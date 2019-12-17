----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:42:56 11/01/2019 
-- Design Name: 
-- Module Name:    level_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity level_generator is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			  pixx_offs, pixy_offs: out std_logic_vector(10 downto 0);
			  mem_add: out std_logic_vector(5 downto 0);
			  mem_data: in std_logic_vector(2 downto 0);
           clock: in  STD_LOGIC;
			  selected_object: out std_logic_vector(2 downto 0);
			  
			  --offsety zvolenych objektu
			  obj_offs_x, obj_offs_y: out std_logic_vector(8 downto 0);
			  --signaly pohybu
			  start_pos, end_pos: in std_logic_vector(7 downto 0);
			  move, reset : in  STD_LOGIC;
			  ack: out std_logic;
			  
			  --signal zacatku hry
			  game_on: in std_logic
			  );
end level_generator;

  architecture Behavioral of level_generator is
  
	component frequency_divider is
		generic(modulo : natural := 15);		--deli cislem 2^(modulo + 1)
		Port (clk_in : in  STD_LOGIC;
           clk_out_div : out  STD_LOGIC := '0');
	end component;

	--citace pixelu v radcich a sloupcich
	signal cntx, cnty, 					--citace cele obrazovky
		cntxoffs, cntyoffs, 					--citace hranic hraci plochy
		inside_area_count_x, inside_area_count_y: natural range 0 to 1200 := 0;				--citace vnitrni oblasti hraci plochy

	--signaly pro pohyb, vykresleni objektu v dane vzdalenosti
	signal mov_offs_x, mov_offs_y: natural range 0 to 385 := 0;		--offset hybaneho objektu
	signal count_x, count_y: natural range 0 to 385 := 0;
	signal position_start_x, position_start_y, position_end_x, position_end_y: natural range 0 to 400 := 0;


	--rozmery hraci plochy		
	constant dimm_x: natural range 0 to 800 := 512;				
	constant dimm_y: natural range 0 to 600 := 448;


	constant area_offset_x : natural range 0 to 200 := 192;				--posouva oblast vykreslovani hraci plochy
	constant area_offset_y : natural range 0 to 200 := 0;

	--prochazeni v pameti
	signal row, column: natural range 0 to 35:= 0;

	--stavovy automat pohybu
	type state_type is(LOAD,CHOOSE_MOVE, MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT, MOVE_DONE);
	signal state: state_type;
	signal performing_move: std_logic := '0';
	
	signal clk_div: std_logic;

