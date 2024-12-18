`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 13:24:36
// Design Name: 
// Module Name: TRANSMITTER_PISO
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


module TRANSMITTER_PISO(
    input [7:0] data_in,
    input       shift_in,
    input       load_in, 
    input       Clk,
    input       reset,
    
    output reg  data_out
    );
reg [7:0] temp;
always @ (posedge Clk or posedge reset) begin
    if(reset) begin
        data_out <= 0;
        temp <= 8'b0;
    end
    else if (load_in) begin
        temp <= data_in;
        data_out <= temp[0];
    end
    else if (shift_in) begin
        temp = temp >> 1'b1;
        data_out <= temp[0];
    end
    else begin
        data_out <= data_out;
    end
end
endmodule
