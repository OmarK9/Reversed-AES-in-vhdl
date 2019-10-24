library AESLibrary;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use AESLibrary.state_definition_package.all;

entity RTL_MUX is
port(
    Inputl0_i: in bit128;
    Inputl1_i: in bit128;
    getCipherText_i: in std_logic;
    CipherText_o: out bit128
);
end RTL_MUX;

 
architecture RTL_MUX_Arch of RTL_MUX is
begin

Ciphertext_o<=Inputl1_i when  getCipherText_i='1' 
	 else Inputl0_i;

end RTL_MUX_Arch;




