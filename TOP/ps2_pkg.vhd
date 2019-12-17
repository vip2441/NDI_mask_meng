library ieee;

use ieee.std_logic_1164.all;

package ps2_pkg is

  constant  c_up    : std_logic_vector (7 downto 0) := "01110101";  -- 75
  constant  c_down  : std_logic_vector (7 downto 0) := "01110010";  -- 72
  constant  c_left  : std_logic_vector (7 downto 0) := "01101011";  -- 6b
  constant  c_right : std_logic_vector (7 downto 0) := "01110100";  -- 74
  constant  c_esc   : std_logic_vector (7 downto 0) := "01110110";  -- 76
  constant  c_enter : std_logic_vector (7 downto 0) := "01011010";  -- 5a
  constant  c_r     : std_logic_vector (7 downto 0) := "00101101";  -- 2d
  constant  c_f0    : std_logic_vector (7 downto 0) := "11110000";  -- f0
  constant  c_e0    : std_logic_vector (7 downto 0) := "11100000";  -- e0

  type t_keys is record
    up      : std_logic;
    down    : std_logic;
    left    : std_logic;
    right   : std_logic;
    esc     : std_logic;
    enter   : std_logic;
    r       : std_logic;
  end record t_keys;

  type t_fsm_ps2rx    is (idle, ready, tx, par, done);
  type t_fsm_dekoder  is (idle, throw_f0, tx_arrow, set_key);

end ps2_pkg;

package body ps2_pkg is

end ps2_pkg;
