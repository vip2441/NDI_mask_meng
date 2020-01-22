library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Grafika is
    Port ( clk, wf_en : in  STD_LOGIC := '0';
           HS,VS,R,G,B, frame_tick: out  STD_LOGIC := '0';
			  start_pos, end_pos: in std_logic_vector(7 downto 0);
			  
			  --pamet usporadani levelu
			  lvl_mem_add: out std_logic_vector(5 downto 0);
			  lvl_mem_data: in std_logic_vector(2 downto 0);
			  
			  --signaly pro pohyb
			  move: in std_logic;
			  reset: in std_logic;
			  ack: out std_logic;
			  
			  --signal znacici, ze zacala hra
			  game_on, finish:std_logic;
			  
			  --herni informace
			  lvl_1, lvl_10, stp_1, stp_10: in std_logic_vector(3 downto 0)
	);
end Grafika;

architecture Behavioral of Grafika is

	component vga_sync is
		Port ( clk : in  STD_LOGIC;
           h_sync, v_sync,video_on, frame_tick : out  STD_LOGIC;
           pixel_x, pixel_y : out  STD_LOGIC_VECTOR (10 downto 0));
	end component;

	component level_generator is
		Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			  pixx_offs, pixy_offs: out std_logic_vector(10 downto 0);
			  mem_add: out std_logic_vector(5 downto 0);
			  mem_data: in std_logic_vector(2 downto 0);
           clock: in  STD_LOGIC;
			  selected_object: out std_logic_vector(2 downto 0);
			  
			  start_pos, end_pos: std_logic_vector(7 downto 0);
			  move, reset : in  STD_LOGIC;
			  ack: out std_logic;
			  
			  obj_offs_x, obj_offs_y: out std_logic_vector(8 downto 0);
			  
			  game_on: in std_logic
			 
			  );
	end component;

	component object_generator is
		Port ( clk: std_logic;
			  sel: in std_logic_vector(2 downto 0);
           pixx, pixy : in  STD_LOGIC_VECTOR (10 downto 0);
           offset_x, offset_y : in  STD_LOGIC_VECTOR (8 downto 0);
			  --white_dots_en, 
			  obj_en: out std_logic;
			  color: out std_logic_vector(2 downto 0);
			  
			  --signaly pro pamet grafickou
				mem_data: in std_logic_vector(1 downto 0);
			  mem_read_enable: out std_logic;
			  mem_add_x: out std_logic_vector(11 downto 0);
			  mem_add_y: out std_logic_vector(3 downto 0)
			);
	end component;
	
	component graphic_rom is
    Port ( clock, we, en: in  STD_LOGIC;
				data_in: in std_logic_vector(1 downto 0);
           address_x1, address_x2: in  STD_LOGIC_VECTOR (11 downto 0);
			  address_y1, address_y2: in  STD_LOGIC_VECTOR (3 downto 0);
           data_out1, data_out2 : out  STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
	component gui_generator is
		Port ( pix_x, pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			 clk, game_on, finish : in STD_LOGIC;
			 lvl_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 lvl_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_jednotky : in STD_LOGIC_VECTOR (3 downto 0);
			 stp_desitky : in STD_LOGIC_VECTOR (3 downto 0);
			 
			obj_sel: out std_logic_vector(5 downto 0)
		);
	end component;
	
	component gui_decoder is
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
			 gui_en : out STD_LOGIC
			);
	end component;
	
	component arb_obj_gen is
    Port ( pix_x,pix_y : in  STD_LOGIC_VECTOR (10 downto 0);
			  clk, trigg_wf: in std_logic;
           color : out  STD_LOGIC_VECTOR (2 downto 0);
           en : out  STD_LOGIC);
	end component;

	component ROM_lett_num is
	Port ( clock, read_enable : in  STD_LOGIC;
           address_x: in  STD_LOGIC_VECTOR (5 downto 0);
			  address_y: in  STD_LOGIC_VECTOR (4 downto 0);
           data_out : out  STD_LOGIC_VECTOR (0 to 31));
	end component;

	--vnitrni signaly pro synchronizaci grafiky
	signal vid_on: std_logic := '0';
	signal pxx, pxy: std_logic_vector(10 downto 0) := (others => '0');
	signal color: std_logic_vector(2 downto 0);		--signal z multiplexeru do registru

	--signaly pro grafickou pamet
	signal gui_gen_addx, obj_gen_addx: std_logic_vector(11 downto 0) := (others => '0');
	signal gui_gen_addy, obj_gen_addy: std_logic_vector(3 downto 0) := (others => '0');
	signal graphic_mem_re, gui_gen_mem_re, obj_gen_mem_re: std_logic;
	signal gui_gen_mem_data, obj_gen_mem_data: std_logic_vector(1 downto 0);

	--offsety grafickych obejktu
	signal gr_offs_x, gr_offs_y: std_logic_vector(8 downto 0);

	--signaly pro rizeni generatoru objektu
	signal selected_object, obj_pic, gui_pic, white_frame:std_logic_vector(2 downto 0);

	--signaly pixelu s offsetem
	signal pixx_arena, pixy_arena: std_logic_vector(10 downto 0) := (others => '0');

	--signaly vystupniho multiplexeru
	signal graphics_enable, arb_gen_en, gui_en: std_logic;

	--signaly zpozdovaaci linky
	signal pixx_1, pixx_2: std_logic_vector(10 downto 0);
	signal pixx_3, pixx_4, pixx_5: std_logic_vector(10 downto 0);
	
	--signaly pameti pro vykreslovani gui(pamet pismen a cislic)
	signal LaN_add_x : STD_LOGIC_VECTOR (5 downto 0);
	signal LaN_add_y: STD_LOGIC_VECTOR (4 downto 0);
	signal LaN_re: std_logic;
	signal LaN_data: std_logic_vector(0 to 31);
	
	signal sel_gui_sprite: std_logic_vector(5 downto 0);

