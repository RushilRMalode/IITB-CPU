------IITB_CPU

------state

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity state is 
  port(
     d   : in std_logic_vector(4 downto 0);
     rst : in std_logic; 
     clk : in std_logic; 
     q   : out std_logic_vector(4 downto 0)); 
end state;

architecture beh of state is

begin
    process(clk, rst)
    begin
        if rst = '1' then
            q <= "10000";
        elsif rising_edge(clk) then
                q <= d;
        end if;
    end process;
end beh;