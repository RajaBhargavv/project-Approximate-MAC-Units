/*module pip_acc(input [15:0]a,b,c,d, output [31:0]prod);
assign 	prod[7:0]=b[7:0];
wire [15:0]x= {a[7:0],b[15:8]};
wire [15:0]s,cc;
genvar i; 
for(i=0;i<=15;i=i+1)begin
	fa f_i(c[i],d[i],x[i],s[i],cc[i]);
end
assign prod[8]=b[8];
adder4c ad1(s[5:1],cc[4:0],prod[13:9],cout[0]);
adder4 ad2(s[10:6],cc[9:5],cout[0],prod[18:14],cout[1]);
adder4 ad3(s[15:11],cc[14:10],cout[1],prod[23:19],cout[2]);
wire [5:0]bb={4'b0,cc[15]};
adder4 ad4(a[12:8],bb,cout[2],prod[28:24],cout[3]);\
ha ff1(a[13],cout[4],prod[29],cout[5]);
ha ff2(a[14],cout[5],prod[30],cout[6]);
ha ff3(a[15],cout[6],prod[31],cout[7]);

endmodule
*/
module pip_acc(input [15:0]a,b,c,d, output [31:0]prod);
assign 	prod[7:0]=b[7:0];
wire [15:0]x= {a[7:0],b[15:8]};
wire [15:0]s,cs;
genvar i; 
for(i=0;i<=15;i=i+1)begin
	fa f_i(x[i],c[i],d[i],s[i],cs[i]);
end
assign prod[8]=s[0];
wire [6:0]cout;
adder4c ad1(s[5:1],cs[4:0],prod[13:9],cout[0]);
adder4  ad2(s[10:6],cs[9:5],cout[0],prod[18:14],cout[1]);
adder4  ad3(s[15:11],cs[14:10],cout[1],prod[23:19],cout[2]);
wire [4:0]bb={4'b0,cs[15]};

adder4 ad4(a[12:8],bb,cout[2],prod[28:24],cout[3]);
ha hf1(a[13],cout[3],prod[29],cout[4]);
ha hf2(a[14],cout[4],prod[30],cout[5]);
ha hf3(a[15],cout[5],prod[31],cout[6]);

endmodule
