`timescale 10ns/1ns
module tb_toppwmgenerator #(
parameter FRECUENCY_BITS=6, //3 - 24.4KHz
parameter RESOLUTION_BITS=8
)();

//inputs
reg clk_tb, rst_tb;
reg [RESOLUTION_BITS-1 : 0] referencia_tb;
//outputs
wire ena_tb;
wire [RESOLUTION_BITS-1 :0] value_tb;
wire pwm_out_tb;

//instanciació top generador
top_pwmgenerator #( .FRECUENCY_BITS(FRECUENCY_BITS), .RESOLUTION_BITS(RESOLUTION_BITS)) gen(
//inputs
	.clk_top				(clk_tb), 
	.rst_top				(rst_tb),
	.referencia_top	(referencia_tb),
//outputs
	.ena_top				(ena_tb),
	.value_top			(value_tb),
	.pwm_out_top		(pwm_out_tb)
);

initial begin
	clk_tb = 1'b0;
	rst_tb = 1'b1;
	referencia_tb = 8'd200;
	
	#1 rst_tb =  1'b0;
	#1 rst_tb =  1'b1;
	#5000 referencia_tb = 8'd100;
	#5000 referencia_tb = 8'd50;
	#20000 $stop;
end

always #1 clk_tb = ~clk_tb;

endmodule
