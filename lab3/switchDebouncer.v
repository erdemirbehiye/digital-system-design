module switchDebouncer(clock,button,SwOut);
 input clock,button;
 output reg SwOut;
 wire [5:0] forShiftReg;
 wire Decision;

 shiftReg sR(clock,button,forShiftReg);
 
 assign Decision= forShiftReg[0]&forShiftReg[1]&forShiftReg[2]&forShiftReg[3]&forShiftReg[4]&forShiftReg[5];
 
	always@(posedge clock)
	begin 
		SwOut<=Decision;
	end
 
 endmodule