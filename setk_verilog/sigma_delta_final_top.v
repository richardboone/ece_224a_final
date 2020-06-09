module sd_piece #(parameter POSTGAIN=2, parameter BITWIDTH = 32, parameter RESETVAL = 0) (clk, reset, kin1, kin2, muxin1, muxin2, sd_out);
input clk, reset;
input [BITWIDTH-1:0] kin1, kin2;
input muxin1, muxin2;
output sd_out;
	wire [BITWIDTH-1:0] muxout1, muxout2;
	wire [BITWIDTH-1:0] intermediate_builder;
	
	wire [BITWIDTH-1:0] small_feedback_sum;
	wire [BITWIDTH-1:0] capped, gained;
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
		feedback <= (reset) ? 0 : mid_feedback_sum;
	end
	
	assign gained = feedback << POSTGAIN;
	
	
	sd2 # (.RESETVAL(RESETVAL))
	sd_one(
	.clk(clk),
	.reset(reset),
	.sd_in(gained),
	.bs_out(sd_out));


endmodule

module sigma_delta_final_top #(parameter FSIG = 1000, BITWIDTH = 32)(clk, reset, kin, sd_out);

input clk, reset;
input [BITWIDTH-1:0] kin;
output [2:0] sd_out;

wire [BITWIDTH-1:0] kpos, kneg;

assign kpos = (reset) ? 0 : kin;
assign kneg = (reset) ? 0 : -kin;

//sigmadelta1

	sd_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH),
		.RESETVAL(0))
	piece_0 (
		.clk(clk),
		.reset(reset),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[1]),
		.muxin2(sd_out[2]),
		.sd_out(sd_out[0]));
		
	sd_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH),
		.RESETVAL(32'h00ffffff))
	piece_1 (
		.clk(clk),
		.reset(reset),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[0]),
		.muxin2(sd_out[2]),
		.sd_out(sd_out[1]));

	sd_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH),
		.RESETVAL(32'h000fffff))
	piece_2 (
		.clk(clk),
		.reset(reset),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[1]),
		.muxin2(sd_out[0]),
		.sd_out(sd_out[2]));


endmodule