library ieee;
library work;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.bloky_pkg.all;
use work.ps2_pkg.all;

entity game is
    port  ( clk       : in  std_logic;
            keys      : in  t_keys;

            -- ram - cteni a zapis pohyblivych bloku
            rst_ram   : out std_logic;
            we_ram    : out std_logic;
            addr_ram  : out std_logic_vector(5 downto 0);
            w_ram     : out std_logic_vector(2 downto 0);
            r_ram     : in  std_logic_vector(2 downto 0);

            -- rom - rozmistneni levlu
            addr_rom  : out std_logic_vector(10 downto 0);
            r_rom     : in  std_logic_vector(2 downto 0);

            -- grafika
            gamemode  : out std_logic;
            fin       : out std_logic;
            lvl_10    : out std_logic_vector(3 downto 0);
            lvl_1     : out std_logic_vector(3 downto 0);
            tahy_10   : out std_logic_vector(3 downto 0);
            tahy_1    : out std_logic_vector(3 downto 0);
            start_pos : out std_logic_vector(7 downto 0);
            end_pos   : out std_logic_vector(7 downto 0);
            move      : out std_logic;
            ack       : in  std_logic
          );
end game;

architecture behavioral of game is

  component decoder_to_BCD is
    generic  ( g_input_width    : in positive;
               g_decimal_digits : in positive
             );
    port  ( clk        : in  std_logic;
            bcd_start  : in  std_logic;
            binary_in  : in  std_logic_vector(g_input_width-1 downto 0);       
            bcd_out    : out std_logic_vector(g_decimal_digits*4-1 downto 0);
            bcd_done   : out std_logic
      );
  end component;

  -- prochazeni hrou
  type  t_fsm_notgm is (menu, inic, vyhledani_cile, hra, finish);
  -- herní logika
  type  t_fsm_gm    is (stoji, vyhledani_hrace, cekani_ack_re, cekani_ack_fe, aktualizace_ram_end,
                        aktualizace_ram_start, skenovani, kontrola, zed_x_blok);

  signal fsm_notgm     : t_fsm_notgm := menu;
  signal fsm_gm        : t_fsm_gm    := stoji;

  signal finished      : std_logic := '0';            -- priznak vytezstvi
  signal gamemode_s    : std_logic := '0';            -- priznak aktivnej hry (nie menu)
  signal lvl_int       : natural range 0 to 30 := 1;
  signal lvl           : std_logic_vector(7 downto 0);
  signal lvl_101       : std_logic_vector(7 downto 0);
  signal lvl_bcd_start : std_logic;
  signal lvl_bcd_done  : std_logic;

  signal addr_ram_s    : std_logic_vector(5 downto 0)  := (others => '0');
  signal w_ram_s       : std_logic_vector(2 downto 0)  := (others => '0');
  signal addr_rom_s    : std_logic_vector(10 downto 0) := (others => '0');

  -- grafika
  signal start_pos_s   : std_logic_vector(7 downto 0) := (others => '0');
  signal end_pos_s     : std_logic_vector(7 downto 0) := (others => '0');
  signal move_s        : std_logic := '0';

  signal tahy_int       : integer := 0;
  signal tahy           : std_logic_vector(7 downto 0);
  signal tahy_101       : std_logic_vector(7 downto 0);
  signal tahy_bcd_start : std_logic;
  signal tahy_bcd_done  : std_logic;

