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
	signal di_b, do_b: std_logic_vector(width - 1 downto 0);
	signal do_b_stall, di_bv, do_v: std_logic;
	
	attribute ASYNC_REG : boolean;
	attribute ASYNC_REG of do_0: signal is TRUE;
	attribute ASYNC_REG of do_1: signal is TRUE;
	attribute ASYNC_REG of do_b_stall: signal is TRUE;
begin
	data_output_regs: process(clk, ki, rst) begin
		if ki = '0' or rst = '1' then
			do_0 <= (others => '0');
			do_1 <= (others => '0');
			do_b_stall <= '0'; -- rfn could be quite short (compared to clk)
		elsif rising_edge(clk) then
			if do_v = '1' and ki = '1' and do_b_stall = '0' then
				do_b_stall <= '1';
				do_0 <= not do_b;
				do_1 <= do_b;
			end if;
		end if;
	end process data_output_regs;
	
	op: process(clk) begin -- standard bypass buffer (unregistered); ovalid and istall are the same
		if rising_edge(clk) then
			if rst = '1' then
				di_bv <= '0';
			else
				if (valid = '1' and di_bv = '0') and (ki = '0' or do_b_stall = '1') then -- incoming, but stalled
					di_bv <= '1';
				elsif not (ki = '0' or do_b_stall = '1') then -- not stalled
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