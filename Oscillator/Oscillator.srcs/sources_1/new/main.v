`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2020 05:56:22 PM
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
    input CLK67MHZ,
    input sckPort,
    input mosiPort,
    input sselPort,
    input resetPort,
    output misoPort,
    output [15:0] LED,
    output upPort,
    output downPort
    );
    wire [63:0] omegaOut;
    getOmega omega(CLK67MHZ,sckPort,mosiPort,sselPort,misoPort,LED,omegaOut);
    
    wire [3:0] n;
    msbNumZeros(n,omegaOut[39:24], 1'b1);
    wire clk;
    clkDivider getClk(CLK67MHZ, n, clk);
    wire [1:0] sdOut;
    sigma_delta_twopiece sd2(clk,resetPort,omegaOut[39:0],sdOut);
    reg delayOut1;
    reg delayOut2;
    always @ (posedge CLK67MHZ)
    begin
        delayOut1 = sdOut[0];
        delayOut2 = delayOut1;

    end
    assign upPort = ~ (delayOut2 & delayOut1);
    assign downPort = ~ (delayOut2 | delayOut1);   
endmodule



module msbNumZeros (
binary_out , //  4 bit binary output
encoder_in , //  16-bit input 
enable       //  Enable for the encoder
);

output [3:0] binary_out ;
input  enable ; 
input [15:0] encoder_in ; 

wire [3:0] binary_out ;
      
assign  binary_out  = (!enable) ? 0 : (
    (encoder_in == 16'bxxxx_xxxx_xxxx_xxx1) ? 0 : 
    (encoder_in == 16'bxxxx_xxxx_xxxx_xx10) ? 1 : 
    (encoder_in == 16'bxxxx_xxxx_xxxx_x100) ? 2 : 
    (encoder_in == 16'bxxxx_xxxx_xxxx_1000) ? 3 : 
    (encoder_in == 16'bxxxx_xxxx_xxx1_0000) ? 4 : 
    (encoder_in == 16'bxxxx_xxxx_xx10_0000) ? 5 : 
    (encoder_in == 16'bxxxx_xxxx_x100_0000) ? 6 : 
    (encoder_in == 16'bxxxx_xxxx_1000_0000) ? 7 : 
    (encoder_in == 16'bxxxx_xxx1_0000_0000) ? 8 : 
    (encoder_in == 16'bxxxx_xx10_0000_0000) ? 9 : 
    (encoder_in == 16'bxxxx_x100_0000_0000) ? 10 : 
    (encoder_in == 16'bxxxx_1000_0000_0000) ? 11 : 
    (encoder_in == 16'bxxx1_0000_0000_0000) ? 12 : 
    (encoder_in == 16'bxx10_0000_0000_0000) ? 13 : 
    (encoder_in == 16'bx100_0000_0000_0000) ? 14 : 15); 

endmodule 
