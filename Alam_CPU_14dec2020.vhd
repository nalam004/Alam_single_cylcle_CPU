library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity Alam_CPU_14dec2020 is
	port (
		rst, clk: in std_logic;
		rs_out, rt_out, pc_out: out std_logic_vector(3 downto 0);
		overflow, zero: out std_logic
	);
end Alam_CPU_14dec2020;

architecture Alam_behavioral of Alam_CPU_14dec2020 is
	signal memtoreg, RegDst, Regwr, ALUsrc, add_sub, Memwr: std_logic;
	signal ALUop, Extop, branch_type, PCsrc: std_logic_vector(1 downto 0);
	signal mul1_out: std_logic_vector(4 downto 0);
	
	signal out_pc, next_out_pc, i_out, busa, busb, extend_out, 
			mul2_out, mul3_out, alu_out, d_out: std_logic_vector(31 downto 0);
			
	component Alam_mux2to1_14dec2020 is
		generic (n: integer := 32);
		port ( 
			x, y: in std_logic_vector(n-1 downto 0);
			sel: in std_logic;
			f: out std_logic_vector(n-1 downto 0) 
		);
	end component;
  
	component Alam_control_unit_14dec2020 is	
	port (
		op, funct: in std_logic_vector(5 downto 0);
		memtoreg, RegDst, Regwr, ALUsrc, add_sub, Memwr: out std_logic;
		ALUop, Extop, branch_type, PCsrc: out std_logic_vector(1 downto 0)
	);
	end component;
	
	component Alam_ALU_14dec2020 is
	port(
		x, y: in std_logic_vector(31 downto 0); 
		add_sub: in std_logic;  
		ALUop, extop: in std_logic_vector(1 downto 0);          
		z: out std_logic_vector(31 downto 0);
		overflow, zero: out std_logic
	);
	end component; 
	
	component Alam_datamem_14dec2020 is
	port (
		rst, clk, wren: in std_logic;
		addr: in std_logic_vector(4 downto 0);
		data: in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component Alam_instructionmemory_14dec2020 is
	port (
		addr: in std_logic_vector(4 downto 0);
		instruction: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component Alam_registerfile is
	port (
		din: in std_logic_vector(31 downto 0);
		rst, clk, wren: in std_logic;
		ra, rb, rw: in std_logic_vector(4 downto 0);
		q_a, q_b: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component Alam_pc_14dec2020 is
	port ( 
		rst, clk: in std_logic;
		pc_in: in std_logic_vector(31 downto 0);
		pc_out: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component Alam_nal_14dec2020 is
	port(
		rt, rs, pc: in std_logic_vector(31 downto 0);
		target: in std_logic_vector(25 downto 0);
		branch_type, PCsrc: in std_logic_vector(1 downto 0);
		next_pc: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component Alam_signextend_14dec2020 is
	port (
		imm16: in std_logic_vector(15 downto 0);
		extop: in std_logic_vector(1 downto 0);
		imm32: out std_logic_vector(31 downto 0)
	);
	end component;
	
	begin
		ALU: Alam_ALU_14dec2020 port map(busa, mul2_out, add_sub, ALUop, Extop, alu_out, overflow, zero);
		
		Control: Alam_control_unit_14dec2020 port map(i_out(31 downto 26), i_out(5 downto 0), 
						memtoreg, RegDst, Regwr, ALUsrc, add_sub, Memwr, ALUop, Extop, branch_type, PCsrc);
						
		DataMem: Alam_datamem_14dec2020 port map(rst, clk, Memwr, alu_out(4 downto 0), busb, d_out);
		
		InstMem: Alam_instructionmemory_14dec2020 port map(out_pc(4 downto 0), i_out);
		
		NAL: Alam_nal_14dec2020 port map(busb, busa, out_pc, i_out(25 downto 0), branch_type, PCsrc, next_out_pc);
		
		PC: Alam_pc_14dec2020 port map(rst, clk, next_out_pc, out_pc);
		
		RegisterFile: Alam_registerfile port map(mul3_out, rst, clk, memtoreg, i_out(25 downto 21), i_out(20 downto 16), 
												mul1_out, busa, busb);
		
		Extender: Alam_signextend_14dec2020 port map(i_out(15 downto 0), Extop, extend_out);
		mux1: Alam_mux2to1_14dec2020 
			generic map (n => 5) 
			port map(i_out(20 downto 16), i_out(15 downto 11), RegDst, mul1_out);
			
		mux2: Alam_mux2to1_14dec2020 port map(busb, extend_out, ALUsrc, mul2_out);
		mux3: Alam_mux2to1_14dec2020 port map(d_out, alu_out, Regwr, mul3_out);
		
		rs_out <= not busa(3 downto 0);
		rt_out <= not busb(3 downto 0);
		pc_out <= not out_pc(3 downto 0);

end Alam_behavioral;