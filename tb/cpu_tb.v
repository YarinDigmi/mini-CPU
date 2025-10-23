`timescale 1ns/1ps

module cpu_tb;

  reg clk, areset;

  cpu DUT (
    .clk   (clk),
    .areset(areset)
  );

  // ----- ALIASES FOR RAM -----
wire [7:0] RAM0  = DUT.ram0.mem[0];
wire [7:0] RAM1  = DUT.ram0.mem[1];
wire [7:0] RAM2  = DUT.ram0.mem[2];
wire [7:0] RAM3  = DUT.ram0.mem[3];
wire [7:0] RAM4  = DUT.ram0.mem[4];
wire [7:0] RAM5  = DUT.ram0.mem[5];
wire [7:0] RAM6  = DUT.ram0.mem[6];
wire [7:0] RAM7  = DUT.ram0.mem[7];
wire [7:0] RAM8  = DUT.ram0.mem[8];
wire [7:0] RAM9  = DUT.ram0.mem[9];
wire [7:0] RAM10 = DUT.ram0.mem[10];
wire [7:0] RAM11 = DUT.ram0.mem[11];
wire [7:0] RAM12 = DUT.ram0.mem[12];
wire [7:0] RAM13 = DUT.ram0.mem[13];
wire [7:0] RAM14 = DUT.ram0.mem[14];
wire [7:0] RAM15 = DUT.ram0.mem[15];

// ----- ALIASES FOR REGFILE -----
wire [7:0] R0 = DUT.rf0.mem[0];
wire [7:0] R1 = DUT.rf0.mem[1];
wire [7:0] R2 = DUT.rf0.mem[2];
wire [7:0] R3 = DUT.rf0.mem[3];
wire [7:0] R4 = DUT.rf0.mem[4];
wire [7:0] R5 = DUT.rf0.mem[5];
wire [7:0] R6 = DUT.rf0.mem[6];
wire [7:0] R7 = DUT.rf0.mem[7];

  always #5 clk = ~clk;

  always @(posedge clk) begin
    $display("[%0t] PC=%0d  INSTR=%016b", $time, DUT.pc_val, DUT.inst);
  end

  integer i;

  initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, cpu_tb);

    clk    = 1'b0;
    areset = 1'b1;

    for (i = 0; i < 16; i = i + 1) DUT.ram0.mem[i] = 8'h00;

    #20 areset = 1'b0;

    repeat (36) @(posedge clk);

    $display("\n==== RAM dump ====");
    for (i = 0; i < 16; i = i + 1)
      $display("RAM[%0d] = 0x%02h", i, DUT.ram0.mem[i]);

    $display("\n==== RegFile dump ====");
    for (i = 0; i < 8; i = i + 1)
      $display("R[%0d] = 0x%02h", i, DUT.rf0.mem[i]);



    #20 $finish;
  end

endmodule
