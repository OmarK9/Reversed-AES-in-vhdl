library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity InvSubBytes is

port(
	donnee_i:in type_state;
	donnee_o:out type_state);

end entity InvSubBytes;

architecture InvSubBytes_arch of InvSubBytes is

component S_box--On va utiliser la S_box donc on l'instancie ici
port(
	S_box_i:in bit8;
	S_box_o:out bit8
	);
end component;

begin
	Gen1:for i in 0 to 3 generate--On opère deux generate pour remplir toute la matrice
		Gen2:for j in 0 to 3 generate
		InvSubBytes:S_box
			port map(
				S_box_i=>donnee_i(i)(j),
				S_box_o=>donnee_o(i)(j) );--La  matrice d'état de sortie va être  remplie en allant chercher    dans la Sbox les élément d'indices donnee_i(i)(j)

			end generate;
		end generate;

end InvSubBytes_arch;


