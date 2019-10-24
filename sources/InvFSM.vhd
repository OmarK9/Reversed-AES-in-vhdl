

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library aeslibrary;
use aeslibrary.state_definition_package.all;
library source;
use source.all;


entity InvFSM is
    Port ( resetb_i : in  STD_LOGIC;
           clock_i : in  STD_LOGIC;
           start_i : in  STD_LOGIC;
	   round_i : in bit4;
	    
	   enableMixcolumns_o : out std_logic;
	   enableRoundcpting_o : out std_logic;
	   enableOutput_o : out std_logic;
	   done_o : out std_logic;
	   
	   enableCounter_o: out std_logic;
	   getciphertext_o: out std_logic;
	   resetCounter_o:out std_logic);
end InvFSM;

architecture InvFSM_arch  of InvFSM is
type state_type is (reset, Inactif,premier_invRK,CycleComplet,CycleSansInvMixColumns,Fin);--déclaration de mes états
signal etat_present, etat_futur : state_type;--les états présents et futurs
signal counting_s : bit4;--Le compteur
signal fin_premier_invRK_i : std_logic;

begin
counting_s<=round_i;

sequentiel : process(clock_i, resetb_i)--permet la transition entre etat futur et état présent à chaque coup d'horloge
begin
	if resetb_i = '0' then--au reset 
		etat_present <= reset;
	elsif rising_edge(clock_i) then--sur chaque front montant d'horloge
		etat_present <= etat_futur;--on passe à l'état futur
		
	end if;
end process;





C0 : process(etat_present, start_i, counting_s)
begin
	case etat_present is
		
		when reset =>--si l'état présent inactifau début
				if start_i = '1' then
					etat_futur <= Inactif;--On passe à l'état Inactif
				else
					etat_futur <= etat_present;--on maintient au reset
				end if;





			
		when Inactif => 
				etat_futur<=premier_invRK;

		
		when premier_invRK=>
				if (counting_s = 9) then --Pendant 9 rondes (de countig_s=9 à 1)
					etat_futur <= CycleComplet;
				else
					etat_futur <= premier_invRK;--Dans cet état on ne fera que le InvAddRoundKey
				end if;
		
		when CycleComplet =>--On fera les 4 transformations dans cet état 
				if counting_s = 1 then
					etat_futur <= CycleSansInvMixColumns;
				else
					etat_futur <= CycleComplet;
				end if;
		when CycleSansInvMixColumns => --Dans cet état on fera pas le InvMiColumns
				if (counting_s=0) then
					etat_futur <= Fin;
			
				else
					etat_futur<=CycleSansInvMixColumns;
			end if;
		
		
		when Fin =>
				if (start_i = '0') then 
				    etat_futur <= Inactif;
				else
				    etat_futur <= Fin;
				end if;

	end case;
end process C0;






C1 : process(etat_present)
		begin
			case etat_present is

			
					when Inactif=>
					done_o <= '0';
					enableCounter_o <= '0';
					enableMixColumns_o <= '0';
					enableOutPut_o <= '0';
					enableRoundcpting_o <= '0';
					getciphertext_o <= '0';
					resetCounter_o <= '0';
					


				when reset =>
					done_o <= '0';
					enableCounter_o <= '0';--Le décrémentage du compteur est désativé
					enableMixColumns_o <= '0';
					enableOutPut_o <= '0';
					enableRoundcpting_o <= '1';
					getciphertext_o <= '0';
					resetCounter_o <= '0';--Le compteur est maintenu à 10 (0xA)


				

				when premier_invRK =>
					--done_o <= '0';
					done_o<='1';
					enableCounter_o <= '1';--Le décrémentage du compteur est activé
					enableMixColumns_o <= '0';
					enableOutPut_o <= '1';
					enableRoundcpting_o <= '1';--On exécutera que InvAddRoundKey
					getciphertext_o <= '0';--on va utiliser le texte chiffré
					resetCounter_o <= '1';
				
				when CycleComplet =>
					
					done_o <= '1';
					enableCounter_o <= '1';
					enableMixColumns_o <= '1';--On active le InvMixColumns
					enableOutPut_o <= '0';
					enableRoundcpting_o <= '0';
					getciphertext_o <= '1';--On va utiliser le texte issu de la ronde précédente
					resetCounter_o <= '1';
				
		


				when CycleSansInvMixColumns=>
					done_o <= '1';
					enableCounter_o <= '1';
					enableMixColumns_o <= '0';--on désactive le InvMixColumns
					enableOutPut_o <= '1';
					enableRoundcpting_o <= '0';
					getciphertext_o <= '1';--On va utiliser le texte issu de la ronde précédente
					resetCounter_o <= '1';



			
			when Fin =>
					done_o <= '0';
					enableCounter_o <= '1';
					enableMixColumns_o <= '0';
					enableOutPut_o <= '1';
					enableRoundcpting_o <= '0';
					getciphertext_o <= '1';
					resetCounter_o <= '0';--On réinitialise le compteur à 10(0xA)
			end case;
		end process;

end InvFSM_arch;





