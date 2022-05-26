----------------------------------------------------------------------------
-- Entity:        TrafficLightFSM_NSL
-- Written By:    Robert Myers
-- Date Created:  19 Mar 22
-- Description:   VHDL model of a the next state logic for the traffic light 
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
entity TrafficLightFSM_NSL is
    port (
        TA            : in  STD_LOGIC;
        TB            : in  STD_LOGIC;
        CURRENT_STATE : in  STD_LOGIC_VECTOR(3 downto 0);
        NEXT_STATE    : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of TrafficLightFSM_NSL is

begin

    NEXT_STATE(0) <= (NOT CURRENT_STATE(3) AND NOT CURRENT_STATE(2) AND NOT CURRENT_STATE(1) AND NOT CURRENT_STATE(0)) 
                     OR (CURRENT_STATE(0) AND TA) 
                     OR CURRENT_STATE(3);
    NEXT_STATE(1) <= CURRENT_STATE(0) AND NOT TA;
    NEXT_STATE(2) <= CURRENT_STATE(1)
                     OR (CURRENT_STATE(2) AND TB);
    NEXT_STATE(3) <= CURRENT_STATE(2) AND NOT TB;
                   
    
end architecture;
