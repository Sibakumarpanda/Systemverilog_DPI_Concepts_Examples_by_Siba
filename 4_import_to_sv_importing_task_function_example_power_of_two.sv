//Example-3: Importing Tasks and Functions: Computing Power of 2 for variable

//C File
#include "stdio.h"
#include "svdpi.h"
#include "math.h"

calculate_pwr (int t)
  
{
   int x ;
   x = pow (t ,2);
   printf("C: Power of 2 for variable from SV is %d\n", x);
    
 }

//SV File
module calling_the_DPI_tb;
  
  import "DPI-C" function void calculate_pwr(input int s);
  
  initial begin
    int s = 7;
    calculate_pwr(s);
  end
  
endmodule

//Output by using Cadence Xcelium Tool

[2025-06-24 10:43:09 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' 'dpi.c' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on Jun 24, 2025 at 06:43:10 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
    int s = 7;
          |
xmvlog: *W,VARIST (testbench.sv,8|10): Local static variable with initializer requires 'static' keyword.
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

$TESTDIR/dpi.c:9:1: warning: return type defaults to 'int' [-Wimplicit-int]
    9 | calculate_pwr (int t)
      | ^~~~~~~~~~~~~
$TESTDIR/dpi.c: In function 'calculate_pwr':
$TESTDIR/dpi.c:16:2: warning: control reaches end of non-void function [-Wreturn-type]
   16 |  }
      |  ^

building library run.so

	Top level design units:
		calling_the_DPI_tb
Loading snapshot worklib.calling_the_DPI_tb:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
C: Power of 2 for variable from SV is 49
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 24, 2025 at 06:43:12 EDT  (total: 00:00:02)
Done
