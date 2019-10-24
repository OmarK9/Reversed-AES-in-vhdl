library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library source;
use source.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;


entity InvSubBytes_tb is
end entity InvSubBytes_tb;

architecture InvSubBytes_tb_arch of InvSubBytes_tb is
	component InvSubBytes
		port(
			donnee_i:in type_state;
			donnee_o:out type_state
	
);

		end component;

signal InvSubBytesi_s:type_state:=((X"06", X"09", X"99", X"5b"), 
					(X"85", X"fb", X"c1", X"8e"), 
					(X"a6", X"06", X"5f", X"56"), 
					(X"61", X"54", X"ca", X"74")) ;




signal InvSubByteso_s:type_state;
begin
	DUT:InvSubBytes
	port map(
		donnee_i=>InvSubBytesi_s,
		donnee_o=>InvSubByteso_s);

end architecture InvSubBytes_tb_arch;

configuration InvSubBytes_tb_conf of InvSubBytes_tb is
		for InvSubBytes_tb_arch
			for DUT:InvSubBytes
				use entity source.InvSubBytes(InvSubBytes_arch);
		end for;
	end for;

end  configuration InvSubBytes_tb_conf;



