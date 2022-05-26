----------------------------------------------------------------------------
-- Entity:        Reg_LOAD_CLR_2bit
-- Written By:    Robert Myers
-- Date Created:  6 Mar 22
-- Description:   VHDL model of a 2-bit register with load and clear
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   DFF_EN_RESET
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Reg_LOAD_CLR_2bit is
    port (
        D    : in  STD_LOGIC_VECTOR(1 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Reg_LOAD_CLR_2bit is
    component DFF_EN_RESET is
        port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            EN    : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC
        );
    end component;

begin

    DFF_EN_REST_1: DFF_EN_RESET
    port map(
        D    => D(1),
        CLK  => CLK,
        EN   => LOAD,
        RESET  => CLR,
        Q    => Q(1)
    );
    DFF_EN_REST_0: DFF_EN_RESET
    port map(
        D    => D(0),
        CLK  => CLK,
        EN   => LOAD,
        RESET  => CLR,
        Q    => Q(0)
    );

end architecture;
