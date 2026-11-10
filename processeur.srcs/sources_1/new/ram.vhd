----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2026 05:17:39 PM
-- Design Name: 
-- Module Name: ram - Behavioral
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

entity ram is
    Port ( clk : in STD_LOGIC;
           wr : in STD_LOGIC;
           rd : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR(4 downto 0);
           data_in : in STD_LOGIC_VECTOR(31 downto 0);
           data_out : out STD_LOGIC_VECTOR(31 downto 0));
end ram;

architecture Behavioral of ram is

    type tableau_32x32 is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal tableau_ram : tableau_32x32 := (others => (others => '0'));
    signal data_out_in : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin
    process(clk)
    begin
         if rising_edge(clk) then
             if wr = '1' then
                tableau_ram(TO_INTEGER(unsigned(addr))) <= data_in;
             elsif rd = '1' then
                data_out_in <= tableau_ram(TO_INTEGER(unsigned(addr)));
             end if;
         end if;
    end process;
    data_out <= data_out_in;

end Behavioral;
