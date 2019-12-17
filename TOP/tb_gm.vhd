library ieee;
library work;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.bloky_pkg.all;
use work.ps2_pkg.all;

entity tb_gm is
end;

architecture testbench of tb_gm is

  component game is
      port  ( clk       : in  std_logic;
              keys      : in  t_keys;

              -- ram - cteni a zapis pohyblivych bloku
              rst_ram   : out std_logic;
              we_ram    : out std_logic;
              addr_ram  : out std_logic_vector(5 downto 0);
              w_ram     : out std_logic_vector(2 downto 0);
              r_ram     : in  std_logic_vector(2 downto 0);

              -- rom - rozmistneni levlu
              addr_rom  : out std_logic_vector(10 downto 0);
              r_rom     : in  std_logic_vector(2 downto 0);

              -- grafika
              gamemode  : out std_logic;
              fin       : out std_logic;
              lvl_10    : out std_logic_vector(3 downto 0);
              lvl_1     : out std_logic_vector(3 downto 0);
              tahy_10   : out std_logic_vector(3 downto 0);
              tahy_1    : out std_logic_vector(3 downto 0);
              start_pos : out std_logic_vector(7 downto 0);
              end_pos   : out std_logic_vector(7 downto 0);
              move      : out std_logic;
              ack       : in  std_logic
            );
  end component;

  component layout_rom is
    port  ( clk         : in  std_logic;
            addr_a      : in  std_logic_vector(10 downto 0);
            addr_b      : in  std_logic_vector(10 downto 0);
            data_out_a  : out std_logic_vector(2 downto 0);
            data_out_b  : out std_logic_vector(2 downto 0)
          );
  end component;

  component dynamic_ram is
    port  ( clk         : in  std_logic;
            rst         : in  std_logic;
            we          : in  std_logic;
            addr_a      : in  std_logic_vector(5 downto 0);
            addr_b      : in  std_logic_vector(5 downto 0);
            input_data  : in  std_logic_vector(2 downto 0);
            data_out_a  : out std_logic_vector(2 downto 0);
            data_out_b  : out std_logic_vector(2 downto 0)
          );
  end component;

  -- ps2
  signal keys             : t_keys;

  -- grafika
  signal gamemode         : std_logic;
  signal fin              : std_logic;
  signal lvl_des          : std_logic_vector(3 downto 0);
  signal lvl_jed          : std_logic_vector(3 downto 0);
  signal tahy_des         : std_logic_vector(3 downto 0);
  signal tahy_jed         : std_logic_vector(3 downto 0);
  signal start_pos        : std_logic_vector(7 downto 0);
  signal end_pos          : std_logic_vector(7 downto 0);
  signal move             : std_logic;
  signal ack              : std_logic;

  -- rom
  signal addr_a_rom       : std_logic_vector(10 downto 0);
  signal addr_b_rom       : std_logic_vector(10 downto 0);
  signal data_out_a_rom   : std_logic_vector(2 downto 0);
  signal data_out_b_rom   : std_logic_vector(2 downto 0);

  -- ram
  signal rst_ram          : std_logic;
  signal we_ram           : std_logic;
  signal addr_a_ram       : std_logic_vector(5 downto 0);
  signal addr_b_ram       : std_logic_vector(5 downto 0);
  signal input_data_ram   : std_logic_vector(2 downto 0);
  signal data_out_a_ram   : std_logic_vector(2 downto 0);
  signal data_out_b_ram   : std_logic_vector(2 downto 0);

  constant  clk_per : time := 20 ns;
  signal    clk     : std_logic;

