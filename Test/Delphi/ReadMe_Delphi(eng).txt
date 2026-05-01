                            For compilation in connection mode Foreval.dll.

  Compiling of the test program: 
     Copy modules:  TestForevalG9.pas, DefFN.pas, Forevaldll.pas from folder .../Test/CommonDelphiLazarus to folder .../Test/Delphi/Sources 
     Compile TestG9.dpr in the folder ... /Test/Delphi/Sources
  Compilation of Foreval.dll: 
     Copy the Foreval ".pas " source files from the folder .../Foreval/Foreval to the folder .../Foreval/Delphi
     Compile Foreval.dpr.
  Place Foreval.dll and the test program in common folder.



                       For  compile in the mode of direct connection of Foreval to the program:

  Copy modules: TestForevalG9.pas, DefFN.pas,  from folder .../Test/CommonDelphiLazarus to folder .../Test/Delphi/Sources 
  Copy the Foreval ".pas " sources from the folder .../Foreval/Foreval to the folder .../Test/Delphi/Sources
  In the test program modules: TestForevalG9.pas and the interface module Foreval: Foreval_Lib.pas, disable the key {$DEFINE USEDLL}.
  Compile TestG9.dpr.


PS
Modules test program             :  TestForevalG9.pas, DefFN.pas,
connection module                :  Forevaldll.pas
and '.pas' modules of Foreval.dll:  Foreval_Lib.pas, Foreval_Main.pas, Foreval_Command.pas, 
                                    Foreval_DiffNumeric.pas, Foreval_SpecFunc.pas, Foreval_Definitions
are the same for Delphi and Lazarus.

Foreval.dll compiled by  DelphiXE3.
Compilation was checked in Delphi2009, DelphiXE3.