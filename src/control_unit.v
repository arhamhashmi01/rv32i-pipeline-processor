module controlunit (
    input wire [6:0] opcode,
    input wire [2:0] fun3,
    input wire fun7,
    input wire valid,
    input wire load_control,

    output wire reg_write,
    output wire [2:0]imm_sel,
    output wire operand_b,
    output wire operand_a,
    output wire [1:0] mem_to_reg,
    output wire Load,
    output wire jalr_out,
    output wire Store,
    output wire Branch,
    output wire mem_en,
    output wire next_sel,
    output wire [3:0] alu_control
);

    wire r_type;
    wire i_type;
    wire load;
    wire store;
    wire branch;
    wire jal;
    wire jalr;
    wire lui;
    wire auipc;

    type_decoder u_typedec0 (
        .opcode(opcode),
        .valid(valid),
        .r_type(r_type),
        .i_type(i_type),
        .load(load),
        .branch(branch),
        .store(store),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc),
        .load_signal_controller(load_control)
    );

    control_decoder u_controldec0 (
        .fun3(fun3),
        .fun7(fun7),
        .i_type(i_type),
        .r_type(r_type),
        .load(load),
        .store(store),
        .branch(branch),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc), 
        .next_sel(next_sel),
        .Branch(Branch),
        .Load(Load),
        .Store(Store),
        .jalr_out(jalr_out),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_en(mem_en),
        .operand_b(operand_b),
        .operand_a(operand_a),
        .imm_sel(imm_sel),
        .alu_control(alu_control),
        .load_control(load_control)
    );

endmodule