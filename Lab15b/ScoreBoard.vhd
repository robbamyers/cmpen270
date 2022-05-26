----------------------------------------------------------------------------
-- Entity:        ScoreBoard
-- Written By:    E. George Walters
-- Date Created:  19 Apr 19
-- Description:   VHDL model of the score board for a Pong game
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScoreBoard is
    port (
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        P2SCORE : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ScoreBoard is

component ScoreBoardDatapath is
    port (
        LOADP1  : in  STD_LOGIC;
        LOADP2  : in  STD_LOGIC;
        P1ORP2  : in  STD_LOGIC;
        ADD1OR6 : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        P2SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        EQU10   : out STD_LOGIC
    );
end component;

component ScoreBoardFSM is
    port (
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        EQU10   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        LOADP1  : out STD_LOGIC;
        LOADP2  : out STD_LOGIC;
        P1ORP2  : out STD_LOGIC;
        ADD1OR6 : out STD_LOGIC
    );
end component;

signal equSig : STD_LOGIC;
signal loadP1sig : STD_LOGIC;
signal loadP2sig : STD_LOGIC;
signal p1OrP2sig : STD_LOGIC;
signal add1or6sig : STD_LOGIC;

begin

FSM: ScoreBoardFSM
port map(
    P1POINT => P1POINT,
    P2POINT => P2POINT,
    EQU10 => equSig,
    CLK => CLK,
    RESET => RESET,
    LOADP1 => loadP1Sig,
    LOADP2 => loadP2Sig,
    P1ORP2 => p1OrP2sig,
    ADD1OR6 => add1or6sig
);

Datapath: ScoreBoardDatapath
port map(
    LOADP1 => loadP1Sig,
    LOADP2 => loadP2Sig,
    P1ORP2 => p1OrP2sig,
    ADD1OR6 => add1or6sig,
    CLK => CLK,
    RESET => RESET,
    P1SCORE => P1SCORE,
    P2SCORE => P2SCORE,
    EQU10 => equSig
);

end architecture;
