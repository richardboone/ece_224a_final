module test_sdgen_2;

	reg [31:0] kval;
	parameter FSIG = 1000;
	parameter BITWIDTH = 32;
	
	reg clk = 0;
	reg reset;
	wire [1:0] sd_out;
	
	initial begin
		forever begin
			#5; clk <= ~clk;
		end
	end
	
	initial begin
		kval <= {16'b0000100000101110, 16'hffff};
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