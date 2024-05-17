///////////////////////////////////////
/// 640x480 version! 16-bit color
/// This code will segfault the original
/// DE1 computer
/// compile with
/// gcc graphics_video_16bit.c -o gr -O2 -lm
///
///////////////////////////////////////
#define _GNU_SOURCE 
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
#include <pthread.h>
#include <semaphore.h>
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

#define MYPIO_N0_FROM_FPGA    0x000030D0
#define MYPIO_NN_FROM_FPGA    0x000030E0
#define MYPIO_NS_FROM_FPGA    0x000030F0
#define MYPIO_NW_FROM_FPGA    0x00003100
#define MYPIO_NE_FROM_FPGA    0x00003110
#define MYPIO_NNW_FROM_FPGA   0x00003120
#define MYPIO_NNE_FROM_FPGA   0x00003130
#define MYPIO_NSW_FROM_FPGA   0x00003140
#define MYPIO_NSE_FROM_FPGA   0x00003150

#define MYPIO_ONE9TH_FROM_HPS  0x00003160
#define MYPIO_ONE36TH_FROM_HPS 0x00003170
#define MYPIO_OMEGA_FROM_HPS   0x00003180
#define MYPIO_UX_FROM_FPGA     0x00003190
#define MYPIO_UY_FROM_FPGA     0x000031A0
#define MYPIO_PIPES            0x000031C0

/*
#define MYPIO_N0_FROM_HPS     0x04002000
#define MYPIO_NN_FROM_HPS     0x04002010
#define MYPIO_NS_FROM_HPS     0x04002020
#define MYPIO_NW_FROM_HPS     0x04002030
#define MYPIO_NE_FROM_HPS     0x04002040
#define MYPIO_NNW_FROM_HPS    0x04002050
#define MYPIO_NNE_FROM_HPS    0x04002060
#define MYPIO_NSW_FROM_HPS    0x04002070
#define MYPIO_NSE_FROM_HPS    0x04002080
									
#define MYPIO_N0_FROM_FPGA    0x04002090
#define MYPIO_NN_FROM_FPGA    0x040020A0
#define MYPIO_NS_FROM_FPGA    0x040020B0
#define MYPIO_NW_FROM_FPGA    0x040020C0
#define MYPIO_NE_FROM_FPGA    0x040020D0
#define MYPIO_NNW_FROM_FPGA   0x040020E0
#define MYPIO_NNE_FROM_FPGA   0x040020F0
#define MYPIO_NSW_FROM_FPGA   0x04002100
#define MYPIO_NSE_FROM_FPGA   0x04002110

#define MYPIO_ONE9TH_FROM_HPS  0x04002120
#define MYPIO_ONE36TH_FROM_HPS 0x04002130
#define MYPIO_OMEGA_FROM_HPS   0x04002140
#define MYPIO_UX_FROM_FPGA     0x04002150
#define MYPIO_UY_FROM_FPGA     0x04002160
*/


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
volatile unsigned int *mypio_one9th_write_ptr = NULL;
volatile unsigned int *mypio_one36th_write_ptr = NULL;
volatile unsigned int *mypio_omega_write_ptr = NULL;

volatile unsigned int *mypio_n0_read_ptr = NULL;
volatile unsigned int *mypio_nn_read_ptr = NULL;
volatile unsigned int *mypio_ns_read_ptr = NULL;
volatile unsigned int *mypio_nw_read_ptr = NULL;
volatile unsigned int *mypio_ne_read_ptr = NULL;
volatile unsigned int *mypio_nnw_read_ptr = NULL;
volatile unsigned int *mypio_nne_read_ptr = NULL;
volatile unsigned int *mypio_nsw_read_ptr = NULL;
volatile unsigned int *mypio_nse_read_ptr = NULL;
volatile unsigned int *mypio_ux_read_ptr = NULL;
volatile unsigned int *mypio_uy_read_ptr = NULL;
volatile unsigned int *mypio_pipes_read_ptr = NULL;

int fish=0;
// pixel buffer
volatile unsigned int * vga_pixel_ptr = NULL ;
void *vga_pixel_virtual_base;

// character buffer
volatile unsigned int * vga_char_ptr = NULL ;
void *vga_char_virtual_base;

// /dev/mem file id
int fd;


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
	#define xdim  300			// grid dimensions for simulation 250x100
	#define ydim 150 
	
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
	//
	int barrierCount = 0;
	int barrierxSum = 0;
	int barrierySum = 0;
	float barrierFx = 0.0;						// total force on all barrier sites
	float barrierFy = 0.0;
	//int time = 0;								// time (in simulation step units) since data collection started
	char showingPeriod = false;
	
	// Create the arrays of fluid particle densities, etc. (using 1D arrays for speed):
	// To index into these arrays, use x + y*xdim, traversing rows first and then columns.
	Fix n0 [xdim*ydim];			// microscopic densities along each lattice direction
	Fix nN [xdim*ydim];
	Fix nS [xdim*ydim];
	Fix nE [xdim*ydim];
	Fix nW [xdim*ydim];
	Fix nNE [xdim*ydim];
	Fix nSE [xdim*ydim];
	Fix nNW [xdim*ydim];
	Fix nSW [xdim*ydim];
	Fix rho [xdim*ydim];			// macroscopic density
	Fix ux  [xdim*ydim];			// macroscopic x-velocity
	Fix uy  [xdim*ydim];          // macroscopic y-velocity
	//float curl  [xdim*ydim];
	char barrier  [xdim*ydim];		// boolean array of barrier locations

  //#define nColors 16;

  // Initialize tracers (but don't place them yet):
  #define n_trace  1
  Fix14 halffix14 = f2Fix14(0.5) ;
  #define tracer_enable 1
  Fix14 trace_x [n_trace];
  Fix14 trace_y [n_trace];
  Fix14 fish1x,fish1y,fish2x,fish2y;
  // unstable above 0.10 or so
  Fix fluid_speed = f2Fix(0.08) ;
  // 30 bit is unstable at viscosity 0.002 and speed 0.10
  //Fix fluid_viscosity = f2Fix(0.003) ;
  Fix fluid_viscosity = f2Fix(0.03) ;
  #define stepsPerFrame 1

// =========================================
// LB init function
// =========================================




void init_LB(void){
	// Initialize to a steady rightward flow with no barriers:
	int x, y ;
	for ( y=0; y<ydim; y++) {
		for ( x=0; x<xdim; x++) {
			barrier[x+y*xdim] = false;
		}
	}
  	//for (int t=0; t<nTracers; t++) {
	//	tracerX[t] = 0; tracerY[t] = 0;
	//}
} // end init_LB

void init_trace(void){
	int i;
	for( i=0; i<n_trace; i++){
		trace_x[i] = i2Fix14(4 + (rand() % (xdim-6))) ; //i2Fix14(4 + 20*i/ydim) ;
		trace_y[i] =  i2Fix14(4 + (rand() % (ydim-6))) ; //4 + i2Fix14(i % (ydim-6)) ;
	}
  
   
draw_fish1();
draw_fish2();
	


}



