-- IITB-CPU

-- 5 input 1 output map

library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;
------------------------------------------------

entity R_7 is 
	port( --  000     010      011     001    o.w.
			alu_out, t2_out, PC_out, t3_out, rf_d3: in std_logic_vector(15 DOWNTO 0);
			m   : in std_logic_vector(2 downto 0); -- select line vector
			rst : in std_logic; -- reset
			clk : in std_logic; -- clock
			wr  : in std_logic; -- enable
			q   : out std_logic_vector(15 downto 0)
		);
end entity R_7;

architecture arch of R_7 is

begin
process1 : process(rst, clk, wr, m)
	
begin
	if rst ='1' then
		q  <= (others => '0'); -- output is sixteen zeroes if reset is 1
	elsif rising_edge(clk) then
		if wr = '1' then
			if m = "000" then
				q <= alu_out;
			elsif m = "001" then
				q <= t3_out;
			elsif m = "010" then
				q <= t2_out;
			elsif m = "011" then
				q <= PC_out;
			else 
				q <= rf_d3;
			end if;
		end if;
	end if;
end process process1;
end architecture arch;	
	
	