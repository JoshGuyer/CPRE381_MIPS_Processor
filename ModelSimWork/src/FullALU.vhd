library IEEE;
use IEEE.std_logic_1164.all;

--i_a: input A
--i_b: input B
--i_c: Carry in 
--i_LogOrAri: '0'-Logical '1'-Arithmetic
--i_LeftOrRight: '0'-Left '1'-Right
--i_shamt: shift amount
--i_ALUorBS: '0'-ALU '1'-BS
--i_op: Operation code
entity FullALU is
port(
	i_a : in std_logic_vector(31 downto 0);
	i_b : in std_logic_vector(31 downto 0);
	i_c : in std_logic;
	i_LogOrAri : in std_logic;
	i_LeftOrRight : in std_logic;
	i_shamt : in std_logic_vector(4 downto 0);
	i_op : in std_logic_vector(2 downto 0);
	i_unsignedOrSigned : in std_logic;
	o_zero : out std_logic;
	o_of : out std_logic;
	o_F : out std_logic_vector(31 downto 0));
	
end FullALU;

architecture structure of FullALU is
component proja_32bitALU
port(
	i_a : in std_logic_vector(31 downto 0);
	i_b : in std_logic_vector(31 downto 0);
	i_c : in std_logic;
	i_op : in std_logic_vector(2 downto 0);
	o_zero : out std_logic;
	o_c : out std_logic;
	o_of : out std_logic;
	o_F : out std_logic_vector(31 downto 0));	
end component;

component bs
port(
	i_A  : in std_logic_vector(31 downto 0);
        i_S  : in std_logic_vector(4 downto 0);
        LogOrAri : in std_logic;
        LeftOrRight : in std_logic;
        o_F  : out std_logic_vector(31 downto 0));
end component;

component mux21
port(
	i_A  : in std_logic_vector(31 downto 0);
	i_B  : in std_logic_vector(31 downto 0);
	i_s  : in std_logic;
	o_X  : out std_logic_vector(31 downto 0));
end component;

signal s_ALU, s_BS : std_logic_vector(31 downto 0);
signal s_ALUorBS, s_overflow, o_c : std_logic;


begin
s_ALUorBS <= i_op(0) AND i_op(1) AND i_op(2);
o_of <=  s_overflow AND i_unsignedOrSigned;

ALU: proja_32bitALU
port map(
	i_a => i_a,
	i_b => i_b,
	i_c => i_c,
	i_op => i_op,
	o_zero => o_zero, 
	o_c => o_c,
	o_of => s_overflow,
	o_F => s_ALU);
BS1: bs
port map(
	i_A => i_b,
        i_S => i_shamt,
        LogOrAri => i_LogOrAri,
        LeftOrRight => i_LeftOrRight, 
        o_F => s_BS);
MUX: mux21
port map(
	i_A => s_BS,
	i_B => s_ALU,
	i_s => s_ALUorBS, 
	o_X => o_F );

end structure;