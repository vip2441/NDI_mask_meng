library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity decoder_to_BCD is
  generic (
    g_input_width    : in positive;
    g_decimal_digits : in positive
    );
  port (
    clk        : in std_logic;
    bcd_start  : in std_logic;
    binary_in  : in std_logic_vector(g_input_width-1 downto 0);
     
    bcd_out   : out std_logic_vector(g_decimal_digits*4-1 downto 0);
    bcd_done  : out std_logic
    );
end entity decoder_to_BCD;
 
architecture rtl of decoder_to_BCD is
 
  type t_fsm_bcd is (s_idle, s_shift, s_check_shift_index, s_add, s_check_digit_index, s_bcd_done);
  signal fsm_bcd : t_fsm_bcd := s_idle;
 
  -- The vector that contains the output BCD
  signal bcd_out_s : std_logic_vector(g_decimal_digits*4-1 downto 0) := (others => '0');
 
  -- The vector that contains the input binary_in value being shifted.
  signal binary_in_s : std_logic_vector(g_input_width-1 downto 0) := (others => '0');
   
  -- Keeps track of which Decimal Digit we are indexing
  signal digit_idx : natural range 0 to g_decimal_digits-1 := 0;
 
  -- Keeps track of which loop iteration we are on.
  -- Number of loops performed = g_input_width
  signal loop_count : natural range 0 to g_input_width-1  := 0;
   
begin
 
  double_dabble : process (clk)
    variable upper     : natural;
    variable lower     : natural;
    variable bcd_digit : unsigned(3 downto 0);
  begin
    if rising_edge(clk) then
 
      case fsm_bcd is
 
        -- Stay in this state until bcd_start comes along
        when s_idle =>
          if bcd_start = '1' then
            bcd_out_s    <= (others => '0');
            binary_in_s  <= binary_in;
            fsm_bcd      <= s_shift;
          else
            fsm_bcd <= s_idle;
          end if;
 
        -- Always shift the BCD Vector until we have shifted all bits through
        -- Shift the most significant bit of binary_in_s into bcd_out_s lowest bit.
        when s_shift =>
          bcd_out_s    <= bcd_out_s(bcd_out_s'left-1 downto 0) & binary_in_s(binary_in_s'left);
          binary_in_s  <= binary_in_s(binary_in_s'left-1 downto 0) & '0';
          fsm_bcd      <= s_check_shift_index;
 
        -- Check if we are done with shifting in binary_in_s vector
        when s_check_shift_index => 
          if loop_count = g_input_width-1 then
            loop_count <= 0;
            fsm_bcd    <= s_bcd_done;
          else
            loop_count <= loop_count + 1;
            fsm_bcd    <= s_add;
          end if;
 
        -- Break down each BCD Digit individually.  Check them one-by-one to
        -- see if they are greater than 4.  If they are, increment by 3.
        -- Put the result back into bcd_out_s Vector.  Note that bcd_digit is
        -- unsigned.  Numeric_std does not perform math on std_logic_vector.
        when s_add =>
          upper     := digit_idx*4 + 3;
          lower     := digit_idx*4;
          bcd_digit := unsigned(bcd_out_s(upper downto lower));
           
          if bcd_digit > 4 then
            bcd_digit := bcd_digit + 3;
          end if;
 
          bcd_out_s(upper downto lower) <= std_logic_vector(bcd_digit);
          fsm_bcd <= s_check_digit_index;
 
        -- Check if we are done incrementing all of the BCD Digits
        when s_check_digit_index =>
          if digit_idx = g_decimal_digits-1 then
            digit_idx  <= 0;
            fsm_bcd    <= s_shift;
          else
            digit_idx  <= digit_idx + 1;
            fsm_bcd    <= s_add;
          end if;
 
        when s_bcd_done =>
          fsm_bcd <= s_idle;
 
        when others =>
          fsm_bcd <= s_idle;
           
      end case;
    end if; -- rising_edge(clk)
  end process double_dabble;
 
  bcd_done  <= '1' when fsm_bcd = s_bcd_done else '0';
  bcd_out   <= bcd_out_s;
   
end architecture rtl;
