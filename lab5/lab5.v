module lab5 (Clk,Send_long,PDin1,SDout1,SCout1,Send_async,PDin2,SDout2,
    SCout2,Send,PDin3,SDout3,SCout3,SDout4,PDout,PDready,ParErr);


//--------------------------------------------------------------------
input Clk;   // 20 MHz Clock wave
input Send_long;  // send signal must be one clock cycle
input [7:0]PDin1; 
output SDout1;		// Serial data out
output SCout1;		// Serial clock out

//	Long Send signal
tx tx1 (Clk, Send_long, PDin1, SCout1, SDout1) ; 


//--------------------------------------------------------------------

input Send_async;	// send signal must be one clock cycle
input [7:0]PDin2; 
output SDout2;		// Serial data out
output SCout2;		// Serial clock out

//	Asyncronous Send signal
tx tx2 (Clk, Send_async, PDin2, SCout2, SDout2) ; 	


//--------------------------------------------------------------------
input Send;	// send signal must be one clock cycle
input [7:0]PDin3; 	// paralel data input
output SCout3;
output SDout3;
wire SCout3,SDout3;

tx tx (Clk,Send,PDin3,SCout3,SDout3);

//--------------------------------------------------------------------
input SDout4;
output ParErr;
output [7:0]PDout;	// paralel data output
output PDready;		// paralel data ready

rx rx1 (Clk,SDout3,PDout,PDready,ParErr);

endmodule

