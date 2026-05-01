unit Foreval_DiffNumeric;
{******************************************************************************}
{                                                                              }
{                               ver. 9.0.0.300A                                }
{------------------------------------------------------------------------------}
{                 Модуль численного дифференцирования                          }
{------------------------------------------------------------------------------}
{          The module of numerical calculation of derivatives                  }
{------------------------------------------------------------------------------}
{                SOREL (C)CopyRight 2000. Russia, S.-Petersburg.               }
{******************************************************************************}


//{$RangeChecks Off}
//{$OverFlowChecks Off}
//{$ZEROBASEDSTRINGS Off}

{$R-}
{$Q-}

{$IFDEF FPC}
   {$MODE DELPHI}
{$ENDIF}

interface

uses Foreval_Definitions,Math;


const NumberFact = 1754;

{***
const _Single = 1;
const _Double = 2;
const _Extended = 3;
 ***}
 {***
type
 TAddress = Cardinal;
 TFloatType = extended;
 PFloatType = ^TFloatType;
 ***}
type
 TArrayF = array of TFloat;
 TArrayX = array of extended;


 procedure CalcDiffCoeff;
 procedure CreateDiff(Np: integer; h: extended);
 procedure CreateFactMass;
 procedure InitDiff;


   function  A1_N: extended;
   function  A2_N: extended;
   function  A3_N: extended;
   function  A4_N: extended;
   function  A5_N: extended;
   function  A6_N: extended;
   function  A7_N: extended;
   function  A8_N: extended;
   function  A9_N: extended;
   function  A10_N: extended;
   function  A11_N: extended;
   function  A12_N: extended;
   function  A13_N: extended;
   function  A14_N: extended;
   function  A15_N: extended;
   function  A16_N: extended;
   function  A17_N: extended;
   function  A18_N: extended;
   function  A19_N: extended;
   function  A20_N: extended;

   function  Cnk(n,k: Integer): TFloat;
   function  DiffN(N: Integer; X: Double): extended;
   function  Factorial(N: Integer): TFloat;
   function  CalcFunc(Addr: TAddress): TFloat;
   function  Derivative1(Func,PV: TAddress; VType: Integer): TFloat;   stdcall;
   function  Derivative2(Func,PV: TAddress; VType: Integer): TFloat;   stdcall;
   function  Derivative3(Func,PV: TAddress; VType: Integer): TFloat;  stdcall;
   function  Derivative4(Func,PV: TAddress; VType: Integer): TFloat;  stdcall;
   function  DerivativeN(Func,PV: TAddress; VType: Integer; N: Integer): TFloat;  stdcall;
   function  Diff_N(Func,PV: TAddress; VType: Integer; N: Integer): TFloat;



implementation
var

 DiffL: Integer;
 DiffH: extended;
 D1,D2,D3,D4,D5: array of extended;
 DA,DD: TArrayX;
 Fact: TArrayF;



function CalcFunc(Addr: TAddress): TFloat;
asm
  call Addr
end;


procedure CreateDiff(Np: integer; h: extended);
begin
//порядок не менять
  DiffL:=Np;//14;    //3 <= DiffL <=20 порядок интерполяционного многочлена
  DiffH:=h;//0.001;
  CreateFactMass;
  InitDiff;
end;




procedure CreateFactMass;
var
i,j: integer;
S: TFloat;
begin                   //создание массива факториалов


SetLength(Fact,NumberFact+1);

S:=1;
for j:=1 to NumberFact do
begin
 S:=S*j;
 Fact[j]:=S;
end;
 Fact[0]:=1;
end;




function Derivative1(Func,PV: TAddress; VType: Integer): TFloat;
var
h,dy5,H1,xh,Yh,x0,rf,rd: TFloat;
i: Integer;
PS: PSingle;
PD: PDouble;
PE: PExtended;
begin
if VType = _Double then
begin
 PD:=PDouble(PV);

 x0:=PD^;

 h:=DiffH;
 xh:=PD^-DiffL*h*0.5;
 Yh:=0;

 for i:=0 to  DiffL do
 begin
  PD^:=xh;
  Yh:=Yh+D1[i]*CalcFunc(Func);
  xh:=xh+h;
 end;

 PD^:=x0;
