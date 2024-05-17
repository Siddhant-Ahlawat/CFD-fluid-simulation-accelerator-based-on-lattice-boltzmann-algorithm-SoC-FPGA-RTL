

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

//assign HEX0 = display[ 6: 0]; // hex3_hex0[ 6: 0]; 
//assign HEX1 = ~hex3_hex0[14: 8];
//assign HEX2 = ~hex3_hex0[22:16];
//assign HEX3 = ~hex3_hex0[30:24];
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;
assign HEX3 = 7'b1111111;
assign HEX2 = 7'b1111111;
//assign HEX1 = display[13:7];
assign HEX1 = 7'b1111111;
assign HEX0 = segs;
//assign HEX0 = 7'b1111111;

//reg [13:0] display;
reg [6:0] segs;
/*
reg [3:0] num;
reg [6:0] segs;


HexDigit  hex(
.segs(segs),
.num(num)
)
assign HEX0 = segs;
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;
assign HEX3 = 7'b1111111;
assign HEX2 = 7'b1111111;
assign HEX1 = 7'b1111111;

*/

always@(score)begin
case(score)
4'd0:begin
//num=4'd0;
//display=14'b1111111_0000001;
segs=7'b1000000;
end
4'd1:begin
//num=4'd1;
//display=14'b1111111_1001111;
segs = 7'b1111001;
end
4'd2:begin
//num=4'd2;
//display=14'b1111111_0010010;
segs = 7'b0100100;
end
4'd3:begin
//num=4'd3;
//display=14'b1111111_0000110;
segs = 7'b0110000;
end
4'd4:begin
//num=4'd4;
//display=14'b1111111_1001100;
segs = 7'b0011001;
end
4'd5:begin
//num=4'd5;
//display=14'b1111111_0100100;
segs = 7'b0010010;
end
4'd6:begin
//num=4'd6;
//display=14'b1111111_0100000;
segs =7'b0000010;
end
4'd7:begin
//num=4'd7;
//display=14'b1111111_0001111;
segs =7'b1111000;
end
4'd8:begin
//num=4'd8;
//display=14'b1111111_0000000;
segs =7'b0000000;
end
4'd9:begin
//num=4'd9;
//display=14'b1111111_0000100;
segs = 7'b0010000;
end
4'd10:begin
//num=4'd10;
//display=14'b1001111_0000001;
segs = 7'b0001000;
end
4'd11:begin
//num=4'd11;
//display=14'b1001111_1001111;
segs = 7'b0000011;
end
4'd12:begin
//num=4'd12;
//display=14'b1001111_0010010;
segs = 7'b1000110;
end
4'd13:begin
//num=4'd13;
//display=14'b1001111_0000110;
segs = 7'b0100001;
end
4'd14:begin
//num=4'd14;
//display=14'b1001111_1001100;
segs = 7'b0000110;
end
4'd15:begin
//num=4'd15;
//display=14'b1001111_0100100;
segs = 7'b0001110;
end



endcase

end




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
 wire signed [31:0] n0_from_hps; 
 wire signed [31:0] nN_from_hps; 
 wire signed [31:0] nS_from_hps; 
 wire signed [31:0] nW_from_hps; 
 wire signed [31:0] nE_from_hps; 
 wire signed [31:0] nNW_from_hps; 
 wire signed [31:0] nNE_from_hps; 
 wire signed [31:0] nSW_from_hps; 
 wire signed [31:0] nSE_from_hps; 
 wire signed [31:0] ux_from_hps; 
 wire signed [31:0] uy_from_hps; 
 
 wire [31:0] start_collide;
 wire [31:0] start_stream;
 wire [31:0] start_move_trace;
 wire [31:0] start_speed_color;
 wire [31:0] start_init;
 wire [31:0] stream_finish;
 wire [31:0] collide_finish;
 wire [31:0] move_trace_finish;
 wire [31:0] speed_color_finish;
 wire [31:0] init_finish;
 wire [31:0] init_ship_finish;
 wire [31:0] init_ship;
 
 wire [9:0] x_vga;
  wire [9:0] y_vga;
 wire [7:0] color_out_vga;
 wire [31:0] write_address_init;
 wire [31:0] reset_signal_from_hps;
 wire [31:0] start_print;
 wire [31:0] print_finish;
 
wire clk_25mhz;
wire clk_4mhz;
wire clk_16mhz;
wire clk_8mhz;
wire clk_fsm;

wire [31:0] pipes;

