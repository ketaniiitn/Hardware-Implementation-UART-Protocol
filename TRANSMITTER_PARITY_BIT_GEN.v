`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 14:20:22
// Design Name: 
// Module Name: TRANSMITTER_PARITY_BIT_GEN
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


module TRANSMITTER_PARITY_BIT_GEN(
    input [7:0] data_in,
    
    output      parity_bit_out      
    );
assign parity_bit_out = ^data_in;
endmodule
