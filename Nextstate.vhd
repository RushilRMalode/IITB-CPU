library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity next_state1 is
	port(
	   IR : in std_logic_vector(15 downto 0);
		T_P : in std_logic;
		present_state : inout std_logic_vector(4 downto 0);
		next_state : inout std_logic_vector(4 downto 0);
		reset : in std_logic;
		clk : in std_logic);
end next_state1;

architecture behav of next_state1 is

component state is 
  port(
     d   : in std_logic_vector(4 downto 0);
     rst : in std_logic; 
     clk : in std_logic; 
     q   : out std_logic_vector(4 downto 0));
end component;

begin
	state1 : state port map (next_state, reset, clk, present_state);
	
	statelogic : process(present_state, reset, IR, T_P)
	begin
		if reset = '1' then
			    next_state <= "10000";
		elsif present_state = "10000" then
			    next_state <= "00000";
		elsif present_state = "00000" then
			    next_state <= "00001";
		elsif present_state = "00001" then
			if IR(15 downto 12) = "0000" or IR(15 downto 12) = "0010" or IR(15 downto 12) = "1100" then 
				next_state <= "00010";
			elsif IR(15 downto 12) = "0001" then
				next_state <= "00100";
			elsif IR(15 downto 12) = "0011" then  
				next_state <= "00101";
			elsif IR(15 downto 12) = "0100" or IR(15 downto 12) = "0101"  then
				next_state <= "00110";
			elsif IR(15 downto 12) = "0110" then
				next_state <= "01001";
			elsif IR(15 downto 12) = "0111" then
				next_state <= "01011";
			elsif IR(15 downto 12) = "1000" then
				next_state <= "01110";
			elsif IR(15 downto 12) = "1001" then
				next_state <= "01111";
			else 
				next_state <= "00000";
			end if;

		elsif present_state = "00010" then
			if IR(15 downto 12) = "1100" then
				 next_state <= "01101";
			elsif IR(15 downto 12) = "0000" or IR(15 downto 12) = "0010" then
				 next_state <= "00011";
			else
				 next_state <= "00000";
			end if;
		elsif present_state = "00011" then
			    next_state <= "00000";
		elsif present_state = "00100" then
			    next_state <= "00011";
		elsif present_state = "00101" then
			    next_state <= "00000";
		elsif present_state = "00110" then
			if IR(12) = '0' then
				 next_state <= "00111";
			else
				 next_state <= "01000";
			end if;
		elsif present_state = "00111" then
			    next_state <= "00000";
		elsif present_state = "01000" then
			    next_state <= "00000";
		elsif present_state = "01001" then
			    next_state <= "01010";
		elsif present_state = "01010" then
			if T_P = '1' then
				 next_state <= "00000";
			else
				 next_state <= "01001";
			end if;
		elsif present_state = "01011" then
			    next_state <= "01100";
		elsif present_state = "01100" then
			if T_P = '1' then
				 next_state <= "00000";
			else
				 next_state <= "01011";
			end if;
		elsif present_state = "01101" then
			    next_state <= "00000";
		elsif present_state = "01110" then
			    next_state <= "00000";
		elsif present_state = "01111" then
			    next_state <= "00000";
		else  
			    next_state <= "00000";
		end if;
		
	end process;
	
end behav;