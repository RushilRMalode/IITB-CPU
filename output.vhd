----IITB CPU


----OUTPUT


library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity output is
	port(IR: in std_logic_vector(15 DOWNTO 0);
		T_P,T_Z : in std_logic;
		reset : in std_logic;
		clk : in std_logic;
		C : in std_logic;
		Z : in std_logic;
		rf_a3 : in std_logic_vector(2 DOWNTO 0);
		rst_1 : out std_logic;
	
		control_signal : out std_logic_vector(37 DOWNTO 0));
end output;

architecture behv of output is


signal presentstate: std_logic_vector(4 downto 0);


begin 

statelogic: process(presentstate, reset, IR, T_P,T_Z,rf_a3,C,Z)
	
	variable control_variable :  std_logic_vector(37 DOWNTO 0);
	
	begin 
		if reset = '1' then
			
			control_variable := (others =>'0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(34) := '1';
			control_variable(35) := '1';
			
		elsif presentstate = "10000" then
			control_variable := (others =>'0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(34) := '1';
			control_variable(35) := '1';
			
			

		elsif presentstate = "00000" then
			control_variable := (others => '0');
			control_variable(1) := '1';
			control_variable(36) := '1';
			control_variable(12) := '1';
			control_variable(11) := '1';
			control_variable(30) := '1';
			control_variable(3) := '1';
			control_variable(32) := '1';
			
	   elsif presentstate = "00001" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(28) := '1';
			control_variable(15) := '1';
			control_variable(29) := '1';
			control_variable(16) := '1';
			control_variable(33) := '1';
			control_variable(25) := '1';
		
		elsif presentstate = "00010" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(13) := '1';
			
		
			if IR(15) = '1' then
				control_variable(18) := '1';
				control_variable(19) := '1';
				control_variable(30) := '1';

			elsif ((IR(0)='0') and (IR(1)='0')) or ((IR(0)='0') and (IR(1)='1') and C = '1') or ((IR(0)='1') and (IR(1)='0') and Z = '1') then   
				control_variable(30) := '1';
				if IR(13) = '1' then
					control_variable(18) :='1';
				else 
					control_variable(20) := '1';
				end if;

			elsif (((IR(0)='0') and (IR(1)='1') and C = '0') or ((IR(0)='1') and (IR(1)='0') and Z = '0')) then
				control_variable(31) := '1';
				control_variable(23) := '1';
				control_variable(22) := '1';
			
			else
				control_variable := (others => '0');
				control_variable(0) := '1';
				control_variable(1) := '1';
			end if;

		elsif presentstate = "00011" then
			control_variable := (others => '0');
				control_variable(0) := '1';
				control_variable(1) := '1';
				control_variable(37) := '1';
				control_variable(21) := '1';
				control_variable(31) := '1';
				control_variable(23) := '1';
				control_variable(22) := '1';	

				if IR(14) = '0' then
					if IR(12) = '0' then
						control_variable(8) := '1';
					else
						control_variable(9) := '1';
					end if;
				end if;
				
		elsif presentstate = "00100" then
			control_variable := (others => '0');
			control_variable(0)  := '1';
			control_variable(1)  := '1';
			control_variable(14) := '1';
			control_variable(30) := '1';
			control_variable(20) := '1';

		elsif presentstate = "00101" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(37) := '1';
			control_variable(10) := '1';
			control_variable(31) := '1';
			control_variable(23) := '1';
			control_variable(22) := '1';	
			
	   elsif presentstate = "00110" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(11) := '1';
			control_variable(14) := '1';
			control_variable(29) := '1';
			control_variable(17) := '1';

		elsif presentstate = "00111" then
		   control_variable := (others => '0');
			control_variable(1) := '1';
			control_variable(5) := '1';
			control_variable(30) := '1';
			control_variable(2) := '1';

		elsif presentstate = "01000" then
			control_variable := (others => '0');
			control_variable(0)  := '1';
			control_variable(5)  := '1';
			control_variable(31) := '1';
			control_variable(23) := '1';
			control_variable(22) := '1';
			

		elsif presentstate = "01001" then
			control_variable := (others => '0');
			control_variable(1) := '1';
			control_variable(4) := '1';
			control_variable(28) := '1';
			control_variable(30) := '1';
			control_variable(2) := '1';

		elsif presentstate = "01010" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(37) := '1';
			control_variable(9) := '1';
			control_variable(8) := '1';
			control_variable(33) := '1';
			control_variable(31) := '1';
			control_variable(23) := '1';
			control_variable(22) := '1';	
				
	   elsif presentstate = "01011" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(7) := '1';
			control_variable(29) := '1';	
	
		elsif presentstate = "01100" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(4) := '1';
			control_variable(6) := '1';
			control_variable(31) := '1';
			control_variable(23) := '1';
			control_variable(22) := '1';
			control_variable(28) := '1';
			control_variable(33) := '1';	
			
	  elsif presentstate = "01101" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(31) := '1';
			control_variable(12) := '1';
			control_variable(11) := '1';
			control_variable(14) := '1';

			if T_Z = '1' then
			control_variable(32) := '1';	

			else
			control_variable(23) := '1';
			control_variable(22) := '1';	
			
			end if;


		elsif presentstate = "01110" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(37) := '1';
			control_variable(31) := '1';	
			control_variable(12) := '1';
			control_variable(14) := '1';
			control_variable(13) := '1';
			control_variable(32) := '1';

		elsif presentstate = "01111" then
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			control_variable(37) := '1';
			control_variable(31) := '1';	
			control_variable(23) := '1';
			control_variable(32) := '1';	
			control_variable(26) := '1';	

		else  
			control_variable := (others => '0');
			control_variable(0) := '1';
			control_variable(1) := '1';
			
			
		end if;
		
		if presentstate = "10000" then
			rst_1 <= '1';
		else 
			rst_1 <= '0';
		end if;

	control_signal <= control_variable;

	end process;					
end behv ;