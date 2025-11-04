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
	signal do_m_0, do_m_1: std_logic_vector(width - 1 downto 0);
	
	signal di_b, do_b: std_logic_vector(width - 1 downto 0);
	signal do_b_stall, di_bv, do_v, ki_neg, do_rst, do_ce: std_logic;
	
	attribute ASYNC_REG : boolean;
	attribute ASYNC_REG of ki_latch: label is TRUE;
	
	attribute NCL_WIRE_TYPE : string;
	attribute DONT_TOUCH : boolean;
	
begin

	mark_do: for ii in 0 to width - 1 generate
		attribute NCL_WIRE_TYPE of d0_mark : label is "NCL_CLK";
		attribute NCL_WIRE_TYPE of d1_mark : label is "NCL_CLK";
	begin
	
		d0_mark: LUT1
			generic map (
				INIT => "10"
			) port map (
				I0 => do_m_0(ii),
				O  => do_0(ii)
			);
			
		d1_mark: LUT1
			generic map (
				INIT => "10"
			) port map (
				I0 => do_m_1(ii),
				O  => do_1(ii)
			);
			
	end generate;

	data_output_regs: for ii in 0 to width - 1 generate
		signal d_neg : std_logic;
		
		attribute ASYNC_REG of reg_0: label is TRUE;
		attribute ASYNC_REG of reg_1: label is TRUE;
	begin
	
		d_neg <= not do_b(ii);
	
		reg_0: FDCE
			generic map (
				INIT => '0'
			) port map (
				C   => clk,
				CE  => do_ce,
				CLR => do_rst,
				D   => d_neg,
				Q   => do_m_0(ii)
			);
	
		reg_1: FDCE
			generic map (
				INIT => '0'
			) port map (
				C   => clk,
				CE  => do_ce,
				CLR => do_rst,
				D   => do_b(ii),
				Q   => do_m_1(ii)
			);
	end generate;
	
	ki_latch: FDPE
		generic map (
			INIT => '1'
		) port map (
			C   => clk,
			CE  => do_ce,
			PRE => do_rst,
			D   => '0',
			Q   => do_b_stall
		);

	ki_neg <= not ki;
	do_rst <= ki_neg or rst;
	do_ce  <= do_v and ki and do_b_stall;
	
	op: process(clk) begin -- standard bypass buffer (unregistered); ovalid and istall are the same
		if rising_edge(clk) then
			if rst = '1' then
				di_bv <= '0';
			else
				if (valid = '1' and di_bv = '0') and (ki = '0' or do_b_stall = '0') then -- incoming, but stalled
					di_bv <= '1';
				elsif not (ki = '0' or do_b_stall = '0') then -- not stalled
					di_bv <= '0';
				end if;
				
				if di_bv = '0' then
					di_b <= di;
				end if;
			end if;
		end if;
	end process op;
	
	stall <= di_bv;
	do_v  <= valid or di_bv;
	do_b  <= di_b when di_bv = '1' else di;
end Behavioural;