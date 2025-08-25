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

entity rca is
	Generic (
		width : integer
	);
	Port (
		a_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		a_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		b_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		b_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end rca;

architecture Behavioral of rca is
	signal c_0, c_1 : std_logic_vector(width - 1 downto 1);
begin
	
	first: entity ncl_components.ha
		port map(
			a_0 => a_0(0),
			a_1 => a_1(0),
			b_0 => b_0(0),
			b_1 => b_1(0),
			co_0 => c_0(1),
			co_1 => c_1(1),
			y_0 => y_0(0),
			y_1 => y_1(0)
		);
	
	last: entity ncl_components.fa_noco
		port map(
			a_0 => a_0(width - 1),
			a_1 => a_1(width - 1),
			b_0 => b_0(width - 1),
			b_1 => b_1(width - 1),
			ci_0 => c_0(width - 1),
			ci_1 => c_1(width - 1),
			y_0 => y_0(width - 1),
			y_1 => y_1(width - 1)
		);
		
	middle: for ii in 1 to width - 2 generate
		cell: entity ncl_components.fa
			port map(
				a_0 => a_0(ii),
				a_1 => a_1(ii),
				b_0 => b_0(ii),
				b_1 => b_1(ii),
				ci_0 => c_0(ii),
				ci_1 => c_1(ii),
				co_0 => c_0(ii + 1),
				co_1 => c_1(ii + 1),
				y_0 => y_0(ii),
				y_1 => y_1(ii)
			);
	end generate;
	
end Behavioral;
