-- HW1 Solution
-- By: Negin Safari 

----------------LIBRARY--------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
----------------ENTITY---------------------------
ENTITY controller IS
	PORT(
        clk:  IN STD_LOGIC;
        rst:  IN STD_LOGIC;
        start:  IN STD_LOGIC;

        outReg_init0: OUT std_logic;
        outReg_ld: OUT std_logic;

        ready: OUT std_logic);
END ENTITY;
------------ARCHITECTURE----------------------
ARCHITECTURE Behavorial OF controller IS

	TYPE state IS (idle, init, getd);
	SIGNAL p_state, n_state : state; 
	SIGNAL ce, co: STD_LOGIC;
    SIGNAL cnt : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN 


    PROCESS (clk, rst)
	BEGIN
		IF (rst='1') THEN
			cnt<= (OTHERS=>'0');
		ELSIF (clk = '1' AND clk'EVENT) THEN
			IF (ce = '1') THEN
				cnt <= cnt + 1;
			END IF;
		END IF;
	END PROCESS;
	
	co <= cnt(0) AND cnt(1) AND cnt(2);
	
	combinational_part:PROCESS(p_state, start, co)
					   BEGIN
					   ready <= '0'; outReg_init0 <= '0'; outReg_ld <= '0'; ce <= '0'; 
							CASE p_state IS
								WHEN idle =>
									IF start = '1' THEN n_state <= init; 
									ELSE n_state <= idle; END IF;
									ready <= '1';
									
								WHEN init =>
									IF start = '0' THEN n_state <= getd; 
									ELSE n_state <= init; END IF;
									outReg_init0 <= '1';
									
								WHEN getd =>
									IF co = '1' THEN n_state <= idle; 
									ELSE n_state <= getd; END IF;
									outReg_ld <= '1'; ce <= '1'; 

							END CASE;
						END PROCESS;
						
	sequential_part: PROCESS (clk, rst)
					BEGIN
					IF (rst = '1') THEN
						p_state <= idle;
					ELSIF (clk = '1' AND clk'EVENT) THEN
						 p_state <= n_state;
					END IF;
					END PROCESS;
									
END ARCHITECTURE;

