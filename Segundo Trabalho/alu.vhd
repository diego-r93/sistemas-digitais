library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
  port ( num1      : in std_logic_vector(15 downto 0);
         num2      : in std_logic_vector(15 downto 0);
         selection : in std_logic_vector(1 downto 0);
         result    : out std_logic_vector(15 downto 0)         
       );
end alu;

architecture Behavioral of alu is

  signal carry_mult  : std_logic_vector(3 downto 0);
  signal carry_adder : std_logic;

  signal result_sum  : STD_LOGIC_VECTOR (15 downto 0);
  signal result_mult : STD_LOGIC_VECTOR (15 downto 0);

  component TopAdder is
    port (
           in1   : in std_logic_vector(15 downto 0);               
           in2   : in std_logic_vector(15 downto 0);
           sum   : out std_logic_vector(15 downto 0);
           carry : out std_logic
         );
    end component;

  component TopMultiplier is
    port (
           in1   : in std_logic_vector(15 downto 0);
           in2   : in std_logic_vector(15 downto 0);
           mult  : out std_logic_vector(15 downto 0);
           carry : out std_logic_vector(3 downto 0)
         );
  end component;

begin

  SUM  : TopAdder port map (num1, num2, result_sum, carry_adder);           -- Salva os dois resultados nos
  MULT : TopMultiplier port map (num1, num2, result_mult, carry_mult);      -- sinais criados, dessa maneira
                                                                            -- foi mais fácil de implementar 
  ALU_Operation: process (num1, num2, selection)                            -- sem que ocorressem erros
  begin
    case selection is
      when '00' =>                     -- SOMA
      result <= result_sum;
      					
			when '01' =>                     -- MULTIPLICAÇÃO
			result <= result_mult;
									
			when others =>
			result <= "0000000000000000";    -- Para o programa não reclamar			
		end case;
  end process ALU_Operation;

end Behavioral;