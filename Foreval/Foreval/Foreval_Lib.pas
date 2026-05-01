unit Foreval_Lib;
{******************************************************************************}
{                                                                              }
{                                 ver 9.1.1.395A                               }
{----------------------------------------------------------------------------- }
{                Foreval_Lib -  конструктор интерфейса Foreval.dll:            }
{      преобразование многострочного выражения в одну строку,                  }
{      разбор комманд: for, while, fordown, goto, ...                          }
{      компиляция функций fl_PreCompiled,                                      }
{                                     ...                                      }
{                                                                              }
{               Компилировать  начиная с  DELPHI 2009   или FPC                }
{                                                                              }
{------------------------------------------------------------------------------}
{              Foreval_Lib -  constructor of  interface of Foreval.dll         }
{                    converting a multiline expression to one string,          }
{                    parser of comand: for, while,  fordown, goto,...          }
{                    compile of functions fl_PreCompiled,                      }
{                                     ...                                      }
{                     Compiled since  Delphi 2009 or FPC                       }
{------------------------------------------------------------------------------}
{                  SOREL   (C)CopyRight 2000+. Russia, S.-Petersburg.          }
{******************************************************************************}

//Note:
{
rus:

  При  прямом подключении к программе (без "dll") или компиляции пакета  убрать ключ "USEDLL".
  При компиляции  "Foreval.dll" установить !!!

  Использовать   32-разрядный компилятор.
}

{
eng:

  At direct connection to the program (without "dll") or compilation to package: to disable  key "USEDLL".
  At compilation  "Foreval.dll" to set key !!!

  Use  32 bit compiler.
}


{$DEFINE USEDLL}   // <- To set key USEDLL, at compile in "Foreval.dll". Remove, at  direct connection to the program


// {$RangeChecks On}
// {$OverFlowChecks On}
 //{$ZEROBASEDSTRINGS Off}

{$R-}
{$Q-}

{$IFDEF FPC}
   {$MODE DELPHI}
   {$ASMMODE INTEL}
{$ENDIF}


{$IFNDEF USEDLL}
   {$DEFINE STRINGINT}
{$ENDIF}


{.$DEFINE LOGIC_OPERATORS_INLINE}    //some faster, but not safe-thread {.393A}

{
                                        !!!!!!!!!!!  WARNING  to Pascal compiler  !!!!!!!!!!!!!!!!!!!!!!!!

                   Type TComplexE must be place exactly 32 bytes in memory!! By 16 bytes for each field.
                   Type TArrayE = array of extended;  must  allocate exactly 10 bytes (no more!) for each cell.
                   In cell of array of any types on address: @array[0]-4 (bytes) must store length of array.
                   Violation of these rules will cause an error!

}

interface

uses
Foreval_Main, Foreval_Definitions, Foreval_Command, Foreval_DiffNumeric, SysUtils, StrUtils;
// ,VCL.Dialogs{, Math}{, dialogs,windows};   //DEBUG







const _VMAJOR: integer   = 9;
const _VMINOR: integer   = 1;
const _VREALISE: integer = 1;
const _VBUILD: integer   = 395;
//const _COMPILED_BY: integer =  12;   //on default in Delphi 2009

{$IFDEF FPC}
   {$MACRO ON}
      const FPC_COMPILED_BY:integer = FPC_FULLVERSION;

{$ELSE}

    const DELPHI_COMPILED_BY:extended  = CompilerVersion;
    //  const   _COMPILED_BY: integer = 12;     //on default in Delphi 2009

{$ENDIF}

const _S_ABOUT: String = 'Foreval - compiler of string mathematical expressions with real&complex numbers in "run-time" mode. (x86-32 CPU/FPU command set).  v.9.1.1.395.  Last compilations: xx.03.2026. SoReL  2000+ CopyRight .Russia, S.-Petersburg';
const _S_AUTHOR: String = 'SOREL. CopyRight(C) 2000+. Russia, S.-Petersburg';
const _S_COMMENT: String = 'with FastMM4 v. 4.991 - only for delphi';


const
fl_DISABLE              = 0;
fl_ENABLE               = 1;
fl_REAL                 = 2;  //result type
fl_COMPLEX              = 3;  //result type
fl_REAL_DOUBLE          = 4;  //var type
fl_REAL_EXTENDED        = 5;  //var type
fl_REAL_INTEGER         = 6;  //var type
fl_COMPLEX_DOUBLE       = 7;  //var type
fl_COMPLEX_EXTENDED     = 8;  //var type
fl_ARRAY_REAL_DOUBLE    = 9;  //var type
fl_ARRAY_REAL_EXTENDED  = 10; //var type
fl_DIFFER_DOUBLE        = 11; //var type
fl_DIFFER_EXTENDED      = 12; //var type
fl_VARS_VALUES          = 13; //call func      //fl_VARS_VALUES
fl_VARS_ADDRS           = 14; //call func      //fl_VARS_ADDRS
fl_VARS_LIST_ADDR_EAX   = 15; //call func      //fl_VARS_LIST_ADDR_EAX
fl_VARS_LIST_ADDR_ESP   = 16; //call func      //fl_VARS_LIST_ADDR_ESP
fl_CDECL                = 17; //call type
fl_STDCALL              = 18; //call type
fl_PASCAL               = 19; //call type
fl_DOUBLE               = 20; //stack type
fl_EXTENDED             = 21; //stack type
fl_SHOW_EXCEPTION       = 22;
fl_OPTIMIZATION         = 23;
fl_STACK_TYPE           = 24;
fl_STACK_DEEP           = 25;
fl_RESULT_LEAD_TO_TYPE  = 26; //fl_CALC_TYPE
fl_RESULT_TYPE          = 27;
fl_DIFFER               = 28;
fl_INFINITE             = 29;
fl_FREE                 = 30;
fl_CLEAR                = 31;
fl_VAR_LIST             = 32;
fl_CMPL_FUNC_LIST       = 33;
fl_STRING               = 32;
fl_STRING_UTF16         = 32;
fl_PCHAR                = 33;
fl_ANSISTRING           = 34;
fl_STRING_INTERNAL      = 35;
fl_UNKNOWN              = 36;
fl_STRING_TYPE          = 37;
fl_SYNTAX_EXTENSION     = 38;
fl_PRESENT_COMPLEX_NUMBER = 39;
fl_YES                  = 60;
fl_NO                   = 61;
fl_PRECOMPILED          = 62;
fl_COMPILE_STACK_DEEP   = 63;
fl_COMPILE_OVFL         = 64;
fl_DINAMIC_LOAD_NUM     = 65;
fl_PANSICHAR            = 66;
fl_PESENT_VAR           = 67;
fl_NONE                 = 68;  //result type
fl_WIDESTRING           = 69;
fl_ARRAY_LENGTH         = 70;
fl_VERSION                         = 71;
fl_MAJOR                           = 72;
fl_MINOR                           = 73;
fl_RELEASE                         = 74;
fl_ABOUT                           = 75;
fl_BUILD                           = 76;
fl_AUTHOR                          = 77;
fl_EXTENDED_COMMAND                = 78;
fl_STRING_UTF8                     = 79;
fl_ERROR_CODE                      = 80;
fl_ARRAY_REAL_INTEGER              = 81;
fl_SAVE                            = 82;
fl_RESTORE                         = 83;
fl_COMPILED_BY                     = 84;
fl_ENABLE_FUNCTION                 = 85;   {.191}
fl_DISABLE_FUNCTION                = 86;   {.191}
fl_REPLACE_FUNCTIONS               = 87;   {.193}
fl_REPLACE_FUNCTIONS_NUM           = 88;    {.193}
fl_REPLACE_DIV                     = 89;  {.193}
fl_REPLACE_MUL                     = 90;   {.193}
fl_REPLACE_ADDSUB                  = 91;   {.193}
fl_REPLACE_OPERATIONS              = 92;    {.193}
fl_REPLACE_OPERATIONS_NUM          = 93;    {.193}
fl_REPLACE_MULTI_EXPR              = 94;    {.193}
fl_USE_VIRTUAL_ALLOC               = 95;   //only for exe code
fl_LENGTH_CODE                     = 96;   {.193}
fl_SAVE_EAX                        = 97;   {.193}
fl_SAVE_EBX                        = 98;   {.193}
fl_SAVE_ECX                        = 99;   {.193}
fl_SAVE_EDX                        = 100;  {.193}
fl_SAVE_ESP                        = 101;   {.193}
fl_SAVE_EBP                        = 102;  {.193}
fl_SAVE_ESI                        = 103;  {.193}
fl_SAVE_EDI                        = 104;  {.193}
fl_ACCURATE_SPEC_FUNC              = 105;
fl_DINAMIC_LOAD                    = 106;
fl_CHECK_INCORRECT_SPACE           = 107; {.195}
fl_SET_POWER_SYMBOL                = 108; {.195}
fl_REPLACE_AT_IF                   = 109; {.197}
fl_LOAD_STACK_AFTER_CALC           = 110;  {.197}
fl_ADDRESS_OBJECT                  = 111;  {.197}
fl_FPU_CW                          = 112; {.203}
fl_FPU_CW_DEFAULT                  = 113; {.203} { = $1372 }
fl_FAST_DIV                        = 114; {.205}
fl_COMMENT                         = 115; {.213}
fl_ENABLE_REPLACE_FUNCTION         = 116; {.215}
fl_DISABLE_REPLACE_FUNCTION        = 117; {.215}
fl_ENABLE_CALC_CONST               = 118; {.215}
fl_DISABLE_CALC_CONST              = 119; {.215}
fl_REPLACE_COMPOSITE_FUNCTIONS                 = 120; {.217}
fl_REPLACE_COMPOSITE_FUNCTIONS_COMPLEX         = 121; {.217}
fl_REPLACE_COMPOSITE_FUNCTIONS_REAL            = 122; {.217}
fl_DISABLE_REPLACE_FUNCTION_COMPLEX            = 123; {.217}
fl_DISABLE_REPLACE_FUNCTION_REAL               = 124; {.217}
fl_ENABLE_REPLACE_FUNCTION_COMPLEX             = 125; {.217}
fl_ENABLE_REPLACE_FUNCTION_REAL                = 126; {.217}
fl_OPTIMIZATION_MUL_DIV                        = 127; {.217A}
fl_OPTIMIZATION_A1                             = 128;
fl_OPTIMIZATION_A2                             = 129;
fl_CALC_CONST_EXPRESSION                       = 130;
fl_LEAD_TO_LOWER_CASE                          = 131; {.221}
fl_SKIPPED_IF                                  = 132;  {.221}
fl_CALC_CONST_EXPR_IN_MULTI_EXPR               = 133;   {.221}
fl_PRECISION                                   = 134;
fl_MASK_FPU_EXCEPTION                          = 135;  {.229}
fl_CLEAR_FPU_EXCEPTION                         = 136;  {.229}
fl_IS_FPU_EXCEPTION                            = 137;  {.229}
fl_FREE_CODE_AT_REPLACE                        = 138; {.229}
fl_ADDRESS_EXCEPTION_FLAG                      = 139; {.231}
fl_EXCHANGE_BRANCH_NUM                         = 140; {.300}
fl_DINAMIC_LOAD_STACK_DEEP                     = 141;
fl_EXCHANGE_BRANCH_STACK_DEEP                  = 142;
fl_EXCHANGE_BRANCH                             = 143;
fl_ANY                                         = -1;
fl_NOT_FOUND                                   = -1;
fl_AUTO                                        = 144;
fl_DELETE                                      = 145;
fl_CALC_CONST_FUNC                             = 146;
fl_CALC_CONST_ARG                              = 147;
fl_NEW                                         = 148;
fl_ReWRITE                                     = 149;
fl_INTEGER_OPTIMIZATION                        = 150;
fl_CALC_CONST_EXT_FUNC                         = 151;
fl_PARAM_LIST                                  = 152;
fl_CALC_CONST_MUL_DIV                          = 153;
fl_INTEGER_OPTIMIZATION_EXT_FUNC               = 154;
fl_DIFF_NUMERIC_PRECISION                      = 155;
fl_STAY_AS_IS                                  = 156;
fl_DATA_IN_ARRAY                               = 157; {.332}
fl_INTERNAL_ERROR_CODE                         = 158;  {.333}
fl_SPEC_FUNC                                   = 159;  {.334}
fl_FAST                                        = 160;
fl_ACCURATE                                    = 161;
fl_STD_FUNC_REAL                               = 162;  {.335}
fl_STD_FUNC_COMPLEX                            = 163;  {.335}
fl_COMPLEX_DIV                                 = 164;  {.335}
fl_STD_FUNC                                    = 165;  {.335}
fl_DISABLE_OPERATION                           = 166;  {.339}
fl_ENABLE_OPERATION                            = 167;  {.339}
fl_BETWEEN                                     = 168;  {.340}
fl_BEFORE                                      = 169;  {.340}
fl_AFTER                                       = 170;  {.340}
fl_PIPE_BRACKET_TO_ABS                         = 171;
fl_SQUARE_BRACKET_TO_TRUNC                     = 172;
fl_CURLY_BRACKET_TO_FRAC                       = 173;
fl_REPLACE_FUNC_IN_PART                        = 174;
fl_EXT_NAME_FUNC                               = 175;
fl_SUBST_NUMCX                                 = 176;
fl_PRELIM_SYNT_ERROR                           = 177;
fl_SYNTAX_OPERATORS                            = 178;
fl_OPERATOR                                    = 179;
fl_STANDARD                                    = 180;  {.345}
fl_EXTRA                                       = 181;   {.345}
fl_PACKAGE_EXPRESSIONS                         = 182; {.347}
fl_USE_POINTER                                 = 183; {.353}
fl_USE_INTEGER_POINTER                         = 184; {.353}
fl_POINTER                                     = 185;  //var type
fl_ARRAY_POINTER                               = 186;
fl_REAL_SINGLE                                 = 187;
fl_ARRAY_REAL_SINGLE                           = 188;
fl_INTEGER                                     = 189;
fl_SINGLE                                      = 190;
fl_ALL_REPLACE                                 = 191; {.357}
fl_COMPILE                                     = 192;
fl_PACKAGE_COMPILE_ADDR                        = 193;
fl_CHECK_SYNTAX                                = 194;
fl_DIFF_EXPRESSION                             = 195;
fl_COMPILER_TYPE_EXE                           = 196;
fl_DELPHI                                      = 197;
fl_FREE_PASCAL                                 = 198;
fl_REPLACE_ARRAYS                              = 199;
fl_CHECK_ARRAY_TYPE_CONNECT                    = 200;
fl_COMPLEX_SINGLE                              = 201;
fl_REDUCE_CONST_ARG                            = 202;
fl_DELETE_ZERO_BRANCH                          = 203;
fl_INSERT_INLINE                               = 204;
fl_ENABLE_POINTER_MATH                         = 205;
fl_MULTI_EXPR                                  = 206;
fl_INIT_FPU                                    = 207;
fl_ARCCOTAN_TYPE                               = 208;   {.375C}
fl_ARCCOTAN_STD                                = 209;
fl_ARCCOTAN_1DIV_ARG                           = 210;
fl_DELETE_EXTENDED_NAMES_FUNCTION              = 211; {.377C}
fl_CHECK_USED_NAME                             = 212; {.378}
fl_TYPE_OF_DIFFERENTIATION                     = 213; {.379}
fl_SYMBOLIC                                    = 214;
fl_NUMERIC                                     = 215;
fl_FREE_MAIN_DIFF_EXPR                         = 216;
fl_INTERNAL                                    = 217;
fl_EXTERNAL                                    = 218;
fl_CONNECT                                     = 219;
fl_LOGIC_OPERATIONS_BY_NAMES                   = 220;
fl_LOGIC_OPERATIONS_BY_SYMBOLS                 = 221;
fl_RESTORE_AND_CLEAR_TMP_VARS                  = 222;
fl_RETURN_VAL_ON_ZERO_LENGTH                   = 223;  {.389}
fl_ZERO                                        = 224;
fl_NAN                                         = 225;
fl_CREATE                                      = 226;  {.395}
fl_DESTROY                                     = 227;
fl_REDUCE_CONST_ARG_F                          = 228;
fl_NUMBER_REDUCTIONS                           = 229;










fl_UNKNOWN_SYMBOL                 = 40;
fl_MISSING_ROUND_BRACKET          = 41;
fl_MISSING_OPERATION              = 43;
fl_WRONG_NUMBER_ARGUMENTS         = 44;
fl_MISSING_EXPRESSION             = 45;
fl_UNKNOWN_FUNCTION               = 46;
fl_ERROR_AT_ADDITION_FUNCTION     = 47;
fl_NOT_DEFINED_OPERATOR           = 48;
fl_NOT_DEFINED_FUNCTION           = 49;
fl_INCORRECT_ARGUMENT             = 50;
fl_MISSING_ARGUMENT               = 51;
fl_INTERNAL_ERROR                 = 52;
fl_INCORRECT_TYPE                 = 53;
fl_MISSING_SEPARATOR              = 54;
fl_WRONG_NAME                     = 55;
fl_CALCULATION_ERROR              = 56;
fl_ABSENT_LOAD_FUNCTION_FOR_TYPE  = 57;
fl_MISSING_SQUARE_BRACKET         = 58;
fl_MISSING_CURLY_BRACKET          = 59;
fl_MISSING_ABS_BRACKET            = 60;
fl_WRONG_EXPRESSION               = 61;
fl_INCORRECT_SPACE                = 62;  {.195}
fl_VARIABLE_REDECLARED            = 63;  {.221}
fl_NO_DIFF_SYMBOLIC               = 64;
fl_WRONG_PASSED_DATA              = 65;
fl_UNKNOWN_ARRAY                  = 66;
fl_INTERNAL_ERROR_AT_DIFF         = 67;
fl_VOID_EXPRESSION                = 68; {.333}
fl_WRONG_SYMBOL                   = 69; {.333}
fl_NO_RETURN_NUMBER               = 70; {.347}
fl_PROHIBITED_SYMBOL              = 71; {.347}
fl_NO_FUNCTION_ARGUMENT           = 72;
fl_NO_APPLICABLE_TO_EXTERNAL_ARRAY = 73;
fl_MULTI_EXPR_DISABLE             = 74;
fl_LABEL_IN_GOTO_NOT_SET          = 75;
fl_NO_APPLICABLE_TO_PASSED_ARRAY  = 76;
fl_NAME_ALREADY_USED              = 77; {.377D}
fl_WRONG_PLACEMENT_OPERATOR       = 78;
fl_ERROR_AT_ADDITION_OF_OPERATOR  = 79;
fl_UNKNOWN_VARIABLE               = 80;
fl_INVALID_FPU_LOADING            = 81;
//fl_ABSENT_OR_WRONG_SEMICOLON      = 81;


fl_ACCESS_VIOLATION           = 200;
fl_ZERO_DIVIDE                = 201;
fl_INVALID_OPERATION          = 202;
fl_OVERFLOW                   = 203;
fl_OUT_OF_MEMORY              = 204;
fl_STACK_OVERFLOW             = 205;
fl_UNDERFLOW                  = 206;
fl_INT_OVERFLOW               = 207;
fl_COMMON_CALCULATON_ERROR    = 210;





 {
fl_Power=4;
fl_Log=5;
fl_Abs=7;
fl_Arg=10;
fl_Sin=11;
fl_Cos=12;
fl_Tan=13;
fl_Cotan=14;
fl_ArcCos=15;
fl_ArcSin=16;
fl_ArcTan=17;
fl_ArcCotan=18;
fl_Sinh=19;
fl_Cosh=20;
fl_Tanh=21;
fl_Cotanh=22;
fl_ArcCosh=23;
fl_ArcSinh=24;
fl_ArcTanh=25;
fl_ArcCotanh=26;
fl_Ln=27;
fl_Exp=28;
fl_Sqr=29;
fl_Sqrt=30;
fl_Fact=31;
fl_Log10=32;
fl_Log2=33;
fl_Root=34;
fl_ArcTan2=70;
 }




  const _Pascal = 1;
  const _StdCall = 2;
  const _Cdecl = 3;

  {***
  const _STACK_ADDR = 1;
  const _STACK_VAL = 2;
  const _MEMORY_ESP = 4;
  const _MEMORY_EAX = 5;
  const _Compiled = 9;
  ***}

  {***
  const R_EAX = 1;
  const R_EBX = 2;
  const R_ECX = 3;
  const R_EDX = 4;
  const R_ESP = 5;
  const R_EBP = 6;
  const R_ESI = 7;
  const R_EDI = 8;
  ***}

  const _CLEAR = 1;
  const _SAVE = 2;

{
const S_c1: single = 1;
const S_c2: single = 2;
const S_c05: single = 0.5;
const S_c025: single = 0.25;
const S_cs2: Single = -2;

const NumberFact = 1754;
 }

const E_CPId2: extended = 1.57079632679489662;{Pi/2;}
{const
 D_Real =         11;
 E_Real =         12;
 D_Complex =      13;
 E_Complex =      14;
 D_Any  =         15;
 E_Any =          16;
 D_Array_Real =   17;
 E_Array_Real  =  18;}

  {
  const _Single = 1;
  const _Double = 2;
  const _Extended = 3;
  const _Integer = 4;
  const _Pointer = 5;
  const _Array = 6;

  }
  {
  const _Real     = 1;    //=T_Real     !!!
  const _Complex  = 2; //=T_Complex  !!!
  }
  //const _Array    = 3;  //=T_Array   !!!
  //const _Integer  = 4; //=T_Integer


  {
  const  T_Real     = 1;
  const  T_Complex  = 2;
  const  T_Array    = 3;
  const  T_Integer  = 4;
  const  T_None     = 5;
  const  T_Void     = 6;  //как T_None, только для внутренних ф-ий
  const  T_Any      = -1;
  const  T_Pointer  = 7;
  }

  {.345}
  {***
  // fl_COMPLEX_DIV
  const _fast      = 1;
  const _standard  = 2;
  const _accurate  = 3;
  const _extra     = 4;
  ***}

  const _proc = 10;
  const _func = 20;


  const  CM_WholeExpr = 100;
  const  CM_DiffExpr = 101;
  const  CM_Name = 102;
  const  CM_OnlySpace = 103;
  const  CM_DiffTemplate = 104;


  {***
   //source of definition of variables
  const
       ds_ExternalAddr          = 1;
       ds_InternalAddr          = 2;
       ds_ProgrammBody          = 3;
       ds_FunctionHeader        = 4;
       ds_FunctionBody          = 5;
 ***}

  const
       cm_ProgrammBody = 3;
       cm_FunctionBody = 5;

  {.383}
  const S_LABEL    = '>>';
  const S_NameLab  = 'lab#';
  const S_PackageVarName   = 'pv#';
  const S_CaseIntVarName   = 'iv#';
  const S_CaseFloatVarName = 'fv#';



{***
type
TComplexD =  record
               re: double;
               im: double;
              end;

type
TComplexE = record               //WARNING!!! SizeOf(TComplexE) = 32b! Size of each field (re,im) = 16 b (instead 10b)!!!
            re: extended;        //Be shure, that your compiler do correctly set size of TComplexE, otherwise to be error!
            im: extended;
           end;

type
TComplexS =  record
               re: single;
               im: single;
              end;



type
TByte32 = record                   // TComplexE -> TByte32 in dynamic arrays.
            re:  double;
            re2: double;
            im:  double;
            im2: double;
           end;

type
PComplexE = ^TComplexE;

type
PComplexD = ^TComplexD;


type
PComplexS = ^TComplexS;


type TArrayC = array of Cardinal;
//type TArrayI = array of Integer;
//type PArrayI = ^TArrayI;
type TArrayI = Foreval_Main.TArrayI;
type PArrayI = Foreval_Main.PArrayI;

type TArrayD = array of Double;
type TArrayE = array of Extended;
type TArrayS = array of Single;
type TArrayP = array of Pointer;
type PArrayD = ^TArrayD;
type PArrayE = ^TArrayE;
type PArrayS = ^TArrayS;
type TArrayB = array of byte;
type PArrayB = ^TArrayB;
type PArrayP = ^TArrayP;

***}


{.324}
{***
type
TAttribInt = Foreval_Definitions.TAttrib;
***}


{.324}
{***
type
TAttrib    = record
               MType:    Integer; //тип сохраняемого результата
                            //MType = _Double,_Integer,_Extended,_Pointer,_Single
               AddrRE:   Pointer; //адрес сохраняемого результата (непосредственный - Address)
               AddrIM:   Pointer; //адрес сохраняемого результата (непосредственный - Address)
             end;
***}




type TFuncS = record
                SV: String;
                SF: String;
              end;

type TidFunc = record       //IDFP = ^TidFunc        {.300}
                  idName: Integer;    //IDFN    идентефикатор имени
                  idArg:  Integer;    //IDFA    идентефикатор аргументов
               end;

type  PidFunc =   ^TidFunc;



type TOperData = record
                    IdOp:      Integer;
                    idFunc:    Integer;   // = TidFunc.idName
                    OpPrior:   Integer;
                    NArg:      Integer;
                    Placement: Integer;
                    ExeType:   Integer;
                 end;

type  POperData =   ^TOperData;


type
   PInt64        = ^Int64;

type
  TVarTypeList = record
                    TypeName: String;
                    GVarType: Integer;
                    VarType:  Integer;
                    MathType: Integer;
                 end;

type
TFunctionZ = record
              Func: TFunction;
              R_Type: Integer;
              CmplOverFlow: Integer;
              CmplSDeep: Integer;
              DinLoadSDeep: Integer;
              DinLoadNMem: Integer;
              XchBrSDeep: Integer;
              ReplFuncNum:  Integer;
              ReplOpNum: Integer;
              LoadStackAfterCalc: Integer;
              XchBrNXch: Integer;
              CalcConstFunc:  Integer;
              CalcConstArg:  Integer;
              CalcConstMulDiv:  Integer;
              CodeSize: Integer;
              AddrMainDiffExpr:   Pointer;  {.379}
              DiffNumericExpr:    Integer;  {.379}    //fl_Yes fl_No
              NumberReductions: Integer; {.395}
             end;


type
TAddFuncStruct = record
                    addr:  Pointer;
                CallType:  Cardinal;  //stdcall, cdecl, pascal
                     Arg:  Cardinal;
                 ArgType:  Cardinal;  //
             ArgTypeList:  Pointer;   //
                CallFunc:  Cardinal;
              ResultType:  Cardinal;
                 DeepFPU:  Cardinal;
               CalcConst:  Cardinal;
                 SaveReg:  Cardinal;
                ReplFunc:  Cardinal;   {.193}
                  Set_ID:  Cardinal;
                 Id_Func:  Cardinal;
                AdrDeriv:  Pointer;
                  NDeriv:  Cardinal;
                   Place:  Cardinal; {.308}
          ResultTypeMath:  Cardinal; {.353}
                IsInline:  Cardinal; {.365}
                   Rsrv1:  Cardinal;
                   Rsrv2:  Cardinal;
                   Rsrv3:  Cardinal;
                 end;

type
TArraySt = array of String;

type
   PInternalVar = ^TInternalVar;
   TInternalVar = record
                {замена TComplexE на TByte32: из-за ошибки компилятора Delphi: в данном случае ( как переменная в списке)
                  почему-то TComplexE  имеет размерность полей 10+10;
                  при объявлении переменных z: TComplexE; - имеет размерность полей 16+16 }
                Variable: TByte32; {.203} {internal complex extended use 16+16 instead 10+10:TComplexE}//TComplexE;  {.203}
                VecE: TArrayD;
                VecD: TArrayE;
                VecI: TArrayI;
                VecS: TArrayS;
                Name:  String;
                Next:  PInternalVar;
               end;



type  TForevalDll = class(TForevalH) end;


        procedure flCompile(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PAttr: Pointer; var Func: Pointer);     stdcall;
        procedure flCompileATE(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PAttr: Pointer; var Func: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal); stdcall;
        procedure flSetExpression(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PAttr: Pointer; action: Integer; var Func: Pointer; var CError: Cardinal); stdcall;
        procedure flSetVar(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Addr: Pointer; TV: Cardinal);    stdcall;
        procedure flSetVarCx(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; AddrRE,AddrIM: Pointer; TV: Cardinal);  stdcall;
        procedure flSetParamD(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Re,Im: Double;  TV: Cardinal);    stdcall;
        procedure flSetParamE(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Re,Im: Extended;  TV: Cardinal);    stdcall;
        procedure flSetParamI(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Iparam: Integer);    stdcall;
        procedure flSetParamP(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PReal: Pointer; TV: Cardinal);    stdcall;
        procedure flSetParamCxP(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PReal,PImage: Pointer; TV: Cardinal);    stdcall;
        procedure flSetFunction(NameF: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; FAdr: Pointer;  {.328} {var} idfP: Pointer); stdcall;
        procedure flSet(mode: Cardinal; value1,value2: Integer);                                               stdcall;
        procedure flGet(mode,subj: Cardinal; var value: Cardinal);                                             stdcall;
        procedure flGetErrorCode(var CError: Cardinal);                                                  stdcall;
        procedure flGetErrorString(var SError:{$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});              stdcall;
        procedure flPerform(act,subj: Cardinal);                                                               stdcall;
        procedure flResultCxD(Func: Pointer; var Re,Im: Double);                                                stdcall;
        procedure flResultCxE(Func: Pointer; var Re,Im: Extended);                                                stdcall;
        procedure flResultCxDP(Func: Pointer;  Res: Pointer);                                                    stdcall;
        procedure flResultCxEP(Func: Pointer;  Res: Pointer);                                                    stdcall;
        procedure flResultD(Addr: Pointer;  var Res: double);                                                  stdcall;
        procedure flResultE(Addr: Pointer;  var Res: extended);                                                stdcall;
        procedure flResult(Func: Pointer);                                                                     stdcall;

        procedure flCheckName(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};  var Answ: Integer);   stdcall;

        function flResultSafe(Addr: Pointer): HRESULT;                                                     stdcall;
        function flResultSafeD(Addr: Pointer;  var Res: double): HRESULT;                                  stdcall;
        function flResultSafeE(Addr: Pointer;  var Res: extended): HRESULT;                                stdcall;
        function flResultSafeCxD(Addr: Pointer;  var Re,Im: double): HRESULT;                              stdcall;
        function flResultSafeCxE(Addr: Pointer;  var Re,Im: extended): HRESULT;                            stdcall;
        function flResultSafeCxDP(Addr: Pointer;  Res: Pointer): HRESULT;                                  stdcall;
        function flResultSafeCxEP(Addr: Pointer;  Res: Pointer): HRESULT;                                  stdcall;



        procedure   flResultMaskedFPU(Addr: Pointer);  stdcall;
        procedure   flResultMaskedFpuE(Addr: Pointer; var Res: Extended);  stdcall;
        procedure   flResultMaskedFpuD(Addr: Pointer; var Res: Double);  stdcall;
        procedure   flResultMaskedFpuCxE(Addr: Pointer; var Re,Im: extended);  stdcall;
        procedure   flResultMaskedFpuCxD(Addr: Pointer; var Re,Im: double);  stdcall;
        procedure   flResultMaskedFpuCxEP(Addr: Pointer;  Res: Pointer);  stdcall;
        procedure   flResultMaskedFpuCxDP(Addr: Pointer;  Res: Pointer);  stdcall;





        procedure flPolarDP(pz: Pointer;   pz1: Pointer);                                                      stdcall;
        procedure flPolarEP(pz: Pointer;   pz1: Pointer);                                                      stdcall;
        procedure flDecartDP(pz: Pointer;  pz1: Pointer);                                                      stdcall;
        procedure flDecartEP(pz: Pointer;  pz1: Pointer);                                                      stdcall;
        procedure flSetVarIntrnl(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};  VType: Cardinal; var ExAddr: Pointer);   stdcall;
        procedure flSetVarValueD(Addr: Pointer;  Val: Double);       stdcall;
        procedure flSetVarValueE(Addr: Pointer;  Val: Extended);       stdcall;
        procedure flSetVarValueI(Addr: Pointer;  Val: Integer);       stdcall;
        procedure flSetVarValueS(Addr: Pointer;  Val: Single);       stdcall;
        procedure flSetVarValueCxS(Addr: Pointer;  ValRe,ValIm: Single);       stdcall;
        procedure flSetVarValueCxD(Addr: Pointer;  ValRe,ValIm: Double);       stdcall;
        procedure flSetVarValueCxE(Addr: Pointer;  ValRe,ValIm: Extended);       stdcall;
        procedure flSetLength(AdrV: Pointer; TypeV: Cardinal; Len: Cardinal);  stdcall;
        procedure flSetArrayValueI(AdrV: Pointer; indx: Cardinal; Val: integer);  stdcall;
        procedure flSetArrayValueD(AdrV: Pointer; indx: Cardinal; Val: double);  stdcall;
        procedure flSetArrayValueE(AdrV: Pointer; indx: Cardinal; Val: extended);  stdcall;
        procedure flSetArrayValueS(AdrV: Pointer; indx: Cardinal; Val: single);  stdcall;
        procedure flGetVarValueE(Addr: Pointer; var Val: Extended);       stdcall;
        procedure flGetVarValueI(Addr: Pointer; var Val: Integer);       stdcall;
        procedure flGetVarValueD(Addr: Pointer; var Val: Double);       stdcall;
        procedure flGetVarValueS(Addr: Pointer; var Val: Single);       stdcall;
        procedure flGetArrayValueI(AdrV: Pointer; indx: Cardinal; var Val: integer);  stdcall;
        procedure flGetArrayValueD(AdrV: Pointer; indx: Cardinal; var Val: double);  stdcall;
        procedure flGetArrayValueE(AdrV: Pointer; indx: Cardinal; var Val: extended);  stdcall;
        procedure flGetArrayValueS(AdrV: Pointer; indx: Cardinal; var Val: single);  stdcall;
        procedure flGetVarValueCxS(Addr: Pointer;  var ValRe,ValIm: Single);       stdcall;
        procedure flGetVarValueCxD(Addr: Pointer;  var ValRe,ValIm: Double);       stdcall;
        procedure flGetVarValueCxE(Addr: Pointer;  var ValRe,ValIm: Extended);       stdcall;

        procedure flSetNameImUnit(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});   stdcall;

        procedure flLoadFPUD(RE: Double; Im: Double);  stdcall;
        procedure flLoadFPUE(RE: Extended; Im: Extended);  stdcall;
        procedure flLoadFPUDP(Adr: Pointer);  stdcall;
        procedure flLoadFPUEP(Adr: Pointer);  stdcall;


        procedure flSetDiffVar(NName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});        stdcall;
        procedure flSetDiffExpr(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});         stdcall;
        procedure flDiffExpr(N: Cardinal);                                                      stdcall;
        procedure flGetDiffString(var S: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}); stdcall;
        procedure flCompileDiffExpr(var Addr: Pointer);    stdcall;
        procedure flCompileDeriv(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; VName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; N: Cardinal; var Addr: Pointer);  stdcall;

        procedure flCompileDiffExprATE(PAttr:   Pointer; var Addr: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal);  stdcall;
        procedure flCompileDerivATE(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; VName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; N: Cardinal;  PAttr: Pointer; var Addr: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal); stdcall;

        procedure flSetDiffTemplate(idfP: Pointer; TemplateDiff: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});     stdcall;
        procedure flSetSplainFunction(FuncName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; AdrVX,AdrVY: Pointer; ArrayType: Cardinal;  {.328} { var} idfP: Pointer);  stdcall;
        procedure flSetDiffNumCurrency(Np: Cardinal; h: double);        stdcall;

        procedure flSetExtAddrErrorFPU(ErrFpuAddr: Pointer); stdcall;
        procedure flMaskFPUException;            stdcall;
        procedure flResetMaskFPUException;       stdcall;
        function  flGetFPUException: Cardinal;   stdcall;
        function  flIsNAN(val: extended): integer; stdcall;

        procedure flRenameFunction(Name,NewName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});                 stdcall;
        procedure flAddNameFunction(IDF: Integer; AddName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});      stdcall;
        procedure flGetFunctionIDFP(FName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; FData: Pointer;  {.328} {var} idfP: Pointer);    stdcall;
        procedure flGetFuncIDN(FName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; var IDN: Integer);   stdcall;
        procedure flChangeFunctionProperty(Action: Cardinal; idfP: Pointer); stdcall;
        {.339}
        procedure flSetOperation(OpSymb: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; OperDataP: Pointer); stdcall;
        //procedure flGetOperationID(OpSymb: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};var IdOp: Integer; var NFunc: Integer;  var OpPrior: Integer; var  NArg: Integer; var Placement: Integer); stdcall;
        procedure flGetOperation(OpSymb: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; OperDataP: Pointer); stdcall;
        procedure flGetFunctionAddr(idfP: Pointer; var AddrFP: Pointer{Cardinal});    stdcall;
        {.342}
        //AUXILIARY
        procedure flCopyArrayExt(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
        procedure flCopyArrayDbl(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
        procedure flCopyArrayInt(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;
        procedure flCopyArrayExtDSC(DstAddr: Pointer; SrcAddr: Pointer; CellSizeSrc:Integer; CellSizeDst:Integer; Len: Integer);  stdcall;
        procedure flCopyMemory(DstAddr: Pointer; SrcAddr: Pointer; NBytes:Integer);  stdcall;
        procedure flCopyVarCxD(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
        procedure flCopyVarCxE(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
        procedure flCopyVarD(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
        procedure flCopyVarE(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
        procedure flCopyVarI(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;


    

procedure _CreateLib;
procedure _DestroyLib;
//procedure _SetIntVar(NS: String; TypeV,MType: Integer; var Adr: Cardinal);
procedure _SetDiffVar(NName: String);
procedure _CompileMultiExpr(Expr: String; var SExpr1: String);
function  _CheckMultiExpr(PS: PString): Boolean;
procedure _FindReIm(S: String; var S1:String; var TF: Integer);
procedure _ResultC(Func: cardinal; var Res: TComplexE);
function  _ResultR(Func: Cardinal): extended;
procedure pcSetFunc(VNS: TArraySt; S: String; var SF: String);
procedure pcFreeIntVar;
procedure pcSetIntVar(VNS: TArraySt; ATL: TArrayI);
function  pcPosN(S: String; FS: String; P: Integer): Integer;
procedure pcFindVar(S: String; NV: String; P: Integer;  var Bl: Boolean; var NNV: String);
procedure  pcGetFuncVarName(S: String; var FN: String; var VNS: TArraySt);
procedure FreeFunction(Func: Cardinal);
procedure FreeCmplFuncList;
procedure SetReg(Reg,Mode: Integer);
function  PtrToStr(P: Pointer): String;
function  StrToPtr(S: String): Pointer;
procedure DeleteSpace(S: String; var S1: String);
procedure DeleteSpaceP(PS: PString);
procedure pcFindFuncArg(SA: String; var MX: TArraySt; var VT: Integer);
function  pcGetFuncName(SF,SFM: String; MX: TArraySt): String;
procedure pcConvertFuncName(S: String;  var FN: String; var LVT: TArrayI; var VN,VT,RT: Integer);
procedure pcCompile(S: String; var FName: String; var FAdr: Pointer);
procedure InitFuncStruct(var FS: TAddFuncStruct);
procedure PushVar(S: String);
procedure PopVar;
procedure PushParam(S: String);
procedure PopParam;
procedure RestoreAndFreeData;
procedure ExchLabl(S1: String; var S2: String);
procedure _SetVar(Name: String; Addr: Pointer; TV: Cardinal; TypeCnt: Cardinal);
procedure _SetVar2(Name: String; AddrRE, AddrIM: Pointer; TV: Cardinal; SrcDef: Cardinal); {.343}
procedure _SetParam(Name: String; Re,Im: Extended; TV: Cardinal);
procedure _GetStrPCh(var P: Pointer);
procedure _SetStrPCh(P: Pointer);
procedure _Compile(Expr: String; var Func: Pointer);
procedure _CompileDiff(DiffS: String; G_AtrD: TAttribInt;  var Func: Pointer); {.377C}
procedure _SetDiffExpr(Expr: String); {.327}
procedure ResultCxD(Func: Pointer; var Res: TComplexD);
procedure ResultCxE(Func: Pointer; var Res: TComplexE);
procedure _LEN(adr: Cardinal; var len: Cardinal);
procedure _SetFunction(Name: String; FAdr: Pointer; {var} idfP: Pointer);
function  FindArray(SV,SF: String; var SV1,SF1: String): Boolean;
procedure SetNameTypes;
function _FindCmplFunc(Addr: Cardinal): Cardinal;
procedure CheckFalseBlank(S: String; var S1: String);
function IsCurrentSet(NS: String): Boolean;    {.221}
procedure WriteCurrentSet(NS: String);    {.221}
procedure _SetVarIntrnlA(NS: String; TypeV,MType: Integer;  SrcDef: Integer; var Adr: Cardinal); {.221}
procedure _SetIntVarMultiExpr(NS: String; TypeV,MType: Integer; SrcDef: integer; var Adr: Cardinal);  {.229}
procedure _SetVarIntrnlS(VName: String; VType,MType:Integer; SrcDef: integer; CheckSyntax:Boolean); {.347}
procedure ClearError; {.300}
procedure FindDiffExt(S: String;  var SC: String); {.301}   {.328}
procedure _SetSplain3F(nameF: String; VX,VY: TArrayE;{ var} idfP: Pointer);
procedure AddNewFuncD(NameF: String; FS: TIntFunc; AdrDeriv: Pointer; NDeriv: Cardinal);
procedure  _DeleteSameFunction(SN: String; FS: TIntFunc);
procedure _GetFunctionID(FSName: String; FData: Pointer; {var} idfP: Pointer);
procedure _MaskFPUException(CWAddr: PCardinal);  stdcall;  {.332}
function _IsFPUException(CWAddr: PCardinal): integer; stdcall; {.332}
procedure _InitFPU;
procedure _ResetMaskFPUException(CWAddr: PCardinal);
//function  CheckToDisCmplSymbPS(PExpr: PString): Boolean;      {.333}
procedure CheckSpace(PExpr: PString);
function  CheckSyntaxErrorPS(PExpr: PString; CheckMode: Integer): Boolean;
procedure CheckAndReplaceAbsBrPS(PExpr: PString);
procedure CheckDisableSymbPS(PExpr: PString);
function  CheckNamePS(PExpr: PString): boolean;
procedure DeleteExternalBracketPS(PS: PString);
function  FindAssign(PS1,PS1a,PS1b: PString): Boolean;
procedure _LibError;
procedure _DiffExprN(N: Cardinal);
procedure _SetVarIntrnlExtAddr(NS: String; TypeV,MType: Integer; AddrRe,AddrIm: Cardinal; CheckSyntax: Boolean);
procedure _CreatePackageExpression(S: String; G_Atr:  TAttribInt);
procedure   _CompilePackage(var CAddr: Pointer);
function _ConvertAttr: Boolean;
procedure _SetExpression(S : String;  action: Integer; var Func: Pointer);
function _GetTypeVar(TypeName: String; var GVT,VT,MT: Cardinal): Boolean;
function CheckUsedFuncNamePS(PExpr: PString; ChName: Boolean): boolean;
function CheckUsedVarName(VName: String; ChName: Boolean): boolean;
procedure ConnectLogicOps(BbyNames: Boolean);
procedure Lib_AddOperationSymbToList(OpSymb: Char; NArg: Integer; Placement: Integer);
procedure FindMissingSemiOperInMultiPS(PS: PString; _bp: Integer);
function FindControlVarPS(PSA: PString; PSF: PString; VT: Cardinal; MT: Cardinal; var vpos: Cardinal; var ReIm: Integer): Boolean;
procedure _SyntaxExtCom_FindArgArrPS(PSM: PString; SF: String; FPType: Integer; cp: integer; var NArg,lensf,pf: Integer; var ArgArr: TArrayStr);
procedure _SyntaxExtCom_FindArgPS(PSM: PString; SF: String; FPType: Integer; cp: integer; var NArg,lensf,pf: Integer; var S1,S2,S3,S4,S5: String);


//function  CheckDisableSymb(PS: PString): Boolean;



  var   AfterFirstVarEnableSymb:   set of char = ['+','-','*','/','^','!','[',';',',','.','='];

  var   BeforeLastVarEnableSymb:   set of char = ['+','-','*','/','^',';'];

  var   BeforeMiddleVarEnableSymb: set of char = ['+','-','*','/','^','<','>',';',',','=','(','[','{','|'];

  var   AfterMiddleVarEnableSymb:  set of char = ['+','-','*','/','^','!','<','>',';',',','.','=',')',']','}','|','['];

  var   ControlSpaceSymb: set of char; // = EnableNameSymb + '.'

var

 Foreval: TForevalDll;
 CompZ: array of TFunctionZ;
 _STRINGTYPE: Integer;
 VSI,ATL,CVA,pcLVT: TArrayI;
 SaveVar,SaveVarD: TAlgObject;
 SaveParam: TAlgParam;
 F_CurrentIntFunc: Cardinal; //число ф-ий типа fl_PRECOMPILED
 InternalVarList, BInternalVarList: PInternalVar;
 CmplOverFlow,CmplSDeep,DinLoadNMem,XchBrSDeep,DinLoadSDeep,ReplFuncNum,ReplOpNum,LoadStackAfterCalc,XchBrNXch: Integer;
 CalcConstFunc,CalcConstArg,CalcConstMulDiv,NumberReductions:  Integer;
 CodeSize:  Cardinal;
 Lib_ErrorCode,Lib_ErrorCodeDiff: Cardinal;           //E_Code
 VSB: TArrayB;
 Str,Str1: String;
 Lib_ErrorString,Lib_ErrorStringDiff: String;
 Sws,Sws1: WideString;
 Sans,Sans1: AnsiString;
 Su8,S1u8: UTF8STRING;
 PSu8: PUTF8STRING;
 G_FMT: TFormatSettings;
 StrE: String;
 FS:TAddFuncStruct;
 LabCount: Integer;
 IntrnlVarCount:Integer;

 _COMPILED_BY: Integer;
 F_EXTENDED_COMMAND, F_REPLACE_MULTI_EXPR,F_MULTI_EXPR: Boolean;
 F_FindWrongSpace: Boolean;
 F_LeadToLowerCase: Boolean;
 F_PACKAGE_COMPILE: Boolean;

 F_CalcConsExprInMulti: Boolean;  //разрешает компиляцию промежуточных выражений (в составном выражении) для проверки их на константу.

 S_Current_Expression,StrD: String;
 S_Package_Expression: String;
 S_SubExpr: String;
 N_Count_Package_Var: Integer;
 //S_PackageVarName: String;
 P_PackageCompileAddr: Pointer;
 F_CompileMode: Integer;    //=      cm_ProgrammBody , cm_FunctionBody
 F_FreeMainDiffExpr : Boolean; {.379}
 Len_SLABEL: Integer;


 G_FS:TAddFuncStruct;
 SNCmplx,SNInt,SNPtr,SNReal,SNArrayInt,SNArrayReal,SNSpace: array of String;

 CurrentNameSet:Array of String;
 CWMEM,FCWMEM: WORD;
 PFPUErrorAddr: Pointer;
 CalcCW: WORD;
 F_ClearCurrentNameSet: Boolean;
 F_FREE_CODE_AT_REPLACE: Boolean;
 F_CALC_EXCEPTION_IN_SAFE: Cardinal;
 GA_TmpExeptionFlag: Cardinal;
 GA_ExceptionFlagAddr: TAddress;
 S_DiffExpr: String;     //строка с продифференцированным выражением
 idFunc,idFuncF,IDtmpP:  TidFunc;
 F_DiffExtPresent: Boolean;
 F_MainDiffExpr: Boolean; {.379}
 F_ConnectLogicOps: Boolean; {.379}
 FuncFS: TAddFuncStruct;
 VarTypeList: array of TVarTypeList;
 //IDtmpP: Pointer;

 GC_PAtr: ^TAttrib; {.324}
 //G_PAtr:  TAttrib; {.324}
 G_Atr, G_Atr0:   TAttribInt; {.324}

 c_DinArrayLenCorrect: Integer; {.357}
 SwitchFPUExceptSpecFunc: Pointer;  {.375}
 _AddrMainDiffExpr: Pointer;  {.379}




implementation
var
MEM: Cardinal;


(*
NOTE:
Строковые переменные в процедурах Foreval передаются через указатели (Pointer) и могут иметь типы: String(UTF-16),  AnsiString(PAnsiChar), WideString, UTF8
Их конвертация выполняется процедурами: PtrToStr, StrToPtr.


String variables in procedures Foreval are transferred through pointers (Pointer) and can have types: String(UTF-16),  AnsiString(PAnsiChar), WideString, UTF8
Their conversion is fulfilled by procedures: PtrToStr, StrToPtr.
*)



procedure ClearError;
begin
  Foreval.SyntaxError:=0;
  Foreval.InternalError:=0;
  Foreval.SyntaxErrorString:='';
  Lib_ErrorCode:=0;
  Lib_ErrorCodeDiff:=0; {.389A}
  Lib_ErrorString:='';
end;


procedure flCompile(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PAttr: Pointer; var Func: Pointer);
var
S: String;
begin
{$IFDEF STRINGINT}
S:=Expr;
{$ELSE}
S:=PtrToStr(Expr);
{$ENDIF}



if F_LeadToLowerCase = True then S:=LowerCase(S);

GC_PAtr:=PAttr;{.324}
Func:=nil;       {.375C}


//ClearError;

if CheckSyntaxErrorPS(@S,CM_WholeExpr) = True then
begin
    F_CompileMode := cm_ProgrammBody;
    _Compile(S,Func);
end;

 RestoreAndFreeData;   {.383}
_LibError;
end;



procedure flCompileATE(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PAttr: Pointer; var Func: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal);
var
S: String;
begin
{$IFDEF STRINGINT}
S:=Expr;
{$ELSE}
S:=PtrToStr(Expr);
{$ENDIF}



if F_LeadToLowerCase = True then S:=LowerCase(S);

GC_PAtr:=PAttr;{.324}
Func:=nil;       {.375C}


//ClearError;

if CheckSyntaxErrorPS(@S,CM_WholeExpr) = True then
begin
    F_CompileMode := cm_ProgrammBody;
    _Compile(S,Func);
end;

 RestoreAndFreeData;      {.383}
_LibError;

//ErrorCode:=Lib_ErrorCode;
flGetErrorCode(ErrorCode); {.377C}
flGet(fl_RESULT_TYPE,0,ResType);

end;




 {.357}
procedure flSetExpression(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; PAttr: Pointer; action: Integer; var Func: Pointer; var CError: Cardinal);
var                          //action = fl_COMPILE, fl_PACKAGE_EXPRESSION, fl_CHECK_SYNTAX, fl_DIFF_EXPRESSION
S: String;
SntxChck: Integer;
begin
{$IFDEF STRINGINT}
S:=Expr;
{$ELSE}
S:=PtrToStr(Expr);
{$ENDIF}

if F_LeadToLowerCase = True then S:=LowerCase(S);

GC_PAtr:=PAttr;
Func:=nil;

//ClearError;

if (action = fl_COMPILE)  or (action = fl_CHECK_SYNTAX) then SntxChck:=CM_WholeExpr
else
if  action = fl_PACKAGE_EXPRESSIONS then SntxChck:=CM_DiffExpr //только односоставные функции!
else
if action = fl_DIFF_EXPRESSION   then SntxChck:=CM_DiffExpr;

if CheckSyntaxErrorPS(@S,SntxChck) = True then
begin
   _SetExpression(S,action,Func);
end
else
begin
  if  (action = fl_PACKAGE_EXPRESSIONS) and (Lib_ErrorCode = E_NO_DIFF_SYMBOLIC) then Lib_ErrorCode := E_WRONG_EXPRESSION;


end;

RestoreAndFreeData;
_LibError;
//CError:=Lib_ErrorCode;
flGetErrorCode(CError); //{.393A1}
end;





procedure flSet(mode: Cardinal; value1,value2: Integer);
begin
if mode = fl_ENABLE then
  begin
   if value1 = fl_SHOW_EXCEPTION           then  Foreval.ShowException:=True else
   if value1 = fl_OPTIMIZATION             then begin
                                                 Foreval.OperationOptimizatorA1:=True;
                                                 Foreval.OperationOptimizatorA2:=True;
                                                 Foreval.CalcConstExpr:=True;
                                                 Foreval.MulDivOptimization:=True;
                                                 Foreval.SetDivMode(_fast);
                                                 Foreval.ReplaceFuncs:=True;
                                                 Foreval.ReplaceOps:=True;
                                                 Foreval.DinamicLoad:=True;
                                                 Foreval.ReplaceFuncsCF:=True;
                                                 Foreval.TreeOptimization:=_Enable;
                                                 Foreval.EnableCalcConstFUNC:=True;
                                                 Foreval.EnableCalcConstARG:=True;
                                                 Foreval.EnableCalcConstExtFunc:=True;
                                                 Foreval.IntegerOptimizator:=True;
                                                 Foreval.IntegerOptimizatorF:=True;
                                                 Foreval.SkippedIF:=True;
                                                 Foreval.EnableReduceArgOptimizator:=True;
                                                 Foreval.EnableReduceArgOptimizatorF:=True;
                                                 Foreval.DeleteZeroBranch:=True;
                                                end  else
   if value1 = fl_SYNTAX_EXTENSION         then Foreval.SetSyntaxExtension(True) else
   if value1 = fl_EXTENDED_COMMAND         then F_EXTENDED_COMMAND:=True         else
   if value1 = fl_REPLACE_FUNCTIONS        then Foreval.ReplaceFuncs:=True else      {.193}
   if value1 = fl_REPLACE_OPERATIONS       then Foreval.ReplaceOps:=True else      {.193}
   if value1 = fl_REPLACE_DIV              then Foreval.SetF(3,CM_DIV,0) else
   if value1 = fl_REPLACE_MUL              then Foreval.SetF(3,CM_MUL,0) else
   if value1 = fl_REPLACE_ADDSUB           then
                                                 begin
                                                    Foreval.SetF(3,CM_ADD,0);
                                                    Foreval.SetF(3,CM_SUB,0);
                                                    Foreval.SetF(3,CM_NEG,0);
                                                 end
                                                 else
   if value1 = fl_REPLACE_ARRAYS           then Foreval.SetF(3,CM_LDSVX,0) else
   if value1 = fl_REPLACE_MULTI_EXPR       then F_REPLACE_MULTI_EXPR:=True else
   if value1 = fl_USE_VIRTUAL_ALLOC        then Foreval.UseVirtAlloc:=True else
   if value1 = fl_SAVE_EAX                 then SetReg(R_EAX,_SAVE)             else     {.193}
   if value1 = fl_SAVE_EBX                 then SetReg(R_EBX,_SAVE)          else
   if value1 = fl_SAVE_ECX                 then SetReg(R_ECX,_SAVE)            else
   if value1 = fl_SAVE_EDX                 then SetReg(R_EDX,_SAVE)            else
   if value1 = fl_SAVE_ESP                 then SetReg(R_ESP,_SAVE)            else
   if value1 = fl_SAVE_EBP                 then SetReg(R_EBP,_SAVE)            else
   if value1 = fl_SAVE_ESI                 then SetReg(R_ESI,_SAVE)           else
   if value1 = fl_SAVE_EDI                 then SetReg(R_EDI,_SAVE)           else
   if value1 = fl_ACCURATE_SPEC_FUNC       then Foreval.FastSpec(False)   else
   if value1 = fl_DINAMIC_LOAD             then Foreval.DinamicLoad:=True else
   if value1 = fl_CHECK_INCORRECT_SPACE    then F_FindWrongSpace:=True else      {.195}
   if value1 = fl_REPLACE_AT_IF            then Foreval.DisableReplaceIF:=False else  {.195}
   if value1 = fl_FAST_DIV                 then Foreval.SetDivMode(_fast) else//Foreval.FastDivision:=True else  {.205}
   if value1 = fl_REPLACE_COMPOSITE_FUNCTIONS        then Foreval.ReplaceFuncsCF:=True else      {.217}
   if value1 = fl_REPLACE_COMPOSITE_FUNCTIONS_COMPLEX        then Foreval.SetF(17,0,0)  else      {.217}
   if value1 = fl_REPLACE_COMPOSITE_FUNCTIONS_REAL           then Foreval.SetF(16,0,0)   else   {.217}
   if value1 = fl_OPTIMIZATION_MUL_DIV     then Foreval.MulDivOptimization:=True else {.217A}
   if value1 = fl_OPTIMIZATION_A1          then Foreval.OperationOptimizatorA1:=True else
   if value1 = fl_OPTIMIZATION_A2          then Foreval.OperationOptimizatorA2:=True else
   if value1 = fl_CALC_CONST_EXPRESSION    then Foreval.CalcConstExpr:=True else
   if value1 = fl_LEAD_TO_LOWER_CASE       then begin F_LeadToLowerCase:=True {Foreval.LeadToLowerCase:=True} end else {.221}
   if value1 = fl_SKIPPED_IF               then Foreval.SkippedIF:=True else           {.221}
   if value1 = fl_CALC_CONST_EXPR_IN_MULTI_EXPR   then F_CalcConsExprInMulti:=True else {.221}
   if value1 = fl_MASK_FPU_EXCEPTION       then Foreval.EnableMaskFpuException:=True else {.229}
   if value1 = fl_FREE_CODE_AT_REPLACE     then    F_FREE_CODE_AT_REPLACE:=True else  {.229}
   if value1 = fl_EXCHANGE_BRANCH          then Foreval.TreeOptimization:=_Enable else
   if value1 = fl_CALC_CONST_FUNC          then Foreval.EnableCalcConstFUNC:=True else
   if value1 = fl_CALC_CONST_ARG           then Foreval.EnableCalcConstARG:=True  else
   if value1 = fl_CALC_CONST_EXT_FUNC      then Foreval.EnableCalcConstExtFunc:=True else
   if value1 = fl_CALC_CONST_MUL_DIV       then Foreval.EnableCalcConstMulDiv:=True else
   if value1 = fl_INTEGER_OPTIMIZATION     then Foreval.IntegerOptimizator:=True else
   if value1 = fl_INTEGER_OPTIMIZATION_EXT_FUNC     then Foreval.IntegerOptimizatorF:=True  else
   if value1 = fl_DATA_IN_ARRAY            then Foreval.DataInArray:=True else
   if value1 = fl_PIPE_BRACKET_TO_ABS      then Foreval.PipeBracketToAbs:=True else
   if value1 = fl_SQUARE_BRACKET_TO_TRUNC  then Foreval.SquareBracketToTrunc :=True else
   if value1 = fl_CURLY_BRACKET_TO_FRAC    then Foreval.CurlyBracketToFrac:=True else
   if value1 = fl_REPLACE_FUNC_IN_PART     then Foreval.ReplaceFuncInPart:=True else
   if value1 = fl_EXT_NAME_FUNC            then Foreval.ExtNameFunction:=True else
   if value1 = fl_SUBST_NUMCX              then Foreval.SubstNumCX:=True else
   if value1 = fl_PRELIM_SYNT_ERROR        then Foreval.PreliminarySyntaxError:=True else
   if value1 = fl_SYNTAX_OPERATORS         then Foreval.SetSyntaxExtensionForOperations(True) else
   if value1 = fl_OPERATOR                 then Foreval.Operation(value2,True) else
   if value1 = fl_PACKAGE_EXPRESSIONS       then
                                           begin
                                              F_PACKAGE_COMPILE:=True;
                                              S_Package_Expression:='';
                                              N_Count_Package_Var:=0;
                                              P_PackageCompileAddr:=nil;
                                           end
                                           else
   if value1 = fl_ALL_REPLACE              then Foreval.EnableAllReplace:=True else
   if value1 = fl_USE_POINTER              then Foreval.UsePointer:=True else
   if value1 = fl_USE_INTEGER_POINTER      then Foreval.UseIntegerPointer:=True else
   if value1 = fl_CHECK_ARRAY_TYPE_CONNECT then Foreval.CheckArrayTypeConnect:=True else
   if value1 = fl_REDUCE_CONST_ARG         then Foreval.EnableReduceArgOptimizator:=True else
   if value1 = fl_REDUCE_CONST_ARG_F       then Foreval.EnableReduceArgOptimizatorF:=True else
   if value1 = fl_DELETE_ZERO_BRANCH       then Foreval.DeleteZeroBranch:=True else
   if value1 = fl_INSERT_INLINE            then Foreval.EnableInline:=True else
   if value1 = fl_MULTI_EXPR               then F_MULTI_EXPR:=True        else
   if value1 = fl_CHECK_USED_NAME          then Foreval.CheckUsedName:=True else {.378}
   if value1 = fl_FREE_MAIN_DIFF_EXPR      then F_FreeMainDiffExpr := True; {.379}
   //if value1 = fl_ENABLE_POINTER_MATH      then Foreval.EnablePointerMath:=True;// else




  end
 else
if mode = fl_DISABLE then
  begin
    if value1 = fl_SHOW_EXCEPTION          then  Foreval.ShowException:=False else
    if value1 = fl_OPTIMIZATION            then begin
                                                 Foreval.OperationOptimizatorA1:=False;
                                                 Foreval.OperationOptimizatorA2:=False;
                                                 Foreval.CalcConstExpr:=False;
                                                 Foreval.MulDivOptimization:=False;
                                                 Foreval.SetDivMode(_standard);
                                                 Foreval.ReplaceFuncs:=False;
                                                 Foreval.ReplaceOps:=False;
                                                 Foreval.DinamicLoad:=False;
                                                 Foreval.ReplaceFuncsCF:=False;
                                                 Foreval.TreeOptimization:=_Disable;
                                                 Foreval.EnableCalcConstFUNC:=False;
                                                 Foreval.EnableCalcConstARG:=False;
                                                 Foreval.EnableCalcConstExtFunc:=False;
                                                 Foreval.IntegerOptimizator:=False;
                                                 Foreval.IntegerOptimizatorF:=False;
                                                 Foreval.SkippedIF:=False;
                                                 Foreval.EnableReduceArgOptimizator:=False;
                                                 Foreval.EnableReduceArgOptimizatorF:=False;
                                                 Foreval.DeleteZeroBranch:=False;
                                               end   else
    if value1 = fl_SYNTAX_EXTENSION        then Foreval.SetSyntaxExtension(False)  else
    if value1 = fl_EXTENDED_COMMAND        then F_EXTENDED_COMMAND:=False   else
    if value1 = fl_REPLACE_FUNCTIONS       then Foreval.ReplaceFuncs:=False else
    if value1 = fl_REPLACE_OPERATIONS      then Foreval.ReplaceOps:=False  else    {.193}
    if value1 = fl_REPLACE_DIV             then Foreval.SetF(4,CM_DIV,0) else
    if value1 = fl_REPLACE_MUL             then Foreval.SetF(4,CM_MUL,0) else
    if value1 = fl_REPLACE_ADDSUB          then
                                                begin
                                                    Foreval.SetF(4,CM_ADD,0);
                                                    Foreval.SetF(4,CM_SUB,0);
                                                    Foreval.SetF(4,CM_NEG,0);
                                                end
                                                else
    if value1 = fl_REPLACE_ARRAYS          then Foreval.SetF(4,CM_LDSVX,0) else
    if value1 = fl_REPLACE_MULTI_EXPR      then F_REPLACE_MULTI_EXPR:=False else
    if value1 = fl_USE_VIRTUAL_ALLOC       then Foreval.UseVirtAlloc:=False else
    if value1 = fl_SAVE_EAX                then SetReg(R_EAX,_CLEAR)             else     {.193}
    if value1 = fl_SAVE_EBX                then SetReg(R_EBX,_CLEAR)          else
    if value1 = fl_SAVE_ECX                then SetReg(R_ECX,_CLEAR)            else
    if value1 = fl_SAVE_EDX                then SetReg(R_EDX,_CLEAR)            else
    if value1 = fl_SAVE_ESP                then SetReg(R_ESP,_CLEAR)            else
    if value1 = fl_SAVE_EBP                then SetReg(R_EBP,_CLEAR)            else
    if value1 = fl_SAVE_ESI                then SetReg(R_ESI,_CLEAR)           else
    if value1 = fl_SAVE_EDI                then SetReg(R_EDI,_CLEAR)           else
    if value1 = fl_ACCURATE_SPEC_FUNC      then Foreval.FastSpec(True) else
    if value1 = fl_DINAMIC_LOAD            then Foreval.DinamicLoad:=False else
    if value1 = fl_CHECK_INCORRECT_SPACE   then F_FindWrongSpace:=False else      {.195}
    if value1 = fl_REPLACE_AT_IF           then Foreval.DisableReplaceIF:=True else  {.195}
    if value1 = fl_FAST_DIV                then Foreval.SetDivMode(_standard) else  //Foreval.FastDivision:=False else  {.205}
    if value1 = fl_REPLACE_COMPOSITE_FUNCTIONS        then Foreval.ReplaceFuncsCF:=False else      {.217}
    if value1 = fl_REPLACE_COMPOSITE_FUNCTIONS_COMPLEX        then Foreval.SetF(15,0,0)  else      {.217}
    if value1 = fl_REPLACE_COMPOSITE_FUNCTIONS_REAL           then Foreval.SetF(14,0,0) else     {.217}
    if value1 = fl_OPTIMIZATION_MUL_DIV     then Foreval.MulDivOptimization:=False else {.217A}
    if value1 = fl_OPTIMIZATION_A1          then Foreval.OperationOptimizatorA1:=False else
    if value1 = fl_OPTIMIZATION_A2          then Foreval.OperationOptimizatorA2:=False else
    if value1 = fl_CALC_CONST_EXPRESSION    then Foreval.CalcConstExpr:=False else
    if value1 = fl_LEAD_TO_LOWER_CASE       then begin F_LeadToLowerCase:=False{ Foreval.LeadToLowerCase:=False} end else {.221}
    if value1 = fl_SKIPPED_IF               then Foreval.SkippedIF:=False else           {.221}
    if value1 = fl_CALC_CONST_EXPR_IN_MULTI_EXPR   then F_CalcConsExprInMulti:=False else {.221}
    if value1 = fl_MASK_FPU_EXCEPTION       then Foreval.EnableMaskFpuException:=False  else {.229}
    if value1 = fl_FREE_CODE_AT_REPLACE     then  F_FREE_CODE_AT_REPLACE:=False else  {.229}
    if value1 = fl_EXCHANGE_BRANCH          then  Foreval.TreeOptimization:=_Disable else
    if value1 = fl_CALC_CONST_FUNC          then Foreval.EnableCalcConstFUNC:=False else
    if value1 = fl_CALC_CONST_ARG           then Foreval.EnableCalcConstARG:=False else
    if value1 = fl_CALC_CONST_EXT_FUNC      then Foreval.EnableCalcConstExtFunc:=False else
    if value1 = fl_CALC_CONST_MUL_DIV       then Foreval.EnableCalcConstMulDiv:=False else
    if value1 = fl_INTEGER_OPTIMIZATION     then Foreval.IntegerOptimizator:=False else
    if value1 = fl_INTEGER_OPTIMIZATION_EXT_FUNC     then Foreval.IntegerOptimizatorF:=False  else
    if value1 = fl_DATA_IN_ARRAY            then Foreval.DataInArray:=False  else
    if value1 = fl_PIPE_BRACKET_TO_ABS      then Foreval.PipeBracketToAbs:=False else
    if value1 = fl_SQUARE_BRACKET_TO_TRUNC  then Foreval.SquareBracketToTrunc :=False else
    if value1 = fl_CURLY_BRACKET_TO_FRAC    then Foreval.CurlyBracketToFrac:=False else
    if value1 = fl_REPLACE_FUNC_IN_PART     then Foreval.ReplaceFuncInPart:=False else
    if value1 = fl_EXT_NAME_FUNC            then Foreval.ExtNameFunction:=False else
    if value1 = fl_SUBST_NUMCX              then Foreval.SubstNumCX:=False else
    if value1 = fl_PRELIM_SYNT_ERROR        then Foreval.PreliminarySyntaxError:=False else
    if value1 = fl_SYNTAX_OPERATORS         then Foreval.SetSyntaxExtensionForOperations(False) else
    if value1 = fl_OPERATOR                 then Foreval.Operation(value2,False) else
    if value1 = fl_PACKAGE_EXPRESSIONS       then F_PACKAGE_COMPILE:=False else
    if value1 = fl_ALL_REPLACE              then Foreval.EnableAllReplace:=False else
    if value1 = fl_USE_POINTER              then Foreval.UsePointer:=False else
    if value1 = fl_USE_INTEGER_POINTER      then Foreval.UseIntegerPointer:=False else
    if value1 = fl_CHECK_ARRAY_TYPE_CONNECT then Foreval.CheckArrayTypeConnect:=False else
    if value1 = fl_REDUCE_CONST_ARG         then Foreval.EnableReduceArgOptimizator:=False else
    if value1 = fl_REDUCE_CONST_ARG_F       then Foreval.EnableReduceArgOptimizatorF:=False else
    if value1 = fl_DELETE_ZERO_BRANCH       then Foreval.DeleteZeroBranch:=False else
    if value1 = fl_INSERT_INLINE            then Foreval.EnableInline:=False else
    if value1 = fl_MULTI_EXPR               then F_MULTI_EXPR:=False else
    if value1 = fl_CHECK_USED_NAME          then Foreval.CheckUsedName:=False else
    if value1 = fl_FREE_MAIN_DIFF_EXPR      then F_FreeMainDiffExpr := False; {.379}
    //if value1 = fl_ENABLE_POINTER_MATH      then Foreval.EnablePointerMath:=False;// else

  end
 else
if (mode = fl_AUTO) and (value1 = fl_EXCHANGE_BRANCH) then  Foreval.TreeOptimization:=_Auto
else
if mode = fl_STACK_TYPE then
  begin
    if value1 = fl_DOUBLE      then  Foreval.DataType:=_Double  else
    if value1 = fl_EXTENDED    then  Foreval.DataType:=_Extended;
  end
 else
if mode = fl_STACK_DEEP then
  begin
    if (value1 <= 8) and (value1 >= 0) then  Foreval.StackDeep:=value1;
    {.300}  //off
   { if  value1 = 0 then Foreval.DinamicLoad:=False else
    if  value1 >= 1 then Foreval.DinamicLoad:=True;  }
  end
 else
if mode = fl_RESULT_LEAD_TO_TYPE then   {.324}   //Calc_Type
  begin
    if value1 = fl_STAY_AS_IS   then  Foreval.CalcType:=T_Any else      {.324}
    if value1 = fl_REAL         then  Foreval.CalcType:=T_Real else
    if value1 = fl_COMPLEX      then  Foreval.CalcType:=T_Complex;
  end
  else
if mode = fl_STRING_TYPE then
begin
 case value1 of
 fl_STRING:           _STRINGTYPE:=value1;
 fl_ANSISTRING:       _STRINGTYPE:=value1;
 fl_PANSICHAR:        _STRINGTYPE:=value1;
 fl_WIDESTRING:       _STRINGTYPE:=value1;
 fl_STRING_UTF8:      _STRINGTYPE:=value1;
 end;
end
else
if mode = fl_PRECISION then          {.221}
begin
   case value1 of
     fl_DOUBLE:          begin CalcCW:=$1272; Set8087CW($1272);   end;    {.229}
     fl_EXTENDED:        begin CalcCW:=$1372; Set8087CW($1372);  end;     {.229}
   end;
end
else   {.334}
if mode = fl_SPEC_FUNC       then
begin
   if value1 = fl_FAST       then Foreval.FastSpec(True)
    else
   if value1 = fl_ACCURATE   then Foreval.FastSpec(False);
end
else     {.335}
if mode = fl_STD_FUNC_REAL   then
begin
   if value1 = fl_FAST       then Foreval.FastStdFunc(_Real,True)
    else
   if value1 = fl_ACCURATE   then Foreval.FastStdFunc(_Real,False);
end
else     {.335}
if mode = fl_STD_FUNC_COMPLEX then
begin
   if value1 = fl_FAST       then Foreval.FastStdFunc(_Complex,True)
    else
   if value1 = fl_ACCURATE   then Foreval.FastStdFunc(_Complex,False);
end
else      {.335}    {.345}
if mode = fl_COMPLEX_DIV       then
begin
   if value1 = fl_FAST       then Foreval.SetDivMode(_fast)//Foreval.FastDiv(True)
    else
   if value1 = fl_STANDARD   then Foreval.SetDivMode(_standard)
    else
   if value1 = fl_ACCURATE   then Foreval.SetDivMode(_accurate)
    else
   if value1 = fl_EXTRA      then Foreval.SetDivMode(_extra);
end
else     {.335}
if mode = fl_STD_FUNC then
begin
   if value1 = fl_FAST       then
   begin
      Foreval.FastStdFunc(_Real,True);
      Foreval.FastStdFunc(_Complex,True);
      Foreval.SetStdFunc;
   end
   else
   if value1 = fl_ACCURATE   then
   begin
      Foreval.FastStdFunc(_Real,False);
      Foreval.FastStdFunc(_Complex,False);
      Foreval.SetStdFunc;
   end;
end
{else
if mode = fl_POWER_SYMBOL then   Foreval.SetF(5,value1,0) }
else
if mode = fl_FPU_CW then   Set8087CW(value1)           {.203}
else
if mode =  fl_FPU_CW_DEFAULT  then  Set8087CW($1372)  {.203}
else
if mode =   fl_ADDRESS_EXCEPTION_FLAG then   GA_ExceptionFlagAddr:=value1    {.231}
else
if mode = fl_Diff_Numeric_Precision then
begin
  CreateDiff(value1,fc_power(0.1,value2));   //1 <= value11 <=20 порядок интерполяционного многочлена; h <= 0.1; value11 = 1..20; value12=1..19
end
else
if mode = fl_COMPILER_TYPE_EXE then
begin
 if value1 = fl_DELPHI then c_DinArrayLenCorrect:=0
  else
 if value1 = fl_FREE_PASCAL then c_DinArrayLenCorrect:=1;
 Foreval.SetCorrectDynArrayLen(c_DinArrayLenCorrect);
end
else
if mode =  fl_ARCCOTAN_TYPE   then
begin

 if value1 =  fl_ARCCOTAN_STD  then
 begin
     Foreval.ArcCotanSTD:=True;
     //Foreval.SetF(12,CM_ARCCOTAN,0);
     //Foreval.SetF(12,CM_ARCTAN,0);
 end
 else
 if value1 =  fl_ARCCOTAN_1DIV_ARG  then
 begin
     Foreval.ArcCotanSTD:=False;
     //Foreval.SetF(10,CM_ARCCOTAN,0);
     //Foreval.SetF(10,CM_ARCTAN,0);
 end ;


 Foreval.SetReplaceType_ARCTAN_ARCCOTAN(Foreval.ArcCotanSTD);     {.377}

end
else
if mode =  fl_TYPE_OF_DIFFERENTIATION then          {.379}
 begin
   if value1 =  fl_SYMBOLIC  then Foreval.DiffType:=_Symbolic
   else
   if value1 =  fl_NUMERIC  then Foreval.DiffType:=_Numeric
 end
else
if mode =  fl_RETURN_VAL_ON_ZERO_LENGTH then
begin

  if value1 =  fl_ZERO  then    SetRetValOnNilInNAN(False)
   else
  if value1 =     fl_NAN   then    SetRetValOnNilInNAN(True);

end;








(*
if mode = fl_ENABLE_FUNCTION then   Foreval.SetF(1,value1)
else
if mode = fl_DISABLE_FUNCTION then  Foreval.SetF(2,value1)
else
if mode =  fl_ENABLE_REPLACE_FUNCTION then   Foreval.SetF(6,value1)    {.215}
else
if mode =  fl_DISABLE_REPLACE_FUNCTION then   Foreval.SetF(7,value1)    {.215}
else
if mode =  fl_ENABLE_CALC_CONST   then    Foreval.SetF(8,value1)  {.215}
else
if mode =  fl_DISABLE_CALC_CONST   then    Foreval.SetF(9,value1)   {.215}
else
if mode = fl_DISABLE_REPLACE_FUNCTION_COMPLEX then     Foreval.SetF(11,value1)   {.217}
else
if mode = fl_DISABLE_REPLACE_FUNCTION_REAL then       Foreval.SetF(10,value1)   {.217}
else
if mode = fl_ENABLE_REPLACE_FUNCTION_COMPLEX then     Foreval.SetF(13,value1)   {.217}
else
if mode = fl_ENABLE_REPLACE_FUNCTION_REAL then       Foreval.SetF(12,value1)   {.217}
else
*)



end;






procedure flGet(mode,subj: Cardinal; var value: Cardinal);
var
cd,Num,rt,uv: cardinal;
begin
value:=0;
 if (mode = fl_RESULT_TYPE) and (subj = 0) then
   begin
     if Foreval.ResultType = T_Real      then value:=fl_REAL else
     if Foreval.ResultType = T_None      then value:=fl_NONE else
     if Foreval.ResultType = T_Complex   then value:=fl_COMPLEX else
     if Foreval.ResultType = T_Array     then value:=fl_NONE else  {arraycpu}  {.223}
     if Foreval.ResultType = T_Pointer   then value:=fl_NONE;   {arraycpu}
   end
  else
 if mode = fl_RESULT_TYPE then
 begin
   Num:=_FindCmplFunc(subj);
   if Num <> 0 then
   begin
     rt:=CompZ[Num].R_Type;
     if rt = T_Real      then value:=fl_REAL else
     if rt = T_None      then value:=fl_NONE else
     if rt = T_Complex   then value:=fl_COMPLEX else
     if rt = T_Array     then value:=fl_NONE else   {arraycpu}  {.223}
     if rt = T_Pointer   then value:=fl_NONE;   {arraycpu}
   end;
  end
 else
 if mode = fl_IS_FPU_EXCEPTION then
  begin
   //if (Foreval.IsFPUException(@CWMEM) =  0) and (F_CALC_EXCEPTION_IN_SAFE = 0) then value:=fl_NO else value:=fl_YES; {.229}
   value:=_IsFPUException(@CWMEM); {.332}
  end
 else
 if mode = fl_INTERNAL_ERROR_CODE then        {.333}
 begin
       case Foreval.InternalError of
           E_ZeroDivide:          value :=  fl_ZERO_DIVIDE;
           E_InvalidOp:           value :=  fl_INVALID_OPERATION;
           E_OverFlow:            value :=  fl_OVERFLOW;
           E_UnderFlow:           value :=  fl_UNDERFLOW;
           //E_IntOverFlow:         value :=  fl_INT_OVERFLOW;
           E_AccessViolation:     value :=  fl_ACCESS_VIOLATION;
           E_OutOfMemory:         value :=  fl_OUT_OF_MEMORY;
           E_StackOverFlow:       value :=  fl_STACK_OVERFLOW;
       end;
 end
 else
 if mode = fl_PRESENT_COMPLEX_NUMBER then
 begin
     if Foreval.ComplexNumber = True   then value:=fl_YES else value:=fl_NO;
 end
 else
 if mode = fl_COMPILE_STACK_DEEP then  value:=CmplSDeep;
 if mode = fl_COMPILE_OVFL       then
                                  begin
                                    if CmplOverFlow = 1 then value:=fl_YES
                                    else
                                    if CmplOverFlow = 0 then value:=fl_NO;
                                   end;
 if mode = fl_DINAMIC_LOAD_NUM   then  value:=DinLoadNMem
 else
 if mode = fl_DINAMIC_LOAD_STACK_DEEP   then  value:=DinLoadSDeep
 else
 if mode = fl_LOAD_STACK_AFTER_CALC  then  value:=LoadStackAfterCalc        {.197}
 else
 if mode = fl_REPLACE_FUNCTIONS_NUM  then value:=ReplFuncNum  {.193}
 else
 if mode = fl_REPLACE_OPERATIONS_NUM  then value:=ReplOpNum  {.193}
 else
 if mode = fl_EXCHANGE_BRANCH_NUM then value:=XchBrNXch
 else
 if mode =  fl_EXCHANGE_BRANCH_STACK_DEEP  then value:=XchBrSDeep
 else
 if mode = fl_CALC_CONST_FUNC  then value:=CalcConstFunc {.315}
 else
 if mode = fl_CALC_CONST_ARG  then value:=CalcConstARG {.315}
 else
 if mode = fl_CALC_CONST_MUL_DIV  then value:=CalcConstMulDiv {.315}
 else
 if mode = fl_NUMBER_REDUCTIONS  then value:=NumberReductions {.395}
 else
 if mode = fl_ADDRESS_OBJECT  then  value:=subj {.197}
 else
 if mode = fl_PACKAGE_COMPILE_ADDR then value:=Cardinal(P_PackageCompileAddr)  {.357}
 else
 if mode = fl_PESENT_VAR then
 begin
   if subj <> 0 then                   {.333}
   begin
     uv:=Foreval.IsUsedVar(subj);
     if uv = _YES then  value:=fl_YES else
     if uv = _NO  then  value:=fl_NO;
   end
   else
   begin
      if Foreval.PresentVar = True   then value:=fl_YES else value:=fl_NO;
   end;
 end
 else
 if mode = fl_ARRAY_LENGTH then
 begin
  _LEN(subj,cd);
  value:=cd;
 end
 else
 if mode = fl_LENGTH_CODE   then
 begin
    Num:=_FindCmplFunc(subj);
    if Num <> 0 then
    begin
     value:=CompZ[Num].Func.CodeSize;
    end
    else
     value:=CodeSize;
 end
 else
 if mode = fl_VERSION        then
begin
 if subj = fl_MAJOR          then value:=_VMAJOR;
 if subj = fl_MINOR          then value:=_VMINOR;
 if subj = fl_RELEASE        then value:=_VREALISE;
 if subj = fl_BUILD          then value:=_VBUILD;
end
else
if mode = fl_ABOUT        then value:=Cardinal(StrToPtr(_S_ABOUT))
else
if mode = fl_AUTHOR       then value:=Cardinal(StrToPtr(_S_AUTHOR))
else
if mode = fl_COMMENT      then value:=Cardinal(StrToPtr(_S_COMMENT))
else
if mode = fl_STRING_TYPE  then value:=_STRINGTYPE
else
if mode = fl_COMPILED_BY  then value:=_COMPILED_BY


end;





procedure flGetErrorCode(var CError: Cardinal);
begin
CError:=0;
 case Foreval.SyntaxError of

 E_UNKNOWN_SYMBOL:                              CError:=fl_UNKNOWN_SYMBOL;
 E_MISSING_ROUND_BRACKET:                       CError:=fl_MISSING_ROUND_BRACKET;
 E_MISSING_OPERATION:                           CError:=fl_MISSING_OPERATION;
 E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS:           CError:=fl_WRONG_NUMBER_ARGUMENTS;
 E_MISSING_EXPRESSION:                          CError:=fl_MISSING_EXPRESSION;
 E_UNKNOWN_FUNCTION:                            CError:=fl_UNKNOWN_FUNCTION;
 E_UNKNOWN_ARRAY:                               CError:=fl_UNKNOWN_ARRAY;
 E_ABSENT_FUNCTION_FOR_LOAD_TYPE:               CError:=fl_ABSENT_LOAD_FUNCTION_FOR_TYPE;
 E_NOT_DEFINED_OPERATION_FOR_TYPE:              CError:=fl_NOT_DEFINED_OPERATOR;
 E_NOT_DEFINED_FUNCTION_FOR_TYPE:               CError:=fl_NOT_DEFINED_FUNCTION;
 E_INTERNAL_ERROR:                              CError:=fl_INTERNAL_ERROR;
 E_INTERNAL_ERROR_AT_DIFF:                      CError:=fl_INTERNAL_ERROR_AT_DIFF;
 E_ERROR_AT_ADDITION_OF_FUNCTION:               CError:=fl_ERROR_AT_ADDITION_FUNCTION;
 E_WRONG_TYPE:                                  CError:=fl_INCORRECT_TYPE;
 E_WRONG_NAME:                                  CError:=fl_WRONG_NAME;
 E_MISSING_SQUARE_BRACKET:                      CError:=fl_MISSING_SQUARE_BRACKET;
 E_MISSING_CURLY_BRACKET:                       CError:=fl_MISSING_CURLY_BRACKET;
 E_MISSING_ABS_BRACKET:                         CError:=fl_MISSING_ABS_BRACKET;
 E_MISSING_SEPARATOR:                           CError:=fl_MISSING_SEPARATOR;
 E_WRONG_EXPRESSION:                            CError:=fl_WRONG_EXPRESSION;
 E_INTERNAL_ERROR_AT_CALCULATION:               CError:=fl_CALCULATION_ERROR;
 E_INCORRECT_ARGUMENT:                          CError:=fl_INCORRECT_ARGUMENT;
 E_INCORRECT_SPACE:                             CError:=fl_INCORRECT_SPACE;{.195}
 E_VARIABLE_REDECLARED:                         CError:=fl_VARIABLE_REDECLARED; {.221}
 E_NO_DIFF_SYMBOLIC:                            CError:=fl_NO_DIFF_SYMBOLIC;
 E_WRONG_PASSED_DATA:                           CError:=fl_WRONG_PASSED_DATA;
 E_VOID_EXPRESSION:                             CError:=fl_VOID_EXPRESSION;  {.333}
 E_WRONG_SYMBOL:                                CError:=fl_WRONG_SYMBOL;   {.333}
 E_NO_RETURN_NUMBER:                            CError:=fl_NO_RETURN_NUMBER;  {.347}
 E_PROHIBITED_SYMBOL:                           CError:=fl_PROHIBITED_SYMBOL;
 E_NO_FUNCTION_ARGUMENT:                        CError:=fl_NO_FUNCTION_ARGUMENT;
 E_NO_APPLICABLE_TO_EXTERNAL_ARRAY:             CError:=fl_NO_APPLICABLE_TO_EXTERNAL_ARRAY;
 E_MULTI_EXPR_DISABLE:                          CError:=fl_MULTI_EXPR_DISABLE;
 E_LABEL_IN_GOTO_NOT_SET:                       CError:=fl_LABEL_IN_GOTO_NOT_SET;
 E_NO_APPLICABLE_TO_PASSED_ARRAY:               CError:=fl_NO_APPLICABLE_TO_PASSED_ARRAY;
 E_NAME_ALREADY_USED:                           CError:=fl_NAME_ALREADY_USED;
 E_WRONG_PLACEMENT_OPERATOR:                    CError:=fl_WRONG_PLACEMENT_OPERATOR;
 E_ERROR_AT_ADDITION_OF_OPERATOR:               CError:=fl_ERROR_AT_ADDITION_OF_OPERATOR;
 E_UNKNOWN_VARIABLE:                            CError:=fl_UNKNOWN_VARIABLE;
 E_INVALID_FPU_LOADING:                         CError:=fl_INVALID_FPU_LOADING;


 //E_ABSENT_OR_WRONG_SEMICOLON:                   CError:=fl_ABSENT_OR_WRONG_SEMICOLON;
 //else       CError:=Foreval.SyntaxError;
 end;
end;


procedure flGetErrorString(var SError:{$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});
var
S1: String;
begin
S1:=Foreval.SyntaxErrorString;

StrE:=Copy(S1,1,Length(S1));

SError:={$IFDEF STRINGINT}StrE{$ELSE}StrToPtr(StrE){$ENDIF};
end;



procedure flRenameFunction(Name,NewName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});
begin
  Foreval.RenameFunction({$IFDEF STRINGINT}Name,NewName{$ELSE}PtrToStr(Name),PtrToStr(NewName){$ENDIF});
end;


procedure flAddNameFunction(IDF: Integer; AddName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});          stdcall;
var
S: String;
begin

 S:=Copy({$IFDEF STRINGINT}AddName{$ELSE}PtrToStr(AddName){$ENDIF},1,Length({$IFDEF STRINGINT}AddName{$ELSE}PtrToStr(AddName){$ENDIF}));

 if F_LeadToLowerCase = True then S:=LowerCase(S);

 Foreval.SetExtNameFunc(IDF,S);
end;


procedure flPerform(act,subj: Cardinal);
begin
  if act = fl_FREE then
  begin
   case subj of
     fl_VAR_LIST:         Foreval.FreeVar;
     fl_CMPL_FUNC_LIST:   FreeCmplFuncList;
     else                 FreeFunction(subj);
   end;
  end
  else
  if act = fl_CLEAR then
  begin
   case subj of
    fl_ERROR_CODE:  begin ClearError;  end
   end
  end
  else
  if act = fl_SAVE then
  begin
    case subj of
     fl_VAR_LIST:         Foreval.PushVar;
     fl_PARAM_LIST:       Foreval.PushParam;
    end
  end
  else
  if act = fl_RESTORE then
  begin
    case subj of
     fl_VAR_LIST:         Foreval.PopVar;
     fl_PARAM_LIST:       Foreval.PopParam;
    end;
  end
  else
  if act = fl_DISABLE_OPERATION then    {.339}
  begin
     Foreval.Operation(subj,False);
  end
  else
  if act = fl_ENABLE_OPERATION then    {.339}
  begin
     Foreval.Operation(subj,True);
  end
  else
  if act = fl_COMPILE then           {.357}
  begin
     if subj = fl_PACKAGE_EXPRESSIONS then
     begin
       _CompilePackage(P_PackageCompileAddr);
     end;
  end
  else
  //if act = fl_MASK_FPU_EXCEPTION then Foreval.MaskFPUException(@CWMEM) //_MaskFpuException;
  {.332}
  if act = fl_MASK_FPU_EXCEPTION then _MaskFPUException(@CWMEM) //_MaskFpuException;
  else
  if act = fl_CLEAR_FPU_EXCEPTION then  _ResetMaskFPUException(@CWMEM) // Foreval.ClearFpuException;   {.229}
  else
  if act = fl_INIT_FPU then _InitFPU
  else
  if act = fl_CONNECT then       {.379}
  begin
        case subj of
           fl_LOGIC_OPERATIONS_BY_NAMES:
                   if F_ConnectLogicOps = False then ConnectLogicOps(True);
           fl_LOGIC_OPERATIONS_BY_SYMBOLS:
                   if F_ConnectLogicOps = False then ConnectLogicOps(False);
        end;
  end
  else
  if act = fl_RESTORE_AND_CLEAR_TMP_VARS then
  begin
     RestoreAndFreeData;
  end
  else
  if act = fl_CREATE then
  begin
    _CreateLib;
  end
  else
  if act = fl_DESTROY then
  begin
    _DestroyLib;
  end;


end;



{.377B}
procedure flCheckName(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};  var Answ: Integer);
var
NameS: String;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

 Lib_ErrorCode:=0;
 Answ:=0;

 CheckSpace(@NameS);
 if Lib_ErrorCode <> 0 then
 begin
   Answ:=Lib_ErrorCode;
   Lib_ErrorString:=NameS;
 end
 else
 begin
   CheckNamePS(@NameS);
   if Lib_ErrorCode <> 0 then
   begin
     Answ:=Lib_ErrorCode;
     Lib_ErrorString:=NameS;
   end;
 end;


end;




procedure flSetParamD(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Re,Im: Double;  TV: Cardinal);    stdcall;
var
NameS: String;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);


if  CheckNamePS(@NameS) = true  then _SetParam(NameS,Re,Im,TV)
else
begin
  _LibError;
end;


end;



procedure flSetParamE(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Re,Im: Extended;  TV: Cardinal);    stdcall;
var
NameS: String;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);

if  CheckNamePS(@NameS) = true  then _SetParam(NameS,Re,Im,TV)
else
begin
  _LibError;
end;

end;




procedure flSetParamI(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Iparam: Integer);    stdcall;
var
NameS: String;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);

if  CheckNamePS(@NameS) = true  then _SetParam(NameS,IParam,0,fl_REAL)
else
begin
  _LibError;
end;

end;





procedure flSetParamP(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};  PReal: Pointer;  TV: Cardinal);    stdcall;
var
NameS: String;
Re: Extended;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);

if  CheckNamePS(@NameS) = true  then
begin
 case TV of
  fl_SINGLE:   Re:=PSingle(PReal)^;
  fl_INTEGER:  Re:=PInteger(PReal)^;
  fl_DOUBLE:   Re:=PDouble(PReal)^;
  fl_EXTENDED: Re:=PExtended(PReal)^;
 end;
 _SetParam(NameS,Re,0,fl_REAL)
end
else
begin
  _LibError;
end;

end;




procedure flSetParamCxP(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};  PReal,PImage: Pointer;   TV: Cardinal);    stdcall;
var
NameS: String;
Re,Im: Extended;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);

if  CheckNamePS(@NameS) = true  then
begin
  case TV of
  fl_SINGLE:   begin Re:=PSingle(PReal)^;   Im:=PSingle(PImage)^; end;
  fl_INTEGER:  begin Re:=PInteger(PReal)^;  Im:=PInteger(PImage)^; end;
  fl_DOUBLE:   begin Re:=PDouble(PReal)^;   Im:=PDouble(PImage)^; end;
  fl_EXTENDED: begin Re:=PExtended(PReal)^; Im:=PExtended(PImage)^; end;
 end;
 _SetParam(NameS,Re,Im,fl_COMPLEX)
end
else
begin
  _LibError;
end;

end;





procedure flSetVar(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; Addr: Pointer; TV: Cardinal);
var
TypeV,MType: Integer;
NameS: String;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);

                                                                 {.378}
if  (CheckNamePS(@NameS) = true) and (CheckUsedFuncNamePS(@NameS,Foreval.CheckUsedName) = true)  then
begin
  _SetVar(NameS,Addr,TV,ds_ExternalAddr{_External})
end;

 {.377B}
if  Lib_ErrorCode <> 0 then   _LibError;

end;




procedure flSetVarCX(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; AddrRE,AddrIM: Pointer; TV: Cardinal);
var
TypeV,MType: Integer;
NameS: String;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);

                                       {.378}
if  (CheckNamePS(@NameS) = true) and (CheckUsedFuncNamePS(@NameS,Foreval.CheckUsedName) = true)  then _SetVar2(NameS,AddrRE,AddrIM,TV,ds_ExternalAddr{_External})
else
begin
  _LibError;
end;



end;




procedure flSetVarIntrnl(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};  VType: Cardinal; var ExAddr: Pointer);
var
TypeV,MType: Integer;
NameS: String;
begin
{$IFDEF STRINGINT}NameS:=Name{$ELSE}NameS:=PtrToStr(Name){$ENDIF};

if F_LeadToLowerCase = True then NameS:=LowerCase(NameS);

 case VType of
  fl_Real_Single:            begin TypeV:=T_Real;    MType:=_Single; end;
  fl_Real_Double:            begin TypeV:=T_Real;    MType:=_Double; end;
  fl_Real_Extended:          begin TypeV:=T_Real;    MType:=_Extended; end;
  fl_Real_Integer:           begin TypeV:=T_Real;    MType:=_Integer; end;

  fl_Complex_Single:         begin TypeV:=T_Complex; MType:=_Single; end;
  fl_Complex_Double:         begin TypeV:=T_Complex; MType:=_Double; end;
  fl_Complex_Extended:       begin TypeV:=T_Complex; MType:=_Extended; end;

  fl_Array_Real_Double:      begin TypeV:=T_Array;   MType:=_Double; end;
  fl_Array_Real_Extended:    begin TypeV:=T_Array;   MType:=_Extended; end;
  fl_Array_Real_Integer:     begin TypeV:=T_Array;   MType:=_Integer; end;
  fl_Array_Pointer:          begin TypeV:=T_Array;   MType:=_Pointer; end;
  fl_Array_Real_Single:      begin TypeV:=T_Array;   MType:=_Single; end;

  fl_Pointer:                begin TypeV:=T_Pointer; MType:=_Pointer; end;
 end;
                                       {.378}
if  (CheckNamePS(@NameS) = true) and (CheckUsedFuncNamePS(@NameS,Foreval.CheckUsedName) = true)  then _SetVarIntrnlA(NameS, TypeV, MType, ds_InternalAddr, Cardinal(ExAddr))
else
begin
  _LibError;
end;


end;



procedure  flSetVarValueS(Addr: Pointer;  Val: Single);       stdcall;
{asm
  push eax
  mov eax, [Addr]
  fld qword ptr [Val]
  fstp qword ptr [eax]
  pop eax
end;}
begin
  PSingle(Addr)^:=Val
end;


procedure  flSetVarValueD(Addr: Pointer;  Val: Double);       stdcall;
{asm
  push eax
  mov eax, [Addr]
  fld qword ptr [Val]
  fstp qword ptr [eax]
  pop eax
end;}
begin
  PDouble(Addr)^:=Val
end;


procedure  flSetVarValueE(Addr: Pointer;  Val: Extended);       stdcall;
{asm
  push eax
  mov eax, [Addr]
  fld tbyte ptr [Val]
  fstp tbyte ptr [eax]
  pop eax
end; }
begin
  PExtended(Addr)^:=Val
end;


procedure  flSetVarValueI(Addr: Pointer;  Val: Integer);       stdcall;
{asm
  push eax
  push ebx
  mov eax, [Addr]
  mov ebx, [Val]
  mov [eax], ebx
  pop ebx
  pop eax
end; }
begin
  PInteger(Addr)^:=Val
end;



procedure  flSetVarValueCxS(Addr: Pointer;  ValRe,ValIm: Single);       stdcall;
begin
  PSingle(Addr)^:=ValRe;
  PSingle(Cardinal(Addr)+Sh_S)^:=ValIm;
end;



procedure  flSetVarValueCxD(Addr: Pointer;  ValRe,ValIm: Double);       stdcall;
{asm
  push eax
  mov eax, [Addr]
  fld qword ptr [ValRe]
  fstp qword ptr [eax]
  fld qword ptr [ValIm]
  fstp qword ptr [eax+8]
  pop eax
end;}
begin
  PDouble(Addr)^:=ValRe;
  PDouble(Cardinal(Addr)+Sh_D)^:=ValIm;
end;


procedure  flSetVarValueCxE(Addr: Pointer;  ValRe,ValIm: Extended);       stdcall;
{asm
  push eax
  mov eax, [Addr]
  fld tbyte ptr [ValRe]
  fstp tbyte ptr [eax]
  fld tbyte ptr [ValRe]
  fstp tbyte ptr [eax+16]
  pop eax
end;}
begin
  PExtended(Addr)^:=ValRe;
  PEXtended(Cardinal(Addr)+Sh_E)^:=ValIm;
end;


procedure  flGetVarValueCxE(Addr: Pointer;  var ValRe,ValIm: Extended);       stdcall;
begin
  ValRe:=PExtended(Addr)^;
  ValIm:=PEXtended(Cardinal(Addr)+Sh_E)^;
end;


procedure  flGetVarValueCxD(Addr: Pointer;  var ValRe,ValIm: Double);       stdcall;
begin
  ValRe:=PDouble(Addr)^;
  ValIm:=PDouble(Cardinal(Addr)+Sh_D)^;
end;



procedure  flGetVarValueCxS(Addr: Pointer;  var ValRe,ValIm: Single);       stdcall;
begin
  ValRe:=PSingle(Addr)^;
  ValIm:=PSingle(Cardinal(Addr)+Sh_S)^;
end;



procedure  flResultD(Addr: Pointer;  var Res: double);       stdcall;
asm
  push eax
  call Addr
  mov eax, [res]
  fstp qword ptr [eax]
  pop eax
end;


procedure  flResultE(Addr: Pointer;  var Res: extended);     stdcall;
asm
  push eax
  call Addr
  mov eax, [res]
  fstp tbyte ptr [eax]
  pop eax
end;



procedure flResultCxD(Func: Pointer; var Re,Im: double);     stdcall;
var
p:TComplexD;
begin
  asm
   call Func
   push eax
   mov  eax, [re]
   fstp qword ptr [eax]
   mov  eax, [Im]
   fstp qword ptr [eax]
   pop  eax
  end;

{
  asm
   call Func
   fstp p.re
   fstp p.im
  end;

  Res:=p;
  }
end;



procedure flResultCxE(Func: Pointer; var  Re,Im: extended);   stdcall;
var
p:TComplexE;
begin
 asm
   call Func
   push eax
   mov  eax, [Re]
   fstp tbyte ptr [eax]
   mov  eax, [Im]
   fstp tbyte ptr [eax]
   pop  eax
  end;
{
  asm
   call Func
   fstp p.re
   fstp p.im
  end;

  Res:=p;
 }
end;




procedure flResultCxDP(Func: Pointer; Res: Pointer);   stdcall;
asm
   push eax
   call Func
   mov eax, [res]
   fstp qword ptr [eax]
   fstp qword ptr [eax+8]
   pop  eax
end;
{var
p:TComplexD;
begin
  asm
   call Func
   fstp p.re
   fstp p.im
  end;

  Res:=PComplexD(@p);
end;
}


procedure flResultCxEP(Func: Pointer;  Res: Pointer);      stdcall;
asm
   push eax
   call Func
   mov eax, [res]
   fstp tbyte ptr [eax]
   fstp tbyte ptr [eax+16]
   pop  eax
end;
{var
p:TComplexE;
begin
  asm
   call Func
   fstp p.re
   fstp p.im
  end;

  Res:=PComplexE(@p);
end;
}


procedure  flResult(Func: Pointer); assembler;     stdcall;
asm
   call Func
end;






 {
function flResultSafe(Addr: Pointer): Integer;        stdcall;
asm
    push  eax

    sub esp,8
   	fnstcw word ptr [esp];
	  or word ptr [esp], 003Fh;
    fnstcw word ptr [esp+4];       //->store   CW
    fldcw [esp];

    call Addr

    //Catch  FPU Exception
    xor  eax,eax
    fnstsw ax
    sahf
    and  ax, 001Fh   //in eax - error code

    fnclex
    fldcw  word ptr [esp+4]   //<-load        CW
	  add esp, 8


    mov [esp],eax
    pop eax
end;
 }




function flResultSafe(Addr: Pointer): HRESULT;   stdcall;
begin
try
    Result:=0;
 asm
    call Addr
    {push eax
    call Addr
    mov eax, [res]
    fstp qword ptr [eax]
    pop eax  }
 end;
except
    //on E: Exception do   Result:=fl_COMMON_CALCULATON_ERROR;
    on E: EZeroDivide      do Result:=fl_ZERO_DIVIDE;
    on E: EInvalidOp       do Result:=fl_INVALID_OPERATION;
    on E: EOverFlow        do Result:=fl_OVERFLOW;
    on E: EACCESSVIOLATION do Result:=fl_ACCESS_VIOLATION;
    on E: EStackOverFlow   do Result:=fl_STACK_OVERFLOW;
    on E: EOutOfMemory     do Result:=fl_OUT_OF_MEMORY;
    else                      Result:=fl_COMMON_CALCULATON_ERROR;

end;


end;







//procedure  flResultSafeD(Addr: Pointer;  var Res: double);       stdcall;
{function  flResultSafeD(Addr: Pointer;  var Res: double):Integer;       stdcall;
asm

    push  eax

    sub esp,8
	  fnstcw word ptr [esp];
	  or word ptr [esp], 003Fh;
    fnstcw word ptr [esp+4];       //->store   CW
    fldcw [esp];

    call Addr

	  mov eax,[res]
    fstp qword ptr [eax]

    //Catch  FPU Exception
    xor  eax,eax
    fnstsw ax
    sahf
    and  ax, 001Fh   //in eax - error code

    fnclex
    fldcw  word ptr [esp+4]   //<-load        CW
	  add esp, 8


    mov [esp],eax
    pop eax
end;  }



function  flResultSafeD(Addr: Pointer; var Res: double): HRESULT;  stdcall;

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
    fstp qword ptr [eax]
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
 BResult := ((PInt64(@Res)^ and $7FF0000000000000)  = $7FF0000000000000);

  if BResult = True then _Result:=fl_INVALID_OPERATION;
end;

flResultSafeD:=_Result;
end;





//procedure  flResultSafeE(Addr: Pointer;  var Res: double);       stdcall;
{function  flResultSafeE(Addr: Pointer;  var Res: extended):Integer;       stdcall;
asm

    push  eax

    sub esp,8
	  fnstcw word ptr [esp];
	  or word ptr [esp], 003Fh;
    fnstcw word ptr [esp+4];       //->store   CW
    fldcw [esp];

    call Addr

	  mov eax,[res]
    fstp tbyte ptr [eax]

    //Catch  FPU Exception
    xor  eax,eax
    fnstsw ax
    sahf
    and  ax, 001Fh   //in eax - error code

    fnclex
    fldcw  word ptr [esp+4]   //<-load        CW
	  add esp, 8


    mov [esp],eax
    pop eax
end;
}


function  flResultSafeE(Addr: Pointer; var Res: Extended): HRESULT;  stdcall;

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
     BResult := ((TExtented(Res).Exponent and $7FFF)  = $7FFF);
     if BResult = True then _Result:=fl_INVALID_OPERATION;
end;

flResultSafeE:=_Result;

end;




{
//procedure  flResultSafeCxD(Addr: Pointer;  var Re,Im: double);       stdcall;
function  flResultSafeCxD(Addr: Pointer;  var Re,Im: double):Integer;       stdcall;
asm
    push  eax

    sub esp,8
	  fnstcw word ptr [esp];
   	or word ptr [esp], 003Fh;
    fnstcw word ptr [esp+4];       //->store   CW
    fldcw [esp];

    call Addr

    mov eax,  [Re]
    fstp qword ptr [eax]
    mov  eax,  [Im]
    fstp qword ptr [eax]

    //Catch  FPU Exception
    xor  eax,eax
    fnstsw ax
    sahf
    and  ax, 001Fh   //in eax - error code

    fnclex
    fldcw  word ptr [esp+4]   //<-load        CW
	  add esp, 8


    mov [esp],eax
    pop eax
end;
}




function  flResultSafeCxD(Addr: Pointer;  var Re,Im: double): HRESULT;  stdcall;

var

   BResult: Boolean;
  _Result: Integer;

begin
try
 _Result:=0;
 asm
    push eax
    call Addr
    mov eax,  [Re]
    fstp qword ptr [eax]
    mov  eax,  [Im]
    fstp qword ptr [eax]
    pop eax
 end;
except
    //on E: Exception do   Result:=fl_COMMON_CALCULATON_ERROR;
    on E: EZeroDivide      do Result:=fl_ZERO_DIVIDE;
    on E: EInvalidOp       do Result:=fl_INVALID_OPERATION;
    on E: EOverFlow        do Result:=fl_OVERFLOW;
    on E: EACCESSVIOLATION do Result:=fl_ACCESS_VIOLATION;
    on E: EStackOverFlow   do Result:=fl_STACK_OVERFLOW;
    on E: EOutOfMemory     do Result:=fl_OUT_OF_MEMORY;
    else                      Result:=fl_COMMON_CALCULATON_ERROR;

end;





if _Result = 0 then
begin
 BResult := ((PInt64(@Re)^ and $7FF0000000000000)  = $7FF0000000000000);
  if BResult = True then _Result:=fl_INVALID_OPERATION
  else
  begin
    BResult := ((PInt64(@Im)^ and $7FF0000000000000)  = $7FF0000000000000);
    if BResult = True then _Result:=fl_INVALID_OPERATION;
  end;
end;


 flResultSafeCxD:=_Result;
end;



{
//procedure  flResultSafeCxE(Addr: Pointer;  var Re,Im: extended);       stdcall;
function  flResultSafeCxE(Addr: Pointer;  var Re,Im: extended):Integer;       stdcall;
asm
    push  eax

    sub esp,8
	  fnstcw word ptr [esp];
   	or word ptr [esp], 003Fh;
    fnstcw word ptr [esp+4];       //->store   CW
    fldcw [esp];

    call Addr

    mov eax,  [Re]
    fstp tbyte ptr [eax]
    mov  eax,  [Im]
    fstp tbyte ptr [eax]

    //Catch  FPU Exception
    xor  eax,eax
    fnstsw ax
    sahf
    and  ax, 001Fh   //in eax - error code

    fnclex
    fldcw  word ptr [esp+4]   //<-load        CW
	  add esp, 8


    mov [esp],eax
    pop eax
end;
 }


function  flResultSafeCxE(Addr: Pointer;  var Re,Im: extended): HRESULT;  stdcall;

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
    mov eax,  [Re]
    fstp tbyte ptr [eax]
    mov  eax,  [Im]
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
     BResult := ((TExtented(Re).Exponent and $7FFF)  = $7FFF) ;

     if BResult = True then _Result:=fl_INVALID_OPERATION
     else
     begin
      BResult := ((TExtented(Im).Exponent and $7FFF)  = $7FFF);

       if BResult = True then _Result:=fl_INVALID_OPERATION
     end;
end;

flResultSafeCxE:=_Result;

end;




{
//procedure  flResultSafeCxDP(Addr: Pointer;  Res: Pointer);       stdcall;
function  flResultSafeCxDP(Addr: Pointer;  Res: Pointer): Integer;       stdcall;
asm
    push  eax

    sub esp,8
	  fnstcw word ptr [esp];
	  or word ptr [esp], 003Fh;
    fnstcw word ptr [esp+4];       //->store   CW
    fldcw [esp];

    call Addr

    mov eax, [Res]
    fstp qword ptr [eax]
    fstp qword ptr [eax+8]

    //Catch  FPU Exception
    xor  eax,eax
    fnstsw ax
    sahf
    and  ax, 001Fh   //in eax - error code

    fnclex
    fldcw  word ptr [esp+4]   //<-load        CW
	  add esp, 8


    mov [esp],eax
    pop eax
end;
}


function  flResultSafeCxDP(Addr: Pointer;   Res: Pointer): HRESULT;  stdcall;
var
 Re,Im: double;
  BResult: Boolean;
  _Result: Integer;
begin
try
 _Result:=0;
 asm
    push eax
    call Addr
    mov eax, [Res]

    fstp qword ptr [eax]
    fstp qword ptr [eax+8]       //!!!
    {
    fld st(0)
    fstp qword ptr [eax]
    fstp qword ptr Re
    fld st(0)
    fstp qword ptr [eax+8]
    fstp qword ptr Im
    }
    pop eax
 end;
except
    //on E: Exception do   Result:=fl_COMMON_CALCULATON_ERROR;
    on E: EZeroDivide      do Result:=fl_ZERO_DIVIDE;
    on E: EInvalidOp       do Result:=fl_INVALID_OPERATION;
    on E: EOverFlow        do Result:=fl_OVERFLOW;
    on E: EACCESSVIOLATION do Result:=fl_ACCESS_VIOLATION;
    on E: EStackOverFlow   do Result:=fl_STACK_OVERFLOW;
    on E: EOutOfMemory     do Result:=fl_OUT_OF_MEMORY;
    else                      Result:=fl_COMMON_CALCULATON_ERROR;

end;



if _Result = 0 then
begin
 BResult := ((PInt64(@Re)^ and $7FF0000000000000)  = $7FF0000000000000);
  if BResult = True then _Result:=fl_INVALID_OPERATION
  else
  begin
    BResult := ((PInt64(@Im)^ and $7FF0000000000000)  = $7FF0000000000000);
    if BResult = True then _Result:=fl_INVALID_OPERATION;
  end;
end;


 flResultSafeCxDP:=_Result;

end;


{
function flResultSafeCxEP(Addr: Pointer;  Res: Pointer): Integer;                                  stdcall;
asm
    push  eax

    sub esp,8
	  fnstcw word ptr [esp];
	  or word ptr [esp], 003Fh;
    fnstcw word ptr [esp+4];       //->store   CW
    fldcw [esp];

    call Addr

    mov eax, [Res]
    fstp tbyte ptr [eax]
    fstp tbyte ptr [eax+16]     //!!!

    //Catch  FPU Exception
    xor  eax,eax
    fnstsw ax
    sahf
    and  ax, 001Fh   //in eax - error code

    fnclex
    fldcw  word ptr [esp+4]   //<-load        CW
	  add esp, 8


    mov [esp],eax
    pop eax
end;

}


function  flResultSafeCxEP(Addr: Pointer;   Res: Pointer): HRESULT;  stdcall;

type
  TExtented = packed record
    Mantissa: Int64;
    Exponent: Word;
  end;

var

   BResult: Boolean;
  _Result: Integer;
  Re,Im: Extended;

begin
try
 _Result:=0;
 asm
    push eax
    call Addr
    mov eax, [Res]

    fstp tbyte ptr [eax]
    fstp tbyte ptr [eax+16]       //!!!

    {fld st(0)
    fstp tbyte ptr [eax]
    fstp  tbyte ptr Re
    fld st(0)
    fstp tbyte ptr [eax+16]       //!!!
    fstp  tbyte ptr Im }

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
     BResult := ((TExtented(Re).Exponent and $7FFF)  = $7FFF);

     if BResult = True then _Result:=fl_INVALID_OPERATION
     else
     begin
      BResult := ((TExtented(Im).Exponent and $7FFF)  = $7FFF);

       if BResult = True then _Result:=fl_INVALID_OPERATION
     end;
end;

flResultSafeCxEP:=_Result;
end;




procedure _MaskFPUException(CWAddr: PCardinal); stdcall;  {.332}
begin
 asm
    //fnclex    {.332}
    push eax
    mov eax,CWAddr
    fnstcw word ptr [eax];       //->store  CW
    //pop eax
    sub esp,4
    fnstcw [esp];
    or word ptr [esp], 003Fh;
    fldcw [esp];
    add esp, 4

    //задаёт принудительный вызов FPU исключений при вычислении многих специальных ф-ий.
    //Только NAN. INF по преждему не вызывают исключений
    mov eax,[SwitchFPUExceptSpecFunc]
    mov [eax],1

    pop  eax

 end;
end;



procedure _ResetMaskFPUException(CWAddr: PCardinal);
begin
 asm
    push eax
    fnclex
    mov eax,CWAddr
    fldcw  word ptr [eax]   //<-load CW
    //pop eax

    //сбрасывает принудительный вызов FPU исключений при вычислении многих специальных ф-ий.
    mov eax,[SwitchFPUExceptSpecFunc]
    mov [eax],0

    pop  eax

 end;
end;



function _IsFPUException(CWAddr: PCardinal): integer; stdcall; {.332}
begin
 asm
  (*
    push eax
    push ecx
    xor  eax,eax
    fnstsw ax
    sahf
    test ax, 001Fh
    mov  ecx,fl_NO   //0 fl_NO = 61             {.332}
    //push $00000000
    jz @@Z
    mov  ecx,fl_YES  //1 fl_YES = 60            {.332}
    //mov [esp],$00000001
    @@Z:
    mov dword ptr Result,ecx
    //pop dword ptr Result //[IsFPUException]
    fnclex
    mov eax,CWAddr
    fldcw  word ptr [eax]   //<-load    CW
    pop ecx
    pop eax
  *)

    push eax
    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh
    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }

    cmp ax,0
    jz @@REZ
    cmp ax,1
    jnz @@Z1
    mov eax,fl_INVALID_OPERATION
    jmp @@REZ
    @@Z1:
    cmp ax,4
    jnz @@Z2
    mov eax,fl_ZERO_DIVIDE
    jmp @@REZ
    @@Z2:
    cmp ax,8
    jnz @@Z2
    mov eax,fl_OVERFLOW
    jmp @@REZ
    mov eax,fl_INVALID_OPERATION

    @@REZ:
    mov dword ptr Result,eax
    //pop dword ptr Result //[IsFPUException]

    fnclex
    mov eax,CWAddr
    fldcw  word ptr [eax]   //<-load CW
    pop eax

 end;
end;



procedure _InitFPU; assembler;
asm
    fnclex
    fninit
    fldcw word ptr [CalcCW]
end;






procedure flMaskFPUException; stdcall;    {.332}
begin
  _MaskFPUException(@CWMEM);
end;



procedure flResetMaskFPUException; stdcall;    {.332}
begin
  _ResetMaskFPUException(@CWMEM);
end;



function flGetFPUException: Cardinal;  stdcall;{.332}
begin
  flGetFPUException:=_IsFPUException(@CWMEM);
end;





procedure flSetExtAddrErrorFPU(ErrFpuAddr: Pointer); stdcall;
begin
 PFPUErrorAddr:=ErrFpuAddr;
end;





procedure  flResultMaskedFPU(Addr: Pointer); assembler;     stdcall;
asm

    call Addr

    push eax
    push ebx

    mov  ebx,PFPUErrorAddr

    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh


    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }


    mov [ebx],eax

    pop ebx
    pop eax
end;



procedure  flResultMaskedFpuE(Addr: Pointer; var Res: Extended);  stdcall;
asm

    push eax
    push ebx

    call Addr
    mov  eax, [Res]
    fstp tbyte ptr [eax]


    mov  ebx,PFPUErrorAddr

    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh


    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }

    mov [ebx],eax

    pop ebx
    pop eax
end;



procedure  flResultMaskedFpuD(Addr: Pointer; var Res: Double);  stdcall;
asm

    push eax
    push ebx

    call Addr
    mov  eax, [Res]
    fstp qword ptr [eax]


    mov  ebx,PFPUErrorAddr

    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh


    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }

    mov [ebx],eax

    pop ebx
    pop eax
end;





procedure  flResultMaskedFpuCxE(Addr: Pointer; var Re,Im: Extended);  stdcall;
asm

    push eax
    push ebx

    call Addr

    mov  eax, [Re]
    mov  ebx, [Im]
    fstp tbyte ptr [eax]
    fstp tbyte ptr [ebx]


    mov  ebx,PFPUErrorAddr

    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh


    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }

    mov [ebx],eax

    pop ebx
    pop eax
end;



procedure  flResultMaskedFpuCxD(Addr: Pointer; var Re,Im: double);  stdcall;
asm

    push eax
    push ebx

    call Addr

    mov  eax, [Re]
    mov  ebx, [Im]
    fstp qword ptr [eax]
    fstp qword ptr [ebx]


    mov  ebx,PFPUErrorAddr

    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh


    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }

    mov [ebx],eax

    pop ebx
    pop eax
end;




procedure  flResultMaskedFpuCxEP(Addr: Pointer; Res: Pointer);  stdcall;
asm

    push eax
    push ebx

    call Addr
    mov  eax, [Res]
    fstp tbyte ptr [eax]
    fstp tbyte ptr [eax+16]       //!!!


    mov  ebx,PFPUErrorAddr

    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh


    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }

    mov [ebx],eax

    pop ebx
    pop eax
end;





procedure  flResultMaskedFpuCxDP(Addr: Pointer; Res: Pointer);  stdcall;
asm

    push eax
    push ebx

    call Addr
    mov  eax, [Res]
    fstp qword ptr [eax]
    fstp qword ptr [eax+8]       //!!!


    mov  ebx,PFPUErrorAddr

    xor  eax,eax
    fnstsw ax
    sahf
    and ax, 001Fh


    {
      //1 - ivalid op; 4 div zero ; 8 - overflow
    }

    mov [ebx],eax

    pop ebx
    pop eax
end;









function  flIsNAN(val: extended): integer; stdcall;
begin
asm
 fld tbyte ptr[val]
 sub  esp,10
 fstp tbyte ptr [esp]
 mov  ax,[esp+8]
 add  esp,10
 and  ax,$7fff
 cmp  ax,$7fff
 jnz  @@1
 mov @Result,1
 //fld1
 jmp  @@3
 @@1:
 //fldz
 mov @Result,0
 @@3:
end;
end;







procedure flSetNameImUnit(Name: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});   stdcall;
var
S: String;
begin
 S:=Copy({$IFDEF STRINGINT}Name{$ELSE}PtrToStr(Name){$ENDIF},1,Length({$IFDEF STRINGINT}Name{$ELSE}PtrToStr(Name){$ENDIF}));

 if F_LeadToLowerCase = True then S:=LowerCase(S);
 Foreval.SetImUnitName(S);
end;


{.191}
procedure flGetFuncIDN(FName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; var IDN: Integer);   stdcall;
var
S: String;
begin
 S:=Copy({$IFDEF STRINGINT}FName{$ELSE}PtrToStr(FName){$ENDIF},1,Length({$IFDEF STRINGINT}FName{$ELSE}PtrToStr(FName){$ENDIF}));

 if F_LeadToLowerCase = True then S:=LowerCase(S);
 Foreval.FindFuncA(S,IDN);
end;



                                                           {.328}
procedure _GetFunctionID(FSName: String; FData: Pointer; {var} idfP: Pointer);
label endp;
var
 NumArg,ResType,i,TypeV,MType,IDFN,IDFA: Integer;
 ListF: PArrayI;
 TV,TM: TArrayI;
 //FSName: String;
begin
{
 FData.Field1 = NumArg
 FData.Field2 = ResType
 FData.Field3 = ArgType1
 ............
 FData.FieldN = ArgTypeN
}


 ListF:=@TArrayI(FData);

try

 if FData <> nil then
 begin
   NumArg:=ListF^[0];
   ResType:=ListF^[1];
 end
 else
 begin
   ResType := fl_ANY;
   NumArg := fl_ANY;
 end;

  if (ResType = fl_ANY) and  (NumArg = fl_ANY) then
  begin
   Foreval.FindFuncA(FSName,IDFN);
   if IDFN <> _NOT_FOUND then
      IDFA:=0 else IDFA:=fl_NOT_FOUND;
   goto endp;
  end;

  if ResType = fl_Real  then  ResType := T_Real
  else
  if ResType = fl_Complex  then  ResType := T_Complex;

  if NumArg <> fl_ANY  then
  begin
    SetLength(TV,NumArg);
    SetLength(TM,NumArg);

    for i := 0 to NumArg-1 do
    begin
       case ListF^[i+2] of
         fl_Real_Double:               begin TypeV:=T_Real;    MType:=_Double; end;
         fl_Real_Extended:             begin TypeV:=T_Real;    MType:=_Extended; end;
         fl_Real_Single:               begin TypeV:=T_Real;    MType:=_Single; end;
         fl_Complex_Double:            begin TypeV:=T_Complex; MType:=_Double; end;
         fl_Complex_Extended:          begin TypeV:=T_Complex; MType:=_Extended; end;
         fl_Complex_Single:            begin TypeV:=T_Complex; MType:=_Single; end;
         fl_Array_Real_Double:         begin TypeV:=T_Array;   MType:=_Double; end;
         fl_Array_Real_Extended:       begin TypeV:=T_Array;   MType:=_Extended; end;
         fl_Array_Real_Integer:        begin TypeV:=T_Array;   MType:=_Integer; end;
         fl_Array_Real_Single:         begin TypeV:=T_Array;   MType:=_Single; end;
         fl_Array_Pointer:             begin TypeV:=T_Array;   MType:=_Pointer; end;
         fl_Real_Integer:              begin TypeV:=T_Real;    MType:=_Integer; end;
         fl_Real:                      begin TypeV:=T_Real;    MType:=_ANY; end;
         fl_Complex:                   begin TypeV:=T_Complex; MType:=_ANY; end;
         fl_Pointer:                   begin TypeV:=T_Pointer; MType:=_Pointer; end;
         fl_ANY:                       begin TypeV:=_ANY;      MType:=_ANY; end;
       else                            Lib_ErrorCode:=E_WRONG_PASSED_DATA;
       end;

       TV[i]:=TypeV;
       TM[i]:=MType;
    end;

    Foreval.FindFuncID(FSName,NumArg,ResType,TV,TM,IDFN,IDFA);
  end
  else
  Foreval.FindFuncB(FSName,NumArg,ResType,IDFN,IDFA);


endp:
   {
  idFunc.idName:=IDFN;
  idFunc.idArg:=IDFA;
  idfP:=@idFunc;
  }
  {.328}
  PidFunc(idfP)^.idName:=IDFN;
  PidFunc(idfP)^.idArg:=IDFA;

except
 Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
 Foreval.SyntaxErrorString:='flGetFunctionID';
 Foreval.IntException;
end;

end;



                                                                                                       {.328}
procedure flGetFunctionIDFP(FName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; FData: Pointer; {var} idfP: Pointer);
var
FSName: String;
begin
{
 FData.Field1 = NumArg
 FData.Field2 = ResType
 FData.Field3 = ArgType1
 ............
 FData.FieldN = ArgTypeN
}

//FSName:=Copy({$IFDEF STRINGINT}FName{$ELSE}PtrToStr(FName){$ENDIF},1,Length({$IFDEF STRINGINT}FName{$ELSE}PtrToStr(FName){$ENDIF}));
{$IFDEF STRINGINT}
FSName:=FName;
{$ELSE}
FSName:=PtrToStr(FName);
{$ENDIF}

if F_LeadToLowerCase = True then FSName:=LowerCase(FSName);

_GetFunctionID(FSName,FData,idfP);

end;


{.353}
procedure flGetFunctionAddr(idfP: Pointer; var AddrFP: Pointer{Cardinal});    stdcall;
var
 idFunc: TidFunc;
begin
  idFunc:=TidFunc(idfP^);
  Foreval.GetFuncAddr(idFunc.idName,idFunc.idArg, Cardinal(AddrFP));
end;


procedure flChangeFunctionProperty(Action: Cardinal; idfP: Pointer);
var
 //FData: TArrayI;
 //i: Integer;
 //idfP: Pointer;
 ifFunc: TidFunc;

begin

idFunc:=TidFunc(idfP^);

if Action = fl_DELETE then Foreval.DeleteFunc(idFunc.idName,idFunc.idArg)
else
if Action = fl_ENABLE_FUNCTION then   Foreval.SetF(1,idFunc.idName,idFunc.idArg)
else
if Action = fl_DISABLE_FUNCTION then  Foreval.SetF(2,idFunc.idName,idFunc.idArg)
else
if Action =  fl_ENABLE_REPLACE_FUNCTION then   Foreval.SetF(6,idFunc.idName,idFunc.idArg)
else
if Action =  fl_DISABLE_REPLACE_FUNCTION then   Foreval.SetF(7,idFunc.idName,idFunc.idArg)
else
if Action =  fl_ENABLE_CALC_CONST   then    Foreval.SetF(8,idFunc.idName,idFunc.idArg)
else
if Action =  fl_DISABLE_CALC_CONST   then    Foreval.SetF(9,idFunc.idName,idFunc.idArg)
else
if Action = fl_DISABLE_REPLACE_FUNCTION_COMPLEX then     Foreval.SetF(11,idFunc.idName,idFunc.idArg)
else
if Action = fl_DISABLE_REPLACE_FUNCTION_REAL then       Foreval.SetF(10,idFunc.idName,idFunc.idArg)
else
if Action = fl_ENABLE_REPLACE_FUNCTION_COMPLEX then     Foreval.SetF(13,idFunc.idName,idFunc.idArg)
else
if Action = fl_ENABLE_REPLACE_FUNCTION_REAL then       Foreval.SetF(12,idFunc.idName,idFunc.idArg)
else
if Action = fl_DELETE_EXTENDED_NAMES_FUNCTION then       Foreval.SetF(18,idFunc.idName,idFunc.idArg)
else
if Action = fl_SET_POWER_SYMBOL then   Foreval.SetF(5,idFunc.idName,0);
;

end;





                                                                                                {.328}
procedure flSetFunction(NameF: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; FAdr: Pointer; {var}  idfP: Pointer);
var
S: String;
begin
//S:=Copy({$IFDEF STRINGINT}NameF{$ELSE}PtrToStr(NameF){$ENDIF},1,Length({$IFDEF STRINGINT}NameF{$ELSE}PtrToStr(NameF){$ENDIF}));

{$IFDEF STRINGINT}
S:=NameF;
{$ELSE}
S:=PtrToStr(NameF);
{$ENDIF}

if F_LeadToLowerCase = True then S:=LowerCase(S);

_SetFunction(S,FAdr,idfP);

end;


                                                      {.328}
procedure _SetFunction(Name: String; FAdr: Pointer; {var} idfP: Pointer);
label 1,ler,endf,endp;
var
N,K,i,idf,idn: Integer;
FS:  TIntFunc;
TypeV,MType,CError,CP,P,CT,adr: Cardinal;
TV: PArrayI;
ResT,ResM: Cardinal;
CallF,CallT,SDeep,ECode,CT1: Integer;
FuncStruct: TAddFuncStruct;
PF: ^TAddFuncStruct;
E: Exception;
SN,SF,NameF,S,SNE: String;
VNS: TArraySt;
CAdr: Pointer;
idName,idArg: Integer;
FData: TArrayI;
begin
ECode:=0;
//Lib_ErrorCode:=0;


CError:=0;
//Foreval.SyntaxError:=0;
ClearError;   {.300}
idName:=-1;
idArg:=-1;

SetLength(ATL,0);

//if Foreval.LeadToLowerCase = True then NameF:=LowerCase(NameF); {.221}

NameF:=Copy(Name,1,Length(Name));
Lib_ErrorString:=NameF;

 //MessageDlg(NameF,mtError,[mbOk],0);    //DEBUG

(*
if F_FindWrongSpace = True then      {.195}
begin
  CheckFalseBlank(NameF,NameF);
  if Lib_ErrorCode <> 0 then
  begin
    Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;
    goto endp;
  end;
end
else
DeleteSpace(NameF,NameF);


if NameF = '' then
begin
 Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION;
 //Foreval.SyntaxError:=ECode;
 goto ler;
end;
*)

CheckSpace(@NameF);
if Lib_ErrorCode <> 0 then  goto ler;






  {
  fnc():real=1.123
  fnc():real=1.123345
  переустановка
  }
if FAdr = nil then    //fl_PRECOMPILED: whole string
begin
  pcCompile(NameF,NameF,FAdr);
  if Lib_ErrorCode <> 0 then goto ler;
end ;


try

PF:=FAdr;
FuncStruct:=PF^;


Foreval.InitFuncStruct(FS);
FS.Addr:=Cardinal(FuncStruct.addr);

//if FuncStruct.IsInline = fl_ENABLE then FS.IsInline:=_YES;



if FuncStruct.CallFunc = fl_INFINITE then
begin
 FS.NArg:=_INFINITE;       //??

 SetLength(FS.TV,1); SetLength(FS.TM,1);

 case FuncStruct.ArgType of
    fl_Real_Double:               begin TypeV:=T_Real;    MType:=_Double; end;
    fl_Real_Extended:             begin TypeV:=T_Real;    MType:=_Extended; end;
    fl_Real_Single:               begin TypeV:=T_Real;    MType:=_Single; end;
    fl_Complex_Double:            begin TypeV:=T_Complex; MType:=_Double; end;
    fl_Complex_Extended:          begin TypeV:=T_Complex; MType:=_Extended; end;
    fl_Complex_Single:            begin TypeV:=T_Complex; MType:=_Single; end;
    fl_Real_Integer:              begin TypeV:=T_Real;    MType:=_Integer; end;
    fl_Pointer:                   begin TypeV:=T_Pointer; MType:=_Pointer; end;
    fl_differ_Double:             begin {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;  end;
    fl_differ_Extended:           begin {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;  end;
    else                          {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION
 end;

 FS.TV[0]:=TypeV;
 FS.TM[0]:=MType;

 FS.CallT:=_STACK_INFINITE;

 //if FuncStruct.ArgType = fl_differ_Double then begin FS.CallT:=_INTERNAL_INFINITE_ANY; FS.NArg:=-2; FS.TM[0]:=_Double; end;
 //if FuncStruct.ArgType = fl_differ_Extended then begin FS.CallT:=_INTERNAL_INFINITE_ANY; FS.NArg:=-2; FS.TM[0]:=_Extended; end;

 goto 1;
end;


  //db:
  //MessageDlg(NameF+'(Arg)'+IntToStr(FuncStruct.Arg),mtError,[mbOk],0);
  //MessageBox(0,PChar(S+#13+#10+'"'+F_SyntaxErrorString+'"'),PChar('Foreval error'),MB_ICONERROR);

 N:=FuncStruct.Arg;
 FS.NArg:=N;
 SetLength(FS.TV,N); SetLength(FS.TM,N);


 if (FuncStruct.ArgType = fl_DIFFER) or (FuncStruct.ArgTypeList <> nil) then
 begin
  TV:=@TArrayI(FuncStruct.ArgTypeList);
  SetLength(ATL,FS.NArg);
  for i:=0 to N-1 do
  begin
   case TV^[i] of
    fl_Real_Double:               begin TypeV:=T_Real;    MType:=_Double; end;
    fl_Real_Extended:             begin TypeV:=T_Real;    MType:=_Extended; end;
    fl_Real_Single:               begin TypeV:=T_Real;    MType:=_Single; end;
    fl_Complex_Double:            begin TypeV:=T_Complex; MType:=_Double; end;
    fl_Complex_Extended:          begin TypeV:=T_Complex; MType:=_Extended; end;
    fl_Complex_Single:            begin TypeV:=T_Complex; MType:=_Single; end;
    fl_Array_Real_Double:         begin TypeV:=T_Array;   MType:=_Double; end;
    fl_Array_Real_Extended:       begin TypeV:=T_Array;   MType:=_Extended; end;
    fl_Array_Real_Single:         begin TypeV:=T_Array;   MType:=_Single; end;
    fl_Array_Real_Integer:        begin TypeV:=T_Array;   MType:=_Integer; end;
    fl_Array_Pointer:             begin TypeV:=T_Array;   MType:=_Pointer; end;
    fl_Real_Integer:              begin TypeV:=T_Real;    MType:=_Integer; end;
    fl_Pointer:                   begin TypeV:=T_Pointer; MType:=_Pointer; end;
    else                          {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION
   end;
   FS.TV[i]:=TypeV;
   FS.TM[i]:=MType;
   ATL[i]:=TV^[i];
   end;
 end
 else
 begin
  SetLength(ATL,FS.NArg);
  for i:=0 to N-1 do
  begin
   case FuncStruct.ArgType of
    fl_Real_Double:               begin TypeV:=T_Real;    MType:=_Double; end;
    fl_Real_Extended:             begin TypeV:=T_Real;    MType:=_Extended; end;
    fl_Real_Single:               begin TypeV:=T_Real;    MType:=_Single; end;
    fl_Complex_Double:            begin TypeV:=T_Complex; MType:=_Double; end;
    fl_Complex_Extended:          begin TypeV:=T_Complex; MType:=_Extended; end;
    fl_Complex_Single:            begin TypeV:=T_Complex; MType:=_Single; end;
    fl_Array_Real_Double:         begin TypeV:=T_Array;   MType:=_Double; end;
    fl_Array_Real_Extended:       begin TypeV:=T_Array;   MType:=_Extended; end;
    fl_Array_Real_Single:         begin TypeV:=T_Array;   MType:=_Single; end;
    fl_Array_Real_Integer:        begin TypeV:=T_Array;   MType:=_Integer; end;
    fl_Array_Pointer:             begin TypeV:=T_Array;   MType:=_Pointer; end;
    fl_Real_Integer:              begin TypeV:=T_Real;    MType:=_Integer; end;
    fl_Pointer:                   begin TypeV:=T_Pointer; MType:=_Pointer; end;
    else                          {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION
   end;
   FS.TV[i]:=TypeV;
   FS.TM[i]:=MType;
   ATL[i]:=FuncStruct.ArgType
   end;
 end;

 if (FuncStruct.ArgTypeList <> nil) and (FuncStruct.ArgType <> fl_DIFFER) then {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;

 case FuncStruct.CallFunc of
   fl_VARS_VALUES:                 CallF:=_Stack_Val;
   fl_VARS_ADDRS:                  CallF:=_Stack_Addr;
   fl_VARS_LIST_ADDR_EAX:          CallF:=_Memory_EAX;
   fl_VARS_LIST_ADDR_ESP:          CallF:=_Memory_ESP;
   fl_PRECOMPILED:                 CallF:=_Compiled;
   else             {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;
 end;

 FS.CallT:=CallF;

1:
 case FuncStruct.CallType of
   fl_CDECL:    CallT:=_Cdecl;
   fl_STDCALL:  CallT:=_StdCall;
   fl_PASCAL:   CallT:=_Pascal;
   else  if CallF = _Compiled then CallT:=_Compiled else  {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;
 end;

 if FuncStruct.ResultType = fl_REAL then ResT:=T_Real else
   if FuncStruct.ResultType = fl_COMPLEX then ResT:=T_Complex else
     if FuncStruct.ResultType = fl_NONE then ResT:=T_NONE else
     {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;

 //ResM:=_Extended;
 if FuncStruct.ResultTypeMath = fl_EXTENDED then ResM:=_Extended else
   if FuncStruct.ResultTypeMath = fl_DOUBLE then ResM:=_Double else
     if FuncStruct.ResultTypeMath = fl_INTEGER then ResM:=_Integer else
       if FuncStruct.ResultTypeMath = fl_POINTER then ResM:=_Pointer else
        if FuncStruct.ResultTypeMath = fl_SINGLE then ResM:=_Single else
                                                      ResM:=_Extended;   //для совместимости с предыдущими версиями
           //Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;

 if FuncStruct.DeepFPU = fl_UNKNOWN then SDeep:=-1 else
   if (FuncStruct.DeepFPU  < 0) or (FuncStruct.DeepFPU > 8) then
     {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION  else SDeep:=FuncStruct.DeepFPU;

 if FuncStruct.Place = fl_NEW then FS.Place:=_New else                             {.308}
    if FuncStruct.Place = fl_ReWrite then FS.Place:=_ReWrite else FS.Place:=_New;

 FS.TypeF:=ResT;
 FS.TypeM:=ResM;
 FS.SDeep:=SDeep;
 FS.SaveReg:=FuncStruct.SaveReg;
 FS.Id_Func:=FuncStruct.Id_Func;

 if  FuncStruct.Set_ID = fl_ENABLE then FS.Set_ID:=_YES
 else
 if  FuncStruct.Set_ID = fl_DISABLE then FS.Set_ID:=_NO;

 if FuncStruct.CalcConst = fl_YES then FS.CalcConst:=_YES else FS.CalcConst:=_NO;
 if FuncStruct.ReplFunc = fl_YES then FS.ReplFunc:=_YES else FS.ReplFunc:=_NO; {.193}
 if FuncStruct.IsInline = fl_YES then FS.IsInline:=_YES else  FS.IsInline:=_NO;



 if CallT = _Pascal then  FS.Arrow:=_Back else
 if CallT = _StdCall then FS.Arrow:=_Right else
 if CallT = _Cdecl then   FS.Arrow:=_Right;

 if  CallT = _Cdecl then FS.CLST:=_YES;


if FuncStruct.CallFunc = fl_PRECOMPILED then
begin
  //NameF:=Copy({$IFDEF STRINGINT}Name{$ELSE}PtrToStr(Name){$ENDIF},1,Length({$IFDEF STRINGINT}Name{$ELSE}PtrToStr(Name){$ENDIF}));
  //DeleteSpace(NameF,NameF);
  P:=Pos('=',NameF);
  SN:=Copy(NameF,1,P-1);
  SF:=Copy(NameF,P+1,Length(NameF)-P+1);


  SNE:=SN; Lib_ErrorString:=SNE;

  if (SF = '') or (SN = '') then   {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;

  pcGetFuncVarName(SN,SN,VNS);
  FS.NArg:=Length(VNS);
  SetLength(ATL,FS.NArg);

  if CheckNamePS(@SN) = false  then    {.357}
  begin
    goto endf;
  end;


  if CheckUsedVarName(SN, Foreval.CheckUsedName) = false then goto endf;     {.377D}

  for  i:= 0 to Length(VNS)-1 do          {.357}
  begin
    if CheckNamePS(@VNS[i]) = false  then
    begin
       //Lib_ErrorString:=PExpr^[i] + ' in: ' + PExpr^;
       Lib_ErrorString:=Lib_ErrorString+ #13#10+' in function:  '+ #13#10+SNE;
       goto endf   {.357}
    end;
  end;




 N:=FS.NArg;
 SetLength(FS.TV,N); SetLength(FS.TM,N);
 if (FuncStruct.ArgType = fl_DIFFER) or (FuncStruct.ArgTypeList <> nil) then
 begin
  TV:=@TArrayI(FuncStruct.ArgTypeList);
  for i:=0 to N-1 do
  begin
   case TV^[i] of
    fl_Real_Double:               begin TypeV:=T_Real;    MType:=_Double; end;
    fl_Real_Extended:             begin TypeV:=T_Real;    MType:=_Extended; end;
    fl_Real_Single:               begin TypeV:=T_Real;    MType:=_Single; end;
    fl_Complex_Double:            begin TypeV:=T_Complex; MType:=_Double; end;
    fl_Complex_Extended:          begin TypeV:=T_Complex; MType:=_Extended; end;
    fl_Complex_Single:            begin TypeV:=T_Complex; MType:=_Single; end;
    fl_Array_Real_Double:         begin TypeV:=T_Array;   MType:=_Double; end;
    fl_Array_Real_Extended:       begin TypeV:=T_Array;   MType:=_Extended; end;
    fl_Array_Real_Single:         begin TypeV:=T_Array;   MType:=_Single; end;
    fl_Array_Real_Integer:        begin TypeV:=T_Array;   MType:=_Integer; end;
    fl_Array_Pointer:             begin TypeV:=T_Array;   MType:=_Pointer; end;
    fl_Real_Integer:              begin TypeV:=T_Real;    MType:=_Integer; end;
    fl_Pointer:                   begin TypeV:=T_Pointer; MType:=_Pointer; end;
    else                          {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION
   end;
   FS.TV[i]:=TypeV;
   FS.TM[i]:=MType;
   ATL[i]:=TV^[i];
   end;
 end
 else
 begin
  for i:=0 to N-1 do
  begin
   case FuncStruct.ArgType of
    fl_Real_Double:               begin TypeV:=T_Real;    MType:=_Double; end;
    fl_Real_Extended:             begin TypeV:=T_Real;    MType:=_Extended; end;
    fl_Real_Single:               begin TypeV:=T_Real;    MType:=_Single; end;
    fl_Complex_Double:            begin TypeV:=T_Complex; MType:=_Double; end;
    fl_Complex_Extended:          begin TypeV:=T_Complex; MType:=_Extended; end;
    fl_Complex_Single:            begin TypeV:=T_Complex; MType:=_Single; end;
    fl_Array_Real_Double:         begin TypeV:=T_Array;   MType:=_Double; end;
    fl_Array_Real_Extended:       begin TypeV:=T_Array;   MType:=_Extended; end;
    fl_Array_Real_Single:         begin TypeV:=T_Array;   MType:=_Single; end;
    fl_Array_Real_Integer:        begin TypeV:=T_Array;   MType:=_Integer; end;
    fl_Array_Pointer:             begin TypeV:=T_Array;   MType:=_Pointer; end;
    fl_Real_Integer:              begin TypeV:=T_Real;    MType:=_Integer; end;
    fl_Pointer:                   begin TypeV:=T_Pointer; MType:=_Pointer; end;
    else                          {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION
   end;
   FS.TV[i]:=TypeV;
   FS.TM[i]:=MType;
   ATL[i]:=FuncStruct.ArgType;
   end;
 end;

 if (FuncStruct.ArgTypeList <> nil) and (FuncStruct.ArgType <> fl_DIFFER) then {ECode}Lib_ErrorCode:=fl_ERROR_AT_ADDITION_FUNCTION;



  pcSetFunc(VNS,SF,SF);
  inc(F_CurrentIntFunc);
  CT:=Foreval.CalcType;
  if FuncStruct.ResultType = fl_REAL then  Foreval.CalcType:=T_Real;



  if {(ECode = 0) and} (Lib_ErrorCode = 0)
  then
  begin
    F_ClearCurrentNameSet:=False;    {.229}
    if CheckSyntaxErrorPS(@SF,CM_WholeExpr) = True then
    begin
       F_CompileMode := cm_FunctionBody;
       _Compile(SF,CAdr);   //{.346}
    end;
    F_ClearCurrentNameSet:=True;      {.229}
  end
  else
  begin
    PopParam;
    PopVar;      {.229}
  end;


  Foreval.CalcType:=CT;
  flGetErrorCode(CError);
  FS.addr:=Cardinal(CAdr);
  FS.CodeSize:=CodeSize;
  //FS.IsInline:=

  if CError = 0 then
  begin
     flGet(fl_COMPILE_OVFL,0,CP);
     if CP = fl_YES then  {FS.SDeep:=-1}FS.SDeep:=8 {.209}  //max value
     else
     if CP = fl_NO  then
     begin
      flGet(fl_COMPILE_STACK_DEEP,0,CP);
      FS.SDeep:=CP;
     end;


     N:=Length(CVA);
     if N <> FS.NArg then
     begin
       //ECode:=fl_ERROR_AT_ADDITION_FUNCTION;
       Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION;
       goto endf;
     end;

     SetLength(FS.ArgAdr,N);

     for i:=0 to N-1 do
     begin
       FS.ArgAdr[i]:=CVA[i];
     end;
     //удалить такую же ф-ию (если есть)
     //Foreval.FindFunc(SN,FS.TV,idn,idf,CT1,adr);
     //_DeleteExtFunction(SN,FS);
     _DeleteSameFunction(SN,FS);

  end;

  NameF:=Copy(SN,1,Length(SN));
  //if NameF = ''  then  begin ECode:=11;  end;
endf:
end;

except
  on E:  EAccessViolation do
   begin
        Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION;
        Foreval.InternalError:=E_AccessViolation;
    end;
//ECode:=E_ERROR_AT_ADDITION_OF_FUNCTION;


end;

ler:
if {(ECode = 0) and} (Lib_ErrorCode = 0)   then
begin
 if FS.NArg = 0  then  FS.CalcConst:=_NO;   {.203} //func1(): real=sin(x)

 if CheckNamePS(@NameF) = true then
 begin
    Foreval.SetFunctionExt(NameF,FS,idName,idArg);
    PidFunc(idfP)^.idName:=idName;
    PidFunc(idfP)^.idArg:=idArg;
    AddNewFuncD(NameF,FS,FuncStruct.AdrDeriv,FuncStruct.NDeriv);
 end
 else
 begin
   _LibError;
 end;

  RestoreAndFreeData;   {.385}

 {idFuncF.idName:=idName;
 idFuncF.idArg:=idArg;
 idfP:=@idFuncF;}
 {.328}




end
else
begin
  if Lib_ErrorCode <> 0 then  Foreval.SyntaxError:=Lib_ErrorCode else Foreval.SyntaxError:=E_ERROR_AT_ADDITION_OF_FUNCTION;
  Foreval.SyntaxErrorString:=Lib_ErrorString;
  Foreval.IntException;
end;

endp:
end;



{
  Добавление имён производных внешней функции, заданных по указанным адресам
  Ограничение: только для функции с одной переменной
  Имена производных заданы: ИмяФункции+Суффикс(=)+Порядок Производной
  Внутри используется для сплайн-функций
}
procedure AddNewFuncD(NameF: String; FS: TIntFunc; AdrDeriv: Pointer; NDeriv: Cardinal);
var
 DL: PArrayI;
  I,NArg: Integer;
  SDName: String;                           //func#1, func#2, ...,func#n - names of derivatives order of 1,2,...n
  idName,idArg: Integer;

begin

  NArg:=FS.NArg;

//ForevD.AddExtFuncN(Func.Name,NArg);

if (AdrDeriv <> nil) and (NDeriv > 0) and  (NArg = 1) then
 begin

   DL:=@TArrayI(AdrDeriv);
   for I := 0 to NDeriv-1 do
   begin
     if DL^[i] <> 0 then
     begin
      Cardinal(FS.addr):=DL^[i];
      SDName:=NameF+SeparatorNameDeriv+IntToStr(i+1);
      Foreval.EnableCheckName:=False;
      Foreval.SetFunctionExt(SDName,FS,idName,idArg);
      Foreval.EnableCheckName:=True;
      //ForevD.AddExtFunc(S);
     end;
   end;

   //if _MaxDeriv < NDeriv then _MaxDeriv:=NDeriv;

 end;



end;




procedure  _DeleteSameFunction(SN: String; FS: TIntFunc);
var
 FData: TArrayI;
 i,TypeF: Integer;
 idfP: TidFunc; //Pointer;
 ifFunc: TidFunc;
 CT,Adr: Cardinal;
begin
//т.к. flGetFunctionID для внешних ф-ий:
  if FS.TypeF = T_Real  then  TypeF :=fl_Real
  else
  if FS.TypeF = T_Complex  then  TypeF := fl_Complex;

SetLength(FData,2+FS.NArg);
FData[0]:=FS.NArg;
FData[1]:=TypeF;

for i := 0 to FS.NArg - 1 do
begin
 FData[2+i]:=ATL[i];
end;

_GetFunctionID(SN,@FData[0],@idfP);           {.328}
//idFunc:=TidFunc(idfP^);
if (idfP.idName <> _NOT_FOUND) and (idfP.idArg <> _NOT_FOUND) then
begin
  Foreval.GetF(_CALL_TYPE,idfP.idName,idfP.idArg,CT);

  if CT = _Compiled then
  begin
   Foreval.GetF(_ADDR,idfP.idName,idfP.idArg,adr);
   flPerform(fl_Free,adr);
  end;

  Foreval.DeleteFunc(idfP.idName,idfP.idArg);
end;

end;



procedure flPolarDP(pz: Pointer;  pz1: Pointer);   stdcall;
asm
  push eax
  mov eax, [pz]
  fld qword ptr [eax+8]
  fld qword ptr [eax]
  fpatan
  fld qword ptr [eax+8]
  fmul st(0),st(0)
  fld qword ptr [eax]
  fmul st(0),st(0)
  faddp
  fsqrt
  mov eax, [pz1]
  fstp qword ptr [eax]
  fstp qword ptr [eax+8]
  pop eax
end;


procedure flPolarEP(pz: Pointer;  pz1: Pointer);     stdcall;
asm
  push eax
  mov eax, [pz]
  fld tbyte ptr [eax+16]
  fld tbyte ptr [eax]
  fpatan
  fld tbyte ptr [eax+16]
  fmul st(0),st(0)
  fld tbyte ptr [eax]
  fmul st(0),st(0)
  faddp
  fsqrt
  mov eax, [pz1]
  fstp tbyte ptr [eax]
  fstp tbyte ptr [eax+16]
  pop eax
end;


procedure flDecartDP(pz: Pointer;  pz1: Pointer);  stdcall;
asm
  push eax
  mov eax, [pz]
  fld qword ptr [eax+8]
  fsincos
  fmul qword ptr [eax]
  fxch
  fmul qword ptr [eax]
  fxch
  mov eax, [pz1]
  fstp qword ptr [eax]
  fstp qword ptr [eax+8]
  pop eax
end;



procedure flDecartEP(pz: Pointer;  pz1: Pointer);    stdcall;
asm
  push eax
  mov eax, [pz]
  fld tbyte ptr [eax+16]
  fsincos
  fld tbyte ptr [eax]
  fmulp
  fxch
  fld tbyte ptr [eax]
  fmulp
  fxch
  mov eax, [pz1]
  fstp tbyte ptr [eax]
  fstp tbyte ptr [eax+16]
  pop eax
end;





procedure flSetLength(AdrV: Pointer; TypeV: Cardinal; Len: Cardinal);  stdcall;
begin

if TypeV = fl_ARRAY_REAL_DOUBLE then
begin
  SetLength(PArrayD(AdrV)^,Len);
end
else
if TypeV = fl_ARRAY_REAL_EXTENDED then
begin
  SetLength(PArrayE(AdrV)^,Len);
end
else
if TypeV = fl_ARRAY_REAL_INTEGER then
begin
  SetLength(PArrayI(AdrV)^,Len);
end
else
if TypeV = fl_ARRAY_POINTER then
begin
  SetLength(PArrayI(AdrV)^,Len);
end
else
if TypeV = fl_ARRAY_REAL_SINGLE then
begin
  SetLength(PArrayS(AdrV)^,Len);
end;

end;




procedure flSetArrayValueI(AdrV: Pointer; indx: Cardinal; Val: integer);  stdcall;
begin
 PArrayI(AdrV)^[indx]:=Val;
end;


procedure flSetArrayValueD(AdrV: Pointer; indx: Cardinal; Val: double);  stdcall;
begin
 PArrayD(AdrV)^[indx]:=Val;
end;


procedure flSetArrayValueE(AdrV: Pointer; indx: Cardinal; Val: extended);  stdcall;
begin
 PArrayE(AdrV)^[indx]:=Val;
end;



procedure flSetArrayValueS(AdrV: Pointer; indx: Cardinal; Val: single);  stdcall;
begin
 PArrayS(AdrV)^[indx]:=Val;
end;


procedure flGetArrayValueI(AdrV: Pointer; indx: Cardinal; var Val: integer);  stdcall;
begin
 Val:=PArrayI(AdrV)^[indx];
end;


procedure flGetArrayValueD(AdrV: Pointer; indx: Cardinal; var Val: double);  stdcall;
begin
 Val:=PArrayD(AdrV)^[indx];
end;


procedure flGetArrayValueE(AdrV: Pointer; indx: Cardinal; var Val: extended);  stdcall;
begin
 Val:=PArrayE(AdrV)^[indx];
end;



procedure flGetArrayValueS(AdrV: Pointer; indx: Cardinal; var Val: single);  stdcall;
begin
 Val:=PArrayS(AdrV)^[indx];
end;





function PtrToStr(P: Pointer): String;
var
S: String;
S1,S2: AnsiString;
begin
 if _STRINGTYPE = fl_STRING then
 begin
  Str:=String(P);
  S:=Copy(Str,1,Length(Str));
  Str:='';
 end
 else
 if  _STRINGTYPE = fl_ANSISTRING then
 begin
   _SetStrPCh(P);
   S:=Str;
   //S:=String(PAnsiChar(P))
 end
 else
 if  _STRINGTYPE = fl_WIDESTRING then
 begin
  Sws:=WideString(p);
  Str:=String(Copy(Sws,1,Length(Sws)));
  S:=Str;
  Sws:='';
   //db
   //MessageDlg(S,mtError,[mbOk],0);
 end
 else
 if  _STRINGTYPE = fl_STRING_UTF8 then
 begin
   {$IFDEF FPC}
    Su8:=UTF8String(p);
    Str:=String(Su8);
    S:=Copy(Str,1,Length(Str));
    Su8:='';
   {$ELSE}
   //for Delphi:
    //Str:=StringOf(P);
    Str:=StringOf(TBytes(P));
    S:=Copy(Str,1,Length(Str));
    Str:='';
   {$ENDIF}

  {Su8:=UTF8String(p);
  S1u8:=Copy(Su8,1,Length(Su8));
  Sws:=Utf8Decode(S1u8);
  Str:=String(Copy(Sws,1,Length(Sws)));
  S:=Str;
  Su8:='0';
  }
  {Su8:=UTF8String(p);
  S1u8:=Copy(Su8,1,Length(Su8));
  Str:=String(S1u8);
  S:=Str;
  Su8:='0'; }
 end
 else
 if  _STRINGTYPE = fl_PANSICHAR then
 begin
  _SetStrPCh(P);
  S:=Str;
  {S1:=PAnsiChar(P);
  S2:=Copy(S1,1,Length(S2));
  S:=S2;}
  //S1:=
  //S:=String(PAnsiChar(P))
  //S:=String(P)
 end;
 {else
 if  _STRINGTYPE = fl_PWIDECHAR then S:=String(PWideChar(P));}


 PtrToStr:=Copy(S,1,Length(S));
end;




function StrToPtr(S: String): Pointer;
var
P: Pointer;
begin
 if _STRINGTYPE = fl_STRING then
 begin
   Str:=S;
   StrToPtr:=Pointer(PChar(Str))
 //StrToPtr:=Pointer(S)
 end
 else
 if _STRINGTYPE = fl_ANSISTRING then
 begin
   {Str:=S;
   _GetStrPCh(P);
   StrToPtr:=Pointer(P); }
   SAns:=AnsiString(Copy(S,1,Length(S)));
   StrToPtr:=Pointer(PAnsiChar(Sans))
 end
 else
 if  _STRINGTYPE = fl_WIDESTRING then
 begin
   Sws:=WideString(Copy(S,1,Length(S)));
   StrToPtr:=PWideString(Sws);
 end
 else
 if  _STRINGTYPE = fl_STRING_UTF8 then
 begin
   Su8:=UTF8String(Copy(S,1,Length(S)));
   StrToPtr:=PUTF8String(Su8);
   {Sws:=WideString(Copy(S,1,Length(S)));
   StrToPtr:=Pointer(Utf8Encode(Sws));
   }
 end
 else
 if  _STRINGTYPE = fl_PANSICHAR then
 begin
  //StrToPtr:=(PAnsiChar(S));
   SAns:=AnsiString(Copy(S,1,Length(S)));
   StrToPtr:=Pointer(PAnsiChar(Sans))
 end;
end;


procedure DeleteSpace(S: String; var S1: String);
label 1,2,endp;
var i,p: Integer;
begin
if Length(S) > 0 then
begin
 {.217}
//S:=StringReplace(S,' ','',[rfReplaceAll, rfIgnoreCase]);
S:=StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);    //Tab

i:=Length(S);

 while i >= 1 do
 begin
    if S[i] = ' ' then
   begin
    Delete(S,i,1);
   end;
  dec(i);
 end;

 {.333}
 if S = '' then
 begin
   S1:='';
   goto endp;
 end;

1:
if S[Length(S)] = ';' then begin Delete(S,Length(S),1); goto 1; end;

2:
p:=pos(';;',S);
if p > 0 then  begin Delete(S,p,1); goto 2; end;

if S[1] = ';' then Delete(S,1,1);

end;

S1:=Copy(S,1,Length(S));

endp:
end;



procedure DeleteSpaceP(PS: PString);
label 1,2;
var i,p: Integer;
begin

if Length(PS^) > 0 then
begin

  PS^:=StringReplace(PS^,#9,'',[rfReplaceAll, rfIgnoreCase]);
  PS^:=StringReplace(PS^,' ','',[rfReplaceAll, rfIgnoreCase]);
  PS^:=StringReplace(PS^,';;',';',[rfReplaceAll, rfIgnoreCase]);
  if Length(PS^) > 0 then
  begin
    if PS^[Length(PS^)] = ';' then Delete(PS^,Length(PS^),1);
    if Length(PS^) > 0 then
    begin
      if PS^[1] = ';' then Delete(PS^,1,1);
    end;
  end;
{
i:=Length(PS^);

 while i >= 1 do
 begin
    if PS^[i] = ' ' then
   begin
    Delete(PS^,i,1);
   end;
  dec(i);
 end;


1:
if PS^[Length(PS^)] = ';' then begin Delete(PS^,Length(PS^),1); goto 1; end;

2:
p:=pos(';;',PS^);
if p > 0 then  begin Delete(PS^,p,1); goto 2; end;

if PS^[1] = ';' then Delete(PS^,1,1);

end;
 }
end;

end;





procedure FreeFunction(Func: Cardinal);
label endp;
var
i,j: Integer;
AddrMainDiffExpr:Pointer;
begin
if Func <> 0 then
begin

For i:=0 to High(CompZ) do
 begin

  if Func = CompZ[i].Func.Addr then
  begin
   Foreval.FreeExtFunc(@CompZ[i].Func);   {.225}
   CompZ[i].Func.Addr:=0;

   {.379} //поиск и освобождение памяти для главного выражения численного дифф-я
          //используется при принудительном освобождении fl_Free (небязательно)
          //при закрытие .dll память для всех выражений освобождается в FreeCmplFuncList
   if (F_FreeMainDiffExpr = True) and (CompZ[i].DiffNumericExpr = fl_Yes) then
   begin
      AddrMainDiffExpr:=CompZ[i].AddrMainDiffExpr;

      if AddrMainDiffExpr <> nil then
      begin
         For j:=0 to High(CompZ) do
         begin
            if Cardinal(AddrMainDiffExpr) = CompZ[j].Func.Addr then
            begin
              Foreval.FreeExtFunc(@CompZ[j].Func);
              CompZ[j].Func.Addr:=0;
              CompZ[i].AddrMainDiffExpr:=nil;
              CompZ[i].DiffNumericExpr := fl_No;
              goto endp;
            end;
         end;
      end;

   end;


    goto endp;
  end;

 end;

end;

endp:
end;


procedure FreeCmplFuncList;
var
i: Integer;
begin
For i:=1 to Length(CompZ)-1 do
 begin
  if CompZ[i].Func.Addr <> 0 then
  Foreval.FreeExtFunc(@CompZ[i].Func);   {.225}
 end;
end;


procedure SetReg(Reg,Mode: Integer);
var
R,C: Integer;
begin
//R:=Reg-_EAX+1;
C:=Mode-_CLEAR;
Foreval.SetRegA(Reg,C);
end;



procedure  pcGetFuncVarName(S: String; var FN: String; var VNS: TArraySt);
var                                        //S=Func(x1,x2,...,xn)
  i,N,P,L: Integer;
begin
 VNS:=nil;
 N:=pos('(',S);
 if N <> 0  then
 begin
  FN:=Copy(S,1,N-1);   P:=N+1; L:=Length(S);
  for i := N+1 to L - 1 do
  begin
   if S[i] = ',' then begin  SetLength(VNS,Length(VNS)+1); VNS[High(VNS)]:=Copy(S,P,i-P); P:=i+1; end;
  end;
  SetLength(VNS,Length(VNS)+1); VNS[High(VNS)]:=Copy(S,P,L-P);
  if VNS[High(VNS)] = '' then   SetLength(VNS,0);  {.203} {.xxx}    //fnc():real=1.123
 end
 else
 begin
   Lib_ErrorCode:=E_WRONG_TYPE;
 end;

end;


// ChangeToSet   (AAA)
procedure pcFindVar(S: String; NV: String; P: Integer;  var Bl: Boolean; var NNV: String);
var
i,LV,LS: Integer;
begin
LV:=Length(NV);
LS:=Length(S);
Bl:=False;
if (P = 1) and (LV = LS) then Bl:=True
else
if P = 1 then
begin
 (*
    if (S[P+LV] = '+') or (S[P+LV] = '-') or (S[P+LV] = '/') or
    (S[P+LV] = '*') or (S[P+LV] = '^') or (S[P+LV] = '!') or (S[P+LV] = '[') or
    (S[P+LV] = ';') or (S[P+LV] = '.') or (S[P+LV] = '=')
    *)
    if S[P+LV] in    AfterFirstVarEnableSymb = True  {.383}
    then
    begin
      Bl:=True;
    end;
end
else
if P = LS-LV+1  then
begin
   (*
   if (S[P-1] = '+') or  (S[P-1] = '-') or (S[P-1] = '*')  or
     (S[P-1] = '/') or  (S[P-1] = '^') or (S[P-1] = ';')
   *)
   if S[P-1] in BeforeLastVarEnableSymb = True  {.383}
   then
   begin
     Bl:=True;
   end;
end
else
   (*
   if ((S[P-1] = '(')  or  (S[P-1] = '{') or (S[P-1] = '[')  or
    (S[P-1] = '+')  or  (S[P-1] = '-') or (S[P-1] = '*')  or
    (S[P-1] = '/')  or  (S[P-1] = '^') or (S[P-1] = '|')  or
    (S[P-1] = ',')  or  (S[P-1] = '=') or (S[P-1] = '<')  or (S[P-1] = '>') or (S[P-1] = ';'))
    and
   ((S[P+LV] = '+') or (S[P+LV] = '-') or (S[P+LV] = '/') or
    (S[P+LV] = '*') or (S[P+LV] = '^') or (S[P+LV] = '!') or
    (S[P+LV] = ')') or (S[P+LV] = ']') or (S[P+LV] = '}') or
    (S[P+LV] = '|') or (S[P+LV] = '[') or (S[P+LV] = ',') or
    (S[P+LV] = '=') or (S[P+LV] = '<') or (S[P+LV] = '>') or
    (S[P+LV] = ';') or (S[P+LV] = '.'))
   *)
   if (S[P-1] in  BeforeMiddleVarEnableSymb = True) and (S[P+LV] in AfterMiddleVarEnableSymb = True)    {.383}
   then
   begin
     Bl:=True;
   end;


if Bl = True then begin {NNV:=NV+'#'+IntToStr(F_CurrentIntFunc);} NNV:=NV; end;       {###}
//F_CurrentIntFunc - число ф-ий типа fl_PreCompiled

end;


function pcPosN(S: String; FS: String; P: Integer): Integer;
label 1, endp;
var
 N,i,j,L,LFS: Integer;
begin
L:=Length(S);
LFS:=Length(FS);
pcPosN:=0;
for i := P to L-LFS+1 do     {.197}
begin
    for j := 1 to LFS do
    begin
    {
      if Foreval.VarShift = False then
      begin
       if LowerCase(S[i+j-1]) <> LowerCase(FS[j]) then  goto 1
      end
      else
       if (S[i+j]) <> (FS[j]) then  goto 1;
       }
       if S[i+j-1] <> FS[j] then  goto 1;     {.221}
    end;
    pcPosN:=i; goto endp;
1:
end;

endp:
end;


procedure pcSetIntVar(VNS: TArraySt; ATL: TArrayI);
label endp;
var
FD1,FD2: PInternalVar;
LS,LL,i,IDN: Integer;
SN,SV,num: String;
Bl: Boolean;
begin
//Установка заголовочных переменных в ф-ях Precompiled

LS:=Length(VNS); LL:=Length(ATL);
//LS=LL!!!
SetLength(CVA,LS);
SetLength(CurrentNameSet,0);
for i := 0 to LS-1 do
begin
  if IsCurrentSet(VNS[i]) = False then      {.221}
  begin

    IDN := _NOT_FOUND;         {.378}
    if Foreval.CheckUsedName then Foreval.FindFuncA(VNS[i],IDN);     {.378}
    if IDN = _NOT_FOUND then
    begin

       new(FD1); FD1^.Next:=nil;

       {FD1^.Name:=Copy(LowerCase(VNS[i]),1,Length(VNS[i]))+'#'+IntToStr(F_CurrentIntFunc);}
       FD1^.Name:=Copy(VNS[i],1,Length(VNS[i]));
       PushParam(FD1^.Name);
       PushVar(FD1^.Name);
       _SetVar(FD1^.Name,@FD1^.Variable,ATL[i],ds_FunctionHeader{_Internal});
       CVA[i]:=TAddress(@FD1^.Variable);
       InternalVarList^.Next:=FD1;
       InternalVarList:=FD1;
    end
    else         {.377D}
    begin
       Foreval.SyntaxError:=E_NAME_ALREADY_USED;
       Lib_ErrorString:=VNS[i];
       Lib_ErrorCode:=Foreval.SyntaxError;
       PopParam;
       PopVar;              {.229}
       goto endp;
    end;

  end
  else
  begin
    Foreval.SyntaxError:=E_VARIABLE_REDECLARED;
    Lib_ErrorCode:=Foreval.SyntaxError;
    PopParam;
    PopVar;                   {.229}
    goto endp;
  end;

  WriteCurrentSet(VNS[i]);
end;

endp:
end;



procedure pcFreeIntVar;
var
FD1,FD2: PInternalVar;
begin

FD1:=BInternalVarList;
while FD1 <> nil do
begin
 FD2:=FD1^.Next;
 {SetLength(FD1^.VecD,0);
 SetLength(FD1^.VecE,0);
 SetLength(FD1^.VecI,0); }
 FD1^.VecD:=nil;
 FD1^.VecE:=nil;
 FD1^.VecI:=nil;
 FD1^.Name:='';
 dispose(FD1);
 FD1:=FD2;
end;

end;



procedure pcSetFunc(VNS: TArraySt; S: String; var SF: String);
label 1;
var
 P,i,L,BP: Integer;
 NNV,S1: String;
 Bl: Boolean;
 SN: String;
begin

 pcSetIntVar(VNS,ATL);

 L:=Length(VNS);

 for i:=0 to L-1  do
 begin
  P:=1; BP:=1;
1:
  P:=pcPosN(S,VNS[i],BP);  // G_int1:=i; для замены переменных: тип
  if P <> 0 then
  begin
    pcFindVar(S,VNS[i],P,Bl,NNV);
    if Bl = True then
    begin
      Delete(S,P,Length(VNS[i]));
      Insert(NNV,S,P);
      BP:=P+Length(NNV);
    end
    else
    BP:=BP+1;
    goto 1;
  end;

 end;

 SF:=Copy(S,1,Length(S));
end;




function  _ResultR(Func: Cardinal): extended;
asm
   call Func
end;



procedure _ResultC(Func: cardinal; var Res: TComplexE);
var
p:TComplexE;
begin
 asm
   call Func
   push eax
   mov  eax, [res]
   fstp tbyte ptr [eax]
   fstp tbyte ptr [eax+16]
   pop  eax
  end;
end;




procedure _SetVar(Name: String; Addr: Pointer; TV: Cardinal; TypeCnt: Cardinal);
var
TypeV,MType: Integer;
begin
 TypeV:=0;    MType:=0;

 case TV of
  fl_Real_Single:            begin TypeV:=T_Real;    MType:=_Single; end;
  fl_Real_Double:            begin TypeV:=T_Real;    MType:=_Double; end;
  fl_Real_Extended:          begin TypeV:=T_Real;    MType:=_Extended; end;
  fl_Real_Integer:           begin TypeV:=T_Real;    MType:=_Integer; end;

  fl_Complex_Single:         begin TypeV:=T_Complex;  MType:=_Single; end;
  fl_Complex_Double:         begin TypeV:=T_Complex; MType:=_Double; end;
  fl_Complex_Extended:       begin TypeV:=T_Complex; MType:=_Extended; end;

  fl_Array_Real_Double:      begin TypeV:=T_Array;   MType:=_Double; end;
  fl_Array_Real_Extended:    begin TypeV:=T_Array;   MType:=_Extended; end;
  fl_Array_Real_Integer:     begin TypeV:=T_Array;   MType:=_Integer; end;
  fl_Array_Pointer:          begin TypeV:=T_Array;   MType:=_Pointer; end;
  fl_Array_Real_Single:      begin TypeV:=T_Array;   MType:=_Single; end;

  fl_Pointer:                begin TypeV:=T_Pointer; MType:=_Pointer; end;
 end;

  {.377B}
 if (TypeV <> 0) and  (MType <> 0) then Foreval.SetObject(Name,Cardinal(Addr),TypeV,MType,TypeCnt)
 else
 begin
    Lib_ErrorCode:=E_WRONG_PASSED_DATA;
    Lib_ErrorString:=Name;
 end;

end;



procedure _SetVar2(Name: String; AddrRE, AddrIM: Pointer; TV: Cardinal; SrcDef: Cardinal);
var
TypeV,MType: Integer;
begin

 case TV of
  fl_Real_Single:            begin TypeV:=T_Real;    MType:=_Single; end;
  fl_Real_Double:            begin TypeV:=T_Real;    MType:=_Double; end;
  fl_Real_Extended:          begin TypeV:=T_Real;    MType:=_Extended; end;
  fl_Real_Integer:           begin TypeV:=T_Real;    MType:=_Integer; end;

  fl_Complex_Single:         begin TypeV:=T_Complex;  MType:=_Single; end;
  fl_Complex_Double:         begin TypeV:=T_Complex; MType:=_Double; end;
  fl_Complex_Extended:       begin TypeV:=T_Complex; MType:=_Extended; end;

  fl_Array_Real_Double:      begin TypeV:=T_Array;   MType:=_Double; end;
  fl_Array_Real_Extended:    begin TypeV:=T_Array;   MType:=_Extended; end;
  fl_Array_Real_Integer:     begin TypeV:=T_Array;   MType:=_Integer; end;
  fl_Array_Pointer:          begin TypeV:=T_Array;   MType:=_Pointer; end;
  fl_Array_Real_Single:      begin TypeV:=T_Array;   MType:=_Single; end;

  fl_Pointer:                begin TypeV:=T_Pointer; MType:=_Pointer; end;
 end;

 Foreval.SetObject2(Name,Cardinal(AddrRE),Cardinal(AddrIM),TypeV,MType,SrcDef)
end;




procedure _SetParam(Name: String; Re,Im: Extended; TV: Cardinal);
var
TypeV,MType: Integer;
begin
 case TV of
  fl_Real:                   TypeV:=T_Real;
  fl_Complex:                TypeV:=T_Complex;
 end;
 Foreval.SetParam(Name,Re,Im,TypeV);
end;




procedure _SyntaxExtComReplaceIfName(S1: String; var S2: String);
label 1,2,endp;
//const EnName = ['(','{','[','|','*','/','>','<','=','+','^','-',',',';'];
var
p,cp,cle: integer;
SL: String;                            //x+iff(
Bxh: Boolean;                          //x+piff(
begin
cp:=1;
1:
{SL:=LowerCase(S1);} SL:=S1;

  

//iff
p:=posEx('iff(',SL,cp);

if p <> 0 then
begin
 Bxh:=False;
 if (p > 1) then
 begin
   if S1[p-1] in  {EnName} BeforeFuncEnableSymb = true then Bxh:=True   //{.346}
 end
 else Bxh:=True;

 if Bxh = True then Delete(S1,p+1,1); cp:=cp+2;
 goto 1;
end;



//ifp
cp:=1;
2:
{SL:=LowerCase(S1);} SL:=S1;

p:=posEx('ifp(',SL,cp);

if p <> 0 then
begin
 Bxh:=False;
 if (p > 1) then
 begin
   if S1[p-1] in  {EnName} BeforeProcEnableSymb = true then Bxh:=True   //{.346}
      else
   if S1[p-1] in           BeforeProcDisableSymb = true then      //{.346}
   begin
      Lib_ErrorCode:=E_NO_RETURN_NUMBER;
      //cle:=10; //условно
      cle:=Length(SL)-(p-1);
      if cle > 10  then cle:=10;
      Lib_ErrorString:=copy(SL,p-1,cle);
      goto endp;
   end
   else
   //Bxh:=True;
   Bxh:=False; {.385}

 end
 else Bxh:=True;

 if Bxh = True then  Delete(S1,p+2,1); cp:=cp+2;
 goto 2;
end;


endp:
S2:=S1;
end;


{.191}
function FindControlVarPS(PSA: PString; PSF: PString; VT: Cardinal; MT: Cardinal; var vpos: Cardinal; var ReIm: Integer): Boolean;
label nxtsrchi,nxtsrchp,nxtsrchf,nxtsrchc, nxtsrchai,endp;
var
 ST1,ST2,SNT,S2,SNV: String;
 ResF: Boolean;
 P: Cardinal;
 i,rp,ip,TF,pf,b1: Integer;
begin
{
 Опережающий поиск заданных переменных , используемых в командах for,fordown,case,...
 Т.к. синтаксический препоцессор при преобразовании этих команд (в CheckSyntaxErrorPS) не учитывает ранее заданные переменные (в теле программы)
}
ResF:=False;
P:=0;
vpos:=0;
ReIm:=0;





if (VT = T_Real) and (MT = _Integer) then
  begin

    for i := 0 to Length(SNInt)-1 do
    begin
      SNT:=PSA^+':'+SNInt[i];  // => VarName:VarType;
      //P:=Pos(S1,SF1);

      pf:=1;              {.211}
      nxtsrchi:
      P:=PosEx(SNT,PSF^,pf);

      if P = 1 then
      begin
        ResF:=True;
        goto endp;
      end
      else
      if P > 1 then
      begin
        if PSF^[P-1] = ';' then
        begin
           ResF:=True;
           goto endp;
        end
        else        {.211}  // max:int=0; x:int=0; for(x,...)
        begin
          pf:=pf+Length(SNT);
          if pf >= Length(PSF^) then goto endp
           else goto nxtsrchi;
        end;
      end;
    end;

  end;




if (VT = T_Pointer) and (MT = _Pointer) then
  begin

    for i := 0 to Length(SNPtr)-1 do
    begin
      SNT:=PSA^+':'+SNPtr[i];
      //P:=Pos(S1,SF1);

      pf:=1;
      nxtsrchp:
      P:=PosEx(SNT,PSF^,pf);

      if P = 1 then
      begin
        ResF:=True;
        goto endp;
      end
      else
      if P > 1 then
      begin
        if PSF^[P-1] = ';' then
        begin
           ResF:=True;
           goto endp;
        end
        else
        begin
          pf:=pf+Length(SNT);
          if pf >= Length(PSF^) then goto endp
           else goto nxtsrchp;
        end;
      end;
    end;

  end;


if (VT = T_Real) and ((MT = _Double) or (MT = _Extended) or (MT = _Single))  then
  begin

    for i := 0 to Length(SNReal)-1 do
    begin
      SNT:=PSA^+':'+SNReal[i];
      //P:=Pos(S1,SF1);
      pf:=1;              {.211}
      nxtsrchf:
      P:=PosEx(SNT,PSF^,pf);

      if P = 1 then
      begin
        ResF:=True;
        goto endp;
      end
      else
      if P > 1 then
      begin
        if PSF^[P-1] = ';' then
        begin
           ResF:=True;
           goto endp;
        end
        else        {.211}  // max:ext=0; x:ext=0; for(x,...)
        begin
          pf:=pf+Length(SNT);
          if pf >= Length(PSF^) then goto endp
           else goto nxtsrchf;
        end;
      end;
    end;

  end;



if (VT = T_Complex)  then
  begin
     _FindReIm(PSA^,PSA^,TF);
     if TF = 0  then goto endp;

     {
     rp:=pos('.re',LowerCase(SA1));
     if (rp <> 0) and (rp = Length(SA1)-2) then
     begin
        //SA1:=Copy(SA1,1,Length(SA1)-3);
        Delete(SA1,Length(SA1)-2,3);
     end
     else
     begin
        ip:=pos('.im',LowerCase(SA1));
        if (ip <> 0) and (ip = Length(SA1)-2) then
        begin
          //SA1:=Copy(SA1,1,Length(SA1)-3);
          Delete(SA1,Length(SA1)-2,3);
        end
        else
        begin
          goto endp;
        end;
      end;

     }

    ReIm:=TF;

    for i := 0 to Length(SNCmplx)-1 do
    begin
      SNT:=PSA^+':'+SNCmplx[i];
      //P:=Pos(S1,SF1);

      pf:=1;              {.211}
      nxtsrchc:
      P:=PosEx(SNT,PSF^,pf);

      if P = 1 then
      begin
        ResF:=True;
        goto endp;
      end
      else
      if P > 1 then
      begin
        if PSF^[P-1] = ';' then
        begin
           ResF:=True;
           goto endp;
        end
        else        {.211}  // max:extcx=0; x:extcx=0; ...
        begin
          pf:=pf+Length(SNT);
          if pf >= Length(PSF^) then goto endp
           else goto nxtsrchc;
        end;
      end;
    end;

  end;


  if (VT = T_Array) and (MT = _Integer)  then
  begin



     b1:=Pos('[',PSA^);
     if (b1 = 0) or (b1 = 1) then  goto endp;

     if PSA^[Length(PSA^)] <> ']' then   goto endp
     else   SNV:=Copy(PSA^,1,b1-1);

    

    for i := 0 to Length(SNArrayInt)-1 do
    begin
      SNT:=SNV+':'+SNInt[i];  // => VarName:VarType;


      pf:=1;
      nxtsrchai:
      P:=PosEx(SNT,PSF^,pf);

      if P = 1 then
      begin
        ResF:=True;
        goto endp;
      end
      else
      if P > 1 then
      begin
        if PSF^[P-1] = ';' then
        begin
           ResF:=True;
           goto endp;
        end
        else
        begin
          pf:=pf+Length(SNT);
          if pf >= Length(PSF^) then goto endp
           else goto nxtsrchai;
        end;
      end;
    end;

  end;


endp:

vpos:=P;

FindControlVarPS:=ResF;
end;



function _SyntaxExtComSepPS(PSM: PString; ps,lens,typef: integer): boolean;
var
str: String[1];             //typef=0: if
begin                       //typef=1: for,fordown,while
_SyntaxExtComSepPS:=True;

//if typef = 0 then
begin

 if ps+lens < Length(PSM^) then
 begin
  str:=PSM^[ps+lens+1];
  if (str <> ';') and (str <> ')') and (str <> ',') then
  begin
    _SyntaxExtComSepPS:=false;
  end;
 end;

end
(*else
begin
 //after : for();  for(),  for())
 if ps+lens < Length(SM) then
 begin
  str:=SM[ps+lens+1];
  if (str <> ';') and (str <> ')') and (str <> ',') then
  begin
    _SyntaxExtComSep:=false;
  end;
 end;
 //before:  ;for()   ,for()
 if ps > 1 then
 begin
  str:=SM[ps-1];
  if (str <> ';') and (str <> ',') then
  begin
    _SyntaxExtComSep:=false;
  end;
 end;

end;
*)
end;


 // ChangeToSet    (AAA)
 {SYNT_ERR}
function _CheckOperatorPlacementPS(PSF: PString; bpos,epos: integer): boolean;
label endp;
//const EnName = ['(','{','[','|','*','/','>','<','=','+','^','-',',',';'];
var
BH: boolean;
Len: integer;
p: integer;
Bch: Boolean;
s1,s2: string;
begin                  //if(x<y, if(x>t,x=x+1), if(x>=y,x=x-1)); x
                       //-for(i,1,10,if({i/3}=0,x=x+1)); x
BH:=False;
Len:=Length(PSF^);

if (bpos-1 >= 1) and (epos+1 <= Len)  then
begin
s1:=PSF^[bpos-1]; s2:=PSF^[epos+1];
  if ((PSF^[bpos-1] = ',') and (PSF^[epos+1] = ',')) or
     ((PSF^[bpos-1] = ',') and (PSF^[epos+1] = ';')) or
     ((PSF^[bpos-1] = ';') and (PSF^[epos+1] = ';')) or
     ((PSF^[bpos-1] = ';') and (PSF^[epos+1] = ',')) or   {.395}  // ifp(n=1, x=0; for(k=0,high(vs),x=x+vs[k]), ifp(n=2,x=2)); x
     ((PSF^[bpos-1] = ';') and (PSF^[epos+1] = ')')) or
     ((PSF^[bpos-1] = ',') and (PSF^[epos+1] = ')')) or
     ((PSF^[bpos-2] = '>') and (PSF^[bpos-1] = '>') and (PSF^[epos+1] = ')')) or   // S_LABEL !!!
     ((PSF^[bpos-2] = '>') and (PSF^[bpos-1] = '>') and (PSF^[epos+1] = ';'))      // S_LABEL !!!
     then
     BH:=True;
end
else
if (bpos-1 < 2) and (epos+1 <= Len)  then
begin
  if  (PSF^[epos+1] = ';') then BH:=True;
end
else
if (bpos-1 >= 2) and (epos+1 > Len)  then
begin
  if
     (PSF^[bpos-1] = ';')  or
     ((PSF^[bpos-2] = '>') and (PSF^[bpos-1] = '>'))       // S_LABEL !!!
     then
     BH:=True;
end
else
if (bpos = 1) and (epos = Len) then   {.195}
 BH:=True;



(*
// комманда не должна находится во вложенных if, iff, ifp (должны быть раскрыты перед этим  - иначе ошибка )
//if(x<y, if(x>t,x=x+1), if(x>=y,x=x-1)); x
if BH = True then
begin
  //'if('  'iff(' 'ifp('
  Bch:=False;
  p:=pos('if',LowerCase(SF));
  if p <> 0 then
  begin
    if (p > 1) then
    begin
        if SF[p-1] in  EnName = true then Bch:=True
    end
    else Bch:=True;

    if (Bch = True) and (p < bpos) then
    begin
       BH:=False;   goto endp;
    end;

  end;

  p:=pos(LowerCase(SF),'iff(');
  if p <> 0 then
  begin

  end;

  p:=pos(LowerCase(SF),'ifp(');
  if p <> 0 then
  begin

  end;

end;
*)

endp:
_CheckOperatorPlacementPS:=BH;
end;



// x=y+x; for(k=1,10,x=x+1)+y; x+y
//  x=y+x; ifp((x<y)and(y<x),x+1,y+1)+y;
function _CheckSyntaxExtComPS(PSM: PString; pf,lens,typef: integer): boolean;
var
BH: boolean;
cl,cl1,cl2, pspr,lns: Integer;
StrPE: String;
StrSE: String[1];
begin
BH:=True;

{.385}
 if _SyntaxExtComSepPS(PSM,pf,lens,typef) = False then
       begin
          lns:=lens;
          if lens+3 >= Length(PSM^)  then lens:=Length(PSM^)-3;
          if pf > 1 then pf:=pf-1;

         { if typef = 1  then
          begin }


            cl:=10;  // условно
            cl1:=cl; cl2:=cl;
            pspr:=pf+lns;
            if pspr - cl < 1 then cl1:=1;
            if pspr + cl > Length(PSM^) then cl2:= Length(PSM^)-pspr;

            pspr:=pf+lns+1;
            StrSE:=PSM^[pspr+1];
            if PSM^[pspr+1] in AfterProcDisableSymb = True then
            Lib_ErrorCode:=E_WRONG_PLACEMENT_OPERATOR
            else
            Lib_ErrorCode:=E_MISSING_SEPARATOR;


            StrPE:=copy(PSM^,pspr-cl1,cl1+cl2);

            Lib_ErrorString:='"'+StrPE+'"'+ #13#10+' in: '+#13#10+ '"'+copy(PSM^,pf,lens+3)+'"';


         { end
          else
          begin
            Lib_ErrorCode:=E_MISSING_SEPARATOR;
            Lib_ErrorString:=copy(PSM^,pf,lens+3);
          end;  }



          BH:=False;
       end
 else
 if _CheckOperatorPlacementPS(PSM,pf,lens+pf) = False then
  begin
     Lib_ErrorCode:=E_WRONG_EXPRESSION;
     if pf-1 = 0 then pf:=1;
     if lens+2 >= Length(PSM^)  then lens:=Length(PSM^)-2;
     Lib_ErrorString:=copy(PSM^,pf-1,lens+2);
     BH:=False;
  end;

  _CheckSyntaxExtComPS:=BH;
end;






procedure _SyntaxExtCom_CorrectLabPS(PS1: PString);
label nxt;
var
i,p: integer;
begin

nxt:
 //p:=pos('>>;',S1);  {LAB}
 p:=pos(S_LABEL+';',PS1^);

 if p <> 0 then
 begin
   delete(PS1^,p+Len_SLABEL,1);
   goto nxt;
 end;

end;


{.191}
procedure _SyntaxExtCom_FindArgPS(PSM: PString; SF: String; FPType: Integer; cp: integer; var NArg,lensf,pf: Integer; var S1,S2,S3,S4,S5: String);
label endf,endp, endf2;
//const EnName = ['>',',',';'];
//const EnName = ['>',',',';','+'];
                                   //x+iff(x<y,x=x+1;y=y+1;x+y)+y
//const BeforeProcEnableSymb = [',',';','>','(','{','['];                                        //{.346}
//const BeforeFuncEnableSymb = [',',';','>','(','{','[','|','+','-','*','/','^','=','<',];       //{.346}

var
SF1: String;
i,n,p,cna,ls,br,lf,lens: integer;
arp: array of integer;
FA1: Boolean;
begin
{
SF=if, for, ,fordown, while
}


FA1:=False;
SF1:=SF+'(';
ls:=Length(PSM^);
lf:=Length(SF);
NArg:=0;
SetLength(arp,0);

lens:=ls; {.395} // init for Warning

{SMlc:=LowerCase(SM); }
p:=posEx(SF1,PSM^,cp);

if p <> 0 then
begin

   if p > 1 then
   begin
     if (FPType = _proc) and (PSM^[p-1] in  BeforeProcDisableSymb  = true)  then       //{.346}
     begin
       Lib_ErrorCode:=E_NO_RETURN_NUMBER;
       //goto endp;
         {NArg:=0;
         goto endp; }

     end
     else         //{.346}
     if (FPType = _proc) and (PSM^[p-1] in  BeforeProcEnableSymb  = false) then   //then other functions with name ***for,***while,...:   isfor() ,bewhile(), ...
     begin
        NArg:=0;
        goto endp;
     end;

   end;


   br:=0;
   for i := p+lf+1 to ls do
   begin
   (*
    if (SM[i] = '(') or (SM[i] = '{') or (SM[i] = '[') {or (SM[i] = '|')} then dec(br) else
    if (SM[i] = ')') or (SM[i] = '}') or (SM[i] = ']') {or (SM[i] = '|')} then inc(br);
    *)
    if PSM^[i] in OpenBracket then  dec(br)
    else
    if PSM^[i] in CloseBracket then inc(br);

    if (br = 1) then
    begin
      FA1:=True; lens:=i; goto endf;               {.195}
    end;

    if (br = 0) and (PSM^[i] = ',') then
    begin
      SetLength(arp,Length(arp)+1);
      arp[High(arp)]:=i;
      inc(NArg);
    end;

   end;

end;

endf:

if Lib_ErrorCode = E_NO_RETURN_NUMBER then
begin
 Lib_ErrorString:=copy(PSM^,p-1,lens-p+2);
 NArg:=0;
 goto endp;
end;


if NArg > 0  then
begin
 inc(NArg);
 SetLength(arp,Length(arp)+1);
 arp[High(arp)]:=lens;
end
else
if (NArg = 0) and (FA1 = True) then   {.195}   //while(n>0)
begin
   NArg:=1;
   S1:=Copy(PSM^,p+lf+1,lens-(p+lf+1));
   goto endf2;
end;



case NArg of
1: S1:=Copy(PSM^,p+lf,arp[0]-(p+lf)) ;
2: begin S1:=Copy(PSM^,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(PSM^,arp[0]+1,arp[1]-arp[0]-1);  end;
3: begin S1:=Copy(PSM^,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(PSM^,arp[0]+1,arp[1]-arp[0]-1); S3:= Copy(PSM^,arp[1]+1,arp[2]-arp[1]-1);   end;
4: begin S1:=Copy(PSM^,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(PSM^,arp[0]+1,arp[1]-arp[0]-1); S3:= Copy(PSM^,arp[1]+1,arp[2]-arp[1]-1); S4:=Copy(PSM^,arp[2]+1,arp[3]-arp[2]-1);   end;
5: begin S1:=Copy(PSM^,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(PSM^,arp[0]+1,arp[1]-arp[0]-1); S3:= Copy(PSM^,arp[1]+1,arp[2]-arp[1]-1); S4:=Copy(PSM^,arp[2]+1,arp[3]-arp[2]-1); S5:=Copy(PSM^,arp[3]+1,arp[4]-arp[3]-1);   end;
end;


endf2:
lensf:=lens-p;
pf:=p;

endp:
end;




procedure _SyntaxExtCom_FindArgArrPS(PSM: PString; SF: String; FPType: Integer; cp: integer; var NArg,lensf,pf: Integer; var ArgArr: TArrayStr);
label endf,endp, endf2;
//const EnName = ['>',',',';'];
//const EnName = ['>',',',';','+'];

//const BeforeProcEnableSymb = [',',';','>','(','{','['];                                        //{.346}
//const BeforeFuncEnableSymb = [',',';','>','(','{','[','|','+','-','*','/','^','=','<',];       //{.346}

var
SF1,Sa,S1: String;
i,n,p,cna,ls,br,lf,lens: integer;
arp: TArrayI;
FA1: Boolean;
j,br1,br2: Integer;
begin
{
SF = multiiff, multiifp, casep,
}


FA1:=False;
SF1:=SF+'(';
ls:=Length(PSM^);
lf:=Length(SF);
NArg:=0;
SetLength(ArgArr,0);
SetLength(arp,0);

lens:=ls; {.395} // init for Warning

{SMlc:=LowerCase(SM); }
p:=posEx(SF1,PSM^,cp);

if p <> 0 then
begin

   if p > 1 then
   begin
     if (FPType = _proc) and (PSM^[p-1] in  BeforeProcDisableSymb  = true)  then       //{.346}
     begin
       Lib_ErrorCode:=E_NO_RETURN_NUMBER;
       //goto endp;
         {NArg:=0;
         goto endp; }

     end
     else         //{.346}
     if (FPType = _proc) and (PSM^[p-1] in  BeforeProcEnableSymb  = false) then   //then other functions with name ***for,***while,...:   isfor() ,bewhile(), ...
     begin
        NArg:=0;
        goto endp;
     end;

   end;


   br:=0;
   for i := p+lf+1 to ls do
   begin
   (*
    if (SM[i] = '(') or (SM[i] = '{') or (SM[i] = '[') then dec(br) else
    if (SM[i] = ')') or (SM[i] = '}') or (SM[i] = ']') then inc(br);
    *)

    if PSM^[i] in OpenBracket then  dec(br)
    else
    if PSM^[i] in CloseBracket then inc(br);

    if (br = 1) then
    begin
      FA1:=True; lens:=i; goto endf;               {.195}
    end;

    if (br = 0) and (PSM^[i] = ',') then
    begin
      SetLength(arp,Length(arp)+1);
      arp[High(arp)]:=i;
      inc(NArg);
    end;

   end;

end;

endf:

if Lib_ErrorCode = E_NO_RETURN_NUMBER then
begin
 Lib_ErrorString:=copy(PSM^,p-1,lens-p+2);
 NArg:=0;
 goto endp;
end;


if NArg > 0  then
begin
 inc(NArg);
 SetLength(arp,Length(arp)+1);
 arp[High(arp)]:=lens;
end
else
if (NArg = 0) and (FA1 = True) then
begin
   NArg:=1;
   S1:=Copy(PSM^,p+lf+1,lens-(p+lf+1));
   SetLength(ArgArr,1);
   ArgArr[0]:=S1;
   //goto endf2;
end;

//multiiff(x=1,sin(x),x=2,cos(x),x=3,tan(x))
if Length(arp) > 0 then
begin
  SetLength(ArgArr,Length(arp));
  ArgArr[0]:=Copy(PSM^,p+lf+1,arp[0]-(p+lf+1));
  for i := 1 to High(arp) do
  begin
   ArgArr[i]:=Copy(PSM^,arp[i-1]+1,arp[i]-arp[i-1]-1);
   //Copy(SM,arp[3]+1,arp[4]-arp[3]-1);
   //Copy(SM,arp[0]+1,arp[1]-arp[0]-1);
  end;
end;

 for i := 0 to High(ArgArr) do
 begin
   if ArgArr[i] = '' then
   begin
        Lib_ErrorCode:=E_MISSING_EXPRESSION;
        Lib_ErrorString:='  in:  '+#13#10+copy(PSM^,p,lens);
        goto endp;
   end;
 end;


if FPType = _func then
begin
  //проверка аргументов multiiff на отсутствие вложенных операндов с разделителем ';'
  for i := 0 to High(ArgArr) do
  begin

    Sa:=ArgArr[i];
    br1:=0; br2:=0;
    for j := 1 to Length(Sa) do
    begin
     if Sa[j] in OpenBracket  then inc(br1)
     else
     if Sa[j] in CloseBracket then inc(br2)
     else
     if (br1 = br2)   then
     begin
        if  (Sa[j] = ';') or ((odd(i) = True) and (Sa[j] = '='))   then
        begin
           Lib_ErrorCode:=E_NO_FUNCTION_ARGUMENT;
           Lib_ErrorString:=Sa+ #13#10+'  in: '+#13#10+Copy(PSM^,p,lens);
           goto endp;
        end;
     end
    end;

  end;
end;


(*
case NArg of
1: S1:=Copy(SM,p+lf,arp[0]-(p+lf)) ;
2: begin S1:=Copy(SM,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(SM,arp[0]+1,arp[1]-arp[0]-1);  end;
3: begin S1:=Copy(SM,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(SM,arp[0]+1,arp[1]-arp[0]-1); S3:= Copy(SM,arp[1]+1,arp[2]-arp[1]-1);   end;
4: begin S1:=Copy(SM,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(SM,arp[0]+1,arp[1]-arp[0]-1); S3:= Copy(SM,arp[1]+1,arp[2]-arp[1]-1); S4:=Copy(SM,arp[2]+1,arp[3]-arp[2]-1);   end;
5: begin S1:=Copy(SM,p+lf+1,arp[0]-(p+lf+1)) ; S2:=Copy(SM,arp[0]+1,arp[1]-arp[0]-1); S3:= Copy(SM,arp[1]+1,arp[2]-arp[1]-1); S4:=Copy(SM,arp[2]+1,arp[3]-arp[2]-1); S5:=Copy(SM,arp[3]+1,arp[4]-arp[3]-1);   end;
end;
*)

endf2:
lensf:=lens-p;
pf:=p;

endp:
end;




procedure _SyntaxExtCom_FindSubArg(SArg,Ssub: String; var ps: integer);
label endp;
var
i,br: integer;
begin
ps:=0;
br:=0;
for I := 1 to Length(SArg) do
  begin
    if (SArg[i] = '(') (*or (SArg[i] = '{') or (SArg[i] = '[')*) {or (SM[i] = '|')} then dec(br) else
    if (SArg[i] = ')') (*or (SArg[i] = '}') or (SArg[i] = ']')*) {or (SM[i] = '|')} then inc(br);

    if (br = 0) and (SArg[i] = Ssub) then
    begin
      ps:=i;
      goto endp;
    end;

  end;

endp:
end;






procedure _SyntaxExtCom_IF_PS(PSM:PString);

   function FindFirstProc(S: String): boolean;
      var
      Sc: String;
      pp: integer;
      BH: Boolean;
   begin
      BH:=False;
      {Sc:=LowerCase(S);} Sc:=S;
      pp:=pos('ifp(',Sc);

      if pp = 1 then BH:=True
      else
      pp:=pos('for(',S);

      if pp = 1 then BH:=True
      else
      pp:=pos('fordown(',S);

      if pp = 1 then BH:=True
      else
      pp:=pos('while(',S);

      if pp = 1 then BH:=True
      else
      pp:=pos('case(',S);

      if pp = 1 then BH:=True;


      FindFirstProc:=BH;
   end;


   function _CheckIFFArg(PS: PString): Boolean;
    label endp;
    var
    j,br1,br2: integer;
    BE: boolean;
    begin

       BE:=True;
       br1:=0; br2:=0;
       for j := 1 to Length(PS^) do
       begin
        if PS^[j] in OpenBracket  then inc(br1)
        else
        if PS^[j] in CloseBracket then inc(br2)
        else
        if (br1 = br2)   then
        begin
           if  (PS^[j] = ';') or  (PS^[j] = '=')   then
           begin
              BE:=False;
              //F_SyntaxErrorCode:=E_NO_FUNCTION_ARGUMENT;
              //F_SyntaxErrorString:=PS^+'   in:  '+F_CurrentString;
              goto endp;
           end;
        end
       end;

    endp:
    _CheckIFFArg:=BE;
    end;


label endp, nxt1;
var
SMlc,SF,S1,S2,S3,S4,S5,SR,S2c: String;
cp,NArg,lens,ps1,ps2,ps3,ps4,pf: Integer;
Bch: Boolean;
str: string[1];
FPType: Integer;
begin
{
ifp(cond,expA1,expA2;...;expAn) ->
if(cond,goto(lab#1),goto(Lab#2));Lab#1>>expA2;...;expAn; Lab#2>>

ifp(cond,expA1, expA2;...; expAn , exprB1; exprB2;...;exprBn) ->
if(cond,goto(lab#1),goto(Lab#2));Lab#1>>expA2;...;expAn; goto(Lab#3); Lab#2>> exprB1; exprB2;...;exprBn; Lab#3>>

//iff(x<y,x=sin(y),x=cos(y); y=sin(x))
//ifp(x<y,proc1(x1),proc2(x,y))
//ifp(x<y,proc1(x1))
//ifp(x<y,x=proc1(x1))
//ifp(x<y,proc1(x1); proc2(x))
//ifp(x<y,proc1(x1);proc2(x,y),proc3(x))
//ifp(x<y,proc1(x1),x=proc2(x,y))
//';' и/или '=' в аргументах без скобок  S1,S2


}

//k=0;ifp(n>5,inc(k));k   !!!!!!!!!!!

//SM:=SFin;
SF:='ifp';


cp:=1;
FPType:=_proc;

nxt1:
Bch:=False;


_SyntaxExtCom_FindArgPS(PSM,SF,FPType,cp,NArg,lens,pf,S1,S2,S3,S4,S5);

if  Lib_ErrorCode <> 0 then goto endp;

if (NArg = 0) and (SF = 'ifp') then
begin
 SF:='iff';
 cp:=1;
 FPType:=_func;
 goto nxt1;
end;

if NArg > 0 then
begin
//find in S2 and S3  ';' or '=' or :  'if(' , 'for( , fordown( , 'while(  in first position

//if(x<y, if(x>t,x=x+1)); x  !!!!!!!ERROR if(x<y, if(x>t,x=x+1); y=y); x

  if NArg = 1 then             {.195} //if(n>0)
  begin
    if (S1 = '')  then
    begin
     Lib_ErrorCode:=E_MISSING_EXPRESSION;
     Lib_ErrorString:=copy(PSM^,pf,lens+1);
    end
    else    {.346}
    if (NArg = 1) and (SF = 'ifp') then     //ifp(x=x+1)  ifp(x=x+1; y=y+1)  в процедуре должно быть минимум два аргумента
    begin
      Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
      Lib_ErrorString:=copy(PSM^,pf,lens+1);
    end;

    goto endp;
  end;

  if NArg = 2  then
  begin

       if (S1 = '') or (S2 = '') then
       begin
         Lib_ErrorCode:=E_MISSING_EXPRESSION;
         Lib_ErrorString:=copy(PSM^,pf,lens+1);
         goto endp;
       end;



       if SF = 'iff' then       {.346}
       begin
          if _CheckIFFArg(@S2) = False then     //iff(x>=y,y=x+1) iff(x>=y,y=x+1; y=x+2) iff(x>=y,proc1(x); proc2(x))
          begin
            Lib_ErrorCode:=E_NO_FUNCTION_ARGUMENT;
            Lib_ErrorString:=S2+ #13#10+'   in:  '+ #13#10+copy(PSM^,pf,lens+1);
            goto endp;
         end
       end;



      _SyntaxExtCom_FindSubArg(S2,';',ps1);
      if ps1 = 0 then
      begin

        _SyntaxExtCom_FindSubArg(S2,'=',ps2);
        if ps2 = 0 then
        begin
          if FindFirstProc(S2) =  True then Bch:=True;
          if (SF = 'ifp') and (Bch = False) then Bch:=True;   //k=0;ifp(n>5,inc(k));k   !!!!!!!!!!!
        end
        else
        Bch:=True

      end
      else Bch:=True;

      FindMissingSemiOperInMultiPS(@S2,1);      {.383}
      if Lib_ErrorCode <> 0 then goto endp;

  end    //NArg = 2

  else

  if NArg = 3  then
  begin

    if (S1 = '') or (S2 = '') or (S3 = '') then
    begin
      Lib_ErrorCode:=E_MISSING_EXPRESSION;
      Lib_ErrorString:=copy(PSM^,pf,lens+1);
      goto endp;
    end;



     if SF = 'iff' then    {.346}
     begin
          if _CheckIFFArg(@S2) = False then     //iff(x>=y,y=x+1,y=x+2) iff(x>=y,y=x+1; y=x+2, y=x+3; y=x+4) iff(x>=y,proc1(x); proc2(x),proc3(x);proc4(x))
          begin
            Lib_ErrorCode:=E_NO_FUNCTION_ARGUMENT;
            Lib_ErrorString:=S2+ #13#10+'   in:   '+ #13#10+ copy(PSM^,pf,lens+1);
            goto endp;
         end
         else
         if _CheckIFFArg(@S3) = False then           {.385}
         begin
              Lib_ErrorCode:=E_NO_FUNCTION_ARGUMENT;
              Lib_ErrorString:=S3+ #13#10+'   in:   '+ #13#10+ copy(PSM^,pf,lens+1);
              goto endp;
         end
     end;


     FindMissingSemiOperInMultiPS(@S2,1);         {.383}
     if Lib_ErrorCode <> 0 then goto endp;

     FindMissingSemiOperInMultiPS(@S3,1);        {.383}
     if Lib_ErrorCode <> 0 then goto endp;

    _SyntaxExtCom_FindSubArg(S2,';',ps1);
    if ps1 = 0 then
    begin

      _SyntaxExtCom_FindSubArg(S2,'=',ps2);
      if ps2  = 0 then
      begin

        _SyntaxExtCom_FindSubArg(S3,';',ps3);
        if ps3 = 0 then
        begin

         _SyntaxExtCom_FindSubArg(S3,'=',ps4);
          if ps4 <> 0 then Bch:=True;
        end
        else Bch:=True;

      end
      else
      Bch:=True;

    end
    else Bch:=True;

    //if(x<y, if(x>t,x=x+1), if(x>=y,x=x-1)); x       !!!!!!!!!!!!ERROR!!!!!!!!!
    //x*iff(x=1,cos(x),y=sin(x))+y
    if Bch = False then
    begin
      if FindFirstProc(S2) =  True then Bch:=True else
      if FindFirstProc(S3) =  True then Bch:=True;
      if (SF = 'ifp') and (Bch = False) then Bch:=True;   {.195}   //ifp(n<k,inc(n),inc(k))   !!!!!!!!!!!!ERROR!!!!!!!!!
    end;
  end
  else
  begin
    Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
    Lib_ErrorString:=copy(PSM^,pf,lens+1);
    goto endp;
  end;

  if Bch = true then
  begin
     //replace
    //if(cond,expA1,expA2;...;expAn) ->
    //if(cond,goto(lab#1),goto(Lab#2));Lab#1>>expA1;...;expAn; Lab#2>>

    //after replaceable if() must be ';' or ')' or end of string!!!!!
    if _CheckSyntaxExtComPS(PSM,pf,lens,0) = false then goto endp;

    if NArg = 2 then
    begin
    //ifp(x<y,x=sin(y))->                         if(x<y ,goto(lab#1), goto(Lab#2)); Lab31>> x=sin(y); Lab#2>>
    //ifp(x<y,proc1(x1);proc2(x,y))->             if(x<y ,goto(lab#1), goto(Lab#2)); Lab#1>> proc1(x1); proc2(x,y); Lab#2>>
    //ifp(x<y,proc1(x1))           ->             if(x<y,proc1(x1))
    //ifp(x<y,x=proc1(x1); y=proc2(x2))->         if(x<y ,goto(lab#1), goto(Lab#2)); Lab#1>> x=proc1(x1); y=proc2(x,y); Lab#2>>

     {.195}
     if S2[Length(S2)] = ';'  then  Delete(S2,Length(S2),1);

     //SR:='if('+S1+','+'goto(lab#'+IntToStr(LabCount)+'),goto(lab#'+IntToStr(LabCount+1)+'));lab#'+IntToStr(LabCount)+S_LABEL+S2+';lab#'+IntToStr(LabCount+1)+S_LABEL;
     SR:='if('+S1+','+'goto('+S_NameLab+IntToStr(LabCount)+'),goto('+S_NameLab+IntToStr(LabCount+1)+'));'+S_NameLab+IntToStr(LabCount)+S_LABEL+S2+';'+S_NameLab+IntToStr(LabCount+1)+S_LABEL;
     LabCount:=LabCount+2;

     delete(PSM^,pf,lens+1);
     insert(SR,PSM^,pf);
    end
    else
    if NArg = 3 then
    begin
      //replace
     //if(cond, expA1, expA2;...; expAn , exprB1; exprB2;...;exprBn) ->
     //if(cond,goto(lab#1),goto(Lab#2));Lab#1>>expA2;...;expAn; goto(Lab#3); Lab#2>> exprB1; exprB2;...;exprBn; Lab#3>>

     {.195}
     if S2[Length(S2)] = ';'  then  Delete(S2,Length(S2),1);
     if S3[Length(S3)] = ';'  then  Delete(S3,Length(S3),1);



     //SR:='if('+S1+','+'goto(lab#'+IntToStr(LabCount)+'),goto(lab#'+IntToStr(LabCount+1)+'));lab#'+IntToStr(LabCount)+S_LABEL+S2+';goto(lab#'+IntToStr(LabCount+2)+');lab#'+IntToStr(LabCount+1)+S_LABEL+S3+';lab#'+IntToStr(LabCount+2)+S_LABEL;
      SR:='if('+S1+','+'goto('+S_NameLab+IntToStr(LabCount)+'),goto('+S_NameLab+IntToStr(LabCount+1)+'));'+S_NameLab+IntToStr(LabCount)+S_LABEL+S2+';goto('+S_NameLab+IntToStr(LabCount+2)+');'+S_NameLab+IntToStr(LabCount+1)+S_LABEL+S3+';'+S_NameLab+IntToStr(LabCount+2)+S_LABEL;
      LabCount:=LabCount+3;

     delete(PSM^,pf,lens+1);
     insert(SR,PSM^,pf);
    end
    else
    begin
      Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
      Lib_ErrorString:=copy(PSM^,pf,lens+1);
      goto endp;
    end;

    //if(x<y , x=x+1;t= if(x>y , x=1.1; sin(x),cos(x)))
  end;

  inc(cp);
  goto nxt1;
end;

endp:
//SFout:=SM;
end;





procedure _SyntaxExtCom_WHILE_PS(PSM:PString);
label endp, nxt1;
var
SF,S1,S2,S3,S4,S5,SR,SR1,SR2,SR3: String;
cp,NArg,lens,ps1,ps2,ps3,ps4,pf: Integer;
Bch: Boolean;
begin

{
  while(expr, exprA1; exprA2; ...;exprAn) ->
       lab#1>> if(expr,goto(Lab#2),goto(Lab#3)); Lab#2>> exprA1;exprA2;...;exprAn;  goto(lab#1) ;Lab#3>>
}

//SM:=SFin;
cp:=1;


nxt1:
Bch:=False;
//SMlc:=LowerCase(SM);
_SyntaxExtCom_FindArgPS(PSM,'while',_proc,cp,NArg,lens,pf,S1,S2,S3,S4,S5);

if  Lib_ErrorCode <> 0 then goto endp;



if NArg > 0 then
begin

   if NArg = 1 then   {.195}   //while(n>0)
   begin
    NArg:=2;
    S2:=SCnop;
   end
   else
   if NArg <> 2  then
   begin
    Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
    Lib_ErrorString:=copy(PSM^,pf,lens+1);
    goto endp;
   end;

   if _CheckSyntaxExtComPS(PSM,pf,lens,1) = false then goto endp;



    if NArg = 2 then
    begin
       if (S1 = '') or (S2 = '') then
        begin
         Lib_ErrorCode:=E_MISSING_EXPRESSION;
         Lib_ErrorString:=copy(PSM^,pf,lens+1);
         goto endp;
        end;

       FindMissingSemiOperInMultiPS(@S2,1);        {.383}
       if Lib_ErrorCode <> 0 then  goto endp;


     {while(expr, exprA1; exprA2; ...;exprAn) ->
       lab#1>> if(expr,goto(Lab#2),goto(Lab#3)); Lab#2>> exprA1;exprA2;...;exprAn;  goto(lab#1) ;Lab#3>>
      }

      //t=0; x=0; y=5;  while(x<y, x=x+1;t=t+2); x+t

     {.195}
     if S2[Length(S2)] = ';'  then  Delete(S2,Length(S2),1);

     //SR:= 'lab#'+IntToStr(LabCount)+S_LABEL+'if('+S1+',goto(lab#'+IntToStr(LabCount+1)+'),goto(lab#'+IntToStr(LabCount+2)+'));lab#'+IntToStr(LabCount+1)+S_LABEL+S2+';goto(lab#'+IntToStr(LabCount)+');'+'lab#'+IntToStr(LabCount+2)+S_LABEL;
     SR:= S_NameLab+IntToStr(LabCount)+S_LABEL+'if('+S1+',goto('+S_NameLab+IntToStr(LabCount+1)+'),goto('+S_NameLab+IntToStr(LabCount+2)+'));'+S_NameLab+IntToStr(LabCount+1)+S_LABEL+S2+';goto('+S_NameLab+IntToStr(LabCount)+');'+S_NameLab+IntToStr(LabCount+2)+S_LABEL;
     LabCount:=LabCount+3;

     delete(PSM^,pf,lens+1);
     insert(SR,PSM^,pf);
    end;


  inc(cp);
  goto nxt1;
end;

endp:
//SFout:=SM;
end;








procedure _SyntaxExtCom_FORDOWN_PS(PSM:PString);
label endp, nxt1;
var
SF,S1,S2,S3,S4,S5,SR,SR1,SR2,SR3,S1a,S1b,S1t: String;
cp,NArg,lens,ps1,ps2,ps3,ps4,pf,ReIm: Integer;
vpos: Cardinal;
Bch: Boolean;
adrV: Cardinal;
VT,MT: Cardinal;
begin
{
(var - only integer)

fordown(var,expr1,expr2,exprA1;exprA2;...;exprAn) ->
var=expr1; lab#1>> if(var < expr2,goto(Lab#2)); exprA1;exprA2;...;exprAn; dec(var); goto(lab#1) ;Lab#2>>

}

//SM:=SFin;
cp:=1;


nxt1:
Bch:=False;
_SyntaxExtCom_FindArgPS(PSM,'fordown',_proc,cp,NArg,lens,pf,S1,S2,S3,S4,S5);

if  Lib_ErrorCode <> 0 then goto endp;


if NArg > 0 then
begin
   //fordown(n=5,0)
 if NArg = 2 then    {.365}
 begin
   //DeleteExternalBracketPS(@S1);
   if FindAssign(@S1,@S1a,@S1b) = True then
   begin
     S1:=S1a; S3:=S2; S2:=S1b;
     NArg:=4;
     S4:=SCnop;
   end
   else
   begin
     Lib_ErrorCode:=E_MISSING_EXPRESSION;
     Lib_ErrorString:=copy(PSM^,pf,lens+1);
     goto endp;
   end;
 end
 else
 if NArg = 3 then               {.365}
  begin
   //DeleteExternalBracketPS(@S1);    //fordown(n=10,0,k=k+1)
   if FindAssign(@S1,@S1a,@S1b) = True then
   begin
     S4:=S3; S3:=S2; S2:=S1b; S1:=S1a;
     NArg:=4;
   end
   else
   begin            {.195}   //fordown(n,5,0)
     NArg:=4;
     S4:=SCnop;
   end;
  end
  else
  if (NArg <> 4)  then
  begin
   Lib_ErrorCode:=fl_WRONG_NUMBER_ARGUMENTS;
   Lib_ErrorString:=copy(PSM^,pf,lens+1);
   goto endp;
  end;

  {
  if _SyntaxExtComSep(SM,pf+lens) = False then
       begin
          E_Code:=E_MISSING_SEPARATOR;
          SError:=copy(SM,pf,lens+1);
          goto endp;
       end;
   }

    if _CheckSyntaxExtComPS(PSM,pf,lens,1) = false then goto endp;

  begin


    if NArg = 4 then
    begin
      if (S1 = '') or (S2 = '') or (S3 = '') or (S4 = '') then
       begin
        Lib_ErrorCode:=fl_MISSING_EXPRESSION;
        Lib_ErrorString:=copy(PSM^,pf,lens+1);
        goto endp;
       end;

      (*
      {.191}  //check loop var. for corectness:
      Foreval.ExistVar(S1,adrV,VT,MT);
      if  (VT <> T_Real) or (MT <> _Integer) then
      begin
        if FindControlVar(S1,SFin,T_Real,_Integer,vpos) = False then
        begin
          Lib_ErrorCode:=E_INCORRECT_ARGUMENT;
          Lib_ErrorString:=copy(SM,pf,lens+1);
          goto endp;
        end;
      end;
      *)

      {.385}
      // вначале искать переменную в тексте прог.
      S1t:=S1;
      if FindControlVarPS(@S1t,{SFin}PSM,T_Real,_Integer, vpos, ReIm) = False then
      begin
          Foreval.ExistVar(S1,adrV,VT,MT);        // искать среди глобальных
          if  (VT <> T_Real) or (MT <> _Integer) then
          begin
              Lib_ErrorCode:=E_INCORRECT_ARGUMENT;
              Lib_ErrorString:='  "'+S1+'"' + #13#10+ ' in:' +#13#10+'"'+ 'fordown('+S1+'  ';//copy(SM,pf,lens+1);
              goto endp;
          end
      end
      else
      if vpos > pf then           // переменная определена после
      begin
           Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
           Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:' +#13#10+'"'+  'fordown('+S1+'  ';//copy(SM,pf,lens+1);
           goto endp;
      end;


     {
      fordown(var,expr1,expr2,exprA1;exprA2;...;exprAn) ->
      var=expr1; lab#1>> if(var < expr2,goto(Lab#2)); exprA1;exprA2;...;exprAn; dec(var); goto(lab#1) ;Lab#2>>
     }
     //x=0;  fordown(i,5,1,x=x+1); x

     FindMissingSemiOperInMultiPS(@S4,1);    {.383}
     if Lib_ErrorCode <> 0 then goto endp;

     {.195}
     if S4[Length(S4)] = ';'  then  Delete(S4,Length(S4),1);

     //SR:= S1+'='+S2+';'+'lab#'+IntToStr(LabCount)+S_LABEL+'if('+S1+'<'+S3+',goto(lab#'+IntToStr(LabCount+1)+'));'+S4+';dec('+S1+');'+'goto(lab#'+IntToStr(LabCount)+');'+'lab#'+IntToStr(LabCount+1)+S_LABEL;
     SR:= S1+'='+S2+';'+S_NameLab+IntToStr(LabCount)+S_LABEL+'if('+S1+'<'+S3+',goto('+S_NameLab+IntToStr(LabCount+1)+'));'+S4+';dec('+S1+');'+'goto('+S_NameLab+IntToStr(LabCount)+');'+S_NameLab+IntToStr(LabCount+1)+S_LABEL;
     LabCount:=LabCount+2;

     delete(PSM^,pf,lens+1);
     insert(SR,PSM^,pf);
    end;
  end;

  inc(cp);
  goto nxt1;
end;

endp:
//SFout:=SM;
end;








procedure _SyntaxExtCom_FOR_PS(PSM:PString);
label endp, nxt1;
var
SF,S1,S2,S3,S4,S5,SR,SR1,SR2,SR3,S1a,S1b,S1t: String;
cp,NArg,lens,ps1,ps2,ps3,ps4,pf,ReIm: Integer;
vpos: Cardinal;
Bch: Boolean;
adrV: Cardinal;
VT,MT,ImU,CT,P: Cardinal;
begin
{

(var - only integer)
for(var,expr1,expr2,exprA1;exprA2;...;exprAn)
for(var=expr1,expr2,exprA1;exprA2;...;exprAn)
->
var=expr1; lab#1>> if(var > expr2,goto(Lab#2)); exprA1;exprA2;...;exprAn; inc(var); goto(lab#1) ;Lab#2>>

(var - only integer)
fordown(var,expr1,expr2,exprA1;exprA2;...;exprAn)
fordown(var=expr1,expr2,exprA1;exprA2;...;exprAn)
->
var=expr1; lab#1>> if(var < expr2,goto(Lab#2)); exprA1;exprA2;...;exprAn; dec(var); goto(lab#1) ;Lab#2>>

(var - any)
for(var,expr1,expr2,expr3,exprA1;exprA2;...;exprAn)
for(var=expr1,expr2,expr3,exprA1;exprA2;...;exprAn)
->
var=expr1; lab#1>> if(expr2,goto(Lab#2),goto(Lab#3)); Lab#2>> exprA1;exprA2;...;exprAn; var=expr3; goto(lab#1) ;Lab#3>>
//for(x,n+k,(2*x < n*k) or ( x < 100), x=x*2+n, exprA1;exprA2;...;exprAn)
}

//SM:=SFin;
cp:=1;


nxt1:
Bch:=False;
_SyntaxExtCom_FindArgPS(PSM,'for',_proc,cp,NArg,lens,pf,S1,S2,S3,S4,S5);

if  Lib_ErrorCode <> 0 then goto endp;



if NArg > 0 then
begin

  //for(n=0,5)
 if NArg = 2 then    {.365}
 begin
   //DeleteExternalBracketPS(@S1);
   if FindAssign(@S1,@S1a,@S1b) = True then
   begin
     S1:=S1a; S3:=S2; S2:=S1b;
     NArg:=4;
     S4:=SCnop;
   end
   else
   begin
     Lib_ErrorCode:=E_MISSING_EXPRESSION;
     Lib_ErrorString:=copy(PSM^,pf,lens+1);
     goto endp;
   end;
 end
 else
 if NArg = 3 then               {.365}
  begin
   //DeleteExternalBracketPS(@S1);    //for(n=0,5,k=k+1)
   if FindAssign(@S1,@S1a,@S1b) = True then
   begin
     S4:=S3; S3:=S2; S2:=S1b; S1:=S1a;
     NArg:=4;
   end
   else
   begin            {.195}   //for(n,0,5)
     NArg:=4;
     S4:=SCnop;
   end;
  end
  else
  if NArg = 4 then   // for(x=1,x<=10,x+1,y=sin(y))           {.365}
  begin
     //DeleteExternalBracketPS(@S1);
     if FindAssign(@S1,@S1a,@S1b) = True then
     begin
       S5:=S4; S4:=S3; S3:=S2; S2:=S1b; S1:=S1a;
       NArg:=5;
     end
  end
 else
 if (NArg <> 4) and (NArg <> 5) then
  begin
   Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
   Lib_ErrorString:=copy(PSM^,pf,lens+1);
   goto endp;
  end;

  if _CheckSyntaxExtComPS(PSM,pf,lens,1) = false then goto endp;


  begin

    if NArg = 4 then
    begin

       if (S1 = '') or (S2 = '') or (S3 = '') or (S4 = '') then
       begin
        Lib_ErrorCode:=E_MISSING_EXPRESSION;
        Lib_ErrorString:=copy(PSM^,pf,lens+1);
        goto endp;
       end;



      {.385}
      // вначале искать переменную в тексте прог.
      S1t:=S1;
      if FindControlVarPS(@S1t,{SFin}PSM,T_Real,_Integer, vpos, ReIm) = False then
      begin
          Foreval.ExistVar(S1,adrV,VT,MT);        // искать среди глобальных
          if  (VT <> T_Real) or (MT <> _Integer) then
          begin
              Lib_ErrorCode:=E_INCORRECT_ARGUMENT;
              Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:'+ #13#10+'"'+  'for('+S1+'  ';//copy(SM,pf,lens+1);
              goto endp;
          end
      end
      else
      if vpos > pf then           // переменная определена после
      begin
           Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
           Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:' +#13#10+'"'+  'for('+S1+'  ';//copy(SM,pf,lens+1);
           goto endp;
      end;

     {
      for(var,expr1,expr2,exprA1;exprA2;...;exprAn) ->
      var=expr1; lab#1>> if(var > expr2,goto(Lab#2)); exprA1;exprA2;...;exprAn; inc(var); goto(lab#1) ;Lab#2>>
     }
     //x=0; i=1; for(i,1,5,x=x+1); x
     //x=0;  for(i,1,5, if({i*0.5}=0,for(j,1,10,x=x+1))); x
     //x=0;  for(i,1,5, if({i*0.5}=0,  for(j,1,10,x=x+1; if(j>=5,goto(lab1))) lab1>>)); x
     //x=0;  for(i,1,5, if({i*0.5}=0,  for(j,1,10,x=x+1; if(j>=5,goto(lab1)))) lab1>>); x
     //t=0; for(i,1,5,for(j,1,i,t=t+1)); t

     FindMissingSemiOperInMultiPS(@S4,1);        {.383}
     if Lib_ErrorCode <> 0 then goto endp;

     {.195}               //for(n,0,5,y=x;);y
     if S4[Length(S4)] = ';'  then  Delete(S4,Length(S4),1);

     //SR:= S1+'='+S2+';'+'lab#'+IntToStr(LabCount)+S_LABEL+'if('+S1+'>'+S3+',goto(lab#'+IntToStr(LabCount+1)+'));'+S4+';inc('+S1+');'+'goto(lab#'+IntToStr(LabCount)+');'+'lab#'+IntToStr(LabCount+1)+S_LABEL;
     SR:= S1+'='+S2+';'+S_NameLab+IntToStr(LabCount)+S_LABEL+'if('+S1+'>'+S3+',goto('+S_NameLab+IntToStr(LabCount+1)+'));'+S4+';inc('+S1+');'+'goto('+S_NameLab+IntToStr(LabCount)+');'+S_NameLab+IntToStr(LabCount+1)+S_LABEL;
     LabCount:=LabCount+2;

     delete(PSM^,pf,lens+1);
     insert(SR,PSM^,pf);
    end
    else
    if NArg = 5 then
    begin

      if (S1 = '') or (S2 = '') or (S3 = '') or (S4 = '') or (S5 = '') then
       begin
        Lib_ErrorCode:=E_MISSING_EXPRESSION;
        Lib_ErrorString:=copy(PSM^,pf,lens+1);
        goto endp;
       end;

      {.191}//check loop var. for corectness:
      S1t:=S1;
      if FindControlVarPS(@S1t,{SFin}PSM,T_Real,_Integer,vpos, ReIm) = False then
      begin
          S1t:=S1;
          if FindControlVarPS(@S1t,{SFin}PSM,T_Real,_Extended,vpos, ReIm) = False then
          begin
             S1t:=S1;
             if FindControlVarPS(@S1t,{SFin}PSM,T_Complex,_Extended,vpos, ReIm) = False then
             begin

                     Foreval.ExistVarEx(S1,adrV,VT,MT,CT,ImU);
                             if  ((VT = T_Complex) and (CT = 0)) or (ImU = Im_Unit) or (VT = 0) then
                             begin
                                Lib_ErrorCode:=E_INCORRECT_ARGUMENT;
                                Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:' +#13#10+'"'+ 'for('+S1+'  ';//copy(SM,pf,lens+1);
                                goto endp;
                             end
                             else
                             if  (VT = T_Complex) and (CT = 0) then
                             begin
                                Lib_ErrorCode:=E_INCORRECT_ARGUMENT;
                                Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:'  +#13#10+'"'+ 'for('+S1+'  ';//copy(SM,pf,lens+1);
                                goto endp;
                             end
             end
             else
             if vpos > pf then           // переменная определена после
             begin
                Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
                Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:'  +#13#10+'"'+ 'for('+S1+'  ';//copy(SM,pf,lens+1);
                goto endp;
              end;

          end
          else
          if vpos > pf then           // переменная определена после
          begin
              Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
              Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:'  +#13#10+'"'+ 'for('+S1+'  ';//copy(SM,pf,lens+1);
              goto endp;
          end;

      end
      else
      if vpos > pf then           // переменная определена после
      begin
         Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
         Lib_ErrorString:='  "'+S1+'"'+ #13#10+' in:'  +#13#10+'"'+ 'for('+S1+'  ';//copy(SM,pf,lens+1);
         goto endp;
      end;


       {
      for(var,expr1,expr2,expr3,exprA1;exprA2;...;exprAn) ->
      var=expr1; lab#1>> if(expr2,goto(Lab#2),goto(Lab#3)); Lab#2>> exprA1;exprA2;...;exprAn; var=expr3; goto(lab#1) ;Lab#3>>
      }

      //for(x,n+k,(2*x < n*k) or ( x < 100), x*2+n, exprA1;exprA2;...;exprAn)
      //for(x,1,x<=10,x+1,y=sin(y))
      //t=0; for(x,1,x<=3,x+1,for(y,1,y<=x,y+1,t=t+1)); t
      //k1:int=0; CKL:int=10; ires:int=0; for(k1=1,CKL, k2:int=0; for(k2=1,CKL,k3:int=0;for(k3=1,CKL,inc(ires)))); ires

     FindMissingSemiOperInMultiPS(@S5,1);               {.383}
     if Lib_ErrorCode <> 0 then goto endp;

     {.195}
     if S5[Length(S5)] = ';'  then  Delete(S5,Length(S5),1);
     SR:= S1+'='+S2+';'+'lab#'+IntToStr(LabCount)+S_LABEL+'if('+S3+',goto(lab#'+IntToStr(LabCount+1)+'),goto(lab#'+IntToStr(LabCount+2)+'));lab#'+IntToStr(LabCount+1)+S_LABEL+S5+';'+S1+'='+S4+';goto(lab#'+IntToStr(LabCount)+');'+'lab#'+IntToStr(LabCount+2)+S_LABEL;
     SR:= S1+'='+S2+';'+S_NameLab+IntToStr(LabCount)+S_LABEL+'if('+S3+',goto('+S_NameLab+IntToStr(LabCount+1)+'),goto('+S_NameLab+IntToStr(LabCount+2)+'));'+S_NameLab+IntToStr(LabCount+1)+S_LABEL+S5+';'+S1+'='+S4+';goto('+S_NameLab+IntToStr(LabCount)+');'+S_NameLab+IntToStr(LabCount+2)+S_LABEL;
     LabCount:=LabCount+3;

     delete(PSM^,pf,lens+1);
     insert(SR,PSM^,pf);
    end;

    //if(x<y , x=x+1;t= if(x>y , x=1.1; sin(x),cos(x)))
  end;

  inc(cp);
  goto nxt1;
end;

endp:
//SFout:=SM;
end;




procedure _SyntaxExtCom_MULTIIFF_PS(PSM:PString; TypeF: Integer);
label endp, nxt1;
var
SF,SArgIff,SArgMulti,Multi_Name,If_Name,S1,S2,S3,S4,S5,SR,SR1,SR2,SR3: String;
cp,NArg,lens,ps1,ps2,ps3,ps4,pf: Integer;
Bch: Boolean;
adrV: Cardinal;
VT,MT,ImU,CT,P,NArgIff: Cardinal;
ArgArr: TArrayStr;
i: Integer;
BF: Boolean;
begin
{
  multiiff(cond1,Arg1, cond2,Arg2, cond3,Arg3,..., condN,ArgN)
    -> iff(cond1,Arg1,iff(cond2,Arg2,iff(cond3,Arg3,iff(...,iff(condN,ArgN)))))

  multiiff(cond1,Arg1, cond2,Arg2, cond3,Arg3,..., condN,ArgN,ArgN0)
    -> iff(cond1,Arg1,iff(cond2,Arg2,iff(cond3,Arg3,iff(...,iff(condN,ArgN,ArgN0)))))


  multiifp(cond1,Arg1_1;Arg1_2;...,  cond2,Arg2_1;Arg2_2;..., cond3,Arg3_1;Arg3_2;..., condN,ArgN_1;ArgN_2;...)
    -> ifp(cond1,Arg1_1;Agr1_2;...,ifp(cond2,Arg2_1;Arg2_2;...,ifp(cond3,Arg3_1;Arg3_2;...,ifp(...,ifp(condN,ArgN_1;ArgN_2;...)))))

  multiifp(cond1,Arg1_1;Arg1_2;...,  cond2,Arg2_1;Arg2_2;..., cond3,Arg3_1;Arg3_2;..., condN,ArgN_1;ArgN_2;...,ArgN2_1,ArgN2_2;...)
    -> ifp(cond1,Arg1_1;Agr1_2;...,ifp(cond2,Arg2_1;Arg2_2;...,ifp(cond3,Arg3_1;Arg3_2;...,ifp(...,ifp(condN,ArgN_1;ArgN_2;...,ArgN2_1,ArgN2_2;...)))))


}

//SM:=SFin;
cp:=1;


if TypeF = _func then
begin
  Multi_Name:='multiiff';
  IF_Name:='iff';
end
else
if TypeF = _proc then
begin
  Multi_Name:='multiifp';
  IF_Name:='ifp';
end;


nxt1:
Bch:=False;
_SyntaxExtCom_FindArgArrPS(PSM,Multi_Name,TypeF,cp,NArg,lens,pf,ArgArr);

if  Lib_ErrorCode <> 0 then goto endp;


if NArg > 0 then
begin

  //NArgIff:=Narg div 2;
  BF:=True;
  SArgIff:='';
  i:=High(ArgArr);
  //for i := NArgIff downto 1 do
        //multiiff((y=1)and(y=2),sin(y),(y=10)and(y=20),cos(y))
        //multiiff((t=1)or(t=2)or(t=3),xx*multiiff(z=1,sin(t),yy*multiiff(u=5,sin(z)+yy,u=9,tt*multiiff(v=10,sin(x*y),v=20,cos(x*y))+tt)+yy)+xx)
        //multiiff(t=1,cos(x))
        //multiiff(t=1,sin(x),cos(x))
        //x*multiiff(x=1,sin(x),x=2,cos(x),x=3,tan(x))+t
        //x*multiiff(x=1,sin(x),x=2,cos(x),x=3,tan(x),cotan(x))+t
        //x*multiiff(x=1,cos(x),x=2,sin(x),x=3,y=y+1;tan(x))+y
        //x*multiiff(x=1,cos(x),x=2,sin(x),x=3,x*multiiff(y=y+1;tan(x))+y)+y

        //multiiff((t=1)or(t=2)or(t=3),xx*multiiff(z=1,sin(t),yy*multiiff(u=5,sin(z)+yy,u=9,tt*multiiff(v=10,sin(x*y),v=20,cos(x*y))+tt)+yy)+xx)

        //multiifp(x=1,cos(x),x=2,sin(x),x=3,multiifp(y=y+1;y=tan(y)))


  while i >= 0 do
  begin
     if (i = 0) and (BF = True) then   //multiiff(cond) -> iff(cond)     multiiff(x>=0)
     begin
         SArgIff:=IF_Name+'('+ArgArr[0]+')';
         i:=i-1;
         BF:=False;
         if TypeF = _proc then        //multiifp(y=y+1;y=tan(y))
         begin
           Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
           Lib_ErrorString:=Multi_Name+'('+ArgArr[0]+')';
           goto endp;
         end;
     end
     else
     if (NArg mod 2 =  0) and (BF = True) then   //  iff(condN,ArgN)
     begin
        SArgIff:=IF_Name+'('+ArgArr[i-1]+','+ArgArr[i]+')';
        i:=i-2;
        BF:=False;
     end
     else   // iff(condN,ArgN,ArgN0)
     if (BF = True) then
     begin
       SArgIff:=IF_Name+'('+ArgArr[i-2]+','+ArgArr[i-1]+','+ArgArr[i]+')';
       i:=i-3;
       BF:=False;
     end
     else
     begin
        SArgIff:=IF_Name+'('+ArgArr[i-1]+','+ArgArr[i]+','+SArgIff+')';
        i:=i-2;
     end;

  end;


 Delete(PSM^,pf,lens+1);
 Insert(SArgIff,PSM^,pf);
 //cp:=cp+Length(Multi_Name+'(');
 cp:=cp+Length(IF_Name+'(');
 goto nxt1;


  if _CheckSyntaxExtComPS(PSM,pf,lens,1) = false then goto endp;



end;

endp:
//SFout:=SM;
end;






procedure _SyntaxExtCom_CASEP_PS(PSM:PString; TypeF: Integer);


         procedure _findCondOP(PArg: PString; var CondOP: String);
         //CondOP = '=','>','<','<=','=<','>=','=>', '<>', '><' :

         begin

           if Length(PArg^) > 2 then
           begin
             CondOP:='';
             //порядок не менять:
             if (PArg^[1] = '<') and (PArg^[2] = '=')  then CondOP:='<=' else
             if (PArg^[1] = '=') and (PArg^[2] = '<')  then CondOP:='<=' else
             if (PArg^[1] = '>') and (PArg^[2] = '=')  then CondOP:='>=' else
             if (PArg^[1] = '=') and (PArg^[2] = '>')  then CondOP:='>=' else
             if (PArg^[1] = '<') and (PArg^[2] = '>')  then CondOP:='<>' else
             if (PArg^[1] = '>') and (PArg^[2] = '<')  then CondOP:='<>' else
             if (PArg^[1]) = '=' then  CondOp:='=' else
             if (PArg^[1]) = '>' then  CondOp:='>' else
             if (PArg^[1]) = '<' then  CondOp:='<';

             if  CondOP <> '' then Delete(PArg^,1,Length(CondOp))  else CondOP:='=';

           end
           else
           if Length(PArg^) > 1 then
           begin
             CondOP:='';

             if PArg^[1] = '=' then CondOP:='=' else
             if PArg^[1] = '>' then CondOP:='>' else
             if PArg^[1] = '<' then CondOP:='<' ;
             //else CondOP:='=';

             if  CondOP <> '' then Delete(PArg^,1,1)  else CondOP:='=';
             //Delete(PS^,1,1);
           end
           else
           CondOP:='=';

         end;



         function DefineCaseVar(NameArg: String;  PS: PString; poscom: Integer; var ExprType: Integer):Boolean;
           label endf;
           var
             BRes: Boolean;
             ReIm: Integer;
             vpos: Cardinal;
             S1t: String;
         begin

             BRes:=False; // только, если переменная найдена ниже в коде

             // Вначале искать выше, в коде программы
             S1t:=NameArg;
             if FindControlVarPS(@S1t,PS,T_Real,_Integer, vpos, ReIm) = True then
             begin

                if vpos > poscom then           // переменная определена после
                begin
                  Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
                  Lib_ErrorString:='  "'+NameArg+'"'+ #13#10+' in:'  +#13#10+'"'+ 'case('+NameArg+'  ';//copy(SM,pf,lens+1);
                  goto endf;
                end;

                ExprType := _IntVar;
                BRes:=True;
                goto endf;
             end;

             S1t:=NameArg;
             if FindControlVarPS(@S1t,PS,T_Real,_Extended, vpos, ReIm) = True then
             begin

                if vpos > poscom then           // переменная определена после
                begin
                  Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
                  Lib_ErrorString:='  "'+NameArg+'"'+ #13#10+' in:'  +#13#10+'"'+ 'case('+NameArg+'  ';//copy(SM,pf,lens+1);
                  goto endf;
                end;

                ExprType := _FloatVar;
                BRes:=True;
                goto endf;
             end;

             S1t:=NameArg;
             if FindControlVarPS(@S1t,PS,T_Complex,_Extended, vpos, ReIm) = True then
             begin

                if vpos > poscom then           // переменная определена после
                begin
                  Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
                  Lib_ErrorString:='  "'+NameArg+'"'+ #13#10+' in:'  +#13#10+'"'+ 'case('+NameArg+'  ';//copy(SM,pf,lens+1);
                  goto endf;
                end;

                if ReIm = _RE then    ExprType := _ComplexVarRE
                else
                if ReIm = _IM then    ExprType := _ComplexVarIM;


                BRes:=True;
                goto endf;
             end;

             S1t:=NameArg;
             if FindControlVarPS(@S1t,PS,T_Array,_Integer, vpos, ReIm) = True then
             begin
                if vpos > poscom then           // переменная определена после
                begin
                  Lib_ErrorCode:=E_UNKNOWN_VARIABLE;
                  Lib_ErrorString:='  "'+NameArg+'"'+ #13#10+' in:'  +#13#10+'"'+ 'case('+NameArg+'  ';//copy(SM,pf,lens+1);
                  goto endf;
                end;

                  BRes:=True;
                  ExprType := _IntArray;
                  goto endf;
             end;

             // искать среди глобальных , а также IntForm
            Foreval.FindExprTypePS(@NameArg, ExprType);
            BRes:=True;

            endf:
            DefineCaseVar:=BRes;
         end;




label endp, nxt1;
var
SF,S1,S2,SArgIff,CaseVar,Case_Name,IF_Name,SaveExpr,CondOP: String;
cp,NArg,lens,ps1,ps2,ps3,ps4,pf: Integer;
Bch: Boolean;
adrV: Cardinal;
VT,MT,ImU,CT,P,NArgIff: Cardinal;
ArgArr: TArrayStr;
i: Integer;
BFirst: Boolean;
ExprType: Integer;
begin

//error ! vi10[j] не находит в  FindControlVarPS !! Переделать , как в FindExprTypePS
{
vi10:arrayint=10;
vi10[5]=7;
case(vi10[j],
     =k,   x=x+1;,
     =j+2, x=x+2;,
           x=x+3;
     );
x
}

{

comparison MainExpr  with Cond1,Cond2,...: '=' :
   casep(MainExpr, Cond1, Arg1_1;Arg1_2;...Arg1_N,  Cond2, Arg2_1;Arg2_2;...Arg2_N, ...,CondK, ArgK_1;ArgK_2;...ArgK_N, <ELSE_EXPR>)
    -> Var#Tmp=MainExpr; ifp(Var#Tmp=cond1,Arg1_1; Agr1_2;..., ifp(Var#Tmp=cond2, Arg2_1;Arg2_2;...,ifp(Var#Tmp=cond3,Arg3_1;Arg3_2;...,ifp(...,ifp(Var#Tmp=condN,ArgK2_1,ArgK2_2;...,<ELSE_EXPR>)))))

comparison MainExpr  with Cond1,Cond2,...: OP(OP1,OP2,...) = '=','>','<','<=','=<','>=','=>', '<>' :
   casep(MainExpr,OP1 Cond1, Arg1_1;Arg1_2;...Arg1_N,OP2 Cond2, Arg2_1;Arg2_2;...Arg2_N, ...,OPK CondK, ArgK_1;ArgK_2;...ArgK_N,<ELSE_EXPR>)
   -> Var#Tmp=MainExpr; ifp(Var#Tmp op cond1,Arg1_1; Agr1_2;..., ifp(Var#Tmp op cond2, Arg2_1;Arg2_2;...,ifp(Var#Tmp op cond3,Arg3_1;Arg3_2;...,ifp(...,ifp(Var#Tmp op condN,ArgK2_1,ArgK2_2;...,<ELSE_EXPR>)))))

if MainExpr - variable: CaseVar
    ->  ifp(CaseVar OP1 cond1,Arg1_1; Agr1_2;..., ifp(CaseVar OP2 cond2, Arg2_1;Arg2_2;...,ifp(CaseVar OP3 cond3,Arg3_1;Arg3_2;...,ifp(...,ifp(CaseVar OPN condN,ArgK2_1,ArgK2_2;...,<ELSE_EXPR>)))))


}

{
  casep(ExprCond, op cond1,agrA1;...argAn, op cond2, argB1;...argBn, op cond3,... )

  casep(x^2+1, >=1, y+1, >=2, y+2, =3, y+3,...)

}



//SM:=SFin;
cp:=1;
SaveExpr:='';


{
if TypeF = _func then
begin
  Case_Name:='casef';
  IF_Name:='iff';
end
else
if TypeF = _proc then
begin
  Case_Name:='casep';
  IF_Name:='ifp';
end;
}

//While work only CASE Proc!!!  instead casep&casef
Case_Name:='case';
IF_Name:='ifp';



nxt1:
Bch:=False;
_SyntaxExtCom_FindArgArrPS(PSM,Case_Name,TypeF,cp,NArg,lens,pf,ArgArr);

if  Lib_ErrorCode <> 0 then goto endp;

if NArg > 0 then
begin

  if NArg < 3 then
  begin
     Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
     Lib_ErrorString:=copy(PSM^,pf,lens+1);
     goto endp;
  end;


   // casep(z1.re,1,t=x+1,2,t=x+2,3,t=x+3,t=x+y);
  // Foreval.FindExprTypePS(@ArgArr[0], ExprType);

   {.385}
   if DefineCaseVar(ArgArr[0], PSM, pf,  ExprType) = False then goto endp;

   if ExprType = _IntVar then  //IntVar=cond1,IntVar=cond2,...
   begin
      CaseVar:=ArgArr[0];
   end
   else
   if ExprType = _FloatVar then     //FloartVar=cond1,FloartVar=cond2,...
   begin
      CaseVar:=ArgArr[0];
   end
   else
    if ExprType = _ComplexVarRE then     //ComplexVar.re=cond1,ComplexVar.re=cond2,...
   begin
      CaseVar:=ArgArr[0];
   end
   else
    if ExprType = _ComplexVarIM then     //ComplexVar.im=cond1,ComplexVar.im=cond2,...
   begin
      CaseVar:=ArgArr[0];
   end
   else
   if ExprType = _IntArray then      //IntVar#Tmp=IntArray[]
   begin
      inc(IntrnlVarCount);
      CaseVar:=S_CaseIntVarName+IntToStr(IntrnlVarCount);
      SaveExpr:=CaseVar + '=' + ArgArr[0]+';' ;
      _SetVarIntrnlS(CaseVar ,T_Real ,_Integer, ds_ProgrammBody, False);

      {Foreval.EnableCheckName:=False;
      _SetIntVarMultiExpr(CaseVar, T_Real ,_Integer, AdrV);
      Foreval.EnableCheckName:=True;}

       //CaseVar:=ArgArr[0];
   end
   else
   if ExprType = _IntForm then  //IntVar#Tmp=IntForm
   begin
      inc(IntrnlVarCount);
      CaseVar:=S_CaseIntVarName+IntToStr(IntrnlVarCount);
      SaveExpr:=CaseVar + '=' + ArgArr[0]+';' ;
      _SetVarIntrnlS(CaseVar ,T_Real ,_Integer, ds_ProgrammBody, False);

      {Foreval.EnableCheckName:=False;
      _SetIntVarMultiExpr(CaseVar, T_Real ,_Integer, AdrV);
      Foreval.EnableCheckName:=True;}

       //CaseVar:=ArgArr[0];
   end
   else      //FloatVar#Tmp=MainExpr
   begin
       inc(IntrnlVarCount);                              {CASE}
       CaseVar:=S_CaseFloatVarName+IntToStr(IntrnlVarCount);
       SaveExpr:=CaseVar + '=' + ArgArr[0]+';' ;
       _SetVarIntrnlS(CaseVar, T_Real ,Foreval.DataType, ds_ProgrammBody, False);

       {Foreval.EnableCheckName:=False;
       _SetIntVarMultiExpr(CaseVar, T_Real ,Foreval.DataType, AdrV);
       Foreval.EnableCheckName:=True; }

       // CaseVar:=ArgArr[0];
   end;


  //NArgIff:=Narg div 2;
  BFirst:=True;
  SArgIff:='';
  i:=High(ArgArr);
        //case(x,1,t=x+1,2,y=x+2,3,y=x+3,y=x+y)
        //case(x,=1,t=x+1,>=2,y=x+2,<3,y=x+3,y=x+y)
        //case(x,=1,t=x+1;t=t+1,>=2,y=x+2;x=y+2,<3,y=x+3;x=y+3,y=x+y;x=x+y)
        //case(x,=1,t=x+1;t=t+1,   >=2,t=x+2;t=y+2,  <3, t=x+3;t=t+3, t=x+t;t=x+t)
        //case(x,=1,t=x+1;t=t+1,   >=2,t=x+2;t=y+2,  <3, t=x+3;t=t+3)
        //case(n+k*2,1,t=x+1,2,y=x+2,3,y=x+3,y=x+y); y=x+2;y
        //case(vi[k+j],1,y=x+1,2,y=x+2,3,y=x+3,y=x+y); y=x+2;y
        //case(x^2+1,1,y=x+1,2,y=x+2,3,y=x+3,y=x+y); y=x+2;y
        //x=2; case(x+1,1,t=x+1,2,y=x+2,3,y=x+3,y=x+y); k=1; j=2; casep(k+j-1,1,t=x+1,2,y=x+2,3,y=x+3,y=x+y); x+y
        //x=y+1; case(x,1,t=x+1,2,t=x+2,3,t=x+3,t=x+y); t
        //case(t,  =>1, x = 1; y =1;, => 2, x =2;  y =2; ,x=3; y=3);
        //case(t,  =>1, x = 1; y =1;);

  while i >= 1 do     //'0' - ExprCond
  begin

     if (NArg mod 2 =  0) and (BFirst = True) then   // чётное число аргументов в case: +<ELSE_EXPR>
     begin
       _findCondOP(@ArgArr[i-2],CondOP);
       SArgIff:=IF_Name+'('+CaseVar+CondOP+ArgArr[i-2]+','+ArgArr[i-1]+','+ArgArr[i]+')';
       i:=i-3;
       BFirst:=False;
     end
     else   //
     if (BFirst = True) then
     begin
        _findCondOP(@ArgArr[i-1],CondOP);
        SArgIff:=IF_Name+'('+CaseVar+CondOP+ArgArr[i-1]+','+ArgArr[i]+')';
        i:=i-2;
        BFirst:=False;
     end
     else
     begin
        _findCondOP(@ArgArr[i-1],CondOP);
        SArgIff:=IF_Name+'('+CaseVar+CondOP+ArgArr[i-1]+','+ArgArr[i]+','+SArgIff+')';
        i:=i-2;
     end;




  end;   //while



 Delete(PSM^,pf,lens+1);
 Insert(SArgIff,PSM^,pf);
 Insert(SaveExpr,PSM^,pf);
 cp:=cp+Length(SaveExpr+Case_Name+'(');

 goto nxt1;


  if _CheckSyntaxExtComPS(PSM,pf,lens,1) = false then goto endp;



end;

endp:
//SFout:=SM;
end;




procedure _SyntaxExtCom_SWAPIF(SFin:String;  var SFout: String);
label endp, xch, nxt;
{
  swapif (Arg1 op Arg2) => ifp(Arg1 op Arg2, swap(Arg1,arg2))
         op = '  >, <, >=, <=, =>, =<, =, <>'
         Arg1,Arg2 - FloatVar, IntVar, ComplexVar, Arrays.
}
const
  OpNames: array[1..9] of string =
    ('>=', '=>', '<=', '=<', '<>', '><', '>', '<', '='); //sequence not to change!


var
SM,SF,S1,S2,Proc_Name,SIns,CondOP: String;
cp,NArg,lens,ps1,ps2,ps3,ps4,pf,sn,NumOp: Integer;
Bch: Boolean;
adrV: Cardinal;
VT,MT,ImU,CT,P,NArgIff: Cardinal;
ArgArr: TArrayStr;
i: Integer;
BFirst: Boolean;
ExprType: Integer;
begin
                                //swapif(x>y)
cp:=1;
Proc_Name:='swapif';

nxt:
_SyntaxExtCom_FindArgArrPS(@SFin,Proc_Name,_proc,cp,NArg,lens,pf,ArgArr);


if  Lib_ErrorCode <> 0 then goto endp;

if NArg > 0 then
begin

  if NArg > 1 then
  begin
     Lib_ErrorCode:=E_INCOINCIDENCE_NUMBER_OF_ARGUMENTS;
     Lib_ErrorString:=copy(SFin,pf,lens+1);
     goto endp;
  end;

 for i := 1 to 9 do
 begin
    p:=Pos(OpNames[i],ArgArr[0]);

    if p > 0 then
    begin
       if i <= 6 then sn:=2 else sn:=1;
       NumOp:=i;
       goto xch;
    end;

 end;

 //swapif(vd[k]>=vd[j]); swapif(x>=vd[j]); swapif(vd[k]>=vd[j]) ; swapif(vd[k]<vd[j]); swapif(vd[k]>=y);
 //ttt; swapif(vd[k]>=vd[j]); tt; swapif(x>=vd[j]); t; swapif(vd[k]>=vd[j]) ; tttttt;  swapif(vd[k]<vd[j]); ttttt; swapif(vd[k]>=y); tt;
 //ttt; swapif(x>y); t

 xch:
 S1:=Copy(SFin,pf+Length(Proc_Name)+1,p-1);
 S2:=Copy(SFin,pf+Length(Proc_Name)+Length(S1)+1+sn,lens-(Length(Proc_Name)+Length(S1)+sn+1));
 Delete(SFin,pf,lens+1);
 SIns:='ifp('+S1+OpNames[i]+S2+',swap('+S1+','+S2+'))';
 Insert(SIns,SFin,pf);
 cp:=cp+Length(SIns);

 goto nxt;
end;



 endp:
 SFout:=SFin;
end;



procedure _SyntaxExtCom(S1: String; var S2: String);
label endp,endp1;
var
SM,Sifp,SF,SFD,SW: String;
b1,b2,i,cp: Integer;
begin


SM:=S1;
b1:=0; b2:=0; cp:=1;
for i:=1 to Length(S1) do
begin
 if S1[i] = '(' then inc(b1);
 if S1[i] = ')' then inc(b2);
end;

if (b2-b1) <> 0 then
begin
 Lib_ErrorCode:=E_MISSING_ROUND_BRACKET;
 Lib_ErrorString:=S1;
 goto endp;
end;


LabCount:=1;
IntrnlVarCount:=0;

try
{.359}
//_SyntaxExtCom_SWAPIF(SM,SM);           if Lib_ErrorCode <> 0 then  goto endp1;

_SyntaxExtCom_CASEP_PS(@SM, _proc);    if Lib_ErrorCode <> 0 then  goto endp1;
_SyntaxExtCom_WHILE_PS(@SM);           if Lib_ErrorCode <> 0 then  goto endp1;
_SyntaxExtCom_FORDOWN_PS(@SM);         if Lib_ErrorCode <> 0 then  goto endp1;
_SyntaxExtCom_FOR_PS(@SM);             if Lib_ErrorCode <> 0 then  goto endp1;
_SyntaxExtCom_MULTIIFF_PS(@SM,_func);  if Lib_ErrorCode <> 0 then  goto endp1; //multiiff
_SyntaxExtCom_MULTIIFF_PS(@SM,_proc);  if Lib_ErrorCode <> 0 then  goto endp1; //multiifp
_SyntaxExtCom_IF_PS(@SM);              if Lib_ErrorCode <> 0 then  goto endp1; //!!! after all !!!

_SyntaxExtCom_CorrectLabPS(@SM);       if Lib_ErrorCode <> 0 then  goto endp1;
_SyntaxExtComReplaceIfName(SM,SM);

endp1:
except
 on E:  EAccessViolation do Lib_ErrorCode:=E_INTERNAL_ERROR;
end;

//if(x<y, if(x>t,x=x+1), if(x>=y,x=x-1)); x
endp:
S2:=SM;
end;






{.323}
procedure FindFalseBracketInMulti(PS: PString);
label endp,endp1;
var
b1,b2,i,cp,p1,p2,p3,p4,p5,p6,p7,L,np,cb,pif: Integer;
arn: array of integer;
Bl: Boolean;
begin
b1:=0; b2:=0; cp:=1;  np:=0; cb:=0;

p1:=Pos('ifp(',PS^);        if p1 <> 0 then  inc(np);
p2:=Pos('for(',PS^);        if p2 <> 0 then  inc(np);
p3:=Pos('fordown(',PS^);    if p3 <> 0 then  inc(np);
p4:=Pos('while(',PS^);      if p4 <> 0 then  inc(np);
p5:=Pos('multiiff(',PS^);   if p5 <> 0 then  inc(np);
p6:=Pos('multiifp(',PS^);   if p6 <> 0 then  inc(np);
p7:=Pos('case(',PS^);      if p7 <> 0 then  inc(np);

Bl:=True;
if (p1 = 0) and (p2 = 0) and (p3 = 0) and (p4 = 0) and (p5 = 0) and (p6 = 0) and (p7 = 0) then Bl:=False;




if np = 0 then L:= Length(PS^)
else
begin
 SetLength(arn,np);   np:=0;
 if (p1 <> 0)then begin  arn[np]:=p1; inc(np); end;
 if (p2 <> 0)then begin  arn[np]:=p2; inc(np); end;
 if (p3 <> 0)then begin  arn[np]:=p3; inc(np); end;
 if (p4 <> 0)then begin  arn[np]:=p4; inc(np); end;
 if (p5 <> 0)then begin  arn[np]:=p5; inc(np); end;
 if (p6 <> 0)then begin  arn[np]:=p6; inc(np); end;
 if (p7 <> 0)then begin  arn[np]:=p7; inc(np); end;

 L:=arn[0];
 for i := 0 to Length(arn)-1 do
 begin
   if L > arn[i] then L:=arn[i];
 end;

end;

for i:=1 to L do
begin
 if PS^[i] = '(' then inc(b1);
 if PS^[i] = ')' then inc(b2);
 if (b1 = 1) and (cb = 0) then  cb:=i;

 if (PS^[i] = ';')  then
 begin
    if  (b2-b1 <> 0) then
    begin
      Lib_ErrorCode:=E_MISSING_ROUND_BRACKET;
      Lib_ErrorString:=Copy(PS^,cp,i-cp+1);
      if Bl = True then goto endp;
    end
    else
      cp:=i+1;
 end;

 {.346}
 if (Bl = False) and (Lib_ErrorCode <> 0) then
 begin
    if (b2-b1 = 0) then             //x*if(x>=y,y=x+1; y=x+2)+y    if(x>=y,y=x+1; proc1(x))
    begin
         Lib_ErrorCode:=E_WRONG_EXPRESSION;
         Lib_ErrorString:=Copy(PS^,cb,i-cb+1);
         pif:=Pos('iff(',PS^);
         if (pif > 0) and  (pif = cb-3)  then Lib_ErrorString:='iff'+Lib_ErrorString
         else
         begin
           pif:=Pos('if(',PS^);
           if (pif > 0) and (pif = cb-2)  then Lib_ErrorString:='if'+Lib_ErrorString;
         end;
         goto endp;
    end;
 end;


end;


endp:
end;



procedure FindMissingSemiOperInMultiPS(PS: PString; _bp: Integer);
label endp;
var
k,bp,ep,L,br,bs,bc,LC: Integer;
begin

  L:=Length(PS^);
  br:=0; bs:=0; bc:=0;
  for k := _bp to L-1 do
  begin

   if PS^[k] = '(' then br:=br-1   else
   if PS^[k] = ')' then br:=br+1   else
   if PS^[k] = '[' then bs:=bs-1 else
   if PS^[k] = ']' then bs:=bs+1 else
   if PS^[k] = '{' then bc:=bc-1 else
   if PS^[k] = '}' then bc:=bc+1;

   if  (br = 0) and (bs = 0) and (bc = 0) then
   begin

    if (PS^[k] = ')')  then
       if PS^[k+1] in EnableNameSymb = True then
       begin
           Lib_ErrorCode:=E_MISSING_SEPARATOR;
           LC:=10;                               // 10 - условно
           if k > LC then bp:=k-LC else bp:=1;
           if k+LC < L then ep:=k+LC else ep:=L;

           Lib_ErrorString:=Copy(PS^,bp,ep-bp+1);
           goto endp;
       end;

   end;

  end;

  endp:
end;








function FalseRoundBracketInMulti(PS: PString):Boolean;


  function FindSemicolon(const S: String): integer;
  label endp;
  var              //поиск последней ';' вне круглых скобок
  i,br,tbr: Integer;
  NSC: integer;
  S1:String;
  begin
    NSC:=0;
    br:=0; tbr:=0;
    for i := 1 to Length(S) do
    begin
      if S[i] = '(' then begin  inc(br); tbr:=1; end;
      if S[i] = ')' then begin  dec(br); tbr:=2; end;

     (* if S[i] = '[' then inc(br);
      if S[i] = ']' then dec(br);

      if S[i] = '{' then inc(br);
      if S[i] = '}' then dec(br);  *)

      if (br = 0) and (S[i] = ';') and (tbr = 2) then
      begin
        NSC:=i;
        S1:=Copy(S,i,i+10);
      end;
    end;

    endp:
    FindSemicolon:=NSC;
  end;


label endp,ckl;
var
br,i,p1,p2,NL: Integer;
NAnsw: Integer;
BAnsw: Boolean;
begin

NAnsw:=0;
BAnsw:=False;

if pos(';',PS^) = 0 then goto endp;

br:=0;
for i := 1 to Length(PS^) do
begin
  if PS^[i] = '(' then inc(br);
  if PS^[i] = ')' then dec(br);
end;
if br = 0 then   goto endp;

BAnsw:=True;


//
p1:=1;

ckl:
if p1 = Length(PS^) then
begin
   NL:=Length(PS^);
   if NL > 50 then NL:=50;// 50 -условно
   Lib_ErrorString:='in expression:   '+Copy(PS^,1,NL)+' ...';
   goto endp;
end;

p2:=PosEx(';',PS^,p1+1);
if p2 = 0 then
begin
   NL:=Length(PS^);
   if NL > 50 then NL:=50;// 50 -условно
   Lib_ErrorString:='in expression:   '+Copy(PS^,1,NL)+' ...';
   goto endp;
end;

br:=0;
for i := p1 to p2 do
begin
  if PS^[i] = '(' then inc(br);
  if PS^[i] = ')' then dec(br);
end;

if br <> 0 then
begin
   {NAnsw:= FindSemicolon(PS^);
   if NAnsw = 0 then NAnsw:=1; }
   NL:=p2-p1; if NL > 50 then NL:=50;// 50 -условно

   Lib_ErrorString:='in expression:   '+Copy(PS^,p1,NL)+' ...';
   goto endp;

end
else
begin
  p1:=p2;
  goto ckl;
end;




endp:
FalseRoundBracketInMulti:=BAnsw;
end;




procedure CheckFalseBlank(S: String; var S1: String);      {.195}

  function FindEnableName(const S: String; p: integer): Boolean;
  var
    S1: String;
    I,L,pb,pe: Integer;
    ENN: Boolean;
  begin
    L:=Length(S);
    ENN:=False;

    pb:=p;
    repeat
     dec(pb);
    until (pb < 1) or (S[pb] =':');

    pe:=p;
    repeat
     inc(pe);
    until (pe >= L) or (S[pe] =';') or (S[pe] = ')') or (S[pe] = '=');

    S1:=Copy(S,pb+1,pe-pb-1);
    DeleteSpace(S1,S1);


    //S1:=StringReplace(S1,#9,'',[rfReplaceAll, rfIgnoreCase]);
    S1:=StringReplace(S1,' ','',[rfReplaceAll, rfIgnoreCase]);
    S1:=StringReplace(S1,';;',';',[rfReplaceAll, rfIgnoreCase]);

    for I := 0 to Length(VarTypeList{SNSpace})-1 do
    begin
      if {LowerCase(S1) = SNSpace[i]} S1 = {SNSpace[i]}VarTypeList[i].TypeName then ENN:=True;
    end;

    FindEnableName:=ENN;
  end;



label lab1, lab2;
label endp;
//const FalseSymb = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','1','2','3','4','5','6','7','8','9','0','.','_'];

var
St1,St2: String;
pb,bs,MaxES,i,j,p1,p2: Integer;
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

S:=StringReplace(S,'  ',' ',[rfReplaceAll, rfIgnoreCase]);    //2space->1space
{
pb:=pos('  ',S); //2space
while pb <> 0 do
begin
 Delete(S,pb,1);
 pb:=pos('  ',S); //2space
end;
}


for i:= 2 to Length(S)-1 do
begin

  if S[i] = ' ' then
  begin
    if (S[i-1] in {FalseSymb}{EnableNameSymb}ControlSpaceSymb = True) and (S[i+1] in {FalseSymb}{EnableNameSymb}ControlSpaceSymb = True) then
    begin
      {bs:=min(pb,Length(S)-i);
      if bs > MaxES  then  bs:=MaxES;
      SError:=Copy(S,i-MaxES,2*MaxES);}

      for j := i downto 1 do
      begin
        if S[j] <> ' ' then
        begin
          if S[j] in {FalseSymb}{EnableNameSymb}ControlSpaceSymb = False then  begin  p1:=j; goto lab1; end;
        end;
      end;
      p1:=1;


      lab1:
      for j := i to Length(S) do
      begin
        if S[j] <> ' ' then
        begin
          if S[j] in {FalseSymb}{EnableNameSymb}ControlSpaceSymb = False then  begin p2:=j; goto lab2; end;
        end;
      end;
      p2:=Length(S);

      lab2:
      if FindEnableName(S,i) = False then
      begin
        Lib_ErrorString:=Copy(S,p1,p2-p1+1);
        Lib_ErrorCode:=E_INCORRECT_SPACE;
        goto endp;
      end;

      //Delete(S,pb,1);
    end;
  end;

end;


{
pb:=pos(' ',S); //1space
while pb <> 0 do
begin
 Delete(S,pb,1);
 pb:=pos(' ',S); //1space
end;


pb:=pos(';;',S);
while pb <> 0 do
begin
 Delete(S,pb,1);
 pb:=pos(';;',S);
end;
}

S:=StringReplace(S,' ','',[rfReplaceAll, rfIgnoreCase]);
S:=StringReplace(S,';;',';',[rfReplaceAll, rfIgnoreCase]);
if S[Length(S)] = ';' then  Delete(S,Length(S),1);
if S[1] = ';' then Delete(S,1,1);

S1:=S;
endp:
end;


procedure CheckSpace(PExpr: PString);
begin

 if F_FindWrongSpace = True then CheckFalseBlank(PExpr^,PExpr^)
    else DeleteSpaceP(PExpr);

 //PExpr^:=StringReplace(PExpr^,' ','',[rfReplaceAll, rfIgnoreCase]);
 //DeleteSpace(S,S);


 if PExpr^ = '' then
 begin
    Lib_ErrorCode:=E_VOID_EXPRESSION;
    Lib_ErrorString:='';
 end;


end;


 {.347}
function CheckSyntaxErrorPS(PExpr: PString; CheckMode: Integer): Boolean;

  function FindEQ(const S: String): Boolean;
  label endp;
  var              //поиск '=' вне  скобок
  i,br: Integer;
  BEQ: Boolean;
  begin
    BEQ:=False;
    br:=0;
    for i := 1 to Length(S)-1 do
    begin
      (*
      if S[i] = '(' then inc(br) else          {.369}
      if S[i] = ')' then dec(br) else

      if S[i] = '[' then inc(br) else
      if S[i] = ']' then dec(br) else

      if S[i] = '{' then inc(br) else
      if S[i] = '}' then dec(br);
      *)

      if S[i] in OpenBracket then  inc(br)
      else
      if S[i] in CloseBracket then dec(br);

      if (br = 0) and (S[i] = '=') then
      begin
        BEQ:=True;
        goto endp;
      end;
    end;

    endp:
    FindEQ:=BEQ;
  end;


  function CheckCurlBracketPS(PS: PString): Boolean;
  var
    i,br: Integer;
    BEQ: Boolean;
  begin
      BEQ:=False;
      br:=0;
      for i := 1 to Length(PS^) do
      begin
          if PS^[i] = '{' then inc(br) else
          if PS^[i] = '}' then dec(br);
      end;

      if br = 0 then BEQ:=True;
      CheckCurlBracketPS:=BEQ;
  end;


label endp;
var                                         //CheckMode = CM_WholeExpr; CM_DiffExpr; CM_Name; CM_OnlySpace;  CM_DiffTemplate
Answ: Boolean;
Nbr,NL: Integer;
begin
{    Предварительная проверка на синтаксические ошибки;
  !!!Конвертация команд SYNTAX EXTENDED COMMAND: for,fordown,ifp,iff,casep,while,multiiff,multiifp

}
Answ:=True;
ClearError;
              {CASE}

 //if Foreval.LeadToLowerCase = True then PExpr^:=LowerCase(PExpr^);

 PExpr^:=StringReplace(PExpr^,#9,'',[rfReplaceAll, rfIgnoreCase]);

 if Foreval.CurlyBracketToFrac = False then
 begin

    if CheckCurlBracketPS(PExpr) = False then  {.395}
    begin
       Lib_ErrorCode:=E_MISSING_CURLY_BRACKET;
       Lib_ErrorString:=PExpr^;
       goto endp;
    end;

    PExpr^:=StringReplace(PExpr^,'{','(',[rfReplaceAll, rfIgnoreCase]);
    PExpr^:=StringReplace(PExpr^,'}',')',[rfReplaceAll, rfIgnoreCase]);
 end;


 if CheckMode = CM_Name then
 begin
   Answ:=CheckNamePS(PExpr);
   goto endp;
 end;

 CheckDisableSymbPS(PExpr);
 if Lib_ErrorCode <> 0 then
 begin
     {Foreval.SyntaxErrorString:=Lib_ErrorString;
     Foreval.SyntaxError:=Lib_ErrorCode;
     Foreval.IntException;}
     goto endp;
 end;

  CheckSpace(PExpr);
  if Lib_ErrorCode <> 0 then
  begin
     {Foreval.SyntaxErrorString:=Lib_ErrorString;
     Foreval.SyntaxError:=Lib_ErrorCode;
     Foreval.IntException; }
     goto endp;
  end;

  if CheckMode = CM_OnlySpace then goto endp;




 if (CheckMode = CM_DiffExpr) or (CheckMode = CM_DiffTemplate) then
    if pos(';',PExpr^) > 0 then
    begin
       Lib_ErrorCode:=E_NO_DIFF_SYMBOLIC;
       Lib_ErrorString:=PExpr^;
       goto endp;
    end;

 (*
 CheckAndReplaceAbsBrPS(PExpr);
 if Lib_ErrorCode <> 0 then
   begin
     {Foreval.SyntaxErrorString:=Lib_ErrorString;
     Foreval.SyntaxError:=Lib_ErrorCode;
     Foreval.IntException; }
     goto endp;
 end;
 *)


//S:=Copy(S1,1,Length(S1));                          //x=if(y<x,t,goto(2)); x



if (CheckMode = CM_WholeExpr) then
begin

   {.357}
 if FalseRoundBracketInMulti(PExpr) = True then
 begin
   { Lib_ErrorCode:=E_MISSING_ROUND_BRACKET;
    NL:=Length(PExpr^)-NSC;
    if NL > 15 then NL:=15; //15 - условно
    Lib_ErrorString:='beginning with:    '+Copy(PExpr^,NSC+1,NL)+' ...';  }
    Lib_ErrorCode:=E_MISSING_ROUND_BRACKET;
   { NL:=Length(PExpr^);
    if NL > 50 then NL:=50;//50 - условно
    Lib_ErrorString:='in expression:   '+Copy(PExpr^,1,NL)+' ...';  }
    goto endp;
 end;

 //x=y+t; z1=x*(z1-(y+t()); z1+x
 FindFalseBracketInMulti(PExpr);
 if Lib_ErrorCode <> 0 then
 begin
    {Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;}
    goto endp;
 end;

 {.383}
 FindMissingSemiOperInMultiPS(PExpr,1);
 if Lib_ErrorCode <> 0 then
 begin
    {Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;}
    goto endp;
 end;

end;


{
CASE (_SyntaxExtCom_CASEP) может устанавливать внутр. переменную перед её определением.
т.е. переменная определяется в коде перед case, но в данной процедуре  _SyntaxExtCom это не учитывается
Определение переменных , заданных в коде идёт только при компиляции
}
if F_EXTENDED_COMMAND = True then
begin
  _SyntaxExtCom(PExpr^,PExpr^);
  if Lib_ErrorCode <> 0 then
  begin
    {Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;}
    goto endp;
  end;
end;


if F_MULTI_EXPR = False then
begin
   if pos(';',PExpr^) <> 0 then
   begin
     Lib_ErrorCode:=E_MULTI_EXPR_DISABLE;
     Lib_ErrorString:=PExpr^;
     goto endp;
   end
end;



if CheckMode = CM_DiffExpr then
begin
   if pos(';',PExpr^) <> 0 then
   begin
     Lib_ErrorCode:=E_NO_DIFF_SYMBOLIC;
     Lib_ErrorString:=PExpr^;
   end
   else
   if FindEQ(PExpr^) = True then    {.357}
   begin
     Lib_ErrorCode:=E_NO_DIFF_SYMBOLIC;
     Lib_ErrorString:=PExpr^;
   end
   else
   begin
      //отлов ошибок перед дифф-ем, т.к. дерево дифф-я выражения  составляется по упрощённой схеме
     Foreval.CheckSyntax(PExpr^,PExpr^);
     Lib_ErrorCode:=Foreval.SyntaxError;
     if Lib_ErrorCode <> 0 then Lib_ErrorString:=Foreval.SyntaxErrorString
     else Lib_ErrorString:=PExpr^;
   end;
end;


if CheckMode = CM_DiffTemplate then
begin
  if pos(';',PExpr^) <> 0 then
   begin
     Lib_ErrorCode:=E_NO_DIFF_SYMBOLIC;
     Lib_ErrorString:=PExpr^;
   end
end;


endp:
if Lib_ErrorCode <> 0 then
begin
    {Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;}
    Answ:=False;
end;
   CheckSyntaxErrorPS:=Answ;
end;



procedure CheckAndReplaceAbsBrPS(PExpr: PString);
var
 pabs: integer;
begin

  pabs:=pos('|',PExpr^);
  if (pabs <> 0) and (Foreval.PipeBracketToAbs = False) then
  begin
       Lib_ErrorCode := E_PROHIBITED_SYMBOL;
       Lib_ErrorString:='|';
       //Foreval.SyntaxError:=Lib_ErrorCode;
       //Foreval.SyntaxErrorString:=Lib_ErrorString;
       //Foreval.IntException;
       //goto endp;
  end
  else
  begin
      Foreval.ReplaceAbsBrP(PExpr);
  end;

end;



procedure CheckDisableSymbPS(PExpr: PString);
label endp;
var
 EnName: set of  Char;
 i,pabs,shft,b1,b2: integer;
begin

if PExpr^ = '' then
begin
 Lib_ErrorCode :=E_VOID_EXPRESSION;
 Lib_ErrorString:='';
 //Foreval.IntException;
end
else
begin
   //EnName:=['@','$','#','&'];
   //EnName:=['$','#'];       {.347}
   for i := 1 to Length(PExpr^) do
   begin
    if PExpr^[i] in ProhibitedSymb then
    begin
      shft:=10; // условно
      //Foreval.SyntaxError:=E_WRONG_SYMBOL;
      Lib_ErrorCode := E_PROHIBITED_SYMBOL;

      if i-shft <= 0 then b1:=1 else b1:=i-shft;
      if i+shft >= Length(PExpr^) then b2:=Length(PExpr^) else b2:=i+shft;


      //Lib_ErrorString:=PExpr^;
      Lib_ErrorString:=Copy(PExpr^,b1,2*shft);


      //SetString(Lib_ErrorString,ProhibitedSymb,Length(ProhibitedSymb));
      //Foreval.SyntaxErrorString:=Copy(PExpr^,i,1);
      //Foreval.IntException;
    end;
   end;

end;



 endp:
end;





function CheckNamePS(PExpr: PString): boolean;
label endp;
var
 i: integer;
 Answ: boolean;
 fx: Extended;
begin
 Answ:=True;
 ClearError;

 PExpr^:=StringReplace(PExpr^,#9,'',[rfReplaceAll, rfIgnoreCase]);
 PExpr^:=StringReplace(PExpr^,' ','',[rfReplaceAll, rfIgnoreCase]);


if PExpr^ = '' then
begin
 Lib_ErrorCode :=E_VOID_EXPRESSION;
 Lib_ErrorString:=S_SubExpr;
 Answ:=False;
end
else                   {.365A}
if TryStrToFloat(PExpr^,fx,G_FMT) = True   then
begin
   Lib_ErrorCode := E_WRONG_NAME;
   Lib_ErrorString:=PExpr^;
   Answ:=False;
end
else
begin

   if Foreval.EnableCheckName = True then
   begin
      for i := 1 to Length(PExpr^) do
      begin
        if not (PExpr^[i] in EnableNameSymb)then
        begin
          Lib_ErrorCode := E_PROHIBITED_SYMBOL;
          Lib_ErrorString:=PExpr^[i] + #13#10+ ' in: ' + #13#10+  PExpr^;
          Answ:=False;
          goto endp;
        end
      end;

      {.379}
      if  Length(StringReplace(PExpr^,'_','',[rfReplaceAll, rfIgnoreCase])) = 0 then
      begin
        Lib_ErrorCode := E_WRONG_NAME;
        Lib_ErrorString:=PExpr^;
        Answ:=False;
      end;

   end;

end;

endp:
  CheckNamePS:=Answ;
end;



{.378}
function CheckUsedFuncNamePS(PExpr: PString; ChName: Boolean): boolean;
var
 IDN: Integer;
begin
   if ChName = False then
   begin
     CheckUsedFuncNamePS:=true
   end
   else
   begin
    Foreval.FindFuncA(PExpr^,IDN);
    if IDN = _NOT_FOUND then CheckUsedFuncNamePS:=true else
    begin
      CheckUsedFuncNamePS:=false;
      Lib_ErrorCode :=E_NAME_ALREADY_USED;
      Lib_ErrorString:=PExpr^;
    end;
   end;
end;



{.378}
function CheckUsedVarName(VName: String; ChName: Boolean): boolean;
var
 IdType,MType: Cardinal;
 Addr: TAddress;

begin
    if ChName = False then
   begin
     CheckUsedVarName:=true
   end
   else
    begin
    Foreval.ExistVar(VName, Addr, IdType, MType);
    if Addr = 0  then CheckUsedVarName:=true else
    begin
      CheckUsedVarName:=false;
      Lib_ErrorCode :=E_NAME_ALREADY_USED;
      Lib_ErrorString:=VName;
    end;
   end;
end;



procedure DeleteExternalBracketPS(PS: PString);
label outf,nxt,endp;
var
b,i,bp,L:Integer;
//Answ: Boolean;
begin


//Answ:=False;
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

 //Answ:=True;
 Delete(PS^,L,1);
 Delete(PS^,1,1);
 goto nxt;
end;




endp:
//DeleteExternalBracketPS:=Answ;
end;


function FindAssign(PS1,PS1a,PS1b: PString): Boolean;
var
Answ: Boolean;
P,L: Cardinal;
begin
Answ := False;
L:=Length(PS1^);
P:=Pos('=',PS1^);
if P > 0 then
begin
 PS1a^:=Copy(PS1^,1,P-1);
 PS1b^:=Copy(PS1^,P+1,L-P);
 Answ:=True;
end;

FindAssign:=Answ;
end;







procedure _LibError;
begin
 if Lib_ErrorCode <> 0 then
 begin
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.IntException;
 end;
end;



function _ConvertAttr: Boolean;
var
RVT: Integer;
begin

RVT:=0;

if GC_PAtr = nil then
begin
  G_Atr.FType:=0;
  G_Atr.AddrRE:=0;
  G_Atr.AddrIM:=0;
  _ConvertAttr:=True;
end
else
begin
  G_Atr.FType:=0;
  G_Atr.AddrRE:=0;
  G_Atr.AddrIM:=0;

  case GC_PAtr^.MType of
   fl_SINGLE:            G_Atr.FType:=_Single;
   //fl_INTEGER:           G_Atr.FType:=_Integer;
   fl_DOUBLE:            G_Atr.FType:=_Double;
   fl_EXTENDED:          G_Atr.FType:=_Extended;
   {.357}
   fl_COMPLEX_DOUBLE:    begin G_Atr.FType:=_Double;   RVT:= T_Complex; end;
   fl_COMPLEX_EXTENDED:  begin G_Atr.FType:=_Extended; RVT:= T_Complex; end;
   fl_REAL_DOUBLE:       begin G_Atr.FType:=_Double;   RVT:= T_Real;    end;
   fl_REAL_EXTENDED:     begin G_Atr.FType:=_Extended; RVT:= T_Real;    end;
  end;
  G_Atr.AddrRE:= Cardinal(GC_PAtr^.AddrRE);
  G_Atr.AddrIM:= Cardinal(GC_PAtr^.AddrIM);


  if (G_Atr.AddrRE = 0) or (G_Atr.FType = 0) or ((RVT = T_Complex) and (G_Atr.AddrIM = 0))
  then
  begin
    Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
    Lib_ErrorCode:=E_WRONG_PASSED_DATA;
    Lib_ErrorString:=S_Current_Expression;
    _ConvertAttr:=False;
  end
  else
    _ConvertAttr:=True;

end;

end;




procedure _Compile(Expr: String; var Func: Pointer);
label endp;
var
FS: TFunction;
NS,RVT: Cardinal;
S,S1: String;
BME,BRF,ShEx: Boolean;
BRFnc,BROps,BRFncCF: Boolean;
B_CheckMultiExpr: boolean;

begin

{
ClearError;
CheckSyntaxErrorPS(@S);
if Lib_ErrorCode <> 0 then
begin
    Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;
    goto endp;
end;
}


//S:=StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);   {.221}

S:=Expr;
S_Current_Expression:=Copy(S,1,Length(S));
Func:=nil;       {.375C}

//{.347}
//Convert String!!!  and check Syntax



//if Foreval.LeadToLowerCase = True then S:=LowerCase(S); {.221}

(*
if F_FindWrongSpace = True then      {.195}
begin
  CheckFalseBlank(S,S);
  if Lib_ErrorCode <> 0 then
  begin
    Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;
    goto endp;
  end;
end
else
DeleteSpace(S,S);

{.333}
if S = '' then
begin
   Foreval.SyntaxError:=E_VOID_EXPRESSION;
   Foreval.IntException;
   goto endp;
end;


//x=y+t; z1=x*(z1-(y+t()); z1+x
FindFalseBracketInMulti(@S);    {.323}
if Lib_ErrorCode <> 0 then
begin
    Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;
    goto endp;
end;


//S:=Copy(S1,1,Length(S1));                          //x=if(y<x,t,goto(2)); x


if _EXTENDED_COMMAND = True then
begin
  _SyntaxExtCom(S,S);
  if Lib_ErrorCode <> 0 then
  begin
    Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;
    goto endp;
  end;
end;
*)



{.324}

{.357}
if _ConvertAttr = False then goto endp;
(*
if GC_PAtr = nil then
begin
  G_Atr.FType:=0;
  G_Atr.AddrRE:=0;
  G_Atr.AddrIM:=0;
end
else
begin
  G_Atr.FType:=0;
  G_Atr.AddrRE:=0;
  G_Atr.AddrIM:=0;

  case GC_PAtr^.MType of
   fl_SINGLE:            G_Atr.FType:=_Single;
   //fl_INTEGER:           G_Atr.FType:=_Integer;
   fl_DOUBLE:            G_Atr.FType:=_Double;
   fl_EXTENDED:          G_Atr.FType:=_Extended;
   {.357}
   fl_COMPLEX_DOUBLE:    begin G_Atr.FType:=_Double;   RVT:= T_Complex; end;
   fl_COMPLEX_EXTENDED:  begin G_Atr.FType:=_Extended; RVT:= T_Complex; end;
   fl_REAL_DOUBLE:       begin G_Atr.FType:=_Double;   RVT:= T_Real;    end;
   fl_REAL_EXTENDED:     begin G_Atr.FType:=_Extended; RVT:= T_Real;    end;
  end;
  G_Atr.AddrRE:= Cardinal(GC_PAtr^.AddrRE);
  G_Atr.AddrIM:= Cardinal(GC_PAtr^.AddrIM);


  if (G_Atr.AddrRE = 0) or (G_Atr.FType = 0) or ((RVT = T_Complex) and G_Atr.AddrIM = 0))
  then
  begin
    Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
    Lib_ErrorCode:=E_WRONG_PASSED_DATA;
    Lib_ErrorString:=S_Current_Expression;
    goto endp;
  end;

end;
*)


(*
{.357}
if F_PACKAGE_COMPILE = True then
begin
 _CreatePackageExpression(S,G_Atr);
 goto endp;
end;
*)

 //BME:=False; {.193}
B_CheckMultiExpr:=_CheckMultiExpr(@S); {.231} {.357}

if {(pos(';',S) > 0) or (pos('=',S) > 0)} B_CheckMultiExpr = True then    {.213}
begin
 try
  _CompileMultiExpr(S,S);
 except
    on E:  EAccessViolation do Lib_ErrorCode:=E_INTERNAL_ERROR;
 end;
  if Lib_ErrorCode <> 0 then
  begin
    {Foreval.SyntaxErrorString:=Lib_ErrorString;
    Foreval.SyntaxError:=Lib_ErrorCode;
    Foreval.IntException;}

    //_LibError;
    goto endp;
  end;
  //BME:=True;   {.193}
end;


   if (B_CheckMultiExpr = True) and (F_REPLACE_MULTI_EXPR = False)  then   {.231}
   begin
       BRFnc:=Foreval.ReplaceFuncs;           {.221}
       BROps:=Foreval.ReplaceOps;
       BRFncCF:=Foreval.ReplaceFuncsCF;
       //if BME = True then  Foreval.ReplaceFuncs:=False;    {.193}
       Foreval.ReplaceFuncs:=False;
       Foreval.ReplaceOps:=False;
       Foreval.ReplaceFuncsCF:=False;
       ShEx:=Foreval.ShowException;   {.353} //запрет показа ошибок при промежуточном разборе
       Foreval.ShowException:=False;
     Foreval.SetExtExpression(S,G_Atr,FS,NS);
       Foreval.ReplaceFuncs:=BRFnc;
       Foreval.ReplaceOps:=BROps;
       Foreval.ReplaceFuncsCF:=BRFncCF;
       Foreval.ShowException:=ShEx;      {.353}
       //Foreval.ReplaceFuncs:=BRF;       {.193}
   end
   else
   begin
       ShEx:=Foreval.ShowException;   {.353} //запрет показа ошибок при промежуточном разборе
       Foreval.ShowException:=False;
     Foreval.SetExtExpression(S,G_Atr,FS,NS);
       Foreval.ShowException:=ShEx;      {.353}
   end;


   if Foreval.SyntaxError = 0 then
   begin
      SetLength(CompZ,Length(CompZ)+1);
      CompZ[High(CompZ)].Func:=FS;
      CompZ[High(CompZ)].R_Type:=Foreval.ResultType;
      if Foreval.DinLoadOverFlow = True then
      begin
       CompZ[High(CompZ)].CmplOverFlow:=1;
       CmplOverFlow:=1;
      end
      else
      begin
       CompZ[High(CompZ)].CmplOverFlow:=0;
       CmplOverFlow:=0;
      end;
      CompZ[High(CompZ)].CmplSDeep:=Foreval.MaxLoadStack;
      CompZ[High(CompZ)].DinLoadNMem:=Foreval.DinLoadNMem;
      CompZ[High(CompZ)].DinLoadSDeep :=Foreval.DinLoadSDeep;
      CompZ[High(CompZ)].ReplFuncNum:=Foreval.ReplFuncNum;
      CompZ[High(CompZ)].ReplOpNum:=Foreval.ReplOpNum;
      CompZ[High(CompZ)].LoadStackAfterCalc:=Foreval.LoadStackAfterCalc;
      CompZ[High(CompZ)].XchBrNXch:=Foreval.XchBrNXch;
      CompZ[High(CompZ)].XchBrSDeep:=Foreval.XchBrSDeep;
      CompZ[High(CompZ)].CalcConstFunc:=Foreval.CalcConstFunc;        {.315}
      CompZ[High(CompZ)].CalcConstArg:=Foreval.CalcConstArg;          {.315}
      CompZ[High(CompZ)].CalcConstMulDiv:=Foreval.CalcConstMulDiv;    {.315}
      CompZ[High(CompZ)].CodeSize:=Foreval.CodeSize;
      CompZ[High(CompZ)].AddrMainDiffExpr:= nil;      {.379}
      CompZ[High(CompZ)].DiffNumericExpr:=fl_No;       {.379}
      CompZ[High(CompZ)].NumberReductions:=Foreval.NumberReductions;        {.395}


      CmplSDeep:=Foreval.MaxLoadStack;
      DinLoadNMem:=Foreval.DinLoadNMem;
      ReplFuncNum:=Foreval.ReplFuncNum;
      ReplOpNum:=Foreval.ReplOpNum;
      LoadStackAfterCalc:=Foreval.LoadStackAfterCalc; {.197}
      XchBrNXch:=Foreval.XchBrNXch;
      DinLoadSDeep:=Foreval.DinLoadSDeep;
      XchBrSDeep:=Foreval.XchBrSDeep;
      CalcConstFunc:=Foreval.CalcConstFunc;  {.315}
      CalcConstArg:=Foreval.CalcConstArg;
      CalcConstMulDiv:=Foreval.CalcConstMulDiv;
      CodeSize:=Foreval.CodeSize;
      NumberReductions:=Foreval.NumberReductions;


      //Func:=Pointer(CompZ[High(CompZ)].Func.ICode);  {.193}
      Func:=CompZ[High(CompZ)].Func.PAddr;
   end
   else
   begin  {.357}
      Lib_ErrorCode:=Foreval.SyntaxError;
      Lib_ErrorString:=Foreval.SyntaxErrorString;
   end;

endp:
 PopParam;
 PopVar;
 GC_PAtr := nil;
 Set8087CW(CalcCW);//in SetExExpression CW - changed    {.229}
end;








 {.357}
procedure _SetExpression(S : String;  action: Integer; var Func: Pointer);
label endp;
//var                          //action = fl_COMPILE, fl_PACKAGE_EXPRESSION, fl_CHECK_SYNTAX, fl_DIFF_EXPRESSION

begin

  S_Current_Expression:=S;
  F_CompileMode := cm_ProgrammBody;
  Func:=nil; {.375C}

  if _ConvertAttr = False then goto endp;

  if (action = fl_PACKAGE_EXPRESSIONS) and (F_PACKAGE_COMPILE = True) then
  begin
    _CreatePackageExpression(S,G_Atr);
  end
  else
  if action = fl_COMPILE  then
  begin
     _Compile(S,Func);
  end
  else
  if action =  fl_CHECK_SYNTAX  then
  begin

    if _CheckMultiExpr(@S) = True then
    begin
      try
         _CompileMultiExpr(S,S);
      except
       on E:  EAccessViolation do Lib_ErrorCode:=E_INTERNAL_ERROR;
      end;
    end;

    if Lib_ErrorCode = 0 then
    begin
       Foreval.CheckSyntax(S,S);
       Lib_ErrorCode:=Foreval.SyntaxError;
       Lib_ErrorString:=Foreval.SyntaxErrorString;
    end;

  end
  else
  if action =  fl_DIFF_EXPRESSION   then
  begin
    _SetDiffExpr(S);
  end;


endp:
end;







procedure _FindReIm(S: String; var S1:String; var TF: Integer);
var
r,i: Integer;
SR,SI,ST: String;
begin
  r:=pos('.re',S{LowerCase(S)});
  if (r <> 0) and (r = Length(S)-2) then
  begin
   TF:=_RE; S1:=Copy(S,1,Length(S)-3);
  end
  else
  begin
   i:=pos('.im',S{LowerCase(S)});
   if (i <> 0) and (i = Length(S)-2) then
   begin
    TF:=_IM; S1:=Copy(S,1,Length(S)-3);
   end
   else
   begin
    S1:=S; TF:=0;
   end;
  end;
end;







function IsCurrentSet(NS: String): Boolean;
label endp;
var
i: Integer;
begin
IsCurrentSet:=False;

  for i := 0 to Length(CurrentNameSet)-1 do
  begin
   if NS = CurrentNameSet[i] then
   begin
     IsCurrentSet:=True; goto endp;
   end;
  end;

endp:
end;


procedure WriteCurrentSet(NS: String);
var
 i: Integer;
begin
 SetLength(CurrentNameSet,Length(CurrentNameSet)+1);
 CurrentNameSet[High(CurrentNameSet)]:=NS;
end;



procedure _SetVarIntrnlA(NS: String; TypeV,MType: Integer; SrcDef: Integer; var Adr: Cardinal);
var
FD1,FD2: PInternalVar;
LS,LL,i: Integer;
SN,SV,num: String;
Bl: Boolean;
PAdr: Pointer;
begin


  new(FD1); FD1^.Next:=nil;
  FD1^.Name:=Copy(NS,1,Length(NS));

  {SetLength(FD1^.VecD,0);
  SetLength(FD1^.VecE,0);
  SetLength(FD1^.VecI,0);}

  if (TypeV = T_Real) or (TypeV = T_Complex) or (TypeV = T_Pointer) then
  begin
     PAdr:=@FD1^.Variable;
  end
  else
  if (TypeV = T_Array) then
  begin
    if (MType =_Double) then     PAdr:=@FD1^.VecD
    else
    if (MType =_Extended) then   PAdr:=@FD1^.VecE
    else
    if (MType =_Integer) then    PAdr:=@FD1^.VecI
    else
    if (MType =_Pointer) then    PAdr:=@FD1^.VecI
    else
    if (MType =_Single) then     PAdr:=@FD1^.VecS
  end;



  {Foreval.SetObject(FD1^.Name,Cardinal(@FD1^.Variable),TypeV,MType);
  Adr:=Cardinal(@FD1^.Variable);}

  Foreval.SetObject(FD1^.Name,Cardinal(PAdr),TypeV,MType,SrcDef{_Internal});
  Adr:=Cardinal(PAdr);

  InternalVarList^.Next:=FD1;
  InternalVarList:=FD1;


end;



 (*
procedure _SetIntVar(NS: String; TypeV,MType: Integer; var Adr: Cardinal);
var
FD1,FD2: PInternalVar;
LS,LL,i: Integer;
SN,SV,num: String;
Bl: Boolean;
PAdr: Pointer;
begin

if IsCurrentSet(NS) = False then      {.221}
begin
  _SetVarIntrnlA(NS,TypeV,MType,Adr);
  WriteCurrentSet(NS);
end
else           {.221}
Foreval.SyntaxError:=E_VARIABLE_REDECLARED;

end;

  *)



{.229}
procedure _SetIntVarMultiExpr(NS: String; TypeV,MType: Integer; SrcDef: Integer; var Adr: Cardinal);
var
FD1,FD2: PInternalVar;
LS,LL,i,IDN: Integer;
SN,SV,num: String;
Bl: Boolean;
PAdr: Pointer;
begin

if IsCurrentSet(NS) = False then
begin
   IDN := _NOT_FOUND;         {.378}
   if Foreval.CheckUsedName then Foreval.FindFuncA(NS,IDN);     {.378}
   if IDN = _NOT_FOUND then
   begin
      PushParam(NS);
      PushVar(NS);
      _SetVarIntrnlA(NS,TypeV,MType,SrcDef,Adr);
       WriteCurrentSet(NS);
   end
   else
   begin
      Foreval.SyntaxError:=E_NAME_ALREADY_USED;
      Lib_ErrorCode:=Foreval.SyntaxError;
      Lib_ErrorString:=NS;
   end;

end
else
begin
  Foreval.SyntaxError:=E_VARIABLE_REDECLARED;
  Lib_ErrorCode:=E_VARIABLE_REDECLARED;
  Lib_ErrorString:=NS;
end;

end;



{.347}
procedure _SetVarIntrnlS(VName: String; VType,MType:Integer; SrcDef: integer;  CheckSyntax:Boolean);
var
AdrV: Cardinal;
begin
  Foreval.EnableCheckName:=CheckSyntax;
  _SetIntVarMultiExpr(VName,VType,MType, SrcDef,AdrV);
  Foreval.EnableCheckName:=True;
end;





{.357}
procedure _SetVarIntrnlExtAddr(NS: String; TypeV, MType: Integer; AddrRe,AddrIm: Cardinal; CheckSyntax: Boolean);
var                                      //TypeV = T_Real, T_Complex, T_Array, T_Pointer
FD1,FD2: PInternalVar;                   //MType = _Double, _Extended, _Integer, _Pointer, _Single
LS,LL,i: Integer;
SN,SV,num: String;
Bl: Boolean;
PAdr: Pointer;
begin
// Только для fl_Package_Compile
//Переменные переписываются под одними и теми же именами для разных пакетов без PUSH/POP, т.к. не могут перекрывать подобные имена
//pcv#1, pcv#2,...

if ( (TypeV = T_Real) and (AddrRE <> 0) ) or ( (TypeV = T_Complex) and (AddrRE <> 0) and (AddrIM <> 0)) then
begin
  Foreval.EnableCheckName:=CheckSyntax;
    Foreval.SetObject2(NS, AddrRE, AddrIM,  TypeV, MType, _External); //переменные, заданные через Attrib по умолчанию считаются внешними
  Foreval.EnableCheckName:=True;
end
else
begin
  Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
  Lib_ErrorCode:=E_WRONG_PASSED_DATA;
  Lib_ErrorString:=S_Current_Expression;
end;

end;


{.357}
procedure _CreatePackageExpression(S: String; G_Atr:  TAttribInt);
var
 SPV: String;
 //AddrRE,AddrIM: Cardinal;
begin

  inc(N_Count_Package_Var);
  SPV:=S_PackageVarName+IntToStr(N_Count_Package_Var);
  if  G_Atr.AddrIM = 0 then
    _SetVarIntrnlExtAddr(SPV, T_Real, G_Atr.FType, G_Atr.AddrRE, G_Atr.AddrIM, False)
  else
    _SetVarIntrnlExtAddr(SPV, T_Complex, G_Atr.FType, G_Atr.AddrRE, G_Atr.AddrIM, False);

  S_Package_Expression:=S_Package_Expression+SPV+'='+S+';';

end;


{.357}
procedure   _CompilePackage(var CAddr: Pointer);
begin
   F_PACKAGE_COMPILE:=False;
   GC_PAtr := nil;
   F_CompileMode := cm_ProgrammBody ;
   _Compile(S_Package_Expression, CAddr);
   //flSet(fl_DISABLE,  fl_ALL_REPLACE,0);
   S_Package_Expression:='';
   N_Count_Package_Var:=0;
   P_PackageCompileAddr:=CAddr;
end;



procedure CheckEndString(S: String; var S1: String);
label nxt1, nxt2;
var
P: Cardinal;
begin
               // ;  ; x=1;  ;; y=x+1 ;; y ; ;

 nxt1:
 if S[1] = ';' then
 begin
  Delete(S,1,1) ;
  goto nxt1;
 end;


 nxt2:
 if S[Length(S)] = ';' then
 begin
  Delete(S,Length(S),1) ;
  goto nxt2;
 end;

 Insert(';',S,Length(S)+1);

 S1:=S;
end;




function _CheckMultiExpr(PS: PString): Boolean;
var
       b,i,P1,P2: Integer;
       Res: Boolean;
begin

       Res:=False;

       if pos(';',PS^) > 0 then Res:=True
       else
       begin
         P1:=pos('=',PS^);
         P2:=pos('(',PS^);

         if (P2 > 0) and (P1 > 0)   then
         begin
           //P1:=pos('=',S);           //x=1
           //P2:=pos('(',S);           //vd[k]=1
                                      //vd[(k+1)*2]=1
                                      //if(x=y,x,y)
           if (P1 < P2)  and (P1 > 0) then Res:=True    //vd[k]=(1+2)*3
           else                                         //vd[(k+1)*2]=(1+2)*3
           if P1 > 0 then
           begin
             b:=0;
             for i :=  P2 to P1 do
             begin
               if PS^[i] = '(' then inc(b) else
               if PS^[i] = ')' then dec(b) ;
             end;
             if  b = 0 then Res:=True else Res:=False;
           end
           else
           Res:=False;
         end
         else
         if (P2 = 0) and (P1 > 0) then Res:=True;


       end;

       _CheckMultiExpr:=Res;
end;




procedure _CompileMultiExpr(Expr: String; var SExpr1: String);
{
Если программа (выражение составное), то _CompileMultiExpr упаковывает отдельные выражения в
 виртуальную функцию-контейнер #prog(Expr1,Expr2,...,ExprN);
 А также разбирает и конвертирует выражения с присваиванием в процедуру-контейнер Save(VarRes,Arg)

}
label ckl,endp,nxt,cmpl,defvarexpr,nxtexpr;
var
FS: TFunction;
P,V,RT,TF,TypeV,MType,ni,{VT,MT,}V1,NE: Integer;
NS,Error,prv,adrv: Cardinal;
VT,MT,GVT: Cardinal;
CT: Integer;
S,SV,SF,SV1,SExpr, SFR,ST,SubExpr: String;
ASF: array of TFuncS;
Res: TComplex;
VNS: TArraySt;
ATL: TArrayI;
PF: Pointer;
EC,BH,ShEx,BNewVar,Answ,ArrayIs: Boolean;
Siu: String;
_Re,_Im: extended;
SrcDef:Integer;
begin
if Foreval.SubstNumCX = True then Siu:=Foreval.IM_UNIT_NAME else Siu:='*'+Foreval.IM_UNIT_NAME;

S:=Copy(Expr,1,Length(Expr));

if F_ClearCurrentNameSet = True then SetLength(CurrentNameSet,0); {.221}

SExpr:='';
NE:=0; //число  выражений

if S[Length(S)] = '>' then S:=S+SCnop;// else S:=S+';#nop';   S_LABEL


//RT:=0;
ExchLabl(S,S);  if Lib_ErrorCode <> 0 then  goto endp;

if F_CompileMode = cm_ProgrammBody then  SrcDef := ds_ProgrammBody else
if F_CompileMode = cm_FunctionBody then  SrcDef := ds_FunctionBody;

//P:=Pos(';',S);


ckl:
BNewVar:=False;
ArrayIs:=False;
RT:=0;     {.227}
 CheckEndString(S,S);        {.195}
 P:=Pos(';',S);              {.195}
 {SV:=Copy(S,1,P-1);
 V:=Pos('=',SV);
 SV:=Copy(S,1,V-1);
 SF:=Copy(S,V+1,P-V-1);}
 VT:=T_None;

 SV:=Copy(S,1,P-1);
 SubExpr:=SV;
 S_SubExpr:=SubExpr;

 V:=Pos('=',SV);
 SV1:=Copy(S,1,V-1);

 EC:=True;

 if (Pos('(',SV1) > 0) and (Pos('(',SV1) < V) then     //;if(arg1=arg2,,);
 begin
   if (Pos('[',SV1) > 0) and (Pos('[',SV1) < Pos('(',SV1)) then   //vd[len(vd)-1]=x; x
   begin
    SF:=Copy(SV,V+1,Length(SV)-V);
    SV:=Copy(SV,1,V-1);
    ArrayIs:=FindArray(SV,SF,SV,SF);    //vvv[len(vd)-1]=x; x  |  vvv[n+1]=x;  |  vd=x+y;
   end
   else
   begin
      //поиск и конвертация в команду Save присвоения значения по указателю: PType(PointerArg)=value -> save(PType(PointerArg),value)
     if Foreval.CheckSaveForPointer(@SV) = True then      {.367}
     begin
         if SExpr = '' then SExpr:=SV else SExpr:=SExpr+SV;
         goto  nxtexpr;
     end
     else
     begin
      SF:=SV;
      SV:='';
     end;
   end;
 end
 else
 begin
  //V:=Pos('=',SV);
{   if (V > 0) and (Foreval.CheckOperationOnCompound('=', @SV, V) = True) then
   begin
      SF:=SV;
      SV:='';
      goto cmpl;
   end;  }

   SV:=Copy(S,1,V-1);
   SF:=Copy(S,V+1,P-V-1);

   if V > 0 then        {.369} // 'x=' '=' '=x'
   begin
     if (SV = '') or (SF = '') then
     begin
       Lib_ErrorCode:=E_MISSING_EXPRESSION;
       Lib_ErrorString:=SubExpr;
       goto endp;
     end;
   end;


   V1:=Pos(':',SV);
   if V1 > 0 then                   //xx:ext = sin(x); sqrt(xx^2+cos(x))
   begin
     SV:=Copy(SV,1,V1-1);
     ST:=Copy(S,V1+1,V-V1-1); {ST:=LowerCase(Copy(S,V1+1,V-V1-1));}

     MT:=0; VT:=0;
     if   _GetTypeVar(ST,GVT,VT,MT) = False then
     begin
        Lib_ErrorCode:=E_WRONG_TYPE;{fl_INCORRECT_TYPE};
        if ST = '' then Lib_ErrorString:=SV1 else Lib_ErrorString:=ST;
        goto endp;
     end;
      //newvar:type=<expr>
      {PushVar(SV);
     _SetIntVar(SV,VT,MT,adrv); }

      if CheckNamePS(@SV) = true then   {.357}
      begin

          _SetIntVarMultiExpr(SV,VT,MT,SrcDef,adrv);  {.229}
          if Foreval.SyntaxError <> 0 then
          begin                                     {.221}
            //if Foreval.SyntaxError = E_VARIABLE_REDECLARED  then Lib_ErrorCode:=E_VARIABLE_REDECLARED else Lib_ErrorCode:=E_WRONG_NAME;
           // E_Code:=15{fl_WRONG_NAME};

             Lib_ErrorCode:=Foreval.SyntaxError;
             Lib_ErrorString:=SV;
             goto endp;
          end;

          if VT = T_Array  then
          begin
            SF:='setlen('+SV+','+SF+')'  ;
            ArrayIs:=True; {.365A}
          end;

          BNewVar:=True; //новая переменная с заданным типом

      end
      else
      begin
         {Lib_ErrorCode:=E_WRONG_NAME;
         Lib_ErrorString:=SV; }
         goto endp;
      end;

     //Foreval.SetObject(SV1,adr,VT,MT);
   end
   else
   begin
     ArrayIs:=FindArray(SV,SF,SV,SF); //array[expr1]=expr2  ->  save(vd,expr1,expr2)
     if Lib_ErrorCode <> 0  then goto endp;
   end;




 end;

  //CalcType=T_Real:
 //z1:extCX=1+2i; x:dbl=3+4;  x=z1.im;  x


 //x=1; x=if(y>x,y,goto(end)); x=3; end>>x;

cmpl:
SFR:=SF;
 //компиляция промежуточных выражений (в составном выражении) для проверки их на константу.

   {.359}
   //если новая переменная c заданным типом инициализируется простой константой, то для ускорения разбора вначале ищется константа
   //xx:ext=5; xx  | zz:extCx=2+5i; zz
 if BNewVar = True then
 begin
      Foreval.UseSaveSW:=False;    // {.365} Устранение странной ошибки, возникающей в некоторых случаях в CodeBlock16 (В остальных  CodeBlock, MSVC , Delphi ошибки нет)
   Answ:=Foreval.FindConst(SF,_Re,_Im);
      Foreval.UseSaveSW:=True; {.365}
   if Answ = True then
   begin
     Res.re:=_Re;
     Res.im:=_Im;
     SF:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT)+'+('+FloatToStrF(Res.im, ffGeneral, 20, 4, G_FMT)+')'+Siu;
     SFR:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT);
     goto defvarexpr;
   end;
 end;

     //иначе идёт поиск и вычисление сложных константных выражений
     //xx:ext=5*(2+3/(sin(4-7*pi))^2); xx  | zz:extCx=2i*(3-4i-5*(sin(2+5i))^(1+6i)); zz
 if (Foreval.CalcConstExpr = True) and (F_CalcConsExprInMulti = True) {.221}  then
 begin

     CT:=Foreval.CalcType;
     //Foreval.CalcType:=T_Complex;
     Foreval.CalcType:=T_Any; {.357}
     Foreval.EnableCalcConsExprInMulti:=True;   {.221}
     ShEx:=Foreval.ShowException;   {.353} //запрет показа ошибок при промежуточном разборе
     Foreval.ShowException:=False;
  Foreval.SetExtExpression(SF,G_Atr0,FS,NS);
     Foreval.EnableCalcConsExprInMulti:=False;   {.221}
     Foreval.CalcType:=CT;
     Foreval.ShowException:=ShEx;      {.353}

  if (Foreval.SyntaxError = 0)  then
  begin
     //calculated  if expression - const.:
    if {(Foreval.PresentVar = false)}(Foreval.CanRecompile = True) and (Foreval.EnableCalcConstExpression = True) and (Foreval.ResultType <> T_None) then
    begin
          //_ResultC(FS.Addr,Res);
          //SF:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT)+'+('+FloatToStrF(Res.im, ffGeneral, 20, 4, G_FMT)+')'+Siu;
          //SFR:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT);

          Res:=Foreval.FResult;  {.229}
                                                                                    {.357: AsIs}
         if (Foreval.ResultType = T_Real) and ((Foreval.CalcType = T_Real) or (Foreval.CalcType = T_Any)) then
           begin
            //Res.re:=_ResultR(FS.ICode);
            //SF:=FloatToStr(Res.re,G_FMT);
            SF:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT);
            SFR:=SF;
           end
           else
           begin
             //_ResultC(FS.ICode,Res);
             //SF:=FloatToStr(Res.re,G_FMT)+'+i*('+FloatToStr(Res.im,G_FMT)+')';
             SF:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT)+'+('+FloatToStrF(Res.im, ffGeneral, 20, 4, G_FMT)+')'+Siu;
             //SFR:=FloatToStr(Res.re,G_FMT);
             SFR:=FloatToStrF(Res.re, ffGeneral, 20, 4, G_FMT);
           end;


    end;

    EC:= Foreval.PresentVar;
    RT:=Foreval.ResultType;
    Foreval.FreeExtFunc(@FS);  {.225}
  end
  else
  begin
   Lib_ErrorCode:=Foreval.SyntaxError;  Lib_ErrorString:=Foreval.SyntaxErrorString;   goto endp;        {.139}
  end;
 end;
                     //x=if(y>x,t,goto(2));x   !!!!!!!!!!!!!!!!!!!!!!

                     //r1=2*sin(3*cos(pi/2+1))+1;r1
                     //x=2^3; y=x+1;y
                      //x5=2^3; x7=x5+1;x7
                     //z5.re=3^2; z5.im=2^3; z5
                     //z5.re=3^2; z5.im=Im(2^3*i); z5

defvarexpr:
 _FindReIm(SV,SV1,TF);
  Foreval.FindVar(SV1,ni);
  if ni = _ABSENT then //если новой переменной тип  не задан:   xx=5; xx  |  zz=2+3i; zz
  begin           //то установить её тип по типу выражения
    if RT = 0 then
    begin
         ShEx:=Foreval.ShowException;   {.353} //запрет показа ошибок при промежуточном разборе
         Foreval.ShowException:=False;
      Foreval.SetExtExpression(SF,G_Atr0,FS,NS);
         Foreval.ShowException:=ShEx;      {.353}
      if Foreval.SyntaxError <> 0 then
      begin
         Lib_ErrorCode:=Foreval.SyntaxError;
         Lib_ErrorString:=Foreval.SyntaxErrorString;  {.139};{Foreval.SyntaxErrorString:=SF;}
         goto endp;
      end;
      RT:=Foreval.ResultType;
      EC:= Foreval.PresentVar;
      Foreval.FreeExtFunc(@FS); {.225}
    end;
    if (TF <> 0) or (RT = T_Complex) then
    begin
     MT:=Foreval.DataType;
     VT:=T_Complex;
    end
    else
    begin
     MT:=Foreval.DataType;
     VT:=T_Real;
     //if EC = False then SF:=SFR;
    end;

     if SV1 <> '' then
     begin
       //newvar=<expr>
       {PushVar(SV1);
       _SetIntVar(SV1,VT,MT,adrv); }
       if CheckNamePS(@SV1) = true then       {.365A}
          _SetIntVarMultiExpr(SV1,VT,MT,SrcDef,adrv);  {.229}
     end;
     if Foreval.SyntaxError <> 0 then
      begin
        Lib_ErrorCode:=E_WRONG_NAME ;{fl_WRONG_NAME};
        Lib_ErrorString:=SV;
        //goto endp;
      end;
  end;


   {if (SV = '') then SExpr:=SExpr+SF
             else SExpr:=SExpr+'SAVE('+SV+','+SF+')'; }

  if (SV = '') then SExpr:=SExpr+SF
  else
  begin
      Foreval.ExistVar(SV1,adrv,VT,MT);

      if (ArrayIs = False) and (VT = T_Array) then  {.365A} //catch error: vd=x+y
      begin
        Lib_ErrorCode:=E_WRONG_EXPRESSION;
        Lib_ErrorString:=SubExpr;
        goto endp;
      end;

      if VT = T_Array then SExpr:=SExpr+SF
      else
      if VT = T_Real then
       SExpr:=SExpr+'save('+SV+','+SFR+')'    {.191}
      else
      if VT = T_Complex then
       SExpr:=SExpr+'save('+SV+','+SF+')'     {.191}
      else
      if VT = T_Pointer then
       SExpr:=SExpr+'save('+SV+','+SFR+')' ;   {.353}

  end;
  //vd[n]=pi;vd[n]
  //vd:arrayD=10;vd[n+1]



 nxtexpr:
  Delete(S,1,P);
  P:=Pos(';',S);
  if P > 0 then
  begin
   inc(NE);
   SExpr:=SExpr+',';
   goto ckl;
  end
  else
  begin
    //SExpr:=SExpr+','+S;                 //x=1; y=x
    inc(NE);
    if S <> '' then           {.195}    //x=1; y=x;
    SExpr:=SExpr+','+S;                 //x=1; y=x
    //else  SExpr:=SExpr;               //x=1; ; y=x;;  ;x+y; ;
                                        //x=1; ; y=x;;  ;z1=x+y; ;
  end;

  {.316}
  //if NE >= 1 then SExpr:='nop('+SExpr+')';    //не обязательно(NE)
  if NE >= 1 then SExpr:=SCprog+'('+SExpr+')';    //не обязательно(NE)
  //SExpr:='nop('+SExpr+')';

endp:
//PopVar;
SExpr1:=Copy(SExpr,1,Length(SExpr));
end;





procedure pcCompile(S: String; var FName: String; var FAdr: Pointer);
label 1,2,3,endp,endp1;
var
i,j: Integer;
//FS:TZAddFuncStruct;
FN: String;
LVT: TArrayI;
VN,VT,RT,PKCCM,PKRFM,PKINP,PKCCP,PKRFP,PKINM: Integer;
IDF,Er,CC,RF,INL: Cardinal;
begin

try
 CC:=0; RF:=0; INL:=0;
 PKCCP:=0; PKRFP:=0; PKINM:=0;
 PKCCM:=0; PKRFM:=0; PKINP:=0;

 3:
 PKCCM:=Pos('{$CC-}',S);
 if PKCCM = 0 then PKCCM :=   Pos('{$cc-}',S);      {.320}

 PKCCP:=Pos('{$CC+}',S);
 if PKCCP = 0 then PKCCP :=   Pos('{$cc+}',S);     {.375C}

 PKRFM:=Pos('{$RF-}',S);
 if PKRFM = 0 then PKRFM :=   Pos('{$rf-}',S);     {.320}

 PKRFP:=Pos('{$RF+}',S);
 if PKRFP = 0 then PKRFP :=   Pos('{$rf+}',S);     {.375C}


 PKINP:=Pos('{$IN+}',S);
 if PKINP = 0 then PKINP :=   Pos('{$in+}',S);     {.365}

 PKINM:=Pos('{$IN-}',S);
 if PKINM = 0 then PKINM :=   Pos('{$in-}',S);     {.375C}



 if PKCCM = 1 then
 begin
   Delete(S,1,6);
   CC:=1;
 end
 else
 if PKCCP = 1 then
 begin
   Delete(S,1,6);
   CC:=2;
 end
 else
 if PKRFM = 1 then
 begin
   Delete(S,1,6);
   RF:=1;
 end
 else
 if PKRFP = 1 then
 begin
   Delete(S,1,6);
   RF:=2;
 end
 else
 if PKINP = 1 then
 begin
   Delete(S,1,6);
   INL:=2;
 end
 else
 if PKINM = 1 then
 begin
   Delete(S,1,6);
   INL:=1;
 end;

 if (PKCCM <> 0) or (PKRFM <> 0) or (PKINM <> 0) or
    (PKCCP <> 0) or (PKRFP <> 0) or (PKINP <> 0) then goto 3;

  //for i:=0 to FDFN.MA.Lines.Capacity do
  //begin
    InitFuncStruct(G_FS);
    G_FS.SaveReg:=0; {.191}
    G_FS.CallFunc:=fl_PRECOMPILED;

    //S:=FDFN.MA.Lines[i];
    {DeleteSpace(S,S);
    if S = '' then goto 1;}


    pcConvertFuncName(S,FN,LVT,VN,VT,RT);
    if  Lib_ErrorCode <> 0 then goto endp1;

    SetLength(pcLVT,Length(LVT));
    if VT = 0 then
    begin
       for j := 0 to  High(LVT) do
       begin
         (*
         case LVT[j] of
           //1:  pcLVT[j]:=fl_single;
           2:  pcLVT[j]:=fl_REAL_DOUBLE ;
           3:  pcLVT[j]:=fl_REAL_EXTENDED;
           4:  pcLVT[j]:=fl_REAL_INTEGER ;
           //5:  pcLVT[j]:=fl_ARRAY_SINGLE ;
           6:  pcLVT[j]:=fl_ARRAY_REAL_DOUBLE ;
           7:  pcLVT[j]:=fl_ARRAY_REAL_EXTENDED ;
           8:  pcLVT[j]:=fl_ARRAY_REAL_INTEGER;
           9:  pcLVT[j]:=fl_COMPLEX_DOUBLE;
           10: pcLVT[j]:=fl_COMPLEX_EXTENDED ;
           11: pcLVT[j]:=fl_Pointer;
           12: pcLVT[j]:=fl_Array_Pointer;
         end;
         *)

         {.353}
         pcLVT[j]:=LVT[j];
       end;
       G_FS.ArgType:=fl_differ;
       G_FS.ArgTypeList:=@pcLVT[0];
    end
    else
    begin
      (*
      case VT of
           2:   G_FS.ArgType:=fl_REAL_DOUBLE ;
           3:   G_FS.ArgType:=fl_REAL_EXTENDED;
           4:   G_FS.ArgType:=fl_REAL_INTEGER ;
           //5:  pcLVT[j]:=fl_ARRAY_REAL_SINGLE ;
           6:   G_FS.ArgType:=fl_ARRAY_REAL_DOUBLE ;
           7:   G_FS.ArgType:=fl_ARRAY_REAL_EXTENDED ;
           8:   G_FS.ArgType:=fl_ARRAY_REAL_INTEGER;
           9:   G_FS.ArgType:=fl_COMPLEX_DOUBLE;
           10:  G_FS.ArgType:=fl_COMPLEX_EXTENDED ;
           11:  G_FS.ArgType:=fl_Pointer;
           12:  G_FS.ArgType:=fl_Array_Pointer;
      end;
      *)

       {.353}
      G_FS.ArgType:=VT;
    end;

    {case RT of
      1:   G_FS.ResultType:=fl_real;
      2:   G_FS.ResultType:=fl_real;
      3:   G_FS.ResultType:=fl_real;
      4:   G_FS.ResultType:=fl_complex;
      5:   G_FS.ResultType:=fl_none;
    end; }

    {.353}
    G_FS.ResultType:=RT;
    G_FS.ResultTypeMath:=fl_Extended;

    LVT:=nil;

    1:
  //end;
  if CC =  1 then G_FS.CalcConst:=fl_NO
  else
  if CC =  2 then G_FS.CalcConst:=fl_YES;

  if RF =  1 then G_FS.ReplFunc:=fl_NO
  else
  if RF =  2 then G_FS.ReplFunc:=fl_YES;

  if INL = 1 then G_FS.IsInline:=fl_NO
  else
  if INL = 2 then G_FS.IsInline:=fl_YES;

  FName:=FN;
  FAdr:=@G_FS;

endp1:

except
    on E:  EAccessViolation do
      begin
        Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION;
        Foreval.InternalError:=E_AccessViolation;
      end;
end;




endp:
end;




procedure pcConvertFuncName(S: String;  var FN: String; var LVT: TArrayI; var VN,VT,RT: Integer);
label 1, endp;
var                                                               //TV[i]=_float,_integer,_complex,_array
SF,SA,S1,S2,S3,S4,SFM,SR: String;
MA,MAN,MX,MX1: TArraySt;
br1,br2,i,L,p,L1,j: Integer;
BT: Boolean;
begin
//DeleteSpace(S,S);
try
FN:='';
P:=Pos('=',S);

if P = 0 then begin Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION; Lib_ErrorString:=S; goto endp; end;

S1:=Copy(S,1,P-1);
SFM:=Copy(S,P,Length(S)-P+1); //+ '='
RT:=2;
P:=Pos(')',S1);

if P = 0 then begin Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION; Lib_ErrorString:=S; goto endp; end;
if S1 = '' then begin Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION; Lib_ErrorString:=S; goto endp; end;

if S1 = '' then goto endp;

if p+1 < Length(S1) then  {.197}
begin
 if S1[p+1] = ':' then
 begin
  //SR:=LowerCase(Copy(S1,p+2,Length(S1)-p-1));
  SR:=Copy(S1,p+2,Length(S1)-p-1);

  if SR = 'real'       then begin RT:=fl_Real end else  {.191}
  if SR = 'complex'    then RT:=fl_Complex else
  if SR = 'none'       then RT:=fl_None else
   (*
  if SR = 'nan'                then RT:=fl_None{RT:=5}  else
  if SR = 'absent'             then RT:=fl_None{RT:=5}  else
  if SR = 'procedure'          then RT:=fl_None{RT:=5}  else
  if SR = 'proc'               then RT:=fl_None{RT:=5} else

  if SR = 'float'      then {RT:=2}begin RT:=fl_Real end  else {.191}
  if SR = 'double'     then RT:=fl_Real{RT:=2} else
  if SR = 'dbl'        then RT:=fl_Real {RT:=2} else

  if SR = 'complexofdouble'    then RT:=fl_Complex{RT:=4} else
  if SR = 'complexofdbl'       then RT:=fl_Complex{RT:=4} else
  if SR = 'doublecomplex'      then RT:=fl_Complex{RT:=4} else
  if SR = 'doubleofcomplex'    then RT:=fl_Complex{RT:=4} else
  if SR = 'complexdouble'      then RT:=fl_Complex{RT:=4} else
  if SR = 'cxdbl'              then RT:=fl_Complex{RT:=4} else
  if SR = 'dblcx'              then RT:=fl_Complex{RT:=4} else
  if SR = 'cxdouble'           then RT:=fl_Complex{RT:=4} else
  if SR = 'doublecx'           then RT:=fl_Complex{RT:=4} else
  if SR = 'complexd'           then RT:=fl_Complex{RT:=4} else
  if SR = 'tcomplexd'          then RT:=fl_Complex{RT:=4} else
  if SR = 'complexofextended'  then RT:=fl_Complex{RT:=4} else
  if SR = 'complexextended'    then RT:=fl_Complex{RT:=4} else
  if SR = 'complexofext'       then RT:=fl_Complex{RT:=4} else
  if SR = 'extendedofcomplex'  then RT:=fl_Complex{RT:=4} else
  if SR = 'extendedcomplex'    then RT:=fl_Complex{RT:=4} else
  if SR = 'complexext'         then RT:=fl_Complex{RT:=4} else
  if SR = 'cxextended'         then RT:=fl_Complex{RT:=4} else
  if SR = 'extendedcx'         then RT:=fl_Complex{RT:=4} else
  if SR = 'cxext'              then RT:=fl_Complex{RT:=4} else
  if SR = 'extcx'              then RT:=fl_Complex{RT:=4} else
  if SR = 'complexe'           then RT:=fl_Complex{RT:=4} else
  if SR = 'tcomplexe'          then RT:=fl_Complex{RT:=4} else
  if SR = 'extended'           then RT:=fl_Real{RT:=3}  else
  if SR = 'ext'                then RT:=fl_Real{RT:=3}  else
  *)

  begin
    Lib_ErrorCode:=E_WRONG_TYPE;{fl_INCORRECT_TYPE}
    if SR = ''  then Lib_ErrorString:=S1 else
    Lib_ErrorString:=SR;
    goto endp;
  end;
 end
end
else
begin
 {if Foreval.DataType = _Double then RT:=2 else RT:=3;}
 RT:=fl_Real;
end;


L:=Length(S1);
br1:=0; br2:=0;
for i := 1 to L do
begin
  if (S1[i] = '(') and (br1 = 0) then begin SF:=Copy(S1,1,i-1); br1:=i; end;
  if (S1[i] = ')') and (br2 = 0) then begin  br2:=i; SA:=Copy(S1,br1+1,br2-br1-1);  goto 1; end;
end;

1:
if SF = '' then begin Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION; Lib_ErrorString:=S; goto endp; end;
//if SA = '' then begin E_Code:=E_ERROR_AT_ADDITION_OF_FUNCTION; SError:=S; goto endp; end;  {.203}{.xxx}  fnc():real=1.123

p:=1;
for i := 1 to Length(SA) do
begin
  if SA[i] = ';' then
  begin
   SetLength(MA,Length(MA)+1);
   MA[High(MA)]:=Copy(SA,p,i-p);
   p:=i+1;
  end;
end;
if p > 1 then
begin
 SetLength(MA,Length(MA)+1);
 MA[High(MA)]:=Copy(SA,p,Length(SA)-p+1);
end;
if Length(MA) = 0 then
begin

//func(x1,..,xn: type)
//func(x1,..xn)
//func(x1)
//func(x1: type)
pcFindFuncArg(SA,MX,VT);
if Lib_ErrorCode <> 0 then goto endp;
VN:=Length(MX);
FN:=pcGetFuncName(SF,SFM,MX);

end
else
//func(x1,..,xn: type1; y1,..,yn: type2,..)
begin
 for i := 0 to High(MA) do
 begin
   pcFindFuncArg(MA[i],MX,VT);
   if Lib_ErrorCode <> 0 then    goto endp;
   L:=Length(MX);
   L1:=Length(MX1);
   SetLength(MX1,Length(MX1)+L);
   SetLength(LVT,Length(LVT)+L);
   for j := 0 to L-1 do
   begin
    MX1[L1+j]:=MX[j];
    LVT[L1+j]:=VT;
   end;
   MX:=nil;
 end;

 VN:=Length(MX1);
 FN:=pcGetFuncName(SF,SFM,MX1);

 VT:=LVT[0];
 BT:=True;
 for I := 1 to High(LVT) do
 begin
    if VT <> LVT[i] then BT:=False;
 end;

 if BT = True  then
 begin
   LVT:=nil;
 end
 else
 VT:=0;

end;

endp:
except
    on E:  EAccessViolation do
    begin
        Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION;
        Foreval.InternalError:=E_AccessViolation;
    end;

end;
end;




function pcGetFuncName(SF,SFM: String; MX: TArraySt): String;
var
S: String;
i: Integer;
begin
try
S:='';
if Length(MX) = 1 then S:=MX[0]
else
if Length(MX) > 1 then     {.xxx} {.203}   //fnc():real=1.123
begin
  for i := 0 to High(MX) - 1 do
  begin
   S:=S+MX[i]+',';
  end;
  S:=S+MX[High(MX)];
end;

pcGetFuncName:=SF+'('+S+')'+SFM;
except
    on E:  EAccessViolation do
    begin
        Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION;
        Foreval.InternalError:=E_AccessViolation;
    end;
end;

end;






procedure pcFindFuncArg(SA: String; var MX: TArraySt; var VT: Integer);
label endp;
var
 i,p: Integer;
 S2,S3: String;
 GVT,_VT,MT: Cardinal;
begin
//x1,..,xn: type
//x1,..xn
//x1
//x1: type

try
VT:=0;
 P:=Pos(':',SA);
 if P <> 0 then
 begin
  S2:=Copy(SA,1,P-1);  //x1,..xn
  //S3:=LowerCase(Copy(SA,P+1,Length(SA)-P+1)); //type
  S3:=Copy(SA,P+1,Length(SA)-P+1);

  if   _GetTypeVar(S3,GVT,_VT,MT) = False then       {.359}
 
  begin
    Lib_ErrorCode:=E_WRONG_NAME;
    if S3 = ''  then  Lib_ErrorString:=SA else
    Lib_ErrorString:=S3;
    goto endp;
  end;


  VT:=GVT;    {.359}



 end
 else
 begin
   //VT:=2;              {.191}
   if Foreval.DataType = _Double then VT:=fl_REAL_DOUBLE  else VT:=fl_REAL_EXTENDED;
   S2:=SA;
 end;
p:=1;
 for i:=1 to Length(S2) - 1 do
 begin
     if S2[i] = ',' then
     begin
      SetLength(MX,Length(MX)+1);
      MX[High(MX)]:=Copy(S2,p,i-p);
      p:=i+1;
     end;
 end;
 if p <> 1 then
 begin
   SetLength(MX,Length(MX)+1);
   MX[High(MX)]:=Copy(S2,p,Length(S2)-p+1);
 end;
                           {.xxx}
 if (Length(MX) = 0) and (Length(S2) <> 0) {.203} then       //func1(x): real=x
 begin                                                       //func1(): real=1.123
   SetLength(MX,1);
   MX[0]:=Copy(S2,1,Length(S2));
 end;

endp:
except
    on E:  EAccessViolation do
    begin
        Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_FUNCTION;
        Foreval.InternalError:=E_AccessViolation;
    end;
end;
end;






procedure PushVar(S: String);
var
Addr,AddrIM,IdType,MType,SrcDef: Cardinal;
begin
Foreval.ExistVar2(S,Addr,AddrIM,IdType,MType,SrcDef);   {.343}
if Addr <> 0  then
begin
  SetLength(SaveVar,Length(SaveVar)+1);
  SaveVar[Length(SaveVar)-1].Name:=S;
  SaveVar[Length(SaveVar)-1].Addr:=Addr;
  SaveVar[Length(SaveVar)-1].AddrIM:=AddrIM;     {.343}
  SaveVar[Length(SaveVar)-1].TypeF:=IdType;
  SaveVar[Length(SaveVar)-1].MType:=MType;
  SaveVar[Length(SaveVar)-1].SrcDef:=SrcDef;
end
else
begin
  SetLength(SaveVarD,Length(SaveVarD)+1);
  SaveVarD[Length(SaveVarD)-1].Name:=S;
  SaveVarD[Length(SaveVarD)-1].Addr:=0;
  SaveVarD[Length(SaveVarD)-1].AddrIM:=0;
  SaveVarD[Length(SaveVarD)-1].MType:=0;
  SaveVarD[Length(SaveVarD)-1].TypeF:=0;
  SaveVarD[Length(SaveVarD)-1].SrcDef:=0;//не важно; ds_ExternalAddr;//_External;
end;
end;



procedure PopVar;
var
i: integer;
begin
if Length(SaveVar) > 0 then
begin
  for i := 0 to Length(SaveVar) - 1 do
  begin
    {.343}
    //Foreval.SetObject(SaveVar[i].Name,SaveVar[i].Addr,SaveVar[i].TypeF,SaveVar[i].MType);
    Foreval.SetObject2(SaveVar[i].Name,SaveVar[i].Addr,SaveVar[i].AddrIM,SaveVar[i].TypeF,SaveVar[i].MType,SaveVar[i].SrcDef);
  end;
  SetLength(SaveVar,0);
end;
if Length(SaveVarD) > 0 then
begin
  for i := 0 to Length(SaveVarD) - 1 do
  begin
    Foreval.DeleteVar(SaveVarD[i].Name);
  end;
  SetLength(SaveVarD,0);
end;
end;



procedure PushParam(S: String);
var
Re,Im: Extended;
TV: Integer;
idP: Integer;
begin

Foreval.ExistParam(S,idP);
if idP <> _NOT_FOUND then
begin
  Foreval.GetParam(idP,Re,Im,TV);
  SetLength(SaveParam,Length(SaveParam)+1);
  SaveParam[Length(SaveParam)-1].Name:=S;
  SaveParam[Length(SaveParam)-1].Real:=Re;
  SaveParam[Length(SaveParam)-1].Imag:=Im;
  SaveParam[Length(SaveParam)-1].TypeF:=TV;
  Foreval.RenameParam(S,SChidden,0,0,0);
end;
end;


procedure PopParam;
var
i: integer;
begin
if Length(SaveParam) > 0 then
begin
  for i := 0 to Length(SaveParam) - 1 do
  begin
    Foreval.RenameParam(SChidden,SaveParam[i].Name,SaveParam[i].Real,SaveParam[i].Imag,SaveParam[i].TypeF);
  end;
  SetLength(SaveParam,0);
end;
end;

{.385}
procedure RestoreAndFreeData;
begin
{
  (_SyntaxExtCom_CASEP) может устанавливать внутр. переменную перед её определением .
  В процедуре - CheckSyntaxErrorPS
  В случае синт. ошибки нужна очистка.
}

  PopParam;
  PopVar;
  SetLength(CurrentNameSet,0);
end;




procedure ExchLabl(S1: String; var S2: String);

label 1,2,3,endp,err,lfbr2;
var
  i,j,n,p,ns,pl,pg,lens,br,p1,p2,pbr0,psm,cl: integer;
  SG,SN,SGN,SGS,SGSN: String;
  Sin: String;
  Bbr: Boolean;


   function CheckNameLab(SLab,ErrS: String): boolean;
   label endp;
   var
     i,Ps,pe,pe1,pe2: integer;
     Answ: boolean;
   begin
    Answ:=True;
    // ClearError;

     SLab:=StringReplace(SLab,#9,'',[rfReplaceAll, rfIgnoreCase]);
     SLab:=StringReplace(SLab,' ','',[rfReplaceAll, rfIgnoreCase]);


    { if SLab = '' then
     begin
       pe:=12; // условно
       Lib_ErrorCode :=E_VOID_EXPRESSION;
       if (p - pe) < 1 then pe1:=1 else pe1:=p-pe;
       pe2:=2*pe;
       Lib_ErrorString:=Copy(S1,pe1,pe2);
       Answ:=False;
     end
     else }
     begin
         Ps:=pos(S_NameLab,SLab);
         if (Ps = 0) or (Ps > 1) then   // Ps > 1 - error!
         begin
           for i := 1 to Length(SLab) do
           begin
             if not (SLab[i] in EnableNameSymb)then
             begin
               Lib_ErrorCode := E_PROHIBITED_SYMBOL;
               //Lib_ErrorString:=S1;
               // Lib_ErrorString:=SLab[i] + #13#10+ ' in label: ' + #13#10+  SLab;
               Lib_ErrorString:=SLab[i] + #13#10+ ' in label: ' + #13#10+  ErrS;
               Answ:=False;
               goto endp;
             end
           end;

         end;


     end;

       endp:
       CheckNameLab:=Answ;
   end;





begin




  //  for(k,1,10,if(x>y, x=y;y=x;x=y); t=x+y);t


  // for(k,1,10,if((x>y) and (y>x), x=y;y=x;x=y); t=x+y);t

  //  res: int=0 ifp((x > y) or (x <=1), res=0; goto(end)); end >> res

  // for(k,1,10, res: int=0 ifp((x > y) or (x <=1), res=0; goto(end)); t=x+y); end>>t

br:=0;  p1:=0; p2:=0;   pbr0:=0;
Sin:=S1;


for i := 1 to Length(S1) do
begin

 if S1[i] = '(' then
 begin
   inc(br);
   p1:=i;
 end;

 if S1[i] = ')' then dec(br);

 // if br = 0 then pbr0:=i;


 if (S1[i] = ';') and (br <> 0 ) then
 begin
     br:=0; psm:=i;

     {.385}
     for j := psm downto 1 do
     begin
        if S1[j] = ')' then begin dec(br);  end
        else
        if S1[j] = '(' then begin inc(br);  end;

        if br = 1 then begin pbr0:=j; goto lfbr2; end;
     end;

     lfbr2:

     br:=0;  Bbr:=False;
     for j := {p1}pbr0 to Length(S1) do
     begin
        if S1[j] = '(' then begin inc(br); Bbr:=True; end;
        if S1[j] = ')' then begin dec(br); Bbr:=True; end;
        if (br = 0) and (Bbr = True) then begin p2:= j; goto err; end;
     end;



     err:    // если ';' находится внутри скобок  (после обработки процедур for, case, ifp, ... )

     Lib_ErrorCode:=E_MISSING_SEPARATOR;
     //Lib_ErrorString:=Copy(S1,p1,p2-p1+1);//S_Current_Expression;
     cl:=10;
     if pbr0-cl < 1 then cl:=1;

     Lib_ErrorString:=Copy(S1,pbr0-cl,p2-pbr0+cl+1);

     //Lib_ErrorString:=Copy(S1,psm-25,50);
     goto endp;

 end;


end;  //of for i



1:
p:=pos(S_LABEL,S1);      {.383}

if P > 0 then
begin
 ns:=0;
 for i := 1 to P do
 begin
  if S1[i]=';' then inc(ns);
 end;

 inc(ns);
 pl:=0;

 for i := p  downto 1  do
 begin
   if S1[i] = ';' then
   begin
     pl:=i;
     goto 2;
   end;
 end;

 2:
  SN:=Copy(S1,pl+1,p-pl-1);   // Name Label  before: >>
  // if CheckNameLab(SN) = False then   goto endp;   {.395}


  //delete(S1,pl+1,p+1-pl);
  delete(S1,pl+1,p-pl-1+Len_SLABEL);   {.383}
  SG:='goto('+SN+')';
  SGN:='goto('+IntToStr(ns)+')';
  SGS:='gosub('+SN+')';
  SGSN:='gosub('+IntToStr(ns)+')';


 3:
   pg:=pos(SG,S1);
   if pg > 0 then
   begin

      lens:=length(SG);     {SYNT_ERR}
      if _CheckOperatorPlacementPS(@S1,pg,lens+pg-1) = False then
      begin
         Lib_ErrorCode:=E_WRONG_EXPRESSION;
         if pg-1 = 0 then pg:=1;
         if lens+2 >= Length(S1)  then lens:=Length(S1)-2;
         Lib_ErrorString:=copy(S1,pg-1,lens+2);
         goto endp;
      end;

      if CheckNameLab(SN,SG) = False then   goto endp;   {.395}

      delete(S1,pg,5+p-pl);
      insert(SGN,S1,pg);
      goto 3;
   end;


   pg:=pos(SGS,S1);
   if pg > 0 then
   begin
      lens:=length(SGS);
      if _CheckOperatorPlacementPS(@S1,pg,lens+pg-1) = False then
      begin
         Lib_ErrorCode:=E_WRONG_EXPRESSION;
         if pg-1 = 0 then pg:=1;
         if lens+2 >= Length(S1)  then lens:=Length(S1)-2;
         Lib_ErrorString:=copy(S1,pg-1,lens+2);
         goto endp;
      end;

      if CheckNameLab(SN,SGS) = False then   goto endp;   {.395}

      delete(S1,pg,6+p-pl);
      insert(SGSN,S1,pg);
      goto 3;
   end;

 goto 1;
end;

endp:
 S2:=S1;
end;





function _FindCmplFunc(Addr: Cardinal): Cardinal;
label endp;
var
i,N: Cardinal;
begin
N:=0;

For i:=0 to High(CompZ) do
 begin
  if Addr = CompZ[i].Func.Addr then
  begin
   N:=i;
   goto endp;
  end;
 end;

endp:
 _FindCmplFunc:=N;
end;



{.365A}
function FindArray(SV,SF: String; var SV1,SF1: String): Boolean; //array[expr1]=expr2  ->  savev(vd,expr1,expr2)
var
SArg,SF2: String;
P,L: Integer;
Answ: Boolean;
VAddr1,VAddr2: Cardinal;
MType1,MType2,VType1,VType2: Cardinal;
begin

Answ:=False;
SF1:=SF;
SV1:=SV;
//P:=Pos(']',SV);
L:=Length(SV);

//if (P = L) and (L > 0) then
if L > 0 then                     {.199}
begin
 if SV[Length(SV)] = ']' then
 begin
   P:=Pos('[',SV);
   SV1:=Copy(SV,1,P-1);
   SArg:=Copy(SV,P+1,Length(SV)-P-1);
   if SV1 = '' then                  {.365A}
   begin
      Lib_ErrorCode:=E_WRONG_EXPRESSION;
      Lib_ErrorString:=SV;
   end
   else
   begin
     SF1:='save('+SV1+','+SArg+','+SF+')';
     Answ:=True;
   end;
 end
 else {.369} //Array1=Array2
 begin
    Foreval.ExistVar(SV,VAddr1,VType1,MType1);
    if VType1 = T_Array then
    begin
      Foreval.ExistVar(SF,VAddr2,VType2,MType2);
      if (VType2 = T_Array) and (MType1 = MType2) then
      begin
        SV1:=SV;
        SF1:='save('+SV+','+SF+')';
        Answ:=True;
      end
      else
      begin
         Lib_ErrorCode:=E_WRONG_TYPE;
         Lib_ErrorString:=SV+'='+SF;
      end;
    end;

 end;
end;

 FindArray:=Answ;
end;



procedure _SetStrPCh(P: Pointer);
label 1,endp;
var
L,es,i: integer;
AI: PArrayB;
S1: AnsiString;
P1: Pointer;
begin

if P = nil then
begin
 S1:='';
 goto endp;
end;


  AI:=@TArrayB(P);
  i:=0;  L:=0;
  es:=Integer(AI^[0]);
  S1:='';

  1:
  if es  > 0 then
  begin
   S1:=S1+AnsiChar(AI^[i]);
   inc(i);
   es:=Integer(AI^[i]);
   goto 1;
  end;



endp:
 //Str:=Sans;
 Str:=String(Copy(S1,1,Length(S1)));
end;





procedure _GetStrPCh(var P: Pointer);
var
L,i: integer;
begin
 Sans:=AnsiString(Str);


  L:=Length(Sans);
  SetLength(VSB,L+1);

  if L > 0 then
  begin
   for i:=1 to L do
   begin
    VSB[i-1]:=byte(AnsiChar(Sans[i]));
   end;
   VSB[L]:=byte(#0);
  end
  else
  begin
   SetLength(VSB,1);
   VSB[0]:=byte(#0);
  end;

  P:=@VSB[0];

end;



procedure SetNameTypes;
var
NTypeList,Nint,NCmplx,NReal,NPtr,NArrayInt,NArrayReal,nc,nc1: Integer;
GVT,ncr,nci,ncp,nccx,ncar,ncai,k: Integer;
begin
      {.359}
 NTypeList:=52;
 SetLength(VarTypeList,NTypeList);
 nc:=0; nc1:=0;
 VarTypeList[nc].TypeName:='real';
 VarTypeList[nc].GVarType:=fl_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='ext';
 VarTypeList[nc].GVarType:=fl_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='extended';
 VarTypeList[nc].GVarType:=fl_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='dbl';
 VarTypeList[nc].GVarType:=fl_REAL_DOUBLE;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='double';
 VarTypeList[nc].GVarType:=fl_REAL_DOUBLE;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='sng';
 VarTypeList[nc].GVarType:=fl_REAL_SINGLE;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='single';
 VarTypeList[nc].GVarType:=fl_REAL_SINGLE;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_SINGLE;

 NReal:=nc-nc1+1;

 nc1:=nc;
 inc(nc);
 VarTypeList[nc].TypeName:='int';
 VarTypeList[nc].GVarType:=fl_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_INTEGER;
 inc(nc);
 VarTypeList[nc].TypeName:='integer';
 VarTypeList[nc].GVarType:=fl_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_INTEGER;
 {inc(nc);
 VarTypeList[nc].TypeName:='int32';
 VarTypeList[nc].GVarType:=fl_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_INTEGER;
 inc(nc);
 VarTypeList[nc].TypeName:='integer32';
 VarTypeList[nc].GVarType:=fl_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Real;
 VarTypeList[nc].MathType:=_INTEGER;}

 NInt:=nc-nc1;

 nc1:=nc;
 inc(nc);
 VarTypeList[nc].TypeName:='ptr';
 VarTypeList[nc].GVarType:=fl_POINTER;
 VarTypeList[nc].VarType:=T_Pointer;
 VarTypeList[nc].MathType:=_POINTER;
 inc(nc);
 VarTypeList[nc].TypeName:='pointer';
 VarTypeList[nc].GVarType:=fl_POINTER;
 VarTypeList[nc].VarType:=T_Pointer;
 VarTypeList[nc].MathType:=_POINTER;

 NPtr:=nc-nc1;

 nc1:=nc;
 inc(nc);
 VarTypeList[nc].TypeName:='complex';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='tcomplexe';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='complexextended';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='complexofextended';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='complexext';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='cxextended';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='cxext';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED;
 {inc(nc);
 VarTypeList[nc].TypeName:='extcx';
 VarTypeList[nc].GVarType:=fl_COMPLEX_EXTENDED;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_EXTENDED; }

 inc(nc);
 VarTypeList[nc].TypeName:='tcomplexd';
 VarTypeList[nc].GVarType:=fl_COMPLEX_DOUBLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='complexdouble';
 VarTypeList[nc].GVarType:=fl_COMPLEX_DOUBLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='complexofdouble';
 VarTypeList[nc].GVarType:=fl_COMPLEX_DOUBLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='complexdbl';
 VarTypeList[nc].GVarType:=fl_COMPLEX_DOUBLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='cxdouble';
 VarTypeList[nc].GVarType:=fl_COMPLEX_DOUBLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='cxdbl';
 VarTypeList[nc].GVarType:=fl_COMPLEX_DOUBLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_DOUBLE;
 {inc(nc);
 VarTypeList[nc].TypeName:='dblcx';
 VarTypeList[nc].GVarType:=fl_COMPLEX_DOUBLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_DOUBLE; }

 inc(nc);
 VarTypeList[nc].TypeName:='tcomplexs';
 VarTypeList[nc].GVarType:=fl_COMPLEX_SINGLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='complexsingle';
 VarTypeList[nc].GVarType:=fl_COMPLEX_SINGLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='complexofsingle';
 VarTypeList[nc].GVarType:=fl_COMPLEX_SINGLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='complexsng';
 VarTypeList[nc].GVarType:=fl_COMPLEX_SINGLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='cxsingle';
 VarTypeList[nc].GVarType:=fl_COMPLEX_SINGLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='cxsng';
 VarTypeList[nc].GVarType:=fl_COMPLEX_SINGLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_SINGLE;
 {inc(nc);
 VarTypeList[nc].TypeName:='sngcx';
 VarTypeList[nc].GVarType:=fl_COMPLEX_SINGLE;
 VarTypeList[nc].VarType:=T_Complex;
 VarTypeList[nc].MathType:=_SINGLE;}

 NCmplx:=nc-nc1;

 nc1:=nc;
 inc(nc);
 VarTypeList[nc].TypeName:='array';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='tarraye';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayextended';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayofextended';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_EXTENDED;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayext';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_EXTENDED;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_EXTENDED;



 inc(nc);
 VarTypeList[nc].TypeName:='tarrayd';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_DOUBLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='arraydouble';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_DOUBLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayofdouble';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_DOUBLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_DOUBLE;
 inc(nc);
 VarTypeList[nc].TypeName:='arraydbl';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_DOUBLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_DOUBLE;


 inc(nc);
 VarTypeList[nc].TypeName:='tarrays';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_SINGLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='arraysingle';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_SINGLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayofsingle';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_SINGLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_SINGLE;
 inc(nc);
 VarTypeList[nc].TypeName:='arraysng';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_SINGLE;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_SINGLE;

 NArrayReal:=nc-nc1;

 nc1:=nc;
 inc(nc);
 VarTypeList[nc].TypeName:='tarrayi';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_INTEGER;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayinteger';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_INTEGER;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayofinteger';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_INTEGER;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayint';
 VarTypeList[nc].GVarType:=fl_ARRAY_REAL_INTEGER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_INTEGER;

 NArrayInt:=nc-nc1;

 nc1:=nc;
 inc(nc);
 VarTypeList[nc].TypeName:='tarrayp';
 VarTypeList[nc].GVarType:=fl_ARRAY_POINTER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_POINTER;
 inc(nc);
 VarTypeList[nc].TypeName:='arraypointer';
 VarTypeList[nc].GVarType:=fl_ARRAY_POINTER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_POINTER;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayofpointer';
 VarTypeList[nc].GVarType:=fl_ARRAY_POINTER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_POINTER;
 inc(nc);
 VarTypeList[nc].TypeName:='arrayptr';
 VarTypeList[nc].GVarType:=fl_ARRAY_POINTER;
 VarTypeList[nc].VarType:=T_Array;
 VarTypeList[nc].MathType:=_POINTER;




 SetLength(SNReal,NReal);
 SetLength(SNInt,NInt);
 SetLength(SNPtr,NPtr);
 SetLength(SNCmplx,NCmplx);
 SetLength(SNArrayInt,NArrayInt);
 SetLength(SNArrayReal,NArrayReal);


 ncr:=0; nci:=0; ncp:=0; nccx:=0; ncar:=0; ncai:=0;
 for k := 0 to Length(VarTypeList)-1 do
 begin
    GVT:=VarTypeList[k].GVarType;
    case GVT of
      fl_REAL_EXTENDED:       begin SNReal[ncr]:=VarTypeList[k].TypeName; inc(ncr);  end;
      fl_REAL_DOUBLE:         begin SNReal[ncr]:=VarTypeList[k].TypeName; inc(ncr);  end;
      fl_REAL_SINGLE:         begin SNReal[ncr]:=VarTypeList[k].TypeName; inc(ncr);  end;

      fl_COMPLEX_EXTENDED:    begin SNCmplx[nccx]:=VarTypeList[k].TypeName; inc(nccx);  end;
      fl_COMPLEX_DOUBLE:      begin SNCmplx[nccx]:=VarTypeList[k].TypeName; inc(nccx);  end;
      fl_COMPLEX_SINGLE:      begin SNCmplx[nccx]:=VarTypeList[k].TypeName; inc(nccx);  end;

      fl_REAL_INTEGER:        begin SNInt[nci]:=VarTypeList[k].TypeName; inc(nci);  end;

      fl_POINTER:             begin SNPtr[ncp]:=VarTypeList[k].TypeName; inc(ncp);  end;

      fl_ARRAY_REAL_INTEGER:  begin SNArrayInt[ncai]:=VarTypeList[k].TypeName; inc(ncai);  end;

      fl_ARRAY_REAL_EXTENDED: begin SNArrayReal[ncar]:=VarTypeList[k].TypeName; inc(ncar);  end;
      fl_ARRAY_REAL_DOUBLE:   begin SNArrayReal[ncar]:=VarTypeList[k].TypeName; inc(ncar);  end;
      fl_ARRAY_REAL_SINGLE:   begin SNArrayReal[ncar]:=VarTypeList[k].TypeName; inc(ncar);  end;

    end;
 end;



  (*
 SNReal[0]:='dbl';
 SNReal[1]:='double';
 SNReal[2]:='ext';
 SNReal[3]:='extended';
 SNReal[4]:='float';
 SNReal[5]:='real';
 SNReal[6]:='single';
 SNReal[7]:='sng';

 SNInt[0]:='int';
 SNInt[1]:='integer';

 SNPtr[0]:='ptr';
 SNPtr[1]:='pointer';

 SNCmplx[0]:='complex';
 SNCmplx[1]:='complexofdouble';
 SNCmplx[2]:='complexdouble';
 SNCmplx[3]:='doublecomplex';
 SNCmplx[4]:='doubleofcomplex';
 SNCmplx[5]:='cxdbl';
 SNCmplx[6]:='dblcx';
 SNCmplx[7]:='cxdouble';
 SNCmplx[8]:='complexd';
 SNCmplx[19]:='doublecx';
 SNCmplx[20]:='tcomplexd';
 SNCmplx[21]:='dblcomplex';
 SNCmplx[22]:='complexdbl';

 SNCmplx[9]:=  'complexofextended'  ;
 SNCmplx[10]:= 'complexextended'    ;
 SNCmplx[11]:= 'extendedcomplex'    ;
 SNCmplx[12]:= 'extendedofcomplex'  ;
 SNCmplx[13]:= 'cxext'              ;
 SNCmplx[14]:= 'extcx'              ;
 SNCmplx[15]:= 'cxextended'         ;
 SNCmplx[16]:= 'tcomplexe'          ;
 SNCmplx[17]:= 'extendedcx'         ;
 SNCmplx[18]:= 'complexe'           ;
 SNCmplx[23]:= 'complexext';
 SNCmplx[24]:= 'extcomplex';


 SNCmplx[25]:='complexofsingle';
 SNCmplx[26]:='complexsingle';
 SNCmplx[27]:='singlecomplex';
 SNCmplx[28]:='singleofcomplex';
 SNCmplx[29]:='cxsng';
 SNCmplx[30]:='sngcx';
 SNCmplx[31]:='cxsingle';
 SNCmplx[32]:='complexs';
 SNCmplx[33]:='singlecx';
 SNCmplx[34]:='tcomplexd';
 SNCmplx[35]:='sngcomplex';
 SNCmplx[36]:='complexsng';


 SetLength(SNSpace,43);
 SNSpace[0]:='complexdouble';
 SNSpace[1]:='complexofdouble' ;
 SNSpace[2]:='complexofdbl';
 SNSpace[3]:='doublecomplex' ;
 SNSpace[4]:='complexextended' ;
 SNSpace[5]:='complexofextended' ;
 SNSpace[6]:='complexofext' ;
 SNSpace[7]:='extendedcomplex';

 SNSpace[8]:='arraydouble'  ;
 SNSpace[9]:='arrayofdouble' ;
 SNSpace[10]:='arraydbl' ;
 SNSpace[11]:='arrayofdbl' ;
 SNSpace[21]:='arrayd' ;

 SNSpace[12]:='arrayextended'  ;
 SNSpace[13]:='arrayofextended'  ;
 SNSpace[14]:='arrayofext'  ;
 SNSpace[15]:='arrayext'    ;

 SNSpace[16]:='arrayinteger'  ;
 SNSpace[17]:='arrayofinteger' ;
 SNSpace[18]:='arrayofint' ;
 SNSpace[19]:='arrayint' ;
 SNSpace[20]:='arrayi' ;


 SNSpace[22]:='complexext' ;
 SNSpace[23]:='complexdbl' ;
 SNSpace[24]:='extcomplex' ;
 SNSpace[25]:='dblcomplex' ;

 SNSpace[26]:='arraypointer'  ;
 SNSpace[27]:='arrayofpointer' ;
 SNSpace[28]:='arrayofptr' ;
 SNSpace[29]:='arrayptr' ;
 SNSpace[30]:='arrayp' ;

 SNSpace[31]:='arrays'  ;
 SNSpace[32]:='arrayofsingle' ;
 SNSpace[33]:='arraysng' ;
 SNSpace[34]:='arrayofsng' ;
 SNSpace[35]:='arraysingle' ;
 SNSpace[36]:='arrays' ;

 SNSpace[37]:='complexsingle';
 SNSpace[38]:='complexofsingle' ;
 SNSpace[39]:='complexofsng';
 SNSpace[40]:='complexs' ;
 SNSpace[41]:='complexd' ;
 SNSpace[42]:='complexe' ;

*)


end;


  {.359}
function _GetTypeVar(TypeName: String; var GVT,VT,MT: Cardinal): Boolean;
label endp;
var
BAnsw: Boolean;
k: integer;
SN: String;
begin

BAnsw:=False;
GVT:=0; MT:=0; VT:=0;
if TypeName = '' then goto endp; {.377C}

for k := 0 to Length(VarTypeList)-1 do
begin

   SN:=VarTypeList[k].TypeName;

   if SN = TypeName then
   begin
     GVT:=VarTypeList[k].GVarType;
     VT:=VarTypeList[k].VarType;
     MT:=VarTypeList[k].MathType;

     if SN = 'real' then
     begin
        MT:=Foreval.DataType;
        if MT = _Double then GVT:=fl_REAL_DOUBLE  else GVT:=fl_REAL_EXTENDED;
     end
     else
     if SN = 'complex' then
     begin
        MT:=Foreval.DataType;
        if MT = _Double then GVT:=fl_COMPLEX_DOUBLE  else GVT:=fl_COMPLEX_EXTENDED;
     end
     else
     if SN = 'array'  then
     begin
        MT:=Foreval.DataType;
        if MT = _Double then GVT:=fl_ARRAY_REAL_DOUBLE else GVT:=fl_ARRAY_REAL_EXTENDED;
     end;


     BAnsw:=True;
     goto endp;
   end;

end;

endp:
_GetTypeVar:=BAnsw;
end;


procedure ResultCxD(Func: Pointer; var  Res: TComplexD);
var
p:TComplexD;
begin
  asm
   call Func
   push eax
   mov  eax, [res]
   fstp qword ptr [eax]
   fstp qword ptr [eax+8]
   pop  eax
  end;
end;



procedure ResultCxE(Func: Pointer; var Res: TComplexE);
begin
 asm
   call Func
   push eax
   mov  eax, [res]
   fstp tbyte ptr [eax]
   fstp tbyte ptr [eax+16]
   pop  eax
  end;
end;









procedure _LEN(adr: Cardinal; var len: Cardinal);
var
len1: cardinal;
begin
asm
       push eax
       mov  eax, [adr]
       mov  eax, [eax]
       test eax,eax
       jz @@nil
       mov  eax, [eax-4]

       {.357}
       add eax, c_DinArrayLenCorrect
       (*
       {$IFDEF FPC}
       add eax,1
       {$ENDIF}
       *)

       @@nil:
       mov  len1, eax
       pop  eax
end;
len:=len1;
end;




{.193}
procedure InitFuncStruct(var FS: TAddFuncStruct);
begin
  FS.addr:=nil;
  FS.CallType:=fl_Stdcall;
  FS.Arg:=0;
  FS.ArgType:=fl_Differ;
  FS.ArgTypeList:=nil;
  FS.CallFunc:=0;
  FS.ResultType:=0;
  FS.DeepFPU:=8;//fl_UNKNOWN;
  FS.CalcConst:=fl_Yes;
  FS.SaveReg:=15;  //save:eax,ebx,ecx,edx
  FS.ReplFunc:=fl_YES;
  FS.Set_ID:=fl_DISABLE;
  FS.Id_Func:=0;
  FS.AdrDeriv:=nil;
  FS.NDeriv:=0;
  FS.ResultTypeMath := fl_EXTENDED;
  FS.IsInline:=fl_NO;
end;


procedure flLoadFPUD(RE: Double; Im: Double);  stdcall;
asm
  fld qword ptr Im
  fld qword ptr Re
end;


procedure flLoadFPUE(RE: Extended; Im: Extended);   stdcall;
asm
  fld tbyte ptr Im
  fld tbyte ptr Re
end;


procedure flLoadFPUDP(Adr: Pointer);  stdcall;
asm         //Adr=@TComplexD
  push eax
  mov eax,Adr
  fld qword ptr [eax+8]
  fld qword ptr [eax]
  pop eax
end;


procedure flLoadFPUEP(Adr: Pointer);  stdcall;   {.191}
asm         //Adr=@TComplexE
  push eax
  mov eax,Adr
  fld tbyte ptr [eax+16]
  fld tbyte ptr [eax]
  pop eax
end;




procedure  flGetVarValueD(Addr: Pointer; var Val: Double);       stdcall;
begin
  Val:=PDouble(Addr)^
end;


procedure  flGetVarValueE(Addr: Pointer; var Val: Extended);       stdcall;
begin
  Val:=PExtended(Addr)^
end;


procedure  flGetVarValueI(Addr: Pointer; var Val: Integer);       stdcall;
begin
  Val:=PInteger(Addr)^
end;


procedure  flGetVarValueS(Addr: Pointer; var Val: Single);       stdcall;
begin
  Val:=PSingle(Addr)^
end;

//******************************************************************************
//                       DIFFERENTIATION    (begin)
//******************************************************************************





procedure _SetDiffVar(NName: String);
var
VDiff: String;
Addr: Cardinal;
ni,TV,TM: Integer;
begin
 VDiff:=NName;
 //if Foreval.LeadToLowerCase = True then VDiff:=LowerCase(VDiff); {.245}

 //if F_LeadToLowerCase = True then VDiff:=LowerCase(VDiff);

 ClearError;
 Foreval.FindVarA(VDiff,ni,Addr,TV,TM);                                                                 {.358}
 if (ni <> _NOT_FOUND) and ((TV = T_Real)or (TV = T_Complex)) and ((TM = _Double) or (TM = _Extended) or (TM = _Single)) then
 begin
   Foreval.DiffVar:=VDiff;
 end
 else
 begin
    {Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
    Foreval.SyntaxErrorString:='flSetDiffVar';
    Foreval.IntException;}
    Lib_ErrorCode:=E_WRONG_PASSED_DATA;
    Lib_ErrorString:='flSetDiffVar';
 end;

end;


procedure flSetDiffVar(NName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});
var
VDiff: String;
Addr: Cardinal;
ni,TV,TM: Integer;
begin
  VDiff:={$IFDEF STRINGINT}NName{$ELSE}PtrToStr(NName){$ENDIF};

  if F_LeadToLowerCase = True then VDiff:=LowerCase(VDiff);

  if  CheckNamePS(@VDiff) = true  then
  begin
    _SetDiffVar(VDiff);
    if Lib_ErrorCode <> 0 then  _LibError;
  end
  else
  begin
    _LibError;
  end;

end;



procedure  _SetDiffExpr(Expr: String);
label endp;
var
Func,Sdiff: String;
EC,ErrDiffType: Cardinal;
begin

//if Foreval.LeadToLowerCase = True then Func:=LowerCase(Func); {.245}

Func:=Expr;
Lib_ErrorCodeDiff:=0; {.389A}

if Foreval.DiffType = _Symbolic then   ErrDiffType:=CM_DiffExpr
else
if Foreval.DiffType = _Numeric  then   ErrDiffType:=CM_WholeExpr;


if CheckSyntaxErrorPS(@Func, ErrDiffType) = True then
begin
  S_DiffExpr:=Copy(Func,1,Length(Func)) ;
end
else          {.389A}
begin
   Lib_ErrorCodeDiff:=Lib_ErrorCode;
   Lib_ErrorStringDiff:=Lib_ErrorString;
end;


 endp:
end;




procedure  _DiffExprN(N: Cardinal);
label endp;
var
SDiff: String;
EC: Cardinal;
begin
ClearError;

if N > 0 then
begin

 //if F_DiffType = F_Symbolic then
  Foreval.DiffExpressionN(S_DiffExpr, N, SDiff);
 //else


 flGetErrorCode(EC);
 if EC = 0 then
 begin
  S_DiffExpr:=Copy(SDiff,1,Length(SDiff));
 end
 else
 begin
   Lib_ErrorCode:=Foreval.SyntaxError;
   Lib_ErrorString:=Foreval.SyntaxErrorString;
   Lib_ErrorCodeDiff:=Lib_ErrorCode;        {.389A}
   Lib_ErrorStringDiff:=Lib_ErrorString;    {.389A}
   //_LibError;
 end;

end;

endp:
end;




procedure  flSetDiffExpr(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});
label endp;
var
Func,Sdiff: String;
EC: Cardinal;
begin
 {$IFDEF STRINGINT}
  Func:=Expr;
 {$ELSE}
  Func:=PtrToStr(Expr);
 {$ENDIF}

 if F_LeadToLowerCase = True then Func:=LowerCase(Func);

 _SetDiffExpr(Func);
 if Lib_ErrorCode <> 0 then
 begin
   _LibError;
   RestoreAndFreeData;   {.383}
   {.377C}
   Lib_ErrorCodeDiff:=Lib_ErrorCode;
   Lib_ErrorStringDiff:=Lib_ErrorString;
 end;



 endp:
end;





procedure  flDiffExpr(N: Cardinal);
label endp;
var
SDiff: String;
EC: Cardinal;
begin
ClearError;

_DiffExprN(N);
flGetErrorCode(EC);
if EC <> 0 then _LibError;


endp:
end;





{.377C}
procedure _CompileDiff(DiffS: String; G_AtrD: TAttribInt; var Func: Pointer);
label endp;
var
FS: TFunction;
NS: Cardinal;
S,S1: String;
BME,BRF: Boolean;
BRFnc,BROps,BRFncCF: Boolean;
begin
//проверка синтаксиса уже выполнена в flSetDiffExpr


S:=DiffS;
if S = '' then S:='0';
ClearError; {.300}
Func:=nil;       {.375C}


S_Current_Expression:=Copy(S,1,Length(S));


   Foreval.SetExtExpression(S,G_AtrD,FS,NS);

   if Foreval.SyntaxError = 0 then
   begin
    SetLength(CompZ,Length(CompZ)+1);
    CompZ[High(CompZ)].Func:=FS;
    CompZ[High(CompZ)].R_Type:=Foreval.ResultType;
    if Foreval.DinLoadOverFlow = True then
    begin
     CompZ[High(CompZ)].CmplOverFlow:=1;
     CmplOverFlow:=1;
    end
    else
    begin
     CompZ[High(CompZ)].CmplOverFlow:=0;
     CmplOverFlow:=0;
    end;
    CompZ[High(CompZ)].CmplSDeep:=Foreval.MaxLoadStack;
    CompZ[High(CompZ)].DinLoadNMem:=Foreval.DinLoadNMem;
    CompZ[High(CompZ)].DinLoadSDeep :=Foreval.DinLoadSDeep;
    CompZ[High(CompZ)].ReplFuncNum:=Foreval.ReplFuncNum;
    CompZ[High(CompZ)].ReplOpNum:=Foreval.ReplOpNum;
    CompZ[High(CompZ)].LoadStackAfterCalc:=Foreval.LoadStackAfterCalc;
    CompZ[High(CompZ)].XchBrNXch:=Foreval.XchBrNXch;
    CompZ[High(CompZ)].XchBrSDeep:=Foreval.XchBrSDeep;
    CompZ[High(CompZ)].CalcConstFunc:=Foreval.CalcConstFunc;        {.315}
    CompZ[High(CompZ)].CalcConstArg:=Foreval.CalcConstArg;          {.315}
    CompZ[High(CompZ)].CalcConstMulDiv:=Foreval.CalcConstMulDiv;    {.315}
    CompZ[High(CompZ)].NumberReductions:=Foreval.NumberReductions;
    CompZ[High(CompZ)].CodeSize:=Foreval.CodeSize;
    CompZ[High(CompZ)].AddrMainDiffExpr:= _AddrMainDiffExpr;        {.379}
    CompZ[High(CompZ)].DiffNumericExpr:=fl_No;     {.379}
    if Foreval.DiffType =_Numeric then  CompZ[High(CompZ)].DiffNumericExpr:=fl_Yes;  {.379}



    CmplSDeep:=Foreval.MaxLoadStack;
    DinLoadNMem:=Foreval.DinLoadNMem;
    ReplFuncNum:=Foreval.ReplFuncNum;
    ReplOpNum:=Foreval.ReplOpNum;
    LoadStackAfterCalc:=Foreval.LoadStackAfterCalc; {.197}
    XchBrNXch:=Foreval.XchBrNXch;
    DinLoadSDeep:=Foreval.DinLoadSDeep;
    XchBrSDeep:=Foreval.XchBrSDeep;
    CalcConstFunc:=Foreval.CalcConstFunc;  {.315}
    CalcConstArg:=Foreval.CalcConstArg;
    CalcConstMulDiv:=Foreval.CalcConstMulDiv;
    NumberReductions:=Foreval.NumberReductions;
    CodeSize:=Foreval.CodeSize;

    //Func:=Pointer(CompZ[High(CompZ)].Func.ICode);  {.193}
    Func:=CompZ[High(CompZ)].Func.PAddr;
   end;

endp:
Set8087CW(CalcCW);//in SetExExpression CW - changed    {.229}
end;



procedure  flCompileDiffExpr( var Addr: Pointer);   stdcall;
label endp;
var
SDiff: String;
EC,NAddr: Cardinal;
bl: boolean;
begin
Addr:=nil;
ClearError;
//Foreval.ErrorCode:=0;
F_DiffExtPresent:= False;
F_MainDiffExpr  := True; {.379}
_AddrMainDiffExpr:=nil;  {.379}

FindDiffExt(S_DiffExpr,SDiff);
flGetErrorCode(EC);
if {Foreval.SyntaxError}EC = 0 then
begin
 //bl:=Foreval.CalcConstExpression;    {.301}//off
 //if F_DiffExtPresent = True then  Foreval.CalcConstExpression:=False;       {.301}//off
 try
  //_Compile(SDiff,Addr);
  _CompileDiff(SDiff, G_Atr0, Addr);



   //SetLength(DF[High(DF)].DiffIntFunc,Length(DiffIntFunc));  {.215}
   //for i:=0 to Length(DiffIntFunc)-1 do begin   DF[High(DF)].DiffIntFunc[i]:=DiffIntFunc[i]; end;   {.215}
        {NAddr:=Cardinal(Addr);
         asm
           call NAddr
         end;}
 except
    Foreval.SyntaxError:=fl_INTERNAL_ERROR ;
 end;

 //Foreval.CalcConstExpression:=bl;   {.301}//off

end;

endp:
end;




{.377C}
procedure  flCompileDiffExprATE(PAttr:   Pointer; var Addr: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal);  stdcall;
label endp;
var
SDiff: String;
EC,NAddr: Cardinal;
bl: boolean;
begin

Addr:=nil;
//ClearError;
ResType:=0;
ErrorCode:=0;


if Lib_ErrorCodeDiff = 0 then
begin

  ClearError; {.389A}     //обнуление  Lib_ErrorCodeDiff
  F_DiffExtPresent:=False;

  FindDiffExt(S_DiffExpr,SDiff);
  flGetErrorCode(EC);
  if {Foreval.SyntaxError}EC = 0 then
  begin
   GC_PAtr:=PAttr;
   if _ConvertAttr = True then
   begin

    try
      _CompileDiff(SDiff,G_Atr, Addr);
    except
      Foreval.SyntaxError:=fl_INTERNAL_ERROR ;
    end;

   end;


  end;

  flGetErrorCode(ErrorCode);
  flGet(fl_RESULT_TYPE,0,ResType);
end
else
begin
    Foreval.SyntaxError:=Lib_ErrorCodeDiff;
    Foreval.SyntaxErrorString:=Lib_ErrorStringDiff;
    flGetErrorCode(ErrorCode);
    //Foreval.IntException;
end;

Lib_ErrorCodeDiff:=0;
Lib_ErrorStringDiff:='';



endp:
end;






procedure  flCompileDeriv(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; VName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; N: Cardinal; var Addr: Pointer);  stdcall;
label endp;
var
Func,SDiff,Func1,Func2,Func3,VDiff: String;
EC: Cardinal;
bl: boolean;
begin
 {$IFDEF STRINGINT}
  Func:=Expr;
  VDiff:=VName;
 {$ELSE}
  Func:=PtrToStr(Expr);
  VDiff:=PtrToStr(VName);
 {$ENDIF}

 Addr:=nil; {.375C}

 if F_LeadToLowerCase = True then
 begin
   Func:=LowerCase(Func);
   VDiff:=LowerCase(VDiff);
 end;

  Func1:=S_DiffExpr;
  Func2:=Foreval.DiffVar;

  if  CheckNamePS(@VDiff) = true  then
  begin

     _SetDiffVar(VDiff);
     if Lib_ErrorCode = 0 then
     begin

        _SetDiffExpr(Func);
        if {Lib_ErrorCode} Lib_ErrorCodeDiff = 0 then  {.389A}
        begin
            //flDiffExpr(N);
            _DiffExprN(N);
            {flGetErrorCode(EC);
            if EC = 0 then  flCompileDiffExpr(Addr)}
            if Lib_ErrorCodeDiff = 0 then  flCompileDiffExpr(Addr) {.389A}
            else
            _LibError;
        end
        else
        _LibError;

     end
     else
     _LibError

  end
  else
  _LibError;


 RestoreAndFreeData;   {.383}
 S_DiffExpr:=Func1;
 Foreval.DiffVar:=Func2;
end;



 {.377C}
procedure  flCompileDerivATE(Expr: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; VName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; N: Cardinal; PAttr:   Pointer; var Addr: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal); stdcall;
label endp;
var
Func,SDiff,Func1,Func2,Func3,VDiff: String;
EC,EC1: Cardinal;
bl: boolean;
begin

 {$IFDEF STRINGINT}
  Func:=Expr;
  VDiff:=VName;
 {$ELSE}
  Func:=PtrToStr(Expr);
  VDiff:=PtrToStr(VName);
 {$ENDIF}

 Addr:=nil; {.375C}
 ResType:=fl_NONE;

 if F_LeadToLowerCase = True then
 begin
   Func:=LowerCase(Func);
   VDiff:=LowerCase(VDiff);
 end;

  Func1:=S_DiffExpr;
  Func2:=Foreval.DiffVar;

  if  CheckNamePS(@VDiff) = true  then
  begin

     _SetDiffVar(VDiff);
     if Lib_ErrorCode = 0 then
     begin

        _SetDiffExpr(Func);
        if {Lib_ErrorCode} Lib_ErrorCodeDiff = 0 then   {.389A}
        begin
            //flDiffExpr(N);
            _DiffExprN(N);
            {flGetErrorCode(EC);
            if EC = 0 then  flCompileDiffExprATE(PAttr, Addr, ResType, EC1) }
            if Lib_ErrorCodeDiff = 0 then  flCompileDiffExprATE(PAttr, Addr, ResType, EC1) {.389A}
            else
            _LibError;
        end
        else
        _LibError;

     end
     else
     _LibError

  end
  else
  _LibError;

 flGetErrorCode(ErrorCode);

 S_DiffExpr:=Func1;
 Foreval.DiffVar:=Func2;

end;






procedure flGetDiffString(var S: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});
var
S1: String;
begin
 S1:=S_DiffExpr;
 StrD:=Copy(S1,1,Length(S1));
 S:={$IFDEF STRINGINT}StrD{$ELSE}StrToPtr(StrD){$ENDIF};
end;




function CheckDisableSymb(PS: PString): Boolean;
label endp;
var
Answ: Boolean;
i: integer;
begin

Answ :=False;

if Foreval.ReplaceAbsBrP(PS) = True then
begin
   if Foreval.PipeBracketToAbs = False then
   begin
      Answ:=True;
      goto endp;
   end;
end;

for i := 1 to Length(PS^) do
begin
 if PS^[i] in ProhibitedSymb then
 begin
    Answ:=True;
    goto endp;
 end;
end;



endp:
 CheckDisableSymb:=answ;
end;




procedure  flSetDiffTemplate(idfP: Pointer; TemplateDiff: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF});     stdcall;
label endp;
var
TmplDF,NameF: String;
IDF: ^TidFunc;
p,i: integer;
S,Sfn,Sdf: String;
NF,NFunc: Integer;
begin
TmplDF:=Copy({$IFDEF STRINGINT}TemplateDiff{$ELSE}PtrToStr(TemplateDiff){$ENDIF},1,Length({$IFDEF STRINGINT}TemplateDiff{$ELSE}PtrToStr(TemplateDiff){$ENDIF}));

//if Foreval.LeadToLowerCase = True then TmplDF:=LowerCase(TmplDF); {.245}

if F_LeadToLowerCase = True then TmplDF:=LowerCase(TmplDF);

//DeleteSpace(TmplDF,TmplDF);



ClearError;

//{.346}
if CheckSyntaxErrorPS(@TmplDF,CM_DiffTemplate) = False  then
begin
      Foreval.SyntaxError:=Lib_ErrorCode;
      Foreval.SyntaxErrorString:=Lib_ErrorString;
      Foreval.IntException;
      goto endp;
end;



try
  if idfP <> nil then
  begin
    IDF:=idfP;
    NFunc:=IDF^.idName;
    NF:=IDF^.idArg;
    Foreval.SetTemplateDiffFunc(NFunc,NF,TmplDF);
  end
  else
  begin
     S:=Copy(TmplDF,1,5);
     if S = 'diff(' then
     begin
        p:=pos(')',TmplDF);
        NameF:=Copy(TmplDF,6,p-6);
        p:=pos('=',TmplDF);
        Sdf:=Copy(TmplDF,p+1,Length(TmplDF)-p);
        Foreval.FindFuncA(NameF,NFunc);
        if NFunc <> _NOT_FOUND then Foreval.SetTemplateDiffFunc(NFunc,0,Sdf)
        else
        begin
          Foreval.SyntaxError:=E_ERROR_AT_ADDITION_OF_FUNCTION;
          Foreval.SyntaxErrorString:=TmplDF;
          Foreval.IntException;
        end;
     end
   else
   begin
     Foreval.SyntaxError:=E_ERROR_AT_ADDITION_OF_FUNCTION;
     Foreval.SyntaxErrorString:=TmplDF;
     Foreval.IntException;
   end;
  end;
except
 Foreval.SyntaxError:=E_ERROR_AT_ADDITION_OF_FUNCTION;
 Foreval.SyntaxErrorString:=TmplDF;
 Foreval.IntException;
end;


(*
try
  if idfP <> nil then
  begin
    IDF:=idfP;
    NFunc:=IDF^.idName;
    NF:=IDF^.idArg;
    Foreval.SetTemplateDiffFunc(NFunc,NF,TmplDF);
  end
  else
  begin
    Foreval.SyntaxError:=E_ERROR_AT_ADDITION_OF_FUNCTION;
    Foreval.SyntaxErrorString:=TmplDF;
    Foreval.IntException;
  end;
except
 Foreval.SyntaxError:=E_ERROR_AT_ADDITION_OF_FUNCTION;
 Foreval.SyntaxErrorString:=TmplDF;
 Foreval.IntException;
end;
*)


(*
if ID = 0 then     //pc
begin

   S:=Copy(TmplDF,1,5);
   if {LowerCase(S)}S = 'diff(' then
   begin
     p:=pos(')',TmplDF);
     NameF:=Copy(TmplDF,6,p-6);
     p:=pos('=',TmplDF);
     Sdf:=Copy(TmplDF,p+1,Length(TmplDF)-p);
     Foreval.fdGetDiffFuncID(NameF,IDF);
     if IDF > 0 then Foreval.SetTemplateDiffFunc(IDF,Sdf)
     else
     begin
       Foreval.ErrorCode:=E_NONEXISTENT_FUNCTION;{ERROR}
       Foreval.SyntaxErrorString:=TmplDF;
       Foreval.IntException;
   end;
   end
   else
   begin
     Foreval.ErrorCode:=E_ERROR_AT_ADDITION_FUNCTION;{ERROR}
     Foreval.SyntaxErrorString:=TmplDF;
     Foreval.IntException;
   end;
end
else
begin
  NameF:=Foreval.GetFuncName(ID);
  Foreval.fdGetDiffFuncID(NameF,IDF);
  if IDF <> -1 then
  begin
   ForevD.fdSetTemplateDiffFunc(IDF,TmplDF);
  end;
end;
 *)

endp:
end;


procedure FindDiffExt(S: String;  var SC: String);
label 1,2,endp,rplf;
var
i,L,P1,P2,LA,br,DP,DP1,n1,n2,N,K,ni: Integer;            //#diff(expr,n,difvar)   DiffNumFunc
S1,S2,S3,S4,SFdif,Sdfnb: String;
addrF,addrV: Cardinal;
ptr: Pointer;
VType,TV,TM,ct: Integer;
bl: boolean;
G_AtrT: TAttribInt;
begin        //func2(y+x,x+y)+func2(x,y)+func2(y+x,x+y)+func2(x,y)

 {.379}


2:
//DP:=Pos('@diff(',S);

Sdfnb:=DiffNumFunc+'('; //#diff(
DP:=Pos(Sdfnb,S);
if DP = 0 then goto endp;

F_DiffExtPresent:=True;

N:=DP+6;
L:=Length(S);
br:=1;
P1:=0;
P2:=0;

LA:=0; //{.395} Intit for Warning

for i := N to L - 1 do
begin
 if S[i] = '(' then inc(br) else
 if S[i] = ')' then dec(br);

 if (S[i] = ',') and (br = 1) and (P1 = 0) then P1:=i else
 if (S[i] = ',') and (br = 1) and (P1 <> 0) and (P2 = 0) then P2:=i;


 if (P1 <> 0) and (P2 <> 0) and (br = 1) and (S[i+1] = ')')  then
 begin
   LA:=i; goto 1;
 end;

end;

1:
S1:=Copy(S,N,P1-N);
S2:=Copy(S,P1+1,P2-P1-1);
S3:=Copy(S,P2+1,LA-P2);

SFdif:=DiffNumFunc+'('+S1+','+S2+','+S3+')';

if Pos(Sdfnb,S1) <> 0 then  {.215}      //make possible numeric diff.of many var.
 begin
   FindDiffExt(S1,S1);
 end;



//Foreval.GetVarAdr({ForevD.DiffVar}S3,AddrV,VType);
Foreval.FindVarA(S3,ni,AddrV,TV,{TM}VType);
//bl:=Foreval.CalcConstExpression;         {.301}//off
//Foreval.CalcConstExpression:=False;    {.301}//off

ct:=Foreval.CalcType;
Foreval.CalcType:=T_Real;
F_CompileMode := cm_ProgrammBody; // cm_FunctionBody
G_AtrT.FType:=G_Atr.FType; G_AtrT.AddrRE:=G_Atr.AddrRE; G_AtrT.AddrIM:=G_Atr.AddrIM;    {.392}
G_Atr.FType:=0; G_Atr.AddrRE:=0; G_Atr.AddrIM:=0; GC_PAtr:=nil;      {.389A} //компиляция #diff() должна возвращать числ рез-ат в FPU

_Compile(S1,ptr);

G_Atr.FType:=G_AtrT.FType; G_Atr.AddrRE:=G_AtrT.AddrRE; G_Atr.AddrIM:=G_AtrT.AddrIM;   {.392}
Foreval.CalcType:=ct;
//Foreval.CalcConstExpression:=bl;       {.301}//off
if ptr = nil then goto endp;

if Foreval.ResultType {<> T_Real} = T_None then    // если функция в численном дифф-ии не возвращает число real    {.392}
begin
 if Foreval.ResultType = T_None then
 begin
    Lib_ErrorCode:=E_NO_RETURN_NUMBER;
    Lib_ErrorString:=S_SubExpr+ #13#10+'  in:  '+ #13#10+S1;
    Foreval.SyntaxError:=E_NO_RETURN_NUMBER;
    Foreval.SyntaxErrorString:=Lib_ErrorString;
    goto endp;
 end
 else
 begin
   { Lib_ErrorCode:=E_WRONG_TYPE;
    Lib_ErrorString:=S1;
    Foreval.SyntaxError:=E_WRONG_TYPE;
    Foreval.SyntaxErrorString:=S1;  }
    goto endp;
 end;

end;


addrF:=Cardinal(ptr);

//сохранить адрес скомпилированного главного  выражения при полном численном дифф-ии  для очистки их fl_Free
 if (F_MainDiffExpr = True) and (Foreval.DiffType = _Numeric) then
 begin
   _AddrMainDiffExpr:=ptr;
   F_MainDiffExpr :=False;
 end;

 //***

//SetLength(DiffIntFunc,DiffIntFunc+1);  DiffIntFunc[High(DiffIntFunc)]:=ptr;   {.215}


K:=StrToInt(S2);

Delete(S,DP,LA-N+8);

if K = 1 then S4:=SCdiff1+'('+IntToStr(addrF)+','+IntToStr(addrV)+','+InttoStr(VType)+')' else
if K = 2 then S4:=SCdiff2+'('+IntToStr(addrF)+','+IntToStr(addrV)+','+InttoStr(VType)+')' else
if K = 3 then S4:=SCdiff3+'('+IntToStr(addrF)+','+IntToStr(addrV)+','+InttoStr(VType)+')' else
//if K = 4 then S3:='diff4('+IntToStr(addrF)+','+IntToStr(addrV)+','+InttoStr(VType)+')' else
              S4:=SCdiffN+'('+IntToStr(addrF)+','+IntToStr(addrV)+','+InttoStr(VType)+','+S2+')';


Insert(S4,S,DP);


rplf:
DP:=Pos(SFdif,S);        //func2(x,y)+x*func2(x,y)
if DP <> 0 then
begin
 Delete(S,DP,LA-N+8);
 Insert(S4,S,DP);
 goto rplf;
end;

goto 2;

//gamma(x)*(1/gamma(x))
//gamma(x)+(-gamma(x))
endp:
SC:=S;
end;





//******************************************************************************
//                       DIFFERENTIATION    (end)
//******************************************************************************





//******************************************************************************
//                      SPLAIN   (begin)
//******************************************************************************


                                                                                                                                     {.328}
procedure flSetSplainFunction(FuncName: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; AdrVX,AdrVY: Pointer; ArrayType: Cardinal; {var} idfP: Pointer);  stdcall;
var
NameF: String;
VEX,VEY: TArrayE;
VDX,VDY: TArrayD;
L,i: integer;
adrVX0,adrVY0: Cardinal;
LenX,LenY,ic: Integer;
begin

{$IFDEF STRINGINT}
NameF:=FuncName;
{$ELSE}
NameF:=PtrToStr(FuncName);
{$ENDIF}

//if Foreval.LeadToLowerCase = True then NameF:=LowerCase(NameF); {.245}

if F_LeadToLowerCase = True then NameF:=LowerCase(NameF);

//Len:=PInteger(PInteger(adrXVE)^-4)^;
//u:=PExtended(PInteger(adrXVE)^+10)^;
//u:=PDouble(PInteger(adrXVE)^+10)^;

//for compability with non-delphi data :     {.241}
try
 adrVX0:=PInteger(adrVX)^;
 LenX:=PInteger(PInteger(adrVX)^-4)^;
 adrVY0:=PInteger(adrVY)^;
 LenY:=PInteger(PInteger(adrVY)^-4)^;

 if (LenX = LenY) and (LenX > 0) and (LenY > 0) then
 begin

 {.357}
 LenX:=LenX+c_DinArrayLenCorrect;
 LenY:=LenY+c_DinArrayLenCorrect;
 SetLength(VEX,LenX);  SetLength(VEY,LenY);

 (*
 {$IFDEF FPC}
   SetLength(VEX,LenX+1);  SetLength(VEY,LenY+1);
 {$ELSE}
   SetLength(VEX,LenX);  SetLength(VEY,LenY);
 {$ENDIF}
 *)

   ic:=0;
   if ArrayType =  fl_ARRAY_REAL_EXTENDED then
   begin
      {.357}
      (*
      {$IFDEF FPC}
      while ic <= LenX do
      {$ELSE}
       while ic < LenX do
      {$ENDIF}
      *)
      while ic < LenX do
      begin
         VEX[ic]:=PExtended(adrVX0+10*ic)^;
         VEY[ic]:=PExtended(adrVY0+10*ic)^;
         inc(ic);
      end;
   end
   else
   if ArrayType =  fl_ARRAY_REAL_DOUBLE then
   begin
     {.357}
     (*
     {$IFDEF FPC}
      while ic <= LenX do
      {$ELSE}
       while ic < LenX do
      {$ENDIF}
      *)
      while ic < LenX do
      begin
         VEX[ic]:=PDouble(adrVX0+8*ic)^;
         VEY[ic]:=PDouble(adrVY0+8*ic)^;
         inc(ic);
      end;
   end;

 _SetSplain3F(nameF,VEX,VEY,idfP);
 end
 else
 begin
    Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
    Foreval.SyntaxErrorString:='flSetSplainFunction';
    Foreval.IntException;
 end;

except
    Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
    Foreval.SyntaxErrorString:='flSetSplainFunction';
    Foreval.IntException;
end;

end;


procedure _SetSplain3F(nameF: String; VX,VY: TArrayE; {var} idfP: Pointer);
label 1;
var
SB: Boolean;
idfs: cardinal;
FS: TAddFuncStruct;
DL: array of Integer;
Er: integer;
begin
SB:=False;
//E_SPLError:=0;
if (Length(VX) <> Length(VY)) or (Length(VX) < 4) or (Length(VY) < 4) then goto 1;

try
  _CreateSplain3(TArrayE(VX),TArrayE(VY),idfs,Er);
  if Er = 0 then SB:=True;
except
 SB:=False;
end;

if SB = True  then
begin
  InitFuncStruct(FS);
  FS.addr:=@_FSPL3;
  FS.CallType:=fl_stdcall;
  FS.Arg:=1;
  FS.ArgType:=fl_real_extended;
  FS.ResultType:=fl_real;
  FS.ResultTypeMath:=fl_extended;
  FS.CallFunc:=fl_VARS_ADDRS;
  FS.DeepFPU:=2;
  FS.Set_ID:=fl_Enable;
  FS.Id_Func:=idfs;
  SetLength(DL,4);
  DL[0]:=Cardinal(@_FSPL3D1);
  DL[1]:=Cardinal(@_FSPL3D2);
  DL[2]:=Cardinal(@_FSPL3D3);
  DL[3]:=Cardinal(@_FSPL3D4);
  FS.NDeriv:=4;
  FS.AdrDeriv:=@DL[0];

  _SetFunction(NameF, @FS, idfP);
end
else
begin
1:
    Foreval.SyntaxError:=E_WRONG_PASSED_DATA;
    Foreval.SyntaxErrorString:='flSetSplainFunction';
    Foreval.IntException;
end;


end;


//******************************************************************************
//                       SPLAIN    (end)
//******************************************************************************



procedure  flSetDiffNumCurrency(Np: Cardinal; h: double);        stdcall;
begin
 CreateDiff(Np,h);    //1 <= Np <=20 порядок интерполяционного многочлена; h <= 0.1
end;



procedure Lib_AddOperationSymbToList(OpSymb: Char; NArg: Integer; Placement: Integer);
begin
    Foreval.AddOperationSymbToList(OpSymb,NArg,Placement);

    Include(AfterFirstVarEnableSymb, AnsiChar(OpSymb));
    Include(BeforeLastVarEnableSymb, AnsiChar(OpSymb));
    Include(BeforeMiddleVarEnableSymb, AnsiChar(OpSymb));
    Include(AfterMiddleVarEnableSymb, AnsiChar(OpSymb));
end;


{.339}
//procedure flSetOperation(OpSymb: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; NFunc: Cardinal; OpPrior: Integer; NArg: Integer; Placement: Integer);  stdcall;
procedure flSetOperation(OpSymb: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; OperDataP: Pointer);  stdcall;
var
  S: String;
  OperData: TOperData;
  ExeType,Placement: Integer;
  ChOp: Char;
  k: Integer;
  BEnableNameOp: Boolean;
begin

 ClearError;

 try

 S:=Copy({$IFDEF STRINGINT}OpSymb{$ELSE}PtrToStr(OpSymb){$ENDIF},1,Length({$IFDEF STRINGINT}OpSymb{$ELSE}PtrToStr(OpSymb){$ENDIF}));

 OperData:=TOperData(OperDataP^);
 {
   .idOp  -   returned value
   NArg =1:   Placement = _before; Placement = _after;
   NArg =2:   Placement = _between;
   NFunc -    called function  from
              flSetFunction('FuncName',@FS,@idfP); NFunc = idFP.idName;
   OpPrior:   priority of operation

              default:
              2 - arg operations  (NArg=2; Placement = _between;)

              priority add(+),sub(-) = 1
              priority mul(*),div(/) = 2
              priority power(^)      = 3

              1 - arg operations  (NArg=1; Placement = _before, _after)
              priority neg(-) = 1
              priority fact(!),fact2(!!),Re(.re),Im(.im) = 4
              priority addr(@) = 3
              priority conj($)  = 5


 }

 case OperData.ExeType of
    fl_INTERNAL:   ExeType:= _Internal;
    fl_EXTERNAL:   ExeType:= _External;
 end;

 case OperData.Placement of
    fl_BETWEEN:   Placement:= _between;
    fl_BEFORE:    Placement:= _before;
    fl_AFTER:     Placement:= _after;
 end;

   S:=StringReplace(S,#9,'',[rfReplaceAll, rfIgnoreCase]);
   S:=StringReplace(S,' ','',[rfReplaceAll, rfIgnoreCase]);

   if S <> '' then
   begin
     BEnableNameOp:=True;
     for k := 1 to Length(S) do
     begin
        if (S[k] in ProhibitedSymb = True) or  (S[k] in DisableOperatorName = True) {or (S[k] in EnableNameSymb = True)}  then
            BEnableNameOp:=False;
     end;
   end
   else
   BEnableNameOp:=False;

   if   BEnableNameOp = True then
   begin
      Foreval.SetOperationA(S, OperData.idFunc, OperData.OpPrior, OperData.NArg, Placement, ExeType, OperData.idOp);

    
      if OperData.NArg = 2 then
      begin
         ChOp:=S[1];
         Lib_AddOperationSymbToList(ChOp, OperData.NArg, _Any);

         ChOp:=S[Length(S)];
         Lib_AddOperationSymbToList(ChOp, OperData.NArg, _Before);
      end
      else
      if OperData.NArg = 1 then
      begin
         if Placement = _Before then
         begin
            ChOp:=S[Length(S)];
            Lib_AddOperationSymbToList(ChOp, OperData.NArg, _Before);
         end;

      end;


      POperData(OperDataP)^.IdOp:=OperData.IdOp;
   end
   else
   begin
     Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_OPERATOR;
     Lib_ErrorString:=S;
   end;


 except
    Lib_ErrorCode:=E_ERROR_AT_ADDITION_OF_OPERATOR;
    Lib_ErrorString:=S;
 end;

 if  Lib_ErrorCode <> 0 then   _LibError;
end;




{.339}
//procedure flGetOperation(OpSymb: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF};var IdOp: Integer; var NFunc: Integer;  var OpPrior: Integer; var  NArg: Integer; var Placement: Integer); stdcall;
procedure flGetOperation(OpSymb: {$IFDEF STRINGINT}String{$ELSE}Pointer{$ENDIF}; OperDataP: Pointer); stdcall;
var
 S: String;
 OperData: TOperData;
begin

  //OperData:=TOperData(OperDataP^);

  S:=Copy({$IFDEF STRINGINT}OpSymb{$ELSE}PtrToStr(OpSymb){$ENDIF},1,Length({$IFDEF STRINGINT}OpSymb{$ELSE}PtrToStr(OpSymb){$ENDIF}));

  Foreval.GetOperationA(S, OperData.IdOp, OperData.OpPrior, OperData.Placement, OperData.NArg, OperData.idFunc);

  if OperData.Placement = _between then OperData.Placement := fl_BETWEEN
    else
  if OperData.Placement = _before  then  OperData.Placement := fl_BEFORE
    else
  if OperData.Placement = _after   then   OperData.Placement := fl_AFTER;

  POperData(OperDataP)^:=OperData;

end;



//******************************************************************************
//                       CONNECTIONS of LOGIC OPERATIONS   (begin)
//******************************************************************************

procedure ConnectLogicOps(BbyNames: Boolean);
var
OpData: TOperData;
OpSymb: String;
FuncStr: String;
idfP: TidFunc;
_CurrentStringType: Integer;
begin

//flSet(fl_Disable,fl_PRELIM_SYNT_ERROR,0);

_CurrentStringType:=_STRINGTYPE;

_STRINGTYPE:=fl_STRING;

{
 Сonnection of operations  via external functions.
 External functions of two types:
  1.  fl_VARS_VALUES - Specified in the program text -  (LGC_OR, LGC_AND,... in unit Foreval_Command)     .393A
  2.  fl_PRECOMPILED - inline compiled functions. More fast. Are in use.    //some faster, but not safe-thread
}




//   ------------ OR ------------------------



{$IFDEF LOGIC_OPERATORS_INLINE}


  FuncStr:='{$IN+}lgc_or(n1,n2:int)=or(n1,n2)';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,0,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),0,@idfP);
  {$ENDIF};

{$ELSE}

  InitFuncStruct(FS);
  FS.addr:=@LGC_OR;
  FS.CallType:=fl_cdecl;
  FS.Arg:=2;
  FS.ArgType:=fl_real_integer;
  FS.ResultType:=fl_real;
  FS.CallFunc:=fl_VARS_VALUES;
  FS.DeepFPU:=1;
  FuncStr:='lgc_or';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,@FS,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),@FS,@idfP);
  {$ENDIF};

{$ENDIF}


if BbyNames = true then
   OpSymb:='&or&'
 else
   OpSymb:='%';

OpData.idFunc:=idFP.idName;
OpData.OpPrior:=10;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
OpData.idFunc:=idFP.idName;
OpData.ExeType:=fl_EXTERNAL;
{$IFDEF STRINGINT}
flSetOperation(OpSymb,@OpData);
{$ELSE}
flSetOperation(Pointer(OpSymb),@OpData);
{$ENDIF};



 //   ------------ AND ------------------------


{$IFDEF LOGIC_OPERATORS_INLINE}

  FuncStr:='{$IN+}lgc_and(n1,n2:int)=and(n1,n2)';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,0,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),0,@idfP);
  {$ENDIF};

{$ELSE}

  InitFuncStruct(FS);
  FS.addr:=@LGC_AND;
  FS.CallType:=fl_cdecl;
  FS.Arg:=2;
  FS.ArgType:=fl_real_integer;
  FS.ResultType:=fl_real;
  FS.CallFunc:=fl_VARS_VALUES;
  FS.DeepFPU:=1;
  FuncStr:='lgc_and';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,@FS,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),@FS,@idfP);
  {$ENDIF};

{$ENDIF}


if BbyNames = true then
   OpSymb:='&and&'
 else
   OpSymb:='&';

OpData.idFunc:=idFP.idName;
OpData.OpPrior:=11;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
OpData.idFunc:=idFP.idName;
OpData.ExeType:=fl_EXTERNAL;
{$IFDEF STRINGINT}
flSetOperation(OpSymb,@OpData);
{$ELSE}
flSetOperation(Pointer(OpSymb),@OpData);
{$ENDIF};


 //   ------------ XOR ------------------------



{$IFDEF LOGIC_OPERATORS_INLINE}

  FuncStr:='{$IN+}lgc_xor(n1,n2:int)=xor(n1,n2)';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,0,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),0,@idfP);
  {$ENDIF};

{$ELSE}

  InitFuncStruct(FS);
  FS.addr:=@LGC_XOR;
  FS.CallType:=fl_cdecl;
  FS.Arg:=2;
  FS.ArgType:=fl_real_integer;
  FS.ResultType:=fl_real;
  FS.CallFunc:=fl_VARS_VALUES;
  FS.DeepFPU:=1;
  FuncStr:='lgc_xor';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,@FS,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),@FS,@idfP);
  {$ENDIF};

{$ENDIF}


if BbyNames = true then
   OpSymb:='&xor&'
 else
   OpSymb:='~';


OpData.idFunc:=idFP.idName;
OpData.OpPrior:=10;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
OpData.idFunc:=idFP.idName;
OpData.ExeType:=fl_EXTERNAL;
{$IFDEF STRINGINT}
flSetOperation(OpSymb,@OpData);
{$ELSE}
flSetOperation(Pointer(OpSymb),@OpData);
{$ENDIF};


//   ------------ NOT ------------------------


{$IFDEF LOGIC_OPERATORS_INLINE}

  FuncStr:='{$IN+}lgc_not(n:int)=not(n)';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,0,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),0,@idfP);
  {$ENDIF};

{$ELSE}

  InitFuncStruct(FS);
  FS.addr:=@LGC_NOT;
  FS.CallType:=fl_cdecl;
  FS.Arg:=1;
  FS.ArgType:=fl_real_integer;
  FS.ResultType:=fl_real;
  FS.CallFunc:=fl_VARS_VALUES;
  FS.DeepFPU:=1;
  FuncStr:='lgc_not';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,@FS,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),@FS,@idfP);
  {$ENDIF};

{$ENDIF}


if BbyNames = true then
   OpSymb:='not&'
 else
   OpSymb:='!';

OpData.idFunc:=idFP.idName;
OpData.OpPrior:=12;
OpData.NArg:=1;
OpData.Placement:=fl_BEFORE;
OpData.idFunc:=idFP.idName;
OpData.ExeType:=fl_EXTERNAL;
{$IFDEF STRINGINT}
flSetOperation(OpSymb,@OpData);
{$ELSE}
flSetOperation(Pointer(OpSymb),@OpData);
{$ENDIF};



//   ------------ NOR ------------------------


{$IFDEF LOGIC_OPERATORS_INLINE}

  FuncStr:='{$IN+}lgc_nor(n1,n2:int)=nor(n1,n2)';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,0,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),0,@idfP);
  {$ENDIF};

{$ELSE}

  InitFuncStruct(FS);
  FS.addr:=@LGC_NOR;
  FS.CallType:=fl_cdecl;//fl_stdcall;
  FS.Arg:=2;
  FS.ArgType:=fl_real_integer;
  FS.ResultType:=fl_real;
  FS.CallFunc:=fl_VARS_VALUES;
  FS.DeepFPU:=1;
  FuncStr:='lgc_nor';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,@FS,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),@FS,@idfP);
  {$ENDIF};

{$ENDIF}


if BbyNames = true then
   OpSymb:='&nor&'
 else
   OpSymb:='!%';

OpData.idFunc:=idFP.idName;
OpData.OpPrior:=10;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
OpData.idFunc:=idFP.idName;
OpData.ExeType:=fl_EXTERNAL;
{$IFDEF STRINGINT}
flSetOperation(OpSymb,@OpData);
{$ELSE}
flSetOperation(Pointer(OpSymb),@OpData);
{$ENDIF};



 //   ------------ NAND ------------------------


{$IFDEF LOGIC_OPERATORS_INLINE}

  FuncStr:='{$IN+}lgc_nand(n1,n2:int)=nand(n1,n2)';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,0,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),0,@idfP);
  {$ENDIF};

{$ELSE}

  InitFuncStruct(FS);
  FS.addr:=@LGC_NAND;
  FS.CallType:=fl_cdecl;
  FS.Arg:=2;
  FS.ArgType:=fl_real_integer;
  FS.ResultType:=fl_real;
  FS.CallFunc:=fl_VARS_VALUES;
  FS.DeepFPU:=1;
  FuncStr:='lgc_nand';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,@FS,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),@FS,@idfP);
  {$ENDIF};

{$ENDIF}


if BbyNames = true then
   OpSymb:='&nand&'
 else
   OpSymb:='!&';

OpData.idFunc:=idFP.idName;
OpData.OpPrior:=11;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
OpData.idFunc:=idFP.idName;
OpData.ExeType:=fl_EXTERNAL;
{$IFDEF STRINGINT}
flSetOperation(OpSymb,@OpData);
{$ELSE}
flSetOperation(Pointer(OpSymb),@OpData);
{$ENDIF};



 //   ------------ XNOR ------------------------


{$IFDEF LOGIC_OPERATORS_INLINE}

  FuncStr:='{$IN+}lgc_xnor(n1,n2:int)=xnor(n1,n2)';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,0,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),0,@idfP);
{$ENDIF};

{$ELSE}

  InitFuncStruct(FS);
  FS.addr:=@LGC_XNOR;
  FS.CallType:=fl_cdecl;
  FS.Arg:=2;
  FS.ArgType:=fl_real_integer;
  FS.ResultType:=fl_real;
  FS.CallFunc:=fl_VARS_VALUES;
  FS.DeepFPU:=1;
  FuncStr:='lgc_xnor';
  {$IFDEF STRINGINT}
  flSetFunction(FuncStr,@FS,@idfP);
  {$ELSE}
  flSetFunction(Pointer(FuncStr),@FS,@idfP);
  {$ENDIF};

{$ENDIF}


if BbyNames = true then
   OpSymb:='&xnor&'
 else
   OpSymb:='!~';

OpData.idFunc:=idFP.idName;
OpData.OpPrior:=10;
OpData.NArg:=2;
OpData.Placement:=fl_BETWEEN;
OpData.idFunc:=idFP.idName;
OpData.ExeType:=fl_EXTERNAL;
{$IFDEF STRINGINT}
flSetOperation(OpSymb,@OpData);
{$ELSE}
flSetOperation(Pointer(OpSymb),@OpData);
{$ENDIF};

F_ConnectLogicOps:=True;


_STRINGTYPE:=_CurrentStringType;

end;



//******************************************************************************
//                       CONNECTIONS of LOGIC OPERATIONS   (end)
//******************************************************************************



//************************** AUXILIARY *****************************************


// Copy array of Extended SrcAddr =>  DstAddr; with Len elements(cell)
{
  SrcAddr = @ArraySource[0]
  DstAddr = @ArrayDestination[0]
  Len = Length(ArraySource) = Length(ArrayDestination)
}
procedure flCopyArrayExt(DstAddr: Pointer; SrcAddr: Pointer;  Len: Integer);   stdcall;
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



// Copy array of Double SrcAddr =>  DstAddr; with Len elements(cell)
{
  SrcAddr = @ArraySource[0]
  DstAddr = @ArrayDestination[0]
  Len = Length(ArraySource) = Length(ArrayDestination)
}
procedure flCopyArrayDbl(DstAddr: Pointer; SrcAddr: Pointer;  Len: Integer);   stdcall;
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



// Copy array of Integer SrcAddr =>  DstAddr; with Len elements(cell)
{
  SrcAddr = @ArraySource[0]
  DstAddr = @ArrayDestination[0]
  Len = Length(ArraySource) = Length(ArrayDestination)
}
procedure flCopyArrayInt(DstAddr: Pointer; SrcAddr: Pointer;  Len: Integer);   stdcall;
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


{
 Copy array of Extended type   with different size of cell in memory;
 SrcAddr =>  DstAddr;  Len - elements(cell)  of array
 SrcAddr = @ArraySource[0]
 DstAddr = @ArrayDestination[0]
 Len = Length(ArraySource) = Length(ArrayDestination)
 CellSizeSrc -  size of cell  source      array
 CellSizeDst -  size of cell  destination array


 On default, size of cell of extended array must be 10 bytes.
 But in ,for example, in GCC cell of extended array = 12 bytes;

}

procedure   flCopyArrayExtDSC(DstAddr: Pointer; SrcAddr: Pointer;  CellSizeSrc:Integer; CellSizeDst:Integer; Len: Integer);  stdcall;
asm

  pushad

  mov   ecx,Len
  mov   esi,SrcAddr
  mov   edi,DstAddr
  mov   eax,CellSizeSrc
  mov   edx,CellSizeDst


  test ecx,ecx
  jz @@endp
  test esi,esi
  jz @@endp
  test edi,edi
  jz @@endp



  mov   bx,cx
  shr   ecx,3
  and   bx,7

  test ecx,ecx
  jz  @@cycl1


  @@cyclx8:

     lea edi, [edi+8*edx]
     sub      edi,edx

     fld   tbyte ptr[esi]
      add    esi,eax
     fld   tbyte ptr[esi]
      add    esi,eax
     fld   tbyte ptr[esi]
      add    esi,eax
     fld   tbyte ptr[esi]
      add    esi,eax
     fld   tbyte ptr[esi]
      add    esi,eax
     fld   tbyte ptr[esi]
      add    esi,eax
     fld   tbyte ptr[esi]
      add    esi,eax
     fld   tbyte ptr[esi]
      add    esi,eax


     fstp   tbyte ptr[edi]
      sub    edi,edx
     fstp   tbyte ptr[edi]
      sub    edi,edx
     fstp   tbyte ptr[edi]
      sub    edi,edx
     fstp   tbyte ptr[edi]
      sub    edi,edx
     fstp   tbyte ptr[edi]
      sub    edi,edx
     fstp   tbyte ptr[edi]
      sub    edi,edx
     fstp   tbyte ptr[edi]
      sub    edi,edx
     fstp   tbyte ptr[edi]


     lea edi, [edi+8*edx]

    dec      ecx


  jnz   @@cyclx8



  @@cycl1:

    mov   cx,bx
    jcxz @@endp



  @@cyclx1:

        fld   tbyte ptr[esi]
          add    esi,eax

        fstp   tbyte ptr[edi]
          add    edi,edx

        dec   cx

  jnz   @@cyclx1


@@endp:

  popad

{
        pushad

        mov     esi,SrcAddr
        mov     edi,DstAddr
        mov     ecx,Len

        @@loop:
        mov     eax,[esi]
        mov     ebx,[esi+4]
        mov     dx, [esi+8]

        mov     [edi],  eax
        mov     [edi+4],ebx
        mov     [edi+8],dx

        add     esi, CellSizeSrc
        add     edi, CellSizeDst

        dec     ecx
        jnz     @@loop

        popad
 }

end;




// Copy NBytes bytes SrcAddr =>  DstAddr;
procedure   flCopyMemory(DstAddr: Pointer; SrcAddr: Pointer;  NBytes:Integer);  stdcall;
asm
        push    edi
        push    esi
        push    ecx

        cld
        mov     esi,SrcAddr
        mov     edi,DstAddr
        mov     ecx,NBytes
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




procedure flCopyVarCxD(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
begin
  //PComplexD(AddrDst)^ := PComplexD(AddrSrc)^;
  // more fast than above^:
  PDouble(AddrDst)^:=PDouble(AddrSrc)^;
  PDouble(Cardinal(AddrDst)+8)^:=PDouble(Cardinal(AddrSrc)+8)^;
end;


procedure flCopyVarCxE(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
begin
  //PComplexE(AddrDst)^ := PComplexE(AddrSrc)^;
  // more fast than above^:
  PExtended(AddrDst)^:=PExtended(AddrSrc)^;
  PExtended(Cardinal(AddrDst)+16)^:=PExtended(Cardinal(AddrSrc)+16)^;
end;

procedure flCopyVarD(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
begin
   PDouble(AddrDst)^ := PDouble(AddrSrc)^;
end;

procedure flCopyVarE(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
begin
   PExtended(AddrDst)^:=PExtended(AddrSrc)^;
end;

procedure flCopyVarI(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;
begin
   PInteger(AddrDst)^:=PInteger(AddrSrc)^;
end;

procedure _DestroyLib;
begin
{.324}
//dispose(G_PAtr);
//G_PAtr:=nil;

  FreeCmplFuncList;
  CompZ:=nil;
  pcFreeIntVar;
  Foreval.Destroy;
end;


procedure _CreateLib;
begin
   //SetMinimumBlockAlignment(mba16Byte);
 Foreval:=TForevalDll.Create;
 //CreateClass;
 SetLength(CompZ,1);
 SetLength(SaveVar,0);
 SetLength(SaveVarD,0);
 Foreval.ShowException:=false;
 Foreval.DataType:=_Extended;  //_Double;
 Foreval.FastSpec(False);
 Foreval.FastStdFunc(_Real,True);
 Foreval.FastStdFunc(_Complex,True);
 //Foreval.FastDivision:=True;
 Foreval.SetDivMode(_fast); {.345}

 F_CalcConsExprInMulti:=True; {.221}
 _STRINGTYPE:=fl_STRING;
 F_EXTENDED_COMMAND:=True;
 F_REPLACE_MULTI_EXPR:=True;
 F_MULTI_EXPR:=True; {.369}
 F_FREE_CODE_AT_REPLACE := True;
 F_LeadToLowerCase:=True;
 F_PACKAGE_COMPILE:=False;
 S_Package_Expression:='';
 N_Count_Package_Var:=0;
 P_PackageCompileAddr:=nil;
 F_ConnectLogicOps:=False;    {.379}
 Len_SLABEL:=Length(S_Label);
 IntrnlVarCount:=0;


  //задание смещения к длине динамических массивов для совместимости между DELPH & FPC
    flSet(fl_COMPILER_TYPE_EXE, fl_DELPHI, 0);   {.357}

 {$IFDEF FPC}
    flSet(fl_COMPILER_TYPE_EXE, fl_FREE_PASCAL, 0);   {.357}
 {$ENDIF}


 {
  вкл. контроль ошибки в команде SetLen(Array), если массив может быть задан из-вне dll
  если компиляция EXE идёт вместе с прямым подключениенм Foreval, то контроль отключить, т.к. используется общий  менеджер памяти
 }
   {.357}
   flSet(fl_DISABLE, fl_CHECK_ARRAY_TYPE_CONNECT , 0);
{$IFDEF USEDLL}
   flSet(fl_ENABLE, fl_CHECK_ARRAY_TYPE_CONNECT , 0);
{$ENDIF}



 //принудительное сохранение регистров если в выражении присутствует внешняя функция
 {SetReg(_EAX,_SAVE);
 SetReg(_EBX,_SAVE);
 SetReg(_ECX,_SAVE);
 SetReg(_EDX,_SAVE);}
 F_CurrentIntFunc:=0;
 new(InternalVarList);
 InternalVarList^.Next:=nil;
 BInternalVarList:=InternalVarList;
 //_SetVar('pi',@c_pi,fl_Real_Extended);
 {.334}
 flSetParamE({$IFDEF STRINGINT}'pi'{$ELSE}StrToPtr('pi'){$ENDIF},c_pi,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'2pi'{$ELSE}StrToPtr('2pi'){$ENDIF},c_2pi,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'exp1'{$ELSE}StrToPtr('exp1'){$ENDIF},c_exp1,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'eul'{$ELSE}StrToPtr('eul'){$ENDIF},c_eul,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'ln2'{$ELSE}StrToPtr('ln2'){$ENDIF},c_ln2,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'ln10'{$ELSE}StrToPtr('ln10'){$ENDIF},c_ln10,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'lg2'{$ELSE}StrToPtr('lg2'){$ENDIF},c_lg2,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'lge'{$ELSE}StrToPtr('lge'){$ENDIF},c_lge,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'l2e'{$ELSE}StrToPtr('l2e'){$ENDIF},c_l2e,0,fl_REAL);
 flSetParamE({$IFDEF STRINGINT}'l2g'{$ELSE}StrToPtr('l2g'){$ENDIF},c_l2g,0,fl_REAL);


 Lib_ErrorCode:=0;
 Lib_ErrorCodeDiff:=0;
 SetNameTypes;

 flSet(fl_Stack_Type,fl_Extended,0);
 flSet(fl_Disable,fl_Show_Exception,0);
 flSet(fl_SPEC_FUNC,fl_FAST,0);
 flSet(fl_Enable,fl_REPLACE_DIV,0);
 flSet(fl_Enable,fl_REPLACE_MUL,0 );
 flSet(fl_Enable,fl_REPLACE_ADDSUB,0);
 flSet(fl_Disable,fl_CHECK_INCORRECT_SPACE,0);
 flSet(fl_RESULT_LEAD_TO_TYPE,fl_STAY_AS_IS,0);
 flSet(fl_DISABLE,fl_USE_INTEGER_POINTER,0);
 flSet(fl_Enable,fl_FREE_MAIN_DIFF_EXPR ,0);
 flSet(fl_TYPE_OF_DIFFERENTIATION,fl_SYMBOLIC,0);
 //flSet(fl_Enable,fl_USE_VIRTUAL_ALLOC,0 );
 //flSet(fl_Enable, fl_MASK_FPU_EXCEPTION,0);
 //flSet(fl_Disable,fl_ACCURATE_SPEC_FUNC,0);
 //flSet(fl_ARCCOTAN_TYPE,fl_ARCCOTAN_STD,0);


 F_CALC_EXCEPTION_IN_SAFE:=0;
 F_ClearCurrentNameSet:=True;
 GA_TmpExeptionFlag:=0;
 GA_ExceptionFlagAddr:=TAddress(@GA_TmpExeptionFlag);
 //flSet(fl_PRECISION,fl_EXTENDED);
 //Set8087CW($1372);
 CalcCW:=$1372;
 CWMEM:=$1372;
 flPerform(fl_INIT_FPU,0);
 GetLocaleFormatSettings(0,G_FMT);
 G_FMT.DecimalSeparator:='.';

 ControlSpaceSymb := EnableNameSymb;
 Include(ControlSpaceSymb, '.');


 CreateDiff(14,fc_power(0.1,2));   //1 <= Np <=20 порядок интерполяционного многочлена; h <= 0.01=(0.1)^2

 InitFuncStruct(FuncFS);
 FuncFS.addr:=@Derivative1;
 FuncFS.Arg:=3;
 FuncFS.ArgType:=fl_Real_Integer;
 FuncFS.CallType:=fl_stdcall;
 FuncFS.CallFunc:=fl_VARS_VALUES;
 FuncFS.DeepFPU:=8;//макс.: т.к. не учитывается DeepFPU дифф. функции
 FuncFS.ReplFunc:=fl_YES;
 FuncFS.CalcConst:=fl_NO;
 FuncFS.SaveReg:=15;
 FuncFS.ResultType:=fl_Real;
 FuncFS.ResultTypeMath := fl_EXTENDED;


 Foreval.EnableCheckName := False;
   _SetFunction(SCdiff1,@FuncFS,@IDtmpP);
   FuncFS.addr:=@Derivative2;
   _SetFunction(SCdiff2,@FuncFS,@IDtmpP);
   FuncFS.addr:=@Derivative3;
   _SetFunction(SCdiff3,@FuncFS,@IDtmpP);
   FuncFS.addr:=@Derivative4;
   _SetFunction(SCdiff4,@FuncFS,@IDtmpP);
   FuncFS.Arg:=4;
   FuncFS.addr:=@DerivativeN;
   _SetFunction(SCdiffN,@FuncFS,@IDtmpP);
 Foreval.EnableCheckName := True;

 //_MaxDeriv:=0;

(*
 new(G_PAtr); {.324}
 G_PAtr^.FType:=0;
 G_PAtr^.AddrRE:=0;
 G_PAtr^.AddrIM:=0;
 *)


 G_Atr0.FType:=0;     //!!!
 G_Atr0.AddrRE:=0;    //!!!
 G_Atr0.AddrIM:=0;    //!!!

 G_Atr.FType:=0;
 G_Atr.AddrRE:=0;
 G_Atr.AddrIM:=0;

 GC_PAtr:=nil;

 ClearError;

SwitchFPUExceptSpecFunc:=Foreval.SwitchFastSpecFPUException;

{$IFDEF FPC}
    _COMPILED_BY:=FPC_COMPILED_BY;
{$ELSE}
    _COMPILED_BY:=Trunc(DELPHI_COMPILED_BY);
{$ENDIF}

end;


initialization
begin
   _CreateLib;
end;



finalization
begin
   _DestroyLib;
end;

end.
