module shiftReg (clock, sel, out);
 input clock,sel;
 output reg [5:0]out;
	always@(posedge clock)
		begin
			out[5:1]<=out[4:0];
			out[0]<=sel;
		end

endmodule