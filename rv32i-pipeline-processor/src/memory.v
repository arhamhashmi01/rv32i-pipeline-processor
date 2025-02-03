module memory#(
    parameter INIT_MEM = 0
)(
    input wire clk,
    input wire we_re,
    input wire request,
    input wire [7:0]address,
    input wire [31:0]data_in,
    input wire [3:0]mask,

    output reg [31:0]data_out
);

    reg [31:0] mem [0:255];

    initial begin
        if (INIT_MEM)
            $readmemh("tb/instr.mem",mem);
    end

    always @(posedge clk) begin
        if (request && we_re) begin
            if(mask[0]) begin
                mem[address][7:0] <= data_in[7:0];
            end
            if(mask[1]) begin
                mem[address][15:8] <= data_in[15:8];
            end
            if(mask[2]) begin
                mem[address][23:16] <= data_in[23:16];
            end
            if(mask[3]) begin
                mem[address][31:24] <= data_in[31:24];
            end
        end

        else begin
            if (request && !we_re) begin
                data_out <= mem[address];
            end
        end
    end
endmodule