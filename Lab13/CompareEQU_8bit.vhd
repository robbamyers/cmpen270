----------------------------------------------------------------------------
-- Entity:        CompareEQU_8bit
-- Written By:    Robert Myers
-- Date Created:  11 Apr 22
-- Description:   VHDL model of an 8-bit equality comparitor
--
-- Revision History (date, initials, description):
--
-- Dependencies:
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity CompareEQU_8bit is
    port (
        A   : in  STD_LOGIC_VECTOR(7 downto 0);
        B   : in  STD_LOGIC_VECTOR(7 downto 0);
        EQU : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of CompareEQU_8bit is

signal n : STD_LOGIC_VECTOR(7 downto 0);
    
begin

n(7) <= A(7) XNOR B(7);
n(6) <= A(6) XNOR B(6);
n(5) <= A(5) XNOR B(5);
n(4) <= A(4) XNOR B(4);
n(3) <= A(3) XNOR B(3);
n(2) <= A(2) XNOR B(2);
n(1) <= A(1) XNOR B(1);
n(0) <= A(0) XNOR B(0);
EQU <= n(7) and n(6) and n(5) and n(4) and n(3) and n(2) and n(1) and n(0);
	
end architecture;
