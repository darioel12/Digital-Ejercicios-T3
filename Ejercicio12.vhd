----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:44:27 08/19/2015 
-- Design Name: 
-- Module Name:    Ejercicio12 - Behavioral 
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

entity Ejercicio12 is
    Port ( INICIO : in  STD_LOGIC;
           VACIO : in  STD_LOGIC;
           LLENO : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           EV : out  STD_LOGIC;
           BD : out  STD_LOGIC;
           MA : out  STD_LOGIC;
           MC : out  STD_LOGIC);
end Ejercicio12;

architecture Behavioral of Ejercicio12 is
--contador módulo 1200--
	signal cnt,n_cnt: unsigned (10 downto 0);
	signal ini_cnt: std_logic;

--mef--
	type states is (reposo,aclarado,lavado,centrifugado,vaciado,agitado);
	signal n_state,p_state: states;
	signal act_aclarado: std_logic;
begin

--CONTADOR MÓDULO 1200--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then cnt<=0;
	elsif (CLK'event and CLK='1') then cnt<=n_cnt;
	end if;
	end process;
	--proceso combinacional--
	n_cnt<=cnt+1 when cnt<1200 or ini_cnt='1' else 0;
	
--MEF--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then p_state<=reposo;
	elsif(CLK'event and CLK='1') then p_state<=n_state;
	end if;
	end process;
	--proceso combinacional--
	process(p_state,LLENO,VACIO,INICIO,n_cnt,act_aclarado)
	begin
	case p_state is
		when reposo =>
		EV<='0';
		BD<='0';
		MA<='0';
		MC<='0';
		ini_cnt<='0';
		if(INICIO='1') then n_state<=lavado;
		end if;
		when lavado =>
		EV<='1';
		BD<='0';
		MA<='0';
		MC<='0';
		ini_cnt<='0';
		if(LLENO='1') then n_state<=agitado;
		end if;
		when agitado =>
		EV<='0';
		MA<='1';
		MC<='0';
		BD<='0';
		ini_cnt<='1';
		if(VACIO='1' and n_cnt=1199) then n_state<=vaciado;
		end if;
		when vaciado =>
		EV<='0';
		BD<='1';
		MC<='0';
		MA<='0';
		ini_cnt<='0';
		if(act_aclarado<='1') then n_state<=aclarado;
		end if;
		when aclarado =>
		EV<='1';
		ini_cnt<='1';
		MA<='1';
		MC<='0';
		BD<='0';
		if(n_cnt=899) then n_state<=centrifugado;
		end if;
		when centrifugado =>
		BD<='1';
		ini_cnt<='1';
		MC<='1';
		MA<='0';
		EV<='0';
		if(n_cnt=599) then n_state<=reposo;
		end if;
	end case;
	end process;
end Behavioral;

