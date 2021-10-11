library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity TopMultiplier is
  port (
         in1   : in std_logic_vector(15 downto 0);    -- input numbers (4 digits)
         in2   : in std_logic_vector(15 downto 0);
         mult  : out std_logic_vector(15 downto 0);   -- result (4 digits)
         carry : out std_logic_vector(3 downto 0)
       );
end TopMultiplier;

architecture structural of TopMultiplier is

component bcd_multiplier is
  port ( 
         a, b      : in  std_logic_vector(3 downto 0);       
         result    : out  std_logic_vector (7 downto 0)  
       );
end component;

component TopAdder is
  port (
         in1   : in std_logic_vector(15 downto 0);   
         in2   : in std_logic_vector(15 downto 0);
         sum   : out std_logic_vector(15 downto 0); 
         carry : out std_logic
       );
end component;

  signal carry1, carry2, carry3 : std_logic;
  signal in1_s, in2_s   : std_logic_vector(15 downto 0);
  signal mult1, mult2, mult3, mult4 : std_logic_vector(7 downto 0);
  signal soma1, soma2 : std_logic_vector(15 downto 0);
  signal mult1_C15, mult2_C15, mult3_C15, mult4_C15 : std_logic_vector(15 downto 0);

begin

  in1_s <= in1;
  in2_s <= in2;
  
  mult1_C15 <= "00000000" &(mult1);              -- Concatena com 8 bits para poder utlizar na soma de
  mult2_C15 <= "00000000" &(mult2);              -- até 15 bits
  mult3_C15 <= "00000000" &(mult3);              -- As multiplicações são entre dois inteiros (BCD 4 digitos)
  mult4_C15 <= "00000000" &(mult4);              -- Logo os resultados terão no máximo 8 bits
                                                 -- Exemplo: 9(1001) X 9(1001) = 10000001
                                                 
  
  mult_dig1: bcd_multiplier
  port map(in1_s(3 downto 0), in2_s(3 downto 0), mult1);

  mult_dig2: bcd_multiplier
  port map(in1_s(7 downto 4), in2_s(7 downto 4), mult2);

  mult_dig3: bcd_multiplier
  port map(in1_s(11 downto 8), in2_s(11 downto 8), mult3);

  mult_dig4: bcd_multiplier
  port map(in1_s(15 downto 12), in2_s(15 downto 12), mult4);
  
  sum1: TopAdder
  port map(mult1_C15, mult2_C15, soma1, carry1);                -- Soma os resultados das multiplicações
                                                                -- utilizando o módulo somador de 15 bits       
  sum2: TopAdder                                                -- dessa maneira o próprio módulo trata o 
  port map(mult3_C15, mult4_C15, soma2, carry2);                -- resultado das somas
  
  sum3: TopAdder
  port map(soma1, soma2, mult, carry3);

end structural;