library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity clk2ncl is
	generic (
		width: integer := 2
	);
	port (
		clk, rst: in std_logic;
		do_0, do_1: out std_logic_vector(width - 1 downto 0);
		ki: in std_logic;
		valid: in std_logic;
		stall: out std_logic;
		di: in std_logic_vector(width - 1 downto 0)
	);
end clk2ncl;

architecture Behavioural of clk2ncl is
	signal do_1m, do_0m, d_r : std_logic_vector(width - 1 downto 0);
	signal v_r : std_logic;
	
	signal hold : std_logic;
	signal ki_s : std_logic;
	
	signal stalled : std_logic;
	
	attribute NCL_WIRE_TYPE : string;
	attribute RLOC          : string;
	attribute DONT_TOUCH    : boolean;
	attribute ASYNC_REG     : boolean;
	
	signal ki_f, ki_r     : std_logic;
	signal ki_f_p, ki_r_p : std_logic;
	
	attribute ASYNC_REG of ki_rm : label is true;
	attribute ASYNC_REG of ki_fm : label is true;
	attribute ASYNC_REG of ki_rs : label is true;
	attribute ASYNC_REG of ki_fs : label is true;
	
	attribute RLOC of ki_rm : label is "X0Y0";
	attribute RLOC of ki_fm : label is "X1Y0";
	attribute RLOC of ki_rs : label is "X1Y0";
	attribute RLOC of ki_fs : label is "X0Y0";
begin
	stall <= stalled;
	ki_s <= ki_f and ki_r;
	
	do_0m <= (others => '0') when v_r = '0' or ki_s = '0' else not d_r;
	do_1m <= (others => '0') when v_r = '0' or ki_s = '0' else d_r;
	
	do_0 <= do_0m;
	do_1 <= do_1m;
	
	stalled <= hold and v_r;

	mark_d: for ii in 0 to width - 1 generate
		attribute NCL_WIRE_TYPE of do0_mark : label is "NCL_CLK";
		attribute DONT_TOUCH    of do0_mark : label is true;
		
		attribute NCL_WIRE_TYPE of do1_mark : label is "NCL_CLK";
		attribute DONT_TOUCH    of do1_mark : label is true;
	begin
		do0_mark: LUT1
			generic map (
				INIT => "10"
			) port map (
				I0 => do_0m(ii)
			);
			
		do1_mark: LUT1
			generic map (
				INIT => "10"
			) port map (
				I0 => do_1m(ii)
			);
	end generate;
	
	in_regs: process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then
				d_r <= (others => '0');
				v_r <= '0';
			elsif stalled = '0' then
				d_r <= di;
				v_r <= valid;
			elsif (ki_f xor ki_r) = '1' then
				v_r <= '0';
			end if;
		end if;
	end process in_regs;
	
	hold_unit: process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then
				hold <= '1';
			elsif (ki_f xor ki_r) = '1' then
				hold <= '0';
			elsif valid = '1' then
				hold <= '1';
			end if;
		end if;
	end process hold_unit;
	
	ki_rm: FDRE
		port map (
			R  => rst,
			C  => clk,
			CE => '1',
			
			D => ki,
			Q => ki_r_p
		);
	
	ki_fm: FDRE_1
		port map (
			R  => rst,
			C  => clk,
			CE => '1',
			
			D => ki,
			Q => ki_f_p
		);
	
	ki_rs: FDRE_1
		port map (
			R  => rst,
			C  => clk,
			CE => '1',
			
			D => ki_r_p,
			Q => ki_r
		);
	
	ki_fs: FDRE
		port map (
			R  => rst,
			C  => clk,
			CE => '1',
			
			D => ki_f_p,
			Q => ki_f
		);
	
end Behavioural;