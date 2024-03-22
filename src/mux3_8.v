module mux3_8 (a,b,c,d,e,f,g,h,sel,out);
    input wire [31:0] a,b,c,d,e,f,g,h;
    input wire [2:0] sel;

    output reg [31:0] out;

    always @ (*) begin
        case (sel)
            3'b000 : out = a;
            3'b001 : out = b;
            3'b010 : out = c;
            3'b011 : out = d;
            3'b100 : out = e;
            3'b101 : out = f;
            3'b110 : out = g;
            3'b111 : out = h;
        endcase
    end
endmodule