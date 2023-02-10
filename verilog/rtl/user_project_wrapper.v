// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [63:0] la_data_in,
    output [63:0] la_data_out,
    input  [63:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

wire reg_dir, reg_bus, reg_clk;
wire [`MPRJ_IO_PADS-1:0] io_out, io_in, io_oeb;
wire [31:0] wbs_dat_o;

localparam SPI_ADDR_WIDTH = 'd1;
localparam SPI_REG_WIDTH = 'd8;

wire [SPI_ADDR_WIDTH:0] reg_addr;

assign wbs_ack_o = 1'b1;
assign wbs_dat_o = 32'b0;
assign la_data_out = 64'b0;
assign io_out[0:4] = 5'b0;
assign io_out[25:`MPRJ_IO_PADS-1] = `MPRJ_IO_PADS-26;
assign io_oeb = 1'b1;	// Unused
assign irq = 'b000;	// Unused

spi_device #('d8, SPI_REG_WIDTH, SPI_ADDR_WIDTH) ctrl(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),
	.vssd1(vssd1),
`endif
	.spi_miso (io_out[5]),
	.spi_mosi(io_in[6]),
	.spi_clk(io_in[7]),
	.spi_sel(io_in[8]),
	.reg_dir(reg_dir),
	.reg_bus(reg_bus),
	.reg_clk(reg_clk),
	.reg_addr(reg_addr)
);

spi_register #(SPI_REG_WIDTH, SPI_ADDR_WIDTH, 1'd0) spi_reg0 (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),
	.vssd1(vssd1),
`endif
	.reg_dir(reg_dir),
	.reg_bus(reg_bus),
	.reg_clk(reg_clk),
	.reg_addr(reg_addr),
	.reg_data(io_out[9:16])
);

spi_register #(SPI_REG_WIDTH, SPI_ADDR_WIDTH, 1'd1) spi_reg1 (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),
	.vssd1(vssd1),
`endif
	.reg_dir(reg_dir),
	.reg_bus(reg_bus),
	.reg_clk(reg_clk),
	.reg_addr(reg_addr),
	.reg_data(io_out[17:24])
);

endmodule	// user_project_wrapper

`default_nettype wire
