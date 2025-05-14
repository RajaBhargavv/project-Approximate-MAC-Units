
/* module fa(input a, b, cin, output sum, cout);
	wire condition=b^cin;
	assign sum = condition ? (~a) : a;
	assign cout= condition ?  a : b;
endmodule
*/
module adderpg4 (input [4:0]in1,in2,input cin,output [4:0]sum,output cout,output [4:0]PP,GG);
wire [4:0]P,G;
wire [5:0]c;
assign P=in1^in2;
assign G=in1 & in2;
assign {PP,GG}={P,G};
assign c[0]=cin;
assign c[1]=G[0] | P[0] & cin;
assign c[2]=G[1] | P[1] & G[0] | P[1] & P[0] & cin;
assign c[3]=G[2] | P[2] & G[1] | P[2] & P[1] & G[0] | P[2]&P[1]&P[0]&cin;
assign c[4]=G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&cin;
assign c[5]=G[4] | P[4] & G[3] | P[4] & P[3] & G[2] | P[4]&P[3]&P[2]&G[1] | P[4]&P[3]&P[2]&P[1]&G[0] | P[4]&P[3]&P[2]&P[1]&P[0]&cin;
assign cout=c[5];
assign sum = P ^ c;
endmodule

module adderpg4c (input [4:0]in1,in2,output [4:0]sum,output cout, output [4:0]PP,GG);

wire [4:0]P,G;
wire [5:0]c;
assign P=in1^in2;
assign G=in1 & in2;
assign {PP,GG}={P,G};
assign c[0]=1'b0;
assign c[1]=G[0];
assign c[2]=G[1] | P[1] & G[0];
assign c[3]=G[2] | P[2] & G[1] | P[2] & P[1] & G[0];
assign c[4]=G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3]&P[2]&P[1]&G[0];
assign c[5]=G[4] | P[4] & G[3] | P[4] & P[3] & G[2] | P[4]&P[3]&P[2]&G[1] | P[4]&P[3]&P[2]&P[1]&G[0];
assign cout=c[5];
assign sum = P ^ c;
endmodule

module mux(input in0,in1,sel, output out);
	assign out=sel?in1:in0;
endmodule

module adder32(input [31:0]in1,in2,output [31:0]out);
	wire [29:0]P,G;
	wire [5:0]sk;
	wire [7:0]c;
	adderpg4c ad1(in1[4:0],in2[4:0],out[4:0],c[0],P[4:0],G[4:0]);
	mux skip1(c[0],1'b0,&(P[4:0]),sk[0]);

	adderpg4   ad2(in1[9:5],in2[9:5],sk[0],out[9:5],c[1],P[9:5],G[9:5]);
	mux skip2(c[1],sk[0],&(P[9:5]),sk[1]);
	
	adderpg4   ad3(in1[14:10],in2[14:10],sk[1],out[14:10],c[2],P[14:10],G[14:10]);
	mux skip3(c[2],sk[1],&(P[14:10]),sk[2]);

	adderpg4   ad4(in1[19:15],in2[19:15],sk[2],out[19:15],c[3],P[19:15],G[19:15]);
	mux skip4(c[3],sk[2],&(P[19:15]),sk[3]);

	adderpg4   ad5(in1[24:20],in2[24:20],sk[3],out[24:20],c[4],P[24:20],G[24:20]);
	mux skip5(c[4],sk[3],&(P[24:20]),sk[4]);
	
	adderpg4   ad6(in1[29:25],in2[29:25],sk[4],out[29:25],c[5],P[29:25],G[29:25]);
	mux skip6(c[5],sk[4],&(P[29:25]),sk[5]);

	fa f1(in1[30],in2[30],sk[5],out[30],c[6]);
	fa f2(in1[31],in2[31],c[6],out[31],c[7]);

endmodule
