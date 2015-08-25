----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:33 08/20/2015 
-- Design Name: 
-- Module Name:    Ejercicio13 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ejercicio13 is
    Port ( ENVIA : in  STD_LOGIC;
           DATO : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           TxD : out  STD_LOGIC;
           RDY : out  STD_LOGIC);
end Ejercicio13;

architecture Behavioral of Ejercicio13 is

--contador módulo 10--
	signal cnt,n_cnt: unsigned (3 downto 0);
	signal ini_cnt: std_logic;
--registro desplazamiento p/p--
	signal nq,pq: std_logic_vector (7 downto 0);
	signal ld_dato: std_logic;
--mef--
	type states is (stop,start,paridad,d0,d1,d2,d3,d4,d5,d6,d7);
	signal n_state,p_state: states;
	
begin

--CONTADOR MODULO 9--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then cnt<=0;
	elsif (CLK'event and CLK='1') then cnt<=n_cnt;
	end if;
	end process;
	--proceso combinacional--
	n_cnt<=cnt+1 when cnt<9 or ini_cnt='1' else 0;
	
--REGISTRO DESPLAZAMIENTO P/P--
	--proceso secuencial--
	process(CLK,RST)
	begin 
	if(RST='1') then pq<="00000000";
	elsif (CLK'event and CLK='1') then pq<=nq;
	end if;
	end process;
	--proceso combinacional--
	nq<=DATO(7 downto 1) when ld_dato='1' else pq;
	
--MEF--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then p_state<=stop;
	elsif(CLK'event and CLK='1') then p_state<=n_state;
	end if;
	end process;
	--proceso combinacional--
	process(p_state,n_cnt,ENVIA)
	begin
	case p_state is
		when stop =>
		ini_cnt<='0';
		TxD<='1';
		RDY<='1';
		ld_dato<='0';
		if(ENVIA='1') then n_state<=start;
		end if;
		when start =>
		ini_cnt<='1';
		TxD<='0';
		RDY<='1';
		ld_dato<='0';
		if(n_cnt=0) then n_state<=d0;
		end if;
		when d0 =>
		ini_cnt<='1';
		TxD<=nq(0);
		RDY<='0';
		ld_dato<='1';
		if(n_cnt=1) then n_state<=d1;
		end if;
		when d1 =>
		ini_cnt<='1';
		TxD<=nq(1);
		RDY<='0';
		ld_dato<='1';
		if(n_cnt=2) then n_state<=d2;
		end if;
		when d2 =>
		ini_cnt<='1';
		TxD<=nq(2);
		ld_dato<='1';
		RDY<='0';
		if(n_cnt=3) then n_state<=d3;
		end if;
		when d3 =>
		ini_cnt<='1';
		TxD<=nq(3);
		RDY<='0';
		ld_dato<='1';
		if(n_cnt=4) then n_state<=d4;
		end if;
		when d4 =>
		ini_cnt<='1';
		TxD<=nq(4);
		RDY<='0';
		ld_dato<='1';
		if(n_cnt=5) then n_state<=d5;
		end if;
		when d5 =>
		ini_cnt<='1';
		TxD<=nq(5);
		RDY<='0';
		ld_dato<='1';
		if(n_cnt=6) then n_state<=d6;
		end if;
		when d6 =>
		ini_cnt<='1';
		TxD<=nq(6);
		RDY<='0';
		ld_dato<='1';
		if(n_cnt=7) then n_state<=d7;
		end if;
		when d7 =>
		ini_cnt<='1';
		ld_dato<='1';
		TxD<=nq(7);
		RDY<='0';
		if(n_cnt=8) then n_state<=paridad;
		end if;
		when paridad =>
		ini_cnt<='1';
		ld_dato<='0';
		TxD<='1';
		RDY<='0';
		if(ENVIA='0') then n_state<=stop;
		end if;
	end case;
	end process;
	
end Behavioral;

