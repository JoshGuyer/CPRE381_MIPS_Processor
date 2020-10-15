library IEEE;
use IEEE.std_logic_1164.all;

entity norg32 is
port(
	i_x : in std_logic_vector(31 downto 0);
	o_F : out std_logic);
end norg32;

architecture dataflow of norg32 is


begin
with i_x select
	o_F <= '1' when X"00000000",
		'0' when others;
end dataflow;