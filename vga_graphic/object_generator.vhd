----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:28:49 11/11/2019 
-- Design Name: 
-- Module Name:    object_generator - Behavioral 
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

entity object_generator is
    Port ( clk: std_logic;
				sel: in std_logic_vector(2 downto 0);
           pixx, pixy : in  STD_LOGIC_VECTOR (10 downto 0);
           offset_x, offset_y : in  STD_LOGIC_VECTOR (8 downto 0);
           color : out  STD_LOGIC_vector(2 downto 0));
end object_generator;

architecture Behavioral of object_generator is

signal cntx, cnty: natural range 0 to 1200 := 0;
signal offsx, offsy : natural range 0 to 500 := 0;

signal color: std_logic_vector(2 downto 0) := "000";

begin

	cntx <= to_integer(unsigned(pixx));
	cnty <= to_integer(unsigned(pixy));
	offsx <= to_integer(unsigned(offset_x));
	offsy <= to_integer(unsigned(offset_y));
	
	
	process(clk,cntx, cnty, sel)
	begin
		if(rising_edge(clk)) then
			if(sel = "101") then
				color <= rom(((cntx - offsx) mod 64)*64 + ((cnty - offsy) mod 64));
			elsif(sel = "000") then
				color <= rom(4096 + ((cntx - offsx) mod 64)*64 + ((cnty - offsy) mod 64));
			elsif(sel = "110") then
				color <= rom(8192 + ((cntx - offsx) mod 64)*64 + ((cnty - offsy) mod 64));
			elsif(sel = "111") then
				color <= rom(12288 + ((cntx - offsx) mod 64)*64 + ((cnty - offsy) mod 64));
			elsif(sel = "011") then
				color <= rom(16384 + ((cntx - offsx) mod 64)*64 + ((cnty - offsy) mod 64));
			else
				color <= "000";
			end if;
		end if;
	end process;

--floor_object_generator: floor_object
--		port map(
--			pix_x => inside_pix_x,
--			pix_y => inside_pix_y,
--         enable => gen_floor_en,
--			clk => clk,
--         color => floor_pic
--		);
--			
--wall_object_generator: wall_object
--		port map(
--			pix_x => pixx_selected,
--			pix_y => pixy_selected,
--         enable => gen_wall_en,
--			clk => clk,
--         color => wall_pic
--		);
--		
--stone_object_generator: stone_obj
--		port map(
--			pix_x => inside_pix_x,
--			pix_y => inside_pix_y,
--         enable => gen_stone_en,
--			clk => clk,
--         color => stone_pic
--		);		
--		
--player_object_generator: player_obj
--		port map(
--			pix_x => inside_pix_x,
--			pix_y => inside_pix_y,
--         enable => gen_player_en,
--			clk => clk,
--         color => player_pic
--		);		
--		
--food_object_generator: food_obj
--		port map(
--			pix_x => inside_pix_x,
--			pix_y => inside_pix_y,
--         enable => gen_food_en,
--			clk => clk,
--         color => food_pic
--		);		
--						
--col_out_mux: color_output_mux
--		port map(
--			floor_obj => floor_pic, 
--			wall_obj => wall_pic, 
--			player_obj => player_pic, 
--			stone_obj => stone_pic, 
--			food_obj => food_pic,
--         floor_sel => gen_floor_en, 
--			wall_sel => gen_wall_en, 
--			player_sel => gen_player_en,
--			stone_sel => gen_stone_en,
--			food_sel => gen_food_en,
--			R => red,
--			G => green,
--			B => blue);

end Behavioral;

