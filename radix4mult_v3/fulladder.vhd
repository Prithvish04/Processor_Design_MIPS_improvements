library ieee;
use ieee.std_logic_1164.all;
use work.mlite_pack.all;

entity fulladder is
   port(a : in std_logic;
		b : in std_logic;
		cin : in std_logic;
		s : out std_logic;
		c : out std_logic);
end fulladder; --fulladder

architecture behavioural of fulladder is
   signal axorb    : std_logic;
begin
	axorb <= a xor b;
	s <= axorb xor cin;
	c <= (a and b) or (axorb and cin);
end behavioural; --architecture logic


