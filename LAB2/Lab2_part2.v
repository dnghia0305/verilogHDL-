module Lab2_part2(SW,HEX2,HEX3,HEX1,HEX0,LEDR);
input [9:0]SW;
output [9:0]LEDR;
output [6:0]HEX2,HEX3,HEX1,HEX0;
wire z;
wire [3:0]X;
wire [3:0]M;
assign LEDR = SW;
CircuitC zgt9(SW[3:0],z);
CircuitB hex_2(z,HEX1);
CircuitA A0(SW[3:0],X);
mux2to1_4b a1(z,SW[3:0],X,M);
bcd_7seg hex_1(M[3:0],HEX0);
bcd_7seg sw74tohex3(SW[7:4],HEX2);
bcd_7seg sw74tohex3_2(SW[7:4],HEX3);
endmodule

module bcd_7seg(C,Display);
input [3:0]C;
output [6:0]Display;

assign Display[0] = (~C[3])&(~C[1])&(C[2]^C[0]);
assign Display[1] = (~C[3])&C[2]&(C[1]^C[0]);
assign Display[2] = (~C[3])&(~C[2])&C[1]&(~C[0]);
assign Display[3] = (~C[3])&((~C[1])&(C[2]^C[0])|(C[2]&C[1]&C[0]));
//assign Display[4] = (C[3]|(~C[1])|C[0])&(C[2]|C[1]|C[0]); //treat don't care as low
assign Display[4] = ((~C[3])&C[0])|((~C[3])&C[2]&(~C[1]))|((~C[2])&(~C[1])&C[0]); //treat don't care as high
assign Display[5] = ((~C[3])&C[1]&C[0])|((~C[3])&(~C[2])&(C[0]|C[1]));
//assign Display[6] = ((~C[3])&(~C[2])&(~C[1]))|((~C[3])&C[2]&C[1]&C[0]); //treat don't care as low
assign Display[6] = ((~C[3])&(~C[2])&(~C[1]))|(C[2]&C[1]&C[0])|(C[3]&C[2])|(C[3]&(~C[2])&C[1]); //treat don't care as high
endmodule

module CircuitC(V,z);
input [3:0]V;
output z;
assign z = (V[3]&V[2]) | (V[3]&V[1]); 
endmodule

module mux2to1(s,x,y,m);
input s,x,y;
output m;
assign m = (~s & x)|(s & y);
endmodule

module mux2to1_4b(s,X,Y,M);
input s;
input [3:0]X,Y;
output [3:0]M;
mux2to1 mux0(s,X[0],Y[0],M[0]);
mux2to1 mux1(s,X[1],Y[1],M[1]);
mux2to1 mux2(s,X[2],Y[2],M[2]);
mux2to1 mux3(s,X[3],Y[3],M[3]);
endmodule

module CircuitA(V,X);
input [3:0]V;
output [3:0] X;
assign X[0] = V[0];
assign X[1] = ~V[1];
assign X[2] = V[2]&V[1];
assign X[3] = ~V[3];
endmodule

module CircuitB(z,C);
input z;
output [6:0]C;
assign C[0] = z;
assign C[1] = 0;
assign C[2] = 0;
assign C[3] = z;
assign C[4] = z;
assign C[5] = z;
assign C[6] = 1;
endmodule

