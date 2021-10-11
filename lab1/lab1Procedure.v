module lab1Procedure(Output,Sel,Clk,Reset);

 input Clk;
 input Reset;
 input Sel;
 output Output;
 wire [0:2]out;
 
 //top level module
 bit_3Counter count(out,Clk,Reset);
 ANDXOR LogicFunction(Output,out[0],out[2],Sel);
 
endmodule