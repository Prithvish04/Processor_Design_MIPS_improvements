----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/08/2022 04:57:23 PM
-- Design Name: 
-- Module Name: multtestbench - Behavioral
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
use work.mlite_pack.all;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multtestbench is
--  Port ( );
end multtestbench;

architecture Behavioral of multtestbench is
component mult is
port(clk       : in std_logic;
        reset_in  : in std_logic;
        a, b      : in std_logic_vector(31 downto 0);
        mult_func : in mult_function_type;
        c_mult    : out std_logic_vector(31 downto 0);
        pause_out : out std_logic);
end component; --entity mult

signal a,b : std_logic_vector(31 downto 0);
signal clk, reset,pause : std_logic;
signal sum :  std_logic_vector(31 downto 0);
signal carry :  std_logic;
signal mult_func : mult_function_type;

begin

uut : mult port map(
clk =>clk,
reset_in=>reset,
a =>a,
b =>b,
mult_func => mult_func,
c_mult =>sum,
pause_out => pause);

reset <= '1', '0' after 10 ns, '1' after 400 ns, '0' after 420 ns;

process begin
clk <= '1'; wait for 5 ns; -- clk high for T1 ns
clk <= '0'; wait for 5 ns; -- clk low for T2 ns
end process;
mult_func<=MULT_SIGNED_MULT after 21 ns, MULT_NOTHING after 40 ns, MULT_SIGNED_MULT after 400 ns;

a <= std_logic_vector(to_signed(-50, 32)) after 20 ns, std_logic_vector(to_signed(-475, 32)) after 400 ns;
b <= std_logic_vector(to_signed(23, 32)) after 20 ns, std_logic_vector(to_signed(475, 32)) after 400 ns;

--cin <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns, '0' after 80 ns, '1' after 100 ns,
--       '0' after 120 ns, '1' after 140 ns;

end Behavioral;
