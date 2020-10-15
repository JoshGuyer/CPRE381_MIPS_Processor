library IEEE;
use IEEE.std_logic_1164.all;

entity decoder532 is
port(i_s    : in std_logic_vector(4 downto 0);
     o_d    : out std_logic_vector(31 downto 0));
end decoder532;

architecture dataflow of decoder532 is

begin
   with i_s select
	o_d <=  X"00000001" when "00000",
		X"00000002" when "00001",
		X"00000004" when "00010",
		X"00000008" when "00011",
		X"00000010" when "00100",
		X"00000020" when "00101",
		X"00000040" when "00110",
		X"00000080" when "00111",
		X"00000100" when "01000",
		X"00000200" when "01001",
		X"00000400" when "01010",
		X"00000800" when "01011",
		X"00001000" when "01100",
		X"00002000" when "01101",
		X"00004000" when "01110",
		X"00008000" when "01111",
		X"00010000" when "10000",
		X"00020000" when "10001",
		X"00040000" when "10010",
		X"00080000" when "10011",
		X"00100000" when "10100",
		X"00200000" when "10101",
		X"00400000" when "10110",
		X"00800000" when "10111",
		X"01000000" when "11000",
		X"02000000" when "11001",
		X"04000000" when "11010",
		X"08000000" when "11011",
		X"10000000" when "11100",
		X"20000000" when "11101",
		X"40000000" when "11110",
		X"80000000" when "11111",
		X"00000000" when others;
end dataflow;