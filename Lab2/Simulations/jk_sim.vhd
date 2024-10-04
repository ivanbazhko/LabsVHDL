----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2024 11:31:56
-- Design Name: 
-- Module Name: jk_sim - Behavioral_jk
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

entity jk_sim is
--  Port ( );
end jk_sim;

architecture Behavioral_jk of jk_sim is
    component jk_trigger
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
    
    signal J : std_logic := '0';
    signal K : std_logic := '0';
    signal C : std_logic := '0';
    signal N_R : std_logic := '1';
    signal N_S : std_logic := '1';
    signal Q : std_logic;
    signal N_Q : std_logic;

    begin
    jktb: jk_trigger port map (
        J => J,
        K => K,
        C => C,
        N_R => N_R,
        N_S => N_S,
        Q => Q,
        N_Q => N_Q
    );

    clk_process: process
    begin       
        C <= '0';
        wait for 5 ns;
        C <= '1';
        wait for 5 ns;
    end process;
    
    test_process: process
    variable temp : std_logic := '0';
    begin                
        for i in 0 to 3 loop
            J <= temp;
            wait for 5 ns;
            K <= not(temp);
            temp := not(temp);
            
            wait for 20 ns;
        end loop;
        
        for i in 0 to 3 loop
            J <= temp;
            wait for 5 ns;
            K <= temp;
            temp := not(temp);
            
             wait for 20 ns;
        end loop;
        
        N_S <= '0';
        N_R <= '1';
        for i in 0 to 3 loop
            J <= temp;
            wait for 5 ns;
            K <= not(temp);
            temp := not(temp);
            
             wait for 20 ns;
        end loop;
        
        N_S <= '1';
        N_R <= '0';
        for i in 0 to 3 loop
            J <= temp;
            wait for 5 ns;
            K <= temp;
            temp := not(temp);
            
             wait for 20 ns;
        end loop;
              
        N_S <= '1';
        N_R <= '1';  
    end process;

end Behavioral_jk;
