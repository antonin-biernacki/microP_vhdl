----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2025 02:05:57 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           rs2 : in STD_LOGIC_VECTOR (31 downto 0);
           op_code : in STD_LOGIC_VECTOR (4 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end alu;

architecture Behavioral of alu is
    signal a, b, c : STD_LOGIC_VECTOR(31 downto 0);
    
begin
    a <= rs1;
    b <= rs2;
    process (a, b, op_code)
    begin
        case op_code is
            when ADD_opcode =>
                c <= STD_LOGIC_VECTOR(signed(a) + signed(b));
            when SUB_opcode =>
                c <= STD_LOGIC_VECTOR(signed(a) - signed(b));
            when AND_opcode =>
                c <= a and b;
            when XOR_opcode =>
                c <= a xor b;
            when LW_opcode =>
                c <= STD_LOGIC_VECTOR(unsigned(a) + unsigned(b));
            when SW_opcode =>
                c <= b;
            when JMP_opcode =>
                c <= rs2;
            when others =>
                c <= b;
        end case;
    end process;
    
    result <= c;
    zero <= '1' when a = b else '0';

end Behavioral;
