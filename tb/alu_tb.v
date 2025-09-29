`timescale 1ps/1ps
module alu_tb;


reg signed [7:0]a,b;
reg clk, areset;
reg [2:0]op;
wire signed [7:0] result;
wire cf, ovf,z,neg;

alu DUT(a,b,clk,areset,op,result,cf,ovf,z,neg);

always #5 clk=~clk;

initial begin
$dumpfile("alu.vcd");
$dumpvars(0,alu_tb);

//start values
clk=0;
areset=1;
a=0;b=0;op=0;

#12 areset=0;

//ADDU
#10 op=0; a=8'd12; b=8'd7; //12+7=19
#10 op=0; a=8'hff; b=8'd1; //cf=1
//SUBU
#10 op=1; a=8'd120; b=8'd50; //120-50=70
#10 op=1; a=8'd50; b=8'd120; //cf=1
//ADDS
#10 op=2; a=8'd127; b=8'd1; //ovf=1
#10 op=2; a= -11; b= -14; // -11 + -14 = -25
//SUBS
#10 op=3; a= -100; b= 100; // ovf=1
#10 op=3; a= -43; b=10; //-43-10=-53
//LOGIC
#10 op=4; a=8'b10011011; b=8'b01010111; //AND
#10 op=5; a=8'b10011011; b=8'b01010111; //OR
#10 op=6; a=8'b10011011; b=8'b01010111; //XOR
#10 op=7; a=8'b11110000; b=8'hff; //SLL


#20 $finish;

end

endmodule
