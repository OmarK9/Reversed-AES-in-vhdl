
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.numeric_std.all;

library AESLibrary;

use AESLibrary.state_definition_package.all;

library source;

use source.all;

entity counter_tb is

end entity counter_tb;


architecture counter_tb_arch of counter_tb is

component counter is

port(

	resetb_i:in STD_LOGIC;
	clock_i: in STD_LOGIC;
	counting_o:out bit4;
	enable_i:in  STD_LOGIC);


end component;
	signal resetbi_s:STD_LOGIC;
	signal enablei_s:STD_LOGIC;
	signal clocki_s:STD_LOGIC:='0';--initialisation  de l'horloge
	signal countingo_s:bit4;

begin

DUT:counter

Port map(
	resetb_i=>resetbi_s,
	enable_i=>enablei_s,
	clock_i=>clocki_s,
	counting_o=>countingo_s);

	resetbi_s<='0','1' after 10 ns;
	enablei_s<='0','1' after 50 ns;
	clocki_s<=not(clocki_s) after 70 ns;

end architecture counter_tb_arch;


configuration counter_tb_conf of counter_tb is

	for counter_tb_arch
		for DUT:counter
			use entity source.counter(counter_arch);
		end for;
		end for;

	end configuration counter_tb_conf;


	
	





