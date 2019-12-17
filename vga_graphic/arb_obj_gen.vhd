----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:25 12/17/2019 
-- Design Name: 
-- Module Name:    arb_obj_gen - Behavioral 
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

entity arb_obj_gen is
    Port ( pix_x,pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			  clk: in std_logic;
           color : out  STD_LOGIC_VECTOR (2 downto 0);
           en : out  STD_LOGIC);
end arb_obj_gen;

architecture Behavioral of arb_obj_gen is
	signal cx,cy: natural range 0 to 1200;
begin

	cx <= to_integer(unsigned(pix_x));
	cy <= to_integer(unsigned(pix_y));

	process(clk)
	begin
		if(rising_edge(clk)) then
			en <= '1';
			if((cx = 0) or (cx = 798) or (cy = 0) or (cy = 599))then
				color <= "111";
				
			elsif(((cx >= 1) and (cx <= 4) and (cy >= 0) and (cy <= 599)) or (cx = 195 and (cy >= 0) and (cy < 500))) then
				color <= "000";	

			else
				en <= '0';
				color <= "000";
			end if;
			
		end if;
	end process;

end Behavioral;

