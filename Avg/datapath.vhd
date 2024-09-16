library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Jonathan Lopez
-- ECE 5723 Spring 2024 WPI
-- Homework # 1: Logic design and modeling using VHDL
-- Simualtor: Siemens (Mentor Graphics) Questa Intel FPGA Starter Editon 2021.2
-- Description: Datapath Module for Averaging Circuit

entity Datapath is
    port (
        -- Inputs
        clk     : in std_logic;
        cntr    : in std_logic_vector(3 downto 0);
        data    : in std_logic_vector(7 downto 0);

        -- Output
        average : out std_logic_vector(7 downto 0)
    );
end Datapath;

architecture Behavorial of Datapath is
    signal num0, num1, num2, num3, num4, num5, num6, num7 : std_logic_vector (7 downto 0):= (others => '0');
    signal sum : std_logic_vector(10 downto 0):= (others => '0');
    signal sum_i : std_logic_vector(10 downto 0):= (others => '0');
    signal start_avg : std_logic;
    
begin
    process(cntr) begin
        case cntr is
            when "0001" =>
                num0 <= data;
                start_avg <= '0';
                --sum <= sum + num0;
            when "0010" =>
                num1 <= data;
                sum <= sum + num0;
            when "0011" =>
                num2 <= data;
                sum <= sum + num1;
            when "0100" =>
                num3 <= data;
                sum <= sum + num2;
            when "0101" =>
                num4 <= data;
                sum <= sum + num3;
            when "0110" =>
                num5 <= data;
                sum <= sum + num4;
            when "0111" =>
                num6 <= data;
                sum <= sum + num5;
            when "1000" =>
                num7 <= data;
                sum <= sum + num6;
            when "1001" =>
                sum <= sum + num7;
                start_avg <= '1';
            when others =>
                start_avg <= '0';
                --sum <= num0 + num1 + num2 + num3 + num4 + num5 + num6 + num7;
        end case;
        if start_avg = '1' then
            sum_i <= sum srl 3;
        end if;
    end process;
    process(clk) begin
        if rising_edge(clk) then
            if sum_i >= X"000" then
                average <= sum_i(7 downto 0);
            end if;
        end if;``
    end process ;
end Behavorial; 