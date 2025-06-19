`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/26 17:26:26
// Design Name: 
// Module Name: top_watch_uart
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


module top_watch_uart (
    input clk,
    input rst,
    input sw0,
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    input rx,
    input btnU_up,
    input btnD_down,
    input btnR_runstop,
    input btnL_clear,

    output [3:0] led,
    output [3:0] fnd_com,
    output [7:0] fnd_data,
    output tx
);

    wire [7:0] w_rx_data;
    wire w_rx_done;
    wire w_s_sw0;
    wire w_s_sw1;
    wire w_s_sw2;
    wire w_s_sw3;
    wire w_s_sw4;

    wire w_btnC_rst;
    wire w_btnL_l;
    wire w_btnR_r;
    wire w_btnU_u;
    wire w_btnD_d;

    uart_controller U_UART_CNTL (
        .clk(clk),
        .rst(rst),
        .btn_start(btnU_up),
        .rx(rx),
        .rx_data(w_rx_data),
        .rx_done(w_rx_done),
        .tx_done(),
        .tx(tx)
    );

    uart_cu_v2 U_UART_CU (
        .clk(clk),
        .rst(rst),
        .rx_data(w_rx_data),
        .rx_done(w_rx_done),
        .s_sw0(w_s_sw0),
        .s_sw1(w_s_sw1),
        .s_sw2(w_s_sw2),
        .s_sw3(w_s_sw3),
        .s_sw4(w_s_sw4),

        .s_btnC_rst(w_btnC_rst),
        .s_btnL_clear(w_btnL_l),
        .s_btnR_runstop(w_btnR_r),
        .s_btnU_up(w_btnU_u),
        .s_btnD_down(w_btnD_d)

    );



    top U_Stopwatch (
        .clk(clk),
        .rst(rst | w_btnC_rst),
        .sw0(sw0 | w_s_sw0),
        .sw1(sw1 | w_s_sw1),
        .sw2(sw2 | w_s_sw2),
        .sw3(sw3 | w_s_sw3),
        .sw4(sw4 | w_s_sw4),
        .btnL_clear(btnL_clear | w_btnL_l),
        .btnR_runstop(btnR_runstop | w_btnR_r),
        .btnU_up(btnU_up | w_btnU_u),
        .btnD_down(btnD_down | w_btnD_d),
        .led(led),
        .fnd_data(fnd_data),
        .fnd_com(fnd_com)
    );

endmodule
