----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2025 11:45:35 AM
-- Design Name: 
-- Module Name: programme_counter - Behavioral
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

entity programme_counter is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           load : in STD_LOGIC;
           target : in STD_LOGIC_VECTOR(4 downto 0);
           pc : out STD_LOGIC_VECTOR(4 downto 0));
end programme_counter;

architecture Behavioral of programme_counter is

    signal pc_in : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                if load = '1' then
                    pc_in <= target;
                else
                    pc_in <= STD_LOGIC_VECTOR(unsigned(pc_in) + 1);
                end if;
            end if;
        end if;
    end process;
    
    pc <= pc_in;

end Behavioral;
