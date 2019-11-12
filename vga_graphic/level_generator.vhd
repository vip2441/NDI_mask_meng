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
			  pixx_offs, pixy_offs, inside_pixx_offs, inside_pixy_offs : out std_logic_vector(10 downto 0);
			  mem_add: out std_logic_vector(5 downto 0);
			  mem_data: in std_logic_vector(2 downto 0);
           clock: in  STD_LOGIC;
			  border_draw_en : out  STD_LOGIC;
			  selected_object: out std_logic_vector(2 downto 0);
			  --experimentalni signaly
			  move, reset : in  STD_LOGIC;
			  ack: out std_logic
			  );
end level_generator;

architecture Behavioral of level_generator is

--component frequency_divider is
--		generic(modulo : natural := 14);		--deli cislem 2^(modulo + 1)
--    Port ( clk_in : in  STD_LOGIC;
--           clk_out_div : out  STD_LOGIC := '0');
--end component;
--
--signal divided_clock: std_logic := '0';

--signal game_on: std_logic;

--citace pixelu v radcich a sloupcich
signal cntx, cnty, 					--citace cele obrazovky
		cntxoffs, cntyoffs, 					--citace hranic hraci plochy
		inside_area_count_x, inside_area_count_y: natural range 0 to 1200 := 0;				--citace vnitrni oblasti hraci plochy
--signal count_obj_x, count_obj_y: natural range 0 to 500 := 0;

	
--experimentalni signaly pro pohyb	
constant start_pos: std_logic_vector(7 downto 0) := "00101011"; 
constant end_pos: std_logic_vector(7 downto 0) := "11001011";

--signaly pro pohyb, vykresleni objektu v dane vzdalenosti
signal mov_offs_x, mov_offs_y: natural range 0 to 800 := 0;		--offset hybaneho objektu

--rozmery hraci plochy		
constant dimm_x: natural range 0 to 800 := 512;				
constant dimm_y: natural range 0 to 600 := 448;


constant area_offset_x : natural range 0 to 200 := 120;				--posouva oblast vykreslovani hraci plochy
constant area_offset_y : natural range 0 to 200 := 0;

--prochazeni v pameti
signal row, column: natural range 0 to 35:= 0;

--stavovy automat pohybu
type state_type is(LOAD,CHOOSE_MOVE, MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT, MOVE_DONE);
signal present_state, next_state: state_type;
signal performing_move, ack_internal: std_logic := '0';

begin

--	divider: frequency_divider
--		port map(
--			clk_in => clock,
--			clk_out_div => divided_clock
--		);
	
	--pocitadla radku a sloupcu cele obrazovky
	cntx <= to_integer(unsigned(pix_x));
	cnty <= to_integer(unsigned(pix_y));
	
	--pocitadla radku a sloupcu hraciho pole pro celou arenu
	cntxoffs <= (cntx - area_offset_x) when cntx >= area_offset_x and cntx < 576 + area_offset_x else 1200;
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
	
