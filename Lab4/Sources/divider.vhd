----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2019 22:56:35
-- Design Name: 
-- Module Name: DIVIDER - Behavioral
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

entity divider is
Port ( 
    clki : in std_logic;
    clko : out std_logic
);
end divider;

architecture Behavioral of divider is
    signal i: integer := 0;
    signal temp: std_logic := '0';
    
    constant divide_value: integer := 50000000;
begin
    process (clki)
    begin
        if rising_edge(clki) then
            if (i = divide_value) then
                i <= 0;
                temp <= not temp;
            else i <= i + 1;
            end if;
        end if;
    end process;
    
    clko <= temp;       
end Behavioral;