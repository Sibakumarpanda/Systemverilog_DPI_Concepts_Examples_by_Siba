//Example-11

// C++ Code

#include "stdio.h"
#include "svdpi.h"

extern "C" {

  void f(
    const svBitVecVal* fa,
    const svBitVecVal* fs,
    const svBitVecVal* fu,
    const svBit* fb,
    const svLogic fl0,
    const svLogic fl1,
    const svLogic flz,
    const svLogic flx,
    const svLogicVecVal* flpa
    )
    	
  {
    int i;
    printf("fa is %d, fs is %d, fu is %d\n", *fa, *fs, *fu);

    for (i = 0; i < 10; i++)
      printf("b[%0d] is %0d\n", i, fb[i]);

    
    printf("l0 = %0d\n", fl0);
    printf("l1 = %0d\n", fl1);
    printf("lz = %0d\n", flz);
    printf("lx = %0d\n", flx);
    
    printf("lpa.aval = %0x\n", flpa->aval);
    printf("lpa.bval = %0x\n", flpa->bval);
    
    printf("\n");
    
  }

}

//SV File
module m;

  typedef bit [2:0] A;

  typedef struct packed { bit a; bit b; bit c; } S;

  typedef union packed { A a; S s; } U;

  bit b [3:12];  
  S s;
  U u;
  A a;
  logic l0, l1, lz, lx;
  logic [11:23] lpa;
  

  import "DPI-C" function void f(input A a, input S s, input U u, input bit b[3:12], 
                                 input logic l0, input logic l1, input logic lz, input logic lx, input logic [11:23] la);
  
  initial begin
    s.a = 1'b1;
    s.b = 1'b0;
    s.c = 1'b0;
    a = 3'b100;
    u.a = 3'b100;
    l0 = 1'b0;
    l1 = 1'b1;
    lz = 1'bz;
    lx = 1'bx;
    lpa = 13'bx_zzzz_1111_0000;
    
    for(int i = 3; i <= 12; i++)
      b[i] = (i % 3) & 1'b1;

    f(a, s, u, b, l0, l1, lz, lx, lpa);
  end
  
endmodule

//Output Using Cadence Xcelium Tool

[2025-06-25 12:18:17 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.cc' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 25, 2025 at 08:18:17 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
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
		m
Loading snapshot worklib.m:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
fa is -4, fs is -4, fu is -4
b[0] is 0
b[1] is 1
b[2] is 0
b[3] is 0
b[4] is 1
b[5] is 0
b[6] is 0
b[7] is 1
b[8] is 0
b[9] is 0
l0 = 0
l1 = 1
lz = 2
lx = 3
lpa.aval = fffff0f0
lpa.bval = ffffff00

xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 08:18:20 EDT  (total: 00:00:03)
Done
