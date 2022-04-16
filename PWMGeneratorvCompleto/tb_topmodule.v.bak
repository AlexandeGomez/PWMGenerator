`timescale 1ns/1ns
module tb_topmodule();

reg clk_tb, rst_tb, sum_tb, rest_tb;
wire enaGen_tb, enaSel_tb, enaConv_tb, pwm_tb, rdy_tb;
wire [7 : 0] valorReference_tb;
wire [7 : 0] valueGenerator_tb;
wire [3:0] fdig_tb, sdig_tb,	tdig_tb;
wire [7:0] seg_data1_tb, seg_data2_tb, seg_data3_tb;

top_module #( .BITS_FRECUENCY(3), .BITS_RESOLUTION(8), .CONVER_SPEED(2), .CONT_SPEED(4)) tpmod(
//inputs//
	.clk_top	(clk_tb),
	.rst_top	(rst_tb),
	.sum_top	(sum_tb),
	.rest_top(rest_tb),

//outputs//
	.enaGen	(enaGen_tb),
	.enaSel	(enaSel_tb),
	.enaConv	(enaConv_tb),
	.pwm_top	(pwm_tb),
	.rdy_top	(rdy_tb),
	
	.valorReference	(valorReference_tb),
	.valueGenerator	(valueGenerator_tb),
	
	.fdig_top	(fdig_tb), 
	.sdig_top	(sdig_tb),
	.tdig_top	(tdig_tb),

	.seg_data1	(seg_data1_tb),
	.seg_data2	(seg_data2_tb),
	.seg_data3	(seg_data3_tb)
);

initial begin
	clk_tb = 1'b0; 
	rst_tb = 1'b1;
	sum_tb = 1'b1;
	rest_tb = 1'b1;
	
	#1 rst_tb = 1'b0;
	#1 rst_tb = 1'b1;
	
	#1 rest_tb = 1'b0;
	#1000 rest_tb = 1'b1;
	
	#10000 sum_tb = 1'b0;
	#100 sum_tb = 1'b1;
	
	#10000 rest_tb = 1'b0;
	#1000 rest_tb = 1'b1;
	
	#10000 $stop;
end

always #1 clk_tb = ~clk_tb;
endmodule
