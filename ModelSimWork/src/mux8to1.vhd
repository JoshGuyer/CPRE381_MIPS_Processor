library IEEE;
use IEEE.std_logic_1164.all;

entity mux8to1 is
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
end mux8to1;

architecture dataflow of mux8to1 is

begin
 with i_s select
	o_F <= i_x0 when "000",
	       i_x1 when "001",
	       i_x2 when "010",
	       i_x3 when "011",
	       i_x4 when "100",
	       i_x5 when "101",
	       i_x6 when "110",
	       i_x7 when "111",
	       '0' when others;
end dataflow;