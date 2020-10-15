library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dataNbitAdder is
generic(N : integer := 32);
   port(i_X  : in unsigned(N-1 downto 0);
	i_Y  : in unsigned(N-1 downto 0);
	i_c  : in unsigned(0 downto 0);
	o_S  : out unsigned(N-1 downto 0));
end dataNbitAdder;

architecture dataflow of dataNbitAdder is

begin
o_S <= i_X + i_Y + i_C;

end dataflow;