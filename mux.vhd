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

	-- y0 <= '(s0 a0 (b0 + b1)) + s1 b0 (a0 + a1)
	-- y1 <= '(s0 a1 (b0 + b1)) + s1 b1 (a0 + a1)
	
	gates: for ii in 0 to width - 1 generate
		signal t0, t1 : std_logic;
	begin
		gate0_1: entity ncl_gates.TH54w22
			port map (
				A => s_0,
				B => a_0(ii),
				C => b_0(ii),
				D => b_1(ii),
				Z => t0
			);
			
		gate1_1: entity ncl_gates.TH54w22
			port map (
				A => s_0,
				B => a_1(ii),
				C => b_0(ii),
				D => b_1(ii),
				Z => t1
			);
			
		gate_0_2: entity ncl_gates.fb_5
			generic map(
				ASSERT_SET => A5 or (B5 and C5 and (D5 or E5))
			) port map(
				A => t0,
				B => s_1,
				C => b_0(ii),
				D => a_0(ii),
				E => a_1(ii),
				Z => y_0(ii)
			);
			
		gate_1_2: entity ncl_gates.fb_5
			generic map(
				ASSERT_SET => A5 or (B5 and C5 and (D5 or E5))
			) port map (
				A => t1,
				B => s_1,
				C => b_1(ii),
				D => a_0(ii),
				E => a_1(ii),
				Z => y_1(ii)
			);
	end generate;

end Behavioral;
