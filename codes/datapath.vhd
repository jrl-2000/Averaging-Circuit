-- HW1 Solution
-- By: Negin Safari 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is
    port (
        -- Inputs
        clk              : in std_logic;
        rst              : in std_logic;

        outReg_ld        : in std_logic;
        outReg_init0     : in std_logic;

        data    : in std_logic_vector(7 downto 0);

        -- Output
        average : out std_logic_vector(7 downto 0)
    );
end datapath;

architecture Behavorial of datapath is
    signal add_out, outReg_out: std_logic_vector (10 downto 0):= (others => '0');  
begin

    process(clk, rst)
    begin
      if (rst='1') then
        outReg_out<= (others=>'0');
      elsif( clk='1' and clk'event) then
        if(outReg_init0='1') then
            outReg_out<=(others=>'0');
        elsif (outReg_ld='1') then
            outReg_out<=add_out;
        end if;
      end if;  
    end process;

    average <= outReg_out(10 downto 3);

    process(data, outReg_out) begin
        add_out <= ("000" & data) + outReg_out;
    end process ;

end Behavorial; 