-- IITB-CPU

-- Shift 7

library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity Shift7 is
	port(
		ip: in std_logic_vector(8 downto 0);
		op: out std_logic_vector(15 downto 0)
		);
end entity Shift7;

architecture arch of Shift7 is

begin
	op(15 downto 7) <= ip(8 downto 0);
	op(6 downto 0) <= "0000000";
	
end architecture arch;