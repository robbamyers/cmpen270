----------------------------------------------------------------------------
-- Entity:        Adder_4bit
-- Written By:    Robert Myers
-- Date Created:  6 Mar 22
-- Description:   VHDL model of a 4-bit ripple-carry adder
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   FA
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Adder_4bit is
    port (
        A  : in  STD_LOGIC_VECTOR (3 downto 0);
        B  : in  STD_LOGIC_VECTOR (3 downto 0);
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC_VECTOR (3 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Adder_4bit is
    component FullAdder is
        port (
            A  : in  STD_LOGIC;
            B  : in  STD_LOGIC;
            Ci : in  STD_LOGIC;
            Co : out STD_LOGIC;
            S  : out STD_LOGIC
        );
    end component;
    
    signal n0 : STD_LOGIC;
    signal n1 : STD_LOGIC;
    signal n2 : STD_LOGIC;
    
begin

    FullAdder_0: FullAdder
    port map(
        A => A(0),
        B => B(0),
        Ci => Ci,
        Co => n0,
        S => S(0)
    );
    
    FullAdder_1: FullAdder
    port map(
        A => A(1),
        B => B(1),
        Ci => n0,
        Co => n1,
        S => S(1)
    );
    FullAdder_2: FullAdder
    port map(
        A => A(2),
        B => B(2),
        Ci => n1,
        Co => n2,
        S => S(2)
    );
    FullAdder_3: FullAdder
    port map(
        A => A(3),
        B => B(3),
        Ci => n2,
        Co => Co,
        S => S(3)
    );

end architecture;

