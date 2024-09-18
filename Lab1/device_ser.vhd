----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.09.2024 22:48:55
-- Design Name: 
-- Module Name: device_ser - Behavioral_ser
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity device_ser is
    Port(
        A, B, C, D, E, F, G, H, I, XMIT: in std_logic;
        PERR: out std_logic;
        PARITY: inout std_logic
    );
end device_ser;

architecture Behavioral_ser of device_ser is

begin
    process is
        variable temp1 : integer := 0;
        begin
        
            if(XMIT = '0') then
                temp1 := 0;
                if (A = '1') then temp1 := temp1 + 1; end if;
                if (B = '1') then temp1 := temp1 + 1; end if;
                if (C = '1') then temp1 := temp1 + 1; end if;
                if (D = '1') then temp1 := temp1 + 1; end if;
                if (E = '1') then temp1 := temp1 + 1; end if;
                if (F = '1') then temp1 := temp1 + 1; end if;
                if (G = '1') then temp1 := temp1 + 1; end if;
                if (H = '1') then temp1 := temp1 + 1; end if;
                if (I = '1') then temp1 := temp1 + 1; end if;
                if (temp1 mod 2 = 1) then
                    PARITY <= '0';
                    PERR <= '1';
                else
                    PARITY <= '1';
                    PERR <= '1';
                end if;
                
            else
                temp1 := 0;
                PARITY <= 'Z';
                if (A = '1') then temp1 := temp1 + 1; end if;
                if (B = '1') then temp1 := temp1 + 1; end if;
                if (C = '1') then temp1 := temp1 + 1; end if;
                if (D = '1') then temp1 := temp1 + 1; end if;
                if (E = '1') then temp1 := temp1 + 1; end if;
                if (F = '1') then temp1 := temp1 + 1; end if;
                if (G = '1') then temp1 := temp1 + 1; end if;
                if (H = '1') then temp1 := temp1 + 1; end if;
                if (I = '1') then temp1 := temp1 + 1; end if;
                if (temp1 mod 2 = 1) then
                    if(PARITY = '0') then
                        PERR <= '1';
                    else
                        PERR <= '0';
                    end if;
                else
                    if(PARITY = '0') then
                        PERR <= '0';
                    else
                        PERR <= '1';
                    end if;
                end if;
                
            end if;
    
    end process;

end Behavioral_ser;
