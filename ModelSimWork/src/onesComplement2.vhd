library IEEE;
use IEEE.std_logic_1164.all;

entity onesComplement2 is
generic(N  : integer := 32);
  port(i_A  :  in std_logic_vector(N-1 downto 0);
	o_f  :  out std_logic_vector(N-1 downto 0));
end onesComplement2;

architecture dataflow of onesComplement2 is

begin 

o_F <= NOT i_A;


end dataflow;