LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Alam_test_CPU IS
END Alam_test_CPU;
 
ARCHITECTURE behavior of Alam_test_CPU is 
	COMPONENT Alam_CPU_14dec2020 
	port (
		rst, clk: in std_logic;
		rs_out, rt_out, pc_out: out std_logic_vector(3 downto 0);
		overflow, zero: out std_logic
	);
	END COMPONENT;
   
	signal clk, rst: std_logic;
	signal overflow, zero: std_logic;
	signal rs_out, rt_out, pc_out: std_logic_vector(3 downto 0);
   constant clk_period : time := 10 ns;
	
	BEGIN
	
	uut: Alam_CPU_14dec2020 port map(rst, clk, rs_out, rt_out, pc_out, overflow, zero);
	
	clk_process :process
   begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
	end process;
	
	stim_proc: process
   begin  
	rst <= '1';
	wait for clk_period*10;
	rst <= '0';
	wait;
   end process;
end;
