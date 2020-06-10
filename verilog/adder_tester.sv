module adder_tester();
reg [2:0] a, b;
wire [2:0] sum;

initial begin
	a <= 3'b000;
	forever begin
		#5;
		a <= a + 1;
	end

end

initial begin
	b <= 3'b000;
	forever begin
		#40;
		b <= b + 1;
	end
end


capped_adder #(.BITWIDTH(3)) add_1 (a, b, sum);
endmodule 