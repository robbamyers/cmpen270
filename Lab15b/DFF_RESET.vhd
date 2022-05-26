----------------------------------------------------------------------------
-- Entity:        DFF_RESET
-- Written By:    Robert Myers
-- Date Created:  22 Feb 22
-- Description:   VHDL model of a D flip-flop with reset
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity DFF_RESET is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of DFF_RESET is
    component DFF is
        port (
            D    : in  STD_LOGIC;
            CLK  : in  STD_LOGIC;
            Q    : out STD_LOGIC
        );
    end component;

    signal n1 : STD_LOGIC;

begin

    n1 <= D and not RESET;

    DFF_2: DFF
    port map (
        D => n1,
        CLK => CLK,
        Q => Q
    );

end architecture;
