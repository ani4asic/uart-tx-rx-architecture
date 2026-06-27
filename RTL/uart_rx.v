module uart_rx (
    input clk_3125,            // 3.125 MHz clock input
    input rx,                  // UART receiver input
    output reg [7:0] rx_msg,   // Received 8-bit message
    output reg rx_parity,      // Received parity bit
    output reg rx_complete     // Flag for completed reception
);

localparam IDLE = 0, START = 1, DATA = 2, PARITY = 3, STOP = 4;
reg [2:0] state = IDLE;

reg [2:0] bit_count;           // Counter for data bits
reg [3:0] baud_count;          // Adjust to match baud rate
reg [7:0] data_store;          // Register to hold received data

initial begin
    rx_msg = 8'b0;
    rx_parity = 0;
    rx_complete = 0;
end

always @(posedge clk_3125) begin
    case (state)
        IDLE: begin
            rx_complete <= 0;       // Reset completion flag
            bit_count <= 3'd7;      // Set bit index to highest bit
				 data_store[bit_count] <= rx;  // Capture received bit
            baud_count <= 0;        // Reset baud counter
            if (rx == 0) begin      // Detect start bit (active low)
                state <= START;
            end
        end

        START: begin
            if (baud_count == 13) begin  // Wait for 1 full bit period
                baud_count <= 0;
                state <= DATA;
            end else begin
                baud_count <= baud_count + 1;
            end
        end

        DATA: begin
            if (baud_count == 13) begin
                baud_count <= 0;
                data_store[bit_count] <= rx;  // Capture received bit
                if (bit_count > 0) begin
                    bit_count <= bit_count - 1;
                end else begin
                    state <= PARITY;   // All bits received, move to parity
                end
            end else begin
                baud_count <= baud_count + 1;
            end
        end

        PARITY: begin
            if (baud_count == 13) begin
                baud_count <= 0;
                rx_parity <= ^(rx);              // Capture received parity bit
                state <= STOP;
            end else begin
                baud_count <= baud_count + 1;
            end
        end

        STOP: begin
            if (baud_count == 12) begin         // Align STOP baud count with other states
                rx_msg <= data_store;           // Store received data
                state <= IDLE;                  // Return to idle state
                rx_complete <= 1;               // Set complete flag
            end else begin
                baud_count <= baud_count + 1;
            end
        end

        default: state <= IDLE;
    endcase
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
