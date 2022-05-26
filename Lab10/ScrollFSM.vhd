----------------------------------------------------------------------------
-- Entity:        ScrollFSM
-- Written By:    Robert Myers
-- Date Created:  24 Mar 22
-- Description:   VHDL model of a scrolling display FSM
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScrollFSM is
    port (
        L       : in  STD_LOGIC;
        R       : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        DISPLAY : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ScrollFSM is

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
signal        s1 : STD_LOGIC;
signal        s0 : STD_LOGIC;

begin

nextState(1) <= (R and not s1 and s0) or (L and not s1 and not s0) or (not L and s1 and not s0) or (not R and s1 and s0);
nextState(0) <= (not L and not R and s0) or (R and not s0) or (L and not s0);
DISPLAY(1) <= s1;
DISPLAY(0) <= s0;

Reg: Reg_Load_CLR_2bit
port map(
    D(1 downto 0) => nextState(1 downto 0),
    CLK => CLK,
    CLR => RESET,
    Q(1) => s1,
    Q(0) => s0,
    LOAD => '1'
);


end architecture;
