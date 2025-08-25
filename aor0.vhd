----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2025 03:08:04 PM
-- Design Name: 
-- Module Name: aor0 - Behavioral
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

entity aor0 is
	Generic (
		width : integer
	);
	Port (
		s_0 : in STD_LOGIC;
		s_1 : in STD_LOGIC;
		a_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		a_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end aor0;

architecture Behavioral of aor0 is
begin
	
	gates: for ii in width - 1 downto 0 generate
		signal g_prep_0, g_prep_1: STD_LOGIC_VECTOR (1 downto 0);
	begin
		g_prep_0(0) <= a_0(ii);
		g_prep_0(1) <= s_1;
		
		g_prep_1(0) <= a_1(ii);
		g_prep_1(1) <= s_0;
		
		gate: entity ncl_components.andn
			generic map (width => 2)
			port map (
				d_0 => g_prep_0,
				d_1 => g_prep_1,
				y_0 => y_0(ii),
				y_1 => y_1(ii)
			);
	end generate;
	
end Behavioral;
