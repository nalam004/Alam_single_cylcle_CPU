library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Alam_control_unit_14dec2020 is	
	port (
		op, funct: in std_logic_vector(5 downto 0);
		memtoreg, RegDst, Regwr, ALUsrc, add_sub, Memwr: out std_logic;
		ALUop, Extop, branch_type, PCsrc: out std_logic_vector(1 downto 0)
	);
end Alam_control_unit_14dec2020;

architecture Alam_behavioral of Alam_control_unit_14dec2020 is
	begin
	process(op, funct)
	begin
	case op is
		when "000000"=>
			case funct is
				when "100000" => 			--add
					memtoreg <= '1';
					RegDst <= '1';
					Regwr <= '1';
					ALUsrc <= '0';
					add_sub <= '0';
					Memwr <= '0';
					ALUop <= "00";
					Extop <= "10";
					branch_type <= "00";
					PCsrc <= "00";
					
				when "100010" => 			--sub
					memtoreg <= '1';
					RegDst <= '1';
					Regwr <= '1';
					ALUsrc <= '0';
					add_sub <= '1';
					Memwr <= '0';
					ALUop <= "00";
					Extop <= "10";
					branch_type <= "00";
					PCsrc <= "00";
					
				when "100101" => 			--or
					memtoreg <= '1';
					RegDst <= '1';
					Regwr <= '1';
					ALUsrc <= '0';
					add_sub <= '0';
					Memwr <= '0';
					ALUop <= "01";
					Extop <= "11";
					branch_type <= "00";
					PCsrc <= "00";
				when others => null;
			end case;
		
		when "001000" => 					--addi
			ALUop <= "00";		
			RegDst <= '0';		
			Extop <= "10";		
			ALUsrc <= '1';		
			Memwr <= '0'; 			
			memtoreg <= '1';		
			PCsrc <= "00";			
			Regwr	<= '1';			
			add_sub <= '0';
			branch_type <= "00";
			
		when "001101" => 					--ori
			memtoreg <= '1';
			RegDst <= '0';
			Regwr <= '1';
			ALUsrc <= '1';
			add_sub <= '0';
			Memwr <= '0';
			ALUop <= "01";
			Extop <= "11";
			branch_type <= "00";
			PCsrc <= "00";
		
		when "100011"=> 				--lw
			memtoreg <= '1';
			RegDst <= '0';
			Regwr <= '0';
			ALUsrc <= '1';
			add_sub <= '0';
			Memwr <= '0';
			ALUop <= "10";
			Extop <= "10";
			branch_type <= "00";
			PCsrc <= "00";
		
		when "101011" => 				--sw
			memtoreg <= '0';
			RegDst <= '1';
			Regwr <= '1';
			ALUsrc <= '1';
			add_sub <= '0';
			Memwr <= '1';
			ALUop <= "00";
			Extop <= "10";
			branch_type <= "00";
			PCsrc <= "00";
			
		when "000100" => 				--beq
			memtoreg <= '0';
			RegDst <= '0';
			Regwr <= '0';
			ALUsrc <= '0';
			add_sub <= '0';
			Memwr <= '0';
			ALUop <= "00";
			Extop <= "00";
			branch_type <= "01";
			PCsrc <= "00";
			
		when others => null;
	end case;
	end process;
end Alam_behavioral;
