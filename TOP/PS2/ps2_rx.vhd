library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ps2_pkg.all;

entity ps2_rx is
    port  ( ps2_c       : in  std_logic;
            ps2_d       : in  std_logic;
            clk         : in  std_logic;
            ps2_kod     : out std_logic_vector (7 downto 0);
            ps2_kod_rdy : out std_logic);
end ps2_rx;

architecture behavioral of ps2_rx is

  component enabler is
    port  ( vstup   : in std_logic;
            clk     : in std_logic;
            vystup  : out std_logic
          );
  end component;

  component clk_divider is
    generic ( hz_in   : positive;
              hz_out  : positive
            );
    port  (
            clk_in    : in  std_logic;
            clk_en    : out std_logic
          );
  end component;

  signal fsm          : t_fsm_ps2rx;
  signal ps2_cd       : std_logic;
  signal ps2_cce      : std_logic;
  signal clk_div_en   : std_logic;
  signal ps2_reg      : std_logic_vector (10 downto 0);

begin

-- ps2_c debouncer -------------------------------------------------------------

  fpga_clk_divider: clk_divider
    generic map ( hz_in => 50000000, -- 50 mhz
                  hz_out => 1000000  --  1 mhz
                )
    port map  ( clk_in => clk,
                clk_en => clk_div_en
              );

  process(clk, ps2_c, clk_div_en)

    variable ps2_cd_reg : std_logic_vector (3 downto 0) := "0000";

  begin
    if (rising_edge(clk)) then
      if(clk_div_en = '1') then
        ps2_cd_reg := ps2_c & ps2_cd_reg(3 downto 1);
        if(ps2_cd_reg = "1111") then
          ps2_cd <= '1';
        end if;
        if(ps2_cd_reg = "0000") then
          ps2_cd <= '0';
        end if;
      end if;
    end if;
  end process;

-- /ps2_c debouncer ------------------------------------------------------------

  ps2_c_falling_edge: enabler
    port map  ( vstup => ps2_cd,
                clk => clk,
                vystup => ps2_cce
              );

-- rx state machine ------------------------------------------------------------

  process (clk, ps2_d, ps2_cce)

    variable cnt    : integer := 0;
    variable parity : std_logic := '1';

  begin

    if(rising_edge(clk)) then
      case fsm is
		
        when idle =>
          cnt := 0;
          parity := '1';
          ps2_kod_rdy <= '0';
          if(ps2_cce = '1') then
            fsm <= tx;
          end if;
			 
        when ready =>
          if(ps2_cce = '1') then
            fsm <= tx;
          end if;
			 
        when tx =>
          ps2_reg(cnt) <= ps2_d;
          cnt := cnt + 1;
          if(cnt = 11) then
            fsm <= par;
          else
            fsm <= ready;
          end if;
			 
        when par =>
          if(ps2_reg(0) = '0') and (ps2_reg(10) = '1') then
            parity := parity xor ps2_reg(1)
                             xor ps2_reg(2)
                             xor ps2_reg(3)
                             xor ps2_reg(4)
                             xor ps2_reg(5)
                             xor ps2_reg(6)
                             xor ps2_reg(7)
                             xor ps2_reg(8);

            if(parity = ps2_reg(9)) then
              fsm <= done;
            end if;
          end if;
			 
        when done =>
          ps2_kod_rdy <= '1';
          ps2_kod <= ps2_reg (8 downto 1);
          fsm <= idle;
      end case;
    end if;

  end process;

-- /rx state machine -----------------------------------------------------------

end behavioral;
