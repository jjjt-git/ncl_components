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

entity mux_comp0_reg_r1 is
	Generic (
		width : integer
	);
	Port (
		rst : in std_logic;
		ki  : in std_logic;
		ko  : out std_logic_vector(width - 1 downto 0);
		
		s_0 : in STD_LOGIC;
		s_1 : in STD_LOGIC;
		a_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		a_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		b_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		b_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end mux_comp0_reg_r1;

architecture Behavioral of mux_comp0_reg_r1 is

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
	
	-- y1 <= s0a1 + s1b1a0 + s1b1a1 | AB + CDE + CDB = AB + (CDE + CDB)
	-- y0 <= s0a0 + s1b0a0 + s1b0a1 | AE + CFE + CFB = AE + (CFE + CFB)
	
	gates: for ii in 0 to width - 1 generate
		signal t0, t1 : std_logic;
		signal to0, to1 : std_logic;
	begin
		gate0_1: entity ncl_gates.TH54w22
			port map(
				A => s_1,
				B => b_0(ii),
				C => a_0(ii),
				D => a_1(ii),
				Z => t0
			);
			
		gate1_1: entity ncl_gates.TH54w22
			port map(
				A => s_1,
				B => b_1(ii),
				C => a_0(ii),
				D => a_1(ii),
				Z => t1
			);
			
		gate_0_2: entity ncl_gates.TH54w32n
			port map(
				A => ki,
				B => t0,
				C => s_0,
				D => a_0(ii),
				R => rst,
				Z => to0
			);
			
		gate_1_2: entity ncl_gates.TH54w32d
			port map(
				A => ki,
				B => t1,
				C => s_0,
				D => a_1(ii),
				R => rst,
				Z => to1
			);
			
		y_0(ii) <= to0;
		y_1(ii) <= to1;
		
		comp: entity ncl_gates.TH12
			port map (
				A => to0,
				B => to1,
				Z => ko(ii)
			);
	end generate;

end Behavioral;
