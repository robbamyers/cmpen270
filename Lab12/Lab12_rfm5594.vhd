--------------------------------------------------------------------------------
-- Entity:        Lab12_StartingVHDL
-- Written By:    Robert Myers
-- Date Created:  6 Apr 22
-- Description:   CMPEN 270 Lab #12 starting VHDL
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab12_rfm5594 is
    port (
		SWITCH  : in  STD_LOGIC_VECTOR(15 downto 0);
		CLK     : in  STD_LOGIC;
		LED     : out STD_LOGIC_VECTOR(15 downto 0);
		SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;
--------------------------------------------------------------------------------

architecture Structural of Lab12_rfm5594 is

component ALU_4bit is
    port (
        A    : in  STD_LOGIC_VECTOR (3 downto 0);
        B    : in  STD_LOGIC_VECTOR (3 downto 0);
        F    : in  STD_LOGIC_VECTOR (2 downto 0);
        Cout : out STD_LOGIC;
        Y    : out STD_LOGIC_VECTOR (3 downto 0)
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

component PulseGenerator_1ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end component;

signal displayWord : STD_LOGIC_VECTOR(15 downto 0);
signal ALU_Cout : STD_LOGIC;
signal ALU_Y : STD_LOGIC_VECTOR(3 downto 0);
signal pulse_1ms : STD_LOGIC;

begin

displayWord(15 downto 12) <= SWITCH(15 downto 12);
displayWord(11 downto 8) <= SWITCH(11 downto 8);
displayWord(7 downto 5) <= "000";
displayWord(4) <= ALU_Cout;
displayWord(3 downto 0) <= ALU_Y;
LED <= displayWord;


ALU: ALU_4bit
port map(
    A(3 downto 0) => SWITCH(15 downto 12),
    B(3 downto 0) => SWITCH(11 downto 8),
    F(2 downto 0) => SWITCH(2 downto 0),
    Cout => ALU_Cout,
    Y(3 downto 0) => ALU_Y(3 downto 0)
);

Pulse: PulseGenerator_1ms
port map(
    CLK => CLK,
    PULSE => pulse_1ms
);

Words: WordTo4DigitDisplayDriver
port map(
    WORD => displayWord,
    PULSE => pulse_1ms,
    SEGMENT => SEGMENT,
    ANODE => ANODE,
    CLK => CLK
);

end architecture;
