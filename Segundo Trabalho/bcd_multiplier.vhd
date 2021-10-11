library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity bcd_multiplier is
    Port ( a, b      : in  std_logic_vector(3 downto 0);       -- input numbers           
           result    : out  std_logic_vector (7 downto 0)              
         );
    end bcd_multiplier;

architecture Behavioral of bcd_multiplier is

    signal a_un : unsigned (3 downto 0);                       
    signal b_un : unsigned (3 downto 0);
    signal s_un : unsigned (7 downto 0);            -- Foi necessário para que não ocorresse erro ao       
    signal sum_temp : unsigned (7 downto 0);        -- tentar usar um sinal em mais de um processo
              
begin

    a_un <= unsigned (a);            -- Conversão para inteiro para poder utilizar os recuros 
    b_un <= unsigned (b);            -- +, -, *, /
    s_un <= (a_un * b_un);

    process (s_un)
    begin 
      
	    if (sum_temp > 9 and sum_temp < 20) then                -- 9 < n < 20    soma 6
	      sum_temp <= sum_temp + 6;
	    elsif (sum_temp > 19 and sum_temp < 30) then            -- 19 < n < 30    soma 12
	    sum_temp <= sum_temp + 12;	
	    elsif (sum_temp > 29 and sum_temp < 40) then            -- 29 < n < 40    soma 18
	      sum_temp <= sum_temp + 18;
	    elsif (sum_temp > 39 and sum_temp < 50) then            -- 39 < n < 50    soma 24
	      sum_temp <= sum_temp + 24;
	    elsif (sum_temp > 49 and sum_temp < 60) then            -- 49 < n < 60    soma 30
	      sum_temp <= sum_temp + 30;
	    elsif (sum_temp > 59 and sum_temp < 70) then            -- 59 < n < 70    soma 36
	      sum_temp <= sum_temp + 36;
	    elsif (sum_temp > 69 and sum_temp < 80) then            -- 69 < n < 80    soma 42
	      sum_temp <= sum_temp + 42;
	    elsif (sum_temp > 79 and sum_temp < 90) then            -- 79 < n < 90    soma 48
        sum_temp <= sum_temp + 48;
      else
        sum_temp <= s_un;                                     -- Se for < 9 o resultado é
      end if;                                                 -- o número sem correção
         
    end process; 
	
    result <= std_logic_vector(sum_temp);    

end Behavioral;