library ieee;
use ieee.std_logic_1164.all;

entity Alam_mux2to1_14dec2020 is
	generic (n: integer := 32);
	port ( 
		x, y: in std_logic_vector(n-1 downto 0);
		sel: in std_logic;
		f: out std_logic_vector(n-1 downto 0) 
	);
end Alam_mux2to1_14dec2020;

architecture Alam_behavioral of Alam_mux2to1_14dec2020 is
begin
	process (x, y, sel)
	begin
		if sel = '0' then f <= x;
		else f <= y;
		end if;
	end process;
end Alam_behavioral;