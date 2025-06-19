`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/26 16:58:39
// Design Name: 
// Module Name: uart_cu
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


module uart_cu_v2 (
    input clk,
    input rst,
    input [7:0] rx_data,
    input rx_done,

    output reg s_sw0,
    output reg s_sw1,
    output reg s_sw2,
    output reg s_sw3,
    output reg s_sw4,

    output s_btnC_rst,
    output s_btnL_clear,
    output s_btnR_runstop,
    output s_btnU_up,
    output s_btnD_down

);  

    reg tick_reg, tick_next;

    assign s_btnC_rst = (8'h1B == rx_data) ? tick_reg : 0;
    assign s_btnL_clear = (8'h43 == rx_data) ? tick_reg : 0;
    assign s_btnR_runstop = (8'h47 == rx_data) ? tick_reg : 0;
    assign s_btnU_up = (8'h57 == rx_data) ? tick_reg : 0;
    assign s_btnD_down = (8'h44 == rx_data) ? tick_reg : 0;

    always @(posedge clk, posedge rst) begin
       if (rst) begin
        s_sw0 <=0;
        s_sw1 <=0;
        s_sw2 <=0;
        s_sw3 <=0;
        s_sw4 <=0;
        tick_reg <=0;    
        end else begin
            tick_reg <= tick_next & rx_done;
            if (rx_done) begin
            case (rx_data)
            8'h6D  : s_sw0 = (s_sw0) ? 0 : 1; 
            8'h6E  : s_sw1 = (s_sw1) ? 0 : 1;
            8'h31  : s_sw2 = (s_sw2) ? 0 : 1; 
            8'h32  : s_sw3 = (s_sw3) ? 0 : 1; 
            8'h33  : s_sw4 = (s_sw4) ? 0 : 1;  
            endcase
            end
        end
    end 

    always @(*) begin
        tick_next = tick_reg;
        case (rx_data)
        8'h47  : tick_next= 1;  // G  
        8'h43  : tick_next= 1;  // C
        8'h1B  : tick_next= 1;  // ESC
        8'h57  : tick_next= 1;  // W
        8'h44  : tick_next= 1;  // D 
            default: tick_next= 0;  
        endcase
    end


            
              



endmodule
