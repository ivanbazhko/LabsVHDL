----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2024 14:22:28
-- Design Name: 
-- Module Name: rsjk_trigger - Behavioral_rsjk
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

entity rsjk_trigger is
Port (
    N_S: in std_logic;
    N_R: in std_logic;
    Q: out std_logic;
    N_Q: out std_logic
);
end rsjk_trigger;

architecture Behavioral_rsjk of rsjk_trigger is

signal tempq: std_logic;                                
signal tempnq: std_logic;
signal inr: std_logic := '1';
signal ins: std_logic := '1';
signal sigfin: std_logic := '0';                                
signal signfin: std_logic := '1';

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

begin

jkt: jk_trigger port map (
        N_S => ins,
        N_R => inr,
        Q => Q,
        N_Q => N_Q,
        J => '0',
        K => '0',
        C => '1'
);

process (N_S, N_R)
begin
    if N_R='0' and N_S='0' then 
        inr <= '1';
        ins <= '1';
    else
        inr <= N_R;
        ins <= N_S;
    end if;
end process;

end Behavioral_rsjk;