begin

  dut : game
    port map  ( clk         => clk,
                keys        => keys,
                rst_ram     => rst_ram,
                we_ram      => we_ram,
                addr_ram    => addr_a_ram,
                w_ram       => input_data_ram,
                r_ram       => data_out_a_ram,
                addr_rom    => addr_a_rom,
                r_rom       => data_out_a_rom,
                gamemode    => gamemode,
                fin         => fin,
                lvl_10      => lvl_des,
                lvl_1       => lvl_jed,
                tahy_10     => tahy_des,
                tahy_1      => tahy_jed,
                start_pos   => start_pos,
                end_pos     => end_pos,
                move        => move,
                ack         => ack
              );

  level_layout : layout_rom
    port map  ( clk         => clk,
                addr_a      => addr_a_rom,
                addr_b      => addr_b_rom,
                data_out_a  => data_out_a_rom,
                data_out_b  => data_out_b_rom
              );

  level_dynamic : dynamic_ram
    port map  ( clk         => clk,
                rst         => rst_ram,
                we          => we_ram,
                addr_a      => addr_a_ram,
                addr_b      => addr_b_ram,
                input_data  => input_data_ram,
                data_out_a  => data_out_a_ram,
                data_out_b  => data_out_b_ram
              );

  clocking: process
  begin
    clk <= '0';
    wait for clk_per/2;
    clk <= '1';
    wait for clk_per/2;
  end process;

  stimulus: process

    -- testbench procedures

    procedure p_move ( constant smer : in  std_logic_vector (1 downto 0)) is
    begin
	 
		wait for clk_per*100;

      case smer is

        when c_smer_up =>
          report "procedure: move up";
          wait for clk_per;
          keys.up <= '1';
          wait for clk_per;
          keys.up <= '0';
          wait until move = '1';
          report "procedure: simulating VGA animation time (1000 ns)";
          wait for 1000 ns;
          ack <= '1';
          wait until move = '0';
          wait for clk_per;
          ack <= '0';
          report "procedure: waiting for ft_cnt counter to finish";
          wait for 1500000*clk_per;
          report "procedure: ft_cnt counter finished";


        when c_smer_down =>
          report "procedure: move down";
          wait for clk_per;
          keys.down <= '1';
          wait for clk_per;
          keys.down <= '0';
          wait until move = '1';
          report "procedure: simulating VGA animation time (1000 ns)";
          wait for 1000 ns;
          ack <= '1';
          wait until move = '0';
          wait for clk_per;
          ack <= '0';
          report "procedure: waiting for ft_cnt counter to finish";
          wait for 1500000*clk_per;
          report "procedure: ft_cnt counter finished";

        when c_smer_left =>
          report "procedure: move left";
          wait for clk_per;
          keys.left <= '1';
          wait for clk_per;
          keys.left <= '0';
          wait until move = '1';
          report "procedure: simulating VGA animation time (1000 ns)";
          wait for 1000 ns;
          ack <= '1';
          wait until move = '0';
          wait for clk_per;
          ack <= '0';
          report "procedure: waiting for ft_cnt counter to finish";
          wait for 1500000*clk_per;
          report "procedure: ft_cnt counter finished";

        when c_smer_right =>
          report "procedure: move right";
          wait for clk_per;
          keys.right <= '1';
          wait for clk_per;
          keys.right <= '0';
          wait until move = '1';
          report "procedure: simulating VGA animation time (1000 ns)";
          wait for 1000 ns;
          ack <= '1';
          wait until move = '0';
          wait for clk_per;
          ack <= '0';
          report "procedure: waiting for ft_cnt counter to finish";
          wait for 1500000*clk_per;
          report "procedure: ft_cnt counter finished";

        when others =>
          report "ERROR procedure: input smer unknown!";

        end case;

--         p_draw;

    end p_move;

    procedure p_keypress ( constant key : in  std_logic_vector(7 downto 0)) is
    begin
	 
		wait for clk_per*100;

      case key is

        when c_up =>
          report "procedure: keypress up";
          wait for clk_per;
          keys.up <= '1';
          wait for clk_per;
          keys.up <= '0';

        when c_down =>
          report "procedure: keypress down";
          wait for clk_per;
          keys.down <= '1';
          wait for clk_per;
          keys.down <= '0';

        when c_left =>
          report "procedure: keypress left";
          wait for clk_per;
          keys.left <= '1';
          wait for clk_per;
          keys.left <= '0';

        when c_right =>
          report "procedure: keypress right";
          wait for clk_per;
          keys.right <= '1';
          wait for clk_per;
          keys.right <= '0';

        when c_esc =>
          report "procedure: keypress esc";
          wait for clk_per;
          keys.esc <= '1';
          wait for clk_per;
          keys.esc <= '0';

        when c_enter =>
          report "procedure: keypress enter";
          wait for clk_per;
          keys.enter <= '1';
          wait for clk_per;
          keys.enter <= '0';

        when c_r =>
          report "procedure: keypress r";
          wait for clk_per;
          keys.r <= '1';
          wait for clk_per;
          keys.r <= '0';

        when others =>
          report "ERROR procedure: input key unknown!";

      end case;
    end p_keypress;

