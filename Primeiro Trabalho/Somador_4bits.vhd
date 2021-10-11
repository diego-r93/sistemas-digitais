library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Somador_4bits is
  Port ( A : in  std_logic_vector (3 downto 0);
         B : in  std_logic_vector (3 downto 0);
         cin : in std_logic;
         cout : out  std_logic;
         Sum : out  std_logic_vector (3 downto 0)
       );
end Somador_4bits;

architecture Behavioral of Somador_4bits is

signal carry : std_logic_vector (3 downto 0);

component Somador_1bit is
Port ( A : in std_logic;
       B : in std_logic;
       cin : in  std_logic;
       cout : out std_logic; 
       Sum : out  std_logic
      );
end component;

begin
  bit0: somador_1bit port map (A(0), B(0), cin, carry(0), Sum(0));            -- Vetor da Soma
  bit1: somador_1bit port map (A(1), B(1), carry(0), carry(1), Sum(1));
  bit2: somador_1bit port map (A(2), B(2), carry(1), carry(2), Sum(2));
  bit3: somador_1bit port map (A(3), B(3), carry(2), carry(3), Sum(3));
  cout <= carry(3);
end Behavioral;