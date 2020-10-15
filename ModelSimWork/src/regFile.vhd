library IEEE;
use IEEE.std_logic_1164.all;

entity regFile is
   port(waddr : in std_logic_vector(4 downto 0);
	we    : in std_logic;
	clk   : in std_logic;
	reset : in std_logic;
	wdata : in std_logic_vector(31 downto 0);
	raddr1: in std_logic_vector(4 downto 0);
	raddr2: in std_logic_vector(4 downto 0);
	rdata1: out std_logic_vector(31 downto 0);
	rdata2: out std_logic_vector(31 downto 0));
end regFile;

architecture structure of regFile is
component decoder532
port(i_s    : in std_logic_vector(4 downto 0);
     o_d    : out std_logic_vector(31 downto 0));
end component;

component mux32to1
port(i_x0 : in std_logic_vector(31 downto 0);
     i_x1 : in std_logic_vector(31 downto 0);
     i_x2 : in std_logic_vector(31 downto 0);
     i_x3 : in std_logic_vector(31 downto 0);
     i_x4 : in std_logic_vector(31 downto 0);
     i_x5 : in std_logic_vector(31 downto 0);
     i_x6 : in std_logic_vector(31 downto 0);
     i_x7 : in std_logic_vector(31 downto 0);
     i_x8 : in std_logic_vector(31 downto 0);
     i_x9 : in std_logic_vector(31 downto 0);
     i_x10 : in std_logic_vector(31 downto 0);
     i_x11 : in std_logic_vector(31 downto 0);
     i_x12 : in std_logic_vector(31 downto 0);
     i_x13 : in std_logic_vector(31 downto 0);
     i_x14 : in std_logic_vector(31 downto 0);
     i_x15 : in std_logic_vector(31 downto 0);
     i_x16 : in std_logic_vector(31 downto 0);
     i_x17 : in std_logic_vector(31 downto 0);
     i_x18 : in std_logic_vector(31 downto 0);
     i_x19 : in std_logic_vector(31 downto 0);
     i_x20 : in std_logic_vector(31 downto 0);
     i_x21 : in std_logic_vector(31 downto 0);
     i_x22 : in std_logic_vector(31 downto 0);
     i_x23 : in std_logic_vector(31 downto 0);
     i_x24 : in std_logic_vector(31 downto 0);
     i_x25 : in std_logic_vector(31 downto 0);
     i_x26 : in std_logic_vector(31 downto 0);
     i_x27 : in std_logic_vector(31 downto 0);
     i_x28 : in std_logic_vector(31 downto 0);
     i_x29 : in std_logic_vector(31 downto 0);
     i_x30 : in std_logic_vector(31 downto 0);
     i_x31 : in std_logic_vector(31 downto 0);
     i_s   : in std_logic_vector(4 downto 0);
     o_F  : out std_logic_vector(31 downto 0));
end component;

component n_dff
generic(N :integer := 32);
port(i_d     : in std_logic_vector(N-1 downto 0);
     i_rst   : in std_logic;
     i_we    : in std_logic;
     i_CLK   : in std_logic;
     o_Q     : out std_logic_vector(N-1 downto 0));
end component;


signal s_wRegSel : std_logic_vector(31 downto 0);
signal s_reg0 : std_logic_vector(31 downto 0);
signal s_reg1 : std_logic_vector(31 downto 0);
signal s_reg2 : std_logic_vector(31 downto 0);
signal s_reg3 : std_logic_vector(31 downto 0);
signal s_reg4 : std_logic_vector(31 downto 0);
signal s_reg5 : std_logic_vector(31 downto 0);
signal s_reg6 : std_logic_vector(31 downto 0);
signal s_reg7 : std_logic_vector(31 downto 0);
signal s_reg8 : std_logic_vector(31 downto 0);
signal s_reg9 : std_logic_vector(31 downto 0);
signal s_reg10 : std_logic_vector(31 downto 0);
signal s_reg11 : std_logic_vector(31 downto 0);
signal s_reg12 : std_logic_vector(31 downto 0);
signal s_reg13 : std_logic_vector(31 downto 0);
signal s_reg14 : std_logic_vector(31 downto 0);
signal s_reg15 : std_logic_vector(31 downto 0);
signal s_reg16 : std_logic_vector(31 downto 0);
signal s_reg17 : std_logic_vector(31 downto 0);
signal s_reg18 : std_logic_vector(31 downto 0);
signal s_reg19 : std_logic_vector(31 downto 0);
signal s_reg20 : std_logic_vector(31 downto 0);
signal s_reg21 : std_logic_vector(31 downto 0);
signal s_reg22 : std_logic_vector(31 downto 0);
signal s_reg23 : std_logic_vector(31 downto 0);
signal s_reg24 : std_logic_vector(31 downto 0);
signal s_reg25 : std_logic_vector(31 downto 0);
signal s_reg26 : std_logic_vector(31 downto 0);
signal s_reg27 : std_logic_vector(31 downto 0);
signal s_reg28 : std_logic_vector(31 downto 0);
signal s_reg29 : std_logic_vector(31 downto 0);
signal s_reg30 : std_logic_vector(31 downto 0);
signal s_reg31 : std_logic_vector(31 downto 0);
signal writeEn : std_logic_vector(31 downto 0);

begin

dec: decoder532
   port map(i_s => waddr,
	    o_d => s_wRegSel);

AndOp: for i in 0 to 31 generate
writeEn(i) <= s_wRegSel(i) AND we;
end generate;

