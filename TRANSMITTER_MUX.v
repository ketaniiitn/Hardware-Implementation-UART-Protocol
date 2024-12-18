`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 14:47:13
// Design Name: 
// Module Name: TRANSMITTER_MUX
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


module TRANSMITTER_MUX(
    input  [1:0]tx_mux_sel,
    input       data_in,
    input       parity_bit_in,
    input       mux_enable, 
    output reg tx_mux_out
    );
    
localparam START_BIT = 1'b1;
localparam STOP_BIT =  1'b0;    
    
always @ (tx_mux_sel or mux_enable or data_in or parity_bit_in) begin
    if(mux_enable) begin
        case (tx_mux_sel) 
            2'b00: tx_mux_out <= 1;
            2'b01: tx_mux_out <= data_in;
            2'b10: tx_mux_out <= parity_bit_in;
            2'b11: tx_mux_out <= STOP_BIT;
        endcase
    end
end

endmodule
