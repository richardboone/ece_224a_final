`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2015 03:26:51 PM
// Design Name: 
// Module Name: // Project Name: 
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
 

module getOmega(
   input CLK100MHZ,
   input sck,
   input mosi,
   input ssel,
   output reg miso,
   output reg [15:0] LED,
   output reg [63:0] omega
);
    //reg [39:0] omega; // Angle for frequency
    wire [63:0] dataOut;
    //wire omegaOut;
    wire misoOut;
    SPI_slave SPI(CLK100MHZ, sck, mosi, ssel, misoOut, dataOut);
  
    always @(posedge(CLK100MHZ)) // 2 bit counter that cycles which adc is read
    begin
    
        LED[15:0]=dataOut[31:16];
        omega[63:0]=dataOut[63:0];
        miso = misoOut;
        

    end
      

    
endmodule
