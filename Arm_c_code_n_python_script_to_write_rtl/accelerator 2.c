///////////////////////////////////////
/// 640x480 version! 16-bit color
/// This code will segfault the original
/// DE1 computer
/// compile with
/// gcc graphics_video_16bit.c -o gr -O2 -lm
///
///////////////////////////////////////
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/ipc.h> 
#include <sys/shm.h> 
#include <sys/mman.h>
#include <sys/time.h> 
#include <math.h>
//#include "address_map_arm_brl4.h"

// video display
#define SDRAM_BASE            0xC0000000
#define SDRAM_END             0xC3FFFFFF
#define SDRAM_SPAN			  0x05000000

#define AXI_MASTER_BASE       0xC4002000
#define AXI_MASTER_END        0xC91FFFFF
#define AXI_MASTER_SPAN		  0x00200000

#define MYPIO_N0_FROM_HPS     0x000031B0
#define MYPIO_NN_FROM_HPS     0x00003050
#define MYPIO_NS_FROM_HPS     0x00003060
#define MYPIO_NW_FROM_HPS     0x00003070
#define MYPIO_NE_FROM_HPS     0x00003080
#define MYPIO_NNW_FROM_HPS    0x00003090
#define MYPIO_NNE_FROM_HPS    0x000030A0
#define MYPIO_NSW_FROM_HPS    0x000030B0
#define MYPIO_NSE_FROM_HPS    0x000030C0

#define MYPIO_START_COLLIDE      0x000030D0
#define MYPIO_START_STREAM       0x000030F0
#define MYPIO_START_MOVE_TRACE   0x00003150
#define MYPIO_START_INIT         0x00003120
#define MYPIO_START_SPEED_COLOR  0x00003170
#define MYPIO_COLLIDE_FINISH     0x000030E0
#define MYPIO_STREAM_FINISH      0x00003100
#define MYPIO_MOVE_TRACE_FINISH  0x00003160
#define MYPIO_INIT_FINISH        0x00003130
#define MYPIO_SPEED_COLOR_FINISH 0x00003180
#define MYPIO_INIT_SHIP          0x00003140
#define MYPIO_WRITE_ADDRESS_INIT 0x00003110
#define MYPIO_UX_FROM_HPS        0x00003190
#define MYPIO_UY_FROM_HPS        0x000031A0
#define MYPIO_PIPES              0x000031D0
#define MYPIO_RESET_FROM_HPS     0x000031C0
#define MYPIO_START_PRINT        0x000031E0
#define MYPIO_PRINT_FINISH       0x000031F0

#define MYPIO_SHIP_X             0x00003210
#define MYPIO_SHIP_Y             0x00003220

#define MYPIO_UX_IN              0x00003230
#define MYPIO_UY_IN              0x00003240

#define MYPIO_X_FISH1            0x00003250
#define MYPIO_X_FISH2            0x00003270
#define MYPIO_Y_FISH1            0x00003260
#define MYPIO_Y_FISH2            0x00003280

#define MYPIO_SCORE              0x00003200
// characters
#define FPGA_CHAR_BASE        0xC9000000 
#define FPGA_CHAR_END         0xC9001FFF
#define FPGA_CHAR_SPAN        0x00002000
/* Cyclone V FPGA devices */
#define HW_REGS_BASE          0xff200000
//#define HW_REGS_SPAN        0x00200000 
#define HW_REGS_SPAN          0x00005000 

// graphics primitives
void VGA_text (int, int, char *);
void VGA_text_clear();
void VGA_box (int, int, int, int, short);
void VGA_rect (int, int, int, int, short);
void VGA_line(int, int, int, int, short) ;
void VGA_Vline(int, int, int, short) ;
void VGA_Hline(int, int, int, short) ;
void VGA_disc (int, int, int, short);
void VGA_circle (int, int, int, int);
void VGA_ship (int,int,int,int,short);
void draw_fish1(void);
void draw_fish2(void);
// 16-bit primary colors
    // R bits 11-15 mask 0xf800
	// G bits 5-10  mask 0x07e0
	// B bits 0-4   mask 0x001f
	// so color = B+(G<<5)+(R<<11);
#define red  (0+(0<<5)+(31<<11))
#define dark_red (0+(0<<5)+(15<<11))
#define green (0+(63<<5)+(0<<11))
#define dark_green (0+(31<<5)+(0<<11))
#define blue (31+(0<<5)+(0<<11))
#define dark_blue (15+(0<<5)+(0<<11))
#define yellow (0+(63<<5)+(31<<11))
#define cyan (31+(63<<5)+(0<<11))
#define magenta (31+(0<<5)+(31<<11))
#define black (0x0000)
#define gray (15+(31<<5)+(51<<11))
#define white (0xffff)
int colors[] = {red, dark_red, green, dark_green, blue, dark_blue, 
		yellow, cyan, magenta, gray, black, white};

// pixel macro
#define VGA_PIXEL(x,y,color) do{\
	int  *pixel_ptr ;\
	pixel_ptr = (int*)((char *)vga_pixel_ptr + (((y)*640+(x))<<1)) ; \
	*(short *)pixel_ptr = (color);\
} while(0)

