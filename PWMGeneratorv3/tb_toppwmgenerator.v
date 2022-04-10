`timescale 10ns/1ns
module tb_toppwmgenerator #(
parameter FRECUENCY_BITS=3, //2 - 48.8 kHz // 3 - 24.4KHz
parameter RESOLUTION_BITS=8
)();

//inputs
reg clk_tb, rst_tb;
//(contadorSelector)
reg sum_tb, rest_tb;
//(convertido)
reg enaConv_tb;
//outputs
wire ena_tb;
wire [RESOLUTION_BITS-1 :0] value_tb;
wire pwm_out_tb;
//(ContadorSelector)
wire [RESOLUTION_BITS-1 : 0] referencia_tb;
wire enaSel_tb;
//(convertidor)
wire [3:0] fdig_tb;
wire [3:0] sdig_tb;
wire [3:0] tdig_tb;
wire rdy_tb;

//instanciació top generador
top_pwmgenerator #( .FRECUENCY_BITS(FRECUENCY_BITS), .RESOLUTION_BITS(RESOLUTION_BITS)) gen(
//inputs
	.clk_top				(clk_tb), 
	.rst_top				(rst_tb),
	.sum_top				(sum_tb),
	.rest_top			(rest_tb),
	.enaConv_top		(enaConv_tb),
//outputs
	.ena_top				(ena_tb),
	.value_top			(value_tb),
	.pwm_out_top		(pwm_out_tb),
	.referencia_top	(referencia_tb),
	.enaSel_top			(enaSel_tb),
	.fdig_top			(fdig_tb),
	.sdig_top			(sdig_tb),
	.tdig_top			(tdig_tb),
	.rdy_top				(rdy_tb)
);

initial begin
	clk_tb = 1'b0;
	rst_tb = 1'b1;
	sum_tb = 1'b1;
	rest_tb = 1'b1;
	enaConv_tb = 1'b1;
	
	#1 rst_tb =  1'b0;
	#1 rst_tb =  1'b1;
	#1 sum_tb = 1'b0;
	#50 sum_tb = 1'b1;
	#10 rest_tb = 1'b0;
	#10 rest_tb = 1'b1;
	
	
	#10000;
	#1 sum_tb = 1'b0;
	#50 sum_tb = 1'b1;
	
	
	#10000;
	#1 sum_tb = 1'b0;
	#75 sum_tb = 1'b1;
	
	#10000;
	#1 sum_tb = 1'b0;
	#100 sum_tb = 1'b1;
	
	#10000;
	#1 sum_tb = 1'b0;
	#5000 sum_tb = 1'b1;
	
	#20000 $stop;
end

always #1 clk_tb = ~clk_tb;

endmodule
