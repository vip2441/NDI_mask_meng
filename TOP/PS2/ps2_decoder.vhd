library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ps2_pkg.all;

entity ps2_decoder is
    port  ( ps2_kod     : in  std_logic_vector (7 downto 0);
            ps2_kod_rdy : in  std_logic;
            clk         : in  std_logic;
            keys        : out t_keys
          );
end ps2_decoder;

architecture behavioral of ps2_decoder is

signal  fsm   : t_fsm_dekoder;

begin

  process(clk, ps2_kod_rdy, ps2_kod)
  begin
    if (rising_edge(clk)) then
      case fsm is

        when idle =>
          keys.up     <= '0';
          keys.down   <= '0';
          keys.left   <= '0';
          keys.right  <= '0';
          keys.esc    <= '0';
          keys.enter  <= '0';
          keys.r      <= '0';

          if(ps2_kod_rdy = '1') then
            if(ps2_kod = c_f0) then
              fsm <= throw_f0;
            elsif(ps2_kod = c_e0) then -- arrow 1st byte
              fsm <= tx_arrow;
            else
              fsm <= set_key;
            end if;
          end if;

        when throw_f0 =>
          if(ps2_kod_rdy = '1') then
            fsm <= idle;
          end if;

        when tx_arrow =>
          if(ps2_kod_rdy = '1') then
            if(ps2_kod = c_f0) then
              fsm <= throw_f0;
            else
              fsm <= set_key;
            end if;
          end if;

        when set_key =>
          case ps2_kod is

            when c_up =>
              keys.up <= '1';

            when c_down =>
              keys.down <= '1';

            when c_left =>
              keys.left <= '1';

            when c_right =>
              keys.right <= '1';

            when c_esc =>
              keys.esc <= '1';

            when c_enter =>
              keys.enter <= '1';

            when c_r =>
              keys.r <= '1';

            when others =>

          end case;
          fsm <= idle;

      end case;
    end if;
  end process;
end behavioral;