end
else
if VType = _Single then
begin
 PS:=PSingle(PV);
 x0:=PS^;
 h:=DiffH;
 xh:=PS^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PS^:=xh;
  Yh:=Yh+D1[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PS^:=x0;
end
else
if VType = _Extended then
begin
 PE:=PExtended(PV);
 x0:=PE^;
 h:=DiffH;
 xh:=PE^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PE^:=xh;
  Yh:=Yh+D1[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PE^:=x0;
end;



Derivative1:=Yh/h;
end;





function Derivative2(Func,PV: TAddress; VType: Integer): TFloat;
var
h,dy5,H1,xh,Yh,x0: TFloat;
i: Integer;
PS: PSingle;
PD: PDouble;
PE: PExtended;
begin
if VType = _Double then
begin
 PD:=PDouble(PV);

 x0:=PD^;

 h:=DiffH;
 xh:=PD^-DiffL*h*0.5;
 Yh:=0;

 for i:=0 to  DiffL do
 begin
  PD^:=xh;
  Yh:=Yh+D2[i]*CalcFunc(Func);
  xh:=xh+h;
 end;

 PD^:=x0;
end
else
if VType = _Single then
begin
 PS:=PSingle(PV);
 x0:=PS^;
 h:=DiffH;
 xh:=PS^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PS^:=xh;
  Yh:=Yh+D2[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PS^:=x0;
end
else
if VType = _Extended then
begin
 PE:=PExtended(PV);
 x0:=PE^;
 h:=DiffH;
 xh:=PE^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PE^:=xh;
  Yh:=Yh+D2[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PE^:=x0;
end;



Derivative2:=Yh/sqr(h);
end;





function Derivative3(Func,PV: TAddress; VType: Integer): TFloat;
var
h,dy5,H1,xh,Yh,x0: TFloat;
i: Integer;
PS: PSingle;
PD: PDouble;
PE: PExtended;
begin

if VType = _Double then
begin
 PD:=PDouble(PV);

 x0:=PD^;

 h:=DiffH;
 xh:=PD^-DiffL*h*0.5;
 Yh:=0;

 for i:=0 to  DiffL do
 begin
  PD^:=xh;
  Yh:=Yh+D3[i]*CalcFunc(Func);
  xh:=xh+h;
 end;

 PD^:=x0;
end
else
if VType = _Single then
begin
 PS:=PSingle(PV);
 x0:=PS^;
 h:=DiffH;
 xh:=PS^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PS^:=xh;
  Yh:=Yh+D3[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PS^:=x0;
end
else
if VType = _Extended then
begin
 PE:=PExtended(PV);
 x0:=PE^;
 h:=DiffH;
 xh:=PE^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PE^:=xh;
  Yh:=Yh+D3[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PE^:=x0;
end;



Derivative3:=Yh/(h*sqr(h));
end;





function Derivative4(Func,PV: TAddress; VType: Integer): TFloat;
var
h,dy5,H1,xh,Yh,x0: TFloat;
i: Integer;
PS: PSingle;
PD: PDouble;
PE: PExtended;
begin

if VType = _Double then
begin
 PD:=PDouble(PV);

 x0:=PD^;

 h:=DiffH;
 xh:=PD^-DiffL*h*0.5;
 Yh:=0;

 for i:=0 to  DiffL do
 begin
  PD^:=xh;
  Yh:=Yh+D4[i]*CalcFunc(Func);
  xh:=xh+h;
 end;

 PD^:=x0;
end
else
if VType = _Single then
begin
 PS:=PSingle(PV);
 x0:=PS^;
 h:=DiffH;
 xh:=PS^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PS^:=xh;
  Yh:=Yh+D4[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PS^:=x0;
end
else
if VType = _Extended then
begin
 PE:=PExtended(PV);
 x0:=PE^;
 h:=DiffH;
 xh:=PE^-DiffL*h*0.5;
 Yh:=0;
 for i:=0 to  DiffL do
 begin
  PE^:=xh;
  Yh:=Yh+D4[i]*CalcFunc(Func);
  xh:=xh+h;
 end;
 PE^:=x0;
end;



Derivative4:=Yh/(sqr(sqr(h)));
end;




function DerivativeN(Func,PV: TAddress; VType: Integer; N: Integer): TFloat;
var
x0,h: TFloat;
PS: PSingle;
PD: PDouble;
PE: PExtended;
begin
h:=DiffH;
//DiffH:=0.1;
if VType = _Double then
begin
 PD:=PDouble(PV);
 x0:=PD^;
 DerivativeN:=Diff_N(Func,PV,VType,N);
 PD^:=x0;
end
else
if VType = _Single then
begin
 PS:=PSingle(PV);
 x0:=PS^;
 DerivativeN:=Diff_N(Func,PV,VType,N);
 PS^:=x0;
end
else
if VType = _Extended then
begin
 PE:=PExtended(PV);
 x0:=PE^;
 DerivativeN:=Diff_N(Func,PV,VType,N);
 PE^:=x0;
end;

DiffH:=h;
end;




function Diff_N(Func,PV: TAddress; VType: Integer; N: Integer): TFloat;
var
x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,
y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,
h,dy5,x,xm: TFloat;
PS: PSingle;
PD: PDouble;
PE: PExtended;
begin
if N = 1 then Diff_N:=Derivative1(Func,PV,VType)
else
if N = 2 then Diff_N:=Derivative2(Func,PV,VType)
else
if N = 3 then Diff_N:=Derivative3(Func,PV,VType)
{else
if N = 4 then Diff_N:=Derivative4(Func,PV,VType)}
else
begin
 if VType = _Double then
 begin
  PD:=PDouble(PV);
  xm:=PD^;

  x:=PD^;
  //h:=0.1;
  h:=DiffH;
  x0:=x-5*h; x1:=x0+h; x2:=x1+h;  x3:=x2+h; x4:=x3+h; x5:=x4+h; x6:=x5+h;
  x7:=x6+h; x8:=x7+h; x9:=x8+h; x10:=x9+h;

   PD^:=x0;
  y0:=Diff_N(Func,PV,VType,N-1);
   PD^:=x1;
  y1:=Diff_N(Func,PV,VType,N-1);
   PD^:=x2;
  y2:=Diff_N(Func,PV,VType,N-1);
   PD^:=x3;
  y3:=Diff_N(Func,PV,VType,N-1);
   PD^:=x4;
  y4:=Diff_N(Func,PV,VType,N-1);
   PD^:=x5;
  y5:=Diff_N(Func,PV,VType,N-1);
   PD^:=x6;
  y6:=Diff_N(Func,PV,VType,N-1);
   PD^:=x7;
  y7:=Diff_N(Func,PV,VType,N-1);
   PD^:=x8;
  y8:=Diff_N(Func,PV,VType,N-1);
   PD^:=x9;
  y9:=Diff_N(Func,PV,VType,N-1);
   PD^:=x10;
  y10:=Diff_N(Func,PV,VType,N-1);

  dy5:=1/(4536*h)*(-3.6*y0+45*y1-270*y2+1080*y3-3780*y4+3780*y6-1080*y7+270*y8-45*y9+3.6*y10);

  Diff_N:=dy5;

  PD^:=xm;
 end
 else
 if VType = _Single then
 begin
  PS:=PSingle(PV);

  xm:=PS^;
  x:=PS^;
  //h:=0.1;
  h:=DiffH;
  x0:=x-5*h; x1:=x0+h; x2:=x1+h;  x3:=x2+h; x4:=x3+h; x5:=x4+h; x6:=x5+h;
  x7:=x6+h; x8:=x7+h; x9:=x8+h; x10:=x9+h;

   PS^:=x0;
  y0:=Diff_N(Func,PV,VType,N-1);
   PS^:=x1;
  y1:=Diff_N(Func,PV,VType,N-1);
   PS^:=x2;
  y2:=Diff_N(Func,PV,VType,N-1);
   PS^:=x3;
  y3:=Diff_N(Func,PV,VType,N-1);
   PS^:=x4;
  y4:=Diff_N(Func,PV,VType,N-1);
   PS^:=x5;
  y5:=Diff_N(Func,PV,VType,N-1);
   PS^:=x6;
  y6:=Diff_N(Func,PV,VType,N-1);
   PS^:=x7;
  y7:=Diff_N(Func,PV,VType,N-1);
   PS^:=x8;
  y8:=Diff_N(Func,PV,VType,N-1);
   PS^:=x9;
  y9:=Diff_N(Func,PV,VType,N-1);
   PS^:=x10;
  y10:=Diff_N(Func,PV,VType,N-1);

  dy5:=1/(4536*h)*(-3.6*y0+45*y1-270*y2+1080*y3-3780*y4+3780*y6-1080*y7+270*y8-45*y9+3.6*y10);

  Diff_N:=dy5;

  PS^:=xm;
 end
 else
 if VType = _Extended then
 begin
  PE:=PExtended(PV);

  x:=PE^;
  xm:=PE^;
  //h:=0.1;
  h:=DiffH;
  x0:=x-5*h; x1:=x0+h; x2:=x1+h;  x3:=x2+h; x4:=x3+h; x5:=x4+h; x6:=x5+h;
  x7:=x6+h; x8:=x7+h; x9:=x8+h; x10:=x9+h;

   PE^:=x0;
  y0:=Diff_N(Func,PV,VType,N-1);
   PE^:=x1;
  y1:=Diff_N(Func,PV,VType,N-1);
   PE^:=x2;
  y2:=Diff_N(Func,PV,VType,N-1);
   PE^:=x3;
  y3:=Diff_N(Func,PV,VType,N-1);
   PE^:=x4;
  y4:=Diff_N(Func,PV,VType,N-1);
   PE^:=x5;
  y5:=Diff_N(Func,PV,VType,N-1);
   PE^:=x6;
  y6:=Diff_N(Func,PV,VType,N-1);
   PE^:=x7;
  y7:=Diff_N(Func,PV,VType,N-1);
   PE^:=x8;
  y8:=Diff_N(Func,PV,VType,N-1);
   PE^:=x9;
  y9:=Diff_N(Func,PV,VType,N-1);
   PE^:=x10;
  y10:=Diff_N(Func,PV,VType,N-1);

  dy5:=1/(4536*h)*(-3.6*y0+45*y1-270*y2+1080*y3-3780*y4+3780*y6-1080*y7+270*y8-45*y9+3.6*y10);

  Diff_N:=dy5;

  PE^:=xm;
 end;

end;


end;





function A1_N: extended;
var
i1: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL do
F:=F+DA[i1];

A1_N:=F;
end;




function A2_N: extended;
var
i1,i2: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-1 do
for i2:=i1+1 to DiffL do
F:=F+DA[i1]*DA[i2];

A2_N:=F;
end;





function A3_N: extended;
var
i1,i2,i3: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-2 do
for i2:=i1+1 to DiffL-1 do
for i3:=i2+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3];

A3_N:=F;
end;



function A4_N: extended;
var
i1,i2,i3,i4: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-3 do
for i2:=i1+1 to DiffL-2 do
for i3:=i2+1 to DiffL-1 do
for i4:=i3+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4];

A4_N:=F;
end;



function A5_N: extended;
var
i1,i2,i3,i4,i5: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-4 do
for i2:=i1+1 to DiffL-3 do
for i3:=i2+1 to DiffL-2 do
for i4:=i3+1 to DiffL-1 do
for i5:=i4+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5];

A5_N:=F;
end;




function A6_N: extended;
var
i1,i2,i3,i4,i5,i6: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-5 do
for i2:=i1+1 to DiffL-4 do
for i3:=i2+1 to DiffL-3 do
for i4:=i3+1 to DiffL-2 do
for i5:=i4+1 to DiffL-1 do
for i6:=i5+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6];

A6_N:=F;
end;





function A7_N: extended;
var
i1,i2,i3,i4,i5,i6,i7: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-6 do
for i2:=i1+1 to DiffL-5 do
for i3:=i2+1 to DiffL-4 do
for i4:=i3+1 to DiffL-3 do
for i5:=i4+1 to DiffL-2 do
for i6:=i5+1 to DiffL-1 do
for i7:=i6+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7];

A7_N:=F;
end;





function A8_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-7 do
for i2:=i1+1 to DiffL-6 do
for i3:=i2+1 to DiffL-5 do
for i4:=i3+1 to DiffL-4 do
for i5:=i4+1 to DiffL-3 do
for i6:=i5+1 to DiffL-2 do
for i7:=i6+1 to DiffL-1 do
for i8:=i7+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8];

A8_N:=F;
end;





function A9_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-8 do
for i2:=i1+1 to DiffL-7 do
for i3:=i2+1 to DiffL-6 do
for i4:=i3+1 to DiffL-5 do
for i5:=i4+1 to DiffL-4 do
for i6:=i5+1 to DiffL-3 do
for i7:=i6+1 to DiffL-2 do
for i8:=i7+1 to DiffL-1 do
for i9:=i8+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9];

