library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Jonathan Lopez
-- ECE 5723 Spring 2024 WPI
-- Homework # 1: Logic design and modeling using VHDL
-- Simualtor: Siemens (Mentor Graphics) Questa Intel FPGA Starter Editon 2021.2
-- Description: Top Module for Averaging Circuit

entity top is
    port (
        -- Inputs
        clk     : in std_logic;
        reset_n : in std_logic;
        start   : in std_logic;
        data    : in std_logic_vector(7 downto 0);

        -- Outputs
        ready   : out std_logic;
        average : out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavorial of top is
    --Component Instantiations
    component Controller is
        port (
            clk     : in std_logic;
            reset_n : in std_logic;
            start   : in std_logic;
            cntr    : out std_logic_vector(3 downto 0);
            ready   : out std_logic
        );
    end component Controller;

    component Datapath is
        port (
            clk     : in std_logic;
            cntr    : in std_logic_vector(3 downto 0);
            data    : in std_logic_vector(7 downto 0);
            average : out std_logic_vector(7 downto 0)
        );
    end component Datapath;

    signal cntr_i : std_logic_vector(3 downto 0);
begin
    CNTRLR_0 : Controller port map (
        clk => clk,
        reset_n => reset_n,
        start => start,
        cntr => cntr_i,
        ready => ready
    );

    DP_0 : Datapath port map (
        clk => clk,
        cntr => cntr_i,
        data => data,
        average => average
    );
    
end Behavorial;