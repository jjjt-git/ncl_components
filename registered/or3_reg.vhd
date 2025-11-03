----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/16/2025 11:44:50 AM
-- Design Name: 
-- Module Name: or3 - Behavioral
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

library ncl_components;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity or3_reg is
	Generic (
		rst_y_0 : std_logic; -- desired value of y at end of reset
		rst_y_1 : std_logic
	);
	Port (
		rst : in std_logic;
		ki  : in std_logic;
		ko  : out std_logic;
		
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		c_0 : in STD_LOGIC;
		c_1 : in STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end or3_reg;

architecture Behavioral of or3_reg is
	signal t_0, t_1 : STD_LOGIC;
begin

	g1: entity ncl_components.or2
		port map(
			a_0 => a_0,
			a_1 => a_1,
			b_0 => b_0,
			b_1 => b_1,
			y_0 => t_0,
			y_1 => t_1
		);
	
	g2: entity ncl_components.or2_reg
		generic map (
			rst_y_0 => rst_y_0,
			rst_y_1 => rst_y_1
		) port map (
			rst => rst,
			ki  => ki,
			ko  => ko,
			
			a_0 => t_0,
			a_1 => t_1,
			b_0 => c_0,
			b_1 => c_1,
			y_0 => y_0,
			y_1 => y_1
		); 

end Behavioral;