A9_N:=F;
end;



function A10_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-9 do
for i2:=i1+1 to DiffL-8 do
for i3:=i2+1 to DiffL-7 do
for i4:=i3+1 to DiffL-6 do
for i5:=i4+1 to DiffL-5 do
for i6:=i5+1 to DiffL-4 do
for i7:=i6+1 to DiffL-3 do
for i8:=i7+1 to DiffL-2 do
for i9:=i8+1 to DiffL-1 do
for i10:=i9+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10];

A10_N:=F;
end;




function A11_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-10 do
for i2:=i1+1 to DiffL-9 do
for i3:=i2+1 to DiffL-8 do
for i4:=i3+1 to DiffL-7 do
for i5:=i4+1 to DiffL-6 do
for i6:=i5+1 to DiffL-5 do
for i7:=i6+1 to DiffL-4 do
for i8:=i7+1 to DiffL-3 do
for i9:=i8+1 to DiffL-2 do
for i10:=i9+1 to DiffL-1 do
for i11:=i10+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11];

A11_N:=F;
end;





function A12_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-11 do
for i2:=i1+1 to DiffL-10 do
for i3:=i2+1 to DiffL-9 do
for i4:=i3+1 to DiffL-8 do
for i5:=i4+1 to DiffL-7 do
for i6:=i5+1 to DiffL-6 do
for i7:=i6+1 to DiffL-5 do
for i8:=i7+1 to DiffL-4 do
for i9:=i8+1 to DiffL-3 do
for i10:=i9+1 to DiffL-2 do
for i11:=i10+1 to DiffL-1 do
for i12:=i11+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12];

