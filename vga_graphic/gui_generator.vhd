----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:31:32 11/20/2019 
-- Design Name: 
-- Module Name:    gui_generator - Behavioral 
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

entity gui_generator is
Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			 clk : in STD_LOGIC;
			 lvl_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 lvl_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 address_x : out STD_LOGIC_VECTOR (10 downto 0);
			 address_y : out STD_LOGIC_VECTOR (5 downto 0);
			 gui_sel : out STD_LOGIC);
end gui_generator;

architecture Behavioral of gui_generator is

signal cntx, cnty: natural range 0 to 1600 := 0;
signal act_lvl_1, act_lvl_10, act_stp_1, act_stp_10 : natural range 0 to 100 := 0;

begin

cntx <= to_integer(unsigned(pix_x));
cnty <= to_integer(unsigned(pix_y));

act_lvl_1 <= to_integer(unsigned(lvl_jednotky));
act_lvl_10 <= to_integer(unsigned(lvl_desitky));
act_stp_1 <= to_integer(unsigned(stp_jednotky));
act_stp_10 <= to_integer(unsigned(stp_desitky));

process(clk, cntx, cnty)
begin
	if(rising_edge(clk)) then
		--VYKRESLENI TLACITKA ENTER--
		if((cntx >= 128 and cntx <=159) and (cnty >= 384 and cnty <= 447)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000110";
			gui_sel <= '1';
		elsif((cntx >= 160 and cntx <=192) and (cnty >= 384 and cnty <= 447)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000111";
			gui_sel <= '1';
			
		--VYKRESLENI TLACITKA RESET--
		elsif((cntx >= 128 and cntx <=159) and (cnty >= 448 and cnty <= 511)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000100";
			gui_sel <= '1';
		elsif((cntx >= 160 and cntx <=192) and (cnty >= 448 and cnty <= 511)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000101";
			gui_sel <= '1';
			
		--VYKRESLENI LOGA--
		elsif((cntx >= 0 and cntx <=31) and (cnty >= 0 and cnty <= 63)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "010100";
			gui_sel <= '1';
		elsif((cntx >= 32 and cntx <=63) and (cnty >= 0 and cnty <= 63)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "010101";
			gui_sel <= '1';
			
		elsif((cntx >= 0 and cntx <=31) and (cnty >= 64 and cnty <= 127)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "010110";
			gui_sel <= '1';
		elsif((cntx >= 32 and cntx <=63) and (cnty >= 64 and cnty <= 127)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "010111";
			gui_sel <= '1';
			
		elsif((cntx >= 0 and cntx <=31) and (cnty >= 128 and cnty <= 191)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011000";
			gui_sel <= '1';
		elsif((cntx >= 32 and cntx <=63) and (cnty >= 128 and cnty <= 191)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011001";
			gui_sel <= '1';
		
		
		
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 0 and cnty <= 63)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011010";
			gui_sel <= '1';
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 0 and cnty <= 63)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011011";
			gui_sel <= '1';
			
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 64 and cnty <= 127)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011100";
			gui_sel <= '1';
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 64 and cnty <= 127)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011101";
			gui_sel <= '1';
			
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 128 and cnty <= 191)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011110";
			gui_sel <= '1';
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 128 and cnty <= 191)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "011111";
			gui_sel <= '1';
			
			
			
			
		elsif((cntx >= 128 and cntx <=159) and (cnty >= 0 and cnty <= 63)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "100000";
			gui_sel <= '1';
		elsif((cntx >= 160 and cntx <=191) and (cnty >= 0 and cnty <= 63)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "100001";
			gui_sel <= '1';
			
		elsif((cntx >= 128 and cntx <=159) and (cnty >= 64 and cnty <= 127)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "100010";
			gui_sel <= '1';
		elsif((cntx >= 160 and cntx <=191) and (cnty >= 64 and cnty <= 127)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "100011";
			gui_sel <= '1';
			
		elsif((cntx >= 128 and cntx <=159) and (cnty >= 128 and cnty <= 191)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "100100";
			gui_sel <= '1';
		elsif((cntx >= 160 and cntx <=191) and (cnty >= 128 and cnty <= 191)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "100101";
			gui_sel <= '1';
			
		--VYKRESLENI NAPISU LEVEL--	
		elsif((cntx >= 0 and cntx <=31) and (cnty >= 384 and cnty <= 447)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000000";
			gui_sel <= '1';
		elsif((cntx >= 32 and cntx <=63) and (cnty >= 384 and cnty <= 447)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000001";
			gui_sel <= '1';
			
		--VYKRESLENI LEVEL COUNTERU--
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 384 and cnty <= 447)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			case act_lvl_10 is
				when 0 => address_y <= "001010";
				when 1 => address_y <= "001011";
				when 2 => address_y <= "001100";
				when 3 => address_y <= "001101";
				when 4 => address_y <= "001110";
				when 5 => address_y <= "001111";
				when 6 => address_y <= "010000";
				when 7 => address_y <= "010001";
				when 8 => address_y <= "010010";
				when 9 => address_y <= "010011";
				when others => address_y <= "010011";
			end case;
			gui_sel <= '1';
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 384 and cnty <= 447)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			case act_lvl_1 is
				when 0 => address_y <= "001010";
				when 1 => address_y <= "001011";
				when 2 => address_y <= "001100";
				when 3 => address_y <= "001101";
				when 4 => address_y <= "001110";
				when 5 => address_y <= "001111";
				when 6 => address_y <= "010000";
				when 7 => address_y <= "010001";
				when 8 => address_y <= "010010";
				when 9 => address_y <= "010011";
				when others => address_y <= "010011";
			end case;
			gui_sel <= '1';
			
		--VYKRESLENI NAPISU TAHY--		
		elsif((cntx >= 0 and cntx <=31) and (cnty >= 448 and cnty <= 511)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000010";
			gui_sel <= '1';
		elsif((cntx >= 32 and cntx <=63) and (cnty >= 448 and cnty <= 511)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			address_y <= "000011";
			gui_sel <= '1';
			
		--VYKRESLENI COUNTERU TAHU--	
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 448 and cnty <= 511)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			case act_stp_10 is
				when 0 => address_y <= "001010";
				when 1 => address_y <= "001011";
				when 2 => address_y <= "001100";
				when 3 => address_y <= "001101";
				when 4 => address_y <= "001110";
				when 5 => address_y <= "001111";
				when 6 => address_y <= "010000";
				when 7 => address_y <= "010001";
				when 8 => address_y <= "010010";
				when 9 => address_y <= "010011";
				when others => address_y <= "010011";
			end case;
			gui_sel <= '1';
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 448 and cnty <= 511)) then
			address_x <= std_logic_vector(to_unsigned((cntx mod 32)*64 + (cnty mod 64),11));
			case act_stp_1 is
				when 0 => address_y <= "001010";
				when 1 => address_y <= "001011";
				when 2 => address_y <= "001100";
				when 3 => address_y <= "001101";
				when 4 => address_y <= "001110";
				when 5 => address_y <= "001111";
				when 6 => address_y <= "010000";
				when 7 => address_y <= "010001";
				when 8 => address_y <= "010010";
				when 9 => address_y <= "010011";
				when others => address_y <= "010011";
			end case;
			gui_sel <= '1';
			
			
		else
			gui_sel <= '0';
		end if;
	end if;
end process;

end Behavioral;