assign pipes = {22'd0,SW[9],SW[8],SW[8],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0]};

wire [31:0] x_fish1,x_fish2,y_fish1,y_fish2,score;
wire [31:0] ship_x,ship_y;

wire [26:0] ux_in,uy_in;


Clock_divider c1(.clock_in(CLOCK_50),.clock_out(clk_25mhz));

Clock_divider4 c4(.clock_in(CLOCK_50),.clock_out(clk_4mhz));
Clock_divider8 c8(.clock_in(CLOCK_50),.clock_out(clk_8mhz));
Clock_divider16 c16(.clock_in(CLOCK_50),.clock_out(clk_16mhz));

 collide_stream_fsm k00(
.clk(clk_4mhz),
.rst(reset_signal_from_hps),
.start_collide(start_collide),
.start_init(start_init),
.start_speed_color(start_speed_color),
.start_move_trace(start_move_trace),
.init_ship(init_ship),
.ship_x(ship_x[13:0]),
.ship_y(ship_y[13:0]),
.x_fish1(x_fish1[13:0]),
.x_fish2(x_fish2[13:0]),
.y_fish1(y_fish1[13:0]),
.y_fish2(y_fish2[13:0]),
.omega(27'sd_65922266),
.x_vga(x_vga),
.y_vga(y_vga),
.ux_in(ux_in),
.uy_in(uy_in),

 .n0_init_data(n0_from_hps[26:0]),
 .nN_init_data(nN_from_hps[26:0]),
 .nS_init_data(nS_from_hps[26:0]),
 .nW_init_data(nW_from_hps[26:0]),
 .nE_init_data(nE_from_hps[26:0]),
 .nNW_init_data(nNW_from_hps[26:0]),
 .nNE_init_data(nNE_from_hps[26:0]),
 .nSW_init_data(nSW_from_hps[26:0]),
 .nSE_init_data(nSE_from_hps[26:0]),
 .ux_init_data(ux_from_hps[26:0]),
 .uy_init_data(uy_from_hps[26:0]),
.write_address_init(write_address_init[13:0]),
.start_stream(start_stream),
.color_out_vga(color_out_vga),
.stream_finish(stream_finish),
.collide_finish(collide_finish),
.init_ship_finish(init_ship_finish),
.speed_color_finish(speed_color_finish),
.move_trace_finish(move_trace_finish),
.init_finish(init_finish)
);






// Instantiate VGA driver					
vga_driver DUT   (  .clock(clk_25mhz),     // 25 MHz
							.reset(reset_signal_from_hps),     // Active high
							.color_in(color_out_vga), // Pixel color data (RRRGGGBB)
							.next_x(x_vga),  // x-coordinate of NEXT pixel that will be drawn
							.next_y(y_vga),  // y-coordinate of NEXT pixel that will be drawn
							.hsync(VGA_HS),
							.vsync(VGA_VS),
							.start_print(start_print[0]),
							.print_finish(print_finish[0]),
							.red(VGA_R),
							.green(VGA_G),
							.blue(VGA_B),
							.sync(VGA_SYNC_N),
							.clk(VGA_CLK),
							.blank(VGA_BLANK_N)
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
	.sdram_clk_clk								(state_clock),

	// AV Config
	.av_config_SCLK							(FPGA_I2C_SCLK),
	.av_config_SDAT							(FPGA_I2C_SDAT),

	// Audio Subsystem
	.audio_pll_ref_clk_clk					(CLOCK3_50),
	.audio_pll_ref_reset_reset				(1'b0),
	.audio_clk_clk								(AUD_XCK),
	.audio_ADCDAT								(AUD_ADCDAT),
	.audio_ADCLRCK								(AUD_ADCLRCK),
	.audio_BCLK									(AUD_BCLK),
	.audio_DACDAT								(AUD_DACDAT),
	.audio_DACLRCK								(AUD_DACLRCK),

	// bus-master state machine interface
	.bus_master_audio_external_interface_address     (bus_addr),     
	.bus_master_audio_external_interface_byte_enable (bus_byte_enable), 
	.bus_master_audio_external_interface_read        (bus_read),        
	.bus_master_audio_external_interface_write       (bus_write),       
	.bus_master_audio_external_interface_write_data  (bus_write_data),  
	.bus_master_audio_external_interface_acknowledge (bus_ack),                                  
	.bus_master_audio_external_interface_read_data   (bus_read_data),   
	
	
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
		  
	// Ethernet
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

	 	.collide_finish_export(collide_finish),
	.init_finish_export(init_finish),
	.init_ship_export(init_ship),
	.move_trace_finish_export(move_trace_finish),
	 .n0_from_hps_export(n0_from_hps),
 .nn_from_hps_export(nN_from_hps),
 .ns_from_hps_export(nS_from_hps),
 .nw_from_hps_export(nW_from_hps),
 .ne_from_hps_export(nE_from_hps),
 .nnw_from_hps_export(nNW_from_hps),
 .nne_from_hps_export(nNE_from_hps),
 .nsw_from_hps_export(nSW_from_hps),
 .nse_from_hps_export(nSE_from_hps),
 .ux_from_hps_export(ux_from_hps),
 .uy_from_hps_export(uy_from_hps),
 .speed_color_finish_export(speed_color_finish),
 .start_collide_export(start_collide),
 .start_init_export(start_init),
 .start_move_trace_export(start_move_trace),
 .start_speed_color_export(start_speed_color),
 .start_stream_export(start_stream),
 .stream_finish_export(stream_finish),
 .write_address_init_export(write_address_init),
 .pipes_export(pipes),	
 .reset_lb_export(reset_signal_from_hps),	
 .print_finish_export(print_finish),
 .start_print_export(start_print),
 .test_data_export(score),
 .ship_x_export(ship_x),
 .ship_y_export(ship_y),
 .ux_in_export({ux_in[26],ux_in[26],ux_in[26],ux_in[26],ux_in[26],ux_in[26:0]}),
 .uy_in_export({uy_in[26],uy_in[26],uy_in[26],uy_in[26],uy_in[26],uy_in[26:0]}),
 .x_fish2_export(x_fish2),
 .x_fish1_export(x_fish1),
 .y_fish2_export(y_fish2),
 .y_fish1_export(y_fish1),
	
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







//===================VGA DRIVER====================================================================

module vga_driver (
    input wire clock,     // 25 MHz
    input wire reset,     // Active high
    input [7:0] color_in, // Pixel color data (RRRGGGBB)
	 input start_print,
	 output reg print_finish,
    output [9:0] next_x,  // x-coordinate of NEXT pixel that will be drawn
    output [9:0] next_y,  // y-coordinate of NEXT pixel that will be drawn
    output wire hsync,    // HSYNC (to VGA connector)
    output wire vsync,    // VSYNC (to VGA connctor)
    output [7:0] red,     // RED (to resistor DAC VGA connector)
    output [7:0] green,   // GREEN (to resistor DAC to VGA connector)
    output [7:0] blue,    // BLUE (to resistor DAC to VGA connector)
    output sync,          // SYNC to VGA connector
    output clk,           // CLK to VGA connector
    output blank          // BLANK to VGA connector
);

    // Horizontal parameters (measured in clock cycles)
    parameter [9:0] H_ACTIVE  =  10'd_639 ;
    parameter [9:0] H_FRONT   =  10'd_15 ;
    parameter [9:0] H_PULSE   =  10'd_95 ;
    parameter [9:0] H_BACK    =  10'd_47 ;

    // Vertical parameters (measured in lines)
    parameter [9:0] V_ACTIVE   =  10'd_479 ;
    parameter [9:0] V_FRONT    =  10'd_9 ;
    parameter [9:0] V_PULSE =  10'd_1 ;
    parameter [9:0] V_BACK  =  10'd_32 ;

    // Parameters for readability
    parameter   LOW     = 1'b_0 ;
    parameter   HIGH    = 1'b_1 ;

    // States (more readable)
    parameter   [7:0]    H_ACTIVE_STATE    = 8'd_0 ;
    parameter   [7:0]   H_FRONT_STATE     = 8'd_1 ;
    parameter   [7:0]   H_PULSE_STATE   = 8'd_2 ;
    parameter   [7:0]   H_BACK_STATE     = 8'd_3 ;

    parameter   [7:0]    V_ACTIVE_STATE    = 8'd_0 ;
    parameter   [7:0]   V_FRONT_STATE    = 8'd_1 ;
    parameter   [7:0]   V_PULSE_STATE   = 8'd_2 ;
    parameter   [7:0]   V_BACK_STATE     = 8'd_3 ;

    // Clocked registers
    reg              hysnc_reg ;
    reg              vsync_reg ;
    reg     [7:0]   red_reg ;
    reg     [7:0]   green_reg ;
    reg     [7:0]   blue_reg ;
    reg              line_done ;

    // Control registers
    reg     [9:0]   h_counter ;
    reg     [9:0]   v_counter ;

    reg     [7:0]    h_state ;
    reg     [7:0]    v_state ;

    // State machine
    always@(posedge clock) begin
        // At reset . . .
        if (reset) begin
            // Zero the counters
            h_counter   <= 10'd_0 ;
            v_counter   <= 10'd_0 ;
				print_finish <= 1'b0;
            // States to ACTIVE
            h_state     <= H_ACTIVE_STATE  ;
            v_state     <= V_ACTIVE_STATE  ;
            // Deassert line done
            line_done   <= LOW ;
        end
        else begin
            //////////////////////////////////////////////////////////////////////////
            ///////////////////////// HORIZONTAL /////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////
            if (h_state == H_ACTIVE_STATE) begin
                // Iterate horizontal counter, zero at end of ACTIVE mode
                h_counter <= (h_counter==H_ACTIVE)?10'd_0:(h_counter + 10'd_1) ;
                // Set hsync
                hysnc_reg <= HIGH ;
                // Deassert line done
                line_done <= LOW ;
                // State transition
                h_state <= (h_counter == H_ACTIVE)?H_FRONT_STATE:H_ACTIVE_STATE ;
            end
            if (h_state == H_FRONT_STATE) begin
                // Iterate horizontal counter, zero at end of H_FRONT mode
                h_counter <= (h_counter==H_FRONT)?10'd_0:(h_counter + 10'd_1) ;
                // Set hsync
                hysnc_reg <= HIGH ;
                // State transition
                h_state <= (h_counter == H_FRONT)?H_PULSE_STATE:H_FRONT_STATE ;
            end
            if (h_state == H_PULSE_STATE) begin
                // Iterate horizontal counter, zero at end of H_PULSE mode
                h_counter <= (h_counter==H_PULSE)?10'd_0:(h_counter + 10'd_1) ;
                // Clear hsync
                hysnc_reg <= LOW ;
                // State transition
                h_state <= (h_counter == H_PULSE)?H_BACK_STATE:H_PULSE_STATE ;
            end
            if (h_state == H_BACK_STATE) begin
                // Iterate horizontal counter, zero at end of H_BACK mode
                h_counter <= (h_counter==H_BACK)?10'd_0:(h_counter + 10'd_1) ;
                // Set hsync
                hysnc_reg <= HIGH ;
                // State transition
                h_state <= (h_counter == H_BACK)?H_ACTIVE_STATE:H_BACK_STATE ;
                // Signal line complete at state transition (offset by 1 for synchronous state transition)
                line_done <= (h_counter == (H_BACK-1))?HIGH:LOW ;
            end
				
				
            //////////////////////////////////////////////////////////////////////////
            ///////////////////////// VERTICAL ///////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////
            if (v_state == V_ACTIVE_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_ACTIVE)?10'd_0:(v_counter+10'd_1)):v_counter ;
                // set vsync in active mode
                vsync_reg <= HIGH ;
                // state transition - only on end of lines
                v_state<=(line_done==HIGH)?((v_counter==V_ACTIVE)?V_FRONT_STATE:V_ACTIVE_STATE):V_ACTIVE_STATE ;
            end
            if (v_state == V_FRONT_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_FRONT)?10'd_0:(v_counter + 10'd_1)):v_counter ;
                // set vsync in front porch
                vsync_reg <= HIGH ;
                // state transition
                v_state<=(line_done==HIGH)?((v_counter==V_FRONT)?V_PULSE_STATE:V_FRONT_STATE):V_FRONT_STATE;
            end
            if (v_state == V_PULSE_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_PULSE)?10'd_0:(v_counter + 10'd_1)):v_counter ;
                // clear vsync in pulse
                vsync_reg <= LOW ;
                // state transition
                v_state<=(line_done==HIGH)?((v_counter==V_PULSE)?V_BACK_STATE:V_PULSE_STATE):V_PULSE_STATE;
            end
            if (v_state == V_BACK_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_BACK)?10'd_0:(v_counter + 10'd_1)):v_counter ;
                // set vsync in back porch
                vsync_reg <= HIGH ;
                // state transition
                v_state<=(line_done==HIGH)?((v_counter==V_BACK)?V_ACTIVE_STATE:V_BACK_STATE):V_BACK_STATE ;
            end

            //////////////////////////////////////////////////////////////////////////
            //////////////////////////////// COLOR OUT ///////////////////////////////
            //////////////////////////////////////////////////////////////////////////
            // Assign colors if in active mode
            red_reg<=(h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[7:5],5'd_0}:8'd_0):8'd_0 ;
            green_reg<=(h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[4:2],5'd_0}:8'd_0):8'd_0 ;
            blue_reg<=(h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[1:0],6'd_0}:8'd_0):8'd_0 ;
				
				if(h_counter==10'd639 && v_counter==10'd479)begin
				print_finish=1'b1;
				end
				if(h_counter==10'd0 && v_counter==10'd0)begin
				print_finish=1'b0;
				end

        end
    end
    // Assign output values - to VGA connector
    assign hsync = hysnc_reg ;
    assign vsync = vsync_reg ;
    assign red = red_reg ;
    assign green = green_reg ;
    assign blue = blue_reg ;
    assign clk = clock ;
    assign sync = 1'b_0 ;
    assign blank = hysnc_reg & vsync_reg ;
    // The x/y coordinates that should be available on the NEXT cycle
    assign next_x = (h_state==H_ACTIVE_STATE)?h_counter:10'd_0 ;
    assign next_y = (v_state==V_ACTIVE_STATE)?v_counter:10'd_0 ;
	 
	 

