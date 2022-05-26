--------------------------------------------------------------------------------
-- Entity:        Lab10_StartingVHDL
-- Written By:    Robert Myers
-- Date Created:  24 Mar 22
-- Description:   CMPEN 270 Lab #10 starting VHDL for top level
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab10_rfm5594 is
    port (
		SWITCH  : in  STD_LOGIC_VECTOR(15 downto 0);
        BTNL    : in  STD_LOGIC;
        BTNR    : in  STD_LOGIC;
        BTND    : in  STD_LOGIC;
		CLK     : in  STD_LOGIC;
		LED     : out STD_LOGIC_VECTOR(15 downto 0);
		SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;
--------------------------------------------------------------------------------

architecture Structural of Lab10_rfm5594 is

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

component ScrollFSM is
    port (
        L       : in  STD_LOGIC;
        R       : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        DISPLAY : out STD_LOGIC_VECTOR(1 downto 0)
    );
end component;

component OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;

component DisplayDecoder is
    port (
        A : in  STD_LOGIC_VECTOR(1  downto 0);
        Y : out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;

signal   pulse_1ms : STD_LOGIC;
signal displayWord : STD_LOGIC_VECTOR(15 downto 0);
signal displayCode : STD_LOGIC_VECTOR(1 downto 0);
signal    BTNL_ons : STD_LOGIC;
signal    BTNR_ons : STD_LOGIC;

begin

LED(15 downto 14) <= displayCode(1 downto 0);

Pulse: PulseGenerator_1ms
port map(
    CLK => CLK,
    PULSE => pulse_1ms
);

Word: WordTo4DigitDisplayDriver
port map(
    WORD => displayWord(15 downto 0),
    PULSE => pulse_1ms,
    CLK => CLK,
    SEGMENT(0 to 6) => SEGMENT(0 to 6),
    ANODE(3 downto 0) => ANODE(3 downto 0)
);

Scroll: ScrollFSM
port map(
    L => BTNL_ons,
    R => BTNR_ons,
    CLK => CLK,
    RESET => BTND,
    DISPLAY(1 downto 0) => LED(15 downto 14)
);

OneShotL: OneShot
port map(
    D => BTNL,
    CLK => CLK,
    Q => BTNL_ons
);

OneShotR: OneShot
port map(
    D => BTNR,
    CLK => CLK,
    Q => BTNR_ons
);

Decoder: DisplayDecoder
port map(
    A(1 downto 0) => displayCode(1 downto 0),
    Y(15 downto 0) => displayWord(15 downto 0)
);

end architecture;