A12_N:=F;
end;




function A13_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-12 do
for i2:=i1+1 to DiffL-11 do
for i3:=i2+1 to DiffL-10 do
for i4:=i3+1 to DiffL-9 do
for i5:=i4+1 to DiffL-8 do
for i6:=i5+1 to DiffL-7 do
for i7:=i6+1 to DiffL-6 do
for i8:=i7+1 to DiffL-5 do
for i9:=i8+1 to DiffL-4 do
for i10:=i9+1 to DiffL-3 do
for i11:=i10+1 to DiffL-2 do
for i12:=i11+1 to DiffL-1 do
for i13:=i12+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13];

A13_N:=F;
end;




function A14_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-13 do
for i2:=i1+1 to DiffL-12 do
for i3:=i2+1 to DiffL-11 do
for i4:=i3+1 to DiffL-10 do
for i5:=i4+1 to DiffL-9 do
for i6:=i5+1 to DiffL-8 do
for i7:=i6+1 to DiffL-7 do
for i8:=i7+1 to DiffL-6 do
for i9:=i8+1 to DiffL-5 do
for i10:=i9+1 to DiffL-4 do
for i11:=i10+1 to DiffL-3 do
for i12:=i11+1 to DiffL-2 do
for i13:=i12+1 to DiffL-1 do
for i14:=i13+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13]*DA[i14];

