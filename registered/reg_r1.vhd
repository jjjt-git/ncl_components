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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
	begin
		y_0(ii) <= t_0;
		y_1(ii) <= t_1;
	
		reg_0: entity ncl_gates.TH22n
			port map (
				A => ki,
				B => d_0(ii),
				R => rst,
				Z => t_0
			);
			
		reg_1: entity ncl_gates.TH22d
			port map (
				A => ki,
				B => d_1(ii),
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
