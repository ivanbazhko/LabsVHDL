----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2024 18:03:37
-- Design Name: 
-- Module Name: d_sim - Behavioral_d
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

entity d_sim is
--  Port ( );
end d_sim;

architecture Behavioral_d of d_sim is

    component d_trigger
        Port (
            N_R: in std_logic;
            N_S: in std_logic;
            D: in std_logic;
            N_C: in std_logic;
            Q: out std_logic;
            N_Q: out std_logic
        );
    end component;

    signal D : std_logic := '0';
    signal N_C : std_logic := '0';
    signal N_R : std_logic := '1';
    signal N_S : std_logic := '1';
    signal Q : std_logic;
    signal N_Q : std_logic;

    begin
        dtb: d_trigger port map (
            D => D,
            N_C => N_C,
            N_R => N_R,
            N_S => N_S,
            Q => Q,
            N_Q => N_Q
        );
        
    clk_process: process
    begin       
        N_C <= '1';
        wait for 5 ns;
        N_C <= '0';
        wait for 5 ns;
    end process;
    
    test_process: process
        variable temp : std_logic := '0';
        begin                
            for i in 0 to 3 loop
                D <= temp;
                wait for 10 ns;
                D <= not(temp);
                wait for 10 ns;
            end loop;
            
            N_S <= '0';
            N_R <= '1';
            for i in 0 to 3 loop
                D <= temp;
                wait for 10 ns;
                D <= not(temp);
                wait for 10 ns;
            end loop;
            
            N_S <= '1';
            N_R <= '0';
            for i in 0 to 3 loop
                D <= temp;
                wait for 10 ns;
                D <= not(temp);
                wait for 10 ns;
            end loop;
                  
            N_S <= '1';
            N_R <= '1';  
        end process;

end Behavioral_d;
