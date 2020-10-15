library IEEE;
use IEEE.std_logic_1164.all;

entity proja is
port(
	rs : in std_logic_vector(4 downto 0);
	rt : in std_logic_vector(4 downto 0);
	rd : in std_logic_vector(4 downto 0);
	clk : std_logic;
	reg_we : in std_logic;
	data_we : in std_logic;
	imme : in std_logic_vector(15 downto 0);
	operation : in std_logic_vector(2 downto 0);
	c_LogOrAri : in std_logic;
	c_LeftOrRight : in std_logic;
	c_shamt : in std_logic_vector(4 downto 0);
	c_ALUorBS : in std_logic;
	c_sign : in std_logic;
	c_imme : in std_logic;
	c_loc : in std_logic;
	c_addsub : in std_logic);
end proja;

architecture structure of proja is
component FullALU
port(
	i_a : in std_logic_vector(31 downto 0);
	i_b : in std_logic_vector(31 downto 0);
	i_c : in std_logic;
	i_LogOrAri : in std_logic;
	i_LeftOrRight : in std_logic;
	i_shamt : in std_logic_vector(4 downto 0);
	i_ALUorBS : in std_logic;
	i_op : in std_logic_vector(2 downto 0);
	o_zero : out std_logic;
	o_c : out std_logic;
	o_of : out std_logic;
	o_F : out std_logic_vector(31 downto 0));
	
end component;
component mem
port (
	clk		: in std_logic;
	addr	        : in std_logic_vector(9 downto 0);
	data	        : in std_logic_vector(31 downto 0);
	we		: in std_logic := '1';
	q		: out std_logic_vector(31 downto 0));
end component;
component regfile
port(
	waddr : in std_logic_vector(4 downto 0);
	we    : in std_logic;
	clk   : in std_logic;
	reset : in std_logic;
	wdata : in std_logic_vector(31 downto 0);
	raddr1: in std_logic_vector(4 downto 0);
	raddr2: in std_logic_vector(4 downto 0);
	rdata1: out std_logic_vector(31 downto 0);
	rdata2: out std_logic_vector(31 downto 0));
end component;
component extender16to32
port(
	i_A   : in std_logic_vector(15 downto 0);
	c_ext : in std_logic;
	o_F   : out std_logic_vector(31 downto 0));
end component;
component mux21
port(
	i_A  : in std_logic_vector(31 downto 0);
	i_B  : in std_logic_vector(31 downto 0);
	i_s  : in std_logic;
	o_X  : out std_logic_vector(31 downto 0));
end component;

signal s_iALU1, s_iALU2, s_oALU, s_data, s_rdata2, s_wdata, s_ext32 : std_logic_vector(31 downto 0);
signal s_zero, s_c, s_of, c_regReset : std_logic;
begin
ALU: FullALU
port map(
	i_a => s_iALU1,
	i_b => s_IALU2,
	i_c => c_addsub,
	i_LogOrAri => c_LogOrAri,
	i_LeftOrRight => c_LeftOrRight,
	i_shamt => c_shamt,
	i_ALUorBS => c_ALUorBS,
	i_op => operation,
	o_zero => s_zero,
	o_c => s_c,
	o_of => s_of,
	o_F => s_oALU);
dmem: mem
port map(
	clk => clk,
	addr => s_oALU(9 downto 0),
	data => s_rdata2,
	we => data_we,
	q => s_data);
reg: regFile
port map(
	waddr => rd,
	we => reg_we,
	clk => clk,
	reset => c_regReset,
	wdata => s_wdata,
	raddr1 => rs,
	raddr2 => rt,
	rdata1 => s_iALU1,
	rdata2 => s_rdata2);
ext: extender16to32
port map(
	i_A => imme,
	c_ext => c_sign,
	o_F => s_ext32);
mux1: mux21
port map(
	i_A => s_data,
	i_B => s_oALU,
	i_s => c_loc,
	o_X => s_wdata);
mux2: mux21
port map(
	i_A => s_ext32,
	i_B => s_rdata2,
	i_s => c_imme,
	o_X => s_iALU2);
end structure;