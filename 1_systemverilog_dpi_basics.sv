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


C vs SystemVerilog Data Types:
  
-A pair of matching type definitions is required to pass a value through DPI: the SystemVerilog definition and the C definition.
-SystemVerilog types which are directly compatible with C types are presented below. 
  
SYSTEMVERILOG TYPE	                  C Type
  
byte	                                char
int	                                  int
longint	                              long long
shortint	                            short int
real	                                double
shortreal	                            float
chandle	                              void*
string	                              char*  

About SV DPI:
-Direct Programming Interface (DPI) allows users to establish communication between foreign languages and SystemVerilog. 
-It has two separate layers as a foreign language layer and a SystemVerilog layer which are completely isolated. 
-DPI allows having a heterogeneous system that connects and efficiently connects existing code written in other languages.
-DPI also allows calling functions and tasks from other languages or vice-versa using import/ export methods. 
-These methods can communicate with the help of arguments and return value.  

Import Method :
- SystemVerilog can call functions or tasks (methods) implemented in a foreign language, such methods are called import methods
- syntax:  import “DPI-C” function <return_type> <function_name> (<arguments if any>)
- For example: 
import "DPI-C" function void init();
import "DPI-C" function int sum(int a, b);

Export Method:
-Methods implemented in SystemVerilog can be called in other foreign languages and need to be specified in an export declaration.
-A foreign language can call functions or tasks (methods) implemented in SystemVerilog, such methods are called export methods
-Syntax: export "DPI-C" function <function_name>
- For example:  
export "DPI-C" function int randomize(int range_a, range_b);   

Example using Import method :
                                                                  
//C file:
#include <stdio.h>

  void addition(int a, int b) {
  printf("Addition of %0d and %0d is %0d\n", a, b, a+b);

}   

//SV file:
module tb;

  import "DPI-C" function void addition(int a, int b);
  
  initial
  begin
    $display("Before add function call");
    addition(4,5);
    $display("After add function call");
  end
  
endmodule  
                                                                  
// Output:
Before add function call
Addition of 4 and 5 is 9
After add function call                                                                 

Example using Export method :  

//C file:
#include <stdio.h>
//#include <svdpi.h>

extern void addition(int, int);

void c_caller() {
  printf("Calling addition function from c_caller\n");
  addition(4, 5);

} 

//SV file:
module tb;

  export "DPI-C" function addition; // This is not a function prototype
  import "DPI-C" context function void c_caller();
  
  function void addition(int a, b);
    $display("Addition of %0d and %0d is %0d\n", a, b, a+b);
  endfunction
    
  initial
  begin
    c_caller();
  end
endmodule  

//Output:
Calling addition function from c_caller
Addition of 4 and 5 is 9  
