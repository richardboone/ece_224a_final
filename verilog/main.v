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
    //output misoPort,
    //output [15:0] LED,
    output upPort,
    output downPort
    );
    wire [39:0] omegaOut;
    getOmega omega(CLK67MHZ,sckPort,mosiPort,sselPort,omegaOut);
    
    wire [3:0] n, ntemp;
	assign n = 4'b1100 - ntemp;
	
    // msbNumZeros(n,omegaOut[39:24], 1'b1);
    wire clk;
    clkDivider getClk(CLK67MHZ, n, clk);
    wire [1:0] sdOut;
	wire [27:0] sd_kin;
	
	bitShifter bs(CLK67MHZ, omegaOut, sd_kin, ntemp);
    sigma_delta_twopiece sd2(clk,resetPort,sd_kin,sdOut);
    reg delayOut1;
    reg delayOut2;
    always @ (posedge CLK67MHZ)
    begin
        delayOut1 <= sdOut[0];
        delayOut2 <= delayOut1;

    end
    assign upPort = ~ (delayOut2 & delayOut1);
    assign downPort = ~ (delayOut2 | delayOut1);   
endmodule

module bitShifter(clk, inval, outval, outdivider);
input clk;
input [39:0] inval;
output reg [27:0] outval;
output reg [3:0] outdivider;

localparam bitmask = 12'hfff;


reg [39:0] previnval, internal_reg;
reg [3:0] countshift;
reg enable, inreg;
wire  finished;


assign finished = |(internal_reg[39:28] & bitmask); //if no bits in the top 12 bits are 1, 


always@(posedge clk)
begin
	previnval <= inval;
	if (previnval != inval)
	begin
		enable <= 1;
		inreg <= 1;
		countshift <= 0;
	end
	else if (enable)
	begin
		inreg <= 0;
		if (!inreg && finished)
		begin
			countshift <= countshift + 1;
		end
	end
	else if (finished == 1'b0)
	begin
		enable <= 0;
	end
	
	
	//bitshifting
	if (inreg)
	begin
		internal_reg <= previnval;
	end
	else if (finished)
	begin
		internal_reg <= internal_reg >> 1;
	end
	
	if (!finished)
	begin
		outval <= internal_reg[27:0];
		outdivider <= countshift;
	end

end

	



endmodule

