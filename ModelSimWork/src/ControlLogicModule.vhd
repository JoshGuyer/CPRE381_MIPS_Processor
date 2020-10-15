library IEEE;
use IEEE.std_logic_1164.all;

entity ControlLogicModule is
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
	
end ControLLogicModule;

architecture behavioral of ControlLogicModule is
begin
process(opcode, funct)
begin
  if(opcode = "000000") then
	case funct is
		--add
		when "100000" =>
		immediateSelect <= '0';
		operationControl <= "110";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--addu
		when "100001" =>
		immediateSelect <= '0';
		operationControl <= "110";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--and
		when "100100" =>
		immediateSelect <= '0';
		operationControl <= "000";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--nor
		when "100111" =>
		immediateSelect <= '0';
		operationControl <= "100";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--xor
		when "100110" =>
		immediateSelect <= '0';
		operationControl <= "010";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--or
		when "100101" =>
		immediateSelect <= '0';
		operationControl <= "001";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--slt
		when "101010" =>
		immediateSelect <= '0';
		operationControl <= "101";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '1';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--sltu
		when "101011" =>
		immediateSelect <= '0';
		operationControl <= "101";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '1';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--sll
		when "000000" =>
		immediateSelect <= '0';
		operationControl <= "111";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--srl
		when "000010" =>
		immediateSelect <= '0';
		operationControl <= "111";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '1';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--sra
		when "000011" =>
		immediateSelect <= '0';
		operationControl <= "111";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '1';
		LeftorRight <= '1';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--sllv
		when "000100" =>
		immediateSelect <= '0';
		operationControl <= "111";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '1';
		lui <= '0';
		unsignorSignExtend <= '0';
		--srlv
		when "000110" =>
		immediateSelect <= '0';
		operationControl <= "111";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '1';
		ShamtorVar <= '1';
		lui <= '0';
		unsignorSignExtend <= '0';
		--srav
		when "000111" =>
		immediateSelect <= '0';
		operationControl <= "111";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '1';
		LeftorRight <= '1';
		ShamtorVar <= '1';
		lui <= '0';
		unsignorSignExtend <= '0';
		--sub
		when "100010" =>
		immediateSelect <= '0';
		operationControl <= "110";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '1';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--subu
		when "100011" =>
		immediateSelect <= '0';
		operationControl <= "110";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '1';
		AddorSub <= '1';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		when others =>
		immediateSelect <= '0';
		operationControl <= "000";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '0';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
	end case;
     else 
	case opcode is
		--addi
		when "001000" =>
		immediateSelect <= '1';
		operationControl <= "110";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '1';
		--addiu
		when "001001" =>
		immediateSelect <= '1';
		operationControl <= "110";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '1';
		--andi
		when "001100" =>
		immediateSelect <= '1';
		operationControl <= "000";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--lui
		when "001111" =>
		immediateSelect <= '1';
		operationControl <= "110";
		ALUorMEM <= '1';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '1';
		unsignorSignExtend <= '0';
		--lw
		when "100011" =>
		immediateSelect <= '1';
		operationControl <= "110";
		ALUorMEM <= '1';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '1';
		--xori
		when "001110" =>
		immediateSelect <= '1';
		operationControl <= "010";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--ori
		when "001101" =>
		immediateSelect <= '1';
		operationControl <= "001";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		--slti
		when "001010" =>
		immediateSelect <= '1';
		operationControl <= "101";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '1';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '1';
		--sltiu
		when "001011" =>
		immediateSelect <= '1';
		operationControl <= "101";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '1';
		RTorRD <= '0';
		AddorSub <= '1';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '1';
		--sw
		when "101011" =>
		immediateSelect <= '1';
		operationControl <= "110";
		ALUorMEM <= '0';
		DMEMwrite <= '1';
		REGwrite <= '0';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '1';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '1';
		when others =>
		immediateSelect <= '0';
		operationControl <= "000";
		ALUorMEM <= '0';
		DMEMwrite <= '0';
		REGwrite <= '0';
		RTorRD <= '0';
		AddorSub <= '0';
		unsignedOrSigned <= '0';
		LogorAri <= '0';
		LeftorRight <= '0';
		ShamtorVar <= '0';
		lui <= '0';
		unsignorSignExtend <= '0';
		end case;
  end if;
end process;
end behavioral;