----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2022 04:08:51 PM
-- Design Name: 
-- Module Name: ab2pg - Behavioral
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


entity ab2pg is
    port(A : in std_logic;      -- AND gate input
         B : in std_logic;      -- AND gate input
         P : out std_logic;    -- AND gate 
         G : out std_logic);
end ab2pg;

architecture Behavioral of ab2pg is

begin
    
    P <= A xor B;
    G <= A and B;
end Behavioral;
