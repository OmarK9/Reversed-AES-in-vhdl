
library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


library AESLibrary;

use AESLibrary.state_definition_package.all;

library source;
use source.all;


entity counter is


port (
	resetb_i:in STD_LOGIC;
	clock_i: in STD_LOGIC;
	counting_o:out bit4;
	enable_i:in  STD_LOGIC);

end entity counter;

architecture counter_arch of counter is
signal counting_s:integer range 0 to 10;--le comptage ira de 10 à 0

begin 
process(resetb_i,clock_i)

begin 
if resetb_i='0' then
counting_s<=10;--on réarme à 10 si le reset est à 0
elsif clock_i'event and clock_i='1' then--à chaque coup d'horloge
if enable_i='1' then --si le décomptage est activé
if counting_s=0 --si le décomptage atteint 0...
then counting_s<=10;--on réarme à 10

else
counting_s<=counting_s-1;--toujours si enable=1,et si la valeur du décomptage n'est pas nulle on décrémente
end if;
else
counting_s<=counting_s;--si on est pas sur un clock event on gare la même valeur(on fait rien)
end if;
end if;

end process;
counting_o<=std_logic_vector(To_unsigned(counting_s,4));


end architecture counter_arch;
