----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:23 11/04/2019 
-- Design Name: 
-- Module Name:    object_decoder - Behavioral 
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

entity object_decoder is
    Port ( object : in  STD_LOGIC_VECTOR (2 downto 0);
           wall_obj, stone_obj, floor_obj, player_obj, food_obj : out  STD_LOGIC);
end object_decoder;

architecture Behavioral of object_decoder is

begin

process(object)
begin
	if(object = "101")then
		wall_obj <= '1';
		stone_obj <= '0';
		floor_obj <= '0';
		player_obj <= '0';
		food_obj <= '0';
	elsif(object = "110") then
		wall_obj <= '0';
		stone_obj <= '1';
		floor_obj <= '0';
		player_obj <= '0';
		food_obj <= '0';
	elsif(object = "000") then
		wall_obj <= '0';
		stone_obj <= '0';
		floor_obj <= '1';
		player_obj <= '0';
		food_obj <= '0';
	elsif(object = "111") then
		wall_obj <= '0';
		stone_obj <= '0';
		floor_obj <= '0';
		player_obj <= '1';
		food_obj <= '0';
	elsif(object = "011")then
		wall_obj <= '0';
		stone_obj <= '0';
		floor_obj <= '0';
		player_obj <= '0';
		food_obj <= '1';
	else
		wall_obj <= '0';
		stone_obj <= '0';
		floor_obj <= '0';
		player_obj <= '0';
		food_obj <= '0';
	end if;
end process;

end Behavioral;

