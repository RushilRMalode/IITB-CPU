----IITB CPU

----UP


library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;


entity IITB_CPU is
   port(--instruction: in std_logic_vector(15 downto 0);
			clk: in std_logic;
			rst_m: in std_logic);
end entity;



architecture Struct of IITB_CPU is

	
component ALU is
   port(alu_a,alu_b: in std_logic_vector(15 downto 0);
		k1: in std_logic; k2: in std_logic;
		alu_out: out std_logic_vector(15 downto 0);
      c_out: out std_logic);
end component;

component mux4to1 is
   port(S1,S0:in std_logic;
	D0,D1,D2,D3:in std_logic_vector(15 downto 0);
	Y:out std_logic_vector(15 downto 0));
end component;

component  Reg1 is 
 port (D, CLK ,reset, control : in std_logic; Q: out std_logic); --control is the Enable signal
end  component;

component Reg_16 is 
	port(
		 d   : in std_logic_vector(15 DOWNTO 0);
		 en  : in std_logic; -- load/enable.
		 rst : in std_logic; -- async. clear.
		 clk : in std_logic; -- clock.
		 q   : out std_logic_vector(15 DOWNTO 0)); -- output
end component;

component register_file is 
	port(
			 rf_a1, rf_a2	, rf_a3   : in std_logic_vector(2 DOWNTO 0);
			 m : in std_logic_vector(2 downto 0);
			 rst : in std_logic; -- async. clear.
			 clk : in std_logic; -- clock.
			 wr_rf  : in std_logic; -- write
			 en7 : in std_logic; -- enable for register 7
			 alu_out, t2_out, PC_out, t3_out, rf_d3 : in std_logic_vector(15 downto 0);
			 rf_d1,rf_d2, R7_out  : out std_logic_vector(15 DOWNTO 0)); -- output
end component;

component mux2to1_3bit is
   port(S0:in std_logic;
	D0,D1:in std_logic_vector(2 downto 0);
	Y:out std_logic_vector(2 downto 0));
end component;

component mux2to1_16bit is
   port(S0:in std_logic;
	D0,D1:in std_logic_vector(15 downto 0);
	Y:out std_logic_vector(15 downto 0));
end component;

component mux4to1_3bit is
   port(S1,S0:in std_logic;
	D0,D1,D2,D3:in std_logic_vector(2 downto 0);
	Y:out std_logic_vector(2 downto 0));
end component;

component SE9 is
   port(ip: in std_logic_vector(8 downto 0);
			op: out std_logic_vector(15 downto 0));
end component;

component SE6 is
   port(ip: in std_logic_vector(5 downto 0);
			op: out std_logic_vector(15 downto 0));
end component;

component Shift7 is
   port(ip: in std_logic_vector(8 downto 0);
			op: out std_logic_vector(15 downto 0));
end component;

component PEN is 
	port (pen_in: in std_logic_vector(7 downto 0);
			t_p : out std_logic;
			pen_next: out std_logic_vector(7 downto 0);
			pen_out: out std_logic_vector(2 downto 0));
end component;

component mux2to1_8bit is
   port(S0:in std_logic;
	D0,D1:in std_logic_vector(7 downto 0);
	Y:out std_logic_vector(7 downto 0));
end component;

component Reg8 is 
	port(
		 d   : in std_logic_vector(7 DOWNTO 0);
		 en  : in std_logic; -- load/enable.
		 rst : in std_logic; -- async. clear.
		 clk : in std_logic; -- clock.
		 q   : out std_logic_vector(7 DOWNTO 0)); -- output
end component;

component memory is 
	port(
		 mem_d   : in std_logic_vector(15 DOWNTO 0);
		 mem_a   : in std_logic_vector(15 downto 0);
		 rd_bar  : in std_logic; -- read enable.
		 wr_bar  : in std_logic; -- write enable
		 rst : in std_logic; -- clear.
		 clk : in std_logic; -- clock.
		 mem_out : out std_logic_vector(15 DOWNTO 0)); -- output
end component;

