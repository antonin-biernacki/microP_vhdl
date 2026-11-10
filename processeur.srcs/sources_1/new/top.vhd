library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.pack.all;

entity top is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end top;

architecture Behavioral of top is

    signal ph : unsigned(2 downto 0) := (others => '0');
    signal en : STD_LOGIC;
    signal pc : STD_LOGIC_VECTOR(4 downto 0);
    signal trame : STD_LOGIC_VECTOR(20 downto 0);
    signal reg1 : STD_LOGIC_VECTOR(4 downto 0);
    signal reg2 : STD_LOGIC_VECTOR(4 downto 0);
    signal reg_rd : STD_LOGIC_VECTOR(4 downto 0);
    signal op_code : STD_LOGIC_VECTOR(4 downto 0);
    signal reg_wr : STD_LOGIC;
    signal ram_wr : STD_LOGIC;
    signal ram_rd : STD_LOGIC;
    signal param : STD_LOGIC;
    signal reg_wr_en : STD_LOGIC;
    signal ram_wr_en : STD_LOGIC;
    signal rs1 : STD_LOGIC_VECTOR(31 downto 0);
    signal rs2 : STD_LOGIC_VECTOR(31 downto 0);
    signal imm : STD_LOGIC_VECTOR(31 downto 0);
    signal s : STD_LOGIC_VECTOR(31 downto 0);
    signal result : STD_LOGIC_VECTOR(31 downto 0);
    signal ram_out : STD_LOGIC_VECTOR(31 downto 0);
    signal data : STD_LOGIC_VECTOR(31 downto 0);
    signal zero : STD_LOGIC;
    signal load : STD_LOGIC;

begin

    process (clk)
    begin
        if rising_edge(clk) then
            if ph = 4 then
                ph <= (others => '0');
            else
                ph <= ph + 1;
            end if;
        end if;
    end process;

    en <= '1' when ph = 4 else '0';
    reg_wr_en <= reg_wr and en;
    ram_wr_en <= ram_wr and en;
    imm <= "000000000000000000000000000" & reg2;
    data <= ram_out when ram_rd = '1' else result;
    load <= '1' when op_code = JMP_opcode or (op_code = BEQ_opcode and zero = '1') else '0';
    led <= rs1(15 downto 0);

    pc_inst : entity work.programme_counter
        port map (clk => clk, en => en, load => load, target => result(4 downto 0), pc => pc);

    rom_inst : entity work.rom
        port map (clk => clk, pointeur => pc, trame => trame);

    decodeur_inst : entity work.decodeur
        port map (clk => clk, trame => trame, reg1 => reg1, reg2 => reg2, reg_rd => reg_rd,
                  reg_wr => reg_wr, ram_wr => ram_wr, ram_rd => ram_rd, op_code => op_code, param => param);

    registres_inst : entity work.registres
        port map (clk => clk, addr_rs1 => reg1, addr_rs2 => reg2, addr_rd => reg_rd,
                  data => data, wr => reg_wr_en, rs1 => rs1, rs2 => rs2);

    multiplexer_inst : entity work.multiplexer
        port map (clk => clk, rs2 => rs2, imm => imm, choice => param, s => s);

    alu_inst : entity work.alu
        port map (rs1 => rs1, rs2 => s, op_code => op_code, result => result, zero => zero);

    ram_inst : entity work.ram
        port map (clk => clk, wr => ram_wr_en, rd => ram_rd, addr => result(4 downto 0),
                  data_in => rs1, data_out => ram_out);

end Behavioral;
