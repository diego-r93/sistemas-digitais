library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Subtrator_4bits is
  Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
         B : in  STD_LOGIC_VECTOR (3 downto 0);
         cout : out  std_logic;
         Sub : out  STD_LOGIC_VECTOR (3 downto 0)
       );
end Subtrator_4bits;

architecture Behavioral of Subtrator_4bits is

component Somador4bits is 
  Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
         B : in  STD_LOGIC_VECTOR (3 downto 0);
         cin: in STD_LOGIC; 
         cout : out  STD_LOGIC;
         Sum : out  STD_LOGIC_VECTOR (4 downto 0)
       );
end component;

signal borrow: STD_LOGIC; 
signal result: STD_LOGIC_VECTOR (3 downto 0);

begin
  Operation: Somador4bits port map (A, not(B),'1', borrow, result);
  Sub(3) <= result(3);
  Sub(2) <= result(2);
  Sub(1) <= result(1);
  Sub(0) <= result(0);
  cout <= borrow;
end Behavioral;