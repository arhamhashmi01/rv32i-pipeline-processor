module execute_pipe(
  input wire clk,
  input wire load_in,
  input wire store_in,
  input wire reg_write_in,
  input wire [31:0] opb_datain,
  input wire [31:0] alu_res,
  input wire [1:0] mem_reg_in,
  input wire [31:0] next_sel_addr,
  input wire [31:0] pre_address_in,
  input wire [31:0] instruction_in,

  output wire reg_write_out,
  output wire load_out,
  output wire store_out,
  output wire [31:0] opb_dataout,
  output wire [31:0] alu_res_out,
  output wire [1:0] mem_reg_out,
  output wire [31:0] next_sel_address,
  output wire [31:0] pre_address_out,
  output wire [31:0] instruction_out
  );

  reg load , store , reg_write;
  reg [1:0] mem_reg;
  reg [31:0] alu_result , nextsel_addr;
  reg [31:0] pre_address , instruction , opb_data;

  always @ (posedge clk) begin
    load <= load_in;
    store <= store_in;
    mem_reg <= mem_reg_in;
    opb_data <= opb_datain;
    pre_address <= pre_address_in;
    instruction <= instruction_in;
    alu_result <= alu_res;
    nextsel_addr <= next_sel_addr;
    reg_write <= reg_write_in;
  end

  assign reg_write_out = reg_write;
  assign load_out = load;
  assign store_out = store;
  assign mem_reg_out = mem_reg;
  assign opb_dataout = opb_data;
  assign alu_res_out = alu_result;
  assign pre_address_out = pre_address;
  assign instruction_out = instruction;
  assign next_sel_address = nextsel_addr;
endmodule