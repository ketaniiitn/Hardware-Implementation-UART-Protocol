`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2023 01:04:20
// Design Name: 
// Module Name: RECIEVER_STARTBIT_DET
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


module RECIEVER_STARTBIT_DET(
    input data_in,
    input Clk, 
    input reset,
    input startbit_det_enable_in,
    
    output reg start_bit_out
    );
always @ (posedge Clk or posedge reset) begin
    if (reset) begin
        start_bit_out <= 0;
    end 
    else if(startbit_det_enable_in) begin
        if (data_in == 1)begin
            start_bit_out = 1; 
        end
        else
            start_bit_out = 0;
    end
    else 
        start_bit_out <= 0;
end
    
endmodule
