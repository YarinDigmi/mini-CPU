module controller(
    input [2:0]main_op,
    input [3:0]alu_in,
    input zero,
    output reg [2:0]alu_out,
    output reg [1:0] alusrc,
    output reg en_pc, jump, we_reg, en_ram, we_ram, wrtsrc, rdsrc, pcsrc
);

parameter RTYPE=0, ITYPE=1, LOAD=2, STORE=3, JUMP=4, BEZ=5, BNEZ=6;
parameter ADD=0, SUB=1, AND=2, OR=3, XOR=4;
always @(*)begin
    case(main_op)
    RTYPE:begin
        en_pc=1'b1;
        jump=1'b0;
        we_reg=1'b1;
        case(alu_in)
            ADD:alu_out=3'd0;
            SUB:alu_out=3'd1;
            AND:alu_out=3'd4;
            OR:alu_out=3'd5;
            XOR:alu_out=3'd6;
            default:alu_out=3'd0;
        endcase
        en_ram=1'b0;
        we_ram=1'b0;
        wrtsrc=1'b0;
        rdsrc=1'b1;
        alusrc=2'b0;
        pcsrc=1'bx;
    end
    ITYPE:begin
        en_pc=1'b1;
        jump=1'b0;
        we_reg=1'b1;
        alu_out=3'b0;
        en_ram=1'b0;
        we_ram=1'b0;
        wrtsrc=1'b0;
        rdsrc=1'b1;
        alusrc=2'b01;
        pcsrc=1'bx;
    end
    LOAD:begin
        en_pc=1'b1;
        jump=1'b0;
        we_reg=1'b1;
        alu_out=3'bxxx;
        en_ram=1'b1;
        we_ram=1'b0;
        wrtsrc=1'b1;
        rdsrc=1'bx;
        alusrc=2'bxx;
        pcsrc=1'bx;
    end
    STORE:begin
        en_pc=1'b1;
        jump=1'b0;
        we_reg=1'b0;
        alu_out=3'b0;
        en_ram=1'b1;
        we_ram=1'b1;
        wrtsrc=1'bx;
        rdsrc=1'b0;
        alusrc=2'b10;
        pcsrc=1'bx;
    end
    JUMP:begin
        en_pc=1'b1;
        jump=1'b1;
        we_reg=1'b0;
        alu_out=3'bxxx;
        en_ram=1'b0;
        we_ram=1'bx;
        wrtsrc=1'bx;
        rdsrc=1'bx;
        alusrc=2'bxx;
        pcsrc=1'b1;
    end
    BEZ:begin
        en_pc=1'b1;
        jump=zero;
        we_reg=1'b0;
        alu_out=3'b0;
        en_ram=1'b0;
        we_ram=1'bx;
        wrtsrc=1'bx;
        rdsrc=1'b0;
        alusrc=2'b10;
        pcsrc=1'b0;
    end
    BNEZ:begin
        en_pc=1'b1;
        jump=~zero;
        we_reg=1'b0;
        alu_out=3'b0;
        en_ram=1'b0;
        we_ram=1'bx;
        wrtsrc=1'bx;
        rdsrc=1'b0;
        alusrc=2'b10;
        pcsrc=1'b0;
    end
    default:begin
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
    end
    endcase
end

endmodule
