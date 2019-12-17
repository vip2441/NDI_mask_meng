library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package bloky_pkg is

  constant c_zem : std_logic_vector(2 downto 0) := "000"; -- 0
  constant c_wal : std_logic_vector(2 downto 0) := "101"; -- 1
  constant c_blk : std_logic_vector(2 downto 0) := "110"; -- 2
  constant c_cil : std_logic_vector(2 downto 0) := "011"; -- 3
  constant c_hrc : std_logic_vector(2 downto 0) := "111"; -- 4

  constant c_smer_up     : std_logic_vector (1 downto 0) := "00";
  constant c_smer_down   : std_logic_vector (1 downto 0) := "01";
  constant c_smer_left   : std_logic_vector (1 downto 0) := "10";
  constant c_smer_right  : std_logic_vector (1 downto 0) := "11";

  constant c_pohyb_hrc   : unsigned (1 downto 0) := "11";
  constant c_pohyb_blk   : unsigned (1 downto 0) := "00";

end bloky_pkg;

package body bloky_pkg is

end bloky_pkg;
