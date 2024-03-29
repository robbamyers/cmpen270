----------------------------------------------------------------------------
-- Entity:        PulseGenerator_1ms
-- Written By:    Robert Myers
-- Date Created:  11 Apr 22
-- Description:   VHDL model of a pulse generator with a pulse every 1 ms
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;
use     IEEE.NUMERIC_STD.ALL;

----------------------------------------------------------------------------
entity PulseGenerator_1ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Behavioral of PulseGenerator_1ms is

    signal count : UNSIGNED(16 downto 0) := (OTHERS => '0');

begin

    process (CLK)
    begin
        if rising_edge(CLK) then
            if (count >= 99999) then
                count <= (OTHERS => '0');
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    PULSE <= '1' when (count >= 99999) else '0';
    
end architecture;
