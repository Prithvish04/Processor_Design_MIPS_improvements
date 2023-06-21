library ieee;
use ieee.std_logic_1164.all;
use work.mlite_pack.all;

entity bubble is
   port(ga : in std_logic;
		pa : in std_logic;
		gb : in std_logic;
		pb : in std_logic;
		p_out : out std_logic;
		g_out : out std_logic);
end bubble; --prefix bubble calculator 

architecture behavbubble of bubble is
   signal s1    : std_logic;
begin
	s1 <= ga and pb;
	g_out <= gb or s1;
	p_out <= pa and pb;
end behavbubble; --architecture logic


