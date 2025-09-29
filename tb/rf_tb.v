`timescale 1ns/1ns

module rf_tb;

    reg clk, areset, we;
    reg [2:0] raddr1, raddr2, waddr;
    reg [7:0] wdata;
    wire [7:0] rout1, rout2;

    regfile DUT (clk, areset, we, raddr1, raddr2, waddr, wdata, rout1, rout2);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("rf.vcd");
        $dumpvars(0, rf_tb);

        // Init
        clk = 0; areset = 1; we = 0;
        raddr1 = 0; raddr2 = 0; waddr = 0; wdata = 0;

        // Reset
        #12 areset = 0;

        // Writing
        @(posedge clk);
        we = 1; waddr = 3; wdata = 8'hAA;
        @(posedge clk);
        we = 1; waddr = 5; wdata = 8'h55;
        @(posedge clk);
        we = 0;

        // Double reading
        raddr1 = 3; raddr2 = 5;

        // Writing & Reading
        @(posedge clk);
        we = 1; waddr = 2; wdata = 8'hF0;
        raddr1 = 2; raddr2 = 3;
        @(posedge clk);
        we = 0;


        // Reset
        @(posedge clk);
        areset = 1;
        @(posedge clk);
        areset = 0;
        raddr1 = 3; raddr2 = 5;

        //Writing with we=0
        #12 wdata=8'hab; waddr=2;
        #10 raddr1=2;

        #20 $finish;
    end

endmodule
