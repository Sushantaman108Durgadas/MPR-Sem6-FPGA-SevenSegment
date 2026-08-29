library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_seven_segment is
    Port (
        digit0 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit1 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit2 : in  STD_LOGIC_VECTOR(3 downto 0);
       
        active_digit : in STD_LOGIC_VECTOR(1 downto 0); -- select which digit to show
        seg          : out STD_LOGIC_VECTOR(7 downto 0); -- a b c d e f g dp
 SevenSegmentEnable1 : out STD_LOGIC;
    SevenSegmentEnable2 : out STD_LOGIC;
 SevenSegmentEnable3 : out STD_LOGIC
    );
end top_seven_segment;

architecture Behavioral of top_seven_segment is

    -- 7-segment lookup table (Active Low for segments, unchanged)
    type seg_array is array (0 to 9) of STD_LOGIC_VECTOR(7 downto 0);
    constant chargen : seg_array := (
        "00000011", -- 0
        "10011111", -- 1
        "00100101", -- 2
        "00001101", -- 3
        "10011001", -- 4
        "01001001", -- 5
        "01000001", -- 6
        "00011111", -- 7
        "00000001", -- 8
        "00001001"  -- 9
    );

begin

    -- Multiplexing logic based on active_digit input (Active High)
    process(active_digit, digit0, digit1, digit2)
        variable d_int : integer range 0 to 9;
    begin
        case active_digit is
            when "00" =>
                d_int := to_integer(unsigned(digit0));
                seg <= chargen(d_int);
                SevenSegmentEnable1 <= '0'; -- Enable digit 0 (Active High)
SevenSegmentEnable2 <= '1';
SevenSegmentEnable3 <= '1';
            when "01" =>
                d_int := to_integer(unsigned(digit1));
                seg <= chargen(d_int);
                SevenSegmentEnable2 <= '0'; -- Enable digit 1
SevenSegmentEnable1 <= '1';
SevenSegmentEnable3 <= '1';
            when "10" =>
                d_int := to_integer(unsigned(digit2));
                seg <= chargen(d_int);
                SevenSegmentEnable3 <= '0'; -- Enable digit 2
SevenSegmentEnable2 <= '1';
SevenSegmentEnable1 <= '1';
            when others =>
                seg <= "11111111";
                SevenSegmentEnable1 <= '1';
SevenSegmentEnable2 <= '1';
SevenSegmentEnable3 <= '1';
        end case;
    end process;

end Behavioral;
