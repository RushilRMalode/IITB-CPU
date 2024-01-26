----IITB CPU
----ALU

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity ALU is

   port(ALU_A,ALU_B: in std_logic_vector(15 downto 0);
		K1: in std_logic; K2: in std_logic;
		ALU_OUT: out std_logic_vector(15 downto 0);
      C_OUT: out std_logic);
end entity;

architecture behav of ALU is

component Add is
   port(a,b: in std_logic_vector(15 downto 0);
	
	s: out std_logic_vector(15 downto 0);
        c: out std_logic);
end component;


signal Viru: std_logic_vector(15 downto 0);

begin
	A1 : Add port map (ALU_A, ALU_B, Viru,C_OUT);
	
	process1 : process(ALU_A,ALU_B,K1,K2,Viru)
	begin
	
		if (K1='0') then
			ALU_OUT <= Viru;
		elsif (K2='0') then
			ALU_OUT <= (ALU_A nand ALU_B);
		else 
			ALU_OUT <= (ALU_A xor ALU_B);
		end if;
	end process process1;
	
end behav;