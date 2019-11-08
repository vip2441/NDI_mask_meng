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
           clock : in  STD_LOGIC;
			  border_draw_en : out  STD_LOGIC;
			  selected_object: out std_logic_vector(2 downto 0)
			  );
end level_generator;

architecture Behavioral of level_generator is

component frequency_divider is
		generic(modulo : natural := 17);		--deli cislem 2^(modulo + 1)
    Port ( clk_in : in  STD_LOGIC;
           clk_out_div : out  STD_LOGIC := '0');
end component;

signal divided_clock: std_logic := '0';

--signal game_on: std_logic;

--citace pixelu v radcich a sloupcich
signal cntx, cnty, 					--citace cele obrazovky
		cntxoffs, cntyoffs, 					--citace hranic hraci plochy
		inside_area_count_x, inside_area_count_y: natural range 0 to 1200 := 0;				--citace vnitrni oblasti hraci plochy
	
--experimentalni signaly pro pohyb	
constant start_pos: std_logic_vector(7 downto 0) := "00101011"; 
constant end_pos: std_logic_vector(7 downto 0) := "11001011";

signal move: std_logic := '1';		--informace o tom, zda ma probihat pohyb
signal ack: std_logic := '0';			--informace o vykonani pohybu
signal mov_offs_x, mov_offs_y: natural range 0 to 800 := 0;		--offset hybaneho objektu

--rozmery hraci plochy		
constant dimm_x: natural range 0 to 800 := 512;				
constant dimm_y: natural range 0 to 600 := 448;


constant area_offset_x : natural range 0 to 200 := 120;				--posouva oblast vykreslovani hraci plochy
constant area_offset_y : natural range 0 to 200 := 0;

--prochazeni v pameti
signal row, column: natural range 0 to 35:= 0;

begin

	divider: frequency_divider
		port map(
			clk_in => clock,
			clk_out_div => divided_clock
		);
	
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
	
	read_from_memory:process(clock, inside_area_count_x, inside_area_count_y,cntxoffs,cntyoffs)			--cte z pameti a voli objekt v externim dekoderu
	begin
		if(rising_edge(clock)) then
				--kresleni vnejsich sten
			if((cntxoffs < 64 + dimm_x and cntyoffs < 64) or
										(cntxoffs < 64 and (cntyoffs >= 64 and cntyoffs < dimm_y)) or
										((cntxoffs >=dimm_x and cntxoffs < 64 + dimm_x) and (cntyoffs >= 64 and cntyoffs < dimm_y)) or
										(cntxoffs < 64 + dimm_x and (cntyoffs >= dimm_y and cntyoffs < 64 + dimm_y))) then
				border_draw_en <= '1';
				mem_add <= (others => '1');
				selected_object <= "101";
				
				--kresleni vnitrni oblasti
			elsif((inside_area_count_x < 448) and (inside_area_count_y < 384)) then
				--selected_object <= level_reg(row + column);
				border_draw_en <= '0';
				mem_add <= std_logic_vector(to_unsigned(row + column,6));
				selected_object <= mem_data;
				
				--nekreslit nic
			else
				border_draw_en <= '0';
				mem_add <= (others => '1');
				selected_object <= "100";
			end if;
		end if;
	end process;
	
--	constant start_pos: std_logic_vector(7 downto 0) := "00101011"; 11-hrac, 00- sutr
--constant end_pos: std_logic_vector(7 downto 0) := "11001011";
--
--signal move: std_logic := '1';		--informace o tom, zda ma probihat pohyb
--signal ack: std_logic := '0';			--informace o vykonani pohybu
--signal mov_offs_x, mov_offs_y: natural 0 to 800 := 0;		--offset hybaneho objektu
--signal direction: std_logic;			--priznak smeru 1-doprava/nahoru, 0-doleva/dolu
	
	move_object: process(divided_clock, move, inside_area_count_x, inside_area_count_y)			--meni offset vykreslovaneho objektu
	begin
		if(rising_edge(divided_clock)) then
			if(move = '1') then
				if((start_pos(7 downto 5) xnor end_pos(7 downto 5)) = "111") then			--pokud se x-ove souradnice rovnaji, probiha VERTIKALNI pohyb
					if((signed(end_pos(4 downto 2)) - signed(start_pos(4 downto 2))) > 0) then		--probiha pohyb DOLU
						mov_offs_y <= mov_offs_y + 1;
					else					--probiha pohyb NAHORU
						mov_offs_y <= mov_offs_y - 1;
					end if;
					
				else					--v tomto pripade se x-ove souradnice nerovnaji, takze probiha HORIZONTALNI pohyb
					if((signed(end_pos(7 downto 5)) - signed(start_pos(7 downto 5))) > 0) then		--probiha pohyb DOPRAVA
						mov_offs_x <= mov_offs_x + 1;
					else				--probiha pohyb DOLEVA
						mov_offs_x <= mov_offs_x - 1;
					end if;
				end if;
			end if;		
		end if;		
	end process;
	
	--citace pixelu pro celou arenu
	pixx_offs <= std_logic_vector(to_unsigned(cntxoffs,11));
	pixy_offs <= std_logic_vector(to_unsigned(cntyoffs,11));
	
	--citace pixelu vnitrni oblasti
	inside_pixx_offs <= std_logic_vector(to_unsigned(inside_area_count_x,11));
	inside_pixy_offs <= std_logic_vector(to_unsigned(inside_area_count_y,11));


end Behavioral;

