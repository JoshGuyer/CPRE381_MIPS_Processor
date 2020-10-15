library IEEE;
use IEEE.std_logic_1164.all;

entity datamux21 is
generic(N : integer := 32);
   port(i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_s  : in std_logic;
	o_X  : out std_logic_vector(N-1 downto 0));
end datamux21;

architecture dataflow of datamux21 is
begin
 G1: for i in 0 to N-1 generate
  o_X(i) <= (i_B(i) AND (NOT i_s)) OR (i_A(i) AND i_s);
end generate;

end dataflow; 