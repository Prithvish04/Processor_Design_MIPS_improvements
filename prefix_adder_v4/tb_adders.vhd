library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end entity;

architecture behav of adder_tb is
component brentkung is
port(
A, B : in std_logic_vector(31 downto 0);
carry_in : in std_logic;
sum : out std_logic_vector(31 downto 0);
carry : out std_logic_vector(31 downto 0));
end component;

signal a,b : std_logic_vector(31 downto 0);
signal cin : std_logic;
signal sum :  std_logic_vector(31 downto 0);
signal carry :  std_logic_vector(31 downto 0);
signal sreal :  std_logic_vector(31 downto 0);

begin

uut : brentkung port map(
A =>a,
B =>b,
carry_in => cin,
sum =>sum,
carry => carry);
--a <= (others => '0');
--b <= (others => '0');
a <= std_logic_vector(to_unsigned(-450, 32)) after 40 ns; 
b <= std_logic_vector(to_unsigned(147, 32)) after 40 ns;
cin  <= '0';
sreal <= sum(31 downto 0);
--cin <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns, '0' after 80 ns, '1' after 100 ns,
--       '0' after 120 ns, '1' after 140 ns;

end behav;
 
 
