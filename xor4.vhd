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

entity xor4 is
	Port (
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		c_0 : in STD_LOGIC;
		c_1 : in STD_LOGIC;
		d_0 : in STD_LOGIC;
		d_1 : in STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end xor4;

architecture Behavioral of xor4 is
	signal t_0, t_1: std_logic;
begin
	-- 0000 0
	-- 0001 1
	-- 0010 1
	-- 0011 0
	-- 0100 1
	-- 0101 0
	-- 0110 0
	-- 0111 1
	-- 1000 1
	-- 1001 0
	-- 1010 0
	-- 1011 1
	-- 1100 0
	-- 1101 1
	-- 1110 1
	-- 1111 0
	-- y0 <= 
	-- y1 <= 
	
	g1: entity ncl_components.xor3
		port map(
			a_0 => a_0,
			a_1 => a_1,
			b_0 => b_0,
			b_1 => b_1,
			c_0 => c_0,
			c_1 => c_1,
			y_0 => t_0,
			y_1 => t_1
		);
	
	g2: entity ncl_components.xor2
		port map(
			a_0 => t_0,
			a_1 => t_1,
			b_0 => d_0,
			b_1 => d_1,
			y_0 => y_0,
			y_1 => y_1
		);
	
end Behavioral;