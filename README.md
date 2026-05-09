# About Foreval library

Foreval is compiler of mathematical expressions, given as string at run-time. 
After parsing and building tree of expression is perform  optimizations and compiling directly to x86-32 CPU/FPU/SSE  instructions. 
The address of the compiled expression is returned, which can be passed into program and call inside it or evaluate an expression by calling Foreval external functions.
Present as "dll" library and Delphi sources. Can be compiled in FPC (Lazarus). Can be direct connection to the program (without dll).
Examples for Delphi, Lazarus , GCC (Codeblock).
Foreval.dll is 32 bit compiler. Can be connected only for 32 bit program.
Compiled "Foreval.dll" and  demo programs work in Windows OS 32/64.   Current version   9.1.1.395A.   MIT License.


## Main properties:

* Unlimited length and nested of expression (limited only by computer memory).
* Built-in operations:
                                                  
>-    '+'        - addition
>-    '-'        - substraction
>-    '*'        - multiply
>-    '/'        - division
>-    '^'        - power
>-    '!'        - factorial
>-    '!!'       - double factorial 
>-    '@'        - taking the address
>-    '='        - assignment/comparison
>-   '(,)'       - bracket
>-   '| |'       - abs bracket
>-   '[,]'       - trunc bracket
>-   '{,}'       - frac bracket 
>-   '$'         - conjugation of complex variable;  $z=Conj(z)
>-   '.re'       - real part of complex variable;      z.re=Re(z)
>-   '.im'       - imaginary part of complex variable; z.im=Im(z)  
>-   '$h'        - hexadecimal number suffix. ( A12FF$h )
>-   '$b'        - binary number suffix. ( 11001011101$b )
>-   '...'       - logical operators (connected separately see .doc).

* Built-in main:

>-  logical functions: and, or, not, xor, nand, nor, xnor
>-  trigonometric, hyperbolic, ... and other functions.
>-  special functions: gamma, bessel, legendre, ...and other.
>-  statistical functions, functions of generate of pseudorandom numbers.
>-  functions with arrays: max, min, sum, ...and other.
>-  algorithmic commands: if, goto, gosub/return, call, for, while, case,...and other.
>-  procedures for masking and intercepting FPU exceptions: setmaskfpu, try, except,...and other.

* Adding internal and external real variables and arrays of (extended, double, single, integer32), parameters of (extended, double) and pointers. All arrays are dynamic.
* Support complex numbers: variables of (extended, double, single) and complex parameters of (extended, double).
* Adding external functions with unlimited and indefinite number of variables with any types of (real, integer32, complex, array, pointer).
* Adding external functions in one line with any types and numbers of arguments (real, integer32, complex,array, pointer) .
* Adding an external functions (with one argument) given by arrays of data using cubic spline interpolation.
* Symbolic and numeric differentiation (also for the added functions).
* Multi-level  optimization of code.
* Supported string types: UTF16, WideString, AnsiString, UTF8


### Compiled   files: 
* Foreval.dll  (in .../Test/Delphi) - Foreval library.
* TestG9_dll.exe (in .../Test/Delphi) - main testing program of Foreval.dll with all optpimizations
* ForevalG9_GCC_O3_EXT.exe (in .../Test/GCC) - testing program compiled in GCC. Consist manies examples of using, commentaries and comparative performance test with GCC        
* ComplexVisual.exe (in .../ComplexVisual/exe) - executes the given program text in the syntax of Foreval library. Text examples of programs:
>- program visualizing of functions of complex variable F(z) - complex domain coloring, 
>- building simple fractals of F(z) 
>- graph plotting of real function  F(x)
>- finding roots  of real function  F(x)
>- Fourier series of real function  F(x)

To run the  test program, copy Foreval.dll from the folder .../Test/Delphi and place it into the folder with the test program.

".../doc"     - full documentation in ".doc" files.

".../Foreval" - sources of Foreval (for Delphi and Lazarus) .
