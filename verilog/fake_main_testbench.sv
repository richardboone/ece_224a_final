`timescale 1ns / 1ps

module fake_main_testbench();

	reg clk;
	reg [39:0] kval;
	wire upPort;
	wire downPort;
	reg reset;
	
	fake_main dut(clk, kval, reset, upPort, downPort);
	
	
	initial begin
		clk <= 0;
		forever begin
			#100;
			clk <= ~clk;
		end
	end
	
	initial begin
		kval <= 40'h011e2b9946;
		#1000;
		kval <= 40'h001e2b9946;
		#2000;
		kval <= 40'h000e2b9946;
		#1000;
		@(posedge clk);
		reset <= 1'b1;
		#1000000;
		reset <= 1'b0;
		// reset <= 1'b1;
		#1000;
		// reset <= 1'b0;
		@(posedge clk);
		#100000
		kval <= 40'hf2b9946000;
	end




endmodule