library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

library AESLibrary;

use AESLibrary.state_definition_package.all;


entity InvMixColumns is

port(

	--il faudrait savoir quel numÃ©ro de colonne il s'agit
	state_matrix_o:out type_state;
	state_matrix_i :in type_state);

end entity InvMixColumns;

architecture InvMixColumns_arch of InvMixColumns is

--chaque colonne coli_s aura comme coefficients les coefficients de col1_s multipliées par i (i en héxa) , puis on va extraire les coefficients en fonction de la ligne du coefficient résultat
 --ex:comme s'0,c=0e*s0,c+0b*s1,c+0d*s2,c+09*s2,c
--alors s0,c sera multiplié par le coefficient 0 de la colonne cole_s
--plus s1,c multiplié par le coefficient 1 de la colonne colb_s etc...

signal col1_s:type_state;
signal col2_s:type_state;
signal col4_s:type_state;
signal col8_s:type_state;
signal col9_s:type_state;
signal colb_s:type_state;
signal cold_s:type_state;
signal cole_s:type_state;


--On sait que multiplier par deux revient à décaler à gauche
--on prenant garde si le bit de poids fort est égal àƒ  1 ou pas




--on crée un signal représentant la matrice résultat
signal column_resultat_s:type_state;


begin

RemplissageMatriceTotaleGen:for j in 0 to 3 generate
	Gen:for i in 0 to 3 generate
		
		col2_s(i)(j)<=state_matrix_i(i)(j)(6 downto 0)&"0" xor "000"&state_matrix_i(i)(j)(7)&state_matrix_i(i)(j)(7)&"0"&state_matrix_i(i)(j)(7)&state_matrix_i(i)(j)(7);
		
		

		
		col4_s(i)(j)<=col2_s(i)(j)(6 downto 0)&"0" xor "000"&col2_s(i)(j)(7)&col2_s(i)(j)(7)&"0"&col2_s(i)(j)(7)&col2_s(i)(j)(7);
	

	
		col8_s(i)(j)<=col4_s(i)(j)(6 downto 0)&"0"xor "000"&col4_s(i)(j)(7)&col4_s(i)(j)(7)&"0"&col4_s(i)(j)(7)&col4_s(i)(j)(7);
		
	--le reste des colonnes multipliées seront fonction des sommes des colonne2,colonne4,et colonne8
	col9_s(i)(j)<=col8_s(i)(j) xor  state_matrix_i(i)(j);
	colb_s(i)(j)<=col8_s(i)(j) xor  col2_s(i)(j) xor state_matrix_i(i)(j);
	cold_s(i)(j)<=col8_s(i)(j) xor  col4_s(i)(j) xor state_matrix_i(i)(j);
	cole_s(i)(j)<=col8_s(i)(j) xor  col4_s(i)(j) xor  col2_s(i)(j);

	
	end generate;--end generate du i
--il ne reste plus qu'à rassembler les colonnes dans la matrice résultat

	state_matrix_o(0)(j)<=cole_s(0)(j) xor  cold_s(2)(j) xor colb_s(1)(j) xor  col9_s(3)(j);
	state_matrix_o(1)(j)<=cole_s(1)(j) xor  cold_s(3)(j) xor  colb_s(2)(j) xor  col9_s(0)(j);
	state_matrix_o(2)(j)<=cole_s(2)(j) xor  cold_s(0)(j) xor  colb_s(3)(j) xor col9_s(1)(j);
	state_matrix_o(3)(j)<=cole_s(3)(j) xor cold_s(1)(j) xor colb_s(0)(j)xor  col9_s(2)(j);

	

end generate;--generate du j
end  architecture InvMixColumns_arch;


	

