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
			 
			 --pamet s logem,entrem a rst
			 mem_re1: out std_logic;
			 address_x1 : out STD_LOGIC_VECTOR (11 downto 0);
			 address_y1 : out STD_LOGIC_VECTOR (3 downto 0);
			 mem_data_1: in std_logic_vector(1 downto 0);
			 
			 --pamet s cisly a pismeny
			 mem_re2: out std_logic;
			 address_x2 : out STD_LOGIC_VECTOR (5 downto 0);
			 address_y2 : out STD_LOGIC_VECTOR (4 downto 0);
			 mem_data_2: in std_logic_vector(0 to 31);
			 
			 color: out std_logic_vector(2 downto 0);
			 gui_sel : out STD_LOGIC);
end gui_generator;

architecture Behavioral of gui_generator is

signal cntx, cnty: natural range 0 to 1600 := 0;
signal act_lvl_1, act_lvl_10, act_stp_1, act_stp_10 : natural range 0 to 100 := 0;
signal sel_color, sel_baw: std_logic := '0';				--cteni z barevnych nebo cernobilych sprajtu

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
		address_x1 <= std_logic_vector(to_unsigned((cntx mod 64)*64 + (cnty mod 64),12));		--nacitani sprajtu 64x64
		gui_sel <= '1';
		mem_re1 <= '1';
		mem_re2 <= '1';
		sel_color <= '0';
		sel_baw <= '1';
		
		--VYKRESLENI TLACITKA ENTER--
		if((cntx >= 128 and cntx <=192) and (cnty >= 384 and cnty <= 447)) then
			address_y1 <= "1110";
			sel_color <= '1';
			sel_baw <= '0';
			
		--VYKRESLENI TLACITKA RESET--
		elsif((cntx >= 128 and cntx <=192) and (cnty >= 448 and cnty <= 511)) then
			address_y1 <= "1111";
			sel_color <= '1';
			sel_baw <= '0';
			
		--VYKRESLENI LOGA--
		elsif((cntx >= 0 and cntx <=63) and (cnty >= 0 and cnty <= 63)) then
			address_y1 <= "0101";
			sel_color <= '1';
			sel_baw <= '0';
			
		elsif((cntx >= 0 and cntx <=63) and (cnty >= 64 and cnty <= 127)) then
			address_y1 <= "0110";
			sel_color <= '1';
			sel_baw <= '0';
			
		elsif((cntx >= 0 and cntx <=63) and (cnty >= 128 and cnty <= 191)) then
			address_y1 <= "0111";
			sel_color <= '1';
			sel_baw <= '0';
				
		elsif((cntx >= 64 and cntx <=127) and (cnty >= 0 and cnty <= 63)) then
			address_y1 <= "1000";
			sel_color <= '1';
			sel_baw <= '0';
			
		elsif((cntx >= 64 and cntx <=127) and (cnty >= 64 and cnty <= 127)) then
			address_y1 <= "1001";
			sel_color <= '1';
			sel_baw <= '0';
			
		elsif((cntx >= 64 and cntx <=127) and (cnty >= 128 and cnty <= 191)) then
			address_y1 <= "1010";
			sel_color <= '1';
			sel_baw <= '0';
			
		elsif((cntx >= 128 and cntx <=191) and (cnty >= 0 and cnty <= 63)) then
			address_y1 <= "1011";
			sel_color <= '1';
			sel_baw <= '0';
			
		elsif((cntx >= 128 and cntx <=191) and (cnty >= 64 and cnty <= 127)) then
			address_y1 <= "1100";
			sel_color <= '1';
			sel_baw <= '0';
			
		elsif((cntx >= 128 and cntx <=191) and (cnty >= 128 and cnty <= 191)) then
			address_y1 <= "1101";
			sel_color <= '1';
			sel_baw <= '0';
			
		--VYKRESLENI NAPISU OVLADANI
		elsif((cntx >= 0 and cntx <=31) and (cnty >= 192 and cnty <= 255)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00000";
		elsif((cntx >= 32 and cntx <=63) and (cnty >= 192 and cnty <= 255)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00011";
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 192 and cnty <= 255)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00111";
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 192 and cnty <= 255)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00101";
		elsif((cntx >= 128 and cntx <=159) and (cnty >= 192 and cnty <= 255)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00010";
		elsif((cntx >= 160 and cntx <=191) and (cnty >= 192 and cnty <= 255)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "01001";
			
		--VYKRESLENI NAPISU LEVEL--	
		elsif((cntx >= 0 and cntx <=31) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64),6));
			address_y2 <= "00010";
		elsif((cntx >= 32 and cntx <=63) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00001";
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "01000";
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00001";
		elsif((cntx >= 128 and cntx <=159) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00010";
		elsif((cntx >= 160 and cntx <=191) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "01001";
			
		--VYKRESLENI LEVEL COUNTERU--
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 384 and cnty <= 447)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			case act_lvl_10 is
				when 0 => address_y2 <= "10011";
				when 1 => address_y2 <= "01010";
				when 2 => address_y2 <= "01011";
				when 3 => address_y2 <= "01100";
				when 4 => address_y2 <= "01101";
				when 5 => address_y2 <= "01110";
				when 6 => address_y2 <= "01111";
				when 7 => address_y2 <= "10000";
				when 8 => address_y2 <= "10001";
				when 9 => address_y2 <= "10010";
				when others => address_y2 <= "10010";
			end case;
			
		elsif((cntx >= 96 and cntx <=127) and (cnty >= 384 and cnty <= 447)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			case act_lvl_1 is
				when 0 => address_y2 <= "10011";
				when 1 => address_y2 <= "01010";
				when 2 => address_y2 <= "01011";
				when 3 => address_y2 <= "01100";
				when 4 => address_y2 <= "01101";
				when 5 => address_y2 <= "01110";
				when 6 => address_y2 <= "01111";
				when 7 => address_y2 <= "10000";
				when 8 => address_y2 <= "10001";
				when 9 => address_y2 <= "10010";
				when others => address_y2 <= "10010";
			end case;
			
		--VYKRESLENI NAPISU STEPS--
		elsif((cntx >= 480 and cntx <=511) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00110";
		elsif((cntx >= 512 and cntx <=543) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00111";
			
		elsif((cntx >= 544 and cntx <=575) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00001";
			
		elsif((cntx >= 576 and cntx <=607) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00100";
			
		elsif((cntx >= 608 and cntx <=639) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "00110";
			
		elsif((cntx >= 640 and cntx <=671) and (cnty >= 512 and cnty <= 575)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			address_y2 <= "01001";
			
		--VYKRESLENI COUNTERU TAHU--	
		elsif((cntx >= 64 and cntx <=95) and (cnty >= 448 and cnty <= 511)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			case act_stp_10 is
				when 0 => address_y2 <= "10011";
				when 1 => address_y2 <= "01010";
				when 2 => address_y2 <= "01011";
				when 3 => address_y2 <= "01100";
				when 4 => address_y2 <= "01101";
				when 5 => address_y2 <= "01110";
				when 6 => address_y2 <= "01111";
				when 7 => address_y2 <= "10000";
				when 8 => address_y2 <= "10001";
				when 9 => address_y2 <= "10010";
				when others => address_y2 <= "10010";
			end case;

		elsif((cntx >= 96 and cntx <=127) and (cnty >= 448 and cnty <= 511)) then
			address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
			case act_stp_1 is
				when 0 => address_y2 <= "10011";
				when 1 => address_y2 <= "01010";
				when 2 => address_y2 <= "01011";
				when 3 => address_y2 <= "01100";
				when 4 => address_y2 <= "01101";
				when 5 => address_y2 <= "01110";
				when 6 => address_y2 <= "01111";
				when 7 => address_y2 <= "10000";
				when 8 => address_y2 <= "10001";
				when 9 => address_y2 <= "10010";
				when others => address_y2 <= "10010";
			end case;		
			
		else
			gui_sel <= '0';
			mem_re1 <= '0';
			mem_re2 <= '0';
			sel_color <= '0';
			sel_baw <= '0';
		end if;
	end if;
end process;

	color_decoder:process(clk)
		variable temp: std_logic := '0';
	begin
		if(rising_edge(clk)) then
			if(sel_color = '1') then
			
				case(mem_data_1) is
					when "11" => color <= "110";
					when "00" => color <= "000";
					when "01" => color <= "111";
					when "10" => color <= "100";
					when others => color <= "000";
				end case;
				
			elsif(sel_baw = '1') then
				temp := mem_data_2(cntx mod 32);
				
				case(temp) is
					when '0' => color <= "000";
					when '1' => color <= "111";
					when others => color <= "000";
				end case;
			end if;				
		end if;
	end process;

end Behavioral;

