----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2025 03:08:04 PM
-- Design Name: 
-- Module Name: rege - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

library ncl_gates;

entity reg_r1 is
	Generic (
		width : integer
	);
	Port (
		rst : in STD_LOGIC;
		ki  : in std_logic;
		ko  : out STD_LOGIC_VECTOR (width - 1 downto 0);
		d_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end reg_r1;

architecture Behavioral of reg_r1 is
begin

	regs: for ii in 0 to width - 1 generate
		signal t_0, t_1: std_logic;
		signal m_0, m_1: std_logic;
	begin
	
		m_0 <= d_0(ii);
		m_1 <= d_1(ii);
	
		y_0(ii) <= t_0;
		y_1(ii) <= t_1;
	
		NCL_reg_0: entity ncl_gates.TH22n
			port map (
				A => ki,
				B => m_0,
				R => rst,
				Z => t_0
			);
			
		NCL_reg_1: entity ncl_gates.TH22d
			port map (
				A => ki,
				B => m_1,
				R => rst,
				Z => t_1
			);
			
		comp: entity ncl_gates.TH12
			port map (
				A => t_0,
				B => t_1,
				Z => ko(ii)
			);
	end generate;

end Behavioral;
