`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 12:49:10 PM
// Design Name: 
// Module Name: main
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


module main(
    input CLK10MHZ,
    output reg [2:1] JA

    );
    wire [1:0] sd;
    core Core(CLK10MHZ,1'b0, sd);
    reg delayOut1;
    reg delayOut2;
    always @ (posedge CLK10MHZ)
    begin
        delayOut1 = sd[0];
        delayOut2 = delayOut1;
        JA[1] = ~ (delayOut2 & delayOut1);
        JA[2] = ~ (delayOut2 | delayOut1);
    end
    
    
    
endmodule
