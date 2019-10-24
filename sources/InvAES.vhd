
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvAES is

port(
	start_i:in STD_LOGIC;
	clock_i:in STD_LOGIC;
	reset_i:in STD_LOGIC;
	data_i:in bit128;
	aes_on_o:out STD_LOGIC;
	data_o:out bit128);
	

end entity InvAES;

architecture InvAES_arch of InvAES is
--on va mapper les différents composants au sein du top level

component KeyExpansion_table
    Port ( 
	   round_i:in bit4;
           expansion_key_o : out bit128);
end component;

--composant InvFSM
component InvFSM

    Port ( resetb_i : in  STD_LOGIC;
           clock_i : in  STD_LOGIC;
           start_i : in  STD_LOGIC; 
	   round_i : in bit4;
	    
	   enableMixcolumns_o : out std_logic;
	   enableRoundcpting_o : out std_logic;
	   enableOutput_o : out std_logic;
	   done_o : out std_logic;
	   
	   enableCounter_o: out std_logic;
	   getciphertext_o: out std_logic;
	   resetCounter_o:out std_logic);
end component;



--Composant InvAddRound


component InvAESRound is
port(	currentkey_i : in bit128;
	currenttext_i : in bit128;
	data_o : out bit128;
	clock_i : in std_logic;
	resetb_i : in std_logic;
	enableInvMixcolumns_i : in std_logic;
	enableRoundcomputing_i : in std_logic);
end component InvAESRound;







component Counter is

port(
	clock_i:in STD_LOGIC;
	enable_i:in STD_LOGIC;
	resetb_i:in STD_LOGIC;
	counting_o:out bit4);

end component ;



component RTL_MUX is
port(
    Inputl0_i: in bit128;
    Inputl1_i: in bit128;
    getCipherText_i: in std_logic;
    CipherText_o: out bit128
);
end component;


signal resetb_s : std_logic;


signal expansion_key_s : bit128;

signal datao_s : bit128;--issu du invAESRound

signal enableMixcolumns_s : std_logic;--issu du FSM_INV_AES
signal enableRoundCpting_s : std_logic;--issu de la FSM_INV_AES
signal enableCounter_s:std_logic;--issu de la FSM_INV_AES
signal enableOutput_s : std_logic;--issu de la FSM_INV_AES
signal resetCounter_s:std_logic;--issu de la FSM_INV_AES
signal count_s: bit4;--issu du compteur
signal CipherText_s:bit128;--issu du multiplexeur
signal getciphertext_s:STD_LOGIC;--issu de la FSM_INV_AES 
signal Inputl1_is:bit128;
signal Inputl0_s:bit128;

begin 
	
	resetb_s <= not reset_i;
	
	
		
	Cter:Counter

	
	port map(
	 counting_o=>count_s,
	  clock_i=>clock_i,
	enable_i=>enableCounter_s,
	resetb_i=>resetCounter_s 
           );




	KE : KeyExpansion_table
	port map(
	 round_i=>count_s,
	   
           expansion_key_o => expansion_key_s);

	FSM : InvFSM
	Port map( 
		clock_i => clock_i,
		resetb_i => resetb_s,
		
		start_i => start_i,
		
		round_i=>count_s,

		enableMixcolumns_o => enableMixcolumns_s, 
		enableRoundcpting_o => enableRoundcpting_s,
	        enableOutput_o => enableOutput_s,

	   	enableCounter_o=>enableCounter_s,
	   	getciphertext_o=> getciphertext_s,
	   	resetCounter_o=>resetCounter_s,
	        done_o => aes_on_o);

	AR : InvAESRound
	port map(
		currenttext_i => CipherText_s,
		currentkey_i => expansion_key_s,
		data_o => datao_s,
		clock_i => clock_i,
		resetb_i => resetb_s,
		enableInvMixcolumns_i => enableMixColumns_s, 
		enableRoundcomputing_i => enableRoundcpting_s);


	


MUX: RTL_MUX 
port map(
	Inputl0_i=>data_i,
	Inputl1_i=>datao_s,
	getCipherText_i=>getciphertext_s,
	CipherText_o=>CipherText_s	
   
);



	Sortie: process(datao_s, enableOutput_s)
	begin
	
		if ( enableOutput_s = '1') then
	       data_o <= datao_s;
	   end if;
	end process Sortie;
end architecture InvAES_arch;







	