// the light weight buss base
void *h2p_lw_virtual_base;
void *h2p_axi_virtual_base;

volatile unsigned int *mypio_n0_write_ptr = NULL;
volatile unsigned int *mypio_nn_write_ptr = NULL;
volatile unsigned int *mypio_ns_write_ptr = NULL;
volatile unsigned int *mypio_nw_write_ptr = NULL;
volatile unsigned int *mypio_ne_write_ptr = NULL;
volatile unsigned int *mypio_nnw_write_ptr = NULL;
volatile unsigned int *mypio_nne_write_ptr = NULL;
volatile unsigned int *mypio_nsw_write_ptr = NULL;
volatile unsigned int *mypio_nse_write_ptr = NULL;
volatile unsigned int *mypio_start_collide_write_ptr = NULL;
volatile unsigned int *mypio_start_stream_write_ptr = NULL;
volatile unsigned int *mypio_start_init_write_ptr = NULL;
volatile unsigned int *mypio_ux_write_ptr = NULL;
volatile unsigned int *mypio_uy_write_ptr = NULL;
volatile unsigned int *mypio_start_move_trace_write_ptr = NULL;
volatile unsigned int *mypio_start_speed_color_write_ptr = NULL;
volatile unsigned int *mypio_write_address_init_write_ptr = NULL;
volatile unsigned int *mypio_init_ship_write_ptr = NULL;

volatile unsigned int *mypio_finish_collide_read_ptr = NULL;
volatile unsigned int *mypio_finish_stream_read_ptr = NULL;
volatile unsigned int *mypio_finish_init_read_ptr = NULL;
volatile unsigned int *mypio_finish_move_trace_read_ptr = NULL;
volatile unsigned int *mypio_finish_speed_color_read_ptr = NULL;
volatile unsigned int *mypio_pipes_read_ptr = NULL;
volatile unsigned int *mypio_reset_signal_write_ptr = NULL;

volatile unsigned int *mypio_print_finish_read_ptr = NULL;
volatile unsigned int *mypio_start_print_write_ptr = NULL;

volatile unsigned int *mypio_x_fish1_write_ptr = NULL;
volatile unsigned int *mypio_x_fish2_write_ptr = NULL;
volatile unsigned int *mypio_y_fish1_write_ptr = NULL;
volatile unsigned int *mypio_y_fish2_write_ptr = NULL;
volatile unsigned int *mypio_score_write_ptr = NULL;
volatile unsigned int *mypio_ship_x_write_ptr = NULL;
volatile unsigned int *mypio_ship_y_write_ptr = NULL;

volatile unsigned int *mypio_ux_in_read_ptr = NULL;
volatile unsigned int *mypio_uy_in_read_ptr = NULL;

// pixel buffer
volatile unsigned int * vga_pixel_ptr = NULL ;
void *vga_pixel_virtual_base;

// character buffer
volatile unsigned int * vga_char_ptr = NULL ;
void *vga_char_virtual_base;

// /dev/mem file id
int fd;
int x_fish1 =0;
		int y_fish1 = 0;
		int x_fish2 = 0;
		int y_fish2 = 0;
int fish=0;
/*
// s1.30 format
// == resolution 2^-30 = 1e-9
// == dynamic range is +1.9999/-2.0
typedef signed int Fix ;
#define two30 1073741824.0
#define two14 16384
#define mFix(a,b) ((Fix)((((signed long long)(a))*((signed long long)(b)))>>30)) 
#define f2Fix(a) ((Fix)((a)*two30)) // 
#define Fix2f(a) ((float)(a)/two30)
#define absFix(a) abs(a) 
#define divFix(a,b) ((Fix)(((((signed long long)(a))<<30)/(b)))) 
*/

// s1.25 format (FPGA size)
// == resolution 2^-30 = 1e-9
// == dynamic range is +1.9999/-2.0
typedef signed int Fix ;
#define two30 1073741824.0
#define two14 16384.0
#define two25 33554432.0
#define mFix(a,b) ((Fix)((((signed long long)(a))*((signed long long)(b)))>>25)) 
#define f2Fix(a) ((Fix)((a)*two25)) // 
#define Fix2f(a) ((float)(a)/two25)
#define i2Fix(a) ((Fix)((a)<<25)) // 
#define Fix2i(a) ((int)(a)>>25)
#define absFix(a) abs(a) 
#define divFix(a,b) ((Fix)(((((signed long long)(a))<<25)/(b)))) 


// s17.14 format
typedef signed int Fix14 ;
#define mFix14(a,b) ((Fix14)((((signed long long)(a))*((signed long long)(b)))>>14)) 
#define f2Fix14(a) ((Fix14)((a)*two14)) // 
#define Fix142f(a) ((float)(a)/two14)
#define i2Fix14(a) ((Fix14)((a)<<14)) // 
#define Fix142i(a) ((int)(a)>>14)




