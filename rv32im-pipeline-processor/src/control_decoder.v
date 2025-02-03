module control_decoder (
    input wire [2:0] fun3,
    input wire [6:0]fun7,
    input wire i_type,
    input wire r_type,
    input wire load,
    input wire store,
    input wire branch,
    input wire jal,
    input wire jalr,
    input wire lui,
    input wire auipc,
    input wire load_control,

    output reg Load,
    output reg Store,
    output reg jalr_out,
    output reg [1:0] mem_to_reg,
    output reg reg_write,
    output reg mem_en,
    output reg operand_b,
    output reg operand_a,
    output reg [2:0]imm_sel,
    output reg Branch,
    output reg next_sel,
    output reg [4:0]alu_control
);
wire fun_7 = fun7[5];

always @(*) begin
    //reg write signal for register file
    reg_write = r_type | i_type | load | jal | jalr | lui | auipc | load_control;
    //operand a select for first input of alu
    operand_a = branch | jal | auipc;
    //operand b signal for second input of alu
    operand_b = i_type | load | store | branch | jal | jalr | lui | auipc;
    //load
    Load = load;
    //store
    Store = store;
    //branch
    Branch =  branch;
    //selection for next address if any jump instrucion run
    next_sel = jal;
    jalr_out = jalr;
    //mem enable
    mem_en = store;

    if(r_type)begin //rtype
        mem_to_reg = 2'b00;
        if(fun3==3'b000 & fun7==0000000)begin
            alu_control = 5'b00000;
        end
        else if(fun3==3'b000 & fun7==7'b0100000)begin
            alu_control = 5'b00001;
        end
        else if (fun3==3'b001 & fun7==7'b0000000)begin
            alu_control = 5'b00010;
        end
        else if (fun3==3'b010 & fun7==7'b0000000)begin
            alu_control = 5'b00011;
        end
        else if (fun3==3'b011 & fun7==7'b0000000)begin
            alu_control = 5'b00100;
        end
        else if (fun3==3'b100 & fun7==7'b0000000)begin
            alu_control = 5'b00101;
        end
        else if (fun3==3'b101 & fun7==7'b0000000)begin
            alu_control = 5'b00110;
        end
        else if (fun3==3'b101 & fun7==7'b0100000)begin
            alu_control = 5'b00111;
        end
        else if (fun3==3'b110 & fun7==7'b0000000)begin
            alu_control = 5'b01000;
        end
        else if (fun3==3'b111 & fun7==7'b0000000)begin
            alu_control = 5'b01001;
        end
        //--------M-Extension------------//
        else if (fun3==3'b000 & fun7==7'b0000001)begin
            alu_control = 5'b10000;
        end
        else if (fun3==3'b001 & fun7==7'b0000001)begin
            alu_control = 5'b10001;
        end
        else if (fun3==3'b010 & fun7==7'b0000001)begin
            alu_control = 5'b10010;
        end
        else if (fun3==3'b011 & fun7==7'b0000001)begin
            alu_control = 5'b10011;
        end
        else if (fun3==3'b100 & fun7==0000001)begin
            alu_control = 5'b10100;
        end
        else if (fun3==3'b101 & fun7==7'b0000001)begin
            alu_control = 5'b10101;
        end
        else if (fun3==3'b110 & fun7==7'b0000001)begin
            alu_control = 5'b10110;
        end
        else if (fun3==3'b111 & fun7==7'b0000001)begin
            alu_control = 5'b10111;
        end
    end
    else if (i_type)begin //itype
        imm_sel = 3'b000; //i_type selection
        mem_to_reg = 2'b00;
        if(fun3==3'b000)begin
            alu_control = 5'b00000;
        end
        else if (fun3==3'b001 & fun_7==0)begin
            alu_control = 5'b00010;
        end
        else if (fun3==3'b010 & fun_7==0)begin
            alu_control = 5'b00011;
        end
        else if (fun3==3'b011 & fun_7==0)begin
            alu_control = 5'b00100;
        end
        else if (fun3==3'b100 & fun_7==0)begin
            alu_control = 5'b00101;
        end
        else if (fun3==3'b101 & fun_7==0)begin
            alu_control = 5'b00110;
        end
        else if (fun3==3'b101 & fun_7==1)begin
            alu_control = 5'b00111;
        end
        else if (fun3==3'b110 & fun_7==0)begin
            alu_control = 5'b01000;
        end
        else if (fun3==3'b111 & fun_7==0)begin
            alu_control = 5'b01001;
        end
    end
    else if (store) begin //store
        imm_sel = 3'b001; //store selection
        mem_to_reg = 2'b00;
        if (fun3==3'b000)begin //sb
            alu_control = 5'b00000;
            //signal = 2'b00;
        end
        else if (fun3==3'b001)begin //sh
            alu_control = 5'b00000;
            //signal = 2'b01;
        end
        else if (fun3==3'b010)begin //sw
            alu_control = 5'b00000;
            //signal = 2'b10;
        end
    end
    else if (load) begin
        imm_sel = 3'b000; //i_type selection
        mem_to_reg = 2'b01;
        if (fun3==3'b000)begin //lb
            alu_control = 5'b00000;
        end
        else if(fun3==3'b001)begin //lh
            alu_control = 5'b00000;
        end
        else if(fun3==3'b010)begin //lw
            alu_control = 5'b00000;
        end
        else if(fun3==3'b100)begin //lbu
            alu_control = 5'b00000;
        end
        else if(fun3==3'b101)begin //lhu
            alu_control = 5'b00000;
        end
        else if(fun3==3'b110)begin //lwu
            alu_control = 5'b00000;
        end
    end
    else if (branch)begin
        alu_control = 5'b00000;
        mem_to_reg = 2'b00;
        imm_sel = 3'b010; //branch selection
    end
    else if (jal)begin
        alu_control = 5'b00000;
        mem_to_reg = 2'b10;
        imm_sel = 3'b011; //jal selection
    end
    if(jalr)begin
        mem_to_reg = 2'b00;
        alu_control = 5'b00000;
        imm_sel = 3'b000;//i_type selection
    end
    else if(lui)begin
        mem_to_reg = 2'b00;
        imm_sel = 3'b100;//u_type selection
        alu_control = 5'b01111;
    end
    else if(auipc)begin
        mem_to_reg = 2'b00;
        alu_control = 5'b00000;
        imm_sel = 3'b100;//u_type selection
    end
end

endmodule