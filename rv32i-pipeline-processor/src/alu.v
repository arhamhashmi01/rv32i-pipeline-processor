module alu (a_i,b_i,op_i,res_o);

    input wire [31:0]a_i;
    input wire [31:0]b_i;
    input wire [3:0]op_i;

    output reg [31:0]res_o;

    always @(*) begin

        if (op_i==4'b0000) begin
            res_o = a_i + b_i; //add
        end
        else if (op_i==4'b0001) begin
            res_o = a_i - b_i; //sub
        end
        else if (op_i==4'b0010) begin
            res_o = a_i << b_i; //shift left logical
        end
        else if (op_i==4'b0011) begin
            res_o = $signed (a_i) < $signed (b_i); //shift less then
        end 
        else if (op_i==4'b0100) begin
            res_o = a_i < b_i; //shift less then unsigned
        end          
        else if (op_i==4'b0101) begin
            res_o = a_i ^ b_i; //xor
        end
        else if (op_i==4'b0110) begin
            res_o = a_i >> b_i; //shift right logical
        end
        else if (op_i==4'b0111) begin
            res_o = a_i >>> b_i; //shift right arithematic
        end
        else if (op_i==4'b1000) begin
            res_o = a_i | b_i; //or
        end
        else if (op_i==4'b1001) begin
            res_o = a_i & b_i; //and
        end
        else if (op_i==4'b1111) begin
            res_o = b_i; //for lui 
        end
        else begin
            res_o = 0;
        end
    end
endmodule