module topmodule(Rst, Clk, Cen, Co1, Co10, Co100);
input Rst;
input Clk;
input Cen;
output [3:0] Co1;
output [3:0] Co10;
output [3:0] Co100;

wire NextEn1, NextEn10,NextEn100;

BCD bcd1(Rst, Clk, Cen, Co1, NextEn1);
BCD bcd10(Rst, Clk, Cen&NextEn1, Co10, NextEn10);
BCD bcd100(Rst, Clk, Cen&NextEn1&NextEn10, Co100, NextEn100);

endmodule