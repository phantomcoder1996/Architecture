Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pccalculator is
generic(n : integer:=16);
port(a: in std_logic_vector(n-1 downto 0);
     --b: in std_logic_vector(n-1 downto 0);
     output:out std_logic_vector(n-1 downto 0)
);


end entity;

architecture pccalcarch of pccalculator is

signal result:integer;
begin

--result<= (to_integer(unsigned(a)))+(to_integer(unsigned(b)));
result<= to_integer(unsigned(a))+1;
output<=std_logic_vector(to_unsigned(result,output'length));



end pccalcarch;