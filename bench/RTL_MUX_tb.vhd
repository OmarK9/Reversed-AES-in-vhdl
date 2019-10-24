
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library source;library AESLibrary;
use AESLibrary.state_definition_package.all;

entity RTL_MUX_tb is
end entity RTL_MUX_tb ;






architecture RTL_MUX_tb_arch of RTL_MUX_tb is
	component RTL_MUX

		port(
			Inputl0_i: in bit128;
   			 Inputl1_i: in bit128;
    			getCipherText_i: in std_logic;
    			CipherText_o: out bit128);


end component;


signal Inputl0_is:bit128:=x"b6af33aaa019a9e83d0c10694daca87b";
signal Inputl1_is:bit128;
			    
signal CipherText_os:bit128;
signal getCipherText_is:std_logic:='0';

begin
	DUT:RTL_MUX
	port map(
		Inputl0_i=>Inputl0_is,
		Inputl1_i=>Inputl1_is,
		CipherText_o=>CipherText_os,
		getCipherText_i=>getCipherText_is
		
		);
Inputl1_is<=x"791b6662478eb7c88b817ce465aa6f03",x"00000000000000000000000000000000" after 50 ns;

end architecture RTL_MUX_tb_arch;

configuration RTL_MUX_tb_conf of RTL_MUX_tb is

	for RTL_MUX_tb_arch
		for DUT:RTL_MUX
			use entity source.RTL_MUX(RTL_MUX_arch);
		end for;
	end for;
end configuration RTL_MUX_tb_conf;

