----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2025 03:08:04 PM
-- Design Name: 
-- Module Name: shift_l1 - Behavioral
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

entity shift_l1 is
	Generic (
		width : integer
	);
	Port (
		d_0 : in STD_LOGIC_VECTOR (width - 2 downto 0);
		d_1 : in STD_LOGIC_VECTOR (width - 2 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end shift_l1;

architecture Behavioral of shift_l1 is

begin

	y_0(width - 1 downto 1) <= d_0(width - 2 downto 0);
	y_1(width - 1 downto 1) <= d_1(width - 2 downto 0);
	
	y_1(0) <= '0';
	gate: entity ncl_gates.TH12
		port map(
			A => d_0(0),
			B => d_1(0),
			Z => y_0(0)
		);
	
end Behavioral;
