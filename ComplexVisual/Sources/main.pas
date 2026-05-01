unit main;

                   { ver. 1.1  for ForevalG9 }


interface
uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, math, OpenGL, ExtCtrls, ComCtrls ,

//{$FINITEFLOAT ON}



{$DEFINE USEDLL}


   {$IFDEF USEDLL}
     Forevaldll;
   {$ELSE}
     Foreval_Lib, Foreval_Definitions;
   {$ENDIF}



{$IFDEF USEDLL}
   // с использонием dll: установить такой же ключ в   Forevaldll (тип передаваемых строк)
   // with dll: to set the same key in Forevaldll (type of passed strings)

   {.$DEFINE STRING}        //test in dll
   {$DEFINE ANSISTRING}    //test in dll
   {.$DEFINE WIDESTRING}    //test in dll
   {.$DEFINE PANSICHAR}     //test in dll
   {.$DEFINE UTF8}     //test in dll

{$ELSE}
   {$DEFINE STRINGINT}
{$ENDIF}


{$IFDEF STRINGINT}     type TStringType = String;       {$ENDIF}

{$IFDEF STRING}       type TStringType = String;       {$ENDIF}

{$IFDEF ANSISTRING}   type TStringType = AnsiString;   {$ENDIF}

{$IFDEF WIDESTRING}   type TStringType = WideString;    {$ENDIF}

{$IFDEF PANSICHAR}    type TStringType = PAnsiChar;    {$ENDIF}

{$IFDEF UTF8}         type TStringType = UTF8String;       {$ENDIF}

const
_Fractal:          cardinal  = 1;
_ComplexDraw :     cardinal = 2;
_ComplexDynDraw :  cardinal = 3;
_Graph2DDraw:      cardinal = 4;
_Graph2DFourier:   cardinal = 5;




  {
  type
   TComplexD =
   record
      re: double;
      im: double;
   end;

   type
   TComplexE =
   record
      re: extended;
      im: extended;
   end;
    }

   const
    FPCdll     =  1;
    Delphidll  =  0;
  

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    PFLD: TPanel;
    Image1: TImage;
    MFRC: TMemo;
    Button1: TButton;
    Label6: TLabel;
    Label7: TLabel;
    BInit: TButton;
    ES: TEdit;
    Label8: TLabel;
    ETF: TEdit;
    LFG: TLabel;
    Button3: TButton;
    OpenFile: TOpenDialog;
    BDraw: TButton;
    L_FPS: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    RadioGroup1: TRadioGroup;
    RB_ComplexGraph: TRadioButton;
    RB_Fractal: TRadioButton;
    RB_ComplexDynamic: TRadioButton;
    UpDown1: TUpDown;
    Label12: TLabel;
    LabC: TLabel;
    RB_GraphFX: TRadioButton;
    E_Dens: TEdit;
    Label13: TLabel;
    Image3: TImage;
    Button2: TButton;
    Image2: TImage;
    Button4: TButton;
    Image4: TImage;
    Image5: TImage;
    Button5: TButton;
    Button6: TButton;
    CB_AReDrw: TCheckBox;
    Label9: TLabel;
    RB_Fourier: TRadioButton;
    E_NHarmonics: TEdit;
    Label14: TLabel;
    CB_FixFourier: TCheckBox;
    Label15: TLabel;
    L_FourierInterval: TLabel;


    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowError;
    procedure BInitClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BDrawClick(Sender: TObject);
    //procedure BFractalClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure RB_FractalClick(Sender: TObject);
    procedure RB_ComplexGraphClick(Sender: TObject);
    procedure RB_ComplexDynamicClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure ShowLibData;
    procedure RB_GraphFXClick(Sender: TObject);
    procedure CreateOpenGLHandle;
    procedure GraphFXInitGL;
    procedure Edit4Enter(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure CB_AReDrwClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure E_DensChange(Sender: TObject);
    procedure InitIntegral;
    function  Integral1(Func: Pointer;  PV: PExtended; a,b: Extended): Extended;
    procedure CreateFourierCoaff(Func: Pointer;  PV: PExtended; a,b: Extended);
    function  EvalFourieFunc(x,a,b: Extended): Extended;
    procedure RB_FourierClick(Sender: TObject);
    function  CallFSafe(Func: Pointer): Extended;
    procedure CB_FixFourierClick(Sender: TObject);

    private

    public



    S_TextProg: String;

    procedure ConvStr(P: Pointer; var S: String);
    procedure ComplexToHSV(z: TComplexE; var h,s,v :extended);
    procedure HsvToRgb(h,s,v: extended; var cr,cg,cb: extended);
    procedure DrawDynComplex;
    procedure DrawComplex;
    procedure DrawFractal;
    procedure DrawGraph2D;
    procedure DrawGraph2DGL;
    procedure DrawGraph2D_FS;
    procedure DrawGraph2DFourier;
    procedure SetDCPixelFormat (hdc : HDC);
    procedure Scaling;
    procedure ConvLinesToStr;
    procedure FindDrawMode;

      var

       c_real, c_img,tgx, tgy, { x1, X2,Y1,Y2,} Xmax,Xmin, Ymax,Ymin, Sc, XF,YF,TF,AF,BF,CF: {Double;} extended;
       NSc: Integer;
       r4, g4, b4, l, n:integer;
       imagemouse: boolean;
       imageRect: TRect;
       tmr1, tmr2:cardinal;
       NIter, ISize, itr: Cardinal;

       zf,c0: TComplexD;
       FJ,FJ1: Pointer;
       fx,fy: double;

       F_BTest1: Boolean;

       Gr_Mode: cardinal;
       G_Error: cardinal;


       //Zd,FZd: TComplexD;
      { ResultCx: TComplexE;
       //ResultR  absolute ResultCx.re;
       ResE: Extended;
       ResultR: Extended absolute ResultCx;  }
       KDens: Integer;

       F_AutoReDraw,F_DefFunc,F_DefFuncDeriv,F_FixFourierInterval: Boolean;
       N_EndProg: Integer;
       S_FuncName: String;

       an,bn: array [1..15] of extended; //интегральные коэффиценты
       Aint,Bint: array of extended; //интегральные коэффиценты
       P_Integral, N_Integral, P_IntegralInit: Integer;
       N_Harmonics: Integer;
       A0fc: Extended;
       Afc,Bfc: array of Extended;
       FourierXmin,FourierXmax: Extended;
       FourierA,FourierB: Extended;
       FI_FixFourierInterval: Integer;



       PenWidth:  Integer;
       PenStyle:  TPenStyle;
       PenColor:  TColor;

    end;


    procedure _DrawGraph2D(AddrGF: Pointer; Gv: Pointer; ShowImg: Integer);    stdcall;
    procedure ShowImage; stdcall;

    procedure _DelFalseCloseRoot(AddrF: Pointer; RootTmp: TArrayE; var RootF: TArrayE); stdcall;
    procedure _Sort(var VE: TArrayE);   stdcall;

var
  Form1: TForm1;
implementation
//uses UQPixels;
var
 btm, BitMap: tbitmap;
 G_FMT: TFormatSettings;
 HGD: HDC;
 DC: HDC;
 hrc: HGLRC;
 hnd: THandle;
 ZFunc: Pointer;
 Ze,zt,Z1e,Z2e,Z3e: TComplexE;
 ResultCx: TComplexE;
 ResultFZ: TComplexE absolute ResultCx;
 ResultR: Extended absolute ResultCx.re;
 ResultFX: Extended absolute ResultCx.re;
 ResultCxD,Zd: TComplexD;
 // Xmax,Xmin, Ymax,Ymin: extended;
 G2d_PointSize: Integer;
 G2d_PointColor: TColor;
 DllCmpl:Integer;



{$R *.DFM}




procedure TForm1.ConvStr(P: Pointer; var S: String);
var
S1: String;
ECode: Cardinal;
PC: PChar;
Ans: AnsiString;
str:TStringType;
ws: widestring;
PAC: PAnsiChar;
su8: UTF8String;
begin

  {$IFDEF ANSISTRING}   Ans:=AnsiString(P);    S:=Copy(Ans,1,Length(Ans)); Ans:='';      {$ENDIF}
  {$IFDEF STRING}       Str:=String(P);        S:=Copy(Str,1,Length(Str)); Str:='';    {$ENDIF}
  {$IFDEF WIDESTRING}   ws:=WideString(P);     S:=Copy(ws,1,Length(ws));   ws:='';   {$ENDIF}
  {$IFDEF UTF8}         su8:=UTF8String(P);    S:=Copy(Su8,1,Length(Su8)); Su8:='';    {$ENDIF}
  {$IFDEF PANSICHAR}    PAC:=PAnsiChar(P);     Ans:=AnsiString(PAC); S:=Copy(Ans,1,Length(Ans)); Ans:='';  {$ENDIF}

end;




procedure TForm1.Scaling;
begin
NSc:=Trunc(StrToFloat(ES.Text,G_FMT));

if NSc = 0  then NSc:=1;

 if NSc < 0 then
   Sc:=abs(1/NSc)
 else
   Sc:=NSc;

ES.Text:=IntToStr(NSc);
end;



procedure InitFuncStruct(var FS: TAddFuncStruct);
begin
  FS.addr:=nil;
  FS.CallType:=fl_StdCall;
  FS.Arg:=0;
  FS.ArgType:=fl_Differ;
  FS.ArgTypeList:=nil;
  FS.CallFunc:=0;
  FS.ResultType:=0;
  FS.CalcConst:=fl_YES;
  FS.DeepFPU:=8;   //fl_UNKNOWN   //max value = 8 !
  FS.SaveReg:=15;  //=15: save eax,ebx,ecx,edx (RECOMMEND.);  =255 save all reg; see .doc if there are any error
  FS.ReplFunc:=fl_Yes;{.193}
  FS.Set_ID:=0;
  FS.Id_Func:=0;
  FS.AdrDeriv:=nil;
  FS.NDeriv:=0;
end;




procedure TForm1.SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);

end;



function _IsNan(AValue: Extended): Extended; stdcall;
type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;
  PExtended = ^TExtented;
var
  BResult: Boolean;
begin
  BResult := ((TExtented(AValue).Exponent and $7FFF)  = $7FFF) and
            ((TExtented(AValue).Mantissa and $7FFFFFFFFFFFFFFF) <> 0);

  if BResult = True then Result:=1 else Result:=0;

end;




procedure _MoveTo(X,Y: Integer);  stdcall;
begin
 btm.canvas.MoveTo(X,Y);
end;




procedure _LineTo(X,Y: Integer);  stdcall;
begin
 btm.canvas.LineTo(X,Y);
end;


procedure {TForm1.}SetPixelRGB(Adr: Cardinal); stdcall;
var
cc: TColor;
k: Cardinal;
begin
   btm.canvas.Pixels[PInteger(Adr)^,PInteger(Adr+16)^]:=rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^);

    //Windows.SetPixel(HGD,PInteger(Adr)^,PInteger(Adr+16)^,rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^));
   //Form1.image1.Canvas.Pixels[PInteger(Adr)^,PInteger(Adr+16)^]:=rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^);
end;


procedure _SetPenColor(R,G,B: Integer);  stdcall;
begin
 btm.canvas.Pen.Color:=rgb(R,G,B) ;
end;


procedure _SetPenWidth(W: Integer);   stdcall;
begin
 btm.canvas.Pen.Width:=W;
end;



procedure _SetPenStyle(S: Integer);   stdcall;
begin
 case S of
   1:  btm.canvas.Pen.Style:=psSolid;
   2:  btm.canvas.Pen.Style:=psDash;
   3:  btm.canvas.Pen.Style:=psDot;
   4:  btm.canvas.Pen.Style:=psDashDot;
   5:  btm.canvas.Pen.Style:=psDashDotDot;
 end;
end;



procedure _SetCanvasColor(R,G,B: Integer);  stdcall;
begin

 btm.Canvas.Brush.Color := RGB(R,G,B);
 btm.Canvas.Rectangle(0,0,  btm.Width, btm.Height);

end;




procedure _SetPointSize(W: Integer);   stdcall;
begin
 G2d_PointSize:=W;
end;



procedure _SetPointColor(R,G,B: Integer);   stdcall;
begin
 G2d_PointColor:=RGB(R,G,B);
{
 G2d_PointColor.R:=R;
 G2d_PointColor.G:=G;
 G2d_PointColor.B:=B;
 }
end;



procedure _SetPointW(X,Y: Integer);   stdcall;
begin
 btm.canvas.Pen.Color := G2d_PointColor;//rgb(G2d_PointColor.R,G2d_PointColor.G,G2d_PointColor.B);
 btm.canvas.Pen.Style := psSolid;
 btm.canvas.Brush.Color:=G2d_PointColor;// rgb(G2d_PointColor.R,G2d_PointColor.G,G2d_PointColor.B);
 btm.canvas.Brush.Style := bsSolid;
 btm.canvas.Pen.Width := 1;
 btm.canvas.Ellipse(X - G2d_PointSize, Y - G2d_PointSize, X + G2d_PointSize, Y + G2d_PointSize);

 ShowImage;
end;





procedure _SetPoint(X,Y: Extended; ShowImg: Integer);   stdcall;
var
Xw,Yw,YWmax: integer;
begin

YWmax:=Form1.Image1.Height;


 yw:=Trunc(((Y-Form1.Ymin)/(abs(Form1.Ymax-Form1.Ymin)/Form1.Image1.Height)));
 xw:=Trunc(((X-Form1.Xmin)/(abs(Form1.Xmax-Form1.Xmin)/Form1.Image1.Width)));

 btm.canvas.Pen.Color := G2d_PointColor;//rgb(G2d_PointColor.R,G2d_PointColor.G,G2d_PointColor.B);
 btm.canvas.Pen.Style := psSolid;
 btm.canvas.Brush.Color:=G2d_PointColor;// rgb(G2d_PointColor.R,G2d_PointColor.G,G2d_PointColor.B);
 btm.canvas.Brush.Style := bsSolid;
 btm.canvas.Pen.Width := 1;
 btm.canvas.Ellipse(Xw - G2d_PointSize,YWmax-(Yw-G2d_PointSize), Xw + G2d_PointSize, YWmax-(Yw + G2d_PointSize));

 {
 btm.canvas.Pen.Color := G2d_PointColor;//rgb(G2d_PointColor.R,G2d_PointColor.G,G2d_PointColor.B);
 btm.canvas.Pen.Style := psSolid;
 btm.canvas.Pen.Width := 1;
 }


//COORD
  {
btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clGreen;


//yw:=Trunc((0-YGF_min)*Hky);

btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);


//xw:=Trunc((0-XGF_min)*Hkx);

btm.canvas.MoveTo(xw,0);
btm.canvas.LineTo(xw,YWmax);
}
    {
 btm.canvas.MoveTo(Xw,YWmax-Yw);
 btm.canvas.LineTo(Xw,YWmax-(YW+G2d_PointSize));
 btm.canvas.MoveTo(Xw,YWmax-Yw);
 btm.canvas.LineTo(Xw,YWmax-(YW-G2d_PointSize));

 btm.canvas.MoveTo(Xw,YWmax-Yw);
 btm.canvas.LineTo(Xw+G2d_PointSize,YWmax-YW);
 btm.canvas.MoveTo(Xw,YWmax-Yw);
 btm.canvas.LineTo(Xw-G2d_PointSize,YWmax-YW);
   }
 {
 btm.canvas.MoveTo(Xw,Yw);
 btm.canvas.LineTo(Xw,YW+G2d_PointSize);
 btm.canvas.LineTo(Xw,YW-G2d_PointSize);
 }

 // btm.canvas.Pixels[Xw,Yw]:=G2d_PointColor;
 {
 btm.canvas.Pen.Width:=1;
 btm.canvas.Pen.Style:=psSolid;
 btm.canvas.Pen.Color:=clWhite;
 }

//XWmax:=Form1.Image1.Width;
//YWmax:=Form1.Image1.Height;

{
btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);
}
 //btm.canvas.MoveTo(0,Form1.Image1.Width-yw);
 //btm.canvas.LineTo(Form1.Image1.Width,Form1.Image1.Height-yw);

if ShowImg <> 0 then
   Form1.Image1.picture.Bitmap.Assign(btm);

 //ShowImage;
end;




function _TestFX: Extended; stdcall;
begin
  _TestFX:=sin(Form1.XF);
end;



procedure {TForm1.}SetPixel(Adr: Cardinal);
  stdcall;
var
cc: TColor;
k: Cardinal;
begin
   btm.canvas.Pixels[PInteger(Adr)^,PInteger(Adr+16)^]:=PCardinal(Adr+32)^;

    //Windows.SetPixel(HGD,PInteger(Adr)^,PInteger(Adr+16)^,rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^));
   //Form1.image1.Canvas.Pixels[PInteger(Adr)^,PInteger(Adr+16)^]:=rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^);
end;


procedure {TForm1.}BackGround(Adr: Cardinal);
  stdcall;
var
cc: TColor;
k: Cardinal;
begin
   //btm.canvas.Pixels[PInteger(Adr)^,PInteger(Adr+16)^]:=rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^);

    btm.Canvas.Brush.Color := RGB(PCardinal(Adr)^,PCardinal(Adr+16)^,PCardinal(Adr+32)^);
    btm.Canvas.Rectangle(0,0,  btm.Width, btm.Height);//заливка фона
    //Windows.SetPixel(HGD,PInteger(Adr)^,PInteger(Adr+16)^,rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^));
   //Form1.image1.Canvas.Pixels[PInteger(Adr)^,PInteger(Adr+16)^]:=rgb(PCardinal(Adr+32)^, PCardinal(Adr+48)^, PCardinal(Adr+64)^);
end;




procedure {TForm1.}ShowVar(Adr: Cardinal);  stdcall;
var

k: Cardinal;
x,y,r: double;
begin
x:=PDouble(Adr)^; y:=PDouble(adr+16)^;  k:=PInteger(adr+32)^;  r:=PDouble(adr+48)^;

//showMessage(FloatToStr(x)+'   '+floatToStr(y)+'i');
showMessage(FloatToStr(x)+'   '+FloatToStr(y)+'i'+'  k:'+IntToStr(k)+'  r:'+FloatToStr(r));
  {k:=PCardinal(Adr+32)^;
  if k < 290 then
  begin
    showMessage(IntToStr(k));
  end; }





end;



procedure {TForm1.}ShowVar1Ex(Adr: Cardinal);  stdcall;
var

k: Cardinal;
x: Extended;
begin
x:=PExtended(Adr)^;

//showMessage(FloatToStr(x)+'   '+floatToStr(y)+'i');
 ShowMessage(FloatToStr(x));
  {k:=PCardinal(Adr+32)^;
  if k < 290 then
  begin
    showMessage(IntToStr(k));
  end; }


end;




procedure PrintArray(VE: TArrayE);  stdcall;
var
 k,L,H: Integer;
 LC: Cardinal;
begin
 //Correct length of FPC array. Only  if .exe compiled in Delphi:
   //LC:=Length(VE);
   //if (DllCmpl = FPCdll) and (LC > 0) then LC:=LC+1;    //FPC

  flGet(fl_ARRAY_LENGTH,  Cardinal(@VE),  LC);

 for k := 0 to LC-1 do
 begin
   Form1.MFRC.Lines.Add(FloatToStrF(VE[k], ffGeneral, 20, 4, G_FMT));
 end;

end;




procedure PrintArrays(VX,VF: TArrayE);  stdcall;
var
 k,L: Integer;
 LC: Cardinal;
