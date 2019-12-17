library ieee;
library work;
use ieee.std_logic_1164.all;
use work.ps2_pkg.all;

entity top_ps2 is
    port  ( clk   : in  std_logic;
            ps2_c : in  std_logic;
            ps2_d : in  std_logic;
            keys  : out t_keys
          );
end top_ps2;

architecture behavioral of top_ps2 is

  component ps2_rx is
      port  ( ps2_c       : in  std_logic;
              ps2_d       : in  std_logic;
              clk         : in  std_logic;
              ps2_kod     : out std_logic_vector (7 downto 0);
              ps2_kod_rdy : out std_logic);
  end component;

  component ps2_decoder is
    port  ( ps2_kod     : in  std_logic_vector (7 downto 0);
            ps2_kod_rdy : in  std_logic;
            clk         : in  std_logic;
            keys        : out t_keys
          );
  end component;

  signal ps2_kod      : std_logic_vector (7 downto 0);
  signal ps2_kod_rdy  : std_logic;

begin

  ps2_receiver : ps2_rx
    port map  ( ps2_c => ps2_c,
                ps2_d => ps2_d,
                clk => clk,
                ps2_kod => ps2_kod,
                ps2_kod_rdy => ps2_kod_rdy
              );

  keycode_decoder : ps2_decoder
    port map  ( ps2_kod => ps2_kod,
                ps2_kod_rdy => ps2_kod_rdy,
                clk => clk,
                keys => keys
              );

end behavioral;
