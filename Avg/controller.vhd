library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Jonathan Lopez
-- ECE 5723 Spring 2024 WPI
-- Homework # 1: Logic design and modeling using VHDL
-- Simualtor: Siemens (Mentor Graphics) Questa Intel FPGA Starter Editon 2021.2
-- Description: Controller Module for Averaging Circuit

entity Controller is
    port (
        -- Inputs
        clk     : in std_logic;
        reset_n : in std_logic;
        start   : in std_logic;
        
        -- Outputs
        cntr    : out std_logic_vector(3 downto 0):= (others => '0');
        ready   : out std_logic
    );
end Controller;

architecture Behavorial of Controller is
    -- State Machine Enum
    type StateT is (RESET, WAIT_INFO, COUNT, READY_AVG);
    signal state : StateT;
    
begin
    process(clk, reset_n)
    begin
        if (reset_n = '0') then
            state <= RESET;
        elsif rising_edge(clk) then
            case state is
                when RESET => 
                    cntr <= (others => '0');
                    ready <= '0';
                    state <= WAIT_INFO;
                when WAIT_INFO =>
                    if start = '1' then
                        ready <= '0';
                        state <= COUNT;
                    end if;
                when COUNT =>
                    if cntr = "1010" then
                        state <= READY_AVG;
                        ready <= '1';
                    else
                        cntr <= cntr + '1';
                    end if;
                when READY_AVG =>
                    state <= WAIT_INFO;
            end case; 
        end if;
    end process;    
end Behavorial;  