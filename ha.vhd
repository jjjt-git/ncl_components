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

entity ha is
	Port (
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		co_0 : out STD_LOGIC;
		co_1 : out STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end ha;

architecture Behavioral of ha is
	signal t_0, t_1 : std_logic_vector(1 downto 0);
begin
	-- ab cy
	-- 00 00
	-- 01 01
	-- 10 01
	-- 11 10
	
	gy: entity ncl_components.xor2
		port map(
			a_0 => a_0,
			a_1 => a_1,
			b_0 => b_0,
			b_1 => b_1,
			y_0 => y_0,
			y_1 => y_1
		);
	
	t_0 <= a_0 & b_0;
	t_1 <= a_1 & b_1;
	
	gc: entity ncl_components.andn
		generic map(width => 2)
		port map(
			d_0 => t_0,
			d_1 => t_1,
			y_0 => co_0,
			y_1 => co_1
		); 
	
end Behavioral;