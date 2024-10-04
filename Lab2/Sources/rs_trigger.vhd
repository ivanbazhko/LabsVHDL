----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2024 17:46:18
-- Design Name: 
-- Module Name: rs_trigger - Behavioral_rs
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

entity rs_trigger is
    Port (
        N_S: in std_logic;
        N_R: in std_logic;
        Q: out std_logic;
        N_Q: out std_logic
    );
end rs_trigger;

architecture Behavioral_rs of rs_trigger is

signal temp: std_logic := '0';

begin
    process (N_S, N_R)
    begin
        if N_R='0' and N_S='0' then 
            temp <= 'X';
        elsif N_R='0' then   
            temp <= '0';
        elsif N_S='0' then   
            temp <= '1';
        end if;
    end process;
    
    Q <= temp;
    N_Q <= not(temp);

end Behavioral_rs;
