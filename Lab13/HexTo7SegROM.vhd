----------------------------------------------------------------------------
-- Entity:        HexTo7SegROM
-- Written By:    Robert Myers
-- Date Created:  11 Apr 22
-- Description:   VHDL model of a hex digit to 7-segment display ROM
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
entity HexTo7SegROM is
    port (
        A  : in  STD_LOGIC_VECTOR(3 downto 0);
        RD : out STD_LOGIC_VECTOR(0 to 6)
    );
end entity;
----------------------------------------------------------------------------

architecture Behavioral of HexTo7SegROM is

	type ROM_TYPE is ARRAY (0 to 15) of STD_LOGIC_VECTOR(0 to 6);
	constant ROM : ROM_TYPE := (
		"1111111", -- Address =  0: all segments off
		"0111111", -- Address =  1: only segment A on
		"1011111", -- Address =  2: only segment B on
		"1101111", -- Address =  3: only segment C on
		"1110111", -- Address =  4: only segment D on
		"1111011", -- Address =  5: only segment E on
		"1111101", -- Address =  6: only segment F on
		"1111110", -- Address =  7: only segment G on
		"1001000", -- Address =  8: H
		"0110000", -- Address =  9: E
		"1110001", -- Address = 10: L
		"1110001", -- Address = 11: L
		"0000001", -- Address = 12: O
		"0011000", -- Address = 13: P
		"0100100", -- Address = 14: S
		"1000001"  -- Address = 15: U
	);

begin

    RD <= ROM(to_integer(unsigned(A(3 downto 0))));

end architecture;
