`include"accurate_mode.sv"
`include"add.sv"

module mac32(input [31:0] add1,input [15:0]reg1,reg2,output [31:0]mul_out,mac_out);
	//accurate_mode m1(reg1,reg2,mul_out);

	//vhigh_approx m1(reg1,reg2,mul_out);
  //high_approx m1(reg1,reg2,mul_out);
	low_approx m1(reg1,reg2,mul_out);

	adder32 ad1(add1,mul_out,mac_out);
endmodule

