library IEEE;
use IEEE.std_logic_1164.all;

--i_A +- i_B
entity ALU is
generic(N : integer := 32);
   port(i_A : in std_logic_vector(N-1 downto 0);
	i_B : in std_logic_vector(N-1 downto 0);
	nAdd_Sub : in std_logic;
	o_S : out std_logic_vector(N-1 downto 0));
end ALU;

architecture structure of ALU is

component NbitAdder
   port(i_X  : in std_logic_vector(N-1 downto 0);
	i_Y  : in std_logic_vector(N-1 downto 0);
	i_c  : in std_logic;
	o_S  : out std_logic_vector(N-1 downto 0));
end component;

component mux21
   port(i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_s  : in std_logic;
	o_X  : out std_logic_vector(N-1 downto 0));
end component;

component onesComplement
   port(i_A  : in std_logic_vector(N-1 downto 0);
	o_F  : out std_logic_vector(N-1 downto 0));
end component;

signal s_nB,s_muxB : std_logic_vector(N-1 downto 0);

begin

INVG: onesComplement
port map(i_A => i_B,
	o_F => s_nB);
	
MUX: mux21
port map(i_A => s_nB,
	i_B => i_B,
	i_s => nAdd_Sub,
	o_X => s_muxB);

FA1: NbitAdder
port map(i_X => i_A,
	i_Y => s_muxB,
	i_c => nAdd_Sub,
	o_S => o_S);

end structure;