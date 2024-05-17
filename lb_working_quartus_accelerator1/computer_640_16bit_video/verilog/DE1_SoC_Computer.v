

module DE1_SoC_Computer (
	////////////////////////////////////
	// FPGA Pins
	////////////////////////////////////

	// Clock pins
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,
	CLOCK4_50,

	// ADC
	ADC_CS_N,
	ADC_DIN,
	ADC_DOUT,
	ADC_SCLK,

	// Audio
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,

	// SDRAM
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_LDQM,
	DRAM_RAS_N,
	DRAM_UDQM,
	DRAM_WE_N,

	// I2C Bus for Configuration of the Audio and Video-In Chips
	FPGA_I2C_SCLK,
	FPGA_I2C_SDAT,

	// 40-Pin Headers
	GPIO_0,
	GPIO_1,
	
	// Seven Segment Displays
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,

	// IR
	IRDA_RXD,
	IRDA_TXD,

	// Pushbuttons
	KEY,

	// LEDs
	LEDR,

	// PS2 Ports
	PS2_CLK,
	PS2_DAT,
	
	PS2_CLK2,
	PS2_DAT2,

	// Slider Switches
	SW,

	// Video-In
	TD_CLK27,
	TD_DATA,
	TD_HS,
	TD_RESET_N,
	TD_VS,

	// VGA
	VGA_B,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS,

	////////////////////////////////////
	// HPS Pins
	////////////////////////////////////
	
	// DDR3 SDRAM
	HPS_DDR3_ADDR,
	HPS_DDR3_BA,
	HPS_DDR3_CAS_N,
	HPS_DDR3_CKE,
	HPS_DDR3_CK_N,
	HPS_DDR3_CK_P,
	HPS_DDR3_CS_N,
	HPS_DDR3_DM,
	HPS_DDR3_DQ,
	HPS_DDR3_DQS_N,
	HPS_DDR3_DQS_P,
	HPS_DDR3_ODT,
	HPS_DDR3_RAS_N,
	HPS_DDR3_RESET_N,
	HPS_DDR3_RZQ,
	HPS_DDR3_WE_N,

	// Ethernet
	HPS_ENET_GTX_CLK,
	HPS_ENET_INT_N,
	HPS_ENET_MDC,
	HPS_ENET_MDIO,
	HPS_ENET_RX_CLK,
	HPS_ENET_RX_DATA,
	HPS_ENET_RX_DV,
	HPS_ENET_TX_DATA,
	HPS_ENET_TX_EN,

	// Flash
	HPS_FLASH_DATA,
	HPS_FLASH_DCLK,
	HPS_FLASH_NCSO,

	// Accelerometer
	HPS_GSENSOR_INT,
		
	// General Purpose I/O
	HPS_GPIO,
		
	// I2C
	HPS_I2C_CONTROL,
	HPS_I2C1_SCLK,
	HPS_I2C1_SDAT,
	HPS_I2C2_SCLK,
	HPS_I2C2_SDAT,

	// Pushbutton
	HPS_KEY,

	// LED
	HPS_LED,
		
	// SD Card
	HPS_SD_CLK,
	HPS_SD_CMD,
	HPS_SD_DATA,

	// SPI
	HPS_SPIM_CLK,
	HPS_SPIM_MISO,
	HPS_SPIM_MOSI,
	HPS_SPIM_SS,

	// UART
	HPS_UART_RX,
	HPS_UART_TX,

	// USB
	HPS_CONV_USB_N,
	HPS_USB_CLKOUT,
	HPS_USB_DATA,
	HPS_USB_DIR,
	HPS_USB_NXT,
	HPS_USB_STP
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

////////////////////////////////////
// FPGA Pins
////////////////////////////////////

// Clock pins
input						CLOCK_50;
input						CLOCK2_50;
input						CLOCK3_50;
input						CLOCK4_50;

// ADC
inout						ADC_CS_N;
output					ADC_DIN;
input						ADC_DOUT;
output					ADC_SCLK;

// Audio
input						AUD_ADCDAT;
inout						AUD_ADCLRCK;
inout						AUD_BCLK;
output					AUD_DACDAT;
inout						AUD_DACLRCK;
output					AUD_XCK;

// SDRAM
output 		[12: 0]	DRAM_ADDR;
output		[ 1: 0]	DRAM_BA;
output					DRAM_CAS_N;
output					DRAM_CKE;
output					DRAM_CLK;
output					DRAM_CS_N;
inout			[15: 0]	DRAM_DQ;
output					DRAM_LDQM;
output					DRAM_RAS_N;
output					DRAM_UDQM;
output					DRAM_WE_N;

// I2C Bus for Configuration of the Audio and Video-In Chips
output					FPGA_I2C_SCLK;
inout						FPGA_I2C_SDAT;

// 40-pin headers
inout			[35: 0]	GPIO_0;
inout			[35: 0]	GPIO_1;

// Seven Segment Displays
output		[ 6: 0]	HEX0;
output		[ 6: 0]	HEX1;
output		[ 6: 0]	HEX2;
output		[ 6: 0]	HEX3;
output		[ 6: 0]	HEX4;
output		[ 6: 0]	HEX5;

// IR
input						IRDA_RXD;
output					IRDA_TXD;

// Pushbuttons
input			[ 3: 0]	KEY;

// LEDs
output		[ 9: 0]	LEDR;

// PS2 Ports
inout						PS2_CLK;
inout						PS2_DAT;

inout						PS2_CLK2;
inout						PS2_DAT2;

// Slider Switches
input			[ 9: 0]	SW;

// Video-In
input						TD_CLK27;
input			[ 7: 0]	TD_DATA;
input						TD_HS;
output					TD_RESET_N;
input						TD_VS;

// VGA
output		[ 7: 0]	VGA_B;
output					VGA_BLANK_N;
output					VGA_CLK;
output		[ 7: 0]	VGA_G;
output					VGA_HS;
output		[ 7: 0]	VGA_R;
output					VGA_SYNC_N;
output					VGA_VS;



////////////////////////////////////
// HPS Pins
////////////////////////////////////
	
// DDR3 SDRAM
output		[14: 0]	HPS_DDR3_ADDR;
output		[ 2: 0]  HPS_DDR3_BA;
output					HPS_DDR3_CAS_N;
output					HPS_DDR3_CKE;
output					HPS_DDR3_CK_N;
output					HPS_DDR3_CK_P;
output					HPS_DDR3_CS_N;
output		[ 3: 0]	HPS_DDR3_DM;
inout			[31: 0]	HPS_DDR3_DQ;
inout			[ 3: 0]	HPS_DDR3_DQS_N;
inout			[ 3: 0]	HPS_DDR3_DQS_P;
output					HPS_DDR3_ODT;
output					HPS_DDR3_RAS_N;
output					HPS_DDR3_RESET_N;
input						HPS_DDR3_RZQ;
output					HPS_DDR3_WE_N;

// Ethernet
output					HPS_ENET_GTX_CLK;
inout						HPS_ENET_INT_N;
output					HPS_ENET_MDC;
inout						HPS_ENET_MDIO;
input						HPS_ENET_RX_CLK;
input			[ 3: 0]	HPS_ENET_RX_DATA;
input						HPS_ENET_RX_DV;
output		[ 3: 0]	HPS_ENET_TX_DATA;
output					HPS_ENET_TX_EN;

// Flash
inout			[ 3: 0]	HPS_FLASH_DATA;
output					HPS_FLASH_DCLK;
output					HPS_FLASH_NCSO;

// Accelerometer
inout						HPS_GSENSOR_INT;

// General Purpose I/O
inout			[ 1: 0]	HPS_GPIO;

// I2C
inout						HPS_I2C_CONTROL;
inout						HPS_I2C1_SCLK;
inout						HPS_I2C1_SDAT;
inout						HPS_I2C2_SCLK;
inout						HPS_I2C2_SDAT;

// Pushbutton
inout						HPS_KEY;

// LED
inout						HPS_LED;

// SD Card
output					HPS_SD_CLK;
inout						HPS_SD_CMD;
inout			[ 3: 0]	HPS_SD_DATA;

// SPI
output					HPS_SPIM_CLK;
input						HPS_SPIM_MISO;
output					HPS_SPIM_MOSI;
inout						HPS_SPIM_SS;

// UART
input						HPS_UART_RX;
output					HPS_UART_TX;

// USB
inout						HPS_CONV_USB_N;
input						HPS_USB_CLKOUT;
inout			[ 7: 0]	HPS_USB_DATA;
input						HPS_USB_DIR;
input						HPS_USB_NXT;
output					HPS_USB_STP;

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire			[15: 0]	hex3_hex0;
//wire			[15: 0]	hex5_hex4;

//assign HEX0 = ~hex3_hex0[ 6: 0]; // hex3_hex0[ 6: 0]; 
//assign HEX1 = ~hex3_hex0[14: 8];
//assign HEX2 = ~hex3_hex0[22:16];
//assign HEX3 = ~hex3_hex0[30:24];
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;

HexDigit Digit0(HEX0, hex3_hex0[3:0]);
HexDigit Digit1(HEX1, hex3_hex0[7:4]);
HexDigit Digit2(HEX2, hex3_hex0[11:8]);
HexDigit Digit3(HEX3, hex3_hex0[15:12]);

wire [31:0] pipes;

assign pipes = {22'd0,SW[9],,SW[8],SW[8],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0]};


//======================our code here===========

wire signed [31:0] n0_in0;
wire signed [31:0] ns_in0;
wire signed [31:0] nn_in0;
wire signed [31:0] nw_in0;
wire signed [31:0] ne_in0;
wire signed [31:0] nnw_in0;
wire signed [31:0] nne_in0;
wire signed [31:0] nsw_in0;
wire signed [31:0] nse_in0;

wire signed [26:0] n0_out0;
wire signed [26:0] ns_out0;
wire signed [26:0] nn_out0;
wire signed [26:0] nw_out0;
wire signed [26:0] ne_out0;
wire signed [26:0] nnw_out0;
wire signed [26:0] nne_out0;
wire signed [26:0] nsw_out0;
wire signed [26:0] nse_out0;

wire signed [26:0] ux_out;
wire signed [26:0] uy_out;
wire signed [31:0] omega_in;
wire signed [31:0] one9th0;
wire signed [31:0] one36th0;

//==========================================







collide b0(
.n0_in(n0_in0[26:0]),
.ns_in(ns_in0[26:0]),
.nn_in(nn_in0[26:0]),
.nw_in(nw_in0[26:0]),
.ne_in(ne_in0[26:0]),
.nnw_in(nnw_in0[26:0]),
.nne_in(nne_in0[26:0]),
.nsw_in(nsw_in0[26:0]),
.nse_in(nse_in0[26:0]),
.omega(27'd65922266),
.one9th(27'd3728270),
.one36th(27'd932067),
.n0_out(n0_out0[26:0]),
.ns_out(ns_out0[26:0]),
.nn_out(nn_out0[26:0]),
.nw_out(nw_out0[26:0]),
.ne_out(ne_out0[26:0]),
.nnw_out(nnw_out0[26:0]),
.nne_out(nne_out0[26:0]),
.nsw_out(nsw_out0[26:0]),
.nse_out(nse_out0[26:0]),
.ux(ux_out[26:0]),
.uy(uy_out[26:0]) 
);


//=======================================================
//  Structural coding
//=======================================================

Computer_System The_System (
	////////////////////////////////////
	// FPGA Side
	////////////////////////////////////

	// Global signals
	.system_pll_ref_clk_clk					(CLOCK_50),
	.system_pll_ref_reset_reset			(1'b0),

	// AV Config
	.av_config_SCLK							(FPGA_I2C_SCLK),
	.av_config_SDAT							(FPGA_I2C_SDAT),

	// VGA Subsystem
	.vga_pll_ref_clk_clk 					(CLOCK2_50),
	.vga_pll_ref_reset_reset				(1'b0),
	.vga_CLK										(VGA_CLK),
	.vga_BLANK									(VGA_BLANK_N),
	.vga_SYNC									(VGA_SYNC_N),
	.vga_HS										(VGA_HS),
	.vga_VS										(VGA_VS),
	.vga_R										(VGA_R),
	.vga_G										(VGA_G),
	.vga_B										(VGA_B),
	
	// SDRAM
	.sdram_clk_clk								(DRAM_CLK),
   .sdram_addr									(DRAM_ADDR),
	.sdram_ba									(DRAM_BA),
	.sdram_cas_n								(DRAM_CAS_N),
	.sdram_cke									(DRAM_CKE),
	.sdram_cs_n									(DRAM_CS_N),
	.sdram_dq									(DRAM_DQ),
	.sdram_dqm									({DRAM_UDQM,DRAM_LDQM}),
	.sdram_ras_n								(DRAM_RAS_N),
	.sdram_we_n									(DRAM_WE_N),
	
	////////////////////////////////////
	// HPS Side
	////////////////////////////////////
	// DDR3 SDRAM
	.memory_mem_a			(HPS_DDR3_ADDR),
	.memory_mem_ba			(HPS_DDR3_BA),
	.memory_mem_ck			(HPS_DDR3_CK_P),
	.memory_mem_ck_n		(HPS_DDR3_CK_N),
	.memory_mem_cke		(HPS_DDR3_CKE),
	.memory_mem_cs_n		(HPS_DDR3_CS_N),
	.memory_mem_ras_n		(HPS_DDR3_RAS_N),
	.memory_mem_cas_n		(HPS_DDR3_CAS_N),
	.memory_mem_we_n		(HPS_DDR3_WE_N),
	.memory_mem_reset_n	(HPS_DDR3_RESET_N),
	.memory_mem_dq			(HPS_DDR3_DQ),
	.memory_mem_dqs		(HPS_DDR3_DQS_P),
	.memory_mem_dqs_n		(HPS_DDR3_DQS_N),
	.memory_mem_odt		(HPS_DDR3_ODT),
	.memory_mem_dm			(HPS_DDR3_DM),
	.memory_oct_rzqin		(HPS_DDR3_RZQ),
	.n0_from_fpga_export({5'd0,n0_out0}),             //         n0_from_fpga.export
   .n0_from_hps_export(n0_in0),              //          n0_from_hps.export
	.ne_from_fpga_export({5'd0,ne_out0}),             //         ne_from_fpga.export
	.ne_from_hps_export(ne_in0),              //          ne_from_hps.export
   .nn_from_fpga_export({5'd0,nn_out0}),             //         nn_from_fpga.export
   .nn_from_hps_export(nn_in0),              //          nn_from_hps.export
   .nne_from_fpga_export({5'd0,nne_out0}),            //        nne_from_fpga.
   .nne_from_hps_export(nne_in0),             //         nne_from_hps.export
	.nnw_from_fpga_export({5'd0,nnw_out0}),            //        nnw_from_fpga.export
   .nnw_from_hps_export(nnw_in0),             //         nnw_from_hps.export
	.ns_from_fpga_export({5'd0,ns_out0}),             //         ns_from_fpga.export
   .ns_from_hps_export(ns_in0),              //          ns_from_hps.export
	.nse_from_fpga_export({5'd0,nse_out0}),            //        nse_from_fpga.export
   .nse_from_hps_export(nse_in0),             //         nse_from_hps.export
	.nsw_from_fpga_export({5'd0,nsw_out0}),            //        nsw_from_fpga.export
   .nsw_from_hps_export(nsw_in0),             //         nsw_from_hps.export
   .nw_from_fpga_export({5'd0,nw_out0}),             //         nw_from_fpga.export
	.nw_from_hps_export(nw_in0),              //          nw_from_hps.export	  // Ethernet
	.one36th_export(one36th0),                  //              one36th.export
	.one9th_export(one9th0),                   //               one9th.export
	.omega_export(omega_in),
	.pipes_export(pipes),
	.ux_export({ux_out[26],ux_out[26],ux_out[26],ux_out[26],ux_out[26],ux_out}),
   .uy_export({uy_out[26],uy_out[26],uy_out[26],uy_out[26],uy_out[26],uy_out}), 	
	.hps_io_hps_io_gpio_inst_GPIO35	(HPS_ENET_INT_N),
	.hps_io_hps_io_emac1_inst_TX_CLK	(HPS_ENET_GTX_CLK),
	.hps_io_hps_io_emac1_inst_TXD0	(HPS_ENET_TX_DATA[0]),
	.hps_io_hps_io_emac1_inst_TXD1	(HPS_ENET_TX_DATA[1]),
	.hps_io_hps_io_emac1_inst_TXD2	(HPS_ENET_TX_DATA[2]),
	.hps_io_hps_io_emac1_inst_TXD3	(HPS_ENET_TX_DATA[3]),
	.hps_io_hps_io_emac1_inst_RXD0	(HPS_ENET_RX_DATA[0]),
	.hps_io_hps_io_emac1_inst_MDIO	(HPS_ENET_MDIO),
	.hps_io_hps_io_emac1_inst_MDC		(HPS_ENET_MDC),
	.hps_io_hps_io_emac1_inst_RX_CTL	(HPS_ENET_RX_DV),
	.hps_io_hps_io_emac1_inst_TX_CTL	(HPS_ENET_TX_EN),
	.hps_io_hps_io_emac1_inst_RX_CLK	(HPS_ENET_RX_CLK),
	.hps_io_hps_io_emac1_inst_RXD1	(HPS_ENET_RX_DATA[1]),
	.hps_io_hps_io_emac1_inst_RXD2	(HPS_ENET_RX_DATA[2]),
	.hps_io_hps_io_emac1_inst_RXD3	(HPS_ENET_RX_DATA[3]),

	// Flash
	.hps_io_hps_io_qspi_inst_IO0	(HPS_FLASH_DATA[0]),
	.hps_io_hps_io_qspi_inst_IO1	(HPS_FLASH_DATA[1]),
	.hps_io_hps_io_qspi_inst_IO2	(HPS_FLASH_DATA[2]),
	.hps_io_hps_io_qspi_inst_IO3	(HPS_FLASH_DATA[3]),
	.hps_io_hps_io_qspi_inst_SS0	(HPS_FLASH_NCSO),
	.hps_io_hps_io_qspi_inst_CLK	(HPS_FLASH_DCLK),

	// Accelerometer
	.hps_io_hps_io_gpio_inst_GPIO61	(HPS_GSENSOR_INT),

	//.adc_sclk                        (ADC_SCLK),
	//.adc_cs_n                        (ADC_CS_N),
	//.adc_dout                        (ADC_DOUT),
	//.adc_din                         (ADC_DIN),

	// General Purpose I/O
	.hps_io_hps_io_gpio_inst_GPIO40	(HPS_GPIO[0]),
	.hps_io_hps_io_gpio_inst_GPIO41	(HPS_GPIO[1]),

	// I2C
	.hps_io_hps_io_gpio_inst_GPIO48	(HPS_I2C_CONTROL),
	.hps_io_hps_io_i2c0_inst_SDA		(HPS_I2C1_SDAT),
	.hps_io_hps_io_i2c0_inst_SCL		(HPS_I2C1_SCLK),
	.hps_io_hps_io_i2c1_inst_SDA		(HPS_I2C2_SDAT),
	.hps_io_hps_io_i2c1_inst_SCL		(HPS_I2C2_SCLK),

	// Pushbutton
	.hps_io_hps_io_gpio_inst_GPIO54	(HPS_KEY),

	// LED
	.hps_io_hps_io_gpio_inst_GPIO53	(HPS_LED),

	// SD Card
	.hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),
	.hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),
	.hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),
	.hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),
	.hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),
	.hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),

	// SPI
	.hps_io_hps_io_spim1_inst_CLK		(HPS_SPIM_CLK),
	.hps_io_hps_io_spim1_inst_MOSI	(HPS_SPIM_MOSI),
	.hps_io_hps_io_spim1_inst_MISO	(HPS_SPIM_MISO),
	.hps_io_hps_io_spim1_inst_SS0		(HPS_SPIM_SS),

	// UART
	.hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),
	.hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX),

	// USB
	.hps_io_hps_io_gpio_inst_GPIO09	(HPS_CONV_USB_N),
	.hps_io_hps_io_usb1_inst_D0		(HPS_USB_DATA[0]),
	.hps_io_hps_io_usb1_inst_D1		(HPS_USB_DATA[1]),
	.hps_io_hps_io_usb1_inst_D2		(HPS_USB_DATA[2]),
	.hps_io_hps_io_usb1_inst_D3		(HPS_USB_DATA[3]),
	.hps_io_hps_io_usb1_inst_D4		(HPS_USB_DATA[4]),
	.hps_io_hps_io_usb1_inst_D5		(HPS_USB_DATA[5]),
	.hps_io_hps_io_usb1_inst_D6		(HPS_USB_DATA[6]),
	.hps_io_hps_io_usb1_inst_D7		(HPS_USB_DATA[7]),
	.hps_io_hps_io_usb1_inst_CLK		(HPS_USB_CLKOUT),
	.hps_io_hps_io_usb1_inst_STP		(HPS_USB_STP),
	.hps_io_hps_io_usb1_inst_DIR		(HPS_USB_DIR),
	.hps_io_hps_io_usb1_inst_NXT		(HPS_USB_NXT)
);


endmodule














module collide(
input  wire signed [26:0] n0_in,
input  wire signed [26:0] ns_in,
input  wire signed [26:0] nn_in,
input  wire signed [26:0] nw_in,
input  wire signed [26:0] ne_in,
input  wire signed [26:0] nnw_in,
input  wire signed [26:0] nne_in,
input  wire signed [26:0] nsw_in,
input  wire signed [26:0] nse_in,
input  wire signed [26:0] omega,
input  wire signed [26:0] one9th,
input  wire signed [26:0] one36th,
output wire signed [26:0] n0_out,
output wire signed [26:0] ns_out,
output wire signed [26:0] nn_out,
output wire signed [26:0] nw_out,
output wire signed [26:0] ne_out,
output wire signed [26:0] nnw_out,
output wire signed [26:0] nne_out,
output wire signed [26:0] nsw_out,
output wire signed [26:0] nse_out,
output wire signed [26:0] ux,
output wire signed [26:0] uy 
);




wire signed [26:0] onefix;

wire signed [26:0] this_rho;
wire signed [26:0] rho_inv;

wire signed [26:0] thisux;
wire signed [26:0] thisuy; 

wire signed [26:0] one9thrho;
wire signed [26:0] one36thrho;

wire signed [26:0] ux3;
wire signed [26:0] uy3;
wire signed [26:0] ux2;
wire signed [26:0] uy2;
wire signed [26:0] uxuy2;
wire signed [26:0] u2;
wire signed [26:0] u215;

assign onefix= 27'sd1<<<25;

assign ux = thisux;
assign uy = thisuy;


assign this_rho = n0_in + nn_in +ns_in + nw_in + ne_in + nnw_in + nne_in +nsw_in + nse_in ;

wire signed [26:0] temp1;
signed_mult s1(temp1,(this_rho - onefix),(this_rho - onefix));

assign rho_inv = onefix - (this_rho - onefix) + temp1;

wire signed [26:0] temp2;
signed_mult s2(temp2,(rho_inv),(ne_in + nne_in + nse_in - nw_in -nnw_in -nsw_in));

assign thisux=temp2;


wire signed [26:0] temp3;
signed_mult s3(temp3,(rho_inv),(nn_in + nne_in + nnw_in - ns_in -nse_in -nsw_in));

assign thisuy = temp3;


signed_mult s4(one9thrho, this_rho, one9th);
signed_mult s5(one36thrho, this_rho, one36th);


m3 k0(thisux,ux3);
m3 k1(thisuy,uy3);
signed_mult s6 (ux2,thisux,thisux);
signed_mult s7 (uy2,thisuy,thisuy);
wire signed [26:0] temp4;
signed_mult s8 (temp4,thisux,thisuy);
assign uxuy2 = temp4<<<1;

assign u2 =ux2 + uy2;
m1_5 p0(u2,u215);



wire signed [26:0] m45ux2;
wire signed [26:0] m45uy2;

m4_5 r0(ux2,m45ux2);
m4_5 r1(uy2,m45uy2);



wire signed [26:0] netemp1;
wire signed [26:0] netemp2;

signed_mult pp1(netemp1,one9thrho, (onefix + ux3    + m45ux2   - u215));
signed_mult pp2(netemp2,omega,(netemp1 - ne_in));


assign ne_out = ne_in + netemp2;


wire signed [26:0] nwtemp1;
wire signed [26:0] nwtemp2;

signed_mult pw1(nwtemp1,one9thrho, (onefix - ux3    + m45ux2   - u215));
signed_mult pw2(nwtemp2,omega,(nwtemp1 - nw_in));


assign nw_out = nw_in + nwtemp2;
 
 
wire signed [26:0] nntemp1;
wire signed [26:0] nntemp2;

signed_mult pn1(nntemp1,one9thrho, (onefix + uy3    + m45uy2   - u215));
signed_mult pn2(nntemp2,omega,(nntemp1 - nn_in));


assign nn_out = nn_in + nntemp2;

wire signed [26:0] nstemp1;
wire signed [26:0] nstemp2;

signed_mult ps1(nstemp1,one9thrho, (onefix - uy3    + m45uy2   - u215));
signed_mult ps2(nstemp2,omega,(nstemp1 - ns_in));


assign ns_out = ns_in + nstemp2;

wire signed [26:0] nnetemp1;
wire signed [26:0] nnetemp2;
wire signed [26:0] nnetemp3;

m4_5 g1((u2+uxuy2),nnetemp3);

signed_mult psr1(nnetemp1,one36thrho, (onefix + uy3 +ux3    + nnetemp3   - u215));
signed_mult psr2(nnetemp2,omega,(nnetemp1 - nne_in));


assign nne_out = nne_in + nnetemp2;

wire signed [26:0] nsetemp1;
wire signed [26:0] nsetemp2;
wire signed [26:0] nsetemp3;

m4_5 g11((u2 - uxuy2),nsetemp3);

signed_mult psrr1(nsetemp1,one36thrho, (onefix - uy3 +ux3    + nsetemp3   - u215));
signed_mult psrr2(nsetemp2,omega,(nsetemp1 - nse_in));


assign nse_out = nse_in + nsetemp2;

wire signed [26:0] nnwtemp1;
wire signed [26:0] nnwtemp2;
wire signed [26:0] nnwtemp3;

m4_5 g12((u2 - uxuy2),nnwtemp3);

signed_mult psw1(nnwtemp1,one36thrho, (onefix + uy3 - ux3    + nnwtemp3   - u215));
signed_mult psw2(nnwtemp2,omega,(nnwtemp1 - nnw_in));


assign nnw_out = nnw_in + nnwtemp2;

wire signed [26:0] nswtemp1;
wire signed [26:0] nswtemp2;
wire signed [26:0] nswtemp3;

m4_5 g13((u2 + uxuy2),nswtemp3);

signed_mult psj1(nswtemp1,one36thrho, (onefix - uy3 - ux3    + nswtemp3   - u215));
signed_mult psj2(nswtemp2,omega,(nswtemp1 - nsw_in));


assign nsw_out = nsw_in + nswtemp2;


assign n0_out = this_rho - (nn_out +ne_out +nw_out +nsw_out + ns_out + nse_out +nne_out +nnw_out);




endmodule



//////////////////////////////////////////////////
//// signed mult of 2.25 format 2'comp////////////
//////////////////////////////////////////////////

module signed_mult (out, a, b);
	output 	signed  [26:0]	out;
	input 	signed	[26:0] 	a;
	input 	signed	[26:0] 	b;
	// intermediate full bit length
	wire 	signed	[53:0]	mult_out;
	assign mult_out = a * b;
	// select bits
	assign out = {mult_out[53], mult_out[51:25]};
endmodule
//////////////////////////////////////////////////




module m3 (input wire signed [26:0] a,
output wire signed [26:0] out);


assign out = a + (a<<<1);



endmodule

module m4_5 (input wire signed  [26:0] a,
output wire signed [26:0] out);


assign out = (a<<<2) + (a>>>1);



endmodule


module m1_5 (input wire signed  [26:0] a,
output wire signed [26:0] out);


assign out = (a) + (a>>>1);



endmodule
 