begin

  fsm : process (clk)

    -- citac poli v pameti rom pri prevod do ram
    variable cnt_layout_rom : natural range 0 to 50 := 0;

    -- smer pohybujuceho sa bloku
    variable smer           : std_logic_vector (1 downto 0) := c_smer_up;

    -- vyruseni dvojiteho narazu kamenu
    variable cnt_1_bit      : natural range 0 to 1 := 0;

    -- souradnice x,y pro pohyb pro grafiku
    variable start_x        : unsigned (2 downto 0)   := (others => '0');
    variable start_y        : unsigned (2 downto 0)   := (others => '0');
    variable end_x          : unsigned (2 downto 0)   := (others => '0');
    variable end_y          : unsigned (2 downto 0)   := (others => '0');
    variable cil_x          : unsigned (2 downto 0)   := (others => '0');
    variable cil_y          : unsigned (2 downto 0)   := (others => '0');
    variable radek          : unsigned (2 downto 0)   := (others => '0');
    variable radek_old      : unsigned (2 downto 0)   := (others => '0');

    -- id bloku ktory sa hybe pre grafiku
    variable pohyb_blok     : unsigned (1 downto 0) := c_pohyb_hrc;

    variable addr_ram_v     : unsigned (5 downto 0) := (others => '0');
    variable addr_ram_v_old : unsigned (5 downto 0) := (others => '0');

  begin

    if(rising_edge(clk)) then

      -- default hodnoty
        rst_ram         <= '0';   -- neresetuje se ram
        we_ram          <= '0';   -- write enable ram
        move_s          <= '0';

        fsm_notgm       <= fsm_notgm;
        fsm_gm          <= fsm_gm;
        finished        <= finished;
        gamemode_s      <= gamemode_s;
        lvl_int         <= lvl_int;
        addr_ram_s      <= addr_ram_s;
        w_ram_s         <= w_ram_s;
        addr_rom_s      <= addr_rom_s;
        start_pos_s     <= start_pos_s;
        end_pos_s       <= end_pos_s;
        tahy_int        <= tahy_int;

        cnt_layout_rom  := cnt_layout_rom;
        smer            := smer;
        cnt_1_bit       := cnt_1_bit;
        start_x         := start_x;
        start_y         := start_y;
        cil_x           := cil_x;
        cil_y           := cil_y;
        end_x           := end_x;
        end_y           := end_y;
        pohyb_blok      := pohyb_blok;
        addr_ram_v      := addr_ram_v;
        addr_ram_v_old  := addr_ram_v_old;


      case fsm_notgm is

        -- vyber levelu pomoci sipek a potvrzeni entrem
        when menu =>

          gamemode_s      <= '0';     -- povel grafice, ze jsme v menu
          finished        <= '0';
          tahy_int        <= 0;
          cnt_layout_rom  := 0;

          if(keys.up = '1') then      -- zvysovani levelu
            if(lvl_int < 30) then
              lvl_int <= lvl_int + 1;
            end if;
          end if;

          if(keys.down = '1') then    -- snizovani levelu
            if(lvl_int > 1) then
              lvl_int <= lvl_int - 1;
            end if;
          end if;

          if(keys.enter = '1') then
            rst_ram <= '1';       -- reser ram pred nahranim dat z rom
            fsm_notgm <= inic;
          end if;

        -- nacteni levelu z rom do ram
        when inic =>

          tahy_int <= 0;

          -- *42 je posun v pameti k dalsimu levelu
          addr_rom_s <= std_logic_vector(to_unsigned(cnt_layout_rom + ((lvl_int - 1) * 42),addr_rom_s'length));

          if(cnt_layout_rom > 0) then
            we_ram      <= '1';    -- povolenie zapisu do ram
            w_ram_s     <= r_rom;
            addr_ram_s  <= std_logic_vector(to_unsigned((cnt_layout_rom - 1),addr_ram_s'length));
          end if;

          -- precteni vsech bloku (zapis o jeden clk opozden)
          if(cnt_layout_rom = 42) then
            addr_ram_v  := (others => '0');
            fsm_notgm   <= vyhledani_cile;
          else
            cnt_layout_rom := cnt_layout_rom + 1;
          end if;
			 
			 
			 
		  when vyhledani_cile =>

                addr_ram_s <= std_logic_vector(addr_ram_v);
                if(addr_ram_v > 0) then
                  if(r_ram = c_cil) then

                    -- dekoder souradnic z adresy ram a ulozeni do cil x,y
                    -- \_{°-°}_/

                    if((addr_ram_v - 1) < 7) then
                      cil_x := to_unsigned(to_integer(addr_ram_v - 1),3);
                      cil_y := to_unsigned(0,3);
                    elsif((addr_ram_v - 1) < 14) then
                      cil_x := to_unsigned(to_integer(addr_ram_v - 8),3);
                      cil_y := to_unsigned(1,3);
                    elsif((addr_ram_v - 1) < 21) then
                      cil_x := to_unsigned(to_integer(addr_ram_v - 15),3);
                      cil_y := to_unsigned(2,3);
                    elsif((addr_ram_v - 1) < 28) then
                      cil_x := to_unsigned(to_integer(addr_ram_v - 22),3);
                      cil_y := to_unsigned(3,3);
                    elsif((addr_ram_v - 1) < 35) then
                      cil_x := to_unsigned(to_integer(addr_ram_v - 29),3);
                      cil_y := to_unsigned(4,3);
                    elsif((addr_ram_v - 1) < 42) then
                      cil_x := to_unsigned(to_integer(addr_ram_v - 36),3);
                      cil_y := to_unsigned(5,3);
                    end if;

                    gamemode_s  <= '1'; --signal grafice, ze jsme ve hre
                    fsm_notgm <= hra;
                  
                  end if;
                end if;

                addr_ram_v := addr_ram_v + 1;
					 
					 

        when hra =>

          cnt_layout_rom := 0;

          if(keys.r = '1' and fsm_gm /= cekani_ack_re and fsm_gm /= cekani_ack_fe) then
            rst_ram   <= '1';
            fsm_notgm <= inic;
            fsm_gm    <= stoji;
          elsif(keys.esc = '1') then
            fsm_notgm <= menu;
            fsm_gm    <= stoji;
          else

  -----------------------------------------------------------------------------

            case fsm_gm is

              when stoji =>

                cnt_1_bit   := 0;
                addr_ram_v  := (others => '0');
                fsm_gm      <= vyhledani_hrace; -- moze sa vyrusit nizsie

                if(tahy_int < 99) then
                  tahy_int <= tahy_int + 1;
                end if;

                if(keys.up = '1') then
                  smer := c_smer_up;
                elsif(keys.down = '1') then
                  smer := c_smer_down;
                elsif(keys.left = '1') then
                  smer := c_smer_left;
                elsif(keys.right = '1') then
                  smer := c_smer_right;
                else
                  fsm_gm    <= stoji;     -- pokud se nic nezmacke hrac zustava v modu stoji
                  tahy_int  <= tahy_int;  -- pokial sa nic nestlaci ostava rovnaky
                end if;

              when vyhledani_hrace =>

                addr_ram_s <= std_logic_vector(addr_ram_v);
                if(addr_ram_v > 0) then
                  if(r_ram = c_hrc) then

                    -- dekoder souradnic z adresy ram a ulozeni do start x,y
                    -- \_{°-°}_/

                    if((addr_ram_v - 1) < 7) then
                      start_x := to_unsigned(to_integer(addr_ram_v - 1),3);
                      start_y := to_unsigned(0,3);
                    elsif((addr_ram_v - 1) < 14) then
                      start_x := to_unsigned(to_integer(addr_ram_v - 8),3);
                      start_y := to_unsigned(1,3);
                    elsif((addr_ram_v - 1) < 21) then
                      start_x := to_unsigned(to_integer(addr_ram_v - 15),3);
                      start_y := to_unsigned(2,3);
                    elsif((addr_ram_v - 1) < 28) then
                      start_x := to_unsigned(to_integer(addr_ram_v - 22),3);
                      start_y := to_unsigned(3,3);
                    elsif((addr_ram_v - 1) < 35) then
                      start_x := to_unsigned(to_integer(addr_ram_v - 29),3);
                      start_y := to_unsigned(4,3);
                    elsif((addr_ram_v - 1) < 42) then
                      start_x := to_unsigned(to_integer(addr_ram_v - 36),3);
                      start_y := to_unsigned(5,3);
                    end if;

                    addr_ram_v := addr_ram_v - 2;  -- adresa na ktere je hrac
                    fsm_gm <= skenovani;
                  
                  end if;
                end if;

                addr_ram_v := addr_ram_v + 1;

              when skenovani =>  -- jeden virtualni krok pohybu

                addr_ram_v_old := addr_ram_v; -- aktualna pozice hrace/bloku pred skokem o policko

                case smer is

                  when c_smer_up =>
                    addr_ram_v := addr_ram_v - 7;

                  when c_smer_down =>
                    addr_ram_v := addr_ram_v + 7;

                  when c_smer_left =>
                    addr_ram_v := addr_ram_v - 1;

                  when others => -- right
                    addr_ram_v := addr_ram_v + 1;

                end case;

                -- nasledujici adresa ve smeru pohybu
                addr_ram_s <= std_logic_vector(addr_ram_v);

                fsm_gm <= kontrola; -- cakame na synchronny vystup ram

              when kontrola =>

                if(cnt_1_bit = 0) then
                  pohyb_blok := c_pohyb_hrc;
                else
                  pohyb_blok := c_pohyb_blk;
                end if;

               -- pokial sa pohybujeme v riadku
                if(smer = c_smer_left or smer = c_smer_right) then

                  -- kontrola pretecenia riadku
                  if(addr_ram_v_old < 7) then
                    radek_old := to_unsigned(0,3);
                  elsif(addr_ram_v_old < 14) then
                    radek_old := to_unsigned(1,3);
                  elsif(addr_ram_v_old < 21) then
                    radek_old := to_unsigned(2,3);
                  elsif(addr_ram_v_old < 28) then
                    radek_old := to_unsigned(3,3);
                  elsif(addr_ram_v_old < 35) then
                    radek_old := to_unsigned(4,3);
                  elsif(addr_ram_v_old < 42) then
                    radek_old := to_unsigned(5,3);
                  end if;

                  if(addr_ram_v < 7) then
                    radek := to_unsigned(0,3);
                  elsif(addr_ram_v < 14) then
                    radek := to_unsigned(1,3);
                  elsif(addr_ram_v < 21) then
                    radek := to_unsigned(2,3);
                  elsif(addr_ram_v < 28) then
                    radek := to_unsigned(3,3);
                  elsif(addr_ram_v < 35) then
                    radek := to_unsigned(4,3);
                  elsif(addr_ram_v < 42) then
                    radek := to_unsigned(5,3);
                  end if;
                else
                  radek_old := radek;
                end if;
					 
                -- dekoder souradnic z adresy ram ze stare pozice kde bylo volno
                -- \_{°-°}_/

                if(addr_ram_v_old < 7) then
                  end_x := to_unsigned(to_integer(addr_ram_v_old),3);
                  end_y := to_unsigned(0,3);
                elsif(addr_ram_v_old < 14) then
                  end_x := to_unsigned(to_integer(addr_ram_v_old - 7),3);
                  end_y := to_unsigned(1,3);
                elsif(addr_ram_v_old < 21) then
                  end_x := to_unsigned(to_integer(addr_ram_v_old - 14),3);
                  end_y := to_unsigned(2,3);
                elsif(addr_ram_v_old < 28) then
                  end_x := to_unsigned(to_integer(addr_ram_v_old - 21),3);
                  end_y := to_unsigned(3,3);
                elsif(addr_ram_v_old < 35) then
                  end_x := to_unsigned(to_integer(addr_ram_v_old - 28),3);
                  end_y := to_unsigned(4,3);
                elsif(addr_ram_v_old < 42) then
                  end_x := to_unsigned(to_integer(addr_ram_v_old - 35),3);
                  end_y := to_unsigned(5,3);
                end if;

                if(radek_old /= radek) then
                  --naraz
                  cnt_1_bit := 0;
                  fsm_gm    <= cekani_ack_re;
                else
                  -- identifikace nasledujiciho bloku ve smeru pohybu
                  case r_ram is

                    when c_cil =>

                      if(cnt_1_bit = 0) then
                        fsm_gm    <= cekani_ack_re;
                        finished  <= '1'; -- priznak vitezstvi
								
								 -- dekoder souradnic z adresy ram ze stare pozice kde bylo volno
								 -- \_{°-°}_/

								 if(addr_ram_v < 7) then
									end_x := to_unsigned(to_integer(addr_ram_v),3);
									end_y := to_unsigned(0,3);
								 elsif(addr_ram_v < 14) then
									end_x := to_unsigned(to_integer(addr_ram_v - 7),3);
									end_y := to_unsigned(1,3);
								 elsif(addr_ram_v < 21) then
									end_x := to_unsigned(to_integer(addr_ram_v - 14),3);
									end_y := to_unsigned(2,3);
								 elsif(addr_ram_v < 28) then
									end_x := to_unsigned(to_integer(addr_ram_v - 21),3);
									end_y := to_unsigned(3,3);
								 elsif(addr_ram_v < 35) then
									end_x := to_unsigned(to_integer(addr_ram_v - 28),3);
									end_y := to_unsigned(4,3);
								 elsif(addr_ram_v < 42) then
									end_x := to_unsigned(to_integer(addr_ram_v - 35),3);
									end_y := to_unsigned(5,3);
								 end if;								
							
                      else
                        fsm_gm <= skenovani;
                      end if;

                    when c_wal =>

                      cnt_1_bit := 0;
                      fsm_gm    <= cekani_ack_re;

                    when c_blk =>

                      if(cnt_1_bit = 1) then
                        cnt_1_bit := 0;
                      else
                        cnt_1_bit := 1;
                      end if;

                      fsm_gm <= cekani_ack_re;

                    when others =>

                      fsm_gm <= skenovani;

                  end case;
                end if;

                start_pos_s <= std_logic_vector(start_x & start_y & pohyb_blok);
                end_pos_s   <= std_logic_vector(end_x   & end_y   & pohyb_blok);

              when cekani_ack_re =>

                move_s <= '1'; -- povel grafice pro zahajeni animace

                if(ack /= '0') then
                  fsm_gm <= cekani_ack_fe;
                end if;
					 
				  when cekani_ack_fe =>
				  
					 if(ack = '0') then
                  fsm_gm <= aktualizace_ram_start;
                end if;

              when aktualizace_ram_start =>
					 
                if((start_x = cil_x) and (start_y = cil_y)) then
                  w_ram_s <= c_cil;
                else
                  w_ram_s <= c_zem;
                end if;
                
                we_ram      <= '1';
                addr_ram_s  <= std_logic_vector(start_x + start_y * 7);

                fsm_gm <= aktualizace_ram_end;

              when aktualizace_ram_end =>

                if(pohyb_blok = c_pohyb_blk) then
                  w_ram_s <= c_blk;
                elsif(pohyb_blok = c_pohyb_hrc) then
                  w_ram_s <= c_hrc;
                end if;

                we_ram <= '1';
					 
                if(finished = '1') then
                  addr_ram_s  <= std_logic_vector(addr_ram_v);
                  fsm_gm      <= stoji;
                  fsm_notgm   <= finish;
                else
                  addr_ram_s  <= std_logic_vector(addr_ram_v_old);
                  fsm_gm      <= zed_x_blok;
                end if;
					 
              when zed_x_blok =>

                if(cnt_1_bit = 0) then
                  fsm_gm <= stoji;
                else

                  -- pokial hrac narazil do bloku - blok sa zacne hybat
                  -- dekoder souradnic z adresy ram a ulozeni do start x,y
                  -- \_{°-°}_/

                  if((addr_ram_v) < 7) then
                    start_x := to_unsigned(to_integer(addr_ram_v),3);
                    start_y := to_unsigned(0,3);
                  elsif((addr_ram_v) < 14) then
                    start_x := to_unsigned(to_integer(addr_ram_v - 7),3);
                    start_y := to_unsigned(1,3);
                  elsif((addr_ram_v) < 21) then
                    start_x := to_unsigned(to_integer(addr_ram_v - 14),3);
                    start_y := to_unsigned(2,3);
                  elsif((addr_ram_v) < 28) then
                    start_x := to_unsigned(to_integer(addr_ram_v - 21),3);
                    start_y := to_unsigned(3,3);
                  elsif((addr_ram_v) < 35) then
                    start_x := to_unsigned(to_integer(addr_ram_v - 28),3);
                    start_y := to_unsigned(4,3);
                  elsif((addr_ram_v) < 42) then
                    start_x := to_unsigned(to_integer(addr_ram_v - 35),3);
                    start_y := to_unsigned(5,3);
                  end if;

                fsm_gm <= skenovani;
              end if;

            end case; -- fsm_gm

  -----------------------------------------------------------------------------

          end if;

        when finish =>

          -- ceka na stlaceni libovolne klavesy
          if((keys.up or keys.down or keys.left or keys.right or keys.enter) = '1') then
            finished  <= '0';
            lvl_int   <= lvl_int + 1;
            tahy_int  <= 0;
            rst_ram   <= '1';
            fsm_notgm <= inic;
          elsif(keys.esc = '1') then
            finished  <= '0';
            lvl_int   <= lvl_int + 1;
            fsm_notgm <= menu;
			 elsif(keys.r = '1') then
            finished  <= '0';
			   rst_ram   <= '1';
            fsm_notgm <= inic;
            fsm_gm    <= stoji;
          end if;

          -- kontrola preteceni
          if(lvl_int = 30) then
            lvl_int   <= 30;
            fsm_notgm <= menu;
          end if;

      end case;
    end if;
  end process;


  bcd_lvl : decoder_to_bcd
    generic map  (  g_input_width => 8,
                    g_decimal_digits => 2
                 )
    port map  ( clk        => clk,
                bcd_start  => '1',
                binary_in  => lvl,
                bcd_out    => lvl_101,
                bcd_done   => lvl_bcd_done
              );

  bcd_tahy : decoder_to_bcd
    generic map  (  g_input_width => 8,
                    g_decimal_digits => 2
                 )
    port map  ( clk        => clk,
                bcd_start  => '1',
                binary_in  => tahy,
                bcd_out    => tahy_101,
                bcd_done   => tahy_bcd_done
              );
              
  update_bcd : process(clk, lvl_101, tahy_101)
  begin
    if (rising_edge(clk)) then
      if(lvl_bcd_done = '1') then
        lvl_1   <= lvl_101(3 downto 0);
        lvl_10  <= lvl_101(7 downto 4);
      end if;
		if(tahy_bcd_done = '1') then
        tahy_1   <= tahy_101(3 downto 0);
        tahy_10  <= tahy_101(7 downto 4);
      end if;
    end if;
  end process;

  -- combinational output assigments
  gamemode    <= gamemode_s;
  fin         <= finished;
  addr_ram    <= addr_ram_s;
  w_ram       <= w_ram_s;
  addr_rom    <= addr_rom_s;
  start_pos   <= start_pos_s;
  end_pos     <= end_pos_s;
  move        <= move_s;
  lvl         <= '0' & std_logic_vector(to_unsigned(lvl_int,(lvl'length-1)));
  tahy        <= '0' & std_logic_vector(to_unsigned(tahy_int,(tahy'length-1)));

end behavioral;
