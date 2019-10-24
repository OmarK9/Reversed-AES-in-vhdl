

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library aeslibrary;
use aeslibrary.state_definition_package.all;
library source;
use source.all;


entity InvAESRound is
port(	currentkey_i : in bit128;
	currenttext_i : in bit128;
	data_o : out bit128;
	clock_i : in std_logic;
	resetb_i : in std_logic;
	enableInvMixcolumns_i : in std_logic;
	enableRoundcomputing_i : in std_logic);
end entity InvAESRound;

architecture InvAESRound_arch of InvAESRound is


component InvAddRoundKey--Instantiation du composant InvAddRoundKey



port(

	donnee_i:in type_state;
	key_i:in type_state;
	donnee_o:out type_state);
end component;




component InvMixColumns is--on instancie le InvMixColumns
 
port(

	
	state_matrix_o:out type_state;
	state_matrix_i :in type_state);

end component InvMixColumns;






Component InvShiftRows is --On instancie le InvShiftRows

port(
	donnee_i:in type_state;
	donnee_o:out type_state
);
end component;

component InvSubBytes
port( donnee_i : in type_state;
      donnee_o : out type_state);
end component;

signal SortieSousFormatMat_s : type_state;--sortie sous format matriciel
signal CurrentTextState_s : type_state;--bloc texte courant sous format matriciel
signal Key_s : type_state;--Clef courante de la ronde sous format matriciel
signal InvArkIn_s: type_state;--l'entrée du invaddround key
signal InvArkOut_s : type_state;--la sortie du invaddround key
signal InvSbIn_s : type_state;--l'entree du subbyte
signal InvSbOut_s : type_state;--la sortie du sbbyute
signal InvSrOut_s : type_state;--sortie du InvShiftRows
signal InvSrIn_s : type_state;
signal InvMcOut_s : type_state;--ce qui sort de l'inverse mixcolumns


begin
	
	
	
	
	ISR : InvShiftRows
	port map(
		donnee_i=>InvSrIn_s,
		donnee_o=>InvSrOut_s);
	
		

	ISB : InvSubBytes
	port map(
		donnee_i=>InvSrOut_s,--Un InvShubByte vient toujours après un InvShiftRows
		donnee_o=>InvSbOut_s);
		

	IARK : InvAddRoundkey
	port map(
		donnee_i => InvArkIn_s,--L'entrée de l'InvAddRoundKey prendra soit ce qui sort du InvSubByte soit le text courant(si ronde 10)
		
		key_i=>Key_s,
		donnee_o=>InvArkOut_s);
		

	IMC : InvMixColumns port map(

		state_matrix_i=>InvArkOut_s,--Un InvMixColumns (si il a lieu) vient toujours après un InvAddRoundKey
		state_matrix_o=>InvMcOut_s);
		
	



--Conversion du texte courant en matrice (type state)
--Il existe surement une méthode plus simple pour convertir

CurrentTextState_s(0)(0)<=currenttext_i(127 downto 120);

CurrentTextState_s(1)(0)<=currenttext_i(119 downto 112);
CurrentTextState_s(2)(0)<=currenttext_i(111 downto 104);
CurrentTextState_s(3)(0)<=currenttext_i(103 downto 96);
CurrentTextState_s(0)(1)<=currenttext_i(95 downto 88);
CurrentTextState_s(1)(1)<=currenttext_i(87 downto 80); 
CurrentTextState_s(2)(1)<=currenttext_i(79 downto 72);
CurrentTextState_s(3)(1)<=currenttext_i(71 downto 64);
CurrentTextState_s(0)(2)<=currenttext_i(63 downto 56);
CurrentTextState_s(1)(2)<=currenttext_i(55 downto 48);
CurrentTextState_s(2)(2)<=currenttext_i(47 downto 40);
CurrentTextState_s(3)(2)<=currenttext_i(39 downto 32);
CurrentTextState_s(0)(3)<=currenttext_i(31 downto 24);
CurrentTextState_s(1)(3)<=currenttext_i(23 downto 16);
CurrentTextState_s(2)(3)<=currenttext_i(15 downto 8);
CurrentTextState_s(3)(3)<=currenttext_i(7 downto 0);


