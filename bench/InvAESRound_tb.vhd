library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.numeric_std.all;

library aeslibrary;
use aeslibrary.state_definition_package.all;
library source;
use source.all;


entity InvAESRound_tb is
end entity InvAESRound_tb;


architecture InvAESRound_tb_arch of InvAESRound_tb is
component InvAESRound is
port(	

 		currentkey_i : in bit128;
	currenttext_i : in bit128;
	data_o : out bit128;
	clock_i : in std_logic;
	resetb_i : in std_logic;
	enableInvMixcolumns_i : in std_logic;
	enableRoundcomputing_i : in std_logic);


end component;

signal currentkeyi_s:bit128;

signal currenttexti_s:bit128;

signal datao_s:bit128;
signal clocki_s:std_logic:='0';-- initialisé à 0 sinon U
signal resetbi_s:std_logic;
signal enableInvMixcolumnsi_s:std_logic;
signal enableRoundcomputingi_s:std_logic;



begin 
	DUT : InvAESRound
	port map(
		clock_i => clocki_s,
		resetb_i => resetbi_s,
		enableInvMixcolumns_i=>enableInvMixcolumnsi_s,
		
	
		enableRoundcomputing_i=> enableRoundcomputingi_s,
		data_o=>datao_s,
		currentkey_i=>currentkeyi_s,
		currenttext_i=>currenttexti_s);



	resetbi_s<='1';
	
	
	clocki_s<=not(clocki_s) after 50 ns;
	
	
	enableRoundcomputingi_s<='0';
	enableInvMixcolumnsi_s<='0';
	currenttexti_s<=x"b619107ba00ca8aa3dac33e84dafa969";
	currentkeyi_s<=x"2b7e151628aed2a6abf7158809cf4f3c"; 




end architecture InvAESRound_tb_arch;

configuration InvAESRound_tb_conf of InvAESRound_tb is

	for InvAESRound_tb_arch
		for DUT:InvAESRound
			use entity source.InvAESRound(InvAESRound_arch);
		end for;
		end for;

	end configuration InvAESRound_tb_conf;


	
	





