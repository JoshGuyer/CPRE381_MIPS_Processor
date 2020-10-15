library IEEE;
use IEEE.std_logic_1164.all;

entity proja_32bitALU is
port(
	i_a : in std_logic_vector(31 downto 0);
	i_b : in std_logic_vector(31 downto 0);
	i_c : in std_logic;
	i_op : in std_logic_vector(2 downto 0);
	o_zero : out std_logic;
	o_c : out std_logic;
	o_of : out std_logic;
	o_F : out std_logic_vector(31 downto 0));
	
end proja_32bitALU;

architecture structure of proja_32bitALU is
component proja_1bitALU
port(
	i_a : in std_logic;
	i_b : in std_logic;
	i_c : in std_logic;
	i_op : in std_logic_vector(2 downto 0);
	i_less : in std_logic;
	o_c : out std_logic;
	o_set : out std_logic;
	o_F : out std_logic);
end component;

signal s_carry : std_logic_vector(32 downto 0);
signal s_set : std_logic_vector(31 downto 0);

component norg32
port(
	i_x : in std_logic_vector(31 downto 0);
	o_F : out std_logic);
end component;

component xorg2 is
  port(
	i_A          : in std_logic;
        i_B          : in std_logic;
        o_F          : out std_logic);
end component;

begin
s_carry(0) <= i_c;
o_c <= s_carry(32);

G1: for i in 1 to 31 generate
ALU1bit: proja_1bitALU
port map(
	i_a => i_a(i),
	i_b => (i_b(i) XOR i_c),
	i_c => s_carry(i),
	i_op => i_op,
	i_less => '0',
	o_c => s_carry(i+1),
	o_set => s_set(i),
	o_F => o_F(i));
end generate;

ALU1bit: proja_1bitALU
port map(
	i_a => i_a(0),
	i_b => (i_b(0) XOR i_c),
	i_c => s_carry(0),
	i_op => i_op,
	i_less => s_set(31),
	o_c => s_carry(1),
	o_set => s_set(0),
	o_F => o_F(0));

NORG: norg32
port map(
	i_x => o_F,
	o_F => o_zero);

GXOR: xorg2
port map(
	i_A => i_c,
	i_B => o_c,
	o_F => o_of);
end structure;