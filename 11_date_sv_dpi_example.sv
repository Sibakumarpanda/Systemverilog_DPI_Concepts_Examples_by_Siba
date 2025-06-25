//Example-11: DATE Example 
//A quick example showing how to use DPI. Note that the dpi.c file goes on the command line options

//C File
#include "stdio.h"
#include "svdpi.h"
#include <time.h>

long int date() {
  return time(NULL);
}

//SV File
module test;
  
  import "DPI-C" function longint date();
    longint seconds;
    initial begin
      seconds = date();;
        $display("Seconds: %0d", seconds);
        $finish;
    end

endmodule

//Output Using Cadence Xcelium Tool

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
		test
Loading snapshot worklib.test:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
Seconds: 1750833412
Simulation complete via $finish(1) at time 0 FS + 0
./testbench.sv:10         $finish;
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Jun 25, 2025 at 02:36:52 EDT  (total: 00:00:03)
Done
