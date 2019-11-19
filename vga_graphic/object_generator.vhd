----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:28:49 11/11/2019 
-- Design Name: 
-- Module Name:    object_generator - Behavioral 
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

entity object_generator is
    Port ( clk: std_logic;
				sel: in std_logic_vector(2 downto 0);
           pixx, pixy : in  STD_LOGIC_VECTOR (10 downto 0);
           offset_x, offset_y : in  STD_LOGIC_VECTOR (8 downto 0);
			  white_dots_en, obj_en: out std_logic;
			  
			  --signaly pro pamet
			  mem_read_enable: out std_logic;
			  mem_add_x: out std_logic_vector(11 downto 0);
			  mem_add_y: out std_logic_vector(2 downto 0)
			  
			  );
end object_generator;

architecture Behavioral of object_generator is



signal cntx, cnty: natural range 0 to 1200 := 0;
signal offsx, offsy : natural range 0 to 500 := 0;

begin

	cntx <= to_integer(unsigned(pixx));
	cnty <= to_integer(unsigned(pixy));
	offsx <= to_integer(unsigned(offset_x));
	offsy <= to_integer(unsigned(offset_y));
	
	
	process(clk,cntx, cnty, sel)
	begin
		if(rising_edge(clk)) then
			mem_read_enable <= '1';
			mem_add_x <= std_logic_vector(to_unsigned((((cntx - offsx) mod 64)*64 + ((cnty - offsy) mod 64)), 12));
			white_dots_en <= '0';
			obj_en <= '1';
			
			if(sel = "101") then			--STENA
				mem_add_y <= "000";
			elsif(sel = "000") then		--PODLAHA
				mem_add_y <= "001";
			elsif(sel = "110") then			--KAMEN
				mem_add_y <= "010";
			elsif(sel = "111") then			--HRAC
				mem_add_y <= "011";
			elsif(sel = "011") then			--JIDLO
				mem_add_y <= "100";
			elsif(sel = "001") then				--bile tecky v rozich
				mem_read_enable <= '0';
				mem_add_y <= "000";
				white_dots_en <= '1';
				obj_en <= '0';
			else
				mem_read_enable <= '0';			-- kombinace 100
				mem_add_x <= (others => '0');
				mem_add_y <= (others => '0');
				obj_en <= '0';
			end if;
		end if;
	end process;	

end Behavioral;