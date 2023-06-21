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



entity brentkung is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           carry_in : in std_logic;
           sum : out STD_LOGIC_VECTOR (31 downto 0);
           carry : out STD_LOGIC_VECTOR (31 downto 0));
           
end brentkung;

architecture Behavioral of brentkung is
    signal s2c :  std_logic_vector (31 downto  0);
    signal g_in,p_in,g_out, p_out   : STD_LOGIC_VECTOR (31 downto 0); 
    component CL_network PORT(  g_in, p_in : in  std_logic_vector (31 downto 0);
                                g_out, p_out : out std_logic_vector (31 downto 0)); 
                            end component;
    
    component  prefix_sum   port(g_in : in std_logic;
		                      p_in : in std_logic;
		                      carry_in : in std_logic;
		                      c_out : out std_logic;
		                      s_out : out std_logic);
                            end component; 
                            
     component ab2pg port(A : in std_logic;      
                          B : in std_logic;      
                          P : out std_logic;   
                          G : out std_logic);
                         end component;
                  

begin

    abpg: for i in 0 to 31 generate
        abpgall: ab2pg PORT MAP (A => A(i)  , B => B(i) , P => p_in(i)  , G  => g_in(i));
    end generate;
    
    cl: CL_network PORT MAP (g_in => g_in, p_in => p_in, g_out => g_out, p_out => p_out);
    sum(0) <= carry_in xor p_in(0);
    carry(0)<=carry_in;
    ps: for i IN 1 to 31 generate
        --psall: prefix_sum PORT MAP (g_in => g_out(i) , p_in => p_in(i) ,carry_in => carry_in, c_out => s2c(i), s_out => sum(i));
--        sum(0) <= carry_in xor p_in(0);
--        sum(1) <= p_in(1) xor (g_out(0) or (carry_in and p_out(0)));
--        sum(2) <= p_in(2) xor (g_out(1) or (carry_in and p_out(1)));
        carry(i)<=g_out(i-1) or (carry_in and p_out(i-1));
        sum(i) <= p_in(i) xor (g_out(i-1) or (carry_in and p_out(i-1)));
    end generate; 

   

end Behavioral;
