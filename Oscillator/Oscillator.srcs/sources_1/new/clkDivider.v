`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2020 03:51:38 PM
// Design Name: 
// Module Name: clkDivider
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


module divide_2(
    input inClk,
    input reset,
    input enable,
    output reg outClk
    );
    
initial begin
    outClk = 0;
end
always @(posedge inClk or negedge reset) begin
if (!reset) begin
    outClk <= 0;
end
else if (enable) begin
    outClk <= ~outClk;
end
end

endmodule



module clkDivider(
    input inClk,            // probably the 100MHZ clk
    input wire [3:0] n,     // counter where n goes to 2^n, 0 <= n <= 12
    output reg outClk       // outClk = inClk / 2^n
    );
    reg [10:0] enReg;
    wire [11:0] clkReg;
    assign clkReg[0] = inClk;
    divide_2 div2To1(clkReg[0], 1'b0, enReg[0], clkReg[1]);
    divide_2 div2To2(clkReg[1], 1'b0, enReg[1], clkReg[2]);
    divide_2 div2To3(clkReg[2], 1'b0, enReg[2], clkReg[3]);
    divide_2 div2To4(clkReg[3], 1'b0, enReg[3], clkReg[4]);
    divide_2 div2To5(clkReg[4], 1'b0, enReg[4], clkReg[5]);
    divide_2 div2To6(clkReg[5], 1'b0, enReg[5], clkReg[6]);
    divide_2 div2To7(clkReg[6], 1'b0, enReg[6], clkReg[7]);
    divide_2 div2To8(clkReg[7], 1'b0, enReg[7], clkReg[8]);
    divide_2 div2To9(clkReg[8], 1'b0, enReg[8], clkReg[9]);
    divide_2 div2To10(clkReg[9], 1'b0, enReg[9], clkReg[10]);
    divide_2 div2To11(clkReg[10], 1'b0, enReg[10], clkReg[11]);
    
    always @ inClk begin
        case(n)
            4'b0000 : begin
                enReg <= 11'b00000000000;
                outClk = clkReg[0];
                end
            4'b0001 : begin
                enReg <= 11'b00000000001;
                outClk = clkReg[1];
                end
            4'b0010 : begin
                enReg <= 11'b00000000011;
                outClk = clkReg[2];
                end
            4'b0011 : begin
                enReg <= 11'b00000000111;
                outClk = clkReg[3];
                end
            4'b0100 : begin
                enReg <= 11'b00000001111;
                outClk = clkReg[4];
                end
            4'b0101 : begin
                enReg <= 11'b00000011111;
                outClk = clkReg[5];
                end
            4'b0110 : begin
                enReg <= 11'b00000111111;
                outClk = clkReg[6];
                end
            4'b0111 : begin
                enReg <= 11'b00001111111;
                outClk = clkReg[7];
                end
            4'b1000 : begin
                enReg <= 11'b00011111111;
                outClk = clkReg[8];
                end
            4'b1001 : begin
                enReg <= 11'b00111111111;
                outClk = clkReg[9];
                end 
            4'b1010 : begin
                enReg <= 11'b01111111111;
                outClk = clkReg[10];
                end
            4'b1011 : begin
                enReg <= 11'b11111111111;
                outClk = clkReg[11];
                end                    
            default : begin
                enReg <= 11'b11111111111;
                outClk = clkReg[11];
                end                                                  
        endcase
    end
    
    
    
endmodule
