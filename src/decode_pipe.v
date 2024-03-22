module  decode_pipe(
  input wire clk,
  input wire load_in,
  input wire store_in,
  input wire jalr_in,
  input wire next_sel_in,
  input wire branch_result_in,
  input wire reg_write_in,
  input wire [4:0] rs1_in,
  input wire [4:0] rs2_in, 
  input wire [3:0] alu_control_in,
  input wire [1:0]  mem_to_reg_in,
  input wire [31:0] opa_mux_in,
  input wire [31:0] opb_mux_in,
  input wire [31:0] opb_data_in,
  input wire [31:0] pre_address_in,
  input wire [31:0] instruction_in,

  output wire load,
  output wire store,
  output wire jalr_out,
  output wire next_sel,
  output wire branch_result,
  output wire reg_write_out,
  output wire [4:0] rs1_out,
  output wire [4:0] rs2_out,
  output wire [3:0] alu_control,
  output wire [1:0]  mem_to_reg,
  output wire [31:0] opa_mux_out,
  output wire [31:0] opb_mux_out,
  output wire [31:0] opb_data_out,
  output wire [31:0] pre_address_out,
  output wire [31:0] instruction_out
 );

  reg l,s,nextsel,branch_res,jalr;
  reg reg_write;
  reg [1:0] mem_reg;
  reg [3:0] alu_con;
  reg [4:0] rs1;
  reg [4:0] rs2;
  reg [31:0] opa_mux,opb_mux,opb_data,pre_address,instruction;

  always @ (posedge clk) begin
    l <= load_in;
    s <= store_in;
    jalr <= jalr_in;
    nextsel <= next_sel_in;
    branch_res <= branch_result_in;
    mem_reg <= mem_to_reg_in;
    alu_con <= alu_control_in;
    opa_mux <= opa_mux_in;
    opb_mux <= opb_mux_in;
    opb_data <= opb_data_in;
    pre_address <= pre_address_in;
    instruction <= instruction_in;
    reg_write <= reg_write_in;
    rs1 <= rs1_in;
    rs2 <= rs2_in;
  end

  assign load = l;
  assign store = s;
  assign rs1_out = rs1;
  assign rs2_out = rs2;
  assign jalr_out = jalr;
  assign next_sel = nextsel;
  assign reg_write_out = reg_write;
  assign branch_result = branch_res;
  assign mem_to_reg = mem_reg;
  assign alu_control = alu_con;
  assign opa_mux_out = opa_mux;
  assign opb_mux_out = opb_mux;
  assign opb_data_out = opb_data;
  assign instruction_out = instruction;
  assign pre_address_out = pre_address;
endmodule