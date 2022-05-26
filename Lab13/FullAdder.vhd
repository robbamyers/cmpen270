----------------------------------------------------------------------------
-- Entity:        FullAdder
-- Written By:    Robert Myers
-- Date Created:  6 Mar 22
-- Description:   VHDL model of a full adder.  Adds three bits, producing
--   a sum and a carry-out bit
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity FullAdder is
    port (
        A  : in  STD_LOGIC;
        B  : in  STD_LOGIC;
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of FullAdder is

begin
    S <= A xor B xor Ci;
    Co <= (A and B) or (A and Ci) or (B and Ci);
	
end architecture;
