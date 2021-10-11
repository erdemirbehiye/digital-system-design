module tx(Clk,Send,PDin,SCout,SDout);
input Clk;
input Send;
input [7:0] PDin; //8 bit data unit
output SCout;
output SDout;//serial data output

reg [7:0] temp;		// temporary data unit
reg serial_out;		// data transmission 


always @(posedge Clk)
begin
	if (Send == 1'b1)//if data is valid			
		begin
			temp [7:0] <= PDin [7:0];	// store the data for transmiting
			serial_out <= 1'b1;			// assign start condition
		end
	else   //  transmitting paralel data on serial way
		begin
			temp[7:1] <= temp[6:0];		// shift the data 
			temp[0] <= 1'b0;			// clear the storage
			serial_out <= temp[7];		//transmission
		end
end

assign SCout = Clk;
assign SDout = serial_out;
 
endmodule