endmodule











// fpga4student.com: FPGA projects, VHDL projects, Verilog projects
// Verilog project: Verilog code for clock divider on FPGA
// Top level Verilog code for clock divider on FPGA
module Clock_divider(clock_in,clock_out
    );
input clock_in; // input clock on FPGA
output reg clock_out; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd2;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule


// fpga4student.com: FPGA projects, VHDL projects, Verilog projects
// Verilog project: Verilog code for clock divider on FPGA
// Top level Verilog code for clock divider on FPGA
module Clock_divider4(clock_in,clock_out
    );
input clock_in; // input clock on FPGA
output reg clock_out; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd4;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule

// fpga4student.com: FPGA projects, VHDL projects, Verilog projects
// Verilog project: Verilog code for clock divider on FPGA
// Top level Verilog code for clock divider on FPGA
module Clock_divider8(clock_in,clock_out
    );
input clock_in; // input clock on FPGA
output reg clock_out; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd8;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule


// fpga4student.com: FPGA projects, VHDL projects, Verilog projects
// Verilog project: Verilog code for clock divider on FPGA
// Top level Verilog code for clock divider on FPGA
module Clock_divider16(clock_in,clock_out
    );
input clock_in; // input clock on FPGA
output reg clock_out; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd16;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule







module collide_stream_fsm(
input clk,
input rst,
input start_collide,
input start_init,
input start_speed_color,
input start_move_trace,
input init_ship,
input  wire signed [26:0] omega,
input start_stream,
input [9:0] x_vga,
input [9:0] y_vga,
input [13:0] x_fish1,
input [13:0] x_fish2,
input [13:0] y_fish1,
input [13:0] y_fish2,
 input wire signed [26:0] n0_init_data ,
 input wire signed [26:0] nN_init_data ,
 input wire signed [26:0] nS_init_data ,
 input wire signed [26:0] nW_init_data ,
 input wire signed [26:0] nE_init_data ,
 input wire signed [26:0] nNW_init_data ,
 input wire signed [26:0] nNE_init_data ,
 input wire signed [26:0] nSW_init_data ,
 input wire signed [26:0] nSE_init_data ,
 input wire signed [26:0] ux_init_data ,
 input wire signed [26:0] uy_init_data ,
input wire [13:0] write_address_init,
output wire [7:0] color_out_vga,
output reg signed [26:0] ux_in,
output reg signed [26:0] uy_in,
input wire [13:0] ship_x,
input wire [13:0] ship_y,
output reg stream_finish,
output reg init_ship_finish,
output reg speed_color_finish,
output reg collide_finish,
output reg move_trace_finish,
output reg init_finish

);

parameter num_pixels =1;





//read addresses 

 reg [13:0] n0_read_address ;
 reg [13:0] nN_read_address ;
 reg [13:0] nS_read_address ;
 reg [13:0] nW_read_address ;
 reg [13:0] nE_read_address ;
 reg [13:0] nNW_read_address ;
 reg [13:0] nNE_read_address ;
 reg [13:0] nSW_read_address ;
 reg [13:0] nSE_read_address ;
 reg [13:0] ux_read_address ;
 reg [13:0] uy_read_address ;

//write addresses

 reg [13:0] n0_write_address ;
 reg [13:0] nN_write_address ;
 reg [13:0] nS_write_address ;
 reg [13:0] nW_write_address ;
 reg [13:0] nE_write_address ;
 reg [13:0] nNW_write_address ;
 reg [13:0] nNE_write_address ;
 reg [13:0] nSW_write_address ;
 reg [13:0] nSE_write_address ;
 reg [13:0] ux_write_address ;
 reg [13:0] uy_write_address ;

//write enables

 reg n0_we ;
 reg nN_we ;
 reg nS_we ;
 reg nW_we ;
 reg nE_we ;
 reg nNW_we ;
 reg nNE_we ;
 reg nSW_we ;
 reg nSE_we ;
 reg ux_we ;
 reg uy_we ;
 reg init_we;

//read_data's


 wire signed [26:0] n0_read_data ;
 wire signed [26:0] nN_read_data ;
 wire signed [26:0] nS_read_data ;
 wire signed [26:0] nW_read_data ;
 wire signed [26:0] nE_read_data ;
 wire signed [26:0] nNW_read_data ;
 wire signed [26:0] nNE_read_data ;
 wire signed [26:0] nSW_read_data ;
 wire signed [26:0] nSE_read_data ;
 wire signed [26:0] ux_read_data ;
 wire signed [26:0] uy_read_data ;

