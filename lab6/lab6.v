module Lab6(Clk,nReset,D1,D2,COut);

input Clk,nReset,D1,D2;
output [3:0]COut;
reg [3:0]Count;

wire [1:0]DState;
reg [2:0]CurState;
reg [2:0]NxtState;
reg [1:0]CountEn;
parameter S0=3'b000, S1=3'b010, S2=3'b011, S3=3'b001, S4=3'b101, S5=3'b111, S6=3'b110;
assign DState[1] = D1;
assign DState[0] = D2;

always@(posedge Clk or negedge nReset)
begin
	if(nReset==1'b0)
		CurState[2:0]<= S0;
	else
		begin
		CurState[2:0]<=NxtState[2:0];
			if(CountEn[1:0] == 2'b10 && NxtState[2:0] == S0 )
				Count[3:0] <= Count[3:0] + 4'd1;
			else if(CountEn[1:0] == 2'b01 && NxtState[2:0] == S0 )
				Count[3:0] <= Count[3:0] - 4'd1;
			else
				Count[3:0] <= Count[3:0];
		end
end

always @(DState or CurState or CountEn)
begin
case(CurState)
	S0:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b10)
			NxtState[2:0] = S1;
		else if(DState == 2'b01)
			NxtState[2:0] = S4;
		else
			NxtState[2:0] = S0;
	end
	S1:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b11)
			NxtState[2:0] = S2;
		else if(DState == 2'b00)
			NxtState[2:0] = S0;
		else
			NxtState[2:0] = S1;
	end
	S2:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b01)
			NxtState[2:0] = S3;
		else if(DState == 2'b10)
			NxtState[2:0] = S1;
		else
			NxtState[2:0] = S2;
	end
	S3:
	begin
		if(DState == 2'b00)
			begin
			NxtState[2:0] = S0;
			CountEn[1:0] = 2'b10;
			end
		else if(DState == 2'b11)
			NxtState[2:0] = S2;
		else
			begin
			NxtState[2:0] = S3;
			end
	end
	
	S4:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b00)
			NxtState[2:0] = S0;
		else if(DState == 2'b11)
			NxtState[2:0] = S5;
		else
			NxtState[2:0] = S4;
	end
	S5:
	begin
	CountEn[1:0] = 2'b00;
		if(DState == 2'b01)
			NxtState[2:0] = S4;
		else if(DState == 2'b10)
			NxtState[2:0] = S6;
		else
			NxtState[2:0] = S5;
	end
	S6:														//S6
	begin
		if(DState == 2'b00)
			begin
			NxtState[2:0] = S0;
			CountEn[1:0] = 2'b01;
			end
		else if(DState == 2'b11)
			NxtState[2:0] = S5;
		else
			begin
			NxtState[2:0] = S6;
			end
	end
	
	default:
		begin
		CountEn[1:0] = 2'b00;
		NxtState[2:0] = S0;
		end
endcase
end

assign COut[3:0] = Count[3:0];

endmodule