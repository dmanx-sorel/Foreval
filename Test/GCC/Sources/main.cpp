#include <iostream>
#include "ForevalG9Test.cpp"


/**
                               Warning:

      >  Use only 32bit compiler.

      >  Foreval does not support multitasking: compiled expression can not be executed simultaneously in multiple threads;
           For each thread needs its own compilation of expression, it also applies to functions such fl_Precompiled (not  thread-safe).

      >  If many expressions are compiled, but are calculated once, to speed up, disable all optimizations: flSet (fl_Disable, fl_Optimization, 0);

       >  For MSVC and other likes.
           All data passed in  and returned from Foreval (addresses of variables and functions)  must placing in 'unmanaged memory' so as using at compilation, except strings.
           I.e. they are placed in fixed, unmovable addresses in memory.
           Also use mode:
             flSet(fl_ENABLE,fl_USE_VIRTUAL_ALLOC,0);  - necessarily.
             flSet(fl_ENABLE,fl_MASK_FPU_EXCEPTION,0); -to use , if at connecting Foreval.dll, don't catched FPU exception in internal try except block (of dll).

      >  For  environments  with  without 'unmanaged memory'  use internal definition of variables:  SetVarIntrnl , and added external functions  with type flPrecompiled.






**/




/*
   Warning: only for 32bits compilers; all compiled expressions (in Foreval) not support parallel executions(not thread safety)

	 Foreval.dll compiled in FPC work not correctly with dynamic arrays ;
*/

using namespace std;

int main()
{
    test();
    return 0;
}
