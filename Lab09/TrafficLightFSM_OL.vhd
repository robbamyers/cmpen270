----------------------------------------------------------------------------
-- Entity:        TrafficLightFSM_OL
-- Written By:    Robert Myers
-- Date Created:  19 Mar 22
-- Description:   VHDL model of a the output logic for the traffic light 
--                controller FSM
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity TrafficLightFSM_OL is
    port (
        CURRENT_STATE : in  STD_LOGIC_VECTOR(3 downto 0);
        LA            : out STD_LOGIC_VECTOR(2 downto 0);
        LB            : out STD_LOGIC_VECTOR(2 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of TrafficLightFSM_OL is

begin

    LA(2) <= (NOT CURRENT_STATE(3) AND NOT CURRENT_STATE(2) AND NOT CURRENT_STATE(1) AND NOT CURRENT_STATE(0))
             OR CURRENT_STATE(2)
             OR CURRENT_STATE(3);
    LA(1) <= CURRENT_STATE(1);
    LA(0) <= CURRENT_STATE(0);
    LB(2) <= (NOT CURRENT_STATE(3) AND NOT CURRENT_STATE(2) AND NOT CURRENT_STATE(1) AND NOT CURRENT_STATE(0))
             OR CURRENT_STATE(0)
             OR CURRENT_STATE(1);
    LB(1) <= CURRENT_STATE(3);
    LB(0) <= CURRENT_STATE(2);

end architecture;
