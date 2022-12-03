module Lab2_part1(SW,HEX3,HEX2,HEX1,HEX0,LEDR);
input [9:0]SW;
output [9:0]LEDR;
output [6:0]HEX3,HEX2,HEX1,HEX0;

assign LEDR = SW;

bcd_7seg sw74tohex3(SW[7:4],HEX3);
bcd_7seg sw30tohex2(SW[3:0],HEX2);
bcd_7seg sw74tohex1(SW[7:4],HEX1);
bcd_7seg sw30tohex0(.C(SW[3:0]),.Display(HEX0));

endmodule

module bcd_7seg(C,Display);
input [3:0]C;
output [6:0]Display;

assign LEDR = C;
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
 