// some multiply macros for small whole numbers
#define m3(a) ((a)+((a)<<1))
#define m1_5(a) ((a)+((a)>>1))
#define m4_5(a) (((a)<<2)+((a)>>1))
#define min(X,Y) ((X) < (Y) ? (X) : (Y))
#define max(X,Y) ((X) > (Y) ? (X) : (Y))

#define true 1
#define false 0

// ==================================================
// === Lattice Boltzmann code from Daniel V. Schroeder
// ==================================================
/*
A lattice-Boltzmann fluid simulation in JavaScript, using HTML5 canvas for graphics	
	Copyright 2013, Daniel V. Schroeder
  >>> Modifed for C on  Pi Pico by Bruce Land 2022 <<<
	Permission is hereby granted, free of charge, to any person obtaining a copy of 
	this software and associated data and documentation (the "Software"), to deal in 
	the Software without restriction, including without limitation the rights to 
	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
	of the Software, and to permit persons to whom the Software is furnished to do 
	so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all 
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR 
	ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
	OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
	OTHER DEALINGS IN THE SOFTWARE.

	Except as contained in this notice, the name of the author shall not be used in 
	advertising or otherwise to promote the sale, use or other dealings in this 
	Software without prior written authorization.
  */
 // Global floatiables:	

	//int pxPerSquare = 1 ;
													// width of plotted grid site in pixels
	#define xdim  136			// grid dimensions for simulation 250x100
	#define ydim 72 
	int x_ship=0,y_ship=0;
	char running = true;						// will be true when running
	int stepCount = 0;
	int startTime = 0;
	Fix four9ths = f2Fix(4.0 / 9.0) ;					// abbreviations
	Fix one9th = f2Fix(1.0 / 9.0) ;
	Fix one36th = f2Fix(1.0 / 36.0) ;
    Fix onefix = f2Fix(1.0) ;
    Fix halffix = f2Fix(0.5) ;
	Fix omega;
	Fix viscosity;
	 Fix14 fish1x,fish1y,fish2x,fish2y;
	//
	int barrierCount = 0;
	int barrierxSum = 0;
	int barrierySum = 0;
	float barrierFx = 0.0;						// total force on all barrier sites
	float barrierFy = 0.0;
	int time = 0;								// time (in simulation step units) since data collection started
	char showingPeriod = false;
	
	// Create the arrays of fluid particle densities, etc. (using 1D arrays for speed):
	// To index into these arrays, use x + y*xdim, traversing rows first and then columns.
	          // macroscopic y-velocity
	//float curl  [xdim*ydim];
			// boolean array of barrier locations

  //#define nColors 16;

  // Initialize tracers (but don't place them yet):
   #define n_trace  1
  Fix14 halffix14 = f2Fix14(0.5) ;
  #define tracer_enable 1
  Fix14 trace_x [n_trace];
  Fix14 trace_y [n_trace];
  int ship_x=0,ship_y=0;
  
  // unstable above 0.10 or so
  Fix fluid_speed = f2Fix(0.08) ;
  // 30 bit is unstable at viscosity 0.002 and speed 0.10
  Fix fluid_viscosity = f2Fix(0.003) ;
  #define stepsPerFrame 1

  int xxx=0;

// =========================================
// LB init function
// =========================================

void init_LB(void){
	// Initialize to a steady rightward flow with no barriers:
	
  	//for (int t=0; t<nTracers; t++) {
	//	tracerX[t] = 0; tracerY[t] = 0;
	//}
} // end init_LB

void init_trace(void){
draw_fish1();
draw_fish2();

    int i;
	for( i=0; i<n_trace; i++){
		trace_x[i] = i2Fix14(4 + (rand() % (xdim-100))) ; //i2Fix14(4 + 20*i/ydim) ;
		trace_y[i] =  i2Fix14(40) ; //4 + i2Fix14(i % (ydim-6)) ;
	}

     

    
   
	*(mypio_init_ship_write_ptr)=1;
	*(mypio_start_move_trace_write_ptr)=1;
	  
	  int wait=0;
	  while(1)
      {wait = 1;
	  if(*(mypio_finish_move_trace_read_ptr)==1)
	  {break;}
	  }

	*(mypio_start_move_trace_write_ptr)=0;
	*(mypio_init_ship_write_ptr)=0;
}

void move_trace(void){



	*(mypio_start_move_trace_write_ptr)=1;
	  
	  int wait=0;
	  while(1)
      {wait = 1;
	  if(*(mypio_finish_move_trace_read_ptr)==1)
	  {break;}
	  }
	*(mypio_start_move_trace_write_ptr)=0;	
 int i, index;
	for(i=0; i<n_trace; i++){

		int ux,uy;
		ux= (*(mypio_ux_in_read_ptr))<<5;
		uy =(*(mypio_uy_in_read_ptr))<<5;
		int index = Fix142i(trace_x[i]+halffix14) + xdim*Fix142i(trace_y[i]+halffix14) ;
		trace_x[i] += (ux)>>13 ;
		//if(Fix2i(trace_x[i])<1) 
		trace_y[i] += (uy)>>13 ;
		if( (Fix142i(trace_x[i])>xdim-4)) {
			trace_x[i] = 10  ;
			trace_y[i] = 50    ;
			//trace_y[i] = i2Fix14(4 ) ;
		}
		//if( Fix2i(trace_y[i])>ydim-4) trace_y[i] = trace_y[i] - 72 ;
	}
    *(mypio_ship_x_write_ptr)=  Fix142i(trace_x[i]);
      
          *(mypio_ship_y_write_ptr)=  Fix142i(trace_y[i]);
// printf("ux_in = %d \n",*(mypio_ux_in_read_ptr)>>12);
//printf("uy_in = %d \n",*(mypio_uy_in_read_ptr)>>12);

}

