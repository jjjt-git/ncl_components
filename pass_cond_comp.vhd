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

entity pass_cond_comp is
	Generic (
		width : integer
	);
	Port (
		en  : in std_logic;
		d_0, d_1 : in STD_LOGIC_VECTOR(width - 1 downto 0);
		c_0, c_1 : in std_logic_vector(width - 1 downto 0);
		y_0, y_1: out STD_LOGIC_VECTOR(width - 1 downto 0)
	);
end pass_cond_comp;

architecture Behavioral of pass_cond_comp is
begin
	pass: for ii in 0 to width - 1 generate
		en_1: entity ncl_gates.TH54w22
			port map (
				A => en,
				B => d_1(ii),
				C => c_0(ii),
				D => c_1(ii),
				Z => y_1(ii)
			);
			
		en_0: entity ncl_gates.TH54w22
			port map (
				A => en,
				B => d_0(ii),
				C => c_0(ii),
				D => c_1(ii),
				Z => y_0(ii)
			);
	end generate;
end Behavioral;