component output is
	port(IR : in std_logic_vector(15 DOWNTO 0);
		T_P,T_Z : in std_logic;
		reset : in std_logic;
		clk : in std_logic;
		C : in std_logic;
		Z : in std_logic;
		Rf_a3 : in std_logic_vector(2 DOWNTO 0);
		rst_1 : out std_logic;
		control_signal : out std_logic_vector(37 DOWNTO 0));
end component;

component next_state1 is
   port(IR : in std_logic_vector(15 downto 0);
		T_P : in std_logic;
		present_state : inout std_logic_vector(4 downto 0);
		next_state : inout std_logic_vector(4 downto 0);
		reset : in std_logic;
		clk : in std_logic);
end component;

function or_16(A: in std_logic_vector(15 downto 0))
		return std_logic is
		variable B : std_logic;
		
begin
		
		B:= A(15) or A(14) or A(13) or A(12) or A(11) or A(10) or A(9) or A(8) or A(7) or A(6) or A(5) or A(4) or A(3) or A(2) or A(1) or A(0);
	return B;

end or_16;

signal T1_IN,T1_OUT,T2_IN,T2_OUT,T3_IN,T3_OUT,MEM_OUT,PC_OUT,ALU_A,ALU_B,SE6_OUT,SE9_OUT,ALU_OUT,PC_IN,SHIFT7_OUT,MEM_A,MEM_D,RF_D3,RF_D1,RF_D2,IR, R7_OUT: std_logic_vector(15 downto 0);
signal IR9_11,IR3_5,IR6_8,PEN_OUT,RF_A1,RF_A2,RF_A3: std_logic_vector(2 downto 0);
signal RD_BAR,WR_BAR,A1,A2,B1,B2,C1,D1,E1,E2,F1,G1,G2,H1,H2,I1,J1,J2,K1,K2,L1,L2,M1,M2,M3,N,P1,P2,EN1,EN2,EN3,EN7,ENP,ENPEN,RST1,RST2,ENI,WR : std_logic;
signal IR0_8 : std_logic_vector(8 downto 0);
signal IR0_5 : std_logic_vector(5 downto 0);
signal C,CARRY,T_P,T_Z,ZERO,RST,reset : std_logic;
signal IR0_7,PEN_NEXT,PEN_IN_REG,PEN_OUT_REG : std_logic_vector(7 downto 0);
signal NEXTSTATE,present_state,next_state: std_logic_vector(4 downto 0);

