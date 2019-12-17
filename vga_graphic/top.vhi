
-- VHDL Instantiation Created from source file top.vhd -- 16:45:38 12/13/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT top
	PORT(
		clk : IN std_logic;
		move : IN std_logic;
		reset : IN std_logic;
		game_on : IN std_logic;          
		HS : OUT std_logic;
		VS : OUT std_logic;
		R : OUT std_logic;
		G : OUT std_logic;
		B : OUT std_logic;
		frame_tick : OUT std_logic;
		ack : OUT std_logic
		);
	END COMPONENT;

	Inst_top: top PORT MAP(
		clk => ,
		HS => ,
		VS => ,
		R => ,
		G => ,
		B => ,
		frame_tick => ,
		move => ,
		reset => ,
		ack => ,
		game_on => 
	);


