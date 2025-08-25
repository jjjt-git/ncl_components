library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library ncl_gates;

entity or2 is
	Port (
		a_0 : in STD_LOGIC;
		a_1 : in STD_LOGIC;
		b_0 : in STD_LOGIC;
		b_1 : in STD_LOGIC;
		y_0 : out STD_LOGIC;
		y_1 : out STD_LOGIC
	);
end or2;

architecture Behavioral of or2 is

begin
	
	-- y0 <= a0 & b0
	-- y1 <= a1 & b1 | a0 & b1 | a1 & b0
	
	gate_0: entity ncl_gates.TH22
		port map (
			A => a_0,
			B => b_0,
			Z => y_0
		);
		
	gate_1: entity ncl_gates.THand0
		port map (
			A => a_1,
			B => b_1,
			C => a_0,
			D => b_0,
			Z => y_1
		);

end Behavioral;