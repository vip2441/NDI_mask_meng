----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:33:28 10/31/2019 
-- Design Name: 
-- Module Name:    levels_rom - Behavioral 
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

entity levels_rom is
    Port ( clock: in  STD_LOGIC;
           address_x : in  STD_LOGIC_VECTOR (5 downto 0);
           data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end levels_rom;

architecture Behavioral of levels_rom is

type ROM_type is array(0 to 63) of std_logic_vector(2 downto 0);
constant rom : ROM_type := (
--LEVEL VZOR
"101", "101", "101", "101", "000", "000", "000",
"101", "101", "101", "101", "000", "101", "000",
"000", "111", "000", "000", "000", "000", "000",
"000", "000", "000", "000", "000", "000", "000",
"101", "101", "000", "101", "000", "000", "000",
"000", "000", "011", "101", "101", "101", "000",
others => (others => '0'));

begin

memory_read:process(clock)
	begin
		if(rising_edge(clock)) then
			data_out <= rom(to_integer(unsigned(address_x)));
		end if;
	end process;

end Behavioral;

