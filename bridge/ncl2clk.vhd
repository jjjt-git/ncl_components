library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

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
	signal di_b_0, di_b_1, do_b, di_m_0, di_m_1 : std_logic_vector(width - 1 downto 0);
	signal di_cN, di_cD, do_bv, do_v : std_logic;
	
	signal state : std_logic;
	
	attribute ASYNC_REG : boolean;
	attribute ASYNC_REG of di_b_0: signal is TRUE;
	attribute ASYNC_REG of di_b_1: signal is TRUE;
	
	attribute NCL_WIRE_TYPE : string;
	attribute NCL_WIRE_TYPE of ko_mark : label is "ACK";
	attribute DONT_TOUCH : boolean;
	attribute DONT_TOUCH of ko_mark : label is TRUE;
begin

	ko_mark: LUT1
		generic map (
			INIT => "10"
		) port map (
			I0 => state,
			O  => ko
		);

	mark_di: for ii in 0 to width - 1 generate
		attribute NCL_WIRE_TYPE of d0_mark : label is "NCL_CLK";
		attribute NCL_WIRE_TYPE of d1_mark : label is "NCL_CLK";
	begin
	
		d0_mark: LUT1
			generic map (
				INIT => "10"
			) port map (
				I0 => di_0(ii),
				O  => di_m_0(ii)
			);
			
		d1_mark: LUT1
			generic map (
				INIT => "10"
			) port map (
				I0 => di_1(ii),
				O  => di_m_1(ii)
			);
			
	end generate;

	data_input_regs: process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then
				di_b_0 <= (others => '0');
				di_b_1 <= (others => '0');
			else
				di_b_0 <= di_m_0;
				di_b_1 <= di_m_1;
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
				state <= '1';
				do_v  <= '0';
				do_bv <= '0';
			else
				di   := (others => '-');
				di_v := '0';
				
				case state is
					when '1' =>
						if di_cD = '1' and ((WITH_BUFFER and do_bv = '0') or (not WITH_BUFFER and do_v = '0')) then
							state <= '0';
							di   := di_b_1;
							di_v := '1';
						end if;
					when '0' =>
						if di_cN = '1' then
							state <= '1';
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
end Behavioural;