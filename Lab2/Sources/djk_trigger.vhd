----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2024 14:22:09
-- Design Name: 
-- Module Name: djk_trigger - Behavioral
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

entity djk_trigger is
    Port (
        N_R: in std_logic;
        N_S: in std_logic;
        D: in std_logic;
        N_C: in std_logic;
        Q: out std_logic;
        N_Q: out std_logic
    );
end djk_trigger;

architecture Behavioral_djk of djk_trigger is

component jk_trigger is
        Port (
            N_R: in std_logic;
            N_S: in std_logic;
            J: in std_logic;
            K: in std_logic;
            C: in std_logic;
            Q: out std_logic;
            N_Q: out std_logic
        );
end component;
    
signal temp, tempj, tempk: std_logic := '0';
    
begin

jkt: jk_trigger port map (
        N_S => N_S,
        N_R => N_R,
        Q => Q,
        N_Q => N_Q,
        J => tempj,
        K => tempk,
        C => N_C
);

tempj <= D;
tempk <= not(D);

end Behavioral_djk;
