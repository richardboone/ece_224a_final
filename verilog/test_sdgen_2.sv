module test_sdgen_2;

	reg [31:0] kval;
	parameter FSIG = 1000;
	parameter BITWIDTH = 32;
	
	reg clk = 0;
	reg reset;
	wire [1:0] sd_out;
	
	initial begin
		forever begin
			#500; clk <= ~clk;
		end
	end
	
	initial begin
		// kval <= {16'b0000100000101110, 16'hffff};
		kval <= {16'h0e2c, 16'ha000};//3627 in lowest bits
		// kval <= {16'h0000, 16'b0000111000101011‬};
		reset <= 1;
		
		#1000;
		reset <= 0;
	
	
	end
	
	sigma_delta_twopiece_top #(
		.FSIG(FSIG),
		.BITWIDTH(BITWIDTH))
		top_sd (
		.clk(clk),
		.reset(reset),
		.kin(kval),
		.sd_out(sd_out));
		


endmodule