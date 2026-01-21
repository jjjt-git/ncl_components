library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library ncl_gates;
use ncl_gates.MACRO_CONFIG.all;

entity or2_en is
	Port (
		en : in std_logic;
		a_0, a_1 : in STD_LOGIC;
		b_0, b_1 : in STD_LOGIC;
		y_0, y_1 : out STD_LOGIC
	);
end or2_en;

architecture Behavioral of or2_en is

begin
	
	-- y0 <= a0 & b0
	-- y1 <= a1 & b1 | a0 & b1 | a1 & b0
	
	gate_0: entity ncl_gates.TH33
		port map (
			A => a_0,
			B => b_0,
			C => en,
			Z => y_0
		);
		
	gate_1: entity ncl_gates.fb_5
		generic map (
			ASSERT_SET => ((A5 and B5) or (B5 and C5) or (A5 and D5)) and E5
		) port map (
			A => a_1,
			B => b_1,
			C => a_0,
			D => b_0,
			E => en,
			Z => y_1
		);

end Behavioral;