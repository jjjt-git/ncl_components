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

entity rca_ci_co_en is
	Generic (
		width : integer
	);
	Port (
		en : in std_logic;
		
		ci_0, ci_1 : in std_logic;
		co_0, co_1 : out std_logic;
	
		a_0, a_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		b_0, b_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0, y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end rca_ci_co_en;

architecture Behavioral of rca_ci_co_en is
	signal c_0, c_1 : std_logic_vector(width downto 0);
begin

	c_0(0) <= ci_0;
	c_1(0) <= ci_1;
	
	co_0 <= c_0(width);
	co_1 <= c_1(width);
		
	chain: for ii in 0 to width - 1 generate
		cell: entity ncl_components.fa_en
			port map (
				en  => en,
				
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
