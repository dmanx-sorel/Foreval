                            For compilation Foreval.dll.
For Delphi:
  Copy modules: TestForevalG9.pas, DefFN.pas,  from folder .../Foreval/Foreval to folder .../Foreval/Delphi
  Compile  Foreval.dpr.

 For Lazarus:
  Copy modules: TestForevalG9.pas, DefFN.pas,  from folder .../Foreval/Foreval to folder .../Foreval/Lazarus
  Compile  Foreval.lpr.

Make sure, that the {$DEFINE USEDLL} key is set in the Foreval_Lib.pas module.