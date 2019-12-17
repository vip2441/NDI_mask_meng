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
			 clk, game_on, finish : in STD_LOGIC;
			 lvl_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 lvl_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 
			obj_sel: out std_logic_vector(5 downto 0)
		);
end gui_generator;

architecture Behavioral of gui_generator is

	signal cntx, cnty: natural range 0 to 1600 := 0;
	signal act_lvl_1, act_lvl_10, act_stp_1, act_stp_10 : natural range 0 to 100 := 0;
	
	signal fin_cnt: natural range 0 to 35000000 := 0;

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
			
			fin_cnt <= fin_cnt + 1;
			
			--VYKRESLENI LOGA--
			if((cntx >= 0 and cntx < 64) and (cnty >= 0 and cnty < 64)) then
				obj_sel <= "011110";
			elsif((cntx >= 0 and cntx < 64) and (cnty >= 64 and cnty < 128)) then
				obj_sel <= "011111";
			elsif((cntx >= 0 and cntx < 64) and (cnty >= 128 and cnty < 192)) then
				obj_sel <= "100000";
			elsif((cntx >= 64 and cntx < 128) and (cnty >= 0 and cnty < 64)) then
				obj_sel <= "100001";
			elsif((cntx >= 64 and cntx < 128) and (cnty >= 64 and cnty < 128)) then
				obj_sel <= "100010";
			elsif((cntx >= 64 and cntx < 128) and (cnty >= 128 and cnty < 192)) then
				obj_sel <= "100011";
			elsif((cntx >= 128 and cntx < 192) and (cnty >= 0 and cnty < 64)) then
				obj_sel <= "100100";
			elsif((cntx >= 128 and cntx < 192) and (cnty >= 64 and cnty < 128)) then
				obj_sel <= "100101";
			elsif((cntx >= 128 and cntx < 192) and (cnty >= 128 and cnty < 192)) then
				obj_sel <= "100110";
				
			--VYKRESLENI NAPISU CNTRL:
			elsif((cntx >= 0 and cntx <=31) and (cnty >= 192 and cnty <= 255)) then				--C
				obj_sel <= "000000";
			elsif((cntx >= 32 and cntx <=63) and (cnty >= 192 and cnty <= 255)) then			--N
				obj_sel <= "000100";
			elsif((cntx >= 64 and cntx <=95) and (cnty >= 192 and cnty <= 255)) then			--T
				obj_sel <= "001000";
			elsif((cntx >= 96 and cntx <=127) and (cnty >= 192 and cnty <= 255)) then			--R
				obj_sel <= "000110";
			elsif((cntx >= 128 and cntx <=159) and (cnty >= 192 and cnty <= 255)) then			--L
				obj_sel <= "000011";
			elsif((cntx >= 160 and cntx <=191) and (cnty >= 192 and cnty <= 255)) then			--:
				obj_sel <= "001011";
				
			--VYKRESLENI TLACITKA ESCAPE--
			elsif((cntx >= 0 and cntx < 32) and (cnty >= 256 and cnty < 320)) then
				obj_sel <= "011000";

			elsif((cntx >= 32 and cntx < 64) and (cnty >= 256 and cnty < 320)) then
				obj_sel <= "011001";

			--VYKRESLENI TLACITKA RESET--
			elsif((cntx >= 128 and cntx < 160) and (cnty >= 256 and cnty < 320)) then
				obj_sel <= "010110";

			elsif((cntx >= 160 and cntx < 192) and (cnty >= 256 and cnty < 320)) then
				obj_sel <= "010111";			
				
			--SIPKY---
			elsif((cntx >= 64 and cntx < 128) and (cnty >= 256 and cnty < 320)) then				--sipka nahoru
				obj_sel <= "100111";
				
			elsif((cntx >= 0 and cntx < 64) and (cnty >= 320 and cnty < 384)) then				--sipka doleva
				obj_sel <= "101000";
			
			elsif((cntx >= 128 and cntx < 192) and (cnty >= 320 and cnty < 384)) then				--sipka doprava
				obj_sel <= "101001";
				
			elsif((cntx >= 64 and cntx < 128) and (cnty >= 320 and cnty < 384)) then				--sipka dolu
				obj_sel <= "101010";		
			
			--NAPIS WINNER--
			elsif((cntx >= 0 and cntx <=31) and (cnty >= 448 and cnty <= 511) and (finish = '1') and (fin_cnt >= 17500000)) then			--W
				obj_sel <= "001010";
			elsif((cntx >= 32 and cntx <=63) and (cnty >= 448 and cnty <= 511) and (finish = '1') and (fin_cnt >= 17500000)) then		--I
				obj_sel <= "000010";
			elsif((cntx >= 64 and cntx <=95) and (cnty >= 448	and cnty <= 511) and (finish = '1') and (fin_cnt >= 17500000)) then		--N
				obj_sel <= "000100";
			elsif((cntx >= 96 and cntx <=127) and (cnty >= 448 and cnty <= 511) and (finish = '1') and (fin_cnt >= 17500000)) then		--N
				obj_sel <= "000100";
			elsif((cntx >= 128 and cntx <=159) and (cnty >= 448 and cnty <= 511) and (finish = '1') and (fin_cnt >= 17500000)) then		--E
				obj_sel <= "000001";
			elsif((cntx >= 160 and cntx <=191) and (cnty >= 448 and cnty <= 511) and (finish = '1') and (fin_cnt >= 17500000)) then		--R
				obj_sel <= "000110";
				
			--VYKRESLENI NAPISU LEVEL--	
			elsif((cntx >= 0 and cntx <=31) and (cnty >= 512 and cnty <= 575)) then				--L
				obj_sel <= "000011";
			elsif((cntx >= 32 and cntx <=63) and (cnty >= 512 and cnty <= 575)) then			--E
				obj_sel <= "000001";
			elsif((cntx >= 64 and cntx <=95) and (cnty >= 512 and cnty <= 575)) then			--V
				obj_sel <= "001001";
			elsif((cntx >= 96 and cntx <=127) and (cnty >= 512 and cnty <= 575)) then			--E
				obj_sel <= "000001";
			elsif((cntx >= 128 and cntx <=159) and (cnty >= 512 and cnty <= 575)) then			--L
				obj_sel <= "000011";
			elsif((cntx >= 160 and cntx <=191) and (cnty >= 512 and cnty <= 575)) then			--:
				obj_sel <= "001011";
				
			--VYKRESLENI LEVEL COUNTERU--
			elsif((cntx >= 192 and cntx < 224) and (cnty >= 512 and cnty < 576)) then
				case act_lvl_10 is
					when 0 => obj_sel <= "010101";
					when 1 => obj_sel <= "001100";
					when 2 => obj_sel <= "001101";
					when 3 => obj_sel <= "001110";
					when 4 => obj_sel <= "001111";
					when 5 => obj_sel <= "010000";
					when 6 => obj_sel <= "010001";
					when 7 => obj_sel <= "010010";
					when 8 => obj_sel <= "010011";
					when 9 => obj_sel <= "010100";
					when others => obj_sel <= "010101";
				end case;
				
			elsif((cntx >= 224 and cntx < 256) and (cnty >= 512 and cnty < 576)) then
				case act_lvl_1 is
					when 0 => obj_sel <= "010101";
					when 1 => obj_sel <= "001100";
					when 2 => obj_sel <= "001101";
					when 3 => obj_sel <= "001110";
					when 4 => obj_sel <= "001111";
					when 5 => obj_sel <= "010000";
					when 6 => obj_sel <= "010001";
					when 7 => obj_sel <= "010010";
					when 8 => obj_sel <= "010011";
					when 9 => obj_sel <= "010100";
					when others => obj_sel <= "010101";
				end case;
			
			--VYKRESLENI SIPECEK--
			elsif((cntx >= 256 and cntx < 288) and (cnty >= 512 and cnty <= 575) and (game_on = '0')) then
				obj_sel <= "011010";
				
				
			--VYKRESLENI TLACITKA ENTER--
			elsif((cntx >= 288 and cntx < 320) and (cnty >= 512 and cnty < 576) and (game_on = '0')) then
				obj_sel <= "011011";
				
			elsif((cntx >= 320 and cntx < 352) and (cnty >= 512 and cnty < 576) and (game_on = '0')) then
				obj_sel <= "011100";			
				
			--VYKRESLENI NAPISU STEPS--
			elsif((cntx >= 480 and cntx <=511) and (cnty >= 512 and cnty <= 575)) then			--S
				obj_sel <= "000111";
				
			elsif((cntx >= 512 and cntx <=543) and (cnty >= 512 and cnty <= 575)) then			--T
				obj_sel <= "001000";
				
			elsif((cntx >= 544 and cntx <=575) and (cnty >= 512 and cnty <= 575)) then			--E
				obj_sel <= "000001";
				
			elsif((cntx >= 576 and cntx <=607) and (cnty >= 512 and cnty <= 575)) then			--P
				obj_sel <= "000101";
				
			elsif((cntx >= 608 and cntx <=639) and (cnty >= 512 and cnty <= 575)) then			--S
				obj_sel <= "000111";
				
			elsif((cntx >= 640 and cntx <=671) and (cnty >= 512 and cnty <= 575)) then			--:
				obj_sel <= "001011";
				
			--VYKRESLENI COUNTERU TAHU--	
			elsif((cntx >= 672 and cntx < 704) and (cnty >= 512 and cnty < 576)) then
				case act_stp_10 is
					when 0 => obj_sel <= "010101";
					when 1 => obj_sel <= "001100";
					when 2 => obj_sel <= "001101";
					when 3 => obj_sel <= "001110";
					when 4 => obj_sel <= "001111";
					when 5 => obj_sel <= "010000";
					when 6 => obj_sel <= "010001";
					when 7 => obj_sel <= "010010";
					when 8 => obj_sel <= "010011";
					when 9 => obj_sel <= "010100";
					when others => obj_sel <= "010101";
				end case;

			elsif((cntx >= 704 and cntx < 736) and (cnty >= 512 and cnty < 576)) then
				case act_stp_1 is
					when 0 => obj_sel <= "010101";
					when 1 => obj_sel <= "001100";
					when 2 => obj_sel <= "001101";
					when 3 => obj_sel <= "001110";
					when 4 => obj_sel <= "001111";
					when 5 => obj_sel <= "010000";
					when 6 => obj_sel <= "010001";
					when 7 => obj_sel <= "010010";
					when 8 => obj_sel <= "010011";
					when 9 => obj_sel <= "010100";
					when others => obj_sel <= "010101";
				end case;		
				
			else
				obj_sel <= "111111";			--objekt niceho
			end if;
		end if;
	end process;


end Behavioral;

