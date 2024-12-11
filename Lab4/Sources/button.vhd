----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2024 14:43:33
-- Design Name: 
-- Module Name: button - Behavioral_button
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

entity button is
  Port (
    ins: in std_logic;
    ous: out std_logic;
    clk: in std_logic
  );
end button;

architecture Behavioral_button of button is

signal temp: std_logic := '0';
constant wait_time: time := 100000000 ns;

begin

process(clk)
begin
    if rising_edge(clk) then
        if ins = '0' and temp = '0' then
            temp <= '0';
        elsif ins = '0' and temp = '1' then
            temp <= '0';
        elsif ins = '1' and temp = '0' then
            temp <= '1';
        elsif ins = '1' and temp = '1' then
            temp <= '1';
        end if;
    end if;
end process;

ous <= temp;

end Behavioral_button;
