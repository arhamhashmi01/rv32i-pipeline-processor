module alu (a_i,b_i,op_i,res_o);

    input wire [31:0]a_i;
    input wire [31:0]b_i;
    input wire [4:0]op_i;

    output reg [31:0]res_o;

    reg [63:0] res_64;

    always @(*) begin
        if (op_i==5'b00000) begin
            res_o = a_i + b_i; //add
        end
        else if (op_i==5'b00001) begin
            res_o = a_i - b_i; //sub
        end
        else if (op_i==5'b00010) begin
            res_o = a_i << b_i; //shift left logical
        end
        else if (op_i==5'b00011) begin
            res_o = $signed (a_i) < $signed (b_i); //shift less then
        end 
        else if (op_i==5'b00100) begin
            res_o = a_i < b_i; //shift less then unsigned
        end          
        else if (op_i==5'b00101) begin
            res_o = a_i ^ b_i; //xor
        end
        else if (op_i==5'b00110) begin
            res_o = a_i >> b_i; //shift right logical
        end
        else if (op_i==5'b00111) begin
            res_o = a_i >>> b_i; //shift right arithematic
        end
        else if (op_i==5'b01000) begin
            res_o = a_i | b_i; //or
        end
        else if (op_i==5'b01001) begin
            res_o = a_i & b_i; //and
        end
        else if (op_i==5'b01111) begin
            res_o = b_i; //for lui 
        end
        //----------M Extension------------//
        else if (op_i==5'b10000) begin
            res_64= (a_i * b_i);//for MUL
            res_o = res_64[31:0]; //lower bits 
        end
        else if (op_i==5'b10001) begin
            res_64= ($signed (a_i) * $signed (b_i));//for MULH
            res_o = res_64[63:32]; //upper bits 
        end
        else if (op_i==5'b10010) begin
            res_64= ($signed (a_i) * (b_i));//for MULHSU
            res_o = res_64[63:32]; //upper bits 
        end
        else if (op_i==5'b10011) begin
            res_64= a_i * b_i;     //for MULU
            res_o = res_64[63:32]; //upper bits 
        end
        else if (op_i==5'b10100) begin
            res_o = ($signed (a_i) / $signed (b_i)); //for DIV 
        end
        else if (op_i==5'b10101) begin
            res_o = a_i / b_i; //for DIVU 
        end
        else if (op_i==5'b10110) begin
            res_o = ($signed (a_i) % $signed (b_i)); //for REM 
        end
        else if (op_i==5'b10111) begin
            res_o = a_i % b_i; //for REMU 
        end
        else begin
            res_o = 0;
        end
    end
endmodule