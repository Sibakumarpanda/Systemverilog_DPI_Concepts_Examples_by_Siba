//Example using Export method :  
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
//#include <svdpi.h>

extern void addition(int, int);

void c_caller() {
  printf("Calling addition function from c_caller\n");
  addition(4, 5);

} 

//SV file:
module tb;

  export "DPI-C" function addition; // This is not a function prototype
  import "DPI-C" context function void c_caller();
  
  function void addition(int a, b);
    $display("Addition of %0d and %0d is %0d\n", a, b, a+b);
  endfunction
    
  initial
  begin
    c_caller();
  end
endmodule  

//Output using cadence Xcelium Tool

[2025-06-24 09:45:02 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 24, 2025 at 05:45:03 EDT
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
Calling addition function from c_caller
Addition of 4 and 5 is 9

xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 24, 2025 at 05:45:07 EDT  (total: 00:00:04)
Done
