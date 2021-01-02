library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Alam_instructionmemory_14dec2020 is
	port (
		addr: in std_logic_vector(4 downto 0);
		instruction: out std_logic_vector(31 downto 0)
	);
end Alam_instructionmemory_14dec2020;

architecture Alam_behavioral of Alam_instructionmemory_14dec2020 is
	type mem is array(0 to 31) of std_logic_vector(31 downto 0);
	signal instructions: mem := (others => (others => '0'));
	begin
	--instructions(0) <= "10001100000010000000000000000000";
	--instructions(1) <= "10001100000010010000000000000000";
	--instructions(2) <= "10001100000010110000000000000000";
	--instructions(3) <= "00010001000001101100000000000000";
	--instructions(4) <= "10001101001010100000000010010000";
	--instructions(5) <= "10000001011010100101100000100000";
	--instructions(6) <= "00100001001010010000000000000100";
	--instructions(7) <= "00100001000010000000000000000001";
	--instructions(8) <= "00010001000010001000000000000001";
	--instructions(9) <= "10101101001010110000000000000000";
	instructions(0) <= "10001100000000010000000000000000";
	instructions(1) <= "00100000001000010000000000000001";
	instructions(2) <= "00100000001000010000000000000010";
	instructions(3) <= "00100000001000010000000000000011";
	instructions(4) <= "00100000001000010000000000000100";
	instructions(5) <= "00100000001000010000000000000101";
	instructions(6) <= "00100000001000010000000000000110";
	
	instruction <= instructions(conv_integer(addr));
end Alam_behavioral;