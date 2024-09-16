-- HW1 Solution
-- By: Negin Safari 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top is
    port (
        -- Inputs
        clk     : in std_logic;
        rst : in std_logic;
        start   : in std_logic;
        data    : in std_logic_vector(7 downto 0);

        -- Outputs
        ready   : out std_logic;
        average : out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavorial of top is
    --Component Instantiations
    component controller is
        port (
            clk:  IN STD_LOGIC;
            rst:  IN STD_LOGIC;
            start:  IN STD_LOGIC;

            outReg_init0: OUT std_logic;
            outReg_ld: OUT std_logic;

            ready: OUT std_logic
        );
    end component controller;

    component datapath is
        port (
            clk     : in std_logic;
            rst:  IN STD_LOGIC;
            outReg_init0: IN std_logic;
            outReg_ld: IN std_logic;
            data    : in std_logic_vector(7 downto 0);
            average : out std_logic_vector(7 downto 0)
        );
    end component datapath;

    signal outReg_init0, outReg_ld : std_logic;
begin
    CU : controller port map (
        clk => clk,
        rst => rst,
        start => start,
        outReg_init0 => outReg_init0,
        outReg_ld => outReg_ld,
        ready => ready
    );

    DP : datapath port map (
        clk => clk,
        rst => rst,
        outReg_init0 => outReg_init0,
        outReg_ld => outReg_ld,
        data => data,
        average => average
    );
    
end Behavorial;