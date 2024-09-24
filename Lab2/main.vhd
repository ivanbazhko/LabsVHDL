----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2024 16:33:37
-- Design Name: 
-- Module Name: main - Behavioral_main
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

entity main is
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
end main;

architecture Behavioral_main of main is

    component rs_trigger is
    Port (
        N_S: in std_logic;
        N_R: in std_logic;
        Q: out std_logic;
        N_Q: out std_logic
    );
    end component;
    
    component d_trigger is
        Port (
            N_R: in std_logic;
            N_S: in std_logic;
            D: in std_logic;
            N_C: in std_logic;
            Q: out std_logic;
            N_Q: out std_logic
        );
    end component;
    
    signal dclk: std_logic;
    signal rsout: std_logic;
    signal nrsout: std_logic;
    signal nqa: std_logic;
    signal nqb: std_logic;
    signal nqc: std_logic;
    signal nqd: std_logic;
    
    signal nrda, nsda, dda: std_logic;
    signal nrdb, nsdb, ddb: std_logic;
    signal nrdc, nsdc, ddc: std_logic;
    signal nrdd, nsdd, ddd: std_logic;

begin

    rs_1: rs_trigger port map (
        N_S => UP,
        N_R => DOWN,
        Q => rsout,
        N_Q => nrsout
    );
    
    d_1: d_trigger port map (
        N_R => nrda,
        N_S => nsda,
        D => dda,
        N_C => dclk,
        Q => Qa,
        N_Q => nqa
    );
    
    d_2: d_trigger port map (
        N_R => nrdb,
        N_S => nsdb,
        D => ddb,
        N_C => dclk,
        Q => Qb,
        N_Q => nqb
    );
    
    d_3: d_trigger port map (
        N_R => nrdc,
        N_S => nsdc,
        D => ddc,
        N_C => dclk,
        Q => Qc,
        N_Q => nqc
    );
    
    d_4: d_trigger port map (
        N_R => nrdd,
        N_S => nsdd,
        D => ddd,
        N_C => dclk,
        Q => Qd,
        N_Q => nqd
    );
    
    dclk <= not(UP and DOWN);
    
    NCO <= not(not(nqa) and not(nqb) and not(nqc) and not(nqd) and not(UP));
    NBO <= not(nqa and nqb and nqc and nqd and not(DOWN));
    
    nsda <= not(A and not(CLR) and not(NLOAD));
    nrda <= not(CLR) and not(not(A) and not(NLOAD));
    dda <= nqa;
    
    nsdb <= not(B and not(CLR) and not(NLOAD));
    nrdb <= not(CLR) and not(not(B) and not(NLOAD));
    ddb <= ((not(nqa) xor not(nqb)) and rsout) or ((not(nqb) xor nqa) and nrsout);
    
    nsdc <= not(C and not(CLR) and not(NLOAD));
    nrdc <= not(CLR) and not(not(C) and not(NLOAD));
    ddc <= (((not(nqa) and not(nqb)) xor not(nqc)) and rsout) or (((nqa and nqb) xor not(nqc)) and nrsout);
        
    nsdd <= not(D and not(CLR) and not(NLOAD));
    nrdd <= not(CLR) and not(not(D) and not(NLOAD));
    ddd <= (((not(nqa) and not(nqb) and not(nqc)) xor not(nqd)) and rsout) or (((nqa and nqb and nqc) xor not(nqd)) and nrsout);

end Behavioral_main;
