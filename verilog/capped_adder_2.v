module capped_adder_2#(parameter BITWIDTH=32) (a, b, out);
	localparam smallBW = BITWIDTH-1;
	input [BITWIDTH-1:0] a, b;
	output [BITWIDTH-1:0] out;
	wire [BITWIDTH:0] tempsum;
	wire overflow;
	wire signcheck;
	
	assign signcheck = !(a[BITWIDTH-1] ^ b[BITWIDTH-1]);
	assign tempsum = a + b;
	always@(*)
		case(tempsum[BITWIDTH:BITWIDTH-1])
			2'b01 : out = {1'b0, {smallBW{1'b1}}};
			2'b10 : out = {1'b1, {smallBW{1'b0}}};
			default : out = tempsum;
		endcase
	// assign overflow = tempsum[BITWIDTH] ^ tempsum[BITWIDTH-1];
	
	// assign out = (!(overflow&signcheck)) ? tempsum[BITWIDTH-1:0] : ((a[BITWIDTH-1]) ? {1'b1, {smallBW{1'b0}} } :{1'b0, {smallBW{1'b1}}});
	// assign out = (!(overflow&signcheck)) ? tempsum[BITWIDTH-1:0] : a[BITWIDTH-1] ? {BITWIDTH{1'b0}} : {BITWIDTH{1'b1}};


endmodule