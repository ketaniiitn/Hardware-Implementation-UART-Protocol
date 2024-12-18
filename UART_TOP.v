`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2023 16:36:14
// Design Name: 
// Module Name: UART_TOP
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


module UART_TOP(
    input   Clk, 
    input   reset, 
    input   [7:0] data_in,
    input   [1:0] baud_sel_in,
    input   start,
    
    output  [7:0] data_out 
    );
// Connections from Baud Mux
wire [11:0] baud_mux_out_to_baud_mux_gen__divisor;

// Connections from Baud rate gen
wire baud_rate_gen_to_Clock__baud_rate;

// Connections from reciever FSM
wire reciever_fsm_to_reciever_sipo__sipo_enable;
wire reciever_fsm_to_reciever_sipo__sipo_shift;
wire reciever_fsm_to_reciever_paritybit_check__paritybit_check_enable;
wire reciever_fsm_to_reciever_stopbit_check__stopbit_check_enable;


//Connections from reciever Sipo
wire [7:0] reciever_sipo_to_reciever_paritybit_check__data_out;

// Connectios from reciever paritybit check
wire reciever_paritybit_check_to_output__parity_check;

//Connections from startbit check
wire reciever_start_bit_check_to_reciever_fsm__start_bit_check;

// Connections fronm stop bit check
wire reciever_stopbit_check_to_reciever_fsm__stop_bit_check;

// Connections from transmitter fsm
wire transmitter_fsm_to_transmitter_piso__shift;
wire transmitter_fsm_to_transmitter_piso__load;
wire [1:0] transmitter_fsm_to_transmitter_mux__mux_sel;
wire transmitter_fsm_to_transmitter_mux__mux_enable;

// connections from paritybit gen 
wire parity_bit_gen_to_parity_bit_mux__parity_bit;

//connections from transmitter_mux
wire transmitter_mux_to_reciever_end__mux_out;

//connections from piso
wire transmitter_piso_to_transmitter_mux__data_out;

assign data_out = reciever_sipo_to_reciever_paritybit_check__data_out;

BAUD_MUX baud_mux (
    .baud_sel_in(baud_sel_in),
    .baud_mux_out(baud_mux_out_to_baud_mux_gen__divisor)
);

BAUD_RATE_GENERATOR baud_rate_generator (
    .Clk(Clk), 
    .reset(reset),
    
    .divisor_in(baud_mux_out_to_baud_mux_gen__divisor),
    
    .baud_out(baud_rate_gen_to_Clock__baud_rate)
);

RECIEVER_FSM reciever_fsm (
    .Clk(baud_rate_gen_to_Clock__baud_rate),
    .reset(reset),
    
    .start_bit_in(reciever_start_bit_check_to_reciever_fsm__start_bit_check),
    .stop_bit_in(reciever_stopbit_check_to_reciever_fsm__stop_bit_check),
    
    .sipo_enable_out(reciever_fsm_to_reciever_sipo__sipo_enable),
    .sipo_shift_out(reciever_fsm_to_reciever_sipo__sipo_shift),
    .parity_bit_check_enable_out(reciever_fsm_to_reciever_paritybit_check__paritybit_check_enable),
    .stop_bit_check_enable_out(reciever_fsm_to_reciever_stopbit_check__stopbit_check_enable)
);

RECIEVER_SIPO reciever_sipo (      
    .Clk(baud_rate_gen_to_Clock__baud_rate),        
    .reset(reset),
    
    .data_in(transmitter_mux_to_reciever_end__mux_out), 
    .shift(reciever_fsm_to_reciever_sipo__sipo_shift),
    .sipo_enable_in(reciever_fsm_to_reciever_sipo__sipo_enable),
    
    .data_out(reciever_sipo_to_reciever_paritybit_check__data_out)
);

RECIEVER_PARITYBIT_CHECK reciever_parity_check (    
    .Clk(baud_rate_gen_to_Clock__baud_rate),            
    .reset(reset),
    
    .parity_bit(transmitter_mux_to_reciever_end__mux_out),            
    .SIPO_data_in(reciever_sipo_to_reciever_paritybit_check__data_out),            
    .paritybit_check_enable_in(reciever_fsm_to_reciever_paritybit_check__paritybit_check_enable),
    
    .parity_check_out(reciever_paritybit_check_to_output__parity_check)
);

RECIEVER_STARTBIT_DET reciever_startbit_det (
    .Clk(baud_rate_gen_to_Clock__baud_rate),
    .reset(reset), 
    
    .data_in(transmitter_mux_to_reciever_end__mux_out),
    .startbit_det_enable_in(start),
    
    .start_bit_out(reciever_start_bit_check_to_reciever_fsm__start_bit_check)
);
  
RECIEVER_STOPBIT_CHECK reciever_stopbit_check (
    .stop_bit_in(transmitter_mux_to_reciever_end__mux_out),          
    .Clk(baud_rate_gen_to_Clock__baud_rate),                    
    .reset(reset),
    .stopbit_check_enable_in(reciever_fsm_to_reciever_stopbit_check__stopbit_check_enable),
                          
    .stop_bit_check_out(reciever_stopbit_check_to_reciever_fsm__stop_bit_check)
);  

TRANSMITTER_FSM transmitter_fsm (
    .tx_start_in(start),            
    .Clk(baud_rate_gen_to_Clock__baud_rate),         
    .reset(reset),
                        
    .shift_out(transmitter_fsm_to_transmitter_piso__shift),          
    .load_out(transmitter_fsm_to_transmitter_piso__load),
    .tx_mux_sel_out(transmitter_fsm_to_transmitter_mux__mux_sel),
    .mux_enable(transmitter_fsm_to_transmitter_mux__mux_enable)                      
);

TRANSMITTER_MUX transmitter_mux (
    .tx_mux_sel(transmitter_fsm_to_transmitter_mux__mux_sel),   
    .data_in(transmitter_piso_to_transmitter_mux__data_out),     
    .parity_bit_in(parity_bit_gen_to_parity_bit_mux__parity_bit),
    .mux_enable(transmitter_fsm_to_transmitter_mux__mux_enable),  
    .tx_mux_out(transmitter_mux_to_reciever_end__mux_out)
);

TRANSMITTER_PARITY_BIT_GEN transmitter_parity_bit_gen (
    .data_in(data_in),                   
    .parity_bit_out(parity_bit_gen_to_parity_bit_mux__parity_bit)
);

TRANSMITTER_PISO transmitter_piso (
    .data_in(data_in), 
    .shift_in(transmitter_fsm_to_transmitter_piso__shift),
    .load_in(transmitter_fsm_to_transmitter_piso__load), 
    .Clk(baud_rate_gen_to_Clock__baud_rate),
    .reset(reset),
         
    .data_out(transmitter_piso_to_transmitter_mux__data_out)
);
endmodule
