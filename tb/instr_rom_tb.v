`timescale 1ps/1ps
`default_nettype none

module instr_rom_tb;

reg [7:0]addr;
wire [15:0]instr;

instr_rom DUT(addr, instr);

initial begin
    $dumpfile("instr_rom.vcd");
    $dumpvars(0,instr_rom_tb);

    addr=0;
    #10 addr=1;
    #10 addr=2;
    #10 addr=3;
    #10 addr=7;
    #10 addr=13;
    #10 addr=19;
    #10 addr=30;

    #20 $finish;

end

endmodule
