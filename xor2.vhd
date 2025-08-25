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

entity xor2 is
	Port (
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end xor2;

architecture Behavioral of xor2 is
begin
	
	-- 00 0
	-- 01 1
	-- 10 1
	-- 11 0
	-- y0 <= a0b0 + a1b1
	-- y1 <= a0b1 + a1b0
	
	g1: entity ncl_gates.THxor0
		port map(
			A => a_0,
			B => b_0,
			C => a_1,
			D => b_1,
			Z => y_0
		);
	
	g2: entity ncl_gates.THxor0
		port map(
			A => a_0,
			B => b_1,
			C => a_1,
			D => b_0,
			Z => y_1
		);
	
end Behavioral;