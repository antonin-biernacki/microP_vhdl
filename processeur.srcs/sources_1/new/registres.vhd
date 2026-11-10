----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2025 05:12:40 PM
-- Design Name: 
-- Module Name: registres - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registres is
    Port ( clk : in STD_LOGIC;
           addr_rs1 : in STD_LOGIC_VECTOR (4 downto 0);
           addr_rs2 : in STD_LOGIC_VECTOR (4 downto 0);
           addr_rd : in STD_LOGIC_VECTOR (4 downto 0);
           data : in STD_LOGIC_VECTOR (31 downto 0);
           wr : in STD_LOGIC;
           rs1 : out STD_LOGIC_VECTOR (31 downto 0);
           rs2 : out STD_LOGIC_VECTOR (31 downto 0));
end registres;

architecture Behavioral of registres is
    
    type tableau_32x32 is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal tableau_regs : tableau_32x32 := (others => (others => '0'));
    signal rs1_in : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal rs2_in : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if wr = '1' then
                tableau_regs(TO_INTEGER(unsigned(addr_rd))) <= data;
            end if;
            rs1_in <= tableau_regs(TO_INTEGER(unsigned(addr_rs1)));
            rs2_in <= tableau_regs(TO_INTEGER(unsigned(addr_rs2)));
        end if;
    end process;
    
    rs1 <= rs1_in;
    rs2 <= rs2_in;
    
    


end Behavioral;
