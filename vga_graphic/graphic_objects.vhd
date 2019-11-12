----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:50:02 11/11/2019 
-- Design Name: 
-- Module Name:    graphic_objects - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity graphic_objects is
	Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
           enable, clk, wall_en, stone_en, floor_en, player_en, food_en : in  STD_LOGIC;
           color : out  STD_LOGIC_VECTOR (2 downto 0));
end graphic_objects;

architecture Behavioral of graphic_objects is



begin



end Behavioral;

