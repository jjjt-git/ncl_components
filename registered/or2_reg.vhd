library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library ncl_gates;

entity or2_reg is
	Generic (
		rst_y_0 : std_logic; -- desired value of y at end of reset
		rst_y_1 : std_logic
	);
	Port (
		rst : in std_logic;
		ki  : in std_logic;
		ko  : out std_logic;
		
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end or2_reg;

architecture Behavioral of or2_reg is
	signal t_0, t_1 : std_logic;
begin
	
	-- y0 <= a0 & b0
	-- y1 <= a1 & b1 | a0 & b1 | a1 & b0
	
	rst_N: if rst_y_0 = '0' and rst_y_1 = '0' generate
		gate_0: entity ncl_gates.TH33n
			port map (
				A => ki,
				B => a_0,
				C => b_0,
				R => rst,
				Z => t_0
			);
			
		gate_1: entity ncl_gates.THand0en
			port map (
				A => ki,
				B => a_1,
				C => b_1,
				D => a_0,
				E => b_0,
				R => rst,
				Z => t_1
			);
	end generate;
	
	rst_0: if rst_y_0 = '1' and rst_y_1 = '0' generate
		gate_0: entity ncl_gates.TH33d
			port map (
				A => ki,
				B => a_0,
				C => b_0,
				R => rst,
				Z => t_0
			);
			
		gate_1: entity ncl_gates.THand0en
			port map (
				A => ki,
				B => a_1,
				C => b_1,
				D => a_0,
				E => b_0,
				R => rst,
				Z => t_1
			);
	end generate;
	
	rst_1: if rst_y_0 = '0' and rst_y_1 = '1' generate
		gate_0: entity ncl_gates.TH33n
			port map (
				A => ki,
				B => a_0,
				C => b_0,
				R => rst,
				Z => t_0
			);
			
		gate_1: entity ncl_gates.THand0ed
			port map (
				A => ki,
				B => a_1,
				C => b_1,
				D => a_0,
				E => b_0,
				R => rst,
				Z => t_1
			);
	end generate;
	
	y_0 <= t_0;
	y_1 <= t_1;
	
	comp: entity ncl_gates.TH12
		port map (
			A => t_0,
			B => t_1,
			Z => ko
		);

end Behavioral;