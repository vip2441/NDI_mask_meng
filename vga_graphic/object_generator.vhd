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
			  obj_en: out std_logic;
			  color: out std_logic_vector(2 downto 0);
			  
			  --signaly pro pamet
			  mem_data: in std_logic_vector(1 downto 0);
			  mem_read_enable: out std_logic;
			  mem_add_x: out std_logic_vector(11 downto 0);					--zatim jen jeden objekt v pameti
			  mem_add_y : out std_logic_vector(3 downto 0)
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

	color_decoder:process(clk)
	begin
		if(rising_edge(clk)) then
			case(mem_data) is
				when "00" =>
					color <= "000";
				when "10" => 
					if(sel = "111") then				--objekt hrace
						color <= "100";
					else
						color <= "010";
					end if;
				when "01" =>
					color <= "111";
				when "11" =>
					color <= "110";
				when others =>
					color <= "000";		--kresli cernou, kdyz nic
			end case;
		end if;
	end process;
	
	read_memory:process(clk,cntx, cnty, sel)
	begin
		if(rising_edge(clk)) then
			mem_read_enable <= '1';		
			mem_add_x <= std_logic_vector(to_unsigned((((cntx - offsx + 1) mod 64)*64 + ((cnty - offsy) mod 64)),12));
			obj_en <= '1';
			
		if(sel = "101") then			--STENA
			mem_add_y <= "0000";
		elsif(sel = "000") then		--PODLAHA
			mem_add_y <= "0001";
		elsif(sel = "110") then			--KAMEN
			mem_add_y <= "0010";
		elsif(sel = "111") then			--HRAC
			mem_add_y <= "0011";
		elsif(sel = "011") then			--JIDLO
			mem_add_y <= "0100";
		else
			mem_read_enable <= '0';			-- kombinace 100
			mem_add_x <= (others => '1');
			mem_add_y <= (others => '1');
			obj_en <= '0';
		end if;
			
		end if;
	end process;	

end Behavioral;