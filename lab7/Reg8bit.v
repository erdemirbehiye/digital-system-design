module Reg8bit(Clk,Sel,RnW,Dio);
input Clk;	// clock input to trigger register storage
input Sel;	// select input that enables read/write operations
input RnW;	// read/write control input
			// 0=> store data input at Dio[7:0] if Sel is 1
			// 1=> enable output to Dio[7:0] if Sel is 1
inout [7:0] Dio;	// connection for data input and output
reg [7:0] FF;		// storage register

always @(posedge Clk)
	begin
		if (Sel == 1'b1)
			FF[7:0] <= Dio[7:0];
		else
			FF[7:0] <= FF[7:0];
	end
		
assign Dio[7:0] = (RnW == 1'b1 && Sel == 1'b1) ? FF[7:0] : 8'bZ;

endmodule
