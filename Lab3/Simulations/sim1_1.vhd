----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.10.2024 10:37:38
-- Design Name: 
-- Module Name: sim1_1 - sim1_1
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim1_1 is
--  Port ( );
end sim1_1;

architecture sim1_1 of sim1_1 is

component device is
    Port(
        A, B, C, D, E, F, G, H, I, XMIT: in std_logic;
        PERR: out std_logic;
        PARITY: inout std_logic
    );
end component;

signal A, B, C, D, E, F, G, H, I, XMIT: std_logic := '0';
signal PARITY: std_logic := '0';
signal PERR: std_logic;

file output : text open read_mode is "D:\AP_sneeze\LAB3\Project3\Project3.srcs\sim_1\new\output_2048.txt";
file test_input : text open read_mode is "D:\AP_sneeze\LAB3\Project3\Project3.srcs\sim_1\new\input_2048.txt";

constant passed : string(1 to 7) := "passed ";
constant error : string(1 to 7) := "ERROR: ";

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

    variable curr_line, output_line : line;
    variable vector_value : std_logic_vector(0 to 10);
    variable output_value : std_logic_vector(0 to 1);
    variable temp1 : integer := 1;

    begin
    
    while not endfile(test_input) loop
    
        readline(test_input, curr_line);
        read(curr_line, vector_value);
        
        A <= vector_value(10);
        B <= vector_value(9);
        C <= vector_value(8);
        D <= vector_value(7);
        E <= vector_value(6);
        F <= vector_value(5);
        G <= vector_value(4);
        H <= vector_value(3);
        I <= vector_value(2);
        if (vector_value(0) = '1') then
            PARITY <= vector_value(1);
        else
            PARITY <= 'Z';
        end if;
        XMIT <= vector_value(0);
        
        readline(output, output_line);
        read(output_line, output_value);
        
        wait for 1 ns;
        
        if (PARITY = output_value(0)) and (PERR = output_value(1)) then
            report passed & integer'image(temp1);
        else
            report error & integer'image(temp1) & " OUT = " & std_logic'image(PARITY) & std_logic'image(PERR) & ", TARGET = " & std_logic'image(output_value(0)) & std_logic'image(output_value(1)) severity failure;
        end if;
        
        temp1 := temp1 + 1;
        
        wait for 1 ns;
        
    end loop;
    
    wait;

    end process;

end sim1_1;
