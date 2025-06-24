//Example-5: Exporting from SV Tasks and Functions: parity calculation

//C File
#include <stdio.h>
#include <svdpi.h>

// Forward declaration of the SV function
extern void display_text(const char* text);

int parityf(int a) {
    int parity = 0;
    while (a) {
        parity ^= a & 1;
        a >>= 1;
    }
    display_text("Parity Done");
    return parity;
}

//SV File
         
module parity_calculator_tb;
  
  import "DPI-C" context function int parityf(input int a);
  export "DPI-C" function display_text;
  
  function void display_text(input string text);
    $display("from SV: %s", text);
  endfunction
  
  initial begin
    int x = 2;  // Example input
    int y = 5;  // Example input
    int parity;
    parity = parityf(x);
    $display("Parity of %0d is %0d", x, parity);
    parity = parityf(y);
    $display("Parity of %0d is %0d", y, parity);
  end
            
endmodule    

//Outout using Cadence Xcelium Tool

[2025-06-24 15:35:51 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 24, 2025 at 11:35:51 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
    int x = 2;  // Example input
          |
xmvlog: *W,VARIST (testbench.sv,13|10): Local static variable with initializer requires 'static' keyword.
    int y = 5;  // Example input
          |
xmvlog: *W,VARIST (testbench.sv,14|10): Local static variable with initializer requires 'static' keyword.
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
		parity_calculator_tb
Loading snapshot worklib.parity_calculator_tb:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
from SV: Parity Done
Parity of 2 is 1
from SV: Parity Done
Parity of 5 is 0
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 24, 2025 at 11:35:54 EDT  (total: 00:00:03)
Done
