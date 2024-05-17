`timescale 1ps/1ps
module tb_fsm_lb_systemverilog();


  
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
.omega(27'sd_65922266),
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


wire signed [26:0] u0;
assign u0= 27'sd2684354;

wire signed [26:0] onefix;
assign onefix= 27'sd1<<<25;


always #5 clk= ~clk;

integer i,j,q,r,z;



initial begin

for(r=0;r<480;r=r+1) begin
for(z=0;z<640;z=z+1)begin
#40000;
x_vga=z;
y_vga=r;


end


end


end






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
#100 ;

for(j=0;j<72;j=j+1)begin
for(i=0;i<136;i=i+1)begin
#25 setEquil(i, j, 0, 0, onefix,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= i + 136*j;
#25 start_init=1;

while(init_finish==0)begin
#1;
end
#5 start_init=0;



end

end


#100 init_ship=1;
#10 start_move_trace=1;
while(move_trace_finish==0)begin
#1;
end
#10 start_move_trace=0;
init_ship=0;



//main while loop begins
for(q=0;q<100;q=q+1)begin ///*********************************************number of frames

for(i=0;i<136;i=i+1)begin
#25 setEquil(i, 0, u0, 0, onefix ,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= i ;
#25 start_init=1;
	while(init_finish==0)begin
	#1;
	end
#5 start_init=0;


#25 setEquil(i, 71, u0, 0, onefix ,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= i +136*71 ;
#25 start_init=1;
	while(init_finish==0)begin
	#1;
	end
#5 start_init=0;
end


for(j=1;j<71;j=j+1)begin
if(j>30 && j<40)begin

#25 setEquil(0, j, u0, 0, onefix ,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= j*136 ;
#25 start_init=1;
while(init_finish==0)begin
#1;
end
#5 start_init=0;

#25 setEquil(135, j, u0, 0, onefix ,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= 135 + j*136 ;
#25 start_init=1;
while(init_finish==0)begin
#1;
end
#5 start_init=0;
end




else begin
if(j<=30)begin
#25 setEquil(0, j, 0, (u0>>>1), onefix ,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= j*136 ;
#25 start_init=1;
while(init_finish==0)begin
#1;
end
#5 start_init=0;

	end

else begin

#25 setEquil(0, j, 0, -(u0>>>1), onefix ,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= j*136 ;
#25 start_init=1;
while(init_finish==0)begin
#1;
end
#5 start_init=0;


	end


#25 setEquil(135, j, u0, 0, onefix ,n0_init_data,nN_init_data,nS_init_data,nW_init_data,nE_init_data,nNW_init_data,nNE_init_data,nSW_init_data,nSE_init_data,ux_init_data,uy_init_data);
#25 write_address_init= j*136 + 135 ;
#25 start_init=1;
while(init_finish==0)begin
#1;
end
#5 start_init=0;



end



end



#100 strt_colide=1;

while(collide_finish==0)begin
#1;
end
#5 strt_colide=0;


//stream begins
#100 strt_stream=1;

while(stream_finish==0)begin
#1;
end
#5 strt_stream=0;



#100 start_move_trace=1;
while(move_trace_finish==0)begin
#1;
end
#10 start_move_trace=0;


#100 start_speed_color=1;
while(speed_color_finish==0)begin
#1;
end
#10 start_speed_color=0;
//first speed color


end //end the while loop main



#100 strt_colide=1;

while(collide_finish==0)begin
#1;
end
#5 strt_colide=0;




end



task setEquil;
input [13:0] x;
input [13:0] y;
input signed [26:0] new_ux;
input signed [26:0] new_uy;
input signed [26:0] new_rho;
 output reg signed [26:0] n0_init_data1 ; 
 output reg signed [26:0] nN_init_data1 ; 
 output reg signed [26:0] nS_init_data1 ; 
 output reg signed [26:0] nW_init_data1 ; 
 output reg signed [26:0] nE_init_data1 ; 
 output reg signed [26:0] nNW_init_data1 ; 
 output reg signed [26:0] nNE_init_data1 ; 
 output reg signed [26:0] nSW_init_data1 ; 
 output reg signed [26:0] nSE_init_data1 ; 
 output reg signed [26:0] ux_init_data1 ; 
 output reg signed [26:0] uy_init_data1 ;

reg signed [26:0] ux3;
reg signed [26:0] uy3;
reg signed [26:0] ux2;
reg signed [26:0] uy2;
reg signed [26:0] uxuy2;
reg signed [26:0] u2;
reg signed [26:0] u215;
reg signed [26:0] one9th_newrho;
reg signed [26:0] one36th_newrho;
reg signed [26:0] four9ths_newrho;

begin
 ux3 = m3(new_ux) ;// 3 * newux;
 uy3 = m3(new_uy) ;// 3 * newuy;
 ux2 = mFix(new_ux, new_ux) ;
 uy2 = mFix(new_uy, new_uy);
 uxuy2 = mFix(new_ux, new_uy)<<1 ; //2 * newux * newuy;
 u2 = ux2 + uy2;
 u215 = m1_5(u2) ; // 1.5 * u2;
  one9th_newrho = mFix(27'd3728270, new_rho) ;
  one36th_newrho = mFix(27'd932067, new_rho) ;
  four9ths_newrho = mFix(27'b000111000111000111000111000, new_rho) ;

nE_init_data1 = mFix(one9th_newrho,  (onefix + ux3       + m4_5(ux2)      - u215)) ;
nW_init_data1 = mFix( one9th_newrho, (onefix - ux3       + m4_5(ux2)      - u215)) ;
nN_init_data1 =  mFix( one9th_newrho, (onefix + uy3       + m4_5(uy2)      - u215)) ;
nS_init_data1= mFix( one9th_newrho, (onefix - uy3       + m4_5(uy2)      - u215)) ;
nNE_init_data1 = mFix(one36th_newrho, (onefix + ux3 + uy3 + m4_5(u2+uxuy2) - u215)) ;
nSE_init_data1 = mFix(one36th_newrho, (onefix + ux3 - uy3 + m4_5(u2-uxuy2) - u215)) ;
nNW_init_data1 = mFix(one36th_newrho, (onefix - ux3 + uy3 + m4_5(u2-uxuy2) - u215)) ;
nSW_init_data1 = mFix(one36th_newrho, (onefix - ux3 - uy3 + m4_5(u2+uxuy2) - u215)) ;
n0_init_data1 = new_rho - (nE_init_data + nW_init_data + nN_init_data + nS_init_data + nNE_init_data + nSE_init_data + nNW_init_data + nSW_init_data) ;
ux_init_data1= new_ux;
uy_init_data1=new_uy;

end

endtask



function [26:0] m4_5(input [26:0] a);
begin
m4_5 = (((a)<<<2)+((a)>>>1));
end
endfunction

function [26:0] m1_5(input [26:0] a);
begin
m1_5 = ((a)+((a)>>>1));
end
endfunction

function [26:0] m3(input [26:0] a);
begin
m3 = ((a)+((a)<<<1));
end
endfunction

function signed [26:0] mFix; 
input signed [26:0] a;
input signed [26:0] b;


reg 	signed	[53:0]	mult_out;
begin


	// intermediate full bit length
	
	mult_out = a * b;
	// select bits
	mFix = {mult_out[53], mult_out[51:25]};

end

endfunction

endmodule
