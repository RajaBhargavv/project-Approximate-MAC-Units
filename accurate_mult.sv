module accurates(input [7:0]in1,in2,output [7:0]b,a,c,d);

	multiplier_4b mult_AHHXHL(in1[7:4], in2[3:0], c);
	multiplier_4b mult_AHHXHH(in1[7:4], in2[7:4], b);
	multiplier_4b mult_AHLXHL(in1[3:0], in2[3:0], a);
	multiplier_4b mult_AHLXHH(in1[3:0], in2[7:4], d);
	
endmodule


module acc_mult(input [7:0]b,a,c,d,output [15:0]ap);
	wire [7:0]s,cc;
	fa f1(a[4],c[0],d[0],s[0],cc[0]);
	fa f2(a[5],c[1],d[1],s[1],cc[1]);
	fa f3(a[6],c[2],d[2],s[2],cc[2]);
	fa f4(a[7],c[3],d[3],s[3],cc[3]);
	
	fa f5(b[0],c[4],d[4],s[4],cc[4]);
	fa f6(b[1],c[5],d[5],s[5],cc[5]);
	fa f7(b[2],c[6],d[6],s[6],cc[6]);
	fa f8(b[3],c[7],d[7],s[7],cc[7]);
	assign ap[4:0]={s[0],a[3:0]};
	wire [6:0]ccc;
	adder4 add(s[5:1],cc[4:0],1'b0,ap[9:5],ccc[0]);
	fa ff1(s[6],cc[5],ccc[0],ap[10],ccc[1]);
	fa ff2(s[7],cc[6],ccc[1],ap[11],ccc[2]);
	fa ff3(b[4],cc[7],ccc[2],ap[12],ccc[3]);
	ha h1(b[5],ccc[3],ap[13],ccc[4]);
	ha h2(b[6],ccc[4],ap[14],ccc[5]);
	ha h3(b[7],ccc[5],ap[15],ccc[6]);

endmodule

module acc_mult15(input [7:0]in1,in2,output [15:0]ap);
	wire [7:0]b,a,c,d;
	accurates acc(in1,in2,b,a,c,d);
	acc_mult mul(b,a,c,d,ap);
endmodule
