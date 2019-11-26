--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:09:14 11/24/2019
-- Design Name:   
-- Module Name:   C:/SharedVmchine/NDI_mask_meng/vga_graphic/test_clock_manager.vhd
-- Project Name:  vga_control
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clock_mgmt
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
 
ENTITY test_clock_manager IS
END test_clock_manager;
 
ARCHITECTURE behavior OF test_clock_manager IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_mgmt
    PORT(
         clock : IN  std_logic;
         en : IN  std_logic;
         re : OUT  std_logic;
         cclk : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal en : std_logic := '1';

 	--Outputs
   signal re : std_logic;
   signal cclk : std_logic;

   -- Clock period definitions
   constant clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_mgmt PORT MAP (
          clock => clock,
          en => en,
          re => re,
          cclk => cclk
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 
 -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 

      wait;
   end process;

END;
