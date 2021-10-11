library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Machine_States is
  Port ( switch: in  std_logic_vector (3 downto 0);
         load_a : in std_logic;
         load_b : in std_logic;
         reset : in std_logic;
         leds : out  std_logic_vector (7 downto 0);
         clock : in std_logic
       );
end Machine_States;


architecture Behavioral of Machine_States is

  signal number_a : std_logic_vector (3 downto 0);
  signal number_b : std_logic_vector (3 downto 0);
  signal result : std_logic_vector (7 downto 0);
  signal sel : std_logic_vector (2 downto 0);
  signal state : std_logic_vector (1 downto 0) := "00"; 
  signal logic_state : bit := '0';
  signal counter: integer: = 0;


  component ALU is
    Port ( A : in std_logic_vector (3 downto 0);
           B : in std_logic_vector (3 downto 0);
           Selection : in std_logic_vector (2 downto 0);
           S : out  std_logic_vector (7 downto 0)
         );
  end component;


begin
  
  -- state = 00     Aguarda inserir o valor A
  -- state = 01     Aguarda inserir o valor B
  -- state = 10     Realiza a operação e mostra o resultado nos LED's
           
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
        if (load_a = '1') then
          number_a <= switch;
          state <= "01";
        end if; 
      when "01" =>
        if (load_b = '1') then
          number_b <= switch;
          state <= "10";
        end if;
      when "10" =>  
        sel(0) <= switch(0); 
        sel(1) <= switch(1);
        sel(2) <= switch(2);
        
      when others =>
        state <= "00"; 
    end case;     
  end process start_alu;  

  ALU_Call: ALU port map (number_a, number_b, sel, result);

	
  show_result: process(number_a, number_b, result, leds)
  begin
  -- incrementa o counter de clock na transicao
    if (clock'event and clock ='1') then
      counter <= counter + 1;
    end if;
      
    if (state ='10') then
      
        if (counter = 0) then
          leds (3 downto 0) <= number_a;    -- Mostra o número A
          leds (7 downto 4) <= "0010";    
        end if;
  --apos 2 seg
        if (counter = 100000000) then
          leds (3 downto 0) <= number_b;    -- Mostra o número B
          leds (7 downto 4) <= "0101";     
        end if;
  --apos 4 seg
        if (counter = 200000000) then
        leds (4 downto 0) <= result;        -- Mostra o resultado
        leds (7 downto 5) <= "100";       
        end if;
      
    elsif (state ='11') then
      leds (7 downto 0) <= "00000000";
    end if ;
      
    -- zera o counter de clock apos 6 seg(3x10⁸us)
    if (counter = 300000000)then
      counter<=0;
    end if;

end Behavioral;