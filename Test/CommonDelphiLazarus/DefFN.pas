unit DefFN;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFuncPC = class(TForm)
    BS: TButton;
    BC: TButton;
    MA: TMemo;

    procedure BSClick(Sender: TObject);
    procedure BCClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;







implementation
uses
TestForevalG9;



{$IFDEF FPC}
   {$R *.LFM}
{$ELSE}
   {$R *.DFM}
{$ENDIF}



procedure TFuncPC.BCClick(Sender: TObject);
begin
ModalResult := mrCancel;
end;





procedure TFuncPC.BSClick(Sender: TObject);
label endp;
var
N,i,j,Er,L: Integer;
begin

TestForevalG9.Form1.CompilePC;


endp:
end;




end.
