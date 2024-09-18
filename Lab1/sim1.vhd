----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.09.2024 20:21:37
-- Design Name: 
-- Module Name: sim1 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim1 is
--  Port ( );
end sim1;

architecture Behavioral of sim1 is
component device is
    Port(
        A, B, C, D, E, F, G, H, I, XMIT: in std_logic;
        PERR: out std_logic;
        PARITY: inout std_logic
    );
end component;

signal A, B, C, D, E, F, G, H, I, XMIT: std_logic := '0';
signal PERR: std_logic;
signal PARITY: std_logic := '0';
signal inputArray: std_logic_vector(0 to 9);
signal jv: integer;

begin
    uut: device
        port map (
            A => A,
            B => B,
            C => C,
            D => D,
            E => E,
            F => F,
            G => G,
            H => H,
            I => I,
            XMIT => XMIT,
            PERR => PERR,
            PARITY => PARITY
        );

    sim_proc: process
    begin
    
    for k in std_logic range '0' to '1' loop
        
        for j in 0 to 1024 loop
        
          XMIT <= k;
          jv <= j;
          inputArray <= std_logic_vector(conv_unsigned(j, 10));
          A <= inputArray(0);
          B <= inputArray(1);
          C <= inputArray(2);
          D <= inputArray(3);
          E <= inputArray(4);
          F <= inputArray(5);
          G <= inputArray(6);
          H <= inputArray(7);
          I <= inputArray(8);
  
          if (XMIT = '1') then
            PARITY <= inputArray(9);
          else
            PARITY <= 'Z';
          end if;
          
          if(j = 0) then
              A <= '0';
              B <= '0';
              C <= '0';
              D <= '0';
              E <= '0';
              F <= '0';
              G <= '0';
              H <= '0';
              I <= '0';
              if(k = '1') then
                PARITY <= '0';
              else
                PARITY <= 'Z';
              end if;
          end if;
          
          wait for 10 ns;
        end loop;
    end loop;

    end process;

end Behavioral;
