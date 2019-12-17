library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- fallsing edge on signal vstup detector --------------------------------------

entity enabler is
  port  ( vstup   : in  std_logic;
          clk     : in  std_logic;
          vystup  : out std_logic
        );
end enabler;

architecture behavioral of enabler is

  signal q        : std_logic;
  signal xor_out  : std_logic;
  signal and_out  : std_logic;

begin

  process (clk,vstup,and_out)
    begin
      if (rising_edge(clk)) then
        q <= vstup;
        vystup <= and_out;
      end if;
    end process;

  xor_out <= vstup xor q;
  and_out <= xor_out and not(vstup);

end behavioral;
