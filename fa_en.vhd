----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2025 03:09:05 PM
-- Design Name: 
-- Module Name: rca - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ncl_gates;
use ncl_gates.MACRO_CONFIG.all;

entity fa_en is
	Port (
		en : in std_logic;
		
		a_0, a_1 : in STD_LOGIC;
		b_0, b_1 : in STD_LOGIC;
		
		ci_0, ci_1 : in STD_LOGIC;
		co_0, co_1 : out STD_LOGIC;
		
		y_0, y_1 : out STD_LOGIC
	);
end fa_en;

architecture Behavioral of fa_en is
	signal c_0, c_1 : std_logic;
begin
	
	-- abc cy
	-- 000 00
	-- 001 01
	-- 010 01
	-- 011 10
	-- 100 01
	-- 101 10
	-- 110 10
	-- 111 11
	-- co_0 <= a0b0 + a0c0 + b0c0
	-- co_1 <= b1c1 + a1c1 + a1b1
	-- y_0  <= a0b0c0 + a0co_1 + b0co_1 + c0co_1
	-- y_1  <= c0_0c1 + b1co_0 + a1co_0 + a1b1c1
	
	co_0 <= c_0;
	co_1 <= c_1;
	
	c0: entity ncl_gates.TH44w2
		port map (
			A => en,
			B => a_0,
			C => b_0,
			D => ci_0,
			Z => c_0
		);
	c1: entity ncl_gates.TH44w2
		port map (
			A => en,
			B => a_1,
			C => b_1,
			D => ci_1,
			Z => c_1
		);
	
	y0: entity ncl_gates.fb_5
		generic map ( -- TH34w2 with enable
			ASSERT_SET => ((A5 and B5) or (A5 and C5) or (A5 and D5) or (B5 and C5 and D5)) and E5
		) port map (
			A => c_1,
			B => a_0,
			C => b_0,
			D => ci_0,
			E => en,
			Z => y_0
		);
		
	y1: entity ncl_gates.fb_5
		generic map ( -- TH34w2 with enable
			ASSERT_SET => ((A5 and B5) or (A5 and C5) or (A5 and D5) or (B5 and C5 and D5)) and E5
		) port map (
			A => c_0,
			B => a_1,
			C => b_1,
			D => ci_1,
			E => en,
			Z => y_1
		);
	
end Behavioral;
