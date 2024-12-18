`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2023 00:25:11
// Design Name: 
// Module Name: RECIEVER_STOPBIT_CHECK
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RECIEVER_STOPBIT_CHECK(
    input stop_bit_in,
    input Clk, 
    input reset, 
    input stopbit_check_enable_in,
    
    output reg stop_bit_check_out
    );
always @ (posedge Clk or posedge reset) begin
    if (reset) begin
        stop_bit_check_out <= 0;
    end
    else if (stopbit_check_enable_in) begin
        if (stop_bit_in == 1'b0) begin
            stop_bit_check_out <= 1;
        end
    end
    else 
        stop_bit_check_out <= 0;
end
endmodule
