Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pcincrementer is



end entity;


architecture pcincdes of pcincrementer is

signal pcoutput,marinput,maroutput:  std_logic_vector(15 downto 0);
signal incrementeroutput:  std_logic_vector(15 downto 0);
signal bus1,bus2,bus3:  std_logic_vector(31 downto 0);
signal muxout,mdroutmuxin: std_logic_vector(15 downto 0);
signal pcinput:std_logic_vector(15 downto 0);
signal pcin,muxpcin,pcout,clk,marin,muxclear,mdroutl,mdrouth,mdrin,muxmdrin,rst,wr:std_logic;
signal mdrinput,mdroutput: std_logic_vector(31 downto 0);
signal ramout:std_logic_vector(31 downto 0);


constant zero16:std_logic_vector(15 downto 0):=(others=>'0');

begin

pc: entity work.nbitregister generic map(n=>16) port map(pcinput,rst,clk,pcin,pcoutput);

martristatein:entity work.tristate generic map(n=>16) port map(bus2(15 downto 0),marinput,marin);


pctristateout1:entity work.tristate generic map(n=>16) port map(pcoutput,bus2(15 downto 0),pcout);
pctristateout2:entity work.tristate generic map(n=>16) port map(zero16,bus2(31 downto 16),pcout);
--muxpc:entity work.mux2 generic map(n=>16) port map(incrementeroutput,bus1,muxpcin,muxout);
muxpc:entity work.mux2 generic map(n=>16) port map(incrementeroutput,bus1(15 downto 0),muxpcin,pcinput);
incrementer: entity work.pccalculator generic map(n=>16) port map(pcoutput,incrementeroutput);

mar:entity work.nbitregister generic map(n=>16) port map(marinput,rst,not clk,marin,maroutput);

mdr:entity work.nbitregister generic map(n=>32) port map(mdrinput,rst,clk,mdrin,mdroutput);

muxmdr:entity work.mux2 generic map(n=>32) port map(ramout,bus1,muxmdrin,mdrinput);

mdroutltristateout:entity work.tristate generic map(n=>16) port map(mdroutput(15 downto 0),bus2(15 downto 0),mdroutl);
mdroutHtristateout:entity work.tristate generic map(n=>16) port map(mdroutput(31 downto 16),mdroutmuxin,mdrouth);

muxclearhigh:entity work.mux2 generic map(n=>16) port map(mdroutmuxin,zero16,muxclear,bus2(31 downto 16));


ram:entity work.ram port map(clk,wr,maroutput(10 downto 0),mdroutput,ramout);



end pcincdes;