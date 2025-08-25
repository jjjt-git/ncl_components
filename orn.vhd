----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/16/2025 11:55:09 AM
-- Design Name: 
-- Module Name: orn - Behavioral
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

library ncl_components;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity orn is
	Generic (
		width : integer
	);
	Port (
		d_0 : in STD_LOGIC_VECTOR(width - 1 downto 0);
		d_1 : in STD_LOGIC_VECTOR(width - 1 downto 0);
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end orn;

architecture Behavioral of orn is
	constant owidth : integer := (width - (width mod 4)) / 4 + (width mod 4);
	constant ngates : integer := (width - (width mod 4)) / 4;
begin
	
	multi: if width > 4 generate
		signal next_stage_0, next_stage_1 : std_logic_vector(owidth - 1 downto 0);
	begin

		n: entity ncl_components.orn
			generic map (width => owidth)
			port map (
				d_0 => next_stage_0,
				d_1 => next_stage_1,
				y_0 => y_0,
				y_1 => y_1
			);
			
		gates: for ii in ngates - 1 downto 0 generate
			gate: entity ncl_components.or4
				port map (
					a_0 => d_0(4 * ii),
					a_1 => d_1(4 * ii),
					b_0 => d_0(4 * ii + 1),
					b_1 => d_1(4 * ii + 1),
					c_0 => d_0(4 * ii + 2),
					c_1 => d_1(4 * ii + 2),
					d_0 => d_0(4 * ii + 3),
					d_1 => d_1(4 * ii + 3),
					y_0 => next_stage_0(ii),
					y_1 => next_stage_1(ii)
				);
		end generate;
		
		remainder: if width mod 4 /= 0 generate
			next_stage_0(owidth - 1 downto ngates) <= d_0(width - 1 downto ngates * 4);
			next_stage_1(owidth - 1 downto ngates) <= d_1(width - 1 downto ngates * 4);
		end generate;
	end generate;
	
	g4: if width = 4 generate
		gate: entity ncl_components.or4
			port map (
					a_0 => d_0(0),
					a_1 => d_1(0),
					b_0 => d_0(1),
					b_1 => d_1(1),
					c_0 => d_0(2),
					c_1 => d_1(2),
					d_0 => d_0(3),
					d_1 => d_1(3),
					y_0 => y_0,
					y_1 => y_1
			);
	end generate;
	
	g3: if width = 3 generate
		gate: entity ncl_components.or3
			port map (
					a_0 => d_0(0),
					a_1 => d_1(0),
					b_0 => d_0(1),
					b_1 => d_1(1),
					c_0 => d_0(2),
					c_1 => d_1(2),
					y_0 => y_0,
					y_1 => y_1
			);
	end generate;
	
	g2: if width = 2 generate
		gate: entity ncl_components.or2
			port map (
					a_0 => d_0(0),
					a_1 => d_1(0),
					b_0 => d_0(1),
					b_1 => d_1(1),
					y_0 => y_0,
					y_1 => y_1
			);
	end generate;

end Behavioral;