--	arena_draw_fsm:process(present_state)
--	begin
--		if (present_state = DRAWING_BORDERS) then				--kresli hranice
--			border_draw_en <= '1';
--			mem_add <= (others => '1');
--			selected_object <= "101";
--			
--		elsif(present_state = DRAWING_ARENA) then				--kresli arenu, kdyz neprobiha pohyb
--			border_draw_en <= '0';
--			mem_add <= std_logic_vector(to_unsigned(row + column,6));
--			selected_object <= mem_data;
--			
--		elsif(present_state = FLOOR_INSTEAD) then
--			border_draw_en <= '0';
--			mem_add <= std_logic_vector(to_unsigned(row + column,6));				--pravdepodobne nepotrebne
--			selected_object <= "000";			
--		end if;		
--	end process;
	
	read_from_memory:process(clock)
	begin
		if(rising_edge(clock)) then
			if((cntxoffs < 64 + dimm_x and cntyoffs < 64) or		--kresleni vnejsich sten
										(cntxoffs < 64 and (cntyoffs >= 64 and cntyoffs < dimm_y)) or
										((cntxoffs >=dimm_x and cntxoffs < 64 + dimm_x) and (cntyoffs >= 64 and cntyoffs < dimm_y)) or
										(cntxoffs < 64 + dimm_x and (cntyoffs >= dimm_y and cntyoffs < 64 + dimm_y))) then
				border_draw_en <= '1';
				mem_add <= (others => '1');
				selected_object <= "101";
				
			elsif((inside_area_count_x < 448) and (inside_area_count_y < 384)) then      --kresleni vnitrni oblasti
				if(performing_move = '1') then			--pohyb se vykonava
					if((inside_area_count_x >= to_integer(unsigned(start_pos(7 downto 5)))*64) and (inside_area_count_x < 64 + to_integer(unsigned(start_pos(7 downto 5)))*64) 
								and(inside_area_count_y >= to_integer(unsigned(start_pos(4 downto 2)))*64) and (inside_area_count_y < 64 + to_integer(unsigned(start_pos(4 downto 2)))*64) )then					--kdyz se nachazi na pocatecni pozici objektu
						border_draw_en <= '0';
						mem_add <= std_logic_vector(to_unsigned(row + column,6));				--pravdepodobne nepotrebne
						selected_object <= "000";
						
					elsif((inside_area_count_x >= mov_offs_x) and (inside_area_count_x < 64 + mov_offs_x) 
							and (inside_area_count_y >= mov_offs_y) and (inside_area_count_y < 64 + mov_offs_y)) then				--kdyz se nachazi na soucasne pozici objektu
						if(start_pos(1 downto 0) = "11") then  --posouvany objekt je hrac
							border_draw_en <= '0';
							mem_add <= (others => '1');
							selected_object <= "111";
						else					--posouvany objekt je kamen, koncova hodnota 10,01 nebo 00
							border_draw_en <= '0';
							mem_add <= (others => '1');
							selected_object <= "110";
						end if;
					else						--kdyz se nachazi vsude jinde
						border_draw_en <= '0';
						mem_add <= std_logic_vector(to_unsigned(row + column,6));
						selected_object <= mem_data;							
					end if;					
				else					--pohyb se nevykonava
					border_draw_en <= '0';
					mem_add <= std_logic_vector(to_unsigned(row + column,6));
					selected_object <= mem_data;
				end if;				
			else						--nekreslit nic
				border_draw_en <= '0';
				mem_add <= (others => '1');
				selected_object <= "100";			--objekt niceho
			end if;
		end if;		
	end process;
	
	
	GRAND_FSM:process(clock)
	begin
		if(reset = '1') then
			next_state <= LOAD;
			ack <= '0';
		elsif(rising_edge(clock)) then
			case next_state is				
				when LOAD =>	
					ack_internal <= '0';
					performing_move <= '0';
					mov_offs_x <= 0;
					mov_offs_y <= 0;
					
					if(move = '1') then 
						next_state <= CHOOSE_MOVE;
					else 
						next_state <= LOAD;
					end if;
				
				when CHOOSE_MOVE =>	
					ack_internal <= '0';
					performing_move <= '0';
					mov_offs_x <= to_integer(unsigned(start_pos(7 downto 5)))*64; 	 --pocatecni offsety
					mov_offs_y <= to_integer(unsigned(start_pos(4 downto 2)))*64;
				
					if((start_pos(7 downto 5) xnor end_pos(7 downto 5)) = "111") then			--pokud se x-ove souradnice rovnaji, probiha VERTIKALNI pohyb
						if((signed(end_pos(4 downto 2)) - signed(start_pos(4 downto 2))) > 0) then		--probiha pohyb DOLU
							next_state <= MOVE_DOWN;
						else 
							next_state <= MOVE_UP;
						end if;
					else								--v tomto pripade se x-ove souradnice nerovnaji, takze probiha HORIZONTALNI pohyb
						if((signed(end_pos(7 downto 5)) - signed(start_pos(7 downto 5))) > 0) then		--probiha pohyb DOPRAVA
							next_state <= MOVE_RIGHT;
						else				--probiha pohyb DOLEVA
							next_state <= MOVE_LEFT;
						end if;
					end if;
				
				when MOVE_DOWN =>
					ack_internal <= '0';
					performing_move <= '1';
					mov_offs_x <= to_integer(unsigned(start_pos(7 downto 5)))*64;
					mov_offs_y <= mov_offs_y + 1;
				
					if(mov_offs_y = to_integer(unsigned(end_pos(4 downto 2)))*64)	then 
						next_state <= MOVE_DONE;
					else 
						next_state <= MOVE_DOWN;
					end if;
				
				when MOVE_UP =>
					ack_internal <= '0';
					performing_move <= '1';
					mov_offs_x <= to_integer(unsigned(start_pos(7 downto 5)))*64;
					mov_offs_y <= mov_offs_y - 1;
					
					if(mov_offs_y = to_integer(unsigned(end_pos(4 downto 2)))*64)	then 
						next_state <= MOVE_DONE;
					else 
						next_state <= MOVE_UP;
					end if;
				
				when MOVE_LEFT =>	
					ack_internal <= '0';
					performing_move <= '1';
					mov_offs_x <= mov_offs_x + 1;
					mov_offs_y <= to_integer(unsigned(start_pos(4 downto 2)))*64;
						
					if(mov_offs_x = to_integer(unsigned(end_pos(7 downto 5)))*64)	then 
						next_state <= MOVE_DONE;
					else 
						next_state <= MOVE_LEFT;
					end if;
				
				when MOVE_RIGHT =>	
					ack_internal <= '0';
					performing_move <= '1';
					mov_offs_x <= mov_offs_x - 1;
					mov_offs_y <= to_integer(unsigned(start_pos(4 downto 2)))*64;
					
					if(mov_offs_x = to_integer(unsigned(end_pos(7 downto 5)))*64)	then
						next_state <= MOVE_DONE;
					else 
						next_state <= MOVE_RIGHT;
					end if;
				
				when MOVE_DONE =>	
					ack_internal <= '1';
					performing_move <= '1';
					mov_offs_x <= to_integer(unsigned(end_pos(7 downto 5)))*64;
					mov_offs_y <= to_integer(unsigned(end_pos(4 downto 2)))*64;
			
					if(move = '0') then 
						next_state <= LOAD;
					else 
						next_state <= MOVE_DONE;
					end if;
				
				when others => 
					ack_internal <= '0';
					performing_move <= '0';
					mov_offs_x<= 0;
					mov_offs_y <= 0;
					next_state <= LOAD;				
			end case;
		end if;
	end process;

