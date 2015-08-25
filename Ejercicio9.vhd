----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:06:57 06/15/2015 
-- Design Name: 
-- Module Name:    Ejercicio9 - Behavioral 
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

entity Ejercicio9 is
    Port ( CLK : in  STD_LOGIC;
           A : in  STD_LOGIC;
			  RST: in STD_LOGIC;
			  CNT: in STD_LOGIC_VECTOR(3 downto 0);
           LEDS : out  STD_LOGIC);
end Ejercicio9;

architecture Behavioral of Ejercicio9 is
signal p_cnt: unsigned(3 downto 0);
signal ss: unsigned (3 downto 0);
begin

process(RST,CLK)
begin
if(RST='1') then cnt<="0000";
elsif(CLK'event and CLK='1') then cnt<=p_cnt;
end if;
end process;

p_cnt<=cnt+1 when cnt<10 else "0000";



end Behavioral;

