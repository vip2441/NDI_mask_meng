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

component mux2 is
    Port ( a,b : in  STD_LOGIC_VECTOR (10 downto 0);
           y : out  STD_LOGIC_VECTOR (10 downto 0);
           sel : in  STD_LOGIC);
end component;

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
			  border_draw_en : out  STD_LOGIC;
			  selected_object: out std_logic_vector(2 downto 0);
		--experimentarni signaly
			  move, reset : in  STD_LOGIC;
			  ack: out std_logic
			  );
end component;

component object_generator is
    Port ( object : in  STD_LOGIC_VECTOR (2 downto 0);
           inside_pixx_offs, inside_pixy_offs : in  STD_LOGIC_VECTOR (10 downto 0);
           pixx_offs, pixy_offs : in  STD_LOGIC_VECTOR (10 downto 0);
           border_draw_en : in  STD_LOGIC;
           offset_x, offset_y : in  STD_LOGIC_VECTOR (8 downto 0);
           R,G,B : out  STD_LOGIC);
end component;

component levels_rom is
    Port ( clock: in  STD_LOGIC;
           address_x : in  STD_LOGIC_VECTOR (5 downto 0);
           data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

--vnitrni signaly pro synchronizaci grafiky
signal vid_on: std_logic := '0';
signal pxx, pxy: std_logic_vector(10 downto 0) := (others => '0');
signal red, green, blue: std_logic;

--signaly pro ram levelu
signal lvl_mem_addx: std_logic_vector(5 downto 0) := (others => '0');
signal lvl_mem_data: std_logic_vector(2 downto 0) := (others => '0');

--signaly pro rizeni generatoru objektu
signal selected_object:std_logic_vector(2 downto 0);
signal border_draw_en:std_logic;
signal obj_offset_x, obj_offset_y: std_logic_vector(8 downto 0) := (others => '0');

--signaly pixelu s offsetem
signal pixx_arena, pixy_arena, inside_pix_x, inside_pix_y, pixx_selected, pixy_selected: std_logic_vector(10 downto 0) := (others => '0');

--signaly pro povoleni vykreslovani objektu
signal gen_floor_en, gen_wall_en, gen_stone_en,gen_food_en, gen_player_en:std_logic;

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

pixx_counter_select:mux2
		port map(
			a =>pixx_arena,
			b =>inside_pix_x,
			y =>pixx_selected,
			sel => border_draw_en
		);
		
pixy_counter_select:mux2
		port map(
			a =>pixy_arena,
			b =>inside_pix_y,
			y =>pixy_selected,
			sel => border_draw_en
		);
			
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
		  move => move,
		  reset => reset,
		  ack => ack,
		  border_draw_en => border_draw_en,
		  selected_object => selected_object
		);
		
		object_selector: object_decoder
		port map(
			object => selected_object,
         wall_obj =>gen_wall_en, 
			stone_obj =>gen_stone_en, 
			floor_obj =>gen_floor_en,
			player_obj => gen_player_en,
			food_obj => gen_food_en
		);
		
graphics_generator:object_generator
		port map(
			object => selected_object,
         pixx => pixx_selected,
			pixy => pixy_selected,
         offset_x => obj_offset_x,				--DOPLNIT do level generatoru!!
			offset_y => obj_offset_y,
         R => red,
			G => green,
			B => blue
		);
		
level_placement_rom:levels_rom
		port map(
			clock => clk,
         address_x => lvl_mem_addx,
         data_out => lvl_mem_data
		);


end Behavioral;

