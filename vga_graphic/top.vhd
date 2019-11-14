----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:41:55 10/16/2019 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    Port ( clk : in  STD_LOGIC := '0';
           HS,VS,R,G,B, frame_tick : out  STD_LOGIC := '0';
			  
			  --experimentalni signaly
			  move: in std_logic := '0';
			  reset: in std_logic := '0';
			  ack: out std_logic := '0');
end top;

architecture Behavioral of top is

--component mux2 is
--    Port ( a,b : in  STD_LOGIC_VECTOR (10 downto 0);
--           y : out  STD_LOGIC_VECTOR (10 downto 0);
--           sel : in  STD_LOGIC);
--end component;b

component vga_sync is
    Port ( clk : in  STD_LOGIC;
           h_sync, v_sync,video_on, frame_tick : out  STD_LOGIC;
           pixel_x, pixel_y : out  STD_LOGIC_VECTOR (10 downto 0));
end component;

component level_generator is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			  pixx_offs, pixy_offs, inside_pixx_offs, inside_pixy_offs : out std_logic_vector(10 downto 0);
			  mem_add: out std_logic_vector(5 downto 0);
			  mem_data: in std_logic_vector(2 downto 0);
           clock : in  STD_LOGIC;
			  border_draw_en, graphics_enable : out  STD_LOGIC;
			  selected_object: out std_logic_vector(2 downto 0);
			  
			  obj_offs_x, obj_offs_y: out std_logic_vector(8 downto 0);
		--experimentarni signaly
			  move, reset : in  STD_LOGIC;
			  ack: out std_logic
			  );
end component;

component object_generator is
    Port ( clk: std_logic;
			  sel: in std_logic_vector(2 downto 0);
           pixx, pixy : in  STD_LOGIC_VECTOR (10 downto 0);
           offset_x, offset_y : in  STD_LOGIC_VECTOR (8 downto 0);
			  
			  --signaly pro pamet
			  mem_read_enable: out std_logic;
			  mem_add_x: out std_logic_vector(11 downto 0);
			  mem_add_y: out std_logic_vector(2 downto 0)
		);
end component;

component graphic_rom is
    Port ( clock, read_enable : in  STD_LOGIC;
           address_x: in  STD_LOGIC_VECTOR (11 downto 0);
			  address_y: in  STD_LOGIC_VECTOR (2 downto 0);
           data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component levels_rom is
    Port ( clock: in  STD_LOGIC;
           address_x : in  STD_LOGIC_VECTOR (5 downto 0);
           data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component color_output_mux is
    Port ( graphic_object : in  STD_LOGIC_VECTOR (2 downto 0);
           graphic_object_sel : in  STD_LOGIC;
			  R,G,B: out std_logic);
end component;


--vnitrni signaly pro synchronizaci grafiky
signal vid_on: std_logic := '0';
signal pxx, pxy: std_logic_vector(10 downto 0) := (others => '0');
signal red, green, blue: std_logic;

--signaly pro ram levelu
signal lvl_mem_addx: std_logic_vector(5 downto 0) := (others => '0');
signal lvl_mem_data: std_logic_vector(2 downto 0) := (others => '0');

--signaly pro grafickou pamet
signal graphic_mem_addx: std_logic_vector(11 downto 0) := (others => '0');
signal graphic_mem_addy: std_logic_vector(2 downto 0) := (others => '0');
signal graphic_mem_re: std_logic;
signal graphic_mem_data: std_logic_vector(2 downto 0);

--offsety grafickych obejktu
signal gr_offs_x, gr_offs_y: std_logic_vector(8 downto 0);

--signaly pro rizeni generatoru objektu
signal selected_object:std_logic_vector(2 downto 0);
signal border_draw_en:std_logic;

--signaly pixelu s offsetem
signal pixx_arena, pixy_arena, inside_pix_x, inside_pix_y, pixx_selected, pixy_selected: std_logic_vector(10 downto 0) := (others => '0');

--signaly vystupniho multiplexeru
--signal graphic_object: std_logic_vector(2 downto 0);
signal graphics_enable: std_logic;

begin

reg_color: process(clk) is			--vystupni registr barev
begin
	if(rising_edge(clk)) then
		if(vid_on ='1') then
			R <= red;
			G <= green;
			B <= blue;
		else
			R <= '0';
			G <= '0';
			B <= '0';
		end if;
	end if;
end process;

with border_draw_en select
pixx_selected <= pixx_arena when '1',
						inside_pix_x when '0',
						(others => '0') when others;
						
with border_draw_en select
pixy_selected <= pixy_arena when '1',
						inside_pix_y when '0',
						(others => '0') when others;
			
synchronizer: vga_sync
		port map(
			clk => clk,
			h_sync => HS,
			v_sync => VS,
			video_on => vid_on,
			pixel_x => pxx,
			pixel_y => pxy,
			frame_tick => frame_tick);
			
lvl_load_generator: level_generator
		port map(
		  pix_x => pxx, 
		  pix_y => pxy, 
		  pixx_offs => pixx_arena,
		  pixy_offs => pixy_arena,
		  inside_pixx_offs => inside_pix_x,
		  inside_pixy_offs => inside_pix_y,
		  mem_add => lvl_mem_addx,
		  mem_data => lvl_mem_data,
        clock => clk,
		  graphics_enable => graphics_enable,
		  move => move,
		  reset => reset,
		  ack => ack,
		  obj_offs_x => gr_offs_x, 
		  obj_offs_y => gr_offs_y,
		  border_draw_en => border_draw_en,
		  selected_object => selected_object
		);
		
graphics_generator:object_generator
		port map(
			clk => clk,
			sel => selected_object,
         pixx => pixx_selected,
			pixy => pixy_selected,
         offset_x => gr_offs_x,
			offset_y => gr_offs_y,			 
			mem_read_enable => graphic_mem_re,
			mem_add_x => graphic_mem_addx,
			mem_add_y => graphic_mem_addy
		);
		
level_placement_rom:levels_rom
		port map(
			clock => clk,
         address_x => lvl_mem_addx,
         data_out => lvl_mem_data
		);
		
sprite_memory: graphic_rom
		port map(
			clock => clk,
			read_enable => graphic_mem_re,
         address_x => graphic_mem_addx,
			address_y => graphic_mem_addy,
         data_out => graphic_mem_data
		);
		
col_out_mux: color_output_mux
		port map(
			graphic_object => graphic_mem_data,
			graphic_object_sel => graphics_enable,
			R => red,
			G => green,
			B => blue
		);


end Behavioral;

