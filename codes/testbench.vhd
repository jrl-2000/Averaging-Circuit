-- HW1 Solution
-- By: Negin Safari 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
end testbench;

architecture simulation of testbench is
    signal clk, start, ready : std_logic := '0';
    signal rst : std_logic := '0';
    signal data : std_logic_vector(7 downto 0) := "00000000";
    signal average : std_logic_vector(7 downto 0);

    -- UUT
    component top is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
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
        rst <= '0';
        wait for 5 ns;
        rst <= '1';
        wait for 5 ns;
        rst <= '0';
        wait for 5 ns;

        wait for 4 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 1 ns;

        data <= X"01"; -- num0
        wait for 10 ns;
        data <= X"02"; -- num1
        wait for 10 ns;
        data <= X"03"; -- num2
        wait for 10 ns;
        data <= X"04"; -- num3
        wait for 10 ns;
        data <= X"05"; -- num4
        wait for 10 ns;
        data <= X"06"; -- num5
        wait for 10 ns;
        data <= X"07"; -- num6
        wait for 10 ns;
        data <= X"08"; -- num7

        wait for 200 ns;
        assert false report "End Sim" severity failure;
    end process;

    top_UUT : top port map(
        clk => clk,
        rst => rst,
        start => start,
        data => data,
        ready => ready,
        average => average
    );

end simulation; 