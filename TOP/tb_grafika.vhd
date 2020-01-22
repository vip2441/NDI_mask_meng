--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:50:30 01/21/2020
-- Design Name:   
-- Module Name:   C:/SharedVmchine/NDI_mask_meng/TOP/tb_grafika.vhd
-- Project Name:  MaskMeng
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Grafika
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_grafika IS
END tb_grafika;
 
ARCHITECTURE behavior OF tb_grafika IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Grafika
    PORT(
         clk : IN  std_logic;
         wf_en : IN  std_logic;
         HS : OUT  std_logic;
         VS : OUT  std_logic;
         R : OUT  std_logic;
         G : OUT  std_logic;
         B : OUT  std_logic;
         frame_tick : OUT  std_logic;
         start_pos : IN  std_logic_vector(7 downto 0);
         end_pos : IN  std_logic_vector(7 downto 0);
         lvl_mem_add : OUT  std_logic_vector(5 downto 0);
         lvl_mem_data : IN  std_logic_vector(2 downto 0);
         move : IN  std_logic;
         reset : IN  std_logic;
         ack : OUT  std_logic;
         game_on : IN  std_logic;
         finish : IN  std_logic;
         lvl_1 : IN  std_logic_vector(3 downto 0);
         lvl_10 : IN  std_logic_vector(3 downto 0);
         stp_1 : IN  std_logic_vector(3 downto 0);
         stp_10 : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal wf_en : std_logic := '0';
   signal start_pos : std_logic_vector(7 downto 0) := (others => '0');
   signal end_pos : std_logic_vector(7 downto 0) := (others => '0');
   signal lvl_mem_data : std_logic_vector(2 downto 0) := (others => '0');
   signal move : std_logic := '0';
   signal reset : std_logic := '0';
   signal game_on : std_logic := '0';
   signal finish : std_logic := '0';
   signal lvl_1 : std_logic_vector(3 downto 0) := (others => '0');
   signal lvl_10 : std_logic_vector(3 downto 0) := (others => '0');
   signal stp_1 : std_logic_vector(3 downto 0) := (others => '0');
   signal stp_10 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal HS : std_logic;
   signal VS : std_logic;
   signal R : std_logic;
   signal G : std_logic;
   signal B : std_logic;
   signal frame_tick : std_logic;
   signal lvl_mem_add : std_logic_vector(5 downto 0);
   signal ack : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Grafika PORT MAP (
          clk => clk,
          wf_en => wf_en,
          HS => HS,
          VS => VS,
          R => R,
          G => G,
          B => B,
          frame_tick => frame_tick,
          start_pos => start_pos,
          end_pos => end_pos,
          lvl_mem_add => lvl_mem_add,
          lvl_mem_data => lvl_mem_data,
          move => move,
          reset => reset,
          ack => ack,
          game_on => game_on,
          finish => finish,
          lvl_1 => lvl_1,
          lvl_10 => lvl_10,
          stp_1 => stp_1,
          stp_10 => stp_10
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
		wf_en <= '1';

      wait;
   end process;

END;
