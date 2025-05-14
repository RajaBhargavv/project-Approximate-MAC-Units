module ha(input a, b, output s0, c0);
  assign s0 = a ^ b;
  assign c0 = a & b;
endmodule

module fa(input a, b, cin, output sum, cout);
wire condition=b^cin;
assign sum = condition ? (~a) : a;
assign cout= condition ?  a : b;
endmodule

module adder4 (input [4:0]in1,in2,input cin,output [4:0]sum,output cout);
wire [4:0]P,G;
wire [5:0]c;
assign P=in1^in2;
assign G=in1 & in2;
assign c[0]=cin;
assign c[1]=G[0] | P[0] & cin;
assign c[2]=G[1] | P[1] & G[0] | P[1] & P[0] & cin;
assign c[3]=G[2] | P[2] & G[1] | P[2] & P[1] & G[0] | P[2]&P[1]&P[0]&cin;
assign c[4]=G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&cin;
assign c[5]=G[4] | P[4] & G[3] | P[4] & P[3] & G[2] | P[4]&P[3]&P[2]&G[1] | P[4]&P[3]&P[2]&P[1]&G[0] | P[4]&P[3]&P[2]&P[1]&P[0]&cin;
assign cout=c[5];
assign sum = P ^ c;
endmodule

module adder4c (input [4:0]in1,in2,output [4:0]sum,output cout);
wire [4:0]P,G;
wire [5:0]c;
assign P=in1^in2;
assign G=in1 & in2;
assign c[0]=1'b0;
assign c[1]=G[0];
assign c[2]=G[1] | P[1] & G[0];
assign c[3]=G[2] | P[2] & G[1] | P[2] & P[1] & G[0];
assign c[4]=G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3]&P[2]&P[1]&G[0];
assign c[5]=G[4] | P[4] & G[3] | P[4] & P[3] & G[2] | P[4]&P[3]&P[2]&G[1] | P[4]&P[3]&P[2]&P[1]&G[0];
assign cout=c[5];
assign sum = P ^ c;
endmodule

module add21(input [20:0]add1,add2,output [20:0]sum,output cout);
	wire [3:0]c;
	adder4c a1(add1[4:0],add2[4:0],sum[4:0],c[0]);
	adder4 a2(add1[9:5],add2[9:5],c[0],sum[9:5],c[1]);
	adder4 a3(add1[14:10],add2[14:10],c[1],sum[14:10],c[2]);
	adder4 a4(add1[19:15],add2[19:15],c[2],sum[19:15],c[3]);
	assign sum[20]=add1[20]^add2[20];
	assign cout = (add1[20] & c[3]) | (add2[20] & c[3]) | (add1[20] & add2[20]);

endmodule

