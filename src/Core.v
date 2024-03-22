module core (
    input wire clk,
    input wire rst,
    input wire data_mem_valid,
    input wire instruc_mem_valid,
    input wire [31:0] instruction,
    input wire [31:0] load_data_in,

    output wire load_signal,
    output wire instruction_mem_we_re,
    output wire instruction_mem_request,
    output wire data_mem_we_re,
    output wire data_mem_request,
    output wire [3:0]  mask_singal,
    output wire [3:0]  instruc_mask_singal,
    output wire [31:0] store_data_out,
    output wire [31:0] alu_out_address,
    output wire [31:0] pc_address
    );

    wire [31:0] instruc_data_out;
    wire [31:0] pre_address_pc;
    wire [31:0] instruction_fetch , instruction_decode , instruction_execute;
    wire [31:0] instruction_memstage , instruction_wb;
    wire [31:0] pre_pc_addr_fetch , pre_pc_addr_decode , pre_pc_addr_execute;
    wire [31:0] pre_pc_addr_memstage , pre_pc_addr_wb;
    wire load_decode , load_execute , load_memstage;
    wire store_decode , store_execute , store_memstage;
    wire jalr_decode;
    wire next_sel_decode , next_sel_execute;
    wire reg_write_decode , reg_write_execute , reg_write_memstage;
    wire branch_result_decode , branch_result_execute;
    wire [3:0]  mask;
    wire [3:0]  alu_control_decode , alu_control_execute;
    wire [1:0]  mem_to_reg_decode , mem_to_reg_execute;
    wire [1:0]  mem_to_reg_memstage , mem_to_reg_wb;
    wire [4:0]  rs1_decode , rs1_execute;
    wire [4:0]  rs2_decode , rs2_execute;
    wire [4:0]  rd_memstage;
    wire [31:0] op_b_decode , op_b_execute , op_b_memstage;
    wire [31:0] opa_mux_out_decode , opa_mux_out_execute;
    wire [31:0] opb_mux_out_decode , opb_mux_out_execute;
    wire [31:0] alu_res_out_execute , alu_res_out_memstage;
    wire [31:0] alu_res_out_wb;
    wire [31:0] next_sel_address_execute , next_sel_address_memstage;
    wire [31:0] next_sel_address_wb;
    wire [31:0] wrap_load_memstage , wrap_load_wb;
    wire [31:0] rd_wb_data;
    wire [31:0] alu_in_a , alu_in_b;

    //FETCH STAGE
    fetch u_fetchstage(
        .clk(clk),
        .rst(rst),
        .load(load_decode),
        .jalr(jalr_execute),
        .next_sel(next_sel_execute),
        .branch_reselt(branch_result_execute),
        .next_address(alu_res_out_execute),
        .instruction_fetch(instruction),
        .instruction(instruction_fetch),
        .address_in(0),
        .valid(data_mem_valid),
        .mask(instruc_mask_singal),
        .we_re(instruction_mem_we_re),
        .request(instruction_mem_request),
        .pre_address_pc(pre_pc_addr_fetch),
        .address_out(pc_address)
    );

    //FETCH STAGE PIPELINE
    fetch_pipe u_fetchpipeline(
        .clk(clk),
        .pre_address_pc(pre_pc_addr_fetch),
        .instruction_fetch(instruction_fetch),
        .pre_address_out(pre_pc_addr_decode),
        .instruction(instruction_decode),
        .next_select(next_sel_decode),
        .branch_result(branch_result_decode),
        .jalr(jalr_decode),
        .load(load_decode)
    );

    //DECODE STAGE
    decode u_decodestage(
        .clk(clk),
        .rst(rst),
        .valid(data_mem_valid),
        .load_control_signal(load_execute),
        .reg_write_en_in(reg_write_wb),
        .instruction(instruction_decode),
        .pc_address(pre_pc_addr_decode),
        .rd_wb_data(rd_wb_data),
        .rs1(rs1_decode),
        .rs2(rs2_decode),
        .load(load_decode),
        .store(store_decode),
        .jalr(jalr_decode),
        .next_sel(next_sel_decode),
        .reg_write_en_out(reg_write_decode),
        .mem_to_reg(mem_to_reg_decode),
        .branch_result(branch_result_decode),
        .opb_data(op_b_decode),
        .instruction_rd(instruction_wb),
        .alu_control(alu_control_decode),
        .opa_mux_out(opa_mux_out_decode),
        .opb_mux_out(opb_mux_out_decode)
    );

    //DECODE STAGE PIPELINE
    decode_pipe u_decodepipeline(
        .clk(clk),
        .load_in(load_decode),
        .store_in(store_decode),
        .jalr_in(jalr_decode),
        .next_sel_in(next_sel_decode),
        .mem_to_reg_in(mem_to_reg_decode),
        .branch_result_in(branch_result_decode),
        .opb_data_in(op_b_decode),
        .alu_control_in(alu_control_decode),
        .opa_mux_in(opa_mux_out_decode),
        .opb_mux_in(opb_mux_out_decode),
        .pre_address_in(pre_pc_addr_decode),
        .instruction_in(instruction_decode),
        .reg_write_in(reg_write_decode),
        .rs1_in(rs1_decode),
        .rs2_in(rs2_decode),
        .reg_write_out(reg_write_execute),
        .jalr_out(jalr_execute),
        .load(load_execute),
        .store(store_execute),
        .next_sel(next_sel_execute),
        .mem_to_reg(mem_to_reg_execute),
        .branch_result(branch_result_execute),
        .opb_data_out(op_b_execute),
        .alu_control(alu_control_execute),
        .opa_mux_out(opa_mux_out_execute),
        .opb_mux_out(opb_mux_out_execute),
        .pre_address_out(pre_pc_addr_execute),
        .instruction_out(instruction_execute),
        .rs1_out(rs1_execute),
        .rs2_out(rs2_execute)
    );

    assign alu_in_a = (rs1_execute == rd_memstage)? alu_res_out_memstage : opa_mux_out_execute;
    assign alu_in_b = (rs2_execute == rd_memstage)? alu_res_out_memstage : opb_mux_out_execute;

    //EXECUTE STAGE
    execute u_executestage(
        .a_i(alu_in_a),
        .b_i(alu_in_b),
        .pc_address(pre_pc_addr_execute),
        .alu_control(alu_control_execute),
        .alu_res_out(alu_res_out_execute),
        .next_sel_address(next_sel_address_execute)
    );

    //EXECUTE STAGE PIPELINE
    execute_pipe u_executepipeline(
        .clk(clk),
        .load_in(load_execute),
        .store_in(store_execute),
        .opb_datain(op_b_execute),
        .alu_res(alu_res_out_execute),
        .mem_reg_in(mem_to_reg_execute),
        .next_sel_addr(next_sel_address_execute),
        .pre_address_in(pre_pc_addr_execute),
        .instruction_in(instruction_execute),
        .reg_write_in(reg_write_execute),
        .reg_write_out(reg_write_memstage),
        .load_out(load_memstage),
        .store_out(store_memstage),
        .opb_dataout(op_b_memstage),
        .alu_res_out(alu_res_out_memstage),
        .mem_reg_out(mem_to_reg_memstage),
        .next_sel_address(next_sel_address_memstage),
        .pre_address_out(pre_pc_addr_memstage),
        .instruction_out(instruction_memstage)
    );

    //MEMORY STAGE
    memory_stage u_memorystage(
        .rst(rst),
        .load(load_memstage),
        .store(store_memstage),
        .op_b(op_b_memstage),
        .instruction(instruction_memstage),
        .alu_out_address(alu_res_out_memstage),
        .wrap_load_in(load_data_in),
        .mask(mask),
        .data_valid(data_mem_valid),
        .valid(instruc_mem_valid),
        .we_re(data_mem_we_re),
        .request(data_mem_request),
        .store_data_out(store_data_out),
        .wrap_load_out(wrap_load_memstage)
    );

    assign rd_memstage = instruction_memstage[11:7];
    assign alu_out_address = alu_res_out_memstage;
    assign mask_singal = mask ;
    assign load_signal = load_memstage;

    //MEMORY STAGE PIPELINE
    memory_pipe u_memstagepipeline(
        .clk(clk),
        .mem_reg_in(mem_to_reg_memstage),
        .wrap_load_in(wrap_load_memstage),
        .alu_res(alu_res_out_memstage),
        .next_sel_addr(next_sel_address_memstage),
        .pre_address_in(pre_pc_addr_memstage),
        .instruction_in(instruction_memstage),
        .reg_write_in(reg_write_memstage),
        .reg_write_out(reg_write_wb),
        .alu_res_out(alu_res_out_wb),
        .mem_reg_out(mem_to_reg_wb),
        .next_sel_address(next_sel_address_wb),
        .instruction_out(instruction_wb),
        .pre_address_out(pre_pc_addr_wb),
        .wrap_load_out(wrap_load_wb)
    );

    //WRITE BACK STAGE
    write_back u_wbstage(
        .mem_to_reg(mem_to_reg_wb),
        .alu_out(alu_res_out_wb),
        .data_mem_out(wrap_load_wb),
        .next_sel_address(next_sel_address_wb),
        .rd_sel_mux_out(rd_wb_data)
    );
endmodule