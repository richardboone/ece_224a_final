`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2020 05:36:27 PM
// Design Name: 
// Module Name: test
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


module SPI_slave(
    input clk,
    input SCK,
    input MOSI,
    input SSEL,
    //output wire MISO,
    output reg [63:0] DATA
    );


    // sync SCK to the FPGA clock using a 3-bits shift register
reg [2:0] SCKr;  always @(posedge clk) SCKr <= {SCKr[1:0], SCK};
wire SCK_risingedge = (SCKr[2:1]==2'b01);  // now we can detect SCK rising edges
wire SCK_fallingedge = (SCKr[2:1]==2'b10);  // and falling edges

// same thing for SSEL
reg [2:0] SSELr;  always @(posedge clk) SSELr <= {SSELr[1:0], SSEL};
wire SSEL_active = ~SSELr[1];  // SSEL is active low
wire SSEL_startmessage = (SSELr[2:1]==2'b10);  // message starts at falling edge
wire SSEL_endmessage = (SSELr[2:1]==2'b01);  // message stops at rising edge

// and for MOSI
reg [1:0] MOSIr;  always @(posedge clk) MOSIr <= {MOSIr[0], MOSI};
wire MOSI_data = MOSIr[1];

// we handle SPI in 8-bits format, so we need a 3 bits counter to count the bits as they come in
reg [7:0] bitcnt;

reg byte_received;  // high when a byte has been received
reg [63:0] byte_data_received;

always @(posedge clk)
begin
  if(~SSEL_active)
    bitcnt <= 3'b000;
  else
  if(SCK_risingedge)
  begin
    bitcnt <= bitcnt + 3'b001;

    byte_data_received <= {byte_data_received[62:0], MOSI_data};
  end
  //leds[15] = 1'b1;
end

assign MISO = MOSI_data;

always @(posedge clk) byte_received <= ~SSEL_active;

// assign data received to led
always @(posedge clk)
begin 
    //MISO <= MOSI;
    if(byte_received)
    begin
        DATA[63:0] <= byte_data_received[63:0];
    end

end


    
    
endmodule