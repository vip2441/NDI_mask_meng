library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity clk_divider is
  generic ( hz_in   : positive := 100000000;
            hz_out  : positive
          );
  port  ( clk_in    : in    std_logic;
          clk_en    : out   std_logic
        );
end clk_divider;

architecture behavioral of clk_divider is

  signal counter  : natural range 0 to (hz_in/hz_out) := 0;

begin

    process (clk_in)
      begin
        if rising_edge(clk_in) then

          if counter = (hz_in/hz_out) then
            counter <= 0;
          else
            counter <= counter + 1;
          end if;

          if counter = ((hz_in/hz_out)-1) then
            clk_en <= '1';
          else
            clk_en <= '0';
          end if;

        end if;
      end process;

end behavioral;
