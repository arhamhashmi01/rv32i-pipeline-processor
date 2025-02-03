module fetch (
    input wire clk,
    input wire rst,
    input wire next_sel,
    input wire valid,
    input wire load,
    input wire jalr,
    input wire branch_reselt,
    input wire [31:0] next_address,
    input wire [31:0] address_in,
    input wire [31:0] instruction_fetch,

    output reg we_re,
    output reg request,
    output reg [3:0] mask,
    output wire [31:0] address_out,
    output reg  [31:0] instruction,
    output wire [31:0] pre_address_pc
    );

    // PROGRAM COUNTER
    pc u_pc0 
    (
        .clk(clk),
        .rst(rst),
        .load(load),
        .next_sel(next_sel),
        .jalr(jalr),
        .dmem_valid(valid),
        .next_address(next_address),
        .branch_reselt(branch_reselt),
        .address_in(0),
        .address_out(address_out),
        .pre_address_pc(pre_address_pc)
    );

    always @ (*) begin
        if ((load && !valid)) begin
            mask = 4'b1111; 
            we_re = 1'b0;
            request = 1'b0;
        end
        else begin
            mask = 4'b1111; 
            we_re = 1'b0;
            request = 1'b1;
        end
    end
    always @ (*) begin
        instruction = instruction_fetch ;
    end
endmodule