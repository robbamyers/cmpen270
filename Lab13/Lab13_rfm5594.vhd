--------------------------------------------------------------------------------
-- Entity:        Lab13_StartingVHDL
-- Written By:    Robert Myers
-- Date Created:  11 Apr 22
-- Description:   CMPEN 270 Lab #13 starting VHDL
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab13_rfm5594 is
    port (
		SWITCH  : in  STD_LOGIC_VECTOR(15 downto 0);
		BTNR    : in  STD_LOGIC;
		CLK     : in  STD_LOGIC;
		LED     : out STD_LOGIC_VECTOR(15 downto 0);
		SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;
--------------------------------------------------------------------------------

architecture Structural of Lab13_rfm5594 is
component WordTo4DigitDisplayDriver is
    port (
        WORD    : in  STD_LOGIC_VECTOR(15 downto 0);
        PULSE   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
		ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;
component PulseGenerator_1ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end component;
component Counter_8bit is
    port (EN  : in  STD_LOGIC;
          CLK : in  STD_LOGIC;
          CLR : in  STD_LOGIC;
          Q   : out STD_LOGIC_VECTOR (7 downto 0));
end component;
component CompareEQU_8bit is
    port (
        A   : in  STD_LOGIC_VECTOR(7 downto 0);
        B   : in  STD_LOGIC_VECTOR(7 downto 0);
        EQU : out STD_LOGIC
    );
end component;
component PulseGenerator_125ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end component;
component LightShowROM is
    port (
        A  : in  STD_LOGIC_VECTOR(7 downto 0);
        RD : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

signal pulse_1ms : STD_LOGIC;
signal pulse_125ms : STD_LOGIC;
signal resetCount : STD_LOGIC;
signal done : STD_LOGIC;
signal readData : STD_LOGIC_VECTOR(31 downto 0);
signal address : STD_LOGIC_VECTOR(7 downto 0);

begin

resetCount <= pulse_125ms AND (BTNR OR done);
LED <= readData(15 downto 0);

Pulse: PulseGenerator_1ms
port map(
    CLK => CLK,
    PULSE => pulse_1ms
);

Words: WordTo4DigitDisplayDriver
port map(
    WORD => readData(31 downto 16),
    PULSE => pulse_1ms,
    CLK => CLK,
    SEGMENT => SEGMENT,
    ANODE => ANODE
);

Counter: Counter_8bit
port map(
    EN => pulse_125ms,
    CLK => CLK,
    CLR => resetCount,
    Q => address
);

Compare: CompareEQU_8bit
port map(
    A => SWITCH(7 downto 0),
    B => address,
    EQU => done
);
Pulse125: PulseGenerator_125ms
port map(
    CLK => CLK,
    PULSE => pulse_125ms
);
Lights: LightShowROM
port map(
    A => address,
    RD => readData
);

end architecture;
