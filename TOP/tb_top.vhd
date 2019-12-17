library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.bloky_pkg.all;
use work.ps2_pkg.all;

entity tb_top is
end;

architecture testbench of tb_top is

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

  component grafika is
    port  ( clk         : in  std_logic;
            hs,vs       : out std_logic;
            r,g,b       : out std_logic;

            --GM
            start_pos   : in  std_logic_vector(7 downto 0);
            end_pos     : in  std_logic_vector(7 downto 0);

            --pamet usporadani levelu
            lvl_mem_add   : out std_logic_vector(5 downto 0);
            lvl_mem_data  : in  std_logic_vector(2 downto 0);

            --signaly pro pohyb
            move    : in  std_logic;
            reset   : in  std_logic;
            ack     : out std_logic;

            --signal znacici, ze zacala hra
            game_on : std_logic;
				finish  : std_logic;

            --herni informace
            lvl_1, lvl_10   : in std_logic_vector(3 downto 0);
            stp_1, stp_10   : in std_logic_vector(3 downto 0)
          );
  end component;

  -- top
  signal reset       : std_logic;
  signal hs,vs       : std_logic;
  signal r,g,b       : std_logic;

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

  game_mechanics : game
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

  graphics : grafika
    port map  ( clk           => clk,
                hs            => hs,
                vs            => vs,
                r             => r,
                g             => g,
                b             => b,
                start_pos     => start_pos,
                end_pos       => end_pos,
                lvl_mem_add   => addr_b_ram,
                lvl_mem_data  => data_out_b_ram,
                move          => move,
                reset         => reset,
                ack           => ack,
                game_on       => gamemode,
					 finish        => fin,
                lvl_1         => lvl_jed,
                lvl_10        => lvl_des,
                stp_1         => tahy_jed,
                stp_10        => tahy_des
              );
  
  clocking: process
  begin
    clk <= '0';
    wait for clk_per/2;
    clk <= '1';
    wait for clk_per/2;
  end process;

  stimulus: process

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

  begin
  
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
    
	 p_keypress(c_up);
	 wait for clk_per*1000;
	 p_keypress(c_up);
	 wait for clk_per*1000;
	 p_keypress(c_up);
	 wait for clk_per*1000;
    -- start lvl 4
    p_keypress(c_enter);
    wait for clk_per*1000;
    p_keypress(c_left);

    wait;
  end process;

end;
