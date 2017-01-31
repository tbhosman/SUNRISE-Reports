entity uart is
	port (
		clk, reset: in std_logic;
		rx: in std_logic; --input bit stream
		tx: out std_logic; --output bit stream
		sw: in std_logic_vector(7 downto 0); --byte to be sent
		led: out std_logic_vector(7 downto 0); --received byte
		write_data: in std_logic; --write to transmitter buffer 
		read_data: in std_logic; --read from receiver buffer 
		sseg: out std_logic_vector(7 downto 0); --seven segment LED display
		an: out std_logic_vector(3 downto 0) --anodes of seven segment LED display 
	);
end uart;