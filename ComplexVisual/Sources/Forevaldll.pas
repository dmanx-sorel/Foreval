unit Forevaldll;

{******************************************************************************}
{                                                                              }
{               SOREL  (C)CopyRight 2000+. Russia                              }
{                                                                              }
{                          Foreval.dll interface unit                          }
{                               ver. 9.1.1.395                                 }
{******************************************************************************}




interface

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}


{
При подключении к проекту установить ключ (STRING, ANSISTRING, WIDESTRING, UTF8, PANSICHAR) cоответствующий типу передаваемых строк
В проекте при инициализации Foreval.dll установить такой же ключ соответствующей коммандой:

When connecting to a project need to install a key (STRING, ANSISTRING, WIDESTRING, PANSICHAR, UTF8 ) corresponding type of passed strings
In the project  at initialization Foreval.dll set the same key corresponding commands:

flSet(fl_STRING_TYPE,fl_STRING_UTF16,0)
flSet(fl_STRING_TYPE,fl_ANSISTRING,0)
flSet(fl_STRING_TYPE,fl_WIDESTRING,0)
flSet(fl_STRING_TYPE,fl_ANSISTRING,0)
flSet(fl_STRING_TYPE,fl_STRING_UTF8,0)

}

 {.$DEFINE STRING}
 {$DEFINE ANSISTRING}
 {.$DEFINE WIDESTRING}
 {.$DEFINE PANSICHAR}
 {.$DEFINE UTF8}



{$IFDEF STRING}       type TStringType = String;       {$ENDIF}   {set flSet(fl_STRING_TYPE,fl_STRING)} //UTF16 only for delphi2009+

{$IFDEF ANSISTRING}   type TStringType = AnsiString;   {$ENDIF}   {set flSet(fl_STRING_TYPE,fl_ANSISTRING)}

{$IFDEF WIDESTRING}   type TStringType = WideString;    {$ENDIF}  {set flSet(fl_STRING_TYPE,fl_WIDESTRING)}

{$IFDEF PANSICHAR}    type TStringType = PAnsiChar;    {$ENDIF}  {set flSet(fl_STRING_TYPE,fl_PAnsiChar)}

{$IFDEF UTF8}         type TStringType = UTF8String;       {$ENDIF}   {set flSet(fl_STRING_TYPE,fl_STRING_UTF8) }






const
MathDll = 'Foreval.dll';


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
fl_RESULT_LEAD_TO_TYPE  = 26;
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
fl_DATA_IN_ARRAY                               = 157;
fl_INTERNAL_ERROR_CODE                         = 158;
fl_SPEC_FUNC                                   = 159;
fl_FAST                                        = 160;
fl_ACCURATE                                    = 161;
fl_STD_FUNC_REAL                               = 162;  {.335}
fl_STD_FUNC_COMPLEX                            = 163;  {.335}
fl_COMPLEX_DIV                                 = 164;  {.335}
fl_STD_FUNC                                    = 165;  {.335}
fl_DISABLE_OPERATION                           = 166;  {.339}
fl_ENABLE_OPERATION                            = 167;  {.339}
fl_BETWEEN                                     = 168;  {.339}
fl_BEFORE                                      = 169;  {.339}
fl_AFTER                                       = 170;  {.339}
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
fl_CREATE                                      = 226;
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
fl_NAME_ALREADY_USED              = 77; {.378}
fl_WRONG_PLACEMENT_OPERATOR       = 78; {.383}
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

  const _Pascal = 1;
  const _StdCall = 2;
  const _Cdecl = 3;
  const _STACK_ADR = 1;
  const _STACK_VAL = 2;
  const _ESP = 4;
  const _EAX = 5;
  const _EBX = 6;
  const _ECX = 7;
  const _EDX = 8;
  const _Compiled = 9;


  const R_EAX = 1;
  const R_EBX = 2;
  const R_ECX = 3;
  const R_EDX = 4;
  const R_ESP = 5;
  const R_EBP = 6;
  const R_ESI = 7;
  const R_EDI = 8;
  const _CLEAR = 1;
  const _SAVE = 2;

   }
const
 _Complex  = 2; //=T_Complex  !!!
 _Real  = 1;    //=T_Real     !!!
 _Array = 3;  //=T_Array   !!!
 _Integer = 4; //=T_Integer

type TArrayC = array of Cardinal;
type TArrayI = array of Integer;
type TArrayP = array of Pointer;
type PArrayP = ^TArrayP;

