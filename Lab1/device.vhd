----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.09.2024 20:13:46
-- Design Name: 
-- Module Name: device - Behavioral
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

entity device is
    Port(
        A, B, C, D, E, F, G, H, I, XMIT: in std_logic;
        PERR: out std_logic;
        PARITY: inout std_logic
    );
end device;

architecture Behavioral of device is
    signal tmp1, tmp2, tmp3, tmp4: std_logic;
begin
    tmp1 <= (A xnor B) xnor (not C);
    tmp2 <= (D xnor E) xnor (not F);
    tmp3 <= (G xnor H) xnor (not I);
    tmp4 <= (tmp1 xnor tmp2) xnor (not tmp3);
    PARITY <= not tmp4 when XMIT = '0' else 'Z';
    PERR <= '1' when XMIT = '0' else ((not tmp4) xnor (not PARITY)) nand XMIT; 
end Behavioral;
