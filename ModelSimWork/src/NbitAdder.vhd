library IEEE;
use IEEE.std_logic_1164.all;

entity NbitAdder is
generic(N : integer := 32);
   port(i_X  : in std_logic_vector(N-1 downto 0);
	i_Y  : in std_logic_vector(N-1 downto 0);
	i_c  : in std_logic;
	o_S  : out std_logic_vector(N-1 downto 0));
end NbitAdder;

architecture structure of NbitAdder is

component fullAdder 
   port(i_X  : in std_logic;
	i_Y  : in std_logic;
	i_c  : in std_logic;
	o_c  : out std_logic;
	o_S  : out std_logic);
end component;
signal c : std_logic_vector(N downto 0);
begin
c(0) <= i_c;
G1: for i in 0 to N-1 generate
FA: fullAdder
port map(i_X => i_X(i),
	i_Y => i_Y(i),
	i_c => c(i),
	o_c => c(i+1),
	o_S => o_S(i));
end generate;

end structure;