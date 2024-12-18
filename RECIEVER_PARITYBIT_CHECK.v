`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2023 00:07:28
// Design Name: 
// Module Name: RECIEVER_PARITYBIT_CHECK
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


module RECIEVER_PARITYBIT_CHECK(
    input parity_bit, 
    input [7:0] SIPO_data_in,
    input Clk, 
    input reset, 
    input paritybit_check_enable_in,
    
    output reg parity_check_out
    );
reg parity_temp;
always @ (posedge Clk or posedge reset) begin
    if (reset) begin
        parity_check_out <= 0;
    end
    else if (paritybit_check_enable_in)begin
        parity_temp <= ^SIPO_data_in;
        if (parity_temp == parity_bit) begin
            parity_check_out <= 1;
        end
        else
            parity_check_out <= 0;
    end
    else 
        parity_check_out <= 0;
    
end
endmodule
