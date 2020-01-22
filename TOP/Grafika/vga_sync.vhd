----------------------------------------------------------------------------------
-- Company: FEKT VUT v Brne
-- Engineer: Vladislav Valek, Tomas Truska
-- 
-- Create Date:    17:46:13 10/16/2019 
-- Design Name: 	VGA controller
-- Module Name:    vga_sync - Behavioral 
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

entity vga_sync is
    Port ( clk : in  STD_LOGIC;
           h_sync, v_sync,video_on, frame_tick : out  STD_LOGIC;
           pixel_x, pixel_y : out  STD_LOGIC_VECTOR (10 downto 0));
end vga_sync;

architecture Behavioral of vga_sync is

component clk_divider is
	generic(del : integer := 1);		--urcuje modulus, takze deli cislem 2^del
    Port ( clk_in : in  STD_LOGIC;
           clk_out_div : out  STD_LOGIC);
end component;

component cntr is
	generic(modulo: integer := 20);
    Port ( 
	 clk, ce, clr : in  STD_LOGIC;
	 ovf: out std_logic;
	 q : out std_logic_vector (10 downto 0));
end component;

signal ovf_inter : std_logic := '0';
signal px_x, px_y: std_logic_vector(10 downto 0) := (others => '0');
signal cntx, cnty: integer := 0;

constant hline: integer := 1040;
constant vline: integer := 666;

constant hdisp: integer :=800;
constant hfront_porch: integer :=56;
constant hretrace: integer :=120;

constant vdisp: integer :=600;
constant vfront_porch: integer :=37;
constant vretrace: integer :=6;

begin
		
h_cnt: cntr
		generic map(modulo => hline)
		port map(
		clk => clk,
		ce => '1',
		clr => '0',
		ovf => ovf_inter,
		q => px_x);

v_cnt: cntr
		generic map(modulo => vline)
		port map(
		clk => clk,
		ce => ovf_inter,
		clr => '0',
		ovf => frame_tick,
		q => px_y);
		
		
cntx <= to_integer(unsigned(px_x));
cnty <= to_integer(unsigned(px_y));
		
video_on <= '1' when ( cntx < hdisp and cnty < vdisp) 
			else '0';
			
h_sync <= '0' when ( cntx <= (hdisp + hfront_porch) or cntx >= (hdisp + hfront_porch + hretrace)) 
				else '1';                                 
v_sync <= '0' when ( cnty <= (vdisp + vfront_porch) or cnty >= (vdisp + vfront_porch + vretrace))
				else '1';                                

pixel_x <= px_x;
pixel_y <= px_y;

end Behavioral;

