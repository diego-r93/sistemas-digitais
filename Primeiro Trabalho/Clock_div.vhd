library ieee;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity Clock_div is
port(
      clock_in  : in std_logic;
      max_count in : INTEGER;
      clock_out : out std_logic
    );
end Clock_div;
 
architecture Behavioral of Clock_div is

  signal count: INTEGER range 0 to max_count;
  signal clock_state: STD_LOGIC := '0';
  
begin
   
  gen_clock: process(clock_in, clock_state, count)
  begin
    if clock_in'event and clock_in ='1' then
      if count < max_count then 
        count <= count + 1;
      else
        clk_state <= not clk_state;
        count <= 0;
      end if;
    end if;
  end process;
               
  persecond: process (clk_state)
  begin
    clock_out <= clk_state;
  end process;
               
end Behavioral;