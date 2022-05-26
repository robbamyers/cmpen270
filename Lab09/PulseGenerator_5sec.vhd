----------------------------------------------------------------------------
-- Entity:        PulseGenerator_5sec
-- Written By:    Robert Myers
-- Date Created:  19 Mar 22
-- Description:   VHDL model of a pulse generator with a pulse every 5 seconds
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
entity PulseGenerator_5sec is
    port (
        EN     : in  STD_LOGIC;
        CLK    : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        STATUS : out STD_LOGIC_VECTOR(4 downto 1);
        PULSE  : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Behavioral of PulseGenerator_5sec is

    signal count : UNSIGNED(28 downto 0) := (OTHERS => '0');

begin

    process (CLK)
    begin
        if rising_edge(CLK) then
            if ((RESET = '1') or (count >= 499999999)) then
                count <= (OTHERS => '0');
            elsif (EN = '1') then
                count <= count + 1;
            end if;
        end if;
    end process;
    
    PULSE <= '1' when (count >= 499999999) else '0';
    
    STATUS(1) <= '1' when (count >  99999999) else '0';
    STATUS(2) <= '1' when (count > 199999999) else '0';
    STATUS(3) <= '1' when (count > 299999999) else '0';
    STATUS(4) <= '1' when (count > 399999999) else '0';

end architecture;
