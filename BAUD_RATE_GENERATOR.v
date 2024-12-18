`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 12:36:33
// Design Name: 
// Module Name: BAUD_RATE_GENERATOR
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


module BAUD_RATE_GENERATOR(
    input Clk,
    input reset, 
    input [11:0] divisor_in,
    
    output reg baud_out  
    );

reg [11:0] count = 0; 
always @ (posedge Clk or posedge reset)
    if(reset) begin
        baud_out <= 0;
    end
    else begin
        if(count == divisor_in) begin
            count <= 0;
            baud_out <= ~baud_out;
        end
        else begin
            count <= count + 1;
        end
    end

endmodule
