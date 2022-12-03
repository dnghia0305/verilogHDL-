module lab2_part3_b(SW, LEDR, LEDG, HEX1, HEX0, HEX2, HEX3);

input[9:0]SW;
wire w1,w2,w3;
wire [3:0] s;
wire z, C1;
wire [3:0]X;
wire [3:0]M;
output [6:0]HEX2,HEX3,HEX1,HEX0;
output[9:0]LEDR;
output[7:0]LEDG;

assign LEDR=SW;

FA fa1(SW[0], SW[4], SW[8], w1, s[0]);
FA fa2(SW[1], SW[5], w1, w2, s[1]);
FA fa3(SW[2], SW[6], w2, w3, s[2]);
FA fa4(SW[3], SW[7], w3, C1, s[3]);

//CircuitC zgt9(s[3:0],z);
//CircuitB hex_2(z,HEX1);
//CircuitA A0(s[3:0],X);
//mux2to1_4b a1(z,s[3:0],X,M);
//bcd_7seg hex_1(M[3:0],HEX0);
//bcd_7seg sw74tohex3(SW[7:4],HEX2);
//bcd_7seg sw74tohex3_2(SW[7:4],HEX3);
hexto7seg hex_1(s[3:0],HEX0);
hexto7seg hex_2(C1,HEX1);
hexto7seg hex_a(SW[3:0],HEX2);
hexto7seg hex_b(SW[7:4],HEX3);

assign LEDG[0]=s[0];
assign LEDG[1]=s[1];
assign LEDG[2]=s[2];
assign LEDG[3]=s[3];
assign LEDG[4]=C1;
endmodule   


module FA(A, B, C, C2, S);
input A, B, C;
output C2, S;

assign C2 = (B & C) | (A & C) | (A & B);
assign S = (~A & ~B & C) | (~A & B & ~C) | (A & ~B & ~C) | (A & B & C);
endmodule 




//he10

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


// he 12

module hexto7seg(C,Dspl);
	input [3:0]C;
	output [6:0]Dspl;
	wire [3:0] Cb;

	assign Cb=~C;
	assign Dspl[0]=(Cb[3]&Cb[1]&(C[2]^C[0]))|(C[3]&C[0]&(C[2]^C[1]));
	assign Dspl[1]=(C[2]&C[1]&Cb[0])|(C[3]&C[1]&C[0])|(C[2]&Cb[1]&(C[3]^C[0]));
	assign Dspl[2]=C[3]&C[2]&(Cb[0]|C[1])|(Cb[3]&Cb[2]&C[1]&Cb[0]);
	assign Dspl[3]=(C[2]&C[1]&C[0])|(Cb[3]&Cb[2]&Cb[1]&C[0])|(C[3]&Cb[2]&C[1]&Cb[0])|(Cb[3]&C[2]&Cb[1]&Cb[0]);
	assign Dspl[4]=(Cb[3]&C[0])|(Cb[3]&C[2]&Cb[1])|(Cb[2]&Cb[1]&C[0]);
	assign Dspl[5]=(Cb[3]&Cb[2]&(C[1]|C[0]))|(Cb[3]&C[1]&C[0])|(C[3]&C[2]&Cb[1]&C[0]);
	assign  Dspl[6]=(Cb[3]&Cb[2]&Cb[1])|(Cb[3]&C[2]&C[1]&C[0])|(C[3]&C[2]&Cb[1]&Cb[0]);
	endmodule 
	