--     procedure p_draw is
--
--       type    ramtype is array (0 to 63) of std_logic_vector (2 downto 0);
--       alias   ram_map is <<signal level_dynamic.ram : ramtype >>;
--
--       variable level_map  : string(1 to 47) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
--       variable cnt_map    : integer := 0;
--
--     begin
--
--       wait for clk_per;
--
--       for i in 1 to 47 loop
--         if ((i rem 8) = 0) then
--           level_map(i) := LF;
--         else
--           case ram_map(cnt_map) is
--             when c_zem =>
--               level_map(i) := 'O';
--             when c_wal =>
--               level_map(i) := 'W';
--             when c_blk =>
--               level_map(i) := 'B';
--             when c_cil =>
--               level_map(i) := 'F';
--             when c_hrc =>
--               level_map(i) := 'H';
--             when others=>
--               report "procedure: draw others" severity error;
--           end case;
--           cnt_map := cnt_map + 1;
--         end if;
--       end loop;
--       report LF & level_map;
--     end p_draw;

    procedure p_move_blk is
    begin

      wait until move = '1';
      report "procedure: simulating VGA animation time (1000 ns)";
      wait for 1000 ns;
      ack <= '1';
      wait until move = '0';
      wait for clk_per;
      ack <= '0';
      report "procedure: waiting for ft_cnt counter to finish";
      wait for 1500000*clk_per;
      report "procedure: ft_cnt counter finished";

--       p_draw;

    end p_move_blk;

  begin

    -- procedury:
    --   p_move ( c_smer_up | c_smer_down | c_smer_left | c_smer_right )
    --     pohyb hracom v hre, procedura simuluje cas ktory potrebuje VGA na vykreslenie pohybu
    --     spolu s move a ack handshakom
    --
    --   p_keypress ( c_up | c_down | c_left | c_right | c_esc | c_enter | c_r )
    --     simuluje jednoduche stlacenie klavesy akoby prislo od PS2 RX bloku - nic viac
    --
    --   p_draw
    --     vykresli herne pole

    ack <= '0';

    keys.up     <= '0';
    keys.down   <= '0';
    keys.left   <= '0';
    keys.right  <= '0';
    keys.esc    <= '0';
    keys.enter  <= '0';
    keys.r      <= '0';

    addr_b_rom  <= (others => '0');
    addr_b_ram  <= (others => '0');
	 
	 wait for clk_per*1000;
	 report "START OF TESTBENCH";

    -- menu

	 report "TEST MAX 30 LEVELS";
	 for i in 1 to 35 loop
      p_keypress(c_up);
	 end loop;
	 -- lvl = 30?
	 assert (lvl_des = "0011") report "MAX LEVEL LIMIT FAILURE" severity failure;
	 assert (lvl_jed = "0000") report "MAX LEVEL LIMIT FAILURE" severity failure;
	 report "TEST MAX 30 LEVELS DONE";
	 

    report "TEST MIN 1 LEVEL";
	 for i in 1 to 35 loop
      p_keypress(c_down);
	 end loop;
	 -- lvl = 1?
	 assert (lvl_des = "0000") report "MAX LEVEL LIMIT FAILURE" severity failure;
	 assert (lvl_jed = "0001") report "MAX LEVEL LIMIT FAILURE" severity failure;
	 report "TEST MIN 1 LEVEL DONE";
	 

    -- enter level 1
    wait for clk_per*10;
    p_keypress(c_enter);

    -- wait until RAM inic
    wait for 1200 ns;
    report "LEVEL 1";
