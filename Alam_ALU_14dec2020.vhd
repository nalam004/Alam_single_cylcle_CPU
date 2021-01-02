library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity Alam_ALU_14dec2020 is
	port(
		x, y: in std_logic_vector(31 downto 0); 
		add_sub: in std_logic;  
		ALUop, extop: in std_logic_vector(1 downto 0);     
		z: out std_logic_vector(31 downto 0);
		overflow, zero: out std_logic
	);
end Alam_ALU_14dec2020;
 
architecture Alam_behavioral of Alam_ALU_14dec2020 is	
	signal logic_unit_out, aout: std_logic_vector(31 downto 0);

	begin
	process(x, y, ALUop)   
	begin
	case ALUop is
		when "00" => logic_unit_out <= x and y;
		when "01" => logic_unit_out <= x or y;
		when others => null;
	end case;
	end process;
	
	process(x, y, add_sub)   
	begin
		if(add_sub = '0') then aout <= x + y;
		elsif(add_sub = '1') then aout <= x - y;
		else null;
		end if;
	end process;
	
	process(aout)   							
	begin
		if(aout = 0) then zero <= '1';
		else zero <= '0';
		end if;
	end process;
	
	process(x, y, add_sub, aout)   			
	variable over_out : std_logic;
	begin
	over_out:='0';
	if (add_sub = '0') then 
		if (x(31) = '0') and (y(31) = '0') and (aout(31) = '1') then over_out := '1';
		end if;
		if (x(31) = '1') and (y(31) = '1') and (aout(31) = '0') then over_out := '1';
		end if;
	end if;
	end process;
	
	process(x, y, aout, logic_unit_out, extop, add_sub) 
	begin
	case extop is 
		when "00" => z <= y;
		when "01" =>
			if(x < y) and (add_sub = '1') then z <= (0 => '1',others => '0');
			else z <= (others => '0');
			end if;
		when "10" => z <= aout;
		when "11" => z <= logic_unit_out;
		when others => null;
		end case;
	end process;

end Alam_behavioral;

	
