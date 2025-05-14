`include"mac32.sv"
module top;
reg [15:0] in1,in2;
reg [31:0] product,add1,mac_out;
reg seed=1231;
int unsigned mult,mac_m;
integer error1=0,error2=0,error=0;
integer count=10;
int unsigned total_error=0,total_product=0;
real error_percent;
real error_per;

mac32 dut(.add1(add1),.reg1(in1),.reg2(in2),.mul_out(product),.mac_out(mac_out));

initial begin
	repeat(count) begin
		in1=$random;
		in2=$random;
		add1=$random;
		mult=in1*in2;
		mac_m=mult+add1;
		#0;
		error1=product-mult;
		error2=mult-product;
		error=error1>error2?error1:error2;
		#1;
		total_product=total_product+mult;
		total_error=total_error+error;
		#1;
		error_per=real'((product/mult)*100);	
		#1;
		$display("************************************************************");
		$display("Expected output in1=%d_%b and in2=%d_%b multiply is == %d_%b and mac=%d_%b",in1,in1,in2,in2,mult,mult,mac_m,mac_m);
		$display("Actual   output in1=%d_%b and in2=%d_%b is multiply == %d_%b mac=%d_%b",in1,in1,in2,in2,product,product,mac_out,mac_out);
		$display("______________________________________________ERROR=%d_________________", error1>error2?error1:error2);
		if(mult==product && mac_m==mac_out) $display("-------------------------- -------------------------------PASS----------------------------------------");
		//else $display("-----------FAIL----------");
		$display("************************************************************");
		#10;
	end
	#1;
	error_percent= real'((total_error*100)/total_product) ;
	$display("___________________total error=%d  >>>>>  totalProduct=%d_______",total_error,total_product);
	#1 $finish;
end
endmodule

