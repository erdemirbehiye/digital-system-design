module Lab6_2(Clk,nReset,D1,D2,COut,CurState);

input Clk,nReset,D1,D2;
output [3:0]CurState;// 4 bit for 5 state
output [3:0]COut;
reg [3:0]Count;

wire[1:0]DState;
reg [3:0]CurState;   
reg [3:0]NxtState;
reg CountEn;

parameter S0 = 4'b0000 //00
		, S1 = 4'b0001 //10
		, S2 = 4'b0010 //11
		, S3 = 4'b0100 //01
		, S4 = 4'b1000;	// 00,S0 ;to enable the counter
		
assign DState[1] = D1; 		// sensor 1
assign DState[0] = D2;		// sensor 2

//============================================================================
//						Count number of car  
//============================================================================
always@(posedge Clk or negedge nReset)
begin
	if(nReset==1'b0)
		CurState<= S0;  // initializing
	else
		begin
		CurState<=NxtState;			//  assign Next state
			if(CountEn == 1)  		// if car passes through
				Count[3:0] <= Count[3:0] + 4'd1;		// increase counter
			else
				Count[3:0] <= Count[3:0];				// else stay idle
		end
end

//============================================================================
//						Check position of car  
//============================================================================
always @(DState or CurState)
begin
case(CurState) 
	S0: // if sensors at beginning state
	begin
	CountEn = 0;
		if(DState == 2'b10)		// check car direction for each state
			NxtState = S1; // car goes forward  S0 => S2
		else if(DState == 2'b01)
			NxtState = S3;	// car goes backward S0 => S4 (01)
		else
			NxtState = S0; // stay idle
	end
	S1:
	begin
	CountEn = 0;
		if(DState == 2'b11)
			NxtState = S2;	// car goes forward  S1 => S2
		else if(DState == 2'b00)
			NxtState = S0;	// car goes backward S1 => S0
		else
			NxtState = S1;
	end
	S2:
	begin
	CountEn = 0;
		if(DState == 2'b01)
			NxtState = S3;	// car goes forward  S2 => S3
		else if(DState == 2'b10)
			NxtState = S1;	// car goes backward  S2 => S1
		else
			NxtState = S2;
	end
	S3:
	begin
	CountEn = 0;
		if(DState == 2'b00)
			begin
			NxtState = S4;	// car goes forward  S3 => S4  
			CountEn = 1; // car passed, increase counter
			end
		else if(DState == 2'b11)
			NxtState = S2;	// car goes backward  S3 => S2
		else
			begin
			NxtState = S3;
			end
	end
	
	S4:
	begin
	CountEn = 0;
		if(DState == 2'b00)
			NxtState = S0;	// car goes backward  S4 => S0 
		else if(DState == 2'b01)
			NxtState = S3;	// car goes forward  S4 => S3 
		else
			NxtState = S4; //S0
	end

	default:
		begin
		CountEn = 0;  // start with these conditions
		NxtState = S0;
		end
endcase
end

assign COut[3:0] = Count[3:0];

endmodule
