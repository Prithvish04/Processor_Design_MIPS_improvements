----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2022 12:24:12
-- Design Name: 
-- Module Name: CL_network - Behavioral
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

entity CL_network_BC is
    Port ( g_in : in STD_LOGIC_VECTOR (31 downto 0);
           p_in : in STD_LOGIC_VECTOR (31 downto 0);
           g_out : out STD_LOGIC_VECTOR (31 downto 0);
           p_out : out STD_LOGIC_VECTOR (31 downto 0));
end CL_network_BC;

architecture Behavioral of CL_network_BC is
    signal g1, p1, g2, p2, g3, p3, g4, p4, g5, p5, g6, p6, g7, p7    : STD_LOGIC_VECTOR (31 downto 0);
    component bubble PORT( ga, pa, gb, pb : in  STD_LOGIC;
                            g_out, p_out : out STD_LOGIC); end component;
begin
    L1: for i IN 0 to 15 generate
        L11to16: bubble PORT MAP(ga => g_in(2*i), pa => p_in(2*i), gb => g_in(2*i+1), pb => p_in(2*i+1), g_out => g1(2*i+1), p_out => p1(2*i+1));
        g1(2*i) <= g_in(2*i);
        p1(2*i) <= p_in(2*i);
    end generate;
    
    L2: for i IN 0 to 7 generate
        L11to16: bubble PORT MAP(ga => g1(4*i+1), pa => p1(4*i+1), gb => g1(4*i+3), pb => p1(4*i+3), g_out => g2(4*i+3), p_out => p2(4*i+3));
        g2(4*i) <= g1(4*i);
        g2(4*i+1) <= g1(4*i+1);
        g2(4*i+2) <= g1(4*i+2);
        p2(4*i) <= p1(4*i);
        p2(4*i+1) <= p1(4*i+1);
        p2(4*i+2) <= p1(4*i+2);
    end generate;
    
    L3: for i IN 0 to 3 generate
        L11to16: bubble PORT MAP(ga => g2(8*i+3), pa => p2(8*i+3), gb => g2(8*i+7), pb => p2(8*i+7), g_out => g3(8*i+7), p_out => p3(8*i+7));
        g3(8*i+6 downto 8*i) <= g2(8*i+6 downto 8*i);
        p3(8*i+6 downto 8*i) <= p2(8*i+6 downto 8*i);
    end generate;
    
    L4: for i IN 0 to 1 generate
        L11to16: bubble PORT MAP(ga => g3(16*i+7), pa => p3(16*i+7), gb => g3(16*i+15), pb => p3(16*i+15), g_out => g4(16*i+15), p_out => p4(16*i+15));
        g4(16*i+14 downto 16*i) <= g3(16*i+14 downto 16*i);
        p4(16*i+14 downto 16*i) <= p3(16*i+14 downto 16*i);
    end generate;
    
    L51: bubble PORT MAP(ga => g4(15), pa => p4(15), gb => g4(31), pb => p4(31), g_out => g5(31), p_out => p5(31));
    L52: bubble PORT MAP(ga => g4(15), pa => p4(15), gb => g4(23), pb => p4(23), g_out => g5(23), p_out => p5(23));
    g5(30 downto 24) <= g4(30 downto 24);
    p5(30 downto 24) <= p4(30 downto 24);
    g5(22 downto 0) <= g4(22 downto 0);
    p5(22 downto 0) <= p4(22 downto 0);
    
    L6: for i IN 0 to 2 generate
        L11to16: bubble PORT MAP(ga => g5(i*8+7), pa => p5(i*8+7), gb => g5(i*8+11), pb => p5(i*8+11), g_out => g6(i*8+11), p_out => p6(i*8+11));
        g6(8*i+10 downto 8*i+4) <= g5(8*i+10 downto 8*i+4);
        p6(8*i+10 downto 8*i+4) <= p5(8*i+10 downto 8*i+4);
    end generate;
    g6(3 downto 0) <= g5(3 downto 0);
    p6(3 downto 0) <= p5(3 downto 0);
    g6(31 downto 28) <= g5(31 downto 28);
    p6(31 downto 28) <= p5(31 downto 28);
    
    L7: for i IN 0 to 6 generate
        L11to16: bubble PORT MAP(ga => g6(i*4+3), pa => p6(i*4+3), gb => g6(i*4+5), pb => p6(i*4+5), g_out => g7(i*4+5), p_out => p7(i*4+5));
        g7(4*i+4 downto 4*i+2) <= g6(4*i+4 downto 4*i+2);
        p7(4*i+4 downto 4*i+2) <= p6(4*i+4 downto 4*i+2);
    end generate;
    g7(1 downto 0) <= g6(1 downto 0);
    p7(1 downto 0) <= p6(1 downto 0);
    g7(31 downto 30) <= g6(31 downto 30);
    p7(31 downto 30) <= p6(31 downto 30);
    
   L8: for i IN 0 to 14 generate
        L11to16: bubble PORT MAP(ga => g7(i*2+1), pa => p7(i*2+1), gb => g7(i*2+2), pb => p7(i*2+2), g_out => g_out(i*2+2), p_out => p_out(i*2+2));
        g_out(2*i+1) <= g7(2*i+1);
        p_out(2*i+1) <= p7(2*i+1);
    end generate;
    g_out(0) <= g7(0);
    p_out(0) <= p7(0);
    g_out(31) <= g7(31);
    p_out(31) <= p7(31);
    
end Behavioral;