-----------Conversion de la clef courante en matrice (type state)


Key_s(0)(0)<=currentkey_i(127 downto 120);

Key_s(1)(0)<=currentkey_i(119 downto 112);
Key_s(2)(0)<=currentkey_i(111 downto 104);
Key_s(3)(0)<=currentkey_i(103 downto 96);
Key_s(0)(1)<=currentkey_i(95 downto 88);
Key_s(1)(1)<=currentkey_i(87 downto 80); 
Key_s(2)(1)<=currentkey_i(79 downto 72);
Key_s(3)(1)<=currentkey_i(71 downto 64);
Key_s(0)(2)<=currentkey_i(63 downto 56);
Key_s(1)(2)<=currentkey_i(55 downto 48);
Key_s(2)(2)<=currentkey_i(47 downto 40);
Key_s(3)(2)<=currentkey_i(39 downto 32);
Key_s(0)(3)<=currentkey_i(31 downto 24);
Key_s(1)(3)<=currentkey_i(23 downto 16);
Key_s(2)(3)<=currentkey_i(15 downto 8);
Key_s(3)(3)<=currentkey_i(7 downto 0);

-----------------

--Conversion du résultat matriciel en bloc de 128 bits
data_o(127 downto 120)<=SortieSousFormatMat_s(0)(0);
data_o(119 downto 112)<=SortieSousFormatMat_s(1)(0);


data_o(111 downto 104)<=SortieSousFormatMat_s(2)(0);

data_o(103 downto 96)<=SortieSousFormatMat_s(3)(0);
data_o(95 downto 88)<=SortieSousFormatMat_s(0)(1);
data_o(87 downto 80)<=SortieSousFormatMat_s(1)(1); 
data_o(79 downto 72)<=SortieSousFormatMat_s(2)(1);
data_o(71 downto 64)<=SortieSousFormatMat_s(3)(1);
data_o(63 downto 56)<=SortieSousFormatMat_s(0)(2);
data_o(55 downto 48)<=SortieSousFormatMat_s(1)(2);
data_o(47 downto 40)<=SortieSousFormatMat_s(2)(2);
data_o(39 downto 32)<=SortieSousFormatMat_s(3)(2);
data_o(31 downto 24)<=SortieSousFormatMat_s(0)(3);
data_o(23 downto 16)<=SortieSousFormatMat_s(1)(3);
data_o(15 downto 8)<=SortieSousFormatMat_s(2)(3);
data_o(7 downto 0)<=SortieSousFormatMat_s(3)(3);

	InvSrIn_s <= CurrentTextState_s;



	

--En fonction des valeur des bits en entrées  enableRoundcomputing_i et  enableInvMixcolumns_i , on va mapper les sorties des4 entités entres elles
--sur les fronts d'horloges

	InvArkIn_s <= CurrentTextState_s when (enableRoundcomputing_i = '1' and enableInvMixcolumns_i='0' and rising_edge(clock_i)) else
	InvSbOut_s when (enableRoundcomputing_i='0' and enableInvMixcolumns_i='1' and  rising_edge(clock_i))  else
	InvSbOut_s when (enableRoundcomputing_i = '0' and enableInvMixcolumns_i='0' and  rising_edge(clock_i));

	SortieSousFormatMat_s<=InvMcOut_s when (enableRoundcomputing_i='0' and enableInvMixcolumns_i='1' and  rising_edge(clock_i)) else
	InvArkOut_s  when (enableRoundcomputing_i = '1' and enableInvMixcolumns_i='0' and rising_edge(clock_i)) else
	
	InvArkOut_s  when (enableRoundcomputing_i = '0' and enableInvMixcolumns_i='0' and rising_edge(clock_i));
	
	


	end InvAESRound_arch;

