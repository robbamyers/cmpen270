----------------------------------------------------------------------------
-- Entity:        Mux2to1
-- Written By:    E. George Walters
-- Date Created:  2 Feb 19
-- Description:   VHDL model of a 2 to 1 multiplexer
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Mux2to1 is
    port (
        D0  : in  STD_LOGIC;
        D1  : in  STD_LOGIC;
        SEL : in  STD_LOGIC;
        Y   : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Mux2to1 is

begin

    Y <= (not SEL and D0) or (SEL and D1);

end architecture;