begin
//Correct length of FPC array. Only  if .exe compiled in Delphi:
   // L:=Length(VX);
   // if (DllCmpl = FPCdll) and (L > 0) then L:=L+1;    //FPC

    flGet(fl_ARRAY_LENGTH,  Cardinal(@VX),  LC);


 for k := 0 to LC-1 do
 begin
   //Form1.MFRC.Lines.Add(FloatToStr(VX[k])+'; F(x)= '+FloatToStr(VF[k]));
   Form1.MFRC.Lines.Add(FloatToStrF(VX[k], ffGeneral, 20, 4, G_FMT) +';    F(x)= '+FloatToStrF(VF[k], ffGeneral, 20, 4, G_FMT));

 end;

end;






procedure PrintReal(Val: Extended);  stdcall;
begin
   Form1.MFRC.Lines.Add(FloatToStrF(Val, ffGeneral, 20, 4, G_FMT));
end;




procedure PrintInteger(Val: Integer);  stdcall;
begin
   Form1.MFRC.Lines.Add(IntToStr(Val));
end;


procedure PrintComplex(z: TComplexE);  stdcall;
begin
   //Form1.MFRC.Lines.Add(FloatToStr(z.re)+'    '+FloatToStr(z.im)+'i');
   Form1.MFRC.Lines.Add(FloatToStrF(z.re, ffGeneral, 20, 4, G_FMT)+'    '+FloatToStrF(z.im, ffGeneral, 20, 4, G_FMT)+'i');

end;




procedure ClearPrint;  stdcall;
var
 k: Cardinal;
begin
{
 for k :=  Form1.N_EndProg to Form1.MFRC.Lines.Capacity-1 do
 begin
   Form1.MFRC.Lines.Delete(k+1);
 end;
 }

 for k :=  Form1.MFRC.Lines.Capacity-1   downto  Form1.N_EndProg  do
 begin
   Form1.MFRC.Lines.Delete(k+1);
 end;
end;






procedure PrintAstrsk;  stdcall;
var
 k: Cardinal;
begin

  Form1.MFRC.Lines.Add('********************************************************');

end;



{
procedure ShowImage(adr,len: Cardinal); stdcall;
begin
 Form1.image1.picture.Bitmap.Assign(btm);
end;
}

procedure ShowImage; stdcall;
begin
 Form1.image1.picture.Bitmap.Assign(btm);
end;



procedure SwapBuff; stdcall;
begin
 //Form1.PFLD.picture.Bitmap.Assign(btm);
 SwapBuffers(DC);
end;

//http://docwiki.embarcadero.com/RADStudio/XE7/en/Floating-Point_Number_Control_Routines
procedure MaskException;
var
Mem: Cardinal;
begin

asm
    {
    push ebp;
    fstcw [ebp];
    or word ptr [ebp], 003Fh;
    fldcw [ebp];
    //add esp, 4
    pop ebp
    }
   // push  eax
   // lea eax, M
    //push eax;
    //fclex
   // cli

    sub esp,4
    fnstcw [esp];
    or word ptr [esp], 003Fh;
    fnclex
    fldcw [esp];
    add esp, 4


   //fninit
end;

//SetExceptionMask([exInvalidOp]+[exUnderFlow]+[exDenormalized]+ [exZeroDivide] +[exOverflow]+ [exUnderflow] +[exPrecision]);
end;

procedure IfException;
var
Mem: Cardinal;
begin
asm

    push eax
    xor  eax,eax


    fnstsw ax
    sahf
    test ax, 001Fh
    fldz
    jz @@Z
    fstp st(0)
    fld1
    @@Z:
    pop eax
    fnclex
    //sti
   //finit
end;

end;



function _IfException: extended;
var
Mem: Cardinal;
begin
asm

    push eax
    xor  eax,eax


    fnstsw ax
    sahf
    test ax, 001Fh
    fldz
    jz @@Z
    fstp st(0)
    fld1
    @@Z:
    pop eax
    fnclex
    //sti
   //finit
   fstp @Result
end;

end;



function  _ResultSafeE(Addr: Pointer; var Res: Extended): extended;  {HRESULT;  }   stdcall;
begin
try
 Result:=0;
 asm
    push eax
    call Addr
    mov eax, [Res]
    fstp tbyte ptr [eax]
    pop eax
 end;
except
   // on E: Exception do   Result:=1;//fl_COMMON_CALCULATON_ERROR;
    on E: EZeroDivide      do Result:=fl_ZERO_DIVIDE;
    on E: EInvalidOp       do Result:=fl_INVALID_OPERATION;
    on E: EOverFlow        do Result:=fl_OVERFLOW;
    on E: EACCESSVIOLATION do Result:=fl_ACCESS_VIOLATION;
    on E: EStackOverFlow   do Result:=fl_STACK_OVERFLOW;
    else                      Result:=fl_COMMON_CALCULATON_ERROR;

end;

end;



 {
function  _ResultSafeE(Addr: Pointer; var Res: Extended): extended; stdcall;
begin
  _ResultSafeE:=ResultSafeE(Addr,Res);
end;

 }




function  infoVE(ve: TArrayE; L: Integer):extended;  stdcall
var
  k: Integer;
  S:extended;
begin
 S:=0;
 for k := 0 to L-1 do
 begin
  S:=S+ve[k];
 end;
  infoVE:=S;
end;




procedure _VoidP(x:extended);   stdcall;
var
xx: extended;
begin
 xx:=x;
end;



function _Floor(X: Extended): Extended; stdcall;
var
 RI: Integer;
begin
 RI := Trunc(X);
 if Frac(X) < 0 then Dec(RI);

 _Floor:=RI;
end;




procedure _Sort(var VE: TArrayE);   stdcall;
var

i,len,l,r,c:integer;
bf,s: extended;
begin

len:=Length(ve);

c:=0; s:= 0; i:= 0; l:=0; r:=len-1; bf:=0;


while l < r do
begin
     for i := l to r-1 do
     begin
        if ve[i] > ve[i+1] then
        begin
         bf := ve[i];
         ve[i] := ve[i+1];
         ve[i+1] := bf;
        end;
     end;

     dec(r);

     for i := r downto l+1 do
     begin
        if ve[i] < ve[i-1] then
        begin
         bf := ve[i];
         ve[i] := ve[i-1];
         ve[i-1] := bf;
        end;
     end;

     inc(l);

end;


end;


function _TryCalc(Addr: Pointer; var Res: Extended): HRESULT;  stdcall;

type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;

var

   BResult: Boolean;
  _Result: Integer;

begin
try
 _Result:=0;
 asm
    push eax
    call Addr
    mov eax, [Res]
    fstp tbyte ptr [eax]
    pop eax
 end;
except
    //on E: Exception do   Result:=fl_COMMON_CALCULATON_ERROR;
    on E: EZeroDivide      do _Result:=fl_ZERO_DIVIDE;
    on E: EInvalidOp       do _Result:=fl_INVALID_OPERATION;
    on E: EOverFlow        do _Result:=fl_OVERFLOW;
    on E: EACCESSVIOLATION do _Result:=fl_ACCESS_VIOLATION;
    on E: EStackOverFlow   do _Result:=fl_STACK_OVERFLOW;
    on E: EOutOfMemory     do _Result:=fl_OUT_OF_MEMORY;
    else                      _Result:=fl_COMMON_CALCULATON_ERROR;

end;

if _Result = 0 then
begin
     BResult := ((TExtented(Res).Exponent and $7FFF)  = $7FFF) and
            ((TExtented(Res).Mantissa and $7FFFFFFFFFFFFFFF) <> 0);

     if BResult = True then _Result:=fl_INVALID_OPERATION;
end;

_TryCalc:=_Result;

end;

//ввестит min(vec,val,num), max(vec,val,num) num-номер max/min val
procedure _DelFalseCloseRoot(AddrF: Pointer; RootTmp: TArrayE; var RootF: TArrayE);  stdcall;
label nxtr;
var
 x1,x2,xr,f1,f2,dist12,dnst,h,MaxF12,MinF,fr:Extended;
 cr1,cr2,Len,N,crn,minn,k: Integer;
 BHigh: Boolean;
 FX:TArrayE;

begin

//_Sort(RootTmp);

  dnst:=700;
  BHigh:=False;
  crn:=0;
  Len:=Length(RootTmp);
  SetLength(RootF,0);

  SetLength(FX,Length(RootTmp));

  for cr1:=0 to Len-2 do
  begin

    x1:=RootTmp[cr1]; x2:=RootTmp[cr1+1];
    dist12:=abs(x2-x1);
    Form1.XF:=x1; if _TryCalc(AddrF,f1) > 0 then goto nxtr;
    Form1.XF:=x2; if _TryCalc(AddrF,f2) > 0 then goto nxtr;

    if abs(f1) > abs(f2) then MaxF12:=abs(f1) else MaxF12:=abs(f2);
    N:=Trunc(dist12*dnst)+1; h:=dist12/N;

    FX[cr1]:=f1;

    for cr2 := 0 to N do
    begin
      xr:=x1+h*cr2;
      Form1.XF:=xr; if _TryCalc(AddrF,fr) > 0 then goto nxtr;

      if fr > MaxF12 then
      begin
        BHigh:=True;
        goto nxtr;
      end;
    end;

    nxtr:
    //если есть превышение порога MaxF на сканируемом отрезке и число корней на этом отрезке > 2
    if (BHigh = True) and (cr1-crn > 1) then  //some serials same roots
    begin
       //if abs(f1) > abs(f2) then Root[cr1]:=Root[cr2];  else MaxF12:=abs(f2);

       MinF:=FX[crn]; minn:=crn;
       for k := crn+1 to cr1 do
       begin
         if MinF > FX[k] then
         begin
           MinF:=FX[k]; minn:=k;
         end;
       end;

       SetLength(RootF,Length(RootF)+1);
       RootF[High(RootF)]:=RootTmp[minn];

       crn:=cr1+1;
       BHigh:=False;

    end
    else
    begin
       crn:=cr1+1;
       BHigh:=False;
       SetLength(RootF,Length(RootF)+1);
       RootF[High(RootF)]:=RootTmp[cr1];
    end;



  end;
end;






procedure TForm1.FormCreate(Sender: TObject);
var
FS:TAddFuncStruct;
VT: TArrayC;
S1,S2: String;
idfP: TidFunc;
begin
{$IFDEF STRING}       flSet(fl_STRING_TYPE,fl_STRING,0);     {$ENDIF}
{$IFDEF ANSISTRING}   flSet(fl_STRING_TYPE,fl_ANSISTRING,0);   {$ENDIF}
{$IFDEF WIDESTRING}   flSet(fl_STRING_TYPE,fl_WIDESTRING,0);    {$ENDIF}
{$IFDEF PANSICHAR}    flSet(fl_STRING_TYPE,fl_ANSISTRING,0);   {$ENDIF}
{$IFDEF UTF8}         flSet(fl_String_Type,fl_String_UTF8,0);   {$ENDIF}

GetLocaleFormatSettings(0,G_FMT);
G_FMT.DecimalSeparator:='.';
NSc:=1;

//flSet(fl_COMPILER_TYPE_EXE, fl_DELPHI, 0);

//flSet(fl_Enable,fl_CHECK_INCORRECT_SPACE,0);
//flSet(fl_Disable,fl_CALC_CONST_EXPR_IN_MULTI_EXPR,0);

//flSet(fl_Disable,fl_CALC_CONST_ARG,0);
//flSet(fl_Disable,fl_CALC_CONST_FUNC,0);
//flSet(fl_Disable,fl_INTEGER_OPTIMIZATION,0);
//flSet(fl_Disable,fl_CALC_CONST_EXT_FUNC,0);

Set8087CW($1372);


ISize:=strtoint(combobox2.text);

//flSet(fl_Enable,fl_Show_Exception,0);

//flSetVar('zf',@zf,fl_Complex_Double);
//flSetVar('c0',@c0,fl_Complex_Double);
//flSetVar('x0',@fx,fl_Real_Double);
//flSetVar('y0',@fy,fl_Real_Double);
flSetVar('Iterations',@NIter,fl_Real_Integer);
flSetVar('ImageSize',@ISize,fl_Real_Integer);
flSetVar('itr',@itr,fl_Real_Integer);
//flSetVar('fz',@FZd,fl_Complex_Double);


flSetVar('y',@YF,fl_Real_Extended);
flSetVar('t',@TF,fl_Real_Extended);
flSetVar('a',@AF,fl_Real_Extended);
flSetVar('b',@BF,fl_Real_Extended);
flSetVar('c',@CF,fl_Real_Extended);
flSetVar('z1',@Z1e,fl_Complex_Extended);
flSetVar('z2',@Z2e,fl_Complex_Extended);
flSetVar('z3',@Z3e,fl_Complex_Extended);

flSetVar('x',@XF,fl_Real_Extended);
flSetVar('xf',@XF,fl_Real_Extended);
flSetVar('z',@Ze,fl_Complex_Extended);
flSetVar('fz',@ResultCx,fl_Complex_Extended);
flSetVar('ResultCx',@ResultCx,fl_Complex_Extended);
flSetVar('fx',@ResultCx.re,fl_Real_Extended);
flSetVar('ResultR',@ResultCx.re,fl_Real_Extended);


flSetVar('zt',@zt,fl_Complex_Extended);


flSetVar('G_Xmin',@Xmin,fl_Real_Extended);
flSetVar('G_Xmax',@Xmax,fl_Real_Extended);
flSetVar('G_Ymin',@Ymin,fl_Real_Extended);
flSetVar('G_Ymax',@Ymax,fl_Real_Extended);

flSetVar('Xmin',@Xmin,fl_Real_Extended);
flSetVar('Xmax',@Xmax,fl_Real_Extended);
flSetVar('Ymin',@Ymin,fl_Real_Extended);
flSetVar('Ymax',@Ymax,fl_Real_Extended);

flSetVar('FourierXmin',@FourierXmin,fl_Real_Extended);
flSetVar('FourierXmax',@FourierXmax,fl_Real_Extended);
flSetVar('N_Harmonics',@N_Harmonics,fl_Real_Integer);
flSetVar('N_Integral', @N_Integral, fl_Real_Integer);
flSetVar('P_Integral', @P_Integral, fl_Real_Integer);
flSetVar('P_IntegralInit', @P_IntegralInit, fl_Real_Integer);
flSetVar('F_FixFourierInterval', @FI_FixFourierInterval, fl_Real_Integer);

flSetVar('an',@Aint,fl_Array_Real_Extended);
flSetVar('bn',@Bint,fl_Array_Real_Extended);



KDens:=700;
flSetVar('KDens',@KDens,fl_Real_Integer);


{
flSetVar('Xmin',@x1,fl_Real_Double);
flSetVar('Xmax',@x2,fl_Real_Double);
flSetVar('Ymin',@y1,fl_Real_Double);
flSetVar('Ymax',@y2,fl_Real_Double);
}

InitFuncStruct(FS);
FS.addr:=@SetPixelRGB;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPixelRGB',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@SetPixel;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPixel',@FS,@idfP);

 {
InitFuncStruct(FS);
FS.addr:=@_IsNaN;
FS.ArgType:=fl_Real_Extended;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
flSetFunction('IsNaN',@FS,@idfP);
 }


