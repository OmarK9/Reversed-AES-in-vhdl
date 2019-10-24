library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;

use AESLibrary.state_definition_package.all;
library source;
use source.all;
entity InvAddRoundKey is
port(
	donnee_i:in type_state;
	key_i:in type_state;
	donnee_o:out type_state

);

end InvAddRoundKey;

architecture InvAddRoundKey_arch of InvAddRoundKey is

	begin

	Gc:for i in 0 to 3 generate
		Gl:for j in 0 to 3 generate--Pour toutes les colonnes de la matrice
			donnee_o(i)(j)<=donnee_i(i)(j) xor key_i(i)(j);--On effectue le xor entre la colonne j de la matrice et le clef courante J
		end generate;
	end generate;
end architecture InvAddRoundKey_arch;

