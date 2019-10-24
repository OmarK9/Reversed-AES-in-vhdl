library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

entity KeyExpansion_table_tb is
end entity KeyExpansion_table_tb;

architecture KeyExpansion_table_tb_arch of KeyExpansion_table_tb is
component KeyExpansion_table
    Port ( round_i : in bit4;
	   expansion_key_o : out bit128);
end component;
signal round_s : bit4;
signal expansion_key_s : bit128;
begin 
	DUT : KeyExpansion_table
	Port map (
		round_i => round_s,
		expansion_key_o => expansion_key_s);

	P3: process
	begin
		round_s <= X"0";
		wait for 30 ns;
		round_s <= X"6";
		wait for 30 ns;
		round_s <= X"A";
		wait;
	end process P3;
end architecture KeyExpansion_table_tb_arch;