void draw_fish1( void ){
fish1x = i2Fix14(8 + (rand() % (xdim-7))) ;
    fish1y = i2Fix14(8 + (rand() % (ydim-7))) ;

}

void draw_fish2(void ){
fish2x = i2Fix14(8 + (rand() % (xdim-7))) ;
    fish2y = i2Fix14(9 + (rand() % (ydim-9))) ;

}

// Set all densities in a cell to their equilibrium values for a given velocity and density:
// (If density is omitted, it's left unchanged.)
void setEquil(int x, int y, Fix newux, Fix newuy, Fix newrho) {
	int i = x + y*xdim;
	//if (typeof newrho == 'undefined') {
		//newrho = rho[i];
	//}
	Fix ux3 = m3(newux) ;// 3 * newux;
	Fix uy3 = m3(newuy) ;// 3 * newuy;
	Fix ux2 = mFix(newux, newux) ;
	Fix uy2 = mFix(newuy, newuy);
	Fix uxuy2 = mFix(newux, newuy)<<1 ; //2 * newux * newuy;
	Fix u2 = ux2 + uy2;
	Fix u215 = m1_5(u2) ; // 1.5 * u2;
    Fix one9th_newrho = mFix(one9th, newrho) ;
    Fix one36th_newrho = mFix(one36th, newrho) ;
    Fix four9ths_newrho = mFix(four9ths, newrho) ;
	//n0[i]  = mFix(four9ths_newrho, (1 - u215));

		Fix nN1,nW1,nS1,nE1,nNE1,nNW1,nSE1,nSW1,n01;

			nN1= mFix( one9th_newrho, (onefix + uy3       + m4_5(uy2)      - u215)) ;
			nS1 =  mFix( one9th_newrho, (onefix - uy3       + m4_5(uy2)      - u215)) ;
			nE1 =  mFix(one9th_newrho,  (onefix + ux3       + m4_5(ux2)      - u215)) ;
			nW1 = mFix( one9th_newrho, (onefix - ux3       + m4_5(ux2)      - u215)) ;
			nNE1 = mFix(one36th_newrho, (onefix + ux3 + uy3 + m4_5(u2+uxuy2) - u215)) ;
			nNW1 =  mFix(one36th_newrho, (onefix - ux3 + uy3 + m4_5(u2-uxuy2) - u215)) ;
			nSE1 = mFix(one36th_newrho, (onefix + ux3 - uy3 + m4_5(u2-uxuy2) - u215)) ;
			nSW1 = mFix(one36th_newrho, (onefix - ux3 - uy3 + m4_5(u2+uxuy2) - u215)) ;
			n01 = newrho - (nE1+nW1+nN1+nS1+nNE1+nSE1+nNW1+nSW1) ;

		 *(mypio_ne_write_ptr)  = nE1;
	 *(mypio_nw_write_ptr)  = nW1;
	 *(mypio_nn_write_ptr)  = nN1;
	 *(mypio_ns_write_ptr)  = nS1;
	*(mypio_nne_write_ptr) = nNE1;
	*(mypio_nse_write_ptr) = nSE1;
	*(mypio_nnw_write_ptr) = nNW1;
	*(mypio_nsw_write_ptr) = nSW1;
     *(mypio_n0_write_ptr) = n01;
	 *(mypio_ux_write_ptr) = newux;
	 *(mypio_uy_write_ptr) = newuy;

	 /*
printf("n0 sent = %d \n",*(mypio_n0_write_ptr ));
printf("nW sent = %d \n",*(mypio_nw_write_ptr ));
printf("ne sent = %d \n",*(mypio_ne_write_ptr ));
printf("nn sent = %d \n",*(mypio_nn_write_ptr ));
printf("nne sent = %d \n",*(mypio_nne_write_ptr ));
printf("nse sent = %d \n",*(mypio_nse_write_ptr ));
printf("nnw sent = %d \n",*(mypio_nnw_write_ptr ));
printf("nsw sent = %d \n",*(mypio_nsw_write_ptr ));
printf("ns sent = %d \n",*(mypio_ns_write_ptr ));
printf("ux sent = %d \n",*(mypio_ux_write_ptr ));
printf("uy sent = %d \n",*(mypio_uy_write_ptr ));
*/

	*(mypio_write_address_init_write_ptr) = i;
//printf("init address sent = %d \n",*(mypio_write_address_init_write_ptr ));
	*(mypio_start_init_write_ptr)=1;
	//printf("start_init sent = %d \n",*(mypio_start_init_write_ptr ));
	  //printf("n0 = %d,\n nN = %d,\n nW = %d,\n nE = %d,\n nS = %d,\n nNE = %d,\n nNW = %d,\n nSE = %d,\n nSW = %d,\n  ux= %d,\n uy = %d,\n address = %d,\n  ",n01,nN1,nW1,nE1,nS1,nNE1,nNW1,nSE1,nSW1,newux,newuy,(i));
	  int wait=0;
	  while(1)
      {wait = 1;
	  //printf("waiting for finish \n");
	  if(*(mypio_finish_init_read_ptr)==1)
	  {//printf("waiting for finish \n");
		  break;}
	  }
	*(mypio_start_init_write_ptr)=0;




}

