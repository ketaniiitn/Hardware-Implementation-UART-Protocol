`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 13:06:25
// Design Name: 
// Module Name: BAUD_MUX
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


module BAUD_MUX(
    input [1:0] baud_sel_in,
    
    output reg [11:0] baud_mux_out
    );
always @ (baud_sel_in) begin
    case (baud_sel_in)
        2'b00: baud_mux_out <= 12'b001010001010;
        2'b01: baud_mux_out <= 12'b101000101100;
        2'b10: baud_mux_out <= 12'b000101000101;
        2'b11: baud_mux_out <= 12'b010100010110;
    endcase
end
endmodule
