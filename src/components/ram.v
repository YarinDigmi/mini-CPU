module ram(
    input clk, areset, en, we,
    input [3:0] addr,
    input [7:0]din,
    output reg [7:0]dout
);

reg [7:0]mem[0:15];
integer i;

always @(posedge clk or posedge areset)begin
    if(areset)begin
        for(i=0;i<16;i++) mem[i]<=8'd0;
        dout<=8'd0;
    end
    else begin
        if(en)begin
            case(we)
            1'b0: dout<=mem[addr];
            1'b1: mem[addr]<=din;
            endcase
        end
    end
end


endmodule
