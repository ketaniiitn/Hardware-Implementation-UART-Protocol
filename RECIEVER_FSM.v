`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2023 00:52:39
// Design Name: 
// Module Name: RECIEVER_FSM
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


module RECIEVER_FSM(
    input Clk, 
    input reset, 
    input start_bit_in, 
    input stop_bit_in,
    
    output reg sipo_enable_out, 
    output reg sipo_shift_out,
    output reg parity_bit_check_enable_out, 
    output reg stop_bit_check_enable_out
    );  
localparam IDLE_STATE = 3'b000;
localparam START_STATE = 3'b001;
localparam DATA_STATE = 3'b010;
localparam STOP_STATE = 3'b100;
localparam PARITY_STATE = 3'b011;

reg [2:0] current_state;
reg [2:0] next_state;
reg [2:0] data_count = 3'b0;
always @ (*) begin
    case (current_state)
        IDLE_STATE: begin
            sipo_enable_out <= 0;
            sipo_shift_out <= 0;
            parity_bit_check_enable_out <= 0;
            stop_bit_check_enable_out <= 0;
            if (start_bit_in) begin
                next_state <= DATA_STATE;
                sipo_enable_out <= 1;
                sipo_shift_out <= 1;
            end
            else 
                next_state <= IDLE_STATE;
        end
        DATA_STATE: begin
            sipo_enable_out <= 1;
            sipo_shift_out <= 1;
            parity_bit_check_enable_out <= 0;
            stop_bit_check_enable_out <= 0;
            if (data_count == 3'b111) begin
                next_state <= PARITY_STATE;
                parity_bit_check_enable_out <= 1;
            end
            else
                 next_state <= DATA_STATE;
        end
        PARITY_STATE: begin
            sipo_enable_out <= 0;
            sipo_shift_out <= 0;
            parity_bit_check_enable_out <= 1;
            stop_bit_check_enable_out <= 0; 
            next_state <= STOP_STATE;
        end
        STOP_STATE: begin
            sipo_enable_out <= 0;
            sipo_shift_out <= 0;
            parity_bit_check_enable_out <= 0;
            stop_bit_check_enable_out <= 1;
            if(stop_bit_in) begin
                next_state <= IDLE_STATE;  
            end    
            else
                next_state <= STOP_STATE;
        end
    endcase
end

always @ (posedge Clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE_STATE;
    end
    else  begin
        current_state <= next_state;
    end
end

always @ (posedge Clk) begin
    if (sipo_enable_out) begin
        data_count <= data_count + 1;
    end
    else 
    data_count <= 0;
end
endmodule