// Function to initialize or re-initialize the fluid, based on speed slider setting:
void initFluid() {
	// Amazingly, if I nest the y loop inside the x loop, Firefox slows down by a factor of 20
	Fix u0 = fluid_speed;
	int x, y ;
	for ( y=0; y<ydim; y++) {
		for ( x=0; x<xdim; x++) {
			setEquil(x, y, 0, 0, onefix);
			//printf("init_fluid for address = %d", (x + xdim*y));
            //setEquil(x, y, u0, 0, 1);
			//curl[x+y*xdim] = 0.0;
		}
	}
//paintCanvas();
} // end initFluid

// Set the fluid floatiables at the boundaries, according to the current slider value:
void setBoundaries() {//printf("set_boundaries***** \n");
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		setEquil(x, 0, u0, 0, onefix);
		setEquil(x, ydim-1, u0, 0, onefix);
		
	}
	for ( y=1; y<ydim-1; y++) {
		if(y>30 && y<40){
		setEquil(0, y, u0, 0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);}
		else if(y>70 && y<80){setEquil(0, y, u0, 0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);}
		else {if(y<=30){setEquil(0, y, 0, u0>>1, onefix);}
		else{setEquil(0, y, 0, -(u0>>1), onefix);
		}
		
		setEquil(xdim-1, y, u0, 0, onefix);
		}
	}
} // end setBoundaries()
// Set the fluid floatiables at the boundaries, according to the current slider value:




void pipe1() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>40 && x<50)){
		setEquil(x, 0, 0, u0, onefix);
		setEquil(x, ydim-1, -u0, 0, onefix);}
		else{
			if(x<=40){setEquil(x, 0, u0>>1, 0, onefix);}
			else{setEquil(x, 0, (u0>>1), 0, onefix);}
			
		setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, (u0>>1), onefix);
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		}
	
} // end setBoundaries()

void pipe22() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>65 && x<75)){
		setEquil(x, 0, 0, u0, onefix);
		setEquil(x, ydim-1, -u0, 0, onefix);}
		else{
			if(x<=65){setEquil(x, 0, u0>>1, 0, onefix);}
			else{setEquil(x, 0, -(u0>>1), 0, onefix);}
			
		setEquil(x, ydim-1, -u0>>1, 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, -(u0>>1), onefix);
		setEquil(xdim-1, y, 0, -(u0>>1), onefix);
		}
	
} // end setBoundaries()


void pipe3() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>105 && x<115)){
		setEquil(x, 0, 0, u0, onefix);
		setEquil(x, ydim-1, -u0, 0, onefix);}
		else{
			if(x<=105){setEquil(x, 0, u0>>1, 0, onefix);}
			else{setEquil(x, 0, -(u0>>1), 0, onefix);}
			
		setEquil(x, ydim-1, -u0>>1, 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, -(u0>>1), onefix);
		setEquil(xdim-1, y, 0, -(u0>>1), onefix);
		}
	
} // end setBoundaries()




void pipe4() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>105 && x<115)){
		setEquil(x, 0, u0, 0, onefix);
		setEquil(x, ydim-1, 0, -u0, onefix);}
		else{
			if(x<=105){setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
			else{setEquil(x, ydim-1, (u0>>1), 0, onefix);}
			
		setEquil(x, 0, u0>>1, 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, -(u0>>1), onefix);
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		}
	
} // end setBoundaries()

void pipe5() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>65 && x<75)){
		setEquil(x, 0, u0>>1, 0, onefix);
		setEquil(x, ydim-1, 0, -u0, onefix);}
		else{
			if(x<=65){setEquil(x, ydim-1, u0>>1, 0, onefix);}
			else{setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
			
		setEquil(x, 0, u0>>1, 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, -(u0>>1), onefix);
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		}
	
} // end setBoundaries()

void pipe6() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>40 && x<50)){
		setEquil(x, 0, u0, 0, onefix);
		setEquil(x, ydim-1, 0, -u0, onefix);}
		else{
			if(x<=30){setEquil(x, ydim-1, u0>>1, 0, onefix);}
			else{setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
			
		setEquil(x, 0, u0>>1, 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, -(u0>>1), onefix);
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		}
	
} // end setBoundaries()



