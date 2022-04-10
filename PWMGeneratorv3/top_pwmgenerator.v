module top_pwmgenerator #(parameter FRECUENCY_BITS = 3, parameter RESOLUTION_BITS = 8)( //2 - 48.8kHz y 8 resolucion
//inputs
input clk_top, rst_top,
input sum_top, rest_top,
//in convertidor bcd
input 	enaConv_top,

//outputs
output ena_top,
output [RESOLUTION_BITS-1 :0] value_top,
output pwm_out_top,
output enaSel_top,
output [RESOLUTION_BITS-1 : 0] referencia_top,

//out de convertido bcd
output [3:0] fdig_top,
output [3:0] sdig_top,
output [3:0] tdig_top,
output 	rdy_top
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
	.clk	(enaSel_top),
	.rst	(rst_top),
	.sum	(sum_top),
	.rest	(rest_top),
//outputs
	.valor(referencia_top)
);

//Instanciando convertidor bcd
BCDConvert bcdConv(
	.clk	(clk_top),
	.ena	(enaConv_top),
	.bin_d_in(referencia_top),

//output 	[11:0] bcd_d_out,
	.fdig	(fdig_top),
	.sdig	(sdig_top),
	.tdig	(tdig_top),
	.rdy	(rdy_top)
);

endmodule
