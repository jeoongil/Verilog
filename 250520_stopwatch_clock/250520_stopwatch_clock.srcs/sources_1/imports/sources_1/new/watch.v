`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/21 09:20:38
// Design Name: 
// Module Name: watch
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


module watch (
    input clk,
    input rst,
    input sw0,
    input btnL_clear,
    input btnR_runstop,
    output [3:0] fnd_com,
    output [7:0] fnd_data
);

    wire [6:0] w_msec;
    wire [5:0] w_sec;
    wire [5:0] w_min;
    wire [4:0] w_hour;
    wire w_clear, w_runstop;
    wire o_clear, o_runstop;


    btn_debounce U_BTNR_RUNSTOP (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnR_runstop),
        .o_btn(o_runstop)
    );

    btn_debounce U_BTNL_CLEAR (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnL_clear),
        .o_btn(o_clear)
    );


    watch_cu U_Watch_CU (
        .clk(clk),
        .rst(rst),
        .i_clear(o_clear),
        .i_runstop(o_runstop),
        .o_clear(w_clear),
        .o_runstop(w_runstop)
    );

    watch_dp U_Watch_DP (
        .clk(clk),
        .rst(rst),
        .run_stop(w_runstop),
        .clear(w_clear),
        .msec(w_msec),
        .sec(w_sec),
        .min(w_min),
        .hour(w_hour)
    );

    fnd_controller U_FND_CNTL (
        .clk(clk),
        .rst(rst),
        .sw0(sw0),
        .msec(w_msec),
        .sec(w_sec),
        .min(w_min),
        .hour(w_hour),
        .fnd_data(fnd_data),
        .fnd_com(fnd_com)
    );
endmodule
