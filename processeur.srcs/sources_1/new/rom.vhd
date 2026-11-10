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

library work;
use work.pack.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rom is
    Port ( clk : in STD_LOGIC;
           pointeur : in STD_LOGIC_VECTOR (4 downto 0);
           trame : out STD_LOGIC_VECTOR (20 downto 0));
end rom;

architecture Behavioral of rom is

    type tableau_32x21 is array (0 to 31) of STD_LOGIC_VECTOR(20 downto 0);
    signal tableau_rom : tableau_32x21 := (
        0 => '1' & "00001" & "00111" & "00000" & ADD_opcode,
        1 => '1' & "00010" & "00101" & "00000" & ADD_opcode,
        2 => '1' & "00000" & "00101" & "00010" & BEQ_opcode,
        3 => '1' & "00001" & "11111" & "00000" & ADD_opcode,
        4 => '1' & "00010" & "11111" & "00000" & ADD_opcode,
        5 => '0' & "00011" & "00010" & "00001" & ADD_opcode,
        6 => '0' & "00100" & "00010" & "00001" & SUB_opcode,
        7 => '0' & "00101" & "00010" & "00001" & AND_opcode,
        8 => '0' & "00110" & "00010" & "00001" & XOR_opcode,
        9 => '1' & "00000" & "00011" & "00011" & SW_opcode,
        10 => '1' & "00111" & "00011" & "00000" & LW_opcode,
        11 => '1' & "00000" & "01011" & "00111" & JMP_opcode,
        others => (others => '1'));

begin

   process (clk)
        begin
        if (rising_edge(clk)) then
            trame <= tableau_rom(to_integer(unsigned(pointeur)));
        end if;
    end process;


end Behavioral;
