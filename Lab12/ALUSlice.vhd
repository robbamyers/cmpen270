----------------------------------------------------------------------------
-- Entity:        ALUSlice
-- Written By:    Robert Myers
-- Date Created:  6 Apr 22
-- Description:   VHDL model of an ALU slice.
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ALUSlice is
    port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
		F    : in  STD_LOGIC_VECTOR(2 downto 0);
        Cin  : in  STD_LOGIC;
        Cout : out STD_LOGIC;
        Y    : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ALUSlice is

component FullAdder is
    port (
        A  : in  STD_LOGIC;
        B  : in  STD_LOGIC;
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC
    );
end component;

component Mux4to1 is
    port (
        D0  : in  STD_LOGIC;
        D1  : in  STD_LOGIC;
        D2  : in  STD_LOGIC;
        D3  : in  STD_LOGIC;
        SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        Y   : out STD_LOGIC
    );
end component;

component Mux2to1 is
    port (
        D0  : in  STD_LOGIC;
        D1  : in  STD_LOGIC;
        SEL : in  STD_LOGIC;
        Y   : out STD_LOGIC
    );
end component;

signal   n1 : STD_LOGIC;
signal   n2 : STD_LOGIC;
signal   n3 : STD_LOGIC;
signal   n4 : STD_LOGIC;
signal notB : STD_LOGIC;

begin

notB <= not B;
n2 <= n1 or A;
n3 <= n1 and A;


F2: Mux2to1
port map(
    D0 => B,
    D1 => notB,
    SEL => F(2),
    Y => n1
);

FA: FullAdder
port map(
    A => A,
    B => n1,
    Co => Cout,
    Ci => Cin,
    S => n4
);

F10: Mux4to1
port map(
    D3 => '0',
    D2 => n4,
    D1 => n2,
    D0 => n3,
    SEL => F(1 downto 0),
    Y => Y
    
);





end architecture;
