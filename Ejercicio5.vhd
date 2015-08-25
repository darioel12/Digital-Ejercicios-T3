----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:16:29 06/10/2015 
-- Design Name: 
-- Module Name:    Ejercicio5 - Behavioral 
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

entity Ejercicio5 is
    Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
           Q : out  STD_LOGIC_VECTOR (3 downto 0);
			  CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
           RIN : in  STD_LOGIC;
           LIN : in  STD_LOGIC);
end Ejercicio5;

architecture Behavioral of Ejercicio5 is
signal s_uv: unsigned (1 downto 0);
signal nq:std_logic_vector (3 downto 0);
begin
	s_uv<=unsigned(S);
	
	--PROCESO SECUENCIAL
	
	process (CLK,RST)
	begin
	if(RST='1') then Q<="0000";
	elsif(CLK'event and CLK='1') then Q<=nq;
	end if;
	end process;
	
	--PROCESO COMBINACIONAL
	nq<=   "0000"     when (s_uv=0) else
			(RIN&"000") when (s_uv=1) else
			("000"&LIN) when (s_uv=2) else
			Q;

end Behavioral;

