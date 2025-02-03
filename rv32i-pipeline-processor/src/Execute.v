module execute (
    input wire [31:0] a_i,
    input wire [31:0] b_i,
    input wire [3:0]  alu_control,
    input wire [31:0] pc_address,

    output wire [31:0] alu_res_out,
    output wire [31:0] next_sel_address
    );

    // ALU
    alu u_alu0 
    (
        .a_i(a_i),
        .b_i(b_i),
        .op_i(alu_control),
        .res_o(alu_res_out)
    );
    //adder
    adder u_adder0(
        .a(pc_address),
        .adder_out(next_sel_address)
    );
endmodule