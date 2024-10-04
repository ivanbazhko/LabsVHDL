----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2024 17:46:42
-- Design Name: 
-- Module Name: rs_sim - Behavioral_rs
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

entity rs_sim is
--  Port ( );
end rs_sim;

architecture Behavioral_rs of rs_sim is
    component rs_trigger
        Port (
            N_S: in std_logic;
            N_R: in std_logic;
            Q: out std_logic;
            N_Q: out std_logic
        );
    end component;

    signal N_S : std_logic := '1';
    signal N_R : std_logic := '1';
    signal Q : std_logic;
    signal N_Q : std_logic;

    begin
    rstb: rs_trigger port map (
        N_S => N_S,
        N_R => N_R,
        Q => Q,
        N_Q => N_Q
    );

    test_process: process
    begin
        
--        wait for 20 ns;
        N_S <= '0';
        wait for 20 ns;
        N_R <= '0';
        wait for 20 ns;
        N_S <= '1';
        wait for 20 ns;
        N_R <= '1';
        wait for 20 ns;
        
    end process;

end Behavioral_rs;
