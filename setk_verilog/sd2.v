module sd2 #(parameter BW = 32, parameter RESETVAL = 0) (clk, reset, sd_in, bs_out);

// input bitwidth
// parameter BW = 32;

input clk, reset;
input signed [BW-1:0] sd_in;    // sd input
output bs_out;                  // bitstream output

wire signed [BW-1:0] feedback;  // feedback signal

reg signed [BW+1:0] sd_reg1;
reg signed [BW+1:0] sd_reg2;

initial begin 
sd_reg1 = 0;
sd_reg2 = 0;
end

// logic assignments
assign bs_out = sd_reg1[BW+1] ? 0 : 1;
assign feedback = sd_reg1[BW+1] ? -(2**(BW-1)) : (2**(BW-1) - 1);

// register update logic
always@(posedge clk) begin
	sd_reg1 <= (reset) ? RESETVAL : sd_reg1 + sd_reg2 + sd_in - (feedback <<< 1);
	sd_reg2 <= (reset) ? RESETVAL : sd_reg2 + sd_in - feedback;
end

endmodule
