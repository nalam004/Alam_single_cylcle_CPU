library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Alam_datamem_14dec2020 is
	port (
		rst, clk, wren: in std_logic;
		addr: in std_logic_vector(4 downto 0);
		data: in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0)
	);
end Alam_datamem_14dec2020;

architecture Alam_behavioral of Alam_datamem_14dec2020 is
	type meme is array(0 to 31) of std_logic_vector(31 downto 0);
	signal data_arr: meme := (others => (others => '0'));
	begin
	process(rst, clk)
	begin
		if (rst = '1') then data_arr <= (others => (others => '0'));
		elsif (clk'event and clk = '1') then
			if (wren = '1') then data_arr(conv_integer(addr)) <= data;
			end if;
		end if;
	end process;
	--data_arr(0) <= "00000000000000000000000000000001";
	--data_arr(1) <= "00000000000000000000000000000010";
	--data_arr(2) <= "00000000000000000000000000000011";
	--data_arr(3) <= "00000000000000000000000000000100";
	--data_arr(4) <= "00000000000000000000000000000101";
	--data_arr(5) <= "00000000000000000000000000000110";
	q <= data_arr(conv_integer(addr));
end Alam_behavioral;
