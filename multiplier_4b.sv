module CLA(
  input [7:0]A, B,
  input Cin,
  output [7:0] S,
  output Cout
);
  wire [7:0] Ci;
 
  assign Ci[0] = Cin;
  assign Ci[1] = (A[0] & B[0]) | ((A[0]^B[0]) & Ci[0]);
  assign Ci[2] = (A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])));
  assign Ci[3] = (A[2] & B[2]) | ((A[2]^B[2]) & ((A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])))));
  assign Ci[4] = (A[3] & B[3]) | ((A[3]^B[3]) & Ci[3]);
  assign Ci[5] = (A[4] & B[4]) | ((A[4]^B[4]) & Ci[4]);
  assign Ci[6] = (A[5] & B[5]) | ((A[5]^B[5]) & Ci[5]);
  assign Ci[7] = (A[6] & B[6]) | ((A[6]^B[6]) & Ci[6]);
  assign Cout = (A[7] & B[7]) | ((A[7]^B[7]) & Ci[7]);
  assign S = A^B^Ci;
endmodule


module multiplier_4b(input [3:0] A, B, output [7:0] P);
  wire [3:0] R0, R1, R2, R3;
  wire [4:0] X,Y;
  wire [5:-2] M;
  wire [4:-3] N;
  wire car;
  // generation of partial products;
  genvar g;
  generate
    for(g = 0; g<4; g=g+1) begin
      and (R0[g], A[g], B[0]);
      and (R1[g], A[g], B[1]);
      and (R2[g], A[g], B[2]);
      and (R3[g], A[g], B[3]);
    end
  endgenerate
 
  // generation of sums and carries
  ha add1(R0[1],R1[0],X[0],Y[0]);
  fa add2(R0[2],R1[1],R2[0],X[1],Y[1]);
  fa add3(R0[3],R1[2],R2[1],X[2],Y[2]);
  fa add4(R1[3],R2[2],R3[1],X[3],Y[3]);
  ha add5(R2[3],R3[2],X[4],Y[4]);
 
  ha add6(X[1],Y[0],M[0],N[0]);
  fa add7(X[2],Y[1],R3[0],M[1],N[1]);
  ha add8(X[3],Y[2],M[2],N[2]);
  ha add9(X[4],Y[3],M[3],N[3]);
  ha add10(R3[3],Y[4],M[4],N[4]);
 
  assign M[-1]=X[0];
  assign M[-2]=R0[0];
  assign M[5]=0;
  assign N[-1]=0;
  assign N[-2]=0;
  assign N[-3]=0;
 
  CLA add11(M,N,1'b0,P,car);
 
endmodule
