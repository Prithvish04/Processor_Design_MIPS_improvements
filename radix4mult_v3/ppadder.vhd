----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.06.2022 16:06:54
-- Design Name: 
-- Module Name: partialproductadder - Behavioral
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
use work.mlite_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ppadder is
    Port ( clk       : in std_logic;
           reset_in  : in std_logic;
           sign_reg : in std_logic;
           upper_pp : in STD_LOGIC_VECTOR (31 downto 0);
           lower_pp : in STD_LOGIC_VECTOR (1 downto 0);
           a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (1 downto 0);
           pp_new : out STD_LOGIC_VECTOR (33 downto 0));
end ppadder;

architecture Behavioral of ppadder is
component csa is
   port(a : in std_logic_vector(32 downto 0);
		b : in std_logic_vector(32 downto 0);
		c_in : in std_logic_vector(32 downto 0);
		s : out std_logic_vector(32 downto 0);
		c_out : out std_logic_vector(32 downto 0)); --note that this carry is shifted (carry 0 is carry going from 0 to 1, carry 31 is carry going out
end component;

component fulladder is
   port(a : in std_logic;
		b : in std_logic;
		cin : in std_logic;
		s : out std_logic;
		c : out std_logic);
end component;

signal a2_mux, a_mux, s1, s2, c1, c1_shifted, c2, lower_csa_pp, upper_csa_pp   :std_logic_vector(32 downto 0);
signal c2_shifted, s1_adder   :std_logic_vector(32 downto 0);
signal tba_carry    :std_logic_vector(2 downto 0);
begin

lower_csa_pp <= upper_pp(31) & upper_pp(31 downto 0) when (sign_reg = '1') else '0' & upper_pp(31 downto 0);
--upper_csa_pp <= (upper_pp(31 downto 30) & (31 downto 0 => '0'));
upper_csa_pp <= (32 downto 0 => upper_pp(31));

a2_mux <= a & '0'               when (b(1) = '1') else 
          ( others => '0');
a_mux <= a(31) & a              when (b(0) = '1' and sign_reg = '1') else 
         '0' & a                when (b(0) = '1' and sign_reg = '0') else 
         ( others => '0');
CSA1: csa PORT MAP( a => lower_csa_pp, 
                    b => a2_mux, 
                    c_in => a_mux, 
                    s => s1, 
                    c_out => c1);
c1_shifted <= c1(31 downto 0) & '0';
--CSA2: csa PORT MAP( a => upper_csa_pp, 
--                    b => s1, 
--                    c_in => c1_shifted, 
--                    s => s2, 
--                    c_out => c2);
--c2_shifted <= c2(32 downto 0) & '0';
FA: topadder PORT MAP(a => s1(32 downto 1), b => c1_shifted(32 downto 1), do_add => '1', result => pp_new(33 downto 1));
pp_new(0)<= s1(0);
--twobitadder1: fulladder PORT MAP(a => c2_shifted(0), b => s2(0), cin => tba_carry(2), s => pp_new(0), c => tba_carry(0));

--twobitadder2: fulladder PORT MAP(a => c2_shifted(1), b => s2(1), cin => tba_carry(0), s => pp_new(1), c => tba_carry(1));
--   FF: process(clk, reset_in, tba_carry)
--   begin
--        if reset_in = '1' then
--            tba_carry(2) <= '0';
--        elsif rising_edge(clk) then
--            tba_carry(2) <= tba_carry(1);
--        end if;
--   end process;

end Behavioral;
