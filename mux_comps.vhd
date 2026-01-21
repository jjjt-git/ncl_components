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

library ncl_gates;
use ncl_gates.MACRO_CONFIG.all;

entity mux_comps is
	Generic (
		width : integer
	);
	Port (
		s_0 : in STD_LOGIC;
		s_1 : in STD_LOGIC;
		a_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		a_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		b_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		b_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end mux_comps;

architecture Behavioral of mux_comps is

begin
	-- sab y
	--------
	-- NXX N
	-- XNX N
	-- XXN N
	--------
	-- 0AB A
	-- 1AB B

	-- y0 <= a0 s0 + b0 s1
	-- y1 <= a1 s0 + b1 s1
	
	gates: for ii in 0 to width - 1 generate
	begin
		gate_0: entity ncl_gates.THxor0
			port map(
				A => a_0(ii),
				B => s_0,
				C => b_0(ii),
				D => s_1,
				Z => y_0(ii)
			);
			
		gate_1: entity ncl_gates.THxor0
			port map (
				A => a_1(ii),
				B => s_0,
				C => b_1(ii),
				D => s_1,
				Z => y_1(ii)
			);
	end generate;
end Behavioral;
