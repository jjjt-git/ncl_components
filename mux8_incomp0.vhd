----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2025 03:08:04 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux8_incomp0 is
	Generic (
		width : integer
	);
	Port (
		s_0 : in STD_LOGIC_VECTOR(2 downto 0);
		s_1 : in STD_LOGIC_VECTOR(2 downto 0);
		d0_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d0_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d1_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d1_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d2_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d2_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d3_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d3_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d4_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d4_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d5_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d5_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d6_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d6_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d7_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d7_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end mux8_incomp0;

architecture Behavioral of mux8_incomp0 is
	signal t0_0, t0_1, t1_0, t1_1 : std_logic_vector(width - 1 downto 0);
begin

	mux00: entity ncl_components.mux4_incomp0
		generic map (
			width => width
		) port map (
			s_0 => s_0(1 downto 0),
			s_1 => s_1(1 downto 0),
			d0_0 => d0_0,
			d0_1 => d0_1,
			d1_0 => d1_0,
			d1_1 => d1_1,
			d2_0 => d2_0,
			d2_1 => d2_1,
			d3_0 => d3_0,
			d3_1 => d3_1,
			y_0 => t0_0,
			y_1 => t0_1
		);

	mux01: entity ncl_components.mux4
		generic map (
			width => width
		) port map (
			s_0 => s_0(1 downto 0),
			s_1 => s_1(1 downto 0),
			d0_0 => d4_0,
			d0_1 => d4_1,
			d1_0 => d5_0,
			d1_1 => d5_1,
			d2_0 => d6_0,
			d2_1 => d6_1,
			d3_0 => d7_0,
			d3_1 => d7_1,
			y_0 => t1_0,
			y_1 => t1_1
		);

	mux1: entity ncl_components.mux
		generic map (
			width => width
		) port map (
			s_0 => s_0(2),
			s_1 => s_1(2),
			a_0 => t0_0,
			a_1 => t0_1,
			b_0 => t1_0,
			b_1 => t1_1,
			y_0 => y_0,
			y_1 => y_1
		);

end Behavioral;
