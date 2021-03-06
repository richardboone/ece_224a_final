
module sd_two_piece #(parameter POSTGAIN=2, parameter BITWIDTH = 40, parameter RESETVAL = 0) (clk, reset, kin1, kin2, muxin1, sd_out);
input clk, reset;
input [BITWIDTH-1:0] kin1, kin2;
input muxin1;
output sd_out;
	wire [BITWIDTH-1:0] muxout1, muxout2, muxout3;
	wire [BITWIDTH-1:0] intermediate_builder;
	
	wire [BITWIDTH-1:0] small_feedback_sum, mid_feedback_sum;
	wire [BITWIDTH-1:0] capped, gained;
	reg signed [BITWIDTH-1:0] feedback;
	//muxes
	assign muxout1 = muxin1 ? kin1 : kin2;
	assign muxout3 = sd_out ? 40'hffffff0000 : 40'h0000010000;

	assign intermediate_builder = muxout1;//addsub2
	
	// assign small_feedback_sum = intermediate_builder + muxout3;
	// assign mid_feedback_sum = small_feedback_sum + feedback;
	capped_adder #(.BITWIDTH(BITWIDTH)) add_1 (intermediate_builder, muxout3, small_feedback_sum);
	capped_adder #(.BITWIDTH(BITWIDTH)) add_2 (small_feedback_sum, feedback, mid_feedback_sum);
	
	
	// assign capped = feedback_sum[16] ? 16'hffff : feedback_sum;
	
	always@(posedge clk)
	begin
		feedback <= (reset) ? RESETVAL : mid_feedback_sum;
	end
	
	assign gained = feedback;
	
	
	sd2 # (.RESETVAL(0),
	.BW(16))
	sd_one(
	.clk(clk),
	.reset(reset),
	.sd_in(gained[39:24]),
	.bs_out(sd_out));


endmodule