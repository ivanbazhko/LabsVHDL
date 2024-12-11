----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2024 11:19:50
-- Design Name: 
-- Module Name: circuit - Behavioral
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

entity circuit is
    Port (
        ledsmain: out std_logic_vector(3 downto 0);
        ledsboard: out std_logic_vector(3 downto 0);
        pushbuttons: in std_logic_vector(4 downto 0);
        dipswitch: in std_logic_vector(3 downto 0);
        sysclk_p: in std_logic;
        sysclk_n: in std_logic
    );
end circuit;

-- ibufds

architecture Behavioral of circuit is

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

component ibufds
    port (
        i, ib : in std_logic; 
        o : out std_logic
    );
end component;

component divider is
    port ( 
        clki : in STD_LOGIC;
        clko : out STD_LOGIC
    );
end component;

component button is
  Port (
    ins: in std_logic;
    ous: out std_logic;
    clk: in std_logic
  );
end component;

signal nb1, nb2, nb3: std_logic;
signal ba, bb, bc, bd, res, clk, clknd: std_logic;

begin

    buffds: ibufds port map (
        i => sysclk_p, 
        ib => sysclk_n, 
        o => clknd
    );
    
    div: divider port map (
        clki => clknd, 
        clko => clk
    );

    device: main port map (
        CLR => ba,
        UP => bb,
        DOWN => bc,
        NLOAD => bd,
        A => dipswitch(3),
        B => dipswitch(2),
        C => dipswitch(1),
        D => dipswitch(0),
        NCO => ledsmain(0),
        NBO => ledsmain(1),
        Qa => ledsboard(0),
        Qb => ledsboard(1),
        Qc => ledsboard(2),
        Qd => ledsboard(3)
    );
    
    b0: button port map (
        ins => pushbuttons(0),
        ous => ba,
        clk => clk
    );
    
    b1: button port map (
        ins => nb1,
        ous => bb,
        clk => clk
    );
    
    b2: button port map (
        ins => nb2,
        ous => bc,
        clk => clk
    );
    
    b3: button port map (
        ins => nb3,
        ous => bd,
        clk => clk
    );
    
    nb1 <= not(pushbuttons(1));
    nb2 <= not(pushbuttons(2));
    nb3 <= not(pushbuttons(3));
    
end Behavioral;
