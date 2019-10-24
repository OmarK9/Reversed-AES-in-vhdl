
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;



entity InvAES_tb is
end entity InvAES_tb;

architecture InvAES_tb_arch of InvAES_tb is
component InvAES
port(	

	start_i:in STD_LOGIC;
	clock_i:in STD_LOGIC;
	reset_i:in STD_LOGIC;
	data_i:in bit128;
	aes_on_o:out STD_LOGIC;
	data_o:out bit128);
	

end component;
signal start_s:std_logic;
signal clock_s:std_logic:='0';
signal datai_s:bit128;
signal datao_s:bit128;
signal aes_on_s: std_logic;
signal done_s:std_logic;
signal reset_s: std_logic;


begin 
	DUT : InvAES
	port map(
		clock_i => clock_s,
		reset_i => reset_s,
		start_i => start_s,
		
		data_i => datai_s,
		data_o => datao_s,
		aes_on_o => aes_on_s);


			reset_s<='0';
			start_s<='1';
			
			datai_s<= x"d6efa6dc4ce8efd2476b9546d76acdf0" ;--le texte initial à déchiffrer
			clock_s<=not(clock_s) after 50 ns;


end architecture InvAES_tb_arch;



configuration InvAES_tb_conf of InvAES_tb is

	for InvAES_tb_arch
		for DUT:InvAES
			use entity source.InvAES(InvAES_arch);
		end for;
	end for;
end configuration InvAES_tb_conf;
