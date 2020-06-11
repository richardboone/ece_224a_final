`timescale 1ns / 1ps
module bitShifter_testbench();


reg clk;
reg [39:0] inval;
reg [39:0] outval;
reg [3:0] outdivider;


bitShifter dut(clk, inval, outval, outdivider);

initial begin
	clk <= 0;
	forever begin
		#5;
		clk <= ~clk;
	end
end

initial begin
	inval <= 40'h011e2b9946;
	@(posedge clk);
	inval <= 40'h000e2b9946;
	#100;
	inval <= 40'he2b9946000;
	#200;
	inval <= 40'h00154165e9;
	#200;
	inval <= 40'h0e2b994600;
end

endmodule