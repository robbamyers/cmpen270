----------------------------------------------------------------------------
-- Entity:        ScoreBoardDatapath
-- Written By:    E. George Walters
-- Date Created:  19 Apr 19
-- Description:   VHDL model of the score board datapath for a Pong game
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   FA
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScoreBoardDatapath is
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
end entity;
----------------------------------------------------------------------------

architecture Structural of ScoreBoardDatapath is

component Reg_LOAD_CLR_8bit is
    port (
        D    : in  STD_LOGIC_VECTOR(7 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

component Adder_8bit is
    port (
        A   : in  STD_LOGIC_VECTOR (7 downto 0);
        B   : in  STD_LOGIC_VECTOR (7 downto 0);
        SUM : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

component CompareEQU_4bit is
    port (
        A   : in  STD_LOGIC_VECTOR(3 downto 0);
        B   : in  STD_LOGIC_VECTOR(3 downto 0);
        EQU : out STD_LOGIC
    );
end component;

component Mux2to1_8bit is
    port (
        D0  : in  STD_LOGIC_VECTOR (7 downto 0);
        D1  : in  STD_LOGIC_VECTOR (7 downto 0);
        SEL : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

signal regIn : STD_LOGIC_VECTOR(7 downto 0);
signal P1SCORE_int : STD_LOGIC_VECTOR(7 downto 0);
signal P2SCORE_int : STD_LOGIC_VECTOR(7 downto 0);
signal muxOutAddB : STD_LOGIC_VECTOR(7 downto 0);
signal muxOutAddA : STD_LOGIC_VECTOR(7 downto 0);

begin

P2SCORE <= P2SCORE_int;
P1SCORE <= P1SCORE_int;

Reg1: Reg_LOAD_CLR_8bit
port map(
    LOAD => LOADP1,
    CLK => CLK,
    CLR => RESET,
    D => regIn,
    Q => P1SCORE_int
);

Reg2: Reg_LOAD_CLR_8bit
port map(
    LOAD => LOADP2,
    CLK => CLK,
    CLR => RESET,
    D => regIn,
    Q => P2SCORE_int
);

Mux1: Mux2to1_8bit
port map(
    SEL => P1ORP2,
    D0 => P1SCORE_int,
    D1 => P2SCORE_int,
    Y => muxOutAddB
);

Mux2: Mux2to1_8bit
port map(
    SEL => ADD1OR6,
    D0 => "00000001",
    D1 => "00000110",
    Y => muxOutAddA
);

Add: Adder_8bit
port map(
    A => muxOutAddA,
    B => muxOutAddB,
    SUM => regIn
);

Compare: CompareEQU_4bit
port map(
    A => muxOutAddB(3 downto 0),
    B => "1010",
    EQU => EQU10
);


end architecture;
