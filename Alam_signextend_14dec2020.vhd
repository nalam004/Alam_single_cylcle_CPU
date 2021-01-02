library ieee;
use ieee.std_logic_1164.all;

entity Alam_signextend_14dec2020 is
	port (
		imm16: in std_logic_vector(15 downto 0);
		extop: in std_logic_vector(1 downto 0);
		imm32: out std_logic_vector(31 downto 0)
	);
end Alam_signextend_14dec2020;

architecture Alam_logic of Alam_signextend_14dec2020 is
	signal extend: std_logic_vector(15 downto 0);
	begin
	process(imm16,extop,extend)
   begin
		case extop is
			when "00" => extend <= (others => '0');
				imm32 <= imm16 & extend;
			when "01"|"10" => extend <= (others => imm16(15));
				imm32 <= extend & imm16;
			when "11" => extend <= (others => '0');
				imm32 <= extend & imm16;
			when others => null;
      end case;
	end process;
end Alam_logic;