void pipe7() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		
		setEquil(x, 0, -(u0>>1), 0, onefix);
		setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
		
	
	for ( y=1; y<ydim-1; y++) {
		if(y>25 && y<35){setEquil(xdim-1, y, 0,u0>>1, onefix);
		setEquil(0, y, u0, 0, onefix);}
		else{
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		if(y<=25){
		setEquil(0, y, 0, (u0>>1), onefix);}
		else{setEquil(0, y, 0, -(u0>>1), onefix);}
		}
		}
	
} // end setBoundaries()

void pipe8() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		
		setEquil(x, 0, -(u0>>1), 0, onefix);
		setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
		
	
	for ( y=1; y<ydim-1; y++) {
		if(y>45 && y<55){setEquil(xdim-1, y, 0,u0>>1, onefix);
		setEquil(0, y, u0, 0, onefix);}
		else{
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		if(y<=45){
		setEquil(0, y, 0, (u0>>1), onefix);}
		else{setEquil(0, y, 0, -(u0>>1), onefix);}
		}
		}
	
} // end setBoundaries()


void pipe9() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		
		setEquil(x, 0, -(u0>>1), 0, onefix);
		setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
		
	
	for ( y=1; y<ydim-1; y++) {
		if(y>45 && y<55){setEquil(xdim-1, y, 0,u0>>1, onefix);
		setEquil(0, y, 0, u0>>1, onefix);}
		else{
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		if(y<=45){
		setEquil(0, y, 0, (u0>>1), onefix);}
		else{setEquil(0, y, 0, -(u0>>1), onefix);}
		}
		}
	
} // end setBoundaries()



// Collide particles within each cell (here's the physics!):
void collide(void) {
	 xxx++;
	 //printf("collide begin \n");
	 *(mypio_start_collide_write_ptr)=1;
	 // printf("collide wait ffor finsih \n");
	  int wait=0;
	  while(1)
      {wait = 1;
	  if(*(mypio_finish_collide_read_ptr)==1)
	  {break;}
	  }
	 // printf("collide end \n");
	*(mypio_start_collide_write_ptr)=0;
} // end collide

// Move particles along their directions of motion:
void stream(void) {
	//printf("stream begin \n");
  *(mypio_start_stream_write_ptr)=1;
	  
	  int wait=0;
	  while(1)
      {wait = 1;
	 // printf("stream wait \n");
	  if(*(mypio_finish_stream_read_ptr)==1)
	  {break;}
	  }
	 // printf("stream end \n");
	*(mypio_start_stream_write_ptr)=0;
	
} // end stream


// Simulate function executes a bunch of steps and then schedules another call to itself:
void simulate(int countt) {
	// 
	//printf("8 \n");
	
	
	 if(*( mypio_pipes_read_ptr)==2){pipe1();}
		else if(*( mypio_pipes_read_ptr)==4){pipe22();}
		else if(*( mypio_pipes_read_ptr)==8){pipe3();}
		else if(*( mypio_pipes_read_ptr)==16){pipe4();}
		else if(*( mypio_pipes_read_ptr)==32){pipe5();}
		else if(*( mypio_pipes_read_ptr)==64){pipe6();}
		else if(*( mypio_pipes_read_ptr)==128){pipe7();}
		else if(*( mypio_pipes_read_ptr)==256){pipe8();}
		else{
			pipe9();
			//setBoundaries();
		}
	//printf("9 \n");
	
	int step ;
	// Execute a bunch of time steps:
	for ( step=0; step<stepsPerFrame; step++) {
		collide();
	//printf("10 \n");
		stream();
		//printf("11 \n");
		
		//moveTracers();
		//lastBarrierFy = barrierFy;
	}
	//paintCanvas();

	if (running) {
		stepCount += stepsPerFrame;
	}
	
}






// end of LB	
	
// measure time
struct timeval t1, t2,t3,t4;
double elapsedTime=0;
	
int main(void)
{
  	viscosity = fluid_viscosity;	// kinematic viscosity coefficient in natural units
	omega = divFix(onefix, (m3(viscosity) + halffix));		// reciprocal of relaxation time
	// === need to mmap: =======================
	// FPGA_CHAR_BASE
	// FPGA_ONCHIP_BASE      
	// HW_REGS_BASE        
  
	// === get FPGA addresses ==================
    // Open /dev/mem
	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) 	{
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}
    
    // get virtual addr that maps to physical
	h2p_lw_virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );	
	if( h2p_lw_virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap1() failed...\n" );
		close( fd );
		return(1);
	}
    
 
    
		

 mypio_n0_write_ptr					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_N0_FROM_HPS );
