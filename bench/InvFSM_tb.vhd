library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.numeric_std.all;

library aeslibrary;
use aeslibrary.state_definition_package.all;
library source;
use source.all;


entity InvFSM_tb is
end entity InvFSM_tb;



architecture InvFSM_tb_arch of InvFSM_tb is
component InvFSM is
port(	

 		clock_i : in  STD_LOGIC;
               start_i : in  STD_LOGIC;
	        round_i : in bit4;
		resetb_i:in STD_LOGIC;
	        enableMixcolumns_o : out std_logic;
	        enableRoundcpting_o : out std_logic;
	       enableOutput_o : out std_logic;
	       done_o : out std_logic;
	       enableCounter_o: out std_logic;
	       getciphertext_o: out std_logic;
	       resetCounter_o:out std_logic);
end component;
signal clocki_s : STD_LOGIC:='0';
signal starti_s : STD_LOGIC;
signal roundi_s : bit4;
signal resetbi_s:STD_LOGIC;
signal enableMixcolumnso_s : STD_LOGIC;
signal enableRoundcptingo_s : STD_LOGIC;
signal enableOutputo_s : STD_LOGIC;
signal doneo_s : STD_LOGIC;
signal enableCountero_s:STD_LOGIC;
signal getciphertexto_s:STD_LOGIC;
signal resetCountero_s:STD_LOGIC;

begin 
	DUT : InvFSM
	port map(
		clock_i => clocki_s,
		resetb_i => resetbi_s,
		start_i=> starti_s,
		round_i => roundi_s,
		enableMixcolumns_o => enableMixcolumnso_s,
		enableRoundcpting_o => enableRoundcptingo_s,
		enableOutput_o=>enableOutputo_s,
		done_o=>doneo_s,
		enableCounter_o=>enableCountero_s,
		getciphertext_o=>getciphertexto_s,
		resetCounter_o=>resetCountero_s);
		



	resetbi_s<='1';
	
	clocki_s<=not(clocki_s) after 50 ns;
	
	starti_s<= '0','1' after 100 ns;
	roundi_s <=x"0",x"A" after 300 ns, x"1" after 500 ns;

	

end architecture InvFSM_tb_arch;

configuration InvFSM_tb_conf of InvFSM_tb is

	for InvFSM_tb_arch
		for DUT:InvFSM
			use entity source.InvFSM(InvFSM_arch);
		end for;
		end for;

	end configuration InvFSM_tb_conf;


	
	






