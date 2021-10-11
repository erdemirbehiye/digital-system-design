module ANDXOR (Output, In0, In1, Sel);

 output Output;
 input In0, In1, Sel;
 wire Output;
 
 //if Sel=0 => AND, if Sel=1 => XOR
 assign Output = (Sel == 1'b0) ? In0&In1 : In0^In1;
 
endmodule
