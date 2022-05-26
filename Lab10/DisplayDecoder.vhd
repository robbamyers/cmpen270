----------------------------------------------------------------------------
-- Entity:        DisplayDecoder
-- Written By:    Robert Myers
-- Date Created:  24 Mar 22
-- Description:   VHDL model of a decoder for the display in Lab 10
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity DisplayDecoder is
    port (
        A : in  STD_LOGIC_VECTOR(1  downto 0);
        Y : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of DisplayDecoder is

begin

Y(15) <= '1';
Y(14) <= A(1);
Y(13) <= not A(1);
Y(12) <= A(0);
Y(11) <= '0';
Y(10) <= A(1) xor A(0);
Y(9) <= A(1) and not A(0);
Y(8) <= not A(0);
Y(7) <= A(1);
Y(6) <= A(0);
Y(5) <= A(1) xnor A(0);
Y(4) <= not A(1) and A(0);
Y(3) <= A(1);
Y(2) <= A(0);
Y(1) <= not A(1) or A(0);
Y(0) <= A(1) or not A(0);

end architecture;
