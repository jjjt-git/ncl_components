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
library qdi_framework;
use qdi_framework.MACRO_CONFIG.all;

entity mux is
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
end mux;

architecture Behavioral of mux is

begin
	-- sab y
	--------
	-- NXX N
	-- XNX N
	-- XXN N
	--------
	-- 0AB A
	-- 1AB B

	-- y0 <= a0 s0 (b0 + b1) + b0 s1 (a0 + a1)
	-- y1 <= a1 s0 (b0 + b1) + b1 s1 (a0 + a1)

	gates: for ii in 0 to width - 1 generate
		signal t0, t1 : std_logic;
	begin
		gate0_1: entity ncl_gates.TH23
			port map (
				A => s_0,
				B => b_0(ii),
				C => b_1(ii),
				Z => t0
			);

		gate1_1: entity ncl_gates.TH23
			port map (
				A => s_1,
				B => a_0(ii),
				C => a_1(ii),
				Z => t1
			);

		gate_0_2: entity ncl_gates.THxor0
			port map(
				A => a_0(ii),
				B => t0,
				C => t1,
				D => b_0(ii),
				Z => y_0(ii)
			);

		gate_1_2: entity ncl_gates.THxor0
			port map (
				A => a_1(ii),
				B => t0,
				C => t1,
				D => b_1(ii),
				Z => y_1(ii)
			);
	end generate;

end Behavioral;
