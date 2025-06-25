// Example-13

// This file is compiled as C++ and linked with stdlib
// into the simulation executable.
//C++ File

#include <iostream>
#include <svdpi.h>

using namespace std;

extern "C" int helloFromCpp(svLogic a) {
  // 0 is 0
  // 1 is 1
  // 2 is Z
  // 3 is X
  
  int a_int = a;
  cout << "(C++) a is " << a_int << endl;
  return 0;
}

// Example of using SystemVerilog DPI-C with C++ code.

/*

This example demonstrates how to use DPI-C import/export with C++ using Riviera Pro.

Compiling the C++ is as simple as just adding the C++ as a new tab.

The C++ code is then imported into the SystemVerilog code using the line

import "DPI-C" function void helloFromCpp(logic a);

*/

// SV File

module automatic test;
 
  import "DPI-C" function void helloFromCpp(logic a);

  initial run();
 
  task run();
    logic a = 1'bx;
    $display("a is %0d", a);
    helloFromCpp(a);
    a = 1;
    $display("a is %0d", a);
    helloFromCpp(a);
    a = 1'bz;
    $display("a is %0d", a);
    helloFromCpp(a);
  endtask
 
endmodule


//Output uisng Cadence Xcelium Tool

[2025-06-25 12:20:21 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.cc' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 25, 2025 at 08:20:21 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
module automatic test;
               |
xmvlog: *W,DFAUTO (testbench.sv,17|15): Default automatic lifetime will not be applied outside tasks and functions.
$CDSROOT = /xcelium23.09
$TESTDIR = /home/runner

TOOL:	xmsc	23.09-s001
xmsc C++ parameters: 
	xmsc -COMPILER $CDSROOT/tools/cdsgcc/gcc/9.3/bin/g++ 
	-f ./xcelium.d/run.lnx86.23.09.d/xmsc_run/xmsc_obj/xmsc.args
	-MANUAL 
	-CFLAGS "-DXMSC
		-DNCSC
		-I$CDSROOT/tools/systemc/include_pch
		-I$CDSROOT/tools/tbsc/include
		-I$CDSROOT/tools/vic/include
		-I$CDSROOT/tools/methodology/OVM/CDNS-2.1.2/sc/src
		-I$CDSROOT/tools/methodology/UVM/CDNS-1.1d/sc/sc
		-I$CDSROOT/tools/methodology/UVM/CDNS-1.1d/ml/sc
		-I$CDSROOT/tools/systemc/include/cci
		-I$CDSROOT/tools/systemc/include/factory
		-I$CDSROOT/tools/systemc/include/tlm2
		-D_GLIBCXX_USE_CXX11_ABI=1 -c
		-x c++ -m32  -Wall 
		-I$CDSROOT/tools/include
		-I$CDSROOT/tools/inca/include
		-pipe"

xmsc: compiling $TESTDIR/dpi.cc

building library run.so

	Top level design units:
		test
Loading snapshot worklib.test:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
a is x
(C++) a is 3
a is 1
(C++) a is 1
a is z
(C++) a is 2
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 08:20:32 EDT  (total: 00:00:11)
Done
