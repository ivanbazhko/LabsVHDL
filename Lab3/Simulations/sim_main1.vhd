----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2024 12:04:19
-- Design Name: 
-- Module Name: sim_main1 - Behavioral_sm1
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

entity sim_main1 is
--  Port ( );
end sim_main1;

architecture Behavioral_sm1 of sim_main1 is

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
--file test_input : text open read_mode is "D:\AP_sneeze\input_counter.txt";
--file test_output : text open read_mode is "D:\AP_sneeze\output_counter.txt";
file test_input : text open read_mode is "D:\AP_sneeze\LAB3\Lab3_generator\full_input_counter.txt";
file test_output : text open read_mode is "D:\AP_sneeze\LAB3\Lab3_generator\full_output_counter.txt";
constant passed : string(1 to 7) := "passed ";
constant error : string(1 to 7) := "ERROR: ";

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

    variable curr_line, output_line : line;
    variable vector_value : std_logic_vector(7 downto 0);
    variable output_value : std_logic_vector(5 downto 0);
    variable temp1 : integer := 1;
    
    begin
    
    while not endfile(test_input) loop
    
        readline(test_input, curr_line);
        read(curr_line, vector_value);
        
        CLR <= vector_value(7);
        UP <= vector_value(6);
        DOWN <= vector_value(5);
        NLOAD <= vector_value(4);
        D <= vector_value(3);
        C <= vector_value(2);
        B <= vector_value(1);
        A <= vector_value(0);
        
        readline(test_output, output_line);
        read(output_line, output_value);
        
        wait for 1 ns;
        
        if (Qa = output_value(0)) and (Qb = output_value(1)) and (Qc = output_value(2)) and (Qd = output_value(3)) and (NBO = output_value(4)) and (NCO = output_value(5)) then
            report passed & integer'image(temp1);
        else
            report error & integer'image(temp1) & " OUT = " & std_logic'image(NCO) & std_logic'image(NBO)& std_logic'image(Qd)& std_logic'image(Qc)& std_logic'image(Qb)& std_logic'image(Qa) & ", TARGET = " & std_logic'image(output_value(5)) & std_logic'image(output_value(4)) & std_logic'image(output_value(3)) & std_logic'image(output_value(2)) & std_logic'image(output_value(1)) & std_logic'image(output_value(0)) severity failure;
--                report error;
        end if;
        
        temp1 := temp1 + 1;
         
        wait for 1 ns;
            
    end loop;
    
    wait;
    
end process;

end Behavioral_sm1;
