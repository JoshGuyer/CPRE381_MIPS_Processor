library IEEE;
use IEEE.std_logic_1164.all;

entity n_dff is
generic(N :integer := 32);
port(i_d     : in std_logic_vector(N-1 downto 0);
     i_rst   : in std_logic;
     i_we    : in std_logic;
     i_CLK   : in std_logic;
     o_Q     : out std_logic_vector(N-1 downto 0));
end n_dff;

architecture structure of n_dff is 
component dff
  port(i_CLK        : in std_logic; 
       i_RST        : in std_logic;  
       i_WE         : in std_logic;  
       i_D          : in std_logic;    
       o_Q          : out std_logic);
end component;
begin
g1: for i in 0 to N-1 generate
ndff: dff
port map(i_CLK => i_CLK,
	i_rst => i_rst,
	i_we => i_we,
	i_D => i_d(i),
	o_Q => o_Q(i));
end generate;

end structure;