begin

	reg_color: process(clk) is			--vystupni registr barev
	begin
		if(rising_edge(clk)) then
			if(vid_on ='1') then
				R <= color(2);
				G <= color(1);
				B <= color(0);
			else
				R <= '0';
				G <= '0';
				B <= '0';
			end if;
		end if;
	end process;
	
	process(clk)				--zpozdovani GRAFIKY hry
	begin
		if(rising_edge(clk)) then
			pixx_3 <= pxx;
			pixx_4 <= pixx_3;
			pixx_5 <= pixx_4;
		end if;
	end process;

	process(clk)			--zpozdovani GUI
	begin
		if(rising_edge(clk)) then
			pixx_1 <= pixx_arena;
			pixx_2 <= pixx_1;
		end if;
	end process;
	
	--vystupni multiplexer grafickych objektu
	color <= white_frame when arb_gen_en = '1' else
				obj_pic when ((graphics_enable = '1') and (arb_gen_en = '0')) else
				gui_pic when gui_en = '1' else
				"000";	
	
	process(clk)
	begin
		if(rising_edge(clk)) then
		case(gui_en) is
			when '0' => 		--gui se nekresli
				graphic_mem_re <= obj_gen_mem_re;
			when '1' =>
				graphic_mem_re <= gui_gen_mem_re;
			when others =>
				graphic_mem_re <= '0';
		end case;
		end if;
	end process;
		
	info_generator: gui_generator
		port map(
			pix_x => pxx,
			pix_y => pxy,
			clk => clk,
			game_on => game_on,
			finish => finish,
			
			lvl_jednotky => lvl_1,
			lvl_desitky => lvl_10,
			stp_jednotky => stp_1,
			stp_desitky => stp_10,
			
			obj_sel => sel_gui_sprite
		);
			
	gui_sprite_decoder: gui_decoder
		port map(
			pix_x => pixx_5,
			pix_y => pxy,
			clk => clk,
			sel => sel_gui_sprite,
			
			mem_re1 => gui_gen_mem_re,
			address_x1 => gui_gen_addx,
			address_y1 => gui_gen_addy,
			mem_data_1 => gui_gen_mem_data,
			
			mem_re2 => LaN_re,
			address_x2 => LaN_add_x,
			address_y2 => LaN_add_y,
			mem_data_2 => LaN_data,
			
			color => gui_pic,
			gui_en => gui_en
		);
	
	letters_numbers_rom:ROM_lett_num
		port map(
			clock => clk,
			read_enable => LaN_re,
			address_x => LaN_add_x,
			address_y => LaN_add_y,
			data_out => LaN_data		
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
		  
		  mem_add => lvl_mem_add,
		  mem_data => lvl_mem_data,
		  
        clock => clk,
		  move => move,
		  reset => reset,					--reset automatu zabyvajicim se pohybem
		  ack => ack,
		  start_pos => start_pos,
		  end_pos => end_pos,
		  
		  obj_offs_x => gr_offs_x, 
		  obj_offs_y => gr_offs_y,
		  
		  game_on => game_on,
		  selected_object => selected_object
		);
				
	graphics_generator:object_generator
		port map(
			clk => clk,
			sel => selected_object,
			
         pixx => pixx_2,
			pixy => pixy_arena,
			
         offset_x => gr_offs_x,
			offset_y => gr_offs_y,
			
			obj_en => graphics_enable,
			
			mem_data => obj_gen_mem_data,
			mem_read_enable => obj_gen_mem_re,
			mem_add_x => obj_gen_addx,
			mem_add_y => obj_gen_addy,
			
			color => obj_pic
		);
		
	draw_white_frame: arb_obj_gen
		port map(
			pix_x => pxx,
			pix_y => pxy,
			clk => clk,
			trigg_wf => wf_en,
         color => white_frame,
			en => arb_gen_en		
		);
		
	sprite_rom:graphic_rom
		port map(
			clock => clk,
			en => graphic_mem_re,
			we => '0',
			data_in => "00",
			address_x1 => obj_gen_addx,
			address_y1 => obj_gen_addy,
			data_out1 => obj_gen_mem_data,
			address_x2 => gui_gen_addx,
			address_y2 => gui_gen_addy,
			data_out2 => gui_gen_mem_data
		);
			
end Behavioral;

