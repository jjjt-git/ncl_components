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

library ncl_components;

entity xor3 is
	Port (
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		c_0 : in STD_LOGIC;
		c_1 : in STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end xor3;

architecture Behavioral of xor3 is
	signal t_0, t_1: std_logic;
begin
	-- 000 0
	-- 001 1
	-- 010 1
	-- 011 0
	-- 100 1
	-- 101 0
	-- 110 0
	-- 111 1
	-- y0 <= 
	-- y1 <= 
	
	g1: entity ncl_components.xor2
		port map(
			a_0 => a_0,
			a_1 => a_1,
			b_0 => b_0,
			b_1 => b_1,
			y_0 => t_0,
			y_1 => t_1
		);
	
	g2: entity ncl_components.xor2
		port map(
			a_0 => t_0,
			a_1 => t_1,
			b_0 => c_0,
			b_1 => c_1,
			y_0 => y_0,
			y_1 => y_1
		);
	
end Behavioral;