A14_N:=F;
end;





function A15_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-14 do
for i2:=i1+1 to DiffL-13 do
for i3:=i2+1 to DiffL-12 do
for i4:=i3+1 to DiffL-11 do
for i5:=i4+1 to DiffL-10 do
for i6:=i5+1 to DiffL-9 do
for i7:=i6+1 to DiffL-8 do
for i8:=i7+1 to DiffL-7 do
for i9:=i8+1 to DiffL-6 do
for i10:=i9+1 to DiffL-5 do
for i11:=i10+1 to DiffL-4 do
for i12:=i11+1 to DiffL-3 do
for i13:=i12+1 to DiffL-2 do
for i14:=i13+1 to DiffL-1 do
for i15:=i14+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13]*DA[i14]
*DA[i15];

A15_N:=F;
end;





function A16_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-15 do
for i2:=i1+1 to DiffL-14 do
for i3:=i2+1 to DiffL-13 do
for i4:=i3+1 to DiffL-12 do
for i5:=i4+1 to DiffL-11 do
for i6:=i5+1 to DiffL-10 do
for i7:=i6+1 to DiffL-9 do
for i8:=i7+1 to DiffL-8 do
for i9:=i8+1 to DiffL-7 do
for i10:=i9+1 to DiffL-6 do
for i11:=i10+1 to DiffL-5 do
for i12:=i11+1 to DiffL-4 do
for i13:=i12+1 to DiffL-3 do
for i14:=i13+1 to DiffL-2 do
for i15:=i14+1 to DiffL-1 do
for i16:=i15+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13]*DA[i14]
*DA[i15]*DA[i16];

