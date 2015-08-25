----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:59 06/10/2015 
-- Design Name: 
-- Module Name:    Ejercicio6 - Behavioral 
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

entity Ejercicio6 is
    Port ( RST : in  STD_LOGIC;
				A: IN STD_LOGIC_VECTOR (5 downto 0);
				DECENAS: out STD_LOGIC_VECTOR (6 downto 0);
				UNIDADES: out STD_LOGIC_VECTOR (6 downto 0);
           CLK : in  STD_LOGIC);
end Ejercicio6;

architecture Behavioral of Ejercicio6 is
 signal cnt,p_cnt: unsigned (5 downto 0);
 --contadores BCD
 signal cnt1,cnt2,p_cnt1,p_cnt2: unsigned(2 downto 0);
begin
	cnt<=unsigned(A);
	
--CONTADOR BINARIO--
--PROCESO SECUENCIAL
	process (RST,CLK)
	begin
	if(RST='1') then cnt<="000000";
	elsif(CLK'event and CLK='1') then cnt<=p_cnt;
	end if;
	end process;
	
--PROCESO COMBINACIONAL
	p_cnt<=cnt+1 when (cnt<29) else "000000";

--CONTADOR BCD--
--CONTADOR UNIDADES--
	process (RST,CLK)
	begin
	if(RST='1') then cnt1<="000";
	elsif (CLK'event and CLK='1') then cnt1<=p_cnt1;
	end if;
	end process;
	
	p_cnt1<=cnt+1 when (cnt<10) else "000";
	
--CONTADOR DECENAS
	process(RST,CLK)
	begin
	if(RST='1') then cnt2<="000";
	elsif(CLK'event and CLK='1') then cnt2<=p_cnt2;
	end if;
	end process;
	
	p_cnt2<=cnt2+1 when cnt1=9 and cnt2<3 else "000";
	
--BCDS--
	UNIDADES<="1111110" when (p_cnt1=0) else
				"0110000" when (p_cnt1=1) else
				"1101101" when (p_cnt1=2) else
				"1111001" when (p_cnt1=3) else
				"0110011" when (p_cnt1=4) else
				"1011011" when (p_cnt1=5) else
				"1011111" when (p_cnt1=6) else
				"1110000" when (p_cnt1=7) else
				"1111111" when (p_cnt1=8) else
				"1110011" when (p_cnt1=9) else
				"1001111";
				
	DECENAS<="1111110" when (p_cnt1=0) else
				"0110000" when (p_cnt1=1) else
				"1101101" when (p_cnt1=2) else
				"1001111";
				
	
end Behavioral;