type
TComplexD =  record
               re: double;
               im: double;
              end;

//size of (TComplexE)  must be = 32 bytes!!!  On each field - 16 bytes!!!
type
TComplexE = record
              re: extended;
              im: extended;
            end;


type
TComplexS =  record
               re: single;
               im: single;
              end;

type
PComplexE = ^TComplexE;

type
PComplexD = ^TComplexD;

type
PComplexS = ^TComplexS;

type TArrayD = array of Double;
type TArrayE = array of extended;
type TArrayS = array of single;
type PArrayD = ^TArrayD;
type PArrayE = ^TArrayE;
type PArrayS = ^TArrayS;

type TidFunc = record  //IDFP = ^TidFunc             {.300}
                  idName: Integer; //IDN
                  idArg:  Integer;
               end;

type TOperData = record
                    IdOp:      Integer;
                    idFunc:    Integer;   // = TidFunc.idName
                    OpPrior:   Integer;
                    NArg:      Integer;
                    Placement: Integer;
                    ExeType:   Integer;
                 end;

type
TAttrib    = record
               MType:    Integer; //тип сохраняемого результата
                            //MType = fl_Double,fl_Integer,fl_Extended,fl_Single
               AddrRE:   Pointer;//Cardinal; //адрес сохраняемого результата (непосредственный - Address)
               AddrIM:   Pointer;//Cardinal; //адрес сохраняемого результата (непосредственный - Address)
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



 //в реальных шаблонах функций в Foreval.dll переменные стоковых типов передаются через Pointer:
 //вместо String(UTF16) можно использовать: AnsiString (PAnsiChar) ,WideString, UTF8
//по-умолчанию установлен String(UTF16) для delphi2009+

 //In real templates of functions in Foreval.dll variables of string types are transferred through Pointer:
 //instead of String(UTF16) may use: AnsiString (PAnsiChar),  WideString, UTF8
