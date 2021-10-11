module bit_3Counter(counters,Clk, Reset);
	
 //variables of the module
 input Clk;// input clock
 input Reset; // asynchronous reset
 output reg [2:0]counters; // registered nodes to store value
 
 //the behaviour of registered nodes
   always @(posedge Clk or negedge Reset) 
   
      begin
      
	     if (Reset==1'b0) // when reset is 0
	          counters[2:0]=3'b0; //reset the counter
	          
	     else  //when reset is 1
	          /* the array of 3 bits treated as a single numeric value,
		      The counter is incremented by 1
		      */
		      counters[2:0]<=counters[2:0]+3'b1; 
		     
      end
 
	
endmodule