----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2025 05:17:31 PM
-- Design Name: 
-- Module Name: multiplexer - Behavioral
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

entity multiplexer is
    Port ( clk : in STD_LOGIC;
           rs2 : in STD_LOGIC_VECTOR (31 downto 0);
           imm : in STD_LOGIC_VECTOR (31 downto 0);
           choice : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (31 downto 0));
end multiplexer;

architecture Behavioral of multiplexer is

    signal s_in : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin
    process (clk)
    begin
        if rising_edge(clk) then
            case choice is
                when '0' =>
                    s_in <= rs2;
                when others =>
                    s_in <= imm;
            end case;
        end if;
    end process;
    s <= s_in;


end Behavioral;