void draw_fish1( void ){
fish1x = i2Fix14(8 + (rand() % (xdim-7))) ;
    fish1y = i2Fix14(8 + (rand() % (ydim-7))) ;

}

void draw_fish2(void ){
fish2x = i2Fix14(8 + (rand() % (xdim-7))) ;
    fish2y = i2Fix14(9 + (rand() % (ydim-9))) ;

}

void move_trace(void){
	int i, index;
	for(i=0; i<n_trace; i++){
		int index = Fix142i(trace_x[i]+halffix14) + xdim*Fix142i(trace_y[i]+halffix14) ;
		trace_x[i] += ux[index]>>7 ;
		//if(Fix2i(trace_x[i])<1) 
		trace_y[i] += uy[index]>>7 ;
		if( (Fix142i(trace_x[i])>xdim-2)) {
			trace_x[i] = 4  ;
			//trace_y[i] = 4 + i2Fix14(i % (ydim-6)) ;  ;
			//trace_y[i] = i2Fix14(4 ) ;
		}
		//if(Fix2i(trace_y[i])<2 || Fix2i(trace_y[i])>ydim-2) trace_y[i] = i2Fix14(4 + ((ydim-30))) ;
	}	
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
	nE[i]  = mFix(one9th_newrho,  (onefix + ux3       + m4_5(ux2)      - u215)) ;
	nW[i]  = mFix( one9th_newrho, (onefix - ux3       + m4_5(ux2)      - u215)) ;
	nN[i]  = mFix( one9th_newrho, (onefix + uy3       + m4_5(uy2)      - u215)) ;
	nS[i]  = mFix( one9th_newrho, (onefix - uy3       + m4_5(uy2)      - u215)) ;
	nNE[i] = mFix(one36th_newrho, (onefix + ux3 + uy3 + m4_5(u2+uxuy2) - u215)) ;
	nSE[i] = mFix(one36th_newrho, (onefix + ux3 - uy3 + m4_5(u2-uxuy2) - u215)) ;
	nNW[i] = mFix(one36th_newrho, (onefix - ux3 + uy3 + m4_5(u2-uxuy2) - u215)) ;
	nSW[i] = mFix(one36th_newrho, (onefix - ux3 - uy3 + m4_5(u2+uxuy2) - u215)) ;
    n0[i] = newrho - (nE[i]+nW[i]+nN[i]+nS[i]+nNE[i]+nSE[i]+nNW[i]+nSW[i]) ;
	rho[i] = newrho;
	ux[i] = newux;
	uy[i] = newuy;
}

// Function to initialize or re-initialize the fluid, based on speed slider setting:
void initFluid() {
	// Amazingly, if I nest the y loop inside the x loop, Firefox slows down by a factor of 20
	Fix u0 = fluid_speed;
	int x, y ;
	for ( y=0; y<ydim; y++) {
		for ( x=0; x<xdim; x++) {
			setEquil(x, y, 0, 0, onefix);
            //setEquil(x, y, u0, 0, 1);
			//curl[x+y*xdim] = 0.0;
		}
	}
//paintCanvas();
} // end initFluid

// Set the fluid floatiables at the boundaries, according to the current slider value:
void setBoundaries() {
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
		else if(y>100 && y<135){setEquil(0, y, u0, 0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);}
		else {if(y<=30){setEquil(0, y, 0, u0>>1, onefix);}
		else{setEquil(0, y, 0, -(u0>>1), onefix);
		}
		
		setEquil(xdim-1, y, u0, 0, onefix);
		}
	}
} // end setBoundaries()
// Set the fluid floatiables at the boundaries, according to the current slider value:
void setBoundaries2() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		setEquil(x, 0, u0, 0, onefix);
		setEquil(x, ydim-1, u0, 0, onefix);
		
	}
	for ( y=1; y<ydim-1; y++) {
		if(y>100 && y<150){
		setEquil(0, y, u0, 0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);}
		else if(y>250 && y<300){setEquil(0, y, 0, 0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);}
		else {
		setEquil(0, y, 0, 0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);
		}
	}
} // end setBoundaries()

// Set the fluid floatiables at the boundaries, according to the current slider value:
void setBoundaries3() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if(x>60 && x<95){
		setEquil(x, 0, 0, u0, onefix);
		setEquil(x, ydim-1, u0, 0, onefix);}
		else{setEquil(x, 0, u0>>1, 0, onefix);
		setEquil(x, ydim-1, u0, 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		if(y>30 && y<65){
		setEquil(0, y, u0, 0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);}
		else if(y>100 && y<135){setEquil(0, y, 0, -u0, onefix);
		setEquil(xdim-1, y, u0, 0, onefix);}
		else {
		if(y<=30){setEquil(0, y, 0, u0>>1, onefix);}
		else{setEquil(0, y, 0, -(u0>>1), onefix);}
		setEquil(xdim-1, y, u0, 0, onefix);
		}
	}
} // end setBoundaries()




void pipe1() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>40 && x<70)){
		setEquil(x, 0, 0, u0, onefix);
		setEquil(x, ydim-1, -u0, 0, onefix);}
		else{
			if(x<=60){setEquil(x, 0, u0>>1, 0, onefix);}
			else{setEquil(x, 0, -(u0>>1), 0, onefix);}
			
		setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, -(u0>>1), onefix);
		setEquil(xdim-1, y, 0, -(u0>>1), onefix);
		}
	
} // end setBoundaries()

void pipe22() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>130 && x<160)){
		setEquil(x, 0, 0, u0, onefix);
		setEquil(x, ydim-1, -u0, 0, onefix);}
		else{
			if(x<=130){setEquil(x, 0, u0>>1, 0, onefix);}
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
		if((x>210 && x<240)){
		setEquil(x, 0, 0, u0, onefix);
		setEquil(x, ydim-1, -u0, 0, onefix);}
		else{
			if(x<=210){setEquil(x, 0, u0>>1, 0, onefix);}
			else{setEquil(x, 0, -(u0>>1), 0, onefix);}
			
		setEquil(x, ydim-1, -u0>>1, 0, onefix);}
		
	}
	for ( y=1; y<ydim-1; y++) {
		
		setEquil(0, y, 0, -(u0>>1), onefix);
		setEquil(xdim-1, y, 0, -(u0>>1), onefix);
		}
	
} // end setBoundaries()





void pipe33() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		
		setEquil(x, 0, u0>>1, 0, onefix);
		setEquil(x, ydim-1, u0>>1, 0, onefix);}
		
	
	for ( y=1; y<ydim-1; y++) {
		if(y>30 && y<51){setEquil(0, y, 0,u0>>1, onefix);
		setEquil(xdim-1, y, -u0, 0, onefix);}
		else{
		setEquil(0, y, 0, (u0>>1), onefix);
		if(y<=30){
		setEquil(xdim-1, y, 0, (u0>>1), onefix);}
		else{setEquil(xdim-1, y, 0, -(u0>>1), onefix);}
		}
		}
	
} // end setBoundaries()

