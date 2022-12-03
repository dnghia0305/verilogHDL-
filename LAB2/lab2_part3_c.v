module lab2_part3_c(SW, LEDR, LEDG, HEX1, HEX0, HEX2, HEX3, KEY);

input[9:0]SW;
input [3:0] KEY;
output [6:0]HEX2,HEX3,HEX1,HEX0;
output[9:0]LEDR;
output[7:0]LEDG;

wire w1,w2,w3;
wire [3:0] s;
wire z, C1;
wire [3:0]X;
wire [3:0]M;
wire [15:0]Q;
wire[6:0]tam2;
wire[6:0]tam3;

//assign LEDR=SW;

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
//hexto7seg hex_1(s[3:0],HEX0);
//hexto7seg hex_2(C1,HEX1);
//hexto7seg hex_a(SW[3:0],HEX2);
//hexto7seg hex_b(SW[7:4],HEX3);
/*
assign LEDG[0]=s[0];
assign LEDG[1]=s[1];
assign LEDG[2]=s[2];
assign LEDG[3]=s[3];
assign LEDG[4]=C1;

/*
	SW[9] Enable
	KEY[0] reset
	KEY[1] count clk
	KEY[2] nhap 8bit SW cho 8 LEDG hien thi len HEX10
	KEY[3] nhap 8bit SW cho 8 LEDR hien thi len HEX32
	LEDR[8] bit nho (bit 17) cua dem 16bit
	SW[8] base=1 decimal; base=0 hex
	*/
	assign LEDR=SW;//Enable

	//T_countup16bit dem16bit(SW[9],KEY[1],KEY[0],KEY[3],KEY[2],SW[7:0],Q,LEDR[8]);
	
	//assign LEDR[7:0]=Q[15:8];//set by KEY[3]
	assign Q[3:0]=s[3:0];
	assign Q[4]=C1;
	assign LEDG[4:0]=Q[4:0];//set by KEY[2]
	
	bin_7seg3dig_base hienso(KEY[0],SW[9],Q,tam3,tam2,HEX1,HEX0);		
	//sw[9]=1: decimal; sw[8]=0: hex
	hexto7seg hex_a(SW[3:0],HEX2);
	hexto7seg hex_b(SW[7:4],HEX3);
endmodule   


module FA(A, B, C, C2, S);
input A, B, C;
output C2, S;

assign C2 = (B & C) | (A & C) | (A & B);
assign S = (~A & ~B & C) | (~A & B & ~C) | (A & ~B & ~C) | (A & B & C);


endmodule 


// Chuyen doi co so 16 to 10
module bin_7seg3dig_base(clr,clk,bin,disp3,disp2,disp1,disp0);
	input clr,clk;
	input [15:0]bin;
	output [0:6]disp3,disp2,disp1,disp0;
	reg [3:0]b3,b2,b1,b0;
	wire [3:0]bcd3,bcd2,bcd1,bcd0;
	
	bin2bcd_tui b2bcd(bin,bcd3,bcd2,bcd1,bcd0);
	
	always@(clr,clk)
	begin
		if(~clr)
		begin
				b3=4'd0;
				b2=4'd0;
				b1=4'd0;
				b0=4'd0;		
		end
		else begin
			if(clk)
			begin
					b3=bcd3;
					b2=bcd2;
					b1=bcd1;
					b0=bcd0;		
			end 
			else begin
				b3=bin[15:12];
				b2=bin[11:8];
				b1=bin[7:4];
				b0=bin[3:0];		
			end
		end
	end
	hexto7seg hngan(b3,disp3);
	hexto7seg htram(b2,disp2);
	hexto7seg hchuc(b1,disp1);
	hexto7seg hdvi(b0,disp0);
	
endmodule

module T_countup16bit(En,Clk,Clrn,Prs32,Prs10,Qs,Q,Cout);
	input En,Clk,Clrn,Prs32,Prs10;
	input [7:0]Qs;
	output reg [15:0]Q;
	output Cout;
	wire [3:0]Tm;
	wire Clrm;
	
	assign Tm[0]=En;
	and(Cout,En,Q[0],Q[1],Q[2],Q[3],Q[4],Q[5],Q[6],Q[7],Q[8],Q[9],Q[10],Q[11],Q[12],Q[13],Q[14],Q[15]);
	always@(negedge Clrn, posedge Clk, negedge Prs32, negedge Prs10)
	begin
		if(!Clrn)
			Q<=0;
		else if(!Prs32)
			Q[15:8]=Qs;
		else if(!Prs10)
			Q[7:0]=Qs;
		else if(En)
			Q<=Q+1;	
	end
	
endmodule

module bin2bcd_tui(bin,bcd3,bcd2,bcd1,bcd0);
		input [15:0]bin;
output reg [3:0]bcd3,bcd2,bcd1,bcd0;
		reg [3:0]bcd4;
		
		integer i;
		always@(bin)
		begin
			bcd4=4'd0;
			bcd3=4'd0;
			bcd2=4'd0;
			bcd1=4'd0;
			bcd0=4'd0;
			
			for(i=15;i>=0;i=i-1)
			begin
				if(bcd4>=5)
					bcd4 = bcd4 + 3;
				if(bcd3>=5)
					bcd3 = bcd3 + 3;
				if(bcd2>=5)
					bcd2 = bcd2 + 3;
				if(bcd1>=5)
					bcd1 = bcd1 + 3;
				if(bcd0>=5)
					bcd0 = bcd0 + 3;
		
				bcd4 = bcd4 << 1;
				bcd4[0] = bcd3[3];
				bcd3 = bcd3 << 1;
				bcd3[0] = bcd2[3];
				bcd2 = bcd2 << 1;
				bcd2[0] = bcd1[3];
				bcd1 = bcd1 << 1;
				bcd1[0] = bcd0[3];
				bcd0 = bcd0 << 1;
				bcd0[0] = bin[i];
			end
		end
		
endmodule



/*module bcd_7seg(C,Display);
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
*/

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