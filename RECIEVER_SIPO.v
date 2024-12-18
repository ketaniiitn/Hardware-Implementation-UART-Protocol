`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 16:34:04
// Design Name: 
// Module Name: RECIEVER_SIPO
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


module RECIEVER_SIPO(
    input data_in,
    input Clk, 
    input reset,
    input shift,
    input sipo_enable_in,
    
    output reg [7:0] data_out      
    );
reg [2:0] addr_count = 3'b0;
reg [7:0] temp_data_out = 8'b0;

always @ (posedge Clk or posedge reset) begin
    if(reset) begin
        data_out <= 8'b0;
        addr_count <= 0;
    end
    if (sipo_enable_in) begin
        if (shift) begin
            temp_data_out[addr_count] = data_in;
            addr_count <= addr_count + 1;
            if (addr_count == 0) 
                data_out <= temp_data_out;
        end
        else 
            data_out <= temp_data_out;
              
    end
    else    
        data_out <= temp_data_out;
end
endmodule
