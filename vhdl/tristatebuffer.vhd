Library ieee;
use ieee.std_logic_1164.all;

entity tristate is 
Generic(n:integer :=32);
Port(input: in std_logic_vector(n-1 downto 0);
     output: out std_logic_vector(n-1 downto 0);
     En: in std_logic);

end entity;

Architecture tristateArchitecture of tristate is
begin

output<= input when En='1'
else (others=>'Z');


end tristateArchitecture;