//Example-9: Passing Logic Value to C

//C File
#include <stdio.h>
#include "svdpi.h"

void print_statement(const svLogicVecVal* v)
{
    // For 4-state values (with X/Z), use v->aval and v->bval
    printf("v (combined) = %08x\n", *(unsigned int*)v);
    printf("aval (value bits) = %x\n", v->aval);
    printf("bval (X/Z bits) = %x\n", v->bval);
}

//SV File
module pass_logic_value;
    import "DPI-C" function void print_statement(input logic[7:0] v);

    initial begin
      print_statement(8'b0011XXZZ); // Will show aval=0x33, bval=0xCC (X/Z bits)
    end
  
endmodule

//Output Using Cadence Xcelium 

[2025-06-25 06:18:48 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 25, 2025 at 02:18:48 EDT
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
		pass_logic_value
Loading snapshot worklib.pass_logic_value:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
v (combined) = 0000003c
aval (value bits) = 3c
bval (X/Z bits) = f
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 02:18:50 EDT  (total: 00:00:02)
Done

