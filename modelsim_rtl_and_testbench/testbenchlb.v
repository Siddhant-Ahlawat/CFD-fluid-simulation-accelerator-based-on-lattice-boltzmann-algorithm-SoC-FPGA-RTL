
module tb_fsm_lb();


  
reg clk;
reg rst;
reg strt_colide;
reg strt_stream;
reg start_init;
 reg signed [26:0] n0_init_data;
 reg signed [26:0] nN_init_data;
 reg signed [26:0] nS_init_data;
 reg signed [26:0] nW_init_data;
 reg signed [26:0] nE_init_data;
 reg signed [26:0] nNW_init_data;
 reg signed [26:0] nNE_init_data;
 reg signed [26:0] nSW_init_data;
 reg signed [26:0] nSE_init_data;
 reg signed [26:0] ux_init_data;
 reg signed [26:0] uy_init_data;
reg [13:0] write_address_init;
wire init_finish;
wire stream_finish;
wire collide_finish;
reg start_speed_color;
reg init_ship;
reg start_move_trace;
reg [9:0] x_vga;
reg [9:0] y_vga;
wire [7:0] color_out_vga;
wire init_ship_finish;
wire speed_color_finish;
wire move_trace_finish;






 collide_stream_fsm k00(
.clk(clk),
.rst(rst),
.start_collide(strt_colide),
.start_init(start_init),
.start_speed_color(start_speed_color),
.start_move_trace(start_move_trace),
.init_ship(init_ship),
.omega(27'd_65922266),
.x_vga(x_vga),
.y_vga(y_vga),
 .n0_init_data(n0_init_data),
 .nN_init_data(nN_init_data),
 .nS_init_data(nS_init_data),
 .nW_init_data(nW_init_data),
 .nE_init_data(nE_init_data),
 .nNW_init_data(nNW_init_data),
 .nNE_init_data(nNE_init_data),
 .nSW_init_data(nSW_init_data),
 .nSE_init_data(nSE_init_data),
 .ux_init_data(ux_init_data),
 .uy_init_data(uy_init_data),
.write_address_init(write_address_init),
.start_stream(strt_stream),
.color_out_vga(color_out_vga),
.stream_finish(stream_finish),
.collide_finish(collide_finish),
.init_ship_finish(init_ship_finish),
.speed_color_finish(speed_color_finish),
.move_trace_finish(move_trace_finish),
.init_finish(init_finish)
);








always #5 clk= ~clk;


initial begin
clk=1'b0;
strt_colide=0;
strt_stream=0;
start_move_trace=0;
start_speed_color=0;
rst=1'b0;
#10 start_init=1'b0;
#1 rst= 1'b1;
#50 rst=1'b0;
#100 strt_colide=1;
while(collide_finish==0)begin
#1;
end
strt_colide=0;
#100;
end

endmodule
