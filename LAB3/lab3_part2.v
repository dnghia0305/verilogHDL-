module part3_lab2(Clk, D, Q);
input Clk, D; 
output Q;
wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
nand (R_g, R, Clk); 
nand (S_g, S, Clk);
nand (Qa, R_g, Qb); 
nand (Qb, S_g, Qa);

assign Q = Qa;
endmodule
