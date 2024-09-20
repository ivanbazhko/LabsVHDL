----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2024 11:29:51
-- Design Name: 
-- Module Name: jk_trigger - Behavioral_jk
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

entity jk_trigger is
    Port (
        N_R: in std_logic;
        N_S: in std_logic;
        J: in std_logic;
        K: in std_logic;
        C: in std_logic;
        Q: out std_logic;
        N_Q: out std_logic
    );
end jk_trigger;

architecture Behavioral_jk of jk_trigger is

signal temp: std_logic := '0';

begin
    process (C, N_R, N_S)
    begin
        if N_R='0' and N_S='0' then 
            temp <= 'X';
        elsif N_R='0' then   
            temp <= '0';
        elsif N_S='0' then   
            temp <= '1';
        elsif rising_edge(C) then                 
            if (J='0' and K='0') then
                temp <= temp;
            elsif (J='0' and K='1') then
                temp <= '0';
            elsif (J='1' and K='0') then
                temp <= '1';
            elsif (J='1' and K='1') then
                temp <= not (temp);
            end if;
        end if;
    end process;
    
    Q <= temp;
    N_Q <= not(temp);

end Behavioral_jk;
