module top_pwmgenerator #(parameter FRECUENCY_BITS=10, parameter RESOLUTION_BITS=8)(
//inputs
input clk_top, rst_top,
input [RESOLUTION_BITS-1 : 0] referencia_top,
//outputs
output ena_top,
output [RESOLUTION_BITS-1 :0] value_top,
output pwm_out_top
);

//Instanciando Prescaler
prescaler #( .COUNTER_SIZE(FRECUENCY_BITS)) prescal(
//inputs
	.clk	(clk_top),
	.rst	(rst_top),
//outputs	
	.ena	(ena_top)
);

//Instanciando contador de n bits
contador #( .RESOLUTION_BITS(RESOLUTION_BITS)) cnt(
//inputs
	.clk	(clk_top),
	.rst	(rst_top),
	.ena	(ena_top),
//output
	.value (value_top)
);

//Instanciando comparador
comparador #( .RESOLUTION_BITS(RESOLUTION_BITS)) comp(
//inputs
	.clk	(clk_top),
	.value(value_top),
	.referencia	(referencia_top),
//outputs
	.pwm_out(pwm_out_top)
);

endmodule
