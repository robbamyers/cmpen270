--------------------------------------------------------------------------------
-- Entity:        Lab03_rfm5594
-- Written By:    Robert Myers
-- Date Created:  25 January 2022
-- Description:   CMPEN 270 Lab #3 starting VHDL
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab03_rfm5594 is
    port (
		SW3  : in  STD_LOGIC;
		SW2  : in  STD_LOGIC;
		SW1  : in  STD_LOGIC;
		SW0  : in  STD_LOGIC;
		LD0  : out STD_LOGIC;
		LD1 : out STD_LOGIC;
		LD2 : out STD_LOGIC;
		LD3 : out STD_LOGIC;
		LD4 : out STD_LOGIC;
		LD5 : out STD_LOGIC;
		LD6 : out STD_LOGIC;
		LD7 : out STD_LOGIC;
		LD8 : out STD_LOGIC;
		LD9 : out STD_LOGIC;
		LD10 : out STD_LOGIC;
		LD11 : out STD_LOGIC;
		LD12 : out STD_LOGIC;
		LD13 : out STD_LOGIC;
		LD14 : out STD_LOGIC
	);
end entity;
--------------------------------------------------------------------------------

architecture Structural of Lab03_rfm5594 is

	-- Input aliases
    alias S3 : STD_LOGIC is SW3;
    alias S2 : STD_LOGIC is SW2;
    alias S1 : STD_LOGIC is SW1;
    alias S0 : STD_LOGIC is SW0;
    alias L0 : STD_LOGIC is LD0;
    alias L1 : STD_LOGIC is LD1;
    alias L2 : STD_LOGIC is LD2;
    alias L3 : STD_LOGIC is LD3;
    alias L4 : STD_LOGIC is LD4;
    alias L5 : STD_LOGIC is LD5;
    alias L6 : STD_LOGIC is LD6;
    alias L7 : STD_LOGIC is LD7;
    alias L8 : STD_LOGIC is LD8;
    alias L9 : STD_LOGIC is LD9;
    alias L10 : STD_LOGIC is LD10;
    alias L11 : STD_LOGIC is LD11;
    alias L12 : STD_LOGIC is LD12;
    alias L13 : STD_LOGIC is LD13;
    alias L14 : STD_LOGIC is LD14;

begin

    L0 <= S3 or S2 or S1 or S0;
    L1 <= S3 or S2 or S1;
    L2 <= (S3 or S2 or S1) and (S3 or S2 or (not(S1)) or S0);
    L3 <= S3 or S2;
    L4 <= (S3 or (not(S2)) or S1 or S0) and (S3 or S2);
    L5 <= (S3 or (not(S2)) or S1) and (S3 or S2);
    L6 <= (S3 or (not(S2)) or S1) and (S3 or S2) and (S3 or (not(S2)) or (not(S1)) or S0);
    L7 <= S3;
    L8 <= (S3 and (not(S2)) and (not(S1)) and S0) or (S3 and (not(S2)) and S1) or (S3 and S2);
    L9 <= (S3 and (not(S2)) and S1) or (S3 and S2);
    L10 <= (S3 and (not(S2)) and S1 and S0) or (S3 and S2);
    L11 <= (S3 and S2);
    L12 <= (S3 and S2 and (not(S1)) and S0) or (S3 and S2 and S1);
    L13 <= (S3 and S2 and S1);
    L14 <= (S3 and S2 and S1 and S0);
    
end Structural;
