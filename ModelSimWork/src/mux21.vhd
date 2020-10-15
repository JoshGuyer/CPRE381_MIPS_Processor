library IEEE;
use IEEE.std_logic_1164.all;

--i_A output when i_s = 1
--i_B output when i_s = 0
entity mux21 is
generic(N : integer :=32);
   port(i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_s  : in std_logic;
	o_X  : out std_logic_vector(N-1 downto 0));
end mux21;

architecture structure of mux21 is 

component andg2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component org2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component invg 

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

signal i_ns : std_logic;
signal i_bns: std_logic_vector(N-1 downto 0);
signal i_as : std_logic_vector(N-1 downto 0);

begin

inv: invg
port map(i_A => i_s,
	o_F => i_ns);

G1: for i in 0 to N-1 generate
and1: andg2
port map(i_A => i_B(i),
	i_B => i_ns,
	o_F => i_bns(i));
end generate;

G2: for i in 0 to N-1 generate
and2: andg2
port map(i_A => i_A(i),
	i_B => i_s,
	o_F => i_as(i));
end generate;

G3: for i in 0 to N-1 generate
org: org2
port map(i_A => i_as(i),
	i_B => i_bns(i),
	o_F => o_X(i));
end generate;

end structure;