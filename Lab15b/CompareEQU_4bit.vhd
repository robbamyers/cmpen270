----------------------------------------------------------------------------
-- Entity:        CompareEQU_4bit
-- Written By:    Robert Myers
-- Date Created:  25 Apr 22
-- Description:   VHDL model of an 8-bit equality comparitor
--
-- Revision History (date, initials, description):
--
-- Dependencies:
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity CompareEQU_4bit is
    port (
        A   : in  STD_LOGIC_VECTOR(3 downto 0);
        B   : in  STD_LOGIC_VECTOR(3 downto 0);
        EQU : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of CompareEQU_4bit is

signal n : STD_LOGIC_VECTOR(3 downto 0);
    
begin

n(3) <= A(3) XNOR B(3);
n(2) <= A(2) XNOR B(2);
n(1) <= A(1) XNOR B(1);
n(0) <= A(0) XNOR B(0);
EQU <=  n(3) and n(2) and n(1) and n(0);
	
end architecture;
