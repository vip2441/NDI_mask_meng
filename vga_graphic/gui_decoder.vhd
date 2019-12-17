library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gui_decoder is
    Port ( clk : in  STD_LOGIC;
			 sel: in std_logic_vector(5 downto 0);
			 pix_x,pix_y: in std_logic_vector(10 downto 0);
			
			 --pamet s logem,entrem
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
			 gui_en, white_dots_en : out STD_LOGIC
			);
end gui_decoder;

architecture Behavioral of gui_decoder is

	signal cntx, cnty: natural range 0 to 1200 := 0;
	signal sel_color, sel_baw: std_logic := '0';				--cteni z barevnych nebo cernobilych sprajtu

begin

	cntx <= to_integer(unsigned(pix_x));
	cnty <= to_integer(unsigned(pix_y));

	process(clk)
	begin
		if(rising_edge(clk)) then
			
			address_x1 <= std_logic_vector(to_unsigned((cntx mod 64)*64 + (cnty mod 64),12));		--nacitani sprajtu 64x64
			gui_en <= '1';
			sel_color <= '1';
			mem_re1 <= '1';
			mem_re2 <= '0';
			sel_color <= '1';
			sel_baw <= '0';
			
			
			
			case sel is
				when "011110" =>			--LOGO1
					address_y1 <= "0101";
					
				when "011111" =>			--LOGO2
					address_y1 <= "0110";
					
				when "100000" =>			--LOGO3
					address_y1 <= "0111";
					
				when "100001" =>			--LOGO4
					address_y1 <= "1000";
					
				when "100010" =>			--LOGO5
					address_y1 <= "1001";
					
				when "100011" =>			--LOGO6
					address_y1 <= "1010";
					
				when "100100" =>			--LOGO7
					address_y1 <= "1011";
					
				when "100101" =>			--LOGO8
					address_y1 <= "1100";
					
				when "100110" =>			--LOGO9
					address_y1 <= "1101";
					
				when "100111" =>			--SIPKA NAHORU
					address_y1 <= "1111";
					
				when "101000" => 			--SIPKA DOLEVA
					address_x1 <= std_logic_vector(to_unsigned((cntx mod 64) + (cnty mod 64)*64,12));
					address_y1 <= "1111";
					
				when "101001" => 			--SIPKA DOPRAVA
					address_x1 <= std_logic_vector(to_unsigned((63-(cntx mod 64)) + (cnty mod 64)*64,12));
					address_y1 <= "1111";
					
				when "101010" => 			--SIPKA DOLU
					address_x1 <= std_logic_vector(to_unsigned(64*(cntx mod 64) + (63 -(cnty mod 64)),12));
					address_y1 <= "1111";
					
				when "111111" => 				--objekt niceho
					address_x1 <= (others => '0');
					address_y1 <= (others => '0');
					address_x2 <= (others => '0');
					address_y2 <= (others => '0');
					gui_en <= '0';
					sel_color <= '0';
					sel_baw <= '0';
					mem_re1 <= '0';
					mem_re2 <= '0';
					
				when others =>
					address_x2 <= std_logic_vector(to_unsigned((cnty mod 64) ,6));
					address_y2 <= sel(4 downto 0);		--pro vsechny sprajty 32x64 staci poslednich 5 bitu selectu	
					gui_en <= '1';
					mem_re1 <= '0';
					mem_re2 <= '1';
					sel_color <= '0';
					sel_baw <= '1';
			end case;			
		end if;		
	end process;
	
	color_decoder:process(clk)
		variable temp: std_logic := '0';
	begin
		if(rising_edge(clk)) then
			white_dots_en <= '0';
			if((cntx = 0) or (cntx = 798) or (cnty = 0) or (cnty = 599))then
				color <= "111";
				white_dots_en <= '1';
			
			elsif(sel_color = '1') then
				
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
			else
				color <= "000";
			end if;				
		end if;
	end process;



end Behavioral;

