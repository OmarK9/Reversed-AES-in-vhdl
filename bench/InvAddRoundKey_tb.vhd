
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;
entity InvAddRoundKey_tb is 
end entity InvAddRoundKey_tb;

architecture InvAddRoundKey_tb_arch of InvAddRoundKey_tb is component InvAddRoundKey
	
port(
	donnee_i:in type_state;
	key_i:in type_state;
	donnee_o:out type_state

);
end component;


signal donneei_s:type_state:=((X"10", X"37", X"a6", X"dc"), 
					(X"cd", X"e8", X"14", X"d2"), 
					(X"18", X"41", X"95", X"1b"), 
					(X"19", X"5a", X"10", X"14")) ;



signal keyi_s:type_state:= ((X"d0", X"14", X"f9", X"a8"), 
					(X"a3", X"18", X"25", X"89"), 
					(X"17", X"16", X"0c", X"81"), 
					(X"21", X"1b", X"8c", X"15")) ;


signal donneeo_s:type_state;
begin

DUT:InvAddRoundKey
Port map(
	donnee_i=>donneei_s,
	key_i=>keyi_s,
	donnee_o=>donneeo_s);





end architecture InvAddRoundKey_tb_arch;

configuration InvAddRoundKey_tb_conf of InvAddRoundKey_tb is
	for InvAddRoundKey_tb_arch
		for DUT:InvAddRoundKey
			use entity source.InvAddRoundKey(InvAddRoundKey_arch);
	end for;
    end for;

end configuration InvAddRoundKey_tb_conf;




