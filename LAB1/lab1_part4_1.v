module lab1_part4_1(SW,HEX0,LEDR);
input [1:0] SW;
output [1:0] LEDR;
output [6:0] HEX0;
part4 bit0 (HEX0, SW);
assign LEDR = SW;
endmodule 

module part4 (F,V);
input [1:0] V;
output [6:0] F;
assign F[0]=~V[0];
assign F[1]=(V[0] & ~V[1]);
assign F[2]=(V[0] & ~V[1]);
assign F[3]=(~V[0] & V[1]);
assign F[4]=(~V[0] & V[1]);
assign F[5]=(~V[0]);
assign F[6]=(~V[0] & V[1]);
endmodule

module lab1_part3b(SW,LEDR,LEDG);
input [9:0] SW;

output [9:0] LEDR;
output [7:0] LEDG;
wire [1:0] M;

mux2to1_2b bit2(SW[9], SW[1:0], SW[3:2], M[1:0]);
mux2to1_2b bit3(SW[8], M[1:0], SW[5:4], LEDG[1:0]);

endmodule

module mux2to1_2b(S,X,Y,M);
input [1:0]X,Y;
input S;
output [1:0]M;
mux2to1 bit0(S, X[0], Y[0], M[0]);
mux2to1 bit1(S, X[1], Y[1], M[1]);

endmodule 

module mux2to1(s,x,y,m);
input s,x,y;
output m;
assign m = (~s & x)|(s & y);

endmodule 