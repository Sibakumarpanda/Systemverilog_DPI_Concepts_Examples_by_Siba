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

To be Noted:
-The C function slave_write is called inside the SystemVerilog function, the arguments being passed by value (we will see more detail about this later in the tutorial).
-The function imported from C has two inputs, which in C are declared as const.
-This is because they shouldn’t be changed in the C function.
-Both DPI imported and exported functions can be declared in any place where normal SystemVerilog functions can be (e.g. package, module, program, interface, constructs).
-Also all functions used in DPI complete their execution instantly (zero simulation time), just as normal SystemVerilog functions. 
-chandle is a special SystemVerilog type that is used for passing C pointers as arguments to imported DPI functions.

// User-defined function
import "DPI" function void AFunc();

// Standard C function
import "DPI" function chandle malloc(int size);

// Standard C function
import "DPI" function void free(chandle ptr);

// Open array of 8-bit
import "DPI" function void OpenF(logic [7:0] Arg[]);  
