----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/16/2025 11:55:09 AM
-- Design Name: 
-- Module Name: andn - Behavioral
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

entity andn is
	Generic (
		width : integer
	);
	Port (
		d_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end andn;

architecture Behavioral of andn is
begin
	
	gate: entity ncl_components.orn
		generic map (width => width)
		port map (
			d_0 => d_1,
			d_1 => d_0,
			y_0 => y_1,
			y_1 => y_0
		);

end Behavioral;
