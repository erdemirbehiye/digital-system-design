module step1(Clk,nReset,D1,D2,COut,CurState);

input Clk,nReset,D1,D2;
output [3:0]COut; 
reg [3:0]Count;
wire [1:0]DState;
output reg [2:0]CurState;

reg [2:0]NxtState;
reg [1:0]CountEn;//for forward,backward and stop

parameter S0=3'b000, S1=3'b010, S2=3'b011, S3=3'b001,	// forward 
		  S4=3'b101, S5=3'b111, S6=3'b110;  			// backward, intermediate states
assign DState[1] = D1; 		// sensor 1
assign DState[0] = D2;		// sensor 2

//============================================================================
//						Count number of car  
//============================================================================
always@(posedge Clk or negedge nReset)
begin
	if(nReset==1'b0)
		CurState[2:0]<= S0;  // initializing
	else
		begin
		CurState[2:0]<=NxtState[2:0]; //  assign Next state
			if(CountEn[1:0] == 2'b10 && NxtState[2:0] == S0 )  // if car passes through
				Count[3:0] <= Count[3:0] + 4'd1;			   // increase counter
			else if(CountEn[1:0] == 2'b01 && NxtState[2:0] == S0 )  // if car goes back 
				Count[3:0] <= Count[3:0] - 4'd1;					// decrease
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
	CountEn[1:0] = 2'b00;
		if(DState == 2'b10)		// check car direction for each state
			NxtState[2:0] = S1; // car goes forward  S0 => S2
		else if(DState == 2'b01)
			NxtState[2:0] = S4;	// car goes backward S0 => S4 (01)
		else
			NxtState[2:0] = S0; // stay idle
	end
	S1:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b11)
			NxtState[2:0] = S2;	// car goes forward  S1 => S2
		else if(DState == 2'b00)
			NxtState[2:0] = S0;	// car goes backward S1 => S0
		else
			NxtState[2:0] = S1;
	end
	S2:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b01)
			NxtState[2:0] = S3;	// car goes forward  S2 => S3
		else if(DState == 2'b10)
			NxtState[2:0] = S1;	// car goes backward  S2 => S1
		else
			NxtState[2:0] = S2;
	end
	S3:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b00)
			begin
			NxtState[2:0] = S0;	// car goes forward  S3 => S0  
			CountEn[1:0] = 2'b10; // car passed increase counter
			end
		else if(DState == 2'b11)
			NxtState[2:0] = S2;	// car goes backward  S3 => S2
		else
			begin
			NxtState[2:0] = S3;
			end
	end
	
	S4://101
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b00)
			NxtState[2:0] = S0;	 // car goes forwars  S4 => S0 (01) => (00)
		else if(DState == 2'b11)
			NxtState[2:0] = S5;	// car goes backward  S4 => S5  (01) => (11)
		else
			NxtState[2:0] = S4;
	end
	S5://111
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b01)
			NxtState[2:0] = S4;	// car goes forward  S5 => S4 (11) => (01)
		else if(DState == 2'b10)
			NxtState[2:0] = S6; // car goes backward S5 => S6 (11) => (10)
		else
			NxtState[2:0] = S5;
	end
	S6://101														
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b00)
			begin
			NxtState[2:0] = S0;	// car goes backward  S6 => S0 (01) => (00)
			CountEn[1:0] = 2'b01; // decrease counter
			end
		else if(DState == 2'b11)
			NxtState[2:0] = S5; // car goes forward  S6 => S5 (01) => (11)
		else
			begin
			NxtState[2:0] = S6;
			end
	end
	
	default:
		begin
		CountEn[1:0] = 2'b00;  // start with these conditions
		NxtState[2:0] = S0;
		end
endcase
end

assign COut[3:0] = Count[3:0];

endmodule
