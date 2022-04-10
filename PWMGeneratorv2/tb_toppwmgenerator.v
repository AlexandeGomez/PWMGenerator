`timescale 10ns/1ns
module tb_toppwmgenerator #(
parameter FRECUENCY_BITS=2, //2 - 48.8 kHz // 3 - 24.4KHz
parameter RESOLUTION_BITS=8
)();

//inputs
reg clk_tb, rst_tb;
//(contadorSelector)
reg sum_tb, rest_tb;
//outputs
wire ena_tb;
wire [RESOLUTION_BITS-1 :0] value_tb;
wire pwm_out_tb;
//(ContadorSelector)
wire [RESOLUTION_BITS-1 : 0] referencia_tb;
wire enaSel_tb;

//instanciació top generador
top_pwmgenerator #( .FRECUENCY_BITS(FRECUENCY_BITS), .RESOLUTION_BITS(RESOLUTION_BITS)) gen(
//inputs
	.clk_top				(clk_tb), 
	.rst_top				(rst_tb),
	.sum_top				(sum_tb),
	.rest_top			(rest_tb),
//outputs
	.ena_top				(ena_tb),
	.value_top			(value_tb),
	.pwm_out_top		(pwm_out_tb),
	.referencia_top	(referencia_tb),
	.enaSel_top			(enaSel_tb)
);

initial begin
	clk_tb = 1'b0;
	rst_tb = 1'b1;
	sum_tb = 1'b1;
	rest_tb = 1'b1;
	
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
	#200 sum_tb = 1'b1;
	
	#10000 $stop;
end

always #1 clk_tb = ~clk_tb;

endmodule
