--------------------------------------------------------------------------------
-- Entity:        Lab09_rfm5594
-- Written By:    Robert Myers
-- Date Created:  19 Mar 22
-- Description:   CMPEN 270 Lab #9 starting VHDL for top level
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab09_rfm5594 is
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

architecture Structural of Lab09_rfm5594 is

component TrafficLightFSM is
    port (
        TA    : in  STD_LOGIC;
        TB    : in  STD_LOGIC;
        PULSE : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        LA    : out STD_LOGIC_VECTOR(2 downto 0);
        LB    : out STD_LOGIC_VECTOR(2 downto 0)
    );
end component;

component PulseGenerator_5sec is
    port (
        EN     : in  STD_LOGIC;
        CLK    : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        STATUS : out STD_LOGIC_VECTOR(4 downto 1);
        PULSE  : out STD_LOGIC
    );
end component;

signal pulse_5sec : STD_LOGIC;

begin

fsm: TrafficLightFSM
port map(
    TA => SWITCH(13),
    TB => SWITCH(0),
    PULSE => pulse_5sec,
    CLK => CLK,
    RESET => BTNR,
    LA(2 downto 0) => LED(15 downto 13),
    LB(2 downto 0) => LED(2 downto 0)
);

pulse: PulseGenerator_5sec
port map(
    EN => '1',
    RESET => BTNR,
    CLK => CLK,
    PULSE => pulse_5sec,
    STATUS(4 downto 1) => LED(9 downto 6)
);

    LED(12 downto 10) <= "000";
    LED(5 downto 3) <= "000";
    SEGMENT <= "1111111";
    ANODE   <= "1111";

end architecture;
