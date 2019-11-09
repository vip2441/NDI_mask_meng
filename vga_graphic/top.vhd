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
           HS,VS,R,G,B, frame_tick : out  STD_LOGIC := '0');
end top;

architecture Behavioral of top is

component mux2 is
    Port ( a,b : in  STD_LOGIC_VECTOR (10 downto 0);
           y : out  STD_LOGIC_VECTOR (10 downto 0);
           sel : in  STD_LOGIC);
end component;

component object_decoder is
    Port ( object : in  STD_LOGIC_VECTOR (2 downto 0);
           wall_obj, stone_obj, floor_obj, player_obj, food_obj : out  STD_LOGIC);
end component;

component vga_sync is
    Port ( clk : in  STD_LOGIC;
           h_sync, v_sync,video_on, frame_tick : out  STD_LOGIC;
           pixel_x, pixel_y : out  STD_LOGIC_VECTOR (10 downto 0));
end component;

component level_generator is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
				pixx_offs, pixy_offs, inside_pixx_offs, inside_pixy_offs : out std_logic_vector(10 downto 0);
				mem_add_x: out std_logic_vector(5 downto 0);
				mem_data: in std_logic_vector(2 downto 0);
           clock : in  STD_LOGIC;
			  border_draw_en : out  STD_LOGIC;
			  selected_object: out std_logic_vector(2 downto 0));
end component;

component levels_rom is
    Port ( clock: in  STD_LOGIC;
           address_x : in  STD_LOGIC_VECTOR (5 downto 0);
           data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component wall_object is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
           enable, clk : in  STD_LOGIC;
           color : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component floor_object is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
           enable, clk : in  STD_LOGIC;
           color : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component stone_obj is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
           enable, clk : in  STD_LOGIC;
           color : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component food_obj is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
           enable, clk : in  STD_LOGIC;
           color : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component player_obj is
    Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
           enable, clk : in  STD_LOGIC;
           color : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component color_output_mux is
    Port ( floor_obj, wall_obj, stone_obj,player_obj, food_obj, gui_obj : in  STD_LOGIC_VECTOR (2 downto 0);
           R,G,B : out  STD_LOGIC;
           floor_sel, wall_sel, stone_sel, player_sel,food_sel, gui_sel: in  STD_LOGIC);
end component;

component gui_generator is
	Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			 clk : in STD_LOGIC;
			 lvl_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 lvl_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 color : out STD_LOGIC_VECTOR (2 downto 0);
			 gui_sel : out STD_LOGIC);
end component;

--vnitrni signaly pro synchronizaci grafiky
signal vid_on: std_logic := '0';
signal pxx, pxy: std_logic_vector(10 downto 0) := (others => '0');
signal red, green, blue: std_logic;

--signaly pro ram levelu
signal lvl_mem_addx: std_logic_vector(5 downto 0) := (others => '0');
signal lvl_mem_data: std_logic_vector(2 downto 0) := (others => '0');

--vnitrni signaly z vystupu generatoru objektu
signal floor_pic, wall_pic, stone_pic, player_pic, food_pic, gui_pic: std_logic_vector(2 downto 0) := (others => '0');

--signaly pro povoleni vykreslovani objektu
signal gen_floor_en, gen_wall_en, gen_stone_en,gen_food_en, gen_player_en, border_draw_en, gui_en:std_logic;

signal selected_object:std_logic_vector(2 downto 0);

--signaly pixelu s offsetem
signal pixx_arena, pixy_arena, inside_pix_x, inside_pix_y, pixx_selected, pixy_selected: std_logic_vector(10 downto 0) := (others => '0');

--signaly pro tahy a levely
signal lvl_1: std_logic_vector(3 downto 0) := "0101";
signal lvl_10: std_logic_vector(3 downto 0) := "0010";
signal stp_1: std_logic_vector(3 downto 0) := "0100";
signal stp_10: std_logic_vector(3 downto 0) := "0100";

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

info_generator: gui_generator
		port map(
			clk => clk,
			pix_x => pxx,
			pix_y => pxy,
			gui_sel => gui_en,
			color => gui_pic,
			lvl_jednotky => lvl_1,
			lvl_desitky => lvl_10,
			stp_jednotky => stp_1,
			stp_desitky => stp_10);
			
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
		  mem_add_x => lvl_mem_addx,
		  mem_data => lvl_mem_data,
        clock => clk,
		  border_draw_en => border_draw_en,
		  selected_object => selected_object
		);
		
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

object_selector: object_decoder
		port map(
			object => selected_object,
         wall_obj =>gen_wall_en, 
			stone_obj =>gen_stone_en, 
			floor_obj =>gen_floor_en,
			player_obj => gen_player_en,
			food_obj => gen_food_en
		);
		
level_placement_rom:levels_rom
		port map(
			clock => clk,
         address_x => lvl_mem_addx,
         data_out => lvl_mem_data
		);

floor_object_generator: floor_object
		port map(
			pix_x => inside_pix_x,
			pix_y => inside_pix_y,
         enable => gen_floor_en,
			clk => clk,
         color => floor_pic
		);
			
wall_object_generator: wall_object
		port map(
			pix_x => pixx_selected,
			pix_y => pixy_selected,
         enable => gen_wall_en,
			clk => clk,
         color => wall_pic
		);
		
stone_object_generator: stone_obj
		port map(
			pix_x => inside_pix_x,
			pix_y => inside_pix_y,
         enable => gen_stone_en,
			clk => clk,
         color => stone_pic
		);		
		
player_object_generator: player_obj
		port map(
			pix_x => inside_pix_x,
			pix_y => inside_pix_y,
         enable => gen_player_en,
			clk => clk,
         color => player_pic
		);		
		
food_object_generator: food_obj
		port map(
			pix_x => inside_pix_x,
			pix_y => inside_pix_y,
         enable => gen_food_en,
			clk => clk,
         color => food_pic
		);		
						
col_out_mux: color_output_mux
		port map(
			floor_obj => floor_pic, 
			wall_obj => wall_pic, 
			player_obj => player_pic, 
			stone_obj => stone_pic, 
			food_obj => food_pic,
         floor_sel => gen_floor_en, 
			wall_sel => gen_wall_en, 
			player_sel => gen_player_en,
			stone_sel => gen_stone_en,
			food_sel => gen_food_en,
			gui_sel => gui_en,
			gui_obj => gui_pic,
			R => red,
			G => green,
			B => blue);
end Behavioral;

