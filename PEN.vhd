-- IITB-CPU

-- LSB Priority Encoder

library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity PEN is 
	port(
		pen_in: in std_logic_vector(7 downto 0);
		t_p: out std_logic;
		pen_next: out std_logic_vector(7 downto 0);
		pen_out: out std_logic_vector(2 downto 0)
	);
end entity PEN;

architecture arch of PEN is


begin 
	process1 : process(pen_in)
	variable next_var : std_logic_vector(7 downto 0);
	begin
		if (pen_in(0) = '1') then 
		   next_var := ("11111110" and pen_in);--------------clearing pen_in(0)
			pen_out <= "000";
		elsif (pen_in(1) = '1') then
		   next_var := ("11111100" and pen_in);--------------clearing pen_in(1)	
			pen_out <= "001";
		elsif (pen_in(2) = '1') then 
		   next_var := ("11111000" and pen_in);--------------clearing pen_in(2)
			pen_out <= "010";
		elsif (pen_in(3) = '1') then 
			next_var := ("11110000" and pen_in);--------------clearing pen_in(3)
			pen_out <= "011";
		elsif (pen_in(4) = '1') then 
			next_var := ("11100000" and pen_in);--------------clearing pen_in(4)
			pen_out <= "100";
		elsif (pen_in(5) = '1') then 
			next_var := ("11000000" and pen_in);--------------clearing pen_in(5)
			pen_out <= "101";
		elsif (pen_in(6) = '1') then 
			next_var := ("10000000" and pen_in);--------------clearing pen_in(6)
			pen_out <= "110";
		else
			next_var := ("00000000" and pen_in);
			pen_out <= "111";
		end if;
		pen_next <= next_var;
		
		if next_var = "00000000" then
			t_p <= '1';
		else
			t_p <= '0';
		end if;
	end process process1;
	
end architecture arch;
