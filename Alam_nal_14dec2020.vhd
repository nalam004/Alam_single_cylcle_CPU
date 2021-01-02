library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alam_nal_14dec2020 is
	port(
		rt, rs, pc: in std_logic_vector(31 downto 0);
		target: in std_logic_vector(25 downto 0);
		branch_type, PCsrc: in std_logic_vector(1 downto 0);
		next_pc: out std_logic_vector(31 downto 0)
	);
end Alam_nal_14dec2020;

architecture Alam_behavioral of Alam_nal_14dec2020 is
	signal offset: signed(31 downto 0);
	signal extend: std_logic_vector(15 downto 0);
	begin
		extend <= (others => target(15));
		offset <= signed(extend & target(15 downto 0));
	process(PCsrc, branch_type, pc, rs, rt, offset, target)     
	begin
		case PCsrc is
			when "00"=>
				case branch_type is
					when "00" => next_pc <= std_logic_vector(unsigned(pc) + 1);
					when "01" =>
						if (rs = rt) then
							next_pc <= std_logic_vector(signed(unsigned(pc) + 1) + offset);
						else next_pc <= std_logic_vector(unsigned(pc) + 1);
						end if;
					when "10" =>
						if (rs /= rt) then
							next_pc <= std_logic_vector(signed(unsigned(pc) + 1) + offset);
							else next_pc <= std_logic_vector(unsigned(pc) + 1);
						end if;
					when "11" =>
						if (signed(rs) < 0) then
							next_pc <= std_logic_vector(signed(unsigned(pc) + 1) + offset);
							else next_pc <= std_logic_vector(unsigned(pc) + 1);
							end if;
					when others => null;
				end case;
			when "01" => next_pc <= "000000" & target;
			when "10" => next_pc <= rs;
			when others => null;
		end case;
	end process;
end Alam_behavioral;
