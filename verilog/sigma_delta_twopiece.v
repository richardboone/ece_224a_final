module sd_two_piece #(parameter POSTGAIN=2, parameter BITWIDTH = 32, parameter RESETVAL = 0) (clk, reset, kin1, kin2, muxin1, sd_out);
input clk, reset;
input [BITWIDTH-1:0] kin1, kin2;
input muxin1;
output sd_out;
	wire [BITWIDTH-1:0] muxout1, muxout2;
	wire [BITWIDTH-1:0] intermediate_builder;
	
	wire [BITWIDTH-1:0] small_feedback_sum, mid_feedback_sum;
	wire [BITWIDTH-1:0] capped, gained;
	reg [BITWIDTH-1:0] feedback;
	//muxes
	assign muxout1 = muxin1 ? kin1 : kin2;
	assign muxout3 = sd_out ? -16'd1 : 16'd1;

	assign intermediate_builder = muxout1;//addsub2
	
	assign small_feedback_sum = intermediate_builder + muxout3;
	assign mid_feedback_sum = small_feedback_sum + feedback;
	
	// assign capped = feedback_sum[16] ? 16'hffff : feedback_sum;
	
	always@(posedge clk)
	begin
		feedback <= (reset) ? RESETVAL : mid_feedback_sum;
	end
	
	assign gained = feedback;
	
	
	sd2 # (.RESETVAL(0),
	.BW(12))
	sd_one(
	.clk(clk),
	.reset(reset),
	.sd_in(gained[31:20]),
	.bs_out(sd_out));


endmodule


module sigma_delta_twopiece_top #(parameter FSIG = 1000, BITWIDTH = 32)(clk, reset, kin, sd_out);

input clk, reset;
input [BITWIDTH-1:0] kin;
output [1:0] sd_out;

wire [BITWIDTH-1:0] kpos, kneg;

assign kpos = (reset) ? 0 : kin;
assign kneg = (reset) ? 0 : -kin;

//sigmadelta1

	sd_two_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH),
		.RESETVAL(32'h80000000))
	piece_0 (
		.clk(clk),
		.reset(reset),
		.kin1(kneg),
		.kin2(kpos),
		.muxin1(sd_out[1]),
		.sd_out(sd_out[0]));
		
	sd_two_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH),
		.RESETVAL(32'h00000000))
	piece_1 (
		.clk(clk),
		.reset(reset),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[0]),
		.sd_out(sd_out[1]));




endmodule