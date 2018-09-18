----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:54:25 05/04/2015 
-- Design Name: 
-- Module Name:    obstacles_ROM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity obstacles3_ROM is
    Port ( obstacle3_on     : in  STD_LOGIC;
           obstacle3_row    : in  STD_LOGIC_VECTOR (10 downto 0);
           obstacle3_col    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obstacle3_enable : out  STD_LOGIC;
           obstacle3_rgb    : out  STD_LOGIC );
end obstacles3_ROM;

architecture Behavioral of obstacles3_ROM is
type ROM is array(0 to 49) of std_logic_vector(49 downto 0);
constant content : ROM := (
   0 => "00000000000000000000000000111000000000000000000000",
   1 => "00000000000000000000011111111111100000000000000000",
   2 => "00000000000000000011111111111111111100000000000000",
   3 => "00000000000000011111111111111111111111110000000000",
   4 => "00000000000000111111111111111111111111111000000000",
   5 => "00000000000001111111111111111111111111110000000000",
   6 => "00000000000011111111111111111111111111100000000000",
   7 => "00000000000111111111111111111111111111110000000000",
   8 => "00000000001111111111111111111111111111111100000000",
   9 => "00000000001111111111111111111111111111111110000000",
  10 => "00000000001111111111111111111110000111111111000000",
  11 => "00000000011111111111111111111111000001111111100000",
  12 => "00000000111111111111111111111000000111111111111100",
  13 => "00000001111111111111111111111110000011111111111110",
  14 => "00000111111111111111111111111111000111111111111111",
  15 => "00000111111111111111111111111111111111111111111111",
  16 => "00001111111111111111111111111111111111111111111110",
  17 => "00011111111111111111111111111111111111111111111110",
  18 => "00011111111111111111111111111111111111111111111110",
  19 => "00011111111111111001111111111111111111111111111110",
  20 => "00111111111111110000011111111111111111111111111100",
  21 => "00111111111111100000001111111111111111111111111100",
  22 => "01111111111111111000000111111111111111111111111000",
  23 => "01111111111111111110000111111111111111111111111000",
  24 => "01111111111111111111111111111111111000111111110000",
  25 => "01111111111111111111111111111111110000011111000000",
  26 => "01111111111111111111111111111111110000011111100000",
  27 => "00111111111111111111111111111111111000111111110000",
  28 => "00011111111111111111111111111111111111111111110000",
  29 => "00001111111111111000001111111111111111111111111000",
  30 => "00000000011111111000001111111111111111111111111000",
  31 => "00000000011111110000001111111111111111111111111100",
  32 => "00000000001111111100111111111111111111111111111110",
  33 => "00000000000111111111111111111111111111111111111110",
  34 => "00000000000011111111111111111111111111111111111111",
  35 => "00000000000000011111111111111111111111111111111110",
  36 => "00000000000000001111111111111111111111111111111110",
  37 => "00000000000000000001111111111111111111111111111110",
  38 => "00000000000000000000111111111111111111111111100000",
  39 => "00000000000000000000000000111111111111111100000000",
  40 => "00000000000000000000000000011111111111110000000000",
  41 => "00000000000000000000000000000111111111000000000000",
  42 => "00000000000000000000000000000000000000000000000000",
  43 => "00000000000000000000000000000000000000000000000000",
  44 => "00000000000000000000000000000000000000000000000000",
  45 => "00000000000000000000000000000000000000000000000000",
  46 => "00000000000000000000000000000000000000000000000000",
  47 => "00000000000000000000000000000000000000000000000000",
  48 => "00000000000000000000000000000000000000000000000000",
  49 => "00000000000000000000000000000000000000000000000000"
	);

signal data_line : std_logic_vector(0 to 49);
signal obs3_rgb : std_logic;
signal enable : std_logic;
constant rest : integer := 2;
begin

process(obstacle3_on, obstacle3_col, obstacle3_row)
begin

    obs3_rgb <= '0';
	 enable <= '0';
	 
	 -- IF OBSTACLE IS ON
    if obstacle3_on = '1' then
		  -- SCALING ALGORITHM
		  if (conv_integer(obstacle3_col) rem rest) = 0 then
	         data_line <= content((conv_integer(obstacle3_col)) / rest);
		  else
		      data_line <= content((conv_integer(obstacle3_col) - (conv_integer(obstacle3_col) rem rest)) / rest);
		  end if;
		  if (conv_integer(obstacle3_row) rem rest) = 0 then
		      obs3_rgb <= data_line((conv_integer(obstacle3_row)) / rest);
				-- ENABLE ROM
				enable <= '1';
		  else
		  		obs3_rgb <= data_line((conv_integer(obstacle3_row) - (conv_integer(obstacle3_row) rem rest)) / rest);
				-- ENABLE ROM
				enable <= '1';
		  end if;
	 end if;

end process;

obstacle3_rgb <= obs3_rgb;
obstacle3_enable <= enable;

end Behavioral;












