----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:16:35 11/05/2019 
-- Design Name: 
-- Module Name:    custom_counter - Behavioral 
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

entity custom_counter is
		generic(modulo : integer := 41;
					vector_length : integer := 6);
    Port ( clk,ce,clr : in  STD_LOGIC;
           ovf : out  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR ((vector_length - 1) downto 0));
end custom_counter;

architecture Behavioral of custom_counter is

begin

process(clk,clr,ce)
	variable count: unsigned ((vector_length - 1) downto 0) := (others => '0');
	begin
		if(clr = '1') then		--asynchronni reset
				count := (others => '0');
				ovf <= '0';
		elsif(rising_edge(clk) and ce = '1') then			 
			if(count = (modulo - 1) or count = (count'range => '1')) then
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

