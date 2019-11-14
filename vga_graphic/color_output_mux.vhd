----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:27:09 11/01/2019 
-- Design Name: 
-- Module Name:    color_output_mux - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity color_output_mux is
    Port ( graphic_object : in  STD_LOGIC_VECTOR (2 downto 0);
           graphic_object_sel : in  STD_LOGIC;
			  R,G,B: out std_logic);
end color_output_mux;

architecture Behavioral of color_output_mux is

signal color_out : std_logic_vector(2 downto 0);

begin

color_out <= graphic_object when (graphic_object_sel = '1') else
				"000";
				
R <= color_out(2);
G <= color_out(1);
B <= color_out(0);

end Behavioral;

