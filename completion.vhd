
library IEEE;
library ncl_gates;
library ncl_components;

use IEEE.STD_LOGIC_1164.ALL;

entity completion is
	generic( 
		width : integer := 1
	);
	port (
		ko_vector : in std_logic_vector (width - 1 downto 0);
		ko : out std_logic
	);
end completion;

architecture Structural of completion is
	constant owidth : integer := (width - (width mod 4)) / 4 + (width mod 4);
	constant ngates : integer := (width - (width mod 4)) / 4;
begin
	
	multi: if width > 4 generate
		signal next_stage : std_logic_vector(owidth - 1 downto 0);
	begin

		n: entity ncl_components.completion
			generic map (width => owidth)
			port map (
				ko_vector => next_stage,
				ko => ko
			);
			
		gates: for ii in ngates - 1 downto 0 generate
			gate: entity ncl_gates.TH44
				port map (
					A => ko_vector(4 * ii),
					B => ko_vector(4 * ii + 1),
					C => ko_vector(4 * ii + 2),
					D => ko_vector(4 * ii + 3),
					Z => next_stage(ii)
				);
		end generate;
		
		remainder: if width mod 4 /= 0 generate
			next_stage(owidth - 1 downto ngates) <= ko_vector(width - 1 downto ngates * 4);
		end generate;
	end generate;
	
	g4: if width = 4 generate
		signal ko_neg : std_logic;
	begin
		ko <= not ko_neg;
	
		gate: entity ncl_gates.TH44
				port map (
					A => ko_vector(0),
					B => ko_vector(1),
					C => ko_vector(2),
					D => ko_vector(3),
					Z => ko_neg
				);
	end generate;
	
	g3: if width = 3 generate
		signal ko_neg : std_logic;
	begin
		ko <= not ko_neg;
	
		gate: entity ncl_gates.TH33
				port map (
					A => ko_vector(0),
					B => ko_vector(1),
					C => ko_vector(2),
					Z => ko_neg
				);
	end generate;
	
	g2: if width = 2 generate
		signal ko_neg : std_logic;
	begin
		ko <= not ko_neg;
	
		gate: entity ncl_gates.TH22
				port map (
					A => ko_vector(0),
					B => ko_vector(1),
					Z => ko_neg
				);
	end generate;
	
	g1: if width = 1 generate
		ko <= not ko_vector(0);
	end generate;
end Structural;