void pipe4() {
	int x, y ;
	Fix u0 = fluid_speed;
	for ( x=0; x<xdim; x++) {
		if((x>210 && x<240)){
		setEquil(x, 0, -u0, 0, onefix);
		setEquil(x, ydim-1, 0, -u0, onefix);}
		else{
			if(x<=210){setEquil(x, ydim-1, u0>>1, 0, onefix);}
			else{setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
			
		setEquil(x, 0, -u0>>1, 0, onefix);}
		
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
		if((x>130 && x<160)){
		setEquil(x, 0, u0, 0, onefix);
		setEquil(x, ydim-1, 0, -u0, onefix);}
		else{
			if(x<=130){setEquil(x, ydim-1, u0>>1, 0, onefix);}
			else{setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
			
		setEquil(x, 0, -u0>>1, 0, onefix);}
		
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
		if((x>40 && x<70)){
		setEquil(x, 0, u0, 0, onefix);
		setEquil(x, ydim-1, 0, -u0, onefix);}
		else{
			if(x<=40){setEquil(x, ydim-1, u0>>1, 0, onefix);}
			else{setEquil(x, ydim-1, -(u0>>1), 0, onefix);}
			
		setEquil(x, 0, -u0>>1, 0, onefix);}
		
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
		if(y>40 && y<60){setEquil(xdim-1, y, 0,u0>>1, onefix);
		setEquil(0, y, u0, 0, onefix);}
		else{
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		if(y<=40){
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
		if(y>90 && y<110){setEquil(xdim-1, y, 0,u0>>1, onefix);
		setEquil(0, y, u0, 0, onefix);}
		else{
		setEquil(xdim-1, y, 0, (u0>>1), onefix);
		if(y<=90){
		setEquil(0, y, 0, (u0>>1), onefix);}
		else{setEquil(0, y, 0, -(u0>>1), onefix);}
		}
		}
	
} // end setBoundaries()

// Collide particles within each cell (here's the physics!):
void collide(void) {
	 
	int x, y ;
	Fix rho_inv ;
	for ( y=1; y<ydim-1; y++) {
		for ( x=1; x<xdim-1; x++) {
			int i = x + y*xdim;		// array index for this lattice site
           
              
		   
			       *(mypio_n0_write_ptr	) 	= n0[i];
        *(mypio_nn_write_ptr 	)	= nN[i];
        *(mypio_ns_write_ptr 	)   = nS[i];
        *(mypio_nw_write_ptr	)   = nW[i];
        *(mypio_ne_write_ptr 	)	= nE[i];
        *(mypio_nnw_write_ptr	)   =nNW[i];
        *(mypio_nne_write_ptr   )  = nNE[i];
        *(mypio_nsw_write_ptr   )  = nSW[i];
        *(mypio_nse_write_ptr   )  = nSE[i];
		
			//usleep(100);
		         	 n0[i] =  *(mypio_n0_read_ptr	)   ;
        	 nN[i] =  *(mypio_nn_read_ptr 	)   ;
            nS[i]  =  *(mypio_ns_read_ptr 	)   ;
            nW[i]  =  *(mypio_nw_read_ptr	)   ;
        	nE[i] =  *(mypio_ne_read_ptr 	)   ;
           nNW[i]  = *(mypio_nnw_read_ptr	)   ;
          nNE[i]  = *(mypio_nne_read_ptr   )  ;
          nSW[i]  = *(mypio_nsw_read_ptr   )  ;
           nSE[i]  = *(mypio_nse_read_ptr   )  ;
		   ux[i]=    *(mypio_ux_read_ptr   )  ;
			uy[i]=  *(mypio_uy_read_ptr   )  ;
			

        /*
		     printf("**************values of prob densities*********** \n");
			printf(" input n0 = %d \n",n0[i]);
			printf("  input nN = %d \n",nN[i]);
			printf(" input  nS = %d \n",nS[i]);
			printf("  input nW = %d \n",nW[i]);
			printf("  input nE = %d \n",nE[i]);
			printf("  input nNW = %d \n",nNW[i]);
			printf("  input nNE = %d \n",nNE[i]);
			printf("  input nSW = %d \n",nSW[i]);
			printf("  input nSE = %d \n",nSE[i]);


			*/
			/*
			
			Fix thisrho = n0[i] + nN[i] + nS[i] + nE[i] + nW[i] + nNW[i] + nNE[i] + nSW[i] + nSE[i];
			//rho[i] = thisrho;
			// taylor expand to avoid divide rho is fairly near one
			rho_inv = onefix - (thisrho - onefix) + mFix((thisrho-onefix), (thisrho-onefix)) ;
			//
			Fix thisux = mFix((nE[i] + nNE[i] + nSE[i] - nW[i] - nNW[i] - nSW[i]), rho_inv);
			ux[i] = thisux;
			Fix thisuy = mFix((nN[i] + nNE[i] + nNW[i] - nS[i] - nSE[i] - nSW[i]), rho_inv);
			uy[i] = thisuy ;
			Fix one9thrho = mFix(one9th, thisrho);		// pre-compute a bunch of stuff for optimization
			Fix one36thrho = mFix(one36th, thisrho);
			Fix ux3 = m3(thisux);
			Fix uy3 = m3(thisuy);
			Fix ux2 = mFix(thisux, thisux);
			Fix uy2 = mFix(thisuy, thisuy);
			Fix uxuy2 = mFix(thisux, thisuy)<<1;
			Fix u2 = ux2 + uy2;
			Fix u215 = m1_5(u2);
            
			//n0[i]  += omega * (four9ths*thisrho * (1                        - u215) - n0[i]);
			nE[i]  += mFix(omega, ( mFix(one9thrho, (onefix + ux3    + m4_5(ux2)      - u215)) - nE[i]));
			nW[i]  += mFix(omega, ( mFix(one9thrho, (onefix - ux3    + m4_5(ux2)      - u215)) - nW[i]));
			nN[i]  += mFix(omega, ( mFix(one9thrho, (onefix + uy3    + m4_5(uy2)      - u215)) - nN[i]));
			nS[i]  += mFix(omega, ( mFix(one9thrho, (onefix - uy3    + m4_5(uy2)      - u215)) - nS[i]));
			nNE[i] += mFix(omega, ( mFix(one36thrho, (onefix + ux3 + uy3 + m4_5(u2+uxuy2) - u215)) - nNE[i]));
			nSE[i] += mFix(omega, ( mFix(one36thrho, (onefix + ux3 - uy3 + m4_5(u2-uxuy2) - u215)) - nSE[i]));
			nNW[i] += mFix(omega, ( mFix(one36thrho, (onefix - ux3 + uy3 + m4_5(u2-uxuy2) - u215)) - nNW[i]));
			nSW[i] += mFix(omega, ( mFix(one36thrho, (onefix - ux3 - uy3 + m4_5(u2+uxuy2) - u215)) - nSW[i]));
			// force conservation of mass for limited precision aithmetic
			n0[i]   = thisrho - (nE[i]+nW[i]+nN[i]+nS[i]+nNE[i]+nSE[i]+nNW[i]+nSW[i]);
				  */
            
			/*
			n0[i] =  *(mypio_n0_read_ptr)   ;
        	 nN[i] =  *(mypio_nn_read_ptr)   ;
            nS[i]  =  *(mypio_ns_read_ptr )   ;
            nW[i]  =  *(mypio_nw_read_ptr)   ;
        	nE[i] =  *(mypio_ne_read_ptr )   ;
           nNW[i]  = *(mypio_nnw_read_ptr)   ;
          nNE[i]  = *(mypio_nne_read_ptr )  ;
          nSW[i]  = *(mypio_nsw_read_ptr )  ;
           nSE[i]  = *(mypio_nse_read_ptr )  ;
		   //ux[i]= *(mypio_ux_read_ptr )  ;
			//uy[i]= *(mypio_uy_read_ptr )  ;
           */
				
			/*

           printf(" output n0 = %d \n",n0[i]);
			printf("  outut nN = %d \n",nN[i]);
			printf(" output  nS = %d \n",nS[i]);
			printf("  output nW = %d \n",nW[i]);
			printf("  output nE = %d \n",nE[i]);
			printf("  output nNW = %d \n",nNW[i]);
			printf("  ioutut nNE = %d \n",nNE[i]);
			printf("  output nSW = %d \n",nSW[i]);
			printf("  output nSE = %d \n",nSE[i]);
			printf(" Omega = %d \n",omega);
			printf(" ux = %d \n",ux[i]);
			printf(" uy = %d \n",uy[i]);
			printf(" one9th = %d \n",one9th);
			printf(" one36th = %d \n",one36th);
			printf(" output n0 from fpga = %d \n",(*(mypio_n0_read_ptr	)));
			printf("  outut nN from fpga= %d \n",( *(mypio_nn_read_ptr 	)));
			printf(" output nS from fpga = %d \n",(*(mypio_ns_read_ptr	)));
			printf("  outut nE from fpga= %d \n",( *(mypio_ne_read_ptr 	)));
			printf(" output nW from fpga = %d \n",(*(mypio_nw_read_ptr	)));
			printf("  outut nNW from fpga= %d \n",( *(mypio_nnw_read_ptr 	)));
			printf(" output nNE from fpga = %d \n",(*(mypio_nne_read_ptr	)));
			printf("  outut nSW from fpga= %d \n",( *(mypio_nsw_read_ptr 	)));
			printf(" output nSE from fpga = %d \n",(*(mypio_nse_read_ptr	)));
			
			printf(" ux from fpga = %d \n",(*(mypio_ux_read_ptr   )));
			printf(" uy from fpga = %d \n",(*(mypio_uy_read_ptr   )));
				*/			

		}
	}
	for ( y=1; y<ydim-2; y++) {
		nW[xdim-1+y*xdim] = nW[xdim-2+y*xdim];		// at right end, copy left-flowing densities from next row to the left
		nNW[xdim-1+y*xdim] = nNW[xdim-2+y*xdim];
		nSW[xdim-1+y*xdim] = nSW[xdim-2+y*xdim];
	}
} // end collide

// Move particles along their directions of motion:
void stream(void) {
	barrierCount = 0; barrierxSum = 0; barrierySum = 0;
	barrierFx = 0.0; barrierFy = 0.0;
	int x, y ;
	for ( y=ydim-2; y>0; y--) {			// first start in NW corner...
		for ( x=1; x<xdim-1; x++) {
			nN[x+y*xdim] = nN[x+(y-1)*xdim];			// move the north-moving particles
			nNW[x+y*xdim] = nNW[x+1+(y-1)*xdim];		// and the northwest-moving particles
		}
	}
	for ( y=ydim-2; y>0; y--) {			// now start in NE corner...
		for ( x=xdim-2; x>0; x--) {
			nE[x+y*xdim] = nE[x-1+y*xdim];			// move the east-moving particles
			nNE[x+y*xdim] = nNE[x-1+(y-1)*xdim];		// and the northeast-moving particles
		}
	}
	for ( y=1; y<ydim-1; y++) {			// now start in SE corner...
		for ( x=xdim-2; x>0; x--) {
			nS[x+y*xdim] = nS[x+(y+1)*xdim];			// move the south-moving particles
			nSE[x+y*xdim] = nSE[x-1+(y+1)*xdim];		// and the southeast-moving particles
		}
	}
	for ( y=1; y<ydim-1; y++) {				// now start in the SW corner...
		for ( x=1; x<xdim-1; x++) {
			nW[x+y*xdim] = nW[x+1+y*xdim];			// move the west-moving particles
			nSW[x+y*xdim] = nSW[x+1+(y+1)*xdim];		// and the southwest-moving particles
		}
	}
	for ( y=1; y<ydim-1; y++) {				// Now handle bounce-back from barriers
		for ( x=1; x<xdim-1; x++) {
			if (barrier[x+y*xdim]) {
				int index = x + y*xdim;
				nE[x+1+y*xdim] = nW[index];
				nW[x-1+y*xdim] = nE[index];
				nN[x+(y+1)*xdim] = nS[index];
				nS[x+(y-1)*xdim] = nN[index];
				nNE[x+1+(y+1)*xdim] = nSW[index];
				nNW[x-1+(y+1)*xdim] = nSE[index];
				nSE[x+1+(y-1)*xdim] = nNW[index];
				nSW[x-1+(y-1)*xdim] = nNE[index];
				// Keep track of stuff needed to plot force vector:
				//barrierCount++;
				//barrierxSum += x;
				//barrierySum += y;
				//barrierFx += nE[index] + nNE[index] + nSE[index] - nW[index] - nNW[index] - nSW[index];
				//barrierFy += nN[index] + nNE[index] + nNW[index] - nS[index] - nSE[index] - nSW[index];
			}
		}
	}
} // end stream


// Simulate function executes a bunch of steps and then schedules another call to itself:
void simulate(int countt) {
	// 
	
     // printf(" SW = %d",(*( mypio_pipes_read_ptr)));

		if(*( mypio_pipes_read_ptr)==2){pipe1();}
		else if(*( mypio_pipes_read_ptr)==4){pipe22();}
		else if(*( mypio_pipes_read_ptr)==8){pipe3();}
		else if(*( mypio_pipes_read_ptr)==16){pipe4();}
		else if(*( mypio_pipes_read_ptr)==32){pipe5();}
		else if(*( mypio_pipes_read_ptr)==64){pipe6();}
		else if(*( mypio_pipes_read_ptr)==128){pipe7();}
		else if(*( mypio_pipes_read_ptr)==256){pipe8();}

/*
	 if(countt>200 && countt<400 ){pipe2();}
	 else if(countt>=400 && countt<600){pipe3();}
	 else if(countt>=600 && countt<800){pipe4();}
	 else if(countt>=800 && countt<1000){pipe5();}
	 else if(countt>=1000){pipe6();}
	else {pipe1();	}
	*/
	int step ;
	// Execute a bunch of time steps:
	for ( step=0; step<stepsPerFrame; step++) {
		collide();
		stream();
		//moveTracers();
		//lastBarrierFy = barrierFy;
	}
	//paintCanvas();

	if (running) {
		stepCount += stepsPerFrame;
	}
	//char stable = true;
	//for (int x=0; x<xdim; x++) {
	//	int index = x + (ydim/2)*xdim;	// look at middle row only
	//	if (rho[index] <= 0) stable = false;
	//}//
	//if (!stable) {
		//window.alert("The simulation has become unstable due to excessive fluid speeds.");
	//	startStop();
	//	initFluid();
	//}	
}

	/*
	
*/
// measure time
struct timeval t1, t2,t3,t4;
double elapsedTime=0;
	
void * second_half(){


char text_top_row[40] = "DE1-SoC ARM/FPGA\0";
	char text_bottom_row[40] = "Cornell ece5760\0";
	char text_next[40] = "Lattice Boltzmann\0";
	char num_string[32], time_string[32] ;
	char color_index = 0 ;
	int color_counter = 0 ;
	


	//VGA_box(int x1, int y1, int x2, int y2, short pixel_color)
	VGA_box(0, 0, 640, 480, black); // clear screen
	VGA_box(64, 0, 240, 50, blue); // blue box
	
	// the Lattice-boltzmaann setup
    init_LB();
    // initialize to steady rightward flow
    initFluid();		
	//
	init_trace();
    // put in a vertical barrier
	// about 1/3 of width
	int x, y ;
	for ( y=ydim/2-15; y<ydim/2+15; y++) {
		//addBarrier(40, y) ;
	}

short color;
Fix speedmax = 0, speedmin = f2Fix(1.5);
long long int count=0;

	gettimeofday(&t3, NULL);
	while(1) 
	{//printf(" SW = %d",(*( mypio_pipes_read_ptr)));
		// start timer
		gettimeofday(&t1, NULL);
	
		// main simulation loop 

	  simulate(count) ;
	  //

	  move_trace();
	  usleep(10);
	  //VGA_box(351,60,10,280,black);
	 
	  // Fix bit 25 is hig-order fraction bit
	  // 0x02000000
	  // max is 0.2 min is 0.001
	  // 0x00700000 to 0x00010200
	  
	  int i;
	  for ( x=0; x<xdim; x++) {
			for ( y=0; y<ydim; y++) {
				 i = x+y*xdim ;
				//printf(" SW = %d",(*( mypio_pipes_read_ptr)));
				//short speed = 50*sqrt(ux[x+y*xdim]*ux[x+y*xdim]+uy[x+y*xdim]*uy[x+y*xdim]);
				Fix speed = (max(abs(ux[i]), abs(uy[i])) + (min(abs(ux[i]), abs(uy[i])) >>1)) ;//17
				if(speed>speedmax) speedmax = speed ;
				if(speed<speedmin) speedmin = speed ;
				// color = B+(G<<5)+(R<<11);
				color = (((speed>>17) & 0x3f)<<5) ;//+ (((speed>>11) & 0x3)<<13) ; //  17
				// add some red to the full green
				//color =  color + (((speed>>18)& 0x1f )<<11) ; //(0x3f<<5)
				//if(speed > 0x00010000) color = red ;
				//else if(speed > 0x00400000) color = yellow ;
				//else if(speed > 0x00200000) color = green ;
				
				//color = speed & 0xfff8 ;
				VGA_PIXEL(x+130, y+100, color) ;
				
			}
		}
		
		
       for(i=0; i<n_trace; i++){
			VGA_ship(130+Fix142i(trace_x[i]), 100+Fix142i(trace_y[i]),10+130+Fix142i(trace_x[i]),3+100+Fix142i(trace_y[i]),  white) ;
		}
		 i=0;
		int x_ship = 130+Fix142i(trace_x[i]);
		int y_ship = 100+Fix142i(trace_y[i]);
		int x_fish1 = 130 + Fix142i(fish1x);
		int y_fish1 = 100 + Fix142i(fish1y);
		int x_fish2 = 130 + Fix142i(fish2x);
		int y_fish2 = 100 + Fix142i(fish2y);
		//printf("ship coordinates = x = %d, y =%d \n",x_ship,y_ship);
	  // printf("fish1 cordinates = x = %d, y =%d \n",x_fish1,y_fish1);

       if(((x_fish1<(x_ship+17)) && (x_fish1 >= x_ship)) && (((y_ship-10)<=y_fish1) && (y_fish1<y_ship+10))){
		fish++;
		draw_fish1();

	   }

 if(((x_fish2<(x_ship+17)) && (x_fish2 >= x_ship)) && (((y_ship-10)<=y_fish2) && (y_fish2<y_ship+10))){
		fish++;
		draw_fish2();

	   }


	  VGA_box(120, 84, 440, 99, black); // clear screen
      VGA_box(430, 100, 440, 260, black); // clear screen
      VGA_box(120, 250, 440, 255, black); // clear screen

	   VGA_disc(130 + Fix142i(fish2x),100 + Fix142i(fish2y),2,yellow);
	   VGA_disc(130 + Fix142i(fish1x),100 + Fix142i(fish1y),2,yellow);
		
		gettimeofday(&t4, NULL);
		// stop timer
		gettimeofday(&t2, NULL);
		//elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000.0;      // sec to ms
		elapsedTime += (t3.tv_sec - t1.tv_sec)>>7 ;   // us 
		sprintf(time_string, "number of fishes caught= %d  ", fish);
		//sprintf(time_string, "T in minutes = %d mins  ", elapsedTime/60);
		count=count+1;
		VGA_text (10, 5, time_string);
		// set frame rate
		//sprintf(time_string, "max=%5.3f  min=%5.4f  ", Fix2f(speedmax), Fix2f(speedmin));
		sprintf(time_string, "T = %6.0f uSec  ", elapsedTime);
		VGA_text (5, 2, time_string);
		//sprintf(time_string, "max=%0x  min=%0x  ", (speedmax), (speedmin));
		//VGA_text (5, 3, time_string);
		//usleep(17000);
		
	} // end while(1)
}

void * first_half(){
	int i;
	
	while(1){
	
	}}


/*
	// Compute the curl (actually times 2) of the macroscopic velocity field, for plotting:
	function computeCurl() {
		for (float y=1; y<ydim-1; y++) {			// interior sites only; leave edges set to zero
			for (float x=1; x<xdim-1; x++) {
				curl[x+y*xdim] = uy[x+1+y*xdim] - uy[x-1+y*xdim] - ux[x+(y+1)*xdim] + ux[x+(y-1)*xdim];
			}
		}
	}

	*/

	// Add a barrier at a given grid coordinate location:
	void addBarrier(int x, int y) {
		if ((x > 1) && (x < xdim-2) && (y > 1) && (y < ydim-2)) {
			barrier[x+y*xdim] = true;
		}
	}

	// Remove a barrier at a given grid coordinate location:
	void removeBarrier(int x, int y) {
		if (barrier[x+y*xdim]) {
			barrier[x+y*xdim] = false;
			//paintCanvas();
		}
	}

	// Clear all barriers:
	void clearBarriers(void) {
		int x, y ;
		for ( x=0; x<xdim; x++) {
			for ( y=0; y<ydim; y++) {
				barrier[x+y*xdim] = false;
			}
		}
		//paintCanvas();
	}

// end of LB	
	

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
    
 
// get virtual addr that maps to physical
	h2p_axi_virtual_base = mmap( NULL, AXI_MASTER_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, AXI_MASTER_BASE );	
	if( h2p_axi_virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap1() failed...\n" );
		close( fd );
		return(1);
	}
    

	// === get VGA char addr =====================
	// get virtual addr that maps to physical
	vga_char_virtual_base = mmap( NULL, FPGA_CHAR_SPAN, ( 	PROT_READ | PROT_WRITE ), MAP_SHARED, fd, FPGA_CHAR_BASE );	
	if( vga_char_virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap2() failed...\n" );
		close( fd );
		return(1);
	}
    
    // Get the address that maps to the FPGA LED control 
	vga_char_ptr =(unsigned int *)(vga_char_virtual_base);

	// === get VGA pixel addr ====================
	// get virtual addr that maps to physical
	vga_pixel_virtual_base = mmap( NULL, SDRAM_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, SDRAM_BASE);	
	if( vga_pixel_virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap3() failed...\n" );
		close( fd );
		return(1);
	}
    
    // Get the address that maps to the FPGA pixel buffer
	vga_pixel_ptr =(unsigned int *)(vga_pixel_virtual_base);

		

        mypio_n0_write_ptr	 	= (unsigned int *)(h2p_lw_virtual_base + MYPIO_N0_FROM_HPS  );
        mypio_nn_write_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NN_FROM_HPS  );
        mypio_ns_write_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NS_FROM_HPS  );
        mypio_nw_write_ptr	    = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NW_FROM_HPS  );
        mypio_ne_write_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NE_FROM_HPS  );
        mypio_nnw_write_ptr	    = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NNW_FROM_HPS  );
        mypio_nne_write_ptr     = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NNE_FROM_HPS  );
        mypio_nsw_write_ptr     = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NSW_FROM_HPS  );
        mypio_nse_write_ptr     = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NSE_FROM_HPS  );
        mypio_one9th_write_ptr  = (unsigned int *)(h2p_lw_virtual_base + MYPIO_ONE9TH_FROM_HPS  );
        mypio_one36th_write_ptr = (unsigned int *)(h2p_lw_virtual_base + MYPIO_ONE36TH_FROM_HPS  );
        mypio_omega_write_ptr   = (unsigned int *)(h2p_lw_virtual_base + MYPIO_OMEGA_FROM_HPS  );
        			
        mypio_n0_read_ptr       = (unsigned int *)(h2p_lw_virtual_base + MYPIO_N0_FROM_FPGA  );
        mypio_nn_read_ptr       = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NN_FROM_FPGA  );
        mypio_ns_read_ptr       = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NS_FROM_FPGA  );
        mypio_nw_read_ptr       = (unsigned int *)(h2p_lw_virtual_base + MYPIO_NW_FROM_FPGA  );
        mypio_ne_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NE_FROM_FPGA  );
        mypio_nnw_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NNW_FROM_FPGA  );
        mypio_nne_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NNE_FROM_FPGA  );
        mypio_nsw_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NSW_FROM_FPGA  );
        mypio_nse_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_NSE_FROM_FPGA  );
        mypio_ux_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_UX_FROM_FPGA  );
        mypio_uy_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_UY_FROM_FPGA  );	

		     mypio_pipes_read_ptr 		= (unsigned int *)(h2p_lw_virtual_base + MYPIO_PIPES  );	
