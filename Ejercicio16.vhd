----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:59 08/21/2015 
-- Design Name: 
-- Module Name:    Ejercicio16 - Behavioral 
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

entity Ejercicio16 is
    Port ( DV : in  STD_LOGIC;
           MD : in  UNSIGNED (3 downto 0);
           MR : in  UNSIGNED (3 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PV : out  UNSIGNED (7 downto 0);
           PR : out  STD_LOGIC);
end Ejercicio16;

architecture Behavioral of Ejercicio16 is

--registro A--
signal pA,nA: unsigned(3 downto 0);
signal ld_dato1: std_logic;
--regsitro B--
signal pA,na: unsigned(3 downto 0);
signal ld_dato2: std_logic;
--registro P--
signal pP, nP: unsigned (3 downto 0);
signal ld_dato3: std_logic;
--registro desplazamiento p/p--
signal pq,nq: unsigned(8 downto 0);
signal ld_dato4: std_logic;
--puerta AND--
signal Pi: unsigned(3 downto 0);
--sumador--
signal S: unsigned (4 downto 0);
--mef--
type states is (reposo,multiplicacion);
signal n_state,p_state: states;

begin

--REGISTRO A--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then pA<=to_unsigned(0,3);
	elsif (CLK'event and CLK='1') then pA<=nA;
	end if;
	end process;
	--proceso combinacional--
	nA<=MA(3 downto 1) when ld_dato='1' else pA;
	
--REGISTRO B--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then pB<=to_unsigned(0,3);
	elsif (CLK'event and CLK='1') then pB<=nB;
	end if;
	end process;
	--proceso combinacional--
	nB<=MR(3 downto 1) when ld_dato2='1' else pB;
	
--REGISTRO P--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then pP<=to_unsigned(0,3);
	elsif (CLK'event and CLK='1') then pP<=nP;
	end if;
	end process;
	--proceso combinacional--
	nP<=S(3 downto 1) when ld_dato3='1' else pP;

--PUERTA AND--
	Pi<= nA and nB(0);
	
--REGISTRO DESPLAZAMIENTO P/P--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then pq<=to_unsigned(0,9);
	elsif(CLK'event and CLK='1') then pq<=nq;
	end if;
	end process;
	--proceso combinacional--
	nq<=S&np&nB when ld_dato='1' else pq;
	
--SUMADOR--
	S<=Pi+nP;
	
--MEF--
	--proceso secuencial--
	process(CLK,RST)
	begin
	if(RST='1') then p_state<=reposo;
	elsif(CLK'event and CLK='1') then p_state<=n_state;
	end if;
	end process;
	--proceso combinacional--
	process(p_state,DV)
	begin 
		case p_state is 
		when repsoso =>
		PV<=0;
		PR<='0';
		if(DV='1') then n_state<=multiplicador;
		end if;
		when multiplicador =>
		PV<=nq(7 downto 0);
		PR<=1;
		if(DV='0') then n_state<=reposo;
		end if;
	end case;
	end process;

end Behavioral;