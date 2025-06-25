//Example-6: Passing a String From SV to C

//C File

#include "stdio.h"
#include "svdpi.h"

void print_message(const char* t) {
    printf("\nC: Passing a string from SV to C : Message from SV is \"%s\"\n", t);
}

// SV File
module pass_string;
  import "DPI-C" function void print_message(input string s);
  
  initial begin
    //static string s = "Hello DPI";
    string s = "Hello DPI";
    print_message(s);
  end
endmodule

//Output from Cadence Xcelium Tool

[2025-06-25 04:18:16 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 25, 2025 at 00:18:17 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
    string s = "Hello DPI";
             |
xmvlog: *W,VARIST (testbench.sv,7|13): Local static variable with initializer requires 'static' keyword.
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

C: Passing a string from SV to C : Message from SV is "Hello DPI"
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 00:18:19 EDT  (total: 00:00:02)
Done
