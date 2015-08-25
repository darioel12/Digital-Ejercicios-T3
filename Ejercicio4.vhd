----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:46:51 06/10/2015 
-- Design Name: 
-- Module Name:    Ejercicio4 - Behavioral 
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

entity Ejercicio4 is
    Port ( Q : in  STD_LOGIC_VECTOR (7 downto 0);
			  CLK: in STD_LOGIC;
			  RST: in STD_LOGIC
			  );
			  
end Ejercicio4;

architecture Behavioral of Ejercicio4 is
	signal nq,pq: std_logic_vector(7 downto 0);
	signal ld_dato: std_logic;

begin
--PROCESO SECUENCIAL
	process(CLK,RST)
	begin
	if(RST='0') then pq<="00000000";
	elsif (CLK'event and CLK='1') then pq<=nq;
	end if;
	end process;
--PROCESO COMBINACIONAL
	nq<=Q when (ld_dato='1') else pq(6 downto 0)&'0';

end Behavioral;

