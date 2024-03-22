module memory_pipe(
  input wire clk,
  input wire reg_write_in,
  input wire [1:0]  mem_reg_in,
  input wire [31:0] wrap_load_in,
  input wire [31:0] alu_res,
  input wire [31:0] next_sel_addr,
  input wire [31:0] instruction_in,
  input wire [31:0] pre_address_in,

  output wire reg_write_out,
  output wire [31:0] alu_res_out,
  output wire [1:0]  mem_reg_out,
  output wire [31:0] next_sel_address,
  output wire [31:0] wrap_load_out,
  output wire [31:0] instruction_out,
  output wire [31:0] pre_address_out
  );

  reg reg_write;
  reg [1:0]  mem_reg;
  reg [31:0] pre_address_pc;
  reg [31:0] alu_result , nextsel_addr , wrap_load , instruction;

  always @ (posedge clk) begin
    mem_reg        <= mem_reg_in;
    alu_result     <= alu_res;
    nextsel_addr   <= next_sel_addr;
    wrap_load      <= wrap_load_in;
    instruction    <= instruction_in;
    reg_write      <= reg_write_in;
    pre_address_pc <= pre_address_in;
  end

  assign reg_write_out    = reg_write;
  assign mem_reg_out      = mem_reg;
  assign alu_res_out      = alu_result;
  assign next_sel_address = nextsel_addr;
  assign wrap_load_out    = wrap_load;
  assign instruction_out  = instruction;
  assign pre_address_out  = pre_address_pc;
endmodule