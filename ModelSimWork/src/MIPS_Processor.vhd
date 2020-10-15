-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_rtData	: std_logic_vector(N-1 downto 0);

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  --Required ALU signals
  signal s_ALU1 : std_logic_vector(N-1 downto 0); 
  signal s_ALU2 : std_logic_vector(N-1 downto 0);
  signal s_oALU : std_logic_vector(N-1 downto 0);
  signal s_zero : std_logic;
  signal s_overflow : std_logic;
  signal s_dontcare : std_logic;

  --Required Control logic module signals
  signal c_shamtorvariable : std_logic;
  signal c_ALUorMEM : std_logic;
  signal c_signExt : std_logic;
  signal c_RTorRD : std_logic;
  signal c_logicalOrArithmetic : std_logic;
  signal c_LeftorRight : std_logic;
  signal c_unsignedOrSigned : std_logic;
  signal c_addSub : std_logic;
  signal c_opControl : std_logic_vector(2 downto 0);
  signal c_immeSel : std_logic;
  signal c_lui : std_logic;

  --Required Extentender signals
  signal s_ext : std_logic_vector(31 downto 0);

  --Required PC signals
  signal s_iPC : std_logic_vector(N-1 downto 0);

  --Required MUX signals
  signal s_RD : std_logic_vector(N-1 downto 0);
  signal s_shamtorvariable : std_logic_vector(4 downto 0);
  signal s_shamtorlui : std_logic_vector(4 downto 0);

  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment
  component n_dff
   generic(N :integer := 32);
   port(i_d     : in std_logic_vector(N-1 downto 0);
     i_rst   : in std_logic;
     i_we    : in std_logic;
     i_CLK   : in std_logic;
     o_Q     : out std_logic_vector(N-1 downto 0));
   end component;

  component mux21
   generic(N : integer :=32);
   port(i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_s  : in std_logic;
	o_X  : out std_logic_vector(N-1 downto 0));
  end component;

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

  component ControlLogicModule
    port(
	opcode : in std_logic_vector(5 downto 0);
	funct : in std_logic_vector(5 downto 0);
	immediateSelect : out std_logic;
	operationControl : out std_logic_vector(2 downto 0);
	ALUorMEM : out std_logic;
	DMEMwrite : out std_logic;
	REGwrite : out std_logic;
	RTorRD : out std_logic;
	AddorSub : out std_logic;
	unsignorSignExtend : out std_logic;
	LogorAri : out std_logic;
	LeftorRight : out std_logic;
	ShamtorVar : out std_logic;
	lui : out std_logic;
	unsignedOrSigned : out std_logic);
  end component;

  component FullALU
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
   end component;

  component extender16to32
   port(i_A : in std_logic_vector(15 downto 0);
	c_ext : in std_logic;
	o_F : out std_logic_vector(31 downto 0));
  end component;

  component NbitAdder is
   generic(N : integer := 32);
    port(i_X  : in std_logic_vector(N-1 downto 0);
	i_Y  : in std_logic_vector(N-1 downto 0);
	i_c  : in std_logic;
	o_S  : out std_logic_vector(N-1 downto 0));
  end component;

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;

  s_DMemAddr <= s_oALU;
  oALUout <= s_oALU;
  v0 <= <<signal REG.s_reg2 : std_logic_vector(N-1 downto 0)>>;

  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);
  
  REG: regFile
  port map(waddr => s_RegWrAddr,
	   we => s_RegWr,
	   clk => iCLK,
	   reset => iRST,
	   wdata => s_RegWrData,
	   raddr1 => s_Inst(25 downto 21),
	   raddr2 => s_Inst(20 downto 16),
	   rdata1 => s_ALU1,
	   rdata2 => s_rtdata);

  MUX_RDorRT: mux21
  generic map(N => 5)
  port map(i_A => s_Inst(15 downto 11),
	   i_B => s_Inst(20 downto 16),
	   i_s => c_RTorRD,
	   o_X => s_RegWrAddr);

  MUX_SHAMTorREG: mux21
  generic map(N => 5)
  port map(i_A => s_ALU1(4 downto 0),
	   i_B => s_Inst(10 downto 6),
	   i_s => c_shamtorvariable,
	   o_X => s_shamtorvariable);

  MUX_16orSHAMT: mux21
  generic map(N => 5)
  port map(i_A => "10000",
	   i_B => s_shamtorvariable,
	   i_s => c_lui,
	   o_X => s_shamtorlui);

  MUX_RTorIMME: mux21
  generic map(N => 32)
  port map(i_A => s_ext,
	   i_B => s_rtData,
	   i_s => c_immeSel,
	   o_X => s_ALU2);

  MUX_DATAorALU: mux21
  generic map(N => 32)
  port map(i_A => s_DMemData,
	   i_B => s_oALU,
	   i_s => c_ALUorMEM,
	   o_X => s_RegWrData);
  extender: extender16to32
  port map(
	i_A => s_Inst(15 downto 0),
	c_ext => c_signExt,
	o_F => s_ext);

  control: ControlLogicModule
  port map(
	opcode => s_Inst(31 downto 26),
	funct => s_Inst(5 downto 0),
	immediateSelect => c_immeSel,
	operationControl => c_opControl,
	ALUorMEM => c_ALUorMEM,
	DMEMwrite => s_DMemWr,
	REGwrite => s_RegWr,
	RTorRD => c_RTorRD,
	AddorSub => c_addSub,
	unsignorSignExtend => c_signExt,
	LogorAri => c_logicalOrArithmetic,
	LeftorRight => c_LeftorRight,
	ShamtorVar => c_shamtorvariable,
	lui => c_lui,
	unsignedOrSigned => c_unsignedOrSigned);

  ALU: FullALU
  port map(
	i_a => s_ALU1,
	i_b => s_ALU2,
	i_c => c_addSub,
	i_LogOrAri => c_logicalorArithmetic,
	i_LeftOrRight => c_LeftorRight,
	i_shamt => s_shamtorlui,
	i_op => c_opControl,
	i_unsignedOrSigned => c_unsignedOrSigned,
	o_zero => s_zero,
	o_of => s_overflow,
	o_F => s_oALU);

  PC: n_dff
    generic map(N => N)
    port map(
	i_d => s_iPC,
	i_rst => iRST,
	i_we => '1',
	i_CLK => iCLK,
	o_Q => s_NextInstAddr);

  PCALU: NbitAdder
  port map(
	i_X => s_NextInstAddr,
	i_Y => X"00000004",
	i_c => '0',
	o_S => s_iPC);

  s_Halt <='1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

  -- TODO: Implement the rest of your processor below this comment! 

end structure;
