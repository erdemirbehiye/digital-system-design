module top(Clock, Send, PDataIn,clockout, PDataOut, Pready);
input Clock, Send;
input [7:0] PDataIn;
output Pready,clockout;
output [7:0] PDataOut;

wire SData, Clock;

tx tra(Clock,Send,PDataIn,clockout,SData);
rx rec(Clock,SData,PDataOut,Pready);

endmodule