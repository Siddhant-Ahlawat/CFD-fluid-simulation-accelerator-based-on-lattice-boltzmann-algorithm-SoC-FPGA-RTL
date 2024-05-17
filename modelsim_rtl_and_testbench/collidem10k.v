

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

assign k_vga = (x_vga - 10'd200) + (y_vga - 10'd200)*14'd136;

assign color_out_vga = ((x_vga>=10'd200)&&(x_vga<=10'd335)&&(y_vga>=10'd200)&&(y_vga<=10'd271))? color_read_data : 8'b1111_1111;



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

ux_in<=27'd0;
uy_in<=27'd0;


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




