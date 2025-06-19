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
    input sw2,
    input sw3,
    input sw4,
    input btnU_up,
    input btnD_down,
    output [6:0] msec,
    output [5:0] sec,
    output [5:0] min,
    output [4:0] hour
    
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
        .i_btn(btnU_up),
        .o_btn(o_runstop)
    );

    btn_debounce U_BTNL_CLEAR (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnD_down),
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
        .msec(msec),
        .sec(sec),
        .min(min),
        .hour(hour)
    );


endmodule
