----------------------------------------------------------------------------
-- Entity:        ALU_4bit
-- Written By:    Robert Myers
-- Date Created:  6 Apr 22
-- Description:   VHDL model of a 4-bit ALU
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   FA
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ALU_4bit is
    port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        B    : in  STD_LOGIC_VECTOR (3 downto 0);
        F    : in  STD_LOGIC_VECTOR (2 downto 0);
        Cout : out STD_LOGIC;
        Y    : out STD_LOGIC_VECTOR (3 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ALU_4bit is

component ALUSlice is
    port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
		F    : in  STD_LOGIC_VECTOR(2 downto 0);
        Cin  : in  STD_LOGIC;
        Cout : out STD_LOGIC;
        Y    : out STD_LOGIC
    );
end component;

signal n1 : STD_LOGIC;
signal n2 : STD_LOGIC;
signal n3 : STD_LOGIC;

begin

Slice0: ALUSlice
port map(
    A => A(0),
    B => B(0),
    F => F,
    Cin => F(2),
    Cout => n1,
    Y => Y(0)
);

Slice1: ALUSlice
port map(
    A => A(1),
    B => B(1),
    F => F,
    Cin => n1,
    Cout => n2,
    Y => Y(1)
);

Slice2: ALUSlice
port map(
    A => A(2),
    B => B(2),
    F => F,
    Cin => n2,
    Cout => n3,
    Y => Y(2)
);

Slice3: ALUSlice
port map(
    A => A(3),
    B => B(3),
    F => F,
    Cin => n3,
    Cout => Cout,
    Y => Y(3)
);

    
end architecture;

