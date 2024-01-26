----IITB_CPU

----Register File


library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is 
	port(  rf_a1, rf_a2, rf_a3   : in std_logic_vector(2 DOWNTO 0);
	       wr_rf  : in std_logic; -- write
			 en7 : in std_logic; -- enable for register 7
			 alu_out, t2_out, PC_out, t3_out, rf_d3 : in std_logic_vector(15 downto 0);
			 m : in std_logic_vector(2 downto 0);
			 rst : in std_logic; -- async. clear.
			 clk : in std_logic; -- clock.
			 rf_d1,rf_d2, R7_out  : out std_logic_vector(15 DOWNTO 0)); -- output
end register_file;

architecture arch of register_file is

component R_7 is 
	port(
			 alu_out, t2_out, PC_out, t3_out, rf_d3  : in std_logic_vector(15 DOWNTO 0);
			 m : in std_logic_vector(2 downto 0);
			 rst : in std_logic; -- async. clear.
			 clk : in std_logic; -- clock.
			 wr  : in std_logic; -- write
			 q : out std_logic_vector(15 downto 0) );
end component;


component Reg_16 is 
	port(
		 d   : in std_logic_vector(15 DOWNTO 0);
		 en  : in std_logic; -- load/enable.
		 rst : in std_logic; -- async. clear.
		 clk : in std_logic; -- clock.
		 q   : out std_logic_vector(15 DOWNTO 0)); -- output
end component;


type registerFile is array(0 to 7) of std_logic_vector(15 downto 0);
signal registers_0 : registerFile;
type bit_array is array(0 to 7) of std_logic;
signal wr_7 : std_logic;
signal wr_array : bit_array := "00000000";
signal t1,t2 : std_logic_vector(15 downto 0);

begin

process1 : for i in 0 to 6 generate
R: Reg_16 port map (d => rf_d3, en => wr_array(i), rst => rst, clk => clk, q => registers_0(i));
end generate process1;

wr_7 <= (wr_array(7) or en7); 
R70 : R_7 port map (alu_out => alu_out, t2_out => t2_out, PC_out => PC_out, t3_out => t3_out, rf_d3 => rf_d3, m => m, rst => rst, clk => clk, wr => wr_7, q => registers_0(7));


process2 : process (clk, rst, wr_rf,rf_a3,rf_a1,rf_a2)
	variable wr_arraytemp: bit_array:="00000000";
	begin	
		
		if wr_rf = '1' then
			wr_arraytemp := (others =>'0');
			wr_arraytemp(to_integer(unsigned(rf_a3))) := '1';
			t1 <= (others => '0');
			t2 <= (others => '0');
		else 
			wr_arraytemp := (others =>'0');
			t1 <= registers_0(to_integer(unsigned(rf_a1)));
			t2 <= registers_0(to_integer(unsigned(rf_a2)));
			
		end if;
		
		wr_array <= wr_arraytemp;
		
	end process process2;
		
		rf_d1 <= t1;
		rf_d2 <= t2;
		R7_out <= registers_0(7);
end arch;