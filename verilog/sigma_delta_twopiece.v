
module sigma_delta_twopiece #(parameter FSIG = 1000, BITWIDTH = 40)(clk, reset, kin, sd_out);
localparam BW_TOP = 12;

input clk, reset;
input [BITWIDTH-13:0] kin;
output [1:0] sd_out;

wire [BITWIDTH-1:0] kpos, kneg;
wire [BITWIDTH-1:0] temp_kin;
assign temp_kin = {{BW_TOP{1'b0}}, kin};

assign kpos = (reset) ? 0 : kin;
assign kneg = (reset) ? 0 : -kin;

//sigmadelta1
//40'h8000000000
//40'h7fffffffff
	sd_two_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH),
		.RESETVAL(40'h7fffffffff))
	piece_0 (
		.clk(clk),
		.reset(reset),
		.kin1(kneg),
		.kin2(kpos),
		.muxin1(sd_out[1]),
		.sd_out(sd_out[0]));
		
	sd_two_piece #(.POSTGAIN(2),
		.BITWIDTH(BITWIDTH),
		.RESETVAL(40'h0000000000))
	piece_1 (
		.clk(clk),
		.reset(reset),
		.kin1(kpos),
		.kin2(kneg),
		.muxin1(sd_out[0]),
		.sd_out(sd_out[1]));




endmodule



