-- double dabble algorithm
-- usable for numbers 0-99 encoded in binary vector 7 downto 0
-- result returned as two BCD digits combined in one binary vector 7 downto 0 [tens & ones]

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_to_bcd is
  port  ( clk       : in  std_logic;
          binary    : in  std_logic_vector(7 downto 0);
          bcd_2     : out std_logic_vector(7 downto 0);
          bcd_done  : out std_logic
      );
end binary_to_bcd;

architecture rtl of binary_to_bcd is

  type t_fsm_dd is (init, assign, shift);
  signal fsm_dd : t_fsm_dd := init;

  -- registers
  --
  -- combined:
  -- tens ones binary
  -- 0000 0000 00000000
  -- 15   11   7      0

  signal r_combined     : std_logic_vector(15 downto 0) := (others => '0');
  signal r_ones_next    : std_logic_vector(3 downto 0)  := (others => '0');
  signal r_tens_next    : std_logic_vector(3 downto 0)  := (others => '0');
  signal r_counter      : std_logic_vector(3 downto 0)  := (others => '0');
  signal r_counter_next : std_logic_vector(3 downto 0)  := (others => '0');
  
begin

  -------------------------------------------------------------------------- rtl
  
  process(clk)
  begin
    if rising_edge(clk) then
      
      r_combined  <= r_combined;
      r_counter   <= r_counter;
      fsm_dd      <= fsm_dd;
      bcd_done    <= '0';
      
      case fsm_dd is
      
        when init =>
          -- reset and capture input
          r_combined(15 downto 8) <= (others => '0');
          r_combined(7 downto 0)  <= binary;
          -- reset counter
          r_counter <= "0001";
          
          fsm_dd <= assign;
          
        when assign =>
          -- assign next values
          r_combined(11 downto 8)   <= r_ones_next;
          r_combined(15 downto 12)  <= r_tens_next;
          
          fsm_dd <= shift;
          
        when shift =>
          -- shift left 1 bit
          r_combined <= r_combined(14 downto 0) & '0';
          
          if (unsigned(r_counter) >= 8) then
            -- algorithm done
            bcd_done  <= '1';
            fsm_dd    <= init;
          else
            r_counter <= r_counter_next;
            fsm_dd    <= assign;
          end if;
        
        when others =>
          -- reset FSM
          fsm_dd <= init;
        
      end case;
    end if;
  end process;
  
  ---------------------------------------------------------- combinational logic
  
  -- shift counter
  r_counter_next <= std_logic_vector(unsigned(r_counter) + 1);
  
  -- BCD next value
  process(r_combined)
  begin
  
    r_ones_next <= r_combined(11 downto 8);
    r_tens_next <= r_combined(15 downto 12);
    
    if (unsigned(r_combined(11 downto 8)) > 4) then
      r_ones_next <= std_logic_vector(unsigned(r_combined(11 downto 8)) + 3);
    end if;
    if (unsigned(r_combined(15 downto 12)) > 4) then
      r_tens_next <= std_logic_vector(unsigned(r_combined(15 downto 12)) + 3);
    end if;
    
  end process;
  
  -- output assigment
  bcd_2 <= r_combined(15 downto 8);
    
end rtl;