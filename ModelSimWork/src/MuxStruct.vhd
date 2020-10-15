

library IEEE;
use IEEE.std_logic_1164.all;

entity MuxStruct is
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       i_S  : in std_logic;
       o_F  : out std_logic);

end MuxStruct;

architecture structure of MuxStruct is

component andg2
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       o_F  : out std_logic);
end component;

component org2
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       o_F  : out std_logic);
end component;

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

signal sVALUE_Not, sVALUE_And1, sVALUE_And2 : std_logic;

begin



not_s: invg
    port map(i_A  => i_S,
  	     o_F  => sVALUE_Not);


and_i: andg2 
   port map(i_A  => i_A,
            i_B  => sVALUE_Not,
  	        o_F  => sVALUE_And1);


and2_i: andg2 
   port map(i_A  => i_S,
             i_B  => i_B,
  	         o_F  => sVALUE_And2);

or_i: org2 
    port map(i_A  => sVALUE_And1,
             i_B  => sVALUE_And2,
  	         o_F  => o_F);


  
end structure;
