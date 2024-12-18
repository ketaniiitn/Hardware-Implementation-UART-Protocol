`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 15:08:02
// Design Name: 
// Module Name: TRANSMITTER_FSM
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


module TRANSMITTER_FSM(
    input   tx_start_in,
    input   Clk, 
    input   reset, 
    
    output  reg shift_out, 
    output  reg load_out, 
    output  reg [1:0] tx_mux_sel_out, 
    output  reg mux_enable
    );
localparam IDLE_STATE = 3'b000;
localparam START_STATE = 3'b001;
localparam DATA_STATE = 3'b010;
localparam PARITY_STATE = 3'b011;
localparam STOP_STATE = 3'b100;

reg [3:0] current_state;
reg [3:0] next_state;

reg [2:0] data_count;
always @ (*) begin
    case (current_state) 
        IDLE_STATE: begin
            shift_out       <= 0;
            load_out        <= 0;
            tx_mux_sel_out  <= 2'b0;
            mux_enable      <= 0;
            if (tx_start_in) begin
                next_state <= START_STATE;
                load_out <= 1;
            end
            else 
                next_state <= IDLE_STATE;
        end
        START_STATE: begin
            shift_out       <= 0;
            load_out        <= 1;
            tx_mux_sel_out  <= 2'b0;
            mux_enable      <= 1;
            next_state      <= DATA_STATE;
        end
        DATA_STATE: begin
            shift_out       <= 1;
            load_out        <= 0;
            tx_mux_sel_out  <= 2'b01;
            mux_enable      <= 1;
            if (data_count == 3'b111) 
                next_state <= PARITY_STATE;
            else
                next_state <= DATA_STATE;
        end
        PARITY_STATE: begin
            shift_out       <= 0;
            load_out        <= 0;
            tx_mux_sel_out  <= 2'b10;
            mux_enable      <= 1;
            next_state      <= STOP_STATE;
        end
        STOP_STATE: begin
            shift_out       <= 0;
            load_out        <= 0;
            tx_mux_sel_out  <= 2'b11;
            mux_enable      <= 1;
            next_state      <= IDLE_STATE;
        end
    endcase
end

always @ (posedge Clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE_STATE;
    end
    else begin
        current_state <= next_state;
    end
    
end

always @ (posedge Clk or posedge reset) begin
    if (current_state == DATA_STATE) begin
        data_count <= data_count + 1;
    end
    else
    data_count <= 0;
end
endmodule
