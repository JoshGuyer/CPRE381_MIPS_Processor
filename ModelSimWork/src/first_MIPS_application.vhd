library IEEE;
use IEEE.std_logic_1164.all;

entity first_MIPS_application is
   port(clk      : in std_logic;
	we       : in std_logic;
	ALUSrc   : in std_logic;
	nAdd_Sub : in std_logic;
	rs   : in std_logic_vector(4 downto 0);
	rt   : in std_logic_vector(4 downto 0);
	rd    : in std_logic_vector(4 downto 0);
	imme     : in std_logic_vector(31 downto 0));
end first_MIPS_application;

architecture structure of first_MIPS_application is

component regFile
port(waddr : in std_logic_vector(4 downto 0);
	we    : in std_logic;
	clk   : in std_logic;
	reset : in std_logic;
	wdata : in std_logic_vector(31 downto 0);
	raddr1: in std_logic_vector(4 downto 0);
	raddr2: in std_logic_vector(4 downto 0);
	rdata1: out std_logic_vector(31 downto 0);
	rdata2: out std_logic_vector(31 downto 0));
end component;

component mux21
generic(N : integer :=32);
   port(i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_s  : in std_logic;
	o_X  : out std_logic_vector(N-1 downto 0));
end component;

component ALU
generic(N : integer := 32);
   port(i_A : in std_logic_vector(N-1 downto 0);
	i_B : in std_logic_vector(N-1 downto 0);
	nAdd_Sub : in std_logic;
	o_S : out std_logic_vector(N-1 downto 0));
end component;


signal rdata1 : std_logic_vector(31 downto 0);
signal rdata2 : std_logic_vector(31 downto 0);
signal s_mux : std_logic_vector(31 downto 0);
signal ALUout : std_logic_vector(31 downto 0);

begin 
reg: regFile
port map(waddr => rd,
	we => we,
	clk => clk,
	reset => '0',
	wdata => ALUout,
	raddr1 => rs,
	raddr2 => rt,
	rdata1 => rdata1,
	rdata2 => rdata2);

mux: mux21
port map(i_A => imme,
	i_B => rdata1,
	i_s => ALUSrc,
	o_X => s_mux);

ALU1: ALU
port map(i_A => rdata2,
	i_B => s_mux,
	nAdd_Sub => nAdd_Sub,
	o_S => ALUout);

end structure;