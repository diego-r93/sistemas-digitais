library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplicador_4x4 is
  Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
         B : in  STD_LOGIC_VECTOR (3 downto 0);
         Mult : out  STD_LOGIC_VECTOR (4 downto 0)
       );
end Multiplicador_4x4;

architecture Behavioral of Multiplicador_4x4 is

component Multiplicador_4x1 is
  Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
         B : in  STD_LOGIC;
         S : out  STD_LOGIC_VECTOR (3 downto 0)
       );
end component;

component Somador_4bits is
  Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
         B : in  STD_LOGIC_VECTOR (3 downto 0);
         cin : in STD_LOGIC;
         cout : out  STD_LOGIC;
         Sum : out  STD_LOGIC_VECTOR (3 downto 0)
       );
end component;

signal X: STD_LOGIC_VECTOR (3 downto 0);
signal Y: STD_LOGIC_VECTOR (3 downto 0);
signal W: STD_LOGIC_VECTOR (3 downto 0);
signal Z: STD_LOGIC_VECTOR (3 downto 0);

signal P0: STD_LOGIC_VECTOR (3 downto 0);
signal P1: STD_LOGIC_VECTOR (3 downto 0);
signal P2: STD_LOGIC_VECTOR (3 downto 0);
signal P3: STD_LOGIC_VECTOR (3 downto 0);

signal inutil: STD_LOGIC;
signal inutil1: STD_LOGIC;
signal inutil2: STD_LOGIC;

signal primeirasoma: STD_LOGIC_VECTOR (4 downto 0);
signal segundasoma: STD_LOGIC_VECTOR (4 downto 0);
signal terceirasoma: STD_LOGIC_VECTOR (4 downto 0);
  
begin
d0: Multiplicador_4x1 port map (A,B(0),P0);
d1: Multiplicador_4x1 port map (A,B(1),P1);
d2: Multiplicador_4x1 port map (A,B(2),P2);
d3: Multiplicador_4x1 port map (A,B(3),P3);

X(3) <= '0';
X(2 downto 0) <= P0(3 downto 1);

Y<= P1;

W(3 downto 1) <= P2(2 downto 0);
W(0) <='0';

Z(3 downto 2) <= P3(1 downto 0);
Z(1 downto 0) <= "00";

s0: Somador_4bits port map (X,Y,'0',inutil,primeirasoma);
s1: Somador_4bits port map (primeirasoma(3 downto 0),W,'0',inutil1,segundasoma);
s2: Somador_4bits port map (segundasoma(3 downto 0) ,Z,'0',inutil2,terceirasoma);

Mult(4 downto 1) <= terceirasoma (3 downto 0);
Mult(0) <= P0(0);


end Behavioral;