module regfile(
    input clk, areset, we,
    input [2:0] raddr1,raddr2,waddr,
    input [7:0] wdata,
    output [7:0] rout1, rout2
);

reg [7:0]mem[0:7];
integer i;

always @(posedge clk or posedge areset)begin
    if(areset)begin
        for(i=0;i<8;i++) mem[i]<=8'd0;
    end
    else begin
        if(we) begin
            mem[waddr]<=wdata;
            rout1<=mem[raddr1];
            rout2<=mem[raddr2];
        end
    end
end


endmodule
