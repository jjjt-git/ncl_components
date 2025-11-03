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

entity rege_rN is
	Generic (
		RST_MASK_KO : boolean;
		RST_MASK_KO_VALUE : std_logic := 'X';
		MKO_VALUE : std_logic := 'X';
		width : integer
	);
	Port (
		rst : in STD_LOGIC;
		e   : in std_logic;
		mko : in std_logic;
		ki  : in std_logic;
		ko  : out STD_LOGIC_VECTOR (width - 1 downto 0);
		d_0 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		d_1 : in STD_LOGIC_VECTOR (width - 1 downto 0);
		y_0 : out STD_LOGIC_VECTOR (width - 1 downto 0);
		y_1 : out STD_LOGIC_VECTOR (width - 1 downto 0)
	);
end rege_rN;

architecture Behavioral of rege_rN is
begin

	regs: for ii in 0 to width - 1 generate
		signal t_0, t_1: std_logic;
		signal tko : std_logic;
		signal m_0, m_1: std_logic;
	begin
	
		m_0 <= d_0(ii);
		m_1 <= d_1(ii);
	
		y_0(ii) <= t_0;
		y_1(ii) <= t_1;
		
		NCL_reg_0: entity ncl_gates.TH33n
			port map (
				A => ki,
				B => m_0,
				C => e,
				R => rst,
				Z => t_0
			);
			
		NCL_reg_1: entity ncl_gates.TH33n
			port map (
				A => ki,
				B => m_1,
				C => e,
				R => rst,
				Z => t_1
			);
			
		comp: entity ncl_gates.TH12
			port map (
				A => t_0,
				B => t_1,
				Z => tko
			);
			
		ko(ii) <=
			RST_MASK_KO_VALUE when rst = '1' and RST_MASK_KO else
			MKO_VALUE when mko = '1' else
			tko;
	end generate;

end Behavioral;
