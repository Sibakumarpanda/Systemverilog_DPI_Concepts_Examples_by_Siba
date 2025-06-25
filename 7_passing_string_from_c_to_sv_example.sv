//Example-7: Passing a String From C to SV

//C File
#include "stdio.h"
#include "svdpi.h"

char * print_message ()
{
return "HI from C Programming World" ;
  
}

// SV File
module pass_string ;
  
  import "DPI-C" function string print_message ();
  
  initial begin
    string s = print_message();
    $display("%s",s);
  end
  
endmodule

//Output From Cadence Xcelium Tool

[2025-06-25 04:48:24 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 25, 2025 at 00:48:24 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
    string s = print_message();
             |
xmvlog: *W,VARIST (testbench.sv,8|13): Local static variable with initializer requires 'static' keyword.
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
		pass_string
Loading snapshot worklib.pass_string:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
HI from C Programming World
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 00:48:27 EDT  (total: 00:00:03)
Done
