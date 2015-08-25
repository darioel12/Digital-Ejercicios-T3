----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:37:01 03/23/2015 
-- Design Name: 
-- Module Name:    ejercicio_clase1 - Behavioral 
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

entity ejercicio_clase1 is
    Port ( S : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Pulso_up : out  STD_LOGIC);
end ejercicio_clase1;

architecture Behavioral of ejercicio_clase1 is
	type states is (cero,uno,pulso);
	signal n_state, p_state : states;
	
begin --proceso secuencial
		process (CLK,RST)
		begin
			if(RST='1') then p_state <=uno;
			elsif (CLK' event and CLK='1') then
				p_state<=n_state;
			end if;
		end process;
		
		process (S, p_state) -- proceso combinacional
			begin
			n_state <= p_state;
			Pulso_up <= '0';
			case p_state is
				when uno =>
					if( S='0') then n_state <= cero;
					end if;
				when cero =>
					if (S='1') then n_state <= pulso;
					end if;
				when pulso =>
					Pulso_up <= '1';
					if (S='0') then n_state <= cero;
					else n_state <= uno;
					end if;
			end case;
		end process;
end Behavioral;

