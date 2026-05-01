unit TestForevalG9;

                    (*программа, тестирующа€ Foreval.dll*)



//{$RangeChecks On}
//{$OverFlowChecks On}
//{$ZEROBASEDSTRINGS Off}


 
{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

 //при непосредственном подключении Foreval (без .dll) запретить ключ "USEDLL"  (также и в Foreval_Lib)
 //At direct connection Foreval (without dll) to disable key  "USEDLL"   (also in Foreval_Lib)

{$DEFINE USEDLL}


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








//  using in internal test

{$DEFINE EXTENDED_FLOAT}     //Type of float variables(real+complex+array): extended/double (only for: x,y,t,s,r & z1,z2,z3,z4,z5 & vu1,vu2,vu3) and arguments in external functions



{.$DEFINE USEFOREVAL}

{$DEFINE FASTDIV}

{.$DEFINE OVERLOADCOMPLEX}

{.$DEFINE SAVEREG}

{.$DEFINE SKIP_COMPILED}        // запрет автокомпил€ции всех предустановленных функций и примеров при старте

interface
uses
   
{$IFDEF FPC}
  Interfaces, 
{$ENDIF}
   Windows,  SysUtils, Classes,  Dialogs, Math, Forms, Controls, StdCtrls,
   ExtCtrls, ComCtrls, DefFN, {Foreval_SpecFunc,}

   {$IFDEF USEFOREVAL}
   //  Forevaldll,
   {$ENDIF}


   {$IFDEF USEDLL}
     Forevaldll;
   {$ELSE}
     Foreval_Lib, Foreval_Definitions;
   {$ENDIF}




{$IFDEF STRINGINT}    type TStringType = String;       {$ENDIF}

{$IFDEF STRING}       type TStringType = String;       {$ENDIF}

{$IFDEF ANSISTRING}   type TStringType = AnsiString;   {$ENDIF}

{$IFDEF WIDESTRING}   type TStringType = WideString;    {$ENDIF}

{$IFDEF PANSICHAR}    type TStringType = PAnsiChar;    {$ENDIF}

{$IFDEF UTF8}         type TStringType = UTF8String;       {$ENDIF}






{$IFDEF EXTENDED_FLOAT}

  type  TFloatType = Extended;
  type  TComplexFloat   = TComplexE;
  type  TFloatArray    = TArrayE;
  const c_ComplexFloat:integer = fl_Complex_Extended;
  const c_RealFloat:integer    = fl_Real_Extended;
  const c_MathType:integer    =  fl_Extended;
  const c_ArrayType:integer   =  fl_ARRAY_REAL_EXTENDED;
  const FloatCellSize:integer = 10;
{$ELSE}

  type  TFloatType = double;
  type  TComplexFloat =   TComplexD;
  type  TFloatArray    = TArrayD;
  const c_ComplexFloat:integer = fl_Complex_Double;
  const c_RealFloat:integer    = fl_Real_Double;
  const c_MathType:integer    =  fl_Double;
  const c_ArrayType:integer   =  fl_ARRAY_REAL_DOUBLE;
  const FloatCellSize:integer = 8;
{$ENDIF}


type PFloatType = ^TFloatType;
type PComplexFloat = ^TComplexFloat;
type PFloatArray  =  ^TFloatArray;

type THexExtW = packed array[0..4] of word;
const NaNXHex     : THexExtW = ($ffff,$ffff,$ffff,$ffff,$7fff); {an extended NaN as hex}
var   NaN_x       : extended absolute NaNXHex;
var   RetValOnNil : extended;

const
 c_pi:extended = 3.1415926535897932384626433832795;

type PArrayI = ^TArrayI;

type TArraySt = array of String;

type TFuncID =
             record
               NumArg: Integer;
               ResType: Integer;
               t1: Integer;
               t2: Integer;
               t3: Integer;
             end;


type TArray2 = array of array of TFloatType;



type
 TComplexNum = record

   re : TFloatType;
   im : TFloatType;

  class operator  Add(const Z1,Z2:TComplexNum):TComplexNum;
  class operator  Add(const x: TFloatType; const Z2:TComplexNum):TComplexNum;
  class operator  Add(const Z1:TComplexNum; const x: TFloatType ):TComplexNum;

  class operator  Subtract(const Z1,Z2:TComplexNum):TComplexNum;
  class operator  Subtract(const x: TFloatType; const Z2:TComplexNum):TComplexNum;
  class operator  Subtract(const Z1:TComplexNum; const x: TFloatType ):TComplexNum;


  class operator  Multiply(const Z1,Z2:TComplexNum):TComplexNum;
  class operator  Multiply(const x: TFloatType; const Z2:TComplexNum):TComplexNum;
  class operator  Multiply(const Z1:TComplexNum; const x: TFloatType ):TComplexNum;


  class operator  Divide(const Z1,Z2:TComplexNum):TComplexNum;
  class operator  Divide(const Z1: TComplexNum; const x:TFloatType): TComplexNum;
  class operator  Divide(const x: TFloatType; const Z2: TComplexNum): TComplexNum;

  class operator  Negative(const Z1: TComplexNum): TComplexNum;


end;

Type TFunc3ReX  = record
                   Expr: String;
                   Addr: Pointer;
                   res:  TFloatType;
                   x:    TFloatType;
                   y:    TFloatType;
                   t:    TFloatType;
                  End;


 Type TFunc4             = record
                              Expr: String;
                              Addr: Pointer;
                              z1:   TComplexFloat;
                              z2:   TComplexFloat;
                              z3:   TComplexFloat;
                              x:    TFloatType;
                              y:    TFloatType;
                              t:    TFloatType;
                              n:    integer;
                              res:  TComplexFloat;
                           End;


type
Tdfvar = record
           n: integer;
           nd: integer;
           s: string;
         end;

         {
type
   PLstVar = ^TLstVar;
   TLstVar = record
                re: Extended;
                im: Extended;
                Variable: TComplexE;
                VecE: TArrayD;
                VecD: TArrayE;
                VecI: TArrayI;
                Name:  String;
                Next:  PLstVar;
               end;
     }

type
TByte10 = record
             b1: byte;
             b2: byte;
             b3: byte;
             b4: byte;
             b5: byte;
             b6: byte;
             b7: byte;
             b8: byte;
             b9: byte;
             b10: byte;
          end;
type
PByte10 = ^TByte10;



type
 TTestExprCmpl =
      record
         RExprEO: Pointer;
         RExprE : Pointer;
         RExprDO: Pointer;
         RExprD : Pointer;
         CExprEO: Pointer;
         CExprE : Pointer;
         CExprDO: Pointer;
         CExprD : Pointer;
         NExpr  : Integer; //номер текущего выражени€ в  TestExprCmpl
         K_Diff: Boolean;
         K_VarXYT: Boolean;
         K_StrCom: Boolean;
         K_CmpED: Boolean;
         K_CmpXYT: Boolean;
         EPrecision: Integer; //14
         EPrecisionIM: Integer; //8-14
         EPrecisionDbl: Integer; //12
         EPrecisionImDbl: Integer; //7-10
      end;



type
 TTestExprList =
     record
       Expr:  String;
         sx1: String;
         sx2: String;
         sx3: String;
         sx4: String;
         sx5: String;
         dx1: Integer;
         dx2: Integer;
         dx3: Integer;
         dx4: Integer;
         dx5: Integer;
       NDiff: Integer; //1-5
       K_Diff: Boolean;
       K_VarXYT: Boolean;
       K_StrCom: Boolean;
       K_CmpED: Boolean;
       K_CmpXYT: Boolean;
       EPrecision: Integer; //14
       EPrecisionIM: Integer; //8-14
       EPrecisionDbl: Integer; //12
       EPrecisionImDbl: Integer; //7-10
       StrCom: String;


       //VType: Integer; //double extended
       //RType: Integer; //real complex
       //Optmz: Integer; //true false
     end;



type
 TTestExprError =
     record
       K_Diff: Boolean;
       K_VarXYT: Boolean;
       K_CmpED: Boolean;
       K_CmpXYT: Boolean;
       K_CalcError,K_PrecError: Boolean;
       //вычислительные погрешности:
       K_CalcError_REO,K_CalcError_RE,K_CalcError_RDO,K_CalcError_RD,K_CalcError_CEO,K_CalcError_CE,K_CalcError_CDO,K_CalcError_CD: Boolean;
       //сравнительные погрешности:
       K_PrecError_EOE,K_PrecError_DOD, K_PrecError_CEOCE,K_PrecError_CDOCD, K_PrecError_EODO, K_PrecError_EOCEO,K_PrecError_DOCDO,
       K_PrecError_ED, K_PrecError_CEOCDO,K_PrecError_CECD: Boolean;

       EPrecision: Integer; //15
       ResCmpRE,ResCmpIM: extended;
       NExpr:  Integer; //номер текущего выражени€ в   TestExprList
       NCExpr:  Integer; //номер текущего выражени€ в  TestExprCmpl

       absErr_Re_EOE,absErr_Im_EOE: Extended;
       absErr_Re_DOD,absErr_Im_DOD: Extended;
       absErr_Re_CEOCE,absErr_Im_CEOCE: Extended;
       absErr_Re_CDOCD,absErr_Im_CDOCD: Extended;
       absErr_Re_EOCEO,absErr_Im_EOCEO: Extended;
       absErr_Re_DOCDO,absErr_Im_DOCDO: Extended;
       absErr_Re_EOE_Diff,absErr_Im_EOE_Diff: Extended;
       absErr_Re_DOD_Diff,absErr_Im_DOD_Diff: Extended;
       absErr_Re_CEOCE_Diff,absErr_Im_CEOCE_Diff: Extended;
       absErr_Re_CDOCD_Diff,absErr_Im_CDOCD_Diff: Extended;
       absErr_Re_EOCEO_Diff,absErr_Im_EOCEO_Diff: Extended;
       absErr_Re_DOCDO_Diff,absErr_Im_DOCDO_Diff: Extended;

     end;



type
 TTestExprDiff =
     record
       sx: String;
       dx: Integer;
     end;



type
  TTestExprTask = class(TThread)
  private
     //Result: TFloat;
  protected
    procedure Execute; override;

  public
    constructor Create;
    //function  _Root: TFloat;
    //function  _Sum1: TFloat;
    //function  _Sum2: TFloat;
  end;


  const
    CompiledByDelphi = 0;
    CompiledByFPC = 1;


type

  { TForm1 }

  TForm1 = class(TForm)
    B_Calc: TButton;
   CB_DCR: TCheckBox;
   CB_DCZ: TCheckBox;
   GB_RT: TGroupBox;
    LFR: TLabel;
    Label2: TLabel;
    EF: TEdit;
    Label5: TLabel;
    LIPF: TLabel;
    LCTF: TLabel;
    LCT: TLabel;
    LP: TLabel;
    LCT1: TLabel;
    CB_OM: TCheckBox;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Ez1x: TEdit;
    Ez2x: TEdit;
    Ez1y: TEdit;
    Ez2y: TEdit;
    EX: TEdit;
    EY: TEdit;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    E_Cnt: TEdit;
    GroubBox2: TGroupBox;
    Panel1: TPanel;
    RB_SD: TRadioButton;
    RB_SE: TRadioButton;
    Label10: TLabel;
    Label14: TLabel;
    EN: TEdit;
    EK: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EA0: TEdit;
    EA1: TEdit;
    EA2: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    GB_FVT: TGroupBox;
    RB_FVD: TRadioButton;
    RB_FVE: TRadioButton;
    B_DefFunc: TButton;
    Label24: TLabel;
    LST: TLabel;
    MT: TMemo;
    B_CompFunc: TButton;
    Ez3x: TEdit;
    Ez3y: TEdit;
    ET: TEdit;
    EJ: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    GB_Opt: TGroupBox;
    GB_Repl: TGroupBox;
    CB_RF: TCheckBox;
    GB_Opr: TGroupBox;
    CB_DIV: TCheckBox;
    CB_RAS: TCheckBox;
    CB_MUL: TCheckBox;
    CB_OP: TCheckBox;
    Label13: TLabel;
    UDSD: TUpDown;
    B_RunProg: TButton;
    CB_RME: TCheckBox;
    CB_DRL: TCheckBox;
    CB_VCx: TCheckBox;
    MT1: TMemo;
    MT2: TMemo;
    LPFT: TLabel;
    Label12: TLabel;
    CB_RFCS: TCheckBox;
    CB_SKIF: TCheckBox;
    CB_MULDIV: TCheckBox;
    CB_DCEM: TCheckBox;
    bTest: TButton;
    ETest: TEdit;
    GB_PrecCl: TGroupBox;
    RB_PD: TRadioButton;
    RB_PE: TRadioButton;
    IntTest: TButton;
    B_ShowDiffStr: TButton;
    Label34: TLabel;
    LDFT: TLabel;
    B_CaclDiff: TButton;
    E_DX: TEdit;
    E_DY: TEdit;
    E_DT: TEdit;
    E_DS: TEdit;
    Label_dx: TLabel;
    Label_dxn: TLabel;
    Label_dy: TLabel;
    Label_dyn: TLabel;
    Label_dt: TLabel;
    Label_dtn: TLabel;
    Label_dz: TLabel;
    Label_dzn: TLabel;
    LDR: TLabel;
    LDPT: TLabel;
    LDCT: TLabel;
    GB_XchBr: TGroupBox;
    RB_XbAuto: TRadioButton;
    RB_XbEnable: TRadioButton;
    RB_XBdisable: TRadioButton;
    GB_DinLd: TGroupBox;
    RB_DLEnable: TRadioButton;
    RB_DLDisable: TRadioButton;
    CB_CalcConstInTree: TCheckBox;
    CB_IntArg: TCheckBox;
    GB_NumDiff: TGroupBox;
    Label11: TLabel;
    Label22: TLabel;
    E_NP: TEdit;
    E_PH: TEdit;
    Label23: TLabel;
    B_RDO: TButton;
    L_DO: TLabel;
    CB_ND: TCheckBox;
    CB_CalcConstWholeExpr: TCheckBox;
    CB_CalcConstMulDiv: TCheckBox;
    CB_CalcConstFunc: TCheckBox;
    RB_AsIs: TRadioButton;
    RB_Re: TRadioButton;
    RB_Cx: TRadioButton;
    Label25: TLabel;
    L_AFT: TLabel;
    CB_AccFunc: TCheckBox;
    CB_DFvars: TCheckBox;
    B_Refresh: TButton;
    CB_CXAnyAddr: TCheckBox;
    GB_CXDIV: TGroupBox;
    RB_ZDiv_Fast: TRadioButton;
    RB_ZDiv_STD: TRadioButton;
    RB_ZDiv_ACC: TRadioButton;
    RB_ZDiv_Extra: TRadioButton;
    Label35: TLabel;
    LExprLen: TLabel;
    CB_TestExpr: TCheckBox;
    BClearMT: TButton;
    GB_Syntax: TGroupBox;
    CB_LeadToLower: TCheckBox;
    CB_ControlSpace: TCheckBox;
    CB_ExtCom: TCheckBox;
    Label32: TLabel;
    E_CntProg: TEdit;
    CB_ShowDiff: TCheckBox;
    CB_Package: TCheckBox;
    CB_RV: TCheckBox;
    RB_FVS: TRadioButton;
    EAre: TEdit;
    EAim: TEdit;
    Label40: TLabel;
    Label50: TLabel;
    Label53: TLabel;
    EBre: TEdit;
    ECre: TEdit;
    EBim: TEdit;
    ECim: TEdit;
    Label51: TLabel;
    Label52: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    CB_RedArg: TCheckBox;
    CB_DelZeroBranch: TCheckBox;
    CB_PCInline: TCheckBox;
    CB_VirtAlloc: TCheckBox;
    CB_Actg_Type: TCheckBox;
    CB_LGC_Names: TCheckBox;
    CB_LGC_SYMBS: TCheckBox;
    CB_MaskFPU: TCheckBox;
    CB_NoCalc: TCheckBox;
    CB_SafeCalc: TCheckBox;
    CB_Create: TButton;
    CB_Destroy: TButton;

    procedure B_CalcClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure CreateForm;
    //procedure TimerExTimer(Sender: TObject);
    procedure OutStr(Sout: String);

    procedure RefreshVar;
   
    procedure Ez1xChange(Sender: TObject);
    procedure Ez1yChange(Sender: TObject);
    procedure Ez2xChange(Sender: TObject);
    procedure Ez2yChange(Sender: TObject);
    procedure EXChange(Sender: TObject);
    procedure ENChange(Sender: TObject);
    procedure EKChange(Sender: TObject);
    procedure EYChange(Sender: TObject);
    procedure RB_SDClick(Sender: TObject);
    procedure RB_SEClick(Sender: TObject);
    procedure CB_OPClick(Sender: TObject);
    procedure EA0Change(Sender: TObject);
    procedure EA1Change(Sender: TObject);
    procedure EA2Change(Sender: TObject);
    procedure RB_FVDClick(Sender: TObject);
    procedure RB_FVEClick(Sender: TObject);
    procedure UDSDClick(Sender: TObject; Button: TUDBtnType);
    procedure B_DefFuncClick(Sender: TObject);
    procedure ShowError;
    procedure ShowCalcError(CErr: Cardinal);
    procedure ShowCompilationData(FS: Pointer);
    procedure DestroyForm;
    procedure FormDestroy(Sender: TObject);
    procedure CB_RFClick(Sender: TObject);
    procedure CB_DIVClick(Sender: TObject);
    procedure CB_MULClick(Sender: TObject);
    procedure CB_RASClick(Sender: TObject);

    procedure  CompTextProg;
    procedure  CompTextFunc;
    procedure  TestAll;
    procedure B_CompFuncClick(Sender: TObject);
    procedure ETChange(Sender: TObject);
    procedure EJChange(Sender: TObject);
    procedure Ez3xChange(Sender: TObject);
    procedure Ez3yChange(Sender: TObject);

    procedure B_RunProgClick(Sender: TObject);
    procedure CB_RMEClick(Sender: TObject);
    procedure CB_DRLClick(Sender: TObject);
    procedure CB_VCxClick(Sender: TObject);
    procedure CB_RFCSClick(Sender: TObject);
    procedure CB_DCRClick(Sender: TObject);
    procedure CB_DCZClick(Sender: TObject);
    procedure CB_MULDIVClick(Sender: TObject);
    procedure CB_SKIFClick(Sender: TObject);
    procedure CB_DCEMClick(Sender: TObject);
    procedure bTestClick(Sender: TObject);
    procedure RB_PEClick(Sender: TObject);
    procedure RB_PDClick(Sender: TObject);
    procedure IntTestClick(Sender: TObject);
    procedure bExprFileClick(Sender: TObject);
    procedure ETestChange(Sender: TObject);
    procedure bDiffExprFileClick(Sender: TObject);
    procedure B_ShowDiffStrClick(Sender: TObject);
    procedure B_CaclDiffClick(Sender: TObject);
    procedure RB_XbAutoClick(Sender: TObject);
    procedure RB_XbEnableClick(Sender: TObject);
    procedure RB_XBdisableClick(Sender: TObject);
    procedure RB_DLEnableClick(Sender: TObject);
    procedure RB_DLDisableClick(Sender: TObject);
    procedure CB_CalcConstInTreeClick(Sender: TObject);
    procedure CB_IntArgClick(Sender: TObject);
    procedure B_RDOClick(Sender: TObject);
    procedure NumDiff;
    procedure InitDF;
    procedure CB_CalcConstWholeExprClick(Sender: TObject);
    procedure CB_CalcConstMulDivClick(Sender: TObject);
    procedure CB_CalcConstFuncClick(Sender: TObject);
    procedure RB_AsIsClick(Sender: TObject);
    procedure RB_ReClick(Sender: TObject);
    procedure RB_CxClick(Sender: TObject);
    procedure CB_AccFuncClick(Sender: TObject);
    procedure CB_DFvarsClick(Sender: TObject);
    procedure B_RefreshClick(Sender: TObject);
    procedure CB_CXAnyAddrClick(Sender: TObject);
    procedure RB_ZDiv_FastClick(Sender: TObject);
    procedure RB_ZDiv_STDClick(Sender: TObject);
    procedure RB_ZDiv_ACCClick(Sender: TObject);
    procedure RB_ZDiv_ExtraClick(Sender: TObject);
    procedure CB_PackageClick(Sender: TObject);
    procedure BClearMTClick(Sender: TObject);
    procedure CB_LeadToLowerClick(Sender: TObject);
    procedure CB_ControlSpaceClick(Sender: TObject);
    procedure CB_ExtComClick(Sender: TObject);
    procedure CB_ShowDiffClick(Sender: TObject);
    procedure CB_RVClick(Sender: TObject);
    procedure RB_FVSClick(Sender: TObject);
    procedure EAreChange(Sender: TObject);
    procedure EBreChange(Sender: TObject);
    procedure ECreChange(Sender: TObject);
    procedure EAimChange(Sender: TObject);
    procedure EBimChange(Sender: TObject);
    procedure ECimChange(Sender: TObject);
    procedure CB_RedArgClick(Sender: TObject);
    procedure CB_DelZeroBranchClick(Sender: TObject);
    procedure CB_PCInlineClick(Sender: TObject);
    procedure CB_VirtAllocClick(Sender: TObject);
    procedure CB_Actg_TypeClick(Sender: TObject);
    procedure CB_LGC_NamesClick(Sender: TObject);
    procedure CB_LGC_SYMBSClick(Sender: TObject);
    procedure CB_MaskFPUClick(Sender: TObject);
    procedure CB_NoCalcClick(Sender: TObject);
    procedure CB_SafeCalcClick(Sender: TObject);
    procedure CB_DestroyClick(Sender: TObject);
    procedure CB_CreateClick(Sender: TObject);
    

  private



  protected



  public

   ExprFile: TStringList;
   F_LoadExprFile: Boolean;
   TestExprCmpl:     array of TTestExprCmpl;
   TestExprList:     array of TTestExprList;
   TestExprDiff:     array of TTestExprDiff;
   TestExprError:    array of TTestExprError;

   procedure TestM1F;
   function  Test1F(VE1,VE2: array of extended; x1,x2: extended):extended;
   procedure ConvStr(P: Pointer; var S: String);
   function  ConvStrOut(S: String): TStringType;

     procedure FullOptimization;
     procedure WithoutReplaceOperations;
     procedure WithoutOptimizations;
     procedure LoadExprTestFile(NameF: String);
     function  CompileExprTest: Boolean;
     procedure RunExprTest;
     procedure ShowTestExprError;
     procedure FreeCompiledList;



   //function Abs(const z1: TComplexNum): extended; overload;

   {X,Y,T,a,b,c,d,e, x1,x2,x3,x4: Double;
   EX,EY,ET,ea,eb,ec,ed,ee: Extended;
   Z1,Z2,Z3: TComplexD;
   EZ1,EZ2,EZ3: TComplexE;
   VD,AD: TArrayD;
   VE,ADE: TArrayE;
   adrXVD,adrXVE,adrXVI: Pointer;
   VI: TArrayI;
   n,k,j: Integer;
   adrAint,adrBint: Pointer;

   zp: PComplexD;
   }
   procedure  CompilePC;



    procedure TestMulti;
    function _Result(Func: Pointer): extended;

    procedure InitIntegral;

  published

     function SpeedCpuFpu: TFloatType;



  end;


  function Re(const Z1: TComplexNum): TFloatType;
  function Im(const Z1: TComplexNum): TFloatType;

  procedure  CreateIntArray;
  function Test2F: double;

  function spadr0: TFloatType;  stdcall;


  function CallF(Addr: Pointer): Extended; assembler;
  function  Integral1(Func: Pointer;  PV: PFloatType; a,b: TFloatType): TFloatType;
  procedure CreateM1u;
  //function  Integral2F(Func: TAddress;  PV1,PV2: PFloatType; a,b: TFloatType; Func1,Func2: TAddress): TFloatType;
  //function  Integral2(Func: TAddress;  PV1: PFloatType; PV2: PFloatType; a,b,c,d: TFloatType): TFloatType;
  //function  Integral3(Func: TAddress;  PV1,PV2,PV3: PFloatType; a,b,c,d,e,f: TFloatType): TFloatType;  overload;
  //function  Integral3F(Func: TAddress;  PV1,PV2,PV3: PFloatType; a,b,c,d: TFloatType; Func1,Func2: TAddress): TFloatType;
  function  Integral3FF(Func: Pointer;  PV1,PV2,PV3: PFloatType; a,b: TFloatType; Func1,Func2,Func3,Func4: Pointer): TFloatType;  stdcall;
  function FRInt1XYT(): TFloatType;
  function FRInt2XYT(): TFloatType;
  function FRInt3XYT(): TFloatType;
  function FRLim1X(): TFloatType;
  function FRLim2X(): TFloatType;
  function FRLim3XY(): TFloatType;
  function FRLim4XY(): TFloatType;







var


   Xd,Yd,Td,Sd,Pd,Qd,Ud,Rd,V_d,    a,b,c,d,e, x1d, x2d, x3d, x4d, x5d, res: Double;
   Xe,Ye,Te,Se,Pe,Qe,Ue,R_e,V_e,   Ae,Be,Ce,De,Ee,Fe,Ge,  P1r,P2r,  x1e,x2e,x3e,x4e,x5e: Extended;
   Xs,Ys,Ts,Ss,Rs,X1s,X2s,X3s,X4s,X5s: Single;
   Z1d,Z2d,Z3d,Z4d,Z5d,   zxd,zyd,ztd,zsd: TComplexD;
   Z1e,Z2e,Z3e,Z4e,Z5e,   zxe,zye,zte,zse,{resf,}Acx,Bcx,Ccx,Dcx,Ecx,Fcx,Gcx,  P1cx,P2cx,P3cx,P4cx,P5cx,P6cx: TComplexE;
   resf: TComplexFloat;
   Z1s,Z2s,Z3s,Z4s,Z5s,   zxs,zys,zts,zss: TComplexS;
   ptr1,ptr2,ptr3,ptr4,ptr5: Pointer;


   resr: Extended;
   VX,CP: Array of Extended;
   VDZ: Array of TComplexD;
   CFA: array of Pointer;

   z1,z2,z3,z4,z5,i,i0,rezCx: TComplexNum;
   n,k,j,m,l,ii: Integer;
   n1,n2,n3,n4,n5: Integer;
   errorf: Integer;
   x,y,t,s: TFloatType;
   PVX,PVY,PVT,PVR,PVS: PFloatType;
   PVZ1,PVZ2,PVZ3,PVZ4,PVZ5: PComplexFloat;
   PtrF1,PtrF2,PtrF3,PtrF4: Pointer;
   vpfInt: TArrayP;
   addrXs,addrYs,addrTs: Pointer;
   addrZ1s,addrZ2s,addrZ3s: Pointer;
   MEM: Cardinal;


   an,bn: array [1..15] of extended; //интегральные коэффиценты
   P_Integral, N_Integral: Integer;

   fnc1, fnc2, fnc3, fnc4, fnc5, fnc1A, fnc2A, fnc3A: TFunc4;

   CxVarAnyRE_E :array [1..20] of  Extended;
   CxVarAnyIM_E :array [1..20] of  Extended;
   CxVarAnyRE_D :array [1..20] of  Double;
   CxVarAnyIM_D :array [1..20] of  Double;
   CxVarAnyRE_S :array [1..20] of  Single;
   CxVarAnyIM_S :array [1..20] of  Single;

   z1re,z1im,z2re,z2im,z3re,z3im: Integer;
   {
    z1re = 1;  z1im = 5;
    z2re = 11; z2im = 3;
    z3re = 9;  z3im = 19;
    z1.re = CxVarAnyRE[z1re]; z1.im = CxVarAnyIM[z1im];
    z2.re = CxVarAnyRE[z2re]; z2.im = CxVarAnyIM[z2im];
    z3.re = CxVarAnyRE[z3re]; z3.im = CxVarAnyIM[z3im];
   }

   VD,AD,VD1,VD2,VD3,VECD,VDT,  VD4,VD5,VD6: TArrayD;
   VE,ADE,VE1,VE2,VE3,VECE,VET, VE4,VE5,VE6: TArrayE;
   VS,VS1,VS2,VS3, VS4,VS5,VS6: TArrayS;
   VX1,VX2,VX3,VX4,VX5: TArrayE;
   VP1,VP2,VP3,VPU,VPF1,VPF2,VPF3: TArrayP;
   VU1,VU2,VU3,CP12,VU1T,VU2T,VU3T: TFloatArray;    //Universal array.  Type depends from key EXTENDED_FLOAT
   CP12d: TArrayD;
   CP12s: TArrayS;
   CP12i: TArrayI;
   adrXVD,adrXVE,adrXVI,adrXVS,adrGVD,adrGVDF,FDyn,adrExtZ: Pointer;
   adrVD4,adrVD5,adrVD6,adrVE4,adrVE5,adrVE6,adrVS4,adrVS5,adrVS6,adrVI4,adrVI5,adrVI6:Pointer;
   VI,VI1,VI2,VI3,VECI,VIT, VI4,VI5,VI6: TArrayI;
   XSPL,YSPL: TArrayE;
   adrAint,adrBint: Pointer;
   mxd1,mxd2: TArrayD;
   zp: PComplexD;
   Form1: TForm1;
   //TimerEx: TTimer;
   TestExprTask: TTestExprTask;
   OpenFile: TOpenDialog;

   G_TestExprEx: Boolean;
   G_BeginPosEx: Integer;
   GS_TestExprEx: array of String;
   F_NoCalc,F_SafeCalc: Boolean;

  //VSI: array [0..1000] of integer;
  adrVD1,adrVD2,adrVE1,adrVE2: Pointer;
  NC: Cardinal;
  VSI: TArrayI;
  MAR,MAC: TMemo;
  FDFN: TFuncPC;
  G_FMT: TFormatSettings;
   Aint,Bint: array of extended;
   XVE1,XVE2: array of extended;
   dbEAX1,dbEAX2,dbEBX1,dbEBX2,dbECX1,dbECX2,dbEDX1,dbEDX2,dbESI1,dbESI2,dbEDI1,dbEDI2,dbESP1,dbESP2,dbEBP1,dbEBP2: Cardinal;
   adrVDX,adrVDY: pointer;
   F_Error: Boolean;
   ndx,ndy,ndt,nds: cardinal;
   testx1,testx2: TComplexD;
   CntExpr: Integer;
   Adv: array [1..4] of Tdfvar;
   G_FResult: TComplexFloat;
   G_ResCalcType: Integer;
   G_ZDIV: Integer;
   F_DefFunc,F_DefFuncDeriv: Boolean;
   S_FuncName: String;
   FPUError,PFPUErrorAddr: Cardinal;
   G_LenV: Cardinal;

   cpl16: array of TComplexD; //array of 16 byte


  // VL,VL1,VL2: PLSTVar;


implementation
var
G_Res: TComplexE;
MEM1,MEM2,MEM3,MEM4: Cardinal;
c2: double;
CAddr1,CAddr2,CAddr3: Cardinal;
vdt1,vdt2: TarrayD;
M1u,M1ut,M1ux,M1uy: TFloatArray;
LenSCM1u: Integer;
Ptr0M1u, Ptr0M1ux, Ptr0M1uy: Pointer;
Ptr0VU1, Ptr0VU2, Ptr0VU3: Pointer;
CompiledBy: Integer;



{$IFDEF FPC}
   {$R *.LFM}
{$ELSE}
   {$R *.DFM}
{$ENDIF}




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
  FS.Place:=fl_NEW; //fl_ReWRITE;
  FS.ResultTypeMath:=fl_EXTENDED;
  FS.IsInline:= fl_No; {fl_Yes;}
  FS.Rsrv1:=0;
  FS.Rsrv2:=0;
  FS.Rsrv3:=0;
end;




function TForm1.ConvStrOut(S: String): TStringType;
var
S1: String;
ECode: Cardinal;
PC: PChar;
Ans: AnsiString;
str:TStringType;
ws: widestring;
PAC: PAnsiChar;
su8: UTF8String;
SExpr: TStringType;
begin

 {$IFDEF PANSICHAR}
       ans:=AnsiString(S); SExpr:=PAnsiChar(ans);
  {$ELSE}
       SExpr:=TStringType(S);
   {$ENDIF}

   ConvStrOut:=SExpr;
end;




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
    //MessageDlg(S+#13#10+SE+#13#10+'"'+Str+'"',mtError,[mbOk],0);
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


 //так лучше: сначала копирование строки затем обнуление - поможет избежать возможных ошибок, св€занных с передачей строк (конфликт разных менеджеров пам€ти)
 //it's better: at first,  copying of a string then reset - will help to avoid the possible mistakes connected with transfer of strings  (the conflict of different managers of memory)
   {$IFDEF ANSISTRING}       Ans:=AnsiString(P);    S1:=Copy(Ans,1,Length(Ans)); Ans:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}
   {$IFDEF STRING}           Str:=String(P);        S1:=Copy(Str,1,Length(Str)); Str:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}
   {$IFDEF WIDESTRING}       ws:=WideString(P);     S1:=Copy(ws,1,Length(ws));   ws:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0);{$ENDIF}
   {$IFDEF UTF8}             su8:=UTF8String(P);    S1:=Copy(Su8,1,Length(Su8)); Su8:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}
   {$IFDEF PANSICHAR}        PAC:=PAnsiChar(P);     Ans:=AnsiString(PAC); S1:=Copy(Ans,1,Length(Ans)); Ans:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"'+#13#10+SEF+#13#10,mtError,[mbOk],0); {$ENDIF}

   (*
  {$IFDEF ANSISTRING}       Ans:=AnsiString(P);    S1:=Copy(Ans,1,Length(Ans)); Ans:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"',mtError,[mbOk],0); {$ENDIF}
  {$IFDEF STRING}           Str:=String(P);        S1:=Copy(Str,1,Length(Str)); Str:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"',mtError,[mbOk],0); {$ENDIF}
  {$IFDEF WIDESTRING}       ws:=WideString(P);     S1:=Copy(ws,1,Length(ws));   ws:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"',mtError,[mbOk],0);{$ENDIF}
  {$IFDEF UTF8}             su8:=UTF8String(P);    S1:=Copy(Su8,1,Length(Su8)); Su8:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"',mtError,[mbOk],0); {$ENDIF}
  {$IFDEF PANSICHAR}        PAC:=PAnsiChar(P);     Ans:=AnsiString(PAC); S1:=Copy(Ans,1,Length(Ans)); Ans:=''; MessageDlg(S+#13#10+SE+#13#10+'"'+S1+'"',mtError,[mbOk],0); {$ENDIF}
  *)

endp:
end;



procedure TForm1.ShowCalcError(CErr: Cardinal);
var
S: String;
begin

  case  CErr of

     fl_ZERO_DIVIDE:                S:= 'ZERO DIVIDE';
     fl_INVALID_OPERATION:          S:= 'INVALID OPERATION';
     fl_OVERFLOW:                   S:= 'OVERFLOW';
     fl_ACCESS_VIOLATION:           S:= 'ACCESS VIOLATION';
     fl_STACK_OVERFLOW:             S:= 'STACK OVERFLOW';
     fl_OUT_OF_MEMORY:              S:= 'OUT OF MEMORY';
     fl_COMMON_CALCULATON_ERROR:    S:= 'COMMON CALCULATON_ERROR';

  end;

   MessageDlg(S,mtError,[mbOk],0);

end;


//********************** PRINT**************************************************

procedure PrintR(ResR: Extended; IdW: Integer); stdcall;
begin
 if IdW = 1 then Form1.MT.Lines.Add(FloatToStr(ResR))
 else
 if IdW = 2 then Form1.MT2.Lines.Add(FloatToStr(ResR));
end;


procedure PrintC(ResC: TComplexE; IdW: Integer);   stdcall;
begin
 if IdW = 1 then Form1.MT.Lines.Add(FloatToStr(ResC.re)+'       '+FloatToStr(ResC.im)+'i')
 else
 if IdW = 2 then Form1.MT2.Lines.Add(FloatToStr(ResC.re)+'       '+FloatToStr(ResC.im)+'i');
end;





procedure PrintVE(VE: TArrayE; IdW: Integer);   stdcall;
var
n: integer;
begin
 if IdW = 1 then
 begin
   for n := 0 to High(VE) do
   begin
      Form1.MT.Lines.Add(FloatToStr(VE[n],G_FMT))
   end;
 end
 else
 if IdW = 2 then
 begin
   for n := 0 to High(VE) do
   begin
      Form1.MT2.Lines.Add(FloatToStr(VE[n],G_FMT))
   end;
 end
end;




procedure PrintVD(VD: TArrayD; IdW: Integer);   stdcall;
var
n: integer;
begin
 if IdW = 1 then
 begin
   for n := 0 to High(VD) do
   begin
      Form1.MT.Lines.Add(FloatToStr(VD[n]))
   end;
 end
 else
 if IdW = 2 then
 begin
   for n := 0 to High(VD) do
   begin
      Form1.MT2.Lines.Add(FloatToStr(VD[n]))
   end;
 end
end;





procedure PrintVI(VI: TArrayI; IdW: Integer);   stdcall;
var
n: integer;
begin
 if IdW = 1 then
 begin
   for n := 0 to High(VI) do
   begin
      Form1.MT.Lines.Add(IntToStr(VI[n]))
   end;
 end
 else
 if IdW = 2 then
 begin
   for n := 0 to High(VI) do
   begin
      Form1.MT2.Lines.Add(IntToStr(VI[n]))
   end;
 end
end;




procedure PrintVS(VS: TArrayS; IdW: Integer);   stdcall;
var
n: integer;
begin
 if IdW = 1 then
 begin
   for n := 0 to High(VS) do
   begin
      Form1.MT.Lines.Add(FloatToStrF(VS[n],ffGeneral,5,3,G_FMT))
   end;
 end
 else
 if IdW = 2 then
 begin
   for n := 0 to High(VS) do
   begin
      Form1.MT2.Lines.Add(FloatToStrF(VS[n],ffGeneral,5,3,G_FMT))
   end;
 end
end;




procedure PrintSpace(NS: Integer; IdW: Integer);   stdcall;
var
n: integer;
begin
 if IdW = 1 then
 begin
   for n := 1 to NS do
   begin
      Form1.MT.Lines.Add('');
   end;
 end
 else
 if IdW = 2 then
 begin
   for n := 1 to NS do
   begin
      Form1.MT2.Lines.Add('');
   end;
 end
end;





procedure PrintLine(IdW: Integer);   stdcall;
var
n: integer;
begin
 if IdW = 1 then
 begin
      Form1.MT.Lines.Add('__________________________________________');
 end
 else
 if IdW = 2 then
 begin
      Form1.MT2.Lines.Add('__________________________________________');
 end
end;




procedure PrintAsterisk(IdW: Integer);   stdcall;
var
n: integer;
begin
 if IdW = 1 then
 begin
      Form1.MT.Lines.Add('***************************************************************');
 end
 else
 if IdW = 2 then
 begin
      Form1.MT2.Lines.Add('***************************************************************');
 end
end;




//*******************************************************************************




procedure s_rrz(r1,r2: PDouble{PExtended};z1:PComplexD); cdecl;//stdcall;//pascal;
var
N,i:Integer;
Sz: TComplexD;
begin

 Sz.re:=r1^+r2^+z1^.re;
 Sz.im:=z1^.im;


 asm
  fld Sz.im
  fld Sz.re
 end
end;


procedure s_zzr(z1,z2: PComplexD;r1:PDouble{PExtended}); {cdecl;}stdcall;//pascal;
var
N,i:Integer;
Sz: TComplexD;
begin

 Sz.re:=z1^.re+z2^.re+r1^;
 Sz.im:=z1^.im+z2^.im;

 asm
  fld Sz.im
  fld Sz.re
 end
end;



procedure e_rrz(adr: Cardinal); pascal;//stdcall;
var
N,i:Integer;
Sz: TComplexE;
z1,z2: TComplexE;
r1,r2,Sx,Sy: Double;
begin
 r1:=PDouble{PExtended}(Adr)^;
 r2:=PDouble{PExtended}(Adr+16)^;
 z1.re:={PDouble}PExtended(Adr+32)^ ;
 z1.im:={PDouble}PExtended(Adr+48)^;

 Sz.re:=r1+r2+z1.re;
 Sz.im:=z1.im;

 asm
  fld Sz.im
  fld Sz.re
 end
end;



procedure e_zzr(adr: Cardinal); stdcall;
var
N,i:Integer;
Sz: TComplexE;
z1,z2: TComplexE;
r1,r2,Sx,Sy: Double;
begin
 z1.re:={PDouble}PExtended(Adr)^;
 z1.im:={PDouble}PExtended(Adr+16)^;
 z2.re:={PDouble}PExtended(Adr+32)^ ;
 z2.im:={PDouble}PExtended(Adr+48)^;
 r1:=PDouble{PExtended}(Adr+64)^;

 Sz.re:=z1.re+z2.re+r1;
 Sz.im:=z1.im+z2.im;

 asm
  fld Sz.im
  fld Sz.re
 end
end;




function SA1(adr: Cardinal): double; cdecl;
begin
 SA1:=PDouble(adr)^*PDouble(adr)^;
end;


function SA2(adr: Cardinal): double; pascal;
begin
 SA2:=PDouble(adr)^-PDouble(adr+16)^;
end;


function SA3(adr: Cardinal): double; pascal;
begin
 SA3:=PDouble(adr)^+PDouble(adr+16)^-PDouble(adr+32)^;
end;


function SA4(adr: Cardinal): double; stdcall;
begin
 SA4:=PExtended(adr)^+PDouble(adr+16)^-PExtended(adr+32)^*PDouble(adr+48)^;
end;



procedure MS4(adr: Cardinal); stdcall;
var
re,im: double;
begin
// msv4(z1: CXext, n:int; ve: int; x: dbl)
 re:=PExtended(adr)^+PArrayE(adr+48)^[PInteger(adr+32)^]+PDouble(adr+64)^;
 im:= PExtended(adr+16)^;
 asm
   fld im
   fld re
 end;
end;

//real
function MS0(Adr: Cardinal): double; cdecl;
begin
 MS0:=1;//sqr(PDouble(Adr)^);
end;



//real
function MS1(Adr: Cardinal): TFloatType; cdecl;
begin
 MS1:=sqr(PFloatType(Adr)^);
end;

function MS2(Adr: Cardinal):TFloatType; stdcall;
begin
 MS2:=PFloatType(Adr)^-PFloatType(Adr+16)^;
end;

function MS3(Adr: Cardinal): TFloatType; cdecl;
begin
 MS3:=PFloatType(Adr)^+PFloatType(Adr+16)^-PFloatType(Adr+32)^;
end;


//complex
procedure MS1Z(Adr: Cardinal);stdcall;
var
re,im: TFloatType;
begin
 re:=sqr(PFloatType(Adr)^)-sqr(PFloatType(Adr+16)^);
 im:=2*PFloatType(Adr)^*PFloatType(Adr+16)^;
 asm
   fld im
   fld re
 end;
end;


//complex
procedure MS2Z(Adr: Cardinal);stdcall;
var
re,im: double;
begin
 re:=PFloatType(Adr)^-PFloatType(Adr+32)^;
 im:=PFloatType(Adr+16)^-PFloatType(Adr+48)^;
 asm
   fld im
   fld re
 end;
end;

//real,complex
procedure MS2RZ(Adr: Cardinal);cdecl;
var
re,im: double;
begin
 re:=PFloatType(Adr)^-PFloatType(Adr+16)^;
 im:=-PFloatType(Adr+32)^;
 asm
   fld im
   fld re
 end;
end;


//complex,real
procedure MS2ZR(Adr: Cardinal);pascal;
var
re,im: double;
begin
 re:=PFloatType(Adr)^-PFloatType(Adr+32)^;
 im:=PFloatType(Adr+16)^;
 asm
   fld im
   fld re
 end;
end;


procedure MS3Z(Adr: Cardinal);stdcall;
var
re,im: TFloatType;                      //0,16; 32,48; 64,80
begin
 re:=PFloatType(Adr)^+PFloatType(Adr+32)^-PFloatType(Adr+64)^;
 im:=PFloatType(Adr+16)^+PFloatType(Adr+48)^-PFloatType(Adr+80)^;
 asm
   fld im
   fld re
 end;
end;




function SP10(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10: double): double;  pascal;
begin
 SP10:=x1+x2-x3+x4-x5+x6-x7+x8-x9+x10;
end;

function PS10(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10: Pdouble): double;  pascal;
begin
 PS10:=x1^+x2^-x3^+x4^-x5^+x6^-x7^+x8^-x9^+x10^;
end;

function ms10(adr: cardinal): double;  stdcall;
begin
 //SP10:=x1+x2-x3+x4-x5+x6-x7+x8-x9+x10;
 ms10:=PDouble(Adr)^+PDouble(Adr+16)^-PDouble(Adr+32)^+PDouble(Adr+48)^-PDouble(Adr+64)^+PDouble(Adr+80)^-PDouble(Adr+96)^+PDouble(Adr+112)^-PDouble(Adr+128)^+PDouble(Adr+144)^;

end;





function MS1X(adr: Cardinal): Extended; stdcall;
begin
 MS1X:=PExtended(adr)^*PExtended(adr)^;
end;


function MS2X(adr: Cardinal): Extended; pascal;
begin
 MS2X:=PExtended(adr)^-PExtended(adr+16)^;
end;


function MS3X(adr: Cardinal): Extended; cdecl;
begin
 MS3X:=PExtended(adr)^+PExtended(adr+16)^-PExtended(adr+32)^;
end;


//complex
procedure MS1ZX(Adr: Cardinal);stdcall;
var
re,im: extended;
begin
 re:=sqr(PExtended(Adr)^)-sqr(PExtended(Adr+16)^);
 im:=2*PExtended(Adr)^*PExtended(Adr+16)^;
 asm
   fld im
   fld re
 end;
end;


//complex
procedure MS2ZX(Adr: Cardinal);stdcall;
var
re,im: extended;
begin
 re:=PExtended(Adr)^-PExtended(Adr+32)^;
 im:=PExtended(Adr+16)^-PExtended(Adr+48)^;
 asm
   fld im
   fld re
 end;
end;

//real,complex
procedure MS2RZX(Adr: Cardinal);cdecl;
var
re,im: extended;
begin
 re:=PExtended(Adr)^-PExtended(Adr+16)^;
 im:=-PExtended(Adr+32)^;
 asm
   fld im
   fld re
 end;
end;


//complex,real
procedure MS2ZRX(Adr: Cardinal);pascal;
var
re,im: extended;
begin
 re:=PExtended(Adr)^-PExtended(Adr+32)^;
 im:=PExtended(Adr+16)^;
 asm
   fld im
   fld re
 end;
end;



procedure MS3ZX(Adr: Cardinal);cdecl;
var
re,im: Extended;                      //0,16; 32,48; 64,80
begin
 re:=PExtended(Adr)^+PExtended(Adr+32)^-PExtended(Adr+64)^;
 im:=PExtended(Adr+16)^+PExtended(Adr+48)^-PExtended(Adr+80)^;
 asm
   fld im
   fld re
 end;
end;




procedure a_rrz; //pascal;//stdcall;
var
N,i:Integer;
Sz: TComplexD;
z1,z2: TComplexD;
r1,r2,Sx,Sy: Double;
pz: PComplexD;
adr: Cardinal;
begin
asm
  mov Adr,eax
end;
 r1:=PDouble(Adr)^;
 r2:=PDouble(Adr+16)^;
 z1.re:=PDouble(Adr+32)^ ;
 z1.im:=PDouble(Adr+48)^;

 Sz.re:=r1+r2+z1.re;
 Sz.im:=z1.im;

 asm
  fld Sz.im
  fld Sz.re
 end
end;



procedure a_zzr; //stdcall;
var
N,i:Integer;
Sz: TComplexD;
z1,z2: TComplexD;
r1,r2,Sx,Sy: Double;
adr: Cardinal;
begin
asm
  mov Adr,eax
end;
 z1.re:=PDouble(Adr)^;
 z1.im:=PDouble(Adr+16)^;
 z2.re:=PDouble(Adr+32)^ ;
 z2.im:=PDouble(Adr+48)^;
 r1:=PDouble(Adr+64)^;

 Sz.re:=z1.re+z2.re+r1;
 Sz.im:=z1.im+z2.im;

 asm
  fld Sz.im
  fld Sz.re
 end
end;


procedure a_zrz; //stdcall;
var
N,i:Integer;
Sz: TComplexD;
z1,z2: TComplexD;
r1,r2,Sx,Sy: Double;
adr: Cardinal;
begin
asm
  mov Adr,eax
end;
 z1.re:=PDouble(Adr)^;
 z1.im:=PDouble(Adr+16)^;
 r1:=PDouble(Adr+32)^;
 z2.re:=PDouble(Adr+48)^ ;
 z2.im:=PDouble(Adr+64)^;

 Sz.re:=z1.re+z2.re+r1;
 Sz.im:=z1.im+z2.im;

 asm
  fld Sz.im
  fld Sz.re
 end
end;



//infsum(z1,z2,z3,z3-z2,z2-infsum(z3*z1,z1/z2*infsum(z2*(z1-z3),z1*(z3-z1),z3*(z2-z1))),z1*z2)/(z1+z2+z3+z3-z2+z2-(z3*z1+z1/z2*(z2*(z1-z3)+z1*(z3-z1)+z3*(z2-z1)))+z1*z2)
procedure sumz(adr,len: Cardinal); {cdecl;}{pascal;}stdcall;
var
N,i:Integer;
Sz: TComplexFloat;
begin
Sz.re:=0;
Sz.im:=0;
for I := 0 to len - 1 do
begin
  Sz.re:=Sz.re+{PExtended}{PDouble}PFloatType(Adr+32*i)^;
  Sz.im:=Sz.im+{PExtended}{PDouble}PFloatType(Adr+32*i+16)^;
end;

 asm
  fld Sz.im
  fld Sz.re
 end
end;



//infsum(x,y,t,t-y,y-infsum(t*x,x/y*infsum(y*(x-t),x*(t-x),t*(y-x))),x*y)/(x+y+t+t-y+y-(t*x+x/y*(y*(x-t)+x*(t-x)+t*(y-x)))+x*y)
procedure sumr(adr,len: Cardinal); {cdecl;}{pascal;}stdcall;
var
N,i:Integer;
Sz: TFloatType;
// z1,z2: TComplexFloat;
//r1,r2,Sx,Sy: Double;
begin
Sz:=0;
for I := 0 to len - 1 do
begin
  Sz:=Sz+{PExtended}{PDouble}PFloatType(Adr+16*i)^;     //real: Adr+16*i
end;

 asm
  //fld Sz.y
  fld Sz
 end
end;


//sum(z1,z2.re,x)+sum(x,z1,z2,y*x)+sum(z2,y)+sum(x,z2,y,z1,x,y,z1,x,z2)
procedure sumd(adr,len,adrt: Cardinal); {cdecl;}{pascal;}stdcall;
var
N,i:Integer;
Sz: TComplexD;
z1,z2: TComplexD;
r1,r2,Sx,Sy,ccx,ccr: Double;
begin
Sz.re:=0;
Sz.im:=0;
//ccx:=0;ccr:=0;

for I := 0 to len - 1 do
begin
  if PInteger(Adrt+4*i)^ = _Real then
  begin
    Sz.re:=Sz.re+{PExtended}PDouble(Adr)^;
    Adr:=Adr+16;    //ccr:=ccr+1;
  end
  else
  if PInteger(Adrt+4*i)^ = _Complex then
  begin
   Sz.re:=Sz.re+{PExtended}PDouble(Adr)^; Adr:=Adr+16;
   Sz.im:=Sz.im+{PExtended}PDouble(Adr)^; Adr:=Adr+16;
   //ccx:=ccx+1;
  end;
end;
       //len:=len;
 asm
  //fldz
  //fild len
  //fld  ccx
  //fld  ccr
  fld Sz.im
  fld Sz.re
 end
end;



//polyU(An,An-1,An-2,....,A0,Expr)
function PolyUR(adr,len: Cardinal): TFloatType; stdcall;
  {Evaluate polynomial; return An*Expr^n + An-1*Expr^(n-1) + An-2*Expr^(n-2)... + A0}

var
  i: integer;
  p,x,r: TFloatType;
begin
  //polyu(a+b,a-b,c*b/a,a*(c-a),c-d,t*d/(a-b),2*b-3/d,t*2*a/(3*d-b*4),-d/a,x/(x+y))
  //polyu(a+b,a-b,c*b/a,a*(c-a),c-d,t*d/(a-b),2*b-3/d,2*a/(3*d-b*4),-d/a,x/(x+y))

  //polyu(a+b,a-b,c*b/a,a*(c-a),c-d,t*d/(a-b),2*b-3/d,t*2*a/(3*d-b*4),-d/a,x/(x+y))
 //(a+b)*(x/(x+y))^8+(a-b)*(x/(x+y))^7+c*b/a*(x/(x+y))^6+a*(c-a)*(x/(x+y))^5+(c-d)*(x/(x+y))^4+t*d/(a-b)*(x/(x+y))^3+(2*b-3/d)*(x/(x+y))^2+(t*2*a/(3*d-b*4))*(x/(x+y))-d/a


x:=PFloatType(Adr+16*(len-1))^;   //Expr
p:=PFloatType(Adr+16*(0))^;  //An

for i:=1 to len-2 do
begin
  //r:= PFloatType(Adr+16*i)^;
  p := p*x + PFloatType(Adr+16*i)^;
end;

PolyUR:=p;

end;





procedure test(z1: TComplexD; x: extended; y: double; z2: TComplexE); {cdecl;}stdcall;
var
S: TComplexE;
begin
 S.re:=x+y+z1.re+z2.re;
 S.im:=z1.im+z2.im;


 asm
  fld S.im
  fld S.re
 end;
end;




procedure vt4(z1: TComplexD; n: integer; vd: TArrayD; x: double); {cdecl;}stdcall;
var
S: double;
begin
 S:=z1.re+z1.im+x+vd[n];

 asm
  fld S
 end;
end;



procedure pt4(z1: PComplexD; n: Pinteger; vd: PArrayD; x: Pdouble); {cdecl;}stdcall;
var
S: double;
begin
 S:=z1^.re+z1^.im+x^+vd^[n^];

 asm
  fld S
 end;
end;




procedure vt2(x: double; n: integer); {cdecl;}stdcall;
var
S: double;
begin
 S:=x+n;

 asm
  fld S
 end;
end;


procedure v_rrz(r1,r2: double{PExtended};z1:TComplexD); cdecl;{stdcall;}
var
N,i:Integer;
Sz: TComplexD;
begin

 Sz.re:=r1+r2+z1.re;
 Sz.im:=z1.im;


 asm
  fld Sz.im
  fld Sz.re
 end
end;


procedure v_zzr(z1,z2: TComplexD;r1:Double{PExtended}); {cdecl;}stdcall;
var
N,i:Integer;
Sz: TComplexD;
begin

 Sz.re:=z1.re+z2.re+r1;
 Sz.im:=z1.im+z2.im;

 asm
  fld Sz.im
  fld Sz.re
 end
end;




function Fint1(n: Integer): TFloatType;  stdcall;
begin
 FInt1:=n+1;
end;



function Fint2(n1,n2: Integer): TFloatType;  stdcall;
begin
 FInt2:=n1+n2;
end;



function Fint3(n1,n2,n3: Integer): TFloatType;  stdcall;
begin
 FInt3:=n1+n2+n3;
end;




function Fflt1(x: TFloatType): TFloatType;  stdcall;
begin
 Fflt1:=x+1;
end;


function farr1(vdf: TArrayD): double;
begin
  //SetLength(vdf,1000);
  farr1:=vdf[10];
end;


function spadr0: TFloatType;  stdcall;
begin
 spadr0:=x*x*x;
end;


function spCallExt(px: Pointer; AddrFunc: Pointer; val:TFloatType): TFloatType;  stdcall;
begin
  PFloatType(px)^:=val;
  spCallExt:=callF(AddrFunc);
end;


//spproc2r(x,y,@res)
procedure spproc2r(x,y: TFloatType; var res: TFloatType);  stdcall;
begin
 res:=x+y;
end;




//spproc2c(z1,z2,@res)
procedure spproc2c(z1,z2: TComplexFloat; var res: TComplexFloat);  stdcall;
begin
 res.re:=z1.re+z2.re;
 res.im:=z1.im+z2.im;
end;



//spprocswpinc2r(@x,@y)=x+y; (x=y+1; y=x+1)
function spprocswpinc2r(px,py:  PFloatType): TFloatType;  stdcall;
var
t: TFloatType;
begin
 spprocswpinc2r:=px^+py^;
 t:=px^;
 px^:=py^+1;
 py^:=t+1;
end;




//spprocswpinc2c(@z1,@z2)=z1+z2; (z1=2*z2+2+2i; z2=3*z1+3+3i)
procedure spprocswpinc2c(pz1,pz2:  PComplexFloat);  stdcall;
var
Sz,tz: TComplexFloat;
begin

 Sz.re:=pz1^.re+pz2^.re;
 Sz.im:=pz1^.im+pz2^.im;

 tz:=pz1^;

 pz1^.re:=2*pz2^.re+2;
 pz1^.im:=2*pz2^.im+2;

 pz2^.re:=3*tz.re+3;
 pz2^.im:=3*tz.im+3;




 asm
  fld Sz.im
  fld Sz.re
 end

end;




//spprocsqr2(@x,@z1); (x=x^2; z1=z1^2)
procedure spprocsqr2(var x: TFloatType; var z:  TComplexFloat);  stdcall;
var
t: TFloatType;
begin

 x:=sqr(x);

 t:=z.re;
 z.re:=sqr(z.re)-sqr(z.im);
 z.im:=2*t*z.im;

end;





//spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1, vu2, @s, @m, @z5, @vu3);
procedure spprocsumall(x,y: TFloatType; n1,n2: Integer;  z1,z2: TComplexFloat; vu1,vu2: TFloatArray;   var resR: TFloatType; var resI: Integer; var resC:  TComplexFloat; var ResV: TFloatArray);  stdcall;
{(resR=x+y; resC=z1+z2; resI=n1+n2; resV=vu1+vu2) }
var
t: TFloatType;
L,k: Integer;
begin

 resR:=x+y;
 resI:=n1+n2;
 resC.re:=z1.re+z2.re;
 resC.im:=z1.im+z2.im;

 L:=Length(vu1); //= Length vu2, resV
 for k := 0 to L-1 do
 begin
   resV[k]:=vu1[k]+vu2[k]
 end;


end;






//spproctest(@FRInt1XYT, @x,@y,@t,a,b, @FRLim1X, @pcLim1X,  @FRLim3XY, @pcLim3XY)

//spproctest(@FRInt1XYT, @x,@y,@t,a,b)
function spproctest(pfunc: Pointer; pv1,pv2,pv3:  PFloatType; a,b: TFloatType; pfunc1, pfunc2, pfunc3, pfunc4: Pointer ): TFloatType;  stdcall;
var
t1,t2,t3,t4,t5: TFloatType;
begin
 //spproctest:=pv1^+pv2^+pv3^+a+b+callf(pfunc)+callf(pfunc1)+callf(pfunc2)+callf(pfunc3)+callf(pfunc4);
 pv1^:=10.123+pv1^;
 pv2^:=20.456+pv2^;
 pv3^:=30.789+pv3^;
 t1:=callf(pfunc);
 t2:=callf(pfunc1);
 t3:=callf(pfunc2);
 t4:=callf(pfunc3);
 t5:=callf(pfunc4);
 spproctest:=pv1^+pv2^+pv3^+a+b+t1+t2+t3+t4+t5;

end;



function spcallfunc3(pfunc1,pfunc2,pfunc3: Pointer): TFloatType;  stdcall;
var
t1,t2,t3: TFloatType;
begin

 t1:=callf(pfunc1);
 t2:=callf(pfunc2);
 t3:=callf(pfunc3);

 spcallfunc3:=t1+t2+t3;

end;



//spadr1(@x)
function spadr1fp(px: PFloatType): TFloatType;  stdcall;
begin
 spadr1fp:=px^*px^*px^;
end;


function spadr1(Func: Pointer; AddrV: PFloatType;{AddrV: Integer; } Val: TFloatType): TFloatType;  stdcall;
var
res: TFloatType;
begin
// PFloatType(AddrV)^:=Val;
 AddrV^:=Val;
 //x:=Val;
 asm
  //fld   Val
  //fstp  tbyte ptr [AddrV]
  call  Func
  fstp  res
 end;
 spadr1:=res;
end;

//gx=2; spadr2(@spadr0,@gx); spadr2(@spadr0,@gx); gx;
procedure spadr2(Func: Pointer; AddrV: PFloatType{AddrV: Integer; });  stdcall;
var
res: TFloatType;
begin
// PFloatType(AddrV)^:=Val;
 //AddrV^:=Val;
 //x:=Val;
 asm
  //fld   Val
  //fstp  tbyte ptr [AddrV]
  call  Func
  fstp  res
 end;
 AddrV^:=Res;

end;


//x=123.4567; vu1[k]=321.321; spadr3(x,@vu1,@k); vu1[k]
//x=123.4567; vu1[k]=321.321; avu1:int=vu1; spadr3(x,avu1,@k); vu1[k]
procedure spadr3(x: TFloatType; Vec: {Integer}TFloatArray; Pindx: PInteger);  stdcall;
//Vec[indx]=x
var
res: TFloatType;
begin

  //PFloatType(PInteger(PVec0)^+Pindx^*FloatCellSize)^:=x;
  //PArray(PVec0)^[Pindx^]:=x;


  //TArray(Vec)[PIndx^]:=x;
  Vec[PIndx^]:=x;


  //res:=TArray(PVec0)[PIndx^];
{ res:=PVec0[PIndx^];
 PVec0[PIndx^]:=x; }



 //PFloatType(PVec0+Pindx^*FloatCellSize)^:=x;



end;


//x=123.4567; vu1[k]=321.321; spadr3(x,@vu1,@k); vu1[k]
//x=123.4567; vu1[k]=321.321; avu1:int=@vu1; spadr3(x,avu1,@k); vu1[k]
procedure spadr3pa(x: TFloatType; PVec: PFloatArray {Integer}; Pindx: PInteger);  stdcall;
//Vec[indx]=x
var
res: TFloatType;
begin
  //PFloatArray(PVec)^[PIndx^]:=x;    //if    PVec:  Integer
  PVec^[PIndx^]:=x;                   //if     PVec:  PFloatArray

end;



//spadrv(@vu1,k)
//n=@vu1; spadrv(n,k)
function spadrv(Vec: Integer{TArray}; indx: Integer):TFloatType;  stdcall;
//Vec[indx]
var
res: TFloatType;
begin

  //PFloatType(PInteger(PVec0)^+Pindx^*FloatCellSize)^:=x;
  //PArray(PVec0)^[Pindx^]:=x;


  //TArray(PVec0)[PIndx^]:=x;
  //PVec0[PIndx^]:=x;


  //res:=TArray(PVec0)[PIndx^];
{ res:=PVec0[PIndx^];
 PVec0[PIndx^]:=x; }



 //PFloatType(PVec0+Pindx^*FloatCellSize)^:=x;

   spadrv:=TFloatArray(Vec)[Indx];
   //spadrv:=Vec[Indx];
end;




//k=@n; spadrInt1(k,123); n
procedure spadrInt1(AddrInt: Integer; Val: Integer);  stdcall;
var
k: Integer;
begin
// PFloatType(AddrV)^:=Val;
//k:=PInteger(AddrInt)^;
 PInteger(AddrInt)^:=Val;
end;



//k=@x; spadrFlt1(k,123.456); x
procedure spadrFlt1(AddrFlt: Integer; Val: TFloatType);  stdcall;
var
k: Integer;
begin
// PFloatType(AddrV)^:=Val;
//k:=PInteger(AddrInt)^;
 PFloatType(AddrFlt)^:=Val;
end;


//x=123.4567;  FillArray(vu1,x); sum(vu1);
procedure spFillArray(PVec0: Integer{PFloatType}; x:TFloatType{PV: PFloatType} );  stdcall;
var
res: TFloatType;
i,L: integer;
begin
 L:=PInteger(PVec0-4)^;
 for i := 0 to L-1 do
 begin
   PFloatType(PVec0+i*FloatCellSize)^:=x{PV^};
 end;

end;



function fptr3vd(pv1,pv2,pv3: Pointer): TFloatType;  stdcall;
var
t1,t2,t3: TFloatType;
begin
 fptr3vd:=PDouble(pv1)^+PDouble(pv2)^+PDouble(pv3)^;
end;





//x=10;y=20;  incv(@x,y+100); x
//z1=1+2i; y=20;  incv(@z1,y+10); z1
procedure incf(PVar: PFloatType; x:TFloatType);  stdcall;
begin
 PFloatType(PVar)^:= PFloatType(PVar)^+x;
end;



//z1=1+2i; z2=5+6i;  incv(@z1,z2+10+20i); z1
//z1=1+2i;  incv(@z1,20i); z1
procedure incz(PVar: Integer{PFloatType}; zx: TComplexFloat);  stdcall;
begin
 PFloatType(PVar)^:= PFloatType(PVar)^+zx.re;
 PFloatType(PVar+16)^:= PFloatType(PVar+16)^+zx.im;
end;



function SP3(x1,x2,x3: TFloatType): TFloatType;  stdcall;  overload;
begin
 SP3:=x1+x2-x3;
end;


function SP2(x1,x2: TFloatType):TFloatType;  cdecl;   overload;
begin
 SP2:=x1-x2;
end;


function SP1(x1: TFloatType): TFloatType;  cdecl;    overload;
{var
px: PDouble;  }
begin
{ px:=nil;
 SP1:=x1*x1+px^;  }
 SP1:=x1*x1;
end;


procedure SP1Z(z1: TComplexFloat);  cdecl;
var
re,im: TFloatType;
begin
 re:=sqr(z1.re)-sqr(z1.im);
 im:=2*z1.re*z1.im;
 asm
   fld im
   fld re
 end;
 //flLoadFPUD(re,im);
end;


procedure SP2Z(z1,z2: TComplexFloat);  cdecl;
var
rez: TComplexFloat;
begin
 rez.re:=z1.re-z2.re;
 rez.im:=z1.im-z2.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;


procedure SP3Z(z1,z2,z3: TComplexFloat);  stdcall;
var
re,im:  TFloatType;
begin
 re:=z1.re+z2.re-z3.re;
 im:=z1.im+z2.im-z3.im;
 asm
   fld im
   fld re
 end;
end;


procedure SP2ZR(z1:  TComplexFloat; x: TFloatType);  cdecl;
var
rez:  TComplexFloat;//TComplexE;
begin
 rez.re:=z1.re-x;
 rez.im:=z1.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;


procedure SP2RZ(x: TFloatType; z1:  TComplexFloat);  stdcall;
var
rez:  TComplexFloat;//TComplexE;
begin
 rez.re:=x-z1.re;
 rez.im:=-z1.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;




procedure SP3ZRZ(z1:  TComplexFloat; x2: TFloatType; z3: TComplexFloat);  cdecl;
var
rez:  TComplexFloat;//TComplexE;
begin
 rez.re:=z1.re+x2-z3.re;
 rez.im:=z1.im-z3.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;




procedure SP3RZR(x1:  TFloatType;  z2: TComplexFloat; x3: TFloatType);  cdecl;
var
rez:  TComplexFloat;//TComplexE;
begin
 rez.re:=x1+z2.re-x3;
 rez.im:=z2.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;




procedure SP3ZZR(z1:  TComplexFloat; z2: TComplexFloat; x3: TFloatType);  cdecl;
var
rez:  TComplexFloat;//TComplexE;
begin
 rez.re:=z1.re+z2.re-x3;
 rez.im:=z1.im+z2.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;




procedure SP4ZR(z1: TComplexFloat; x1: TFloatType;  z2: TComplexFloat; x2: TFloatType);  cdecl;
var
re,im: TFloatType;
begin
 re:=z1.re+x1-z2.re*x2;
 im:=z1.im-z2.im*x2;
 asm
   fld im
   fld re
 end;
end;



procedure SP4RZ(x1: TFloatType; z1: TComplexFloat;   x2: TFloatType;  z2: TComplexFloat);  stdcall;
var
re,im: TFloatType;
begin
 re:=z1.re+x1-z2.re*x2;
 im:=z1.im-z2.im*x2;
 asm
   fld im
   fld re
 end;
end;





  //extended
function SP3X(x1,x2,x3: extended): extended;  stdcall;
begin
 SP3X:=x1+x2-x3;
end;


function SP2X(x1,x2: extended): extended;  cdecl;
begin
 SP2X:=x1-x2;
end;


function SP1X(x1: extended): extended;  cdecl;
begin
 SP1X:=x1*x1;
end;


procedure SP1ZX(z1: TComplexE);  cdecl;
var
re,im: Extended;
begin
re:=sqr(z1.re)-sqr(z1.im);
 im:=2*z1.re*z1.im;
 asm
   fld im
   fld re
 end;
 //flLoadFPUD(re,im);
end;


procedure SP2ZX(z1,z2: TComplexE);  cdecl;
var
rez: TComplexE;
begin
 rez.re:=z1.re-z2.re;
 rez.im:=z1.im-z2.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;


{**************************   OVERLOADCOMPLEX    ******************************}
function SP3(z1,z2,z3: TComplexNum): TComplexNum; overload;
begin
 SP3:=z1+z2-z3;
end;


function SP2(z1,z2: TComplexNum): TComplexNum;  overload;
begin
 SP2:=z1-z2;
end;


function SP1(z1: TComplexNum): TComplexNum;  overload;
begin
 SP1:=z1*z1;
end;
{}

function sp6(vd: TArrayD; d: TComplexNum; ve: TArrayE; n: Integer; x: TComplexNum; j: integer): TComplexNum; overload;
//sp6(vd: arrayDbl; y: Double; ve: arrayExt; n: int; x: Ext; j:int)  = vd[n]-ve[j]+x-y;
//sp6(vd,x,ve,n,y,j)
begin
  SP6:=vd[n]-ve[j]+d-x;
end;

{******************************************************************************}



procedure ADDZRZ(z1: TComplexE; x2: double; z3: TComplexD);  stdcall;
var
re,im: extended;
begin
 re:=z1.re+x2+z3.re;
 im:=z1.im+z3.im;
 asm
   fld im
   fld re
 end;
end;



procedure SP3ZX(z1,z2,z3: TComplexE);  stdcall;
var
re,im: extended;
begin
 re:=z1.re+z2.re-z3.re;
 im:=z1.im+z2.im-z3.im;
 asm
   fld im
   fld re
 end;
end;


procedure SP2ZRX(z1: TComplexE; x: extended);  cdecl;
var
rez: TComplexE;
begin
 rez.re:=z1.re-x;
 rez.im:=z1.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;


procedure SP2RZX(x: extended; z1: TComplexE);  stdcall;
var
rez: TComplexE;
begin
 rez.re:=x-z1.re;
 rez.im:=-z1.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;






function PS1(x1: PFloatType{PDouble}):  TFloatType;  stdcall;
begin
 PS1:=x1^*x1^;
end;


function PS2(x1,x2: PFloatType): TFloatType;  stdcall;
begin
 PS2:=x1^-x2^;
end;



function PS3(x1,x2,x3: PFloatType): TFloatType;  stdcall;
begin
 PS3:=x1^+x2^-x3^;
end;




procedure PS1Z(z1: PComplexFloat{PComplexD});  cdecl;
var
re,im:  TFloatType;
begin
 re:=sqr(z1^.re)-sqr(z1^.im);
 im:=2*z1^.re*z1^.im;
 asm
   fld im
   fld re
 end;
end;


procedure PS2Z(z1,z2: PComplexFloat);  stdcall;
var
re,im:  TFloatType;
begin
 re:=z1^.re-z2^.re;
 im:=z1^.im-z2^.im;
 asm
   fld im
   fld re
 end;
end;


procedure PS2ZR(z1: PComplexFloat; x:PFloatType);  stdcall;
var
re,im: TFloatType;
begin
 re:=z1^.re-x^;
 im:=z1^.im;
 asm
   fld im
   fld re
 end;
end;


procedure PS2RZ(x:PFloatType; z1: PComplexFloat);  stdcall;
var
re,im: TFloatType;
begin
 re:=x^-z1^.re;
 im:=-z1^.im;
 asm
   fld im
   fld re
 end;
end;






procedure PS3ZRZ(z1: PComplexFloat; x2: PFloatType;  z3: PComplexFloat);  cdecl;
var
re,im: TFloatType;
begin
 re:=z1^.re+x2^-z3^.re;
 im:=z1^.im-z3^.im;

 asm
   fld im
   fld re
 end;
end;




procedure PS3RZR(x1: PFloatType; z2: PComplexFloat; x3: PFloatType);  cdecl;
var
re,im: TFloatType;
begin
 re:=x1^+z2^.re-x3^;
 im:=z2^.im;

 asm
   fld im
   fld re
 end;
end;




procedure PS3ZZR(z1: PComplexFloat;  z2: PComplexFloat;  x2: PFloatType);  cdecl;
var
re,im: TFloatType;
begin
 re:=z1^.re+z2^.re-x2^;
 im:=z1^.im+z2^.im;

 asm
   fld im
   fld re
 end;
end;



procedure PS4ZR(z1: PComplexFloat; x1: PFloatType;  z2: PComplexFloat; x2: PFloatType);  cdecl;
var
re,im: TFloatType;
begin
 re:=z1^.re+x1^-z2^.re*x2^;
 im:=z1^.im-z2^.im*x2^;
 asm
   fld im
   fld re
 end;
end;



procedure PS4RZ(x1: PFloatType; z1: PComplexFloat;   x2: PFloatType;  z2: PComplexFloat);  stdcall;
var
re,im: TFloatType;
begin
 re:=z1^.re+x1^-z2^.re*x2^;
 im:=z1^.im-z2^.im*x2^;
 asm
   fld im
   fld re
 end;
end;




procedure PS3Z(z1,z2,z3: PComplexFloat);  stdcall;
var
re,im: TFloatType;
begin
 re:=z1^.re+z2^.re-z3^.re;
 im:=z1^.im+z2^.im-z3^.im;
 asm
   fld im
   fld re
 end;
end;


procedure PS3ZX(z1,z2,z3: PComplexE);  pascal;
var
re,im: Extended;
begin
 re:=z1^.re+z2^.re-z3^.re;
 im:=z1^.im+z2^.im-z3^.im;
 asm
   fld im
   fld re
 end;
end;



function PS2A(x1,x2: TFloatType): TFloatType;  stdcall;
begin
 PS2A:=x1/x2;
end;





function PS3X(x1,x2,x3: PExtended): Extended;  cdecl;
begin
 PS3X:=x1^+x2^-x3^;
end;


function PS2X(x1,x2: PExtended): Extended;  cdecl;
begin
 PS2X:=x1^-x2^;
end;


function PS1X(x1: PExtended): Extended;  stdcall;
begin
 PS1X:=x1^*x1^;
end;


procedure PS1ZX(z1: PComplexE);  cdecl;
var
re,im: Extended;
begin
 re:=sqr(z1^.re)-sqr(z1^.im);
 im:=2*z1^.re*z1^.im;
 asm
   fld im
   fld re
 end;
end;


procedure PS2ZX(z1,z2: PComplexE);  stdcall;
var
re,im: Extended;
begin
 re:=z1^.re-z2^.re;
 im:=z1^.im-z2^.im;
 asm
   fld im
   fld re
 end;
end;


procedure PS2ZRX(z1: PComplexE; x:PExtended);  cdecl;
var
re,im: Extended;
begin
 re:=z1^.re-x^;
 im:=z1^.im;
 asm
   fld im
   fld re
 end;
end;


procedure PS2RZX(x:PExtended; z1: PComplexE);  stdcall;
var
re,im: Extended;
begin
 re:=x^-z1^.re;
 im:=-z1^.im;
 asm
   fld im
   fld re
 end;
end;






function SP4(x1: extended; x2: double; x3: extended; x4: double): extended;  cdecl;
begin
 SP4:=x1+x2-x3*x4;
end;



function PS4(x1: Pextended; x2: Pdouble; x3: Pextended; x4: Pdouble): extended;  cdecl;
begin
 PS4:=x1^+x2^-x3^*x4^;
end;



procedure SP4Z(z1: TComplexE; z2: TComplexD; z3: TComplexE; z4: TComplexD);  stdcall;
var
re,im: extended;
begin
 re:=z1.re+z2.re-(z3.re*z4.re-z3.im*z4.im);
 im:=z1.im+z2.im-(z3.re*z4.im+z4.re*z3.im);
 asm
   fld im
   fld re
 end;
end;



procedure PS4Z(z1: PComplexE; z2: PComplexD; z3: PComplexE; z4: PComplexD);  cdecl;
var
re,im: extended;
begin
 re:=z1^.re+z2^.re-(z3^.re*z4^.re-z3^.im*z4^.im);
 im:=z1^.im+z2^.im-(z3^.re*z4^.im+z4^.re*z3^.im);
 asm
   fld im
   fld re
 end;
end;



function FVD3(vd: TArrayD; ve: TArrayE; n: Integer): extended;  stdcall;
begin
  FVD3:=VD[n]+VE[n];
end;


function PVD3(vd: PArrayD; ve: PArrayE; n: PInteger): extended;  stdcall;
begin
  PVD3:=VD^[n^]+VE^[n^];
end;

function MVD3(adr: Cardinal): extended;  stdcall;
begin
  MVD3:=PArrayD(Adr)^[PInteger(Adr+32)^]+PArrayE(Adr+16)^[PInteger(Adr+32)^]
end;


function FVD1(vd: TArrayD): extended;  stdcall;
var
 i,L: Integer;
begin
  //L:=Length(VD);
  FVD1:=VD[0]+VD[1];
end;


function PVE1(ve: PArrayE): extended;  stdcall;
var
 i,L: Integer;
begin
  //L:=Length(VD);
  PVE1:=VE^[0]+VE^[1];
end;




procedure SetLA(AdrV: Pointer; {TypeV: Cardinal; }Len: Cardinal{PInteger});  stdcall;
var
L1: integer;
begin
SetLength(PArrayD(AdrV)^,Len);

{
if TypeV = _ARRAYD then
begin
  SetLength(PArrayD(AdrV)^,Len);
end
else
if TypeV = _ARRAYE then
begin
  SetLength(PArrayE(AdrV)^,Len);
end
else
if TypeV = _ARRAYI then
begin
  SetLength(PArrayI(AdrV)^,Len);
end
else
if TypeV = _ARRAYS then
begin
  SetLength(PArrayS(AdrV)^,Len);
end;
}
end;



function FV5(vd: TArrayD; d: double; ve: TArrayE; i: Integer; x: extended): extended;  stdcall;
//fv5(vd,d,ve,i,x)
begin
  FV5:=vd[i]+ve[i]+d+x;
end;



function PV5(vd: PArrayD; d: PDouble; ve: PArrayE; i: PInteger; x: PExtended): extended;  stdcall;
//pv5(vd,d,ve,i,x)
begin
  PV5:=vd^[i^]+ve^[i^]+d^+x^;
end;


function _sp6(vd: TArrayD; d: double; ve: TArrayE; n: Integer; x: extended; j: integer): extended;  stdcall; overload; //cdecl;
//sp6(vd: arrayDbl; y: Double; ve: arrayExt; n: int; x: Ext; j:int)  = vd[n]-ve[j]+x-y;
//sp6(vd,x,ve,n,y,j)
begin
  _SP6:=vd[n]-ve[j]+d-x;
end;



function PS6(vd: PArrayD; d: PDouble; ve: PArrayE; n: PInteger; x: PExtended; j: PInteger): extended;  cdecl;//stdcall;
//ps6(vd,x,ve,n,y,j)=vd[n]-ve[j]+x-y;
begin
  PS6:=vd^[n^]-ve^[j^]+d^-x^;
end;

function MS6(Adr: Cardinal): extended;  stdcall;
//ms6(vd,x,ve,n,y,j)=vd[n]-ve[j]+x-y;
begin
  MS6:=PArrayD(Adr)^[PInteger(Adr+48)^]-PArrayE(Adr+32)^[PInteger(Adr+80)^]+PDouble(Adr+16)^-PExtended(Adr+64)^;
end;


procedure SP6Z(vd: TArrayD; zd: TComplexD; ve: TArrayE; n: Integer; zx: TComplexE; j: integer);  stdcall;//cdecl;
//sp6z(vd,z1,ve,n,z2,j)=vd[n]-ve[j]+z1-z2;
var
re,im: extended;
begin
  re:=vd[n]-ve[j]+zd.re-zx.re;
  im:=zd.im-zx.im;
  asm
   fld im
   fld re
 end;
end;



procedure PS6Z(vd: PArrayD; zd: PComplexD; ve: PArrayE; n: PInteger; zx: PComplexE; j: PInteger);  cdecl;//stdcall;
//ps6z(vd,z1,ve,n,z2,j)=vd[n]-ve[j]+z1-z2;
var
re,im: extended;
begin
  re:=vd^[n^]-ve^[j^]+zd^.re-zx^.re;
  im:=zd^.im-zx^.im;
  asm
   fld im
   fld re
 end;
end;


procedure MS6Z(Adr: Cardinal);  stdcall;
//ms6z(vd,z1,ve,n,z2,j)=vd[n]-ve[j]+z1-z2;
var
re,im: extended;
begin
  re:=PArrayD(Adr)^[PInteger(Adr+64)^]-PArrayE(Adr+48)^[PInteger(Adr+112)^]+PDouble(Adr+16)^-PExtended(Adr+80)^;
  im:=PDouble(Adr+32)^-PExtended(Adr+96)^;
  asm
   fld im
   fld re
 end;
end;


function MS3V(Adr: Cardinal): extended;  stdcall;
//ms3v(vd1,n1,vd2,n2,vd3,n3,x)=vd1[n1]+vd2[n2]+vd3[n3]+x;
begin
  MS3V:=PArrayD(Adr)^[PInteger(Adr+16)^]+PArrayD(Adr+32)^[PInteger(Adr+48)^]+PArrayD(Adr+64)^[PInteger(Adr+80)^]+PDouble(Adr+96)^;
end;


function SP3V(vd1: TArrayD; n1: Integer; vd2: TArrayD; n2: Integer ; vd3: TArrayD; n3: Integer; x: double):extended;  stdcall;//cdecl;
//sp3v(vd1,n1,vd2,n2,vd3,n3,x)=vd1[n1]+vd2[n2]+vd3[n3]+x;
begin
   SP3V:=vd1[n1]+vd2[n2]+vd3[n3]+x;
end;


function PS3V(vd1: PArrayD; n1: PInteger; vd2: PArrayD; n2: PInteger ; vd3: PArrayD; n3: PInteger; x: Pdouble):extended;  stdcall;//cdecl;
//sp3v(vd1,n1,vd2,n2,vd3,n3,x)=vd1[n1]+vd2[n2]+vd3[n3]+x;
begin
   PS3V:=vd1^[n1^]+vd2^[n2^]+vd3^[n3^]+x^;
end;


function MS8V(Adr: Cardinal): extended;  stdcall;
//ms8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
begin
  MS8V:=(PArrayD(Adr)^[PInteger(Adr+16)^]*PDouble(Adr+32)^-PArrayD(Adr+48)^[PInteger(Adr+64)^]*PExtended(Adr+80)^)*PArrayD(Adr+96)^[PInteger(Adr+112)^];
end;


function SP8V(vd1: TArrayD; n1: Integer; d: Double; vd2: TArrayD; n2: Integer ;  x: extended; vd3: TArrayD; n3: Integer):extended;  stdcall;//cdecl;
//sp8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
begin
   SP8V:=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
end;


function PS8V(vd1: PArrayD; n1: PInteger; d: PDouble; vd2: PArrayD; n2: PInteger ; x: PExtended; vd3: PArrayD; n3: PInteger):extended;  stdcall;//cdecl;
//ps8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
begin
   PS8V:=(vd1^[n1^]*d^-vd2^[n2^]*x^)*vd3^[n3^];
end;


procedure MS8VZ(Adr: Cardinal); stdcall;
//ms8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
var
re,im: extended;
begin
  re:=(PArrayD(Adr)^[PInteger(Adr+16)^]*PDouble(Adr+32)^-PArrayD(Adr+64)^[PInteger(Adr+80)^]*PExtended(Adr+96)^)*PArrayD(Adr+128)^[PInteger(Adr+144)^];
  im:=(PArrayD(Adr)^[PInteger(Adr+16)^]*PDouble(Adr+48)^-PArrayD(Adr+64)^[PInteger(Adr+80)^]*PExtended(Adr+112)^)*PArrayD(Adr+128)^[PInteger(Adr+144)^];
   asm
     fld im
     fld re
   end;
end;


procedure SP8VZ(vd1: TArrayD; n1: Integer; d: TComplexD; vd2: TArrayD; n2: Integer ;  x: TComplexE; vd3: TArrayD; n3: Integer); stdcall;//cdecl;
//sp8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
var
re,im: extended;
begin
   re:=(vd1[n1]*d.re-vd2[n2]*x.re)*vd3[n3];
   im:=(vd1[n1]*d.im-vd2[n2]*x.im)*vd3[n3];
   asm
     fld im
     fld re
   end;
end;


procedure PS8VZ(vd1: PArrayD; n1: PInteger; d: PComplexD; vd2: PArrayD; n2: PInteger ; x: PComplexE; vd3: PArrayD; n3: PInteger);  stdcall;//cdecl;
//ps8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
var
re,im: extended;
begin
   re:=(vd1^[n1^]*d^.re-vd2^[n2^]*x^.re)*vd3^[n3^];
   im:=(vd1^[n1^]*d^.im-vd2^[n2^]*x^.im)*vd3^[n3^];
   asm
     fld im
     fld re
   end;
end;






function SP8(ve: TArrayE; ne: Integer; x: extended;  vd: TArrayD; nd: Integer ; d: Double;  vdi: TArrayI; ni: Integer):extended;  stdcall;//cdecl;
//sp8(ve,ne,x,vd,nd,d,vi,ni) = (ve[ne]*x - vd[nd]*d)*vi[ni]
begin
   SP8:=(ve[ne]*x-vd[nd]*d)*vi[ni];
end;




function SP8PAI(ve: Integer{TArrayE}; ne: Integer; x: extended;  vd: Integer{TArrayD}; nd: Integer ; d: Double;  vdi: Integer{TArrayI}; ni: Integer):extended;  stdcall;//cdecl;
//sp8pai(@ve,ne,x,@vd,nd,d,@vi,ni) = (ve[ne]*x - vd[nd]*d)*vi[ni]
begin
   SP8PAI:=(TArrayE(ve)[ne]*x-TArrayD(vd)[nd]*d)*TArrayI(vi)[ni];
end;



function SP8PA(ve: PArrayE; ne: Integer; x: extended;  vd: PArrayD; nd: Integer ; d: Double;  vi: PArrayI; ni: Integer):extended;  stdcall;//cdecl;
//sp8pa(@ve,ne,x,@vd,nd,d,@vi,ni) = (ve[ne]*x - vd[nd]*d)*vi[ni]
begin
   SP8PA:=(ve^[ne]*x-vd^[nd]*d)*vi^[ni];
end;



function PS8(ve: PArrayE; ne: PInteger; x: PExtended; vd: PArrayD; nd: PInteger ; d: PDouble; vi: PArrayI; ni: PInteger):extended;  stdcall;//cdecl;
//ps8(ve,ne,x,vd,nd,d,vi,ni) = (ve[ne]*x - vd[nd]*d)*vi[ni]
begin
   PS8:=(ve^[ne^]*x^-vd^[nd^]*d^)*vi^[ni^];
end;



procedure SP8Z(ve: TArrayE; ne: Integer; zx: TComplexE; vd: TArrayD; nd: Integer ;  zd: TComplexD; vi: TArrayI; ni: Integer); stdcall;//cdecl;
//sp8(ve,ne,zx,vd,nd,zd,vi,ni) = (ve[ne]*zx - vd[nd]*zd)*vi[ni]
var
re,im: extended;
begin
   re:=(ve[ne]*zx.re-vd[nd]*zd.re)*vi[ni];
   im:=(ve[ne]*zx.im-vd[nd]*zd.im)*vi[ni];
   asm
     fld im
     fld re
   end;
end;


procedure PS8Z(ve: PArrayE; ne: PInteger; zx: PComplexE; vd: PArrayD; nd: PInteger ; zd: PComplexD; vi: PArrayI; ni: PInteger);  stdcall;//cdecl;
//ps8(ve,ne,zx,vd,nd,zd,vi,ni) = (ve[ne]*zx - vd[nd]*zd)*vi[ni]
var
re,im: extended;
begin
   re:=(ve^[ne^]*zx^.re-vd^[nd^]*zd^.re)*vi^[ni^];
   im:=(ve^[ne^]*zx^.im-vd^[nd^]*zd^.im)*vi^[ni^];
   asm
     fld im
     fld re
   end;
end;




function MS8i(Adr: Cardinal): extended;  stdcall;
//ms8i(vd1,n1,d,ve2,n2,x,vi3,n3)=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
begin
  MS8i:=(PArrayD(Adr)^[PInteger(Adr+16)^]*PDouble(Adr+32)^-PArrayE(Adr+48)^[PInteger(Adr+64)^]*PExtended(Adr+80)^)*PArrayI(Adr+96)^[PInteger(Adr+112)^];
end;


function SP8i(vd1: TArrayD; n1: Integer; d: Double; ve2: TArrayE; n2: Integer ;  x: extended; vi3: TArrayI; n3: Integer):extended;  stdcall;//cdecl;
//sp8i(vd1,n1,d,ve2,n2,x,vi3,n3)=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
begin
   SP8i:=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
end;


function PS8i(vd1: PArrayD; n1: PInteger; d: PDouble; ve2: PArrayE; n2: PInteger ; x: PExtended; vi3: PArrayI; n3: PInteger):extended;  stdcall;//cdecl;
//ps8i(vd1,n1,d,ve2,n2,x,vi3,n3)=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
begin
   PS8i:=(vd1^[n1^]*d^-ve2^[n2^]*x^)*vi3^[n3^];
end;





procedure MS8iZ(Adr: Cardinal); stdcall;
//ms8i(vd1,n1,d,ve2,n2,x,vi3,n3)=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
var
re,im: extended;
begin
  re:=(PArrayD(Adr)^[PInteger(Adr+16)^]*PDouble(Adr+32)^-PArrayE(Adr+64)^[PInteger(Adr+80)^]*PExtended(Adr+96)^)*PArrayI(Adr+128)^[PInteger(Adr+144)^];
  im:=(PArrayD(Adr)^[PInteger(Adr+16)^]*PDouble(Adr+48)^-PArrayE(Adr+64)^[PInteger(Adr+80)^]*PExtended(Adr+112)^)*PArrayI(Adr+128)^[PInteger(Adr+144)^];
   asm
     fld im
     fld re
   end;
end;


procedure SP8iZ(vd1: TArrayD; n1: Integer; d: TComplexD; ve2: TArrayE; n2: Integer ;  x: TComplexE; vi3: TArrayI; n3: Integer); stdcall;//cdecl;
//sp8v(vd1,n1,d,ve2,n2,x,vi3,n3)=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
var
re,im: extended;
begin
   re:=(vd1[n1]*d.re-ve2[n2]*x.re)*vi3[n3];
   im:=(vd1[n1]*d.im-ve2[n2]*x.im)*vi3[n3];
   asm
     fld im
     fld re
   end;
end;


procedure PS8iZ(vd1: PArrayD; n1: PInteger; d: PComplexD; ve2: PArrayE; n2: PInteger ; x: PComplexE; vi3: PArrayI; n3: PInteger);  stdcall;//cdecl;
//ps8i(vd1,n1,d,ve2,n2,x,vi3,n3)=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
var
re,im: extended;
begin
   re:=(vd1^[n1^]*d^.re-ve2^[n2^]*x^.re)*vi3^[n3^];
   im:=(vd1^[n1^]*d^.im-ve2^[n2^]*x^.im)*vi3^[n3^];
   asm
     fld im
     fld re
   end;
end;


//spall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
procedure spall(vx: TArrayE; nx: integer;  zx: TComplexE;  vd: TArrayD; nd: Integer; d: double; zd: TComplexD; x: Extended;  vi: TArrayI;  ni: Integer); cdecl;
var
rez: TComplexE;
begin
//rez=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]


 rez.re:=(vd[nd]*d*zd.re-vx[nx]*x*zx.re)*vi[ni];
 rez.im:=(vd[nd]*d*zd.im-vx[nx]*x*zx.im)*vi[ni];

 //flLoadFPUEP(&rez);
 asm
     fld rez.im
     fld rez.re
   end;

end;



//psall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
procedure psall(vx: PArrayE; nx: Pinteger;  zx: PComplexE;  vd: PArrayD; nd: PInteger; d: Pdouble; zd: PComplexD; x: PExtended;  vi: PArrayI;  ni: PInteger); cdecl;
var
rez: TComplexE;
begin
//rez=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]


 rez.re:=(vd^[nd^]*d^*zd^.re-vx^[nx^]*x^*zx^.re)*vi^[ni^];
 rez.im:=(vd^[nd^]*d^*zd^.im-vx^[nx^]*x^*zx^.im)*vi^[ni^];

 //flLoadFPUEP(&rez);
 asm
     fld rez.im
     fld rez.re
   end;

end;




//msall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
procedure msall(Adr: Cardinal); cdecl;
var
rez: TComplexE;
begin
  {
   vx =     PArrayE(Adr)^
   nx =     PInteger(Adr+16)^
   zx.re =  PExtended(Adr+32)^
   zx.im =  PExtended(Adr+48)^
   vd =     PArrayD(Adr+64)^
   nd =     PInteger(Adr+80)^
   d  =     PDouble(Adr+96)^
   zd.re =  PDouble(Adr+112)^
   zd.im =  PDouble(Adr+128)^
   x =      PExtended(Adr+144)^
   vi =     PArrayD(Adr+160)^
   ni =     PInteger(Adr+176)^
  }



 rez.re:=(PArrayD(Adr+64)^[PInteger(Adr+80)^]*PDouble(Adr+96)^*PDouble(Adr+112)^-PArrayE(Adr)^[PInteger(Adr+16)^]*PExtended(Adr+144)^*PExtended(Adr+32)^)*PArrayI(Adr+160)^[PInteger(Adr+176)^];
 rez.im:=(PArrayD(Adr+64)^[PInteger(Adr+80)^]*PDouble(Adr+96)^*PDouble(Adr+128)^-PArrayE(Adr)^[PInteger(Adr+16)^]*PExtended(Adr+144)^*PExtended(Adr+48)^)*PArrayI(Adr+160)^[PInteger(Adr+176)^];


 //flLoadFPUEP(&rez);
 asm
     fld rez.im
     fld rez.re
   end;

end;




//spall(@vx,nx,@zx,@vd,nd,d,zd,@x,@vi,@ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
procedure spallp(pvx: PArrayE; nx: integer;  pzx: PComplexE;  pvd: PArrayD; nd: Integer; d: double; zd: TComplexD; px: PExtended;  pvi: PArrayI; pni: PInteger); cdecl;
var
rez: TComplexE;
begin
//rez=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]


 rez.re:=(pvd^[nd]*d*zd.re-pvx^[nx]*px^*pzx^.re)*pvi^[pni^];
 rez.im:=(pvd^[nd]*d*zd.im-pvx^[nx]*px^*pzx^.im)*pvi^[pni^];

 //flLoadFPUEP(&rez);
 asm
     fld rez.im
     fld rez.re
 end;

end;




//spall(@vx,@nx,@zx,@vd,@nd,@d,@zd,@x,@vi,@ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
procedure spall_ptr(pvx: PArrayE; pnx: Pinteger;  pzx: PComplexE;  pvd: PArrayD; pnd: PInteger; pd: Pdouble; pzd: PComplexD; px: PExtended;  pvi: PArrayI; pni: PInteger); cdecl;
var
rez: TComplexE;
begin
//rez=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]


 rez.re:=(pvd^[pnd^]*pd^*pzd^.re-pvx^[pnx^]*px^*pzx^.re)*pvi^[pni^];
 rez.im:=(pvd^[pnd^]*pd^*pzd^.im-pvx^[pnx^]*px^*pzx^.im)*pvi^[pni^];

 //flLoadFPUEP(&rez);
 asm
     fld rez.im
     fld rez.re
 end;

end;

//spall(ve,vi[k+j],z5,vd,vi[k+3],vd[2*k+3*j*k+1],z2,z3.im,vi,j)
//spall(@ve,@vi[k+j],@z5,@vd,@vi[k+3],@vd[2*k+3*j*k+1],@z2,@z3.im,@vi,@j)





function MS2A(Adr: Cardinal): extended;  stdcall;
begin                  //ms2a(vd,j)
  MS2A:=PArrayD(Adr)^[PInteger(Adr+16)^]//-PArrayE(Adr+32)^[PInteger(Adr+80)^]+PDouble(Adr+16)^-PExtended(Adr+64)^;
end;

procedure FVDL(vd: TArrayD); stdcall;
var
 L: Integer;
 k: Integer;
begin
  //L:=Length(VD);
  //FVDL:=VD[i]+VD[i+1];
  //SetLength(vd,i);
  L:=Length(vd);
  for k := 0 to L - 1 do
   begin
     vd[k]:=k+1;
   end;
end;



function PVDL(vd: Pointer{PArrayD}): extended;  stdcall;
var
 L,k: Integer;
 s: double;
begin
  L:=Length(PArrayD(VD)^);
  s:=0;
  //SetLength(vd^,i^);
  for k := 0 to L - 1 do
   begin
     s:=s+PArrayD(VD)^[k];
   end;
  PVDL:=s;
  //PVDL:=VD^[i^]+VD^[i^+1];
end;





procedure SP0P;  stdcall;
begin
 resf.re:=x;
end;



function SP0: extended;  stdcall;
begin
 SP0:=123.456789;
end;




procedure SP0Z;  stdcall;
var re,im: double;
begin
re:=321.98765;
im:=456.789123;
  asm
   fld im
   fld re
 end;
end;




function PS0: double;  cdecl;
begin
 PS0:=123.456789;
end;


procedure PS0Z;  cdecl;
var re,im: double;
begin
re:=321.98765;
im:=456.789123;
  asm
   fld im
   fld re
 end;
end;




function SP1idS(x1: extended; ID: Integer): extended;  stdcall;
begin
 SP1idS:=x1*x1+ID;
end;


function SP1idC(x1: extended; ID: Integer): extended;  cdecl;
begin
 SP1idC:=x1*x1+ID;
end;


function SP1idP(x1: extended; ID: Integer): extended;  pascal;
begin
 SP1idP:=x1*x1+ID;
end;




procedure SP4idS(z1: TComplexE; x: Double; vd: TArrayD; n: Integer; z2: TComplexE; ID: Integer);  stdcall;
var
re,im: Extended;
begin
 re:=z1.re+z2.re+vd[n]+x+ID;
 im:=z1.im+z2.im+ID;

 asm
   fld im
   fld re
 end;

end;





procedure SP4idC(z1: TComplexE; x: Double; vd: TArrayD; n: Integer; z2: TComplexE; ID: Integer);  cdecl;
var
re,im: Extended;
begin
 re:=z1.re+z2.re+vd[n]+x+ID;
 im:=z1.im+z2.im+ID;

 asm
   fld im
   fld re
 end;

end;



 //дл€ "pascal" не работает, т.к. передаетс€ адрес, а не числа
procedure SP4idP(z1: TComplexE; x: Double; vd: TArrayD; n: Integer; z2: TComplexE; ID: Integer);  pascal;
var
re,im: Extended;
begin
 re:=z1.re+z2.re+vd[n]+x+ID;
 im:=z1.im+z2.im+ID;

 asm
   fld im
   fld re
 end;

end;



function SP0idS(ID: Integer): double;  stdcall;
begin
 SP0idS:=ID;
end;



function SP0idC(ID: Integer): double;  cdecl;
begin
 SP0idC:=ID;
end;



function SP0idP(ID: Integer): double;  pascal;
begin
 SP0idP:=ID;
end;



function PS1idS(x1: PDouble; ID: Integer): double;  stdcall;
begin
 PS1idS:=x1^*x1^+ID;
end;



function PS1idC(x1: PExtended; ID: Integer): double;  cdecl;
begin
 PS1idC:=x1^*x1^+ID;
end;



function PS1idP(x1: PExtended; ID: Integer): double;  pascal;
begin
 PS1idP:=x1^*x1^+ID;
end;


//real
function MS1idC(Adr: Cardinal; ID:Integer): double; cdecl;
begin
 MS1idC:=sqr(PDouble(Adr)^)+ID;
end;



//real
function MS1idS(Adr: Cardinal; ID:Integer): double; stdcall;
begin
 MS1idS:=sqr(PDouble(Adr)^)+ID;
end;


//real
function MS0idC(Adr: Cardinal; ID:Integer): double; cdecl;
begin
 MS0idC:=ID;
end;



//real
function MS0idS(Adr: Cardinal; ID:Integer): double; stdcall;
begin
 MS0idS:=ID;
end;



function PS0idS(ID: Integer): double;  stdcall;
begin
 PS0idS:=ID;
end;



function PS0idC(ID: Integer): double;  cdecl;
begin
 PS0idC:=ID;
end;



function PS0idP(ID: Integer): double;  pascal;
begin
 PS0idP:=ID;
end;




procedure PS4idS(z1: PComplexE; x: PDouble; vd: PArrayD; n: PInteger; z2: PComplexE; ID: Integer);  stdcall;
var
re,im: Extended;
begin
 re:=z1^.re+z2^.re+x^+vd^[n^]+ID;
 im:=z1^.im+z2^.im+ID;

 asm
   fld im
   fld re
 end;

end;



procedure  PS4idC(z1: PComplexE; x: PDouble; vd: PArrayD; n: PInteger; z2: PComplexE; ID: Integer);  cdecl;
var
re,im: Extended;
begin
 re:=z1^.re+z2^.re+x^+vd^[n^]+ID;
 im:=z1^.im+z2^.im+ID;

 asm
   fld im
   fld re
 end;
end;



procedure  PS4idP(z1: PComplexE; x: PDouble; vd: PArrayD; n: PInteger; z2: PComplexE; ID: Integer); pascal;
var
re,im: Extended;
begin
 re:=z1^.re+z2^.re+x^+vd^[n^]+ID;
 im:=z1^.im+z2^.im+ID;

 asm
   fld im
   fld re
 end;
end;



procedure MS4idC(Adr: Cardinal; ID: Integer);  cdecl;
var
re,im: extended;
begin
  re:=PExtended(Adr)^+PDouble(Adr+32)^+PArrayD(Adr+48)^[PInteger(Adr+64)^]+PExtended(Adr+80)^+ID;
  im:=PExtended(Adr+16)^+PExtended(Adr+96)^+ID;
  asm
   fld im
   fld re
 end;
end;



procedure MS4idS(Adr: Cardinal; ID: Integer);  stdcall;
var
re,im: extended;
begin
  re:=PExtended(Adr)^+PDouble(Adr+32)^+PArrayD(Adr+48)^[PInteger(Adr+64)^]+PExtended(Adr+80)^+ID;
  im:=PExtended(Adr+16)^+PExtended(Adr+96)^+ID;
  asm
   fld im
   fld re
 end;
end;



procedure MS4idP(Adr: Cardinal; ID: Integer);  pascal;
var
re,im: extended;
begin
  re:=PExtended(Adr)^+PDouble(Adr+32)^+PArrayD(Adr+48)^[PInteger(Adr+64)^]+PExtended(Adr+80)^+ID;
  im:=PExtended(Adr+16)^+PExtended(Adr+96)^+ID;
  asm
   fld im
   fld re
 end;
end;



function MA1idS:extended; stdcall;
var
id: Integer;
x1,x2,x3: double;
Adr: Cardinal;
begin

asm
    push   eax
    mov    Adr,eax
    mov    eax,[ebp+8]
    mov    id,eax
    mov    eax,[ebp+12]          //+12(вместо 8) т.к. в вершине стека -ID
    //fld    qword ptr [EAX]
    //fstp   x1
    //fld    qword ptr [EAX+16]
    //fstp   x2
    //fld    qword ptr [EAX+32]
    //fstp   x3
    pop    eax
end;

{
asm
 push  ebp
 push  dword ptr [ebp+8]
 pop   Id
 pop   ebp
 mov    Adr,eax
end;
}

MA1idS:=sqr(PDouble(Adr)^)+ID;
end;



procedure MA4idP; pascal;
var
id: Integer;
re,im: extended;
Adr: Cardinal;
begin

asm
    push   eax
    mov    Adr,eax
    mov    eax,[ebp+8]
    mov    id,eax
    mov    eax,[ebp+12]          //+12(вместо 8) т.к. в вершине стека -ID
    //fld    qword ptr [EAX]
    //fstp   x1
    //fld    qword ptr [EAX+16]
    //fstp   x2
    //fld    qword ptr [EAX+32]
    //fstp   x3
    pop    eax
end;

{
asm
 push  ebp
 push  dword ptr [ebp+8]
 pop   Id
 pop   ebp
 mov    Adr,eax
end;
}
  re:=PExtended(Adr)^+PDouble(Adr+32)^+PArrayD(Adr+48)^[PInteger(Adr+64)^]+PExtended(Adr+80)^+ID;
  im:=PExtended(Adr+16)^+PExtended(Adr+96)^+ID;
  asm
   fld im
   fld re
 end;
end;




//InfZidS(z1,z2,z3,z3-z2,z2-z1,z1*z2)
procedure InfZid(adr,len,id: Cardinal); {cdecl;}{pascal;}stdcall;
var
N,i:Integer;
Sz: TComplexE;
z1,z2: TComplexE;
r1,r2,Sx,Sy: Extended;//Double;
begin
Sz.re:=id;
Sz.im:=id;
for I := 0 to len - 1 do
begin
  Sz.re:=Sz.re+PExtended{PDouble}(Adr+32*i)^;
  Sz.im:=Sz.im+PExtended{PDouble}(Adr+32*i+16)^;
end;

 asm
  fld Sz.im
  fld Sz.re
 end
end;



//InfRidS(x,y,t,x-t,y-x,t*y)
procedure InfRid(adr,len,id: Cardinal); {cdecl;}{pascal;}stdcall;
var
N,i:Integer;
Sz: TComplexE;
z1,z2: TComplexE;
r1,r2,Sx,Sy: Extended;//Double;
begin
Sz.re:=id;
//Sz.im:=id;
for I := 0 to len - 1 do
begin
  Sz.re:=Sz.re+PExtended{PDouble}(Adr+16*i)^;     //real: Adr+16*i
end;

 asm
  //fld Sz.y
  fld Sz.re
 end
end;



function SPVd(vd1: TArrayD; n1: Integer):extended;  stdcall;//cdecl;
begin
   SPVd:=vd1[n1];
end;




function SPVi(vd1: TArrayI; n1: Integer):extended;  stdcall;//cdecl;
begin
   SPVi:=vd1[n1];
end;




function SPVe(vd1: TArrayE; n1: Integer):extended;  stdcall;//cdecl;
begin
   SPVe:=vd1[n1];
end;


function MSt(Adr: Cardinal): extended;  stdcall;
//mst(vd,n,x)=vd[n]*x
{var
x: Extended;
n: Integer;
vd: TArrayD;}
begin
  {vd:=PArrayD(Adr)^;
  n:=PInteger(Adr+16)^;
  x:=PExtended(Adr+32)^;
  MSt:=vd[n]*x; }
  MSt:=PArrayD(Adr)^[PInteger(Adr+16)^]*PExtended(Adr+32)^;
end;





function _fovlDR(vd: TArrayD; i: Integer;  x: extended): extended;  stdcall;
begin
  _fovlDR:=vd[i]/x;
end;


function _fovlER(ve: TArrayE; i: Integer;  x: extended): extended;  stdcall;
begin
  _fovlER:=ve[i]/x;
end;


function _fovlIR(vi: TArrayI; i: Integer;  x: extended): extended;  stdcall;
begin
  _fovlIR:=vi[i]/x;
end;


procedure _fovlDZ(vd: TArrayD; i: Integer;  z: TComplexE);  stdcall;
var
Re,Im,t: Extended;
begin
  t:=vd[i]/(sqr(z.re)+sqr(z.im));
  Re:=t*z.re;
  Im:=-t*z.im;
  asm
   fld Im
   fld Re
  end
end;


procedure _fovlEZ(ve: TArrayE; i: Integer;  z: TComplexE);  stdcall;
var
Re,Im,t: Extended;
begin
  t:=ve[i]/(sqr(z.re)+sqr(z.im));
  Re:=t*z.re;
  Im:=-t*z.im;
  asm
   fld Im
   fld Re
  end
end;


procedure _fovlIZ(vi: TArrayI; i: Integer;  z: TComplexE);  stdcall;
var
Re,Im,t: Extended;
begin
 t:=vi[i]/(sqr(z.re)+sqr(z.im));
 Re:=t*z.re;
 Im:=-t*z.im;
 asm
   fld Im
   fld Re
 end
end;




function _fovlRD(x: Pextended; vd: PArrayD; i: PInteger): extended;  stdcall;
begin
  _fovlRD:=x^/vd^[i^];
end;


function _fovlRE(x: Pextended; ve: PArrayE; i: PInteger): extended;  stdcall;
begin
  _fovlRE:=x^/ve^[i^];
end;


function _fovlRI(x: Pextended; vi: PArrayI; i: PInteger): extended;  stdcall;
begin
  _fovlRI:=x^/vi^[i^];
end;


procedure _fovlZD(z: PComplexE; vd: PArrayD; i: PInteger);  stdcall;
var
Re,Im: Extended;
begin

  Re:=z.re/vd^[i^];
  Im:=z.im/vd^[i^];
  asm
   fld Im
   fld Re
  end
end;


procedure _fovlZE(z: PComplexE; ve: PArrayE; i: PInteger);  stdcall;
var
Re,Im,t: Extended;
begin

  Re:=z.re/ve^[i^];
  Im:=z.im/ve^[i^];
  asm
   fld Im
   fld Re
  end
end;


procedure _fovlZI(z: PComplexE; vi: PArrayI; i: PInteger);  stdcall;
var
Re,Im,t: Extended;
begin

  Re:=z.re/vi^[i^];
  Im:=z.im/vi^[i^];
 asm
   fld Im
   fld Re
 end
end;





function StrToArrayI(S: String):Pointer;
var
   L,i: Integer;
   AI: TArrayI;
begin
  L:=Length(S);
  SetLength(VSI,L+1);
  VSI[0]:=L;
 for i:= 1 to L do
  begin
    VSI[i]:=Integer(S[i]);
  end;

 StrToArrayI:=@VSI[0];
end;


function ArrayIToStr(P: Pointer): String;
 var
   S: String;
   L,i: Integer;
   AI:  PArrayI;
begin
  AI:=@TArrayI(P);
  L:=AI^[0];

  S:='';
  for i:= 1 to L do
   begin
     S:=S+chr(AI^[i]);
   end;

  ArrayIToStr:=S;
end;



 //spt6(z1,n,x,z2,k,y)
procedure SPT6(z1: TComplexE; n2: integer; x3: extended; z4: TComplexD; n5: Integer; x6: double); stdcall;
var
re,im: Extended;
begin
 re:=z1.re*n2+z4.re*n5-x3*x6;
 im:=z1.im+z4.im;
 asm
   fld Im
   fld Re
 end;
end;


procedure PST6(z1: PComplexE; n2: Pinteger; x3: Pextended; z4: PComplexD; n5: PInteger; x6: Pdouble); stdcall;
var
re,im: Extended;
begin
 re:=z1^.re*n2^+z4^.re*n5^-x3^*x6^;
 im:=z1^.im+z4^.im;
 asm
   fld Im
   fld Re
 end;
end;


procedure MST6(Adr: Cardinal); stdcall;

var
re,im: extended;
begin
  re:=PExtended(Adr)^*PInteger(Adr+32)^+PDouble(Adr+64)^*PInteger(Adr+96)^-PExtended(Adr+48)^*PDouble(Adr+112)^;
  im:=PExtended(Adr+16)^+PDouble(Adr+80)^;
   asm
     fld im
     fld re
   end;
end;


 //spt2(vd,n)
function SPT2(vd1: TArrayD; n2: integer): double;  stdcall;
begin
 SPT2:=vd1[n2];
end;

 //spt5(vd,n,x,ve,k,y)
function SPT5(vd1: TArrayD; n2: integer; x3: extended; ve4: TArrayE; n5: Integer; x6: double): double;  stdcall;  {cdecl;}
begin
 SPT5:=vd1[n2]+x3+ve4[n5]+x6;
end;


function SPT1(x1: double): double;  stdcall;
begin
 SPT1:=x1*x1;
end;



function SPT4(x1: extended; n2: integer; x3: extended; x4: double): double;  stdcall;
begin
 SPT4:=x1+n2+x3+x4;
end;


function SPT3(x1,x2,x3: double): double;  stdcall;
begin
 SPT3:=x1+x2-x3;
end;



procedure SPT1Z(z1: TComplexE);  stdcall;
var
rez: TComplexE;
begin
 rez.re:=z1.re;
 rez.im:=z1.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;


procedure SPT3Z(z1,z2,z3: TComplexE); cdecl;// stdcall;
var
rez: TComplexE;
begin
 rez.re:=z1.re+z2.re+z3.re;
 rez.im:=z1.im+z2.im+z3.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;



procedure SPT4Z(z1: TComplexE; n2: Integer; z3: TComplexD; x4: Extended);  stdcall; {cdecl; }
var
rez: TComplexE;
begin
 rez.re:=z1.re+x4+z3.re+n2;
 rez.im:=z1.im+z3.im;
 asm
   fld rez.im
   fld rez.re
 end;
 //flLoadFPUDP(@rez);
 //flLoadFPUD(rez.re,rez.im);
 //flLoadFPUE(rez.re,rez.im);
 //flLoadFPUEP(@rez);
end;




 //spvs(vs,n*k+10)
function SPVS(vs1: TArrayS; n: integer): double;  stdcall;
begin
 SPVS:=vs1[n]*Length(vs1);
end;



 //spsrcx(sr1,sz1)
procedure SPSRCX(sr1: Single; sz1: TComplexS);  stdcall;
var
rez: TComplexS;
begin
  rez.re:=sr1*sz1.re;
  rez.im:=sr1*sz1.im;
  asm
    fld rez.im
    fld rez.re
  end;
end;



function CallF(Addr: Pointer): Extended; assembler;
asm
  call Addr
end;



function Integral1(Func: Pointer;  PV: PFloatType; a,b: TFloatType): TFloatType;
var
j,i,n:Integer;
x1,x2,Int,H1,hax,sx,ax,h,prf:TFloatType;
begin
H1:=PV^;

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
  Int:=Int+an[i]*CallF(Func)*sx;
 end;

end;



 Integral1:=Int;
 PV^:=H1;
end;





function Integral3FF(Func: Pointer;  PV1,PV2,PV3: PFloatType; a,b: TFloatType; Func1,Func2,Func3,Func4: Pointer): TFloatType;  stdcall;
var
R,j1,i1,j2,i2,j3,i3,n1,n2,n3:Integer;
Int1,Int2,Int3,HV1,HV2,HV3,h1,h2,h3,x1,x2,c,d,e,f,h:TFloatType;
ax1,ax2,ax3,sx1,sx2,sx3: TFloatType;
begin
//h:=H_Integral;
HV1:=PV1^;
HV2:=PV2^;
HV3:=PV3^;

Int3:=0;


n1:=abs(P_Integral);
if n1 = 0 then n1:=1;
n2:=abs(P_Integral);
if n2 = 0 then n2:=1;
n3:=abs(P_Integral);
if n3 = 0 then n3:=1;
h3:=(b-a)/n3;

for j3:=0 to n3-1 do
begin
x1:=a+j3*h3; x2:=a+(j3+1)*h3;
ax3:=(x1+x2)*0.5; sx3:=(x2-x1)*0.5;
for i3:=1 to N_Integral do
begin
PV1^:=sx3*bn[i3]+ax3;

 Int2:=0;
 d:=CallF(Func2);
 c:=CallF(Func1);
 //n2:=Trunc(abs(d-c)/h);
 //if n2 = 0 then n2:=1;
 h2:=(d-c)/n2;
 for j2:=0 to n2-1 do
 begin
   x1:=c+j2*h2; x2:=c+(j2+1)*h2;
   ax2:=(x1+x2)*0.5; sx2:=(x2-x1)*0.5;
   for i2:=1 to N_Integral do
   begin
   PV2^:=sx2*bn[i2]+ax2;

    Int1:=0;
    f:=CallF(Func4);
    e:=CallF(Func3);
  //n1:=Trunc(abs(f-e)/h);
  //if n1 = 0 then n1:=1;
    h1:=(f-e)/n1;
    for j1:=0 to n1-1 do
    begin
      x1:=e+j1*h1; x2:=e+(j1+1)*h1;
      ax1:=(x1+x2)*0.5; sx1:=(x2-x1)*0.5;
      for i1:=1 to N_Integral do
      begin
        PV3^:=sx1*bn[i1]+ax1;
        Int1:=Int1+an[i1]*CallF(Func)*sx1;
      end;
    end;

   Int2:=Int2+an[i2]*Int1*sx2;
   end;
 end;

Int3:=Int3+an[i3]*Int2*sx3;
end;
end;


Integral3FF:=Int3;
PV1^:=HV1;
PV2^:=HV2;
PV3^:=HV3;
end;


function FRInt1XYT(): TFloatType;
begin
   FRInt1XYT:=0.11*PVX^*(0.32*PVT^-0.23*PVY^);
end;



function FRInt2XYT(): TFloatType;
begin
  FRInt2XYT:=0.17*PVT^*(0.31*PVX^+0.17*PVY^);
end;



function FRInt3XYT(): TFloatType;
begin
  FRInt3XYT:=0.21*PVY^*(0.25*PVX^-0.15*PVT^);
end;




function FRLim1X(): TFloatType;
begin
   //FRLim1X:=-2.5*sqrt(1.1*sqr(PVX^+1.5));
   FRLim1X:=-0.5*sqr(PVX^-1.1);
end;


function FRLim2X(): TFloatType;
begin
  //FRLim2X:=2.7*sqrt(1.5*sqr(PVX^+2.5));
  FRLim2X:=0.7*sqr(PVX^+1.7);
end;



function FRLim3XY(): TFloatType;
begin
  //FRLim3XY:=-1.5*sqrt(1.1*sqr(PVX^)+1.7*sqr(PVY^));
  FRLim3XY:=-0.1*sqr(1.1*PVX^-0.2*PVY^);
end;


function FRLim4XY(): TFloatType;
begin
  //FRLim4XY:=2.7*sqrt(4.5*sqr(PVX^)+1.9*sqr(PVY^))*sqrt(1.1*sqr(PVX^)+3.7*sqr(PVY^));
  FRLim4XY:=0.2*sqr(1.2*PVX^-0.3*PVY^);
end;






function Integral1Tst(a,b: TFloatType): TFloatType;


       function IntF(x:TFloatType): TFloatType;
       begin
          IntF:=2.1*x*x-3.2*x+4.5;
       end;

var
j,i,n,N_Int:Integer;
x1,x2,xf,Int,H1,hax,sx,ax,h,prf:TFloatType;
begin

// intf(x:ext):real =  2.1*sqr(x)-3.2*x+4.5;
// integral1(a,b: ext):real  =  Hi:int=high(Aint);n:int=100;h:ext=|b-a|/n; int1:ext=0;   for(j=0, n-1,    x1:ext=a+j*h; x2:ext=a+(j+1)*h; ax:ext=(x1+x2)*0.5; sx:ext=(x2-x1)*0.5;   for(k=0,Hi, xf:ext=sx*Bint[k]+ax; int1=int1+Aint[k]*intf(xf)*sx; )); int1

//h:=H_Integral;
//n:=Trunc(abs(b-a)/h);
n:=100;
N_Int:=Length(Aint);
h:=abs(b-a)/n;




Int:=0;
for j:=0 to n-1 do
begin

 x1:=a+j*h; x2:=a+(j+1)*h;
 ax:=(x1+x2)*0.5; sx:=(x2-x1)*0.5;
 for i:=1 to N_Int do
 begin
  xf:=sx*bn[i]+ax;
  Int:=Int+an[i]*IntF(xf){(2.1*xf*xf-3.2*xf+4.5)}*sx;
 end;

end;

 Integral1Tst:=Int;
end;





function opr1(x1: TFloatType):TFloatType;  cdecl;
begin
 opr1:=x1+1;
end;


function opr2(x1: TFloatType):TFloatType;  cdecl;
begin
 opr2:=x1+2;
end;



function opr3(x1: TFloatType):TFloatType;  cdecl;
begin
 opr3:=x1+3;
end;



function oprm1(x1: TFloatType):TFloatType;  cdecl;
begin
 oprm1:=x1;
end;


function oprm2(x1: TFloatType):TFloatType;  cdecl;
begin
 oprm2:=x1*2;
end;



function oprm3(x1: TFloatType):TFloatType;  cdecl;
begin
 oprm3:=x1*3;
end;




function proc(x1,x2: TFloatType):TFloatType;  cdecl;
begin
 proc:=x1*x2/100;
end;



function __power(x1,x2: TFloatType):TFloatType;  cdecl;
begin
 __power:=power(x1,x2);
end;



procedure cnj(Z: TComplexE);  cdecl;
asm
  fld tbyte ptr Z.im
  fchs
  fld tbyte ptr Z.re
end;





function fbig(x: TFloatType): TFloatType;  stdcall;
begin
 fbig:=power(x*x,x*x);
end;




function fsmall(x: TFloatType): TFloatType;  stdcall;
begin
  fsmall:=x;
end;




function iadd2(n1,n2: Integer): TFloatType;  stdcall;
begin
  iadd2:=n1+n2;
end;




procedure InvR(x: Extended);  cdecl;
asm
  fld tbyte ptr x
  fld1
  fdivrp
end;


procedure _sqr_ovr_r(x: Extended);  cdecl;
asm
  fld   tbyte ptr x
  fld   st(0)
  fmulp st(1),st(0)
end;


procedure _sqr_ovr_cx(z1: TComplexE);  cdecl;
const c2: double = 2.0;
asm
   fld z1.im
   fld z1.re

   fld   st
   fmul  st,st
   fxch
   fmul  st,st(2)
   fmul  c2
   fxch  st(2)
   fmul  st,st
   fsubp

end;






procedure InvZ(Z: TComplexE);  cdecl;
asm
  fld tbyte ptr Z.im
  fld tbyte ptr Z.re

  fld st(0)
  fmul st(0),st(0)
  fxch st(2)
  fld st(0)
  fmul st(0),st(0)
  faddp st(3),st(0)
  fld1
  fdivrp st(3),st(0)
  fmul st(0),st(2)
  fchs
  fxch st(2)
  fmulp
end;



procedure AddRR(x1,x2: Extended);  cdecl;
//procedure AddRR(x1,x2: Extended);  assembler; cdecl;
asm
  fld tbyte ptr x1
  fld tbyte ptr x2
  //fld tbyte ptr [esp+$8]
  //fld tbyte ptr [esp+$14]
  faddp
end;



procedure AddRZ(x1: Extended; z2: TComplexE);  cdecl;
asm
  fld tbyte ptr z2.im
  fld tbyte ptr z2.re
  fld tbyte ptr x1
  faddp
end;



procedure AddZR(z1: TComplexE; x2: Extended);  cdecl;
asm
  fld tbyte ptr z1.im
  fld tbyte ptr z1.re
  fld tbyte ptr x2
  faddp
end;



procedure AddZZ(z1,z2: TComplexE);  cdecl;
asm
  fld tbyte ptr z1.im
  fld tbyte ptr z2.im
  faddp
  fld tbyte ptr z1.re
  fld tbyte ptr z2.re
  faddp
end;



procedure SubRR(x1,x2: Extended);  cdecl;
asm
  fld tbyte ptr x1
  fld tbyte ptr x2
  fsubp
end;



procedure SubRZ(x1: Extended; z2: TComplexE);  cdecl;
asm
  fld tbyte ptr z2.im
  fchs
  fld tbyte ptr z2.re
  fld tbyte ptr x1
  fsubrp
end;



procedure SubZR(z1: TComplexE; x2: Extended);  cdecl;
asm
  fld tbyte ptr z1.im
  fld tbyte ptr z1.re
  fld tbyte ptr x2
  fsubp
end;



procedure SubZZ(z1,z2: TComplexE);  cdecl;
asm
  fld tbyte ptr z1.im
  fld tbyte ptr z2.im
  fsubp
  fld tbyte ptr z1.re
  fld tbyte ptr z2.re
  fsubp
end;




procedure NegR(x1: Extended);  cdecl;
asm
  fld tbyte ptr x1
  fchs
end;




procedure NegZ(z1:  TComplexE);  cdecl;
asm
  fld tbyte ptr z1.im
  fchs
  fld tbyte ptr z1.re
  fchs
end;




procedure MulRR(x1,x2: Extended);  cdecl;
asm
  fld tbyte ptr x1
  fld tbyte ptr x2
  fmulp
end;



procedure MulRZ(x1: Extended; z2: TComplexE);  cdecl;
asm
  fld tbyte ptr x1
  fld tbyte ptr z2.im
  fmul st(0),st(1)
  fxch st(1)
  fld tbyte ptr z2.re
  fmulp
end;



procedure MulZR(z1: TComplexE; x2: Extended);  cdecl;
asm
  fld tbyte ptr x2
  fld tbyte ptr z1.im
  fmul st(0),st(1)
  fxch st(1)
  fld tbyte ptr z1.re
  fmulp
end;



procedure MulZZ(z1,z2: TComplexE);  cdecl;
asm
 fld tbyte ptr z2.im
 fld tbyte ptr z2.re
 fld tbyte ptr z1.im
 fld tbyte ptr z1.re
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





procedure DivRR(x1,x2: Extended);  cdecl;
asm
  fld tbyte ptr x1
  fld tbyte ptr x2
  fdivp
end;



procedure DivRZ(x1: Extended; z2: TComplexE);  cdecl;
//x1/z2; x1-ST,z2.RE-ST(1),z2.IM-ST(2);
//FAST ZDIV!!!
asm

  fld tbyte ptr z2.im
  fld tbyte ptr z2.re
  fld tbyte ptr x1

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



procedure DivZR(z1: TComplexE; x2: Extended);  cdecl;
asm
  fld tbyte ptr x2
  fld tbyte ptr z1.im
  fdiv st(0),st(1)
  fxch st(1)
  fld tbyte ptr z1.re
  fdivrp
end;



procedure DivZZ(z1,z2: TComplexE);  cdecl;
//z1/z2; z1.RE-ST,z1.IM-ST(1),z2.RE-ST(2),z2.IM-ST(3);
//FAST ZDIV!!!
asm
 fld tbyte ptr z2.im
 fld tbyte ptr z2.re
 fld tbyte ptr z1.im
 fld tbyte ptr z1.re


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




procedure  W_PByte; assembler; //cdecl;
asm

     mov eax,[esp+4]      // Addr
     mov ebx,[esp+8]      // Val
     mov byte ptr [eax], bl

end;





procedure _MulCx;   //(a+ bi) * (c+di)
asm
  movddup xmm0, qword ptr[z1d]       //; a, a (high , low qword of xmm0)
  movupd xmm1,  [z2d]      //; d, c
  mulpd xmm0, xmm1        //; ad, ac
  shufpd xmm1, xmm1, 1    //; c, d
  movddup xmm2, qword ptr[z1d+8]   //; b, b
  mulpd xmm2, xmm1       //; bc, bd
  addsubpd xmm0, xmm2   //; bc+ad, ac Цbd (the final result )
  movupd [z3d], xmm0
end;





function Tst1(z1,z2: TComplexD): TComplexD;   stdcall;
begin
Tst1.re:=z1.re+z2.re;
Tst1.im:=z1.im+z2.im;
end;


procedure CheckFalseBlank(S: String; var S1,SE: String);
label endp;
const FalseSymb = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','1','2','3','4','5','6','7','8','9','0'];
var
St1,St2: String;
pb,bs,MaxES,i: Integer;
begin

MaxES:=7;//условно

while S[1] = ' '  do
begin
  Delete(S,1,1);
end;

while S[Length(S)] = ' '  do
begin
  Delete(S,Length(S),1);
end;

pb:=pos('  ',S); //2space
while pb <> 0 do
begin
 Delete(S,pb,1);
 pb:=pos('  ',S); //2space
end;



for i:= 2 to Length(S)-1 do
begin

  if S[i] = ' ' then
  begin
    if (S[i-1] in FalseSymb = True) and (S[i+1] in FalseSymb = True) then
    begin
      bs:=min(pb,Length(S)-i);
      if bs > MaxES  then  bs:=MaxES;
      SE:=Copy(S,i-MaxES,2*MaxES);
      goto endp;
      //Delete(S,pb,1);
    end;
  end;

end;


endp:
end;


procedure TForm1.TestAll;
label endp;
var
 S,S1,S2,S3,S4,S5,S6,S7: String;
Expr: TStringType;
ic,Error,ic1: Cardinal;
T1,T2,SB,adr,gt: Cardinal;
NS: Cardinal;
r1,r2,zx,zy,resd: double;
er1,ex1,ex7: extended;

FZ1,FZ2,FZ3,FZ4,PtrZ1,PtrZ2: Pointer;
FS1,FS2,FS3,FS4,FS5,FS6,FS7: Pointer;
zr1,zr2,zr3,zr4,zr5: TComplexD;
st: array of extended;
ze1,zrese: TComplexE;
zresd,zres: TComplexD;
ptr,P: Pointer;
rt,rt1,ct,len: Cardinal;
NN,n1,n2,ni: integer;
Ans: AnsiString;
Str,SF: String;
WS: WideString;
PAC: PAnsiChar;
acf: array of pointer;
acr: array of double;
adrLen: PCardinal;
adrLenC: Cardinal;
Expr1,Expr2,Expr3,Expr4,Expr5,Expr6,Expr7: TStringType;
NC,NE: Cardinal;
RezCX,FRezCX,SRezCX: TComplexE;
MRezCX,RezCX1,RezCX2,RezCX3,RezCX4,RezCX5,RezCX6,RezCX7: TComplexE;
FRezCX1,FRezCX2,FRezCX3,FRezCX4,FRezCX5,FRezCX6,FRezCX7: TComplexE;
vfs,fvs: array of string;
vs: string;
LS,LC,cLC: integer;
k0,k1,k2,k3,k4,k5,k6,k7: Integer;
cf: array of Pointer;
vrf: array of extended;
vif: array of extended;
tx,txr,txi: extended;
T_1,T_2: Cardinal;
begin




Expr1:='z1*sp3(z1-z2,sp2(z1/x,y/z2),z1/(z2-z3))*sp2(sp2(x-y,z1+z2)/z1,z2/sp2(z2-z3,x+t))/(x*sp1(x+y)/sp1(z1+z3)+z1*sp2(-sp1(z1/z2),x-sp1(x/z1)))';
Expr2:='z1:CXdbl=2.123+1.321i; n:int=3; x: ext=2.135; z2: CXext=3.357-2.975i; y: ext=5.579; k: int=15;'+'z1=(z2*x-z1/y+z1/z2+z1*z2)*(n*z1-k/z2-k*(k*x/z2-y/n*z1-z2/z1)/n)/(z1/z2-z2/z1); x=(z1.re*k-z2.im*y)/(z1.im*x/y-z2.re*x/z1.im-k/n);'+'n=((n+3)*x-k*y)/k;  z2=(z1/k-n/z2)*(x-z1*y*n/z2+z1*z2)*(z2/z1+z1/z2)/((n-z1)*(z2/x-k-z2/z1)*(z1*z2-z1/z2)); k=(5-k)*(n-5)/n;  ((z2/z1-y/x)*k-(x/y-z1/z2)*n)*(z1*z2-x*z1*y*z2/(z1+k-x-z2))/(z1/z2-y*z1*z2*x*k+z2/z1)';
Expr3:='(((z1/z2)^(z2/z1))^(z1/(z1+z2))^(z2/(z1+z2)))*(exp(z1/z2)/(sh(z1/z2)-ch(-z2/z1))-exp(-z2/z1)/(ch(z1/z2)-sh(-z2/z1)))'+'*(sin(z1/(z1+z2))^(z1/z2)+cos(z2/(z1+z2))^(z2/z1)+cos(z1/(z1+z2))^(z1/z2)+sin(z2/(z1+z2))^(z2/z1))/(tan(z1/(z1+z2))*(sin(z1/(z1+z2))^(z1/z2)+cos(z2/(z1+z2))^(z2/z1))-ctg(z1/(z1+z2))^sin(z2/(z1+z2))^(z2/z1)-ctg(z2/(z1+z2)))';
Expr4:='min:int=20; max: int=200; limit:ext=max; res:int=0;  ifp((min > max) or (max <=1), res=0; goto(end));   ifp(max = 3,ifp(min=3,res=1;goto(end),res=2;goto(end)),ifp(max=2,res=1;goto(end)));'+'is_prime:arrayInt=limit+2; jj: ext=0; ic:int=0; k:ext=0; x: int=0; y:int=0; n:ext=0;  Lsqrt:ext=[sqrt(limit)]; for(ic,5,limit,is_prime[ic]=0);'+'for(x,1,Lsqrt,for(y,1,Lsqrt,n=4*sqr(x)+sqr(y);ifp((n<=limit) and ((mod(n,12) = 1) or (mod(n,12) = 5)),is_prime[n]=1-is_prime[n]); n=n-sqr(x); ifp((n<=limit) and (mod(n,12) = 7)'+', is_prime[n]=1-is_prime[n] ); n=n-2*sqr(y); ifp((x>y) and (n<=limit) and (mod(n,12) = 11),is_prime[n]=1-is_prime[n])));  for(ic,5,Lsqrt,ifp(is_prime[ic]=1,k=sqr(ic);n=k; '+'while(n<=limit,is_prime[n]=0; n=n+k))); is_prime[0]=0;  is_prime[0]=0;  is_prime[1]=0; is_prime[2]=1; is_prime[3]=1; for(ic,min,max,ifp(is_prime[ic]=1,inc(res))); end>>res+i';
Expr5:='(x*z1*(2.251*x+1)*(2.243*x*z2/t-2.353*x*(3.475*z3-1)/(2.575*z1-3.675*y-4.766)*(x/(3.767*z1-1)-4.176/x-5.186*(2.866*z1*y*z3-1.766)/(y+1.876)-7.165*(2.874*x*(z2+1.641)*(3.864*y+2.162)*(3.171/(z1+1.765)-2.173*z3'+'/(2.174*z1*y*z3-1.171)+(4.171*x-1.164)*(5.172/z2-7.174)/(x-2.175*z2-1.747-2.174*t/(3.618-7.716*x-8.181*z2*(4.612*z1/(2.189*t+1.165)-7.198*x-8.149/z3+9.912*(2.199*x-1.261)'+'*(3.107*z1+4.179*z2+5.108)*(2.271*z1*z2*z3-7.179)*x*y*z3/(z1-y*2.282-3.621/(x/(z3-1.147)-7.198/(z2+2.245)+8.233/(2.288*x*y/z3+1.247)-9.174))))))))))/(z1*z2*(x*z1*z2-y*z2*z3)*x*y*65.853)';
Expr6:='MinSize:int=10; MaxSize:int=100; vi:arrayInt=0; vd:arrayDbl=0; Sum:ext=0; n:int=0; k:int=0;  itr:int=10; SumVD:Ext=0; for(k,0,itr, SetLen(vd,rnd(MinSize,MaxSize)); L:int=Len(vd);'+' for(n,0,L-1,vd[n]=n; Sum=Sum+n); SumVD=SumVD+sum(vd)); SumVI:Ext=0; for(k,0,itr, SetLen(vi,rnd(MinSize,MaxSize)); L=Len(vi); for(n,0,L-1,vi[n]=n; Sum=Sum+n); SumVI=SumVI+sum(vi)); SetLen(vi,0); SetLen(vd,0); Sum/(SumVD+SumVI)+i';
Expr7:='z1:CXext=1.357+2.321i; z2: CXext=3.123-2.864i; zrez:CXext=0; k: int=0; for(k,1,10,z1=sh(z1/z2)^ch(z1/z2)/sin(z2/z1)^cos(z2/z1)+ch(z1/z2)*sin(z2/z1)/(sh(z1/z2)+cos(z2/z1)); '+'z2=th(z1/z2)^cth(z2/z1)*cth(z1/z2)^th(z2/z1); z2=z1/(z2+z1); z1=z2/(z1+z2) ;zrez=zrez+(z1/z2)^k; ); zrez;';

NE:=7;
NC:=StrToInt(ETest.Text);
setlength(acf,NC*NE);

flSet(fl_Enable,fl_Show_Exception,0);
flCompile(Expr1,0,FS1);
flCompile(Expr2,0,FS2);
flCompile(Expr3,0,FS3);
flCompile(Expr4,0,FS4);
flCompile(Expr5,0,FS5);
flCompile(Expr6,0,FS6);
flCompile(Expr7,0,FS7);

flResultCxEP(FS1,@RezCX1);
flResultCxEP(FS2,@RezCX2);
flResultCxEP(FS3,@RezCX3);
flResultCxEP(FS4,@RezCX4);
flResultCxEP(FS5,@RezCX5);
flResultCxEP(FS6,@RezCX6);
flResultCxEP(FS7,@RezCX7);

MRezCX.re:=RezCX1.re*RezCX2.re*RezCX3.re*RezCX4.re*RezCX5.re*RezCX6.re*RezCX7.re;
MRezCX.im:=RezCX1.im*RezCX2.im*RezCX3.im*RezCX4.im*RezCX5.im*RezCX6.im*RezCX7.im;


ic:=0;
T1:=GetTickCount;
while ic <  Length(acf)-1 do
begin
   flCompile(Expr1,0,acf[ic]);
   flCompile(Expr2,0,acf[ic+1]);
   flCompile(Expr3,0,acf[ic+2]);
   flCompile(Expr4,0,acf[ic+3]);
   flCompile(Expr5,0,acf[ic+4]);
   flCompile(Expr6,0,acf[ic+5]);
   flCompile(Expr7,0,acf[ic+6]);
   ic:=ic+NE;
end;
T2:=GetTickCount;

LCTF.Caption:=IntToStr(T2-T1);

ic:=0;
RezCX.re:=1; RezCX.im:=1;
SRezCX.re:=0; SRezCX.im:=0;

T1:=GetTickCount;
while ic <  Length(acf)-1 do
begin
  RezCX.re:=1; RezCX.im:=1;

  flResultCxEP(acf[ic],@FRezCX1);
  RezCX.re:=RezCX.re*FRezCX1.re;
  RezCX.im:=RezCX.im*FRezCX1.im;

  flResultCxEP(acf[ic+1],@FRezCX2);
  RezCX.re:=RezCX.re*FRezCX2.re;
  RezCX.im:=RezCX.im*FRezCX2.im;

  flResultCxEP(acf[ic+2],@FRezCX3);
  RezCX.re:=RezCX.re*FRezCX3.re;
  RezCX.im:=RezCX.im*FRezCX3.im;

  flResultCxEP(acf[ic+3],@FRezCX4);
  RezCX.re:=RezCX.re*FRezCX4.re;
  RezCX.im:=RezCX.im*FRezCX4.im;

  flResultCxEP(acf[ic+4],@FRezCX5);
  RezCX.re:=RezCX.re*FRezCX5.re;
  RezCX.im:=RezCX.im*FRezCX5.im;

  flResultCxEP(acf[ic+5],@FRezCX6);
  RezCX.re:=RezCX.re*FRezCX6.re;
  RezCX.im:=RezCX.im*FRezCX6.im;

  flResultCxEP(acf[ic+6],@FRezCX7);
  RezCX.re:=RezCX.re*FRezCX7.re;
  RezCX.im:=RezCX.im*FRezCX7.im;

  SRezCX.re:=SRezCX.re+RezCX.re;
  SRezCX.im:=SRezCX.im+RezCX.im;

  for  ic1 := 0 to 10*NE  do
  begin
     flResultCxEP(acf[0],@FRezCX1);
     flResultCxEP(acf[1],@FRezCX1);
     flResultCxEP(acf[2],@FRezCX1);
     flResultCxEP(acf[3],@FRezCX1);
     flResultCxEP(acf[4],@FRezCX1);
     flResultCxEP(acf[5],@FRezCX1);
     flResultCxEP(acf[6],@FRezCX1);
     flResultCxEP(acf[7],@FRezCX1);
  end;


  ic:=ic+NE;
end;
T2:=GetTickCount;

LIPF.Caption:='ms.:  '+IntToStr(T2-T1);

LFR.Caption:=FloatToStr((SRezCX.re/NC)/MRezCX.re+(SRezCX.im/NC)/MRezCX.im);



for ic := 0 to Length(acf)-1 do
begin
  flPerform(fl_Free,Cardinal(acf[ic]));
end;

  flPerform(fl_Free,Cardinal(FS1));
  flPerform(fl_Free,Cardinal(FS2));
  flPerform(fl_Free,Cardinal(FS3));
  flPerform(fl_Free,Cardinal(FS4));
  flPerform(fl_Free,Cardinal(FS5));
  flPerform(fl_Free,Cardinal(FS6));
  flPerform(fl_Free,Cardinal(FS7));


 flSet(fl_Disable,fl_Show_Exception,0);

goto endp;



(*
vs:='x';
vs:='z1';
LS:=6; setlength(vfs,LS); sf:='';
vfs[0]:='sin('+vs+')+';
vfs[1]:='cos('+vs+')+';
vfs[2]:='sec('+vs+')+';
vfs[3]:='cosec('+vs+')+';
vfs[4]:='tan('+vs+')+';
vfs[5]:='cotan('+vs+')+';

///LC:=120; setlength(fvs,LC);
cLC:=0;
for k0 := 0 to LS - 1 do
begin
  for k1 := 0 to LS - 1 do
  begin

   if k1 <> k0 then
   for k2 := 0 to LS - 1 do
   begin
    if (k2 <> k1) and (k2 <> k0) then
    for k3 := 0 to LS - 1 do
    begin
     if (k3 <> k1) and (k3 <> k0) and (k3 <> k2) then
     for k4 := 0 to LS - 1 do
     begin
      if (k4 <> k1) and (k4 <> k0) and (k4 <> k2) and (k4 <> k3) then
      for k5 := 0 to LS - 1 do
       begin
            if (k5 <> k1) and (k5 <> k0) and (k5 <> k2) and (k5 <> k3) and (k5 <> k4) then
            begin
             setlength(fvs,length(fvs)+1);
             fvs[cLC]:=vfs[k0]+vfs[k1]+vfs[k2]+vfs[k3]+vfs[k4]+vfs[k5];
             delete(fvs[cLC],Length(fvs[cLC]),1);
             inc(cLC);
            end;
       end;
     end;
   end;
  end;


 end;
end;



SetLength(cf,Length(fvs));
//flSet(fl_Calc_Type, fl_Real);
flSet(fl_Calc_Type, fl_Complex);
for k0 := 0 to Length(cf) - 1 do
begin
    flCompile(fvs[k0],cf[k0]);
end;

SetLength(vrf,Length(fvs));  SetLength(vif,Length(fvs));
for k0 := 0 to Length(vrf) - 1 do
begin
    flCompile(fvs[k0],cf[k0]);

    flResultCxE(cf[k0],vrf[k0],vif[k0]);
end;

txr:=vrf[0];  txi:=vif[0];
for k0 := 1 to Length(vrf) - 1 do
begin
    if (abs(vrf[k0] - txr) > (1E-18)) or (abs(vif[k0] - txi) > (1E-18)) then
    begin
      //FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT);
       MessageDlg(FloatToStrF(tx,ffGeneral,20,4,G_FMT)+#13#10+'"'+FloatToStrF(vrf[k0],ffGeneral,20,4,G_FMT)+#13#10+'"'+FloatToStrF(vrf[k0]-tx,ffGeneral,20,4,G_FMT)+'"',mtError,[mbOk],0);
       //MessageDlg(fvs[k0],mtError,[mbOk],0);
    end
    else
    begin
     txr:=vrf[k0];
     txi:=vif[k0];
    end;

end;

for k0 := 0 to Length(cf) - 1 do
begin
    flPerform(fl_Free,Cardinal(cf[k0]));
end;

*)


(*
//vs:='x';
vs:='z1';
LS:=7; setlength(vfs,LS); sf:='';
vfs[0]:='sinh('+vs+')*';
vfs[1]:='cosh('+vs+')*';
vfs[2]:='sech('+vs+')*';
vfs[3]:='cosech('+vs+')*';
vfs[4]:='tanh('+vs+')*';
vfs[5]:='cotanh('+vs+')*';
vfs[6]:='exp('+vs+')*';

///LC:=120; setlength(fvs,LC);
cLC:=0;
for k0 := 0 to LS - 1 do
begin
  for k1 := 0 to LS - 1 do
  begin

   if k1 <> k0 then
   for k2 := 0 to LS - 1 do
   begin
    if (k2 <> k1) and (k2 <> k0) then
    for k3 := 0 to LS - 1 do
    begin
     if (k3 <> k1) and (k3 <> k0) and (k3 <> k2) then
     for k4 := 0 to LS - 1 do
     begin
      if (k4 <> k1) and (k4 <> k0) and (k4 <> k2) and (k4 <> k3) then
      for k5 := 0 to LS - 1 do
      begin
         if (k5 <> k1) and (k5 <> k0) and (k5 <> k2) and (k5 <> k3) and (k5 <> k4) then
         for k6 := 0 to LS - 1 do
         begin
             if (k6 <> k1) and (k6 <> k0) and (k6 <> k2) and (k6 <> k3) and (k6 <> k4)  and (k6 <> k5) then
             begin
               setlength(fvs,length(fvs)+1);
               fvs[cLC]:=vfs[k0]+vfs[k1]+vfs[k2]+vfs[k3]+vfs[k4]+vfs[k5]+vfs[k6];
               delete(fvs[cLC],Length(fvs[cLC]),1);
               inc(cLC);
             end;
         end;
      end;

     end;
   end;
  end;


 end;
end;



SetLength(cf,Length(fvs));
//flSet(fl_Calc_Type, fl_Real);
flSet(fl_Calc_Type, fl_Complex);
for k0 := 0 to Length(cf) - 1 do
begin
    flCompile(fvs[k0],cf[k0]);
end;

SetLength(vrf,Length(fvs));  SetLength(vif,Length(fvs));
for k0 := 0 to Length(vrf) - 1 do
begin
    flCompile(fvs[k0],cf[k0]);
end;

//T_1:=GettickCount;
//for k1 := 0 to 100 do
 for k0 := 0 to Length(vrf) - 1 do
 begin
    flResultCxE(cf[k0],vrf[k0],vif[k0]);
 end;
//T_2:=GettickCount;

//CTF.Caption:=IntToStr(T_2-T_1);

txr:=vrf[0];  txi:=vif[0];
for k0 := 1 to Length(vrf) - 1 do
begin
    if (abs(vrf[k0] - txr) > (1E-18)) or (abs(vif[k0] - txi) > (1E-18)) then
    begin
      //FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT);
       MessageDlg(FloatToStrF(vrf[k0] - txr,ffGeneral,20,4,G_FMT)+#13#10+'"'+FloatToStrF(vif[k0] - txi,ffGeneral,20,4,G_FMT)+#13#10+'"'+fvs[k0]+'"',mtError,[mbOk],0);
       //MessageDlg(fvs[k0],mtError,[mbOk],0);
    end
    else
    begin
     txr:=vrf[k0];
     txi:=vif[k0];
    end;

end;

for k0 := 0 to Length(cf) - 1 do
begin
    flPerform(fl_Free,Cardinal(cf[k0]));
end;
*)


 (*
 S1:=EF.Text;
 //flSet(fl_Enable,fl_Show_Exception);
 //flSet(fl_Calc_Type, fl_real);
 setlength(acf,200);
 //flSet(fl_Calc_Type, fl_real);
 T1:=GetTickCount;
    for ic := 0 to Length(acf)-1 do
    begin
       flCompile(S1,FS1);
       acf[ic]:=FS1;
    end;
 T2:=GetTickCount;
  {
   for ic := 0 to Length(acf)-1 do
    begin
       flResultD(acf[ic],r1);
       r2:=r1+r2;
    end;
   }
  for ic := 0 to Length(acf)-1 do
    begin
       flPerform(fl_Free,Cardinal(acf[ic]));
    end;

  CTF.Caption:=IntToStr(T2-T1);
 goto endp;
*)
{
r1:=1.0; r2:=3.0; SF:='FVar+fvar';

flSet(fl_DISABLE, fl_LEAD_TO_LOWER_CASE);
flSetVar('fvar', @r1,fl_REAL_DOUBLE);
flSetVar('FVar',@r2, fl_REAL_DOUBLE);
flCompile(SF,FS1);
flResultCxD(FS1,zx,zy);            //R = 4


flSet(fl_ENABLE, fl_LEAD_TO_LOWER_CASE);
flSetVar('fvar',  @r1,fl_REAL_DOUBLE);
flSetVar('FVar', @r2,fl_REAL_DOUBLE);
flCompile(SF,FS1);
flResultCxD(FS1,zx,zy);
}

(*
flSet(fl_Disable,fl_Syntax_Extension);
flSet(fl_Disable,fl_EXTENDED_COMMAND);

S:='x*y-x*(x*t-t*(y*(t+y/(x+y))-t/(y+t*x))+x+y/(t-x/y))';
SetLength(acf,2000);
T1:=GetTickCount;
for ic := 0 to 1000 do
begin
   flCompile(S,acf[ic]);
end;
T2:=GetTickCount;
IPF.Caption:=IntToStr(T2-T1) ;
for ic := 0 to 1000 do
begin
   flPerform(fl_Free,Cardinal(acf[ic]));
end;
goto endp;
*)

(*
S:='((((((x)+((x)))))))';
//S:='x';
//S:='(xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)';
NC:=Trunc(StrToFloat(E_Cnt.Text,G_FMT));
T1:=GetTickCount;
for ic := 0 to NC do
begin
 FindExternalBracketP(@S);
end;
T2:=GetTickCount;
IPF.Caption:=IntToStr(Trunc(NC/(T2-T1))) ;
MT.Lines[0]:=S;
goto endp;

//S:='(-(-(((-(-0-1))))))';
//S:='((0))+((1))';
//S:='(-(-(((-(-0))))))';
{S:=EF.Text;
FindExternalBracketP(@S);
MT.Lines[0]:=S;
goto endp; }
//BRes:=CheckToZeroP(@S);
//if BRes = True then


//S:='(((((-(-0-1))))))';
//S:='((((((-0-1))))))';
//FindExternalBracketP(@S);
//EF.Text:=S; goto endp;
*)
(*
z1e.re:=z1d.re;   z1e.im:=z1d.im;
z2e.re:=z2d.re;   z2e.im:=z2d.im;
flCompile('z1:CXext=1+i; ez2=1+i; ez1=z1+ez2',FS1);
flResult(FS1);
z1e.re:=z2e.re+z2e.im+z1e.re+z1e.im;


  Randomize();
  SB:=RandomRange(2,30000);
  SetLength(ve,SB);
  for ni := 1 to SB-1 do
  begin
     ve[ni]:=1.0;
  end;

  adrLen:=@ve[1];
  dec(adrLen);   //@ve[1]-4b
  PCardinal(adrLen)^:=Length(ve)-1;
  adrGVDF:=@ve[1];

  {
  adrGVDF:=@ve[1];
  adrLenC:=PCardinal(@adrGVDF)^-4;
  PCardinal(adrLenC)^:=Length(ve)-1;
  }
  flResultCxEP(FDyn,@zrese);

  r1:=0;
  for ni := 1 to SB-1 do
  begin
     r1:=r1+ve[ni];
  end;
  r1:=r1/2;
  LFR.Caption:=FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT)+'     '+FloatToStrF(r1,ffGeneral,20,4,G_FMT);
  goto endp;
*)

{
S1:='-20*exp(-0.2*sqrt(0.5*(x^2+y^2)))-exp(0.5*(cos(2*pi*x)+cos(2*pi*y)))+20+a';
S2:='-0.0001*(|sin(x)*sin(y)*exp(|100-sqrt(x^2+y^2)/pi|)|+1)^0.1';
S3:='(1+(x+y+1)^2*(19-14*x+3*x^2-14*y+6*x*y+3*y^2))';
S4:='0.5+(cos(sin(|x^2-y^2|))-0.5)/(1+0.001*(x^2+y^2))^2';
S5:='-|sin(x)*cos(y)*exp(|1-sqrt(x^2+y^2)/pi|)|';
S6:='-(y+47)*sin(sqrt(|y+x/2+47|))-x*sin(sqrt(|x-(y+47)|))';
S7:='sin(3*pi*x)^2+(x-1)^2*(1+sin(3*pi*y)^2)';
 }
{
 flSet(fl_Calc_Type, fl_real);
 flCompile(S1,FS1);
 flCompile(S2,FS2);
 flCompile(S3,FS3);
 flCompile(S4,FS4);
 flCompile(S5,FS5);
 flCompile(S6,FS6);
 flCompile(S7,FS7);



 T1:=GetTickCount;
     for I := 0 to 1000000 do
    begin
       flResultD(FS1,resd);
       flResultD(FS2,resd);
       flResultD(FS3,resd);
       flResultD(FS4,resd);
       flResultD(FS5,resd);
       flResultD(FS6,resd);
       flResultD(FS7,resd);
    end;
 T2:=GetTickCount;
  CTF.Caption:=IntToStr(Trunc((T2-T1)/7));
  //LFR.Caption:=FloatToStr(ex7);
 goto endp;
}
 {
setlength(acf,1000);
 setlength(acr,1000);
 ex7:=0;
 flSet(fl_Calc_Type, fl_real);
 T1:=GetTickCount;
    for I := 0 to 999 do
    begin
       flCompile(S1,FS1);
       acf[i]:=FS1;
    end;
     for I := 0 to 999 do
    begin
       flResultD(FS1,acr[i]);
       ex7:=ex7+acr[i];
    end;
 T2:=GetTickCount;
  CTF.Caption:=IntToStr(T2-T1);
  LFR.Caption:=FloatToStr(ex7);
 goto endp;
 }
{
setlength(mxd1,14); mxd1[0]:=3; mxd1[1]:=4;
setlength(mxd2,14); mxd2[0]:=3; mxd2[1]:=4;
for ni := 2 to Length(mxd1)-1 do mxd1[ni]:=ni-1;

flSetFunction('readmxd(mx:arrayd; i,j: integer):dbl = mx[(i-1)*mx[1]+j+1];',0);
flSetFunction('writemxd(mx:arrayd; i,j: integer; val:double):none= mx[(i-1)*mx[1]+j+1]=val;',0);


flSetFunction('summxd(mx1,mx2,rmx: arrayd):none=  st:integer=mx1[0]; cl:integer=mx1[1]; i:int=0; j:int=0; indx:int=0; for(i,1,st,for(j,1,cl,indx=(i-1)*cl+j+2-1; rmx[indx]=mx2[indx]+mx1[indx]))',0);
flCompile('smx: arrayd=len(mxd1); smx[0]=mxd1[0]; smx[1]=mxd1[1]; i:int=0; for(i,2,len(mxd1)-1,smx[i]=mxd1[i]); summxd(smx,mxd1,mxd2)',FS1);
flCompile('x:dbl=readmxd(mxd2,3,2)+readmxd(mxd1,2,4); writemxd(mxd1,2,3,x)',FS2);

flResult(FS1);
CopyMemory(@mxd1[2],@mxd2[2],(length(mxd2)-2)*8);

flResult(FS1);
CopyMemory(@mxd1[2],@mxd2[2],(length(mxd2)-2)*8);

flResult(FS2);
}


//TestM;
//res:=Test2F;


//sp1z(z1);
//TestM;
{CheckFalseBlank(EF.Text,S1,S2);
if S2 <> ''  then EF.Text:=S2;
goto endp; }


{z1:=Tst1(Tst1(z1,z2),Tst1(z2,z1));
asm
  fld qword ptr [eax+8]
  fld qword ptr [eax]
end;  }

//k:=1; j:=2;
//n:=k mod j;



{
setlength(vd,5);
for I := 0 to Length(vd) - 1 do
  begin
    vd[i]:=i+1;
  end;

adr:=Cardinal(@vd[0]);
asm
  fld qword ptr [z1.im]
  fld qword ptr [z1.re]
  //push eax
  mov eax,[adr]
  //pop eax
end;
 CxD_Poly;
 }
{
flSet(fl_Disable, fl_Var_Name_Lower_Case);
flSetVar('x',@r1,fl_Real_Double);
flSetVar('X',@r2, fl_Real_Double);
r1:=5; r2:=7;
flSet(fl_Disable, fl_Var_Name_Lower_Case);                      //x = X
flCompile('x+X',FS1);
flResultCxDP(FS1,@res);                                                      //res.re=4;

flSet(fl_Enable, fl_Var_Name_Lower_Case);                      //X <> x
flCompile('x+X',FS1);
flResultCxDP(FS1,@res);                                                    //res.re=5;
}


{if RB_FDouble.Checked then  RB_FDoubleClick(Sender) else
if RB_FExtended.Checked then RB_FExtendedClick(Sender);}

(*
flSetVarIntrnl('vecd',fl_ARRAY_REAL_DOUBLE,adrVD1);
flSetVarIntrnl('vece',fl_ARRAY_REAL_EXTENDED,adrVE1);

flCompile('sum(vecd)',FS1);
flCompile('sum(vece)',FS2);

flSetLength(adrVD1,fl_ARRAY_REAL_DOUBLE,3);  flGet(fl_ARRAY_LENGTH,Cardinal(adrVD1),len);
flSetArrayValueD(adrVD1,0,1.1); flSetArrayValueD(adrVD1,1,2.2); flSetArrayValueD(adrVD1,2,3.3);

flSetLength(adrVE1,fl_ARRAY_REAL_EXTENDED,2); flGet(fl_ARRAY_LENGTH,Cardinal(adrVE1),len);
flSetArrayValueE(adrVE1,0,-1.1); flSetArrayValueE(adrVE1,1,-2.2);

//n1:=Length(PArrayD(adrVD1)^); n2:=Length(PArrayE(adrVE1)^);
//zres.re:=n1+n2;
//zres.re:=PArrayD(adrVD1)^[1];
//zres.im:=PArrayE(adrVE1)^[1];

flResultCxEP(FS1,@ze1);
flResultCxEP(FS2,@ze1);


flSetLength(adrVD1,fl_ARRAY_REAL_DOUBLE,5);     flGet(fl_ARRAY_LENGTH,Cardinal(adrVD1),len);
flSetArrayValueD(adrVD1,0,1.1); flSetArrayValueD(adrVD1,1,2.2); flSetArrayValueD(adrVD1,2,3.3);
flSetArrayValueD(adrVD1,3,4.4); flSetArrayValueD(adrVD1,4,5.5);  n1:=Length(PArrayD(adrVD1)^);

flSetLength(adrVE1,fl_ARRAY_REAL_EXTENDED,3 );  flGet(fl_ARRAY_LENGTH,Cardinal(adrVE1),len);
flSetArrayValueE(adrVE1,0,-1.1); flSetArrayValueE(adrVE1,1,-2.2);  flSetArrayValueE(adrVE1,2,-3.3);


flResultCxEP(FS1,@ze1);
flResultCxEP(FS2,@ze1);
*)

{
zr1.re:=1.1; zr1.im:=2.2;
flSetVarIntrnl('z1', fl_COMPLEX_DOUBLE, PtrZ1);
flSetVarValueCxD(PtrZ1,zr1.re,zr1.im);
flCompile('z1+i+2',FZ1);
flResultCxDP(FZ1,@z1);

flSetVarIntrnl('z1', fl_COMPLEX_EXTENDED, PtrZ2);
flSetVarValueCxE(PtrZ2,z1.re,z1.im);
flCompile('z1*2',FZ2);
flResultCxEP(FZ2,@ze1);

zres.re:=ze1.re; zres.im:=ze1.im;
}
{
zr1.re:=1.1; zr1.im:=2.2;  x:=2;
flSetVarIntrnl('z1', fl_COMPLEX_DOUBLE, PtrZ1);
flCompile('z1+i+2',FZ1);

flSetVarIntrnl('z1', fl_COMPLEX_EXTENDED, PtrZ2);
flCompile('z1*x',FZ2);

flSetVarValueCxD(PtrZ1,zr1.re,zr1.im);
flResultCxEP(FZ1,PtrZ2);
flResultCxEP(FZ2,@ze1);

zres.re:=ze1.re; zres.im:=ze1.im;
}

//flSet(fl_Calc_Type,fl_Real);
//flSet(fl_enable,fl_Syntax_Extension);     //[x*5.77]
{zr1.re:=2; zr1.im:=-1;
fzPolarDP(@zr1,@zr2);
zr1.re:=zr2.re; zr1.im:=zr2.im;
fzDecartDP(@zr2,@zr3);
zr5.re:=zr3.re; zr5.im:=zr3.im;}

{
 flCompile('x/y',FZ1);
 flCompile('z1*z2+x',FZ2);
 flCompile('x*2+t*y-y/x',FZ3);
 flCompile('z1/z2+i*x',FZ4);
 flResultD(FZ1,zr1);
 flResultD(FZ2,zr2);
 flResultD(FZ3,zr3);
 flResultD(FZ4,zr4);
 flPerform(fl_Free,Cardinal(FZ1)); flPerform(fl_Free,Cardinal(FZ2)); flPerform(fl_Free,Cardinal(FZ3)); flPerform(fl_Free,Cardinal(FZ4));
 zr5.re:=zr1.re+zr2.re+zr3.re+zr4.re; zr5.im:=zr1.im+zr2.im+zr3.im+zr4.im;
 S1:=FloatToStr(zr5.im); S2:=FloatToStr(zr5.im); LFR.Caption:=S1+'  '+S2+'i';
}
 {
 Ptr:=StrToArrayI(EF.Text);
 S1:=ArrayIToStr(Ptr);
 }
 {
 flSet(fl_String_Type,fl_String_Internal);
  flCompile(StrToArrayI(EF.Text),FZ1);
 flSet(fl_String_Type,fl_String);
 }


 endp:
end;




procedure FindExternalBracket(S: String; var SS: String);
label 1,endp;
var
b,i,z,a:Integer;
begin
SS:=Copy(S,1,Length(S));



1:
if SS = '' then
begin
goto endp;
end;

if (SS[1] = '(') and (SS[Length(SS)] = ')') then
begin
  b:=-1;
  for i:=2 to Length(SS)-1 do
  begin
   if SS[i] = '(' then b:=b-1;
   if SS[i] = ')' then b:=b+1;

   if b = 0 then goto endp;
  end;

 Delete(SS,Length(SS),1);
 Delete(SS,1,1);
 goto 1;
end;




endp:
end;


procedure ConvToAtn2(S1: String; var S2: String);

  procedure   FindAtn2Arg(Sa: String;  var Sa1,Sa2: String; var BH: Boolean);
  label rep,endp;
  var
     i,bp,pd,cp: integer;
     pps,ppd: Boolean;
  begin


     FindExternalBracket(Sa,Sa);

     BH:=False;
     bp:=0; pd:=0;   pps:=false; {+,-,*}  ;ppd:=false; {/}
     for i := 1 to Length(Sa)  do
     begin
        if (Sa[i] = '(') or  (Sa[i] = '[') or (Sa[i] = '{') then inc(bp)
        else
        if (Sa[i] = ')') or  (Sa[i] = ']') or (Sa[i] = '}') then dec(bp)
        else
        if (bp = 0) and ((Sa[i] = '+') or  (Sa[i] = '-') or (Sa[i] = '*'))  then
        begin  pps:=true; goto endp; end
        else
        if (bp = 0) and  (Sa[i] = '/') and (ppd = false) then
        begin  ppd:=true; pd:=i; {Sa1:=Copy(Sa,1,i); Sa2:=Copy(Sa,i,Length(Sa)-i); BH:=True; goto endp;} end;
     end;

     if ppd = true then
     begin
       Sa1:=Copy(Sa,1,pd-1); Sa2:=Copy(Sa,pd+1,Length(Sa)-pd); BH:=True;
     end;

  endp:
  end;

var

  Sn,Sa1,Sa2: String;
  Ps,Pa,cp,bp: Integer;
  i,j,Lf: Integer;
  BH: Boolean;
begin
  Sn:='arctan'+'('; //

  Lf:=Length(Sn)-1;

  //S1:='arctan(((((x)/y)/(t))))';
  //S1:='arctan((x/y/t))';
  //S1:='x+arctan(x/y)+y';
  //S1:='arctan([x/y])';
  //S1:='x*arctan(x/y)+y*arctan(y/x)*y';
  S1:='x+arctan(x/arctan(y/arctan(arctan(x+y)/arctan(x-y))))+y';
  for i := 1 to Length(S1)  do
  begin
     Ps:=Pos(Sn,S1);
     if Ps <> 0 then
     begin
       cp:=Ps+Lf+1; bp:=-1;
       while (bp <> 0) and (cp <= Length(S1)) do
       begin
        if (S1[cp] = '(') or  (S1[cp] = '[') or (S1[cp] = '{') then dec(bp)
        else
        if (S1[cp] = ')') or  (S1[cp] = ']') or (S1[cp] = '}') then inc(bp);

        inc(cp);
       end;

       FindAtn2Arg(Copy(S1,Ps+Lf+1,cp-Ps-Lf-2),Sa1,Sa2,BH);
       if BH = True then
       begin
         Delete(S1,Ps,cp-Ps);
         Insert('arctan2('+Sa1+','+Sa2+')',S1,Ps);
       end;
     end;
  end;

  S2:=S1;

end;



(*

function Test2: TComplexNum;
var
 n1,n2,n3,L: integer;
 zs1,zs2: TComplexNum;
 x,y: extended;
begin
 zs1:=z1; zs2:=z2;
 x:=z1.re; y:=z2.re;
 L:=Length(VE1)-10;

  for n1 := 1 to L - 1 do
  begin
    for n2 := 1 to L - 1 do
    begin

        if n2 > n1 then
        begin
         //zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1));
         //zs2:=((x-zs2*(zs2-y)+y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2));
         zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))+zs1*i*x;
         zs2:=((x-zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))-zs2*i*y;
       end;

      for n3 := 1 to L - 1 do
      begin

        if n3 > n2 then
        begin
          if n3 > n1 then
          begin
             if (zs1.re > zs1.im) and (zs2.re < zs2.im) then
             begin
               zs1:=((zs1*zs2+VE1[n3-n1])*(zs1*(zs2+zs1*VE2[n3-n2])-zs2*(zs2+zs1*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs1*(zs2-zs1*VE2[n3-n2])+zs2*(zs2+zs1*VE2[n3-n1])));
               zs2:=((zs1*zs2-VE1[n3-n1])*(zs2*(zs2+zs1*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs2*(zs1+zs2*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n3-n1])));

             end
             else
             if (zs1.re < zs2.re) and  (zs1.im < zs2.im)then
             begin
               zs1:=(x*zs1+zs1/x-x/zs1-zs2*y)/(x*zs1-zs1/x+x/zs1+zs2*y);
               zs2:=(x*zs2-zs2/x-x/zs2-zs1*y)/(x*zs2+zs2/x+x/zs2+zs1*y);
             end;
          end
          else
          begin
             zs1:=((zs1*VE1[n1]-zs2*VE2[n1])*(zs1*VE1[n1]-zs2*VE2[n1])-zs1*zs2)/((zs1*VE2[n1]+zs2*VE3[n1])*(zs1*VE1[n1]+zs2*VE3[n1])+zs1*zs2)+zs2*i*x;
             zs2:=((zs2*VE1[n1]-zs1*VE2[n1])*(zs2*VE1[n1]-zs1*VE2[n1])-zs1*zs2)/((zs2*VE2[n1]-zs1*VE3[n1])*(zs2*VE1[n1]+zs1*VE3[n1])+z1*zs2);
          end;
        end
        else
        begin
           if n2 > n1 then
           begin
             zs1:=(zs1.re*VE1[n2-n1]-VE2[n3]*zs1.im)/(zs1/VE2[n2]+VE1[n2-n1]/zs1)-zs2;
             zs2:=(zs2.re*VE1[n2-n1]-VE2[n1]*zs2.im)/(zs2/VE2[n2]+VE1[n3]/zs2)-zs1;
           end
           else
           begin
              zs1:= (zs1/VE1[n1]-VE2[n1-n2]/zs1)/(zs1/VE2[n1-n2]+VE1[n3]/zs1)+zs2;
              zs2:= (zs2/VE1[n1-n2]-VE2[n3]/zs2)/(zs2/VE2[n1]+VE1[n1-n2]/zs2)+zs1;
           end;
        end;
        {
       if n3 > n2 then
       begin
         //zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1));
         //zs2:=((x-zs2*(zs2-y)+y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2));
         zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))+zs1*i*x;
         zs2:=((x-zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))-zs2*i*y;
       end;
       }
    end;
  end;
 end;



   for n1 := 1 to L-1 do
  begin
  {
    //zs1:= (zs1/VE1[n1]-VE2[n1]/zs1)/(zs1/VE2[n1]+VE1[n1]/zs1)+zs1;
    //zs1:=(zs1.re*VE1[n1]-VE2[n1]*zs1.im)/(zs1/VE2[n1]+VE1[n1]/zs1)-zs1;
    //zs1:=((zs1*VE1[n1]-zs2*VE2[n1])*(zs1*VE1[n1]-zs2*VE2[n1])-zs1*zs2)/((zs1*VE2[n1]+zs2*VE3[n1])*(zs1*VE1[n1]+zs2*VE3[n1])+zs1*zs2);
  }
  {
  zs1:=((zs1*zs2+VE1[n1])*(zs1*(zs2+zs1*VE2[n1])-zs2*(zs2+zs1*VE2[n1])))/((zs1*zs2-VE1[n1])*(zs1*(zs2-zs1*VE2[n1])+zs2*(zs2+zs1*VE2[n1])));
  zs1:=(x*zs1+zs1/x-x/zs1-zs2*y)/(x*zs1-zs1/x+x/zs1+zs2*y);
  zs1:=((x-zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))/((x+zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1));
  }

  end;

 Test2:=zs1+zs2;
end;

*)






(*
function Test2: TComplexNum;
var
 n1,n2,n3,L: integer;
 k1,k2,k3,k4,k5,k6,k7,k8: integer;
 zs1,zs2: TComplexNum;
 x,y: extended;
begin
 zs1:=z1; zs2:=z2;
 x:=z1.re; y:=z2.re;
 L:=Length(VE1);
 k1:=0; k2:=0; k3:=0; k4:=0; k5:=0; k6:=0; k7:=0; k8:=0;

  for n1 := 1 to L - 1 do
  begin
    for n2 := 1 to L - 1 do
    begin

        if n2 > n1 then
        begin
         //zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1));
         //zs2:=((x-zs2*(zs2-y)+y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2));
         //zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))+zs1*i*x;
         //zs2:=((x-zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))-zs2*i*y;
         //zs1:=
         //inc(k1);
       end;

      for n3 := 1 to L - 1 do
      begin

        if n3 > n2 then
        begin
            {zs1:=((zs1*zs2+VE1[n3-n1])*(zs1*(zs2+zs1*VE2[n3-n2])-zs2*(zs2+zs1*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs1*(zs2-zs1*VE2[n3-n2])+zs2*(zs2+zs1*VE2[n3-n1])))+zs1;
            zs2:=((zs1*zs2-VE1[n3-n1])*(zs2*(zs2+zs1*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs2*(zs1+zs2*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n3-n1])))+zs2;
            inc(k2); }

          if n3 > n1 then
          begin
             if (zs1.re > zs1.im) and (zs2.re < zs2.im) then
             begin
               zs1:=((zs1*zs2+VE1[n3-n1])*(zs1*(zs2+zs1*VE2[n3-n2])-zs2*(zs2+zs1*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs1*(zs2-zs1*VE2[n3-n2])+zs2*(zs2+zs1*VE2[n3-n1])))+zs1;
               zs2:=((zs1*zs2-VE1[n3-n1])*(zs2*(zs2+zs1*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs2*(zs1+zs2*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n3-n1])))+zs2;
               inc(k2);
             end
             else
             if (zs1.re < zs2.re) and  (zs1.im < zs2.im) then
             begin
               zs1:=(x*zs1+zs1/x-x/zs1-zs2*y)/(x*zs1-zs1/x+x/zs1+zs2*y)+zs1*zs2;
               zs2:=(x*zs2-zs2/x-x/zs2-zs1*y)/(x*zs2+zs2/x+x/zs2+zs1*y)+zs2;
               inc(k3);
             end
             else
             inc(k7);
          end
          else
          begin
             zs1:=((zs1*VE1[n1]-zs2*VE2[n1])*(zs1*VE1[n1]-zs2*VE2[n1])-zs1*zs2)/((zs1*VE2[n1]+zs2*VE3[n1])*(zs1*VE1[n1]+zs2*VE3[n1])+zs1*zs2)+zs1*i*x;
             zs2:=((zs2*VE1[n1]-zs1*VE2[n1])*(zs2*VE1[n1]-zs1*VE2[n1])-zs1*zs2)/((zs2*VE2[n1]-zs1*VE3[n1])*(zs2*VE1[n1]+zs1*VE3[n1])+z1*zs2)-z2*i;
             inc(k4);
          end;

        end
        else   //n3>n2
        begin
           if (n2 > n1) and (n1 > n3) then
           begin
             zs1:=(zs1.re*VE1[n2-n1]-VE2[n3]*zs1.im)/(zs1/VE2[n2]+VE1[n2-n1]/zs1)-i*zs1;
             zs2:=(zs2.re*VE1[n2-n1]-VE2[n1]*zs2.im)/(zs2/VE2[n2]+VE1[n3]/zs2)-zs2;
             inc(k5);
           end
           else
           if n1 > n2 then
           begin
              zs1:= (zs1/VE1[n1]-VE2[n1-n2]/zs1)/(zs1/VE2[n1-n2]+VE1[n3]/zs1)+i*zs1;
              zs2:= (zs2/VE1[n1-n2]-VE2[n3]/zs2)/(zs2/VE2[n1]+VE1[n1-n2]/zs2)+i*zs2;
              inc(k6);
           end
           else
           begin
             zs1:=(zs1*n1+n2*zs2-n3/zs1-zs2/n3)/(zs1*n1+n2*zs2-n3/zs1-zs2/n3)+zs1;
             zs2:=(zs2*n2+n3*zs1-n2/zs2-zs1/n1)/(zs2*n2+n3*zs1+n2/zs2+zs1/n1)+zs2;
             inc(k8);
           end;
        end;

       if n3 > n2 then
       begin
         zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1)){-zs1*i/zs2};
         zs2:=((x-zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2)){-zs2*i/zs1};
          inc(k1);
       end;

    end;
  end;
 end;





 Test2:=zs1+zs2+k1+k2+k3+k4+k5+k6+k7+k8;
 //Test2:=zs1*zs2;
end;

*)


function Test2z: TComplexNum;
var
 n1,n2,n3,L: integer;
 k1,k2,k3,k4,k5,k6,k7,k8: integer;
 zs1,zs2: TComplexNum;
 x,y: TFloatType;
begin
 zs1:=z1; zs2:=z2;
 x:=z1.re; y:=z2.re;
 L:=Length(VE1);
 k1:=0; k2:=0; k3:=0; k4:=0; k5:=0; k6:=0; k7:=0; k8:=0;

  for n1 := 1 to L - 1 do
  begin
    for n2 := 1 to L - 1 do
    begin

        if n2 > n1 then
        begin
         //zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1));
         //zs2:=((x-zs2*(zs2-y)+y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2));
         //zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))+zs1*i*x;
         //zs2:=((x-zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2))-zs2*i*y;
         //zs1:=
         //inc(k1);
       end;

      for n3 := 1 to L - 1 do
      begin

        if n3 > n2 then
        begin
          if n3 > n1 then
          begin
             if (zs1.re > zs1.im) and (zs2.re < zs2.im) then
             begin
               zs1:=((zs1*zs2+VE1[n3-n1])*(zs1*(zs2+zs1*VE2[n3-n2])-zs2*(zs2+zs1*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs1*(zs2-zs1*VE2[n3-n2])+zs2*(zs2+zs1*VE2[n3-n1])))+zs1;
               zs2:=((zs1*zs2-VE1[n3-n1])*(zs2*(zs2+zs1*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs2*(zs1+zs2*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n3-n1])))+zs2;
               inc(k2);
             end
             else
             if (zs1.re < zs2.re) and  (zs1.im < zs2.im) then
             begin
               zs1:=(x*zs1+zs1/x-x/zs1-zs2*y)/(x*zs1-zs1/x+x/zs1+zs2*y)+zs1*zs2;
               zs2:=(x*zs2-zs2/x-x/zs2-zs1*y)/(x*zs2+zs2/x+x/zs2+zs1*y)+zs2;
               inc(k3);
             end
             else
             inc(k7);
          end
          else
          begin
             zs1:=((zs1*VE1[n1]-zs2*VE2[n1])*(zs1*VE1[n1]-zs2*VE2[n1])-zs1*zs2)/((zs1*VE2[n1]+zs2*VE3[n1])*(zs1*VE1[n1]+zs2*VE3[n1])+zs1*zs2)+zs1*i*x;
             zs2:=((zs2*VE1[n1]-zs1*VE2[n1])*(zs2*VE1[n1]-zs1*VE2[n1])-zs1*zs2)/((zs2*VE2[n1]-zs1*VE3[n1])*(zs2*VE1[n1]+zs1*VE3[n1])+z1*zs2)-z2*i;
             inc(k4);
          end;
        end
        else   //n3>n2
        begin
           if (n2 > n1) and (n1 > n3) then
           begin
             zs1:=(zs1.re*VE1[n2-n1]-VE2[n3]*zs1.im)/(zs1/VE2[n2]+VE1[n2-n1]/zs1)-i*zs1;
             zs2:=(zs2.re*VE1[n2-n1]-VE2[n1]*zs2.im)/(zs2/VE2[n2]+VE1[n3]/zs2)-zs2;
             inc(k5);
           end
           else
           if n1 > n2 then
           begin
              zs1:= (zs1/VE1[n1]-VE2[n1-n2]/zs1)/(zs1/VE2[n1-n2]+VE1[n3]/zs1)+i*zs1;
              zs2:= (zs2/VE1[n1-n2]-VE2[n3]/zs2)/(zs2/VE2[n1]+VE1[n1-n2]/zs2)+i*zs2;
              inc(k6);
           end
           else
           begin
             zs1:=(zs1*n1+n2*zs2-n3/zs1-zs2/n3)/(zs1*n1+n2*zs2-n3/zs1-zs2/n3)+zs1;
             zs2:=(zs2*n2+n3*zs1-n2/zs2-zs1/n1)/(zs2*n2+n3*zs1+n2/zs2+zs1/n1)+zs2;
             inc(k8);
           end;
        end;

       if n3 > n2 then
       begin
         zs1:=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1)){-zs1*i/zs2};
         zs2:=((x-zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2)){-zs2*i/zs1};
         inc(k1);
       end;

    end;
  end;
 end;



   for n1 := 1 to L-1 do
  begin
  {
    //zs1:= (zs1/VE1[n1]-VE2[n1]/zs1)/(zs1/VE2[n1]+VE1[n1]/zs1)+zs1;
    //zs1:=(zs1.re*VE1[n1]-VE2[n1]*zs1.im)/(zs1/VE2[n1]+VE1[n1]/zs1)-zs1;
    //zs1:=((zs1*VE1[n1]-zs2*VE2[n1])*(zs1*VE1[n1]-zs2*VE2[n1])-zs1*zs2)/((zs1*VE2[n1]+zs2*VE3[n1])*(zs1*VE1[n1]+zs2*VE3[n1])+zs1*zs2);
  }

    //zs1:=((zs1*zs2+VE1[n1])*(zs1*(zs2+zs1*VE2[n1])-zs2*(zs2+zs1*VE2[n1])))/((zs1*zs2-VE1[n1])*(zs1*(zs2-zs1*VE2[n1])+zs2*(zs2+zs1*VE2[n1])));
    //zs1:=(x*zs1+zs1/x-x/zs1-zs2*y)/(x*zs1-zs1/x+x/zs1+zs2*y);
    //zs1:=((x-zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1))/((x+zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1));


  end;

 //Test2z:=zs1+zs2+k1+k2+k3+k4+k5+k6+k7+k8;
  vx1[1]:=k1;  vx1[2]:=k2; vx1[3]:=k3; vx1[4]:=k4;vx1[5]:=k5;vx1[6]:=k6;vx1[7]:=k7; vx1[8]:=k8;  vx1[9]:=0;
  vx1[10]:=zs1.re;  vx1[11]:=zs1.im;
  vx1[12]:=zs2.re;  vx1[13]:=zs2.im;
  vx1[14]:=0;

 Test2z:=zs1*zs2;
end;




(*


Test2z(z1,z2: complexExt):Complex=

n1:int=0; n2:int=0; n3:int=0;
k1:int=0; k2:int=0;k3:int=0;k4:int=0;k5:int=0;k6:int=0;k7:int=0;k8:int=0;
L:int=Len(VE1);
zs1: ComplexExt=z1;
zs2: ComplexExt=z2;

x: ext=z1.re; y: ext=z2.re;



for(n1,1,L-1,

   for(n2,1,L-1,

      for(n3,1,L-1,

      ifp(n3 > n2,

       ifp(n3 > n1,

           ifp( (zs1.re > zs1.im) and (zs2.re < zs2.im),
               zs1=((zs1*zs2+VE1[n3-n1])*(zs1*(zs2+zs1*VE2[n3-n2])-zs2*(zs2+zs1*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs1*(zs2-zs1*VE2[n3-n2])+zs2*(zs2+zs1*VE2[n3-n1])))+zs1;
               zs2=((zs1*zs2-VE1[n3-n1])*(zs2*(zs2+zs1*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n2])))/((zs1*zs2-VE1[n3])*(zs2*(zs1+zs2*VE2[n3-n2])+zs1*(zs1+zs2*VE2[n3-n1])))+zs2;
               inc(k2);
               ,
               ifp( (zs1.re < zs2.re) and  (zs1.im < zs2.im),
                   zs1=(x*zs1+zs1/x-x/zs1-zs2*y)/(x*zs1-zs1/x+x/zs1+zs2*y)+zs1*zs2;
                   zs2=(x*zs2-zs2/x-x/zs2-zs1*y)/(x*zs2+zs2/x+x/zs2+zs1*y)+zs2;
                   inc(k3);
                  ,
                   inc(k7);
                  );
              );


          ,
          //n3>n1
            zs1=((zs1*VE1[n1]-zs2*VE2[n1])*(zs1*VE1[n1]-zs2*VE2[n1])-zs1*zs2)/((zs1*VE2[n1]+zs2*VE3[n1])*(zs1*VE1[n1]+zs2*VE3[n1])+zs1*zs2)+zs1*i*x;
            zs2=((zs2*VE1[n1]-zs1*VE2[n1])*(zs2*VE1[n1]-zs1*VE2[n1])-zs1*zs2)/((zs2*VE2[n1]-zs1*VE3[n1])*(zs2*VE1[n1]+zs1*VE3[n1])+z1*zs2)-z2*i;
            inc(k4);
          );

     ,
     //n3>n2
            ifp((n2 > n1) and (n1 > n3),

             zs1=(zs1.re*VE1[n2-n1]-VE2[n3]*zs1.im)/(zs1/VE2[n2]+VE1[n2-n1]/zs1)-i*zs1;
             zs2=(zs2.re*VE1[n2-n1]-VE2[n1]*zs2.im)/(zs2/VE2[n2]+VE1[n3]/zs2)-zs2;
             inc(k5);
               ,
                //n2>n1&n1>n3
                ifp (n1 > n2,

                    zs1 = (zs1/VE1[n1]-VE2[n1-n2]/zs1)/(zs1/VE2[n1-n2]+VE1[n3]/zs1)+i*zs1;
                    zs2 = (zs2/VE1[n1-n2]-VE2[n3]/zs2)/(zs2/VE2[n1]+VE1[n1-n2]/zs2)+i*zs2;
                    inc(k6);
                    ,
                    //n1>n2
                    zs1=(zs1*n1+n2*zs2-n3/zs1-zs2/n3)/(zs1*n1+n2*zs2-n3/zs1-zs2/n3)+zs1;
                    zs2=(zs2*n2+n3*zs1-n2/zs2-zs1/n1)/(zs2*n2+n3*zs1+n2/zs2+zs1/n1)+zs2;
                    inc(k8);
                    );

               ) ;
     );



 ifp (n3 > n2,
             zs1=((x-zs1*(zs1-y)+y*(x+zs2))*(zs1.re*zs2+zs2.im*zs1))/((x+zs1*(zs1-y)-y*(x+zs2))*(zs1.re*zs2-zs2.im*zs1));
             zs2=((x-zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1+zs1.im*zs2))/((x+zs2*(zs2-y)-y*(x+zs1))*(zs2.re*zs1-zs1.im*zs2));
             inc(k1);

           );


    );
  );
);

  vx1[1]=k1;  vx1[2]=k2; vx1[3]=k3; vx1[4]=k4;vx1[5]=k5;vx1[6]=k6;vx1[7]=k7; vx1[8]=k8;  vx1[9]=0;
  vx1[10]=zs1.re;  vx1[11]=zs1.im;
  vx1[12]=zs2.re;  vx1[13]=zs2.im;
  vx1[14]=0;

zs1*zs2;

*)




//zs1:Complex=z1; zs2: Complex=z2; n1:int=0;   for(n1, 1, 99, x=zs1.re*ve[n1]; zs2=(zs1/ve[n1]+ve[n1]/zs1) ; zs1=(x)/zs2+i*zs1; ve1[n1]=x; ve2[n1]=zs1.re;  ve3[n1]=zs1.im;);zs1
//zs1:Complex=z1; zs2: Complex=z2; n1:int=0;   for(n1, 1, 99,  zs1=zs1.re*ve[n1]/(zs1/ve[n1]+ve[n1]/zs1)+i*zs1);zs1
//zs1:Complex=z1; zs2: Complex=z2; n1:int=0; for(n1, 1, 99, ve[n1]=(-1)^(n1+5)*(n1+5)*0.5);  for(n1, 1, 99,  zs1=zs1.re*ve[n1]/(zs1/ve[n1]+ve[n1]/zs1)+i*zs1);zs1



//zs1:Complex=z1; zs2: Complex=z2; n1:int=0; for(n1, 1, 99, ve[n1]=(-1)^(n1+5)*(n1+5)*0.5);  for(n1, 1, 99,  zs1=zs1.re*ve[n1]/(zs1/ve[n1]+ve[n1]/zs1)+i*zs1);zs1
function Test3z: TComplexNum;
var
 n1: integer;

 zs1,zs2: TComplexNum;
 x,y: TFloatType;
begin
 zs1:=z1; zs2:=z2;
 x:=z1.re; y:=z2.re;



  for n1 := 1 to 99 do
  begin
   // ve[n1]:=n1;
      ve[n1]:=IntPower(-1,n1+5)*(n1+5)*0.5;
    //ve[n1]:=IntPower(-1,n1+1)*(n1+1)*0.5;
  end;


  for n1 := 1 to 99{j} do
  begin


   zs1:=zs1.re*ve[n1]/(zs1/ve[n1]+ve[n1]/zs1)+i*zs1;

     {
     x:=zs1.re*ve[n1];
     zs2:=(zs1/ve[n1]+ve[n1]/zs1);
     zs1:=x/zs2+i*zs1;

        vx1[n1]:=x;
        vx2[n1]:=zs1.re;
        vx3[n1]:=zs1.im;
    }
  end;




 Test3z:=zs1;
 //Test2:=zs1*zs2;
end;




function Test3zr: TComplexNum;
var
 n1,n2,n3,L: integer;
 k1,k2,k3,k4,k5,k6,k7,k8: integer;
 zs1,zs2: TComplexNum;
 x,y,tr,ti: TFloatType;
begin
 zs1:=z1; zs2:=z2;
 x:=z1.re; y:=z2.re;
 L:=Length(VE1);
 k1:=0; k2:=0; k3:=0; k4:=0; k5:=0; k6:=0; k7:=0; k8:=0;

  for n1 := 1 to 99 do
  begin
         //x=zs1.re;
           x:=zs1.re*ve[n1];

           //zs2:=(zs1/ve[n1]+ve[n1]/zs1);
           zs2.re:=zs1.re/ve[n1]+ve[n1]*zs1.re/(sqr(zs1.re)+sqr(zs1.im));
           zs2.im:=zs1.im/ve[n1]-ve[n1]*zs1.im/(sqr(zs1.re)+sqr(zs1.im));

          //zs1:=(x)/zs2+i*zs1;
          tr:=zs1.re; //ti:=zs1.im;
          zs1.re:=x*zs2.re/(sqr(zs2.re)+sqr(zs2.im))-zs1.im;
          zs1.im:=-x*zs2.im/(sqr(zs2.re)+sqr(zs2.im))+tr;

        ve1[n1]:=x;
        vx2[n1]:=zs1.re;
        vx3[n1]:=zs1.im;

  end;




 Test3zr:=zs1;
 //Test2:=zs1*zs2;
end;


(*
Test2(z1,z2: complexExt):Complex=

n1:int=10;
L:int=100;
zs1: ComplexExt=z1;
zs2: ComplexExt=z2;





for(n1,1,L-1,
           //x=zs1.re;
           x=zs1.re*VE[n1];
          zs2=(zs1/ve[n1]+ve[n1]/zs1);
           zs1=(x)/zs2-i*zs1;

        ve1[n1]=x;
        ve2[n1]=zs2.re;
       ve3[n1]=zs2.im;


);
zs1;
*)




procedure CreateAndFillInternalArray(LenV: Integer; BArray456: Boolean);
var
ic: Integer;
v4,v5,v6: extended;
begin

SetLength(vd,LenV);    SetLength(vdt,LenV);
SetLength(ve,LenV);    SetLength(vet,LenV);
SetLength(vi,LenV);    SetLength(vit,LenV);
SetLength(vs,LenV);
SetLength(vd1,LenV);SetLength(vd2,LenV);SetLength(vd3,LenV);
SetLength(ve1,LenV);SetLength(ve2,LenV);SetLength(ve3,LenV);
SetLength(vi1,LenV);SetLength(vi2,LenV);SetLength(vi3,LenV);
SetLength(vs1,LenV);SetLength(vs2,LenV);SetLength(vs3,LenV);

SetLength(vu1,LenV);   SetLength(vu1t,LenV);
SetLength(vu2,LenV);   SetLength(vu2t,LenV);
SetLength(vu3,LenV);   SetLength(vu3t,LenV);

SetLength(vp1,LenV);
SetLength(vp2,LenV);
SetLength(vp3,LenV);

SetLength(vpu,LenV);
{
SetLength(vpf1,LenV);
SetLength(vpf2,LenV);
SetLength(vpf3,LenV);
}

flSetLength(adrXVD, fl_ARRAY_REAL_DOUBLE, LenV);
flSetLength(adrXVE, fl_ARRAY_REAL_EXTENDED, LenV);
flSetLength(adrXVI, fl_ARRAY_REAL_INTEGER, LenV);
flSetLength(adrXVS, fl_ARRAY_REAL_SINGLE, LenV);

SetLength(AD,3);

AD[0]:=3.5; AD[1]:=-1.4;  AD[2]:=7.6;

for ic := 0 to LenV-1 do
begin
  vd[ic]:=ic+1;
  ve[ic]:=ic+5;
  vs[ic]:=ic+3;

  vd1[ic]:=ic+2;
  vd2[ic]:=ic+3;
  vd3[ic]:=ic+4;

  ve1[ic]:=ic+2;
  ve2[ic]:=ic+3;
  ve3[ic]:=ic+4;

  vs1[ic]:=ic+2;
  vs2[ic]:=ic+3;
  vs3[ic]:=ic+4;


  vd[ic]:=power(-1,ic+1)*vd[ic]*0.5;
  ve[ic]:=power(-1,ic+5)*ve[ic]*0.5;
  vi[ic]:=Trunc(ve[ic]);
  vs[ic]:=power(-1,ic+3)*vs[ic]*0.5;

  vu1[ic]:=vd[ic];
  vu2[ic]:=ve[ic];
  vu3[ic]:=ve[ic];

  vd1[ic]:=power(-1,ic+2)*vd1[ic]*0.7;//0.07
  vd2[ic]:=power(-1,ic+3)*vd2[ic]*0.5;//0.05
  vd3[ic]:=power(-1,ic+4)*vd3[ic]*0.3;//0.03

  ve1[ic]:=power(-1,ic+2)*ve1[ic]*0.7;//0.07
  ve2[ic]:=power(-1,ic+3)*ve2[ic]*0.5;//0.05
  ve3[ic]:=power(-1,ic+4)*ve3[ic]*0.3;//0.03

  vs1[ic]:=power(-1,ic+2)*vs1[ic]*0.7;//0.07
  vs2[ic]:=power(-1,ic+3)*vs2[ic]*0.5;//0.05
  vs3[ic]:=power(-1,ic+4)*vs3[ic]*0.3;//0.03

  vi1[ic]:=Trunc({10*}ve1[ic]);
  vi2[ic]:=Trunc({20*}ve2[ic]);
  vi3[ic]:=Trunc({30*}ve3[ic]);

  vu1[ic]:=ve1[ic];
  vu2[ic]:=ve2[ic];
  vu3[ic]:=ve3[ic];

  vdt[ic]:=vd[ic];
  vet[ic]:=ve[ic];
  vit[ic]:=vi[ic];
  vu1t[ic]:=vu1[ic];
  vu2t[ic]:=vu2[ic];
  vu3t[ic]:=vu3[ic];

  flSetArrayValueD(adrXVD,ic,vd[ic]);
  flSetArrayValueE(adrXVE,ic,ve[ic]);
  flSetArrayValueI(adrXVI,ic,vi[ic]);
  flSetArrayValueS(adrXVS,ic,vs[ic]);
  //if i/2 = trunc(i/2) then vd[i]:=-vd[i];
  //if i/3 = trunc(i/3) then ve[i]:=-ve[i];
  //vd[i]:=vd[i]*0.5;
  //ve[i]:=ve[i]*0.3;
end;


if BArray456 = True then
begin

   flSetLength(adrVD4, fl_ARRAY_REAL_DOUBLE, LenV);
   flSetLength(adrVD5, fl_ARRAY_REAL_DOUBLE, LenV);
   flSetLength(adrVD6, fl_ARRAY_REAL_DOUBLE, LenV);

   flSetLength(adrVE4, fl_ARRAY_REAL_EXTENDED, LenV);
   flSetLength(adrVE5, fl_ARRAY_REAL_EXTENDED, LenV);
   flSetLength(adrVE6, fl_ARRAY_REAL_EXTENDED, LenV);

   flSetLength(adrVI4, fl_ARRAY_REAL_INTEGER, LenV);
   flSetLength(adrVI5, fl_ARRAY_REAL_INTEGER, LenV);
   flSetLength(adrVI6, fl_ARRAY_REAL_INTEGER, LenV);

   flSetLength(adrVS4, fl_ARRAY_REAL_SINGLE, LenV);
   flSetLength(adrVS5, fl_ARRAY_REAL_SINGLE, LenV);
   flSetLength(adrVS6, fl_ARRAY_REAL_SINGLE, LenV);



  for ic := 0 to LenV-1 do
  begin


    v4:=ic+2;
    v5:=ic+3;
    v6:=ic+4;

    v4:=power(-1,ic+2)*v4*0.07;
    v5:=power(-1,ic+3)*v5*0.05;
    v6:=power(-1,ic+4)*v6*0.03;

    flSetArrayValueD(adrVD4,ic,v4); flSetArrayValueD(adrVD5,ic,v5); flSetArrayValueD(adrVD6,ic,v6);
    flSetArrayValueE(adrVE4,ic,v4); flSetArrayValueE(adrVE5,ic,v5); flSetArrayValueE(adrVE6,ic,v6);
    flSetArrayValueS(adrVS4,ic,v4); flSetArrayValueS(adrVS5,ic,v5); flSetArrayValueS(adrVS6,ic,v6);
    flSetArrayValueI(adrVI4,ic,Trunc(v4*10)); flSetArrayValueI(adrVI5,ic,Trunc(v5*10)); flSetArrayValueI(adrVI6,ic,Trunc(v6*10));




  end;

   {
  SetLength(vd4,LenV);SetLength(vd5,LenV);SetLength(vd6,LenV);
  SetLength(ve4,LenV);SetLength(ve5,LenV);SetLength(ve6,LenV);
  SetLength(vi4,LenV);SetLength(vi5,LenV);SetLength(vi6,LenV);
  SetLength(vs4,LenV);SetLength(vs5,LenV);SetLength(vs6,LenV);



  for ic := 0 to LenV-1 do
  begin


    vd4[ic]:=ic+2;
    vd5[ic]:=ic+3;
    vd6[ic]:=ic+4;

    ve4[ic]:=ic+2;
    ve5[ic]:=ic+3;
    ve6[ic]:=ic+4;

    vs4[ic]:=ic+2;
    vs5[ic]:=ic+3;
    vs6[ic]:=ic+4;


    vd4[ic]:=power(-1,ic+2)*vd4[ic]*0.07;
    vd5[ic]:=power(-1,ic+3)*vd5[ic]*0.05;
    vd6[ic]:=power(-1,ic+4)*vd6[ic]*0.03;

    ve4[ic]:=power(-1,ic+2)*ve4[ic]*0.07;
    ve5[ic]:=power(-1,ic+3)*ve5[ic]*0.05;
    ve6[ic]:=power(-1,ic+4)*ve6[ic]*0.03;

    vs4[ic]:=power(-1,ic+2)*vs4[ic]*0.07;
    vs5[ic]:=power(-1,ic+3)*vs5[ic]*0.05;
    vs6[ic]:=power(-1,ic+4)*vs6[ic]*0.03;

    vi4[ic]:=Trunc(10*ve4[ic]);
    vi5[ic]:=Trunc(20*ve5[ic]);
    vi6[ic]:=Trunc(30*ve6[ic]);


  end;
  }

end;



end;



procedure TForm1.RefreshVar;
var
lenv: Integer;
begin
     Ez1xChange(Self);
     Ez1yChange(Self);
     Ez2xChange(Self);
     Ez2yChange(Self);
     ExChange(Self);
     EnChange(Self);
     EkChange(Self);
     EyChange(Self);
     EtChange(Self);
     EjChange(Self);
     Ez3xChange(Self);
     Ez3yChange(Self);

     EAreChange(Self);
     EAimChange(Self);
     EBreChange(Self);
     EBimChange(Self);
     ECreChange(Self);
     ECimChange(Self);

     ErrorF:=0;



     LenV:=G_LenV;

     CreateAndFillInternalArray(G_LenV,False);

(*

     lenv:=Length(vdt);
     SetLength(vd,lenv);
     flCopyArrayDbl(@vd[0],@vdt[0],lenv);

     lenv:=Length(vet);
     SetLength(ve,lenv);
     flCopyArrayExt(@ve[0],@vet[0],lenv);

     lenv:=Length(vit);
     SetLength(vi,lenv);
     flCopyArrayInt(@vi[0],@vit[0],lenv);
    {
     SetLength(vp1,lenv);
     SetLength(vp2,lenv);
     SetLength(vp3,lenv);
    }

  {$IFDEF EXTENDED_FLOAT}

     lenv:=Length(vu1t);
     SetLength(vu1,lenv);
     flCopyArrayExt(@vu1[0],@vu1t[0],lenv);

     lenv:=Length(vu2t);
     SetLength(vu1,lenv);
     flCopyArrayExt(@vu2[0],@vu2t[0],lenv);

     lenv:=Length(vu3t);
     SetLength(vu3,lenv);
     flCopyArrayExt(@vu3[0],@vu3t[0],lenv);


  {$ELSE}

     lenv:=Length(vu1t);
     SetLength(vu1,lenv);
     flCopyArrayDbl(@vu1[0],@vu1t[0],lenv);

     lenv:=Length(vu2t);
     SetLength(vu1,lenv);
     flCopyArrayDbl(@vu2[0],@vu2t[0],lenv);

     lenv:=Length(vu3t);
     SetLength(vu3,lenv);
     flCopyArrayDbl(@vu3[0],@vu3t[0],lenv);

  {$ENDIF}

*)

     Ptr0M1u:=@M1u[0];
     Ptr0M1ux:=@M1ux[0];
     Ptr0M1uy:=@M1uy[0];

     Ptr0VU1:=@vu1[0];
     Ptr0VU2:=@vu2[0];
     Ptr0VU3:=@vu3[0];



end;




{
function CheckToZero(PS: PString): Boolean;
label nxt;
var
b,i,z,a,bp,ep: Integer;
BRes: Boolean;
begin

BRes:=False;
L:=Length(PS^); ep:=0; bp:=1;
nxt:
if (PS^[bp] = '(') and (PS^[L-ep] = ')') then
begin
  inc(bp); inc(ep);
  goto nxt;
end
else
if PS^[bp] = '-' then
begin
  inc(bp);
  goto nxt;
end
else
if Copy(PS^,bp,L-bp-ep+1) = '0' then Bres:=True;

CheckToZero:=BRes;
end;
 }

{
procedure FindExternalBracketP(PS: PString);
label nxt,endp;
var
b,i,z,a,bp,L:Integer;
begin


if PS^ = '' then
begin
goto endp;
end;


L:=Length(PS^);  bp:=1;
nxt:
if (PS^[bp] = '(') and (PS^[L-bp+1] = ')') then
begin
  inc(bp);
  goto nxt;
end
else
begin
  if bp > 1 then
  begin
    Delete(PS^,L-bp+1,bp-1);
    Delete(PS^,1,bp-1);
  end;
end;

endp:
end;
}


procedure FindExternalBracketP(PS: PString);
label outf,nxt,endp;
var
b,i,z,a,bp,ep,L,k: Integer;
BRes: Boolean;
begin

(*
bp:=0;  L:=Length(PS^);

nxt:
if PS^ = '' then
begin
 goto outf;
end;


inc(bp);
if (PS^[bp] = '(') and (PS^[L-bp+1] = ')') then
begin

  b:=0;
  for i:=bp to L-bp do
  begin
    if PS^[i] = '(' then dec(b)
    else
    if PS^[i] = ')' then inc(b);

    if b = 0 then  goto outf;
  end;
  goto nxt;

end;

outf:
dec(bp);
if bp > 0 then
begin
 Delete(PS^,L-bp+1,bp);
 Delete(PS^,1,bp);
end;
*)


nxt:
if PS^ = '' then
begin
 goto endp;
end;

L:=Length(PS^);

if (PS^[1] = '(') and (PS^[L] = ')') then
begin
  b:=0;
  for i:=1 to L-1 do
  begin
   if PS^[i] = '(' then dec(b)
   else
   if PS^[i] = ')' then inc(b);
   if b = 0 then goto endp;
  end;

 Delete(PS^,L,1);
 Delete(PS^,1,1);
 goto nxt;
end;




{
L:=Length(PS^);
while (PS^[1] = '(') and (PS^[L] = ')') and (PS^ <> '') do
begin

  b:=0;
  for i:=1 to L-1 do
  begin
   if PS^[i] = '(' then dec(b)
   else
   if PS^[i] = ')' then inc(b);
   if b = 0 then goto endp;
  end;


 Delete(PS^,L,1);
 Delete(PS^,1,1);
 L:=Length(PS^);
end;
}

endp:
end;



function CheckToZero(S: String): Boolean;
label
2,3,endp;
var
b,i,z,a: Integer;
BRes: Boolean;
begin
//SS:=Copy(S,1,Length(S));

BRes:=False;

z:=1;
2:
b:=0; a:=1;

if S = '' then
begin
goto endp;
end;


if S[1] = '-' then a:=2;

if  S[a] = '(' then
begin
 b:=-1;
 for i:=a+1 to Length(S)-1 do
 begin
  if S[i] = '(' then b:=b-1;
  if S[i] = ')' then b:=b+1;
  if b = 0 then goto 3
 end;


 if S[Length(S)] = ')' then
 begin
  if a = 2 then
  begin
   Delete(S,1,1);
   z:=z*(-1);
  end;
  Delete(S,1,1);
  Delete(S,Length(S),1);
  goto 2;
 end;
end;

3:
{if z = -1 then  Neg:=1
else  Neg:=0; }
if S = '0' then BRes:=True;

CheckToZero:=BRes;

endp:
end;




function CheckToZeroP(PS: PString): Boolean;
label nxt;
var
b,i,z,a,bp,ep,L: Integer;
BRes: Boolean;
begin

BRes:=False;
L:=Length(PS^); ep:=0; bp:=1;
nxt:
if (PS^[bp] = '(') and (PS^[L-ep] = ')') then
begin
  inc(bp); inc(ep);
  goto nxt;
end
else
if PS^[bp] = '-' then
begin
  inc(bp);
  goto nxt;
end
else
if Copy(PS^,bp,L-bp-ep+1) = '0' then Bres:=True;

CheckToZeroP:=BRes;
end;



procedure DeleteSpace(S: String; var S1: String);
label lt,ls;
var i: Integer;
begin
i:=Length(S);

{
while Pos(#9,S) <> 0 do StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);
while Pos(' ',S) <> 0 do StringReplace(S,' ','',[rfReplaceAll, rfIgnoreCase]);
}


 while i >= 1 do
 begin
    if S[i] = ' ' then
   begin
    Delete(S,i,1);
   end;
  dec(i);
 end;

S1:=S;
end;



procedure TForm1.BClearMTClick(Sender: TObject);
begin
  MT.Clear;
end;

procedure TForm1.bDiffExprFileClick(Sender: TObject);
label sz,sm,endp;
var
FN,S,St,Str: String;
Expr: TStringType;
i,P,Cnt: Integer;
res, res_opt, res_rf, resCxyt, resCxyt_opt, resCxyt_rf: TComplexE;
PS: Pointer;
PAS: PAnsiString;
PAC: PAnsiChar;
PWS: PWideString;
PWC: PWideChar;
Ans: AnsiString;
WS: WideString;
F_MStr: Boolean;
begin

{$IFDEF USEFOREVAL}


 if F_LoadExprFile = False then
 begin
   FN := ExtractFilePath(ParamStr(0))+'\TestExpressions.txt';
   if FileExists(FN) then
   begin
     ExprFile:=TStringList.Create;
     ExprFile.LoadFromFile(FN);
     F_LoadExprFile:=True;

     for i := 0 to ExprFile.Count - 1 do
     begin
       StringReplace(ExprFile[i],#9,'',[rfReplaceAll, rfIgnoreCase]);    //Tab
       S:=ExprFile[i];
       DeleteSpace(S,S);
       ExprFile[i]:=S;
       P:=Pos('//',ExprFile[i]);
       S:=ExprFile[i];
       if P <> 0 then Delete(S,P,Length(S)-P+1);
       ExprFile[i]:=S;
     end;

     CntExpr:=1;
     ETest.Text:='1';
   end;
 end;

 if F_LoadExprFile = False then
 begin
   ShowMessage('File: TestExpressions.txt is absent');
   goto endp;
 end;


    if CntExpr > ExprFile.Count then goto endp;
    if ExprFile.Count = 0 then goto endp;


   ETest.Text:=IntToStr(CntExpr);
   CntExpr:=StrToInt(ETest.Text);



    {
   if ExprFile[CntExpr-1] <> '' then EF.Text:=ExprFile[CntExpr-1]
   else
   begin
      inc(CntExpr);
      ETest.Text:=IntToStr(CntExpr);
   end;
    }

    EF.Text:=S;

   St:=''; EF.Text:='';  F_MStr:=False;


   sz:
   if ExprFile[CntExpr-1] <> '' then St:=ExprFile[CntExpr-1]
   else
   begin
      inc(CntExpr);
      goto sz;
   end;


   if St = '(*' then
   begin
        F_MStr:=True;
        //inc(CntExpr);
   end
   else
        EF.Text:=St;

   if F_Mstr = True then
   begin
      sm:
      inc(CntExpr);
      St:=ExprFile[CntExpr-1];
      if St <> '*)' then
      begin
        EF.Text:=EF.Text+St;
        goto sm;
      end
      else
      begin

      end;

   end;



   {$IFDEF PANSICHAR}
       ans:=AnsiString(EF.Text); Expr:=PAnsiChar(ans);
    {$ELSE}
       Expr:=TStringType(EF.Text);
    {$ENDIF}


   flSetDiffExpr(Expr);
   flSetDiffVar('x');
   flDiffExpr(1);
   flSetDiffVar('y');
   flDiffExpr(1);
   flGetDiffString(PS);
   Str:=String(PS);        S:=Copy(Str,1,Length(Str)); Str:='';
   EF.Text:=S;
   (*
  {$IFDEF ANSISTRING}   Ans:=AnsiString(PS);    S:=Copy(Ans,1,Length(Ans)); Ans:='';    {$ENDIF}
  {$IFDEF STRING}       Str:=String(PS);        S:=Copy(Str,1,Length(Str)); Str:='';  {$ENDIF}
  {$IFDEF WIDESTRING}   ws:=WideString(PS);     S:=Copy(ws,1,Length(ws));   ws:='';  {$ENDIF}
  {$IFDEF UTF8}         su8:=UTF8String(PS);    S:=Copy(Su8,1,Length(Su8)); Su8:='';  {$ENDIF}
  {$IFDEF PANSICHAR}    PAC:=PAnsiChar(PS);     Ans:=AnsiString(PAC); S:=Copy(Ans,1,Length(Ans)); Ans:=''; {$ENDIF}
   *)


   FullOptimization;

   CB_VCx.Checked:=False;
   Button1.Click;
   res_opt.re:=G_Res.re;  res_opt.im:=G_Res.im;

   CB_VCx.Checked:=True;
   Button1.Click;
   resCxyt_opt.re:=G_Res.re;  resCxyt_opt.im:=G_Res.im;




   WithoutReplaceOperations;

   CB_VCx.Checked:=False;
   Button1.Click;
   res_rf.re:=G_Res.re;  res_rf.im:=G_Res.im;

   CB_VCx.Checked:=True;
   Button1.Click;
   resCxyt_rf.re:=G_Res.re;  resCxyt_rf.im:=G_Res.im;



   WithoutOptimizations;

   CB_VCx.Checked:=False;
   Button1.Click;
   res.re:=G_Res.re;  res.im:=G_Res.im;

   CB_VCx.Checked:=True;
   Button1.Click;
   resCxyt.re:=G_Res.re;  resCxyt.im:=G_Res.im;



   S:=FloatToStrF(Res_opt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res_opt.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[0]:=S;
   S:=FloatToStrF(Res_rf.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res_rf.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[1]:=S;
   S:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[2]:=S;

   S:=FloatToStrF(ResCxyt_opt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt_opt.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[3]:=S;
   S:=FloatToStrF(ResCxyt_rf.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt_rf.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[4]:=S;
   S:=FloatToStrF(ResCxyt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[5]:=S;


    inc(CntExpr);
    //ETest.Text:=IntToStr(CntExpr);


    EF.Text:=Expr;


{$ENDIF}
endp:
end;


procedure TForm1.bExprFileClick(Sender: TObject);
label sz,sm,endp;
var
FN,S,St: String;
i,P,Cnt: Integer;
res, res_opt, res_rf, resCxyt, resCxyt_opt, resCxyt_rf: TComplexE;
F_MStr: Boolean;
begin

 if F_LoadExprFile = False then
 begin
   FN := ExtractFilePath(ParamStr(0))+'\TestExpressions.txt';
   if FileExists(FN) then
   begin
     ExprFile:=TStringList.Create;
     ExprFile.LoadFromFile(FN);
     F_LoadExprFile:=True;

     for i := 0 to ExprFile.Count - 1 do
     begin
       StringReplace(ExprFile[i],#9,'',[rfReplaceAll, rfIgnoreCase]);    //Tab
       S:=ExprFile[i];
       DeleteSpace(S,S);
       ExprFile[i]:=S;
       P:=Pos('//',ExprFile[i]);
       S:=ExprFile[i];
       if P <> 0 then Delete(S,P,Length(S)-P+1);
       ExprFile[i]:=S;
     end;

     CntExpr:=1;
     ETest.Text:='1';
   end;
 end;

 if F_LoadExprFile = False then
 begin
   ShowMessage('File: TestExpressions.txt is absent');
   goto endp;
 end;


    if CntExpr > ExprFile.Count then goto endp;
    if ExprFile.Count = 0 then goto endp;

   ETest.Text:=IntToStr(CntExpr);
   CntExpr:=StrToInt(ETest.Text);



    {
   if ExprFile[CntExpr-1] <> '' then EF.Text:=ExprFile[CntExpr-1]
   else
   begin
      inc(CntExpr);
      ETest.Text:=IntToStr(CntExpr);
   end;
   }

   St:=''; EF.Text:='';  F_MStr:=False;


   sz:
   if ExprFile[CntExpr-1] <> '' then St:=ExprFile[CntExpr-1]
   else
   begin
      inc(CntExpr);
      goto sz;
   end;


   if St = '(*' then
   begin
        F_MStr:=True;
        //inc(CntExpr);
   end
   else
        EF.Text:=St;

   if F_Mstr = True then
   begin
      sm:
      inc(CntExpr);
      St:=ExprFile[CntExpr-1];
      if St <> '*)' then
      begin
        EF.Text:=EF.Text+St;
        goto sm;
      end
      else
      begin

      end;

   end;

   FullOptimization;

   CB_VCx.Checked:=False;
   B_Calc.Click;
   res_opt.re:=G_Res.re;  res_opt.im:=G_Res.im;

   CB_VCx.Checked:=True;
   B_Calc.Click;
   resCxyt_opt.re:=G_Res.re;  resCxyt_opt.im:=G_Res.im;




   WithoutReplaceOperations;

   CB_VCx.Checked:=False;
   B_Calc.Click;
   res_rf.re:=G_Res.re;  res_rf.im:=G_Res.im;

   CB_VCx.Checked:=True;
   B_Calc.Click;
   resCxyt_rf.re:=G_Res.re;  resCxyt_rf.im:=G_Res.im;



   WithoutOptimizations;

   CB_VCx.Checked:=False;
   B_Calc.Click;
   res.re:=G_Res.re;  res.im:=G_Res.im;

   CB_VCx.Checked:=True;
   B_Calc.Click;
   resCxyt.re:=G_Res.re;  resCxyt.im:=G_Res.im;



   S:=FloatToStrF(Res_opt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res_opt.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[0]:=S;
   S:=FloatToStrF(Res_rf.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res_rf.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[1]:=S;
   S:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[2]:=S;

   S:=FloatToStrF(ResCxyt_opt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt_opt.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[3]:=S;
   S:=FloatToStrF(ResCxyt_rf.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt_rf.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[4]:=S;
   S:=FloatToStrF(ResCxyt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt.im, ffGeneral, 20, 4, G_FMT);
   MT.Lines[5]:=S;

  
    inc(CntExpr);
    //ETest.Text:=IntToStr(CntExpr);


endp:
end;




function TForm1.SpeedCpuFpu: TFloatType;
var
n,k,i,j,m,L: integer;
s: TFloatType;
begin

s:=0;
L:=Length(vd1);

for i := 0 to L-1 do
begin

  for j := 0 to L-1 do
  begin

    if j > i then
        s:= s+vd1[j-i]*vd2[j-i]-vd3[j]*vd1[j]
     else
        s:= s+vd1[i-j]*vd2[i-j]-vd3[j]*vd1[j];

    for k := 0 to L-1 do
    begin

     if (k > j)  then
        s:= s+vd1[k-j]*vd2[k]-vd3[k]*vd1[k]
     else
        s:= s+vd1[j-k]*vd2[k]-vd3[k]*vd1[k];

     if (3*k+j+4 < L-3) and (4*j+3*j*k + 3 < L-2) and (3*k*j+4*j+5*k+3 < L-1) then
       s:=s+vd1[2*k+j+3]*vd2[3*j+2*k*j + 2]-vd3[2*k*j+3*j+4*k+2]*vd1[5*k+k*j*2]+vd1[k+j+2]*vd3[3*k*j+j*2+2]
     else
     begin
      if vd1[k] > vd2[k] then
        s:=s+vd3[k]*vd2[k]
      else
      begin
      if (vd2[k] < vd3[k]) and (vd1[k] < vd2[k]) then
        s:=s-vd2[k]*(vd3[k]-vd1[k])
      else
        s:=s+vd1[k]*(vd2[k]-vd3[k])-vd2[k]*(vd1[k]+vd3[k])
      end;

     end;


    end;

    if (3*j+i+4 < L-3) and (4*j+3*j*i + 3 < L-2) and (3*i*j+4*j+5*i+3 < L-1) then
     s:=s+vd1[2*j+i+3]*vd2[3*j+2*i*j + 2]-vd3[2*j*i+3*j+4*i+2]*vd1[5*i+i*2*j]+vd1[i+j+2]*vd3[j*3*i+j*2+2]
     else
     begin
      if vd1[j] > vd2[j] then
        s:=s+vd3[j]*(vd2[j]-vd1[j])
      else
      begin
      if (vd2[j] < vd3[j]) and (vd1[j] < vd2[j]) then
        s:=s-vd2[j]*(vd3[j]-vd1[j])
      else
        s:=s+vd1[j]*(vd2[j]-vd3[j])-vd2[j]*(vd1[j]+vd3[j])
      end;
     end;

  end;

end;

  SpeedCpuFpu:=s;
end;



function TForm1._Result(Func: Pointer): extended;
asm
 call Func
end;


procedure TForm1.TestMulti;
var
NExpr,i: integer;
Expr: TStringType;
T1,T2: Cardinal;
ans: AnsiString;
r: Extended;
begin

NExpr:=StrToInt(ETest.Text);
SetLength(CFA,NExpr);
r:=0;
//flSet(fl_RESULT_LEAD_TO_TYPE, fl_Real,0);
RB_Re.Checked:=True;

{$IFDEF PANSICHAR}
       ans:=AnsiString(EF.Text); Expr:=PAnsiChar(ans);
{$ELSE}
       Expr:=TStringType(EF.Text);
{$ENDIF}



T1:=GetTickCount;
for i := 0 to NExpr-1 do
begin
   flCompile(Expr,0,CFA[i]);
end;

for i := 0 to NExpr-1 do
begin
   r:=r+_Result(CFA[i]);
end;
T2:=GetTickCount;

LFR.Caption:=FloatToStrF(r/NExpr,ffGeneral,20,4,G_FMT);//FloatToStr(r/NExpr);
LCTF.Caption:=IntToStr(T2-T1);



for i := 0 to NExpr-1 do
begin
   flPerform(fl_FREE,Cardinal(CFA[i]));
end;

  {
zrese.re:=rezCx.re;  zrese.im:=rezCx.im;
S1:=FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT);
S2:=FloatToStrF(zrese.im,ffGeneral,20,4,G_FMT);
LFR.Caption:=S1+'  '+S2+'i';
if not CB_OM.Checked then
 begin if (T2-T1) <> 0 then LIPF.Caption:=IntToStr(Trunc(NC/(T2-T1))) else LIPF.Caption:='no defined'; end;
 }
end;





procedure TForm1.bTestClick(Sender: TObject);
label endp;
var
L,j: integer;
T1,T2: Cardinal;
r: TFloatType;
begin
// TestAll;   goto endp;
TestMulti;   goto endp;


  L:=600;
  SetLength(vd1,L);  SetLength(vd2,L); SetLength(vd3,L);

  randomize;
  for j := 0 to L-1 do
  begin
      vd1[j]:=1+98*Random;
      vd2[j]:=1+98*Random;
      vd3[j]:=1+98*Random;
  end;

  T1:=GetTickCount;
  r:=SpeedCpuFpu;
  T2:=GetTickCount;

  LFR.Caption:=FloatToStr(r);
  LCTF.Caption:=IntToStr(T2-T1);

endp:
end;









//len: int = 50; c: int=0; s: dbl = 0; i:int = 0; l:int=0; r:int=len-1; bf: dbl=0;   vds: arrayDbl = len; for(i,0,len-1, vds[i] = rnd(1,100)); while(l < r, for(i,l,r-1, if(vds[i] > vds[i+1], bf=vds[i]; vds[i] = vds[i+1]; vds[i+1] = bf)); dec(r); fordown(i,r,l+1, if(vds[i] < vds[i-1], bf=vds[i]; vds[i] = vds[i-1]; vds[i-1] = bf)); inc(l););    for(i,0,len-2, if(vds[i] < vds[i+1], s=s+vds[i]; inc(c))); s = s+vds[len-1]; s

function SortShake: double;
var

vds: array of double;
i,len,l,r,c:integer;
bf,s: double;
begin

len:=50;

c:=0; s:= 0; i:= 0; l:=0; r:=len-1; bf:=0;


randomize;

SetLength(vds,len);
for i := 0 to len-1 do
begin
    vds[i]:=1 + Random(100);
end;


while l < r do
begin
     for i := l to r-1 do
     begin
        if vds[i] > vds[i+1] then
        begin
         bf := vds[i];
         vds[i] := vds[i+1];
         vds[i+1] := bf;
        end;
     end;

     dec(r);

     for i := r downto l+1 do
     begin
        if vds[i] < vds[i-1] then
        begin
         bf := vds[i];
         vds[i] := vds[i-1];
         vds[i-1] := bf;
        end;
     end;

     inc(l);

end;


for i := 0 to len-2 do
begin
       if vds[i+1] >= vds[i] then
       begin
         s:=s+vds[i];
         inc(c);
        end;
end;
s:=s+vds[len-1]; inc(c);

SortShake:=c;
end;



procedure _Sort(var VE: TArrayE);
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












procedure DetM(A: TArray2; var D: Extended);
label endxch, endp;
var
 D1,Z,T,x: Extended;
 Hi,k,i,n,m,L: Integer;
begin
Hi:=High(A);


 D1:=1;
 Z:=1;

 for k:=0 to Hi do
 begin


  if A[k,k] = 0 then
  begin
    //XCHSC2(k,k,A,E);


    E:=0;
    // i <-> j //i=k; j=k
    for n:=k to Hi do
    begin
      if A[n,k] <> 0 then
      begin
        for m:=0 to Hi do
        begin
          x:=A[k,m]; A[k,m]:=A[n,m]; A[n,m]:=x;
        end;
        goto endxch;
      end;
    end;


    for n:=k to Hi do
    begin
      if A[k,n] <> 0 then
      begin
         for m:=0 to Hi do
         begin
           x:=A[m,k]; A[m,k]:=A[m,n]; A[m,n]:=x;
         end;
         goto endxch;
      end;
    end;


    E:=1;
    endxch:

    if E = 1 then goto endp;
    Z:=-Z;

  end;


  T:=1/A[k,k];
  D1:=D1*A[k,k];

  for i:=k to Hi do
  begin
   for j:=k to Hi do
   begin
    if i=k then A[i,j]:=A[i,j]*T else
    if j>k then A[i,j]:=A[i,j]-A[i,k]*A[k,j];
   end;
  end;
 end;

endp:
if E = 1 then D1:=0;
D:=D1*Z;

end;




 {

 DetM():real =

  D1:ext=1; Z:ext=1; k:int=0; i:int=0; j:int=0; m:int=0;   E:int=0; T:ext=0;
  L:int=LenSCM1u;
  Hi:int=L-1;

  for(k=0,Hi,

      ifp(M1u[k*L+k]=0,
          E=0;
          for(n=k, Hi,
             ifp(M1u[n*L+k] <> 0,
                 for(m=0 , Hi ,
                      swap(M1u[k*L+m],M1u[n*L+m]);
                     ); //* for m
                 goto (endxch);
                );
            ); //* for n

          for(n=k , Hi ,
            ifp(M1u[k*L+n] <> 0 ,
                for(m=0 , Hi ,
                     swap(M1u[m*L+k],M1u[m*L+n]);
                   ); //* for m
                goto (endxch);
               );
             );//* for n

          E=1;
          endxch >>
          ifp(E = 1,  goto (endp));
          Z=-Z;

         );

      T=M1u[k*L+k];
      D1=D1*T;
      T=1/T;

      for(i=k , Hi ,
         for(j=k , Hi ,

            ifp(i=k , M1u[i*L+j]=M1u[i*L+j]*T ,
                    ifp(j>k,  M1u[i*L+j]=M1u[i*L+j]-M1u[i*L+k]*M1u[k*L+j]);
                );
            ); //* for j
         ); //* for i

     ); //* for k


    endp>>
    ifp(E = 1 , D1=0);
    D=D1*Z;
    D

 }





procedure DetM1(var D: Extended);
label endxch, endp;
var
 D1,Z,T,x: Extended;
 Hi,k,i,n,m,L,E: Integer;
begin
//L:=Trunc(sqrt(Length(A)));
//Hi:=Trunc(sqrt(High(A)));
L:=LenSCM1u;
Hi:=L-1;
// A2[j,k] -> A1[(j-1)*L+k] -> A1[j*L+k]

 D1:=1;
 Z:=1;

 for k:=0 to Hi do
 begin


  if M1u[k*L+k] = 0 then
  begin
   //XCHSC2(k,k,A,E);

     E:=0;
     // i <-> j //i=k; j=k
     for n:=k to Hi do
     begin
       if M1u[n*L+k] <> 0 then
       begin
         for m:=0 to Hi do
         begin
           x:=M1u[k*L+m]; M1u[k*L+m]:=M1u[n*L+m]; M1u[n*L+m]:=x;
         end;
         goto endxch;
       end;
     end;


     for n:=k to Hi do
     begin
       if M1u[k*L+n] <> 0 then
       begin
          for m:=0 to Hi do
          begin
            x:=M1u[m*L+k]; M1u[m*L+k]:=M1u[m*L+n]; M1u[m*L+n]:=x;
          end;
          goto endxch;
       end;
     end;


     E:=1;


     endxch:
     if E = 1 then goto endp;
     Z:=-Z;
  end;


  T:=M1u[k*L+k];
  D1:=D1*T;
  T:=1/T;

  for i:=k to Hi do
  begin
   for j:=k to Hi do
   begin
    if i=k then M1u[i*L+j]:=M1u[i*L+j]*T else
    if j>k then M1u[i*L+j]:=M1u[i*L+j]-M1u[i*L+k]*M1u[k*L+j];
   end;
  end;

 end;

endp:
if E = 1 then D1:=0;
D:=D1*Z;

end;






 {

 DetMulMxM1():real =

  D1:ext=1; Z:ext=1; k:int=0; i:int=0; j:int=0; m:int=0;   E:int=0;
  T:ext=0;  S:ext=0;

  L:int=LenSCM1u;
  Hi:int=L-1;


  for(i=0 , Hi ,
     for(j=0, Hi ,
         S=0;
         for(m=0 , Hi ,
             S=S+M1ux[i*L+m]*M1uy[m*L+j];
            );
         M1u[i*L+j]=S;
        );
     );



  D1=1; Z=1; E=0;

  for(k=0,Hi,

      ifp(M1u[k*L+k]=0,
          E=0;
          for(n=k, Hi,
             ifp(M1u[n*L+k] <> 0,
                 for(m=0 , Hi ,
                      swap(M1u[k*L+m],M1u[n*L+m]);
                     ); //* for m
                 goto (endxch);
                );
            ); //* for n

          for(n=k , Hi ,
            ifp(M1u[k*L+n] <> 0 ,
                for(m=0 , Hi ,
                     swap(M1u[m*L+k],M1u[m*L+n]);
                   ); //* for m
                goto (endxch);
               );
             );//* for n

          E=1;
          endxch >>
          ifp(E = 1,  goto (endp));
          Z=-Z;

         );

      T=M1u[k*L+k];
      D1=D1*T;
      T=1/T;

      for(i=k , Hi ,
         for(j=k , Hi ,

            ifp(i=k , M1u[i*L+j]=M1u[i*L+j]*T ,
                    ifp(j>k,  M1u[i*L+j]=M1u[i*L+j]-M1u[i*L+k]*M1u[k*L+j]);
                );
            ); //* for j
         ); //* for i

     ); //* for k


    endp>>
    ifp(E = 1 , D1=0);
    D=D1*Z;
    D

 }





 {

 DetMulMxM1PE():real =

  D1:ext=1; Z:ext=1; k:int=0; i:int=0; j:int=0; m:int=0;   E:int=0;
  T:ext=0;  S:ext=0; sw:Ext=0;

  L:int=LenSCM1u;
  Hi:int=L-1;


  for(i=0 , Hi ,
     for(j=0, Hi ,
         S=0;
         for(m=0 , Hi ,
             S=S+PExtended(Ptr0M1ux+ExtCS*i*L+ExtCS*m)*PExtended(Ptr0M1uy+ExtCS*m*L+ExtCS*j);
            );
         PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)=S;
        );
     );



  D1=1; Z=1; E=0;

  for(k=0,Hi,

      ifp(PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*k)=0 ,
          E=0;
          for(n=k, Hi,
             ifp(PExtended(Ptr0M1u+ExtCS*n*L+ExtCS*k)<>0,
                 for(m=0 , Hi ,
                      sw=PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*m);
                      PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*m)=PExtended(Ptr0M1u+ExtCS*n*L+ExtCS*m);
                      PExtended(Ptr0M1u+ExtCS*n*L+ExtCS*m)=sw;
                     );
                 goto (endxch);
                );
            );

          for(n=k , Hi ,
            ifp(PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*n) <> 0 ,
                for(m=0 , Hi ,
                      sw=PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*k);
                      PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*k)=PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*n);
                      PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*n)=sw;
                   );
                goto (endxch);
               );
             );

          E=1;
          endxch >>
          ifp(E = 1,  goto (endp));
          Z=-Z;

         );

      T=PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*k);
      D1=D1*T;
      T=1/T;

      for(i=k , Hi ,
         for(j=k , Hi ,
            ifp(i=k , PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j) = PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)*T,
                      ifp(j>k,
                           PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)=PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)-PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*k)*PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*j)
                         );
                );
            );
         );

     );


    endp>>
    ifp(E = 1 , D1=0);
    D=D1*Z;
    D

 }




procedure DetMulMxM1(var D: Extended);
label endxch, endp;
var
 D1,Z,T,x,S: Extended;
 Hi,k,i,n,m,L,E: Integer;
begin
//L:=Trunc(sqrt(Length(A)));
//Hi:=Trunc(sqrt(High(A)));
L:=LenSCM1u;
Hi:=L-1;


//M1u = M1ux*M1uy
//det(M1u)

// A2[j,k]  -> A1[j*L+k]

for i:=0 to Hi do
begin
  for j:=0 to Hi do
  begin
   S:=0;
   for m:=0 to Hi do
   begin
    //S:=S+A[i,m]*B[m,j];
    S:=S+M1ux[i*L+m]*M1uy[m*L+j];
   end;
   //C[i,j]:=S;
   M1u[i*L+j]:=S;
  end;
end;




 D1:=1;
 Z:=1;
 E:=0;

 for k:=0 to Hi do
 begin


  if M1u[k*L+k] = 0 then
  begin
   //XCHSC2(k,k,A,E);

     E:=0;
     // i <-> j //i=k; j=k
     for n:=k to Hi do
     begin
       if M1u[n*L+k] <> 0 then
       begin
         for m:=0 to Hi do
         begin
           x:=M1u[k*L+m]; M1u[k*L+m]:=M1u[n*L+m]; M1u[n*L+m]:=x;
         end;
         goto endxch;
       end;
     end;


     for n:=k to Hi do
     begin
       if M1u[k*L+n] <> 0 then
       begin
          for m:=0 to Hi do
          begin
            x:=M1u[m*L+k]; M1u[m*L+k]:=M1u[m*L+n]; M1u[m*L+n]:=x;
          end;
          goto endxch;
       end;
     end;


     E:=1;


     endxch:
     if E = 1 then goto endp;
     Z:=-Z;
  end;


  T:=M1u[k*L+k];
  D1:=D1*T;
  T:=1/T;

  for i:=k to Hi do
  begin
   for j:=k to Hi do
   begin
    if i=k then M1u[i*L+j]:=M1u[i*L+j]*T else
    if j>k then M1u[i*L+j]:=M1u[i*L+j]-M1u[i*L+k]*M1u[k*L+j];
   end;
  end;

 end;

endp:
if E = 1 then D1:=0;
D:=D1*Z;

end;



//setmaskfpu(); sqrt(-x);
function _IsNan:Extended; assembler;
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


 {
function Tst5: extended;
var

begin
Hi:=High(vd);

  for n := 0 to Hi do
  begin
     for k := 0 to n do
     begin
        for j := k to Hi do
        begin

        end;
        if True then


     end;
  end;

end;
  }




procedure TForm1.B_CalcClick(Sender: TObject);
label endp,endc,resout;
const fcw: word = $1f32;
const LA = 10;
//const fw2: word = $1332;
var
S,S1,S2,S3,S4,S5,S6,S7: String;
Expr,Expr1: TStringType;
ic,ic1,icn,Error: Cardinal;
T1,T2,SB,adr,gt,gt1,gt2: Cardinal;
NS: Cardinal;
r1,r2,zx,zy,resd: double;
er1,ex1,ex2,ex7: extended;

FZ1,FZ2,FZ3,FZ4,PtrZ1,PtrZ2: Pointer;
FS1,FS2,FS3,FS4,FS5,FS6,FS7: Pointer;
ptrVD1,ptrVD2,ptrVE1,ptrVE2: Pointer;
ptrVS1,ptrVS2,ptrVI1,ptrVI2: Pointer;
ptrVI,ptrVD,ptrVE,ptrVS: Pointer;

zr1,zr2,zr3,zr4,zr5: TComplexD;
st: array of extended;
ze1,ze2,ze3,zrese: TComplexE;
zresd,zres: TComplexD;
ptr,P: Pointer;
rt,rt1,ct,len: Cardinal;
NN,n1,n2,n3,n4,n5,ni,Exc,LenV,li,ri: integer;
Ans: AnsiString;
Str: String;
WS: WideString;
PAC: PAnsiChar;
acf: array of pointer;
acr: array of double;
BRes,BAnsw: Boolean;
M1: Cardinal;
FpuEx: Cardinal;
Erc: Cardinal;
bl: Boolean;
fx,nx,kx,jx,ln2x,lnabsx,argzc,lnzabs,zabs: extended;

y10: TByte10;
xb,zb: Extended;
ar,vse,vde: array of extended;
RootArray: TArrayE;

vsd,vdd: array of double;
vsi,vdi: array of integer;
addrS,addrD: Integer;
Nptr1,Nptr2: Cardinal;
idfP: TidFunc;


ARE: array[0..LA-1] of extended;
bt: byte;
 Attr: TAttrib;//TAttribExt;
 Ptr1,PtrF: Pointer;
 MA2: TArray2;
 MA1: TFloatArray;
 rmax,rmin: extended;



Xmin,Xmax,Eps,epsF,ScanStep,distR:extended;

begin
    // root(sin(ai)+bi,5,1)*x

 CreateM1u;
 RefreshVar;



asm
{}
end;




zrese.re:=0; zrese.im:=0;
zres.re:=0; zres.im:=0;
res:=0;

z1.re:=z1e.re; z1.im:=z1e.im;
z2.re:=z2e.re; z2.im:=z2e.im;
z3.re:=z3e.re; z3.im:=z3e.im;
x:=xe; y:=ye; t:=te;

Exc:=0;




{---------------------------------------- !!!!! WITH  RELOAD OPERATIONS  !!!!!-----------------------------------------------------------------}


{$IFDEF OVERLOADCOMPLEX}
if CB_OM.Checked then NC:=1 else NC:=abs(Trunc(StrToFloat(E_Cnt.Text,G_FMT)));
T1:=GetTickCount;
for ic:=1 to NC do
begin
     rezCx:=z1*z2*(z2-z1+z3)*(z1-z2)-z2*(z3*z2*(z1+z2*(z1+z2-z3))-z3+z1);

//      rezCx:= z1*z2*z3*(z3*z1*(z1*z2-z3*z1)-z1*z2*(z1*z3-z2*z3)+z2*z1*(z2*z1-z3*z2)-(z1+z2)*(z1-z2)*(z3-z2)*(z1*z2-z3*z1*(z1-z2*(z3-z1*(z3-z1)*(z1-z3)*(z3-z2)-z1*z2-z2))))-(z1*z3*z2*(z1*z2-z1*(z2-z2*(z3-z3*(z1-z1*z3*(z1*z2-z3*z1-(z1*z2-z3*z1)*(z1-z2)*(z2-z3)*(z3-z2)-(z1+z3*z2)*(z2-z1*z3)+(z3-z2*z3)*(z2-z3*z1))))))) ;
//      rezCx:= -z1/(z1/z2-z3/(z1+z3)+z1*z2*(z1*z2-z2*z3+z1/(z1/(z1+z2)+z2/(z3+z1))))*(z2*(z1-z2/(z1*z2-z2/(z1*z2+z2*z3)*(z2*z3-z1*z2)))+z1-z2*(z1-z3-z3/(z1-z2)*(z2/(z2-z3*(z1+z2*z3)*(z2-z1*z3)/(z1*z3-z2*(z1+z3))))))*(z1*z2-z3*z2-z3*(z1*z3-z2*(z3-z1)/(z1*z2*z3-z1-z2-z3)));
//      rezCx:= z1*z2*(2.111*z1+1)*(2.211*z1*z2/z3-2.311*z1*(3.422*z3-1)/(2.511*z1-3.611*z2-4.22)*(z1/(3.711*z1-1)-4.111/z1+5.111*(2.611*z1*z2*z3-1.23)/(z2+1.12)-7.132*(2.812*z1*(z2+1.123)*(3.832*z2+2.121)*(3.112/(z1+1.123)-2.133*z3))));
//      rezCx:= z1*z2*(z1-z3*(2.123*z1-3.222*z2-5.323)/(z3*z1*z2/(2.234-z1*z2)+(2.455*z1+3.632)*(3.734*z2-4.832*z3-5.923)-(1.134-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.745*z1-3.345*z2-z3))-z2*(z1*z2-z2*z3*3.167+2.965*(z1/z3-z3/(z1-z2*(2.467-z1-z2-z3)))*(z2-z3)-2.376*z1)*(z2-z1)-7.154/z1)*(-1.943/z3+z1*z2*z3*5.334))-3.556*z1-5.657)-7.243*z2-3.459)/(z1-z3)+z1*(z3*z2/(z1-2.834*z3)-z2*(z1*(z3-2.756*z2-z1-5.676))));
//      rezCx:= (z1*z2+z3*(z1*z2-z2*z3*z1-z1+z2-z3))*(z1+z2+z3)*(z1-z2-z3)*(z3-z1*(z3-z2*(z1-z2-z3)))*z1*z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)*(z2*z1+z3*z1+z3*z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2*(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3)-z3*(-z1-z2*(-z3*(-z1*(z2-z3))))))))))));
//      rezCx:= z1*z2-z1/(z1/z2-z3/z2-(-z1-z2*(z1*z2-z3*z1/(z1/z2-z3/z2-(-z1-(-z2-(-z3-(z1*z2-z2*(-z1*z2-z2/(z1+z2*z3)))*z1)*z2)/(z1+z2*z3)-z1*(z2/z3-(-z2*z1/(z1-z2*z3)-(-z1-(-z2/(-z1*z2*(-z1-z2))+z1/z2*(z2*z1+z2*z3-z1/(z1+z2*z3))-z1*z2*(z1*z2+(-z1*z2-z3/z2+z1-z2*z1)))))+z1*z2*z3*(z1+z2*z3)))))));
//      rezCx:= z1*z2*(z1-z3*(2.154*z1-3.253*z2-5.353)/(z3*z1*z2/(2.544-z1*z2)+(2.143*z1+3.556)*(3.343*z2-4.153*z3-5.456)-(1.153-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.644*z1-3.364*z2-z3))-z2*(z1*z2-z2*z3*3.164+2.267*(z1/z3-z3/(z1-z2*(2.533-z1-z2-z3)))*(z2-z3)-2.453*z1)*(z2-z1)-7.535/z1)*(-1.253/z3+z1*z2*z3*5.353))-3.433*z1-5.455)-7.466*z2-3.577)/(z1-z3)+z1*(z3*z2/(z1-2.699*z3)-z2*(z1*(z3-2.767*z2-z1-5.854)-z2*(-1.549-z1/(-z3-z2))/(z1/z2-z1/(z3/z1-z2/z3)+z3*(1/z1-5.344/z2-z1*z2*(2.435*z1-1.456)*(z3*z2*3.326-5.347)*(1.943-z1*z2*z3*3.245)*(z1+z2))))));
//      rezCx:= (z1*z2+z3*(z1*z2-z2*z3*z1-z1+z2-z3))*(z1+z2+z3)*(z1-z2-z3)*(z3-z1*(z3-z2*(z1-z2-z3)))*z1*z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)*(z2*z1+z3*z1+z3*z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2*(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3*(z1-z2*(z3-z1*z2-z2*(z1*z2-z3*z1)-z3*(z3*z1+z2))))-z3*(-z1-z2*(-z3*(-z1*(z2-z3*(z1*z2*z3-z2*z1*z3*(-z1*(z2*z1-z3*z2-z1-z2-z3)))))))))))))));
//      rezCx:= (z1*z2+z3/(z1*z2-z2*z3/z1-z1+z2-z3))*(z1+z2+z3)/(z1-z2-z3)*(z3-z1*(z3-z2/(z1-z2-z3)))*z1/z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)/(z2*z1+z3*z1+z3/z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2/(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3/(z1-z2*(z3-z1*z2-z2/(z1*z2-z3*z1)-z3/(z3/z1+z2))))-z3*(-z1-z2*(-z3/(-z1*(z2-z3*(z1*z2/z3-z2*z1*z3/(-z1*(z2*z1-z3*z2-z1-z2-z3)))))))))))))));
//      rezCx:= z1*z2*(z1-z3*(2.156*z1-3.652*z2-5.653)/(z3*z1*z2/(2.664-z1*z2)+(2.155*z1+3.543)*(3.345*z2-4.431*z3-5.443)-(1.451-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.453*z1-3.353*z2-z3))-z2*(z1*z2-z2*z3*3.153+2.253*(z1/z3-z3/(z1-z2*(2.533-z1-z2-z3)))*(z2-z3)-2.453*z1)*(z2-z1)-7.553/z1)*(-1.253/z3+z1*z2*z3*5.533))-3.453*z1-5.453)-7.453*z2-3.553)/(z1-z3)+z1*(z3*z2/(z1-2.653*z3)-z2*(z1*(z3-2.753*z2-z1-5.853)-z2*(-1.539-z1/(-z3-z2))/(z1/z2-z1/(z3/z1-z2/z3)+z3*(1/z1-5.553/z2-z1*z2*(2.535*z1-1.53)*(z3*z2*3.536-5.753)*(1.539-z1*z2*z3*3.665)*(z1+z2*(z3-(-z1-z2*z3/(z1*z2-2.863*(z1*z2*(z1-z2*(z1*z3+z2/z3*(2.623*z1-1.352-z3*z2))))))))))))) ;
//      rezCx:= z1*z2*(2.251*z1+1)*(2.243*z1*z2/z3-2.353*z1*(3.475*z3-1)/(2.575*z1-3.675*z2-4.766)*(z1/(3.767*z1-1)-4.176/z1+5.186*(2.866*z1*z2*z3-1.766)/(z2+1.876)-7.165*(2.874*z1*(z2+1.641)*(3.864*z2+2.162)*(3.171/(z1+1.765)-2.173*z3/(2.174*z1*z2*z3-1.171)+(4.171*z1-1.164)*(5.172*z2-7.174)/(z1-2.175*z2-1.747-2.174*z3/(3.618-7.716*z1-8.181*z2*(4.612*z1/(2.189*z3+1.165)-7.198*z1-8.149/z3+9.912*(2.199*z1-1.261)*(3.107*z1+4.179*z2+5.108)*(2.271*z1*z2*z3-7.179)*z1*z2*z3/(z1-z2*2.282-3.621/(z1/(z3-1.147)-7.198/(z2+2.245)+8.233/(2.288*z1*z2*z3+1.247)-9.174)))))/(z1-1.525)))));


  //rezCX:=x*(z1*z2+z1/z2/(z1*z2-z2/z1))-(z1*z2*(z1/z2-z2/z1+z1*z2*(z1-z2)))*y;
  //rezCx:=z1*(x*y+x*y*(x/y-y/x+x/(x*y/(x+y))))+(x*y-x/(x*y-y/x)*(x*y*(x*y+y/x)))*z2;
 //rezCx:=z1*z2*(2.251*z1+1)*(2.243*z1*z2/z3-2.353*z1*(3.475*z3-1)/(2.575*z1-3.675*z2-4.766)*(z1/(3.767*z1-1)-4.176/z1+5.186*(2.866*z1*z2*z3-1.766)/(z2+1.876)-7.165*(2.874*z1*(z2+1.641)*(3.864*z2+2.162)*(3.171/(z1+1.765)-2.173*z3/(2.174*z1*z2*z3-1.171)+(4.171*z1-1.164)*(5.172*z2-7.174)/(z1-2.175*z2-1.747-2.174*z3/(3.618-7.716*z1-8.181*z2*(4.612*z1/(2.189*z3+1.165)-7.198*z1-8.149/z3+9.912*(2.199*z1-1.261)*(3.107*z1+4.179*z2+5.108)*(2.271*z1*z2*z3-7.179)*z1*z2*z3/(z1-z2*2.282-3.621/(z1/(z3-1.147)-7.198/(z2+2.245)+8.233/(2.288*z1*z2*z3+1.247)-9.174)))))/(z1-1.525)))));
 //rezCx:=z1*z2*(-z1/x-z2/(-2.135/z2-5.123/(x/z1-z2/y))/x/z2)/(z1*x-y*z2-x*(x+z2+y-(-(-z1-x/(-z2)-(-y)/(z1/(z1-z2/(x-y))))))*z1);
  //rezCx:=z1*x*(z1/y-z2/(x*z2-x-z2*(-x/z1-t/z2-(z1/x-z2/z1))*y)/z1/x)/(2.345/z1-5.865*z2-3.246*(-z1-3.986/z2-z1/5.942)+(x-y*(x-z1*3.976)/(z1-z2)-(z2-x*5.943)*(x/(2.868-z1)*(z2+8.645)))*2.952)
  //rezCx:=z1*z2*(z1-t*(2.156*z1-3.652*z2-5.653)/(t*z1*z2/(2.664-z1*z2)+(2.155*z1+3.543)*(3.345*z2-4.431*t-5.443)-(1.451-z1)/(-t-z2))+z1*(z2-(-z1-(-z2/(-t*z1*(z1*z2*t*(2.453*z1-3.353*z2-t))-z2*(z1*z2-z2*t*3.153+2.253*(z1/t-t/(z1-z2*(2.533-z1-z2-t)))*(z2-t)-2.453*z1)*(z2-z1)-7.553/z1)*(-1.253/t+z1*z2*t*5.533))-3.453*z1-5.453)-7.453*z2-3.553)/(z1-t)+z1*(t*z2/(z1-2.653*t)-z2*(z1*(t-2.753*z2-z1-5.853)-z2*(-1.539-z1/(-t-z2))/(z1/z2-z1/(t/z1-z2/t)+t*(1/z1-5.553/z2-z1*z2*(2.535*z1-1.53)*(t*z2*3.536-5.753)*(1.539-z1*z2*t*3.665)*(z1+z2*(t-(-z1-z2*t/(z1*z2-2.863*(z1*z2*(z1-z2*(z1*t+z2/t*(2.623*z1-1.352-t*z2)))))))))))))

  //rezCx:=(x/k-k/y)/(x*i-i*k-y/i)*(k/i-i/k-k/2.257-k/(4.763/k-7.543/i)+i/(x-k)*(y+k*2.765)*(2.57*i-2.13)/(-5.322-3.567*i))*(k*x-y*k-y/k-k/x-i/k-k/i-2.15/k-k/3.234)/(-(i-k)-k/(x/y-i)+(i/x-y/i)/k+k*(x*y-i/(x-y/i))-(i*(-x-y*i/k))*k)
  //rezCx:=(z1.re*k-z2.im/k)*(k/z2.re-k*z1.im)*(-i*(-z1/k-k/z2-x*z1.re*(z1.re/(i/x-z1/i)-(i/z2-k*i*x/z1*z2.im/(2.135-z1)*(z2-3.537*i))/z2.re)/z2.im))/((x/y-y/x)/z1-z2/(x*k-y/k));
  //rezCx:=-z1/(z2-(x*y*(x*y-t*y)+x)/(z1*z3*(z1*z2+z3))+(z3*z2*(z3*z1-z2*z1))/(x*y*(t*x+y*t)))*((z1/z2-z3)/z1-z2/(z2/z1+z3)+x/(z1/z3+z2)-(z2/z1-z3)/y)/((x*y*(x*y+t))/z1-z2/(x*t*(t*y+t))-z1*(t*y*(y*t-t))+(-t*x*(y*t-x))*z1)
  //rezCx:=-(-x-k/z1-(z2/k-(k-5.542)*(2.763/x*z2.re/z1.im/i-x/z1/z2/i/k/3.74)))/(z2*x*(-z2-(-i-(-z3-i*(-i/(-z3/(z2-z3/x-t/z1)-i/t+t*(x-y/t)/i)-y*2.752/i+z2*z1/z3)-i*z2+z3*i)-z2*x+t*z3)-y/z1+z2/(i-x))-t*z2*(z1-t*3.86)*(i*k-z3*i/k))
  //rezCx:=z1*z2-z1*(z2-z1*(z2*z1-z1*z2*(z1+z2-z1*(z2-z1)*(z2-z1))));

  //rezCx:=Re(z1.re/z2.im-x*i)*Im(z1*x-y/z2.re*i-i)+Im(z1-z2*(x-z1-y/(z2.re+i*z1.im)))*i ;
    //rezCx:=  z1*z2-z3*(z1-z2-z1*(z2+z3-z1));
    //rezCx:=x+i0;
  //rezCx:=Re(z1)*Im(z2)+i;
  //rezCx:=z1*z2;

  //rezCx:=(z1.re/x*(z1.im*(z2.re-i*x-i/(z2.im*i-x/y*(i-i/y-x/i-z1*(i/z1-z2/i)))))/z2.im)*(2.1*i-3.2/i-z1-(-z2-i*(i/(z1.re/i-i/z2.im)-(x/(z1-z2.re)+(z1.re*i-z2.im*x/z2))/i)/(z1-i*z2)))
   //rezCX:=-(-(-(-(-(-z1-(-z2-(x-(-2.5-z1-(-(-(-x-z1-(-3.2-i)-i-(-i-4.5))))-i*(-z1-3.7*i-y/i))))-9.5-(-3.5-z2/i)))-i-(-z1/(-i)-(-z2/(-x))))));
  //rezCx:=(z1*x*z2.im/i*(z1*(z1.re-x)-(-z2.im-y)*z2)*(x*(z1-z2/x)-(z1/x-y/z2)*y))/(-(x-z1.re/z2.im)/z2-z1/(z2.im*y-x/z1.re))*(-z1*(-i*x+y)+(x/i-i/y)*z2)/((z1+y*z2)/(z1-z2*x)-(x-z2)/(z1-x));
 //rezCx:=((z1-x)*(y-z2)-(x+z2)*(z1+y))/((x/z1-z2/y)+(z2/x-y/z1))*((i-z1)*x-y*(z2-i)+z1*(i-x)+(y-i)*z2)/((5.1-i)*(i-3.2)*(2.7+i)*(i+7.5)-(2.3-z1)/(z2-5.7)+(2.5*i-x)/(y-i*3.7))*((i*x+z1)/(i*z1+z2)+(y*i-z2*i)/x+y/(z1/i-x/i+i/(y+x)+i/(z1+z2*x)));

  //rezCx:=sp1(z1*sp2(z2,z1/sp1(z2/x-y/z2)))/sp3(z1-x,sp2(-sp2(-x/i,i/y),-7.5-i/sp3(-z1,-z2/z1,z2*i)),sp1(x*z1-i)/x)
  //rezCx:=sp3(z1,z2,z3*sp3(z1-x,y-z3,z2-z1*z2))*sp2(sp1(sp2(sp1(z2),sp1(z1))),sp2(z3,z2))
  //rezCx:=sp3(sp2(z2,sp3(z1,z3,z2)),sp3(z2,sp3(sp3(z3,z2,sp3(z2,z1,z3)),z1,z2),z3),sp1(sp3(z1,sp3(z3,sp3(z2,z3,z1),z1),z3)))

   //rezCx:=z1*sp2(i,x/i-z2*sp3(-x*sp1(z1-i),-3.796-i,x*(-i-z2-5.875))/5.145+sp2(-i-z2,-t-i/z2)/z1)/sp3(z1*sp1(y*i),-sp2(-z1/x,y/(z1/z2-i))/sp3(x*(z1-z2/i),-z3/z1,x/(-z3)),sp2(2.841-t*i,-z2/(-z3-i/(-x-z1)))*sp3(z1*sp1(t/i),x/i-i/y,2.5*z1-7.5/z2)/sp2(z2/x-y*z3/z2,-4.784/i-i/3.752))

   //rezCx:=(z1/x-y/z2)*((2.123*z1-z2*y+t)/(3.235/z3-y*z3-y)-y*(3.532*z1*t-t/z2-z3/(x-z2-t-z1*2.751)-(x*y-t)/(z3*z2-z1/z3)+x*z3*y*z2)*z3)+(2.467*(x*z1-z3/y-5.642)-3.178*x/(2.921*t-5.742/z2)+z1*t*(-z2/t-2.751*z3*(-3.854*x*(z1/(x+y-t)-(3.672*z1-6.728*z2+7.631/z3)/(y*z1-t*z3+y/z1)))));
   //rezCx:=z1*z2-z1*(z2-z1*(z2*z1-z1*z2*(z1+z2-z1*(z2-z1)*(z2-z1))));
  //rezCx:=sp6(vd,z1/sp6(vd,z1,ve,n+j, z2-z1-z2/sp6(vd,-z1,ve,n+m, -z2, k+j), j),ve,n, i*sp6(vd,z1/z2,ve,n+m, z2/z3, 2*j+3), j*5-3)
  //rezCx:=(m+j+k)*z1;   !!!
  //rezCx:=(1.5*i-2.7)*(-3.2-i*(2.7-x-(-z2-i-(-z1.re-3.5-(-x/(z1-z2*i)-i/(x-z2.im-2.3*i)))))/(-i/x*z1-z2*y/i));
  //rezCx:=((i*x/z1-z2/x/i*t)*i/(z2-z1/i-i/(x*y*(x-y/(t/x-y/t)))-(i*z1-z2*i-z3*(x*i-z3/(i*t-2.5*i-i/x)))*i)+(-i-3.1/i)/(i/(x-z2)+(z1/(t/z1/x/i-x/i/z3)/i)/(z1-z2/(1.5*i*x-t/i)))+z1*(t-z3/x*i-2.3*i*z2*y*(-x/(y/(-i-z2/x)-z3/(-t/i-z1/i*x))-i/(2.3*x-2.5/i-z2*x)))*(-2.1-i/(-x/(1.7-i*2.3))))/(z1/(x-i/(z1-z2/i-i/3.5))+x*(z3-x/i)*(y/z1-i/z2/x)-z1*(i/(x/i-i/x)-(i/z2-z3/i)/i)*(-i-y/(-z1/(z2-x))));
  //rezCx:=((z3/(x*z2-z3/x+2.5)-2.1*z2*z1/(1.5-z1-z2/t)+(-z1-2.3/z3+1.7/(x/z2-z3*z1))/(y-z3*z1*2.7)*(2.1*z1-y*1.9-2.5/z3-1.1))/((-z2/x)/z2-t/(z1*1.1/z2*(z3-x)-x/(-z3))-2.7/(-2.1-(-z1-t/z2))+z1*1.2*y/(z2-1.5)*z3*(-1.1/z1-z2)/(z1-z2))-(-z1*(-z1/(1.1/z3-z1/(-z2-3.1/(-z1))))*z2/(y-t*z1)-(x*z2/(-z1-y/(z3-1.2/(-z1*1.5))))*z3*(-z2-z3/x)+z2/(2.1/(-z1)-1.5/(-z1))*5.5-z1*y*(z3/(-z1)+z1*(y-z3/x)))/(-z1*y/z3-t/z1*z2*(-1.1*z1/z2*t-2.3/(-z1-(z2/z3-x/z2)/(z1-2.5-y*3.2)))+z3*(z3/(z1-y-2.1)-(x*z3-2.5/z1+3.7)/z2)*z1/(z2*z1-t/(-2.5/z1-3.7*(z1*z2-z3/(-1.5-z2*x))/(2.1*z1-3.2*y-2.5*z3+2.7/z3)))))*(z1*z2-z3*z2/(x-z2/(z1*z3-t*(y-z1*z2/(z2/z3-x)))));


end;
T2:=GetTickCount;

//zrese:=TComplexE(rezCx);
zrese.re:=rezCx.re;  zrese.im:=rezCx.im;
S1:=FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT);
S2:=FloatToStrF(zrese.im,ffGeneral,20,4,G_FMT);
LFR.Caption:=S1+'  '+S2+'i';
if not CB_OM.Checked then
 begin if (T2-T1) <> 0 then LIPF.Caption:=IntToStr(Trunc(NC/(T2-T1))) else LIPF.Caption:='no defined'; end;
goto endp;
{$ENDIF}

{-------------------------------------------------------------------------------------------------------------------------------}


ct:=G_ResCalcType;

                                    //  EF.Text:='111';

 T1:=GetTickCount;
   {$IFDEF PANSICHAR}
       ans:=AnsiString(EF.Text); Expr:=PAnsiChar(ans);
    {$ELSE}
       Expr:=TStringType(EF.Text);
    {$ENDIF}
     flCompile(Expr,0,FZ1);
    //flCompileATE(Expr,0,FZ1,rt,Error);
 T2:=GetTickCount;

 LExprLen.Caption:=IntToStr(Length(EF.Text));


 LCTF.Caption:=IntToStr(T2-T1);
 if CB_OM.Checked then NC:=1 else NC:=abs(Trunc(StrToFloat(E_Cnt.Text,G_FMT)));
 flGetErrorCode(Error);

//goto endp;
//x:=2.123;
//x:=10;


 if  Error = 0 then
 begin

   if F_NoCalc = True  then begin flPerform(fl_FREE,Cardinal(FZ1)); goto endp; end;

   flGet(fl_RESULT_TYPE,0,rt);

   FPUError:=0;




   if (rt = fl_None)    then
   begin

       if F_SafeCalc = True then
       begin
         // flMaskFPUException; //flPerform(fl_MASK_FPU_EXCEPTION,0);
          NC:=10; T1:=0; T2:=0;
          for ic := 1 to NC do
          begin
            // flResultMaskedFPU(FZ1); if FPUError <> 0 then goto endc;
            Exc:=flResultSafe(FZ1);
            if Exc <> 0 then goto endc;
          end;
       end
       else
       begin

         T1:=GetTickCount;
         for ic:=1 to NC do
         begin
           asm
              call FZ1
           end;
         end;
         T2:=GetTickCount;
    end;

     zrese.re:=resf.re;
     zrese.im:=resf.im;
   end


   else
   begin
      if ((rt = fl_Real) and (ct = fl_Stay_As_Is)) or ((rt = fl_Complex) and (ct = fl_Real)) or  ((rt = fl_Real) and (ct = fl_Real)) then
      begin
       if F_SafeCalc = True then
       begin
        //  flMaskFPUException; //flPerform(fl_MASK_FPU_EXCEPTION,0);
          NC:=10; T1:=0; T2:=0;
          for ic := 1 to NC do
          begin
           //  flResultMaskedFpuE(FZ1,zrese.re); if FPUError <> 0 then goto endc;
             Exc:=flResultSafeE(FZ1,zrese.re);
             if Exc <> 0 then goto endc;
          end;
       end
       else
       begin

           T1:=GetTickCount;
           for ic:=1 to NC do
           begin


           {$IFDEF SAVEREG}
              asm
                mov dbEAX1,eax
                mov dbEBX1,ebx
                mov dbECX1,ecx
                mov dbEDX1,edx
                mov dbESI1,esi
                mov dbEDI1,edi
                mov dbESP1,esp
                mov dbEBP1,ebp
              end;
           {$ENDIF}

         

              asm

                 call FZ1
                 fstp zrese.re

              end;

             {$IFDEF SAVEREG}
             asm
                mov dbEAX2,eax
                mov dbEBX2,ebx
                mov dbECX2,ecx
                mov dbEDX2,edx
                mov dbESI2,esi
                mov dbEDI2,edi
                mov dbESP2,esp
                mov dbEBP2,ebp
             end;

             if dbEAX1 <> dbEAX2 then showmessage('EAX');
             if dbEBX1 <> dbEBX2 then showmessage('EBX');
             if dbECX1 <> dbECX2 then showmessage('ECX');
             if dbEDX1 <> dbEDX2 then showmessage('EDX');
             if dbESI1 <> dbESI2 then showmessage('ESI');
             if dbEDI1 <> dbEDI2 then showmessage('EDI');
             if dbESP1 <> dbESP2 then showmessage('ESP');
             if dbEBP1 <> dbEBP2 then showmessage('EBP');
          {$ENDIF}



           end;

           T2:=GetTickCount;
       end

    end
    else       //ct = fl_Complex; rt = fl_Real,fl_Complex
    begin

       if F_SafeCalc = True then
       begin
         // flMaskFPUException; //flPerform(fl_MASK_FPU_EXCEPTION,0);
          NC:=10; T1:=0; T2:=0;
          for ic := 1 to NC do
          begin
          // flResultMaskedFpuCxEP(FZ1,@zrese); if FPUError <> 0 then goto endc;
            Exc:=flResultSafeCxEP(FZ1,@zrese);
            if Exc <> 0 then goto endc;
          end;
       end
       else
       begin

           T1:=GetTickCount;

           for ic:=1 to NC do
           begin



           {$IFDEF SAVEREG}
              asm
                mov dbEAX1,eax
                mov dbEBX1,ebx
                mov dbECX1,ecx
                mov dbEDX1,edx
                mov dbESI1,esi
                mov dbEDI1,edi
                mov dbESP1,esp
                mov dbEBP1,ebp
              end;
           {$ENDIF}

         //   (-1)^z1 = exp(-pi*z1.im)*cossin(pi*z1.re)
    
            asm

              call FZ1
              fstp zrese.re
              fstp zrese.im

            end;


          {$IFDEF SAVEREG}
             asm
                mov dbEAX2,eax
                mov dbEBX2,ebx
                mov dbECX2,ecx
                mov dbEDX2,edx
                mov dbESI2,esi
                mov dbEDI2,edi
                mov dbESP2,esp
                mov dbEBP2,ebp
             end;

             if dbEAX1 <> dbEAX2 then showmessage('EAX');
             if dbEBX1 <> dbEBX2 then showmessage('EBX');
             if dbECX1 <> dbECX2 then showmessage('ECX');
             if dbEDX1 <> dbEDX2 then showmessage('EDX');
             if dbESI1 <> dbESI2 then showmessage('ESI');
             if dbEDI1 <> dbEDI2 then showmessage('EDI');
             if dbESP1 <> dbESP2 then showmessage('ESP');
             if dbEBP1 <> dbEBP2 then showmessage('EBP');
          {$ENDIF}


            end;

            T2:=GetTickCount;
       end;




      end;


   end;




  resout:

   S1:=FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT);
   S2:=FloatToStrF(zrese.im,ffGeneral,20,4,G_FMT);
   flGet(fl_Result_Type,0, rt);

   if  (ct = fl_Complex) or ((rt = fl_Complex) and (ct = fl_Stay_As_Is)) or (rt = fl_None) then
      LFR.Caption:=S1+'  '+S2+'i' else  LFR.Caption:=S1;

   G_Res.re:=zrese.re; G_Res.im:=zrese.im;




  if not CB_OM.Checked then
    begin if (T2-T1) <> 0 then LIPF.Caption:=IntToStr(Trunc(NC/(T2-T1))) else LIPF.Caption:='no defined'; end;

  LPFT.Caption:=IntToStr(T2-T1);

  ShowCompilationData(FZ1);


   //LIPF.Caption:=FloatToStr(Trunc(NC/(T2-T1))*Length(vse)*10 / 1024 / 1024);  //Gb/sec
   //LIPF.Caption:=FloatToStr(Trunc(NC/(T2-T1))*Length(vdd)*8 / 1024 / 1024);  //Gb/sec
   //LIPF.Caption:=FloatToStr(Trunc(NC/(T2-T1))*Length(vdi)*4 / 1024 / 1024);  //Gb/sec



 end
 else
 begin
  ShowError;
 end;

endc:
 flPerform(fl_FREE,Cardinal(FZ1));

// flResetMaskFPUException;//flPerform(fl_CLEAR_FPU_EXCEPTION,0);

// if Exc <> 0 then LFR.Caption:=IntToStr(Exc);

 if Exc <> 0 then
 begin
            case Exc of
             fl_ZERO_DIVIDE:              LFR.Caption:='ZERO_DIVIDE';
             fl_INVALID_OPERATION:        LFR.Caption:='INVALID_OPERATION';
             fl_OVERFLOW:                 LFR.Caption:='OVERFLOW';
             fl_ACCESS_VIOLATION:         LFR.Caption:='ACCESS_VIOLATION';
             fl_STACK_OVERFLOW:           LFR.Caption:='STACK_OVERFLOW';
             fl_COMMON_CALCULATON_ERROR:  LFR.Caption:='COMMON_CALCULATON_ERROR';

             fl_YES:                      LFR.Caption:='INVALID_OPERATION';
            end;


 end;

 if FPUError <> 0 then
 begin
     LFR.Caption:='INVALID_OPERATION';
 end;



      {if dbEAX1 <> dbEAX2 then showmessage('EAX');
      if dbEBX1 <> dbEBX2 then showmessage('EBX');
      if dbECX1 <> dbECX2 then showmessage('ECX');
      if dbEDX1 <> dbEDX2 then showmessage('EDX');
      if dbESI1 <> dbESI2 then showmessage('ESI');
      if dbEDI1 <> dbEDI2 then showmessage('EDI');
      if dbESP1 <> dbESP2 then showmessage('ESP');
      if dbEBP1 <> dbEBP2 then showmessage('EBP');  }




endp:
{ S1:=FloatToStrF(zrese.re-ex2,ffGeneral,20,4,G_FMT);
 S2:=FloatToStrF(zrese.im-ex7,ffGeneral,20,4,G_FMT);
 LFR.Caption:=S1+'  '+S2+'i';}

end;




procedure TForm1.ShowCompilationData(FS: Pointer);
var gt,gt1,gt2: cardinal;
begin
  MT1.Clear;

  flGet(fl_EXCHANGE_BRANCH_STACK_DEEP,0,gt);
  MT1.Lines.Add('Deep  FPU stack before XchBranch:         '+IntToStr(gt));

  //L_DSXchBr.Caption:=IntToStr(gt);

  flGet(fl_EXCHANGE_BRANCH_NUM,0,gt);
  MT1.Lines.Add('Number  of exchange of branches:             '+IntToStr(gt));
  //L_NXchBr.Caption:=IntToStr(gt);

  flGet(fl_DINAMIC_LOAD_STACK_DEEP,0,gt);
  MT1.Lines.Add('Deep FPU stack before D.L. optimization:   '+IntToStr(gt));
  //L_DSDinLoad.Caption:=IntToStr(gt);

  flGet(fl_DINAMIC_LOAD_NUM,0,gt);
  MT1.Lines.Add('Number save in mem at DL:                         '+IntToStr(gt));
  // L_NDinLoad.Caption:=IntToStr(gt);


  flGet(fl_COMPILE_OVFL,0,gt);
  if gt = fl_YES then
  begin
    //L_MLS.Caption:='OverFlow'
  MT1.Lines.Add('Deep FPU stack at calculations:   overflow');
  end
  else
  begin
     flGet(fl_COMPILE_STACK_DEEP,0,gt);
  MT1.Lines.Add('Deep FPU stack at calculations:                  '+IntToStr(gt));
     //L_MLS.Caption:=IntToStr(gt);
  end;


  flGet(fl_REPLACE_FUNCTIONS_NUM,0,gt);
  MT1.Lines.Add('Number of replace functions:   :                   '+IntToStr(gt));

  flGet(fl_REPLACE_OPERATIONS_NUM,0,gt);
  MT1.Lines.Add('Number of replace operations   :                  '+IntToStr(gt));


  flGet(fl_CALC_CONST_ARG,0,gt1);
  flGet(fl_CALC_CONST_MUL_DIV,0,gt2);
  MT1.Lines.Add('Calc. const. expressions:                              '+IntToStr(gt1+gt2));


  flGet(fl_CALC_CONST_FUNC,0,gt);
  MT1.Lines.Add('Calc. const. functions:                                  '+IntToStr(gt));


  flGet(fl_NUMBER_REDUCTIONS,0,gt);
  MT1.Lines.Add('Number of reductions functions:                   '+IntToStr(gt));

  flGet(fl_LOAD_STACK_AFTER_CALC,Cardinal(FS),gt);
  MT1.Lines.Add('Load stack after calc(0,1,2)   :                      '+IntToStr(gt));


  MT1.Lines.Add('---------------------------------------------------------------------------');

  flGet(fl_LENGTH_CODE,Cardinal(FS),gt);
  MT1.Lines.Add('Code size in bytes   :                     '+IntToStr(gt));
end;





//((((-((((cos(x/y))^((-j)-1)*((-j))*((-sin(x/y)*(((1/(y)))))))))))/((-power(cos(x/y),(-j)))*(k+j))*root(-power(cos(x/y),(-j)),k+j))-((((((1)*(sin(-power(cos(x/y),j)))-((cos(-power(cos(x/y),j))*((-((((cos(x/y))^(j-1)*(j)*((-sin(x/y)*(((1/(y)))))))))))))*(x))/sqr(sin(-power(cos(x/y),j)))))/((x/sin(-power(cos(x/y),j)))*(-j))*root(x/sin(-power(cos(x/y),j)),-j))))

//((((-power(cos(x/y),(-j)))*(k+j))*root(-power(cos(x/y),(-j)),k+j))-((((((1)*(sin(-power(cos(x/y),j)))-((cos(-power(cos(x/y),j))*((-((((cos(x/y))^(j-1)*(j)*((-sin(x/y)*(((1/(y)))))))))))))*(x))/sqr(sin(-power(cos(x/y),j)))))/((x/sin(-power(cos(x/y),j)))*(-j))*root(x/sin(-power(cos(x/y),j)),-j))))

// (-(((((-((cos(-power(cos(x/y),j))*((-((((cos(x/y))^(j-1)*(j)*((-sin(x/y)*(((1/(y)))))))))))))*(x))/sqr(sin(-power(cos(x/y),j)))))/((x/sin(-power(cos(x/y),j)))*(-j))*root(x/sin(-power(cos(x/y),j)),-j))))


// (-(((((-((cos(-power(cos(x/y),j))*((-((((cos(x/y))^(j-1)*((-sin(x/y)))))))))))/sqr(sin(-power(cos(x/y),j)))))/((x/sin(-power(cos(x/y),j)))*(-j))*root(x/sin(-power(cos(x/y),j)),-j))))
 {
(-(((((-((cos(-power(cos(x/y),j))*((-((((cos(x/y))^(j-1)))))))))/sqr(sin(-power(cos(x/y),j)))))/((x/sin(-power(cos(x/y),j)))*(-j))*root(x/sin(-power(cos(x/y),j)),-j))))

(-(((((-((cos(-power(cos(x/y),j))*((-((((cos(x/y))^(j-1)))))))))))/((x/sin(-power(cos(x/y),j)))*(-j))*root(x/sin(-power(cos(x/y),j)),-j))))

(-(((((-((cos(-power(cos(x/y),j)))))))/((x/sin(-power(cos(x/y),j)))*(-j))*root(x/sin(-power(cos(x/y),j)),-j))))

 ((((cos(-power(cos(x/y),j)))/((x/sin(-power(cos(x/y),j))))*root(x/sin(-power(cos(x/y),j)),-j))))

 ((((cos(-power(cos(x/y),j)))/((sin(-power(cos(x/y),j))))*root(sin(-power(cos(x/y),j)),-j))))

 cos(-power(cos(x/y),j))*power(y,j)*root(sin(-power(cos(x/y),j)),-j)

 cos(-power(cos(x/y),j))*root(sin(-power(cos(x/y),j)),-j)

 cos(-power(cos(x/y),j))*root(sin(-power(cos(x/y),j)),j)

 cos(-cos(x/y))*root(sin(-cos(x/y)),j)

 cos(-x/y)*root(sin(-x/y),j)

 cos(-x/y)*root(sin(-x/y),3)
 }

//comp(vd1,vd2: array extended)= L1:int=len(vd1);L2:int=len(vd2);n1:int=0;s:int=0;if(n1>L1-1,goto(14));n2:int=0;if(n2>L2-1,goto(12));if(vd2[n2]<>vd1[n1],goto(10));s=s+1;n2=n2+1;goto(7);n1=n1+1;goto(5);s;

 //x*y-y*(x*y-x*y*(x*y-(x*y+(x*y-x*(x*y-x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y)))))*y)*y))
 //sp3(sin(x),cos(x)*x,sp3(sin(sp3(cos(x+2),x*sin(x+2),x/sp3(sin(x),cos(x),cos(x+2))-sin(x+2))*sin(2*cos(x+1)+1)),cos(x+1),sp3(cos(sp3(sin(cos(x+1)),2*cos(2*sin(x+1)+1),sin(2*cos(x+1)+1))),x,y)))
 //3*sp3(x+1,y+1,4*sp3(x+1,y+1,t+1)+1)+5*sp3(x+1,6/sp3(x+1,y+1,x*sp3(x+1,y+1,t+1))*x,t+1)-(7*sp3(x+1,y+1,t+1)+2);
 //3*ps3(x+1,y+1,4*ps3(x+1,y+1,t+1)+1)+5*ps3(x+1,6/ps3(x+1,y+1,x*ps3(x+1,y+1,t+1))*x,t+1)-(7*ps3(x+1,y+1,t+1)+2)
 //3*ps3(x+1,y+1,4*ps3(x+1,y+1,t+1)-sp2(5,7)*sp3(1.5,t,x)-5*ps3(x+1,6/ps3(x+1,y+1,x*ps3(x+1,y+1,t+ps2(y*t,-ps3(x-ps2(t,-7.5),-ps2(x,-t*x)-t,x-t))))*x,t+1)-(7*ps3(x+1,y+1,ps2(x,ps3(x,-4.5*t,t)*t))+2.1))
 //3*sp3(x+1,y+1,4*sp3(x+1,y+1,t+1)-sp2(5,7)*sp3(1.5,t,x)-5*sp3(x+1,6/sp3(x+1,y+1,x*sp3(x+1,y+1,t+sp2(y*t,-sp3(x-sp2(t,-7.5),-sp2(x,-t*x)-t,x-t))))*x,t+1)-(7*sp3(x+1,y+1,sp2(x,sp3(x,-4.5*t,t)*t))+2.1))
 //3*sp3(x+1,y+1,4*ps3(x+1,y+1,t+1)-ps2(5,7)*sp3(1.5,t,x)-5*sp3(x+1,6/sp3(x+1,y+1,x*sp3(x+1,y+1,t+sp2(y*t,-sp3(x-sp2(t,-7.5),-ps2(x,-t*x)-t,x-t))))*x,t+1)-(7*sp3(x+1,y+1,sp2(x,ps3(x,-4.5*t,t)*t))+2.1))
 //-sp3(-x,-(-1-y)*x,sp3(-sp2(-x*y,y)*x,-y,-sp2(y-x*3,-x*(x+y)/y)+x)-1)-(-sp2(-sp2(-x,-y),-y*sp3(-2,3*x-y,-x/sp2(x*y,-y)-x/sp2(x,-y)-x)))
 //-ps3(-x,-(-1-y)*x,ps3(-ps2(-x*y,y)*x,-y,-ps2(y-x*3,-x*(x+y)/y)+x)-1)-(-ps2(-ps2(-x,-y),-y*ps3(-2,3*x-y,-x/ps2(x*y,-y)-x/ps2(x,-y)-x)))
 //sp2(z1,z2-sp2(z1+x,i*y-sp2(i*x,z1*x)_-x)-z1_*sp2((x+z1.im)*i,sp2(z1_*z2_,z1_+z2.im)_.im*z1).re)-sp2(z1_,-z2_)*z1-(-sp2(x*z1.re,y*z2.im)-z1)_*z1
 //sp3(z1,z2_,z1.re*z2_.im+x)*sp3(z1,z2,(z1*z2).re)_-sp3(z1-z2*sp3(z1,-sp3(x/y,y/z1_.re,z2.im)*i,-x),z1^2,x^3-(z1_^3).im)^2
 //ps3(z1,z2_,z1.re*z2_.im+x)*ps3(z1,z2,(z1*z2).re)_-ps3(z1-z2*ps3(z1,-ps3(x/y,y/z1_.re,z2.im)*i,-x),z1^2,x^3-(z1_^3).im)^2

 // (x-i/ai-bi/(a-bi-(ci-ai/2.51*(1.3-ci/i+i/(i-2.1*a/ci)))/(-x-5i/(-i-x/(-1.7/i-i/a/bi*ci*d/x-i+ai+bi/d*3.5-x^(-2)*a/i))))-x*(1.5/ci-bi/ci*(i/ai+bi/i)/i-x*ai/(b*ai-i/(b*i/a*ai+b/bi/i))*b)/ci-(-x/i/bi-ci/i/x*a/bi+x*(i+x/(x*ci+i*x-i/(-x/ci-bi/x+a*ci-b/c*i))-3i*b*ci-(-a-ci*d/(b-d-i+ai*i-i*bi/d-2/x^(-3)/i)/(-i/(-a/x-bi/(-x/(-i*a/ci+2.5i-3.7)))))/(-x/ai-i/x+bi*i*ci/di-3i-3.5*a))))/(-x/ai/(-i/(2.5*a-bi+d+bi)*(a+ai)/(bi-c-i/x^(-4))))

 //-1-(-2-(-3+4-(-i)*(i-7-(-i-(-7i-i)))))+i*(-i-3i)*(-2i-i)/(-i/(-1-i))*(1/(-2i-1))
 //-1-(-2-(-3+4-(-i)*(i-7-(-i-(-7i-i)))))+i*(-i-3i)*(-2i-i)/(-i/(-1-i))*(1/(-2i-1))+i/(1-(2-(3+4)))*(-1+(-2)-(-3)+5/(-7))+(-i-(-i)+(-1)*i+i/(-i-i)+1/(2i-(-1)))+(-i)/(-1-i)*(i-5)*(-1-5i)/(-2i+5i+1)*(-2i+3i)+i*(-1-i/(-2*(-i)-(-i)*3))
 //-1-(-2-(-3+4-(-1i)*(1i-7-(-1i-(-7i-1i)))))+1i*(-1i-3i)*(-2i-1i)/(-1i/(-1-1i))*(1/(-2i-1))+1i/(1-(2-(3+4)))*(-1+(-2)-(-3)+5/(-7))+(-1i-(-1i)+(-1)*1i+1i/(-1i-1i)+1/(2i-(-1)))+(-1i)/(-1-1i)*(1i-5)*(-1-5i)/(-2i+5i+1)*(-2i+3i)+1i*(-1-1i/(-2*(-1i)-(-1i)*3))


 //-(-2-(-3-(-(-5*(-7/8*9/(-((-5/8-4))))/(-2*4/9-6/(5/8-7)*(-3-4/(-5/8+6))*4/3)*(-1-(-(-5))/(-6/8-4)*(5*7/3*(-(-5/2*7-1))))))))
 //(2-4i)*(4-7i)*(-4i-5i/(5-8/9)*(3-3i-8i/9*5*(-7-(-(4-5i)))/(-(-5-7i-8/i))*2i))
 // (i/7-7/i)*(-9-(-(i-7*(-2/(5/i-i/(3-4i))))))/(-5i-9/(7-9)*(8i-3i/(-1-(-(-6-8i)))-(5-2*4)/i)-(4-8i-i/(7-2i))/i)*7/i-i/(-i*(-(2i-5/(-i-1)))/(2i-5/(-(i/2-5/i)))*(i-1)/(1-i)*4)
 //re(-i*im(3-5i)/re(3i+8)*(4-5i)-re(2*7/8-9)-im(7i-i/(9-2))*(4i-5/7))-i*im(i-im(3-6/7*8)/i-i/re(3*4-9)+re(8i-i*(4-6/4))/i)

 //ps3(-ps3(z1,z2,t),z1*x,-ps3(x+1,y,-t)*x)*ps3(z1*ps3(z1,z2,z1.re+z2.im),z1_-z2,x*z1.re-z2_.im)+ps3(-z1_*ps3(z1_.re*z2,z1_,-z2_.im),x-ps3(x*z1.re,y-z2.im,x*z1.re-z2_.im)*z1_,x)
 //z1_.im*i-(-(-i/z2_^2-z1_.im*(-i-1)^2))
 //(z1+x)-2
 //sin(z1)-2
 //x+(z1+x+(i+(x+y+3+sin(x))+sin(z1)))
 //sin(x)*cos(x)+sin(x)^(cos(x)^2)
 //res:=logn(x,y);
 //z1+(z2+(z1+(z2+(z1+(z2+(z1+z2))))))
 //z1+(z2+(z1+(z2+(z1+(z1+(z2+(z1+(z2+(z1+(z2+(z1+z2))))))+(z1+z1+(z2+(z1+(z2+(z1+(z2+(z1+z2))))))))))))
 //x+(y+(x+(y+(x+(y+(x+(x+y)))))))
 //sin(x)+(sin(y)+(sin(x)+(sin(y)+(sin(x)+(sin(y)+(sin(x)+(sin(x)+sin(y))))))))
 //-(-(-z1-(z2*z1+1)*x-2*z1)*z2-z1*(-x))-z1*(-z2*x-x*z1)-x*z2-x*(-z1)-2*(-z1*x*z2-(-x*z2))
 //-(-(-z1-(z2+z1+1)+x-2+z1)+z2-z1+(-x))-z1+(-z2+x-x+z1)-x+z2-x+(-z1)-2+(-z1+x+z2-(-x+z2))
 //-z1*(-z2*x-x*z1)-x*z2-x*(-z1)-2*(-z1*x*z2-(-x*z2))
 //z1+(z2+x+x+z1)+x+z2+x+(z1)+2+(z1+x+z2+(x+z2))

 //res:=sp3(sin(x),cos(x)*x,sp3(sin(sp3(cos(x+2),x*sin(x+2),x/sp3(sin(x),cos(x),cos(x+2))-sin(x+2))*sin(2*cos(x+1)+1)),cos(x+1),sp3(cos(sp3(sin(cos(x+1)),2*cos(2*sin(x+1)+1),sin(2*cos(x+1)+1))),x,y)))
 //res:=3*sp3(x+1,y+1,4*sp3(x+1,y+1,t+1)+1)+5*sp3(x+1,6/sp3(x+1,y+1,x*sp3(x+1,y+1,t+1))*x,t+1)-(7*sp3(x+1,y+1,t+1)+2)
 //Res:=sp3(x+1,y+1,sp3(x+1,y+1,t+1))+sp3(x+1,sp3(x+1,y+1,x*sp3(x+1,y+1,t+1))*x,t+1)+sp3(x+1,y+1,t+1)
  //res:=sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
    //res:=sp4(x-(-sp4(x+1,x-sp3(x+1,x*y,x),2,3)-x),y,x*y,t)-sp4(2,x*sp3(x,-y,-t),4,x)
    //sp3(z1,-sp3(z1,z2,x)^2,x+Re(sp3(z1,z2/sp3(z1,z2,y*Im(z1-i*sp3(z1,i,x))),x)))
 //((z1-(z2*z1+1)*x-2*z1)*z2-z1*(x))-z1*(z2*x-x*z1)-x*z2-x*(z1)-2*(z1*x*z2-(x*z2))

//***************FUNCTION*******************************
 //sin(arcsin(z1))
 //cos(arccos(z1))
 //tan(arctan(z1))
 //cotan(arccotan(z1))
 //sinh(arcsinh(z1))
 //cosh(arccosh(z1))
 //tanh(arctanh(z1))
 //cotanh(arccotanh(z1))
 //exp(ln(z1))
 //2^log2(z1)
 //10^log10(z1)
 //z1^log(z1,z2)
 //root(z1,y)^y
 //root(x,y)^y
 //root(z1,y,3)^y
 //root(z1,y,5)^y

 //z1*(-z2*x-x*z1)*x*z2-x*(-z1)
 //z1+(-z2+x-x+z1)+x+z2-x+(-z1)
  //-(-(-z1-(z2*z1+1)/x-1/z1)/z2-z1/(-x))-z1/(-z2*x-x/z1)/x/z2-x*(-z1)-2/(-z1*x*z2-(-x/z2))
  //-(-(-ez1-(ez2*ez1+1)/ex-1/ez1)/ez2-ez1/(-ex))-ez1/(-ez2*ex-ex/ez1)/ex/ez2-ex*(-ez1)-2/(-ez1*ex*ez2-(-ex/ez2))
  //szzr(z1,z2,x)+srrz(re(z1),im(z2),z1)
  //ezzr(z1,z2,x)+errz(re(z1),im(z2),z1)
  //azzr(z1,z2,x)+arrz(re(z1),im(z2),z1)
  //abs(z1)*cos(arg(z1))+i*abs(z1)*sin(arg(z1))
  //z1^log(z1,z2)
 //x/(z1*t-2)+t*z2-t/z1+z2/(x+1)-2*z2*(i+z1-2)
 //z1*z2/z3-z1/(z1-z2+z3)+z2
 //re(z1*z2+i+2)*im(z1/z2-i)
 //(z1+2)*x*i-2.1/(z2+i*x-1.5)+x-z2*sin(x)
 //(z1+2)*x*i-2.1/(z2+i*x-1.5)
 //7*z1^7-2*z1^6-3*z1^5+4*z1^4-3*z1^3+2*z1^2-5*z1-10
 //x*k+z1*n-i*k^k-(-k*2*n-z1*i*k)^(k+1)
 //

 //sp8i(vd1,n,y,ve2,k,x,vi3,j)+ps8i(vd1,n,y,ve2,k,x,vi3,j)+ms8i(vd1,n,y,ve2,k,x,vi3,j)+pc8i(vd1,n,y,ve2,k,x,vi3,j)


//*****************************************TEST*********************************
//*****************************************REAL*********************************


// ***************************************CONST*********************************



//-((-(-a)-b)-2-c)*d*((-(-c))-d)*(-((-(-d-c))))*(-(-2-a))-((-a)/(-b*2)-3/(-c)-4)*(-(2*(-c)*(-d*3*c/(-a-1/d*a*3-d-3*(-c/(-1-b*a*b*3*4/a/b/4-5))))))-(-(-2-b/3/4/a)-a-3+a*(a-b*2*c-(-d)*2-b)*(-a/(-a-b-1)*c))/((-(b)))*(-(a+b)/(-c)+2*c-b-(-b*d*3*4/c/(-5)))
// (2+b-3)*(7-9+b*c/7*(-c)/(-5/c-d/2)-a*(-6))-(-(2*(-c)/(-c-7/(-c/(-7/(-b*(-5/7-1)*3*a))))*d*7/9)/(-d*a+3-c*(4/(a*2*c+b*7)-(c*7/b)+(-1-c/(-4-b+c*d))+a)))/(-4-7*(-2-c-1/(-1/c-(-1/d*2)+2*b/(c-b*4)))*4/c*(-(-b/4))-(-(-4/b-c*2-5*d/7-(3-7*b/(-1/c+b+c*2)+4*c/d*(-(-3*a)/(-(-5-9/c)))*(2*3*c-d*7*(-a))/(-(5*a-d/(-a+b))/c+d/(a*(2-4+6/8*9)-(-d/(-1))*c+d*(c/(-a)-1/d)+e))*3)/5-c/((-c)*(-b)/(-6+d-a*c)))));

//**************************************VAR X,Y,  ******************************

// -(-a/(b-(-c*d-x))*x*b/c/(-a/b*y/c/x-b*(-c-(-d-(-2.5-c/2.12*(-(-a)/(-b-c/(-d*a))+b*x*(-a)/(a+b*(-c)-b/c*(b*x*c*y/(-a*x-y*b+c/(a/x-b/y-c/d))))*(-a/(-y-b/(-c/x))))-y/(-x-b/(-c)))))*(b/x/y/a/(b-a/c-y/(-x/y+y/(-x))))/(-y-c-x-d/b)))*(-(-(-(-(a*b-c*(-(-d-c))))))*(-(-(-x-a)*(-b-y)/(-(-y*x*(-c/(c-y-x-d)*b*(-c-d))))-y*c*x*d/a*(-x/(-(-(-a/(-y-(-b*c/x)+b+c+d/(c+d/a)))))))));
//  -(-(-1/(-1-1.12/a-1.51/(-b/x)))/(-x-b/(-(-1.12*x/a-y/1.52*(-x-y/b)*b/c)))-(-x*1.62*a*c/(c/(-x/b/c/y-t/(-x*1.93*c/y)))-y/t*1.63*b/(-1/c-1/d)*(-c/x-y/(-b/c/d-2.13/a/b*c)-(1.15*x-a*(-b)/(-y-1/x))*x/(-c/(-d-x/t)-d*(-c*x-a/y)/(-b/x-d/t*y))))-(y/x*c/1.73-c/d/y-y/a/c)/(-x/(-y*(1.73*a*x-2.52/b*y)/(-3.84-a/(-(-(-x-t/(-b/c-d/(-x/a-y/b*x-b*y/x)+c/(-d/y*2.31/x*c)))))*(-t/b/x-b*(-c)/(-d-2.31)/(-x/2.85-1.97/y+a*b/(-y/(-x+1.5*a/c)))))))) ;
// (-x*a-b/(-3.5*a/(b-c/2.87-a*x/b*y/(-x/a-2.12*b/c-b/(-x/(-y/a*b*2.41/(-c-y)))))-c/(-a*(-x*(-2.54/a*b-b*1.73*(-x/(-y/(-1.54/(-x*b/y-c/y/(-x/2.83)))-c*2.71/y)))))))*(-b/c*1.23/x/(-x/c/1.34-a/(-y))-b/c*1.31/(c*a/x-y/(-x/(-2/(-y))*2.43/b))+c/(-x)-x*(-1/y)/(1-(-b/c-a*(-b-x/(-c/2.15)))))/(-(1.31*x*(-a-1.12)/(-b)*y-b/(c-a-b/1.41))*(-y*x*a*(-b-a/(2.53/b-c*y*(-x)/(-c/b-x/(-y-2.31/x/(-b)))))/(-c-a*(1.12*a-b/1.72)))-x*(-y/(-1/x-2/(y-x/y*c/(c-x/b/(-x-y-c/a*(-1.45/x)))))-c*x*2.12/(-y-(-1.32/a-c/(-y/(-c-x/b)))))) ;
// (-a*2.12/3.53*x/(-b/x*2.17/(-c/(-x/(-2.12*a*y*b/(1.12*b/c/x)))))-a*y*b*(-2.17)*x/(2.15*b-c/d/(1.15-2.15*x*(-y)*(-b/c/a))))/(a*x/(-1.15/b)/c/(2.15*d-a/b/x/y/(a*x/y*1.74-b/x/y/(b-c/d))));
// (2+b-3)*(y-7*a-x*9*(a-b)+b*c*x/7*(-c)/(-5*a/x*b/c-d/2)-a*(-6-x-c+b/y))-(-(2*(-c-b/x*a)/(-c/y-x/c-7/(-c/(-7/(-y*b*(-5/7-1-x*b+c*y)*3*a*x/y))))*x*d*7/9/y-x/(-y*2*a*x*(c+d)/b/5+c*7/x*8/d/y))/(-d*a/x+3/(c-d)*y/(a*2-b)*3-c*(x*4/(a*2*c+b*7)/y*(c/d-3)/d*5/x-(c*7/b+x+3/a+b/y/5*x/(c-b)-b/c+7-c/b-2*a*y/(2*a-b)/(b/(c-d)+2*a)*b/d/x)+(-1-c/(-4-b+c*d-x+b*y/(a-b/x)))+a+b/d-x+b+y)))/(-4-7*(b/a/y/x/c/d/(d-b/a)-2-c-x/(-1/c-(-1/d*2*x)+y*2*b/(c-b*4)))*4/c/x*(-(-b/4-y-c/d+x))-(-(-4/b-c*2-x*a-a/b-b*y-5*d/7-x*y*(3-7*b/(-1/c+b+c*2)*x/(-b*y-x/a-b+c)+4*c/d*(-(-3*a*x)/(-(-5-y*9/c)))*(y/2*3*c*x-d*7*(-a-x+b-d+y))/(-x/(5*a-d/(-a+b-y*(a+b)/c))/c+d/(a*(2-4+6/8*9-(a-b)/c*x)/y-(-d/(-1/x-c*x/b))*c/(b-a/c/y)+d*(c/(-a)/x-1/d)/y+e*y))*3)/5-c*x/((-c)*(-b)*y/(y-6+d-a*c+x-c/d/(b-c*a))))));
// -((-y)/x-(-a)*y-(-x-y))-(-y-(-2-x/(-y*x-x*a-b/y*(-x*(-y)*(a*x-b/(-y)*x*c-c-x)-x/y)+c/x-d/x-y/(c*x))+x*(-y-x*a-b)*c/(y+x*y-(-c*y))-y*(-2-x)-(-(-x-5-y))-3)-4/y*(-(-(-7-(-x))/y-5)-y)+x);
// -1/(-a/(-x)-(-x/(-b*(-c)*y-d)))-(-(-2*(a*(-b*c-d*2/c/(-a))*(-x*(-a*(-x)-b)*y*(-d-3)))))-(-(-(-a-x)-(-x*(-c)*(-2)-b*(-c)/2/(-a))))-(-(-a*(-b*c-d)*2*(2*(-b)*x-c*3)*(-(3*(-y)-(-b)*2))))+(-(-x*2*(-y)*(-b))*(-(-x)*(-y)*(-a)*(-a-(-b))*2*(-c)*(-(-x/(-x/(a-b*c/(-x))-a*(-b-x)/(c/(-x)-b))))*(-x*(-a/(-x*(-y)*a/b*(-c*(-x)-d)-2*c/x)-(a*(-x)-y*(-b-c)*((-y*a-b/(-c))/(-x+b-c/(-d*2+3))))))/c/d/(-b)/(-c-(-b)/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b*(-x/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b))))));
// -(-(-x-(-2*(-x/(-y*(-2)*(-2+(-x*(-x*2-y/(-2/x-x/2-1-y))))*x*(-2*x*y-1))))))-(-2/(-x-y-1)*(2*x-(-3)*x-(-y)*2)*(-1/(-x)-y/(-x-y-1))/x/(-1-x-y/x)-x-y+1)+(-x/(2*x-1/(-x))*(-y/x-2*x-1)/(-x*(-2)*y-5)*(-x-2*y-1)/(-x-y-1)*x/y-(-x/(-2/(-x/(-1-x*y-2-x/y))-5-(-x-x/(2/y)-7)/(-x)-1-x-2*(-x))));
// (-(-x*y+1)-5)*(-(-(-x-1.5-y)))*((-(-x*2.1*y/1.7*t+1.7-3.5)))*(((3.5*(-x)*(y)*(-(-t))/2.5-(-2.7))))*(-(-x)+(-y)*2.5-(-x)*5.7-1.3*(-(-(-y))));
// -(-(-x-a)-((-x)*(-(a)))-a*2/c*x/y*(-y)/(-x)*(a*x*b+c-d)/(2*x*y+b*2))-(-((-x)-y)-(-(-x-(-y)-a))-b*(-x)*(-a-b-2))/(-a/b/x)+(-x)*(-(-x*(-(-y*x*(a*x*y+b)*(a*x*y+b)*(-x-1)*(y+x*2)))))-(-(-x*y*(x*a*b+3)*(-x*y-c*b*2)/(2*x*y+b*c)*(2*a-x)*a*2/3/b*(b+1)));
// -(-a*b*(-c)-x-(-1-y))/(-x*a*(-a-x*y/b)*(-b-x/c)*(-1-y/2*3/b)*x*y/a/(2*c/b-x*y*c*d/3/b))*(a-x*y/b-b*x*y-y*b-a/(-b)-b*x/(-c)*2/3-b*x*y/3/(b-a)-c*x-b*y-c/(-b)/2*(-a-b)*x-y*(b-c/2)/a/b-(-y)*a-x*(-(-b))+x*(a-d/c/y-(-(-(-y)/(-x))))-x/(a*x*y+b-c+2))-x*y*(-x*(-y)-x*(y*x-(-(-x-y-2*x*(-b)-(-x)*y*(-y)-a/x-(-(-a-x*y/c))))))/(-b-x*y)*(-a-b*c)*y*(-2-x/3)*(x*(-y-b-3*(-b/(x*a-b*2*(-c)*x*b-c*x-2*y)-c-x-2-y*2)*c*(-(-d-x/(-b-y))))+x*y/(a*x-y*b-c-1));
// x*y*(2*x+1)*(2*x*y/t-2*x*(3*t-1)/(2*x-3*y-4)*(x/(3*x-1)-4/x+5*(2*x*y*t-1)/(y+1)-7*(2*x*(y+1)*(3*y+2)*(3/(x+1)-2*t/(2*x*y*t-1)+(4*x-1)*(5*y-7)/(x-2*y-1-2*t/(3-7*x-8*y*(4*x/(2*t+1)-7*x-8/t+9*(2*x-1)*(3*x+4*y+5)*(2*x*y*t-7)*x*y*t/(x-y*2-3/(x/(t-1)-7/(y+2)+8/(2*x*y*t+1)-9)))))/(x-1)))));
// -(-1/a*b-c/x*(1-d)*(-a)-b/c/d/(x-c/(-d)*(-x*2)*(-y*(-2)/(-c)/d/x)-x/2/a))*(-2/a/x*y*3*d*(d+c)*(x+a)*(y+(-a))*(a+1)*(2/d-c))+a/c*d*2/3*x*(-2)*(-a)*(-a-b)*(-x)/(-x-a*x*y*(x/(x*a-y*b-c)*2/c-c/(-d-1)));
// (2*x-(-x/(-y-1)-y)-(-(-1-y))-y/(-x-y-2*(-x/y-3)))*(-(-1-x-(-(-x-(-1-2/y))/(x*y-2/x*(2+x)*(2*x+3*y-4)*y/(2*x+3*y+4))-x/(x+3*y-4))*x*y)*(2*x+1)*(3*y+2)*y*x)-(-2/x)*x*y*(2*x+y-1)*(-y/(-x/y-(-y/(-x/y-1))*(x*y*2-1))-x);
// -1/(-a/(-x)-(-x/(-b*(-c)*y-d)))-(-(-2*(a*(-b*c-d*2/c/(-a))*(-x*(-a*(-x)-b)*y*(-d-3)))))-(-(-(-a-x)-(-x*(-c)*(-2)-b*(-c)/2/(-a))))-(-(-a*(-b*c-d)*2*(2*(-b)*x-c*3)*(-(3*(-y)-(-b)*2))))+(-(-x*2*(-y)*(-b))*(-(-x)*(-y)*(-a)*(-a-(-b))*2*(-c)*(-(-x/(-x/(a-b*c/(-x))-a*(-b-x)/(c/(-x)-b))))*(-x*(-a/(-x*(-y)*a/b*(-c*(-x)-d)-2*c/x)-(a*(-x)-y*(-b-c)*((-y*a-b/(-c))/(-x+b-c/(-d*2+3))))))/c/d/(-b)/(-c-(-b)/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b*(-x/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b))))));
// -(-(-x-a)-((-x)*(-(a)))-a*2/c*x/y*(-y)/(-x)*(a*x*b+c-d)/(2*x*y+b*2))-(-((-x)-y)-(-(-x-(-y)-a))-b*(-x)*(-a-b-2))/(-a/b/x)+(-x)*(-(-x*(-(-y*x*(a*x*y+b)*(a*x*y+b)*(-x-1)*(y+x*2)))))-(-(-x*y*(x*a*b+3)*(-x*y-c*b*2)/(2*x*y+b*c)*(2*a-x)*a*2/3/b*(b+1)));
// -(-a*b*(-c)-x-(-1-y))/(-x*a*(-a-x*y/b)*(-b-x/c)*(-1-y/2*3/b)*x*y/a/(2*c/b-x*y*c*d/3/b))*(a-x*y/b-b*x*y-y*b-a/(-b)-b*x/(-c)*2/3-b*x*y/3/(b-a)-c*x-b*y-c/(-b)/2*(-a-b)*x-y*(b-c/2)/a/b-(-y)*a-x*(-(-b))+x*(a-d/c/y-(-(-(-y)/(-x))))-x/(a*x*y+b-c+2))-x*y*(-x*(-y)-x*(y*x-(-(-x-y-2*x*(-b)-(-x)*y*(-y)-a/x-(-(-a-x*y/c))))))/(-b-x*y)*(-a-b*c)*y*(-2-x/3)*(x*(-y-b-3*(-b/(x*a-b*2*(-c)*x*b-c*x-2*y)-c-x-2-y*2)*c*(-(-d-x/(-b-y))))+x*y/(a*x-y*b-c-1));
// (-x/(-y/(-t-y/(-x*2.1/(-3.1*x*y-2.7*t)-y*x/(-x-(-t*1.5/(-y*3.7/(-x)-y/t)-t/(2.7-x*y/(-x))-3.7/x)-4.5/(-y/(-x-y/(t/x-x/(-y))-t/(x-6.5/(-y)))-x*(-y*2.7-t/x)/(7.5-x*y))-y*x*(y-t/x)/(-t/(-x)-4.5))-5.1/(-x-y/t))-2.5/x/y/(-t/x-y/t))-4.5*x/y/(-2.8/t)/(-x/(-y)))-(-x-3.1)/(-2.5-y)/(-t-x/(-y))/(-x-y))/(-x*3.5*y/t*(-7.1/(-x+y/(-x))*(y*x-t/y))/(-x-y-t/(-x-y/1.9)));
// -(-(-1.5-(-3.4-(-(-1.7*a/6.3/(b-1-(-c-5.7*a*b/c-x-y/(-x/(-a*c/(-b*y-c*y/(-y/(-a)/b/(-y/(-x*a/b/(c-b/d/y-(-x)/(-b)/(-a-c/d/(-b)*(-y)))))-c*(-b)/(-d/(-a-x/y))))))))))))-a*(-b/(c+3.4)*1.4*x))*(-a*(b-c/3.5)*x*(a+b/5.2*(-7.8)*y-c*(-c-4.5*(-d))))-(-(-a*(-b-1.5)*(-5.8))*x-(-2.6/(-7.8)/(c-d))-c/7.1*(-d)*(1-(-6.7/(-c-2.5))))*(-(-1.7-(-x-(-(-4.5)/(-a-b/c/7.5/(-7.1)/(-b)*x*(-y)-(-c)/(-d-1.5*a))))))+(-x-(-(-(-a)-(-1.7)-(-c-d/(-c))))*(-x)-(-a)*(-7.5)/(-c)*x-(-b)/(-x))*(-a*(-b)*(-y)*x-(-4.7*c/d)/(-y)*(-x))*(2.1*a-(-4.7/b)*(-c-x)/b*(-b/x-y/(-c)-y/(-c-b/(-c/x-b*c/y/a*(a*b-c/d)/(-x/y/(-a)-y/x/b))))+a/b*c/d*(-4.3)-b/(-9.8)*(a+6.5)/y-x);
// (((-x*(-a)-(-b)*(-1.5))*(-y/(-b)-c*1.2)*(-c*(-3.5)-(-b)*t)/(-c/(-a)+x/(-b)*(-y)/b*t)/(-x*(-b)-c)/(-1.5-(-y)*(-a)))/(-(-(-x)*y*(-a)*t-a*b)*(-(-x)/(-b)*(-t)-a/(-1.5))*(-(-x)*a-b)*(-(-b)*(-1.5)*(-x)-1.5)*(-x)*(-y)*t/(-(-x)*a-(-b)*(-y)+(-t)/(-c)-b)/(-y*(-a)-(-b*3.1))))*(((-t*(-b)-c)/(-1.5-(-x)*(-b))*(-a-(-b)*(-x))/(-3.7-x/(-b))*(-a*(-b)/(-1.5-c)*(-x)*y/(-b)*t*(-a/b)+b))/((-1.5)*x*(-y)/(-b)*t*(-x)*y*(-t)/(-1.5-(-x)-(-a))*(-b-(-x)/(1.7))*(-c-(-x)*(-5.1))/(-a*(-x)+5.6-b*(-y)-t*c-7.5/(-b))*(-x*(-a)-y/(-5.3)-7.5-(-c)-(-b)/(-4.3)-t*c/b)/(c*y/(-t)*x/(-1-x)*(-7.3)-b/c)));
// ((-t/(x/a-b/(2-y*(c+1)))-x*y*(-y/(x*t/y-2*x*t*(b-c)/(-c*2-y*b*x*3/(t*x*b-c*3/x-t*2/(x*a-b*t/y))))+2*a/(b-t/(x/y-y*3/(x+a*2)))))+a*y*2*(-b*x+3*y-t-2*c)/(-c-(-2-(-x-t/(y*t*x/b-2/c-x/(-2-y*t/x-y/(-y-b/(c-x/((c-x)*(2+y)-b/x)))))))));
// (-a/(-b*x/(a/x-c/y-a*b/x*(x-b)*(c/b-a/x)))+(-y/(a*y*t/(a*x-b/y))+b*(x/(-a-b+x/y))*((b/(x/(-y/x-c/y*x-a))-(-a*x*(-b-y*(x/(-y/t-c))))/c)/y)*c)*(-c-a*(-b/y-c*(-y-x*y/(-y-a)*(-x/(x*y/c-y*x*a-y/(-c-b*(-y-x*(-x/(-y/(c-x)+x*b*y/(a/y-c/x-b))-c/(x-y))-b-c)*(c*a/x-y*b*c*x/(a-y*x))/((-y-b*(-c-(-x-(-y-c/(-a-x))))-x)/x-y/(-y/(x*a*(-b-c-(-x-y)*(y+x*y))-b/y)-x/(x*y+y*x*(x*a-b*y-c*y*x-a))*b)))*x)-(a*y/x-c-x*b/y)/x))-x/a*y)/((-b*x+a)*(-y*c-a)*x/(-x*a*b*y-c))*x));
// (-a*x*(-2*3*b+4-2*(-3/(2/x-x/5-b/((y-3)*(3-x)-3/x)-2/(2*a-(3+y)*(x+2)))/b-5-a-x*3)-(2*x-y*3-4*a/(y+b*2))*3))/(-7-a/x*(-y/(x/y-2*x/y-y/(-2-x*c-b*y*3-((b-c+2)/(a-b+3)-(b+c*2)/(x-(3-b/c)))*2)))) ;
// (-(-(-(-(-2-x-(-y-3-b-(-x/(-y/(-c/(-b-y/(-x*b))))))))))-(-2-(-a-(-x/(-y/(-c/x-(-x*b-c/(-y*2-b*c/(-a*2-b*(-(-x)-b*(-3)*(-y*x-3*b/(-c)))))))))))-b*c/(-c-b-(-x)*(-y-2*(-b))/(-2/(-y)-(-x)*x*(-(-(-y-(1-x/(1-y/x-b)))))))) ;
//  -(a*x*y/b/y-b/(y*a-b*x-c*(b/x-y/c))-(-x-(-y/(-a*x*c-y*b*t)*c*(-x)-b/(y/x/c-a/y/x-a*b/c)-c*b-c*y/(-x))-(x-a)*(b-y)*(b+x)*(c+y)/(c*x*b-x*a*y))+a*(b/(a*c-b)-y/(c/(-x*(-a)-y/(-b))/b-y/(c*b-a-c))*a/(-a/x-b/(c/x-y/a))/(b-c/a))-(-x*y*a-b/x*y/c*(-x*(a*c-b)))/b) ;


//  x*y*t*(t*x*(x*y-t*x)-x*y*(x*t-y*t)+y*x*(y*x-t*y)-(x+y)*(x-y)*(t-y)*(x*y-t*x*(x-y*(t-x*(t-x)*(x-t)*(t-y)-x*y-y))))-(x*t*y*(x*y-x*(y-y*(t-t*(x-x*t*(x*y-t*x-(x*y-t*x)*(x-y)*(y-t)*(t-y)-(x+t*y)*(y-x*t)+(t-y*t)*(y-t*x))))))) ;
//  -x/(x/y-t/(x+t)+x*y*(x*y-y*t+x/(x/(x+y)+y/(t+x))))*(y*(x-y/(x*y-y/(x*y+y*t)*(y*t-x*y)))+x-y*(x-t-t/(x-y)*(y/(y-t*(x+y*t)*(y-x*t)/(x*t-y*(x+t))))))*(x*y-t*y-t*(x*t-y*(t-x)/(x*y*t-x-y-t)));
//  x*y*(2.111*x+1)*(2.211*x*y/t-2.311*x*(3.422*t-1)/(2.511*x-3.611*y-4.22)*(x/(3.711*x-1)-4.111/x+5.111*(2.611*x*y*t-1.23)/(y+1.12)-7.132*(2.812*x*(y+1.123)*(3.832*y+2.121)*(3.112/(x+1.123)-2.133*t))));
//  x*y*(x-t*(2.123*x-3.222*y-5.323)/(t*x*y/(2.234-x*y)+(2.455*x+3.632)*(3.734*y-4.832*t-5.923)-(1.134-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.745*x-3.345*y-t))-y*(x*y-y*t*3.167+2.965*(x/t-t/(x-y*(2.467-x-y-t)))*(y-t)-2.376*x)*(y-x)-7.154/x)*(-1.943/t+x*y*t*5.334))-3.556*x-5.657)-7.243*y-3.459)/(x-t)+x*(t*y/(x-2.834*t)-y*(x*(t-2.756*y-x-5.676))));
//  (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t)-t*(-x-y*(-t*(-x*(y-t))))))))))));
//  x*y-x/(x/y-t/y-(-x-y*(x*y-t*x/(x/y-t/y-(-x-(-y-(-t-(x*y-y*(-x*y-y/(x+y*t)))*x)*y)/(x+y*t)-x*(y/t-(-y*x/(x-y*t)-(-x-(-y/(-x*y*(-x-y))+x/y*(y*x+y*t-x/(x+y*t))-x*y*(x*y+(-x*y-t/y+x-y*x)))))+x*y*t*(x+y*t)))))));
//  x*y*(x-t*(2.154*x-3.253*y-5.353)/(t*x*y/(2.544-x*y)+(2.143*x+3.556)*(3.343*y-4.153*t-5.456)-(1.153-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.644*x-3.364*y-t))-y*(x*y-y*t*3.164+2.267*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.535/x)*(-1.253/t+x*y*t*5.353))-3.433*x-5.455)-7.466*y-3.577)/(x-t)+x*(t*y/(x-2.699*t)-y*(x*(t-2.767*y-x-5.854)-y*(-1.549-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.344/y-x*y*(2.435*x-1.456)*(t*y*3.326-5.347)*(1.943-x*y*t*3.245)*(x+y))))));
//  (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t*(x-y*(t-x*y-y*(x*y-t*x)-t*(t*x+y))))-t*(-x-y*(-t*(-x*(y-t*(x*y*t-y*x*t*(-x*(y*x-t*y-x-y-t)))))))))))))));
//  (x*y+t/(x*y-y*t/x-x+y-t))*(x+y+t)/(x-y-t)*(t-x*(t-y/(x-y-t)))*x/y*t-x*t*(x*t-y*t+x-t)/(y*x+t*x+t/y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y/(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t/(x-y*(t-x*y-y/(x*y-t*x)-t/(t/x+y))))-t*(-x-y*(-t/(-x*(y-t*(x*y/t-y*x*t/(-x*(y*x-t*y-x-y-t)))))))))))))));
//  x*y*(x-t*(2.156*x-3.652*y-5.653)/(t*x*y/(2.664-x*y)+(2.155*x+3.543)*(3.345*y-4.431*t-5.443)-(1.451-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.453*x-3.353*y-t))-y*(x*y-y*t*3.153+2.253*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.553/x)*(-1.253/t+x*y*t*5.533))-3.453*x-5.453)-7.453*y-3.553)/(x-t)+x*(t*y/(x-2.653*t)-y*(x*(t-2.753*y-x-5.853)-y*(-1.539-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.553/y-x*y*(2.535*x-1.53)*(t*y*3.536-5.753)*(1.539-x*y*t*3.665)*(x+y*(t-(-x-y*t/(x*y-2.863*(x*y*(x-y*(x*t+y/t*(2.623*x-1.352-t*y)))))))))))));
//  x*y*(2.251*x+1)*(2.243*x*y/t-2.353*x*(3.475*t-1)/(2.575*x-3.675*y-4.766)*(x/(3.767*x-1)-4.176/x+5.186*(2.866*x*y*t-1.766)/(y+1.876)-7.165*(2.874*x*(y+1.641)*(3.864*y+2.162)*(3.171/(x+1.765)-2.173*t/(2.174*x*y*t-1.171)+(4.171*x-1.164)*(5.172*y-7.174)/(x-2.175*y-1.747-2.174*t/(3.618-7.716*x-8.181*y*(4.612*x/(2.189*t+1.165)-7.198*x-8.149/t+9.912*(2.199*x-1.261)*(3.107*x+4.179*y+5.108)*(2.271*x*y*t-7.179)*x*y*t/(x-y*2.282-3.621/(x/(t-1.147)-7.198/(y+2.245)+8.233/(2.288*x*y*t+1.247)-9.174)))))/(x-1.525)))));


//--------------------------------------------------------------------------------

//c*y*(a*y*(b*y+c+d*y*(c*y+e))+(d*y+a)*c+c*y+e)*(a*y+b)*(c*y+d*(c*y+a)+d)*(a+c*y*(d*y+c+y+(c*y+e)*c+(e*y+d)*b)+c*y+d)+d*y+e*y*(a*y+c+y)+y+c*y*(a*y+b)*(c*y+d)*(d*y+e)+d*(c*y+(b*y+c)+(d*y+e)+a)+b
//c/x/(a/x/(x/b-c)-(x/d-a)-x/c-e)/(x/a-b)/(x/c-d)/(a-x/c/(x/d-c-x-(x/c-e)/c)-x/c-d)-x/d-e
//((c/x/(a/x/(x*b-c)-(x*d-a)-x*c-e)/(x*a-b)/(x*c-d)/(a-x*c/(x*d-c-x-(x*c-e)*c)-x*c-d)-x*d-e)/(c*x-d)-(x/(a*x-c)+(a*x-b)/x)/(c*x-d)+x/(c-x/(a*x+b)-(c*x-d)/x+(a*x-b)/(b*x-c)))*(a*x+b)/(c*x+d)+b*x*(c*x+d)/(a*x+d)-c*(c*x+d)*(b*x-a)/x+b
//c*x*(a*x*(b*x-c-d*x*(c*x-e))-(d*x-a)*c-c*x-e)*(a*x-b)*(c*x-d*(c*x-a)-d)*(a-c*x*(d*x-c-x-(c*x-e)*c-(e*x-d)*b)-c*x-d)-d*x-e*x*(a*x-c-x)-x-c*x*(a*x-b)*(c*x-d)*(d*x-e)-d*(c*x-(b*x-c)-(d*x-e)-a)-b
//(((2*x+3)*(3*y+4)+(3*x-5)/(4*y+6)+x*(4*y-5))*(3*x-4)+(2*x+3)*(((3*x-4)/(3*y+5)+5*x/(2*x-5)-7*y*(3*y+5)+7)/(3*x+4)-5/x-7/y))/(((3*x-4)*(4*y-5)*(5*y-7)*x-(3*x-8)*(2*y-9)/(3*x+4)+5/x-7)*(2*x-3)*(3*y+4)+x*(3*x-4)*(3*y+4)+5/x+7)+(3*x-5)*(5*y+6)/x+y*(3*x+5)/(5*x-6)+7
//(2*x*(2*t-1)/(3-x)-t-x/t/(7-y))*(3/x-t-3+(y*(x-1)-t*(5-x/t-7*(8*x-1)/(t*2/y+1))))-(2*x-x*y*t/(6*x-1)-t*(4-y)+2-5/x*(x-t*(3-x))*(x*y/(x+1)/(t-1)-2/y*(y-t))-x*y*t*(3/t+1)/(5*y/x-1))
//x*y-y*(x*y-x*y*(x*y-(x*y+(x*y-x*(x*y-x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y)))))*y)*y))
//(-x*a-b)*(-a*x*y-b)*(-2*x-c)/(a*x*y-b)-x*y*c*(-a*x-b*y-c)*(-x-b)*(-d*y-b)/(-a*x*y-b)
//x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y-(x*y+(x*y-(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y-(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y+(x*y+(x*y+(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x+(x*y+x*y+(x*y-(x*y-(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1))))))-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))
//(a*x*y+t-b*x)*(c*(t/x+x/y*(c*x+y-t*(c+y*x*t/d+(y-x)/t)))-x/(x-b*t*y-d/(a*x*y*t-c)+a/x+b/y+c/t-e/(x*y*t))+b)
//a*x*(b/(c*c-d)+e*x*(c*(d*x*((a*x+b)-(b*x-c))-x/((x/b-c)*c+(x/d+a)*x+c)+(a*x+b)-(b*x+c)+(c*x+d)*e*x)/(a*(b*(c*(d*(e*x-a)*(x+b)+(c*x-d)*x*a)+c*x+d)+e)/(x-d))*(x/c-d)*a*x))
// (-x/(-y/(-t-y/(-x*2.1/(-3.1*x*y-2.7*t)-y*x/(-x-(-t*1.5/(-y*3.7/(-x)-y/t)-t/(2.7-x*y/(-x))-3.7/x)-4.5/(-y/(-x-y/(t/x-x/(-y))-t/(x-6.5/(-y)))-x*(-y*2.7-t/x)/(7.5-x*y))-y*x*(y-t/x)/(-t/(-x)-4.5))-5.1/(-x-y/t))-2.5/x/y/(-t/x-y/t))-4.5*x/y/(-2.8/t)/(-x/(-y)))-(-x-3.1)/(-2.5-y)/(-t-x/(-y))/(-x-y))/(-x*3.5*y/t*(-7.1/(-x+y/(-x))*(y*x-t/y))/(-x-y-t/(-x-y/1.9)))
//-(-(-1.5-(-3.4-(-(-1.7*a/6.3/(b-1-(-c-5.7*a*b/c-x))))))-a*(-b/(c+3.4)*1.4*x))*(-a*(b-c/3.5)*x*(a+b/5.2*(-7.8)*y-c*(-c-4.5*(-d))))-(-(-a*(-b-1.5)*(-5.8))*x-(-2.6/(-7.8)/(c-d))-c/7.1*(-d)*(1-(-6.7/(-c-2.5))))*(-(-1.7-(-x-(-(-4.5)/(-a-b/c/7.5/(-7.1)/(-b)*x*(-y)-(-c)/(-d-1.5*a))))))+(-x-(-(-(-a)-(-1.7)-(-c-d/(-c))))*(-x)-(-a)*(-7.5)/(-c)*x-(-b)/(-x))*(-a*(-b)*(-y)*x-(-4.7*c/d)/(-y)*(-x))*(2.1*a-(-4.7/b)*(-c-x)+a/b*c/d*(-4.3)-b/(-9.8)*(a+6.5)-x)
//-((-(-a)-b)-2-c)*d*((-(-c))-d)*(-((-(-d-c))))*(-(-2-a))-((-a)/(-b*2)-3/(-c)-4)*(-(2*(-c)*(-d*3*c/(-a-1/d*a*3-d-3*(-c/(-1-b*a*b*3*4/a/b/4-5))))))-(-(-2-b/3/4/a)-a-3+a*(a-b*2*c-(-d)*2-b)*(-a/(-a-b-1)*c))/((-(b)))*(-(a+b)/(-c)+2*c-b-(-b*d*3*4/c/(-5)))
//-1/(-a/(-x)-(-x/(-b*(-c)*y-d)))-(-(-2*(a*(-b*c-d*2/c/(-a))*(-x*(-a*(-x)-b)*y*(-d-3)))))-(-(-(-a-x)-(-x*(-c)*(-2)-b*(-c)/2/(-a))))-(-(-a*(-b*c-d)*2*(2*(-b)*x-c*3)*(-(3*(-y)-(-b)*2))))+(-(-x*2*(-y)*(-b))*(-(-x)*(-y)*(-a)*(-a-(-b))*2*(-c)*(-(-x/(-x/(a-b*c/(-x))-a*(-b-x)/(c/(-x)-b))))*(-x*(-a/(-x*(-y)*a/b*(-c*(-x)-d)-2*c/x)-(a*(-x)-y*(-b-c)*((-y*a-b/(-c))/(-x+b-c/(-d*2+3))))))/c/d/(-b)/(-c-(-b))))
//-1/(-a/(-x)-(-x/(-b*(-c)*y-d)))-(-(-2*(a*(-b*c-d*2/c/(-a))*(-x*(-a*(-x)-b)*y*(-d-3)))))-(-(-(-a-x)-(-x*(-c)*(-2)-b*(-c)/2/(-a))))-(-(-a*(-b*c-d)*2*(2*(-b)*x-c*3)*(-(3*(-y)-(-b)*2))))+(-(-x*2*(-y)*(-b))*(-(-x)*(-y)*(-a)*(-a-(-b))*2*(-c)*(-(-x/(-x/(a-b*c/(-x))-a*(-b-x)/(c/(-x)-b))))*(-x*(-a/(-x*(-y)*a/b*(-c*(-x)-d)-2*c/x)-(a*(-x)-y*(-b-c)*((-y*a-b/(-c))/(-x+b-c/(-d*2+3))))))/c/d/(-b)/(-c-(-b)/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b*(-x/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b))))))
//-(-(-x-(-2*(-x/(-y*(-2)*(-2+(-x*(-x*2-y/(-2/x-x/2-1-y))))*x*(-2*x*y-1))))))-(-2/(-x-y-1)*(2*x-(-3)*x-(-y)*2)*(-1/(-x)-y/(-x-y-1))/x/(-1-x-y/x)-x-y+1)+(-x/(2*x-1/(-x))*(-y/x-2*x-1)/(-x*(-2)*y-5)*(-x-2*y-1)/(-x-y-1)*x/y-(-x/(-2/(-x/(-1-x*y-2-x/y))-5-(-x-x/(2/y)-7)/(-x)-1-x-2*(-x))))
//(-(-x*y+1)-5)*(-(-(-x-1.5-y)))*((-(-x*2.1*y/1.7*t+1.7-3.5)))*(((3.5*(-x)*(y)*(-(-t))/2.5-(-2.7))))*(-(-x)+(-y)*2.5-(-x)*5.7-1.3*(-(-(-y))))
//1-(-x-(-x*y-a)-(-(-3-5*x*t)*(-(-(1-(-(-x*y+2)*(3-x*y)*(-5-x*y)*(-x*y-7)))))))-x*y*a-x*(-x+c)*b*(-2*x*y-b)
//-(-(-x-a)-((-x)*(-(a)))-a*2/c*x/y*(-y)/(-x)*(a*x*b+c-d)/(2*x*y+b*2))-(-((-x)-y)-(-(-x-(-y)-a))-b*(-x)*(-a-b-2))/(-a/b/x)+(-x)*(-(-x*(-(-y*x*(a*x*y+b)*(a*x*y+b)*(-x-1)*(y+x*2)))))-(-(-x*y*(x*a*b+3)*(-x*y-c*b*2)/(2*x*y+b*c)*(2*a-x)*a*2/3/b*(b+1)))
//-(-a*b*(-c)-x-(-1-y))/(-x*a*(-a-x*y/b)*(-b-x/c)*(-1-y/2*3/b)*x*y/a/(2*c/b-x*y*c*d/3/b))*(a-x*y/b-b*x*y-y*b-a/(-b)-b*x/(-c)*2/3-b*x*y/3/(b-a)-c*x-b*y-c/(-b)/2*(-a-b)*x-y*(b-c/2)/a/b-(-y)*a-x*(-(-b))+x*(a-d/c/y-(-(-(-y)/(-x))))-x/(a*x*y+b-c+2))-x*y*(-x*(-y)-x*(y*x-(-(-x-y-2*x*(-b)-(-x)*y*(-y)-a/x-(-(-a-x*y/c))))))/(-b-x*y)*(-a-b*c)*y*(-2-x/3)*(x*(-y-b-3*(-b/(x*a-b*2*(-c)*x*b-c*x-2*y)-c-x-2-y*2)*c*(-(-d-x/(-b-y))))+x*y/(a*x-y*b-c-1))
//-((-y)/x-(-a)*y-(-x-y))-(-y-(-2-x/(-y*x-x*a-b/y*(-x*(-y)*(a*x-b/(-y)*x*c-c-x)-x/y)+c/x-d/x-y/(c*x))+x*(-y-x*a-b)*c/(y+x*y-(-c*y))-y*(-2-x)-(-(-x-5-y))-3)-4/y*(-(-(-7-(-x))/y-5)-y)+x)
//x*y*(2*x+1)*(2*x*y/t-2*x*(3*t-1)/(2*x-3*y-4)*(x/(3*x-1)-4/x+5*(2*x*y*t-1)/(y+1)-7*(2*x*(y+1)*(3*y+2)*(3/(x+1)-2*t/(2*x*y*t-1)+(4*x-1)*(5*y-7)/(x-2*y-1-2*t/(3-7*x-8*y*(4*x/(2*t+1)-7*x-8/t+9*(2*x-1)*(3*x+4*y+5)*(2*x*y*t-7)*x*y*t/(x-y*2-3/(x/(t-1)-7/(y+2)+8/(2*x*y*t+1)-9)))))/(x-1)))))
//-(-1/a*b-c/x*(1-d)*(-a)-b/c/d/(x-c/(-d)*(-x*2)*(-y*(-2)/(-c)/d/x)-x/2/a))*(-2/a/x*y*3*d*(d+c)*(x+a)*(y+(-a))*(a+1)*(2/d-c))+a/c*d*2/3*x*(-2)*(-a)*(-a-b)*(-x)/(-x-a*x*y*(x/(x*a-y*b-c)*2/c-c/(-d-1)))
//(2*x-(-x/(-y-1)-y)-(-(-1-y))-y/(-x-y-2*(-x/y-3)))*(-(-1-x-(-(-x-(-1-2/y))/(x*y-2/x*(2+x)*(2*x+3*y-4)*y/(2*x+3*y+4))-x/(x+3*y-4))*x*y)*(2*x+1)*(3*y+2)*y*x)-(-2/x)*x*y*(2*x+y-1)*(-y/(-x/y-(-y/(-x/y-1))*(x*y*2-1))-x)
//c*y*(a*y*(b*y+c+d*y*(c*y+e))+(d*y+a)*c+c*y+e)*(a*y+b)*(c*y+d*(c*y+a)+d)*(a+c*y*(d*y+c+y+(c*y+e)*c+(e*y+d)*b)+c*y+d)+d*y+e*y*(a*y+c+y)+y+c*y*(a*y+b)*(c*y+d)*(d*y+e)+d*(c*y+(b*y+c)+(d*y+e)+a)+b
//c/x/(a/x/(x/b-c)-(x/d-a)-x/c-e)/(x/a-b)/(x/c-d)/(a-x/c/(x/d-c-x-(x/c-e)/c)-x/c-d)-x/d-e
//((c/x/(a/x/(x*b-c)-(x*d-a)-x*c-e)/(x*a-b)/(x*c-d)/(a-x*c/(x*d-c-x-(x*c-e)*c)-x*c-d)-x*d-e)/(c*x-d)-(x/(a*x-c-1)+(a*x-b)/x)/(c*x-d)+x/(c-x/(a*x+b)-(c*x-d)/x+(a*x-b)/(b*x-c)))*(a*x+b)/(c*x+d)+b*x*(c*x+d)/(a*x+d)-c*(c*x+d)*(b*x-a)/x+b
//c*x*(a*x*(b*x-c-d*x*(c*x-e))-(d*x-a)*c-c*x-e)*(a*x-b)*(c*x-d*(c*x-a)-d)*(a-c*x*(d*x-c-x-(c*x-e)*c-(e*x-d)*b)-c*x-d)-d*x-e*x*(a*x-c-x)-x-c*x*(a*x-b)*(c*x-d)*(d*x-e)-d*(c*x-(b*x-c)-(d*x-e)-a)-b
//(((2*x+3)*(3*y+4)+(3*x-5)/(4*y+6)+x*(4*y-5))*(3*x-4)+(2*x+3)*(((3*x-4)/(3*y+5)+5*x/(2*x-5)-7*y*(3*y+5)+7)/(3*x+4)-5/x-7/y))/(((3*x-4)*(4*y-5)*(5*y-7)*x-(3*x-8)*(2*y-9)/(3*x+4)+5/x-7)*(2*x-3)*(3*y+4)+x*(3*x-4)*(3*y+4)+5/x+7)+(3*x-5)*(5*y+6)/x+y*(3*x+5)/(5*x-6)+7
//(2*x*(2*t-1)/(3-x)-t-x/t/(7-y))*(3/x-t-3+(y*(x-1)-t*(5-x/t-7*(8*x-1)/(t*2/y+1))))-(2*x-x*y*t/(6*x-1)-t*(4-y)+2-5/x*(x-t*(3-x))*(x*y/(x+1)/(t-1)-2/y*(y-t))-x*y*t*(3/t+1)/(5*y/x-1))
//x*y-y*(x*y-x*y*(x*y-(x*y+(x*y-x*(x*y-x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y)))))*y)*y))
//(-x*a-b)*(-a*x*y-b)*(-2*x-c)/(a*x*y-b)-x*y*c*(-a*x-b*y-c)*(-x-b)*(-d*y-b)/(-a*x*y-b)
//x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y-(x*y+(x*y-(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y-(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y+(x*y+(x*y+(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x+(x*y+x*y+(x*y-(x*y-(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1))))))-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))
//(a*x*y+t-b*x)*(c*(t/x+x/y*(c*x+y-t*(c+y*x*t/d+(y-x)/t)))-x/(x-b*t*y-d/(a*x*y*t-c)+a/x+b/y+c/t-e/(x*y*t))+b)
//a*x*(b/(c*c-d)+e*x*(c*(d*x*((a*x+b)-(b*x-c))-x/((x/b-c)*c+(x/d+a)*x+c)+(a*x+b)-(b*x+c)+(c*x+d)*e*x)/(a*(b*(c*(d*(e*x-a)*(x+b)+(c*x-d)*x*a)+c*x+d)+e)/(x-d))*(x/c-d)*a*x))
//-(-(-a)*(-x)*(-y)*t-b+(-c))*(-x*(-y)*t*(-a)-b)/(-b-y/(-x)*(-t)*a)-(-x)*(-y)*a*(-a-(-a*(-x)*y*(-t)-b)*(-x)-(-a)*(a-c*(-x)-b*y))
//((-2*3)*x+(-2)*y/3-t*(-11.5)-(-4)*(-5)*(-1.2))*(-(-2)*x-y/(-1.5)-(-1.7)*t-(-(-5)))*(-(-1.5)*x-(-(-1.9))*y-t/(-(-(-1.7)))-3)*(-(-2)*x*(-y)/(-(-(-1.7)))*t-(-(-5.3)))*(-(-x)/(-(-(-7.5)))*(-(-(-y)))*(-t)*(-(-(-9.9)))-1)
//(3*x*y*t-5)*(x*y*(2*x-1)/(2*y+1)/(2*x*y-1)-x*y/(2*x-4*y+5*t+4)*(2*x*y+1)-y*(-x-x*y*t*(2*x*y*t+1)/(2*x*y*t-1)*(2*x+3*y-4*t-5)*(2*x+2)/t))-x/(x/(2*x+1)+y/(2*x-1)+t/(2*x*y+1)-x*(-y/(2*x+3*y-1))*(-x/(2*x*y-t/(2*x+3))))
//-(-a*1.5/(-b*2.7/(c/(-x-1.5*a/(-b*1.5+c)+x*(-1.9-a)*b*3.1)))-2.1*a/3.5/c/(c-1.5)+x*(-a)*(-5.1)*y*(-a*x-3.5*b*y*3.5-d/c/5.2))*(-2.1*sin(-6.5*x-a*b-5.3)/7.8+2.5/cos(2.5*(-a)*x/(x-a*y)*(-3.1)*y*(1.5/x/a/c/(-c-7.1/d/(-c/a-5.7/(-3.1*(-a*x)))))))/(-2.1-a*3.2/(-x/(-d/c*a/(-a*2.1/x*c+x/(-a)-y*(-x)*(-a*4.5/(-x)))))-c*2.9*(-d)*(-3.5*c-d)*sin(-x-a-(-b-(-1.7-(-x/(-1.7-d/c))))))
//-(-x)-(-x/(-x-1-y)-t)*(-(-(-x-1)-y-y-1)/(-y)*t/(-y)-y)*(-(-sin(x)-1-x)-y*x/(-y)/(-y)-(-(1-cos(x)-x)-y)/sin(x)+(-(-x*x-y-y+1)-sin(y)/(-t-(-x)-1)*y)*y+(x-(-sin(x)-1-y)-t/(-t*x/(-y)-1)-1)-x-1)
//-(-1/a*b-c/x*(1-d)*(-a)-b/c/d/(x-c/(-d)*(-x*2)*(-y*(-2)/(-c)/d/x)-x/2/a))*(-2/a/x*y*3*d*(d+c)*(x+a)*(y+(-a))*(a+1)*(2/d-c))+a/c*d*2/3*x*(-2)*(-a)*(-a-b)*(-x)/(-x-a*x*y*(x/(x*a-y*b-c)*2/c-c/(-d-1)))
//2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
//-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//(2*x-(-x/(-y-1)-y)-(-(-1-y))-y/(-x-y-2*(-x/y-3)))*(-(-1-x-(-(-x-(-1-2/y))/(x*y-2/x*(2+x)*(2*x+3*y-4)*y/(2*x+3*y+4))-x/(x+3*y-4))*x*y)*(2*x+1)*(3*y+2)*y*x)-(-2/x)*x*y*(2*x+y-1)*(-y/(-x/y-(-y/(-x/y-1))*(x*y*2-1))-x)
//-(-(-(-x/(-x/(-y-x/(-(-y/(-x)/(-y*(-(-x-y*(-x/(-y*(-x-y/(-x*y-x/(x-y/(-x))))))))))))))))
//-y*x/(-x/y-y/(-y/(-x/(x/y/(-y-x/(-x/(-y/x-x/y)))))))
//(-a/(-x)-(-b-y/(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))))/(-x*y/(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))))




//(-x*y/(-t)*2.1*(-x-1.5)*(-2.5-2.1*x)*(-(-x)*(-1.7)-3.5)*(-y*(-2.5)-1.5)/(-(-x)*2.5-y*2.5+t*2.1-7.7)*x/(-5.7-x*1.5*(-y)*t))*(-x)/(-y)*(-5.1-x)

//(-(-x-y/(-x)*3.2)-(-y)*(-9.1-t*(-x)/(-x*y-(-6.1*x-y/(-x-y/(-y-x/(-3.5-(-x)/(-x*y-5.3*y/(-x*(-y)*3.1-(-x-1.5)/(-5.1-(-x)*2.1-y*3.2-t*2.1))))))))))

//(-(-x-y/(-x)*3.2)-(-y)*(-9.1-t*(-(-1.5/(-x/y*t*(-x-4.1)/(-x/(-y)-(-(-x*y*(-y-2.5/(-x))*(-2.7/(-x*3.1-y*2.1+t-2.9))))))))/(-x*y-(-6.1*x-y/(-x-y/(-y-x/(-3.5-(-x)/(-x*y-5.3*y/(-x*(-y)*3.1-(-x-1.5)/(-5.1-(-x)*2.1-y*3.2-t*2.1))))))))))
//-(-x*a/(-b+x)*y*(-t)*(-1.5)/(4.7)+(-c/(-2.3)*(-d)*a+1.7/a*b/(-d+c*1.7))*x/(-c-y*(-a)))*(-1.5*x+y/(-a)-t/b+3.5*a/1.7/b/(-c)/(-1.5))*(-c-(-(x*(-1.5)-c/5.1)*(-1.2*c-d/(-1.7+4.8*b))))/(x/a+y/(-3.5)-(-b)*t-(-1.5)*(-a))*(-1.9/(-a/(-b*4.5-c/(-1.7/7.1-5.1*(c-b*(-2.4))))))*((-x)*t*3.2*(-7.3)*(-a)/(-b)/(1.5*x-(-y)*(-c)-b/(-c))*(-b/(-y/(-x*a))+x*(-2.3)/(-3.7/(-x/(c-d/3.2))))-c*(-b/(-3.5*b)-a*(2.1-a*b*(-c))))


//(((-x*(-a)-(-b)*(-1.5))*(-y/(-b)-c*1.2)*(-c*(-3.5)-(-b)*t)/(-c/(-a)+x/(-b)*(-y)/b*t)/(-x*(-b)-c)/(-1.5-(-y)*(-a)))/(-(-(-x)*y*(-a)*t-a*b)*(-(-x)/(-b)*(-t)-a/(-1.5))*(-(-x)*a-b)*(-(-b)*(-1.5)*(-x)-1.5)*(-x)*(-y)*t/(-(-x)*a-(-b)*(-y)+(-t)/(-c)-b)/(-y*(-a)-(-b*3.1))))*(((-t*(-b)-c)/(-1.5-(-x)*(-b))*(-a-(-b)*(-x))/(-3.7-x/(-b))*(-a*(-b)/(-1.5-c)*(-x)*y/(-b)*t*(-a/b)+b))/((-1.5)*x*(-y)/(-b)*t*(-x)*y*(-t)/(-1.5-(-x)-(-a))*(-b-(-x)/(1.7))*(-c-(-x)*(-5.1))/(-a*(-x)+5.6-b*(-y)-t*c-7.5/(-b))*(-x*(-a)-y/(-5.3)-7.5-(-c)-(-b)/(-4.3)-t*c/b)/(c*y/(-t)*x/(-1-x)*(-7.3)-b/c)))

// ((k*x-y*m)*j/y-k/(k/a-b/j))/(-2.12-k)/(3.18*m-k*3.97-3.91/j-m/2.97)+(x/k*a/y*m/b-(b*k-m*a)/x-y/(x/(k-a)-(b-m)/y+(m+c)*(b+k)*x/(y-a*k/x)))-(x-y*a)/m

// (a*x/b*y/d-c/x+y/b-c/d*y/x*(c-x)/(y-b)/(b*a-x))*((-x/(c/a-y/x)+b/(y/x/a+b/c))/(-a*x-y*b-c+b/c)-y*(a+y)*(x+b)/(-a-x-b+y))
//((-x*y/(-t)*2.1*(-x-1.5)*(-2.5-2.1*x)*(-(-x)*(-1.7)-3.5)*(-y*(-2.5)-1.5)/(-(-x)*2.5-y*2.5+t*2.1-7.7)*x/(-5.7-x*1.5*(-y)*t))*(-x)/(-y)*(-5.1-x))/((-(-x-y/(-x)*3.2)-(-y)*(-9.1-t*(-x)/(-x*y-(-6.1*x-y/(-x-y/(-y-x/(-3.5-(-x)/(-x*y-5.3*y/(-x*(-y)*3.1-(-x-1.5)/(-5.1-(-x)*2.1-y*3.2-t*2.1)))))))))))/((-(-x-y/(-x)*3.2)-(-y)*(-9.1-t*(-(-1.5/(-x/y*t*(-x-4.1)/(-x/(-y)-(-(-x*y*(-y-2.5/(-x))*(-2.7/(-x*3.1-y*2.1+t-2.9))))))))/(-x*y-(-6.1*x-y/(-x-y/(-y-x/(-3.5-(-x)/(-x*y-5.3*y/(-x*(-y)*3.1-(-x-1.5)/(-5.1-(-x)*2.1-y*3.2-t*2.1)))))))))))
//-(-(-1.5-(-3.4-(-(-1.7*a/6.3/(b-1-(-c-5.7*a*b/c-x))))))-a*(-b/(c+3.4)*1.4*x))*(-a*(b-c/3.5)*x*(a+b/5.2*(-7.8)*y-c*(-c-4.5*(-d))))-(-(-a*(-b-1.5)*(-5.8))*x-(-2.6/(-7.8)/(c-d))-c/7.1*(-d)*(1-(-6.7/(-c-2.5))))*(-(-1.7-(-x-(-(-4.5)/(-a-b/c/7.5/(-7.1)/(-b)*x*(-y)-(-c)/(-d-1.5*a))))))+(-x-(-(-(-a)-(-1.7)-(-c-d/(-c))))*(-x)-(-a)*(-7.5)/(-c)*x-(-b)/(-x))*(-a*(-b)*(-y)*x-(-4.7*c/d)/(-y)*(-x))*(2.1*a-(-4.7/b)*(-c-x)+a/b*c/d*(-4.3)-b/(-9.8)*(a+6.5)-x)
//-((-(-a)-b)-2-c)*d*((-(-c))-d)*(-((-(-d-c))))*(-(-2-a))-((-a)/(-b*2)-3/(-c)-4)*(-(2*(-c)*(-d*3*c/(-a-1/d*a*3-d-3*(-c/(-1-b*a*b*3*4/a/b/4-5))))))-(-(-2-b/3/4/a)-a-3+a*(a-b*2*c-(-d)*2-b)*(-a/(-a-b-1)*c))/((-(b)))*(-(a+b)/(-c)+2*c-b-(-b*d*3*4/c/(-5)))
//-1/(-a/(-x)-(-x/(-b*(-c)*y-d)))-(-(-2*(a*(-b*c-d*2/c/(-a))*(-x*(-a*(-x)-b)*y*(-d-3)))))-(-(-(-a-x)-(-x*(-c)*(-2)-b*(-c)/2/(-a))))-(-(-a*(-b*c-d)*2*(2*(-b)*x-c*3)*(-(3*(-y)-(-b)*2))))+(-(-x*2*(-y)*(-b))*(-(-x)*(-y)*(-a)*(-a-(-b))*2*(-c)*(-(-x/(-x/(a-b*c/(-x))-a*(-b-x)/(c/(-x)-b))))*(-x*(-a/(-x*(-y)*a/b*(-c*(-x)-d)-2*c/x)-(a*(-x)-y*(-b-c)*((-y*a-b/(-c))/(-x+b-c/(-d*2+3))))))/c/d/(-b)/(-c-(-b))))
//-1/(-a/(-x)-(-x/(-b*(-c)*y-d)))-(-(-2*(a*(-b*c-d*2/c/(-a))*(-x*(-a*(-x)-b)*y*(-d-3)))))-(-(-(-a-x)-(-x*(-c)*(-2)-b*(-c)/2/(-a))))-(-(-a*(-b*c-d)*2*(2*(-b)*x-c*3)*(-(3*(-y)-(-b)*2))))+(-(-x*2*(-y)*(-b))*(-(-x)*(-y)*(-a)*(-a-(-b))*2*(-c)*(-(-x/(-x/(a-b*c/(-x))-a*(-b-x)/(c/(-x)-b))))*(-x*(-a/(-x*(-y)*a/b*(-c*(-x)-d)-2*c/x)-(a*(-x)-y*(-b-c)*((-y*a-b/(-c))/(-x+b-c/(-d*2+3))))))/c/d/(-b)/(-c-(-b)/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b*(-x/(2*(-c)*d*(-c+d)*(d+(-b))/3/(-a)/(-(-a-(-(-(-b-c)-d))))*(-a-x*(-b))*(-y*b*(c-1)-c)+(-a)*b))))))
//-(-(-x-(-2*(-x/(-y*(-2)*(-2+(-x*(-x*2-y/(-2/x-x/2-1-y))))*x*(-2*x*y-1))))))-(-2/(-x-y-1)*(2*x-(-3)*x-(-y)*2)*(-1/(-x)-y/(-x-y-1))/x/(-1-x-y/x)-x-y+1)+(-x/(2*x-1/(-x))*(-y/x-2*x-1)/(-x*(-2)*y-5)*(-x-2*y-1)/(-x-y-1)*x/y-(-x/(-2/(-x/(-1-x*y-2-x/y))-5-(-x-x/(2/y)-7)/(-x)-1-x-2*(-x))))
//(-(-x*y+1)-5)*(-(-(-x-1.5-y)))*((-(-x*2.1*y/1.7*t+1.7-3.5)))*(((3.5*(-x)*(y)*(-(-t))/2.5-(-2.7))))*(-(-x)+(-y)*2.5-(-x)*5.7-1.3*(-(-(-y))))
//1-(-x-(-x*y-a)-(-(-3-5*x*t)*(-(-(1-(-(-x*y+2)*(3-x*y)*(-5-x*y)*(-x*y-7)))))))-x*y*a-x*(-x+c)*b*(-2*x*y-b)
//-(-(-x-a)-((-x)*(-(a)))-a*2/c*x/y*(-y)/(-x)*(a*x*b+c-d)/(2*x*y+b*2))-(-((-x)-y)-(-(-x-(-y)-a))-b*(-x)*(-a-b-2))/(-a/b/x)+(-x)*(-(-x*(-(-y*x*(a*x*y+b)*(a*x*y+b)*(-x-1)*(y+x*2)))))-(-(-x*y*(x*a*b+3)*(-x*y-c*b*2)/(2*x*y+b*c)*(2*a-x)*a*2/3/b*(b+1)))
//-(-a*b*(-c)-x-(-1-y))/(-x*a*(-a-x*y/b)*(-b-x/c)*(-1-y/2*3/b)*x*y/a/(2*c/b-x*y*c*d/3/b))*(a-x*y/b-b*x*y-y*b-a/(-b)-b*x/(-c)*2/3-b*x*y/3/(b-a)-c*x-b*y-c/(-b)/2*(-a-b)*x-y*(b-c/2)/a/b-(-y)*a-x*(-(-b))+x*(a-d/c/y-(-(-(-y)/(-x))))-x/(a*x*y+b-c+2))-x*y*(-x*(-y)-x*(y*x-(-(-x-y-2*x*(-b)-(-x)*y*(-y)-a/x-(-(-a-x*y/c))))))/(-b-x*y)*(-a-b*c)*y*(-2-x/3)*(x*(-y-b-3*(-b/(x*a-b*2*(-c)*x*b-c*x-2*y)-c-x-2-y*2)*c*(-(-d-x/(-b-y))))+x*y/(a*x-y*b-c-1))
//-((-y)/x-(-a)*y-(-x-y))-(-y-(-2-x/(-y*x-x*a-b/y*(-x*(-y)*(a*x-b/(-y)*x*c-c-x)-x/y)+c/x-d/x-y/(c*x))+x*(-y-x*a-b)*c/(y+x*y-(-c*y))-y*(-2-x)-(-(-x-5-y))-3)-4/y*(-(-(-7-(-x))/y-5)-y)+x)
//x*y*(2*x+1)*(2*x*y/t-2*x*(3*t-1)/(2*x-3*y-4)*(x/(3*x-1)-4/x+5*(2*x*y*t-1)/(y+1)-7*(2*x*(y+1)*(3*y+2)*(3/(x+1)-2*t/(2*x*y*t-1)+(4*x-1)*(5*y-7)/(x-2*y-1-2*t/(3-7*x-8*y*(4*x/(2*t+1)-7*x-8/t+9*(2*x-1)*(3*x+4*y+5)*(2*x*y*t-7)*x*y*t/(x-y*2-3/(x/(t-1)-7/(y+2)+8/(2*x*y*t+1)-9)))))/(x-1)))))
//-(-1/a*b-c/x*(1-d)*(-a)-b/c/d/(x-c/(-d)*(-x*2)*(-y*(-2)/(-c)/d/x)-x/2/a))*(-2/a/x*y*3*d*(d+c)*(x+a)*(y+(-a))*(a+1)*(2/d-c))+a/c*d*2/3*x*(-2)*(-a)*(-a-b)*(-x)/(-x-a*x*y*(x/(x*a-y*b-c)*2/c-c/(-d-1)))
//(2*x-(-x/(-y-1)-y)-(-(-1-y))-y/(-x-y-2*(-x/y-3)))*(-(-1-x-(-(-x-(-1-2/y))/(x*y-2/x*(2+x)*(2*x+3*y-4)*y/(2*x+3*y+4))-x/(x+3*y-4))*x*y)*(2*x+1)*(3*y+2)*y*x)-(-2/x)*x*y*(2*x+y-1)*(-y/(-x/y-(-y/(-x/y-1))*(x*y*2-1))-x)
//c*y*(a*y*(b*y+c+d*y*(c*y+e))+(d*y+a)*c+c*y+e)*(a*y+b)*(c*y+d*(c*y+a)+d)*(a+c*y*(d*y+c+y+(c*y+e)*c+(e*y+d)*b)+c*y+d)+d*y+e*y*(a*y+c+y)+y+c*y*(a*y+b)*(c*y+d)*(d*y+e)+d*(c*y+(b*y+c)+(d*y+e)+a)+b
//c/x/(a/x/(x/b-c)-(x/d-a)-x/c-e)/(x/a-b)/(x/c-d)/(a-x/c/(x/d-c-x-(x/c-e)/c)-x/c-d)-x/d-e
//((c/x/(a/x/(x*b-c)-(x*d-a)-x*c-e)/(x*a-b)/(x*c-d)/(a-x*c/(x*d-c-x-(x*c-e)*c)-x*c-d)-x*d-e)/(c*x-d)-(x/(a*x-c-1)+(a*x-b)/x)/(c*x-d)+x/(c-x/(a*x+b)-(c*x-d)/x+(a*x-b)/(b*x-c)))*(a*x+b)/(c*x+d)+b*x*(c*x+d)/(a*x+d)-c*(c*x+d)*(b*x-a)/x+b
//c*x*(a*x*(b*x-c-d*x*(c*x-e))-(d*x-a)*c-c*x-e)*(a*x-b)*(c*x-d*(c*x-a)-d)*(a-c*x*(d*x-c-x-(c*x-e)*c-(e*x-d)*b)-c*x-d)-d*x-e*x*(a*x-c-x)-x-c*x*(a*x-b)*(c*x-d)*(d*x-e)-d*(c*x-(b*x-c)-(d*x-e)-a)-b
//(((2*x+3)*(3*y+4)+(3*x-5)/(4*y+6)+x*(4*y-5))*(3*x-4)+(2*x+3)*(((3*x-4)/(3*y+5)+5*x/(2*x-5)-7*y*(3*y+5)+7)/(3*x+4)-5/x-7/y))/(((3*x-4)*(4*y-5)*(5*y-7)*x-(3*x-8)*(2*y-9)/(3*x+4)+5/x-7)*(2*x-3)*(3*y+4)+x*(3*x-4)*(3*y+4)+5/x+7)+(3*x-5)*(5*y+6)/x+y*(3*x+5)/(5*x-6)+7
//(2*x*(2*t-1)/(3-x)-t-x/t/(7-y))*(3/x-t-3+(y*(x-1)-t*(5-x/t-7*(8*x-1)/(t*2/y+1))))-(2*x-x*y*t/(6*x-1)-t*(4-y)+2-5/x*(x-t*(3-x))*(x*y/(x+1)/(t-1)-2/y*(y-t))-x*y*t*(3/t+1)/(5*y/x-1))
//x*y-y*(x*y-x*y*(x*y-(x*y+(x*y-x*(x*y-x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y)))))*y)*y))
//(-x*a-b)*(-a*x*y-b)*(-2*x-c)/(a*x*y-b)-x*y*c*(-a*x-b*y-c)*(-x-b)*(-d*y-b)/(-a*x*y-b)
//x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y-(x*y+(x*y-(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y-(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y+(x*y+(x*y+(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x+(x*y+x*y+(x*y-(x*y-(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1))))))-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))
//(a*x*y+t-b*x)*(c*(t/x+x/y*(c*x+y-t*(c+y*x*t/d+(y-x)/t)))-x/(x-b*t*y-d/(a*x*y*t-c)+a/x+b/y+c/t-e/(x*y*t))+b)
//a*x*(b/(c*c-d)+e*x*(c*(d*x*((a*x+b)-(b*x-c))-x/((x/b-c)*c+(x/d+a)*x+c)+(a*x+b)-(b*x+c)+(c*x+d)*e*x)/(a*(b*(c*(d*(e*x-a)*(x+b)+(c*x-d)*x*a)+c*x+d)+e)/(x-d))*(x/c-d)*a*x))
//-(-(-a)*(-x)*(-y)*t-b+(-c))*(-x*(-y)*t*(-a)-b)/(-b-y/(-x)*(-t)*a)-(-x)*(-y)*a*(-a-(-a*(-x)*y*(-t)-b)*(-x)-(-a)*(a-c*(-x)-b*y))
//((-2*3)*x+(-2)*y/3-t*(-11.5)-(-4)*(-5)*(-1.2))*(-(-2)*x-y/(-1.5)-(-1.7)*t-(-(-5)))*(-(-1.5)*x-(-(-1.9))*y-t/(-(-(-1.7)))-3)*(-(-2)*x*(-y)/(-(-(-1.7)))*t-(-(-5.3)))*(-(-x)/(-(-(-7.5)))*(-(-(-y)))*(-t)*(-(-(-9.9)))-1)
//(3*x*y*t-5)*(x*y*(2*x-1)/(2*y+1)/(2*x*y-1)-x*y/(2*x-4*y+5*t+4)*(2*x*y+1)-y*(-x-x*y*t*(2*x*y*t+1)/(2*x*y*t-1)*(2*x+3*y-4*t-5)*(2*x+2)/t))-x/(x/(2*x+1)+y/(2*x-1)+t/(2*x*y+1)-x*(-y/(2*x+3*y-1))*(-x/(2*x*y-t/(2*x+3))))
//-(-a*1.5/(-b*2.7/(c/(-x-1.5*a/(-b*1.5+c)+x*(-1.9-a)*b*3.1)))-2.1*a/3.5/c/(c-1.5)+x*(-a)*(-5.1)*y*(-a*x-3.5*b*y*3.5-d/c/5.2))*(-2.1*sin(-6.5*x-a*b-5.3)/7.8+2.5/cos(2.5*(-a)*x/(x-a*y)*(-3.1)*y*(1.5/x/a/c/(-c-7.1/d/(-c/a-5.7/(-3.1*(-a*x)))))))/(-2.1-a*3.2/(-x/(-d/c*a/(-a*2.1/x*c+x/(-a)-y*(-x)*(-a*4.5/(-x)))))-c*2.9*(-d)*(-3.5*c-d)*sin(-x-a-(-b-(-1.7-(-x/(-1.7-d/c))))))


//x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y-(x*y+(x*y-(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y-(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y+(x*y+(x*y+(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x+(x*y+x*y+(x*y-(x*y-(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)
//-(x/(2/x-x/(-t))*t*(-x*2+1)-(-(-x*(2*x*y/(-1-x))*(x*y*t/(2*x*y/t-1/(-x)))/(-1/x/(-2/x-(-1-t-(-x)*(-y)/(-x/(-t/(x-1/y*(2*t/y*x+(x*2*y*(-3)*(-x)/(-1-x-y))))))))))))+x*t*(-1/(-x-1/(-y-1/x)))*x/(-x-(-1-(-x/(-y-(x*2-1)*(-1+x*5*y*t)*x/t))))*(-x);
//x*((y/x+x/y)/(x/y-y/x)+x/y+y*x/(x/y+x/(x*y+x*y/(x+y)))-x/(x*(x*y+x/y)*y))+(y/(x+y/x)+x/(y+x/y))/(x*(x+y/x)*(y+x/y))-y/(x+x/(x*y+x*y/(x+y)))+x*(x/(x/y+x/(x*y+x*y/(x+y)))+y/(x/y+y/x)+x/(x*((y/x+x/y)/(x/y-y/x)+x/y+y*x/(x/y+x/(x*y+x*y/(x+y)))-x/(x*(x*y+x/y)*y))+(y/(x+y/x)+x/(y+x/y))/(x*(x+y/x)*(y+x/y))-y/(x+x/(x*y+x*y/(x+y)))+x*(x/(x/y+x/(x*y+x*y/(x+y)))+y/(x/y+y/x))));
//(2*x*(2*t-1)/(3-x)-t-x/t/(7-y))*(3/x-t-3+(y*(x-1)-t*(5-x/t-7*(8*x-1)/(t*2/y+1))))-(2*x-x*y*t/(6*x-1)-t*(4-y)+2-5/x*(x-t*(3-x))*(x*y/(x+1)/(t-1)-2/y*(y-t))-x*y*t*(3/t+1)/(5*y/x-1))
//(2*x*(2*t-1)/(3-x)-t-x/t/(7-y))*(3/x-t-3+(y*(x-1)-t*(5-x/t-7*(8*x-1)/(t*2/y+1))))-(2*x-x*y*t/(6*x-1)-t*(4-y)+2-5/x*(x-t*(3-x))*(x*y/(x+1)/(t-1-(2*x*(2*t-1)/(3-x)-t-x/t/(7-y))*(3/x-t-3+(y*(x-1)-t*(5-x/t-7*(8*x-1)/(t*2/y+1))))-(2*x-x*y*t/(6*x-1)-t*(4-y)+2-5/x*(x-t*(3-x))*(x*y/(x+1)/(t-1)-2/y*(y-t))-x*y*t*(3/t+1)/(5*y/x-1)))-2/y*(y-t))-x*y*t*(3/t+1)/(5*y/x-1))
//x*y*(x-t*(2*x-3*y-5)/(t*x*y/(2-x*y)+(2*x+3)*(3*y-4*t-5)-(1-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2*x-3*y-t))-y*(x*y-y*t*3+2*(x/t-t/(x-y*(2-x-y-t)))*(y-t)-2*x)*(y-x)-7/x)*(-1/t+x*y*t*5))-3*x-5)-7*y-3)/(x-t)+x*(t*y/(x-2*t)-y*(x*(t-2*y-x-5)-y*(-1-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5/y-x*y*(2*x-1)*(t*y*3-5)*(1-x*y*t*3)*(x+y*(t-(-x-y*t/(x*y-2*(x*y*(x-y*(x*t+y/t*(2*x-1-t*y)))))))))))))
//x*y/(-x/(x/(y-t/(x*y-t*x)-x/(y+t))+y/(x*t-y/(x+y))+x*y*(x-y)*(x/y-t/x))+x*(x/(y-t))*y*(x*y+x*t))*(x*y+x-y-x/(x-y/x))
//-(-1/x-x*(x*t-t/(y-t/(-x)))/(-x-y/x)*(-x/y-y/(1-t/(y-x)))-y/(t-y*(t*y-x*(y-t/x)))/(-x-t/(-x-t/(x-y/t))))*(y-(-x-(-x*y*(-t)-t/(x-y-t-1/x)))/(x-y/t-t)-t/(x-y/(-t-x/(-y-x/(-y/x-x/y-t/(x-y/t))))))/(-x*(-t)*(-y)/(x-y+t)-y/(-x/(-t+y/(-x*y))))


{
-(-(-x-a)-((-x)*(-(a)))-a*2/c*x/y*(-y)/(-x)*(a*x*b+c-d)/(2*x*y+b*2))-(-((-x)-y)-(-(-x-(-y)-a))-b*(-x)*(-a-b-2))/(-a/b/x)+(-x)*(-(-x*(-(-y*x*(a*x*y+b)*(a*x*y+b)*(-x-1)*(y+x*2)))))-(-(-x*y*(x*a*b+3)*(-x*y-c*b*2)/(2*x*y+b*c)*(2*a-x)*a*2/3/b*(b+1)));
-(-a*b*(-c)-x-(-1-y))/(-x*a*(-a-x*y/b)*(-b-x/c)*(-1-y/2*3/b)*x*y/a/(2*c/b-x*y*c*d/3/b))*(a-x*y/b-b*x*y-y*b-a/(-b)-b*x/(-c)*2/3-b*x*y/3/(b-a)-c*x-b*y-c/(-b)/2*(-a-b)*x-y*(b-c/2)/a/b-(-y)*a-x*(-(-b))+x*(a-d/c/y-(-(-(-y)/(-x))))-x/(a*x*y+b-c+2))-x*y*(-x*(-y)-x*(y*x-(-(-x-y-2*x*(-b)-(-x)*y*(-y)-a/x-(-(-a-x*y/c))))))/(-b-x*y)*(-a-b*c)*y*(-2-x/3)*(x*(-y-b-3*(-b/(x*a-b*2*(-c)*x*b-c*x-2*y)-c-x-2-y*2)*c*(-(-d-x/(-b-y))))+x*y/(a*x-y*b-c-1));
-((-y)/x-(-a)*y-(-x-y))-(-y-(-2-x/(-y*x-x*a-b/y*(-x*(-y)*(a*x-b/(-y)*x*c-c-x)-x/y)+c/x-d/x-y/(c*x))+x*(-y-x*a-b)*c/(y+x*y-(-c*y))-y*(-2-x)-(-(-x-5-y))-3)-4/y*(-(-(-7-(-x))/y-5)-y)+x);
-(-1/a*b-c/x*(1-d)*(-a)-b/c/d/(x-c/(-d)*(-x*2)*(-y*(-2)/(-c)/d/x)-x/2/a))*(-2/a/x*y*3*d*(d+c)*(x+a)*(y+(-a))*(a+1)*(2/d-c))+a/c*d*2/3*x*(-2)*(-a)*(-a-b)*(-x)/(-x-a*x*y*(x/(x*a-y*b-c)*2/c-c/(-d-1)));
(2*x-(-x/(-y-1)-y)-(-(-1-y))-y/(-x-y-2*(-x/y-3)))*(-(-1-x-(-(-x-(-1-2/y))/(x*y-2/x*(2+x)*(2*x+3*y-4)*y/(2*x+3*y+4))-x/(x+3*y-4))*x*y)*(2*x+1)*(3*y+2)*y*x)-(-2/x)*x*y*(2*x+y-1)*(-y/(-x/y-(-y/(-x/y-1))*(x*y*2-1))-x) ;
(-x/(-y/(-t-y/(-x*2.1/(-3.1*x*y-2.7*t)-y*x/(-x-(-t*1.5/(-y*3.7/(-x)-y/t)-t/(2.7-x*y/(-x))-3.7/x)-4.5/(-y/(-x-y/(t/x-x/(-y))-t/(x-6.5/(-y)))-x*(-y*2.7-t/x)/(7.5-x*y))-y*x*(y-t/x)/(-t/(-x)-4.5))-5.1/(-x-y/t))-2.5/x/y/(-t/x-y/t))-4.5*x/y/(-2.8/t)/(-x/(-y)))-(-x-3.1)/(-2.5-y)/(-t-x/(-y))/(-x-y))/(-x*3.5*y/t*(-7.1/(-x+y/(-x))*(y*x-t/y))/(-x-y-t/(-x-y/1.9)));
-(-(-1.5-(-3.4-(-(-1.7*a/6.3/(b-1-(-c-5.7*a*b/c-x-y/(-x/(-a*c/(-b*y-c*y/(-y/(-a)/b/(-y/(-x*a/b/(c-b/d/y-(-x)/(-b)/(-a-c/d/(-b)*(-y)))))-c*(-b)/(-d/(-a-x/y))))))))))))-a*(-b/(c+3.4)*1.4*x))*(-a*(b-c/3.5)*x*(a+b/5.2*(-7.8)*y-c*(-c-4.5*(-d))))-(-(-a*(-b-1.5)*(-5.8))*x-(-2.6/(-7.8)/(c-d))-c/7.1*(-d)*(1-(-6.7/(-c-2.5))))*(-(-1.7-(-x-(-(-4.5)/(-a-b/c/7.5/(-7.1)/(-b)*x*(-y)-(-c)/(-d-1.5*a))))))+(-x-(-(-(-a)-(-1.7)-(-c-d/(-c))))*(-x)-(-a)*(-7.5)/(-c)*x-(-b)/(-x))*(-a*(-b)*(-y)*x-(-4.7*c/d)/(-y)*(-x))*(2.1*a-(-4.7/b)*(-c-x)/b*(-b/x-y/(-c)-y/(-c-b/(-c/x-b*c/y/a*(a*b-c/d)/(-x/y/(-a)-y/x/b))))+a/b*c/d*(-4.3)-b/(-9.8)*(a+6.5)/y-x);


}

{

 x*y*t*(t*x*(x*y-t*x)-x*y*(x*t-y*t)+y*x*(y*x-t*y)-(x+y)*(x-y)*(t-y)*(x*y-t*x*(x-y*(t-x*(t-x)*(x-t)*(t-y)-x*y-y))))-(x*t*y*(x*y-x*(y-y*(t-t*(x-x*t*(x*y-t*x-(x*y-t*x)*(x-y)*(y-t)*(t-y)-(x+t*y)*(y-x*t)+(t-y*t)*(y-t*x))))))) ;
 -x/(x/y-t/(x+t)+x*y*(x*y-y*t+x/(x/(x+y)+y/(t+x))))*(y*(x-y/(x*y-y/(x*y+y*t)*(y*t-x*y)))+x-y*(x-t-t/(x-y)*(y/(y-t*(x+y*t)*(y-x*t)/(x*t-y*(x+t))))))*(x*y-t*y-t*(x*t-y*(t-x)/(x*y*t-x-y-t)));
 x*y*(2.111*x+1)*(2.211*x*y/t-2.311*x*(3.422*t-1)/(2.511*x-3.611*y-4.22)*(x/(3.711*x-1)-4.111/x+5.111*(2.611*x*y*t-1.23)/(y+1.12)-7.132*(2.812*x*(y+1.123)*(3.832*y+2.121)*(3.112/(x+1.123)-2.133*t))));
 x*y*(x-t*(2.123*x-3.222*y-5.323)/(t*x*y/(2.234-x*y)+(2.455*x+3.632)*(3.734*y-4.832*t-5.923)-(1.134-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.745*x-3.345*y-t))-y*(x*y-y*t*3.167+2.965*(x/t-t/(x-y*(2.467-x-y-t)))*(y-t)-2.376*x)*(y-x)-7.154/x)*(-1.943/t+x*y*t*5.334))-3.556*x-5.657)-7.243*y-3.459)/(x-t)+x*(t*y/(x-2.834*t)-y*(x*(t-2.756*y-x-5.676))));
 (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t)-t*(-x-y*(-t*(-x*(y-t))))))))))));
 x*y-x/(x/y-t/y-(-x-y*(x*y-t*x/(x/y-t/y-(-x-(-y-(-t-(x*y-y*(-x*y-y/(x+y*t)))*x)*y)/(x+y*t)-x*(y/t-(-y*x/(x-y*t)-(-x-(-y/(-x*y*(-x-y))+x/y*(y*x+y*t-x/(x+y*t))-x*y*(x*y+(-x*y-t/y+x-y*x)))))+x*y*t*(x+y*t)))))));
 x*y*(x-t*(2.154*x-3.253*y-5.353)/(t*x*y/(2.544-x*y)+(2.143*x+3.556)*(3.343*y-4.153*t-5.456)-(1.153-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.644*x-3.364*y-t))-y*(x*y-y*t*3.164+2.267*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.535/x)*(-1.253/t+x*y*t*5.353))-3.433*x-5.455)-7.466*y-3.577)/(x-t)+x*(t*y/(x-2.699*t)-y*(x*(t-2.767*y-x-5.854)-y*(-1.549-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.344/y-x*y*(2.435*x-1.456)*(t*y*3.326-5.347)*(1.943-x*y*t*3.245)*(x+y))))));
 (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t*(x-y*(t-x*y-y*(x*y-t*x)-t*(t*x+y))))-t*(-x-y*(-t*(-x*(y-t*(x*y*t-y*x*t*(-x*(y*x-t*y-x-y-t)))))))))))))));
 (x*y+t/(x*y-y*t/x-x+y-t))*(x+y+t)/(x-y-t)*(t-x*(t-y/(x-y-t)))*x/y*t-x*t*(x*t-y*t+x-t)/(y*x+t*x+t/y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y/(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t/(x-y*(t-x*y-y/(x*y-t*x)-t/(t/x+y))))-t*(-x-y*(-t/(-x*(y-t*(x*y/t-y*x*t/(-x*(y*x-t*y-x-y-t)))))))))))))));
 x*y*(x-t*(2.156*x-3.652*y-5.653)/(t*x*y/(2.664-x*y)+(2.155*x+3.543)*(3.345*y-4.431*t-5.443)-(1.451-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.453*x-3.353*y-t))-y*(x*y-y*t*3.153+2.253*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.553/x)*(-1.253/t+x*y*t*5.533))-3.453*x-5.453)-7.453*y-3.553)/(x-t)+x*(t*y/(x-2.653*t)-y*(x*(t-2.753*y-x-5.853)-y*(-1.539-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.553/y-x*y*(2.535*x-1.53)*(t*y*3.536-5.753)*(1.539-x*y*t*3.665)*(x+y*(t-(-x-y*t/(x*y-2.863*(x*y*(x-y*(x*t+y/t*(2.623*x-1.352-t*y)))))))))))));
 x*y*(2.251*x+1)*(2.243*x*y/t-2.353*x*(3.475*t-1)/(2.575*x-3.675*y-4.766)*(x/(3.767*x-1)-4.176/x+5.186*(2.866*x*y*t-1.766)/(y+1.876)-7.165*(2.874*x*(y+1.641)*(3.864*y+2.162)*(3.171/(x+1.765)-2.173*t/(2.174*x*y*t-1.171)+(4.171*x-1.164)*(5.172*y-7.174)/(x-2.175*y-1.747-2.174*t/(3.618-7.716*x-8.181*y*(4.612*x/(2.189*t+1.165)-7.198*x-8.149/t+9.912*(2.199*x-1.261)*(3.107*x+4.179*y+5.108)*(2.271*x*y*t-7.179)*x*y*t/(x-y*2.282-3.621/(x/(t-1.147)-7.198/(y+2.245)+8.233/(2.288*x*y*t+1.247)-9.174)))))/(x-1.525)))));

}


{
 x*(y*(t+r)+t*(y+r)+r*(y+t))+y*(x*(t+r)+t*(x+r)+r*(x+t))+t*(y*(x+r)+x*(y+r)+r*(y+x))+r*(y*(x+t)+x*(y+t)+t*(y+x))+x*y*(r+t)+x*r*(t+y)+y*t*(x+r)+y*r*(x+t)+x*t*(y+r)+r*t*(x+y)

9*(r*t*x + r*t*y + r*x*y + t*x *y)

}

//------------------------------------------------------------------------------




//*****************************************TEST*********************************
//*****************************************COMPLEX******************************


// ***************************************CONST*********************************


//
{
 ((a*bi+bi*c-2*ci-di*5)/(2/ai-bi/a+c/di-ci/5)-(i-5)*(i+ai*b/ci)*(-ci/di/5/i/b+3i*a/bi*5-7i+b/c+d)/(bi/(ai-b)/c-b*(c-di)/di+bi*(-4i-b-di*i-i/ai+i*(bi-c/i+bi/i+5/i))*d-d*(a*i-b-4+i)*ci-di/(a*b-c/2)/b-ai/(2i-c/di)/c))*((i/a+b*ai))
}

// x*(2+3i)-(3-5i)*z1+7i*y-8i*z2-(4-2i)*(x+y)-(7-3i)*(z1+z2)+3i*(x-y)-7i*(z3-z1)

//  ((9*i+1)*(-i-x/i)*(-i)/((i-y*2)/i-i*(t-i)-(i+x)*i)-x*i*y*(t+i)*(t-i)*(-i-(-(x*i-i/y-t/i-2/i+i/5-3+i*t)/i-i)*(i+i/(i/x-i/y))))*(i*(2*x+y)-(2*t-y)*i-i/(-x-(-1-y)/t)-(y/t-y/x)/i)/(2*i-3*i*(i-x/(x-y))*(i+y/(y+x))*(t/(y-t)+i)*(y/(t+x)-i))

 //    x*y*(a*i-b*(i-x)*(y+i)*(x/i-i/y-a*i-i*b-2.5*(x*y-a*x-y*b)/i)/(-i*3.7*(2*x-3*y/x+a*(b-c-3.1*(b*c-5.5)))-2.3*x/y-i/(-a-i-i*c-3.2-2.7*(-2*i-x*2.7+y*3.9/((2.3-i)*(i-3.1*x))))))

 //  (-i*2.3-9.1*i/((i-2.5)*(1.7-i))+x*i/((i+2.7)*(3.5+i))-a*y/((i/3.1-4.5*i)*(2.5/i-i*2.9)))*(-2.5-i/x-y*i/(-i/((a/i-i/b-x/(i/x-x/(y-i*x/(-a-2.1*i/c))))*(x*a*y-i/1.7+a*(-b-i/(y-i/x+x/(i-a)))))-3.1*x/(2.7*(2.3-i-a*3.2*(x*a/i-y*x/(2.5/(i/(x+b*y*i)-(x/y-3.7*x/(y*1.2-x*3.1-i)))-5.7/(-x*a+y*b+6.7))))-7.5/(2.5*i-((i*x-y/i*3.1-i/(-x/(-2.5*a-b/i)))/7.5-2.1*(-y/x*(-a/(b/x-y*c/(-x+i)))+y*(-i/3.1-2.5*(-i/(y-i/x)+2.7*i/(a*x-y*2.1*b-c+3.5)))))/5.1))))/((-x*y*2.5-y/a-i/x+(x*y*(a*i-b*(i-x)*(y+i)*(x/i-i/y-a*i-i*b-2.5*(x*y-a*x-y*b)/i)/(-i*3.7*(2*x-3*y/x+a*(b-c-3.1*(b*c-5.5)))-2.3*x/y-i/(-a-i-i*c-3.2-2.7*(-2*i-x*2.7+y*3.9/((2.3-i)*(i-3.1*x)))))))+x*i*2.7*y/(a+b))+3.5*y/i*a+2.1/(i*x-b))

// (i*(a-b*d) - (a/b+a/c)*i +(b-c/d)/i -i/(d/c-b*a))/(i*(ai*i-i*bi) - (i*2-a/i+i/b)*i +(ai-i)/i -i/(i-bi*a))
// (i*(a-b*d/(-2*a/b+c*d)) - (a/b+a/c*(-c-b/(a+b)))*i +(b-c/d/(-2/(-a)*(-b))-d/(-c/a+d))/i -i/((c-2*b)*d/c-b*a))/(i*(ai*i/(-i/(-ai/i-bi*(-i)+2i-a))-((i-a)/(b-i)+i*a/ai)/i*bi) - (i*2/((a+i)*(b+i)-ai*b*i/c/ci)-a/i+((ai+i)/(i+bi)*(ci-i)/(i-bi))*i/b)*i +((-i/a-b+3i/(-ci/i))/ai-(-i/(a*i-i*b+ci/b-c/bi))*i)/i -i/(i-bi*a/(-i/(-ai-b)*ci/(-bi/(-a)*ci+i*ci))))

// -i*(3i-ai)*(a*i-i/(-Re(i-a/bi*i)/Im(i/bi)*i-re(ai+b*i)*im(ci-d/i)))*(-im(i*(i-5)*(3-i)-i/(-ai)*(-b)*ci/(-bi-b))/i-i/re(-re(-a-i/(-i-bi*(a*3-c/(-b/(-1-c/(d/a+c*b))))/ci/(-ci*i+b*di*i)*(i*5-7i-bi)))*i/(a+bi-3i)-im(a-7i-bi*i))-i*(b/(-b/5-7/(-c+d+3/a)))/ai*b/(-c/i-b*i-bi+i*c-7i)*ci*((re(-ai+bi/(ci-5i))-im(-3i-i*3.5+4.9-7/(-3-bi/ci)))/(2*ci-4*b-(-(-i)*(-a)/(-(-bi-i/(-di)))))))


// ((-x)*ai-i/(-z1/(-i/(-x)-a*i/(-x/(-bi-c/i)))*(-a-ai-x/(-i/bi*c)-z2*bi))+z3*i/(z2/a/bi-i/z2-z3/ci))/(-ai-b/(-x*i-z1/(-y/(-ci-i/z2)))-ci*a*x/(bi*z1/x-y/z2*i)+b*z3*(c-i/ci+c/(-b))-bi/(-z1/(-x)*(-i/(-bi-z2/x*(-a/(-i*b))+c/i)-z1/(-x)-a*x/b-bi/z1*ci/i*b)))
//(i*z1-z2*i+a*z2-z2*b-z3/i-i/z1+ai*z1-z2*bi-ci/z1-z2/di)/(x*z1-z2/y-z3*y)*(z1-x)*(y-z2)*(z1+ai)/((bi-z1)*(z3-ci)-z1*(i/x-z2*(-x/(-i-x/ci*b))))/((c-i-di)/(-z1/y-z2*x/(-y*i-ci/(-x/(-y+ai*z1/(-z2-x-i/y)))))-(-b-di/(-i/x/z2/(-z1/(-x)))/(x*a-y/bi-ci-(i/ci-(bi-c/i/x)/(-z2/x-ci/x/i))*z2)))

//(1):
//-(-(-x-ai)-((-x)*(-(a)))-a*2/ci*x/y*(-y)/(-x)*(a*x*b+c-d)/(2*x*y+bi*2))-(-((-x)-y)-(-(-x-(-y)-ai))-bi*(-x)*(-a-bi-2))/(-a/bi/x)+(-x)*(-(-x*(-(-y*x*(a*x*y+bi)*(ai*x*y+b)*(-x-1-i)*(y+x*2i)))))-(-(-x*y*(x*a*b+3i)*(-x*y-c*b*2)/(2i*x*y+b*c)*(2*ai-x)*a*2/3/b*(b+i)))
//(2):
//-(-a*b*(-ci)-x-(-i-y))/(-x*a*(-a-x*y/bi)*(-bi-x/ci)*(-1-y/2*3i/b)*x*y/a/(2*c/b-x*y*c*d/3i/b))*(a-x*y/bi-b*x*y-y*bi-ai/(-b)-b*x/(-ci)*2/3i-b*x*y/3i/(bi-a)-c*x-b*y-c/(-bi)/2*(-ai-b)*x-y*(bi-ci/2i)/a/bi-(-y)*a-x*(-(-bi))+x*(a-d/ci/y-(-(-(-y)/(-x))))-x/(a*x*y+bi-c+2))-x*y*(-x*(-y)-x*(y*x-(-(-x-y-2*x*(-bi)-(-x)*y*(-y)-a/x-(-(-a-x*y/ci))))))/(-b-x*y)*(-a-bi*c)*y*(-2-x/3)*(x*(-y-b-3i*(-b/(x*ai-b*2*(-ci)*x*b-c*x-2i*y)-c-x-2-y*2)*c*(-(-di-x/(-bi-y))))+x*y/(a*x-y*bi-c-1-i))


//-(-(-x-a)-((-x)*(-(a)))-a*2/c*x/y*(-y)/(-x)*(a*x*b+c-d)/(2*x*y+b*2))-(-((-x)-y)-(-(-x-(-y)-a))-b*(-x)*(-a-b-2))/(-a/b/x)+(-x)*(-(-x*(-(-y*x*(a*x*y+b)*(a*x*y+b)*(-x-1)*(y+x*2)))))-(-(-x*y*(x*a*b+3)*(-x*y-c*b*2)/(2*x*y+b*c)*(2*a-x)*a*2/3/b*(b+1)))
//-(-a*b*(-c)-x-(-1-y))/(-x*a*(-a-x*y/b)*(-b-x/c)*(-1-y/2*3/b)*x*y/a/(2*c/b-x*y*c*d/3/b))*(a-x*y/b-b*x*y-y*b-a/(-b)-b*x/(-c)*2/3-b*x*y/3/(b-a)-c*x-b*y-c/(-b)/2*(-a-b)*x-y*(b-c/2)/a/b-(-y)*a-x*(-(-b))+x*(a-d/c/y-(-(-(-y)/(-x))))-x/(a*x*y+b-c+2))-x*y*(-x*(-y)-x*(y*x-(-(-x-y-2*x*(-b)-(-x)*y*(-y)-a/x-(-(-a-x*y/c))))))/(-b-x*y)*(-a-b*c)*y*(-2-x/3)*(x*(-y-b-3*(-b/(x*a-b*2*(-c)*x*b-c*x-2*y)-c-x-2-y*2)*c*(-(-d-x/(-b-y))))+x*y/(a*x-y*b-c-1))

//1-(-x-(-x*y-a)-(-(-3-5*x*t)*(-(-(1-(-(-x*y+2)*(3-x*y)*(-5-x*y)*(-x*y-7)))))))-x*y*a-x*(-x+c)*b*(-2*x*y-b)

//   ERROR in  (1)    CalcConstOnTree= off , MulDiv,CaclConstOnTree= on/off
// dx2/dy1 ERROR in  (1)  CalcConstOnTree= off ;  CalcConstOnTree= off , MulDiv,CaclConstOnTree= on/off


//-i/(-a/(-x)-(-x/(-bi*(-c)*y-di)))-(-(-2i*(-a*(-a/i-b*ci/z2-d*2i/ci/(-a)/(-3i/(-i-(-x)/(-ai/(-b/y*i*c/x-z1/x*(-z3/(-y-z2/x*(-i-x))))))))*(-x*z2/(-ai*(-x/(-z3/x/y))-bi-ci/x/(-z3/y))*y*(-d-3i-ai*z3)/(-x/i-i/y/(-x/(-bi/y-3i/ci*(y/bi-x*ai/z1))))))))-(-(-(-a-x)-(-x*(-ci)*(-2i)-bi*(-c)/2i/(-a)/z2)))-(-(-a*(-b*c-d)*2*(2*(-b)*x-ci*3/(-y-i/(-z3/(-x-ai/i/z1/(-bi*z1/y-ci*x)))))*(-(3*(-y)-(-b)*2*(-i*x-(-a-ci/z1/x)/(-y/(-i)*ci))))))+(-(-x*2*(-y)*(-b))*(-(-x)*(-y)*(-ai)*(-a-(-b))*2i*(-c)*(-(-x/(-x/(a-b*c/(-x/y-z1/x*ci))-a*(-bi-x)/(ci/(-x)-b))))*(-x*(-ai/(-x*(-y)*a/bi*(-c*(-x)-di/z1)-2i*c/x)-(a*(-x)-y*(-bi-c)*((-y*a-bi/(-c))/(-x+b/(-z1/(-(-z2/x-(-y/z1-i/(-ai/x)))))-ci/(-d*2+3i))))))/c/di/(-b)/(-ci-(-bi)/(2*(-c)*di*(-c+d)*(y*di*z3+(-b))/3/(-a/ci/i)/(-(-a-(-(-(-b-ci)-di*i))))*(-a-x*(-b))*(-y*bi*(ci-1)-ci/(i/z1-z2/(-i/x/(-y/bi-3i))))+(-ai)*b*(-x/(2*(-c/y)*di*(-c+d)*(d/y/x+(-b/z2))/3i/(-a)/(-(-ai-(-(-(-b-c)-di))))*(-ai-x*(-b/i))*(-y*b*(i/c-1)-c/bi/x)+(-a)*b/(-x/(-y+z3/z2*i))))))))


//  ((sp2(7,5)+sp3(3,9,5))^(sp3(y/x,x/y,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y)))+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(z2/x,x/z1,x/(x+y)))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(y/x,x/y,x/(x+y))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(z1/x,x/z2,z3*x)))*((sp2(7,5)+sp3(3,9,5))^(sp3(z1/x,x/z2,z3*x))))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x,y,y-x))+(sp2(7,5)+sp3(3,9,5))^(sp2(z1/x,x/z2))))
//  ((sp2(7,5)+sp3(3,9,5))^(sp3(y/x,sp2(a/b,b/a)/b+b/a,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(sp2(a/b,b/a)/x,x/sp2(b/(a+b),a/(a+b)))))+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(sp2(ai/bi,bi/ai)/x,x/z1,x/(x+sp2(a/b,b/(a+b)))))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(sp2(b/a,a/b)/x,x/sp2(a/(a+b),b/(a+b)),x/(x+sp2(a/(a+b),b/a)))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(sp2(ai/ci,bi/ai)/x,x/sp2(ai/bi,bi/(ai+bi)),sp2(ai/(ci+ai),bi/ai)*x)))*((sp2(7,5)+sp3(3,9,5))^(sp3(sp2(bi/(ai+ci),ai/bi)/x,x/z2,z3*sp2(ai/ci,bi/ci)*x))))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x*sp2(a/b,b/(c+a)),sp2(a/b,b/c),y-x-x/sp2(a/(a+b),b/(a+b))))+(sp2(7,5)+sp3(3,9,5))^(sp2((z1+sp2(ai/bi+ai/ci,ci/(bi+ai/bi)))/x,x/(z2+sp2(ai/bi-ci,ci-bi/ai))))))
//  ((sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y)+sp3(y/x,x/y,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y))*x)+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp2(y/x,x/z1)+sp3(z2/x,x/z1,x/(x+y)))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp2(y/x,x/y)+sp3(y/x,x/y,x/(x+y))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(z1/x,x/z2,z3*x)))*((sp2(7,5)+sp3(3,9,5))^(x/sp2(z1/x,x/z2)+sp3(z1/x,x/z2,z3*x)/x)))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x,y,y-x)+sp2(x,y))+(sp2(7,5)+sp3(3,9,5))^(sp2(z1/x,x/z2))))
//  ((sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y)+sp2(a/b,b/sp1(a/b))+sp3(y/x,x/y,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(a/b,b/a)+sp2(y/x,x/y))*x)+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp2(y/x,x/z1)/sp3(a/b,b/a,a/(b+a))+sp3(z2/x,x/z1,x/(x+y)))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp1(a/(a-b))+sp2(y/x,x/y)+sp3(y/x,x/y,x/(x+y))-a/sp1(b/(a+b))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(z1/x,x/z2,z3*x)))*((sp2(7,5)+sp3(3,9,5))^(x/sp2(z1/x,x/z2)+sp3(z1/x,x/z2,z3*x)/x)))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x,y,y-x)/sp1(a/(b+a))+sp2(x,y)/sp1(b/(b+a)))+(sp2(7,5)+sp3(3,9,5))^(sp2(z1/x,x/z2))))


//ERROR!!!!!!!!!
{
at mode CalcConstOnTree= off  in const expr.
(-(-2-a))-((-a)/(-b*2))
a/(-b*2)
5/(-3*2)

(-(-2-a))-((-a)/(-b))
a*(-b*2)
}
{
ERROR
((-4i-b-di*i-i/ai+i*(bi-c/i+bi/i+5/i))*d-d*(a*i-b-4+i)*ci)
a*i
i*a
2*i
MulDiv,CaclConstOnTree= off
}
{
 ERROR
CalcConstMulDiv = off
i*i
i/i
}
{
ERROR
sin(i*i+x)
sin(-1+x)
MulDiv,CaclConstOnTree= on
i*i
}

{
(ci+i)*(i+bi)
(ci+i)/(i+bi)
ci+i
ai+1
}

//ERROR sin(x)+cossin(x)+cos(x) стек = 3!!!
{
ошибка
cossin(x)+cos(x)+sin(x)
cossin(x)+cos(x)+sin(x)



}


{
   y1:ext=r*sin(x)*cos(y); y2:ext=r*sin(x)*sin(y); y3:ext=r*cos(x); y1+y2+y3
   zr1:CXext=z1/(x/z1-z2/y)*(z1/(z2-z1)); zr2:CXext=(z2/y-x/z1)*(z1/(z2-z1)-z3/(x/z1-z2/y)); zr3:CXext=(z1/(x/z1-z2/y)-z3/(x/z1-z2/y)); zr1+zr2+zr3;
   xr:ext = sinh(s)*cos(a*u)/(1+cosh(u)*cosh(s));yr:ext = sinh(s)*sin(a*u)/(1+cosh(u)*cosh(s)); zr:ext = cosh(s)*sinh(u)/(1+cosh(u)*cosh(s)); xr+yr+zr;
   xr:ext = ( b + (c + r*sin (u))*sin(k*s*t))*cos(s*t) - r*cos(u)*sin (s*t); yr:ext = ( b + (c + r*sin (u)))*sin(s*t) + r*cos (u)*cos(s*t); zr:ext = (c+ r*sin (u))*cos(k*s*t); xr+yr+zr;

   Kuen Surface
   x:ext = (2*cosh(v)*(cos(u)+u*sin(u)))/(cosh(v)^2+u^2);y:ext = (2*cosh(v)*(sin(u)-u*cos(u)))/(cosh(v)^2+u^2); z:ext = v-(2*sinh(v)*cosh(v))/ (cosh(v)^2 + u^2);

   Hyperbolic Helicoid
   x:ext = sinh(v)*cos(a*u)/(1+cosh(u)*cosh(v)); y:ext = sinh(v)*sin(a*u)/(1+cosh(u)*cosh(v)); z:ext = cosh(v)*sinh(u)/(1+cosh(u)*cosh(v)) ;x+y+z;

}

//  ((k*x-y*m)*j/y-k/(k/a-b/j))/(-2.12-k)/(3.18*m-k*3.97-3.91/j-m/2.97)+(x/k*a/y*m/b-(b*k-m*a)/x-y/(x/(k-a)-(b-m)/y+(m+c)*(b+k)*x/(y-a*k/x)))-(x-y*a)/m
//  (n/k/m/x-m/k-(-k/2.5-m/x*a*(-j*(2.8/a-b/3.1*m*j-x/(-y/m-b/(-(x-a/y)/m-j*(-2.1*m+1.7*j-3.1)/(-x/m+a*m-j*c-y*a*m*x))))-m/(-x-k*a-b*j))*(-x/(a/k-m/b-2.7/m+k/1.8)*y)))/(x/(-a*1.2*j*m-(-j+2*m+4.5)/(j+m))-y/(-x-y/((n-k)*x-y/(k*a-j*b/c)))*a/b*1.7)
//  ((-y^k-x^m)/(m^k-k^j)-(x/y)^(k-j))/(k^(2*m+j)/(y/x)^(2*j-3)+(x/(x+y))^(k^x/y^m))*(1.5*x^(y*k)-y^(x/m)*2.5)/((a*x^(x/y-y/x))/(y^(a/x+y/b)/b+2.1))-(((x/k)^2+(m/y)^3)/(x/k+m/y)^(a/k+m/b))*((x/y)^5+(y/x)^3+(j*y-1)^(x*k-2))
//  ((x/y)^(x^5/(x^3+y^2))*2.3+(1.3*y/x^2-x/y^2*7.7)^(y^k*j^x/(a^k*3.5-2.7*k^b)+3.7*(x/y)^(k/j*3.7)))^(1.5/(x/y)^2-(y/x)^3/2.7)
//  (x/y)^(j-5*k-4)/(y/x)^(2-j*2+m*3)/a^(x/y)/(y/(x+y))^c/((x^1.7/2.9^y-(x/y)^(y/x))/(2.9*j^(x/y)+(y/x)^k*2.7)*(a^k/j^b-j^3/2^k*2.3))*(x^1.7/2.9^y-(x/y)^(y/x))/(2.9*j^(x/y)+(y/x)^k*2.7)

//  (x^1.7/2.9^y-(x/y)^(y/x))/(2.9*j^(x/y)+(y/x)^k*2.7)
//  (x/y)^(j-5*k-4)/(y/x)^(2-j*2+m*3)/a^(x/y)/(y/(x+y))^c/((x^1.7/2.9^y-(x/y)^(y/x))/(2.9*j^(x/y)+(y/x)^k*2.7)*(a^k/j^b-j^3/2^k*2.3))




//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//-(-x)-(-x/(-x-1-y)-t)*(-(-(-x-1)-y-y-1)/(-y)*t/(-y)-y)*(-(-sin(x)-1-x)-y*x/(-y)/(-y)-(-(1-cos(x)-x)-y)/sin(x)+(-(-x*x-y-y+1)-sin(y)/(-t-(-x)-1)*y)*y+(x-(-sin(x)-1-y)-t/(-t*x/(-y)-1)-1)-x-1)
//2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
//-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1-(-sin(x)+(-(-x*y))))
//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//-(-(-sin(x)-(-cos(x)*(-x-(-(-a)/sin(x)*x-(-(-cos(x)/x)/sin(x)*(-x)-sin(x)*(-x)*(-(-a))*(-x/cos(x)-sin(x)/(-y-(-a/x)))))))))
//-(-(-sin(x)/x-cos(x)*a/x-(-a/sin(x)*cos(x))-(-(sin(x)-(-a*(-x/sin(x)-(-cos(x)/x)))))-(-(-(-sin(x)*(-cos(x)/x)*x*b*(-b*x)/x/(-sin(x)))))*x/sin(x)/(-a)))
//2/(-3*x-y-t/x-(-sin(x/y-(-x-1)+1)-y)/t)-(-(-1-x)/y*2+3*x/y/t-cos(-(-x-y)/(-(-x+y*2)-x)-1)/(x+y*t/3)*x)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1)
//-(-sin(-x-c)-(-x)/sin(x-c)-cos(c-x))*x/sin(-(x+c))-cos(-(x+c))/(-b-c/sin(-(c-x)))-(-(-(2*sin(-(x-c)))))-(-cos(-c-x)*2)/sin(x-c)-(-2-cos(c-x)*3)/(sin(x+c)*2-3)-cos(c+x)*2
//-1/sin(a*cos(-c-x)-b)-cos(a*sin(-c-x)-b)/sin(a*sin(-c-x)-b)-(-cos(-c-x)-sin(a*cos(-c-x)-b)/cos(a*cos(-c-x)-b)-2*cos(a*sin(-c-x)-b))
//(-sin(-x)-(-1/(-cos(-y)*a)))*sin(a*cos(-x)-b)-x*(-x/cos(-y)-b*(sin(x)-cos(y)*b-c-c/cos(a*sin(x)-b))-sin(-y)/cos(a*sin(x)-b)-sin(-y)*cos(y)*(cos(a*cos(-x)-b)-cos(a*cos(x)-b)/(-(-a-sin(a*sin(-x)-b)*c)))-sin(y)/cos(x)/cos(a*sin(-x)-b)-b*sin(y)/cos(-x)/sin(a*sin(x)-b)/cos(a*sin(-y)-b))-(cos(a*sin(-y)-b)*sin(a*sin(-x)-b)/(x-sin(a*cos(-x)-b)))
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tan(x)-(-1/x-4+1/t-sin(y))))
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9)
//(sin(cos(x))*cos(sin(x))+cos(cos(x))/sin(sin(x)))/(sin(cos(sin(x)))-cos(sin(cos(x))))-(sin(cos(sin(x)))-cos(sin(cos(x))))
//-x*(-x/(x*y-x/y)+y/(x/y-y/x)*x)/(x*y*(x*y-x/y)-(x*y-x/y)/(x*y))+x*y*(x*y+x/(x/y-y/x)+y/(x/y+y/x)+(y/x-x/y)/(x*y-x/y))
//(x+y/x)/x/y/(-x/(-y)/(x+y)/y/(-x/(-y/(-y*t/(-x-y)))))*x/(t/(y-x))*(x/(x-y)/y*t*(t-y)/(t+y))*(x-y/t)/(x-y/(x-t/y))

// (-x)/3.5/(-y/(t/(y-x)-t/(-y))*(-t-4.5/x/(-x/(-y/(x/y/t*3.7)))/7.5/y)/(-y/(2.1/x-y)*(-y-(-x/(-y/x-1.5/(-x))))*(-y/(-x)*(-2.1-t/(-x/t))/(y*t/x*(-t-y)/(-t/x-y)/(y-t/x)-y/(t/x-x))/t*3.1)))*(-3.4/x/t/y-1/x*y/t*(-y/(x-7.1)-2.5)*(-y/(-x*t-3.2)))/(-x/(-7.1/x-y)/y/(-y/(t/x*4.5)))

//(x*y*(y/t-t*x*(x/t-y/(y/t-x/y)))/s+x*y*(y/t-t*x*(x/t-y/(y/t-x/y)))/(s+r/s*(s-r/(-r-s/r-s*r/(s*r*(s*r-r/s))))))/((y/(s+r/s*(s+r/(-r-r/s-s*r/(s*r*(s*r+r/s)))))+s/(r*x/(y/s-r/y)*y-x*r*y/(x-r)*(s-y)))*(s-(y*x-y*(-t*x-s)/r)-(x/r-r/(x-s/t))-r)/(y-s*(r*s*(-r/s*(r*(-s)-s/r)-s/r))+((-s*r*(s*r*(s/r-r/s)*(-r-s))/(-r))-x)))
//((3.7/(x/y-y/(s/x-y/s)*(s*y-r*x-t*s)))*(x*y-(-t*s/x+2.5/(x+y))/y)/(x*s/y*(-s/t-y*x)/r*(x/t-t/x)/y-x*(x*t-x)/(s*r+s/r*(s/r+r/s*(s*r*(s*r/(s+r)+s/r)))))*((r*s+s/r/(s*r+r*s*(r/(r-s/r))))/y-(r*s-s/r*(s*r+r*s*(r/(r+s/r))))/(y-t/x+y*t*(x/y-y/x))))*((x*y*(y/t-t*x*(x/t-y/(y/t-x/y)))/s+x*y*(y/t-t*x*(x/t-y/(y/t-x/y)))/(s+r/s*(s-r/(-r-s/r-s*r/(s*r*(s*r-r/s))))))/((y/(s+r/s*(s+r/(-r-r/s-s*r/(s*r*(s*r+r/s)))))+s/(r*x/(y/s-r/y)*y-x*r*y/(x-r)*(s-y)))*(s-(y*x-y*(-t*x-s)/r)-(x/r-r/(x-s/t))-r)/(y-s*(r*s*(-r/s*(r*(-s)-s/r)-s/r))+((-s*r*(s*r*(s/r-r/s)*(-r-s))/(-r))-x))))




//******************************************************************************

//complex

//******************************************************************************
{


//  ((x*y-y*x/(x-y*(x-y/x-b*(x-a/(y/(b*x-a/(x*y-y/x))))/c)))*i+i*(y/x-x/(b/(c/x-a/(c-y*x))-y/(b/(-x/y-y*x/(-c*x-b/(a/y-y/x)))-y/(x+y*a)))))/((x*y+y*x/(y+x*(x+y/x+b*(y+b/(y/(b*x+a/(x*y+y/x-b))))/(c-x/(x+y)))))/i+i/(y/x+x/(c/(b/x+a/(c+y*x))+y/(a/(-x/y+y*x/(-a*x-b/(b/y+y/x+a)))-x/(x-y*c)))))*(((x*y-y*x/(x-y*(x-y/x-b*(x-a/(y/(b*x-a/(x*y-y/x))))/c)))+i)/(i+(y/x-x/(b/(c/x-a/(c-y*x))-y/(b/(-x/y-y*x/(-c*x-b/(a/y-y/x)))-y/(x+y*a))))))*(((x*y+y*x/(y+x*(x+y/x+b*(y+b/(y/(b*x+a/(x*y+y/x-b))))/(c-x/(x+y)))))-i)/(i-(y/x+x/(c/(b/x+a/(c+y*x))+y/(a/(-x/y+y*x/(-a*x-b/(b/y+y/x+a)))-x/(x-y*c))))))


(x*y-t*y/(x-y/(x*y-t*(x-y))))
(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))
(x*y-t*y/(x-y/(x*t-t*(y-x*y/(y/t-x)))))

(t/(x*y-t/x+2.5)-2.1*y*x/(1.5-x-y/t)+(-x-2.3/t+1.7/(x/y-t*x))/(y-t*x*2.7)*(2.1*x-y*1.9-2.5/t-1.1))
((-y/x)/y-t/(x*1.1/y*(t-x)-x/(-t))-2.7/(-2.1-(-x-t/y))+x*1.2*y/(y-1.5)*t*(-1.1/x-y)/(x-y))
(-x*(-x/(1.1/t-x/(-y-3.1/(-x))))*y/(y-t*x)-(x*y/(-x-y/(t-1.2/(-x*1.5))))*t*(-y-t/x)+y/(2.1/(-x)-1.5/(-x))*5.5-x*y*(t/(-x)+x*(y-t/x)))
(-x*y/t-t/x*y*(-1.1*x/y*t-2.3/(-x-(y/t-x/y)/(x-2.5-y*3.2)))+t*(t/(x-y-2.1)-(x*t-2.5/x+3.7)/y)*x/(y*x-t/(-2.5/x-3.7*(x*y-t/(-1.5-y*x))/(2.1*x-3.2*y-2.5*t+2.7/t))))




(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))
(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))
(z1*z2-z3*z2/(z1-z2/(z1*z3-z3*(z2-z1*z2/(z2/z3-z1)))))
(z3/(z1*z2-z3/z1+2.5)-2.1*z2*z1/(1.5-z1-z2/z3)+(-z1-2.3/z3+1.7/(z1/z2-z3*z1))/(z2-z3*z1*2.7)*(2.1*z1-z2*1.9-2.5/z3-1.1))
((-z2/z1)/z2-z3/(z1*1.1/z2*(z3-z1)-z1/(-z3))-2.7/(-2.1-(-z1-z3/z2))+z1*1.2*z2/(z2-1.5)*z3*(-1.1/z1-z2)/(z1-z2))
(-z1*(-z1/(1.1/z3-z1/(-z2-3.1/(-z1))))*z2/(z2-z3*z1)-(z1*z2/(-z1-z2/(z3-1.2/(-z1*1.5))))*z3*(-z2-z3/z1)+z2/(2.1/(-z1)-1.5/(-z1))*5.5-z1*z2*(z3/(-z1)+z1*(z2-z3/z1)))



(z1*(x*y-t*y/(x-y/(x*y-t*(x-y))))-(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))*z2)/(x*(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))-(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))*y)
(z1/(x*y-t*y/(x-y/(x*y-t*(x-y))))-(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))/z2)/(x/(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))-(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))/y)
(z1-(x*y-t*y/(x-y/(x*y-t*(x-y))))-(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))-z2)/(x-(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))-(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))-y)
(z1+(x*y-t*y/(x-y/(x*y-t*(x-y))))-(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))+z2)/(x+(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))-(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))+y)


(x*y-t*y/(x-y/(x*y-t*(x-y))))*(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))+(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))*(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))
(x*y-t*y/(x-y/(x*y-t*(x-y))))/(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))+(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))/(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))
(x*y-t*y/(x-y/(x*y-t*(x-y))))+(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))+(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))+(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))
(x*y-t*y/(x-y/(x*y-t*(x-y))))-(z1*z2-z3*z2/(z1-z2/(z1*z2-z3*(z1-z2))))+(z1*z2-z3*z1/(z1-z2/(z1*z2-z3*(z1-z2*z3*(z2/z3-z1)))))-(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))

(-x*(-x/(1.1/z1-x/(-y-3.1/(-z2))))*y/(y-t*x)-(z3*y/(-x-y/(t-1.2/(-x*1.5))))*t*(-y-z1/x)+y/(2.1/(-x)-1.5/(-x))*5.5-x*z2*(t/(-x)+x*(y-t/z3)))
(-z1*(-x/(1.1/z3-z1/(-z2-3.1/(-y))))*z2/(z2-z3*z1)-(z1*t/(-z1-z2/(z3-1.2/(-z1*1.5))))*t*(-z2-z3/z1)+z2/(2.1/(-z1)-1.5*y/(-z1))*5.5-t*z2*(z3/(-z1)+z1*(y-z3/z1)*t))

((-y/x)/y-t/(x*1.1/y*(t-x)-x/(-t))-2.7/(-2.1-(-x-t/y))+x*1.2*y/(y-1.5)*t*(-1.1/x-y)/(x-y))
(t/(x*y-t/x+2.5)-2.1*y*x/(1.5-x-y/t)+(-x-2.3/t+1.7/(x/y-t*x))/(y-t*x*2.7)*(2.1*x-y*1.9-2.5/t-1.1))

((-y/z2)/y-t/(z1*1.1/y*(t-z2)-z1/(-t))-2.7/(-2.1-(-z3-t/y))+x*1.2*z2/(y-1.5)*t*(-1.1/x-z3)/(x-z1))
(t/(x*y-t/z3+2.5)-2.1*y*z1/(1.5-x-y/t)+(-x-2.3/t+1.7/(z2/y-t*z1))/(y-z2*x*2.7)*(2.1*x-y*1.9-2.5/t-1.1))

(-x*z2/t-t/x*z2*(-1.1*x/y*z3-2.3/(-x-(y/t-z1/y)/(x-2.5-y*3.2)))+t*(t/(x-z2-2.1)-(x*t-2.5/z1+3.7)/y)*x/(z2*x-z3/(-2.5/x-3.7*(z1*y-t/(-1.5-z2*x))/(2.1*x-3.2*y-2.5*z3+2.7/t))))


((t/(x*y-t/x+2.5)-2.1*y*x/(1.5-x-y/t)+(-x-2.3/t+1.7/(x/y-t*x))/(y-t*x*2.7)*(2.1*x-y*1.9-2.5/t-1.1))/((-y/x)/y-t/(x*1.1/y*(t-x)-x/(-t))-2.7/(-2.1-(-x-t/y))+x*1.2*y/(y-1.5)*t*(-1.1/x-y)/(x-y))+(-x*(-x/(1.1/t-x/(-y-3.1/(-x))))*y/(y-t*x)-(x*y/(-x-y/(t-1.2/(-x*1.5))))*t*(-y-t/x)+y/(2.1/(-x)-1.5/(-x))*5.5-x*y*(t/(-x)+x*(y-t/x)))/(x*y-t*y/(x-y/(x*t-t*(y-x*y/(y/t-x))))))*(x*y-t*x/(x-y/(x*y-t*(x-y*t*(y/t-x)))))



((t/(x*y-t/x+2.5)-2.1*y*x/(1.5-x-y/t)+(-x-2.3/t+1.7/(x/y-t*x))/(y-t*x*2.7)*(2.1*x-y*1.9-2.5/t-1.1))/((-y/x)/y-t/(x*1.1/y*(t-x)-x/(-t))-2.7/(-2.1-(-x-t/y))+x*1.2*y/(y-1.5)*t*(-1.1/x-y)/(x-y))-(-x*(-x/(1.1/t-x/(-y-3.1/(-x))))*y/(y-t*x)-(x*y/(-x-y/(t-1.2/(-x*1.5))))*t*(-y-t/x)+y/(2.1/(-x)-1.5/(-x))*5.5-x*y*(t/(-x)+x*(y-t/x)))/(-x*y/t-t/x*y*(-1.1*x/y*t-2.3/(-x-(y/t-x/y)/(x-2.5-y*3.2)))+t*(t/(x-y-2.1)-(x*t-2.5/x+3.7)/y)*x/(y*x-t/(-2.5/x-3.7*(x*y-t/(-1.5-y*x))/(2.1*x-3.2*y-2.5*t+2.7/t)))))*(x*y-t*y/(x-y/(x*t-t*(y-x*y/(y/t-x)))))
((z3/(z1*z2-z3/z1+2.5)-2.1*z2*z1/(1.5-z1-z2/z3)+(-z1-2.3/z3+1.7/(z1/z2-z3*z1))/(z2-z3*z1*2.7)*(2.1*z1-z2*1.9-2.5/z3-1.1))/((-z2/z1)/z2-z3/(z1*1.1/z2*(z3-z1)-z1/(-z3))-2.7/(-2.1-(-z1-z3/z2))+z1*1.2*z2/(z2-1.5)*z3*(-1.1/z1-z2)/(z1-z2))-(-z1*(-z1/(1.1/z3-z1/(-z2-3.1/(-z1))))*z2/(z2-z3*z1)-(z1*z2/(-z1-z2/(z3-1.2/(-z1*1.5))))*z3*(-z2-z3/z1)+z2/(2.1/(-z1)-1.5/(-z1))*5.5-z1*z2*(z3/(-z1)+z1*(z2-z3/z1)))/(-z1*z2/z3-z3/z1*z2*(-1.1*z1/z2*z3-2.3/(-z1-(z2/z3-z1/z2)/(z1-2.5-z2*3.2)))+z3*(z3/(z1-z2-2.1)-(z1*z3-2.5/z1+3.7)/z2)*z1/(z2*z1-z3/(-2.5/z1-3.7*(z1*z2-z3/(-1.5-z2*z1))/(2.1*z1-3.2*z2-2.5*z3+2.7/z3)))))*(z1*z2-z3*z2/(z1-z2/(z1*z3-z3*(z2-z1*z2/(z2/z3-z1)))))



((t/(x*z2-t/x+2.5)-2.1*z2*x/(1.5-x-y/t)+(-x-2.3/z3+1.7/(z1/y-t*x))/(y-t*x*2.7)*(2.1*x-z2*1.9-2.5/t-1.1))/((-y/z1)/y-t/(x*1.1/y*(t-x)-x/(-z3))-2.7/(-2.1-(-z1-t/y))+x*1.2*y/(z2-1.5)*t*(-1.1/z1-y)/(x-y))-(-z1*(-x/(1.1/z3-x/(-y-3.1/(-x))))*z2/(y-t*x)-(z1*y/(-x-y/(t-1.2/(-x*1.5))))*z3*(-y-t/x)+z2/(2.1/(-x)-1.5/(-x))*5.5-z1*z2*(t/(-x)+x*(y-t/x)))/(-z1*y/z3-t/x*y*(-1.1*x/z2*t-2.3/(-z1-(z2/t-x/y)/(x-2.5-y*3.2)))+z3*(z3/(x-y-2.1)-(x*t-2.5/x+3.7)/y)*x/(z2*x-t/(-2.5/x-3.7*(x*z2-t/(-1.5-y*x))/(2.1*x-3.2*y-2.5*z3+2.7/t)))))*(x*y-t*z2/(x-y/(x*z3-t*(y-x*z2/(y/t-x)))))
((z3/(x*z2-z3/x+2.5)-2.1*z2*z1/(1.5-z1-z2/t)+(-z1-2.3/z3+1.7/(x/z2-z3*z1))/(y-z3*z1*2.7)*(2.1*z1-y*1.9-2.5/z3-1.1))/((-z2/x)/z2-t/(z1*1.1/z2*(z3-x)-x/(-z3))-2.7/(-2.1-(-z1-t/z2))+z1*1.2*y/(z2-1.5)*z3*(-1.1/z1-z2)/(z1-z2))-(-z1*(-z1/(1.1/z3-z1/(-z2-3.1/(-z1))))*z2/(y-t*z1)-(x*z2/(-z1-y/(z3-1.2/(-z1*1.5))))*z3*(-z2-z3/x)+z2/(2.1/(-z1)-1.5/(-z1))*5.5-z1*y*(z3/(-z1)+z1*(y-z3/x)))/(-z1*y/z3-t/z1*z2*(-1.1*z1/z2*t-2.3/(-z1-(z2/z3-x/z2)/(z1-2.5-y*3.2)))+z3*(z3/(z1-y-2.1)-(x*z3-2.5/z1+3.7)/z2)*z1/(z2*z1-t/(-2.5/z1-3.7*(z1*z2-z3/(-1.5-z2*x))/(2.1*z1-3.2*y-2.5*z3+2.7/z3)))))*(z1*z2-z3*z2/(x-z2/(z1*z3-t*(y-z1*z2/(z2/z3-x)))))


((i*x/z1-z2/x/i*t)*i/(z2-z1/i-i/(x*y*(x-y/(t/x-y/t)))-(i*z1-z2*i-z3*(x*i-z3/(i*t-2.5*i-i/x)))*i))/(z1/(x-i/(z1-z2/i-i/3.5))+x*(z3-x/i)*(y/z1-i/z2/x)-z1*(i/(x/i-i/x)-(i/z2-z3/i)/i)*(-i-y/(-z1/(z2-x))))
((i*x/z1-z2/x/i*t)*i/(z2-z1/i-i/(x*y*(x-y/(t/x-y/t)))-(i*z1-z2*i-z3*(x*i-z3/(i*t-2.5*i-i/x)))*i)+(-i-3.1/i)/(i/(x-z2)+(z1/(t/z1/x/i-x/i/z3)/i)/(z1-z2/(1.5*i*x-t/i)))+z1*(t-z3/x*i-2.3*i*z2*y*(-x/(y/(-i-z2/x)-z3/(-t/i-z1/i*x))-i/(2.3*x-2.5/i-z2*x)))*(-2.1-i/(-x/(1.7-i*2.3))))/(z1/(x-i/(z1-z2/i-i/3.5))+x*(z3-x/i)*(y/z1-i/z2/x)-z1*(i/(x/i-i/x)-(i/z2-z3/i)/i)*(-i-y/(-z1/(z2-x))))


(z1/j-m/z2-x/(k*m-z1/x-y/z2-z1/(2.5-k)*(m-3.5)*x*y))*(i*k-m*i-2.61/i/m/z1/(z1/i-i/z2)+x/(-z1/y-y/i*x/(-z2/y)))
(m*x*2.71/z2-x/k*z1/y)/(z2/(m*y-x*k-z1)-k*(z1/(x/z2-y/(x*z2*y-2.81/y*z2)))+((z1/(z2/4.63-3.977/m*z2/x*y))/x-y/(k-2.67*m-(z2/(x/z1-y*(-z2/y-x/(k*x-z2*m/z1))))*k))/m-(x*(x*j-m/(y-2.87*x*k))+(z1/z2-2.14/z1+5.87/z2-x*2.76/y/m*k/z2)*y)/k)
(z1*x*2.12/y-3.15/z2*(x*z1-z2*y/2.17/(-2.19/x-z2/(x-y))-k*m))*(-k/(z1*i-x/i/z2-y/6.71)*i-i*(-z1*x/y-i/(-k/i+2.81)/x-z2/(x/i-i/y))+(2.11/(-x+y/z2/z1/x-z2*(-x/(-z1*(z2*m-k*z1-(x-y*2.95)/z2)/(x*k-m*(x/y-y/(x-y))/j)))/z1))/i)

 -(-ai*1.5/(-bi*2.7/(ci/(-z1-1.5*ai/(-bi*1.5+ci)+z1*(-1.9-ai)*bi*3.1)))-2.1*ai/3.5/ci/(ci-1.5)+z1*(-ai)*(-5.1)*z2*(-ai*z1-3.5*bi*z2*3.5-d/ci/5.2))*(-2.1*sin(-6.5*z1-ai*bi-5.3)/7.8+2.5/cos(2.5*(-ai)*z1/(z1-ai*z2)*(-3.1)*z2*(1.5/z1/ai/ci/(-ci-7.1/d/(-ci/ai-5.7/(-3.1*(-ai*z1)))))))/(-2.1-ai*3.2/(-z1/(-d/ci*ai/(-ai*2.1/z1*ci+z1/(-ai)-z2*(-z1)*(-ai*4.5/(-z1)))))-ci*2.9*(-d)*(-3.5*ci-d)*sin(-z1-ai-(-bi-(-1.7-(-z1/(-1.7-d/ci))))))
 -(-z1)-(-z1/(-z1-1-z2)-t)*(-(-(-z1-1)-z2-z2-1)/(-z2)*t/(-z2)-z2)*(-(-sin(z1)-1-z1)-z2*z1/(-z2)/(-z2)-(-(1-cos(z1)-z1)-z2)/sin(z1)+(-(-z1*z1-z2-z2+1)-sin(z2)/(-t-(-z1)-1)*z2)*z2+(z1-(-sin(z1)-1-z2)-t/(-t*z1/(-z2)-1)-1)-z1-1)
 -(-1/ai*bi-ci/z1*(1-d)*(-ai)-bi/ci/d/(z1-ci/(-d)*(-z1*2)*(-z2*(-2)/(-ci)/d/z1)-z1/2/ai))*(-2/ai/z1*z2*3*d*(d+ci)*(z1+ai)*(z2+(-ai))*(ai+1)*(2/d-ci))+ai/ci*d*2/3*z1*(-2)*(-ai)*(-ai-bi)*(-z1)/(-z1-ai*z1*z2*(z1/(z1*ai-z2*bi-ci)*2/ci-ci/(-d-1)))
 2/(-3*ai-bi-ci/d-(-sin(ai/bi-(-ci-1)+1)-ci)/d)-(-(-1-ci)/d*2+3*ai/bi/ci-cos(-(-ai-bi)/(-(-ci+d*2)-ai)-1)/(ai+bi*ci/3)*d)
 2/(-ai)/(-3*(-ai)-bi*(-bi)/(-(-ci))-ci/d-(-1/(-sin(ai/bi-(-ci-1)+1)-ci)/d)+bi*(-(-ci)))-(-(-1-ci)/d*2+3*ai/(-bi)/(-(-(-ci)-2-d)-bi)-cos(-(-ai-bi)/(-(-ci+d*2)-ai)-1)/(ai+bi*ci/3)*d)-sin(-ci-(-d-(1-bi)-3-(-ai*2))/ai/(-bi/(-ai)-d)-1)
 -(-z1)-(-ai/(-z1-1-z2)-ci)*(-(-(-z1-1)-bi-z2-1)/(-bi)*ci/(-z2)-bi)*(-(-sin(z1)-1-z1)-bi*z1/(-z2)/(-bi)-(-(1-cos(z1)-z1)-bi)/sin(z1)+(-(-ai*z1-bi-z2+1)-sin(z2)/(-ci-(-z1)-1)*z2)*bi+(z1-(-sin(z1)-1-z2)-t/(-ci*z1/(-bi)-1)-1)-z1-1)
 z1*(-(z1*z2+z1))-2/(-3*ai-bi-ci/d-(-sin(ai/(-(z1*z2+z1))-(-ci-1)+1)-ci)/d)-(-(-1-ci)/d*2+3*ai/bi/ci-cos(-(-ai-bi)/(-(-ci+d*2)-ai)-1)/(ai+bi*ci/3)*d)
 (2*z1-(-z1/(-z2-1)-z2)-(-(-1-z2))-z2/(-z1-z2-2*(-z1/z2-3)))*(-(-1-z1-(-(-z1-(-1-2/z2))/(z1*z2-2/z1*(2+z1)*(2*z1+3*z2-4)*z2/(2*z1+3*z2+4))-z1/(z1+3*z2-4))*z1*z2)*(2*z1+1)*(3*z2+2)*z2*z1)-(-2/z1)*z1*z2*(2*z1+z2-1)*(-z2/(-z1/z2-(-z2/(-z1/z2-1))*(z1*z2*2-1))-z1)
 -(-(-(-z1/(-z1/(-z2-z1/(-(-z2/(-z1)/(-z2*(-(-z1-z2*(-z1/(-z2*(-z1-z2/(-z1*z2-z1/(z1-z2/(-z1))))))))))))))))


 (-(-ai/(-z1-bi-ci/(-i/ai*z1/(ci/i-z1*x/bi-i*y))-(-(-z2/(-z1/ci*x/ai/i-x*(-z2/(-y)/(-z1*(-ci+i/bi)-(-(-ci/i*a*(-b)/(-x)-z1/(-z2/y*(ai-a+b/i-x/z2)))-ci/i*(-x/z1-z2/y/i*(ai+bi*x/i))/(-(-i*(-bi*x/(-y-z1-ci/i*(-bi-z2/(ci+z1/x*z2/bi))))))+ci/z2*(ai-x)*(y-b/i)/(z1-b/x))))+z1/(-z2)*(-ci/(-z1-z2/(-bi/(-z1)))))+ci*y*x/b/i/(-x/z2+z1/y/bi*z2))))-z1/(-bi/z2-(-ci-(-a-(-x-(-z1-i/(-i/z2-z1/(ci+b+b/bi)*i))))))))

-(-(-z1-ai)-((-z1)*(-(ai)))-ai*2/c*z1/y*(-y)/(-z1)*(ai*z1*b+c-d)/(2*z1*y+b*2))-(-((-z1)-y)-(-(-z1-(-y)-ai))-b*(-z1)*(-ai-b-2))/(-ai/b/z1)+(-z1)*(-(-z1*(-(-y*z1*(ai*z1*y+b)*(ai*z1*y+b)*(-z1-1)*(y+z1*2)))))-(-(-z1*y*(z1*ai*b+3)*(-z1*y-c*b*2)/(2*z1*y+b*c)*(2*ai-z1)*ai*2/3/b*(b+1)))
-(-ai*b*(-c)-z1-(-1-y))/(-z1*ai*(-ai-z1*y/b)*(-b-z1/c)*(-1-y/2*3/b)*z1*y/ai/(2*c/b-z1*y*c*d/3/b))*(ai-z1*y/b-b*z1*y-y*b-ai/(-b)-b*z1/(-c)*2/3-b*z1*y/3/(b-ai)-c*z1-b*y-c/(-b)/2*(-ai-b)*z1-y*(b-c/2)/ai/b-(-y)*ai-z1*(-(-b))+z1*(ai-d/c/y-(-(-(-y)/(-z1))))-z1/(ai*z1*y+b-c+2))-z1*y*(-z1*(-y)-z1*(y*z1-(-(-z1-y-2*z1*(-b)-(-z1)*y*(-y)-ai/z1-(-(-ai-z1*y/c))))))/(-b-z1*y)*(-ai-b*c)*y*(-2-z1/3)*(z1*(-y-b-3*(-b/(z1*ai-b*2*(-c)*z1*b-c*z1-2*y)-c-z1-2-y*2)*c*(-(-d-z1/(-b-y))))+z1*y/(ai*z1-y*b-c-1))
-((-y)/z1-(-ai)*y-(-z1-y))-(-y-(-2-z1/(-y*z1-z1*ai-b/y*(-z1*(-y)*(ai*z1-b/(-y)*z1*c-c-z1)-z1/y)+c/z1-d/z1-y/(c*z1))+z1*(-y-z1*ai-b)*c/(y+z1*y-(-c*y))-y*(-2-z1)-(-(-z1-5-y))-3)-4/y*(-(-(-7-(-z1))/y-5)-y)+z1)
z1*y*(2*z1+1)*(2*z1*y/t-2*z1*(3*t-1)/(2*z1-3*y-4)*(z1/(3*z1-1)-4/z1+5*(2*z1*y*t-1)/(y+1)-7*(2*z1*(y+1)*(3*y+2)*(3/(z1+1)-2*t/(2*z1*y*t-1)+(4*z1-1)*(5*y-7)/(z1-2*y-1-2*t/(3-7*z1-8*y*(4*z1/(2*t+1)-7*z1-8/t+9*(2*z1-1)*(3*z1+4*y+5)*(2*z1*y*t-7)*z1*y*t/(z1-y*2-3/(z1/(t-1)-7/(y+2)+8/(2*z1*y*t+1)-9)))))/(z1-1)))))
-(-1/ai*b-c/z1*(1-d)*(-ai)-b/c/d/(z1-c/(-d)*(-z1*2)*(-y*(-2)/(-c)/d/z1)-z1/2/ai))*(-2/ai/z1*y*3*d*(d+c)*(z1+ai)*(y+(-ai))*(ai+1)*(2/d-c))+ai/c*d*2/3*z1*(-2)*(-ai)*(-ai-b)*(-z1)/(-z1-ai*z1*y*(z1/(z1*ai-y*b-c)*2/c-c/(-d-1)))
(2*z1-(-z1/(-y-1)-y)-(-(-1-y))-y/(-z1-y-2*(-z1/y-3)))*(-(-1-z1-(-(-z1-(-1-2/y))/(z1*y-2/z1*(2+z1)*(2*z1+3*y-4)*y/(2*z1+3*y+4))-z1/(z1+3*y-4))*z1*y)*(2*z1+1)*(3*y+2)*y*z1)-(-2/z1)*z1*y*(2*z1+y-1)*(-y/(-z1/y-(-y/(-z1/y-1))*(z1*y*2-1))-z1)
c*y*(ai*y*(b*y+c+d*y*(c*y+e))+(d*y+ai)*c+c*y+e)*(ai*y+b)*(c*y+d*(c*y+ai)+d)*(ai+c*y*(d*y+c+y+(c*y+e)*c+(e*y+d)*b)+c*y+d)+d*y+e*y*(ai*y+c+y)+y+c*y*(ai*y+b)*(c*y+d)*(d*y+e)+d*(c*y+(b*y+c)+(d*y+e)+ai)+b
c/z1/(ai/z1/(z1/b-c)-(z1/d-ai)-z1/c-e)/(z1/ai-b)/(z1/c-d)/(ai-z1/c/(z1/d-c-z1-(z1/c-e)/c)-z1/c-d)-z1/d-e
((c/z1/(ai/z1/(z1*b-c)-(z1*d-ai)-z1*c-e)/(z1*ai-b)/(z1*c-d)/(ai-z1*c/(z1*d-c-z1-(z1*c-e)*c)-z1*c-d)-z1*d-e)/(c*z1-d)-(z1/(ai*z1-c)+(ai*z1-b)/z1)/(c*z1-d)+z1/(c-z1/(ai*z1+b)-(c*z1-d)/z1+(ai*z1-b)/(b*z1-c)))*(ai*z1+b)/(c*z1+d)+b*z1*(c*z1+d)/(ai*z1+d)-c*(c*z1+d)*(b*z1-ai)/z1+b
c*z1*(ai*z1*(b*z1-c-d*z1*(c*z1-e))-(d*z1-ai)*c-c*z1-e)*(ai*z1-b)*(c*z1-d*(c*z1-ai)-d)*(ai-c*z1*(d*z1-c-z1-(c*z1-e)*c-(e*z1-d)*b)-c*z1-d)-d*z1-e*z1*(ai*z1-c-z1)-z1-c*z1*(ai*z1-b)*(c*z1-d)*(d*z1-e)-d*(c*z1-(b*z1-c)-(d*z1-e)-ai)-b
(((2*z1+3)*(3*y+4)+(3*z1-5)/(4*y+6)+z1*(4*y-5))*(3*z1-4)+(2*z1+3)*(((3*z1-4)/(3*y+5)+5*z1/(2*z1-5)-7*y*(3*y+5)+7)/(3*z1+4)-5/z1-7/y))/(((3*z1-4)*(4*y-5)*(5*y-7)*z1-(3*z1-8)*(2*y-9)/(3*z1+4)+5/z1-7)*(2*z1-3)*(3*y+4)+z1*(3*z1-4)*(3*y+4)+5/z1+7)+(3*z1-5)*(5*y+6)/z1+y*(3*z1+5)/(5*z1-6)+7
(2*z1*(2*t-1)/(3-z1)-t-z1/t/(7-y))*(3/z1-t-3+(y*(z1-1)-t*(5-z1/t-7*(8*z1-1)/(t*2/y+1))))-(2*z1-z1*y*t/(6*z1-1)-t*(4-y)+2-5/z1*(z1-t*(3-z1))*(z1*y/(z1+1)/(t-1)-2/y*(y-t))-z1*y*t*(3/t+1)/(5*y/z1-1))

 -(-(-z1-i*(-i-z2/(-ai*i/(-bi/(-z1/bi)-ci*z1/(-z2-ci/(-z1))+ai*z1/(-z2/(-ci/i-ai))-i/(-z1/ci)-ci/(-ai*i/z1-z2/(bi-ci/z2*i)))+z1*(-i/ci*z2/(-z1))*(x*i/ci-y/i-z1/x*ai)))/(-ai*bi/(-x*z1+z2/(-i*y-bi)))*(-x*i/bi/z1-z2*(-i/y-i*bi/(-z1/x-i/z2/y/bi/(ai*i-bi/i)))))/(-i/(-z1/(-i*y/(-ci*a/i*z2/z1-ci/(-i/x+z1/(-x/ci*y/b/ci*i/ai/(z1/x-y/z2))))))*x/ci/(a*ai-b*bi-c*(-i/d))))

 -z1*(-z2/x/(ai/z2*i-z1/y/bi/z2*ci*(-i/ai*(-bi/b/z1*z2+x/z1+i*z2/(-z1-i*a/x/bi*z2/(-ai*a*x*z1*bi/z2-ci*(-i/z1+z2/a+b*z1/z2/x/i)/(-ai/x-y*bi/i)))))/(-ai-b-ci/i/z1/x*(-x-b/z1-ci/z2))*ci/z1*b)+z1*(-i-z1)*(-ai*x-z2/(-z1/z2*ci-bi*y/i/(-x-bi/z1/i)))/z2)

 ((ai*x-y*bi)/(i/y-x/i)-x)*(y-(z1/x*ai-y/z2/(bi-c))*y-(ci/x-y/bi)/x+y/(-x/(-z1/(-ai/z2-z1/bi/c/(c-b/bi)))-(-z1*x-y*z2-z1*(-z2/(x/y-c))/z2)/y))/(ci/c*z1*x/y/z2-y/(-z1/(ci+x))-x/(y-ai))

 z1*z2*z3*(z3*z1*(z1*z2-z3*z1)-z1*z2*(z1*z3-z2*z3)+z2*z1*(z2*z1-z3*z2)-(z1+z2)*(z1-z2)*(z3-z2)*(z1*z2-z3*z1*(z1-z2*(z3-z1*(z3-z1)*(z1-z3)*(z3-z2)-z1*z2-z2))))-(z1*z3*z2*(z1*z2-z1*(z2-z2*(z3-z3*(z1-z1*z3*(z1*z2-z3*z1-(z1*z2-z3*z1)*(z1-z2)*(z2-z3)*(z3-z2)-(z1+z3*z2)*(z2-z1*z3)+(z3-z2*z3)*(z2-z3*z1))))))) ;
 -z1/(z1/z2-z3/(z1+z3)+z1*z2*(z1*z2-z2*z3+z1/(z1/(z1+z2)+z2/(z3+z1))))*(z2*(z1-z2/(z1*z2-z2/(z1*z2+z2*z3)*(z2*z3-z1*z2)))+z1-z2*(z1-z3-z3/(z1-z2)*(z2/(z2-z3*(z1+z2*z3)*(z2-z1*z3)/(z1*z3-z2*(z1+z3))))))*(z1*z2-z3*z2-z3*(z1*z3-z2*(z3-z1)/(z1*z2*z3-z1-z2-z3)));
 z1*z2*(2.111*z1+1)*(2.211*z1*z2/z3-2.311*z1*(3.422*z3-1)/(2.511*z1-3.611*z2-4.22)*(z1/(3.711*z1-1)-4.111/z1+5.111*(2.611*z1*z2*z3-1.23)/(z2+1.12)-7.132*(2.812*z1*(z2+1.123)*(3.832*z2+2.121)*(3.112/(z1+1.123)-2.133*z3))));
 z1*z2*(z1-z3*(2.123*z1-3.222*z2-5.323)/(z3*z1*z2/(2.234-z1*z2)+(2.455*z1+3.632)*(3.734*z2-4.832*z3-5.923)-(1.134-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.745*z1-3.345*z2-z3))-z2*(z1*z2-z2*z3*3.167+2.965*(z1/z3-z3/(z1-z2*(2.467-z1-z2-z3)))*(z2-z3)-2.376*z1)*(z2-z1)-7.154/z1)*(-1.943/z3+z1*z2*z3*5.334))-3.556*z1-5.657)-7.243*z2-3.459)/(z1-z3)+z1*(z3*z2/(z1-2.834*z3)-z2*(z1*(z3-2.756*z2-z1-5.676))));
 (z1*z2+z3*(z1*z2-z2*z3*z1-z1+z2-z3))*(z1+z2+z3)*(z1-z2-z3)*(z3-z1*(z3-z2*(z1-z2-z3)))*z1*z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)*(z2*z1+z3*z1+z3*z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2*(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3)-z3*(-z1-z2*(-z3*(-z1*(z2-z3))))))))))));
 z1*z2-z1/(z1/z2-z3/z2-(-z1-z2*(z1*z2-z3*z1/(z1/z2-z3/z2-(-z1-(-z2-(-z3-(z1*z2-z2*(-z1*z2-z2/(z1+z2*z3)))*z1)*z2)/(z1+z2*z3)-z1*(z2/z3-(-z2*z1/(z1-z2*z3)-(-z1-(-z2/(-z1*z2*(-z1-z2))+z1/z2*(z2*z1+z2*z3-z1/(z1+z2*z3))-z1*z2*(z1*z2+(-z1*z2-z3/z2+z1-z2*z1)))))+z1*z2*z3*(z1+z2*z3)))))));
 z1*z2*(z1-z3*(2.154*z1-3.253*z2-5.353)/(z3*z1*z2/(2.544-z1*z2)+(2.143*z1+3.556)*(3.343*z2-4.153*z3-5.456)-(1.153-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.644*z1-3.364*z2-z3))-z2*(z1*z2-z2*z3*3.164+2.267*(z1/z3-z3/(z1-z2*(2.533-z1-z2-z3)))*(z2-z3)-2.453*z1)*(z2-z1)-7.535/z1)*(-1.253/z3+z1*z2*z3*5.353))-3.433*z1-5.455)-7.466*z2-3.577)/(z1-z3)+z1*(z3*z2/(z1-2.699*z3)-z2*(z1*(z3-2.767*z2-z1-5.854)-z2*(-1.549-z1/(-z3-z2))/(z1/z2-z1/(z3/z1-z2/z3)+z3*(1/z1-5.344/z2-z1*z2*(2.435*z1-1.456)*(z3*z2*3.326-5.347)*(1.943-z1*z2*z3*3.245)*(z1+z2))))));
 (z1*z2+z3*(z1*z2-z2*z3*z1-z1+z2-z3))*(z1+z2+z3)*(z1-z2-z3)*(z3-z1*(z3-z2*(z1-z2-z3)))*z1*z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)*(z2*z1+z3*z1+z3*z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2*(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3*(z1-z2*(z3-z1*z2-z2*(z1*z2-z3*z1)-z3*(z3*z1+z2))))-z3*(-z1-z2*(-z3*(-z1*(z2-z3*(z1*z2*z3-z2*z1*z3*(-z1*(z2*z1-z3*z2-z1-z2-z3)))))))))))))));
 (z1*z2+z3/(z1*z2-z2*z3/z1-z1+z2-z3))*(z1+z2+z3)/(z1-z2-z3)*(z3-z1*(z3-z2/(z1-z2-z3)))*z1/z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)/(z2*z1+z3*z1+z3/z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2/(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3/(z1-z2*(z3-z1*z2-z2/(z1*z2-z3*z1)-z3/(z3/z1+z2))))-z3*(-z1-z2*(-z3/(-z1*(z2-z3*(z1*z2/z3-z2*z1*z3/(-z1*(z2*z1-z3*z2-z1-z2-z3)))))))))))))));
 z1*z2*(z1-z3*(2.156*z1-3.652*z2-5.653)/(z3*z1*z2/(2.664-z1*z2)+(2.155*z1+3.543)*(3.345*z2-4.431*z3-5.443)-(1.451-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.453*z1-3.353*z2-z3))-z2*(z1*z2-z2*z3*3.153+2.253*(z1/z3-z3/(z1-z2*(2.533-z1-z2-z3)))*(z2-z3)-2.453*z1)*(z2-z1)-7.553/z1)*(-1.253/z3+z1*z2*z3*5.533))-3.453*z1-5.453)-7.453*z2-3.553)/(z1-z3)+z1*(z3*z2/(z1-2.653*z3)-z2*(z1*(z3-2.753*z2-z1-5.853)-z2*(-1.539-z1/(-z3-z2))/(z1/z2-z1/(z3/z1-z2/z3)+z3*(1/z1-5.553/z2-z1*z2*(2.535*z1-1.53)*(z3*z2*3.536-5.753)*(1.539-z1*z2*z3*3.665)*(z1+z2*(z3-(-z1-z2*z3/(z1*z2-2.863*(z1*z2*(z1-z2*(z1*z3+z2/z3*(2.623*z1-1.352-z3*z2)))))))))))))
 z1*z2*(2.251*z1+1)*(2.243*z1*z2/z3-2.353*z1*(3.475*z3-1)/(2.575*z1-3.675*z2-4.766)*(z1/(3.767*z1-1)-4.176/z1+5.186*(2.866*z1*z2*z3-1.766)/(z2+1.876)-7.165*(2.874*z1*(z2+1.641)*(3.864*z2+2.162)*(3.171/(z1+1.765)-2.173*z3/(2.174*z1*z2*z3-1.171)+(4.171*z1-1.164)*(5.172*z2-7.174)/(z1-2.175*z2-1.747-2.174*z3/(3.618-7.716*z1-8.181*z2*(4.612*z1/(2.189*z3+1.165)-7.198*z1-8.149/z3+9.912*(2.199*z1-1.261)*(3.107*z1+4.179*z2+5.108)*(2.271*z1*z2*z3-7.179)*z1*z2*z3/(z1-z2*2.282-3.621/(z1/(z3-1.147)-7.198/(z2+2.245)+8.233/(2.288*z1*z2*z3+1.247)-9.174)))))/(z1-1.525)))))






 (-ai/x-bi*(-c*z1*x/(-z1-a-bi-x/(-(-x/z1*ci)/y*a-b*y/z1/x-b/i)-z2/(-(-y*b*z1/(-z1/x*c-bi/y*z2*d-i/a))/z1))-di/(x-z2/y*b-b/i-ci/i))-c/bi*(-z1*x*b*z2-a/x*ci*y-i/(-i*x+y/i-z1/i+i/z2)))
 (-a/i/x-(-i)/a/b*(c-d)*y/z1/x-i/(-i)*z2/(z1-x/(-z2/y))-ai/i*(-b*z1/c*x-y/ci/z2)*(-x*bi-y/ci-x/a*y/bi)/(-a-bi-ci*(-z2/x*a-b/z1*ci)-di/(y/(-b)-a*x)+(-x/(-y)*(-a/b-c))/bi-(-ai/bi-ci/(-z1/x-y/z2))/c))
 (-i/(z1/a/x-y/z2/bi)-(-(-i)/(x/a/y-y/b*c*(-x/b/(-c)-(-y)/(-a*x)))))*(-i/a*bi-i*(-x-(-y/a-b)-c/(-a)*b)+(-i)*(-ai)*(-x/(-z1/bi-ci/(-y/(-x*a/y-bi/a))))-(-z1/x-c/z2/y+(-a)*(-ci)/z1/(-x)/bi*y/z2)/i+a/x*b/y*(-x-(-y*a-b-b/x))/(-i))
-(-a/ai/z1-x/bi-ci/y-ci*b/di*(-ci*x-di/y*a/b)/z2-z3/(-z2/(-ci)-i/z1-x/i-i/y))*(-x/(i*z1-y*i*z2)-i*ai/b/x-bi/i/ci*y)/(-y/i/(y*i-z2*i-x*z1*i*a/bi/y)-i/x/z1/(i-ai/2.43/x*z1))
 ((-z1/x)/((-y/z2)-i/z1-z2/i)/(x/i-i/y-(x/(i*z1*y))^2)/(z2*i/x)^2)*((ai/z1-z2/bi)/(z1/x/bi-y/(z2*i*(ci/x*i)^2))-x*z1*bi*i/(-z1*i/ai-i/bi/z2*x-i*bi*x/(-ci*i/(-i/x^2-(i/y)^2))))
 (-ai/bi/x-2.14/8*z1/(y/x-i/z1/y/bi)*(-z1/i-z2/x*(-i-ci-bi/x*z1-i*(i/ai-i/(-x*bi*i/ai-(-ci/i*ai-(i*z1/x^2)^2/(-(-x*i/y^2)^2)-i*(z2*x*i/(i*y/x)^2)^2))))/(-ai/i*(bi*z1*i/(i*x/y)^2)^2)*ci))
 (i*z1*(-ai/z2)/(-x/1.23/y-2.51/(-x/y-1.85/y))-(z1/(-z2)*i*(-y/(-a-c/(-x/b*c-a/y/c*b)))-(-1.42/y*x*(2.53/a/(-b)-1.85/c)-y/(-1.98/y-x/b*c))/(-i/(-ai/z2/bi/(i*x-y/ci)))))
  (a*z1/x*(-bi/y-x/(-ai)/(-i))-(-i)*(-i/(-x/y/c*1.5-y/(-a*x/b)-c/d*a)-2.1i/(-1.7i/z1-1.3i/x-1.9i/(-b/x/y-a/x)-i*x/(2.3i/a/bi/z1-1.4i*(i/y-x*i-(-i)/t-t*(-i))/ci))))
-(-(-z1-(z2+z1+1)+x-2+z1)+z2-z1+(-x))-z1+(-z2+x-x+z1)-x+z2-x+(-z1)-2+(-z1+x+z2-(-x+z2))
-(-(i-i*z1-2+i*((-i*z1-x*2)*(2*i*(-z1)+x*i)-2-i)+z1*(x-(i*(x*z1-z2*y-2*i-3)*x*z2*i-z1*(-i*2-i-z1)-x*i-z1*2)*i*2)-i*2)*z2-i+5)*i-x*z1
z1*z2/(z1+z2)-(z1.re*z2_-x*(z1-y*(z1-z2.re-y)-z1*y-x/z1.re-z2.im/z2_))
-(-(-x-z1)-z1.im/(-z2.re-y-1)*i-(2*x*(-z1)-3/z2+4*z1.re/x-(-z1_-(-(-z2_)-z1_.re/x*(-1-i-3*i-4/(i*2-1/(-i)+z2_-(-x-z1.re/z2.im-i-1)/z1_)*z2_.im)*(z1_*z2_/(-i/(-z1_-1)))))))
-(-(-z1_)-i/z1.re)_/(-z2_-z1_.im-i/x*(x/z1.im-z2_)-(-x/z1-2/(-x-z1_.im)_))_
z1.re-(-z2_.im-z2.re*z1)*z1_^x-z1_-(z2.im*(z1_*(z2+z2)_-(z1_.re+z2).re-i*(z1_*i-z2*z1_.im).im)_-(sin(z1).re^x-(z1^x)_.im)_.im)
z1_*(-z1_-z2.re/z1_.im-(x-(-2/z1_^2)-z2_^x+2/(x*i-z2_.im/z1_)_-z2.re*i)+z1_.im*(i/z1_-2/i-(-i-z1_)_-z1.re/(i-z1_.im/(-i-1))_))
z1_.im*i-(-(-i/z2_^2-z1_.im*(-i-1)^2))
-(-(-z1-a)-((-z1)*(-(a)))-a*2/c*z1/y*(-y)/(-z1)*(a*z1*b+c-d)/(2*z1*y+b*2))-(-((-z1)-y)-(-(-z1-(-y)-a))-b*(-z1)*(-a-b-2))/(-a/b/z1)+(-z1)*(-(-z1*(-(-y*z1*(a*z1*y+b)*(a*z1*y+b)*(-z1-1)*(y+z1*2)))))-(-(-z1*y*(z1*a*b+3)*(-z1*y-c*b*2)/(2*z1*y+b*c)*(2*a-z1)*a*2/3/b*(b+1)))
-(-(-a/z1)-b/y*z1)*(-(-z1/(-y)/a)/(-z1-y/z1))*(-y/a-c/z1)-(z1^2/y^3-z1^(k+1)/y^k-(z1*y-y)/y-(-(-(-z1)))-(-y/(-z1)-(-a-z1)/(-z1^3)))/(-y/z1^4-y/a-k!/y-(k+1)!^z1/y)-(b/y-z1/a)^z1
-(-(-a/z1)-b/z2*z1)*(-(-z1/(-z2)/a)/(-z1-z2/z1))*(-z2/a-c/z1)-(z1^2/z2^3-z1^(k+1)/z2^k-(z1*z2-z2)/z2-(-(-(-z1)))-(-z2/(-z1)-(-a-z1)/(-z1^3)))/(-z2/z1^4-z2/a-k!/z2-(k+1)!^z1/z2)-(b/z2-z1/a)^z1
z1^(k+n)-(z1/z2)^(n*k+k)-(z1^k*z2^7)/((z2/z1)^k+(z1+z2)^9)+((z1/z2-z2/z1)*(z1*z2/(x+z2)))^(-k*2-n)*((z1*z2*(z1+z2))^9+(z2/z1-z2*z1)^(-7))
1/z1-z1/sin(1/z1)-((-1/z1)*sin(-1/z1+1/z2)-1/sin(1/z1)/z2/z1)
z1*z2*(2*z1+1)*(2*z1*z2/t-2*z1*(3*t-1)/(2*z1-3*z2-4)*(z1/(3*z1-1)-4/z1+5*(2*z1*z2*t-1)/(z2+1)-7*(2*z1*(z2+1)*(3*z2+2)*(3/(z1+1)-2*t/(2*z1*z2*t-1)+(4*z1-1)*(5*z2-7)/(z1-2*z2-1-2*t/(3-7*z1-8*z2*(4*z1/(2*t+1)-7*z1-8/t+9*(2*z1-1)*(3*z1+4*z2+5)*(2*z1*z2*t-7)*z1*z2*t/(z1-z2*2-3/(z1/(t-1)-7/(z2+2)+8/(2*z1*z2*t+1)-9)))))/(z1-1)))))
z1/z2+z1/z2*(z1/z2+z1/z2*(z1/z2+z1/z2*(z1/z2+z1/z2*(z1/z2+z1/z2*(z1/z2+z1/z2*(z1/z2+z1/z2*(z1/z2+z1/z2*(z1/z2+z1*z2))))))))
-z1*(z2/x-x/z2)-(-(-x-1-z2)-(-z2/y)*z1*(-z2-x)+z2/z1-z1/z2)*(z1/z2-z2/z1/(z1/z2-x/z1)-x/y*z1+z1)+((z2/z1-z1/z2)*z1-x/(z1/z2+z2/z1)+z1/(x/z1-z2/y))
(z1/z2+z2/z1)*(z1/(z1+z2)+z2/(z1-z2)-(z1/z2)*(x/z1-z2/y))+z1*x*(x/z1+y/z2)/(z1/x-z2/y)*(z1-z2/z1-x/z2-x/(z1+z2))+(x/(z1-z2)-z1/(z2-z1)-z2/(z1+z2))+z1*z2/((z1/z2+z2/z1)*(z1/(z1+z2)+z2/(z1-z2)-(z1/z2)*(x/z1-z2/y))+z1*x*(x/z1+y/z2)/(z1/x-z2/y)*(z1-z2/z1-x/z2-x/(z1+z2))+(x/(z1-z2)-z1/(z2-z1)-z2/(z1+z2)))
z1/(x/(z2/(-z3/(x-y/x)+y/(-z1/x+y/z2)-z2*x/(y/z3-x/(z3-z2*y/z1)))-2.1*z1*x/(-2.2/z1+3.1/(-x/z3*1.2+2.3*z2/(y-z1)*(z2-x)*(y-x/y)))))*(-2.1/z2*(z2+x)*(y+(z1-z3/(-z1*(-y/z1-z2*(-z2/(-z3)-y/(-z2/(-x/y/t)))))))*(z2-(x/y-2.1/(-y/(-y/t-x/(y-t/x)))))/(2.3*y*(-z1*(y*z3*2.1/(-z2/(-y/z3))+(y+z1)/(x/(-z2+z1/y/x)))+3.1*z2*(x-t/(-y*1.7/(2.6*x-4.5/y)))*y/(2.1*z2*z3/(-(-t/z1-(-z3/x-(-y/z2-(-y/z3-x/z2*x/z1)))))))*x*(z1-z2/(-x/z3+y/(x+z1/z2-z3/(-z2*(-z1*z2/(-z2+z1*y))+x))))))

z1/(-i/z1/x-x/(z2/(-z3/(x-y/x/i)+i*y/(-z1/x+y/z2)-z2*x/(y/z3*i-x/(z3-z2*y/z1)))-2.1i*z1*x/(-2.2/z1+3.1i/(-x*i/z3*1.2+2.3*z2/(y/i-i/z1)*(z2-i/x)*(y-x/y)))))*(-2.1/z2*(z2*i+x)*(y+(z1-z3/(-z1*(-y/z1-i*z2*(-z2/(-z3/i)-i*y/(-z2/(-x/y/t)))))))*(z2-(x/y-2.1/(-i/(-z1/i-i/(-z1*x/i-i/(z3/z2*i-y*x*i)))-y/(-y/t-x/(y-t/x)))))/(2.3*y*(-z1*(y*z3*2.1/(-z2/(-y/z3))+(y+z1)/(-i*x/(-z2*i+z1/y/x)))+3.1i*z2*(x-t/(-y*1.7/(2.6*x-4.5/y)))*y/(2.1*z2*z3/(-(-t/z1-(-z3/x-(-y/z2-(-i-y/z3-x/z2*x/z1)))))))*x*(z1-z2/(-x/z3+y/(x+z1/z2-z3/(-z2*(-z1*z2/(-z2+z1*y))+x))))))

 (x/(y/z1-x/z2)-z2/(x*z1/(x/z3)-y/z1))/(z1*(x/z2-y/z1*(z1*y/(y/z3-x*y/(z1/x-z3/y)))))


 -(-x/z1-z2/(x+y)-ci*x+y/bi)/(ci/z1-z2/bi-ci*z1/z2/(z2*t/(-x/z3+bi))-y/(-ai*z1/(-y/z2-bi/z3-x)))*(z1*(-z2/(-x/(-ci/(-z3-z2/(-y/(z2/x-y/z1/ci*y/z3)))))-ci*z1*x/(-z2/ai/t/z3+y/(-z2/(-x/(-y*(-z3/x-y*t/z2)))))))


 (z1^(-z2/z1)-z2^(-z1/z2))*(z1^(2*k+k*j+1)*(-z2)^(2*k+1)-(z1/z2)^(ai*i)*(-ai*i)^(-z2/z1))/(i^(-z1/z2)*(-1+0i)^(-z2/z1)-(z2/z1)^(i*k+1))/(ai^(i*z1)/(-i)^(bi/z2)-ci/(-(-z1)^(-i/z2)*bi/(-z2/z1)^(-ai/bi+i/z2)))


}

   {

    x=1; y=2;
    (2^(n+k)+2^(x+y)+3^(n+k)+3^(x+y)+ai^(n+k)+ai^(x+y))/(-2^(n+k)-2^(x+y)-3^(n+k)-3^(x+y)-ai^(n+k)-ai^(x+y))
    2^vi[k]
    ((-1)^(n+k)+(-1)^(x+y))/(-(-1)^(n+k)-(-1)^(x+y))
    ((-1+0i)^(n+k)+(-1+0i)^(x+y)+(i)^(n+k)+(i)^(x+y)+(-i)^(n+k)+(-i)^(x+y))/(-(-1+0i)^(n+k)-(-1+0i)^(x+y)-(i)^(n+k)-(i)^(x+y)-(-i)^(n+k)-(-i)^(x+y))

    (i)^vi[k]+(-i)^vi[k]


    (i)^z1+(-i)^z1

    a^z1+ai^z1

    ((sin(a)+2)^(n+k)+(sin(ai)+2)^(n+k)+(sin(a)+2)^(x+y)+(sin(ai)+2)^(x+y)+(sin(a)+2)^(z1)+(sin(ai)+2)^(z1))/ (-(sin(a)+2)^(n+k)-(sin(ai)+2)^(n+k)-(sin(a)+2)^(x+y)-(sin(ai)+2)^(x+y)-(sin(a)+2)^(z1)-(sin(ai)+2)^(z1))



   }
 //  Reduce arg
 {
  power(   (sin(a/b)/c+c/cos(b/a)+2),(a*cos(a-b)+b*cos(b-a))   )
  x*power(-b/power(cos(a-c)/a+a/sin(c-a)+b/c,c/power(d/sin(d/c-a)-b/cos(c/d+b),cos(b-d)*sin(c/a)-cos(a/sin(b/d)) ) ),(-a*cos(c/a)-power((sin(a/b)/c+c/cos(b/a)+2),(a*cos(a-b)+b*cos(b-a)))/c))
  x*power(-b/power(cos(a-c)/a+a/sin(c-a)+b/c,c/power(d/sin(d/c-a)-b/cos(c/d+b),cos(b-d)*sin(c/a)-cos(a/sin(b/d)) ) ),x+(-a*cos(c/a)-power((sin(a/b)/c+c/cos(b/a)+2),(a*cos(a-b)+b*cos(b-a)))/c))
  x*power(-bi/power(cos(ai-c)/a+a/sin(c-a)+bi/c,c/power(di/sin(d/c-a)-bi/cos(c/d+b),cos(b-d)*sin(c/ai)-cos(a/sin(b/d)) ) ),x+(-ai*cos(c/a)-power((sin(ai/b)/c+ci/cos(b/a)+2),(a*cos(a-b)+bi*cos(b-a)))/c))
 }

{
(sin(a-b)+cos(b/c))^((sin(a*b/(a+b))+cos(b/(c+a)))^x)*((sin(a*c/(a-b))+cos(c/(c+b)))^((-sin(b*c/(c-b))-cos(c*a/(c/b-b)))^((sin(a/(c/a-b/c))-cos(c*a/(c/b-b)))^x))+(sin(c/(a/b-b/a))-cos(b/(b/c-c/b)))^((sin(b/(a*b-b/a))+cos(c/(b/c-c*b)))^((sin(a/(b/(a-c/b)))+cos(c/(b*c+c/(b+a/b))))^x)))*(sin(b*(a/(c-b/a)))-cos(c*(b/(c-c/b))))^((sin(a/(b/(a-c/b)))+cos(c/(b*c+c/(b+a/b))))^x)

(sin(ai-bi)+cos(bi/c))^((sin(ai*bi/(ai+bi))+cos(bi/(c+ai)))^(x/y))*((sin(ai*c/(ai-bi))+cos(c/(c+bi)))^((-sin(bi*c/(c-bi))-cos(c*ai/(c/bi-bi)))^((sin(ai/(c/ai-bi/c))-cos(c*ai/(c/bi-bi)))^(x/y)))+(sin(c/(ai/bi-bi/ai))-cos(bi/(bi/c-c/bi)))^((sin(bi/(ai*bi-bi/ai))+cos(c/(bi/c-c*bi)))^((sin(ai/(bi/(ai-c/bi)))+cos(c/(bi*c+c/(bi+ai/bi))))^(x/y))))*(sin(bi*(ai/(c-bi/ai)))-cos(c*(bi/(c-c/bi))))^((sin(ai/(bi/(ai-c/bi)))+cos(c/(bi*c+c/(bi+ai/bi))))^(x/y))

}

{


  x*root(a*(b+c*(d-e/(a+1)-d*(2*c-b/(a-e))))+c/d*(a+b/(c-d)),k+n)+y*root(-b*(d+c*(d-a/(a+2)-b*(2*a-c/(b-e))))-b/a*(c+d/(c+d)),k+j)
  root(sin((a-b)^(c/d+1))+cos(2*a-3*b+2*d/(c+3)+4*d)^atan2(a*(b-c)*(c/(d+4/a)),b-c/(2-b+5/a)),n+k)
  root((sp2(a/c-b/(b-3/a),2*a-3/(4-b/d))*sp3(a/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)))^(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c))+3*a*cos(c/b)),k+j)
 ((x-y)/x+y/t)*root((sp2(a/c-b/(b-3/a),2*a-3/(4-b/d))*sp3(a/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)))^(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c))+3*a*cos(c/b)),k+j)-(y/x-t/(y*2+t))/root((sp2(a/c-b/(b-3/a),2*a-3/(4-b/d))*sp3(a/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)))^(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c))+3*a*cos(c/b)),k+j)

 (a+b/c-d/(2*c+a))^(sin(a/b-c)+cos(b/c-2*a/(b-d)))
 (cos(a+b/c)-sin(d/(2*c+a)))^(sin(a/b-c)+cos(b/c-2*a/(b-d)))
  (sin(a/b-c)+cos(b/c-2*a/(b-d)))^(sin(b/a-c)+cos(a/c-2*d/(a-d)))
  (sin(d/a-c/b)-b*cos(a/c-2*b/(d-a)))^(c*sin(b/d-a/c)-a*cos(3/c-2*d/(3*a-b)))

 (sin(a/b-c)+cos(b/c-2*a/(b-d)))^x
 (sin(b/a-c)+cos(a/c-2*d/(a-d)))^x
 (sin(d/a-c/b)-b*cos(a/c-2*b/(d-a)))^x
 (c*sin(b/d-a/c)-a*cos(3/c-2*d/(3*a-b)))^x

  (a+b/c-d/(2*c+a))^(sin(a/b-c)+cos(b/c-2*a/(b-d)))*root((sp2(a/c-b/(b-3/a),2*a-3/(4-b/d))*sp3(a/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)))^(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c))+3*a*cos(c/b)),k+j) + (cos(a+b/c)-sin(d/(2*c+a)))^(sin(a/b-c)+cos(b/c-2*a/(b-d)))*root((sp2(a/c-b/(b-3/a),2*a-3/(4-b/d))*sp3(a/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)))^(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c))+3*a*cos(c/b)),k+j)+ (sin(d/a-c/b)-b*cos(a/c-2*b/(d-a)))^(c*sin(b/d-a/c)-a*cos(3/c-2*d/(3*a-b)))+ (sin(d/a-c/b)-b*cos(a/c-2*b/(d-a)))^(c*sin(b/d-a/c)-a*cos(3/c-2*d/(3*a-b)))

  (sin(a/b-c)+cos(b/c-2*a/(b-d)))^x*root((sp2(a/c-b/(b-3/a),2*a-3/(4-b/d))*sp3(a/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)))^(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c))+3*a*cos(c/b)),k+j) +  (sin(b/a-c)+cos(a/c-2*d/(a-d)))^x *root((sp2(a/c-b/(b-3/a),2*a-3/(4-b/d))*sp3(a/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)))^(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c))+3*a*cos(c/b)),k+j)+ (sin(d/a-c/b)-b*cos(a/c-2*b/(d-a)))^x

  root(sp3(a/b,b/c,sp3(a-b,b-c,c/a))+b*sp3(c/sp2(-a+1,b+c),c-a,b-sp2(a+1,b-2)),n+k)
  root(sin(a/b)*cos(b/c)-sp3(c/a,b-sp1(c+a)/b,b+c*2),n+2)
  root(a*sp3(b+1/a,c-2/b,a+3/c)-c/sp2(c/sp1(c-a/d),b-sin(b*2+1/c)),k+1)
  root(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c)),k+3)
  root(2*a-3/(4-b/d)*sp3(cos(a-sin(b/sp1(c/b)))/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)),k+5)


  (root(sp3(a/b,b/c,sp3(a-b,b-c,c/a))+b*sp3(c/sp2(-a+1,b+c),c-a,b-sp2(a+1,b-2)),n+k)*root(sin(a/b)*cos(b/c)-sp3(c/a,b-sp1(c+a)/b,b+c*2),n+2)-root(a*sp3(b+1/a,c-2/b,a+3/c)-c/sp2(c/sp1(c-a/d),b-sin(b*2+1/c)),k+1))/(root(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c)),k+3)+root(2*a-3/(4-b/d)*sp3(cos(a-sin(b/sp1(c/b)))/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)),k+5))

  (root(sp3(a/b,b/c,sp3(a-b,b-c,c/a))+bi*sp3(c/sp2(-a+1,b+c),c-a,b-sp2(a+1,b-2)),n+k)*root(sin(ai/b)*cos(b/ci)-sp3(c/a,b-sp1(c+a)/b,b+c*2),n+2)-root(ai*sp3(b+1/a,c-2/b,a+3/c)-ci/sp2(c/sp1(c-a/d),b-sin(b*2+1/c)),k+1))/(root(ai/sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c)),k+3)+root(2*ai-3/(4-b/di)*sp3(cos(a-sin(b/sp1(c/b)))/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)),k+5))

  (root(sp3(a/b,b/c,sp3(a-b,b-c,c/a))+bi*sp3(c/sp2(-a+1,b+c),c-a,b-sp2(a+1,b-2)),n+k)*root(sin(a/b)*cos(b/c)-sp3(c/a,b-sp1(c+a)/b,b+c*2),n+2)-root(ai*sp3(b+1/a,c-2/b,a+3/c)-c/sp2(c/sp1(c-a/d),b-sin(b*2+1/c)),k+1))/(root(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c)),k+3)+root(2*ai-3/(4-b/di)*sp3(cos(a-sin(b/sp1(c/b)))/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)),k+5))


   x=2
  (power(sp3(a/b,b/c,sp3(a-b,b-c,c/a))+b*sp3(c/sp2(-a+1,b+c),c-a,b-sp2(a+1,b-2)),n+x)*power(sin(a/b)*cos(b/c)-sp3(c/a,b-sp1(c+a)/b,b+c*2),n+x)-power(a*sp3(b+1/a,c-2/b,a+3/c)-c/sp2(c/sp1(c-a/d),b-sin(b*2+1/c)),k+1))/(power(sp2(a+b,c/d)/sp3(a-b/c+d,b/(c-a),c/(b-d)+d/(a+c)),x+3)+power(2*a-3/(4-b/d)*sp3(cos(a-sin(b/sp1(c/b)))/(b/c-d/b),a/d-c/a,sin(a-b/c+d/b)),x+5))

}

 {

  log(x,sin(a/b)+3)
  log(x+y,sin(c/b)+cos(b/a)+4)
  log(x^2+y^2,sin(a/(a+b))+cos(b/(a-b))+4)
  log(x+y/x,sin(cos(c/a)+a/sin(c-b))+cos(d/(a-b))+4)
  log(x/y+y/(y-x),sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5)


  log(x/y+y/(y-x),sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5)*(log(x,sin(a/b)+3)*log(x^2+y^2,sin(a/(a+b))+cos(b/(a-b))+4)- log(x+y,sin(c/b)+cos(b/a)+4)/log(x+y/x,sin(cos(c/a)+a/sin(c-b))+cos(d/(a-b))+4))
  ln(sin(a/b)*cos(b/a)+4)*log(a/(a+b)+3,b/(2*b+a)+5)+log(sin(a-2*b)+3,cos(2*b+3*a)+5)*log(x/y+y/(y-x),sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2)+5)) + (cos(2*c/b)-log(cos(a/b)-sin(3*c+1)+4,sin(a*5/c)+2*cos(6*c-d)+7))*log(x+y/x,sin(cos(c/a)+a/sin(c-b))+cos(d/(a-b))+4)

  log(z1/y+y/(z2-x),sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5)*(log(z1,sin(a/b)+3)*log(z1^2+z2^2,sin(a/(a+b))+cos(b/(a-b))+4)- log(z1+z2,sin(c/b)+cos(b/a)+4)/log(z1+y/z1,sin(cos(c/a)+a/sin(c-b))+cos(d/(a-b))+4))
  ln(sin(a/b)*cos(b/a)+4)*log(a/(a+b)+3,b/(2*b+a)+5)+log(sin(a-2*b)+3,cos(2*b+3*a)+5)*log(z1/y+y/(z2-x),sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2)+5)) + (cos(2*c/b)-log(cos(a/b)-sin(3*c+1)+4,sin(a*5/c)+2*cos(6*c-d)+7))*log(x+z2/x,sin(cos(c/a)+a/sin(c-b))+cos(d/(a-b))+4)




  log(sin(a/b)+4,x)
  log(sin(c/b)+cos(b/a)+5,y-x)
  log(sin(a/(a+b))+cos(b/(a-b))+7,x^2+y^2)
  log(sin(cos(c/a)+a/sin(c-b))+cos(d/(a-b))+7,y+x/y)
  log(sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5, y/x+x/(y-x) )



   ( log(sin(a/b)+4,x)*log(x/y+y/(y-x),sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5)+log(x,sin(a/b)+3)/log(sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5, y/x+x/(y-x) ) )/(log(sin(cos(c/a)+a/sin(c-b))+cos(d/(a-b))+7,y+x/y)+ log(x^2+y^2,sin(a/(a+b))+cos(b/(a-b))+4))

    log(sin(a-2*b)+3,cos(2*b+3*a)+5)*log(sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5, y/x+x/(y-x) )*ln(sin(a/b)*cos(b/a)+4)*log(x/y+y/(y-x),sin(2*a-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5)

    ( log(sin(ai/b)+4,x)*log(x/y+y/(y-x),sin(2*ai-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5)+log(x,sin(ai/b)+3)/log(sin(2*ai-b)*cos(a*b+a)+a/((cos(a)+2)^(sin(b)+2))+5, y/x+x/(y-x) ) )/(log(sin(cos(c/ai)+a/sin(c-b))+cos(d/(a-b))+7,y+x/y)+ log(x^2+y^2,sin(ai/(a+b))+cos(b/(a-b))+4))

    log(sin(ai-2*b)+3,cos(2*bi+3*a)+5)*log(sin(2*ai-b)*cos(a*b+a)+a/((cos(ai)+2)^(sin(b)+2))+5, y/x+x/(y-x) )*ln(sin(ai/b)*cos(b/a)+4)*log(x/y+y/(y-x),sin(2*ai-b)*cos(a*b+a)+a/((cos(ai)+2)^(sin(bi)+2))+5)




  }




      {

      (sin(x)*cos(x)*log(sin(a)+cos(b)+5,x)*cos(x)*sin(x+1)+cos(x+1)*log(x,sin(a)+cos(b)+5)*sin(x))/(sin(x+1)*log(sin(a)+cos(b)+5,x)*cos(x)+cos(x)*log(x,sin(a)+cos(b)+5)*sin(x+1))
      (sin(x)*cos(x)*log(sin(ai)+cos(b)+5,x)*cos(x)*sin(x+1)+cos(x+1)*log(x,sin(ai)+cos(b)+5)*sin(x))/(sin(x+1)*log(sin(ai)+cos(b)+5,x)*cos(x)+cos(x)*log(x,sin(ai)+cos(b)+5)*sin(x+1))

      }

      // (log(sin(a/(b+a))+3,x)*log(y,cos(b/(b+a))+4)+log(sin(ai/(bi+a)),x)*log(y,cos(bi/(b+ai))))/((log(sin(a/(b-a)),z1)*log(z2,cos(b/(b-a)))+log(sin(ai/(bi-a)),z1)*log(z2,cos(bi/(b-ai)))))
    //  (  log(sin(a/(b+a))+3,x)*log(sin(ai/(bi+a)),x)+log(y,cos(b/(b+a))+4)*log(y,cos(bi/(b+ai))))*((log(sin(a/(b-a)),z1)*log(z2,cos(b/(b-a)))+log(sin(ai/(bi-a)),z1)*log(z2,cos(bi/(b-ai)))))



// (x/k-k/y)/(x*i-i*k-y/i)*(k/i-i/k-k/2.257-k/(4.763/k-7.543/i)+i/(x-k)*(y+k*2.765)*(2.57i-2.13)/(-5.322-3.567i))*(k*x-y*k-y/k-k/x-i/k-k/i-2.15/k-k/3.234)/(-(i-k)-k/(x/y-i)+(i/x-y/i)/k+k*(x*y-i/(x-y/i))-(i*(-x-y*i/k))*k)


//x=1.1; y=2.2; t=-3.3; x=sin(x)*cos(y)*cos(t)*sin(x+y+t)*(x/t-t/y); y=sin(x)*cos(y)*cos(t)*cos(x+y+t)*(x/t-t/y); y=sin(x)*cos(y)*cos(t)*cos(x+y+t)*(x/t-t/y); t=sin(x)*cos(y)*cos(t)*cos(x+y+t)*(x/t-t/y); x=sin(x)*cos(y)*cos(t)*cos(x+y+t)*(x/t-t/y); x+y+t
//x=1.1; y=2.2; t=-3.3; x=sin(x)*cos(y)*cos(x)*sin(x/y+y/t+t/x)*(sin(x/y)+cos(y/t)+sin(t/x))*(cos(x/y)+sin(y/t)+cos(t/x)); y=sin(x)*cos(y)*cos(x)*sin(x/y+y/t+t/x)*(sin(x/y)+cos(y/t)+sin(t/x))*(cos(x/y)+sin(y/t)+cos(t/x)); y=sin(x)*cos(y)*cos(x)*sin(x/y+y/t+t/x)*(sin(x/y)+cos(y/t)+sin(t/x))*(cos(x/y)+sin(y/t)+cos(t/x)); t=sin(x)*cos(y)*cos(x)*sin(x/y+y/t+t/x)*(sin(x/y)+cos(y/t)+sin(t/x))*(cos(x/y)+sin(y/t)+cos(t/x)); x=sin(x)*cos(y)*cos(x)*sin(x/y+y/t+t/x)*(sin(x/y)+cos(y/t)+sin(t/x))*(cos(x/y)+sin(y/t)+cos(t/x)); x+y+t

//z1=2.1+0.1i; z2=0.5+0.2i; z1=sin(x+cos(z1))*cos(z2)+sin(z1)/cos(z2)-(x+cos(z1))*(x-sin(z1)/cos(z2))*(sin(x+cos(z1))+cos(z2)/sin(z1));z2=sin(x)*(cos(z2)/sin(z1)-x/z1)*(z1/z2-cos(x/z1)*sin(z1/z2));z1=((z1/z2-z2/z1)*(z2/z1-z1/z2)*sin(z1/z2-z2/z1)*cos(z2/z1-z1/z2))/(z2+z1);z1=(sin(x)*sin(z1)+cos(x)*cos(z1))*(sin(sin(x)*sin(z1))-cos(cos(x)*cos(z1)))/(sin(z1)*(z1+z2)^2+cos(z1)*(z1+z2)^2);z2=(z1/sin(z1)-z2/cos(z2))*(sin(z1/sin(z1))-cos(z2/cos(z2)));z1+z2


//polyn(vd: array double; x: double)=l:int=len(vd); s:dbl=0; ifp(l=0,goto(endp)); i:int=0; s=vd[l-1]; fordown(i,l-2,0,s=s*x+vd[i]); endp>> s
//polyn(vd: array double; x: complex double):complex=l:int=len(vd); s:Cxdbl=0+0*i; ifp(l=0,goto(endp)); j:int=0; s.re=vd[l-1]; fordown(j,l-2,0,s=s*x+vd[j]); endp>> s


{
 poly(9,-8,7,-6,5,-4,3,-2,1,-12.34,z1)
 9*z1^9-8*z1^8+7*z1^7-6*z1^6+5*z1^5-4*z1^4+3*z1^3-2*z1^2+z1-12.34
 (((((((((9*z1-8)*z1+7)*z1-6)*z1+5)*z1-4)*z1+3)*z1-2)*z1+1)*z1)-12.34
}

                                                                              {POLY}
//poly(a,2,(a+b)/c,3,4+5,4,5,a*c-d*b,b/a-c,a*(b-(c/d+a/(b-c))),a*b*c,x) - (a*x^10+2*x^9+((a+b)/c)*x^8+3*x^7+(4+5)*x^6+4*x^5+5*x^4+(a*c-d*b)*x^3+(b/a-c)*x^2+(a*(b-(c/d+a/(b-c))))*x+a*b*c)
//poly(2*s,0,a/b-c,2,0,0,s*v/q,b*(c-a),s+q,q-s,3,4*(a+b),c*b/(a*s-c*v),s*a/(b-c*v),q/(s-b*v),x)- (2*s*x^14+(a/b-c)*x^12+2*x^11+(s*v/q)*x^8+(b*(c-a))*x^7+(s+q)*x^6+(q-s)*x^5+3*x^4+(4*(a+b))*x^3+(c*b/(a*s-c*v))*x^2+(s*a/(b-c*v))*x+q/(s-b*v))
//poly(a,2i,(a+b)/c,3i-2,4i+5i,4,5,ai*c-d*bi,b/a-c,a*(bi-(c/d+a/(b-ci))),a*b*c-ai*bi*ci,x) - (a*x^10+2i*x^9+((a+b)/c)*x^8+(3i-2)*x^7+(4i+5i)*x^6+4*x^5+5*x^4+(ai*c-d*bi)*x^3+(b/a-c)*x^2+(a*(bi-(c/d+a/(b-ci))))*x+a*b*c-ai*bi*ci)
//poly(z4+s,0,2*a,3,i/bi,s+p,z5+z4*z5,p-q,4,0,a+b/c,z4-z4*z5,x)-((z4+s)*x^11+(2*a)*x^9+3*x^8+(i/bi)*x^7+(s+p)*x^6+(z5+z4*z5)*x^5+(p-q)*x^4+4*x^3+(a+b/c)*x+z4-z4*z5)

//poly(a,2,(a+b)/c,3,4+5,4,5,a*c-d*b,b/a-c,a*(b-(c/d+a/(b-c))),a*b*c,(x/(y+t))) - (a*(x/(y+t))^10+2*(x/(y+t))^9+((a+b)/c)*(x/(y+t))^8+3*(x/(y+t))^7+(4+5)*(x/(y+t))^6+4*(x/(y+t))^5+5*(x/(y+t))^4+(a*c-d*b)*(x/(y+t))^3+(b/a-c)*(x/(y+t))^2+(a*(b-(c/d+a/(b-c))))*(x/(y+t))+a*b*c)
//poly(2*s,0,a/b-c,2,0,0,s*v/q,b*(c-a),s+q,q-s,3,4*(a+b),c*b/(a*s-c*v),s*a/(b-c*v),q/(s-b*v),(x/(y+t)))- (2*s*(x/(y+t))^14+(a/b-c)*(x/(y+t))^12+2*(x/(y+t))^11+(s*v/q)*(x/(y+t))^8+(b*(c-a))*(x/(y+t))^7+(s+q)*(x/(y+t))^6+(q-s)*(x/(y+t))^5+3*(x/(y+t))^4+(4*(a+b))*(x/(y+t))^3+(c*b/(a*s-c*v))*(x/(y+t))^2+(s*a/(b-c*v))*(x/(y+t))+q/(s-b*v))
//poly(a,2i,(a+b)/c,3i-2,4i+5i,4,5,ai*c-d*bi,b/a-c,a*(bi-(c/d+a/(b-ci))),a*b*c-ai*bi*ci,(x/(y+t))) - (a*(x/(y+t))^10+2i*(x/(y+t))^9+((a+b)/c)*(x/(y+t))^8+(3i-2)*(x/(y+t))^7+(4i+5i)*(x/(y+t))^6+4*(x/(y+t))^5+5*(x/(y+t))^4+(ai*c-d*bi)*(x/(y+t))^3+(b/a-c)*(x/(y+t))^2+(a*(bi-(c/d+a/(b-ci))))*(x/(y+t))+a*b*c-ai*bi*ci)
//poly(z4+s,0,2*a,3,i/bi,s+p,z5+z4*z5,p-q,4,0,a+b/c,z4-z4*z5,(x/(y+t)))-((z4+s)*(x/(y+t))^11+(2*a)*(x/(y+t))^9+3*(x/(y+t))^8+(i/bi)*(x/(y+t))^7+(s+p)*(x/(y+t))^6+(z5+z4*z5)*(x/(y+t))^5+(p-q)*(x/(y+t))^4+4*(x/(y+t))^3+(a+b/c)*(x/(y+t))+z4-z4*z5)


//(poly(a,2,(a+b)/c,3,4+5,4,5,a*c-d*b,b/a-c,a*(b-(c/d+a/(b-c))),a*b*c,(x/(y+t)))*poly(a,2i,(a+b)/c,3i-2,4i+5i,4,5,ai*c-d*bi,b/a-c,a*(bi-(c/d+a/(b-ci))),a*b*c-ai*bi*ci,(x/(y+t))))/(poly(2*s,0,a/b-c,2,0,0,s*v/q,b*(c-a),s+q,q-s,3,4*(a+b),c*b/(a*s-c*v),s*a/(b-c*v),q/(s-b*v),(x/(y+t)))-poly(z4+s,0,2*a,3,i/bi,s+p,z5+z4*z5,p-q,4,0,a+b/c,z4-z4*z5,(x/(y+t))))
//(((a*(x/(y+t))^10+2*(x/(y+t))^9+((a+b)/c)*(x/(y+t))^8+3*(x/(y+t))^7+(4+5)*(x/(y+t))^6+4*(x/(y+t))^5+5*(x/(y+t))^4+(a*c-d*b)*(x/(y+t))^3+(b/a-c)*(x/(y+t))^2+(a*(b-(c/d+a/(b-c))))*(x/(y+t))+a*b*c))*((a*(x/(y+t))^10+2i*(x/(y+t))^9+((a+b)/c)*(x/(y+t))^8+(3i-2)*(x/(y+t))^7+(4i+5i)*(x/(y+t))^6+4*(x/(y+t))^5+5*(x/(y+t))^4+(ai*c-d*bi)*(x/(y+t))^3+(b/a-c)*(x/(y+t))^2+(a*(bi-(c/d+a/(b-ci))))*(x/(y+t))+a*b*c-ai*bi*ci)))/(((2*s*(x/(y+t))^14+(a/b-c)*(x/(y+t))^12+2*(x/(y+t))^11+(s*v/q)*(x/(y+t))^8+(b*(c-a))*(x/(y+t))^7+(s+q)*(x/(y+t))^6+(q-s)*(x/(y+t))^5+3*(x/(y+t))^4+(4*(a+b))*(x/(y+t))^3+(c*b/(a*s-c*v))*(x/(y+t))^2+(s*a/(b-c*v))*(x/(y+t))+q/(s-b*v)))-(((z4+s)*(x/(y+t))^11+(2*a)*(x/(y+t))^9+3*(x/(y+t))^8+(i/bi)*(x/(y+t))^7+(s+p)*(x/(y+t))^6+(z5+z4*z5)*(x/(y+t))^5+(p-q)*(x/(y+t))^4+4*(x/(y+t))^3+(a+b/c)*(x/(y+t))+z4-z4*z5)))




//poly(a,2,(a+b)/c,3,4+5,4,5,a*c-d*b,b/a-c,a*(b-(c/d+a/(b-c))),a*b*c,(z1/(z2+z3))) - (a*(z1/(z2+z3))^10+2*(z1/(z2+z3))^9+((a+b)/c)*(z1/(z2+z3))^8+3*(z1/(z2+z3))^7+(4+5)*(z1/(z2+z3))^6+4*(z1/(z2+z3))^5+5*(z1/(z2+z3))^4+(a*c-d*b)*(z1/(z2+z3))^3+(b/a-c)*(z1/(z2+z3))^2+(a*(b-(c/d+a/(b-c))))*(z1/(z2+z3))+a*b*c)
//poly(2*s,0,a/b-c,2,0,0,s*v/q,b*(c-a),s+q,q-s,3,4*(a+b),c*b/(a*s-c*v),s*a/(b-c*v),q/(s-b*v),(z1/(z2+z3)))- (2*s*(z1/(z2+z3))^14+(a/b-c)*(z1/(z2+z3))^12+2*(z1/(z2+z3))^11+(s*v/q)*(z1/(z2+z3))^8+(b*(c-a))*(z1/(z2+z3))^7+(s+q)*(z1/(z2+z3))^6+(q-s)*(z1/(z2+z3))^5+3*(z1/(z2+z3))^4+(4*(a+b))*(z1/(z2+z3))^3+(c*b/(a*s-c*v))*(z1/(z2+z3))^2+(s*a/(b-c*v))*(z1/(z2+z3))+q/(s-b*v))
//poly(a,2i,(a+b)/c,3i-2,4i+5i,4,5,ai*c-d*bi,b/a-c,a*(bi-(c/d+a/(b-ci))),a*b*c-ai*bi*ci,(z1/(z2+z3))) - (a*(z1/(z2+z3))^10+2i*(z1/(z2+z3))^9+((a+b)/c)*(z1/(z2+z3))^8+(3i-2)*(z1/(z2+z3))^7+(4i+5i)*(z1/(z2+z3))^6+4*(z1/(z2+z3))^5+5*(z1/(z2+z3))^4+(ai*c-d*bi)*(z1/(z2+z3))^3+(b/a-c)*(z1/(z2+z3))^2+(a*(bi-(c/d+a/(b-ci))))*(z1/(z2+z3))+a*b*c-ai*bi*ci)
//poly(z4+s,0,2*a,3,i/bi,s+p,z5+z4*z5,p-q,4,0,a+b/c,z4-z4*z5,(z1/(z2+z3)))-((z4+s)*(z1/(z2+z3))^11+(2*a)*(z1/(z2+z3))^9+3*(z1/(z2+z3))^8+(i/bi)*(z1/(z2+z3))^7+(s+p)*(z1/(z2+z3))^6+(z5+z4*z5)*(z1/(z2+z3))^5+(p-q)*(z1/(z2+z3))^4+4*(z1/(z2+z3))^3+(a+b/c)*(z1/(z2+z3))+z4-z4*z5)



//(poly(a,2,(a+b)/c,3,4+5,4,5,a*c-d*b,b/a-c,a*(b-(c/d+a/(b-c))),a*b*c,(z1/(z2+z3)))*poly(a,2i,(a+b)/c,3i-2,4i+5i,4,5,ai*c-d*bi,b/a-c,a*(bi-(c/d+a/(b-ci))),a*b*c-ai*bi*ci,(z1/(z2+z3))))/(poly(2*s,0,a/b-c,2,0,0,s*v/q,b*(c-a),s+q,q-s,3,4*(a+b),c*b/(a*s-c*v),s*a/(b-c*v),q/(s-b*v),(z1/(z2+z3)))-poly(z4+s,0,2*a,3,i/bi,s+p,z5+z4*z5,p-q,4,0,a+b/c,z4-z4*z5,(z1/(z2+z3))))
//(((a*(z1/(z2+z3))^10+2*(z1/(z2+z3))^9+((a+b)/c)*(z1/(z2+z3))^8+3*(z1/(z2+z3))^7+(4+5)*(z1/(z2+z3))^6+4*(z1/(z2+z3))^5+5*(z1/(z2+z3))^4+(a*c-d*b)*(z1/(z2+z3))^3+(b/a-c)*(z1/(z2+z3))^2+(a*(b-(c/d+a/(b-c))))*(z1/(z2+z3))+a*b*c))*((a*(z1/(z2+z3))^10+2i*(z1/(z2+z3))^9+((a+b)/c)*(z1/(z2+z3))^8+(3i-2)*(z1/(z2+z3))^7+(4i+5i)*(z1/(z2+z3))^6+4*(z1/(z2+z3))^5+5*(z1/(z2+z3))^4+(ai*c-d*bi)*(z1/(z2+z3))^3+(b/a-c)*(z1/(z2+z3))^2+(a*(bi-(c/d+a/(b-ci))))*(z1/(z2+z3))+a*b*c-ai*bi*ci)))/(((2*s*(z1/(z2+z3))^14+(a/b-c)*(z1/(z2+z3))^12+2*(z1/(z2+z3))^11+(s*v/q)*(z1/(z2+z3))^8+(b*(c-a))*(z1/(z2+z3))^7+(s+q)*(z1/(z2+z3))^6+(q-s)*(z1/(z2+z3))^5+3*(z1/(z2+z3))^4+(4*(a+b))*(z1/(z2+z3))^3+(c*b/(a*s-c*v))*(z1/(z2+z3))^2+(s*a/(b-c*v))*(z1/(z2+z3))+q/(s-b*v)))-(((z4+s)*(z1/(z2+z3))^11+(2*a)*(z1/(z2+z3))^9+3*(z1/(z2+z3))^8+(i/bi)*(z1/(z2+z3))^7+(s+p)*(z1/(z2+z3))^6+(z5+z4*z5)*(z1/(z2+z3))^5+(p-q)*(z1/(z2+z3))^4+4*(z1/(z2+z3))^3+(a+b/c)*(z1/(z2+z3))+z4-z4*z5)))



 {
power(y/x,x/y)+log(x/y,y/x)+sin(x/y)+cos(x/y)+tan(x/y) +cotan(x/y)+sec(x/y)+
cosec(x/y)+arccos(x/y)+arcsin(x/y)+arctan(x/y)+arccotan(x/y)+arcsec(y/x)+
arccosec(y/x)+arcsech(x/y)+arccosech(x/y)+
sinh(x/y)+cosh(x/y)+tanh(x/y)+cotanh(x/y)+sech(x/y)+
cosech(x/y)+arccosh(y/x)+arcsinh(x/y)+arctanh(x/y)+arccotanh(y/x)+arcsech(x/y)+
arccosech(x/y)+arcsech(x/y)+arccosech(x/y)+
ln(x/y)+exp(x/y)+sqr(x/y)+sqrt(x/y)+fact(j+k)/fact2(j+2*k)+log10(x/y)+log2(x/y)+
re(x/y)+im(x/y)+abs(x/y)+arg(x/y)+root(x/y,j+k)+sign(x/y)+cossin(x/y)+
trunc(y/x)+round(y/x)+frac(x/y)+arctan2(x/y,y/x)

}


 //  (-1+0i)^x+ (-1+0i)^(n+k+2)+ (-1+0i)^z1+ (-i)^x+ (-i)^(n+k+2)+ (-i)^z1+ (i)^x+ (i)^(n+k+2)+ (i)^z1+ (-1+2i)^x+ (-1+2i)^(n+k+2)+ (-1+2i)^z1+ (-1+2i)^x
 //  x=5;  (-1+0i)^x/(-1+0i)^(n+k+2)+ (-i)^x/(-i)^(n+k+2)+  (i)^x/(i)^(n+k+2)+  (-1+2i)^x/(-1+2i)^(n+k+2)
 //  x=5; z1.re=5; z1.im=0;  (-1+2i)^z1/(-1+2i)^x + (-1+0i)^z1/(-1+0i)^x+  (-i)^z1/(-i)^x+   i^z1/i^x
 //  root(-1+0i,x+3)/root(-1+0i,n+k+2)+  root(i,n+k+2)/root(i,x+3)  +  root(-i,n+k+2)/root(-i,x+3)+  root(-1+2i,x+3)/root(-1+2i,n+k+2)

 {

  (-1)^(-2*k*j+5*k+9) + (-1)^(-2*k*j+5*k+9)
  (-1)^vi[k+2*n+3] + (-1)^vi[k+2*n+3]
  2^(9-2*k*j+5*k) + 2^(9-2*k*j+5*k)
  x=k; y=j; 2^(9-2*x*y+5*x) +2^(9-2*x*y+5*x)
  2^vi[k+2*n+3]  + 2^vi[k+2*n+3]
  3^(9-2*k*j+5*k) + 3^(9-2*k*j+5*k)
  x=k; y=j; 3^(9-2*x*y+5*x) + 3^(9-2*x*y+5*x)
  3^vi[k+2*n+3] + 3^vi[k+2*n+3]
  i^(2*k*j+1) + i^(2*k*j+1)
  i^(2*k*j+2)
  i^(2*k*j+3)
  i^(2*k*j+4)
  (-i)^(2*k*j+1)   +  (-i)^(2*k*j+1)
  (-i)^(2*k*j+2)
  (-i)^(2*k*j+3)
  (-i)^(2*k*j+4)
  x=k; y=j; i^(2*x*y+1) + i^(2*x*y+1)
  x=k; y=j; i^(2*x*y+2)
  x=k; y=j; i^(2*x*y+3)
  x=k; y=j; i^(2*x*y+4)
  x=k; y=j; (-i)^(2*x*y+1)  + (-i)^(2*x*y+1)
  x=k; y=j; (-i)^(2*x*y+2)
  x=k; y=j; (-i)^(2*x*y+3)
  x=k; y=j; (-i)^(2*x*y+4)


  (-i)^x



 }

//package compile
{
 r1=sin(x)*cos(y); r2=cos(x)*sin(y); r3=sin(x)*cos(y)-cos(x)*sin(y); r1+r2+r3
 r1:complex=sin(x)*cos(y); r2:complex=cos(x)*sin(y); r3:complex=sin(x)*cos(y)-cos(x)*sin(y); r1+r2+r3
 r1:complex=sin(z1)*cos(z2); r2:complex=cos(z1)*sin(z2); r3:complex=sin(z1)*cos(z2)-cos(z1)*sin(z2); r1+r2+r3



}






//sp2(ps2(z1,z2)+z1,-z2*sp1(-z1))-ps1(z1/ps2(-z1,z2*sp2(-sp1(z1),z2/sp2(z1/z2,sp1(z1+z2)/ps1(z1-z2)))))
//sp2(ps2(z1,z2)+z1,-z2*sp1(-z1))-ps1(z1/ps2(-z1,z2*sp2(-sp1(z1/sp2((sp2(ps2(z1,z2)+z1,-z2*sp1(-z1))-ps1(z1/ps2(-z1,z2*sp2(-sp1(z1/sp2(z1*ps2(z1-z2,-z1-ps1(-z2)),-z2)),z2/sp2(z1/z2,sp1(z1+z2)/ps1(z1-z2))))))*ps2(z1-z2,-z1-ps1(-z2)),-z2)),z2/sp2(z1/z2,sp1(z1+z2)/ps1(z1-z2)))))



{



}
//*******integ var************
{
 -(a*m-x*k-j*(y*j-m/x-b*(-k)*a-t/j)-(-b/(-x-(-k-j-a)*(x-j)*(j-y)))/(j*x-y*k)-j*k*(k*t-j*y-k*2+3*j)-j/(x*a-a/j+m/c-t-(-k-2-j)/(-k*2+j))+(-a/(b*c-a*2/j)-j*k*x/c+m/(a*b-c/a))/k)*(-(a*b-c)/m-x*(a*k-b*m+3)*(k*x-y*m-j*a*x*k*b/((x-k)*(m-y)-(k+x)*(t+n))))

 k*y*(2*k+1)*(2*k*y/t-2*k*(3*t-1)/(2*k-3*y-4)*(k/(3*k-1)-4/k+5*(2*k*y*t-1)/(y+1)-7*(2*k*(y+1)*(3*y+2)*(3/(k+1)-2*t/(2*k*y*t-1)+(4*k-1)*(5*y-7)/(k-2*y-1-2*t/(3-7*k-8*y*(4*k/(2*t+1)-7*k-8/t+9*(2*k-1)*(3*k+4*y+5)*(2*k*y*t-7)*k*y*t/(k-y*2-3/(k/(t-1)-7/(y+2)+8/(2*k*y*t+1)-9)))))/(k-1)))))
 k*j*(2*k+1)*(2*k*j/t-2*k*(3*t-1)/(2*k-3*j-4)*(k/(3*k-1)-4/k+5*(2*k*j*t-1)/(j+1)-7*(2*k*(j+1)*(3*j+2)*(3/(k+1)-2*t/(2*k*j*t-1)+(4*k-1)*(5*j-7)/(k-2*j-1-2*t/(3-7*k-8*j*(4*k/(2*t+1)-7*k-8/t+9*(2*k-1)*(3*k+4*j+5)*(2*k*j*t-7)*k*j*t/(k-j*2-3/(k/(t-1)-7/(j+2)+8/(2*k*j*t+1)-9)))))/(k-1)))))
 k!*(2*k-3*j-4)/(3*j-(k+1)!)!-k-j/(k+1)!+2^(k+j-1)/2^k
 6*(y-a)^n+(y-a)^k+3*(y-a)^(2*k+4)+4*(y-a)^(2*k+5)+5*(a-y)^n-2*(a*x+b)^(2*k+n)-3*(a*x-b)^(2*k+j)+4*(2*x+y)^(2*k+j+1)-3*(2*x*y+1)^(7-k)-9*(2*x*y+1)^(7-n)-2*(2*x*y-1)^(7-k)-(2*(y-a)^n-3*(y-a)^k+4*(a-y)^n-5*(a*x+b)^(2*k+n)-6*(a*x-b)^(2*k+j)+7*(2*x+y)^(2*k+j+1)+8*(2*x*y+1)^(7-k)-2*(2*x*y+1)^(7-n)+10*(2*x*y-1)^(7-k)-5*(y-a)^(2*k+4)-8*(y-a)^(2*k+5))
 sin(2*x*k-3)*cos(x*k+1)^(k+1)-k/x*(k+1)*(2*x*k-3)/sin(x*k+1)^(k+1)-x*k*(2*k+3*n+4)/(x*k-y*n-k*a)*(5*k!^k-2^(k+n)!)-(3*2^(k+n)!/k!^k)*sin(x*k+1)^(k+1)*(cos(2*x*k-3)/cos(x*k+1)^(k+1))


 ((k*x-y*m)*j/y-k/(k/a-b/j))/(-2.12-k)/(3.18*m-k*3.97-3.91/j-m/2.97)+(x/k*a/y*m/b-(b*k-m*a)/x-y/(x/(k-a)-(b-m)/y+(m+c)*(b+k)*x/(y-a*k/x)))-(x-y*a)/m
 (n/k/m/x-m/k-(-k/2.5-m/x*a*(-j*(2.8/a-b/3.1*m*j-x/(-y/m-b/(-(x-a/y)/m-j*(-2.1*m+1.7*j-3.1)/(-x/m+a*m-j*c-y*a*m*x))))-m/(-x-k*a-b*j))*(-x/(a/k-m/b-2.7/m+k/1.8)*y)))/(x/(-a*1.2*j*m-(-j+2*m+4.5)/(j+m))-y/(-x-y/((n-k)*x-y/(k*a-j*b/c)))*a/b*1.7)
 ((-y^k-x^m)/(m^k-k^j)-(x/y)^(k-j))/(k^(2*m+j)/(y/x)^(2*j-3)+(x/(x+y))^(k^x/y^m))*(1.5*x^(y*k)-y^(x/m)*2.5)/((a*x^(x/y-y/x))/(y^(a/x+y/b)/b+2.1))-(((x/k)^2+(m/y)^3)/(x/k+m/y)^(a/k+m/b))*((x/y)^5+(y/x)^3+(j*y-1)^(x*k-2))
 ((x/y)^(x^5/(x^3+y^2))*2.3+(1.3*y/x^2-x/y^2*7.7)^(y^k*j^x/(a^k*3.5-2.7*k^b)+3.7*(x/y)^(k/j*3.7)))^(1.5/(x/y)^2-(y/x)^3/2.7)
 (x/y)^(j-5*k-4)/(y/x)^(2-j*2+m*3)/a^(x/y)/(y/(x+y))^c/((x^1.7/2.9^y-(x/y)^(y/x))/(2.9*j^(x/y)+(y/x)^k*2.7)*(a^k/j^b-j^3/2^k*2.3))*(x^1.7/2.9^y-(x/y)^(y/x))/(2.9*j^(x/y)+(y/x)^k*2.7)


 x^(2*j+k+2)/(x^(2*j+k+1)+x^(2*j+k))-x^(j+k+2)/(x^(j+k+1)-x^(j+k))
 (-x)^(2*j-k+2)*x^(2*j+k+1)/(x^(2*j+k+1)+(-x)^(2*j-k)+x^(2*j+k))-(-x)^(j+k+2)*(-x)^(j-k+3)/((-x)^(j+k+1)-x^(j+k)+(-x)^(j-k))

 (7-2*k*j*m)!!/((j*k*3+1)!+x*(4*k-3*j+7*m*j-5*k*j*m*n-7)!)*(2*k-15*j-187-9*k*j*m)^j/((k+1)!^(j-1)!!)*(3*k-60*j+5*k*j-7*m*j*k+37)^(k*2*m-k*j*m+j*3-27)

 ((3*k-60*j+5*k*j-7*m*j*k+37)^y*x^(k*2*m-k*j*m+j*3-27)*(x/y)^(k*2*m-k*j*m+j*3-32)*(3*k-60*j+5*k*j-7*m*j*k+42)^(y/x))/((3*k-60*j+5*k*j-7*m*j*k+37)^(a*y-3)*(k*2*m-k*j*m+j*3-28)^(a*x/(y*b)) + (b*x-1)^(k*2*m-k*j*m+j*3-27)*(3*k-60*j+5*k*j-7*m*j*k+38)^(a*y/(b*x)))

 x^(4-n)*x^(3-n)*x^(2-n)*x^(1-n)

 x^(1-2*k)*x^(3-2*k)/(x^(3-n-k)+x^(2-n-k))*(x^(3-2*k+4*j)+x^(2-2*k+4*j)+(1-2*k+4*j))/(x^(3-2*k+j)+x^(2-2*k+j)+(1-2*k+j))
}


//**************array*************
{
 -vd[k+j]/ve[j-k]-k*j*ve[|-vd[k]|]-x*(2*ve[k*2+1]+3)*vd[j+1]^2*(2*ve[(k+1)!]-ve[k*j]*3-5)
 -(-vd[k+1]-ve[2*j+1])-(-(-vd[k+2]))^2-(-(-x-vd[(k+1)!]))*vd[k*2]^3/ve[7]^2*(-vd[j]-(-ve[k+5])*(5-ve[k+8]*2)*vd[j+3]*(-(-a*ve[k+5]-3)))
 -(-(-(vd[k^2])))-(-(-ve[2*k!+1]))-(-(-vd[(k+1)!])-ve[2*k]^k!-k^vd[j+2])
 (vi[(k+1)!+j!!]*vi[2*(k+1)!+3*j!!]*((k+1)!^j!!)+vi[k+j]!+vi[(2*k)!])/(j!*vi[k+j]!^k!/j!!+vi[(3*k-1)!!]^(j!!/k!))
  j!!^k!*(2*j!)/((2*k)!+(3*k)!!+4*k^j)+k^vi[vi[k*2+3*n+6]]+vi[vi[j*2+3*n+3!]+2*k^(n+1)]^k
  vi[vi[|1+2*k+3*j*k+4*m*j*k|]*x]*vi[vi[2*m+3*j*k+3]*(k+1)!]/vi[-m*j*4+3*j*k-70]^(k+1)
 sqr(norm(ve))-sumq(ve)+sum(ve)/len(ve)-avr(ve)
}

//**********functions*******************real*********

// -(-(-a/x)-b/y*x)*(-(-x/(-y)/a)/(-x-y/x))*(-y/a-c/x)-(x^2/y^3-x^(k+1)/y^k-(x*y-y)/y-(-(-(-x)))-(-y/(-x)-(-a-x)/(-x^3)))/(-y/x^4-y/a-k!/y-(k+1)!^[x/y+2*x])-(b/y-x/a)^[x*y-1]
//-(-(-a/x)-b/y*x)*(-(-x/(-y)/a)/(-x-y/x))*(-y/a-c/x)-(x^2/y^3-x^(k+1)/y^k-(x*y-y)/y-(-(-(-x)))-(-y/(-x)-(-a-x)/(-x^3)))/(-y/x^4-y/a-k!/y-(k+1)!^x/y)-(b/y-x/a)^x

//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//sin(-a/b-1)*(c+1)^(1+d)-tan(c*(-d)^(2+c))-(2*a+3)^(b+1)-(-a+1/sin(b^(-c)+3^(-d)-d^(-5)))

//sin(x)^(-2)-3*cos(y)^(-5)-(-(-8*sin(y)^(5))-(-(-9*cos(x)^(-7)))-(10*cos(y)^(11))-(-(-11*sin(y)^(5)))-1/cos(y)^(-5)*cos(x)^(-7)/cos(y)^(11))

//2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*(-t)^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(-3*t+1)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))
//(x+1)^2+2*(x+1)^3-3*(x+1)^4+4*(x+1)^5-6*(x+1)^6+2*(x+1)^7+2*(x+1)^8-2*(x+1)^9+2*(x+1)^10-8*(x+1)^11+2*(x+1)^12-7*(x+1)^13+2*(x+1)^14-4*(x+1)^15-3*(x+1)^16+8*(x+1)^17+2*((x+1)^(-2)+2*(x+1)^(-3)-3*(x+1)^(-4)+4*(x+1)^(-5)-6*(x+1)^(-6)+2*(x+1)^(-7)+20*(x+1)^(-8)-20*(x+1)^(-9)+20*(x+1)^(-10)-80*(x+1)^(-11)+20*(x+1)^(-12)-70*(x+1)^(-13)+20*(x+1)^(-14)-40*(x+1)^(-15)-30*(x+1)^(-16)+80*(x+1)^(-17))*((x+1)^2/(x+1)^3*(x+1)^4/(x+1)^5*(x+1)^6/(x+1)^7*(x+1)^8/(x+1)^9*(x+1)^10/(x+1)^11*(x+1)^12/(x+1)^13*(x+1)^14/(x+1)^15*(x+1)^16/(x+1)^17*((x+1)^(-2)/(x+1)^(-3)*(x+1)^(-4)/(x+1)^(-5)*(x+1)^(-6)/(x+1)^(-7)*(x+1)^(-8)/(x+1)^(-9)*(x+1)^(-10)/(x+1)^(-11)*(x+1)^(-12)/(x+1)^(-13)*(x+1)^(-14)/(x+1)^(-15)*(x+1)^(-16)/(x+1)^(-17)))

//(a*x*t*sin(t/a+b)*(b*x+d)*cos(c*(a*x+b*y-c*t-d)^(c*x-b)-d)-tan(a*sin(a*x+b*y+c)^2-b*cos(a*x*y*t+b)^5+c)^3)/(a*x*y*(b*t-c)^(c*x-d)*(b*t+a)-b*x*sin(a*(b*x+c)^3-b)^4+d)+a*(b*x+c*y+d*t+c)*(a*x*y*t+b)*x*y*t-(b*x*y*t*(c*sin(b*x+c)+d)^3)/(((a*x+b)*(c*y-d)*(b*t+c)*x*y*t*b+c)*sin(a*cos(c*x+d)+b)^3)

//(2*sin(3*x+4)*cos(2*x*y*t-7)*x/sin(2*x*y+1)-x*y*t*2*cos(2*x+3)/sin((4*x+2)/(4*y+1))-cos(2*x*y-7))*x/sin(x/y*2-3)/sin(2*x*y-8)-2*x/cos(x*sin(5*x+3)/cos(5*x-7)+8)+2*sin(2*x+3*y-4*t+5)*cos(3*x*y*t+7)/(2*x+3)-x/(-(-2/cos(3*x+4)*sin(2*x*y*t-7)*x-x*y/sin(2*x+3)*cos(4*x+2)-2*x-5*x+8))-x*(-(2*y-3-x-(2*x+1)*2*cos(5*x+3)*sin(5*x-7)+x/cos(2*x+3*y-4*t+5)/sin(3*x*y*t+7)-sin(2*x*y+1))/(2/cos(2*x*y-8)-1)-3*cos(3*x*y+1)*(2*cos(2*x*y+1)-1)*y/t)
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//2/cos(3*x+4)*sin(2*x*y*t-7)*x-x*y/sin(2*x+3)*cos(4*x+2)
//(2*x+1)*2*cos(5*x+3)*sin(5*x-7)+x/cos(2*x+3*y-4*t+5)/sin(3*x*y*t+7)
//sin(2*x*y+1)/(2/cos(2*x*y-8)-1)
//cos(3*x*y+1)*(2*cos(2*x*y+1)-1)
//x^y*sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))

// 2/(-x-(-sin(x*(3-x/y-(4*x/y-(-((x*(-sin(x-(-3*x/y-(2*x-x/y))*(1-sin(x-2*(-x/y-(2*x/y+1))+2*x/y+1)^x)-x^(x/y))/(x^(x/y))+(x/y*(-x)-x/y)-((x+1)-x/y/(x+x/y))^x-(2*x/y-7)/(2*sin(x)+x/y))-x/y*(3-x/y)^x*(x/y)-7*x/y-8)-(x/y*(x-x/y)^x*(x/y)^x*(x+1)-(x/y+1)-x/y))-(x*(-(x-(-(2*sin(x)+x/y+1)^x-(x/y+1)*(2*x/y+1)^x-(x/y+1)^x))*(2*x/y+1)^x-(4*x/y+1)^x*(-(-x/y)-x/y/(x+x/y)^x-(-x-(2*(x+x/y)^x-3*(x/y+x)/(-sin(x/y))-(x/y*7-x)^x)/(7*x/y-1)-(2*x/y+1)^x)-(3*x/y+1)^x-(-x/y-1))*(-x/y+1)^x-x/(x-x/y)^x-y*(-x/y-1))-(-(x+x/y)/(x-x/y)+(y-x/y)^x))-(-x/y-x-(-(x+x/y)-(x-x/y)^x)*x/y)-x/y)*(x-x/y)^x)))))

// 2/(-x-(-sin(x*|3-t-[4*t-(-|t-[x*{-sin(x-{-3*t-|2*x-t|*[|-y-t|-|-{x+t}-[|t-y|^(x/y)-[x-t]^|{t-y}^[x-t-2]-|t*x-y-3|^|y-x-3|*(x+t)|+t]-y|]}*{1-|sin(x-2*[-t-|2*t+1|*|t-y*(sin(x)-1)^[y+x*{t-y}]|^[y+t*2]^2-|x^{t*y}-|-t-y||^3]-t)|^x}-x^t)/[x^y]+|t*(-x)-t|-{-|x+1|-t/(x+t)+y}^x-(2*t-7)/(2*sin(x)+t)}-t/|-t-7|^x/(x*t)-7*t-8]-(t*[y-x]^x/|t|^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+9)^x-(t+4)^x))*(-2*t+3)^x-(-3*t+1)^x*(-(-t)-t/(-x-t)^x-(-x-(2*(-t-x)^x-3*(t+x)/(-sin(t))-(x*2-1)^x)/(7*t-1)-(-2*t-1)^x)-(-2*t-2)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))

// 2/(-x-(-sin(ve[x]-vd[k]^2-vd[3]-x*|3-t-vd[k]^2*[4*t-(-|ve[k]-t-[vd[y]*x*{-sin(vd[2]*ve[y]-{-vd[3]*t-|2*x-t-||vd[|-x|]|^|vd[k]|||*[|-y-t-vd[k]|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-vd[{t*y}*2]-|x^{t*y}-[vd[x*k]^2-|t-y|^vd[2]]-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))
// 2/(-x-(-sin(x-x^2-x-x*|3-t-x^2*[4*t-(-|x-t-[y*x*{-sin(x*y-{-x*t-|2*x-t-||-x|^|y|||*[|-y-t-x|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-vd[{t*y}*2]-|x^{t*y}-[vd[x*k]^2-|t-y|^vd[2]]-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))


//(1/x+1/y)/(1/x*1/y)-(1/x+1/y)/(1/x-1/y)+(1/((1/x+1/y)/(1/x*1/y))+1/((1/x+1/y)/(1/x*1/y)))/(1/x*1/((1/x+1/y)/(1/x*1/y)))

 // -sin(-cos(-(cos(-x)-sin(-y))))*(cos(-x*sin(-x-y))-sin(-y/cos(-x/sin(-x/y)))-cos(-y/x)-sin(x/(-y))/(-x/sin(y/(-x))-cos(-sin(-x/(-y)))))

//   (sin(x)*cos(y)/(cos(y)+tan(x)/sin(-t))-cot(y)*cot(x)/(sin(t)/cos(x)-tan(t)/cos(y))+(cot(-x)/sin(t)+cos(-x)*tan(-x)+sin(-y)*cos(y)/(cot(-t)+tan(-y))))/(sin(-t)/sin(x)-cos(t)/sin(y)-cot(t)*tan(y)/(-sin(-y)*cot(-t)+tan(x)*cos(x)))

//   ((sin(x/cos(y))*tan(sin(y))/(cos(cos(y)/x)-sin(-tan(t)))-cos(cot(t)/t)*tan(tan(y)))/(x/tan(cos(y)/x)-cot(x/cos(y))/t)-cot(cot(t)/t)*tan(cot(y))*sin(-tan(t))*cos(x/tan(cos(y)/x))/(sin(-cos(t))-cos(tan(t)/t)))*((cos(tan(-t))*sin(cot(-x))-sin(cos(t/tan(t)))*cos(-cos(t))*sin(-cos(t)))/(cot(x/cos(x))+tan(y/cos(y))))

//  coth(x)+sech(x)+tanh(x)+sinh(x)+cosech(x)+exp(x)+csch(x)+cosh(x)


//  arccoth(z1)*arccoth(z2)*arccoth(z3)*arccoth(z1*z2)*arccoth(z1/(z1+z2))*arccoth(-z1/(z1+z2))


{
cosec(z1)+cos(z1)+sin(z1)+sec(z1)
tan(z1)+sec(z1)+cos(z1)+cotan(z1)+cosec(z1)

cotan(z1)+sec(z1)+sin(z1)+tan(z1)+cosec(z1)+cos(z1)
sin(z1)+sec(z1)+sin(z1)+cosec(z1)+cos(z1)+tan(z1)
sec(z1)+tan(z1)+cotan(z2)+cosec(z2)+sin(z2)+cos(z2)+cotan(z1)+sin(z2)+sin(z1)+cosec(z1)+sec(z2)+tan(z2)
}

{

((x/y-sin(x/y)*cos(y/x)/(sin(y/x)-cos(x/y)))*(y/x-sin(cos(-x))*cos(sin(-y))*cos(y/x)/(sin(x/y-y/sin(cos(-x/y))-x/cos(sin(-x))))))/((y/sin(-x/y)-x/sin(sin(-y/x))+(x/y-y/x)/(tan(-x/y)/x-y/cot(-y/x))+tan(cot(x/(x+y)))*cot(tan(y/(x+y)))*tan(-x/y)*cot(y/x))/(y/sin(tan(x/y))+x/cos(cot(y/x))+x*y/(tan(sin(x/(x+y)+cot(cos(y/(x+y))))))))
((z1/z2-sin(z1/z2)*cos(z2/z1)/(sin(z2/z1)-cos(z1/z2)))*(z2/z1-sin(cos(-z1))*cos(sin(-z2))*cos(z2/z1)/(sin(z1/z2-z2/sin(cos(-z1/z2))-z1/cos(sin(-z1))))))/((z2/sin(-z1/z2)-z1/sin(sin(-z2/z1))+(z1/z2-z2/z1)/(tan(-z1/z2)/z1-z2/cot(-z2/z1))+tan(cot(z1/(z1+z2)))*cot(tan(z2/(z1+z2)))*tan(-z1/z2)*cot(z2/z1))/(z2/sin(tan(z1/z2))+z1/cos(cot(z2/z1))+z1*z2/(tan(sin(z1/(z1+z2)+cot(cos(z2/(z1+z2))))))))


(((sec(-tan(x))*csc(-cot(y))/(sin(-y/(tan(x/y)))-cos(-x/cot(-x/y)))-tan(-cot(y/x))*cot(-x/cos(x/y))/(csc(-x/csc(-x))-x/tan(-y/sec(-x))+y/cot(-cot(x/y))))/((tan(-x/cot(x))/sin(x/sec(x))-cos(x/csc(x))/cot(-sec(-x))+cot(csc(-y))/tan(sec(-x)))/(x/cot(-x/cos(y/x))+y/tan(-y/sin(x/y))))-((cot(-x)*sec(-y/x)*(sin(cos(-x/y)))-tan(cot(y/x))/(csc(x/y)-cos(sin(-y/x))/tan(-cot(-y)))))/((x/cot(tan(-y))-y/sec(csc(-y/x)))*(sin(-x/cos(x/y))/sec(cos(-y))-sec(-x/y)*cot(-y/x)))))/((sin(x)/(-x/tan(-sec(-x/y)+y/cot(-cos(-x))))+cos(y)/(x/tan(-csc(-y))-y/cot(-sec(-x))))*(x/sec(-x/csc(-x))-y/cot(-y/sec(-x))-sec(-cot(x/y))/tan(-csc(y/x)))/(tan(-cos(-y/x))-x/cot(tan(y/x))-y/sin(-sec(-x/y))))
(((sec(-tan(z1))*csc(-cot(z2))/(sin(-z2/(tan(z1/z2)))-cos(-z1/cot(-z1/z2)))-tan(-cot(z2/z1))*cot(-z1/cos(z1/z2))/(csc(-z1/csc(-z1))-z1/tan(-z2/sec(-z1))+z2/cot(-cot(z1/z2))))/((tan(-z1/cot(z1))/sin(z1/sec(z1))-cos(z1/csc(z1))/cot(-sec(-z1))+cot(csc(-z2))/tan(sec(-z1)))/(z1/cot(-z1/cos(z2/z1))+z2/tan(-z2/sin(z1/z2))))-((cot(-z1)*sec(-z2/z1)*(sin(cos(-z1/z2)))-tan(cot(z2/z1))/(csc(z1/z2)-cos(sin(-z2/z1))/tan(-cot(-z2)))))/((z1/cot(tan(-z2))-z2/sec(csc(-z2/z1)))*(sin(-z1/cos(z1/z2))/sec(cos(-z2))-sec(-z1/z2)*cot(-z2/z1)))))/((sin(z1)/(-z1/tan(-sec(-z1/z2)+z2/cot(-cos(-z1))))+cos(z2)/(z1/tan(-csc(-z2))-z2/cot(-sec(-z1))))*(z1/sec(-z1/csc(-z1))-z2/cot(-z2/sec(-z1))-sec(-cot(z1/z2))/tan(-csc(z2/z1)))/(tan(-cos(-z2/z1))-z1/cot(tan(z2/z1))-z2/sin(-sec(-z1/z2))))


((sin(cos(sec(-x/y)))*cos(cos(-csc(-x/y)))*cos(sin(sec(-x/y)))/(tan(csc(-x/y))-csc(sin(cos(-x/y)))))-cos(cos(-sec(-x/y)))*sin(-sin(sec(-x/y)))*sin(-cos(sec(-x/y)))/(tan(-csc(-x/y))+sec(sin(-cos(-x/y)))+sec(-sin(cos(-x/y)))))/((sin(cos(-y/x))*sin(tan(x/y))*cos(sec(cot(x/y)))/(sec(cos(sec(-y/x)))-csc(sec(x/y))-cos(sin(x/y))-cot(sin(csc(-y/x))))-sin(cos(-y/x))*sin(tan(x/y))*cos(sec(cot(x/y)))/(tan(sin(-y/x))-sec(sin(sin(x/y)))/sec(-cos(sec(-y/x)))-cot(cos(csc(-y/x)))/csc(-csc(x/y))-cot(cos(-csc(-y/x)))/sin(-sec(cot(x/y)))))+(cos(tan(sin(y/x)))*sin(tan(x/(x+y)))*sin(cot(cos(y/x)))/(1/tan(sec(cos(x/(x+y))))+csc(sin(sec(y/x)))/sin(cos(cot(x/(x+y))))+cos(tan(sec(x/(x+y))))/sec(csc(y/x)))+cos(-tan(sin(y/x)))/tan(-sec(cos(x/(x+y))))+cos(-cot(x/(x+y)))/sin(tan(-cos(y/x)))-sec(-cos(sec(y/x)))/sin(-tan(sec(x/(x+y))))-cos(-cos(cot(x/(x+y))))/sec(-csc(y/x))))
((sin(cos(sec(-z1/z2)))*cos(cos(-csc(-z1/z2)))*cos(sin(sec(-z1/z2)))/(tan(csc(-z1/z2))-csc(sin(cos(-z1/z2)))))-cos(cos(-sec(-z1/z2)))*sin(-sin(sec(-z1/z2)))*sin(-cos(sec(-z1/z2)))/(tan(-csc(-z1/z2))+sec(sin(-cos(-z1/z2)))+sec(-sin(cos(-z1/z2)))))/((sin(cos(-z2/z1))*sin(tan(z1/z2))*cos(sec(cot(z1/z2)))/(sec(cos(sec(-z2/z1)))-csc(sec(z1/z2))-cos(sin(z1/z2))-cot(sin(csc(-z2/z1))))-sin(cos(-z2/z1))*sin(tan(z1/z2))*cos(sec(cot(z1/z2)))/(tan(sin(-z2/z1))-sec(sin(sin(z1/z2)))/sec(-cos(sec(-z2/z1)))-cot(cos(csc(-z2/z1)))/csc(-csc(z1/z2))-cot(cos(-csc(-z2/z1)))/sin(-sec(cot(z1/z2)))))+(cos(tan(sin(z2/z1)))*sin(tan(z1/(z1+z2)))*sin(cot(cos(z2/z1)))/(1/tan(sec(cos(z1/(z1+z2))))+csc(sin(sec(z2/z1)))/sin(cos(cot(z1/(z1+z2))))+cos(tan(sec(z1/(z1+z2))))/sec(csc(z2/z1)))+cos(-tan(sin(z2/z1)))/tan(-sec(cos(z1/(z1+z2))))+cos(-cot(z1/(z1+z2)))/sin(tan(-cos(z2/z1)))-sec(-cos(sec(z2/z1)))/sin(-tan(sec(z1/(z1+z2))))-cos(-cos(cot(z1/(z1+z2))))/sec(-csc(z2/z1))))

}

{

((x/y-sinh(x/y)*cosh(y/x)/(sinh(y/x)-cosh(x/y)))*(y/x-sinh(cosh(-x))*cosh(sinh(-y))*cosh(y/x)/(sinh(x/y-y/sinh(cosh(-x/y))-x/cosh(sinh(-x))))))/((y/sinh(-x/y)-x/sinh(sinh(-y/x))+(x/y-y/x)/(tanh(-x/y)/x-y/coth(-y/x))+tanh(coth(x/(x+y)))*coth(tanh(y/(x+y)))*tanh(-x/y)*coth(y/x))/(y/sinh(tanh(x/y))+x/cosh(coth(y/x))+x*y/(tanh(sinh(x/(x+y)+coth(cosh(y/(x+y))))))))
((z1/z2-sinh(z1/z2)*cosh(z2/z1)/(sinh(z2/z1)-cosh(z1/z2)))*(z2/z1-sinh(cosh(-z1))*cosh(sinh(-z2))*cosh(z2/z1)/(sinh(z1/z2-z2/sinh(cosh(-z1/z2))-z1/cosh(sinh(-z1))))))/((z2/sinh(-z1/z2)-z1/sinh(sinh(-z2/z1))+(z1/z2-z2/z1)/(tanh(-z1/z2)/z1-z2/coth(-z2/z1))+tanh(coth(z1/(z1+z2)))*coth(tanh(z2/(z1+z2)))*tanh(-z1/z2)*coth(z2/z1))/(z2/sinh(tanh(z1/z2))+z1/cosh(coth(z2/z1))+z1*z2/(tanh(sinh(z1/(z1+z2)+coth(cosh(z2/(z1+z2))))))))

(((sech(-tanh(x))*csch(-coth(y))/(sinh(-y/(tanh(x/y)))-cosh(-x/coth(-x/y)))-tanh(-coth(y/x))*coth(-x/cosh(x/y))/(csch(-x/csch(-x))-x/tanh(-y/sech(-x))+y/coth(-coth(x/y))))/((tanh(-x/coth(x))/sinh(x/sech(x))-cosh(x/csch(x))/coth(-sech(-x))+coth(csch(-y))/tanh(sech(-x)))/(x/coth(-x/cosh(y/x))+y/tanh(-y/sinh(x/y))))-((coth(-x)*sech(-y/x)*(sinh(cosh(-x/y)))-tanh(coth(y/x))/(csch(x/y)-cosh(sinh(-y/x))/tanh(-coth(-y)))))/((x/coth(tanh(-y))-y/sech(csch(-y/x)))*(sinh(-x/cosh(x/y))/sech(cosh(-y))-sech(-x/y)*coth(-y/x)))))/((sinh(x)/(-x/tanh(-sech(-x/y)+y/coth(-cosh(-x))))+cosh(y)/(x/tanh(-csch(-y))-y/coth(-sech(-x))))*(x/sech(-x/csch(-x))-y/coth(-y/sech(-x))-sech(-coth(x/y))/tanh(-csch(y/x)))/(tanh(-cosh(-y/x))-x/coth(tanh(y/x))-y/sinh(-sech(-x/y))))
(((sech(-tanh(z1))*csch(-coth(z2))/(sinh(-z2/(tanh(z1/z2)))-cosh(-z1/coth(-z1/z2)))-tanh(-coth(z2/z1))*coth(-z1/cosh(z1/z2))/(csch(-z1/csch(-z1))-z1/tanh(-z2/sech(-z1))+z2/coth(-coth(z1/z2))))/((tanh(-z1/coth(z1))/sinh(z1/sech(z1))-cosh(z1/csch(z1))/coth(-sech(-z1))+coth(csch(-z2))/tanh(sech(-z1)))/(z1/coth(-z1/cosh(z2/z1))+z2/tanh(-z2/sinh(z1/z2))))-((coth(-z1)*sech(-z2/z1)*(sinh(cosh(-z1/z2)))-tanh(coth(z2/z1))/(csch(z1/z2)-cosh(sinh(-z2/z1))/tanh(-coth(-z2)))))/((z1/coth(tanh(-z2))-z2/sech(csch(-z2/z1)))*(sinh(-z1/cosh(z1/z2))/sech(cosh(-z2))-sech(-z1/z2)*coth(-z2/z1)))))/((sinh(z1)/(-z1/tanh(-sech(-z1/z2)+z2/coth(-cosh(-z1))))+cosh(z2)/(z1/tanh(-csch(-z2))-z2/coth(-sech(-z1))))*(z1/sech(-z1/csch(-z1))-z2/coth(-z2/sech(-z1))-sech(-coth(z1/z2))/tanh(-csch(z2/z1)))/(tanh(-cosh(-z2/z1))-z1/coth(tanh(z2/z1))-z2/sinh(-sech(-z1/z2))))

((sinh(cosh(sech(-x/y)))*cosh(cosh(-csch(-x/y)))*cosh(sinh(sech(-x/y)))/(tanh(csch(-x/y))-csch(sinh(cosh(-x/y)))))-cosh(cosh(-sech(-x/y)))*sinh(-sinh(sech(-x/y)))*sinh(-cosh(sech(-x/y)))/(tanh(-csch(-x/y))+sech(sinh(-cosh(-x/y)))+sech(-sinh(cosh(-x/y)))))/((sinh(cosh(-y/x))*sinh(tanh(x/y))*cosh(sech(coth(x/y)))/(sech(cosh(sech(-y/x)))-csch(sech(x/y))-cosh(sinh(x/y))-coth(sinh(csch(-y/x))))-sinh(cosh(-y/x))*sinh(tanh(x/y))*cosh(sech(coth(x/y)))/(tanh(sinh(-y/x))-sech(sinh(sinh(x/y)))/sech(-cosh(sech(-y/x)))-coth(cosh(csch(-y/x)))/csch(-csch(x/y))-coth(cosh(-csch(-y/x)))/sinh(-sech(coth(x/y)))))+(cosh(tanh(sinh(y/x)))*sinh(tanh(x/(x+y)))*sinh(coth(cosh(y/x)))/(1/tanh(sech(cosh(x/(x+y))))+csch(sinh(sech(y/x)))/sinh(cosh(coth(x/(x+y))))+cosh(tanh(sech(x/(x+y))))/sech(csch(y/x)))+cosh(-tanh(sinh(y/x)))/tanh(-sech(cosh(x/(x+y))))
   +cosh(-coth(x/(x+y)))/sinh(tanh(-cosh(y/x)))-sech(-cosh(sech(y/x)))/sinh(-tanh(sech(x/(x+y))))-cosh(-cosh(coth(x/(x+y))))/sech(-csch(y/x))))

((sinh(cosh(sech(-z1/z2)))*cosh(cosh(-csch(-z1/z2)))*cosh(sinh(sech(-z1/z2)))/(tanh(csch(-z1/z2))-csch(sinh(cosh(-z1/z2)))))-cosh(cosh(-sech(-z1/z2)))*sinh(-sinh(sech(-z1/z2)))*sinh(-cosh(sech(-z1/z2)))/(tanh(-csch(-z1/z2))+sech(sinh(-cosh(-z1/z2)))+sech(-sinh(cosh(-z1/z2)))))/((sinh(cosh(-z2/z1))*sinh(tanh(z1/z2))*cosh(sech(coth(z1/z2)))/(sech(cosh(sech(-z2/z1)))-csch(sech(z1/z2))-cosh(sinh(z1/z2))-coth(sinh(csch(-z2/z1))))-sinh(cosh(-z2/z1))*sinh(tanh(z1/z2))*cosh(sech(coth(z1/z2)))/(tanh(sinh(-z2/z1))-sech(sinh(sinh(z1/z2)))/sech(-cosh(sech(-z2/z1)))-coth(cosh(csch(-z2/z1)))/csch(-csch(z1/z2))-coth(cosh(-csch(-z2/z1)))/sinh(-sech(coth(z1/z2)))))+(cosh(tanh(sinh(z2/z1)))*sinh(tanh(z1/(z1+z2)))*sinh(coth(cosh(z2/z1)))/(1/tanh(sech(cosh(z1/(z1+z2))))+csch(sinh(sech(z2/z1)))/sinh(cosh(coth(z1/(z1+z2))))+cosh(tanh(sech(z1/(z1+z2))))
   /sech(csch(z2/z1)))+cosh(-tanh(sinh(z2/z1)))/tanh(-sech(cosh(z1/(z1+z2))))+cosh(-coth(z1/(z1+z2)))/sinh(tanh(-cosh(z2/z1)))-sech(-cosh(sech(z2/z1)))/sinh(-tanh(sech(z1/(z1+z2))))-cosh(-cosh(coth(z1/(z1+z2))))/sech(-csch(z2/z1))))

}


{
  sec(z1/z2)/cosec(z1/z2)-sin(z1/z2)/cos(z1/z2)-tan(z1/z2)/cotan(z1/z2)
  cosec(z1/z2)/sec(z1/z2)-sin(z1/z2)/cos(z1/z2)-tan(z1/z2)/cotan(z1/z2)
  sin(z1/z2)/cosec(z1/z2)-sec(z1/z2)/cos(z1/z2)-tan(z1/z2)/cotan(z1/z2)
  cos(z1/z2)/cosec(z1/z2)-sin(z1/z2)/sec(z1/z2)-tan(z1/z2)/cotan(z1/z2)
  tan(z1/z2)/cosec(z1/z2)-sin(z1/z2)/cos(z1/z2)-sec(z1/z2)/cotan(z1/z2)
  cotan(z1/z2)/cosec(z1/z2)-sin(z1/z2)/cos(z1/z2)-tan(z1/z2)/sec(z1/z2)

  sech(z1/z2)/cosech(z1/z2)-sinh(z1/z2)/cosh(z1/z2)-tanh(z1/z2)/cotanh(z1/z2)
  cosech(z1/z2)/sech(z1/z2)-sinh(z1/z2)/cosh(z1/z2)-tanh(z1/z2)/cotanh(z1/z2)
  sinh(z1/z2)/cosech(z1/z2)-sech(z1/z2)/cosh(z1/z2)-tanh(z1/z2)/cotanh(z1/z2)
  cosh(z1/z2)/cosech(z1/z2)-sinh(z1/z2)/sech(z1/z2)-tanh(z1/z2)/cotanh(z1/z2)
  tanh(z1/z2)/cosech(z1/z2)-sinh(z1/z2)/cosh(z1/z2)-sech(z1/z2)/cotanh(z1/z2)
  cotanh(z1/z2)/cosech(z1/z2)-sinh(z1/z2)/cosh(z1/z2)-tanh(z1/z2)/sech(z1/z2)


  cosec(z2/z1)
  sin(z1/(z1+z2))
  cos(z2/(z1+z2))
  tan(z1/(z1-z2))
  cotan(z2/(z1-z2))

  sin(-z1/sec(z1/z2))/cos(-z2/cosec())



}


{

(cosh(-z1-a)*sinh(-a-z1)-cosh(z1*z2-a)/(a-sinh(-a+z1*z2))+z1*(z2*sinh(z1-z2)-z1*cosh(-z2+z1)-sinh(-z1/z2)*cosh(-z2/z1)))*(sinh(-z1/cosh(z1-z2))*cosh(z2/sinh(z1*z2-a))+cosh(z1/sinh(-z2/z1))*sinh(-z2/cosh(-z1/z2))+cosh(sinh(z1/z2)*cosh(z2/z1)))*(sinh(z2/sinh(z1*z2-a))/(z1-cosh(-z1/cosh(z1-z2)))+z1*sinh(z1/cosh(sinh(z2/sinh(z1*z2-a))))/(z1-sinh(cosh(sinh(z1/z2)*cosh(z2/z1)))-cosh(sinh(-z1/z2)*cosh(-z2/z1))))
cosh(-(-z1/sinh(-z2/z1)))*sinh(-cosh(-z1/z2)/(-z1))*(sinh(-z1*z2/(z1-z2))-cosh(-z1/(-1/sinh(-z2/z1)))-sinh(-1-z1/cosh(-z1/z2)))*(sinh(-z2/(z1+z2))+tan(-z1/cosh(-z1/(z1+z2)))*cotan(-z2/sinh(-z2/(z1+z2))))
-cosh(-z1/(z1+z2))*(-z1-(-sinh(-z1/(z1+z2))/(-cosh(-z2/(z1+z2)))))*(-cosh(-z1/sinh(-z1/(z1+z2)))-sinh(sinh(z1/sinh((z1+z2)/z1)-z2/cosh((z1+z2/z2)))/cosh(-z1/(z1+z2))))*(z1/sinh((z1+z2)/z1)-z2/cosh((z1+z2/z2))-sinh(z1/cosh(-z2/(z1-z2))-z2/sinh(-z1/(z2-z1))))*(cosh(z2/cosh(-z2/(z1-z2))-z1/sinh(-z1/(z2-z1))))*((-z2/(z2-z1))*(-z1/(z2-z1))/sinh(z1/cosh(-z1/(z2-z1))-z2/sinh(-z1/(z1-z2)))-z1/cosh(-z1/sinh(z2/sinh(-z1/(z1-z2))-z1/cosh(-z1/(z2-z1))))-z2/sinh(-z2/cosh(-z1/sinh(z1/(z1-z2)-z2/cosh(z2/(z2-z1))))))
(z1/(z1-z2)-z2/(z2-z1)-t/(z1-t))*(z1/sinh(z2/(z2-z1))-z2/cosh(-z2/(z2-z1))-t/(sinh(-z1/cosh(z1/(z1-z2)))*(-z1)+cosh(-z1/cosh(z1/(z1-z2)))-(-t*z1)/cosh(-z2/sinh(-t/(z1-t)))))*(sinh(sinh(-z1/cosh(z1/(z1-z2)))-cosh(-z2/sinh(z1/(z1-z2))))*(-z1/sinh(-z2/cosh(z1/(z1-z2)))-t/sinh(-z2/sinh(z1/(z1-z2)))))
(exp(-z1/z2)/(sinh(z1/z2)-cosh(z2/z1))+sinh(-exp(z1/z2))/(exp(-cosh(z1/z2))+exp(z2/z1)))*(tanh(z2/z1)/(coth(-z1/z2)+coth(z2/z1)+coth(-z2/z1)))*((sinh(-z2/z1)+cosh(-coth(z2/z1)))/(tanh(cosh(-exp(z1/z2)))-coth(-exp(-z1/z2)))+cosh(cosh(z1/z2))/(tanh(exp(cosh(z1/z2)))-coth(sinh(-exp(z1/z2)))))*(tanh(sinh(-exp(z1/z2)))/(coth(exp(cosh(z1/z2)))-sinh(-exp(-z1/z2))/cosh(cosh(-exp(z1/z2)))))


(cos(-z1-a)*sin(-a-z1)-cos(z1*z2-a)/(a-sin(-a+z1*z2))+z1*(z2*sin(z1-z2)-z1*cos(-z2+z1)-sin(-z1/z2)*cos(-z2/z1)))*(sin(-z1/cos(z1-z2))*cos(z2/sin(z1*z2-a))+cos(z1/sin(-z2/z1))*sin(-z2/cos(-z1/z2))+cos(sin(z1/z2)*cos(z2/z1)))*(sin(z2/sin(z1*z2-a))/(z1-cos(-z1/cos(z1-z2)))+z1*sin(z1/cos(sin(z2/sin(z1*z2-a))))/(z1-sin(cos(sin(z1/z2)*cos(z2/z1)))-cos(sin(-z1/z2)*cos(-z2/z1))))
cos(-(-z1/sin(-z2/z1)))*sin(-cos(-z1/z2)/(-z1))*(sin(-z1*z2/(z1-z2))-cos(-z1/(-1/sin(-z2/z1)))-sin(-1-z1/cos(-z1/z2)))*(sin(-z2/(z1+z2))+tan(-z1/cos(-z1/(z1+z2)))*cotan(-z2/sin(-z2/(z1+z2))))
-cos(-z1/(z1+z2))*(-z1-(-sin(-z1/(z1+z2))/(-cos(-z2/(z1+z2)))))*(-cos(-z1/sin(-z1/(z1+z2)))-sin(sin(z1/sin((z1+z2)/z1)-z2/cos((z1+z2/z2)))/cos(-z1/(z1+z2))))*(z1/sin((z1+z2)/z1)-z2/cos((z1+z2/z2))-sin(z1/cos(-z2/(z1-z2))-z2/sin(-z1/(z2-z1))))*(cos(z2/cos(-z2/(z1-z2))-z1/sin(-z1/(z2-z1))))*((-z2/(z2-z1))*(-z1/(z2-z1))/sin(z1/cos(-z1/(z2-z1))-z2/sin(-z1/(z1-z2)))-z1/cos(-z1/sin(z2/sin(-z1/(z1-z2))-z1/cos(-z1/(z2-z1))))-z2/sin(-z2/cos(-z1/sin(z1/(z1-z2)-z2/cos(z2/(z2-z1))))))

(z1/(z1-z2)-z2/(z2-z1)-t/(z1-t))*(z1/sin(z2/(z2-z1))-z2/cos(-z2/(z2-z1))-t/(sin(-z1/cos(z1/(z1-z2)))*(-z1)+cos(-z1/cos(z1/(z1-z2)))-(-t*z1)/cos(-z2/sin(-t/(z1-t)))))*(sin(sin(-z1/cos(z1/(z1-z2)))-cos(-z2/sin(z1/(z1-z2))))*(-z1/sin(-z2/cos(z1/(z1-z2)))-t/sin(-z2/sin(z1/(z1-z2)))))


-cotan(-z1/(z1+z2))*(-z1-(-tan(-z1/(z1+z2))/(-cotan(-z2/(z1+z2)))))*(-cotan(-z1/tan(-z1/(z1+z2)))-tan(tan(z1/tan((z1+z2)/z1)-z2/cotan((z1+z2/z2)))/cotan(-z1/(z1+z2))))*(z1/tan((z1+z2)/z1)-z2/cotan((z1+z2/z2))-tan(z1/cotan(-z2/(z1-z2))-z2/tan(-z1/(z2-z1))))*(cotan(z2/cotan(-z2/(z1-z2))-z1/tan(-z1/(z2-z1))))*((-z2/(z2-z1))*(-z1/(z2-z1))/tan(z1/cotan(-z1/(z2-z1))-z2/tan(-z1/(z1-z2)))-z1/cotan(-z1/tan(z2/tan(-z1/(z1-z2))-z1/cotan(-z1/(z2-z1))))-z2/tan(-z2/cotan(-z1/tan(z1/(z1-z2)-z2/cotan(z2/(z2-z1))))))
(z1/(z1-z2)-z2/(z2-z1)-t/(z1-t))*(z1/tan(z2/(z2-z1))-z2/cotan(-z2/(z2-z1))-t/(tan(-z1/cotan(z1/(z1-z2)))*(-z1)+cotan(-z1/cotan(z1/(z1-z2)))-(-t*z1)/cotan(-z2/tan(-t/(z1-t)))))*(tan(tan(-z1/cotan(z1/(z1-z2)))-cotan(-z2/tan(z1/(z1-z2))))*(-z1/tan(-z2/cotan(z1/(z1-z2)))-t/tan(-z2/tan(z1/(z1-z2)))))
-(-z1-z1/(z1+z2)-(-z1/(-z2)+z1/(z1/z2+z2/z1))*z2*z1/(z1+z2)-(-z1/(z1-z2)+z2/(z1-z2))*tan(z1/(z1+z2))-z1/cotan(z1/z2+z2/z1)*(-z1*z2/(z2-z1)*cotan(z2/(z1+z2))))-(-(-z1)/(z1-z2)+tan(z1/(z1/z2+z2/z1))*z1/(z1+z2)*cotan(z2/(z1/z2+z2/z1))-(-z2)*z1/(z1/z2-z2/z1))/(tan(z2/(z1+z2))-z1/cotan(z1/(z1/z2-z2/z1)))+z1*z2/(cotan(z1/z2+z2/z1)*tan(z1/z2-z2/z1)-cotan(z1/(z1+z2))/tan(z2/(z1+z2))+tan(z1/(z1/z2-z2/z1))/cotan(z2/(z1/z2+z1/z2)))+cotan(z1/(z1/z2-z2/z1))*tan(z2/(z2/z1-z1/z2))/(z1/(z1+z2)-z2/(z1/z2-z2/z1)*cotan(z2/(z2/z1-z1/z2)))

  ((-cos(-z1/sec(z1/z2))*cotan(-z2/tan(z2/z1))-cosec(-z2/cosec(z1/z2))*sin(-z1/cos(z2/z1)))*(tan(-z2/cotan(z2/z1))*sec(-z2/sec(-z1/z2)))/cotan(-z2/tan(-z1/cos(-z2/sec(-z1/z2))))-sin(-z2/cosec(z1/z2)*cos(-z1/tan(z1/z2))/sec(-z1/sin(-z2/cosec(-z1/z2)))))/(-tan(-z1*sec(sin(-z1/tan(z1/z2))))*cosec(-z1/sin(-z1/cotan(-z2/z1)))+cos(-z1/sin(-z2/cotan(-z2/cosec(-z1/z2))))*sin(-cos(-z1/cotan(-z2/z1)))/cosec(-z1/cotan(-z2/cotan(z2/z1))))

 (sin(z1)+tan(z2)+cos(z1))/(sec(z2)-sin(z2)-cotan(z1))*(cosec(z3)-sin(z3)-cos(z2)*cos(z3))/(cotan(z3)*tan(z1)-tan(z3)*sec(z3)-cos(z2)*sec(z3))
 (sinh(z1)+tanh(z2)+cosh(z1))/(sech(z2)-sinh(z2)-cotanh(z1))*(cosech(z3)-sinh(z3)-cosh(z2)*cosh(z3))/(cotanh(z3)*tanh(z1)-tanh(z3)*sech(z3)-cosh(z2)*sech(z3))
}

{

 -z1*ai*(-z2/sin(z2-ai/cos(-bi*sin(ci/i/tan(-di+c*(i-a)/(ai/bi/c+a)))-z1/cos(-z1/sec(-c-b/i/(-b+bi*d/di*(ci-i/a)))*bi+z2/ci/(a*ai-b/(i-bi)))))-c/cos(-ci^z1/bi+z2^(-ai))*cosec(-z2/(-sec(-z2^i*z1^ci/(ai^z1-bi^(i-z2))))))



}

// (power(x/(y+x),y/(y-x))-power(x/y,y/x))/(power(1/(y-x),1/(x*y))+power(x/(x+y),y/(x+y)))
// (power(x/(y+x),power(1/(y-x),1/(x*y))+power(x/(x+y),y/(x+y)))-power(power(1/(y-x),1/(x*y))-power(x/(x+y),y/(x+y)),y/x))/(power(1/(y-x),1/(x*y))+power(x/(x+y),y/(x+y)))

//  sin(x)/(sec(cos(x))-cos(csc(x)))+tan(y)/(sin(cos(y))/sec(csc(y))-cotan(y)/sec(y))
// (sin(x)/(sec(cos(x))-cos(csc(x)))+tan(y)/(sin(cos(y))/sec(csc(y))-cotan(y)/sec(y)))*(tan(x/y)/cos(sin(x/y))-sec(y/x)/csc(x/y)-(cotan(-x/y)/sec(-y/x)-tan(sec(y/x))-csc(tan(-x/y)))*sin(-y/x)*cos(csc(-y/x)))


//(cos(-x-a)*sin(-a-x)-cos(x*y-a)/(a-sin(-a+x*y))+x*(y*sin(x-y)-x*cos(-y+x)-sin(-x/y)*cos(-y/x)))*(sin(-x/cos(x-y))*cos(y/sin(x*y-a))+cos(x/sin(-y/x))*sin(-y/cos(-x/y))+cos(sin(x/y)*cos(y/x)))*(sin(y/sin(x*y-a))/(x-cos(-x/cos(x-y)))+x*sin(x/cos(sin(y/sin(x*y-a))))/(x-sin(cos(sin(x/y)*cos(y/x)))-cos(sin(-x/y)*cos(-y/x))))
//cos(-(-x/sin(-y/x)))*sin(-cos(-x/y)/(-x))*(sin(-x*y/(x-y))-cos(-x/(-1/sin(-y/x)))-sin(-1-x/cos(-x/y)))*(sin(-y/(x+y))+tan(-x/cos(-x/(x+y)))*cotan(-y/sin(-y/(x+y))))
//-cos(-x/(x+y))*(-x-(-sin(-x/(x+y))/(-cos(-y/(x+y)))))*(-cos(-x/sin(-x/(x+y)))-sin(sin(x/sin((x+y)/x)-y/cos((x+y/y)))/cos(-x/(x+y))))*(x/sin((x+y)/x)-y/cos((x+y/y))-sin(x/cos(-y/(x-y))-y/sin(-x/(y-x))))*(cos(y/cos(-y/(x-y))-x/sin(-x/(y-x))))*((-y/(y-x))*(-x/(y-x))/sin(x/cos(-x/(y-x))-y/sin(-x/(x-y)))-x/cos(-x/sin(y/sin(-x/(x-y))-x/cos(-x/(y-x))))-y/sin(-y/cos(-x/sin(x/(x-y)-y/cos(y/(y-x))))))

//(x/(x-y)-y/(y-x)-t/(x-t))*(x/sin(y/(y-x))-y/cos(-y/(y-x))-t/(sin(-x/cos(x/(x-y)))*(-x)+cos(-x/cos(x/(x-y)))-(-t*x)/cos(-y/sin(-t/(x-t)))))*(sin(sin(-x/cos(x/(x-y)))-cos(-y/sin(x/(x-y))))*(-x/sin(-y/cos(x/(x-y)))-t/sin(-y/sin(x/(x-y)))))


//-cotan(-x/(x+y))*(-x-(-tan(-x/(x+y))/(-cotan(-y/(x+y)))))*(-cotan(-x/tan(-x/(x+y)))-tan(tan(x/tan((x+y)/x)-y/cotan((x+y/y)))/cotan(-x/(x+y))))*(x/tan((x+y)/x)-y/cotan((x+y/y))-tan(x/cotan(-y/(x-y))-y/tan(-x/(y-x))))*(cotan(y/cotan(-y/(x-y))-x/tan(-x/(y-x))))*((-y/(y-x))*(-x/(y-x))/tan(x/cotan(-x/(y-x))-y/tan(-x/(x-y)))-x/cotan(-x/tan(y/tan(-x/(x-y))-x/cotan(-x/(y-x))))-y/tan(-y/cotan(-x/tan(x/(x-y)-y/cotan(y/(y-x))))))
//(x/(x-y)-y/(y-x)-t/(x-t))*(x/tan(y/(y-x))-y/cotan(-y/(y-x))-t/(tan(-x/cotan(x/(x-y)))*(-x)+cotan(-x/cotan(x/(x-y)))-(-t*x)/cotan(-y/tan(-t/(x-t)))))*(tan(tan(-x/cotan(x/(x-y)))-cotan(-y/tan(x/(x-y))))*(-x/tan(-y/cotan(x/(x-y)))-t/tan(-y/tan(x/(x-y)))))
//-(-x-x/(x+y)-(-x/(-y)+x/(x/y+y/x))*y*x/(x+y)-(-x/(x-y)+y/(x-y))*tan(x/(x+y))-x/cotan(x/y+y/x)*(-x*y/(y-x)*cotan(y/(x+y))))-(-(-x)/(x-y)+tan(x/(x/y+y/x))*x/(x+y)*cotan(y/(x/y+y/x))-(-y)*x/(x/y-y/x))/(tan(y/(x+y))-x/cotan(x/(x/y-y/x)))+x*y/(cotan(x/y+y/x)*tan(x/y-y/x)-cotan(x/(x+y))/tan(y/(x+y))+tan(x/(x/y-y/x))/cotan(y/(x/y+x/y)))+cotan(x/(x/y-y/x))*tan(y/(y/x-x/y))/(x/(x+y)-y/(x/y-y/x)*cotan(y/(y/x-x/y)))

//sin(-cos(-y/x)*sin(-x/y))*cos(-1/x)/(sin(-x/cos(-x/y))-cos(-y/sin(-y/x)))


//-cos(-x/(x+y))*(-x-(-sin(-x/(x+y))/(-cos(-y/(x+y)))))*(-cos(-x/sin(-x/(x+y)))-sin(sin(x/sin((x+y)/x)-y/cos((x+y/y)))/cos(-x/(x+y))))*(x/sin((x+y)/x)-y/cos((x+y/y))-sin(x/cos(-y/(x-y))-y/sin(-x/(y-x))))*(cos(y/cos(-y/(x-y))-x/sin(-x/(y-x))))*((-y/(y-x))*(-x/(y-x))/sin(x/cos(-x/(y-x))-y/sin(-x/(x-y)))-x/cos(-x/sin(y/sin(-x/(x-y))-x/cos(-x/(y-x))))-y/sin(-y/cos(-x/sin(x/(x-y)-y/cos(y/(y-x))))))
//(x/(x-y)-y/(y-x)-t/(x-t))*(x/sin(y/(y-x))-y/cos(-y/(y-x))-t/(sin(-x/cos(x/(x-y)))*(-x)+cos(-x/cos(x/(x-y)))-(-t*x)/cos(-y/sin(-t/(x-t)))))*(sin(sin(-x/cos(x/(x-y)))-cos(-y/sin(x/(x-y))))*(-x/sin(-y/cos(x/(x-y)))-t/sin(-y/sin(x/(x-y)))))
//-(-x-x/(x+y)-(-x/(-y)+x/(x/y+y/x))*y*x/(x+y)-(-x/(x-y)+y/(x-y))*sin(x/(x+y))-x/cos(x/y+y/x)*(-x*y/(y-x)*cos(y/(x+y))))-(-(-x)/(x-y)+sin(x/(x/y+y/x))*x/(x+y)*cos(y/(x/y+y/x))-(-y)*x/(x/y-y/x))/(sin(y/(x+y))-x/cos(x/(x/y-y/x)))+x*y/(cos(x/y+y/x)*sin(x/y-y/x)-cos(x/(x+y))/sin(y/(x+y))+sin(x/(x/y-y/x))/cos(y/(x/y+x/y)))+cos(x/(x/y-y/x))*sin(y/(y/x-x/y))/(x/(x+y)-y/(x/y-y/x)*cos(y/(y/x-x/y)))


//-(-x-x/(x+y)-(-x/(-y)+x/(x/y+y/x))*y*x/(x+y)-(-x/(x-y)+y/(x-y))*sin(x/(x+y))-x/cos(x/y+y/x)*(-x*y/(y-x)*cos(y/(x+y))))-(-(-x)/(x-y)+sin(x/(x/y+y/x))*x/(x+y)*cos(y/(x/y+y/x))-(-y)*x/(x/y-y/x))/(sin(y/(x+y))-x/cos(x/(x/y-y/x)))+x*y/(cos(x/y+y/x)*sin(x/y-y/x)-cos(x/(x+y))/sin(y/(x+y))+sin(x/(x/y-y/x))/cos(y/(x/y+x/y)))+cos(x/(x/y-y/x))*sin(y/(y/x-x/y))/(x/(x+y)-y/(x/y-y/x)*cos(y/(y/x-x/y)))
 //sin(2*x/(x+y))/(x+y)-3*x/(3*sin(x/(x+y))+1)+x/(2*sin(2*x/(x+y))-x/(2*sin(x/(x+y))))

//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//-(-x)-(-x/(-x-1-y)-t)*(-(-(-x-1)-y-y-1)/(-y)*t/(-y)-y)*(-(-sin(x)-1-x)-y*x/(-y)/(-y)-(-(1-cos(x)-x)-y)/sin(x)+(-(-x*x-y-y+1)-sin(y)/(-t-(-x)-1)*y)*y+(x-(-sin(x)-1-y)-t/(-t*x/(-y)-1)-1)-x-1)
//2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
//-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1/(-sin(x)+(-(-x*y))))
//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//-(-(-sin(x)-(-cos(x)*(-x-(-(-a)/sin(x)*x-(-(-cos(x)/x)/sin(x)*(-x)-sin(x)*(-x)*(-(-a))*(-x/cos(x)-sin(x)/(-y-(-a/x)))))))))
//-(-(-sin(x)/x-cos(x)*a/x-(-a/sin(x)*cos(x))-(-(sin(x)-(-a*(-x/sin(x)-(-cos(x)/x)))))-(-(-(-sin(x)*(-cos(x)/x)*x*b*(-b*x)/x/(-sin(x)))))*x/sin(x)/(-a)))
//2/(-3*x-y-t/x-(-sin(x/y-(-x-1)+1)-y)/t)-(-(-1-x)/y*2+3*x/y/t-cos(-(-x-y)/(-(-x+y*2)-x)-1)/(x+y*t/3)*x)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1)
//-(-sin(-x-c)-(-x)/sin(x-c)-cos(c-x))*x/sin(-(x+c))-cos(-(x+c))/(-b-c/sin(-(c-x)))-(-(-(2*sin(-(x-c)))))-(-cos(-c-x)*2)/sin(x-c)-(-2-cos(c-x)*3)/(sin(x+c)*2-3)-cos(c+x)*2
//-1/sin(a*cos(-c-x)-b)-cos(a*sin(-c-x)-b)/sin(a*sin(-c-x)-b)-(-cos(-c-x)-sin(a*cos(-c-x)-b)/cos(a*cos(-c-x)-b)-2*cos(a*sin(-c-x)-b))
//(-sin(-x)-(-1/(-cos(-y)*a)))*sin(a*cos(-x)-b)-x*(-x/cos(-y)-b*(sin(x)-cos(y)*b-c-c/cos(a*sin(x)-b))-sin(-y)/cos(a*sin(x)-b)-sin(-y)*cos(y)*(cos(a*cos(-x)-b)-cos(a*cos(x)-b)/(-(-a-sin(a*sin(-x)-b)*c)))-sin(y)/cos(x)/cos(a*sin(-x)-b)-b*sin(y)/cos(-x)/sin(a*sin(x)-b)/cos(a*sin(-y)-b))-(cos(a*sin(-y)-b)*sin(a*sin(-x)-b)/(x-sin(a*cos(-x)-b)))
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tan(x)-(-1/x-4+1/t-sin(y))))
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9)
//sin(x)+cos(3-2*sin(x))-sin(-(-3+2*sin(x)))*cos(-2*sin(x)+3)
//(x^7+x^6-92)/(x^4+x^5-38)/(x^2+x^3-10)
//(x^2+1)/(x^3+x)/(x^4+x*y)/(1+1/x)/(x-1/x)/(1-1/(1+(1/x+x/(1-1/(x^2+1)))/(1/x+x/(x/(x^2-1)))))

//tan(x/sin(-x/y)-y/cos(-y/x))*(-y/cotan(x/tan(-x/y)-y/tan(-y/x))+x/tan(sin(-y/x)/x-cos(-x/y)/(-x)))

//x=2; y=5; x=sin(x)*cos(-x)+sin(1/sin(y-cos(x)*sin(-x))); y=cos(y)-sin(x-y)*cos(y-x)/(cos(x-y)-sin(y-x)*cos(sin(y)))+cos(sin(y))*sin(sin(y)); x=sin(y/cos(x)-sin(x-y)*cos(y-x))+cos(y/cos(x))*sin(y/cos(x)-sin(y-x)); y=cos(1/x-x/sin(x)-y/cos(x*sin(x-y)/cos(y-x)))+sin(x/sin(x))*cos(x*sin(x-y)/cos(y-x))*(x*sin(x-y)/cos(y-x)+x/sin(x)); y=(sin(-x)*cos(-y)*x/y+x)*(sin(-x)*cos(-y)*x/y-y)/(x/sin(x)-1/(x-x/sin(x))); x=x*(sin(x-y)*cos(y-x)+cos(x-y)*sin(y-x))-t*(sin(x-y)*cos(y-x)+cos(x-y)*sin(y-x));x+y
//x=2.123; x=sin(x)*cos(x)/(sin(x)+cos(x));  x=sin(x)*cos(x)/(sin(x)+cos(x));  x=sin(x)*cos(x)/(sin(x)+cos(x));  x=sin(x)*cos(x)/(sin(x)+cos(x)); x
//x=2.123; y=5.456; x=(sin(x/(x+y))*cos(x/y))/(sin(x/y)+tan(x/(x+y))-x/(x+y)); y=(cos(-y/x)+sin(y/x)+tan(x/(x+y)))*(x/(x+y)-x/y-y/x); x=(x/(x+y)+tan(x/(x+y))/(x/(x+y))-x/y-y/x)*(sin(x/y)+cos(y/x)/cotan(x/(x+y))); y=(tan(x/(x+y))*sin(x/y)+cotan(x/y)*cos(x/(x+y)))/(tan(x/(x+y))*cos(x/y)-cotan(x/y)*sin(x/(x+y)));y*x

//*******integ var************
//(-1.65-j*2.76+k/2.75-k*j*(-2.21*x*y*k*t/j-m*(x*m-j*y-t*2.65)/(-k*j/x-(t-j)*(m-x)/((k+x)*(t+j))))*x)*(-1.54/x-2.76*t/(-x*2.54*y/(-2.34*t/x+y*2.65-1.65*t-3.64))*(y*1.32*x*(-t)-2.32)*(-2.43-t/2.65-x*1.65+y*3.12)/(-2.76/t-k/x-2.76*t/m)+(t*x/2.65*y)*(-(-2.87-(-k-(-x-y/(-k*t-x/(-1.54-x*2.65)*1.75*x/y*t/2.43)))-x-y/(-x+1.64/t))))/(1.67*t*x*(j/(-t/(-x*k+(-j)*y+(-t)*(-m))-x*(-y)/(-2.72/(x/k-j/(-y))))*2.76-2.54*k-3.65*y+2.76*x*y*k)-k/x*m/t*(x-(-x*(-(-k+j))*(-y*k-3.76*m))))
//k*y*(2*k+1)*(2*k*y/t-2*k*(3*t-1)/(2*k-3*y-4)*(k/(3*k-1)-4/k+5*(2*k*y*t-1)/(y+1)-7*(2*k*(y+1)*(3*y+2)*(3/(k+1)-2*t/(2*k*y*t-1)+(4*k-1)*(5*y-7)/(k-2*y-1-2*t/(3-7*k-8*y*(4*k/(2*t+1)-7*k-8/t+9*(2*k-1)*(3*k+4*y+5)*(2*k*y*t-7)*k*y*t/(k-y*2-3/(k/(t-1)-7/(y+2)+8/(2*k*y*t+1)-9)))))/(k-1)))))
//k*j*(2*k+1)*(2*k*j/t-2*k*(3*t-1)/(2*k-3*j-4)*(k/(3*k-1)-4/k+5*(2*k*j*t-1)/(j+1)-7*(2*k*(j+1)*(3*j+2)*(3/(k+1)-2*t/(2*k*j*t-1)+(4*k-1)*(5*j-7)/(k-2*j-1-2*t/(3-7*k-8*j*(4*k/(2*t+1)-7*k-8/t+9*(2*k-1)*(3*k+4*j+5)*(2*k*j*t-7)*k*j*t/(k-j*2-3/(k/(t-1)-7/(j+2)+8/(2*k*j*t+1)-9)))))/(k-1)))))
//k!*(2*k-3*j-4)/(3*j-(k+1)!)!-k-j/(k+1)!+2^(k+j-1)/2^k
//6*(y-a)^n+(y-a)^k+3*(y-a)^(2*k+4)+4*(y-a)^(2*k+5)+5*(a-y)^n-2*(a*x+b)^(2*k+n)-3*(a*x-b)^(2*k+j)+4*(2*x+y)^(2*k+j+1)-3*(2*x*y+1)^(7-k)-9*(2*x*y+1)^(7-n)-2*(2*x*y-1)^(7-k)-(2*(y-a)^n-3*(y-a)^k+4*(a-y)^n-5*(a*x+b)^(2*k+n)-6*(a*x-b)^(2*k+j)+7*(2*x+y)^(2*k+j+1)+8*(2*x*y+1)^(7-k)-2*(2*x*y+1)^(7-n)+10*(2*x*y-1)^(7-k)-5*(y-a)^(2*k+4)-8*(y-a)^(2*k+5))
//sin(2*x*k-3)*cos(x*k+1)^(k+1)-k/x*(k+1)*(2*x*k-3)/sin(x*k+1)^(k+1)-x*k*(2*k+3*n+4)/(x*k-y*n-k*a)*(5*k!^k-2^(k+n)!)-(3*2^(k+n)!/k!^k)*sin(x*k+1)^(k+1)*(cos(2*x*k-3)/cos(x*k+1)^(k+1))

// (y/x)^(2*k+3*j-7)/((2*k*j-15)!+(k!+j!!)^k!)-2^(3*k*l+2*k*l-2*j-1)*(-1)^(k+2*j-1)/(2*k!^j+2^(j+n-2)!)
// (y/x)^(k+n)*(x^j/y^k)^(n+j+1)*((x/y)^(-1)*x^k!/y^(j-3)!/((y/x^2)^(2*k*n+3*j-5)+x^(3*k+j*2)/y^(3*n+2) -(x^j/y^k)^(j*2+3*n*k*5-15)*(x/y)^(j-2)!))
//**************array*************
//-vd[k+j]/ve[j-k]-k*j*ve[|-vd[k]|]-x*(2*ve[k*2+1]+3)*vd[j+1]^2*(2*ve[(k+1)!]-ve[k*j]*3-5)
//-(-vd[k+1]-ve[2*j+1])-(-(-vd[k+2]))^2-(-(-x-vd[(k+1)!]))*vd[k*2]^3/ve[7]^2*(-vd[j]-(-ve[k+5])*(5-ve[k+8]*2)*vd[j+3]*(-(-a*ve[k+5]-3)))
//-(-(-(vd[k^2])))-(-(-ve[2*k!+1]))-(-(-vd[(k+1)!])-ve[2*k]^k!-k^vd[j+2])
//sqr(norm(ve))-sumq(ve)+sum(ve)/len(ve)-avr(ve)

//**********functions*******************
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//sin(-a/b-1)*(c+1)^(1+d)-tan(c*(-d)^(2+c))-(2*a+3)^(b+1)-(-a+1/sin(b^(-c)+3^(-d)-d^(-5)))
//sin(x)^(-2)-3*cos(y)^(-5)-(-(-8*sin(y)^(5))-(-(-9*cos(x)^(-7)))-(10*cos(y)^(11))-(-(-11*sin(y)^(5)))-1/cos(y)^(-5)*cos(x)^(-7)/cos(y)^(11))
//2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*(t+5)^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+12)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))

//2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*(t+x*y)^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+x*y)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))

//(x+1)^2+2*(x+1)^3-3*(x+1)^4+4*(x+1)^5-6*(x+1)^6+2*(x+1)^7+2*(x+1)^8-2*(x+1)^9+2*(x+1)^10-8*(x+1)^11+2*(x+1)^12-7*(x+1)^13+2*(x+1)^14-4*(x+1)^15-3*(x+1)^16+8*(x+1)^17+2*((x+1)^(-2)+2*(x+1)^(-3)-3*(x+1)^(-4)+4*(x+1)^(-5)-6*(x+1)^(-6)+2*(x+1)^(-7)+20*(x+1)^(-8)-20*(x+1)^(-9)+20*(x+1)^(-10)-80*(x+1)^(-11)+20*(x+1)^(-12)-70*(x+1)^(-13)+20*(x+1)^(-14)-40*(x+1)^(-15)-30*(x+1)^(-16)+80*(x+1)^(-17))*((x+1)^2/(x+1)^3*(x+1)^4/(x+1)^5*(x+1)^6/(x+1)^7*(x+1)^8/(x+1)^9*(x+1)^10/(x+1)^11*(x+1)^12/(x+1)^13*(x+1)^14/(x+1)^15*(x+1)^16/(x+1)^17*((x+1)^(-2)/(x+1)^(-3)*(x+1)^(-4)/(x+1)^(-5)*(x+1)^(-6)/(x+1)^(-7)*(x+1)^(-8)/(x+1)^(-9)*(x+1)^(-10)/(x+1)^(-11)*(x+1)^(-12)/(x+1)^(-13)*(x+1)^(-14)/(x+1)^(-15)*(x+1)^(-16)/(x+1)^(-17)))
//(a*x*t*sin(t/a+b)*(b*x+d)*((cos(c*(a*x+b*y+c*t+d))+1)^(c*x-b)-d)-tan(a*sin(a*x+b*y+c)^2-b*cos(a*x*y*t+b)^5+c)^3)/(a*x*y*(b*t-c)^(c*x-d)*(b*t+a)-b*x*sin(a*(b*x+c)^3-b)^4+d)+a*(b*x+c*y+d*t+c)*(a*x*y*t+b)*x*y*t-(b*x*y*t*(c*sin(b*x+c)+d)^3)/(((a*x+b)*(c*y-d)*(b*t+c)*x*y*t*b+c)*sin(a*cos(c*x+d)+b)^3)

//(a*x*t*sin(t/a+b)*(b*x+d)*cos(c*(a*x-b*y+c*t+d)^(c*x-b)-d)-tan(a*sin(a*x+b*y+c)^2-b*cos(a*x*y*t+b)^5+c)^3)/(a*x*y*(b*t-c)^(c*x-d)*(b*t+a)-b*x*sin(a*(b*x+c)^3-b)^4+d)+a*(b*x+c*y+d*t+c)*(a*x*y*t+b)*x*y*t-(b*x*y*t*(c*sin(b*x+c)+d)^3)/(((a*x+b)*(c*y-d)*(b*t+c)*x*y*t*b+c)*sin(a*cos(c*x+d)+b)^3)

//(2*sin(3*x+4)*cos(2*x*y*t-7)*x/sin(2*x*y+1)-x*y*t*2*cos(2*x+3)/sin((4*x+2)/(4*y+1))-cos(2*x*y-7))*x/sin(x/y*2-3)/sin(2*x*y-8)-2*x/cos(x*sin(5*x+3)/cos(5*x-7)+8)+2*sin(2*x+3*y-4*t+5)*cos(3*x*y*t+7)/(2*x+3)-x/(-(-2/cos(3*x+4)*sin(2*x*y*t-7)*x-x*y/sin(2*x+3)*cos(4*x+2)-2*x-5*x+8))-x*(-(2*y-3-x-(2*x+1)*2*cos(5*x+3)*sin(5*x-7)+x/cos(2*x+3*y-4*t+5)/sin(3*x*y*t+7)-sin(2*x*y+1))/(2/cos(2*x*y-8)-1)-3*cos(3*x*y+1)*(2*cos(2*x*y+1)-1)*y/t)
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//2/cos(3*x+4)*sin(2*x*y*t-7)*x-x*y/sin(2*x+3)*cos(4*x+2)
//(2*x+1)*2*cos(5*x+3)*sin(5*x-7)+x/cos(2*x+3*y-4*t+5)/sin(3*x*y*t+7)
//sin(2*x*y+1)/(2/cos(2*x*y-8)-1)
//cos(3*x*y+1)*(2*cos(2*x*y+1)-1)
//x^y*sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//sec(csc(csch(sech(arccsch(arcsech(arcsec(arcsech(x/5))))))))
//csch(sech(arccsch(arcsech(arcsec(arcsech(x/5))))))+cosec(sec(arccot(arctan(arccosec(5*arcsec(arccos(arcsin(x/5))))))))

//sin(2*x/y-1)/x*y*(2*x*y+1)*cos(x*cos(2*x/y-1)/(-x-1)+x)-(-(-sin(-x/y*(2*x+1))*sin(1-2*x/y)*(2*x-1)*(2*t+1)*(3*y+2)/(2*x*y*t+1)-2*x/cos(x/y-x)))*(-x)/((-x-(-1/(-sin(-x/cos(sin(-x/y)-cos(-y/x)))))))+(-(-sin(x/cos(x/y)-cos(y/x)/x)*x*(-x)*(-x-y/x))-(-(-cos(-sin(x-cos(-y/x))))-x-sin(x-cos(-y/x))/cos(-sin(-x/y))))

{x=2;y=5; t=1.77 :}
//x=2;y=5; t=1.77; 2/(-x-(-sin(x*(3-t-(4*t-(-((x*(-sin(x-(-3*t-(2*x-t))*(1-sin(x-2*(-t-(2*t+1))-t)^x)-x^t)/(x^t)+(t*(-x)-t)-((x+1)-t/(x+t))^x-(2*t-7)/(2*sin(x)+t))-t*(-t-7)^x*(x*t)-7*t-8)-(t*(-x-t)^x*t^x*(x+1)-(t+1)-t))-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x)))))
//x=2;y=5; t=1.77; 2/(-x-(-sin(x*|3-t-[4*t-(-|t-[x*{-sin(x-{-3*t-|2*x-t|*[|-y-t|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-|x^{t*y}-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))
//x=2;y=5; t=1.77; 2/(-x-(-sin(ve[x]-vd[k]^2-vd[3]-x*|3-t-vd[k]^2*[4*t-(-|ve[k]-t-[vd[y]*x*{-sin(vd[2]*ve[y]-{-vd[3]*t-|2*x-t-||vd[|-x|]|^|vd[k]|||*[|-y-t-vd[k]|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-vd[{t*y}*2]-|x^{t*y}-[vd[x*k]^2-|t-y|^vd[2]]-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))
//x=2;y=5; t=1.77; 2/(-x-(-sin(x-x^2-x-x*|3-t-x^2*[4*t-(-|x-t-[y*x*{-sin(x*y-{-x*t-|2*x-t-||-x|^|y|||*[|-y-t-x|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-vd[{t*y}*2]-|x^{t*y}-[vd[x*k]^2-|t-y|^vd[2]]-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))

//2*sin(2*x*y+3)-(-(-cos(2*x*y-3))/(-sin(2*x*y-3)))-(-(cos(sin(2*x*y+3)-1)*(-sin(-cos(2*x*y-3)-1))))-(-cos(3-2*x*y)-cos(sin(3-2*x*y)))/(-cos(cos(2*x*y-3)-1))
//2*sin(2*x*y+3)-(-(-cos(2*x*y-3))/(-sin(2*x*y-3)))-(-(cos(sin(2*x*y+3)-1)*(-sin(-cos(2*x*y-3)-1))))-(-cos(3-2*x*y)-cos(sin(3-2*x*y)))/(-cos(cos(2*x*y-3)-1))+(-cos(sin(2*x*y+3)-1)/(cos(-sin(2*x*y+3)-1)))+(3-(-cos(sin(2*x*y+3)-1)*(5-sin(-cos(2*x*y-3)-1))))/(1-(-cos(sin(3-2*x*y)))-cos(cos(2*x*y-3)-1))
//2*sin(2*x*y+3)-(-(-cos(2*x*y-3))/(-sin(2*x*y-3)))-(-(cos(sin(2*x*y+3)-1)*(-sin(-cos(2*x*y-3)-1))))-(-cos(3-2*x*y)-cos(sin(3-2*x*y)))/(-cos(cos(2*x*y-3)-1))+(-cos(sin(2*x*y+3)-1)/(cos(-sin(2*x*y+3)-1)))+(3-(-cos(sin(2*x*y+3)-1)*(5-sin(-cos(2*x*y-3)-1))))/(1-(-cos(sin(3-2*x*y)))-cos(cos(2*x*y-3)-1))+(-(cos(-sin(3-2*x*y)))/(-cos(3-2*x*y)/(-sin(-cos(2*x*y-3)-1)))-1)
//||sin(x)-cos(x)|-|cos(x)-sin(x)||-|cos(x^2)-sin(x)|-|cos(x)-sin(x^2)-|cos(x^2)-|sin(x^2)|||
//abs(abs(sin(x)-cos(x))-abs(cos(x)-sin(x)))-abs(cos(x^2)-sin(x))-abs(cos(x)-sin(x^2)-abs(cos(x^2)-abs(sin(x^2))))

//sin(x/cos(y/x))/(sin(y/x)-cos(x/cos(y/x)))
//sin(cos(x)^3+sin(x)^3)*cos(cos(-x)-sin(x))/(cos(x)^3-sin(-x)^3+sin(cos(-x)*x)*cos(sin(-x)*x))+cos(x/y)*sin(cos(y/x*cos(x/y)))*(sin(y/x*cos(x/y)))/(cos(y/x)*sin(x/y^3)-cos(-x)^3*sin(-x)^3)+cos(sin(y/x*cos(x/y)))/(sin(x/y)^3+cos(y/x)^3-sin(cos(y/x))^3-cos(cos(y/x))^3)
//(sin(x^2+y^2)+cos(x^2+y^2))/(sin(cos(x^2/y^2))-sin(x^2/y^2))-(-sin(-cos(y^2/x^2))-(-1/cos(-sin(x^2/y^2)))*(-sin(x^2+y^2)/cos(sin(x^2+y^2)))-1/(-sin(y^2/x^2)-(-sin(cos(y^2/x^2)))))-sin(-x^2/y^2)/(cos(-y^2/x^2))*(cos(sin(-x^2/y^2))+sin(sin(-y^2/x^2))-cos(-y^2/x^2)/(cos(sin(-x^2/y^2))-sin(cos(-y^2/x^2))))+sin(cos(-x^2/y^2))/(cos(cos(-x^2/y^2))-sin(cos(-y^2/x^2)))
//(sin(x^2+y^2)+cos(x^2+y^2))/(sin(cos(x^2/y^2))-sin(x^2/y^2))-(-sin(-cos(y^2/x^2))-(-1/cos(-sin(x^2/y^2)))*(-sin(x^2+y^2)/cos(sin(x^2+y^2)))-1/(-sin(y^2/x^2)-(-sin(cos(y^2/x^2)))))-sin(-x^2/y^2)/(cos(-y^2/x^2))*(cos(sin(-x^2/y^2))+sin(sin(-y^2/x^2))-cos(-y^2/x^2)/(cos(sin(-x^2/y^2))-sin(cos(-y^2/x^2))))+sin(cos(-x^2/y^2))/(cos(cos(-x^2/y^2))-sin(cos(-y^2/x^2))/(sin(x^2/y^2)+cos(sin(y^2/x^2))-sin(cos(-x^2/y^2))/(cos(sin(cos(-x^2/y^2)))+sin(sin(cos(-y^2/x^2)))+cos(sin(cos(-y^2/x^2))))))
//((sin(x)^2+1)^(cos(x)^2+1)+(cos(-x)^2+1)^(sin(x)^2+1))*((sin(x/y)^2+1)^(cos(x/y)^2+1)+(cos(y/x)^2+1)^(sin(x/y)^2+1))/(((sin(x)^2+1)^(cos(x)^2+1)-(cos(-x)^2+1)^(sin(x)^2+1))/((sin(x/y)^2+1)^(cos(x/y)^2+1)-(cos(y/x)^2+1)^(sin(x/y)^2+1)))
//((sin(x)^2+1)^(cos(x)^2+1)+(cos(-x)^2+1)^(sin(x)^2+1))*((sin(x/y)^2+1)^(cos(x/y)^2+1)+(cos(y/x)^2+1)^(sin(x/y)^2+1))/(((sin(x)^2+1)^(cos(x)^2+1)-(cos(-x)^2+1)^(sin(x)^2+1))/((sin(x/y)^2+1)^(cos(x/y)^2+1)-(cos(y/x)^2+1)^(sin(x/y)^2+1)))+((sin(x)^3+1)^(cos(x)^2+2)+(cos(-x)^2+2)^(sin(x)^3+1))*((sin(x/y)^2+2)^(cos(x/y)^3+1)+(cos(y/x)^2+2)^(sin(x/y)^3+1))/(((sin(x)^3+1)^(cos(x)^2+2)-(cos(-x)^3+1)^(sin(x)^2+2))/((sin(x/y)^3+1)^(cos(x/y)^2+2)-(cos(y/x)^3+1)^(sin(x/y)^2+2)))
//(2*sin(sin(2*x*y+3)/cos(3*x-y+1)-x/cos(x-1))+3)/(5*cos(sin(2*x*y+3)/cos(3*x-y+1)-x/cos(x-1))+7)+(-cos(sin(2*x*y+3)/cos(3*x-y+1)-x/cos(x-1))+x)/(x/sin(sin(2*x*y+3)/cos(3*x-y+1)-x/cos(x-1))+1)

//sinh(2*(1-x)^2)+sh(sqr(-x+1)/0.5)

 //((sin(-x/y)+1)^(k*x+3)+cos(-y/x)^(k+1)-x/((cos(-x/y)+1)^(x/y)-sin(-cos(-y/x))^(k*n+j)))*(-cos(-x/(x+y))^(y/(x+y))/((sin(x/(x+y))+1)^(-x/(x+y))))*((cos(-y/(x+y))+1)^(sin(-x/(x+y))+1)+(sin(-sin(-x/y)+cos(-y/x))+1)^(sin(-y/x)^(k+1)+1))*(sin(cos(x/(x+y))-(sin(-x/(x+y))+1)^(1+sin(x/(x+y))))-(cos(-sin(-y/(x+y)))-sin(-y/x)^(k+1)))
// (x^|x-y|)*(|t-x|^|t/y-x|-[x]^[y])/(x^y^t-[y-x]^|t-x|^vd[k+1])*(x/y^(x/y)-y^(y/x^t/y^|x-y|)/(x/x^y-(y^t-|t|^x/x)^(x/(x+y)+y/(x+y))))*j!^k!*(k!^j-j^vd[j^k+1])
 // (x/(x^(x/y)/y-(y/x)^y/x))*(x^(x/y^x+y/x^y)-x^(x^y/y^x))/(y^(x^(y^(x/y)))*(x/y)^((y/x)^(y/x-x/y)))/((x^y/y^x-x^(y/x-x/y)^(x/(x+y)))*(x^(y/(x^y-y^x))/(y^((x/y)^(y/x-1.21)-(x/(y-x)^y)))))


 //    *****->
//sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))+sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)*(exp(y*x-1))))))
//x*t-x^t*(x^(x*t-x^t*(x^(x*t-x^t*(x^t)))))
//x*t-x^(-1)*(x^(x*t-x^(-2)*(x^(x*t-x^(-3)*(x^(-4))))))
//x*t-x^7*((x*t-x^7*((x*t-x^7*(x^7))^7))^7)
//x*t-x^5*((x*t-x^5*((x*t-x^5*(x^5)+(x*(x^5))^5)^5)^5)^5)^5
//x*t-x^(-5)*((x*t-x^(-1)*((x*t-x^(-2)*(x^(-3))+(x*(x^(-4)))^(-2))^(-2))^(3))^(4))^(5)
//(x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1)
//(x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1)-((x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1))
//(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-((2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)){!!!!!XCH no error so as big number}
//-(2*tan(x-5)/cotan(x-5)^3-(2*tan(x-5)-1)^3/cotan(x-5)^5-7/cotan(3*x-y+1)^3)/tan(3*x*y+1)^5-3*(4*tan(3*x-y+1)^3+2)/(2*cotan(x-5)-1)^3*(2*x*cotan(x-5)^5-5)-x*(-(2/tan(x-5)*(-cotan(x-5)^3)-(2/tan(x-5)-1)^3*cotan(x-5)^5-7*cotan(3*x-y+1)^3)*tan(3*x*y+1)^5-3/(4*tan(3*x-y+1)^3+2)*(2*cotan(x-5)-1)^3/(2*x*cotan(x-5)^5-5))
//sin(x)*cos(x)+sin(x+1)/sin(x)+cos(x+1)*cos(x)
//(sin(x)+cos(x)*x+(sin((cos(x+2)+x*sin(x+2)+x/(sin(x)+cos(x)+cos(x+2))-sin(x+2))*sin(2*cos(x+1)+1))+cos(x+1)+(cos((sin(cos(x+1))+2*cos(2*sin(x+1)+1)+sin(2*cos(x+1)+1))))))
//x/sin(x)-cos(x)/(4*sin(x+1)-3)/(2*cos(2*sin(x)+1)-3)-(-(-sin(2*cos(x)+1)-1)-(-2*sin(2*sin(x)+1)))/(-sin(2*cos(x+1)+1)-x/(3*sin(2*sin(x+1)+1)-4)-5/(4*cos(x)*sin(x+1)/(5*sin(2*cos(x+1)+1)))-5-(4*cos(2*sin(x+1)+1)+1)/sin(x+1)*(-cos(x+1)+2)/x/cos(2*cos(x+1)+1))-2*sin(2*cos(x)+1)*cos(2*sin(x)+1)/(2-sin(2*sin(2*sin(x)+1)*3*cos(2*cos(x)+1)))
//sin(2*x*y+1)*cos(2*x+y+1)/(3*cos(2*x*y+1)-4*sin(2*x+y+1))

//1/sin(x)-(-cos(x)-sin(x)^(-1))/cos(x)^(-1)-cos(2*sin(x)^(-1))*sin(2*sin(x)^(-1))/(cos(2*sin(x)^(-1))-sin(2*sin(x)^(-1)))
//sin(x)^(-1)-cos(x)^(-1)-(cos(sin(x)^(-1))^(-1)-sin(sin(x)^(-1))^(-1))-(sin(sin(x)^(-1))^(-1)-2*sin(sin(x)^(-1)))
//(sin(cos(sin(x)))+cos(sin(x)))/(sin(cos(sin(x)))-cos(sin(x))-sin(cos(x)))-cos(x)*cos(sin(cos(x)))-sin(x)/(cos(sin(cos(x)))+cos(x))
//x/sin(2*cos(2*x)+1)-cos(x+1)*cos(2*x)-sin(2*x)/(cos(sin(2*x))-sin(x+1)*sin(2*cos(x)+1))-cos(sin(2*x))*sin(2*cos(2*x)+1)
//1/tan(x)-(-cotan(x)-sin(x)*(tan(x)^(-1)-1/cos(x)^2))-(cos(x)-x*(-cotan(x)^(-1)-sin(x))/tan(x)^(-1))
//arcsin(x/5)^x-1/arccos(x/5)-(-arcsin(x/5)-arccos(x/5)^x)/(arcsin(x/5)^x+arccos(x/5)^x)

 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)
 //(-sin(x)^(-1))-cos(x)^(-2)/sin(x)^(-3)+sin(x)^(-1)-cos(x)-(-sin(x)-cos(x)^(-2))/sin(x)^(-3)
 //(-arccotan(x)^(-1))-arctan(x)^(-2)/arccotan(x)^(-3)+arccotan(x)^(-1)-arctan(x)-(-arccotan(x)-arctan(x)^(-2))/arccotan(x)^(-3)
 //(-arctan(x)^(-1))-arccotan(x)^(-2)/arctan(x)^(-3)+arctan(x)^(-1)-arccotan(x)-(-arctan(x)-arccotan(x)^(-2))/arctan(x)^(-3)
 //arctg(x)^(-1)/(-arcctg(x)^(-2))+arctg(x)^(-2)/arctg(x)^(-1)
 //power(sin(x),(-1))/power(cos(x),(-2))/power(sin(x),(-3))/power(sin(x),(-1))/cos(x)/sin(x)/power(cos(x),(-2))/power(sin(x),(-3));
 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)
 //(arcsin(x/(x+y))+arccos(y/(x+y)))/(arcsin(y/(x+y))+arccos(x/(x+y)))+(arctan(x/(x+y))+arccot(y/(x+y)))/(arctan(y/(x+y))+arccot(x/(x+y)))

 //(cos(x)^(-1)+sin(x)^(-1))/(sin(x)^(-1)-cos(x)^(-1))


 //(cos(x)^(-2)+sin(x)^(-2))/(sin(x)^(-2)-cos(x)^(-2))
 //-cos(x)^(-1)-(-cos(x)^(-2))+sin(x)^(-1)*sin(x)^(-2)/(-cos(x)^(-2))*sin(x)^(-1)
   //(sin(x)^(-2)+cos(x)^(-2))/(sin(x)^(-1)+cos(x)^(-1))
   //(1/sin(x)^2+1/cos(x)^2)/(1/sin(x)+1/cos(x))

{
(((sin(x/y)+1.123)^cos(y/x)+1.123)^sin(x/(x+y))+1.123)^cos(y/(x+y))
(((((sin(x/y)+1.123)^cos(y/x)+1.123)^sin(x/(x+y))+1.123)^cos(y/(x+y))+1.123)^tan(y/(x+y))+1.123)^cot(x/(x+y))
(((sin(x/y)-cos(y/x)+2.123)^(tan(x/y)/cot(y/x))))^((sin(x/(x+y)))^cos(y/(x+y))-sin(y/(x+y))^cot(x/(x+y))/tan(y/(x+y)))
((((sin(x/y)-cos(y/x)+2.123)^(tan(x/y)/cot(y/x))))^(sin(x/(x+y))))
((((sin(x/y)-cos(y/x)+2.123)^(tan(x/y)/cot(y/x))))^(sin(x/(x+y))))^cos(y/(x+y))
(((((sin(x/y)-cos(y/x)+2.123)^(tan(x/y)/cot(y/x))))^(sin(x/(x+y))))^cos(y/(x+y)))^tan(x/(x+y))
((((((sin(x/y)-cos(y/x)+2.123)^(tan(x/y)/cot(y/x))))^(sin(x/(x+y))))^cos(y/(x+y)))^tan(x/(x+y)))^cot(y/(x+y))
((sin(-cos(x/y))+1.123)^cos(y/(x+y))-(cos(sin(x/(x+y)))+1.123)^(sin(y/(x+y))-cos(sin(y/x)))+2.123)^((cos(sin(x/y)-cos(y/x))+1.123)^(cos(sin(x/(x+y)))-sin(-cos(y/(x+y)))))

}


//(asin(x/(x+y))+acos(y/(x+y)))*(1/acos(x/(x+y))+1/asin(y/(x+y)))+(asin(x/(x+y))+acos(y/(x+y)))/(acos(x/(x+y))+asin(y/(x+y)))
 //sinh(x)/(-exp(x))+cosh(x)/(sinh(x))-exp(x)/cosh(x)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-n)/(-exp(x)^(-k))+cosh(x)^(-k)/(sinh(x)^(-n))-exp(x)^(-n)/cosh(x)^(-k)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)*(exp(x)^(-1)+cosh(x))-tanh(x)^(-1)/(-cotanh(x)^(-1)/exp(x)-cosh(x)^(-1))+tanh(x)/exp(x)^(-1)
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1))))/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1)+sinh(exp(x-1))))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1))+sinh(exp(x-1)))-1/exp(x-1)-exp(x-1)^2-1/exp(x+1)^(-1)*(-tanh(x+1)^(k+1)-1/cosh(x+1)^(k+1)-1/sinh(exp(x-1)^2))-(sinh(exp(x-1))-1/cosh(exp(x-1))^2)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //tanh(x)-exp(x)/(cosh(x)+exp(x)*tanh(x))+sinh(x)/(cotanh(x)-tanh(x))-exp(x)*(cosh(x)+tanh(x)+cotanh(x)+sinh(x)+exp(x))
 //sinh(x)+exp(x)*sinh(x)^2-cosh(x)/(cosh(x)^2+tanh(x))-exp(x)^2*sinh(x)^2
 //sinh(x)+cosh(x)+cosh(x)^t-sinh(x)/(cosh(x)^t+exp(x))
 //exp(x)*sinh(x)-cosh(x)/(exp(x)+sinh(x)-cotanh(x))
 ////sh(x)/(-exp(x))+ch(x)/(-sh(x))
 //sinh(x)/(-exp(x))+cosh(x)/(-sinh(x))   !!!
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(-sinh(x)^(-1))
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)
//sinh(x)/(-exp(x))+cosh(x)/(-sinh(x))-(-(-sinh(x)/(-1/cosh(x)-1/(-(-1/exp(x))))))
//sinh(x)/(-exp(-x))+cosh(x)/(-sinh(-x))-(-(-sinh(x)/(-1/cosh(-x)-1/(-(-1/exp(x)-exp(-x))))))+(-1-(-sinh(-exp(x))-x/cosh(exp(-x))*(-x)-1/(-sinh(cosh(-x)))))
//sinh(x)/(-exp(-x))+cosh(x)/(-sinh(-x))-(-(-sinh(x)/(-1/cosh(-x)-1/(-(-1/exp(x)-exp(-x))))))+(-1-(-sinh(-exp(x))-x/cosh(exp(-x))*(-x)-1/(-sinh(cosh(-x)))))+tanh(-x)/(-cotanh(x))+sinh(-exp(x))/cosh(-exp(x))/sinh(exp(-x))
//sinh(x)/(-exp(-x))+cosh(x)/(-sinh(-x))-(-(-sinh(x)/(-1/cosh(-x)-1/(-(-1/exp(x)-exp(-x))))))+(-1-(-sinh(-exp(x))-x/cosh(exp(-x))*(-x)-1/(-sinh(cosh(-x)))))+tanh(-x)/(-cotanh(x))+sinh(-exp(x))/cosh(-exp(x))/sinh(exp(-x))/(-(-(-tanh(-exp(-x))-1/cotanh(-exp(-x)))))
//sinh(1-x)+tanh(x+1)/exp(x-1)-sinh(x-1)/cosh(x+1)+tanh(x-1)-exp(x-1)/(cosh(tanh(x+1)/sinh(x-1)))*tanh(sinh(tanh(3-x)))+cosh(sinh(x-1))/sinh(cosh(1-x))+tanh(exp(1-x))/sinh(tanh(3-x))+cosh(tanh(3-x))/exp(3-x)-sinh(exp(3-x))*cosh(3-x)*sinh(1-x)+cosh(sinh(exp(3-x)))/sinh(tanh(1+x))+sinh(cosh(1+x))/tanh(exp(1-x))
//(-2/asin(x/(x+y))+1)*(-acos(y/(x+y))*2+1)-(-atan(x^2/(x^2+y^2))*3+4/acos(x/(x+y))*(3*asin(y/(x+y))-acot(y^2/(x^2+y^2))))/(acot(-asin(x/(x+y))/acos(y/(x+y)))-2/atan(1-acos(x/(x+y)))*3+4/asin(y/(x+y)))
//(asin(x/(x+y))*3-acos(-x/(x+y)))/(-asin(-y/(x+y))+2/acos(x/(x+y)))+(-asin(y/(x+y))*4-2/acos(-y/(x+y)))/(1-asin(-x/(x+y))-5/acos(y/(x+y)))
//(-exp(x/y)/exp(y/x))*(sinh(t/y)*0.5-(cosh(x/t)*2.5-5.3))*(-1/tanh(-y/x)-cotanh(-x/y))+(sinh(x/y)/(-cosh(y/x)*2)+exp(x/t)*exp(-x/y)/(exp(t/y)-2/exp(-y/x))+(-1/sinh(x/y)-cosh(x/y)*sinh(y/x)/(cotanh(-y/x)-tanh(-x/y)))/(cosh(-x/y)+sinh(-y/x)+tanh(x/y)*cotanh(y/x)))
//sh(x)/(-exp(x))+ch(x)/(-sh(x))
 //sh(x)/(-exp(x))+ch(x)/(sh(x))-exp(x)/ch(x)-sh(x)*ch(x)/exp(x)
 //sh(x)^(-1)/(-exp(x)^(-2))+ch(x)^(-2)/(sh(x)^(-1))-exp(x)^(-1)/ch(x)^(-2)-sh(x)*ch(x)/exp(x)
 //sh(x)^(-n)/(-exp(x)^(-k))+ch(x)^(-k)/(sh(x)^(-n))-exp(x)^(-n)/ch(x)^(-k)-sh(x)*ch(x)/exp(x)
 //sinh(x)*(exp(x)^(-1)+cosh(x))-tanh(x)^(-1)/(-cotanh(x)^(-1)/exp(x)-cosh(x)^(-1))+tanh(x)/exp(x)^(-1)
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1))))/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1)+sinh(exp(x-1))))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1))+sinh(exp(x-1)))-1/exp(x-1)-exp(x-1)^2-1/exp(x+1)^(-1)*(-tanh(x+1)^(k+1)-1/cosh(x+1)^(k+1)-1/sinh(exp(x-1)^2))-(sinh(exp(x-1))-1/cosh(exp(x-1))^2)


 //sin(x/cos(x*sin(x)))/cos(x/cos(x*cos(-x)))-sin(x/sin(x*sin(-x)))/cos(x/sin(x*cos(x)))/(sin(x/cos(x*sin(x)))/cos(x/cos(x*sin(x)))-sin(x/cos(x*sin(-x)))/cos(x/sin(x*sin(x))))
 //sin(x)*cos(x)+sin(x+1)/sin(x)+cos(x+1)*cos(x)
 //(sin(x)+cos(x)*x+(sin((cos(x+2)+x*sin(x+2)+x/(sin(x)+cos(x)+cos(x+2))-sin(x+2))*sin(2*cos(x+1)+1))+cos(x+1)+(cos((sin(cos(x+1))+2*cos(2*sin(x+1)+1)+sin(2*cos(x+1)+1))))))
 //1/sin(x)-(-cos(x)-sin(x)^(-1))/cos(x)^(-1)-cos(2*sin(x)^(-1))*sin(2*sin(x)^(-1))/(cos(2*sin(x)^(-1))-sin(2*sin(x)^(-1)))
 //sin(x)^(-1)-cos(x)^(-1)-(cos(sin(x)^(-1))^(-1)-sin(sin(x)^(-1))^(-1))-(sin(sin(x)^(-1))^(-1)-2*sin(sin(x)^(-1)))
 //(sin(cos(sin(x)))+cos(sin(x)))/(sin(cos(sin(x)))-cos(sin(x))-sin(cos(x)))-cos(x)*cos(sin(cos(x)))-sin(x)/(cos(sin(cos(x)))+cos(x))
 //x/sin(2*cos(2*x)+1)-cos(x+1)*cos(2*x)-sin(2*x)/(cos(sin(2*x))-sin(x+1)*sin(2*cos(x)+1))-cos(sin(2*x))*sin(2*cos(2*x)+1)
 //1/tan(x)-(-cotan(x)-sin(x)*(tan(x)^(-1)-1/cos(x)^2))-(cos(x)-x*(-cotan(x)^(-1)-sin(x))/tan(x)^(-1))
 //arcsin(x/5)^x-1/arccos(x/5)-(-arcsin(x/5)-arccos(x/5)^x)/(arcsin(x/5)^x+arccos(x/5)^x)


 //sin(x/cos(x*sin(x)))/cos(x/cos(x*cos(-x)))-sin(x/sin(x*sin(-x)))/cos(x/sin(x*cos(x)))/(sin(x/cos(x*sin(x)))/cos(x/cos(x*sin(x)))-sin(x/cos(x*sin(-x)))/cos(x/sin(x*sin(x))))
 //sin(x)*cos(x)+sin(x+1)/sin(x)+cos(x+1)*cos(x)
 //(sin(x)+cos(x)*x+(sin((cos(x+2)+x*sin(x+2)+x/(sin(x)+cos(x)+cos(x+2))-sin(x+2))*sin(2*cos(x+1)+1))+cos(x+1)+(cos((sin(cos(x+1))+2*cos(2*sin(x+1)+1)+sin(2*cos(x+1)+1))))))
 //1/sin(x)-(-cos(x)-sin(x)^(-1))/cos(x)^(-1)-cos(2*sin(x)^(-1))*sin(2*sin(x)^(-1))/(cos(2*sin(x)^(-1))-sin(2*sin(x)^(-1)))
 //sin(x)^(-1)-cos(x)^(-1)-(cos(sin(x)^(-1))^(-1)-sin(sin(x)^(-1))^(-1))-(sin(sin(x)^(-1))^(-1)-2*sin(sin(x)^(-1)))
 //(sin(cos(sin(x)))+cos(sin(x)))/(sin(cos(sin(x)))-cos(sin(x))-sin(cos(x)))-cos(x)*cos(sin(cos(x)))-sin(x)/(cos(sin(cos(x)))+cos(x))
 //x/sin(2*cos(2*x)+1)-cos(x+1)*cos(2*x)-sin(2*x)/(cos(sin(2*x))-sin(x+1)*sin(2*cos(x)+1))-cos(sin(2*x))*sin(2*cos(2*x)+1)
 //1/tan(x)-(-cotan(x)-sin(x)*(tan(x)^(-1)-1/cos(x)^2))-(cos(x)-x*(-cotan(x)^(-1)-sin(x))/tan(x)^(-1))
 //arcsin(x/5)^x-1/arccos(x/5)-(-arcsin(x/5)-arccos(x/5)^x)/(arcsin(x/5)^x+arccos(x/5)^x)
//asin(cos(asin(cos(atan(x/y)))))*acos(sin(x/asin(cos(y/acos(x/y)))))
//atan(x/asin(cos(y/atan(acos(x/y)))))/acot(x/acos(sin(y/acot(asin(x/y)))))
//(atan(cot(x/(y+x)))+acot(tan(y/(y+x))))/(asin(cos(x/(y+x)))+acos(sin(y/(y+x))))
//(asin(cos(asin(x/(y+x))))+acos(sin(acos(y/(y+x)))))/(sin(atan(cot(x/(y+x))))-cos(acot(tan(y/(y+x)))))
//sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)
 //(-sin(x)^(-1))-cos(x)^(-2)/sin(x)^(-3)+sin(x)^(-1)-cos(x)-(-sin(x)-cos(x)^(-2))/sin(x)^(-3)
 //(-arcctg(x)^(-1))-arctg(x)^(-2)/arcctg(x)^(-3)+arcctg(x)^(-1)-arctg(x)-(-arcctg(x)-arctg(x)^(-2))/arcctg(x)^(-3)
 //(-arctg(x)^(-1))-arcctg(x)^(-2)/arctg(x)^(-3)+arctg(x)^(-1)-arcctg(x)-(-arctg(x)-arcctg(x)^(-2))/arctg(x)^(-3)
 //(arcsin(x/y)-arccos(x/y))*(arcsin(t/y)+arccos(t/x))/(arcsin(x/(y+t))-arccos(x/(y-t)))+(arccos(x/(y+t))-arcsin(x/(y-t)))/(arccos(t/y)-arcsin(t/x))
 //(arcsin(x/(y+x))-arccos(x/(y+x)))*(arcsin(t/(y+t))+arccos(t/(x+t)))/(arcsin(x/(y+t))-arccos(x/(y+t)))+(arccos(x/(y+t))-arcsin(x/(y+t)))/(arccos(t/(y+t))-arcsin(t/(x+t)))
 //Res:= 1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9)
  //Res:=2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
  //Res:=2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
  //Res:=-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1)
  //Res:=x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
  //Res:=x*t-cosh(t)*(tanh(x*t-cosh(t)*(tanh(x*t-cosh(t)*(tanh(y*x-power(x,y)))))))
  //Res:=exp(exp(x*y-8)/2-1)/tanh(exp(x*y-8)/2-1)-exp(x*y-8)*tanh(x*y-8)*cosh(x*y-8)/sinh(exp(x*y-8)/2-1)
 //sin(x+1)^(-1)*(2*x*y*t+2)^(-1)+(2*cos(x+1)+1)^(-1)*(2*x*y*t+2)^(-1)-(2*cos(x+1)+1)^(-1)
    //|y-|x-1|+t-|3-t|-x|-|2*t+1|*|x-t*|y+2|-y|
    //(-1)^(2*k+1)*2^(k+1)*(2*i+1)!*k!/(y^(2*k+1)*i!)
    ////-(-x/vd[k]*ve[j]-(-vd[k+1]/ve[k+2]^3-vd[5]^2))
    //-(-vd[-[-x^2]]*ve[2*[x*2]-k]^k)
    //-(-x/vd[1]*ve[1]-(-vd[1+1]/ve[1+2]^3-vd[5]^2))
    //vd[[t+1]]
    //vd[[t]]
    //-(-(-vd[n]))-(-ve[3]-3)-(-3-(1-vd[4]))-vd[5]
    //-(-vd[n])-(sin(-vd[n+1]^2)-ve[5*n-k]^k-vd[k]^(-3)-vd[k]/ve[n]-2)^2+vd[k]!





//(asin(x/(x+y))+acos(y/(x+y)))*(1/acos(x/(x+y))+1/asin(y/(x+y)))+(asin(x/(x+y))+acos(y/(x+y)))/(acos(x/(x+y))+asin(y/(x+y)))
 //sinh(x)/(-exp(x))+cosh(x)/(sinh(x))-exp(x)/cosh(x)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-n)/(-exp(x)^(-k))+cosh(x)^(-k)/(sinh(x)^(-n))-exp(x)^(-n)/cosh(x)^(-k)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)*(exp(x)^(-1)+cosh(x))-tanh(x)^(-1)/(-cotanh(x)^(-1)/exp(x)-cosh(x)^(-1))+tanh(x)/exp(x)^(-1)
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1))))/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1)+sinh(exp(x-1))))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1))+sinh(exp(x-1)))-1/exp(x-1)-exp(x-1)^2-1/exp(x+1)^(-1)*(-tanh(x+1)^(k+1)-1/cosh(x+1)^(k+1)-1/sinh(exp(x-1)^2))-(sinh(exp(x-1))-1/cosh(exp(x-1))^2)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //tanh(x)-exp(x)/(cosh(x)+exp(x)*tanh(x))+sinh(x)/(cotanh(x)-tanh(x))-exp(x)*(cosh(x)+tanh(x)+cotanh(x)+sinh(x)+exp(x))
 //sinh(x)+exp(x)*sinh(x)^2-cosh(x)/(cosh(x)^2+tanh(x))-exp(x)^2*sinh(x)^2
 //sinh(x)+cosh(x)+cosh(x)^t-sinh(x)/(cosh(x)^t+exp(x))
 //exp(x)*sinh(x)-cosh(x)/(exp(x)+sinh(x)-cotanh(x))
 ////sh(x)/(-exp(x))+ch(x)/(-sh(x))
 //sinh(x)/(-exp(x))+cosh(x)/(-sinh(x))   !!!
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(-sinh(x)^(-1))
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)
//sinh(x)/(-exp(x))+cosh(x)/(-sinh(x))-(-(-sinh(x)/(-1/cosh(x)-1/(-(-1/exp(x))))))
//sinh(x)/(-exp(-x))+cosh(x)/(-sinh(-x))-(-(-sinh(x)/(-1/cosh(-x)-1/(-(-1/exp(x)-exp(-x))))))+(-1-(-sinh(-exp(x))-x/cosh(exp(-x))*(-x)-1/(-sinh(cosh(-x)))))
//sinh(x)/(-exp(-x))+cosh(x)/(-sinh(-x))-(-(-sinh(x)/(-1/cosh(-x)-1/(-(-1/exp(x)-exp(-x))))))+(-1-(-sinh(-exp(x))-x/cosh(exp(-x))*(-x)-1/(-sinh(cosh(-x)))))+tanh(-x)/(-cotanh(x))+sinh(-exp(x))/cosh(-exp(x))/sinh(exp(-x))
//sinh(x)/(-exp(-x))+cosh(x)/(-sinh(-x))-(-(-sinh(x)/(-1/cosh(-x)-1/(-(-1/exp(x)-exp(-x))))))+(-1-(-sinh(-exp(x))-x/cosh(exp(-x))*(-x)-1/(-sinh(cosh(-x)))))+tanh(-x)/(-cotanh(x))+sinh(-exp(x))/cosh(-exp(x))/sinh(exp(-x))/(-(-(-tanh(-exp(-x))-1/cotanh(-exp(-x)))))
//sinh(1-x)+tanh(x+1)/exp(x-1)-sinh(x-1)/cosh(x+1)+tanh(x-1)-exp(x-1)/(cosh(tanh(x+1)/sinh(x-1)))*tanh(sinh(tanh(3-x)))+cosh(sinh(x-1))/sinh(cosh(1-x))+tanh(exp(1-x))/sinh(tanh(3-x))+cosh(tanh(3-x))/exp(3-x)-sinh(exp(3-x))*cosh(3-x)*sinh(1-x)+cosh(sinh(exp(3-x)))/sinh(tanh(1+x))+sinh(cosh(1+x))/tanh(exp(1-x))
//(-2/asin(x/(x+y))+1)*(-acos(y/(x+y))*2+1)-(-atan(x^2/(x^2+y^2))*3+4/acos(x/(x+y))*(3*asin(y/(x+y))-acot(y^2/(x^2+y^2))))/(acot(-asin(x/(x+y))/acos(y/(x+y)))-2/atan(1-acos(x/(x+y)))*3+4/asin(y/(x+y)))
//(asin(x/(x+y))*3-acos(-x/(x+y)))/(-asin(-y/(x+y))+2/acos(x/(x+y)))+(-asin(y/(x+y))*4-2/acos(-y/(x+y)))/(1-asin(-x/(x+y))-5/acos(y/(x+y)))
//(-exp(x/y)/exp(y/x))*(sinh(t/y)*0.5-(cosh(x/t)*2.5-5.3))*(-1/tanh(-y/x)-cotanh(-x/y))+(sinh(x/y)/(-cosh(y/x)*2)+exp(x/t)*exp(-x/y)/(exp(t/y)-2/exp(-y/x))+(-1/sinh(x/y)-cosh(x/y)*sinh(y/x)/(cotanh(-y/x)-tanh(-x/y)))/(cosh(-x/y)+sinh(-y/x)+tanh(x/y)*cotanh(y/x)))




//(cosh(-x-a)*sinh(-a-x)-cosh(x*y-a)/(a-sinh(-a+x*y))+x*(y*sinh(x-y)-x*cosh(-y+x)-sinh(-x/y)*cosh(-y/x)))*(sinh(-x/cosh(x-y))*cosh(y/sinh(x*y-a))+cosh(x/sinh(-y/x))*sinh(-y/cosh(-x/y))+cosh(sinh(x/y)*cosh(y/x)))*(sinh(y/sinh(x*y-a))/(x-cosh(-x/cosh(x-y)))+x*sinh(x/cosh(sinh(y/sinh(x*y-a))))/(x-sinh(cosh(sinh(x/y)*cosh(y/x)))-cosh(sinh(-x/y)*cosh(-y/x))))
//cosh(-(-x/sinh(-y/x)))*sinh(-cosh(-x/y)/(-x))*(sinh(-x*y/(x-y))-cosh(-x/(-1/sinh(-y/x)))-sinh(-1-x/cosh(-x/y)))*(sinh(-y/(x+y))+tan(-x/cosh(-x/(x+y)))*cotan(-y/sinh(-y/(x+y))))
//-cosh(-x/(x+y))*(-x-(-sinh(-x/(x+y))/(-cosh(-y/(x+y)))))*(-cosh(-x/sinh(-x/(x+y)))-sinh(sinh(x/sinh((x+y)/x)-y/cosh((x+y/y)))/cosh(-x/(x+y))))*(x/sinh((x+y)/x)-y/cosh((x+y/y))-sinh(x/cosh(-y/(x-y))-y/sinh(-x/(y-x))))*(cosh(y/cosh(-y/(x-y))-x/sinh(-x/(y-x))))*((-y/(y-x))*(-x/(y-x))/sinh(x/cosh(-x/(y-x))-y/sinh(-x/(x-y)))-x/cosh(-x/sinh(y/sinh(-x/(x-y))-x/cosh(-x/(y-x))))-y/sinh(-y/cosh(-x/sinh(x/(x-y)-y/cosh(y/(y-x))))))
//(x/(x-y)-y/(y-x)-t/(x-t))*(x/sinh(y/(y-x))-y/cosh(-y/(y-x))-t/(sinh(-x/cosh(x/(x-y)))*(-x)+cosh(-x/cosh(x/(x-y)))-(-t*x)/cosh(-y/sinh(-t/(x-t)))))*(sinh(sinh(-x/cosh(x/(x-y)))-cosh(-y/sinh(x/(x-y))))*(-x/sinh(-y/cosh(x/(x-y)))-t/sinh(-y/sinh(x/(x-y)))))
//(exp(-x/y)/(sinh(x/y)-cosh(y/x))+sinh(-exp(x/y))/(exp(-cosh(x/y))+exp(y/x)))*(tanh(y/x)/(coth(-x/y)+coth(y/x)+coth(-y/x)))*((sinh(-y/x)+cosh(-coth(y/x)))/(tanh(cosh(-exp(x/y)))-coth(-exp(-x/y)))+cosh(cosh(x/y))/(tanh(exp(cosh(x/y)))-coth(sinh(-exp(x/y)))))*(tanh(sinh(-exp(x/y)))/(coth(exp(cosh(x/y)))-sinh(-exp(-x/y))/cosh(cosh(-exp(x/y)))))


//(-2/asin(x/(x+y))+1)*(-acos(y/(x+y))*2+1)-(-atan(x^2/(x^2+y^2))*3+4/acos(x/(x+y))*(3*asin(y/(x+y))-acot(y^2/(x^2+y^2))))/(acot(-asin(x/(x+y))/acos(y/(x+y)))-2/atan(1-acos(x/(x+y)))*3+4/asin(y/(x+y)))
//(-2/asin(z1/(z1+z2))+1)*(-acos(z2/(z1+z2))*2+1)-(-atan(z1^2/(z1^2+z2^2))*3+4/acos(z1/(z1+z2))*(3*asin(z2/(z1+z2))-acot(z2^2/(z1^2+z2^2))))/(acot(-asin(z1/(z1+z2))/acos(z2/(z1+z2)))-2/atan(1-acos(z1/(z1+z2)))*3+4/asin(z2/(z1+z2)))


// ((x^(x/(y-x))*y^(2*k+1)-(1/x)^(1/y)*(x/(y-x))^(y/(y-x)))*((x/y)^(2*k+1)*(y/x)^(2*n+1)-(x/(y-x))^(2*k+3*n-4)/((1/y)^(2*k+1)+(1/x)^(2*k+2)))+(y^(2*k+2)*x^(2*j-2)-(1/x)^(n+k+1)*(1/y)^(n+k+2))*((x/(y-x))^(n+k)-(y/(y-x))^(n+j-1)))/((1/x)^(n+k)*(1/y)^(n+k)-(x/(y-x))^(2*k+3*n-2)*y^(2*k)/x^(2*j-3))

//(root(z1/z2,n+k)/(root(z2/z1,n+k+1))+root(z1,x+1)/root(z2,y+1))*(root(x,n+k)/root(y,n+k+1)*root(z1,x)/root(z2+1,y)-(z1/z2)^x/y^(z2/z1))/((z1/z2)^(n+k)*(z1/z2)^(x-1)-y^(z2/z1-1)/root(z2/z1,n+k-1)+root(z2,y)/root(z1,x-1))

//(cosh(-x-a)*sinh(-a-x)-cosh(x*y-a)/(a-sinh(-a+x*y))+x*(y*sinh(x-y)-x*cosh(-y+x)-sinh(-x/y)*cosh(-y/x)))*(sinh(-x/cosh(x-y))*cosh(y/sinh(x*y-a))+cosh(x/sinh(-y/x))*sinh(-y/cosh(-x/y))+cosh(sinh(x/y)*cosh(y/x)))*(sinh(y/sinh(x*y-a))/(x-cosh(-x/cosh(x-y)))+x*sinh(x/cosh(sinh(y/sinh(x*y-a))))/(x-sinh(cosh(sinh(x/y)*cosh(y/x)))-cosh(sinh(-x/y)*cosh(-y/x))))
//cosh(-(-x/sinh(-y/x)))*sinh(-cosh(-x/y)/(-x))*(sinh(-x*y/(x-y))-cosh(-x/(-1/sinh(-y/x)))-sinh(-1-x/cosh(-x/y)))*(sinh(-y/(x+y))+tan(-x/cosh(-x/(x+y)))*cotan(-y/sinh(-y/(x+y))))
//-cosh(-x/(x+y))*(-x-(-sinh(-x/(x+y))/(-cosh(-y/(x+y)))))*(-cosh(-x/sinh(-x/(x+y)))-sinh(sinh(x/sinh((x+y)/x)-y/cosh((x+y/y)))/cosh(-x/(x+y))))*(x/sinh((x+y)/x)-y/cosh((x+y/y))-sinh(x/cosh(-y/(x-y))-y/sinh(-x/(y-x))))*(cosh(y/cosh(-y/(x-y))-x/sinh(-x/(y-x))))*((-y/(y-x))*(-x/(y-x))/sinh(x/cosh(-x/(y-x))-y/sinh(-x/(x-y)))-x/cosh(-x/sinh(y/sinh(-x/(x-y))-x/cosh(-x/(y-x))))-y/sinh(-y/cosh(-x/sinh(x/(x-y)-y/cosh(y/(y-x))))))
//(x/(x-y)-y/(y-x)-t/(x-t))*(x/sinh(y/(y-x))-y/cosh(-y/(y-x))-t/(sinh(-x/cosh(x/(x-y)))*(-x)+cosh(-x/cosh(x/(x-y)))-(-t*x)/cosh(-y/sinh(-t/(x-t)))))*(sinh(sinh(-x/cosh(x/(x-y)))-cosh(-y/sinh(x/(x-y))))*(-x/sinh(-y/cosh(x/(x-y)))-t/sinh(-y/sinh(x/(x-y)))))
//(exp(-x/y)/(sinh(x/y)-cosh(y/x))+sinh(-exp(x/y))/(exp(-cosh(x/y))+exp(y/x)))*(tanh(y/x)/(coth(-x/y)+coth(y/x)+coth(-y/x)))*((sinh(-y/x)+cosh(-coth(y/x)))/(tanh(cosh(-exp(x/y)))-coth(-exp(-x/y)))+cosh(cosh(x/y))/(tanh(exp(cosh(x/y)))-coth(sinh(-exp(x/y)))))*(tanh(sinh(-exp(x/y)))/(coth(exp(cosh(x/y)))-sinh(-exp(-x/y))/cosh(cosh(-exp(x/y)))))


//(1-2*if(x<y,sin(x)))/(3*if(x<y,cos(x))+1)+if(x<y,cos(x))/if(x<y,sin(x))/if(x<y,cos(x))-(4*if(x<y,sin(x))-3)/(5*if(x<y,cos(x))+4)

//poly(1,2,3,x*y)   (diff(x)=1,(y)=2)    ERROR!!!!!
//poly(1,2,3,4,5,x/y)
//poly(-2,3,4,-5,6,-7,x/y)
//-2*(x/y)^5+3*(x/y)^4+4*(x/y)^3-5*(x/y)^2+6*(x/y)-7


//x*(-(x*y+x))-2/(-3*x-y-t/x-(-sin(x/(-(x*y+x))-(-t-1)+1)-t)/x)-(-(-1-t)/x*2+3*x/y/t-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9) {!!! (8)}
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))


//sin(x)+(-(-x*y))
//sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//-(-(-sin(x)-(-cos(x)*(-x-(-(-a)/sin(x)*x-(-(-cos(x)/x)/sin(x)*(-x)-sin(x)*(-x)*(-(-a))*(-x/cos(x)-sin(x)/(-y-(-a/x)))))))))
//-(-(-sin(x)/x-cos(x)*a/x-(-a/sin(x)*cos(x))-(-(sin(x)-(-a*(-x/sin(x)-(-cos(x)/x)))))-(-(-(-sin(x)*(-cos(x)/x)*x*b*(-b*x)/x/(-sin(x)))))*x/sin(x)/(-a)))
//2/(-3*x-y-t/x-(-sin(x/y-(-x-1)+1)-y)/t)-(-(-1-x)/y*2+3*x/y/t-cos(-(-x-y)/(-(-x+y*2)-x)-1)/(x+y*t/3)*x)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1)
//2/(-k)/(-3*(-k)-i*(-i)/(-(-t))-t/k-(-1/(-sin(k/i-(-t-1)+1)-t)/k)+i*(-(-t)))-(-(-1-t)/k*2+3*k/(-i)/(-(-(-t)-2-k)-i)-cos(-(-k-i)/(-(-t+k*2)-k)-1)/(k+i*t/3)*k)-sin(-t-(-k-(1-i)-3-(-k*2))/k/(-i/(-k)-k)-1)

//-(-x)-(-x/(-x-1-y)-t)*(-(-(-x-1)-y-y-1)/(-y)*t/(-y)-y)*(-(-sin(x)-1-x)-y*x/(-y)/(-y)-(-(1-cos(x)-x)-y)/sin(x)+(-(-x*x-y-y+1)-sin(y)/(-t-(-x)-1)*y)*y+(x-(-sin(x)-1-y)-t/(-t*x/(-y)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*x-y-t/x-(-sin(x/(-(x*y+x))-(-t-1)+1)-t)/x)-(-(-1-t)/x*2+3*x/y/t-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9) {!!! (8)}
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))  {!!!}
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))
// 2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*t^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+1)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tg(x)-(-1/x-4+1/t-sin(y))))

//2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*(t+5.1)^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+15.3)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))


//2/sp2(x-cos(y)*sin(-y*sp2(x*t,cos(y*sp2(2-x/t,t)/x*sp2(2-x,3*sin(x))/(2+x)))),y/sp2(x*cos(y),cos(y)*sp2(cos(y),sin(x))))
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1))))))-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))


//sin(x)-(-(sh(x)+cos(x)))

//-(-1/a*b-c/x*(1-d)*(-a)-b/c/d/(x-c/(-d)*(-x*2)*(-y*(-2)/(-c)/d/x)-x/2/a))*(-2/a/x*y*3*d*(d+c)*(x+a)*(y+(-a))*(a+1)*(2/d-c))+a/c*d*2/3*x*(-2)*(-a)*(-a-b)*(-x)/(-x-a*x*y*(x/(x*a-y*b-c)*2/c-c/(-d-1)))
//2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
//-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//(2*x-(-x/(-y-1)-y)-(-(-1-y))-y/(-x-y-2*(-x/y-3)))*(-(-1-x-(-(-x-(-1-2/y))/(x*y-2/x*(2+x)*(2*x+3*y-4)*y/(2*x+3*y+4))-x/(x+3*y-4))*x*y)*(2*x+1)*(3*y+2)*y*x)-(-2/x)*x*y*(2*x+y-1)*(-y/(-x/y-(-y/(-x/y-1))*(x*y*2-1))-x)
//sin(-a/b-1)*(c+1)^(1+d)-tan(c*(-d)^(2+c))-(2*a+3)^(b+1)-(-a+1/sin(b^(-c)+3^(-d)-d^(-5)))


//x^y*sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//sin(x)+(-(x/y))


//spl1(x/y)*spl2(y/x)*(spl1(x/y)+spl2(y/x)*(spl1(x/y)-spl2(y/x))/(spl1(spl1(x/y)*spl2(y/x))*spl2(spl1(x/y)*spl2(y/x))))
//spl1(x/y)*spl2(y/x)*(spl1(x/y)+spl2(y/x))*(spl1(x/y)-spl2(y/x))/(spl1(spl1(x/y)*spl2(y/x))+spl2(spl1(x/y)*spl2(y/x)))
//spl1(x/y)*spl2(y/x)*(spl1(x/y+y/x)-spl2(x/y-y/x))*(spl1(y/x)+spl2(x/y))/(spl1(spl2(y/x-x/y))+spl2(spl1(x/y-y/x)))

//ps3(x,x/ps2(x/y,y/x),x*ps1(x/y)-ps1(y/x)/(ps1(-y/x)))*ps2(x/y,-y/x)*ps1(x/y)*ps2(ps1(y/x)*(ps1(-y/x)+ps1(-x/y)),x*ps2(ps1(y/x)/y,x/ps1(-x/y))+x/ps1(-ps1(-y/x)))+x*ps2(-x/y,y/x)/(x*ps2(x/y,y/x)+2*ps1(-x/y)*ps3(x,x/ps2(-x/y,y/x),x/y))+x/(-ps1(-y/x)*ps2(ps1(x/y),-ps1(-y/x)*x))
//ps3(x,x/ps2(x/y,y/x),x*ps1(x/y)-ps1(y/x)/(ps1(-y/x)))*ps2(x/y,-y/x)*ps1(x/y)*ps2(ps1(y/x)*(ps1(-y/x)+ps1(-x/y)),x*ps2(ps1(y/x)/y,x/ps1(-x/y))+x/ps1(-ps1(-y/x)))+x*ps2(-x/y,y/x)/(x*ps2(x/y,y/x)+2*ps1(-x/y)*ps3(x,x/ps2(-x/y,y/x),x/y))+x/(-ps1(-y/x)*ps2(ps1(x/y),-ps1(-y/x)*x))+ps3(x,x/ps2(x/y,y/x),x*ps1(x/y)-ps1(y/x)/(ps1(-y/x)))*ps2(x/y,-y/x)*ps1(x/y)*ps2(ps1(y/x)*(ps1(-y/x)+ps1(-x/y)),x*ps2(ps1(y/x)/y,x/ps1(-x/y))+x/ps1(-ps1(-y/x)))+x*ps2(-x/y,y/x)/(x*ps2(x/y,y/x)+2*ps1(-x/y)*ps3(x,x/ps2(-x/y,y/x),x/y))+x/(-ps1(-y/x)*ps2(ps1(x/y),-ps1(-y/x)*x))


 //const func
// sp2(a/b+c,c+b/sp1(a*(b-c)+d))*x-c/sp1(a-b/c)


  //  sin(x)*if(sin(x+1) < cos(y+1) ,  sin(2*x)*if(cos(x)+cos(x+1) < sin(y)+sin(y+1), sin(x)+sin(x+1)+sin(x+2),cos(x)+cos(y+1)+cos(y+2))+sin(3*x) , cos(2*x)*if(cos(x+1)+cos(2*x) < cos(y+1)+sin(2*x), sin(x+3)+sin(y+3)-sin(2*x), cos(x+3)-cos(y+4)+cos(2*y))+cos(3*x))*sin(y+1)*cos(2*x)+ cos(3*x)*if(sin(x)+cos(y+1)+sin(2*x)+cos(y+5) < cos(y+2)-cos(3*x)+sin(x+1)+sin(x+3), if(sin(y+5)+cos(x+4)< sin(y+4)-cos(x+5),sin(4*x)+sin(x+2),cos(4*y)+cos(y+3))+cos(5*y)*sin(4*y) ,  sin(5*y)*sin(y+3)*if(cos(x+6)+cos(4*y)<cos(y+3)+cos(2*x),sin(3*x)+cos(7+y),cos(y+1)-sin(4*x))+cos(y+3)*sin(4*y) )

  {

    s:ext=0; upx:int=120; upy:int=100; x=0; y=0;  for(k=0, upx, for(n=0, upy, s=s+sin(x+y); y=y-0.15); x=x+0.1); s

   s:ext=0; upx:int=100; upy:int=120; x=0; y=0;  for(k=0, upx, for(n=0, upy, s=s+ sin(x)*if(sin(x+1) < cos(y+1) ,  sin(2*x)*if(cos(x)+cos(x+1) < sin(y)+sin(y+1), sin(x)+sin(x+1)+sin(x+2),cos(x)+cos(y+1)+cos(y+2))+sin(3*x) , cos(2*x)*if(cos(x+1)+cos(2*x) < cos(y+1)+sin(2*x), sin(x+3)+sin(y+3)-sin(2*x), cos(x+3)-cos(y+4)+cos(2*y))+cos(3*x))*sin(y+1)*cos(2*x)+ cos(3*x)*if(sin(x)+cos(y+1)+sin(2*x)+cos(y+5) < cos(y+2)-cos(3*x)+sin(x+1)+sin(x+3), if(sin(y+5)+cos(x+4)< sin(y+4)-cos(x+5),sin(4*x)+sin(x+2),cos(4*y)+cos(y+3))+cos(5*y)*sin(4*y) ,  sin(5*y)*sin(y+3)*if(cos(x+6)+cos(4*y)<cos(y+3)+cos(2*x),sin(3*x)+cos(7+y),cos(y+1)-sin(4*x))+cos(y+3)*sin(4*y) ); y=y-0.15); x=x+0.1); s


   }
  
//******************************{ IF } ******************************************
(*

  s:dbl=0; x=-150;  ckl>>if(x>450,goto(end)); s=s+if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,cos(x),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and
  (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,cos(x),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or
  (sin(x) > cos(x*y)) ,cos(x),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,cos(x),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and
  ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,cos(x),sin(x))),sin(x))),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,cos(x),sin(x))))),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or
   (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,cos(x),sin(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,cos(x),sin(x))),sin(x))); x=x+1; goto(ckl); end>>s

*)

//  if(x<y,cos(x)*if(x<y,sin(x)*if(x<y,cos(y)*if(x<y,sin(y)*if(x<y,cos(x+y)*if(x<y,sin(x+y)*if(x<y,cos(x-y)*if(x<y,sin(x-y),y),y),y),y),y),y),y),y)
//  if(x<y,cos(x)*if(x<y,sin(x)*if(x<y,cos(y)*if(x<y,sin(y)*if(x<y,cos(x+y)*if(x<y,sin(x+y)*if(x<y,cos(x-y),y),y),y),y),y),y),y)

//  s:ext=0; upx:int=100; upy:int=120; x=0; y=0;  for(k=0, upx, for(n=0, upy, s=s+ sin(x)*if(sin(x+1) < cos(y+1) ,  sin(2*x)*if(cos(x)+cos(x+1) < sin(y)+sin(y+1), sin(x)+sin(x+1)+sin(x+2),cos(x)+cos(y+1)+cos(y+2))+sin(3*x) , cos(2*x)*if(cos(x+1)+cos(2*x) < cos(y+1)+sin(2*x), sin(x+3)+sin(y+3)-sin(2*x), cos(x+3)-cos(y+4)+cos(2*y))+cos(3*x))*sin(y+1)*cos(2*x)+ cos(3*x)*if(sin(x)+cos(y+1)+sin(2*x)+cos(y+5) < cos(y+2)-cos(3*x)+sin(x+1)+sin(x+3), if(sin(y+5)+cos(x+4)< sin(y+4)-cos(x+5),sin(4*x)+sin(x+2),cos(4*y)+cos(y+3))+cos(5*y)*sin(4*y) ,  sin(5*y)*sin(y+3)*if(cos(x+6)+cos(4*y)<cos(y+3)+cos(2*x),sin(3*x)+cos(7+y),cos(y+1)-sin(4*x))+cos(y+3)*sin(4*y) ); y=y-0.15); x=x+0.1); s

{

  k=5; s=0; for(n,1,k,x=n; for(j,1,k,y=j;s=s+if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or
  ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x))))+if((sin(x*y)*cos(x+y) > sin(cos(y)*x))  or ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))*if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y)))
   ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))));s
}

{
  if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or
  ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <=
  cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),
  if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x))))+if((sin(x*y)*cos(x+y) > sin(cos(y)*x))  or ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y))) ,if( ((sin(x+y)*cos(x-y) >
  sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and
  ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))*if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) >
  sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))
}


{
 s:dbl=0; x=-150;  ckl>>if(x>450,goto(end)); s=s+if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or
 ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <=
 cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),
 if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x))))+if((sin(x*y)*cos(x+y) > sin(cos(y)*x))  or ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y))) ,if( ((sin(x+y)*cos(x-y) >
 sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and
 ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))*if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) >
 sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x))) ;x=x+1;  goto(ckl); end>>s

 }


{
 s:ext=0; x=-150;  ckl>>if(x>150,goto(end)); s=s+if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or
 ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <=
 cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),
 if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x))))+if((sin(x*y)*cos(x+y) > sin(cos(y)*x))  or ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y))) ,if( ((sin(x+y)*cos(x-y) >
 sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and
 ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))*if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) >
 sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x))) ;x=x+0.1; y=y-0.1; goto(ckl); end>>s

 }



 // s=0; for(n=1,1000,x=n*0.1; s=s+cos(x)*if(cos(x) > sin(x),sin(2*x+1)*cos(2*x+2)*sin(x), cos(x)*sin(3*x+1)*cos(3*x+2) )+ sin(x)*sin(2*x+1)*cos(2*x+2)*sin(3*x+1)*cos(3*x+2));s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+cos(x)*if( cos(x)*cos(x+1)>sin(x)*sin(x+1) , sin(2*x+1)*sin(x)*sin(x+1) , cos(2*x+1)*cos(x)*cos(x+1) ) +cos(x)*cos(x+1)*sin(2*x+1));s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+ if(sin(x) > cos(x), sin(x), cos(x)) + if(sin(2*x)*cos(x) > sin(x)*cos(2*x), sin(x)*sin(2*x), cos(2*x)*cos(x))) ; s

 //   s=0; for(n=1,1000,x=n*0.1; s=s+ if(sin(x)*sin(2*x) > cos(x)*cos(2*x)   ,  if( cos(4*x)*cos(3*x)*cos(x) > sin(3*x)*sin(x)*sin(2*x), cos(x)-sin(2*x)*cos(3*x), cos(3*x)*sin(2*x)-sin(x))+cos(x)*cos(3*x)  ,if(sin(2*x)*cos(3*x)>sin(3*x)*cos(x),sin(3*x)+sin(2*x),sin(3*x)+cos(3*x))));s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+cos(x)*if(cos(x) > sin(x+1),sin(x+2),cos(x+3))*sin(x)+sin(x+2)*if(cos(x)*sin(2*x) < sin(x+1)*cos(3*x),sin(x)*cos(x+2)*sin(x+5),cos(x+1)*sin(x+3)*cos(x+4))+sin(x+3)*sin(x+5)*sin(x));s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+cos(x)*if(cos(x) > sin(x+1),sin(2*x+1)+sin(x),cos(3*x+2)+sin(2*x+1))+sin(x+1)*sin(2*x+1)+sin(3*x+1)*cos(x+2)+if(cos(x+1)*sin(x+2)>sin(x)*cos(2*x+1),cos(3*x+1)*sin(x+2),cos(x+1)*sin(3*x+2))); s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+cos(x)*if( cos(x)*cos(x+1)>sin(x)*sin(x+1) , sin(2*x+1)*sin(x)*sin(x+1) , cos(2*x+1)*cos(x)*cos(x+1) ) +cos(x)*cos(x+1)*sin(2*x+1));s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+cos(2*x+1)*if(cos(3*x+1)*cos(3*x+2) > sin(4*x+1)*sin(4*x+2), sin(2*x+1)* sin(x+1)*if( cos(x+1)*sin(x+2)*sin(3*x+1) > cos(x+3)*cos(x+2)*cos(4*x+1) , cos(x+1)*sin(x+3)*cos(x+4), sin(x+2)*sin(x+4)*cos(x+5))+cos(x+1)*cos(x+2)  ,  sin(2*x+1)*if(sin(4*x+1) > cos(3*x+2), sin(2*x+1)*cos(4*x+2),sin(3*x+1)*cos(x+1))*cos(4*x+1))); s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+cos(2*x+1)*if(   cos(3*x+1)*cos(3*x+2) > sin(4*x+1)*sin(4*x+2),   sin(2*x+1)*if(sin(4*x+1) > cos(3*x+2), sin(2*x+1)*cos(4*x+2),sin(3*x+1)*cos(x+1))*cos(4*x+1) ,    sin(2*x+1)* sin(x+1)*if( cos(x+1)*sin(x+2)*sin(3*x+1) > cos(x+3)*cos(x+2)*cos(4*x+1) , cos(x+1)*sin(x+3)*cos(x+4), sin(x+2)*sin(x+4)*cos(x+5))+cos(x+1)*cos(x+2)     )); s

 //  s=0; for(n=1,1000,x=n*0.1; s=s+cos(x+1)*sin(x+2)*if(cos(x+1)*cos(x+4) > sin(x+3)*sin(x+5),sin(x+1)*sin(x+4),cos(x+3)*cos(x+5))*sin(x+4)*cos(x+3)*cos(x+1)+ sin(2*x+1)*if(sin(x+1)*cos(x+2) < cos(x+1)*cos(x+4), sin(x+3)*sin(x+5) + cos(2*x+1)*sin(x+1) ,cos(x+1)*cos(x+4)+cos(x+5)*sin(x+3))+sin(x+3)*sin(x+5)*sin(x));s




{

x/(x+y)
x/(x-y)
x/(y-x)
-x/(x+y)

y/(x+y)
y/(x-y)
y/(y-x)
-y/(x+y)

x/y
y/x
-x/y
-y/x

}
 {

cos(sin(x/y))
csc(sec(y/x))
cot(csc(-x/y))
cos(csc(-y/x))


sin(x/(x+y))
cos(x/(x-y))
tan(x/(y-x))
cot(y/(x+y))
sec(y/(x-y))
csc(y/(y-x))

sin(csc(-x/(x+y)))
tan(sec(-y/(x+y)))
tan(sec(x/(x+y)))
cot(csc(x/(x-y)))


sin(-sec(csc(x/(x-y))))
cos(tan(-sec(x/(y-x))))
csc(cot(-sin(x/(x-y))))
cot(-cos(-csc(y/(y-x))))
tan(-sin(-cot(y/(x+y))))
sec(tan(-csc(y/(y-x))))
tan(-csc(cos(x/(x-y))))
cot(-cos(sin(x/(x+y))))


 }

{



 sec(tan(-csc(y/(y-x))))*sin(x/(x+y))/sec(y/(x-y))/(sin(-sec(csc(x/(x-y))))*cos(x/(x-y))-cos(tan(-sec(x/(y-x))))*cot(-cos(sin(x/(x+y)))))

 cot(-cos(-csc(y/(y-x))))*tan(sec(-y/(x+y)))*cot(y/(x+y))/(tan(x/(y-x))*tan(-sin(-cot(y/(x+y))))+csc(y/(y-x))*csc(cot(-sin(x/(x-y)))))

 (tan(-csc(cos(x/(x-y))))/sin(csc(-x/(x+y)))+tan(sec(x/(x+y)))/cot(csc(x/(x-y))))/(cot(csc(x/(x-y)))/tan(-csc(cos(x/(x-y))))-sin(csc(-x/(x+y)))/tan(sec(x/(x+y))))







 ((tan(-csc(cos(x/(x-y))))/sin(csc(-x/(x+y)))+tan(sec(x/(x+y)))/cot(csc(x/(x-y))))/(cot(csc(x/(x-y)))/tan(-csc(cos(x/(x-y))))-sin(csc(-x/(x+y)))/tan(sec(x/(x+y)))))/((sec(tan(-csc(y/(y-x))))*sin(x/(x+y))/sec(y/(x-y))/(sin(-sec(csc(x/(x-y))))*cos(x/(x-y))-cos(tan(-sec(x/(y-x))))*cot(-cos(sin(x/(x+y)))))+cot(-cos(-csc(y/(y-x))))*tan(sec(-y/(x+y)))*cot(y/(x+y))/(tan(x/(y-x))*tan(-sin(-cot(y/(x+y))))+csc(y/(y-x))*csc(cot(-sin(x/(x-y)))))))
 ((tan(-csc(cos(z1/(z1-z2))))/sin(csc(-z1/(z1+z2)))+tan(sec(z1/(z1+z2)))/cot(csc(z1/(z1-z2))))/(cot(csc(z1/(z1-z2)))/tan(-csc(cos(z1/(z1-z2))))-sin(csc(-z1/(z1+z2)))/tan(sec(z1/(z1+z2)))))/((sec(tan(-csc(z2/(z2-z1))))*sin(z1/(z1+z2))/sec(z2/(z1-z2))/(sin(-sec(csc(z1/(z1-z2))))*cos(z1/(z1-z2))-cos(tan(-sec(z1/(z2-z1))))*cot(-cos(sin(z1/(z1+z2)))))+cot(-cos(-csc(z2/(z2-z1))))*tan(sec(-z2/(z1+z2)))*cot(z2/(z1+z2))/(tan(z1/(z2-z1))*tan(-sin(-cot(z2/(z1+z2))))+csc(z2/(z2-z1))*csc(cot(-sin(z1/(z1-z2)))))))

 ((tanh(-csch(cosh(x/(x-y))))/sinh(csch(-x/(x+y)))+tanh(sech(x/(x+y)))/coth(csch(x/(x-y))))/(coth(csch(x/(x-y)))/tanh(-csch(cosh(x/(x-y))))-sinh(csch(-x/(x+y)))/tanh(sech(x/(x+y)))))/((sech(tanh(-csch(y/(y-x))))*sinh(x/(x+y))/sech(y/(x-y))/(sinh(-sech(csch(x/(x-y))))*cosh(x/(x-y))-cosh(tanh(-sech(x/(y-x))))*coth(-cosh(sinh(x/(x+y)))))+coth(-cosh(-csch(y/(y-x))))*tanh(sech(-y/(x+y)))*coth(y/(x+y))/(tanh(x/(y-x))*tanh(-sinh(-coth(y/(x+y))))+csch(y/(y-x))*csch(coth(-sinh(x/(x-y)))))))
 ((tanh(-csch(cosh(z1/(z1-z2))))/sinh(csch(-z1/(z1+z2)))+tanh(sech(z1/(z1+z2)))/coth(csch(z1/(z1-z2))))/(coth(csch(z1/(z1-z2)))/tanh(-csch(cosh(z1/(z1-z2))))-sinh(csch(-z1/(z1+z2)))/tanh(sech(z1/(z1+z2)))))/((sech(tanh(-csch(z2/(z2-z1))))*sinh(z1/(z1+z2))/sech(z2/(z1-z2))/(sinh(-sech(csch(z1/(z1-z2))))*cosh(z1/(z1-z2))-cosh(tanh(-sech(z1/(z2-z1))))*coth(-cosh(sinh(z1/(z1+z2)))))+coth(-cosh(-csch(z2/(z2-z1))))*tanh(sech(-z2/(z1+z2)))*coth(z2/(z1+z2))/(tanh(z1/(z2-z1))*tanh(-sinh(-coth(z2/(z1+z2))))+csch(z2/(z2-z1))*csch(coth(-sinh(z1/(z1-z2)))))))



}
//sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))+sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)*(exp(y*x-1))))))
//x*t-x^t*(x^(x*t-x^t*(x^(x*t-x^t*(x^t)))))
//x*t-x^(-1)*(x^(x*t-x^(-2)*(x^(x*t-x^(-3)*(x^(-4))))))
//x*t-x^7*((x*t-x^7*((x*t-x^7*(x^7))^7))^7)
//x*t-x^5*((x*t-x^5*((x*t-x^5*(x^5)+(x*(x^5))^5)^5)^5)^5)^5
//x*t-x^(-5)*((x*t-x^(-1)*((x*t-x^(-2)*(x^(-3))+(x*(x^(-4)))^(-2))^(-2))^(3))^(4))^(5)
//(x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1)
//(x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1)-((x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1))
//(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-((2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)){!!!!!XCH no error so as big number}
//-(2*tan(x-5)/cotan(x-5)^3-(2*tan(x-5)-1)^3/cotan(x-5)^5-7/cotan(3*x-y+1)^3)/tan(3*x*y+1)^5-3*(4*tan(3*x-y+1)^3+2)/(2*cotan(x-5)-1)^3*(2*x*cotan(x-5)^5-5)-x*(-(2/tan(x-5)*(-cotan(x-5)^3)-(2/tan(x-5)-1)^3*cotan(x-5)^5-7*cotan(3*x-y+1)^3)*tan(3*x*y+1)^5-3/(4*tan(3*x-y+1)^3+2)*(2*cotan(x-5)-1)^3/(2*x*cotan(x-5)^5-5))
//sin(x)*cos(x)+sin(x+1)/sin(x)+cos(x+1)*cos(x)
//(sin(x)+cos(x)*x+(sin((cos(x+2)+x*sin(x+2)+x/(sin(x)+cos(x)+cos(x+2))-sin(x+2))*sin(2*cos(x+1)+1))+cos(x+1)+(cos((sin(cos(x+1))+2*cos(2*sin(x+1)+1)+sin(2*cos(x+1)+1))))))
//x/sin(x)-cos(x)/(4*sin(x+1)-3)/(2*cos(2*sin(x)+1)-3)-(-(-sin(2*cos(x)+1)-1)-(-2*sin(2*sin(x)+1)))/(-sin(2*cos(x+1)+1)-x/(3*sin(2*sin(x+1)+1)-4)-5/(4*cos(x)*sin(x+1)/(5*sin(2*cos(x+1)+1)))-5-(4*cos(2*sin(x+1)+1)+1)/sin(x+1)*(-cos(x+1)+2)/x/cos(2*cos(x+1)+1))-2*sin(2*cos(x)+1)*cos(2*sin(x)+1)/(2-sin(2*sin(2*sin(x)+1)*3*cos(2*cos(x)+1)))
//sin(2*x*y+1)*cos(2*x+y+1)/(3*cos(2*x*y+1)-4*sin(2*x+y+1))

//1/sin(x)-(-cos(x)-sin(x)^(-1))/cos(x)^(-1)-cos(2*sin(x)^(-1))*sin(2*sin(x)^(-1))/(cos(2*sin(x)^(-1))-sin(2*sin(x)^(-1)))
//sin(x)^(-1)-cos(x)^(-1)-(cos(sin(x)^(-1))^(-1)-sin(sin(x)^(-1))^(-1))-(sin(sin(x)^(-1))^(-1)-2*sin(sin(x)^(-1)))
//(sin(cos(sin(x)))+cos(sin(x)))/(sin(cos(sin(x)))-cos(sin(x))-sin(cos(x)))-cos(x)*cos(sin(cos(x)))-sin(x)/(cos(sin(cos(x)))+cos(x))
//x/sin(2*cos(2*x)+1)-cos(x+1)*cos(2*x)-sin(2*x)/(cos(sin(2*x))-sin(x+1)*sin(2*cos(x)+1))-cos(sin(2*x))*sin(2*cos(2*x)+1)
//1/tan(x)-(-cotan(x)-sin(x)*(tan(x)^(-1)-1/cos(x)^2))-(cos(x)-x*(-cotan(x)^(-1)-sin(x))/tan(x)^(-1))
//arcsin(x/5)^x-1/arccos(x/5)-(-arcsin(x/5)-arccos(x/5)^x)/(arcsin(x/5)^x+arccos(x/5)^x)

 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)
 //(-sin(x)^(-1))-cos(x)^(-2)/sin(x)^(-3)+sin(x)^(-1)-cos(x)-(-sin(x)-cos(x)^(-2))/sin(x)^(-3)
 //(-arccotan(x)^(-1))-arctan(x)^(-2)/arccotan(x)^(-3)+arccotan(x)^(-1)-arctan(x)-(-arccotan(x)-arctan(x)^(-2))/arccotan(x)^(-3)
 //(-arctan(x)^(-1))-arccotan(x)^(-2)/arctan(x)^(-3)+arctan(x)^(-1)-arccotan(x)-(-arctan(x)-arccotan(x)^(-2))/arctan(x)^(-3)
 //arctg(x)^(-1)/(-arcctg(x)^(-2))+arctg(x)^(-2)/arctg(x)^(-1)
 //power(sin(x),(-1))/power(cos(x),(-2))/power(sin(x),(-3))/power(sin(x),(-1))/cos(x)/sin(x)/power(cos(x),(-2))/power(sin(x),(-3));
 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)

 //(cos(x)^(-1)+sin(x)^(-1))/(sin(x)^(-1)-cos(x)^(-1))
 //(cos(x)^(-2)+sin(x)^(-2))/(sin(x)^(-2)-cos(x)^(-2))
 //-cos(x)^(-1)-(-cos(x)^(-2))+sin(x)^(-1)*sin(x)^(-2)/(-cos(x)^(-2))*sin(x)^(-1)
   //(sin(x)^(-2)+cos(x)^(-2))/(sin(x)^(-1)+cos(x)^(-1))
   //(1/sin(x)^2+1/cos(x)^2)/(1/sin(x)+1/cos(x))

 //sinh(x)/(-exp(x))+cosh(x)/(sinh(x))-exp(x)/cosh(x)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-n)/(-exp(x)^(-k))+cosh(x)^(-k)/(sinh(x)^(-n))-exp(x)^(-n)/cosh(x)^(-k)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)*(exp(x)^(-1)+cosh(x))-tanh(x)^(-1)/(-cotanh(x)^(-1)/exp(x)-cosh(x)^(-1))+tanh(x)/exp(x)^(-1)
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1))))/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1)+sinh(exp(x-1))))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1))+sinh(exp(x-1)))-1/exp(x-1)-exp(x-1)^2-1/exp(x+1)^(-1)*(-tanh(x+1)^(k+1)-1/cosh(x+1)^(k+1)-1/sinh(exp(x-1)^2))-(sinh(exp(x-1))-1/cosh(exp(x-1))^2)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //tanh(x)-exp(x)/(cosh(x)+exp(x)*tanh(x))+sinh(x)/(cotanh(x)-tanh(x))-exp(x)*(cosh(x)+tanh(x)+cotanh(x)+sinh(x)+exp(x))
 //sinh(x)+exp(x)*sinh(x)^2-cosh(x)/(cosh(x)^2+tanh(x))-exp(x)^2*sinh(x)^2
 //sinh(x)+cosh(x)+cosh(x)^t-sinh(x)/(cosh(x)^t+exp(x))
 //exp(x)*sinh(x)-cosh(x)/(exp(x)+sinh(x)-cotanh(x))
 //sinh(x)/(-exp(x))+cosh(x)/(-sinh(x))   !!!
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(-sinh(x)^(-1))
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)



//x*(-(x*y+x))-2/(-3*x-y-t/x-(-sin(x/(-(x*y+x))-(-t-1)+1)-t)/x)-(-(-1-t)/x*2+3*x/y/t-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9) {!!! (8)}
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))


//sin(x)+(-(-x*y))
//sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//-(-(-sin(x)-(-cos(x)*(-x-(-(-a)/sin(x)*x-(-(-cos(x)/x)/sin(x)*(-x)-sin(x)*(-x)*(-(-a))*(-x/cos(x)-sin(x)/(-y-(-a/x)))))))))
//-(-(-sin(x)/x-cos(x)*a/x-(-a/sin(x)*cos(x))-(-(sin(x)-(-a*(-x/sin(x)-(-cos(x)/x)))))-(-(-(-sin(x)*(-cos(x)/x)*x*b*(-b*x)/x/(-sin(x)))))*x/sin(x)/(-a)))
//2/(-3*x-y-t/x-(-sin(x/y-(-x-1)+1)-y)/t)-(-(-1-x)/y*2+3*x/y/t-cos(-(-x-y)/(-(-x+y*2)-x)-1)/(x+y*t/3)*x)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1)
//2/(-k)/(-3*(-k)-i*(-i)/(-(-t))-t/k-(-1/(-sin(k/i-(-t-1)+1)-t)/k)+i*(-(-t)))-(-(-1-t)/k*2+3*k/(-i)/(-(-(-t)-2-k)-i)-cos(-(-k-i)/(-(-t+k*2)-k)-1)/(k+i*t/3)*k)-sin(-t-(-k-(1-i)-3-(-k*2))/k/(-i/(-k)-k)-1)

//-(-x)-(-x/(-x-1-y)-t)*(-(-(-x-1)-y-y-1)/(-y)*t/(-y)-y)*(-(-sin(x)-1-x)-y*x/(-y)/(-y)-(-(1-cos(x)-x)-y)/sin(x)+(-(-x*x-y-y+1)-sin(y)/(-t-(-x)-1)*y)*y+(x-(-sin(x)-1-y)-t/(-t*x/(-y)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*x-y-t/x-(-sin(x/(-(x*y+x))-(-t-1)+1)-t)/x)-(-(-1-t)/x*2+3*x/y/t-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9) {!!! (8)}
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))  {!!!}
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))
// 2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*t^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+1)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tg(x)-(-1/x-4+1/t-sin(y))))

//2/sp2(x-cos(y)*sin(-y*sp2(x*t,cos(y*sp2(2-x/t,t)/x*sp2(2-x,3*sin(x))/(2+x)))),y/sp2(x*cos(y),cos(y)*sp2(cos(y),sin(x))))
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1))))))-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))


//sin(x)-(-(sh(x)+cos(x)))
//x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y+(x*y+x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)
//x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y-(x*y+(x*y-(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y-(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y+(x*y+(x*y+(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x+(x*y+x*y+(x*y-(x*y-(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)

//-(-1/a*b-c/x*(1-d)*(-a)-b/c/d/(x-c/(-d)*(-x*2)*(-y*(-2)/(-c)/d/x)-x/2/a))*(-2/a/x*y*3*d*(d+c)*(x+a)*(y+(-a))*(a+1)*(2/d-c))+a/c*d*2/3*x*(-2)*(-a)*(-a-b)*(-x)/(-x-a*x*y*(x/(x*a-y*b-c)*2/c-c/(-d-1)))
//2/(-3*a-b-c/d-(-sin(a/b-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//2/(-a)/(-3*(-a)-b*(-b)/(-(-c))-c/d-(-1/(-sin(a/b-(-c-1)+1)-c)/d)+b*(-(-c)))-(-(-1-c)/d*2+3*a/(-b)/(-(-(-c)-2-d)-b)-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)-sin(-c-(-d-(1-b)-3-(-a*2))/a/(-b/(-a)-d)-1)
//-(-x)-(-a/(-x-1-y)-c)*(-(-(-x-1)-b-y-1)/(-b)*c/(-y)-b)*(-(-sin(x)-1-x)-b*x/(-y)/(-b)-(-(1-cos(x)-x)-b)/sin(x)+(-(-a*x-b-y+1)-sin(y)/(-c-(-x)-1)*y)*b+(x-(-sin(x)-1-y)-t/(-c*x/(-b)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*a-b-c/d-(-sin(a/(-(x*y+x))-(-c-1)+1)-c)/d)-(-(-1-c)/d*2+3*a/b/c-cos(-(-a-b)/(-(-c+d*2)-a)-1)/(a+b*c/3)*d)
//(2*x-(-x/(-y-1)-y)-(-(-1-y))-y/(-x-y-2*(-x/y-3)))*(-(-1-x-(-(-x-(-1-2/y))/(x*y-2/x*(2+x)*(2*x+3*y-4)*y/(2*x+3*y+4))-x/(x+3*y-4))*x*y)*(2*x+1)*(3*y+2)*y*x)-(-2/x)*x*y*(2*x+y-1)*(-y/(-x/y-(-y/(-x/y-1))*(x*y*2-1))-x)
//sin(-a/b-1)*(c+1)^(1+d)-tan(c*(-d)^(2+c))-(2*a+3)^(b+1)-(-a+1/sin(b^(-c)+3^(-d)-d^(-5)))

//2/(-x-(-sin(x*(3-t-(4*t-(-((x*(-sin(x-(-3*t-(2*x-t))*(1-sin(x-2*(-t-(2*t+1))-t)^x)-x^t)/(x^t)+(t*(-x)-t)-((x+1)-t/(x+t))^x-(2*t-7)/(2*sin(x)+t))-t*(-t-7)^x*(x*t)-7*t-8)-(t*(-x-t)^x*t^x*(x+1)-(t+1)-t))-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x)))))
//2/(-x-(-sin(x*|3-t-[4*t-(-|t-[x*{-sin(x-{-3*t-|2*x-t|*[|-y-t|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-|x^{t*y}-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))
//2/(-x-(-sin(ve[x]-vd[k]^2-vd[3]-x*|3-t-vd[k]^2*[4*t-(-|ve[k]-t-[vd[y]*x*{-sin(vd[2]*ve[y]-{-vd[3]*t-|2*x-t-||vd[|-x|]|^|vd[k]|||*[|-y-t-vd[k]|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-vd[{t*y}*2]-|x^{t*y}-[vd[x*k]^2-|t-y|^vd[2]]-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))


//x^y*sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//sin(x)+(-(x/y))




//*********************External function**********************
//***real
//pc1(x)*pc2(x,y)-(-pc1(-pc2(-pc2(2*pc1(-x),3*pc1(-y)+1),2*pc1(-y))))-(pc2(5*pc1(8*pc1(y)-3),7-pc2(pc1(x)/pc1(y),2*pc1(-x)*pc1(y)))*2-1)*(pc2(4*pc1(-y)-5,4-pc1(-x))*3-4-7*pc1(x)/pc1(y))
//sp1(x)*sp2(x,y)-(-sp1(-sp2(-sp2(2*sp1(-x),3*sp1(-y)+1),2*sp1(-y))))-(sp2(5*sp1(8*sp1(y)-3),7-sp2(sp1(x)/sp1(y),2*sp1(-x)*sp1(y)))*2-1)*(sp2(4*sp1(-y)-5,4-sp1(-x))*3-4-7*sp1(x)/sp1(y))
//ps1(x)*ps2(x,y)-(-ps1(-ps2(-ps2(2*ps1(-x),3*ps1(-y)+1),2*ps1(-y))))-(ps2(5*ps1(8*ps1(y)-3),7-ps2(ps1(x)/ps1(y),2*ps1(-x)*ps1(y)))*2-1)*(ps2(4*ps1(-y)-5,4-ps1(-x))*3-4-7*ps1(x)/ps1(y))
//ms1(x)*ms2(x,y)-(-ms1(-ms2(-ms2(2*ms1(-x),3*ms1(-y)+1),2*ms1(-y))))-(ms2(5*ms1(8*ms1(y)-3),7-ms2(ms1(x)/ms1(y),2*ms1(-x)*ms1(y)))*2-1)*(ms2(4*ms1(-y)-5,4-ms1(-x))*3-4-7*ms1(x)/ms1(y))


//sp4(x,y,t,u)*sp4(sp3(y,x,v),sp2(t,y)*sp3(v,u,t),sp4(s,p,q,r),sp3(x,v,q)-sp4(x-sp2(sp1(y),sp2(u,v)),y-sp3(y,t,u),t-sp4(u,s,q,x),-sp3(-x,-y,t)))
//ps4(x,y,t,u)*ps4(ps3(y,x,v),ps2(t,y)*ps3(v,u,t),ps4(s,p,q,r),ps3(x,v,q)-ps4(x-ps2(ps1(y),ps2(u,v)),y-ps3(y,t,u),t-ps4(u,s,q,x),-ps3(-x,-y,t)))
//pc4(x,y,t,u)*pc4(pc3(y,x,v),pc2(t,y)*pc3(v,u,t),pc4(s,p,q,r),pc3(x,v,q)-pc4(x-pc2(pc1(y),pc2(u,v)),y-pc3(y,t,u),t-pc4(u,s,q,x),-pc3(-x,-y,t)))


//sp4(x,y,t,u)*sp4(sp3(y,x,v),sp2(t,y)*sp3(v,u,t),sp4(s,p,q,r),sp3(x,v,q)-sp4(x-sp2(sp1(y),sp2(u,v)),y-sp3(y,t,u),t-sp4(u,s,q,x),-sp3(-x,-y,t)))
//ps4(x,y,t,u)*ps4(ps3(y,x,v),ps2(t,y)*ps3(v,u,t),ps4(s,p,q,r),ps3(x,v,q)-ps4(x-ps2(ps1(y),ps2(u,v)),y-ps3(y,t,u),t-ps4(u,s,q,x),-ps3(-x,-y,t)))
//pc4(x,y,t,u)*pc4(pc3(y,x,v),pc2(t,y)*pc3(v,u,t),pc4(s,p,q,r),pc3(x,v,q)-pc4(x-pc2(pc1(y),pc2(u,v)),y-pc3(y,t,u),t-pc4(u,s,q,x),-pc3(-x,-y,t)))



//sp2(-x,y+t)*sp2(u-r,v-x+y)+sp3(-x,s-y,t-r)*sp2(-t,-x)*(sp3(v-sp1(-x+r),sp2(s-r,r-x),sp3(-sp2(y-x-t,r-y),sp2(v+t,-u),sp1(-s+x)))-sp2(r-sp1(t-y),s-sp1(y-x))*(sp3(y-r,r-sp2(-s,t-u),s-sp1(s+q))-sp3(-u,-t,-y)*(sp3(-sp1(u+s-r),s-t,t+r)-sp2(-r,s+x)*(sp3(r+u,u+q,q-t)*sp1(x-v)-sp1(y*sp2(v+s,r+u-y))))))
//ps2(-x,y+t)*ps2(u-r,v-x+y)+ps3(-x,s-y,t-r)*ps2(-t,-x)*(ps3(v-ps1(-x+r),ps2(s-r,r-x),ps3(-ps2(y-x-t,r-y),ps2(v+t,-u),ps1(-s+x)))-ps2(r-ps1(t-y),s-ps1(y-x))*(ps3(y-r,r-ps2(-s,t-u),s-ps1(s+q))-ps3(-u,-t,-y)*(ps3(-ps1(u+s-r),s-t,t+r)-ps2(-r,s+x)*(ps3(r+u,u+q,q-t)*ps1(x-v)-ps1(y*ps2(v+s,r+u-y))))))
//ms2(-x,y+t)*ms2(u-r,v-x+y)+ms3(-x,s-y,t-r)*ms2(-t,-x)*(ms3(v-ms1(-x+r),ms2(s-r,r-x),ms3(-ms2(y-x-t,r-y),ms2(v+t,-u),ms1(-s+x)))-ms2(r-ms1(t-y),s-ms1(y-x))*(ms3(y-r,r-ms2(-s,t-u),s-ms1(s+q))-ms3(-u,-t,-y)*(ms3(-ms1(u+s-r),s-t,t+r)-ms2(-r,s+x)*(ms3(r+u,u+q,q-t)*ms1(x-v)-ms1(y*ms2(v+s,r+u-y))))))
//pc2(-x,y+t)*pc2(u-r,v-x+y)+pc3(-x,s-y,t-r)*pc2(-t,-x)*(pc3(v-pc1(-x+r),pc2(s-r,r-x),pc3(-pc2(y-x-t,r-y),pc2(v+t,-u),pc1(-s+x)))-pc2(r-pc1(t-y),s-pc1(y-x))*(pc3(y-r,r-pc2(-s,t-u),s-pc1(s+q))-pc3(-u,-t,-y)*(pc3(-pc1(u+s-r),s-t,t+r)-pc2(-r,s+x)*(pc3(r+u,u+q,q-t)*pc1(x-v)-pc1(y*pc2(v+s,r+u-y))))))



 //sp2(sin(x)+1,cos(x)+1)*cos(x)-sin(x)/sp2(x,sin(x))-sp2(cos(x),y+1)/cos(x)-(sp2(x,y+1)^5-sp2(x+2,sp2(y^(x+1),x+1)))*sp2(x,sin(x))-y/sp2(cos(x),y+1)*(sp2(sin(x)+1,cos(x)+1)-sp2(x,y+1)/cos(x))*sp2(x,y+1)^5


{x,y, complex<->real ?!?! ERROR}
//2*pc3(-pc1(sin(x))/pc2(-sin(y)^3,cos(x)^2),-pc2(cos(y)^k,k^sin(x))*3,x/pc2(-pc3((-x/pc2(k^pc2(-k^cos(x),-k!/y),y/pc1(x*sin(cos(y))))^k!-k!^pc2(-x*y,y/x))^5,sin(y)/pc2(-cos(y),sin(x)*x),-k!^pc2(-y/k,x*k))^4,-pc2(k!+x,-(k!)^y)/x)-2)



//sp4(3*sp4(x*sin(x),2-sp4(x*(x*y-t),x*y*(x+y),x*(x+(x+t))+2,x*y*sin(x*y-2*sp4(x*y,t-(y*(x+y))+3,x+y,t*y)+4))*x+y,x*t+2*sp4(3*sp4(sin(x),x*(x-(x+y*2)+t)+y,x*(x-(x*y-t*3)/y)+x,cos(x)*x),sin(y)*cos(t),x-sin(y)-sp4(x-sin(t),-cos(y),-x-sin(y)*cos(y),x*(x+(-y-t)))+3,x/sin(y)-cos(t)/(x-sin(t)))+2*sp4(x*y-t-x/sp4(7.5,x*(x+y*(x-t)/cos(x)),-sin(x),-cos(x)-x*(x-y*(x+y*t))-x),-x*(2*sp4(x*y,x-y,t-x,-y-1)+3),sp4(-x*(x*(x-t)-y),-y*sin(x),-t-x*y,t*x-y)-sin(x)*sp4(-x*(x*(x+t*y)),x*y-x*t,-t-y*x*(x-t*y),-t),x*y*cos(t)+2),sin(t)*sin(x)*(x+y*t)),y*(x*sin(x)+y*t),y*cos(t)+x*y,-t)
//pc4(3*pc4(x*sin(x),2-pc4(x*(x*y-t),x*y*(x+y),x*(x+(x+t))+2,x*y*sin(x*y-2*pc4(x*y,t-(y*(x+y))+3,x+y,t*y)+4))*x+y,x*t+2*pc4(3*pc4(sin(x),x*(x-(x+y*2)+t)+y,x*(x-(x*y-t*3)/y)+x,cos(x)*x),sin(y)*cos(t),x-sin(y)-pc4(x-sin(t),-cos(y),-x-sin(y)*cos(y),x*(x+(-y-t)))+3,x/sin(y)-cos(t)/(x-sin(t)))+2*pc4(x*y-t-x/pc4(7.5,x*(x+y*(x-t)/cos(x)),-sin(x),-cos(x)-x*(x-y*(x+y*t))-x),-x*(2*pc4(x*y,x-y,t-x,-y-1)+3),pc4(-x*(x*(x-t)-y),-y*sin(x),-t-x*y,t*x-y)-sin(x)*pc4(-x*(x*(x+t*y)),x*y-x*t,-t-y*x*(x-t*y),-t),x*y*cos(t)+2),sin(t)*sin(x)*(x+y*t)),y*(x*sin(x)+y*t),y*cos(t)+x*y,-t)
//ps4(3*ps4(x*sin(x),2-ps4(x*(x*y-t),x*y*(x+y),x*(x+(x+t))+2,x*y*sin(x*y-2*ps4(x*y,t-(y*(x+y))+3,x+y,t*y)+4))*x+y,x*t+2*ps4(3*ps4(sin(x),x*(x-(x+y*2)+t)+y,x*(x-(x*y-t*3)/y)+x,cos(x)*x),sin(y)*cos(t),x-sin(y)-ps4(x-sin(t),-cos(y),-x-sin(y)*cos(y),x*(x+(-y-t)))+3,x/sin(y)-cos(t)/(x-sin(t)))+2*ps4(x*y-t-x/ps4(7.5,x*(x+y*(x-t)/cos(x)),-sin(x),-cos(x)-x*(x-y*(x+y*t))-x),-x*(2*ps4(x*y,x-y,t-x,-y-1)+3),ps4(-x*(x*(x-t)-y),-y*sin(x),-t-x*y,t*x-y)-sin(x)*ps4(-x*(x*(x+t*y)),x*y-x*t,-t-y*x*(x-t*y),-t),x*y*cos(t)+2),sin(t)*sin(x)*(x+y*t)),y*(x*sin(x)+y*t),y*cos(t)+x*y,-t)


//x=2; y=5;    {x,y, complex<->real ?!?! ERROR}
//ps2(x*y,y)^(-1)+ps2(x*y,y)^(-1)/ps2(x+y,y)^x-ps2(x*y,y)^(-2)/(ps2(x+y,y)^x+ps2(ps2(x*y,y)^(-1),ps2(x*y,y)^(-2)))+ps2(ps2(x*2+y,ps2(x,y+1))*ps2(x+y,y)^x,ps2(x+y,y)*ps2(x,y+1))/(ps2(x,y+x+1)^(2*x+1)-ps2(x,y+x+1)^(2*k+3))+ps2(x*ps2(x,y+x+1)^(2*x+1),y/ps2(x,y+x+1)^(2*k+3))
//2*pc3(-pc1(sin(x))/pc2(-sin(y)^3,cos(x)^2),-pc2(cos(y)^k,k^sin(x))*3,x/pc2(-pc3((-x/pc2(k^pc2(-k^cos(x),-k!/y),y/pc1(x*sin(cos(y))))^k!-k!^pc2(-x*y,y/x))^5,sin(y)/pc2(-cos(y),sin(x)*x),-k!^pc2(-y/k,x*k))^4,-pc2(k!+x,-(-k!)^y)/x)-2)
//2*ps3(-ps1(sin(x))/ps2(-sin(y)^3,cos(x)^2),-ps2(cos(y)^k,k^sin(x))*3,x/ps2(-ps3((-x/ps2(k^ps2(-k^cos(x),-k!/y),y/ps1(x*sin(cos(y))))^k!-k!^ps2(-x*y,y/x))^5,sin(y)/ps2(-cos(y),sin(x)*x),-k!^ps2(-y/k,x*k))^4,-ps2(k!+x,-(-k!)^y)/x)-2)
//2*sp3(-sp1(sin(x))/sp2(-sin(y)^3,cos(x)^2),-sp2(cos(y)^k,k^sin(x))*3,x/sp2(-sp3((-x/sp2(k^sp2(-k^cos(x),-k!/y),y/sp1(x*sin(cos(y))))^k!-k!^sp2(-x*y,y/x))^5,sin(y)/sp2(-cos(y),sin(x)*x),-k!^sp2(-y/k,x*k))^4,-sp2(k!+x,-(-k!)^y)/x)-2)


//pc3(x-pc2(x+pc1(x*y),y-3*pc1(-y-x)),y+2*pc3(x-pc2(t-pc2(pc1(x-y),-pc1(x*y)),1.5*pc2(x*y,-pc3(x*y,t*pc2(y-t,t-x),x-pc1(x-y)))),pc3(x*y,pc3(x-y,y-t,t*x),pc3(2*pc1(-pc1(x-t)),x-t,pc3(-x,-y-t,x-y-t)))+2.1*pc3(x*y-pc1(y-x),y+pc3(-pc2(-x-pc1(-y),pc2(x*y,-x*t)),2.5*pc2(pc1(t)-pc2(-y*t,t-x)-pc3(x*y,x-y,t-x),1.7*pc2(-t-pc2(x-y,y*t),-pc2(y-t,t*x))+9.5),5.3-pc3(-pc1(t-x)+9.5,pc2(-x*y,t*y)-8.7,-pc3(x-y,y*x,t*3.5)+7.9)),t*x-y),t-pc2(-x*y,-t*1.7)),t+pc2(pc3(pc3(x+y,pc2(x+y,x*t)-pc3(x-t,y-t,t*x)*pc1(y*t*1.5),y+t*x),pc2(x+y,y*t),pc1(x*y)),pc2(-t*x,y*5.3)))
//ms3(x-ms2(x+ms1(x*y),y-3*ms1(-y-x)),y+2*ms3(x-ms2(t-ms2(ms1(x-y),-ms1(x*y)),1.5*ms2(x*y,-ms3(x*y,t*ms2(y-t,t-x),x-ms1(x-y)))),ms3(x*y,ms3(x-y,y-t,t*x),ms3(2*ms1(-ms1(x-t)),x-t,ms3(-x,-y-t,x-y-t)))+2.1*ms3(x*y-ms1(y-x),y+ms3(-ms2(-x-ms1(-y),ms2(x*y,-x*t)),2.5*ms2(ms1(t)-ms2(-y*t,t-x)-ms3(x*y,x-y,t-x),1.7*ms2(-t-ms2(x-y,y*t),-ms2(y-t,t*x))+9.5),5.3-ms3(-ms1(t-x)+9.5,ms2(-x*y,t*y)-8.7,-ms3(x-y,y*x,t*3.5)+7.9)),t*x-y),t-ms2(-x*y,-t*1.7)),t+ms2(ms3(ms3(x+y,ms2(x+y,x*t)-ms3(x-t,y-t,t*x)*ms1(y*t*1.5),y+t*x),ms2(x+y,y*t),ms1(x*y)),ms2(-t*x,y*5.3)))
//ps3(x-ps2(x+ps1(x*y),y-3*ps1(-y-x)),y+2*ps3(x-ps2(t-ps2(ps1(x-y),-ps1(x*y)),1.5*ps2(x*y,-ps3(x*y,t*ps2(y-t,t-x),x-ps1(x-y)))),ps3(x*y,ps3(x-y,y-t,t*x),ps3(2*ps1(-ps1(x-t)),x-t,ps3(-x,-y-t,x-y-t)))+2.1*ps3(x*y-ps1(y-x),y+ps3(-ps2(-x-ps1(-y),ps2(x*y,-x*t)),2.5*ps2(ps1(t)-ps2(-y*t,t-x)-ps3(x*y,x-y,t-x),1.7*ps2(-t-ps2(x-y,y*t),-ps2(y-t,t*x))+9.5),5.3-ps3(-ps1(t-x)+9.5,ps2(-x*y,t*y)-8.7,-ps3(x-y,y*x,t*3.5)+7.9)),t*x-y),t-ps2(-x*y,-t*1.7)),t+ps2(ps3(ps3(x+y,ps2(x+y,x*t)-ps3(x-t,y-t,t*x)*ps1(y*t*1.5),y+t*x),ps2(x+y,y*t),ps1(x*y)),ps2(-t*x,y*5.3)))
//sp3(x-sp2(x+sp1(x*y),y-3*sp1(-y-x)),y+2*sp3(x-sp2(t-sp2(sp1(x-y),-sp1(x*y)),1.5*sp2(x*y,-sp3(x*y,t*sp2(y-t,t-x),x-sp1(x-y)))),sp3(x*y,sp3(x-y,y-t,t*x),sp3(2*sp1(-sp1(x-t)),x-t,sp3(-x,-y-t,x-y-t)))+2.1*sp3(x*y-sp1(y-x),y+sp3(-sp2(-x-sp1(-y),sp2(x*y,-x*t)),2.5*sp2(sp1(t)-sp2(-y*t,t-x)-sp3(x*y,x-y,t-x),1.7*sp2(-t-sp2(x-y,y*t),-sp2(y-t,t*x))+9.5),5.3-sp3(-sp1(t-x)+9.5,sp2(-x*y,t*y)-8.7,-sp3(x-y,y*x,t*3.5)+7.9)),t*x-y),t-sp2(-x*y,-t*1.7)),t+sp2(sp3(sp3(x+y,sp2(x+y,x*t)-sp3(x-t,y-t,t*x)*sp1(y*t*1.5),y+t*x),sp2(x+y,y*t),sp1(x*y)),sp2(-t*x,y*5.3)))


//ms3v(vd3,n+k*3,vd2,k*4+1,vd1,j,ms3v(vd2,n+j,vd2,k,vd3,j*2+n,ms3v(vd1,n+5,vd3,k*2,vd2,j*3+k*2,ms3v(vd3,n+k*2+j,vd1,k,vd2,j*3+k+n,ms3v(vd1,n+3*k,vd2,k,vd3,j+k,x)))))
//pc3v(vd3,n+k*3,vd2,k*4+1,vd1,j,pc3v(vd2,n+j,vd2,k,vd3,j*2+n,pc3v(vd1,n+5,vd3,k*2,vd2,j*3+k*2,pc3v(vd3,n+k*2+j,vd1,k,vd2,j*3+k+n,pc3v(vd1,n+3*k,vd2,k,vd3,j+k,x)))))
//sp3v(vd3,n+k*3,vd2,k*4+1,vd1,j,sp3v(vd2,n+j,vd2,k,vd3,j*2+n,sp3v(vd1,n+5,vd3,k*2,vd2,j*3+k*2,sp3v(vd3,n+k*2+j,vd1,k,vd2,j*3+k+n,sp3v(vd1,n+3*k,vd2,k,vd3,j+k,x)))))
//ps3v(vd3,n+k*3,vd2,k*4+1,vd1,j,ps3v(vd2,n+j,vd2,k,vd3,j*2+n,ps3v(vd1,n+5,vd3,k*2,vd2,j*3+k*2,ps3v(vd3,n+k*2+j,vd1,k,vd2,j*3+k+n,ps3v(vd1,n+3*k,vd2,k,vd3,j+k,x)))))

{
ms8v(vd1,n+1,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,y,vd1,k*2+n,ms8v(vd1,k+j*3,y,vd2,k*4+n+1,x,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,y,vd1,k*3+j,x,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x,vd3,j),vd1,k*2+n,ms8v(vd1,k+j*3,y,vd2,k*4+n+1,x,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,y,vd1,k*3+j,x,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x,vd3,j),vd2,k*3,x,vd3,j)*ms8v(vd2,n+k+j,ms8v(vd2,n+k*4,y*ms8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*ms8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x*ms8v(vd1,n+k*3,y,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*ms8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x,vd2,j*3+n)*t
  *ms8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*ms8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*ms8v(vd3,n+1,x*ms8v(vd1,n+k*3,x*ms8v(vd1,n+k*2,y,vd1,k*3+j,x,vd3,j*3+n)-t*ms8v(vd3,k+j*3-1,y,vd2,k*4+n+2,x,vd2,j+k+n),vd3,k*3+j,x,vd2,j+n)+y*ms8v(vd1,k+j*3,y,vd2,k*4+n+1,x,vd3,j+k),vd1,k*3,x*ms8v(vd1,n+k*3,x*ms8v(vd1,n+k*2,y,vd1,k*3+j,x,vd3,j*3+n)-t*ms8v(vd3,k+j*3-1,y,vd2,k*4+n+2,x,vd2,j+k+n),vd3,k*3+j,x,vd2,j+n)+y*ms8v(vd1,k+j*3,y,vd2,k*4+n+1,x,vd3,j+k),vd2,j)
}


//real:
{
ms8v(vd1,n+1,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,x*y+t,vd1,k*2+n,ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*ms8v(vd2,n+k+j,ms8v(vd2,n+k*4,y*ms8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*ms8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*ms8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*ms8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*ms8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*ms8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*ms8v(vd3,n+1,x*ms8v(vd1,n+k*3,x*ms8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ms8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*ms8v(vd1,n+k*3,x*ms8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ms8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}
{
pc8v(vd1,n+1,pc8v(vd1,n+k*3,pc8v(vd2,n+k*3+j,pc8v(vd2,n+k*3+j,pc8v(vd3,n+k*3,pc8v(vd1,n+k*3,pc8v(vd2,n+k*3+j,pc8v(vd2,n+k*3+j,pc8v(vd3,n+k*3,x*y+t,vd1,k*2+n,pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,pc8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,pc8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*pc8v(vd2,n+k+j,pc8v(vd2,n+k*4,y*pc8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*pc8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*pc8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*pc8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*pc8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*pc8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*pc8v(vd3,n+1,x*pc8v(vd1,n+k*3,x*pc8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*pc8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*pc8v(vd1,n+k*3,x*pc8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*pc8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}
{
ps8v(vd1,n+1,ps8v(vd1,n+k*3,ps8v(vd2,n+k*3+j,ps8v(vd2,n+k*3+j,ps8v(vd3,n+k*3,ps8v(vd1,n+k*3,ps8v(vd2,n+k*3+j,ps8v(vd2,n+k*3+j,ps8v(vd3,n+k*3,x*y+t,vd1,k*2+n,ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ps8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ps8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*ps8v(vd2,n+k+j,ps8v(vd2,n+k*4,y*ps8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*ps8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*ps8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*ps8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*ps8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*ps8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*ps8v(vd3,n+1,x*ps8v(vd1,n+k*3,x*ps8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ps8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*ps8v(vd1,n+k*3,x*ps8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ps8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}
{
sp8v(vd1,n+1,sp8v(vd1,n+k*3,sp8v(vd2,n+k*3+j,sp8v(vd2,n+k*3+j,sp8v(vd3,n+k*3,sp8v(vd1,n+k*3,sp8v(vd2,n+k*3+j,sp8v(vd2,n+k*3+j,sp8v(vd3,n+k*3,x*y+t,vd1,k*2+n,sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,sp8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,sp8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*sp8v(vd2,n+k+j,sp8v(vd2,n+k*4,y*sp8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*sp8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*sp8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*sp8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*sp8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*sp8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*sp8v(vd3,n+1,x*sp8v(vd1,n+k*3,x*sp8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*sp8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*sp8v(vd1,n+k*3,x*sp8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*sp8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}
//complex:
{
ms8v(vd1,n+1,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,z1*z2+z3,vd1,k*2+n,ms8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd1,k*2+n,ms8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd2,k*3,z1*z3+z2,vd3,j)*ms8v(vd2,n+k+j,ms8v(vd2,n+k*4,z2*ms8v(vd1,n+k*4+j,z2*z3+z1,vd2,k*3+j,z1*z2+z1,vd3,j*5+2*k-4*n),vd3,k*2+n-k,z1*ms8v(vd2,n+k*5+j,z2*z3+z1,vd1,k*3+j,z1
*ms8v(vd1,n+k*3,z1*z2+z3,vd3,k*3+j,z1*z2+z3,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,z1*ms8v(vd3,n+k*2,z2*z3+z1*z2,vd1,k*3+j,z1*z3+z2,vd2,j*3+n)*z3*ms8v(vd2,k+j*2+3,z2*z1-z2*z3,vd1,k*4+n+2,z1*ms8v(vd3,n+k*3,z2*z1-z3*z1,vd1,k*2+n,z1*z3,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*ms8v(vd3,n+1,z1*ms8v(vd1,n+k*3,z1*ms8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*ms8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*ms8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd1,k*3,z1*ms8v(vd1,n+k*3,z1*ms8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*ms8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*ms8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j)
}
{
ps8v(vd1,n+1,ps8v(vd1,n+k*3,ps8v(vd2,n+k*3+j,ps8v(vd2,n+k*3+j,ps8v(vd3,n+k*3,ps8v(vd1,n+k*3,ps8v(vd2,n+k*3+j,ps8v(vd2,n+k*3+j,ps8v(vd3,n+k*3,z1*z2+z3,vd1,k*2+n,ps8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,ps8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd1,k*2+n,ps8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,ps8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd2,k*3,z1*z3+z2,vd3,j)*ps8v(vd2,n+k+j,ps8v(vd2,n+k*4,z2*ps8v(vd1,n+k*4+j,z2*z3+z1,vd2,k*3+j,z1*z2+z1,vd3,j*5+2*k-4*n),vd3,k*2+n-k,z1*ps8v(vd2,n+k*5+j,z2*z3+z1,vd1,k*3+j,z1
*ps8v(vd1,n+k*3,z1*z2+z3,vd3,k*3+j,z1*z2+z3,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,z1*ps8v(vd3,n+k*2,z2*z3+z1*z2,vd1,k*3+j,z1*z3+z2,vd2,j*3+n)*z3*ps8v(vd2,k+j*2+3,z2*z1-z2*z3,vd1,k*4+n+2,z1*ps8v(vd3,n+k*3,z2*z1-z3*z1,vd1,k*2+n,z1*z3,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*ps8v(vd3,n+1,z1*ps8v(vd1,n+k*3,z1*ps8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*ps8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*ps8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd1,k*3,z1*ps8v(vd1,n+k*3,z1*ps8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*ps8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*ps8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j)
}
{
sp8v(vd1,n+1,sp8v(vd1,n+k*3,sp8v(vd2,n+k*3+j,sp8v(vd2,n+k*3+j,sp8v(vd3,n+k*3,sp8v(vd1,n+k*3,sp8v(vd2,n+k*3+j,sp8v(vd2,n+k*3+j,sp8v(vd3,n+k*3,z1*z2+z3,vd1,k*2+n,sp8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,sp8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd1,k*2+n,sp8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,sp8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd2,k*3,z1*z3+z2,vd3,j)*sp8v(vd2,n+k+j,sp8v(vd2,n+k*4,z2*sp8v(vd1,n+k*4+j,z2*z3+z1,vd2,k*3+j,z1*z2+z1,vd3,j*5+2*k-4*n),vd3,k*2+n-k,z1*sp8v(vd2,n+k*5+j,z2*z3+z1,vd1,k*3+j,z1
*sp8v(vd1,n+k*3,z1*z2+z3,vd3,k*3+j,z1*z2+z3,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,z1*sp8v(vd3,n+k*2,z2*z3+z1*z2,vd1,k*3+j,z1*z3+z2,vd2,j*3+n)*z3*sp8v(vd2,k+j*2+3,z2*z1-z2*z3,vd1,k*4+n+2,z1*sp8v(vd3,n+k*3,z2*z1-z3*z1,vd1,k*2+n,z1*z3,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*sp8v(vd3,n+1,z1*sp8v(vd1,n+k*3,z1*sp8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*sp8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*sp8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd1,k*3,z1*sp8v(vd1,n+k*3,z1*sp8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*sp8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*sp8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j)
}
{
pc8v(vd1,n+1,pc8v(vd1,n+k*3,pc8v(vd2,n+k*3+j,pc8v(vd2,n+k*3+j,pc8v(vd3,n+k*3,pc8v(vd1,n+k*3,pc8v(vd2,n+k*3+j,pc8v(vd2,n+k*3+j,pc8v(vd3,n+k*3,z1*z2+z3,vd1,k*2+n,pc8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,pc8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd1,k*2+n,pc8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,z1*z3+z2,vd2,j*5+3*k-4*n),vd1,k*3+j,pc8v(vd3,n+k*5,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,z1*z3+z2,vd3,j),vd2,k*3,z1*z3+z2,vd3,j)*pc8v(vd2,n+k+j,pc8v(vd2,n+k*4,z2*pc8v(vd1,n+k*4+j,z2*z3+z1,vd2,k*3+j,z1*z2+z1,vd3,j*5+2*k-4*n),vd3,k*2+n-k,z1*pc8v(vd2,n+k*5+j,z2*z3+z1,vd1,k*3+j,z1
*pc8v(vd1,n+k*3,z1*z2+z3,vd3,k*3+j,z1*z2+z3,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,z1*pc8v(vd3,n+k*2,z2*z3+z1*z2,vd1,k*3+j,z1*z3+z2,vd2,j*3+n)*z3*pc8v(vd2,k+j*2+3,z2*z1-z2*z3,vd1,k*4+n+2,z1*pc8v(vd3,n+k*3,z2*z1-z3*z1,vd1,k*2+n,z1*z3,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*pc8v(vd3,n+1,z1*pc8v(vd1,n+k*3,z1*pc8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*pc8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*pc8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd1,k*3,z1*pc8v(vd1,n+k*3,z1*pc8v(vd1,n+k*2,z1*z2+z3,vd1,k*3+j,z1*z3+z2,vd3,j*3+n)-z3*pc8v(vd3,k+j*3-1,z1*z2+z3,vd2,k*4+n+2,z1*z3+z2,vd2,j+k+n),vd3,k*3+j,z1*z3+z2,vd2,j+n)+z2*pc8v(vd1,k+j*3,z1*z2+z3,vd2,k*4+n+1,z1*z3+z2,vd3,j+k),vd2,j)
}



//ms8v(vd1,n+k*3,x*ms8v(vd1,k+j*3,y*ms8v(vd3,n+k*3,y*ms8v(vd1,n+k*3,x*ms8v(vd1,k+j*3,y*ms8v(vd3,n+k*3,y,vd1,k*2+n,x*ms8v(vd3,5*j+k*2,y*ms8v(vd3,n+k*5,y*ms8v(vd2,n+k*4,y,vd3,k*3+n-k,x*ms8v(vd2,n+k*3+j,y,vd1,k*3+j,x*ms8v(vd1,n+k*3,y,vd3,k*3+j,x,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x,vd2,j*3+n+k),vd2,k*5+j-n,x,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x,vd3,j+k),vd3,k*3+j,y*ms8v(vd1,k+j*3,y,vd2,k*4+n+1,x,vd3,j+k),vd2,j+n),vd1,k*2+n,x*ms8v(vd3,5*j+k*2,y*ms8v(vd3,n+k*5,y*ms8v(vd2,n+k*4,y,vd3,k*3+n-k,x*ms8v(vd2,n+k*3+j,y,vd1,k*3+j,x*ms8v(vd1,n+k*3,y,vd3,k*3+j,x,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x,vd2,j*3+n+k),vd2,k*5+j-n,x,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x,vd3,j+k),vd3,k*3+j,y*ms8v(vd1,k+j*3,y,vd2,k*4+n+1,x,vd3,j+k),vd2,j+n)



//ms8v(vd1,n+k*3,x*ms8v(vd1,k+j*3,y*ms8v(vd3,n+k*3,y*ms8v(vd1,n+k*3,x*ms8v(vd1,k+j*3,y*ms8v(vd3,n+k*3,x*y+t,vd1,k*2+n,x*ms8v(vd3,5*j+k*2,y*ms8v(vd3,n+k*5,y*ms8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*ms8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*ms8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n),vd1,k*2+n,x*ms8v(vd3,5*j+k*2,y*ms8v(vd3,n+k*5,y*ms8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*ms8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*ms8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n)
//pc8v(vd1,n+k*3,x*pc8v(vd1,k+j*3,y*pc8v(vd3,n+k*3,y*pc8v(vd1,n+k*3,x*pc8v(vd1,k+j*3,y*pc8v(vd3,n+k*3,x*y+t,vd1,k*2+n,x*pc8v(vd3,5*j+k*2,y*pc8v(vd3,n+k*5,y*pc8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*pc8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*pc8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n),vd1,k*2+n,x*pc8v(vd3,5*j+k*2,y*pc8v(vd3,n+k*5,y*pc8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*pc8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*pc8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n)
//ps8v(vd1,n+k*3,x*ps8v(vd1,k+j*3,y*ps8v(vd3,n+k*3,y*ps8v(vd1,n+k*3,x*ps8v(vd1,k+j*3,y*ps8v(vd3,n+k*3,x*y+t,vd1,k*2+n,x*ps8v(vd3,5*j+k*2,y*ps8v(vd3,n+k*5,y*ps8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*ps8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*ps8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n),vd1,k*2+n,x*ps8v(vd3,5*j+k*2,y*ps8v(vd3,n+k*5,y*ps8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*ps8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*ps8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n)
//sp8v(vd1,n+k*3,x*sp8v(vd1,k+j*3,y*sp8v(vd3,n+k*3,y*sp8v(vd1,n+k*3,x*sp8v(vd1,k+j*3,y*sp8v(vd3,n+k*3,x*y+t,vd1,k*2+n,x*sp8v(vd3,5*j+k*2,y*sp8v(vd3,n+k*5,y*sp8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*sp8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*sp8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n),vd1,k*2+n,x*sp8v(vd3,5*j+k*2,y*sp8v(vd3,n+k*5,y*sp8v(vd2,n+k*4,x*y+t,vd3,k*3+n-k,x*sp8v(vd2,n+k*3+j,x*y+t,vd1,k*3+j,x*sp8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*t+y,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,k*5+j-n,x*t+y,vd1,4*k+n),vd2,j+2*k+n),vd2,k*4+n+1,x*t+y,vd3,j+k),vd3,k*3+j,y*sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+n)



//***complex
//pc1(z1)*pc2(z1,y)-(-pc1(-pc2(-pc2(2*pc1(-z1),3*pc1(-y)+1),2*pc1(-y))))-(pc2(5*pc1(8*pc1(y)-3),7-pc2(pc1(z1)/pc1(y),2*pc1(-z1)*pc1(y)))*2-1)*(pc2(4*pc1(-y)-5,4-pc1(-z1))*3-4-7*pc1(z1)/pc1(y))
//pc1(z1)*pc2(z1,z2)-(-pc1(-pc2(-pc2(2*pc1(-z1),3*pc1(-z2)+1),2*pc1(-z2))))-(pc2(5*pc1(8*pc1(z2)-3),7-pc2(pc1(z1)/pc1(z2),2*pc1(-z1)*pc1(z2)))*2-1)*(pc2(4*pc1(-z2)-5,4-pc1(-z1))*3-4-7*pc1(z1)/pc1(z2))
//

//sp2(z1,x)*ps2(z1,x)*ms2(z1,x)+sp2(x,sp2(z1,x)*ps2(z1,x))*ps2(y,ps2(z1,x)*ms2(z1,x))*ms2(t,sp2(z1,x)*ms2(z1,x))
//sp2x(z1,x)*ps2x(z1,x)*ms2x(z1,x)+sp2x(x,sp2x(z1,x)*ps2x(z1,x))*ps2x(y,ps2x(z1,x)*ms2x(z1,x))*ms2x(t,sp2x(z1,x)*ms2x(z1,x))




//*************INFINITE********************

//sum(1,2,3,4,5,sum())+sum()+sum(1,2,sum(1,2,3,4,5),sum(1,2,3,4,5,6,7)*sum(1,sum(1,2,3,4,5),2,3))

//2*sum(x,x*sum(sin(x)*sum(x,y,x*y-y,-5),cos(y),x,y)+1,2*sum(3*sum(sin(y),x*y,sum(-x)/cos(y),y)+4,x/sum(cos(x)-sum(x,5,-y)),-sum(2*x,-y),-(-(-sum(x/sum(-sum(x*y)/x)-x*y)))-sum(x,y,sin(x)*2,cos(y)*3))+2)



//ms1(-ms2(z1*ms2(ms2(x+y,z1-z2)*ms2(ms1(z1+z2),ms1(z2-z1*ms1(x+t))*ms2(ms1(x*y),ms1(y*t))*z1-ms2(-ms1(z1+z2),ms1(z2-z1))),-ms2(z1-z2,x*y)*z2),z2-ms2(x,z1*x)))

//ms1(-ms2(z1*ms2(ms2(x+y,z1-z2)*ms2(ms1(z1+z2),ms1(z2-z1*ms1(x+t))*ms2(ms1(x*y),ms1(y*t))*z1-ms2(-ms1(z1+z2),ms1(z2-z1))),-ms2(z1-z2,x*y)*z2),z2-ms2(x,z1*x)*ms2(ms1(x*y),ms1(x-y))+ms2(ms1(ms2(z1*z2,x-y)),ms2(ms2(x+y,x-y),ms2(z1-z2,z2*z1)))))+ms2(-ms2(ms1(z1+z2),-ms1(x-y)),ms2(ms1(x*t),-ms1(z2-z1)))*ms2(-z1*ms2(z1*z2,z2*x-y*z2),-z2-ms2(x+y*t,z1*z2-z1)*z2+ms1(x*y+t)*ms1(z1-x))
//sp1(-sp2(z1*sp2(sp2(x+y,z1-z2)*sp2(sp1(z1+z2),sp1(z2-z1*sp1(x+t))*sp2(sp1(x*y),sp1(y*t))*z1-sp2(-sp1(z1+z2),sp1(z2-z1))),-sp2(z1-z2,x*y)*z2),z2-sp2(x,z1*x)*sp2(sp1(x*y),sp1(x-y))+sp2(sp1(sp2(z1*z2,x-y)),sp2(sp2(x+y,x-y),sp2(z1-z2,z2*z1)))))+sp2(-sp2(sp1(z1+z2),-sp1(x-y)),sp2(sp1(x*t),-sp1(z2-z1)))*sp2(-z1*sp2(z1*z2,z2*x-y*z2),-z2-sp2(x+y*t,z1*z2-z1)*z2+sp1(x*y+t)*sp1(z1-x))
//ps1(-ps2(z1*ps2(ps2(x+y,z1-z2)*ps2(ps1(z1+z2),ps1(z2-z1*ps1(x+t))*ps2(ps1(x*y),ps1(y*t))*z1-ps2(-ps1(z1+z2),ps1(z2-z1))),-ps2(z1-z2,x*y)*z2),z2-ps2(x,z1*x)*ps2(ps1(x*y),ps1(x-y))+ps2(ps1(ps2(z1*z2,x-y)),ps2(ps2(x+y,x-y),ps2(z1-z2,z2*z1)))))+ps2(-ps2(ps1(z1+z2),-ps1(x-y)),ps2(ps1(x*t),-ps1(z2-z1)))*ps2(-z1*ps2(z1*z2,z2*x-y*z2),-z2-ps2(x+y*t,z1*z2-z1)*z2+ps1(x*y+t)*ps1(z1-x))


//ms2(z1/z2*ms2(-ms2(x/ms2(z1-z2,z1*z2),-y/ms1(x*y)),ms2(z1*z2,z1/z2)/ms2(z2/z1,z2-z1)),-ms1(x*y+t)/ms2(x-y,z1+z2/z1)*ms2(-ms1(z1/x)/ms2(x/z2,-z2/x),ms1(-x/t)/ms2(x*y,y-t)))*ms2(-z1/ms2(x/ms1(z1-z2),-ms1(z2-z1)/x),-ms2(ms1(x*y),x-ms1(z1/ms2(-ms1(x*y)/z2,-y*ms1(x-y))))/ms1(z1-z2/z1))
//ps2(z1/z2*ps2(-ps2(x/ps2(z1-z2,z1*z2),-y/ps1(x*y)),ps2(z1*z2,z1/z2)/ps2(z2/z1,z2-z1)),-ps1(x*y+t)/ps2(x-y,z1+z2/z1)*ps2(-ps1(z1/x)/ps2(x/z2,-z2/x),ps1(-x/t)/ps2(x*y,y-t)))*ps2(-z1/ps2(x/ps1(z1-z2),-ps1(z2-z1)/x),-ps2(ps1(x*y),x-ps1(z1/ps2(-ps1(x*y)/z2,-y*ps1(x-y))))/ps1(z1-z2/z1))
//sp2(z1/z2*sp2(-sp2(x/sp2(z1-z2,z1*z2),-y/sp1(x*y)),sp2(z1*z2,z1/z2)/sp2(z2/z1,z2-z1)),-sp1(x*y+t)/sp2(x-y,z1+z2/z1)*sp2(-sp1(z1/x)/sp2(x/z2,-z2/x),sp1(-x/t)/sp2(x*y,y-t)))*sp2(-z1/sp2(x/sp1(z1-z2),-sp1(z2-z1)/x),-sp2(sp1(x*y),x-sp1(z1/sp2(-sp1(x*y)/z2,-y*sp1(x-y))))/sp1(z1-z2/z1))


//pc2(z1,-z2/pc2(z2,z1/pc2(z1+z2,z2/pc2(z1*z3,-z1/pc2(z3-z1,z2/pc2(z1/z2,z3/pc2(z1*z2,z3/z1-pc2(z1/pc2(z1*z3,z3/z2),z2/pc2(-z3/z1,-z1/z3)))))))))
//ps2(z1,-z2/ps2(z2,z1/ps2(z1+z2,z2/ps2(z1*z3,-z1/ps2(z3-z1,z2/ps2(z1/z2,z3/ps2(z1*z2,z3/z1-ps2(z1/ps2(z1*z3,z3/z2),z2/ps2(-z3/z1,-z1/z3)))))))))
//sp2(z1,-z2/sp2(z2,z1/sp2(z1+z2,z2/sp2(z1*z3,-z1/sp2(z3-z1,z2/sp2(z1/z2,z3/sp2(z1*z2,z3/z1-sp2(z1/sp2(z1*z3,z3/z2),z2/sp2(-z3/z1,-z1/z3)))))))))
//ms2(z1,-z2/ms2(z2,z1/ms2(z1+z2,z2/ms2(z1*z3,-z1/ms2(z3-z1,z2/ms2(z1/z2,z3/ms2(z1*z2,z3/z1-ms2(z1/ms2(z1*z3,z3/z2),z2/ms2(-z3/z1,-z1/z3)))))))))


//ms1(-ms2(x*ms2(ms2(x+y,x-y)*ms2(ms1(x+y),ms1(y-x*ms1(x+t))*ms2(ms1(x*y),ms1(y*t))*x-ms2(-ms1(x+y),ms1(y-x))),-ms2(x-y,x*y)*y),y-ms2(x,x*x)))

//ms1(-ms2(x*ms2(ms2(x+y,x-y)*ms2(ms1(x+y),ms1(y-x*ms1(x+t))*ms2(ms1(x*y),ms1(y*t))*x-ms2(-ms1(x+y),ms1(y-x))),-ms2(x-y,x*y)*y),y-ms2(x,x*x)*ms2(ms1(x*y),ms1(x-y))+ms2(ms1(ms2(x*y,x-y)),ms2(ms2(x+y,x-y),ms2(x-y,y*x)))))+ms2(-ms2(ms1(x+y),-ms1(x-y)),ms2(ms1(x*t),-ms1(y-x)))*ms2(-x*ms2(x*y,y*x-y*y),-y-ms2(x+y*t,x*y-x)*y+ms1(x*y+t)*ms1(x-x))
//sp1(-sp2(x*sp2(sp2(x+y,x-y)*sp2(sp1(x+y),sp1(y-x*sp1(x+t))*sp2(sp1(x*y),sp1(y*t))*x-sp2(-sp1(x+y),sp1(y-x))),-sp2(x-y,x*y)*y),y-sp2(x,x*x)*sp2(sp1(x*y),sp1(x-y))+sp2(sp1(sp2(x*y,x-y)),sp2(sp2(x+y,x-y),sp2(x-y,y*x)))))+sp2(-sp2(sp1(x+y),-sp1(x-y)),sp2(sp1(x*t),-sp1(y-x)))*sp2(-x*sp2(x*y,y*x-y*y),-y-sp2(x+y*t,x*y-x)*y+sp1(x*y+t)*sp1(x-x))
//ps1(-ps2(x*ps2(ps2(x+y,x-y)*ps2(ps1(x+y),ps1(y-x*ps1(x+t))*ps2(ps1(x*y),ps1(y*t))*x-ps2(-ps1(x+y),ps1(y-x))),-ps2(x-y,x*y)*y),y-ps2(x,x*x)*ps2(ps1(x*y),ps1(x-y))+ps2(ps1(ps2(x*y,x-y)),ps2(ps2(x+y,x-y),ps2(x-y,y*x)))))+ps2(-ps2(ps1(x+y),-ps1(x-y)),ps2(ps1(x*t),-ps1(y-x)))*ps2(-x*ps2(x*y,y*x-y*y),-y-ps2(x+y*t,x*y-x)*y+ps1(x*y+t)*ps1(x-x))


//ms2(x/y*ms2(-ms2(x/ms2(x-y,x*y),-y/ms1(x*y)),ms2(x*y,x/y)/ms2(y/x,y-x)),-ms1(x*y+t)/ms2(x-y,x+y/x)*ms2(-ms1(x/x)/ms2(x/y,-y/x),ms1(-x/t)/ms2(x*y,y-t)))*ms2(-x/ms2(x/ms1(x-y),-ms1(y-x)/x),-ms2(ms1(x*y),x-ms1(x/ms2(-ms1(x*y)/y,-y*ms1(x-y))))/ms1(x-y/x))
//ps2(x/y*ps2(-ps2(x/ps2(x-y,x*y),-y/ps1(x*y)),ps2(x*y,x/y)/ps2(y/x,y-x)),-ps1(x*y+t)/ps2(x-y,x+y/x)*ps2(-ps1(x/x)/ps2(x/y,-y/x),ps1(-x/t)/ps2(x*y,y-t)))*ps2(-x/ps2(x/ps1(x-y),-ps1(y-x)/x),-ps2(ps1(x*y),x-ps1(x/ps2(-ps1(x*y)/y,-y*ps1(x-y))))/ps1(x-y/x))
//sp2(x/y*sp2(-sp2(x/sp2(x-y,x*y),-y/sp1(x*y)),sp2(x*y,x/y)/sp2(y/x,y-x)),-sp1(x*y+t)/sp2(x-y,x+y/x)*sp2(-sp1(x/x)/sp2(x/y,-y/x),sp1(-x/t)/sp2(x*y,y-t)))*sp2(-x/sp2(x/sp1(x-y),-sp1(y-x)/x),-sp2(sp1(x*y),x-sp1(x/sp2(-sp1(x*y)/y,-y*sp1(x-y))))/sp1(x-y/x))


//pc2(x,-y/pc2(y,x/pc2(x+y,y/pc2(x*t,-x/pc2(t-x,y/pc2(x/y,t/pc2(x*y,t/x-pc2(x/pc2(x*t,t/y),y/pc2(-t/x,-x/t)))))))))
//ps2(x,-y/ps2(y,x/ps2(x+y,y/ps2(x*t,-x/ps2(t-x,y/ps2(x/y,t/ps2(x*y,t/x-ps2(x/ps2(x*t,t/y),y/ps2(-t/x,-x/t)))))))))
//sp2(x,-y/sp2(y,x/sp2(x+y,y/sp2(x*t,-x/sp2(t-x,y/sp2(x/y,t/sp2(x*y,t/x-sp2(x/sp2(x*t,t/y),y/sp2(-t/x,-x/t)))))))))
//ms2(x,-y/ms2(y,x/ms2(x+y,y/ms2(x*t,-x/ms2(t-x,y/ms2(x/y,t/ms2(x*y,t/x-ms2(x/ms2(x*t,t/y),y/ms2(-t/x,-x/t)))))))))



//pc1(-x)/(-(-(-1-pc2(-1-x,pc1(x))))-pc1(-pc1(-x)-1)*(2-pc2(-x,-1)*3))/(-pc1(pc1(-x)*2-3)*3-5)/(pc1(-x-1)*3-5)+(-(-pc1(-1-x))*(-(-(-pc1(-x)*2+5)))*(-pc1(x+1)))+pc1(2*pc1(-x-1)-1)-pc1(-1-x)/((pc1(2*pc1(-x-1)-1)*3-5)+(-(-(-pc1(-1+2*pc1(-x-1)))))-(-pc1(-2*pc1(-x-1)+1)-5)*(pc1(1-2*pc1(-x-1))))+(-pc1(2*pc1(-x-1)-1)-5)*(-2*pc1(1-2*pc1(-x-1))-3)/(pc1(-1+2*pc1(-x-1))*3-pc1(2*pc1(-x-1)-1)*5)/pc1(2*pc1(-x-1)-1)-(-pc1(2*pc1(-x-1)-1)/pc1(x+1))+pc2(-x,x)+2*pc2(x,-x)/(-pc2(-x-1,x+1)-5*pc2(x+1,-x-1)*pc1(pc2(x+1,-x-1)))*(pc1(pc2(x+1,-x-1))-pc1(pc2(1-2*pc1(-x-1),-1-x)))-pc2(x+1,2*pc1(-x)-1)/(-(-3*pc2(1-2*pc1(-x-1),-1-x)))*((-2*pc2(pc1(x+1)*2-1,-1-2*pc1(x+1))-(-5*pc2(-pc1(x+1)*2-1,1-pc1(-x-1)*2))))+(-pc2(-x,x)+(7-3*pc2(x,-x)-5)/(-pc2(-x-1,x+1))/pc2(x+1,-x-1))/(-9/pc2(1-2*pc1(-x-1),-1-x)-pc1(-7*pc2(x+1,2*pc1(-x)-1))-3)+(-pc1(-pc2(pc1(x+1)*2-1,-1-2*pc1(x+1))-7)+(3*pc2(-pc1(x+1)*2-1,1-pc1(-x-1)*2)-5))
//sp1(-x)/(-(-(-1-sp2(-1-x,sp1(x))))-sp1(-sp1(-x)-1)*(2-sp2(-x,-1)*3))/(-sp1(sp1(-x)*2-3)*3-5)/(sp1(-x-1)*3-5)+(-(-sp1(-1-x))*(-(-(-sp1(-x)*2+5)))*(-sp1(x+1)))+sp1(2*sp1(-x-1)-1)-sp1(-1-x)/((sp1(2*sp1(-x-1)-1)*3-5)+(-(-(-sp1(-1+2*sp1(-x-1)))))-(-sp1(-2*sp1(-x-1)+1)-5)*(sp1(1-2*sp1(-x-1))))+(-sp1(2*sp1(-x-1)-1)-5)*(-2*sp1(1-2*sp1(-x-1))-3)/(sp1(-1+2*sp1(-x-1))*3-sp1(2*sp1(-x-1)-1)*5)/sp1(2*sp1(-x-1)-1)-(-sp1(2*sp1(-x-1)-1)/sp1(x+1))+sp2(-x,x)+2*sp2(x,-x)/(-sp2(-x-1,x+1)-5*sp2(x+1,-x-1)*sp1(sp2(x+1,-x-1)))*(sp1(sp2(x+1,-x-1))-sp1(sp2(1-2*sp1(-x-1),-1-x)))-sp2(x+1,2*sp1(-x)-1)/(-(-3*sp2(1-2*sp1(-x-1),-1-x)))*((-2*sp2(sp1(x+1)*2-1,-1-2*sp1(x+1))-(-5*sp2(-sp1(x+1)*2-1,1-sp1(-x-1)*2))))+(-sp2(-x,x)+(7-3*sp2(x,-x)-5)/(-sp2(-x-1,x+1))/sp2(x+1,-x-1))/(-9/sp2(1-2*sp1(-x-1),-1-x)-sp1(-7*sp2(x+1,2*sp1(-x)-1))-3)+(-sp1(-sp2(sp1(x+1)*2-1,-1-2*sp1(x+1))-7)+(3*sp2(-sp1(x+1)*2-1,1-sp1(-x-1)*2)-5))
//ps1(-x)/(-(-(-1-ps2(-1-x,ps1(x))))-ps1(-ps1(-x)-1)*(2-ps2(-x,-1)*3))/(-ps1(ps1(-x)*2-3)*3-5)/(ps1(-x-1)*3-5)+(-(-ps1(-1-x))*(-(-(-ps1(-x)*2+5)))*(-ps1(x+1)))+ps1(2*ps1(-x-1)-1)-ps1(-1-x)/((ps1(2*ps1(-x-1)-1)*3-5)+(-(-(-ps1(-1+2*ps1(-x-1)))))-(-ps1(-2*ps1(-x-1)+1)-5)*(ps1(1-2*ps1(-x-1))))+(-ps1(2*ps1(-x-1)-1)-5)*(-2*ps1(1-2*ps1(-x-1))-3)/(ps1(-1+2*ps1(-x-1))*3-ps1(2*ps1(-x-1)-1)*5)/ps1(2*ps1(-x-1)-1)-(-ps1(2*ps1(-x-1)-1)/ps1(x+1))+ps2(-x,x)+2*ps2(x,-x)/(-ps2(-x-1,x+1)-5*ps2(x+1,-x-1)*ps1(ps2(x+1,-x-1)))*(ps1(ps2(x+1,-x-1))-ps1(ps2(1-2*ps1(-x-1),-1-x)))-ps2(x+1,2*ps1(-x)-1)/(-(-3*ps2(1-2*ps1(-x-1),-1-x)))*((-2*ps2(ps1(x+1)*2-1,-1-2*ps1(x+1))-(-5*ps2(-ps1(x+1)*2-1,1-ps1(-x-1)*2))))+(-ps2(-x,x)+(7-3*ps2(x,-x)-5)/(-ps2(-x-1,x+1))/ps2(x+1,-x-1))/(-9/ps2(1-2*ps1(-x-1),-1-x)-ps1(-7*ps2(x+1,2*ps1(-x)-1))-3)+(-ps1(-ps2(ps1(x+1)*2-1,-1-2*ps1(x+1))-7)+(3*ps2(-ps1(x+1)*2-1,1-ps1(-x-1)*2)-5))
//ms1(-x)/(-(-(-1-ms2(-1-x,ms1(x))))-ms1(-ms1(-x)-1)*(2-ms2(-x,-1)*3))/(-ms1(ms1(-x)*2-3)*3-5)/(ms1(-x-1)*3-5)+(-(-ms1(-1-x))*(-(-(-ms1(-x)*2+5)))*(-ms1(x+1)))+ms1(2*ms1(-x-1)-1)-ms1(-1-x)/((ms1(2*ms1(-x-1)-1)*3-5)+(-(-(-ms1(-1+2*ms1(-x-1)))))-(-ms1(-2*ms1(-x-1)+1)-5)*(ms1(1-2*ms1(-x-1))))+(-ms1(2*ms1(-x-1)-1)-5)*(-2*ms1(1-2*ms1(-x-1))-3)/(ms1(-1+2*ms1(-x-1))*3-ms1(2*ms1(-x-1)-1)*5)/ms1(2*ms1(-x-1)-1)-(-ms1(2*ms1(-x-1)-1)/ms1(x+1))+ms2(-x,x)+2*ms2(x,-x)/(-ms2(-x-1,x+1)-5*ms2(x+1,-x-1)*ms1(ms2(x+1,-x-1)))*(ms1(ms2(x+1,-x-1))-ms1(ms2(1-2*ms1(-x-1),-1-x)))-ms2(x+1,2*ms1(-x)-1)/(-(-3*ms2(1-2*ms1(-x-1),-1-x)))*((-2*ms2(ms1(x+1)*2-1,-1-2*ms1(x+1))-(-5*ms2(-ms1(x+1)*2-1,1-ms1(-x-1)*2))))+(-ms2(-x,x)+(7-3*ms2(x,-x)-5)/(-ms2(-x-1,x+1))/ms2(x+1,-x-1))/(-9/ms2(1-2*ms1(-x-1),-1-x)-ms1(-7*ms2(x+1,2*ms1(-x)-1))-3)+(-ms1(-ms2(ms1(x+1)*2-1,-1-2*ms1(x+1))-7)+(3*ms2(-ms1(x+1)*2-1,1-ms1(-x-1)*2)-5))


//(-sp1(-(-x)/(-t))-(-sp2(-(-sp2(-x,-x-t)-sp2(-sp1(-1.1-x),-(-1.2-sp2(-x-1.3,-y-1.4)*(-1.5)))/sp1(-1.7-x)),-(-1.8-(-x-1.9/(-t-2.1))))))*(-2.2-x*(-2.3-(-y-(-2.4-(-y-x)))/(2.5*x*y*sp2(2.8,-2.9-x)*t/(-2.6-(2.7*x)))))*(sp1(3.1)*sp1(3.2)/sp2(3.3,3.4)-x/(-x*3.5*y*(-3.6)-3.8))+x*(-1.1-y*(2.3*sp2(-1.1,x+y)-sp2(-y,1.1)/2.3)*t)*(-sp2(1.1,x+y)*3.3-sp1(-1.7-x)/(3.5)+sp1(-1.1-x)*(-3.9)-sp2(sp2(1.1,x+y)*7.1,sp2(-y,1.1)/2.5))*((sp2(-sp2(-1.1,x+y)*5.1,-sp2(-1.1,x+y)*3.1-7.9))+sp2(-sp2(-y,1.1)/3.2,-5.7-sp2(-y,1.1)*2.9))
//(-ps1(-(-x)/(-t))-(-ps2(-(-ps2(-x,-x-t)-ps2(-ps1(-1.1-x),-(-1.2-ps2(-x-1.3,-y-1.4)*(-1.5)))/ps1(-1.7-x)),-(-1.8-(-x-1.9/(-t-2.1))))))*(-2.2-x*(-2.3-(-y-(-2.4-(-y-x)))/(2.5*x*y*ps2(2.8,-2.9-x)*t/(-2.6-(2.7*x)))))*(ps1(3.1)*ps1(3.2)/ps2(3.3,3.4)-x/(-x*3.5*y*(-3.6)-3.8))+x*(-1.1-y*(2.3*ps2(-1.1,x+y)-ps2(-y,1.1)/2.3)*t)*(-ps2(1.1,x+y)*3.3-ps1(-1.7-x)/(3.5)+ps1(-1.1-x)*(-3.9)-ps2(ps2(1.1,x+y)*7.1,ps2(-y,1.1)/2.5))*((ps2(-ps2(-1.1,x+y)*5.1,-ps2(-1.1,x+y)*3.1-7.9))+ps2(-ps2(-y,1.1)/3.2,-5.7-ps2(-y,1.1)*2.9))
//(-ms1(-(-x)/(-t))-(-ms2(-(-ms2(-x,-x-t)-ms2(-ms1(-1.1-x),-(-1.2-ms2(-x-1.3,-y-1.4)*(-1.5)))/ms1(-1.7-x)),-(-1.8-(-x-1.9/(-t-2.1))))))*(-2.2-x*(-2.3-(-y-(-2.4-(-y-x)))/(2.5*x*y*ms2(2.8,-2.9-x)*t/(-2.6-(2.7*x)))))*(ms1(3.1)*ms1(3.2)/ms2(3.3,3.4)-x/(-x*3.5*y*(-3.6)-3.8))+x*(-1.1-y*(2.3*ms2(-1.1,x+y)-ms2(-y,1.1)/2.3)*t)*(-ms2(1.1,x+y)*3.3-ms1(-1.7-x)/(3.5)+ms1(-1.1-x)*(-3.9)-ms2(ms2(1.1,x+y)*7.1,ms2(-y,1.1)/2.5))*((ms2(-ms2(-1.1,x+y)*5.1,-ms2(-1.1,x+y)*3.1-7.9))+ms2(-ms2(-y,1.1)/3.2,-5.7-ms2(-y,1.1)*2.9))






//((sp3(x/y,-y/x,-sp2(-x/(x+y),y/(x-y))*2.1)-sp2(-sp1(-y/(y-x))/(x-y/(x-y)),-sp2(x/sp1(x/y),-y/sp1(-y/x))/(x/y-y/x)))/(x/(1.5-sp1(x/(x-y)))-sp2(-x/y,-y/(x+y))/sp3(x/(x+y),-y/(x+y),-2.5+3.1*sp1(x/(x-y)))))/(sp3(x/sp2(x/sp1(x/y),-y/sp1(-y/x)),y/sp2(-x/(x+y),y/(x-y)),-2.5/sp1(x/(x-y)))-sp3(sp1(-y/(y-x))*3.1,sp1(1.5-2.1*sp1(x/(x-y))),sp2(x/y,y/(x+y))/sp2(-x/y,-y/(x+y)))+sp2(3.5-1.7*sp3(x/y,-y/x,-sp2(-x/(x+y),y/(x-y))),3.9-sp1(-y/(y-x))/sp1(-y/x))*sp3(sp2(x/sp1(-y/(x-y)),-sp2(-x/y,-y/(x+y))),sp1(x/(x-y))/sp2(-x/y,-y/(x+y)),sp1(-x/(x-y))/sp1(-y/(x-y))))
//((ps3(x/y,-y/x,-ps2(-x/(x+y),y/(x-y))*2.1)-ps2(-ps1(-y/(y-x))/(x-y/(x-y)),-ps2(x/ps1(x/y),-y/ps1(-y/x))/(x/y-y/x)))/(x/(1.5-ps1(x/(x-y)))-ps2(-x/y,-y/(x+y))/ps3(x/(x+y),-y/(x+y),-2.5+3.1*ps1(x/(x-y)))))/(ps3(x/ps2(x/ps1(x/y),-y/ps1(-y/x)),y/ps2(-x/(x+y),y/(x-y)),-2.5/ps1(x/(x-y)))-ps3(ps1(-y/(y-x))*3.1,ps1(1.5-2.1*ps1(x/(x-y))),ps2(x/y,y/(x+y))/ps2(-x/y,-y/(x+y)))+ps2(3.5-1.7*ps3(x/y,-y/x,-ps2(-x/(x+y),y/(x-y))),3.9-ps1(-y/(y-x))/ps1(-y/x))*ps3(ps2(x/ps1(-y/(x-y)),-ps2(-x/y,-y/(x+y))),ps1(x/(x-y))/ps2(-x/y,-y/(x+y)),ps1(-x/(x-y))/ps1(-y/(x-y))))
//((ms3(x/y,-y/x,-ms2(-x/(x+y),y/(x-y))*2.1)-ms2(-ms1(-y/(y-x))/(x-y/(x-y)),-ms2(x/ms1(x/y),-y/ms1(-y/x))/(x/y-y/x)))/(x/(1.5-ms1(x/(x-y)))-ms2(-x/y,-y/(x+y))/ms3(x/(x+y),-y/(x+y),-2.5+3.1*ms1(x/(x-y)))))/(ms3(x/ms2(x/ms1(x/y),-y/ms1(-y/x)),y/ms2(-x/(x+y),y/(x-y)),-2.5/ms1(x/(x-y)))-ms3(ms1(-y/(y-x))*3.1,ms1(1.5-2.1*ms1(x/(x-y))),ms2(x/y,y/(x+y))/ms2(-x/y,-y/(x+y)))+ms2(3.5-1.7*ms3(x/y,-y/x,-ms2(-x/(x+y),y/(x-y))),3.9-ms1(-y/(y-x))/ms1(-y/x))*ms3(ms2(x/ms1(-y/(x-y)),-ms2(-x/y,-y/(x+y))),ms1(x/(x-y))/ms2(-x/y,-y/(x+y)),ms1(-x/(x-y))/ms1(-y/(x-y))))
//((pc3(x/y,-y/x,-pc2(-x/(x+y),y/(x-y))*2.1)-pc2(-pc1(-y/(y-x))/(x-y/(x-y)),-pc2(x/pc1(x/y),-y/pc1(-y/x))/(x/y-y/x)))/(x/(1.5-pc1(x/(x-y)))-pc2(-x/y,-y/(x+y))/pc3(x/(x+y),-y/(x+y),-2.5+3.1*pc1(x/(x-y)))))/(pc3(x/pc2(x/pc1(x/y),-y/pc1(-y/x)),y/pc2(-x/(x+y),y/(x-y)),-2.5/pc1(x/(x-y)))-pc3(pc1(-y/(y-x))*3.1,pc1(1.5-2.1*pc1(x/(x-y))),pc2(x/y,y/(x+y))/pc2(-x/y,-y/(x+y)))+pc2(3.5-1.7*pc3(x/y,-y/x,-pc2(-x/(x+y),y/(x-y))),3.9-pc1(-y/(y-x))/pc1(-y/x))*pc3(pc2(x/pc1(-y/(x-y)),-pc2(-x/y,-y/(x+y))),pc1(x/(x-y))/pc2(-x/y,-y/(x+y)),pc1(-x/(x-y))/pc1(-y/(x-y))))

//var: extended:
//((sp3x(x/y,-y/x,-sp2x(-x/(x+y),y/(x-y))*2.1)-sp2x(-sp1x(-y/(y-x))/(x-y/(x-y)),-sp2x(x/sp1x(x/y),-y/sp1x(-y/x))/(x/y-y/x)))/(x/(1.5-sp1x(x/(x-y)))-sp2x(-x/y,-y/(x+y))/sp3x(x/(x+y),-y/(x+y),-2.5+3.1*sp1x(x/(x-y)))))/(sp3x(x/sp2x(x/sp1x(x/y),-y/sp1x(-y/x)),y/sp2x(-x/(x+y),y/(x-y)),-2.5/sp1x(x/(x-y)))-sp3x(sp1x(-y/(y-x))*3.1,sp1x(1.5-2.1*sp1x(x/(x-y))),sp2x(x/y,y/(x+y))/sp2x(-x/y,-y/(x+y)))+sp2x(3.5-1.7*sp3x(x/y,-y/x,-sp2x(-x/(x+y),y/(x-y))),3.9-sp1x(-y/(y-x))/sp1x(-y/x))*sp3x(sp2x(x/sp1x(-y/(x-y)),-sp2x(-x/y,-y/(x+y))),sp1x(x/(x-y))/sp2x(-x/y,-y/(x+y)),sp1x(-x/(x-y))/sp1x(-y/(x-y))))
//((ps3x(x/y,-y/x,-ps2x(-x/(x+y),y/(x-y))*2.1)-ps2x(-ps1x(-y/(y-x))/(x-y/(x-y)),-ps2x(x/ps1x(x/y),-y/ps1x(-y/x))/(x/y-y/x)))/(x/(1.5-ps1x(x/(x-y)))-ps2x(-x/y,-y/(x+y))/ps3x(x/(x+y),-y/(x+y),-2.5+3.1*ps1x(x/(x-y)))))/(ps3x(x/ps2x(x/ps1x(x/y),-y/ps1x(-y/x)),y/ps2x(-x/(x+y),y/(x-y)),-2.5/ps1x(x/(x-y)))-ps3x(ps1x(-y/(y-x))*3.1,ps1x(1.5-2.1*ps1x(x/(x-y))),ps2x(x/y,y/(x+y))/ps2x(-x/y,-y/(x+y)))+ps2x(3.5-1.7*ps3x(x/y,-y/x,-ps2x(-x/(x+y),y/(x-y))),3.9-ps1x(-y/(y-x))/ps1x(-y/x))*ps3x(ps2x(x/ps1x(-y/(x-y)),-ps2x(-x/y,-y/(x+y))),ps1x(x/(x-y))/ps2x(-x/y,-y/(x+y)),ps1x(-x/(x-y))/ps1x(-y/(x-y))))
//((ms3x(x/y,-y/x,-ms2x(-x/(x+y),y/(x-y))*2.1)-ms2x(-ms1x(-y/(y-x))/(x-y/(x-y)),-ms2x(x/ms1x(x/y),-y/ms1x(-y/x))/(x/y-y/x)))/(x/(1.5-ms1x(x/(x-y)))-ms2x(-x/y,-y/(x+y))/ms3x(x/(x+y),-y/(x+y),-2.5+3.1*ms1x(x/(x-y)))))/(ms3x(x/ms2x(x/ms1x(x/y),-y/ms1x(-y/x)),y/ms2x(-x/(x+y),y/(x-y)),-2.5/ms1x(x/(x-y)))-ms3x(ms1x(-y/(y-x))*3.1,ms1x(1.5-2.1*ms1x(x/(x-y))),ms2x(x/y,y/(x+y))/ms2x(-x/y,-y/(x+y)))+ms2x(3.5-1.7*ms3x(x/y,-y/x,-ms2x(-x/(x+y),y/(x-y))),3.9-ms1x(-y/(y-x))/ms1x(-y/x))*ms3x(ms2x(x/ms1x(-y/(x-y)),-ms2x(-x/y,-y/(x+y))),ms1x(x/(x-y))/ms2x(-x/y,-y/(x+y)),ms1x(-x/(x-y))/ms1x(-y/(x-y))))
//((pc3x(x/y,-y/x,-pc2x(-x/(x+y),y/(x-y))*2.1)-pc2x(-pc1x(-y/(y-x))/(x-y/(x-y)),-pc2x(x/pc1x(x/y),-y/pc1x(-y/x))/(x/y-y/x)))/(x/(1.5-pc1x(x/(x-y)))-pc2x(-x/y,-y/(x+y))/pc3x(x/(x+y),-y/(x+y),-2.5+3.1*pc1x(x/(x-y)))))/(pc3x(x/pc2x(x/pc1x(x/y),-y/pc1x(-y/x)),y/pc2x(-x/(x+y),y/(x-y)),-2.5/pc1x(x/(x-y)))-pc3x(pc1x(-y/(y-x))*3.1,pc1x(1.5-2.1*pc1x(x/(x-y))),pc2x(x/y,y/(x+y))/pc2x(-x/y,-y/(x+y)))+pc2x(3.5-1.7*pc3x(x/y,-y/x,-pc2x(-x/(x+y),y/(x-y))),3.9-pc1x(-y/(y-x))/pc1x(-y/x))*pc3x(pc2x(x/pc1x(-y/(x-y)),-pc2x(-x/y,-y/(x+y))),pc1x(x/(x-y))/pc2x(-x/y,-y/(x+y)),pc1x(-x/(x-y))/pc1x(-y/(x-y))))




//x*(sp2(sp1(x-t),-t-sp1(-x-sp1(-y/sp1(-sp2(sp1(sp1(x+y/sp2(x+y,sp2(x*y,y*sp1(x/t))))/x-sp2(2*x+1,3*y+2)/t)/y,-t*sp2(2*x+1,3*y+2))))))-sp2(sp2(x+y,sp2(x*y,y*sp1(x/t))),sp1(sp1(x+y/sp2(x+y,sp2(x*y,y*sp1(x/t))))/x-sp2(2*x+1,3*y+2)/t))*sp1(x-t))*sp2(sp1(x*y*sp2(x+y,x-y)),sp2(x*y+x*sp2(sp1(x*sp1(x+y)*sp2(x*sp1(x*y),y*sp2(x*t,-y))),y-sp2(sp1(y*x*sp2(sp1(x*y*sp2(x+y,x-y)),x*sp2(x*sp1(x-y),y*sp1(x+y)))),sp1(y-x))),-sp2(x*sp1(x*y),y*sp2(x*t,-y))))*sp2(-sp2(-x,y-sp2(sp1(x+y),-sp2(x*y,x*t))*x),x-x*(sp2(2*x+1,3*y+2)-sp2(x*y*sp1(2*x+1),sp2(sp1(x+t)*sp1(x+y),sp1(3*y+2)))))-(sp1(-x*sp2(x*y*sp1(x+t)*sp1(x+y),x-sp2(sp1(x+t)*sp1(x+y),sp1(3*y+2)))+y)*sp2(sp2(2*x+1,3*y+2),-sp1(-sp1(-sp2(sp1(3*y+2),sp1(x+y)))))*x)
//x*(ms2(ms1(x-t),-t-ms1(-x-ms1(-y/ms1(-ms2(ms1(ms1(x+y/ms2(x+y,ms2(x*y,y*ms1(x/t))))/x-ms2(2*x+1,3*y+2)/t)/y,-t*ms2(2*x+1,3*y+2))))))-ms2(ms2(x+y,ms2(x*y,y*ms1(x/t))),ms1(ms1(x+y/ms2(x+y,ms2(x*y,y*ms1(x/t))))/x-ms2(2*x+1,3*y+2)/t))*ms1(x-t))*ms2(ms1(x*y*ms2(x+y,x-y)),ms2(x*y+x*ms2(ms1(x*ms1(x+y)*ms2(x*ms1(x*y),y*ms2(x*t,-y))),y-ms2(ms1(y*x*ms2(ms1(x*y*ms2(x+y,x-y)),x*ms2(x*ms1(x-y),y*ms1(x+y)))),ms1(y-x))),-ms2(x*ms1(x*y),y*ms2(x*t,-y))))*ms2(-ms2(-x,y-ms2(ms1(x+y),-ms2(x*y,x*t))*x),x-x*(ms2(2*x+1,3*y+2)-ms2(x*y*ms1(2*x+1),ms2(ms1(x+t)*ms1(x+y),ms1(3*y+2)))))-(ms1(-x*ms2(x*y*ms1(x+t)*ms1(x+y),x-ms2(ms1(x+t)*ms1(x+y),ms1(3*y+2)))+y)*ms2(ms2(2*x+1,3*y+2),-ms1(-ms1(-ms2(ms1(3*y+2),ms1(x+y)))))*x)
//x*(ps2(ps1(x-t),-t-ps1(-x-ps1(-y/ps1(-ps2(ps1(ps1(x+y/ps2(x+y,ps2(x*y,y*ps1(x/t))))/x-ps2(2*x+1,3*y+2)/t)/y,-t*ps2(2*x+1,3*y+2))))))-ps2(ps2(x+y,ps2(x*y,y*ps1(x/t))),ps1(ps1(x+y/ps2(x+y,ps2(x*y,y*ps1(x/t))))/x-ps2(2*x+1,3*y+2)/t))*ps1(x-t))*ps2(ps1(x*y*ps2(x+y,x-y)),ps2(x*y+x*ps2(ps1(x*ps1(x+y)*ps2(x*ps1(x*y),y*ps2(x*t,-y))),y-ps2(ps1(y*x*ps2(ps1(x*y*ps2(x+y,x-y)),x*ps2(x*ps1(x-y),y*ps1(x+y)))),ps1(y-x))),-ps2(x*ps1(x*y),y*ps2(x*t,-y))))*ps2(-ps2(-x,y-ps2(ps1(x+y),-ps2(x*y,x*t))*x),x-x*(ps2(2*x+1,3*y+2)-ps2(x*y*ps1(2*x+1),ps2(ps1(x+t)*ps1(x+y),ps1(3*y+2)))))-(ps1(-x*ps2(x*y*ps1(x+t)*ps1(x+y),x-ps2(ps1(x+t)*ps1(x+y),ps1(3*y+2)))+y)*ps2(ps2(2*x+1,3*y+2),-ps1(-ps1(-ps2(ps1(3*y+2),ps1(x+y)))))*x)
//x*(pc2(pc1(x-t),-t-pc1(-x-pc1(-y/pc1(-pc2(pc1(pc1(x+y/pc2(x+y,pc2(x*y,y*pc1(x/t))))/x-pc2(2*x+1,3*y+2)/t)/y,-t*pc2(2*x+1,3*y+2))))))-pc2(pc2(x+y,pc2(x*y,y*pc1(x/t))),pc1(pc1(x+y/pc2(x+y,pc2(x*y,y*pc1(x/t))))/x-pc2(2*x+1,3*y+2)/t))*pc1(x-t))*pc2(pc1(x*y*pc2(x+y,x-y)),pc2(x*y+x*pc2(pc1(x*pc1(x+y)*pc2(x*pc1(x*y),y*pc2(x*t,-y))),y-pc2(pc1(y*x*pc2(pc1(x*y*pc2(x+y,x-y)),x*pc2(x*pc1(x-y),y*pc1(x+y)))),pc1(y-x))),-pc2(x*pc1(x*y),y*pc2(x*t,-y))))*pc2(-pc2(-x,y-pc2(pc1(x+y),-pc2(x*y,x*t))*x),x-x*(pc2(2*x+1,3*y+2)-pc2(x*y*pc1(2*x+1),pc2(pc1(x+t)*pc1(x+y),pc1(3*y+2)))))-(pc1(-x*pc2(x*y*pc1(x+t)*pc1(x+y),x-pc2(pc1(x+t)*pc1(x+y),pc1(3*y+2)))+y)*pc2(pc2(2*x+1,3*y+2),-pc1(-pc1(-pc2(pc1(3*y+2),pc1(x+y)))))*x)

//var: extended:
//x*(sp2x(sp1x(x-t),-t-sp1x(-x-sp1x(-y/sp1x(-sp2x(sp1x(sp1x(x+y/sp2x(x+y,sp2x(x*y,y*sp1x(x/t))))/x-sp2x(2*x+1,3*y+2)/t)/y,-t*sp2x(2*x+1,3*y+2))))))-sp2x(sp2x(x+y,sp2x(x*y,y*sp1x(x/t))),sp1x(sp1x(x+y/sp2x(x+y,sp2x(x*y,y*sp1x(x/t))))/x-sp2x(2*x+1,3*y+2)/t))*sp1x(x-t))*sp2x(sp1x(x*y*sp2x(x+y,x-y)),sp2x(x*y+x*sp2x(sp1x(x*sp1x(x+y)*sp2x(x*sp1x(x*y),y*sp2x(x*t,-y))),y-sp2x(sp1x(y*x*sp2x(sp1x(x*y*sp2x(x+y,x-y)),x*sp2x(x*sp1x(x-y),y*sp1x(x+y)))),sp1x(y-x))),-sp2x(x*sp1x(x*y),y*sp2x(x*t,-y))))*sp2x(-sp2x(-x,y-sp2x(sp1x(x+y),-sp2x(x*y,x*t))*x),x-x*(sp2x(2*x+1,3*y+2)-sp2x(x*y*sp1x(2*x+1),sp2x(sp1x(x+t)*sp1x(x+y),sp1x(3*y+2)))))-(sp1x(-x*sp2x(x*y*sp1x(x+t)*sp1x(x+y),x-sp2x(sp1x(x+t)*sp1x(x+y),sp1x(3*y+2)))+y)*sp2x(sp2x(2*x+1,3*y+2),-sp1x(-sp1x(-sp2x(sp1x(3*y+2),sp1x(x+y)))))*x)
//x*(ps2x(ps1x(x-t),-t-ps1x(-x-ps1x(-y/ps1x(-ps2x(ps1x(ps1x(x+y/ps2x(x+y,ps2x(x*y,y*ps1x(x/t))))/x-ps2x(2*x+1,3*y+2)/t)/y,-t*ps2x(2*x+1,3*y+2))))))-ps2x(ps2x(x+y,ps2x(x*y,y*ps1x(x/t))),ps1x(ps1x(x+y/ps2x(x+y,ps2x(x*y,y*ps1x(x/t))))/x-ps2x(2*x+1,3*y+2)/t))*ps1x(x-t))*ps2x(ps1x(x*y*ps2x(x+y,x-y)),ps2x(x*y+x*ps2x(ps1x(x*ps1x(x+y)*ps2x(x*ps1x(x*y),y*ps2x(x*t,-y))),y-ps2x(ps1x(y*x*ps2x(ps1x(x*y*ps2x(x+y,x-y)),x*ps2x(x*ps1x(x-y),y*ps1x(x+y)))),ps1x(y-x))),-ps2x(x*ps1x(x*y),y*ps2x(x*t,-y))))*ps2x(-ps2x(-x,y-ps2x(ps1x(x+y),-ps2x(x*y,x*t))*x),x-x*(ps2x(2*x+1,3*y+2)-ps2x(x*y*ps1x(2*x+1),ps2x(ps1x(x+t)*ps1x(x+y),ps1x(3*y+2)))))-(ps1x(-x*ps2x(x*y*ps1x(x+t)*ps1x(x+y),x-ps2x(ps1x(x+t)*ps1x(x+y),ps1x(3*y+2)))+y)*ps2x(ps2x(2*x+1,3*y+2),-ps1x(-ps1x(-ps2x(ps1x(3*y+2),ps1x(x+y)))))*x)
//x*(ms2x(ms1x(x-t),-t-ms1x(-x-ms1x(-y/ms1x(-ms2x(ms1x(ms1x(x+y/ms2x(x+y,ms2x(x*y,y*ms1x(x/t))))/x-ms2x(2*x+1,3*y+2)/t)/y,-t*ms2x(2*x+1,3*y+2))))))-ms2x(ms2x(x+y,ms2x(x*y,y*ms1x(x/t))),ms1x(ms1x(x+y/ms2x(x+y,ms2x(x*y,y*ms1x(x/t))))/x-ms2x(2*x+1,3*y+2)/t))*ms1x(x-t))*ms2x(ms1x(x*y*ms2x(x+y,x-y)),ms2x(x*y+x*ms2x(ms1x(x*ms1x(x+y)*ms2x(x*ms1x(x*y),y*ms2x(x*t,-y))),y-ms2x(ms1x(y*x*ms2x(ms1x(x*y*ms2x(x+y,x-y)),x*ms2x(x*ms1x(x-y),y*ms1x(x+y)))),ms1x(y-x))),-ms2x(x*ms1x(x*y),y*ms2x(x*t,-y))))*ms2x(-ms2x(-x,y-ms2x(ms1x(x+y),-ms2x(x*y,x*t))*x),x-x*(ms2x(2*x+1,3*y+2)-ms2x(x*y*ms1x(2*x+1),ms2x(ms1x(x+t)*ms1x(x+y),ms1x(3*y+2)))))-(ms1x(-x*ms2x(x*y*ms1x(x+t)*ms1x(x+y),x-ms2x(ms1x(x+t)*ms1x(x+y),ms1x(3*y+2)))+y)*ms2x(ms2x(2*x+1,3*y+2),-ms1x(-ms1x(-ms2x(ms1x(3*y+2),ms1x(x+y)))))*x)
//x*(pc2x(pc1x(x-t),-t-pc1x(-x-pc1x(-y/pc1x(-pc2x(pc1x(pc1x(x+y/pc2x(x+y,pc2x(x*y,y*pc1x(x/t))))/x-pc2x(2*x+1,3*y+2)/t)/y,-t*pc2x(2*x+1,3*y+2))))))-pc2x(pc2x(x+y,pc2x(x*y,y*pc1x(x/t))),pc1x(pc1x(x+y/pc2x(x+y,pc2x(x*y,y*pc1x(x/t))))/x-pc2x(2*x+1,3*y+2)/t))*pc1x(x-t))*pc2x(pc1x(x*y*pc2x(x+y,x-y)),pc2x(x*y+x*pc2x(pc1x(x*pc1x(x+y)*pc2x(x*pc1x(x*y),y*pc2x(x*t,-y))),y-pc2x(pc1x(y*x*pc2x(pc1x(x*y*pc2x(x+y,x-y)),x*pc2x(x*pc1x(x-y),y*pc1x(x+y)))),pc1x(y-x))),-pc2x(x*pc1x(x*y),y*pc2x(x*t,-y))))*pc2x(-pc2x(-x,y-pc2x(pc1x(x+y),-pc2x(x*y,x*t))*x),x-x*(pc2x(2*x+1,3*y+2)-pc2x(x*y*pc1x(2*x+1),pc2x(pc1x(x+t)*pc1x(x+y),pc1x(3*y+2)))))-(pc1x(-x*pc2x(x*y*pc1x(x+t)*pc1x(x+y),x-pc2x(pc1x(x+t)*pc1x(x+y),pc1x(3*y+2)))+y)*pc2x(pc2x(2*x+1,3*y+2),-pc1x(-pc1x(-pc2x(pc1x(3*y+2),pc1x(x+y)))))*x)

//sp3(t*sp2(x,t),-sp4(x,2,5,t),sp3(-x,y*sp1(x*sp2(x,y*sp3(1,2,t*sp1(5)+sp2(-x,y)))),1-sp2(-x,-1-y))*x)*sp2(x-sp3(x,-y,-5),sp4(x,y*x,-t,-t-5)-sp2(x,-t-3*sp4(3,x,y,t))*x)
//ps3(t*ps2(x,t),-ps4(x,2,5,t),ps3(-x,y*ps1(x*ps2(x,y*ps3(1,2,t*ps1(5)+ps2(-x,y)))),1-ps2(-x,-1-y))*x)*ps2(x-ps3(x,-y,-5),ps4(x,y*x,-t,-t-5)-ps2(x,-t-3*ps4(3,x,y,t))*x)
//pc3(t*pc2(x,t),-pc4(x,2,5,t),pc3(-x,y*pc1(x*pc2(x,y*pc3(1,2,t*pc1(5)+pc2(-x,y)))),1-pc2(-x,-1-y))*x)*pc2(x-pc3(x,-y,-5),pc4(x,y*x,-t,-t-5)-pc2(x,-t-3*pc4(3,x,y,t))*x)

//sp1(x/y)*sp2(x/y,y/x)*x/(x*sp2(y/x,x/y)+sp1(y/x)*2)+sp3(x/y,y/x,sp1(-x/y))*x*sp1(x*sp1(-x/y))*(sp3(sp1(-y/x),x/y,y/x)*sp3(x/y,sp1(-x/y),y/x)/(x/sp2(x/y,y/x)+2*sp2(sp1(-y/x)*x,sp1(x/y)*2)))
//ps1(x/y)*ps2(x/y,y/x)*x/(x*ps2(y/x,x/y)+ps1(y/x)*2)+ps3(x/y,y/x,ps1(-x/y))*x*ps1(x*ps1(-x/y))*(ps3(ps1(-y/x),x/y,y/x)*ps3(x/y,ps1(-x/y),y/x)/(x/ps2(x/y,y/x)+2*ps2(ps1(-y/x)*x,ps1(x/y)*2)))



{
sp3(-x,y,-t)*sp3(-1.1*sp2(-x*sp2(x*2.2-3.3,-y*2.1-x)-y,-y-x*sp2(-1.5*sp3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-sp3(x-5.1*sp2(-x,-y/t-2.5)-sp2(-y,1.5-y),-sp2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/sp3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*sp3(x*sp2(-1.1-x,-y-2.2),-1-2/sp3(-x/y,-y/x,-1.1-x/y),x-7.1*sp3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)*sp2(1+5.5/sp2(-1.1-x,-y-2.2),x*sp2(-x,-y/t-2.5))*sp2(-sp3(x+3.1*sp2(-x,-y/t-2.5)+2.1*sp2(-y,1.5-y),1.5+sp2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-(sp3(-x,y,-t)*sp3(-1.1*sp2(-x*sp2(x*2.2-3.3,-y*2.1-x)-y,-y-x*sp2(-1.5*sp3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-sp3(x-5.1*sp2(-x,-y/t-2.5)-sp2(-y,1.5-y),-sp2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/sp3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*sp3(x*sp2(-1.1-x,-y-2.2),-1-2/sp3(-x/y,-y/x,-1.1-x/y),x-7.1*sp3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)
 *sp2(1+5.5/sp2(-1.1-x,-y-2.2),x*sp2(-x,-y/t-2.5))*sp2(-sp3(x+3.1*sp2(-x,-y/t-2.5)+2.1*sp2(-y,1.5-y),1.5+sp2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-y/sp3(x-5.1*sp2(-x,-y/t-2.5)-sp2(-y,1.5-y),-sp2(-1.1-x,-y-2.2)/2.5*x,t)*3.1))/sp3(x-5.1*sp2(-x,-y/t-2.5)-sp2(-y,1.5-y),-sp2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)
}
{
ps3(-x,y,-t)*ps3(-1.1*ps2(-x*ps2(x*2.2-3.3,-y*2.1-x)-y,-y-x*ps2(-1.5*ps3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-ps3(x-5.1*ps2(-x,-y/t-2.5)-ps2(-y,1.5-y),-ps2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/ps3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*ps3(x*ps2(-1.1-x,-y-2.2),-1-2/ps3(-x/y,-y/x,-1.1-x/y),x-7.1*ps3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)*ps2(1+5.5/ps2(-1.1-x,-y-2.2),x*ps2(-x,-y/t-2.5))*ps2(-ps3(x+3.1*ps2(-x,-y/t-2.5)+2.1*ps2(-y,1.5-y),1.5+ps2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-(ps3(-x,y,-t)*ps3(-1.1*ps2(-x*ps2(x*2.2-3.3,-y*2.1-x)-y,-y-x*ps2(-1.5*ps3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-ps3(x-5.1*ps2(-x,-y/t-2.5)-ps2(-y,1.5-y),-ps2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/ps3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*ps3(x*ps2(-1.1-x,-y-2.2),-1-2/ps3(-x/y,-y/x,-1.1-x/y),x-7.1*ps3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)
 *ps2(1+5.5/ps2(-1.1-x,-y-2.2),x*ps2(-x,-y/t-2.5))*ps2(-ps3(x+3.1*ps2(-x,-y/t-2.5)+2.1*ps2(-y,1.5-y),1.5+ps2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-y/ps3(x-5.1*ps2(-x,-y/t-2.5)-ps2(-y,1.5-y),-ps2(-1.1-x,-y-2.2)/2.5*x,t)*3.1))/ps3(x-5.1*ps2(-x,-y/t-2.5)-ps2(-y,1.5-y),-ps2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)
}
{
pc3(-x,y,-t)*pc3(-1.1*pc2(-x*pc2(x*2.2-3.3,-y*2.1-x)-y,-y-x*pc2(-1.5*pc3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-pc3(x-5.1*pc2(-x,-y/t-2.5)-pc2(-y,1.5-y),-pc2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/pc3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*pc3(x*pc2(-1.1-x,-y-2.2),-1-2/pc3(-x/y,-y/x,-1.1-x/y),x-7.1*pc3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)*pc2(1+5.5/pc2(-1.1-x,-y-2.2),x*pc2(-x,-y/t-2.5))*pc2(-pc3(x+3.1*pc2(-x,-y/t-2.5)+2.1*pc2(-y,1.5-y),1.5+pc2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-(pc3(-x,y,-t)*pc3(-1.1*pc2(-x*pc2(x*2.2-3.3,-y*2.1-x)-y,-y-x*pc2(-1.5*pc3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-pc3(x-5.1*pc2(-x,-y/t-2.5)-pc2(-y,1.5-y),-pc2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/pc3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*pc3(x*pc2(-1.1-x,-y-2.2),-1-2/pc3(-x/y,-y/x,-1.1-x/y),x-7.1*pc3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)
 *pc2(1+5.5/pc2(-1.1-x,-y-2.2),x*pc2(-x,-y/t-2.5))*pc2(-pc3(x+3.1*pc2(-x,-y/t-2.5)+2.1*pc2(-y,1.5-y),1.5+pc2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-y/pc3(x-5.1*pc2(-x,-y/t-2.5)-pc2(-y,1.5-y),-pc2(-1.1-x,-y-2.2)/2.5*x,t)*3.1))/pc3(x-5.1*pc2(-x,-y/t-2.5)-pc2(-y,1.5-y),-pc2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)
}
{
ms3(-x,y,-t)*ms3(-1.1*ms2(-x*ms2(x*2.2-3.3,-y*2.1-x)-y,-y-x*ms2(-1.5*ms3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-ms3(x-5.1*ms2(-x,-y/t-2.5)-ms2(-y,1.5-y),-ms2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/ms3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*ms3(x*ms2(-1.1-x,-y-2.2),-1-2/ms3(-x/y,-y/x,-1.1-x/y),x-7.1*ms3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)*ms2(1+5.5/ms2(-1.1-x,-y-2.2),x*ms2(-x,-y/t-2.5))*ms2(-ms3(x+3.1*ms2(-x,-y/t-2.5)+2.1*ms2(-y,1.5-y),1.5+ms2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-(ms3(-x,y,-t)*ms3(-1.1*ms2(-x*ms2(x*2.2-3.3,-y*2.1-x)-y,-y-x*ms2(-1.5*ms3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y),-7.9/(-ms3(x-5.1*ms2(-x,-y/t-2.5)-ms2(-y,1.5-y),-ms2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)))-2/ms3(-x/y,-y/x,-1.1-x/y),-1.5,-t)+1.7*ms3(x*ms2(-1.1-x,-y-2.2),-1-2/ms3(-x/y,-y/x,-1.1-x/y),x-7.1*ms3(-x*2.1+y*2.5-3.3,2.1*x*y-5.3,-x/y)/2.1)
 *ms2(1+5.5/ms2(-1.1-x,-y-2.2),x*ms2(-x,-y/t-2.5))*ms2(-ms3(x+3.1*ms2(-x,-y/t-2.5)+2.1*ms2(-y,1.5-y),1.5+ms2(-1.1-x,-y-2.2)/7.5*x,t)/9.1,x-y/ms3(x-5.1*ms2(-x,-y/t-2.5)-ms2(-y,1.5-y),-ms2(-1.1-x,-y-2.2)/2.5*x,t)*3.1))/ms3(x-5.1*ms2(-x,-y/t-2.5)-ms2(-y,1.5-y),-ms2(-1.1-x,-y-2.2)/2.5*x,t)*3.1)
}



//sp3(sp2(-x,y),sp2(y-sp3(sp2(-x,y),sp2(y,x+sp3(sp2(-x,y+sp3(sp2(-x,y),sp2(y,x+sp3(sp2(-x,y),sp2(y+sp3(sp2(-x,y),sp2(y,x),sp2(t,-x)),x),sp2(t,-x))),sp2(t+sp3(sp2(-x,y+sp3(sp2(-x,y),sp2(y,x),sp2(t,-x))),sp2(y,x),sp2(t,-x)),-x))),sp2(y,x),sp2(-t+sp3(sp2(-x,y),sp2(y,x),sp2(t,-x)),-x))),sp2(t,-x+sp3(sp2(sp3(sp2(-x,y-sp3(sp2(-x,y),sp2(y,x),sp2(t,-x))),sp2(y+sp3(sp2(-x,y),sp2(y,x),sp2(sp3(sp2(-x-sp3(sp2(-x,y-sp3(sp2(-x,y),sp2(y,x),sp2(t+sp3(sp2(-x,y),sp2(y,x),sp2(t,-x)),-x))),sp2(y,x),sp2(t,-x)),y),sp2(y,x),sp2(t,-x))-t,-x)),x),sp2(t-sp3(sp2(-x,sp3(sp2(-x,y),sp2(sp3(sp2(-x,y)+sp3(sp2(-x,y),sp2(y,x),sp2(t,-x)),sp2(y,x)+sp3(sp2(-x,y),sp2(y,x),sp2(t,-x)),sp2(t,-x))+y,x),sp2(t,-x))-y),sp2(y,x),sp2(t,-x)),-x))-x,y+sp3(sp2(-x,y),sp2(y,x),sp2(t,-x))),sp2(y,x),sp2(t,-x)))),x),sp2(t,-x))
//ps3(ps2(-x,y),ps2(y-ps3(ps2(-x,y),ps2(y,x+ps3(ps2(-x,y+ps3(ps2(-x,y),ps2(y,x+ps3(ps2(-x,y),ps2(y+ps3(ps2(-x,y),ps2(y,x),ps2(t,-x)),x),ps2(t,-x))),ps2(t+ps3(ps2(-x,y+ps3(ps2(-x,y),ps2(y,x),ps2(t,-x))),ps2(y,x),ps2(t,-x)),-x))),ps2(y,x),ps2(-t+ps3(ps2(-x,y),ps2(y,x),ps2(t,-x)),-x))),ps2(t,-x+ps3(ps2(ps3(ps2(-x,y-ps3(ps2(-x,y),ps2(y,x),ps2(t,-x))),ps2(y+ps3(ps2(-x,y),ps2(y,x),ps2(ps3(ps2(-x-ps3(ps2(-x,y-ps3(ps2(-x,y),ps2(y,x),ps2(t+ps3(ps2(-x,y),ps2(y,x),ps2(t,-x)),-x))),ps2(y,x),ps2(t,-x)),y),ps2(y,x),ps2(t,-x))-t,-x)),x),ps2(t-ps3(ps2(-x,ps3(ps2(-x,y),ps2(ps3(ps2(-x,y)+ps3(ps2(-x,y),ps2(y,x),ps2(t,-x)),ps2(y,x)+ps3(ps2(-x,y),ps2(y,x),ps2(t,-x)),ps2(t,-x))+y,x),ps2(t,-x))-y),ps2(y,x),ps2(t,-x)),-x))-x,y+ps3(ps2(-x,y),ps2(y,x),ps2(t,-x))),ps2(y,x),ps2(t,-x)))),x),ps2(t,-x))
//ms3(ms2(-x,y),ms2(y-ms3(ms2(-x,y),ms2(y,x+ms3(ms2(-x,y+ms3(ms2(-x,y),ms2(y,x+ms3(ms2(-x,y),ms2(y+ms3(ms2(-x,y),ms2(y,x),ms2(t,-x)),x),ms2(t,-x))),ms2(t+ms3(ms2(-x,y+ms3(ms2(-x,y),ms2(y,x),ms2(t,-x))),ms2(y,x),ms2(t,-x)),-x))),ms2(y,x),ms2(-t+ms3(ms2(-x,y),ms2(y,x),ms2(t,-x)),-x))),ms2(t,-x+ms3(ms2(ms3(ms2(-x,y-ms3(ms2(-x,y),ms2(y,x),ms2(t,-x))),ms2(y+ms3(ms2(-x,y),ms2(y,x),ms2(ms3(ms2(-x-ms3(ms2(-x,y-ms3(ms2(-x,y),ms2(y,x),ms2(t+ms3(ms2(-x,y),ms2(y,x),ms2(t,-x)),-x))),ms2(y,x),ms2(t,-x)),y),ms2(y,x),ms2(t,-x))-t,-x)),x),ms2(t-ms3(ms2(-x,ms3(ms2(-x,y),ms2(ms3(ms2(-x,y)+ms3(ms2(-x,y),ms2(y,x),ms2(t,-x)),ms2(y,x)+ms3(ms2(-x,y),ms2(y,x),ms2(t,-x)),ms2(t,-x))+y,x),ms2(t,-x))-y),ms2(y,x),ms2(t,-x)),-x))-x,y+ms3(ms2(-x,y),ms2(y,x),ms2(t,-x))),ms2(y,x),ms2(t,-x)))),x),ms2(t,-x))



{
sp8i(vd1,j+1,x-y/sp8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), ve2, 2*j+k, -sp8i(vd1,j+2, -x/t, ve1, 4*j-2*k, -x/(sp8i(vd1,j+2, -t/sp8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n) , ve1, 5*j-k, -sp8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)/sp8i(vd2,j+1,x/y, ve1, 2*j+k, x/(sp8i(vd1,j+2, x/sp8i(vd3,j+1, x/sp8i(vd2,k+1,x*s, ve1, 2*j+k, -sp8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n), vi2,3*k-n), ve1, 2*j+k, x-y,vi2,k+j), ve2, 2*j+k, x-y,vi1,k+j-n)),vi1,k+j+n), vi1, k+n)), vi2, k+n),vi1,k+j-n)*((sp8i(vd1,2*j+n, x/y-y/t, ve3, 3*j+k, x-y/t-y/x, vi2,k+3*j-n)*2-sp8i(vd2, 3*j+n, -y/t, ve2, 3*j+k, -y/t, vi3, k+2*j-n))/(x/sp8i(vd1,2*j+n, -x/y, ve2, 3*j+k, y-x/t, vi1,k+3*j-n)-y*sp8i(vd2, 4*j+n, x*(y-t), ve1, 3*j+k, y-y/t, vi3,3*j-n)))
pc8i(vd1,j+1,x-y/pc8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), ve2, 2*j+k, -pc8i(vd1,j+2, -x/t, ve1, 4*j-2*k, -x/(pc8i(vd1,j+2, -t/pc8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n) , ve1, 5*j-k, -pc8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)/pc8i(vd2,j+1,x/y, ve1, 2*j+k, x/(pc8i(vd1,j+2, x/pc8i(vd3,j+1, x/pc8i(vd2,k+1,x*s, ve1, 2*j+k, -pc8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n), vi2,3*k-n), ve1, 2*j+k, x-y,vi2,k+j), ve2, 2*j+k, x-y,vi1,k+j-n)),vi1,k+j+n), vi1, k+n)), vi2, k+n),vi1,k+j-n)*((pc8i(vd1,2*j+n, x/y-y/t, ve3, 3*j+k, x-y/t-y/x, vi2,k+3*j-n)*2-pc8i(vd2, 3*j+n, -y/t, ve2, 3*j+k, -y/t, vi3, k+2*j-n))/(x/pc8i(vd1,2*j+n, -x/y, ve2, 3*j+k, y-x/t, vi1,k+3*j-n)-y*pc8i(vd2, 4*j+n, x*(y-t), ve1, 3*j+k, y-y/t, vi3,3*j-n)))

}



{
ms8v(vd1,n+1,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,ms8v(vd1,n+k*3,ms8v(vd2,n+k*3+j,ms8v(vd2,n+k*3+j,ms8v(vd3,n+k*3,x*y+t,vd1,k*2+n,ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ms8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*ms8v(vd2,n+k+j,ms8v(vd2,n+k*4,y*ms8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*ms8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*ms8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*ms8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*ms8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*ms8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*ms8v(vd3,n+1,x*ms8v(vd1,n+k*3,x*ms8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ms8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*ms8v(vd1,n+k*3,x*ms8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ms8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ms8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}
{
pc8v(vd1,n+1,pc8v(vd1,n+k*3,pc8v(vd2,n+k*3+j,pc8v(vd2,n+k*3+j,pc8v(vd3,n+k*3,pc8v(vd1,n+k*3,pc8v(vd2,n+k*3+j,pc8v(vd2,n+k*3+j,pc8v(vd3,n+k*3,x*y+t,vd1,k*2+n,pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,pc8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,pc8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*pc8v(vd2,n+k+j,pc8v(vd2,n+k*4,y*pc8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*pc8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*pc8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*pc8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*pc8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*pc8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*pc8v(vd3,n+1,x*pc8v(vd1,n+k*3,x*pc8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*pc8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*pc8v(vd1,n+k*3,x*pc8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*pc8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*pc8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}
{
ps8v(vd1,n+1,ps8v(vd1,n+k*3,ps8v(vd2,n+k*3+j,ps8v(vd2,n+k*3+j,ps8v(vd3,n+k*3,ps8v(vd1,n+k*3,ps8v(vd2,n+k*3+j,ps8v(vd2,n+k*3+j,ps8v(vd3,n+k*3,x*y+t,vd1,k*2+n,ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ps8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,ps8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*ps8v(vd2,n+k+j,ps8v(vd2,n+k*4,y*ps8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*ps8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*ps8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*ps8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*ps8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*ps8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*ps8v(vd3,n+1,x*ps8v(vd1,n+k*3,x*ps8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ps8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*ps8v(vd1,n+k*3,x*ps8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*ps8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*ps8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}
{
sp8v(vd1,n+1,sp8v(vd1,n+k*3,sp8v(vd2,n+k*3+j,sp8v(vd2,n+k*3+j,sp8v(vd3,n+k*3,sp8v(vd1,n+k*3,sp8v(vd2,n+k*3+j,sp8v(vd2,n+k*3+j,sp8v(vd3,n+k*3,x*y+t,vd1,k*2+n,sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,sp8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd1,k*2+n,sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j+2*k+n),vd1,k*3+j,x*t+y,vd2,j*5+3*k-4*n),vd1,k*3+j,sp8v(vd3,n+k*5,x*y+t,vd1,k*3+j,x*t+y,vd2,j*3+n+k),vd2,j*5+3*k-4*n),vd3,k*3+j,x*t+y,vd3,j),vd2,k*3,x*t+y,vd3,j)*sp8v(vd2,n+k+j,sp8v(vd2,n+k*4,y*sp8v(vd1,n+k*4+j,y*t+x,vd2,k*3+j,x*y+x,vd3,j*5+2*k-4*n),vd3,k*2+n-k,x*sp8v(vd2,n+k*5+j,y*t+x,vd1,k*3+j,x
*sp8v(vd1,n+k*3,x*y+t,vd3,k*3+j,x*y+t,vd3,j),vd2,j*5+3*k-4*n),vd1,j+k-n),vd3,j*3+n,x*sp8v(vd3,n+k*2,y*t+x*y,vd1,k*3+j,x*t+y,vd2,j*3+n)*t*sp8v(vd2,k+j*2+3,y*x-y*t,vd1,k*4+n+2,x*sp8v(vd3,n+k*3,y*x-t*x,vd1,k*2+n,x*t,vd2,j+2*k+n),vd3,2*j+3*k+n),vd1,j)*sp8v(vd3,n+1,x*sp8v(vd1,n+k*3,x*sp8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*sp8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd1,k*3,x*sp8v(vd1,n+k*3,x*sp8v(vd1,n+k*2,x*y+t,vd1,k*3+j,x*t+y,vd3,j*3+n)-t*sp8v(vd3,k+j*3-1,x*y+t,vd2,k*4+n+2,x*t+y,vd2,j+k+n),vd3,k*3+j,x*t+y,vd2,j+n)+y*sp8v(vd1,k+j*3,x*y+t,vd2,k*4+n+1,x*t+y,vd3,j+k),vd2,j)
}



{


(sp8i(vd3, 2*j, -x*sp8i(vd1, 3*j, -t/sp8i(vd2, 3*k, x/sp8i(vd3,2*j, x/sp8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), ve1, j*k, x-y/t, vi2,k*2*j), ve2, j*k+2*n, t-y/t, vi3, k*2*j)/sp8i(vd2,2+j, x/sp8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, j*k, x-y/t, vi1,k*j+n), ve1, j*k, y/t, vi2, k*3*j), ve1, j*k, -y/t+x, vi2, k*2*j)/sp8i(vd2,5*j, -x/y-x, ve2, j*k+j, sp8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)-t/sp8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), vi1,k*j*3+k))/((-sp8i(vd2,j+5,x+sp8i(vd2,j+5,x+y, ve1, 3*j-k, x-y,vi3,k+2*j-3*n), ve2, 3*j-k, x-y,vi3,k+2*j-3*n)/x+y/sp8i(vd1,2*j+n, x/sp8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, 3*j+k, x-y/t, vi1,k+3*j-n)-3/sp8i(vd3,2*j, x/y, ve3, j*k,
  x-y/sp8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), vi3,k*2*j)))*sp8i(vd1,j+1,x-y/sp8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), ve2, 2*j+k, -sp8i(vd1,j+2, -x/t, ve1, 4*j-2*k, -x/(sp8i(vd1,j+2, -t/sp8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n) , ve1, 5*j-k, -sp8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)/sp8i(vd2,j+1,x/y, ve1, 2*j+k, x/(sp8i(vd1,j+2, x/sp8i(vd3,j+1, x/sp8i(vd2,k+1,x*s, ve1, 2*j+k, -sp8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n), vi2,3*k-n), ve1, 2*j+k, x-y,vi2,k+j), ve3, 2*j+k, x-y,vi1,k+j-n)),vi1,k+j+n), vi1, k+n)), vi2, k+n),vi1,k+j-n)*((sp8i(vd1,2*j+n, x/y-y/t, ve2, 3*j+k, x-y/t-y/x, vi2,k+3*j-n)*2-sp8i(vd2, 3*j+n, -y/t, ve2, 3*j+k, -y/t, vi3, k+2*j-n))*(x/sp8i(vd1,2*j+n, -x/y, ve2, 3*j+k, y-x/t, vi1,k+3*j-n)-y*sp8i(vd2, 4*j+n, x*(y-t), ve3, 3*j+k, y-y/t, vi3,3*j-n)))

(ps8i(vd3, 2*j, -x*ps8i(vd1, 3*j, -t/ps8i(vd2, 3*k, x/ps8i(vd3,2*j, x/ps8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), ve1, j*k, x-y/t, vi2,k*2*j), ve2, j*k+2*n, t-y/t, vi3, k*2*j)/ps8i(vd2,2+j, x/ps8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, j*k, x-y/t, vi1,k*j+n), ve1, j*k, y/t, vi2, k*3*j), ve1, j*k, -y/t+x, vi2, k*2*j)/ps8i(vd2,5*j, -x/y-x, ve2, j*k+j, ps8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)-t/ps8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), vi1,k*j*3+k))/((-ps8i(vd2,j+5,x+ps8i(vd2,j+5,x+y, ve1, 3*j-k, x-y,vi3,k+2*j-3*n), ve2, 3*j-k, x-y,vi3,k+2*j-3*n)/x+y/ps8i(vd1,2*j+n, x/ps8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, 3*j+k, x-y/t, vi1,k+3*j-n)-3/ps8i(vd3,2*j, x/y, ve3, j*k,
  x-y/ps8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), vi3,k*2*j)))*ps8i(vd1,j+1,x-y/ps8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), ve2, 2*j+k, -ps8i(vd1,j+2, -x/t, ve1, 4*j-2*k, -x/(ps8i(vd1,j+2, -t/ps8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n) , ve1, 5*j-k, -ps8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)/ps8i(vd2,j+1,x/y, ve1, 2*j+k, x/(ps8i(vd1,j+2, x/ps8i(vd3,j+1, x/ps8i(vd2,k+1,x*s, ve1, 2*j+k, -ps8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n), vi2,3*k-n), ve1, 2*j+k, x-y,vi2,k+j), ve3, 2*j+k, x-y,vi1,k+j-n)),vi1,k+j+n), vi1, k+n)), vi2, k+n),vi1,k+j-n)*((ps8i(vd1,2*j+n, x/y-y/t, ve2, 3*j+k, x-y/t-y/x, vi2,k+3*j-n)*2-ps8i(vd2, 3*j+n, -y/t, ve2, 3*j+k, -y/t, vi3, k+2*j-n))*(x/ps8i(vd1,2*j+n, -x/y, ve2, 3*j+k, y-x/t, vi1,k+3*j-n)-y*ps8i(vd2, 4*j+n, x*(y-t), ve3, 3*j+k, y-y/t, vi3,3*j-n)))


(ms8i(vd3, 2*j, -x*ms8i(vd1, 3*j, -t/ms8i(vd2, 3*k, x/ms8i(vd3,2*j, x/ms8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), ve1, j*k, x-y/t, vi2,k*2*j), ve2, j*k+2*n, t-y/t, vi3, k*2*j)/ms8i(vd2,2+j, x/ms8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, j*k, x-y/t, vi1,k*j+n), ve1, j*k, y/t, vi2, k*3*j), ve1, j*k, -y/t+x, vi2, k*2*j)/ms8i(vd2,5*j, -x/y-x, ve2, j*k+j, ms8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)-t/ms8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), vi1,k*j*3+k))/((-ms8i(vd2,j+5,x+ms8i(vd2,j+5,x+y, ve1, 3*j-k, x-y,vi3,k+2*j-3*n), ve2, 3*j-k, x-y,vi3,k+2*j-3*n)/x+y/ms8i(vd1,2*j+n, x/ms8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, 3*j+k, x-y/t, vi1,k+3*j-n)-3/ms8i(vd3,2*j, x/y, ve3, j*k,
  x-y/ms8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), vi3,k*2*j)))*ms8i(vd1,j+1,x-y/ms8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), ve2, 2*j+k, -ms8i(vd1,j+2, -x/t, ve1, 4*j-2*k, -x/(ms8i(vd1,j+2, -t/ms8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n) , ve1, 5*j-k, -ms8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)/ms8i(vd2,j+1,x/y, ve1, 2*j+k, x/(ms8i(vd1,j+2, x/ms8i(vd3,j+1, x/ms8i(vd2,k+1,x*s, ve1, 2*j+k, -ms8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n), vi2,3*k-n), ve1, 2*j+k, x-y,vi2,k+j), ve3, 2*j+k, x-y,vi1,k+j-n)),vi1,k+j+n), vi1, k+n)), vi2, k+n),vi1,k+j-n)*((ms8i(vd1,2*j+n, x/y-y/t, ve2, 3*j+k, x-y/t-y/x, vi2,k+3*j-n)*2-ms8i(vd2, 3*j+n, -y/t, ve2, 3*j+k, -y/t, vi3, k+2*j-n))*(x/ms8i(vd1,2*j+n, -x/y, ve2, 3*j+k, y-x/t, vi1,k+3*j-n)-y*ms8i(vd2, 4*j+n, x*(y-t), ve3, 3*j+k, y-y/t, vi3,3*j-n)))

(pc8i(vd3, 2*j, -x*pc8i(vd1, 3*j, -t/pc8i(vd2, 3*k, x/pc8i(vd3,2*j, x/pc8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), ve1, j*k, x-y/t, vi2,k*2*j), ve2, j*k+2*n, t-y/t, vi3, k*2*j)/pc8i(vd2,2+j, x/pc8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, j*k, x-y/t, vi1,k*j+n), ve1, j*k, y/t, vi2, k*3*j), ve1, j*k, -y/t+x, vi2, k*2*j)/pc8i(vd2,5*j, -x/y-x, ve2, j*k+j, pc8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)-t/pc8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), vi1,k*j*3+k))/((-pc8i(vd2,j+5,x+pc8i(vd2,j+5,x+y, ve1, 3*j-k, x-y,vi3,k+2*j-3*n), ve2, 3*j-k, x-y,vi3,k+2*j-3*n)/x+y/pc8i(vd1,2*j+n, x/pc8i(vd1,2*j+n, x/y, ve2, 3*j+k, x-y/t, vi1,k+3*j-n), ve2, 3*j+k, x-y/t, vi1,k+3*j-n)-3/pc8i(vd3,2*j, x/y, ve3, j*k,
  x-y/pc8i(vd3,2*j, x/y, ve1, j*k, x-y/t, vi2,k*2*j), vi3,k*2*j)))*pc8i(vd1,j+1,x-y/pc8i(vd3,2*j+n, x/y, ve1, 3*j+k, x-y/t, vi2,k+3*j-n), ve2, 2*j+k, -pc8i(vd1,j+2, -x/t, ve1, 4*j-2*k, -x/(pc8i(vd1,j+2, -t/pc8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n) , ve1, 5*j-k, -pc8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n)/pc8i(vd2,j+1,x/y, ve1, 2*j+k, x/(pc8i(vd1,j+2, x/pc8i(vd3,j+1, x/pc8i(vd2,k+1,x*s, ve1, 2*j+k, -pc8i(vd1,j+1,x+y, ve2, 2*j+k, x-y,vi1,k+j-n), vi2,3*k-n), ve1, 2*j+k, x-y,vi2,k+j), ve3, 2*j+k, x-y,vi1,k+j-n)),vi1,k+j+n), vi1, k+n)), vi2, k+n),vi1,k+j-n)*((pc8i(vd1,2*j+n, x/y-y/t, ve2, 3*j+k, x-y/t-y/x, vi2,k+3*j-n)*2-pc8i(vd2, 3*j+n, -y/t, ve2, 3*j+k, -y/t, vi3, k+2*j-n))*(x/pc8i(vd1,2*j+n, -x/y, ve2, 3*j+k, y-x/t, vi1,k+3*j-n)-y*pc8i(vd2, 4*j+n, x*(y-t), ve3, 3*j+k, y-y/t, vi3,3*j-n)))

}

    {calc const}


//sp2(a*x/sp2(-d/a,-c/(b-d))/c+(a/b-c)/(sp1(c/(2-d/a*sp1(a-b)))*a-(c-d/a)/sp2(sp1(a/b),-sp1(d/a))*b)-sp1(a/b-c)*x/sp1(c/a+b),-d/sp3(a-b,b/c,c*d)/(-sp2(-a,-d/c))-sp1(c/d-d/c)*t/sp2(-d/a,-d/(b-a))*sp1(c/b-a)/(-c))
//sp2(ai*z1/sp2(-di/a,-c/(bi-d))/c+(a/bi-c)/(sp1(ci/(2-d/a*sp1(a-bi)))*ai-(c-di/a)/sp2(sp1(a/bi),-sp1(di/ai))*bi)-sp1(ai/bi-ci)*z2/sp1(c/ai+bi),-di/sp3(ai-bi,bi/c,ci*di)/(-sp2(-a,-di/ci))-sp1(i/c/d-d/c+i)*z3/sp2(-di/a,-d*i/(b-a))*sp1(ci/b-ai)/(-c/i))



// sp3(cos(-a/sp1(d/c)),-sp2(c*sp1(cos(a+c))*sp2(a^b,c/sin(b-c)),c^d),-cos(c/d)/sp2(-a/b,d-c/sp1(-c/(-sp1(c/(a+b))))))/sin(sp1(-c-d/a))/(sp2(sin(a/c^b)/d,-cos(c^(b-a))^sp1(d/b))^sp1(c^2/(b-d)^a))
// sp3(cos(-ai/sp1(di/c)),-sp2(ci*sp1(cos(a+ci))*sp2(a^bi,c/sin(b-c)),ci^di),-cos(c/di)/sp2(-ai/b,d-c/sp1(-ci/(-sp1(ci/(ai+b))))))/sin(sp1(-ci-d/a))/(sp2(sin(a/ci^bi)/di,-cos(c^(b-ai))^sp1(di/b))^sp1(c^2/(b-d)^ai)-d*(bi-i/a)^(c/d))



// x/sp1(y-sp2(1.34-sp1(y-2.21)/2.75,sp1(x/2.12)/2.34-2.97))/sp3(-sp1(1.57-y)/2.65,-x-(-sp1(y/2.23)*1.12-2.64),2.32/sp1(x-1.32))*y/(x/1.74/y*2.76-2.11)-2.12/sp2(x,y)*3.35/y/t/sp1(x)*(-x/2.21-2.11-y/7.54)/x*sp2(-1.76/x,-y/2.93)




//  ((sp2(7,5)+sp3(3,9,5))^(sp3(y/x,x/y,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y)))+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(z2/x,x/z1,x/(x+y)))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(y/x,x/y,x/(x+y))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(z1/x,x/z2,z3*x)))*((sp2(7,5)+sp3(3,9,5))^(sp3(z1/x,x/z2,z3*x))))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x,y,y-x))+(sp2(7,5)+sp3(3,9,5))^(sp2(z1/x,x/z2))))
//  ((sp2(7,5)+sp3(3,9,5))^(sp3(y/x,sp2(a/b,b/a)/b+b/a,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(sp2(a/b,b/a)/x,x/sp2(b/(a+b),a/(a+b)))))+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(sp2(ai/bi,bi/ai)/x,x/z1,x/(x+sp2(a/b,b/(a+b)))))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp3(sp2(b/a,a/b)/x,x/sp2(a/(a+b),b/(a+b)),x/(x+sp2(a/(a+b),b/a)))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(sp2(ai/ci,bi/ai)/x,x/sp2(ai/bi,bi/(ai+bi)),sp2(ai/(ci+ai),bi/ai)*x)))*((sp2(7,5)+sp3(3,9,5))^(sp3(sp2(bi/(ai+ci),ai/bi)/x,x/z2,z3*sp2(ai/ci,bi/ci)*x))))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x*sp2(a/b,b/(c+a)),sp2(a/b,b/c),y-x-x/sp2(a/(a+b),b/(a+b))))+(sp2(7,5)+sp3(3,9,5))^(sp2((z1+sp2(ai/bi+ai/ci,ci/(bi+ai/bi)))/x,x/(z2+sp2(ai/bi-ci,ci-bi/ai))))))
//  ((sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y)+sp3(y/x,x/y,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y))*x)+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp2(y/x,x/z1)+sp3(z2/x,x/z1,x/(x+y)))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp2(y/x,x/y)+sp3(y/x,x/y,x/(x+y))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(z1/x,x/z2,z3*x)))*((sp2(7,5)+sp3(3,9,5))^(x/sp2(z1/x,x/z2)+sp3(z1/x,x/z2,z3*x)/x)))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x,y,y-x)+sp2(x,y))+(sp2(7,5)+sp3(3,9,5))^(sp2(z1/x,x/z2))))
//  ((sp2(7,5)+sp3(3,9,5))^(sp2(y/x,x/y)+sp2(a/b,b/sp1(a/b))+sp3(y/x,x/y,x/(y-x)))-(sp2(7,5)+sp3(3,9,5))^(sp2(a/b,b/a)+sp2(y/x,x/y))*x)+((sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp2(y/x,x/z1)/sp3(a/b,b/a,a/(b+a))+sp3(z2/x,x/z1,x/(x+y)))+(sp2(2i,5i)+sp3(3i,9+2i,5-3i))^(sp1(a/(a-b))+sp2(y/x,x/y)+sp3(y/x,x/y,x/(x+y))-a/sp1(b/(a+b))))/((((sp2(b/2,a)+sp3(a-b,b/c,a/c))^(sp3(z1/x,x/z2,z3*x)))*((sp2(7,5)+sp3(3,9,5))^(x/sp2(z1/x,x/z2)+sp3(z1/x,x/z2,z3*x)/x)))/((sp2(ai*sp1(bi/ci),sp2(b,ai))+sp3(ai,bi/ci,ci/(ai+b)))^(sp3(x,y,y-x)/sp1(a/(b+a))+sp2(x,y)/sp1(b/(b+a)))+(sp2(7,5)+sp3(3,9,5))^(sp2(z1/x,x/z2))))



{

sp8(ve,j+3,t+sp8(ve,n+2,y-sp8(ve,k+3,x-y,vd,j+n,y-sp8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-sp8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/sp8(ve,j,x+sp8(ve,k+n+2,t+sp8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+sp8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2)

ps8(ve,j+3,t+ps8(ve,n+2,y-ps8(ve,k+3,x-y,vd,j+n,y-ps8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-ps8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/ps8(ve,j,x+ps8(ve,k+n+2,t+ps8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+ps8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2)

sp8(ve,j+3,z1-sp8(ve,n+2,z2-sp8(ve,k+3,z1-z2,vd,j+n,z2-sp8(ve,k+n,t*z1-y,vd,j+n,z2-z3,vi,j+2),vi,j+2),vd,k+2,t*(z1+z2),vi,n+2*j),vd,j+n,z3-sp8(ve,n*3+1,-z3*x,vd,j+n-1,-z1*1.15,vi,k+2*n-1)/sp8(ve,j,z3+x/sp8(ve,k+n+2,z1*y+sp8(ve,n*4-2,z3-z1*2.73,vd,j+n+1,y*z3,vi,k+5),vd,n+3,z1*t+z3/sp8(ve,j+k,z2*1.17-z3,vd,j+k*2,z3*y-2.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1+z3*2.12,vi,n+2*k),vi,n+2)

ps8(ve,j+3,z1-ps8(ve,n+2,z2-ps8(ve,k+3,z1-z2,vd,j+n,z2-ps8(ve,k+n,t*z1-y,vd,j+n,z2-z3,vi,j+2),vi,j+2),vd,k+2,t*(z1+z2),vi,n+2*j),vd,j+n,z3-ps8(ve,n*3+1,-z3*x,vd,j+n-1,-z1*1.15,vi,k+2*n-1)/ps8(ve,j,z3+x/ps8(ve,k+n+2,z1*y+ps8(ve,n*4-2,z3-z1*2.73,vd,j+n+1,y*z3,vi,k+5),vd,n+3,z1*t+z3/ps8(ve,j+k,z2*1.17-z3,vd,j+k*2,z3*y-2.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1+z3*2.12,vi,n+2*k),vi,n+2)


}


{

spall(ve,n+3,spall(ve,n+1,z1/z2,vd,j+k-1,x,z2/spall(ve,j+3,z3-spall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/spall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-spall(ve,k+3,z1/spall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*spall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)

psall(ve,n+3,psall(ve,n+1,z1/z2,vd,j+k-1,x,z2/psall(ve,j+3,z3-psall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/psall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-psall(ve,k+3,z1/psall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*psall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)

msall(ve,n+3,msall(ve,n+1,z1/z2,vd,j+k-1,x,z2/msall(ve,j+3,z3-msall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/msall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-msall(ve,k+3,z1/msall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*msall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)

pcall(ve,n+3,pcall(ve,n+1,z1/z2,vd,j+k-1,x,z2/pcall(ve,j+3,z3-pcall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/pcall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-pcall(ve,k+3,z1/pcall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*pcall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)

}

{



//spallp(PArrayE;  integer;  PComplexE; PArrayD;  Integer;  double;  TComplexD;  PExtended; PArrayI;  PInteger);


  spall(ve1,k+j,z5e,vd2,k+3,x1d+x2d,z1d-z2d,z4e.im,vi3,j)
  spall(ve2,5*k-j+3,z4e,vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,z5e.re,vi1,k)
  spall(ve3,k+n1-1,z3e,vd3,2*k+3*n1-5,x1d*(x2d-x3d)/(x5d-x2d),z1d*(z2d-z5d/(z3d-z1d)),x3e,vi2,n1)
  spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),z4.im,vi3,n2)
  spall(ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,z1e,vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,z1e.im,vi1,n3)
  spall(ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,z5e,vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d)),z1d*z2d/(z5d*z3d-z2d*z4d),x3e,vi2,n4)
  spall(ve1,k*(j+2*n1*n3-n5),z4e,vd3,5*k*n3+3*(n1+2*n2*k-3*n5),x3d*x2d/(x5d*x1d-x2d*x3d/(x1d-x4d)),(z3d-z2d)*(z5d-z1d)/(z2d*(z1d+z4d)-z3d/z4d),z2.re,vi3,n5)


  spall(@ve1,k+j,@z5e,@vd2,k+3,x1d+x2d,z1d-z2d,@z4e.im,@vi3,@j)
  spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,@z5e.re,@vi1,@k)
  spall(@ve3,k+n1-1,@z3e,@vd3,2*k+3*n1-5,x1d*(x2d-x3d)/(x5d-x2d),z1d*(z2d-z5d/(z3d-z1d)),@x3e,@vi2,@n1)
  spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),@z4.im,@vi3,@n2)
  spall(@ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,@z1e,@vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,@z1e.im,@vi1,@n3)
  spall(@ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,@z5e,@vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d)),z1d*z2d/(z5d*z3d-z2d*z4d),@x3e,@vi2,@n4)
  spall(@ve1,k*(j+2*n1*n3-n5),@z4e,@vd3,5*k*n3+3*(n1+2*n2*k-3*n5),x3d*x2d/(x5d*x1d-x2d*x3d/(x1d-x4d)),(z3d-z2d)*(z5d-z1d)/(z2d*(z1d+z4d)-z3d/z4d),@z2.re,@vi3,@n5)



 1.
  spall(@ve1,k+j,@z5e,@vd2,k+3,x1d+x2d,z1d-z2d,@z4e.im,@vi3,@j)*spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,@z5e.re,@vi1,@k)/(spall(@ve3,k+n1-1,@z3e,@vd3,2*k+3*n1-5,x1d*(x2d-x3d)/(x5d-x2d),z1d*(z2d-z5d/(z3d-z1d)),@x3e,@vi2,@n1)/spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),@z4.im,@vi3,@n2)
   -spall(@ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,@z1e,@vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,@z1e.im,@vi1,@n3)/spall(@ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,@z1e,@vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,@z1e.im,@vi1,@n3)
   +spall(@ve1,k*(j+2*n1*n3-n5),@z4e,@vd3,5*k*n3+3*(n1+2*n2*k-3*n5),x3d*x2d/(x5d*x1d-x2d*x3d/(x1d-x4d)),(z3d-z2d)*(z5d-z1d)/(z2d*(z1d+z4d)-z3d/z4d),@z2.re,@vi3,@n5)/(spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,@z5e.re,@vi1,@k)-spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),@z4.im,@vi3,@n2)))


  spall(ve1,k+j,z5e,vd2,k+3,x1d+x2d,z1d-z2d,z4e.im,vi3,j)*spall(ve2,5*k-j+3,z4e,vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,z5e.re,vi1,k)/(spall(ve3,k+n1-1,z3e,vd3,2*k+3*n1-5,x1d*(x2d-x3d)/(x5d-x2d),z1d*(z2d-z5d/(z3d-z1d)),x3e,vi2,n1)/spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),z4.im,vi3,n2)
   -spall(ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,z1e,vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,z1e.im,vi1,n3)/spall(ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,z1e,vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,z1e.im,vi1,n3)
   +spall(ve1,k*(j+2*n1*n3-n5),z4e,vd3,5*k*n3+3*(n1+2*n2*k-3*n5),x3d*x2d/(x5d*x1d-x2d*x3d/(x1d-x4d)),(z3d-z2d)*(z5d-z1d)/(z2d*(z1d+z4d)-z3d/z4d),z2.re,vi3,n5)/(spall(ve2,5*k-j+3,z4e,vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,z5e.re,vi1,k)-spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),z4.im,vi3,n2)))

 2.
  spall(@ve1,k+j,@z5e,@vd2,k+3,(x1d+x2d)/Re(-z1/spall(@ve1,k+j,@z5e,@vd2,k+3,x1d+x2d,(z1d-z2d)/spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),@z4.im,@vi3,@n2),@z4e.im,@vi3,@j)),(z1d-z2d)/spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,(x2d-x3d)/Im(spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,@z5e.re,@vi1,@k)),
      (z3d+z2d/z3d)/spall(@ve3,k+n1-1,@z3e,@vd3,2*k+3*n1-5,(x1d*(x2d-x3d)/(x5d-x2d))/(Im(spall(@ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,@z1e,@vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,@z1e.im,@vi1,@n3))), (z1d*(z2d-z5d/(z3d-z1d)))/spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,(x3d/(x5d-x2d/x1d))/RE(-spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,(x3d/(x5d-x2d/x1d))/(x5d*Re(-z1/spall(@ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,@z1e,@vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,@z1e.im,@vi1,@n3))),((z3d+z2d)/(z4d/z5d-z3d/z2d))/(z1*spall(@ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,@z1e,@vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),
      z1+z2,@z1e.im,@vi1,@n3)/z2),@z4.im,@vi3,@n2)),spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,x2d-x3d,spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)*(spall(@ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,@z5e,@vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d)),z1d*z2d/(z5d*z3d-z2d*z4d),@x3e,@vi2,@n4)*spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,@z5e.re,@vi1,@k))/(z4d/z5d-z3d/z2d),@z4.im,@vi3,@n2)/(z3d+z2d/z3d),@z5e.re,@vi1,@k)/((z3d+z2d)/(z4d/z5d-z3d/z2d)),@z4.im,@vi3,@n2),@x3e,@vi2,@n1),@z5e.re,@vi1,@k),@z4e.im,@vi3,@j)*spall(@ve1,k*(j+2*n1*n3-n5),@z4e,@vd3,5*k*n3+3*(n1+2*n2*k-3*n5),x3d*x2d/(x5d*x1d-x2d*x3d/(x1d-x4d)),(z3d-z2d)*spall(ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,z5e,vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d)),z1d*z2d/(z5d*z3d-z2d*z4d),x3e,vi2,n4)*(z5d-z1d)/(z2d*(z1d+z4d)-z3d/z4d),@z2.re,@vi3,@n5)/
      (z3*(z5/z2-z3/z1)*spall(@ve2,5*k-j+3,@z4e,@vd1,3*k+3,x2d-x3d,z3d+z2d*spall(@ve1,k+j,@z5e,@vd2,k+3,x1d+x2d,z1d-z2d,@z4e.im,@vi3,@j)/z3d,@z5e.re,@vi1,@k)/spall(@ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,@z1e,@vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,@z1e.im,@vi1,@n3)-z1*(z3/z2)*spall(@ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,@z5e,@vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d))/Im(-z1*spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),@z4.im,@vi3,@n2)),z1d*z2d/(z5d*z3d-z2d*z4d),@x3e,@vi2,@n4)/spall(@ve2,n2+j+1,@z2e,@vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),@z4.im,@vi3,@n2))


  spall(ve1,k+j,z5e,vd2,k+3,(x1d+x2d)/Re(-z1/spall(ve1,k+j,z5e,vd2,k+3,x1d+x2d,(z1d-z2d)/spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),z4.im,vi3,n2),z4e.im,vi3,j)),(z1d-z2d)/spall(ve2,5*k-j+3,z4e,vd1,3*k+3,(x2d-x3d)/Im(spall(ve2,5*k-j+3,z4e,vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,z5e.re,vi1,k)),(z3d+z2d/z3d)/spall(ve3,k+n1-1,z3e,vd3,2*k+3*n1-5,(x1d*(x2d-x3d)/(x5d-x2d))/(Im(spall(ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,z1e,vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,z1e.im,vi1,n3))), (z1d*(z2d-z5d/(z3d-z1d)))/spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,(x3d/(x5d-x2d/x1d))/RE(-spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,(x3d/(x5d-x2d/x1d))/(x5d*Re(-z1/spall(ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,z1e,vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,z1e.im,vi1,n3))),((z3d+z2d)/(z4d/z5d-z3d/z2d))/(z1*spall(ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,z1e,vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),
      z1+z2,z1e.im,vi1,n3)/z2),z4.im,vi3,n2)),spall(ve2,5*k-j+3,z4e,vd1,3*k+3,x2d-x3d,spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)*(spall(ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,z5e,vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d)),z1d*z2d/(z5d*z3d-z2d*z4d),x3e,vi2,n4)*spall(ve2,5*k-j+3,z4e,vd1,3*k+3,x2d-x3d,z3d+z2d/z3d,z5e.re,vi1,k))/(z4d/z5d-z3d/z2d),z4.im,vi3,n2)/(z3d+z2d/z3d),z5e.re,vi1,k)/((z3d+z2d)/(z4d/z5d-z3d/z2d)),z4.im,vi3,n2),x3e,vi2,n1),z5e.re,vi1,k),z4e.im,vi3,j)*spall(ve1,k*(j+2*n1*n3-n5),z4e,vd3,5*k*n3+3*(n1+2*n2*k-3*n5),x3d*x2d/(x5d*x1d-x2d*x3d/(x1d-x4d)),(z3d-z2d)*spall(ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,z5e,vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d)),z1d*z2d/(z5d*z3d-z2d*z4d),x3e,vi2,n4)*(z5d-z1d)/(z2d*(z1d+z4d)-z3d/z4d),z2.re,vi3,n5)/
      (z3*(z5/z2-z3/z1)*spall(ve2,5*k-j+3,z4e,vd1,3*k+3,x2d-x3d,z3d+z2d*spall(ve1,k+j,z5e,vd2,k+3,x1d+x2d,z1d-z2d,z4e.im,vi3,j)/z3d,z5e.re,vi1,k)/spall(ve1,k-5*j-2*n1*k*n1+3*n2*n3-7,z1e,vd3,5-15*k*n5-3*n1*n3*n5+3*n2*n3*n4,(x5d-x2d*x1d)/(x4d/(x3d-x2d)),z1+z2,z1e.im,vi1,n3)-z1*(z3/z2)*spall(ve3,7*n1*n2*n3*n5+3*n3*n2*m*n1*n4+10*n5*n3+15*n3+2*n1*n3*n5-15,z5e,vd1,2*k*(n1+2*n3),(x3d/x1d-x5d/(x4d-x2d))/Im(-z1*spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),z4.im,vi3,n2)),z1d*z2d/(z5d*z3d-z2d*z4d),x3e,vi2,n4)/spall(ve2,n2+j+1,z2e,vd2,2*n1+3*n2+4*n3-n4,x3d/(x5d-x2d/x1d),(z3d+z2d)/(z4d/z5d-z3d/z2d),z4.im,vi3,n2))

 3.


  spall(@ve,@vi[k+j],@z5e,@vd,@vi[k+3],@vd[2*k+3*j*k+1],@z2d,@z4e.im,@vi,@j)
  spall(ve,vi[k+j],z5e,vd,vi[k+3],vd[2*k+3*j*k+1],z2d,z4e.im,vi,j)


  spall(@ve,@vi[k+j],@z5e,@vd,@vi2[j+4+n5*k],@vd1[2*j+3*n1*k+n3],@z3d,@ve[2*k*(j+1)],@vi,@j)
  spall(ve,vi[k+j],z5e,vd,vi2[j+4+n5*k],vd1[2*j+3*n1*k+n3],z3d,ve[2*k*(j+1)],vi,j)


  spall(@ve,@vi1[3*k+5*j*k-4],@z5e,@vd1,@vi2[15],@vd[2*k+3*j*k+1],@z2d,@ve[2*k*j+n1*n2*n5-15*n3],@vi,@vi3[j+k*3*n3*n1-10*n5-1])
  spall(ve,vi1[3*k+5*j*k-4],z5e,vd1,vi2[15],vd[2*k+3*j*k+1],z2d,ve[2*k*j+n1*n2*n5-15*n3],vi,vi3[j+k*3*n3*n1-10*n5-1])


  spall(@ve2,@vi2[3*k*(j-1)+25],@z3e,@vd2,@vi3[n5], @vd3[2*j*(3*k-1)],@z3d,@ve1[3*n3*k+n2*n1*n5-15*n4],@vi3,@vi2[n1-k*20*n2*n1+7*n5*n4])
  spall(ve2,vi2[3*k*(j-1)+25],z3e,vd2,vi3[n5], vd3[2*j*(3*k-1)],z3d,ve1[3*n3*k+n2*n1*n5-15*n4],vi3,vi2[n1-k*20*n2*n1+7*n5*n4])


  spall(@ve3,@vi2[n4],@z2e,@vd3,@vi[n4], @x3d, @z3d, @x4e,@vi1,@vi3[n1-25*n3+2*k*j*n3*n5-17*n5*n3])
  spall(ve3,vi2[n4],z2e,vd3,vi[n4], x3d, z3d, x4e,vi1,vi3[n1-25*n3+2*k*j*n3*n5-17*n5*n3])


  spall(@ve3,@vi2[n4],@z4e,@vd1,@vi[n4], @vd2[n1*(n2+n3)], @z4d, @ve3[3*n1*n2+7*n5*n1*n2-15*n5*n3], @vi2, @vi3[2*n1+3*n2*n3-17])
  spall(ve3,vi2[n4],z4e,vd1,vi[n4], vd2[n1*(n2+n3)], z4d, ve3[3*n1*n2+7*n5*n1*n2-15*n5*n3], vi2, vi3[2*n1+3*n2*n3-17])





}

//pcall(ve,n,z1,vd,k,x,z2,y,vi,j)

//sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))+sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)*(exp(y*x-1))))))
//x*t-x^t*(x^(x*t-x^t*(x^(x*t-x^t*(x^t)))))
//x*t-x^(-1)*(x^(x*t-x^(-2)*(x^(x*t-x^(-3)*(x^(-4))))))
//x*t-x^7*((x*t-x^7*((x*t-x^7*(x^7))^7))^7)
//x*t-x^5*((x*t-x^5*((x*t-x^5*(x^5)+(x*(x^5))^5)^5)^5)^5)^5
//x*t-x^(-5)*((x*t-x^(-1)*((x*t-x^(-2)*(x^(-3))+(x*(x^(-4)))^(-2))^(-2))^(3))^(4))^(5)
//(x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1)
//(x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1)-((x+1)^(2*x+1)+(x+1)^(x+1)+(x+1)^(3*x+1)+(x+y)^x+(x+t)^x+(3*x+2*y-5)^(2*x+3*y-9)+(3*x+2*y-4)^(2*x+3*y-9)+(3*x+2*y-5)^(2*x+3*y-8)+(2*x*y+1)^(2*x+3*y-8)+(2*x*y+2)^(2*x+3*y-8)+(x*y+1)^(2*x+3*y-8)+(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-(2*x+y+1)^(x+2*y+1)-(2*x+y+2)^(x+2*y+1)-(2*x+y+1)^(x+2*y+2)-(x+2*y+1)^(2*x+y+1))
//(2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)-((2*x*y+1)^(2*x*t+1)+(2*x*y+1)^(3*x*t+1)+(2*x*y+1)^(2*x*y+1)){!!!!!XCH no error so as big number}
//-(2*tan(x-5)/cotan(x-5)^3-(2*tan(x-5)-1)^3/cotan(x-5)^5-7/cotan(3*x-y+1)^3)/tan(3*x*y+1)^5-3*(4*tan(3*x-y+1)^3+2)/(2*cotan(x-5)-1)^3*(2*x*cotan(x-5)^5-5)-x*(-(2/tan(x-5)*(-cotan(x-5)^3)-(2/tan(x-5)-1)^3*cotan(x-5)^5-7*cotan(3*x-y+1)^3)*tan(3*x*y+1)^5-3/(4*tan(3*x-y+1)^3+2)*(2*cotan(x-5)-1)^3/(2*x*cotan(x-5)^5-5))
//sin(x)*cos(x)+sin(x+1)/sin(x)+cos(x+1)*cos(x)
//(sin(x)+cos(x)*x+(sin((cos(x+2)+x*sin(x+2)+x/(sin(x)+cos(x)+cos(x+2))-sin(x+2))*sin(2*cos(x+1)+1))+cos(x+1)+(cos((sin(cos(x+1))+2*cos(2*sin(x+1)+1)+sin(2*cos(x+1)+1))))))
//x/sin(x)-cos(x)/(4*sin(x+1)-3)/(2*cos(2*sin(x)+1)-3)-(-(-sin(2*cos(x)+1)-1)-(-2*sin(2*sin(x)+1)))/(-sin(2*cos(x+1)+1)-x/(3*sin(2*sin(x+1)+1)-4)-5/(4*cos(x)*sin(x+1)/(5*sin(2*cos(x+1)+1)))-5-(4*cos(2*sin(x+1)+1)+1)/sin(x+1)*(-cos(x+1)+2)/x/cos(2*cos(x+1)+1))-2*sin(2*cos(x)+1)*cos(2*sin(x)+1)/(2-sin(2*sin(2*sin(x)+1)*3*cos(2*cos(x)+1)))
//sin(2*x*y+1)*cos(2*x+y+1)/(3*cos(2*x*y+1)-4*sin(2*x+y+1))

//1/sin(x)-(-cos(x)-sin(x)^(-1))/cos(x)^(-1)-cos(2*sin(x)^(-1))*sin(2*sin(x)^(-1))/(cos(2*sin(x)^(-1))-sin(2*sin(x)^(-1)))
//sin(x)^(-1)-cos(x)^(-1)-(cos(sin(x)^(-1))^(-1)-sin(sin(x)^(-1))^(-1))-(sin(sin(x)^(-1))^(-1)-2*sin(sin(x)^(-1)))
//(sin(cos(sin(x)))+cos(sin(x)))/(sin(cos(sin(x)))-cos(sin(x))-sin(cos(x)))-cos(x)*cos(sin(cos(x)))-sin(x)/(cos(sin(cos(x)))+cos(x))
//x/sin(2*cos(2*x)+1)-cos(x+1)*cos(2*x)-sin(2*x)/(cos(sin(2*x))-sin(x+1)*sin(2*cos(x)+1))-cos(sin(2*x))*sin(2*cos(2*x)+1)
//1/tan(x)-(-cotan(x)-sin(x)*(tan(x)^(-1)-1/cos(x)^2))-(cos(x)-x*(-cotan(x)^(-1)-sin(x))/tan(x)^(-1))
//arcsin(x/5)^x-1/arccos(x/5)-(-arcsin(x/5)-arccos(x/5)^x)/(arcsin(x/5)^x+arccos(x/5)^x)

 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)
 //(-sin(x)^(-1))-cos(x)^(-2)/sin(x)^(-3)+sin(x)^(-1)-cos(x)-(-sin(x)-cos(x)^(-2))/sin(x)^(-3)
 //(-arccotan(x)^(-1))-arctan(x)^(-2)/arccotan(x)^(-3)+arccotan(x)^(-1)-arctan(x)-(-arccotan(x)-arctan(x)^(-2))/arccotan(x)^(-3)
 //(-arctan(x)^(-1))-arccotan(x)^(-2)/arctan(x)^(-3)+arctan(x)^(-1)-arccotan(x)-(-arctan(x)-arccotan(x)^(-2))/arctan(x)^(-3)
 //arctg(x)^(-1)/(-arcctg(x)^(-2))+arctg(x)^(-2)/arctg(x)^(-1)
 //power(sin(x),(-1))/power(cos(x),(-2))/power(sin(x),(-3))/power(sin(x),(-1))/cos(x)/sin(x)/power(cos(x),(-2))/power(sin(x),(-3));
 //sin(x)^(-1)/cos(x)^(-2)/sin(x)^(-3)/sin(x)^(-1)/cos(x)/sin(x)/cos(x)^(-2)/sin(x)^(-3)

 //(cos(x)^(-1)+sin(x)^(-1))/(sin(x)^(-1)-cos(x)^(-1))
 //(cos(x)^(-2)+sin(x)^(-2))/(sin(x)^(-2)-cos(x)^(-2))
 //-cos(x)^(-1)-(-cos(x)^(-2))+sin(x)^(-1)*sin(x)^(-2)/(-cos(x)^(-2))*sin(x)^(-1)
   //(sin(x)^(-2)+cos(x)^(-2))/(sin(x)^(-1)+cos(x)^(-1))
   //(1/sin(x)^2+1/cos(x)^2)/(1/sin(x)+1/cos(x))

 //sinh(x)/(-exp(x))+cosh(x)/(sinh(x))-exp(x)/cosh(x)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)^(-n)/(-exp(x)^(-k))+cosh(x)^(-k)/(sinh(x)^(-n))-exp(x)^(-n)/cosh(x)^(-k)-sinh(x)*cosh(x)/exp(x)
 //sinh(x)*(exp(x)^(-1)+cosh(x))-tanh(x)^(-1)/(-cotanh(x)^(-1)/exp(x)-cosh(x)^(-1))+tanh(x)/exp(x)^(-1)
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1))))/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1)+sinh(exp(x-1))))
 //tanh(x+1)^(k+1)-(-1/exp(x)-(-exp(x+1)^(-1)-sinh(exp(x-1))))-sinh(x)/(tanh(x+1)+cosh(x+1)^(k+1)/cosh(x))-cotanh(x)^(k+1)/(cotanh(x+1)-tanh(x+1)/sinh(x)-(-exp(x+1)^(-2)/cosh(x+1)^(k+1)))-(-exp(x)^(-1)*cotanh(x+1)/cotanh(x)^(k+2)-tanh(x+1)^(k+1))-(x/cosh(x)^2)-cosh(exp(x-1))/sinh(exp(x-1))/(tanh(exp(x-1))-exp(x-1)^2/cotanh(exp(x-1)))-(cosh(exp(x-1))+sinh(exp(x-1)))-1/exp(x-1)-exp(x-1)^2-1/exp(x+1)^(-1)*(-tanh(x+1)^(k+1)-1/cosh(x+1)^(k+1)-1/sinh(exp(x-1)^2))-(sinh(exp(x-1))-1/cosh(exp(x-1))^2)
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)-sinh(x)*cosh(x)/exp(x)
 //tanh(x)-exp(x)/(cosh(x)+exp(x)*tanh(x))+sinh(x)/(cotanh(x)-tanh(x))-exp(x)*(cosh(x)+tanh(x)+cotanh(x)+sinh(x)+exp(x))
 //sinh(x)+exp(x)*sinh(x)^2-cosh(x)/(cosh(x)^2+tanh(x))-exp(x)^2*sinh(x)^2
 //sinh(x)+cosh(x)+cosh(x)^t-sinh(x)/(cosh(x)^t+exp(x))
 //exp(x)*sinh(x)-cosh(x)/(exp(x)+sinh(x)-cotanh(x))
 //sinh(x)/(-exp(x))+cosh(x)/(-sinh(x))   !!!
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(-sinh(x)^(-1))
 //sinh(x)^(-1)/(-exp(x)^(-2))+cosh(x)^(-2)/(sinh(x)^(-1))-exp(x)^(-1)/cosh(x)^(-2)


//x=2; y=5; x=(x/y+y/x)/(x/y-y/x); y=(y/x)*(x/y-y/x); y=x*y/(x/y-y/x)+x/(x*y/(x/y-y/x)); x=(x/y-y/x)/(y/x+x/y)+x*y/(x/y-y/x); x+y

//x*(-(x*y+x))-2/(-3*x-y-t/x-(-sin(x/(-(x*y+x))-(-t-1)+1)-t)/x)-(-(-1-t)/x*2+3*x/y/t-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9) {!!! (8)}
//sin(a*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))

//2/sp2(x-cos(y)*sin(-y*sp2(x*t,cos(y*sp2(2-x/t,t)/x*sp2(2-x,3*sin(x))/(2+x)))),y/sp2(x*cos(y),cos(y)*sp2(cos(y),sin(x))))
//x+y+(2+x+1)+(2+x+y-t-2+x+(3+t-1)-(2+x-3+y-4)+(x-(3+x-1)-4-x+5+(2+x+y+t-1)-(y+1)-7+(2+x+(y+1)+(3+y+2)+(3-(x+1)-2+t-(2+x+y+t-1)+(4+x-1)+(5+y-7)-(x-2+y-1-2+t-(3-7+x-8+y+(4+x-(2+t+1)-7+x-8-t+9+(2+x-1)+(3+x+4+y+5)+(2+x+y+t-7)+x+y+t-(x-y+2-3-(x-(t-1)-7-(y+2)+8-(2+x+y+t+1)-9)))))-(x-1)))))


//sin(x)-(-(sh(x)+cos(x)))
//x*y-x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y+(x*y+x*y+(x*y-x*y+(x*y+(x*y+(x*y-x+(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y+(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)
//x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y-(x*y+(x*y-(x*y-x+(x*y+x*y-(x*y+(x*y-(x*y+x+y+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y+(x*y+(x*y-(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x+(x*y+x*y)-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y+(x*y+(x*y+(x*y+x+y-(x*y-x*y+(x*y-x*y+(x*y-(x*y+(x*y-x-(x*y+x*y)+(x*y-x*y+(x*y-x*y+(x*y-(x*y-(x*y-x+(x*y+x*y+(x*y-(x*y-(x*y+x+y)))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)))))))+y)+y)+y)))+y)+y)+y)



//sin(-a/b-1)*(c+1)^(1+d)-tan(c*(-d)^(2+c))-(2*a+3)^(b+1)-(-a+1/sin(b^(-c)+3^(-d)-d^(-5)))
//x^y*sin(x*y)-(-x/y-y/x-(-a/(-x-(-x-y))))/(-(-2-a/b*(-x*y/b))+(-(-x/y)))
//sin(x)+(-(x/y))



 //pc2(x*sp1(x*y)-pc2(x*(x-y),x+y),pc2(-x,-y-x-1))
 //pc2(y-pc2(x-y,x+y),pc2(x,y-x-1))
 //pc2(pc2(x-y,x+y),pc2(x,y-x-1))
 //pc2(pc2(x-y,x+y),pc2(x,y-x))

 //sp3(sp1(x*sp1(-sp2(x*(x+y),-x*2)-3-y)/x)-sp2(x*sp1(x*y)-sp2(x*(x-y),x+y),sp2(-x,-y-x-1)*2-3),x*y,-sp2(x*2-y*x/2,x*y))
 //ps3(ps1(x*ps1(-ps2(x*(x+y),-x*2)-3-y)/x)-ps2(x*ps1(x*y)-ps2(x*(x-y),x+y),ps2(-x,-y-x-1)*2-3),x*y,-ps2(x*2-y*x/2,x*y))
 //pc3(pc1(x*pc1(-pc2(x*(x+y),-x*2)-3-y)/x)-pc2(x*pc1(x*y)-pc2(x*(x-y),x+y),pc2(-x,-y-x-1)*2-3),x*y,-pc2(x*2-y*x/2,x*y))


 //sp3(t*sp2(x,t),-sp4(x,2,5,t),sp3(-x,y*sp1(x*sp2(x,y*sp3(1,2,t*sp1(5)+sp2(-x,y)))),1-sp2(-x,-1-y))*x)*sp2(x-sp3(x,-y,-5),sp4(x,y*x,-t,-t-5)-sp2(x,-t-3*sp4(3,x,y,t))*x)
//ps3(t*ps2(x,t),-ps4(x,2,5,t),ps3(-x,y*ps1(x*ps2(x,y*ps3(1,2,t*ps1(5)+ps2(-x,y)))),1-ps2(-x,-1-y))*x)*ps2(x-ps3(x,-y,-5),ps4(x,y*x,-t,-t-5)-ps2(x,-t-3*ps4(3,x,y,t))*x)
//pc3(t*pc2(x,t),-pc4(x,2,5,t),pc3(-x,y*pc1(x*pc2(x,y*pc3(1,2,t*pc1(5)+pc2(-x,y)))),1-pc2(-x,-1-y))*x)*pc2(x-pc3(x,-y,-5),pc4(x,y*x,-t,-t-5)-pc2(x,-t-3*pc4(3,x,y,t))*x)
//sa3(t*sa2(x,t),-sa4(x,2,5,t),sa3(-x,y*sa1(x*sa2(x,y*sa3(1,2,t*sa1(5)+sa2(-x,y)))),1-sa2(-x,-1-y))*x)*sa2(x-sa3(x,-y,-5),sa4(x,y*x,-t,-t-5)-sa2(x,-t-3*sa4(3,x,y,t))*x)
//sa3(t*sp2(x,t),-sp4(x,2,5,t),sp3(-x,y*ps1(x*pc2(x,y*sp3(1,2,t*sa1(5)+pc2(-x,y)))),1-sp2(-x,-1-y))*x)*sp2(x-sp3(x,-y,-5),ps4(x,y*x,-t,-t-5)-pc2(x,-t-3*sa4(3,x,y,t))*x)


 //res:=sp4(3*sp4(x*sin(x),2-sp4(x*(x*y-t),x*y*(x+y),x*(x+(x+t))+2,x*y*sin(x*y-2*sp4(x*y,t-(y*(x+y))+3,x+y,t*y)+4))*x+y,x*t+2*sp4(3*sp4(sin(x),x*(x-(x+y*2)+t)+y,x*(x-(x*y-t*3)/y)+x,cos(x)*x),sin(y)*cos(t),x-sin(y)-sp4(x-sin(t),-cos(y),-x-sin(y)*cos(y),x*(x+(-y-t)))+3,x/sin(y)-cos(t)/(x-sin(t)))+2*sp4(x*y-t-x/sp4(7.5,x*(x+y*(x-t)/cos(x)),-sin(x),-cos(x)-x*(x-y*(x+y*t))-x),-x*(2*sp4(x*y,x-y,t-x,-y-1)+3),sp4(-x*(x*(x-t)-y),-y*sin(x),-t-x*y,t*x-y)-sin(x)*sp4(-x*(x*(x+t*y)),x*y-x*t,-t-y*x*(x-t*y),-t),x*y*cos(t)+2),sin(t)*sin(x)*(x+y*t)),y*(x*sin(x)+y*t),y*cos(t)+x*y,-t)

 //pc4(3*pc4(x*sin(x),2-pc4(x*(x*y-t),x*y*(x+y),x*(x+(x+t))+2,x*y*sin(x*y-2*pc4(x*y,t-(y*(x+y))+3,x+y,t*y)+4))*x+y,x*t+2*pc4(3*pc4(sin(x),x*(x-(x+y*2)+t)+y,x*(x-(x*y-t*3)/y)+x,cos(x)*x),sin(y)*cos(t),x-sin(y)-pc4(x-sin(t),-cos(y),-x-sin(y)*cos(y),x*(x+(-y-t)))+3,x/sin(y)-cos(t)/(x-sin(t)))+2*pc4(x*y-t-x/pc4(7.5,x*(x+y*(x-t)/cos(x)),-sin(x),-cos(x)-x*(x-y*(x+y*t))-x),-x*(2*pc4(x*y,x-y,t-x,-y-1)+3),pc4(-x*(x*(x-t)-y),-y*sin(x),-t-x*y,t*x-y)-sin(x)*pc4(-x*(x*(x+t*y)),x*y-x*t,-t-y*x*(x-t*y),-t),x*y*cos(t)+2),sin(t)*sin(x)*(x+y*t)),y*(x*sin(x)+y*t),y*cos(t)+x*y,-t)



//-(-x/vd[k]*ve[j]-(-vd[k+1]/ve[k+2]^3-vd[5]^2))
//-(-vd[-[-x^2]]*ve[2*[x*2]-k]^k)
//-(-x/vd[1]*ve[1]-(-vd[1+1]/ve[1+2]^3-vd[5]^2))
//vd[[t+1]]
//vd[[t]]
//-((-y)/x-(-a)*y-(-x-y))-(-y-(-2-x/(-y*x-x*a-b/y*(-x*(-y)*(a*x-b/(-y)*x*c-c-x)-x/y)+c/x-d/x-y/(c*x))+x*(-y-x*a-b)*c/(y+x*y-(-c*y))-y*(-2-x)-(-(-x-5-y))-3)-4/y*(-(-(-7-(-x))/y-5)-y)+x)
//-((-z2)/z1-(-a)*z2-(-z1-z2))-(-z2-(-2-z1/(-z2*z1-z1*a-b/z2*(-z1*(-z2)*(a*z1-b/(-z2)*z1*c-c-z1)-z1/z2)+c/z1-d/z1-z2/(c*z1))+z1*(-z2-z1*a-b)*c/(z2+z1*z2-(-c*z2))-z2*(-2-z1)-(-(-z1-5-z2))-3)-4/z2*(-(-(-7-(-z1))/z2-5)-z2)+z1)
//-((-z2)/z1-(-a)*z2-(-z1-z2))
//z1*(-z2-z1*a-b)*c/(z2+z1*z2-(-c*z2))-(z2*(-2-z1)-(-(-z1-5-z2))-3)-4/z2*(-(-(-7-(-z1))/z2-5)-z2)
//-2-z1-(z1-i-(2-z2-(z1*(i+2)-(x+z1)-(x-i)-x))*x-(z1-x-(z2*i-z1*2-(z1-z2)-(x-(x-z2*i-i*(x/z1))))))
//2/(-3*x-z1*2-t/z2-(-sin(z1/y-(-z2-1)+1)*i-z1*2)/z2)-(-(-1-x-z2)/z1*2+3*x/z1/z2-cos(-(-z1-z2)/(-(-x+z1*2)-x*z2-x-z1)-1)/(x*z1+y*t/3-z2/4)*x*z1)
//2/(-z1)/(-3*(-z1)-z2*(-z2)/(-(-z1))-z1/x-(-1/(-sin(z1/y-(-z2-1)+1)-z1-t)/x/z2)+y*(-(-z1)))-(-(-1-z1)/z2*2+3*x/(-z2)/(-(-(-z1)-2-x*z2)-z1)-cos(-(-z2-z1)/(-(-t+z1*2)-x-z2)-1)/(x+y*z1/3)*x+i)-sin(-i-t-(-x/i-(1-y*i)-3*i-i-(-x*2-i))/z1/(-y/(-z1)-x)-1-2*i)
//2*x/z1-z1*x/(y+z1)-Re(z1*x-Im(z1*(x-i/(z1-2/z1*Re(x*(z1-z2*(Re(i*Im(-z1-x*i))-(-i)*x)))-1+2*i)-i*(x-2/z2))-x*(z1-z2)+2)-i)
//(-2-z1/(-z2*z1-z1*a-b/z2*(-z1*(-z2)*(a*z1-b/(-z2)*z1*c-c-z1)-z1/z2)))
//(-2-z1*(-z2*z1-z1*a-b*z2*(-z1*(-z2)*(a*z1-b*(-z2)*z1*c-c-z1))))
//(-z2*z1-z1*a-b/z2*(-z1*(-z2)*(a*z1-b/(-z2)*z1*c-c-z1)))
//(z2*z1-z1*a-b*z2*(-z1*(-z2)*(a*z1-b*(-z2)*z1*c-c-z1)))
//(z2*z1+z1*a+b*z2*(z1*(z2)*(a*z1+b*(z2)*z1*c+c+z1)))
//z2*z1+z2*(z1*(a*z1))
//sin(z1+5)^((sin(z2)^cos(x))^(sin(x+1)^cos(z2+1)))+sin(x+5)^((sin(x)^cos(z2))^(sin(z1+1)^cos(y+1)))
//-(-x-z1-sin(x-z2)-7+8*i)-(-(-cos(x)/z2-(-(-x+i))/sin(z2)-5-x/sin(z1)-(-1/x-4+1/z2-sin(z1))))
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1);
//2/(-x-(-sin(x*(3-t-(4*t-(-((x*(-sin(x-(-3*t-(2*x-t))*(1-sin(x-2*(-t-(2*t+1))-t)^x)-x^t)/(x^t)+(t*(-x)-t)-((x+1)-t/(x+t))^x-(2*t-7)/(2*sin(x)+t))-t*(-t-7)^x*(x*t)-7*t-8)-(t*(-x-t)^x*t^x*(x+1)-(t+1)-t))-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x)))))
//2/(-x-(-sin(x*|3-t-[4*t-(-|t-[x*{-sin(x-{-3*t-|2*x-t|*[|-y-t|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-|x^{t*y}-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))
//2/(-x-(-sin(ve[x]-vd[k]^2-vd[3]-x*|3-t-vd[k]^2*[4*t-(-|ve[k]-t-[vd[y]*x*{-sin(vd[2]*ve[y]-{-vd[3]*t-|2*x-t-||vd[|-x|]|^|vd[k]|||*[|-y-t-vd[k]|-|-{x+t}-[|t-y|^x-[x+t]^|{t-y}^[y*t]-|t*x-y|^|y-x|*(x+t)-1|+t]-y|]}*{1-sin(x-2*[-t-|2*t+1|*|t-y*sin(x)^[y*2-x*{t+1}]|^[y-t*2]^2-vd[{t*y}*2]-|x^{t*y}-[vd[x*k]^2-|t-y|^vd[2]]-|-t-y||^3]-t)^x}-x^t)/[x^t]+|t*(-x)-t|-{-|x+1|-t/(x+t)}^x-(2*t-7)/(2*sin(x)+t)}-t*|-t-7|^x*(x*t)-7*t-8]-(t*[-x-t]^x*t^x*(x+1)-(t+1)-t)|-(x*(-(x-(-(2*sin(x)-t)^x-(t+1)*(2*t+7)^x-(t+1)^x))*(2*t+1)^x-(4*t-3)^x*(-(-t)-t/(x+t)^x-(-x-(2*(x+t)^x-3*(t+x)/(-sin(t))-(t*2-x)^x)/(7*t-1)-(2*t+1)^x)-(2*t-1)^x-(-x*t-1))*(-x*t+1)^x-x/(x-t)^x-y*(-x*t-1))-(-(x+t)/(x-t)+(y-t)^x))-(-t-x-(-(x+t)-(x-t)^x)*t)-t)*(x-t)^x]|)))


//(arcsin(cos(x))-arccos(sin(x)))*(arcsin(sin(x))-arccos(cos(x)))

//2/(-z1)/(-3*(-x)-x*(-z1)/(-(-z1))-z2/x-(-1/(-sin(x/z1-(-t-1)+i)-t)/z2)+z1*(-(-t)))-(-(-1-z1)/x*2+3*z2/(-y)/(-(-(-z1)-2-z2)-y-i)-cos(-(-x-z1)/(-(-z2+x*2)-x)-i)/(z2+y*z1/3)*z1)-sin(-t-(-z1-(1-z2)-i-(-x*i))/z1/(-y/(-z1)-z2-x)-1)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/z1-(-t-1)+i)-t)/x)+y*(-(-t)))-(-(-1-t)/z2*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-z1)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1)
//2/(-z1)/(-3*(-x)-y*(-z2)/(-(-t))-z1/x-(-1/(-sin(x/y-(-t-1)+1)-z2)/x)+y*(-(-t)))-(-(-1-z1)/x*2+3*x/(-y)/(-(-(-z1)-2-x)-y)-cos(-(-x-z2)/(-(-t+x*2)-x)-1)/(x+y*t/3)*z1)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-z2)-x)-1)
//x*Re(-x-(i-z1*(x*i/Im(z1/(1-x*(z1/x/z2-2*(-x-z1*(Im(z1*Re(x-i*z1-2)))-x/(x-i)*2-i*(Im(z1*(2-x)-i*(z1-x))*z1-Re(i-x*z1-i/(z1-z2))*i)-z1)-i*x)-(1-x*Im(z1-z2-i/x)-i)-z2/z1)-x/z1)-z2/x)-z2/i)-i/z1)/z1-z2*Im(i*x+z1-2+3*y/z1*z2)
//-((-z2)/z1-(-a)*z2-(-z1-z2))-(-z2-Re(-2-z1/Im(-z2*z1-z1*a-b/z2*Re(-z1*(-z2)*(a*z1-b/(-z2)*z1*c-c-z1)-z1/z2)-c/z1-d/z1-z2/Im(c*z1))-z1*Re(-z2-z1*a-b)*c/Im(z2-z1*z2-Re(-c*z2))-z2*(-2-z1)-(-Im(-z1-5-z2))-3)-4/z2*(-(-(-7-(-z1))/z2-5)-z2)-z1)

//-(-i*(-z1-i*Im(2-i/z1)/z1*(-i-2-x*(im(x-i/z1-re(3-i/(x*z1/y-3/z1/i*x*(x/i-i-7/z1*i))-(z1*(-(-x-z1-i-8)*z1/i*x/(x*y/i-z1))-i/im(i/x*8-7/i*z1*x-7/i)+re(x/2-z2/3+5/(z1-z2*x)/i)/i/z1/x/2)/i)*(-i-(-2-(-x-z2*(3-z1/z2-z1/i-(i/(z1/x-(z1*x-2)/i)/i-8)-7)*7/i)-x*i/z1)*(x-i*z1-5*i+6)+x*(i*z1-z2-1))-i/re(x*i+3/(x*y-z1)*z1)))-re(i*im(z1/(-(x*z1-i))-(i*x-z1)/(z1*z2/i-i)*(i/8)+8+i*x))*(-x/z1-z2*(-i/x-x/i+i/z1+i*z1))-x/i*z1-i*t/z1)))

//2/(-z1)/(-3*(-z1)-y*(-y)/(-(-t))-t/z1-(-1/(-sin(z1/y-(-t-1)+1)-t)/z1)+y*(-(-t)))-(-(-1-t)/z1*2+3*z1/(-y)/(-(-(-t)-2-z1)-y)-cos(-(-z1-y)/(-(-t+z1*2)-z1)-1)/(z1+y*t/3)*z1)-sin(-t-(-z1-(1-y)-3-(-z1*2))/z1/(-y/(-z1)-z1)-1)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-z1))-z1/x-(-1/(-sin(x/y-(-z1-1)+1)-z1)/x)+y*(-(-z1)))-(-(-1-z1)/x*2+3*x/(-y)/(-(-(-z1)-2-x)-y)-cos(-(-x-y)/(-(-z1+x*2)-x)-1)/(x+y*z1/3)*x)-sin(-z1-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1);
// ((z1/z2)*sin(z1/z2)+cos(z1/(z1+z2))*(z1/(z1+z2)))*((z2/z1)*sin(z1/z2+z2/z1)+cos(z1/(z1/z2+z2/z1)+z2/(z1+z2)))+cos(z1/(z1+z2))*sin(z1/z2)*sin(z1/z2+z2/z1)


//x+y+x+y+(x+(y+x+(x+y+(x+y)+y+x+y+(x+y+x+(x+y+(x+y+(x+(x+y+x+y+(x+y+(x+y+(x+(x+y)+x)+x)))+y)+x)+y)+x+y)+x+y+x)+y+x)+y)

//2*sin(x-cos(tan(2*t^(2*x/sin(x))-t)^3)^5)
//a*x*(b*y-(c*y/x-c)/y+c*y)-x/y-x*(c*(x*y-t*(x*a-b-y+b/t)))*(c*x-t)
 //x*y+x/y*(x+(y/x+(x+y/(x+y)*y+x*y*(x/y+x/(x*y+(x+y/(x*(x*y+x+y*(x*y+x))/y)*x)/y)+x*y)+x+y/x)/y*x)+y)
 //x+y+x+y+(x+(y+x+(x+y+(x+y)+y+x+y+(x+y+x+(x+y+(x+y+(x+(x+y+x+y+(x+y+x))+y)+x)+y)+x+y)+x+y+x)+y+x)+y)
 //x*y+x+y*(x+(y+x+(x+y+(x+y)*y+x*y*(x+y+x+(x*y+(x+y+(x*(x*y+x+y*(x*y+x))+y)*x)+y)+x*y)+x+y+x)+y*x)+y)
 //x*y+x*y*(x+(y*x+(x+y*(x+y)*y+x*y*(x*y+x*(x*y+(x+y*(x*(x*y+x+y*(x*y+x))*y)*x)*y)+x*y)+x+y*x)*y*x)+y)
 //res:=2/(-3*x-y-t/x-(-sin(x/y-(-x-1)+1)-y)/t)-(-(-1-x)/y*2+3*x/y/t-cos(-(-x-y)/(-(-x+y*2)-x)-1)/(x+y*t/3)*x);
  //res:=2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1);

//x*y*(2*x+1)*(2*x*y/t-2*x*(3*t-1)/(2*x-3*y-4)*(x/(3*x-1)-4/x+5*(2*x*y*t-1)/(y+1)-7*(2*x*(y+1)*(3*y+2)*(3/(x+1)-2*t/(2*x*y*t-1)+(4*x-1)*(5*y-7)/(x-2*y-1-2*t/(3-7*x-8*y*(4*x/(2*t+1)-7*x-8/t+9*(2*x-1)*(3*x+4*y+5)*(2*x*y*t-7)*x*y*t/(x-y*2-3/(x/(t-1)-7/(y+2)+8/(2*x*y*t+1)-9)))))/(x-1)))))
//x*(2*x+1)*(x*t+y)/(3*x-1)*(t-1)-(2*x-1)/t*(4*t+5)*(3*x+4)*y/(x+y+t/(x+2))*(y+1)*x
//2/(-3*x-y-t/x-(-sin(x/y-(-x-1)+1)-y)/t)-(-(-1-x)/y*2+3*x/y/t-cos(-(-x-y)/(-(-x+y*2)-x)-1)/(x+y*t/3)*x)
//2/(-x)/(-3*(-x)-y*(-y)/(-(-t))-t/x-(-1/(-sin(x/y-(-t-1)+1)-t)/x)+y*(-(-t)))-(-(-1-t)/x*2+3*x/(-y)/(-(-(-t)-2-x)-y)-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)-sin(-t-(-x-(1-y)-3-(-x*2))/x/(-y/(-x)-x)-1)
//-(-x)-(-x/(-x-1-y)-t)*(-(-(-x-1)-y-y-1)/(-y)*t/(-y)-y)*(-(-sin(x)-1-x)-y*x/(-y)/(-y)-(-(1-cos(x)-x)-y)/sin(x)+(-(-x*x-y-y+1)-sin(y)/(-t-(-x)-1)*y)*y+(x-(-sin(x)-1-y)-t/(-t*x/(-y)-1)-1)-x-1)
//x*(-(x*y+x))-2/(-3*x-y-t/x-(-sin(x/(-(x*y+x))-(-t-1)+1)-t)/x)-(-(-1-t)/x*2+3*x/y/t-cos(-(-x-y)/(-(-t+x*2)-x)-1)/(x+y*t/3)*x)
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9)
//sin(c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))
// 2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*t^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+1)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tg(x)-(-1/x-4+1/t-sin(y))))
//sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))+sin(x+5)^((sin(x)^cos(y))^(sin(x+1)^cos(y+1)))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)*(exp(y*x-1))))))
//x*t-x^t*(x^(x*t-x^t*(x^(x*t-x^t*(x^t)))))
//x*t-x^(-1)*(x^(x*t-x^(-2)*(x^(x*t-x^(-3)*(x^(-4))))))
//x*t-x^7*((x*t-x^7*((x*t-x^7*(x^7))^7))^7)
//x*t-x^5*((x*t-x^5*((x*t-x^5*(x^5)+(x*(x^5))^5)^5)^5)^5)^5
//x*t-x^(-5)*((x*t-x^(-1)*((x*t-x^(-2)*(x^(-3))+(x*(x^(-4)))^(-2))^(-2))^(3))^(4))^(5)
//-(-x-y-sin(x)-7+8)-(-(-cos(x)-(-(-x+1))-5-tg(x)-(x-4-sin(y))))
//-(-x-y-sin(x)-7+8)-(-(-cos(x)/x-(-(-x+1))/sin(t)-5-x/tg(x)-(-1/x-4+1/t-sin(y))))
//5/((2/x-3)/sin(5/y+3)-2*sin(7/sin(1/(2*x+3)+4)-3/(7-5/(2*x+3)*sin(3/x+5))-3))-3*sin(2*x+3)*(3*y+4)/sin(3/x-2)+4*(2*x+3)*(3*y+4)/(5*x+6)-6*sin(x)/(7*sin(3/x-2)*sin(3/(2*y-3)-4)/(2*x+3)-2*sin(2*x+3)*(3*y+4)/sin(1-5/(2*y+3)))*(2*sin(2/x-3)*(2/sin(2*x+3)-3*sin(2/x-3)/(2*x+3)+4*(3*y-2)/sin(2*y-3)/sin(sin(2*x+3)*sin(3*y+4)/(5*x-7)-7*sin(2/x-3)/(2*y+3)-5*sin(2*x-3)*(2*y-5)/sin(2/x-4))))


//sin(x*(y*x)^cos(-x^(sin(x^(-6)+x)*y+t)+t)+x*(y*x)^cos(-x^(sin(t^(-6)+x)*x+y)+t))
//x*y*(x+y/t-t*y*x*(x+y-t)*x*t*(x+t)*(x+y)/(x+t-y)-t/(x+y)+t*(x+y)/x-(x-y)/t)*(x-t)*(x+y+t*x-y*t)/(t+y/x-t/y)-x*y*(x+t)*(x-y)*(t/(x-t+y)-x*(t+x)/(y-t+x))+(x+y+t+(x-t)*(x+y)-(x+y)/(x-t)-x*y/(t-x))
//(x*(2*x+3)*(4*t+5)*y*t/(7*y+1)+8)*(7*x*y*(2*x+1)*(2*x*y*t-1)/(3*x-4*y+5*t-7)-9)/(4*x*y*(7*x+1)*(9*t+2)*(5*y-9)*(7/(2*x+3)-8/x-9/(2*x*y*t-1)+1))-((2*x+3)/x-t/(4*x+5)-(2*x*y-1)*(3*x-4*y+5*t-7)*x*y/(5*x-7*y+8)-9)*(5*x+1)*(7*y-9)*(7*t-1)/(x/y-t/x+1)
//x-(-(7-(-sin(x)-1)-8*y+y-cos(x)))
//7-x-(-(-x-1)+cos(x)-1-sin(x)-2*t-(-cos(y-(-(1-sin(t)-x)))))+2*y-t
//1-(-(-x-(-5-x-t+7*t-8)/x-9/(-x)+t/5*x/8*y-9)-7-(x-8)/9)
//sin((a*x+b*y+c)-(a*x*y*t-d)+d*x-e)
//((x+sin(x)+3)*2*x+2*sin(x)+x+5)*2+sin(x)*x+2*sin(x)+5*sin(x)*sin(x)*x+5+x+2*(sin(x)*sin(x)*sin(x)+x*sin(x)+x+5)
//x*(2*x+3)*(3*y+4)*(4*x*y+5)+t*(2*t+3*y+4*x+5)*(2*x*y*t+3)+t*(2*x+3*y+4)*(5*x+6)-7*(5*x*y*t-8-7*x-8*y-9*t)*(2*x+3*t+4*y+5)
//sin(c*(a*x)^cos(-x^(sin(c^-6+x)*c+b)+d))
//sin(c*power(a*x,cos(-power(x,(sin(power(c,-6)+x)*c+b))+d)))
//sin(c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d)+c*(a*x)^cos(-x^(sin(c^(-6)+x)*c+b)+d))
//sin(c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d)+c*(a*y)^sin(-y^(sin(c^(-6)+y)*c+b)+d))
//sin((x)^a+(x)^b)
//sin(b+b*x^7+x^6)
//a*x^7+x^6
//sin(a*(sin(a*(sin(a*(sin(a*(b*x+d)^b+c))^b+c))^b+c))^b+c)
//sin(a*sin(a*(sin(a*(sin(a*(x)^2+b)^2)^2+b)^2)^2+b)^2+b)^2
//sin(a*sin(x)^2+b)
//sin(a*(sin(b*x+c)^2)^2+d)
//sin(a*(sin(sin(a*(sin(b*x+c)^2)^2+d))^2)^2+d)
//power(sin(a*power(sin(a*(sin(a*(sin(a*(x)^2+b)^2)^2+b)^2)^2+b),2)+b),2)
//sin(a*(sin(a*(x)^2+b)^2)^2+b)^2
//(a*sin(a*(sin(b))^2+b)^2+b)^2
//(a*(sin(a*(sin(b))^2+b)^2)+b)^2
//(sin(a*(sin(b))^2+b)^2)^2
//sin(a*power(power(sin(a*x+b),2),2)+b)
//2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6
//sin(sin(sin(sin(x)^2+sin(x)^2)^2+sin(sin(x)^2+sin(x)^2))+sin(sin(sin(x)^2+sin(x)^2)^2+sin(sin(x)^2+sin(x)^2)))^2
//power(sin(a*power(sin(a*power(power(sin(a*power(power(sin(a*x+b),2),2)+b),2),2)+b),2)+b),2)
//sin(cos(tan(x/2+3)^5)^5)^5
//sin(sin(sin(sin(a*x+b)^5+sin(c*x+d)^5)^5+sin(sin(d*x+e)^5+sin(c*x+b)^5))^5+sin(sin(sin(d*x+e)^5+sin(a*x+b)^5)^5+sin(sin(d*x+e)^5+sin(c*x+d)^5)))^5
//(a*sin(a*sin(a*sin(x)^2+b)^2+b)^2+b)^2
//sin(sin(a*sin(a*x+b)^2+b)+sin(a*sin(a*sin(a*x+b)^2+b*sin(c*x+d)^2)^3+b)^5)^2+sin(sin(a*sin(a*sin(b*x+c)^2+b)^2+d)^2+sin(a*sin(a*sin(b*x+c)^2+d)^2+b)^2+sin(a*sin(a*sin(b*x+c)^2+d)^2+b)^2)^3
//2*x*sin(3*x*tan(pi*x)+4*x*cos(pi*x)+5*x*cotan(pi*x)+6*x*sin(pi*x))+7*x*cos(8*x*tan(pi*x)+9*x*cos(pi*x)+10*x*cotan(pi*x)+11*x*sin(pi*x))+12*x*tan(13*x*tan(pi*x)+14*x*cos(pi*x)+15*x*cotan(pi*x)+16*x*sin(pi*x))+17*x*cotan(18*x*tan(pi*x)+19*x*cos(pi*x)+20*x*cotan(pi*x)+21*x*sin(pi*x))
//2*x*sin(3*x*tan(2*x)+4*x*cos(2*x)+5*x*cotan(2*x)+6*x*sin(2*x))+7*x*cos(8*x*tan(2*x)+9*x*cos(2*x)+10*x*cotan(2*x)+11*x*sin(2*x))+12*x*tan(13*x*tan(2*x)+14*x*cos(2*x)+15*x*cotan(2*x)+16*x*sin(2*x))+17*x*cotan(18*x*tan(2*x)+19*x*cos(2*x)+20*x*cotan(2*x)+21*x*sin(2*x))
//2*x*sin(2*x+3)*cos(2*x+3)+3*x*tan(2*x+3)*arctan(sin(2*x+3)*cos(2*x+3)*x*2)/sqrt(x+3*cos(2*x+3)+4*tan(2*x+3)+5*sin(2*x+3)+2)/sqrt(x+6*sqr(7*cos(2*x+3)+1)+3)/sqrt(x+9*sqr(8*sin(2*x+3)+2)+4)/sqrt(x+4*sqr(3*tan(2*x+3)+3)+5)
//3*(2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6)*sin(2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6)+3*(2*sin(2*x*(2*sin(3*x+4)*sin(4*x+5)+5)*sin(2*x+3)+6)+3)^2+4
//(a*x*t*sin(t/a+b)*(b*x+d)*cos(c*(a*x+b*y+c*t+d)^(c*x-b)-d)-tan(a*sin(a*x+b*y+c)^2-b*cos(a*x*y*t+b)^5+c)^3)/(a*x*y*(b*t-c)^(c*x-d)*(b*t+a)-b*x*sin(a*(b*x+c)^3-b)^4+d)+a*(b*x+c*y+d*t+c)*(a*x*y*t+b)*x*y*t-(b*x*y*t*(c*sin(b*x+c)+d)^3)/(((a*x+b)*(c*y-d)*(b*t+c)*x*y*t*b+c)*sin(a*cos(c*x+d)+b)^3)
//sin(sin(sin(sin(sin(sin(sin(sin(sin(sin(sin(x)))))))))))
//(2*sin(3*x+4)*cos(x)+3*tan(x))*(3*sin(2*x+3)*tan(3*x+4)+4*sin(2*x+3)*cos(3*x+4)+5)+(2*sin(x)*cos(x)+3*tan(2*x+3)*cos(3*x+4)+4)*(3*cos(3*x+4)*tan(2*x+3)+4*sin(x)*ln(2*x+3)+4)+5
//(sin(x)*cos(x)+sin(x))*(cos(x)*sin(x)+cos(x))+(sin(x)*cos(x)+sin(x))*(cos(x)*sin(x)+cos(x))
//(((sin(x)*sin(x)+sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)*sin(x)+sin(x)*sin(x)*sin(x))*(sin(x)*sin(x)*sin(x)+sin(x))+(sin(x)*sin(x)*sin(x)+sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)+sin(x)*sin(x)+sin(x))+sin(x))*(sin(x)*sin(x)*sin(x)+sin(x))+sin(x))*(sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)+sin(x)*sin(x))+(sin(x)*sin(x)+sin(x)*sin(x)+sin(x))*(sin(x)*sin(x)*sin(x)+sin(x)*sin(x)*sin(x))+sin(x)
//2*(2*x+3)*(3*y+4)*(4*x*y+5)+3*(2*t+3*y+4*x+5)*(2*x*y*t+3)+4*(2*x+3*y+4)*(5*x+6)+7
//5*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x+3*y+4*t+2*x*y*t*sin(2*x*y*t+3)+5)+2*x*y*t*sin(2*x+3*y+4*t+5)+7*((5*sin(2*x*y*t+5)*cos(2*x+3*y+5*t+7)*x*y*t+7)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+5)+7
//2*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)*(2*x*y*t*sin(2*x*y*t+3)*cos(2*x+3*y+4*t+5)+2*x+3*y+4*t+5)+sin(x)+5
//2*sin(a*(2*x*y*t+3)^(2*x+5)-7)+8
//1-5*(-2*(-2*x+3)*sin(x))
//1-(-2*(-2*x+3)*sin(x)-1)
//(2*(x/2+3)/(y/3+4)-7)/(3*sin(x/2-3)/(sin(x/3+4)/2+3)+2)/(x/3+3)-2*(y/4-7)/sin(x/5+7)/(x/3+4)-2*sin(x/5+6)*sin(x/7+8)/(y/5+7)-(2*sin(2/x+3)*(2*x+3)/sin(x/4+5)-(5/x+7)*(2*sin(x/5+7)/(2*x+3)-5)/(x/5+7))
//(2*(x/2-3)/(5/x-7)-(x/5+7)*sin(x/3+4)/(x/5+7)-9)/sin(x/2-3)
//(x/2-3)/(5/x-7)+(x/5+7)*2
//2*(sin(x)/(a*x+b)-(a*x-b)/sin(x))*(b-a*x)*sin(x)/(b-x*a)-7
//2*(2*x+3)*(3*y+4)*(4*x*y+5)+3*(2*t+3*y+4*x+5)*(2*x*y*t+3)+4*(2*x+3*y+4)*(5*x+6)+7
//1-((8-3*(2*x-3)/4*y/sin(x)-7))
//5/((2/x-3)/sin(5/y+3)-2*sin(7/sin(1/(2*x+3)+4)-3/(7-5/(2*x+3)*sin(3/x+5))-3))-3*sin(2*x+3)*(3*y+4)/sin(3/x-2)+4*(2*x+3)*(3*y+4)/(5*x+6)-6*sin(x)/(7*sin(3/x-2)*sin(3/(2*y-3)-4)/(2*x+3)-2*sin(2*x+3)*(3*y+4)/sin(1-5/(2*y+3)))*(2*sin(2/x-3)*(2/sin(2*x+3)-3*sin(2/x-3)/(2*x+3)+4*(3*y-2)/sin(2*y-3)/sin(sin(2*x+3)*sin(3*y+4)/(5*x-7)-7*sin(2/x-3)/(2*y+3)-5*sin(2*x-3)*(2*y-5)/sin(2/x-4))))
//sin(sin(x))*sin(x)+sin(x)
//sin(x)+sin(x)*sin(sin(x))
//sin(x)+sin(x)*cos(sin(x))
//sin(x)+sin(x)*sin(x)
//2*((x+1)*3-4)/(3*x*y+4)+5
//2*sin(4*x/t-(4*x-5)/(5*y+1)-x*5/cos(tan(2*t^(2*x/sin(4*x*y-5)+1)-3*x*y*t-t)^3)^5/(4*x*y*tan(2*x*y/(4*x-5*t+y-7/x)^7-(3*t+1)^sin(3*cos(sin(5*x/(4*t-1)-1)*tan(2/tan(4*x-t*cos(2*x+1)))*sin(5*x*y*t)*tan(3*(3*t-1)^3-2)+x*4+t-1)))))
//(2*sin(3*x+4)*cos(2*x*y*t-7)*x-x*y*t*2*cos(2*x+3)/sin((4*x+2)/(4*y+1)))*x/sin(x/y*2-3)-2*x/cos(x*sin(5*x+3)/cos(5*x-7)+8)+2*sin(2*x+3*y-4*t+5)*cos(3*x*y*t+7)/(2*x+3)
//sin(x)+1+cos(x*2+3)*sin(x)+x^2+2*t+7
//1+x^2+2*t
//x*t-cos(t)*(tan(x*t-cos(t)*(tan(x*t-cos(t)*(tan(y*x-t^y))))))
//x*t-cos(t)*(tan(x*t-cos(t)*(tan(x*t-cos(t)*(tan(y*x-t^(-1)))))))
//cos(x)-sin(2*cos(x)+3)+sin(cos(x))+sin(x)/(cos(x)-5*sin(2*cos(x)+3)-4*sin(cos(x)))-4*cos(5*sin(2*cos(x)+3)/(7*sin(cos(x))-1))
//2/sqrt(sin(x))-sin(x)/(sqrt(sin(x))-sqrt(1-sin(x)))-sin(x)/(sqrt(sin(x))+sqrt(1-sin(x)))
//2-sin(x)-(sqrt(1+sin(x))-sqrt(1-sin(x)))/(sqrt(1+sin(x))+sqrt(1-sin(x)))
//x*t-sin(x)^cos(x)*(tan(x*t-sin(x)^cos(x)*(tan(x*t-sin(x)^cos(x)))))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)))))
//x*t-exp(t)*(exp(x*t-exp(t)*(exp(x*t-exp(t)*(exp(y*x-1))))))
//x*t-x^t*(x^(x*t-x^t*(x^(x*t-x^t*(x^t)))))
//x*t-x^(-1)*(x^(x*t-x^(-2)*(x^(x*t-x^(-3)*(x^(-4))))))
//x*t-x^7*((x*t-x^7*((x*t-x^7*(x^7))^7))^7)
//x*t-x^5*((x*t-x^5*((x*t-x^5*(x^5)+(x*(x^5))^5)^5)^5)^5)^5
//x*t-x^(-5)*((x*t-x^(-1)*((x*t-x^(-2)*(x^(-3))+(x*(x^(-4)))^(-2))^(-2))^(3))^(4))^(5)
//sin(sin(x))+sin(sin(sin(x)))+sin(sin(x))+sin(sin(sin(x)))
//sin(x)+sin(sin(x))+sin(sin(sin(x)))+sin(x)+sin(sin(x))+sin(sin(sin(x)))
//(sin(2*x+4)*3-5*cos(4*x-5)/tan(5*t-7)-x*4+y*5-7)/sin(x*5-11)+7*x*cos(8*t-9)
//(sin(x)-cos(x)-x+y)
//(x*x*y+7)^2
//(x*y)^2+(y*t*x)
//-(-x-y-sin(x)-7+8)-(-(-cos(x)-(-(-x+1))-5-tg(x)-(x-4-sin(y))))
//vi: TArrayI=10; setlen(vi,10); vi[0]=144; vi[1]=864;  vi[2]=24;  vi[3]=120;  vi[4]=720;  vi[5]=168; vi[6]=1728; vi[7]=192; vi[8]=216; vi[9]=840; gcd(vi)
//L=2; vi1: TArrayI=L; for(k,0,L-1,vi1[k]=vi[k]) ;lcm(vi1)
//lcm( 144, 864, 24, 120, 720, 168, 1728, 192, 216, 840)





//flSet(fl_Disable,fl_PRELIM_SYNT_ERROR,0);

//  not&j&or&(k+1)&and&not&(j+1)&xnor&AF$h&nand&not&((j+k)&nor&11011$b)


//************************************************************************

//  not&j&or&(k+1)&and&not&(j+1)&xor&AF$h&nand&not&((k+j+15)&nor&1001$b)
//  !j%(k+1)&(!(j+1))~AF$h!&!((k+j+15)!%1001$b)
//  xor(or(not(j),and(k+1,not(j+1))),nand(AF$h,not(nor(k+j+15,1001$b))))
//  k1:int=not(j); k2:int=not(j+1); k3:int=and(k+1,k2); k4:int=or(k1,k3); k5:int=nor(k+j+15,1001$b); k6:int=not(k5); k7:int=nand(AF$h,k6); xor(k4,k7)

//  k1:int = sp2(!k,j%k); k2:int=sp2(j&k1,!k1); k3:int=sp2(!j%(k1&k2),!k1&k2%(!j%!k1)); k3
//  k1:int = sp2(not(k),or(j,k)); k2:int=sp2(and(j,k1),not(k1)); k3:int=sp2(or(not(j),(and(k1,k2))),or(and(not(k1),k2),(nor(not(j),k1)))); k3
//  k1:int = sp2(not&k,j&or&k); k2:int=sp2(j&and&k1,not&k1); k3:int=sp2(not&j&or&(k1&and&k2),not&k1&and&k2&or&(not&j&nor&k1)); k3


// k1:int=!k%j; k2:int=k1!%j; k3:int=!k1&k2%(!j); k3
// k1:int=not&k&or&j; k2:int=k1&or&not&j; k3:int=not&k1&and&k2&or&(not&j); k3
// k1:int=or(not(k),j); k2:int=or(k1,not(j)); k3:int=or(and(not(k1),k2),(not(j))); k3


//  fint2(k1,k2:int) = n1:int=!k1%k2; n2:int=k1!%k2; n3:int=!k1&k2%(!n1); (!k1%(!k2)!%(k1&k2)!%n2!~n3)
//  k1:int=123; k2: int=321;  n1:int=!k1%k2; n2:int=k1!%k2; n3:int=!k1&k2%(!n1); (!k1%(!k2)!%(k1&k2)!%n2!~n3)

//  fint2(k1,k2:int) =  (!k1%(!k2)!%(k1&k2)!%k2!~k1)
//  k1:int=123; k2: int=321;  (!k1%(!k2)!%(k1&k2)!%k2!~k1)
//  k1:int=123; k2: int=321;  (!k1%(!k2)!~(k1&k2)!~k2!%k1)



//  fint2(k1,k2:int) =  !k1%(!k2)!%(k1&k2)!%k1!~k2
//  k1:int=123; k2: int=321;  !k1%(!k2)!%(k1&k2)!%k1!~k2

 //  not&|not&|k|&or&not&|j|&or&|n||&or&123$h
  //  !|!|k|+|k|!|!

// n=12345678$h; Ptrn:Ptr=@n; b1:integer=PByte(Ptrn);  b2:integer=PByte(Ptrn+1); b3:integer=PByte(Ptrn+2); b4:integer=PByte(Ptrn+3);
// n=12345678$h; b1:integer=and(n,FF$h);  b2:integer=and(n,FF00$h); b3:integer=and(n,FF0000$h); b4:integer=and(n,FF000000$h);

//  Ptrn:ptr=@n; PByte(Ptrn)=78$h; PByte(Ptrn+1)=56$h; PByte(Ptrn+2)=34$h; PByte(Ptrn+3)=12$h; n

// Ptr1:ptr=@n; vp1[k+j]=Ptr1;  vp1[k+j+1]=Ptr1+1; vp1[k+j+2]=Ptr1+2; vp1[k+j+3]=Ptr1+3;  PByte(vp1[k+j])=78$h; PByte(vp1[k+j+1])=56$h; PByte(vp1[k+j+2])=34$h; PByte(vp1[k+j+3])=12$h; n


// error !!
// k1:int=1113; k2: int=5; !k1%k2!
// k1:int=1113; k2: int=5; (!k1)%(k2!)


// ![x]
// !iff(y>x,y,x)
               // последний символ 2 орг опер-ии и 1арг опер-ции с передним расположением
// BeforeFuncEnableSymb
// BeforeBracketEnableSymb

// [x]%![y]


//j:=5; k:=2;
//n1:=10; n2:=20; n3:=30; n4:=40; n5:=50;
//n:=n1 or n2 xor n3 and n4;

//n:= not n1 xor not n2 ;
//n:= not n1 and not n2 ;
//n:=-n1 and -n2;
//n:=n1 * n2 and n3 * n4;
//n:=n1 or n2 xor n3;
//n:=123; j:=543;
//n:=not((not n) or (not j));

//n:=not j or (k+1) and not (j+1) xor $AF and not ((k+j+15) or 9);  // not&j&or&(k+1)&and&not&(j+1)&xor&AF$h&and&not&((k+j+15)&or&1001$b)
//n:=not j or (k+1) and not (j+1) xor not ($AF and not (not((k+j+15) or 9)));  //  not&j&or&(k+1)&and&not&(j+1)&xor&AF$h&nand&not&((k+j+15)&nor&1001$b)


//n:=not j or (k+1) and not (j+1) xor $AF and not ((k+j+15) xor 9) and $1F xor (2*j+3*k-20);
// not&j&or&(k+1)&and&not&(j+1)&xor&AF$h&and&not&((k+j+15)&xor&1001$b)&and&1F$h&xor&(2*j+3*k-20)

//n1:=n;

{
not&k&and&not&j
and(not(k),not(j))
n1:int=not(k)  ; n2:int=not(j); and(n1,n2)
}

//n:=n1 + n2 and n3 + n4;
{
n1:int=10; n2:int=20; n3:int=30; n4:int=40; n5:int=50; n1+n2&and&n3+n4
}




{
 b^(i*x)-exp(-x*arg(b+0i))*(cos(x*ln(|b|))+i*sin(x*ln(|b|)))


  }


//*******************************************************************************

//  not&j&or&(k+1)&and&11011$b&xor&AF$h&nand&not&((k+j)&nor&11011$b)

//  (j)&and&(k)


//if , for

//ifp(x<y,x=y);  x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y))))))))))
//x=2; y=5; ifp(x<y,x=y;x=x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y))))))))));goto(lab), y=x;x=x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y*(x*y+x*y)))))))))));); lab>> x

//r:dbl=0; L:int=len(vd1); i: int=0; j:int=0; k:int=0; for(i,0,L-1,for(j,0,L-1,ifp(j>i,for(k,i+j,L-1,ifp((k+i <= L-1) and (k+j <= L-1),r=vd1[k+i]-vd2[k+j]*vd3[k]+r;); ifp((((k+j-3*i) >= 0)  and ((k+j-3*i) <= L-1)) and ((2*k+1) <= L-1),r=r-vd3[2*k-1]+vd2[k+j-3*i]*vd1[2*k]);)))); r

(*

{$IN+}pl1(x)=x+1
{$IN+}pl2(x)=x*2
{$IN+}pl3(x,y)=x+y
{$IN+}pl4(x,y,t)=pl3(pl1(x),pl2(x))/pl3(x,t)

s=0; for(n=1,10,s=s+pl4(pl1(y),pl2(t),pl1(x)/pl2(y))*pl3(x/pl1(t),y/pl2(x))); s
*)


{




x=6; y=10; q=3.5; t=2;
multiiff(
         x<1,  multiiff(
                         multiiff(t < 1, 15, t<3, 25, 35) < 20,  multiiff(q < 2, 150, q<4, 250, 350),
                         y<5,  20,
                         y<=7, 30,
                         y<=9, multiiff(q < 2, 110, q<4, 210, 310),
                               50
                        ),

         x<5,  2,

         x<=7,  multiiff(
                         multiiff(t < 1, 21, t<3, 31, 41) < 30,  multiiff(q < 2, 170, q<4, 270, 370),
                         y<5,  200,
                         y<=multiiff(t < 1, 5, t<3, 15, 25), multiiff(q < 2, 190, q<4, 290, 390),
                         y<=9, 400,
                               multiiff(q < 2, 180, q<4, 280, 380)
                        ),

         x<=9, 4,

               5
        );




x=6; y=10; q=3.5; t=2; r=1000;  res:ext=0;
multiifp(
         x<1,  multiifp(
                         multiiff(t < 1, 15, t<3, 25, 35) < 20,  multiifp(q < 2, res=150; res=res+r, q<4, res=250; res=res+r, res=350; res=res+r),
                         y<5,  res=20; res=res+r,
                         y<=7, res=30; res=res+r,
                         y<=9, multiifp(q < 2, res=110; res=res+r, q<4, res=210; res=res+r, res=310; res=res+r),
                               res=50; res=res+r
                        ),

         x<5,  res=2; res=res+r,

         x<=7,  multiifp(
                         multiiff(t < 1, 21, t<3, 31, 41) < 30,  multiifp(q < 2, res=170; res=res+r, q<4, res=270; res=res+r, res=370; res=res+r),
                         y<5,  res=200; res=res+r,
                         y<=multiiff(t < 1, 5, t<3, 15, 25), multiifp(q < 2, res=190; res=res+r, q<4, res=290; res=res+r, res=390; res=res+r),
                         y<=9, res=400; res=res+r,
                               multiifp(q < 2, res=180; res=res+r, q<4, res=280; res=res+r, res=380; res=res+r)
                        ),

         x<=9, res=4; res=res+r,

               res=5; res=res+r
        );   res;




r=1;  x=9;
case(x+1,
          10, res=10,
          20, res=20,
          30, res=30; res=res+r,
          40, res=40; res=res+r,
              res=50; res=res+r
     );res




r=1;  k=10; n=1;
case(n*k,
          10, res=10,
          20, res=20,
          30, res=30; res=res+r,
          40, res=40; res=res+r,
              res=50; res=res+r
     );res



r=1;  x=10;
case(x,
          10, res=10,
          20, res=20,
          30, res=30; res=res+r,
          40, res=40; res=res+r,
              res=50; res=res+r
     );res




r=1;  k=10;
case(k,
          10, res=10,
          20, res=20,
          30, res=30; res=res+r,
          40, res=40; res=res+r,
              res=50; res=res+r
     );res




r=1;  y=10; x=30;
case(x,
          =y,     res=10,
          =20,    res=20,
          =y*3,   res=30; res=res+r,
          =y*4,   res=40; res=res+r,
                  res=50; res=res+r
     );res




r=1;  y=10; x=30;
case(x,
          <= 5,     res=5,
          <  y,     res=10,
          <  20,    res=20,
          <= y*3,   res=30; res=res+r,
          <  y*4,   res=40; res=res+r,
                    res=50; res=res+r
     );res




r=1;  y=10; x=30;
case(x,
          >= y*4,   res=50; res=res+r,
          >  y*3,   res=40; res=res+r,
          >= 20,    res=30; res=res+r,
          >  y,     res=20,
          >  5,     res=10,
                    res=5
     );res




  ********************

r=1;  y=10; x=10;
case(x,
          <= 5,     res=5,
          <  y,     res=10,
          <  20,    res=20,
          <= y*3,   res=30; res=res+r,
          <  y*4,   res=40; res=res+r,
                    res=50; res=res+r
     );q1=res;


case(x,
          >= y*4,   res=50; res=res+r,
          >  y*3,   res=40; res=res+r,
          >= 20,    res=30; res=res+r,
          >=  y,     res=20,
          >  5,     res=10,
                    res=5
     );q2=res;

q1-q2     ;  //=0!!!

  ***********************



r=1;  t=2; y=10; x=5;
case(x*t,
          <= 5,     res=5,
          <  y,     res=10,
          <  20,    res=20,
          <= y*3,   res=30; res=res+r,
          <  y*4,   res=40; res=res+r,
                    res=50; res=res+r
     );q1=res;


case(x*t,
          >= y*4,   res=50; res=res+r,
          >  y*3,   res=40; res=res+r,
          >= 20,    res=30; res=res+r,
          >=  y,     res=20,
          >  5,     res=10,
                    res=5
     );q2=res;

q1-q2     ;  //=0!!!


******************************
            F(x,y,p,q,t) =
            x*y  <= p:       res=p,
            x*y  <  2*p:     res=2*p,
            x*y  <  p+q:     t=t+p+q;   res=t*x,
            x*y  <= 2*(p+q): t=t*(p+q); res=t*y,
            x*y  <  3*(p+q): t=t*(p+q); res=t*(x+y);
                             res=t*(p*x+q*y);


 ----------------

x=1; y=2; p=5; q=10; t=3;
case(x*y,
            <= p,       res=p,
            <  2*p,     res=2*p,
            <  p+q,     t=t+p+q;   res=t*x,
            <= 2*(p+q), t=t*(p+q); res=t*y,
            <  3*(p+q), t=t*(p+q); res=t*(x+y);,
                        res=t*(p*x+q*y);
     );q1=res;



case(x*y,
            >=  3*(p+q),  res=t*(p*x+q*y),
            >   2*(p+q),  t=t*(p+q); res=t*(x+y),
            >=  p+q,      t=t*(p+q); res=t*y,
            >=  2*p,      t=t+p+q;   res=t*x,
            >   p,        res=2*p,
                          res=p;
     );q2=res;

     q1-q2;

  ---------------------

x=1; y=2; p=5; q=10; t=3; arg=x*y;
multiifp(arg <= p,res=p,  arg < 2*p,res=2*p, arg <  p+q,t=t+p+q;res=t*x, arg <= 2*(p+q), t=t*(p+q); res=t*y, arg <  3*(p+q), t=t*(p+q); res=t*(x+y) ,res=t*(p*x+q*y) ) ; res



  ***********************




r1=1000; r2=10000; r3=100000; r4=1000000; x=2; y=3; a=4; b=5; p=5; q=10; t=10; res=-1;
case(t,
          10, res=10+r1,
          20, case(y,10, res=q*y+r2, 20, res=2*q*y+r2, 30, res=3*q*y+r2);,
          30, res=30; res=res+r1,
          40, case(x,10, res=p*x; res=res*x+r3, 20, res=2*p*x; res=2*res*x+r3, 30, res=3*p*x; res=3*res*x+r3);,
              multiifp((a<b) or (x<y),res=a*y+r4; , (a>b) and (x>y), res=b*y; res=res*x+r4, res=(a+b)*x*y; res=res+2*r4);
     );res



  *********************************

      s:ext=0; x=0; y=0; t=0;
      upx:int=100; upy:int=100; upt:int=100; kx:int=0; ky:int=0; kt:int=0;
      n1:int=0; n2:int=0; n3:int=0;
      n4:int=0; n5:int=0; n6:int=0;
      n7:int=0; n8:int=0; n9:int=0;

       for(kx=0,upx,
        for(ky=0,upy,
         for(kt=0,upt,

               case( sin(x)+cos(y),

                     <  2*sin(2*t)     ,
                                   case( sin(x+t),
                                         < cos(x+t), inc(n1),
                                         < cos(y+t), inc(n2),
                                                     inc(n3)

                                       );
                                       ,
                     <  2*cos(sin(t))  ,
                                   case( cos(x+t),
                                        < sin(x+y),  inc(n4),
                                        < sin(y+t),  inc(n5),
                                                     inc(n6)
                                       )
                                       ,
                                   case( cos(x+t)*sin(y+t),
                                        < cos(x+y)*cos(y+t), inc(n7),
                                        < sin(x-t)*sin(y-t), inc(n8),
                                                             inc(n9)
                                       ) ;

                   );

              t=t+0.1;
            );
            y=y-0.15
           );
           x=x+0.2;
          );


      PrintW2(n1); PrintW2(n2); PrintW2(n3);
      PrintW2(n4); PrintW2(n5); PrintW2(n6);
      PrintW2(n7); PrintW2(n8); PrintW2(n9);

  ------------------------------------------------------------------


   s:ext=0; x=0; y=0; t=0;
      upx:int=100; upy:int=100; upt:int=100; kx:int=0; ky:int=0; kt:int=0;
      n1:int=0; n2:int=0; n3:int=0;
      n4:int=0; n5:int=0; n6:int=0;
      n7:int=0; n8:int=0; n9:int=0;

       for(kx=0,upx,
        for(ky=0,upy,
         for(kt=0,upt,

               case( sin(x)+cos(y),

                     <  2*sin(2*t)     ,
                                   case( sin(x+t),
                                         < cos(x+t), s=s+cos(x+t)*cos(y+t),
                                         < cos(y+t), s=s+sin(x+t)*sin(y+t),
                                                     s=s+cos(2*t)*sin(y)

                                       );
                                       ,
                     <  2*cos(sin(t))  ,
                                   case( cos(x+t),
                                        < sin(x+y),  s=s+cos(x+y)*sin(x+t),
                                        < sin(y+t),  s=s+sin(x+y)*sin(2*t),
                                                     s=s+cos(y)*sin(sin(t))
                                       )
                                       ,
                                   case( cos(x+t)*sin(y+t),
                                        < cos(x+y)*cos(y+t), s=s+cos(y+t)*sin(x+t),
                                        < sin(x-t)*sin(y-t), s=s+cos(x-t)*cos(y-t),
                                                             s=s+cos(x)*sin(y)+cos(sin(t))
                                       ) ;

                   );

              t=t+0.1;
            );
            y=y-0.15
           );
           x=x+0.2;
          );

         s;
     
    ------------------------------------------------------------------------------------




   s:ext=0; x=0; y=0; t=0;
      upx:int=100; upy:int=100; upt:int=100; kx:int=0; ky:int=0; kt:int=0;
      n1:int=0; n2:int=0; n3:int=0;
      n4:int=0; n5:int=0; n6:int=0;
      n7:int=0; n8:int=0; n9:int=0;

       for(kx=0,upx,
        for(ky=0,upy,
         for(kt=0,upt,

               case( sin(x)+cos(y),

                     <  2*sin(2*t)     ,

                                        s=s+multiiff(sin(x+t) < cos(x+t), cos(x+t)*cos(y+t), sin(x+t)  < cos(y+t),sin(x+t)*sin(y+t), cos(2*t)*sin(y))

                                       ,
                     <  2*cos(sin(t))  ,

                                        s=s+multiiff(cos(x+t) <  sin(x+y), cos(x+y)*sin(x+t),  cos(x+t) < sin(y+t),  sin(x+y)*sin(2*t), cos(y)*sin(sin(t)))

                                       ,

                                       s=s+multiiff(cos(x+t)*sin(y+t) <  cos(x+y)*cos(y+t), cos(y+t)*sin(x+t),  cos(x+t)*sin(y+t) <  sin(x-t)*sin(y-t),  cos(x-t)*cos(y-t), cos(x)*sin(y)+cos(sin(t)))

                   );

              t=t+0.1;
            );
            y=y-0.15
           );
           x=x+0.2;
          );

         s;

   -----------------------------------------------------------------------------



   s:ext=0; x=0; y=0; t=0;
      upx:int=100; upy:int=100; upt:int=100; kx:int=0; ky:int=0; kt:int=0;
      n1:int=0; n2:int=0; n3:int=0;
      n4:int=0; n5:int=0; n6:int=0;
      n7:int=0; n8:int=0; n9:int=0;

       for(kx=0,upx,
        for(ky=0,upy,
         for(kt=0,upt,

               case( sin(x)+cos(y),

                     <  2*sin(2*t)     ,

                                        multiifp(sin(x+t) < cos(x+t), s=s+cos(x+t)*cos(y+t), sin(x+t)  < cos(y+t), s=s+sin(x+t)*sin(y+t), s=s+cos(2*t)*sin(y))

                                       ,
                     <  2*cos(sin(t))  ,

                                        multiifp(cos(x+t) <  sin(x+y), s=s+cos(x+y)*sin(x+t),  cos(x+t) < sin(y+t),  s=s+sin(x+y)*sin(2*t), s=s+cos(y)*sin(sin(t)))

                                       ,

                                       multiifp(cos(x+t)*sin(y+t) <  cos(x+y)*cos(y+t), s=s+cos(y+t)*sin(x+t),  cos(x+t)*sin(y+t) <  sin(x-t)*sin(y-t),  s=s+cos(x-t)*cos(y-t), s=s+cos(x)*sin(y)+cos(sin(t)))

                   );

              t=t+0.1;
            );
            y=y-0.15
           );
           x=x+0.2;
          );

         s;


   ****************************************************************************


}




{

//******************************************************************************

x:ext=0; y:ext=0;
Res1:ext=0; Res2:ext=0; Res3:ext=0; Res:ext=0;

x=1; y=1;
gosub(Proc1);
res1=res;

x=2; y=2;
gosub(Proc2);
res1=res1+res;


x=3; y=3;
gosub(Proc3);
res1=res1+res;


x=4; y=4;
gosub(Proc4);
res1=res1+res;


x=5; y=5;
gosub(Proc5);
res1=res1+res;

x=6; y=6;
gosub(Proc6);
res1=res1+res;

goto(nxt1);

//------------------------------
Proc1>>
 Res=(x+1)+y*1;
Return();


Proc2>>
 xt2:ext=x; yt2:ext=y; rest2:ext=0;
 x=x+2; y=y*2;
 gosub(Proc1);
 rest2=Res;
 x=xt2+x; y=yt2*y;
 gosub(Proc3);
 Res=Rest2+Res;
Return();


proc3>>
 res=(x+3)+y*3;
Return();
//------------------------------

nxt1>>

x=1; y=1;
gosub(Proc1);
res2=res;

x=2; y=2;
gosub(Proc2);
res2=res2+res;


x=3; y=3;
gosub(Proc3);
res2=res2+res;


x=4; y=4;
gosub(Proc4);
res2=res2+res;


x=5; y=5;
gosub(Proc5);
res2=res2+res;

x=6; y=6;
gosub(Proc6);
res2=res2+res;

goto(nxt2);





//-----------------------------
Proc4>>
 Res=(x+4)+y*4;
Return();


Proc5>>
 xt5:ext=x; yt5:ext=y; rest5:ext=0;
 x=x+5; y=y*5;
 gosub(proc2);
 rest5=Res;
 x=xt5+x; y=yt5*y;
 gosub(proc6);
 Res=Rest5+Res;
Return();


Proc6>>
 res=(x+6)+y*6;
Return();
//----------------------------

nxt2>>


x=1; y=1;
gosub(Proc1);
res3=res;

x=2; y=2;
gosub(Proc2);
res3=res3+res;


x=3; y=3;
gosub(Proc3);
res3=res3+res;


x=4; y=4;
gosub(Proc4);
res3=res3+res;


x=5; y=5;
gosub(Proc5);
res3=res3+res;

x=6; y=6;
gosub(Proc6);
res3=res3+res;

(res1/res2+res1/res3+res2/res3)/3


//******************************************************************************
}


{
 s:ext=0;  for(y,1,y<=30,y+1,for(x,1,x<=50, x+1, s=s+if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y))
  or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),  if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x)))))
  or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x))))+if((sin(x*y)*cos(x+y) > sin(cos(y)*x))  or ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y))) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x))
  and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))*if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y))))
  or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) and (sin(x*sin(x)) > cos(y*cos(y))) ,sin(x),cos(x)),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and (sin(cos(x)) >= cos(y*sin(x*cos(x))))) or ((sin(x) <= cos(y+x)) and ( cos(x-y)*cos(x+y) <= sin(cos(x)+sin(y)))) ,sin(x),cos(x)))  ));s
}

//r:dbl=0; L:int=len(vd1); i: int=0; j:int=0; k:int=0; for(i,0,L-1,for(j,0,L-1,ifp(j>i,for(k,i+j,L-1,ifp((k+i <= L-1) and (k+j <= L-1),r=vd1[k+i]-vd2[k+j]*vd3[k]+r;); ifp((((k+j-3*i) >= 0)  and ((k+j-3*i) <= L-1)) and ((2*k+1) <= L-1),r=r-vd3[2*k-1]+vd2[k+j-3*i]*vd1[2*k]);)))); r

//vi:arrayInt=0; vd:arrayDbl=0; n:int=0; k:int=0;  itr:int=10;  SetLen(vd,10); L:int=Len(vd);   for(k,0,itr,  for(n,0,L-1,vd[n]=n));  SetLen(vi,10);   L=Len(vi);  for(k,0,itr,   for(n,0,L-1,vi[n]=n));  1


//{$CC-}pct1(k: int):real= k+1;



{sum of all numbers in range [1,k] integer divide on p: fnc(10,5)=5+10=15; fnc(10,3)=3+6+9=18; ...}
//fnc(k,p: int)= vd:ArrayDbl=k; vi:ArrayInt=0; n:int=0; L:int=Len(vd); ckl1>> if(n > L-1, goto(nxt)); vd[n]=n+1; inc(n); goto(ckl1); nxt>> n=0;  ckl2>>  if(n > L-1, goto(nxt2)); if({vd[n]/p}<>0,goto(lab1)); setlen(vi,len(vi)+1); vi[len(vi)-1]=n; lab1>> inc(n); goto(ckl2); nxt2>> m:int=0; L=Len(vi);  n=0; ckl3>> if(n > L-1, goto(end)); m=m+vd[vi[n]]; inc(n); goto(ckl3); end>>m


//gvd - global array-variable result in gvd
//{$CC-}fnc(k,p: int):none= vd:ArrayDbl=k; setlen(gvd,0); n:int=0; L:int=Len(vd); ckl1>> if(n > L-1, goto(nxt)); vd[n]=n+1; inc(n); goto(ckl1); nxt>> n=0;  ckl2>>  if(n > L-1, goto(nxt2)); if({vd[n]/p}<>0,goto(lab1)); setlen(gvd,len(gvd)+1); gvd[len(gvd)-1]=vd[n]; lab1>> inc(n); goto(ckl2); nxt2>>
//fnc(100,7);x=sum(gvd);fnc(10,3);x+sum(gvd)

(*
{$CC-}fnc(k: int):none= setlen(gvd,k); n:int=0; L:int=Len(gvd); ckl1>> if(n > L-1, goto(end)); gvd[n]=n+1; inc(n); goto(ckl1); end>>
setlen(gvd,2); gvd[0]=1.1; gvd[1]=2.2; x=sum(gvd); fnc(5); x+sum(gvd)   //18.3
*)




(*
{$CC-} fnc(n: int):none=  k: int=0; n=len(vd);  ckl>> if(k>n-1,goto(end)); vd[k]=k+1; inc(k); goto(ckl); end>>
setlen(vd,3); fnc(3); x=sum(vd); setlen(vd,5); fnc(5); x+sum(vd)
*)

(*
{$CC-} fnc(vv: array double):none=  k: int=0; n=len(vv);  ckl>> if(k>n-1,goto(end)); vv[k]=k+1; inc(k); goto(ckl); end>>
setlen(vd,3); fnc(vd); x=sum(vd); setlen(xvd,5); fnc(xvd); x+sum(xvd)
*)

(*
ffdl(vv: array double):none=fvdl(vv)
pfdl(vv: array double)=pvdl(vv)+sum(vv)

wfdl(vv: array double):none=ffdl(vv)
sfdl(vv: array double)=pfdl(vv)

vdyn: arrayDbl=3; wfdl(vdyn); x=sfdl(vdyn);  setlen(vdyn,5); wfdl(vdyn); x+sfdl(vdyn);

res=42 (6+6)+(15+15)
*)

(*
l:int=len(ad);i:int=0;vs:arrayExt=l; ckl1>>if(i>l-1,goto(ckl2));vs[i]=ad[i]+ad[i];inc(i);goto(ckl1);ckl2>>vs[2]
l:int=len(ad);i:int=0;vs:arrayExt=0; setlen(vs,l); ckl1>>if(i>l-1,goto(ckl2));vs[i]=ad[i]+ad[i];inc(i);goto(ckl1);ckl2>>vs[2]


l: int=30; xs: arrayExt=l; ys: arrayExt=l; i:int=0;  ckl>>if(i>l-1,goto(end)); ys[i]=i; xs[i]=i+1; inc(i);goto(ckl); end>> sum(xs)+sum(ys)



copy(xs1,ys1: arrayExt):none=l:int=len(xs1);i:int=0;  ckl>>if(i>l-1,goto(end));ys1[i]=xs1[i];inc(i);goto(ckl); end>>
l: int=3; xs: arrayExt=0; ys: arrayExt=0; setlen(xs,l); setlen(ys,l); i:int=0;  ckl>>if(i>l-1,goto(end));xs[i]=i;inc(i);goto(ckl); end>>copy(xs,ys); sum(ys)


copy(xs1,ys1: arrayExt):none=l:int=len(xs1);i:int=0;  ckl>>if(i>l-1,goto(end));ys1[i]=xs1[i];inc(i);goto(ckl); end>>
l: int=3; xs: arrayExt=l; ys: arrayExt=l;  i:int=0;  ckl>>if(i>l-1,goto(end));xs[i]=i;inc(i);goto(ckl); end>>copy(xs,ys); sum(ys)



l: int=[rand(1,1000)]; xs: arrayExt=l; ys: arrayExt=l; i:int=l-2;  xs[i]=l; ys[i+1]=l+1;  sum(xs)+sum(ys)


l: int=[rand(1,1000)];  xs: arrayExt=l;  i:int=0;  ckl>>if(i>l-1,goto(end)); xs[i]=i; inc(i); goto(ckl); end>> sum(xs)

*)
(*


sumv(ai: arrayInt)=l:int=len(ai); i:int=1; s:ext=0; ckl>>if(i>l-1,goto(end)); s=s+if(ai[i]=1,i,0); inc(i); goto(ckl); end>>s

limit:ext=10001; is_prime:arrayInt=limit+2; jj: ext=0; i:ext=0; k:ext=0; x: ext=0; y:ext=0; Lsqrt:ext=[sqrt(limit)]; i=5; ckli1>>if(i>limit,goto(EndCkli1));is_prime[i]=0;i=i+1;goto(ckli1); EndCkli1>>  x=1; cklx>> if(x > Lsqrt,goto(EndCklX)); y=1; ckly>> if(y > Lsqrt,goto(EndCklY)); n=4*x^2+y^2 ; is_prime[n]=if((n <=limit) and ((n-[n/12]*12 = 1) or (n-[n/12]*12 = 5)),1-is_prime[n],is_prime[n]); n=n-x^2; is_prime[n]=if((n <=limit) and (n-[n/12]*12 = 7),1-is_prime[n],is_prime[n]); n=n-2*y^2; is_prime[n]=if((x>y) and (n <= limit) and (n-[n/12]*12 = 11),1-is_prime[n],is_prime[n]); y=y+1;goto(ckly); EndCklY>> x=x+1; goto(cklx); EndCklX>>    i=5; ckli2>>  if(i > Lsqrt,goto(EndCkli2));  if(is_prime[i] = 0, goto(nxti2)); k=i^2; n=k;  ckln>> if(n > limit, goto(nxti2)); is_prime[n]=0;  n=n+k;  goto(ckln) ;nxti2>>i=i+1; goto(ckli2); EndCkli2>> is_prime[2]=1; is_prime[3]=1; sumv(is_prime)

limit:ext=10001; is_prime:arrayInt=limit+2; jj: ext=0; i:int=0; k:ext=0; x: int=0; y:int=0; n:ext=0;  Lsqrt:ext=[sqrt(limit)]; for(i,5,limit,is_prime[i]=0); for(x,1,Lsqrt,for(y,1,Lsqrt,n=4*sqr(x)+sqr(y);if((n<=limit) and ((n-[n/12]*12 = 1) or (n-[n/12]*12 = 5)),is_prime[n]=1-is_prime[n]); n=n-sqr(x); if((n<=limit) and (n-[n/12]*12 = 7) , is_prime[n]=1-is_prime[n] ); n=n-2*sqr(y); if((x>y) and (n<=limit) and (n-[n/12]*12 = 11),is_prime[n]=1-is_prime[n])));  for(i,5,Lsqrt,if(is_prime[i]=1,k=sqr(i);n=k; while(n<=limit,is_prime[n]=0; n=n+k))); is_prime[2]=1; is_prime[3]=1; sumv(is_prime)
*)



//gcd(n,k: int):real=  ckl>>ifp(n>k,n=mod(n,k),k=mod(k,n)); ifp((n=0) or (k=0),goto(end),goto(ckl)); end>>n+k


//s:dbl=0; n:int=0; k:int=0; m: int=0; for(n,1,300,ifp({n/3}=0,for(k,1,200,ifp({(n+k)/2}=0,for(m,1,100,ifp(({(n+m)/3}=0) or ({(k+m)/5}=0),s=s+1))))));s

//gcda(vd: arrayD):real=Len:int=Len(vd); S:ext=0; ifp(Len=0,S=0; goto(endp),ifp(Len=1,S=vd[0];goto(endp)));n:int=1; u:int=[vd[0]]; v:int=[vd[1]]; lp>> while(v<>0,t:int=u;u=v;v=mod(t,v));s=|u|; inc(n);ifp(n>len-1,goto(endp),v=[s];u=[vd[n]];goto(lp)); endp>>S

//Error:
{
vdstl(v1: arrayd; len: int): none= setlen(v1,len);
v1:arrayd=1; vdstl(vd,10);
}
{

z1/k
k/z2
k+z1
z2+k
k-z2
z2-k
z2+k
k*z1
z1*k

z1/x
x/z2
x+z1
z2+x
x-z2
z2-x
z2+x
x*z1
z1*x

(z1*z2+z2*z1*(z1*z2+z2*z1))*(x*y+y*x*(x*y+y*x))
(z1*z2+z2*z1*(z1*z2+z2*z1))/(x*y+y*x*(x*y+y*x))
(z1*z2+z2*z1*(z1*z2+z2*z1))-(x*y+y*x*(x*y+y*x))
(z1*z2+z2*z1*(z1*z2+z2*z1))+(x*y+y*x*(x*y+y*x))

(x*y+y*x*(x*y+y*x))*(z1*z2+z2*z1*(z1*z2+z2*z1))
(x*y+y*x*(x*y+y*x))/(z1*z2+z2*z1*(z1*z2+z2*z1))
(x*y+y*x*(x*y+y*x))-(z1*z2+z2*z1*(z1*z2+z2*z1))
(x*y+y*x*(x*y+y*x))+(z1*z2+z2*z1*(z1*z2+z2*z1))


}

(*
{$DefFunc+}

   Func1X()=sqrt(x);
   Func2X()=res=sqrt(x);
   Func1Z():complex=sqrt(z1.re)+i*sqrt(z1.im)
   Func2Z()=res=sqrt(z1.re)+i*sqrt(z1.im)

{$DefFunc-}

Ptr1X:Pointer=@Func1X;
Ptr2X:Pointer=@Func2X;
Ptr1Z:Pointer=@Func1Z;
Ptr2Z:Pointer=@Func2Z;


Err:int=0;

//x=81;  t=CallRMaskFpu(Ptr1X,@Err); t
//x=-81; t=CallRMaskFpu(Ptr1X,@Err); Err
//x=81;  t=CallRSafe(Ptr1X,@Err); t
//x=-81; t=CallRSafe(Ptr1X,@Err); Err

//x=81;  CallMaskFPU(Ptr2X,@Err); res
//x=-81; CallMaskFPU(Ptr2X,@Err); Err
//x=81;  CallSafe(Ptr2X,@Err); res
//x=-81; CallSafe(Ptr2X,@Err); Err


//z1.re=81;  z1.im=25;   z2=CallCMaskFPU(Ptr1Z,@Err); z2
//z1.re=-81; z1.im=25;   z2=CallCMaskFPU(Ptr1Z,@Err); Err
//z1.re=81;  z1.im=-25;  z2=CallCMaskFPU(Ptr1Z,@Err); Err


//z1.re=81;  z1.im=25;   z2=CallCSafe(Ptr1Z,@Err); z2
//z1.re=-81; z1.im=25;   z2=CallCSafe(Ptr1Z,@Err); Err
//z1.re=81;  z1.im=-25;  z2=CallCSafe(Ptr1Z,@Err); Err



//z1.re=81;  z1.im=25;   CallMaskFPU(Ptr2Z,@Err); res
//z1.re=-81; z1.im=25;   CallMaskFPU(Ptr2Z,@Err); Err
//z1.re=81;  z1.im=-25;  CallMaskFPU(Ptr2Z,@Err); Err


//z1.re=81;  z1.im=25;   CallSafe(Ptr2Z,@Err); res
//z1.re=-81; z1.im=25;   CallSafe(Ptr2Z,@Err); Err
//z1.re=81;  z1.im=-25;  CallSafe(Ptr2Z,@Err); Err

*)


(*



   //     cos(-x/y)*root(sin(-x/y),3)
   //     tan(tan(-x/cotan(x/(x-y))))

               //sp1idS(x)
   //poly(a+b,c,di+a,bi-c,d,e,ai-bi,di+ai,b+a,-c,-d+a,z1)-((a+b)*z1^10+c*z1^9+(di+a)*z1^8+(bi-c)*z1^7+d*z1^6+e*z1^5+(ai-bi)*z1^4+(di+ai)*z1^3+(b+a)*z1^2-c*z1-d+a)
   //poly(a+b,c,di+a,bi-c,d,e,ai-bi,di+ai,b+a,-c,-d+a,x/y)-((a+b)*(x/y)^10+c*(x/y)^9+(di+a)*(x/y)^8+(bi-c)*(x/y)^7+d*(x/y)^6+e*(x/y)^5+(ai-bi)*(x/y)^4+(di+ai)*(x/y)^3+(b+a)*(x/y)^2-c*(x/y)-d+a)
   //poly(a+b,c,di+a,bi-c,d,e,ai-bi,di+ai,b+a,-c,-d+a,x)-((a+b)*x^10+c*x^9+(di+a)*x^8+(bi-c)*x^7+d*x^6+e*x^5+(ai-bi)*x^4+(di+ai)*x^3+(b+a)*x^2-c*x-d+a)
   //poly(a+b,c,d+a,b-c,d,e,a-b,d+a,b+a,-c,-d+a,x)-((a+b)*x^10+c*x^9+(d+a)*x^8+(b-c)*x^7+d*x^6+e*x^5+(a-b)*x^4+(d+a)*x^3+(b+a)*x^2-c*x-d+a)
   //poly(d,e,ai-bi,di+ai,b+a,-c,-d,x)-(d*x^6+e*x^5+(ai-bi)*x^4+(di+ai)*x^3+(b+a)*x^2-c*x-d)
   //poly(e,a,di,0,0,0,x)-(e*x^5+a*x^4+di*x^3)
   //poly(e,a,di,0,0,x)-(e*x^4+a*x^3+di*x^2)
   //poly(e,a,di,0,x)-(e*x^3+a*x^2+di*x)
   //poly(1,1,di,0,x)-(x^3+x^2+di*x)
   //poly(1,1,i,0,x)-(x^3+x^2+i*x)
   //poly(a,bi,b,c,di,ei,-i,i,5i,x)-(a*x^8+bi*x^7+b*x^6+c*x^5+di*x^4+ei*x^3-i*x^2+i*x+5i)
   //poly(a,bi,1,-1,di,ei,-i,i,5i,x)-(a*x^8+bi*x^7+x^6-x^5+di*x^4+ei*x^3-i*x^2+i*x+5i)
   //poly(ai,bi,b,c,di,ei,-i,i,5i,x)-(ai*x^8+bi*x^7+b*x^6+c*x^5+di*x^4+ei*x^3-i*x^2+i*x+5i)
   //poly(a,bi,b,c,di,ei,-i,i,5i,z1)-(a*z1^8+bi*z1^7+b*z1^6+c*z1^5+di*z1^4+ei*z1^3-i*z1^2+i*z1+5i)
   //poly(a,bi,0,0,di,ei,-i,i,5i,z1)-(a*z1^8+bi*z1^7+di*z1^4+ei*z1^3-i*z1^2+i*z1+5i)
   //poly(a,bi,0,0,0,0,-i,i,5i,z1)-(a*z1^8+bi*z1^7-i*z1^2+i*z1+5i)
   //poly(-1,1+i,-1-i,i-1,1-i,i,-i,i+1,x)-(-x^7+(1+i)*x^6-(1+i)*x^5+(i-1)*x^4+(1-i)*x^3+i*x^2-i*x+i+1)
   //poly(-1,1+i,-1-i,i-1,1-i,i,-i,i+1,z1)-(-z1^7+(1+i)*z1^6-(1+i)*z1^5+(i-1)*z1^4+(1-i)*z1^3+i*z1^2-i*z1+i+1)
   //poly(a*b-c,i+ai,-1-bi/c,i-a/bi,1-a/b,i-b,c-i,i+a,z1)
   //poly(a*b-c,a,c*b+1,b,c-a/b,c,d,a*b-d,x)
   //poly(a*b-c,a,c*b+1,b,c-a/b,c,d,a*b-d,x) - ((a*b-c)*x^7+a*x^6+(c*b+1)*x^5+b*x^4+(c-a/b)*x^3+c*x^2+d*x+a*b-d)

   //error:
   //poly(a,x,di+ai/c,bi-c,d,e,y,ai/bi-i,bi,b+a,-c,-d+ai,x-y,z1) - (a*z1^12+x*z1^11+(di+ai/c)*z1^10+(bi-c)*z1^9+d*z1^8+e*z1^7+y*z1^6+(ai/bi-i)*z1^5+bi*z1^4+(b+a)*z1^3-c*z1^2+(-d+ai)*z1+x-y)
   //poly(a,x,di+ai/c,bi-c,d,e,y,ai/bi-i,bi,b+a,-c,-d+ai,x-y,x) - (a*x^12+x*x^11+(di+ai/c)*x^10+(bi-c)*x^9+d*x^8+e*x^7+y*x^6+(ai/bi-i)*x^5+bi*x^4+(b+a)*x^3-c*x^2+(-d+ai)*x+x-y)
   //poly(a,z1,d+a/c,b-c,d,e,y,a/b-1,b,b+a,-c,-d+a,z1-y,z1) - (a*z1^12+z1*z1^11+(d+a/c)*z1^10+(b-c)*z1^9+d*z1^8+e*z1^7+y*z1^6+(a/b-1)*z1^5+b*z1^4+(b+a)*z1^3-c*z1^2+(-d+a)*z1+z1-y)
   //poly(di+ai,b,y,x)
   //poly(2i+3i+4,5,y,x)
   //poly(2i+3i+4,5,y,x)-((2i+3i+4)*x^2+5*x+y)

   //no error
   //poly(a,x,d+a/c,b-c,d,e,y,a/b-1,b,b+a,-c,-d+a,x-y,x) - (a*x^12+x*x^11+(d+a/c)*x^10+(b-c)*x^9+d*x^8+e*x^7+y*x^6+(a/b-1)*x^5+b*x^4+(b+a)*x^3-c*x^2+(-d+a)*x+x-y)
   //poly(2*s,0,a/b-c,2,0,0,s*v/q,b*(c-a),s+q,q-s,3,4*(a+b),c*b/(a*s-c*v),s*a/(b-c*v),q/(s-b*v),x)- (2*s*x^14+(a/b-c)*x^12+2*x^11+(s*v/q)*x^8+(b*(c-a))*x^7+(s+q)*x^6+(q-s)*x^5+3*x^4+(4*(a+b))*x^3+(c*b/(a*s-c*v))*x^2+(s*a/(b-c*v))*x+q/(s-b*v))


       {
poly(a*b+c,a*b-c,x)
poly(a,a*b+c,d,x)
poly(a,a*b,d,x)
poly(a,a*b,x)
}
        //poly(a*b-c,i+ai,-1-bi/c,i-a/bi,1-a/b,i-b,c-i,i+a,z1)
        //poly(a*b-c,i+ai,-1-bi/c,i-a/bi,1-a/b,i-b,c-i,i+a,x)
        //poly(a*b-c,i+ai,x)
        //poly(2*3-c,i+1+5i,x)

        //poly(a,x,di+ai/c,bi-c,d,e,y,ai/bi-i,bi,b+a,-c,-d+ai,x-y,z1)
        //polynom(5*(z1+y),0,3*(2+3),4,5*(2+3+i),x)
        //polynom(4,3*(i-1),4,3,x*y)+polynom(12,6*(i-1),4,x*y)
        //polynom(4,2*(i-1),4,3,x*y)+polynom(12,3*(i-2),4,x*y)
        //x^y+polynom(12,3*(i-2),4,x*y)
        //x*t+polynom(2,3*(i-4),5,x*y)


         // sp2(sp1(2*(3+4/5)/7),sp2(5/8,8/9))*x*sp2(2*sp2(-sp1(9/7),sp2(7/(9-8),8/(9/5-7/3))/sp1(7/2)),i*sp3(2*(3-4/(7/5-9/4)),2*sp1(2/3),3/sp1(5/7)))



//      zres.re:= x*y*t*(t*x*(x*y-t*x)-x*y*(x*t-y*t)+y*x*(y*x-t*y)-(x+y)*(x-y)*(t-y)*(x*y-t*x*(x-y*(t-x*(t-x)*(x-t)*(t-y)-x*y-y))))-(x*t*y*(x*y-x*(y-y*(t-t*(x-x*t*(x*y-t*x-(x*y-t*x)*(x-y)*(y-t)*(t-y)-(x+t*y)*(y-x*t)+(t-y*t)*(y-t*x))))))) ;
//      zres.re:= -x/(x/y-t/(x+t)+x*y*(x*y-y*t+x/(x/(x+y)+y/(t+x))))*(y*(x-y/(x*y-y/(x*y+y*t)*(y*t-x*y)))+x-y*(x-t-t/(x-y)*(y/(y-t*(x+y*t)*(y-x*t)/(x*t-y*(x+t))))))*(x*y-t*y-t*(x*t-y*(t-x)/(x*y*t-x-y-t)));
//      zres.re:= x*y*(2.111*x+1)*(2.211*x*y/t-2.311*x*(3.422*t-1)/(2.511*x-3.611*y-4.22)*(x/(3.711*x-1)-4.111/x+5.111*(2.611*x*y*t-1.23)/(y+1.12)-7.132*(2.812*x*(y+1.123)*(3.832*y+2.121)*(3.112/(x+1.123)-2.133*t))));
//      zres.re:= x*y*(x-t*(2.123*x-3.222*y-5.323)/(t*x*y/(2.234-x*y)+(2.455*x+3.632)*(3.734*y-4.832*t-5.923)-(1.134-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.745*x-3.345*y-t))-y*(x*y-y*t*3.167+2.965*(x/t-t/(x-y*(2.467-x-y-t)))*(y-t)-2.376*x)*(y-x)-7.154/x)*(-1.943/t+x*y*t*5.334))-3.556*x-5.657)-7.243*y-3.459)/(x-t)+x*(t*y/(x-2.834*t)-y*(x*(t-2.756*y-x-5.676))));
//      zres.re:= (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t)-t*(-x-y*(-t*(-x*(y-t))))))))))));
//      zres.re:= x*y-x/(x/y-t/y-(-x-y*(x*y-t*x/(x/y-t/y-(-x-(-y-(-t-(x*y-y*(-x*y-y/(x+y*t)))*x)*y)/(x+y*t)-x*(y/t-(-y*x/(x-y*t)-(-x-(-y/(-x*y*(-x-y))+x/y*(y*x+y*t-x/(x+y*t))-x*y*(x*y+(-x*y-t/y+x-y*x)))))+x*y*t*(x+y*t)))))));
//      zres.re:= x*y*(x-t*(2.154*x-3.253*y-5.353)/(t*x*y/(2.544-x*y)+(2.143*x+3.556)*(3.343*y-4.153*t-5.456)-(1.153-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.644*x-3.364*y-t))-y*(x*y-y*t*3.164+2.267*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.535/x)*(-1.253/t+x*y*t*5.353))-3.433*x-5.455)-7.466*y-3.577)/(x-t)+x*(t*y/(x-2.699*t)-y*(x*(t-2.767*y-x-5.854)-y*(-1.549-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.344/y-x*y*(2.435*x-1.456)*(t*y*3.326-5.347)*(1.943-x*y*t*3.245)*(x+y))))));
//      zres.re:= (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t*(x-y*(t-x*y-y*(x*y-t*x)-t*(t*x+y))))-t*(-x-y*(-t*(-x*(y-t*(x*y*t-y*x*t*(-x*(y*x-t*y-x-y-t)))))))))))))));
//      zres.re:= (x*y+t/(x*y-y*t/x-x+y-t))*(x+y+t)/(x-y-t)*(t-x*(t-y/(x-y-t)))*x/y*t-x*t*(x*t-y*t+x-t)/(y*x+t*x+t/y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y/(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t/(x-y*(t-x*y-y/(x*y-t*x)-t/(t/x+y))))-t*(-x-y*(-t/(-x*(y-t*(x*y/t-y*x*t/(-x*(y*x-t*y-x-y-t)))))))))))))));
//      zres.re:= x*y*(x-t*(2.156*x-3.652*y-5.653)/(t*x*y/(2.664-x*y)+(2.155*x+3.543)*(3.345*y-4.431*t-5.443)-(1.451-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.453*x-3.353*y-t))-y*(x*y-y*t*3.153+2.253*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.553/x)*(-1.253/t+x*y*t*5.533))-3.453*x-5.453)-7.453*y-3.553)/(x-t)+x*(t*y/(x-2.653*t)-y*(x*(t-2.753*y-x-5.853)-y*(-1.539-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.553/y-x*y*(2.535*x-1.53)*(t*y*3.536-5.753)*(1.539-x*y*t*3.665)*(x+y*(t-(-x-y*t/(x*y-2.863*(x*y*(x-y*(x*t+y/t*(2.623*x-1.352-t*y))))))))))))) ;
//      zres.re:= x*y*(2.251*x+1)*(2.243*x*y/t-2.353*x*(3.475*t-1)/(2.575*x-3.675*y-4.766)*(x/(3.767*x-1)-4.176/x+5.186*(2.866*x*y*t-1.766)/(y+1.876)-7.165*(2.874*x*(y+1.641)*(3.864*y+2.162)*(3.171/(x+1.765)-2.173*t/(2.174*x*y*t-1.171)+(4.171*x-1.164)*(5.172*y-7.174)/(x-2.175*y-1.747-2.174*t/(3.618-7.716*x-8.181*y*(4.612*x/(2.189*t+1.165)-7.198*x-8.149/t+9.912*(2.199*x-1.261)*(3.107*x+4.179*y+5.108)*(2.271*x*y*t-7.179)*x*y*t/(x-y*2.282-3.621/(x/(t-1.147)-7.198/(y+2.245)+8.233/(2.288*x*y*t+1.247)-9.174)))))/(x-1.525)))));

         //zres.re:=sp8i(vd1,n+k*2,x*y+x*t/(t*x-y*t/(x/t-y*t/(x*t-y*x/(y/t-x*y/(t*x-y*x))))),ve1,k*n*2,x*t*(x/t-y/(2.65/t*(x+y)-y*t/(2.87*x-t*2.97/(t*(x-t)-t*x/(x*t-y*t*x))))),vi2,n*2+k*3);
        //ms6(vd,z1/ps6(vd,z1,ve,n+j, z2-z1-z2/sp6(vd,-z1,ve,n+m, -z2, k+j), j),ve,n, i*ps6(vd,z1/z2,ve,n+m, z2/z3, 2*j+3), j*5-3)
         //flResultE(FZ1,zrese.re);
        // zrese.re:=Test2F;

       //  try(); x=power(-1.1,4.5) +y; exception()
      // try(); x=power(-1.1,y); exception()
     // try(); x=ln(-y); exception()
    // x=power(-1.1,y); power(-1.1,t)
  //  try(); x=power(-1.1,y); x=exception();  power(-1.1,y);
  //try(); x=sqrt(-y); x=exception();  sqrt(-y)
  // try(); x=x/sin(x-x); x=exception();

  //x*((1000*(2*3/5+2.7*65))^(1000+2*(5/(2+3)+55)))*y
  //x+y*(y-t*2/(4-(8-2*2))+t)+x/t
  //x+2/(4-(8-2*2))

   //try(); t=sqrt(-y); x1:dbl=exception(); try(); x2:dbl=exception(); x1+x2
   //x*y+t*y+y*t*(y+x*t)
   //x1*x2+x3*x4+x5*x6*(x7+x8*x9)

   // iff(1>2) !!!!!    iff(1>2)*x !!!
   //vd[1+2*3*(5-2+3)]*x !!!
   //vd[1+(5)]
   //sum(1,2,3)         !!!
   //y*2/(3*(3/(2*3-5/(7-8/9))-4/(2/3-4/(5-6/(7/9-8/(3-7/8))))-5*6/7/8)-4/(2-3/(4-5/7))-5/(2/(9-4/5)-3/(3/7-9/5)))*x
  //-x/(x*y*(x*y))  !!! Func replace on/off отключает operation replace





          //poly(2,y,2+3*4,x)
   //poly(1,2*a+b,3*a+b,2,y,3,t,u,4*a+b,5*a+b,4,5,v,6,6*a+b,s,x)

       // zrese.re:=sp3(sp2(x+t,y-x),sp3(x-y,x+y,y+t),sp1(sp2(x*y,y-t)))*sp3(sp1(t-y),sp1(t-y*t),sp2(t-x,y*x+x));
       //sp3(sp2(x+t,y-x),sp3(x-y,x+y,y+t),sp1(sp2(x*y,y-t)))*sp3(sp1(t-y),sp1(t-y*t),sp2(t-x,y*x+x))
       //pc3(pc2(x+t,y-x),pc3(x-y,x+y,y+t),pc1(pc2(x*y,y-t)))*pc3(pc1(t-y),pc1(t-y*t),pc2(t-x,y*x+x))



          //flCopyArrayExt(@vse[0], @vde[0], Length(vse));
          //flCopyArrayExtDSC(@vse[0], @vde[0], 10,10,  Length(vse));
          //flCopyMemory(@vse[0], @vde[0],  Length(vse)*10);
          //flCopyArrayDbl(@vsd[0], @vdd[0], Length(vsd));
          //flCopyArrayInt(@vsi[0], @vdi[0], Length(vsi));
          // flCopyVarCxE(@z1e,@z2e);
          //flCopyVarCxD(@z1d,@z2d);


         // zrese.re:=PolEvalX(x, ar, M1);

          {Exc:=flGetFPUException();
           if Exc <> 0 then goto endc; }
          //if Exc = fl_YES then goto endc;
          //1 - ivalid op; 4 div zero ; 8 - overflow


          {Exc:=flResultSafeE(FZ1,zrese.re);
          if Exc <> 0 then goto endc; }



          Exc:=flResultSafeRE(FZ1,zrese.re{,Exc});
          //Exc:=flResultSafeE(FZ1, zrese.re);

          if Exc <> 0 then
          begin

          end;



    //spt1(x-spt1(x+y*spt1(x-y*spt1(t+x))+spt1(y-x)))+spt1(y-spt1(x*y-t))
    //spt1(x-spt1(y-spt1(y-x)+spt1(x-y)))+spt1(t-spt1(t+spt1(x+t)))
    //spt3(x,y-spt3(x,spt1(x-spt3(x,-y,t+spt3(t,x,y))),spt3(-y,t,-x-spt3(y,t,x))),spt3(x,t+spt3(-x,-y,t),y))+spt3(spt3(x-y,t,x),t,spt3(-y,t,-x))

      //ERROR!!!
   {

   ((2*x)*(-b))-(((-x)*y)*(-y))-(a/x)+((-a)-((x*y)/c))/((-b)-(x*y))*((-a)-(b*c))*(-(3/(3^1)))*((x*(((-y)-b)-(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(-((-d)-(x/((-b)-y)))))))+((x*y)/((((a*x)-(y*b))-c)-1)))+((((((((((y*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))+((x*y)*(y-(((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c))))+(x*(y+(((((-1)-(2*(-b)))-
   ((-y)^2))-((-a)/(x^2)))-((y*c)/(c^2)))))))))*((-b)-(x*y)))-(((x*y)*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))*(-y)))/(((-b)-(x*y))^2))*((-a)-(b*c)))*y)*((-2)-(x/3)))+((((((x*y)*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))/((-b)-(x*y)))*((-a)-(b*c)))*y)*(-(3/(3^1)))))*((x*((-1)-((((3*(((-(b*2))/(((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y))^2))-2))*c)*(-((-d)-
   (x/((-b)-y)))))+(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(x/(((-b)-y)^2))))))+(((x*((((a*x)-(y*b))-c)-1))-((x*y)*(-b)))/(((((a*x)-(y*b))-c)-1)^2))))+
   (((((((((((x*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))+((x*y)*(x-(x*(x+(((-1)-((x*y)-((-x)*y)))-((x*c)/(c^2))))))))*((-b)-(x*y)))-(((x*y)*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c))))))))))))))))

   }



//-(-(-x)*(-x)*(-x))*(-((-x)*(-x)))
 //(-x)*(-(y-x)-(-x*y*(-x)-x)*(-((-x)-y*x)-(-y*x))*(-y-x*(-x*(-x)-y*(-y*(-x-y)))))
 //((-((-x)-y*x)-(-y*x)))
 //-((-x)-y*x)-(-y)
 //-((-x)-x)-(-y)
 //((-x)-x)-(-y)
 //((-x)-x)+y

 //(-y-x*(-x*(-x)-y*(-y*(-x-y))))
 //(-y-(-(-x)-y*(-y*(-x-y))))
 //(-y-(-(-x)-(-(-x-y))))
 //-(-(-x)-(-(-x-y)))
 //-(-x)-(-(-x-y))
 //(-x)-(-(-x-y))
 //(-x)-(-x-y)

//(-x-(-y-(-x*(-y)*(-y*x-x*(-x*(-y*x*(y-x)*(x-y)))*(-y-x*(-x-(-x*(-y))*(-x)*y*(x*(-y)-(-x)*y*(y+x)))*(-x)))*(-y))))
//(-x-(-y-(-x/(-y)*(-y*x-x/(-x/(-y*x*(y-x)/(x-y)))*(-y-x/(-x-(-x*(-y))/(-x)*y/(x*(-y)-(-x)/y/(y+x)))*(-x)))/(-y))))
//-(-(-x-(-x*(-y-(-x)*(-y))*(-x-y*(-y/(-x/(-x-y/(-x)))))))*(-x*(-y/(-x-y/x)))-y*(-x-y/(-(-(-x-y/(-x/(x-y)))))))
//-x/y-(-1-x*(-2-(-(-(-3-(-x-(-y)))))-x*(-y/(-3-x-y-x*(-4-(-(-x/(-y-5-x*(-x-6-y-y*(-x/(-y/(-8/(-x-9/(-y)))-7/(-x))))))))))))

//(-sin(-x)-(-1/(-cos(-y)*a)))*sin(a*cos(-x)-b)-x*(-x/cos(-y)-b*(sin(x)-cos(y)*b-c-c/cos(a*sin(x)-b))-sin(-y)/cos(a*sin(x)-b)-sin(-y)*cos(y)*(cos(a*cos(-x)-b)-cos(a*cos(x)-b)/(-(-a-sin(a*sin(-x)-b)*c)))-sin(y)/cos(x)/cos(a*sin(-x)-b)-b*sin(y)/cos(-x)/sin(a*sin(x)-b)/cos(a*sin(-y)-b))-(cos(a*sin(-y)-b)*sin(a*sin(-x)-b)/(x-sin(a*cos(-x)-b)))


   {

   ((-b)-(x*y))*((-a)-(b*c))*(-(3/(3^1)))*((x*(((-y)-b)-(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(-((-d)-(x/((-b)-y)))))))+((x*y)/((((a*x)-(y*b))-c)-1)))+((((((((((y*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))+((x*y)*(y-(((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c))))+(x*(y+(((((-1)-(2*(-b)))-((-y)^2))-((-a)/(x^2)))-((y*c)/(c^2)))))))))*((-b)-(x*y)))-
   (((x*y)*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))*(-y)))/(((-b)-(x*y))^2))*((-a)-(b*c)))*y)*((-2)-(x/3)))+((((((x*y)*(((-x)*(-y))-(x*((y*x)+
   ((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))/((-b)-(x*y)))*((-a)-(b*c)))*y)*(-(3/(3^1)))))*((x*((-1)-((((3*(((-(b*2))/(((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y))^2))-2))*c)*(-((-d)-(x/((-b)-y)))))+(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(x/(((-b)-y)^2))))))+(((x*((((a*x)-(y*b))-c)-1))-((x*y)*(-b)))/(((((a*x)-(y*b))-c)-1)^2))))+((x*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-
   (((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))+((x*y)*(x-(x*(x+(((-1)-((x*y)-((-x)*y)))-((x*c)/(c^2))))))))

    }

  //zs1:Complex=z1; zs2: Complex=z2; n1:int=0;   for(n1, 1, 99, x=zs1.re*ve[n1]; zs2=(zs1/ve[n1]+ve[n1]/zs1) ; zs1=x/zs2+i*zs1);zs1
  //zs1:Complex=z1; zs2: Complex=z2; n1:int=0;   for(n1, 1, 99,  zs1=zs1.re*ve[n1]/((zs1/ve[n1]+ve[n1]/zs1))+i*zs1);zs1
  //for(j,0,1,t=(x^2+x)*(x^2+x) ); t
        //for(j,0,1,t=(sin(x)+x)*(sin(x)+x) ); t

        //for(j,0,10,t=(sin(vd1[j])+x)*(sin(vd1[j])+x) ); t
          // for(j,0,10,t=sin(vd1[j+1])*sin(vd1[j+1]) ); t !!!!!!!!!!!!!!!!!!!!
           //for(j,0,10,t=sin(vd1[j]+x)*sin(vd1[j]+x) ); t
           //for(j,0,10,x=sin(vd1[j]+x)*sin(vd1[j]+x) ;y=cos(vd1[j]+x)*cos(vd1[j]+x) ); x+y
        //if(sin(x)>sin(x),sin(x),sin(x))
        //if(sin(x)>sin(x),sin(t),sin(t))+if(sin(t)>sin(t),sin(x),sin(x))
        //sin(x)+if(sin(x)>sin(x),sin(x),sin(x))+sin(t)+if(sin(t)>sin(t),sin(t),sin(t))

   // ((-a)-(b*c))*(-(3/(3^1)))*((x*(((-y)-b)-(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(-((-d)-(x/((-b)-y)))))))+((x*y)/((((a*x)-(y*b))-c)-1)))+((((((((((y*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))+((x*y)*(y-(((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c))))+(x*(y+(((((-1)-(2*(-b)))-((-y)^2))-((-a)/(x^2)))-((y*c)/(c^2)))))))))*((-b)-(x*y)))-(((x*y)*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))*(-y)))/(((-b)-(x*y))^2))*((-a)-(b*c)))*y)*((-2)-(x/3)))+((((((x*y)*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))/((-b)-(x*y)))*((-a)-(b*c)))*y)*(-(3/(3^1))))))

    //((-a)-(b*c))*(-(3/(3^1)))*((x*(((-y)-b)-(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(-((-d)-(x/((-b)-y)))))))+((x*y)/((((a*x)-(y*b))-c)-1)))+((((((((((y*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))+((x*y)*(y-(((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c))))+(x*(y+(((((-1)-(2*(-b)))-((-y)^2))-((-a)/(x^2)))-((y*c)/(c^2)))))))))*(-b-x*y)))))))+x*(-(3/(3^1)))))

    //((-a)-(b*c))*(-(3/(3^1)))*((x*(((-y)-b)-(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(-((-d)-(x/((-b)-y)))))))+((x*y)/((((a*x)-(y*b))-c)-1)))+((((((((((y*(((-x)*(-y))-(x*((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c)))))))+((x*y)*(y-(((y*x)+((((((-x)-y)-((2*x)*(-b)))-(((-x)*y)*(-y)))-(a/x))+((-a)-((x*y)/c))))+(x*(y+(((((-1)-(2*(-b)))-((-y)^2))-((-a)/(x^2)))-((y*c)/(c^2)))))))))*(-b-x*y)))))))+3/(3^1)))

  //((-a)-(b*c))*(-(3/(3^1)))*((x*(((-y)-b)-(((3*((((((-b)/((((x*a)-((((b*2)*(-c))*x)*b))-(c*x))-(2*y)))-c)-x)-2)-(y*2)))*c)*(-((-d)-(x/((-b)-y)))))))+((x*y)/((((a*x)-(y*b))-c)-1)))+((((((((((y*(((-x)*(-y)))))))))))+3/(3^1)))

 // ((-a)-(b*c))*(-(3/(3^1)))*(x*b)+(((x*y)+3/(3^1)))
// (3/(3^1))+(3/(3^1))
//(3*(3^1))+(3*(3^1))


 // ptr1=@z1.re; pint(ptr1)=1;  pint(ptr1+4)=2;   pint(ptr1+8)=3;  pint(ptr1)+pint(ptr1+4)+pint(ptr1+8)
 // ptr1=@z1.re; pintx(ptr1,1);  pintx(ptr1+4,2);   pintx(ptr1+8,3);  pintx(ptr1)+pintx(ptr1+4)+pintx(ptr1+8)
 // ptr1=@vi[0]; L=Pinteger(ptr1-4)-1; si:int=0; for(k=0,L,si=si+PInteger(Ptr1+4*k)); si/sum(vi)                           //  only for delphi !
 // ptr1=@z1.re; PExtended(Ptr1)=100;  PExtended(Ptr1+16)=1000;  PExtended(Ptr1)+ i* PExtended(Ptr1+16)
 // ptr1=@ve[0]; L=Pinteger(ptr1-4)-1; s:ext=0; for(k=0,L,PExtended(Ptr1+10*k)=k);  for(k=0,L, s=s+PExtended(Ptr1+10*k)); s/sum(ve)       //  only for delphi !


 // L: int=100; vx:ArrayExt=L; vpu:ArrayPtr=L;  for(k=0,L-1,vpu[k]=@vx[k]); for(k=0,L-1,PExtended(vpu[k])=k); sum(vx);
 // L: int=100; vx:ArrayExt=L; vpu:ArrayPtr=L;  for(k=0,L-1,vpu[k]=@vx[k]); for(k=0,L-1,PExtended(vpu[k])=k); s:ext=0; for(k=0,L-1,s=s+PExtended(vpu[k]));s
 // L: int=100; vx:ArrayExt=L; vy:ArrayExt=L; vpu:ArrayPtr=L;  vpu1:ArrayPtr=L; for(k=0,L-1,vy[k]=k; vpu[k]=@vx[k];vpu1[k]=@vy[k] ); for(k=0,L-1,PExtended(vpu[k])=PExtended(vpu1[k])); sum(vx);

 //----------------------------------
                                //  Only for Delphi !
  //          ***EXTENDED:
  // L: int=100; vx:ArrayExt=L; for(k=0,L-1,vx[k]=k); PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); s:ext=0; for(k=0,Lvx-1,s=s+PExtended(PtrVx0+k*10)); s
  // L: int=100; vx:ArrayExt=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); for(k=0,Lvx-1,PExtended(PtrVx0+10*k)=k);  sum(vx)
  // L: int=100; vx:ArrayExt=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); PtrVxN:Pointer=PtrVx0;  for(k=0,Lvx-1, PtrVxN=PtrVx0+10*k; PExtended(PtrVxN)=k);  s:ext=0; PtrVxN=PtrVx0; for(k=0,Lvx-1, s=s+PExtended(PtrVxN); PtrVxN=PtrVxN+10;); s

   // L: int=100; vx:ArrayExt=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,PExtended(vxP[k])=k); sum(vx);
   // L: int=100; vx:ArrayExt=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,vx[k]=k); s:ext=0; for(k=0,L-1,s=s+PExtended(vxP[k])); s
   // L: int=100; vx:ArrayExt=L;  vy:ArrayExt=L; vxP:ArrayPtr=L;  vyP:ArrayPtr=L; for(k=0,L-1, vy[k]=k; vxP[k]=@vx[k]; vyP[k]=@vy[k] ); for(k=0,L-1,PExtended(vxP[k])=PExtended(vyP[k])); sum(vx);


   //         ***DOUBLE:
  // L: int=100; vx:ArrayDbl=L; for(k=0,L-1,vx[k]=k); PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); s:Dbl=0; for(k=0,Lvx-1,s=s+PDouble(PtrVx0+k*8)); s
  // L: int=100; vx:ArrayDbl=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); for(k=0,Lvx-1,PDouble(PtrVx0+8*k)=k);  sum(vx)
  // L: int=100; vx:ArrayDbl=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); PtrVxN:Pointer=PtrVx0;  for(k=0,Lvx-1, PtrVxN=PtrVx0+8*k; PDouble(PtrVxN)=k);  s:Dbl=0; PtrVxN=PtrVx0; for(k=0,Lvx-1, s=s+PDouble(PtrVxN); PtrVxN=PtrVxN+8;); s

   // L: int=100; vx:ArrayDbl=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,PDouble(vxP[k])=k); sum(vx);
   // L: int=100; vx:ArrayDbl=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,vx[k]=k); s:Dbl=0; for(k=0,L-1,s=s+PDouble(vxP[k])); s
   // L: int=100; vx:ArrayDbl=L;  vy:ArrayDbl=L; vxP:ArrayPtr=L;  vyP:ArrayPtr=L; for(k=0,L-1, vy[k]=k; vxP[k]=@vx[k]; vyP[k]=@vy[k] ); for(k=0,L-1,PDouble(vxP[k])=PDouble(vyP[k])); sum(vx);

   //       *** INTEGER
   // L: int=100; vx:ArrayInt=L; for(k=0,L-1,vx[k]=k); PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); s:Int=0; for(k=0,Lvx-1,s=s+PInteger(PtrVx0+k*4)); s
  // L: int=100; vx:ArrayInt=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); for(k=0,Lvx-1,PInteger(PtrVx0+4*k)=k);  sum(vx)
  // L: int=100; vx:ArrayInt=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); PtrVxN:Pointer=PtrVx0;  for(k=0,Lvx-1, PtrVxN=PtrVx0+4*k; PInteger(PtrVxN)=k);  s:Int=0; PtrVxN=PtrVx0; for(k=0,Lvx-1, s=s+PInteger(PtrVxN); PtrVxN=PtrVxN+4;); s

   // L: int=100; vx:ArrayInt=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,PInteger(vxP[k])=k); sum(vx);
   // L: int=100; vx:ArrayInt=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,vx[k]=k); s:Int=0; for(k=0,L-1,s=s+PInteger(vxP[k])); s
   // L: int=100; vx:ArrayInt=L;  vy:ArrayInt=L; vxP:ArrayPtr=L;  vyP:ArrayPtr=L; for(k=0,L-1, vy[k]=k; vxP[k]=@vx[k]; vyP[k]=@vy[k] ); for(k=0,L-1,PInteger(vxP[k])=PInteger(vyP[k])); sum(vx);


   //        ***SINGLE
   // L: int=100; vx:ArraySng=L; for(k=0,L-1,vx[k]=k); PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); s:Sng=0; for(k=0,Lvx-1,s=s+PSingle(PtrVx0+k*4)); s
  // L: int=100; vx:ArraySng=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); for(k=0,Lvx-1,PSingle(PtrVx0+4*k)=k);  sum(vx)
  // L: int=100; vx:ArraySng=L; PtrVx0:Pointer=@vx[0]; Lvx:int=Pinteger(PtrVx0-4); PtrVxN:Pointer=PtrVx0;  for(k=0,Lvx-1, PtrVxN=PtrVx0+4*k; PSingle(PtrVxN)=k);  s:Sng=0; PtrVxN=PtrVx0; for(k=0,Lvx-1, s=s+PSingle(PtrVxN); PtrVxN=PtrVxN+4;); s

   // L: int=100; vx:ArraySng=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,PSingle(vxP[k])=k); sum(vx);
   // L: int=100; vx:ArraySng=L;  vxP:ArrayPtr = L; for(k=0,L-1,vxP[k]=@vx[k]);  for(k=0,L-1,vx[k]=k); s:Sng=0; for(k=0,L-1,s=s+PSingle(vxP[k])); s
   // L: int=100; vx:ArraySng=L;  vy:ArraySng=L; vxP:ArrayPtr=L;  vyP:ArrayPtr=L; for(k=0,L-1, vy[k]=k; vxP[k]=@vx[k]; vyP[k]=@vy[k] ); for(k=0,L-1,PSingle(vxP[k])=PSingle(vyP[k])); sum(vx);



 //----------------------------------
  ptr1=@z1.re; vp1[0]=ptr1; vp1[1]=ptr1+16;  Pextended(vp1[0])+i*PExtended(vp1[1])
  ptr1=@z1.re; vp1[0]=ptr1; vp1[1]=ptr1+8*k;  Pextended(vp1[0])+i*PExtended(vp1[1])

  Ptr0:Pointer=@ve[0]; L=Len(ve)-1; s:ext=0; for(k=0,L,s=s+PExtended(Ptr0+k*10)); s/sum(ve)
  Ptr0:Pointer=@ve[0]; L=Len(ve)-1; s:ext=0; for(k=0,L, s=s+PExtended(Ptr0); Ptr0=Ptr0+10); s/sum(ve)
  Ptr0:Pointer=@ve[0]; Ptrs:Pointer=Ptr0;  L=Len(ve)-1; s:ext=0; for(k=0,L,  Ptrs=Ptr0+k*10;  s=s+PExtended(Ptrs);); s/sum(ve)
  L:int=Len(ve); PtrV:ArrayPtr = L; for(k=0,L-1, Ptr1=@ve[k]; PtrV[k]=Ptr1); s:ext=0; for(k=0,L-1,s=s+PExtended(PtrV[k])); s/sum(ve)
  Ptr0:Pointer=@ve[0]; L=Len(ve)-1; s:ext=0; for(k=0,L,PExtended(Ptr0+k*10)=1.0); for(k=0,L,s=s+PExtended(Ptr0+k*10)); s/sum(ve)

  Ptr0:Pointer=@vd[0]; L=Len(vd)-1; s:dbl=0; for(k=0,L,s=s+PDouble(Ptr0+k*8)); s/sum(vd)
  Ptr0:Pointer=@vd[0]; L=Len(vd)-1; s:dbl=0; for(k=0,L, s=s+PDouble(Ptr0); Ptr0=Ptr0+8); s/sum(vd)
  Ptr0:Pointer=@vd[0]; Ptrs:Pointer=Ptr0;  L=Len(vd)-1; s:dbl=0; for(k=0,L, Ptrs=Ptr0+k*8;  s=s+PDouble(Ptrs)); s/sum(vd)


  Ptr0:Pointer=@ve[0]; L=Len(ve)-1; s:ext=0; for(k=0,L,PExtended(@ve[k],1.0)); for(k=0,L,s=s+PExtended(Ptr0+k*10)); s/sum(ve)
  Ptr0:Pointer=@ve[0]; L=Len(ve)-1; s:ext=0; for(k=0,L,PExtended(Ptr0+k*10,1.0)); for(k=0,L,s=s+PExtended(Ptr0+k*10)); s/sum(ve)


  L:int=Len(ve); PtrV:ArrayPtr = L; for(k=0,L-1,PtrV[k]=@ve[k]); s:ext=0; for(k=0,L-1,s=s+PExtended(PtrV[k])); s/sum(ve)
*)


(*
 **************************************************************************************************************
    ****************************** FULL COPY  vd <= vs;  Len(Dst) = Len(Src) *************************************
    **************************************************************************************************************
                                       --- Double ---

    1.
    L:int=10; vd: arrayDbl=L; vs: arrayDbl=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  vd=vs;
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    2.
    L:int=10; vd: arrayDbl=L; vs: arrayDbl=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyArrayDbl(@vd,@vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayDbl=L; vs: arrayDbl=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );
    ptrs:ptr=@vs; ptrd:ptr=@vd;  CopyArrayDbl(ptrd,ptrs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayDbl=L; vs: arrayDbl=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyArray(vd,vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    3.
    L:int=10; vd: arrayDbl=L; vs: arrayDbl=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyMemDbl(@vd[0],@vs[0],L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayDbl=L; vs: arrayDbl=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );
    ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemDbl(ptrd,ptrs,L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();



                                   --- Extended ---

    1.
    L:int=10; vd: arrayExt=L; vs: arrayExt=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  vd=vs;
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    2.
    L:int=10; vd: arrayExt=L; vs: arrayExt=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyArrayExt(@vd,@vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayExt=L; vs: arrayExt=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );
    ptrs:ptr=@vs; ptrd:ptr=@vd;  CopyArrayExt(ptrd,ptrs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayExt=L; vs: arrayExt=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyArray(vd,vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    3.
    L:int=10; vd: arrayExt=L; vs: arrayExt=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyMemExt(@vd[0],@vs[0],L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayExt=L; vs: arrayExt=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );
    ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemExt(ptrd,ptrs,L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();



                                      --- Single ---

    1.
    L:int=10; vd: arraySng=L; vs: arraySng=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  vd=vs;
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    2.
    L:int=10; vd: arraySng=L; vs: arraySng=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyArraySng(@vd,@vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arraySng=L; vs: arraySng=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );
    ptrs:ptr=@vs; ptrd:ptr=@vd;  CopyArraySng(ptrd,ptrs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arraySng=L; vs: arraySng=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyArray(vd,vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    3.
    L:int=10; vd: arraySng=L; vs: arraySng=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );  CopyMemSng(@vd[0],@vs[0],L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arraySng=L; vs: arraySng=L;  k:int=0; for(k=0,L-1,vs[k]=k+0.1; vd[k]=k; );
    ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemSng(ptrd,ptrs,L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();


                                            --- Integer ---

    1.
    L:int=10; vd: arrayInt=L; vs: arrayInt=L;  k:int=0; for(k=0,L-1,vs[k]=k+100; vd[k]=k; );  vd=vs;
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    2.
    L:int=10; vd: arrayInt=L; vs: arrayInt=L;  k:int=0; for(k=0,L-1,vs[k]=k+100; vd[k]=k; );  CopyArrayInt(@vd,@vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayInt=L; vs: arrayInt=L;  k:int=0; for(k=0,L-1,vs[k]=k+100; vd[k]=k; );
    ptrs:ptr=@vs; ptrd:ptr=@vd;  CopyArrayInt(ptrd,ptrs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayInt=L; vs: arrayInt=L;  k:int=0; for(k=0,L-1,vs[k]=k+100; vd[k]=k; );  CopyArray(vd,vs);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    3.
    L:int=10; vd: arrayInt=L; vs: arrayInt=L;  k:int=0; for(k=0,L-1,vs[k]=k+100; vd[k]=k; );  CopyMemInt(@vd[0],@vs[0],L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    L:int=10; vd: arrayInt=L; vs: arrayInt=L;  k:int=0; for(k=0,L-1,vs[k]=k+100; vd[k]=k; );
    ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemInt(ptrd,ptrs,L);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();




    **************************************************************************************************************
    ****************************** INSERT COPY  insert vs[ks] => vd[kd]  LI - cells;  Len(Dst) > Len(Src) ********************
    **************************************************************************************************************

        *** full copy: LI=LS, ks=0; kd=0; ***


                                  --- Double ---

    3.
    LS:int=10; LD:Int=20; LI:int=LS; vd: arrayDbl=LD; vs: arrayDbl=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; CopyMemDbl(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=LS;   vd: arrayDbl=LD; vs: arrayDbl=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemDbl(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();


                                    --- Extended ---

    3.
    LS:int=10; LD:Int=20; LI:int=LS; vd: arrayExt=LD; vs: arrayExt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; CopyMemExt(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=LS;   vd: arrayExt=LD; vs: arrayExt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemExt(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();



                                  --- Single ---

    3.
    LS:int=10; LD:Int=20; LI:int=LS; vd: arraySng=LD; vs: arraySng=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; CopyMemSng(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=LS;   vd: arraySng=LD; vs: arraySng=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemSng(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();


                                         --- Integer ---

    3.
    LS:int=10; LD:Int=20; LI:int=LS; vd: arrayInt=LD; vs: arrayInt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+100);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; CopyMemInt(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=LS;   vd: arrayInt=LD; vs: arrayInt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+100);  for(k=0, LD-1, vd[k]=k);
    ks:int=0; kd:int=0; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemInt(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();





         *** partial copying ( vs begin from ks=2 to vd from kd=12  LI=5 cells) ***

                                     --- Double ---
    3.
    LS:int=10; LD:Int=20; LI:int=5; vd: arrayDbl=LD; vs: arrayDbl=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; CopyMemDbl(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arrayDbl=LD; vs: arrayDbl=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemDbl(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arrayDbl=LD; vs: arrayDbl=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemDbl(ptrd+8*kd,ptrs+8*ks,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();


                                         --- Extended ---
    3.
    LS:int=10; LD:Int=20; LI:int=5; vd: arrayExt=LD; vs: arrayExt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; CopyMemExt(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arrayExt=LD; vs: arrayExt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemExt(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arrayExt=LD; vs: arrayExt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemExt(ptrd+10*kd,ptrs+10*ks,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();


                                     --- Single ---
    3.
    LS:int=10; LD:Int=20; LI:int=5; vd: arraySng=LD; vs: arraySng=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; CopyMemSng(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arraySng=LD; vs: arraySng=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemSng(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arraySng=LD; vs: arraySng=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+0.1);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemSng(ptrd+4*kd,ptrs+4*ks,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();


                                        --- Integer ---
    3.
    LS:int=10; LD:Int=20; LI:int=5; vd: arrayInt=LD; vs: arrayInt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+100);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; CopyMemInt(@vd[kd],@vs[ks],LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arrayInt=LD; vs: arrayInt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+100);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[ks]; ptrd:ptr=@vd[kd]; CopyMemInt(ptrd,ptrs,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();

    LS:int=10; LD:Int=20; LI:int=5;   vd: arrayInt=LD; vs: arrayInt=LS;
    k:int=0; for(k=0, LS-1, vs[k]=k+100);  for(k=0, LD-1, vd[k]=k);
    ks:int=2; kd:int=12; ptrs:ptr=@vs[0]; ptrd:ptr=@vd[0]; CopyMemInt(ptrd+4*kd,ptrs+4*ks,LI);
    PrintW2(vs); SpaceW2(1);  AsteriskW2();  PrintW2(vd);  SpaceW2(1);  AsteriskW2();


*)


//******************************* call func. by Ptr ****************************



function _RFuncPtr: TFloatType; stdcall;
begin
  _RFuncPtr:=2.5*PVX^+1.7*PVY^;
end;



procedure _ZFuncPtr;   stdcall;
var
 zt: TComplexFloat;
begin
  zt.re:=(2.5*PVZ1^.re-1.7*PVZ2^.re);
  zt.im:=(2.5*PVZ1^.im-1.7*PVZ2^.im);

  asm
    fld tbyte ptr zt.im
    fld tbyte ptr zt.re
  end;
end;



//2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i
procedure _NFuncPtr;  stdcall;
begin      //Resf - global var
  Resf.re:=2.5*(PVZ1^.re*PVX^+PVZ2^.re*PVY^);
  Resf.im:=1.7*(PVZ1^.im*PVY^-PVZ2^.im*PVX^);
end;






procedure _ZSumCallPtr;   stdcall;
var
 zt: TComplexE;
begin
  zt.re:=(z1.re+z2.re);
  zt.im:=(z1.im+z2.im);

  asm
    fld tbyte ptr zt.im
    fld tbyte ptr zt.re
  end;
end;




//by value of vp with copying
function _RSumCallPtrV(vp: TArrayP): Extended; stdcall;
var
i: integer;
S,Res: extended;
begin
   S:=0;
   for i:=0 to High(vp) do
   begin
     flResultE(vp[i],Res);
     S:=S+Res;
   end;
  _RSumCallPtrV:=S;
end;



//by ref. of vp without copying
function _RSumCallPtrVP(vp: PArrayP): Extended; stdcall;
var
i: integer;
S,Res: extended;
begin
   S:=0;
   for i:=0 to High(vp^) do
   begin
     flResultE(vp^[i],Res);
     S:=S+Res;
   end;
  _RSumCallPtrVP:=S;
end;




//by value of vp with copying
procedure _ZSumCallPtrV(vp: TArrayP); stdcall;
var
i: integer;
S,Res: TComplexE;
begin
   S.re:=0; S.im:=0;
   for i:=0 to High(vp) do
   begin
     flResultCxEP(vp[i],@Res);
     S.re:=S.re+Res.re;
     S.im:=S.im+Res.im;
   end;
    asm
    fld tbyte ptr S.im
    fld tbyte ptr S.re
  end;
end;



//by ref. of vp without copying
procedure _ZSumCallPtrVP(vp: PArrayP); stdcall;
var
i: integer;
S,Res: TComplexE;
begin
   S.re:=0; S.im:=0;
   for i:=0 to High(vp^) do
   begin
     flResultCxEP(vp^[i],@Res);
     S.re:=S.re+Res.re;
     S.im:=S.im+Res.im;
   end;
    asm
    fld tbyte ptr S.im
    fld tbyte ptr s.re
  end;
end;




//by value of vp with copying
procedure _ZNSumCallPtrV(vp: TArrayP); stdcall;
var
i: integer;
S: TComplexFloat;
begin
   S.re:=0; S.im:=0;
   for i:=0 to High(vp) do
   begin
     flResult(vp[i]);
     S.re:=Resf.re+S.re;
     S.im:=Resf.im+S.im;
   end;
   Resf:=S;
end;



//by ref. of vp without copying
procedure _ZnSumCallPtrVP(vp: PArrayP); stdcall;
var
i: integer;
S: TComplexFloat;
begin
   S.re:=0; S.im:=0;
   for i:=0 to High(vp^) do
   begin
     flResult(vp^[i]);
     S.re:=Resf.re+S.re;
     S.im:=Resf.im+S.im;
   end;
   Resf:=S;
end;





function _Func1XE: TFloatType; stdcall;
begin
  _Func1XE:=sqrt(PVX^);
end;


procedure _Proc1XE; stdcall;
begin
  resf.re:=sqrt(PVX^);
end;




procedure _Func1ZE;   stdcall;
var
re,im: extended;
begin
  re:=sqrt(PVZ1^.re);
  im:=sqrt(PVZ1^.im);

  asm
    fld tbyte ptr im
    fld tbyte ptr re
  end;
end;




procedure _Proc1ZE;   stdcall;
begin
  resf.re:=sqrt(PVZ1^.re);
  resf.im:=sqrt(PVZ1^.im);
end;




//******************************************************************************



procedure _SqrtR(x: extended); stdcall;
var
re,im:extended;
begin

 if x < 0 then
 begin
  re:=0;
  im:=sqrt(abs(x));
 end
 else
 begin
  re:=sqrt(x);
  im:=0;
 end;

 asm
    fld  im
    fld  re
 end
end;


procedure _SqrtCx(z: TComplexE);  stdcall;
var
re,im,t:extended;
s:integer;
begin
 s:=1;
 if z.im < 0 then s:=-1;
 t:=sqrt(sqr(z.re)+sqr(z.im));
 re:=sqrt((t+z.re)*0.5);
 im:=s*sqrt((t-z.re)*0.5);

 asm
    fld  im
    fld  re
 end

end;



function rand2(x1,x2:PExtended): extended;  stdcall;
begin
 rand2:=(x1^-x2^)*random+x2^;
end;


function _asm1: double;
begin
 _asm1:=Xd+Yd;
end;


//(sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or ( cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) or (sin(x) > cos(x*y)) ,cos(x),if( ((sin(x+y)*cos(x-y) > sin(cos(y)*x)) and
   {
   F_FAST_DIV
   Foreval_Command.F_FastDiv
   ZDIV
   RZDIV
   Z_IPWRN1
   ZDIVR_C1
   ZDIVR_i

   fl_COMPLEX_DIV =

   fl_FAST
   fl_STANDARD
   fl_ACCURATE
   fl_EXTRA
 }




procedure GetDllInfo;
var
ID: Cardinal;
S: String;
begin
  flGet(fl_Version,fl_Major,ID);    S:=IntToStr(ID);
  flGet(fl_Version,fl_Minor,ID);    S:=S+'.'+IntToStr(ID);
  flGet(fl_Version,fl_Release,ID);  S:=S+'.'+IntToStr(ID);
  flGet(fl_Version,fl_Build,ID);    S:=S+'.'+IntToStr(ID);

  Form1.Caption:='Test Foreval.dll  (v.'+S+')';


  flGet(fl_Compiled_by,0,ID);


if ID >= 100 then
begin
  Form1.Caption:=Form1.Caption+'.  Compiled by FPC v.' + IntToStr(ID);
  CompiledBy:=CompiledByFPC;
end
else
begin
 CompiledBy:=CompiledByDelphi;
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
  30: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10';
  31: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.1';
  32: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.2';
  33: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.3';
  34: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.4';
  35: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 11'
  else Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 11+' ;

end;
end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
    CreateForm;

    CB_Destroy.Enabled:=True;
    CB_Create.Enabled:=False;
end;


procedure TForm1.CreateForm;
label endp,endp1;
var
VT: TArrayC;
FS:TAddFuncStruct;
VTS: array [0..10] of integer;
  ic: Integer;
  S,S1,S2,S3,S4,S5: string;
  Len,ID:cardinal;
  IDN: Integer;
  Ptr: Pointer;
  CAddr: Cardinal;
  T1,T2: Cardinal;
Expr: TStringType;
ans:  AnsiString;
rRe,rIm: double;
FZ1: Pointer;
ni: Integer;
idfP,idfP1,idfP2,idfP3: TidFunc; //Pointer;
OpData: TOperData;
FData: TArrayI;
Lcs,lv,Sz,Lm: Cardinal;
ax,bx,hx,sx,fx,dx,dy: extended;
Attr: TAttrib; //TAttribExt;
IdOp,OpPrior,Placement,NFunc,NArg: Integer;
OpSymb: String;
Err,LenV: Cardinal;
BOpN: Boolean;

begin


Randomize;
InitDF;
InitIntegral;



{$IFDEF STRING}       flSet(fl_STRING_TYPE,fl_STRING,0);     {$ENDIF}
{$IFDEF ANSISTRING}   flSet(fl_STRING_TYPE,fl_ANSISTRING,0);   {$ENDIF}
{$IFDEF WIDESTRING}   flSet(fl_STRING_TYPE,fl_WIDESTRING,0);    {$ENDIF}
{$IFDEF PANSICHAR}    flSet(fl_STRING_TYPE,fl_PAnsiChar,0);   {$ENDIF}
{$IFDEF UTF8}         flSet(fl_String_Type,fl_String_UTF8,0);   {$ENDIF}



 flSet(fl_COMPILER_TYPE_EXE, fl_DELPHI, 0);

{$IFDEF FPC}
  flSet(fl_COMPILER_TYPE_EXE, fl_FREE_PASCAL, 0);
{$ENDIF}

GetDllInfo;

// flSet(fl_COMPILER_TYPE_EXE, fl_FREE_PASCAL, 0);

// flSet(fl_ENABLE,fl_USE_INTEGER_POINTER,0);

// flSet(fl_Enable,fl_Show_Exception,0);

// flSet(fl_Enable,fl_CHECK_INCORRECT_SPACE,0);
// flSetNameImUnit('ii');
// flSet(fl_Disable,fl_LEAD_TO_LOER_CASE,0);

flSet(fl_Disable,fl_USE_VIRTUAL_ALLOC,0 );
flSet(fl_Disable, fl_MASK_FPU_EXCEPTION,0);


flSet(fl_Enable, fl_INSERT_INLINE, 0);

flSet(fl_Enable,fl_ACCURATE_SPEC_FUNC,0);

//flSet(fl_ARCCOTAN_TYPE,fl_ARCCOTAN_1DIV_ARG,0);

//flSet(fl_RETURN_VAL_ON_ZERO_LENGTH,fl_NAN,0);

flSetExtAddrErrorFPU(@FPUError);
PFPUErrorAddr:=Cardinal(@FPUError);


GetLocaleFormatSettings(0,G_FMT);
G_FMT.DecimalSeparator:='.';
F_LoadExprFile:=False;
G_ResCalcType:=fl_STAY_AS_IS;

F_NoCalc:=False;
F_SafeCalc:=False;

{$IFDEF FASTDIV}
   //CB_FD.Checked:=True;
   RB_ZDiv_Fast.Checked:=True;
   flSet(fl_Enable,fl_FAST_DIV,0);
{$ELSE}
   //CB_FD.Checked:=False;
   RB_ZDiv_Fast.Checked:=False;
   flSet(fl_Disable,fl_FAST_DIV,0);
{$ENDIF}

G_ZDIV:=2; //STD_DIV

//flSet(fl_SPEC_FUNC,fl_FAST,0);
//flSet(fl_SPEC_FUNC,fl_ACCURATE,0);

//flSet(fl_Disable,fl_Syntax_Extension);

//goto endp;

//flSet(fl_Enable,fl_PACKAGE_COMPILE,0);

//flSet(fl_DISABLE,fl_USE_POINTER,0);
//flSet(fl_ENABLE,fl_USE_INTEGER_POINTER,0);


//save(y,sin(cos(x))); save(t,sin(cos(x))) ;y+t
//y=sin(cos(x)); t=sin(cos(x));y+t
//sp2(sin(cos(x)),sin(cos(x)))
//sin(cos(x))+sin(cos(x))
//y=sin(cos(x)); t=sin(cos(x))


{
flGetFuncIDN('swap',IDN);
flAddNameFunction(IDN,'xch');
}

//GetMem(Ptr,100);
//flSet(fl_Disable,fl_OPTIMIZATION_A1,0);


RetValOnNil:=Nan_x;

A:=2.54321;
B:=-3.98765;
C:=4.12345;
D:=-5.6789;
E:=-3.25;

P1r:=1;
P2r:=-1;
P1cx.re:=1;  P1cx.im:=0;
P2cx.re:=-1; P2cx.im:=0;
P3cx.re:=-1; P3cx.im:=-1;
P4cx.re:=0;  P4cx.im:=1;
P5cx.re:=0;  P5cx.im:=-1;
P6cx.re:=0;  P6cx.im:=3.456;



x1d:=2; x2d:=3;



Ae:=2.54321;
Be:=-3.98765;
Ce:=4.12345;
De:=-5.67893;
Ee:=-3.25715;
Fe:=7.35791;
Ge:=11.97531;




Acx.re:=Ae; Acx.im:=Ce;
Bcx.re:=Be; Bcx.im:=Ae;
Ccx.re:=Ce; Ccx.im:=Be;
Dcx.re:=De; Dcx.im:=Ce-Ae;
Ecx.re:=Ee; Ecx.im:=Be-De;
Fcx.re:=Fe; Fcx.im:=Ge-Fe;
Gcx.re:=Ge; Gcx.Im:=Ae-Ge;

xd:=2.123;
yd:=5.456;
td:=-3.789;
sd:=-5.135;
rd:=1.357;
pd:=-2.246;
qd:=3.678;
ud:=-1.468;
v_d:=4.975;



xe:=2.123;
ye:=5.456;
te:=-3.789;
se:=-5.135;
r_e:=1.357;
pe:=2.246;
qe:=3.678;
ue:=-1.468;
v_e:=4.975;


xs:=2.123;
ys:=5.456;
ts:=-3.789;
ss:=-5.135;
rs:=1.357;



z1d.re:=2.123;     z1d.im:=-1.456;
z2d.re:=5.456;     z2d.im:=2.789;
z3d.re:=-3.789;    z3d.im:=-3.123;
z4d.re:=-5.135;    z4d.im:=3.975;
z5d.re:=2.246;     z5d.im:=1.753;

z1e.re:=2.123;     z1e.im:=-1.456;
z2e.re:=5.456;     z2e.im:=2.789;
z3e.re:=-3.789;    z3e.im:=-3.123;
z4e.re:=-5.135;    z4e.im:=3.975;
z5e.re:=2.246;     z5e.im:=1.753;

z1s.re:=2.123;     z1s.im:=-1.456;
z2s.re:=5.456;     z2s.im:=2.789;
z3s.re:=-3.789;    z3s.im:=-3.123;
z4s.re:=-5.135;    z4s.im:=3.975;
z5s.re:=2.246;     z5s.im:=1.753;

zxd.re:=xd;     zxd.im:=0;
zyd.re:=yd;     zyd.im:=0;
ztd.re:=td;     ztd.im:=0;
zsd.re:=sd;     zsd.im:=0;

zxe.re:=xe;     zxe.im:=0;
zye.re:=ye;     zye.im:=0;
zte.re:=te;     zte.im:=0;
zse.re:=se;     zse.im:=0;

zxs.re:=xs;     zxs.im:=0;
zys.re:=ys;     zys.im:=0;
zts.re:=ts;     zts.im:=0;
zss.re:=ss;     zss.im:=0;


n:=1;
k:=2;
j:=5;
m:=-3;
l:=4;

//arg. with reload operations (z1,z2,z3,i: complex extended; x,y,t: extended):
z1.re:=z1e.re; z1.im:=z1e.im;
z2.re:=z2e.re; z2.im:=z2e.im;
z3.re:=z3e.re; z3.im:=z3e.im;
z4.re:=z4e.re; z4.im:=z4e.im;
z5.re:=z5e.re; z5.im:=z5e.im;


i.re:=0; i.im:=1;
i0.re:=0; i0.im:=0;
x:=xe; y:=ye; t:=te;
 {
    z1re = 1;  z1im = 5;
    z2re = 11; z2im = 3;
    z3re = 9;  z3im = 19;
    z1.re = CxVarAnyRE[z1re]; z1.im = CxVarAnyIM[z1im];
    z2.re = CxVarAnyRE[z2re]; z2.im = CxVarAnyIM[z2im];
    z3.re = CxVarAnyRE[z3re]; z3.im = CxVarAnyIM[z3im];
}
z1re := 1;  z1im := 5;
z2re := 11; z2im := 3;
z3re := 9;  z3im := 19;
CxVarAnyRE_E[z1re]:=z1e.re;   CxVarAnyIM_E[z1im]:=z1e.im;
CxVarAnyRE_E[z2re]:=z2e.re;   CxVarAnyIM_E[z2im]:=z2e.im;
CxVarAnyRE_E[z3re]:=z3e.re;   CxVarAnyIM_E[z3im]:=z3e.im;

CxVarAnyRE_D[z1re]:=z1d.re;   CxVarAnyIM_D[z1im]:=z1d.im;
CxVarAnyRE_D[z2re]:=z2d.re;   CxVarAnyIM_D[z2im]:=z2d.im;
CxVarAnyRE_D[z3re]:=z3d.re;   CxVarAnyIM_D[z3im]:=z3d.im;

CxVarAnyRE_S[z1re]:=z1s.re;   CxVarAnyIM_S[z1im]:=z1s.im;
CxVarAnyRE_S[z2re]:=z2s.re;   CxVarAnyIM_S[z2im]:=z2s.im;
CxVarAnyRE_S[z3re]:=z3s.re;   CxVarAnyIM_S[z3im]:=z3s.im;


//flSetVarCX('z1a',@Xe,@Ee,fl_Complex_Extended);
{
CAddr1:=Cardinal(@CxVarAnyRE_E[z1re]);
PExtended(CAddr1)^:=111.111;
z1.re:=PExtended(CAddr1)^+x;
//CAddr:=Cardinal(@Xe);
asm
  push eax
  mov eax,CAddr
  fld tbyte ptr [eax]
  pop eax
end;}
 {
flSetVarCX('z1a',@CxVarAnyRE_E[z1re],@CxVarAnyIM_E[z1im],fl_Complex_Extended);
CAddr1:=Cardinal(@CxVarAnyRE_E[z1re]);
//CAddr3:=Cardinal(@CxVarAnyRE_E[z1im]);
CAddr2:=Cardinal(@z1e.re);
asm
  push eax
  mov eax,CAddr1
  fld tbyte ptr [eax]
  mov eax,CAddr2
  fld tbyte ptr [eax]
  pop eax
  fstp st(0)
  fstp st(0)

end;
    }
//PExtended(@CxVarAnyRE_E[z1re])^:=111.111;
//z1.re:=PExtended(@CxVarAnyRE_E[z1re])^+x;


//**************************************
x1d:=1.234; x2d:=2.345; x3d:=-3.456; x4d:=-5.678; x5d:=7.891;
x1e:=1.234; x2e:=2.345; x3e:=-3.456; x4e:=-5.678; x5e:=7.891;
x1s:=1.234; x2s:=2.345; x3s:=-3.456; x4s:=-5.678; x5s:=7.891;
n1:=3; n2:=5; n3:=7; n4:=9; n5:=10;


flSetVar('x1e',@x1e,fl_Real_Extended);
flSetVar('x2e',@x2e,fl_Real_Extended);
flSetVar('x3e',@x3e,fl_Real_Extended);
flSetVar('x4e',@x4e,fl_Real_Extended);
flSetVar('x5e',@x5e,fl_Real_Extended);


flSetVar('x1d',@x1d,fl_Real_Double);
flSetVar('x2d',@x2d,fl_Real_Double);
flSetVar('x3d',@x3d,fl_Real_Double);
flSetVar('x4d',@x4d,fl_Real_Double);
flSetVar('x5d',@x5d,fl_Real_Double);


flSetVar('x1s',@x1s,fl_Real_Single);
flSetVar('x2s',@x2s,fl_Real_Single);
flSetVar('x3s',@x3s,fl_Real_Single);
flSetVar('x4s',@x4s,fl_Real_Single);
flSetVar('x5s',@x5s,fl_Real_Single);


flSetVar('z1e',@z1e,fl_Complex_Extended);
flSetVar('z2e',@z2e,fl_Complex_Extended);
flSetVar('z3e',@z3e,fl_Complex_Extended);
flSetVar('z4e',@z4e,fl_Complex_Extended);
flSetVar('z5e',@z5e,fl_Complex_Extended);


flSetVar('z1d',@z1d,fl_Complex_Double);
flSetVar('z2d',@z2d,fl_Complex_Double);
flSetVar('z3d',@z3d,fl_Complex_Double);
flSetVar('z4d',@z4d,fl_Complex_Double);
flSetVar('z5d',@z5d,fl_Complex_Double);


flSetVar('z1s',@z1s,fl_Complex_Single);
flSetVar('z2s',@z2s,fl_Complex_Single);
flSetVar('z3s',@z3s,fl_Complex_Single);
flSetVar('z4s',@z4s,fl_Complex_Single);
flSetVar('z5s',@z5s,fl_Complex_Single);



flSetVar('n1',@n1,fl_real_Integer);
flSetVar('n2',@n2,fl_real_Integer);
flSetVar('n3',@n3,fl_real_Integer);
flSetVar('n4',@n4,fl_real_Integer);
flSetVar('n5',@n5,fl_real_Integer);



//*******************************************

  {
  flSetVar('x',@xe,c_RealFloat);
  flSetVar('y',@ye,c_RealFloat);
  flSetVar('t',@te,c_RealFloat);
  }
  flSetVar('s',@se,fl_Real_Extended);
  flSetVar('r',@r_e,fl_Real_Extended);
  flSetVar('p',@pe,fl_Real_Extended);
  flSetVar('q',@qe,fl_Real_Extended);
  flSetVar('u',@ue,fl_Real_Extended);
  flSetVar('v',@v_e,fl_Real_Extended);

  {
  flSetVar('z1',@z1e,c_ComplexFloat);
  flSetVar('z2',@z2e,c_ComplexFloat);
  flSetVar('z3',@z3e,c_ComplexFloat);
  }
  flSetVar('z4',@z4e,fl_Complex_Extended);
  flSetVar('z5',@z5e,fl_Complex_Extended);


  flSetVar('gx',@x,c_RealFloat);
  flSetVar('gy',@y,c_RealFloat);
  flSetVar('gt',@t,c_RealFloat);

  flSetVar('ptr1',@ptr1,fl_Pointer);
  flSetVar('ptr2',@ptr2,fl_Pointer);
  flSetVar('ptr3',@ptr3,fl_Pointer);
  flSetVar('ptr4',@ptr4,fl_Pointer);
  flSetVar('ptr5',@ptr5,fl_Pointer);

  //Integer(ptr1):=9;

{$IFDEF EXTENDED_FLOAT}
  RB_FVE.Checked:=True;
  L_AFT.Caption:='Extended';

  flSetVar('x',@xe,fl_Real_Extended);
  flSetVar('y',@ye,fl_Real_Extended);
  flSetVar('t',@te,fl_Real_Extended);
  flSetVar('r',@r_e,fl_Real_Extended);
  flSetVar('s',@se,fl_Real_Extended);


  flSetVar('z1',@z1e,fl_Complex_Extended);
  flSetVar('z2',@z2e,fl_Complex_Extended);
  flSetVar('z3',@z3e,fl_Complex_Extended);
  flSetVar('z4',@z4e,fl_Complex_Extended);
  flSetVar('z5',@z5e,fl_Complex_Extended);

  PVX:=@xe;  PVY:=@ye; PVT:=@te; PVR:=@r_e; PVS:=@se;
  PVZ1:=@z1e; PVZ2:=@z2e;  PVZ3:=@z3e; PVZ4:=@z4e; PVZ5:=@z5e;

{$ELSE}
  RB_FVD.Checked:=True;
  L_AFT.Caption:='Double';

  flSetVar('x',@xd,fl_Real_Double);
  flSetVar('y',@yd,fl_Real_Double);
  flSetVar('t',@td,fl_Real_Double);
  flSetVar('r',@rd,fl_Real_Double);
  flSetVar('s',@sd,fl_Real_Double);

  flSetVar('z1',@z1d,fl_Complex_Double);
  flSetVar('z2',@z2d,fl_Complex_Double);
  flSetVar('z3',@z3d,fl_Complex_Double);
  flSetVar('z4',@z4d,fl_Complex_Double);
  flSetVar('z5',@z5d,fl_Complex_Double);

  PVX:=@xd;  PVY:=@yd; PVT:=@td; PVR:=@rd; PVS:=@sd;
  PVZ1:=@z1d; PVZ2:=@z2d;  PVZ3:=@z3d; PVZ4:=@z4d; PVZ5:=@z5d;

{$ENDIF}


//goto endp;

flSetVar('error',@errorf,fl_Real_Integer);

flSetVar('n',@n,fl_real_Integer);
flSetVar('k',@k,fl_real_Integer);
flSetVar('j',@j,fl_real_Integer);
flSetVar('m',@m,fl_real_Integer);
flSetVar('l',@l,fl_real_Integer);

flSetParamE('a',Ae,0,fl_Real);
flSetParamE('b',Be,0,fl_Real);
flSetParamE('c',Ce,0,fl_Real);
flSetParamE('d',De,0,fl_Real);
flSetParamE('e',Ee,0,fl_Real);
flSetParamE('f',Fe,0,fl_Real);
flSetParamE('g',Ge,0,fl_Real);

flSetParamE('ai',Acx.re,Acx.im,fl_Complex);
flSetParamE('bi',Bcx.re,Bcx.im,fl_Complex);
flSetParamE('ci',Ccx.re,Ccx.im,fl_Complex);
flSetParamE('di',Dcx.re,Dcx.im,fl_Complex);
flSetParamE('ei',Ecx.re,Ecx.im,fl_Complex);
flSetParamE('fi',Fcx.re,Fcx.im,fl_Complex);
flSetParamE('gi',Gcx.re,Gcx.im,fl_Complex);

flSetParamE('p1',P1r,0,fl_Real);
flSetParamE('p2',P2r,0,fl_Real);
flSetParamE('p1i',P1cx.re,P1cx.im,fl_Complex);
flSetParamE('p2i',P2cx.re,P2cx.im,fl_Complex);
flSetParamE('p3i',P3cx.re,P3cx.im,fl_Complex);
flSetParamE('p4i',P4cx.re,P4cx.im,fl_Complex);
flSetParamE('p5i',P5cx.re,P5cx.im,fl_Complex);
flSetParamE('p6i',P6cx.re,P6cx.im,fl_Complex);





{
flSetVar('res',@resf,fl_Complex_Extended);
flSetVar('result',@resf,fl_Complex_Extended);
flSetVar('resr',@resf.re,fl_Real_Extended);
}
flSetVar('res',@resf,c_ComplexFloat);
flSetVar('result',@resf,c_ComplexFloat);
flSetVar('resr',@resf.re,c_RealFloat);

//goto endp;


//flSetVar('res',@resz.re,fl_Real_Double);
//flSetVar('pi',@c_pi,fl_Real_Extended);

{
 flSetVar('x',@xd,fl_Real_Double);
 flSetVar('y',@yd,fl_Real_Double);
 flSetVar('t',@td,fl_Real_Double);

 flSetVar('s',@sd,fl_Real_Double);
 flSetVar('p',@pd,fl_Real_Double);
 flSetVar('r',@rd,fl_Real_Double);

flSetVar('z1',@z1d,fl_Complex_Double);
flSetVar('z2',@z2d,fl_Complex_Double);
flSetVar('z3',@z3d,fl_Complex_Double);
flSetVar('res',@resf,fl_Complex_Extended);
flSetVar('result',@resf,fl_Complex_Extended);

flSetVar('ez1',@z1e,fl_complex_Extended);
flSetVar('ez2',@z2e,fl_complex_Extended);
flSetVar('ez3',@z3e,fl_complex_Extended);
flSetVar('ex',@xe,fl_Real_Extended);
flSetVar('ey',@ye,fl_Real_Extended);
flSetVar('et',@te,fl_Real_Extended);
 }



//x1*x2+x3*x4+x5*x6*(x7+x8*x9)
(*
SetLength(VX,20);
SetLength(VDZ,20);
for ni:= 0 to Length(VX) - 1 do
begin
  S:='x'+IntToStr(ni);
    {$IFDEF PANSICHAR}
       ans:=AnsiString(S); Expr:=PAnsiChar(ans);
    {$ELSE}
       Expr:=TStringType(S);
    {$ENDIF}

  flSetVar(Expr,@VX[ni],fl_Real_Double);
  VX[ni]:=ni;

  S:='w'+IntToStr(ni);
   {$IFDEF PANSICHAR}
       ans:=AnsiString(S); Expr:=PAnsiChar(ans);
    {$ELSE}
       Expr:=TStringType(S);
    {$ENDIF}
  flSetVar(Expr,@VDZ[ni],fl_Complex_Extended);
  VDZ[ni].re:=ni;
  VDZ[ni].im:=ni;
end;
*)

{flSetVar('a',@a,fl_Real_Double);
flSetVar('b',@b,fl_Real_Double);
flSetVar('c',@c,fl_Real_Double);
flSetVar('d',@d,fl_Real_Double);
flSetVar('e',@e,fl_Real_Double); }



flSetParamI('DblCS',8);  // size double
flSetParamI('ExtCS',10); // size extended
flSetVar('Ptr0M1u',@Ptr0M1u,fl_POINTER);
flSetVar('Ptr0M1ux',@Ptr0M1ux,fl_POINTER);
flSetVar('Ptr0M1uy',@Ptr0M1uy,fl_POINTER);
//Ptr0M1u:=&M1u[0];Ptr0M1ux:=&M1ux[0];Ptr0M1uy:=&M1uy[0];

flSetVar('Ptr0VU1',@Ptr0VU1,fl_POINTER);
flSetVar('Ptr0VU2',@Ptr0VU2,fl_POINTER);
flSetVar('Ptr0VU3',@Ptr0VU3,fl_POINTER);
//Ptr0VU1:=&vu1[0];Ptr0VU2:=&vu2[0];Ptr0VU3:=&vu3[0];

//array
G_LenV:=100;
LenV:=G_LenV;
{
SetLength(vd,LenV);    SetLength(vdt,LenV);
SetLength(ve,LenV);    SetLength(vet,LenV);
SetLength(vi,LenV);    SetLength(vit,LenV);
SetLength(vs,LenV);
SetLength(vd1,LenV);SetLength(vd2,LenV);SetLength(vd3,LenV);
SetLength(ve1,LenV);SetLength(ve2,LenV);SetLength(ve3,LenV);
SetLength(vi1,LenV);SetLength(vi2,LenV);SetLength(vi3,LenV);
SetLength(vs1,LenV);

SetLength(vu1,LenV);   SetLength(vu1t,LenV);
SetLength(vu2,LenV);   SetLength(vu2t,LenV);
SetLength(vu3,LenV);   SetLength(vu3t,LenV);

SetLength(vp1,LenV);
SetLength(vp2,LenV);
SetLength(vp3,LenV);
SetLength(vpu,LenV);
}

SetLength(vdt2,10);

for ic := 0 to 9 do
begin
   vdt2[ic]:=ic*1.1
end;






 //L:int=rand(100,1000000); SetLen(gvd,L); for(k,0,L-1,gvd[k]=1.0); sum(gvd)/L
flSetVarIntrnl('xvd',fl_ARRAY_REAL_DOUBLE,adrXVD);   flSetLength(adrXVD, fl_ARRAY_REAL_DOUBLE, LenV);
flSetVarIntrnl('xve',fl_ARRAY_REAL_EXTENDED,adrXVE); flSetLength(adrXVE, fl_ARRAY_REAL_EXTENDED, LenV);
flSetVarIntrnl('xvi',fl_ARRAY_REAL_INTEGER,adrXVI);  flSetLength(adrXVI, fl_ARRAY_REAL_INTEGER, LenV);
flSetVarIntrnl('xvs',fl_ARRAY_REAL_SINGLE,adrXVS);   flSetLength(adrXVS, fl_ARRAY_REAL_SINGLE, LenV);
flSetVarIntrnl('gvd', fl_ARRAY_REAL_DOUBLE,adrGVD);

flSetVarIntrnl('zz', fl_COMPLEX_EXTENDED, adrExtZ);
//flSetVarValueCxE(adrExtZ,1.5,5.7);
PExtended(adrExtZ)^:=x;
PEXtended(Cardinal(adrExtZ)+16)^:=5.7;


flSetVar('vx1',@vx1,fl_Array_Real_Extended);
flSetVar('vx2',@vx2,fl_Array_Real_Extended);
flSetVar('vx3',@vx3,fl_Array_Real_Extended);
flSetVar('vx4',@vx4,fl_Array_Real_Extended);
flSetVar('vx5',@vx5,fl_Array_Real_Extended);

SetLength(vx1,LenV);
SetLength(vx2,LenV);
SetLength(vx3,LenV);
SetLength(vx4,LenV);
SetLength(vx5,LenV);





{

for ic := 0 to LenV-1 do
begin
  vd[ic]:=ic+1;
  ve[ic]:=ic+5;
  vs[ic]:=ic+3;

  vd1[ic]:=ic+2;
  vd2[ic]:=ic+3;
  vd3[ic]:=ic+4;

  ve1[ic]:=ic+2;
  ve2[ic]:=ic+3;
  ve3[ic]:=ic+4;

  vs1[ic]:=ic+2;


  vd[ic]:=power(-1,ic+1)*vd[ic]*0.5;
  ve[ic]:=power(-1,ic+5)*ve[ic]*0.5;
  vi[ic]:=Trunc(ve[ic]);
  vs[ic]:=power(-1,ic+3)*vs[ic]*0.5;

  vu1[ic]:=vd[ic];
  vu2[ic]:=ve[ic];
  vu3[ic]:=ve[ic];

  vd1[ic]:=power(-1,ic+2)*vd1[ic]*0.7;
  vd2[ic]:=power(-1,ic+3)*vd2[ic]*0.5;
  vd3[ic]:=power(-1,ic+4)*vd3[ic]*0.3;

  ve1[ic]:=power(-1,ic+2)*ve1[ic]*0.7;
  ve2[ic]:=power(-1,ic+3)*ve2[ic]*0.5;
  ve3[ic]:=power(-1,ic+4)*ve3[ic]*0.3;

  vs1[ic]:=power(-1,ic+2)*vs1[ic]*0.7;

  vi1[ic]:=Trunc(ve1[ic]);
  vi2[ic]:=Trunc(ve2[ic]);
  vi3[ic]:=Trunc(ve3[ic]);

  vu1[ic]:=ve1[ic];
  vu2[ic]:=ve2[ic];
  vu3[ic]:=ve3[ic];

  vdt[ic]:=vd[ic];
  vet[ic]:=ve[ic];
  vit[ic]:=vi[ic];
  vu1t[ic]:=vu1[ic];
  vu2t[ic]:=vu2[ic];
  vu3t[ic]:=vu3[ic];

  flSetArrayValueD(adrXVD,ic,vd[ic]);
  flSetArrayValueE(adrXVE,ic,ve[ic]);
  flSetArrayValueI(adrXVI,ic,vi[ic]);
  flSetArrayValueS(adrXVS,ic,vs[ic]);
  //if i/2 = trunc(i/2) then vd[i]:=-vd[i];
  //if i/3 = trunc(i/3) then ve[i]:=-ve[i];
  //vd[i]:=vd[i]*0.5;
  //ve[i]:=ve[i]*0.3;
end;

}


{
for ic := 0 to 99 do
begin
  ve[ic]:=ve[ic]*sqrt(2);
end;
}

flSetVar('vd',@vd,fl_Array_Real_Double);
flSetVar('ve',@ve,fl_Array_Real_Extended);
flSetVar('vi',@vi,fl_Array_Real_Integer);
flSetVar('vs',@vs,fl_Array_Real_Single);
flSetVar('vd1',@vd1,fl_Array_Real_Double);
flSetVar('vd2',@vd2,fl_Array_Real_Double);
flSetVar('vd3',@vd3,fl_Array_Real_Double);

//flSetVar('gvdf',@adrGVDF,fl_Array_Real_Double);
flSetVar('gvdf',@adrGVDF,fl_Array_Real_Extended);
flSetVar('vdt2',@vdt2,fl_Array_Real_Double);

//универсальный
flSetVar('vu1',@vu1,c_ArrayType);
flSetVar('vu2',@vu2,c_ArrayType);
flSetVar('vu3',@vu3,c_ArrayType);

flSetVar('M1u',@M1u,c_ArrayType);
flSetVar('M1ux',@M1ux,c_ArrayType);
flSetVar('M1uy',@M1uy,c_ArrayType);
flSetVar('M1ut',@M1ut,c_ArrayType);
flSetVar('LenSCM1u',@LenSCM1u,fl_real_Integer); //LenSCM1u=sqrt(Len(M1u)) - число строк/столбцов в квадратной матрице



flSetVar('ve1',@ve1,fl_Array_Real_Extended);
flSetVar('ve2',@ve2,fl_Array_Real_Extended);
flSetVar('ve3',@ve3,fl_Array_Real_Extended);

flSetVar('vi1',@vi1,fl_Array_Real_Integer);
flSetVar('vi2',@vi2,fl_Array_Real_Integer);
flSetVar('vi3',@vi3,fl_Array_Real_Integer);

flSetVar('vs1',@vs1,fl_Array_Real_Single);
flSetVar('vs2',@vs2,fl_Array_Real_Single);
flSetVar('vs3',@vs3,fl_Array_Real_Single);

flSetVar('mxd1',@mxd1,fl_Array_Real_Double);
flSetVar('mxd2',@mxd2,fl_Array_Real_Double);

flSetVar('vd',@vd,fl_Array_Real_Double);

flSetVar('vp1',@vp1,fl_Array_Pointer);
flSetVar('vp2',@vp2,fl_Array_Pointer);
flSetVar('vp3',@vp3,fl_Array_Pointer);
flSetVar('vpu',@vpu,fl_Array_Pointer);
flSetVar('vpf1',@vpf1,fl_Array_Pointer);
flSetVar('vpf2',@vpf2,fl_Array_Pointer);
flSetVar('vpf3',@vpf3,fl_Array_Pointer);
flSetVar('vpfint',@vpfint,fl_Array_Pointer);

LenV:=100;
flSetVarIntrnl('vd4',fl_ARRAY_REAL_DOUBLE,adrVD4);   flSetLength(adrVD4, fl_ARRAY_REAL_DOUBLE, LenV);
flSetVarIntrnl('vd5',fl_ARRAY_REAL_DOUBLE,adrVD5);   flSetLength(adrVD5, fl_ARRAY_REAL_DOUBLE, LenV);
flSetVarIntrnl('vd6',fl_ARRAY_REAL_DOUBLE,adrVD6);   flSetLength(adrVD6, fl_ARRAY_REAL_DOUBLE, LenV);

flSetVarIntrnl('ve4',fl_ARRAY_REAL_EXTENDED,adrVE4); flSetLength(adrVE4, fl_ARRAY_REAL_EXTENDED, LenV);
flSetVarIntrnl('ve5',fl_ARRAY_REAL_EXTENDED,adrVE5); flSetLength(adrVE5, fl_ARRAY_REAL_EXTENDED, LenV);
flSetVarIntrnl('ve6',fl_ARRAY_REAL_EXTENDED,adrVE6); flSetLength(adrVE6, fl_ARRAY_REAL_EXTENDED, LenV);

flSetVarIntrnl('vi4',fl_ARRAY_REAL_INTEGER,adrVI4);  flSetLength(adrVI4, fl_ARRAY_REAL_INTEGER, LenV);
flSetVarIntrnl('vi5',fl_ARRAY_REAL_INTEGER,adrVI5);  flSetLength(adrVI5, fl_ARRAY_REAL_INTEGER, LenV);
flSetVarIntrnl('vi6',fl_ARRAY_REAL_INTEGER,adrVI6);  flSetLength(adrVI6, fl_ARRAY_REAL_INTEGER, LenV);

flSetVarIntrnl('vs4',fl_ARRAY_REAL_SINGLE,adrVS4);   flSetLength(adrVS4, fl_ARRAY_REAL_SINGLE, LenV);
flSetVarIntrnl('vs5',fl_ARRAY_REAL_SINGLE,adrVS5);   flSetLength(adrVS5, fl_ARRAY_REAL_SINGLE, LenV);
flSetVarIntrnl('vs6',fl_ARRAY_REAL_SINGLE,adrVS6);   flSetLength(adrVS6, fl_ARRAY_REAL_SINGLE, LenV);

CreateAndFillInternalArray(LenV,True);



flSetVar('cp',@cp,fl_Array_Real_Extended);
LenV:=15;
SetLength(cp,LenV);
for ic := 0 to LenV-1 do
begin
   cp[ic]:=ve[ic];
end;

{
flSetVar('vd4',@vd4,fl_Array_Real_Double);
flSetVar('vd5',@vd5,fl_Array_Real_Double);
flSetVar('vd6',@vd6,fl_Array_Real_Double);
flSetVar('ve4',@ve4,fl_Array_Real_Extended);
flSetVar('ve5',@ve5,fl_Array_Real_Extended);
flSetVar('ve6',@ve6,fl_Array_Real_Extended);
flSetVar('vi4',@vi4,fl_Array_Real_Integer);
flSetVar('vi5',@vi5,fl_Array_Real_Integer);
flSetVar('vi6',@vi6,fl_Array_Real_Integer);
flSetVar('vs4',@vs4,fl_Array_Real_Single);
flSetVar('vs5',@vs5,fl_Array_Real_Single);
flSetVar('vs6',@vs6,fl_Array_Real_Single);
}



SetLength(cp12,13);
flSetVar('cp12',@cp12,c_ArrayType);
CP12[12]:=1.1;CP12[11]:=-2.1;CP12[10]:=-3.1;CP12[9]:=2.2;CP12[8]:=-3.3;CP12[7]:=-5.7;CP12[6]:=2.3;CP12[5]:=-9.8;CP12[4]:=1.7;
CP12[3]:=1.4;CP12[2]:=-7.5;CP12[1]:=7.7;CP12[0]:=12.3;


SetLength(cp12d,13);
flSetVar('cp12d',@cp12d,fl_Array_Real_Double);
for k := 0 to Length(CP12)-1 do
begin
   CP12d[k]:=CP12[k];
end;


SetLength(cp12s,13);
flSetVar('cp12s',@cp12s,fl_Array_Real_Single);
for k := 0 to Length(CP12)-1 do
begin
   CP12s[k]:=CP12[k];
end;


SetLength(cp12i,13);
flSetVar('cp12i',@cp12i,fl_Array_Real_Integer);
for k := 0 to Length(CP12)-1 do
begin
   CP12i[k]:=Trunc(CP12[k]);
end;




{
1.1*pow(z1,12)-2.1*pow(z1,11)-3.1*pow(z1,10)+2.2*pow(z1,9)-3.3*pow(z1,8)-5.7*pow(z1,7)+2.3*pow(z1,6)-9.8*pow(z1,5)+1.7*pow(z1,4)+1.4*pow(z1,3)-7.5*pow(z1,2)+7.7*z1+12.3
poly(1.1,-2.1,-3.1,2.2,-3.3,-5.7,2.3,-9.8,1.7,1.4,-7.5,7.7,12.3,z1)
poly(CP12,z1)

1.1*pow(x,12)-2.1*pow(x,11)-3.1*pow(x,10)+2.2*pow(x,9)-3.3*pow(x,8)-5.7*pow(x,7)+2.3*pow(x,6)-9.8*pow(x,5)+1.7*pow(x,4)+1.4*pow(x,3)-7.5*pow(x,2)+7.7*x+12.3
poly(1.1,-2.1,-3.1,2.2,-3.3,-5.7,2.3,-9.8,1.7,1.4,-7.5,7.7,12.3,x)
poly(CP12,x)
}


//flSet(fl_Disable,fl_MULTI_EXPR ,0);
//goto endp;


 //*****************************************************************************
{
 Ќедокументированные возможности с указател€ми. –аботают, но не все и не доделано.
   ѕередача массивов через указатель и преобразование типов  -  во внешние  функции и процедуры.
   »з внутренних только в SetLen, Len, High, SUM, MAX, MIN, PROD, NORM, AVR, DEV, DEVS, SUMQ

 Undocumented features with pointers. Working, but and not all and not finished .
}

 (*
flSet(fl_ENABLE,fl_USE_INTEGER_POINTER,0);   //разрешает использование целых чисел в качестве указателей

Integer(vp1[17]):=7;    //vp1[17]
ptr1:ptr=@spadr0; callr(ptr1)
l:=integer(@spadr0);  //callr(l)
vp1[10]:=@spadr0;         //callr(vp1[10])
vi1[10]:=Integer(@spadr0); //callr(vi1[10])
//ptr1=@spadr0; callr(ptr1)
//j=@spadr0; callr(j)
//ptr1=addr(spadr0); callr(ptr1)
//j=addr(spadr0); callr(j)
//ptr1=@spadr0; ptr2=ptr1; callr(ptr2)
//j=@spadr0; ptr2=j; callr(ptr2)
//j=ptr1;
//ptr1=j;
//ptr1=@j;
//j=@ptr1
//ptr1=ptr2
//ptr1=@ptr2

//vp1[j]=@k; k=vp1[j];k


xx: extended = 123.456789;  ptr1: pointer=@xx; pextended(ptr1)

ptr1:=@j;
ptr2:=@ptr1;

//n:=PInteger(PInteger(ptr2)^)^;
//pinteger(pinteger(ptr2))

// ptr1:ptr=@k;  ptr2:ptr=ptr1; pinteger(ptr2)
// ptr1:ptr=@k;  ptr2:ptr=@ptr1; pinteger(pinteger(ptr2))
// ptr1:ptr=@k;  ptr2:ptr=@ptr1; pinteger(ppointer(ptr2))

//  ptr2:ptr=@k; ptr3:ptr = ppointer(ptr2); integer(ptr3)


// ptr1:ptr=@x;  ptr2:ptr=@ptr1; ptr3:ptr=@ptr2;  pextended(ppointer(ppointer(ptr3)))
// ptr1:ptr=@x;  ptr2:ptr=@ptr1; ptr3:ptr=@ptr2;  pextended(pinteger(pinteger(ptr3)))

// ptr1:ptr=@k;  j=ppointer(ptr1); j
// ptr1:ptr=@k;  j=integer(ppointer(ptr1)); j

// ptr1:ptr=@k; integer(ptr1)



// spadr1(@x)
// ptr1:ptr=@x; spadr1(ptr1)
// j=@x; spadr1(j)

// ptr1:ptr=@spadr0; ptr2:ptr=ptr1; callr(ptr2)
// ptr1:ptr=@spadr0; j=ptr1; callr(j)
// j=@spadr0; ptr1=j; callr(ptr1)



// ptr1:ptr=@k;  ptr2:ptr=@ptr1; pinteger(ppointer(ptr2))
// ptr1:ptr=@k;  ptr2:ptr=@ptr1; ptr3:ptr=ppointer(ptr2); pinteger(ptr3)
// ptr1:ptr=@k;  ptr2:ptr=@ptr1; j=ppointer(ptr2); pinteger(j)
// ptr1:ptr=@k;  ptr2:ptr=@ptr1; ptr3:ptr=ppointer(ptr2); j=ptr3; j
// vp1:ArrayPtr=10; vp1[j]=@k;  ptr1:ptr=ppointer(vp1[j]); j=ptr1; j
// vp1:ArrayPtr=10; vp1[j]=@k;  ptr1:ptr=ppointer(vp1[j]); integer(ptr1)

// ptr1:=@k;
// j=pinteger(ptr1); j
// j=ppointer(ptr1); j


//******* «апись по указателю; Write on pointer:
      //PType(Addr,Val)-> PType(Addr)=Val

//xd: dbl=10; yd:dbl=5; Pdouble(@yd,xd*123); (yd)/(xd)
//xd: dbl=10; yd:dbl=5; ptrd:ptr=@yd; Pdouble(ptrd,xd*123); (yd)/(xd)
//xd: dbl=10; yd:arraydbl=10; yd[7]=5; Pdouble(@yd[7],xd*123); (yd[7])/(xd)
//xd: dbl=10; yd:arraydbl=10; nd:int=3; yd[nd+4]=10; Pdouble(@yd[2*nd+1],xd*123); (yd[nd+4])/(xd)
//xd: dbl=10; yd:arraydbl=10; nd:int=3; yd[nd+4]=10; ptrd:ptr=@yd[nd+4]; Pdouble(ptrd,xd*123); (yd[2*nd+1])/(xd)


//xd: ext=10; yd:ext=5; PExtended(@yd,xd*123); (yd)/(xd)
//xd: ext=10; yd:ext=5; ptrd:ptr=@yd; PExtended(ptrd,xd*123); (yd)/(xd)
//xd: dbl=10; yd:arrayext=10; yd[7]=5; PExtended(@yd[7],xd*123); (yd[7])/(xd)
//xd: ext=10; yd:arrayext=10; nd:int=3; yd[nd+4]=10; PExtended(@yd[2*nd+1],xd*123); (yd[nd+4])/(xd)
//xd: ext=10; yd:arrayext=10; nd:int=3; yd[nd+4]=10; ptrd:ptr=@yd[nd+4]; PExtended(ptrd,xd*123); (yd[2*nd+1])/(xd)


//xd: int=10; yd:int=5; PInteger(@yd,xd*123); (yd)/(xd)
//xd: int=10; yd:int=5; ptrd:ptr=@yd; PInteger(ptrd,xd*123); (yd)/(xd)
//xd: int=10; yd:arrayint=10; yd[7]=5; PInteger(@yd[7],xd*123); (yd[7])/(xd)
//xd: int=10; yd:arrayint=10; nd:int=3; yd[nd+4]=10; PInteger(@yd[2*nd+1],xd*123); (yd[nd+4])/(xd)
//xd: int=10; yd:arrayint=10; nd:int=3; yd[nd+4]=10; ptrd:ptr=@yd[nd+4]; PInteger(ptrd,xd*123); (yd[2*nd+1])/(xd)


//xd: sng=10; yd:sng=5; PSingle(@yd,xd*123); (yd)/(xd)
//xd: sng=10; yd:sng=5; ptrd:ptr=@yd; PSingle(ptrd,xd*123); (yd)/(xd)
//xd: sng=10; yd:arraysng=10; yd[7]=5; PSingle(@yd[7],xd*123); (yd[7])/(xd)
//xd: sng=10; yd:arraysng=10; nd:int=3; yd[nd+4]=10; PSingle(@yd[2*nd+1],xd*123); (yd[nd+4])/(xd)
//xd: sng=10; yd:arraysng=10; nd:int=3; yd[nd+4]=10; ptrd:ptr=@yd[nd+4]; PSingle(ptrd,xd*123); (yd[2*nd+1])/(xd)




//xe: ext=1.12345; ye:ext=5; PExtended(@ye,xe); (ye+xe)/(2*xe)


 //PS:  "Error at dispose in close" : setlen(vp1) = ...!!!

//vp1:ArrayPtr=10;  vp1[j]=@k; pinteger(vp1[j])
//vi1[j]=@k; pinteger(vi1[j])

//vp1:ArrayPtr=10; vp1[j]=@k;  ptr1:ptr=vp1[j]; pinteger(ptr1)
//vp1:ArrayPtr=10; vp1[j]=@k; pinteger(vp1[j])
//vp1:ArrayPtr=10; vp1[j]=@k; ppointer(vp1[j])
//vp1:ArrayPtr=10; vp1[j]=@k; n=ppointer(vp1[j]);n
//vp1:ArrayPtr=10; vp1[j]=@k; n=vp1[j]; pinteger(n)
//vp1:ArrayPtr=10; vp1[j]=@k; ptr1:ptr=vp1[j]; n=ptr1; pinteger(n)
//vp4: arrayPtr=10; vp4[j]=@k; ptr1:ptr=vp4[j]; n=ptr1; pinteger(n)

// ptr1=@ve; PArrayE(ptr1,k+8)
// vp1:ArrayPtr=10; vp1[j]=@ve; PArrayE(vp1[j],k+8)/ve[k+8]
// vp4: arrayPtr=10; vp4[j]=@ve; PArrayE(vp4[j],k+8)
// vp1:ArrayPtr=10;  vp1[j]=@ve; ptr2=vp1[j]; PArrayE(ptr2,k+8)/ve[k+8]
// vp4: arrayPtr=10;  vp4[j]=@ve; ptr2=vp4[j]; PArrayE(ptr2,k+8)/ve[k+8]
// vp1:ArrayPtr=10;  vp1[j]=@ve; n=vp1[j]; PArrayE(n,k+8)
// ptr1:ptr=@ve; ptr2:ptr=@ptr1; ptr3:ptr=@ptr2; PArrayE(ppointer(ppointer(ptr3)),k+8)/ve[k+8]

// vp4: arrayPtr=10; vp1[0]=@x; PExtended(vp1[0])

// vp4: arrayPtr=10; vp4[0]=@x; vp4[1]=@y; vp4[2]=@t; vp4[3]=@s; vp4[4]=@r; PExtended(vp4[k])

//j=45; vd[j]
//j=45; ptr1:ptr=@vd; ptr1:ptr=ppointer(ptr1); n=ptr1;  n=n+8*j; ptr1=n; pdouble(ptr1);
//j=45; n=@vd; n=ppointer(n);    pdouble(n+8*j);
// j=45;  ptrvd:ptr=@vd;  pdouble(pinteger(ptrvd)+8*j)/vd[j];
// j=45; ptrvd:ptr=@vd;  pdouble(pointer(pinteger(ptrvd)+8*j))/vd[j]

//n=integer(@x); pextended(pointer(n))
//pinteger(@j)

//универсальна€ процедура передачи массива дл€ любого типа parrayp(@vec)
// len(parrayp(@vd))
// ptr1:ptr=@ve; len(parrayp(ptr1))


//только дл€ внешних !!!
// ptr1:ptr=@vd; dispn1(arrayd(ppointer(ptr1)))/devs(vd)
// ptrvd:ptr=@vd;  ptrve:ptr=@ve;  spall(arraye(ppointer(ptrve)),k+j,z5, arrayd(ppointer(ptrvd)),k+3,x+y,z1+z2,z4.im,vi,j)/spall(ve,k+j,z5, vd,k+3,x+y,z1+z2,z4.im,vi,j)
// ptr1:ptr=@vd; dispn1(parrayd(ptr1))/devs(vd)
// ptr1:ptr=@vd; spall(ve,k+j,z5, parrayd(ptr1),k+3,x+y,z1+z2,z4.im,vi,j)
// ptr1:ptr=@vd; ptr2=@ve; spall(parraye(ptr2),k+j,z5, parrayd(ptr1),k+3,x+y,z1+z2,z4.im,vi,j)/spall(ve,k+j,z5, vd,k+3,x+y,z1+z2,z4.im,vi,j)


//PDouble(@vd[2*k+3*k*j+1])-vd[2*k+3*k*j+1]
//PExtended(@ve[15])-ve[15]
//PInteger(@vi[2*x+1])-vi[2*x+1]


//ptr1:ptr=@vd[2*k+3*k*j+1]; PDouble(ptr1)/vd[2*k+3*k*j+1]
//ptr1:ptr=@ve[15]; PExtended(ptr1)-ve[15]
//ptr1:ptr=@vi[2*x+1]; PInteger(ptr1)-vi[2*x+1]

  // обход ограничени€ передачи  pointer в _PreCompiled функци€х через преобразование типов
//extf()=sqrt(x)
//callextf(adrF: int):real=callR(pointer(adrF))

//ptrf:int=integer(@extf); callextf(ptrf)

//дл€ массивов:

//не работает!   и не будет!:
//setlen(parrayd(@vd),rnd(1,10000)) ; len(vd)
//ptr1:ptr=@vd; setlen(parrayd(ptr1),rnd(1,10000)) ; len(vd)

// работает: (только через передачу адреса - @vec, а не массива - vec)!!!
// setlen(arrayd(@vd),rnd(1,10000)); len(vd)
// setlen(arrayd(@vd),rnd(1,10000)); len(parrayd(@vd))
// ptr1:ptr=@vd; setlen(arrayd(ptr1),rnd(1,10000)) ; len(vd)
// ptr1:ptr=@vd; setlen(arrayd(ptr1),rnd(1,10000)) ; len(parrayd(ptr1))
// vdt: arrayDbl=1; ptr1:ptr=@vdt; setlen(arrayd(ptr1),rnd(1,10000)); len(vdt)
// vdt: arrayDbl=1; ptr1:ptr=@vdt; setlen(arrayd(ptr1),rnd(1,10000)); len(parrayd(ptr1))

// setlen(arraye(@ve),rnd(1,10000)); len(parraye(@ve))
// vet: arrayExt=1; ptr1:ptr=@vet; setlen(arraye(ptr1),rnd(1,10000)); len(parraye(ptr1))

// setlen(arrayi(@vi),rnd(1,10000)); len(parrayi(@vi))
// vet: arrayInt=1; ptr1:ptr=@vet; setlen(arrayi(ptr1),rnd(1,10000)); len(parrayi(ptr1))


// setlen(arrays(@vs),rnd(1,10000)); len(parrays(@vs))
// vet: arraySng=1; ptr1:ptr=@vet; setlen(arrays(ptr1),rnd(1,10000)); len(parrays(ptr1))

// setlen(arrayp(@vp1),rnd(1,10000)); len(parrayp(@vp1))
// vet: arrayPtr=1; ptr1:ptr=@vet; setlen(arrayp(ptr1),rnd(1,10000)); len(parrayp(ptr1))


   {
    ptr1:ptr=@vs;    sum(parrays(ptr1))
    ptr1:ptr=@vd;    sum(parrayd(ptr1))
    ptr1:ptr=@ve;    sum(parraye(ptr1))
    ptr1:ptr=@vi;    sum(parrayi(ptr1))
   }

  {
   prod(vi)                                    -  not def
   ptr1:ptr=@vi;    prod(parrayi(ptr1))        -  not def

     def ext func for prod int array:
     prod(vii: arrayInt) = vd: arrayDbl=len(vii); CopyArray(vd,vii); prod(vd)

   prod(vi)
   ptr1:ptr=@vi;    prod(parrayi(ptr1))

   ptr1:ptr=@vs;    prod(parrays(ptr1))
   ptr1:ptr=@vd;    prod(parrayd(ptr1))
   ptr1:ptr=@ve;    prod(parraye(ptr1))
  }
  //аналогично (sum,prod) дл€  SUM, MAX, MIN, PROD, NORM, AVR, DEV, DEVS, SUMQ

//универсальна€: { ptr=@vec; setlen(ptr,NewLen) }
// ptr1:ptr=@vd; setlen(ptr1,rnd(1,10000)) ; len(vd)
// ptr1:ptr=@vd; setlen(ptr1,rnd(1,10000)) ; len(parrayp(ptr1))
// vdt: arrayDbl=1; ptr1:ptr=@vdt; setlen(ptr1,rnd(1,10000)); len(vdt)
// vdt: arrayDbl=1; ptr1:ptr=@vdt; setlen(ptr1,rnd(1,10000)); len(parrayp(ptr1))

//присвоени€ PType(addr,val)  -> PType(addr)=val
//pextended(@x,y);x
//xd: double=0; pdouble(@xd,y+x); xd
//pinteger(@k,2*n+3);k
//pextended(@ve[k+1],2*x);ve[k+1]

{
 pcptrf(ps1,ps2: pointer):real= PExtended(ps1,PExtended(ps2))
 pcptrf(@x,@y);y
}

{
  pdxch(pd1,pd2: ptr):none = td: dbl = pdouble(pd1); pdouble(pd1,pdouble(pd2)); pdouble(pd2,td);

  x:dbl=2; y:dbl=12; pdxch(@x,@y); y-x
  x:dbl=2; y:dbl=12; px:ptr=@x; py:ptr=@y; pdxch(px,py); y-x
}

*)
//*****************************************************************************




//FDFN:=TFuncPC.Create(Form1);
//goto endp;

SetLength(AD,3);
flSetVar('ad',@ad,fl_Array_Real_Double);
AD[0]:=3.5; AD[1]:=-1.4;  AD[2]:=7.6;
SetLength(ADE,3);
ADE[0]:=3.5; ADE[1]:=-1.4;  ADE[2]:=7.6;

new(zp);
flSetVar('zp',@zp^,fl_Complex_Double);
zp^.re:=1.1; zp^.im:=2.2;
flSetVar('zpx',@zp^.re,fl_real_Double);
flSetVar('zpy',@zp^.im,fl_real_Double);


SetLength(vecd,9);
flSetVar('vecd',@vecd,fl_Array_Real_Double);
vecd[0]:=1; vecd[1]:=2; vecd[2]:=3; vecd[3]:=4; vecd[4]:=5;  vecd[5]:=6; vecd[6]:=7;  vecd[7]:=8; vecd[8]:=9;

SetLength(vece,9);
flSetVar('vece',@vece,fl_Array_Real_Extended);
vece[0]:=1; vece[1]:=2; vece[2]:=3; vece[3]:=4; vece[4]:=5;  vece[5]:=6; vece[6]:=7;  vece[7]:=8; vece[8]:=9;

SetLength(veci,9);
flSetVar('veci',@veci,fl_Array_Real_Integer);
veci[0]:=1; veci[1]:=2; veci[2]:=3; veci[3]:=4; veci[4]:=5;  veci[5]:=6; veci[6]:=7;  veci[7]:=8; veci[8]:=9;
//goto endp;

CreateIntArray;
flSetVarIntrnl('Aint',fl_ARRAY_REAL_EXTENDED,adrAint);
flSetVarIntrnl('Bint',fl_ARRAY_REAL_EXTENDED,adrBint);

flSetLength(adrAint,fl_ARRAY_REAL_EXTENDED,Length(Aint));
flSetLength(adrBint,fl_ARRAY_REAL_EXTENDED,Length(Bint));



// ******************************************
{
flSetFunction('_pwr(x,y:ext)=x^y',0,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=6;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
flSetOperation('**',@OpData);
}



//flSet(fl_Disable,fl_PRELIM_SYNT_ERROR,0);
 (*
flSet(fl_Disable,fl_PIPE_BRACKET_TO_ABS,0);
flSetFunction('{$IN+}_or_(n1,n2:int)=or(n1,n2)',0,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=16;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
flSetOperation('|',@OpData);



flSet(fl_Disable,fl_PRELIM_SYNT_ERROR,0);
flSet(fl_Disable,fl_PIPE_BRACKET_TO_ABS,0);
flSetFunction('{$IN+}_and_(n1,n2:int)=and(n1,n2)',0,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=16;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
flSetOperation('&',@OpData);
 *)

 // перед  SKIP_COMPILED компилируемый код не размещать
{$IFDEF SKIP_COMPILED}
 goto endp;
{$ENDIF}

//************************************************


for ic := 0 to Length(Aint) - 1 do
  begin
    flSetArrayValueE(adrAint,ic,Aint[ic]);
    flSetArrayValueE(adrBint,ic,Bint[ic]);
  end;

//flGet(fl_ARRAY_LENGTH,Cardinal(@ve{adrAint}),len);

//goto endp;

(*
                    SPLAIN FUNCTIONS
   *************************************************************
   spl1(x)  = (sin(3*sx)-cos(2*sx))*exp(-sx/10);    x =  -15..15
   spl2(x)  =  sx*(sin(sx)+cos(sx));                x =  -10..10
   *************************************************************
*)

hx:=0.1;      //<=1!!!
ax:=-10; bx:=10; sx:=ax;
Lv:=Trunc(abs(bx-ax)/hx)+1;
setlength(xspl,lv);
setlength(yspl,lv);
for ic := 0 to lv-1 do
begin
  xspl[ic]:=sx;
  yspl[ic]:=sx*(sin(sx)+cos(sx));
  sx:=sx+hx;
end;

//_SetSplain3F('spl',Foreval_Lib.TArrayE(xspl),Foreval_Lib.TArrayE(yspl),id);
flSetSplainFunction('spl2',@xspl,@yspl,fl_ARRAY_REAL_EXTENDED,@idfP);



hx:=0.1;      //<=1!!!
ax:=-15; bx:=15; sx:=ax;
Lv:=Trunc(abs(bx-ax)/hx)+1;
flSetVarIntrnl('svdx',fl_Array_Real_Double,adrVDX);
flSetVarIntrnl('svdy',fl_Array_Real_Double,adrVDY);
flSetLength(adrVDX,fl_Array_Real_Double,lv);
flSetLength(adrVDY,fl_Array_Real_Double,lv);

for ic := 0 to lv-1 do
begin

  flSetArrayValueD(adrVDX,ic,sx);
  fx:=(sin(3*sx)-cos(2*sx))*exp(-sx/10);
  flSetArrayValueD(adrVDY,ic,fx);
  sx:=sx+hx;
end;

flSetSplainFunction('spl1',adrVDX,adrVDY,fl_Array_Real_Double,@idfP);




(******************************************************************************

                         ƒобавление внешних функций:
                         Addition external functions:

*******************************************************************************)




(* *****************************************************************************
--------------------------------------------------------------------------------
>> with any call types:

 func1(arg1)=arg1^2;
 func2(arg1,arg2)=arg1-arg2;
 func3(arg1,arg2,arg3)=arg1+arg2-arg3;
 arg1,arg2,arg3 - real/complex

 func4(arg1,arg2,arg3,arg4)=arg1+arg2-arg3*arg4;

 sp1, sp2, sp3      fl_VARS_VALUES
 ps1, ps2, ps3      fl_VARS_ADDRS
 ms1, ms2, ms3      fl_VARS_LIST_ADDR_ESP
 pc1, pc2, pc3      fl_PreCompiled


--------------------------------------------------------------------------------
>>  with infinite numbers of arguments (fl_INFINITE);
    infsum(<real>)
    infsum(<complex>)

--------------------------------------------------------------------------------
>> with array (any call types):

 func6(vd: arrayDbl; d: Double; ve: arrayExt; i: int; x: Ext; j:int)  = vd[i]-ve[j]+d-x
 func6(vd: arrayDbl; zd: ComplexDouble; ve: arrayExt; i: int; zx: ComplexExtended; j:int):Complex  = vd[i]-ve[j]+zd-zx

 sp6      fl_VARS_VALUES
 ps6      fl_VARS_ADDRS
 pc6      fl_PreCompiled
 ms6      fl_VARS_LIST_ADDR_ESP

--------------------------------------------------------------------------------
>> with all types of variables (any call types):

   func8i(vd1: arrayDbl; n1: int;  d: dbl;  ve2: arrayExt; n2: int; x: ext; vi3: arrayInt; n3: int)  = (vd1[n1]*d-ve2[n2]*x)*vi3[n3];
   func8i(vd1: arrayDbl; n1: int;  d: ComplexDbl;  ve2: arrayDbl; n2: int; x: ComplexExt; vi3: arrayDbl; n3: int):complex  = (vd1[n1]*d-ve2[n2]*x)*vi3[n3];


 sp8i      fl_VARS_VALUES
 ps8i      fl_VARS_ADDRS
 pc8i      fl_PreCompiled
 ms8i      fl_VARS_LIST_ADDR_ESP

--------------------------------------------------------------------------------
>> with all math. types of variables:

   func8(ve: arrayExt; ne: int;  x: Ext;  vd: arrayDbl; nd: int; d: Dbl; vi: arrayInt; ni: int)  = (ve[ne]*x-vd[nd]*d)*vi[ni];
   func8(ve: arrayExt; ne: int;  zx: ComplexExt;  vd: arrayDbl; nd: int; zd: ComplexDbl; vi: arrayInt; ni: int):complex  = (ve[ne]*zx-vd[nd]*zd)*vi[ni];

   sp8  fl_VARS_VALUES
   ps8  fl_VARS_ADDRS

--------------------------------------------------------------------------------
>>   with all types of variables (any call types):
     func10(TArrayE vx, Int32 nx, TComplexE zx, TArrayD vd, Int32 nd, double d, TComplexD zd, Extended x, TArrayI vi, Int32 ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]

     spall    fl_VARS_VALUES
     psall    fl_VARS_ADDRS
     msall    fl_VARS_LIST_ADDR_ESP
     pcall    fl_PreCompiled

--------------------------------------------------------------------------------
>>with overload (one name for functions):
  fovl(vx :array<double,extended>; nx :integer; rx :real<complex>) = vx[nx]/rx   (by fl_VARS_VALUES)
      fovl(vx :array double;   nx :integer; rx :real)
      fovl(vx :array extended; nx :integer; rx :real)
      fovl(vx :array integer;  nx :integer; rx :real)
      fovl(vx :array double;   nx :integer; rx :complex)
      fovl(vx :array extended; nx :integer; rx :complex)
      fovl(vx :array integer;  nx :integer; rx :complex)

  fovl(rx :real<complex>; vx :array<double,extended>; nx :integer) = rx/vx[nx]   (by fl_VARS_ADDRS)
      fovl(rx :real;    vx :array double;    nx :integer)
      fovl(rx :real;    vx :array extended;  nx :integer)
      fovl(rx :real;    vx :array integer;   nx :integer)
      fovl(rx :complex; vx :array double;    nx :integer)
      fovl(rx :complex; vx :array extended;  nx :integer)
      fovl(rx :complex; vx :array integer;   nx :integer)
*)


//goto endp;


//goto endp;




{
flSetDiffTemplate(idfP,'2*$arg1*$dfarg1');
flSetDiffTemplate(idfP,'$dfarg1-$dfarg2');
flSetDiffTemplate(idfP,'$dfarg1+$dfarg2-$dfarg3');
flSetDiffTemplate(idfP,'$dfarg1+$dfarg2-$dfarg3*$arg4-$dfarg4*$arg3');
}




///////////////////////////////////////////////////////////////////////////////
//            SP; fl_VARS_VALUES                                             //
///////////////////////////////////////////////////////////////////////////////

//sp1(x)
InitFuncStruct(FS);
FS.addr:=@sp1;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:= c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp1',@FS,@idfP);
flSetDiffTemplate(@idfP,'2*$arg1*$dfarg1');


//sp2(x,y)
InitFuncStruct(FS);
FS.addr:=@sp2;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp2',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1-$dfarg2');



//sp3(x,y,t)
InitFuncStruct(FS);
//SetLength(VT,3);
//VT[0]:=fl_real_double; VT[1]:=fl_real_double; VT[2]:=fl_Real_double;
FS.addr:=@sp3;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp3',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3');
//flAddNameFunction(idfP.idName,'sp3new');


//sp1(z1)
InitFuncStruct(FS);
FS.addr:=@sp1z;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp1',@FS,@idfP);



//sp2(z1,z2)
InitFuncStruct(FS);
FS.addr:=@sp2z;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp2',@FS,@idfP);



//sp3(z1,z2,z3)
InitFuncStruct(FS);
FS.addr:=@sp3z;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp3',@FS,@idfP);



//sp2(z1,x)
InitFuncStruct(FS);
SetLength(VT,2);
VT[0]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.addr:=@sp2zr;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp2',@FS,@idfP);


//sp2(x,z1)
InitFuncStruct(FS);
SetLength(VT,2);
VT[0]:=c_RealFloat;//fl_real_double;   fl_real_extended;
VT[1]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.addr:=@sp2rz;
FS.CallType:=fl_stdcall;
FS.Arg:=2;
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp2',@FS,@idfP);





//sp3(z1,x2,z3)
InitFuncStruct(FS);
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[2]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@sp3ZRZ;
FS.CallType:=fl_cdecl;
FS.CallFunc:=fl_VARS_VALUES;
FS.ResultType:=fl_complex;
FS.DeepFPU:=2;
flSetFunction('sp3',@FS,@idfP);




//sp3(x1,z2,x3)
InitFuncStruct(FS);
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_ComplexFloat;   //fl_real_double;   fl_real_extended;
VT[2]:=c_RealFloat;// fl_complex_double;    fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@sp3RZR;
FS.CallType:=fl_cdecl;
FS.CallFunc:=fl_VARS_VALUES;
FS.ResultType:=fl_complex;
FS.DeepFPU:=2;
flSetFunction('sp3',@FS,@idfP);



//sp4(z1,x1,z2,x2)
InitFuncStruct(FS);
FS.Arg:=4;
SetLength(VT,FS.Arg);
VT[0]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[2]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[3]:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@sp4ZR;
FS.CallType:=fl_cdecl;
FS.CallFunc:=fl_VARS_VALUES;
FS.ResultType:=fl_complex;
FS.DeepFPU:=2;
flSetFunction('sp4',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3*$arg4-$dfarg4*$arg3');




//sp4(x1,z1,x2,z2)
InitFuncStruct(FS);
FS.Arg:=4;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[1]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[2]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[3]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@sp4RZ;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp4',@FS,@idfP);

///////////////////////////////////////////////////////////////
//***********************************************************//
///////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////
//            PS; fl_VARS_ADDRS;                                             //
///////////////////////////////////////////////////////////////////////////////


//ps1(x)
InitFuncStruct(FS);
FS.addr:=@ps1;
FS.CallType:=fl_Stdcall;
FS.Arg:=1;
FS.ArgType:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps1',@FS,@idfP);
flSetDiffTemplate(@idfP,'2*$arg1*$dfarg1');


//ps2(x,y)
InitFuncStruct(FS);
FS.addr:=@ps2;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgType:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps2',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1-$dfarg2');



//ps3(x,y,t)
InitFuncStruct(FS);
FS.addr:=@ps3;
FS.CallType:=fl_Stdcall;
FS.Arg:=3;
FS.ArgType:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps3',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3');



//ps1(z1)
InitFuncStruct(FS);
FS.addr:=@ps1z;
FS.CallType:=fl_CDecl;
FS.ArgType:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.Arg:=1;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps1',@FS,@idfP);


//ps2(z1,z2)
InitFuncStruct(FS);
FS.addr:=@ps2z;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgType:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps2',@FS,@idfP);



//ps3(z1,z2,z3)
InitFuncStruct(FS);
FS.addr:=@ps3z;
FS.CallType:=fl_Stdcall;
FS.Arg:=3;
FS.ArgType:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.ResultType:=fl_Complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps3',@FS,@idfP);



//ps2(z1,x)
InitFuncStruct(FS);
VTS[0]:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
VTS[1]:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.addr:=@ps2zr;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgTypeList:=@VTS[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps2',@FS,@idfP);


//ps2(x,z1)
InitFuncStruct(FS);
VTS[0]:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
VTS[1]:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.addr:=@ps2rz;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgTypeList:=@VTS[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps2',@FS,@idfP);




//ps3(z1,x2,z3)
InitFuncStruct(FS);
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[2]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@ps3ZRZ;
FS.CallType:=fl_cdecl;
FS.CallFunc:=fl_VARS_ADDRS;
FS.ResultType:=fl_complex;
FS.DeepFPU:=2;
flSetFunction('ps3',@FS,@idfP);




//ps3(x1,z2,x3)
InitFuncStruct(FS);
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_ComplexFloat;   //fl_real_double;   fl_real_extended;
VT[2]:=c_RealFloat;// fl_complex_double;    fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@ps3RZR;
FS.CallType:=fl_cdecl;
FS.CallFunc:=fl_VARS_ADDRS;
FS.ResultType:=fl_complex;
FS.DeepFPU:=2;
flSetFunction('ps3',@FS,@idfP);




//ps4(z1,x1,z2,x2)
InitFuncStruct(FS);
FS.Arg:=4;
SetLength(VT,FS.Arg);
VT[0]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[2]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[3]:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@ps4ZR;
FS.CallType:=fl_cdecl;
FS.CallFunc:=fl_VARS_ADDRS;
FS.ResultType:=fl_complex;
FS.DeepFPU:=2;
flSetFunction('ps4',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3*$arg4-$dfarg4*$arg3');




//ps4(x1,z1,x2,z2)
InitFuncStruct(FS);
FS.Arg:=4;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[1]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[2]:=c_RealFloat;   //fl_real_double;   fl_real_extended;
VT[3]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.addr:=@ps4RZ;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps4',@FS,@idfP);


/////////////////////////////////////////////////////////
///******************************************************
/////////////////////////////////////////////////////////

{
//ps2(x,y)
InitFuncStruct(FS);
VTS[0]:=fl_real_double; VTS[1]:=fl_real_double;
FS.addr:=@ps2A;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgTypeList:=@VTS[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('ps2',@FS,@idfP);
}

{spv(vd,n), spv(ve,n), spv(vi,n)}
InitFuncStruct(FS);
FS.addr:=@SPVd;
SetLength(VT,2);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spv',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@SPVi;
SetLength(VT,2);
VT[0]:=fl_array_real_Integer;  VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spv',@FS,@idfP);

InitFuncStruct(FS);
FS.addr:=@SPVe;
SetLength(VT,2);
VT[0]:=fl_array_real_Extended;  VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spv',@FS,@idfP);



//ps3(z1,z2,x)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=c_ComplexFloat; VT[1]:=c_ComplexFloat; VT[2]:=c_RealFloat;
FS.addr:=@PS3ZZR;
FS.CallType:=fl_Cdecl;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps3',@FS,@idfP);


//ps4(x,y,t,x)
InitFuncStruct(FS);
SetLength(VT,4);
VT[0]:=fl_real_extended; VT[1]:=fl_real_double; VT[2]:=fl_Real_extended; VT[3]:=fl_real_double;
FS.addr:=@PS4;
FS.CallType:=fl_cdecl;
FS.Arg:=4;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps4',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3*$arg4-$dfarg4*$arg3');

//ps4(z1:ext,z2:dbl,z3:ext,z4:dbl)
InitFuncStruct(FS);
FS.ArgType:=fl_Differ;
SetLength(VT,4);
VT[0]:=fl_complex_extended; VT[1]:=fl_complex_double; VT[2]:=fl_complex_extended;  VT[3]:=fl_complex_double;
FS.addr:=@ps4z;
FS.ArgTypeList:=@VT[0];
FS.CallType:=fl_cdecl;
FS.Arg:=4;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps4',@FS,@idfP);





//extended
//ps1x(x)
InitFuncStruct(FS);
FS.addr:=@ps1x;
FS.CallType:=fl_Stdcall;
FS.Arg:=1;
FS.ArgType:=fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps1x',@FS,@idfP);

//ps1x(z1)
InitFuncStruct(FS);
FS.addr:=@ps1zx;
FS.CallType:=fl_CDecl;
FS.ArgType:=fl_complex_Extended;
FS.Arg:=1;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps1x',@FS,@idfP);


//ps2x(x,y)
InitFuncStruct(FS);
VTS[0]:=fl_real_Extended; VTS[1]:=fl_real_Extended;
FS.addr:=@ps2x;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgTypeList:=@VTS[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps2x',@FS,@idfP);

//ps3(x,y,t)
InitFuncStruct(FS);
FS.addr:=@ps3x;
FS.CallType:=fl_cdecl;
FS.Arg:=3;
FS.ArgType:=fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps3x',@FS,@idfP);


//ps2x(z1,z2)
InitFuncStruct(FS);
VTS[0]:=fl_complex_Extended; VTS[1]:=fl_complex_Extended;
FS.addr:=@ps2zx;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgTypeList:=@VTS[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps2x',@FS,@idfP);

//ps2x(z1,x)
InitFuncStruct(FS);
VTS[0]:=fl_complex_Extended; VTS[1]:=fl_real_Extended;
FS.addr:=@ps2zrx;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgTypeList:=@VTS[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps2x',@FS,@idfP);


//ps2x(x,z1)
InitFuncStruct(FS);
VTS[0]:=fl_real_Extended; VTS[1]:=fl_complex_Extended;
FS.addr:=@ps2rzx;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgTypeList:=@VTS[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps2x',@FS,@idfP);

//ps3x(z1,z2,z3)
InitFuncStruct(FS);
FS.addr:=@ps3zx;
FS.CallType:=fl_pascal;
FS.Arg:=3;
FS.ArgType:=fl_Complex_Extended;
FS.ResultType:=fl_Complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps3x',@FS,@idfP);




InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_Complex_Double; VT[1]:=fl_Complex_Double; VT[2]:=fl_Real_Double;
FS.addr:=@s_zzr;
FS.CallType:=fl_StdCall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('sum',@FS,@idfP);




//sum(x,z1,z2)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_Real_Double; VT[1]:=fl_Complex_Double; VT[2]:=fl_Complex_Double;
FS.addr:=@s_rrz;
FS.CallType:=fl_Cdecl;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('sum',@FS,@idfP);







//fl_ESP:
//ezzr(z1,z2,x)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_Complex_extended; VT[1]:=fl_Complex_extended; VT[2]:=fl_Real_Double;
FS.addr:=@e_zzr;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.DeepFPU:=2;
flSetFunction('ezzr',@FS,@idfP);


//ezzr(x,y,z1)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_Real_double; VT[1]:=fl_real_double; VT[2]:=fl_complex_extended;
FS.addr:=@e_rrz;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.DeepFPU:=2;
flSetFunction('errz',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@SA1;
FS.ArgType:=fl_Real_double;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
flSetFunction('sa1',@FS,@idfP);
flSetDiffTemplate(@idfP,'2*$arg1*$dfarg1');

InitFuncStruct(FS);
FS.addr:=@SA2;
FS.ArgType:=fl_Real_double;
FS.Arg:=2;
FS.DeepFPU:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_pascal;
FS.ResultType:=fl_Real;
flSetFunction('sa2',@FS,@idfP);
flSetDiffTemplate(@idfP,'2*$arg1*$dfarg1');


InitFuncStruct(FS);
FS.addr:=@SA3;
FS.ArgType:=fl_Real_double;
FS.Arg:=3;
FS.DeepFPU:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_pascal;
FS.ResultType:=fl_Real;
flSetFunction('sa3',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3');
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3');


InitFuncStruct(FS);
FS.addr:=@SA4;
SetLength(VT,4);
VT[0]:=fl_real_extended; VT[1]:=fl_real_double; VT[2]:=fl_Real_extended; VT[3]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=4;
FS.DeepFPU:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_Real;
flSetFunction('sa4',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3*$arg4-$dfarg4*$arg3');


{
InitFuncStruct(FS);
FS.addr:=@MS0;
FS.ArgType:=fl_Real_double;
FS.Arg:=0;
FS.DeepFPU:=1;
FS.CallFunc:=fl_ESP;
FS.CallType:=fl_cdecl;
FS.ResultType:=fl_Real;
flSetFunction('ms0',@FS);
}


/////////////////////////////////////////////////////////////////////////
///                   MS();  fl_VARS_LIST_ADDR_ESP;
/////////////////////////////////////////////////////////////////////////

//ms1
InitFuncStruct(FS);
FS.addr:=@MS1;
FS.ArgType:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
flSetFunction('ms1',@FS,@idfP);
flSetDiffTemplate(@idfP,'2*$arg1*$dfarg1');



//ms1z
InitFuncStruct(FS);
FS.addr:=@MS1Z;
FS.ArgType:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms1',@FS,@idfP);


//ms2
InitFuncStruct(FS);
FS.addr:=@MS2;
FS.ArgType:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.Arg:=2;
FS.DeepFPU:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_Real;
flSetFunction('ms2',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1-$dfarg2');


//ms2z
InitFuncStruct(FS);
FS.addr:=@MS2Z;
FS.ArgType:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms2',@FS,@idfP);

//ms2rz
InitFuncStruct(FS);
FS.addr:=@MS2RZ;
SetLength(VT,2);
VT[0]:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
VT[1]:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms2',@FS,@idfP);

//ms2zr
InitFuncStruct(FS);
FS.addr:=@MS2ZR;
SetLength(VT,2);
VT[0]:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
VT[1]:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_pascal;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms2',@FS,@idfP);


//ms3
InitFuncStruct(FS);
FS.addr:=@MS3;
FS.ArgType:=c_RealFloat; //fl_Real_Double; fl_Real_Extended;
FS.Arg:=3;
FS.DeepFPU:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.ResultType:=fl_Real;
flSetFunction('ms3',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3');


//ms3z
InitFuncStruct(FS);
FS.addr:=@MS3Z;
FS.ArgType:=c_ComplexFloat; //fl_Complex_Double; fl_Complex_Extended;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms3',@FS,@idfP);



//extended

//ms1
InitFuncStruct(FS);
FS.addr:=@MS1X;
FS.ArgType:=fl_Real_Extended;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
flSetFunction('ms1x',@FS,@idfP);
//ms2
InitFuncStruct(FS);
FS.addr:=@MS2X;
FS.ArgType:=fl_Real_Extended;
FS.Arg:=2;
FS.DeepFPU:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_Real;
flSetFunction('ms2x',@FS,@idfP);
//ms3
InitFuncStruct(FS);
FS.addr:=@MS3X;
FS.ArgType:=fl_Real_Extended;
FS.Arg:=3;
FS.DeepFPU:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.ResultType:=fl_Real;
flSetFunction('ms3x',@FS,@idfP);



//ms1z
InitFuncStruct(FS);
FS.addr:=@MS1ZX;
FS.ArgType:=fl_Complex_Extended;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms1x',@FS,@idfP);

//ms2z
InitFuncStruct(FS);
FS.addr:=@MS2ZX;
FS.ArgType:=fl_Complex_Extended;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms2x',@FS,@idfP);

//ms2rz
InitFuncStruct(FS);
FS.addr:=@MS2RZX;
SetLength(VT,2);
VT[0]:=fl_real_extended; VT[1]:=fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms2x',@FS,@idfP);

//ms2zr
InitFuncStruct(FS);
FS.addr:=@MS2ZRX;
SetLength(VT,2);
VT[0]:=fl_complex_extended; VT[1]:=fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_pascal;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms2x',@FS,@idfP);


//ms3z
InitFuncStruct(FS);
FS.addr:=@MS3ZX;
FS.ArgType:=fl_Complex_Extended;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('ms3x',@FS,@idfP);


//real:
//ms6(vd,x,ve,n,y,j)=vd[n]-ve[j]+x-y;
InitFuncStruct(FS);
FS.addr:=@MS6;
SetLength(VT,6);
VT[0]:=fl_array_real_Double; VT[1]:=fl_real_double; VT[2]:=fl_array_real_Extended;
VT[3]:=fl_real_integer; VT[4]:=fl_real_extended;  VT[5]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=6;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('ms6',@FS,@idfP);


//sp6(vd,x,ve,n,y,j)=vd[n]-ve[j]+x-y;
InitFuncStruct(FS);
SetLength(VT,6);
VT[0]:=fl_array_real_Double; VT[1]:=fl_real_double; VT[2]:=fl_array_real_Extended;
VT[3]:=fl_real_integer; VT[4]:=fl_real_extended;  VT[5]:=fl_real_integer;
FS.addr:=@_sp6;
FS.CallType:=fl_stdcall;
FS.Arg:=6;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp6',@FS,@idfP);


//ps6(vd,x,ve,n,y,j)=vd[n]-ve[j]+x-y;
InitFuncStruct(FS);
SetLength(VT,6);
VT[0]:=fl_array_real_Double; VT[1]:=fl_real_double; VT[2]:=fl_array_real_Extended;
VT[3]:=fl_real_integer; VT[4]:=fl_real_extended;  VT[5]:=fl_real_integer;
FS.addr:=@ps6;
FS.CallType:=fl_Cdecl;
FS.Arg:=6;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps6',@FS,@idfP);


//complex:
//ms6(vd,z1,ve,n,z1,j)=vd[n]-ve[j]+z1-z2;
InitFuncStruct(FS);
FS.addr:=@MS6Z;
SetLength(VT,6);
VT[0]:=fl_array_real_Double; VT[1]:=fl_complex_double; VT[2]:=fl_array_real_Extended;
VT[3]:=fl_real_integer; VT[4]:=fl_complex_extended;  VT[5]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=6;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_complex;
flSetFunction('ms6',@FS,@idfP);


//sp6(vd,z1,ve,n,z1,j)=vd[n]-ve[j]+z1-z2;
InitFuncStruct(FS);
SetLength(VT,6);
VT[0]:=fl_array_real_Double; VT[1]:=fl_complex_double; VT[2]:=fl_array_real_Extended;
VT[3]:=fl_real_integer; VT[4]:=fl_complex_extended;  VT[5]:=fl_real_integer;
FS.addr:=@SP6Z;
FS.CallType:=fl_stdcall;
FS.Arg:=6;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('sp6',@FS,@idfP);


//ps6(vd,z1,ve,n,z1,j)=vd[n]-ve[j]+z1-z2;
InitFuncStruct(FS);
SetLength(VT,6);
VT[0]:=fl_array_real_Double; VT[1]:=fl_complex_double; VT[2]:=fl_array_real_Extended;
VT[3]:=fl_real_integer; VT[4]:=fl_complex_extended;  VT[5]:=fl_real_integer;
FS.addr:=@PS6Z;
FS.CallType:=fl_Cdecl;
FS.Arg:=6;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=3;
flSetFunction('ps6',@FS,@idfP);

//pc6(vd,y,ve,n,x,j)=vd[n]-ve[j]+y-x;
//pc6(vd,z1,ve,n,z2,j)=vd[n]-ve[j]+z1-z2;
flSetFunction('pc6(ard: arrayDbl; xd: dbl; arx: arrayExt; n1: int; xx: ext; n2: int)=ard[n1]-arx[n2]+xd-xx',0,@idfP);
flSetFunction('pc6(vd: arrayDbl; zd: ComplexDouble; ve: arrayExt; n1: int; zx: ComplexExt; n2:int):Complex  = vd[n1]-ve[n2]+zd-zx',0,@idfP);





{sp8(ve,ne,x,vd,nd,d,vi,ni)}
InitFuncStruct(FS);
FS.addr:=@SP8;
SetLength(VT,8);
VT[0]:=fl_array_real_Extended;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_Extended;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_double;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('sp8',@FS,@idfP);


{ps8(ve,ne,x,vd,nd,d,vi,ni)}
InitFuncStruct(FS);
FS.addr:=@PS8;
SetLength(VT,8);
VT[0]:=fl_array_real_Extended;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_Extended;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_double;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('ps8',@FS,@idfP);




{sp8(ve,ne,zx,vd,nd,zd,vi,ni)}
InitFuncStruct(FS);
FS.addr:=@SP8Z;
SetLength(VT,8);
VT[0]:=fl_array_real_Extended;  VT[1]:=fl_real_integer;
VT[2]:=fl_Complex_Extended;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_Complex_double;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
flSetFunction('sp8',@FS,@idfP);



{ps8(ve,ne,zx,vd,nd,zd,vi,ni)}
InitFuncStruct(FS);
FS.addr:=@PS8Z;
SetLength(VT,8);
VT[0]:=fl_array_real_Extended;  VT[1]:=fl_real_integer;
VT[2]:=fl_Complex_Extended;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_Complex_double;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
flSetFunction('ps8',@FS,@idfP);





{pc3v(vd1,n,vd2,k,vd3,j,x)}
flSetFunction('pc3v(vd1: arrayDbl; n1: int; vd2: arrayDbl; n2: int; vd3: arrayDbl; n3: int; x: dbl):real  = vd1[n1]+vd2[n2]+vd3[n3]+x',0,@idfP);

//ms3v(vd1,n1,vd2,n2,vd3,n3,x)=vd1[n1]+vd2[n2]+vd3[n3]+x;
{ms3v(vd1,n,vd2,k,vd3,j,x)}
InitFuncStruct(FS);
FS.addr:=@MS3V;
SetLength(VT,7);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_array_real_Double;  VT[5]:=fl_real_integer;
VT[6]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=7;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('ms3v',@FS,@idfP);

{ps3v(vd1,n,vd2,k,vd3,j,x)}
InitFuncStruct(FS);
FS.addr:=@PS3V;
SetLength(VT,7);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_array_real_Double;  VT[5]:=fl_real_integer;
VT[6]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=7;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('ps3v',@FS,@idfP);

{sp3v(vd1,n,vd2,k,vd3,j,x)}
InitFuncStruct(FS);
FS.addr:=@SP3V;
SetLength(VT,7);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_array_real_Double;  VT[5]:=fl_real_integer;
VT[6]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=7;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('sp3v',@FS,@idfP);




//pc8v(vd1,n,y,vd2,k,x,vd3,j)
flSetFunction('pc8v(vd1: arrayDbl; n1: int;  d: dbl;  vd2: arrayDbl; n2: int; x: ext; vd3: arrayDbl; n3: int):real  = (vd1[n1]*d-vd2[n2]*x)*vd3[n3]',0,@idfP);
//ms8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
{ms8v(vd1,n,y,vd2,k,x,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@MS8V;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_double;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_extended;
VT[6]:=fl_array_real_Double;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('ms8v',@FS,@idfP);


{ps8v(vd1,n,y,vd2,k,x,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@PS8V;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_double;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_extended;
VT[6]:=fl_array_real_Double;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('ps8v',@FS,@idfP);


{sp8v(vd1,n,y,vd2,k,x,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@SP8V;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_double;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_extended;
VT[6]:=fl_array_real_Double;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('sp8v',@FS,@idfP);




//complex
//pc8v(vd1,n,z1,vd2,k,z2,vd3,j)
flSetFunction('pc8v(vd1: arrayDbl; n1: int;  d: ComplexDbl;  vd2: arrayDbl; n2: int; x: ComplexExt; vd3: arrayDbl; n3: int):complex  = (vd1[n1]*d-vd2[n2]*x)*vd3[n3]',0,@idfP);
//ms8v(vd1,n1,d,vd2,n2,x,vd3,n3)=(vd1[n1]*d-vd2[n2]*x)*vd3[n3];
{ms8v(vd1,n,z1,vd2,k,z2,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@MS8VZ;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_complex_double;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_complex_extended;
VT[6]:=fl_array_real_Double;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
flSetFunction('ms8v',@FS,@idfP);


{ps8v(vd1,n,y,vd2,k,x,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@PS8VZ;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_complex_double;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_complex_extended;
VT[6]:=fl_array_real_Double;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
flSetFunction('ps8v',@FS,@idfP);


{sp8v(vd1,n,z1,vd2,k,z2,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@SP8VZ;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_complex_double;
VT[3]:=fl_array_real_Double;  VT[4]:=fl_real_integer;
VT[5]:=fl_complex_extended;
VT[6]:=fl_array_real_Double;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
flSetFunction('sp8v',@FS,@idfP);






//pc8i(vd1,n,y,ve2,k,x,vi3,j)
flSetFunction('pc8i(vd1: arrayDbl; n1: int;  d: dbl;  ve2: arrayExt; n2: int; x: ext; vi3: arrayInt; n3: int)  = (vd1[n1]*d-ve2[n2]*x)*vi3[n3]',0,@idfP);

//ms8v(vd1,n1,d,ve2,n2,x,vi3,n3)=(vd1[n1]*d-ve2[n2]*x)*vi3[n3];
{ms8v(vd1,n,y,ve2,k,x,vi3,j)}
InitFuncStruct(FS);
FS.addr:=@MS8i;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_double;
VT[3]:=fl_array_real_Extended;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_extended;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('ms8i',@FS,@idfP);


{ps8v(vd1,n,y,vd2,k,x,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@PS8i;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_double;
VT[3]:=fl_array_real_Extended;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_extended;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('ps8i',@FS,@idfP);


{sp8v(vd1,n,y,vd2,k,x,vd3,j)}
InitFuncStruct(FS);
FS.addr:=@SP8i;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_real_double;
VT[3]:=fl_array_real_Extended;  VT[4]:=fl_real_integer;
VT[5]:=fl_real_extended;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('sp8i',@FS,@idfP);



//complex
//pc8i(vd1,n,z1,ve2,k,z2,vi3,j)
flSetFunction('pc8i(vd1: arrayDbl; n1: int;  d: ComplexDbl;  ve2: arrayExt; n2: int; x: ComplexExt; vi3: arrayInt; n3: int):complex  = (vd1[n1]*d-ve2[n2]*x)*vi3[n3]',0,@idfP);
//ms8i(vd1,n1,z1,ve2,n2,z2,vi3,n3)=(vd1[n1]*z1-ve2[n2]*z2)*vi3[n3];
{ms8i(vd1,n,z1,ve2,k,z2,vi3,j)}
InitFuncStruct(FS);
FS.addr:=@MS8iZ;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_complex_double;
VT[3]:=fl_array_real_Extended;  VT[4]:=fl_real_integer;
VT[5]:=fl_complex_extended;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=4;
FS.ResultType:=fl_Complex;
flSetFunction('ms8i',@FS,@idfP);


{ps8i(vd1,n,z1,ve2,k,z2,vi3,j)}
InitFuncStruct(FS);
FS.addr:=@PS8iZ;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_complex_double;
VT[3]:=fl_array_real_Extended;  VT[4]:=fl_real_integer;
VT[5]:=fl_complex_extended;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=4;
FS.ResultType:=fl_Complex;
flSetFunction('ps8i',@FS,@idfP);


{sp8i(vd1,n,z1,ve2,k,z2,vi3,j)}
InitFuncStruct(FS);
FS.addr:=@SP8iZ;
SetLength(VT,8);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
VT[2]:=fl_complex_double;
VT[3]:=fl_array_real_Extended;  VT[4]:=fl_real_integer;
VT[5]:=fl_complex_extended;
VT[6]:=fl_array_real_Integer;  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=4;
FS.ResultType:=fl_Complex;
flSetFunction('sp8i',@FS,@idfP);


//spall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
InitFuncStruct(FS);
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_ARRAY_REAL_EXTENDED; VT[1]:=fl_REAL_INTEGER; VT[2]:=fl_COMPLEX_EXTENDED; VT[3]:=fl_ARRAY_REAL_DOUBLE;
VT[4]:=fl_REAL_INTEGER; VT[5]:=fl_REAL_DOUBLE; VT[6]:=fl_COMPLEX_DOUBLE;  VT[7]:=fl_REAL_EXTENDED;
VT[8]:=fl_ARRAY_REAL_INTEGER; VT[9]:=fl_REAL_INTEGER;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
FS.addr:=@spall;
flSetFunction('spall',@FS,@idfP);


//psall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
InitFuncStruct(FS);
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_ARRAY_REAL_EXTENDED; VT[1]:=fl_REAL_INTEGER; VT[2]:=fl_COMPLEX_EXTENDED; VT[3]:=fl_ARRAY_REAL_DOUBLE;
VT[4]:=fl_REAL_INTEGER; VT[5]:=fl_REAL_DOUBLE; VT[6]:=fl_COMPLEX_DOUBLE;  VT[7]:=fl_REAL_EXTENDED;
VT[8]:=fl_ARRAY_REAL_INTEGER; VT[9]:=fl_REAL_INTEGER;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
FS.addr:=@psall;
flSetFunction('psall',@FS,@idfP);


//msall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
InitFuncStruct(FS);
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_ARRAY_REAL_EXTENDED; VT[1]:=fl_REAL_INTEGER; VT[2]:=fl_COMPLEX_EXTENDED; VT[3]:=fl_ARRAY_REAL_DOUBLE;
VT[4]:=fl_REAL_INTEGER; VT[5]:=fl_REAL_DOUBLE; VT[6]:=fl_COMPLEX_DOUBLE;  VT[7]:=fl_REAL_EXTENDED;
VT[8]:=fl_ARRAY_REAL_INTEGER; VT[9]:=fl_REAL_INTEGER;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
FS.addr:=@msall;
flSetFunction('msall',@FS,@idfP);


//pcall
flSetFunction('pcall(vx: arrayExt; nx:int; zx: CXext; vd: arrayDbl; nd: int; d: dbl; zd: CXdbl; x: ext; vi: arrayInt; ni: int):complex=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]',0,@idfP);






//sp8pai(ve,ne,x,vd,nd,d,vi,ni) = (ve[ne]*x - vd[nd]*d)*vi[ni]
InitFuncStruct(FS);
FS.addr:=@SP8PAI;
SetLength(VT,8);
VT[0]:=fl_real_Integer {fl_array_real_Extended};  VT[1]:=fl_real_integer;
VT[2]:=fl_real_Extended;
VT[3]:=fl_real_Integer{fl_array_real_Double};  VT[4]:=fl_real_integer;
VT[5]:=fl_real_double;
VT[6]:=fl_real_Integer{fl_array_real_Integer};  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('sp8pai',@FS,@idfP);
//sp8pai(ve,n+1,x,vd,k+2,d,vi,j+3) - Type Error. Only integer var:
//ave:int = ve; avd:int = vd; avi:int = vi;  sp8pai(ave,n+1,x,avd,k+2,d,avi,j+3)



//sp8pai(@ve,ne,x,@vd,nd,d,@vi,ni) = (ve[ne]*x - vd[nd]*d)*vi[ni]
InitFuncStruct(FS);
FS.addr:=@SP8PA;
SetLength(VT,8);
VT[0]:=fl_real_Integer {fl_array_real_Extended};  VT[1]:=fl_real_integer;
VT[2]:=fl_real_Extended;
VT[3]:=fl_real_Integer{fl_array_real_Double};  VT[4]:=fl_real_integer;
VT[5]:=fl_real_double;
VT[6]:=fl_real_Integer{fl_array_real_Integer};  VT[7]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=8;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('sp8pa',@FS,@idfP);
//sp8(ve,n+1,x,vd,k+2,d,vi,j+3)
//sp8pa(@ve,n+1,x,@vd,k+2,d,@vi,j+3)
//ave:int = @ve; avd:int = @vd; avi:int = @vi;  sp8pa(ave,n+1,x,avd,k+2,d,avi,j+3)





//fovl(z1+z2,vd,k+j)*fovl(vd,k+j,z1+z2)+fovl(z1+z3,ve,k+j+2)*fovl(ve,k+j+2,z1+z3)+fovl(z2+z3,vi,k+n+1)*fovl(vi,k+n+1,z2+z3)
//fovl(y+x,vd,k+j)*fovl(vd,k+j,y+x)+fovl(x+t,ve,k+j+2)*fovl(ve,k+j+2,x+t)+fovl(t+y,vi,k+n+1)*fovl(vi,k+n+1,t+y)

//fovl(vd,n,x)=vd[n]/x;
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Double;
VT[1]:=fl_real_integer;
VT[2]:=fl_real_extended;
FS.addr:=@_fovlDR;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(vx,n,x)=vx[n]/x;
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Extended;
VT[1]:=fl_real_integer;
VT[2]:=fl_real_extended;
FS.addr:=@_fovlER;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);

//fovl(vi,n,x)=vi[n]/x;
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Integer;
VT[1]:=fl_real_integer;
VT[2]:=fl_real_extended;
FS.addr:=@_fovlIR;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(vd,n,z)=vd[n]/z;
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Double;
VT[1]:=fl_real_integer;
VT[2]:=fl_complex_extended;
FS.addr:=@_fovlDZ;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(vx,n,z)=vx[n]/z;
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Extended;
VT[1]:=fl_real_integer;
VT[2]:=fl_complex_extended;
FS.addr:=@_fovlEZ;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);

//fovl(vi,n,z)=vi[n]/z;
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Integer;
VT[1]:=fl_real_integer;
VT[2]:=fl_complex_extended;
FS.addr:=@_fovlIZ;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(x,vd,n)=x/vd[n];
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_real_extended;
VT[1]:=fl_array_real_Double;
VT[2]:=fl_real_integer;
FS.addr:=@_fovlRD;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);



//fovl(x,vx,n)=x/vx[n];
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_real_extended;
VT[1]:=fl_array_real_Extended;
VT[2]:=fl_real_integer;
FS.addr:=@_fovlRE;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(x,vi,n)=x/vi[n];
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_real_extended;
VT[1]:=fl_array_real_Integer;
VT[2]:=fl_real_integer;
FS.addr:=@_fovlRI;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(z,vd,n)=z/vd[n];
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_complex_extended;
VT[1]:=fl_array_real_Double;
VT[2]:=fl_real_integer;
FS.addr:=@_fovlZD;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(z,vx,n)=z/vx[n];
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_complex_extended;
VT[1]:=fl_array_real_Extended;
VT[2]:=fl_real_integer;
FS.addr:=@_fovlZE;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);


//fovl(z,vi,n)=z/vi[n];
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_complex_extended;
VT[1]:=fl_array_real_Integer;
VT[2]:=fl_real_integer;
FS.addr:=@_fovlZI;
FS.CallType:=fl_stdcall;
FS.Arg:=Length(VT);
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('fovl',@FS,@idfP);



//ps6(vd,x,ve,n,y,j)=vd[n]-ve[j]+x-y;
InitFuncStruct(FS);
SetLength(VT,6);
VT[0]:=fl_array_real_Double; VT[1]:=fl_real_double; VT[2]:=fl_array_real_Extended;
VT[3]:=fl_real_integer; VT[4]:=fl_real_extended;  VT[5]:=fl_real_integer;
FS.addr:=@ps6;
FS.CallType:=fl_Cdecl;
FS.Arg:=6;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps6',@FS,@idfP);

//fl_EAX:
//azzr(z1,z2,x)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_Complex_double; VT[1]:=fl_Complex_double; VT[2]:=fl_Real_Double;
FS.addr:=@a_zzr;
FS.CallFunc:=fl_VARS_LIST_ADDR_EAX;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.DeepFPU:=2;
flSetFunction('azzr',@FS,@idfP);


//arrz(x,y,z1)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_Real_double; VT[1]:=fl_real_double; VT[2]:=fl_complex_double;
FS.addr:=@a_rrz;
FS.CallFunc:=fl_VARS_LIST_ADDR_EAX;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.DeepFPU:=2;
flSetFunction('arrz',@FS,@idfP);



//azrz(z1,y,z2)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_complex_double; VT[1]:=fl_real_double; VT[2]:=fl_complex_double;
FS.addr:=@a_zrz;
FS.CallFunc:=fl_VARS_LIST_ADDR_EAX;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.DeepFPU:=2;
flSetFunction('azrz',@FS,@idfP);


//fl_INFINITE
//infsum(z1); infsum(z1,z2); ...
InitFuncStruct(FS);
FS.addr:=@sumz;
FS.ArgType:=c_ComplexFloat;//fl_Complex_double;
FS.CallFunc:=fl_INFINITE;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_Complex;
FS.DeepFPU:=2;
flSetFunction('infsum',@FS,@idfP);


//infsum(x); infsum(x,y); ...
InitFuncStruct(FS);
FS.addr:=@sumr;
FS.ArgType:=c_RealFloat;//fl_real_double;
FS.CallFunc:=fl_INFINITE;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_real;
FS.DeepFPU:=2;
flSetFunction('infsum',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@polyUR;
FS.ArgType:=c_RealFloat;
FS.CallFunc:=fl_INFINITE;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_real;
FS.DeepFPU:=2;
flSetFunction('polyu',@FS,@idfP);



{
//sum(x,z1); sum(z1,x,z2,y); ...
InitFuncStruct(FS);
FS.addr:=@sumd;
FS.ArgType:=fl_differ_double;
FS.CallFunc:=fl_INFINITE;
FS.CallType:=fl_stdcall;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.DeepFPU:=2;
flSetFunction('infs',@FS);
}

//fl_VARS_VALUES
//test(z1,t,y,z2)
InitFuncStruct(FS);
SetLength(VT,4);
VT[0]:=fl_Complex_Double; VT[1]:=fl_real_extended; VT[2]:=fl_Real_Double; VT[3]:=fl_Complex_extended;
FS.addr:=@test;
FS.CallType:=fl_StdCall;
FS.Arg:=4;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_Complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('test',@FS,@idfP);


//sum3(z1,z2,x)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_complex_double; VT[1]:=fl_complex_double; VT[2]:=fl_Real_double;
FS.addr:=@v_zzr;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sum3',@FS,@idfP);

//sp4(x,y,t,x)
InitFuncStruct(FS);
SetLength(VT,4);
VT[0]:=fl_real_extended; VT[1]:=fl_real_double; VT[2]:=fl_Real_extended; VT[3]:=fl_real_double;
FS.addr:=@sp4;
FS.CallType:=fl_cdecl;
FS.Arg:=4;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp4',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3*$arg4-$dfarg4*$arg3');


 
//sum3(x,y,z1)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_real_double; VT[1]:=fl_real_double; VT[2]:=fl_complex_double;
FS.addr:=@v_rrz;
FS.CallType:=fl_cdecl;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sum3',@FS,@idfP);


//sp3(z1,z2,x)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[1]:=c_ComplexFloat;// fl_complex_double;    fl_complex_extended;
VT[2]:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.addr:=@SP3ZZR;
FS.CallType:=fl_cdecl;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp3',@FS,@idfP);



//extended

//sp2x(x,y)
InitFuncStruct(FS);
FS.addr:=@sp2x;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp2x',@FS,@idfP);

//sp2x(z1,z2)
InitFuncStruct(FS);
FS.addr:=@sp2zx;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp2x',@FS,@idfP);

//sp1x(x)
InitFuncStruct(FS);
FS.addr:=@sp1x;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp1x',@FS,@idfP);


//sp1x(z1)
InitFuncStruct(FS);
FS.addr:=@sp1zx;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp1x',@FS,@idfP);


//sp3x(x,y,t)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_real_extended; VT[1]:=fl_real_extended; VT[2]:=fl_Real_extended;
FS.addr:=@sp3x;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp3x',@FS,@idfP);


//sp3x(z1,z2,z3)
InitFuncStruct(FS);
FS.addr:=@sp3zx;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp3x',@FS,@idfP);

//sp2x(z1,x)
InitFuncStruct(FS);
SetLength(VT,2);
VT[0]:=fl_complex_extended; VT[1]:=fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.addr:=@sp2zrx;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp2x',@FS,@idfP);

//sp2x(x,z1)
InitFuncStruct(FS);
SetLength(VT,2);
VT[0]:=fl_real_extended; VT[1]:=fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.addr:=@sp2rzx;
FS.CallType:=fl_stdcall;
FS.Arg:=2;
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp2x',@FS,@idfP);


InitFuncStruct(FS);
FS.ArgType:=fl_Differ;
SetLength(VT,4);
VT[0]:=fl_complex_extended; VT[1]:=fl_complex_double; VT[2]:=fl_complex_extended;  VT[3]:=fl_complex_double;
FS.addr:=@sp4z;
FS.ArgTypeList:=@VT[0];
FS.CallType:=fl_stdcall;
FS.Arg:=4;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp4',@FS,@idfP);





//vt4(z1,k,vd,x)
InitFuncStruct(FS);
SetLength(VT,4);
VT[0]:=fl_Complex_Double; VT[1]:=fl_real_integer; VT[2]:=fl_array_real_Double; VT[3]:=fl_real_double;
FS.addr:=@vt4;
FS.CallType:=fl_StdCall;
FS.Arg:=4;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('vt4',@FS,@idfP);



//vt2(x,k)
InitFuncStruct(FS);
SetLength(VT,2);
VT[0]:=fl_real_Double; VT[1]:=fl_real_integer;
FS.addr:=@vt2;
FS.CallType:=fl_StdCall;
FS.Arg:=2;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('vt2',@FS,@idfP);


//sp10
InitFuncStruct(FS);
FS.addr:=@sp10;
FS.CallType:=fl_pascal;
FS.Arg:=10;
FS.ArgType:=fl_real_double;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sp10',@FS,@idfP);

//ms10
InitFuncStruct(FS);
FS.addr:=@MS10;
FS.ArgType:=fl_Real_double;
FS.Arg:=10;
FS.DeepFPU:=2;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_Real;
flSetFunction('ms10',@FS,@idfP);

//pc10(x,y,t,x-y,t-y,t-x,x*t,y*t,t*y,x*y-t)
flSetFunction('{$IN+}pc10(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10):real=x1+x2-x3+x4-x5+x6-x7+x8-x9+x10',0,@idfP);


//ps10(x,y,t)
InitFuncStruct(FS);
FS.addr:=@ps10;
FS.CallType:=fl_pascal;
FS.Arg:=10;
FS.ArgType:=fl_Real_Double;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps10',@FS,@idfP);




//Array (_StdCall,_Cdecl)!!!
//fvd1(vd)
InitFuncStruct(FS);
FS.addr:=@fvd1;
FS.CallType:=fl_StdCall;
FS.Arg:=1;
FS.ArgType:=fl_array_real_double;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('fvd1',@FS,@idfP);



//pve1(ve)
InitFuncStruct(FS);
FS.addr:=@pve1;
FS.CallType:=fl_StdCall;
FS.Arg:=1;
FS.ArgType:=fl_array_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('pve1',@FS,@idfP);



//Fvd3(vd,ve,k)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Double; VT[1]:=fl_array_real_extended; VT[2]:=fl_real_integer;
FS.addr:=@Fvd3;
FS.CallType:=fl_StdCall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fvd3',@FS,@idfP);



//pvd3(vd,ve,k)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Double; VT[1]:=fl_array_real_extended; VT[2]:=fl_real_integer;
FS.addr:=@pvd3;
FS.CallType:=fl_StdCall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('pvd3',@FS,@idfP);

// mvd3(vd,ve,k)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_array_real_Double; VT[1]:=fl_array_real_extended; VT[2]:=fl_real_integer;
FS.addr:=@mvd3;
FS.CallType:=fl_StdCall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.DeepFPU:=2;
flSetFunction('mvd3',@FS,@idfP);


//pcvd3(vd,ve,k)
flSetFunction('pcvd3(ad: array dbl; ae: array ext; n: int)=ad[n]+ae[n]',0,@idfP);


//fv5(vd,y,ve,k,x)
InitFuncStruct(FS);
SetLength(VT,5);
VT[0]:=fl_array_real_Double; VT[1]:=fl_real_double; VT[2]:=fl_array_real_extended; VT[3]:=fl_real_integer; VT[4]:=fl_real_extended;
FS.addr:=@fv5;
FS.CallType:=fl_StdCall;
FS.Arg:=5;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('fv5',@FS,@idfP);

(*
InitFuncStruct(FS);
SetLength(VT,2);
VT[0]:=fl_array_real_Double;  VT[1]:=fl_real_integer;
FS.addr:=@SetLA;
FS.CallType:=fl_StdCall;
FS.Arg:=2;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('setlen',@FS);
*)

InitFuncStruct(FS);
FS.addr:=@FVDL;
FS.Arg:=1;
FS.CallType:=fl_StdCall;
FS.CallFunc:=fl_VARS_VALUES;
FS.ArgType:=fl_array_real_double;
FS.ResultType:=fl_none;
FS.DeepFPU:=1;
flSetFunction('fvdl',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@pvdl;
FS.Arg:=1;
FS.ArgType:=fl_array_real_double;
FS.ResultType:=fl_real;
FS.CallType:=fl_StdCall;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('pvdl',@FS,@idfP);

//pv5(vd,y,ve,k,x)
InitFuncStruct(FS);
SetLength(VT,5);
VT[0]:=fl_array_real_Double; VT[1]:=fl_real_double; VT[2]:=fl_array_real_extended; VT[3]:=fl_real_integer; VT[4]:=fl_real_extended;
FS.addr:=@pv5;
FS.CallType:=fl_StdCall;
FS.Arg:=5;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('pv5',@FS,@idfP);


//pt4(z1,k,vd,x)
InitFuncStruct(FS);
SetLength(VT,4);
VT[0]:=fl_complex_Double; VT[1]:=fl_real_integer; VT[2]:=fl_array_real_double; VT[3]:=fl_real_double;
FS.addr:=@pt4;
FS.CallType:=fl_StdCall;
FS.Arg:=4;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('pt4',@FS,@idfP);



//fint1(int)
InitFuncStruct(FS);
FS.addr:=@fint1;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:= fl_real_integer;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
FS.CalcConst:=fl_Disable;
flSetFunction('fint1',@FS,@idfP);



//fint3(int)
InitFuncStruct(FS);
FS.addr:=@fint3;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:= fl_real_integer;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
FS.CalcConst:=fl_Disable;
flSetFunction('fint3',@FS,@idfP);



//fint1p(ptr)
InitFuncStruct(FS);
FS.addr:=@fint1;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:= fl_pointer;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
FS.CalcConst:=fl_Disable;
flSetFunction('fint1p',@FS,@idfP);



//Fflt1(x)
InitFuncStruct(FS);
FS.addr:=@Fflt1;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:= c_RealFloat;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('Fflt1',@FS,@idfP);



//flSet(fl_DISABLE,fl_USE_POINTER,0);
//flSet(fl_DISABLE,fl_USE_INTEGER_POINTER,0);




{spadr0()= Global_X^3;}
//callr(@spadr0)
//callr(addr(spadr0))
//n=@spadr0; callr(n);
//vi[k]=@spadr0; callr(vi[k]);
InitFuncStruct(FS);
FS.addr:=@spadr0;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spadr0',@FS,@idfP);



//spCallExt(@x,@pcRFN1,y)
InitFuncStruct(FS);
FS.addr:=@spCallExt;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=fl_Pointer; VT[1]:=fl_Pointer; VT[2]:=c_RealFloat;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
//FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spCallExt',@FS,@idfP);
flSetFunction('{$RF-}pcRFN1():real=x^x',0,@idfP);


//spCallExt(@x,@pcRFN1,y)+spCallExt(@x,@pcRFN1,y)
//CallR(@pcRFN1)+CallR(@pcRFN1)






///////////////////////////////////////////////////////////////////////////////
       ////  POINTER, CALL, PROC ////

////////////////////////////////////////////////////////////////////////////////

//spproc2r
//spproc2r(x,y,@res.re); res.re
InitFuncStruct(FS);
FS.addr:=@spproc2r;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat;  VT[1]:=c_RealFloat;  VT[2]:=fl_Pointer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('spproc2r',@FS,@idfP);



//spproc2c
//spproc2c(z1,z2,@res); res
InitFuncStruct(FS);
FS.addr:=@spproc2c;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_ComplexFloat;  VT[1]:=c_ComplexFloat;  VT[2]:=fl_Pointer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
//FS.ArgType:={fl_real_integer;}fl_Pointer;//fl_real_integer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('spproc2c',@FS,@idfP);



// x=1.1; y=5.5; spprocswpinc2r(@x,@y);
// x=1.1; y=5.5; t=spprocswpinc2r(@x,@y); x
// x=1.1; y=5.5; t=spprocswpinc2r(@x,@y); y

InitFuncStruct(FS);
FS.addr:=@spprocswpinc2r;
FS.Arg:=2;
FS.ArgType:=fl_Pointer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spprocswpinc2r',@FS,@idfP);




// z1=1.1+2.2i; z2=5.5+7.7i; spprocswpinc2c(@z1,@z2);
// z1=1.1+2.2i; z2=5.5+7.7i; z3=spprocswpinc2c(@z1,@z2); z1
// z1=1.1+2.2i; z2=5.5+7.7i; z3=spprocswpinc2c(@z1,@z2); z2

InitFuncStruct(FS);
FS.addr:=@spprocswpinc2c;
FS.Arg:=2;
FS.ArgType:=fl_Pointer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
flSetFunction('spprocswpinc2c',@FS,@idfP);




//x=3; z1=1.1+2.2i; spprocsqr2(@x,@z1); x
//x=3; z1=1.1+2.2i; spprocsqr2(@x,@z1); z1

InitFuncStruct(FS);
FS.addr:=@spprocsqr2;
FS.Arg:=2;
FS.ArgType:=fl_Pointer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_None;
flSetFunction('spprocsqr2',@FS,@idfP);




//spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3); (resR=x+y; resC=z1+z2; resI=n1+n2; resV=vu1+vu2)
//x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  s-(2*x+1 + 3*y+2)
//x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  m-(n+k + 2*j*k)
//x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  z5-(2*z1 + 5*z1+z2)
//x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  r=0; for(k,0,len(vu3)-1,r=vu3[k]-(vu1[k]+vu2[k]));r
//x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  r=0; kf:int=0;  for(kf,0,len(vu3)-1,r=r+(vu1[kf]+vu2[kf])); r/sum(vu3)+s/(2*x+1 + 3*y+2)+ m/(n+k + 2*j*k)+z5/(2*z1 + 5*z1+z2)


InitFuncStruct(FS);
FS.addr:=@spprocsumall;
FS.Arg:=12;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat;
VT[1]:=c_RealFloat;
VT[2]:=fl_Real_Integer;
VT[3]:=fl_Real_Integer;
VT[4]:=c_ComplexFloat;
VT[5]:=c_ComplexFloat;
VT[6]:=c_ArrayType;
VT[7]:=c_ArrayType;
VT[8]:=fl_Pointer;
VT[9]:=fl_Pointer;
VT[10]:=fl_Pointer;
VT[11]:=fl_Pointer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_None;
flSetFunction('spprocsumall',@FS,@idfP);



 // spproctest(@FRInt1XYT, @x,@y,@t,a,b, @FRLim1X, @FRLim2X,  @FRLim3XY, @FRLim4XY)
  // spproctest(@pcInt1XYT, @x,@y,@t,a,b, @FRLim1X, @FRLim2X,  @FRLim3XY, @FRLim4XY)
InitFuncStruct(FS);
FS.addr:=@spproctest;
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_Pointer;
VT[1]:=fl_Pointer;
VT[2]:=fl_Pointer;
VT[3]:=fl_Pointer;
VT[4]:=c_RealFloat;
VT[5]:=c_RealFloat;
VT[6]:=fl_Pointer;
VT[7]:=fl_Pointer;
VT[6]:=fl_Pointer;
VT[7]:=fl_Pointer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('spproctest',@FS,@idfP);




// Integral3FF(Func: Pointer;  PV1,PV2,PV3: PFloatType; a,b: TFloatType; Func1,Func2,Func3,Func4: Pointer): TFloatType;


// Integral3FF(@FRInt1XYT, @x,@y,@t, a,f, @FRLim1X, @FRLim2X,  @FRLim3XY, @FRLim4XY)
// Integral3FF(@pcInt1XYT, @x,@y,@t, a,f, @pcLim1X, @pcLim2X,  @pcLim3XY, @pcLim4XY)
InitFuncStruct(FS);
FS.addr:=@Integral3FF;
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_Pointer;
VT[1]:=fl_Pointer;
VT[2]:=fl_Pointer;
VT[3]:=fl_Pointer;
VT[4]:=c_RealFloat;
VT[5]:=c_RealFloat;
VT[6]:=fl_Pointer;
VT[7]:=fl_Pointer;
VT[8]:=fl_Pointer;
VT[9]:=fl_Pointer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=8;
FS.ResultType:=fl_Real;
flSetFunction('Integral3FF',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@FRInt1XYT;
FS.Arg:=0;
//FS.ArgType:=c_RealFloat;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('FRInt1XYT',@FS,@idfP);
flSetFunction('pcInt1XYT():real=0.11*x*(0.32*t-0.23*y)',0,@idfP1);




InitFuncStruct(FS);
FS.addr:=@FRInt2XYT;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('FRInt2XYT',@FS,@idfP);
flSetFunction('pcInt2XYT():real=0.17*t*(0.31*x+0.17*y)',0,@idfP2);



InitFuncStruct(FS);
FS.addr:=@FRInt3XYT;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('FRInt3XYT',@FS,@idfP);
flSetFunction('pcInt3XYT():real=0.21*y*(0.25*x-0.15*t)',0,@idfP3);
//flSetFunction('pcInt3XYT():real=cos(x*t*(y-x))*sin(y*t*(x-t))',0,@idfP);



InitFuncStruct(FS);
FS.addr:=@FRLim1X;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('FRLim1X',@FS,@idfP);
flSetFunction('pcLim1X():real=-0.5*sqr(x-1.1)',0,@idfP);



InitFuncStruct(FS);
FS.addr:=@FRLim2X;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('FRLim2X',@FS,@idfP);
flSetFunction('pcLim2X():real=0.7*sqr(x+1.7)',0,@idfP);



InitFuncStruct(FS);
FS.addr:=@FRLim3XY;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('FRLim3XY',@FS,@idfP);
flSetFunction('pcLim3XY():real=-0.1*sqr(1.1*x-0.2*y)',0,@idfP);


InitFuncStruct(FS);
FS.addr:=@FRLim4XY;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('FRLim4XY',@FS,@idfP);
flSetFunction('pcLim4XY():real=0.2*sqr(1.2*x-0.3*y)',0,@idfP);

{

PFLim1X:pointer = @FRLim1X; PFLim2X:pointer = @FRLim2X; PFLim3XY:pointer =  @FRLim3XY; PFLim4XY:pointer =  @FRLim4XY;
L:Int=3; VPF: arrayP = L; VPF[0] = @FRInt1XYT;  VPF[1] = @FRInt2XYT; VPF[2] = @FRInt3XYT;  s:ext=0; n:int=0;
for(n,0,L-1, s=s + Integral3FF(VPF[n], @x,@y,@t, a,f, PFLim1X, PFLim2X,  PFLim3XY, PFLim4XY));s

}


{

PFLim1X:pointer = @pcLim1X; PFLim2X:pointer = @pcLim2X; PFLim3XY:pointer =  @pcLim3XY; PFLim4XY:pointer =  @pcLim4XY;
L:Int=3; VPF: arrayP = L; VPF[0] = @pcInt1XYT;  VPF[1] = @pcInt2XYT; VPF[2] = @pcInt3XYT;  s:ext=0; n:int=0;
for(n,0,L-1, s=s + Integral3FF(VPF[n], @x,@y,@t, a,f, PFLim1X, PFLim2X,  PFLim3XY, PFLim4XY));s

}


flSetVar('PtrF1',@PtrF1, fl_Pointer); flSetVar('PtrF2',@PtrF2, fl_Pointer);
flSetVar('PtrF3',@PtrF3, fl_Pointer); flSetVar('PtrF4',@PtrF4, fl_Pointer);
flSetVar('VPFint',@vpfInt, fl_Array_Pointer);
SetLength(vpfInt,3);
ptrF1:=@FRLim1X; ptrF2:=@FRLim2X; ptrF3:= @FRLim3XY; ptrF4:=@FRLim4XY;
vpfInt[0]:=@FRInt1XYT; vpfInt[1]:=@FRInt2XYT; vpfInt[2]:=@FRInt3XYT;

{

L:Int=Len(vpF3);  s:ext=0; n:int=0;
for(n,0,L-1, s=s + Integral3FF(VPF3[n], @x,@y,@t, a,f, PtrF1, PtrF2,  PtrF3, PtrF4));s

}

flSetVar('px',@PVX,fl_Pointer);
flSetVar('py',@PVY,fl_Pointer);
flSetVar('pt',@PVT,fl_Pointer);


{

L:Int=Len(vpF3);  s:ext=0; n:int=0;
for(n,0,L-1, s=s + Integral3FF(VPF3[n], px,py,pt, a,f, PtrF1, PtrF2,  PtrF3, PtrF4));s

}





ptr1:=@FRInt1XYT; ptr2:=@FRInt2XYT; ptr3:= @FRInt3XYT;
VP1[0]:=@FRInt1XYT;  VP1[1]:=@FRInt2XYT; VP1[2]:=@FRInt3XYT;

{
 x=1.1; y=2.2; t=3.3;
 s:ext=0; s=s+callR(ptr1);  s=s+callR(ptr2); s=s+callR(ptr3); s
}

{
  L:Int=3;  s:ext=0; n:int=0;
  x=1.1; y=2.2; t=3.3;
  for(n,0,L-1, s=s + callR(VP1[n]));s
}


flGetFunctionAddr(@idfP1,Ptr1);
flGetFunctionAddr(@idfP2,Ptr2);
flGetFunctionAddr(@idfP3,Ptr3);

//ptr1:=@pcInt1XYT; ptr2:=@pcInt2XYT; ptr3:= @pcInt3XYT;
VP1[0]:=Ptr1;  VP1[1]:=Ptr2; VP1[2]:=Ptr3;

//  x=1.1; y=2.2; t=3.3; callR(Ptr1)+callR(Ptr2)+callR(Ptr3)
{
  L:Int=3;  s:ext=0; n:int=0;
  x=1.1; y=2.2; t=3.3;
  for(n,0,L-1, s=s + callR(VP1[n]));s
}






//spcallfunc3(@funcr1,@funcr2,@funcr3)+spcallfunc3(@funcr1,@funcr2,@funcr3)
InitFuncStruct(FS);
FS.addr:=@spcallfunc3;
FS.Arg:=3;
FS.ArgType:=fl_Pointer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=3;
FS.ResultType:=fl_Real;
flSetFunction('spcallfunc3',@FS,@idfP);
flSetFunction('funcr1()=x+1',0,@idfP);
//flSetFunction('{$RF-}funcr1()=x+1',0,@idfP);
flSetFunction('{$RF-}funcr2()=x+2',0,@idfP);
//flSetFunction('funcr2()=x+2',0,@idfP);
//flSetFunction('funcr3()=x+3',0,@idfP);
flSetFunction('{$RF-}funcr3()=x+3',0,@idfP);



{spadr1fp(px)= (px^)^3;}
//spadr1(@x)
//n=@x; spadr1(n);
InitFuncStruct(FS);
FS.addr:=@spadr1fp;
FS.Arg:=1;
FS.ArgType:={fl_real_integer;}fl_Pointer;//fl_real_integer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spadr1',@FS,@idfP);


{spadr1(@func,@Var,Val) = Var=Val; spadr1=call(@Func)}
InitFuncStruct(FS);
FS.addr:=@spadr1;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_Integer;  VT[1]:=fl_real_integer;  VT[2]:=c_RealFloat;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spadr1',@FS,@idfP);
//spadr1(@spadr0,@gx,5)




{spadr2(@func,@Var) =  Var=call(@Func)}
InitFuncStruct(FS);
FS.addr:=@spadr2;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_Integer;  VT[1]:=fl_real_integer; // VT[2]:=c_RealFloat;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('spadr2',@FS,@idfP);
//spadr2(@spadr0,@gx);



{spadr3(x, vec, @IntVar) =  Vec[IntVar]=x}
InitFuncStruct(FS);
FS.addr:=@spadr3;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat; VT[1]:=c_ArrayType;  VT[2]:=fl_real_integer;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('spadr3',@FS,@idfP);


{spadr3pa(x, @vec, @IntVar) =  Vec[IntVar]=x}
InitFuncStruct(FS);
FS.addr:=@spadr3pa;
FS.Arg:=3;
SetLength(VT,FS.Arg);
VT[0]:=c_RealFloat; VT[1]:=fl_real_integer;  VT[2]:=fl_real_integer;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('spadr3',@FS,@idfP);


{spadrv(@vec,IntVar) =  Vec[IntVar]}
InitFuncStruct(FS);
FS.addr:=@spadrv;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_Integer;  VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('spadrv',@FS,@idfP);
//spadr(@vu1,k)



{spadrv(@vec,IntVar) =  Vec[IntVar]}
//ptr0:pointer=@vd[0];  k:int=5; fptr3vd(ptr0,ptr0+8,ptr0+8*k)/(vd[0]+vd[1]+vd[k])
InitFuncStruct(FS);
FS.addr:=@fptr3vd;
FS.Arg:=3;
FS.ArgType:=fl_Pointer;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('fptr3vd',@FS,@idfP);









{spadrInt1(IntVar,IntVal) = PInteger(IntVar)=IntVal}
InitFuncStruct(FS);
FS.addr:=@spadrInt1;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_Integer;  VT[1]:=fl_real_integer;
//FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('spadrInt1',@FS,@idfP);
//k=@n; spadrInt1(k,123); n




{spadrInt1(IntVar,IntVal) = PFloatType(FloatVar)=FloatVal}
InitFuncStruct(FS);
FS.addr:=@spadrFlt1;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_Integer;  VT[1]:=c_RealFloat;
//FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('spadrFlt1',@FS,@idfP);
//k=@x; spadrFlt1(k,123.456); x
//k=@z2.im; spadrFlt1(k,123.456); z2.im



flSetFunction('pcadrc():complex = z1+z2',0,@idfP);
flSetFunction('pcadrr():real = x+y',0,@idfP);
flSetFunction('pcadr():none = res=z1*x+z2*y',0,@idfP);
//flCompile('n=@pcadrc; callc(n)',0,FZ1);
//flCompile('n=@pcadrr; callr(n)',0,FZ1);
//flCompile('n=@pcadr; call(n)',0,FZ1);






//spall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
//spallp(pvx: PArrayE; nx: integer;  pzx: PComplexE;  pvd: PArrayD; nd: Integer; d: double; zd: TComplexD; px: PExtended;  pvi: PArrayI; pni: PInteger); cdecl;
InitFuncStruct(FS);
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_REAL_INTEGER{fl_ARRAY_REAL_EXTENDED};
VT[1]:=fl_REAL_INTEGER;
VT[2]:=fl_REAL_INTEGER{fl_COMPLEX_EXTENDED};
VT[3]:=fl_REAL_INTEGER{fl_ARRAY_REAL_DOUBLE};
VT[4]:=fl_REAL_INTEGER;
VT[5]:=fl_REAL_DOUBLE;
VT[6]:=fl_COMPLEX_DOUBLE;
VT[7]:=fl_REAL_INTEGER{fl_REAL_EXTENDED};
VT[8]:=fl_REAL_INTEGER{fl_ARRAY_REAL_INTEGER};
VT[9]:=fl_REAL_INTEGER{fl_REAL_INTEGER};
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
FS.addr:=@spallp;
flSetFunction('spall',@FS,@idfP); //Overload!   Dont work in  fl_USE_INTEGER_POINTER = fl_DISABLE:


//spall(ve,k+j,z5,vd,k+3,x+y,z1+z2,z4.im,vi,j)
//spall(@ve,k+j,@z5,@vd,k+3,x+y,z1+z2,@z4.im,@vi,@j)

//pve:int=@ve; pz5:int=@z5; pvd:int=@vd; pz4im:int=@z4.im; ;pvi:int=@vi; pj:int=@j; spall(pve,k+j,pz5,pvd,k+3,x+y,z1+z2,pz4im,pvi,pj)
//vi1[0]=@ve; vi1[1]=@z5; vi1[2]=@vd; vi1[3]=@z4.im; ; vi1[4]=@vi; vi1[5]=@j; spall(vi1[0],k+j,vi1[1],vi1[2],k+3,x+y,z1+z2,vi1[3],vi1[4],vi1[5])


InitFuncStruct(FS);
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_POINTER;{fl_ARRAY_REAL_EXTENDED};
VT[1]:=fl_REAL_INTEGER;
VT[2]:=fl_POINTER;{fl_COMPLEX_EXTENDED};
VT[3]:=fl_POINTER;{fl_ARRAY_REAL_DOUBLE};
VT[4]:=fl_REAL_INTEGER;
VT[5]:=fl_REAL_DOUBLE;
VT[6]:=fl_COMPLEX_DOUBLE;
VT[7]:=fl_POINTER;{fl_REAL_EXTENDED};
VT[8]:=fl_POINTER;{fl_ARRAY_REAL_INTEGER};
VT[9]:=fl_POINTER;{fl_REAL_INTEGER};
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
FS.addr:=@spallp;
flSetFunction('spall',@FS,@idfP); //Overload!       Also Work in  fl_USE_INTEGER_POINTER = fl_DISABLE
//spall(@ve,k+j,@z5,@vd,k+3,x+y,z1+z2,@z4.im,@vi,@j)
//pve:int=@ve; pz5:int=@z5; pvd:int=@vd; pz4im:int=@z4.im; ;pvi:int=@vi; pj:int=@j; spall(pve,k+j,pz5,pvd,k+3,x+y,z1+z2,pz4im,pvi,pj)
//pve:ptr=@ve; pz5:ptr=@z5; pvd:ptr=@vd; pz4im:ptr=@z4.im; ;pvi:ptr=@vi; pj:ptr=@j; spall(pve,k+j,pz5,pvd,k+3,x+y,z1+z2,pz4im,pvi,pj)




//spallp(pvx: PArrayE; pnx: Pinteger;  pzx: PComplexE;  pvd: PArrayD; pnd: PInteger; pd: Pdouble; pzd: PComplexD; px: PExtended;  pvi: PArrayI; pni: PInteger); cdecl;
InitFuncStruct(FS);
FS.Arg:=10;
SetLength(VT,FS.Arg);
VT[0]:=fl_POINTER;{fl_ARRAY_REAL_EXTENDED};
VT[1]:=fl_POINTER;{fl_REAL_INTEGER; }
VT[2]:=fl_POINTER;{fl_COMPLEX_EXTENDED};
VT[3]:=fl_POINTER;{fl_ARRAY_REAL_DOUBLE};
VT[4]:=fl_POINTER;{fl_REAL_INTEGER;}
VT[5]:=fl_POINTER;{fl_REAL_DOUBLE;  }
VT[6]:=fl_POINTER;{fl_COMPLEX_DOUBLE;}
VT[7]:=fl_POINTER;{fl_REAL_EXTENDED};
VT[8]:=fl_POINTER;{fl_ARRAY_REAL_INTEGER};
VT[9]:=fl_POINTER;{fl_REAL_INTEGER};
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=3;
FS.ResultType:=fl_Complex;
FS.addr:=@spall_ptr;
flSetFunction('spall',@FS,@idfP); //Overload!       Also Work in  fl_USE_INTEGER_POINTER = fl_DISABLE

//spall(ve,vi[k+j],z5e,vd,vi[k+3],vd[2*k+3*j*k+1],z2d,z4e.im,vi,j)
//spall(@ve,@vi[k+j],@z5e,@vd,@vi[k+3],@vd[2*k+3*j*k+1],@z2d,@z4e.im,@vi,@j)


//spall(ve,vi[k+j],z5e,vd,vi[k+3],vd[2*k+3*j*k+1],z3d,ve[2*k*(j+1)],vi,j)
//spall(@ve,@vi[k+j],@z5e,@vd,@vi[k+3],@vd[2*k+3*j*k+1],@z3d,@ve[2*k*(j+1)],@vi,@j)




// *****************   Call Functions by Pointers  *******************************************

           //x,y,z1,z2, resf - must be global var.!


         // real external  func. : rfunc , pcrfunc
InitFuncStruct(FS);
FS.addr:=@_RFuncPtr;
FS.Arg:=0;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=4;
flSetFunction('rfunc',@FS,@idfP);

flSetFunction('pcrfunc():real = 2.5*x+1.7*y',0,@idfP1);


           // complex external  func. : zfunc, pczfunc
InitFuncStruct(FS);
FS.addr:=@_ZFuncPtr;
FS.Arg:=0;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=4;
flSetFunction('zfunc',@FS,@idfP);

flSetFunction('pczfunc():complex = 2.5*z1-1.7*z2',0,@idfP2);



              // complex "none" external  func. : nfunc, pcnfunc
InitFuncStruct(FS);
FS.addr:=@_NFuncPtr;
FS.Arg:=0;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_none;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=4;
flSetFunction('nfunc',@FS,@idfP);

flSetFunction('pcnfunc():none = res=2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i',0,@idfP3);   //res (resf) - global var.



                    //Calling Real   func.
// by value  vp
InitFuncStruct(FS);
FS.addr:=@_RSumCallPtrV;
FS.Arg:=1;
FS.ArgType:=fl_Array_Pointer;{fl_Array_Real_Integer;}
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=8;
flSetFunction('rcall',@FS,@idfP);
//rcall(vp1)
//rcall(vi1)


// by ref.  vp
InitFuncStruct(FS);
FS.addr:=@_RSumCallPtrVP;
FS.Arg:=1;
FS.ArgType:=fl_Pointer;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=8;
flSetFunction('rcall',@FS,@idfP);
//rcall(@vp1)

flSetFunction('pcrcall(vp: array pointer):real = k:int=0; S:ext=0; for(k,0,Len(vp)-1,S=S+callr(vp[k])); S',0,@idfP);



                    //Calling Complex func.
// by value  vp
InitFuncStruct(FS);
FS.addr:=@_ZSumCallPtrV;
FS.Arg:=1;
FS.ArgType:=fl_Array_Pointer;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=8;
flSetFunction('zcall',@FS,@idfP);
//zcall(vp2)


// by ref.  vp
InitFuncStruct(FS);
FS.addr:=@_ZSumCallPtrVP;
FS.Arg:=1;
FS.ArgType:=fl_Pointer;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=8;
flSetFunction('zcall',@FS,@idfP);
//zcall(@vp2)

flSetFunction('pczcall(vp: array pointer):complex = k:int=0; S:CXext=0+0i; for(k,0,Len(vp)-1,S=S+callc(vp[k])); S',0,@idfP);





                    //Calling Complex "none" func.
// by value  vp
InitFuncStruct(FS);
FS.addr:=@_ZNSumCallPtrV;
FS.Arg:=1;
FS.ArgType:=fl_Array_Pointer;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_none;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=8;
flSetFunction('ncall',@FS,@idfP);
//ncall(vp3)


// by ref.  vp
InitFuncStruct(FS);
FS.addr:=@_ZNSumCallPtrVP;
FS.Arg:=1;
FS.ArgType:=fl_Pointer;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_none;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=8;
flSetFunction('ncall',@FS,@idfP);
//ncall(@vp3)

flSetFunction('pcncall(vp: array pointer):none = k:int=0; S:CXext=0+0i; for(k,0,Len(vp)-1, call(vp[k]); S=S+Res); Res=S',0,@idfP);






flGetFunctionAddr(@idfP1,Ptr1);
flGetFunctionAddr(@idfP2,Ptr2);
flGetFunctionAddr(@idfP3,Ptr3);

//real
SetLength(vp1,2);   SetLength(vpf1,2);
vp1[0]:=@_RFuncPtr;  vp1[1]:=Ptr1;
vpf1[0]:=@_RFuncPtr; vpf1[1]:=Ptr1;

//complex
SetLength(vp2,2);   SetLength(vpf2,2);
vp2[0]:=@_ZFuncPtr;  vp2[1]:=Ptr2;
vpf2[0]:=@_ZFuncPtr; vpf2[1]:=Ptr2;


//complex "none"
SetLength(vp3,2);   SetLength(vpf3,2);
vp3[0]:=@_NFuncPtr;  vp3[1]:=Ptr3;
vpf3[0]:=@_NFuncPtr; vpf3[1]:=Ptr3;

  Res:=_RSumCallPtrV(vp1);
  Res:=_RSumCallPtrVP(@vp1);
  //_ZSumCallPtrV(vp2);
  //_ZSumCallPtrVP(@vp2);

  //goto endp;

{
  1. real                                                = 6
  (rcall(vp1)+rcall(@vp1)+pcrcall(vp1))/( 2.5*x+1.7*y )

  2. complex                                             = 6
  (zcall(vp2)+zcall(@vp2)+pczcall(vp2))/( 2.5*z1-1.7*z2 )

                                                         =6+0i
  3. complex "none".
  S:CXext=0; ncall(vp3); S=S+result; ncall(@vp3); S=S+result; pcncall(vp3); S=S+result; S/(2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i)


  4. common         =1+0i
  L1:int=len(vp1); L2:int=Len(vp2);L3:int=Len(vp3); n:int=0; SC: CXext=0+0i;
  for(n,0,L1-1, SC=SC+callr(vp1[n]));
  for(n,0,L2-1, SC=SC+callc(vp2[n]));
  for(n,0,L3-1, call(vp3[n]); SC=SC+Result);
  SC/(2*( 2.5*x+1.7*y ) + 2*( 2.5*z1-1.7*z2 ) + 2*(2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i))

  5.
  x=2; y=3; z1=2+2i; z2=3+3i;
  L1:int=len(vp1); L2:int=Len(vp2);L3:int=Len(vp3); n:int=0; SC: CXext=0+0i;
  for(k,1,10, x=x/k; y=y/k; for(n,0,L1-1, SC=SC+callr(vp1[n])));
  for(k,1,10, z1=z1/k; z2=z2/k; z3=z3/k; for(n,0,L2-1, SC=SC+callc(vp2[n])));
  for(k,1,10, x=x/k; y=y/k; z1=z1/k; z2=z2/k; z3=z3/k; for(n,0,L3-1, call(vp3[n]); SC=SC+Result));

  SC1: CXext=0+0i;

  for(k,1,10, x=x/k; y=y/k; z1=z1/k; z2=z2/k; z3=z3/k; for(n,0,L3-1, call(vp3[n]); SC=SC+Result));


  6. common with change vars.        = 2+0i
  L1:int=len(vp1); L2:int=Len(vp2);L3:int=Len(vp3); n:int=0;  k:int=0; CNT: int=10;

  x=2; y=3; z1=2-3i; z2=3-5i; SC: CXext=0+0i;
  for(k,1,CNT, x=x/k; y=y/k;  z1=z1/k; z2=z2/k;  for(n,0,L1-1, SC=SC+callr(vp1[n])); for(n,0,L2-1, SC=SC+callc(vp2[n])); for(n,0,L3-1, call(vp3[n]); SC=SC+Result));

  x=2; y=3; z1=2-3i; z2=3-5i; SC1: CXext=0+0i;
  for(k,1,CNT, x=x/k; y=y/k;  z1=z1/k; z2=z2/k;   SC1=SC1+(( 2.5*x+1.7*y ) + ( 2.5*z1-1.7*z2 ) + (2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i)));

  SC/SC1
}







///////////////////////////////////////////////////////////////////////////////

            // *****************************************************//
////////////////////////////////////////////////////////////////////////////////



InitFuncStruct(FS);
FS.addr:=@_Func1XE;
FS.Arg:=0;
FS.ArgType:=fl_None;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('Func1XE',@FS,@idfP);
flSetFunction('pcFunc1XE() = sqrt(x)',0,@idFP);

//Ptr1=@pcFunc1XE; Error:int=0;  x=9; res1:ext=CallRMaskFpu(Ptr1,@Error); res1
//Ptr1=@pcFunc1XE; Error:int=0;  x=-9; res1:ext=CallRMaskFpu(Ptr1,@Error); Error
//Ptr1=@pcFunc1XE; Error:int=0;  x=9; res1:ext=CallRSafe(Ptr1,@Error); res1
//Ptr1=@pcFunc1XE; Error:int=0;  x=-9; res1:ext=CallRSafe(Ptr1,@Error); Error
//Ptr1=@Func1XE; Error:int=0;  x=9; res1:ext=CallRMaskFpu(Ptr1,@Error); res1
//Ptr1=@Func1XE; Error:int=0;  x=-9; res1:ext=CallRMaskFpu(Ptr1,@Error); Error
//Ptr1=@Func1XE; Error:int=0;  x=9; res1:ext=CallRSafe(Ptr1,@Error); res1
//Ptr1=@Func1XE; Error:int=0;  x=-9; res1:ext=CallRSafe(Ptr1,@Error); Error


InitFuncStruct(FS);
FS.addr:=@_Proc1XE;
FS.Arg:=0;
FS.ArgType:=fl_None;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_None;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('Proc1XE',@FS,@idfP);
flSetFunction('pcProc1XE():none = res.re=sqrt(x)',0,@idFP);

//Ptr1=@pcProc1XE; Error:int=0;  x=9; CallMaskFpu(Ptr1,@Error); res
//Ptr1=@pcProc1XE; Error:int=0;  x=-9; CallMaskFpu(Ptr1,@Error); Error
//Ptr1=@pcProc1XE; Error:int=0;  x=9; CallSafe(Ptr1,@Error); res
//Ptr1=@pcProc1XE; Error:int=0;  x=-9; CallSafe(Ptr1,@Error); Error
//Ptr1=@Proc1XE; Error:int=0;  x=9; CallMaskFpu(Ptr1,@Error); res
//Ptr1=@Proc1XE; Error:int=0;  x=-9; CallMaskFpu(Ptr1,@Error); Error
//Ptr1=@Proc1XE; Error:int=0;  x=9; CallSafe(Ptr1,@Error); res
//Ptr1=@Proc1XE; Error:int=0;  x=-9; CallSafe(Ptr1,@Error); Error



InitFuncStruct(FS);
FS.addr:=@_Func1ZE;
FS.Arg:=0;
FS.ArgType:=fl_None;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_Complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('Func1ZE',@FS,@idfP);
flSetFunction('pcFunc1ZE():complex = sqrt(z1.re)+i*sqrt(z1.im)',0,@idFP);

//Ptr1=@pcFunc1ZE; Error:int=0;  z1=25+9i; res1:CXext=CallCMaskFpu(Ptr1,@Error); res1
//Ptr1=@pcFunc1ZE; Error:int=0;  z1=25-9i; res1:CXext=CallCMaskFpu(Ptr1,@Error); Error
//Ptr1=@pcFunc1ZE; Error:int=0;  z1=25+9i; res1:CXext=CallCSafe(Ptr1,@Error); res1
//Ptr1=@pcFunc1ZE; Error:int=0;  z1=25-9i; res1:CXext=CallCSafe(Ptr1,@Error); Error
//Ptr1=@Func1ZE; Error:int=0;  z1=25+9i; res1:CXext=CallCMaskFpu(Ptr1,@Error); res1
//Ptr1=@Func1ZE; Error:int=0;  z1=25-9i; res1:CXext=CallCMaskFpu(Ptr1,@Error); Error
//Ptr1=@Func1ZE; Error:int=0;  z1=25+9i; res1:CXext=CallCSafe(Ptr1,@Error); res1
//Ptr1=@Func1ZE; Error:int=0;  z1=25-9i; res1:CXext=CallCSafe(Ptr1,@Error); Error



InitFuncStruct(FS);
FS.addr:=@_Proc1ZE;
FS.Arg:=0;
FS.ArgType:=fl_None;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_None;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('Proc1ZE',@FS,@idfP);
flSetFunction('pcProc1ZE():none =  res = sqrt(z1.re)+i*sqrt(z1.im) ',0,@idFP);

//Ptr1=@pcProc1ZE; Error:int=0;  z1=25+9i; CallMaskFpu(Ptr1,@Error); res
//Ptr1=@pcProc1ZE; Error:int=0;  z1=25-9i; CallMaskFpu(Ptr1,@Error); Error
//Ptr1=@pcProc1ZE; Error:int=0;  z1=25+9i; CallSafe(Ptr1,@Error); res
//Ptr1=@pcProc1ZE; Error:int=0;  z1=25-9i; CallSafe(Ptr1,@Error); Error
//Ptr1=@Proc1ZE; Error:int=0;  z1=25+9i; CallMaskFpu(Ptr1,@Error); res
//Ptr1=@Proc1ZE; Error:int=0;  z1=25-9i; CallMaskFpu(Ptr1,@Error); Error
//Ptr1=@Proc1ZE; Error:int=0;  z1=25+9i; CallSafe(Ptr1,@Error); res
//Ptr1=@Proc1ZE; Error:int=0;  z1=25-9i; CallSafe(Ptr1,@Error); Error







//incv(pv: PFloat; val: Float); stdcall;
//incv(@var, val)  ;  var=var+val;
InitFuncStruct(FS);
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_POINTER;
VT[1]:=c_RealFloat;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
FS.addr:=@incf;
flSetFunction('incv',@FS,@idfP);
VT[1]:=c_ComplexFloat;
FS.addr:=@incz;
flSetFunction('incv',@FS,@idfP);

//x=10;y=20;  incv(@x,y+100); x
//z1=1+2i; y=20;  incv(@z1,y+10); z1
//z1=1+2i; z2=5+6i;  incv(@z1,z2+10+20i); z1
//z1=1+2i;  incv(@z1,20i); z1





{FillArray(vec, x) =  Vec[all]=x}
InitFuncStruct(FS);
FS.addr:=@spFillArray;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=c_ArrayType;  VT[1]:=c_RealFloat;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_None;
flSetFunction('FillArray',@FS,@idfP);


{
flGetFuncID('sqrt',IDF);
flSet(fl_DISABLE_FUNCTION,IDF);
InitFuncStruct(FS);
FS.addr:=@_SqrtR;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sqrt',@FS);

InitFuncStruct(FS);
FS.addr:=@_SqrtCx;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('sqrt',@FS);
}

//fl_PreCompiled


InitFuncStruct(FS);
FS.ArgType:=c_RealFloat;//fl_real_double;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc1(x)=x^2',@FS,@idfP);
flSetDiffTemplate(@idfP,'2*$arg1*$dfarg1');


InitFuncStruct(FS);
FS.ArgType:=c_ComplexFloat;//fl_complex_double;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc1(z)=z^2',@FS,@idfP);

InitFuncStruct(FS);
FS.ArgType:=c_RealFloat;//fl_real_double;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc2(x,y)=x-y',@FS,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1-$dfarg2');


InitFuncStruct(FS);
FS.ArgType:=c_ComplexFloat;//fl_complex_double;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc2(z1,z2)=z1-z2',@FS,@idfP);

InitFuncStruct(FS);
FS.ArgType:=fl_differ;
SetLength(VT,2);
VT[0]:=c_ComplexFloat;//fl_complex_Double;
VT[1]:=c_RealFloat;//fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc2(z1,x)=z1-x',@FS,@idfP);


InitFuncStruct(FS);
FS.ArgType:=fl_differ;
SetLength(VT,2);
VT[0]:=c_RealFloat;//fl_real_double;
VT[1]:=c_ComplexFloat;//fl_complex_Double;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc2(x,z1)=x-z1',@FS,@idfP);


InitFuncStruct(FS);
FS.ArgType:=c_RealFloat;//fl_real_double;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc3(x,y,t)=x+y-t',@FS,@idfP);
FS.IsInline:=fl_YES;
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3');


InitFuncStruct(FS);
FS.ArgType:=c_ComplexFloat;//fl_complex_double;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc3(z1,z2,z3)=z1+z2-z3',@FS,@idfP);


InitFuncStruct(FS);
FS.ArgType:=fl_differ;
SetLength(VT,3);
VT[0]:=c_ComplexFloat;//fl_complex_Double;
VT[1]:=c_ComplexFloat;//fl_complex_double;
VT[2]:=c_RealFloat;//fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_PRECOMPILED;
FS.IsInline:=fl_YES;
flSetFunction('pc3(z1,z2,x)=z1+z2-x',@FS,@idfP);




flSetFunction('pc4(x1:ext; x2: dbl; x3:ext; x4:dbl):real=x1+x2-x3*x4',0,@idfP);
flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2-$dfarg3*$arg4-$dfarg4*$arg3');
flSetFunction('pc4(z1:CXext; z2: CXdbl; z3:CXext; z4:CXdbl):complex=z1+z2-z3*z4',0,@idfP);



InitFuncStruct(FS);
FS.ResultType:=fl_real;
SetLength(VT,2);
VT[0]:=fl_array_real_double; VT[1]:=fl_real_integer;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_PRECOMPILED;
flSetFunction('pc2(AD,n)=AD[n]*x',@FS,@idfP);



InitFuncStruct(FS);
FS.ArgType:=fl_differ;
FS.ResultType:=fl_complex;
SetLength(VT,4);
VT[0]:=fl_complex_extended; VT[1]:=fl_real_integer; VT[2]:=fl_array_real_double; VT[3]:=fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_PRECOMPILED;
flSetFunction('pc4(z1,n,ad,x)=z1+ad[n]+x',@FS,@idfP);


//pc5(vd,y,ve,k,x)
InitFuncStruct(FS);
FS.ResultType:=fl_real;
SetLength(VT,5);
VT[0]:=fl_array_real_double; VT[1]:=fl_real_double; VT[2]:=fl_array_real_extended; VT[3]:=fl_real_integer; VT[4]:=fl_real_extended;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_PRECOMPILED;
flSetFunction('pc5(vd,d,ve,k,x)=vd[k]+ve[k]+d+x',@FS,@idfP);


InitFuncStruct(FS);
FS.ArgType:=fl_complex_double;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_PRECOMPILED;
flSetFunction('ifz2(z1,z2)=if(|z1|<|z2|,z1^2,if(|z1|=|z2|,z1^3,z1^4))',@FS,@idfP);


flSetFunction('pc1x(x:ext):real=x^2',0,@idfP);
flSetFunction('pc2x(x,y:ext):real=x-y',0,@idfP);
flSetFunction('pc3x(x1,x2,x3:ext):real=x1+x2-x3',0,@idfP);
flSetFunction('pc1x(z:CXext):complex=z^2',0,@idfP);
flSetFunction('pc2x(x:ext;z:CXext):complex=x-z',0,@idfP);
flSetFunction('pc2x(z:CXext; x:ext):complex=z-x',0,@idfP);
flSetFunction('pc2x(z1,z2:CXext):complex=z1-z2',0,@idfP);
flSetFunction('pc3x(z1,z2,z3:CXext):complex=z1+z2-z3',0,@idfP);

flSetFunction('fr(x,y: double): real=x*y+x*y*(x*y+x*y*(x*y+x*y))',0,@idfP);


//sp0()  : real
{
InitFuncStruct(FS);
FS.addr:=@sp0;
FS.CallType:=fl_stdcall;
FS.Arg:=0;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp0',@FS,@idfP);
}

//sp0() :complex
{
InitFuncStruct(FS);
FS.addr:=@sp0z;
FS.CallType:=fl_stdcall;    //stdcall???
FS.Arg:=0;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp0',@FS,@idfP);
}

InitFuncStruct(FS);
FS.addr:=@sp0p;
FS.CallType:=fl_stdcall;
FS.Arg:=0;
FS.ResultType:=fl_none;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sp0',@FS,@idfP);


//ps0()
{InitFuncStruct(FS);
FS.addr:=@ps0;
FS.CallType:=fl_cdecl;            //cdecl???
FS.Arg:=0;
FS.ArgType:=fl_Real_Double;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps0',@FS);}

//ps0()
InitFuncStruct(FS);
FS.addr:=@ps0z;
FS.CallType:=fl_cdecl;            //cdecl???
FS.Arg:=0;
FS.ArgType:=fl_complex_Double;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
flSetFunction('ps0',@FS,@idfP);





//ps1idS(x)
InitFuncStruct(FS);
FS.addr:=@ps1idS;
FS.CallType:=fl_Stdcall;
FS.Arg:=1;
FS.ArgType:=fl_Real_Double;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps1idS0',@FS,@idfP);
FS.Id_Func:=1001;
flSetFunction('ps1idS1',@FS,@idfP);
FS.Id_Func:=1002;
flSetFunction('ps1idS2',@FS,@idfP);
// ps1idS0(x)+ps1idS1(x)+ps1idS2(x)


//ps1idC(x)
InitFuncStruct(FS);
FS.addr:=@ps1idC;
FS.CallType:=fl_Cdecl;
FS.Arg:=1;
FS.ArgType:=fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps1idC',@FS,@idfP);


//ps1idP(x)
InitFuncStruct(FS);
FS.addr:=@ps1idP;
FS.CallType:=fl_Pascal;
FS.Arg:=1;
FS.ArgType:=fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps1idP',@FS,@idfP);



//ps0idS()
InitFuncStruct(FS);
FS.addr:=@ps0idS;
FS.CallType:=fl_Stdcall;
FS.Arg:=0;
FS.ArgType:=fl_Real_Double;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps0idS',@FS,@idfP);



//ps0idC()
InitFuncStruct(FS);
FS.addr:=@ps0idC;
FS.CallType:=fl_Cdecl;
FS.Arg:=0;
FS.ArgType:=fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps0idC',@FS,@idfP);


//ps0idP()
InitFuncStruct(FS);
FS.addr:=@ps0idP;
FS.CallType:=fl_Pascal;
FS.Arg:=0;
FS.ArgType:=fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps0idP',@FS,@idfP);



// ps4idS(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@ps4idS;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps4idS',@FS,@idfP);



// ps4idC(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@ps4idC;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps4idC',@FS,@idfP);




// ps4idP(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@ps4idP;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_ADDRS;
FS.CallType:=fl_pascal;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ps4idP',@FS,@idfP);


//sp1idS(x)
InitFuncStruct(FS);
FS.addr:=@sp1idS;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp1idS',@FS,@idfP);



//sp1idC(x)
InitFuncStruct(FS);
FS.addr:=@sp1idC;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp1idC',@FS,@idfP);


//sp1idP(x)
InitFuncStruct(FS);
FS.addr:=@sp1idP;
FS.CallType:=fl_pascal;
FS.Arg:=1;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp1idP',@FS,@idfP);




// sp4idS(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@sp4idS;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp4idS',@FS,@idfP);




// sp4idC(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@sp4idC;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp4idC',@FS,@idfP);




 //дл€ "pascal" не работает, т.к. передаетс€ адрес, а не числа
// sp4idP(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@sp4idP;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_pascal;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp4idP',@FS,@idfP);



//sp0idS()
InitFuncStruct(FS);
FS.addr:=@sp0idS;
FS.CallType:=fl_Stdcall;
FS.Arg:=0;
FS.ArgType:=fl_Real_Double;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp0idS',@FS,@idfP);



//sp0idC()
InitFuncStruct(FS);
FS.addr:=@sp0idC;
FS.CallType:=fl_cdecl;
FS.Arg:=0;
FS.ArgType:=fl_Real_Double;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp0idC',@FS,@idfP);



//sp0idP()
InitFuncStruct(FS);
FS.addr:=@sp0idP;
FS.CallType:=fl_pascal;
FS.Arg:=0;
FS.ArgType:=fl_Real_Double;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('sp0idP',@FS,@idfP);


//ms1idC(x)
InitFuncStruct(FS);
FS.addr:=@MS1idC;
FS.ArgType:=fl_Real_double;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ms1idC',@FS,@idfP);



//ms1idS(x)
InitFuncStruct(FS);
FS.addr:=@MS1idS;
FS.ArgType:=fl_Real_double;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ms1idS',@FS,@idfP);


//ms0idC()
InitFuncStruct(FS);
FS.addr:=@MS0idC;
FS.ArgType:=fl_Real_double;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ms0idC',@FS,@idfP);



//ms0idS()
InitFuncStruct(FS);
FS.addr:=@MS0idS;
FS.ArgType:=fl_Real_double;
FS.Arg:=0;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_Real;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ms0idS',@FS,@idfP);




// ms4idC(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@ms4idC;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_cdecl;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ms4idC',@FS,@idfP);





// ms4idS(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@ms4idS;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ms4idS',@FS,@idfP);




// ms4idP(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@ms4idP;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_pascal;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ms4idP',@FS,@idfP);



//ma1idS(x)
InitFuncStruct(FS);
FS.addr:=@MA1idS;
FS.ArgType:=fl_Real_double;
FS.Arg:=1;
FS.CallFunc:=fl_VARS_LIST_ADDR_EAX;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_Real;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ma1idS',@FS,@idfP);



// ma4idP(z1,x,vd,n,z2)
InitFuncStruct(FS);
FS.addr:=@ma4idP;
SetLength(VT,5);
VT[0]:=fl_Complex_Extended;   VT[1]:=fl_real_double;
VT[2]:=fl_array_real_Double;  VT[3]:=fl_real_integer;
VT[4]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=5;
FS.CallFunc:=fl_VARS_LIST_ADDR_EAX;
FS.CallType:=fl_pascal;
FS.DeepFPU:=2;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
flSetFunction('ma4idP',@FS,@idfP);



//***************OUTF******************




//

InitFuncStruct(FS);
FS.addr:=@PrintR;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('PrintW1',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@PrintR;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('PrintW2',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintC;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('PrintW1',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintC;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_complex_extended;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('PrintW2',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintVE;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_extended;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('PrintW1',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@PrintVE;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_extended;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('PrintW2',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintVD;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_double;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('PrintW1',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@PrintVD;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_double;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('PrintW2',@FS,@idfP);





InitFuncStruct(FS);
FS.addr:=@PrintVI;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('PrintW1',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@PrintVI;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('PrintW2',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@PrintVS;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_single;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=1;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('PrintW2',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@PrintSpace;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('SpaceW1',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintSpace;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('SpaceW2',@FS,@idfP);





InitFuncStruct(FS);
FS.addr:=@PrintSpace;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('SpaceW1',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintSpace;
FS.Arg:=1;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('SpaceW2',@FS,@idfP);





InitFuncStruct(FS);
FS.addr:=@PrintLine;
FS.Arg:=0;
//SetLength(VT,FS.Arg);
//VT[0]:=fl_real_integer;
//FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('LineW1',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintLine;
FS.Arg:=0;
//SetLength(VT,FS.Arg);
//VT[0]:=fl_real_integer;
//FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('LineW2',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintAsterisk;
FS.Arg:=0;
//SetLength(VT,FS.Arg);
//VT[0]:=fl_real_integer;
//FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1;
flSetFunction('AsteriskW1',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@PrintAsterisk;
FS.Arg:=0;
//SetLength(VT,FS.Arg);
//VT[0]:=fl_real_integer;
//FS.ArgTypeList:=@VT[0];
FS.CallFunc:=fl_VARS_VALUES;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=0;
FS.ResultType:=fl_None;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=2;
flSetFunction('AsteriskW2',@FS,@idfP);


//**********************


 (*
//fl_INFINITE_ID
//InfZidS(z1,z2,z3,z3-z2,z2-z1,z1*z2)
InitFuncStruct(FS);
FS.addr:=@InfZidS;
FS.ArgType:=fl_Complex_Extended;
FS.CallFunc:=fl_INFINITE;
FS.CallType:=fl_cdecl;//fl_pascal;//fl_stdcall;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
FS.DeepFPU:=2;
flSetFunction('InfZidS',@FS,@idfP);


//InfRidS(x,y,t,x-t,y-x,t*y)
InitFuncStruct(FS);
FS.addr:=@InfRidS;
FS.ArgType:=fl_real_Extended;
FS.CallFunc:=fl_INFINITE;
FS.CallType:={fl_cdecl;}{fl_pascal;}fl_stdcall;
FS.ResultType:=fl_real;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
FS.DeepFPU:=2;
flSetFunction('InfRidS',@FS,@idfP);
*)





//fl_INFINITE_ID
//Infid(z1,z2,z3,z3-z2,z2-z1,z1*z2)
InitFuncStruct(FS);
FS.addr:=@InfZid;
FS.ArgType:=fl_Complex_Extended;
FS.CallFunc:=fl_INFINITE;
FS.CallType:={fl_cdecl;}{fl_pascal;}fl_stdcall;
FS.ResultType:=fl_Complex;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
FS.DeepFPU:=2;
flSetFunction('Infid',@FS,@idfP);


//Infid(x,y,t,x-t,y-x,t*y)
InitFuncStruct(FS);
FS.addr:=@InfRid;
FS.ArgType:=fl_real_Extended;
FS.CallFunc:=fl_INFINITE;
FS.CallType:={fl_cdecl;}{fl_pascal;}fl_stdcall;
FS.ResultType:=fl_real;
FS.Set_ID:=fl_Enable;
FS.Id_Func:=1000;
FS.DeepFPU:=2;
flSetFunction('Infid',@FS,@idfP);


//spt1(x)
InitFuncStruct(FS);
FS.addr:=@spt1;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:=fl_real_double;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('spt1',@FS,@idfP);



//spt1z(z1)
InitFuncStruct(FS);
FS.addr:=@spt1z;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('spt1',@FS,@idfP);



//spt2(vd,n)
InitFuncStruct(FS);
FS.addr:=@spt2;
SetLength(VT,2);
VT[0]:=fl_array_real_Double;     VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:=fl_stdcall;
FS.Arg:=2;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spt2',@FS,@idfP);


//spt5(vd,n,x,ve,k,y)
InitFuncStruct(FS);
FS.addr:=@spt5;
SetLength(VT,6);
VT[0]:=fl_array_real_Double;     VT[1]:=fl_real_integer;
VT[2]:=fl_real_Extended;         VT[3]:=fl_array_real_Extended;
VT[4]:=fl_real_integer;          VT[5]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:={fl_cdecl;}fl_stdcall;
FS.Arg:=6;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spt5',@FS,@idfP);




//spt3(z1,z2,z3)
InitFuncStruct(FS);
FS.addr:=@spt3z;
FS.CallType:=fl_cdecl;
FS.Arg:=3;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spt3',@FS,@idfP);


//spt4(x,n,y,t)
InitFuncStruct(FS);
FS.addr:=@spt4;
SetLength(VT,4);
VT[0]:=fl_real_Extended;     VT[1]:=fl_real_integer;
VT[2]:=fl_real_Extended;     VT[3]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:=fl_stdcall;
FS.Arg:=4;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spt4',@FS,@idfP);



//spt4(z1,n,z2,x)
InitFuncStruct(FS);
FS.addr:=@spt4z;
SetLength(VT,4);
VT[0]:=fl_complex_Extended;     VT[1]:=fl_real_integer;
VT[2]:=fl_complex_double;       VT[3]:=fl_real_extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:={fl_cdecl;}fl_stdcall;
FS.Arg:=4;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spt4',@FS,@idfP);



//spt3(x)
InitFuncStruct(FS);
FS.addr:=@spt3;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_real_double;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('spt3',@FS,@idfP);


//real:
//mst(vd,n,x)
InitFuncStruct(FS);
FS.addr:=@MSt;
SetLength(VT,3);
VT[0]:=fl_array_real_Double; VT[1]:=fl_real_integer;  VT[2]:=fl_real_Extended;
// VT[4]:=fl_real_extended;  VT[5]:=fl_real_integer;  VT[1]:=fl_real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.Arg:=3;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.CallType:=fl_stdcall;
FS.DeepFPU:=2;
FS.ResultType:=fl_Real;
flSetFunction('mst',@FS,@idfP);



//spt6(z1,n,x,z2,k,y)
InitFuncStruct(FS);
FS.addr:=@spt6;
SetLength(VT,6);
VT[0]:=fl_Complex_Extended;  VT[1]:=fl_real_integer;  VT[2]:=fl_Real_Extended;
VT[3]:=fl_Complex_Double;    VT[4]:=fl_real_integer;  VT[5]:=fl_Real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:={fl_cdecl;}fl_stdcall;
FS.Arg:=6;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spt6',@FS,@idfP);



//pst6(z1,n,x,z2,k,y)
InitFuncStruct(FS);
FS.addr:=@pst6;
SetLength(VT,6);
VT[0]:=fl_Complex_Extended;  VT[1]:=fl_real_integer;  VT[2]:=fl_Real_Extended;
VT[3]:=fl_Complex_Double;    VT[4]:=fl_real_integer;  VT[5]:=fl_Real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:={fl_cdecl;}fl_stdcall;
FS.Arg:=6;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('pst6',@FS,@idfP);


//mst6(z1,n,x,z2,k,y)
InitFuncStruct(FS);
FS.addr:=@mst6;
SetLength(VT,6);
VT[0]:=fl_Complex_Extended;  VT[1]:=fl_real_integer;  VT[2]:=fl_Real_Extended;
VT[3]:=fl_Complex_Double;    VT[4]:=fl_real_integer;  VT[5]:=fl_Real_double;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:={fl_cdecl;}fl_stdcall;
FS.Arg:=6;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_LIST_ADDR_ESP;
FS.DeepFPU:=2;
flSetFunction('mst6',@FS,@idfP);


flSetFunction('pct6(z1: ComplexExt; n2: int; x3: ext; z4: ComplexDbl; k5: int; y6: dbl):complex= complex(z1.re*n2+z4.re*k5-x3*y6,z1.im+z4.im)',0,@idfP);




  //fbig(x+y)-fbig(y+x)+fsmall(y)-fsmall(x)
InitFuncStruct(FS);
FS.addr:=@fbig;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:= c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=5;
flSetFunction('fbig',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@fsmall;
FS.CallType:=fl_stdcall;
FS.Arg:=1;
FS.ArgType:= c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=8;
flSetFunction('fsmall',@FS,@idfP);




InitFuncStruct(FS);
FS.addr:=@iadd2;
FS.CallType:=fl_stdcall;
FS.Arg:=2;
FS.ArgType:= fl_real_integer;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('iadd2',@FS,@idfP);

flSetFunction('ifunc2(a,b:int)=a+b',0,@idfP);



//spvs(vs,n*k+10)
InitFuncStruct(FS);
FS.addr:=@spvs;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_array_real_Single;
VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spvs',@FS,@idfP);

//pcvs(vs,n*k+10)
flSetFunction('pcvs(vs1: ArraySng; n: int):real=len(vs1)*vs1[n]',0,@idfP);



//s1: single=10; zs1: complexsng=20+30i; spsrcx(s1,zs1)
//spsrcx(x1s,z1s)
InitFuncStruct(FS);
FS.addr:=@SPSRCX;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_real_Single;
VT[1]:=fl_Complex_Single;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.CallType:=fl_stdcall;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('spsrcx',@FS,@idfP);

//pcsrcx(x1s,z1s)
//xs1:sng=10; zs1:complexsng=20+30i;  pcsrcx(xs1,zs1)
flSetFunction('pcsrcx(s1: sng; zs: complexsng):complex=s1*zs',0,@idfP);

       

// ************************************************************************//

  {
// PByte(Addr) -> Val: Read byte(Val) on Addr
InitFuncStruct(FS);
FS.addr:=@R_PByte;
FS.CallType:=fl_cdecl;//fl_stdcall;
FS.Arg:=1;
FS.ArgType:=fl_Pointer;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('PByte',@FS,@idfP);

// PByte(Addr,Val); : Write byte(Val) on Addr
InitFuncStruct(FS);
FS.addr:=@W_PByte;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Pointer;
VT[1]:=fl_real_integer;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_None;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=0;
flSetFunction('PByte',@FS,@idfP);

  }




//*************************************************************************//



// ***************************************************************************






//flSet(fl_Enable,fl_PRELIM_SYNT_ERROR,0);


{
flGetOperation('_', @OpData);
flSet(fl_DISABLE,fl_OPERATOR,OpData.IdOp);
}

//flSet(fl_Disable, fl_CURLY_BRACKET_TO_FRAC,0);
//flSet(fl_Disable, fl_SQUARE_BRACKET_TO_TRUNC,0);
{
flSet(fl_Disable, fl_PIPE_BRACKET_TO_ABS,0);
flSet(fl_Disable, fl_SQUARE_BRACKET_TO_TRUNC,0);
flSet(fl_Disable, fl_CURLY_BRACKET_TO_FRAC,0);
flSet(fl_Disable, fl_REPLACE_FUNC_IN_PART,0);
flSet(fl_Disable, fl_EXT_NAME_FUNC,0);
flSet(fl_Disable, fl_SUBST_NUMCX,0);
flSet(fl_Disable, fl_SYNTAX_OPERATORS,0);
  }

  {
fl_PIPE_BRACKET_TO_ABS
fl_SQUARE_BRACKET_TO_TRUNC
fl_CURLY_BRACKET_TO_FRACK
fl_REPLACE_FUNC_IN_PART
fl_EXT_NAME_FUNC
fl_SUBST_NUMCX                 numi   num*i
fl_PRELIM_SYNT_ERROR
fl_SYNTAX_OPERATORS   ! !! ^ _  .re  .im
  }


//goto endp;

//****************************** OVERLOAD OPERATIONS  *************************************** //

{

 Ќедокументированные возможности с перегрузкой  и определением новых операций. –аботают, но не доделано.
 Undocumented features with overloading and defining new operations. Working, but not finished.
}




  (*

flSet(fl_Disable,fl_PRELIM_SYNT_ERROR,0);  // if used multisymbols operations, espessialy with identical symbols, this mode need turn off

InitFuncStruct(FS);
FS.addr:=@opr2;          //arg+2
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('_opr2',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=20;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BEFORE;
flSetOperation('~~',@OpData);
  //x=5; ~~x
  //x=5; y= 10; ~~(x+y)

InitFuncStruct(FS);
FS.addr:=@opr1;           //arg+1
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('_opr1',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=20;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BEFORE;
flSetOperation('~',@OpData);
    //x=5; ~x



InitFuncStruct(FS);
FS.addr:=@opr3;             //arg+3
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('_opr3',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=20;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BEFORE;
flSetOperation('~~~',@OpData);
    //x=5; ~~~x




InitFuncStruct(FS);
FS.addr:=@oprm2;           //arg*2
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('_oprm2',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=30;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_AFTER;
flSetOperation('~~',@OpData);
      //x=5; x~~



InitFuncStruct(FS);
FS.addr:=@oprm1;          //arg
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('_oprm1',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=30;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_AFTER;
flSetOperation('~',@OpData);





InitFuncStruct(FS);
FS.addr:=@oprm3;        //arg*3
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('_oprm3',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=30;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_AFTER;
flSetOperation('~~~',@OpData);

//x=5; x~~~

//  x=5; ~~~x~~~



flSetFunction('_opr2bx1(x,y:ext)=x*y',0,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=2;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
flSetOperation('~',@OpData);
  //x=5; y=7; x~y

  {.383+ ; work only}
flSetFunction('_opr2bx2(x,y:ext)=2*x*y',0,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=2;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
flSetOperation('~~',@OpData);

 {.383+ ; work only}
flSetFunction('_opr2bx3(x,y:ext)=3*x*y',0,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=2;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
flSetOperation('~~~',@OpData);

*)

//x=5; y=7; x~~y

// x=5; y=7; (x+2)*(y*2)*2
// x=5; y=7; ~~x~~y~~

// x=5; y=7; (x+3)*(y*2)*3
// x=5; y=7; ~~~x~~~y~~


// x=5; y=7; (x+3)*(y*3)*3
// x=5; y=7; ~~~x~~~y~~~




 {
InitFuncStruct(FS);
FS.addr:=@proc;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('proc',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=1;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BETWEEN;
flSetOperation('%',@OpData);         //x%y




InitFuncStruct(FS);
FS.addr:=@__power;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=c_RealFloat;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('__pwr',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=3;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BETWEEN;
flSetOperation('***',@OpData);      //x^y




InitFuncStruct(FS);
FS.addr:=@cnj;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_Complex_Extended;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('cnj',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=2;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BEFORE;
flSetOperation('cnj_',@OpData);      //conj(arg)


//flGetOperation('_', @OpData);
//flPerform(fl_DISABLE_OPERATION,OpData.IdOp);





InitFuncStruct(FS);
FS.addr:=@InvR;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_Real_Extended;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('__inv',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@InvZ;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_Complex_Extended;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('__inv',@FS,@idfP);
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=2;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BEFORE;
flSetOperation('i_',@OpData);      //i_val=1/val

 }


//**********************OVERLOAD ARITHMETIC OPERATIONS********************************************************


 //*****************************************************************************


 {
  ѕерегрузка арифметических операций: + - * /     с такими же символами операций, но через другие (внешние) исполн€емые функции дл€ операций.
  ¬ключа€ задание шаблонов дифференцировани€ . ƒл€ действительных и комплексных чисел.

  Overloading of arithmetic operations: + - * / with the same operation symbols, but through other (external) executable functions for operations.
  Including specifying differentiation templates.  For real and complex numbers.
 }

(*

 //------------------ ADD Overload-------------------------------------
InitFuncStruct(FS);
FS.addr:=@AddRR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Add',@FS,@idfP);
// or more fast - precompiled inline:
//flSetFunction('{$IN+}__Add(x1,x2: extended):real=x1+x2',0,@idFP);




InitFuncStruct(FS);
FS.addr:=@AddZZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('__Add',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@AddRZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Real_Extended; VT[1]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Add',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@AddZR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Complex_Extended; VT[1]:=fl_Real_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Add',@FS,@idfP);

OpSymb:='+';
flGetOperation(OpSymb, @OpData);
flPerform(fl_DISABLE_OPERATION,OpData.IdOp);

OpData.idFunc:=idFP.idName;
//OpData.OpPrior:=1;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BETWEEN;
flSetOperation(OpSymb,@OpData);

flSetDiffTemplate(@idfP,'$dfarg1+$dfarg2');
//--------------------------------------------------------------




 //------------------ SUB Overload-------------------------------------
InitFuncStruct(FS);
FS.addr:=@SubRR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Sub',@FS,@idfP);
// or more fast - precompiled inline:
//flSetFunction('{$IN+}__Sub(x1,x2: extended):real=x1-x2',0,@idFP);



InitFuncStruct(FS);
FS.addr:=@SubZZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('__Sub',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@SubRZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Real_Extended; VT[1]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Sub',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@SubZR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Complex_Extended; VT[1]:=fl_Real_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Sub',@FS,@idfP);

OpSymb:='-';
flGetOperation(OpSymb, @OpData);
flPerform(fl_DISABLE_OPERATION,OpData.IdOp);

OpData.idFunc:=idFP.idName;
//OpData.OpPrior:=1;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BETWEEN;
flSetOperation(OpSymb,@OpData);

flSetDiffTemplate(@idfP,'$dfarg1-$dfarg2');

//--------------------------------------------------------------

//-------------------NEG OVERLOAD-------------------------------------------


InitFuncStruct(FS);
FS.addr:=@NegR;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('__Neg',@FS,@idfP);
// or more fast - precompiled inline:
//flSetFunction('{$IN+}__Neg(x1: extended):real=-x1',0,@idFP);




InitFuncStruct(FS);
FS.addr:=@NegZ;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Neg',@FS,@idfP);

OpSymb:='-';
OpData.idFunc:=idFP.idName;
OpData.OpPrior:=1;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BEFORE;
flSetOperation(OpSymb,@OpData);

flSetDiffTemplate(@idfP,'-$dfarg1');

 //--------------------------------------------------------------



 //------------------ MUL Overload-------------------------------------
InitFuncStruct(FS);
FS.addr:=@MulRR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Mul',@FS,@idfP);
// or more fast - precompiled inline:
//flSetFunction('{$IN+}__Mul(x1,x2: extended):real=x1*x2',0,@idFP);



InitFuncStruct(FS);
FS.addr:=@MulZZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=6;
flSetFunction('__Mul',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@MulRZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Real_Extended; VT[1]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('__Mul',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@MulZR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Complex_Extended; VT[1]:=fl_Real_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('__Mul',@FS,@idfP);

OpSymb:='*';
flGetOperation(OpSymb, @OpData);
flPerform(fl_DISABLE_OPERATION,OpData.IdOp);

OpData.idFunc:=idFP.idName;
//OpData.OpPrior:=2;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BETWEEN;
flSetOperation(OpSymb,@OpData);

flSetDiffTemplate(@idfP,'($dfarg1*$arg2+$arg1*$dfarg2)');


//--------------------------------------------------------------



 //------------------ DIV Overload-------------------------------------


InitFuncStruct(FS);
FS.addr:=@DivRR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=2;
flSetFunction('__Div',@FS,@idfP);
// or more fast - precompiled inline:
//flSetFunction('{$IN+}__Div(x1,x2: extended):real=x1/x2',0,@idFP);



InitFuncStruct(FS);
FS.addr:=@DivZZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
FS.ArgType:=fl_complex_extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=5;
flSetFunction('__Div',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@DivRZ;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Real_Extended; VT[1]:=fl_Complex_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=4;
flSetFunction('__Div',@FS,@idfP);



InitFuncStruct(FS);
FS.addr:=@DivZR;
FS.CallType:=fl_cdecl;
FS.Arg:=2;
SetLength(VT,FS.Arg);
VT[0]:=fl_Complex_Extended; VT[1]:=fl_Real_Extended;
FS.ArgTypeList:=@VT[0];
FS.ArgType:=fl_Differ;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('__Div',@FS,@idfP);

OpSymb:='/';
flGetOperation(OpSymb, @OpData);
flPerform(fl_DISABLE_OPERATION,OpData.IdOp);

OpData.idFunc:=idFP.idName;
//OpData.OpPrior:=2;
OpData.NArg:=FS.Arg;
OpData.Placement:=fl_BETWEEN;
flSetOperation(OpSymb,@OpData);

flSetDiffTemplate(@idfP,'($dfarg1*$arg2-$arg1*$dfarg2)/sqr($arg2)');




//-------------SQR Overload----------------------------


flGetFunctionIDFP('sqr',0,@idfP);
idFP.idArg := fl_ANY;
flChangeFunctionProperty(fl_DISABLE_FUNCTION,@idFP);



InitFuncStruct(FS);
FS.addr:=@_sqr_ovr_r;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_Real_Extended;//fl_real_double;   fl_real_extended;
FS.ResultType:=fl_real;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sqr',@FS,@idfP);


InitFuncStruct(FS);
FS.addr:=@_sqr_ovr_cx;
FS.CallType:=fl_cdecl;
FS.Arg:=1;
FS.ArgType:=fl_Complex_Extended;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=1;
flSetFunction('sqr',@FS,@idfP);

flSetDiffTemplate(@idfP,'2*$arg1*$dfarg1');

{
//-------------LN  Overload----------------------------


flSetFunction('ln_ovr(x: real): real=ln(x)',0,@idfP);
flSetFunction('ln_ovr(z: complex): complex = ln(z)',0,@idfP);


//Disable buil-in "ln"
flGetFuncIDN('ln',IDN);
idFP.idName :=  IDN; idFP.idArg := fl_ANY;
flChangeFunctionProperty(fl_DISABLE_FUNCTION,@idFP);

flSetDiffTemplate(@idfP,'$dfarg1/$arg1');

//-------------POWER  Overload--------------------------------------------------

flSetFunction('pwr_ovr(x,y: ext):real= x^y',0,@idfP);
flSetFunction('pwr_ovr(x: ext; z: CXext):complex= x^z',0,@idfP);
flSetFunction('pwr_ovr(z: CXext; x: ext):complex= z^x',0,@idfP);
flSetFunction('pwr_ovr(z1,z2: CXext):complex= z1^z2',0,@idfP);
flSetDiffTemplate(@idfP,'pwr_ovr($arg1,$arg2)*(($arg2)*($dfarg1)/($arg1)+($dfarg2)*ln(abs($arg1)))');   // только дл€ real!! дл€ complex - ln без abs !!

//Disable buil-in "power"
flGetFuncIDN('power',IDN);
idFP.idName :=  IDN; idFP.idArg := fl_ANY;
flChangeFunctionProperty(fl_DISABLE_FUNCTION,@idFP);
//Add new name to "pwr" : "power"
flGetFuncIDN('pwr_ovr',IDN);
flAddNameFunction(IDN,'power');
flAddNameFunction(IDN,'pow');


//Associate symbol operation "^" with "pwr_ovr"
idFP.idName:=IDN;
flChangeFunctionProperty(fl_SET_POWER_SYMBOL,@idFP);


//------------------------------------------------------------------------------
}
 *)

//********************** END OVERLOAD ARITHMETIC  OPERATIONS********************************************************



//goto endp;


{
sin(x/y)/cos(y/x)
krdiv(sin(krdiv(x,y)),cos(krdiv(y,x)))
krdiv(krsin(krdiv(x,y)),krcos(krdiv(y,x)))
}

{
 pow(-x/sin(-x/y),-y/cos(-y/x))
 krpow(-krdiv(x,krsin(-krdiv(x,y))),-krdiv(y,krcos(-krdiv(y,x))))
 pcpow(-pcdiv(x,pcsin(-pcdiv(x,y))),-pcdiv(y,pccos(-pcdiv(y,x))))
}

{
flSetFunction('pcdiv(x1,x2:ext)=x1/x2',0,ID);
flSetDiffTemplate(0,'diff(pcdiv) = $dfarg1/$arg2-$arg1*$dfarg2/sqr($arg2)');
}



//ps1(z1)
{InitFuncStruct(FS);
FS.addr:=@ps1z;
FS.CallType:=fl_CDecl;
FS.ArgType:=fl_complex_double;
FS.Arg:=1;
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=2;
flSetFunction('ps1',@FS);}


(*
InitFuncStruct(FS);
FS.addr:=@rand2;
FS.CallType:=fl_Stdcall;
FS.Arg:=2;
FS.ArgType:=fl_Real_Extended;
FS.ResultType:=fl_Real;
FS.CallFunc:=fl_VARS_ADDRS;
FS.DeepFPU:=8;
flSetFunction('rand',@FS);
*)
//x*y+x*y*(x*y+x*y*(x*y+x*y*(fr(x*y+x*y,x*y+x*y*(x*y+x*y)))))


//func6(x) = if(x >=  a,  if(x >= d, if(x >= e, x^5,x^4),x^3),x^2)

   // goto endp;

{FDFN:=TFuncPC.Create(Form1);
CompilePC;  }

{
SetLength(FData,4);
FData[0]:=2;
FData[1]:=fl_Real;
FData[2]:=fl_Real;
FData[3]:=fl_Real;
}

//flPerform(fl_Free,fl_VAR_LIST);


//sp3(z1,z2,x)
InitFuncStruct(FS);
SetLength(VT,3);
VT[0]:=fl_complex_extended; VT[1]:=fl_real_double; VT[2]:=fl_complex_double;
FS.addr:=@addzrz;
FS.CallType:=fl_stdcall;
FS.Arg:=3;
FS.ArgType:=fl_Differ;
FS.ArgTypeList:=@VT[0];
FS.ResultType:=fl_complex;
FS.CallFunc:=fl_VARS_VALUES;
FS.DeepFPU:=3;
flSetFunction('add',@FS,@idfP);




//***********************  Example: external functions with diff. templates  *************************

flSetFunction('pcdiv(x1,x2:ext) = x1/x2',0,@idfP);
//flSetDiffTemplate(@idfP,'pcdiv (($dfarg1*$arg2-$arg1*$dfarg2),sqr($arg2))');
flSetDiffTemplate(0,'diff(pcdiv) = pcdiv(($dfarg1*$arg2-$arg1*$dfarg2),sqr($arg2))');

flSetFunction('pcsin(x:ext) = sin(x)',0,@idfP);
//flSetDiffTemplate(@idfP,'pccos($arg1)*$dfarg1');
flSetDiffTemplate(0,'diff(pcsin) = pccos($arg1)*$dfarg1');


flSetFunction('pccos(x:ext) = cos(x)',0,@idfP);
//flSetDiffTemplate(@idfP,'- pcsin($arg1)*$dfarg1');
flSetDiffTemplate(0,'diff(pccos)= - pcsin($arg1)*$dfarg1');


flSetFunction('pcln(x:ext) = ln(x)',0,@idfP);
//flSetDiffTemplate(@idfP,'$dfarg1/$arg1');
flSetDiffTemplate(0,'diff(pcln) = $dfarg1/$arg1');

flSetFunction('pcpow(x1,x2:ext) = x1^x2',0,@idfP);
//flSetDiffTemplate(@idfP,'pcpow($arg1,$arg2)*(($arg2)*($dfarg1)/($arg1)+($dfarg2)*pcln($arg1))');
flSetDiffTemplate(0,'diff(pcpow) = pcpow($arg1,$arg2)*(($arg2)*($dfarg1)/($arg1)+($dfarg2)*pcln($arg1))');

flSetFunction('pcipow(x:ext; n:int)=x^n',0,@idfP);
//flSetDiffTemplate(@idfP,'pcipow($arg1,$arg2-1)*$arg2*$dfarg1');
flSetDiffTemplate(0,'diff(pcipow)=pcipow($arg1,$arg2-1)*$arg2*$dfarg1');

flSetFunction('pcfunc2(x,y:ext) = sin(x/y)',0,@idfP);
flSetDiffTemplate(@idfP,'cos($arg1/$arg2)*($dfarg1*$arg2-$dfarg2*$arg1)/sqr($arg2)');
//flSetDiffTemplate(0,'diff(pcfunc2)=cos($arg1/$arg2)*($dfarg1*$arg2-$dfarg2*$arg1)/sqr($arg2)');

flSetFunction('pcfunc3(x,y,t:ext) = sin(x-y/t)',0,@idfP);
flSetDiffTemplate(@idfP,'cos($arg1-$arg2/$arg3)*($dfarg1*sqr($arg3)-$dfarg2*$arg3+$dfarg3*$arg2)/sqr($arg3)');
//flSetDiffTemplate(0,'diff(pcfunc3)=cos($arg1-$arg2/$arg3)*($dfarg1*sqr($arg3)-$dfarg2*$arg3+$dfarg3*$arg2)/sqr($arg3)');





//***************  several expressions: ****************************************

    flPerform(fl_SAVE, fl_VAR_LIST);   // сохранить глобальные переменные

     fnc1.Expr:= 'z1+z2+n*x';
     flSetVar('x', @fnc1.x, c_RealFloat);
     flSetVar('n', @fnc1.n, fl_REAL_INTEGER);
     flSetVar('z1', @fnc1.z1, c_ComplexFloat);
     flSetVar('z2', @fnc1.z2, c_ComplexFloat);
     //flCompile(fnc1.Expr, fnc1.Addr);

         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc1.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc1.Expr);
         {$ENDIF}

     flCompile(Expr, 0,fnc1.Addr);


     fnc2.Expr:= 'z1*z2+(i*n+x)';
     flSetVar('x', @fnc2.x, c_RealFloat);
     flSetVar('n', @fnc2.n, fl_REAL_INTEGER);
     flSetVar('z1', @fnc2.z1, c_ComplexFloat);
     flSetVar('z2', @fnc2.z2, c_ComplexFloat);
     //flCompile(fnc2.Expr, fnc2.Addr);

         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc2.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc2.Expr);
         {$ENDIF}

     flCompile(Expr, 0, fnc2.Addr);


    flPerform(fl_RESTORE, fl_VAR_LIST); // восстановить глобальные переменные

    fnc1.x:= 1.1;  fnc1.n:= 3; fnc1.z1.re:= 2;  fnc1.z1.im:= -1;  fnc1.z2.re:= 5; fnc1.z2.im:= 3;
                   fnc2.n:= 5;                                    fnc2.z2.re:= 1; fnc2.z2.im:= -1;


    {$IFDEF EXTENDED_FLOAT}
       flResultCxEP(fnc1.Addr, @fnc1.res) ;    //fnc1.res=fnc1(2-i,5+3i,3,1.1)
    {$ELSE}
       flResultCxDP(fnc1.Addr, @fnc1.res) ;    //fnc1.res=fnc1(2-i,5+3i,3,1.1)
    {$ENDIF}

    fnc2.z1:= fnc1.res; fnc2.x:= fnc1.res.re;

      {$IFDEF EXTENDED_FLOAT}
       flResultCxEP(fnc2.Addr, @fnc2.res) ;
    {$ELSE}
       flResultCxDP(fnc2.Addr, @fnc2.res) ;
    {$ENDIF}
     //ShowMessage(FloatToStrF(fnc2.res.re,ffGeneral,19,4,G_FMT)+FloatToStrF(fnc2.res.im,ffGeneral,19,4,G_FMT)+'i');


//******************************************************************************
//                                 ATTRIB
//******************************************************************************
                             //дл€ удобства вычислений  одной процедурой:  flResult

 flPerform(fl_SAVE, fl_VAR_LIST);   // сохранить глобальные переменные

 flSet(fl_RESULT_LEAD_TO_TYPE,fl_STAY_AS_IS,0);

 flSetVar('GResult', @G_FResult, c_ComplexFloat);

    //-------------------------
     fnc1A.Expr:= 'GResult.re=x+y+t';
     flSetVar('x', @fnc1A.x, c_RealFloat);
     flSetVar('y', @fnc1A.y, c_RealFloat);
     flSetVar('t', @fnc1A.t, c_RealFloat);


         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc1A.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc1A.Expr);
         {$ENDIF}

     Attr.MType:=c_MathType; Attr.AddrRE:=@fnc1A.res.re;  Attr.AddrIM:=@fnc1A.res.im;
     flCompile(Expr,@Attr, fnc1A.Addr);
   //-------------------------

                                                  // c_RealFloat = fl_Real_Double, fl_Real_Externded
     fnc2A.Expr:= 'x=x+1; y=y+2; t=t+3; x*y*t';
     flSetVar('x', @fnc2A.x, c_RealFloat);
     flSetVar('y', @fnc2A.y, c_RealFloat);
     flSetVar('t', @fnc2A.t, c_RealFloat);


         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc2A.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc2A.Expr);
         {$ENDIF}

     Attr.MType:=c_MathType; Attr.AddrRE:=@fnc2A.res.re;  Attr.AddrIM:=@fnc2A.res.im;
     flCompile(Expr, @Attr, fnc2A.Addr);
   //-------------------------


     fnc3A.Expr:= '(z2-z1+x)*GResult';             //z2 - global var.
     flSetVar('x',  @fnc3A.x,  c_RealFloat);
     flSetVar('z1', @fnc3A.z1, c_ComplexFloat);

         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc3A.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc3A.Expr);
         {$ENDIF}

     Attr.MType:=c_MathType; Attr.AddrRE:=@fnc3A.res.re;  Attr.AddrIM:=@fnc3A.res.im;
     flCompile(Expr, @Attr,fnc3A.Addr);
   //-------------------------

   flPerform(fl_RESTORE, fl_VAR_LIST); // восстановить глобальные переменные


  fnc1A.x:= 1.1;  fnc1A.y:= 2.2; fnc1A.t:= 3.3;
  fnc2A.x:= 1.0;  fnc2A.y:= 2.0; fnc2A.t:= 3.0;

  flResult(fnc1A.Addr);        //GResult=1.1+2.2+3.3=6.6
  flResult(fnc2A.Addr);        //fnc2A.res=(1+1)*(2+2)*(3+3)=48

  fnc3A.x:=fnc2A.res.re; fnc3A.z1.re:= 1.1;  fnc3A.z1.im:= -1.1;

  flResult(fnc3A.Addr);          //fnc3A.res=(5.456+2.789i-(1.1-1.1i)+48)*6.6  = 345.5496+25.6674i

  //ShowMessage(FloatToStrF(G_FResult.re,ffGeneral,19,4,G_FMT));
  //ShowMessage(FloatToStrF(fnc2A.res.re,ffGeneral,19,4,G_FMT));
  //ShowMessage(FloatToStrF(fnc3A.res.re,ffGeneral,19,4,G_FMT)+'     '+FloatToStrF(fnc3A.res.im,ffGeneral,19,4,G_FMT)+'i');


 //flSetExpression('y=x+1; t=x+;',0,fl_CHECK_SYNTAX,FZ1,Err);


//******************************************************************************
//                                 PACKAGE EXPRESSION
//******************************************************************************
  fnc1.Expr:='r*sin(x)*cos(y)';
  fnc2.Expr:='r*sin(x)*sin(y)';
  fnc3.Expr:='r*cos(x)';



  flSet(fl_Enable,fl_ALL_REPLACE,0);
  flSet(fl_Enable,fl_PACKAGE_EXPRESSIONS,0);

    Attr.MType:=c_MathType;  Attr.AddrIM:=0;

    Attr.AddrRE:=@fnc1.res.re;  //Attr.AddrIM:=@fnc1.res.im;

         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc1.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc1.Expr);
         {$ENDIF}

    flSetExpression(Expr,@Attr,fl_PACKAGE_EXPRESSIONS,FZ1,Err);

    Attr.AddrRE:=@fnc2.res.re; // Attr.AddrIM:=@fnc2.res.im;

         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc2.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc2.Expr);
         {$ENDIF}

    flSetExpression(Expr,@Attr,fl_PACKAGE_EXPRESSIONS,FZ1,Err);

    Attr.AddrRE:=@fnc3.res.re;  //Attr.AddrIM:=@fnc3.res.im;
         {$IFDEF PANSICHAR}
            ans:=AnsiString(fnc3.Expr); Expr:=PAnsiChar(ans);
         {$ELSE}
            Expr:=TStringType(fnc3.Expr);
         {$ENDIF}

    flSetExpression(Expr,@Attr,fl_PACKAGE_EXPRESSIONS,FZ1,Err);

  flPerform(fl_COMPILE,fl_PACKAGE_EXPRESSIONS);
  flGet(fl_PACKAGE_COMPILE_ADDR, 0, CAddr1);
  flSet(fl_Disable,fl_ALL_REPLACE,0);

 (*
   if CB_OM.Checked then NC:=1 else NC:=abs(Trunc(StrToFloat(E_Cnt.Text,G_FMT)));
   T1:=GetTickCount;
   //NC:=1;
   for ic:=1 to NC do
   begin

         flResult(Pointer(CAddr1));
        {
        asm
         call FZ1
        end;
        }
   end;

   T2:=GetTickCount;


   if (T2-T1) <> 0 then LIPF.Caption:=IntToStr(Trunc(NC/(T2-T1))) else LIPF.Caption:='no defined';



   {
   zrese.re:=rezCx.re;  zrese.im:=rezCx.im;
   S1:=FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT);
   S2:=FloatToStrF(zrese.im,ffGeneral,20,4,G_FMT);
   LFR.Caption:=S1+'  '+S2+'i';
   }
   S1:=FloatToStrF(fnc1.res.re+fnc2.res.re+fnc3.res.re,ffGeneral,20,4,G_FMT);
   LFR.Caption:=S1;

  *)

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

 {$IFDEF USEFOREVAL}
  //flSet(fl_String_Type,fl_String,0);

  {$IFDEF STRING}      flSet(fl_String_Type,fl_String,0);       {$ENDIF}
  {$IFDEF ANSISTRING}  flSet(fl_String_Type,fl_AnsiString,0);   {$ENDIF}
  {$IFDEF WIDESTRING}  flSet(fl_STRING_TYPE,fl_WIDESTRING,0);   {$ENDIF}
  {$IFDEF UTF8}        flSet(fl_String_Type,fl_String_UTF8,0);   {$ENDIF}
  {$IFDEF PANSICHAR}   flSet(fl_String_Type,{fl_AnsiString}fl_PAnsiChar,0);   {$ENDIF}

  flSetVar('x',@xd,fl_Double);
  flSetVar('y',@yd,fl_Double);
  flSetVar('t',@td,fl_Double);

  flSetVar('a',@a,fl_Double);
  flSetVar('b',@b,fl_Double);
  flSetVar('c',@c,fl_Double);
  flSetVar('d',@d,fl_Double);
  flSetVar('e',@e,fl_Double);

  flSetVar('j',@j,fl_Integer);
  flSetVar('k',@k,fl_Integer);
  flSetVar('l',@l,fl_Integer);
  flSetVar('m',@m,fl_Integer);
  flSetVar('n',@n,fl_Integer);
{$ENDIF}



//pcmul(sin(x),cos(x))
flSetFunction('pcmul(x1,x2: ext)=x1*x2',0,@idfP);
flGetFunctionIDFP('pcmul',{FData}0,@idfP);
flSetDiffTemplate(@idfP,'pcmul($dfarg1,$arg2)+pcmul($arg1,$dfarg2)');
  // or this:
//flSetDiffTemplate(@idfP,'$dfarg1*$arg2+$arg1*$dfarg2');



 {

  flSetVar('x',@xs,fl_Real_Single);
  flSetVar('y',@ys,fl_Real_Single);
  flSetVar('t',@ts,fl_Real_Single);
  xs:=2.123; ys:=5.456; ts:=-3.789;

  flSetVar('z1',@z1s,fl_Complex_Single);
  flSetVar('z2',@z2s,fl_Complex_Single);
  flSetVar('z3',@z3s,fl_Complex_Single);
  z1s.re:=z1d.re; z1s.im:=z1d.im;
  z2s.re:=z2d.re; z2s.im:=z2d.im;
  z3s.re:=z3d.re; z3s.im:=z3d.im;

 }

  {
  flSetVarIntrnl('x', fl_Real_Single, addrXs);
  flSetVarIntrnl('y', fl_Real_Single, addrYs);
  flSetVarIntrnl('t', fl_Real_Single, addrTs);
  xs:=2.123; ys:=5.456; ts:=-3.789;
  flSetVarValueS(addrXs,xs); flSetVarValueS(addrYs,ys); flSetVarValueS(addrTs,ts);

  flSetVarIntrnl('z1', fl_Complex_Single, addrZ1s);
  flSetVarIntrnl('z2', fl_Complex_Single, addrZ2s);
  flSetVarIntrnl('z3', fl_Complex_Single, addrZ3s);
  z1s.re:=z1d.re; z1s.im:=z1d.im;
  z2s.re:=z2d.re; z2s.im:=z2d.im;
  z3s.re:=z3d.re; z3s.im:=z3d.im;
  flSetVarValueCxS(addrZ1s,z1s.re,z1s.im);
  flSetVarValueCxS(addrZ2s,z2s.re,z2s.im);
  flSetVarValueCxS(addrZ3s,z3s.re,z3s.im);
  }





//************* Manage of functions **********************

//****************************** Example : redefinition sqrt   ************************************

(*
flSetFunction('sqrtcx(x1: real): complex = if(x1 < 0, i*sqrt(|x1|)+0, sqrt(x1)+i*0)',0,@idfP);
flSetFunction('sqrtcx(z1: complex): complex = sqrt(z1)',0,@idfP);


//Add new name to "sqrtcx" : "sqrt"
// !!! not work due to conflict with sqrt_acc, has second name - 'sqrt'. Need also disable  "sqrt_acc"

//Disable buil-in "sqrt_acc"
flGetFuncIDN('sqrt_acc',IDN);
idFP.idName :=  IDN; idFP.idArg := fl_ANY;
flChangeFunctionProperty(fl_DISABLE_FUNCTION,@idFP);

//Disable buil-in "sqrt"
flGetFuncIDN('sqrt',IDN);
idFP.idName :=  IDN; idFP.idArg := fl_ANY;
flChangeFunctionProperty(fl_DISABLE_FUNCTION,@idFP);


//Add new name to "sqrtcx" : "sqrt"
flGetFuncIDN('sqrtcx',IDN);
flAddNameFunction(IDN,'sqrt');
*)


// ******************  Example : redefinition power ********************************

//Set new function: "pwr"
{
flSetFunction('pwr(x,y: ext):complex= if( (x < 0) and ([y] <> y),(x+0i)^y,x^y+0i)',0,@idfP);
flSetFunction('pwr(x: ext; z: CXext):complex= x^z',0,@idfP);
flSetFunction('pwr(z: CXext; x: ext):complex= z^x',0,@idfP);
flSetFunction('pwr(z1,z2: CXext):complex= z1^z2',0,@idfP);
flSetDiffTemplate(@idfP,'pwr($arg1,$arg2)*(($arg2)*($dfarg1)/($arg1)+($dfarg2)*ln($arg1))');

//Disable buil-in "power"
flGetFuncIDN('power',IDN);
idFP.idName :=  IDN; idFP.idArg := fl_ANY;
flChangeFunctionProperty(fl_DISABLE_FUNCTION,@idFP);
//Add new name to "pwr" : "power"
flGetFuncIDN('pwr',IDN);
flAddNameFunction(IDN,'power');
flAddNameFunction(IDN,'pow');


//Associate symbol operation "^" with "pwr"
idFP.idName:=IDN;
flChangeFunctionProperty(fl_SET_POWER_SYMBOL,@idFP);
 }




(*
flGetFunctionIDFP('pcbesselj',{FData}0,@idfP);
flSetDiffTemplate(@idfP,'(pcbesselj($arg1-1,$arg2)-pcbesselj($arg1+1,$arg2))*0.5*$dfarg2');
*)



//********************* Example : manage of syntax  ***************************

(*
  flSet(fl_ENABLE,fl_SHOW_EXCEPTION,0);

  flSet(fl_DISABLE,fl_LEAD_TO_LOWER_CASE,0);
  testx1.re:=1.1; testx1.im:=-1.1; testx2.re:=2.3;  testx2.im:=-2.3;

  flSetVar('x1',@testx1,fl_Complex_Double);
  flSetVar('X1',@testx2,fl_Complex_Double);
  flSetFunction('Tst(x:cxdbl; X:cxdbl):complex=x+X',0,@idfP);
  flSetFunction('tst(x: cxdbl; X:cxdbl):complex=x*X',0,@idfP);




  flCompile('x1+X1',0,FZ1);
  flResultCxD(FZ1,rRe,rIm);
  MessageDlg(floatToStr(rRe)+ '  '+floatToStr(rIm)+'i',mtInformation,[mbOk],0);

  flCompile('Tst(x1,X1)',0,FZ1);
  flResultCxD(FZ1,rRe,rIm);
  MessageDlg(floatToStr(rRe)+ '  '+floatToStr(rIm)+'i',mtInformation,[mbOk],0);

  flCompile('tst(x1,X1)',0,FZ1);
  flResultCxD(FZ1,rRe,rIm);
  MessageDlg(floatToStr(rRe)+ '  '+floatToStr(rIm)+'i',mtInformation,[mbOk],0);


  flSet(fl_ENABLE,fl_LEAD_TO_LOWER_CASE,0);

  flSetVar('x1',@testx1,fl_Complex_Double);
  flSetVar('X1',@testx2,fl_Complex_Double);

  flSetFunction('Tst(X:cxDbl):complex=x+X',0,@idfP);
  flSetFunction('tst(x:cxDbl):complex=x*X',0,@idfP);




  flCompile('x1+X1',0,FZ1);
  flResultCxD(FZ1,rRe,rIm);
  MessageDlg(floatToStr(rRe)+ '  '+floatToStr(rIm)+'i',mtInformation,[mbOk],0);

  flCompile('Tst(X1)',0,FZ1);
  flResultCxD(FZ1,rRe,rIm);
  MessageDlg(floatToStr(rRe)+ '  '+floatToStr(rIm)+'i',mtInformation,[mbOk],0);

  flCompile('tst(x1)',0,FZ1);
  flResultCxD(FZ1,rRe,rIm);
  MessageDlg(floatToStr(rRe)+ '  '+floatToStr(rIm)+'i',mtInformation,[mbOk],0);

  *)

 // *** Rename image unit     *****
{
flSetNameImUnit('ii');
flSetVar('i',@ii,fl_real_Integer);
ii:=100;
   // i*(1+2ii)   =  100+200i
}

// ********* Disable remove space in numbers and name of fucnctions & variables ******

{
flSet(fl_ENABLE,fl_CHECK_INCORRECT_SPACE,0);
flSet(fl_Enable,fl_Show_Exception,0);
flCompile('10.15 * ( 4 5. 87 - 2.12)',0,FZ1);
flCompile('x * si n (x+1)',0,FZ1);
flCompile('x * sin (v d[n] + 1)',0,FZ1);
}



{
flCompile('k:int=0; len:int=len(gvdf); s:dbl=0; for(k,0,len-1,s=s+gvdf[k]; gvdf[k]=2.0); s',0,FDyn);
flSetFunction('fnc1(vd: array double) :real = sum(vd)',0,@idfP);
flSetFunction('fncI1(n: Integer): real = n!',0,@idfP);
flSetFunction('fncF1(x: double): real = x*2',0,@idfP);
flSetFunction('pct(vd: array double; n: integer; x: extended)=vd[n]*x',0,@idfP);
}

 {
flCompile('y:ext=1; x+y+vd[k]',0,FZ1);
flGet(fl_PESENT_VAR,Cardinal(@xe),ID);     //Ans= fl_YES
flGet(fl_PESENT_VAR,Cardinal(@ye),ID);     //Ans= fl_NO      y Ц внутренн€€ переменна€
flGet(fl_PESENT_VAR,Cardinal(@vd),ID);    //Ans= fl_YES
flGet(fl_PESENT_VAR,Cardinal(@k),ID);      //Ans= fl_YES

flCompile('x+y',0,FZ1);
flGet(fl_PESENT_VAR,Cardinal(@xe),ID);     //Ans= fl_YES
flGet(fl_PESENT_VAR,Cardinal(@ye),ID);     //Ans= fl_YES
flGet(fl_PESENT_VAR,Cardinal(@vd),ID);    //Ans= fl_NO
flGet(fl_PESENT_VAR,Cardinal(@k),ID);      //Ans= fl_NO
 }



FDFN:=TFuncPC.Create(Form1);
CompilePC;

endp1:
{
flGet(fl_Version,fl_Major,ID);    S:=IntToStr(ID);
flGet(fl_Version,fl_Minor,ID);    S:=S+'.'+IntToStr(ID);
flGet(fl_Version,fl_Release,ID);  S:=S+'.'+IntToStr(ID);
flGet(fl_Version,fl_Build,ID);    S:=S+'.'+IntToStr(ID);

Form1.Caption:='Test Foreval.dll  (v.'+S+')';


flGet(fl_Compiled_by,0,ID);


if ID >= 100 then
begin
  Form1.Caption:=Form1.Caption+'.  Compiled by FPC v.' + IntToStr(ID);
  CompiledBy:=CompiledByFPC;
end
else
begin
CompiledBy:=CompiledByDelphi;
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
  30: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10';
  31: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.1';
  32: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.2';
  33: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.3';
  34: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 10.4';
  35: Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 11'
  else Form1.Caption:=Form1.Caption+'.   Compiled by Delphi 11+' ;

end;
end;
}


flGet(fl_String_Type,0,ID);
case ID of
 fl_STRING_UTF16:         S1:='UTF16';
 fl_ANSISTRING:           S1:='AnsiString';
 fl_PAnsiChar:            S1:='PAnsiChar';
 fl_WIDESTRING:           S1:='WideString';
 fl_STRING_UTF8:          S1:='UTF8';
end;
Form1.LST.Caption:=S1;

 {
 TimerEx:=TTimer.Create(nil);
 TimerEx.OnTimer:=TimerExTimer;
 TimerEx.Interval := 500;
 TimerEx.Enabled := False;
 G_TestExprEx:=False;
 }
 OpenFile:=TOpenDialog.Create(self);
 OpenFile.Filter:= 'Text files only|*.txt';



{$IFDEF USEDLL}
  //flGet(fl_AUTHOR,0,ID);
  //flGet(fl_ABOUT,0,ID);
  //flGet(fl_COMMENT,0,ID);
  //ConvStr(Pointer(ID),S1);
  // S1:=String(Pointer(ID));
  //Form1.Caption:=Form1.Caption+'    '+S1;
{$ENDIF}


{
       BorserStyle = bsSingle
       BorderIcons.biMaximize = false
}

endp:
end;



constructor TTestExprTask.Create;
begin
 inherited Create(False);

end;


procedure TTestExprTask.Execute;
begin
////

  if Form1.CompileExprTest = True then
  begin
    Form1.RunExprTest;
    Form1.ShowTestExprError;
    Form1.FreeCompiledList;
  end;

  Form1.IntTest.Enabled:=True;

end;




 (*
procedure TForm1.TimerExTimer(Sender: TObject);
var
i: integer;
begin

if G_TestExprEx = True then
begin
    G_TestExprEx:=False;
    L:=Length(GS_TestExprEx);
    for i := G_BeginPosEx to L-1 do
    begin
       MT.Lines.Add(GS_TestExprEx[i]);
    end;
    G_BeginPosEx:=L;
end;


end;
*)



procedure TForm1.OutStr(Sout: String);
begin

  SetLength(GS_TestExprEx,Length(GS_TestExprEx)+1);
  GS_TestExprEx[High(GS_TestExprEx)]:=Sout;
  G_TestExprEx:=True;

end;



procedure TForm1.RB_SDClick(Sender: TObject);
begin
 //fzStackType(_Double);
 flSet(fl_Stack_Type,fl_Double,0);
end;


procedure TForm1.RB_AsIsClick(Sender: TObject);
begin
 if RB_AsIs.Checked =  True  then
 begin
    flSet(fl_RESULT_LEAD_TO_TYPE, fl_STAY_AS_IS,0);
    G_ResCalcType:=fl_STAY_AS_IS;
 end;
end;


procedure TForm1.RB_CxClick(Sender: TObject);
begin
 if RB_Cx.Checked =  True  then
 begin
    flSet(fl_RESULT_LEAD_TO_TYPE, fl_Complex,0);
    G_ResCalcType:=fl_Complex;
 end;
end;


procedure TForm1.RB_ReClick(Sender: TObject);
begin
 if RB_Re.Checked =  True  then
 begin
    flSet(fl_RESULT_LEAD_TO_TYPE, fl_Real,0);
    G_ResCalcType:=fl_Real;
 end;
end;

procedure TForm1.RB_DLDisableClick(Sender: TObject);
begin
 flSet(fl_Disable,fl_DINAMIC_LOAD,0);
end;

procedure TForm1.RB_DLEnableClick(Sender: TObject);
begin
  flSet(fl_Enable,fl_DINAMIC_LOAD,0);
end;

procedure TForm1.RB_SEClick(Sender: TObject);
begin
 //fzStackType(_Extended);
 flSet(fl_Stack_Type,fl_Extended,0);
end;



procedure TForm1.RB_FVDClick(Sender: TObject);
begin
// flPerform(fl_Free,fl_VAR_LIST);

if CB_VCx.Checked =  True  then
begin
  flSetVar('x',@zxd,fl_Complex_Double);
  flSetVar('y',@zyd,fl_Complex_Double);
  flSetVar('t',@ztd,fl_Complex_Double);
  //flSetVar('s',@zs,fl_Complex_Double);
end
else
begin
   flSetVar('x',@xd,fl_Real_Double);
   flSetVar('y',@yd,fl_Real_Double);
   flSetVar('t',@td,fl_Real_Double);
   flSetVar('r',@rd,fl_Real_Double);
   flSetVar('s',@sd,fl_Real_Double);

   PVX:=@xd;  PVY:=@yd; PVT:=@td; PVR:=@rd; PVS:=@sd;
   //flSetVar('s',@sd,fl_Real_Double);
end;


//flSetVar('pi',@c_pi,fl_Real_Extended);

if CB_CXAnyAddr.Checked then
begin
   flSetVarCX('z1',@CxVarAnyRE_D[z1re],@CxVarAnyIM_D[z1im],fl_Complex_Double);
   flSetVarCX('z2',@CxVarAnyRE_D[z2re],@CxVarAnyIM_D[z2im],fl_Complex_Double);
   flSetVarCX('z3',@CxVarAnyRE_D[z3re],@CxVarAnyIM_D[z3im],fl_Complex_Double);
   //flSetVarCX('z4',@CxVarAnyRE_D[z4re],@CxVarAnyIM_D[z4im],fl_Complex_Double);
end
else
begin
   flSetVar('z1',@z1d,fl_Complex_Double);
   flSetVar('z2',@z2d,fl_Complex_Double);
   flSetVar('z3',@z3d,fl_Complex_Double);
   //flSetVar('z4',@z4d,fl_Complex_Double);
end;

 {
flSetVar('a',@a,fl_Real_Double);
flSetVar('b',@b,fl_Real_Double);
flSetVar('c',@c,fl_Real_Double);
flSetVar('d',@d,fl_Real_Double);
flSetVar('e',@e,fl_Real_Double);
}
{
flSetVar('s',@sd,fl_Real_Double);
flSetVar('r',@rd,fl_Real_Double);
flSetVar('p',@pd,fl_Real_Double);
}

{flSetVar('n',@n,fl_real_Integer);
flSetVar('k',@k,fl_real_Integer);
flSetVar('j',@j,fl_real_Integer); }

{
flSetVar('vd',@vd,fl_Array_Real_Double);
flSetVar('ve',@ve,fl_Array_Real_Extended);
flSetVar('ad',@ad,fl_Array_Real_Double);

flSetVar('vd1',@vd1,fl_Array_Real_Double);
flSetVar('vd2',@vd2,fl_Array_Real_Double);
flSetVar('vd3',@vd3,fl_Array_Real_Double);  }
end;


procedure TForm1.RB_FVEClick(Sender: TObject);
begin
 //flPerform(fl_Free,fl_VAR_LIST);

 if CB_VCx.Checked =  True  then
begin
  flSetVar('x',@zxe,fl_Complex_Extended);
  flSetVar('y',@zye,fl_Complex_Extended);
  flSetVar('t',@zte,fl_Complex_Extended);
end
else
begin
   flSetVar('x',@xe,fl_Real_Extended);
   flSetVar('y',@ye,fl_Real_Extended);
   flSetVar('t',@te,fl_Real_Extended);
   flSetVar('r',@r_e,fl_Real_Extended);
   flSetVar('s',@se,fl_Real_Extended);

   PVX:=@xe;  PVY:=@ye; PVT:=@te; PVR:=@r_e; PVS:=@se;
end;



//flSetVar('pi',@c_pi,fl_Real_Extended);

if CB_CXAnyAddr.Checked then
begin
   flSetVarCX('z1',@CxVarAnyRE_E[z1re],@CxVarAnyIM_E[z1im],fl_Complex_Extended);
   flSetVarCX('z2',@CxVarAnyRE_E[z2re],@CxVarAnyIM_E[z2im],fl_Complex_Extended);
   flSetVarCX('z3',@CxVarAnyRE_E[z3re],@CxVarAnyIM_E[z3im],fl_Complex_Extended);
end
else
begin
   flSetVar('z1',@z1e,fl_complex_Extended);
   flSetVar('z2',@z2e,fl_complex_Extended);
   flSetVar('z3',@z3e,fl_complex_Extended);
end;

 {
flSetVar('a',@Ae,fl_Real_Extended);
flSetVar('b',@Be,fl_Real_Extended);
flSetVar('c',@Ce,fl_Real_Extended);
flSetVar('d',@De,fl_Real_Extended);
flSetVar('e',@Ee,fl_Real_Extended);
  }
  {
flSetVar('s',@se,fl_Real_Extended);
flSetVar('r',@rx,fl_Real_Extended);
flSetVar('p',@pe,fl_Real_Extended);
}
{flSetVar('n',@n,fl_real_Integer);
flSetVar('k',@k,fl_real_Integer);
flSetVar('j',@j,fl_real_Integer);



flSetVar('vd',@vd,fl_Array_Real_Double);
flSetVar('ve',@ve,fl_Array_Real_Extended);
flSetVar('ad',@ad,fl_Array_Real_Double);

flSetVar('vd1',@vd1,fl_Array_Real_Double);
flSetVar('vd2',@vd2,fl_Array_Real_Double);
flSetVar('vd3',@vd3,fl_Array_Real_Double);
}



end;


procedure TForm1.RB_FVSClick(Sender: TObject);
begin

if CB_VCx.Checked =  True  then
begin
  flSetVar('x',@zxs,fl_Complex_Single);
  flSetVar('y',@zys,fl_Complex_Single);
  flSetVar('t',@zts,fl_Complex_Single);
  //flSetVar('s',@zs,fl_Complex_Double);
end
else
begin
   flSetVar('x',@xs,fl_Real_Single);
   flSetVar('y',@ys,fl_Real_Single);
   flSetVar('t',@ts,fl_Real_Single);
   flSetVar('r',@rs,fl_Real_Single);
   flSetVar('s',@ss,fl_Real_Single);

   //PVX:=@xd;  PVY:=@yd; PVT:=@td; PVR:=@rd; PVS:=@sd;
end;




if CB_CXAnyAddr.Checked then
begin
   flSetVarCX('z1',@CxVarAnyRE_S[z1re],@CxVarAnyIM_S[z1im],fl_Complex_Single);
   flSetVarCX('z2',@CxVarAnyRE_S[z2re],@CxVarAnyIM_S[z2im],fl_Complex_Single);
   flSetVarCX('z3',@CxVarAnyRE_S[z3re],@CxVarAnyIM_S[z3im],fl_Complex_Single);
   //flSetVarCX('z4',@CxVarAnyRE_D[z4re],@CxVarAnyIM_D[z4im],fl_Complex_Double);
end
else
begin
   flSetVar('z1',@z1s,fl_Complex_Single);
   flSetVar('z2',@z2s,fl_Complex_Single);
   flSetVar('z3',@z3s,fl_Complex_Single);
   //flSetVar('z4',@z4d,fl_Complex_Double);
end;

end;




procedure TForm1.RB_PDClick(Sender: TObject);
begin
 flSet(fl_PRECISION,fl_DOUBLE,0);
end;

procedure TForm1.RB_PEClick(Sender: TObject);
begin
 flSet(fl_PRECISION,fl_EXTENDED,0);
end;


procedure TForm1.RB_XbAutoClick(Sender: TObject);
begin
 flSet(fl_AUTO,fl_EXCHANGE_BRANCH,0);
end;

procedure TForm1.RB_XBdisableClick(Sender: TObject);
begin
 flSet(fl_DISABLE,fl_EXCHANGE_BRANCH,0);
end;

procedure TForm1.RB_XbEnableClick(Sender: TObject);
begin
 flSet(fl_ENABLE,fl_EXCHANGE_BRANCH,0);
end;

procedure TForm1.RB_ZDiv_ACCClick(Sender: TObject);
begin
  flSet(fl_COMPLEX_DIV,fl_ACCURATE,0);
end;

procedure TForm1.RB_ZDiv_ExtraClick(Sender: TObject);
begin
  flSet(fl_COMPLEX_DIV,fl_EXTRA,0);
end;

procedure TForm1.RB_ZDiv_FastClick(Sender: TObject);
begin
  flSet(fl_COMPLEX_DIV,fl_FAST,0);
end;

procedure TForm1.RB_ZDiv_STDClick(Sender: TObject);
begin
  flSet(fl_COMPLEX_DIV,fl_STANDARD,0);
end;



procedure TForm1.UDSDClick(Sender: TObject; Button: TUDBtnType);
begin
 Panel1.Caption:=IntToStr(UDSD.Position);
 flSet(fl_STACK_DEEP,UDSD.Position,0);
end;

procedure TForm1.Ez1xChange(Sender: TObject);
begin
 z1d.re:=StrToFloat(Ez1x.Text,G_FMT);
 z1e.re:=StrToFloat(Ez1x.Text,G_FMT);
 z1s.re:=StrToFloat(Ez1x.Text,G_FMT);

 CxVarAnyRE_E[z1re]:=z1e.re;
 CxVarAnyRE_D[z1re]:=z1d.re;
 CxVarAnyRE_S[z1re]:=z1s.re;

end;

procedure TForm1.Ez1yChange(Sender: TObject);
begin
 z1d.im:=StrToFloat(Ez1y.Text,G_FMT);
 z1e.im:=StrToFloat(Ez1y.Text,G_FMT);
 z1s.im:=StrToFloat(Ez1y.Text,G_FMT);

 CxVarAnyIM_E[z1im]:=z1e.im;
 CxVarAnyIM_D[z1im]:=z1d.im;
 CxVarAnyIM_S[z1im]:=z1s.im;
end;


procedure TForm1.Ez2xChange(Sender: TObject);
begin
 z2d.re:=StrToFloat(Ez2x.Text,G_FMT);
 z2e.re:=StrToFloat(Ez2x.Text,G_FMT);
 z2s.re:=StrToFloat(Ez2x.Text,G_FMT);


 CxVarAnyRE_E[z2re]:=z2e.re;
 CxVarAnyRE_D[z2re]:=z2d.re;
 CxVarAnyRE_S[z2re]:=z2s.re;
end;


procedure TForm1.Ez2yChange(Sender: TObject);
begin
  z2d.im:=StrToFloat(Ez2y.Text,G_FMT);
  z2e.im:=StrToFloat(Ez2y.Text,G_FMT);
  z2s.im:=StrToFloat(Ez2y.Text,G_FMT);

  CxVarAnyIM_E[z2im]:=z2e.im;
  CxVarAnyIM_D[z2im]:=z2d.im;
  CxVarAnyIM_S[z2im]:=z2s.im;
end;


procedure TForm1.Ez3xChange(Sender: TObject);
begin
 z3d.re:=StrToFloat(Ez3x.Text,G_FMT);
 z3e.re:=StrToFloat(Ez3x.Text,G_FMT);
 z3s.re:=StrToFloat(Ez3x.Text,G_FMT);

 CxVarAnyRE_E[z3re]:=z3e.re;
 CxVarAnyRE_D[z3re]:=z3d.re;
 CxVarAnyRE_S[z3re]:=z3s.re;
end;


procedure TForm1.Ez3yChange(Sender: TObject);
begin
  z3d.im:=StrToFloat(Ez3y.Text,G_FMT);
  z3e.im:=StrToFloat(Ez3y.Text,G_FMT);
  z3s.im:=StrToFloat(Ez3y.Text,G_FMT);

  CxVarAnyIM_E[z3im]:=z3e.im;
  CxVarAnyIM_D[z3im]:=z3d.im;
  CxVarAnyIM_S[z3im]:=z3s.im;
end;


procedure TForm1.B_DefFuncClick(Sender: TObject);
begin
   //FDFN:=TFuncPC.Create(Form1);
   FDFN.ShowModal;
   //HelpB.Init(Sett);
   //if SelMode.ShowModal = mrOk then Sett:=H_Sett;
   //FDFN.Destroy;
end;

procedure TForm1.B_CompFuncClick(Sender: TObject);
begin
//CompTextProg;
CompTextFunc;
end;

procedure TForm1.B_RunProgClick(Sender: TObject);
begin
 CompTextProg;
end;




procedure FindExternalBracketN(S: String; var SS: String; var Neg: Integer);
label
2,3,outckl,endp;
var
b,i,z,a,NdelB,NDelE,L,Nbr,Nbrz,LS: Integer;
begin



NDelB:=0;
NDelE:=0;
NBr:=0;
NBrz:=0;
L:=Length(S);
z:=1;
i:=1;
//for i := 1 to Length(S)-1 do
while i <= L-1 do
begin

    if (S[i] = '-') and (S[i+1] = '(')  then
    begin
       b:=-1;
       LS:=L-NDelE;
       for j := i+2 to LS do
       begin
         if S[j] = '(' then b:=b-1 else
         if S[j] = ')' then b:=b+1;
         if (j < LS) and (b = 0)  then goto outckl;
       end;
       if b = 0 then
       begin
         NDelB:=NDelB+2;
         inc(NDelE);
         z:=z*(-1);
         inc(NBrz);
       end
       else goto outckl;  {mast be error}
       i:=i+2;
    end
    else
    if (S[i] = '(')  then
    begin
       b:=-1;
       LS:=L-NDelE;
       for j := i+1 to LS do
       begin
         if S[j] = '(' then b:=b-1 else
         if S[j] = ')' then b:=b+1;
         if (j < LS) and (b = 0)  then goto outckl;
       end;
       if b = 0 then
       begin
         NDelB:=NDelB+1;
         inc(NDelE);
         inc(NBr);
       end
       else goto outckl;  {mast be error}
       i:=i+1;
    end
    else
    inc(i);

end;

outckl:
if (NBr <= 1)  and (NBrz = 0)  then goto endp;//  (Expr) ->  (Expr)
if (NBrz <= 1) and (NBr = 0)   then goto endp;// -(Expr) -> -(Expr)

if (NBrz >= 1) or (NBr >= 1) then
begin
  Delete(S,1,NDelB);
  Delete(S,Length(S)-NDelE+1,NDelE);
  S:='('+S+')';
end;


endp:
if z = -1 then  Neg:=1
else  Neg:=0;

SS:=S;

{
SS:=Copy(S,1,Length(S)); z:=1;
2:
b:=0; a:=1;


if SS = '' then
begin
goto endp;
end;



if SS[1] = '-' then a:=2;
if  SS[a] = '(' then
begin
 b:=-1;
 for i:=a+1 to Length(SS)-1 do
 begin
  if SS[i] = '(' then b:=b-1;
  if SS[i] = ')' then b:=b+1;
  if b = 0 then goto 3
 end;


if SS[Length(SS)] = ')' then
begin
if a = 2 then
begin
Delete(SS,1,1);
z:=z*(-1);
end;
Delete(SS,1,1);
Delete(SS,Length(SS),1);
goto 2;
end;
end;
3:
if z = -1 then  Neg:=1
else  Neg:=0;
endp:
}

end;



procedure FindExternalBracketNP(PS: PString; var Neg: Integer);
label
2,3,outckl,endp;
var
b,i,j,z,a,NdelB,NDelE,L,Nbr,Nbrz,LS: Integer;
begin


NDelB:=0;
NDelE:=0;
NBr:=0;
NBrz:=0;
L:=Length(PS^);
z:=1;
i:=1;
//for i := 1 to Length(S)-1 do
while i <= L-1 do
begin

    if (PS^[i] = '-') and (PS^[i+1] = '(')  then
    begin
       b:=-1;
       LS:=L-NDelE;
       for j := i+2 to LS do
       begin
         if PS^[j] = '(' then b:=b-1 else
         if PS^[j] = ')' then b:=b+1;
         if (j < LS) and (b = 0)  then goto outckl;
       end;
       if b = 0 then
       begin
         NDelB:=NDelB+2;
         inc(NDelE);
         z:=z*(-1);
         inc(NBrz);
       end
       else goto outckl;  {mast be error}
       i:=i+2;
    end
    else
    if (PS^[i] = '(')  then
    begin
       b:=-1;
       LS:=L-NDelE;
       for j := i+1 to LS do
       begin
         if PS^[j] = '(' then b:=b-1 else
         if PS^[j] = ')' then b:=b+1;
         if (j < LS) and (b = 0)  then goto outckl;
       end;
       if b = 0 then
       begin
         NDelB:=NDelB+1;
         inc(NDelE);
         inc(NBr);
       end
       else goto outckl;  {mast be error}
       i:=i+1;
    end
    else
    goto outckl;
    //inc(i);

end;

outckl:
//if (NBr <= 1)  and (NBrz = 0)  then goto endp;//  (Expr) ->  (Expr)
//if (NBrz <= 1) and (NBr = 0)   then goto endp;// -(Expr) -> -(Expr)

if (NBrz >= 1) or (NBr >= 1) then
begin
  Delete(PS^,1,NDelB);
  Delete(PS^,Length(PS^)-NDelE+1,NDelE);

  if PS^[1] = '-' then
  begin
    Delete(PS^,1,1);
    z:=z*(-1);
  end;

  if (PS^ = '0')  then
  begin
    PS^:='0';
    goto endp;
  end
  else
  if (PS^ = '1') then
  begin
    if z = -1 then PS^:='-1';
    goto endp;
  end;


   if z = -1 then  PS^:='-'+PS^;


  //PS^:='('+PS^+')';
end
else
begin
  if PS^[1] = '-' then
  begin
    Delete(PS^,1,1);
    z:=z*(-1);
  end;

  if (PS^ = '0')  then
  begin
    PS^:='0';
    goto endp;
  end
  else
  if (PS^ = '1') then
  begin
    if z = -1 then PS^:='-1';
    goto endp;
  end;

   if z = -1 then  PS^:='-'+PS^;

end;


endp:
{if (PS^ = '-0') or (PS^ = '(-0)') or (PS^ = '-(-0)') or (PS^ = '(0)') then begin PS^:='0'; z:=1;  end
else
if PS^ = '(1)' then PS^:='1';  }

{if z = -1 then  Neg:=1
else  Neg:=0; }
end;



procedure TForm1.B_CaclDiffClick(Sender: TObject);
label endc,endp,showres,eval,_debug;
var
Expr: TStringType;

DStr,DExpr,SArg: String;
T1,T2,ndx,ndy: Cardinal;

Neg: Integer;
S,SS,S1,S2,S3,S4,S5,S6,S7: String;

ic,CError: Cardinal;
SB,adr,gt: Cardinal;
NS: Cardinal;
r1,r2,zx,zy,resd: double;
er1,ex1,ex7: extended;

FZ1,FZ2,FZ3,FZ4,PtrZ1,PtrZ2: Pointer;
FS1,FS2,FS3,FS4,FS5,FS6,FS7: Pointer;

zr1,zr2,zr3,zr4,zr5: TComplexD;
st: array of extended;
ze1,zrese: TComplexE;
zresd,zres: TComplexD;
ptr,P: Pointer;
rt,rt1,ct,len: Cardinal;
NN,n1,n2,ni,j: integer;
Exc: integer;
Ans: AnsiString;
Str: String;
WS: WideString;
PAC: PAnsiChar;
acf: array of pointer;
acr: array of double;
BRes: Boolean;
M1: Cardinal;
FpuEx: Cardinal;
Erc: Cardinal;

FData: TFuncID;
idfP: Pointer;{^TidFunc;}
PidFunc: ^TidFunc;
idFunc: TidFunc;
PtrS: Pointer;
Attr: TAttrib;
begin

   //  goto _debug;



{
flSet(fl_TYPE_OF_DIFFERENTIATION,fl_SYMBOLIC,0);
flSetDiffVar('x');
Expr:='t=x; sin(t)';
flSetDiffExpr(Expr);
flGetErrorCode(CError);
if  CError  = fl_NO_DIFF_SYMBOLIC then
begin
   flSet(fl_TYPE_OF_DIFFERENTIATION,  fl_NUMERIC,0);
   flSetDiffExpr(Expr);
end;
flDiffExpr(1);
flCompileDiffExpr(FZ1);
flSet(fl_Diff_Numeric_Precision, 5 , 2);
flResultE(FZ1,zrese.re);
}

//добавить проверку возвращаемого типа fl_real при численном дифф-и

{
flSetFunction('fdf1(x,y: ext)  = sin(x/y)',0,@idFunc);
flSetFunction('fdf2(x,y: ext)  = cos(y/x)',0,@idFunc);
flSetFunction('fdf3(x,y: ext)  = cos(x/(y+x))',0,@idFunc);
flSetFunction('fdf4(x,y: ext)  = tan(x/(y+x))',0,@idFunc);
 }
{
flSetFunction('fdf1(x,y: ext)  = x*y',0,@idFunc);
flSetFunction('fdf2(x,y: ext)  = y/x',0,@idFunc);
flSetFunction('fdf3(x,y: ext)  = x/y',0,@idFunc);
 }
// x*y*fdf1(x+y, x-y)+ x*y*fdf2(x^2+y, x-y^2)+x^3*fdf3(2*x+y, x-3*y)

// x*fdf1(x+y, x-y)+ x^2*fdf2(x^2+y, x-y^2)+x^3*fdf3(2*x+y, x-3*y)
// x*fdf1(x+y, x-y)+ x^2*fdf2(x^2+y, x-y^2)+x^3*fdf4(2*x+y, x-3*y)
// fdf1(x+y, x-y)+ fdf2(x^2+y, x-y^2)+fdf3(2*x+y, x-3*y)

{
flSetFunction('fdf1(x: ext)  = sin(x)',0,@idFunc);
flSetFunction('fdf2(x: ext)  = cos(x)',0,@idFunc);
flSetFunction('fdf3(x: ext)  = cos(x*2)',0,@idFunc);
}
// fdf1(x+y)+ fdf2(x-y^2)+fdf3(2*x+y)


CreateM1u;
RefReshVar;

{
flSet(fl_TYPE_OF_DIFFERENTIATION,fl_NUMERIC,0);
flCompileDeriv(EF.Text,'x',3,FZ1);
//flPerform(fl_FREE,Cardinal(FZ1));
goto eval;
 }



 F_Error:=False;
 S1:=EF.Text;


 ndx:=StrToInt(E_DX.Text);
 ndy:=StrToInt(E_DY.Text);
 ndt:=StrToInt(E_DT.Text);
 nds:=StrToInt(E_DS.Text);

 flSet(fl_TYPE_OF_DIFFERENTIATION,fl_SYMBOLIC,0);

 if CB_ND.Checked then
 begin
  {
  NumDiff;
  flGetErrorCode(CError);
  if CError <> 0 then goto endp;
   SArg:='';
   if ndx <> 0 then  SArg:=SArg+'x,';
   if ndy <> 0 then  SArg:=SArg+'y,';
   if ndt <> 0 then  SArg:=SArg+'t,';
   if nds <> 0 then  SArg:=SArg+'s,';
   Delete(SArg,Length(SArg),1);
  S1:='mainexpr('+SArg+')';
  }

  flSet(fl_TYPE_OF_DIFFERENTIATION,fl_NUMERIC,0);

 end;


 //extd(extd(x)*x)*extd(sin(x)*x^2)
 //(extd(x)^5*x)^5*(sin(x)*x^2)^5

 //nd:=1;


for j := 1 to 4 do
  begin
    case Adv[j].n of
      1:  Adv[j].nd:=ndx;
      2:  Adv[j].nd:=ndy;
      3:  Adv[j].nd:=ndt;
      4:  Adv[j].nd:=nds;
    end;
  end;


          T1:=GetTickCount;

      {$IFDEF PANSICHAR}
        ans:=AnsiString(S1); Expr:=PAnsiChar(ans);
      {$ELSE}
        Expr:=TStringType(S1);
      {$ENDIF}

       flSetDiffExpr(Expr);
       flGetErrorCode(CError);

       if CError = fl_NO_DIFF_SYMBOLIC then
       begin
                flSet(fl_TYPE_OF_DIFFERENTIATION,fl_NUMERIC,0);
                flSetDiffExpr(Expr);
                flGetErrorCode(CError);
       end;

         if CError = 0 then
         begin

            for j := 1 to 4 do
            begin
              if (Adv[j].nd <> 0) and  (CError = 0) then
              begin

                {$IFDEF PANSICHAR}
                    ans:=AnsiString(Adv[j].s); Expr:=PAnsiChar(ans);
                {$ELSE}
                    Expr:=TStringType(Adv[j].s);
                {$ENDIF}


                flSetDiffVar(Expr);
                flDiffExpr(Adv[j].nd);
                flGetErrorCode(CError);
                if CError <> 0 then
                begin
                    ShowError;
                    goto endp;
                end;
              end;
            end;

            T2:=GetTickCount;

          LDFT.Caption:=IntToStr(T2-T1);
             {
                T_1:=GetTickCount;
            if (CError = 0)  then flCompileDiffExpr(FS1);
                T_2:=GetTickCount;
                }
         end
         else
         begin
             ShowError;
             goto endp;
         end;


  {$IFDEF STRINGINT}
    flGetDiffString(DExpr);
  {$ELSE}
    flGetDiffString(PtrS);
    ConvStr(PtrS,DExpr);
  {$ENDIF}

 if CB_ShowDiff.Checked then MT.Text:=DExpr;

 LExprLen.Caption:=IntToStr(Length(DExpr));






 T1:=GetTickCount;
     //flCompile(DExpr,FZ1);
     flCompileDiffExpr(FZ1);
 T2:=GetTickCount;


 LDCT.Caption:=IntToStr(T2-T1);

eval:
 ct:=G_ResCalcType;
 if CB_OM.Checked then NC:=1 else NC:=abs(Trunc(StrToFloat(E_Cnt.Text,G_FMT)));
 flGetErrorCode(CError);


 flSet(fl_Diff_Numeric_Precision,StrToInt(E_NP.Text),StrToInt(E_PH.Text));



  {!!! DEBUG+}

  _debug:
  (*
     //flSet(fl_Enable,fl_Show_Exception,0);

     //Expr:='t=x; sin(t)';
     //flSet(fl_TYPE_OF_DIFFERENTIATION,fl_NUMERIC,0);

     {
     Expr:='sin(x)';
     flSet(fl_TYPE_OF_DIFFERENTIATION,fl_SYMBOLIC,0);
     }
     flSetFunction('pcnone(x):none = y=x',0,@idfP);

     Expr:= 't=x;  sin(t)';

    // ошибки во всех  не перехватываютс€ !!
    // Expr:= 't=x;  pcnone(x)';
    // Expr:= 't=x;  x=t';
    //Expr:= 't=x';
    // Expr:= 'pcnone(x)';

     flSet(fl_DIFF_NUMERIC_PRECISION,14,2);

     flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);

     //flPerform(fl_CLEAR,fl_ERROR_CODE );

     //flSet(fl_TYPE_OF_DIFFERENTIATION, fl_NUMERIC,0);

     flSetDiffExpr(Expr);
     flGetErrorCode(CError);
     if CError = fl_NO_DIFF_SYMBOLIC then
     begin
                flSet(fl_TYPE_OF_DIFFERENTIATION,fl_NUMERIC,0);
                flSetDiffExpr(Expr);
                flGetErrorCode(CError);
     end
     else
     if CError <> 0 then
     begin
          ShowError;
          goto endp;
     end;

     flSetDiffVar('x');
     flDiffExpr(1);
     flCompileDiffExpr(FZ1);

     flGetErrorCode(CError);
     if CError = 0 then
     begin

	          {$IFDEF STRINGINT}
              flGetDiffString(DExpr);
            {$ELSE}
               flGetDiffString(PtrS);
               ConvStr(PtrS,DExpr);
            {$ENDIF}
               MT.Text:=DExpr;

              flPerform(fl_FREE,Cardinal(FZ1));
              Attr.MType:=c_MathType; Attr.AddrRE:=@resf.re;  Attr.AddrIM:=@resf.im;


              flCompileDiffExprATE( @Attr,FZ1,rt,CError);
              if CError = 0 then
              begin
                CError:=flResultSafe(FZ1);
                if CError = 0 then
                begin
                   zrese.re:=resf.re;
                   zrese.im:=resf.im;
                   goto showres;
                end;
              end;

     end
     else
     begin
       ShowError;
       goto endp;
        //goto showres;
     end;
     goto showres;



     Expr:='sumqs(vd,x)*x';
     flSet(fl_TYPE_OF_DIFFERENTIATION,fl_SYMBOLIC,0);
     Attr.MType:=c_MathType; Attr.AddrRE:=@resf.re;  Attr.AddrIM:=@resf.im;
     flSetDiffExpr(Expr);
     flSetDiffVar('x');
     flDiffExpr(1);
        {$IFDEF STRINGINT}
            flGetDiffString(DExpr);
        {$ELSE}
            flGetDiffString(PtrS);
            ConvStr(PtrS,DExpr);
        {$ENDIF}
        MT.Text:=DExpr;
     flCompileDiffExprATE( @Attr,FZ1,rt,CError);

     {
     flSetDiffExpr(Expr);
     flSetDiffVar('x');
     flDiffExpr(1);
     flCompileDiffExprATE( @Attr,FZ1,rt,CError);
     }
     {
     flCompileDerivATE( Expr, 'x', 1, @Attr, FZ1,rt,CError);
     if  CError = 0 then
     begin
     asm
        call FZ1
     end;
     end;
      }
     //flCompileDerivATE(Expr, 'x', 1, @Attr, FZ1,rt,CError);
     flResult(FZ1);
     zrese.re:=resf.re;
     zrese.im:=resf.im;
     goto showres;


  {
  DExpr:='12345';
  //ERROR: режим double, выражение - константа
  //в extended , или при отключЄнной оптимизации CalcConstWallExpr- работает!
  Attr.MType:=c_MathType; Attr.AddrRE:=@resf.re;  Attr.AddrIM:=@resf.im;
  flCompile(DExpr, @Attr, FZ1);
  asm
    call FZ1
  end;

     zrese.re:=resf.re;
     zrese.im:=resf.im;
     goto showres;
   }
   {!!!}


//goto endp;
// flSet(fl_PRECISION,fl_DOUBLE);
     *)
  {!!! DEBUG-}



 if  CError = 0 then
 begin

   if F_NoCalc = True  then begin flPerform(fl_FREE,Cardinal(FZ1)); goto endp; end;

   flGet(fl_RESULT_TYPE,0,rt);

   //flPerform(fl_MASK_FPU_EXCEPTION,0);

   if (rt = fl_None)   then
   begin

       if F_SafeCalc = True then
       begin
         // flMaskFPUException; //flPerform(fl_MASK_FPU_EXCEPTION,0);
          NC:=10; T1:=0; T2:=0;
          for ic := 1 to NC do
          begin
            // flResultMaskedFPU(FZ1); if FPUError <> 0 then goto endc;
            Exc:=flResultSafe(FZ1);
            if Exc <> 0 then goto endc;
          end;
       end
       else
       begin
         T1:=GetTickCount;
         for ic:=1 to NC do
         begin
          //flResult(FZ1);
           asm
            call FZ1
           end;
         end;
         T2:=GetTickCount;
       end;


     zrese.re:=resf.re;
     zrese.im:=resf.im;
   end
   else
   begin
      if ((rt = fl_Real) and (ct = fl_Stay_As_Is)) or ((rt = fl_Complex) and (ct = fl_Real)) or  ((rt = fl_Real) and (ct = fl_Real)) then
      begin

       if F_SafeCalc = True then
       begin
         // flMaskFPUException; //flPerform(fl_MASK_FPU_EXCEPTION,0);
          NC:=10; T1:=0; T2:=0;
          for ic := 1 to NC do
          begin
            //  flResultMaskedFpuE(FZ1,zrese.re); if FPUError <> 0 then goto endc;
            Exc:=flResultSafeE(FZ1,zrese.re);
            if Exc <> 0 then goto endc;
          end;
       end
       else
       begin
           T1:=GetTickCount;
           for ic:=1 to NC do
           begin
              asm
                call FZ1
                fstp zrese.re
              end;
           end;
           T2:=GetTickCount;
       end;

    end
      else       //ct = fl_Complex; rt = fl_Real,fl_Complex
      begin


       if F_SafeCalc = True then
       begin
         // flMaskFPUException; //flPerform(fl_MASK_FPU_EXCEPTION,0);
          NC:=10; T1:=0; T2:=0;
          for ic := 1 to NC do
          begin
          // flResultMaskedFpuCxEP(FZ1,@zrese); if FPUError <> 0 then goto endc;
            Exc:=flResultSafeCxEP(FZ1,@zrese);
            if Exc <> 0 then goto endc;
          end;
       end
       else
       begin
           T1:=GetTickCount;
           for ic:=1 to NC do
           begin

           {$IFDEF SAVEREG}
              asm
                mov dbEAX1,eax
                mov dbEBX1,ebx
                mov dbECX1,ecx
                mov dbEDX1,edx
                mov dbESI1,esi
                mov dbEDI1,edi
                mov dbESP1,esp
                mov dbEBP1,ebp
              end;
           {$ENDIF}

    //flSet(fl_PRECISION,fl_EXTENDED);

         //flResultCxEP(FZ1,@zrese);
         //flResultCxE(FZ1,zrese.re,zrese.im);
         //zrese:=zCalcFunctionZE(FZ1);

           asm
              call FZ1
              fstp zrese.re
              fstp zrese.im
            end;


          {$IFDEF SAVEREG}
             asm
                mov dbEAX2,eax
                mov dbEBX2,ebx
                mov dbECX2,ecx
                mov dbEDX2,edx
                mov dbESI2,esi
                mov dbEDI2,edi
                mov dbESP2,esp
                mov dbEBP2,ebp
             end;

             if dbEAX1 <> dbEAX2 then showmessage('EAX');
             if dbEBX1 <> dbEBX2 then showmessage('EBX');
             if dbECX1 <> dbECX2 then showmessage('ECX');
             if dbEDX1 <> dbEDX2 then showmessage('EDX');
             if dbESI1 <> dbESI2 then showmessage('ESI');
             if dbEDI1 <> dbEDI2 then showmessage('EDI');
             if dbESP1 <> dbESP2 then showmessage('ESP');
             if dbEBP1 <> dbEBP2 then showmessage('EBP');
          {$ENDIF}

            end;
            T2:=GetTickCount;

       end;



      end;

      {flGet(fl_IS_FPU_EXCEPTION,0,FpuEx);
	    if(FpuEx = fl_YES) then
      begin
	    	 LFR.Caption:='ERROR';
		     goto endp;
	    end; }
   end;


   showres:
   S1:=FloatToStrF(zrese.re,ffGeneral,20,4,G_FMT);
   S2:=FloatToStrF(zrese.im,ffGeneral,20,4,G_FMT);
   flGet(fl_Result_Type,0, rt);
   if  (ct = fl_Complex) or ((rt = fl_Complex) and (ct = fl_Stay_As_Is)) or (rt = fl_None) then
      LDR.Caption:=S1+'  '+S2+'i' else  LDR.Caption:=S1;



   G_Res.re:=zrese.re; G_Res.im:=zrese.im;



  if not CB_OM.Checked then
    begin if (T2-T1) <> 0 then LDPT.Caption:=IntToStr(Trunc(NC/(T2-T1))) else LDPT.Caption:='no defined'; end;

  LPFT.Caption:=IntToStr(T2-T1);


  // LPFT.Caption:=IntToStr(Length(DExpr));



  ShowCompilationData(FZ1);




 end
 else
 begin
  ShowError;
 end;


endc:
 flPerform(fl_FREE,Cardinal(FZ1));

// flResetMaskFPUException;//flPerform(fl_CLEAR_FPU_EXCEPTION,0);

// if Exc <> 0 then LFR.Caption:=IntToStr(Exc);

 if Exc <> 0 then
 begin
            case Exc of
             fl_ZERO_DIVIDE:              LFR.Caption:='ZERO_DIVIDE';
             fl_INVALID_OPERATION:        LFR.Caption:='INVALID_OPERATION';
             fl_OVERFLOW:                 LFR.Caption:='OVERFLOW';
             fl_ACCESS_VIOLATION:         LFR.Caption:='ACCESS_VIOLATION';
             fl_STACK_OVERFLOW:           LFR.Caption:='STACK_OVERFLOW';
             fl_COMMON_CALCULATON_ERROR:  LFR.Caption:='COMMON_CALCULATON_ERROR';

             fl_YES:                      LFR.Caption:='INVALID_OPERATION';
            end;


 end;

 if FPUError <> 0 then
 begin
     LFR.Caption:='INVALID_OPERATION';
 end;





endp:
end;



procedure TForm1.B_ShowDiffStrClick(Sender: TObject);
label endp;
const fcw: word = $1f32;
//const fw2: word = $1332;
var
Expr: TStringType;

S2,Str,SArg,DExpr: String;
S,S1,DStr,SDiff: String;//TStringType;
St,St1,St2: TStringType;
ndx,ndy: Integer;

T_1,T_2,SB: Cardinal;
Result: Double;
//FuncTest: TExternalFunc;
x1,x2,x3,x4,x5,x6,x7,x8,x9,y1,y2,r1,r2,r3,r4,t1,z1: Double;
res:  extended;//double;
res1: extended;
a1,b1,NC: Cardinal;
//pv1,pv2,pv3: PFloatType;

FS,FS1,FS2,FS3: Pointer;

//FuncTest: TAddFuncStruct;
//Addr: TAddress;
Addr: Cardinal;
//Code,Code1: Cardinal;
AE: array of extended;
ex1,ex2,ex3,ex4,ex5,ex6,ex7,ex8: Extended;
//Atr: TCAttrib;
IC: array of byte;
Ptr,Pr,PtrS: Pointer;
sn1: Single;
dn1: Double;
in1: Integer;
xn1: extended;
CError:Cardinal;
CP,Pk: Cardinal;
Code: Array of byte;
Pb: ^byte;
PC: PChar;
PS:PString;
PAS: PAnsiString;
PAC: PAnsiChar;
PWS: PWideString;
PWC: PWideChar;
Ans: AnsiString;
WS: WideString;
P: Pointer;
//Pkg: TArrayPkg;
//FT: TFunction;
n1,nx: Cardinal;
VNS: TArraySt;
su8: UTF8String;

begin
 (*
 {$IFDEF PANSICHAR}
       ans:=AnsiString(EF.Text); Expr:=PAnsiChar(ans);
 {$ELSE}
       Expr:=TStringType(EF.Text);
 {$ENDIF}

 ndx:=StrToInt(E_DX.Text);
 ndy:=StrToInt(E_DY.Text);
 flSetDiffVar('x');

 T_1:=GetTickCount;

 flSetDiffExpr(Expr);
 flDiffExpr(ndx);
 ndy:=StrToInt(E_DY.Text);
 flSetDiffVar('y');
 flDiffExpr(ndy);

  {$IFDEF STRINGINT}
    flGetDiffString(DExpr);
  {$ELSE}
    flGetDiffString(PtrS);
    ConvStr(PtrS,DExpr);
  {$ENDIF}

 T_2:=GetTickCount;

 L_DFtime.Caption:=IntToStr(T_2-T_1);

 MT.Text:=DExpr;

 *)
 {
 DExpr:='sin(x*y)*y';
 flSetDiffVar('y');
 flCompileDiff(DExpr, 3 , FS);
 flResultE(FS,ex1);
 }


 flSet(fl_Diff_Numeric_Precision,StrToInt(E_NP.Text),StrToInt(E_PH.Text));

 F_Error:=False;
 S1:=EF.Text;

 ndx:=StrToInt(E_DX.Text);
 ndy:=StrToInt(E_DY.Text);
 ndt:=StrToInt(E_DT.Text);
 nds:=StrToInt(E_DS.Text);

 if CB_ND.Checked then
 begin
  NumDiff;
  flGetErrorCode(CError);
  if CError <> 0 then goto endp;
   SArg:='';
   if ndx <> 0 then  SArg:=SArg+'x,';
   if ndy <> 0 then  SArg:=SArg+'y,';
   if ndt <> 0 then  SArg:=SArg+'t,';
   if nds <> 0 then  SArg:=SArg+'s,';
   Delete(SArg,Length(SArg),1);
  S1:='mainexpr('+SArg+')';
 end;




for j := 1 to 4 do
  begin
    case Adv[j].n of
      1:  Adv[j].nd:=ndx;
      2:  Adv[j].nd:=ndy;
      3:  Adv[j].nd:=ndt;
      4:  Adv[j].nd:=nds;
    end;
  end;


       T_1:=GetTickCount;
 {$IFDEF PANSICHAR}
       ans:=AnsiString(s1); pac:=PAnsiChar(ans);

       //if CB_ND.Checked then  flCompileDiff(pac,ndx,FS1) else
       begin
         flSetDiffExpr(pac);
         flGetErrorCode(CError);
       end;
 {$ELSE}
       St:=TStringType(S1);

//       if CB_ND.Checked then  flCompileDiff(St,ndx,FS1) else
       begin
         flSetDiffExpr(St);
         flGetErrorCode(CError);
       end;

 {$ENDIF}
         if CError = 0 then
         begin


            for j := 1 to 4 do
            begin
              if (Adv[j].nd <> 0) and  (CError = 0) then
              begin
                {$IFDEF PANSICHAR}
                     ans:=AnsiString(Adv[j].s); pac:=PAnsiChar(ans);
                     flSetDiffVar(pac);
                {$ELSE}
                    St1:=TStringType(Adv[j].s);
                    flSetDiffVar(St1);
                {$ENDIF}

                //flSetDiffVar(Adv[i].s);
                flDiffExpr(Adv[j].nd);
                flGetErrorCode(CError);
                if CError <> 0 then
                begin
                   F_Error:=True;
                   ShowError;
                   goto endp;
                end;
              end;
            end;

            T_2:=GetTickCount;

            LDFT.Caption:=IntToStr(T_2-T_1);

         end;



  flGetErrorCode(CError);
 //if CError <> 0 then F_Error:=True;
 if CError <> 0 then
 begin
  F_Error:=True;
  ShowError;
 end;



 if (F_Error = False) then
 begin

   {$IFDEF STRINGINT}
    flGetDiffString(Str);
  {$ELSE}
    flGetDiffString(P);
  {$ENDIF}

   DStr:=Str;

   LExprLen.Caption:=IntToStr(Length(DStr));



   //так лучше: сначала копирование строки затем обнуление - поможет избежать возможных ошибок, св€занных с передачей строк (конфликт разных менеджеров пам€ти)
  //it's better: at first,  copying of a string then reset - will help to avoid the possible mistakes connected with transfer of strings  (the conflict of different managers of memory)

  {$IFDEF ANSISTRING}   Ans:=AnsiString(P);    S1:=Copy(Ans,1,Length(Ans)); Ans:=''; DStr:=S1;  {$ENDIF}
  {$IFDEF STRING}       Str:=String(P);        S1:=Copy(Str,1,Length(Str)); Str:=''; DStr:=S1; {$ENDIF}
  {$IFDEF WIDESTRING}   ws:=WideString(P);     S1:=Copy(ws,1,Length(ws));   ws:=''; DStr:=S1; {$ENDIF}
  {$IFDEF UTF8}         su8:=UTF8String(P);    S1:=Copy(Su8,1,Length(Su8)); Su8:=''; DStr:=S1; {$ENDIF}
  {$IFDEF PANSICHAR}    PAC:=PAnsiChar(P);     Ans:=AnsiString(PAC); S1:=Copy(Ans,1,Length(Ans)); Ans:=''; DStr:=S1; {$ENDIF}


 end;

 MT.Text:=DStr;




endp:
end;




procedure TForm1.NumDiff;
var
IDF: Cardinal;
S,SArg: String;
St: TStringType;
PAC: PAnsiChar;
ans: AnsiString;
idfP: TidFunc;
begin
 //if CBND.Checked then
 begin
   SArg:='';
   S:=EF.Text;
   DeleteSpace(S,S);
     if S <> '' then
     begin
      ndx:=StrToInt(E_DX.Text);
      ndy:=StrToInt(E_DY.Text);
      ndt:=StrToInt(E_DT.Text);
      nds:=StrToInt(E_DS.Text);
      if ndx <> 0 then  SArg:=SArg+'x:ext;';
      if ndy <> 0 then  SArg:=SArg+'y:ext;';
      if ndt <> 0 then  SArg:=SArg+'t:ext;';
      if nds <> 0 then  SArg:=SArg+'s:ext;';
      Delete(SArg,Length(SArg),1);

      S:='mainexpr('+SArg+')='+S;
     {$IFDEF PANSICHAR}
       ans:=AnsiString(S); pac:=PAnsiChar(ans);
       flSetFunction(pac,0,@idfP);
       ShowError;
       {flGetErrorCode(Er);
       if Er <> 0 then FException;}
     {$ELSE}
       St:=TStringType(S);
       flSetFunction(St,0,@idfP);
        {flGetErrorCode(Er);
       if Er <> 0 then FException;}
       ShowError;
     {$ENDIF}
    end;
 end;
end;




procedure TForm1.CB_OPClick(Sender: TObject);
begin
 if CB_OP.Checked  then
 begin
   flSet(fl_Enable,fl_Optimization,0)  ;

   CB_MULDIV.Checked:=True;
   CB_CalcConstMulDiv.Checked :=True;
   CB_CalcConstInTree.Checked:=True;
   CB_CalcConstWholeExpr.Checked :=True;
   CB_IntArg.Checked:=True;
   CB_CalcConstFunc.Checked:=True;
   //CB_FD.Checked :=True;
   RB_ZDiv_Fast.Checked:=True;
   CB_RF.Checked :=True;
   CB_RV.Checked:=True;
   CB_RFCS.Checked :=True;
   CB_DIV.Checked :=True;
   CB_MUL.Checked :=True;
   CB_RAS.Checked  :=True;
   CB_RME.Checked :=True;
   CB_RedArg.Checked:=True;
   CB_DelZeroBranch.Checked:=True;
   CB_SKIF.Checked:=True;

   RB_XbAuto.Checked:=True;
   RB_DLEnable.Checked:=True;

   UDSD.Position:=8;
   Panel1.Caption:=IntToStr(UDSD.Position);
   flSet(fl_STACK_DEEP,UDSD.Position,0);

   //flSet(fl_STACK_DEEP,UDSD.Position,0);
 end
 else
 begin
   flSet(fl_Disable,fl_Optimization,0); {fzOptimization(True) else fzOptimization(False)};

   CB_MULDIV.Checked:=False;
   CB_CalcConstMulDiv.Checked :=False;
   CB_CalcConstInTree.Checked:=False;
   CB_CalcConstWholeExpr.Checked :=False;
   CB_IntArg.Checked:=False;
   CB_CalcConstFunc.Checked:=False;
   //CB_FD.Checked :=False;
   //RB_ZDiv_Fast.Checked:=False;

   //RB_ZDiv_STD.Checked:=True;
   case G_ZDIV  of
        2: RB_ZDiv_STD.Checked:=True;
        3: RB_ZDiv_ACC.Checked:=True;
        4: RB_ZDiv_Extra.Checked:=True;
   end;

   CB_RF.Checked :=False;
   CB_RV.Checked:=False;
   CB_RFCS.Checked :=False;
   CB_DIV.Checked :=False;
   CB_MUL.Checked :=False;
   CB_RAS.Checked :=False;
   CB_RME.Checked:=False;
   CB_RedArg.Checked:=False;
   CB_DelZeroBranch.Checked:=False;
   CB_SKIF.Checked:=False;

   RB_XBdisable.Checked:=True;
   RB_DLDisable.Checked:=True;

   UDSD.Position:=0;
   Panel1.Caption:=IntToStr(UDSD.Position);
   flSet(fl_STACK_DEEP,UDSD.Position,0);

 end;

end;


procedure TForm1.CB_PackageClick(Sender: TObject);
begin
  if CB_Package.Checked then flSet(fl_Enable,fl_ALL_REPLACE,0) else flSet(fl_Disable,fl_ALL_REPLACE,0);
end;

procedure TForm1.CB_PCInlineClick(Sender: TObject);
begin
  if CB_PCInline.Checked then flSet(fl_Enable,fl_INSERT_INLINE,0) else flSet(fl_Disable,fl_INSERT_INLINE,0);
end;

procedure TForm1.CB_DIVClick(Sender: TObject);
begin
 if CB_DIV.Checked then flSet(fl_Enable,fl_REPLACE_DIV,0) else flSet(fl_Disable,fl_REPLACE_DIV,0);
end;


procedure TForm1.CB_DRLClick(Sender: TObject);
begin
if CB_DRL.Checked  then flSet(fl_Disable,fl_REPLACE_AT_IF,0) else flSet(fl_Enable,fl_REPLACE_AT_IF,0);
end;


procedure TForm1.CB_ExtComClick(Sender: TObject);
begin
 if CB_ExtCom.Checked then flSet(fl_Enable,fl_EXTENDED_COMMAND,0) else flSet(fl_Disable,fl_EXTENDED_COMMAND,0);
end;

procedure TForm1.CB_IntArgClick(Sender: TObject);
begin
if CB_IntArg.Checked then
begin
   flSet(fl_ENABLE,fl_INTEGER_OPTIMIZATION,0 );
   flSet(fl_ENABLE,fl_INTEGER_OPTIMIZATION_EXT_FUNC,0)
end
else
begin
   flSet(fl_DISABLE,fl_INTEGER_OPTIMIZATION ,0);
   flSet(fl_DISABLE,fl_INTEGER_OPTIMIZATION_EXT_FUNC,0)
end;

end;

procedure TForm1.CB_LeadToLowerClick(Sender: TObject);
begin
 if CB_LeadToLower.Checked then  flSet(fl_Enable,fl_LEAD_TO_LOWER_CASE,0) else flSet(fl_Disable,fl_LEAD_TO_LOWER_CASE,0);
end;


procedure TForm1.CB_LGC_NamesClick(Sender: TObject);
begin
   flPerform(fl_Connect,fl_LOGIC_OPERATIONS_BY_NAMES);

   CB_LGC_Names.Enabled:=False;
   CB_LGC_Symbs.Enabled:=False;
end;


procedure TForm1.CB_LGC_SYMBSClick(Sender: TObject);
begin
   flPerform(fl_Connect,fl_LOGIC_OPERATIONS_BY_SYMBOLS);

   CB_LGC_Names.Enabled:=False;
   CB_LGC_Symbs.Enabled:=False;
end;

procedure TForm1.CB_ControlSpaceClick(Sender: TObject);
begin
 if CB_ControlSpace.Checked then flSet(fl_Enable,fl_CHECK_INCORRECT_SPACE,0) else flSet(fl_Disable,fl_CHECK_INCORRECT_SPACE,0);
end;



procedure TForm1.CB_MaskFPUClick(Sender: TObject);
begin
  if CB_MaskFPU.Checked then flSet(fl_Enable,fl_MASK_FPU_EXCEPTION,0) else flSet(fl_Disable,fl_MASK_FPU_EXCEPTION,0);
end;

procedure TForm1.CB_MULClick(Sender: TObject);
begin
  if CB_MUL.Checked then flSet(fl_Enable,fl_REPLACE_MUL,0) else flSet(fl_Disable,fl_REPLACE_MUL,0);
end;


procedure TForm1.CB_MULDIVClick(Sender: TObject);
begin
  if CB_MULDIV.Checked then flSet(fl_Enable,fl_OPTIMIZATION_MUL_DIV,0) else flSet(fl_Disable,fl_OPTIMIZATION_MUL_DIV,0);
end;

procedure TForm1.CB_NoCalcClick(Sender: TObject);
begin
   if CB_NoCalc.Checked then F_NoCalc:=True else F_NoCalc:=False;
end;

procedure TForm1.CB_RASClick(Sender: TObject);
begin
  if CB_RAS.Checked then flSet(fl_Enable,fl_REPLACE_ADDSUB,0) else flSet(fl_Disable,fl_REPLACE_ADDSUB,0);
end;

procedure TForm1.CB_RedArgClick(Sender: TObject);
begin
if CB_RedArg.Checked  then
 begin
   flSet(fl_Enable,fl_REDUCE_CONST_ARG,0);
   flSet(fl_Enable,fl_REDUCE_CONST_ARG_F,0);
 end
 else
 begin
    flSet(fl_Disable,fl_REDUCE_CONST_ARG,0);
    flSet(fl_Disable,fl_REDUCE_CONST_ARG_F,0);
 end;



end;

procedure TForm1.CB_RVClick(Sender: TObject);
begin
if CB_RV.Checked  then flSet(fl_Enable,fl_REPLACE_ARRAYS,0) else flSet(fl_Disable,fl_REPLACE_ARRAYS,0);
end;

procedure TForm1.CB_RFClick(Sender: TObject);
begin
 if CB_RF.Checked  then flSet(fl_Enable,fl_REPLACE_FUNCTIONS,0) else flSet(fl_Disable,fl_REPLACE_FUNCTIONS,0);
end;

procedure TForm1.CB_RFCSClick(Sender: TObject);
begin
 if CB_RFCS.Checked  then flSet(fl_Enable,fl_REPLACE_COMPOSITE_FUNCTIONS,0) else flSet(fl_Disable,fl_REPLACE_COMPOSITE_FUNCTIONS,0);
end;

procedure TForm1.CB_RMEClick(Sender: TObject);
begin
 if CB_RME.Checked  then flSet(fl_Enable,fl_REPLACE_MULTI_EXPR,0) else flSet(fl_Disable,fl_REPLACE_MULTI_EXPR,0);
end;




procedure TForm1.CB_SafeCalcClick(Sender: TObject);
begin
    if CB_SafeCalc.Checked  then  F_SafeCalc:=True else  F_SafeCalc:=False;
end;

procedure TForm1.CB_ShowDiffClick(Sender: TObject);
begin
if CB_ShowDiff.Checked then B_ShowDiffStr.Enabled:=True else  B_ShowDiffStr.Enabled:=False;

end;

procedure TForm1.CB_SKIFClick(Sender: TObject);
begin
 if CB_SKIF.Checked  then flSet(fl_Enable,fl_SKIPPED_IF,0) else flSet(fl_Disable,fl_SKIPPED_IF,0);
end;



procedure TForm1.CB_VirtAllocClick(Sender: TObject);
begin
 if CB_VirtAlloc.Checked  then flSet(fl_Enable,fl_USE_VIRTUAL_ALLOC,0 ) else flSet(fl_Disable,fl_USE_VIRTUAL_ALLOC,0);
end;



procedure TForm1.CB_VCxClick(Sender: TObject);
var
ct: cardinal;
begin

if CB_VCx.Checked = True then
begin
 if RB_FVD.Checked  then
   begin
     flSetVar('x',@zxd,fl_Complex_Double);
     flSetVar('y',@zyd,fl_Complex_Double);
     flSetVar('t',@ztd,fl_Complex_Double);
     flSetVar('s',@zsd,fl_Complex_Double);
   end
 else
 begin
     flSetVar('x',@zxe,fl_Complex_Extended);
     flSetVar('y',@zye,fl_Complex_Extended);
     flSetVar('t',@zte,fl_Complex_Extended);
     flSetVar('s',@zse,fl_Complex_Extended);
 end
end
else
begin

 if RB_FVD.Checked  then
   begin
     flSetVar('x',@xd,fl_Real_Double);
     flSetVar('y',@yd,fl_Real_Double);
     flSetVar('t',@td,fl_Real_Double);
     flSetVar('s',@sd,fl_Real_Double);
   end
 else
 begin
     flSetVar('x',@xe,fl_Real_Extended);
     flSetVar('y',@ye,fl_Real_Extended);
     flSetVar('t',@te,fl_Real_Extended);
     flSetVar('s',@se,fl_Real_Extended);
 end



end;

end;



procedure TForm1.CB_AccFuncClick(Sender: TObject);
begin
  if CB_AccFunc.Checked then
  begin
     flSet(fl_STD_FUNC,fl_ACCURATE,0);
     flSet(fl_SPEC_FUNC,fl_ACCURATE,0);
  end
  else
  begin
     flSet(fl_STD_FUNC,fl_FAST,0);
     flSet(fl_SPEC_FUNC,fl_FAST,0);
  end;
end;

procedure TForm1.CB_Actg_TypeClick(Sender: TObject);
begin
 if CB_Actg_Type.Checked  then
     flSet(fl_ARCCOTAN_TYPE,fl_ARCCOTAN_1DIV_ARG,0)
  else
      flSet(fl_ARCCOTAN_TYPE,fl_ARCCOTAN_STD,0);

end;

procedure TForm1.CB_CalcConstFuncClick(Sender: TObject);
begin
if CB_CalcConstFunc.Checked then
begin
 flSet(fl_ENABLE,fl_CALC_CONST_FUNC,0);
 flSet(fl_ENABLE,fl_CALC_CONST_EXT_FUNC,0);
end
else
begin
 flSet(fl_DISABLE,fl_CALC_CONST_FUNC,0);
 flSet(fl_DISABLE,fl_CALC_CONST_EXT_FUNC,0);
end;
end;

procedure TForm1.CB_CalcConstInTreeClick(Sender: TObject);
begin
if CB_CalcConstInTree.Checked then
begin
  //flSet(fl_Enable,fl_CALC_CONST_EXPRESSION,0)
 //flSet(fl_ENABLE,fl_CALC_CONST_MUL_DIV,0);
 flSet(fl_ENABLE,fl_CALC_CONST_ARG,0);
 //flSet(fl_ENABLE,fl_CALC_CONST_FUNC,0);
 //flSet(fl_ENABLE,fl_CALC_CONST_EXT_FUNC,0);
end
else
begin
 //flSet(fl_Disable, fl_CALC_CONST_EXPRESSION,0);
 //flSet(fl_DISABLE,fl_CALC_CONST_MUL_DIV,0);
 flSet(fl_DISABLE,fl_CALC_CONST_ARG,0);
 //flSet(fl_DISABLE,fl_CALC_CONST_FUNC,0);
 //flSet(fl_DISABLE,fl_CALC_CONST_EXT_FUNC,0);
end;
end;


procedure TForm1.CB_CalcConstMulDivClick(Sender: TObject);
begin
if CB_CalcConstMulDiv.Checked then
begin
 flSet(fl_ENABLE,fl_CALC_CONST_MUL_DIV,0);
end
else
begin
 flSet(fl_DISABLE,fl_CALC_CONST_MUL_DIV,0);
end;
end;


procedure TForm1.CB_CalcConstWholeExprClick(Sender: TObject);
begin

if CB_CalcConstWholeExpr.Checked then
                          flSet(fl_Enable,fl_CALC_CONST_EXPRESSION,0) else
                          flSet(fl_Disable, fl_CALC_CONST_EXPRESSION,0);
end;


procedure TForm1.CB_CXAnyAddrClick(Sender: TObject);
begin

 if CB_CXAnyAddr.Checked then
 begin
   if RB_FVD.Checked then
   begin
     flSetVarCX('z1',@CxVarAnyRE_D[z1re],@CxVarAnyIM_D[z1im],fl_Complex_Double);
     flSetVarCX('z2',@CxVarAnyRE_D[z2re],@CxVarAnyIM_D[z2im],fl_Complex_Double);
     flSetVarCX('z3',@CxVarAnyRE_D[z3re],@CxVarAnyIM_D[z3im],fl_Complex_Double);
   end
   else
   if  RB_FVE.Checked then
   begin
     flSetVarCX('z1',@CxVarAnyRE_E[z1re],@CxVarAnyIM_E[z1im],fl_Complex_Extended);
     flSetVarCX('z2',@CxVarAnyRE_E[z2re],@CxVarAnyIM_E[z2im],fl_Complex_Extended);
     flSetVarCX('z3',@CxVarAnyRE_E[z3re],@CxVarAnyIM_E[z3im],fl_Complex_Extended);
   end
   else
   if  RB_FVS.Checked then
   begin
     flSetVarCX('z1',@CxVarAnyRE_S[z1re],@CxVarAnyIM_S[z1im],fl_Complex_Single);
     flSetVarCX('z2',@CxVarAnyRE_S[z2re],@CxVarAnyIM_S[z2im],fl_Complex_Single);
     flSetVarCX('z3',@CxVarAnyRE_S[z3re],@CxVarAnyIM_S[z3im],fl_Complex_Single);
   end
 end
 else
 begin
   if RB_FVD.Checked then
   begin
      flSetVar('z1',@z1d,fl_Complex_Double);
      flSetVar('z2',@z2d,fl_Complex_Double);
      flSetVar('z3',@z3d,fl_Complex_Double);
   end
   else
   if  RB_FVE.Checked then
   begin
     flSetVar('z1',@z1e,fl_complex_Extended);
     flSetVar('z2',@z2e,fl_complex_Extended);
     flSetVar('z3',@z3e,fl_complex_Extended);
   end
   else
   if  RB_FVS.Checked then
   begin
     flSetVar('z1',@z1s,fl_complex_Single);
     flSetVar('z2',@z2s,fl_complex_Single);
     flSetVar('z3',@z3s,fl_complex_Single);
   end;
 end;

end;



procedure TForm1.CB_DCEMClick(Sender: TObject);
begin
 if CB_DCEM.Checked then   flSet(fl_Disable,fl_CALC_CONST_EXPR_IN_MULTI_EXPR,0) else
                           flSet(fl_Enable, fl_CALC_CONST_EXPR_IN_MULTI_EXPR,0);
end;

procedure TForm1.CB_DCRClick(Sender: TObject);
begin
 if CB_DCR.Checked then   flSet(fl_Disable,fl_REPLACE_COMPOSITE_FUNCTIONS_REAL,0) else
                          flSet(fl_Enable,fl_REPLACE_COMPOSITE_FUNCTIONS_REAL,0);

end;


procedure TForm1.CB_DCZClick(Sender: TObject);
begin
 if CB_DCZ.Checked then    flSet(fl_Disable,fl_REPLACE_COMPOSITE_FUNCTIONS_COMPLEX,0)  else
                           flSet(fl_Enable,fl_REPLACE_COMPOSITE_FUNCTIONS_COMPLEX,0);


end;


procedure TForm1.CB_DelZeroBranchClick(Sender: TObject);
begin
  if CB_DelZeroBranch.Checked then   flSet(fl_Enable,fl_DELETE_ZERO_BRANCH,0) else
                           flSet(fl_Disable,fl_DELETE_ZERO_BRANCH,0);
end;

procedure TForm1.CB_DestroyClick(Sender: TObject);
begin
   flPerform(fl_Destroy,0);
   DestroyForm;

   CB_LGC_SYMBS.Checked:=False;
   CB_LGC_Names.Checked:=False;
   CB_LGC_SYMBS.Enabled:=True;
   CB_LGC_Names.Enabled:=True;

   CB_Destroy.Enabled:=False;
   CB_Create.Enabled:=True;
end;


procedure TForm1.CB_CreateClick(Sender: TObject);
begin
    flPerform(fl_Create,0);
    CreateForm;
    CB_Destroy.Enabled:=True;
    CB_Create.Enabled:=False;
end;



procedure TForm1.CB_DFvarsClick(Sender: TObject);
begin
  if CB_DFvars.Checked  then
  begin
     Adv[1].n:=1;  Adv[1].s:='z1';  Adv[1].nd:=1;
     Adv[2].n:=2;  Adv[2].s:='z2';  Adv[2].nd:=0;
     Adv[3].n:=3;  Adv[3].s:='z3';  Adv[3].nd:=0;
     //Adv[4].n:=4;  Adv[4].s:='z';  Adv[4].nd:=0;
     Label_dx.Caption:='dz1';      Label_dxn.Left:=Label_dxn.Left+5;
     Label_dy.Caption:='dz2';      Label_dyn.Left:=Label_dyn.Left+6;
     Label_dt.Caption:='dz3';      Label_dtn.Left:=Label_dtn.Left+7;
  end
  else
  begin
     InitDF;
     Label_dx.Caption:='dx';  Label_dxn.Left:=Label_dxn.Left-5;
     Label_dy.Caption:='dy';  Label_dyn.Left:=Label_dyn.Left-6;
     Label_dt.Caption:='dt';  Label_dtn.Left:=Label_dtn.Left-7;
     L_DO.Caption:='dx, dy, dt, ds';
  end;
end;



procedure TForm1.EXChange(Sender: TObject);
begin
 xd:=StrToFloat(EX.Text,G_FMT);
 xe:=StrToFloat(EX.Text,G_FMT);
 xs:=StrToFloat(EX.Text,G_FMT);

 zxd.re:=xd;
 zxe.re:=xe;
 zxs.re:=xs;
end;


procedure TForm1.EYChange(Sender: TObject);
begin
  yd:=StrToFloat(EY.Text,G_FMT);
  ye:=StrToFloat(EY.Text,G_FMT);
  ys:=StrToFloat(EY.Text,G_FMT);

  zyd.re:=yd;
  zye.re:=ye;
  zys.re:=ys;
end;




procedure TForm1.ENChange(Sender: TObject);
begin
 n:=StrToInt(En.Text);
end;

procedure TForm1.ETChange(Sender: TObject);
begin
 td:=StrToFloat(ET.Text,G_FMT);
 te:=StrToFloat(ET.Text,G_FMT);
 ts:=StrToFloat(ET.Text,G_FMT);

  ztd.re:=td;
  zte.re:=te;
  zts.re:=ts;
end;

procedure TForm1.EJChange(Sender: TObject);
begin
j:=StrToInt(Ej.Text);
end;

procedure TForm1.EKChange(Sender: TObject);
begin
  k:=StrToInt(Ek.Text);
end;

procedure TForm1.EA0Change(Sender: TObject);
begin
ad[0]:=StrToFloat(EA0.Text,G_FMT);
ade[0]:=StrToFloat(EA0.Text,G_FMT);
end;

procedure TForm1.EA1Change(Sender: TObject);
begin
ad[1]:=StrToFloat(EA1.Text,G_FMT);
ade[1]:=StrToFloat(EA1.Text,G_FMT);
end;

procedure TForm1.EA2Change(Sender: TObject);
begin
ad[2]:=StrToFloat(EA2.Text,G_FMT);
ade[2]:=StrToFloat(EA2.Text,G_FMT);
end;


procedure TForm1.EAimChange(Sender: TObject);
begin
  Acx.im:=StrToFloat(EAim.Text,G_FMT);
  flSetParamE('ai',Acx.re,Acx.im,fl_Complex);
end;

procedure TForm1.EAreChange(Sender: TObject);
begin
 Ae:=StrToFloat(EAre.Text,G_FMT);
 Acx.re:=Ae;

 flSetParamE('a',Ae,0,fl_Real);
 flSetParamE('ai',Acx.re,Acx.im,fl_Complex);
end;

procedure TForm1.EBimChange(Sender: TObject);
begin
 Bcx.im:=StrToFloat(EBim.Text,G_FMT);
 flSetParamE('bi',Bcx.re,Bcx.im,fl_Complex);
end;

procedure TForm1.EBreChange(Sender: TObject);
begin
 Be:=StrToFloat(EBre.Text,G_FMT);
 Bcx.re:=Be;

 flSetParamE('b',Be,0,fl_Real);
 flSetParamE('bi',Bcx.re,Bcx.im,fl_Complex);
end;

procedure TForm1.ECimChange(Sender: TObject);
begin
  Ccx.im:=StrToFloat(ECim.Text,G_FMT);
  flSetParamE('ci',Ccx.re,Ccx.im,fl_Complex);
end;

procedure TForm1.ECreChange(Sender: TObject);
begin
 Ce:=StrToFloat(ECre.Text,G_FMT);
 Ccx.re:=Ce;

 flSetParamE('c',Ce,0,fl_Real);
 flSetParamE('ci',Ccx.re,Ccx.im,fl_Complex);
end;


procedure TForm1.ETestChange(Sender: TObject);
begin
CntExpr:=StrToInt(ETest.Text);
end;




procedure TForm1.CompilePC;
label 1,2,endp;
var
i,j: Integer;
FS:TAddFuncStruct;
FN: String;
S,S1: String;
LVT: TArrayC;
VN,VT,RT: Integer;
Er: Cardinal;
ans: AnsiString;
PAC: PAnsiChar;
Error: Cardinal;
Expr:TStringType;
idfP:  TidFunc;//Pointer ;
begin
//InitFuncStruct(FS);
//FS.ArgType:=fl_real_double;
//FS.ResultType:=fl_real;
//FS.CallFunc:=fl_PRECOMPILED;


  for i:=0 to FDFN.MA.Lines.Capacity-1 do
  begin
    S:=FDFN.MA.Lines[i];
    DeleteSpace(S,S1);
    if S1 = '' then goto 1;
    {$IFDEF PANSICHAR}
       ans:=AnsiString(S);
       Expr:=PAnsiChar(ans);
     {$ELSE}
        Expr:=TStringType(S);
     {$ENDIF}

       flSetFunction(Expr,0,@idfP);
       flGetErrorCode(Error);
       if Error <> 0 then
       begin
        ShowError;
        goto endp;
       end;

    1:
  end;

endp:
end;





procedure CreateIntArray;
begin
SetLength(Aint,15);  SetLength(Bint,15);
 Aint[0]:=0.03075324199611726835; Aint[1]:=0.07036604748810812471;
 Aint[2]:=0.10715922046717193501; Aint[3]:=0.13957067792615431445;
 Aint[4]:=0.16626920581699393355; Aint[5]:=0.18616100001556221103;
 Aint[6]:=0.19843148532711157646; Aint[7]:=0.20257824192556127288;
 Aint[8]:=Aint[6];  Aint[9]:=Aint[5];  Aint[10]:=Aint[4]; Aint[11]:=Aint[3];
 Aint[12]:=Aint[2]; Aint[13]:=Aint[1];  Aint[14]:=Aint[0];
 Bint[0]:=0.98799251802048542849; Bint[1]:=0.93727339240070590431;
 Bint[2]:=0.84820658341042721620; Bint[3]:=0.72441773136017004742;
 Bint[4]:=0.57097217260853884754; Bint[5]:=0.39415134707756336990;
 Bint[6]:=0.20119409399743452230; Bint[7]:=0;
 Bint[8]:=-Bint[6]; Bint[9]:=-Bint[5]; Bint[10]:=-Bint[4]; Bint[11]:=-Bint[3];
 Bint[12]:=-Bint[2];Bint[13]:=-Bint[1]; Bint[14]:=-Bint[0];
end;


(*
Test1F(VE1,VE2: array  extended; x1,x2: extended)=

L1:int=Len(VE1);
L2:int=Len(VE2);
r1:ext=0; r2:ext=0; r:ext=0;
i1:int=0;i2:int=0;i3:int=0;
x:ext=0;   y:ext=0;

for(i1,0,L1-1,
     for(i2,0,L2-1,
         x=VE1[i1]; y=VE2[i2];
         ifp(((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or (cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))),
             r1=r1+sin(x)*cos(y)/(sin(x)+cos(y)+1);
             r2=r2+sin(x)*(sin(y)-cos(y));
             //r=r1-r2;
             r=sin(r1)+cos(r2)+sin(r)+cos(r);
             ,
             r1=sin(r1)*(sin(r2)+cos(r2)*cos(r1));
             r2=cos(r1)*(cos(r2)+sin(r2)*sin(r1));
             r=sin(r1)+cos(r2)+sin(r)+cos(r);
            );
         ifp((sin(cos(VE1[i1]-VE2[i2]))*cos(sin(VE1[i1])) >= cos(sin(VE1[i1]+VE2[i2]))*sin(cos(VE2[i2]))) or ( sin(x1*cos(VE1[i1])) <= cos(x2*sin(VE2[i2]))) and (cos(x1*sin(x2)+x2*sin(x1))*sin(cos(x1)+sin(x2)) > cos(VE1[i1]-VE2[i2])*sin(VE2[i2]+VE1[i1]) ),
            ifp(VE1[i1] > VE2[i2],
              r1=r1*(sin(VE1[i2])*cos(x)*sin(VE2[i1])*cos(y));
              r2=r2*(sin(VE1[i2])*cos(x)*sin(VE2[i1])*cos(y));
              //r=r1+r2;
              r=sin(r1)+cos(r2)+sin(r)+cos(r);
               );
             ,
              ifp(i2 > 3*i1+1,
                  r1=r1+(sin(VE1[i2-2*i1])*cos(VE2[i2-2*i1]))/(sin(VE1[i2-2*i1])+cos(VE2[i2-2*i1])+1) ;
                  r2=r2+(sin(VE1[i2-2*i1])-cos(VE2[i2-2*i1]))/(sin(VE1[i2-2*i1])+cos(VE2[i2-2*i1])+1) ;
                  //r=r1+r2;
                  r=sin(r1)+cos(r2)+sin(r)+cos(r);
                  ,
                  ifp(i2 > i1+3,
                      r1=r1+sin(VE1[i2-i1-1])*cos(VE2[i2-i1-1])/(sin(x)-cos(y)+sin(VE1[i2-i1-1])-cos(VE2[i2-i1-1]));
                      r2=r2+sin(VE1[i2-i1-1])*cos(VE2[i2-i1-1])/(sin(x)+cos(y)-(sin(VE1[i2-i1-1])*cos(VE2[i2-i1-1])));
                      //r=r1+r2;
                      r=sin(r1)+cos(r2)+sin(r)+cos(r);
                      ,
                      for(i3,0,i2-i1,
                           ifp((sin(r1-r2)*cos(r1+r2) > cos(r1-r2)*sin(r1+r2)) and  ( (cos(sin(r1+r2))*sin(cos(r1-r2)) < sin(cos(r1+r2))*cos(sin(r1-r2))) or (sin(r1*cos(r1+r2)) > cos(r2*sin(r1-r2))) ),
                                r1=sin(r1-r2)*cos(r1-r2)+sin(r2-r1)*cos(r2-r1);
                                r2=cos(r1-r2)*cos(r2-r1)+sin(r2-r1)*sin(r1-r2);
                                r=sin(r1)+cos(r2)+sin(r)+cos(r);
                                ,
                                ifp(i3 > i1,
                                     r1=r1-(sin(VE1[i3])*cos(VE2[i3]))/(sin(VE2[i3])-cos(VE1[i3]));
                                     r2=r2-(sin(VE1[i3])*cos(VE2[i3]))/(sin(VE2[i3])+cos(VE1[i3]));
                                     r=sin(r1)+cos(r2)+sin(r)+cos(r);
                                   )
                              )

                         )

                     )

                 )

            )

        );

   );
r;
*)


function  TForm1.Test1F(VE1,VE2: array of extended; x1,x2: extended):extended;
var

 i1,i2,i3,L1,L2: Integer;
 x,y,r1,r2,r: extended;
begin


L1:=Length(VE1);
L2:=Length(VE2);
r1:=0;
r2:=0;
r:=0;

for i1 := 0 to L1 - 1 do
begin
  for i2 := 0 to  L2 - 1 do
  begin
    x:=VE1[i1]; y:=VE2[i2];
    if ((sin(x+y)*cos(x-y) > sin(cos(y)*x)*sin(x+y)) or (sin(cos(x)+sin(y)) >= cos(y*sin(x*cos(x*y))))) and ((sin(x*y) <= cos(y+x)) or (cos(x-y)*cos(x+y) <= cos(x*sin(y)+y*sin(x))*sin(cos(x)+sin(y)))) then
    begin
      r1:=r1+sin(x)*cos(y)/(sin(x)+cos(y)+1);
      r2:=r2+sin(x)*(sin(y)-cos(y));
      //r:=r1-r2;
      r:=sin(r1)+cos(r2)+sin(r)+cos(r);
    end
    else
    begin
     r1:=sin(r1)*(sin(r2)+cos(r2)*cos(r1));
     r2:=cos(r1)*(cos(r2)+sin(r2)*sin(r1));
     r:=sin(r1)+cos(r2)+sin(r)+cos(r);
    end;

    if (sin(cos(VE1[i1]-VE2[i2]))*cos(sin(VE1[i1])) >= cos(sin(VE1[i1]+VE2[i2]))*sin(cos(VE2[i2]))) or ( sin(x1*cos(VE1[i1])) <= cos(x2*sin(VE2[i2]))) and (cos(x1*sin(x2)+x2*sin(x1))*sin(cos(x1)+sin(x2)) > cos(VE1[i1]-VE2[i2])*sin(VE2[i2]+VE1[i1]) )  then
    begin
       if VE1[i1] > VE2[i2] then
       begin
         r1:=r1*(sin(VE1[i2])*cos(x)*sin(VE2[i1])*cos(y));
         r2:=r2*(sin(VE1[i2])*cos(x)*sin(VE2[i1])*cos(y));
         //r:=r1+r2;
         r:=sin(r1)+cos(r2)+sin(r)+cos(r);
       end;
    end
    else
    begin
      if i2 > 3*i1+1 then
      begin
        r1:=r1+(sin(VE1[i2-2*i1])*cos(VE2[i2-2*i1]))/(sin(VE1[i2-2*i1])+cos(VE2[i2-2*i1])+1) ;
        r2:=r2+(sin(VE1[i2-2*i1])-cos(VE2[i2-2*i1]))/(sin(VE1[i2-2*i1])+cos(VE2[i2-2*i1])+1) ;
        //r:=r1+r2;
        r:=sin(r1)*sin(r2)+cos(r)*sin(r1);
      end
      else
      if i2 > i1+3 then
      begin
         r1:=r1+sin(VE1[i2-i1-1])*cos(VE2[i2-i1-1])/(sin(x)-cos(y)+sin(VE1[i2-i1-1])-cos(VE2[i2-i1-1]));
         r2:=r2+sin(VE1[i2-i1-1])*cos(VE2[i2-i1-1])/(sin(x)+cos(y)-(sin(VE1[i2-i1-1])*cos(VE2[i2-i1-1])));
         //r:=r1+r2;
         r:=sin(r1)+cos(r2)+sin(r)+cos(r);
      end
      else
      begin

        for i3 := 0 to i2-i1 do
          begin

             if (sin(r1-r2)*cos(r1+r2) > cos(r1-r2)*sin(r1+r2)) and  ( (cos(sin(r1+r2))*sin(cos(r1-r2)) < sin(cos(r1+r2))*cos(sin(r1-r2))) or (sin(r1*cos(r1+r2)) > cos(r2*sin(r1-r2))) )then
             begin
               r1:=sin(r1-r2)*cos(r1-r2)+sin(r2-r1)*cos(r2-r1);
               r2:=cos(r1-r2)*cos(r2-r1)+sin(r2-r1)*sin(r1-r2);
               r:=sin(r1)+cos(r2)+sin(r)+cos(r);
             end
             else
             if i3 > i1 then
             begin
               r1:=r1-(sin(VE1[i3])*cos(VE2[i3]))/(sin(VE2[i3])-cos(VE1[i3]));
               r2:=r2-(sin(VE1[i3])*cos(VE2[i3]))/(sin(VE2[i3])+cos(VE1[i3]));
               r:=sin(r1)+cos(r2)+sin(r)+cos(r);
             end;

          end;

      end;

    end;


  end;

end;

Test1F:=r;
end;


//r:dbl=0; L:int=len(vd1); i: int=0; j:int=0; k:int=0; for(i,0,L-1,for(j,0,L-1,ifp(j>i,for(k,i+j,L-1,ifp((k+i <= L-1) and (k+j <= L-1),r=vd1[k+i]-vd2[k+j]*vd3[k]+r;); ifp((((k+j-3*i) >= 0)  and ((k+j-3*i) <= L-1)) and ((2*k+1) <= L-1),r=r-vd3[2*k-1]+vd2[k+j-3*i]*vd1[2*k]);)))); r

function Test2F: double;
var
i,j,k,L: Integer;
r: double;
begin
L:=Length(vd1);
r:=0;

for i := 0 to L - 1 do
begin
  for j := 0 to L - 1 do
  begin

    if j > i then
    begin
      for k := i+j to L - 1 do
      begin
        if (k+i <= L-1) and (k+j <= L-1) then
           r:=vd1[k+i]-vd2[k+j]*vd3[k]+r;

        if (((k+j-3*i) >= 0)  and ((k+j-3*i) <= L-1)) and ((2*k+1) <= L-1) then
           r:=r-vd3[2*k-1]+vd2[k+j-3*i]*vd1[2*k]

      end;
    end;

  end;
end;
 Test2F:=r;
end;




{
procedure TForm1.InitTestM;
var
RN,i,p1,p2,s1,s2,nx: Integer;
x1,x2,r: extended;
begin
s1:=90;
s2:=150;
p1:=1;
p2:=100;

  RN:=trunc((s1-s2)*random+s2);
  SetLength(XVE1,RN);
  SetLength(XVE2,RN);

  randomize;

  for i:=0 to RN-1 do
  begin
    XVE1[i]:=(p1-p2)*random+p2;
    XVE2[i]:=(p1-p2)*random+p2;
  end;

  nx:=trunc(RN*random);
  x1:=XVE1[nx];
  nx:=trunc(RN*random);
  x2:=XVE2[nx];



end;
}



procedure TForm1.TestM1F;
label nxt;
var
RN,i,p1,p2,s1,s2,nx,cnt: Integer;
x1,x2,r1,r2,x,y,dr: extended;
FS1: Pointer;

begin
s1:=90;
s2:=150;
p1:=1;
p2:=100;
flSet(fl_Result_Type, fl_Real,0);
flSet(fl_Enable,fl_Show_Exception,0);
flCompile('Test1F(VE1,VE2,ex,ey)',0,FS1);


cnt:=0;
nxt:
  RN:=trunc((s1-s2)*random+s2);
  SetLength(VE1,RN);
  SetLength(VE2,RN);

  randomize;

  for i:=0 to RN-1 do
  begin
    VE1[i]:=(p1-p2)*random+p2;
    VE2[i]:=(p1-p2)*random+p2;
  end;

  nx:=trunc(RN*random);
  x:=VE1[nx];      xe:=x;
  nx:=trunc(RN*random);
  y:=VE2[nx];      ye:=y;

  r1:=Test1F(VE1,VE2,x,y);
  flResultE(FS1,r2);

  inc(cnt);
  dr:=r1-r2;
  if dr = 0 then goto nxt
  else
  begin
   showMessage(' dr =  '+FloatToStr(dr)+'  resf =   '+FloatToStr(r1)+ '  count= '+IntToStr(cnt));
   cnt:=0;
   goto nxt;
  end;
end;





procedure  TForm1.CompTextFunc;
var
Expr: TStringType;
S,S1,S2,Sl: String;
i,nl: integer;
ans: AnsiString;
WS: WideString;
PAC: PAnsiChar;
Error,rt,P: Cardinal;
zres: TComplexE;
FZ1: Pointer;
idfP: Pointer;
begin
S:='';

flSetVar('ex',@xe,fl_Real_Extended);
flSetVar('ey',@ye,fl_Real_Extended);

for i := 0 to  MT.Lines.Capacity-1 do
begin
 Sl:=MT.Lines[i];
 DeleteSpace(Sl,Sl);
 P:=Pos('//',Sl);
 if P <> 0 then Delete(Sl,P,Length(Sl)-P+1);
 if (Sl <> '')  then S:=S+Sl;
end;

S:=StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);    //Tab

//flSet(fl_Calc_Type, fl_Real);

    {$IFDEF PANSICHAR}
       ans:=AnsiString(S); Expr:=PAnsiChar(ans);   flCompile(Expr,0,FZ1);
    {$ELSE}
       Expr:=TStringType(S);
       flSetFunction(Expr,0,@idfP);//flCompile(S,FZ1);
    {$ENDIF}
flGetErrorCode(Error);

if Error <> 0 then ShowError;



end;


   (*

procedure TForm1.ConvLinesToStr;
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
 idfP: TidFunc;
 Error: Cardinal;
begin

F_DefFunc := False;
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


    PtrS:=Pos('{$endprogramm}',SL);
    if PtrS <> 0  then
    begin
       N_EndProG:=i;
       Delete(SL,PtrS,14);
       //goto endf;
    end;




    endf:

    if (SL <> '') and  (F_DefFunc = True) then
    begin
      S_FuncName:=SL;
      flSetFunction(SL,0, @idfP);
      flGetErrorCode(Error);
      if Error <> 0 then  ShowError;
    end
    else
    SP:=SP+SL;

 end;

end;

 S_TextProg:=SP;

end;

*)

procedure CreateM1u;
var
MA2: TArray2;
ic,ic1,icn,Lenv,rmin,rmax: Integer;
begin


 {
LenSCM1u:=4;
SetLength(M1u,LenSCM1u*LenSCM1u);
SetLength(M1ut,LenSCM1u*LenSCM1u);
SetLength(M1ux,LenSCM1u*LenSCM1u);
SetLength(M1uy,LenSCM1u*LenSCM1u);
SetLength(MA2,LenSCM1u,LenSCM1u);

MA2[0,0]:=0;     MA2[0,1]:=1;     MA2[0,2]:=-1;     MA2[0,3]:=3 ;
MA2[1,0]:=2;     MA2[1,1]:=1;     MA2[1,2]:=0;      MA2[1,3]:= 0 ;
MA2[2,0]:=-2;    MA2[2,1]:=4;     MA2[2,2]:=5;      MA2[2,3]:=1;
MA2[3,0]:=3;     MA2[3,1]:= 2;    MA2[3,2]:= 1;     MA2[3,3]:= 0;

icn:=0;
Lenv:=LenSCM1u;
for ic := 0 to Lenv-1 do
begin
    for ic1 := 0 to Lenv-1 do
    begin
       M1ut[icn]:=MA2[ic,ic1];
       inc(icn);
    end;
end;

for ic := 0 to LenSCM1u*LenSCM1u-1 do
begin
  M1u[ic]:= M1ut[ic];
end;


for ic := 0 to LenSCM1u*LenSCM1u-1 do
begin
  M1ux[ic]:= M1ut[ic];
  M1uy[ic]:= M1ut[ic];
end;
 }




LenSCM1u:=10;
SetLength(M1u,LenSCM1u*LenSCM1u);
SetLength(M1ut,LenSCM1u*LenSCM1u);
SetLength(M1ux,LenSCM1u*LenSCM1u);
SetLength(M1uy,LenSCM1u*LenSCM1u);



rmin:=0; rmax:=5;

for ic := 0 to LenSCM1u*LenSCM1u-1 do
begin
  M1ux[ic]:= rmin + Random*(rmax - rmin);
  M1uy[ic]:= rmin + Random*(rmax - rmin);
end;


end;


procedure  TForm1.CompTextProg;
label endc,endp;
var
Expr: TStringType;
S,S1,S2,SP,SL,FNS,dv,DExpr,SDiffFunc,FTS: String;
PtrSF: Pointer;
i,nl,Pb: integer;
ans: AnsiString;
WS: WideString;
PAC: PAnsiChar;
Error,rt,ct,PtrS: Cardinal;
zres: TComplexE;
FZ1: Pointer;
T1,T2,nc: Cardinal;
idfP: TidFunc;
CErr:Cardinal;
begin
CreateM1u;

RefreshVar;

SL:='';
SP:='';
F_DefFunc :=False;
F_DefFuncDeriv:=False;

CErr:=0;


for i := 0 to  MT.Lines.Capacity-1 do
begin

    //S:=S+MT.Lines[i];

    SL:=MT.Lines[i];
    //DeleteSpace(SL,SL);

    PtrS:=Pos('//',SL);
    if PtrS <> 0 then    Delete(SL,PtrS,Length(SL)-PtrS+1) ;
    SL:=StringReplace(SL,#9,'',[rfReplaceAll, rfIgnoreCase]);    //Tab
    //SL:=StringReplace(SL,' ','',[rfReplaceAll, rfIgnoreCase]);    //Space


    PtrS:=Pos('{$DefFunc+}',SL);
    if PtrS <> 0  then
    begin
       F_DefFunc:=True;
       Delete(SL,PtrS,11);
       //goto endf;
    end;

    PtrS:=Pos('{$DefFunc-}',SL);
    if PtrS <> 0  then
    begin
       F_DefFunc:=False;
       Delete(SL,PtrS,11);
       //goto endf;
    end;

    PtrS:=Pos('{$DefFuncDeriv+}',SL);
    if PtrS <> 0  then
    begin
       F_DefFuncDeriv:=True;
       Delete(SL,PtrS,16);
       //goto endf;
    end;

    PtrS:=Pos('{$DefFuncDeriv-}',SL);
    if PtrS <> 0  then
    begin
        F_DefFuncDeriv:=False;
       Delete(SL,PtrS,16);
       //goto endf;
    end;




    if (SL <> '') and  (F_DefFunc = True) then
    begin

      {$IFDEF PANSICHAR}
        ans:=AnsiString(SL); Expr:=PAnsiChar(ans);
      {$ELSE}
        Expr:=TStringType(SL);
      {$ENDIF}

      S_FuncName:=SL;
      flSetFunction(Expr, 0, @idfP);
      flGetErrorCode(Error);
      if Error <> 0 then  ShowError
      else //Set derivatives 1,2,3 on 'X'  with postfix name: FuncName()->FuncNameD1(),FuncNameD2(),FuncNameD3()
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


 if SP = '' then  goto endp;




zres.re:=0;  zres.im:=0;

//flSet(fl_Result_Type, fl_Complex,0);


    {$IFDEF PANSICHAR}
       ans:=AnsiString(SP); Expr:=PAnsiChar(ans);
    {$ELSE}
      Expr:=TStringType(SP);
    {$ENDIF}

 T1:=GetTickCount;
    flCompile(Expr,0,FZ1);
 T2:=GetTickCount;

flGetErrorCode(Error);

if Error = 0 then
begin

 if F_NoCalc = True  then begin flPerform(fl_FREE,Cardinal(FZ1)); goto endp; end;


 MT2.Clear;
 LCTF.Caption:=IntToStr(T2-T1);
 //if CB_OM.Checked then NC:=0 else NC:=abs(Trunc(StrToFloat(E_Cnt.Text,G_FMT)));
 NC:=abs(Trunc(StrToFloat(E_CntProg.Text,G_FMT)));

 ct:=G_ResCalcType;
 flGet(fl_RESULT_TYPE,0,rt);

 (*
 if (rt = fl_None) then
 begin
   for i := 0 to nc do
   begin
    flResult(FZ1);
   end;
   zres.re:=resf.re;
   zres.im:=resf.im;
 end
 else
 begin
   for i := 0 to nc do
   begin
    flResultCxEP(FZ1,@zres);
   end;
 end;
 *)

  if (rt = fl_None) then
  begin

    if F_SafeCalc = True then
    begin
      nc:=1; T1:=0; T2:=0;
      for i := 1 to nc do
      begin
        CErr:=flResultSafe(FZ1);
        if CErr <> 0 then goto endc;
      end;
    end
    else
    begin
      T1:=GetTickCount;
      for i := 1 to nc do
      begin
        flResult(FZ1);
      end;
      T2:=GetTickCount;
    end;

    zres.re:=resf.re;
    zres.im:=resf.im;

  end
  else
  if ((rt = fl_Real) and (ct = fl_Stay_As_Is)) or ((rt = fl_Complex) and (ct = fl_Real)) or  ((rt = fl_Real) and (ct = fl_Real)) then
  begin

    if F_SafeCalc = True then
    begin
      nc:=1; T1:=0; T2:=0;
      for i := 1 to nc do
      begin
        CErr:=flResultSafeE(FZ1,zres.re);
        if CErr <> 0 then goto endc;
      end;
    end
    else
    begin
      T1:=GetTickCount;
      for i := 1 to nc do
      begin
        flResultE(FZ1,zres.re);
      end;
      T2:=GetTickCount;
    end;
    zres.im:=0;

  end
  else
  begin

    if F_SafeCalc = True then
    begin
      nc:=1; T1:=0; T2:=0;
      for i := 1 to nc do
      begin
        CErr:=flResultSafeCxEP(FZ1,@zres);
        if CErr <> 0 then goto endc;
      end;
    end
    else
    begin
      T1:=GetTickCount;
      for i := 1 to nc do
      begin
        flResultCxEP(FZ1,@zres);
      end;
      T2:=GetTickCount;
    end;

  end;



   S1:=FloatToStrF(zres.re,ffGeneral,20,4,G_FMT);
   S2:=FloatToStrF(zres.im,ffGeneral,20,4,G_FMT);
   //flGet(fl_Result_Type,0, rt);

   if  (ct = fl_Complex) or ((rt = fl_Complex) and (ct = fl_Stay_As_Is)) or (rt = fl_None) then
      LFR.Caption:=S1+'  '+S2+'i' else  LFR.Caption:=S1;

   G_Res.re:=zres.re; G_Res.im:=zres.im;



  if not CB_OM.Checked then
    begin if (T2-T1) <> 0 then LIPF.Caption:=IntToStr(Trunc(NC/(T2-T1))) else LIPF.Caption:='no defined'; end;

  LPFT.Caption:=IntToStr(T2-T1);

  ShowCompilationData(FZ1);





 end
else
ShowError;

endc:
if CErr <> 0 then
begin
  ShowCalcError(CErr);
end;



flPerform(fl_FREE,Cardinal(FZ1));

endp:
end;







class operator   TComplexNum.Add(const Z1,Z2:TComplexNum):TComplexNum;
Begin
    Result.re:= Z1.re+Z2.re;
    Result.im:= Z1.im+Z2.im;
end;

class operator   TComplexNum.Add(const x: TFloatType; const Z2:TComplexNum):TComplexNum;
Begin
    Result.re:= Z2.re+x;
    Result.im:= Z2.im;
end;

class operator   TComplexNum.Add(const Z1:TComplexNum; const x: TFloatType ):TComplexNum;
Begin
    Result.re:= Z1.re+x;
    Result.im:= Z1.im;
end;


class operator   TComplexNum.Subtract(const Z1,Z2:TComplexNum):TComplexNum;
Begin
    Result.re:= Z1.re-Z2.re;
    Result.im:= Z1.im-Z2.im;
end;

class operator   TComplexNum.Subtract(const x: TFloatType; const Z2:TComplexNum):TComplexNum;
Begin
    Result.re:= x-Z2.re;
    Result.im:= -Z2.im;
end;

class operator   TComplexNum.Subtract(const Z1:TComplexNum; const x: TFloatType ):TComplexNum;
Begin
    Result.re:= Z1.re-x;
    Result.im:= Z1.im;
end;


class operator TComplexNum.Multiply(const Z1, Z2: TComplexNum): TComplexNum;
begin
  Result.re := z1.re*z2.re-z1.im*z2.im;
  Result.im := z1.re*z2.im+z1.im*z2.re;
end;

class operator TComplexNum.Multiply(const Z1:TComplexNum; const x: TFloatType): TComplexNum;
begin
  Result.re := z1.re*x;
  Result.im := z1.im*x;
end;

class operator TComplexNum.Multiply(const x: TFloatType; const Z2:TComplexNum): TComplexNum;
begin
  Result.re := z2.re*x;
  Result.im := z2.im*x;
end;


class operator TComplexNum.Divide(const Z1, Z2: TComplexNum): TComplexNum;
var
t: extended;
begin
 {$IFDEF FASTDIV}
    t:=1/(sqr(z2.re)+sqr(z2.im));
    Result.re := (z1.re*z2.re+z1.im*z2.im)*t;
    Result.im := (z1.im*z2.re-z1.re*z2.im)*t;
 {$ELSE}
    t:=(sqr(z2.re)+sqr(z2.im));
    Result.re := (z1.re*z2.re+z1.im*z2.im)/t;
    Result.im := (z1.im*z2.re-z1.re*z2.im)/t;
 {$ENDIF}
end;


class operator TComplexNum.Divide(const Z1: TComplexNum; const x:TFloatType): TComplexNum;
var
t: extended;
begin
 {$IFDEF FASTDIV}
    t:=1/x;
    Result.re := z1.re*t;
    Result.im := z1.im*t;
  {$ELSE}
    Result.re := z1.re/x;
    Result.im := z1.im/x;
  {$ENDIF}
end;


class operator TComplexNum.Divide(const x: TFloatType; const Z2: TComplexNum): TComplexNum;
var
t: extended;
begin
  {$IFDEF FASTDIV}
    t:=1/(sqr(z2.re)+sqr(z2.im));
    Result.re := x*z2.re*t;
    Result.im := -x*z2.im*t;
  {$ELSE}
    t:=(sqr(z2.re)+sqr(z2.im));
    Result.re := x*z2.re/t;
    Result.im := -x*z2.im/t;
  {$ENDIF}
end;



class operator TComplexNum.Negative(const Z1: TComplexNum): TComplexNum;
begin
  Result.re:=-Z1.re;
  Result.im:=-Z1.im;
end;

 {
function TForm1.Abs(const Z1: TComplexNum): extended;    overload;
begin
  Result:=sqrt(sqr(z1.re)+sqr(z1.im));
end;
 }

function Re(const Z1: TComplexNum): TFloatType;
begin
  Result:=z1.re;
end;


function Im(const Z1: TComplexNum): TFloatType;
begin
  Result:=z1.im;
end;

procedure TForm1.DestroyForm;
begin
  if zp <> nil then dispose(zp);
  if ExprFile <> nil  then ExprFile.Destroy;
  //TimerEx.Enabled:=False;
  //TimerEx.Destroy;
  if OpenFile <> nil then OpenFile.Destroy;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DestroyForm;
end;



procedure TForm1.FullOptimization;
begin
RB_FVE.Checked:=True;
RB_SE.Checked:=True;
RB_PE.Checked:=True;
E_cnt.Text:=IntToStr(10);




//**********************
CB_OP.Checked:=True;
RB_DLEnable.Checked:=True;
RB_XBEnable.Checked:=True;
CB_MulDiv.Checked:=True;
//CB_FD.Checked:=True;
RB_ZDiv_Fast.Checked:=True;

CB_SKIF.Checked:=True;
CB_RF.Checked:=True;
CB_RFCS.Checked:=True;
CB_Div.Checked:=True;
CB_Mul.Checked:=True;
CB_Ras.Checked:=True;
CB_RME.Checked:=True;

UDSD.Position:=8;
Panel1.Caption:=IntToStr(UDSD.Position);
flSet(fl_STACK_DEEP,UDSD.Position,0);
end;


procedure TForm1.WithoutReplaceOperations;
begin

// without replace operations
//**********************
CB_OP.Checked:=True;
RB_DLEnable.Checked:=True;
RB_XBEnable.Checked:=True;
CB_MulDiv.Checked:=True;
//CB_FD.Checked:=True;
RB_ZDiv_Fast.Checked:=True;
CB_SKIF.Checked:=True;
CB_RF.Checked:=True;
CB_RFCS.Checked:=True;
CB_Div.Checked:=False;
CB_Mul.Checked:=False;
CB_Ras.Checked:=False;
CB_RME.Checked:=True;

UDSD.Position:=8;
Panel1.Caption:=IntToStr(UDSD.Position);
flSet(fl_STACK_DEEP,UDSD.Position,0);

end;

procedure TForm1.WithoutOptimizations;
begin
  // without opt.
 //**********************
CB_OP.Checked:=False;
RB_DLDisable.Checked:=True;
RB_XBDisable.Checked:=True;
CB_MulDiv.Checked:=False;
//CB_FD.Checked:=False;
RB_ZDiv_Fast.Checked:=False;
CB_SKIF.Checked:=False;
CB_RF.Checked:=False;
CB_RFCS.Checked:=False;
CB_Div.Checked:=False;
CB_Mul.Checked:=False;
CB_Ras.Checked:=False;
CB_RME.Checked:=False;

UDSD.Position:=0;
Panel1.Caption:=IntToStr(UDSD.Position);
flSet(fl_STACK_DEEP,UDSD.Position,0);
end;






procedure TForm1.LoadExprTestFile(NameF: String);
label nxtstr,ckl,nxtdx,endp;
var
 FN,S,S1,S2,S3,S4,S4x,S4d,St,sx,sx1,sx2,sx3,sx4,sx5: String;
 dx,dx1,dx2,dx3,dx4,dx5: Integer;
 i,k,P,Cnt,dcnt,P1,P2,P3,CP: Integer;
 K_Diff: Boolean;
 K_VarXYT: Boolean;
 K_StrCom: Boolean;
 K_CmpED,K_CmpXYT: Boolean;
 EPrecision,EPrecisionIM,EPrecisionDbl,EPrecisionImDbl : Integer;
 SKey,StrCom: String;
 NDiffMax,NDiff: Integer;
 //res, res_opt, res_rf, resCxyt, resCxyt_opt, resCxyt_rf: TComplexE;
 //F_MStr: Boolean;
 B_ExprList: Boolean;
begin

   F_LoadExprFile:=False;
   SetLength(TestExprList,0);


   if CB_TestExpr.Checked  then
   begin

      OpenFile.InitialDir := GetCurrentDir;
      if OpenFile.Execute then
      begin
         //MT.Clear;
         //MT.Lines.LoadFromFile(OpenFile.FileName) ;
         FN:=OpenFile.FileName;
         //if FileExists(FN) then
         begin
            if not Assigned(ExprFile) then ExprFile:=TStringList.Create;
            ExprFile.LoadFromFile(FN);
            F_LoadExprFile:=True;
            MT.Lines.Assign(ExprFile);  //goto endp;
         end

         {
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
         }
      end;

   (*
     FN := ExtractFilePath(ParamStr(0))+'\'+NameF; //NameF = TestExpressions.txt
     if FileExists(FN) then
     begin
       if not Assigned(ExprFile) then ExprFile:=TStringList.Create;
       ExprFile.LoadFromFile(FN);

       F_LoadExprFile:=True;

       //MT.Lines.Assign(ExprFile);  //goto endp;

     end

    *)


   end
   else
   begin
      if not Assigned(ExprFile) then ExprFile:=TStringList.Create;
      //ExprFile.Clear;
      ExprFile.Assign(MT.Lines);

      F_LoadExprFile:=True;
   end;




   if F_LoadExprFile = True then
   begin

     //delete:  'tab'  , '' ,  '//.......'
     //for i := 0 to ExprFile.Count - 1 do
     i:=0;
     while i <=  ExprFile.Count - 1  do

     begin
       //DeleteSpace(ExprFile[i],ExprFile[i]);
       S:=ExprFile[i];
       S:=StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);
       S:=StringReplace(S,' ','',[rfReplaceAll, rfIgnoreCase]);
       {
       while Pos(#9,S) <> 0 do S:=StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);

       P:=Pos(' ',S);
       while P <> 0 do
       begin
          S:=StringReplace(S,' ','',[rfReplaceAll, rfIgnoreCase]);
          P:=Pos(' ',S);
       end;
       }

       //StringReplace(ExprFile[i],#9,'',[rfReplaceAll, rfIgnoreCase]);    //Tab
       //StringReplace(ExprFile[i],' ','',[rfReplaceAll]);    //space
       //StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);    //Tab
       //StringReplace(S,' ','',[rfReplaceAll]);    //space
       //S:=ExprFile[i];
       //DeleteSpace(S,S);
       P:=Pos('//',S);
       //if P <> 0 then Delete(ExprFile[i],P,Length(ExprFile[i])-P+1);
       if P <> 0 then Delete(S,P,Length(S)-P+1);
       if S <> '' then
       begin
         ExprFile[i]:=S;
         inc(i);
       end
       else
       begin
         ExprFile.Delete(i);
       end;

       //if ExprFile[i] = '' then  ExprFile.Delete(i)

       //if S <> '' then ExprFile[i]:=S else ExprFile.Delete(i);
       {DeleteSpace(S,S);
       ExprFile[i]:=S;
       P:=Pos('//',ExprFile[i]);
       S:=ExprFile[i];
       if P <> 0 then Delete(S,P,Length(S)-P+1);
       ExprFile[i]:=S; }
       //inc(i);
     end;

//**********  DEBUG+
     //MT.Lines.Assign(ExprFile);  //goto endp;
//**********  DEBUG-

     {
       —оздание списка выражений дл€ компил€ции TestExprList.
       ¬се выражени€ должны заканчиватьс€ символом ';' !!!
       ќбъединение всех строк (без символа ';' на конце)
       Cканирование в поиске ключей
     }
      //sx1:='x'; sx2:='y'; sx3:='t'; sx4:='z';  sx5:='z1';

      sx1:='x'; sx2:='y'; sx3:=''; sx4:='';  sx5:='';
      dx1:=1; dx2:=1;  dx3:=0;  dx4:=0; dx5:=0;
      K_Diff:=False;
      K_VarXYT:=False;
      K_StrCom:=False;
      K_CmpED:=False;
      K_CmpXYT:=False;
      EPrecision:=14;              //сравнение с точностью до этой цифры после зап€той
      EPrecisionIM:=EPrecision;   //сравнение мнимых частей с точностью до этой цифры  после зап€той
      EPrecisionDbl:=EPrecision;          // -//- переменные: double
      EPrecisionImDbl:=EPrecision;        // -//- переменные: double
      NDiffMax:=5;
      NDiff:=2; //число переменных дифф-€ (по умолчанию = 2 ;sx1=x; sx2=y)



      cnt:=0;  dcnt:=0; S:='';
      for  i := 0 to   ExprFile.Count - 1 do
      begin

        // {$Diff}
        S1:=ExprFile[i];
        if (LowerCase(S1) = '{$diff}') or (LowerCase(S1) = '{$diff+}')  then
        begin
           K_Diff:=True;
           goto nxtstr;
        end;

         if (LowerCase(S1) = '{$diff-}')   then
        begin
           K_Diff:=False;
           goto  nxtstr;
        end;


        //{$RealToComplexVar_XYT}
        S1:=ExprFile[i];
        if (LowerCase(S1) = '{$realtocomplexvar_xyt}') or (LowerCase(S1) = '{$realtocomplexvar_xyt+}')  then
        begin
           K_VarXYT:=True;
           goto nxtstr;
        end;

        if (LowerCase(S1) = '{$realtocomplexvar_xyt-}')   then
        begin
           K_VarXYT:=False;
           goto nxtstr;
        end;



        S1:=ExprFile[i];
        if (LowerCase(S1) = '{$compareed}') or (LowerCase(S1) = '{$compareed+}')  then
        begin
           K_CmpED:=True;
           goto nxtstr;
        end;

         if (LowerCase(S1) = '{$compareed-}')   then
        begin
           K_CmpED:=False;
           goto  nxtstr;
        end;


        S1:=ExprFile[i];
        if (LowerCase(S1) = '{$comparecomplex_xyt}') or (LowerCase(S1) = '{$comparecomplex_xyt+}')  then
        begin
           K_CmpXYT:=True;
           goto nxtstr;
        end;

         if (LowerCase(S1) = '{comparecomplex_xyt-}')   then
        begin
           K_CmpXYT:=False;
           goto  nxtstr;
        end;





        //{$ErrorPrecision:  15}
        S1:=Copy(ExprFile[i],1,Length('{$errorprecision:'));
        if (LowerCase(S1) = '{$errorprecision:') and (ExprFile[i][Length(ExprFile[i])] = '}') then
        begin
           P1:=Length('{$errorprecision:'); // :
           P2:=Length(ExprFile[i]); //  }
           S2:=Copy(ExprFile[i],P1+1,P2-P1-1);
           if TryStrToInt(S2,CP) = False then
           begin
             ShowMessage('Error In Key "$ErrorPrecision" ');
             goto nxtstr;
           end;
           EPrecision:=CP;
           EPrecisionIM:=CP;
           EPrecisionDbl:=CP;
           EPrecisionImDbl:=CP;
           goto nxtstr;
        end;


         //{$ErrorPrecisionImage:  15}
        S1:=Copy(ExprFile[i],1,Length('{$errorprecisionimage:'));
        if (LowerCase(S1) = '{$errorprecisionimage:') and (ExprFile[i][Length(ExprFile[i])] = '}') then
        begin
           P1:=Length('{$errorprecisionimage:'); // :
           P2:=Length(ExprFile[i]); //  }
           S2:=Copy(ExprFile[i],P1+1,P2-P1-1);
           if TryStrToInt(S2,CP) = False then
           begin
             ShowMessage('Error In Key "$ErrorPrecisionImage" ');
             goto nxtstr;
           end;
           EPrecisionIM:=CP;
           EPrecisionImDbl:=CP;
           goto nxtstr;
        end;


          //{$ErrorPrecisionDbl:  15}
        S1:=Copy(ExprFile[i],1,Length('{$errorprecisiondbl:'));
        if (LowerCase(S1) = '{$errorprecisiondbl:') and (ExprFile[i][Length(ExprFile[i])] = '}') then
        begin
           P1:=Length('{$errorprecisiondbl:'); // :
           P2:=Length(ExprFile[i]); //  }
           S2:=Copy(ExprFile[i],P1+1,P2-P1-1);
           if TryStrToInt(S2,CP) = False then
           begin
             ShowMessage('Error In Key "$ErrorPrecisionDbl" ');
             goto nxtstr;
           end;
           EPrecisionDbl:=CP;
           EPrecisionImDbl:=CP;
           goto nxtstr;
        end;


          //{$ErrorPrecisionImageDbl:  15}
        S1:=Copy(ExprFile[i],1,Length('{$errorprecisionimagedbl:'));
        if (LowerCase(S1) = '{$errorprecisionimagedbl:') and (ExprFile[i][Length(ExprFile[i])] = '}') then
        begin
           P1:=Length('{$errorprecisionimagedbl:'); // :
           P2:=Length(ExprFile[i]); //  }
           S2:=Copy(ExprFile[i],P1+1,P2-P1-1);
           if TryStrToInt(S2,CP) = False then
           begin
             ShowMessage('Error In Key "$ErrorPrecisionImageDbl" ');
             goto nxtstr;
           end;
           EPrecisionImDbl:=CP;
           goto nxtstr;
        end;



        //{$StrCom: llalaallalalalalalallalalalallalalal}
        S1:=Copy(ExprFile[i],1,Length('{$strcom:'));
        if (LowerCase(S1) = '{$strcom:') and (ExprFile[i][Length(ExprFile[i])] = '}') then
        begin
           P1:=Length('{$strcom:'); // :
           P2:=Length(ExprFile[i]); //  }
           S2:=Copy(ExprFile[i],P1+1,P2-P1-1);
           StrCom:=S2;
           K_StrCom:=True;
           SetLength(TestExprList,Length(TestExprList)+1);
           TestExprList[High(TestExprList)].K_StrCom:=True;
           TestExprList[High(TestExprList)].StrCom:=S2;
           goto nxtstr;
        end;



        //{$ListDiffVar: x:2,y:1,t:1,z1:2,z2:1}    {$ListDiffVar: x:2,y:1}
        S1:=Copy(ExprFile[i],1,Length('{$listdiffvar:'));
        if (LowerCase(S1) = '{$listdiffvar:') and (ExprFile[i][Length(ExprFile[i])] = '}') then
        begin
          cnt:=0;       //число переменных в ключе
          S2:=Copy(ExprFile[i],Length('{$listdiffvar:')+1,Length(ExprFile[i])-Length('{$listdiffvar:')-1);   // x:2,y:1,t:2,z1:3,z2:5

//*************************
          SetLength(TestExprDiff,0);


          P2:=Pos(',',S2);
          if P2 <> 0 then      // {$ListDiffVar: x:2,y:1,t:1,z1:2,z2:1}
          begin
             while P2 <> 0 do
             begin
               S3:=Copy(S2,1,P2-1); //x:2
               P3:=Pos(':',S3);
               if P3 > 0 then
               begin
                   S4x:=Copy(S3,1,P3-1);              //x
                   S4d:=Copy(S3,P3+1,Length(S3)-P3);  //2
                   if TryStrToInt(S4d,dx) = False then
                   begin
                      ShowMessage('Error In Key "$ListDiffVar" ');
                      goto nxtstr;
                   end;
                   SetLength(TestExprDiff,Length(TestExprDiff)+1);
                   TestExprDiff[High(TestExprDiff)].sx:=S4x;
                   TestExprDiff[High(TestExprDiff)].dx:=dx;
               end
               else
               begin
                   ShowMessage('Error In Key "$ListDiffVar" ');
                   goto nxtstr;
               end;

               Delete(S2,1,P2);
               P2:=Pos(',',S2);
             end;
          end;

          if P2 = 0 then    //{$ListDiffVar: x:2}     z2:5
          begin
               S3:=S2;
               P3:=Pos(':',S3);
               if P3 > 0 then
               begin
                   S4x:=Copy(S3,1,P3-1);              //x
                   S4d:=Copy(S3,P3+1,Length(S3)-P3);  //2
                   if TryStrToInt(S4d,dx) = False then
                   begin
                      ShowMessage('Error In Key "$ListDiffVar" ');
                      goto nxtstr;
                   end;
                   SetLength(TestExprDiff,Length(TestExprDiff)+1);
                   TestExprDiff[High(TestExprDiff)].sx:=S4x;
                   TestExprDiff[High(TestExprDiff)].dx:=dx;
                   //goto nxtstr;
               end
               else
               begin
                   ShowMessage('Error In Key "$ListDiffVar" ');
                   goto nxtstr;
               end;
          end;






          for k := 0 to Length(TestExprDiff)-1 do
          begin
            if k+1 <= NDiffMax then
            begin
               inc(cnt);
               sx:=TestExprDiff[k].sx;
               dx:=TestExprDiff[k].dx;
               case  cnt of
                  1: begin sx1:=sx; dx1:=dx;  end;
                  2: begin sx2:=sx; dx2:=dx;  end;
                  3: begin sx3:=sx; dx3:=dx;  end;
                  4: begin sx4:=sx; dx4:=dx;  end;
                  5: begin sx5:=sx; dx5:=dx;  end;
               end;
            end;
          end;
          NDiff:=cnt;
          goto nxtstr;

 //*******************************



          {
          nxtdx:
          P2:=Pos(',',S2);
          P3:=Pos(':',S2); // z2:5  ; последний
          if (P2 > 0) or ( (P2 = 0) and (P3 <> 0)) then   // ','  ':'
          begin

             if P2 <> 0 then S3:=Copy(S2,1,P2-1) //x:2
                        else begin S3:=S2; P2:=Length(S2); end;           //z2:5

             P3:=Pos(':',S3);
             if P3 > 0 then
             begin

                S4x:=Copy(S3,1,P3-1);  S4d:=Copy(S3,P3+1,Length(S3)-P3);
                if TryStrToInt(S4d,dx) = False then
                begin
                   ShowMessage('Error In Key "$ListDiffVar" ');
                   goto nxtstr;
                end;

                sx:=S4x;
                inc(cnt);
                case  cnt of
                  1: begin sx1:=sx; dx1:=dx;  end;
                  2: begin sx2:=sx; dx2:=dx;  end;
                  3: begin sx3:=sx; dx3:=dx;  end;
                  4: begin sx4:=sx; dx4:=dx;  end;
                  5: begin sx5:=sx; dx5:=dx;  end;
                end;

                NDiff:=cnt;
             end //P3
             else
             begin
                ShowMessage('Error In Key "$ListDiffVar" ');
                goto nxtstr;
             end;

          end //P2
          else    // z2:5
          begin

             ShowMessage('Error In Key "$ListDiffVar" ');
             goto nxtstr;
          end;

          Delete(S2,1,P2);
          if S2 <> '' then     goto nxtdx;
          }


        end; //if LowerCase(S1)







        //объединение выражений, если заканчиваютс€ не ;
        //nxt:
        if (ExprFile[i][Length(ExprFile[i])] <> ';')   then
        begin
          if dcnt > 0  then S:=S+ExprFile[i]
                       else S:=ExprFile[i];
          inc(dcnt);
        end
        else
        begin
          if dcnt > 0 then S:=S+ExprFile[i]
                      else S:=ExprFile[i];

          SetLength(TestExprList,Length(TestExprList)+1);

          TestExprList[High(TestExprList)].Expr:=S;
          TestExprList[High(TestExprList)].sx1:=sx1;
          TestExprList[High(TestExprList)].sx2:=sx2;
          TestExprList[High(TestExprList)].sx3:=sx3;
          TestExprList[High(TestExprList)].sx4:=sx4;
          TestExprList[High(TestExprList)].sx5:=sx5;
          TestExprList[High(TestExprList)].dx1:=dx1;
          TestExprList[High(TestExprList)].dx2:=dx2;
          TestExprList[High(TestExprList)].dx3:=dx3;
          TestExprList[High(TestExprList)].dx4:=dx4;
          TestExprList[High(TestExprList)].dx5:=dx5;
          TestExprList[High(TestExprList)].K_Diff:=K_Diff;
          TestExprList[High(TestExprList)].K_VarXYT:=K_VarXYT;
          TestExprList[High(TestExprList)].K_CmpED:=K_CmpED;
          TestExprList[High(TestExprList)].K_CmpXYT:=K_CmpXYT;
          TestExprList[High(TestExprList)].EPrecision:=EPrecision;
          TestExprList[High(TestExprList)].EPrecisionIM:=EPrecisionIM;
          TestExprList[High(TestExprList)].EPrecisionDbl:=EPrecisionDbl;
          TestExprList[High(TestExprList)].EPrecisionImDbl:=EPrecisionImDbl;
          TestExprList[High(TestExprList)].NDiff:=NDiff;
          TestExprList[High(TestExprList)].K_StrCom:=False;

          S:='';  dcnt:=0;
        end;

       nxtstr:
      end;  //for



     //CntExpr:=1;
     //ETest.Text:='1';
   end
   else
   begin
      //ShowMessage('File: TestExpressions.txt is absent');
      ShowMessage('Test file  is absent');
      goto endp;
   end;




 //****************************** DEBUG+
   {MT.Lines.Add('**************************************') ;
   for i := 0 to High(TestExprList) do
   begin
      MT.Lines.Add(  TestExprList[i].Expr) ;
   end;
   }
 //********************************  DEBUG-
 endp:
end;





function TForm1.CompileExprTest: Boolean;
label NxtExp;


var
 FN,S,StrOut,Expr,DExpr,S1,S2,S3,S4,S4x,S4d,St,sx,sx1,sx2,sx3,sx4,sx5: String;
 dx,dx1,dx2,dx3,dx4,dx5: Integer;
 i,k,L,P,Cnt,dcnt,P1,P2,P3,CP: Integer;
 K_Diff: Boolean;
 K_VarXYT: Boolean;
 K_StrCom: Boolean;
 K_CmpED,K_CmpXYT: Boolean;
 EPrecision,EPrecisionIM,EPrecisionDbl,EPrecisionImDbl: Integer;
 SKey,StrCom: String;
 NDiffMax,NDiff: Integer;
 NExprCompl,NTestExprCompl,NLenExpr: Cardinal;  //полное число скомпилированных выражений , исходное число выражений в тесте, суммарна€ длина всех скомпилированных выражений.
 SExpr: TStringType;
 PtrS: Pointer;
 CError: Cardinal;
 GError: Boolean;
 K_ZDIV: Integer;
 Tm1,Tm2,Tts,DTts: Cardinal;
 Ans: AnsiString;


      function _CompileTestExpr(Expr: String; NC,NS: Integer): Integer;  //TestExprCmpl[NC]  TestExprList[NS]
      label endp;

              procedure _CompileExpr(SExpr: String; var CAddr: Pointer; var CError: Cardinal);
              var
                Expr: TStringType;
                ans: AnsiString;
              begin
                 {$IFDEF PANSICHAR}
                     ans:=AnsiString(SExpr); Expr:=PAnsiChar(ans);
                 {$ELSE}
                     Expr:=TStringType(SExpr);
                 {$ENDIF}
                        Tm1:=GetTickCount;
                    flCompile(Expr,0,CAddr);
                        Tm2:=GetTickCount;
                        Tts:=Tts+(Tm2-Tm1);
                    flGetErrorCode(CError);

                    inc(NExprCompl);
                    NLenExpr:=NLenExpr+Length(SExpr);
              end;




      var
         CAddr: Pointer;
         CError: Cardinal;
      begin
       //SetLength(TestExprCmpl,Length(TestExprCmpl)+1);

     // омпил€ци€ выражени€:
          //переменные - extended
          RB_FVE.Checked:=True;
             //оптимизаци€ - ¬ Ћ.
             CB_OP.Checked:=True;

                {Compile}
                _CompileExpr(Expr,CAddr,CError);
                if CError <> 0 then
                begin
                   MT.Lines.Add('Syntax Error in :  '+Expr);
                   GError:=False;
                   goto endp;
                end;
                SetLength(TestExprCmpl,Length(TestExprCmpl)+1);

                TestExprCmpl[High(TestExprCmpl)].RExprEO:=CAddr;


             //оптимизаци€ - ¬џ Ћ.
             CB_OP.Checked:=False;

                {Compile}
                _CompileExpr(Expr,CAddr,CError);
                TestExprCmpl[High(TestExprCmpl)].RExprE:=CAddr;

          //переменные - double
          RB_FVD.Checked:=True;
             //оптимизаци€ - ¬ Ћ.
             CB_OP.Checked:=True;

                 {Compile}
                _CompileExpr(Expr,CAddr,CError);
                TestExprCmpl[High(TestExprCmpl)].RExprDO:=CAddr;

             //оптимизаци€ - ¬џ Ћ.
             CB_OP.Checked:=False;

                 {Compile}
                _CompileExpr(Expr,CAddr,CError);
                TestExprCmpl[High(TestExprCmpl)].RExprD:=CAddr;

          //восстановление
          RB_FVE.Checked:=True;
          CB_OP.Checked:=True;

     // омпил€ци€ c заменой действительных переменных x, y, t комплексными (мнима€ часть = 0):
         if K_VarXYT = True then
         begin
             //x,y,t - комплексные (мнима€ часть = 0)
             CB_VCx.Checked := True;


             //переменные - extended
             RB_FVE.Checked:=True;
                //оптимизаци€ - ¬ Ћ.
                CB_OP.Checked:=True;

                  {Compile}
                  _CompileExpr(Expr,CAddr,CError);
                  TestExprCmpl[High(TestExprCmpl)].CExprEO:=CAddr;

                //оптимизаци€ - ¬џ Ћ.
                CB_OP.Checked:=False;
                   {Compile}
                  _CompileExpr(Expr,CAddr,CError);
                  TestExprCmpl[High(TestExprCmpl)].CExprE:=CAddr;

            //переменные - double
            RB_FVD.Checked:=True;
                //оптимизаци€ - ¬ Ћ.
                CB_OP.Checked:=True;
                   {Compile}
                  _CompileExpr(Expr,CAddr,CError);
                  TestExprCmpl[High(TestExprCmpl)].CExprDO:=CAddr;

                //оптимизаци€ - ¬џ Ћ.
                CB_OP.Checked:=False;
                    {Compile}
                  _CompileExpr(Expr,CAddr,CError);
                  TestExprCmpl[High(TestExprCmpl)].CExprD:=CAddr;

         end;


         //восстановление
         RB_FVE.Checked:=True;
         CB_VCx.Checked := False;
         CB_OP.Checked:=True;
         endp:

        _CompileTestExpr:=CError;
      end;






begin
   L:=Length(TestExprList);
   NExprCompl:=0;
   NTestExprCompl:=0;
   NLenExpr:=0;
   GError:=False;


   if RB_ZDiv_STD.Checked =  True then K_ZDIV:=2 else
    if RB_ZDiv_ACC.Checked =  True then K_ZDIV:=3 else
     if RB_ZDiv_Extra.Checked =  True then K_ZDIV:=4 else  K_ZDIV:=2;

   G_ZDIV:=K_ZDIV;


   SetLength(TestExprCmpl,0);

   //компил€ци€ всех выражений в комплексном режиме: flSet(fl_RESULT_LEAD_TO_TYPE, fl_Complex,0);
   RB_Cx.Checked :=  True;

   // Re Im комплексных переменных z1,z2,z3 располагаютс€ по независимым адресам
   CB_CXAnyAddr.Checked:=True;



   MT.Lines.Add(' **************************************************************');
   MT.Lines.Add(' **************     COMPILING    ******************************');
   MT.Lines.Add(' **************************************************************');

   {
   StrOut:= ' **************************************************************';
   OutStr(StrOut);
   StrOut:= ' **************     COMPILING    ******************************';
   OutStr(StrOut);
   StrOut:= ' **************************************************************';
   OutStr(StrOut);
   }

   Tts:=0;
   DTts:=0;

   for i := 0 to L-1 do
   begin

     K_Diff:=TestExprList[i].K_Diff;
     K_VarXYT:=TestExprList[i].K_VarXYT;
     EPrecision:=TestExprList[i].EPrecision;
     EPrecisionIM:=TestExprList[i].EPrecisionIM;
     EPrecisionDbl:=TestExprList[i].EPrecisionDbl;
     EPrecisionImDbl:=TestExprList[i].EPrecisionImDbl;
     K_CmpED:=TestExprList[i].K_CmpED;
     K_CmpXYT:=TestExprList[i].K_CmpXYT;
     Expr:=TestExprList[i].Expr;

     if TestExprList[i].K_StrCom = False then
     begin

         // омпил€ци€ выражени€
         //SetLength(TestExprCmpl,Length(TestExprCmpl)+1);
         if _CompileTestExpr(TestExprList[i].Expr,High(TestExprCmpl),i) <> 0 then goto  NxtExp
         else
         begin
             TestExprCmpl[High(TestExprCmpl)].NExpr:=i;   //номер текущего выражени€ в  TestExprCmpl
             TestExprCmpl[High(TestExprCmpl)].K_Diff:=False;
             TestExprCmpl[High(TestExprCmpl)].K_VarXYT:=K_VarXYT;
             TestExprCmpl[High(TestExprCmpl)].K_CmpED:=K_CmpED;
             TestExprCmpl[High(TestExprCmpl)].K_CmpXYT:=K_CmpXYT;
             TestExprCmpl[High(TestExprCmpl)].K_StrCom:=False;
             TestExprCmpl[High(TestExprCmpl)].EPrecision:=EPrecision;
             TestExprCmpl[High(TestExprCmpl)].EPrecisionIM:=EPrecisionIM;
             TestExprCmpl[High(TestExprCmpl)].EPrecisionDbl:=EPrecisionDbl;
             TestExprCmpl[High(TestExprCmpl)].EPrecisionImDbl:=EPrecisionImDbl;
         end;


        // омпил€ци€ производной выражени€:
         if K_Diff = True then
         begin
            //Ќахождение строковой производной

            NDiff:=TestExprList[i].NDiff;

            dx1:=TestExprList[i].dx1; dx2:=TestExprList[i].dx2;  dx3:=TestExprList[i].dx3;
            dx4:=TestExprList[i].dx4; dx5:=TestExprList[i].dx5;

            sx1:=TestExprList[i].sx1; sx2:=TestExprList[i].sx2;  sx3:=TestExprList[i].sx3;
            sx4:=TestExprList[i].sx4; sx5:=TestExprList[i].sx5;



            S1:=TestExprList[i].Expr;
            {$IFDEF PANSICHAR}
                   ans:=AnsiString(S1); SExpr:=PAnsiChar(ans);
            {$ELSE}
                   SExpr:=TStringType(S1);
            {$ENDIF}


              flSetDiffExpr(SExpr);
              flGetErrorCode(CError);
              if CError = 0 then
              begin

                 case NDiff of
                   1:
                      begin
                         flSetDiffVar(ConvStrOut(sx1));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx1);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);
                      end;
                   2:
                      begin
                         flSetDiffVar(ConvStrOut(sx1));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx1);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx2));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx2);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);
                      end;
                   3:
                      begin
                         flSetDiffVar(ConvStrOut(sx1));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx1);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx2));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx2);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);


                         flSetDiffVar(ConvStrOut(sx3));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx3);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);
                      end;
                   4:
                      begin
                         flSetDiffVar(ConvStrOut(sx1));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx1);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx2));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx2);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx3));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx3);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx4));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx4);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);
                      end;
                   5:
                      begin
                         flSetDiffVar(ConvStrOut(sx1));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx1);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx2));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx2);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx3));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx3);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx4));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx4);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);

                         flSetDiffVar(ConvStrOut(sx5));
                                  Tm1:=GetTickCount;
                         flDiffExpr(dx5);
                                  Tm2:=GetTickCount;
                                  DTts:=DTts+(Tm2-Tm1);
                      end;
                 end;


                 {$IFDEF STRINGINT}
                    flGetDiffString(DExpr);
                 {$ELSE}
                    flGetDiffString(PtrS);
                    ConvStr(PtrS,DExpr);
                 {$ENDIF}


                  // омпил€ци€ производной
                 //SetLength(TestExprCmpl,Length(TestExprCmpl)+1);
                 if _CompileTestExpr(DExpr,High(TestExprCmpl),i) <> 0 then goto  NxtExp
                 else
                 begin
                       TestExprCmpl[High(TestExprCmpl)].NExpr:=i;   //номер текущего выражени€ в  TestExprCmpl
                       TestExprCmpl[High(TestExprCmpl)].K_Diff:=True;
                       TestExprCmpl[High(TestExprCmpl)].K_VarXYT:=K_VarXYT;
                       TestExprCmpl[High(TestExprCmpl)].K_CmpED:=K_CmpED;
                       TestExprCmpl[High(TestExprCmpl)].K_CmpXYT:=K_CmpXYT;
                       TestExprCmpl[High(TestExprCmpl)].K_StrCom:=False;
                       TestExprCmpl[High(TestExprCmpl)].EPrecision:=EPrecision;
                       TestExprCmpl[High(TestExprCmpl)].EPrecisionIM:=EPrecisionIM;
                       TestExprCmpl[High(TestExprCmpl)].EPrecisionDbl:=EPrecisionDbl;
                       TestExprCmpl[High(TestExprCmpl)].EPrecisionImDbl:=EPrecisionImDbl;
                 end;

              end //CError = 0
              else
              begin
                //Syntax ERROR in DiffExpression
                MT.Lines.Add('Syntax Error or No Diff Expr:  '+Expr);
                GError:=False;
              end;

         end;  //K_Diff

        inc(NTestExprCompl);
        if (K_Diff = True) and (CError = 0) then
        begin
             if K_VarXYT = True then
             begin
                MT.Lines.Add('('+IntToStr(NTestExprCompl)+') '+'  Expr: OK; Repl_XYT: OK;  Diff Expr: OK')
               {StrOut:= '('+IntToStr(NTestExprCompl)+') '+'  Expr: OK; Repl_XYT: OK;  Diff Expr: OK';
               OutStr(StrOut); }
             end
             else
             begin
                MT.Lines.Add('('+IntToStr(NTestExprCompl)+') '+'  Expr: OK;  Diff Expr: OK')
               {StrOut:= '('+IntToStr(NTestExprCompl)+') '+'  Expr: OK;  Diff Expr: OK';
               OutStr(StrOut);  }
             end;
        end
        else
             begin
                MT.Lines.Add('('+IntToStr(NTestExprCompl)+') '+'  Expr: OK');
               {StrOut:= '('+IntToStr(NTestExprCompl)+') '+'  Expr: OK';
               OutStr(StrOut); }
             end
     end   //K_StrCom
     else
     begin
        MT.Lines.Add('Current Compile :  ' + TestExprList[i].StrCom);
        {StrOut:= 'Current Compile :  ' + TestExprList[i].StrCom;
        OutStr(StrOut);}

        SetLength(TestExprCmpl,Length(TestExprCmpl)+1);
        TestExprCmpl[High(TestExprCmpl)].NExpr:=i;
        TestExprCmpl[High(TestExprCmpl)].K_StrCom:=True;
     end;

   NxtExp:
   end;//for i


     //восстановление
    RB_AsIs.Checked :=  True;
    RB_FVE.Checked:=True;
    CB_VCx.Checked := False;
    CB_OP.Checked:=True;

    MT.Lines.Add('');
    MT.Lines.Add('----------- Finished compiling --------');
    MT.Lines.Add(' Total Number Recognized Expressions          :  ' + IntToStr(NTestExprCompl));
    MT.Lines.Add(' Total Number Compiled Expressions            :  ' + IntToStr(NExprCompl));
    MT.Lines.Add(' Total Length Compiled Expressions, characters:  ' + IntToStr(NLenExpr));
    MT.Lines.Add(' Total Compiling Time,  sec                   :  ' + IntToStr(Trunc((Tts)/1000)));
    MT.Lines.Add(' Total Time of Symbolic Differentiations, msec:  ' + IntToStr(Trunc((DTts))));
    MT.Lines.Add('---------------------------------------');
    MT.Lines.Add('');


    {
    StrOut:= '';
    OutStr(StrOut);
    StrOut:= '----------- Finished compiling --------';
    OutStr(StrOut);
    StrOut:= ' Total Number Recognized Expressions:  ' + IntToStr(NTestExprCompl);
    OutStr(StrOut);
    StrOut:= ' Total Number Compiled   Expressions:  ' + IntToStr(NExprCompl);
    OutStr(StrOut);
    StrOut:= ' Total Length Compiled   Expressions:  ' + IntToStr(NLenExpr);
    OutStr(StrOut);
    StrOut:= '---------------------------------------';
    OutStr(StrOut);
    StrOut:= '';
    OutStr(StrOut);
    }

    CompileExprTest:=not(GError);
end;





procedure TForm1.RunExprTest;
label NxtExpr;


     function _CalcTestExpr(CAddr: Pointer; var  Re,Im: extended): Boolean;
     var
       p:TComplexE;
       BResult: Boolean;
       NCalc: Integer;
     begin
       BResult:=True;
       NCalc:=10;


         try

           for k := 1 to NCalc do
           begin

             asm
               call CAddr
               push eax
               mov  eax, [Re]
               fstp tbyte ptr [eax]
               mov  eax, [Im]
               fstp tbyte ptr [eax]
               pop  eax
             end;

           end;

         except
           BResult:=False;
         end;





       _CalcTestExpr:=BResult;
     end;



var
 FN,S,StrOut,Expr,DExpr,S1,S2,S3,S4,S4x,S4d,St,sx,sx1,sx2,sx3,sx4,sx5: String;
 dx,dx1,dx2,dx3,dx4,dx5: Integer;
 i,k,L,P,Cnt,dcnt,P1,P2,P3,CP,ke: Integer;
 K_Diff: Boolean;
 K_VarXYT: Boolean;
 K_StrCom: Boolean;
 K_CmpXYT,K_CmpED: Boolean;
 EPrecision,EPrecisionIM,EPrecisionDbl,EPrecisionImDbl: Integer;
 SKey,StrCom: String;
 NExpr,NStrCom: Integer;
 NDiffMax,NDiff: Integer;
 NExprCompl,NTestExprCompl,NLenExpr: Cardinal;  //полное число скомпилированных выражений , исходное число выражений в тесте, суммарна€ длина всех скомпилированных выражений.
 SExpr: TStringType;
 PtrS: Pointer;
 CError,NCmpExpr: Cardinal;
 GError,BNewExpErr: Boolean;
 ex,ey, dErr,absErr: Extended;
 FErr,FErr_Rel,FErrIM,FErrIM_Rel: Extended;
 FErr_RelDbl,FErrDbl,FErrIM_RelDbl,FErrImDbl: Extended;

 RExprEO,RExprE,RExprDO,RExprD,CExprEO,CExprE,CExprDO,CExprD : Pointer;
 Re_REO,Im_REO,Re_RE,Im_RE,Re_RDO,Im_RDO, Re_RD, Im_RD,Re_CEO,Im_CEO, Re_CE,Im_CE ,Re_CDO,Im_CDO , Re_CD, Im_CD: Extended;

 Ere_EOE,Eim_EOE,
 Ere_DOD,Eim_DOD,
 Ere_EODO,Eim_EODO,
 Ere_ED,Eim_ED,
 Ere_CEOCE,Eim_CEOCE,
 Ere_CDOCD,Eim_CDOCD,
 Ere_CEOCDO,Eim_CEOCDO,
 Ere_CECD,Eim_CECD,
 Ere_EOCEO,Eim_EOCEO,
 Ere_DOCDO,Eim_DOCDO   : Boolean;



 K_PrecError_EOE,    K_PrecError_DOD,
 K_PrecError_EODO,   K_PrecError_ED,

 K_PrecError_CEOCE,  K_PrecError_CDOCD,
 K_PrecError_CEOCDO, K_PrecError_CECD,

 K_PrecError_EOCEO,  K_PrecError_DOCDO  : Boolean;

       absErr_Re_EOE,absErr_Im_EOE: Extended;
       absErr_Re_DOD,absErr_Im_DOD: Extended;
       absErr_Re_CEOCE,absErr_Im_CEOCE: Extended;
       absErr_Re_CDOCD,absErr_Im_CDOCD: Extended;
       absErr_Re_EOCEO,absErr_Im_EOCEO: Extended;
       absErr_Re_DOCDO,absErr_Im_DOCDO: Extended;
       absErr_Re_EOE_Diff,absErr_Im_EOE_Diff: Extended;
       absErr_Re_DOD_Diff,absErr_Im_DOD_Diff: Extended;
       absErr_Re_CEOCE_Diff,absErr_Im_CEOCE_Diff: Extended;
       absErr_Re_CDOCD_Diff,absErr_Im_CDOCD_Diff: Extended;
       absErr_Re_EOCEO_Diff,absErr_Im_EOCEO_Diff: Extended;
       absErr_Re_DOCDO_Diff,absErr_Im_DOCDO_Diff: Extended;


 {K_PrecError_EODO,K_PrecError_EOCEO,K_PrecError_DOCDO: Boolean;}

 K_CalcError_REO,K_CalcError_RE,K_CalcError_RDO,K_CalcError_RD,K_CalcError_CEO,K_CalcError_CE,K_CalcError_CDO,K_CalcError_CD: Boolean;

begin
     SetLength(TestExprError,0);
     K_Diff:=False;
     K_VarXYT:=False;
     K_StrCom:=False;
     K_CmpED:=False;
     K_CmpXYT:=False;
     NCmpExpr:=0;

     //EPrecision:=15;

   MT.Lines.Add(' **************************************************************');
   MT.Lines.Add(' **************     EXECUTION    ******************************');
   MT.Lines.Add(' **************************************************************');

   {
   StrOut:= ' **************************************************************';
   OutStr(StrOut);
   StrOut:= ' **************     EXECUTION     ******************************';
   OutStr(StrOut);
   StrOut:= ' **************************************************************';
   OutStr(StrOut);
   }

   NStrCom:=0;
   L:=Length(TestExprCmpl);
   for i := 0 to L-1 do
   begin
      //настройки текущего выражени€:
      K_Diff:=TestExprCmpl[i].K_Diff;
      K_VarXYT:=TestExprCmpl[i].K_VarXYT;
      K_CmpED:=TestExprCmpl[i].K_CmpED;
      K_CmpXYT:=TestExprCmpl[i].K_CmpXYT;
      K_StrCom:=TestExprCmpl[i].K_StrCom;

      EPrecision:=TestExprCmpl[i].EPrecision;
      EPrecisionIM:=TestExprCmpl[i].EPrecisionIM;

      EPrecisionDbl:=TestExprCmpl[i].EPrecisionDbl;
      EPrecisionImDbl:=TestExprCmpl[i].EPrecisionImDbl;

      ke:=2;
      FErr_Rel:=Power(10,-ke*EPrecision);
      FErr:=Power(10,-EPrecision);
      FErrIM_Rel:=Power(10,-ke*EPrecisionIM);
      FErrIM:=Power(10,-EPrecisionIM);

      FErr_RelDbl:=Power(10,-ke*EPrecisionDbl);
      FErrDbl:=Power(10,-EPrecisionDbl);
      FErrIM_RelDbl:=Power(10,-ke*EPrecisionImDbl);
      FErrImDbl:=Power(10,-EPrecisionImDbl);

      NExpr:=TestExprCmpl[i].NExpr;
      BNewExpErr:=False;

      //Expr:=TestExprList[NExpr].Expr;


      if K_StrCom = False then
      begin

         RExprEO:=TestExprCmpl[i].RExprEO;
         RExprE :=TestExprCmpl[i].RExprE;
         RExprDO:=TestExprCmpl[i].RExprDO;
         RExprD :=TestExprCmpl[i].RExprD;
         CExprEO:=TestExprCmpl[i].CExprEO;
         CExprE :=TestExprCmpl[i].CExprE;
         CExprDO:=TestExprCmpl[i].CExprDO;
         CExprD :=TestExprCmpl[i].CExprD;
         K_CalcError_REO:=False;
         K_CalcError_RE:=False;
         K_CalcError_RDO:=False;
         K_CalcError_RD:=False;
         K_CalcError_CEO:=False;
         K_CalcError_CE:=False;
         K_CalcError_CDO:=False;
         K_CalcError_CD:=False;
         K_PrecError_EOE:=False;



        //**************  вычислительные погрешности **********************
         if _CalcTestExpr(RExprEO,Re_REO,Im_REO) = False then
         begin
            K_CalcError_REO:=True;
            BNewExpErr := True;
         end;

         if _CalcTestExpr(RExprE, Re_RE,Im_RE) = False then
         begin
            K_CalcError_RE:=True;
            BNewExpErr := True;
         end;

         if _CalcTestExpr(RExprDO,Re_RDO,Im_RDO) = False then
         begin
            K_CalcError_RDO:=True;
            BNewExpErr := True;
         end;

         if _CalcTestExpr(RExprD, Re_RD, Im_RD) = False then
         begin
            K_CalcError_RD:=True;
            BNewExpErr := True;
         end;

         if K_VarXYT = True then
         begin

            if _CalcTestExpr(CExprEO,Re_CEO,Im_CEO) = False then
            begin
               K_CalcError_CEO:=True;
               BNewExpErr := True;
            end;

            if _CalcTestExpr(CExprE, Re_CE,Im_CE) = False then
            begin
               K_CalcError_CE:=True;
               BNewExpErr := True;
            end;

            if _CalcTestExpr(CExprDO,Re_CDO,Im_CDO) = False then
            begin
               K_CalcError_CDO:=True;
               BNewExpErr := True;
            end;

            if _CalcTestExpr(CExprD, Re_CD, Im_CD) = False then
            begin
               K_CalcError_CD:=True;
               BNewExpErr := True;
            end;

         end;  //K_VarXYT

         if BNewExpErr = True then
         begin
            SetLength(TestExprError,Length(TestExprError)+1);
            TestExprError[High(TestExprError)].NExpr:=NExpr;
            TestExprError[High(TestExprError)].NCExpr:=i;
            TestExprError[High(TestExprError)].K_Diff:=K_Diff;
            TestExprError[High(TestExprError)].K_VarXYT:=K_VarXYT;
            TestExprError[High(TestExprError)].K_CmpED:=K_CmpED;
            TestExprError[High(TestExprError)].K_CmpXYT:=K_CmpXYT;
            TestExprError[High(TestExprError)].K_CalcError:=True;
            TestExprError[High(TestExprError)].K_CalcError_REO:=K_CalcError_REO;
            TestExprError[High(TestExprError)].K_CalcError_RE :=K_CalcError_RE;
            TestExprError[High(TestExprError)].K_CalcError_RDO:=K_CalcError_RDO;
            TestExprError[High(TestExprError)].K_CalcError_RD:=K_CalcError_RD;
            TestExprError[High(TestExprError)].K_CalcError_CEO:=K_CalcError_CEO;
            TestExprError[High(TestExprError)].K_CalcError_CE:=K_CalcError_CE;
            TestExprError[High(TestExprError)].K_CalcError_CDO:=K_CalcError_CDO;
            TestExprError[High(TestExprError)].K_CalcError_CD:=K_CalcError_CD;
            goto NxtExpr;
         end;



        //**************     сравнительные погрешности  ************
        {
           Cравниваютс€ между собой рез-ты: EO-E; DO-D;
                                            CEO-CE; CDO-CD <- при ключе K_VarXYT
             ѕри ключе K_CmpED дополнительно сравниваютс€:  EO-DO; E-D;
                                            CEO-CDO; CE-CD <- при ключе K_VarXYT

             ѕри ключе K_CmpXYT дополнительно сравниваютс€:  EO-CEO; E-CE; DO-CDO; D-CD;


           “акие же сравнени€ дл€ производной выражени€, при ключе K_Diff

                  лючи сравнени€ Boolean:
            K_PrecError_EOE,       EO-E                 (1)
            K_PrecError_DOD,       DO-D                 (2)
                       K_CmpED
            K_PrecError_EODO,      EO-DO                (3)
            K_PrecError_ED,        E-D                  (4)
                       K_VarXYT,
            K_PrecError_CEOCE,     CEO-CE               (5)
            K_PrecError_CDOCD,     CDO-CD               (6)
                    K_VarXYT, K_CmpED
            K_PrecError_CEOCDO,    CEO-CDO              (7)
            K_PrecError_CECD,      CE-CD                (8)
                    K_VarXYT, K_CmpXYT
            K_PrecError_EOCEO      EO-CEO               (9)
            K_PrecError_DOCDO      DO-CDO               (10)

           ћаксимальное число сравнений - 10.

           EO - выражение с компил€цией переменных X, Y, T, S: extended и полной оптимизацией.
           E - выражение с компил€цией переменных X, Y, T, S: extended без оптимизации.
           DO - выражение с компил€цией переменных X, Y, T, S: double и полной оптимизацией.
           D - выражение с компил€цией переменных X, Y, T, S: double без оптимизации.

           K_VarXYT+
           —EO - выражение с компил€цией переменных X, Y, T, S: TComplexE  и полной оптимизацией.  ћинима€ часть X,Y,T,S = 0!
           —E - выражение с компил€цией переменных X, Y, T, S: TComplexE без оптимизации.         ћинима€ часть X,Y,T,S = 0!
           —DO - выражение с компил€цией переменных X, Y, T, S: TComplexD и полной оптимизацией.  ћинима€ часть X,Y,T,S = 0!
           —D - выражение с компил€цией переменных X, Y, T, S: TComplexD без оптимизации.         ћинима€ часть X,Y,T,S = 0!


         }


         //(1)EO-E, K_PrecError_EOE;   Re_REO,Im_REO vs Re_RE,Im_RE : Ere_EOE&Eim_EOE -> K_PrecError_EOE
         //Extended
         //RE
         if (Re_REO = 0) or (Re_RE = 0) then
         begin
            if abs(Re_REO-Re_RE) < FErr then Ere_EOE:=False else Ere_EOE:=True;
            if K_Diff = False then absErr_Re_EOE:=abs(Re_REO-Re_RE) else
                                   absErr_Re_EOE_Diff:=abs(Re_REO-Re_RE);
         end
         else
         begin
            ex:=abs((Re_REO-Re_RE)/Re_REO);
            ey:=abs((Re_REO-Re_RE)/Re_RE);
            dErr:=abs(ex-ey)/2;
            if dErr < FErr_Rel then   Ere_EOE:=False else Ere_EOE:=True;

            if K_Diff = False then absErr_Re_EOE:=abs(Re_REO-Re_RE) else
                                   absErr_Re_EOE_Diff:=abs(Re_REO-Re_RE);
         end;


         //IM
         if (Im_REO = 0) or (Im_RE = 0) then
         begin
            if abs(Im_REO-Im_RE) < FErrIM then Eim_EOE:=False else Eim_EOE:=True;
            if K_Diff = False then absErr_Im_EOE:=abs(Im_REO-Im_RE) else
                                   absErr_Im_EOE_Diff:=abs(Im_REO-Im_RE);
         end
         else
         begin
            ex:=abs((Im_REO-Im_RE)/Im_REO);  ey:=abs((Im_REO-Im_RE)/Im_RE);
            dErr:=abs(ex-ey)/2;
            if dErr < FErrIM_Rel then  Eim_EOE:=False else Eim_EOE:=True;
            if K_Diff = False then absErr_Im_EOE:=abs(Im_REO-Im_RE) else
                                   absErr_Im_EOE_Diff:=abs(Im_REO-Im_RE);
         end;



         if (Ere_EOE = True) or (Eim_EOE = True) then
         begin
           BNewExpErr:=True;
           K_PrecError_EOE:=True;
         end;
         inc(NCmpExpr);






         //(2) DO-D, K_PrecError_DOD:  Re_RDO, Im_RDO vs Re_RD,Im_RD :  EreDOD&Eim_DOD -> K_PrecError_DOD,
         //Double
         //RE
         if (Re_RDO = 0) or (Re_RD = 0) then
         begin
            if abs(Re_RDO-Re_RD) < FErrDbl then Ere_DOD:=False else Ere_DOD:=True;
            if K_Diff = False then absErr_Re_DOD:=abs(Re_RDO-Re_RD) else
                                   absErr_Re_DOD_Diff:=abs(Re_RDO-Re_RD);
         end
         else
         begin
            ex:=abs((Re_RDO-Re_RD)/Re_RDO);  ey:=abs((Re_RDO-Re_RD)/Re_RD);
            dErr:=abs(ex-ey)/2;
            if dErr < FErr_RelDbl then   Ere_DOD:=False else Ere_DOD:=True;
            if K_Diff = False then absErr_Re_DOD:=abs(Re_RDO-Re_RD) else
                                   absErr_Re_DOD_Diff:=abs(Re_RDO-Re_RD);
         end;


         //IM
         if (Im_RDO = 0) or (Im_RD = 0) then
         begin
            if abs(Im_RDO-Im_RD) < FErrIMDbl then Eim_DOD:=False else Eim_DOD:=True;
            if K_Diff = False then absErr_Im_DOD:=abs(Im_RDO-Im_RD) else
                                   absErr_Im_DOD_Diff:=abs(Im_RDO-Im_RD);
         end
         else
         begin
            ex:=abs((Im_RDO-Im_RD)/Im_RDO);  ey:=abs((Im_RDO-Im_RD)/Im_RD);
            dErr:=abs(ex-ey)/2;
            if dErr < FErrIM_RelDbl then  Eim_DOD:=False else Eim_DOD:=True;
            if K_Diff = False then absErr_Im_DOD:=abs(Im_RDO-Im_RD) else
                                   absErr_Im_DOD_Diff:=abs(Im_RDO-Im_RD);
         end;


         if (Ere_DOD = True) or (Eim_DOD = True) then
         begin
           BNewExpErr:=True;
           K_PrecError_DOD:=True;
         end;
         inc(NCmpExpr);





         if K_CmpED = True then
         begin

            //(3) EO-DO, K_PrecError_EODO:   Re_REO,Im_REO vs Re_RDO,Im_RDO : Ere_EODO&Eim_EODO -> K_PrecError_EODO,
            //Extended <-> Double
            //RE
            if (Re_REO = 0) or (Re_RDO = 0) then      //сравнение extended <->double по точности double!
            begin
               if abs(Re_REO-Re_RDO) < FErrDbl then Ere_EODO:=False else Ere_EODO:=True;
            end
            else
            begin
               ex:=abs((Re_REO-Re_RDO)/Re_REO);  ey:=abs((Re_REO-Re_RDO)/Re_RDO);
               dErr:=abs(ex-ey)/2;
               if dErr < FErr_RelDbl then   Ere_EODO:=False else Ere_EODO:=True;
            end;

            //IM
            if (Im_REO = 0) or (Im_RDO = 0) then
            begin
              if abs(Im_REO-Im_RDO) < FErrIMDbl then Eim_EODO:=False else Eim_EODO:=True;
            end
            else
            begin
               ex:=abs((Im_REO-Im_RDO)/Im_REO);  ey:=abs((Im_REO-Im_RDO)/Im_RDO);
               dErr:=abs(ex-ey)/2;
               if dErr < FErrIM_RelDbl then   Eim_EODO:=False else Eim_EODO:=True;
            end;


            if (Ere_EODO = True) or (Eim_EODO = True) then
            begin
              BNewExpErr:=True;
              K_PrecError_EODO:=True;
            end;
            inc(NCmpExpr);



            //(4) E-D, K_PrecError_ED:   Re_RE,Im_RE vs Re_RD,Im_RD : Ere_ED&Eim_ED -> K_PrecError_ED,
            //Extended <-> Double
            //RE
            if (Re_RE = 0) or (Re_RD = 0) then          //сравнение extended <->double по точности double!
            begin
               if abs(Re_RE-Re_RD) < FErrDbl then Ere_ED:=False else Ere_ED:=True;
            end
            else
            begin
               ex:=abs((Re_RE-Re_RD)/Re_RE);  ey:=abs((Re_RE-Re_RD)/Re_RD);
               dErr:=abs(ex-ey)/2;
               if dErr < FErr_RelDbl then   Ere_ED:=False else Ere_ED:=True;
            end;

            //IM
            if (Im_RE = 0) or (Im_RD = 0) then
            begin
              if abs(Im_RE-Im_RD) < FErrIMDbl then Eim_ED:=False else Eim_ED:=True;
            end
            else
            begin
               ex:=abs((Im_RE-Im_RD)/Im_RE);  ey:=abs((Im_RE-Im_RD)/Im_RD);
               dErr:=abs(ex-ey)/2;
               if dErr < FErrIM_RelDbl then   Eim_ED:=False else Eim_ED:=True;
            end;


            if (Ere_ED = True) or (Eim_ED = True) then
            begin
              BNewExpErr:=True;
              K_PrecError_ED:=True;
            end;
            inc(NCmpExpr);



         end; //K_CmpED





         if K_VarXYT = True then
         begin


            //(5)  CEO-CE,K_PrecError_CEOCE:  Re_CEO,Im_CEO vs Re_CE,Im_CE :  Ere_CEOCE&Eim_CEOCE -> K_PrecError_CEOCE,
            //Extended
            //RE
            if (Re_CEO = 0) or (Re_CE = 0) then
            begin
               if abs(Re_CEO-Re_CE) < FErr then Ere_CEOCE:=False else Ere_CEOCE:=True;
               if K_Diff = False then absErr_Re_CEOCE:=abs(Re_CEO-Re_CE) else
                                      absErr_Re_CEOCE_Diff:=abs(Re_CEO-Re_CE);
            end
            else
            begin
               ex:=abs((Re_CEO-Re_CE)/Re_CEO);  ey:=abs((Re_CEO-Re_CE)/Re_CE);
               dErr:=abs(ex-ey)/2;
               if dErr < FErr_Rel then   Ere_CEOCE:=False else Ere_CEOCE:=True;
               if K_Diff = False then absErr_Re_CEOCE:=abs(Re_CEO-Re_CE) else
                                      absErr_Re_CEOCE_Diff:=abs(Re_CEO-Re_CE);
            end;

            //IM
            if (Im_CEO = 0) or (Im_CE = 0) then
            begin
               if abs(Im_CEO-Im_CE) < FErrIM then Eim_CEOCE:=False else Eim_CEOCE:=True;
               if K_Diff = False then absErr_Im_CEOCE:=abs(Im_CEO-Im_CE) else
                                      absErr_Im_CEOCE_Diff:=abs(Im_CEO-Im_CE);
            end
            else
            begin
               ex:=abs((Im_CEO-Im_CE)/Im_CEO);  ey:=abs((Im_CEO-Im_CE)/Im_CE);
               dErr:=abs(ex-ey)/2;
               if dErr < FErrIM_Rel then  Eim_CEOCE:=False else Eim_CEOCE:=True;
               if K_Diff = False then absErr_Im_CEOCE:=abs(Im_CEO-Im_CE) else
                                      absErr_Im_CEOCE_Diff:=abs(Im_CEO-Im_CE);
            end;

            if (Ere_CEOCE = True) or (Eim_CEOCE = True) then
            begin
              BNewExpErr:=True;
              K_PrecError_CEOCE:=True;
            end;
            inc(NCmpExpr);



             //(6)  CDO-CD,K_PrecError_CDOCD:  Re_CDO,Im_CDO vs Re_CD,Im_CD :  Ere_CDOCD&Eim_CDOCD -> K_PrecError_CDOCD,
             //Double
             //RE
            if (Re_CDO = 0) or (Re_CD = 0) then
            begin
               if abs(Re_CDO-Re_CD) < FErrDbl then Ere_CDOCD:=False else Ere_CDOCD:=True;
               if K_Diff = False then absErr_Re_CDOCD:=abs(Re_CDO-Re_CD) else
                                      absErr_Re_CDOCD_Diff:=abs(Re_CDO-Re_CD);
            end
            else
            begin
               ex:=abs((Re_CDO-Re_CD)/Re_CDO);  ey:=abs((Re_CDO-Re_CD)/Re_CD);
               dErr:=abs(ex-ey)/2;
               if dErr < FErr_RelDbl then   Ere_CDOCD:=False else Ere_CDOCD:=True;
               if K_Diff = False then absErr_Re_CDOCD:=abs(Re_CDO-Re_CD) else
                                      absErr_Re_CDOCD_Diff:=abs(Re_CDO-Re_CD);

            end;

            //IM
           if (Im_CDO = 0) or (Im_CD = 0) then
            begin
               if abs(Im_CDO-Im_CD) < FErrIMDbl then Eim_CDOCD:=False else Eim_CDOCD:=True;
               if K_Diff = False then absErr_Im_CDOCD:=abs(Im_CDO-Im_CD) else
                                      absErr_Im_CDOCD_Diff:=abs(Im_CDO-Im_CD);
            end
            else
            begin
               ex:=abs((Im_CDO-Im_CD)/Im_CDO);  ey:=abs((Im_CDO-Im_CD)/Im_CD);
               dErr:=abs(ex-ey)/2;
               if dErr < FErrIM_RelDbl then  Eim_CDOCD:=False else Eim_CDOCD:=True;
               if K_Diff = False then absErr_Im_CDOCD:=abs(Im_CDO-Im_CD) else
                                      absErr_Im_CDOCD_Diff:=abs(Im_CDO-Im_CD);
            end;

            if (Ere_CDOCD = True) or (Eim_CDOCD = True) then
            begin
              BNewExpErr:=True;
              K_PrecError_CDOCD:=True;
            end;
            inc(NCmpExpr);



            if K_CmpED = True then
            begin

           // K_PrecError_CEOCDO,    CEO-CDO              (7)
           // K_PrecError_CECD,      CE-CD                (8)

               //(7) CEO-CDO,K_PrecError_CEOCDO:   Re_CEO,Im_CEO vs Re_CDO,Im_CDO : Ere_CEOCDO&Eim_CEOCDO -> K_PrecError_CEOCDO,
               //Extended <-> Double
               //RE
               if (Re_CEO = 0) or (Re_CDO = 0) then                //сравнение extended <->double по точности double!
               begin
                  if abs(Re_CEO-Re_CDO) < FErrDbl then Ere_CEOCDO:=False else Ere_CEOCDO:=True;
               end
               else
               begin
                  ex:=abs((Re_CEO-Re_CDO)/Re_CEO);  ey:=abs((Re_CEO-Re_CDO)/Re_CDO);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErr_RelDbl then   Ere_CEOCDO:=False else Ere_CEOCDO:=True;
               end;

               //IM
               if (Im_CEO = 0) or (Im_CDO = 0) then
               begin
                  if abs(Im_CEO-Im_CDO) < FErrIMDbl then Eim_CEOCDO:=False else Eim_CEOCDO:=True;
               end
               else
               begin
                  ex:=abs((Im_CEO-Im_CDO)/Im_CEO);  ey:=abs((Im_CEO-Im_CDO)/Im_CDO);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErrIM_RelDbl then   Eim_CEOCDO:=False else Eim_CEOCDO:=True;
               end;


               if (Ere_CEOCDO = True) or (Eim_CEOCDO = True) then
               begin
                 BNewExpErr:=True;
                 K_PrecError_CEOCDO:=True;
               end;
               inc(NCmpExpr);


               //(8) CE-CD,K_PrecError_CECD:   Re_CE,Im_CE vs Re_CD,Im_CD : Ere_CECD&Eim_CECD -> K_PrecError_CECD,
               //Extended <-> Double
               //RE
               if (Re_CE = 0) or (Re_CD = 0) then             //сравнение extended <->double по точности double!
               begin
                  if abs(Re_CE-Re_CD) < FErrDbl then Ere_CECD:=False else Ere_CECD:=True;
               end
               else
               begin
                  ex:=abs((Re_CE-Re_CD)/Re_CE);  ey:=abs((Re_CE-Re_CD)/Re_CD);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErr_RelDbl then   Ere_CECD:=False else Ere_CECD:=True;
               end;

               //IM
               if (Im_CE = 0) or (Im_CD = 0) then
               begin
                  if abs(Im_CE-Im_CD) < FErrIMDbl then Eim_CECD:=False else Eim_CECD:=True;
               end
               else
               begin
                  ex:=abs((Im_CE-Im_CD)/Im_CE);  ey:=abs((Im_CE-Im_CD)/Im_CD);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErrIM_RelDbl then   Eim_CECD:=False else Eim_CECD:=True;
               end;


               if (Ere_CECD = True) or (Eim_CECD = True) then
               begin
                 BNewExpErr:=True;
                 K_PrecError_CECD:=True;
               end;
               inc(NCmpExpr);


            end; // K_CmpED




            if K_CmpXYT = True then
            begin

                //(9) EO-CEO, K_PrecError_EOCEO:  Re_REO,Im_REO vs Re_CEO,Im_CEO : Ere_EOCEO&Eim_EOCEO -> K_PrecError_EOCEO,
                //Extended
                //RE
               if (Re_REO = 0) or (Re_CEO = 0) then
               begin
                  if abs(Re_REO-Re_CEO) < FErr then Ere_EOCEO:=False else Ere_EOCEO:=True;
                  if K_Diff = False then absErr_Re_EOCEO:=abs(Re_REO-Re_CEO) else
                                         absErr_Re_EOCEO_Diff:=abs(Re_REO-Re_CEO);
               end
               else
               begin
                  ex:=abs((Re_REO-Re_CEO)/Re_REO);  ey:=abs((Re_REO-Re_CEO)/Re_CEO);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErr_Rel then   Ere_EOCEO:=False else Ere_EOCEO:=True;
                  if K_Diff = False then absErr_Re_EOCEO:=abs(Re_REO-Re_CEO) else
                                         absErr_Re_EOCEO_Diff:=abs(Re_REO-Re_CEO);
               end;

               //IM
               if (Im_REO = 0) or (Im_CEO = 0) then
               begin
                  if abs(Im_REO-Im_CEO) < FErrIM then Eim_EOCEO:=False else Eim_EOCEO:=True;
                  if K_Diff = False then absErr_Im_EOCEO:=abs(Im_REO-Im_CEO) else
                                         absErr_Im_EOCEO_Diff:=abs(Im_REO-Im_CEO);
               end
               else
               begin
                  ex:=abs((Im_REO-Im_CEO)/Re_REO);  ey:=abs((Im_REO-Im_CEO)/Im_CEO);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErrIM_Rel then   Eim_EOCEO:=False else Eim_EOCEO:=True;
                  if K_Diff = False then absErr_Im_EOCEO:=abs(Im_REO-Im_CEO) else
                                         absErr_Im_EOCEO_Diff:=abs(Im_REO-Im_CEO);
               end;

               if (Ere_EOCEO = True) or (Eim_EOCEO = True) then
               begin
                 BNewExpErr:=True;
                 K_PrecError_EOCEO:=True;
               end;
               inc(NCmpExpr);



               //(10) DO-CDO,K_PrecError_DOCDO:  Re_RDO,Im_RDO vs Re_CDO,Im_CDO : Ere_DOCDO&Eim_DOCDO -> K_PrecError_DOCDO
               //Double
               //RE
               if (Re_RDO = 0) or (Re_CDO = 0) then
               begin
                  if abs(Re_RDO-Re_CDO) < FErrDbl then Ere_DOCDO:=False else Ere_DOCDO:=True;
                  if K_Diff = False then absErr_Re_DOCDO:=abs(Re_RDO-Re_CDO) else
                                         absErr_Re_DOCDO_Diff:=abs(Re_RDO-Re_CDO);
               end
               else
               begin
                  ex:=abs((Re_RDO-Re_CDO)/Re_RDO);  ey:=abs((Re_RDO-Re_CDO)/Re_CDO);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErr_RelDbl then   Ere_DOCDO:=False else Ere_DOCDO:=True;
                  if K_Diff = False then absErr_Re_DOCDO:=abs(Re_RDO-Re_CDO) else
                                         absErr_Re_DOCDO_Diff:=abs(Re_RDO-Re_CDO);
               end;

               //IM
               if (Im_RDO = 0) or (Im_CDO = 0) then
               begin
                  if abs(Im_RDO-Im_CDO) < FErrIMDbl then Eim_DOCDO:=False else Eim_DOCDO:=True;
                  if K_Diff = False then absErr_Im_DOCDO:=abs(Im_RDO-Im_CDO) else
                                         absErr_Im_DOCDO_Diff:=abs(Im_RDO-Im_CDO);
               end
               else
               begin
                  ex:=abs((Im_RDO-Im_CDO)/Im_RDO);  ey:=abs((Im_RDO-Im_CDO)/Im_CDO);
                  dErr:=abs(ex-ey)/2;
                  if dErr < FErrIM_RelDbl then   Eim_DOCDO:=False else Eim_DOCDO:=True;
                  if K_Diff = False then absErr_Im_DOCDO:=abs(Im_RDO-Im_CDO) else
                                         absErr_Im_DOCDO_Diff:=abs(Im_RDO-Im_CDO);
                  //absErr:=abs();
               end;

               if (Ere_DOCDO = True) or (Eim_DOCDO = True) then
               begin
                 BNewExpErr:=True;
                 K_PrecError_DOCDO:=True;
               end;
               inc(NCmpExpr);

            end; //K_CmpXYT





         end; //K_VarXYT







         if BNewExpErr = True then
         begin
            SetLength(TestExprError,Length(TestExprError)+1);
            TestExprError[High(TestExprError)].NExpr:=NExpr;
            TestExprError[High(TestExprError)].NCExpr:=i;
            TestExprError[High(TestExprError)].K_Diff:=K_Diff;
            TestExprError[High(TestExprError)].K_VarXYT:=K_VarXYT;
            TestExprError[High(TestExprError)].K_CmpED:=K_CmpED;
            TestExprError[High(TestExprError)].K_CmpXYT:=K_CmpXYT;
            TestExprError[High(TestExprError)].K_PrecError:=True;
            TestExprError[High(TestExprError)].K_PrecError_EOE:=K_PrecError_EOE;
            TestExprError[High(TestExprError)].K_PrecError_DOD:=K_PrecError_DOD;
            TestExprError[High(TestExprError)].K_PrecError_CEOCE:=K_PrecError_CEOCE;
            TestExprError[High(TestExprError)].K_PrecError_CDOCD:=K_PrecError_CDOCD;
            TestExprError[High(TestExprError)].K_PrecError_EODO:=K_PrecError_EODO;
            TestExprError[High(TestExprError)].K_PrecError_EOCEO:=K_PrecError_EOCEO;
            TestExprError[High(TestExprError)].K_PrecError_DOCDO:=K_PrecError_DOCDO;
            TestExprError[High(TestExprError)].K_PrecError_ED:=K_PrecError_ED;
            TestExprError[High(TestExprError)].K_PrecError_CEOCDO:=K_PrecError_CEOCDO;
            TestExprError[High(TestExprError)].K_PrecError_CECD:=K_PrecError_CECD;


            TestExprError[High(TestExprError)].absErr_Re_EOE:=absErr_Re_EOE;
            TestExprError[High(TestExprError)].absErr_Re_EOE_Diff:=absErr_Re_EOE_Diff;


            TestExprError[High(TestExprError)].absErr_Im_EOE:=absErr_Im_EOE;
            TestExprError[High(TestExprError)].absErr_Im_EOE_Diff:=absErr_Im_EOE_Diff;


            TestExprError[High(TestExprError)].absErr_Re_DOD:=absErr_Re_DOD;
            TestExprError[High(TestExprError)].absErr_Re_DOD_Diff:=absErr_Re_DOD_Diff;


            TestExprError[High(TestExprError)].absErr_Im_DOD:=absErr_Im_DOD;
            TestExprError[High(TestExprError)].absErr_Im_DOD_Diff:=absErr_Im_DOD_Diff;


            TestExprError[High(TestExprError)].absErr_Re_CEOCE:=absErr_Re_CEOCE;
            TestExprError[High(TestExprError)].absErr_Re_CEOCE_Diff:=absErr_Re_CEOCE_Diff;

            TestExprError[High(TestExprError)].absErr_Im_CEOCE:=absErr_Im_CEOCE;
            TestExprError[High(TestExprError)].absErr_Im_CEOCE_Diff:=absErr_Im_CEOCE_Diff;



            TestExprError[High(TestExprError)].absErr_Re_CDOCD:=absErr_Re_CDOCD;
            TestExprError[High(TestExprError)].absErr_Re_CDOCD_Diff:=absErr_Re_CDOCD_Diff;

            TestExprError[High(TestExprError)].absErr_Im_CDOCD:=absErr_Im_CDOCD;
            TestExprError[High(TestExprError)].absErr_Im_CDOCD_Diff:=absErr_Im_CDOCD_Diff;



            TestExprError[High(TestExprError)].absErr_Re_EOCEO:=absErr_Re_EOCEO;
            TestExprError[High(TestExprError)].absErr_Re_EOCEO_Diff:=absErr_Re_EOCEO_Diff;

            TestExprError[High(TestExprError)].absErr_Im_EOCEO:=absErr_Im_EOCEO;
            TestExprError[High(TestExprError)].absErr_Im_EOCEO_Diff:=absErr_Im_EOCEO_Diff;


            TestExprError[High(TestExprError)].absErr_Re_DOCDO:=absErr_Re_DOCDO;
            TestExprError[High(TestExprError)].absErr_Re_DOCDO_Diff:=absErr_Re_DOCDO_Diff;

            TestExprError[High(TestExprError)].absErr_Im_DOCDO:=absErr_Im_DOCDO;
            TestExprError[High(TestExprError)].absErr_Im_DOCDO_Diff:=absErr_Im_DOCDO_Diff;




            {
            TestExprError[High(TestExprError)].K_CalcError_RE :=K_CalcError_RE;
            TestExprError[High(TestExprError)].K_CalcError_RDO:=K_CalcError_RDO;
            TestExprError[High(TestExprError)].K_CalcError_RD:=K_CalcError_RD;
            TestExprError[High(TestExprError)].K_CalcError_CREO:=K_CalcError_CREO;
            TestExprError[High(TestExprError)].K_CalcError_CRE:=K_CalcError_CRE;
            TestExprError[High(TestExprError)].K_CalcError_CRDO:=K_CalcError_CRDO;
            TestExprError[High(TestExprError)].K_CalcError_CRD:=True;
            }
            goto NxtExpr;
         end;

         if K_Diff = True  then
            begin
               MT.Lines.Add('('+IntToStr(NExpr+1-NStrCom)+')  >  Diff: OK')
              { StrOut:='('+IntToStr(NExpr+1-NStrCom)+')  >  Diff: OK';
               OutStr(StrOut);
               }
            end
            else
            begin
               MT.Lines.Add('('+IntToStr(NExpr+1-NStrCom)+')  >  Expr: OK')
              { StrOut:='('+IntToStr(NExpr+1-NStrCom)+')  >  Expr: OK';
               OutStr(StrOut); }
            end



      end
      else    //K_StrCom = True
      begin
         StrCom:=TestExprList[NExpr].StrCom;
         MT.Lines.Add(StrCom);
         inc(NStrCom);
      end;

    NxtExpr:
   end;
   MT.Lines.Add('---------------------------------------');
   MT.Lines.Add(' Total numbers  comparing  of results :  ' + IntToStr(NCmpExpr));
   MT.Lines.Add('---------------------------------------');

end;



procedure TForm1.ShowTestExprError;
var
   i,L,NExpr: integer;
   Expr,DExpr,SE: String;
   K_Diff,K_VarXYT,K_CmpED,K_CmpXYT: Boolean;
   K_CalcError_REO,K_CalcError_RE,K_CalcError_RDO,K_CalcError_RD,K_CalcError_CEO,K_CalcError_CE,K_CalcError_CDO,K_CalcError_CD: Boolean;

   K_PrecError_EOE,K_PrecError_DOD,K_PrecError_CEOCE, K_PrecError_CDOCD, K_PrecError_EODO,K_PrecError_EOCEO,K_PrecError_DOCDO,
   K_PrecError_ED,K_PrecError_CEOCDO,K_PrecError_CECD: Boolean;
   SKeys,SKeysE: String;
begin
  L:=Length(TestExprError);
  MT.Lines.Add(' **************************************************************');
  MT.Lines.Add(' **************     ERROR LIST   ******************************');
  MT.Lines.Add(' **************************************************************');
  if L > 0 then
  begin

     for i := 0 to L-1 do
     begin
       SE:='';
       SKeys:=' Keys:  ';
       K_Diff:=TestExprError[i].K_Diff;
       K_VarXYT:=TestExprError[i].K_VarXYT;
       K_CmpED:=TestExprError[High(TestExprError)].K_CmpED;
       K_CmpXYT:=TestExprError[High(TestExprError)].K_CmpXYT;
       NExpr:=TestExprError[i].NExpr;
       Expr:=TestExprList[NExpr].Expr;
       K_PrecError_EOE:=TestExprError[i].K_PrecError_EOE ;
       K_PrecError_DOD:=TestExprError[i].K_PrecError_DOD ;
       K_PrecError_CEOCE:=TestExprError[i].K_PrecError_CEOCE ;
       K_PrecError_CDOCD:=TestExprError[i].K_PrecError_CDOCD ;
       K_PrecError_EODO:=TestExprError[i].K_PrecError_EODO ;
       K_PrecError_EOCEO:=TestExprError[i].K_PrecError_EOCEO ;
       K_PrecError_DOCDO:=TestExprError[i].K_PrecError_DOCDO ;
       K_PrecError_ED:=TestExprError[High(TestExprError)].K_PrecError_ED;
       K_PrecError_CEOCDO:=TestExprError[High(TestExprError)].K_PrecError_CEOCDO;
       K_PrecError_CECD:=TestExprError[High(TestExprError)].K_PrecError_CECD;

       if TestExprError[i].K_CalcError = True then
       begin
           if K_Diff = True then    SE:='Calculation Error in DIFF of expression:  '
           else                     SE:='Calculation Error in expression:  ';


           //if K_VarXYT = True then  SE:=SE+ '  X,Y,T- Complex';
           MT.Lines.Add(SE);
           MT.Lines.Add('>>    '+Expr);
       end
       else
       if TestExprError[i].K_PrecError = True then
       begin
           if K_Diff = True then
           begin
              SE:='Precision Error in DIFF of expression.  ';
              SKeys:=SKeys+' $Diff, ';
           end
           else
              SE:='Precision Error in expression.  ';


            SE:=SE+'In MODES: '+#13#10;

            if K_PrecError_EOE = True then
            begin
                SE:=SE+' [ ExtVar+Optimization <-> ExtVar; x,y,t: Extended; z1,z2,z3:TComplexE ];  '+SKeys+#13#10;
                if K_Diff = True then
                SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_EOE_Diff)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_EOE_Diff)+#13#10
                else
                SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_EOE)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_EOE)+#13#10;
            end;

            if K_PrecError_DOD = True then
            begin
                SE:=SE+' [ DblVar+Optimization <-> DblVar; x,y,t: Double; z1,z2,z3:TComplexD ]'+SKeys+#13#10;
                if K_Diff = True then
                SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_DOD_Diff)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_DOD_Diff)+#13#10
                else
                SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_DOD)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_DOD)+#13#10;
            end;


            if K_CmpED = True then
            begin
                SKeysE:=SKeys+' $CompareED ';
                if K_PrecError_EODO = True then  SE:=SE+' [ ExtVar+Optimization <-> DblVar+Optimization; x,y,t:extended; z1,z2,z3: TComplexE <-> double; TComplexD ];'+SKeysE+#13#10;
                if K_PrecError_ED = True then    SE:=SE+' [ ExtVar <-> DblVar; x,y,t:extended; z1,z2,z3: TComplexE <-> double; TComplexD ];'+SKeysE+#13#10;
            end;



            if K_VarXYT = True then
            begin
               SKeysE:=SKeys+' $RealToComplexVar_XYT ';
               if K_PrecError_CEOCE = True then
               begin
                  SE:=SE+' [ ExtVar+Optimization <-> ExtVar; x,y,t,s: im=0, z1,z2,z3: TComplexE ];'+SKeysE+#13#10;
                  if K_Diff = True then
                  SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_CEOCE_Diff)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_CEOCE_Diff)+#13#10
                  else
                  SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_CEOCE)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_CEOCE)+#13#10;
               end;

               if K_PrecError_CDOCD = True then
               begin
                  SE:=SE+' [ DblVar+Optimization <-> DblVar; x,y,t,s: im=0, z1,z2,z3: TComplexD ]'+SKeysE+#13#10;
                  if K_Diff = True then
                  SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_CDOCD_Diff)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_CDOCD_Diff)+#13#10
                  else
                  SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_CDOCD)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_CDOCD)+#13#10;
               end;



               if K_CmpED = True then
               begin
                  //SKeys:=SKeys+' $CompareED ';
                  SKeysE:=SKeys+' $RealToComplexVar_XYT,  $CompareED ';
                  if K_PrecError_CEOCDO = True then  SE:=SE+' [ ExtVar+Optimization <-> DblVar+Optimization; x,y,t,s: im=0, z1,z2,z3: TComplexE <-> TComplexD ];'+SKeysE+#13#10;
                  if K_PrecError_CECD = True then    SE:=SE+' [ ExtVar <-> DblVar; x,y,t,s: im=0, z1,z2,z3: TComplexE <-> TComplexD ];'+SKeysE+#13#10;
               end;



               if K_CmpXYT = True then
               begin
                  SKeysE:=SKeys+' $CompareComplex_XYT, $RealToComplexVar_XYT ';
                  if K_PrecError_EOCEO = True then
                  begin
                     SE:=SE+' [ ExtVar+Optimization(x,y,t,s: extended) <-> ExtVar+Optimization(x,y,t,s: TComplexE, im=0); z1,z2,z3: TComplexE ]'+SKeysE+#13#10;
                     if K_Diff = True then
                     SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_EOCEO_Diff)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_EOCEO_Diff)+#13#10
                     else
                     SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_EOCEO)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_EOCEO)+#13#10;
                  end;

                  if K_PrecError_DOCDO = True then
                  begin
                     SE:=SE+' [ DblVar+Optimization(x,y,t,s: double) <-> DblVar+Optimization(x,y,t,s: TComplexD, im=0); z1,z2,z3: TComplexD ]'+SKeysE+#13#10;
                     if K_Diff = True then
                     SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_DOCDO_Diff)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_DOCDO_Diff)+#13#10
                     else
                     SE:=SE+'AbsError in Re:'+ FloatToStr(TestExprError[i].absErr_Re_DOCDO)+';   AbsError in Im:'+ FloatToStr(TestExprError[i].absErr_Im_DOCDO)+#13#10;
                  end;
               end;

            end;



           //if K_VarXYT = True then  SE:=SE+ '  X,Y,T- Complex';
           MT.Lines.Add(SE);
           MT.Lines.Add('Expression:');
           MT.Lines.Add('>>    '+Expr+#13#10);
           MT.Lines.Add('------------------------------------------------------');

       end

     end;
  end
  else
  begin
       MT.Lines.Add('    EMPTY   ');
  end;
end;



procedure TForm1.FreeCompiledList;
var
  i,L: Integer;
  RExprEO,RExprE,RExprDO,RExprD,CExprEO,CExprE,CExprDO,CExprD : Pointer;
begin
  L:=Length(TestExprCmpl);
  for i := 0 to L-1 do
  begin

         RExprEO:=TestExprCmpl[i].RExprEO;
         RExprE :=TestExprCmpl[i].RExprE;
         RExprDO:=TestExprCmpl[i].RExprDO;
         RExprD :=TestExprCmpl[i].RExprD;
         CExprEO:=TestExprCmpl[i].CExprEO;
         CExprE :=TestExprCmpl[i].CExprE;
         CExprDO:=TestExprCmpl[i].CExprDO;
         CExprD :=TestExprCmpl[i].CExprD;

         flPerform(fl_FREE,Cardinal(RExprEO));
         flPerform(fl_FREE,Cardinal(RExprE));
         flPerform(fl_FREE,Cardinal(RExprDO));
         flPerform(fl_FREE,Cardinal(RExprD));
         flPerform(fl_FREE,Cardinal(CExprEO));
         flPerform(fl_FREE,Cardinal(CExprE));
         flPerform(fl_FREE,Cardinal(CExprDO));
         flPerform(fl_FREE,Cardinal(CExprD));

  end;

end;


{
  x, y: ext;   1E-35
  x,y dbl;    1E-31
  x= 0.123456789123456789;      y= 0.123456789123456788;     ex:ext=abs((x-y)/x);  ey:ext=abs((x-y)/y); abs(ex-ey)
  x= 123456789123456789;        y= 123456789123456788;       ex:ext=abs((x-y)/x);  ey:ext=abs((x-y)/y); abs(ex-ey)
  x= 123456789123456789E50;     y= 123456789123456788E50;    ex:ext=abs((x-y)/x);  ey:ext=abs((x-y)/y); abs(ex-ey)
  x= 1.23456789123456789E-50;   y= 1.23456789123456788E-50;  ex:ext=abs((x-y)/x);  ey:ext=abs((x-y)/y); abs(ex-ey)

  с точностью до:
  CP=15; число знаков в числе после зап€той,например: 1.23456789123456789 ; CP=15 соответствует: 1.234567891234567;
  критерий E < 10^(-2*CP) = 10E-30;   abs(ex-ey) < E

}

procedure TForm1.IntTestClick(Sender: TObject);
label endp;
var
res, res_opt, res_rf, resCxyt, resCxyt_opt, resCxyt_rf: TComplexE;
S: String;
begin
(*
    јвтоматическое тестирование выражений, заданных в файле   TestExpressions.txt
    ¬се выражени€ должны заканчиватьс€ символом ';' !!!
     омпил€ци€ всех действительных и комплексных выражений идЄт в режиме  flSet(fl_RESULT_LEAD_TO_TYPE, fl_Complex,0);
    ƒалее, вычисление в цикле 10 (любое > 8, дл€ вы€влени€ перегрузки FPU) и сравнение разницы результатов на вы€вление ошибки
    ex:ext=abs((res1.re-res2.re)/res1.re);  ey:ext=abs((res1.re-res2.re)/res2.re); abs(ex-ey) <   10^(-2*CP) = 10E-30;
    CP=15; число знаков в числе после зап€той
    » тоже самое дл€ мнимых частей.




     омпил€ци€ всех действительных выражений в файле  в 8 видах (c установкой  ключа  {$RealToComplexVar_XYT+}) :
      действительные x,y,t,s:
        на тип extended (переменные и стек): (1) полна€ оптимизаци€  (2) отключение всех оптимизаций
        на тип double (переменные и стек):   (3) полна€ оптимизаци€  (4) отключение всех оптимизаций
      комплексные x,y,t,s (мнима€ часть x,y,t,s = 0):     {$RealToComplexVar_XYT+}
        на тип extended (переменные и стек): (5) полна€ оптимизаци€  (6) отключение всех оптимизаций
        на тип double (переменные и стек):   (7) полна€ оптимизаци€  (8) отключение всех оптимизаций



      (1) -  RExprEO (2) - RExprE
      (3) -  RExprDO (4) - RExprD
      (5) -  CExprEO (6) - CExprE
      (7) -  CExprDO (8) - CExprD



     омпил€ци€ всех комплексных выражений в файле  в 4 видах:

        комплексные z1,z2,z3 :
          на тип extended (переменные и стек): (1) полна€ оптимизаци€  (2) отключение всех оптимизаций
          на тип double (переменные и стек):   (3) полна€ оптимизаци€  (4) отключение всех оптимизаций

      (1) -  RExprEO (2) - RExprE
      (3) -  RExprDO (4) - RExprD



     лючи компил€ции:

       {$Diff+} {$Diff} - компил€ци€ всех последующих выражений выполн€етс€ также и дл€ их производных, включа€ производные от комплексных выражений , если задан  {$RealToComplexVar_XYT+}
       {$Diff}  - отключает этот режим.

       {$ListDiffVar: x:2,y:1,t,z} - задаЄт список переменных , степени  и пор€док дл€ дифференцировани€  последующих выражений, если установлен ключ $Diff

       {$RealToComplexVar_XYT+} -  к компил€ции всех последующих выражений добавл€етс€  дополнительна€ коммпил€ци€ этих выражений через замену
                                   действительных переменных X, Y, T, S на такие же комплексные с мнимой частью равной нулю!

       {$RealToComplexVar_XYT-} -  отключает этот режим.

       ћаксимальное число  переменных дл€ дифференцировани€ в ключе $ListDiffVar - 5.

       ѕеременные дифференцировани€ могут быть комплексными:   {$ListDiffVar: z1:1, z2:1, x}

       ѕри задании всех ключей компил€ции:  {$Diff+} , {$RealToComplexVar_XYT+}  каждое выражение имеет 16 компил€ций:
          (1) -  RExprEO (2) - RExprE
          (3) -  RExprDO (4) - RExprD
          (5) -  CExprEO (6) - CExprE
          (7) -  CExprDO (8) - CExprD

          (1)-(4) компил€ци€ выражени€ с разными типами переменных и оптимизации.
          (5)-(8) компил€ци€ выражени€ с заменой X,Y,T на комплексные переменные с мнимой частью = 0 и разными типами переменных и оптимизации.

          и такие же компил€ции дл€ производной этого выражени€ по переменным, заданным в {$ListDiffVar: ...} ¬сего -16.



       {$ErrorPrecision:  14} - сравнение результатов всех последующих выражений выполн€етс€ с точностью до этого знака после зап€той. ¬сЄ что выше, выдаЄтс€ как ошибка.

       ƒополнительные ключи точности:

       {$ErrorPrecisionImage:  12} - сравнение результатов мнимых частей всех последующих выражений выполн€етс€ с точностью до этого знака после зап€той. ¬сЄ что выше, выдаЄтс€ как ошибка.
                                »спользовать  дл€ сравнени€ выражений с действительными переменными X,Y,T,S в режиме  {$RealToComplexVar_XYT+} {$CompareComplex_XYT+}
                                “.к.  оптимизированные ф-ии (чаще всего в режиме CompositeReplace) могут давать большие ошибки в мнимой части в этих выражени€х с комплексными переменными с мнимой частью = 0!

       {$ErrorPrecisionDbl:  12}       - дл€ сравнени€ результатов в режиме: переменные: double
       {$ErrorPrecisionImageDbl:  10}  - тоже самое дл€ мнимых частей.  переменные: double.



       {$StrCom: fgdfgdfgfd fgsdfsdfsd dfgfsdgfsdg} - комментарий дл€ распечатывани€

       {$CompareED+} - сравнивать результаты Extended и Double: RExprEO vs RExprDO; RExprE vs RExprD;
                                                                  CExprEO vs CExprDO; CExprE vs CExprD - если задан ключ {$RealToComplexVar_XYT+}

       {$CompareComplex_XYT+} -  сравнивать результаты  в обычном режиме и  {$RealToComplexVar_XYT+} , если задан.
                                 RExprEO vs CExprEO;  RExprD vs CExprD      im(X,Y,T,S)=0!

         $CompareED, $CompareComplex_XYT - также применимы к производной   {$Diff+}

      “ип комплексного делени€ без оптимизации: standard (по умолчанию), accurate, extra задаЄтс€ перед запуском теста на панели.
      “ип функций исполн€емых функций в тесте независимо от режима : fast, accurate  задаЄтс€ перед запуском теста на панели.
*)

//Ќапример:
(*

   {$ErrorPrecision:  14}
   {$ErrorPrecisionImage:  12}
   {$ErrorPrecisionDbl:  12}
   {$ErrorPrecisionImageDbl:  10}
   {$Diff+}
   {$ListDiffVar: x:1,y:1}
   {$RealToComplexVar_XYT+}
   {$CompareComplex_XYT+}

   (-ai/x-bi*(-c*z1*x/(-z1-a-bi-x/(-(-x/z1*ci)/y*a-b*y/z1/x-b/i)-z2/(-(-y*b*z1/(-z1/x*c-bi/y*z2*d-i/a))/z1))-di/(x-z2/y*b-b/i-ci/i))-c/bi*(-z1*x*b*z2-a/x*ci*y-i/(-i*x+y/i-z1/i+i/z2)));
   -x/(x/y-t/(x+t)+x*y*(x*y-y*t+x/(x/(x+y)+y/(t+x))))*(y*(x-y/(x*y-y/(x*y+y*t)*(y*t-x*y)))+x-y*(x-t-t/(x-y)*(y/(y-t*(x+y*t)*(y-x*t)/(x*t-y*(x+t))))))*(x*y-t*y-t*(x*t-y*(t-x)/(x*y*t-x-y-t)));
   -sin(-cos(-(cos(-x)-sin(-y))))*(cos(-x*sin(-x-y))-sin(-y/cos(-x/sin(-x/y)))-cos(-y/x)-sin(x/(-y))/(-x/sin(y/(-x))-cos(-sin(-x/(-y)))));
   ((tanh(-csch(cosh(x/(x-y))))/sinh(csch(-x/(x+y)))+tanh(sech(x/(x+y)))/coth(csch(x/(x-y))))/(coth(csch(x/(x-y)))/tanh(-csch(cosh(x/(x-y))))-sinh(csch(-x/(x+y)))/tanh(sech(x/(x+y)))))/((sech(tanh(-csch(y/(y-x))))*sinh(x/(x+y))/sech(y/(x-y))/(sinh(-sech(csch(x/(x-y))))*cosh(x/(x-y))-cosh(tanh(-sech(x/(y-x))))*coth(-cosh(sinh(x/(x+y)))))+coth(-cosh(-csch(y/(y-x))))*tanh(sech(-y/(x+y)))*coth(y/(x+y))/(tanh(x/(y-x))*tanh(-sinh(-coth(y/(x+y))))+csch(y/(y-x))*csch(coth(-sinh(x/(x-y))))))) ;

*)




 //MT.Clear;
 LoadExprTestFile('TestExpressions.txt');  //goto endp;
 {
 if F_LoadExprFile = False then
 begin
   ShowMessage('File: TestExpressions.txt is absent');
   goto endp;
 end;
  }
 {
  G_BeginPosEx:=0;
  SetLength(GS_TestExprEx,0);
  G_TestExprEx:=False;
  }

   IntTest.Enabled:=False;

   TestExprTask:=TTestExprTask.Create;
   TestExprTask.FreeOnTerminate:= True;
   TestExprTask.Priority:= tpLower;
   TestExprTask.Resume;

  {
  if CompileExprTest = True then
  begin
    RunExprTest;
    ShowTestExprError;
    FreeCompiledList;
  end;
  }

  //TimerEx.Enabled:=False;

   //TestExprTask.Suspend;
   //TestExprTask.Terminate;

  goto endp;






//stop












 {
   CompileExprTest;
   RunExprTest;
  }




{
RB_FExtended.Checked:=True;
RB_EX.Checked:=True;
RB_PE.Checked:=True;
E_cnt.Text:=IntToStr(10);




//**********************
CB_OP.Checked:=True;
CB_DL.Checked:=True;
CB_MulDiv.Checked:=True;
CB_FD.Checked:=True;
CB_SKIF.Checked:=True;
CB_RF.Checked:=True;
CB_RFCS.Checked:=True;
CB_Div.Checked:=True;
CB_Mul.Checked:=True;
CB_Ras.Checked:=True;
CB_RME.Checked:=True;

UDSD.Position:=8;
Panel1.Caption:=IntToStr(UDSD.Position);
flSet(fl_STACK_DEEP,UDSD.Position);
}

FullOptimization;

 CB_VCx.Checked:=False;
 B_Calc.Click;
 res_opt.re:=G_Res.re;  res_opt.im:=G_Res.im;

 CB_VCx.Checked:=True;
 B_Calc.Click;
 resCxyt_opt.re:=G_Res.re;  resCxyt_opt.im:=G_Res.im;


{
// without replace operations
//**********************
CB_OP.Checked:=True;
CB_DL.Checked:=True;
CB_MulDiv.Checked:=True;
CB_FD.Checked:=True;
CB_SKIF.Checked:=True;
CB_RF.Checked:=True;
CB_RFCS.Checked:=True;
CB_Div.Checked:=False;
CB_Mul.Checked:=False;
CB_Ras.Checked:=False;
CB_RME.Checked:=True;

UDSD.Position:=8;
Panel1.Caption:=IntToStr(UDSD.Position);
flSet(fl_STACK_DEEP,UDSD.Position);
}

 WithoutReplaceOperations;

 CB_VCx.Checked:=False;
 B_Calc.Click;
 res_rf.re:=G_Res.re;  res_rf.im:=G_Res.im;

 CB_VCx.Checked:=True;
 B_Calc.Click;
 resCxyt_rf.re:=G_Res.re;  resCxyt_rf.im:=G_Res.im;


{
// without opt.
 //**********************
CB_OP.Checked:=False;
CB_DL.Checked:=False;
CB_MulDiv.Checked:=False;
CB_FD.Checked:=False;
CB_SKIF.Checked:=False;
CB_RF.Checked:=False;
CB_RFCS.Checked:=False;
CB_Div.Checked:=False;
CB_Mul.Checked:=False;
CB_Ras.Checked:=False;
CB_RME.Checked:=False;

UDSD.Position:=0;
Panel1.Caption:=IntToStr(UDSD.Position);
flSet(fl_STACK_DEEP,UDSD.Position);
}


 WithoutOptimizations;

 CB_VCx.Checked:=False;
 B_Calc.Click;
 res.re:=G_Res.re;  res.im:=G_Res.im;

 CB_VCx.Checked:=True;
 B_Calc.Click;
 resCxyt.re:=G_Res.re;  resCxyt.im:=G_Res.im;
//**********************


{
if (abs(res_opt.re-res.re) < 1E-12 ) or (abs(res_opt.im-res.im) < 1E-12) then
  IPF.Caption:='OK'
else
  IPF.Caption:='ERROR';

if (abs(resCxyt_opt.re-resCxyt.re) < 1E-12 ) or (abs(resCxyt_opt.im-resCxyt.im) < 1E-12) then
  CTF.Caption:='OK'
else
  CTF.Caption:='ERROR';
}


S:=FloatToStrF(Res_opt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res_opt.im, ffGeneral, 20, 4, G_FMT);
MT.Lines[0]:=S;
S:=FloatToStrF(Res_rf.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res_rf.im, ffGeneral, 20, 4, G_FMT);
MT.Lines[1]:=S;
S:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(Res.im, ffGeneral, 20, 4, G_FMT);
MT.Lines[2]:=S;

S:=FloatToStrF(ResCxyt_opt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt_opt.im, ffGeneral, 20, 4, G_FMT);
MT.Lines[3]:=S;
S:=FloatToStrF(ResCxyt_rf.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt_rf.im, ffGeneral, 20, 4, G_FMT);
MT.Lines[4]:=S;
S:=FloatToStrF(ResCxyt.re, ffGeneral, 20, 4, G_FMT)+'   '+FloatToStrF(ResCxyt.im, ffGeneral, 20, 4, G_FMT);
MT.Lines[5]:=S;






 endp:
end;



procedure TForm1.InitDF;
var
n1,n2,n,k,i,j,m: integer;
s: string;
begin
 Adv[1].n:=1;  Adv[1].s:='x';  Adv[1].nd:=1;
 Adv[2].n:=2;  Adv[2].s:='y';  Adv[2].nd:=0;
 Adv[3].n:=3;  Adv[3].s:='t';  Adv[3].nd:=0;
 Adv[4].n:=4;  Adv[4].s:='s';  Adv[4].nd:=0;
end;


procedure TForm1.B_RDOClick(Sender: TObject);
var
n1,n2,n,k,i,j,m: integer;
s: string;
begin

{
 Adv[1].n:=1;  Adv[1].s:='x';  Adv[1].nd:=1;
 Adv[2].n:=2;  Adv[2].s:='y';  Adv[2].nd:=0;
 Adv[3].n:=3;  Adv[3].s:='t';  Adv[3].nd:=0;
 Adv[4].n:=4;  Adv[4].s:='r';  Adv[4].nd:=0;
}

InitDF;
if CB_DFvars.Checked then
begin
   Adv[1].s:='z1';
   Adv[2].s:='z2';
   Adv[3].s:='z3';
end;


for i := 0 to 5 do
begin
 n1:=random(4)+1;
 n2:=random(4)+1;
 n:=Adv[n1].n; s:=Adv[n1].s;
 Adv[n1].n:=Adv[n2].n;  Adv[n1].s:=Adv[n2].s;
 Adv[n2].n:=n;  Adv[n2].s:=s;
end;

s:='';
for i := 1 to 4 do
begin
 s:=s+'d'+Adv[i].s+', ';
end;

Delete(s,Length(s)-1,2);
L_DO.Caption:=s;
end;



procedure TForm1.B_RefreshClick(Sender: TObject);
var
ic: integer;
begin

xd:=2.123;
yd:=5.456;
td:=-3.789;

xe:=2.123;
ye:=5.456;
te:=-3.789;

z1d.re:=2.123;     z1d.im:=-1.456;
z2d.re:=5.456;     z2d.im:=2.789;
z3d.re:=-3.789;    z3d.im:=-3.123;

z1e.re:=2.123;     z1e.im:=-1.456;
z2e.re:=5.456;     z2e.im:=2.789;
z3e.re:=-3.789;    z3e.im:=-3.123;

CxVarAnyRE_E[z1re]:=z1e.re;   CxVarAnyIM_E[z1im]:=z1e.im;
CxVarAnyRE_E[z2re]:=z2e.re;   CxVarAnyIM_E[z2im]:=z2e.im;
CxVarAnyRE_E[z3re]:=z3e.re;   CxVarAnyIM_E[z3im]:=z3e.im;

CxVarAnyRE_D[z1re]:=z1d.re;   CxVarAnyIM_D[z1im]:=z1d.im;
CxVarAnyRE_D[z2re]:=z2d.re;   CxVarAnyIM_D[z2im]:=z2d.im;
CxVarAnyRE_D[z3re]:=z3d.re;   CxVarAnyIM_D[z3im]:=z3d.im;


n:=1;
k:=2;
j:=5;
m:=-3;
l:=4;

//arg. with reload operations (z1,z2,z3,i: complex extended; x,y,t: extended):
z1.re:=z1e.re; z1.im:=z1e.im;
z2.re:=z2e.re; z2.im:=z2e.im;
z3.re:=z3e.re; z3.im:=z3e.im;
i.re:=0; i.im:=1;
i0.re:=0; i0.im:=0;
x:=xe; y:=ye; t:=te;




A:=2.54321;
B:=-3.98765;
C:=4.12345;
D:=-5.6789;
E:=-3.25;




Ae:=2.54321;
Be:=-3.98765;
Ce:=4.12345;
De:=-5.67893;
Ee:=-3.25715;
Fe:=7.35791;
Ge:=11.97531;



Acx.re:=Ae; Acx.im:=Ce;
Bcx.re:=Be; Bcx.im:=Ae;
Ccx.re:=Ce; Ccx.im:=Be;
Dcx.re:=De; Dcx.im:=Ce-Ae;
Ecx.re:=Ee; Ecx.im:=Be-De;
Fcx.re:=Fe; Fcx.im:=Ge-Fe;
Gcx.re:=Ge; Gcx.Im:=Ae-Ge;


CreateAndFillInternalArray(G_LenV,True);
{
AD[0]:=3.5; AD[1]:=-1.4;  AD[2]:=7.6;

for ic := 0 to 99 do
begin
  vd[ic]:=ic+1;
  ve[ic]:=ic+5;
  vs[ic]:=ic+3;


  vd[ic]:=power(-1,ic+1)*vd[ic]*0.5;
  ve[ic]:=power(-1,ic+5)*ve[ic]*0.5;
  vs[ic]:=power(-1,ic+3)*vs[ic]*0.5;
  vi[ic]:=Trunc(ve[ic]);

  vu1[ic]:=vd[ic];
  vu2[ic]:=ve[ic];
end;
 }

Ez1x.Text:= FloatToStr(z1.re,G_FMT);
Ez2x.Text:= FloatToStr(z2.re,G_FMT);
Ez3x.Text:= FloatToStr(z3.re,G_FMT);


Ez1y.Text:= FloatToStr(z1.im,G_FMT);
Ez2y.Text:= FloatToStr(z2.im,G_FMT);
Ez3y.Text:= FloatToStr(z3.im,G_FMT);


Ex.Text:= FloatToStr(xe,G_FMT);
Ey.Text:= FloatToStr(ye,G_FMT);
Et.Text:= FloatToStr(te,G_FMT);


Eare.Text:= FloatToStr(Ae,G_FMT);
Ebre.Text:= FloatToStr(Be,G_FMT);
Ecre.Text:= FloatToStr(Ce,G_FMT);


Eaim.Text:= FloatToStr(Acx.im,G_FMT);
Ebim.Text:= FloatToStr(Bcx.im,G_FMT);
Ecim.Text:= FloatToStr(Ccx.im,G_FMT);



En.Text:= IntToStr(n);
Ek.Text:= IntToStr(k);
Ej.Text:= IntToStr(j);


Ea0.Text:= FloatToStr(AD[0],G_FMT);
Ea1.Text:= FloatToStr(AD[1],G_FMT);
Ea2.Text:= FloatToStr(AD[2],G_FMT);



end;



procedure TForm1.InitIntegral;
begin
 P_Integral:=20;
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
end;

end.