mypio_nn_write_ptr 					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NN_FROM_HPS );
mypio_ns_write_ptr 					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NS_FROM_HPS );
mypio_nw_write_ptr					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NW_FROM_HPS );
mypio_ne_write_ptr 					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NE_FROM_HPS );
mypio_nnw_write_ptr 				=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NNW_FROM_HPS );
mypio_nne_write_ptr 				=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NNE_FROM_HPS );
mypio_nsw_write_ptr					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NSW_FROM_HPS );
mypio_nse_write_ptr					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_NSE_FROM_HPS );
mypio_start_collide_write_ptr 		=(unsigned int *)(h2p_lw_virtual_base + MYPIO_START_COLLIDE );
mypio_start_stream_write_ptr 		=(unsigned int *)(h2p_lw_virtual_base + MYPIO_START_STREAM );
mypio_start_init_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_START_INIT );
mypio_ux_write_ptr 					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_UX_FROM_HPS );
mypio_uy_write_ptr 					=(unsigned int *)(h2p_lw_virtual_base + MYPIO_UY_FROM_HPS );
mypio_start_move_trace_write_ptr	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_START_MOVE_TRACE );
mypio_start_speed_color_write_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_START_SPEED_COLOR );
mypio_write_address_init_write_ptr	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_WRITE_ADDRESS_INIT );
mypio_init_ship_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_INIT_SHIP );
						
mypio_finish_collide_read_ptr		=(unsigned int *)(h2p_lw_virtual_base + MYPIO_COLLIDE_FINISH );
mypio_finish_stream_read_ptr 		=(unsigned int *)(h2p_lw_virtual_base + MYPIO_STREAM_FINISH );
mypio_finish_init_read_ptr			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_INIT_FINISH );
mypio_finish_move_trace_read_ptr	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_MOVE_TRACE_FINISH );
mypio_finish_speed_color_read_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_SPEED_COLOR_FINISH );
mypio_pipes_read_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_PIPES );
		mypio_reset_signal_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_RESET_FROM_HPS );

mypio_print_finish_read_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_PRINT_FINISH );
		mypio_start_print_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_START_PRINT );

mypio_x_fish1_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_X_FISH1 );
mypio_x_fish2_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_X_FISH2 );
mypio_y_fish1_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_Y_FISH1);
mypio_y_fish2_write_ptr 			=(unsigned int *)(h2p_lw_virtual_base + MYPIO_Y_FISH2 );

mypio_ship_x_write_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_SHIP_X );
mypio_ship_y_write_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_SHIP_Y );


mypio_ux_in_read_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_UX_IN );
mypio_uy_in_read_ptr 	=(unsigned int *)(h2p_lw_virtual_base + MYPIO_UY_IN );


mypio_score_write_ptr = (unsigned int *)(h2p_lw_virtual_base + MYPIO_SCORE );

*(mypio_n0_write_ptr					) = 0;
*(mypio_nn_write_ptr 				) = 0;
*(mypio_ns_write_ptr 				) = 0;
*(mypio_nw_write_ptr					) = 0;
*(mypio_ne_write_ptr 				) = 0;
*(mypio_nnw_write_ptr 				) = 0;
*(mypio_nne_write_ptr 				) = 0;
*(mypio_nsw_write_ptr				) = 0;
*(mypio_nse_write_ptr				) = 0;
*(mypio_start_collide_write_ptr 		) = 0;
*(mypio_start_stream_write_ptr 		) = 0;
*(mypio_start_init_write_ptr 		) = 0;
*(mypio_ux_write_ptr 				) = 0;
*(mypio_uy_write_ptr 				) = 0;
*(mypio_start_move_trace_write_ptr	) = 0;
*(mypio_start_speed_color_write_ptr 	) = 0;
*(mypio_write_address_init_write_ptr	) = 0;
*(mypio_init_ship_write_ptr 			) = 0;
*(mypio_start_print_write_ptr 			) = 0;
*(mypio_ship_x_write_ptr)= 0;
*(mypio_ship_y_write_ptr)= 0;
*(mypio_x_fish1_write_ptr) =0;
*(mypio_x_fish2_write_ptr) =0;
*(mypio_y_fish1_write_ptr) =0;
*(mypio_y_fish2_write_ptr) =0;
*(mypio_score_write_ptr)=0;

*(mypio_reset_signal_write_ptr 			) = 0;
//printf("reset = %d \n",*(mypio_reset_signal_write_ptr ));
*(mypio_reset_signal_write_ptr 			) = 1;
//printf("reset = %d \n",*(mypio_reset_signal_write_ptr ));
usleep(1);
*(mypio_reset_signal_write_ptr 			) = 0;
//printf("reset = %d \n",*(mypio_reset_signal_write_ptr ));
	// ===========================================

	/* create a message to be displayed on the VGA 
          and LCD displays */
	char text_top_row[40] = "DE1-SoC ARM/FPGA\0";
	char text_bottom_row[40] = "Cornell ece5760\0";
	char text_next[40] = "Lattice Boltzmann\0";
	char num_string[32], time_string[32] ;
	char color_index = 0 ;
	int color_counter = 0 ;
	

	

//printf("1 \n");
	
	
	// the Lattice-boltzmaann setup
    init_LB();
	//printf("2 \n");
    // initialize to steady rightward flow
    initFluid();		
	//
	//printf("3 \n");
	init_trace();
    // put in a vertical barrier
	// about 1/3 of width
	int x, y ;
	
