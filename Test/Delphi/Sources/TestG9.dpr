program TestG9;

uses
  Forms,
  TestForevalG9 in 'TestForevalG9.pas' {Form1},
  Foreval_Definitions in 'Foreval_Definitions.pas';

{$R *.RES}

begin
  SetMinimumBlockAlignment(mba16Byte);
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
