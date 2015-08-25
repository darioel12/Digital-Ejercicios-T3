----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:50:23 06/10/2015 
-- Design Name: 
-- Module Name:    Ejercicio8 - Behavioral 
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

entity Ejercicio8 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           LEDS : out  STD_LOGIC_VECTOR (4 downto 0));
end Ejercicio8;

architecture Behavioral of Ejercicio8 is
--contador modulo 6
signal cnt,n_cnt: unsigned (2 downto 0);
begin
--CONTADOR MODULO 6
	cnt<=unsigned(A);
	--proceso secuencial
	process(CLK,RST)
	begin
		if(RST='1') then cnt<="000";
		elsif(CLK'event and CLK='1') then cnt<=n_cnt;
		end if;
	end process;
	--proceso combinacional
	n_cnt<=(cnt+1) when cnt<10 else "000";
	
	process(n_cnt,RST)
	begin
	LEDS<="00000"; 
		if(n_cnt=1) then LEDS<="10000";
		elsif(n_cnt=2) then LEDS<="11000";
		elsif(n_cnt=3) then LEDS<="11100";
		elsif(n_cnt=4) then LEDS<="11110";
		elsif(n_cnt=5) then LEDS<="11111";
		elsif(n_cnt=6) then LEDS<="11110";
		elsif(n_cnt=7) then LEDS<="11100";
		elsif(n_cnt=8) then LEDS<="11000";
		elsif(n_cnt=9) then LEDS<="10000";
		end if;
	end process;
end Behavioral;

