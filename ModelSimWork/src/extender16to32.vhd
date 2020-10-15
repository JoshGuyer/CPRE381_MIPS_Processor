library IEEE;
use IEEE.std_logic_1164.all;

entity extender16to32 is
   port(i_A : in std_logic_vector(15 downto 0);
	c_ext : in std_logic;
	o_F : out std_logic_vector(31 downto 0));
end extender16to32;

architecture behavior of extender16to32 is
begin
for1: for i in 0 to 15 generate
	o_F(i) <= i_A(i);		
end generate;
for2: for i in 16 to 31 generate
	o_F(i) <= (c_ext AND i_A(15));		
end generate;
end behavior;