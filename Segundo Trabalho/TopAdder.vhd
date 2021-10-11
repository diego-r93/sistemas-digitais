library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity TopAdder is
port (
       in1   : in std_logic_vector(15 downto 0);    -- input numbers (4 digits)
       in2   : in std_logic_vector(15 downto 0);
       sum   : out std_logic_vector(15 downto 0);   -- result (4 digits)
       carry : out std_logic
     );
end TopAdder;

architecture structural of TopAdder is

component bcd_adder is
    port (
           a, b      : in  unsigned(3 downto 0);   -- input numbers
           carry_in  : in std_logic;
           sum       : out  unsigned(3 downto 0);  -- result
           carry_out : out std_logic  
         );
end component;

signal carry1, carry2, carry3 : std_logic;
signal in1_s, in2_s, sum_s    : unsigned(15 downto 0);

begin
    
    in1_s <= unsigned(in1);          -- Conversão para inteiro para poder utilizar os recuros 
    in2_s <= unsigned(in2);          -- +, -, *, /
    sum <= std_logic_vector(sum_s);

    adder1: bcd_adder
    port map(in1_s(3 downto 0), in2_s(3 downto 0), '0', sum_s(3 downto 0), carry1);

    adder2: bcd_adder
    port map(in1_s(7 downto 4), in2_s(7 downto 4), carry1,sum_s(7 downto 4), carry2);

    adder3: bcd_adder
    port map(in1_s(11 downto 8), in2_s(11 downto 8), carry2,sum_s(11 downto 8), carry3);

    adder4: bcd_adder
    port map(in1_s(15 downto 12), in2_s(15 downto 12), carry3,sum_s(15 downto 12), carry);

end structural;