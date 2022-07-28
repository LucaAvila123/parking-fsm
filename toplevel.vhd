----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 09:11:24 AM
-- Design Name: 
-- Module Name: toplevel - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
    Port ( 
        led : out std_logic_vector(15 downto 0);
        clk  : in std_logic;
        sw   : in std_logic_vector(1 downto 0)
    );
end toplevel;

architecture Behavioral of toplevel is

constant N : integer := 199999999; 
signal enable : std_logic;
signal divide_clk : integer range 0 to N;
signal counter:  std_logic_vector(2 downto 0);

begin
    fsm_park : entity work.parking_fsm(Behavioral)
          port map(
                    clk      => clk,
                    reset    => '0',
                    b   => sw(0),
                    a   => sw(1),  --esse aqui é diferente de enable
                    enable => enable,
                    car_exit => led(0),
                    car_entry => led(1),
                    
                    state_out => led(15 downto 7)
          );
        
     enable <= '1' when divide_clk = N else '0';
     
     PROCESS (clk)
        BEGIN
            IF (clk'EVENT AND clk='1') THEN
                divide_clk <= divide_clk+1;
                IF divide_clk = N THEN
                    divide_clk <= 0;
                END IF;
            END IF;
     END PROCESS;
     
end Behavioral;
