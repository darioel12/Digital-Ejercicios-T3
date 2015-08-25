----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:05 08/21/2015 
-- Design Name: 
-- Module Name:    Ejercicio15 - Behavioral 
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

entity Ejercicio15 is
    Port ( ENVIA : in  STD_LOGIC;
           DATO : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           SDA : out  STD_LOGIC;
           CS : out  STD_LOGIC;
           SCK : out  STD_LOGIC;
           BUSY : out  STD_LOGIC);
end Ejercicio15;

architecture Behavioral of Ejercicio15 is

--contador módulo 8--
signal cnt,n_cnt: unsigned (3 downto 0);
signal ini_cnt: std_logic;
--registro desplazamiento p/p--
signal nq,pq: std_logic_vector(7 downto 0);
signal ld_dato: std_logic;
--mef--
type states is (reposo,b7,b6,b5,b4,b3,b2,b1,b0);
signal n_state,p_state: states;

begin

--CONTADOR MÓDULO 8--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then cnt<=to_unsigned(0,5);
	elsif (CLK'event and CLK='1') then cnt<=n_cnt;
	end if;
	end process;
	--proceso combinacional--
	n_cnt<=cnt+1 when cnt<8 or SDK='1' else 0;
	
--REGISTRO DESPLAZAMIENTO P/P--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then pq<="00000000";
	elsif (CLK'event and CLK='1') then pq<=nq;
	end if;
	end process;
	--proceso combinacional--
	nq<=DATOS&q(7 downto 1) when ld_dato<='1' else "00000000";
	
--MEF--
	--proceso combinacional--
	process(CLK,RST)
	begin
	if(RST='1') then p_state<=reposo;
	elsif(CLK'event and CLK='1') then p_state<=n_state;
	end if;
	end process;
	--proceso secuencial--
	process(p_state,n_cnt,nq)
	begin
	case p_state is
		when reposo =>
		CS<='1';
		SDK<='0';
		SDA<='0';
		if(BUSY='1') then n_state<=b7;
		end if;
		when b7 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(7);
		if(cnt=0) then n_state<=b6;
		end if;
		when b6 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(6);
		if(cnt=1) then n_state<=b5;
		end if;
		when b5 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(5);
		if(cnt=2) then n_state<=b4;
		end if;
		when b4 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(4);
		if(cnt=3) then n_state<=b3;
		end if;
		when b3 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(3);
		if(cnt=4) then n_state<=b2;
		end if;
		when b2 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(2);
		if(cnt=5) then n_state<=b1;
		end if;
		when b1 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(1);
		if(cnt=6) then n_state<=b7;
		end if;
		when b0 =>
		CS<='0';
		SDK<='1';
		SDA<=nq(0);
		if(cnt=7 and BUSY='0') then n_state<=reposo;
		end if;
	end case;
	end process;
		

end Behavioral;

