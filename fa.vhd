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

entity fa is
	Port (
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		ci_0 : in STD_LOGIC;
		ci_1 : in STD_LOGIC;
		co_0 : out STD_LOGIC;
		co_1 : out STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end fa;

architecture Behavioral of fa is
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
	
	c0: entity ncl_gates.TH23
		port map (
			A => a_0,
			B => b_0,
			C => ci_0,
			Z => c_0
		);
	c1: entity ncl_gates.TH23
		port map (
			A => a_1,
			B => b_1,
			C => ci_1,
			Z => c_1
		);
	
	y0: entity ncl_gates.TH34w2
		port map (
			A => c_1,
			B => a_0,
			C => b_0,
			D => ci_0,
			Z => y_0
		);
		
	y1: entity ncl_gates.TH34w2
		port map (
			A => c_0,
			B => a_1,
			C => b_1,
			D => ci_1,
			Z => y_1
		);
	
end Behavioral;
