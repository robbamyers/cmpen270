----------------------------------------------------------------------------
-- Entity:        Adder_2bit
-- Written By:    Robert Myers
-- Date Created:  6 Mar 22
-- Description:   VHDL model of a 2-bit ripple-carry adder
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   FA
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Adder_2bit is
    port (
        A  : in  STD_LOGIC_VECTOR (1 downto 0);
        B  : in  STD_LOGIC_VECTOR (1 downto 0);
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC_VECTOR (1 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Adder_2bit is
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
        Co => Co,
        S => S(1)
    );

end architecture;

