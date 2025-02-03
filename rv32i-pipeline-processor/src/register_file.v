module registerfile (
    input wire clk,
    input wire rst,
    input wire en,
    input wire [4:0]rs1,
    input wire [4:0]rs2,
    input wire [4:0]rd,
    input wire [31:0]data,

    output wire [31:0]op_a,
    output wire [31:0]op_b
);

    reg [31:0] register[31:1];
    integer i;

    always @(posedge clk or negedge rst) begin
        if(!rst)begin
            for (i=0; i<32; i++) begin
                register[i] <= 32'b0;
            end
        end
        else begin
            if (en) begin
                register[rd] <= data;
            end
        end
    end

    assign op_a = (rs1 != 0)? register[rs1] : 0;
    assign op_b = (rs2 != 0)? register[rs2] : 0;
endmodule