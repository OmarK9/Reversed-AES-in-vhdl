library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;
library source;
use AESLibrary.state_definition_package.all;

entity InvShiftRows is

port(
	donnee_i:in type_state;
	donnee_o:out type_state
);

end entity InvShiftRows;

architecture InvShiftRows_arch of InvShiftRows is
begin
	GenR:for i in 0 to 3 generate
		GenC:for j in 0 to 3 generate
			donnee_o(i)(j)<=donnee_i(i)((j-i)mod 4);--des calculs empiriques faits à la main m'ont conduit à trouver cette formule
		end generate;



	end generate;


end  InvShiftRows_arch;

		
