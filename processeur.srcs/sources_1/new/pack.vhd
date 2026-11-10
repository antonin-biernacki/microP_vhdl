library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pack is 
    constant ADD_opcode : STD_LOGIC_VECTOR := "00000";
    constant SUB_opcode : STD_LOGIC_VECTOR := "00001";
    constant AND_opcode : STD_LOGIC_VECTOR := "00010";
    constant XOR_opcode : STD_LOGIC_VECTOR := "00011";
    constant LW_opcode : STD_LOGIC_VECTOR := "00100";
    constant SW_opcode : STD_LOGIC_VECTOR := "00101";
    constant JMP_opcode : STD_LOGIC_VECTOR := "00110";
    constant BEQ_opcode : STD_LOGIC_VECTOR := "00111";
end package pack;
