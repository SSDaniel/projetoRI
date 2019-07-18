library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity vga is
		generic(
		multiplier 	: integer := 1
	);
	port(
		CLOCK_50,rst 		: in std_logic;
		red, green, blue : in std_logic_vector(3 downto 0);
		r, g, b : out std_logic_vector(3 downto 0);
		hsync, vsync : out std_logic
	);
end vga;

architecture vga of vga is

component CVGA is
 port(clk, reset : in std_logic;
 red, green, blue : in std_logic_vector(3 downto 0);
 r, g, b : out std_logic_vector(3 downto 0); 
 hsync, vsync : out std_logic;
 row : out std_logic_vector(8 downto 0);
 column : out std_logic_vector(9 downto 0));
end component;

component clk_divider is
	generic(
		multiplier 	: integer := 1
	);
	port(
		clk_in 		: in std_logic;
		clk_out		: out std_logic
	);
end component;

signal CLOCK_25: std_logic;
signal re,gre,blu : std_logic_vector(3 downto 0);

begin
re <= "0000";
gre <= "1111";
blu <= "0000";

C2: clk_divider port map(CLOCK_50,CLOCK_25);
C: CVGA port map(CLOCK_25,rst,re,gre,blu,r,g,b,hsync,vsync);


end vga;