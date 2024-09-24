----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2024 16:35:26
-- Design Name: 
-- Module Name: main_sim - Behavioral_main
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

entity main_sim is
--  Port ( );
end main_sim;

architecture Behavioral_main of main_sim is
    
    component main is
    Port (
        CLR: in std_logic;
        UP: in std_logic;
        DOWN: in std_logic;
        NLOAD: in std_logic;
        A: in std_logic;
        B: in std_logic;
        C: in std_logic;
        D: in std_logic;
        NCO: out std_logic;
        NBO: out std_logic;
        Qa: out std_logic;
        Qb: out std_logic;
        Qc: out std_logic;
        Qd: out std_logic
    );
    end component;
    
    signal CLR, A, B, C, D, Qa, Qb, Qc, Qd: std_logic := '0';
    signal NLOAD, UP, DOWN, NCO, NBO: std_logic := '1';
    
begin

    uut: main port map (
        CLR => CLR,
        UP => UP,
        DOWN => DOWN,
        NLOAD => NLOAD,
        A => A,
        B => B,
        C => C,
        D => D,
        NCO => NCO,
        NBO => NBO,
        Qa => Qa,
        Qb => Qb,
        Qc => Qc,
        Qd => Qd
    );
    
    sim_proc: process
    begin
    
    wait for 10 ns;
    
    -- Loading 9
    A <= '1';
    D <= '1';
    NLOAD <= '0';
    wait for 10 ns;
    NLOAD <= '1';
    
    -- Clearing
    CLR <= '1';
    wait for 10 ns;
    CLR <= '0';
    wait for 10 ns;
    
    -- Counting Down To 13
    DOWN <= '0';
    wait for 10 ns;  
    DOWN <= '1';
    wait for 10 ns;
    DOWN <= '0';
    wait for 10 ns;
    DOWN <= '1'; 
    wait for 10 ns;
    DOWN <= '0';     
    wait for 10 ns;
    DOWN <= '1';  
    wait for 10 ns;
    
    -- Counting Up To 1
    UP <= '0';     
    wait for 10 ns;
    UP <= '1';  
    wait for 10 ns;
    UP <= '0';     
    wait for 10 ns;
    UP <= '1';  
    wait for 10 ns;
    UP <= '0';     
    wait for 10 ns;
    UP <= '1';  
    wait for 10 ns;
    UP <= '0';     
    wait for 10 ns;
    UP <= '1';
    
    -- Loading 13
    A <= '1';
    C <= '1';
    D <= '1';
    NLOAD <= '0';
    wait for 10 ns;
    NLOAD <= '1';
    
    -- Counting Down To 9
    DOWN <= '0';
    wait for 10 ns;  
    DOWN <= '1';
    wait for 10 ns;
    DOWN <= '0';
    wait for 10 ns;
    DOWN <= '1'; 
    wait for 10 ns;
    DOWN <= '0';     
    wait for 10 ns;
    DOWN <= '1';  
    wait for 10 ns;
    DOWN <= '0';     
    wait for 10 ns;
    DOWN <= '1';  
      
    wait for 100 ns;
    
    end process;
    
end Behavioral_main;
