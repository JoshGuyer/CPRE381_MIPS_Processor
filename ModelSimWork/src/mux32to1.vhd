library IEEE;
use IEEE.std_logic_1164.all;

entity mux32to1 is
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
end mux32to1;

architecture dataflow of mux32to1 is 

begin
with i_s select
   o_F <= i_x0  when "00000",
	  i_x1  when "00001",
	  i_x2  when "00010",
	  i_x3  when "00011",
	  i_x4  when "00100",
	  i_x5  when "00101",
	  i_x6  when "00110",
	  i_x7  when "00111",
	  i_x8  when "01000",
	  i_x9  when "01001",
	  i_x10 when "01010",
	  i_x11 when "01011",
	  i_x12 when "01100",
	  i_x13 when "01101",
	  i_x14 when "01110",
	  i_x15 when "01111",
	  i_x16 when "10000",
	  i_x17 when "10001",
	  i_x18 when "10010",
	  i_x19 when "10011",
	  i_x20 when "10100",
	  i_x21 when "10101",
	  i_x22 when "10110",
	  i_x23 when "10111",
	  i_x24 when "11000",
	  i_x25 when "11001",
	  i_x26 when "11010",
	  i_x27 when "11011",
	  i_x28 when "11100",
	  i_x29 when "11101",
	  i_x30 when "11110",
	  i_x31 when "11111",
	  "00000000000000000000000000000000" when others;
end dataflow;