begin

	divider: frequency_divider
	port map(
		clk_in => clock,
		clk_out_div => clk_div	
	);
		
	position_start_x <= to_integer(unsigned(start_pos(7 downto 5)))*64;
	position_start_y <= to_integer(unsigned(start_pos(4 downto 2)))*64;
	position_end_x <= to_integer(unsigned(end_pos(7 downto 5)))*64;
	position_end_y <= to_integer(unsigned(end_pos(4 downto 2)))*64;
	
	--pocitadla radku a sloupcu cele obrazovky
	cntx <= to_integer(unsigned(pix_x));
	cnty <= to_integer(unsigned(pix_y));
	
	--pocitadla radku a sloupcu hraciho pole pro celou arenu
	cntxoffs <= (cntx - area_offset_x) when cntx >= area_offset_x and cntx < 576 + area_offset_x + 1 else 1200;
	cntyoffs <= (cnty - area_offset_y) when cnty >= area_offset_y and cnty < 512 + area_offset_y else 1200;
	
	--pocitadlo vnitrni hraci plochy
	inside_area_count_x <= (cntx - area_offset_x - 64) when ((cntx >= 64 + area_offset_x) and (cntx < 448 + 64 + area_offset_x)) else 1200;
	inside_area_count_y <= (cnty - area_offset_y - 64) when ((cnty >= 64 + area_offset_y) and (cnty < 384 + 64 + area_offset_y)) else 1200;
		
	observe_rows:process(inside_area_count_y)			--prochazeni radku v pameti
	begin
			if(inside_area_count_y >= 0 and inside_area_count_y < 64) then
				row <= 0;
			elsif(inside_area_count_y >= 64 and inside_area_count_y < 128) then
				row <= 7;
			elsif(inside_area_count_y >= 128 and inside_area_count_y < 192) then
				row <= 14;
			elsif(inside_area_count_y >= 192 and inside_area_count_y < 256) then
				row <= 21;
			elsif(inside_area_count_y >= 256 and inside_area_count_y < 320) then
				row <= 28;
			else
				row <= 35;
			end if;
	end process;
	
	observe_columns:process(inside_area_count_x)			--prochazeni slupcu v pameti
	begin
			if(inside_area_count_x >= 0 and inside_area_count_x < 64) then
				column <= 0;
			elsif(inside_area_count_x >= 64 and inside_area_count_x < 128) then
				column <= 1;
			elsif(inside_area_count_x >= 128 and inside_area_count_x < 192) then
				column <= 2;
			elsif(inside_area_count_x >= 192 and inside_area_count_x < 256) then
				column <= 3;
			elsif(inside_area_count_x >= 256 and inside_area_count_x < 320) then
				column <= 4;
			elsif(inside_area_count_x >= 320 and inside_area_count_x < 384) then
				column <= 5;
			else
				column <= 6;
			end if;
	end process;
	
	read_from_memory:process(clock)
	begin		
		if(rising_edge(clock)) then
			obj_offs_x <= (others => '0');
			obj_offs_y <= (others => '0');
				
			if((cntxoffs < 65 + dimm_x and cntyoffs < 64) or		--kresleni hornich sten
										(cntxoffs < 64 and (cntyoffs >= 64 and cntyoffs < dimm_y)) or		--kresleni leve steny
										((cntxoffs >=dimm_x and cntxoffs < 65 + dimm_x) and (cntyoffs >= 64 and cntyoffs < dimm_y)) or			--kresleni prvae steny
										(cntxoffs < 65 + dimm_x and (cntyoffs >= dimm_y and cntyoffs < 64 + dimm_y))) then					--kresleni spodni steny
				mem_add <= (others => '1');
				selected_object <= "101";
				
			elsif((inside_area_count_x < 448) and (inside_area_count_y < 384)) then      --kresleni vnitrni oblasti
				if(performing_move = '1' and game_on = '1') then			--pohyb se vykonava
					if((inside_area_count_x >= mov_offs_x) and (inside_area_count_x < 64 + mov_offs_x) 
					and (inside_area_count_y >= mov_offs_y) and (inside_area_count_y < 64 + mov_offs_y)) then				--kdyz se nachazi na soucasne pozici objektu
							
						obj_offs_x <= std_logic_vector(to_unsigned(mov_offs_x, 9));
						obj_offs_y <= std_logic_vector(to_unsigned(mov_offs_y, 9));
							
						if(start_pos(0) = '1' or end_pos(0) = '1') then  --posouvany objekt je hrac
							mem_add <= (others => '1');
							selected_object <= "111";
						else					--posouvany objekt je kamen, koncova hodnota 10,01 nebo 00
							mem_add <= (others => '1');
							selected_object <= "110";
						end if;
						
					elsif((inside_area_count_x >= position_start_x) and (inside_area_count_x < (64 + position_start_x)) 
								and(inside_area_count_y >= (position_start_y)) and (inside_area_count_y < (64 + position_start_y)))then					--kdyz se nachazi na pocatecni pozici objektu
						
						mem_add <= std_logic_vector(to_unsigned(row + column,6));				--pravdepodobne nepotrebne
							
						if(start_pos(1) = '0' or end_pos(1) = '0') then  --posouvany objekt je hrac
							selected_object <= "000";
						else					--posouvany objekt je kamen, koncova hodnota 10,01 nebo 00
							selected_object <= "011";
						end if;							
					else						--kdyz se nachazi vsude jinde
						mem_add <= std_logic_vector(to_unsigned(row + column,6));
						selected_object <= mem_data;							
					end if;
				elsif(game_on = '1' and performing_move = '0') then		--kresli to, co je v pameti
					mem_add <= std_logic_vector(to_unsigned(row + column,6));
					selected_object <= mem_data;
				else					--pohyb se nevykonava a jeste ani nezacala hra
					mem_add <= (others => '1');
					selected_object <= "101";
				end if;				
			else						--nekreslit nic
				mem_add <= (others => '1');
				selected_object <= "100";			--objekt niceho
			end if;
		end if;		
	end process;
	
	process(clock)
	begin
		if(rising_edge(clock)) then
			mov_offs_x <= count_x;
			mov_offs_y <= count_y;
		end if;		
	end process;
	
	
	GRAND_FSM:process(clk_div, reset)
	begin
		if(reset = '1') then
			state <= LOAD;
			ack <= '0';
		elsif(rising_edge(clk_div)) then
			
			case state is				
				when LOAD =>	
					ack <= '0';
					performing_move <= '0';
					count_x <= 0;
					count_y <= 0;
					
					if(move = '1') then 
						state <= CHOOSE_MOVE;
					else 
						state <= LOAD;
					end if;
				
				when CHOOSE_MOVE =>	
					ack <= '0';
					performing_move <= '0';
					count_x <= position_start_x; 	 --pocatecni offsety
					count_y <= position_start_y;
				
					if(position_start_x = position_end_x) then			--pokud se x-ove souradnice rovnaji, probiha VERTIKALNI pohyb
						if((position_end_y - position_start_y) > 0) then		--probiha pohyb DOLU
							state <= MOVE_DOWN;
						else 
							state <= MOVE_UP;
						end if;
					else								--v tomto pripade se x-ove souradnice nerovnaji, takze probiha HORIZONTALNI pohyb
						if((position_end_x - position_start_x) > 0) then		--probiha pohyb DOPRAVA
							state <= MOVE_RIGHT;
						else				--probiha pohyb DOLEVA
							state <= MOVE_LEFT;
						end if;
					end if;
				
				when MOVE_DOWN =>
					ack <= '0';
					performing_move <= '1';
					count_x <= position_start_x;
					count_y <= mov_offs_y + 1;
				
					if(count_y = position_end_y)	then 
						state <= MOVE_DONE;
					elsif(count_y < position_end_y) then
						state <= MOVE_DOWN;
					else 
						state <= LOAD;
					end if;
				
				when MOVE_UP =>
					ack <= '0';
					performing_move <= '1';
					count_x <= position_start_x;
					count_y <= mov_offs_y - 1;
					
					if(count_y = position_end_y)	then 
						state <= MOVE_DONE;
					elsif(count_y > position_end_y) then
						state <= MOVE_UP;
					else 
						state <= LOAD;
					end if;
				
				when MOVE_LEFT =>	
					ack <= '0';
					performing_move <= '1';
					count_x <= mov_offs_x - 1;
					count_y <= position_start_y;
						
					if(count_x = position_end_x)	then 
						state <= MOVE_DONE;
					elsif(count_x > position_end_x) then
						state <= MOVE_LEFT;
					else 
						state <= LOAD;
					end if;
				
				when MOVE_RIGHT =>	
					ack <= '0';
					performing_move <= '1';
					count_x <= mov_offs_x + 1;
					count_y <= position_start_y;
					
					if(count_x = position_end_x)	then
						state <= MOVE_DONE;
					elsif(count_x < position_end_x) then
						state <= MOVE_RIGHT;
					else 
						state <= LOAD;
					end if;
				
				when MOVE_DONE =>	
					ack <= '1';
					performing_move <= '1';
					count_x <= position_end_x;
					count_y <= position_end_y;
			
					if(move = '0') then 
						state <= LOAD;
					else 
						state <= MOVE_DONE;
					end if;
				
				when others => 
					ack <= '0';
					performing_move <= '0';
					count_x <= 0;
					count_y <= 0;
					state <= LOAD;				
			end case;
		end if;
	end process;
	
	--citace pixelu pro celou arenu
	pixx_offs <= std_logic_vector(to_unsigned(cntxoffs,11));
	pixy_offs <= std_logic_vector(to_unsigned(cntyoffs,11));
	
end Behavioral;

