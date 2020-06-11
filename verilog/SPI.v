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
    output reg [39:0] DATA
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
// reg [7:0] bitcnt;

// reg byte_received;  // high when a byte has been received
reg [63:0] byte_data_received;

always @(posedge clk)
begin
  // if(~SSEL_active)
  //   bitcnt <= 3'b000;
  // else
  if(SCK_risingedge)
  begin
    // bitcnt <= bitcnt + 3'b001;

    // implement a shift-left register (since we receive the data MSB first)
    byte_data_received <= {byte_data_received[62:0], MOSI_data};
    //MISO = MOSI_data;
  end
  //leds[15] = 1'b1;
end

assign MISO = MOSI_data;

//always @(posedge clk) byte_received <= SSEL_active && SCK_risingedge && (bitcnt==3'b000);
// always @(posedge clk) byte_received <= ~SSEL_active;
//always @(posedge clk) byte_received <= SSEL_active;
//always @(posedge clk) byte_received <= SCK_risingedge;
//always @(posedge clk) byte_received <= (bitcnt==3'b111);
//always @(posedge clk) byte_received <= (bitcnt==3'b000);

// assign data received to led
always @(posedge clk)
begin 
    //MISO <= MOSI;
    if( ~SSEL_active)
    begin
        DATA[39:0] <= byte_data_received[39:0];
//        leds[14] <= byte_data_received[14];
//        leds[13] <= byte_data_received[13];
//        leds[12] <= byte_data_received[12];
//        leds[11] <= byte_data_received[11];
//        leds[10] <= byte_data_received[10];
//        leds[9] <= byte_data_received[9];
//        leds[8] <= byte_data_received[8];
//        leds[7] <= byte_data_received[7];
//        leds[6] <= byte_data_received[6];
//        leds[5] <= byte_data_received[5];
//        leds[4] <= byte_data_received[4];
//        leds[3] <= byte_data_received[3];
//        leds[2] <= byte_data_received[2];
//        leds[1] <= byte_data_received[1];
//        leds[0] <= byte_data_received[0];
    end

end

//reg [7:0] byte_data_sent;

//reg [7:0] cnt;
//always @(posedge clk) if(SSEL_startmessage) cnt<=cnt+8'h1;  // count the messages

//always @(posedge clk)
//if(SSEL_active)
//begin
//  if(SSEL_startmessage)
//    byte_data_sent <= cnt;  // first byte sent in a message is the message count
//  else
//  if(SCK_fallingedge)
//  begin
//    if(bitcnt==3'b000)
//      byte_data_sent <= 8'h00;  // after that, we send 0s
//    else
//      byte_data_sent <= {byte_data_sent[6:0], 1'b0};
//  end
//end

//assign MISO = byte_data_sent[7];  // send MSB first
//assign MISO = MOSI;  // send MSB first
// we assume that there is only one slave on the SPI bus
// so we don't bother with a tri-state buffer for MISO
// otherwise we would need to tri-state MISO when SSEL is inactive



/*
    assign MISO = ~SCK;
    always @(posedge(clk)) // 2 bit counter that cycles which adc is read
    begin
    
        leds[0] = SCK;
        leds[1] = MOSI;
        leds[2] = SSEL;
        leds[3] = MISO;           
    
    
    end
  */  
    
    
endmodule