/*
        mypio_n0_write_ptr	 	= (unsigned int *)(vga_pixel_virtual_base + MYPIO_N0_FROM_HPS  );
        mypio_nn_write_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NN_FROM_HPS  );
        mypio_ns_write_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NS_FROM_HPS  );
        mypio_nw_write_ptr	    = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NW_FROM_HPS  );
        mypio_ne_write_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NE_FROM_HPS  );
        mypio_nnw_write_ptr	    = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NNW_FROM_HPS  );
        mypio_nne_write_ptr     = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NNE_FROM_HPS  );
        mypio_nsw_write_ptr     = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NSW_FROM_HPS  );
        mypio_nse_write_ptr     = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NSE_FROM_HPS  );
        mypio_one9th_write_ptr  = (unsigned int *)(vga_pixel_virtual_base + MYPIO_ONE9TH_FROM_HPS  );
        mypio_one36th_write_ptr = (unsigned int *)(vga_pixel_virtual_base + MYPIO_ONE36TH_FROM_HPS  );
        mypio_omega_write_ptr   = (unsigned int *)(vga_pixel_virtual_base + MYPIO_OMEGA_FROM_HPS  );
												   
        mypio_n0_read_ptr       = (unsigned int *)(vga_pixel_virtual_base + MYPIO_N0_FROM_FPGA  );
        mypio_nn_read_ptr       = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NN_FROM_FPGA  );
        mypio_ns_read_ptr       = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NS_FROM_FPGA  );
        mypio_nw_read_ptr       = (unsigned int *)(vga_pixel_virtual_base + MYPIO_NW_FROM_FPGA  );
        mypio_ne_read_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NE_FROM_FPGA  );
        mypio_nnw_read_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NNW_FROM_FPGA  );
        mypio_nne_read_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NNE_FROM_FPGA  );
        mypio_nsw_read_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NSW_FROM_FPGA  );
        mypio_nse_read_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_NSE_FROM_FPGA  );
        mypio_ux_read_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_UX_FROM_FPGA  );
        mypio_uy_read_ptr 		= (unsigned int *)(vga_pixel_virtual_base + MYPIO_UY_FROM_FPGA  );	

*/




	// ===========================================

	/* create a message to be displayed on the VGA 
          and LCD displays */
	

	*(mypio_one9th_write_ptr) = one9th;
	*(mypio_one36th_write_ptr) = one36th;
		*(mypio_omega_write_ptr) = omega ;


	

	/*
int pp;
for(pp=0;pp<50;pp++){
setBoundaries();
  collide();
		stream();
		move_trace();
		
}

int i;
	  for ( x=0; x<xdim; x++) {
			for ( y=0; y<ydim; y++) {
				 i = x+y*xdim ;
				 if(i==137){
					 printf("n0 at address %d is = %d \n",i,n0[i]);
					 printf("nE at address %d is = %d \n",i,nE[i]);
					 printf("nW at address %d is = %d \n",i,nW[i]);
					 printf("nS at address %d is = %d \n",i,nS[i]);
					 printf("nN at address %d is = %d \n",i,nN[i]);
					 printf("nNW at address %d is = %d \n",i,nNW[i]);
					 printf("nNE at address %d is = %d \n",i,nNE[i]);
					 printf("nSE at address %d is = %d \n",i,nSE[i]);
					 printf("nSW at address %d is = %d \n",i,nSW[i]);
					 printf("UX at address %d is = %d \n",i,ux[i]);

					 printf("uy at address %d is = %d \n",i,uy[i]);
				 }
				 
				 }}

for ( x=0; x<xdim; x++) {
			for ( y=0; y<ydim; y++) {
				 i = x+y*xdim ;
				 printf("uy at address %d is = %d \n",i,uy[i]);
				 }}
 

for ( x=0; x<xdim; x++) {
			for ( y=0; y<ydim; y++) {
				 i = x+y*xdim ;
				
				//short speed = 50*sqrt(ux[x+y*xdim]*ux[x+y*xdim]+uy[x+y*xdim]*uy[x+y*xdim]);
				Fix speed = (max(abs(ux[i]), abs(uy[i])) + (min(abs(ux[i]), abs(uy[i])) >>1)) ;//17
				if(speed>speedmax) speedmax = speed ;
				if(speed<speedmin) speedmin = speed ;
				// color = B+(G<<5)+(R<<11);
				color = (((speed>>16) & 0x3f)>>1) ;//+ (((speed>>11) & 0x3)<<13) ; //  17
				printf("Color at address %d is = %d \n",i,color);
			}}

*/


