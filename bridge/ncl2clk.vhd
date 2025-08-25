library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ncl2clk is
	generic (
		WITH_BUFFER : boolean := true;
		width: integer := 2
	);
	port (
		clk, rst: in std_logic;
		di_0, di_1: in std_logic_vector(width - 1 downto 0);
		ko: out std_logic;
		valid: out std_logic;
		stall: in  std_logic;
		do: out std_logic_vector(width - 1 downto 0)
	);
end ncl2clk;

architecture Behavioural of ncl2clk is
	signal di_b_0, di_b_1, do_b : std_logic_vector(width - 1 downto 0);
	signal di_cN, di_cD, do_bv, do_v : std_logic;
	
	type state_t is (WFD, WFN);
	signal state : state_t;
	
	attribute ASYNC_REG : boolean;
	attribute ASYNC_REG of di_b_0: signal is TRUE;
	attribute ASYNC_REG of di_b_1: signal is TRUE;
begin

	data_input_regs: process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then
				di_b_0 <= (others => '0');
				di_b_1 <= (others => '0');
			else
				di_b_0 <= di_0;
				di_b_1 <= di_1;
			end if;
		end if;
	end process data_input_regs;
	
	comp: process(di_b_0, di_b_1)
		variable di_c: std_logic_vector(width - 1 downto 0);
		variable cN, cD: std_logic;
	begin
		di_c := di_b_0 or di_b_1;
		
		cN := '1';
		cD := '1';
		
		for ii in 0 to width - 1 loop
			if di_c(ii) = '1' then
				cN := '0';
			else
				cD := '0';
			end if;
		end loop;
		
		di_cN <= cN;
		di_cD <= cD;
	end process comp;
	
	op: process(clk)
		variable di   : std_logic_vector(width - 1 downto 0);
		variable di_v : std_logic;
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= WFD;
				do_v  <= '0';
				do_bv <= '0';
			else
				di   := (others => '-');
				di_v := '0';
				
				case state is
					when WFD =>
						if di_cD = '1' and ((WITH_BUFFER and do_bv = '0') or (not WITH_BUFFER and do_v = '0')) then
							state <= WFN;
							di   := di_b_1;
							di_v := '1';
						end if;
					when WFN =>
						if di_cN = '1' then
							state <= WFD;
						end if;
				end case;
				
				if WITH_BUFFER then
					if (do_bv = '0' and di_v = '1') and (do_v = '1' and stall = '1') then
						do_bv <= '1';
					elsif stall = '0' then
						do_bv <= '0';
					end if;
					
					if do_bv = '0' then
						do_b <= di;
					end if;
					
					if do_v = '0' or stall = '0' then
						do_v <= di_v or do_bv;
						if do_bv = '1' then
							do <= do_b;
						else
							do <= di;
						end if;
					end if;
				else
					if do_v = '0' or stall = '0' then
						do_v <= di_v;
						do   <= di;
					end if;
				end if;
			end if;
		end if;
	end process op;
	
	valid <= do_v;
	
	ko <=
		'1' when state = WFD else
		'0' when state = WFN else
		'X';
end Behavioural;