//write data's

 reg signed [26:0] n0_write_data ;
 reg signed [26:0] nN_write_data ;
 reg signed [26:0] nS_write_data ;
 reg signed [26:0] nW_write_data ;
 reg signed [26:0] nE_write_data ;
 reg signed [26:0] nNW_write_data ;
 reg signed [26:0] nNE_write_data ;
 reg signed [26:0] nSW_write_data ;
 reg signed [26:0] nSE_write_data ;
 reg signed [26:0] ux_write_data ;
 reg signed [26:0] uy_write_data ;


//color m10k
reg [13:0] color_read_address;
reg [13:0] color_write_address;
reg [7:0] color_write_data;
wire [7:0] color_read_data;
reg color_we;



wire [18:0] k_vga;

assign k_vga = (x_vga - 10'd130) + (y_vga - 10'd100)*14'd136;

assign color_out_vga = ((x_vga>10'd130)&&(x_vga<=10'd265)&&(y_vga>10'd100)&&(y_vga<=10'd171))? color_read_data : 8'b1111_1111;



m10k_n n0(.clk(clk),
.read_address(n0_read_address),
.write_address(n0_write_address),
.we(n0_we),
.data_write(n0_write_data),
.data_read(n0_read_data)
);
m10k_n nN(.clk(clk),
.read_address(nN_read_address),
.write_address(nN_write_address),
.we(nN_we),
.data_write(nN_write_data),
.data_read(nN_read_data)
);
m10k_n nS(.clk(clk),
.read_address(nS_read_address),
.write_address(nS_write_address),
.we(nS_we),
.data_write(nS_write_data),
.data_read(nS_read_data)
);
m10k_n nW(.clk(clk),
.read_address(nW_read_address),
.write_address(nW_write_address),
.we(nW_we),
.data_write(nW_write_data),
.data_read(nW_read_data)
);
m10k_n nE(.clk(clk),
.read_address(nE_read_address),
.write_address(nE_write_address),
.we(nE_we),
.data_write(nE_write_data),
.data_read(nE_read_data)
);
m10k_n nNW(.clk(clk),
.read_address(nNW_read_address),
.write_address(nNW_write_address),
.we(nNW_we),
.data_write(nNW_write_data),
.data_read(nNW_read_data)
);
m10k_n nNE(.clk(clk),
.read_address(nNE_read_address),
.write_address(nNE_write_address),
.we(nNE_we),
.data_write(nNE_write_data),
.data_read(nNE_read_data)
);
m10k_n nSW(.clk(clk),
.read_address(nSW_read_address),
.write_address(nSW_write_address),
.we(nSW_we),
.data_write(nSW_write_data),
.data_read(nSW_read_data)
);
m10k_n nSE(.clk(clk),
.read_address(nSE_read_address),
.write_address(nSE_write_address),
.we(nSE_we),
.data_write(nSE_write_data),
.data_read(nSE_read_data)
);
m10k_n ux(.clk(clk),
.read_address(ux_read_address),
.write_address(ux_write_address),
.we(ux_we),
.data_write(ux_write_data),
.data_read(ux_read_data)
);
m10k_n uy(.clk(clk),
.read_address(uy_read_address),
.write_address(uy_write_address),
.we(uy_we),
.data_write(uy_write_data),
.data_read(uy_read_data)
);

m10k_color p68(.clk(clk),
.read_address(k_vga[13:0]),
.write_address(color_write_address),
.we(color_we),
.data_write(color_write_data),
.data_read(color_read_data)
);







 reg signed [26:0] n0_temp ;
 reg signed [26:0] nN_temp ;
 reg signed [26:0] nS_temp ;
 reg signed [26:0] nW_temp ;
 reg signed [26:0] nE_temp ;
 reg signed [26:0] nNW_temp ;
 reg signed [26:0] nNE_temp ;
 reg signed [26:0] nSW_temp ;
 reg signed [26:0] nSE_temp ;
 reg signed [26:0] ux_temp ;
 reg signed [26:0] uy_temp ;


					
 wire signed [26:0] n0_temp_out ;
 wire signed [26:0] nN_temp_out ;
 wire signed [26:0] nS_temp_out ;
 wire signed [26:0] nW_temp_out ;
 wire signed [26:0] nE_temp_out ;
 wire signed [26:0] nNW_temp_out ;
 wire signed [26:0] nNE_temp_out ;
 wire signed [26:0] nSW_temp_out ;
 wire signed [26:0] nSE_temp_out ;
 wire signed [26:0] ux_temp_out ;
 wire signed [26:0] uy_temp_out ;
								


