module lab1_part5(SW,HEX0,HEX1,HEX2,LEDR,LEDG);
input [9:0]SW;
wire [1:0] M0, M1, M2;
wire [1:0] N0, N1, N2;
output [9:0]LEDR;
output [7:0]LEDG;
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;

mux2to1_2b bit2(SW[9], SW[1:0], SW[3:2], M0[1:0]);
mux2to1_2b bit3(SW[8], M0[1:0], SW[5:4], N0[1:0]);
mux2to1_2b bit4(SW[9], SW[3:2], SW[5:4], M1[1:0]);
mux2to1_2b bit5(SW[8], M1[1:0], SW[1:0], N1[1:0]);
mux2to1_2b bit6(SW[9], SW[5:4], SW[1:0], M2[1:0]);
mux2to1_2b bit7(SW[8], M2[1:0], SW[3:2], N2[1:0]);


seg7 hex0 (HEX0, N0);
seg7 hex1 (HEX1, N1);
seg7 hex2 (HEX2, N2);

assign LEDR=SW;

endmodule 

module seg7 (F,V);
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