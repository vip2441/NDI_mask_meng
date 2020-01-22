library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.bloky_pkg.all;

entity layout_rom is
    port  ( clk         : in  std_logic;
            addr_a      : in  std_logic_vector(10 downto 0);
            addr_b      : in  std_logic_vector(10 downto 0);
            data_out_a  : out std_logic_vector(2 downto 0);
            data_out_b  : out std_logic_vector(2 downto 0)
          );
end layout_rom;

architecture behavioral of layout_rom is

  type      rom_type is array(0 to 2046) of std_logic_vector(2 downto 0);
  constant  rom : rom_type := (

      -------------------------------------------------- level 1 (0-41)
      c_wal, c_wal, c_wal, c_wal, c_wal, c_wal, c_wal,
      c_wal, c_wal, c_wal, c_hrc, c_wal, c_wal, c_wal,
      c_wal, c_wal, c_wal, c_zem, c_wal, c_wal, c_wal,
      c_wal, c_wal, c_wal, c_zem, c_wal, c_wal, c_wal,
      c_wal, c_wal, c_wal, c_cil, c_wal, c_wal, c_wal,
      c_wal, c_wal, c_wal, c_wal, c_wal, c_wal, c_wal,

      -------------------------------------------------- level 2 (42-83)
      c_wal, c_wal, c_wal, c_wal, c_wal, c_wal, c_wal,
      c_wal, c_zem, c_zem, c_zem, c_wal, c_wal, c_wal,
      c_wal, c_zem, c_wal, c_zem, c_wal, c_cil, c_wal,
      c_wal, c_hrc, c_wal, c_zem, c_wal, c_zem, c_wal,
      c_wal, c_wal, c_wal, c_zem, c_zem, c_zem, c_wal,
      c_wal, c_wal, c_wal, c_wal, c_wal, c_wal, c_wal,

      -------------------------------------------------- level 3 (84-125)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_wal,
      c_cil, c_wal, c_wal, c_wal, c_zem, c_wal, c_wal,
      c_wal, c_wal, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_hrc, c_wal, c_zem, c_wal, c_zem, c_wal, c_zem,
      c_zem, c_wal, c_zem, c_wal, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_zem, c_wal, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 4 (126-167)
      c_zem, c_zem, c_zem, c_blk, c_zem, c_zem, c_hrc,
      c_wal, c_wal, c_wal, c_wal, c_zem, c_wal, c_wal,
      c_zem, c_blk, c_zem, c_zem, c_zem, c_wal, c_wal,
      c_wal, c_wal, c_zem, c_wal, c_blk, c_wal, c_wal,
      c_wal, c_wal, c_zem, c_wal, c_zem, c_wal, c_wal,
      c_wal, c_wal, c_cil, c_wal, c_zem, c_wal, c_wal,

      -------------------------------------------------- level 5 (168-209)
      c_wal, c_zem, c_zem, c_zem, c_zem, c_hrc, c_wal,
      c_zem, c_blk, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_cil, c_wal, c_zem, c_zem, c_zem, c_blk, c_zem,
      c_zem, c_wal, c_zem, c_zem, c_blk, c_zem, c_zem,
      c_zem, c_wal, c_wal, c_zem, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_wal,

      -------------------------------------------------- level 6 (210-251)
      c_zem, c_wal, c_cil, c_wal, c_hrc, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_blk, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_zem, c_zem, c_blk, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_zem,

      -------------------------------------------------- level 7 (252-293)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_cil, c_blk, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_hrc, c_zem, c_zem, c_zem, c_zem, c_wal, c_zem,

      -------------------------------------------------- level 8 (294-335)
      c_wal, c_zem, c_zem, c_zem, c_zem, c_zem, c_wal,
      c_zem, c_blk, c_zem, c_zem, c_zem, c_zem, c_wal,
      c_zem, c_zem, c_zem, c_zem, c_wal, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_cil, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_hrc, c_wal, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 9 (336-377)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_blk, c_zem, c_zem, c_zem, c_wal, c_zem,
      c_wal, c_cil, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_wal, c_zem, c_zem, c_blk, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_hrc, c_wal,

      -------------------------------------------------- level 10 (378-419)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_wal,
      c_hrc, c_zem, c_blk, c_zem, c_zem, c_zem, c_cil,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_zem, c_blk,
      c_blk, c_blk, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 11 (420-461)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_blk, c_cil, c_blk, c_zem, c_zem, c_wal,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_hrc, c_zem,
      c_zem, c_zem, c_wal, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 12 (462-503)
      c_zem, c_zem, c_hrc, c_wal, c_zem, c_zem, c_zem,
      c_blk, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_blk, c_zem, c_wal, c_zem,
      c_zem, c_wal, c_zem, c_wal, c_cil, c_wal, c_zem,
      c_zem, c_blk, c_zem, c_zem, c_blk, c_zem, c_zem,

      -------------------------------------------------- level 13 (504-545)
      c_hrc, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_blk, c_zem, c_zem, c_blk,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_cil, c_wal, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_blk, c_zem,

      -------------------------------------------------- level 14 (546-587)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_wal,
      c_blk, c_wal, c_zem, c_zem, c_zem, c_zem, c_cil,
      c_zem, c_zem, c_zem, c_blk, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_wal,
      c_zem, c_hrc, c_wal, c_zem, c_zem, c_zem, c_wal,

      -------------------------------------------------- level 15 (588-629)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_blk, c_zem, c_zem, c_zem, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_hrc, c_wal, c_cil, c_wal,

      -------------------------------------------------- level 16 (630-671)
      c_wal, c_blk, c_zem, c_blk, c_zem, c_blk, c_hrc,
      c_blk, c_zem, c_blk, c_zem, c_zem, c_blk, c_blk,
      c_blk, c_zem, c_zem, c_blk, c_blk, c_zem, c_zem,
      c_zem, c_zem, c_blk, c_zem, c_blk, c_blk, c_blk,
      c_zem, c_zem, c_blk, c_zem, c_blk, c_zem, c_blk,
      c_cil, c_blk, c_zem, c_blk, c_zem, c_blk, c_wal,

      -------------------------------------------------- level 17 (672-713)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_blk, c_zem,
      c_zem, c_wal, c_cil, c_wal, c_wal, c_zem, c_wal,
      c_zem, c_zem, c_zem, c_zem, c_wal, c_zem, c_wal,
      c_zem, c_zem, c_zem, c_blk, c_zem, c_zem, c_wal,
      c_hrc, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_blk, c_zem, c_wal,

      -------------------------------------------------- level 18 (714-755)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_hrc,
      c_zem, c_zem, c_zem, c_zem, c_blk, c_zem, c_zem,
      c_zem, c_wal, c_cil, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_wal,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 19 (756-797)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_hrc,
      c_zem, c_wal, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_wal, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_blk, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_wal,
      c_zem, c_wal, c_cil, c_wal, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 20 (798-839)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_blk, c_blk, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_cil, c_wal, c_wal, c_wal, c_zem, c_zem,
      c_wal, c_zem, c_wal, c_wal, c_wal, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_hrc, c_blk, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 21 (840-881)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_cil,
      c_hrc, c_zem, c_wal, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_wal, c_zem, c_wal, c_wal,
      c_zem, c_zem, c_blk, c_zem, c_blk, c_zem, c_zem,
      c_wal, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 22 (882-923)
      c_wal, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_zem, c_wal, c_wal, c_wal, c_wal, c_zem,
      c_cil, c_blk, c_zem, c_zem, c_blk, c_zem, c_hrc,
      c_wal, c_zem, c_wal, c_blk, c_wal, c_wal, c_zem,
      c_wal, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_zem, c_zem, c_wal, c_zem, c_zem, c_wal,

      -------------------------------------------------- level 23(924-965)
      c_wal, c_wal, c_zem, c_zem, c_zem, c_zem, c_hrc,
      c_wal, c_wal, c_blk, c_zem, c_blk, c_zem, c_zem,
      c_wal, c_wal, c_cil, c_wal, c_zem, c_wal, c_zem,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_blk, c_wal, c_zem, c_blk, c_zem, c_zem,
      c_wal, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 24 (966-1007)
      c_zem, c_wal, c_wal, c_wal, c_zem, c_zem, c_zem,
      c_zem, c_blk, c_zem, c_cil, c_blk, c_zem, c_zem,
      c_blk, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_blk, c_zem, c_blk, c_wal,
      c_blk, c_zem, c_blk, c_hrc, c_wal, c_zem, c_wal,
      c_zem, c_zem, c_zem, c_blk, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 25 (1008-1049)
      c_zem, c_zem, c_zem, c_cil, c_zem, c_zem, c_zem,
      c_blk, c_blk, c_blk, c_blk, c_blk, c_blk, c_blk,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_zem, c_zem, c_zem, c_wal, c_zem, c_zem,
      c_zem, c_zem, c_wal, c_zem, c_zem, c_hrc, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 26 (1050-1091)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_wal, c_cil, c_wal, c_wal, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_blk, c_wal, c_zem, c_zem, c_blk, c_blk,
      c_blk, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_hrc, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 27 (1092-1133)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_blk, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_blk, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_blk, c_zem, c_zem, c_zem, c_cil, c_wal, c_zem,
      c_zem, c_zem, c_zem, c_hrc, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 28 (1134-1175)
      c_zem, c_blk, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_wal, c_zem, c_blk, c_zem, c_cil, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_wal, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_hrc, c_wal, c_zem,
      c_wal, c_zem, c_zem, c_zem, c_blk, c_zem, c_zem,

      -------------------------------------------------- level 29 (1176-1217)
      c_wal, c_zem, c_wal, c_wal, c_zem, c_zem, c_wal,
      c_wal, c_zem, c_zem, c_zem, c_zem, c_zem, c_cil,
      c_zem, c_zem, c_wal, c_wal, c_zem, c_zem, c_wal,
      c_zem, c_zem, c_blk, c_hrc, c_blk, c_zem, c_zem,
      c_zem, c_blk, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,

      -------------------------------------------------- level 30 (1218-1259)
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_blk, c_blk, c_zem, c_zem,
      c_hrc, c_wal, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_cil, c_zem, c_zem, c_zem, c_zem, c_zem,
      c_zem, c_zem, c_zem, c_zem, c_zem, c_wal, c_zem,

      others => (others => '0')

    );

begin

	process(clk)				--pridal jsem zde proces, Vlada
	begin
		if(rising_edge(clk)) then
			data_out_a <= rom(to_integer(unsigned(addr_a)));
			data_out_b <= rom(to_integer(unsigned(addr_b)));
		end if;
	end process;
	
end behavioral;
