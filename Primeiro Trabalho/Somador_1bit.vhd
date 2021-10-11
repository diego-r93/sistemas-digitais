library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Somador_1bit is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
	         cin : in STD_LOGIC;
           cout : out  STD_LOGIC;
           Sum : out  STD_LOGIC
         );
end Somador_1bit;

architecture Behavioral of Somador_1bit is  
begin
  cout <= (A and B) or (cin and (A xor B));		
	Sum <= A xor B xor cin;
end Behavioral;