----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:46:06 11/24/2019 
-- Design Name: 
-- Module Name:    PROM_reader - Behavioral 
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

entity PROM_reader is
    Port ( clock, rst, read, next_sync, data_in : in  STD_LOGIC;
           cclk, sync, data_ready,rst_prom : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end PROM_reader;

architecture Behavioral of PROM_reader is

	component Shift_and_Compare is
		Port( clk,rst,en,data_in : in  STD_LOGIC;
           sync_found : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component clock_mgmt is
		Port ( clock, en : in  STD_LOGIC;
				re, cclk : out  STD_LOGIC);
	end component;

	type state_type is (Look4Sync, Wait4Active, GetData, PresentData);
	signal current_state: state_type;
	
	signal din_re, mem_clock_en, sync_int, sync_found: std_logic := '0';
	signal data: std_logic_vector(7 downto 0) := (others => '0');
	signal count: natural range 0 to 32 := 0;


begin

	Comparator_serial:Shift_and_Compare
		port map(
			clk => clock,
			rst => rst,
			en => din_re,
			data_in => data_in,
			sync_found => sync_found,
			data_out => data			
		);
		
	Clock_manager: clock_mgmt
		port map(
			clock => clock,
			en => mem_clock_en,
			re => din_re,
			cclk => cclk
		);
		
	process(rst, clock, sync_found)
	begin
		if(rst = '1') then
			current_state <= Look4Sync;
			data_out <= (others => '0');
			data_ready <= '0';
			count <= 0;
			mem_clock_en <= '1';
			rst_prom <= '1';
			sync_int <= '0';
			
		elsif(rising_edge(clock)) then
			case current_state is
				when Look4Sync =>
					count <= 0;
					data_ready <= '0';
					sync_int <= '0';
					rst_prom <= '0';			--resetuji ukazatel v pameti, protoze potrebuji hledat od zacatku
					
					if(sync_found = '1') then
						current_state <= Wait4Active;
						sync_int <= '1';
						mem_clock_en <= '0';
					end if;		
					
				when Wait4Active =>
					count <= 0;
					data_ready <= '0';
					
					if(read = '1' or sync_int = '1') then
						current_state <= GetData;
						mem_clock_en <= '1';
						
					elsif(next_sync = '1') then		--zmenim synchronizacni pattern a poslu tento signal do jednicky
						current_state <= Look4Sync;
						mem_clock_en <= '1';
						
					end if;
					
				when GetData =>
					if(din_re = '1') then
						count <= count + 1;
						
						if(sync_int = '1')then
							if(count = 31) then
								current_state <= PresentData;
								sync_int <= '0';
								mem_clock_en <= '0';							
							end if;
						else
							if(count = 7) then
								current_state <= PresentData;
								sync_int <= '0';
								mem_clock_en <= '0';
							end if;
						end if;						
					end if;
					
				when PresentData =>
					data_out <= data;
					data_ready <= '1';
					current_state <= Wait4Active;
					
				when others =>
					current_state <= Look4Sync;
			end case;
		end if;
		
		sync <= sync_found;
		
	end process;


end Behavioral;

