library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library AESLibrary;
use AESLibrary.state_definition_package.all;

entity KeyExpansion_table is
Port (  round_i : in bit4;
        expansion_key_o : out bit128);
end KeyExpansion_table;

architecture KeyExpansion_table_arch of KeyExpansion_table is
type key_memory is array(0 to 10) of bit128;
constant KeyMemory_s : key_memory := (
		X"2b7e151628aed2a6abf7158809cf4f3c",
		X"a0fafe1788542cb123a339392a6c7605",
		X"f2c295f27a96b9435935807a7359f67f",
		X"3d80477d4716fe3e1e237e446d7a883b",
		X"ef44a541a8525b7fb671253bdb0bad00",
		X"d4d1c6f87c839d87caf2b8bc11f915bc",
		X"6d88a37a110b3efddbf98641ca0093fd",
		X"4e54f70e5f5fc9f384a64fb24ea6dc4f",
		X"ead27321b58dbad2312bf5607f8d292f",
		X"ac7766f319fadc2128d12941575c006e",
		X"d014f9a8c9ee2589e13f0cc8b6630ca6");
begin
	expansion_key_o <= KeyMemory_s(conv_integer(round_i));
end architecture KeyExpansion_table_arch;