--stavovy automat ovladajici pohyb
--	
--	SYNC_PROC:process(clock, next_state, reset)
--	begin
--		if(rising_edge(clock)) then
--			if(reset = '1') then
--				present_state <= LOAD;
--				ack <= '0';
--			else
--				present_state <= next_state;
--				ack <= ack_internal;
--				mov_offs_x <= 	count_obj_x;
--				mov_offs_y <= count_obj_y;
--			end if;
--		end if;
--	end process;
--	
--	
--	
--	OUTPUT_DECODE: process(present_state, mov_offs_x, mov_offs_y)
--   begin
--      if (present_state = LOAD) then
--         ack_internal <= '0';
--			performing_move <= '0';
--			count_obj_x <= 0;
--			count_obj_y <= 0;
--			
--		elsif (present_state = CHOOSE_MOVE) then
--			ack_internal <= '0';
--			performing_move <= '0';
--			count_obj_x <= to_integer(unsigned(start_pos(7 downto 5)))*64; 	 --pocatecni offsety
--			count_obj_y <= to_integer(unsigned(start_pos(4 downto 2)))*64;
--			
--		elsif (present_state = MOVE_DOWN) then
--			ack_internal <= '0';
--			performing_move <= '1';
--			count_obj_x <= to_integer(unsigned(start_pos(7 downto 5)))*64;
--			count_obj_y <= mov_offs_y + 1;
--			
--		elsif (present_state = MOVE_UP) then
--			ack_internal <= '0';
--			performing_move <= '1';
--			count_obj_x <= to_integer(unsigned(start_pos(7 downto 5)))*64;
--			count_obj_y <= mov_offs_y - 1;
--			
--		elsif (present_state = MOVE_LEFT) then
--			ack_internal <= '0';
--			performing_move <= '1';
--			count_obj_x <= mov_offs_x + 1;
--			count_obj_y <= to_integer(unsigned(start_pos(4 downto 2)))*64;
--			
--		elsif (present_state = MOVE_RIGHT) then
--			ack_internal <= '0';
--			performing_move <= '1';
--			count_obj_x <= mov_offs_x - 1;
--			count_obj_y <= to_integer(unsigned(start_pos(4 downto 2)))*64;
--			
--		elsif (present_state = MOVE_DONE) then
--			ack_internal <= '1';
--			performing_move <= '1';
--			count_obj_x <= to_integer(unsigned(end_pos(7 downto 5)))*64;
--			count_obj_y <= to_integer(unsigned(end_pos(4 downto 2)))*64;
--		else
--			ack_internal <= '0';
--			performing_move <= '0';
--			count_obj_x<= 0;
--			count_obj_y <= 0;
--      end if;
--   end process;
--	
--	NEXT_STATE_DECODE: process(present_state,move, mov_offs_x, mov_offs_y)			--meni offset vykreslovaneho objektu
--	begin
--	
--		next_state <= present_state;
--		
--		case present_state is
--			when LOAD =>			
--				if(move = '1') then 
--					next_state <= CHOOSE_MOVE;
--				else 
--					next_state <= LOAD;
--				end if;
--				
--			when CHOOSE_MOVE =>				
--				if((start_pos(7 downto 5) xnor end_pos(7 downto 5)) = "111") then			--pokud se x-ove souradnice rovnaji, probiha VERTIKALNI pohyb
--					if((signed(end_pos(4 downto 2)) - signed(start_pos(4 downto 2))) > 0) then		--probiha pohyb DOLU
--						next_state <= MOVE_DOWN;
--					else 
--						next_state <= MOVE_UP;
--					end if;
--				else								--v tomto pripade se x-ove souradnice nerovnaji, takze probiha HORIZONTALNI pohyb
--					if((signed(end_pos(7 downto 5)) - signed(start_pos(7 downto 5))) > 0) then		--probiha pohyb DOPRAVA
--						next_state <= MOVE_RIGHT;
--					else				--probiha pohyb DOLEVA
--						next_state <= MOVE_LEFT;
--					end if;
--				end if;
--				
--			when MOVE_DOWN =>
--				if(mov_offs_y = to_integer(unsigned(end_pos(4 downto 2)))*64)	then 
--					next_state <= MOVE_DONE;
--				else 
--					next_state <= MOVE_DOWN;
--				end if;
--				
--			when MOVE_UP =>
--				if(mov_offs_y = to_integer(unsigned(end_pos(4 downto 2)))*64)	then 
--					next_state <= MOVE_DONE;
--				else 
--					next_state <= MOVE_UP;
--				end if;
--				
--			when MOVE_LEFT =>				
--				if(mov_offs_x = to_integer(unsigned(end_pos(7 downto 5)))*64)	then 
--					next_state <= MOVE_DONE;
--				else 
--					next_state <= MOVE_LEFT;
--				end if;
--				
--			when MOVE_RIGHT =>				
--				if(mov_offs_x = to_integer(unsigned(end_pos(7 downto 5)))*64)	then
--					next_state <= MOVE_DONE;
--				else 
--					next_state <= MOVE_RIGHT;
--				end if;
--				
--    		when MOVE_DONE =>				
--				if(move = '0') then 
--					next_state <= LOAD;
--				else 
--					next_state <= MOVE_DONE;
--				end if;
--				
--			when others => 
--				next_state <= LOAD;
--				
--		end case;
--	end process;
---konec stavoveho automatu ovladajiciho pohyb
	
	--citace pixelu pro celou arenu
	pixx_offs <= std_logic_vector(to_unsigned(cntxoffs,11));
	pixy_offs <= std_logic_vector(to_unsigned(cntyoffs,11));
	
	--citace pixelu vnitrni oblasti
	inside_pixx_offs <= std_logic_vector(to_unsigned(inside_area_count_x,11));
	inside_pixy_offs <= std_logic_vector(to_unsigned(inside_area_count_y,11));

end Behavioral;

