----------------------------------------------------------------------------
-- Entity:        Counter_2bit
-- Written By:    Robert Myers
-- Date Created:  6 Mar 22
-- Description:   VHDL model of a 2-bit counter with enable and clear
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   Adder_4bit
--   Counter_4bit
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Counter_2bit is
    port (
        EN   : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        ROLL : out STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Counter_2bit is

    component Adder_2bit is
        port (
            A  : in  STD_LOGIC_VECTOR (1 downto 0);
            B  : in  STD_LOGIC_VECTOR (1 downto 0);
            Ci : in  STD_LOGIC;
            Co : out STD_LOGIC;
            S  : out STD_LOGIC_VECTOR (1 downto 0)
        );
    end component;
    component Reg_LOAD_CLR_2bit is
        port (
            D    : in  STD_LOGIC_VECTOR(1 downto 0);
            CLK  : in  STD_LOGIC;
            LOAD : in  STD_LOGIC;
            CLR  : in  STD_LOGIC;
            Q    : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    signal nextCount : STD_LOGIC_VECTOR(1 downto 0);
    signal     Q_int : STD_LOGIC_VECTOR(1 downto 0);
    
begin
    
    Q <= Q_int;
    Adder_0: Adder_2bit
    port map(
        A(1 downto 0) => "01",
        B(1 downto 0) => Q_int,
        Ci => '0',
        Co => ROLL,
        S(1 downto 0) => nextCount
    );
    Reg_0: Reg_LOAD_CLR_2bit
    port map(
        D(1 downto 0) => nextCount,
        CLK => CLK,
        LOAD => EN,
        CLR => CLR,
        Q(1 downto 0) => Q_int
    );
    
    
end architecture;
