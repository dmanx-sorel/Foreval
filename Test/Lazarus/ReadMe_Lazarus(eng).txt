                          For compilation in connection mode Foreval.dll.

  Compiling of the test program: 
      Copy modules:  TestForevalG9.pas, DefFN.pas, Forevaldll.pas from folder .../Test/CommonDelphiLazarus to folder .../Test/Lazarus/Sources 
      Compile TestG9.lpr in the folder ... /Test/Lazarus/Sources
  Compilation of Foreval.dll: 
      Copy the Foreval ".pas " source files from the folder .../Foreval/Foreval to the folder .../Foreval/Lazarus
      Compile Foreval.lpr.
  Place Foreval.dll and the test program in common folder.




                  For  compile in the mode of direct connection of Foreval to the program:

  Copy modules TestForevalG9.pas, DefFN.pas  from folder .../Test/CommonDelphiLazarus to folder .../Test/Lazarus/Sources 
  Copy the Foreval ".pas " sources from the folder .../Foreval/Foreval to the folder .../Test/Lazarus/Sources
  In the test program modules: TestForevalG9.pas and the interface module Foreval: Foreval_Lib.pas, disable the key {$DEFINE USEDLL}.
  Compile TestG9.lpr.


PS
Modules test program             :  TestForevalG9.pas, DefFN.pas
connection module                :  Forevaldll.pas
and '.pas' modules of Foreval.dll:  Foreval_Lib.pas, Foreval_Main.pas, Foreval_Command.pas, 
                                    Foreval_DiffNumeric.pas, Foreval_SpecFunc.pas, Foreval_Definitions
are the same for Delphi and Lazarus.


   Forevall.dll compiled in FPC (Lazarus) is not fully compatible with the version compiled in Delphi 2009: 
     no support for string types UTF16, UTF8; 
     incompatible format of dynamic arrays (even in the {$MODE DELPHI}) - (Length -> High) 
     (Real Length = Length(FPC) + 1  !!!)). It is impossible to declare dynamic arrays in exe(Delphi) and to 
     connect dll(FPC) and vice versa. In such cases to connect as internal flSetVarIntrnl, either compile ‘dll’ and 
     ‘exe’   in the same environment, or use compilation with direct connection of Foreval modules.

In version 9.1.1, this incompatibility can be partially bypassed by passing information about the EXE compilation environment to the DLL (See doc)
     flSet(fl_COMPILER_TYPE_EXE,  fl_DELPHI, 0  )  
     flSet(fl_COMPILER_TYPE_EXE,  fl_FREE_PASCAL, 0  ) 
 

Compilation was checked in Lazarus 2.0.10 (FPC 3.2)
