module test_sdgen_2;

	reg [39:0] kval;
	parameter FSIG = 1000;
	parameter BITWIDTH = 40;
	parameter CLK_PERIOD = 1000;
	parameter CLK_HALF = CLK_PERIOD/2;
	reg clk = 0;
	reg reset;
	wire [1:0] sd_out;
	integer f;
	initial begin
		f = $fopen("E:\\Classes\\ECE224A\\Final_project\\ece_224a_final\\python\\output.txt", "w");
		forever begin
			#500; clk <= ~clk;
			#500; clk <= ~clk;
			$fwrite(f, "%x, %x\n", top_sd.piece_0.gained[39:8], top_sd.piece_1.gained[39:8]);
		end
	end
	
	initial begin
		// kval <= {16'h0e2b, 16'hffff};
		// kval <= {16'h0e2c, 16'ha000};//3627 in lowest bits
		kval <= {24'h000e2c, 16'he2c0};//3627 in lowest bits
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