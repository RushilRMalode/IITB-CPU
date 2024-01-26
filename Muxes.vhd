-- IITB-CPU

-- 3 Bit 4X1 MUX

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------
package Muxes is
  component mux4to1_3bit is
   port(
		S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic_vector(2 downto 0);
		Y: out std_logic_vector(2 downto 0)
	);
  end component mux4to1_3bit;
  
  component mux4to1 is
   port(
		S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic_vector(15 downto 0);
		Y: out std_logic_vector(15 downto 0)
	);
  end component mux4to1;
  
  component mux2to1_16bit is
   port(
		S0: in std_logic;
		D0,D1: in std_logic_vector(15 downto 0);
		Y: out std_logic_vector(15 downto 0)
	);
  end component mux2to1_16bit;
  
  component mux2to1_3bit is
   port(
		S0: in std_logic;
		D0,D1: in std_logic_vector(2 downto 0);
		Y: out std_logic_vector(2 downto 0)
	);
 end component mux2to1_3bit;
 
 component mux2to1_8bit is
   port(
		S0: in std_logic;
		D0,D1: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	);
 end component mux2to1_8bit;
 
end package Muxes;
 
----------------------------------------------------------------------------------
 
 
library ieee;
use ieee.std_logic_1164.all;


entity mux4to1_3bit is
   port(
		S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic_vector(2 downto 0);
		Y: out std_logic_vector(2 downto 0)
	);
end entity mux4to1_3bit;
  
architecture arch of mux4to1_3bit is
begin
	mux_proc : process (S0, S1, D0, D1, D3, D2) 
	begin
		if S0 = '0' then
			if S1 = '0' then
				Y <= D0;
			else
				Y <= D2;
			end if;
		else
			if S1 = '0' then
				Y <= D1;
			else
				Y <= D3;
			end if;
		end if;
	end process mux_proc;
end architecture arch;

--------------------------------------------------------------------------------------------------
  
library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
   port(
		S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic_vector(15 downto 0);
		Y: out std_logic_vector(15 downto 0)
	);
end entity mux4to1;
  
architecture arch of mux4to1 is
begin
	mux_proc : process (S0, S1, D0, D1, D3, D2) 
	begin
		if S0 = '0' then
			if S1 = '0' then
				Y <= D0;
			else
				Y <= D2;
			end if;
		else
			if S1 = '0' then
				Y <= D1;
			else
				Y <= D3;
			end if;
		end if;
	end process mux_proc;
end architecture arch;

----------------------------------------------------------------------------------------
 
 library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_16bit is
   port(
		S0: in std_logic;
		D0,D1: in std_logic_vector(15 downto 0);
		Y: out std_logic_vector(15 downto 0)
	);
end entity mux2to1_16bit;
  
architecture arch of mux2to1_16bit is
begin 
	mux_proc : process (S0, D0, D1) 
	begin
		if S0 = '0' then
			Y <= D0;
		else
			Y <= D1;
		end if;
	end process mux_proc;
end architecture arch;

-------------------------------------------------
 
library ieee;
use ieee.std_logic_1164.all;
  
entity mux2to1_8bit is
   port(
		S0: in std_logic;
		D0,D1: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	);
end entity mux2to1_8bit;
  
architecture arch of mux2to1_8bit is
begin
	mux_proc : process (S0, D0, D1) 
	begin
		if S0 = '0' then
			Y <= D0;
		else
			Y <= D1;
		end if;
	end process mux_proc;
end architecture arch;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_3bit is
   port(
		S0: in std_logic;
		D0,D1: in std_logic_vector(2 downto 0);
		Y: out std_logic_vector(2 downto 0)
	);
end entity mux2to1_3bit;
  
architecture arch of mux2to1_3bit is
begin
	mux_proc : process (S0, D0, D1) 
	begin
		if S0 = '0' then
			Y <= D0;
		else
			Y <= D1;
		end if;
	end process mux_proc;
end architecture arch;