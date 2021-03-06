 module rx(SCin, SDin, PDout, PDready,ParError);
input SCin;			// clock input, SDin is valid at the rising clock edge
input SDin;			// serial data input
output [7:0] PDout;	// parallel output
output PDready;		// output validnesswire parcheck
output reg ParError;//parity error
reg [8:0] temp;		// storage unit
reg [3:0] Counter;	// counter
reg control;		// storage control
 

// Data control part
always @(posedge SCin)
	begin
		if ( (SDin == 1'b1) && (Counter [3:0] == 4'b0) )	// new serial incoming data 
			control <= 1'b1;								// set 1 when data is coming
		else
			if (Counter[3:0] == 4'd8)						// all incoming data is arrived
				control <= 1'b0;							// no incoming data
			else
				control <= control;							// incoming data control is idle
	end
	
// Counter Part to control SDin flow
always @(posedge SCin)
	begin
		if (control == 1'b0)								// no incoming data
			Counter [3:0] <= 4'b0;							// clear the counter
		else
			Counter [3:0] <= Counter [3:0] + 4'b1;			// increment the counter by 1 when data is coming
	end

// Serial to Parallel Shifting
always @(posedge SCin)
	begin
		if (control == 1'b1)								// incoming data state
			begin
				temp [8:1] <= temp[7:0];						//	shift the data stored
				temp [0] <= SDin;								//	store the first data coming
			end
		else
			temp [8:0] <= temp [8:0];							// storage idle
	end

//Parity Control 
always @(posedge SCin)
	begin
		if (Counter[3:0]== 4'd8)
			if(SDin ==(^PDout[7:0]))
				ParError<=1'b0; //if input and parity match
			else
				ParError<=1'b1;
			
	end

assign PDout [7:0] = temp [8:1];
assign PDready = (Counter [3:0] == 4'd9) ? 1'b1 : 1'b0; 
endmodule
