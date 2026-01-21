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

entity mux_incomp0 is
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
end mux_incomp0;

architecture Behavioral of mux_incomp0 is

begin
	-- sab y
	-- Nxx N
	-- xxN N
	-- 0ax a
	-- 1xb b
	
	-- s  a  b  y
	
	-- 01 01 01 01
	-- 01 01 10 01
	-- 10 xx 01 01
	
	-- 01 10 01 10
	-- 01 10 10 10
	-- 10 xx 10 10
	
	--       A  E   C    D     B  C
	-- y0 <= s0 a0 (b0 + b1) + s1 b0
	--       A  E   C    D     B  D
	-- y1 <= s0 a1 (b0 + b1) + s1 b1
	
	gates: for ii in 0 to width - 1 generate begin

		gate_0: entity ncl_gates.fb_5
			generic map (
				ASSERT_SET => (A5 and E5 and (C5 or D5)) or (B5 and C5)
			) port map(
				A => s_0,
				B => s_1,
				C => b_0(ii),
				D => b_1(ii),
				E => a_0(ii),
				Z => y_0(ii)
			);
			
		gate_1: entity ncl_gates.fb_5
			generic map (
				ASSERT_SET => (A5 and E5 and (C5 or D5)) or (B5 and D5)
			) port map(
				A => s_0,
				B => s_1,
				C => b_0(ii),
				D => b_1(ii),
				E => a_1(ii),
				Z => y_1(ii)
			);
			
	end generate;

end Behavioral;
