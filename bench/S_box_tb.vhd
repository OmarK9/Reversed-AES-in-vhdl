
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;



entity  S_box_tb  is
end  entity S_box_tb;

architecture  S_box_tb_arch  of  S_box_tb  is
component  S_box
port (
S_box_i : in   bit8;
S_box_o     : out  bit8 );
end  component;

signal S_boxi_s : bit8;
signal S_boxo_s:bit8;
begin


DUT : S_box
port  map (
S_box_i    => S_boxi_s ,
S_box_o     => S_boxo_s 
);

S_boxi_s  <=  x"00";
end architecture S_box_tb_arch;



configuration S_box_tb_conf of S_box_tb is
for S_box_tb_arch
	for DUT : S_box 


use entity source.S_box(S_box_arch); 
end for ;
end for;

end configuration S_box_tb_conf ;


