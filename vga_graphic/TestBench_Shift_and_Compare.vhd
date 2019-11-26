--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:53:25 11/24/2019
-- Design Name:   
-- Module Name:   C:/SharedVmchine/NDI_mask_meng/vga_graphic/TestBench_Shift_and_Compare.vhd
-- Project Name:  vga_control
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Shift_and_Compare
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
 
ENTITY TestBench_Shift_and_Compare IS
END TestBench_Shift_and_Compare;
 
ARCHITECTURE behavior OF TestBench_Shift_and_Compare IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shift_and_Compare
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         data_in : IN  std_logic;
         sync_found : OUT  std_logic;
         data_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal data_in : std_logic := '0';

 	--Outputs
   signal sync_found : std_logic;
   signal data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
	
	signal sync_pattern: std_logic_vector(31 downto 0) := X"0f1f2f1f"; --0000 1111 0001 1111 0010 1111 0001 1111
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shift_and_Compare PORT MAP (
          clk => clk,
          rst => rst,
          en => en,
          data_in => data_in,
          sync_found => sync_found,
          data_out => data_out
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
		
      -- insert stimulus here 
		en <= '1';
		rst <= '0';
		
		wait for 20 ns;
		data_in <= sync_pattern(31);
		wait for 20 ns;
		data_in <= sync_pattern(30);
		wait for 20 ns;
		data_in <= sync_pattern(29);
		wait for 20 ns;
		data_in <= sync_pattern(28);
		wait for 20 ns;
		data_in <= sync_pattern(27);
		wait for 20 ns;
		data_in <= sync_pattern(26);
		wait for 20 ns;
		data_in <= sync_pattern(25);
		wait for 20 ns;
		data_in <= sync_pattern(24);
		wait for 20 ns;
		data_in <= sync_pattern(23);
		wait for 20 ns;
		data_in <= sync_pattern(22);
		wait for 20 ns;
		data_in <= sync_pattern(21);
		wait for 20 ns;
		data_in <= sync_pattern(20);
		wait for 20 ns;
		data_in <= sync_pattern(19);
		wait for 20 ns;
		data_in <= sync_pattern(18);
		wait for 20 ns;
		data_in <= sync_pattern(17);
		wait for 20 ns;
		data_in <= sync_pattern(16);
		wait for 20 ns;
		data_in <= sync_pattern(15);
		wait for 20 ns;
		data_in <= sync_pattern(14);
		wait for 20 ns;
		data_in <= sync_pattern(13);
		wait for 20 ns;
		
		data_in <= sync_pattern(12);
		wait for 20 ns;
		data_in <= sync_pattern(11);
		wait for 20 ns;
		data_in <= sync_pattern(10);
		wait for 20 ns;
		data_in <= sync_pattern(9);
		wait for 20 ns;
		data_in <= sync_pattern(8);
		wait for 20 ns;
		data_in <= sync_pattern(7);
		wait for 20 ns;
		data_in <= sync_pattern(6);
		wait for 20 ns;
		data_in <= sync_pattern(5);
		wait for 20 ns;
		data_in <= sync_pattern(4);
		wait for 20 ns;
		data_in <= sync_pattern(3);
		wait for 20 ns;
		data_in <= sync_pattern(2);
		wait for 20 ns;
		data_in <= sync_pattern(1);
		wait for 20 ns;
		data_in <= sync_pattern(0);
		
   end process;

END;
