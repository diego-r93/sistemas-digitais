library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
  Port ( A : in std_logic_vector (3 downto 0);
         B : in std_logic_vector (3 downto 0);
         Selection : in std_logic_vector (2 downto 0);
         S : out  std_logic_vector (5 downto 0)
       );
end ALU;

architecture Behavioral of ALU is

  signal carry : STD_LOGIC;
  signal borrow: STD_LOGIC; 
  
  signal result_sum: STD_LOGIC_VECTOR (3 downto 0);
  signal result_sub: STD_LOGIC_VECTOR (3 downto 0);
  signal result_mult: STD_LOGIC_VECTOR (4 downto 0);
   
  
  component Somador_4bits is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           cout : out  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (3 downto 0)
         );
  end component;

  component Subtrator_4bits is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           cout : out  std_logic;
           Sub : out  STD_LOGIC_VECTOR (3 downto 0)
         );
  end component Subtrator_4bits;

  component Multiplicador_4x4 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Mult : out  STD_LOGIC_VECTOR (4 downto 0)
         );
  end component Multiplicador_4x4;

begin

  SUM : Somador_4bits port map (A, B, '0', carry, result_sum);
  SUB : Subtrator_4bits port map (A, B, borrow, result_sub);
  MULT : Multiplicador_4x4 port map (A, B, result_mult);
  
	ALU_Operation: process (A, B, Selection)
  begin
   	case Selection is
      when "000" => -- SOMA
      S <= ("0" &(not result_sum));
      					
			when "001" => -- SUBTRAÇÂO
			S <= ("0" &(not result_sub));
			
			when "010" => -- MULTIPLICAÇÃO
			S <= result_mult;
			
			when "011" => -- NOT
			S <= ("0" &(not A));
			
			when "100" => -- AND
			S <= ("0" &(A and B));
			
			when "101" => -- OR
			S <= ("0" &(A or B));
			
			when "110" => -- XOR
			S <= ("0" &(A xor B));
			
			when "111" => -- NAND
			S <= ("0" &(A nand B));
			
			when others =>
			S <= "00000"; 			
		end case;
  end process ALU_Operation;
end Behavioral;
  