cpu_set_t cpuset;
	CPU_ZERO(&cpuset);  
	// add processsors into the list
	CPU_SET(0, &cpuset);
	CPU_SET(1, &cpuset);
	
	// the thread identifiers
	pthread_t thread_first, thread_second;
pthread_attr_t attr;
	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
	// now the threads
	pthread_create(&thread_first,NULL,first_half,NULL);
	pthread_create(&thread_second,NULL,second_half,NULL);

pthread_join(thread_first,NULL);
	pthread_join(thread_second,NULL);




	
} // end main

/****************************************************************************************
 * Subroutine to send a string of text to the VGA monitor 
****************************************************************************************/
void VGA_text(int x, int y, char * text_ptr)
{
  	volatile char * character_buffer = (char *) vga_char_ptr ;	// VGA character buffer
	int offset;
	/* assume that the text string fits on one line */
	offset = (y << 7) + x;
	while ( *(text_ptr) )
	{
		// write to the character buffer
		*(character_buffer + offset) = *(text_ptr);	
		++text_ptr;
		++offset;
	}
}

/****************************************************************************************
 * Subroutine to clear text to the VGA monitor 
****************************************************************************************/
void VGA_text_clear()
{
  	volatile char * character_buffer = (char *) vga_char_ptr ;	// VGA character buffer
	int offset, x, y;
	for (x=0; x<79; x++){
		for (y=0; y<59; y++){
	/* assume that the text string fits on one line */
			offset = (y << 7) + x;
			// write to the character buffer
			*(character_buffer + offset) = ' ';		
		}
	}
}
/****************************************************************************************
 * Draw a filled rectangle on the VGA monitor 
****************************************************************************************/
#define SWAP(X,Y) do{int temp=X; X=Y; Y=temp;}while(0) 