A16_N:=F;
end;





function A17_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-16 do
for i2:=i1+1 to DiffL-15 do
for i3:=i2+1 to DiffL-14 do
for i4:=i3+1 to DiffL-13 do
for i5:=i4+1 to DiffL-12 do
for i6:=i5+1 to DiffL-11 do
for i7:=i6+1 to DiffL-10 do
for i8:=i7+1 to DiffL-9 do
for i9:=i8+1 to DiffL-8 do
for i10:=i9+1 to DiffL-7 do
for i11:=i10+1 to DiffL-6 do
for i12:=i11+1 to DiffL-5 do
for i13:=i12+1 to DiffL-4 do
for i14:=i13+1 to DiffL-3 do
for i15:=i14+1 to DiffL-2 do
for i16:=i15+1 to DiffL-1 do
for i17:=i16+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13]*DA[i14]
*DA[i15]*DA[i16]*DA[i17];

A17_N:=F;
end;




function A18_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL-17 do
for i2:=i1+1 to DiffL-16 do
for i3:=i2+1 to DiffL-15 do
for i4:=i3+1 to DiffL-14 do
for i5:=i4+1 to DiffL-13 do
for i6:=i5+1 to DiffL-12 do
for i7:=i6+1 to DiffL-11 do
for i8:=i7+1 to DiffL-10 do
for i9:=i8+1 to DiffL-9 do
for i10:=i9+1 to DiffL-8 do
for i11:=i10+1 to DiffL-7 do
for i12:=i11+1 to DiffL-6 do
for i13:=i12+1 to DiffL-5 do
for i14:=i13+1 to DiffL-4 do
for i15:=i14+1 to DiffL-3 do
for i16:=i15+1 to DiffL-2 do
for i17:=i16+1 to DiffL-1 do
for i18:=i17+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13]*DA[i14]
*DA[i15]*DA[i16]*DA[i17]*DA[i18];

A18_N:=F;
end;





function A19_N: extended;
label endp;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19: Integer;
F: extended;
begin
F:=0;

for i1:=1 to DiffL-18 do
begin
//if i1 = 3 then goto endp;
for i2:=i1+1 to DiffL-17 do
for i3:=i2+1 to DiffL-16 do
for i4:=i3+1 to DiffL-15 do
for i5:=i4+1 to DiffL-14 do
for i6:=i5+1 to DiffL-13 do
for i7:=i6+1 to DiffL-12 do
for i8:=i7+1 to DiffL-11 do
for i9:=i8+1 to DiffL-10 do
for i10:=i9+1 to DiffL-9 do
for i11:=i10+1 to DiffL-8 do
for i12:=i11+1 to DiffL-7 do
for i13:=i12+1 to DiffL-6 do
for i14:=i13+1 to DiffL-5 do
for i15:=i14+1 to DiffL-4 do
for i16:=i15+1 to DiffL-3 do
for i17:=i16+1 to DiffL-2 do
for i18:=i17+1 to DiffL-1 do
for i19:=i18+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13]*DA[i14]
*DA[i15]*DA[i16]*DA[i17]*DA[i18]*DA[i19];
end;

endp:
A19_N:=F;
end;





