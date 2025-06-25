//Example-8: Passing 1D Unpacked Bit Array to C

//C File
#include "stdio.h"
#include "svdpi.h"

void print_array (svBitVecVal arr [6])
{
  for (int j=0;j<6;j++)
  {
    printf ("\nC :Value in C-code of nums[%d] is %d \n ",j,arr[j]) ;
   
  }
}

//SV File
module pass_array;
  
  import "DPI-C" function void print_array (input bit [15:0] arr[5:0]);
    initial begin
      bit[15:0] arr[5:0]= '{1,2,3,4,5,6};
      print_array(arr);
    end
  
endmodule    

// Output Using Cadence Xcelium Tool
  
  [2025-06-25 06:16:58 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 25, 2025 at 02:16:59 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
      bit[15:0] arr[5:0]= '{1,2,3,4,5,6};
                        |
xmvlog: *W,VARIST (testbench.sv,7|24): Local static variable with initializer requires 'static' keyword.
$CDSROOT = /xcelium23.09
$TESTDIR = /home/runner

TOOL:	xmsc	23.09-s001
xmsc cc parameters: 
	$CDSROOT/tools/cdsgcc/gcc/9.3/bin/gcc
	-I$CDSROOT/tools/include
	-I$CDSROOT/tools/inca/include
	-pipe 
	-DXMSC
	-DNCSC
	-D_GLIBCXX_USE_CXX11_ABI=1 -c
	-x c -m32  -Wall 

xmsc: compiling $TESTDIR/dpi.c

building library run.so

	Top level design units:
		pass_array
Loading snapshot worklib.pass_array:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run

C :Value in C-code of nums[0] is 6 
 
C :Value in C-code of nums[1] is 5 
 
C :Value in C-code of nums[2] is 4 
 
C :Value in C-code of nums[3] is 3 
 
C :Value in C-code of nums[4] is 2 
 
C :Value in C-code of nums[5] is 1 
 xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 02:17:01 EDT  (total: 00:00:02)
Done
