library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Jonathan Lopez
-- ECE 5723 Spring 2024 WPI
-- Homework # 1: Logic design and modeling using VHDL
-- Simualtor: Siemens (Mentor Graphics) Questa Intel FPGA Starter Editon 2021.2
-- Description: Testbench Module for Averaging Circuit

entity testbench is
end testbench;

architecture simulation of testbench is
    signal clk, start, ready : std_logic := '0';
    signal reset_n : std_logic := '1';
    signal data : std_logic_vector(7 downto 0) := "00000000";
    signal average : std_logic_vector(7 downto 0);

    -- UUT
    component top is
        port (
            clk     : in std_logic;
            reset_n : in std_logic;
            start   : in std_logic;
            data    : in std_logic_vector(7 downto 0);
            ready   : out std_logic;
            average : out std_logic_vector(7 downto 0)
        );
    end component top;

begin

    process begin
        wait for 5 ns;
        clk <= not clk;
    end process;

    process begin
        wait for 5 ns;
        reset_n <= '1';
        wait for 5 ns;
        reset_n <= '0';
        wait for 5 ns;
        reset_n <= '1';
        wait for 5 ns;

        wait for 5 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        --wait for 5 ns;
        data <= X"FF"; -- num0
        wait for 10 ns;
        data <= X"FF"; -- num1
        wait for 10 ns;
        data <= X"FF"; -- num2
        wait for 10 ns;
        data <= X"FF"; -- num3
        wait for 10 ns;
        data <= X"FF"; -- num4
        wait for 10 ns;
        data <= X"FF"; -- num5
        wait for 10 ns;
        data <= X"FF"; -- num6
        wait for 10 ns;
        data <= X"FF"; -- num7

        wait for 200 ns;
        assert false report "End Sim" severity failure;
    end process;

    top_UUT : top port map(
        clk => clk,
        reset_n => reset_n,
        start => start,
        data => data,
        ready => ready,
        average => average
    );

end simulation; 