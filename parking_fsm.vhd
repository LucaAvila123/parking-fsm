
---------------- ROTATE FSM-------------------
--------- feito por Luiz (aplausos) ----------
----------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parking_fsm is
    Port ( 
        clk     : in std_logic;
        reset   : in std_logic; -- coisa padrao de FSM
        enable  : in std_logic;
        
        a      : in std_logic; -- 1 deixa a maquina rodar e 0 trava a maquina
        b     : in std_logic; -- 0 vai rodar no sentido anti-horario e 1 no sentido horario
        
        state_out : out std_logic_vector(8 downto 0);
        
        car_exit    : out std_logic; --selecionar o display
        car_entry      : out std_logic --os segmentos do display
    );
end parking_fsm;

architecture Behavioral of parking_fsm is

    -- todos os 8 estados do quadrado no display de 4 digitos    
    type sq_state is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
    signal state_reg, state_next : sq_state;    -- coisas de registrador

begin

   -- registrador
   process(clk, reset)
   begin
        -- flip-flop D (como de sempre) apenas em bordas de subida
      if (reset = '1') then
         --------IMPORTANTE----------
         state_reg <= s0; --<<< ESTADO INICIAL  estamos  comecando no s0
         
      elsif (clk'event and clk = '1') then
         -- o enable fica aqui
         if (enable='1') then
             state_reg <= state_next;
         end if;
         
      end if;
   end process;
   
   
   -- logica do proximo estado
   --(usando apenas as entradas)
   
      process(state_reg, a, b)
      begin
         case state_reg is
         
        ------------------------------------------
        -------------ESTADO S0 -------------------
        ------------------------------------------
           when s0 =>
               
               state_out <= "000000001";
               if a = '1' then            -- (en')
                     state_next <= s1;
                
                
               elsif b = '1' then         -- (en) AND (cw) 
                  state_next <= s4;
                  -- sentido horario (proximo)
               else                        -- (en) AND (cw')
                  state_next <= s0;
               end if;
                
        ------------------------------------------
        -------------ESTADO S1 -------------------
        ------------------------------------------
           when s1 =>
                          state_out <= "000000010";
               if a = '0' then            -- (en')
                     state_next <= s0;
             
               
               elsif b = '0' then         -- (en) AND (cw) 
                  state_next <= s1;
                  -- sentido horario (proximo)
               
               
               else                        -- (en) AND (cw')
                  state_next <= s2;
                  -- sentido anti-horario (anterior)
               end if;
               
            when s2 =>
                               state_out <= "000000100";
                if b = '0' then   -- (en')
                    state_next <= s1;
                    
                elsif a  = '1' then
                    state_next <= s2;
                    
                else
                    state_next <= s3;
                
                end if;
                
            when s3 =>
                                   state_out <= "000001000";
                if a = '1' then   -- (en')
                    state_next <= s2;
                    
                elsif b  = '1' then
                    state_next <= s3;
                    
                else
                    state_next <= s7;
                
               end if;
                    
            when s4 =>
                                                   state_out <= "000010000";
                if b = '0' then   -- (en')
                    state_next <= s0;
                    
                elsif a  = '0' then
                    state_next <= s4;
                    
                else
                    state_next <= s5;
                
                end if;
                        
            when s5 =>
                                                   state_out <= "000100000";
                if a = '0' then   -- (en')
                    state_next <= s4;
                    
                elsif b  = '1' then
                    state_next <= s5;
                    
                else
                    state_next <= s6;
                
                end if;
                            
            when s6 =>
                                                   state_out <= "001000000";
                if b = '1' then   -- (en')
                    state_next <= s5;
                    
                elsif a  = '1' then
                    state_next <= s6;
                    
                else
                    state_next <= s8;
                
                end if;
                                
            when s7 =>
                                                               state_out <= "010000000";
                    state_next <= s0;
            
            when s8 =>
                                                                           state_out <= "100000000";
                    state_next <= s0;
                     
                        --(PREGUICAAAAAAAA)
        ---------------------------------------------------------------------------------------
        -------------BASTA CONTINUAR ATE O ESTADO S7 (EH CHATO) (FOI MESMO) -------------------
        ---------------------------------------------------------------------------------------
        
        --SERA QUE DA PRA USAR UM FOR?? ATEH DA, MAS EU NÂO VOU FAZER ISSO
        --MELHOR AINDA SERA QUE DA TEMPO DE TENTAR FAZER COM UM FOR? NAUM< NAUM DAHHHHH

         end case;
      end process;
   
        -- logica de saida Moore (prque eu acho mais interessante nesse caso)
        
        
        -----PREENCHER ALI OS SEGMENTOS COM AQUILO QUE TEM QUE SEREM CADA ESTADO
      process(state_reg)
      begin
         case state_reg is
            when s0 =>
                car_exit <= '0';
                car_entry <= '0';
            when s1 =>
                car_exit <= '0';
                car_entry <= '0';
            when s2 =>
                car_exit <= '0';
                car_entry <= '0';
            when s3 =>
                car_exit <= '0';
                car_entry <= '0';
            when s4 =>
                car_exit <= '0';
                car_entry <= '0';
            when s5 =>
                car_exit <= '0';
                car_entry <= '0';
            when s6 =>
                car_exit <= '0';
                car_entry <= '0';  
            when s7 =>
                car_exit <= '0';
                car_entry <=   '1';
            when s8 =>
                car_exit <='1';
                car_entry <='0';                                                                             
         end case;
      end process;

end Behavioral;
