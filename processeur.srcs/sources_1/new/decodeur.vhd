----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2026 05:43:00 PM
-- Design Name: 
-- Module Name: decodeur - Behavioral
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

library work;
use work.pack.all;

entity decodeur is
    Port ( clk : in STD_LOGIC;
	       trame : in STD_LOGIC_VECTOR (20 downto 0);
           reg1 : out STD_LOGIC_VECTOR (4 downto 0);
           reg2 : out STD_LOGIC_VECTOR (4 downto 0);
           reg_rd : out STD_LOGIC_VECTOR (4 downto 0);
           reg_wr : out STD_LOGIC;
           ram_wr : out STD_LOGIC;
           ram_rd : out STD_LOGIC;
           op_code : out STD_LOGIC_VECTOR (4 downto 0);
           param : out STD_LOGIC);
end decodeur;

architecture Behavioral of decodeur is

    signal op_code_in : STD_LOGIC_VECTOR (4 downto 0);
    signal reg1_in : STD_LOGIC_VECTOR (4 downto 0);
    signal reg2_in : STD_LOGIC_VECTOR (4 downto 0);
    signal reg_rd_in : STD_LOGIC_VECTOR (4 downto 0);
    signal param_in : STD_LOGIC;

begin
    
    op_code_in <= trame(4 downto 0);
    reg1_in <= trame(9 downto 5);
    reg2_in <= trame(14 downto 10);
    reg_rd_in  <= trame(19 downto 15);
    param_in <= trame(20);
    
    process (clk)
        begin
            if rising_edge(clk) then
                case op_code_in is
                    when ADD_opcode => 
                        reg_wr <= '1';
                        ram_rd <= '0';
                        ram_wr <= '0';
                    when SUB_opcode => 
                        reg_wr <= '1';
                        ram_rd <= '0';
                        ram_wr <= '0';
                    when AND_opcode => 
                        reg_wr <= '1';
                        ram_rd <= '0';
                        ram_wr <= '0';
                    when XOR_opcode => 
                        reg_wr <= '1';
                        ram_rd <= '0';
                        ram_wr <= '0';
                    when LW_opcode =>    
                        reg_wr <= '1';
                        ram_rd <= '1';
                        ram_wr <= '0';
                    when SW_opcode =>  
                        reg_wr <= '0';
                        ram_rd <= '0';
                        ram_wr <= '1';
                    when others => 
                        reg_wr <= '0';
                        ram_rd <= '0';
                        ram_wr <= '0';
                    end case;
              end if;
        end process;

     op_code <= op_code_in;
     reg1 <= reg1_in;
     reg2 <= reg2_in;
     reg_rd <= reg_rd_in;
     param <= param_in;

end Behavioral;
