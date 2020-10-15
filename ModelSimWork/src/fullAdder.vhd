library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is
   port(i_X  : in std_logic;
	i_Y  : in std_logic;
	i_c  : in std_logic;
	o_c  : out std_logic;
	o_S  : out std_logic);
end fullAdder;

architecture structure of fullAdder is

component andg2 
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component org2 
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component xorg2 
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

signal s_xXORy,s_xANDy, s_xORy, s_cANDxy : std_logic;
begin
G1: xorg2
port map(i_A => i_X,
	i_B => i_Y,
	o_F => s_xXORy);
G2: xorg2
port map(i_A => s_xXORy,
	i_B => i_c,
	o_F => o_S);
G3: org2
port map(i_A => i_X,
	i_B => i_Y,
	o_F => s_xORy);
G4: andg2
port map(i_A => i_X,
	i_B => i_Y,
	o_F => s_xANDy);
G5: andg2
port map(i_A => s_xORy,
	i_B => i_c,
	o_F => s_cANDxy);
G6: org2
port map(i_A =>s_cANDxy,
	i_B => s_xANDy,
	o_F => o_C);

end structure;