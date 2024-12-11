----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.10.2024 12:28:02
-- Design Name: 
-- Module Name: sim1_2 - sim1_2
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

entity sim1_2 is
--  Port ( );
end sim1_2;

architecture sim1_2 of sim1_2 is

component device is
    Port(
        A, B, C, D, E, F, G, H, I, XMIT: in std_logic;
        PERR: out std_logic;
        PARITY: inout std_logic
    );
end component;

component device_ser is
    Port(
        A, B, C, D, E, F, G, H, I, XMIT: in std_logic;
        PERR: out std_logic;
        PARITY: inout std_logic
    );
end component;

signal A, B, C, D, E, F, G, H, I, XMIT: std_logic := '0';
signal PARITY: std_logic := '0';
signal PERR: std_logic;

signal Ab, Bb, Cb, Db, Eb, Fb, Gb, Hb, Ib, XMITb: std_logic := '0';
signal PARITYb: std_logic := '0';
signal PERRb: std_logic;

file test_input : text open read_mode is "D:\AP_sneeze\LAB3\Project3\Project3.srcs\sim_1\new\input_2048.txt";

constant passed : string(1 to 7) := "passed ";
constant error : string(1 to 7) := "ERROR: ";

begin

dev1: device
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
    
dev2: device_ser
    port map (
        A => Ab,
        B => Bb,
        C => Cb,
        D => Db,
        E => Eb,
        F => Fb,
        G => Gb,
        H => Hb,
        I => Ib,
        XMIT => XMITb,
        PERR => PERRb,
        PARITY => PARITYb
    );

sim_proc: process

    variable curr_line, output_line : line;
    variable vector_value : std_logic_vector(0 to 10);
    variable temp1 : integer := 1;

    begin
    
    while not endfile(test_input) loop
    
        readline(test_input, curr_line);
        read(curr_line, vector_value);
        
        A <= vector_value(10);
        Ab <= vector_value(10);
        B <= vector_value(9);
        Bb <= vector_value(9);
        C <= vector_value(8);
        Cb <= vector_value(8);
        D <= vector_value(7);
        Db <= vector_value(7);
        E <= vector_value(6);
        Eb <= vector_value(6);
        F <= vector_value(5);
        Fb <= vector_value(5);
        G <= vector_value(4);
        Gb <= vector_value(4);
        H <= vector_value(3);
        Hb <= vector_value(3);
        I <= vector_value(2);
        Ib <= vector_value(2);
        if (vector_value(0) = '1') then
            PARITY <= vector_value(1);
            PARITYb <= vector_value(1);
        else
            PARITY <= 'Z';
            PARITYb <= 'Z';
        end if;
        XMIT <= vector_value(0);
        XMITb <= vector_value(0);
       
        wait for 1 ns;
        
        if (PARITY = PARITYb) and (PERR = PERRb) then
            report passed & integer'image(temp1);
        else
            report error & integer'image(temp1) & " OUT = " & std_logic'image(PARITY) & std_logic'image(PERR) & ", TARGET = " & std_logic'image(PARITYb) & std_logic'image(PERRb) severity failure;
        end if;
        
        temp1 := temp1 + 1;
        
        wait for 1 ns;
        
    end loop;
    
    wait;

    end process;

end sim1_2;
