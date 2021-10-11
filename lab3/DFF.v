module DFF (clock, sel, out);
 input clock,sel;
 reg out;
	always@(posedge clock)
		begin
			out<=sel;
		end

endmodule