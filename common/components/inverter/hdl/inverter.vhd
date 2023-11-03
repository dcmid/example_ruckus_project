library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity inverter is
  port (
    i : in    std_logic;
    o : out   std_logic;

    i_clk : in    std_logic;
    i_rst : in    std_logic
  );
end entity inverter;

architecture rtl of inverter is

begin

  proc_logic : process (i_clk) is
  begin

    if rising_edge(i_clk) then
      if (i_rst = '1') then
        o <= '0';
      else
        o <= not i;
      end if;
    end if;

  end process proc_logic;

end architecture rtl;
