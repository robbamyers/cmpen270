--------------------------------------------------------------------------------
-- Entity:        Lab15b_StartingVHDL
-- Written By:    Robert Myers
-- Date Created:  25 Apr 22
-- Description:   CMPEN 270 Lab #15a starting VHDL
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab15b_rfm5594 is
    port (
		SWITCH  : in  STD_LOGIC_VECTOR(15 downto 0);
		BTNL    : in  STD_LOGIC;
		BTNR    : in  STD_LOGIC;
		BTNU    : in  STD_LOGIC;
		BTND    : in  STD_LOGIC;
		CLK     : in  STD_LOGIC;
		LED     : out STD_LOGIC_VECTOR(15 downto 0);
		SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;
--------------------------------------------------------------------------------

architecture Structural of Lab15b_rfm5594 is

component Synch is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

component Debounce is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        PULSE : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

component OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

component DisplayFSM is
    port (
        MOVELEFT  : in  STD_LOGIC;
        MOVERIGHT : in  STD_LOGIC;
        P1RTS     : in  STD_LOGIC;
        P1POINT   : in  STD_LOGIC;
        P2RTS     : in  STD_LOGIC;
        P2POINT   : in  STD_LOGIC;
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        POS       : out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;

component PulseGenerator_125ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end component;

component PulseGenerator_1ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end component;

component ControlFSM is
    port (
        BTNU      : in  STD_LOGIC;
        BTNL      : in  STD_LOGIC;
        BTNR      : in  STD_LOGIC;
        POS       : in  STD_LOGIC_VECTOR(15 downto 0);
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        MOVELEFT  : out STD_LOGIC;
        MOVERIGHT : out STD_LOGIC;
        P1RTS     : out STD_LOGIC;
        P1POINT   : out STD_LOGIC;
        P2RTS     : out STD_LOGIC;
        P2POINT   : out STD_LOGIC
    );
end component;

component ScoreBoard is
    port (
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        P2SCORE : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

component WordTo4DigitDisplayDriver is
    port (
        WORD    : in  STD_LOGIC_VECTOR(15 downto 0);
        PULSE   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
		ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal pulse_1ms : STD_LOGIC;
signal pulse_125ms : STD_LOGIC;
signal btnlSyncDeb : STD_LOGIC;
signal btnlDebOne : STD_LOGIC;
signal btnlMoveLeft : STD_LOGIC;
signal btnrSyncDeb : STD_LOGIC;
signal btnrDebOne : STD_LOGIC;
signal btnrMoveRight : STD_LOGIC;
signal pos : STD_LOGIC_VECTOR(15 downto 0);
signal moveLeftControlOut : STD_LOGIC;
signal moveRightControlOut : STD_LOGIC;
signal moveLeftDisplayIn : STD_LOGIC;
signal moveRightDisplayIn : STD_LOGIC;
signal p1rts : STD_LOGIC;
signal p2rts : STD_LOGIC;
signal p1point : STD_LOGIC;
signal p2point : STD_LOGIC;
signal displayWord : STD_LOGIC_VECTOR(15 downto 0);


begin

LED <= pos;
moveLeftDisplayIn <= moveLeftControlOut AND pulse_125ms;
moveRightDisplayIn <= moveRightControlOut AND pulse_125ms;

SyncLeft: Synch
port map(
    D => BTNL,
    CLK => CLK,
    Q => btnlSyncDeb
);

SyncRight: Synch
port map(
    D => BTNR,
    CLK => CLK,
    Q => btnrSyncDeb
);

DebLeft: Debounce
port map(
    D => btnlSyncDeb,
    CLK => CLK,
    PULSE => pulse_1ms,
    Q => btnlDebOne
);

DebRight: Debounce
port map(
    D => btnrSyncDeb,
    CLK => CLK,
    PULSE => pulse_1ms,
    Q => btnrDebOne
);

OneLeft: OneShot
port map(
    D => btnlDebOne,
    CLK => CLK,
    Q => btnlMoveLeft
);

OneRight: OneShot
port map(
    D => btnrDebOne,
    CLK => CLK,
    Q => btnrMoveRight
);

Display: DisplayFSM
port map(
    MOVELEFT => moveLeftDisplayIn,
    MOVERIGHT => moveRightDisplayIn,
    P1RTS => p1rts,
    P1POINT => p1point,
    P2RTS => p2rts,
    P2POINT => p2point,
    CLK => CLK,
    RESET => BTND,
    POS => pos
);

Pulse125: PulseGenerator_125ms
port map(
    CLK => CLK,
    PULSE => pulse_125ms
);

Pulse1: PulseGenerator_1ms
port map(
    CLK => CLK,
    PULSE => pulse_1ms
);

Control: ControlFSM
port map(
    BTNU => BTNU,
    BTNL => btnlMoveLeft,
    BTNR => btnrMoveRight,
    POS => pos,
    CLK => CLK,
    RESET => BTND,
    MOVELEFT => moveLeftControlOut,
    MOVERIGHT => moveRightControlOut,
    P1RTS => p1rts,
    P1POINT => p1point,
    P2RTS => p2rts,
    P2POINT => p2point
);

Score: ScoreBoard
port map(
    P1POINT => p1point,
    P2POINT => p2point,
    CLK => CLK,
    RESET => BTND,
    P1SCORE => displayWord(15 downto 8),
    P2SCORE => displayWord(7 downto 0)
);

Words: WordTo4DigitDisplayDriver
port map(
    WORD => displayWord,
    PULSE => pulse_1ms,
    CLK => CLK,
    SEGMENT => SEGMENT,
    ANODE => ANODE
);
    
end architecture;
