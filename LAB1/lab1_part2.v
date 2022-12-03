module lab1_part2(SW,LEDR,LEDG);
input [9:0] SW;
output [9:0] LEDR;
output [7:0] LEDG;

mux2to1 bit0(SW[9], SW[0], SW[4], LEDG[0]);
mux2to1 bit1(SW[9], SW[1], SW[5], LEDG[1]);
mux2to1 bit2(SW[9], SW[2], SW[6], LEDG[2]);
mux2to1 bit3(SW[9], SW[3], SW[7], LEDG[3]);

endmodule


module mux2to1(s,x,y,m);
input s,x,y;
output m;
assign m = (~s & x)|(s & y);

endmodule 

// if if sw[9] = o then ledr = sw[0,1,2,3]
// if if sw[9] = 1 then ledr = sw[4,5,6,7]
// example: 9 turn on =>  green light is not on
// 9 turn on + 0 turn on => green light is not on
// 9 turn off + 0 turn on => green light is on
// both 9 and 4 turn on => green light is on
// 4 turn on => green light is not on

/*assign LEDR=SW; 
assign LEDG[0] = (~SW[9] & SW[0])|(SW[9] & SW[4]); 
assign LEDG[1] = (~SW[9] & SW[1])|(SW[9] & SW[5]);
assign LEDG[2] = (~SW[9] & SW[2])|(SW[9] & SW[6]);
assign LEDG[3] = (~SW[9] & SW[3])|(SW[9] & SW[7]);
*/