function A20_N: extended;
var
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20: Integer;
F: extended;
begin
F:=0;
for i1:=1 to DiffL do
for i2:=i1+1 to DiffL do
for i3:=i2+1 to DiffL do
for i4:=i3+1 to DiffL do
for i5:=i4+1 to DiffL do
for i6:=i5+1 to DiffL do
for i7:=i6+1 to DiffL do
for i8:=i7+1 to DiffL do
for i9:=i8+1 to DiffL do
for i10:=i9+1 to DiffL do
for i11:=i10+1 to DiffL do
for i12:=i11+1 to DiffL do
for i13:=i12+1 to DiffL do
for i14:=i13+1 to DiffL do
for i15:=i14+1 to DiffL do
for i16:=i15+1 to DiffL do
for i17:=i16+1 to DiffL do
for i18:=i17+1 to DiffL do
for i19:=i18+1 to DiffL do
for i20:=i19+1 to DiffL do
F:=F+DA[i1]*DA[i2]*DA[i3]*DA[i4]*DA[i5]*DA[i6]*DA[i7]*DA[i8]*DA[i9]*DA[i10]*DA[i11]*DA[i12]*DA[i13]*DA[i14]
*DA[i15]*DA[i16]*DA[i17]*DA[i18]*DA[i19]*DA[i20];

A20_N:=F;
end;






function Cnk(n,k: Integer): TFloat;
begin
 Cnk:=Factorial(n)/(Factorial(k)*Factorial(n-k));
end;



procedure SetDiffC(k: integer);
var
i,n: Integer;
begin
SetLength(DA,DiffL+1);
SetLength(DD,DiffL+1);
n:=0;
for i:=0 to DiffL do
begin
if i <> k then begin inc(n); DA[n]:=-i; end;
end;



if DiffL >= 1  then DD[1]:=1;
if DiffL >= 2  then DD[2]:=A1_N;
if DiffL >= 3  then DD[3]:=A2_N;
if DiffL >= 4  then DD[4]:=A3_N;
if DiffL >= 5  then DD[5]:=A4_N;
if DiffL >= 6  then DD[6]:=A5_N;
if DiffL >= 7  then DD[7]:=A6_N;
if DiffL >= 8  then DD[8]:=A7_N;
if DiffL >= 9  then DD[9]:=A8_N;
if DiffL >= 10 then DD[10]:=A9_N;
if DiffL >= 11 then DD[11]:=A10_N;
if DiffL >= 12 then DD[12]:=A11_N;
if DiffL >= 13 then DD[13]:=A12_N;
if DiffL >= 14 then DD[14]:=A13_N;
if DiffL >= 15 then DD[15]:=A14_N;
if DiffL >= 16 then DD[16]:=A15_N;
if DiffL >= 17 then DD[17]:=A16_N;
if DiffL >= 18 then DD[18]:=A17_N;
if DiffL >= 19 then DD[19]:=A18_N;
if DiffL >= 20 then DD[20]:=A19_N;
end;




function  Factorial(N: Integer): TFloat;
begin
Factorial:=Fact[N];
end;




function DiffN(N: Integer; X: Double): extended;
var
i: Integer;
F: extended;
DH: TArrayX;
begin
SetLength(DH,DiffL+1);
DH:=Copy(DD,0,DiffL+1);

for i:=1 to DiffL do
begin
if DiffL-N-i+1 < 0
then DH[i]:=0
else
DH[i]:=Factorial(DiffL-i+1)/Factorial(DiffL-N-i+1)*DH[i];
end;

F:=0;

for i:=1 to DiffL do
begin
F:=F+intpower(x,DiffL-i+1-N)*DH[i];
end;

DiffN:=F;
end;



procedure CalcDiffCoeff;
var
i: Integer;
x: TFloat;
C: TFloat;
begin
x:=DiffL/2;

for i:=0 to DiffL do
begin
SetDiffC(i);
C:=Cnk(DiffL,i)/Factorial(DiffL)*IntPower(-1,DiffL+i);
D1[i]:=DiffN(1,x)*C;
D2[i]:=DiffN(2,x)*C;
D3[i]:=DiffN(3,x)*C;
D4[i]:=DiffN(4,x)*C;
D5[i]:=DiffN(5,x)*C;
end;

end;


procedure InitDiff;
begin
SetLength(D1,DiffL+1);
SetLength(D2,DiffL+1);
SetLength(D3,DiffL+1);
SetLength(D4,DiffL+1);
SetLength(D5,DiffL+1);
CalcDiffCoeff;
end;




end.
