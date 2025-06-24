//Example using Import method :

//NOTE:
//By default , in EDA Playground while using Synopsys VCS tool it will show as below
//-timescale=1ns/1ns +vcs+flush+all +warn=all -sverilog 

// To run the SV DPI example , we need to add dpi.c with above compile option, so it will be as below:
//-timescale=1ns/1ns +vcs+flush+all +warn=all -sverilog dpi.c


//By default , in EDA Playground while using Cadence tool it will show as below
//-timescale 1ns/1ns -sysv 

// To run the SV DPI example , we need to add dpi.c with above compile option, so it will be as below:
//-timescale 1ns/1ns -sysv dpi.c
                                                                  
//C file:

#include <stdio.h>

  void addition(int a, int b) {
  printf("Addition of %0d and %0d is %0d\n", a, b, a+b);

}   

//SV file:
module tb;

  import "DPI-C" function void addition(int a, int b);
  
  initial
  begin
    $display("Before add function call");
    addition(4,5);
    $display("After add function call");
  end
  
endmodule  
                                                                  
// Output using cadence Xcelium tool :

[2025-06-24 09:39:42 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 24, 2025 at 05:39:43 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
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
		tb
Loading snapshot worklib.tb:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
Before add function call
Addition of 4 and 5 is 9
After add function call
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 24, 2025 at 05:39:45 EDT  (total: 00:00:02)
Done                                                                
