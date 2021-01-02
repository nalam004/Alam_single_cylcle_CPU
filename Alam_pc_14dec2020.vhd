library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Alam_pc_14dec2020 is
	port ( 
		rst, clk: in std_logic;
		pc_in: in std_logic_vector(31 downto 0);
		pc_out: out std_logic_vector(31 downto 0)
	);
end Alam_pc_14dec2020;

architecture Alam_behavioral of Alam_pc_14dec2020 is 	
	begin
	process(clk,rst)
	begin
		if (rst = '1') then pc_out <= (others => '0');
		elsif (clk'event and clk = '1') then pc_out <= pc_in;
      end if;
	end process;
end Alam_behavioral;





        
     
    
