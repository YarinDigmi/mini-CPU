module cpu(
    input clk, areset
);

wire [15:0]inst;
wire [7:0]pc_val, jaddr, res_alu, rout1, rout2, b, dout, wdata;
wire [2:0]raddr1, op_alu;
wire [1:0]alusrc;
wire wrtsrc, en_pc, jump, we_reg, z, en_ram, we_ram, rdsrc, pcsrc;

assign raddr1= (rdsrc) ? inst[9:7] : inst[12:10];
assign b= (alusrc==2'b00) ? rout2: (alusrc==2'b01) ? {{1{inst[6]}},inst[6:0]} : 8'b0;
assign wdata= (wrtsrc) ? dout : res_alu;
assign jaddr= (pcsrc) ? inst[12:5] : inst[9:2];

alu alu0(
    .a(rout1),
    .b(b),
    .areset(areset),
    .op(op_alu),
    .result(res_alu),
    .cf(),
    .ovf(),
    .z(z),
    .neg()
    );

controller cont0(
    .main_op(inst[15:13]),
    .alu_in(inst[3:0]),
    .zero(z),
    .alu_out(op_alu),
    .alusrc(alusrc),
    .en_pc(en_pc),
    .jump(jump),
    .we_reg(we_reg),
    .en_ram(en_ram),
    .we_ram(we_ram),
    .wrtsrc(wrtsrc),
    .rdsrc(rdsrc),
    .pcsrc(pcsrc)
);

instr_rom inst0(
    .addr(pc_val),
    .instr(inst)
    );

pc pc0(
    .clk(clk),
    .areset(areset),
    .en(en_pc),
    .jump(jump),
    .jaddr(jaddr),
    .pc_value(pc_val)
    );

ram ram0(
    .clk(clk),
    .areset(areset),
    .en(en_ram),
    .we(we_ram),
    .addr(inst[9:6]),
    .din(res_alu),
    .dout(dout)
    );

regfile rf0(
    .clk(clk),
    .areset(areset),
    .we(we_reg),
    .raddr1(raddr1),
    .raddr2(inst[6:4]),
    .waddr(inst[12:10]),
    .wdata(wdata),
    .rout1(rout1),
    .rout2(rout2)
    );

endmodule
