module branch (op_a,op_b,fun3,en,result);

   input [31:0]op_a,op_b;
   input [2:0]fun3;
   input en;

   output reg result;

   always @(*) begin
      if(en==1)begin
         case (fun3)
            3'b000 : result = (op_a == op_b) ? 1 : 0 ;
            3'b001 : result = (op_a != op_b) ? 1 : 0 ;
            3'b100 : result = ($signed (op_a) < $signed (op_b)) ? 1 : 0 ;
            3'b101 : result = ($signed (op_a) >= $signed (op_b)) ? 1 : 0 ;
            3'b110 : result = (op_a < op_b) ? 1 : 0 ;
            3'b111 : result = (op_a >= op_b) ? 1 : 0 ;
         endcase
      end
      else begin
         result = 0;
      end
   end
   
endmodule