void VGA_box(int x1, int y1, int x2, int y2, short pixel_color)
{
	char  *pixel_ptr ; 
	int row, col;

	/* check and fix box coordinates to be valid */
	if (x1>639) x1 = 639;
	if (y1>479) y1 = 479;
	if (x2>639) x2 = 639;
	if (y2>479) y2 = 479;
	if (x1<0) x1 = 0;
	if (y1<0) y1 = 0;
	if (x2<0) x2 = 0;
	if (y2<0) y2 = 0;
	if (x1>x2) SWAP(x1,x2);
	if (y1>y2) SWAP(y1,y2);
	for (row = y1; row <= y2; row++)
		for (col = x1; col <= x2; ++col)
		{
			//640x480
			//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
			// set pixel color
			//*(char *)pixel_ptr = pixel_color;	
			VGA_PIXEL(col,row,pixel_color);	
		}
}
/****************************************************************************************
 * Draw a filled ship on the VGA monitor 
****************************************************************************************/
#define SWAP(X,Y) do{int temp=X; X=Y; Y=temp;}while(0) 

void VGA_ship(int x1, int y1, int x2, int y2, short pixel_color)
{
	char  *pixel_ptr ; 
	int row, col;
     

	/* check and fix box coordinates to be valid */
	if (x1>639) x1 = 639;
	if (y1>479) y1 = 479;
	if (x2>639) x2 = 639;
	if (y2>479) y2 = 479;
	if (x1<0) x1 = 0;
	if (y1<0) y1 = 0;
	if (x2<0) x2 = 0;
	if (y2<0) y2 = 0;
	if (x1>x2) SWAP(x1,x2);
	if (y1>y2) SWAP(y1,y2);

        
		if (x1 +2 >639) x1 = 639;
	if (y1 -6 >479) y1 = 479;
	if (x1 +2 <0) x1 = 0;
	if (y1 -6<0) y1 = 0;
       //VGA_Vline(x1+8,y1-10,y1,pixel_color); //bigger pole
       VGA_Vline(x1+2,y1-6,y1,pixel_color); //smaller pole
     float quad1=0,quad2=15;
      int hh=0;
	  /*
     for (row = y1-10-5; row <= y1-2; row++){
		for (col = x1+8 + (quad1); col <= x1 + quad2; ++col)
		{    
			//640x480
			//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
			// set pixel color
			//*(char *)pixel_ptr = pixel_color;	
			VGA_PIXEL(col,row,pixel_color);	
		}
		if(row<y1-5){quad1=quad1+0.2;}
		else{quad1=quad1-0.2;}
		quad2=quad2+0.5;
		hh=hh+1;


		}
		*/
      quad1=0;
	  quad2=2;
      hh=0;

		for (row = y1-6-3; row <= y1-2; row++){
		for (col = x1+2 + (quad1); col <= x1 + quad2; ++col)
		{    

			if (row>639) row = 639;
	if (col>479) col = 479;
	
	if (row<0) row = 0;
	if (col<0) col = 0;

			//640x480
			//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
			// set pixel color
			//*(char *)pixel_ptr = pixel_color;	
			VGA_PIXEL(col,row,pixel_color);	
		}
		if(row<y1-5){quad1=quad1+0.2;}
		else{quad1=quad1-0.2;}
		quad2=quad2+0.9;
		hh=hh+1;


		}


         
	int rr=0;
	for (row = y1; row <= y2; row++){
		for (col = x1+rr; col <= x2-rr; ++col)
		{    
			//640x480
			//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
			// set pixel color
			//*(char *)pixel_ptr = pixel_color;	
				if (row>639) row = 639;
	if (col>479) col = 479;
	
	if (row<0) row = 0;
	if (col<0) col = 0;
			VGA_PIXEL(col,row,pixel_color);	
		}
		if(rr<6){rr++;}
		else{break;}
		}

         


}




