----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:26:05 11/01/2019 
-- Design Name: 
-- Module Name:    cntr - Behavioral 
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

entity cntr is
	generic(modulo: integer := 1500);
    Port ( 
	 clk, ce, clr : in  STD_LOGIC;
	 ovf: out std_logic;
	 q : out std_logic_vector (10 downto 0));
end cntr;

architecture Behavioral of cntr is
begin

process(clk,clr,ce)
	variable count: unsigned (10 downto 0) := (others => '0');
	begin
		if(clr = '1') then		--asynchronni reset
				count := (others => '0');
				ovf <= '0';
		elsif(rising_edge(clk) and ce = '1') then			 
			if(count = (modulo - 1) or count = "11111111111") then
				count := (others => '0');
				ovf <= '1';
			else
				count := count + 1;
				ovf <= '0';
			end if;
		end if;
		q <= std_logic_vector(count);
end process;


end Behavioral;