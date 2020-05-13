module sd_piece #(parameter POSTGAIN, parameter BITWIDTH = 32) (clk, kin1, kin2, muxin1, muxin2, sd_out);
input clk;
input [BITWIDTH-1:0] kin1, kin2;
input muxin1, muxin2;
output sd_out;
	wire [BITWIDTH-1:0] muxout1, muxout2;
	wire [BITWIDTH-1:0] intermediate_builder;
	
	wire [BITWIDTH-1:0] small_feedback_sum;
	wire [BITWIDTH-1:0] capped;
	reg [BITWIDTH-1:0] feedback;
	//muxes
	assign muxout1 = muxin1 ? kin1 : kin2;
	assign muxout2 = muxin2 ? kin2 : kin1;
	assign muxout3 = sd_out ? -16'd1 : 16'd1;

	assign intermediate_builder = muxout1 + muxout2;//addsub2
	
	assign small_feedback_sum = intermediate_builder + muxout3;
	assign mid_feedback_sum = small_feedback_sum + feedback;
	
	// assign capped = feedback_sum[16] ? 16'hffff : feedback_sum;
	
	always@(posedge clk)
	begin
		feedback <= mid_feedback_sum;
	end
	
	assign gained = feedback << POSTGAIN;
	
	
	sd2 sd_one(
	.clk(clk),
	.sd_in(gained),
	.bs_out(sd_out));


endmodule

module sigma_delta_final_top #(parameter FSIG = 1000, BITWIDTH = 32)(clk, kin, sd_out);

input clk;
input [BITWIDTH-1:0] kin;
output [2:0] sd_out;

wire [BITWIDTH-1:0] kpos, kneg;

assign kpos = kin;
assign kneg = -kin;

//sigmadelta1

	sd_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH))
	piece_0 (
		.clk(clk),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[1]),
		.muxin2(sd_out[2]),
		.sd_out(sd_out[0]));
		
	sd_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH))
	piece_1 (
		.clk(clk),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[0]),
		.muxin2(sd_out[2]),
		.sd_out(sd_out[1]));

	sd_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH))
	piece_2 (
		.clk(clk),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[1]),
		.muxin2(sd_out[0]),
		.sd_out(sd_out[2]));










endmodule