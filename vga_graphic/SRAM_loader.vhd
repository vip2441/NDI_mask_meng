----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:55 11/25/2019 
-- Design Name: 
-- Module Name:    SRAM_loader - Behavioral 
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

entity SRAM_loader is
    Port ( rst, data_ready, sync, clk : in  STD_LOGIC;
           read, next_sync, nWE, load_complete : out  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           addr : out  STD_LOGIC_VECTOR (17 downto 0));
end SRAM_loader;

architecture Behavioral of SRAM_loader is

	type state is (INIT, SCAN, LOAD,DONE);
	signal current_state: state;
	
	signal count: natural range 0 to 49141 := 0;
	
begin

	process(rst, clk)
	begin
		if(rst = '1') then
		
			current_state <= INIT;
			data_out <= (others => '0');
			addr <= (others => '0');
			read <= '0';
			next_sync <= '0';
			nWE <= '1';				--nastavena pro cteni
			load_complete <= '0';
			
		elsif(rising_edge(clk))then
			case current_state is
				when INIT =>
					load_complete <= '0';
					
					if(sync = '1') then		--obvod ctouci PROM nalezl synchronizacni pattern
						current_state <= SCAN;
						read <= '1';
						nWE <= '0';				--chci zapisovat
						next_sync <= '0';
					end if;
					
				when SCAN =>
					load_complete <= '0';
					
					if(data_ready = '1') then
						current_state <= LOAD;						
					end if;	
					
				when LOAD =>
					load_complete <= '0';
					count <= count + 1;				--zvysi se pouze, pokud byla pripravena nova data
					
					data_out <= data_in & "00000000";
					addr <= std_logic_vector(to_unsigned(count, 18));
					
					if(count = 42141) then
						current_state <= DONE;
						nWE <= '1';
					else
						current_state <= SCAN;
					end if;
					
				when DONE => 
					load_complete <= '1';
					
					
				when others =>
					current_state <= INIT;
					data_out <= (others => '0');
					addr <= (others => '0');
					read <= '0';
					next_sync <= '0';
					nWE <= '1';				--nastavena pro cteni
					load_complete <= '0';
			end case;	
		end if;		
	end process;

	


end Behavioral;

