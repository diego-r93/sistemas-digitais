library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplicador_4x1 is
  Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
         B : in  std_logic;
         S : out  STD_LOGIC_VECTOR (3 downto 0)
       );
end Multiplicador_4x1;

architecture Behavioral of Multiplicador_4x1 is

begin
S(0) <= B and A(0);
S(1) <= B and A(1);
S(2) <= B and A(2);
S(3) <= B and A(3);
end Behavioral;