collide b0(
        .n0_in(n0_temp),
        .ns_in(nS_temp),
        .nn_in(nN_temp),
        .nw_in(nW_temp),
        .ne_in(nE_temp),
      .nnw_in(nNW_temp),
      .nne_in(nNE_temp),
      .nsw_in(nSW_temp),
      .nse_in(nSE_temp),
   .omega(omega),
 .one9th(27'sd3728270),
.one36th(27'sd932067),
   .n0_out(n0_temp_out),
   .ns_out(nS_temp_out),
   .nn_out(nN_temp_out),
   .nw_out(nW_temp_out),
   .ne_out(nE_temp_out),
 .nnw_out(nNW_temp_out),
 .nne_out(nNE_temp_out),
 .nsw_out(nSW_temp_out),
 .nse_out(nSE_temp_out),
       .ux(ux_temp_out),
       .uy(uy_temp_out) 
);


 wire [13:0] k_collide_read;
  reg [13:0] x_collide_read;
  reg [13:0] y_collide_read;
wire [13:0] k_collide_write;
 reg [13:0] x_collide_write;
 reg [13:0] y_collide_write;

assign k_collide_read = x_collide_read + ((y_collide_read)<<7) + ((y_collide_read)<<3);	



assign k_collide_write = x_collide_write + (( y_collide_write)<<7) + (( y_collide_write)<<3);	




 reg [13:0] x_stream1_read;
 reg [13:0] y_stream1_read;
reg [13:0] x_stream1_write;
reg [13:0] y_stream1_write;

reg [13:0] x_stream2_write;
reg [13:0] y_stream2_write;
 reg [13:0] x_stream2_read;
 reg [13:0] y_stream2_read;


reg [13:0] x_stream3_write;
reg [13:0] y_stream3_write;
 reg [13:0] x_stream3_read;
 reg [13:0] y_stream3_read;

reg [13:0] x_stream4_write;
reg [13:0] y_stream4_write;
 reg [13:0] x_stream4_read;
 reg [13:0] y_stream4_read;


   wire [13:0] n0_k_stream_write  ;
   wire [13:0] nN_k_stream_write  ;
   wire [13:0] nS_k_stream_write  ;
   wire [13:0] nW_k_stream_write  ;
   wire [13:0] nE_k_stream_write  ;
   wire [13:0] nNW_k_stream_write  ;
   wire [13:0] nNE_k_stream_write  ;
   wire [13:0] nSW_k_stream_write  ;
   wire [13:0] nSE_k_stream_write  ;
	
   wire [13:0] n0_k_stream_read  ;
   wire [13:0] nN_k_stream_read  ;
   wire [13:0] nS_k_stream_read  ;
   wire [13:0] nW_k_stream_read  ;
   wire [13:0] nE_k_stream_read  ;
   wire [13:0] nNW_k_stream_read  ;
   wire [13:0] nNE_k_stream_read  ;
   wire [13:0] nSW_k_stream_read  ;
   wire [13:0] nSE_k_stream_read  ;



     assign nN_k_stream_read = (x_stream1_read ) + (y_stream1_read - 14'd1)*14'd136 ;
     assign nN_k_stream_write = (x_stream1_write) + (y_stream1_write)*14'd136 ;


     assign nS_k_stream_read = (x_stream3_read ) + (y_stream3_read + 14'd1)*14'd136 ;
     assign nS_k_stream_write = (x_stream3_write) + (y_stream3_write)*14'd136 ;

     assign nW_k_stream_read = (x_stream4_read + 14'd1) + (y_stream4_read )*14'd136 ;
     assign nW_k_stream_write = (x_stream4_write) + (y_stream4_write)*14'd136 ;

     assign nE_k_stream_read = (x_stream2_read - 14'd1) + (y_stream2_read )*14'd136 ;

    assign nNW_k_stream_read = (x_stream1_read + 14'd1) + (y_stream1_read - 14'd1)*14'd136 ;

    assign nNE_k_stream_read = (x_stream2_read - 14'd1) + (y_stream2_read - 14'd1)*14'd136 ;

    assign nSW_k_stream_read = (x_stream4_read + 14'd1) + (y_stream4_read + 14'd1)*14'd136 ;

    assign nSE_k_stream_read = (x_stream3_read - 14'd1) + (y_stream3_read + 14'd1)*14'd136 ;



 
 
 assign nE_k_stream_write = (x_stream2_write) + (y_stream2_write)*14'd136 ; 
assign nNW_k_stream_write = (x_stream1_write) + (y_stream1_write)*14'd136 ;
assign nNE_k_stream_write = (x_stream2_write) + (y_stream2_write)*14'd136 ;
assign nSW_k_stream_write = (x_stream4_write) + (y_stream4_write)*14'd136 ;
assign nSE_k_stream_write = (x_stream3_write) + (y_stream3_write)*14'd136 ;







 wire [13:0] k_move_trace_read;
  reg [13:0] x_move_trace_read;
  reg [13:0] y_move_trace_read;
assign k_move_trace_read = x_move_trace_read + y_move_trace_read*14'd136;	


wire [13:0] k_speed_color_read;
 reg [13:0] x_speed_color_read;
 reg [13:0] y_speed_color_read;

assign k_speed_color_read = x_speed_color_read + y_speed_color_read*14'd136;	

wire [13:0] k_fish1;
wire [13:0] k_fish2;
wire [13:0] k_speed_color_write;
 reg [13:0] x_speed_color_write;
 reg [13:0] y_speed_color_write;

assign k_speed_color_write = x_speed_color_write + y_speed_color_write*14'd136;
assign k_fish1 = x_fish1 + y_fish1*14'd136;
assign k_fish2 = x_fish2 + y_fish2*14'd136;

reg [3:0] state_collide;

reg [3:0] state_stream;

reg [3:0] state_init;

reg [3:0] state_move_trace;

reg [3:0] state_speed_color;


always@(ship_x || ship_y)begin
x_move_trace_read = ship_x;
y_move_trace_read = ship_y;



end


wire [26:0] speed_out;
reg signed [26:0] ux_in_speed;
reg signed [26:0] uy_in_speed;



speed_calc cv08(.ux(ux_in_speed),
.uy(uy_in_speed),
.speed(speed_out));


//collide

always@(posedge clk) begin
if(rst || (start_collide==1'b0 && start_stream==1'b0 && start_init==1'b0 && start_move_trace==1'b0 && start_speed_color==1'b0))begin
state_collide<=4'd0;
state_stream<=4'd0;
state_init<=4'd0;
state_move_trace<=4'd0;
state_speed_color<=4'd0;

init_ship_finish<=1'b0;
init_finish<=1'b0;
move_trace_finish<=1'b0;
stream_finish<=1'b0;
collide_finish<=1'b0;
speed_color_finish<=1'b0;

	      n0_read_address <= 14'd0 ;
	 nN_read_address <= 14'd0 ;
	 nS_read_address <= 14'd0 ;
	 nW_read_address <= 14'd0 ;
	 nE_read_address <= 14'd0 ;
	nNW_read_address <= 14'd0 ;
	nNE_read_address <= 14'd0 ;
	nSW_read_address <= 14'd0 ;
	nSE_read_address <= 14'd0 ;
	 ux_read_address <= 14'd0 ;
	 uy_read_address <= 14'd0 ;
					
	n0_write_address <= 14'd0 ;
	nN_write_address <= 14'd0 ;
	nS_write_address <= 14'd0 ;
	nW_write_address <= 14'd0 ;
	nE_write_address <= 14'd0 ;
   nNW_write_address <= 14'd0 ;
   nNE_write_address <= 14'd0 ;
   nSW_write_address <= 14'd0 ;
   nSE_write_address <= 14'd0 ;
	ux_write_address <= 14'd0 ;
	uy_write_address <= 14'd0 ;


                   n0_we<= 1'b0 ; 
                   nN_we<= 1'b0 ; 
                   nS_we<= 1'b0 ; 
                   nW_we<= 1'b0 ; 
                   nE_we<= 1'b0 ; 
                  nNW_we<= 1'b0 ; 
                  nNE_we<= 1'b0 ; 
                  nSW_we<= 1'b0 ; 
                  nSE_we<= 1'b0 ; 
                   ux_we<= 1'b0 ; 
                   uy_we<= 1'b0 ;
          
           n0_write_data<= 27'b0 ; 
           nN_write_data<= 27'b0 ; 
           nS_write_data<= 27'b0 ; 
           nW_write_data<= 27'b0 ; 
           nE_write_data<= 27'b0 ; 
          nNW_write_data<= 27'b0 ; 
          nNE_write_data<= 27'b0 ; 
          nSW_write_data<= 27'b0 ; 
          nSE_write_data<= 27'b0 ; 
           ux_write_data<= 27'b0 ; 
           uy_write_data<= 27'b0 ; 
          	
	color_read_address<=27'd0;
	color_write_address<=27'd0;
	color_write_data<=8'd0;
	color_we<=0;

                 n0_temp <= 27'd0;
                 nN_temp <= 27'd0;
                 nS_temp <= 27'd0;
                 nW_temp <= 27'd0;
                 nE_temp <= 27'd0;
                nNW_temp <= 27'd0;
                nNE_temp <= 27'd0;
                nSW_temp <= 27'd0;
                nSE_temp <= 27'd0;
		ux_temp<=27'd0;
		uy_temp<=27'd0;
		x_collide_read<=14'd0;
		y_collide_read<=14'd0;

		x_collide_write<=14'd0;
		y_collide_write<=14'd0; 
		x_stream1_read<=14'd0;
                y_stream1_read<=14'd0;

	 x_stream1_read<=14'd1;
 y_stream1_read<=14'd70;
x_stream1_write<=14'd1;
y_stream1_write<=14'd70;

 x_stream2_read<=14'd134;
 y_stream2_read<=14'd70;
x_stream2_write<=14'd134;
y_stream2_write<=14'd70;

 x_stream3_read<=14'd134;
 y_stream3_read<=14'd1;
x_stream3_write<=14'd134;
y_stream3_write<=14'd1;

 x_stream4_read<=14'd1;
 y_stream4_read<=14'd1;
x_stream4_write<=14'd1;
y_stream4_write<=14'd1;

//ux_in<=27'd0;
//uy_in<=27'd0;


	x_speed_color_read<=14'd0;
	y_speed_color_read<=14'd0;

	x_speed_color_write<=14'd0;
	y_speed_color_write<=14'd0;

	ux_in_speed<=27'd0;
	uy_in_speed<=27'd0;

end
else begin
//*************************************************collision begin here***********************
if(start_collide==1'b1) begin

   case(state_collide)
		//reset state for collision*************************************
   4'd0:begin              
	x_collide_read<= 14'd1;
	y_collide_read<= 14'd1;
	x_collide_write<= 14'd1;
	y_collide_write<= 14'd1;
	state_collide<=4'd1;

		end


4'd1:begin
 n0_we <= 1'b0 ;
  nN_we <= 1'b0 ;
  nS_we <= 1'b0 ;
  nW_we <= 1'b0 ;
  nE_we <= 1'b0 ;
 nNW_we <= 1'b0 ;
 nNE_we <= 1'b0 ;
 nSW_we <= 1'b0 ;
 nSE_we <= 1'b0 ;
  ux_we <= 1'b0 ;
  uy_we <= 1'b0 ;

 n0_read_address <= k_collide_read ;
    nN_read_address <= k_collide_read ;
    nS_read_address <= k_collide_read ;
    nW_read_address <= k_collide_read ;
    nE_read_address <= k_collide_read ;
   nNW_read_address <= k_collide_read ;
   nNE_read_address <= k_collide_read ;
   nSW_read_address <= k_collide_read ;
   nSE_read_address <= k_collide_read ;




state_collide<=4'd2;

end
//state 0 reset ends*****************state 1 begins********************************************

   4'd2:begin



	

state_collide<=4'd3;



		end
//state 1 ends*****************state 2 begins********************************************


   4'd3:begin
    
            
n0_read_address <= k_collide_read ;
    nN_read_address <= k_collide_read ;
    nS_read_address <= k_collide_read ;
    nW_read_address <= k_collide_read ;
    nE_read_address <= k_collide_read ;
   nNW_read_address <= k_collide_read ;
   nNE_read_address <= k_collide_read ;
   nSW_read_address <= k_collide_read ;
   nSE_read_address <= k_collide_read ;

state_collide<=4'd4;

		end

 4'd4:begin
    n0_temp <=   n0_read_data ;
             nN_temp <=   nN_read_data ;
             nS_temp <=   nS_read_data ;
             nW_temp <=   nW_read_data ;
             nE_temp <=   nE_read_data ;
            nNW_temp <=  nNW_read_data ;
            nNE_temp <=  nNE_read_data ;
            nSW_temp <=  nSW_read_data ;
            nSE_temp <=  nSE_read_data ;

state_collide<=4'd6;

		end



//state 2 ends*****************state 3 begins********************************************

   4'd5:begin
      
     
       
    
            
             

state_collide<=4'd6;

		end
//state 3 ends*****************state 4 begins********************************************
4'd6:begin

       
      
  
      
       n0_write_data <=     n0_temp_out ;
          nN_write_data <=     nN_temp_out ;
          nS_write_data <=     nS_temp_out ;
          nW_write_data <=     nW_temp_out ;
          nE_write_data <=     nE_temp_out ;
         nNW_write_data <=    nNW_temp_out ;
         nNE_write_data <=    nNE_temp_out ;
         nSW_write_data <=    nSW_temp_out ;
         nSE_write_data <=    nSE_temp_out ;
          ux_write_data <=     ux_temp_out ;
          uy_write_data <=     uy_temp_out ;
      
         
      
      
                
                  
       n0_write_address <= k_collide_write ;
       nN_write_address <= k_collide_write ;
       nS_write_address <= k_collide_write ;
       nW_write_address <= k_collide_write ;
       nE_write_address <= k_collide_write ;
      nNW_write_address <= k_collide_write ;
      nNE_write_address <= k_collide_write ;
      nSW_write_address <= k_collide_write ;
      nSE_write_address <= k_collide_write ;
       ux_write_address <= k_collide_write ;
       uy_write_address <= k_collide_write ;
      
      
      
      
		
       		




if(x_collide_read>=14'd134) begin
	x_collide_read<=14'd1;
	if(y_collide_read>=14'd70)begin
		//y_collide_read<=14'd1;
					end
	else begin
		y_collide_read<=y_collide_read+14'd1;
		end
				end
else begin
	x_collide_read<= x_collide_read + 14'd1;
	end





if(x_collide_write>=14'd134) begin
	x_collide_write<=14'd1;
	if(y_collide_write>=14'd70)begin
		//y_collide_write<=14'd1;
					end
	else begin
		y_collide_write<=y_collide_write+14'd1;
		end
				end
else begin
	x_collide_write<= x_collide_write + 14'd1;
	end




if(n0_write_address>=14'd9654) begin
state_collide<=4'd7;

 y_collide_read<=14'd1;
 y_collide_write<=14'd1;

 x_collide_read<=14'd134;
 x_collide_write<=14'd135;


end
else begin
state_collide<=4'd1;
  n0_we <= 1'b1 ;           
		nN_we <= 1'b1 ;
                  nS_we <= 1'b1 ;
                  nW_we <= 1'b1 ;
                  nE_we <= 1'b1 ;
                 nNW_we <= 1'b1 ;
                 nNE_we <= 1'b1 ;
                 nSW_we <= 1'b1 ;
                 nSE_we <= 1'b1 ;
                  ux_we <= 1'b1 ;
                  uy_we <= 1'b1 ;

                 
end


end
//state 4 ends*****************state 5 begins********************************************
4'd7: begin

  n0_we <= 1'b0 ;
  nN_we <= 1'b0 ;
  nS_we <= 1'b0 ;
  nW_we <= 1'b0 ;
  nE_we <= 1'b0 ;
 nNW_we <= 1'b0 ;
 nNE_we <= 1'b0 ;
 nSW_we <= 1'b0 ;
 nSE_we <= 1'b0 ;
  ux_we <= 1'b0 ;
  uy_we <= 1'b0 ;



 nW_read_address <= k_collide_read ;
nNW_read_address <= k_collide_read ;
nSW_read_address <= k_collide_read ;




state_collide<=4'd8;
		end


//state 5 ends*****************state 6 begins********************************************
4'd8: begin
  
 n0_we <=1'b0 ;
 nN_we <=1'b0 ;
 nS_we <=1'b0 ;
 nW_we <=1'b0 ;
 nE_we <=1'b0 ;
 nNW_we <=1'b0 ;
 nNE_we <=1'b0 ;
 nSW_we <=1'b0 ;
 nSE_we <=1'b0 ;
 ux_we <=1'b0 ;
 uy_we <=1'b0 ;



state_collide<=4'd9;
		end
//state 6 ends*****************state 7 begins********************************************

4'd9: begin
state_collide<=4'd11;

end

//state 7 ends*****************state 8 begins********************************************

4'd10: begin
 

state_collide<=4'd11;

end
//state 8 ends*****************state 9 begins********************************************
4'd11: begin
 nW_write_data <=  nW_read_data ;
nNW_write_data <= nNW_read_data ;
nSW_write_data <= nSW_read_data ;

 nW_we <= 1'b1 ;
nNW_we <= 1'b1 ;
nSW_we <= 1'b1 ;


 nW_write_address <= k_collide_write ;
nNW_write_address <= k_collide_write ;
nSW_write_address <= k_collide_write ;




	if(y_collide_read>=14'd70)begin
		y_collide_read<=14'd1;
				end
	else begin
		y_collide_read<=y_collide_read+14'd1;
		end



	if(y_collide_write>=14'd70)begin
		y_collide_write<=14'd1;
		end
	else begin
		y_collide_write<=y_collide_write+14'd1;
		end

if(k_collide_write>= 14'd9519)begin
state_collide<=4'd12;

end
else begin
state_collide<=4'd7;

end


end
//state 9 ends*****************state 10 begins********************************************

4'd12: begin

 n0_we <=1'b0 ;
 nN_we <=1'b0 ;
 nS_we <=1'b0 ;
 nW_we <=1'b0 ;
 nE_we <=1'b0 ;
 nNW_we <=1'b0 ;
 nNE_we <=1'b0 ;
 nSW_we <=1'b0 ;
 nSE_we <=1'b0 ;
 ux_we <=1'b0 ;
 uy_we <=1'b0 ;


state_collide<=4'd13;

end

4'd13:begin
collide_finish<=1'b1;

state_collide<=4'd13;
end

	endcase

end
//*************************************************collision ends here ************ stream begins*****************************************
if(start_stream==1'b1)begin

case(state_stream)
//****************************************state 0 begins ***********************************
4'd0: begin

 x_stream1_read<=14'd1;
 y_stream1_read<=14'd70;
 x_stream1_write<=14'd1;
 y_stream1_write<=14'd70;

 x_stream2_read<=14'd134;
 y_stream2_read<=14'd70;
x_stream2_write<=14'd134;
y_stream2_write<=14'd70;

 x_stream3_read<=14'd134;
 y_stream3_read<=14'd1;
x_stream3_write<=14'd134;
y_stream3_write<=14'd1;

 x_stream4_read<=14'd1;
 y_stream4_read<=14'd1;
x_stream4_write<=14'd1;
y_stream4_write<=14'd1;

state_stream<=4'd1;


end
//**********************************state 0 ends *******************************************
//****************************************state 1 begins ***********************************
4'd1: begin

  nN_read_address <=  nN_k_stream_read ;
  nS_read_address <=  nS_k_stream_read ;
  nW_read_address <=  nW_k_stream_read ;
  nE_read_address <=  nE_k_stream_read ;
 nNW_read_address <= nNW_k_stream_read ;
 nNE_read_address <= nNE_k_stream_read ;
 nSW_read_address <= nSW_k_stream_read ;
 nSE_read_address <= nSE_k_stream_read ;

nN_we <=1'b0 ;
 nS_we <=1'b0 ;
 nW_we <=1'b0 ;
 nE_we <=1'b0 ;
 nNW_we <=1'b0 ;
 nNE_we <=1'b0 ;
 nSW_we <=1'b0 ;
 nSE_we <=1'b0 ;



state_stream<=4'd2;


end
//**********************************state 1 ends *******************************************

//****************************************state 2 begins ***********************************
4'd2: begin





state_stream<=4'd3;


end
//**********************************state 2 ends *******************************************
4'd3: begin





state_stream<=4'd5;


end

4'd4: begin


 



state_stream<=4'd5;


end
//****************************************state 3 begins ***********************************
4'd5: begin




 nN_write_data <=  nN_read_data ;
  nS_write_data <=  nS_read_data ;
  nW_write_data <=  nW_read_data ;
  nE_write_data <=  nE_read_data ;
 nNW_write_data <= nNW_read_data ;
 nNE_write_data <= nNE_read_data ;
 nSW_write_data <= nSW_read_data ;
 nSE_write_data <= nSE_read_data ;




  nN_write_address <=  nN_k_stream_write ;
  nS_write_address <=  nS_k_stream_write ;
  nW_write_address <=  nW_k_stream_write ;
  nE_write_address <=  nE_k_stream_write ;
 nNW_write_address <= nNW_k_stream_write ;
 nNE_write_address <= nNE_k_stream_write ;
 nSW_write_address <= nSW_k_stream_write ;
 nSE_write_address <= nSE_k_stream_write ;


nN_we <=1'b1 ;
 nS_we <=1'b1 ;
 nW_we <=1'b1 ;
 nE_we <=1'b1 ;
 nNW_we <=1'b1 ;
 nNE_we <=1'b1 ;
 nSW_we <=1'b1 ;
 nSE_we <=1'b1 ;


if(x_stream1_read>=14'd134) begin
	x_stream1_read<=14'd1;
	if(y_stream1_read <= 14'd1)begin
		y_stream1_read<=14'd70;
					end
	else begin
		y_stream1_read<=y_stream1_read-14'd1;
		end
				end
else begin
	x_stream1_read<= x_stream1_read + 14'd1;
	end


if(x_stream2_read <=14'd1) begin
	x_stream2_read<=14'd134;
	if(y_stream2_read <= 14'd1)begin
		y_stream2_read<=14'd70;
					end
	else begin
		y_stream2_read<=y_stream2_read-14'd1;
		end
				end
else begin
	x_stream2_read<= x_stream2_read - 14'd1;
	end



if(x_stream3_read <=14'd1) begin
	x_stream3_read<=14'd134;
	if(y_stream3_read >= 14'd70)begin
		y_stream3_read<=14'd1;
					end
	else begin
		y_stream3_read<=y_stream3_read+14'd1;
		end
				end
else begin
	x_stream3_read<= x_stream3_read - 14'd1;
	end

if(x_stream4_read >=14'd134) begin
	x_stream4_read<=14'd1;
	if(y_stream4_read >= 14'd70)begin
		y_stream4_read<=14'd1;
					end
	else begin
		y_stream4_read<=y_stream4_read+14'd1;
		end
				end
else begin
	x_stream4_read<= x_stream4_read + 14'd1;
	end



//*************************write pointers


if(x_stream1_write>=14'd134) begin
	x_stream1_write<=14'd1;
	if(y_stream1_write <= 14'd1)begin
		y_stream1_write<=14'd70;
					end
	else begin
		y_stream1_write<=y_stream1_write-14'd1;
		end
				end
else begin
	x_stream1_write<= x_stream1_write + 14'd1;
	end


if(x_stream2_write <=14'd1) begin
	x_stream2_write<=14'd134;
	if(y_stream2_write <= 14'd1)begin
		y_stream2_write<=14'd70;
					end
	else begin
		y_stream2_write<=y_stream2_write-14'd1;
		end
				end
else begin
	x_stream2_write<= x_stream2_write - 14'd1;
	end



if(x_stream3_write <=14'd1) begin
	x_stream3_write<=14'd134;
	if(y_stream3_write >= 14'd70)begin
		y_stream3_write<=14'd1;
					end
	else begin
		y_stream3_write<=y_stream3_write+14'd1;
		end
				end
else begin
	x_stream3_write<= x_stream3_write - 14'd1;
	end

if(x_stream4_write >=14'd134) begin
	x_stream4_write<=14'd1;
	if(y_stream4_write >= 14'd70)begin
		y_stream4_write<=14'd1;
					end
	else begin
		y_stream4_write<=y_stream4_write+14'd1;
		end
				end
else begin
	x_stream4_write<= x_stream4_write + 14'd1;
	end



	if( nW_k_stream_write >= 14'd9654)begin
		state_stream<=4'd6;

					end
	else begin

 
		state_stream<=4'd1;
		end


end
//**********************************state 3 ends *******************************************
//**********************************state 4 begins *******************************************
4'd6: begin

 
nN_we <=1'b0 ;
 nS_we <=1'b0 ;
 nW_we <=1'b0 ;
 nE_we <=1'b0 ;
 nNW_we <=1'b0 ;
 nNE_we <=1'b0 ;
 nSW_we <=1'b0 ;
 nSE_we <=1'b0 ;

stream_finish<=1'b1;



state_stream<=4'd6;




end
//**********************************state 4 ends *******************************************


endcase




end
//********************************************** init (setequil begin here) **************
if(start_init==1'b1)begin
case(state_init)
//*****************************************state
4'd0:begin

 n0_write_data <= n0_init_data;
 nN_write_data <= nN_init_data;
 nS_write_data <= nS_init_data;
 nW_write_data <= nW_init_data;
 nE_write_data <= nE_init_data;
 nNW_write_data <= nNW_init_data;
 nNE_write_data <= nNE_init_data;
 nSW_write_data <= nSW_init_data;
 nSE_write_data <= nSE_init_data;
 ux_write_data <= ux_init_data;
 uy_write_data <= uy_init_data;

 n0_write_address <= write_address_init;
 nN_write_address <= write_address_init;
 nS_write_address <= write_address_init;
 nW_write_address <= write_address_init;
 nE_write_address <= write_address_init;
 nNW_write_address <= write_address_init;
 nNE_write_address <= write_address_init;
 nSW_write_address <= write_address_init;
 nSE_write_address <= write_address_init;
 ux_write_address <= write_address_init;
 uy_write_address <= write_address_init;

 n0_we <= 1'b1;
 nN_we <= 1'b1;
 nS_we <= 1'b1;
 nW_we <= 1'b1;
 nE_we <= 1'b1;
 nNW_we <= 1'b1;
 nNE_we <= 1'b1;
 nSW_we <= 1'b1;
 nSE_we <= 1'b1;
 ux_we <= 1'b1;
 uy_we <= 1'b1;
state_init<=4'd1;
end

4'd1:begin

 

state_init<=4'd2;
end

4'd2:begin
n0_we <= 1'b0;
 nN_we <= 1'b0;
 nS_we <= 1'b0;
 nW_we <= 1'b0;
 nE_we <= 1'b0;
 nNW_we <= 1'b0;
 nNE_we <= 1'b0;
 nSW_we <= 1'b0;
 nSE_we <= 1'b0;
 ux_we <= 1'b0;
 uy_we <= 1'b0;
init_finish<=1'b1;
state_init<=4'd2;
end

endcase
end
//***************************************move trace begins ****************
if(start_move_trace==1'b1)begin
case(state_move_trace)
4'd0:begin

 


if(init_ship==1'b1)begin

state_move_trace<=4'd5;
end

else begin
state_move_trace<=4'd1;
end
end


4'd1:begin
 ux_read_address<= k_move_trace_read;
 uy_read_address<= k_move_trace_read;
state_move_trace<=4'd2;

end

4'd2:begin
//wait state
state_move_trace<=4'd3;
end
4'd3:begin
//wait state
state_move_trace<=4'd4;
end
4'd4:begin


ux_in<=ux_read_data;
uy_in<=uy_read_data;


state_move_trace<=4'd5;

end
4'd5:begin



move_trace_finish<=1'b1;
state_move_trace<=4'd5;
end
endcase

end
//*************************************************************************************move trace ends ***************
//****************************color VGA drawing begins*************************************************************************
if(start_speed_color==1'b1)begin
case(state_speed_color)
4'd0:begin
color_we<=1'b0;
x_speed_color_read<=14'd0;
y_speed_color_read<=14'd0;

x_speed_color_write<=14'd0;
y_speed_color_write<=14'd0;

state_speed_color<=4'd1; 

end



4'd1:begin

color_we<=1'b0;
 ux_read_address<= k_speed_color_read;
 uy_read_address<= k_speed_color_read;
state_speed_color<=4'd2;

end

4'd2:begin

state_speed_color<=4'd3;



end


4'd3:begin



state_speed_color<=4'd4;

end

4'd4:begin

 ux_in_speed<= ux_read_data ;
 uy_in_speed<= uy_read_data ;

state_speed_color<=4'd5;
end
//****************************state 4 ends 5 begins
4'd5:begin

color_write_address<= k_speed_color_write;

//**********************ship and fish code here*********************************************************************
//********ship
case(k_speed_color_write)
(k_move_trace_read):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd1):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd2):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd3):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd4):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd136):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd137):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd138):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd139):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd133):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd134):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd135):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd272):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd273):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd271):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd274):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd270):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd1):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd2):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd3):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read+14'd4):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd138):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd274):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd410):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd546):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd682):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd818):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd409):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd543):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd681):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd408):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd544):begin
color_write_data<=8'b1111_1111;
end
(k_move_trace_read-14'd407):begin
color_write_data<=8'b1111_1111;
end
(k_fish1):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 - 14'd1):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 - 14'd2):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd1):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd2):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd3):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd4):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 - 14'd137):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd135):begin
color_write_data<=8'b0001_1111;
end
(k_fish1- 14'd136):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 - 14'd272):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd136):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd272):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 - 14'd135):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd137):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 - 14'd133):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd139):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 - 14'd132):begin
color_write_data<=8'b0001_1111;
end
(k_fish1 + 14'd140):begin
color_write_data<=8'b0001_1111;
end
(k_fish2):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 - 14'd1):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 - 14'd2):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd1):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd2):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd3):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd4):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 - 14'd137):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd135):begin
color_write_data<=8'b0001_1111;
end
(k_fish2- 14'd136):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 - 14'd272):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd136):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd272):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 - 14'd135):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd137):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 - 14'd133):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd139):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 - 14'd132):begin
color_write_data<=8'b0001_1111;
end
(k_fish2 + 14'd140):begin
color_write_data<=8'b0001_1111;
end

default:begin
color_write_data = (((speed_out>>19) & 8'b0000_0111)<<5) ;//will it truncate automatically???????????????????????
end

endcase
//color_write_data = (((speed_out>>16) & 8'b0011_1111)>>1) ; //will it truncate automatically???????????????????????
//***********************************************************************************************************************ship and fish end

color_we<=1'b1;

if(y_speed_color_read>=14'd71)begin
	if(x_speed_color_read>=14'd135)begin
		y_speed_color_read<=14'd0;
		x_speed_color_read<=14'd0;
			end
	else begin
y_speed_color_read<=14'd0;
x_speed_color_read<=  x_speed_color_read +14'd1;
		 end

	end
else begin
y_speed_color_read<= y_speed_color_read + 14'd1;

	end

if(y_speed_color_write>=14'd71)begin
	if(x_speed_color_write>=14'd135)begin
		y_speed_color_write<=14'd0;
		x_speed_color_write<=14'd0;
			end
	else begin
y_speed_color_write<=14'd0;
x_speed_color_write<=  x_speed_color_write +14'd1;
		 end

	end
else begin
y_speed_color_write<= y_speed_color_write + 14'd1;

	end



if(color_write_address>=14'd9791)begin
state_speed_color<=4'd7;

end
else begin
state_speed_color<=4'd1;

end





end

4'd6:begin





end


4'd7:begin

state_speed_color<=4'd7;
speed_color_finish<=1'b1;
end


endcase
end


end


end





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
	assign out = {mult_out[53], mult_out[50:25]};
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










module m10k_n( 
    output reg [26:0] data_read,
    input [26:0] data_write,
    input [13:0] write_address, read_address,
    input we, clk
);
	 // force M10K ram style
	 // 256 words of 32 bits
    reg [26:0] mem [9791:0]  /* synthesis ramstyle = "no_rw_check, M10K" */;
	 reg [26:0] temp;
    always @ (posedge clk) begin
        if (we) begin
            mem[write_address] <= data_write;
		  end
        temp <= mem[read_address]; // q doesn't get d in this clock cycle
	data_read<=temp;
    end
endmodule



module m10k_color( 
    output reg [7:0] data_read,
    input [7:0] data_write,
    input [13:0] write_address, read_address,
    input we, clk
);
	 // force M10K ram style
	 // 256 words of 32 bits
    reg [7:0] mem [9791:0]  /* synthesis ramstyle = "no_rw_check, M10K" */;
	 
    always @ (posedge clk) begin
        if (we) begin
            mem[write_address] <= data_write;
		  end
        data_read <= mem[read_address]; // q doesn't get d in this clock cycle
    end
endmodule






module speed_calc(
input wire signed [26:0] ux,
input wire signed [26:0] uy,
output wire [26:0] speed
);

wire  [26:0] ux_abs;
wire  [26:0] uy_abs;
abs a1(ux,ux_abs);
abs a2(uy,uy_abs);

assign speed = (ux_abs >= uy_abs)?  (ux_abs + (uy_abs>>1)): (uy_abs + (ux_abs>>1));


endmodule


module abs(input signed [26:0] a, output [26:0] b);

assign b = (a[26]==1)? (-a) : a;



endmodule



