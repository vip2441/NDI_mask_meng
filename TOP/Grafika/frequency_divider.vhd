----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:31 11/08/2019 
-- Design Name: 
-- Module Name:    frequency_divider - Behavioral 
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

entity frequency_divider is
		generic(modulo : natural := 14);		--deli cislem 2^(modulo + 1)
    Port ( clk_in : in  STD_LOGIC;
           clk_out_div : out  STD_LOGIC := '0');
end frequency_divider;

architecture Behavioral of frequency_divider is

signal count: unsigned (modulo downto 0) := (others => '0');

begin

process(clk_in)

begin
	if(rising_edge(clk_in))then
		count <= count + 1;
	end if;
end process;

clk_out_div <= count(modulo);

end Behavioral;

