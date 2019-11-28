----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:30:18 11/24/2019 
-- Design Name: 
-- Module Name:    clock_mgmt - Behavioral 
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

entity clock_mgmt is
    Port ( clock, en : in  STD_LOGIC;
           re, cclk : out  STD_LOGIC);
end clock_mgmt;

architecture Behavioral of clock_mgmt is

signal div_clk: std_logic := '0';
signal cclk_int: std_logic := '1';

begin

	clock_divider: process(clock)
	begin
		if(rising_edge(clock)) then
			div_clk <= not div_clk;			
		end if;	
	end process;
	
	generate_enable:process(clock,en,div_clk,cclk_int)
	begin
		if(rising_edge(clock)) then
			if(en = '1') then
				if(div_clk = '1') then
					cclk_int <= not cclk_int;
				end if;
				
				if(div_clk = '1' and cclk_int = '1') then
					re <= '1';
				else
					re <= '0';
				end if;
				
			else
				cclk_int <= '1';
			end if;
			
		end if;
		
		cclk <= cclk_int;
	end process;
		

end Behavioral;

