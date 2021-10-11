module top(Clock, Send_long,PDataIn,clockout,SData,Send_async,PDataIn2,SData2,clockout2,Send,PDataIn3,SData3,clockout3,SData4,
ParError,PDout,Pready);
input Clock, Send_long;
input [7:0] PDataIn;
output clockout,SData;
//long send
tx tra(Clock,Send_long,PDataIn,clockout,SData);

input Send_async;
input [7:0] PDataIn2;
output SData2,clockout2;
//async send signal
tx tra2 (Clock,Send_async,PDataIn2,clockout2,SData2);
 
input Send;
input [7:0] PDataIn3;
output SData3,clockout3;
wire SData3;
wire clockout3;
tx tra3(Clock,Send,PDataIn3,clockout3,SData3);

input SData4;
output ParError;
output [7:0] PDout; //parallel data output
output Pready;
rx rec(Clock,SData4,PDout,Pready,ParError);

endmodule