/****************************************************************************************
 * Draw a outline rectangle on the VGA monitor 
****************************************************************************************/
#define SWAP(X,Y) do{int temp=X; X=Y; Y=temp;}while(0) 

void VGA_rect(int x1, int y1, int x2, int y2, short pixel_color)
{
	char  *pixel_ptr ; 
	int row, col;

	/* check and fix box coordinates to be valid */
	if (x1>639) x1 = 639;
	if (y1>479) y1 = 479;
	if (x2>639) x2 = 639;
	if (y2>479) y2 = 479;
	if (x1<0) x1 = 0;
	if (y1<0) y1 = 0;
	if (x2<0) x2 = 0;
	if (y2<0) y2 = 0;
	if (x1>x2) SWAP(x1,x2);
	if (y1>y2) SWAP(y1,y2);
	// left edge
	col = x1;
	for (row = y1; row <= y2; row++){
		//640x480
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;	
		VGA_PIXEL(col,row,pixel_color);		
	}
		
	// right edge
	col = x2;
	for (row = y1; row <= y2; row++){
		//640x480
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;	
		VGA_PIXEL(col,row,pixel_color);		
	}
	
	// top edge
	row = y1;
	for (col = x1; col <= x2; ++col){
		//640x480
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;	
		VGA_PIXEL(col,row,pixel_color);
	}
	
	// bottom edge
	row = y2;
	for (col = x1; col <= x2; ++col){
		//640x480
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;
		VGA_PIXEL(col,row,pixel_color);
	}
}

