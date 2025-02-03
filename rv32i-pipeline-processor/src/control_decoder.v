module control_decoder (
    input wire [2:0] fun3,
    input wire fun7,
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
    output reg [3:0]alu_control
);

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
        if(fun3==3'b000 & fun7==0)begin
            alu_control = 4'b0000;
        end
        else if(fun3==3'b000 & fun7==1)begin
            alu_control = 4'b0001;
        end
        else if (fun3==3'b001 & fun7==0)begin
            alu_control = 4'b0010;
        end
        else if (fun3==3'b010 & fun7==0)begin
            alu_control = 4'b0011;
        end
        else if (fun3==3'b011 & fun7==0)begin
            alu_control = 4'b0100;
        end
        else if (fun3==3'b100 & fun7==0)begin
            alu_control = 4'b0101;
        end
        else if (fun3==3'b101 & fun7==0)begin
            alu_control = 4'b0110;
        end
        else if (fun3==3'b101 & fun7==1)begin
            alu_control = 4'b0111;
        end
        else if (fun3==3'b110 & fun7==0)begin
            alu_control = 4'b1000;
        end
        else if (fun3==3'b111 & fun7==0)begin
            alu_control = 4'b1001;
        end
    end
    else if (i_type)begin //itype
        imm_sel = 3'b000; //i_type selection
        mem_to_reg = 2'b00;
        if(fun3==3'b000 & fun7==0)begin
            alu_control = 4'b0000;
        end
        else if (fun3==3'b001 & fun7==0)begin
            alu_control = 4'b0010;
        end
        else if (fun3==3'b010 & fun7==0)begin
            alu_control = 4'b0011;
        end
        else if (fun3==3'b011 & fun7==0)begin
            alu_control = 4'b0100;
        end
        else if (fun3==3'b100 & fun7==0)begin
            alu_control = 4'b0101;
        end
        else if (fun3==3'b101 & fun7==0)begin
            alu_control = 4'b0110;
        end
        else if (fun3==3'b101 & fun7==1)begin
            alu_control = 4'b0111;
        end
        else if (fun3==3'b110 & fun7==0)begin
            alu_control = 4'b1000;
        end
        else if (fun3==3'b111 & fun7==0)begin
            alu_control = 4'b1001;
        end
    end
    else if (store) begin //store
        imm_sel = 3'b001; //store selection
        mem_to_reg = 2'b00;
        if (fun3==3'b000)begin //sb
            alu_control = 4'b0000;
            //signal = 2'b00;
        end
        else if (fun3==3'b001)begin //sh
            alu_control = 4'b0000;
            //signal = 2'b01;
        end
        else if (fun3==3'b010)begin //sw
            alu_control = 4'b0000;
            //signal = 2'b10;
        end
    end
    else if (load) begin
        imm_sel = 3'b000; //i_type selection
        mem_to_reg = 2'b01;
        if (fun3==3'b000)begin //lb
            alu_control = 4'b0000;
        end
        else if(fun3==3'b001)begin //lh
            alu_control = 4'b0000;
        end
        else if(fun3==3'b010)begin //lw
            alu_control = 4'b0000;
        end
        else if(fun3==3'b100)begin //lbu
            alu_control = 4'b0000;
        end
        else if(fun3==3'b101)begin //lhu
            alu_control = 4'b0000;
        end
        else if(fun3==3'b110)begin //lwu
            alu_control = 4'b0000;
        end
    end
    else if (branch)begin
        alu_control = 4'b0000;
        mem_to_reg = 2'b00;
        imm_sel = 3'b010; //branch selection
    end
    else if (jal)begin
        alu_control = 4'b0000;
        mem_to_reg = 2'b10;
        imm_sel = 3'b011; //jal selection
    end
    if(jalr)begin
        mem_to_reg = 2'b00;
        alu_control = 4'b0000;
        imm_sel = 3'b000;//i_type selection
    end
    else if(lui)begin
        mem_to_reg = 2'b00;
        imm_sel = 3'b100;//u_type selection
        alu_control = 4'b1111;
    end
    else if(auipc)begin
        mem_to_reg = 2'b00;
        alu_control = 4'b0000;
        imm_sel = 3'b100;//u_type selection
    end
end

endmodule