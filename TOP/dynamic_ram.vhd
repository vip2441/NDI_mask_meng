library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.bloky_pkg.all;

entity dynamic_ram is
    port  ( clk         : in  std_logic;
            rst         : in  std_logic;
            we          : in  std_logic;
            addr_a      : in  std_logic_vector(5 downto 0);
            addr_b      : in  std_logic_vector(5 downto 0);
            input_data  : in  std_logic_vector(2 downto 0);
            data_out_a  : out std_logic_vector(2 downto 0);
            data_out_b  : out std_logic_vector(2 downto 0)
          );
end dynamic_ram;

architecture behavioral of dynamic_ram is

  type    ramtype is array (0 to 63) of std_logic_vector (2 downto 0);
  signal  ram : ramtype;

begin

  process(clk,rst) begin
    if (rst = '1') then
      ram <= (others => c_wal);
    elsif rising_edge(clk) then
      if(we ='1') then
        ram(to_integer(unsigned(addr_a))) <= input_data;
      end if;
    end if;
  end process;

  -- asynchronous read
  data_out_a <= ram(to_integer(unsigned(addr_a)));
  data_out_b <= ram(to_integer(unsigned(addr_b)));

end behavioral;

