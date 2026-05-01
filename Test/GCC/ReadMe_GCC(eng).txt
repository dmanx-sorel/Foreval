
----------------------------------------------------------------------------------------------------------------------------------------------

The sources for GCC can be compiled in CodeBlock16, CodeBlock17, CodeBlock20.
At compiling in CodeBlock20, there may be obstacles.
The GCC test program was compiled into CodeBlock20, but not without difficulty.
To run the Gcc test program, copy Foreval.dll from the folder .../Test/Delphi and place it into the folder with the program .../Test/GCC.
To compile the program, open the "ForevalG9.cbp" file in the CodeBlock and compile it.
Works with Foreval.dll compiled in both Delphi and Lazarus.


                                     Program settings:

   module Types.h: 
     COMPLEX_VAR_ANY_ADDR - sets the way to connect complex variables.
     EXTENDED_FLOAT - extended/double - sets the type of variables with floating point. Also for functions.

   module ForevalG9Test.cpp:
      variable TypeCalcProc (= 1,2,3,4,5,6) in the procedure test()  sets the method for calculations  the entered expressions.
      default = 4; at startup the choice between = 2,4  (2 - the fastest, but without exception interception)

                                                        (4 - with full interception of all exceptions, but at the same time, works more slowly)


                                   Test execution sequence:

  1. Testing examples of Foreval features.  See the GCC sources.
  2. Comparative performance tests GCC vs Foreval for real numbers.
  3. Comparative performance tests GCC vs Foreval for complex numbers.
  4. Calculation of the entered expression and the first derivative with respect to "x" from it.

PS
  After the 3rd stage, it will be offered to return back to the second.
  To go to 4th, answer "N" twice.


----------------------------------------------------------------------------------------------------------------------------------------------

                                               Comments on the comparison results:



1.
  For complex numbers, expressions are evaluated in Gcc in two ways
   GCC OVRL - through definition the type of complex numbers and overloading arithmetic operators for them.
   GCC STD - via using the built-in class std::complex.

2.
  Performance comparisons are performed by calculating the sum of the expression in a loop while modifying the variables included in the expression.

  The increment of variables is specified as a dependence on the entered number of loops so that the optimizer does not throw the expression out of the loop.
  The number of calculation cycles for each expression is set in the ranges 2E6-2E9 and for the accuracy of the comparison should be such 
   that each expression is calculated for at least 10 seconds.

PS
For GCC examples in b.385+, the way compiled expressions are called has been changed.
Now (not for all cases) it is performed through a direct addressing call in the code (inline insertion) and works several% faster. 
Previously, it was done through calls to calculating Foreval commands.




--------------------------------------------------------------------------------------------------------------------------------------------------



