`timescale 1ps/1ps
`default_nettype none

module controller_tb;

reg [2:0]main_op;
reg [3:0]alu_in;
reg zero;
wire [2:0]alu_out;
wire [1:0] alusrc;
wire en_pc, jump, we_reg, en_ram, we_ram, wrtsrc, rdsrc, pcsrc;

controller DUT(main_op, alu_in, zero, alu_out, alusrc, en_pc, jump,
we_reg, en_ram, we_ram, wrtsrc, rdsrc, pcsrc);

initial begin
    $dumpfile("controller.vcd");
    $dumpvars(0,controller_tb);

    //Init
    en_pc=1'b0;
    jump=1'b0;
    we_reg=1'b0;
    alu_out=3'b0;
    en_ram=1'b0;
    we_ram=1'b0;
    wrtsrc=1'b0;
    rdsrc=1'b0;
    alusrc=2'b0;
    pcsrc=1'b0;

    //R-type
    #2 main_op=3'd0; alu_in=4'd0; zero=1'd0;

    #2 alu_in=4'd1;
    #2 alu_in=4'd2;
    #2 alu_in=4'd3;
    #2 alu_in=4'd4;
    #2 alu_in=4'd5;

    //Rest
    #2 main_op=3'd1;
    #2 main_op=3'd2;
    #2 main_op=3'd3;
    #2 main_op=3'd4;
    #2 main_op=3'd5;
    #2 main_op=3'd6;
    #2 main_op=3'd7;

end



endmodule
