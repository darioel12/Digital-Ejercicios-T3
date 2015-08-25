----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:09:09 08/20/2015 
-- Design Name: 
-- Module Name:    Ejercicio14 - Behavioral 
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

entity Ejercicio14 is
    Port ( T3 : in  STD_LOGIC;
           T2 : in  STD_LOGIC;
           T1 : in  STD_LOGIC;
           T0 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q1 : out  STD_LOGIC;
           Q2 : out  STD_LOGIC);
end Ejercicio14;

architecture Behavioral of Ejercicio14 is
--contador modulo 10--
signal cnt, n_cnt: unsigned (3 downto 0);
signal ini_cnt: std_logic;
--mef--
type states is (reposo, activa1,activa2,baja);
signal n_state,p_state: states;

begin

--CONTADOR MÓDULO 10--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then cnt<=0;
	elsif (CLK'event and CLK='1') then cnt<=n_cnt;
	end if;
	end process;
	--proceso combinacional--
	n_cnt<=cnt+1 when cnt<10 or ini_cnt='1' else 0;
	
--MEF--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then p_state<=reposo;
	elsif(CLK'event and CLK='1') then p_state<=n_state;
	end if;
	end process;
	--proceso combinacional--
	process(n_cnt,p_state,T3,T2,T1,T0,ini_cnt)
	begin
	case p_state is
		when reposo =>
		Q1<='0';
		Q2<='1';
		if(ini_cnt='1' and T0='1') then n_state<=baja;
		end if;
		when baja =>
		Q1<='0';
		Q2<='0';
		if(n_cnt=1 and T1='1') then n_state<=activa1;
		elsif(n_cnt=5 and T3='1') then n_state<=activa2;
		end if;
		when activa1 =>
		Q1<='1';
		Q2<='0';
		if(n_cnt=4 and T2='1') then n_state<=baja;
		end if;
		when activa2 =>
		Q1<='0';
		Q2<='1';
		if(n_cnt=9 and T0='0') then n_state<=reposo;
		end if;
	end case;
	end process;
end Behavioral;

