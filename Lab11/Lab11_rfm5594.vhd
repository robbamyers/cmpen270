--------------------------------------------------------------------------------
-- Entity:        Lab11_StartingVHDL
-- Written By:    Robert Myers
-- Date Created:  3 Apr 22
-- Description:   CMPEN 270 Lab #11 starting VHDL
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab11_rfm5594 is
    port (
		SWITCH  : in  STD_LOGIC_VECTOR(15 downto 0);
        BTNR    : in  STD_LOGIC;
        BTNU    : in  STD_LOGIC;
		CLK     : in  STD_LOGIC;
		LED     : out STD_LOGIC_VECTOR(15 downto 0);
		SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;
--------------------------------------------------------------------------------

architecture Structural of Lab11_rfm5594 is

component PulseGenerator_1ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
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

component Counter_4bit is
    port (
        EN   : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        ROLL : out STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

component OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

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

signal         pulse_1ms : STD_LOGIC;
signal       displayWord : STD_LOGIC_VECTOR(15 downto 0);
signal          BTNU_ons : STD_LOGIC;
signal     BTNU_sync_ons : STD_LOGIC;
signal BTNU_sync_deb_ons : STD_LOGIC;
signal         BTNU_sync : STD_LOGIC;
signal     BTNU_sync_deb : STD_LOGIC;

begin

Pulse: PulseGenerator_1ms
port map(
    CLK => CLK,
    PULSE => pulse_1ms
);

Word: WordTo4DigitDisplayDriver
port map(
    PULSE => pulse_1ms,
    CLK => CLK,
    WORD(15 downto 0) => displayWord(15 downto 0),
    SEGMENT(0 to 6) => SEGMENT(0 to 6),
    ANODE(3 downto 0) => ANODE(3 downto 0)
);

Counter0: Counter_4bit
port map(
    EN => BTNU,
    CLK => CLK,
    CLR => BTNR,
    Q(3 downto 0) => displayWord(15 downto 12)
);

Counter1: Counter_4bit
port map(
    EN => BTNU_ons,
    CLK => CLK,
    CLR => BTNR,
    Q(3 downto 0) =>  displayWord(11 downto 8)  
);

Counter2: Counter_4bit
port map(
    EN => BTNU_sync_ons,
    CLK => CLK,
    CLR => BTNR,
    Q(3 downto 0) => displayWord(7 downto 4)
);

Counter3: Counter_4bit
port map(
    EN => BTNU_sync_deb_ons,
    CLK => CLK,
    CLR => BTNR,
    Q(3 downto 0) => displayWord(3 downto 0)
);

OneShot0: OneShot
port map(
    D => BTNU,
    CLK => CLK,
    Q => BTNU_ons
);

OneShot1: OneShot
port map(
    D => BTNU_sync,
    CLK => CLK,
    Q => BTNU_sync_ons
);

OneShot2: OneShot
port map(
    D => BTNU_sync_deb,
    CLK => CLK,
    Q => BTNU_sync_deb_ons
);

Synch0: Synch
port map(
    D => BTNU,
    CLK => CLK,
    Q => BTNU_sync
);

Deb: Debounce
port map(
    D => BTNU_sync,
    CLK => CLK,
    PULSE => pulse_1ms,
    Q => BTNU_sync_deb
);


end architecture;
