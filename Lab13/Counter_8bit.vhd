----------------------------------------------------------------------------
-- Entity:        Counter_8bit
-- Written By:    Robert Myers
-- Date Created:  11 Apr 22
-- Description:   VHDL model of an 8-bit counter with enable and clear 
--    and clear.
--
-- Revision History (date, initials, description):
--   (none)

-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.all;
use     IEEE.NUMERIC_STD.all;

----------------------------------------------------------------------------
entity Counter_8bit is
    port (EN  : in  STD_LOGIC;
          CLK : in  STD_LOGIC;
          CLR : in  STD_LOGIC;
          Q   : out STD_LOGIC_VECTOR (7 downto 0));
end entity;
----------------------------------------------------------------------------

architecture Behavioral of Counter_8bit is

    signal Q_int : UNSIGNED (7 downto 0) := (OTHERS => '0');

begin

    process (CLK) is
    begin
        if (rising_edge(CLK)) then
            if (CLR = '1') then
                Q_int <= (OTHERS => '0');
            elsif (EN = '1') then
                Q_int <= Q_int + 1;
            end if;
        end if;
    end process;
    
    Q <= std_logic_vector(Q_int);
    
end architecture;