//printf("4 \n");
	long long int count=0;
	gettimeofday(&t3, NULL);
 int i=0;
	int ww=0;
	while(1) 
	{//printf("5 \n");
	ww=ww+1;
		// start timer
		gettimeofday(&t1, NULL);
	//usleep(1000);
	//printf("6 \n");
		// main simulation loop 
	  simulate(count) ;
	  //printf("7 \n");
	  //printf(" number of collisions = %d",xxx);
	  //
	  move_trace();
	  //VGA_box(351,60,10,280,black);
	  short color;
	  // Fix bit 25 is hig-order fraction bit
	  // 0x02000000
	  // max is 0.2 min is 0.001
	  // 0x00700000 to 0x00010200
	int wait;
     //printf("start print sent1 = %d \n",(*(mypio_start_print_write_ptr)));
	 *(mypio_start_print_write_ptr)=1;
	  //printf("start print sent2 = %d \n",(*(mypio_start_print_write_ptr)));
	  wait=0;
	  while(1)
      {wait = 1;
	  //printf("waiting for finish print sent = %d \n",(*(mypio_print_finish_read_ptr)));
	  if(*(mypio_print_finish_read_ptr)==1)
	  {break;}
	  }
	 // printf("finish print sent 3 = %d \n",(*(mypio_print_finish_read_ptr)));
	*(mypio_start_print_write_ptr)=0;
      // printf("finish print sent 4 = %d \n",(*(mypio_print_finish_read_ptr)));

 *(mypio_ship_x_write_ptr)=  Fix142i(trace_x[i]);
 *(mypio_ship_y_write_ptr)= Fix142i(trace_y[i]);
      
          
		  //printf("trace_x = %d \n",*(mypio_ship_x_write_ptr));
          //printf("trace_y = %d \n",*(mypio_ship_y_write_ptr));

      //printf("color being filled in m10k \n");
	  *(mypio_start_speed_color_write_ptr)=1;
	  
	   wait=0;
	  while(1)
      {wait = 1;
	  if(*(mypio_finish_speed_color_read_ptr)==1)
	  {break;}
	  }
	*(mypio_start_speed_color_write_ptr)=0;
     //printf("color being filled in m10k end \n");
	 
      //printf("start print sent1 = %d \n",(*(mypio_start_print_write_ptr)));
	 *(mypio_start_print_write_ptr)=1;
	  //printf("start print sent2 = %d \n",(*(mypio_start_print_write_ptr)));
	 /*
	  wait=0;
	  while(1)
      {wait = 1;
	  //printf("waiting for finish print sent = %d \n",(*(mypio_print_finish_read_ptr)));
	  if(*(mypio_print_finish_read_ptr)==1)
	  {break;}
	  }
		*/


	 // printf("finish print sent 3 = %d \n",(*(mypio_print_finish_read_ptr)));
	*(mypio_start_print_write_ptr)=0;



		int x_ship = 130+Fix142i(trace_x[i]);
		int y_ship = 100+Fix142i(trace_y[i]);
		int x_fish1 = 130 + Fix142i(fish1x);
		int y_fish1 = 100 + Fix142i(fish1y);
		int x_fish2 = 130 + Fix142i(fish2x);
		int y_fish2 = 100 + Fix142i(fish2y);
		//printf("ship coordinates = x = %d, y =%d \n",x_ship,y_ship);
	  // printf("fish1 cordinates = x = %d, y =%d \n",x_fish1,y_fish1);

       if(((x_fish1<(x_ship+20)) && (x_fish1 >= x_ship)) && (((y_ship-20)<=y_fish1) && (y_fish1<y_ship+20))){
		fish++;
		draw_fish1();

	   }

 if(((x_fish2<(x_ship+20)) && (x_fish2 >= x_ship)) && (((y_ship-20)<=y_fish2) && (y_fish2<y_ship+20))){
		fish++;
		draw_fish2();

	   }

  //printf("fish1_x = %d \n",x_fish1);
          //printf("fish1_y = %d \n",y_fish1);

  //printf("fish2_x = %d \n",x_fish2);
         // printf("fish2_y = %d \n",y_fish2);

  *(mypio_x_fish1_write_ptr) =x_fish1 ; 
*(mypio_x_fish2_write_ptr) =x_fish2 ;
*(mypio_y_fish1_write_ptr) =y_fish1  ;
*(mypio_y_fish2_write_ptr) =y_fish2 ;

*(mypio_score_write_ptr)=fish;
       //printf("finish print sent 4 = %d \n",(*(mypio_print_finish_read_ptr)));
		gettimeofday(&t4, NULL);
		// stop timer
		gettimeofday(&t2, NULL);
		//elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000.0;      // sec to ms
		elapsedTime += (t2.tv_usec - t1.tv_usec) ;   // us 
		
		//sprintf(time_string, "T in min = %d mins  ", count);
		count=count+1;
		
		//usleep(17000);
		
	} // end while(1)
} // end main

