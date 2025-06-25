//Example-10: Imported and Exported Functions

//C File
#include <stdio.h>
#include "svdpi.h"

extern void sv_func(svBit, svBit*);

void c_func(svBit b1, svBit *b2) {
    printf(" b1:%d, b2:%d\n", b1, *b2);
    sv_func(b1, b2);
    printf(" b1:%d, b2:%d\n", b1, *b2);
}

//SV File

module top;
    bit b1 = 1'b1, b2 = 1'b0;
  
    import "DPI-C" context c_func = 
      function void import_c_func (input bit bin1, inout bit bin2);
  
    export "DPI-C" sv_func = function export_sv_func;  // Fixed syntax

    function void export_sv_func(input bit eb1, output bit eb2);
        if (eb1 != eb2) begin
            eb2 = ~eb2;
        end
    endfunction

    initial begin
        import_c_func(b1, b2);
    end
  
endmodule

[2025-06-25 06:20:41 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 25, 2025 at 02:20:41 EDT
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
		top
Loading snapshot worklib.top:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
 b1:1, b2:0
 b1:1, b2:1
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 02:20:44 EDT  (total: 00:00:03)
Done
