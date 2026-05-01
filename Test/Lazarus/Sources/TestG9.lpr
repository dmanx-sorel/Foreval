program TestG9;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses

{$IFNDEF FPC}

{$ELSE}
  //heaptrc,
  Interfaces,
{$ENDIF}
  //FastMM4,
  Forms,
  TestForevalG9 in 'TestForevalG9.pas' {Form1};



//{$R *.RES}


begin
  //ReportMemoryLeaksOnShutdown := True;
  //SetMinimumBlockAlignment(mba16Byte);
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
