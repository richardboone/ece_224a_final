module test_sdgen;

	reg [31:0] kval;
	parameter FSIG = 1000;
	parameter BITWIDTH = 32;
	
	reg clk = 0;
	reg reset;
	wire [2:0] sd_out;
	
	initial begin
		forever begin
			#5; clk <= ~clk;
		end
	end
	
	initial begin
		kval <= {16'b0000100000101110, 16'h6666};
		reset <= 1;
		
		#1000;
		reset <= 0;
	
	
	end
	
	sigma_delta_final_top #(
		.FSIG(FSIG),
		.BITWIDTH(BITWIDTH))
		top_sd (
		.clk(clk),
		.reset(reset),
		.kin(kval),
		.sd_out(sd_out));
		


endmodule