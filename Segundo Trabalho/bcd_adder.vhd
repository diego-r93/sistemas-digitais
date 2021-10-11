library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_adder is
    port (
            a, b      : in unsigned(3 downto 0);      -- input numbers
            carry_in  : in std_logic;
            sum       : out unsigned(3 downto 0);     -- result
            carry_out : out std_logic  
         );
end bcd_adder;

architecture arch of bcd_adder is

begin

process(a, b, carry_in)
variable sum_temp : unsigned(4 downto 0);
begin                                                           -- Os números a e b foram concatenados com
    sum_temp := ('0' & a) + ('0' & b) + ("0000" & carry_in);    -- um dígito para que o resultado pudesse
    if(sum_temp > 9) then                                       -- expresso com 5 dígitos, sendo o quinto
        carry_out <= '1';          -- +6                        -- utilizado como carry_out
        sum <= resize((sum_temp + "00110"), 4);          -- resize foi utilizado para que o resultado        
    else                                                 -- voltasse a ter 4 dígitos
        carry_out <= '0';
        sum <= sum_temp(3 downto 0);
    end if; 
end process;   

end arch;