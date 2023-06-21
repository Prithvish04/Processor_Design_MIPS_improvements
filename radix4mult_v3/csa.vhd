library ieee;
use ieee.std_logic_1164.all;
use work.mlite_pack.all;

entity csa is
   port(a : in std_logic_vector(32 downto 0);
		b : in std_logic_vector(32 downto 0);
		c_in : in std_logic_vector(32 downto 0);
		s : out std_logic_vector(32 downto 0);
		c_out : out std_logic_vector(32 downto 0)); --note that this carry is shifted (carry 0 is carry going from 0 to 1, carry 31 is carry going out
end csa; --carrysave adder

architecture behavioural of csa is
component fulladder is
port(a : in std_logic;
		b : in std_logic;
		cin : in std_logic;
		s : out std_logic;
		c : out std_logic);
end component;
   signal s1    : std_logic;
begin
	L1: for i IN 0 to 32 generate
        UU: fulladder PORT MAP(a => a(i), b => b(i),cin=>c_in(i), s=>s(i), c => c_out(i));
    end generate;
end behavioural; --architecture logic