--     p_draw;

    -------------------------------- pohyb hraca
    p_move(c_smer_down);

    -- continue to level 2
    wait for clk_per*10;
	  assert (fin = '1') report "SHOULD BE FINISHED" severity failure;
	  wait for clk_per;
    p_keypress(c_enter);

    -- wait until RAM inic
    wait for 1200 ns;
    report "LEVEL 2";
--     p_draw;

    -------------------------------- pohyb hraca
    p_move(c_smer_up);
    p_move(c_smer_right);
    p_move(c_smer_down);
    p_move(c_smer_right);
	 
	 report "TEST MAX 99 MOVES";
	 for i in 1 to 60 loop
      p_move(c_smer_left);
      p_move(c_smer_right);
	 end loop;
	 -- tahy = 99?
	 assert (tahy_des = "1001") report "MAX TAHY LIMIT FAILURE" severity failure;
	 assert (tahy_jed = "1001") report "MAX TAHY LIMIT FAILURE" severity failure;
	 report "TEST MAX 99 MOVES DONE";
	 
    p_move(c_smer_up);
	 -- tahy = 99?
	 assert (tahy_des = "1001") report "MAX TAHY LIMIT FAILURE" severity failure;
	 assert (tahy_jed = "1001") report "MAX TAHY LIMIT FAILURE" severity failure;

    -- continue to level 3
    wait for clk_per*10;
	 assert (fin = '1') report "SHOULD BE FINISHED" severity failure;
	 wait for clk_per;
    p_keypress(c_enter);

    -- wait until RAM inic
    wait for 1200 ns;
    report "LEVEL 3";
--     p_draw;

    -------------------------------- pohyb hraca
    p_move(c_smer_down);
    p_move(c_smer_right);
    p_move(c_smer_up);
    p_move(c_smer_right);
    p_move(c_smer_down);
    p_move(c_smer_left);
    p_move(c_smer_up);
    p_move(c_smer_left);
    p_move(c_smer_down);

    -- continue to level 4
    wait for clk_per*10;
    assert (fin = '1') report "SHOULD BE FINISHED" severity failure;
    wait for clk_per;
    p_keypress(c_enter);
    
    -- wait until RAM inic
    wait for 1200 ns;
    report "LEVEL 4";
--     p_draw;

    -------------------------------- pohyb hraca
    p_move(c_smer_left);
    p_move_blk;
    p_move(c_smer_down);
    p_move_blk;

    report "RESET LVL 4";
    p_keypress(c_r);

    -- wait until RAM inic
    wait for 1200 ns;
    report "LEVEL 4";
--     p_draw;

  -------------------------------- pohyb hraca
    p_move(c_smer_left);
    p_move_blk;
    p_move(c_smer_down);
    p_move_blk;
    p_move(c_smer_left);
    p_move_blk;
    p_move(c_smer_down);

    wait for clk_per*10;
	 assert (fin = '1') report "SHOULD BE FINISHED" severity failure;
	 wait for clk_per;
    report "ESCAPE - BACK TO MENU";
    p_keypress(c_esc);
    wait for clk_per*100;

    -- menu

    -- select level 4
    p_keypress(c_down);
    -- select level 3
    p_keypress(c_down);
    -- select level 2
    p_keypress(c_down);
    -- select level 1
    p_keypress(c_down);

    -- enter level 1
    wait for clk_per*10;
    p_keypress(c_enter);

    -- wait until RAM inic
    wait for 1200 ns;
    report "LEVEL 1";
--     p_draw;

    -------------------------------- pohyb hraca

    report "ESCAPE - BACK TO MENU";
    wait for clk_per*100;
    p_keypress(c_esc);
    wait for clk_per*100;
	 
	 assert (gamemode = '0') report "GAMEMODE SHOULD BE 0" severity failure;
	 wait for clk_per;
	 report "TESTBENCH FINISHED SUCCESSFULLY";
	 report "TESTBENCH FINISHED SUCCESSFULLY";
	 report "TESTBENCH FINISHED SUCCESSFULLY";

    wait;
  end process;

end;
