LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk : IN  std_logic;
         HS : OUT  std_logic;
         VS : OUT  std_logic;
         R : OUT  std_logic;
         G : OUT  std_logic;
         B : OUT  std_logic;
         frame_tick : OUT  std_logic;
         move : IN  std_logic;
         reset : IN  std_logic;
         ack : OUT  std_logic;
         game_on : IN  std_logic;
         finish : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal move : std_logic := '0';
   signal reset : std_logic := '0';
   signal game_on : std_logic := '0';
   signal finish : std_logic := '0';

 	--Outputs
   signal HS : std_logic;
   signal VS : std_logic;
   signal R : std_logic;
   signal G : std_logic;
   signal B : std_logic;
   signal frame_tick : std_logic;
   signal ack : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk => clk,
          HS => HS,
          VS => VS,
          R => R,
          G => G,
          B => B,
          frame_tick => frame_tick,
          move => move,
          reset => reset,
          ack => ack,
          game_on => game_on,
          finish => finish
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
