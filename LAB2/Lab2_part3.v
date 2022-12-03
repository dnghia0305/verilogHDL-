module Lab2_part3(SW, LEDR, LEDG, HEX0, HEX1);

input[9:0]SW;
wire w1,w2,w3;
wire [3:0] s;
output[9:0]LEDR;
output[7:0]LEDG;
output[3:0]HEX0, HEX1;

assign LEDR=SW;

FA fa1(SW[0], SW[4], SW[8], w1, s[0]);
FA fa2(SW[1], SW[5], w1, w2, s[1]);
FA fa3(SW[2], SW[6], w2, w3, s[2]);
FA fa4(SW[3], SW[7], w3, C0, s[3]);

assign LEDG[0]=s[0];
assign LEDG[1]=s[1];
assign LEDG[2]=s[2];
assign LEDG[3]=s[3];
assign LEDG[4]=C0;
endmodule   


module FA(A, B, C, C2, S);
input A, B, C;
output C2, S;

assign C2 = (B & C) | (A & C) | (A & B);
assign S = (~A & ~B & C) | (~A & B & ~C) | (A & ~B & ~C) | (A & B & C);
endmodule   



