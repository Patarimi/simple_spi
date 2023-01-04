`default_nettype none

module spi_wrapper(
`ifdef USE_POWER_PINS
	inout vdd,
	inout vss,
`endif

	input wire wb_clk_i,
	input wire wb_rst_i,

	input wire [`MPRJ_IO_PADS-1:0] io_in,
	output wire [`MPRJ_IO_PADS-1:0] io_out,
	output wire [`MPRJ_IO_PADS-1:0] io_oeb,
);

	assign io_oeb = {`MPRJ_IO_PADS{1'b0}};

	wire reset = ! wb_rst_i;
	
	spi_device spi_device(
		.mosi(io_in[5]),
		.sck(wb_clk_i),
		.ssn(io_in[6]),
		.miso(io_out[7]),

		.rword(io_out[8:15]),
		.sword(io_in[16:22]),
		.ovalid(io_out[23]),
		.oready(io_in[24])
	);


endmodule
`default_nettype wire
