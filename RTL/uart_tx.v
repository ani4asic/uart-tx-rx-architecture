// EcoMender Bot : Task 2A - UART Transmitter
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to generate UART Tx data packet to transmit the messages based on the input data.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Transmitter

Input:  clk_3125 - 3125 KHz clock
        parity_type - even(0)/odd(1) parity type
        tx_start - signal to start the communication.
        data    - 8-bit data line to transmit

Output: tx      - UART Transmission Line
        tx_done - message transmitted flag
*/

// module declaration
module uart_tx(
    input clk_3125,
    input parity_type,tx_start,
    input [7:0] data,
    output reg tx, tx_done
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////
localparam IDLE = 0, START = 1, DATA = 2, PARITY = 3, STOP = 4;
reg [2:0] state;
reg [2:0] bitIndex;     // Counter for data bits
reg parity_bit;              // Parity bit storage
reg [2:0] counter;    // Adjust 'N' for baud rate
reg [3:0] counter2;
reg r_clk2;
wire w_clk2;
reg r_start;
initial begin
    tx = 1;
    tx_done = 0;
	 counter = 3'd6;
	 counter2 = 4'd13;
	 bitIndex = 3'd7;
	 state = IDLE;
	 r_clk2 = 0;
	 r_start = 0;
end
always @(posedge clk_3125) begin
counter <= (counter == 3'd6) ? 3'd0:counter+3'd1;
	r_clk2 <= (counter == 3'd6) ? ~r_clk2 : r_clk2;
	counter2 <= (counter2==4'd13) ? 4'd0:counter2+4'd1;
	//r_start<= (state == STOP)?1'd0:tx_start;
	if(counter2==4'd13 && state==STOP) begin
	tx_done<= 1'b1;
	end
	end
assign w_clk2 = r_clk2;

always @ (posedge tx_start or posedge w_clk2) begin
if(tx_start) 
r_start <= 1'd1;
else 
r_start<=1'd0;
 end

always @ (posedge w_clk2) begin
     case (state)
        IDLE: begin
            if (r_start) begin
				parity_bit <= parity_type;
				    state <= START;end
					 //bit_count <= 3'd7;
             else begin
		          state<= IDLE;		 
                tx<=1;end
					 //done_flag<=0;
                 
        end

       START: begin
	  if (data == 8'b0) begin
	     tx<=1; end else begin
			  tx<=0;state<=DATA;end
		  end
       

        DATA: 
            begin
				tx <= data[bitIndex];
				if(&bitIndex) begin
					bitIndex <= 3'd7;
					state <= PARITY;
				end else
					bitIndex <= bitIndex - 1'b1;
			end

        PARITY: begin
		      tx<=1; 
		     state<=STOP;
        end

        STOP: begin
             //tx<=1;
				 state<= (data == 8'b0)? STOP : IDLE;end
            

        default:state <= IDLE;
    endcase

	 
	 
	 
	 
	 
	 
	 end 








// Add your code here...

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule