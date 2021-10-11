library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
  Port ( switch: in  std_logic;        -- Chave para a ALU
         reset : in std_logic;         -- Botão para resetar a máquina de estados
         clock : in std_logic          -- Clock da placa
       );
end main;


architecture Behavioral of main is

  signal number_a : std_logic_vector (15 downto 0);          -- Para salvar temporarioamente as entradas e
  signal number_b : std_logic_vector (15 downto 0);          -- resultados
  signal result : std_logic_vector (15 downto 0);
  signal sel : std_logic_vector (1 downto 0);                -- Será necessário concatenar com '0' (switch)
  signal state : std_logic_vector (1 downto 0) := "00";      -- Inicializa o estado em "00"
  signal counter: integer: = 0;

  component alu is                                            -- Componente ALU
    port ( num1      : in std_logic_vector(15 downto 0);
           num2      : in std_logic_vector(15 downto 0);
           selection : in std_logic_vector(1 downto 0);
           result    : out std_logic_vector(15 downto 0)         
         );
  end component;

  component lcd is                                            -- Componente LCD
    Port ( 	NUMERO: in std_logic_vector(3 downto 0);
				    BOTAO: in std_logic;
				    LED: out std_logic;
				    LCD_DB: out std_logic_vector(7 downto 0);		--DB( 7 through 0)
            RS:out std_logic;  				--WE
            RW:out std_logic;				--ADR(0)
	          CLK:in std_logic;				--GCLK2
	          --ADR1:out std_logic;				--ADR(1)
	          --ADR2:out std_logic;				--ADR(2)
	          --CS:out std_logic;				--CSC
	          OE:out std_logic;				--OE
	          rst:in std_logic		);		--BTN
	          --rdone: out std_logic);			--WriteDone output to work with DI05 test
  end component;

  component fifo is                                          -- Componente buffer para o teclado
    generic (
              B: natural:=8; -- number of bits
              W: natural:=4 -- number of address bits
            );
    port (
           clk, reset: in std_logic;
           rd, wr: in std_logic;
           w_data: in std_logic_vector (B-1 downto 0);
           empty, full: out std_logic;
           r_data: out std_logic_vector (B-1 downto 0)
         );
  end component;

begin
  
  -- state = 00     Aguarda inserir o valor A
  -- state = 01     Aguarda inserir o valor B
  -- state = 10     Realiza a operação e mostra o resultado no display
           
  reset_alu : process (reset, state)
  begin

    if (reset = '0') then
      state <= "00";
    end if;

  end process reset_alu;

  start_alu: process(switch, sel, state, number_a, number_b, load_a, load_b)
  begin
    
    case state is
      when "00" => 
        if () then
          number_a <= ;
          state <= "01";
        end if; 
      when "01" =>
        if () then
          number_b <= ;
          state <= "10";
        end if;
      when "10" =>  
        
        
      when others =>
        state <= "00"; 
    end case;     
  end process start_alu;  

  ALU_Call: ALU port map (number_a, number_b, sel, result);
	
  

end Behavioral;