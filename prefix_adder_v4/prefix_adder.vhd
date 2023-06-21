----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2022 03:14:13 PM
-- Design Name: 
-- Module Name: brentkung - Behavioral
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



entity prefix_adder is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           carry_in : in std_logic;
           sum : out STD_LOGIC_VECTOR (31 downto 0);
           carry : out STD_LOGIC);
           
end prefix_adder;

architecture Behavioral of prefix_adder is
    signal s2c :  std_logic_vector (31 downto  0);
    signal g_in,p_in,g_out, p_out   : STD_LOGIC_VECTOR (32 downto 0); 
    component CL_network_HHC PORT(  g_in, p_in : in  std_logic_vector (31 downto 0);
                                g_out, p_out : out std_logic_vector (31 downto 0)); 
                            end component;
                            
     component ab2pg port(A : in std_logic;      
                          B : in std_logic;      
                          P : out std_logic;   
                          G : out std_logic);
                         end component;
                  
begin

    abpg: for i in 0 to 31 generate
        abpgall: ab2pg PORT MAP (A => A(i)  , B => B(i) , P => p_in(i+1)  , G  => g_in(i+1));
    end generate;
    g_in(0) <= carry_in;
    p_in(0) <= '0';
    cl: CL_network_HHC PORT MAP (g_in => g_in(31 downto 0), p_in => p_in(31 downto 0), g_out => g_out(31 downto 0), p_out => p_out(31 downto 0));
    g_out(32) <= g_in(32);
    p_out(32) <= p_in(32);
    --ps: for i IN 0 to 31 generate
    --    psall: prefix_sum PORT MAP (g_in => g_out(i) , p_in => p_in(i) ,carry_in => carry_in, c_out => s2c(i), s_out => sum(i));
    --end generate;
    sum(31 downto 0) <= g_out(31 downto 0) XOR p_in(32 downto 1);
    
    carry <= g_in(32) OR (p_in(32) AND g_out(31));
 
--    sum  <= g_out xor p_in;
--    carry <= g_out;

end Behavioral;
