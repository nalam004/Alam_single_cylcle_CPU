library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Alam_registerfile is
	port (
		din: in std_logic_vector(31 downto 0);
		rst, clk, wren: in std_logic;
		ra, rb, rw: in std_logic_vector(4 downto 0);
		q_a, q_b: out std_logic_vector(31 downto 0)
	);
end Alam_registerfile;

architecture Alam_behavioral of Alam_registerfile is
	type registerfile is array(0 to 31) of std_logic_vector(31 downto 0);
	signal registers: registerfile := (others => (others => '0'));
	begin
	process(rst, clk)         
	begin
		if (rst = '1') then registers <= (others => (others => '0'));
		elsif (clk'event and clk = '1') then
			if (wren = '1') then
				registers(conv_integer(rw)) <= din;
			end if;
		end if;
	end process;
	q_a <= registers(conv_integer(ra));
	q_b <= registers(conv_integer(rb));
end Alam_behavioral;