reg0: n_dff
   port map(i_d => X"00000000",
	    i_rst => '1',
	    i_we => '0',
	    i_clk => clk,
	    o_Q => s_reg0);

reg1: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(1),
    	    i_clk => clk,
    	    o_Q => s_reg1);

reg2: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(2),
    	    i_clk => clk,
    	    o_Q => s_reg2);

reg3: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(3),
    	    i_clk => clk,
    	    o_Q => s_reg3);

reg4: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(4),
    	    i_clk => clk,
    	    o_Q => s_reg4);

reg5: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(5),
    	    i_clk => clk,
    	    o_Q => s_reg5);

reg6: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(6),
    	    i_clk => clk,
    	    o_Q => s_reg6);

reg7: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(7),
    	    i_clk => clk,
    	    o_Q => s_reg7);

reg8: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(8),
    	    i_clk => clk,
    	    o_Q => s_reg8);

reg9: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(9),
    	    i_clk => clk,
    	    o_Q => s_reg9);

reg10: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(10),
    	    i_clk => clk,
    	    o_Q => s_reg10);

reg11: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(11),
    	    i_clk => clk,
    	    o_Q => s_reg11);

reg12: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(12),
    	    i_clk => clk,
    	    o_Q => s_reg12);

reg13: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(13),
    	    i_clk => clk,
    	    o_Q => s_reg13);

reg14: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(14),
    	    i_clk => clk,
    	    o_Q => s_reg14);

reg15: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(15),
    	    i_clk => clk,
    	    o_Q => s_reg15);

reg16: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(16),
    	    i_clk => clk,
    	    o_Q => s_reg16);

reg17: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(17),
    	    i_clk => clk,
    	    o_Q => s_reg17);

reg18: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(18),
    	    i_clk => clk,
    	    o_Q => s_reg18);

reg19: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(19),
    	    i_clk => clk,
    	    o_Q => s_reg19);

reg20: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(20),
    	    i_clk => clk,
    	    o_Q => s_reg20);

reg21: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(21),
    	    i_clk => clk,
    	    o_Q => s_reg21);

reg22: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(22),
    	    i_clk => clk,
    	    o_Q => s_reg22);

reg23: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(23),
    	    i_clk => clk,
    	    o_Q => s_reg23);

reg24: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(24),
    	    i_clk => clk,
    	    o_Q => s_reg24);

reg25: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(25),
    	    i_clk => clk,
    	    o_Q => s_reg25);

reg26: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(26),
    	    i_clk => clk,
    	    o_Q => s_reg26);

reg27: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(27),
    	    i_clk => clk,
    	    o_Q => s_reg27);

reg28: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(28),
    	    i_clk => clk,
    	    o_Q => s_reg28);

reg29: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(29),
    	    i_clk => clk,
    	    o_Q => s_reg29);

reg30: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(30),
    	    i_clk => clk,
    	    o_Q => s_reg30);

reg31: n_dff
   port map(i_d => wdata,
    	    i_rst => reset,
    	    i_we => writeEn(31),
    	    i_clk => clk,
    	    o_Q => s_reg31);
mux1: mux32to1
port map(i_x0 => s_reg0,
     i_x1 => s_reg1,
     i_x2 => s_reg2,
     i_x3 => s_reg3,
     i_x4 => s_reg4,
     i_x5 => s_reg5,
     i_x6 => s_reg6,
     i_x7 => s_reg7,
     i_x8 => s_reg8,
     i_x9 => s_reg9,
     i_x10 => s_reg10,
     i_x11 => s_reg11,
     i_x12 => s_reg12,
     i_x13 => s_reg13,
     i_x14 => s_reg14,
     i_x15 => s_reg15,
     i_x16 => s_reg16,
     i_x17 => s_reg17,
     i_x18 => s_reg18,
     i_x19 => s_reg19,
     i_x20 => s_reg20,
     i_x21 => s_reg21,
     i_x22 => s_reg22,
     i_x23 => s_reg23,
     i_x24 => s_reg24,
     i_x25 => s_reg25,
     i_x26 => s_reg26,
     i_x27 => s_reg27,
     i_x28 => s_reg28,
     i_x29 => s_reg29,
     i_x30 => s_reg30,
     i_x31 => s_reg31,
     i_s   => raddr1,
     o_F  => rdata1);

mux2: mux32to1
port map(i_x0 => s_reg0,
     i_x1 => s_reg1,
     i_x2 => s_reg2,
     i_x3 => s_reg3,
     i_x4 => s_reg4,
     i_x5 => s_reg5,
     i_x6 => s_reg6,
     i_x7 => s_reg7,
     i_x8 => s_reg8,
     i_x9 => s_reg9,
     i_x10 => s_reg10,
     i_x11 => s_reg11,
     i_x12 => s_reg12,
     i_x13 => s_reg13,
     i_x14 => s_reg14,
     i_x15 => s_reg15,
     i_x16 => s_reg16,
     i_x17 => s_reg17,
     i_x18 => s_reg18,
     i_x19 => s_reg19,
     i_x20 => s_reg20,
     i_x21 => s_reg21,
     i_x22 => s_reg22,
     i_x23 => s_reg23,
     i_x24 => s_reg24,
     i_x25 => s_reg25,
     i_x26 => s_reg26,
     i_x27 => s_reg27,
     i_x28 => s_reg28,
     i_x29 => s_reg29,
     i_x30 => s_reg30,
     i_x31 => s_reg31,
     i_s   => raddr2,
     o_F  => rdata2);
end structure;