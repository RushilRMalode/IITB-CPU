-- IITB_CPU
--ADD for ALU

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity Add is
   port(a,b: in std_logic_vector(15 downto 0);
	
	     s: out std_logic_vector(15 downto 0);
        c: out std_logic);
end entity;

architecture beh of Add is

signal Keerthi: std_logic_vector(15 downto 0);

component FullAdder is
   port(x0,y0,cin: in std_logic;
        s0,cout: out std_logic);
end component;

begin
FullAdder1:  FullAdder port map (a(0), b(0), '0', s(0), Keerthi(0));

Loop1: for i in 1 to 15 generate
Fulladder2:  FullAdder port map (a(i), b(i), Keerthi(i-1), s(i), Keerthi(i));
end generate Loop1;

c<=Keerthi(15);

end beh;
