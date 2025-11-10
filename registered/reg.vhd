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

entity reg is
	Generic (
		width : integer;
		rst_y_0 : std_logic_vector; -- desired value of y at end of reset
		rst_y_1 : std_logic_vector
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
end reg;

architecture Behavioral of reg is
begin

	regs: for ii in 0 to width - 1 generate
		signal t_0, t_1: std_logic;
		signal m_0, m_1: std_logic;
	begin
	
		m_0 <= d_0(ii);
		m_1 <= d_1(ii);
	
		y_0(ii) <= t_0;
		y_1(ii) <= t_1;
	
		rst_type_N: if rst_y_1(ii) = '0' and rst_y_0(ii) = '0' generate -- rst to 00
--			reg: entity ncl_gates.TH22n_22n_SA_AA
--				port map (
--					A  => ki,
--					B1 => m_1,
--					B2 => m_0,
--					R  => rst,
--					Z1 => t_1,
--					Z2 => t_0,
--					Z1_Z2_or => ko(ii)
--				);
				
			reg_1: entity ncl_gates.TH22n
				port map (
					A => ki,
					B => m_1,
					R => rst,
					Z => t_1
				);
				
			reg_0: entity ncl_gates.TH22n
				port map (
					A => ki,
					B => m_0,
					R => rst,
					Z => t_0
				);
				
			comp: entity ncl_gates.TH12
				port map (
					A => t_0,
					B => t_1,
					Z => ko(ii)
				);
		end generate;
		
		rst_type_D0: if rst_y_1(ii) = '0' and rst_y_0(ii) = '1' generate -- rst to 01
			reg_1: entity ncl_gates.TH22n
				port map (
					A => ki,
					B => m_1,
					R => rst,
					Z => t_1
				);
				
			reg_0: entity ncl_gates.TH22d
				port map (
					A => ki,
					B => m_0,
					R => rst,
					Z => t_0
				);
				
			comp: entity ncl_gates.TH12
				port map (
					A => t_0,
					B => t_1,
					Z => ko(ii)
				);
		end generate;
		
		rst_type_D1: if rst_y_1(ii) = '1' and rst_y_0(ii) = '0' generate -- rst to 10
			reg_1: entity ncl_gates.TH22d
				port map (
					A => ki,
					B => m_1,
					R => rst,
					Z => t_1
				);
				
			reg_0: entity ncl_gates.TH22n
				port map (
					A => ki,
					B => m_0,
					R => rst,
					Z => t_0
				);
		
			comp: entity ncl_gates.TH12
				port map (
					A => t_0,
					B => t_1,
					Z => ko(ii)
				);
		end generate;
	end generate;

end Behavioral;
