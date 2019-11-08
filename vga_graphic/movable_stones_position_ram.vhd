----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:38:59 11/08/2019 
-- Design Name: 
-- Module Name:    movable_stones_position_ram - Behavioral 
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

entity movable_stones_position_ram is
	 Port ( clock: in  STD_LOGIC;
           address_x : in  STD_LOGIC_VECTOR (1 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end movable_stones_position_ram;

architecture Behavioral of movable_stones_position_ram is

type ROM_type is array(0 to 3) of std_logic_vector(7 downto 0);
constant rom : ROM_type := (

"00101011", "11001011",

others => (others => '0'));

begin

memory_read:process(clock)
	begin
		if(rising_edge(clock)) then
			data_out <= rom(to_integer(unsigned(address_x)));
		end if;
	end process;


end Behavioral;

