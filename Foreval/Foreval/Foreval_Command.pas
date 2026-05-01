unit Foreval_Command;
{******************************************************************************}
{                                                                              }
{                                 ver 9.1.1.395                                }
{----------------------------------------------------------------------------- }
{ Коммандный модуль: содержит  исполняемые функции,                            }
{ Использовать только на процессорах с автосинхронизацией : отсутствует FWAIT. }
{ система комманд: Pentium Pro + SSE2, SSE3(?)                                 }
{ -----------------------------------------------------------------------------}
{ Command module: contains executable functions,                               }
{ Only use processors with AutoSync : missing FWAIT.                           }
{ min proc.: Pentium Pro  + SSE2, SSE3(?)                                      }
{------------------------------------------------------------------------------}
{                  SOREL   (C)CopyRight 2000+. Russia, S.-Petersburg.          }
{******************************************************************************}

{
 !!!
 во многих  встроенных комплексных функциях используется быстрое деление (скорость выше, но меньше точность):  FAST_ZDIV,  FAST_RDIV
 in many built-in complex functions use fast division(higher speed, but less accuracy): FAST_ZDIV,  FAST_RDIV
}


// {$RangeChecks On}
// {$OverFlowChecks On}
 //{$ZEROBASEDSTRINGS Off}

{$R-}
{$Q-}

{$IFDEF FPC}
  {$MODE DELPHI}
  {$ASMMODE INTEL}
{$ENDIF}


interface


uses
  {math,} {Foreval_SpecFunc,}Foreval_Definitions,  Windows, SysUtils;



{spec. func. }
 type  THexExtW = packed array[0..4] of word;
 const NaNXHex     : THexExtW = ($ffff,$ffff,$ffff,$ffff,$7fff); {an extended NaN as hex}
 var   NaN_x       : extended absolute NaNXHex;
 const PosInfXHex  : THexExtW = ($0000,$0000,$0000,$8000,$7fff); {extended +INF   as hex}
 const NegInfXHex  : THexExtW = ($0000,$0000,$0000,$8000,$ffff); {extended -INF   as hex}
 var   PosInf_x    : extended absolute PosInfXHex;  {extended +INF  }
 var   NegInf_x    : extended absolute NegInfXHex;  {extended -INF  }

 var   RetValOnNil : extended;

 const  Max2Power: integer = 16383;  //2^Max2Power
 const  Max2PowerN: integer = -16383;  //2^Max2Power
 const  Power2Overflow: integer =17000; //Any > Max2Power
 const  MaxInt: double= 2147483647;
 const  C1: double = 1;
 const  C05: double = 0.5;
 const  C2: integer = 2;
 const  C3: double = 3;
 const  C025: double = 0.25;
 const  SizeBinomC = 100;

  const f_Jordan = 1;
  const f_Gauss =  2;


const NumberFact = 1754;
const NumberFact2 = 1604;

 {***
type
TFloatType = extended;

type
TIntegType = integer;

type
TAddress = Cardinal;

type
TArrayD = array of Double;
type
TArrayE = array of Extended;
type
TArrayI = array of Integer;
type
TArrayS = array of Single;
type
PArrayD = ^TArrayD;
type
PArrayE = ^TArrayE;
type
PArrayI = ^TArrayI;
type
PArrayS = ^TArrayS;
***}


type
TArrayStr = array of String;

 {***
type
TComplexD =  record
               re: double;
               im: double;
              end;

type
TComplexE = record
            re: extended;
            im: extended;
           end;
type
PComplexE = ^TComplexE;
type
PComplexD = ^TComplexD;

***}


type
  TExtRec  = packed record     {Extended as sign, exponent, significand}
               lm: longint;    {low  32 bit of significand}
               hm: longint;    {high 32 bit of significand}
               xp: word;       {biased exponent and sign  }
             end;


type
TArray2E = array of array of extended;

type TArrayF = array of TFloat;

type
TSplain = record
             A0: TArrayF;
             A1: TArrayF;
             A2: TArrayF;
             A3: TArrayF;
             PS: TArrayF;
             SL: Integer;
             DS: TFloat;
            end;



type
TInteg2 = record
           I1: Integer;
           I2: Integer;
          end;
type
TArrayF_2 = array of TInteg2;



{***
  const _Single = 1;
  const _Double = 2;
  const _Extended = 3;
  const _Integer = 4;
  const _Pointer = 5;
 ***}
 // const _Array = 6;


{***
const NumberFact = 1754;
const NumberFact2 = 1604;
***}

const MV_4  : extended = 0.2974328738393e4932;  {< MaxExtended/4}

//const S_c05: double = 0.5;
//const S_c2: double = 2;
//const S_c025: double = 0.25;
//const S_cs2: double = -2;
//const E_CPId2: extended  = 3.1415926535897932384626433832795/2;
//const E_2PI: extended  = 3.1415926535897932384626433832795*2;
//const c3: double = 3;
//const c6: double = 6;
//const c4: double = 4;
//const c1: double = 1;

const
FCW1: Word = $1f32;
FCW2: Word = $1332;



 {.345}
 {***
const _fast      = 1;
const _standard  = 2;
const _accurate  = 3;
const _extra     = 4;
***}



const
   TC1 = longint($FFFFFFFE);  {4294967294}
   TC2 = longint($FFFFFFF8);  {4294967288}
   TC3 = longint($FFFFFFF0);  {4294967280}
   TC4 = longint($FFFFFF80);  {4294967168}
   ICNT = 10;                  {Init count to reach valid state}


const
  N19937 = 624;
  M19937 = 397;


const
  mag01: array[0..1] of longint = (0, longint($9908b0df));

const
  Upper_Mask = longint($80000000);
  Lower_mask = longint($7fffffff);
  Weyl = $61c88647; {Weyl generator increment}





type
  taus113_ctx = record
               nr         : longint;  {next rand = s1 xor s2 xor s3 xor s4}
               s1,s2,s3,s4: longint;  {state variables }
             end;
type
  mt19937_state = array[0..N19937-1] of longint;

type
  mt19937_ctx   = record
                    mt : mt19937_state; {state vector}
                    mti: integer;       {state index }
                    nr : longint;       {next random }
                  end;
type
  xor4096_ctx   = record
                    x : array[0..127] of longint; {state vector}
                    i : integer;                  {state index }
                    w : longint;                  {Weyl state  }
                    nr: longint;                  {next random }
                  end;
var
  ctxPLE      :  taus113_ctx;
  ctxMT,ctxMTG:  mt19937_ctx;
  ctxXOR      : xor4096_ctx;


    procedure Z_MUL;
    procedure Z_RZDIV_STD;
    procedure Z_DIV_STD;
    procedure Z_DIV_ACC;     {.335}
    procedure Z_RZDIV_ACC;    {.335}
    procedure Z_RZDIV_FAST;
    procedure Z_DIV_FAST;
    procedure Z_RZDIV_EXTRA;     {.345}
    procedure Z_DIV_EXTRA;      {.345}
    procedure Z_SIN;
    procedure Z_COS;
    procedure Z_TAN;
    procedure Z_COSEC;
    procedure Z_SEC;
    procedure FPWR;
    procedure ZPWR;
    procedure Z_ReCxFPWR;
    procedure Z_CxReFPWR;
    procedure Z_CCxRe_FPWR;      {.361}
    procedure Z_CRe_CxFPWR;      {.361}
    procedure Z_CCx_CxFPWR;      {.361}
    procedure R_CR_FPWR;
    procedure R_FACT;
    procedure R_FACT2;
    procedure Z_LN;
    procedure Z_SQRT;
    procedure Z_SQR;
    procedure Z_CxCxLOG;
    procedure R_LogN;
    procedure Z_ReCxLOG;
    procedure Z_CxReLOG;
    procedure R_CR_LOG;
    procedure R_CR2_LOG;
    procedure Z_CZ2_LOG;
    procedure Z_CR_LOG;
    procedure Z_CZ_CxLOG;
    procedure Z_CZ2_CxLOG;
    procedure Z_CRe_CxLOG;
    procedure Z_CRe2_CxLOG;
    procedure Z_COTAN;
    procedure R_ARCSIN;
    procedure R_ARCCOS;
    procedure R_ARCCOTAN;
    procedure R_ARCCOTAN_1DIVARG;
    procedure Z_ARCCOTAN;
    procedure Z_ARCSIN;
    procedure Z_ARCCOS;
    procedure Z_ARCTAN;
    procedure R_SINH;
    procedure R_COSH;
    procedure R_TANH;
    procedure R_COTANH;
    procedure R_ARCSINH;
    procedure R_ARCCOSH;
    procedure R_ARCTANH;
    procedure R_ARCCOTANH;
    procedure R_ARCCOSECH;
    procedure R_ARCSECH;
    procedure R_COSECH;
    procedure R_SECH;
    procedure R_ARCCOSEC;
    procedure R_ARCSEC;
    procedure Z_ARCSEC;
    procedure Z_ARCCOSEC;
    procedure Z_SINH;
    procedure Z_COSH;
    procedure Z_COSECH;
    procedure Z_SECH;
    procedure Z_TANH;
    procedure Z_COTANH;
    procedure Z_ARCSINH;
    procedure Z_ARCCOSH;
    procedure Z_ARCTANH;
    procedure Z_ARCCOTANH;
    procedure Z_ARCCOSECH;
    procedure Z_ARCSECH;
    procedure Z_EXP;

    procedure Z2_EXPZ_EXPNZ;
    procedure Z_Z2P1_DIV_Z2M1;
    procedure Z_Z2M1_DIV_Z2P1;
    procedure Z_EXPZ_Z2M1_DIV_Z2P1_SAVE;
    procedure Z_EXPZ_Z2P1_DIV_Z2M1_SAVE;

    procedure Z_ARCTAN_FROM_ARCCOTAN;
    procedure R_ARCTAN_FROM_ARCCOTAN;



    {
    procedure R_COSH_SINH;
    procedure Z_1DIV_EXPIZ_PLUS_EXPNIZ;
    procedure Z_EXPIZ;
    procedure Z2_EXPIZ_EXPNIZ;
    procedure Z2_TANZ_EXPIZ_M;
    procedure Z2_TANZ_EXPIZ;
    procedure Z2_COTANZ_EXPIZ_M;
    procedure Z_COTAN__OF__EXPIZ;
    procedure Z_TAN__OF__EXPIZ;
    }



    procedure R_EXP;
    procedure Z_CxIROOT;
    procedure R_IROOT;
    procedure R_FROOT;
    procedure R_CR_IROOT;
    procedure Z_CCx_IROOT;
    procedure Z_IPWR3;
    procedure Z_IPWR4;
    procedure Z_IPWRN1;
   { procedure Z_IPWRN2;
    procedure Z_IPWRN3;
    procedure Z_IPWRN4;
    procedure Z_IPWRN5;
    procedure Z_IPWRN6; }
    procedure R_IPWRSGN;
    procedure Z_IPWRSGN; {189}


    procedure Z_UNeg_ReFPWR;     {.361}
    procedure Z_ImUNeg_ReFPWR;    {.361}
    procedure Z_ImU_ReFPWR;        {.361}
    procedure Z_ImUNeg_CxFPWR;     {.361}
    procedure Z_ImU_CxFPWR;        {.361}


    procedure R_LEN;
    procedure R_HIGH;


    procedure RVD_MAX;
    procedure RVE_MAX;
    procedure RVS_MAX;
    procedure RVI_MAX;

    procedure RVD_MIN;
    procedure RVE_MIN;
    procedure RVI_MIN;
    procedure RVS_MIN;

    procedure RVD_SUM;
    procedure RVE_SUM;
    procedure RVS_SUM;
    procedure RVI_SUM;

    procedure RVD_PROD;
    procedure RVE_PROD;
    procedure RVS_PROD;

    procedure RVD_SUMQ;
    procedure RVE_SUMQ;
    procedure RVS_SUMQ;

    procedure RVD_PRODS;
    procedure RVE_PRODS;
    procedure RVS_PRODS;

    procedure RVD_SUMQS;
    procedure RVE_SUMQS;
    procedure RVS_SUMQS;

    procedure RVD_SUMQS_VX_VY;
    procedure RVE_SUMQS_VX_VY;
    procedure RVS_SUMQS_VX_VY;

    procedure RVD_SUMPROD_VX_VY;
    procedure RVE_SUMPROD_VX_VY;
    procedure RVS_SUMPROD_VX_VY;

    procedure RVD_SUMPRODS_VX_VY;
    procedure RVE_SUMPRODS_VX_VY;
    procedure RVS_SUMPRODS_VX_VY;

    procedure RVD_SUMQS2V(VX,VY: TArrayD); stdcall;
    procedure RVE_SUMQS2V(VX,VY: TArrayE); stdcall;
    procedure RVS_SUMQS2V(VX,VY: TArrayS); stdcall;

    procedure RVD_SUMPROD2V(VX,VY: TArrayD); stdcall;
    procedure RVE_SUMPROD2V(VX,VY: TArrayE); stdcall;
    procedure RVS_SUMPROD2V(VX,VY: TArrayS); stdcall;

    procedure RVD_SUMPRODS2V(VX: TArrayD; x: double;   VY: TArrayD; y: double); stdcall;
    procedure RVE_SUMPRODS2V(VX: TArrayE; x: extended; VY: TArrayE; y: extended); stdcall;
    procedure RVS_SUMPRODS2V(VX: TArrayS; x: single;   VY: TArrayS; y: single); stdcall;


    procedure RVD_AVR;
    procedure RVE_AVR;
    procedure RVS_AVR;

    procedure RVD_NORM;
    procedure RVE_NORM;
    procedure RVS_NORM;

    procedure RVD_DEV;
    procedure RVE_DEV;
    procedure RVS_DEV;

    procedure RVD_DEVS;
    procedure RVE_DEVS;
    procedure RVS_DEVS;


    procedure RV_SUMPS;
    procedure RV_SUMP;



    //procedure RV_POLY;


    procedure RVE_POLY;           {.393}
    procedure RVD_POLY;           {.393}
    procedure RVS_POLY;           {.393}
    procedure RVI_POLY;           {.393}

    procedure CxV_POLY;
    procedure RV_POLYDIFF1;
    procedure RV_POLYDIFF2;
    procedure RV_POLYDIFF3;
    procedure CxV_POLYDIFF1;
    procedure CxV_POLYDIFF2;
    procedure CxV_POLYDIFF3;

    function  PolyDiffVN(pv: Pointer; x: Extended;  p: integer; tv: Integer): extended;  stdcall;
    procedure PolyDiffVNcx(pv: Pointer; z: TComplexE;  p: integer; tv: Integer);  stdcall;

    function RV_GCD(pv: Pointer; tv: Integer): extended; stdcall;
    function RV_LCM(pv: Pointer; tv: Integer): extended; stdcall;


    procedure R_SGN;
    procedure Z_SGN; {.335}
    procedure R_F2PWR;
    procedure R_FPWR2I;
    procedure R_MAX(adr,len: Cardinal);  stdcall;
    procedure R_MIN(adr,len: Cardinal);  stdcall;
    procedure R_AVR(adr,len: Cardinal);  stdcall;
    procedure R_SUM(adr,len: Cardinal);  stdcall;
    procedure R_SUMQ(adr,len: Cardinal);  stdcall;
    procedure R_NORM(adr,len: Cardinal);  stdcall;
    procedure R_PROD(adr,len: Cardinal);  stdcall;
    procedure R_DEV(adr,len: Cardinal); stdcall;
    procedure R_DEVS(adr,len: Cardinal); stdcall;
    procedure R_GCD(adr,len: Cardinal); stdcall;
    procedure R_LCM(adr,len: Cardinal); stdcall;
    procedure RI_VEC;
    procedure RD_VEC;
    procedure RE_VEC;
    procedure RI_VECS;
    procedure RD_VECS;
    procedure RE_VECS;
    procedure R_IPWR;
    procedure Z_IPWR; {v177}
    procedure Z_ImU_IPWR;
    procedure Z_CxIROOT3;
    procedure Z_CxIROOT3Int;
    procedure Z_CCx_IROOT3Int;
    procedure R_Decart;


    procedure _MAX2;
    procedure _MIN2;



    procedure SetLengthArray(AdrV: Pointer; TypeV: Cardinal; Len: Cardinal);  stdcall;

    procedure SetLengthArrayE(AdrV: Pointer; Len: Cardinal);  stdcall;
    procedure SetLengthArrayD(AdrV: Pointer; Len: Cardinal);  stdcall;
    procedure SetLengthArrayI(AdrV: Pointer; Len: Cardinal);  stdcall;
    procedure SetLengthArrayS(AdrV: Pointer; Len: Cardinal);  stdcall;

    {procedure SetLengthCopyArrayDbl; assembler;
    procedure SetLengthCopyArrayExt; assembler;
    procedure SetLengthCopyArraySng; assembler;
    procedure SetLengthCopyArrayInt; assembler;}
    procedure SetLengthCopyArrayAny; assembler;

    procedure _CopyMemDbl(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
    procedure _CopyMemExt(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
    procedure _CopyMemSng(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
    procedure _CopyMemInt(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;

    procedure _CopyArrayDbl(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
    procedure _CopyArrayExt(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
    procedure _CopyArrayInt(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
    procedure _CopyArraySng(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
    //procedure _CopyArrayAny(DstAddr: Pointer; SrcAddr: Pointer; VType: Integer);   stdcall;

    procedure _CopyArrayIntToExt; assembler;
    procedure _CopyArrayIntToDbl; assembler;
    procedure _CopyArraySngToExt; assembler;
    procedure _CopyArraySngToDbl; assembler;
    procedure _CopyArrayDblToExt; assembler;








    //procedure _MaskFPUException;  assembler;
    //procedure _IsFPUException; assembler;

    procedure _MaskFPUExceptionA;  assembler;
    procedure _IsFPUExceptionA; assembler;
    procedure _ResetMaskFPUExceptionA;  assembler;
    procedure _ReadExceptionFPU; assembler;
    procedure _InitFPU; assembler;
    procedure  CallSafe(Addr: Pointer; var Error: integer);      stdcall;
    function   CallRSafe(Addr: Pointer; var Error: integer): extended;      stdcall;
    procedure  CallCxSafe(Addr: Pointer; var Error: integer);      stdcall;

    procedure  CallMaskFPU(Addr: Pointer; var Error: integer);   stdcall;
    function   CallRMaskFPU(Addr: Pointer; var Error: integer): extended;   stdcall;
    procedure  CallCxMaskFPU(Addr: Pointer; var Error: integer);   stdcall;

    procedure _IsNan; assembler;
    //function _IsNanR(AValue: Extended): Extended; stdcall;
    //function _IsNanCx(AValue: TComplexE): Extended; stdcall;

    function  R_PDouble(Addr: Pointer):  Extended;      stdcall;
    procedure RW_PDouble(Addr: Pointer; Val: double);      stdcall;
    function  R_PExtended(Addr: Pointer): Extended;      stdcall;
    procedure RW_PExtended(Addr: Pointer; Val: extended);      stdcall;
    procedure R_PInteger(Addr: Pointer);      stdcall;
    procedure RW_PInteger(Addr: Pointer; Val: integer);      stdcall;
    function  R_PSingle(Addr: Pointer): Extended;      stdcall;
    procedure RW_PSingle(Addr: Pointer; Val: single);      stdcall;
    procedure I_PPointer(Addr: Pointer);   stdcall;
    function  R_PArrayExtended(AdrV: Pointer; indx: Cardinal):Extended;  stdcall;
    function  R_PArrayDouble(AdrV: Pointer; indx: Cardinal):Extended;  stdcall;
    procedure R_PArrayInteger(AdrV: Pointer; indx: Cardinal);  stdcall;
    procedure ToPointer(val: Integer);   stdcall;
    procedure ToInteger(val: Integer);   stdcall;
    procedure  R_PByte;    assembler; //cdecl;      {.379}
    procedure  W_PByte;    assembler; //cdecl;      {.379}
    procedure  R_PWord;    assembler; //cdecl;      {.379}
    procedure  W_PWord;    assembler; //cdecl;      {.379}
    procedure  LGC_OR;     assembler; //cdecl;      {.379}
    procedure  LGC_AND;    assembler; //cdecl;      {.379}
    procedure  LGC_XOR;    assembler; //cdecl;      {.379}
    procedure  LGC_NOT;    assembler; //cdecl;      {.379}
    procedure  LGC_NOR;    assembler; //cdecl;      {.379}
    procedure  LGC_NAND;   assembler; //cdecl;      {.379}
    procedure  LGC_XNOR;   assembler; //cdecl;      {.379}

   // procedure _SafeCall(Adr: Cardinal); {.219}


{
                 Random numbers generator  algorithm( taus113 (Pierre L'Ecuyer),mt19937 (Mersenne Twister), xor4096) ,
                (C) Copyright   Wolfgang Ehrhardt   http://wolfgang-ehrhardt.de/
                https://github.com/chadilukito/www.wolfgang-ehrhardt.de
                https://github.com/maelh/www.wolfgang-ehrhardt.de-1/tree/master/
                https://github.com/moe123/www.wolfgang-ehrhardt.de
}

procedure mt19937_init(var ctxMT: mt19937_ctx; seed: longint);
procedure mt19937_next(var ctx: mt19937_ctx);
function mt19937_double(var ctxMT: mt19937_ctx): double;
function mt19937_double53(var ctxMT: mt19937_ctx): double;
procedure taus113_next(var ctx: taus113_ctx);
procedure taus113_init4(var ctx: taus113_ctx; seed1,seed2,seed3,seed4: longint);
function  taus113_double(var ctx: taus113_ctx): double;
function taus113_double53(var ctx: taus113_ctx): double;
procedure taus113_init(var ctx: taus113_ctx; seed: longint);
procedure xor4096_init(var ctx: xor4096_ctx; seed: longint);
procedure xor4096_next(var ctx: xor4096_ctx);
function xor4096_double53(var ctx: xor4096_ctx): double;
procedure MT_intrand(Num: Cardinal);  stdcall;
procedure MT_intrand_Int;
procedure MT_intrand2(Num1,Num2: Cardinal);  stdcall;
procedure MT_intrand2_Int;
procedure MT_rand01;  stdcall;
function MT_rand2(x1,x2:PDouble): double;  stdcall;
procedure PLE_intrand(Num: Cardinal);  stdcall;
procedure PLE_intrand_Int;
procedure PLE_intrand2(Num1,Num2: Cardinal);  stdcall;
procedure PLE_intrand2_Int;
procedure PLE_rand01;  stdcall;
function PLE_rand2(x1,x2:PDouble): double;  stdcall;
procedure XOR_intrand(Num: Cardinal);  stdcall;
procedure XOR_intrand2(Num1,Num2: Cardinal);  stdcall;
procedure XOR_rand01;  stdcall;
function XOR_rand2(x1,x2:PDouble): double;  stdcall;
function _RandG(Mean, StdDev: PExtended): Extended;  stdcall;


procedure _LSE(A: TArray2E;  B: TArrayE; var B1: TArrayE; var D: TFloat);
procedure _Gausse(A: TArray2E; B: TArrayE; var B1: TArrayE; var D: TFloat);
procedure _Jordan(A: TArray2E; B: TArrayE; var B1: TArrayE; var D: TFloat);
procedure _CreateSplain3(MX: TArrayE; MF: TArrayE; var idf: cardinal; var  E: integer);
procedure _XCHSC(i,j: Integer; M: TArray2E; B: TArrayE; var E: Integer);

function _FSPL3(x: PExtended; id: integer): TFloat;   stdcall;
function _FSPL3D1(x: PExtended; id: integer): TFloat; stdcall;
function _FSPL3D2(x: PExtended; id: integer): TFloat; stdcall;
function _FSPL3D3(x: PExtended; id: integer): TFloat; stdcall;
function _FSPL3D4(x: PExtended; id: integer): TFloat; stdcall;







    procedure CreateFactMass;
    procedure CreateBinomCoeff;
    procedure InitMEM(Addr: Cardinal);
    procedure SetDivCommand(CommandType: Integer);    {.345}
    function _FACT1(n: integer): extended;//N -> EAX
    function std_rand2(x1,x2:PExtended): extended;  stdcall;
    procedure _Randomize;  stdcall;
    procedure InitRandomGenerator;
    procedure SetDynArrayLenCorrect(C: Integer);
    //procedure SetAddrSpecFPUExceptionProc(EnableProc,DisableProc: Pointer);
    procedure  SetAddrSwitchSpecFPUException(AddrSwitch: Pointer);
    procedure  SetRetValOnNilInNAN(BVal: Boolean);

    {.357} //Для исключения Math и унифицирования всех вычислительных процедур, независимо от Delphi vs FPC
    function fc_IntPower(x: Extended; P: Integer): Extended; assembler;
    function fc_Power(x: Extended; P: Extended): Extended; assembler;
    function fc_Ln( X: Extended): Extended;   assembler;
    function fc_Tan( X: Extended): Extended;   assembler;
    function fc_Log2( X: Extended): Extended;   assembler;
    function fc_Log10( X: Extended): Extended;   assembler;
    function fc_LogN(Base, X: Extended):Extended;   assembler;


var
Factorial,Factorial1,Factorial2,Factorial2F: array of extended;
{F_FastSpec,}F_FastStdFuncReal,F_FastStdFuncComplex: Boolean;
F_FastDiv: Integer;
BinomC: TArray2E;




implementation
var
MEM: Cardinal;
CWMEM: Cardinal;
_LSEType: Integer;
S_Error: integer;
F_Clm,F_Str: Integer; //соответствующие флаги
G_TS,G_TC: TArrayF_2; //массивы номеров переставлений строк/столбцов (исп-ся в Matrix преобразованиях)
GSPL3: array of TSplain;
RZDIV_ACC_ADDR, ZDIV_ACC_ADDR: Pointer;
c_DinArrayLenCorrect: Integer; {.357}
CW_Addr: Cardinal;
//EnableFPUExceptAddr,DisableFPUExceptAddr: Pointer;
AddrSwitchFPUExceptSpecFunc: Pointer;


procedure SetDynArrayLenCorrect(C: Integer);
begin
 c_DinArrayLenCorrect:=C;
end;

procedure InitMEM(Addr: Cardinal);
begin
  MEM:=Addr;
end;

 {
procedure  SetAddrSpecFPUExceptionProc(EnableProc,DisableProc: Pointer);
begin
  EnableFPUExceptAddr:=EnableProc;
  DisableFPUExceptAddr:=DisableProc;
end;
 }

procedure  SetAddrSwitchSpecFPUException(AddrSwitch: Pointer);
begin
 AddrSwitchFPUExceptSpecFunc:=AddrSwitch;
end;


procedure  SetRetValOnNilInNAN(BVal: Boolean);
begin
  if BVal = True  then RetValOnNil:=Nan_x else RetValOnNil:=0.0;
end;


procedure SetDivCommand(CommandType: Integer);
var
 RZDivAddr, ZDivAddr: Pointer;
Mode: Integer;
begin
  case CommandType of
        _fast: begin Mode:=1; RZDivAddr:=@Z_RZDIV_FAST; {unused} ZDivAddr:=@Z_DIV_FAST; {unused} end;
    _standard: begin Mode:=0; RZDivAddr:=@Z_RZDIV_STD;   ZDivAddr:=@Z_DIV_STD; {unused}  end;
    _accurate: begin Mode:=0; RZDivAddr:=@Z_RZDIV_ACC;   ZDivAddr:=@Z_DIV_ACC; {unused}  end;
       _extra: begin Mode:=0; RZDivAddr:=@Z_RZDIV_EXTRA; ZDivAddr:=@Z_DIV_EXTRA; {unused} end;
  end;

  Foreval_Command.F_FastDiv:=Mode;
  RZDIV_ACC_ADDR:=RZDivAddr;
  ZDIV_ACC_ADDR:=ZDivAddr;
end;



procedure CreateFactMass;
var
i,j,k1,k2: Integer;
S: extended;
begin                   //создание массива факториалов

SetLength(Factorial,NumberFact+1);

S:=1;
for j:=1 to NumberFact do
begin
 S:=S*j;
 Factorial[j]:=S;
end;
 Factorial[0]:=1;


k1:=1; k2:=1;
SetLength(Factorial1,NumberFact2+1);  SetLength(Factorial2,NumberFact2+1);
Factorial1[0]:=1; Factorial2[0]:=1;
 for i := 1 to NumberFact2*2 do
 begin
  if i mod 2 = 0 then  begin Factorial2[k2]:=Factorial2[k2-1]*i; inc(k2);  end
  else
    begin Factorial1[k1]:=Factorial1[k1-1]*i;  inc(k1); end;
 end;

 k1:=1; k2:=1;
 SetLength(Factorial2F,NumberFact2*2+1);   Factorial2F[0]:=1;
 for i := 1 to NumberFact2*2 do
 begin
  if i mod 2 = 0 then  begin Factorial2F[i]:=Factorial2[k2-1]*i; inc(k2);  end
  else
    begin Factorial2F[i]:=Factorial1[k1-1]*i;  inc(k1); end;
 end;

end;


procedure CreateBinomCoeff;
var
 k,n: integer;
begin
SetLength(BinomC,SizeBinomC+1,SizeBinomC+1);

  for n := 0 to SizeBinomC do
  begin
     for k := 0 to SizeBinomC do
     begin
      if n >= k  then BinomC[n,k]:=Factorial[n]/(Factorial[k]*Factorial[n-k])
      else BinomC[n,k]:=0;
     end;
  end;


end;


function _Length(VecAddr: Pointer): integer;
begin
asm
       push ecx
       //push eax

       mov  ecx, VecAddr
       test ecx,ecx
       jz @@nil
       mov  ecx,[ecx-4]
       {.357}
       add ecx,c_DinArrayLenCorrect
       (*
       {$IFDEF FPC}
        add ecx,1
       {$ENDIF}
       *)
       @@nil:

       mov @Result,ecx
       //pop  eax
       pop  ecx

end;
end;



procedure Z_MUL; assembler;
//z1*z2; z1.RE-ST,z1.IM-ST(1),z2.RE-ST(2),z2.IM-ST(3);
asm
 fld  st(0)
 fmul st(0),st(3)
 fxch st(1)
 fmul st(0),st(4)
 fxch st(4)
 fmul st(0),st(2)
 fsubp
 fxch st(2)
 fmulp
 faddp st(2),st(0)
end;


procedure Z_RZDIV_FAST; assembler;
// r/z1; r-ST,z1.RE-ST(1),z1.IM-ST(2);
// FAST_RDIV!!!
asm
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp

  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
end;



procedure Z_RZDIV_STD; assembler;
// r/z1; r-ST,z1.RE-ST(1),z1.IM-ST(2);
asm
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp

  fdiv  st(1),st
  fdivp st(2),st
end;



procedure Z_DIV_FAST; assembler;
// z1/z2; z1.RE-ST,z1.IM-ST(1),z2.RE-ST(2),z2.IM-ST(3);
// FAST_ZDIV!!!
asm
 fxch  st(2)
 fld   st
 fmul  st,st
 fxch  st(4)
 fld   st
 fmul  st,st
 faddp st(5),st
 fxch  st(4)
 fld1
 fdivr

 fxch  st(4)
 fld   st
 fmul  st,st(3)
 fxch
 fmul  st,st(4)
 fxch  st(3)
 fmul  st,st(2)
 fxch  st(4)
 fmulp st(2),st
 faddp
 fmul  st,st(3)
 fxch  st(2)
 fsubrp
 fmulp st(2),st
end;




procedure Z_DIV_STD; assembler;
// z1/z2; z1.RE-ST,z1.IM-ST(1),z2.RE-ST(2),z2.IM-ST(3);
asm
 fxch  st(2)
 fld   st
 fmul  st,st
 fxch  st(4)
 fld   st
 fmul  st,st
 faddp st(5),st
 fxch  st(4)

 fxch  st(4)
 fld   st
 fmul  st,st(3)
 fxch
 fmul  st,st(4)
 fxch  st(3)
 fmul  st,st(2)
 fxch  st(4)
 fmulp st(2),st
 faddp
 fdiv  st,st(3)
 fxch  st(2)
 fsubrp
 fdivrp st(2),st
end;





{.335}


 (*
procedure cdiv(const x,y: complex; var z: complex);
  {-Return the quotient z = x/y}
var
  d,q,t: extended;
begin
  {Smith's method: see Knuth[32], Exercise 4.2.1.16 and NR[13], (5.4.5)}
  if abs(y.re) >= abs(y.im) then begin
    q := y.im/y.re;
    d := y.re + q*y.im;
    t := (x.re + q*x.im)/d;
    z.im := (x.im - q*x.re)/d;
    z.re := t;
  end
  else begin
    q := y.re/y.im;
    d := y.im + q*y.re;
    t := (q*x.re + x.im)/d;
    z.im := (q*x.im - x.re)/d;
    z.re := t;
  end;
end;
 *)

 (*
procedure Z_DIV_acc;
  {-Return the quotient z = x/y}
var
  d,q,t: extended;
  x,y: complex;
  z: complex;
begin
  asm
    fstp x.re
    fstp x.im
    fstp y.re
    fstp y.im
  end;

  {Smith's method: see Knuth[32], Exercise 4.2.1.16 and NR[13], (5.4.5)}
  if abs(y.re) >= abs(y.im) then begin
    q := y.im/y.re;
    d := y.re + q*y.im;
    t := (x.re + q*x.im)/d;
    z.im := (x.im - q*x.re)/d;
    z.re := t;
  end
  else begin
    q := y.re/y.im;
    d := y.im + q*y.re;
    t := (q*x.re + x.im)/d;
    z.im := (q*x.im - x.re)/d;
    z.re := t;
  end;

  asm
    fld z.im
    fld z.re
  end;
end;
 *)


//algoritm cdiv from WE    Smith
procedure Z_DIV_ACC; assembler;       {.335}
// z1/z2; z1.RE-ST,z1.IM-ST(1),z2.RE-ST(2),z2.IM-ST(3);
asm
     fxch st(3)
     fld st(0)
     fabs
     fxch st(3)
     fld  st(0)
     fabs
     fcomip st(0),st(4)

     jb @@low

     fld  st(0)
     fdivr st(0),st(2)
     fmul st(2),st(0)
     fxch st(2)
     faddp st(1),st(0)

     fxch st(2)
     fst st(3)
     fmul st(0),st(1)
     fxch st(4)
     fmul st(1),st(0)
     faddp st(4),st(0)
     fsubp st(2),st(0)
     fdiv st(2),st(0)
     fdivp st(1),st(0)
     fxch st(1)
     jmp @@end



     @@low:
     fld  st(0)
     fdiv st(0),st(2)
     fmul st(1),st(0)
     fxch st(2)
     faddp st(1),st(0)

     fxch st(4)
     fst st(3)
     fmul st(0),st(1)
     fxch st(2)
     fmul st(1),st(0)
     faddp st(2),st(0)
     fsubrp st(2),st(0)
     fdiv  st(0),st(2)
     fxch st(1)
     fdivrp st(2),st(0)


     @@end:
end;


 (*
//robust zdiv from WE of Baudin&Smith
procedure cdiv_robust(const x,y: TcomplexE; var z: TcomplexE);
  {-Return the quotient z = x/y}
{type
 THexExtW = packed array[0..4] of word; }
var
  a,b,c,d,e,f,q,r,h: extended;


const
  OVH : THexExtW = ($0000,$0000,$0000,$8000,$7FFE); {5.9486574767861588254E+4931 = MaxExtended/2 = 2^16383}
  UNH : THexExtW = ($0000,$0000,$0000,$8000,$0080); {5.7203220768525494207E-4894 = MinExtended*2/eps_x^2 = 2^(-16255)}
  Beh : THexExtW = ($0000,$0000,$0000,$8000,$407E); {0.170141183460469231731687303716e39 = 2/eps_x^2 = 2^127}
var
  OVT: extended absolute OVH;   {Overflow  threshold   }
  UNT: extended absolute UNH;   {Underflow threshold   }
  Be:  extended absolute Beh;   {Underflow scale factor}
var
  ab,cd,s: extended;


begin
  a := x.re;
  b := x.im;
  c := y.re;
  d := y.im;

  e := abs(c);
  f := abs(d);


  {Robust algorithm from Baudin/Smith [68], Fig.9. Part 1: Scaling}
  s := 1.0;
  if abs(a) > abs(b) then ab := abs(a) else ab := abs(b);
  if e>f then cd := e else cd := f;

  if ab >= OVT then begin
    {Scale down a, b}
    a := 0.5*a;
    b := 0.5*b;
    s := 2.0*s;;
  end;
  if cd >= OVT then begin
    {Scale down c, d}
    c := 0.5*c;
    d := 0.5*d;
    s := 0.5*s;
  end;
  if ab <= UNT then begin
    {Scale up a, b}
    a := a*Be;
    b := b*Be;
    s := s/Be;
  end;
  if cd <= UNT then begin
    {Scale up c, d}
    c := c*Be;
    d := d*Be;
    s := s*Be;
  end;

  {This is the robust internal algorithm from [68], Fig.10. AMath implements}
  {a completely expanded code without calling other functions (except abs)! }
  if f <= e {abs(d) <= abs(c)} then begin
    r := d/c;
    if r=0.0 then begin
      e := (a + d*(b/c))/c;
      f := (b - d*(a/c))/c;
    end
    else begin
      {/q is slightly more accurate than the original *t and also gives}
      {compatible results to the non-robust code for the 'easy' cases. }
      q := (c + d*r);
      h := b*r;  if h<>0.0 then e := (a + h)/q else e := a/q + (b/q)*r;
      h := a*r;  if h<>0.0 then f := (b - h)/q else f := b/q - (a/q)*r;
    end;

      z.re := s*e;
      z.im := s*f;

  end
  else begin
    r := c/d;
    if r=0.0 then begin
      e := (b + c*(a/d))/d;
      f := (a - c*(b/d))/d;
    end
    else begin
      q := d + c*r;
      h := a*r;  if h<>0.0 then e := (b + h)/q else e := b/q + (a/q)*r;
      h := b*r;  if h<>0.0 then f := (a - h)/q else f := a/q - (b/q)*r;
    end;

      z.re := s*e;
      z.im := -s*f;

  end;
end;

*)




//robust zdiv from WE of Baudin&Smith
//procedure cdiv_robust(const x,y: TcomplexE; var z: TcomplexE);
procedure Z_DIV_EXTRA;
  {-Return the quotient z = x/y}
{type
 THexExtW = packed array[0..4] of word; }
var
  a,b,c,d,e,f,q,r,h: extended;
  x,y: TcomplexE;
  z: TcomplexE;


type THexExtW = packed array[0..4] of word;

const
  OVH : THexExtW = ($0000,$0000,$0000,$8000,$7FFE); {5.9486574767861588254E+4931 = MaxExtended/2 = 2^16383}
  UNH : THexExtW = ($0000,$0000,$0000,$8000,$0080); {5.7203220768525494207E-4894 = MinExtended*2/eps_x^2 = 2^(-16255)}
  Beh : THexExtW = ($0000,$0000,$0000,$8000,$407E); {0.170141183460469231731687303716e39 = 2/eps_x^2 = 2^127}
var
  OVT: extended absolute OVH;   {Overflow  threshold   }
  UNT: extended absolute UNH;   {Underflow threshold   }
  Be:  extended absolute Beh;   {Underflow scale factor}
var
  ab,cd,s: extended;


begin
 {
  asm
    fstp x.re
    fstp x.im
    fstp y.re
    fstp y.im
  end;


  a := x.re;
  b := x.im;
  c := y.re;
  d := y.im;

  e := abs(c);
  f := abs(d);

   }

  asm
    fstp a //x.re
    fstp b //x.im
    fld  st(0)
    fstp  c //y.re
    fabs
    fstp  e //e = fabs(c)
    fld st(0)
    fstp  d //y.im
    fabs
    fstp  f //f = abs(d)
  end;

 


  {Robust algorithm from Baudin/Smith [68], Fig.9. Part 1: Scaling}
  s := 1.0;
  if abs(a) > abs(b) then ab := abs(a) else ab := abs(b);
  if e>f then cd := e else cd := f;

  if ab >= OVT then begin
    {Scale down a, b}
    a := 0.5*a;
    b := 0.5*b;
    s := 2.0*s;;
  end;
  if cd >= OVT then begin
    {Scale down c, d}
    c := 0.5*c;
    d := 0.5*d;
    s := 0.5*s;
  end;
  if ab <= UNT then begin
    {Scale up a, b}
    a := a*Be;
    b := b*Be;
    s := s/Be;
  end;
  if cd <= UNT then begin
    {Scale up c, d}
    c := c*Be;
    d := d*Be;
    s := s*Be;
  end;

  {This is the robust internal algorithm from [68], Fig.10. AMath implements}
  {a completely expanded code without calling other functions (except abs)! }
  if f <= e {abs(d) <= abs(c)} then begin
    r := d/c;
    if r=0.0 then begin
      e := (a + d*(b/c))/c;
      f := (b - d*(a/c))/c;
    end
    else begin
      {/q is slightly more accurate than the original *t and also gives}
      {compatible results to the non-robust code for the 'easy' cases. }
      q := (c + d*r);
      h := b*r;  if h<>0.0 then e := (a + h)/q else e := a/q + (b/q)*r;
      h := a*r;  if h<>0.0 then f := (b - h)/q else f := b/q - (a/q)*r;
    end;

      z.re := s*e;
      z.im := s*f;

  end
  else begin
    r := c/d;
    if r=0.0 then begin
      e := (b + c*(a/d))/d;
      f := (a - c*(b/d))/d;
    end
    else begin
      q := d + c*r;
      h := a*r;  if h<>0.0 then e := (b + h)/q else e := b/q + (a/q)*r;
      h := b*r;  if h<>0.0 then f := (a - h)/q else f := a/q - (b/q)*r;
    end;

      z.re := s*e;
      z.im := -s*f;

  end;


  asm
    fld z.im
    fld z.re
  end;
end;





//robust zdiv from WE of Baudin&Smith
//procedure cdiv_robust(const x,y: TcomplexE; var z: TcomplexE);
procedure Z_RZDIV_EXTRA;
  {-Return the quotient z = x/y}
{type
 THexExtW = packed array[0..4] of word; }
var
  a,b,c,d,e,f,q,r,h: extended;
  x,y: TcomplexE;
  z: TcomplexE;


const
  OVH : THexExtW = ($0000,$0000,$0000,$8000,$7FFE); {5.9486574767861588254E+4931 = MaxExtended/2 = 2^16383}
  UNH : THexExtW = ($0000,$0000,$0000,$8000,$0080); {5.7203220768525494207E-4894 = MinExtended*2/eps_x^2 = 2^(-16255)}
  Beh : THexExtW = ($0000,$0000,$0000,$8000,$407E); {0.170141183460469231731687303716e39 = 2/eps_x^2 = 2^127}
var
  OVT: extended absolute OVH;   {Overflow  threshold   }
  UNT: extended absolute UNH;   {Underflow threshold   }
  Be:  extended absolute Beh;   {Underflow scale factor}
var
  ab,cd,s: extended;


begin
 {
  asm
    fstp x.re
    fstp y.re
    fstp y.im
  end;

  x.im:=0;

  a := x.re;
  b := x.im;
  c := y.re;
  d := y.im;

  e := abs(c);
  f := abs(d);
 }

 asm
    fstp a //x.re
    fldz    //x.im = 0
    fstp b  //x.im
    fld  st(0)
    fstp  c //y.re
    fabs
    fstp  e //e = fabs(c)
    fld st(0)
    fstp  d //y.im
    fabs
    fstp  f //f = abs(d)
  end;

  {Robust algorithm from Baudin/Smith [68], Fig.9. Part 1: Scaling}
  s := 1.0;
  if abs(a) > abs(b) then ab := abs(a) else ab := abs(b);
  if e>f then cd := e else cd := f;

  if ab >= OVT then begin
    {Scale down a, b}
    a := 0.5*a;
    b := 0.5*b;
    s := 2.0*s;;
  end;
  if cd >= OVT then begin
    {Scale down c, d}
    c := 0.5*c;
    d := 0.5*d;
    s := 0.5*s;
  end;
  if ab <= UNT then begin
    {Scale up a, b}
    a := a*Be;
    b := b*Be;
    s := s/Be;
  end;
  if cd <= UNT then begin
    {Scale up c, d}
    c := c*Be;
    d := d*Be;
    s := s*Be;
  end;

  {This is the robust internal algorithm from [68], Fig.10. AMath implements}
  {a completely expanded code without calling other functions (except abs)! }
  if f <= e {abs(d) <= abs(c)} then begin
    r := d/c;
    if r=0.0 then begin
      e := (a + d*(b/c))/c;
      f := (b - d*(a/c))/c;
    end
    else begin
      {/q is slightly more accurate than the original *t and also gives}
      {compatible results to the non-robust code for the 'easy' cases. }
      q := (c + d*r);
      h := b*r;  if h<>0.0 then e := (a + h)/q else e := a/q + (b/q)*r;
      h := a*r;  if h<>0.0 then f := (b - h)/q else f := b/q - (a/q)*r;
    end;

      z.re := s*e;
      z.im := s*f;

  end
  else begin
    r := c/d;
    if r=0.0 then begin
      e := (b + c*(a/d))/d;
      f := (a - c*(b/d))/d;
    end
    else begin
      q := d + c*r;
      h := a*r;  if h<>0.0 then e := (b + h)/q else e := b/q + (a/q)*r;
      h := b*r;  if h<>0.0 then f := (a - h)/q else f := a/q - (b/q)*r;
    end;

      z.re := s*e;
      z.im := -s*f;

  end;


  asm
    fld z.im
    fld z.re
  end;
end;



  (*
procedure rdivc(x: extended; const y: complex; var z: complex);
  {-Return the quotient z = x/y for real x}
var
  d,q: extended;
begin
  {Stripped-down version of Smith's cdiv}
  if abs(y.re) >= abs(y.im) then
  begin
    q := y.im/y.re;
    if abs(y.re) < MV_4 then d := y.re + q*y.im
    else begin
      d := 0.5*y.re + 0.5*q*y.im;
      x := 0.5*x;
    end;
    z.im := -(q*x)/d;
    z.re := x/d;
  end
  else
  begin
    q := y.re/y.im;
    if abs(y.re) < MV_4 then d := y.im + q*y.re
    else begin
      d := 0.5*y.im + 0.5*q*y.re;
      x := 0.5*x;
    end;
    z.re := (q*x)/d;
    z.im := -x/d;
  end;
end;

*)



(*
//procedure rdivc(x: extended; const y: complex; var z: complex);
procedure Z_RZDIV_acc;
  {-Return the quotient z = x/y for real x}
var
  d,q,x: extended;
  y,z: complex;
begin

  asm
    fstp x
    fstp y.re
    fstp y.im
  end;

  {Stripped-down version of Smith's cdiv}
  if abs(y.re) >= abs(y.im) then
  begin
    q := y.im/y.re;
    if abs(y.re) < MV_4 then d := y.re + q*y.im
    else begin
      d := 0.5*y.re + 0.5*q*y.im;
      x := 0.5*x;
    end;
    z.im := -(q*x)/d;
    z.re := x/d;
  end
  else
  begin
    q := y.re/y.im;
    if abs(y.re) < MV_4 then d := y.im + q*y.re
    else begin
      d := 0.5*y.im + 0.5*q*y.re;
      x := 0.5*x;
    end;
    z.re := (q*x)/d;
    z.im := -x/d;
  end;


  asm
    fld z.im
    fld z.re
  end;

end;

*)


 //reduced version of  rdivc, without check of condition MV_4
 //full version see low: Z_RZDIV_acc_full
procedure Z_RZDIV_ACC;   assembler;    {.335}
//x/z: st(0) -x; st(1) - z.re; st(2) - z.im
  asm
     fxch st(1)
     fld st(0)
     fabs
     fxch st(3)
     fld  st(0)
     fabs
     fcomip st(0),st(4)
     jnb @@low           //if abs(y.re) >= abs(y.im) then

     //d := y.re + q*y.im
     fstp   st(3)
     fxch st(2)
     fld    st(0)
     fdiv   st(0),st(3)
     fmul   st(1),st(0)
     fxch   st(3)
     faddp  st(1),st(0)



     @@answ:           //d,x,q
      //z.im := -(q*x)/d;
     // z.re := x/d;
     fld   st(0)
     fdivr st(0),st(2)
     fxch  st(3)
     fmulp st(2),st(0)
     fdivp st(1),st(0)
     fchs
     fxch st(1)



     jmp @@end



     @@low:

     fstp   st(3)
     fld    st(0)
     fdiv   st(0),st(3)

     fmul   st(1),st(0)
     fxch   st(1)
     faddp st(3),st(0)
     fxch st(2)



      @@answ2:       //d,x,q
      {z.re := (q*x)/d;
      z.im := -x/d;   }
      fld st(0)
      fdivr st(0),st(2)
      fchs
      fxch st(3)
      fmulp st(2),st(0)
      fdivp st(1),st(0)



     @@end:
  end;




procedure Z_RZDIV_acc_full;   assembler;    {.335}
const MV_4  : extended = 0.2974328738393e4932;  {< MaxExtended/4}
const C_05  : double = 0.5;
//x/z: st(0) -x; st(1) - z.re; st(2) - z.im
  asm
     fxch st(1)
     fld st(0)
     fabs
     fxch st(3)
     fld  st(0)
     fabs
     fcomip st(0),st(4)
     jnb @@low           //if abs(y.re) >= abs(y.im) then

     {
     q := y.im/y.re;
    if abs(y.re) < MV_4 then d := y.re + q*y.im
    else
    begin
      d := 0.5*y.re + 0.5*q*y.im;
      x := 0.5*x;
    end;
    z.im := -(q*x)/d;
    z.re := x/d;
    }

     fld  st(0)
     fdiv st(0),st(2)
     fxch st(4)
     fld  MV_4
     fcomip st(0),st(1)
     fstp st(0)
     jb @@dlow   //if abs(y.re) < MV_4 then

     //d := y.re + q*y.im
     fmul  st(0),st(3)
     faddp st(1),st(0)
     jmp @@answ

     @@dlow:
      //d := 0.5*y.re + 0.5*q*y.im;
      //x := 0.5*x;
      fmul  st(0),st(3)
      fmul C_05
      fxch st(1)
      fmul C_05
      faddp st(1),st(0)
      fxch st(1)
      fmul C_05
      fxch st(1)


     @@answ:           //d,x,q
      //z.im := -(q*x)/d;
     // z.re := x/d;
     fld   st(0)
     fdivr st(0),st(2)
     fxch  st(3)
     fmulp st(2),st(0)
     fdivp st(1),st(0)
     fchs
     fxch st(1)



     jmp @@end



     @@low:

    {  q := y.re/y.im;
    if abs(y.re) < MV_4 then d := y.im + q*y.re
    else
    begin
      d := 0.5*y.im + 0.5*q*y.re;
      x := 0.5*x;
    end;
    z.re := (q*x)/d;
    z.im := -x/d;   }
     fld    st(0)
     fdivr  st(0),st(2)
     fxch   st(4)
     fld    MV_4
     fcomip st(0),st(1)
     fstp   st(0)
     jb @@dlow2   //if abs(y.re) < MV_4 then
     //d := y.im + q*y.re
     fxch st(1)
     fmul  st(0),st(3)
     faddp st(1),st(0)
     jmp @@answ2

     jmp @@answ2
     @@dlow2:
      {d := 0.5*y.im + 0.5*q*y.re;
      x := 0.5*x;}
      fxch st(1)
      fmul  st(0),st(3)
      fmul C_05
      fxch st(1)
      fmul C_05
      faddp st(1),st(0)
      fxch st(1)
      fmul C_05
      fxch st(1)

      @@answ2:       //d,x,q
      {z.re := (q*x)/d;
      z.im := -x/d;   }
      fld st(0)
      fdivr st(0),st(2)
      fchs
      fxch st(3)
      fmulp st(2),st(0)
      fdivp st(1),st(0)




     @@end:
  end;





{
RE(sqrt) = sqrt((sqrt(re^2+im^2)+re)*0.5)
IM(sqrt) = sign(im)*sqrt((sqrt(re^2+im^2)-re)*0.5)
}
procedure Z_SQRT;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
asm
 //push   ax
 fxch
 ftst
 fstsw  ax
 sahf
 fmul   st,st
 fxch
 fld    st
 fmul   st,st
 faddp st(2),st
 fxch
 fsqrt
 fld   st
 fsub  st,st(2)
 fmul  c05
 fsqrt
 jnb   @@1
 fchs
@@1:
 fxch  st(2)
 faddp
 fmul  c05
 fsqrt
 //pop   ax

end;



procedure Z_SQR;
const c2: double=2;
//RE-ST(0); IM-ST(1);
asm
 fld   st
 fmul  st,st
 fxch
 fmul  st,st(2)
 fmul  c2
 fxch  st(2)
 fmul  st,st
 fsubp
end;



procedure Z_LN;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
asm
 fld  st
 fxch st(2)
 fld  st
 fxch st(3)
 fpatan
 fxch st(2)
 fmul st,st
 fxch
 fmul st,st
 faddp
 fldln2
 fxch
 fyl2x
 fmul  c05
end;







procedure  R_FPWR2I;   //2^int
var
MX: Extended;
M: Cardinal;
asm
//******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)

        {
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        }

        mov      ebx,Max2Power
        cmp      eax,ebx
        JL       @@LowMaxI
         //call Overflow Error:
        fild Power2Overflow
        fld1
        fscale  //Float Overflow
        fstp   st(1)
        JMP      @@end

@@LowMaxI:  //ipower < Max2PowerN ??

        mov      ebx,Max2PowerN
        cmp      eax,ebx
        JG       @@pwr2i
        fldz
        JMP      @@end

@@pwr2i:

        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
@@end:

//**********************
end;


procedure R_F2PWR;   //2^X
const F2: double =2.0;
var
M: Cardinal;
MX: Extended;
asm
//2^X
//ST(0) <- X




     FLD       ST
     //FRNDINT
     FISTP M
     FILD  M
     FCOMIP   ST(0),ST(1)
     JZ        @@int
     JMP       @@flow

@@int:


       //******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)
        FILD Max2Power
        FCOMIP   ST(0),ST(1)
        JNB   @@LowMaxI
        //call Overflow Error:
        fstp st(0)
        fild Power2Overflow
        fld1
        fscale  //Float Overflow
        fstp   st(1)
        JMP     @@end

@@LowMaxI:  //ipower < Max2PowerN ??
        FILD Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB   @@pwr2i
        fstp st(0)
        fldz
        JMP     @@end

@@pwr2i:
        FISTP M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
    //**********************

     JMP     @@end


@@flow:
     {.283}

     FLD     ST(0)

     FISTP M
     FILD  M

     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD

     {
     FSCALE
     FSTP  ST(1)
     }
      //******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)

        //fpower >  Max2Power ??
        FXCH ST(1)
        FILD Max2Power
        FCOMIP   ST(0),ST(1)
        JNB   @@LowMaxF
        //call Overflow Error:
        fstp st(0)
        fstp st(0)
        fild Power2Overflow
        fld1
        fscale  //Float Overflow
        fstp   st(1)
        JMP     @@end

@@LowMaxF:  //fpower < Max2PowerN ??
        FILD Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB   @@pwr2f
        fstp st(0)
        fstp st(0)
        fldz
        JMP     @@end

@@pwr2f:
        FISTP M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)

 (*
     // X=0 ??
     FLD F2

     FLDZ            {.}
     FCOMP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     JNZ    @@NoZero     //X<>0
                          //устраняет ошибки типа 0^P; P - дробная степень

     // X=0
     // P=0 ??
     //FXCH
     //FLDZ
     FCOMPP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     fldz
     JB    @@end              //P>=0
                              //0^(-P)     P - дробная степень
                              //call error
     fstp st(0)
     fld1
     fchs
     fsqrt
     JMP     @@end      {.}

@@NoZero:
     FYL2X
     FLD     ST(0)
     //FRNDINT
     FISTP M
     FILD  M
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD
     {
     FSCALE
     FSTP  ST(1)
     }
      //******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)

        //fpower >  Max2Power ??
        FXCH ST(1)
        FILD Max2Power
        FCOMIP   ST(0),ST(1)
        JNB   @@LowMaxF
        //call Overflow Error:
        fstp st(0)
        fstp st(0)
        fild Power2Overflow
        fld1
        fscale  //Float Overflow
        fstp   st(1)
        JMP     @@end

@@LowMaxF:  //fpower < Max2PowerN ??
        FILD Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB   @@pwr2f
        fstp st(0)
        fstp st(0)
        fldz
        JMP     @@end

@@pwr2f:
        FISTP   M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)

    //**********************
 *)

@@end:

end;





procedure FPWR;
const
MaxInt: double= 2147483647;
var
M: Cardinal;
MX: Extended;
asm
//X^Y
//ST(0) <- X
//ST(1) <- Y



     FXCH

     FLD       ST
     FABS
     FLD      MaxInt
     fcompp
     fstsw   ax
     sahf
     jb      @@flow


     FIST      M
     FICOM     M
     {fld      st
     frndint
     fcomp}


     FNSTSW    AX
     SAHF;
     JZ        @@int
     JMP       @@flow

@@int:

     FXCH
     FSTP     ST(1)
     //FISTP    M


     MOV      EAX, M



     PUSH     ECX
     PUSH     EDX

     fld1
     fxch
     mov     ecx, eax
     cdq
     xor     eax, edx
     sub     eax, edx
     jnz     @@5
     fstp    ST(0)

     jmp     @@endInt
@@4: fmul    ST, ST
@@5: shr     eax,1
     jnc     @@4
     fmul    ST(1),ST
     jnz     @@4
     fstp    st
     cmp     ecx, 0



     jge     @@endInt
     //fdivr   S_c1
     fld1
     fdivrp

@@endInt:
     POP     EDX
     POP     ECX
     JMP     @@end

@@flow:

     // X=0 ??
     FXCH

     FLDZ            {.}
     FCOMP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     JNZ    @@NoZero           //X<>0
                          //устраняет ошибки типа 0^P; P - дробная степень

     // X=0
     // P=0 ??

     FCOMPP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     fldz
     JB    @@end              //P>=0
                              //0^(-P)     P - дробная степень
                              //call error
     fstp st(0)
     fld1
     fchs
     fsqrt
     JMP     @@end      {.}

@@NoZero:
     FYL2X
     FLD     ST(0)
     //FRNDINT
     FISTP M
     FILD  M
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD

     {
     FSCALE
     FSTP  ST(1)
     }
      //******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)

        //fpower >  Max2Power ??
        FXCH ST(1)
        FILD Max2Power
        FCOMIP   ST(0),ST(1)
        JNB   @@LowMaxF
        //call Overflow Error:
        fstp st(0)
        fstp st(0)
        fild Power2Overflow
        fld1
        fscale  //Float Overflow
        fstp  st(1) {.375}
        JMP     @@end

@@LowMaxF:  //fpower < Max2PowerN ??
        FILD Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB   @@pwr2f
        fstp st(0)
        fstp st(0)
        fldz
        JMP     @@end

@@pwr2f:
        FISTP M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)

@@end:

end;





procedure ZPWR;
//z1^z2; z1.RE-ST(0),z1.IM-ST(1),z2.RE-ST(2),z2.IM-ST(3);

// exp(z2*ln(z1))
var
M: Cardinal;
MX: Extended;
asm

 {.388}



 call Z_LN

 //ZMUL
 fld  st(0)
 fmul st(0),st(3)
 fxch st(1)
 fmul st(0),st(4)
 fxch st(4)
 fmul st(0),st(2)
 fsubp
 fxch st(2)
 fmulp
 faddp st(2),st(0)

 call Z_EXP



(*
 fld   st
 fmul  st,st
 fxch  st(2)
 fld   st
 fmul  st,st
 faddp st(3),st
 fxch  st(2)
 fsqrt
 //LN:
 fldln2
 fxch
 fyl2x

 fxch  st(2)
 fxch
 fpatan
 fld   st
 fmul  st,st(4)
 fxch
 fmul  st,st(3)
 fxch  st(2)
 fmul  st(3),st
 fmulp st(4),st
 fsubp st(2),st
 faddp st(2),st

 //EXP:
 call R_EXP    {.361}

 fxch
 fsincos
 fmul   st,st(2)
 fxch   st(2)
 fmulp
 fxch
 *)

@@end:
end;





procedure Z_ReCxFPWR;
//Re^z2; Re-ST(0),z2.RE-ST(1),z2.IM-ST(2);
var
M: Cardinal;
MX: Extended;
asm


 ftst
 fstsw  ax
 sahf


 fabs
 //LN:
 fldln2
 fxch
 fyl2x

 fld   st
 jnb    @@1

 fmul  st,st(2)
 fldpi
 fmul  st,st(4)
 fsubp
 fxch  st(3)
 fmulp
 fldpi
 fmulp st(2),st
 faddp
 fxch
 jmp   @@2


@@1:
 fmulp st(2),st
 fmulp st(2),st
@@2:
  //EXP:
 call R_EXP    {.361}

 fxch
 fsincos
 fmul   st,st(2)
 fxch
 fmulp  st(2),st
@@end:
end;



procedure Z_CxReFPWR;
//z1^Re; z1.RE-ST,z1.IM-ST(1),Re-ST(2);
const c2: double=2;
var
M: Cardinal;
MX: Extended;
asm

        FXCH      ST(2)
        FIST      M//MEM
        FICOM     M//MEM
        FNSTSW    AX
        SAHF;
        JZ        @@int
        FXCH      ST(2)
        JMP       @@float

@@int:
          {.388}
        FSTP     ST
        FXCH
        MOV      EAX, M
        CALL     Z_IPWR    // uses: eax,ecx,edx
        jmp     @@end

(*
        FSTP     ST
        FXCH
        MOV      EAX, M//MEM

        fldz
        fxch    ST(2)
        fld1
        fxch    ST(2)
        mov     ecx, eax
        cdq
        xor     eax, edx
        sub     eax, edx
        jz      @@3
        jmp     @@2

   @@1: fld   st          //^2
        fmul  st,st
        fxch
        fmul  st,st(2)
        fmul  c2
        fxch  st(2)
        fmul  st,st
        fsubp

   @@2: shr     eax,1         //*z
        jnc     @@1

        fld   ST(0)
        fmul  ST(0),ST(3)
        fxch  ST(3)
        fmul  ST(0),ST(2)
        fxch  ST(4)
        fld   ST(0)
        fmul  ST(0),ST(3)
        fxch  ST(1)
        fmul  ST(0),ST(2)
        faddp ST(5),ST(0)
        fsubp ST(3),ST(0)
        jnz   @@1

@@3:
        fstp   st
        fstp   st

        cmp    ecx, 0
        jge    @@end
        // 1/z
        {.335}
        test  F_FastDiv,1
        jnz   @@fastdiv
        fld1
        call  RZDIV_ACC_ADDR //Z_RZDIV_acc
        jmp   @@end

        @@fastdiv:
        //FAST_RZDIV:
        fld    st
        fmul   st,st
        fxch   st(2)
        fld    st
        fmul   st,st
        faddp  st(3),st
        fld1
        fdivrp st(3),st
        fmul   st,st(2)
        fchs
        fxch   st(2)
        fmulp  st(1),st

        jmp    @@end
*)

@@float:
        //ZPUSHST
        fld   st
        fxch  st(2)
        fld   st
        fxch  st(3)

        fmul  st,st
        fxch
        fmul  st,st
        faddp
        fsqrt

        //LN:
        fldln2
        fxch
        fyl2x

        fmul  st,st(3)

        //EXP:
        call R_EXP    {.361}

        fxch  st(2)
        fxch
        fpatan
        fmulp st(2),st
        fxch
        fsincos
        fmul   st,st(2)
        fxch
        fmulp  st(2),st

@@end:
end;



{v177}
procedure Z_IPWR;    assembler;
const c2:double=2;
//z1^Int; z1.RE-ST,z1.IM-ST(1),Int-EAX;

// uses: eax,ecx,edx,
asm

       { FXCH      ST(2)
        FIST      M//MEM
        FICOM     M//MEM
        FNSTSW    AX
        SAHF;
        JZ        @@int
        FXCH      ST(2)
        JMP       @@float }

@@int:
        {FSTP     ST
        FXCH
        MOV      EAX, M//MEM   }

        fldz
        fxch    ST(2)
        fld1
        fxch    ST(2)
        mov     ecx, eax
        cdq
        xor     eax, edx
        sub     eax, edx
        jz      @@3
        jmp     @@2

   @@1: fld   st          //^2
        fmul  st,st
        fxch
        fmul  st,st(2)
        //fmul  S_c2
        fmul c2             {.217}
        fxch  st(2)
        fmul  st,st
        fsubp

   @@2: shr     eax,1         //*z
        jnc     @@1

        fld   ST(0)
        fmul  ST(0),ST(3)
        fxch  ST(3)
        fmul  ST(0),ST(2)
        fxch  ST(4)
        fld   ST(0)
        fmul  ST(0),ST(3)
        fxch  ST(1)
        fmul  ST(0),ST(2)
        faddp ST(5),ST(0)
        fsubp ST(3),ST(0)
        jnz   @@1

@@3:
        fstp   st
        fstp   st

        cmp    ecx, 0
        jge    @@end
        // 1/z

        {.335}
        test  F_FastDiv,1
        jnz   @@fastdiv
        fld1
        call  RZDIV_ACC_ADDR //Z_RZDIV_acc
        jmp   @@end

        @@fastdiv:
        //fl_FAST_ZDIV:
        fld    st
        fmul   st,st
        fxch   st(2)
        fld    st
        fmul   st,st
        faddp  st(3),st
        fld1                     //FAST_RZDIV
        fdivrp st(3),st
        fmul   st,st(2)
        fchs
        fxch   st(2)
        fmulp  st(1),st

@@end :
end;



{.361}
procedure Z_ImU_IPWR;   assembler;
{
  (i)^IntPwr
  (-i)^IntPwr

  IntPwr ->  EAX
  Sing(i) -> EBX  //=0: +i; =1: -i;
}
asm
   //push eax
   //push ebx
   push ecx
   push edx

   //mov  eax, IPWR
   //mov  ebx, SGNI //sign of i =0: i;  =1: -i;

   mov  ecx, eax
   //abs(eax)
   cdq
   xor  eax, edx
   sub  eax, edx

   and  ecx, $80000000 //sign (eax)
   rol  ecx,1    //sign of power  =0: > 0;  =1: < 0;
   xor  ebx,ecx  //common sign of result

   and  eax,3
   cmp  eax,0
   jnz  @no0
   fldz
   fld1
   jmp  @endp
 @no0:
   cmp  eax,1
   jnz  @no1
   //^1          //   (i)^(1) (-i)^(-1)    (-i)^1  (i)^(-1)
   fld1
   cmp  ebx,1
   jnz  @p1
   fchs          //(-i)^1  (i)^(-1)
   @p1:
   fldz
   jmp  @endp
  @no1: // 2
   cmp  eax,2
   jnz  @no2
   //^2
   fldz
   fld1
   fchs
   jmp  @endp

  @no2:     // 3
   //cmp eax,3
   //jnz  @no3
   //^3
   fld1
   cmp  ebx,1
   jz   @p3
   fchs
   @p3:
   fldz
   jmp  @endp

 @endp:
   pop edx
   pop ecx
   //pop ebx
   //pop eax
end;




procedure R_CR_FPWR;    assembler;   //(x=const)^y
var
M: Cardinal;
MX: Extended;
asm
//Const(X)^Y

//ST(0) <- ln2(const(X)), если X <= 0 вычисление через общую команду FPWR
//ST(1) <- const(X)
//ST(2) <- Y



     FXCH      ST(2)     {R_CR_FPWR}

     FLD       ST
     FABS
     FLD      MaxInt
     fcompp
     fstsw   ax
     sahf
     jb      @@flow


     FIST      M
     FICOM     M
     {fld      st
     frndint
     fcomp}


     FNSTSW    AX
     SAHF;
     JZ        @@int
     JMP       @@flow

@@int:

     FXCH
     FSTP     ST(1)
     //FISTP    M


     MOV      EAX, M



     PUSH     ECX
     PUSH     EDX

     fld1
     fxch
     mov     ecx, eax
     cdq
     xor     eax, edx
     sub     eax, edx
     jnz     @@5
     fstp    ST(0)

     jmp     @@endInt
@@4: fmul    ST, ST
@@5: shr     eax,1
     jnc     @@4
     fmul    ST(1),ST
     jnz     @@4
     fstp    st
     cmp     ecx, 0



     jge     @@endInt
     //fdivr   S_c1
     fld1
     fdivrp

@@endInt:
     POP     EDX
     POP     ECX
     fstp    st(1)        {R_CR_FPWR}
     JMP     @@end

@@flow:


     //FYL2X            {R_CR_FPWR}
     FMULP ST(2),ST(0)              {R_CR_FPWR} //y*ln2(x)
     FSTP  ST(0)                     {R_CR_FPWR}

     FLD     ST(0)
     FISTP M
     FILD  M
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD

     {
     FSCALE
     FSTP  ST(1)
     }
      //******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)

        //fpower >  Max2Power ??
        FXCH ST(1)
        FILD Max2Power
        FCOMIP   ST(0),ST(1)
        JNB   @@LowMaxF
        //call Overflow Error:
        fstp st(0)
        fstp st(0)
        fild Power2Overflow
        fld1
        fscale  //Float Overflow
        fstp   st(1)
        JMP     @@end

@@LowMaxF:  //fpower < Max2PowerN ??
        FILD Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB   @@pwr2f
        fstp st(0)
        fstp st(0)
        fldz
        JMP     @@end

@@pwr2f:
        FISTP M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)

@@end:

end;




procedure Z_CRe_CxFPWR;
//Const(Re)^Z;

//ln(abs(Re)) -> ST(0)
//Re-ST(1)
//Z.RE-ST(2)
//Z.IM-ST(3);

var
M: Cardinal;
MX: Extended;
asm

 fxch  st(1) {Z_CRe_CxFPWR}

 ftst
 fstsw  ax
 sahf


 fstp st(0)   {Z_CRe_CxFPWR}

 {
 fabs
 //LN:
 fldln2
 fxch
 fyl2x
 }

 fld   st
 jnb    @@1

 fmul  st,st(2)
 fldpi
 fmul  st,st(4)
 fsubp
 fxch  st(3)
 fmulp
 fldpi
 fmulp st(2),st
 faddp
 fxch
 jmp   @@2


@@1:
 fmulp st(2),st
 fmulp st(2),st
@@2:
  //EXP:
 call R_EXP    {.361}

 fxch
 fsincos
 fmul   st,st(2)
 fxch
 fmulp  st(2),st
@@end:
end;




procedure Z_CCxRe_FPWR;
//(Const(Z=a+i*b))^Re;

{
a -> ST(0)
b -> ST(1)
ln(sqrt(a^2+b^2)) -> ST(2)
arg(a+i*b)        -> ST(3)
Re                -> ST(4);
}


const c2: double=2;
var
M: Cardinal;
MX: Extended;
asm

        FXCH      ST(4)     {Z_CCxRe_FPWR}
        FIST      M//MEM
        FICOM     M//MEM
        FNSTSW    AX
        SAHF;
        JZ        @@int
        FXCH      ST(4)     {Z_CCxRe_FPWR}
        JMP       @@float

@@int:

       {.388}
        FSTP     ST
        FSTP     ST(2)   {Z_CCxRe_FPWR}
        FSTP     ST      {Z_CCxRe_FPWR}
        FXCH
        MOV      EAX, M
        CALL     Z_IPWR     // uses eax,ecx,edx
        jmp     @@end

(*
        FSTP     ST
        FSTP     ST(2)   {Z_CCxRe_FPWR}
        FSTP     ST      {Z_CCxRe_FPWR}
        FXCH
        MOV      EAX, M//MEM

        fldz
        fxch    ST(2)
        fld1
        fxch    ST(2)
        mov     ecx, eax
        cdq
        xor     eax, edx
        sub     eax, edx
        jz      @@3
        jmp     @@2

   @@1: fld   st          //^2
        fmul  st,st
        fxch
        fmul  st,st(2)
        fmul  c2
        fxch  st(2)
        fmul  st,st
        fsubp

   @@2: shr     eax,1         //*z
        jnc     @@1

        fld   ST(0)
        fmul  ST(0),ST(3)
        fxch  ST(3)
        fmul  ST(0),ST(2)
        fxch  ST(4)
        fld   ST(0)
        fmul  ST(0),ST(3)
        fxch  ST(1)
        fmul  ST(0),ST(2)
        faddp ST(5),ST(0)
        fsubp ST(3),ST(0)
        jnz   @@1

@@3:
        fstp   st
        fstp   st

        cmp    ecx, 0
        jge    @@end
        // 1/z
        {.335}

        test  F_FastDiv,1
        jnz   @@fastdiv
        fld1
        call  RZDIV_ACC_ADDR //Z_RZDIV_acc
        jmp   @@end


        @@fastdiv:
        //FAST_RZDIV:
        fld    st
        fmul   st,st
        fxch   st(2)
        fld    st
        fmul   st,st
        faddp  st(3),st
        fld1
        fdivrp st(3),st
        fmul   st,st(2)
        fchs
        fxch   st(2)
        fmulp  st(1),st


        jmp    @@end
        *)

@@float:
        //ZPUSHST
        {fld   st
        fxch  st(2)
        fld   st
        fxch  st(3)

        fmul  st,st
        fxch
        fmul  st,st
        faddp
        fsqrt

        //LN:
        fldln2
        fxch
        fyl2x
        }
        fstp  st        {Z_CCxRe_FPWR}
        fstp  st        {Z_CCxRe_FPWR}
        fmul  st,st(2)

        //EXP:
        call R_EXP    {.361}

        {fxch  st(2)
        fxch
        fpatan}

        fxch  st(1)       {Z_CCxRe_FPWR}
        fmulp st(2),st
        fxch
        fsincos
        fmul   st,st(2)
        fxch
        fmulp  st(2),st

@@end:
end;





procedure Z_CCx_CxFPWR;
//(Const(Z1=a+i*b))^(Z2=Re+i*Im);


{
ln(sqrt(a^2+b^2)) -> ST(0)
arg(a+i*b)        -> ST(1)
Re                -> ST(2);
Im                -> ST(3);
}


var
M: Cardinal;
MX: Extended;
asm


 fld   st
 fmul  st,st(4)
 fxch
 fmul  st,st(3)
 fxch  st(2)
 fmul  st(3),st
 fmulp st(4),st
 fsubp st(2),st
 faddp st(2),st

 //EXP:
  call R_EXP    {.361}

 fxch
 fsincos
 fmul   st,st(2)
 fxch   st(2)
 fmulp
 fxch

@@end:
end;








procedure R_FACT; assembler;
//N -> EAX
asm
 push  ecx
 mov   ecx, dword ptr [Factorial]
 lea   ecx, [ecx+eax*8]
 lea   eax, [ecx+eax*2]
 fld   tbyte ptr [eax]
 pop   ecx
 //ret
end;





procedure R_FACT2; assembler;
asm
      push  ecx
      mov   ecx, dword ptr [Factorial2F]
      lea   ecx, [ecx+eax*8]
      lea   eax, [ecx+eax*2]
      fld   tbyte ptr [eax]
      pop   ecx
      //push eax
     (* push ecx
      mov  ecx,eax
      and  ecx,1
      test ecx,ecx
      jnz  @_fct1
      shr  eax,1
      mov  ecx,dword ptr [Factorial2]
      lea  ecx,[ecx+eax*8]
      lea  eax,[ecx+eax*2]
      fld  tbyte ptr [eax]
      jmp  @end
  @_fct1:
      add  eax,1
      shr  eax,1
      mov  ecx,dword ptr [Factorial1]
      lea  ecx,[ecx+eax*8]
      lea  eax,[ecx+eax*2]
      fld  tbyte ptr [eax]
  @end:
      pop  ecx
   *)
      //pop  eax
end;








 (*
procedure Z2_TANZ_EXPIZ;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//Z.RE-ST(0); Z.IM-ST(1);
{
Return:

  ST(0)   <-  RE(Exp(I*Z))
  ST(1)   <-  IM(Exp(I*Z))
  ST(2)   <-  RE(Tan(Z))
  ST(3)   <-  IM(Tan(Z))
}
asm

    //if Z.Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@ztan
   fsincos
   fld      st(0)
   fdivr    st(0),st(2)
   //fldz
   fxch   st(2)
   fxch   st(1)
   jmp @@end

@@ztan:

    //if Z.Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@ztanReIm
   // tan(Z.Im) = 1/i*(exp(-Im)^2-1)/(exp(-Im)^2+1)
   fxch   st(1)
   fchs
   call   R_EXP
   fld    st(0)
   fmul   st(0),st(0)
   fld    st(0)
   fld1
   faddp
   fxch   st(1)
   fld1
   fsubp
   fdivrp st(1),st(0)
   fchs
   fldz
   fxch  st(1)
   fxch  st(3)
   fxch  st(2)
   jmp @@end


@@ztanReIm:


  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)/i
  }
   fxch
   fchs
   call R_EXP
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch
   {
    ST(0) <- Re(exp(I*Z))
    ST(1) <- Im(exp(I*Z))
   }
   //ZPUSH
   fld   st
   fxch  st(2)
   fld   st
   fxch  st(3)
   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
   {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
    ST(2) <- Re(exp(I*Z))
    ST(3) <- Im(exp(I*Z))
   }
   fld   st(0)
   fmul  st(0),st(0)
   fxch
   fadd  st(0),st(0)


   fld1
   faddp
   //fadd c1

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(3),st(0) //st3=2*a+1+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=2*a+1+b^2+a^2


   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   //fdivr  c1

   fxch  st(2)


   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   //fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b

   fmul  st(0),st(1)   //Im'
   fxch  st(2)
   fmulp st(1),st(0)   //Re'
   // (Re',Im')/i
   fchs
   fxch  st(1)

   fxch  st(1)
   fxch  st(3)
   fxch  st(1)
   fxch  st(2)

@@end:
end;





procedure Z2_TANZ_EXPIZ_M;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
{
  IN:

    Z.RE-ST(0);
    Z.IM-ST(1);

    [esp+4]   addrRe
    [esp+8]   addrIm
    [esp+12]  TypeMem

  OUT:

    ST(0)   <-  RE(Tan(Z))
    ST(1)   <-  IM(Tan(Z))

    addrRe  <- RE(Exp(I*Z))
    addrIm  <- IM(Exp(I*Z))
}
asm

   mov  eax,[esp+4]       //addrRe for Exp(I*Z)
   mov  ebx,[esp+8]       //addrIm for Exp(I*Z)
   mov  ecx,[esp+12]      //TypeMem: _Extended, _Double

   //tan(z1)+sin(z1)

    //if Z.Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@ztan
   fsincos

   //SAVE EXP(I*Z):
   cmp   ecx,_Extended
   jnz   @@dbl_0I

   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp tbyte ptr [ebx]
   fdivrp    st(1),st(0)
   jmp @@end

 @@dbl_0I:
   fst qword ptr [eax]
   fxch
   fst qword ptr [ebx]
   fdivrp    st(1),st(0)
   jmp @@end
   //-------------------

@@ztan:

    //if Z.Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@ztanReIm
   // tan(Z.Im) = 1/i*(exp(-Im)^2-1)/(exp(-Im)^2+1)
   fxch   st(1)
   fchs
   push   eax
   call   R_EXP
   pop    eax

   //SAVE EXP(I*Z):
   cmp   ecx,_Extended
   jnz   @@dbl_R0
   fld  st(0)
   fstp  tbyte ptr [eax]
   fldz
   fstp  tbyte ptr [ebx]
   jmp @@tan_R0

 @@dbl_R0:
   fst  qword ptr [eax]
   fldz
   fstp qword ptr [ebx]
   //------------------

 @@tan_R0:
   fmul   st(0),st(0)
   fld    st(0)
   fld1
   faddp
   fxch   st(1)
   fld1
   fsubp
   fdivrp st(1),st(0)
   fchs
   fxch
   jmp @@end


@@ztanReIm:


  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)/i
  }
   fxch
   fchs
   push eax
   call R_EXP
   pop  eax
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch
   {
    ST(0) <- Re(exp(I*Z))
    ST(1) <- Im(exp(I*Z))
   }

    //SAVE EXP(I*Z):
   cmp   ecx,_Extended
   jnz   @@dbl_RI
   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp  tbyte ptr [ebx]
   fxch
   jmp @@tan_RI

 @@dbl_RI:
   fst  qword ptr [eax]
   fxch
   fstp qword ptr [ebx]
   fxch
   //------------------

   {
   //ZPUSH
   fld   st
   fxch  st(2)
   fld   st
   fxch  st(3)
  }

 @@tan_RI:
   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
    {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }

   //---------------------------
   {
    //ZPUSH
   fld   st
   fxch  st(2)
   fld   st
   fxch  st(3)

   fld1
   fsubp
   fxch st(2)
   fld1
   faddp
   fxch st(2)

   call Z_DIV_FAST
   fchs
   fxch
    }

   //-------------------
   {
   //a,b
   fld   st(0)
   fmul  st(0),st(0)
   //a^2,a,b
   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   //b^2,b,a,a^2
   fxch  st(3)
   fsub  c1
   //a^2-1,b,a,b^2
   fxch  st(1)
   fadd  st(0),st(0)
   //2*b,a^2-1,a,b^2
   fxch  st(1)
   fadd  st(0),st(3)
   //a^2+b^2-1,2*b,a,b^2
   fxch  st(2)
   fadd  c1
   fmul  st(0),st(0)
   //(a+1)^2,2*b,a^2+b^2-1,b^2
   faddp st(3),st(0)
   fld1
   fdivrp st(3),st(0)
   //2*b,a^2+b^2-1,DE
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)

   //  /i
   fchs
   fxch  st(1)

  }






   fld   st(0)
   fmul  st(0),st(0)
   fxch
   fadd  st(0),st(0)

   {
   fld1
   faddp
   }
   fadd c1

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(3),st(0) //st3=2*a+1+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=2*a+1+b^2+a^2

   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1

   fxch  st(2)

   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b

   fmul  st(0),st(1)   //Im'      *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'      *DE
   // (Re',Im')/i
   fchs
   fxch  st(1)



@@end:
end;







procedure Z2_EXPIZ_EXPNIZ;
{
 IN:
   ST(0) <- Z.re
   ST(1) <- Z.im

 OUT:
   ST(0) <-  Re(exp(i*Z))
   ST(1) <-  Im(exp(i*Z))
   ST(2) <-  Re(exp(-i*Z))
   ST(3) <-  Im(exp(-i*Z))
}
asm


   fxch  st(1)

   //If RE = 0
   fldz
   fcomip    st(0),st(1)
   jnz @@zexp
   fstp st(0)
   fsincos
   fld   st(0)
   fxch  st(2)
   fld   st(0)
   fchs
   fxch  st(3)
   {
     ST(0)  <-   cos(Z.re)
     ST(1)  <-   sin(Z.re)
     ST(2)  <-   cos(Z.re)
     ST(3)  <-  -sin(Z.re)
   }
   jmp @@end



 //EXP:
   @@zexp:
   call R_EXP

  //if IM = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@expz
   fstp st(1)
   fld  st(0)

   fld1                     //FAST_RDIV 1/e
   fdivr

   fldz
   fldz
   fxch st(3)
   fxch st(2)
   {
     ST(0)  <-   exp(-Z.im)
     ST(1)  <-   0
     ST(2)  <-   exp(-Z.im)
     ST(3)  <-   0
   }
   jmp @@end


   @@expz:
   {
     ST(0)  <-   exp(Z.im)
     ST(1)  <-   Z.re
   }
   fld   st(0)
   fld1
   fdivr


   fxch   st(2)
   fsincos
   fld    st(0)
   fmul   st(0),st(3)
   fxch   st(1)
   fmul   st(0),st(4)

   fxch   st(2)
   fchs
   fmul   st(3),st(0)
   fchs
   fmulp  st(4),st(0)

   fxch   st(2)
   fxch   st(3)
   fxch   st(1)


   @@end:
end;




procedure ZZ_TANZ_EXPIZ;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//Z.RE-ST(0); Z.IM-ST(1);
{
Return:

  ST(0)   <-  RE(Exp(I*Z))
  ST(1)   <-  IM(Exp(I*Z))
  ST(2)   <-  RE(Tan(Z))
  ST(3)   <-  IM(Tan(Z))
}
asm

    //if Z.Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@ztan
   fsincos
   fld      st(0)
   fdivr    st(0),st(2)
   fldz
   fxch   st(3)
   fxch   st(1)
   fxch   st(2)
   jmp @@end

@@ztan:

    //if Z.Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@ztanReIm

   fxch   st(1)

   fmul   c2
   call   R_EXP
   fld    st(0)
   fmul   st(0),st(0)
   fld    st(0)
   fsub   c1
   fxch   st(1)
   fadd   c1
   fmul   c05
   faddp  st(2),st(0)

   fdivrp
   fmul   c05
   fxch   st(1)

   jmp @@end


@@ztanReIm:

   fmul   c2
   fxch
   fmul   c2
   //EXP:
   call R_EXP    {.361}


   fld    st
   fmul   st,st
   fmul   c05
   fld    st
   fsub   c05
   fxch
   fadd   c05
   fxch   st(3)
   fsincos
   fmul   st,st(3)
   faddp  st(4),st
   fxch   st(3)
   //fdivr  S_c1

   fld1                            //FAST_RDIV 1/e
   fdivrp

   fxch
   fmul   st,st(1)
   fxch   st(3)
   fmulp  st(2),st
   fmulp
@@end:
end;




procedure Z_1DIV_EXPIZ_PLUS_EXPNIZ;
{
 IN:
   ST(0) <- exp(Z.re)
   ST(1) <- exp(Z.im)

 OUT:
   1/(exp(i*Z)+exp(-i*Z))
}
{
   a:ext=re(exp(z1)); b:ext=im(exp(z1)); Aa:ext=a^2-b^2+1; Bb:ext=2*a*b;
   DE:ext=1/(Aa^2+Bb^2);  ((a*Aa+b*Bb)+i*(b*Aa-a*Bb))*DE
}
const c1: double=1.0;
const c2: double=2.0;
asm
   fld   st(0)
   fmul  st(0),st(0)
   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   //b^2,b,a,a^2
   fxch  st(3)
   fld1
   faddp
   //fadd  c1
   fsubrp st(3),st(0)
   //b,a,Aa
   fld   st(0)
   fmul  st(0),st(2)
   fadd  st(0),st(0)
   //Bb,b,a,Aa
   fld   st(0)
   fmul  st(0),st(0)
   //Bb^2,Bb,b,a,Aa
   fxch  st(4)
   fld   st(0)
   fmul  st(0),st(0)
   //Aa^2,Aa,Bb,b,a,Bb^2
   faddp st(5),st(0)
   fld1
   fdivrp st(5),st(0)
   fld   st(0)
    //Aa,Aa,Bb,b,a,DE
   fmul  st(0),st(4)
   //a*Aa,Aa,Bb,b,a,DE
   fxch  st(2)
   fld   st(0)
   //Bb,Bb,Aa,a*Aa,b,a,DE
   fmulp st(5),st(0)
   //Bb,Aa,a*Aa,b,a*Bb,DE
   fmul  st(0),st(3)
   fxch  st(1)
   //Aa,b*Bb,a*Aa,b,a*Bb,DE
   fmulp  st(3),st(0)
   //b*Bb,a*Aa,b*Aa,a*Bb,DE
   faddp  st(1),st(0)
   //Re',b*Aa,a*Bb,DE
   fxch  st(2)
   fsubp st(1),st(0)
   fxch  st(1)
   //Re',Im',DE
   fmul  st(0),st(2)
   fxch  st(1)
   fmulp st(2),st(0)

end;


procedure Z_TAN__OF__EXPIZ;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//Z.RE-ST(0); Z.IM-ST(1);
{

IN:

  ST(0)   <-  RE(Exp(I*Z))
  ST(0)   <-  IM(Exp(I*Z))

Return:


  ST(0)   <-  RE(Tan(Z))
  ST(0)   <-  IM(Tan(Z))
}
asm



  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)/i
  }

   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
   {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }
   fld   st(0)
   fmul  st(0),st(0)
   fxch
   fadd  st(0),st(0)

   {
   fld1
   faddp
   }
   fadd  c1

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(3),st(0) //st3=2*a+1+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=2*a+1+b^2+a^2
   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1

   fxch  st(2)

   {fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b

   fmul  st(0),st(1)   //Im'    *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'    *DE
   // (Re',Im')/i
   fchs
   fxch  st(1)



@@end:
end;




procedure Z_COTAN__OF__EXPIZ;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//Z.RE-ST(0); Z.IM-ST(1);
{

IN:

  ST(0)   <-  RE(Exp(I*Z))
  ST(0)   <-  IM(Exp(I*Z))

Return:


  ST(0)   <-  RE(CoTan(Z))
  ST(0)   <-  IM(CoTan(Z))
}
asm

 //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
   {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }



  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a-1)^2+b^2); DE*((a^2-1+b^2)-i*2*b)*i
  }
    {.377}



   fld   st(0)
   fmul  st(0),st(0)
   //a^2,a,b
   fxch
   fadd  st(0),st(0)
   //2*a,a^2,b


   {
   fld1
   faddp
   }
   fsubr c1
   //1-2*a,a^2,b

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   //b^2,b,a^2,1-2*a
   fadd  st(3),st(0) //st3=1-2*a+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=1-2*a+b^2+a^2
   //

   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1
   //DE,b,a^2,b^2

   fxch  st(2)

   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b
   fchs

   fmul  st(0),st(1)   //Im'       *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'       *DE
   // (Re',Im')*i
   fxch
   fchs



@@end:
end;


procedure Z2_COTANZ_EXPIZ_M;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
{
  IN:

    Z.RE-ST(0);
    Z.IM-ST(1);

    [esp+4]   addrRe
    [esp+8]   addrIm
    [esp+12]  TypeMem

  OUT:

    ST(0)   <-  RE(CoTan(Z))
    ST(1)   <-  IM(CoTan(Z))

    addrRe  <- RE(Exp(I*Z))
    addrIm  <- IM(Exp(I*Z))
}
asm

   mov  eax,[esp+4]       //addrRe for Exp(I*Z)
   mov  ebx,[esp+8]       //addrIm for Exp(I*Z)
   mov  ecx,[esp+12]      //TypeMem: _Extended, _Double

    //ctg(z1)+sin(z1)

    //if Z.Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcotan
   fsincos

   //SAVE EXP(I*Z):
   cmp   ecx,_Extended
   jnz   @@dbl_0I

   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp tbyte ptr [ebx]
   fdivp    st(1),st(0)
   jmp @@end

 @@dbl_0I:
   fst qword ptr [eax]
   fxch
   fst qword ptr [ebx]
   fdivp    st(1),st(0)
   jmp @@end
   //-------------------

@@zcotan:

    //if Z.Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zcotanReIm
   // ctg(z)=i*(exp(-z.Im)^2+1)/(exp(-z.Im)^2-1)
   fxch   st(1)
   fchs
   push   eax
   call   R_EXP
   pop    eax

   //SAVE EXP(I*Z):
   cmp   ecx,_Extended
   jnz   @@dbl_R0
   fld  st(0)
   fstp  tbyte ptr [eax]
   fldz
   fstp  tbyte ptr [ebx]
   jmp @@cotan_R0

 @@dbl_R0:
   fst  qword ptr [eax]
   fldz
   fstp qword ptr [ebx]
   //------------------

 @@cotan_R0:
   fmul   st(0),st(0)
   fld    st(0)
   fld1
   fsubp
   fxch   st(1)
   fld1
   faddp
   fdivrp st(1),st(0)
   //fchs
   fxch
   jmp @@end


@@zcotanReIm:


  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)/i
  }
   fxch
   fchs
   push eax
   call R_EXP
   pop  eax
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch
   {
    ST(0) <- Re(exp(I*Z))
    ST(1) <- Im(exp(I*Z))
   }

    //SAVE EXP(I*Z):
   cmp   ecx,_Extended
   jnz   @@dbl_RI
   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp  tbyte ptr [ebx]
   fxch
   jmp @@cotan_RI

 @@dbl_RI:
   fst  qword ptr [eax]
   fxch
   fstp qword ptr [ebx]
   fxch
   //------------------

   {
   //ZPUSH
   fld   st
   fxch  st(2)
   fld   st
   fxch  st(3)
  }

 @@cotan_RI:
   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
    {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }

  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a-1)^2+b^2); DE*((a^2-1+b^2)-i*2*b)*i
  }
    {.377}




   fld   st(0)
   fmul  st(0),st(0)
   //a^2,a,b
   fxch
   fadd  st(0),st(0)
   //2*a,a^2,b


   {
   fld1
   faddp
   }
   fsubr c1
   //1-2*a,a^2,b

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   //b^2,b,a^2,1-2*a
   fadd  st(3),st(0) //st3=1-2*a+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=1-2*a+b^2+a^2
   //

   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1
   //DE,b,a^2,b^2

   fxch  st(2)

   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b
   fchs

   fmul  st(0),st(1)   //Im'       *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'       *DE
   // (Re',Im')*i
   fxch
   fchs



@@end:
end;


procedure Z_EXPIZ;
//RE-ST(0); IM-ST(1);
var
M: Cardinal;
MX: Extended;
asm

   fxch  st(1)

   //If RE = 0
   fldz                        {.217}
   fcomip    st(0),st(1)
   jnz @@zexp
   fstp st(0)
   fsincos
   jmp @@end



 //EXP:
   @@zexp:
   call R_EXP    {.361}

   //if IM = 0
   fldz                        {.355}
   fcomip    st(0),st(2)
   jnz @@zexpcx
   fld1
   fdivr
   jmp @@end

   @@zexpcx:
   fld1
   fdivr
   fxch
   fsincos
   fmul  st,st(2)
   fxch
   fmulp st(2),st

@@end:

end;



procedure R_COSH_SINH; assembler;  {.377}
//ST(0) <- COSH; ST(1) <-SINH
const c05: double = 0.5;
asm

  //EXP
  call R_EXP

  FLD     ST(0)
  FLD1
  FDIVR

  FLD     ST(0)
  FSUBR   ST(0),ST(2)
  FMUL    C05
  FXCH    ST(2)

  FADDP
  FMUL    C05

@@end:
end;

*)







 //  sh(z1)+th(z1)           //z1.re = 0 !!!
procedure Z_Z2M1_DIV_Z2P1;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//Z.RE-ST(0); Z.IM-ST(1);
{

IN:

  ST(0)   <-  RE(Z)
  ST(1)   <-  IM(Z)

Return:
         (Z^2-1)/(Z^2+1)
}
asm


  {
   expE2:Cxext=z^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)
  }

   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
   {
    ST(0) <- Re(exp(2*Z))
    ST(1) <- Im(exp(2*Z))
   }



   fld   st(0)
   fmul  st(0),st(0)
   fxch
   fadd  st(0),st(0)

   {
   fld1
   faddp
   }
   fadd  c1

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(3),st(0) //st3=2*a+1+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=2*a+1+b^2+a^2
   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1

   fxch  st(2)
   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b

   fmul  st(0),st(1)   //Im'    *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'    *DE





@@end:
end;





procedure Z_Z2P1_DIV_Z2M1;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//Z.RE-ST(0); Z.IM-ST(1);
{

IN:

  ST(0)   <-  RE(Z)
  ST(1)   <-  IM(Z)

Return:

    (Z^2+1)/(Z^2-1)
}
asm

 //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
   {
    ST(0) <- Re(exp(2*Z))
    ST(1) <- Im(exp(2*Z))
   }



  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a-1)^2+b^2); DE*((a^2-1+b^2)-i*2*b)
  }
    {.377}



   fld   st(0)
   fmul  st(0),st(0)
   //a^2,a,b
   fxch
   fadd  st(0),st(0)
   //2*a,a^2,b


   {
   fld1
   faddp
   }
   fsubr c1
   //1-2*a,a^2,b

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   //b^2,b,a^2,1-2*a
   fadd  st(3),st(0) //st3=1-2*a+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=1-2*a+b^2+a^2
   //

   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1
   //DE,b,a^2,b^2

   fxch  st(2)

   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b
   fchs

   fmul  st(0),st(1)   //Im'       *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'       *DE

   {
   // (Re',Im')*i
   fxch
   fchs
    }


@@end:
end;






procedure Z_EXPZ_Z2M1_DIV_Z2P1_SAVE;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
{
  IN:

    Z.RE-ST(0);
    Z.IM-ST(1);

    [esp+4]   addrRe
    [esp+8]   addrIm
    [esp+12]  TypeMem

  OUT:

    (Exp(Z)^2-1)/(Exp(Z)^2+1) ;

    ST(0)   <-  RE
    ST(1)   <-  IM

  Save In Mem:

    addrRe  <- RE(Exp(Z))
    addrIm  <- IM(Exp(Z))
}

asm


   mov  eax,[esp+4]       //addrRe for Exp(Z)
   mov  ebx,[esp+8]       //addrIm for Exp(Z)
   mov  ecx,[esp+12]      //TypeMem: _Extended, _Double

   //tanh(z1)+sinh(z1)

    //if Z.Re = 0
   fldz
   fcomip    st(0),st(1)
   jnz @@rtanh
   fxch    st(1)
   fsincos

   //SAVE EXP(Z):
   cmp   ecx,_Extended
   jnz   @@dbl_0I

   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp tbyte ptr [ebx]
   fdivrp    st(1),st(0)
   fxch  st(1)
   jmp @@end

 @@dbl_0I:
   fst qword ptr [eax]
   fxch
   fst qword ptr [ebx]
   fdivrp    st(1),st(0)
   fxch  st(1)
   jmp @@end
   //-------------------

@@rtanh:

    //if Z.Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@ztanhReIm
   {
   fxch   st(1)
   fchs
   }
   push   eax
   call   R_EXP
   pop    eax

   //SAVE EXP(Z):
   cmp   ecx,_Extended
   jnz   @@dbl_R0
   fld  st(0)
   fstp  tbyte ptr [eax]
   fldz
   fstp  tbyte ptr [ebx]
   jmp @@tanh_R0

 @@dbl_R0:
   fst  qword ptr [eax]
   fldz
   fstp qword ptr [ebx]
   //------------------

 @@tanh_R0:
   fmul   st(0),st(0)
   fld    st(0)
   fld1
   faddp
   fxch   st(1)
   fld1
   fsubp
   fdivrp st(1),st(0)
   {fchs
   fxch}
   jmp @@end


@@ztanhReIm:


  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)/i
  }
   {
   fxch
   fchs
   }
   push eax
   call R_EXP
   pop  eax
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch
   {
    ST(0) <- Re(exp(Z))
    ST(1) <- Im(exp(Z))
   }

    //SAVE EXP(Z):
   cmp   ecx,_Extended
   jnz   @@dbl_RI
   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp  tbyte ptr [ebx]
   fxch
   jmp @@tanh_RI

 @@dbl_RI:
   fst  qword ptr [eax]
   fxch
   fst  qword ptr [ebx]
   fxch
   //------------------

   

 @@tanh_RI:

   call Z_Z2M1_DIV_Z2P1

  (*
  {
   expE2:Cxext=z^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)
  }

   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
   {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }


   fld   st(0)
   fmul  st(0),st(0)
   fxch
   fadd  st(0),st(0)

   {
   fld1
   faddp
   }
   fadd  c1

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(3),st(0) //st3=2*a+1+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=2*a+1+b^2+a^2
   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1

   fxch  st(2)

   {fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b

   fmul  st(0),st(1)   //Im'    *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'    *DE


   // (Re',Im')/i
   {
   fchs
   fxch  st(1)
   }

  *)

@@end:
end;






procedure Z_EXPZ_Z2P1_DIV_Z2M1_SAVE;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
{
  IN:

    Z.RE-ST(0);
    Z.IM-ST(1);

    [esp+4]   addrRe
    [esp+8]   addrIm
    [esp+12]  TypeMem

  OUT:

    (Exp(Z)^2+1)/(Exp(Z)^2-1) ;

    ST(0)   <-  RE
    ST(1)   <-  IM

  Save In Mem:

    addrRe  <- RE(Exp(Z))
    addrIm  <- IM(Exp(Z))
}

asm


   mov  eax,[esp+4]       //addrRe for Exp(Z)
   mov  ebx,[esp+8]       //addrIm for Exp(Z)
   mov  ecx,[esp+12]      //TypeMem: _Extended, _Double

   //cotanh(z1)+sinh(z1)

    //if Z.Re = 0
   fldz
   fcomip    st(0),st(1)
   jnz @@rcotanh
   fxch    st(1)
   fsincos

   //SAVE EXP(Z):           // cos(Im)/sin(Im)*1/i -> -i*cth(Im)
   cmp   ecx,_Extended
   jnz   @@dbl_0I

   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp tbyte ptr [ebx]
   fdivp    st(1),st(0)
   fchs
   fxch  st(1)
   jmp @@end

 @@dbl_0I:
   fst qword ptr [eax]
   fxch
   fst qword ptr [ebx]
   fdivp    st(1),st(0)
   fchs
   fxch  st(1)
   jmp @@end
   //-------------------

@@rcotanh:


    //if Z.Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcotanhReIm
   {
   fxch   st(1)
   fchs
   }
   push   eax
   call   R_EXP
   pop    eax

   //SAVE EXP(Z):
   cmp   ecx,_Extended
   jnz   @@dbl_R0
   fld  st(0)
   fstp  tbyte ptr [eax]
   fldz
   fstp  tbyte ptr [ebx]
   jmp @@cotanh_R0

 @@dbl_R0:
   fst  qword ptr [eax]
   fldz
   fstp qword ptr [ebx]
   //------------------

 @@cotanh_R0:                    // (exp(z1.re)^2+1)/(exp(z1.re)^2-1)
   fmul   st(0),st(0)
   fld    st(0)
   fld1
   faddp
   fxch   st(1)
   fld1
   fsubp
   fdivp  st(1),st(0)
   jmp @@end


@@zcotanhReIm:


   push eax
   call R_EXP
   pop  eax
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch
   {
    ST(0) <- Re(exp(Z))
    ST(1) <- Im(exp(Z))
   }

    //SAVE EXP(Z):
   cmp   ecx,_Extended
   jnz   @@dbl_RI
   fld   st(0)
   fstp  tbyte ptr [eax]
   fxch
   fld   st(0)
   fstp  tbyte ptr [ebx]
   fxch
   jmp @@cotanh_RI

 @@dbl_RI:
   fst  qword ptr [eax]
   fxch
   fst  qword ptr [ebx]
   fxch
   //------------------



 @@cotanh_RI:

   call Z_Z2P1_DIV_Z2M1


@@end:
end;







procedure Z2_EXPZ_EXPNZ;
{
 IN:
   ST(0) <- Z.re
   ST(1) <- Z.im

 OUT:
   ST(0) <-  Re(exp(Z))
   ST(1) <-  Im(exp(Z))
   ST(2) <-  Re(exp(-Z))
   ST(3) <-  Im(exp(-Z))
}
asm

 //If RE = 0
   fldz
   fcomip    st(0),st(1)
   jnz @@zexp
   fstp st(0)
   fsincos
   fld   st(0)
   fxch  st(2)
   fld   st(0)
   fchs
   fxch  st(3)
   {
     ST(0)  <-   cos(Z.im)
     ST(1)  <-   sin(Z.im)
     ST(2)  <-   cos(Z.im)
     ST(3)  <-  -sin(Z.im)
   }
   jmp @@end



 //EXP:
   @@zexp:
   call R_EXP

  //if IM = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@expz
   fstp st(1)
   fld  st(0)
   fld1
   fdivr
   fldz
   fxch st(2)
   fldz
   fxch st(1)
   {
     ST(0)  <-   exp(Z.re)
     ST(1)  <-   0
     ST(2)  <-   exp(-Z.re)
     ST(3)  <-   0
   }
   jmp @@end


   @@expz:
   {
     ST(0)  <-   exp(Z.re)
     ST(1)  <-   Z.im
   }
   fld   st(0)

   fld1                     //FAST_RDIV 1/e
   fdivr


   fxch   st(2)
   fsincos
   fld    st(0)
   fmul   st(0),st(3)
   fxch   st(1)
   fmul   st(0),st(4)

   fxch   st(2)
   fmul   st(3),st(0)
   fchs
   fmulp  st(4),st(0)

   fxch   st(2)
   fxch   st(1)
   fxch   st(2)


   @@end:
end;




procedure Z_EXP;
//RE-ST(0); IM-ST(1);
var
M: Cardinal;
MX: Extended;
asm
  { push ax
   fldz
   fcomp
   fstsw ax
   sahf
   jnz @@zexp
   fstp st
   fsincos
   jmp @@endp}

   //If RE = 0
   fldz                        {.217}
   fcomip    st(0),st(1)
   jnz @@zexp
   fstp st(0)
   fsincos
   jmp @@end



 //EXP:
   @@zexp:
   call R_EXP    {.361}

   //if IM = 0
   fldz                        {.355}
   fcomip    st(0),st(2)
   jnz @@zexpcx
   jmp @@end

   @@zexpcx:
   fxch
   fsincos
   fmul  st,st(2)
   fxch
   fmulp st(2),st

@@end:
   //pop  ax
end;









procedure  Z_COS;
//RE-ST(0); IM-ST(1);
const c1: double=1.0;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
asm
   {.335}    //if IM = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcos
   fcos
   jmp @@end

@@zcos:


  //if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zcosReIm
   fxch st(1)
   call R_COSH
   //fxch st(1)
   jmp @@end

@@zcosReIm:


   fxch
   //EXP:
   call R_EXP    {.361}

   fld   st
   fld1                    //FAST_RDIV
   fdivrp
   //fdivr S_c1
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(2),st
   fchs
   fmulp st(2),st
@@end:
end;





procedure  Z_SIN;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
asm
   //if IM = 0
   fldz                        {.335}
   fcomip    st(0),st(2)
   jnz @@zsin
   fsin
   jmp @@end

@@zsin:
    //if RE = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zsinReIm
   fxch st(1)
   call R_SINH
   fxch st(1)
   jmp @@end

@@zsinReIm:

   fxch
   //EXP:
   call R_EXP    {.361}
   fld   st
   fld1              //FAST_RDIV
   fdivrp
   //fdivr S_c1
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(3),st
   fmulp

@@end:
end;


//(-2*sin(z1.re)*ch(z1.im)+2*i*cos(z1.re)*sh(z1.im))/(-2*(ch(z1.im)^2+sin(z1.re)^2-1))
procedure  Z_COSEC;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
const c2: double=2.0;
const c2n: double=-2.0;
const c1n: double=-1;
var
M: Cardinal;
MX: Extended;
asm
   {.335}    //if Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcosec
   fsin
   fld1
   fdivrp
   jmp @@end

@@zcosec:

//if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zcosecReIm
   fxch st(1)
   call R_COSECH
   fchs
   fxch st(1)
   jmp @@end


@@zcosecReIm:


   fxch
   //EXP:
   call R_EXP    {.361}

{.335}
   fld st(0)            //FAST_RDIV 1/e
   fdivr c1
   fld st(0)
   fadd st(0),st(2)
   fmul c05
   fxch st(2)
   fsubrp st(1),st(0)
   fmul c05
   fxch st(2)
   fsincos

   fmulp st(3),st(0)
   fld st(0)
   fmul st(0),st(2)
   fxch st(3)
   fmul c2
   fxch st(3)
   fmul c2n
   fxch st(2)
   fmul st(0),st(0)
   fxch st(1)
   fmul st(0),st(0)
   faddp st(1),st(0)
   fadd c1n
   fmul c2n
   fdivr c1                   //Fast_RDIV
   fmul  st(2),st(0)
   fmulp st(1),st(0)



{
   fld   st
   fld1              //FAST_RDIV
   fdivrp
   //fdivr S_c1
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(3),st
   fmulp
   //FAST_ZDIV (1/rez)
  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp

  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
  }
@@end:
end;



//(cos(z1.re)*(exp(z1.im)+1/exp(z1.im))+i*sin(z1.re)*(exp(z1.im)-1/exp(z1.im)))/(2*cos(z1.re)^2-1+(exp(z1.im)^2+(1/exp(z1.im))^2)*0.5)
procedure  Z_SEC;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
const c2: double=2.0;
const c1: double=1.0;
var
M: Cardinal;
MX: Extended;
asm
   {.335}    //if Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zsec
   fcos
   fld1
   fdivrp
   jmp @@end

@@zsec:

//if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zsecReIm
   fxch st(1)
   call R_SECH
   jmp @@end


@@zsecReIm:

   fxch
   //EXP:
   call R_EXP    {.361}

{.335}

   fld st(0)            //FAST_RDIV 1/e
   fdivr c1
   fld st(0)
   fadd st(0),st(2)
   fmul c05
   fxch st(2)
   fsubrp st(1),st(0)
   fmul c05
   fxch st(2)
   fsincos
   fxch st(3)
   fmulp st(1),st(0)
   fmul c2
   fxch st(2)
   fld st(0)
   fmul st(0),st(2)
   fmul c2
   fxch st(2)
   fmul st(0),st(0)
   fxch st(1)
   fmul st(0),st(0)
   faddp st(1),st(0)
   fsub c1
   fmul c2
   fdivr c1                  //FAST_RDIV
   fmul st(2),st(0)
   fmulp st(1),st(0)



{

   fld   st
   fld1                    //FAST_RDIV
   fdivrp
   //fdivr S_c1
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(2),st
   fchs
   fmulp st(2),st

  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp

  fld1              //FAST_RDIV
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
 }

 @@end:
end;



//(exp(2*z.im)*sin(2*z.re)+i*0.5*(exp(2*z.im)^2-1))/(exp(2*z.im)*cos(2*z.re)+0.5*(exp(2*z.im)^2+1))
procedure Z_TAN;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//RE-ST(0); IM-ST(1);
asm
   {.335}    //if Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@ztan
   fptan
   fstp st(0)
   jmp @@end

@@ztan:

    //if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@ztanReIm

   fxch   st(1)

   (*
   fmul   c2
   call   R_EXP
   fld    st(0)
   fmul   st(0),st(0)
   fld    st(0)
   fsub   c1
   fxch   st(1)
   fadd   c1
   fmul   c05
   faddp  st(2),st(0)
   fdivrp
   fmul   c05
   fxch   st(1)
   jmp @@end
   *)


   call   R_EXP
   fmul   st(0),st(0)
   fld    st(0)
   fld1
   faddp
   fxch   st(1)
   fld1
   fsubp
   fdivrp st(1),st(0)
   //fchs
   fxch
   jmp @@end


@@ztanReIm:

    {.361}

    //----------------------------
   fmul   c2
   fxch
   fmul   c2
   //EXP:
   call R_EXP

   fld    st
   fmul   st,st
   fmul   c05
   fld    st
   fsub   c05
   fxch
   fadd   c05
   fxch   st(3)
   fsincos
   fmul   st,st(3)
   faddp  st(4),st
   fxch   st(3)
   //fdivr  S_c1
   fld1                            //FAST_RDIV
   fdivrp
   fxch
   fmul   st,st(1)
   fxch   st(3)
   fmulp  st(2),st
   fmulp
   //---------------------------------------






  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)/i
  }
    {.377}
   (*
   //i*z
   fxch
   fchs

   push eax
   call R_EXP
   pop  eax
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch
   {
    ST(0) <- Re(exp(I*Z))
    ST(1) <- Im(exp(I*Z))
   }

   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
    {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }



   //----------------------------
   //a,b
   fld   st(0)
   fmul  st(0),st(0)
   //a^2,a,b
   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   //b^2,b,a,a^2
   fxch  st(3)
   fsub  c1
   //a^2-1,b,a,b^2
   fxch  st(1)
   fadd  st(0),st(0)
   //2*b,a^2-1,a,b^2
   fxch  st(1)
   fadd  st(0),st(3)
   //a^2+b^2-1,2*b,a,b^2
   fxch  st(2)
   fadd  c1
   fmul  st(0),st(0)
   //(a+1)^2,2*b,a^2+b^2-1,b^2
   faddp st(3),st(0)
   fld1
   fdivrp st(3),st(0)
   //2*b,a^2+b^2-1,DE
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)

   //  /i
   fchs
   fxch  st(1)
   //----------------------------



   //------------------------------
   fld   st(0)
   fmul  st(0),st(0)
   fxch
   fadd  st(0),st(0)

   {
   fld1
   faddp
   }
   fadd c1

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(3),st(0) //st3=2*a+1+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=2*a+1+b^2+a^2

   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1

   fxch  st(2)

   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b

   fmul  st(0),st(1)   //Im'       *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'       *DE
   // (Re',Im')/i
   fchs
   fxch  st(1)
   //------------------------------------------
    *)

@@end:
end;



//(-exp(2*z1.im)*sin(2*z1.re)+i*0.5*(exp(2*z1.im)^2-1))/(exp(2*z1.im)*cos(2*z1.re)-0.5*(exp(2*z1.im)^2+1))
procedure Z_COTAN;
const c2: double=2;
const c05: double=0.5;
const c05n: double=-0.5;
var
M: Cardinal;
MX: Extended;
//RE-ST(0); IM-ST(1);
asm
   {.335}    //if Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcotan

   fptan
   fdivrp

   {fsincos
   fdivrp}

   jmp @@end

@@zcotan:


    //if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zcotanReIm

   fxch   st(1)
   {
   fmul   c2
   call   R_EXP
   fld    st(0)
   fmul   st(0),st(0)
   fld    st(0)
   fsub   c1
   fxch   st(1)
   fadd   c1
   fmul   c05n
   faddp  st(2),st(0)

   fdivrp
   fmul   c05
   fxch   st(1)
   jmp @@end
   }

   call   R_EXP
   fmul   st(0),st(0)
   fld    st(0)
   fld1
   fsubp
   fxch   st(1)
   fld1
   faddp
   fdivrp st(1),st(0)
   fchs
   fxch
   jmp @@end


@@zcotanReIm:


   fmul   c2
   fxch
   fmul   c2
   //EXP:
   call R_EXP    {.361}

   //st()-e, st(1)-x; e=exp(2*z.im); x=2*z1.re
   {.335}
   fxch   st(1)
   fsincos
   fmul   st,st(2)
   fxch st(1)
   fmul   st,st(2)
   fchs
   fxch st(2)
   fmul   st(0),st(0)
   fld  st(0)
   fld1
   faddp st(1),st(0)
   fmul   c05
   fsubp st(2),st(0)
   fld1                   //FAST_RDIV
   fdivr st(2),st(0)
   fsubp st(1),st(0)
   fmul   c05
   fmul  st(0),st(1)
   fxch st(1)
   fmulp  st(2),st(0)
   fxch st(1)


  (*

  {
   expE2:Cxext=exp(i*z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a-1)^2+b^2); DE*((a^2-1+b^2)-i*2*b)*i
  }
    {.377}

   //i*z
   fxch
   fchs

   push eax
   call R_EXP
   pop  eax
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch

   {
    ST(0) <- Re(exp(I*Z))
    ST(1) <- Im(exp(I*Z))
   }

   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp

    {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }



   fld   st(0)
   fmul  st(0),st(0)
   //a^2,a,b
   fxch
   fadd  st(0),st(0)
   //2*a,a^2,b


   {
   fld1
   faddp
   }
   fsubr c1
   //1-2*a,a^2,b

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   //b^2,b,a^2,1-2*a
   fadd  st(3),st(0) //st3=1-2*a+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=1-2*a+b^2+a^2
   //

   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1
   //DE,b,a^2,b^2

   fxch  st(2)

   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b
   fchs

   fmul  st(0),st(1)   //Im'       *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'       *DE
   // (Re',Im')*i
   fxch
   fchs

      *)
@@end:
end;










procedure Z_SINH;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
asm
   {.335}    //if Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zsinh
   call R_SINH
   jmp @@end

@@zsinh:

    //if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zsinhReIm
   fxch st(1)
   fsin
   fxch st(1)
   jmp @@end

@@zsinhReIm:
  //EXP:
   call R_EXP    {.361}
 
   fld   st
   //fdivr S_c1
   fld1                   //FAST_RDIV
   fdivrp
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(3),st
   fmulp
   fxch

 @@end:
end;




procedure Z_COSECH;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
const c2: double=2.0;
const c2n: double=-2.0;
const c1: double=1.0;
var
M: Cardinal;
MX: Extended;
asm
   {.335}    //if Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcosech
   call R_COSECH
   jmp @@end

@@zcosech:

//if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zcosechReIm
   fxch st(1)
   fsin
   fld1
   fdivr
   fchs
   fxch st(1)
   jmp @@end

@@zcosechReIm:

  //EXP:
  call R_EXP    {.361}
 
  {.335}

   fld st(0)            //FAST_RDIV 1/e
   fdivr c1
   fld st(0)
   fadd st(0),st(2)
   fmul c05
   fxch st(2)
   fsubrp st(1),st(0)
   fmul c05
   fxch st(2)
   fsincos

   fxch st(2)
   fmulp st(1),st(0)

   //fmul c2
   fadd st(0),st(0)

   fxch st(1)
   fld st(0)
   fmul st(0),st(3)

   //fmul c2n
   fadd st(0),st(0)
   fchs

   fxch st(3)

   fmul st(0),st(0)
   fxch st(1)
   fmul st(0),st(0)
   fsubrp st(1),st(0)
   fsub c1

   //fmul c2
   fadd  st(0),st(0)

   fdivr c1                //FAST_RDIV
   fmul st(2),st(0)
   fmulp st(1),st(0)
   fxch st(1)



   {
   fld   st
   //fdivr S_c1
   fld1
   fdivrp
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(3),st
   fmulp
   fxch
    //FAST_ZDIV (1/rez)
  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp

  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
  }
@@end:
end;



procedure Z_COSH;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
asm
   {.335}    //if IM = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcosh
   call R_COSH
   jmp @@end

@@zcosh:

  //if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zcoshReIm
   fxch st(1)
   fcos
   //fxch st(1)
   jmp @@end

@@zcoshReIm:

 //EXP:
   call R_EXP    {.361}
 
   fld   st
   //fdivr S_c1
   fld1
   fdivrp                    //FAST_RDIV
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(2),st
   fmulp st(2),st
@@end:
end;


procedure Z_SECH;
//RE-ST(0); IM-ST(1);
const c05: double=0.5;
const c2: double=2.0;
const c2n: double=-2.0;
const c1: double=1.0;
var
M: Cardinal;
MX: Extended;
asm
   {.335}    //if Im = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zsech
   call R_SECH
   jmp @@end

@@zsech:

//if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zsechReIm
   fxch st(1)
   fcos
   fld1
   fdivr
   //fxch st(1)
   jmp @@end

@@zsechReIm:

 //EXP:
   call R_EXP    {.361}
 
{.335}
   fld st(0)            //FAST_RDIV 1/e
   fdivr c1
   fld st(0)
   fadd st(0),st(2)
   fmul c05
   fxch st(2)
   fsubrp st(1),st(0)
   fmul c05
   fxch st(2)
   fsincos
   fxch st(3)
   fmulp st(1),st(0)
   fmul c2n
   fxch st(2)
   fld st(0)
   fmul st(0),st(2)
   fmul c2
   fxch st(2)
   fmul st(0),st(0)
   fxch st(1)
   fmul st(0),st(0)
   faddp st(1),st(0)
   fsub c1
   fmul c2
   fdivr c1                  //FAST_RDIV
   fmul st(2),st(0)
   fmulp st(1),st(0)






{
   fld   st
   //fdivr S_c1
   fld1
   fdivrp
   fld   st
   fadd  st,st(2)
   fmul  c05
   fxch  st(2)
   fsubrp
   fmul  c05
   fxch  st(2)
   fsincos
   fmulp st(2),st
   fmulp st(2),st
     //FAST_ZDIV (1/rez)
  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp

  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
  }
@@end:
end;





procedure Z_TANH;
const c2: double=2;
const c1: double=1;
const c05: double=0.5;
var
M: Cardinal;
MX: Extended;
//RE-ST(0); IM-ST(1);
asm
   {.335}    //if IM = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@ztanh
   call R_TANH
   jmp @@end

@@ztanh:

    //if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@ztanhReIm
   fxch st(1)

   //fmul   c2
   fadd  st(0),st(0)
   fsincos
   //fadd  c1
   fld1
   faddp
   fdivp st(1),st(0)

   fxch st(1)
   jmp @@end

@@ztanhReIm:


   {.361}

   //fmul   c2
   fadd st(0),st(0)
   fxch
   //fmul   c2
   fadd st(0),st(0)
   fxch
   //EXP:
   call R_EXP


   fld    st
   fmul   st,st
   fmul   c05
   fld    st
   fsub   c05
   fxch
   fadd   c05
   fxch   st(3)
   fsincos
   fmul   st,st(3)
   faddp  st(4),st
   fxch   st(3)
   //fdivr  S_c1
   fld1                         //FAST_RDIV
   fdivrp
   fxch
   fmul   st,st(1)
   fxch   st(3)
   fmulp  st(2),st
   fmulp
   fxch




   {.377}
  {
   expE2:Cxext=exp(z1)^2; a:ext=Re(expE2); b:ext=Im(expE2);
   DE:ext=1/((a+1)^2+b^2); DE*((a^2-1+b^2)+i*2*b)
  }
   (*
   {fxch
   fchs}
   push eax
   call R_EXP
   pop  eax
   fxch
   fsincos
   fmul  st(0),st(2)
   fxch  st(2)
   fmulp st(1),st(0)
   fxch
   {
    ST(0) <- Re(exp(I*Z))
    ST(1) <- Im(exp(I*Z))
   }

   //ZSQR
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp
    {
    ST(0) <- Re(exp(2*I*Z))
    ST(1) <- Im(exp(2*I*Z))
   }

   fld   st(0)
   fmul  st(0),st(0)
   fxch
   fadd  st(0),st(0)

   {
   fld1
   faddp
   }
   fadd c1

   fxch  st(2)
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(3),st(0) //st3=2*a+1+b^2
   fxch  st(3)
   fadd  st(0),st(2) //st0=2*a+1+b^2+a^2

   {
   fld1
   fdivrp          //st0=DE        //FAST_RDIV
   }
   fdivr  c1

   fxch  st(2)

   {
   fld1
   fsubp  st(1),st(0)   //st0=a^2-1
   }
   fsub   c1

   faddp  st(3),st(0)    //st3=a^2+b^2-1
   fadd   st(0),st(0)  //st0=2*b

   fmul  st(0),st(1)   //Im'       *DE
   fxch  st(2)
   fmulp st(1),st(0)   //Re'       *DE
   // (Re',Im')
   {fchs
   fxch  st(1)}
   *)
@@end:
end;



//((1-exp(2*z1.re)^2)*0.5+i*sin(2*z1.im)*exp(2*z1.re))/(exp(2*z1.re)*cos(2*z1.im)-0.5*(exp(2*z1.re)^2+1))
procedure Z_COTANH;
const c2: double=2;
const c05: double=0.5;
const c1: double=1.0;
var
M: Cardinal;
MX: Extended;
//RE-ST(0); IM-ST(1);
asm
   {.335}    //if IM = 0
   fldz
   fcomip    st(0),st(2)
   jnz @@zcotanh
   call R_COTANH
   jmp @@end

@@zcotanh:

   //if Re = 0         {.377}
   fldz
   fcomip    st(0),st(1)
   jnz @@zcotanhReIm
   fxch st(1)

   {
   fsincos
   fdivrp st(1),st(0)
   fchs
   }

   //fmul   c2
   fadd st(0),st(0)
   fsincos
   fld1
   fsubp
   //fsub  c1
   fdivp st(1),st(0)

   {
   fptan
   fdivrp st(1),st(0)
   fchs
    }

   fxch st(1)
   jmp @@end

@@zcotanhReIm:


   //fmul   c2
   fadd st(0),st(0)
   fxch
   //fmul   c2
   fadd st(0),st(0)
   fxch

   //EXP:
   call R_EXP    {.361}

   //st()-e, st(1)-y; e=exp(2*z.re); y=2*z.im
   {.335}

   fxch st(1)
   fsincos
   fmul st(0),st(2)
   fxch st(1)
   fmul st(0),st(2)
   fxch st(2)
   fmul st(0),st(0)
   fld st(0)
   fld1
   fsubrp st(1),st(0)
   fmul   c05
   fxch st(1)
   fld1
   faddp  st(1),st(0)
   fmul   c05
   fsubp st(2),st(0)
   fld1
   fdivrp st(2),st(0)
   fmul st(0),st(1)
   fxch st(2)
   fmulp st(1),st(0)
   fxch st(1)

@@end:
end;





procedure Z_ARCSINH;
const c1: double=1.0;
const c2: double=2;
const c05: double=0.5;
//RE-ST(0); IM-ST(1);
asm

 //ZPUSHST
 fld   st
 fxch  st(2)
 fld   st
 fxch  st(3)

 //ZSQR
 fld   st
 fmul  st,st
 fxch
 fmul  st,st(2)
 fmul  c2
 fxch  st(2)
 fmul  st,st
 fsubp

 //fadd  S_c1
 fld1
 faddp

 //ZSQRT:
 push   ax
 call Z_SQRT          {.388}
 {
 fxch
 ftst
 fstsw  ax
 sahf
 fmul   st,st
 fxch
 fld    st
 fmul   st,st
 faddp st(2),st
 fxch
 fsqrt
 fld   st
 fsub  st,st(2)
 fmul  c05
 fsqrt
 jnb   @@1
 fchs
@@1:
 fxch  st(2)
 faddp
 fmul  c05
 fsqrt
 }
 pop   ax

 faddp st(2),st
 faddp st(2),st

 //ZLN:
 call Z_LN          {.388}
 {
 fld  st
 fxch st(2)
 fld  st
 fxch st(3)
 fpatan
 fxch st(2)
 fmul st,st
 fxch
 fmul st,st
 faddp
 fldln2
 fxch
 fyl2x
 fmul  c05
 }

end;





procedure Z_ARCCOSH;   {.357}
const c1: double=1.0;
const c2: double=2;
const c05: double=0.5;
//RE-ST(0); IM-ST(1);
// 2*ln(sqrt((z1 + 1)*0.5) + sqrt((z1 - 1)*0.5))
asm

 //ZPUSHST
 fld   st
 fxch  st(2)
 fld   st
 fxch  st(3)


 //(Z+1)*0.5
 fld1
 faddp
 fxch st(1)
 fmul c05
 fxch st(1)
 fmul c05



 //ZSQRT:
 push   ax
 call Z_SQRT          {.388}
 {
 fxch
 ftst
 fstsw  ax
 sahf
 fmul   st,st
 fxch
 fld    st
 fmul   st,st
 faddp st(2),st
 fxch
 fsqrt
 fld   st
 fsub  st,st(2)
 fmul  c05
 fsqrt
 jnb   @@1
 fchs
@@1:
 fxch  st(2)
 faddp
 fmul  c05
 fsqrt
 }
 pop   ax


 //ZXCH
 fxch st(2)
 fxch st(1)
 fxch st(3)
 fxch st(1)


 //(Z-1)*0.5
 fld1
 fsubp
 fxch st(1)
 fmul c05
 fxch st(1)
 fmul c05



 //ZSQRT:
 push   ax
 call Z_SQRT          {.388}
 {
 fxch
 ftst
 fstsw  ax
 sahf
 fmul   st,st
 fxch
 fld    st
 fmul   st,st
 faddp st(2),st
 fxch
 fsqrt
 fld   st
 fsub  st,st(2)
 fmul  c05
 fsqrt
 jnb   @@2
 fchs
@@2:
 fxch  st(2)
 faddp
 fmul  c05
 fsqrt
 }
 pop   ax


 faddp st(2),st
 faddp st(2),st

 //ZLN:
 call Z_LN          {.388}
 {
 fld  st
 fxch st(2)
 fld  st
 fxch st(3)
 fpatan
 fxch st(2)
 fmul st,st
 fxch
 fmul st,st
 faddp
 fldln2
 fxch
 fyl2x
 fmul  c05
 }

 fxch st(1)
 fmul  c2
 fxch st(1)
 fmul c2

end;





procedure Z_ARCCOSH_OLD;
const c2: double=2;
const c05: double=0.5;
//RE-ST(0); IM-ST(1);
//  use in form: arccosh=ln(z+sqrt(z^2-1)) - no always correct , best: "2*ln(sqrt((z1+1)*0.5)+sqrt((z1-1)*0.5))"
asm

 //ZPUSHST
 fld   st
 fxch  st(2)
 fld   st
 fxch  st(3)

 //ZSQR
 fld   st
 fmul  st,st
 fxch
 fmul  st,st(2)
 fmul  c2
 fxch  st(2)
 fmul  st,st
 fsubp

 //fsub  S_c1
 fld1
 fsubp

 //ZSQRT:
 push   ax
 fxch
 ftst
 fstsw  ax
 sahf
 fmul   st,st
 fxch
 fld    st
 fmul   st,st
 faddp st(2),st
 fxch
 fsqrt
 fld   st
 fsub  st,st(2)
 fmul  c05
 fsqrt
 jnb   @@1
 fchs
@@1:
 fxch  st(2)
 faddp
 fmul  c05
 fsqrt
 pop   ax

 faddp st(2),st
 faddp st(2),st

 //ZLN:
 fld  st
 fxch st(2)
 fld  st
 fxch st(3)
 fpatan
 fxch st(2)
 fmul st,st
 fxch
 fmul st,st
 faddp
 fldln2
 fxch
 fyl2x
 fmul  c05
end;




procedure Z_ARCTANH;
const c1: double=1.0;
const c2: double=2.0;
const c05: double=0.5;
const c025: double=0.25;
//RE-ST(0); IM-ST(1);
asm

  //fsubr  S_c1
  fld1
  fsubrp

  fld    st
  fsubr  c2
  fmul   st,st(1)
  fxch
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   c2
  fxch
  fmul   st,st
  fsub   st(2),st
  faddp  st(3),st
  fxch   st(2)
  //fdivr  S_c1
  fld1                    //FAST_RDIV
  fdivrp
  fmul   st(1),st
  fmulp  st(2),st

//ZLN*0.5
  call  Z_LN      {.388}

  fmul  c05
  fxch  st(1)
  fmul  c05
  fxch  st(1)


{
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fmul  c05
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c025
  }
end;




procedure Z_ARCCOTANH;
const c1: double=1.0;
const c2: double=2.0;
const c05: double=0.5;
const c025: double=0.25;
const cs2: double=-2.0;
//RE-ST(0); IM-ST(1);
asm

  //fsub   c1
  fld1
  fsubp

  fld    st
  fadd   c2
  fmul   st,st(1)
  fxch
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   cs2
  fxch
  fmul   st,st
  fadd   st(2),st
  faddp  st(3),st
  fxch   st(2)
  //fdivr  c1
  fld1                       //FAST_RDIV
  fdivrp
  fmul   st(1),st
  fmulp  st(2),st

//ZLN*0.5
  call Z_LN  {.388}

  fmul  c05
  fxch  st(1)
  fmul  c05
  fxch  st(1)

{
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fmul  c05
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c025
  }
end;







procedure Z_ARCTAN;
const c2: double=2;
const c05: double=0.5;
//RE-ST(0); IM-ST(1);
asm

  fxch
  //fadd   S_c1
  fld1
  faddp
  fld    st
  fsubr  c2
  fmul   st,st(1)
  fxch
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   c2
  fxch
  fmul   st,st
  fsub   st(2),st
  faddp  st(3),st
  fxch   st(2)
  //fdivr  S_c1
  fld1                         //FAST_RDIV
  fdivrp
  fmul   st(1),st
  fmulp  st(2),st

   //ZLN:
   call Z_LN
  {
   fld  st
   fxch st(2)
   fld  st
   fxch st(3)
   fpatan
   fxch st(2)
   fmul st,st
   fxch
   fmul st,st
   faddp
   fldln2
   fxch
   fyl2x
   fmul  c05
   }

   fmul  c05
   fchs
   fxch
   fmul  c05
end;



 {.377}
procedure Z_ARCTAN_FROM_ARCCOTAN;

//Same for ArcTan and ArcCotan ; Arctan<->ArcCotan
{
 ST(0)  Re(Z)
 ST(1)  Re(Arccotan(Z))
 ST(1)  Im(ArcCotan(Z))
}
{
 Z.Re > 0

        arctan(Z).Re=-arccotan(Z).Re+Pi/2
        arctan(Z).Im=-arccotan(Z).Im

 Z.Re < 0

        arctan(Z).Re=-arccotan(Z).Re-Pi/2
        arctan(Z).Im=-arccotan(Z).Im
}

const CPId2: extended  = 3.1415926535897932384626433832795/2;
asm

   fldz
   fcomip    st(0),st(1)
   fstp  st(0)
   ja   @@ztanNeg

   fchs
   fld   CPId2
   faddp st(1),st(0)
   fxch  st(1)
   fchs
   fxch  st(1)
   jmp  @@end

 @@ztanNeg:
   fchs
   fld   CPId2
   fsubp st(1),st(0)
   fxch  st(1)
   fchs
   fxch  st(1)

 @@end:

end;







procedure Z_ARCCOTAN;  {.357}
//RE-ST(0); IM-ST(1);
const c2: double=2;
const c05: double=0.5;
const CPId2: extended  = 3.1415926535897932384626433832795/2;
 // 0.5*i*ln((z-i)/(z+i))
asm


  // ZPUSH    z, z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)

  //z+i
  fxch st(1)
  fld1
  faddp
  fxch st(1)

  //ZXCH          z, z+i
  fxch st(2)
  fxch st(1)
  fxch st(3)
  fxch st(1)

  //z-i
  fxch st(1)
  fld1
  fsubp
  fxch st(1)


  // (z-i)/(z+i)

  test  F_FastDiv,1
  jnz   @@fastdiv
  call  ZDIV_ACC_ADDR
  jmp @@nxt

  @@fastdiv:
 //FAST_ZDIV
  fxch  st(2)
  fld   st
  fmul  st,st
  fxch  st(4)
  fld   st
  fmul  st,st
  faddp st(5),st
  fxch  st(4)
  fld1
  fdivr

  fxch  st(4)
  fld   st
  fmul  st,st(3)
  fxch
  fmul  st,st(4)
  fxch  st(3)
  fmul  st,st(2)
  fxch  st(4)
  fmulp st(2),st
  faddp
  fmul  st,st(3)
  fxch  st(2)
  fsubrp
  fmulp st(2),st

  @@nxt:

  // ZLN
  call  Z_LN  {.388}
  {
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c05
  }

  // *0.5
  fxch st(1)
  fmul  c05
  fxch st(1)
  fmul c05


  // *i
  fxch st(1)
  fchs

end;



procedure Z_ARCSIN;
//RE-ST(0); IM-ST(1);
const c2: double=2;
const c05: double=0.5;
asm


    //ZPUSHST:
   fld   st
   fxch  st(2)
   fld   st
   fxch  st(3)
   //ZSQR:
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp

   //fsubr S_c1
   fld1
   fsubrp
   fxch
   fchs

   //ZSQRT:

   {.388}
   push  ax
   fxch
   call Z_SQRT

  {
   ftst
   fstsw  ax
   sahf
   fmul   st,st
   fxch
   fld    st
   fmul   st,st
   faddp st(2),st
   fxch
   fsqrt
   fld   st
   fsub  st,st(2)
   fmul  c05
   fsqrt
   jnb   @@1
   fchs
  @@1:
   fxch  st(2)
   faddp
   fmul  c05
   fsqrt
   }

   pop   ax


   fsubrp st(3),st
   faddp
   fxch

   //ZLN:
   call  Z_LN {.388}
   {
   fld  st
   fxch st(2)
   fld  st
   fxch st(3)
   fpatan
   fxch st(2)
   fmul st,st
   fxch
   fmul st,st
   faddp
   fldln2
   fxch
   fyl2x
   fmul  c05
   }

   fchs
   fxch


end;





procedure Z_ARCCOS;
const c2: double=2;
const c05: double=0.5;
//RE-ST(0); IM-ST(1);
asm


   //ZPUSHST:
   fld   st
   fxch  st(2)
   fld   st
   fxch  st(3)
   //ZSQR:
   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp

   //fsubr S_c1
   fld1
   fsubrp
   fxch
   fchs

   //ZSQRT:
   {.388}
   push  ax
   fxch
   call  Z_SQRT
   {
   ftst
   fstsw  ax
   sahf
   fmul   st,st
   fxch
   fld    st
   fmul   st,st
   faddp st(2),st
   fxch
   fsqrt
   fld   st
   fsub  st,st(2)
   fmul  c05
   fsqrt
   jnb   @@1
   fchs
  @@1:
   fxch  st(2)
   faddp
   fmul  c05
   fsqrt
   }

   pop  ax

   faddp  st(3),st
   fsubp  st(1),st

   //ZLN:
   call   Z_LN     {.388}
 {  fld  st
   fxch st(2)
   fld  st
   fxch st(3)
   fpatan
   fxch st(2)
   fmul st,st
   fxch
   fmul st,st
   faddp
   fldln2
   fxch
   fyl2x
   fmul  c05  }

   fchs
   fxch

end;




procedure Z_ARCSEC;
const c2: double=2;
const c05: double=0.5;
const CPId2: extended  = 3.1415926535897932384626433832795/2;

//RE-ST(0); IM-ST(1);
asm
//arcsec=pi/2+i*ln(sqrt(1-(1/z)^2)+i/z)

  // 1/z
  {.335}
  test  F_FastDiv,1
  jnz   @@fastdiv
  fld1
  call  RZDIV_ACC_ADDR//Z_RZDIV_acc
  jmp @@nxt

  @@fastdiv:
  // FAST_ZDIV
  fld    st
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   st,st
  faddp  st(3),st
  fld1
  fdivrp st(3),st
  fmul   st,st(2)
  fchs
  fxch   st(2)
  fmulp  st(1),st

  {
  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp
  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
  }


  @@nxt:
   // ZPUSH    1/z, 1/z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)

  // ZSQR  1/z^2
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp


  // 1-1/z^2
  fchs
  fld1
  faddp
  fxch st(1)
  fchs
  fxch  st(1)

 // ZSQRT: sqrt(1-1/z^2)
  push   ax
  call  Z_SQRT {.388}
  {
  fxch
  ftst
  fstsw  ax
  sahf
  fmul   st,st
  fxch
  fld    st
  fmul   st,st
  faddp st(2),st
  fxch
  fsqrt
  fld   st
  fsub  st,st(2)
  fmul  c05
  fsqrt
  jnb   @@1
  fchs
 @@1:
  fxch  st(2)
  faddp
  fmul  c05
  fsqrt
  }

  pop   ax

 // sqrt+i/z
  fsubrp st(3),st(0)
  faddp
  fxch

  // LN
  call   Z_LN       {.388}
  {
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c05
  }

  // *i
  fxch
  fchs

  //+pi/2
  fld tbyte ptr [CPId2]
  faddp

end;




procedure Z_ARCCOSEC;
const c2: double=2;
const c05: double=0.5;
//const CPId2: extended  = 3.1415926535897932384626433832795/2;

//RE-ST(0); IM-ST(1);
asm
//arccosec=-i*ln(sqrt(1-(1/z)^2)+i/z)

   // 1/z

  {.335}
  test  F_FastDiv,1
  jnz   @@fastdiv
  fld1
  call  RZDIV_ACC_ADDR //Z_RZDIV_acc
  jmp @@nxt

  @@fastdiv:
  //  FAST_ZDIV
  fld    st
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   st,st
  faddp  st(3),st
  fld1
  fdivrp st(3),st
  fmul   st,st(2)
  fchs
  fxch   st(2)
  fmulp  st(1),st
  {
  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp
  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
  }

  @@nxt:
   // ZPUSH    1/z, 1/z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)

  // ZSQR  1/z^2
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp


  // 1-1/z^2
  fchs
  fld1
  faddp
  fxch st(1)
  fchs
  fxch  st(1)

 // ZSQRT: sqrt(1-1/z^2)
  push   ax
  call   Z_SQRT  {.388}
  {
  fxch
  ftst
  fstsw  ax
  sahf
  fmul   st,st
  fxch
  fld    st
  fmul   st,st
  faddp st(2),st
  fxch
  fsqrt
  fld   st
  fsub  st,st(2)
  fmul  c05
  fsqrt
  jnb   @@1
  fchs
 @@1:
  fxch  st(2)
  faddp
  fmul  c05
  fsqrt
  }

  pop   ax

 // zsqrt+i/z
  fsubrp st(3),st(0)
  faddp
  fxch

  // LN
  call   Z_LN
  {
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c05
  }

  // *(-i)
  fchs
  fxch

end;




procedure Z_ARCSECH_old;
const c1: double=1;
const c05: double=0.5;
const c2: double=2;
//const CPId2: extended  = 3.1415926535897932384626433832795/2;

//RE-ST(0); IM-ST(1);
//  use in form: arcsech=ln(1/z+sqrt((1/z)^2-1)) - no always correct , best: "ln(1/z+sqrt(1/z+1)*sqrt(1/z-1))"
asm

  // 1/z

  {.335}
  test  F_FastDiv,1
  jnz   @@fastdiv
  fld1
  call  RZDIV_ACC_ADDR  //Z_RZDIV_acc
  jmp @@nxt

  @@fastdiv:
  //  FAST_ZDIV
  fld    st
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   st,st
  faddp  st(3),st
  fld1
  fdivrp st(3),st
  fmul   st,st(2)
  fchs
  fxch   st(2)
  fmulp  st(1),st
  {
  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp
  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st
  }
  @@nxt:
   // ZPUSH    1/z, 1/z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)

  // ZSQR  1/z^2
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp

   // 1/z^2-1
  fsub qword ptr [c1]

   // SQRT: sqrt(1/z^2-1)
  push   ax
  fxch
  ftst
  fstsw  ax
  sahf
  fmul   st,st
  fxch
  fld    st
  fmul   st,st
  faddp st(2),st
  fxch
  fsqrt
  fld   st
  fsub  st,st(2)
  fmul  c05
  fsqrt
  jnb   @@1
  fchs
 @@1:
  fxch  st(2)
  faddp
  fmul  c05
  fsqrt
  pop   ax

  //sqrt+1/z
  faddp st(2),st(0)
  faddp st(2),st(0)

   // LN
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c05

end;





procedure Z_ARCSECH;    {.357}
const c1: double=1;
const c05: double=0.5;
const c2: double=2;
var Re1dZ,Im1dZ: extended;
//const CPId2: extended  = 3.1415926535897932384626433832795/2;

//RE-ST(0); IM-ST(1);
//  ln(1/z+sqrt(1/z+1)*sqrt(1/z-1))
asm

  // 1/z

  {.335}
  test  F_FastDiv,1
  jnz   @@fastdiv
  fld1
  call  RZDIV_ACC_ADDR  //Z_RZDIV_acc
  jmp @@nxt

  @@fastdiv:
  //  FAST_ZDIV
  fld    st
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   st,st
  faddp  st(3),st
  fld1
  fdivrp st(3),st
  fmul   st,st(2)
  fchs
  fxch   st(2)
  fmulp  st(1),st



  @@nxt:
   // ZPUSH    1/z, 1/z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)


   // ZPUSH    1/z, 1/z, 1/z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)

   {
  //1/z-> Re1dZ,Im1dZ     ; 1/z
  fstp tbyte ptr Re1dZ
  fstp tbyte ptr Im1dZ

  // ZPUSH    1/z, 1/z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)
  }


  //1/z+1
  fld1
  faddp


  // ZSQRT: sqrt(1/z+1)
  push   ax
  call   Z_SQRT  {.388}
  {
  fxch
  ftst
  fstsw  ax
  sahf
  fmul   st,st
  fxch
  fld    st
  fmul   st,st
  faddp st(2),st
  fxch
  fsqrt
  fld   st
  fsub  st,st(2)
  fmul  c05
  fsqrt
  jnb   @@1
  fchs
 @@1:
  fxch  st(2)
  faddp
  fmul  c05
  fsqrt
  }

  pop   ax


  //ZXCH          1/z, sqrt(1/z+1)
  fxch st(2)
  fxch st(1)
  fxch st(3)
  fxch st(1)


  //1/z-1
  fld1
  fsubp


  // ZSQRT: sqrt(1/z-1)
  push   ax
  call   Z_SQRT  {.388}
  {
  fxch
  ftst
  fstsw  ax
  sahf
  fmul   st,st
  fxch
  fld    st
  fmul   st,st
  faddp st(2),st
  fxch
  fsqrt
  fld   st
  fsub  st,st(2)
  fmul  c05
  fsqrt
  jnb   @@2
  fchs
 @@2:
  fxch  st(2)
  faddp
  fmul  c05
  fsqrt
  }

  pop   ax


  //ZMULP     sqrt(1/z-1)*sqrt(1/z+1)
  fld  st(0)
  fmul st(0),st(3)
  fxch st(1)
  fmul st(0),st(4)
  fxch st(4)
  fmul st(0),st(2)
  fsubp
  fxch st(2)
  fmulp
  faddp st(2),st(0)

  {
  // 1/z , sqrt(1/z-1)*sqrt(1/z+1)
  fld tbyte ptr Im1dZ
  fld tbyte ptr Re1dZ
  }

  // 1/z + sqrt(1/z-1)*sqrt(1/z+1)
  faddp st(2),st(0)
  faddp st(2),st(0)

   // ZLN
   call  Z_LN  {.388}
  {
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c05
  }
end;



procedure Z_ARCCOSECH;
const c1: double=1;
const c05: double=0.5;
const c2: double=2;
//const CPId2: extended  = 3.1415926535897932384626433832795/2;

//RE-ST(0); IM-ST(1);
//  arccosech=ln(1/z+sqrt((1/z)^2+1))
asm

   // 1/z
  {.335}
  test  F_FastDiv,1
  jnz   @@fastdiv
  fld1
  call  RZDIV_ACC_ADDR  //Z_RZDIV_acc
  jmp @@nxt

  @@fastdiv:
  //  FAST_ZDIV
  fld    st
  fmul   st,st
  fxch   st(2)
  fld    st
  fmul   st,st
  faddp  st(3),st
  fld1
  fdivrp st(3),st
  fmul   st,st(2)
  fchs
  fxch   st(2)
  fmulp  st(1),st
  {
  fld1
  fxch st(2)
  fld  st
  fmul st,st
  fxch
  fmul st,st(3)
  fchs
  fxch st(3)
  fmul st,st(2)
  fxch st(2)
  fmul st,st
  faddp
  fld1
  fdivrp
  fmul  st(1),st
  fmulp st(2),st }


  @@nxt:
   // ZPUSH    1/z, 1/z
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)

  // ZSQR  1/z^2
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp

   // 1/z^2+1
  fadd qword ptr [c1]

   // SQRT: sqrt(1/z^2-1)
  push   ax
  call   Z_SQRT   {.388}

  {
  fxch
  ftst
  fstsw  ax
  sahf
  fmul   st,st
  fxch
  fld    st
  fmul   st,st
  faddp st(2),st
  fxch
  fsqrt
  fld   st
  fsub  st,st(2)
  fmul  c05
  fsqrt
  jnb   @@1
  fchs
 @@1:
  fxch  st(2)
  faddp
  fmul  c05
  fsqrt
  }

  pop   ax

  //sqrt+1/z
  faddp st(2),st(0)
  faddp st(2),st(0)

   // ZLN
   call   Z_LN {.388}
   {
  fld  st
  fxch st(2)
  fld  st
  fxch st(3)
  fpatan
  fxch st(2)
  fmul st,st
  fxch
  fmul st,st
  faddp
  fldln2
  fxch
  fyl2x
  fmul  c05
  }

end;




procedure Z_CxCxLOG;
//log(z1,z2); z1.Re-ST,z1.Im-ST(1),z2.Re-ST(2),z2.Im-ST(3);
const c05: double=0.5;
const c025: double=0.25;
asm

  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch
  fpatan
  fxch
  //LN:
  fldln2
  fxch
  fyl2x

  fxch  st(3)
  fld   st
  fmul  st,st
  fxch  st(3)
  fld   st
  fmul  st,st
  faddp st(4),st
  fpatan
  fxch  st(2)
  //LN:
  fldln2
  fxch
  fyl2x

  fxch
  fld   st
  fmul  st,st
  fxch  st(4)
  fld   st
  fmul  st,st
  fmul  c025

  faddp st(5),st
  fxch  st(4)
  fld1                     //FAST_RDIV
  fdivrp
  //fdivr S_c1
  fxch  st(4)
  fld   st
  fmul  st,st(3)
  fxch
  fmul  st,st(4)
  fxch  st(4)
  fmul  st,st(2)
  fxch  st(3)
  fmulp st(2),st
  fmul  c025
  faddp st(2),st
  fsubp st(2),st
  fmul  st,st(2)
  fxch
  fmul  c05
  fmulp st(2),st

end;







procedure R_LogN; assembler;
//ST(0) <- Y
//ST(1) <- X
asm
        FXCH
        FLD1
        FXCH
        FYL2X
        FXCH
        FLD1
        FXCH
        FYL2X
        FDIV
end;


{.377}
procedure R_CR_LOG; assembler;
// LOG(ConstReal,RealArg) = Log2(RealArg)*Log(ConstReal,2)

//ST(0) <- Log(ConstReal,2)
//ST(1) <- RealArg
asm
    FXCH
    FLD1
    FXCH
    FYL2X
    FMULP
end;



{.377}
procedure R_CR2_LOG; assembler;
//  LOG(Real,ConstReal)=Lg2(ConstReal)/Lg2(Real)

//ST(0) <- Log2(ConstReal)
//ST(1) <- RealArg
asm
    FXCH
    FLD1
    FXCH
    FYL2X
    FDIVP
end;



{.395}
procedure Z_CZ2_LOG; assembler;
// LOG(RealArg,ConstComplex) = Log(ConstComplex,2)/Log2(RealArg)
//
// ST(0) <- RE(Log(ConstComplex,2))
// ST(1) <- IM(Log(ConstComplex,2))
// ST(2) <- RealArg
asm

    FXCH   ST(2)
    FLD1
    FXCH
    FYL2X

    // FAST_RDIV
    FLD1
    FDIVRP

    FMUL  ST(2),ST(0)
    FMULP
    FXCH
end;




{.395}
procedure Z_CR_LOG; assembler;
// LOG(ConstComplex,RealArg) = Log2(RealArg)*Log(ConstComplex,2)
//
// ST(0) <- RE(Log(ConstComplex,2))
// ST(1) <- IM(Log(ConstComplex,2))
// ST(2) <- RealArg
asm
    FXCH   ST(2)
    FLD1
    FXCH
    FYL2X
    FMUL  ST(2),ST(0)
    FMULP
    FXCH
end;








{.395}
procedure Z_CZ_CxLOG;
// LOG(ConstComplex,ComplexArg) = 1/ln(ConstComplex)  *  ( 0.5*ln(ComplexArg.re^2+ComplexArg.im^2)+i*arg(ComplexArg) )

// RE (1/ln(ConstComplex)) -> ST(0)
// IM (1/ln(ConstComplex)) -> ST(1)
// ComplexArg.RE   -> ST(2)
// ComplexArg.IM   -> ST(3);
const c05: double = 0.5;
asm



  fxch  st(2)
  fld   st(0)
  fmul  st(0),st(0)

  fxch  st(4)
  fld   st(0)
  fmul  st(0),st(0)

  faddp st(5),st(0)

  fxch st(1)
  fpatan

  fxch  st(3)

  //LN:
  fldln2
  fxch
  fyl2x
  fmul  c05

  fxch st(2)

  call Z_MUL



end;



{.395}
procedure Z_CZ2_CxLOG;
// LOG(ComplexArg,ConstComplex) =  (Const.re+i*Const.im)/ln(ComplexArg)

// Const.re = 0.5*ln(ConstComplex.re^2+ConstComplex.im^2) -> ST(0)
// Const.im = arg(ConstComplex)                           -> ST(1)
// ComplexArg.RE                                          -> ST(2)
// ComplexArg.IM                                          -> ST(3)
const c05: double = 0.5;
asm


  fxch  st(1)

  fxch  st(3)
  fxch  st(1)
  fxch  st(2)

  // ln(ComplexArg)
  call Z_LN

  // 1/ln
  fld1
  call Z_RZDIV_FAST         // FAST_RDIV

  call Z_MUL



end;









{.377}
procedure Z_CRe_CxLOG;
// LOG(ConstReal,ComplexArg) = 1/ln(ConstReal) * ( 0.5*ln(ComplexArg.re^2+ComplexArg.im^2)+i*arg(ComplexArg) )

// 1/ln(ConstReal) -> ST(0)
// ComplexArg.RE   -> ST(1)
// ComplexArg.IM   -> ST(2);
const c05: double = 0.5;
asm

  fxch  st(2)
  fld   st(0)
  fmul  st(0),st(0)
  fxch  st(2)
  fld   st(0)
  fmul  st(0),st(0)
  faddp st(3),st(0)
  fpatan
  fxch  st(1)
  //LN:
  fldln2
  fxch
  fyl2x
  fmul  c05

  fmul  st(0),st(2)
  fxch  st(1)
  fmulp st(2),st(0)

end;


{.377}
procedure Z_CRe2_CxLOG;
// LOG(ComplexArg,ConstReal) =
{
  Log(z1,c)
  Re=2*ln(c)*ln(z1.re^2+z1.im^2)/(ln(z1.re^2+z1.im^2)^2+4*arg(z1)^2)
  Im=-2*ln(c)*arg(z1)/(0.5*ln(z1.re^2+z1.im^2)^2+2*arg(z1)^2)
}

// 2*ln(ConstReal) -> ST(0)
// ComplexArg.RE   -> ST(1)
// ComplexArg.IM   -> ST(2);
const c05: double = 0.5;
const c2: double = 2;
const c4: double = 4;

asm

  fxch  st(2)
  fld   st(0)
  fmul  st(0),st(0)
  fxch  st(2)
  fld   st(0)
  fmul  st(0),st(0)
  faddp st(3),st(0)
  fpatan
  fxch  st(1)
  //LN:
  fldln2
  fxch
  fyl2x
  {
   ST(0): ln(x^2+y^2)
   ST(1): arg(z1)
   ST(2): 2*ln(a)
  }
  fld   st(0)
  fmul  st(0),st(0)
  fxch  st(2)
  fld   st(0)
  fmul  st(0),st(0)

  fld    c4
  fmul   st(0),st(1)
  fadd   st(0),st(4)
  fxch   st(3)
  fmul   st(0),st(5)
  fdivrp st(3),st(0)
  //RE - st(3)


  fadd   st(0),st(0)
  fxch   st(3)
  fmul   c05
  faddp  st(3),st(0)
  fmulp  st(3),st(0)
  fxch   st(2)
  fdivrp st(1),st(0)
  fchs
  fxch   st(1)


  {
   ST(0): arg^2
   ST(1): arg
   ST(2): RE
   ST(3): ln^2
   ST(4): const
  }


end;




procedure Z_ReCxLOG;
const c05: double=0.5;
const c025: double=0.25;
//log(r,z); Re-ST,z2.RE-ST(1),z2.IM-ST(2);
asm
  ftst
  fstsw  ax
  sahf
  jb     @@pi
  fldz
  jmp    @@1
@@pi:
  fldpi
@@1:
  fxch
  fmul  st,st
  //LN:
  fldln2
  fxch
  fyl2x

  fxch  st(3)
  fld   st
  fmul  st,st
  fxch  st(3)
  fld   st
  fmul  st,st
  faddp st(4),st
  fpatan
  fxch  st(2)
  //LN:
  fldln2
  fxch
  fyl2x

  fxch
  fld   st
  fmul  st,st
  fxch  st(4)
  fld   st
  fmul  st,st
  fmul  c025

  faddp st(5),st
  fxch  st(4)
  //fdivr S_c1
  fld1
  fdivrp
  fxch  st(4)
  fld   st
  fmul  st,st(3)
  fxch
  fmul  st,st(4)
  fxch  st(4)
  fmul  st,st(2)
  fxch  st(3)
  fmulp st(2),st
  fmul  c025
  faddp st(2),st
  fsubp st(2),st
  fmul  st,st(2)
  fxch
  fmul  c05
  fmulp st(2),st
end;






procedure Z_CxReLOG;
const c05: double=0.5;
const c025: double=0.25;
//log(z,r);
//z1.Re-ST(0); z1.Im-ST(1); r-ST(2);

asm
  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch
  fpatan
  fxch
  //LN:
  fldln2
  fxch
  fyl2x

  fxch  st(2)
  ftst
  fstsw  ax
  sahf
  jb     @@pi
  fldz
  jmp    @@1
@@pi:
  fldpi
@@1:
  fxch
  fmul  st,st
  //LN:
  fldln2
  fxch
  fyl2x

  fxch
  fxch  st(2)
  fld   st
  fmul  st,st
  fxch  st(4)
  fld   st
  fmul  st,st
  fmul  c025

  faddp st(5),st
  fxch  st(4)
  //fdivr S_c1
  fld1
  fdivrp
  fxch  st(4)
  fld   st
  fmul  st,st(3)
  fxch
  fmul  st,st(4)
  fxch  st(4)
  fmul  st,st(2)
  fxch  st(3)
  fmulp st(2),st
  fmul  c025
  faddp st(2),st
  fsubp st(2),st
  fmul  st,st(2)
  fxch
  fmul  c05
  fmulp st(2),st

end;


 //root(abs(z),k)*cossin(arg(z)/k)

procedure Z_CxIROOT; assembler;
//root(Z,N); Re-ST, Im-ST(1), N-EAX;
var
M: Cardinal;
asm
 mov   M,eax
 //ZPUSHST
 fld   st
 fxch  st(2)
 fld   st
 fxch  st(3)

 fpatan
 fild  M
 fdivp
 fxch  st(2)
 fmul  st,st
 fxch
 fmul  st,st
 faddp
 fsqrt

 //IROOT:
 call R_IROOT

  fxch
  fsincos
  fmul   st,st(2)
  fxch
  fmulp  st(2),st
end;





{.215}
procedure  R_IROOT; assembler;
//EAX - степень; ST(0) - основание;
var
M: Cardinal;
MX: Extended;
asm
     //push    bx

     xor     bx,bx    //знак числа '+'
     mov     M,eax  //сохранение
     fldz
     fcomp
     fnstsw  ax
     sahf
     mov     eax,M //восстановление
     ja      @@1  // число < 0
     jb      @@2  // число > 0
                  // число = 0:    root(0,P)
     fstp    ST(0)
     fldz

     // P = ??
     fild    M
     fcomp
     fnstsw  ax
     sahf
     ja      @@END    // P > 0

     // P <=0: call error
     fld1
     fchs
     fsqrt
     jmp     @@END

@@1:
     bt      eax,0
     jc      @@3      //если степень нечётная

     //xor     eax,eax    //вызвать ошибку если степень чётная
     //div     eax
     fsqrt     {.203}
@@3:
     or      bx,1b     //знак '-'
     fabs
@@2:

     fld1
     fild    dword ptr [M]
     fdivp
     fxch
     FYL2X
     FLD     ST(0)
     //FRNDINT
     FISTP M
     FILD  M
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD

     {
     FSCALE
     FSTP    ST(1)
     }

     //******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)
     (*
        //fpower >  Max2Power ??
        FXCH     ST(1)
        FILD     Max2Power
        FCOMIP   ST(0),ST(1)
        JNB      @@LowMaxF
        //cal error
        fld1
        fchs
        fsqrt
        JMP       @@end

@@LowMaxF:  //fpower < Max2PowerN ??
        FILD     Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB       @@pwr2f
        fstp     st(0)
        fstp     st(0)
        fldz
        JMP       @@end

@@pwr2f:
        FISTP   M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP   st(1),st(0)
        *)


        FXCH    st(1)
        FISTP   M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)


    //**********************

     bt      bx,0
     jnc     @@END
     fchs

@@END:
     //pop     bx

end;





procedure  R_FROOT; assembler;
//ST(1) - степень; ST(0) - основание;
var
M: Cardinal;
MX: Extended;
asm
     //push      eax

     FXCH
     FIST      M
     FICOM     M
     FNSTSW    AX
     SAHF;
     JNZ        @@F   //не целое

     FXCH
     FSTP     ST(1)
     MOV      EAX, M
     CALL     R_IROOT

     JMP      @@END



@@F:
       // X=0 ??
     FXCH

     FLDZ            {.}
     FCOMP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     JNZ    @@ROOT   //X<>0
                          //устраняет ошибки типа 0^P; P - дробная степень

     // X=0
     // P=0 ??
     //FXCH            {.215}
     //FLDZ            {.215}
     FCOMPP           {.}
     FSTSW   AX      {.}
     SAHF            {.}
     fldz            {.215}
     JB    @@END              //P>=0
                              //0^(-P)     P - дробная степень
                              //call error
     fstp st(0)               {.215}
     fld1
     fchs
     fsqrt
     JMP     @@END      {.}

@@ROOT:
     FXCH
     fld1
     fdivrp
     fxch
     FYL2X
     FLD     ST(0)
     //FRNDINT
     FISTP M
     FILD  M
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD
     {
     FSCALE
     FSTP    ST(1)
     }
     //******ISCALE********* {.219}    (instead FSCALE; FSTP ST(1) ; Agner Fog)
        //PUSH  EAX
        FXCH  st(1)
        FISTP M
        MOV   EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)
        //POP   EAX
    //**********************
@@END:
     //pop      eax
end;



 {.395}
procedure  R_CR_IROOT;    assembler;   // Root(RealConst,IntArg)
//EAX - степень-IntArg;
//ST(0) <- lg2(abs(RealConst))
//ST(1) <- RealConst


var
M: Cardinal;
MX: Extended;
asm
     //push    bx

     fxch    st(1)

     xor     bx,bx    //знак числа '+'
     mov     M,eax  //сохранение
     fldz
     fcomp
     fnstsw  ax
     sahf
     mov     eax,M //восстановление
     ja      @@1  // число < 0
     jb      @@2  // число > 0
                  // число = 0:    root(0,P)
     fstp    ST(0)
     fldz

     // P = ??
     fild    M
     fcomp
     fnstsw  ax
     sahf
     ja      @@END    // P > 0

     // P <=0: call error
     fld1
     fchs
     fsqrt
     jmp     @@END

@@1:
     bt      eax,0
     jc      @@3      //если степень нечётная

     //xor     eax,eax    //вызвать ошибку если степень чётная
     //div     eax
     fsqrt     {.203}
@@3:
     or      bx,1b     //знак '-'
     fabs
@@2:

     fstp st(0)

     fild    dword ptr [M]
     fdivp

     FLD     ST(0)
     //FRNDINT
     FISTP M
     FILD  M
     FSUB    ST(1), ST
     FXCH    ST(1)
     F2XM1
     FLD1
     FADD

     {
     FSCALE
     FSTP    ST(1)
     }

     //******ISCALE********* {.243}    (instead FSCALE; FSTP ST(1) ; Agner Fog)
     (*
        //fpower >  Max2Power ??
        FXCH     ST(1)
        FILD     Max2Power
        FCOMIP   ST(0),ST(1)
        JNB      @@LowMaxF
        //cal error
        fld1
        fchs
        fsqrt
        JMP       @@end

@@LowMaxF:  //fpower < Max2PowerN ??
        FILD     Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB       @@pwr2f
        fstp     st(0)
        fstp     st(0)
        fldz
        JMP       @@end

@@pwr2f:
        FISTP   M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP   st(1),st(0)
        *)


        FXCH    st(1)
        FISTP   M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)


    //**********************

     bt      bx,0
     jnc     @@END
     fchs

@@END:
     //pop     bx

end;




{
 root(abs(z),IntArg)*cossin(arg(z)/IntArg) ->
    iroot(abs(a+ib),IntArg)*cossin(arg(a+ib)/IntArg) ->
        r_cr_iroot(lg2(sqrt(a^2+b^2)),IntArg)*cossin(arg(a+ib)/IntArg)
}

procedure Z_CCx_IROOT; assembler;
//root(ComplexConst,IntArg);  ComplexConst = a+ib;
{
 IntArg -> EAX

 lg2(sqrt(a^2+b^2))   -> ST(0)
 sqrt(a^2+b^2)        -> ST(1)
 arctan2(b,a)         -> ST(2)

}
var
M: Cardinal;
asm

  mov     M,eax
  call    R_CR_IROOT

  fxch    st(1)

  fild    dword ptr [M]
  fdivp
  fsincos
  fmul   st,st(2)
  fxch
  fmulp  st(2),st

end;


procedure Z_CxIROOT3Int; assembler;
const C2PI: extended  = 3.1415926535897932384626433832795*2;
//root(Z,N,K);       //N-EAX,K-EBX
var
M,N,K: Cardinal;
asm
 {fld   tbyte ptr [eax+16]   //im
 fld   tbyte ptr [eax]      //re
 fld   tbyte ptr [eax+32]   //N
 fistp N
 fld   tbyte ptr [eax+48]   //K
 fistp K  }
 mov N, eax
 mov K, ebx

 //mov   M,eax
 //ZPUSHST
 fld   st
 fxch  st(2)
 fld   st
 fxch  st(3)

 fpatan
 fild  K
 fld tbyte ptr [C2PI]
 fmulp
 faddp
 fild  N
 fdivp
 fxch  st(2)
 fmul  st,st
 fxch
 fmul  st,st
 faddp
 fsqrt

 //IROOT:
 mov eax, N
 call R_IROOT        {.215}


  fxch
  fsincos
  fmul   st,st(2)
  fxch
  fmulp  st(2),st
end;



{
 root(abs(z),IntArg1)*cossin((arg(z)+2pi*IntArg2)/IntArg1) ->
    iroot(abs(a+ib),IntArg1)*cossin((arg(a+ib)+2pi*IntArg2)/IntArg1) ->
        r_cr_iroot(lg2(sqrt(a^2+b^2)),IntArg1)*cossin((arg(a+ib)+2pi*IntArg2)/IntArg1)
}
procedure Z_CCx_IROOT3Int; assembler;
//root(ComplexConst,IntArg1,IntArg2);  ComplexConst = a+ib;
{
 IntArg1 -> EAX
 IntArg2 -> EBX

 lg2(sqrt(a^2+b^2))   -> ST(0)
 sqrt(a^2+b^2)        -> ST(1)
 arctan2(b,a)         -> ST(2)

}
var
M,K: Cardinal;
asm

  mov     M,eax    // IntArg1
  mov     K,ebx    // IntArg2

  call    R_CR_IROOT

  fxch    st(1)
  fldpi
  fldpi
  faddp
  fimul  dword ptr [K]
  faddp
  fidiv  dword ptr [M]

  fsincos
  fmul   st,st(2)
  fxch
  fmulp  st(2),st

end;






procedure R_ARCSIN;
 asm
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUBR
  FSQRT
  FPATAN
end;



procedure R_ARCCOS;
 asm
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUBR
  FSQRT
  FXCH
  FPATAN
end;




procedure R_ARCCOTAN;
const E_CPId2: extended  = 3.1415926535897932384626433832795/2;
 asm
  FLD1
  FPATAN
  FLD  E_CPid2
  fsubrp
end;


 //arccotan(x)-arccotan_acc(x)

//arccotan(x)
procedure R_ARCCOTAN_1DIVARG;    {.375C}
  const E_CPId2: extended   = 3.1415926535897932384626433832795/2;
  const E_CPId2M: extended  = -3.1415926535897932384626433832795/2;
  const E_C3PId2: extended   = 3.1415926535897932384626433832795*3/2;
  const FZero:extended = 1E-20; //See arccotan_acc
 asm
  FLD      st(0)
  FLDZ
  FCOMIP   ST(0),ST(1)
  FSTP     st(0)
  JNB      @@Low
  FLD1
  FPATAN
  FLD  E_CPId2
  fsubrp
  jmp  @@End

 @@Low:
  FLD1
  FPATAN
  FLD  E_CPId2M
  fsubrp


 { FLD      st(0)
  FABS
  FLD      FZero
  FCOMIP   ST(0),ST(1)
  FSTP     st(0)
  JNB      @@Low
  FLD1
  FDIVRP
  FLD1
  FPATAN
  jmp  @@End


 @@Low:
  FLDZ
  FCOMIP   ST(0),ST(1)
  FSTP     st(0)
  JNBE       @@LowZ
  FLD      E_CPid2
  jmp  @@End
 @@LowZ:
  FLD      E_CPid2m
 }


 @@End:
end;




 {.377}
procedure R_ARCTAN_FROM_ARCCOTAN;

//Same for ArcTan and ArcCotan ; Arctan<->ArcCotan
{
 ST(0)  X
 ST(1)  Arccotan(X)
}
{
 X > 0

        arctan(X)=-arccotan(X)+Pi/2

 X < 0

        arctan(X)=-arccotan(X)-Pi/2

}

const CPId2: extended  = 3.1415926535897932384626433832795/2;
asm

   fldz
   fcomip    st(0),st(1)
   fstp  st(0)
   ja   @@ztanNeg

   fchs
   fld   CPId2
   faddp st(1),st(0)
   jmp  @@end

 @@ztanNeg:
   fchs
   fld   CPId2
   fsubp st(1),st(0)
  
 @@end:

end;




procedure R_SINH; assembler;
var
MX: Extended;
M:  Cardinal;
asm
 //EXP
  call R_EXP    {.361}

  FLD   ST(0)
  FLD1
  FDIVR
  FSUB
  FMUL   C05

@@end:
end;



procedure R_COSH; assembler;
var
M: Cardinal;
MX: Extended;
asm

  //EXP
  call R_EXP    {.361}


  FLD     ST(0)
  FLD1
  FDIVR
  FADD
  FMUL  C05
@@end:
end;






procedure R_TANH; assembler;
asm
  FIMUL   C2

  //EXP
  call R_EXP    {.361}
 

  FLD     ST(0)
  FLD1
  FSUB
  FLD1
  FADD    ST,ST(2)
  FDIV
  FSTP    ST(1)
@@end:
end;




procedure R_COTANH; assembler;
var
M: Cardinal;
MX: Extended;
asm
  FIMUL   C2

  //EXP
  call R_EXP    {.361}
 

  FLD     ST(0)
  FLD1
  FSUB
  FLD1
  FADD    ST,ST(2)
  FDIVR
  FSTP    ST(1)
@@end:
end;




procedure R_ARCSINH;
asm
  FLD   ST
  FMUL  ST,ST
  FLD1
  FADD
  FSQRT
  FXCH
  FADD
  FLDLN2
  FXCH  ST(1)
  FYL2X
end;



procedure R_ARCCOSH;
asm
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUB
  FSQRT
  FXCH
  FADD
  FLDLN2
  FXCH  ST(1)
  FYL2X
end;



procedure R_ARCTANH;
const c05: double=0.5;
asm
  FLD  ST
  FLD1
  FADD
  FXCH
  FLD1
  FSUBR
  FDIV
  FLDLN2
  FXCH  ST(1)
  FYL2X
  FMUL  C05
end;



procedure R_ARCCOTANH;
const c05: double=0.5;
asm
  FLD  ST
  FLD1
  FADD
  FXCH
  FLD1
  FSUB
  FDIV
  FLDLN2
  FXCH  ST(1)
  FYL2X
  FMUL  C05
end;




procedure R_ARCSEC; assembler;
const c1: double=1;
asm      //arccos(1/x)
  FDIVR C1
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUBR
  FSQRT
  FXCH
  FPATAN
end;


procedure R_ARCCOSEC; assembler;
const c1: double=1;
asm            //arcsin(1/x)
  FDIVR C1
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUBR
  FSQRT
  FPATAN
end;



procedure R_SECH; assembler;
var
M: Cardinal;
MX: Extended;
asm

  //EXP
  call R_EXP    {.361}


  FLD     ST(0)
  FLD1
  FDIVR
  FADD
  FMUL  C05
  FDIVR C1
@@end:
end;




procedure R_COSECH; assembler;
var
M: Cardinal;
MX: Extended;
asm

  //EXP
  call R_EXP    {.361}

  FLD   ST(0)
  FLD1
  FDIVR
  FSUB
  FMUL   C05
  FDIVR  C1
@@end:
end;



procedure R_ARCSECH; assembler;
const c1: double=1;
asm
  FDIVR C1
  FLD   ST
  FMUL  ST,ST
  FLD1
  FSUB
  FSQRT
  FXCH
  FADD
  FLDLN2
  FXCH  ST(1)
  FYL2X
end;



procedure R_ARCCOSECH; assembler;
const c1: double=1;
asm
  push  ecx
  push  eax
  xor   ecx,ecx

  fldz
  fcomp
  fstsw   ax
  sahf
  jb      @@bz
  mov ecx,1

@@bz:
  fabs

  FDIVR C1
  FLD   ST
  FMUL  ST,ST
  FLD1
  FADD
  FSQRT
  FXCH
  FADD
  FLDLN2
  FXCH  ST(1)
  FYL2X

  cmp     ecx, 0
  je     @@end
  fchs
  @@end:

  pop  eax
  pop  ecx
end;



procedure R_EXP; assembler;
var
M: Cardinal;
MX: Extended;
asm
        FLDL2E
        FMUL
        FLD     ST(0)
        //FRNDINT
        FISTP M
        FILD  M
        FSUB    ST(1), ST
        FXCH    ST(1)
        F2XM1
        FLD1
        FADD
       {
        FSCALE
        FSTP ST(1)
       }
        //******ISCALE********* {.219}    (instead FSCALE; FSTP ST(1) ; Agner Fog)
        {PUSH  EAX
        FXCH  st(1)
        FISTP M
        MOV   EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP st(1),st(0)
        POP   EAX    }

        //fpower >  Max2Power ??
        FXCH     ST(1)
        FILD     Max2Power
        FCOMIP   ST(0),ST(1)
        JNB      @@LowMaxF
         //call Overflow Error:
        fstp st(0)
        fstp st(0)
        fild Power2Overflow
        fld1
        fscale  //Float Overflow
        fstp   st(1)       {.375}
        JMP      @@end

@@LowMaxF:  //fpower < Max2PowerN ??
        FILD     Max2PowerN
        FCOMIP   ST(0),ST(1)
        JB       @@pwr2f
        fstp     st(0)
        fstp     st(0)
        fldz
        JMP      @@end

@@pwr2f:
        //PUSH    EAX
        FISTP   M
        MOV     EAX,M
        ADD     EAX, 00003FFFH
        MOV     DWORD PTR [MX],   0
        MOV     DWORD PTR [MX+4], 80000000H
        MOV     DWORD PTR [MX+8], EAX
        FLD     TBYTE PTR [MX]
        FMULP   st(1),st(0)
        //POP     EAX
    //**********************
@@end:
end;





procedure Z_IPWR3; assembler;
//z1^3; z1.RE-ST,z1.IM-ST(1);
const c3: double=3;
asm
  fld   st
  fmul  st,st
  fmul  st,st(1)
  fxch  st(2)
  fld   st
  fmul  st,st
  fmul  st,st(1)
  fxch
  fld   st
  fmul  st,st(3)
  fmul  c3
  fxch
  fmul  st,st(1)
  fsubp st(4),st
  fmulp st(2),st
  fsubp
  fxch
end;




procedure Z_IPWR4; assembler;
//z1^4; z1.RE-ST,z1.IM-ST(1);
//либо: ZSQR+ZSQR;
const c4: double=4;
const c6: double=6;
asm
  fld   st
  fmul  st,st(2)
  fxch
  fmul  st,st
  fxch  st(2)
  fmul  st,st
  fxch  st(2)
  fld   st
  fsub  st,st(3)
  fxch  st(3)
  fmul  st,st
  fxch
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  c4
  fmulp st(4),st
  fmul  st,st
  fxch
  faddp st(2),st
  fmul  c6
  fsubp
end;




procedure Z_IPWRN1; assembler;
//z1^(-1); z1.RE-ST,z1.IM-ST(1);
asm
  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch  st(2)
  fld1
  fdivrp
  fmul  st(1),st
  fchs
  fmulp st(2),st
end;


   (*
procedure Z_IPWRN2; assembler;
//z1^(-2); z1.RE-ST,z1.IM-ST(1);
const c2: double=2;
asm
    //ZSQR
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp

  //1/Z
  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch  st(2)
  fld1
  fdivrp
  fmul  st(1),st
  fchs
  fmulp st(2),st

end;



procedure Z_IPWRN3; assembler;
//z1^(-2); z1.RE-ST,z1.IM-ST(1);
const c3: double=3;
asm
  // Z^3
  fld   st
  fmul  st,st
  fmul  st,st(1)
  fxch  st(2)
  fld   st
  fmul  st,st
  fmul  st,st(1)
  fxch
  fld   st
  fmul  st,st(3)
  fmul  c3
  fxch
  fmul  st,st(1)
  fsubp st(4),st
  fmulp st(2),st
  fsubp
  fxch
  //1/Z
  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch  st(2)
  fld1
  fdivrp
  fmul  st(1),st
  fchs
  fmulp st(2),st

end;




procedure Z_IPWRN4; assembler;
//z1^(-2); z1.RE-ST,z1.IM-ST(1);
const c2: double=2;
asm
  // Z^4
  //ZSQR
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp
  //ZSQR
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp

  //1/Z
  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch  st(2)
  fld1
  fdivrp
  fmul  st(1),st
  fchs
  fmulp st(2),st


end;





procedure Z_IPWRN5; assembler;
//Z^(-5); z1.RE-ST,z1.IM-ST(1);
const c2: double=2;
asm
  //Z^5
  //ZPUSHST
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)
  //ZSQR
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp
  //ZSQR
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp
  //ZMULP
  fld  st(0)
  fmul st(0),st(3)
  fxch st(1)
  fmul st(0),st(4)
  fxch st(4)
  fmul st(0),st(2)
  fsubp
  fxch st(2)
  fmulp
  faddp st(2),st(0)

  //1/Z
  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch  st(2)
  fld1
  fdivrp
  fmul  st(1),st
  fchs
  fmulp st(2),st

end;




procedure Z_IPWRN6; assembler;
//Z^(-6); z1.RE-ST,z1.IM-ST(1);
const c2: double=2;
asm
  //Z^6
  //ZSQR
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp
   //ZPUSHST
  fld   st
  fxch  st(2)
  fld   st
  fxch  st(3)
  //ZSQR
  fld   st
  fmul  st,st
  fxch
  fmul  st,st(2)
  fmul  c2
  fxch  st(2)
  fmul  st,st
  fsubp
  //ZMULP
  fld  st(0)
  fmul st(0),st(3)
  fxch st(1)
  fmul st(0),st(4)
  fxch st(4)
  fmul st(0),st(2)
  fsubp
  fxch st(2)
  fmulp
  faddp st(2),st(0)

  //1/Z
  fld   st
  fmul  st,st
  fxch  st(2)
  fld   st
  fmul  st,st
  faddp st(3),st
  fxch  st(2)
  fld1
  fdivrp
  fmul  st(1),st
  fchs
  fmulp st(2),st

end;
 *)


procedure R_IPWR;assembler;
const c1: double=1;
asm


        FLD1
        FXCH


        mov     ecx, eax
        cdq
        xor     eax, edx
        sub     eax, edx
        jnz     @@2
        fstp    ST(0)
        jmp     @@3
   @@1: fmul    ST, ST
   @@2: shr     eax,1
        jnc     @@1
        fmul    ST(1),ST
        jnz     @@1
        fstp    st
        cmp     ecx, 0
        jge     @@3
        fdivr   c1

   @@3:
end;



procedure R_IPWRB;assembler;
asm       //st(0)^EAX;

        PUSH     EAX
        //PUSH     EBX
        PUSH     ECX
        PUSH     EDX

        FLD1
        FXCH


        mov     ecx, eax
        cdq
        xor     eax, edx
        sub     eax, edx
        jnz     @@2
        fstp    ST(0)
        jmp     @@3
   @@1: fmul    ST, ST
   @@2: shr     eax,1
        jnc     @@1
        fmul    ST(1),ST
        jnz     @@1
        fstp    st
        cmp     ecx, 0
        jge     @@3
        fdivr   c1

   @@3:
        POP     EDX
        POP     ECX
        //POP     EBX
        POP     EAX
end;




procedure R_IPWRSGN; assembler;       {.395}
var
 M: Cardinal;
asm
        FLD   st(0)
        FISTP M
        FILD  M
        FCOMIP  ST(0),ST(1)
        JZ        @@IntA

        // вызвать ошибку, если степень нецелая
        fstp st(0)
        fld1
        fchs
        fsqrt
        jmp   @end

  @@IntA:

        fstp st(0)
        mov  eax,M
        fld1
        and  eax,1
        jz   @end
        fchs
@end:
end;




(*
procedure Z_IPWRSGN; assembler;      {.361}
asm
   fxch  st(1)
   fldpi
   fmulp
   fchs

   //EXP
   call  R_EXP

   fxch  st(1)
   fldpi
   fmulp
   fsincos
   fmul   st,st(2)
   fxch   st(2)
   fmulp
   fxch   st(1)
end;
*)


//(-1)^z1=exp(-pi*z1.im)*(cossin(pi*z1.re))
procedure Z_IPWRSGN; assembler;      {.189}      {.361}
var
M: Cardinal;
MX: Extended;
asm
{  ftst
 fstsw  ax
 sahf}
 //push ax


 fxch
 fldpi
 fmulp
 fchs

 call R_EXP



 fxch
 //fld st(0)

 call  Z_UNeg_ReFPWR
 fmul  st(0),st(2)
 fxch  st(1)
 fmulp st(2),st(0)



 {

 FISTP M
 FILD  M
 FCOMIP  ST(0),ST(1)
 JZ        @@int


 fldpi
 fmulp
 fsincos
 fmul   st,st(2)
 fxch
 fmulp  st(2),st
 jmp @@end


@@int:
 fldpi
 fmulp
 fcos
 fmulp
 fldz
 fxch
 }

@@end:
  //pop ax
end;





procedure Z_ImU_CxFPWR;      assembler;
// (i)^Z=exp(-pi*z.im*0.5)*cossin(pi*z.re*0.5)
{
 Z.re -> ST(0)
 Z.im -> ST(1)
}
const c05: double=0.5;



asm
   fxch  st(1)
   fmul  c05
   fldpi
   fmulp
   fchs


   call  R_EXP
   fxch  st(1)
   call  Z_ImU_ReFPWR

   {
   fxch  st(1)
   fmul  c05
   fldpi
   fmulp
   fsincos
   }
   fmul   st,st(2)
   fxch   st(2)
   fmulp
   fxch   st(1)

end;





procedure Z_ImUNeg_CxFPWR;    assembler;
// (-i)^Z=exp(pi*z.im*0.5)*(cos(pi*z.re*0.5)-i*sin(pi*z.re*0.5))
{
 Z.re -> ST(0)
 Z.im -> ST(1)
}
const c05: double=0.5;

asm
   fxch  st(1)
   fmul  c05
   fldpi
   fmulp



   call  R_EXP
   fxch  st(1)
   call  Z_ImUNeg_ReFPWR


   fmul   st,st(2)
   fxch   st(2)
   fmulp
   fxch   st(1)

end;






procedure Z_ImU_ReFPWR;  assembler;

// (i)^Re=cossin(pi*re*0.5)
{
 re -> ST(0)
}
const c05: double=0.5;
const c2: double=2.0;
var
M,M1: Cardinal;

asm
{
   fldpi
   fmulp
   fsincos
  }

 FLD   st(0)
 FISTP M
 FILD  M
 FCOMIP  ST(0),ST(1)
 JZ        @@IntA


@@Cx:
 fmul  c05
 fldpi
 fmulp
 fsincos
 jmp @@end


@@IntA:

 mov   eax,M
 and   M,1
 jz    @@Re


@@Im:
 {
 fldpi
 fmulp
 fcos
 fldz
 fxch    }


 fstp  st(0)
 fld1
 and  eax,3
 fldz
 jnp   @@end
 fstp  st(0)
 fchs
 fldz
 jmp @@end



@@Re:
 {fldpi
 fmulp
 fsin
 fldz
 }

 fstp  st(0)
 fldz
 fld1
 and   eax,3
 jp    @@end
 fchs



@@end:
end;






procedure Z_ImUNeg_ReFPWR;   assembler;
// (-i)^Re=(cos(pi*re*0.5)-i*sin(pi*re*0.5))
{
 re -> ST(0)
}
const c05: double=0.5;
const c2: double=2.0;
var
M,M1: Cardinal;
asm
{
   fldpi
   fmulp
   fsincos
  }

 FLD   st(0)
 FISTP M
 FILD  M
 FCOMIP  ST(0),ST(1)
 JZ        @@IntA


@@Cx:
 fmul  c05
 fldpi
 fmulp
 fsincos
 jmp @@end


@@IntA:

 mov   eax,M
 and   M,1
 jz    @@Re


@@Im:
 {
 fldpi
 fmulp
 fcos
 fldz
 fxch    }


 fstp  st(0)
 fld1
 and  eax,3
 fldz
 jnp   @@end
 fstp  st(0)
 fchs
 fldz
 jmp @@end



@@Re:
 {fldpi
 fmulp
 fsin
 fldz
 }

 fstp  st(0)
 fldz
 fld1
 and   eax,3
 jp    @@end
 fchs



@@end:
 fxch
 fchs
 fxch
end;








procedure Z_UNeg_ReFPWR;   assembler;
//(-1+0i)^Re=cossin(pi*Re)
{
 re -> ST(0)
}
const c2: double=2.0;
var
M: Cardinal;
asm
{
   fldpi
   fmulp
   fsincos
  }

 FLD   st(0)
 FISTP M
 FILD  M
 FCOMIP  ST(0),ST(1)
 JZ        @@Re

 fld   st(0)
 fmul  c2
 fld   st(0)
 FISTP M
 FILD  M
 FCOMIP  ST(0),ST(1)
 JZ      @@Im


@@Cx:
 fstp  st(0)
 fldpi
 fmulp
 fsincos
 jmp @@end


@@Re:
 {
 fldpi
 fmulp
 fcos
 fldz
 fxch    }
 fstp  st(0)
 fldz
 fld1
 and  M,1
 jz   @@end
 fchs
 jmp @@end



@@Im:
 {fldpi
 fmulp
 fsin
 fldz
 }

 fstp  st(0)
 fstp  st(0)
 fld1
 //mov   eax, M
 //and   eax, 3
 and   M,3
 fldz
 jnp   @@end
 fstp  st(0)
 fchs
 fldz

 //jmp @@end

@@end:
end;










procedure R_Decart;    assembler;
//R->ST(0); PHI->ST(1): Re->ST(0); Im->ST(1)
asm
  fxch
  fsincos
  fmul st(0),st(2)
  fxch st(2)
  fmulp
  fxch
end;






//************************************************ ARRAYS (begin) **************************************************************************************






procedure RVD_MAX; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx

  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)
  fldz


  mov   ecx,[eax-4]     //ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect

  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  cmp   ecx,0
  jnz   @@cycl4

  movlpd  xmm0, qword ptr[eax]
  add   eax,8
  dec   bx
  jmp   @@cycl1

  @@cycl4:
  movupd xmm4,  oword ptr[eax]    // xmm4 - аккумулятор; для инициализации аккумулятора

  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]


     add    eax,64

     maxpd   xmm0,xmm1
     maxpd   xmm2,xmm3
     maxpd   xmm0,xmm2

     maxpd   xmm4,xmm0



     //add    eax,64
     dec    ecx

  jnz   @@cyclx4

  movhlps xmm0,xmm4
  maxsd   xmm0,xmm4


  @@cycl1:

   fstp st(0)
   mov   cx,bx
   jcxz @@end



  @@cyclx1:

      maxsd   xmm0, qword ptr [eax]
      add   eax,8
      dec    cx

  jnz   @@cyclx1





@@end:

  sub     esp,8
  movlpd  qword ptr [esp], xmm0
  fld     qword ptr [esp]
  add     esp,8


@@endp:

  pop   bx
  pop   ecx
  pop  eax


end;





procedure RVE_MAX; assembler;
//in:
//EAX <- @Array[0]

//DeepFPU = 8
asm
     push   eax
     push  ecx
     push  bx


     //mov   eax, [eax]
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     fstp st(0)
     mov   ecx,[eax-4]       //  ECX - Length of array
     {.357}
     add ecx,c_DinArrayLenCorrect

     //jecxz @@end
     test ecx, ecx
     jz @@end




     fld   tbyte ptr [eax]
     //add   eax,10

     mov   bx,cx
     shr   ecx,3
     and   bx,7

     jecxz  @@cycl1

     //fstp st(0)

   {  test ecx,ecx
     jz @@cycl1   }




 @@cycl8:

      fld   tbyte ptr [eax]
      fld   tbyte ptr [eax+10]
      fld   tbyte ptr [eax+20]
      fld   tbyte ptr [eax+30]
      fld   tbyte ptr [eax+40]
      fld   tbyte ptr [eax+50]
      fld   tbyte ptr [eax+60]

     {
      fld   tbyte ptr [eax+70]
      add   eax,80
     }

      fcomi st(0),st(1)
      jb    @@next1
      fxch  st(1)
    @@next1:
      fstp  st(0)
       fcomi st(0),st(1)
      jb    @@next2
      fxch  st(1)
    @@next2:
      fstp  st(0)
       fcomi st(0),st(1)
      jb    @@next3
      fxch  st(1)
    @@next3:
      fstp  st(0)
       fcomi st(0),st(1)
      jb    @@next4
      fxch  st(1)
    @@next4:
      fstp  st(0)
       fcomi st(0),st(1)
      jb    @@next5
      fxch  st(1)
    @@next5:
      fstp  st(0)
       fcomi st(0),st(1)
      jb    @@next6
      fxch  st(1)
    @@next6:
      fstp  st(0)
       fcomi st(0),st(1)
      jb    @@next7
      fxch  st(1)
    @@next7:
      fstp  st(0)


      fld   tbyte ptr [eax+70]
        add   eax,80
      fcomi st(0),st(1)
      jb    @@next8
      fxch  st(1)
    @@next8:
      fstp  st(0)
     // add   eax,80



      dec   ecx

 jnz   @@cycl8




  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      add   eax,10

    @@cmpx1:
      fcomi st(0),st(1)
      jb    @@nextx1
      fxch  st(1)
    @@nextx1:
      fstp  st(0)

      dec   cx

  jnz   @@cyclx1




 @@end:

    pop   bx
    pop   ecx
    pop  eax
end;



{
  RVE_MAX_NoBranches works very slow?!! Much slower than RVE_MAX with branches !
}
(*
procedure RVE_MAX_NoBranches; assembler;
//in:
//EAX <- @Array[0]
asm

     push  ecx
     push  bx


     //mov   eax, [eax]
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     fstp st(0)
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect

     //jecxz @@end
     test ecx, ecx
     jz @@end


     fld   tbyte ptr [eax]


     mov   bx,cx
     shr   ecx,3
     and   bx,7

     jecxz  @@cycl1

     //fstp st(0)

   {  test ecx,ecx
     jz @@cycl1   }




 @@cycl8:

      fld   tbyte ptr [eax]
      fld   tbyte ptr [eax+10]
      fld   tbyte ptr [eax+20]
      fld   tbyte ptr [eax+30]
      fld   tbyte ptr [eax+40]
      fld   tbyte ptr [eax+50]
      fld   tbyte ptr [eax+60]


     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)

     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)

     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)

     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)

     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)

     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)

     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)



     fld   tbyte ptr [eax+70]

        add   eax,80

     fcomi   st(0), st(1)
    //fcmovnb st(0), st(1)     //min
     fcmovb  st(0), st(1)     //max
     fstp st(1)


      dec   ecx

 jnz   @@cycl8


  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      add   eax,10

    @@cmpx1:

       fcomi   st(0), st(1)
      //fcmovnb st(0), st(1)     //min
       fcmovb  st(0), st(1)     //max
       fstp st(1)



      dec   cx

  jnz   @@cyclx1



 @@end:

    pop   bx
    pop   ecx

end;
 *)






procedure RVS_MAX; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx

  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)
  fldz


  mov   ecx,[eax-4]         //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  cmp   ecx,0
  jnz   @@cycl4

  movss   xmm0, dword ptr[eax]
  add     eax,4
  dec     bx
  jmp     @@cycl1

  @@cycl4:
  movups xmm4,  oword ptr[eax]    // xmm4 - аккумулятор; для инициализации аккумулятора

  @@cyclx4:


     movups   xmm0, oword ptr[eax]
     movups   xmm1, oword ptr[eax+16]
     movups   xmm2, oword ptr[eax+32]
     movups   xmm3, oword ptr[eax+48]


     add    eax,64

     maxps   xmm0,xmm1
     maxps   xmm2,xmm3
     maxps   xmm0,xmm2

     maxps   xmm4,xmm0



     //add    eax,64
     dec    ecx

  jnz   @@cyclx4

   movhlps xmm0,xmm4
   maxps   xmm0,xmm4

   pshuflw  xmm1,xmm0,14
   maxss    xmm0, xmm1




  @@cycl1:

   fstp st(0)
   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr



  @@cyclx1:

      maxss   xmm0, dword ptr [eax+4*ecx-4]
      //add   eax,8
      dec     cx

  jnz   @@cyclx1





@@endr:

  sub     esp,4
  movss   dword ptr [esp], xmm0
  fld     dword ptr [esp]
  add     esp,4



@@endp:

  pop   bx
  pop   ecx
  pop   eax
end;





procedure RVI_MAX; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx

  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp


  fstp  st(0)

  mov   ecx,[eax-4]

  {.357}
  add ecx,c_DinArrayLenCorrect     //  ECX - Length of array



  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  cmp   ecx,0
  jnz   @@cycl4

  movd    xmm0, dword ptr[eax]
  add     eax,4
  dec     bx
  jmp     @@cycl1

  @@cycl4:
  movdqu xmm4,  oword ptr[eax]    // xmm4 - аккумулятор; для инициализации аккумулятора

  @@cyclx4:


     movdqu   xmm0, oword ptr[eax]
     movdqu   xmm1, oword ptr[eax+16]
     movdqu   xmm2, oword ptr[eax+32]
     movdqu   xmm3, oword ptr[eax+48]


     add    eax,64

     pmaxsd   xmm0,xmm1
     pmaxsd   xmm2,xmm3
     pmaxsd   xmm0,xmm2

     pmaxsd   xmm4,xmm0



     //add    eax,64
     dec    ecx

  jnz   @@cyclx4

   movhlps  xmm0,xmm4
   pmaxsd   xmm0,xmm4

   pshuflw   xmm1,xmm0,14
   pmaxsd    xmm0, xmm1




  @@cycl1:


   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr



  @@cyclx1:

      movd     xmm1, dword ptr [eax+4*ecx-4]
      pmaxsd   xmm0, xmm1
      //add   eax,8
      dec     cx

  jnz   @@cyclx1


@@endr:

  sub     esp,4
  movd    dword ptr [esp], xmm0
  fild    dword ptr [esp]
  add     esp,4




@@endp:

  pop  bx
  pop  ecx
  pop  eax

end;








procedure RVD_MIN; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx

  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)
  fldz


  mov   ecx,[eax-4]     //ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect

  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  cmp   ecx,0
  jnz   @@cycl4

  movlpd  xmm0, qword ptr[eax]
  add   eax,8
  dec   bx
  jmp   @@cycl1

  @@cycl4:
  movupd xmm4,  oword ptr[eax]    // xmm4 - аккумулятор; для инициализации аккумулятора

  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]


     add    eax,64

     minpd   xmm0,xmm1
     minpd   xmm2,xmm3
     minpd   xmm0,xmm2

     minpd   xmm4,xmm0



     //add    eax,64
     dec    ecx

  jnz   @@cyclx4

  movhlps xmm0,xmm4
  minsd   xmm0,xmm4


  @@cycl1:

   fstp st(0)
   mov   cx,bx
   jcxz @@end



  @@cyclx1:

      minsd   xmm0, qword ptr [eax]
      add   eax,8
      dec    cx

  jnz   @@cyclx1





@@end:

  sub     esp,8
  movlpd  qword ptr [esp], xmm0
  fld     qword ptr [esp]
  add     esp,8


@@endp:

  pop   bx
  pop   ecx
  pop  eax


end;






procedure RVE_MIN; assembler;
//in:
//EAX <- @Array[0]
asm
     push   eax
     push  ecx
     push  bx


     //mov   eax, [eax]
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     fstp st(0)
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect

     //jecxz @@end
     test ecx, ecx
     jz @@end




     fld   tbyte ptr [eax]
     //add   eax,10

     mov   bx,cx
     shr   ecx,3
     and   bx,7

     jecxz  @@cycl1

     //fstp st(0)

   {  test ecx,ecx
     jz @@cycl1   }




 @@cycl8:

      fld   tbyte ptr [eax]
      fld   tbyte ptr [eax+10]
      fld   tbyte ptr [eax+20]
      fld   tbyte ptr [eax+30]
      fld   tbyte ptr [eax+40]
      fld   tbyte ptr [eax+50]
      fld   tbyte ptr [eax+60]

     {
      fld   tbyte ptr [eax+70]
      add   eax,80
     }

      fcomi st(0),st(1)
      jnbe    @@next1
      fxch  st(1)
    @@next1:
      fstp  st(0)

      fcomi st(0),st(1)
      jnbe    @@next2
      fxch  st(1)
    @@next2:
      fstp  st(0)

      fcomi st(0),st(1)
      jnbe    @@next3
      fxch  st(1)
    @@next3:
      fstp  st(0)

      fcomi st(0),st(1)
      jnbe    @@next4
      fxch  st(1)
    @@next4:
      fstp  st(0)

      fcomi st(0),st(1)
      jnbe    @@next5
      fxch  st(1)
    @@next5:
      fstp  st(0)

      fcomi st(0),st(1)
      jnbe    @@next6
      fxch  st(1)
    @@next6:
      fstp  st(0)

      fcomi st(0),st(1)
      jnbe    @@next7
      fxch  st(1)
    @@next7:
      fstp  st(0)


      fld   tbyte ptr [eax+70]

        add   eax,80

      fcomi st(0),st(1)
      jnbe    @@next8
      fxch  st(1)
    @@next8:
      fstp  st(0)




      dec   ecx

 jnz   @@cycl8




  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      add   eax,10

    @@cmpx1:
      fcomi st(0),st(1)
      jnbe    @@nextx1
      fxch  st(1)
    @@nextx1:
      fstp  st(0)

      dec   cx

  jnz   @@cyclx1




 @@end:

    pop   bx
    pop   ecx
    pop  eax

end;





procedure RVS_MIN; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx

  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)
  fldz


  mov   ecx,[eax-4]         //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  cmp   ecx,0
  jnz   @@cycl4

  movss   xmm0, dword ptr[eax]
  add     eax,4
  dec     bx
  jmp     @@cycl1

  @@cycl4:
  movups xmm4,  oword ptr[eax]    // xmm4 - аккумулятор; для инициализации аккумулятора

  @@cyclx4:


     movups   xmm0, oword ptr[eax]
     movups   xmm1, oword ptr[eax+16]
     movups   xmm2, oword ptr[eax+32]
     movups   xmm3, oword ptr[eax+48]


     add    eax,64

     minps   xmm0,xmm1
     minps   xmm2,xmm3
     minps   xmm0,xmm2

     minps   xmm4,xmm0



     //add    eax,64
     dec    ecx

  jnz   @@cyclx4

   movhlps xmm0,xmm4
   minps   xmm0,xmm4

   pshuflw  xmm1,xmm0,14
   minss    xmm0, xmm1




  @@cycl1:

   fstp st(0)
   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr



  @@cyclx1:

      minss   xmm0, dword ptr [eax+4*ecx-4]
      //add   eax,8
      dec     cx

  jnz   @@cyclx1





@@endr:

  sub     esp,4
  movss   dword ptr [esp], xmm0
  fld     dword ptr [esp]
  add     esp,4



@@endp:

  pop   bx
  pop   ecx
  pop  eax

end;





procedure RVI_MIN; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx

  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp


  fstp  st(0)

  mov   ecx,[eax-4]

  {.357}
  add ecx,c_DinArrayLenCorrect     //  ECX - Length of array



  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  cmp   ecx,0
  jnz   @@cycl4

  movd    xmm0, dword ptr[eax]
  add     eax,4
  dec     bx
  jmp     @@cycl1

  @@cycl4:
  movdqu xmm4,  oword ptr[eax]    // xmm4 - аккумулятор; для инициализации аккумулятора

  @@cyclx4:


     movdqu   xmm0, oword ptr[eax]
     movdqu   xmm1, oword ptr[eax+16]
     movdqu   xmm2, oword ptr[eax+32]
     movdqu   xmm3, oword ptr[eax+48]


     add    eax,64

     pminsd   xmm0,xmm1
     pminsd   xmm2,xmm3
     pminsd   xmm0,xmm2

     pminsd   xmm4,xmm0



     //add    eax,64
     dec    ecx

  jnz   @@cyclx4

   movhlps  xmm0,xmm4
   pminsd   xmm0,xmm4

   pshuflw   xmm1,xmm0,14
   pminsd    xmm0, xmm1




  @@cycl1:


   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr



  @@cyclx1:

      movd     xmm1, dword ptr [eax+4*ecx-4]
      pminsd   xmm0, xmm1
      //add   eax,8
      dec     cx

  jnz   @@cyclx1


@@endr:

  sub     esp,4
  movd    dword ptr [esp], xmm0
  fild    dword ptr [esp]
  add     esp,4




@@endp:

  pop  bx
  pop  ecx
  pop  eax

end;





procedure RVD_SUM; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push  eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fldz

  PSLLDQ xmm4,  16         //xmm4 <- ZERO ; accumulator SSE


  mov   ecx,[eax-4]           //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]


     add    eax,64

     addpd  xmm0,xmm1
     addpd  xmm2,xmm3
     addpd  xmm0,xmm2

     {
     //haddpd xmm0,xmm0
     movhlps  xmm1,xmm0
     addpd   xmm0,xmm1
     }

     addpd  xmm4,xmm0

     dec    ecx

  jnz   @@cyclx4

  //haddpd xmm4,xmm4
  movhlps  xmm1,xmm4
  addpd   xmm4,xmm1

  sub     esp,8
  movlpd  qword ptr [esp], xmm4
  fadd    qword ptr [esp]
  add     esp,8



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fadd qword ptr [eax]
      add   eax,8
      dec    cx

  jnz   @@cyclx1


@@end:

  pop   bx
  pop   ecx
  pop  eax

end;




procedure RVE_SUM; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 5
  push  eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fldz

  mov   ecx,[eax-4]          //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     fld    tbyte ptr[eax]
     fld    tbyte ptr[eax+10]
     fld    tbyte ptr[eax+20]
     fld    tbyte ptr[eax+30]

     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)

     fld    tbyte ptr[eax+40]
     fld    tbyte ptr[eax+50]
     fld    tbyte ptr[eax+60]
     fld    tbyte ptr[eax+70]

     add    eax,80

     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)


     {
     //DeepFPU = 8

     fld    tbyte ptr[eax]
     faddp

     fld    tbyte ptr[eax+10]
     fld    tbyte ptr[eax+20]
     fld    tbyte ptr[eax+30]
     fld    tbyte ptr[eax+40]
     fld    tbyte ptr[eax+50]
     fld    tbyte ptr[eax+60]
     fld    tbyte ptr[eax+70]

     faddp  st(7),st(0)
     faddp  st(5),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)

     add    eax,80

     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)
     }

     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      add   eax,10
      faddp st(1),st(0)
      dec   cx

  jnz   @@cyclx1



@@end:


  pop   bx
  pop   ecx
  pop  eax

end;





procedure RVS_SUM; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1

  push  eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)
  fldz


  PSLLDQ xmm4,  16         //xmm4 <- ZERO ; accumulator SSE


  mov   ecx,[eax-4]          //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect



  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:



    movups   xmm0, oword ptr[eax]
    movups   xmm1, oword ptr[eax+16]
    movups   xmm2, oword ptr[eax+32]
    movups   xmm3, oword ptr[eax+48]



    add      eax, 64


    addps    xmm0, xmm1
    addps    xmm2, xmm3
    addps    xmm0, xmm2

    {
    //haddps in xmm0
    movhlps  xmm1,xmm0
    addps    xmm0, xmm1
    pshuflw  xmm1,xmm0,14
    addps    xmm0, xmm1
    }

    addps    xmm4, xmm0


    dec      ecx

  jnz   @@cyclx4


   //haddps in xmm4
   movhlps  xmm1,xmm4
   addps    xmm4, xmm1
   pshuflw  xmm1,xmm4,14
   addps    xmm4, xmm1

  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr


  @@cyclx1:

       addss  xmm4, dword ptr [eax+4*ecx-4]
       dec   cx

  jnz   @@cyclx1


@@endr:

  sub     esp,4
  movss   dword ptr [esp], xmm4
  fadd    dword ptr [esp]
  add     esp,4


@@endp:

  pop   bx
  pop   ecx
  pop  eax


end;






procedure RVI_SUM; assembler;
//in:
//EAX <- @Array[0]
asm

// DeepFPU = 1
  push  eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  //fldz
  fstp  st(0)

  PSLLDQ xmm4,  16         //xmm4 <- ZERO ; accumulator SSE

  mov   ecx,[eax-4]            //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:



    movdqu   xmm0, oword ptr[eax]
    movdqu   xmm1, oword ptr[eax+16]
    movdqu   xmm2, oword ptr[eax+32]
    movdqu   xmm3, oword ptr[eax+48]



    add      eax, 64


    paddd    xmm0, xmm1
    paddd    xmm2, xmm3
    paddd    xmm0, xmm2


    {
    // hadd_i32 in xmm0
    movhlps  xmm1,xmm0
    paddd    xmm0, xmm1
    pshuflw  xmm1,xmm0,14
    paddd    xmm0, xmm1
    }

    paddd    xmm4, xmm0


    dec      ecx


  jnz   @@cyclx4


  // hadd_i32 in xmm4
   movhlps  xmm1,xmm4
   paddd    xmm4, xmm1
   pshuflw  xmm1,xmm4,14
   paddd    xmm4, xmm1

  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr


  @@cyclx1:

       movd  xmm0, dword ptr [eax+4*ecx-4]
       paddd xmm4,xmm0
       dec   cx

  jnz   @@cyclx1


@@endr:

  sub     esp,4
  movd    dword ptr [esp], xmm4
  fild    dword ptr [esp]
  add     esp,4


@@endp:

  pop  bx
  pop  ecx
  pop  eax


end;





procedure RVD_PROD; assembler;
//in:
//EAX <- @Array[0]
const
   c1: double = 1.0;
asm
// Prod( VX[i])


// DeepFPU = 2
  push   eax
  push  ecx
  push  bx
  sub   esp,8


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fld1

  movddup xmm4, qword ptr [c1]   //xmm4 <- 1; accumulator SSE;  expand in all xmm4

  mov   ecx,[eax-4]                  //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]


     add    eax,64

     mulpd  xmm0,xmm1
     mulpd  xmm2,xmm3
     mulpd  xmm0,xmm2

     {
     //hmulpd xmm0,xmm0
     movhlps  xmm1,xmm0
     mulpd    xmm0,xmm1
     }

     mulpd    xmm4,xmm0


     dec    ecx

  jnz   @@cyclx4


  //hmulpd xmm4,xmm4
  movhlps  xmm1,xmm4
  mulpd    xmm4,xmm1

  //sub     esp,8
  movlpd  qword ptr [esp], xmm4
  fmul    qword ptr [esp]
  //add     esp,8


  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   qword ptr [eax]
      add   eax,8
      fmulp st(1),st(0)
      dec    cx

  jnz   @@cyclx1



@@end:

  add   esp,8
  pop   bx
  pop   ecx
  pop  eax

end;





procedure RVS_PROD; assembler;
//in:
//EAX <- @Array[0]
const
   c1: single = 1.0;
asm
// PROD (VX[i])

// DeepFPU = 1
  push   eax
  push   ecx
  push   bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)
  fld1



  movss   xmm4, dword ptr [c1]   //xmm4 <- 1; accumulator SSE
  shufps  xmm4,xmm4,0;           // 1 -  expand in all xxm4



  mov   ecx,[eax-4]               //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect
 



  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:

    movups   xmm0, oword ptr[eax]
    movups   xmm1, oword ptr[eax+16]
    movups   xmm2, oword ptr[eax+32]
    movups   xmm3, oword ptr[eax+48]


    add      eax, 64


    mulps    xmm0, xmm1
    mulps    xmm2, xmm3
    mulps    xmm0, xmm2

    {
    //hmulps in xmm0
    movhlps  xmm1,xmm0
    mulps    xmm0, xmm1
    pshuflw  xmm1,xmm0,14
    mulps    xmm0, xmm1
     }

    mulps    xmm4, xmm0


    dec      ecx

  jnz   @@cyclx4

    //hmulps in xmm4
    movhlps  xmm1,xmm4
    mulps    xmm4, xmm1
    pshuflw  xmm1,xmm4,14
    mulps    xmm4, xmm1


  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr


  @@cyclx1:

       mulss  xmm4, dword ptr [eax+4*ecx-4]
       dec   cx

  jnz   @@cyclx1


@@endr:
  movss   dword ptr [esp], xmm4
  fmul    dword ptr [esp]



@@endp:

  pop   bx
  pop  ecx
  pop  eax

end;




procedure RVE_PROD; assembler;
//in:
//EAX <- @Array[0]
asm
// PROD (VX[i])

// DeepFPU = 5


  push   eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fld1

  mov   ecx,[eax-4]              //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect



  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:


     fld    tbyte ptr[eax]
     fld    tbyte ptr[eax+10]
     fld    tbyte ptr[eax+20]
     fld    tbyte ptr[eax+30]

     fmulp  st(2),st(0)
     fmulp  st(3),st(0)
     fmulp  st(1),st(0)
     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+40]
     fld    tbyte ptr[eax+50]
     fld    tbyte ptr[eax+60]
     fld    tbyte ptr[eax+70]

     add    eax,80

     fmulp  st(2),st(0)
     fmulp  st(3),st(0)
     fmulp  st(1),st(0)
     fmulp  st(1),st(0)


     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      add   eax,10
      fmulp st(1),st(0)
      dec   cx

  jnz   @@cyclx1



@@end:


  pop   bx
  pop   ecx
  pop  eax


end;







procedure RVD_SUMQ; assembler;
//in:
//EAX <- @Array[0]
asm
// SUM (VX[i]^2)

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fldz



  PSLLDQ xmm4,  16         //xmm4 <- ZERO ; accumulator SSE

  mov   ecx,[eax-4]         //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect
 


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:


     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]

     mulpd  xmm0,xmm0
     mulpd  xmm1,xmm1
     mulpd  xmm2,xmm2
     mulpd  xmm3,xmm3


     add    eax,64

     addpd  xmm0,xmm1
     addpd  xmm2,xmm3
     addpd  xmm0,xmm2

     //haddpd xmm0,xmm0
     {movhlps  xmm1,xmm0
     addpd   xmm0,xmm1}

     addpd  xmm4,xmm0

     //через dppd haddpd работает очень медленно
    {
     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]

     dppd  xmm0,xmm0,63
     dppd  xmm1,xmm1,63
     movhlps  xmm0,xmm1
     dppd  xmm2,xmm2,63
     dppd  xmm3,xmm3,63
     movhlps  xmm2,xmm3
     addpd  xmm0,xmm2


     add    eax,64
      //haddpd xmm0,xmm0
     movhlps  xmm1,xmm0
     addpd   xmm0,xmm1

     addpd  xmm4,xmm0
     }




     dec    ecx

  jnz   @@cyclx4

  //haddpd xmm4,xmm4
  movhlps  xmm1,xmm4
  addpd   xmm4,xmm1



  sub     esp,8
  movlpd  qword ptr [esp], xmm4
  fadd    qword ptr [esp]
  add     esp,8


  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   qword ptr [eax]
      add   eax,8
      fmul  st(0),st(0)
      faddp st(1),st(0)
      dec    cx

  jnz   @@cyclx1



@@end:

  pop   bx
  pop   ecx
  pop  eax

end;




procedure RVE_SUMQ; assembler;
//in:
//EAX <- @Array[0]
asm
// SUM (VX[i]^2)

// DeepFPU = 5
  push   eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fldz


  mov   ecx,[eax-4]                //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect
 


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:


     fld    tbyte ptr[eax]
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+10]
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+20]
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+30]
     fmul   st(0),st(0)



     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)



     fld    tbyte ptr[eax+40]
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+50]
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+60]
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+70]
     fmul   st(0),st(0)

     add    eax,80


     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)



     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      fmul  st(0),st(0)
      add   eax,10
      faddp st(1),st(0)
      dec   cx

  jnz   @@cyclx1


@@end:

  pop   bx
  pop   ecx
  pop  eax


end;






procedure RVS_SUMQ; assembler;
//in:
//EAX <- @Array[0]
asm
// SUM (VX[i]^2)

// DeepFPU = 1
  push   eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)
  fldz

  PSLLDQ xmm4,  16         //xmm4 <- ZERO ; accumulator SSE


  mov   ecx,[eax-4]           //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect
 

  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:



    movups   xmm0, oword ptr[eax]
    movups   xmm1, oword ptr[eax+16]
    movups   xmm2, oword ptr[eax+32]
    movups   xmm3, oword ptr[eax+48]

    add      eax, 64

    mulps    xmm0, xmm0
    mulps    xmm1, xmm1
    mulps    xmm2, xmm2
    mulps    xmm3, xmm3

    addps    xmm0, xmm1
    addps    xmm2, xmm3
    addps    xmm0, xmm2

    {
    //  haddps in xmm0
    movhlps  xmm1,xmm0
    addps    xmm0, xmm1
    pshuflw  xmm1,xmm0,14
    addps    xmm0, xmm1
     }

    addps    xmm4, xmm0


    dec      ecx

  jnz   @@cyclx4

   //haddps in xmm4
   movhlps  xmm1,xmm4
   addps    xmm4, xmm1
   pshuflw  xmm1,xmm4,14
   addps    xmm4, xmm1


  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr


  @@cyclx1:

       movss  xmm0, dword ptr [eax+4*ecx-4]
       mulss  xmm0, xmm0
       addss  xmm4, xmm0

       dec   cx

  jnz  @@cyclx1


@@endr:
  sub     esp,4
  movss   dword ptr [esp], xmm4
  fadd    dword ptr [esp]
  add     esp,4


@@endp:


  pop   bx
  pop   ecx
  pop  eax

end;






procedure RVD_PRODS; assembler;
//in:
// EAX <-   @Array[0]
// st(0) <- x
const
   c1: double = 1.0;
asm
// PROD( VX[i]-x )


// DeepFPU = 2
  push   eax
  push  ecx
  push  bx
  sub   esp,8
  fst   qword ptr [esp] //x-> esp


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fld1


  movddup xmm4, qword ptr [c1]   //xmm4 <- 1; accumulator SSE;  expand in all xmm4
  movddup xmm5, qword ptr[esp]  //xmm5_0,xmm5_1 <- x; expand in all xxm5


  mov   ecx,[eax-4]            //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]

     subpd  xmm0,xmm5
     subpd  xmm1,xmm5
     subpd  xmm2,xmm5
     subpd  xmm3,xmm5

     add    eax,64

     mulpd  xmm0,xmm1
     mulpd  xmm2,xmm3
     mulpd  xmm0,xmm2

     //hmulpd xmm0,xmm0
     {movhlps  xmm1,xmm0
     mulpd    xmm0,xmm1}


     mulpd    xmm4,xmm0


     dec    ecx

  jnz   @@cyclx4


  //hmulpd xmm4,xmm4
  movhlps  xmm1,xmm4
  mulpd    xmm4,xmm1

  sub     esp,8
  movlpd  qword ptr [esp], xmm4
  fmul    qword ptr [esp]
  add     esp,8


  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   qword ptr [eax]
      fsub  st(0),st(2)
      add   eax,8
      fmulp st(1),st(0)
      dec    cx

  jnz   @@cyclx1



@@end:

  fstp  st(1)
  add   esp,8
  pop   bx
  pop   ecx
  pop  eax

end;




procedure RVE_PRODS; assembler;
//in:
// EAX <- @Array[0]
// st(0) <- x
asm
// PROD(VX[i] - x)
// DeepFPU = 6


  push   eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end

  fstp  st(0)
  fld1


  mov   ecx,[eax-4]                //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect




  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:


     fld    tbyte ptr[eax]
     fsub   st(0),st(2)
     fld    tbyte ptr[eax+10]
     fsub   st(0),st(3)
     fld    tbyte ptr[eax+20]
     fsub   st(0),st(4)
     fld    tbyte ptr[eax+30]
     fsub   st(0),st(5)




     fmulp  st(2),st(0)
     fmulp  st(3),st(0)
     fmulp  st(1),st(0)
     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+40]
     fsub   st(0),st(2)
     fld    tbyte ptr[eax+50]
     fsub   st(0),st(3)
     fld    tbyte ptr[eax+60]
     fsub   st(0),st(4)
     fld    tbyte ptr[eax+70]
     fsub   st(0),st(5)


     add    eax,80

     fmulp  st(2),st(0)
     fmulp  st(3),st(0)
     fmulp  st(1),st(0)
     fmulp  st(1),st(0)


     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      fsub  st(0),st(2)
      add   eax,10
      fmulp st(1),st(0)
      dec   cx

  jnz   @@cyclx1





@@end:


  fstp  st(1)
  pop   bx
  pop   ecx
  pop  eax


end;







procedure RVS_PRODS; assembler;
//in:
// EAX <-   @Array[0]
// st(0) <- x
const
   c1: single = 1.0;
asm
// PROD( VX[i]-x )

// DeepFPU = 1
  push   eax
  push   ecx
  push   bx
  sub    esp,4
  fstp   dword ptr [esp] //x-> esp


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp

  fstp  st(0)



  movss   xmm4, dword ptr [c1]   //xmm4 <- 1; accumulator SSE
  shufps  xmm4,xmm4,0;        //  1 -  expand in all xxm4

  movss  xmm5,  dword ptr[esp]
  shufps xmm5,xmm5,0;        //xmm5_0,xmm5_1 <- x; expand in all xxm5

  mov   ecx,[eax-4]           //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect
 


  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:



    movups   xmm0, oword ptr[eax]
    movups   xmm1, oword ptr[eax+16]
    movups   xmm2, oword ptr[eax+32]
    movups   xmm3, oword ptr[eax+48]

    add      eax, 64

    subps  xmm0,xmm5
    subps  xmm1,xmm5
    subps  xmm2,xmm5
    subps  xmm3,xmm5


    mulps    xmm0, xmm1
    mulps    xmm2, xmm3
    mulps    xmm0, xmm2

    {
    //hmulps in xmm0
    movhlps  xmm1,xmm0
    mulps    xmm0, xmm1
    pshuflw  xmm1,xmm0,14
    mulps    xmm0, xmm1
    }

    mulps    xmm4, xmm0


    dec      ecx

  jnz   @@cyclx4


   // hmulps in xmm4
   movhlps  xmm1,xmm4
   mulps    xmm4, xmm1
   pshuflw  xmm1,xmm4,14
   mulps    xmm4, xmm1


  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr


  @@cyclx1:

       movss  xmm0, dword ptr [eax+4*ecx-4]
       subps  xmm0,xmm5
       mulss  xmm4, xmm0

       dec   cx

  jnz   @@cyclx1

@@endr:

  movss   dword ptr [esp], xmm4
  fld     dword ptr [esp]



@@endp:


  add  esp,4
  pop   bx
  pop  ecx
  pop  eax

end;





procedure RVD_SUMQS; assembler;
//in:
// EAX   <- @Array[0]
// st(0) <- x
asm
// Sum (VX[i] - x)^2


// DeepFPU = 2
  push   eax
  push  ecx
  push  bx
  sub   esp,8
  fst   qword ptr [esp] //x-> esp


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  fstp  st(0)
  fldz



  PSLLDQ  xmm4,  16             //xmm4 <- ZERO ; accumulator SSE
  movddup xmm5, qword ptr[esp]  //xmm5_0,xmm5_1 <- x; expand in all xxm5


  mov   ecx,[eax-4]                //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect



  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     movupd xmm2,  oword ptr [eax+32]
     movupd xmm3,  oword ptr [eax+48]

     subpd  xmm0,xmm5
     subpd  xmm1,xmm5
     subpd  xmm2,xmm5
     subpd  xmm3,xmm5

     mulpd  xmm0,xmm0
     mulpd  xmm1,xmm1
     mulpd  xmm2,xmm2
     mulpd  xmm3,xmm3


     add    eax,64

     addpd  xmm0,xmm1
     addpd  xmm2,xmm3
     addpd  xmm0,xmm2

     //haddpd xmm0,xmm0
     {movhlps  xmm1,xmm0
     addpd   xmm0,xmm1}


     addpd  xmm4,xmm0


     //add    eax,64
     dec    ecx

  jnz   @@cyclx4


  //haddpd xmm4,xmm4
  movhlps  xmm1,xmm4
  addpd   xmm4,xmm1

  //sub     esp,8
  movlpd  qword ptr [esp], xmm4
  fadd    qword ptr [esp]
  //add     esp,8


  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   qword ptr [eax]
      fsub  st(0),st(2)
      add   eax,8
      fmul  st(0),st(0)
      faddp st(1),st(0)
      dec    cx

  jnz   @@cyclx1





@@end:

  fstp  st(1)
  add   esp,8
  pop   bx
  pop   ecx
  pop  eax

end;






procedure RVE_SUMQS; assembler;
//in:
// EAX   <- @Array[0]
// st(0) <- x
asm

// DeepFPU = 6
// Sum (VX[i] - x)^2

  push   eax
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  fstp  st(0)
  fldz


  mov   ecx,[eax-4]          //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect




  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:


     fld    tbyte ptr[eax]
     fsub   st(0),st(2)
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+10]
     fsub   st(0),st(3)
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+20]
     fsub   st(0),st(4)
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+30]
     fsub   st(0),st(5)
     fmul   st(0),st(0)



     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)

     fld    tbyte ptr[eax+40]
     fsub   st(0),st(2)
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+50]
     fsub   st(0),st(3)
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+60]
     fsub   st(0),st(4)
     fmul   st(0),st(0)
     fld    tbyte ptr[eax+70]
     fsub   st(0),st(5)
     fmul   st(0),st(0)



     add    eax,80



     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)


     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      fsub  st(0),st(2)
      fmul  st(0),st(0)
      add   eax,10
      faddp st(1),st(0)
      dec   cx

  jnz   @@cyclx1





@@end:


  fstp  st(1)
  pop   bx
  pop   ecx
  pop  eax


end;




procedure RVS_SUMQS; assembler;
//in:
// EAX   <- @Array[0]
// st(0) <- x
asm
// Sum (VX[i] - x)^2

// DeepFPU = 1
  push   eax
  push   ecx
  push   bx
  sub    esp,4
  fstp   dword ptr [esp] //x-> esp


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp
  fstp  st(0)
  fldz


  PSLLDQ xmm4,  16                //xmm4 <- ZERO ; accumulator SSE
  movss  xmm5,  dword ptr[esp]
  shufps     xmm5,xmm5,0;        //xmm5_0,xmm5_1 <- x; expand in all xxm5

  mov   ecx,[eax-4]              //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:



    movups   xmm0, oword ptr[eax]
    movups   xmm1, oword ptr[eax+16]
    movups   xmm2, oword ptr[eax+32]
    movups   xmm3, oword ptr[eax+48]

    add      eax, 64

    subps  xmm0,xmm5
    subps  xmm1,xmm5
    subps  xmm2,xmm5
    subps  xmm3,xmm5

    mulps    xmm0, xmm0
    mulps    xmm1, xmm1
    mulps    xmm2, xmm2
    mulps    xmm3, xmm3

    addps    xmm0, xmm1
    addps    xmm2, xmm3
    addps    xmm0, xmm2

    {
     //haddps in xmm0
    movhlps  xmm1,xmm0
    addps    xmm0, xmm1
    pshuflw  xmm1,xmm0,14
    addps    xmm0, xmm1
    }

    addps    xmm4, xmm0

    dec      ecx

  jnz   @@cyclx4


   //haddps in xmm4
   movhlps  xmm1,xmm4
   addps    xmm4, xmm1
   pshuflw  xmm1,xmm4,14
   addps    xmm4, xmm1


  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr


  @@cyclx1:

       movss  xmm0, dword ptr [eax+4*ecx-4]
       subps  xmm0,xmm5
       mulss  xmm0, xmm0
       addss  xmm4, xmm0

       dec   cx

  jnz   @@cyclx1


@@endr:
  movss   dword ptr [esp], xmm4
  fadd    dword ptr [esp]



@@endp:


  add  esp,4
  pop  bx
  pop  ecx
  pop  eax




end;







procedure RVD_AVR; assembler;
//in:
//EAX <- @Array[0]
asm
// SUM (V[i])/Len
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVD_SUM

   mov [esp], ecx  //Len->esp

   fidiv [esp]   //  Sum/Len



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax


end;






procedure RVE_AVR; assembler;
//in:
//EAX <- @Array[0]
asm
// SUM (V[i])/Len
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVE_SUM

   mov [esp], ecx  //Len->esp

   fidiv [esp]   //  Sum/Len



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax


end;






procedure RVS_AVR; assembler;
//in:
//EAX <- @Array[0]
asm
// SUM (V[i])/Len
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVS_SUM

   mov [esp], ecx  //Len->esp

   fidiv [esp]   //  Sum/Len



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax


end;









procedure RVD_NORM; assembler;
//in:
//EAX <- @Array[0]
asm
// SQRT (SUM (V[i]^2))
   push   eax
   push   ecx
   push   bx

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVD_SUMQ

   fsqrt


@@endp:


   pop   bx
   pop  ecx
   pop  eax


end;





procedure RVE_NORM; assembler;
//in:
//EAX <- @Array[0]
asm
// SQRT (SUM (V[i]^2))
   push   eax
   push   ecx
   push   bx

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVE_SUMQ

   fsqrt


@@endp:


   pop   bx
   pop  ecx
   pop  eax


end;






procedure RVS_NORM; assembler;
//in:
//EAX <- @Array[0]
asm
// SQRT (SUM (V[i]^2))
   push   eax
   push   ecx
   push   bx

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVS_SUMQ

   fsqrt


@@endp:


   pop   bx
   pop  ecx
   pop  eax


end;






procedure RVD_DEV; assembler;
//in:
//EAX <- @Array[0]
asm
// Sqrt(SUM (V[i])/Len)
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVD_AVR
   call    RVD_SUMQS

   mov [esp], ecx  //Len->esp
   fidiv [esp]   //  Sqrt(Sum/Len
   fsqrt



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax


end;





procedure RVE_DEV; assembler;
//in:
//EAX <- @Array[0]
asm
// Sqrt(SUM (V[i])/Len)
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVE_AVR
   call    RVE_SUMQS

   mov [esp], ecx  //Len->esp
   fidiv [esp]   //  Sqrt(Sum/Len
   fsqrt



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax

end;





procedure RVS_DEV; assembler;
//in:
//EAX <- @Array[0]
asm
// Sqrt(SUM (V[i])/Len)
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVS_AVR
   call    RVS_SUMQS

   mov [esp], ecx  //Len->esp
   fidiv [esp]   //  Sqrt(Sum/Len
   fsqrt



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax


end;






procedure RVD_DEVS; assembler;
//in:
//EAX <- @Array[0]
asm
// Sqrt(SUM (V[i])/(Len-1))
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVD_AVR
   call    RVD_SUMQS

   mov [esp], ecx  //Len -> esp
   dec   [esp]    // Len-1
   fidiv [esp]    // Sqrt(Sum/(Len-1))
   fsqrt



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax


end;





procedure RVE_DEVS; assembler;
//in:
//EAX <- @Array[0]
asm
// Sqrt(SUM (V[i])/(Len-1))
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVE_AVR
   call    RVE_SUMQS

   mov [esp], ecx  //Len -> esp
   dec   [esp]    // Len-1
   fidiv [esp]    //  Sqrt(Sum/(Len-1))
   fsqrt



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax

end;





procedure RVS_DEVS; assembler;
//in:
//EAX <- @Array[0]
asm
// Sqrt(SUM (V[i])/(Len-1))
   push   eax
   push   ecx
   push   bx
   sub    esp,4

   //fldz
   fld tbyte ptr [RetValOnNil]

   test eax,eax
   jz @@endp

   fstp  st(0)

   mov   ecx,[eax-4]           //  ECX - Length of array

   {.357}
   add ecx,c_DinArrayLenCorrect

   call    RVS_AVR
   call    RVS_SUMQS

   mov [esp], ecx  //Len -> esp
   dec   [esp]    // Len-1
   fidiv [esp]    // Sqrt(Sum/(Len-1))
   fsqrt



@@endp:


   add  esp,4
   pop   bx
   pop  ecx
   pop  eax


end;











procedure RV_SUMPS; assembler;   //sum((vec[i]-shift)^intpower)
//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)
//EDX<-intpower
//ST(0)<-shift

//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
//EDI - IntPower
asm
     push  esi
     push  ecx
     push  edx
     push  edi

     mov   esi,ebx
     mov   edi,edx
     //mov   eax, [eax]

     //fldz
     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jecxz @@end
     fstp st

     mov   eax,edi

    //for double - max speed
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@cycl1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sng
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@cycl1
  @@1sng:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@cycl1
  @@1int:
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int




  @@cycl1:
     fsub st(0),st(1)
     call R_IPWRB
     sub   ecx,1
     jle   @@end
     add   ebx,edx


 @@cycl:

     //for double - max speed
     cmp   esi,_Double   //_Double
     jnz   @@lext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@sum
  @@lext:
     cmp   esi,_Extended // _Extended
     jnz   @@lsng
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@sum
  @@lsng:
     cmp   esi,_Single  //_Single
     jnz   @@lint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@sum
  @@lint:
     fild  dword ptr [ebx]     //load int


  @@sum:
     fsub st(0),st(2)
     call R_IPWRB
     faddp


     add   ebx,edx
     dec   ecx
     jnz   @@cycl


 @@end:

     fstp  st(1)
     pop   edi
     pop   edx
     pop   ecx
     pop   esi
end;







procedure RV_SUMP; assembler;   //sum((vec[i])^intpower)
//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)
//EDX<-intpower
//ST(0)<-shift

//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
//EDI - IntPower
asm
     push  esi
     push  ecx
     push  edx
     push  edi

     mov   esi,ebx
     mov   edi,edx
     //mov   eax, [eax]

     //fldz
     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jecxz @@end
     fstp st

     mov   eax,edi

    //for double - max speed
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@cycl1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sng
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@cycl1
  @@1sng:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@cycl1
  @@1int:
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int




  @@cycl1:
     call R_IPWRB
     sub   ecx,1
     jle   @@end
     add   ebx,edx


 @@cycl:

     //for double - max speed
     cmp   esi,_Double   //_Double
     jnz   @@lext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@sum
  @@lext:
     cmp   esi,_Extended // _Extended
     jnz   @@lsng
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@sum
  @@lsng:
     cmp   esi,_Single  //_Single
     jnz   @@lint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@sum
  @@lint:
     fild  dword ptr [ebx]     //load int


  @@sum:
     call R_IPWRB
     faddp


     add   ebx,edx
     dec   ecx
     jnz   @@cycl


 @@end:

     fstp  st(1)
     pop   edi
     pop   edx
     pop   ecx
     pop   esi
end;




// sumqs(vx,vy)
procedure RVD_SUMQS_VX_VY; assembler;
asm
// in:
// VX -> EAX
// VY -> EDX
// Sum (VX[i] - VY[i])^2


// DeepFPU = 2
  push  eax
  push  edx
  push  ecx
  push  bx

  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  test edx,edx
  jz @@end
  fstp st(0)
  fldz

  PSLLDQ  xmm5,  16             //xmm5 <- ZERO ; accumulator SSE

  mov   ecx,[eax-4]               //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect



  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr[eax+16]
     movupd xmm2,  oword ptr[edx]
     movupd xmm3,  oword ptr[edx+16]

     subpd  xmm0,xmm2
     subpd  xmm1,xmm3

     mulpd  xmm0,xmm0
     mulpd  xmm1,xmm1

     addpd  xmm0,xmm1




     movupd xmm1,  oword ptr[eax+32]
     movupd xmm2,  oword ptr[eax+48]
     movupd xmm3,  oword ptr[edx+32]
     movupd xmm4,  oword ptr[edx+48]

     subpd  xmm1,xmm3
     subpd  xmm2,xmm4

     mulpd  xmm1,xmm1
     mulpd  xmm2,xmm2

     addpd  xmm1,xmm2


     addpd  xmm0,xmm1

     add    eax,64
     add    edx,64


     //haddpd xmm0,xmm0
     {movhlps  xmm1,xmm0
     addpd    xmm0,xmm1}

     addpd    xmm5,xmm0


     //add    eax,64
     dec    ecx

  jnz   @@cyclx4


  //haddpd xmm5,xmm5
  movhlps  xmm1,xmm5
  addpd   xmm5,xmm1

  sub     esp,8
  movlpd  qword ptr [esp], xmm5
  fadd    qword ptr [esp]
  add     esp,8


  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld    qword ptr [eax]
      fld    qword ptr [edx]
      fsubrp st(1),st(0)
      add    eax,8
      add    edx,8
      fmul   st(0),st(0)
      faddp  st(1),st(0)
      dec    cx

  jnz   @@cyclx1





@@end:

  pop   bx
  pop   ecx
  pop   edx
  pop   eax


end;





// sumqs(vx,vy)
procedure RVE_SUMQS_VX_VY; assembler;
asm

// DeepFPU = 5
// in:
// VX -> EAX
// VY -> EDX
// Sum (VX[i] - VY[i])^2

  push  eax
  push  edx
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  test edx,edx
  jz @@end
  fstp  st(0)
  fldz

  mov   ecx,[eax-4]           //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect



  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:


     fld    tbyte ptr[eax]
     fld    tbyte ptr[edx]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)

     fld    tbyte ptr[eax+10]
     fld    tbyte ptr[edx+10]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)

     fld    tbyte ptr[eax+20]
     fld    tbyte ptr[edx+20]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)

     fld    tbyte ptr[eax+30]
     fld    tbyte ptr[edx+30]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)


     faddp  st(4),st(0)
     faddp  st(2),st(0)
     faddp  st(2),st(0)
     faddp  st(1),st(0)

     {
     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)
     }

     fld    tbyte ptr[eax+40]
     fld    tbyte ptr[edx+40]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)

     fld    tbyte ptr[eax+50]
     fld    tbyte ptr[edx+50]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)

     fld    tbyte ptr[eax+60]
     fld    tbyte ptr[edx+60]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)

     fld    tbyte ptr[eax+70]
     fld    tbyte ptr[edx+70]
     fsubrp st(1),st(0)
     fmul   st(0),st(0)

     add    eax,80
     add    edx,80

     faddp  st(4),st(0)
     faddp  st(2),st(0)
     faddp  st(2),st(0)
     faddp  st(1),st(0)

     {
     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)
     }


     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      fld   tbyte ptr [edx]

      fsubrp  st(1),st(0)
      fmul  st(0),st(0)
      add   eax,10
      add   edx,10
      faddp st(1),st(0)
      dec   cx

  jnz   @@cyclx1





@@end:


  pop   bx
  pop   ecx
  pop   edx
  pop   eax

end;




// sumqs(vx,vy)
procedure RVS_SUMQS_VX_VY; assembler;
asm
// in:
// VX -> EAX
// VY -> EDX
// Sum (VX[i] - VY[i])^2


// DeepFPU = 2
  push  eax
  push  edx
  push  ecx
  push  bx

  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp
  test edx,edx
  jz @@endp
  fstp st(0)
  fldz

  PSLLDQ  xmm5,  16             //xmm5 <- ZERO ; accumulator SSE



  mov   ecx,[eax-4]               //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:

     movups xmm0,  oword ptr[eax]
     movups xmm1,  oword ptr[eax+16]
     movups xmm2,  oword ptr[edx]
     movups xmm3,  oword ptr[edx+16]

     subps  xmm0,xmm2
     subps  xmm1,xmm3

     mulps  xmm0,xmm0
     mulps  xmm1,xmm1

     addps  xmm0,xmm1




     movups xmm1,  oword ptr[eax+32]
     movups xmm2,  oword ptr[eax+48]
     movups xmm3,  oword ptr[edx+32]
     movups xmm4,  oword ptr[edx+48]

     subps  xmm1,xmm3
     subps  xmm2,xmm4

     mulps  xmm1,xmm1
     mulps  xmm2,xmm2

     addps  xmm1,xmm2


     addps  xmm0,xmm1

     add    eax,64
     add    edx,64



     //hadds   in xmm0
     {movhlps  xmm1,xmm0
     addps    xmm0, xmm1
     pshuflw  xmm1,xmm0,14
     addps    xmm0, xmm1 }

     addps    xmm5, xmm0



     dec    ecx

  jnz   @@cyclx4

  //haddps in xmm5
   movhlps  xmm1,xmm5
   addps    xmm5, xmm1
   pshuflw  xmm1,xmm5,14
   addps    xmm5, xmm1


  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz @@endr


  @@cyclx1:

      movss  xmm0, dword ptr [eax+4*ecx-4]
      movss  xmm1, dword ptr [edx+4*ecx-4]

      subss  xmm0,xmm1
      mulss  xmm0,xmm0

      addss    xmm5, xmm0

      dec    cx

  jnz   @@cyclx1



@@endr:

  sub  esp,4
  movss   dword ptr [esp], xmm5
  fadd    dword ptr [esp]
  add  esp,4


@@endp:

  pop   bx
  pop   ecx
  pop   edx
  pop   eax


end;






 // sumprod(vx,vy)
procedure RVD_SUMPROD_VX_VY; assembler;
asm
// in:
// VX -> EAX
// VY -> EDX
// Sum ( VX[i]*VY[i] )


// DeepFPU = 2
  push  eax
  push  edx
  push  ecx
  push  bx

  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  test edx,edx
  jz @@end
  fstp st(0)
  fldz

  PSLLDQ  xmm5,  16             //xmm5 <- ZERO ; accumulator SSE



  mov   ecx,[eax-4]               //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect
  (*
  {$IFDEF FPC}
  add ecx,1
  {$ENDIF}
  *)



  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr[eax+16]
     movupd xmm2,  oword ptr[edx]
     movupd xmm3,  oword ptr[edx+16]

     mulpd  xmm0,xmm2
     mulpd  xmm1,xmm3

     addpd  xmm0,xmm1



     movupd xmm1,  oword ptr[eax+32]
     movupd xmm2,  oword ptr[eax+48]
     movupd xmm3,  oword ptr[edx+32]
     movupd xmm4,  oword ptr[edx+48]

     mulpd  xmm1,xmm3
     mulpd  xmm2,xmm4

     addpd  xmm1,xmm2

     addpd  xmm0,xmm1

     add    eax,64
     add    edx,64


     //haddpd xmm0,xmm0
     {movhlps  xmm1,xmm0
     addpd    xmm0,xmm1}

     addpd    xmm5,xmm0


     //add    eax,64
     dec    ecx

  jnz   @@cyclx4


  //haddpd xmm5,xmm5
  movhlps  xmm1,xmm5
  addpd   xmm5,xmm1


  sub     esp,8
  movlpd  qword ptr [esp], xmm5
  fadd    qword ptr [esp]
  add     esp,8


  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld    qword ptr [eax]
      fld    qword ptr [edx]
      fmulp  st(1),st(0)
      add    eax,8
      add    edx,8
      faddp  st(1),st(0)
      dec    cx

  jnz   @@cyclx1





@@end:


  pop   bx
  pop   ecx
  pop   edx
  pop   eax


end;





  // sumprod(vx,vy)
procedure RVE_SUMPROD_VX_VY; assembler;
asm

// DeepFPU = 5
// in:
// VX -> EAX
// VY -> EDX
// Sum (VX[i] * VY[i])

  push  eax
  push  edx
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  test edx,edx
  jz @@end
  fstp st(0)
  fldz


  mov   ecx,[eax-4]               //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:


     fld    tbyte ptr[eax]
     fld    tbyte ptr[edx]
     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+10]
     fld    tbyte ptr[edx+10]
     fmulp  st(1),st(0)


     fld    tbyte ptr[eax+20]
     fld    tbyte ptr[edx+20]
     fmulp  st(1),st(0)


     fld    tbyte ptr[eax+30]
     fld    tbyte ptr[edx+30]
     fmulp  st(1),st(0)



     faddp  st(4),st(0)
     faddp  st(2),st(0)
     faddp  st(2),st(0)
     faddp  st(1),st(0)

    {
     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)
    }

     fld    tbyte ptr[eax+40]
     fld    tbyte ptr[edx+40]
     fmulp  st(1),st(0)


     fld    tbyte ptr[eax+50]
     fld    tbyte ptr[edx+50]
     fmulp  st(1),st(0)


     fld    tbyte ptr[eax+60]
     fld    tbyte ptr[edx+60]
     fmulp  st(1),st(0)


     fld    tbyte ptr[eax+70]
     fld    tbyte ptr[edx+70]
     fmulp  st(1),st(0)


     add    eax,80
     add    edx,80

     faddp  st(4),st(0)
     faddp  st(2),st(0)
     faddp  st(2),st(0)
     faddp  st(1),st(0)

     {
     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)
     }



     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      fld   tbyte ptr [edx]
      fmulp  st(1),st(0)
      add   eax,10
      add   edx,10
      faddp st(1),st(0)
      dec   cx

  jnz   @@cyclx1





@@end:


  pop   bx
  pop   ecx
  pop   edx
  pop   eax

end;




  // sumprod(vx,vy)
procedure RVS_SUMPROD_VX_VY; assembler;
asm
// VX -> EAX
// VY -> EDX
// in:
// Sum ( VX[i]*VY[i] )


// DeepFPU = 2
  push  eax
  push  edx
  push  ecx
  push  bx

  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp
  test edx,edx
  jz @@endp
  fstp st(0)
  fldz

  PSLLDQ  xmm5,  16             //xmm5 <- ZERO ; accumulator SSE



  mov   ecx,[eax-4]               //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect

  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15

  jecxz  @@cycl1


  @@cyclx4:

     movups xmm0,  oword ptr[eax]
     movups xmm1,  oword ptr[eax+16]
     movups xmm2,  oword ptr[edx]
     movups xmm3,  oword ptr[edx+16]

     mulps  xmm0,xmm2
     mulps  xmm1,xmm3

     addps  xmm0,xmm1



     movups xmm1,  oword ptr[eax+32]
     movups xmm2,  oword ptr[eax+48]
     movups xmm3,  oword ptr[edx+32]
     movups xmm4,  oword ptr[edx+48]

     mulps  xmm1,xmm3
     mulps  xmm2,xmm4


     addps  xmm1,xmm2

     addps  xmm0,xmm1

     add    eax,64
     add    edx,64



     //hadds  in xmm0
    { movhlps  xmm1,xmm0
     addps    xmm0, xmm1
     pshuflw  xmm1,xmm0,14
     addps    xmm0, xmm1 }

     addps    xmm5, xmm0


     //add    eax,64
     dec    ecx

  jnz   @@cyclx4

   //haddps in xmm5
   movhlps  xmm1,xmm5
   addps    xmm5, xmm1
   pshuflw  xmm1,xmm5,14
   addps    xmm5, xmm1


  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz  @@endr


  @@cyclx1:

      movss  xmm0, dword ptr [eax+4*ecx-4]
      movss  xmm1, dword ptr [edx+4*ecx-4]

      mulss  xmm0,xmm1

      addss  xmm5, xmm0

      dec    cx

  jnz   @@cyclx1



@@endr:

  sub  esp,4
  movss   dword ptr [esp], xmm5
  fadd    dword ptr [esp]
  add  esp,4


@@endp:

  pop   bx
  pop   ecx
  pop   edx
  pop   eax

end;





  // sumprods(vx,x,vy,y)
procedure RVD_SUMPRODS_VX_VY; assembler;
asm
// sumprods(VX,x,VY,y)= sum( (VX[i]-x)*(VY[i]-y) )
// in:
// VX -> EAX
// VY -> EDX
// x->st(0); y->st(1)

// DeepFPU = 2
  push  eax
  push  edx
  push  ecx
  push  bx
  sub   esp,16
  fst   qword ptr [esp]   //x -> esp
  fxch  st(1)
  fst   qword ptr [esp-8] //y -> esp-8
  fxch  st(1)

  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  test edx,edx
  jz @@end
  fstp st(0)
  fldz



  PSLLDQ  xmm7,  16               //xmm7 <- ZERO ; accumulator SSE
  movddup xmm5, qword ptr[esp]    //xmm5_0,xmm5_1 <- x; expand in all xxm5
  movddup xmm6, qword ptr[esp-8]  //xmm6_0,xmm6_1 <- y; expand in all xxm6

  mov   ecx,[eax-4]                  //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect


  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7


  jecxz  @@cycl1


  @@cyclx4:

     movupd xmm0,  oword ptr[eax]
     movupd xmm1,  oword ptr [eax+16]
     subpd  xmm0,xmm5
     subpd  xmm1,xmm5

     movupd xmm2,  oword ptr[edx]
     movupd xmm3,  oword ptr [edx+16]
     subpd  xmm2,xmm6
     subpd  xmm3,xmm6

     mulpd  xmm0,xmm2
     mulpd  xmm1,xmm3
     addpd  xmm0,xmm1





     movupd xmm1,  oword ptr [eax+32]
     movupd xmm2,  oword ptr [eax+48]
     subpd  xmm1,xmm5
     subpd  xmm2,xmm5

     movupd xmm3,  oword ptr [edx+32]
     movupd xmm4,  oword ptr [edx+48]
     subpd  xmm3,xmm6
     subpd  xmm4,xmm6

     mulpd  xmm1,xmm3
     mulpd  xmm2,xmm4
     addpd  xmm1,xmm2

     addpd  xmm0,xmm1


     add    eax,64
     add    edx,64


     //haddpd xmm0,xmm0
     {movhlps  xmm1,xmm0
     addpd   xmm0,xmm1 }


     addpd  xmm7,xmm0

     dec    ecx

  jnz   @@cyclx4


  //haddpd xmm7,xmm7
  movhlps  xmm1,xmm7
  addpd   xmm7,xmm1


  movlpd  qword ptr [esp], xmm7
  fadd    qword ptr [esp]



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   qword ptr [eax]
      fsub  st(0),st(2)
      fld   qword ptr [edx]
      fsub  st(0),st(4)

      add   eax,8
      add   edx,8

      fmulp st(1),st(0)
      faddp st(1),st(0)

      dec    cx

  jnz   @@cyclx1





@@end:

  fstp  st(2)
  fstp  st(0)
  add   esp,16
  pop   bx
  pop   ecx
  pop   edx
  pop   eax

end;







    // sumprods(vx,x,vy,y)
procedure RVE_SUMPRODS_VX_VY; assembler;
asm

// sumprods(VX,x,VY,y)= sum( (VX[i]-x)*(VY[i]-y) )
// in:
// VX -> EAX
// VY -> EDX
// x->st(0); y->st(1)

  push  eax
  push  edx
  push  ecx
  push  bx


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@end
  test edx,edx
  jz @@end
  fstp st(0)
  fldz


  mov   ecx,[eax-4]                 //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect

  //mov   bx,0
  mov   bx,cx
  shr   ecx,3
  and   bx,7

  //jecxz  @@cycl1
  test ecx,ecx
  jz @@cycl1


  @@cyclx4:


     fld    tbyte ptr[eax]
     fsub   st(0),st(2)
     fld    tbyte ptr[edx]
     fsub   st(0),st(4)

     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+10]
     fsub   st(0),st(3)
     fld    tbyte ptr[edx+10]
     fsub   st(0),st(5)

     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+20]
     fsub   st(0),st(4)
     fld    tbyte ptr[edx+20]
     fsub   st(0),st(6)

     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+30]
     fsub   st(0),st(5)
     fld    tbyte ptr[edx+30]
     fsub   st(0),st(7)

     fmulp  st(1),st(0)

     faddp  st(4),st(0)
     faddp  st(2),st(0)
     faddp  st(2),st(0)
     faddp  st(1),st(0)


     {
     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)
     }

     fld    tbyte ptr[eax+40]
     fsub   st(0),st(2)
     fld    tbyte ptr[edx+40]
     fsub   st(0),st(4)

     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+50]
     fsub   st(0),st(3)
     fld    tbyte ptr[edx+50]
     fsub   st(0),st(5)

     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+60]
     fsub   st(0),st(4)
     fld    tbyte ptr[edx+60]
     fsub   st(0),st(6)

     fmulp  st(1),st(0)

     fld    tbyte ptr[eax+70]
     fsub   st(0),st(5)
     fld    tbyte ptr[edx+70]
     fsub   st(0),st(7)

     fmulp  st(1),st(0)



     add    eax,80
     add    edx,80

     faddp  st(4),st(0)
     faddp  st(2),st(0)
     faddp  st(2),st(0)
     faddp  st(1),st(0)

     {
     faddp  st(2),st(0)
     faddp  st(3),st(0)
     faddp  st(1),st(0)
     faddp  st(1),st(0)
     }



     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   tbyte ptr [eax]
      fsub  st(0),st(2)
      fld   tbyte ptr [edx]
      fsub  st(0),st(4)

      add   eax,10
      add   edx,10

      fmulp st(1),st(0)
      faddp st(1),st(0)

      dec   cx

  jnz   @@cyclx1





@@end:


  fstp  st(2)
  fstp  st(0)
  pop   bx
  pop   ecx
  pop   edx
  pop   eax


end;





   // sumprods(vx,x,vy,y)
procedure RVS_SUMPRODS_VX_VY; assembler;
asm
// sumprods(VX,x,VY,y)= sum( (VX[i]-x)*(VY[i]-y) )
// in:
// VX -> EAX
// VY -> EDX
// x->st(0); y->st(1)

// DeepFPU = 2
  push  eax
  push  edx
  push  ecx
  push  bx

  sub    esp,8
  fstp   dword ptr [esp]   //x -> esp
  fstp   dword ptr [esp-4] //y -> esp-4


  //fldz
  fld tbyte ptr [RetValOnNil]

  test eax,eax
  jz @@endp
  test edx,edx
  jz @@endp
  fstp st(0)
  fldz



  PSLLDQ  xmm7,  16               //xmm7 <- ZERO ; accumulator SSE

  movss  xmm5,  dword ptr[esp]
  shufps xmm5,xmm5,0;        //xmm5 <- x; expand in all xxm5

  movss  xmm6,  dword ptr[esp-4]
  shufps xmm6,xmm6,0;        //xmm6 <- x; expand in all xxm6

  mov   ecx,[eax-4]           //  ECX - Length of array

  {.357}
  add ecx,c_DinArrayLenCorrect



  //mov   bx,0
  mov   bx,cx
  shr   ecx,4
  and   bx,15


  jecxz  @@cycl1


  @@cyclx4:

     movups xmm0,  oword ptr[eax]
     movups xmm1,  oword ptr [eax+16]
     subps  xmm0,xmm5
     subps  xmm1,xmm5

     movups xmm2,  oword ptr[edx]
     movups xmm3,  oword ptr [edx+16]
     subps  xmm2,xmm6
     subps  xmm3,xmm6

     mulps  xmm0,xmm2
     mulps  xmm1,xmm3
     addps  xmm0,xmm1





     movups xmm1,  oword ptr [eax+32]
     movups xmm2,  oword ptr [eax+48]
     subps  xmm1,xmm5
     subps  xmm2,xmm5

     movups xmm3,  oword ptr [edx+32]
     movups xmm4,  oword ptr [edx+48]
     subps  xmm3,xmm6
     subps  xmm4,xmm6

     mulps  xmm1,xmm3
     mulps  xmm2,xmm4
     addps  xmm1,xmm2

     addps  xmm0,xmm1


     add    eax,64
     add    edx,64


     //hadds  in xmm0
     {movhlps  xmm1,xmm0
     addps    xmm0, xmm1
     pshuflw  xmm1,xmm0,14
     addps    xmm0, xmm1}


     addps  xmm7,xmm0

     dec    ecx

  jnz   @@cyclx4


  //haddps in xmm7
   movhlps  xmm1,xmm7
   addps    xmm7, xmm1
   pshuflw  xmm1,xmm7,14
   addps    xmm7, xmm1


  @@cycl1:

   xor   ecx,ecx
   mov   cx,bx
   jcxz  @@endr


  @@cyclx1:

      movss  xmm0, dword ptr [eax+4*ecx-4]
      subss  xmm0,xmm5
      movss  xmm1, dword ptr [edx+4*ecx-4]
      subss  xmm1,xmm6

      mulss  xmm0,xmm1
      addss  xmm7,xmm0


      dec    cx

  jnz   @@cyclx1



 @@endr:

     movss   dword ptr [esp], xmm7
     fadd    dword ptr [esp]

@@endp:


  add   esp,8
  pop   bx
  pop   ecx
  pop   edx
  pop   eax


end;



procedure RVD_SUMQS2V(VX,VY: TArrayD); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+20]


  call RVD_SUMQS_VX_VY

  pop edx
  pop eax

end;




procedure RVE_SUMQS2V(VX,VY: TArrayE); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+20]


  call RVE_SUMQS_VX_VY

  pop edx
  pop eax

end;




procedure RVS_SUMQS2V(VX,VY: TArrayS); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+20]


  call RVS_SUMQS_VX_VY

  pop edx
  pop eax

end;




procedure RVD_SUMPROD2V(VX,VY: TArrayD); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+20]


  call RVD_SUMPROD_VX_VY

  pop edx
  pop eax

end;




procedure RVE_SUMPROD2V(VX,VY: TArrayE); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+20]


  call RVE_SUMPROD_VX_VY

  pop edx
  pop eax

end;




procedure RVS_SUMPROD2V(VX,VY: TArrayS); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+20]


  call RVS_SUMPROD_VX_VY

  pop edx
  pop eax

end;




procedure RVD_SUMPRODS2V(VX: TArrayD; x: double;   VY: TArrayD; y: double); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+28]

  fld  y
  fld  x

  call RVD_SUMPRODS_VX_VY

  pop edx
  pop eax

end;




procedure RVE_SUMPRODS2V(VX: TArrayE; x: extended; VY: TArrayE; y: extended); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+32]

  fld  y
  fld  x

  call RVE_SUMPRODS_VX_VY

  pop edx
  pop eax

end;




procedure RVS_SUMPRODS2V(VX: TArrayS; x: single;   VY: TArrayS; y: single); stdcall;
asm
  push eax
  push edx

  mov  eax,[esp+16]
  mov  edx,[esp+24]

  fld  y
  fld  x

  call RVS_SUMPRODS_VX_VY

  pop edx
  pop eax

end;












function RV_GCD(pv: Pointer; tv: Integer): extended; stdcall;
label lp,endp;
var
  i,n:Integer;
  S: Extended;
  u,v,t,r,len,Si: longint;
  ve: TArrayE absolute pv;
  vd: TArrayD absolute pv;
  vs: TArrayS absolute pv;
  vi: TArrayI absolute pv;

begin

//len:=Length(VD);
len:=_Length(pv); {.357}
// n:=PInteger(PInteger(va)^-4)^+c_DinArrayLenCorrect;

if len = 0  then S:=RetValOnNil else
if len = 1  then
begin
   //max speed for integer
  if tv = _Integer  then S := vi[0]
     else
  if tv = _Double   then S := vd[0]
     else
  if tv = _Extended then S := ve[0]
     else
  if tv = _Single   then S := vs[0];
end
else
begin
  n:=1;

  //max speed for integer
  if tv = _Integer  then begin u:=vi[0];        v:=vi[1]; end
     else
  if tv = _Double   then begin u:=Trunc(vd[0]); v:=Trunc(vd[1]); end
     else
  if tv = _Extended then begin u:=Trunc(ve[0]); v:=Trunc(ve[1]); end
     else
  if tv = _Single   then begin u:=Trunc(vs[0]); v:=Trunc(vs[1]); end;

  {u:=Trunc(VD[0]);
  v:=Trunc(VD[1]); }

//S := abs(u);   Si := abs(u);   //len<=2

lp:
  while v <> 0 do
  begin
    t := u;
    u := v;
    v := t mod v;
  end;

  //S := abs(u);   Si := abs(u);
  inc(n);
  if n > len-1 then begin  S := abs(u);   {Si := abs(u); }goto endp  end
  else
  begin
    //v:=Trunc(S);
    //u:=Trunc(VD[n]);

    //max speed for integer
    if tv = _Integer  then begin   Si := abs(u); v:=Si; u:=vi[n]; end
     else
    if tv = _Double   then begin   S := abs(u); v:=Trunc(S); u:=Trunc(vd[n]); end
     else
    if tv = _Extended then begin   S := abs(u); v:=Trunc(S); u:=Trunc(ve[n]); end
     else
    if tv = _Single   then begin   S := abs(u); v:=Trunc(S); u:=Trunc(vs[n]); end;

    goto lp;
  end;

end;

endp:
  //if tv = _Integer then RV_GCD:=Si else RV_GCD:=S;
  RV_GCD:=S;
end;




function RV_LCM(pv: Pointer; tv: Integer): extended; stdcall;
label lp,endp;
var
  i,n:Integer;
  S: Extended;
  u,v,u1,v1,t,r,len,Si: longint;
  ve: TArrayE absolute pv;
  vd: TArrayD absolute pv;
  vs: TArrayS absolute pv;
  vi: TArrayI absolute pv;
begin

//len:=Length(VD);
len:=_Length(pv); {.357}
// n:=PInteger(PInteger(va)^-4)^+c_DinArrayLenCorrect;


if len = 0  then S:=RetValOnNil else
if len = 1  then
begin
   //max speed for integer
  if tv = _Integer  then S := vi[0]
     else
  if tv = _Double   then S := vd[0]
     else
  if tv = _Extended then S := ve[0]
     else
  if tv = _Single   then S := vs[0];
end
else
begin
  n:=1;
  {u:=Trunc(VD[0]);
  v:=Trunc(VD[1]);}

  //max speed for integer
  if tv = _Integer  then begin u:=vi[0];        v:=vi[1]; end
     else
  if tv = _Double   then begin u:=Trunc(vd[0]); v:=Trunc(vd[1]); end
     else
  if tv = _Extended then begin u:=Trunc(ve[0]); v:=Trunc(ve[1]); end
     else
  if tv = _Single   then begin u:=Trunc(vs[0]); v:=Trunc(vs[1]); end;


S := abs(u);   Si := abs(u);   //len<=2

lp:
  u1:=u; v1:=v;

  while v <> 0 do
  begin
    t := u;
    u := v;
    v := t mod v;
  end;

  u:=(u1*v1) div abs(u);

  //S := u;
  inc(n);
  if n > len-1 then begin S:=(u); goto endp   end
  else
  begin
    {v:=Trunc(S);
    u:=Trunc(VD[n]); }

    //max speed for integer
    if tv = _Integer  then begin   Si := (u); v:=Si; u:=vi[n]; end
     else
    if tv = _Double   then begin   S := (u); v:=Trunc(S); u:=Trunc(vd[n]); end
     else
    if tv = _Extended then begin   S := (u); v:=Trunc(S); u:=Trunc(ve[n]); end
     else
    if tv = _Single   then begin   S := (u); v:=Trunc(S); u:=Trunc(vs[n]); end;

    goto lp;
  end;

end;

endp:
 //if tv = _Integer then  RV_LCM:=Si else  RV_LCM:=S;
  RV_LCM:=S;
end;





//*********************************************************** POLYNOMS (begin) **************************************************************************************


//  parallel Horner's scheme      {.393}
procedure RVE_POLY; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//vec - Extended Array; x - real

//in:
//EAX <-  @Array[0]
//ST(0)<- X

asm

     //push  ecx
     push  ebx
     //push  eax


     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@endp
     fstp  st(0)
     fldz

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     test ecx,ecx
     jz @@end
     fstp st

     cmp   ecx,4
     jnl  @@Poly   // P >= 4



     fld   tbyte ptr [eax]     //A[0]
     dec   ecx
     jz    @@endp   //P=1: A[0]
     fld   tbyte ptr [eax+10]
     fmul  st(0),st(2)
     faddp st(1),st(0)
     dec   ecx
     jz    @@endp   //P=2: A[1]*x+A[0]
     fxch  st(1)
     fmul  st(0),st(0)
     fld   tbyte ptr [eax+20]
     fmulp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end    //P=3: A[2]*x^2+A[1]*x+A[0]


  @@Poly:
     fld   st(0)
     fmul  st(0),st(0)  // x^2,x
     mov   ebx, ecx
     sub   ebx,1 //ebx=high(Array) = Len-1
     test  ecx,1
     jnz   @@OddArray  // нечёт Array,  чёт  Poly

     // чёт Array,  нечёт Poly
     sub   ecx,2   //A[1]*x+A[0]    - оcтаток
     shr   ecx,1
     lea   ebx,[ebx+4*ebx]
     lea   ebx,[eax+2*ebx]
     fldz
     fldz
     fxch  st(2)
   @@cyclx2_evenArray:
      fld   tbyte ptr [ebx-10]   // A[n-1]
      faddp st(3),st(0)
      fld   tbyte ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,20
      dec   ecx
     jnz   @@cyclx2_evenArray

     //x^2,S1,S0,x
     fstp  st(0)
     fmul  st(0),st(2)       // S1*x
     faddp st(1),st(0)
     // S, x
     // +   A[1]*x+A[0]
     fld   tbyte ptr [eax+10]     // A[1],S,x
     fmulp st(2),st(0)
     fld   tbyte ptr [eax]
     faddp st(1),st(0)  // S+A[0],  A[1]*x
     faddp st(1),st(0)
     jmp   @@end



     //нечёт Array,  чёт Poly
  @@OddArray:
     sub   ecx,3   //A[2]*x^2+A[1]*x+A[0]  - остаток
     shr   ecx,1

     lea   ebx,[ebx+4*ebx]
     lea   ebx,[eax+2*ebx]
     fldz
     fldz
     fxch  st(2)
  @@cyclx2_OddArray:
      fld   tbyte ptr [ebx-10]   // A[n-1]
      faddp st(3),st(0)
      fld   tbyte ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,20
      dec   ecx
     jnz   @@cyclx2_OddArray

     //x^2,S0,S1,x
     fmul  st(1),st(0)       //S0*x^2
     fxch  st(3)
     //x,S0,S1,x^2
     fmul  st(2),st(0)    //S1*x
     // S, x
     // +   A[2]*x^2+A[1]*x+A[0]
     fld   tbyte ptr [eax+10]     // A[1],x,S0,S1,x^2
     fmulp st(1),st(0)           // A[1]*x,S0,S1,x^2
     fld   tbyte ptr [eax+20]
     fmulp st(4),st(0)           // A[1]*x,S0,S1,A[2]*x^2
     fld   tbyte ptr [eax]
     faddp st(1),st(0)           // A[1]*x+A[0],S0,S1,A[2]*x^2
     faddp st(3),st(0)
     faddp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end




 @@endp:
     fstp  st(1)

 @@end:
     //pop   eax
     pop   ebx
     //pop   ecx


end;






//  parallel Horner's scheme           {.393}
procedure RVD_POLY; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//vec - Double Array; x - real

//in:
//EAX <-  @Array[0]
//ST(0)<- X

asm

     //push  ecx
     push  ebx
     //push  eax


     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@endp
     fstp  st(0)
     fldz

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     test ecx,ecx
     jz @@end
     fstp st


     cmp   ecx,4
     jnl  @@Poly   // P >= 4



     fld   qword ptr [eax]     //A[0]
     dec   ecx
     jz    @@endp   //P=1: A[0]
     fld   qword ptr [eax+8]
     fmul  st(0),st(2)
     faddp st(1),st(0)
     dec   ecx
     jz    @@endp   //P=2: A[1]*x+A[0]
     fxch  st(1)
     fmul  st(0),st(0)
     fld   qword ptr [eax+16]
     fmulp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end    //P=3: A[2]*x^2+A[1]*x+A[0]


  @@Poly:
     fld   st(0)
     fmul  st(0),st(0)  // x^2,x
     mov   ebx, ecx
     sub   ebx,1 //ebx=high(Array) = Len-1
     test  ecx,1
     jnz   @@OddArray  // нечёт Array,  чёт  Poly

     // чёт Array,  нечёт Poly
     sub   ecx,2   //A[1]*x+A[0]    - оcтаток
     shr   ecx,1
     lea   ebx,[eax+8*ebx]
     fldz
     fldz
     fxch  st(2)
   @@cyclx2_evenArray:
      fld   qword ptr [ebx-8]   // A[n-1]
      faddp st(3),st(0)
      fld   qword ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,16
      dec   ecx
     jnz   @@cyclx2_evenArray

     //x^2,S1,S0,x
     fstp  st(0)
     fmul  st(0),st(2)       // S1*x
     faddp st(1),st(0)
     // S, x
     // +   A[1]*x+A[0]
     fld   qword ptr [eax+8]     // A[1],S,x
     fmulp st(2),st(0)
     fld   qword ptr [eax]
     faddp st(1),st(0)  // S+A[0],  A[1]*x
     faddp st(1),st(0)
     jmp   @@end



     //нечёт Array,  чёт Poly
  @@OddArray:
     sub   ecx,3   //A[2]*x^2+A[1]*x+A[0]  - остаток
     shr   ecx,1

     lea   ebx,[eax+8*ebx]
     fldz
     fldz
     fxch  st(2)
  @@cyclx2_OddArray:

      fld   qword ptr [ebx-8]   // A[n-1]
      faddp st(3),st(0)
      fld   qword ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,16
      dec   ecx
     jnz   @@cyclx2_OddArray

     //x^2,S0,S1,x
     fmul  st(1),st(0)       //S0*x^2
     fxch  st(3)
     //x,S0,S1,x^2
     fmul  st(2),st(0)    //S1*x
     // S, x
     // +   A[2]*x^2+A[1]*x+A[0]
     fld   qword ptr [eax+8]     // A[1],x,S0,S1,x^2
     fmulp st(1),st(0)           // A[1]*x,S0,S1,x^2
     fld   qword ptr [eax+16]
     fmulp st(4),st(0)           // A[1]*x,S0,S1,A[2]*x^2
     fld   qword ptr [eax]
     faddp st(1),st(0)           // A[1]*x+A[0],S0,S1,A[2]*x^2
     faddp st(3),st(0)
     faddp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end




 @@endp:
     fstp  st(1)

 @@end:
     //pop   eax
     pop   ebx
     //pop   ecx


end;




//  parallel Horner's scheme               {.393}
procedure RVS_POLY; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//vec - Single Array; x - real

//in:
//EAX <-  @Array[0]
//ST(0)<- X

asm

     //push  ecx
     push  ebx
     //push  eax


     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@endp
     fstp  st(0)
     fldz

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     test ecx,ecx
     jz @@end
     fstp st


     cmp   ecx,4
     jnl  @@Poly   // P >= 4



     fld   dword ptr [eax]     //A[0]
     dec   ecx
     jz    @@endp   //P=1: A[0]
     fld   dword ptr [eax+4]
     fmul  st(0),st(2)
     faddp st(1),st(0)
     dec   ecx
     jz    @@endp   //P=2: A[1]*x+A[0]
     fxch  st(1)
     fmul  st(0),st(0)
     fld   dword ptr [eax+8]
     fmulp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end    //P=3: A[2]*x^2+A[1]*x+A[0]


  @@Poly:
     fld   st(0)
     fmul  st(0),st(0)  // x^2,x
     mov   ebx, ecx
     sub   ebx,1 //ebx=high(Array) = Len-1
     test  ecx,1
     jnz   @@OddArray  // нечёт Array,  чёт  Poly

     // чёт Array,  нечёт Poly
     sub   ecx,2   //A[1]*x+A[0]    - оcтаток
     shr   ecx,1
     lea   ebx,[eax+4*ebx]
     fldz
     fldz
     fxch  st(2)
   @@cyclx2_evenArray:
      fld   dword ptr [ebx-4]   // A[n-1]
      faddp st(3),st(0)
      fld   dword ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,8
      dec   ecx
     jnz   @@cyclx2_evenArray

     //x^2,S1,S0,x
     fstp  st(0)
     fmul  st(0),st(2)       // S1*x
     faddp st(1),st(0)
     // S, x
     // +   A[1]*x+A[0]
     fld   dword ptr [eax+4]     // A[1],S,x
     fmulp st(2),st(0)
     fld   dword ptr [eax]
     faddp st(1),st(0)  // S+A[0],  A[1]*x
     faddp st(1),st(0)
     jmp   @@end



     //нечёт Array,  чёт Poly
  @@OddArray:
     sub   ecx,3   //A[2]*x^2+A[1]*x+A[0]  - остаток
     shr   ecx,1

     lea   ebx,[eax+4*ebx]
     fldz
     fldz
     fxch  st(2)
  @@cyclx2_OddArray:

      fld   dword ptr [ebx-4]   // A[n-1]
      faddp st(3),st(0)
      fld   dword ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,8
      dec   ecx
     jnz   @@cyclx2_OddArray

     //x^2,S0,S1,x
     fmul  st(1),st(0)       //S0*x^2
     fxch  st(3)
     //x,S0,S1,x^2
     fmul  st(2),st(0)    //S1*x
     // S, x
     // +   A[2]*x^2+A[1]*x+A[0]
     fld   dword ptr [eax+4]     // A[1],x,S0,S1,x^2
     fmulp st(1),st(0)           // A[1]*x,S0,S1,x^2
     fld   dword ptr [eax+8]
     fmulp st(4),st(0)           // A[1]*x,S0,S1,A[2]*x^2
     fld   dword ptr [eax]
     faddp st(1),st(0)           // A[1]*x+A[0],S0,S1,A[2]*x^2
     faddp st(3),st(0)
     faddp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end




 @@endp:
     fstp  st(1)

 @@end:
     //pop   eax
     pop   ebx
     //pop   ecx


end;





//  parallel Horner's scheme              {.393}
procedure RVI_POLY; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//vec - Integer Array; x - real

//in:
//EAX <-  @Array[0]
//ST(0)<- X

asm

     //push  ecx
     push  ebx
     //push  eax


     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@endp
     fstp  st(0)
     fldz

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     test ecx,ecx
     jz @@end
     fstp st


     cmp   ecx,4
     jnl  @@Poly   // P >= 4



     fild   dword ptr [eax]     //A[0]
     dec   ecx
     jz    @@endp   //P=1: A[0]
     fild   dword ptr [eax+4]
     fmul  st(0),st(2)
     faddp st(1),st(0)
     dec   ecx
     jz    @@endp   //P=2: A[1]*x+A[0]
     fxch  st(1)
     fmul  st(0),st(0)
     fild   dword ptr [eax+8]
     fmulp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end    //P=3: A[2]*x^2+A[1]*x+A[0]


  @@Poly:
     fld   st(0)
     fmul  st(0),st(0)  // x^2,x
     mov   ebx, ecx
     sub   ebx,1 //ebx=high(Array) = Len-1
     test  ecx,1
     jnz   @@OddArray  // нечёт Array,  чёт  Poly

     // чёт Array,  нечёт Poly
     sub   ecx,2   //A[1]*x+A[0]    - оcтаток
     shr   ecx,1
     lea   ebx,[eax+4*ebx]
     fldz
     fldz
     fxch  st(2)
   @@cyclx2_evenArray:
      fild   dword ptr [ebx-4]   // A[n-1]
      faddp st(3),st(0)
      fild   dword ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,8
      dec   ecx
     jnz   @@cyclx2_evenArray

     //x^2,S1,S0,x
     fstp  st(0)
     fmul  st(0),st(2)       // S1*x
     faddp st(1),st(0)
     // S, x
     // +   A[1]*x+A[0]
     fild   dword ptr [eax+4]     // A[1],S,x
     fmulp st(2),st(0)
     fild   dword ptr [eax]
     faddp st(1),st(0)  // S+A[0],  A[1]*x
     faddp st(1),st(0)
     jmp   @@end



     //нечёт Array,  чёт Poly
  @@OddArray:
     sub   ecx,3   //A[2]*x^2+A[1]*x+A[0]  - остаток
     shr   ecx,1

     lea   ebx,[eax+4*ebx]
     fldz
     fldz
     fxch  st(2)
  @@cyclx2_OddArray:

      fild   dword ptr [ebx-4]   // A[n-1]
      faddp st(3),st(0)
      fild   dword ptr [ebx]      // A[n]
      faddp st(2),st(0)
      fmul  st(2),st(0)
      fmul  st(1),st(0)
      sub   ebx,8
      dec   ecx
     jnz   @@cyclx2_OddArray

     //x^2,S0,S1,x
     fmul  st(1),st(0)       //S0*x^2
     fxch  st(3)
     //x,S0,S1,x^2
     fmul  st(2),st(0)    //S1*x
     // S, x
     // +   A[2]*x^2+A[1]*x+A[0]
     fild   dword ptr [eax+4]     // A[1],x,S0,S1,x^2
     fmulp st(1),st(0)           // A[1]*x,S0,S1,x^2
     fild   dword ptr [eax+8]
     fmulp st(4),st(0)           // A[1]*x,S0,S1,A[2]*x^2
     fild   dword ptr [eax]
     faddp st(1),st(0)           // A[1]*x+A[0],S0,S1,A[2]*x^2
     faddp st(3),st(0)
     faddp st(1),st(0)
     faddp st(1),st(0)
     jmp   @@end




 @@endp:
     fstp  st(1)

 @@end:
     //pop   eax
     pop   ebx
     //pop   ecx

end;



  (*
 // Old version, sequent Horner's scheme
procedure RV_POLY; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx

     mov   esi,ebx
     //mov   eax, [eax]


     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@end
     fstp  st(0)
     fldz

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect

     jecxz @@end
     fstp st


     mov   ebx,ecx
     sub   ebx,1      //ebx <- Len-1

      //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@cycl1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sgn
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@cycl1
  @@1sgn:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@cycl1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int


  @@cycl1:
     sub   ecx,1
     jle   @@end
     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]


 @@cycl:
     fmul st(0),st(1)   //s*x

      //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@lext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@sum
   @@lext:
     cmp   esi,_Extended // _Extended
     jnz   @@lsgn
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@sum
  @@lsgn:
     cmp   esi,_Single  //_Single
     jnz   @@lint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@sum
  @@lint:
     fild  dword ptr [ebx]     //load int


  @@sum:
     faddp


     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     jnz   @@cycl


 @@end:
     fstp  st(1)
     pop   edx
     pop   ecx
     pop   esi
end;



 *)


 //sequent Horner's scheme
procedure CxV_POLY; assembler;
//polynom(vec,z)=vec[n]*z^(n)+...+vec[1]*z+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*z+vec[n-1])*z+vec[n-2])*z+vec[n-3])*z+...)*z+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx

     mov   esi,ebx
     //mov   eax, [eax]

     //fldz
     //fldz
     fld tbyte ptr [RetValOnNil]
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]

     {.357}
     add ecx,c_DinArrayLenCorrect
     {$IFDEF FPC}
     //add ecx,1
     {$ENDIF}

     //jecxz @@end   //Error in Delphi! E2120
     test ecx,ecx
     jz @@end
     fstp st
     fstp st


     mov   ebx,ecx
     sub   ebx,1      //ebx <- Len-1

     fldz  //0 -> Im

     //load vec[n]
     //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@cycl1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sng
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@cycl1
  @@1sng:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@cycl1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int


  @@cycl1:
     sub   ecx,1
     jle   @@end
     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]


 @@cycl:

     //S*z
     fld   st(0)
     fmul  st(0),st(3)
     fxch  st(1)
     fmul  st(0),st(4)
     fxch  st(2)
     fld   st(0)
     fmul  st(0),st(5)
     fsubp st(2),st(0)
     fmul  st(0),st(3)
     faddp st(2),st(0)

     //load vec[ebx]

     //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@lext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@sum
   @@lext:
     cmp   esi,_Extended // _Extended
     jnz   @@lsng
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@sum
  @@lsng:
     cmp   esi,_Single  //_Single
     jnz   @@lint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@sum
  @@lint:
     fild  dword ptr [ebx]     //load int


  @@sum:
     faddp


     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     jnz   @@cycl


 @@end:
     fstp st(2)
     fstp st(2)
     pop   edx
     pop   ecx
     pop   esi

end;



//  sequent Horner's scheme
procedure RV_POLYDIFF1; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx

     mov   esi,ebx
     //mov   eax, [eax]

     //fldz
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jz   @@end

     cmp ecx,$1
     jz @@end

     fstp st


     mov   ebx,ecx
     sub   ebx,1      //ebx <- Len-1

      //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@cycl1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sgn
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@cycl1
  @@1sgn:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@cycl1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int


  @@cycl1:
     //sub   ecx,1
     dec   ecx
     jecxz @@end

     push ecx
     fild [esp]
     pop  ecx
     fmulp

     dec  ecx
     jz   @@end
     //cmp ecx,$0
     //jz @@end

     //jle   @@end
     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]


 @@cycl:
     fmul st(0),st(1)   //s*x

      //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@lext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@sum
   @@lext:
     cmp   esi,_Extended // _Extended
     jnz   @@lsgn
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@sum
  @@lsgn:
     cmp   esi,_Single  //_Single
     jnz   @@lint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@sum
  @@lint:
     fild  dword ptr [ebx]     //load int


  @@sum:
     push ecx
     fild [esp]
     pop  ecx
     fmulp

     faddp


     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     jnz   @@cycl


 @@end:
     fstp  st(1)
     pop   edx
     pop   ecx
     pop   esi
end;








 //  sequent Horner's scheme
procedure RV_POLYDIFF2; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx


     mov   esi,ebx
     //mov   eax, [eax]

     //fldz
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jz   @@end

     cmp ecx,$2
     jle @@end

     fstp st

     dec  ecx
     mov  ebx,ecx
     //sub  ebx,edx


      //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@L1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sgn
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@L1
  @@1sgn:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@L1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int





  @@L1:
     //dec     ecx
     jecxz    @@end

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     add esp, 8

     {mov  eax,ecx
     push eax
     fild [esp]
     sub  eax,1
     fmulp
     push eax
     fild [esp]
     fmulp
     add esp, 8}



     //sub   ecx,1
    // dec   ecx
    // jecxz @@end


     dec  ecx
     cmp  ecx,1
     jz   @@end

     sub   ebx,edx  // vec[L-2] down to vec[0]


 @@cycl:
     fmul st(0),st(1)   //s*x

      //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@cext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@csum
   @@cext:
     cmp   esi,_Extended // _Extended
     jnz   @@csgn
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@csum
  @@csgn:
     cmp   esi,_Single  //_Single
     jnz   @@cint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@csum
  @@cint:
     fild  dword ptr [ebx]     //load int


  @@csum:

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     add esp, 8

     {mov  eax,ecx
     push eax
     fild [esp]
     sub  eax,1
     fmulp
     push eax
     fild [esp]
     fmulp
     add esp, 8}

     faddp

     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     cmp   ecx,1
     jnz   @@cycl


 @@end:
     fstp  st(1)
     pop   edx
     pop   ecx
     pop   esi
end;






 //  sequent Horner's scheme
procedure RV_POLYDIFF3; assembler;
//polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*x+vec[n-2])*x+vec[n-3])*x+...)*x+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx


     mov   esi,ebx
     //mov   eax, [eax]

     //fldz
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jz   @@end

     cmp ecx,$3
     jle @@end

     fstp st

     dec  ecx
     mov  ebx,ecx
     //sub  ebx,edx


      //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@L1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sgn
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@L1
  @@1sgn:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@L1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int





  @@L1:
     //dec     ecx
     jecxz    @@end

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     fild [esp+8]
     fmulp
     add esp, 12

  



     //sub   ecx,1
    // dec   ecx
    // jecxz @@end


     dec  ecx
     cmp  ecx,2
     jz   @@end

     sub   ebx,edx  // vec[L-2] down to vec[0]


 @@cycl:
     fmul st(0),st(1)   //s*x

      //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@cext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@csum
   @@cext:
     cmp   esi,_Extended // _Extended
     jnz   @@csgn
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@csum
  @@csgn:
     cmp   esi,_Single  //_Single
     jnz   @@cint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@csum
  @@cint:
     fild  dword ptr [ebx]     //load int


  @@csum:

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     fild [esp+8]
     fmulp
     add esp, 12

     

     faddp

     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     cmp   ecx,2
     jnz   @@cycl


 @@end:
     fstp  st(1)
     pop   edx
     pop   ecx
     pop   esi
end;





 //  sequent Horner's scheme
procedure CxV_POLYDIFF1; assembler;
//polynom(vec,z)=vec[n]*z^(n)+...+vec[1]*z+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*x+vec[n-1])*z+vec[n-2])*z+vec[n-3])*z+...)*z+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx

     mov   esi,ebx
     //mov   eax, [eax]

     //fldz
     //fldz
     fld tbyte ptr [RetValOnNil]
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jz   @@end

     cmp ecx,$1
     jz @@end

     fstp st
     fstp st


     mov   ebx,ecx
     sub   ebx,1      //ebx <- Len-1

     fldz  //0 -> Im

      //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@cycl1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sgn
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@cycl1
  @@1sgn:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@cycl1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int


  @@cycl1:
     //sub   ecx,1
     dec   ecx
     jecxz @@end

     push ecx
     fild [esp]
     pop  ecx
     fmulp

     dec  ecx
     jz   @@end
     //cmp ecx,$0
     //jz @@end

     //jle   @@end
     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]


 @@cycl:
      //S*z
     fld   st(0)
     fmul  st(0),st(3)
     fxch  st(1)
     fmul  st(0),st(4)
     fxch  st(2)
     fld   st(0)
     fmul  st(0),st(5)
     fsubp st(2),st(0)
     fmul  st(0),st(3)
     faddp st(2),st(0)


      //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@lext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@sum
   @@lext:
     cmp   esi,_Extended // _Extended
     jnz   @@lsgn
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@sum
  @@lsgn:
     cmp   esi,_Single  //_Single
     jnz   @@lint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@sum
  @@lint:
     fild  dword ptr [ebx]     //load int


  @@sum:
     push ecx
     fild [esp]
     pop  ecx
     fmulp

     faddp


     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     jnz   @@cycl


 @@end:
     fstp  st(2)
     fstp  st(2)
     pop   edx
     pop   ecx
     pop   esi
end;






 //  sequent Horner's scheme
procedure CxV_POLYDIFF2; assembler;
//polynom(vec,z)=vec[n]*z^(n)+...+vec[1]*z+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*z+vec[n-1])*z+vec[n-2])*z+vec[n-3])*z+...)*z+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx


     mov   esi,ebx
     //mov   eax, [eax]

     //fldz
     //fldz
     fld tbyte ptr [RetValOnNil]
     fld tbyte ptr [RetValOnNil]

     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jz   @@end

     cmp ecx,$2
     jle @@end

     fstp st
     fstp st

     dec  ecx
     mov  ebx,ecx
     //sub  ebx,edx
     fldz  //0 -> Im


      //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@L1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sgn
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@L1
  @@1sgn:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@L1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int





  @@L1:
     //dec     ecx
     jecxz    @@end

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     add esp, 8

     {mov  eax,ecx
     push eax
     fild [esp]
     sub  eax,1
     fmulp
     push eax
     fild [esp]
     fmulp
     add esp, 8}



     //sub   ecx,1
    // dec   ecx
    // jecxz @@end


     dec  ecx
     cmp  ecx,1
     jz   @@end

     sub   ebx,edx  // vec[L-2] down to vec[0]


 @@cycl:
      //S*z
     fld   st(0)
     fmul  st(0),st(3)
     fxch  st(1)
     fmul  st(0),st(4)
     fxch  st(2)
     fld   st(0)
     fmul  st(0),st(5)
     fsubp st(2),st(0)
     fmul  st(0),st(3)
     faddp st(2),st(0)


      //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@cext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@csum
   @@cext:
     cmp   esi,_Extended // _Extended
     jnz   @@csgn
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@csum
  @@csgn:
     cmp   esi,_Single  //_Single
     jnz   @@cint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@csum
  @@cint:
     fild  dword ptr [ebx]     //load int


  @@csum:

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     add esp, 8

     {mov  eax,ecx
     push eax
     fild [esp]
     sub  eax,1
     fmulp
     push eax
     fild [esp]
     fmulp
     add esp, 8}

     faddp

     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     cmp   ecx,1
     jnz   @@cycl


 @@end:
     fstp  st(2)
     fstp  st(2)
     pop   edx
     pop   ecx
     pop   esi
end;





 //  sequent Horner's scheme
procedure CxV_POLYDIFF3; assembler;
//polynom(vec,z)=vec[n]*z^(n)+...+vec[1]*z+vec[0] ;n=Length(vec)-1
//eval as  (...(((vec[n]*z+vec[n-1])*z+vec[n-2])*z+vec[n-3])*z+...)*z+vec[0]

//in:
//EAX <- @Array[0]
//EBX<-type of array  (_Extended, _Double, _Single, _Integer)


//EBX - Addr  of current element
//ECX - Length of array
//EDX - Cell Size
//ESI - type of array
asm
     push  esi
     push  ecx
     push  edx


     mov   esi,ebx
     //mov   eax, [eax]

     //fldz
     //fldz
     fld tbyte ptr [RetValOnNil]
     fld tbyte ptr [RetValOnNil]
     test eax,eax
     jz @@end

     mov   ebx,eax
     mov   ecx,[eax-4]
     {.357}
     add ecx,c_DinArrayLenCorrect
     (*
     {$IFDEF FPC}
     add ecx,1
     {$ENDIF}
     *)
     jz   @@end

     cmp ecx,$3
     jle @@end

     fstp st
     fstp st

     dec  ecx
     mov  ebx,ecx
     //sub  ebx,edx
     fldz  //0 -> Im


      //max speed for double
     cmp   esi,_Double    //_Double
     jnz   @@1ext
     lea   ebx, [eax+8*ebx]  //ebx <- @vec[Len-1]
     mov   edx,8   //size dbl
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@L1
  @@1ext:
     cmp   esi,_Extended // _Extended
     jnz   @@1sgn
     lea   edx,[ebx+4*ebx]
     lea   ebx,[eax+2*edx] //ebx <- @vec[Len-1]
     mov   edx,10   //size ext
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@L1
  @@1sgn:
     cmp   esi,_Single  //_Single
     jnz   @@1int
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     mov   edx,4   //size sng
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@L1
  @@1int:
     lea   ebx, [eax+4*ebx]  //ebx <- @vec[Len-1]
     fild  dword ptr [ebx]  //load int
     mov   edx,4   //size int





  @@L1:

     //jecxz @@end   //Error in Delphi! E2120
     test ecx,ecx
     jz @@end

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     fild [esp+8]
     fmulp
     add esp, 12





     //sub   ecx,1
    // dec   ecx
    // jecxz @@end


     dec  ecx
     cmp  ecx,2
     jz   @@end

     sub   ebx,edx  // vec[L-2] down to vec[0]


 @@cycl:
      //S*z
     fld   st(0)
     fmul  st(0),st(3)
     fxch  st(1)
     fmul  st(0),st(4)
     fxch  st(2)
     fld   st(0)
     fmul  st(0),st(5)
     fsubp st(2),st(0)
     fmul  st(0),st(3)
     faddp st(2),st(0)


      //max speed for double
     cmp   esi,_Double   //_Double
     jnz   @@cext
     fld   qword  ptr [ebx]    //load dbl
     jmp   @@csum
   @@cext:
     cmp   esi,_Extended // _Extended
     jnz   @@csgn
     fld   tbyte ptr [ebx]  //load ext
     jmp   @@csum
  @@csgn:
     cmp   esi,_Single  //_Single
     jnz   @@cint
     fld   dword  ptr [ebx]    //load sgn
     jmp   @@csum
  @@cint:
     fild  dword ptr [ebx]     //load int


  @@csum:

     mov  eax,ecx
     push eax
     sub  eax,1
     push eax
     sub  eax,1
     push eax
     fild [esp]
     fmulp
     fild [esp+4]
     fmulp
     fild [esp+8]
     fmulp
     add esp, 12



     faddp

     //add   ebx,edx
     sub   ebx,edx  // vec[L-1] down to vec[0]
     dec   ecx
     cmp   ecx,2
     jnz   @@cycl


 @@end:
     fstp  st(2)
     fstp  st(2)
     pop   edx
     pop   ecx
     pop   esi
end;






//***********************************************************POLYNOMS (asm) (end)**************************************************************************************




{ *****************************  PolyDiff (begin)  *******************************}





function PolyDiffVN(pv: Pointer; x: Extended;  p: integer; tv: Integer): extended;  stdcall;

label endp;
var
  i,n: integer;
  s,c,res: extended;
  //va: TArrayE;
  ve: TArrayE absolute pv;
  vd: TArrayD absolute pv;
  vs: TArrayS absolute pv;
  vi: TArrayI absolute pv;

begin
// n:=length(va^);
 n:=_Length(pv); {.357}
// n:=PCardinal(PCardinal(pv)^-4)^+c_DinArrayLenCorrect;

  if (n-p)<=0 then
  begin
    //s := 0.0;
    s:=RetValOnNil;
    goto endp;
  end;


  //c:=factorial[n-1]/factorial[n-1-p];
  //s := va^[n-1]*c;

  //max speed for double
  if tv = _Double   then s := vd[n-1]*factorial[n-1]/factorial[n-1-p]
     else
  if tv = _Extended then s := ve[n-1]*factorial[n-1]/factorial[n-1-p]
     else
  if tv = _Integer  then s := vi[n-1]*factorial[n-1]/factorial[n-1-p]
     else
  if tv = _Single   then s := vs[n-1]*factorial[n-1]/factorial[n-1-p];

  //va:=TArrayE(pv);

 // s:=va[1];

  for i:=n-2 downto p do
  begin
    //c:=factorial[i]/factorial[i-p];
    //s := s*x^ + va^[i]*c;

     //max speed for double
    if tv = _Double then   s := s*x + vd[i]*factorial[i]/factorial[i-p]
      else
    if tv = _Extended then s := s*x + ve[i]*factorial[i]/factorial[i-p]
      else
    if tv = _Integer then  s := s*x + vi[i]*factorial[i]/factorial[i-p]
      else
    if tv = _Single then   s := s*x + vs[i]*factorial[i]/factorial[i-p];


  end;


endp:
PolyDiffVN:=s;
end;





procedure PolyDiffVNcx(pv: Pointer; z: TComplexE;  p: integer; tv: Integer);  stdcall;

label endp;
var
  i,n: integer;
  c,_re,_im,vv: extended;
  s: TComplexE;
  ve: TArrayE absolute pv;
  vd: TArrayD absolute pv;
  vs: TArrayS absolute pv;
  vi: TArrayI absolute pv;

begin
 //n:=length(va^);
  n:=_Length(pv); {.357}
 // n:=PInteger(PInteger(va)^-4)^+c_DinArrayLenCorrect;

  if (n-p)<=0 then
  begin
    //s.re := 0.0;   s.im := 0.0;
    s.re := RetValOnNil;   s.im := RetValOnNil;
    goto endp;
  end;


  c:=factorial[n-1]/factorial[n-1-p];

  if tv = _Double then   vv:=vd[n-1]
      else
  if tv = _Extended then vv:=ve[n-1]
      else
  if tv = _Integer then  vv:=vi[n-1]
      else
  if tv = _Single then   vv:=vs[n-1];

  s.re := vv*c; s.im := 0.0;

  for i:=n-2 downto p do
  begin
    c:=factorial[i]/factorial[i-p];

    //max speed for double
    if tv = _Double then   vv:=vd[i]
      else
    if tv = _Extended then vv:=ve[i]
      else
    if tv = _Integer then  vv:=vi[i]
      else
    if tv = _Single then   vv:=vs[i];

    _re := s.re*z.re - s.im*z.im + vv*c;
    _im := s.re*z.im + s.im*z.re;
    s.re:=_re;
    s.im:=_im;
  end;


endp:
asm
  fld s.im
  fld s.re
end;
end;






{ *****************************  PolyDiff (end)  *******************************}


procedure R_SGN; assembler;
asm
     push    ax
     ftst
     fstp  st(0)
     fstsw   ax
     sahf
     jnz     @@nz
     fldz
     jmp     @@end
 @@nz:
     fld1
     jnb      @@end
     fchs
 @@end:
     pop     ax
end;





procedure Z_SGN; assembler;
asm
     push    ax
     ftst
     fstp  st(0)
     fstsw   ax
     sahf
     jnz     @@nz

     //sgn(Im(z))
     ftst
     fstp  st(0)
     fstsw   ax
     sahf
     jnz     @@nz_im
     fldz
     jmp     @@end

 @@nz_im:

     fld1
     jnb      @@end
     fchs
     jmp      @@end
 @@nz:
     fstp st(0)
     fld1
     jnb      @@end
     fchs
 @@end:
     pop     ax
end;




procedure R_MAX(adr,len: Cardinal); stdcall;
var
i:Integer;
MAX: Extended;
begin
MAX:=PExtended(Adr)^;
for I := 1 to len - 1 do
begin
  if PExtended(Adr+16*i)^ > MAX then  MAX:=PExtended(Adr+16*i)^;
end;

 asm
  fld MAX
 end
end;




procedure R_MIN(adr,len: Cardinal); stdcall;
var
i:Integer;
MIN: Extended;
begin
MIN:=PExtended(Adr)^;
for I := 1 to len - 1 do
begin
  if PExtended(Adr+16*i)^ < MIN then  MIN:=PExtended(Adr+16*i)^;
end;

 asm
  fld MIN
 end
end;



procedure R_AVR(adr,len: Cardinal); stdcall;
var
i:Integer;
S: Extended;
begin
S:=0;
for I := 0 to len - 1 do
begin
  S:=S+PExtended(Adr+16*i)^;
end;

S:=S/len;
 asm
  fld S
 end
end;



procedure R_SUM(adr,len: Cardinal); stdcall;
var
i:Integer;
S: Extended;
begin
S:=0;
for I := 0 to len - 1 do
begin
  S:=S+PExtended(Adr+16*i)^;
end;

 asm
  fld S
 end
end;




procedure R_SUMQ(adr,len: Cardinal); stdcall;
var
i:Integer;
S: Extended;
begin
S:=0;
for I := 0 to len - 1 do
begin
  S:=S+sqr(PExtended(Adr+16*i)^);
end;

 asm
  fld S
 end
end;




procedure R_NORM(adr,len: Cardinal); stdcall;
var
i:Integer;
S: Extended;
begin
S:=0;
for I := 0 to len - 1 do
begin
  S:=S+sqr(PExtended(Adr+16*i)^);
end;

 asm
  fld S
  fsqrt
 end
end;




procedure R_PROD(adr,len: Cardinal); stdcall;
var
i:Integer;
S: Extended;
begin
S:=1;
for I := 0 to len - 1 do
begin
  S:=S*PExtended(Adr+16*i)^;
end;

 asm
  fld S
 end
end;





procedure R_DEV(adr,len: Cardinal); stdcall;
var
i:Integer;
S,avg: Extended;
begin

avg:=0;
for I := 0 to len - 1 do
begin
  avg:=avg+PExtended(Adr+16*i)^;
end;

avg:=avg/len;

S:=0;
for I := 0 to len - 1 do
begin
  S:=S+sqr(PExtended(Adr+16*i)^-avg);
end;

S:=sqrt(S/len);

 asm
  fld S
 end
end;



procedure R_DEVS(adr,len: Cardinal); stdcall;
var
i:Integer;
S,avg: Extended;
begin

avg:=0;
for I := 0 to len - 1 do
begin
  avg:=avg+PExtended(Adr+16*i)^;
end;

avg:=avg/len;

S:=0;
for I := 0 to len - 1 do
begin
  S:=S+sqr(PExtended(Adr+16*i)^-avg);
end;

S:=sqrt(S/(len-1));

 asm
  fld S
 end
end;



procedure R_GCD(adr,len: Cardinal); stdcall;
label lp,endp;
var
i,n:Integer;
S: Extended;
u,v,t,r: longint;
begin

if len = 0  then S:=0 else
if len = 1  then S:=PExtended(Adr)^ else
begin
  n:=1;
  u:=Trunc(PExtended(Adr)^);
  v:=Trunc(PExtended(Adr+16)^);

lp:
  while v <> 0 do
  begin
    t := u;
    u := v;
    v := t mod v;
  end;

  S := abs(u);
  inc(n);
  if n > len-1 then goto endp
  else
  begin
    v:=Trunc(S);
    u:=Trunc(PExtended(Adr+16*n)^);
    goto lp;
  end;

end;

endp:
 asm
  fld S
 end
end;






procedure R_LCM(adr,len: Cardinal); stdcall;
label lp,endp;
var
i,n:Integer;
S: Extended;
u,v,t,r,u1,v1: longint;
begin


if len = 0  then S:=0 else
if len = 1  then S:=PExtended(Adr)^ else
begin
  n:=1;
  u:=Trunc(PExtended(Adr)^);
  v:=Trunc(PExtended(Adr+16)^);


lp:
  u1:=u; v1:=v;

  while v <> 0 do
  begin
    t := u;
    u := v;
    v := t mod v;
  end;

  u:=(u1*v1) div abs(u);

  S := u;
  inc(n);
  if n > len-1 then goto endp
  else
  begin
    v:=Trunc(S);
    u:=Trunc(PExtended(Adr+16*n)^);
    goto lp;
  end;

end;

endp:
 asm
  fld S
 end
end;





procedure RI_VEC; assembler;
asm              //load vec[num]: EBX<-addr(vec);  EAX<-num
   mov  ebx, [ebx]
   fild  dword ptr [ebx+4*ecx]
end;




procedure RD_VEC; assembler;
asm              //load vec[num]: EBX<-addr(vec);  ECX<-num
   mov  ebx, [ebx]
   fld  qword ptr [ebx+8*ecx]
end;


procedure RE_VEC; assembler;
asm              //load vec[num]: EBX<-addr(vec);  ECX<-num
   mov  ebx, [ebx]
   //fld  tbyte ptr [ebx+10*ecx]
   lea   ecx,[ecx+4*ecx]
   fld   tbyte ptr [ebx+2*ecx]
end;


procedure RI_VECS; assembler;
asm              //load vec[num]: EBX<-addr(vec);  EAX<-num
   mov  ebx, [ebx]
   fistp  dword ptr [ebx+4*ecx]
end;

procedure RD_VECS; assembler;
asm              //load vec[num]: EBX<-addr(vec);  ECX<-num
   mov  ebx, [ebx]
   fstp  qword ptr [ebx+8*ecx]
end;


procedure RE_VECS; assembler;
asm              //load vec[num]: EBX<-addr(vec);  ECX<-num
   mov  ebx, [ebx]
   //fld  tbyte ptr [ebx+10*ecx]
   lea   ecx,[ecx+4*ecx]
   fstp   tbyte ptr [ebx+2*ecx]
end;


procedure _MAX2; assembler;
asm
     //push eax
     fcom
     fstsw ax
     sahf
     jb    @@end
     fxch st(1)
@@end:
     fstp  st(0)
     //pop eax
end;



procedure _MIN2; assembler;
asm
     //push eax
     fcom
     fstsw ax
     sahf
     jnb    @@end
     fxch st(1)
@@end:
     fstp  st(0)
     //pop eax
end;


procedure Z_CxIROOT3; assembler;
const C2PI: extended  = 3.1415926535897932384626433832795*2;
//root(Z,N,K);
var
M,N,K: Cardinal;
asm
 fld   tbyte ptr [eax+16]   //im
 fld   tbyte ptr [eax]      //re
 fld   tbyte ptr [eax+32]   //N
 fistp N
 fld   tbyte ptr [eax+48]   //K
 fistp K

 mov  eax,N
 mov  ebx,K

 call Z_CxIROOT3Int;

 (*
 fld   tbyte ptr [eax+16]   //im
 fld   tbyte ptr [eax]      //re
 fld   tbyte ptr [eax+32]   //N
 fistp N
 fld   tbyte ptr [eax+48]   //K
 fistp K

 //mov   M,eax
 //ZPUSHST
 fld   st
 fxch  st(2)
 fld   st
 fxch  st(3)

 fpatan
 fild  K
 fld tbyte ptr [C2PI]
 fmulp
 faddp
 fild  N
 fdivp
 fxch  st(2)
 fmul  st,st
 fxch
 fmul  st,st
 faddp
 fsqrt

 //IROOT:
 mov eax, N
 call R_IROOT        {.215}


  fxch
  fsincos
  fmul   st,st(2)
  fxch
  fmulp  st(2),st
  *)
end;







procedure R_LEN; assembler;
asm     //EAX<-@vector[0]



       {
       mov  eax,[eax]
       test eax,eax
       jz @@nil1
       mov  eax,[eax-4]
       @@nil1:
       dec eax
       add eax,c_DinArrayLenCorrect

     }



       push ecx
       //mov  eax, [eax]
       mov  ecx,eax
       test ecx,ecx
       jz @@nil
       mov  ecx,[ecx-4]
       {.357}
       add ecx,c_DinArrayLenCorrect
       (*
       {$IFDEF FPC}
        add ecx,1
       {$ENDIF}
       *)
       @@nil:
       push ecx
       fild dword ptr [esp]
       pop  ecx
       pop  ecx

      { push ecx
       mov  eax, [eax]
       mov  ecx,[eax-4]
       push ecx
       fild [esp]
       pop  ecx
       pop  ecx}
end;




procedure R_HIGH; assembler;
asm     //EAX<-@vector[0]

       push ecx
       //mov  eax, [eax]
       mov  ecx,eax
       test ecx,ecx
       jz @@nil
       mov  ecx,[ecx-4]
       {.357}
       add ecx,c_DinArrayLenCorrect
       (*
       {$IFDEF FPC}
        add ecx,1
       {$ENDIF}
       *)

       @@nil:
       dec  ecx
       push ecx
       fild dword ptr [esp]
       pop  ecx
       pop  ecx

      { push ecx
       mov  eax, [eax]
       mov  ecx,[eax-4]
       push ecx
       fild [esp]
       pop  ecx
       pop  ecx}
end;



procedure SetLengthArray(AdrV: Pointer; TypeV: Cardinal; Len: Cardinal);  stdcall;
var
L1: integer;
begin

if TypeV = _Double then
begin
  SetLength(PArrayD(AdrV)^{TArrayD(AdrV)},Len);
end
else
if TypeV = _Extended then
begin
  SetLength(PArrayE(AdrV)^,Len);
end
else
if TypeV = _Integer then
begin
  SetLength(PArrayI(AdrV)^,Len);
end
else
if TypeV = _Pointer then
begin
  SetLength(PArrayI(AdrV)^,Len);
end
else
if TypeV = _Single then
begin
  SetLength(PArrayS(AdrV)^,Len);
end;

end;




procedure SetLengthArrayD(AdrV: Pointer; Len: Cardinal);  stdcall;
begin
     SetLength(PArrayD(AdrV)^,Len);
    //SetLength(TArrayD(AdrV),Len);
end;




procedure SetLengthArrayE(AdrV: Pointer; Len: Cardinal);  stdcall;
begin
  SetLength(PArrayE(AdrV)^,Len);
end;




procedure SetLengthArrayI(AdrV: Pointer; Len: Cardinal);  stdcall;
begin
  SetLength(PArrayI(AdrV)^,Len);
end;



procedure SetLengthArrayS(AdrV: Pointer; Len: Cardinal);  stdcall;
begin
     SetLength(PArrayS(AdrV)^,Len);
    //SetLength(TArrayD(AdrV),Len);
end;






procedure __SetLengthCopyArrayAny; assembler;
//ArraySrc => ArrayDst
//ESI: @ArraySrc;
//EDI: @ArrayDst
//ECX: VType =  type of array  (_Extended, _Double, _Single, _Integer, _Pointer)
var
 Len, ArraySrc, ArrayDst, ArraySrc0, ArrayDst0, VType: Cardinal;
asm
       push  eax
       push  ebx
       push  ecx

       mov  VType,     ecx     //ECX -> VType
       mov  ArraySrc,  esi     // ESI -> ArraySrc  ; =  @ArraySrc
       mov  ArrayDst,  edi     // EDI -> ArrayDst  ; =  @ArrayDst
       mov  esi,      [esi]    // @ArraySrc[0] -> ESI
       mov  ArraySrc0, esi     // ESI -> ArraySrc0 ; =  @ArraySrc[0]
       mov  edi,      [edi]    // @ArrayDst[0] -> EDI
       mov  ArrayDst0, edi     // EDI -> ArrayDst0 ; =  @ArrayDst[0]


       test esi,esi         //ESI = 0? => Len(ArrayDst)=0
       jnz  @@LenD          //Len(ArraySrc) > 0;

       // Len(ArraySrc) = 0 => задать SetLen(ArrayDst,0) и выйти из процедуры
       mov   eax,0          //Len (ArraySrc)
       mov   ecx,ArrayDst   // @ArrayDst->ECX
       push  eax           //Len (ArraySrc)
       push  ecx           //@ArrayDst
       call  SetLengthArrayD
       jmp   @@end


     @@LenD:
       mov  eax, [esi-4]     // Len(ArraySrc) -> EAX ; Len(ArraySrc) > 0
       add  eax, c_DinArrayLenCorrect
       mov  Len, eax         //eax -> Len; длина копирования

       mov  ecx,ArrayDst        // @ArrayDst->ECX
       mov  edi,ArrayDst0       // @ArrayDst[0] -> EDI
       test edi,edi         //EDI = 0 =>  Len(ArrayDst)=0
       jnz  @@CmpLen        //если Len(ArrayDst) > 0, то перейти к сравнению длин  ArrayDst, ArraySrc

       //Len(ArrayDst) = 0 => задать  SetLen(ArrayDst,Len(ArraySrc))   и перейти к копированию
       mov   eax,Len      //Len (ArraySrc)
       mov   ecx,ArrayDst        // @ArrayDst->ECX
       push  eax           //Len (ArraySrc)
       push  ecx           //@ArrayDst
       call  SetLengthArrayD
       //после изменения размера ArrayDst его положение в памяти - @ArrayDst[0] изменилось. Нужно заново считать его из @ArrayDst
       mov  edi,      ArrayDst
       mov  edi,      [edi]      // @ArrayDst[0] -> EDI     //Считываем новое расположение ArrayDst
       mov  ArrayDst0, edi       // EDI ->  ArrayDst0
       jmp  @@copy



       //Сравнить длины ArrayDst, ArraySrc, если равны - перейти к копированию,
       //если нет, то вначале задать SetLen(ArrayDst,Len(ArraySrc))
     @@CmpLen:
       mov  ebx,[edi-4]    // Len(ArrayDst) -> EBX;  Len(ArrayDst) > 0
       add  ebx, c_DinArrayLenCorrect
       cmp  eax,ebx
       jz   @@copy

       //SetLen(ArrayDst,Len(ArraySrc))
       //save @ArraySrc[0], @ArrayDst, Len(ArraySrc)
       //push  esi  //@ArraySrc[0]
       //push  ecx  //@ArrayDst
       //push  eax  //Len(ArraySrc)
       mov   eax,Len             //Len (ArraySrc)
       mov   ecx,ArrayDst        // @ArrayDst->ECX
       push  eax                 //Len (ArraySrc)
       push  ecx                 //@ArrayDst
       call  SetLengthArrayD

       //после изменения размера ArrayDst его положение в памяти - @ArrayDst[0] изменилось. Нужно заново считать его из @ArrayDst
       mov  edi,      ArrayDst
       mov  edi,      [edi]      // @ArrayDst[0] -> EDI     //Считываем новое расположение ArrayDst
       mov  ArrayDst0, edi       // EDI ->  ArrayDst0

       //read  Addr src, dst, Len
       //pop  eax //eax->eax Len(ArraySrc)
       //pop  edi //ecx->edi @ArrayDst
       //pop  esi //@ArraySrc[0]

       //mov  edi,[edi]      // @ArrayDst[0] -> EDI     //Считываем новое расположение ArrayDst


       //Copy ArraySrc => ArrayDst
     @@copy:
       mov ecx, Len       //Len(ArraySrc) -> ECX
       mov esi, ArraySrc0
       mov edi, ArrayDst0
       mov eax, VType

        //for double - max speed
       cmp   eax,_Double    //_Double
       jnz   @@ext

        //*****Double Type Copying********
        cld
        //ecx=ecx*2 ; dword => ecx
        shl     ecx,1
        rep     movsd
        jmp     @@end
        //********************************


    @@ext:
       cmp   eax,_Extended    //_Extended
       jnz   @@int_sng_ptr


       //*****Extended Type Copying********
       cld
       //ecx=ecx*10     ; bytes => ecx
       lea     ecx, [ecx+ecx*4]
       add     ecx, ecx
       push    ecx
       shr     ecx,2
       rep     movsd
       pop     ecx
       and     ecx,3
       rep     movsb
       jmp     @@end
       //********************************


    @@int_sng_ptr:
       //*****Integer Single Pointer Type Copying********
       cld
       rep     movsd
       //********************************

     @@end:
       pop  ecx
       pop  ebx
       pop  eax

end;



procedure SetLengthCopyArrayAny; assembler;
//ArraySrc => ArrayDst
//ArrayDst = ArraySrc
//ESI: @ArraySrc;
//EDI: @ArrayDst
//ECX: VType =  type of array  (_Extended, _Double, _Single, _Integer, _Pointer)
var
 Len, ArraySrc, ArrayDst, ArraySrc0, ArrayDst0, VType: Cardinal;
asm
       push  eax
       push  ebx
       push  ecx

       mov  VType,     ecx     //ECX -> VType
       mov  ArraySrc,  esi     // ESI -> ArraySrc  ; =  @ArraySrc
       mov  ArrayDst,  edi     // EDI -> ArrayDst  ; =  @ArrayDst
       mov  esi,      [esi]    // @ArraySrc[0] -> ESI
       mov  ArraySrc0, esi     // ESI -> ArraySrc0 ; =  @ArraySrc[0]
       mov  edi,      [edi]    // @ArrayDst[0] -> EDI
       mov  ArrayDst0, edi     // EDI -> ArrayDst0 ; =  @ArrayDst[0]


       test esi,esi         //ESI = 0? => Len(ArrayDst)=0
       jnz  @@LenN          //Len(ArraySrc) > 0;

       //*******************************************************************

       // Len(ArraySrc) = 0 => задать SetLen(ArrayDst,0) и выйти из процедуры
       mov   eax,0          //Len (ArraySrc)
       mov   ecx,ArrayDst   // @ArrayDst->ECX
       push  eax           //Len (ArraySrc)
       push  ecx           //@ArrayDst

       mov   ebx, VType
        //for double - max speed
       cmp   ebx,_Double
       jnz   @@ext_Len0
       call  SetLengthArrayD     //_Double
       jmp   @@end
     @@ext_Len0:
       cmp   ebx,_Extended
       jnz   @@sng_Len0
       call  SetLengthArrayE    //_Extended
       jmp   @@end
     @@sng_Len0:
       cmp   ebx,_Single
       jnz   @@int_ptr_Len0
       call  SetLengthArrayS     //_Single
       jmp   @@end
     @@int_ptr_Len0:
       call  SetLengthArrayI   //_Integer, _Pointer
       jmp   @@end

      //*******************************************************************

     @@LenN:
       mov  eax, [esi-4]     // Len(ArraySrc) -> EAX ; Len(ArraySrc) > 0
       add  eax, c_DinArrayLenCorrect
       mov  Len, eax         //eax -> Len; длина копирования

       mov  ecx,ArrayDst        // @ArrayDst->ECX
       mov  edi,ArrayDst0       // @ArrayDst[0] -> EDI
       test edi,edi         //EDI = 0 =>  Len(ArrayDst)=0
       jnz  @@CmpLen        //если Len(ArrayDst) > 0, то перейти к сравнению длин  ArrayDst, ArraySrc

       //Len(ArrayDst) = 0 => задать  SetLen(ArrayDst,Len(ArraySrc))   и перейти к копированию
       mov   eax,Len      //Len (ArraySrc)
       mov   ecx,ArrayDst        // @ArrayDst->ECX
       push  eax           //Len (ArraySrc)
       push  ecx           //@ArrayDst

       mov   ebx, VType
        //for double - max speed
       cmp   ebx,_Double
       jnz   @@ext_LenN
       call  SetLengthArrayD  //_Double
       jmp   @@rewrite
     @@ext_LenN:
       cmp   ebx,_Extended
       jnz   @@sng_LenN
       call  SetLengthArrayE  //_Extended
       jmp   @@rewrite
     @@sng_LenN:
       cmp   ebx,_Single
       jnz   @@int_ptr_LenN
       call  SetLengthArrayS  //_Single
       jmp   @@rewrite
     @@int_ptr_LenN:
       call  SetLengthArrayI //_Integer, _Pointer


     @@rewrite:
       //после изменения размера ArrayDst его положение в памяти - @ArrayDst[0] изменилось. Нужно заново считать его из @ArrayDst
       mov  edi,      ArrayDst
       mov  edi,      [edi]      // @ArrayDst[0] -> EDI     //Считываем новое расположение ArrayDst
       mov  ArrayDst0, edi       // EDI ->  ArrayDst0
       jmp  @@copy

     //*******************************************************************

       //Сравнить длины ArrayDst, ArraySrc, если равны - перейти к копированию,
       //если нет, то вначале задать SetLen(ArrayDst,Len(ArraySrc))
     @@CmpLen:
       mov  ebx,[edi-4]    // Len(ArrayDst) -> EBX;  Len(ArrayDst) > 0
       add  ebx, c_DinArrayLenCorrect
       cmp  eax,ebx
       jz   @@copy

       //SetLen(ArrayDst,Len(ArraySrc))
       //save @ArraySrc[0], @ArrayDst, Len(ArraySrc)
       //push  esi  //@ArraySrc[0]
       //push  ecx  //@ArrayDst
       //push  eax  //Len(ArraySrc)
       mov   eax,Len             //Len (ArraySrc)
       mov   ecx,ArrayDst        // @ArrayDst->ECX
       push  eax                 //Len (ArraySrc)
       push  ecx                 //@ArrayDst

       mov   ebx, VType
        //for double - max speed
       cmp   ebx,_Double
       jnz   @@ext_CmpLenN
       call  SetLengthArrayD  //_Double
       jmp   @@rewrite1
     @@ext_CmpLenN:
       cmp   ebx,_Extended
       jnz   @@sng_CmpLenN
       call  SetLengthArrayE  //_Extended
       jmp   @@rewrite1
     @@sng_CmpLenN:
       cmp   ebx,_Single
       jnz   @@int_ptr_CmpLenN
       call  SetLengthArrayS  //_Single
       jmp   @@rewrite1
     @@int_ptr_CmpLenN:
       call  SetLengthArrayI //_Integer, _Pointer

       //call  SetLengthArrayD

     @@rewrite1:
       //после изменения размера ArrayDst его положение в памяти - @ArrayDst[0] изменилось. Нужно заново считать его из @ArrayDst
       mov  edi,      ArrayDst
       mov  edi,      [edi]      // @ArrayDst[0] -> EDI     //Считываем новое расположение ArrayDst
       mov  ArrayDst0, edi       // EDI ->  ArrayDst0



     //*******************************************************************

       //Copy ArraySrc => ArrayDst
     @@copy:
       mov ecx, Len       //Len(ArraySrc) -> ECX
       mov esi, ArraySrc0
       mov edi, ArrayDst0
       mov eax, VType

        //for double - max speed
       cmp   eax,_Double    //_Double
       jnz   @@ext

        //*****Double Type Copying********
        cld
        //ecx=ecx*2 ; dword => ecx
        shl     ecx,1
        rep     movsd
        jmp     @@end
        //********************************


    @@ext:
       cmp   eax,_Extended    //_Extended
       jnz   @@int_sng_ptr


       //*****Extended Type Copying********
       cld
       //ecx=ecx*10     ; bytes => ecx
       lea     ecx, [ecx+ecx*4]
       add     ecx, ecx
       push    ecx
       shr     ecx,2
       rep     movsd
       pop     ecx
       and     ecx,3
       rep     movsb
       jmp     @@end
       //********************************


    @@int_sng_ptr:
       //*****Integer Single Pointer Type Copying********
       cld
       rep     movsd
       //********************************

     @@end:
       pop  ecx
       pop  ebx
       pop  eax

end;





procedure _CopyArrayDbl(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx
        push    ebx

        mov     esi,SrcAddr
        mov     edi,DstAddr
        mov     edi,[edi]       // @ArrayDst[0] -> EDI
        mov     esi,[esi]       // @ArraySrc[0] -> ESI

        test    edi,edi
        jz      @@end

        test    esi,esi
        jz      @@end

        mov     ecx,[edi-4]     //  Len(ArrayDst) -> ECX
        add     ecx,c_DinArrayLenCorrect     {.357}
        mov     ebx,[esi-4]     // Len(ArraySrc) -> EBX
        add     ebx,c_DinArrayLenCorrect     {.357}


        //Get min Length Arrays
        cmp   ecx,ebx
        jb    @@Copy
        mov   ecx,ebx


        @@Copy:

         cld
        //ecx=ecx*2 ; dword => ecx
        shl     ecx,1
        rep     movsd



 @@end:
        pop     ebx
        pop     ecx
        pop     esi
        pop     edi
end;




procedure _CopyArrayExt(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx
        push    ebx

        mov     esi,SrcAddr
        mov     edi,DstAddr
        mov     edi,[edi]       // @ArrayDst[0] -> EDI
        mov     esi,[esi]       // @ArraySrc[0] -> ESI

        test    edi,edi
        jz      @@end

        test    esi,esi
        jz      @@end

        mov     ecx,[edi-4]     //  Len(ArrayDst) -> ECX
        add     ecx,c_DinArrayLenCorrect     {.357}
        mov     ebx,[esi-4]     // Len(ArraySrc) -> EBX
        add     ebx,c_DinArrayLenCorrect     {.357}


        //Get min Length Arrays
        cmp   ecx,ebx
        jb    @@Copy
        mov   ecx,ebx


        @@Copy:


        cld
        //ecx=ecx*10     ; bytes => ecx
        lea     ecx, [ecx+ecx*4]
        add     ecx, ecx

        push    ecx
        shr     ecx,2
        rep     movsd
        pop     ecx
        and     ecx,3
        rep     movsb


     @@end:
        pop     ebx
        pop     ecx
        pop     esi
        pop     edi
end;




procedure _CopyArrayInt(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx
        push    ebx

        mov     esi,SrcAddr
        mov     edi,DstAddr
        mov     edi,[edi]       // @ArrayDst[0] -> EDI
        mov     esi,[esi]       // @ArraySrc[0] -> ESI

        test    edi,edi
        jz      @@end

        test    esi,esi
        jz      @@end

        mov     ecx,[edi-4]     //  Len(ArrayDst) -> ECX
        add     ecx,c_DinArrayLenCorrect     {.357}
        mov     ebx,[esi-4]     // Len(ArraySrc) -> EBX
        add     ebx,c_DinArrayLenCorrect     {.357}


        //Get min Length Arrays
        cmp   ecx,ebx
        jb    @@Copy
        mov   ecx,ebx


        @@Copy:

        cld
        rep     movsd


      @@end:
        pop     ebx
        pop     ecx
        pop     esi
        pop     edi
end;




procedure _CopyArraySng(DstAddr: Pointer; SrcAddr: Pointer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx
        push    ebx

        mov     esi,SrcAddr
        mov     edi,DstAddr
        mov     edi,[edi]       // @ArrayDst[0] -> EDI
        mov     esi,[esi]       // @ArraySrc[0] -> ESI

        test    edi,edi
        jz      @@end

        test    esi,esi
        jz      @@end

        mov     ecx,[edi-4]     //  Len(ArrayDst) -> ECX
        add     ecx,c_DinArrayLenCorrect     {.357}
        mov     ebx,[esi-4]     // Len(ArraySrc) -> EBX
        add     ebx,c_DinArrayLenCorrect     {.357}


        //Get min Length Arrays
        cmp   ecx,ebx
        jb    @@Copy
        mov   ecx,ebx


        @@Copy:

        cld
        rep     movsd

     @@end:
        pop     ebx
        pop     ecx
        pop     esi
        pop     edi
end;





procedure _CopyMemDbl(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx

        cld
        mov     edi,DstAddr
        mov     esi,SrcAddr
        mov     ecx,Len

        //ecx=ecx*2 ; dword => ecx
        shl     ecx,1

        rep     movsd


        pop     ecx
        pop     esi
        pop     edi
end;



procedure _CopyMemExt(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx

        cld
        mov     edi,DstAddr
        mov     esi,SrcAddr
        mov     ecx,Len

        //ecx=ecx*10     ; bytes => ecx
        lea     ecx, [ecx+ecx*4]
        add     ecx, ecx

        push    ecx
        shr     ecx,2
        rep     movsd
        pop     ecx
        and     ecx,3
        rep     movsb

        pop     ecx
        pop     esi
        pop     edi
end;


procedure _CopyMemInt(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx

        cld
        mov     edi,DstAddr
        mov     esi,SrcAddr
        mov     ecx,Len

        rep     movsd

        pop     ecx
        pop     esi
        pop     edi
end;



procedure _CopyMemSng(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
asm

        push    edi
        push    esi
        push    ecx

        cld
        mov     edi,DstAddr
        mov     esi,SrcAddr
        mov     ecx,Len

        rep     movsd

        pop     ecx
        pop     esi
        pop     edi
end;




procedure _CopyArrayIntToExt; assembler;
//in:
//EAX <- @IntArray[0]
//EDX <- @ExtArray[0]
asm
  push  ecx
  push  ebx

  test eax,eax
  jz @@end

  test edx,edx
  jz @@end


  mov   ecx,[eax-4]
  add   ecx,c_DinArrayLenCorrect     {.357}
  mov   ebx,[edx-4]
  add   ebx,c_DinArrayLenCorrect     {.357}



  //Get min Length Array(Int vs Ext)
  cmp   ecx,ebx
  jb    @@Int
  mov   ecx,ebx
  @@Int:



  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     fild   dword ptr[eax]
     fild   dword ptr[eax+4]
     fild   dword ptr[eax+8]
     fild   dword ptr[eax+12]
     fild   dword ptr[eax+16]
     fild   dword ptr[eax+20]
     fild   dword ptr[eax+24]
     fild   dword ptr[eax+28]

     add    eax,32

     fstp   tbyte ptr[edx+70]
     fstp   tbyte ptr[edx+60]
     fstp   tbyte ptr[edx+50]
     fstp   tbyte ptr[edx+40]
     fstp   tbyte ptr[edx+30]
     fstp   tbyte ptr[edx+20]
     fstp   tbyte ptr[edx+10]
     fstp   tbyte ptr[edx]

     add    edx,80

     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fild   dword ptr[eax]
      add    eax,4
      fstp   tbyte ptr[edx]
      add    edx,10
      dec   cx

  jnz   @@cyclx1


@@end:


  pop   ebx
  pop   ecx


end;




procedure _CopyArrayIntToDbl; assembler;
//in:
//EAX <- @IntArray[0]
//EDX <- @DblArray[0]
asm
  push  ecx
  push  ebx

  test eax,eax
  jz @@end

  test edx,edx
  jz @@end


  mov   ecx,[eax-4]
  add   ecx,c_DinArrayLenCorrect     {.357}
  mov   ebx,[edx-4]
  add   ebx,c_DinArrayLenCorrect     {.357}

  //Get min Length Array(Int vs Dbl)
  cmp   ecx,ebx
  jb    @@Int
  mov   ecx,ebx
  @@Int:




  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     fild   dword ptr[eax]
     fild   dword ptr[eax+4]
     fild   dword ptr[eax+8]
     fild   dword ptr[eax+12]
     fild   dword ptr[eax+16]
     fild   dword ptr[eax+20]
     fild   dword ptr[eax+24]
     fild   dword ptr[eax+28]

     add    eax,32

     fstp   qword ptr[edx+56]
     fstp   qword ptr[edx+48]
     fstp   qword ptr[edx+40]
     fstp   qword ptr[edx+32]
     fstp   qword ptr[edx+24]
     fstp   qword ptr[edx+16]
     fstp   qword ptr[edx+8]
     fstp   qword ptr[edx]

     add    edx,64

     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fild   dword ptr[eax]
      add    eax,4
      fstp   qword ptr[edx]
      add    edx,8
      dec   cx

  jnz   @@cyclx1


@@end:


  pop   ebx
  pop   ecx


end;








procedure _CopyArraySngToExt; assembler;
//in:
//EAX <- @SngArray[0]
//EDX <- @ExtArray[0]
asm
  push  ecx
  push  ebx

  test eax,eax
  jz @@end

  test edx,edx
  jz @@end



  mov   ecx,[eax-4]
  add   ecx,c_DinArrayLenCorrect     {.357}
  mov   ebx,[edx-4]
  add   ebx,c_DinArrayLenCorrect     {.357}


  //Get min Length Array(Sng vs Ext)
  cmp   ecx,ebx
  jb    @@Int
  mov   ecx,ebx
  @@Int:




  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     fld   dword ptr[eax]
     fld   dword ptr[eax+4]
     fld   dword ptr[eax+8]
     fld   dword ptr[eax+12]
     fld   dword ptr[eax+16]
     fld   dword ptr[eax+20]
     fld   dword ptr[eax+24]
     fld   dword ptr[eax+28]

     add    eax,32

     fstp   tbyte ptr[edx+70]
     fstp   tbyte ptr[edx+60]
     fstp   tbyte ptr[edx+50]
     fstp   tbyte ptr[edx+40]
     fstp   tbyte ptr[edx+30]
     fstp   tbyte ptr[edx+20]
     fstp   tbyte ptr[edx+10]
     fstp   tbyte ptr[edx]

     add    edx,80

     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   dword ptr[eax]
      add    eax,4
      fstp   tbyte ptr[edx]
      add    edx,10
      dec   cx

  jnz   @@cyclx1


@@end:


  pop   ebx
  pop   ecx


end;




procedure _CopyArraySngToDbl; assembler;
//in:
//EAX <- @SngArray[0]
//EDX <- @DblArray[0]
asm
  push  ecx
  push  ebx

  test eax,eax
  jz @@end

  test edx,edx
  jz @@end


  mov   ecx,[eax-4]
  add   ecx,c_DinArrayLenCorrect     {.357}
  mov   ebx,[edx-4]
  add   ebx,c_DinArrayLenCorrect     {.357}


  //Get min Length Array(Sng vs Dbl)
  cmp   ecx,ebx
  jb    @@Int
  mov   ecx,ebx
  @@Int:





  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     fld   dword ptr[eax]
     fld   dword ptr[eax+4]
     fld   dword ptr[eax+8]
     fld   dword ptr[eax+12]
     fld   dword ptr[eax+16]
     fld   dword ptr[eax+20]
     fld   dword ptr[eax+24]
     fld   dword ptr[eax+28]

     add    eax,32

     fstp   qword ptr[edx+56]
     fstp   qword ptr[edx+48]
     fstp   qword ptr[edx+40]
     fstp   qword ptr[edx+32]
     fstp   qword ptr[edx+24]
     fstp   qword ptr[edx+16]
     fstp   qword ptr[edx+8]
     fstp   qword ptr[edx]

     add    edx,64

     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld   dword ptr[eax]
      add    eax,4
      fstp   qword ptr[edx]
      add    edx,8
      dec   cx

  jnz   @@cyclx1


@@end:


  pop   ebx
  pop   ecx


end;






procedure _CopyArrayDblToExt; assembler;
//in:
//EAX <- @DblArray[0]
//EDX <- @ExtArray[0]
asm
  push  ecx
  push  ebx

  test eax,eax
  jz @@end

  test edx,edx
  jz @@end


  mov   ecx,[eax-4]
  add   ecx,c_DinArrayLenCorrect     {.357}
  mov   ebx,[edx-4]
  add   ebx,c_DinArrayLenCorrect     {.357}


  //Get min Length Array(Dbl vs Ext)
  cmp   ecx,ebx
  jb    @@Int
  mov   ecx,ebx
  @@Int:





  mov   bx,cx
  shr   ecx,3
  and   bx,7

  jecxz  @@cycl1


  @@cyclx4:

     fld   qword ptr[eax]
     fld   qword ptr[eax+8]
     fld   qword ptr[eax+16]
     fld   qword ptr[eax+24]
     fld   qword ptr[eax+32]
     fld   qword ptr[eax+40]
     fld   qword ptr[eax+48]
     fld   qword ptr[eax+56]

     add    eax,64

     fstp   tbyte ptr[edx+70]
     fstp   tbyte ptr[edx+60]
     fstp   tbyte ptr[edx+50]
     fstp   tbyte ptr[edx+40]
     fstp   tbyte ptr[edx+30]
     fstp   tbyte ptr[edx+20]
     fstp   tbyte ptr[edx+10]
     fstp   tbyte ptr[edx]

     add    edx,80

     dec    ecx

  jnz   @@cyclx4



  @@cycl1:


   mov   cx,bx
   jcxz @@end


  @@cyclx1:

      fld    qword ptr[eax]
      add    eax,8
      fstp   tbyte ptr[edx]
      add    edx,10
      dec   cx

  jnz   @@cyclx1


@@end:


  pop   ebx
  pop   ecx


end;








function  R_PDouble(Addr: Pointer): Extended;      stdcall;
begin
  R_PDouble:=PDouble(Addr)^;
end;



procedure  RW_PDouble(Addr: Pointer; Val: double);      stdcall;
begin
  PDouble(Addr)^:=Val;
end;


function  R_PExtended(Addr: Pointer): Extended;      stdcall;
begin
  R_PExtended:=PExtended(Addr)^;
end;


procedure  RW_PExtended(Addr: Pointer; Val: extended);      stdcall;
begin
  PExtended(Addr)^:=Val;
end;



function  R_PSingle(Addr: Pointer): Extended;      stdcall;
begin
  R_PSingle:=PSingle(Addr)^;
end;


procedure  RW_PSingle(Addr: Pointer; Val: Single);      stdcall;
begin
  PSingle(Addr)^:=Val;
end;




 {
function  R_PInteger(Addr: Pointer): Extended;      stdcall;
begin
  R_PInteger:=PInteger(Addr)^;
end;
 }


procedure  R_PInteger(Addr: Pointer);      stdcall;
asm
    mov eax, [Addr]
    fild dword [eax]
end;



procedure  RW_PInteger(Addr: Pointer; Val: Integer);      stdcall;
begin
  PInteger(Addr)^:=Val;
end;


{var
n: Integer;
begin

  n:=PInteger(Addr)^;
  asm
    fild n
  end;

end;
}



procedure  I_PPointer(Addr: Pointer);   stdcall;
asm
    mov eax, [Addr]
    mov eax, [eax]
end;




function R_PArrayExtended(AdrV: Pointer; indx: Cardinal):Extended;  stdcall;
begin
 R_PArrayExtended:=PArrayE(AdrV)^[indx];
end;




function R_PArrayDouble(AdrV: Pointer; indx: Cardinal):Extended;  stdcall;
begin
 R_PArrayDouble:=PArrayD(AdrV)^[indx];
end;





procedure R_PArrayInteger(AdrV: Pointer; indx: Cardinal);  stdcall;
var
n: Integer;
begin
 n:=PArrayI(AdrV)^[indx];
 asm
    fild n
  end;
end;




procedure  ToPointer(val: Integer);   stdcall;
asm
    mov eax, val
end;




procedure  ToInteger(val: Integer);   stdcall;
asm
    //push eax
    mov  eax, val
    push eax
    fild dword [esp]
    pop  eax
end;



 {.379}
//******************************************************************************
//                       LOGIC FUNCTIONS    (begin)
//******************************************************************************



//procedure LGC__OR(n1,n2: Integer);  cdecl;
procedure LGC_OR; assembler; //cdecl;//stdcall;
asm

  //mov eax,[esp+4]     // n1
  //mov ebx,[esp+8]      // n2

   mov  eax,[esp+4]
   or   eax,[esp+8]

    //push eax
    sub  esp,4
    mov  [esp],eax
    fild [esp]
    add  esp,4

end;



//procedure LGC_AND(n1,n2: Integer);  cdecl;
procedure LGC_AND; assembler; //cdecl;
asm

  //mov eax,[esp+4]     // n1
  //mov ebx,[esp+8]      // n2


    mov   eax,[esp+4]
    and   eax,[esp+8]

    //push eax
    sub  esp,4
    mov  [esp],eax
    fild [esp]
    add  esp,4

end;


//procedure LGC_XOR(n1,n2: Integer);  cdecl;
procedure LGC_XOR; assembler; //cdecl;
asm
  //mov eax,[esp+4]     // n1
  //mov ebx,[esp+8]      // n2

    mov   eax,[esp+4]
    xor   eax,[esp+8]

    //push eax
    sub  esp,4
    mov  [esp],eax
    fild [esp]
    add  esp,4

end;


//procedure LGC_NOT(n1: Integer);  cdecl;
procedure LGC_NOT; assembler; //cdecl;
asm

    mov   eax,[esp+4]    // n1
    not   eax

    //push eax
    sub  esp,4
    mov  [esp],eax
    fild [esp]
    add  esp,4

end;



//procedure LGC_NOR(n1,n2: Integer);  cdecl;
procedure LGC_NOR; assembler; //cdecl;//stdcall;
asm

  //mov eax,[esp+4]     // n1
  //mov ebx,[esp+8]      // n2

   mov  eax,[esp+4]
   or   eax,[esp+8]
   not   eax

    //push eax
    sub  esp,4
    mov  [esp],eax
    fild [esp]
    add  esp,4

end;



//procedure LGC_NAND(n1,n2: Integer);  cdecl;
procedure LGC_NAND; assembler; //cdecl;
asm

  //mov eax,[esp+4]     // n1
  //mov ebx,[esp+8]      // n2


    mov   eax,[esp+4]
    and   eax,[esp+8]
    not   eax

    //push eax
    sub  esp,4
    mov  [esp],eax
    fild [esp]
    add  esp,4

end;



//procedure LGC_XNOR(n1,n2: Integer);  cdecl;
procedure LGC_XNOR; assembler; //cdecl;
asm

  //mov eax,[esp+4]     // n1
  //mov ebx,[esp+8]      // n2

    mov   eax,[esp+4]
    xor   eax,[esp+8]
    not   eax

    //push eax
    sub  esp,4
    mov  [esp],eax
    fild [esp]
    add  esp,4

end;



//******************************************************************************
//                       LOGIC FUNCTIONS    (end)
//******************************************************************************


// PByte(Addr) -> ST(0) ; ST(0) = Byte(Addr)
procedure  R_PByte; assembler; //cdecl;
asm

     xor eax,eax
     mov ebx,[esp+4]
     mov al,byte ptr [ebx]

     sub  esp,4
     mov  [esp],eax
     fild dword ptr  [esp]
     add  esp,4

end;

 {.379}
// PByte(Addr,Val); Byte(Addr) = Val;  Addr:Pointer; Val: Int32
procedure  W_PByte; assembler; //cdecl;
asm

     mov eax,[esp+4]      // Addr
     mov ebx,[esp+8]      // Val
     mov byte ptr [eax], bl

end;



 {.379}
// PWord(Addr) -> ST(0) ; ST(0) = Word(Addr)
procedure  R_PWord; assembler; //cdecl;
asm

     xor eax,eax
     mov ebx,[esp+4]
     mov ax,word ptr [ebx]

     sub  esp,4
     mov  [esp],eax
     fild dword ptr  [esp]
     add  esp,4

end;

 {.379}
// PWord(Addr,Val); Word(Addr) = Val;  Addr:Pointer; Val: Int32
procedure  W_PWord; assembler; //cdecl;
asm

     mov eax,[esp+4]      // Addr
     mov ebx,[esp+8]      // Val
     mov word ptr [eax], bx

end;





{***************************** BEGIN RANDOM COM. ************************************}


{
              Random numbers generator  algorithm
                  (C) Copyright   Wolfgang Ehrhardt   http://wolfgang-ehrhardt.de/

                    algorithm taus113 (Pierre L'Ecuyer)
                    algorithm mt19937 (Mersenne Twister)
                    algorithm xor4096 ()
}





procedure taus113_init4(var ctx: taus113_ctx; seed1,seed2,seed3,seed4: longint);
  {-Init all context with separate seeds, the initial seeds}
  { seed1, seed2, seed3, seed4 should be >= 2, 8, 16, 128 resp. or < 0  }
var
  i: integer;
begin
  with ctx do begin
    s1 := seed1;
    s2 := seed2;
    s3 := seed3;
    s4 := seed4;
    {Make sure most significant bits are set}
    if s1 and TC1=0 then inc(s1,2);
    if s2 and TC2=0 then inc(s2,8);
    if s3 and TC3=0 then inc(s3,16);
    if s4 and TC4=0 then inc(s4,128);
    {Make sure ctx has valid state}
    for i:=1 to ICNT do taus113_next(ctx);
  end;
end;



procedure taus113_init(var ctx: taus113_ctx; seed: longint);
  {-Init context from seed}
const
  M=69069;
  A=1;
var
  seed2,seed3,seed4: longint;
begin
 {Если возникает исключение при  OverFlowChecks,RangeChecks -On - это не ошибка ! }
     {If there is an exception at OverFlowChecks,RangeChecks -On - it is no error !}
//{$RangeChecks Off}
// {$OverFlowChecks Off}
  seed2 := M*seed+A;
  seed3 := M*seed2+A;
  seed4 := M*seed3+A;
  taus113_init4(ctx,seed,seed2,seed3,seed4);
  // {$RangeChecks On}
// {$OverFlowChecks On}
end;


procedure taus113_next(var ctx: taus113_ctx);
  {-Next step of PRNG}
begin
  with ctx do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;
end;





function taus113_double(var ctx: taus113_ctx): double;
  {-Next random double [0..1) with 32 bit precision}
begin
  taus113_next(ctx);
  taus113_double := (ctx.nr + 2147483648.0) / 4294967296.0;
end;


function taus113_double53(var ctx: taus113_ctx): double;
  {-Next random double in [0..1) with 53 bit precision}
var
  hb,lb: longint;
begin
  taus113_next(ctx);
  hb := ctx.nr shr 5;
  taus113_next(ctx);
  lb := ctx.nr shr 6;
  taus113_double53 := (hb*67108864.0+lb)/9007199254740992.0;
end;





procedure PLE_rand01;  stdcall;
const
 c1: double = 67108864.0;
 c2:extended=1/9007199254740992.0;
var
 rn: Cardinal;
 res: extended;
 hb,lb: longint;
begin
  //taus113_next(ctxPLE);
  (*
  with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;
  *)

 {.357}
//53bit floar  :
with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

hb := ctxPLE.nr shr 5;

with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

lb := ctxPLE.nr shr 6;

//=((hb*67108864.0+lb)*c2);


  asm
    fild   lb
    fild   hb
    fmul   c1
    faddp
    fld    c2
    fmulp
  end;

end;





function PLE_rand2(x1,x2:PDouble): double;  stdcall;
const
 c2:extended=1/9007199254740992.0;
var
  hb,lb: longint;
begin
{
 taus113_next(ctx);
 PLE_rand2:=(x1^-x2^)*taus113_double(ctx)+x2^;
}

//32bit  float:
{ with ctx do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

 PLE_rand2:=(x1^-x2^)*((ctx.nr + 2147483648.0) / 4294967296.0)+x2^;
 }

//53bit floar  :
with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

hb := ctxPLE.nr shr 5;

with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

lb := ctxPLE.nr shr 6;

PLE_rand2:=(x1^-x2^)*((hb*67108864.0+lb)*c2)+x2^;

end;




procedure PLE_intrand(Num: Cardinal){extended};  stdcall;
{const
c3: extended}
const
maxint: cardinal = 2147483647;{4294967295}
divmaxint: extended = 1/2147483647;
divmaxlong: extended = 1/4294967295;
var
rn,nr,ResI: Cardinal;
res,res1: double;
begin

{in range max integer: 0..2^31-1=2147483647}
// Num*(ctxMT.nr sh1 1) / 4294967296.0;
  {
  taus113_next(ctxPLE);
  ResI:=longint(uint32(ctxPLE.nr)*uint64(abs(Num)) shr 32);
   }

   {.379}
   with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

  ResI :=  longint(uint32(ctxPLE.nr)*uint64(abs(Num)) shr 32);

   asm
     fild ResI
   end;

  {
  rn:=ctxPLE.nr shr 1;
  asm
    fild  rn
    fimul Num
    fld tbyte ptr divmaxint
    fmulp
    FRNDINT
  end;
   }


{in range max cardinal: 0..2^32-1=4294967295}
// Num*(ctxPLE.nr + 2147483648.0) / 4294967296.0;

{ PLE19937_next(ctxPLE);


  asm
    fild  ctxPLE.nr
    fiadd maxint
    fimul Num
    fld tbyte ptr divmaxlong
    fmulp
    FRNDINT
  end;
 }
end;




procedure PLE_intrand_Int;
var
Num,ResI: Cardinal;
begin

 asm
   mov Num, EAX
 end;

   with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

  ResI :=  longint(uint32(ctxPLE.nr)*uint64(abs(Num)) shr 32);

   asm
     mov EAX, ResI
   end;

end;






{.379}
procedure PLE_intrand2(Num1,Num2: Cardinal){extended};  stdcall;
var
ResI: Cardinal;
begin
 // [i,j)  intrand2(i,j) = intrand(j-i)+i

   with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

  ResI :=  longint(uint32(ctxPLE.nr)*uint64(abs(Num2-Num1)) shr 32)+Num1;

   asm
     fild ResI
   end;

end;






procedure PLE_intrand2_Int;
var
ResI,Num1,Num2: Cardinal;
begin

asm
  mov Num1, EAX
  mov Num2, EBX
end;

// [i,j)  intrand2(i,j) = intrand(j-i)+i

   with ctxPLE do begin
    s1 := ((s1 and TC1) shl 18) xor (((s1 shl  6) xor s1) shr 13);
    s2 := ((s2 and TC2) shl  2) xor (((s2 shl  2) xor s2) shr 27);
    s3 := ((s3 and TC3) shl  7) xor (((s3 shl 13) xor s3) shr 21);
    s4 := ((s4 and TC4) shl 13) xor (((s4 shl  3) xor s4) shr 12);
    nr := s1 xor s2 xor s3 xor s4;
  end;

  ResI :=  longint(uint32(ctxPLE.nr)*uint64(abs(Num2-Num1)) shr 32)+Num1;

asm
  mov EAX, ResI
end;


end;





procedure mt19937_init(var ctxMT: mt19937_ctx; seed: longint);
  {-Init context from seed}

begin
  with ctxMT do begin
    mt[0]:= seed;
    mti  := 1;
    while mti<N19937 do begin
      {See Knuth TAOCP Vol2. 3rd Ed. P.106 for multiplier.}
      {In the previous versions, MSBs of the seed affect  }
      {only MSBs of the array mt[].                       }
      {2002/01/09 modified by Makoto Matsumoto}
      mt[mti] := (1812433253*(mt[mti-1] xor (mt[mti-1] shr 30))+mti);
      inc(mti);
    end;
  end;
end;


procedure mt19937_next(var ctx: mt19937_ctx);
  {-Next step of PRNG}
var
  kk: integer;
  y : longint;
begin
  with ctx do begin
    if mti >= N19937 then begin
      {generate N19937 numbers at one time}
      kk := 0;
      while kk<N19937-M19937 do begin
        y := (mt[kk] and Upper_Mask) or (mt[kk+1] and Lower_mask);
        mt[kk] := mt[kk+M19937] xor (y shr 1) xor mag01[y and 1];
        inc(kk);
      end;
      while kk<N19937-1 do begin
        y := (mt[kk] and Upper_Mask) or (mt[kk+1] and Lower_mask);
        mt[kk] := mt[kk+(M19937-N19937)] xor (y shr 1) xor mag01[y and 1];
        inc(kk);
      end;
      y := (mt[N19937-1] and Upper_Mask) or (mt[0] and Lower_mask);
      mt[N19937-1] := mt[M19937-1] xor (y shr 1) xor mag01[y and 1];
      mti := 0;
    end;
    y := mt[mti];
    inc(mti);

      y := y xor (y shr 11);
      y := y xor ((y shl  7) and longint($9d2c5680));
      y := y xor ((y shl 15) and longint($efc60000));
      nr:= y xor (y shr 18);

  end;
end;


 function mt19937_long(var ctx: mt19937_ctx): longint;
  {-Next random positive longint}
begin
  mt19937_next(ctx);
  mt19937_long := ctx.nr shr 1;
end;







procedure MT_intrand(Num: Cardinal){extended};  stdcall;
{const
c3: extended}
const
 maxint: cardinal = 2147483647;{4294967295}
 divmaxint: extended = 1/2147483647;
 divmaxlong: extended = 1/4294967295;
var
 rn,ResI: Cardinal;
 res,res1: double;
begin

{in range max integer: 0..2^31-1=2147483647}
// Num*(ctxMT.nr sh1 1) / 4294967296.0;

{.379}
mt19937_next(ctxMT);
ResI:=longint(uint32(ctxMT.nr)*uint64(abs(Num)) shr 32);

asm
  fild ResI
end;

{
  mt19937_next(ctxMT);
  rn:=ctxMT.nr shr 1;

  asm
    fild  rn
    fimul Num
    fld tbyte ptr divmaxint
    fmulp
    FRNDINT
  end;
}


end;



procedure MT_intrand_Int;
var
 Num,ResI: Cardinal;
begin

asm
  mov Num,EAX
end;

mt19937_next(ctxMT);
ResI:=longint(uint32(ctxMT.nr)*uint64(abs(Num)) shr 32);

asm
  mov  EAX, ResI
end;


end;


procedure MT_intrand2(Num1,Num2: Cardinal){extended};  stdcall;
var
ResI: Cardinal;
begin

{.379}
mt19937_next(ctxMT);
ResI:=longint(uint32(ctxMT.nr)*uint64(abs(Num2-Num1)) shr 32)+Num1;

asm
  fild ResI
end;

end;




procedure MT_intrand2_Int;
var
ResI,Num1,Num2: Cardinal;
begin

asm
  mov Num1, EAX
  mov Num2, EBX
end;

{.379}
mt19937_next(ctxMT);
ResI:=longint(uint32(ctxMT.nr)*uint64(abs(Num2-Num1)) shr 32)+Num1;

asm
  mov EAX, ResI
end;


end;





procedure MT_rand01;  stdcall;
const
{
c1: extended = 1/4294967296.0;
c2: double =  2147483648.0;
c3: double =  4294967296.0;
}
 c2: extended = 1/9007199254740992.0;
 c1: double =  67108864.0;
var
 rn: Cardinal;
 res: extended;
 hb,lb: longint;
begin


  {.357}
  mt19937_next(ctxMT);
  hb := ctxMT.nr shr 5;
  mt19937_next(ctxMT);
  lb := ctxMT.nr shr 6;
  //mt19937_double53 := (hb*67108864.0+lb)/9007199254740992.0;

  asm
    fild   lb
    fild   hb
    fmul   c1
    faddp
    fld c2
    fmulp
  end;


end;



function mt19937_double(var ctxMT: mt19937_ctx): double;
  {-Next random double [0..1) with 32 bit precision}
begin
  mt19937_next(ctxMT);
  mt19937_double := (ctxMT.nr + 2147483648.0) / 4294967296.0;
end;


function mt19937_double53(var ctxMT: mt19937_ctx): double;
  {-Next random double in [0..1) with full double 53 bit precision}
var
  hb,lb: longint;
begin
  mt19937_next(ctxMT);
  hb := ctxMT.nr shr 5;
  mt19937_next(ctxMT);
  lb := ctxMT.nr shr 6;
  mt19937_double53 := (hb*67108864.0+lb)/9007199254740992.0;
end;



function MT_rand2(x1,x2:PDouble): double;  stdcall;
const
 c2: extended = 1/9007199254740992.0;
var
  hb,lb: longint;
begin
  mt19937_next(ctxMT);
  hb := ctxMT.nr shr 5;
  mt19937_next(ctxMT);
  lb := ctxMT.nr shr 6;

  MT_rand2:=(x1^-x2^)*((hb*67108864.0+lb)*c2)+x2^;
end;




{*******************************xor4096**************************************}

procedure xor4096_init(var ctx: xor4096_ctx; seed: longint);
  {-Init context from seed}
var
  k: integer;
  v: longint;
begin
  v := seed;
  {starting value must be non-zero}
  if v=0 then v := not v;
  with ctx do begin
    {Avoid correlations for close seeds, recurrence has period 2^32-1}
    for k:=0 to 31 do begin
      v := v xor (v shl 10);  v := v xor (v shr 15);
      v := v xor (v shl  4);  v := v xor (v shr 13);
    end;
    {Initialize circular array}
    w := v;
    for k:=0 to 127 do begin
      v := v xor (v shl 10);  v := v xor (v shr 15);
      v := v xor (v shl  4);  v := v xor (v shr 13);
      w := w + Weyl;
      x[k] := v + w;
    end;
    {Discard first 512 results}
    i := 127;
    {Because xor4096_next changes w, the current Weyl state is saved and}
    {restored. The original c code doubles the source except that w is  }
    {unchanged. As the init code is normally called only once, the small}
    {speed penalty is no problem here and optimization is done in next. }
    v := w;
    for k:=0 to 511 do xor4096_next(ctx);
    {Restore Weyl state}
    w := v;
  end;
end;


procedure xor4096_next(var ctx: xor4096_ctx);
  {-Next step of PRNG}
var
  v,t: longint;
const
  a=17; b=12; c=13; d=15;
begin
  with ctx do begin
    {(I + L^a)(I + R^b) */}
    i := succ(i) and 127;
    t := x[i];
    t := t xor (t shl a);
    t := t xor (t shr b);
    {(I + L^c)(I + R^d) and xor with t}
    v := x[(i+33) and 127];
    v := v xor (v shl c);
    v := (v xor (v shr d)) xor t;
    {Update circular array}
    x[i] := v;
    {Update Weyl generator}
    w := w + Weyl;
    {Store next random result}
      nr := v + (w xor (w shr 16));
  end;
end;



procedure XOR_intrand(Num: Cardinal){extended};  stdcall;
{const
c3: extended}
const
maxint: cardinal = 2147483647;{4294967295}
divmaxint: extended = 1/2147483647;
divmaxlong: extended = 1/4294967295;
var
rn,ResI,i,j: Cardinal;
res,res1: double;
begin

{in range max integer: 0..2^31-1=2147483647}
// Num*(ctxXOR.nr sh1 1) / 4294967296.0;


{.379}

  // [0,Num)
  xor4096_next(ctxXOR);
  ResI:=longint(uint32(ctxXOR.nr)*uint64(abs(Num)) shr 32);
  asm
    fild ResI
  end;




{in range max integer: 0..2^31-1=2147483647}
// Num*(ctxXOR.nr sh1 1) / 4294967296.0;

  {
  rn:=ctxXOR.nr shr 1;
  asm
    fild  rn
    fimul Num
    fld tbyte ptr divmaxint
    fmulp
    FRNDINT
  end;
  }

{in range max cardinal: 0..2^32-1=4294967295}
// Num*(ctxXOR.nr + 2147483648.0) / 4294967296.0;

{ XOR4096_next(ctxXOR);


  asm
    fild  ctxXOR.nr
    fiadd maxint
    fimul Num
    fld tbyte ptr divmaxlong
    fmulp
    FRNDINT
  end;
 }
end;



procedure XOR_intrand2(Num1,Num2: Cardinal){extended};  stdcall;
var
ResI: Cardinal;
begin

{.379}

// [i,j)  intrand2(i,j) = intrand(j-i)+i

  xor4096_next(ctxXOR);
  ResI:=longint(uint32(ctxXOR.nr)*uint64(abs(Num2-Num1)) shr 32)+Num1;
  asm
    fild ResI
  end;


end;





function xor4096_double53(var ctx: xor4096_ctx): double;
  {-Next random double in [0..1) with full double 53 bit precision}
var
  hb,lb: longint;
begin
  xor4096_next(ctx);
  hb := ctx.nr shr 5;
  xor4096_next(ctx);
  lb := ctx.nr shr 6;
  xor4096_double53 := (hb*67108864.0+lb)/9007199254740992.0;
end;




function XOR_rand2(x1,x2:PDouble): double;  stdcall;
const
 c2:extended = 1/9007199254740992.0;
var
  hb,lb: longint;
begin
  xor4096_next(ctxXOR);
  hb := ctxXOR.nr shr 5;
  xor4096_next(ctxXOR);
  lb := ctxXOR.nr shr 6;


  XOR_rand2:=(x1^-x2^)*((hb*67108864.0+lb)*c2)+x2^;
end;





procedure XOR_rand01;  stdcall;
const
 c2: extended = 1/9007199254740992.0;
 c1: double =  67108864.0;
var
 rn: Cardinal;
 res: extended;
 hb,lb: longint;
begin


  {.357}
  xor4096_next(ctxXOR);
  hb := ctxXOR.nr shr 5;
  xor4096_next(ctxXOR);
  lb := ctxXOR.nr shr 6;

  // (hb*67108864.0+lb)/9007199254740992.0;
  asm
    fild   lb
    fild   hb
    fmul   c1
    faddp
    fld    c2
    fmulp
  end;



end;





{*****************************end xor4096************************************}




function RandomMT: double;
  {-Next random double in [0..1) with full double 53 bit precision}
 const c2:extended = 1/9007199254740992.0;
var
  hb,lb: longint;
begin
  mt19937_next(ctxMTG);
  hb := ctxMTG.nr shr 5;
  mt19937_next(ctxMTG);
  lb := ctxMTG.nr shr 6;
  RandomMT := (hb*67108864.0+lb)*c2;
end;


function _RandG(Mean, StdDev: PExtended): Extended;  stdcall;
{ Marsaglia-Bray algorithm }
var
  U1, S2: Extended;
begin
  repeat
    U1 := 2*RandomMT - 1;
    S2 := Sqr(U1) + Sqr(2*RandomMT-1);
  until S2 < 1;
  Result := Sqrt(-2*Ln(S2)/S2) * U1 * StdDev^ + Mean^;
end;




function std_rand2(x1,x2:PExtended): extended;  stdcall;
begin
 std_rand2:=(x1^-x2^)*random+x2^;
end;





//randomize()
procedure _Randomize;
var
ht,lt,ISeed: Cardinal;
b1,b2: Integer;
begin
InitRandomGenerator;
{
  asm
   push   eax
   push   edx
   RDTSC  //eax:edx
   shr    eax,10
   mov    lt,eax
   mov    ht,edx
   pop    edx
   pop    eax
 end;

  b1:=1; b2:=1;
  if lt  mod 2 <> 0 then b1:=-1;
  if ht  mod 2 <> 0 then b2:=-1;

  ISeed:=b1*lt+b2*ht;

  mt19937_init(ctxMT,ISeed);
  taus113_init(ctxPLE,ISeed);
  xor4096_init(ctxXOR,ISeed);
  mt19937_init(ctxMTG,ISeed); //only for RandG
}
end;



procedure InitRandomGenerator;
var

T1,i,nrnd,x1,x2,ht,lt,ISeed: Cardinal;

//ISeed: LongInt;

DT,DT2,Seed,b1,b2,b3,b4,b5,b6,b7,r: double;
DY,DM,DD,DHr,DMn,DSc,DMs: WORD;
bi1,bi2,bi3: Integer;
begin
  {.203}
  (*
 DT:=Now;
 //DecodeDate( DT, DY, DM, DD);
 DecodeTime( DT, DHr, DMn, DSc, DMs);

 T1:=GetTickCount;

 asm
   push   eax
   push   edx
   RDTSC  //eax:edx
   mov    lt,eax
   mov    ht,edx
   pop    edx
   pop    eax
end;

 //_GetTickProc(ht,lt);
 {
 b1:=1; b2:=1; b3:=1;
 if Dms mod 2 <> 0 then b1:=-1;
 if T1  mod 2 <> 0 then b2:=-1;
 if lt  mod 2 <> 0 then b3:=-1;
 }
 //Seed:=(DY+DM+DD+Dhr+Dmn+Dsc)*DMs;
 //r:=lt/100000000;
 //Seed:=(DY/100+DM+DD+Dhr+Dmn+b1*Dsc+b2*Dms/10+b3*lt/100000000)*(T1/100);

 //ISeed:=Round(abs(Seed));

 b1:=1; b2:=1; b3:=1; b4:=1; b5:=1; b6:=1;b7:=1;
 if DHr mod 2 <> 0 then b1:=-1;
 if DMn mod 2 <> 0 then b2:=-1;
 if DSc mod 2 <> 0 then b3:=-1;
 if DMs mod 2 <> 0 then b4:=-1;
 if T1  mod 2 <> 0 then b5:=-1;
 if lt  mod 2 <> 0 then b6:=-1;
 if ht  mod 2 <> 0 then b7:=-1;

 //ISeed:=Trunc(DHr*b1+DMs*b2+DSc*b3+DMs*b4+T1*b5+lt*b6+ht*b7);
 //ISeed:=DHr*DMs*DSc*DMs*T1*lt*ht;
 ISeed:=(DHr+1)*(DMs+1)*(DSc+1)*(DMs+1)*(T1+1)*(lt+1)*(ht+1);
 //ISeed:=abs(CSeed);


 mt19937_init(ctxMT,ISeed);
 taus113_init(ctxPLE,ISeed);
 xor4096_init(ctxXOR,ISeed);
 mt19937_init(ctxMTG,ISeed); //only for RandG

 mt19937_next(ctxMT);
 taus113_next(ctxPLE);
 xor4096_next(ctxXOR);
 mt19937_next(ctxMTG);  //only for RandG

 *)

 {.357}

 (*
 T1:=GetTickCount;

 asm
   push   eax
   push   edx
   RDTSC  //eax:edx
   mov    lt,eax
   mov    ht,edx
   pop    edx
   pop    eax
end;


 bi1:=1; bi2:=1; bi3:=1;

 if T1  mod 2 <> 0 then bi1:=-1;
 if lt  mod 2 <> 0 then bi2:=-1;
 if ht  mod 2 <> 0 then bi3:=-1;

 //ISeed:=(bi1*T1+1)*(bi2*lt+1)*(bi3*ht+1);

 // ISeed:=(bi1*T1+1) xor ((bi2*lt+1) xor (bi3*ht*ht*ht+1));

 //ISeed:=(bi1*T1+1)*(bi2*lt+1)*(bi3*ht+1)-(bi1*(T1+1)+bi2*(lt+1)+bi3*(ht*ht*ht+1));

  ISeed:=bi1*(T1+1)+bi2*(lt+1)+bi3*(ht*ht*ht+1);


 mt19937_init(ctxMT,ISeed);
 taus113_init(ctxPLE,ISeed);
 xor4096_init(ctxXOR,ISeed);
 mt19937_init(ctxMTG,ISeed); //only for RandG

 mt19937_next(ctxMT);
 taus113_next(ctxPLE);
 xor4096_next(ctxXOR);
 mt19937_next(ctxMTG);  //only for RandG

 *)


 (*
 T1:=GetTickCount;

 asm
   push   eax
   push   edx
   RDTSC  //eax:edx
   mov    lt,eax
   mov    ht,edx
   pop    edx
   pop    eax
 end;


 ISeed:=lt*ht*T1;
   *)

  T1:=GetTickCount;

 asm
   push   eax
   push   edx
   RDTSC  //eax:edx
   mov    lt,eax
   mov    ht,edx
   pop    edx
   pop    eax
end;


 bi1:=1; bi2:=1; bi3:=1;

 if T1  mod 2 <> 0 then bi1:=-1;
 if lt  mod 2 <> 0 then bi2:=-1;
 if ht  mod 2 <> 0 then bi3:=-1;

 //ISeed:=(bi1*T1+1)*(bi2*lt+1)*(bi3*ht+1);

 // ISeed:=(bi1*T1+1) xor ((bi2*lt+1) xor (bi3*ht*ht*ht+1));

 //ISeed:=(bi1*T1+1)*(bi2*lt+1)*(bi3*ht+1)-(bi1*(T1+1)+bi2*(lt+1)+bi3*(ht*ht*ht+1));

  ISeed:=bi1*(T1+1)+bi2*(lt+1)+bi3*(ht*ht*ht+1);



 mt19937_init(ctxMT,ISeed);
 taus113_init(ctxPLE,ISeed);
 xor4096_init(ctxXOR,ISeed);
 //mt19937_init(ctxMTG,ISeed); //only for RandG


 mt19937_next(ctxMT);
 taus113_next(ctxPLE);
 xor4096_next(ctxXOR);
 //mt19937_next(ctxMTG);  //only for RandGT1:=GetTickCount;



 asm
   push   eax
   mov    eax,ISeed
   and    eax,3
   mov    bi1,eax
   pop    eax
 end;

 // 0 < r < 1
  if (bi1 = 0) or (bi1 = 1) then   r:=mt19937_double53(ctxMT)
     else
  if (bi1 = 2)  then               r:=xor4096_double53(ctxXOR)
     else                          r:=taus113_double53(ctxPLE)  ;



 asm
   push   eax
   mov    eax,T1
   and    eax,3
   mov    bi2,eax
   pop    eax
 end;

 if (bi2 = 0)  then      r:=r
     else
 if (bi2 = 1)   then     r:=r*r
     else
  if (bi2 = 2)  then     r:=r*r*r
     else                r:=r*r*r*r  ;

  r:=r*ISeed;
  ISeed:=Trunc(r);

  mt19937_init(ctxMT,ISeed);
  taus113_init(ctxPLE,ISeed);
  xor4096_init(ctxXOR,ISeed);
  mt19937_init(ctxMTG,ISeed*T1); //only for RandG


  mt19937_next(ctxMT);
  taus113_next(ctxPLE);
  xor4096_next(ctxXOR);
  mt19937_next(ctxMTG);  //only for RandGT1:=GetTickCount;


end;



          //***************
//randomize()
//randmt(), randple(), randxor()  in (0,1)
//intrandmt(Num), intrandple(Num), intrandxor(Num)  in (0,Num) Num - int
//rand(array)


{*****************************end random************************************}



function _FACT1(n: integer): extended;//N -> EAX
asm
 push eax
 mov  eax,n
 push  ecx
 mov   ecx, dword ptr [Factorial]
 lea   ecx, [ecx+eax*8]
 lea   eax, [ecx+eax*2]
 fld   tbyte ptr [eax]
 pop   ecx
 pop   eax
 //ret
end;





function _FACT2(n: integer): extended;
asm
      push eax
      mov  eax,n
      push ecx
      mov  ecx,eax
      and  ecx,1
      test ecx,ecx
      jnz  @_fct1
      shr  eax,1
      mov  ecx,dword ptr [Factorial2]
      lea  ecx,[ecx+eax*8]
      lea  eax,[ecx+eax*2]
      fld  tbyte ptr [eax]
      jmp  @end
  @_fct1:
      add  eax,1
      shr  eax,1
      mov  ecx,dword ptr [Factorial1]
      lea  ecx,[ecx+eax*8]
      lea  eax,[ecx+eax*2]
      fld  tbyte ptr [eax]
  @end:
      pop  ecx

      pop  eax
end;






{********************SPLAIN3 (begin) *************************************************}



procedure _LSE(A: TArray2E;  B: TArrayE; var B1: TArrayE; var D: TFloat);
begin
 if _LSEType = f_Jordan then _Jordan(A,B,B1,D) else
 if _LSEType = f_Gauss then _Gausse(A,B,B1,D);
end;





procedure _Gausse(A: TArray2E; B: TArrayE; var B1: TArrayE; var D: TFloat);
label endp;
var
i,j,k,N: Cardinal;
S,T,D1,x: TFloat;
E,Z: Integer;
adrA,adrB,adrB1: TAddress;
P: Pointer;
begin
 N:=Length(A);
 SetLength(B1,N);
 dec(N);
 S_Error:=0;
 adrA:=TAddress(A);  adrB:=TAddress(B); adrB1:=TAddress(B1);
 F_Clm:=0;

 for I := 0 to N - 1 do
   begin
     B1[i]:=0;
   end;

 D1:=1;
 Z:=1;


//EXTENDED:

 for k:=0 to N do
 begin
  if A[k,k] = 0 then
  begin
   _XCHSC(k,k,A,B,E);
   if S_Error = 1 then goto endp;        //ERROR!!!!!!!!!!!!!!!
   Z:=-Z;
   end;
  T:=1/A[k,k];
  D1:=D1*A[k,k];
  for i:=k to N do
  begin
   for j:=k to N do
   begin
    if i=k then A[i,j]:=A[i,j]*T else
    if j>k then A[i,j]:=A[i,j]-A[i,k]*A[k,j];
   end;

   if i=k then B[i]:=B[i]*T else
   if i>k then B[i]:=B[i]-A[i,k]*B[k];
  end;
 end;

 B1[N]:=B[N];

 for k:=N-1 downto 0 do
 begin
  S:=0;
  for i:=N downto k do
  begin
   S:=S+A[k,i]*B1[i];
  end;
   B1[k]:=B[k]-S;
 end;



D:=D1*Z;

if F_Clm = 1 then
begin
 for i:=0 to High(G_TC) do
 begin
  x:=B1[G_TC[i].I1];
  B1[G_TC[i].I1]:=B1[G_TC[i].I2];
  B1[G_TC[i].I2]:=x;
 end;
end;

endp:
end;



procedure _Jordan(A: TArray2E; B: TArrayE; var B1: TArrayE; var D: TFloat);
label endp;
var
N,i,j,k,N1,k1: Integer;
T,T1,T2,D1,x: TFloat;
E,Z: Integer;
adrA,adrB: TAddress;
begin
S_Error:=0;
N:=High(A);
adrA:=TAddress(A);
adrB:=TAddress(B);
F_Clm:=0;
Z:=1;
D1:=1;



//EXTENDED:

for k:=0 to N do
begin

 if A[k,k] = 0 then
 begin
  _XCHSC(k,k,A,B,E);
  if S_Error = 1 then goto endp;   //ERROR!!!!!!!!!!!!!!!
  Z:=-Z;
 end;

 T:=1/A[k,k];

 D1:=D1*A[k,k];

 for j:=k to N do
  begin
    A[k,j]:=A[k,j]*T;
  end;

  B[k]:=B[k]*T;



 for i:=0 to N do
 begin

  if i <> k then
  begin

   T1:=A[i,k];

   for j:=k to N do
   begin
    A[i,j]:=A[i,j]-A[k,j]*T1;
   end;

    B[i]:=B[i]-B[k]*T1;

  end;
 end;
end;


D:=D1*Z;

if F_Clm = 1 then
begin
 for i:=0 to High(G_TC) do
 begin
  x:=B[G_TC[i].I1];
  B[G_TC[i].I1]:=B[G_TC[i].I2];
  B[G_TC[i].I2]:=x;
 end;
end;

B1:=B;
endp:
end;




procedure _CreateSplain3(MX: TArrayE; MF: TArrayE; var idf: cardinal; var E: integer);
label endp;
var
T,Max,D: TFloat;
i,j,k,l,N: LongInt;
B,B1,h,M,F: TArrayE;
A: TArray2E;
MX1,MF1: TArrayE;
A3,A2,A1,A0,PS,Pk0,Pk: TArrayE;
SL: Integer;
SP: TSplain;
begin
N:=High(MX);
S_Error:=0;

SL:=N;
SetLength(F,N+1); SetLength(A,N,N);
SetLength(PS,N+1);  SetLength(B,N);    SetLength(h,N+1);  SetLength(M,N+1);
SetLength(A3,N+1); SetLength(A2,N+1); SetLength(A1,N+1); SetLength(A0,N+1);

SetLength(MX1,N+2);
SetLength(MF1,N+2);
for i:=1 to N+1 do
begin
 MX1[i]:=MX[i-1];
 MF1[i]:=MF[i-1];
end;


k:=N+1;
for i:=1 to N+1 do
begin
 Max:=MX1[1]; l:=1;
 for j:=1 to k do
  begin
   if MX1[j] > Max then
   begin
    Max:=MX1[j]; l:=j;
   end;
 end;

 if l <> k then
 begin
  T:=MX1[l];
  MX1[l]:=MX1[k];
  MX1[k]:=T;
  T:=MF1[l];
  MF1[l]:=MF1[k];
  MF1[k]:=T;
 end;
 dec(k);
end;


for i:=0 to N do
begin
F[i]:=MF1[i+1];
PS[i]:=MX1[i+1];
end;


for i:=1 to N do
begin
h[i]:=PS[i]-PS[i-1];
end;

for i:=1 to N-1 do
begin
B[i]:=(F[i+1]-F[i])/h[i+1]-(F[i]-F[i-1])/h[i];
end;


for i:=1 to N-1 do
begin
for j:=1 to N-1 do
begin
 if j = i-1 then A[i,j]:=h[i]/6
 else
 if j = i then A[i,j]:=(h[i]+h[i+1])/3
 else
 if j = i+1 then A[i,j]:=h[i+1]/6
 else A[i,j]:=0;
end;
end;


////////////////////
for i:=1 to N-1 do
begin
 for j:=1 to N-1 do
 begin
  A[i-1,j-1]:=A[i,j];
 end;
 B[i-1]:=B[i];
end;

SetLength(A,N-1,N-1);
SetLength(B,N-1);
///////////////////


_LSE(A,B,B1,D);
if S_Error = 1  then goto endp;




M[0]:=0; M[N]:=0;
for i:=1 to N-1 do
begin
 M[i]:=B1[i-1];
end;

for i:=1 to N do
begin
 A3[i]:=(M[i]-M[i-1])/(6*h[i]);
 A2[i]:=(M[i-1]*PS[i]-M[i]*PS[i-1])/(2*h[i]);
 A1[i]:=(3*M[i]*sqr(PS[i-1])-3*M[i-1]*sqr(PS[i])-6*F[i-1]+M[i-1]*sqr(h[i])+
        6*F[i]-M[i]*sqr(h[i]))/(6*h[i]);
 A0[i]:=(M[i-1]*fc_intpower(PS[i],3)-M[i]*fc_intpower(PS[i-1],3)+6*PS[i]*F[i-1]-
        M[i-1]*sqr(h[i])*PS[i]-6*PS[i-1]*F[i]+M[i]*sqr(h[i])*PS[i-1])/(6*h[i]);
end;


SetLength(SP.A0,N);
SetLength(SP.A1,N);
SetLength(SP.A2,N);
SetLength(SP.A3,N);
SetLength(SP.PS,N+1);
SP.SL:=SL-1;
for i:=0 to N-1 do
begin
 SP.A0[i]:=A0[i+1];
 SP.A1[i]:=A1[i+1];
 SP.A2[i]:=A2[i+1];
 SP.A3[i]:=A3[i+1];
 SP.PS[i]:=PS[i];
end;
 SP.PS[N]:=PS[N];
 SP.DS:=abs(SP.PS[0]-SP.PS[SP.SL])/(N-1);


 SetLength(GSPL3,Length(GSPL3)+1);
 GSPL3[High(GSPL3)]:=SP;
 idf:=High(GSPL3);


A0:=nil;  A1:=nil; A2:=nil; A3:=nil; PS:=nil;
B:=nil; B1:=nil; H:=nil; M:=nil; F:=nil;
A:=nil; MX1:=nil; MF1:=nil;
endp:
E:=S_Error;
end;





procedure _XCHSC(i,j: Integer; M: TArray2E; B: TArrayE; var E: Integer);
label endp;
var
x: TFloat;
l,k,N: Integer;
begin
E:=0;
N:=High(M);
for k:=i to N do
begin
 if M[k,j] <> 0 then
 begin
  for l:=0 to N do
  begin
   x:=M[i,l]; M[i,l]:=M[k,l]; M[k,l]:=x;
  end;
   x:=B[i]; B[i]:=B[k]; B[k]:=x;
  goto endp;
 end;
end;



for k:=j to N do
begin
 if M[i,k] <> 0 then
 begin
  for l:=0 to N do
  begin
   x:=M[l,j]; M[l,j]:=M[l,k]; M[l,k]:=x;
   SetLength(G_TC,Length(G_TC)+1);
   G_TC[High(G_TC)].I1:=j;
   G_TC[High(G_TC)].I2:=k;
   F_Clm:=1;
  end;
  goto endp;
 end;
end;


S_Error:=1;

endp:
end;














function _FSPL3(x: PExtended; id: integer): TFloat; stdcall;
label 1,2,3,4,endp;
var
SP: ^TSplain;
i,j,SL,Nd,Nu,M: integer;
begin

SP:=@GSPL3[id];
SL:=GSPL3[id].SL+1;


if (x^ < SP^.PS[0]) or (x^ > SP^.PS[SL]) then
begin
 _FSPL3:=0;
 goto endp;
end;

(*
//if SP.EqDs = True then
begin
  m:=trunc(abs(SP^.DS*x^));
  if m = SL then  dec(m);

  if (x^ >= SP^.PS[m]) and (x^ <= SP^.PS[m+1]) then goto 1;
end;
*)


Nd:=-1;   //min-1
Nu:=SL+1; //max+1
2:
//while Nd <> Nu-1 do
begin
  M:=(Nd+Nu) div 2;



  if (x^ >= SP^.PS[M]) and (x^ <= SP^.PS[M+1]) then goto 4
  else
  if (x^ >= SP^.PS[M])
  then Nd:=M
  else Nu:=M;

end;
goto 2;
4:
//j:=M;




{
for i:=0 to SP.SL do
begin
 if (x >= SP.PS[i]) and (x <= SP.PS[i+1]) then begin j:=i; goto 1; end
 else
 if (x <= SP.PS[SL-i]) and (x >= SP.PS[SL-i-1]) then
  begin
    j:=SL-i-1; goto 1;
  end;
end;
 }

1:
//_FSPL3:=SP.A3[j]*x*sqr(x)+SP.A2[j]*sqr(x)+SP.A1[j]*x+SP.A0[j];
_FSPL3:=x^*(x^*(SP^.A3[m]*x^+SP^.A2[m])+SP^.A1[m])+SP^.A0[m];
endp:

  //_FSPL3:=fSplain3(x,GSPL3[id]);
end;




function _FSPL3D1(x: PExtended; id: integer): TFloat; stdcall;
label 1,2,endp;
var
SP: ^TSplain;
i,j,SL,Nd,Nu,M: integer;
begin

SP:=@GSPL3[id];
SL:=GSPL3[id].SL+1;


if (x^ < SP^.PS[0]) or (x^ > SP^.PS[SL]) then
begin
 _FSPL3D1:=0;
 goto endp;
end;


Nd:=-1;   //min-1
Nu:=SL+1; //max+1

2:
//while Nd <> Nu-1 do
begin
  M:=(Nd+Nu) div 2;
  if (x^ >= SP^.PS[M]) and (x^ <= SP^.PS[M+1]) then goto 1
  else
  if (x^ >= SP^.PS[M])
  then Nd:=M
  else Nu:=M;
end;
goto 2;

1:
_FSPL3D1:=(3*SP.A3[m]*x^+2*SP.A2[m])*x^+SP.A1[m];{3*SP^.A3[m]*sqr(x^)+2*SP^.A2[m]*x^+SP^.A1[m];}
endp:
end;




function _FSPL3D2(x: PExtended; id: integer): TFloat; stdcall;
label 1,2,endp;
var
SP: ^TSplain;
i,j,SL,Nd,Nu,M: integer;
begin

SP:=@GSPL3[id];
SL:=GSPL3[id].SL+1;


if (x^ < SP^.PS[0]) or (x^ > SP^.PS[SL]) then
begin
 _FSPL3D2:=0;
 goto endp;
end;


Nd:=-1;   //min-1
Nu:=SL+1; //max+1

2:
//while Nd <> Nu-1 do
begin
  M:=(Nd+Nu) div 2;
  if (x^ >= SP^.PS[M]) and (x^ <= SP^.PS[M+1]) then goto 1
  else
  if (x^ >= SP^.PS[M])
  then Nd:=M
  else Nu:=M;
end;
goto 2;


1:
_FSPL3D2:=6*SP^.A3[m]*x^+2*SP^.A2[m];
endp:
end;




function _FSPL3D3(x: PExtended; id: integer): TFloat; stdcall;
label 1,2,endp;
var
SP: ^TSplain;
i,j,SL,Nd,Nu,M: integer;
begin

SP:=@GSPL3[id];
SL:=GSPL3[id].SL+1;


if (x^ < SP^.PS[0]) or (x^ > SP^.PS[SL]) then
begin
 _FSPL3D3:=0;
 goto endp;
end;


Nd:=-1;   //min-1
Nu:=SL+1; //max+1

2:
//while Nd <> Nu-1 do
begin
  M:=(Nd+Nu) div 2;
  if (x^ >= SP^.PS[M]) and (x^ <= SP^.PS[M+1]) then goto 1
  else
  if (x^ >= SP^.PS[M])
  then Nd:=M
  else Nu:=M;
end;
goto 2;

1:
_FSPL3D3:=6*SP^.A3[m];
endp:
end;




function _FSPL3D4(x: PExtended; id: integer): TFloat; stdcall;
begin
  _FSPL3D4:=0;
end;


{************* SPLAIN3 (end) ***************************************************}


(*
procedure _MaskFPUException;    {.227}
asm
    fnstcw word ptr [CWMEM];       //->store
    sub esp,4
    fnstcw [esp];
    or word ptr [esp], 003Fh;
    fldcw [esp];
    add esp, 4
end;

  {.227}
procedure _IsFPUException; //function: st(0)
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
    fldcw word ptr [CWMEM]   //<-load
end;
*)


procedure _MaskFPUExceptionA;
asm

    fnstcw word ptr [ECX];       //->store
    sub esp,4
    fnstcw [esp];
    or word ptr [esp], 003Fh;
    fldcw [esp];
    add esp, 4

    mov eax,[AddrSwitchFPUExceptSpecFunc]
    mov [eax],1

    //call EnableFPUExceptAddr  //задаёт принудительный вызов FPU исключений при вычислении многих специальных ф-ий.
                              //Только NAN. INF по преждему не вызывают исключений



  // {.393b}
  {
    fnstcw [esp+4];              //->store
    push  [esp+4]
    or word ptr [esp], 003Fh;
    fldcw [esp];
    add esp, 4

    mov eax,[AddrSwitchFPUExceptSpecFunc]
    mov [eax],1
  }
 end;




procedure _IsFPUExceptionA;
asm

    xor  eax,eax
    fnstsw ax
    sahf

    and ax, 001Fh
    push eax
    fild [esp]

    {
    test ax, 001Fh
    fldz
    jz @@Z
    fstp st(0)
    fld1
    @@Z:
    }
    fnclex
    fldcw word ptr [ECX]   //<-load

    mov eax,[AddrSwitchFPUExceptSpecFunc]
    mov [eax],0

    pop  eax

    //call DisableFPUExceptAddr //сбрасывает принудительный вызов FPU исключений при вычислении многих специальных ф-ий.




   //  {.393b}
  {
    xor  eax,eax
    fnstsw ax
    sahf

    and ax, 001Fh
    push eax
    fild [esp]


    fnclex
    fldcw word ptr [ESP+8]   //<-load // +8: push eax; ret

    mov eax,[AddrSwitchFPUExceptSpecFunc]
    mov [eax],0

    pop  eax
  }
end;




procedure _ResetMaskFPUExceptionA;
asm
    fnclex
    fldcw word ptr [ECX]   //<-load

    mov eax,[AddrSwitchFPUExceptSpecFunc]
    mov [eax],0
    //call DisableFPUExceptAddr   //сбрасывает принудительный вызов FPU исключений при вычислении многих специальных ф-ий.
end;


procedure _ReadExceptionFPU;
asm
    xor  eax,eax
    fnstsw ax
    sahf

    and ax, 001Fh
    push eax
    fild [esp]
    add esp, 4

    fnclex
end;




procedure _InitFPU;
asm
    fnclex
    fninit
    fldcw word ptr [ECX]   //<-load
end;




procedure  CallSafe(Addr: Pointer; var Error: integer);      stdcall;
var

  _Error: Integer;

begin
 _Error:=0;

try

 asm
   {
    push eax
    call Addr
    mov eax, [res]
    fstp tbyte ptr [eax]
    pop eax
    }
    call Addr
 end;

except
  on E: EInvalidOp       do  _Error:=1;
  on E: EZeroDivide      do  _Error:=2;
  on E: EOverFlow        do  _Error:=3;
  on E: EUnderFlow       do  _Error:=4;
  on E: EIntOverFlow     do  _Error:=5;
  on E: EAccessViolation do  _Error:=6;
  on E: EOutOfMemory     do  _Error:=7;
  on E: EStackOverFlow   do  _Error:=8;
end;

Error:=_Error;


end;




function  CallRSafe(Addr: Pointer; var Error: integer): extended;      stdcall;
type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;

var
  BResult: Boolean;
  _Error: Integer;
  Res: Extended;

begin

 _Error:=0;

try

 asm
   {
    push eax
    call Addr
    mov eax, [res]
    fstp tbyte ptr [eax]
    pop eax
    }
    call Addr
    fstp tbyte ptr Res
 end;

except
  on E: EInvalidOp       do  begin _Error:=1;  Res:=Nan_x; end;
  on E: EZeroDivide      do  begin _Error:=2;  Res:=PosInf_x; end;
  on E: EOverFlow        do  begin _Error:=3;  Res:=PosInf_x; end;
  on E: EUnderFlow       do  _Error:=4;
  on E: EIntOverFlow     do  _Error:=5;
  on E: EAccessViolation do  _Error:=6;
  on E: EOutOfMemory     do  _Error:=7;
  on E: EStackOverFlow   do  _Error:=8;
end;


//Is Res  NaN or Inf -?
if _Error = 0 then
begin
     BResult := TExtRec(Res).xp and $7FFF=$7FFF;

     if BResult = True then begin _Error:=1; {Res:=1;} end;// else Result:=0;
end;


Error:=_Error;
CallRSafe:=Res;

end;




procedure  CallCxSafe(Addr: Pointer; var Error: integer);      stdcall;
type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;

var
  BResult: Boolean;
  _Error: Integer;
  Re,Im: Extended;

begin
 _Error:=0;
try

 asm
   {
    push eax
    call Addr
    mov eax, [res]
    fstp tbyte ptr [eax]
    pop eax
    }
    call Addr
    fstp tbyte ptr Re
    fstp tbyte ptr Im
 end;

except
  on E: EInvalidOp       do   begin _Error:=1;  Re:=Nan_x; Im:=Nan_x; end;
  on E: EZeroDivide      do   begin _Error:=2;  Re:=PosInf_x; Im:=PosInf_x; end;
  on E: EOverFlow        do   begin _Error:=3;  Re:=PosInf_x; Im:=PosInf_x; end;
  on E: EUnderFlow       do  _Error:=4;
  on E: EIntOverFlow     do  _Error:=5;
  on E: EAccessViolation do  _Error:=6;
  on E: EOutOfMemory     do  _Error:=7;
  on E: EStackOverFlow   do  _Error:=8;
end;


//Is Res  NaN or Inf -?
if _Error = 0 then
begin
     BResult := TExtRec(Re).xp and $7FFF=$7FFF;

     if BResult = True then _Error:=1
     else
     begin
       BResult := TExtRec(Im).xp and $7FFF=$7FFF;
     end;
end;


asm
  fld tbyte ptr Im
  fld tbyte ptr Re
end;

Error:=_Error;

end;





procedure CallMaskFPU(Addr: Pointer; var Error: integer);      stdcall;
var
  _Error: Integer;
   //CW_Addr: Cardinal;
begin
 _Error:=0;


 asm
  //MaskFPU
   sub esp,4
   fnstcw [esp];
   or word ptr [esp], 003Fh;
   fnclex
   fldcw [esp];
   add esp, 4

    call Addr

  // Cath FPU Exception
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
    fistp _Error
 end;

Error:=_Error;

end;




function  CallRMaskFPU(Addr: Pointer; var Error: integer):extended;      stdcall;
type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;

var
  BResult: Boolean;
  _Error: Integer;
   Res: Extended;
   //CW_Addr: Cardinal;
begin
 _Error:=0;


 asm
  //MaskFPU
   sub esp,4
   fnstcw [esp];
   or word ptr [esp], 003Fh;
   fnclex
   fldcw [esp];
   add esp, 4

    call Addr
    fstp tbyte ptr Res

  // Cath FPU Exception
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
    fistp _Error
 end;

//Is Res  NaN or Inf -?
if _Error = 0 then
begin
     BResult := TExtRec(Res).xp and $7FFF=$7FFF;

     if BResult = True then begin _Error:=1; {Res:=1;} end;// else Result:=0;
end;


Error:=_Error;
CallRMaskFPU:=Res;

end;




procedure  CallCxMaskFPU(Addr: Pointer; var Error: integer);      stdcall;
type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;

var
  BResult: Boolean;
  _Error: Integer;
   Re,Im: Extended;
   //CW_Addr: Cardinal;
begin
 _Error:=0;


 asm
  //MaskFPU
   sub esp,4
   fnstcw [esp];
   or word ptr [esp], 003Fh;
   fnclex
   fldcw [esp];
   add esp, 4

    call Addr
    fstp tbyte ptr Re
    fstp tbyte ptr Im

  // Cath FPU Exception
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
    fistp _Error
 end;


//Is Res  NaN or Inf -?
if _Error = 0 then
begin
     BResult := TExtRec(Re).xp and $7FFF=$7FFF;

     if BResult = True then _Error:=1
     else
     begin
       BResult := TExtRec(Im).xp and $7FFF=$7FFF;
     end;
end;


asm
  fld tbyte ptr Im
  fld tbyte ptr Re
end;


Error:=_Error;

end;



procedure _IsNan; assembler;
asm
 sub  esp,10
 fstp tbyte ptr [esp]
 mov  ax,[esp+8]
 add  esp,10
 and  ax,$7fff
 cmp  ax,$7fff
 jnz  @@1
 fld1
 jmp  @@3
 @@1:
 fldz
 @@3:
end;





//Для исключения Math
function fc_IntPower(x: Extended; P: Integer): Extended; assembler;
asm
    fld  x
    mov  eax,P
    call R_IPWR
end;


function fc_Power(x: Extended; p: Extended): Extended; assembler;
asm
    fld  p
    fld  x
    call FPWR
end;


function fc_Ln( X: Extended): Extended;   assembler;
asm
        FLD     X
        FLDLN2
        FXCH
        FYL2X
end;


function fc_Tan(X: Extended): Extended;   assembler;
asm
        FLD    X
        FPTAN
        FSTP   ST(0)
end;


function fc_Log2( X: Extended): Extended;   assembler;
asm
        FLD1
        FLD     X
        FYL2X
end;



function fc_Log10( X: Extended): Extended;   assembler;
asm
        FLDLG2
        FLD     X
        FYL2X
end;



function fc_LogN(Base, X: Extended):Extended;   assembler;
asm
        FLD1
        FLD     X
        FYL2X
        FLD1
        FLD     Base
        FYL2X
        FDIV
end;



(*
procedure _SafeCall(Adr: Cardinal);       {.219}
var
M: Cardinal;
begin
  try
     asm
       //push eax
       //mov  Adr, eax
       call Adr
       //pop  eax
     end;
  except

  end;
end;
 *)



initialization
begin
 //init random numbers generator
 InitRandomGenerator;
 //F_FastSpec:=True;
 F_FastStdFuncReal:=True;
 F_FastStdFuncComplex:=True;
 F_FastDiv:=1;
 CWMEM:=$1372;   {.227}
 _LSEType:=f_Jordan;
 RZDIV_ACC_ADDR:=@Z_RZDIV_STD; {.245}
 ZDIV_ACC_ADDR:=@Z_DIV_STD; {.245}{unused}

 c_DinArrayLenCorrect:=0; {.357}
 {$IFDEF FPC}
    c_DinArrayLenCorrect:=1;
 {$ENDIF}

 RetValOnNil:=0;//Nan_x;

end;


end.