/****************************************************************************************
 * Draw a horixontal line on the VGA monitor 
****************************************************************************************/
#define SWAP(X,Y) do{int temp=X; X=Y; Y=temp;}while(0) 

void VGA_Hline(int x1, int y1, int x2, short pixel_color)
{
	char  *pixel_ptr ; 
	int row, col;

	/* check and fix box coordinates to be valid */
	if (x1>639) x1 = 639;
	if (y1>479) y1 = 479;
	if (x2>639) x2 = 639;
	if (x1<0) x1 = 0;
	if (y1<0) y1 = 0;
	if (x2<0) x2 = 0;
	if (x1>x2) SWAP(x1,x2);
	// line
	row = y1;
	for (col = x1; col <= x2; ++col){
		//640x480
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;	
		
		VGA_PIXEL(col,row,pixel_color);		
	}
}

/****************************************************************************************
 * Draw a vertical line on the VGA monitor 
****************************************************************************************/
#define SWAP(X,Y) do{int temp=X; X=Y; Y=temp;}while(0) 

void VGA_Vline(int x1, int y1, int y2, short pixel_color)
{
	char  *pixel_ptr ; 
	int row, col;

	/* check and fix box coordinates to be valid */
	if (x1>639) x1 = 639;
	if (y1>479) y1 = 479;
	if (y2>479) y2 = 479;
	if (x1<0) x1 = 0;
	if (y1<0) y1 = 0;
	if (y2<0) y2 = 0;
	if (y1>y2) SWAP(y1,y2);
	// line
	col = x1;
	for (row = y1; row <= y2; row++){
		//640x480
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10)    + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;	
		VGA_PIXEL(col,row,pixel_color);			
	}
}


/****************************************************************************************
 * Draw a filled circle on the VGA monitor 
****************************************************************************************/

void VGA_disc(int x, int y, int r, short pixel_color)
{
	char  *pixel_ptr ; 
	int row, col, rsqr, xc, yc;
	
	rsqr = r*r;
	
	for (yc = -r; yc <= r; yc++)
		for (xc = -r; xc <= r; xc++)
		{
			col = xc;
			row = yc;
			// add the r to make the edge smoother
			if(col*col+row*row <= rsqr+r){
				col += x; // add the center point
				row += y; // add the center point
				//check for valid 640x480
				if (col>639) col = 639;
				if (row>479) row = 479;
				if (col<0) col = 0;
				if (row<0) row = 0;
				//pixel_ptr = (char *)vga_pixel_ptr + (row<<10) + col ;
				// set pixel color
				//*(char *)pixel_ptr = pixel_color;
				VGA_PIXEL(col,row,pixel_color);	
			}
					
		}
}

/****************************************************************************************
 * Draw a  circle on the VGA monitor 
****************************************************************************************/

void VGA_circle(int x, int y, int r, int pixel_color)
{
	char  *pixel_ptr ; 
	int row, col, rsqr, xc, yc;
	int col1, row1;
	rsqr = r*r;
	
	for (yc = -r; yc <= r; yc++){
		//row = yc;
		col1 = (int)sqrt((float)(rsqr + r - yc*yc));
		// right edge
		col = col1 + x; // add the center point
		row = yc + y; // add the center point
		//check for valid 640x480
		if (col>639) col = 639;
		if (row>479) row = 479;
		if (col<0) col = 0;
		if (row<0) row = 0;
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10) + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;
		VGA_PIXEL(col,row,pixel_color);	
		// left edge
		col = -col1 + x; // add the center point
		//check for valid 640x480
		if (col>639) col = 639;
		if (row>479) row = 479;
		if (col<0) col = 0;
		if (row<0) row = 0;
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10) + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;
		VGA_PIXEL(col,row,pixel_color);	
	}
	for (xc = -r; xc <= r; xc++){
		//row = yc;
		row1 = (int)sqrt((float)(rsqr + r - xc*xc));
		// right edge
		col = xc + x; // add the center point
		row = row1 + y; // add the center point
		//check for valid 640x480
		if (col>639) col = 639;
		if (row>479) row = 479;
		if (col<0) col = 0;
		if (row<0) row = 0;
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10) + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;
		VGA_PIXEL(col,row,pixel_color);	
		// left edge
		row = -row1 + y; // add the center point
		//check for valid 640x480
		if (col>639) col = 639;
		if (row>479) row = 479;
		if (col<0) col = 0;
		if (row<0) row = 0;
		//pixel_ptr = (char *)vga_pixel_ptr + (row<<10) + col ;
		// set pixel color
		//*(char *)pixel_ptr = pixel_color;
		VGA_PIXEL(col,row,pixel_color);	
	}
}

// =============================================
// === Draw a line
// =============================================
//plot a line 
//at x1,y1 to x2,y2 with color 
//Code is from David Rodgers,
//"Procedural Elements of Computer Graphics",1985
void VGA_line(int x1, int y1, int x2, int y2, short c) {
	int e;
	signed int dx,dy,j, temp;
	signed int s1,s2, xchange;
     signed int x,y;
	char *pixel_ptr ;
	
	/* check and fix line coordinates to be valid */
	if (x1>639) x1 = 639;
	if (y1>479) y1 = 479;
	if (x2>639) x2 = 639;
	if (y2>479) y2 = 479;
	if (x1<0) x1 = 0;
	if (y1<0) y1 = 0;
	if (x2<0) x2 = 0;
	if (y2<0) y2 = 0;
        
	x = x1;
	y = y1;
	
	//take absolute value
	if (x2 < x1) {
		dx = x1 - x2;
		s1 = -1;
	}

	else if (x2 == x1) {
		dx = 0;
		s1 = 0;
	}

	else {
		dx = x2 - x1;
		s1 = 1;
	}

	if (y2 < y1) {
		dy = y1 - y2;
		s2 = -1;
	}

	else if (y2 == y1) {
		dy = 0;
		s2 = 0;
	}

	else {
		dy = y2 - y1;
		s2 = 1;
	}

	xchange = 0;   

	if (dy>dx) {
		temp = dx;
		dx = dy;
		dy = temp;
		xchange = 1;
	} 

	e = ((int)dy<<1) - dx;  
	 
	for (j=0; j<=dx; j++) {
		//video_pt(x,y,c); //640x480
		//pixel_ptr = (char *)vga_pixel_ptr + (y<<10)+ x; 
		// set pixel color
		//*(char *)pixel_ptr = c;
		VGA_PIXEL(x,y,c);			
		 
		if (e>=0) {
			if (xchange==1) x = x + s1;
			else y = y + s2;
			e = e - ((int)dx<<1);
		}

		if (xchange==1) y = y + s2;
		else x = x + s1;

		e = e + ((int)dy<<1);
	}
}