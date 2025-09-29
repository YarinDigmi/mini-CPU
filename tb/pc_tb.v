`timescale 1ps/1ps
`default_nettype none

module pc_tb;

reg clk, areset, en, jump;
reg [7:0]jaddr;
wire [7:0]pc_value;

pc DUT(clk, areset, en, jump, jaddr, pc_value);

always #5 clk=~clk;

initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0,pc_tb);

    //Init
    clk=0; areset=1; en=1; jaddr=0; jump=0;
    #12 areset=0; en=1;

    //Increment
    #10 ;
    #10 ;
    #10 en=0;
    #10 en=1;

    //Jump
    #10 jump=1; jaddr=8'h1d;
    #10 jump=0; jaddr=8'hd0;

    //
    #10 jump=1; jaddr=8'hff;
    #10 ;
    #10 jump=0;

    #20 $finish;


end

endmodule
