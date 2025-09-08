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

entity rege_r0 is
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
end rege_r0;

architecture Behavioral of rege_r0 is

	signal z : STD_LOGIC_VECTOR (2 * width - 1 downto 0);

begin

	regs: for ii in 0 to width - 1 generate
		signal t_0, t_1: std_logic;
		signal tko : std_logic;
	begin
		y_0(ii) <= t_0;
		y_1(ii) <= t_1;
		
		NCL_reg_0: entity ncl_gates.TH33d
			port map (
				A => ki,
				B => d_0(ii),
				C => e,
				R => rst,
				Z => t_0
			);
			
		NCL_reg_1: entity ncl_gates.TH33n
			port map (
				A => ki,
				B => d_1(ii),
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
