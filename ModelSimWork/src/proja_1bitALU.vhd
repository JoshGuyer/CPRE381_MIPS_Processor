library IEEE;
use IEEE.std_logic_1164.all;

--i_op 0: AND
--i_op 1: OR
--i_op 2: XOR
--i_op 3: NAND
--i_op 4: NOR
--i_op 5: SLT
--i_op 6: ADD/SUB
entity proja_1bitALU is
port(
	i_a : in std_logic;
	i_b : in std_logic;
	i_c : in std_logic;
	i_op : in std_logic_vector(2 downto 0);
	i_less : in std_logic;
	o_c : out std_logic;
	o_set : out std_logic;
	o_F : out std_logic);
end proja_1bitALU;

architecture structure of proja_1bitALU is 
component mux8to1
port(
	i_x0 : in std_logic;
	i_x1 : in std_logic;
	i_x2 : in std_logic;
	i_x3 : in std_logic;
	i_x4 : in std_logic;
	i_x5 : in std_logic;
	i_x6 : in std_logic;
	i_x7 : in std_logic;
	i_s  : in std_logic_vector(2 downto 0);
	o_F  : out std_logic);
end component;

component fullAdder
port(
	i_X  : in std_logic;
	i_Y  : in std_logic;
	i_c  : in std_logic;
	o_c  : out std_logic;
	o_S  : out std_logic);
end component;

component andg2
port(
	i_A   : in std_logic;
	i_B   : in std_logic;
        o_F   : out std_logic);
end component;

component org2
port(
	i_A    : in std_logic;
        i_B    : in std_logic;
        o_F    : out std_logic);
end component;

component xorg2
port(
	i_A    : in std_logic;
        i_B    : in std_logic;
        o_F    : out std_logic);

end component;

component invg
port(
	i_A    : in std_logic;
        o_F    : out std_logic);

end component;

signal s_and, s_or, s_xor, s_nand, s_nor, s_FAb, s_oFA : std_logic;

begin
GAND: andg2
port map(
	i_A => i_a,
	i_B => i_b,
	o_F => s_and);
GOR: org2
port map(
	i_A => i_a,
	i_B => i_b,
	o_F => s_or);
GXOR: xorg2
port map(
	i_A => i_a,
	i_B => i_b,
	o_F => s_xor);
GNAND: invg
port map(
	i_A => s_and,
	o_F => s_nand);
GNOR: invg
port map(
	i_A => s_or,
	o_F => s_nor);
FA: fulladder
port map(
	i_X => i_a,
	i_Y => i_b,
	i_c => i_c,
	o_c => o_c,
	o_S => s_oFA);
MUX: mux8to1
port map(
	i_x0 => s_and,
	i_x1 => s_or,
	i_x2 => s_xor,
	i_x3 => s_nand,
	i_x4 => s_nor,
	i_x5 => i_less,
	i_x6 => s_oFA,
	i_x7 => '0',
	i_s => i_op,
	o_F => o_F);
o_set <= s_oFA;
end structure;