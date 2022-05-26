----------------------------------------------------------------------------
-- Entity:        Decoder2to4_ALO
-- Written By:    Robert Myers
-- Date Created:  16 Feb 22
-- Description:   VHDL model of a 2 to 4 decoder with active low outputs
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Decoder2to4_ALO is
    port (
        A : in  STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Decoder2to4_ALO is



begin

     Y(3) <= A(0) nand A(1);
     Y(2) <= not A(0) nand A(1);
     Y(1) <= A(0) nand not A(1);
     Y(0) <= not A(0) nand  not A(1);


end architecture;
