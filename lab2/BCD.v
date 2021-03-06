module BCD(Reset,Clk, CntEn,Count,NextEn);
 input Clk;
 input Reset; 
 input CntEn;
 output reg [3:0]Count; 
 output NextEn;
 assign NextEn = (Count[3] & ~Count[2] & ~Count[1] & Count[0]);
 
   always @(posedge Clk or negedge Reset) 
   
	begin
      
	     if (Reset==1'b0)//the reset is active
	          Count[3:0] <= 4'b0; //reset the counter 
	          
	     else 
				if(CntEn==1'b1) 
				    if(NextEn==0) //until nextEn is equal 1
		      		   Count[3:0] <= Count[3:0]+4'b0001; //increment
		      	    else
		      	       Count[3:0] <= 4'b0;//counter is idle
				
				else//when Count enable is 0
					 Count[3:0] <= Count[3:0];//idle
					 
	end

	
endmodule