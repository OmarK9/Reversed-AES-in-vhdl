library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library source;


library AESLibrary;
use AESLibrary.state_definition_package.all;

entity InvShiftRows_tb is
end entity InvShiftRows_tb ;

architecture InvShiftRows_tb_arch of InvShiftRows_tb is
	component InvShiftRows

		port(
			donnee_i:in type_state;
			donnee_o:out type_state

);

	end component;
signal donneei_s:type_state:=((X"a5", X"18", X"ec", X"73"), 
					(X"14", X"1c", X"39", X"7a"), 
					(X"15", X"9e", X"3a", X"1a"), 
					(X"10", X"40", X"b2", X"8f")) ;




signal donneeo_s:type_state;

begin
	DUT:InvShiftRows
	port map(
		donnee_i=>donneei_s,
		donnee_o=>donneeo_s
		);


end architecture InvShiftRows_tb_arch;

configuration InvShiftRows_tb_conf of InvShiftRows_tb is

	for InvShiftRows_tb_arch
		for DUT:InvShiftRows
			use entity source.InvShiftRows(InvShiftRows_arch);
		end for;
	end for;
end configuration InvShiftRows_tb_conf;



