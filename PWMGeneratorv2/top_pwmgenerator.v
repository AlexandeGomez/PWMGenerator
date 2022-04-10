module top_pwmgenerator #(parameter FRECUENCY_BITS = 2, parameter RESOLUTION_BITS = 8)( //2 - 48.8kHz y 8 resolucion
//inputs
input clk_top, rst_top,
input sum_top, rest_top,
//outputs
output ena_top,
output [RESOLUTION_BITS-1 :0] value_top,
output pwm_out_top,
output enaSel_top,
output [RESOLUTION_BITS-1 : 0] referencia_top
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

//Prescaler para el contador de seleccion
prescaler #( .COUNTER_SIZE(4)) prescalSelec(
//inputs
	.clk	(clk_top),
	.rst	(rst_top),
//outputs	
	.ena	(enaSel_top)
);

//Contador para seleccionar referencia
contadorSelector #( .SIZE_COUNT(RESOLUTION_BITS)) contSel(
//inputs
	.clk	(clk_top),
	.rst	(rst_top),
	.sum	(sum_top),
	.rest	(rest_top),
//outputs
	.valor(referencia_top)
);

endmodule
