----------------------------------------------------------------------------
-- Entity:        DFF_EN_RESET
-- Written By:    Robert Myers
-- Date Created:  22 Feb 22
-- Description:   VHDL model of a D flip-flop with enable and reset
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity DFF_EN_RESET is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of DFF_EN_RESET is
    
    component Mux2to1 is
        port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC
        );
    end component;
    
    component DFF_RESET is
        port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC
        );
    end component;
    
    signal Q_int : STD_LOGIC;
    signal n1    : STD_LOGIC;
    
begin
    
    Q <= Q_int;
    
    Mux2to1_1: Mux2to1
    port map(
        D0 => Q_int,
        D1 => D,
        SEL => EN,
        Y => n1
    );
    
    DFF_RESET_1: DFF_RESET
    port map(
        D => n1,
        RESET => RESET,
        CLK => CLK,
        Q => Q_int
    );

end architecture;
