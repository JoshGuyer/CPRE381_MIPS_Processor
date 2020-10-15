library IEEE;
use IEEE.std_logic_1164.all;

entity datafullAdder is
   port(i_X  : in std_logic;
	i_Y  : in std_logic;
	i_c  : in std_logic;
	o_c  : out std_logic;
	o_S  : out std_logic);
end datafullAdder;

architecture dataflow of datafullAdder is

begin
o_C <= (i_X AND i_Y) OR (i_c AND (i_Y OR i_X));
o_S <= i_X XOR i_Y XOR i_c;

end dataflow;