

library IEEE;
use IEEE.std_logic_1164.all;

entity RBS is
	generic(Sel : integer := 5;
		    N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic_vector(Sel-1 downto 0);
	   LogOrAri: in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));

end RBS;

architecture structure of RBS is

component MuxStruct
   port(i_A  : in std_logic;
       i_B  : in std_logic;
       i_S  : in std_logic;
       o_F  : out std_logic);
end component;



signal s_1bit, s_2bit, s_4bit, s_8bit : std_logic_vector(N-1 downto 0);
signal s_shiftBit : std_logic;

begin

Log_Ari: MuxStruct
	port map(i_A => '0',
			 i_B => i_A(31),
			 i_S => LogOrAri,
			 o_F => s_shiftBit);


-- 1 bit 

Mux1_0: MuxStruct
	port map(i_A => i_A(31),
			 i_B => s_shiftBit,
			 i_S => i_S(0),
			 o_F => s_1bit(31));
			 

G1: for i in N-2 downto 0 generate
	Mux1_i: MuxStruct
	port map(i_A => i_A(i),
			 i_B => i_A(i+1),
			 i_S => i_S(0),
			 o_F => s_1bit(i));
			 
end generate;
			 

-- 2 bit 

Mux2_0: MuxStruct
	port map(i_A => s_1bit(31),
			 i_B => s_shiftBit,
			 i_S => i_S(1),
			 o_F => s_2bit(31));
			 
Mux2_1: MuxStruct
	port map(i_A => s_1bit(30),
			 i_B => s_shiftBit,
			 i_S => i_S(1),
			 o_F => s_2bit(30));
			 

G2: for i in 29 downto 0 generate
	Mux2_i: MuxStruct
	port map(i_A => s_1bit(i),
			 i_B => s_1bit(i+2),
			 i_S => i_S(1),
			 o_F => s_2bit(i));
			 
end generate;

-- 4 bit 

G4_1: for i in 31 downto 28 generate
	Mux4_i: MuxStruct
		port map(i_A => s_2bit(i),
				 i_B => s_shiftBit,
				 i_S => i_S(2),
				 o_F => s_4bit(i));
end generate;
			 
					 
G4_3: for i in 27 downto 0 generate
	Mux4_3_i: MuxStruct
	port map(i_A => s_2bit(i),
			 i_B => s_2bit(i+4),
			 i_S => i_S(2),
			 o_F => s_4bit(i));
			 
end generate;

-- 8 bit 

G8_1: for i in 31 downto 24 generate
	Mux8_i: MuxStruct
		port map(i_A => s_4bit(i),
				 i_B => s_shiftBit,
				 i_S => i_S(3),
				 o_F => s_8bit(i));
end generate;
			 
					 
G8_3: for i in 23 downto 0 generate
	Mux8_3_i: MuxStruct
	port map(i_A => s_4bit(i),
			 i_B => s_4bit(i+8),
			 i_S => i_S(3),
			 o_F => s_8bit(i));
			 
end generate;

-- 16 bit 

G16_1: for i in 31 downto 16 generate
	Mux16_i: MuxStruct
		port map(i_A => s_8bit(i),
				 i_B => s_shiftBit,
				 i_S => i_S(4),
				 o_F => o_F(i));
end generate;
			 
G16_2: for i in 15 downto 0 generate
	Mux16_2_i: MuxStruct
			port map(i_A => s_8bit(i),
					 i_B => s_8bit(i+16),
					 i_S => i_S(4),
					 o_F => o_F(i));
end generate;

			 
end structure;
