-----IITB_CPU

----Registers

library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;
----------------------------------------------------------
package Registers is
 component  Reg1 is 
	port(
		D, CLK ,reset, control : in std_logic;
		Q: out std_logic --controlsignal is the enable signal
	);
 end component Reg1;
 
 component Reg8 is 
	port(
		d   : in std_logic_vector(7 DOWNTO 0); -- 8 bit input
		en  : in std_logic; -- enable
		rst : in std_logic; -- reset
		clk : in std_logic; -- clock
		q   : out std_logic_vector(7 DOWNTO 0) -- 8 bit output
    );
 end component Reg8; 

 component Reg_16 is 
	port(
	    d   : in std_logic_vector(15 DOWNTO 0); -- 16 bit input
		en  : in std_logic; -- enable
		rst : in std_logic; -- reset
		clk : in std_logic; -- clock
		q   : out std_logic_vector(15 DOWNTO 0) -- 16 bit output
    );
 end component Reg_16;

 end package Registers;

----------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity  Reg1 is 
	port(
		D, CLK ,reset, control : in std_logic;
		Q: out std_logic --controlsignal is the enable signal
	);
end entity Reg1;

architecture arch of Reg1 is
begin
	process1: process(clk, reset, control, D)
	begin
		if(reset='1') then
			Q <= '0';
		elsif rising_edge(CLK) then
			if(control = '1') then
				Q <= D;
			end if;
		end if;
	end process process1;
end architecture arch;
---------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity Reg8 is 
	port(
		d   : in std_logic_vector(7 DOWNTO 0); -- 8 bit input
		en  : in std_logic; -- enable
		rst : in std_logic; -- reset
		clk : in std_logic; -- clock
		q   : out std_logic_vector(7 DOWNTO 0) -- 8 bit output
    );
end entity Reg8;

architecture arch of Reg8 is
begin
    process1: process(clk, rst)
    begin
        if rst = '1' then
            q <= "00000000";
        elsif rising_edge(clk) then
            if en = '1' then
                q <= d;
            end if;
        end if;
    end process process1;
end architecture arch;

------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Reg_16 is 
	port(
	    d   : in std_logic_vector(15 DOWNTO 0); -- 16 bit input
		en  : in std_logic; -- enable
		rst : in std_logic; -- reset
		clk : in std_logic; -- clock
		q   : out std_logic_vector(15 DOWNTO 0) -- 16 bit output
    );
end entity Reg_16;

architecture arch of Reg_16 is
begin
    process1: process(clk, rst)
    begin
        if rst = '1' then
            q <= "0000000000000000";
        elsif rising_edge(clk) then
            if en = '1' then
                q <= d;
            end if;
        end if;
    end process process1;
end architecture arch;

----------------------------------------------------------------------------------------------------

