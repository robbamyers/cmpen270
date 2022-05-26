----------------------------------------------------------------------------
-- Entity:        Counter_4bit
-- Written By:    Robert Myers
-- Date Created:  6 Mar 22
-- Description:   VHDL model of a 4-bit counter with enable and clear
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   Adder_4bit
--   Reg_LOAD_CLR_4bit
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Counter_4bit is
    port (
        EN   : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        ROLL : out STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Counter_4bit is
    component Reg_LOAD_CLR_4bit is
        port (
            D    : in  STD_LOGIC_VECTOR(3 downto 0);
            CLK  : in  STD_LOGIC;
            LOAD : in  STD_LOGIC;
            CLR  : in  STD_LOGIC;
            Q    : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    component Adder_4bit is
        port (
            A  : in  STD_LOGIC_VECTOR (3 downto 0);
            B  : in  STD_LOGIC_VECTOR (3 downto 0);
            Ci : in  STD_LOGIC;
            Co : out STD_LOGIC;
            S  : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
    signal  nextCount : STD_LOGIC_VECTOR (3 downto 0);
    signal      Q_int : STD_LOGIC_VECTOR (3 downto 0);
    
begin

    Q <= Q_int;
    
    Adder_4bit_0: Adder_4bit
    port map(
        A => "0001",
        B => Q_int (3 downto 0),
        Co => ROLL,
        Ci => '0',
        S => nextCount (3 downto 0)
    );
    Reg_0: Reg_LOAD_CLR_4bit
    port map(
        D => nextCount (3 downto 0),
        CLK => CLK,
        CLR => CLR,
        LOAD => EN,
        Q => Q_int
    );
    
    
end architecture;
