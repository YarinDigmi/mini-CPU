module instr_rom(
    input [7:0]addr,
    output [15:0]instr
);

reg [15:0]imem[0:255];

initial begin
    $readmemb("program.mem.txt", imem);
end

assign instr=imem[addr];

endmodule
