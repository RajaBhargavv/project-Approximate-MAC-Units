
module approx_mult(input [7:0]in1,in2,output [15:0]out_oppx);
	
	wire [7:0]reg_par[7:0];
	genvar i;
	wire cin;
	for(i=0;i<8;i=i+1)begin
		assign reg_par[i] = in1 & {8{in2[i]}};  
	end
	assign out_oppx[4]=1'b1;
	assign out_oppx[5]=1'b1;
	assign out_oppx[6]=1'b1;
	assign out_oppx[7]=1'b1;
	assign cin=reg_par[0][7] | reg_par[1][6] | reg_par[2][5] | reg_par[3][4] | reg_par[4][3] | reg_par[5][2] | reg_par[6][1] | reg_par[7][0];
	
	assign out_oppx[0]=reg_par[0][0];
	wire [13:1]s;
	wire [13:1]c;
	ha h1(reg_par[0][1],reg_par[1][0],s[1],c[1]);
	assign out_oppx[1]=s[1];
	
	wire [9:0]ss;
	wire [9:0]css;
	fa f1(reg_par[0][2],reg_par[1][1],reg_par[2][0],s[2],c[2]);
	ha h2(s[2],c[1],ss[0],css[0]);
	assign out_oppx[2]=ss[0];
	
	wire [6:0]sss;
	wire [6:0]csss;
	fa f2(reg_par[0][3],reg_par[1][2],reg_par[2][1],s[3],c[3]);
	fa f3(s[3],reg_par[3][0],c[2],ss[1],css[1]);
	ha h3(ss[1],css[0],sss[0],csss[0]);
	assign out_oppx[3]=sss[0];


	fa f4(reg_par[1][7],reg_par[2][6],cin,s[4],c[4]);
	fa f5(reg_par[3][5],reg_par[4][4],reg_par[5][3],s[5],c[5]);
	ha h4(reg_par[6][2],reg_par[7][1],s[6],c[6]);
	
	fa f6(s[4],s[5],s[6],ss[2],css[2]);
	assign out_oppx[8]=ss[2];

	fa f7(reg_par[2][7],reg_par[3][6],reg_par[4][5],s[7],c[7]);
	fa f8(reg_par[5][4],reg_par[6][3],reg_par[7][2],s[8],c[8]);
	fa f9(s[7],s[8],c[4],ss[3],css[3]);
	ha h5(c[5],c[6],ss[9],css[9]);
	
	fa f10(ss[3],ss[9],css[2],sss[1],csss[1]);
	assign out_oppx[9]=sss[1];
	
	fa f11(reg_par[3][7],reg_par[4][6],reg_par[5][5],s[9],c[9]);
	ha h6(reg_par[6][4],reg_par[7][3],s[10],c[10]);
	fa f12(s[9],s[10],c[7],ss[4],css[4]);
	fa f13(ss[4],c[8],css[3],sss[2],csss[2]);

	fa f14(reg_par[4][7],reg_par[5][6],reg_par[6][5],s[11],c[11]);
	fa f15(s[11],reg_par[7][4],c[9],ss[5],css[5]);
	fa f16(ss[5],c[10],css[4],sss[3],csss[3]);
//12
	fa f17(reg_par[5][7],reg_par[6][6],reg_par[7][5],s[12],c[12]);
	ha h7(s[12],c[11],ss[6],css[6]);
	ha h8(ss[6],css[5],sss[4],csss[4]);
	//13
	ha h9(reg_par[6][7],reg_par[7][6],s[13],c[13]);
	ha h10(s[13],c[12],ss[7],css[7]);
	ha h11(ss[7],css[6],sss[5],csss[5]);
	//14
	ha h12(reg_par[7][7],c[13],ss[8],css[8]);
	ha h13(ss[8],css[7],sss[6],csss[6]);
	//15 stage 3 adder
	wire [5:0]ca;
	fa a1(sss[2],css[9],csss[1],out_oppx[10],ca[0]);
	fa a2(sss[3],csss[2],ca[0],out_oppx[11],ca[1]);
	fa a3(sss[4],csss[3],ca[1],out_oppx[12],ca[2]);
	fa a4(sss[5],csss[4],ca[2],out_oppx[13],ca[3]);
	fa a5(sss[6],csss[5],ca[4],out_oppx[14],ca[4]);
	fa a6(css[8],csss[6],ca[5],out_oppx[15],ca[5]);

endmodule