InitFuncStruct(FS);
FS.addr:=@_MoveTo;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('MoveTo',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@_LineTo;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('LineTo',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@_SetPenColor;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPenColor',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@_SetPointColor;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPointColor',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@_SetCanvasColor;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetCanvasColor',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@_SetPenWidth;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPenWidth',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@_SetPenStyle;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPenStyle',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@_SetPointSize;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPointSize',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@_SetPointW;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPointW',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@_SetPoint;
FS.ArgType:=fl_Differ;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=fl_Real_Extended; VT[1]:=fl_Real_Extended; VT[2]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('SetPoint',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@_DrawGraph2D;
FS.ArgType:=fl_Differ;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=fl_Pointer; VT[1]:=fl_Pointer; VT[2]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=8;
FS.ResultType:=fl_None;
flSetFunction('DrawGraph2D',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@_TestFX;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('TestFX',@FS,@idfP);



//Err:int=ResultF(@Func,@res)
InitFuncStruct(FS);
FS.addr:=@_ResultSafeE;
FS.Arg:=2;
FS.ArgType:=fl_Pointer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=8;
FS.ResultType:=fl_Real;
flSetFunction('ResultSafeR',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@ShowVar1Ex;
FS.ArgType:=fl_Real_Extended;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('ShowVar1',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintArray;
FS.ArgType:=fl_ARRAY_REAL_EXTENDED;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('Print',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@PrintReal;
FS.ArgType:=fl_REAL_EXTENDED;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('Print',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintInteger;
FS.ArgType:=fl_REAL_INTEGER;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('Print',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintComplex;
FS.ArgType:=fl_COMPLEX_EXTENDED;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('Print',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@PrintArrays;
FS.ArgType:=fl_ARRAY_REAL_EXTENDED;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('Print',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@ClearPrint;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
flSetFunction('ClearPrint',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintAstrsk;
FS.ArgType:=fl_ARRAY_REAL_EXTENDED;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('PrintAstrsk',@FS,@idfP);

 {
InitFuncStruct(FS);
FS.addr:=@ShowImage;
FS.ArgType:=fl_real_integer;
FS.CallFunc:=fl_INFINITE;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_none;
FS.DeepFPU:=2;
flSetFunction('ShowImage',@FS);
}
InitFuncStruct(FS);
FS.addr:=@ShowImage;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_none;
FS.DeepFPU:=2;
flSetFunction('ShowImage',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@BackGround;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('BackGround',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@SwapBuff;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_none;
FS.DeepFPU:=0;
flSetFunction('SwapBuffers',@FS,@idfP);

  
InitFuncStruct(FS);
FS.addr:=@MaskException;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_none;
FS.DeepFPU:=0;
flSetFunction('MaskExceptionFPU',@FS,@idfP);
flAddNameFunction(idfP.idName,'MaskException');

InitFuncStruct(FS);
FS.addr:=@IfException;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_real;
FS.DeepFPU:=1;
flSetFunction('ExceptionFPU',@FS,@idfP);
flAddNameFunction(idfP.idName,'ifException');
     


InitFuncStruct(FS);
FS.addr:=@glColor3d;
FS.ArgType:=fl_Real_Double;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('glColor3d',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@glVertex2d;
FS.ArgType:=fl_Real_Double;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('glVertex2d',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@glColor3f;
FS.ArgType:=fl_Real_Single;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('glColor3f',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@glVertex2f;
FS.ArgType:=fl_Real_Single;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('glVertex2f',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@glBegin;
FS.ArgType:=fl_Real_Integer;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('glBegin',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@glEnd;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('glEnd',@FS,@idfP);



  //***debug

InitFuncStruct(FS);
FS.addr:=@ShowVar;
SetLength(VT,4);
VT[0]:=fl_real_Double; VT[1]:=fl_real_double; VT[2]:=fl_real_integer; VT[3]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
//FS.ArgType:=fl_Real_Double;
FS.Arg:=4;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('ShowVar',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@InfoVE;
SetLength(VT,2);
VT[0]:=fl_array_real_Extended;  VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('infove',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@_DelFalseCloseRoot;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=fl_Pointer; VT[1]:=fl_array_real_Extended;  VT[2]:=fl_Pointer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_None;
flSetFunction('DelFalseCloseRoot',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@_Sort;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_Pointer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_None;
flSetFunction('SortArray',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@_VoidP;
FS.Arg:=1;
FS.ArgType:=fl_Real_Extended;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
flSetFunction('VoidP',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@_Floor;
FS.ArgType:=fl_Real_Extended;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
flSetFunction('floor',@FS,@idfP);



//****************






  Xmin:=-1.5;
  Xmax:=1.5;
  Ymin:=-1.5;
  Ymax:=1.5;

 edit1.Text:=FloatToStrF(Xmin, ffGeneral, 20, 4, G_FMT);
 edit2.Text:=floattostrF(Xmax,ffGeneral, 20, 4, G_FMT);
 edit3.Text:=floattostrF(Ymin,ffGeneral, 20, 4, G_FMT);
 edit4.Text:=floattostrF(Ymax,ffGeneral, 20, 4, G_FMT);

PFLD.Width:=strtoint(combobox2.text);
PFLD.height:=strtoint(combobox2.text);

image1.Width:=strtoint(combobox2.text);
image1.height:=strtoint(combobox2.text);

F_AutoReDraw := False;


btm:=Tbitmap.create;
CreateOpenGLHandle;

PenWidth:=1;
PenStyle:=psSolid;
PenColor:=clBlue;


{
HGD:=Form1.PFLD.Handle;

 hnd:=PFLD.Handle;
 DC := GetDC (hnd);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 glViewPort (0, 0, PFLD.ClientHeight, PFLD.ClientHeight);

 glDisable(GL_DEPTH_TEST);
 glDisable(GL_LIGHTING);
 glClearColor (0.75, 0.75, 0.75, 1.0);
 glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
 glPointSize(1);
}
RB_FractalClick(Self);

ShowLibData;

//flSet(fl_SPEC_FUNC, fl_ACCURATE,0);
 InitIntegral;
 N_Harmonics:=30; //число гармоник Фурье
 F_FixFourierInterval:=False;
 FI_FixFourierInterval:=0;

 //   Temp test
 F_BTest1:=True;

//  flSet(fl_Disable,fl_Optimization,0);
end;




procedure TForm1.CreateOpenGLHandle;
begin

  HGD:=Form1.PFLD.Handle;

 hnd:=PFLD.Handle;
 DC := GetDC (hnd);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 glViewPort (0, 0, PFLD.ClientHeight, PFLD.ClientHeight);

 glDisable(GL_DEPTH_TEST);
 glDisable(GL_LIGHTING);
 glClearColor (0.75, 0.75, 0.75, 1.0);
 glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
 glPointSize(1);


end;



procedure TForm1.ShowLibData;
var
 ID: Cardinal;
 S: String;
begin

flGet(fl_Version,fl_Major,ID);    S:=IntToStr(ID);
flGet(fl_Version,fl_Minor,ID);    S:=S+'.'+IntToStr(ID);
flGet(fl_Version,fl_Release,ID);  S:=S+'.'+IntToStr(ID);
flGet(fl_Version,fl_Build,ID);    S:=S+'.'+IntToStr(ID);

Form1.Caption:='Complex visual.   Engine by Foreval.dll   (v.'+S+')';
flGet(fl_Compiled_by,0,ID);




if ID >= 100 then
begin
 DllCmpl:=FPCdll;   //FPC
 Form1.Caption:=Form1.Caption+'.  Compiled by FPC v.' + IntToStr(ID)
end
else
begin
case  ID of
  15: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi7';
  16: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi8';
  17: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi2005';
  18: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi2006';
  19: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi2007';
  20: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 2009';
  21: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 2010';
  22: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE';
  23: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE2';
  24: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE3';
  25: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE4';
  26: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE5';
  27: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE6';
  28: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE7';
  29: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi XE8';
  else Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10+';

  DllCmpl:=Delphidll;  //Delphi
end;

end;


(*
{$IFDEF USEDLL}
  flGet(fl_COMMENT,0,ID);
  ConvStr(Pointer(ID),S1);
  Form1.Caption:=Form1.Caption+'    '+S1;
{$ENDIF}
*)

end;



procedure TForm1.FormDestroy(Sender: TObject);
begin
 btm.Destroy;
end;


procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var
resXxx, resYyy: extended;

begin

if Gr_Mode <> _ComplexDynDraw then
begin
  ImageMouse := True;
  ImageRect.Left := X;
  ImageRect.Top  := Y;
  ImageRect.Right := X;
  ImageRect.Bottom  := Y;
  Image1.Canvas.DrawFocusRect(ImageRect);

  Ymin:=StrTofloat(Edit3.text,G_FMT);
  Ymax:=StrTofloat(Edit4.text,G_FMT);
  Xmin:=StrTofloat(Edit1.text,G_FMT);
  Xmax:=StrTofloat(Edit2.text,G_FMT);



  if (Xmin<0) and (Xmax>0) then tgx:=abs(Xmin)+abs(Xmax);
  if (Xmin<0) and (Xmax<0) then tgx:=abs(Xmin)-abs(Xmax);
  if (Xmin>0) and (Xmax>0) then tgx:=Xmax-Xmin;
  if (Ymin<0) and (Ymax>0) then tgy:=abs(Ymin)+abs(Ymax);
  if (Ymin<0) and (Ymax<0) then tgy:=abs(Ymin)-abs(Ymax);
  if (Ymin>0) and (Ymax>0) then tgy:=Ymax-Ymin;



  resXxx:=Xmin+(tgx / image1.width)*X;
  resYyy:=Ymin+(tgy / image1.height)*Y;

  if (Gr_Mode = _Graph2DDraw) or (Gr_Mode =  _Graph2DFourier) then
  begin
    //resYyy:=-resYyy;
    resYyy:=Ymax-(tgy / image1.height)*Y;
  end;


  edit1.Text:=FloatToStr(resxxx,G_FMT);
  edit3.Text:=FloatToStr(resYYY,G_FMT);

end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);

begin
if Gr_Mode <> _ComplexDynDraw then
begin
if ImageMouse then
If (X > ImageRect.Left) AND (Y > ImageRect.Top) then  begin
 {Восстанавливаем фон}
 Image1.Canvas.DrawFocusRect(ImageRect);
 {Меняем прямоугольник}
 ImageRect.Right := X;
 ImageRect.Bottom := Y;
 {Рисуем прямоугольник фокуса}
 Image1.Canvas.DrawFocusRect(ImageRect);
end;
end;

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    var
    resX, resY, rYmin,rYmax,tf: extended;

begin

if Gr_Mode <> _ComplexDynDraw then
begin
 if ImageMouse then
 begin
  ImageRect.Right := X;
  ImageRect.Bottom := Y;
  Image1.Canvas.DrawFocusRect(ImageRect);
  ImageMouse := False;
  Image1.Canvas.CopyRect(Image1.Canvas.ClipRect, Image1.Canvas,ImageRect);


   Ymax:=StrTofloat(Edit4.text,G_FMT);
   Xmax:=StrTofloat(Edit2.text,G_FMT);

  if (Xmin<0) and (Xmax>0) then tgx:=abs(Xmin)+abs(Xmax);
  if (Xmin<0) and (Xmax<0) then tgx:=abs(Xmin)-abs(Xmax);
  if (Xmin>0) and (Xmax>0) then tgx:=Xmax-Xmin;
  if (Ymin<0) and (Ymax>0) then tgy:=abs(Ymin)+abs(Ymax);
  if (Ymin<0) and (Ymax<0) then tgy:=abs(Ymin)-abs(Ymax);
  if (Ymin>0) and (Ymax>0) then tgy:=Ymax-Ymin;
  if (Ymin>0) and (Ymax>0) then tgy:=Ymax-Ymin;

  resX:=Xmin+(tgx / image1.width)*X;
  resY:=Ymin+(tgy / image1.height)*Y;


  edit2.Text:=FloatToStr(resx,G_FMT);
  edit4.Text:=FloatToStr(resY,G_FMT);

  if (Gr_Mode = _Graph2DDraw) or (Gr_Mode =  _Graph2DFourier) then
  begin

     rYmax:=Ymax-(tgy / image1.height)*Y;
     rYMin:=StrToFloat(edit3.Text,G_FMT);

     if rYmin > rYmax  then
     begin
        tf:=rYmax;
        rYmax:=rYmin;
        rYmin:=tf;
        edit3.Text:=FloatToStr(rYmin,G_FMT);
     end;
    { rYmin:=StrToFloat(edit3.Text,G_FMT);
    //rYmax:=StrToFloat(edit4.Text,G_FMT);
    tf:=rYmin;
    rYmin:=-rYmax;
    rYmax:=tf;  }

    //edit3.Text:=FloatToStr(rYmin,G_FMT);
     edit4.Text:=FloatToStr(rYmax,G_FMT);
  end;


 end;

 if F_AutoReDraw = True then BDrawClick(Self);

end;
end;



procedure TForm1.RB_ComplexGraphClick(Sender: TObject);
begin
 Gr_Mode := _ComplexDraw;
 ETF.Text:='(z^2-1)*(z-2-i)^2/(z^2+2+2i)';
 LFG.Caption:='f(z)=';

 flSet(fl_Stack_Type,fl_Extended,0);
 flSetVar('z',@Ze,fl_Complex_Extended);
// flSetVar('fz',@ResultCx,fl_Complex_Extended);

 ES.Text:='3';
 NSc:=3; Sc:=3;

 Edit1.text:='-1.5';
 Edit2.text:='1.5';
 Edit3.text:='-1.5';
 Edit4.text:='1.5';

 //glOrtho(-1, 1, -1, 1, 0, 1);


 {
 ComboBox1.Text:='300';
 ComboBox2.Text:='500';
 ES.Text:='3';
 }
 //BFractal.Enabled:=False;
 //BDraw.Enabled:=True;
end;


procedure TForm1.RB_ComplexDynamicClick(Sender: TObject);
begin
 Gr_Mode := _ComplexDynDraw;
 ETF.Text:='z^3+2*sin(0.1*itr)';
 LFG.Caption:='f(z,itr)=';
 flSet(fl_Stack_Type,fl_Double,0);
 flSetVar('z',@Zd,fl_Complex_Double);
 //flSetVar('fz',@ResultCxD,fl_Complex_Double);

 ES.Text:='2';
 NSc:=2; Sc:=2;

 Edit1.text:='-1.5';
 Edit2.text:='1.5';
 Edit3.text:='-1.5';
 Edit4.text:='1.5';

 //glOrtho(-1, 1, -1, 1, 0, 1);

 {
 ComboBox1.Text:='200';
 ComboBox2.Text:='500';
 ES.Text:='2';
 }
 //BFractal.Enabled:=False;
 //BDraw.Enabled:=True;
end;




procedure TForm1.RB_FractalClick(Sender: TObject);
begin
 Gr_Mode := _Fractal;
 ETF.Text:='z^2-0.55-0.5i';
 LFG.Caption:='z=';
 flSet(fl_Stack_Type,fl_Extended,0);
 flSetVar('z',@Ze,fl_Complex_Extended);
// flSetVar('fz',@ResultCx,fl_Complex_Extended);

 ES.Text:='1';
 NSc:=1; Sc:=1;

 Xmin:=-1.5;  Xmax:=1.5;
 Ymin:=-1.5;  Ymax:=1.5;

   Edit1.text:='-1.5';
   Edit2.text:='1.5';
   Edit3.text:='-1.5';
   Edit4.text:='1.5';

 //glOrtho(-1, 1, -1, 1, 0, 1);


 {
 ComboBox1.Text:='300';
 ComboBox2.Text:='500';
 ES.Text:='1';
 }
 //BDraw.Enabled:=False;
 //BFractal.Enabled:=True;

end;



procedure TForm1.RB_GraphFXClick(Sender: TObject);
begin
 {CreateOpenGLHandle;
 glOrtho(0, PFLD.ClientHeight, 0, PFLD.ClientHeight, 0, 1);
 glClearColor (0.99, 0.99, 0.999999, 1.0);
 glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); }


 Gr_Mode := _Graph2DDraw;
 ETF.Text:='x/(sin(x)-cos(x))^3';
 LFG.Caption:='f(x)=';
 flSet(fl_Stack_Type,fl_Extended,0);


 ES.Text:='1';
 NSc:=1; Sc:=1;

 Xmin:=-10;  Xmax:=10;
 Ymin:=-10;  Ymax:=10;


 Edit1.text:='-10';
 Edit2.text:='10';
 Edit3.text:='-10';
 Edit4.text:='10';

end;




procedure TForm1.RB_FourierClick(Sender: TObject);
begin

 Gr_Mode := _Graph2DFourier;

 //ETF.Text:='asin(cos(x))';
 ETF.Text:='T=5; a=2; a*sign(sin(2*pi*x/T))';
 LFG.Caption:='f(x)=';
 flSet(fl_Stack_Type,fl_Extended,0);


 ES.Text:='1';
 NSc:=1; Sc:=1;

 Xmin:=-10;  Xmax:=10;
 Ymin:=-10;  Ymax:=10;


 Edit1.text:='-10';
 Edit2.text:='10';
 Edit3.text:='-10';
 Edit4.text:='10';
end;



procedure TForm1.GraphFXInitGL;
begin
 Gr_Mode := _Graph2DDraw;
 flSet(fl_Stack_Type,fl_Extended,0);

 glOrtho(0, PFLD.ClientHeight, 0, PFLD.ClientHeight, 0, 1);
 glClearColor (0.99, 0.99, 0.999999, 1.0);
 glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);


 //glEnable(GL_LINE_SMOOTH);
 {
 ES.Text:='1';
 NSc:=1; Sc:=1;

 Xmin:=-10;  Xmax:=10;
 Ymin:=-10;  Ymax:=10;


 Edit1.text:='-10';
 Edit2.text:='10';
 Edit3.text:='-10';
 Edit4.text:='10';  }

end;




procedure DeleteSpace(S: String; var S1: String);
var i: Integer;
begin
{i:=Length(S);

 while i >= 1 do
 begin
    if S[i] = ' ' then
   begin
    Delete(S,i,1);
   end;
  dec(i);
 end;

S1:=Copy(S,1,Length(S));
}
S1:=StringReplace(S,' ','',[rfReplaceAll, rfIgnoreCase]);
S1:=StringReplace(S1,#9,'',[rfReplaceAll, rfIgnoreCase]);
end;



procedure TForm1.BDrawClick(Sender: TObject);
label endp;
var
S: TStringType;
S1,S2,Sl: String;
i,nl: integer;
ans: AnsiString;
WS: WideString;
PAC: PAnsiChar;
Error,rt,Prt: Cardinal;
zres: TComplexE;
FZ1: Pointer;
t1,t2: cardinal;
Attr: TAttrib;
PAttr: Pointer;
begin


ISize:=strtoint(combobox2.text);
NIter:=strtoint(combobox1.text);

image1.Width:=ISize;
image1.height:=ISize;

PFLD.Width:=ISize;
PFLD.height:=ISize;

btm.Height:=ISize;
btm.Width:=ISize;


//Sc:= StrTofloat(ES.text,G_FMT);
Scaling;
Ymin:=StrTofloat(Edit3.text,G_FMT)*Sc;
Ymax:=StrTofloat(Edit4.text,G_FMT)*Sc;
Xmin:=StrTofloat(Edit1.text,G_FMT)*Sc;
Xmax:=StrTofloat(Edit2.text,G_FMT)*Sc;

KDens:=StrToInt(E_Dens.Text);


PenWidth:=1;
PenStyle:=psSolid;
PenColor:=clBlue;


btm.Canvas.Brush.Color := RGB(255,255,255);
btm.Canvas.Rectangle(0,0,  btm.Width, btm.Height);

{
glClear(GL_COLOR_BUFFER_BIT);
glClear(GL_DEPTH_BUFFER_BIT);
glClear(GL_ACCUM_BUFFER_BIT);
glClear(GL_STENCIL_BUFFER_BIT);
 }



///////////////////////////////////////////////////////////////////////////////

(*
S:=ETF.Text;
//S:='res=x^2';
//S:='res=sin(x)*x';

//S:='res=x';
//S:='res=x/sin(x)';
//S:='res=1/sin(x)';
//S:='res=1/(x-3)';
//S:='res=1/sin(1/x)';

//S:='res=1/(cos(x)-sin(x))';
//S:='res=x/sin(1/x)';
 //S:='res=sin(exp(x))';
//  S:='res=1/sin(exp(x))';
//S:='res=tan(x)';
//S:='res=sqrt(x)';
//S:='res=ctg(x)';
//S:='res=gamma(x)';
//S:='res=|x|^|(x*sin(x))|';

 //S:='res=x/(cos(x)-sin(x))^5';

//S:='res=x^sin(x)';

//S:='res=cos(ln(sin(x)*x))';
//S:='res=sqrt(sin(x))';
//S:='res=sin(x)^cos(x)';
//S:='res=x^cos(x)';
//S:='res=asin(cos(x))';
//S:= 'res=root((x+1)^2,3)-root((x-1)^2,3)';
//S:='res=log(x,x)';

//S:='res=log(sin(x),x)';
S:='res=log(x,sin(x))';
//S:='res=log(sin(x),cos(x))';


//S:='res=sin(x)^cos(x)';
Xmin:=-10;  Xmax:=10;
 Ymin:=-10;  Ymax:=10;


    Edit1.text:='-10';
    Edit2.text:='10';
    Edit3.text:='-10';
    Edit4.text:='10';


flSet(fl_RESULT_TYPE, fl_Real,0);

    {$IFDEF PANSICHAR}
       ans:=AnsiString(S); pac:=PAnsiChar(ans);   fzCompile(pac,ZFunc);
    {$ELSE}
       flCompile(S,0,ZFunc);
    {$ENDIF}
flGetErrorCode(Error);


if Error = 0 then
begin
   DrawGraph2D;
end
else
ShowError;

flPerform(fl_FREE,Cardinal(ZFunc));
goto endp;
 *)


/////////////////////////////////////////////////////////////////////////////


//DrawGraph2D_FS; goto  endp;
//Gr_Mode := _Graph2DFourie;


S:=ETF.Text;

// результат возвращается через глобальные переменные
PAttr:=@Attr;

{
if Gr_Mode = _Graph2DDraw then  flSet(fl_RESULT_TYPE, fl_Real,0)
else  flSet(fl_RESULT_TYPE, fl_Complex,0);   }

if Gr_Mode = _Graph2DDraw then
begin       //Real Result
    Attr.MType:=fl_Real_Extended;
    Attr.AddrRE:=@ResultCx.re;
    Attr.AddrIM:=0;
end
else
if Gr_Mode = _Graph2DFourier then
begin
    //PAttr:=0;         //для разнообразия результат возвращается через ST(0)
    Attr.MType:=fl_Real_Extended;
    Attr.AddrRE:=@ResultCx.re;
    Attr.AddrIM:=0;
end
else      //Complex Result
begin
    if Gr_Mode =  _Fractal then
   begin
     Attr.MType:=fl_Complex_Extended;
     Attr.AddrRE:=@Ze.re;
     Attr.AddrIM:=@Ze.im;
   end
   else
   if Gr_Mode = _ComplexDynDraw then
   begin
     Attr.MType:=fl_Complex_Double;
     Attr.AddrRE:=@ResultCxD.re;
     Attr.AddrIM:=@ResultCxD.im;
   end
   else
   if Gr_Mode =  _ComplexDraw then
   begin
     Attr.MType:=fl_Complex_Extended;
     Attr.AddrRE:=@ResultCx.re;
     Attr.AddrIM:=@ResultCx.im;
   end;
end;


    {$IFDEF PANSICHAR}
       ans:=AnsiString(S); pac:=PAnsiChar(ans);   flCompile(pac,@Attr,ZFunc);
    {$ELSE}
       //flCompile(S,@Attr,ZFunc);
       flCompile(S,PAttr,ZFunc);
    {$ENDIF}
flGetErrorCode(Error);

if Error = 0 then
begin



   //CreateFourieCoaff(ZFunc, @xf, Xmin, Xmax);
  // DrawGraph2D_FS;
   //goto  endp;




   if Gr_Mode = _Fractal then
   begin
     t1:=gettickcount;
       DrawFractal ;
     t2:=gettickcount;
   end
   else
   if Gr_Mode = _ComplexDraw then
   begin
      //CreateOpenGLHandle;
      t1:=gettickcount;
        DrawComplex;
      t2:=gettickcount;
   end
   else
   if Gr_Mode = _ComplexDynDraw then
   begin
      //CreateOpenGLHandle;
      t1:=gettickcount;
        DrawDynComplex;
      t2:=gettickcount;
   end
   else
   if Gr_Mode = _Graph2DDraw then
   begin
      //CreateOpenGLHandle;
      //GraphFXInitGL;
      //RB_GraphFXClick(Self);
      t1:=gettickcount;
        DrawGraph2D;
        //DrawGraph2DGL;
      t2:=gettickcount;
   end
   else
   if Gr_Mode = _Graph2DFourier then
   begin
       N_Harmonics:=StrToInt(E_NHarmonics.Text);

      t1:=gettickcount;

       PenWidth:=2;
       PenColor:=rgb(0,235,235);
       _SetCanvasColor(0,0,0);
       DrawGraph2D;


       if F_FixFourierInterval = False   then
       begin
          FourierXmin:=Xmin;
          FourierXmax:=Xmax;
          FI_FixFourierInterval:=0;
       end;
       CreateFourierCoaff(ZFunc, @xf, FourierXmin, FourierXmax);

       PenWidth:=1;
       PenColor:=rgb(255,0,255);
       DrawGraph2DFourier;
      t2:=gettickcount;

       L_FourierInterval.Caption:='[ ' + FloatToStr(FourierXmin) + ' ... ' + FloatToStr(FourierXmax)+' ]';
   end;







     Label7.Caption:=InttoStr(t2-t1);
     if Gr_Mode = _ComplexDynDraw then  L_FPS.Caption:=InttoStr(Trunc(NIter*1000/(t2-t1))) else  L_FPS.Caption:='';

//ShowError;

end
else
ShowError;

flPerform(fl_FREE,Cardinal(ZFunc));

endp:


end;


 (*
procedure TForm1.BFractalClick(Sender: TObject);
var
S: TStringType;
S1,S2,Sl: String;
i,nl: integer;
ans: AnsiString;
WS: WideString;
PAC: PAnsiChar;
Error,rt,Prt: Cardinal;
zres: TComplexE;
FZ1: Pointer;
t1,t2: cardinal;
begin

Sc:= StrTofloat(ES.text,G_FMT);
btm.Height:=Image1.Height;
btm.Width:=Image1.Width;



NIter:=strtoint(combobox1.text);
ISize:=strtoint(combobox2.text);
Ymin:=StrTofloat(Edit3.text,G_FMT)*Sc;
Ymax:=StrTofloat(Edit4.text,G_FMT)*Sc;
Xmin:=StrTofloat(Edit1.text,G_FMT)*Sc;
Xmax:=StrTofloat(Edit2.text,G_FMT)*Sc;

 S:=ETF.Text;



flSet(fl_Calc_Type, fl_Complex);

    {$IFDEF PANSICHAR}
       ans:=AnsiString(S); pac:=PAnsiChar(ans);   fzCompile(pac,ZFunc);
    {$ELSE}
       fzCompile(S,ZFunc);
    {$ENDIF}
flGetSyntaxErrorCode(Error);

if Error = 0 then
begin


    //btm.canvas.FillRect(clientrect);

     t1:=gettickcount;
      DrawFractal;
     t2:=gettickcount;


     Label7.Caption:=InttoStr(t2-t1);
     L_FPS.Caption:='';

//ShowError;

end
else
ShowError;

fzPerform(fl_FREE,Cardinal(ZFunc));


end;

*)




procedure TForm1.FindDrawMode;
label endf;
var
 S: TStringType;
 SP,SL,ST: String;
 i,nl: integer;
 ans: AnsiString;
 WS: WideString;
 PAC: PAnsiChar;
 PtrS: Cardinal;

 FZ1: Pointer;
 t1,t2,T3: cardinal;
begin


SP:='';
for i := 0 to  MFRC.Lines.Capacity-1 do
begin

 ST:=MFRC.Lines[i];
 DeleteSpace(ST,ST);

 if ST <> '' then
 begin

    PtrS:=Pos('//',ST);
    if PtrS <> 0 then    Delete(ST,PtrS,Length(ST)-PtrS+1) ;

    SL:=LowerCase(ST);

    PtrS:=Pos('{$drawingmode:fractal}',SL);
    if PtrS <> 0  then
    begin
      RB_Fractal.Checked:=True;
      Delete(SL,PtrS,22);
      //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:complexgraph}',SL);
    if PtrS <> 0  then
    begin
       RB_ComplexGraph.Checked:=True;
       Delete(SL,PtrS,27);
       //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:complexdynamic}',SL);
    if PtrS <> 0  then
    begin
       RB_ComplexDynamic.Checked:=True;
       Delete(SL,PtrS,29);
       //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:plotgraph2d}',SL);
    if PtrS <> 0  then
    begin
       RB_GraphFX.Checked:=True;
       Delete(SL,PtrS,26);
       //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:plotfourierseries}',SL);
    if PtrS <> 0  then
    begin
       RB_Fourier.Checked:=True;
       Delete(SL,PtrS,32);
       //goto endf;
    end;

    endf:
   // SP:=SP+SL;

 end;

end;

 //S_TextProg:=SP;

end;



procedure TForm1.ConvLinesToStr;
label endp,endf;
var
 Expr: TStringType;
 S: TStringType;
 SP,SL,ST,FTS,FNS,dv,DExpr,SDiffFunc: String;
 i,nl,Pb: integer;
 ans: AnsiString;
 WS: WideString;
 PAC: PAnsiChar;
 PtrS: Cardinal;

 FZ1,PtrSF: Pointer;
 t1,t2,T3: cardinal;
 idfP: TidFunc;
 Error: Cardinal;
begin

F_DefFunc := False;
F_DefFuncDeriv:=False;

N_EndProg:=MFRC.Lines.Capacity-1;
SP:='';

for i := 0 to  MFRC.Lines.Capacity-1 do
begin

 ST:=MFRC.Lines[i];
 DeleteSpace(ST,ST);

 if ST <> '' then
 begin

    PtrS:=Pos('//',ST);
    if PtrS <> 0 then    Delete(ST,PtrS,Length(ST)-PtrS+1) ;

    SL:=LowerCase(ST);

    PtrS:=Pos('{$drawingmode:fractal}',SL);

    if PtrS <> 0  then
    begin
      RB_Fractal.Checked:=True;
      Delete(SL,PtrS,22);
      //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:complexgraph}',SL);
    if PtrS <> 0  then
    begin
       RB_ComplexGraph.Checked:=True;
       Delete(SL,PtrS,27);
       //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:complexdynamic}',SL);
    if PtrS <> 0  then
    begin
       RB_ComplexDynamic.Checked:=True;
       Delete(SL,PtrS,29);
       //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:plotgraph2d}',SL);
    if PtrS <> 0  then
    begin
       RB_GraphFX.Checked:=True;
       Delete(SL,PtrS,26);
       //goto endf;
    end;

    PtrS:=Pos('{$drawingmode:plotfourierseries}',SL);
    if PtrS <> 0  then
    begin
       RB_Fourier.Checked:=True;
       Delete(SL,PtrS,32);

       if F_FixFourierInterval = False   then
       begin
          FourierXmin:=Xmin;
          FourierXmax:=Xmax;
          FI_FixFourierInterval:=0;
       end;

       L_FourierInterval.Caption:='[ ' + FloatToStr(FourierXmin) + ' ... ' + FloatToStr(FourierXmax)+' ]';
       //goto endf;
    end;

    PtrS:=Pos('{$deffunc+}',SL);
    if PtrS <> 0  then
    begin
       F_DefFunc:=True;
       Delete(SL,PtrS,11);
       //goto endf;
    end;

    PtrS:=Pos('{$deffunc-}',SL);
    if PtrS <> 0  then
    begin
       F_DefFunc:=False;
       Delete(SL,PtrS,11);
       //goto endf;
    end;

    PtrS:=Pos('{$deffuncderiv+}',SL);
    if PtrS <> 0  then
    begin
       F_DefFuncDeriv:=True;
       Delete(SL,PtrS,16);
       //goto endf;
    end;

    PtrS:=Pos('{$deffuncderiv-}',SL);
    if PtrS <> 0  then
    begin
        F_DefFuncDeriv:=False;
       Delete(SL,PtrS,16);
       //goto endf;
    end;



    PtrS:=Pos('{$endprogramm}',SL);
    if PtrS <> 0  then
    begin
       N_EndProG:=i;
       Delete(SL,PtrS,14);
       goto endp;
    end;




    endf:

    if (SL <> '') and  (F_DefFunc = True) then
    begin
      S_FuncName:=SL;
      flSetFunction(SL,0, @idfP);
      flGetErrorCode(Error);
      if Error <> 0 then  begin G_Error:=Error; ShowError; end
      else
      if F_DefFuncDeriv = True then
      begin
          Pb:=Pos('(',SL);
          FNS:=Copy(SL,1,Pb-1);
          Pb:=Pos('=',SL);
          FTS:=Copy(SL,Pb+1,Length(SL)-Pb);

          dv:='x';
          {$IFDEF PANSICHAR}
           ans:=AnsiString(dv); Expr:=PAnsiChar(ans);
         {$ELSE}
           Expr:=TStringType(dv);
         {$ENDIF}

          flSetDiffVar(Expr);

          {$IFDEF PANSICHAR}
           ans:=AnsiString(FTS); Expr:=PAnsiChar(ans);
         {$ELSE}
           Expr:=TStringType(FTS);
         {$ENDIF}

          flSetDiffExpr(Expr);
          flDiffExpr(1);
          flGetErrorCode(Error);
          if Error = 0 then
          begin
              {$IFDEF STRINGINT}
                flGetDiffString(DExpr);
              {$ELSE}
                flGetDiffString(PtrSF);
                ConvStr(PtrSF,DExpr);
              {$ENDIF}

               SDiffFunc:=FNS+'d1()='+DExpr;

              {$IFDEF PANSICHAR}
                 ans:=AnsiString(SDiffFunc); Expr:=PAnsiChar(ans);
              {$ELSE}
                Expr:=TStringType(SDiffFunc);
              {$ENDIF}

               //1 - deriv
               flSetFunction(Expr, 0, @idfP);


              {$IFDEF PANSICHAR}
                  ans:=AnsiString(FTS); Expr:=PAnsiChar(ans);
              {$ELSE}
                  Expr:=TStringType(FTS);
              {$ENDIF}

              flSetDiffExpr(Expr);
              flDiffExpr(2);

              {$IFDEF STRINGINT}
                flGetDiffString(DExpr);
              {$ELSE}
                flGetDiffString(PtrSF);
                ConvStr(PtrSF,DExpr);
              {$ENDIF}

                SDiffFunc:=FNS+'d2()='+DExpr;

              {$IFDEF PANSICHAR}
                 ans:=AnsiString(SDiffFunc); Expr:=PAnsiChar(ans);
              {$ELSE}
                 Expr:=TStringType(SDiffFunc);
              {$ENDIF}

              //2 - deriv
              flSetFunction(Expr, 0, @idfP);

              {$IFDEF PANSICHAR}
                 ans:=AnsiString(FTS); Expr:=PAnsiChar(ans);
              {$ELSE}
                 Expr:=TStringType(FTS);
              {$ENDIF}

              flSetDiffExpr(Expr);
              flDiffExpr(3);

             {$IFDEF STRINGINT}
               flGetDiffString(DExpr);
             {$ELSE}
               flGetDiffString(PtrSF);
               ConvStr(PtrSF,DExpr);
             {$ENDIF}

             SDiffFunc:=FNS+'d3()='+DExpr;

             {$IFDEF PANSICHAR}
                ans:=AnsiString(SDiffFunc); Expr:=PAnsiChar(ans);
             {$ELSE}
                Expr:=TStringType(SDiffFunc);
             {$ENDIF}

              //3 - deriv
             flSetFunction(Expr, 0, @idfP);

          end
          else ShowError;

      end;


    end
    else
    SP:=SP+SL;

 end;

end;

endp:
 S_TextProg:=SP;

end;




procedure TForm1.Button1Click(Sender: TObject);
label endp;
var
S: TStringType;
S1,S2,Sl: String;
i,nl: integer;
ans: AnsiString;
WS: WideString;
PAC: PAnsiChar;
Error,rt,Prt: Cardinal;
zres: TComplexE;
FZ1: Pointer;
t1,t2,T3: cardinal;
begin

G_Error:=0;
//Sc:= StrTofloat(ES.text,G_FMT);
Scaling;
btm.Height:=image1.Height;
btm.Width:=image1.Width;




NIter:=strtoint(combobox1.text);
ISize:=strtoint(combobox2.text);
Ymin:=StrTofloat(Edit3.text,G_FMT)*Sc;
Ymax:=StrTofloat(Edit4.text,G_FMT)*Sc;
Xmin:=StrTofloat(Edit1.text,G_FMT)*Sc;
Xmax:=StrTofloat(Edit2.text,G_FMT)*Sc;

KDens:=StrToInt(E_Dens.Text);

N_Harmonics:=StrToInt(E_NHarmonics.Text);


(*
S:='';
for i := 0 to  MFRC.Lines.Capacity-1 do
begin
 Sl:=MFRC.Lines[i];
 DeleteSpace(Sl,Sl);
 if Sl <> '' then
 begin

  Prt:=Pos('//',Sl);
  if Prt <> 0 then    Delete(Sl,Prt,Length(Sl)-Prt+1) ;


  S:=S+Sl;
 end;
end;
*)


ConvLinesToStr;
if G_Error <> 0 then goto endp;


S:= S_TextProg;

//flSet(fl_RESULT_TYPE, fl_Real,0);
flSet(fl_RESULT_TYPE,  fl_STAY_AS_IS,0);

  t1:=gettickcount;

    {$IFDEF PANSICHAR}
       ans:=AnsiString(S); pac:=PAnsiChar(ans);   flCompile(pac,0,FJ1);
    {$ELSE}
       flCompile(S,0,FJ1);
    {$ENDIF}

  t2:=gettickcount;
  LabC.Caption:=IntToStr(T2-T1);

flGetErrorCode(Error);

 Set8087CW($1372);

if Error = 0 then
begin

    //ClearPrint();
   
    btm.canvas.FillRect(clientrect);

     t1:=gettickcount;
      flResult(FJ1);
     t2:=gettickcount;


     Label7.Caption:=InttoStr(t2-t1);

     if Gr_Mode = _ComplexDynDraw then  L_FPS.Caption:=InttoStr(Trunc(NIter*1000/(t2-t1))) else  L_FPS.Caption:='';

     //LabC.Caption:=IntToStr(T2-T1);
//ShowError;

end
else
ShowError;

flPerform(fl_FREE,Cardinal(FJ1));

endp:
end;





procedure TForm1.Button2Click(Sender: TObject);
begin
  Xmin:=2*Xmin; Xmax:=2*Xmax;

  edit1.Text:=FloatToStr(Xmin,G_FMT);
  edit2.Text:=FloatToStr(Xmax,G_FMT);

  if F_AutoReDraw = True then BDrawClick(Self);

end;

procedure TForm1.BInitClick(Sender: TObject);
begin
  Edit1.text:='-1.5';
  Edit2.text:='1.5';
  Edit3.text:='-1.5';
  Edit4.text:='1.5';

  ES.Text:='1';
  NSc:=1; Sc:=1;


 Xmin:=-1.5;  Xmax:=1.5;
 Ymin:=-1.5;  Ymax:=1.5;

 Edit1.text:='-1.5';
 Edit2.text:='1.5';
 Edit3.text:='-1.5';
 Edit4.text:='1.5';

 //glOrtho(-1, 1, -1, 1, 0, 1);

 if Gr_Mode = _Graph2DDraw then
 begin
    Xmin:=-10;  Xmax:=10;
    Ymin:=-10;  Ymax:=10;
    Edit1.text:='-10';
    Edit2.text:='10';
    Edit3.text:='-10';
    Edit4.text:='10';

    //glOrtho(0, PFLD.ClientHeight, 0, PFLD.ClientHeight, 0, 1);
 end
 else
 if Gr_Mode = _Graph2DFourier then
 begin
    Xmin:=-10;  Xmax:=10;
    Ymin:=-10;  Ymax:=10;
    Edit1.text:='-10';
    Edit2.text:='10';
    Edit3.text:='-10';
    Edit4.text:='10';

    //glOrtho(0, PFLD.ClientHeight, 0, PFLD.ClientHeight, 0, 1);
 end
 else
 if Gr_Mode = _ComplexDynDraw then
 begin
   ES.Text:='2';
   NSc:=2; Sc:=2;
 end
 else
 if Gr_Mode = _ComplexDraw then
 begin
   ES.Text:='3';
   NSc:=3; Sc:=3;
 end;

 if F_AutoReDraw = True then BDrawClick(Self);

end;




procedure TForm1.Button3Click(Sender: TObject);
var
S,S1,SL: String;
begin
 OpenFile.InitialDir := GetCurrentDir;
 if OpenFile.Execute then
 begin
    MFRC.Lines.LoadFromFile(OpenFile.FileName) ;
    FindDrawMode;
    BInitClick(Self);

    //N_EndProg:=MFRC.Lines.Capacity-1;
    //ConvLinesToStr;

    (*
    S:=OpenFile.FileName;
    S1:=AnsiStrRScan(PChar(S),'\');
    Delete(S1,1,1);
    SL:=LowerCase(S1);
    if (SL = 'fractal_fern.txt') or (SL = 'fractal_julia.txt') then
      //RB_Fractal.OnClick(self)
      RB_Fractal.Checked:=True
    else
    if SL = 'complex_graph.txt' then
     //RB_ComplexGraph.OnClick(self)
     RB_ComplexGraph.Checked:=True
    else
    if SL = 'complex_dynamic.txt' then
     //RB_ComplexDynamic.OnClick(self);
     RB_ComplexDynamic.Checked:=True;

    *)

 end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Xmin:=Xmin*0.5; Xmax:=Xmax*0.5;

  edit1.Text:=FloatToStr(Xmin,G_FMT);
  edit2.Text:=FloatToStr(Xmax,G_FMT);

  if F_AutoReDraw = True then BDrawClick(Self);
end;



procedure TForm1.Button5Click(Sender: TObject);
begin
  Ymin:=2*Ymin; Ymax:=2*ymax;

  edit3.Text:=FloatToStr(Ymin,G_FMT);
  edit4.Text:=FloatToStr(Ymax,G_FMT);

  if F_AutoReDraw = True then BDrawClick(Self);
end;



procedure TForm1.Button6Click(Sender: TObject);
begin
  Ymin:=0.5*Ymin; Ymax:=0.5*ymax;

  edit3.Text:=FloatToStr(Ymin,G_FMT);
  edit4.Text:=FloatToStr(Ymax,G_FMT);

  if F_AutoReDraw = True then BDrawClick(Self);
end;


procedure TForm1.CB_AReDrwClick(Sender: TObject);
begin
  if CB_AReDrw.Checked then F_AutoReDraw := True else   F_AutoReDraw := False;
end;

procedure TForm1.CB_FixFourierClick(Sender: TObject);
begin
  if CB_FixFourier.Checked then F_FixFourierInterval := True else   F_FixFourierInterval := False;
  if F_FixFourierInterval = True   then
  begin
     FourierXmin:=Xmin;
     FourierXmax:=Xmax;
     FI_FixFourierInterval:=1;
  end
  else
  begin
     FI_FixFourierInterval:=0;
  end;

  //L_FourierInterval.Caption:='[ ' + FloatToStr(FourierXmin) + ' ... ' + FloatToStr(FourierXmax)+' ]';

end;


procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 NIter:=strtoint(combobox1.text);
end;


procedure TForm1.ComboBox2Change(Sender: TObject);
begin
ISize:=strtoint(combobox2.text);

Image1.Picture := NIL;
image1.Width:=strtoint(combobox2.text);
image1.height:=strtoint(combobox2.text);

PFLD.Width:=strtoint(combobox2.text);
PFLD.height:=strtoint(combobox2.text);

btm.Height:=ISize;
btm.Width:=ISize;

glViewPort (0, 0, PFLD.ClientHeight, PFLD.ClientHeight);
end;





procedure TForm1.DrawDynComplex;
const PI2:  double = 3.1415926535897932384626433832795*2;
const Exp1: double = 2.7182818284590452353602874713527;
const PI2i:  double = 1/(3.1415926535897932384626433832795*2);
var
 ix,iy,citr,zi: integer;
 re,im,h,s,v,f,cr,cg,cb,re_min,re_max,im_min,im_max: double;
 //fz: ForevalZdll.TComplexD;
 r,g,b: double;
 t1,t2: Cardinal;
 //fx,fy: GLFloat;
 iw1,ih1,fx,fy: double;

 t,m,r0,r1,p,q,p1,q1: double;
begin
re_min:=Xmin;
re_max:=Xmax;
im_min:=Ymin;
im_max:=Ymax;

 //t1:=gettickcount;


 iw1:=1/PFLD.Width;     ih1:=1/PFLD.Height;

     for citr := 0 to   NIter do
     begin
            Set8087CW($1332);
            itr:=citr;

            for ix := 0 to   PFLD.Width - 1 do
            begin
                //re := re_min + ix * (re_max - re_min) / PFLD.Width;
                 re := re_min + ix * (re_max - re_min) *iw1;

                //fx:=2*(ix/PFLD.Width-0.5);
                 fx:=2*(ix*iw1-0.5);


                for iy := 0 to  PFLD.Height -1   do
                begin

                   try


                         //im := im_min + iy * (im_max - im_min) / PFLD.Height;
                          im := im_min + iy * (im_max - im_min) * ih1;
                          Zd.re:=re; Zd.im:=im;
                           //fzResultCxDP(Zfunc,@fz);
                           //fzResult(ZFunc);
                           asm
                             call ZFunc
                             //fstp qword ptr [fz].re
                             //fstp qword ptr [fz].im
                           end;
                          // fz:=zCalcFunctionZD(ZFunc);

                       {
                        ComplexToHsv(fz,h,s,v);
                        HsvToRgb(h,s,v,cr,cg,cb);
                       }

                     // ComplexToHsv:
                       t:= arctan2(ResultCxD.im,ResultCxD.re);
                       while (t < 0.0) do t := t+PI2;
                       while (t >= PI2) do  t := t-PI2;
                       h:= t * PI2i;
                       m:= sqrt(sqr(ResultCxD.re)+sqr(ResultCxD.im));
                       r0:= 0.0;
                       r1:= 1.0;
                       while (m > r1)  do
                       begin
                          r0 := r1;
                          r1 := r1 * Exp1;
                       end;
                       r:= (m - r0) / (r1 - r0);
                       if (r < 0.5) then p:=2*r else p:=2*(1-r);
                       q:= 1.0 - p;
                       p1:= 1 - q * q * q;
                       q1:= 1 - p * p * p;
                       s:= 0.4 + 0.6 * p1;
                       v:= 0.6 + 0.4 * q1;

                       //HsvToRgb:
                       if (s = 0) then
                       begin
                         r := v;
                         g := v;
                         b := v;
                       end
                       else
                       begin
                         if (h = 1.0) then h := 0.0;
                         zi := Trunc(6 * h);
                         f := h * 6 - zi;
                         p := v * (1 - s);
                         q := v * (1 - s * f);
                         t := v * (1 - s * (1 - f));

                         case zi of
                          0: begin r := v; g := t; b := p;  end;
                          1: begin r := q; g := v; b := p;  end;
                          2: begin r := p; g := v; b := t;  end;
                          3: begin r := p; g := q; b := v;  end;
                          4: begin r := t; g := p; b := v;  end;
                          5: begin r := v; g := p; b := q;  end;
                         end;
                      end;
                    //  cr:=r; cg:=g; cb:=b;
                       glColor3d (r, g, b);



                        //glColor3d (cr, cg, cb);
                        fy:=2*(iy*ih1-0.5);
                         glBegin(GL_POINTS);
                          glVertex2d(fx,fy);
                         glEnd;



                   except

                   end;
                end;
            end;
            SwapBuffers(DC);
     end;


end;





procedure TForm1.ComplexToHSV(z: TComplexE; var h,s,v :extended);
const PI2:extended = 3.1415926535897932384626433832795*2;
const Exp1:extended = 2.7182818284590452353602874713527;
var
 t,m,r0,r1,r,p,q,p1,q1: extended;
 begin
            // extract a phase 0 <= t < 2 pi
            t:= arctan2(z.im,z.re);
            while (t < 0.0) do t := t+PI2;
            while (t >= PI2) do  t := t-PI2;

            // the hue is determined by the phase
            h:= t / PI2;

            // extract a magnitude m >= 0
            m:= sqrt(sqr(z.re)+sqr(z.im));

            // map the magnitude logrithmicly into the repeating interval 0 < r < 1
            // this is essentially where we are between countour lines
            r0:= 0.0;
            r1:= 1.0;
            while (m > r1)  do
            begin
                r0 := r1;
                r1 := r1 * Exp1;
            end;


            r:= (m - r0) / (r1 - r0);
            // this puts contour lines at 0, 1, e, e^2, e^3, ...

            // determine saturation and value based on r
            // p and q are complementary distances from a countour line
            //p:= r < 0.5 ? 2.0 * r : 2.0 * (1.0 - r);
            if (r < 0.5) then p:=2*r else p:=2*(1-r);
            q:= 1.0 - p;
            // only let p and q go to zero very close to zero; otherwise they should stay nearly 1
            // this keep the countour lines from getting thick
            p1:= 1 - q * q * q;
            q1:= 1 - p * p * p;
            // fix s and v from p1 and q1
            s:= 0.4 + 0.6 * p1;
            v:= 0.6 + 0.4 * q1;

           // return (new ColorTriplet() {X = h, Y = s, Z = v} );
 end;


procedure TForm1.HsvToRgb(h,s,v: extended; var cr,cg,cb: extended);
var
f,p,q,t,r,g,b: extended;
zi: integer;
begin

            if (s = 0) then
            begin
                r := v;
                g := v;
                b := v;
            end
            else
             begin
                if (h = 1.0) then h := 0.0;
                zi := Trunc(6 * h);
                f := h * 6 - zi;
                p := v * (1 - s);
                q := v * (1 - s * f);
                t := v * (1 - s * (1 - f));

                case zi of
                    0: begin r := v; g := t; b := p;  end;
                    1: begin r := q; g := v; b := p;  end;
                    2: begin r := p; g := v; b := t;  end;
                    3: begin r := p; g := q; b := v;  end;
                    4: begin r := t; g := p; b := v;  end;
                    5: begin r := v; g := p; b := q;  end;

                end;

             end;

          // cr:=Trunc(r);   cg:=Trunc(g);  cb:=Trunc(b);
          cr:=r; cg:=g; cb:=b;
            //return (new ColorTriplet() { X = r, Y = g, Z = b });



        {
           c = (int)(256*r); if(c>255) c = 255; RGBcolor[0] = c;
           c = (int)(256*g); if(c>255) c = 255; RGBcolor[1] = c;
           c = (int)(256*b); if(c>255) c = 255; RGBcolor[2] = c;
         }


end;



procedure TForm1.DrawComplex;
var
 ix,iy: integer;
 re,im,h,s,v,cr,cg,cb,re_min,re_max,im_min,im_max: extended;
 fzt: TComplexE;
 r,g,b: Cardinal;
 t1,t2: Cardinal;
begin
Set8087CW($1332);

re_min:=Xmin;
re_max:=Xmax;
im_min:=Ymin;
im_max:=Ymax;

 

            for ix := 0 to   image1.Width - 1 do
            begin
                re := re_min + ix * (re_max - re_min) / image1.Width;
                for iy := 0 to  image1.Height -1   do
                begin
                      try

                           im := im_min + iy * (im_max - im_min) / image1.Height;
                           Ze.re:=re; Ze.im:=im;
                           flResult(Zfunc);

                            ComplexToHsv(ResultCx,h,s,v);
                            HsvToRgb(h,s,v,cr,cg,cb);
                            r := Trunc(255.0 * cr);
                            g := Trunc(255.0 * cg);
                            b := Trunc(255.0 * cb);
                            btm.canvas.Pixels[ix,iy]:=rgb(r, g, b);
                           {
                           if (IsNaN(FZe.re) = true) or (IsNaN(FZe.im)= true) or
                              (IsInfinite(FZe.re)= true) or (IsInfinite(FZe.im)= true)
                           then
                           begin

                           end
                           else
                           begin
                            ComplexToHsv(FZe,h,s,v);
                            HsvToRgb(h,s,v,cr,cg,cb);
                            r := Trunc(255.0 * cr);
                            g := Trunc(255.0 * cg);
                            b := Trunc(255.0 * cb);
                            btm.canvas.Pixels[ix,iy]:=rgb(r, g, b);
                           end;
                           }

                       except

                       end;
                end;
            end;

Form1.image1.picture.Bitmap.Assign(btm);
end;




procedure TForm1.DrawFractal;
var
 ix,iy,k: integer;
 re,im,x,y,hx,hy,r: extended;
 //fz: TComplexEx;
 cr,cg,cb,cl: Cardinal;

begin

Set8087CW($1332);

hx:=(Xmax-Xmin)/Image1.Width;
hy:=(Ymax-Ymin)/Image1.Height;
im:=Ymin;




 for iy :=  0 to Image1.Height-1 do
 begin
     re:= Xmin;

     for ix := 0 to Image1.Width-1 do
      begin
         r:=1;   k:=NIter;
         Ze.re:=re; Ze.im:=im;

         while (k > 0) and (r < 4) do
         begin

                try
                 //fzResult(ZFunc);
                   asm
                     call ZFunc
                   end;
                except
                end;
                r:=sqr(Ze.re)+sqr(Ze.im);
                dec(k);

         end;

         cl:=Trunc(k*255/NIter);
         cR:=10*cl; cG:=5*cl; cB:=cl;
         btm.canvas.Pixels[ix,iy]:=rgb(cr, cg, cb);
         re:=re+hx;
        end;

     im:=im+hy;
    end;

Form1.Image1.picture.Bitmap.Assign(btm);
end;








procedure TForm1.DrawGraph2DGL;
label endp,nxtForK1,nxtForK2,nxtForK0;
var
 ix,iy,k: integer;
 re,im,x,y,hx,hy,r: extended;
 //fz: TComplexEx;
 cr,cg,cb,cl: Cardinal;

 xw,xw0,yw0,KG, XWmax,YWmax,Err: Cardinal;

 yw,yw1,yw2,ywl,YWminC,YWmaxC: Integer;
 {xf,}yf,Kx,Ky,Hkg,Hky,Hkx,Yfmax,Yfmin,xf1,xf2: extended;
 xfmax0,xfmin0,Yfmax0,Yfmin0,yf0,xf0,dyf,dyft,yft: extended;
 YGF_min,YGF_max,XGF_min,XGF_max: extended;
 ywf,YWminCf,YWmaxCf: extended;

 Bdyf,Bdyft,Bchgdyf,BErrC: Boolean;

 BFirst, BErr, BErr0, BWout0, BWout: Boolean;
begin





{
btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clBlue;
}
//glOrtho(0, PFLD.ClientHeight, 0, PFLD.ClientHeight, 0, 1);
glColor3d(0, 0.3, 1.0);

glEnable(GL_LINE_SMOOTH);
glEnable(GL_POINT_SMOOTH);
glPointSize(1);
glLineWidth(1) ;


{
XGF_min:=-2;
XGF_max:=30;


YGF_min:=-7;
YGF_max:=30;
}


XGF_min:=Xmin;
XGF_max:=Xmax;

YGF_min:=Ymin;
YGF_max:=Ymax;


Set8087CW($1332);
flSet(fl_Enable, fl_MASK_FPU_EXCEPTION, 0);

hx:=(XGF_max-XGF_min)/Image1.Width;
hy:=(YGF_max-YGF_min)/Image1.Height;
im:=Ymin;

XWmax:=Image1.Width;
YWmax:=Image1.Height;


KG:=KDens;

xw:=Image1.Width;
xf:=XGF_min;
Kx:=abs(XGF_max-XGF_min)/XWmax;
Ky:=abs(YGF_max-YGF_min)/YWmax;
Hkg:=1/KG;
Hky:=1/Ky;
Hkx:=1/Kx;



BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;



BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;
BErr0:=False;
BWout0:=False;
BWout:=False;
BErr:=False;

//next  points
try
for xw :=  0 to XWmax do
//xw:=1;
//while xw <= XWmax do
begin
   xf := XGF_min + Kx*xw;

   //flResultSafeE(ZFunc,yf);
                 BErr:=False;
                try
                   asm
                     call ZFunc
                   end;
                except
                  //on E: Exception do BErr:=True;
                   on E: EZeroDivide      do BErr:=True;
                   on E: EInvalidOp       do BErr:=True;
                   on E: EOverFlow        do BErr:=True;
                end;
                if (IsNaN(ResultR)=True) {or (BErr = True)} then begin  BErr:=True; goto nxtForK2; end;
                //if BErr = True then BErr0:=True;
                yf:=ResultR;


   //BWout0:=False;

   Yfmax:=yf;
   Yfmin:=yf;
   yft:=yf;

   dyf:=yf-yf0;   //градиент приращений по y
   if dyf > 0  then Bdyf:=True else Bdyf:=False;
   // Bdyf > 0 =>  приращение по y растёт иначе падает
   Bchgdyf:=False;   //смена градиента приращений по y

    BErr:=False;
    for k := 0 to KG do
    begin
       xf := XGF_min + Kx*(xw+k*Hkg);

       //flResultSafeE(ZFunc,yf);
                BErrC:=False;
                try
                   asm
                     call ZFunc
                   end;
                except
                   //on E: Exception do BErr:=True;
                   on E: EZeroDivide      do BErr:=True;
                   on E: EInvalidOp       do BErr:=True;
                   on E: EOverFlow        do BErr:=True;
                end;
                BErrC:=BErr;
                if (IsNaN(ResultR)=True) then
                begin

                  BErr:=True;
                  goto nxtForK2;
                end;


                yf:=ResultR;


       if yf > Yfmax then begin Yfmax:=yf; xf2:=xf; end;
       if yf < Yfmin then begin Yfmin:=yf; xf1:=xf; end;




       dyft:=yf-yft;  yft:=yf;
       if dyft > 0  then Bdyft:=True else Bdyft:=False;

       //регистрировать смену приращений градиента по Y, если значения Y вышли за пределы окна
       //
       if (Bchgdyf = False) and ((YWmaxC > YWmax) or (YWminC < 0)) then
       begin
         //сравнить предыдущее с текущим значением градиета по Y
         //если оно изменилось, то зафиксировать предыдущее значение и установить флаг смены приращений по Y:
         //  Bchgdyf = True
         if Bdyf <> Bdyft then  Bchgdyf:=True;
       end
       else
       begin
          Bdyf:=Bdyft;
       end;




  end;



  if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;


  ywf:=((yf-YGF_min)*Hky);

  if abs(ywf) > MaxInt then
  begin
    if ywf > 0  then yw:=MaxInt else yw:=-MaxInt;
  end
  else  yw:=Trunc(ywf) ;




     YWminCf:=((Yfmin-YGF_min)*Hky);
     YWmaxCf:=((Yfmax-YGF_min)*Hky);

     if abs(YWminCf) > MaxInt then
     begin
        if YWminCf > 0  then YWminC:=MaxInt else YWminC:=-MaxInt;
     end
     else  YWminC:=Trunc(YWminCf);

     if abs(YWmaxCf) > MaxInt then
     begin
        if YWmaxCf > 0  then YWmaxC:=MaxInt else YWmaxC:=-MaxInt;
     end
     else  YWmaxC:=Trunc(YWmaxCf);



     BWout:=False;
     if (YWmaxC > YWmax) or (YWminC < 0) then    BWout:=True;



     if ((YWmaxC > YWmax) and (YWminC < 0)) and (BErr = False) then
     begin

             if Bdyf = True then    //dyf > 0
             begin
                if BFirst = True  then
                begin
                   //btm.canvas.MoveTo(xw+1,YWmax);
                   glBegin(GL_LINE_STRIP);
                   glVertex2i(xw+1,YWmax);
                   BFirst := False;
                 end
                 else
                 begin
                   //btm.canvas.LineTo(xw,0);
                   //btm.canvas.MoveTo(xw+1,YWmax);
                   glVertex2i(xw,0);
                   glEnd;
                   glBegin(GL_LINE_STRIP);
                   glVertex2i(xw+1,YWmax);
                 end;
              end
              else
              begin
                if BFirst = True  then
                begin
                    //btm.canvas.MoveTo(xw+1,0);
                    glBegin(GL_LINE_STRIP);
                    glVertex2i(xw+1,0);//glVertex2d(xw+1,0);
                    BFirst := False;
                 end
                 else
                 begin
                    //btm.canvas.LineTo(xw,YWmax);
                    //btm.canvas.MoveTo(xw+1,0);
                    glVertex2i(xw,YWmax);
                    glEnd;
                    glBegin(GL_LINE_STRIP);
                    glVertex2i(xw+1,0);
                 end;
             end;

     end
     else
         //res=sin(x)^cos(x)
         //res=asin(x)
     begin

      // btm.canvas.LineTo(xw,YWmax-yw);

        if BErr = False then
        begin
           if BFirst = True  then
           begin
                   //btm.canvas.MoveTo(xw,YWmax-yw);
                   glBegin(GL_LINE_STRIP);
                   glVertex2i(xw,YWmax-yw);
                   BFirst := False;
           end
           else
           begin
                  if BErr0 =  True then
                  begin
                      //btm.canvas.MoveTo(xw,YWmax-yw)
                      glEnd;
                      glBegin(GL_LINE_STRIP);
                      glVertex2i(xw,YWmax-yw);
                  end
                  else
                  begin
                     //btm.canvas.LineTo(xw,YWmax-yw);
                     glVertex2i(xw,YWmax-yw);
                  end;
           end;
        end;

    end;



     yf0:=yf;
     yw0:=yw;
     xw0:=xw;


   nxtForK2:
    BWout0:=BWout;
    BErr0:=BErr;
end;

except

end;



//COORD
yw:=Trunc((0-YGF_min)*Hky);

{
btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;

btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);
}

glColor3d(1.0, 0.0, 0.0);

glEnd;
glBegin(GL_LINE_STRIP);
 glVertex2i(0,YWmax-yw);
 glVertex2i(XWmax,YWmax-yw);
glEnd;

xw:=Trunc((0-XGF_min)*Hkx);

{
btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;

btm.canvas.MoveTo(xw,0);
btm.canvas.LineTo(xw,YWmax);
}

glBegin(GL_LINE_STRIP);
 glVertex2i(xw,0);
 glVertex2i(xw,YWmax);
glEnd;

//btm.canvas.Pen.Color:=clSilver;
//Form1.Image1.picture.Bitmap.Assign(btm);
SwapBuffers(DC);

 {
glOrtho(0, PFLD.ClientHeight, 0, PFLD.ClientHeight, 0, 1);
glPointSize(10);
glColor3d(0.7, 0.6, 0.3);
glBegin(GL_POINTS);
 glVertex2f(10.3,100.5);
 glVertex2f(20.3,200.9);
 glVertex2f(250.7,250.9);
glEnd;
SwapBuffers(DC);
}


endp:
end;






procedure _DrawGraph2D(AddrGF: Pointer; Gv: Pointer; ShowImg: Integer);    stdcall;
label endp,nxtForK1,nxtForK2,nxtForK0;
var
 ix,iy,k: integer;
 re,im,x,y,hx,hy,r: extended;
 //fz: TComplexEx;
 cr,cg,cb,cl: Cardinal;

 xw,xw0,yw0,KG, XWmax,YWmax,Err: Cardinal;

 yw,yw1,yw2,ywl,YWminC,YWmaxC: Integer;
 {xf,}yf,Kx,Ky,Hkg,Hky,Hkx,Yfmax,Yfmin,xf1,xf2: extended;
 xfmax0,xfmin0,Yfmax0,Yfmin0,yf0,xf0,dyf,dyfUP,yfUP,yf1NEu,yf2NEu: extended;
 YGF_min,YGF_max,XGF_min,XGF_max: extended;
 ywf,YWminCf,YWmaxCf: extended;

 Bdyf,BdyfUP,Bchgdyf,BErrC: Boolean;

 BFirst, BErr, BErr0, BWout0, BWout, BFirstUP, BErrC0, BNoErrU, BFirstNE: Boolean;
 _Rise, _Fall, gradY_u: integer;

 Rp,Xp,Yp :Integer;
 ResultGf: extended;
begin

 _Rise:=2;
 _Fall:=1;




 {
btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clBlue;
 }

{
XGF_min:=-2;
XGF_max:=30;


YGF_min:=-7;
YGF_max:=30;
}


XGF_min:=Form1.Xmin;
XGF_max:=Form1.Xmax;

YGF_min:=Form1.Ymin;
YGF_max:=Form1.Ymax;


//Set8087CW($1332);
//flSet(fl_Enable, fl_MASK_FPU_EXCEPTION, 0);

hx:=(XGF_max-XGF_min)/Form1.Image1.Width;
hy:=(YGF_max-YGF_min)/Form1.Image1.Height;
im:=Form1.Ymin;

XWmax:=Form1.Image1.Width;
YWmax:=Form1.Image1.Height;


KG:=Form1.KDens;

xw:=Form1.Image1.Width;
Form1.xf:=XGF_min;
Kx:=abs(XGF_max-XGF_min)/XWmax;
Ky:=abs(YGF_max-YGF_min)/YWmax;
Hkg:=1/KG;
Hky:=1/Ky;
Hkx:=1/Kx;



BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;


BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;
BErr0:=False;
BErrC0:=False;
BWout0:=False;
BWout:=False;
BErr:=False;

//next  points
try
for xw :=  0 to XWmax do
//xw:=1;
//while xw <= XWmax do
begin
   //xf := XGF_min + Kx*xw;



    Bchgdyf:=False;   //смена градиента приращений по y
    BWout0:=False;
    BErr:=False;
    BFirstUP:=False;
    BWout:=False;
    BNoErrU:=False; //если хоть раз на единичном интервале есть вычисляемый без ошибки рез-т, то BNoErrU:=True
    BFirstNE:=False; //флаг первой вычисленного без ошибки значения

    //цикл по единичному отрезку
    for k := 0 to KG do
    begin
       Form1.xf := XGF_min + Kx*(xw+k*Hkg);

       PExtended(Gv)^:=Form1.xf;

       //flResultSafeE(ZFunc,yf);
                BErrC:=False;
                {
                try
                   asm
                     call ZFunc
                   end;
                except
                   //on E: Exception do BErr:=True;
                   on E: EZeroDivide      do begin BErr:=True;  BErrC:=True; end;
                   on E: EInvalidOp       do begin BErr:=True;  BErrC:=True; end;
                   on E: EOverFlow        do begin BErr:=True;  BErrC:=True; end;
                end;
                }
                MaskException;
                    asm
                      call AddrGF
                      fstp tbyte ptr [ResultGf]
                    end;
               if _IfException = 1 then
               begin
                  BErr:=True;  BErrC:=True;
               end
                else BNoErrU:=True;

                 //не все ф-ии вызывают исключения. Некоторые возвращают вместо ошибки - NaN
                //BErrC:=BErr;
                if (IsNaN(ResultGf)=True) then
                begin

                  BErr:=True;
                  BErrC:=True;
                  //goto nxtForK2;
                  goto nxtForK1;
                end;


                yf:=ResultGf;
                 //для первой точки на единичном отрезке  [xw,xw+1] c шагом h=1/KG
                if (((k = 0) and (BErr = False)) or ((BErr = True) and (BErrC = False))) and (BFirstUP=False)  then
                //if k = 0 then
                begin
                   Yfmax:=yf;
                   Yfmin:=yf;
                   YfUP:=yf;

                   //dyf:=yf-yf0;   //градиент приращений по y
                   //if dyf > 0  then Bdyf:=True else Bdyf:=False;
                   Bchgdyf:=False;   //смена градиента приращений по y
                   BFirstUP:=True; //флаг, первая точка из единичного отрезка обсчитана,
                   yf1NEu:=yf;  //  BFirstNE = True;  первое вычисленное без ошибки значение на единичном отрезке
                   BFirstNE := True;
                   goto nxtForK1;
                end
                else
                if BErrC = True  then     goto nxtForK1;


         if yf > Yfmax then begin Yfmax:=yf; xf2:=Form1.xf; end;
         if yf < Yfmin then begin Yfmin:=yf; xf1:=Form1.xf; end;


         //фиксация первого вычисленного без ошибки значения на единичном отрезке        sqrt(sin(x))
         if  (BErr = True) and (BErrC = False) and (BFirstNE = False) then begin yf1NEu:=yf; BFirstNE := True end;

          //последнее вычисленное без ошибки значения на единичном отрезке        sqrt(sin(x))
         if BErrC = False then    yf2NEu:=yf;




         dyfUP:=yf-yfUP;  yfUP:=yf;
         if dyfUP > 0  then BdyfUP:=True else BdyfUP:=False;
         if dyfUP > 0 then gradY_u:=_Rise else  gradY_u:=_Fall;

         //регистрировать смену приращений градиента по Y, если значения Y вышли за пределы окна
         //
         if (Bchgdyf = False) and ((Yfmax > YGF_max) or (Yfmin < YGF_min))  {((YWmaxC > YWmax) or (YWminC < 0)) }then
         begin
           //сравнить предыдущее с текущим значением градиета по Y
           //если оно изменилось, то зафиксировать предыдущее значение и установить флаг смены приращений по Y:
           //  Bchgdyf = True
           if Bdyf <> BdyfUP then  Bchgdyf:=True;
         end
         else
         begin
            Bdyf:=BdyfUP;
         end;



      nxtForK1:
    end; //for k

        // ln(x)   ln(sin(x))
        // ln(-x) -ln(-x)

    //if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;

    //sqrt(sin(x))  ln(x-pi) ln(x+pi)  -ln(x-pi)  -ln(x+pi)
    //если все значения на единчном отрезке вычислены без ошибок, то взять за главное- макcимальное по модулю из них
   if (BErr = False) and (BErrC = False) then
   begin
      if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;
   end
   else
    //если последнее вычисленное значение без ошибки, то взять первое вычисленное без ошибок
   if  (BErrC = False)  then yf:=yf1NEu
   else   //иначе - последнее, вычисленное без ошибки
       yf:=yf2NEu;



  ywf:=((yf-YGF_min)*Hky);

  if abs(ywf) > MaxInt then
  begin
    if ywf > 0  then yw:=MaxInt else yw:=-MaxInt;
  end
  else  yw:=Trunc(ywf) ;




     YWminCf:=((Yfmin-YGF_min)*Hky);
     YWmaxCf:=((Yfmax-YGF_min)*Hky);

     if abs(YWminCf) > MaxInt then
     begin
        if YWminCf > 0  then YWminC:=MaxInt else YWminC:=-MaxInt;
     end
     else  YWminC:=Trunc(YWminCf);

     if abs(YWmaxCf) > MaxInt then
     begin
        if YWmaxCf > 0  then YWmaxC:=MaxInt else YWmaxC:=-MaxInt;
     end
     else  YWmaxC:=Trunc(YWmaxCf);



    // BWout:=False;
     if (YWmaxC > YWmax) or (YWminC < 0) then    BWout:=True;



     if ((YWmaxC > YWmax) and (YWminC < 0)) and (BErrC = False) then
     begin

             if Bdyf = True then    //dyf > 0
             begin
                if BFirst = True  then
                begin
                   btm.canvas.MoveTo(xw+1,YWmax);
                   BFirst := False;
                 end
                 else
                 begin
                   btm.canvas.LineTo(xw,0);
                   btm.canvas.MoveTo(xw+1,YWmax);
                 end;
              end
              else
              begin
                if BFirst = True  then
                begin
                    btm.canvas.MoveTo(xw+1,0);
                    BFirst := False;
                 end
                 else
                 begin
                    btm.canvas.LineTo(xw,YWmax);
                    btm.canvas.MoveTo(xw+1,0);
                 end;
             end;

     end
     else
         //res=sin(x)^cos(x)
         //res=asin(x)
     begin

      // btm.canvas.LineTo(xw,YWmax-yw);  // ln(-x)     ln(sin(x))
          //если нет ошибок           //BNoErrU = True => если на единичном отрезке есть вычисляемая без ошибок точка, то использовать её для построения
        if (BErrC{BErr} = False) or  (BNoErrU = True) then    //BErrC - текущая ошибка
        begin

           if BFirst = True  then      //первая точка
           begin
                 //ln(x)
                if BWout = True then   //выход за пределы окна отображения
                begin
                   //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                   if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                          //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                           btm.canvas.MoveTo(xw+1,0)
                end
                else
                begin    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                   btm.canvas.MoveTo(xw,YWmax-yw);
                end;
                BFirst := False;
           end
           else    //остальные
           begin
                (*
                 //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  if {BErr0}BErrC0 =  True then   btm.canvas.MoveTo(xw,YWmax-yw)
                            //ошибки нет в предыдущем и текущем => соединить точки линией
                     else   btm.canvas.LineTo(xw,YWmax-yw);
                   *)

                 //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  if {BErr0}BErrC0 =  True then
                  begin
                       //btm.canvas.MoveTo(xw,YWmax-yw)

                       //проверить на выход из окна:
                        if BWout = True then   //выход за пределы окна отображения
                        begin
                            //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                             if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                             //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                                     btm.canvas.MoveTo(xw+1,0)
                        end
                        else    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                        btm.canvas.MoveTo(xw,YWmax-yw)

                  end
                  //ошибки нет в предыдущем и текущем => соединить точки линией
                  else
                  begin
                       btm.canvas.LineTo(xw,YWmax-yw);
                  end;

           end;

        end
        (*
        else
        //ln(-x)     ln(sin(x))
        if BNoErrU = True then  //если на единичном отрезке есть вычисляемая без ошибок точка, то использовать её для построения
        begin
                if BFirst = True  then      //первая точка
                begin
                   //ln(x)
                    if BWout = True then   //выход за пределы окна отображения
                    begin
                      //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                       if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                          //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                           btm.canvas.MoveTo(xw+1,0)
                    end
                    else
                    begin    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                       btm.canvas.MoveTo(xw,YWmax-yw);
                    end;
                    BFirst := False;
                end
                else
                begin         //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  {
                  if {BErr0}BErrC0 =  True then   btm.canvas.MoveTo(xw,YWmax-yw)
                            //ошибки нет в предыдущем и текущем => соединить точки линией
                     else   btm.canvas.LineTo(xw,YWmax-yw);

                  }

                   //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  if {BErr0}BErrC0 =  True then
                  begin
                       //btm.canvas.MoveTo(xw,YWmax-yw)

                       //проверить на выход из окна:
                        if BWout = True then   //выход за пределы окна отображения
                        begin
                            //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                             if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                             //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                                     btm.canvas.MoveTo(xw+1,0)
                        end
                        else    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                        btm.canvas.MoveTo(xw,YWmax-yw)

                  end
                  //ошибки нет в предыдущем и текущем => соединить точки линией
                  else
                  begin
                       btm.canvas.LineTo(xw,YWmax-yw);
                  end;

                end;
        end;
        *)

    end;



     yf0:=yf;
     yw0:=yw;
     xw0:=xw;


   nxtForK2:
    BWout0:=BWout;
    BErrC0:=BErrC;
    BErr0:=BErr;
end;

except

end;



//COORD
yw:=Trunc((0-YGF_min)*Hky);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;

btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);



xw:=Trunc((0-XGF_min)*Hkx);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;//rgb($00,$FF,$FF) ;

btm.canvas.MoveTo(xw,0);
btm.canvas.LineTo(xw,YWmax);

{
btm.canvas.Pen.Color := clGreen;
btm.canvas.Pen.Style := psSolid;
btm.canvas.Brush.Color:= clGreen;
btm.canvas.Brush.Style := bsSolid;
btm.canvas.Pen.Width := 1;
Rp:=4;
Xp:=100; Yp:=100;
btm.canvas.Ellipse(Xp - Rp, Yp - Rp, Xp + Rp, Yp + Rp );
}
{
_SetPointColor(50,155,50);
_SetPointSize(4);
_SetPointW(100,100);
}

//btm.canvas.Pen.Color:=clSilver;
if ShowImg <> 0 then
   Form1.Image1.picture.Bitmap.Assign(btm);

btm.canvas.Pen.Color:=clSilver;
//goto endp;




endp:
end;



procedure TForm1.DrawGraph2D;
label endp,nxtForK1,nxtForK2,nxtForK0;
var
 ix,iy,k: integer;
 re,im,x,y,hx,hy,r: extended;
 //fz: TComplexEx;
 cr,cg,cb,cl: Cardinal;

 xw,xw0,yw0,KG, XWmax,YWmax,Err: Cardinal;

 yw,yw1,yw2,ywl,YWminC,YWmaxC: Integer;
 {xf,}yf,Kx,Ky,Hkg,Hky,Hkx,Yfmax,Yfmin,xf1,xf2: extended;
 xfmax0,xfmin0,Yfmax0,Yfmin0,yf0,xf0,dyf,dyfUP,yfUP,yf1NEu,yf2NEu: extended;
 YGF_min,YGF_max,XGF_min,XGF_max: extended;
 ywf,YWminCf,YWmaxCf: extended;

 Bdyf,BdyfUP,Bchgdyf,BErrC: Boolean;

 BFirst, BErr, BErr0, BWout0, BWout, BFirstUP, BErrC0, BNoErrU, BFirstNE: Boolean;
 _Rise, _Fall, gradY_u: integer;

 Rp,Xp,Yp :Integer;
begin

 _Rise:=2;
 _Fall:=1;





btm.canvas.Pen.Width:=PenWidth;//1;
btm.canvas.Pen.Style:=PenStyle;//psSolid;
btm.canvas.Pen.Color:=PenColor;//clBlue;


{
XGF_min:=-2;
XGF_max:=30;


YGF_min:=-7;
YGF_max:=30;
}


XGF_min:=Xmin;
XGF_max:=Xmax;

YGF_min:=Ymin;
YGF_max:=Ymax;


Set8087CW($1332);
flSet(fl_Enable, fl_MASK_FPU_EXCEPTION, 0);

hx:=(XGF_max-XGF_min)/Image1.Width;
hy:=(YGF_max-YGF_min)/Image1.Height;
im:=Ymin;

XWmax:=Image1.Width;
YWmax:=Image1.Height;


KG:=KDens;

xw:=Image1.Width;
xf:=XGF_min;
Kx:=abs(XGF_max-XGF_min)/XWmax;
Ky:=abs(YGF_max-YGF_min)/YWmax;
Hkg:=1/KG;
Hky:=1/Ky;
Hkx:=1/Kx;



BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;


BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;
BErr0:=False;
BErrC0:=False;
BWout0:=False;
BWout:=False;
BErr:=False;

//next  points
try
for xw :=  0 to XWmax do
//xw:=1;
//while xw <= XWmax do
begin
   //xf := XGF_min + Kx*xw;



    Bchgdyf:=False;   //смена градиента приращений по y
    BWout0:=False;
    BErr:=False;
    BFirstUP:=False;
    BWout:=False;
    BNoErrU:=False; //если хоть раз на единичном интервале есть вычисляемый без ошибки рез-т, то BNoErrU:=True
    BFirstNE:=False; //флаг первой вычисленного без ошибки значения

    //цикл по единичному отрезку
    for k := 0 to KG do
    begin
       xf := XGF_min + Kx*(xw+k*Hkg);

       //flResultSafeE(ZFunc,yf);
                BErrC:=False;
                {
                try
                   asm
                     call ZFunc
                   end;
                except
                   //on E: Exception do BErr:=True;
                   on E: EZeroDivide      do begin BErr:=True;  BErrC:=True; end;
                   on E: EInvalidOp       do begin BErr:=True;  BErrC:=True; end;
                   on E: EOverFlow        do begin BErr:=True;  BErrC:=True; end;
                end;
                }
                MaskException;
                    asm
                     call ZFunc
                    end;
               if _IfException = 1 then
               begin
                  BErr:=True;  BErrC:=True;
               end
                else BNoErrU:=True;

                 //не все ф-ии вызывают исключения. Некоторые возвращают вместо ошибки - NaN
                //BErrC:=BErr;
                if (IsNaN(ResultR)=True) then
                begin

                  BErr:=True;
                  BErrC:=True;
                  //goto nxtForK2;
                  goto nxtForK1;
                end;


                yf:=ResultR;
                 //для первой точки на единичном отрезке  [xw,xw+1] c шагом h=1/KG
                if (((k = 0) and (BErr = False)) or ((BErr = True) and (BErrC = False))) and (BFirstUP=False)  then
                //if k = 0 then
                begin
                   Yfmax:=yf;
                   Yfmin:=yf;
                   YfUP:=yf;

                   //dyf:=yf-yf0;   //градиент приращений по y
                   //if dyf > 0  then Bdyf:=True else Bdyf:=False;
                   Bchgdyf:=False;   //смена градиента приращений по y
                   BFirstUP:=True; //флаг, первая точка из единичного отрезка обсчитана,
                   yf1NEu:=yf;  //  BFirstNE = True;  первое вычисленное без ошибки значение на единичном отрезке
                   BFirstNE := True;
                   goto nxtForK1;
                end
                else
                if BErrC = True  then     goto nxtForK1;


         if yf > Yfmax then begin Yfmax:=yf; xf2:=xf; end;
         if yf < Yfmin then begin Yfmin:=yf; xf1:=xf; end;


         //фиксация первого вычисленного без ошибки значения на единичном отрезке        sqrt(sin(x))
         if  (BErr = True) and (BErrC = False) and (BFirstNE = False) then begin yf1NEu:=yf; BFirstNE := True end;

          //последнее вычисленное без ошибки значения на единичном отрезке        sqrt(sin(x))
         if BErrC = False then    yf2NEu:=yf;




         dyfUP:=yf-yfUP;  yfUP:=yf;
         if dyfUP > 0  then BdyfUP:=True else BdyfUP:=False;
         if dyfUP > 0 then gradY_u:=_Rise else  gradY_u:=_Fall;

         //регистрировать смену приращений градиента по Y, если значения Y вышли за пределы окна
         //
         if (Bchgdyf = False) and ((Yfmax > YGF_max) or (Yfmin < YGF_min))  {((YWmaxC > YWmax) or (YWminC < 0)) }then
         begin
           //сравнить предыдущее с текущим значением градиета по Y
           //если оно изменилось, то зафиксировать предыдущее значение и установить флаг смены приращений по Y:
           //  Bchgdyf = True
           if Bdyf <> BdyfUP then  Bchgdyf:=True;
         end
         else
         begin
            Bdyf:=BdyfUP;
         end;



      nxtForK1:
    end; //for k

        // ln(x)   ln(sin(x))
        // ln(-x) -ln(-x)

    //if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;

    //sqrt(sin(x))  ln(x-pi) ln(x+pi)  -ln(x-pi)  -ln(x+pi)
    //если все значения на единчном отрезке вычислены без ошибок, то взять за главное- макcимальное по модулю из них
   if (BErr = False) and (BErrC = False) then
   begin
      if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;
   end
   else
    //если последнее вычисленное значение без ошибки, то взять первое вычисленное без ошибок
   if  (BErrC = False)  then yf:=yf1NEu
   else   //иначе - последнее, вычисленное без ошибки
       yf:=yf2NEu;



  ywf:=((yf-YGF_min)*Hky);

  if abs(ywf) > MaxInt then
  begin
    if ywf > 0  then yw:=MaxInt else yw:=-MaxInt;
  end
  else  yw:=Trunc(ywf) ;




     YWminCf:=((Yfmin-YGF_min)*Hky);
     YWmaxCf:=((Yfmax-YGF_min)*Hky);

     if abs(YWminCf) > MaxInt then
     begin
        if YWminCf > 0  then YWminC:=MaxInt else YWminC:=-MaxInt;
     end
     else  YWminC:=Trunc(YWminCf);

     if abs(YWmaxCf) > MaxInt then
     begin
        if YWmaxCf > 0  then YWmaxC:=MaxInt else YWmaxC:=-MaxInt;
     end
     else  YWmaxC:=Trunc(YWmaxCf);



    // BWout:=False;
     if (YWmaxC > YWmax) or (YWminC < 0) then    BWout:=True;



     if ((YWmaxC > YWmax) and (YWminC < 0)) and (BErrC = False) then
     begin

             if Bdyf = True then    //dyf > 0
             begin
                if BFirst = True  then
                begin
                   btm.canvas.MoveTo(xw+1,YWmax);
                   BFirst := False;
                 end
                 else
                 begin
                   btm.canvas.LineTo(xw,0);
                   btm.canvas.MoveTo(xw+1,YWmax);
                 end;
              end
              else
              begin
                if BFirst = True  then
                begin
                    btm.canvas.MoveTo(xw+1,0);
                    BFirst := False;
                 end
                 else
                 begin
                    btm.canvas.LineTo(xw,YWmax);
                    btm.canvas.MoveTo(xw+1,0);
                 end;
             end;

     end
     else
         //res=sin(x)^cos(x)
         //res=asin(x)
     begin

      // btm.canvas.LineTo(xw,YWmax-yw);  // ln(-x)     ln(sin(x))
          //если нет ошибок           //BNoErrU = True => если на единичном отрезке есть вычисляемая без ошибок точка, то использовать её для построения
        if (BErrC{BErr} = False) or  (BNoErrU = True) then    //BErrC - текущая ошибка
        begin

           if BFirst = True  then      //первая точка
           begin
                 //ln(x)
                if BWout = True then   //выход за пределы окна отображения
                begin
                   //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                   if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                          //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                           btm.canvas.MoveTo(xw+1,0)
                end
                else
                begin    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                   btm.canvas.MoveTo(xw,YWmax-yw);
                end;
                BFirst := False;
           end
           else    //остальные
           begin
                (*
                 //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  if {BErr0}BErrC0 =  True then   btm.canvas.MoveTo(xw,YWmax-yw)
                            //ошибки нет в предыдущем и текущем => соединить точки линией
                     else   btm.canvas.LineTo(xw,YWmax-yw);
                   *)

                 //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  if {BErr0}BErrC0 =  True then
                  begin
                       //btm.canvas.MoveTo(xw,YWmax-yw)

                       //проверить на выход из окна:
                        if BWout = True then   //выход за пределы окна отображения
                        begin
                            //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                             if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                             //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                                     btm.canvas.MoveTo(xw+1,0)
                        end
                        else    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                        btm.canvas.MoveTo(xw,YWmax-yw)

                  end
                  //ошибки нет в предыдущем и текущем => соединить точки линией
                  else
                  begin
                       btm.canvas.LineTo(xw,YWmax-yw);
                  end;

           end;

        end
        (*
        else
        //ln(-x)     ln(sin(x))
        if BNoErrU = True then  //если на единичном отрезке есть вычисляемая без ошибок точка, то использовать её для построения
        begin
                if BFirst = True  then      //первая точка
                begin
                   //ln(x)
                    if BWout = True then   //выход за пределы окна отображения
                    begin
                      //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                       if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                          //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                           btm.canvas.MoveTo(xw+1,0)
                    end
                    else
                    begin    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                       btm.canvas.MoveTo(xw,YWmax-yw);
                    end;
                    BFirst := False;
                end
                else
                begin         //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  {
                  if {BErr0}BErrC0 =  True then   btm.canvas.MoveTo(xw,YWmax-yw)
                            //ошибки нет в предыдущем и текущем => соединить точки линией
                     else   btm.canvas.LineTo(xw,YWmax-yw);

                  }

                   //BErrC0 - ошибка в предыдущем расчёте => начать построение заново, линии не соединять
                  if {BErr0}BErrC0 =  True then
                  begin
                       //btm.canvas.MoveTo(xw,YWmax-yw)

                       //проверить на выход из окна:
                        if BWout = True then   //выход за пределы окна отображения
                        begin
                            //если ф-ия возрастает => установить начальную точку продлить  в верху окна
                             if gradY_u = _Rise then btm.canvas.MoveTo(xw+1,YWmax) else
                                             //если ф-ия убывает =>  установить начальную точку продлить  внизу окна
                                                     btm.canvas.MoveTo(xw+1,0)
                        end
                        else    //нет выхода за пределы окна => установить  начальную точку в её текущей координате
                        btm.canvas.MoveTo(xw,YWmax-yw)

                  end
                  //ошибки нет в предыдущем и текущем => соединить точки линией
                  else
                  begin
                       btm.canvas.LineTo(xw,YWmax-yw);
                  end;

                end;
        end;
        *)

    end;



     yf0:=yf;
     yw0:=yw;
     xw0:=xw;


   nxtForK2:
    BWout0:=BWout;
    BErrC0:=BErrC;
    BErr0:=BErr;
end;

except

end;



//COORD
yw:=Trunc((0-YGF_min)*Hky);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;

btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);



xw:=Trunc((0-XGF_min)*Hkx);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;//rgb($00,$FF,$FF) ;

btm.canvas.MoveTo(xw,0);
btm.canvas.LineTo(xw,YWmax);


{
btm.canvas.Pen.Color := clGreen;
btm.canvas.Pen.Style := psSolid;
btm.canvas.Brush.Color:= clGreen;
btm.canvas.Brush.Style := bsSolid;
btm.canvas.Pen.Width := 1;
Rp:=4;
Xp:=100; Yp:=100;
btm.canvas.Ellipse(Xp - Rp, Yp - Rp, Xp + Rp, Yp + Rp );
}
{
_SetPointColor(50,155,50);
_SetPointSize(4);
_SetPointW(100,100);
}

btm.canvas.Pen.Color:=clSilver;
Form1.Image1.picture.Bitmap.Assign(btm);

//goto endp;




endp:
end;





procedure TForm1.DrawGraph2D_FS;
label endp,nxtForK1,nxtForK2,nxtForK0;
var
 ix,iy,k: integer;
 re,im,x,y,hx,hy,r: extended;
 //fz: TComplexEx;
 cr,cg,cb,cl: Cardinal;

 xw,xw0,yw0,KG, XWmax,YWmax,Err: Cardinal;

 yw,yw1,yw2,ywl,YWminC,YWmaxC: Integer;
 {xf,}yf,Kx,Ky,Hkg,Hky,Hkx,Yfmax,Yfmin,xf1,xf2: extended;
 xfmax0,xfmin0,Yfmax0,Yfmin0,yf0,xf0,dyf,dyfUP,yfUP,yf1NEu,yf2NEu: extended;
 YGF_min,YGF_max,XGF_min,XGF_max: extended;
 ywf,YWminCf,YWmaxCf: extended;

 Bdyf,BdyfUP,Bchgdyf,BErrC: Boolean;

 BFirst, BErr, BErr0, BWout0, BWout, BFirstUP, BErrC0, BNoErrU, BFirstNE: Boolean;
 _Rise, _Fall, gradY_u: integer;

 Rp,Xp,Yp :Integer;
begin

 _Rise:=2;
 _Fall:=1;





btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clBlue;


{
XGF_min:=-2;
XGF_max:=30;


YGF_min:=-7;
YGF_max:=30;
}


XGF_min:=Xmin;
XGF_max:=Xmax;

YGF_min:=Ymin;
YGF_max:=Ymax;


Set8087CW($1332);
flSet(fl_Enable, fl_MASK_FPU_EXCEPTION, 0);

hx:=(XGF_max-XGF_min)/Image1.Width;
hy:=(YGF_max-YGF_min)/Image1.Height;
im:=Ymin;

XWmax:=Image1.Width;
YWmax:=Image1.Height;


KG:=1; //KG:=KDens;


xw:=Image1.Width;
xf:=XGF_min;
Kx:=abs(XGF_max-XGF_min)/XWmax;
Ky:=abs(YGF_max-YGF_min)/YWmax;
Hkg:=1/KG;
Hky:=1/Ky;
Hkx:=1/Kx;



BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;


BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;
BErr0:=False;
BErrC0:=False;
BWout0:=False;
BWout:=False;
BErr:=False;

//next  points
try
for xw :=  0 to XWmax do
//xw:=1;
//while xw <= XWmax do
begin
   //xf := XGF_min + Kx*xw;




      //xf := XGF_min + Kx*(xw+k*Hkg);
       xf := XGF_min + Kx*xw;
       yf:=sin(xf);
       ywf:=((yf-YGF_min)*Hky);



  if abs(ywf) > MaxInt then
  begin
    if ywf > 0  then yw:=MaxInt else yw:=-MaxInt;
  end
  else  yw:=Trunc(ywf) ;

       //if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;
       if BFirst = True then
       begin
           btm.canvas.MoveTo(xw,YWmax-yw);
           BFirst := False;
       end
       else
       begin
           btm.canvas.LineTo(xw,YWmax-yw);
       end;

       goto nxtForK2;





   nxtForK2:
    
end;

except

end;



//COORD
yw:=Trunc((0-YGF_min)*Hky);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;

btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);



xw:=Trunc((0-XGF_min)*Hkx);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;//rgb($00,$FF,$FF) ;

btm.canvas.MoveTo(xw,0);
btm.canvas.LineTo(xw,YWmax);


{
btm.canvas.Pen.Color := clGreen;
btm.canvas.Pen.Style := psSolid;
btm.canvas.Brush.Color:= clGreen;
btm.canvas.Brush.Style := bsSolid;
btm.canvas.Pen.Width := 1;
Rp:=4;
Xp:=100; Yp:=100;
btm.canvas.Ellipse(Xp - Rp, Yp - Rp, Xp + Rp, Yp + Rp );
}
{
_SetPointColor(50,155,50);
_SetPointSize(4);
_SetPointW(100,100);
}

btm.canvas.Pen.Color:=clSilver;
Form1.Image1.picture.Bitmap.Assign(btm);

//goto endp;




endp:
end;





procedure TForm1.DrawGraph2DFourier;
label endp,nxtForK1,nxtForK2,nxtForK0;
var
 ix,iy,k: integer;
 re,im,x,y,hx,hy,r: extended;
 //fz: TComplexEx;
 cr,cg,cb,cl: Cardinal;

 xw,xw0,yw0,KG, XWmax,YWmax,Err: Cardinal;

 yw,yw1,yw2,ywl,YWminC,YWmaxC: Integer;
 {xf,}yf,Kx,Ky,Hkg,Hky,Hkx,Yfmax,Yfmin,xf1,xf2: extended;
 xfmax0,xfmin0,Yfmax0,Yfmin0,yf0,xf0,dyf,dyfUP,yfUP,yf1NEu,yf2NEu: extended;
 YGF_min,YGF_max,XGF_min,XGF_max: extended;
 ywf,YWminCf,YWmaxCf: extended;

 Bdyf,BdyfUP,Bchgdyf,BErrC: Boolean;

 BFirst, BErr, BErr0, BWout0, BWout, BFirstUP, BErrC0, BNoErrU, BFirstNE: Boolean;
 _Rise, _Fall, gradY_u: integer;

 Rp,Xp,Yp :Integer;
begin

//A=10; T=10; a=5; A/T*(a*x-T*trunc(a*x/T))

 _Rise:=2;
 _Fall:=1;





btm.canvas.Pen.Width:=PenWidth;//1;
btm.canvas.Pen.Style:=PenStyle;//psSolid;
btm.canvas.Pen.Color:=PenColor;//clBlue;



{
XGF_min:=-2;
XGF_max:=30;


YGF_min:=-7;
YGF_max:=30;
}


XGF_min:=Xmin;
XGF_max:=Xmax;

YGF_min:=Ymin;
YGF_max:=Ymax;


Set8087CW($1332);
flSet(fl_Enable, fl_MASK_FPU_EXCEPTION, 0);

hx:=(XGF_max-XGF_min)/Image1.Width;
hy:=(YGF_max-YGF_min)/Image1.Height;
im:=Ymin;

XWmax:=Image1.Width;
YWmax:=Image1.Height;


KG:=1; //KG:=KDens;


xw:=Image1.Width;
xf:=XGF_min;
Kx:=abs(XGF_max-XGF_min)/XWmax;
Ky:=abs(YGF_max-YGF_min)/YWmax;
Hkg:=1/KG;
Hky:=1/Ky;
Hkx:=1/Kx;



BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;



yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResultR:=0;
BErr0:=False;
BErrC0:=False;
BWout0:=False;
BWout:=False;
BErr:=False;

//next  points
try
for xw :=  0 to XWmax do
//xw:=1;
//while xw <= XWmax do
begin
   //xf := XGF_min + Kx*xw;




      //xf := XGF_min + Kx*(xw+k*Hkg);
       xf := XGF_min + Kx*xw;
       //yf:=sin(xf);
       yf:=EvalFourieFunc(xf,FourierA,FourierB);
       ywf:=((yf-YGF_min)*Hky);



  if abs(ywf) > MaxInt then
  begin
    if ywf > 0  then yw:=MaxInt else yw:=-MaxInt;
  end
  else  yw:=Trunc(ywf) ;

       //if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;
       if BFirst = True then
       begin
           btm.canvas.MoveTo(xw,YWmax-yw);
           BFirst := False;
       end
       else
       begin
           btm.canvas.LineTo(xw,YWmax-yw);
       end;

   nxtForK2:

end;

except

end;



//COORD
yw:=Trunc((0-YGF_min)*Hky);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=rgb(170,100,100);//clRed;

btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);



xw:=Trunc((0-XGF_min)*Hkx);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=rgb(170,100,100);//clRed;//rgb($00,$FF,$FF) ;

btm.canvas.MoveTo(xw,0);
btm.canvas.LineTo(xw,YWmax);


{
btm.canvas.Pen.Color := clGreen;
btm.canvas.Pen.Style := psSolid;
btm.canvas.Brush.Color:= clGreen;
btm.canvas.Brush.Style := bsSolid;
btm.canvas.Pen.Width := 1;
Rp:=4;
Xp:=100; Yp:=100;
btm.canvas.Ellipse(Xp - Rp, Yp - Rp, Xp + Rp, Yp + Rp );
}
{
_SetPointColor(50,155,50);
_SetPointSize(4);
_SetPointW(100,100);
}

btm.canvas.Pen.Color:=clSilver;
Form1.Image1.picture.Bitmap.Assign(btm);

//goto endp;




endp:
end;



(*

procedure TForm1.DrawGraph2D;
label endp,nxtForK1,nxtForK2,nxtForK0;
var
 ix,iy,k: integer;
 re,im,x,y,hx,hy,r: extended;
 //fz: TComplexEx;
 cr,cg,cb,cl: Cardinal;

 xw,xw0,yw0,KG, XWmax,YWmax,Err: Cardinal;

 yw,yw1,yw2,ywl,YWminC,YWmaxC: Integer;
 {xf,}yf,Kx,Ky,Hkg,Hky,Hkx,Yfmax,Yfmin,xf1,xf2: extended;
 xfmax0,xfmin0,Yfmax0,Yfmin0,yf0,xf0,dyf,dyft,yft: extended;
 YGF_min,YGF_max,XGF_min,XGF_max: extended;
 ywf,YWminCf,YWmaxCf: extended;

 Bdyf,Bdyft,Bchgdyf,BErrC: Boolean;

 BFirst, BErr, BErr0, BWout0, BWout: Boolean;
begin






btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clBlue;


{
XGF_min:=-2;
XGF_max:=30;


YGF_min:=-7;
YGF_max:=30;
}


XGF_min:=Xmin;
XGF_max:=Xmax;

YGF_min:=Ymin;
YGF_max:=Ymax;


Set8087CW($1332);
flSet(fl_Enable, fl_MASK_FPU_EXCEPTION, 0);

hx:=(XGF_max-XGF_min)/Image1.Width;
hy:=(YGF_max-YGF_min)/Image1.Height;
im:=Ymin;

XWmax:=Image1.Width;
YWmax:=Image1.Height;


KG:=KDens;

xw:=Image1.Width;
xf:=XGF_min;
Kx:=abs(XGF_max-XGF_min)/XWmax;
Ky:=abs(YGF_max-YGF_min)/YWmax;
Hkg:=1/KG;
Hky:=1/Ky;
Hkx:=1/Kx;



BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResE:=0;


BFirst:=True;

yf:=0;
yf0:=0;
Yfmax0:=0;
Yfmin0:=0;
Yfmax:=0;
Yfmin:=0;
ResE:=0;
BErr0:=False;
BWout0:=False;
BWout:=False;
BErr:=False;

//next  points
try
for xw :=  0 to XWmax do
//xw:=1;
//while xw <= XWmax do
begin
   xf := XGF_min + Kx*xw;

   //flResultSafeE(ZFunc,yf);
                 BErr:=False;
                try
                   asm
                     call ZFunc
                   end;
                except
                  //on E: Exception do BErr:=True;
                   on E: EZeroDivide      do BErr:=True;
                   on E: EInvalidOp       do BErr:=True;
                   on E: EOverFlow        do BErr:=True;
                end;
                if (IsNaN(ResE)=True) {or (BErr = True)} then begin  BErr:=True; goto nxtForK2; end;
                //if BErr = True then BErr0:=True;
                yf:=ResE;


   //BWout0:=False;

   Yfmax:=yf;
   Yfmin:=yf;
   yft:=yf;

   dyf:=yf-yf0;   //градиент приращений по y
   if dyf > 0  then Bdyf:=True else Bdyf:=False;
   // Bdyf > 0 =>  приращение по y растёт иначе падает
   Bchgdyf:=False;   //смена градиента приращений по y

    BErr:=False;
    for k := 0 to KG do
    begin
       xf := XGF_min + Kx*(xw+k*Hkg);

       //flResultSafeE(ZFunc,yf);
                BErrC:=False;
                try
                   asm
                     call ZFunc
                   end;
                except
                   //on E: Exception do BErr:=True;
                   on E: EZeroDivide      do BErr:=True;
                   on E: EInvalidOp       do BErr:=True;
                   on E: EOverFlow        do BErr:=True;
                end;
                BErrC:=BErr;
                if (IsNaN(ResE)=True) then
                begin

                  BErr:=True;
                  goto nxtForK2;
                end;


                yf:=ResE;


       if yf > Yfmax then begin Yfmax:=yf; xf2:=xf; end;
       if yf < Yfmin then begin Yfmin:=yf; xf1:=xf; end;




       dyft:=yf-yft;  yft:=yf;
       if dyft > 0  then Bdyft:=True else Bdyft:=False;

       //регистрировать смену приращений градиента по Y, если значения Y вышли за пределы окна
       //
       if (Bchgdyf = False) and ((YWmaxC > YWmax) or (YWminC < 0)) then
       begin
         //сравнить предыдущее с текущим значением градиета по Y
         //если оно изменилось, то зафиксировать предыдущее значение и установить флаг смены приращений по Y:
         //  Bchgdyf = True
         if Bdyf <> Bdyft then  Bchgdyf:=True;
       end
       else
       begin
          Bdyf:=Bdyft;
       end;




    end; //for k



  if abs(Yfmax) > abs(Yfmin) then yf:=Yfmax else yf:=Yfmin;


  ywf:=((yf-YGF_min)*Hky);

  if abs(ywf) > MaxInt then
  begin
    if ywf > 0  then yw:=MaxInt else yw:=-MaxInt;
  end
  else  yw:=Trunc(ywf) ;




     YWminCf:=((Yfmin-YGF_min)*Hky);
     YWmaxCf:=((Yfmax-YGF_min)*Hky);

     if abs(YWminCf) > MaxInt then
     begin
        if YWminCf > 0  then YWminC:=MaxInt else YWminC:=-MaxInt;
     end
     else  YWminC:=Trunc(YWminCf);

     if abs(YWmaxCf) > MaxInt then
     begin
        if YWmaxCf > 0  then YWmaxC:=MaxInt else YWmaxC:=-MaxInt;
     end
     else  YWmaxC:=Trunc(YWmaxCf);



     BWout:=False;
     if (YWmaxC > YWmax) or (YWminC < 0) then    BWout:=True;



     if ((YWmaxC > YWmax) and (YWminC < 0)) and (BErr = False) then
     begin

             if Bdyf = True then    //dyf > 0
             begin
                if BFirst = True  then
                begin
                   btm.canvas.MoveTo(xw+1,YWmax);
                   BFirst := False;
                 end
                 else
                 begin
                   btm.canvas.LineTo(xw,0);
                   btm.canvas.MoveTo(xw+1,YWmax);
                 end;
              end
              else
              begin
                if BFirst = True  then
                begin
                    btm.canvas.MoveTo(xw+1,0);
                    BFirst := False;
                 end
                 else
                 begin
                    btm.canvas.LineTo(xw,YWmax);
                    btm.canvas.MoveTo(xw+1,0);
                 end;
             end;

     end
     else
         //res=sin(x)^cos(x)
         //res=asin(x)
     begin

      // btm.canvas.LineTo(xw,YWmax-yw);

        if BErr = False then
        begin
           if BFirst = True  then
           begin
                   btm.canvas.MoveTo(xw,YWmax-yw);
                   BFirst := False;
           end
           else
           begin
                  if BErr0 =  True then   btm.canvas.MoveTo(xw,YWmax-yw)
                     else   btm.canvas.LineTo(xw,YWmax-yw);
           end;
        end;

    end;



     yf0:=yf;
     yw0:=yw;
     xw0:=xw;


   nxtForK2:
    BWout0:=BWout;
    BErr0:=BErr;
end;

except

end;



//COORD
yw:=Trunc((0-YGF_min)*Hky);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;

btm.canvas.MoveTo(0,YWmax-yw);
btm.canvas.LineTo(XWmax,YWmax-yw);



xw:=Trunc((0-XGF_min)*Hkx);

btm.canvas.Pen.Width:=1;
btm.canvas.Pen.Style:=psSolid;
btm.canvas.Pen.Color:=clRed;//rgb($00,$FF,$FF) ;

btm.canvas.MoveTo(xw,0);
btm.canvas.LineTo(xw,YWmax);


btm.canvas.Pen.Color:=clSilver;
Form1.Image1.picture.Bitmap.Assign(btm);

//goto endp;




endp:
end;
 *)






procedure TForm1.FormPaint(Sender: TObject);
begin

if Gr_Mode = _ComplexDynDraw then
begin
  PFLD.Update;
  SwapBuffers(DC);

  wglMakeCurrent(0,0);
  wglMakeCurrent(DC, hrc);
end;
end;



procedure TForm1.ShowError;
label endp;
var
S,S1,SE,SEF: String;
Error,EIntrnl: Cardinal;
PC: PChar;
Ans: AnsiString;
str:TStringType;
ws: widestring;
P: Pointer;
PAC: PAnsiChar;
su8: UTF8String;
begin
flGetErrorCode(Error);
if Error
 = 0 then goto endp;
 case  Error of
   fl_UNKNOWN_SYMBOL:                       S:='UNKNOWN SYMBOL or INCORRECT ARGUMENT or WRONG EXPRESSION';
   fl_MISSING_ROUND_BRACKET:                S:='MISSING ROUND BRACKET';
   fl_MISSING_OPERATION:                    S:='MISSING OPERATION';
   fl_WRONG_NUMBER_ARGUMENTS:               S:='WRONG NUMBER ARGUMENTS';
   fl_MISSING_EXPRESSION:                   S:='MISSING EXPRESSION';
   fl_UNKNOWN_FUNCTION:                     S:='UNKNOWN FUNCTION';
   fl_UNKNOWN_ARRAY:                        S:='UNKNOWN ARRAY';
   fl_ERROR_AT_ADDITION_FUNCTION:           S:='ERROR AT ADDITION FUNCTION';
   fl_NOT_DEFINED_OPERATOR:                 S:='NOT DEFINED OPERATOR';
   fl_NOT_DEFINED_FUNCTION:                 S:='NOT DEFINED FUNCTION';
   fl_INCORRECT_ARGUMENT:                   S:='WRONG TYPE OF ARGUMENT';
   fl_MISSING_ARGUMENT:                     S:='MISSING ARGUMENT';
   fl_INTERNAL_ERROR:                       S:='INTERNAL ERROR or  UNCATCHABLE SYNTAX ERROR';
   fl_CALCULATION_ERROR:                    S:='INTERNAL ERROR AT CALCULATION';
   fl_INCORRECT_TYPE:                       S:='WRONG TYPE' ;
   fl_WRONG_NAME:                           S:='WRONG NAME';
   fl_MISSING_SQUARE_BRACKET:               S:='MISSING SQUARE BRACKET';
   fl_MISSING_CURLY_BRACKET:                S:='MISSING CURLY BRACKET';
   fl_MISSING_ABS_BRACKET:                  S:='MISSING ABS BRACKET';
   fl_WRONG_EXPRESSION:                     S:='WRONG EXPRESSION';
   fl_ABSENT_LOAD_FUNCTION_FOR_TYPE:        S:='ABSENT LOAD FUNCTION FOR TYPE';
   fl_MISSING_SEPARATOR:                    S:='MISSING SEPARATOR OR OPERATION';
   fl_INCORRECT_SPACE:                      S:='INCORRECT SPACE';
   fl_VARIABLE_REDECLARED:                  S:='VARIABLE REDECLARED';
   fl_WRONG_PASSED_DATA:                    S:='WRONG PASSED DATA';
   fl_NO_DIFF_SYMBOLIC:                     S:='NOT DIFFERENTIATED SYMBOLICALLY';
   fl_INTERNAL_ERROR_AT_DIFF:               S:='INTERNAL ERROR AT DIFF or UNCATCHABLE SYNTAX ERROR';
   fl_WRONG_SYMBOL:                         S:='WRONG SYMBOL';
   fl_VOID_EXPRESSION:                      S:='VOID EXPRESSION';
   fl_NO_RETURN_NUMBER:                     S:='NO RETURN NUMBER';
   fl_PROHIBITED_SYMBOL:                    S:='PROHIBITED SYMBOL';
   fl_NO_FUNCTION_ARGUMENT:                 S:='NO FUNCTION ARGUMENT';
   fl_NO_APPLICABLE_TO_EXTERNAL_ARRAY:      S:='NO APPLICABLE TO EXTERNAL ARRAY';
   fl_MULTI_EXPR_DISABLE:                   S:='MULTI EXPRESSIONS ARE DISABLE';
   fl_LABEL_IN_GOTO_NOT_SET:                S:='LABEL IN GOTO NOT SET';
   fl_NO_APPLICABLE_TO_PASSED_ARRAY:        S:='NO APPLICABLE TO PASSED ARRAY';
   fl_NAME_ALREADY_USED:                    S:='NAME ALREADY USED';
   fl_WRONG_PLACEMENT_OPERATOR:             S:='WRONG PLACEMENT OPERATOR';
   fl_ERROR_AT_ADDITION_OF_OPERATOR:        S:='ERROR AT ADDITION OF OPERATOR';
   fl_UNKNOWN_VARIABLE:                     S:='UNKNOWN VARIABLE';
   fl_INVALID_FPU_LOADING:                  S:='EXPRESSION MUST BE SAVE RESULT';
   //fl_ABSENT_OR_WRONG_SEMICOLON:            S:='ABSENT OR WRONG SEMICOLON'
   else                                     S:='UNKNOWN SYNTAX ERROR';       //for compability with next vers.
  end;



  flGet(fl_INTERNAL_ERROR_CODE,0,EIntrnl);  //addition info about error
  if EIntrnl <> 0 then
  begin
    case EIntrnl of
      fl_ZERO_DIVIDE:          SE:= 'ZERO DIVIDE';
      fl_INVALID_OPERATION:    SE:= 'INVALID OPERATION';
      fl_OVERFLOW:             SE:= 'OVERFLOW';
      fl_UNDERFLOW:            SE:= 'UNDERFLOW';
      fl_ACCESS_VIOLATION:     SE:= 'ACCESS VIOLATION';
      fl_OUT_OF_MEMORY:        SE:= 'OUT OF MEMORY';
      fl_STACK_OVERFLOW:       SE:= 'STACK OVERFLOW';
    end;
  end;

  if F_DefFunc = True then SEF:= '  in function:  '+S_FuncName else SEF:='';

   MessageBeep(MB_ICONHAND);

  {$IFDEF STRINGINT}
    flGetErrorString(Str);
    MessageDlg(S+#13#10+SE+#13#10+'"'+Str+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0);
    //MessageDlg(S+#13#10+'"'+Str+'"',mtError,[mbOk],0);
  {$ELSE}
    flGetErrorString(P);
  {$ENDIF}

(*
   {$IFDEF ANSISTRING}       Ans:=AnsiString(P);    MessageDlg(S+#13#10+'"'+{PAnsiChar(Str)}Ans+'"',mtError,[mbOk],0);      {$ENDIF}
   {$IFDEF STRING}           Str:=String(P);        MessageDlg(S+#13#10+'"'+Str+'"',mtError,[mbOk],0);      {$ENDIF}
   {$IFDEF WIDESTRING}       ws:=WideString(P);     MessageDlg(S+#13#10+'"'+ws+'"',mtError,[mbOk],0);    {$ENDIF}
   {$IFDEF PANSICHAR}        PAC:=PAnsiChar(P);     MessageDlg(S+#13#10+'"'+PAC+'"',mtError,[mbOk],0);      {$ENDIF}
   {$IFDEF UTF8}             su8:=UTF8String(P);    MessageDlg(S+#13#10+'"'+su8+'"',mtError,[mbOk],0);    {$ENDIF}
*)


 //так лучше: сначала копирование строки затем обнуление - поможет избежать возможных ошибок, связанных с передачей строк (конфликт разных менеджеров памяти)
 //it's better: at first,  copying of a string then reset - will help to avoid the possible mistakes connected with transfer of strings  (the conflict of different managers of memory)

  {$IFDEF ANSISTRING}       Ans:=AnsiString(P);    S1:=Copy(Ans,1,Length(Ans)); Ans:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}
  {$IFDEF STRING}           Str:=String(P);        S1:=Copy(Str,1,Length(Str)); Str:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}
  {$IFDEF WIDESTRING}       ws:=WideString(P);     S1:=Copy(ws,1,Length(ws));   ws:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0);{$ENDIF}
  {$IFDEF UTF8}             su8:=UTF8String(P);    S1:=Copy(Su8,1,Length(Su8)); Su8:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}
  {$IFDEF PANSICHAR}        PAC:=PAnsiChar(P);     Ans:=AnsiString(PAC); S1:=Copy(Ans,1,Length(Ans)); Ans:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}


endp:
end;




procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var
NS: Integer;
begin


if Button = btNext then
begin
  inc(NSc) ;
  if (NSc = -1) or (NSc = 0)  then NSc:=1;
end
else
if Button = btPrev then
begin
  dec(NSc);
  if NSc = 0  then NSc:=-2;
end;


 if NSc < 0 then
   Sc:=abs(1/NSc)
 else
   Sc:=NSc;

ES.Text:=IntToStr(NSc);

 if F_AutoReDraw = True then BDrawClick(Self);

end;

procedure TForm1.Edit3Enter(Sender: TObject);
begin
  //Ymin:=StrToFloat(edit3.Text,G_FMT);
end;

procedure TForm1.Edit4Enter(Sender: TObject);
begin
    //Ymax:=StrToFloat(edit4.Text,G_FMT);
end;

procedure TForm1.E_DensChange(Sender: TObject);
begin
 //KDens:=StrToInt(E_Dens.Text);
end;



function TForm1.CallFSafe(Func: Pointer): Extended;
var
_Res: Extended;
_Err: Boolean;
begin
  _Err:=False;

  MaskException;
   asm
    call Func
   end;
   if _IfException = 1 then
   begin
    _Err:=True;
   end;

   //не все ф-ии вызывают исключения. Некоторые возвращают вместо ошибки - NaN

   if (IsNaN(ResultR)=True) then
   begin
      _Err:=True;
   end;

   if _Err = True then  CallFSafe:=0 else CallFSafe:=ResultR;

end;


function TForm1.Integral1(Func: Pointer;  PV: PExtended; a,b: Extended): Extended;
 {
  function CallFSafe(Func: Pointer): Extended;
  var
   Err: HRESULT;
   Res: Extended;
  begin
      Err:=flResultSafe(Func);
      if Err <> 0  then
      begin
        CallFSafe:=0
      end
      else CallFSafe:=ResultR;
  end;
   }
var
j,i,n:Integer;
x1,x2,Int,H1,hax,sx,ax,h,prf: Extended;
begin
//H1:=PV^;

//h:=H_Integral;
//n:=Trunc(abs(b-a)/h);
n:=abs(P_Integral);
if n = 0 then n:=1;
h:=(b-a)/n;




Int:=0;
for j:=0 to n-1 do
begin

 x1:=a+j*h; x2:=a+(j+1)*h;
 ax:=(x1+x2)*0.5; sx:=(x2-x1)*0.5;
 for i:=1 to N_Integral do
 begin
  PV^:=sx*bn[i]+ax;
  Int:=Int+an[i]*CallFSafe(Func)*sx;
 end;

end;



 Integral1:=Int;
// PV^:=H1;
end;



procedure TForm1.CreateFourierCoaff(Func: Pointer;  PV: PExtended; a,b: Extended);
  {
  function CallFSafe(Func: Pointer): Extended;
  var
   Err: HRESULT;
   Res: Extended;
  begin
      Err:=flResultSafe(Func);
      if Err <> 0  then  CallFSafe:=0 else CallFSafe:=ResultR;
  end;
  }
var
j,i,n:Integer;
x1,x2,Int,H1,hax,sx,ax,h,prf : Extended;
Lf,IntAf,IntBf, acos,bsin, IntF : Extended;
nfh: Integer;

begin

  //С ростом N_Harmonics должна расти точность интегрирования при вычислении коэфицентов P_Integral
if Trunc(N_Harmonics/10) > P_IntegralInit then P_Integral:=Trunc(N_Harmonics/10) else P_Integral:=P_IntegralInit;


SetLength(Afc,N_Harmonics);
SetLength(Bfc,N_Harmonics);
Lf:=abs(b-a);

A0fc:=Integral1(Func,PV,a,b)/Lf;




//h:=H_Integral;
//n:=Trunc(abs(b-a)/h);
n:=abs(P_Integral);
if n = 0 then n:=1;
h:=(b-a)/n;


for nfh := 1 to N_Harmonics do
begin


 IntAf:=0; IntBf:=0;

 for j:=0 to n-1 do
 begin

   x1:=a+j*h; x2:=a+(j+1)*h;
   ax:=(x1+x2)*0.5; sx:=(x2-x1)*0.5;

   for i:=1 to N_Integral do
   begin

     PV^:=sx*bn[i]+ax;
     IntF:=CallFSafe(Func);
     sincos(Pi*nfh*(PV^)/Lf,bsin,acos);

     IntAf:=IntAf+an[i]*IntF*acos*sx;
     IntBf:=IntBf+an[i]*IntF*bsin*sx;

     //Int:=Int+an[i]*IntF*sx;


   end;

 end;

 Afc[nfh-1]:=IntAf/Lf;
 Bfc[nfh-1]:=IntBf/Lf;

end;
   //Интервал вычисления текущего ряда Фурье
   FourierA:=a;
   FourierB:=b;

end;



function TForm1.EvalFourieFunc(x,a,b: Extended): Extended;
var
   Ffunc,SumF,Lf: Extended;
   nfh: Integer;
   acos,bsin: Extended;
begin

Lf:=abs(b-a);
SumF:=A0fc/2;

for nfh := 1 to N_Harmonics do
begin
   sincos(Pi*nfh*x/Lf,bsin,acos);
   SumF:=SumF+Afc[nfh-1]*acos+Bfc[nfh-1]*bsin;
end;

EvalFourieFunc:=SumF;
end;



procedure TForm1.InitIntegral;
var
k: Integer;
begin


 P_IntegralInit:=30; //начальное число разбиений
 P_Integral:=P_IntegralInit; //число разбиений при интегрировании

 N_Integral:=15;
 an[1]:=0.03075324199611726835; an[2]:=0.07036604748810812471;
 an[3]:=0.10715922046717193501; an[4]:=0.13957067792615431445;
 an[5]:=0.16626920581699393355; an[6]:=0.18616100001556221103;
 an[7]:=0.19843148532711157646; an[8]:=0.20257824192556127288;
 an[9]:=an[7];  an[10]:=an[6];  an[11]:=an[5]; an[12]:=an[4];
 an[13]:=an[3]; an[14]:=an[2];  an[15]:=an[1];
 bn[1]:=0.98799251802048542849; bn[2]:=0.93727339240070590431;
 bn[3]:=0.84820658341042721620; bn[4]:=0.72441773136017004742;
 bn[5]:=0.57097217260853884754; bn[6]:=0.39415134707756336990;
 bn[7]:=0.20119409399743452230; bn[8]:=0;
 bn[9]:=-bn[7]; bn[10]:=-bn[6]; bn[11]:=-bn[5]; bn[12]:=-bn[4];
 bn[13]:=-bn[3];bn[14]:=-bn[2]; bn[15]:=-bn[1];

 SetLength(Aint,N_Integral+1);  SetLength(Bint,N_Integral+1);

 for k := 1 to N_Integral do
 begin
   Aint[k]:=an[k];
   Bint[k]:=bn[k];
 end;

end;

end.



