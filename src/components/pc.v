module pc(
    input clk, areset, en, jump,
    input [7:0]jaddr,
    output reg [7:0]pc_value
);

always @(posedge clk or posedge areset)begin
    if(areset) pc_value<=8'd0;
    else if(en)begin
        if(jump) pc_value<=jaddr;
        else pc_value<=pc_value+8'd1;
    end
end

endmodule
