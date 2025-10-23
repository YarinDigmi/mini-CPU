module alu(
    input signed [7:0]a,b,
    input areset,
    input [2:0]op,
    output reg signed [7:0] result,
    output reg cf, ovf,
    output z, neg
);

localparam ADDU=0,SUBU=1,ADDS=2,SUBS=3,AND=4,OR=5,XOR=6,SLL=7;

wire [7:0] add_res=$signed(a)+$signed(b);
wire [7:0] sub_res=$signed(a)-$signed(b);

always @(*)begin
  if(areset) begin
    result=8'd0;
    cf=1'b0;
    ovf=1'b0;
  end
  else begin
        result=8'd0;
        cf=1'b0;
        ovf=1'b0;
    case(op)
        ADDU: begin
            {cf,result}={1'b0,a}+{1'b0,b};
         end
        SUBU: begin
            result=a-b;
            if(a>=b) cf=1'b1;
         end
        ADDS:begin
            result=add_res;
            ovf=(a[7]==b[7])&&(add_res[7]!=a[7]);
        end
        SUBS:begin
            result=sub_res;
            ovf=(a[7]!=b[7])&&(sub_res[7]!=a[7]);
        end
        AND: result=a&b;
        OR: result=a|b;
        XOR: result=a^b;
        SLL:begin
            result=a<<1;
            cf=a[7];
        end
        default: begin
            result=8'd0;
            cf=1'b0;
            ovf=1'b0;
        end


    endcase
  end
end

assign neg=result[7];
assign z=!result;

endmodule
