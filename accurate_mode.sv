`include"adder_21.v"
`include"multiplier_4b.sv"
`include"aprox_mult_8b.v"
`include"accurate_mult.sv"
`include"pip_acc.sv"


// ACCURATE MULTIPLER
module accurate_mode(input [15:0]in1,in2,output [31:0]acc_prod);
	wire [15:0]ALXL,AHXH,AHXL,ALXH;
	acc_mult15 mul1(in1[7:0],in2[7:0],ALXL);
	acc_mult15 mul2(in1[15:8],in2[15:8],AHXH);
	acc_mult15 mul3(in1[15:8],in2[7:0],AHXL);
	acc_mult15 mul4(in1[7:0],in2[15:8],ALXH);
	pip_acc main(AHXH,ALXL,AHXL,ALXH,acc_prod);

endmodule

// VERY APPROXIMATE MULTIPLIER
module vhigh_approx(input [15:0]in1,in2,output [31:0]acc_prod);
	wire [15:0]ALXL,AHXH,AHXL,ALXH;
	approx_mult mult_ALXL(in1[7:0], in2[7:0], ALXL);
 // acc_mult15 mul1(in1[7:0],in2[7:0],ALXL);
	acc_mult15 mul2(in1[15:8],in2[15:8],AHXH);
	acc_mult15 mul3(in1[15:8],in2[7:0],AHXL);
	acc_mult15 mul4(in1[7:0],in2[15:8],ALXH);
	pip_acc main(AHXH,ALXL,AHXL,ALXH,acc_prod);

endmodule

module high_approx(input [15:0]in1,in2,output [31:0]acc_prod);
	wire [15:0]ALXL,AHXH,AHXL,ALXH;
	approx_mult mult_ALXL(in1[7:0], in2[7:0], ALXL);
 // acc_mult15 mul1(in1[7:0],in2[7:0],ALXL);
	acc_mult15 mul2(in1[15:8],in2[15:8],AHXH);
	approx_mult mult_AHXL(in1[15:8], in2[7:0], AHXL);
	//acc_mult15 mul3(in1[15:8],in2[7:0],AHXL);
	acc_mult15 mul4(in1[7:0],in2[15:8],ALXH);
	pip_acc main(AHXH,ALXL,AHXL,ALXH,acc_prod);

endmodule

module low_approx(input [15:0]in1,in2,output [31:0]acc_prod);
	wire [15:0]ALXL,AHXH,AHXL,ALXH;
	approx_mult mult_ALXL(in1[7:0], in2[7:0], ALXL);
	approx_mult mult_AHXL(in1[15:8], in2[7:0], AHXL);
	approx_mult mult_ALXH(in1[7:0], in2[15:8], ALXH); 

	acc_mult15 mul2(in1[15:8],in2[15:8],AHXH);
	pip_acc main(AHXH,ALXL,AHXL,ALXH,acc_prod);

endmodule