begin
	
	mux_a2 : mux2to1_3bit port map ( '0', IR6_8, IR6_8, RF_A2);
	
	mux0: mux2to1_8bit port map ( N, PEN_NEXT, IR0_7, PEN_IN_REG);
	mux1: mux4to1 port map (G2, G1, T1_OUT, T2_OUT,T3_OUT, R7_OUT,ALU_A);
	mux2: mux4to1 port map ( H2, H1, IR, T2_OUT, SE6_OUT, SE9_OUT, ALU_B);
	mux3: mux4to1 port map ( P2, P1, ALU_OUT, T2_OUT, T3_OUT, SHIFT7_OUT, PC_IN);
	mux4: mux4to1 port map ( B1, B2, PC_OUT, T1_OUT, T2_OUT, PC_OUT, MEM_A);
	mux5: mux2to1_16bit port map ( C1, T1_OUT, T2_OUT, MEM_D);
	mux6: mux2to1_3bit port map ( D1, IR9_11, PEN_OUT, RF_A1);
	mux7: mux4to1_3bit port map ( E1, E2, IR9_11, IR3_5, IR6_8, PEN_OUT, RF_A3);
	mux8: mux4to1 port map ( A1, A2, ALU_OUT, MEM_OUT, PC_OUT, ALU_OUT, T3_IN);
	mux10 : mux2to1_16bit port map ( F1, T3_OUT, SHIFT7_OUT, RF_D3);
	mux11: mux4to1 port map( J1, J2, RF_D1, RF_D2, ALU_OUT, ALU_OUT, T2_IN);
	mux12: mux2to1_16bit port map ( I1, ALU_OUT, RF_D1, T1_IN);
	
   c_bit: Reg1 port map ( C, clk, RST, L1, CARRY);
	
	PC_reg: Reg_16 port map ( PC_IN, ENP, RST_M, C1, PC_OUT);
	
	alu1: ALU port map ( ALU_A, ALU_B, K1, K2, ALU_OUT, C);
	
	rf : register_file port map (rf_a1=>rf_a1,rf_a2=>rf_a2,rf_a3=>rf_a3,m(0)=>M1,m(1)=>M2,m(2)=>M3,rst=>rst,clk=>clk,wr_rf=>WR,en7=>en7,alu_out=>alu_out,PC_out=>PC_out, t3_out=>t3_out, t2_out=>t2_out, rf_d3=>rf_d3,rf_d1=>rf_d1,rf_d2=>rf_d2, R7_out=>R7_out);	
	
	TR1: Reg_16 port map ( T1_IN, EN1, RST, clk, T1_OUT);
	
	
	TR2: Reg_16 port map ( T2_IN, EN2, RST, clk, T2_OUT);
	
	
	TR3: Reg_16 port map ( T3_IN, EN3, RST, clk, T3_OUT);
	T_Z <=  (not or_16(T3_OUT));
	z_bit: Reg1 port map ( T_Z, clk, RST, L2, ZERO);
	
	SE_9: SE9 port map ( IR0_8, SE9_out);
	SE_6: SE6 port map ( IR0_5, SE6_out);
	Shift7_0: Shift7 port map ( IR0_8, SHIFT7_OUT);
	
	
	reg_PEN: Reg8 port map ( PEN_IN_REG, ENPEN, RST, clk, PEN_OUT_REG);
	PEN1: PEN port map( PEN_OUT_REG, T_P, PEN_NEXT, PEN_OUT); 
	
	IR_reg: Reg_16 port map ( MEM_OUT, ENI, RST_M, clk, IR);
	
	IR0_5 <= IR(5 downto 0);
	IR0_7 <= IR(7 downto 0);
	IR0_8 <= IR(8 downto 0);
	IR3_5 <= IR(5 downto 3);
	IR6_8 <= IR(8 downto 6);
	IR9_11 <= IR(11 downto 9);
	
	inst_mem : memory port map ( MEM_A, MEM_D, RD_BAR, WR_BAR, clk, RST_M, MEM_OUT);
	next_state0: next_state1 port map(IR, T_P, present_state,next_state, reset, clk);
	
	
	outputlogic_inst: output port map ( IR, T_P, T_Z, RST_M, clk, CARRY, ZERO, RF_A3, RST,
	control_signal(0)=>RD_bar,
	control_signal(1)=> WR_bar,
	control_signal(2) =>A1,
	control_signal(3)=> A2,
	control_signal(4)=> B1,
	control_signal(5)=> B2,
	control_signal(6) =>C1,
	control_signal(7) =>D1,
	control_signal(8)=> E1,
	control_signal(9) =>E2,
	control_signal(10)=> F1,
	control_signal(11)=> G1,
	control_signal(12)=> G2,
	control_signal(13)=> H1,
	control_signal(14)=> H2,
	control_signal(15)=> I1,
	control_signal(16)=> J1,
	control_signal(17) =>J2,
	control_signal(18) =>K1,
	control_signal(19) =>K2,
	control_signal(20) =>L1,
	control_signal(21) =>L2,
	control_signal(22) =>M1,
	control_signal(23)=> M2,
	control_signal(24)=> M3,
	control_signal(25) =>N,
	control_signal(26) =>P1,
	control_signal(27) =>P2,
	control_signal(28)=> EN1,
	control_signal(29) =>EN2,
	control_signal(30) =>EN3,
	control_signal(31)=>EN7,
	control_signal(32) =>ENP,
	control_signal(33) =>ENPEN,
	control_signal(34) =>rst1,
	control_signal(35) =>rst2,
	control_signal(36) =>ENI,
	control_signal(37) =>WR);
	
end Struct;