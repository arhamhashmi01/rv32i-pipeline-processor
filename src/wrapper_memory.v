module wrappermem (
    input wire [31:0] data_i,
    input wire [1:0] byteadd,
    input wire [2:0] fun3,
    input wire mem_en,
    input wire Load,
    input wire data_valid,
    input wire [31:0]wrap_load_in,

    output reg [3:0] masking,
    output reg [31:0] data_o,
    output reg [31:0] wrap_load_out

);

    always @(*) begin
        if (mem_en) begin
            masking = 4'b0000;
            if(fun3==3'b000)begin //sb
               case (byteadd)
                    00: begin
                        masking = 4'b0001;
                        data_o = data_i;
                    end
                    01: begin
                        masking = 4'b0010;
                        data_o = {data_i[31:16],data_i[7:0],data_i[7:0]};
                    end
                    10: begin
                        masking = 4'b0100;
                        data_o = {data_i[31:24],data_i[7:0],data_i[15:0]};
                    end
                    11: begin
                        masking = 4'b1000;
                        data_o = {data_i[7:0],data_i[23:0]};
                    end
               endcase 
            end

            if(fun3==3'b001)begin //sh
                case (byteadd)
                    00: begin
                        masking = 4'b0011;
                        data_o = data_i;
                    end
                    01: begin
                        masking = 4'b0110;
                        data_o = {data_i[31:24],data_i[15:0],data_i[7:0]};
                    end
                    10: begin
                        masking = 4'b1100;
                        data_o = {data_i[15:0],data_i[15:0]};
                    end
                endcase   
            end

            if(fun3==3'b010) begin //sw
                masking = 4'b1111;
                data_o = data_i;
            end
        end

        if (Load | data_valid)begin
            if(fun3==3'b000)begin //lb
                case (byteadd)
                    00: begin 
                        wrap_load_out = {{24{wrap_load_in[7]}},wrap_load_in[7:0]};
                    end
                    01: begin
                        wrap_load_out = {{24{wrap_load_in[15]}},wrap_load_in[15:8]};
                    end
                    10: begin
                        wrap_load_out = {{24{wrap_load_in[23]}},wrap_load_in[23:16]};
                    end
                    11: begin
                        wrap_load_out = {{24{wrap_load_in[31]}},wrap_load_in[31:24]};
                    end
               endcase
            end

            if(fun3==3'b001)begin //lh
                case (byteadd)
                    00: begin
                        wrap_load_out = {{16{wrap_load_in[15]}},wrap_load_in[15:0]};
                    end
                    01: begin
                        wrap_load_out = {{16{wrap_load_in[23]}},wrap_load_in[23:8]};
                    end
                    10: begin
                        wrap_load_out = {{16{wrap_load_in[31]}},wrap_load_in[31:16]};
                    end
                endcase   
            end

            if(fun3==3'b010) begin //lw
                wrap_load_out = wrap_load_in;
            end

            if(fun3==3'b100)begin //lbu
                case (byteadd)
                    00: begin 
                        wrap_load_out = {24'b0,wrap_load_in[7:0]};
                    end
                    01: begin
                        wrap_load_out = {24'b0,wrap_load_in[15:8]};
                    end
                    10: begin
                        wrap_load_out = {24'b0,wrap_load_in[23:16]};
                    end
                    11: begin
                        wrap_load_out = {24'b0,wrap_load_in[31:24]};
                    end
               endcase
            end

            if(fun3==3'b101)begin //lhu
                case (byteadd)
                    00: begin
                        wrap_load_out = {16'b0,wrap_load_in[15:0]};
                    end
                    01: begin
                        wrap_load_out = {16'b0,wrap_load_in[23:8]};
                    end
                    10: begin
                        wrap_load_out = {16'b0,wrap_load_in[31:16]};
                    end
                endcase   
            end

            if(fun3==3'b110) begin //lwu
                wrap_load_out = wrap_load_in;
            end
        end     
    end
endmodule