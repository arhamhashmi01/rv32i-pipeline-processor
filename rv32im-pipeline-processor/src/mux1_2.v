module mux (a,b,sel,out);
    input wire [31:0] a,b;
    input wire sel;

    output wire [31:0] out;

    assign out = (sel)?  b:a;
endmodule