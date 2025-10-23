`default_nettype none
`timescale 1ps/1ps

module ram_tb;

reg clk, areset, en, we;
reg [3:0] addr;
reg [7:0]din;
wire [7:0]dout;

ram DUT(clk, areset, en, we, addr, din, dout);

always #5 clk=~clk;

initial begin
    $dumpfile("ram.vcd");
    $dumpvars(0,ram_tb);

    //start values
    clk=0;
    areset=1;
    en=0; we=0; addr=0; din=0;

    #12 areset=0; en=1; we=1;

    //writing
    #10 addr=0; din=8'hff;
    #10 addr=1; din=8'h12;
    #10 addr=9; din=8'hc0;

    //reading
    #10 we=0; addr=1;
    #10 addr=3;
    #10 addr=9;

    //writing again
    #10 we=1; addr=5; din=8'ha4;

    //en=0
    #10 en=0; addr=6; din=8'h1d;
    #10 we=0; addr=6;
    #10 addr=1;
    #10 en=1; addr=6;

    //reset
    #10 areset=1;
    #10 areset=0; en=1; addr=3;
    #10 addr=5;

    #20 $finish;


end



endmodule
