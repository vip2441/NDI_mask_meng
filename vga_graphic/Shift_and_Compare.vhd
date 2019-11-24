----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:39:58 11/23/2019 
-- Design Name: 
-- Module Name:    Shift_and_Compare - Behavioral 
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

entity Shift_and_Compare is
    Port ( clk,rst,en,data_in : in  STD_LOGIC;
           sync_found : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end Shift_and_Compare;

architecture Behavioral of Shift_and_Compare is

--pattern loga
constant logo_sync_pattern: std_logic_vector(31 downto 0) := X"0f1f2f1f";

signal shift_reg: std_logic_vector(31 downto 0) := (others => '0');

begin
	
process(clk,rst,en)
begin
	if(rst = '1') then
		shift_reg <= (others => '0');
	elsif(rising_edge(clk))then
		if(en = '1') then
			
		end if;	
	end if;
	
end process;


end Behavioral;

