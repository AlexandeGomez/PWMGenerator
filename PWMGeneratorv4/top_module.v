module top_module #(parameter BITS_FRECUENCY = 3, parameter BITS_RESOLUTION = 8, parameter CONVER_SPEED = 2 ,parameter CONT_SPEED = 4)(
//inputs//
input clk_top, rst_top, sum_top, rest_top,

//outputs//
output enaGen, enaSel, enaConv, pwm_top, rdy_top,
output [BITS_RESOLUTION-1 : 0] valorReference,
output [BITS_RESOLUTION-1 : 0] valueGenerator,
output [3:0] fdig_top, sdig_top,	tdig_top,
output [7:0] seg_data1, seg_data2, seg_data3
);


// --------------------------- Prescalers --------------------
prescaler #( .COUNTER_SIZE(BITS_FRECUENCY)) prescalerGenerador( 
//in
	.clk	(clk_top),
	.rst	(rst_top), 
//out
	.ena	(enaGen)
);

prescaler #( .COUNTER_SIZE(CONT_SPEED)) prescalerSelector( 
//in
	.clk	(clk_top),
	.rst	(rst_top), 
//out
	.ena	(enaSel)
);

prescaler #( .COUNTER_SIZE(CONVER_SPEED)) prescalerConvertidor( 
//in
	.clk	(clk_top),
	.rst	(rst_top), 
//out
	.ena	(enaConv)
);

//------------------------- Contador Selector-------------------
contadorSelector #(	.SIZE_COUNT(BITS_RESOLUTION)) sel(
//in
	.clk	(clk_top),
	.rst	(rst_top),
	.ena 	(enaSel),
	.sum	(sum_top),
	.rest	(rest_top),
//out
	.valor(valorReference)
);

//------------------------ Contador Generador ------------------
contadorGenerador #( .RESOLUTION_BITS(BITS_RESOLUTION)) gen(
//in
	.clk	(clk_top),
	.rst	(rst_top),
	.ena	(enaGen),
//out
	.value(valueGenerator)
);

// ---------------------- Comparador ----------------------------
comparador #( .RESOLUTION_BITS(BITS_RESOLUTION)) comp(
//in
	.clk				(clk_top),
	.value			(valueGenerator),
	.referencia		(valorReference),
//out
	.pwm_out			(pwm_top)
);


//----------------------- Convertidor -------------------------
BCDConvert conv(
//in
	.clk			(enaConv),
	.bin_d_in	(valorReference),
//out
	.fdig			(fdig_top),
	.sdig			(sdig_top),
	.tdig			(tdig_top),
	.rdy			(rdy_top)
);

//----------------------- Decodificadores -------------------
seg_decoder dec_first(
//in
	.bin_data	(fdig_top),
	.ena			(rdy_top),
//out
	.seg_data	(seg_data1)
);

seg_decoder dec_second(
//in
	.bin_data	(sdig_top),
	.ena			(rdy_top),
//out
	.seg_data	(seg_data2)
);

seg_decoder dec_thirt(
//in
	.bin_data	(tdig_top),
	.ena			(rdy_top),
//out
	.seg_data	(seg_data3)
);

endmodule
