----------------------------------------------------------------------------
-- Entity:        OneShot
-- Written By:    Robert Myers
-- Date Created:  24 Mar 22
-- Description:   VHDL model of a one-shot (rising edge detector)
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of OneShot is
component Reg_LOAD_CLR_2bit is
    port (
        D    : in  STD_LOGIC_VECTOR(1 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
end component;

signal nextState : STD_LOGIC_VECTOR(1 downto 0);
signal currentState : STD_LOGIC_VECTOR(1 downto 0);

begin

nextState(1) <= D and currentState(0);
nextState(0) <= not D;
Q <= currentState(1);

Reg: Reg_LOAD_CLR_2bit
port map(
    D(1 downto 0) => nextState(1 downto 0),
    CLK => CLK,
    CLR => '0',
    LOAD => '1',
    Q(1 downto 0) => currentState(1 downto 0)
);

end architecture;

