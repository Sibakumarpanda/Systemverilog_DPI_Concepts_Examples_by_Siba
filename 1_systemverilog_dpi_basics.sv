//Systemverilog DPI Basics:

-The SystemVerilog Direct Programming Interface (DPI) is basically an interface between SystemVerilog and a foreign programming language, in particular the C language. 
-It allows the designer to easily call C functions from SystemVerilog and to export SystemVerilog functions, so that they can be called from C.
-The DPI has great advantages: It allows the user to reuse existing C code and also does not require the knowledge of Verilog Programming Language Interface (PLI) or Verilog Procedural Interface (VPI) interfaces. 
-It also provides an alternative (easier) way of calling some, but not all, PLI or VPI functions.
-Functions implemented in C can be called from SystemVerilog using import "DPI" declarations. 
-We will refer to these functions as imported tasks and functions. All imported tasks and functions must be declared. 
-Functions and tasks implemented in SystemVerilog and specified in export "DPI" declarations can be called from C. 
-We will refer to these tasks and functions as exported tasks and functions.

//A Simple Example : 
-Here an example is presented. 
-A module called Bus contains two functions: write, which is a SystemVerilog function that is also exported to C, and a function called slave_write which is imported from C. Both functions return void.
//SystemVerilog: 
  
module Bus(input In1, output Out1);
  import "DPI" function void slave_write(input int address,
                                         input int data);
  export "DPI" function write;  // Note – not a function prototype

  // This SystemVerilog function could be called from C
  function void write(int address, int data);
    // Call C function
    slave_write(address, data); // Arguments passed by copy
  endfunction
  ...
endmodule

//C:
#include "svdpi.h"
extern void write(int, int);    // Imported from SystemVerilog
void slave_write(const int I1, const int I2)
{  
  buff[I1] = I2;
  ...
}  