//The default is set String(UTF16) for  delphi2009+

 //flSet(fl_STRING_TYPE,fl_ANSISTRING),  flSet(fl_STRING_TYPE,fl_WIDESTRING),  flSet(fl_STRING_TYPE,fl_STRING_UTF16),  flSet(fl_STRING_TYPE,fl_STRING_UTF8),




        procedure flCompile(Expr: TStringType; PAttr: Pointer; var Func: Pointer);    stdcall;  external MathDll;
        procedure flCompileATE(Expr: TStringType; PAttr: Pointer; var Func: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal);    stdcall;  external MathDll;
        procedure flSetExpression(Expr: TStringType; PAttr: Pointer;  action: Integer; var Func: Pointer; var CError: Cardinal); stdcall;   external MathDll;
        procedure flSetVar(Name: TStringType; Addr: Pointer; TypeV: Cardinal);        stdcall;  external MathDll;
        procedure flSetVarCx(Name: TStringType; AddrRE: Pointer; AddrIM: Pointer; TypeV: Cardinal);  stdcall; external MathDll;
        procedure flSetParamD(Name: TStringType; Re,Im: Double;  TypeP: Cardinal);    stdcall;  external MathDll;
        procedure flSetParamE(Name: TStringType; Re,Im: Extended;  TypeP: Cardinal);  stdcall;  external MathDll;
        procedure flSetParamI(Name: TStringType; IParam: Integer);                    stdcall;  external MathDll;
        procedure flSetFunction(FName: TStringType; FAdr: Pointer;  idfP: Pointer);   stdcall;  external MathDll;
        procedure flSet(mode: Cardinal; value1,value2: Integer);                      stdcall;  external MathDll;
        procedure flGet(mode,subj: Cardinal; var value: Cardinal);                    stdcall;  external MathDll;
        procedure flGetErrorCode(var CError: Cardinal);                               stdcall;  external MathDll;
        procedure flGetErrorString(var SError: {TStringType}Pointer);                 stdcall;  external MathDll;
        procedure flCheckName(Name: TStringType ;  var Answ: Integer);                stdcall;   external MathDll;
        procedure flPerform(act,subj: Cardinal);                                                               stdcall;  external MathDll;
        procedure flResultCxD(Func: Pointer; var Re,Im: Double);                                               stdcall;  external MathDll;
        procedure flResultCxE(Func: Pointer; var Re,Im: Extended);                                             stdcall;  external MathDll;
        procedure flResultCxDP(Func: Pointer;  Res: Pointer);                                                  stdcall;  external MathDll;
        procedure flResultCxEP(Func: Pointer;  Res: Pointer);                                                  stdcall;  external MathDll;
        procedure flResultD(Addr: Pointer;  var Res: double);                                                  stdcall;  external MathDll;
        procedure flResultE(Addr: Pointer;  var Res: extended);                                                stdcall;  external MathDll;
        procedure flResult(Func: Pointer);                                                                     stdcall;  external MathDll;
        function  flResultR(Func: Pointer):Extended;                                                           stdcall;  external MathDll  name 'flResult';


        function flResultSafe(Addr: Pointer): HRESULT;                                                     stdcall; external MathDll;
        function flResultSafeD(Addr: Pointer;  var Res: double): HRESULT;                                  stdcall; external MathDll;
        function flResultSafeE(Addr: Pointer;  var Res: extended): HRESULT;                                stdcall; external MathDll;
        function flResultSafeCxD(Addr: Pointer;  var Re,Im: double): HRESULT;                              stdcall; external MathDll;
        function flResultSafeCxE(Addr: Pointer;  var Re,Im: extended): HRESULT;                            stdcall; external MathDll;
        function flResultSafeCxDP(Addr: Pointer;  Res: Pointer): HRESULT;                                  stdcall; external MathDll;
        function flResultSafeCxEP(Addr: Pointer;  Res: Pointer): HRESULT;                                  stdcall; external MathDll;


        procedure flSetExtAddrErrorFPU(ErrFpuAddr: Pointer); stdcall;            external MathDll;
        procedure flMaskFPUException;            stdcall;                        external MathDll;
        procedure flResetMaskFPUException;       stdcall;                        external MathDll;
        function  flGetFPUException: Cardinal;   stdcall;                        external MathDll;
        function  flIsNAN(val: extended): integer; stdcall;                      external MathDll;

        procedure   flResultMaskedFPU(Addr: Pointer);                             stdcall;     external MathDll;
        function    flResultRMaskedFPU(Addr: Pointer):Extended;                   stdcall;     external MathDll  name 'flResultMaskedFPU';
        procedure   flResultMaskedFpuE(Addr: Pointer; var Res: Extended);         stdcall;     external MathDll;
        procedure   flResultMaskedFpuD(Addr: Pointer; var Res: Double);           stdcall;     external MathDll;
        procedure   flResultMaskedFpuCxE(Addr: Pointer; var Re,Im: extended);     stdcall;     external MathDll;
        procedure   flResultMaskedFpuCxD(Addr: Pointer; var Re,Im: double);       stdcall;     external MathDll;
        procedure   flResultMaskedFpuCxEP(Addr: Pointer;  Res: Pointer);          stdcall;     external MathDll;
        procedure   flResultMaskedFpuCxDP(Addr: Pointer;  Res: Pointer);          stdcall;     external MathDll;


        procedure flPolarDP(pz: Pointer;   pz1: Pointer);                                                      stdcall;  external MathDll;
        procedure flPolarEP(pz: Pointer;   pz1: Pointer);                                                      stdcall;  external MathDll;
        procedure flDecartDP(pz: Pointer;  pz1: Pointer);                                                      stdcall;  external MathDll;
        procedure flDecartEP(pz: Pointer;  pz1: Pointer);                                                      stdcall;  external MathDll;
        procedure flSetVarIntrnl(Name:  TStringType;  TypeV: Cardinal; var ExAddr: Pointer);                   stdcall;  external MathDll;
        procedure flSetVarValueD(Addr: Pointer;  Val: Double);       stdcall; external MathDll;
        procedure flSetVarValueE(Addr: Pointer;  Val: Extended);       stdcall; external MathDll;
        procedure flSetVarValueI(Addr: Pointer;  Val: Integer);       stdcall; external MathDll;
        procedure flSetVarValueS(Addr: Pointer;  Val: Single);       stdcall;   external MathDll;
        procedure flSetVarValueCxS(Addr: Pointer;  ValRe,ValIm: Single);       stdcall;  external MathDll;
        procedure flSetVarValueCxD(Addr: Pointer;  ValRe,ValIm: Double);       stdcall;  external MathDll;
        procedure flSetVarValueCxE(Addr: Pointer;  ValRe,ValIm: Extended);       stdcall; external MathDll;
        procedure flSetLength(AdrV: Pointer; TypeV: Cardinal; Len: Cardinal);  stdcall; external MathDll;
        procedure flSetArrayValueI(AdrV: Pointer; indx: Cardinal; Val: integer);  stdcall;  external MathDll;
        procedure flSetArrayValueD(AdrV: Pointer; indx: Cardinal; Val: double);  stdcall;   external MathDll;
        procedure flSetArrayValueE(AdrV: Pointer; indx: Cardinal; Val: extended);  stdcall;  external MathDll;
        procedure flSetArrayValueS(AdrV: Pointer; indx: Cardinal; Val: single);  stdcall;  external MathDll;
        procedure flGetVarValueE(Addr: Pointer; var Val: Extended);       stdcall; external MathDll;
        procedure flGetVarValueI(Addr: Pointer; var Val: Integer);       stdcall; external MathDll;
        procedure flGetVarValueD(Addr: Pointer; var Val: Double);       stdcall; external MathDll;
        procedure flGetVarValueS(Addr: Pointer; var Val: Single);       stdcall;  external MathDll;
        procedure flGetArrayValueI(AdrV: Pointer; indx: Cardinal; var Val: integer);  stdcall; external MathDll;
        procedure flGetArrayValueD(AdrV: Pointer; indx: Cardinal; var Val: double);  stdcall;  external MathDll;
        procedure flGetArrayValueE(AdrV: Pointer; indx: Cardinal; var Val: extended);  stdcall; external MathDll;
        procedure flGetArrayValueS(AdrV: Pointer; indx: Cardinal; var Val: single);  stdcall;  external MathDll;
        procedure flGetVarValueCxS(Addr: Pointer;  var ValRe,ValIm: Single);       stdcall;  external MathDll;
        procedure flGetVarValueCxD(Addr: Pointer;  var ValRe,ValIm: Double);       stdcall;  external MathDll;
        procedure flGetVarValueCxE(Addr: Pointer;  var ValRe,ValIm: Extended);       stdcall; external MathDll;
        procedure flSetNameImUnit(Name:  TStringType);   stdcall;  external MathDll;
        procedure flLoadFPUD(RE: Double; Im: Double);  stdcall;  external MathDll;
        procedure flLoadFPUE(RE: Extended; Im: Extended);  stdcall; external MathDll;
        procedure flLoadFPUDP(Adr: Pointer);  stdcall;   external MathDll;
        procedure flLoadFPUEP(Adr: Pointer);  stdcall; external MathDll;
        procedure flSetDiffVar(NName:  TStringType);        stdcall; external MathDll;
        procedure flSetDiffExpr(Expr:  TStringType);         stdcall; external MathDll;
        procedure flDiffExpr(N: Cardinal);                                                      stdcall;  external MathDll;
        procedure flGetDiffString(var S:  Pointer{TStringType}); stdcall;  external MathDll;
        procedure flCompileDiffExpr(var Addr: Pointer);    stdcall;  external MathDll;
        procedure flCompileDeriv(Expr:  TStringType; VName:  TStringType; N: Cardinal; var Addr: Pointer);   stdcall;   external MathDll;

        procedure flCompileDerivATE(Expr: TStringType; VName: TStringType;  N: Cardinal;  PAttr:  Pointer;   var Addr: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal); stdcall;   external MathDll;
        procedure flCompileDiffExprATE(PAttr: Pointer; var Addr: Pointer; var ResType: Cardinal; var ErrorCode: Cardinal);  stdcall;  external MathDll;

        procedure flSetDiffTemplate(idfP: Pointer; TemplateDiff:  TStringType);     stdcall;external MathDll;
		    procedure flSetSplainFunction(FuncName:  TStringType; AdrVX,AdrVY: Pointer; ArrayType: Cardinal;  idfP: Pointer);  stdcall; external MathDll;
        procedure flSetDiffNumCurrency(Np: Cardinal; h: double);        stdcall; external MathDll;

        procedure flRenameFunction(Name,NewName:  TStringType);                       stdcall;  external MathDll;
        procedure flAddNameFunction(IDN: Integer; AddName: TStringType);              stdcall;  external MathDll;  {.191}
        procedure flGetFuncIDN(FName:  TStringType; var IDN: Integer);   stdcall; external MathDll;
		    procedure flGetFunctionIDFP(FName:  TStringType; FData: Pointer;  idfP: Pointer);    stdcall; external MathDll;
        procedure flChangeFunctionProperty(Action: Cardinal; idfP: Pointer); stdcall;  external MathDll;
        procedure flSetOperation(OpSymb: TStringType; OperData: Pointer); stdcall;      external MathDll;
        procedure flGetOperation(OpSymb: TStringType; OperData: Pointer); stdcall;      external MathDll;
        procedure flGetFunctionAddr(idfP: Pointer; var AddrF: Pointer);    stdcall;    external MathDll;

        procedure flCopyArrayExt(DstAddr: Pointer; SrcAddr: Pointer;  Len: Integer);   stdcall;  external MathDll;
        procedure flCopyArrayDbl(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;  external MathDll;
        procedure flCopyArrayInt(DstAddr: Pointer; SrcAddr: Pointer; Len: Integer);   stdcall;  external MathDll;
        procedure flCopyArrayExtDSC(DstAddr: Pointer; SrcAddr: Pointer; CellSizeSrc:Integer; CellSizeDst:Integer; Len: Integer);  stdcall; external MathDll;
        procedure flCopyMemory(DstAddr: Pointer; SrcAddr: Pointer; NBytes:Integer);  stdcall;  external MathDll;
        procedure flCopyVarCxD(AddrDst: Pointer; AddrSrc: Pointer);  stdcall; external MathDll;
        procedure flCopyVarCxE(AddrDst: Pointer; AddrSrc: Pointer);  stdcall; external MathDll;
        procedure flCopyVarD(AddrDst: Pointer; AddrSrc: Pointer);  stdcall; external MathDll;
        procedure flCopyVarE(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;   external MathDll;
        procedure flCopyVarI(AddrDst: Pointer; AddrSrc: Pointer);  stdcall;   external MathDll;



//internal:
procedure InitFuncStruct(var FS: TAddFuncStruct);
function  CalcFunctionD(Func: Pointer): double;
function  CalcFunctionE(Func: Pointer): extended;
function  CalcFunctionZD(Func: Pointer):TComplexD;
function  CalcFunctionZE(Func: Pointer): TComplexE;





implementation

procedure InitFuncStruct(var FS: TAddFuncStruct);
begin
  FS.addr:=nil;
  FS.CallType:=fl_StdCall;
  FS.Arg:=0;
  FS.ArgType:=fl_Differ;
  FS.ArgTypeList:=nil;
  FS.CallFunc:=0;
  FS.ResultType:=0;
  FS.ResultTypeMath:=fl_Extended; {.353}
  FS.CalcConst:=fl_YES;
  FS.DeepFPU:=8;   //fl_UNKNOWN   //max value = 8 !
  FS.SaveReg:=15;  //=15: save eax,ebx,ecx,edx (RECOMMEND.);  =255 save all reg; see .doc if there are any error
  FS.ReplFunc:=fl_Yes;{.193}
  FS.Set_ID:=0;
  FS.Id_Func:=0;
  FS.AdrDeriv:=nil;
  FS.NDeriv:=0;
  FS.Place:=fl_NEW;
  FS.ResultTypeMath := fl_EXTENDED;
  FS.Rsrv1:=0;
  FS.Rsrv2:=0;
  FS.Rsrv3:=0;
end;


function CalcFunctionD(Func: Pointer): double;
  asm
   Call Func
  end;

function CalcFunctionE(Func: Pointer): extended;
  asm
   Call Func
  end;



function  CalcFunctionZD(Func: Pointer):TComplexD;
begin
asm
   call Func
   push eax
   mov  eax, [result]
   fstp qword ptr [eax]
   fstp qword ptr [eax+8]
   pop  eax
end;
end;




function CalcFunctionZE(Func: Pointer): TComplexE;
begin
asm
   call Func
   push eax
   mov  eax, [result]
   fstp tbyte ptr [eax]
   fstp tbyte ptr [eax+16]
   pop  eax
end;
end;



(*
function  CalcFunctionZD(Func: Pointer):TComplexD;
var
p: TComplexD;
begin
  asm
   call Func
   fstp p.re
   fstp p.im
  end;
result:=p;
end;



function CalcFunctionZE(Func: Pointer): TComplexE;
var
p: TComplexE;
begin
  asm
   call Func
   fstp p.re
   fstp p.im
  end;
result:=p;
end;
*)


initialization
begin
(*
  flSet(fl_COMPILER_TYPE_EXE, fl_DELPHI, 0);

{$IFDEF FPC}
  flSet(fl_COMPILER_TYPE_EXE, fl_FREE_PASCAL, 0);
{$ENDIF}

*)

end;


end.






