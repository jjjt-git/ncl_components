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

library qdi_framework;
use qdi_framework.MACRO_CONFIG.all;

entity mux_comp0 is
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
end mux_comp0;

architecture Behavioral of mux_comp0 is

begin
	-- sab y
	-- Nxx N
	-- 0ax a
	-- 1Nx N
	-- 1xb b

	-- s  a  b  y
	-- 00 xx xx 00
	-- 01 aa xx aa
	-- 10 00 xx 00
	-- 10 xx bb bb

	-- y0 <= s1 b0 a0 + s1 b0 a1 + s0 a0
	-- y1 <= s1 b1 a0 + s1 b1 a1 + s0 a1

	gates: for ii in 0 to width - 1 generate begin

		gate_0: entity qdi_framework.fb_5
			generic map (
				ASSERT_SET => (A5 and B5 and C5) or (A5 and B5 and D5) or (E5 and C5)
			) port map(
				A => s_1,
				B => b_0(ii),
				C => a_0(ii),
				D => a_1(ii),
				E => s_0,
				Z => y_0(ii)
			);

		gate_1: entity qdi_framework.fb_5
			generic map (
				ASSERT_SET => (A5 and B5 and C5) or (A5 and B5 and D5) or (E5 and C5)
			) port map(
				A => s_1,
				B => b_1(ii),
				C => a_0(ii),
				D => a_1(ii),
				E => s_0,
				Z => y_1(ii)
			);

	end generate;

end Behavioral;
