----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2022 11:21:01 AM
-- Design Name: 
-- Module Name: 32bitadder - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topadder is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           do_add : in std_logic;
           result : out STD_LOGIC_VECTOR (32 downto 0));
end topadder;

architecture Behavioral of topadder is

signal sum_out, bb : STD_LOGIC_VECTOR (31 downto 0);
signal carry_in, carry : std_logic;

component prefix_adder is
port(
A, B : in std_logic_vector(31 downto 0);
carry_in : in std_logic;
sum : out std_logic_vector(31 downto 0);
carry : out std_logic);
end component;

begin
    bb <= b when (do_add='1') else
        (not b);
    carry_in <= '0' when (do_add='1') else
        '1';  
    uut : prefix_adder port map(
            A =>a,
            B =>bb,
            carry_in => carry_in,
            sum => result(31 downto 0),
            carry => carry);
    result(32) <= carry xnor do_add;

end Behavioral;
