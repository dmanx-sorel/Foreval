/**
                      Interface Foreval.dll only for  GCC C++ !!!
                                  {9.1.1.395}


**/

#pragma once
#include <windows.h>
#include <oleauto.h>
//#include <wtypes.h>
#include <string>
using namespace std;




typedef  const char* TStringType;  /// example only for ansi,for other string types see Builder's example
//typedef  std::string TStringType;
//typedef  string TStringType;






typedef  __float80 Extended;
//typedef  long double Extended;
typedef  float Single;




typedef  INT32 _int32 ;
typedef  INT32  Int32 ;

typedef void*        Pointer32 ;
typedef double*      PDouble;
typedef Extended*    PExtended;
typedef _int32*      PInteger;
typedef Single*      PSingle;




const   _int32   fl_DISABLE              = 0;
const   _int32   fl_ENABLE               = 1;
const   _int32   fl_REAL                 = 2;  //var type
const   _int32   fl_COMPLEX              = 3;  //var type
const   _int32   fl_REAL_DOUBLE          = 4;  //var type
const   _int32   fl_REAL_EXTENDED        = 5;  //var type
const   _int32   fl_REAL_INTEGER         = 6;  //var type
const   _int32   fl_COMPLEX_DOUBLE       = 7;  //var type
const   _int32   fl_COMPLEX_EXTENDED     = 8;  //var type
const   _int32   fl_ARRAY_REAL_DOUBLE    = 9;  //var type
const   _int32   fl_ARRAY_REAL_EXTENDED  = 10; //var type
const   _int32   fl_DIFFER_DOUBLE        = 11; //var type
const   _int32   fl_DIFFER_EXTENDED      = 12; //var type
const   _int32   fl_VARS_VALUES          = 13; //call func      //const   _int32   fl_VARS_VALUES
const   _int32   fl_VARS_ADDRS           = 14; //call func      //const   _int32   fl_VARS_ADDRS
const   _int32   fl_VARS_LIST_ADDR_EAX   = 15; //call func      //const   _int32   fl_VARS_LIST_ADDR_EAX
const   _int32   fl_VARS_LIST_ADDR_ESP   = 16; //call func      //const   _int32   fl_VARS_LIST_ADDR_ESP
const   _int32   fl_CDECL                = 17; //call type
const   _int32   fl_STDCALL              = 18; //call type
const   _int32   fl_PASCAL               = 19; //call type
const   _int32   fl_DOUBLE               = 20; //stack type
const   _int32   fl_EXTENDED             = 21; //stack type
const   _int32   fl_SHOW_EXCEPTION       = 22;
const   _int32   fl_OPTIMIZATION         = 23;
const   _int32   fl_STACK_TYPE           = 24;
const   _int32   fl_STACK_DEEP           = 25;
const   _int32   fl_RESULT_LEAD_TO_TYPE  = 26;
const   _int32   fl_RESULT_TYPE          = 27;
const   _int32   fl_DIFFER               = 28;
const   _int32   fl_INFINITE             = 29;
const   _int32   fl_FREE                 = 30;
const   _int32   fl_CLEAR                = 31;
const   _int32   fl_VAR_LIST             = 32;
const   _int32   fl_CMPL_FUNC_LIST       = 33;
const   _int32   fl_STRING               = 32;
const   _int32   fl_STRING_UTF16         = 32;
const   _int32   fl_PCHAR                = 33;
const   _int32   fl_ANSISTRING           = 34;
const   _int32   fl_STRING_INTERNAL      = 35;
const   _int32   fl_UNKNOWN              = 36;
const   _int32   fl_STRING_TYPE          = 37;
const   _int32   fl_SYNTAX_EXTENSION     = 38;
const   _int32   fl_PRESENT_COMPLEX_NUMBER = 39;
const   _int32   fl_YES                  = 60;
const   _int32   fl_NO                   = 61;
const   _int32   fl_PRECOMPILED          = 62;
const   _int32   fl_COMPILE_STACK_DEEP   = 63;
const   _int32   fl_COMPILE_OVFL         = 64;
const   _int32   fl_DINAMIC_LOAD_NUM     = 65;
const   _int32   fl_PANSICHAR            = 66;
const   _int32   fl_PESENT_VAR           = 67;
const   _int32   fl_NONE                 = 68;  //result type
const   _int32   fl_WIDESTRING           = 69;
const   _int32   fl_ARRAY_LENGTH         = 70;
const   _int32   fl_VERSION                         = 71;
const   _int32   fl_MAJOR                           = 72;
const   _int32   fl_MINOR                           = 73;
const   _int32   fl_RELEASE                         = 74;
const   _int32   fl_ABOUT                           = 75;
const   _int32   fl_BUILD                           = 76;
const   _int32   fl_AUTHOR                          = 77;
const   _int32   fl_EXTENDED_COMMAND                = 78;
const   _int32   fl_STRING_UTF8                     = 79;
const   _int32   fl_ERROR_CODE                      = 80;
const   _int32   fl_ARRAY_REAL_INTEGER              = 81;
const   _int32   fl_SAVE                            = 82;
const   _int32   fl_RESTORE                         = 83;
const   _int32   fl_COMPILED_BY                     = 84;
const   _int32   fl_ENABLE_FUNCTION                 = 85;
const   _int32   fl_DISABLE_FUNCTION                = 86;
const   _int32   fl_REPLACE_FUNCTIONS               = 87;
const   _int32   fl_REPLACE_FUNCTIONS_NUM           = 88;
const   _int32   fl_REPLACE_DIV                     = 89;
const   _int32   fl_REPLACE_MUL                     = 90;
const   _int32   fl_REPLACE_ADDSUB                  = 91;
const   _int32   fl_REPLACE_OPERATIONS              = 92;
const   _int32   fl_REPLACE_OPERATIONS_NUM          = 93;
const   _int32   fl_REPLACE_MULTI_EXPR              = 94;
const   _int32   fl_USE_VIRTUAL_ALLOC               = 95;   //only for exe code
const   _int32   fl_LENGTH_CODE                     = 96;
const   _int32   fl_SAVE_EAX                        = 97;
const   _int32   fl_SAVE_EBX                        = 98;
const   _int32   fl_SAVE_ECX                        = 99;
const   _int32   fl_SAVE_EDX                        = 100;
const   _int32   fl_SAVE_ESP                        = 101;
const   _int32   fl_SAVE_EBP                        = 102;
const   _int32   fl_SAVE_ESI                        = 103;
const   _int32   fl_SAVE_EDI                        = 104;
const   _int32   fl_ACCURATE_SPEC_FUNC              = 105;
const   _int32   fl_DINAMIC_LOAD                    = 106;
const   _int32   fl_CHECK_INCORRECT_SPACE           = 107;
const   _int32   fl_SET_POWER_SYMBOL                = 108;
const   _int32   fl_REPLACE_AT_IF                   = 109;
const   _int32   fl_LOAD_STACK_AFTER_CALC           = 110;
const   _int32   fl_ADDRESS_OBJECT                  = 111;
const   _int32   fl_FPU_CW                          = 112;
const   _int32   fl_FPU_CW_DEFAULT                  = 113;  // = $1372
const   _int32   fl_FAST_DIV                        = 114;
const   _int32   fl_COMMENT                         = 115;
const   _int32   fl_ENABLE_REPLACE_FUNCTION         = 116;
const   _int32   fl_DISABLE_REPLACE_FUNCTION        = 117;
const   _int32   fl_ENABLE_CALC_CONST               = 118;
const   _int32   fl_DISABLE_CALC_CONST              = 119;
const   _int32   fl_REPLACE_COMPOSITE_FUNCTIONS                 = 120;
const   _int32   fl_REPLACE_COMPOSITE_FUNCTIONS_COMPLEX         = 121;
const   _int32   fl_REPLACE_COMPOSITE_FUNCTIONS_REAL            = 122;
const   _int32   fl_DISABLE_REPLACE_FUNCTION_COMPLEX            = 123;
const   _int32   fl_DISABLE_REPLACE_FUNCTION_REAL               = 124;
const   _int32   fl_ENABLE_REPLACE_FUNCTION_COMPLEX             = 125;
const   _int32   fl_ENABLE_REPLACE_FUNCTION_REAL                = 126;
const   _int32   fl_OPTIMIZATION_MUL_DIV                        = 127;
const   _int32   fl_OPTIMIZATION_A1                             = 128;
const   _int32   fl_OPTIMIZATION_A2                             = 129;
const   _int32   fl_CALC_CONST_EXPRESSION                       = 130;
const   _int32   fl_LEAD_TO_LOWER_CASE                          = 131;
const   _int32   fl_SKIPPED_IF                                  = 132;
const   _int32   fl_CALC_CONST_EXPR_IN_MULTI_EXPR               = 133;
const   _int32   fl_PRECISION                                   = 134;
const   _int32   fl_MASK_FPU_EXCEPTION                          = 135;
const   _int32   fl_CLEAR_FPU_EXCEPTION                         = 136;
const   _int32   fl_IS_FPU_EXCEPTION                            = 137;
const   _int32   fl_FREE_CODE_AT_REPLACE                        = 138;
const   _int32   fl_ADDRESS_EXCEPTION_FLAG                      = 139;
const   _int32   fl_EXCHANGE_BRANCH_NUM                         = 140;
const   _int32   fl_DINAMIC_LOAD_STACK_DEEP                     = 141;
const   _int32   fl_EXCHANGE_BRANCH_STACK_DEEP                  = 142;
const   _int32   fl_EXCHANGE_BRANCH                             = 143;
const   _int32   fl_ANY                                         = -1;
const   _int32   fl_NOT_FOUND                                   = -1;
const   _int32   fl_AUTO                                        = 144;
const   _int32   fl_DELETE                                      = 145;
const   _int32   fl_CALC_CONST_FUNC                             = 146;
const   _int32   fl_CALC_CONST_ARG                              = 147;
const   _int32   fl_NEW                                         = 148;
const   _int32   fl_ReWRITE                                     = 149;
const   _int32   fl_INTEGER_OPTIMIZATION                        = 150;
const   _int32   fl_CALC_CONST_EXT_FUNC                         = 151;
const   _int32   fl_PARAM_LIST                                  = 152;
const   _int32   fl_CALC_CONST_MUL_DIV                          = 153;
const   _int32   fl_INTEGER_OPTIMIZATION_EXT_FUNC               = 154;
const   _int32   fl_DIFF_NUMERIC_PRECISION                      = 155;
const   _int32   fl_STAY_AS_IS                                  = 156;
const   _int32   fl_DATA_IN_ARRAY                               = 157;
const   _int32   fl_INTERNAL_ERROR_CODE                         = 158;
const   _int32   fl_SPEC_FUNC                                   = 159;
const   _int32   fl_FAST                                        = 160;
const   _int32   fl_ACCURATE                                    = 161;
const   _int32   fl_STD_FUNC_REAL                               = 162;
const   _int32   fl_STD_FUNC_COMPLEX                            = 163;
const   _int32   fl_COMPLEX_DIV                                 = 164;
const   _int32   fl_STD_FUNC                                    = 165;
const   _int32   fl_DISABLE_OPERATION                           = 166;
const   _int32   fl_ENABLE_OPERATION                            = 167;
const   _int32   fl_BETWEEN                                     = 168;
const   _int32   fl_BEFORE                                      = 169;
const   _int32   fl_AFTER                                       = 170;
const   _int32   fl_PIPE_BRACKET_TO_ABS                         = 171;
const   _int32   fl_SQUARE_BRACKET_TO_TRUNC                     = 172;
const   _int32   fl_CURLY_BRACKET_TO_FRACK                      = 173;
const   _int32   fl_REPLACE_FUNC_IN_PART                        = 174;
const   _int32   fl_EXT_NAME_FUNC                               = 175;
const   _int32   fl_SUBST_NUMCX                                 = 176;
const   _int32   fl_PRELIM_SYNT_ERROR                           = 177;
const   _int32   fl_SYNTAX_OPERATORS                            = 178;
const   _int32   fl_OPERATOR                                    = 179;
const   _int32   fl_STANDARD                                    = 180;
const   _int32   fl_EXTRA                                       = 181;
const   _int32   fl_PACKAGE_EXPRESSIONS                         = 182;
const   _int32   fl_USE_POINTER                                 = 183;
const   _int32   fl_USE_INTEGER_POINTER                         = 184;
const   _int32   fl_POINTER                                     = 185;
const   _int32   fl_ARRAY_POINTER                               = 186;
const   _int32   fl_REAL_SINGLE                                 = 187;
const   _int32   fl_ARRAY_REAL_SINGLE                           = 188;
const   _int32   fl_INTEGER                                     = 189;
const   _int32   fl_SINGLE                                      = 190;
const   _int32   fl_ALL_REPLACE                                 = 191;
const   _int32   fl_COMPILE                                     = 192;
const   _int32   fl_PACKAGE_COMPILE_ADDR                        = 193;
const   _int32   fl_CHECK_SYNTAX                                = 194;
const   _int32   fl_DIFF_EXPRESSION                             = 195;
const   _int32   fl_COMPILER_TYPE_EXE                           = 196;
const   _int32   fl_DELPHI                                      = 197;
const   _int32   fl_FREE_PASCAL                                 = 198;
const   _int32   fl_REPLACE_ARRAYS                              = 199;
const   _int32   fl_CHECK_ARRAY_TYPE_CONNECT                    = 200;
const   _int32   fl_COMPLEX_SINGLE                              = 201;
const   _int32   fl_REDUCE_CONST_ARG                            = 202;
const   _int32   fl_DELETE_ZERO_BRANCH                          = 203;
const   _int32   fl_INSERT_INLINE                               = 204;
const   _int32   fl_MULTI_EXPR                                  = 206;
const   _int32   fl_INIT_FPU                                    = 207;
const   _int32   fl_ARCCOTAN_TYPE                               = 208;
const   _int32   fl_ARCCOTAN_STD                                = 209;
const   _int32   fl_ARCCOTAN_1DIV_ARG                           = 210;
const   _int32   fl_DELETE_EXTENDED_NAMES_FUNCTION              = 211;
const   _int32   fl_CHECK_USED_NAME                             = 212;
const   _int32   fl_TYPE_OF_DIFFERENTIATION                     = 213;
const   _int32   fl_SYMBOLIC                                    = 214;
const   _int32   fl_NUMERIC                                     = 215;
const   _int32   fl_FREE_MAIN_DIFF_EXPR                         = 216;
const   _int32   fl_INTERNAL                                    = 217;
const   _int32   fl_EXTERNAL                                    = 218;
const   _int32   fl_CONNECT                                     = 219;
const   _int32   fl_LOGIC_OPERATIONS_BY_NAMES                   = 220;
const   _int32   fl_LOGIC_OPERATIONS_BY_SYMBOLS                 = 221;
const   _int32   fl_RESTORE_AND_CLEAR_TMP_VARS                  = 222;
const   _int32   fl_RETURN_VAL_ON_ZERO_LENGTH                   = 223;
const   _int32   fl_ZERO                                        = 224;
const   _int32   fl_NAN                                         = 225;
const   _int32   fl_CREATE                                      = 226;
const   _int32   fl_DESTROY                                     = 227;
const   _int32   fl_REDUCE_CONST_ARG_F                          = 228;
const   _int32   fl_NUMBER_REDUCTIONS                           = 229;




const   _int32   fl_UNKNOWN_SYMBOL                 = 40;
const   _int32   fl_MISSING_ROUND_BRACKET          = 41;
const   _int32   fl_MISSING_OPERATION              = 43;
const   _int32   fl_WRONG_NUMBER_ARGUMENTS         = 44;
const   _int32   fl_MISSING_EXPRESSION             = 45;
const   _int32   fl_UNKNOWN_FUNCTION               = 46;
const   _int32   fl_ERROR_AT_ADDITION_FUNCTION     = 47;
const   _int32   fl_NOT_DEFINED_OPERATOR           = 48;
const   _int32   fl_NOT_DEFINED_FUNCTION           = 49;
const   _int32   fl_INCORRECT_ARGUMENT             = 50;
const   _int32   fl_MISSING_ARGUMENT               = 51;
const   _int32   fl_INTERNAL_ERROR                 = 52;
const   _int32   fl_INCORRECT_TYPE                 = 53;
const   _int32   fl_MISSING_SEPARATOR              = 54;
const   _int32   fl_WRONG_NAME                     = 55;
const   _int32   fl_CALCULATION_ERROR              = 56;
const   _int32   fl_ABSENT_LOAD_FUNCTION_FOR_TYPE  = 57;
const   _int32   fl_MISSING_SQUARE_BRACKET         = 58;
const   _int32   fl_MISSING_CURLY_BRACKET          = 59;
const   _int32   fl_MISSING_ABS_BRACKET            = 60;
const   _int32   fl_WRONG_EXPRESSION               = 61;
const   _int32   fl_INCORRECT_SPACE                = 62;
const   _int32   fl_VARIABLE_REDECLARED            = 63;
const   _int32   fl_NO_DIFF_SYMBOLIC               = 64;
const   _int32   fl_WRONG_PASSED_DATA              = 65;
const   _int32   fl_UNKNOWN_ARRAY                  = 66;
const   _int32   fl_INTERNAL_ERROR_AT_DIFF         = 67;
const   _int32   fl_VOID_EXPRESSION                = 68;
const   _int32   fl_WRONG_SYMBOL                   = 69;
const   _int32   fl_NO_RETURN_NUMBER               = 70;
const   _int32   fl_PROHIBITED_SYMBOL              = 71;
const   _int32   fl_NO_FUNCTION_ARGUMENT           = 72;
const   _int32   fl_NO_APPLICABLE_TO_EXTERNAL_ARRAY = 73;
const   _int32   fl_MULTI_EXPR_DISABLE             = 74;
const   _int32   fl_LABEL_IN_GOTO_NOT_SET          = 75;
const   _int32   fl_NO_APPLICABLE_TO_PASSED_ARRAY  = 76;
const   _int32   fl_NAME_ALREADY_USED              = 77;
const   _int32   fl_WRONG_PLACEMENT_OPERATOR       = 78;
const   _int32   fl_ERROR_AT_ADDITION_OF_OPERATOR  = 79;
const   _int32   fl_UNKNOWN_VARIABLE               = 80;
const   _int32   fl_INVALID_FPU_LOADING            = 81;
//const   _int32   fl_ABSENT_OR_WRONG_SEMICOLON      = 81;





const   _int32   fl_ACCESS_VIOLATION           = 200;
const   _int32   fl_ZERO_DIVIDE                = 201;
const   _int32   fl_INVALID_OPERATION          = 202;
const   _int32   fl_OVERFLOW                   = 203;
const   _int32   fl_OUT_OF_MEMORY              = 204;
const   _int32   fl_STACK_OVERFLOW             = 205;
const   _int32   fl_UNDERFLOW                  = 206;
const   _int32   fl_INT_OVERFLOW               = 207;
const   _int32   fl_COMMON_CALCULATON_ERROR    = 210;



struct TAttrib
		 {
			     _int32  MType;  //fl_Double, fl_Extended, ///fl_Single,fl_Integer,
			  Pointer32  AddrRE; //addr of res
              Pointer32  AddrIM; //addr of res
		 };


struct TidFunc       //IDFP = *TidFunc
		 {
			     _int32  idName; //IDFN  id of name of function
			     _int32  idArg;  //IDFA  id on arguments of function
		 };


struct TOperData
          {
                _int32   IdOp;
                _int32   idFunc;   // = TidFunc.idName
                _int32   OpPrior;
                _int32   NArg;
                _int32   Placement;
          }  ;


struct TAddFuncStruct
				{
				   Pointer32    addr;
					  _int32    CallType;
					  _int32    Arg;
					  _int32    ArgType;
				   Pointer32    ArgTypeList;
					  _int32    CallFunc;
					  _int32    ResultType;
					  _int32    DeepFPU;
					  _int32    CalcConst;
					  _int32    SaveReg;
				      _int32    ReplFunc;
				      _int32    Set_ID;
				      _int32    Id_Func;
                   Pointer32    AdrDeriv;
                      _int32    NDeriv;
                      _int32    Place;
                      _int32    ResultTypeMath;
                      _int32    IsInline;
                      _int32    Rsrv1;
                      _int32    Rsrv2;
                      _int32    Rsrv3;
				 };



typedef void (_stdcall *PTflCompile)(TStringType Expression, Pointer32 Attr, Pointer32& Func);
typedef void (_stdcall *PTflCompileATE)(TStringType Expression, Pointer32 Attr, Pointer32& Func, _int32& ResType, _int32& ErrorCode);
typedef void (_stdcall *PTflSetVar)(TStringType Name, Pointer32 Addr, _int32 TypeVar);
typedef void (_stdcall *PTflSetVarCx)(TStringType Name, Pointer32 AddrRE, Pointer32 AddrIM, _int32 TypeVar);
typedef void (_stdcall *PTflSetParamE)(TStringType Name, Extended Re, Extended Im,  _int32 ParamType);
typedef void (_stdcall *PTflSetParamD)(TStringType Name, double Re, double Im,  _int32 ParamType);
typedef void (_stdcall *PTflSetParamI)(TStringType Name, _int32 IParam);
typedef void (_stdcall *PTflSetParamP)(TStringType Name, Pointer32 AddrRe, _int32 ParamType);
typedef void (_stdcall *PTflSetParamCxP)(TStringType Name, Pointer32 AddrRe, Pointer32 AddrIm, _int32 ParamType);
typedef void (_stdcall *PTflSetFunction)(TStringType FuncName, Pointer32 FuncAddr, Pointer32 IDFP);
typedef void (_stdcall *PTflSet)(_int32 mode, _int32 value1, _int32 value2);
typedef void (_stdcall *PTflGet)(_int32 mode, _int32 subj, _int32& value);
typedef void (_stdcall *PTflGetP)(_int32 mode, _int32 subj, Pointer32& Func);
typedef void (_stdcall *PTflCheckName)(TStringType Name,  _int32& Answ);
typedef void (_stdcall *PTflGetErrorCode)(_int32& CError);
typedef void (_stdcall *PTflGetErrorString)(Pointer32& SError);
typedef void (_stdcall *PTflPerform)(_int32 act, _int32 subj);
typedef void (_stdcall *PTflSetExpression)(TStringType Expr, Pointer32 Attr, _int32  action,  Pointer32& Func,  _int32& CError);


typedef void (_stdcall *PTflResultCxD)(Pointer32 Func, double& Re, double& Im);
typedef void (_stdcall *PTflResultCxE)(Pointer32 Func, Extended& Re, Extended& Im);
typedef void (_stdcall *PTflResultCxDP)(Pointer32 Func, Pointer32 PRezCx);
typedef void (_stdcall *PTflResultCxEP)(Pointer32 Func, Pointer32 PRezCx);
typedef void (_stdcall *PTflResultD)(Pointer32 Func, double& Res);
typedef void (_stdcall *PTflResultE)(Pointer32 Func, Extended& Res);
typedef void (_stdcall *PTflResult)(Pointer32 Func);
typedef Extended (_stdcall *PTflResultR)(Pointer32 Func);



typedef void (_stdcall *PTflPolarDP)(Pointer32 pz, Pointer32 pz1);
typedef void (_stdcall *PTflPolarEP)(Pointer32 pz, Pointer32 pz1);
typedef void (_stdcall *PTflDecartDP)(Pointer32 pz, Pointer32 pz1);
typedef void (_stdcall *PTflDecartEP)(Pointer32 pz, Pointer32 pz1);



typedef void (_stdcall *PTflSetVarIntrnl)(TStringType Name,  _int32 VType, Pointer32& ExAddr);
typedef void (_stdcall *PTflSetVarValueS)(Pointer32 addr, Single Val);
typedef void (_stdcall *PTflSetVarValueD)(Pointer32 addr, double Val);
typedef void (_stdcall *PTflSetVarValueE)(Pointer32 addr, Extended Val);
typedef void (_stdcall *PTflSetVarValueI)(Pointer32 addr, _int32 Val);
typedef void (_stdcall *PTflSetVarValueCxS)(Pointer32 addr, Single ValRe, Single ValIm);
typedef void (_stdcall *PTflSetVarValueCxD)(Pointer32 addr, double ValRe, double ValIm);
typedef void (_stdcall *PTflSetVarValueCxE)(Pointer32 addr, Extended ValRe, Extended ValIm);

typedef void (_stdcall *PTflSetLength)(Pointer32 adrV, _int32 TypeV, _int32 Len);
typedef void (_stdcall *PTflSetArrayValueD)(Pointer32 addr, _int32 indx, double Val);
typedef void (_stdcall *PTflSetArrayValueE)(Pointer32 addr, _int32 indx, Extended Val);
typedef void (_stdcall *PTflSetArrayValueI)(Pointer32 addr, _int32 indx, _int32 Val);
typedef void (_stdcall *PTflSetArrayValueS)(Pointer32 addr, _int32 indx, Single Val);

typedef void (_stdcall *PTflGetVarValueS)(Pointer32 addr,  Single& Val);       //val=single(addr)
typedef void (_stdcall *PTflGetVarValueD)(Pointer32 addr,  double& Val);       //val=double(addr)
typedef void (_stdcall *PTflGetVarValueE)(Pointer32 addr,  Extended& Val);     //val=extended(addr)
typedef void (_stdcall *PTflGetVarValueI)(Pointer32 addr,  _int32& Val);        //val=integer(addr)
typedef void (_stdcall *PTflGetArrayValueI)(Pointer32 addr, _int32 indx, _int32& Val);
typedef void (_stdcall *PTflGetArrayValueD)(Pointer32 addr, _int32 indx, double& Val);
typedef void (_stdcall *PTflGetArrayValueE)(Pointer32 addr, _int32 indx, Extended& Val);
typedef void (_stdcall *PTflGetArrayValueS)(Pointer32 addr, _int32 indx, Single& Val);
typedef void (_stdcall *PTflGetVarValueCxS)(Pointer32 addr,  Single& ValRe, Single& ValIm);        //val=TComplexS(addr)
typedef void (_stdcall *PTflGetVarValueCxD)(Pointer32 addr,  double& ValRe, double& ValIm);        //val=TComplexD(addr)
typedef void (_stdcall *PTflGetVarValueCxE)(Pointer32 addr,  Extended& ValRe, Extended& ValIm);        //val=TComplexE(addr)

typedef void (_stdcall *PTflSetNameImUnit)(TStringType Name);

typedef void (_stdcall *PTflLoadFPUD)(double re, double im);
typedef void (_stdcall *PTflLoadFPUE)(Extended re, Extended im);
typedef void (_stdcall *PTflLoadFPUDP)(Pointer32 addrCx);
typedef void (_stdcall *PTflLoadFPUEP)(Pointer32 addrCx);


typedef void (_stdcall *PTflSetDiffVar)(TStringType Name);
typedef void (_stdcall *PTflSetDiffExpr)(TStringType Name);
typedef void (_stdcall *PTflDiffExpr)(_int32 N);
typedef void (_stdcall *PTflGetDiffString)(Pointer32& DS);
typedef void (_stdcall *PTflCompileDiffExpr)(Pointer32& Addr);
typedef void (_stdcall *PTflCompileDeriv)(TStringType Expression, TStringType VName, _int32 N, Pointer32& Addr);
typedef void (_stdcall *PTflCompileDiffExprATE)(Pointer32 Attr, Pointer32& Func, _int32& ResType, _int32& ErrorCode);
typedef void (_stdcall *PTflCompileDerivATE)(TStringType Expression, TStringType Name, _int32 N, Pointer32 Attr, Pointer32& Func, _int32& ResType, _int32& ErrorCode );




typedef void (_stdcall *PTflSetDiffTemplate)(Pointer32 IDFP,  TStringType TemplateDiff);
typedef void (_stdcall *PTflSetSplainFunction)(TStringType FuncName,   Pointer32 AdrVX,  Pointer32 AdrVY,  _int32 ArrayType, Pointer32 IDFP);
typedef void (_stdcall *PTflSetDiffNumCurrency)(_int32 Np, double h);


typedef _int32 (_stdcall *PTflResultSafe)(Pointer32 Func);
typedef _int32 (_stdcall *PTflResultSafeD)(Pointer32 Func, double& Res);
typedef _int32 (_stdcall *PTflResultSafeE)(Pointer32 Func, Extended& Res);
typedef _int32 (_stdcall *PTflResultSafeCxD)(Pointer32 Func, double& Re, double& Im);
typedef _int32 (_stdcall *PTflResultSafeCxE)(Pointer32 Func, Extended& Re, Extended& Im);
typedef _int32 (_stdcall *PTflResultSafeCxDP)(Pointer32 Func, Pointer32 PRes);
typedef _int32 (_stdcall *PTflResultSafeCxEP)(Pointer32 Func, Pointer32 PRes);

typedef void   (_stdcall *PTflMaskFPUException)(void);
typedef void   (_stdcall *PTflResetMaskFPUException)(void);
typedef _int32 (_stdcall *PTflGetFPUException)(void);

typedef void (_stdcall *PTflSetExtAddrErrorFPU)(Pointer32 ErrFpuAddr);
typedef _int32 (_stdcall *PTflIsNAN)(Extended Res);

typedef void (_stdcall *PTflResultMaskedFPU)(Pointer32 Func);
typedef Extended (_stdcall *PTflResultRMaskedFPU)(Pointer32 Func);
typedef void (_stdcall *PTflResultMaskedFpuE)(Pointer32 Func, Extended& Res);
typedef void (_stdcall *PTflResultMaskedFpuD)(Pointer32 Func, double& Res);
typedef void (_stdcall *PTflResultMaskedFpuCxD)(Pointer32 Func, double& Re, double& Im);
typedef void (_stdcall *PTflResultMaskedFpuCxE)(Pointer32 Func, Extended& Re, Extended& Im);
typedef void (_stdcall *PTflResultMaskedFpuCxDP)(Pointer32 Func, Pointer32 PRezCx);
typedef void (_stdcall *PTflResultMaskedFpuCxEP)(Pointer32 Func, Pointer32 PRezCx);


typedef void (_stdcall *PTflRenameFunction)(TStringType Name, TStringType NewName);
typedef void (_stdcall *PTflAddNameFunction)( _int32 IDF, TStringType FuncName);
typedef void (_stdcall *PTflGetFuncIDN)(TStringType FuncName, _int32& IDN);
typedef void (_stdcall *PTflGetFunctionIDFP)(TStringType FuncName, Pointer32 FData, Pointer32 IDFP);
typedef void (_stdcall *PTflChangeFunctionProperty)(_int32 Action, Pointer32 IDFP);
typedef void (_stdcall *PTflGetFunctionAddr) (Pointer32 idFP, Pointer32& AddrF);



typedef void (_stdcall *PTflSetOperation)(TStringType OpSymb,   Pointer32 OperData);
typedef void (_stdcall *PTflGetOperation)(TStringType OpSymb,   Pointer32 OperData);

//auxiliary:
typedef void (_stdcall *PTflCopyArrayExt)(Pointer32 DstAddr, Pointer32 SrcAddr, _int32 Len);
typedef void (_stdcall *PTflCopyArrayDbl)(Pointer32 DstAddr, Pointer32 SrcAddr, _int32 Len);
typedef void (_stdcall *PTflCopyArrayInt)(Pointer32 DstAddr, Pointer32 SrcAddr, _int32 Len);
typedef void (_stdcall *PTflCopyArrayExtDSC)(Pointer32 DstAddr, Pointer32 SrcAddr, _int32 CellSizeSrc, _int32 CellSizeDst, _int32 Len);
typedef void (_stdcall *PTflCopyMemory)(Pointer32 DstAddr, Pointer32 SrcAddr, _int32  NBytes);
typedef void (_stdcall *PTflCopyVarCxD)(Pointer32 DstAddr, Pointer32 SrcAddr);
typedef void (_stdcall *PTflCopyVarCxE)(Pointer32 DstAddr, Pointer32 SrcAddr);
typedef void (_stdcall *PTflCopyVarD)(Pointer32 DstAddr, Pointer32 SrcAddr);
typedef void (_stdcall *PTflCopyVarE)(Pointer32 DstAddr, Pointer32 SrcAddr);
typedef void (_stdcall *PTflCopyVarI)(Pointer32 DstAddr, Pointer32 SrcAddr);






//
PTflCompile                flCompile;
PTflCompileATE             flCompileATE;
PTflSetVar                 flSetVar;
PTflSetVarCx               flSetVarCx;
PTflSetParamD              flSetParamD;
PTflSetParamE              flSetParamE;
PTflSetParamI              flSetParamI;
PTflSetParamP              flSetParamP;
PTflSetParamCxP            flSetParamCxP;
PTflSetFunction            flSetFunction;
PTflSet                    flSet;
PTflGet                    flGet;
PTflGetP                   flGetP;
PTflCheckName              flCheckName;
PTflGetErrorCode           flGetErrorCode;
PTflGetErrorString         flGetErrorString;
PTflPerform                flPerform;
PTflSetExpression          flSetExpression;


PTflResultCxD              flResultCxD;
PTflResultCxE              flResultCxE;
PTflResultCxDP             flResultCxDP;
PTflResultCxEP             flResultCxEP;
PTflResultD                flResultD;
PTflResultE                flResultE;
PTflResult                 flResult;
PTflResultR                flResultR;



PTflResultSafe             flResultSafe;
PTflResultSafeD            flResultSafeD;
PTflResultSafeE            flResultSafeE;
PTflResultSafeCxD          flResultSafeCxD;
PTflResultSafeCxE          flResultSafeCxE;
PTflResultSafeCxDP         flResultSafeCxDP;
PTflResultSafeCxEP         flResultSafeCxEP;



PTflResultMaskedFPU        flResultMaskedFPU;
PTflResultRMaskedFPU       flResultRMaskedFPU;
PTflResultMaskedFpuD       flResultMaskedFpuD;
PTflResultMaskedFpuE       flResultMaskedFpuE;
PTflResultMaskedFpuCxD     flResultMaskedFpuCxD;
PTflResultMaskedFpuCxE     flResultMaskedFpuCxE;
PTflResultMaskedFpuCxDP    flResultMaskedFpuCxDP;
PTflResultMaskedFpuCxEP    flResultMaskedFpuCxEP;


PTflPolarDP                flPolarDP;
PTflPolarEP                flPolarEP;
PTflDecartDP               flDecartDP;
PTflDecartEP               flDecartEP;


PTflLoadFPUD               flLoadFPUD;
PTflLoadFPUE               flLoadFPUE;
PTflLoadFPUDP              flLoadFPUDP;
PTflLoadFPUEP              flLoadFPUEP;



PTflSetVarIntrnl           flSetVarIntrnl;
PTflSetVarValueS           flSetVarValueS;
PTflSetVarValueD           flSetVarValueD;
PTflSetVarValueE           flSetVarValueE;
PTflSetVarValueI           flSetVarValueI;
PTflSetVarValueCxS         flSetVarValueCxS;
PTflSetVarValueCxD         flSetVarValueCxD;
PTflSetVarValueCxE         flSetVarValueCxE;

PTflSetLength              flSetLength;
PTflSetArrayValueD         flSetArrayValueD;
PTflSetArrayValueE         flSetArrayValueE;
PTflSetArrayValueI         flSetArrayValueI;
PTflSetArrayValueS         flSetArrayValueS;


PTflGetVarValueS           flGetVarValueS;
PTflGetVarValueD           flGetVarValueD;
PTflGetVarValueE           flGetVarValueE;
PTflGetVarValueI           flGetVarValueI;
PTflGetVarValueCxS         flGetVarValueCxS;
PTflGetVarValueCxD         flGetVarValueCxD;
PTflGetVarValueCxE         flGetVarValueCxE;
PTflGetArrayValueD         flGetArrayValueD;
PTflGetArrayValueE         flGetArrayValueE;
PTflGetArrayValueI         flGetArrayValueI;
PTflGetArrayValueS         flGetArrayValueS;

PTflSetNameImUnit          flSetNameImUnit;

PTflSetDiffVar             flSetDiffVar;
PTflSetDiffExpr            flSetDiffExpr;
PTflDiffExpr               flDiffExpr;
PTflGetDiffString          flGetDiffString;
PTflCompileDiffExpr        flCompileDiffExpr;
PTflCompileDeriv           flCompileDeriv;
PTflCompileDiffExprATE     flCompileDiffExprATE;
PTflCompileDerivATE        flCompileDerivATE;



PTflSetDiffTemplate        flSetDiffTemplate;
PTflSetSplainFunction      flSetSplainFunction;
PTflSetDiffNumCurrency     flSetDiffNumCurrency;


PTflMaskFPUException       flMaskFPUException;
PTflResetMaskFPUException  flResetMaskFPUException;
PTflGetFPUException        flGetFPUException;
PTflSetExtAddrErrorFPU     flSetExtAddrErrorFPU;
PTflIsNAN                  flIsNAN;


PTflRenameFunction         flRenameFunction;
PTflAddNameFunction        flAddNameFunction;
PTflGetFuncIDN             flGetFuncIDN;
PTflGetFunctionIDFP        flGetFunctionIDFP;
PTflChangeFunctionProperty flChangeFunctionProperty;
PTflGetFunctionAddr        flGetFunctionAddr;


PTflSetOperation           flSetOperation;
PTflGetOperation           flGetOperation;

PTflCopyArrayExt           flCopyArrayExt;
PTflCopyArrayDbl           flCopyArrayDbl;
PTflCopyArrayInt           flCopyArrayInt;
PTflCopyArrayExtDSC        flCopyArrayExtDSC;
PTflCopyMemory             flCopyMemory;
PTflCopyVarCxD             flCopyVarCxD;
PTflCopyVarCxE             flCopyVarCxE;
PTflCopyVarD               flCopyVarD;
PTflCopyVarE               flCopyVarE;
PTflCopyVarI               flCopyVarI;





_int32       DLLCompiledBy, IDL;
const Int32 Delphi  = 1;
const Int32 Lazarus = 2;




_int32 flInit()
{

   static HINSTANCE hDLL;
   hDLL = LoadLibraryA("Foreval.dll");

   if (hDLL == NULL) {return 0;}
   else
   {
	 flCompile = (PTflCompile)GetProcAddress(hDLL, "flCompile");
	 flCompileATE = (PTflCompileATE)GetProcAddress(hDLL, "flCompileATE");
	 flSet = (PTflSet)GetProcAddress(hDLL, "flSet");
	 flGet  = (PTflGet)GetProcAddress(hDLL, "flGet");
     flGetP  = (PTflGetP)GetProcAddress(hDLL, "flGet");
	 flSetVar = (PTflSetVar)GetProcAddress(hDLL, "flSetVar");
	 flSetVarCx = (PTflSetVarCx)GetProcAddress(hDLL, "flSetVarCx");
	 flSetParamD = (PTflSetParamD)GetProcAddress(hDLL, "flSetParamD");
	 flSetParamE = (PTflSetParamE)GetProcAddress(hDLL, "flSetParamE");
	 flSetParamI = (PTflSetParamI)GetProcAddress(hDLL, "flSetParamI");
	 flSetParamP = (PTflSetParamP)GetProcAddress(hDLL, "flSetParamP");
	 flSetParamCxP = (PTflSetParamCxP)GetProcAddress(hDLL, "flSetParamCxP");
	 flSetFunction = (PTflSetFunction)GetProcAddress(hDLL, "flSetFunction");
     flPerform = (PTflPerform)GetProcAddress(hDLL, "flPerform");
     flSetExpression = (PTflSetExpression)GetProcAddress(hDLL, "flSetExpression");

     flCheckName   = (PTflCheckName)GetProcAddress(hDLL, "flCheckName");
	 flGetErrorString = (PTflGetErrorString)GetProcAddress(hDLL, "flGetErrorString");
	 flGetErrorCode = (PTflGetErrorCode)GetProcAddress(hDLL, "flGetErrorCode");




	 flResultCxE = (PTflResultCxE)GetProcAddress(hDLL, "flResultCxE");
	 flResultCxD = (PTflResultCxD)GetProcAddress(hDLL, "flResultCxD");
	 flResultCxEP = (PTflResultCxEP)GetProcAddress(hDLL, "flResultCxEP");
	 flResultCxDP = (PTflResultCxDP)GetProcAddress(hDLL, "flResultCxDP");
	 flResultD = (PTflResultD)GetProcAddress(hDLL, "flResultD");
	 flResultE = (PTflResultE)GetProcAddress(hDLL, "flResultE");
	 flResult = (PTflResult)GetProcAddress(hDLL, "flResult");
	 flResultR = (PTflResultR)GetProcAddress(hDLL, "flResult");




	 flResultSafeCxD = (PTflResultSafeCxD)GetProcAddress(hDLL, "flResultSafeCxD");
	 flResultSafeCxDP = (PTflResultSafeCxDP)GetProcAddress(hDLL, "flResultSafeCxDP");
     flResultSafeCxE = (PTflResultSafeCxE)GetProcAddress(hDLL, "flResultSafeCxE");
	 flResultSafeCxEP = (PTflResultSafeCxEP)GetProcAddress(hDLL, "flResultSafeCxEP");
	 flResultSafeD = (PTflResultSafeD)GetProcAddress(hDLL, "flResultSafeD");
	 flResultSafeE = (PTflResultSafeE)GetProcAddress(hDLL, "flResultSafeE");
	 flResultSafe = (PTflResultSafe)GetProcAddress(hDLL, "flResultSafe");

	 flResultMaskedFPU = (PTflResultMaskedFPU)GetProcAddress(hDLL, "flResultMaskedFPU");
     flResultRMaskedFPU = (PTflResultRMaskedFPU)GetProcAddress(hDLL, "flResultMaskedFPU");

     flResultMaskedFpuD = (PTflResultMaskedFpuD)GetProcAddress(hDLL, "flResultMaskedFpuD");
     flResultMaskedFpuE = (PTflResultMaskedFpuE)GetProcAddress(hDLL, "flResultMaskedFpuE");

     flResultMaskedFpuCxD = (PTflResultMaskedFpuCxD)GetProcAddress(hDLL, "flResultMaskedFpuCxD");
     flResultMaskedFpuCxE = (PTflResultMaskedFpuCxE)GetProcAddress(hDLL, "flResultMaskedFpuCxE");
     flResultMaskedFpuCxDP = (PTflResultMaskedFpuCxDP)GetProcAddress(hDLL, "flResultMaskedFpuCxDP");
     flResultMaskedFpuCxEP = (PTflResultMaskedFpuCxEP)GetProcAddress(hDLL, "flResultMaskedFpuCxEP");


     flSetVarIntrnl  = (PTflSetVarIntrnl)GetProcAddress(hDLL, "flSetVarIntrnl");
	 flSetVarValueS  = (PTflSetVarValueS)GetProcAddress(hDLL, "flSetVarValueS");
     flSetVarValueD  = (PTflSetVarValueD)GetProcAddress(hDLL, "flSetVarValueD");
	 flSetVarValueE  = (PTflSetVarValueE)GetProcAddress(hDLL, "flSetVarValueE");
	 flSetVarValueI  = (PTflSetVarValueI)GetProcAddress(hDLL, "flSetVarValueI");
	 flSetVarValueCxS  = (PTflSetVarValueCxS)GetProcAddress(hDLL, "flSetVarValueCxS");
	 flSetVarValueCxD  = (PTflSetVarValueCxD)GetProcAddress(hDLL, "flSetVarValueCxD");
	 flSetVarValueCxE  = (PTflSetVarValueCxE)GetProcAddress(hDLL, "flSetVarValueCxE");

     flSetLength  = (PTflSetLength)GetProcAddress(hDLL, "flSetLength");
	 flSetArrayValueD  = (PTflSetArrayValueD)GetProcAddress(hDLL, "flSetArrayValueD");
	 flSetArrayValueE  = (PTflSetArrayValueE)GetProcAddress(hDLL, "flSetArrayValueE");
	 flSetArrayValueI  = (PTflSetArrayValueI)GetProcAddress(hDLL, "flSetArrayValueI");
	 flSetArrayValueS  = (PTflSetArrayValueS)GetProcAddress(hDLL, "flSetArrayValueS");

	 flGetVarValueS  = (PTflGetVarValueS)GetProcAddress(hDLL, "flGetVarValueS");
	 flGetVarValueD  = (PTflGetVarValueD)GetProcAddress(hDLL, "flGetVarValueD");
	 flGetVarValueE  = (PTflGetVarValueE)GetProcAddress(hDLL, "flGetVarValueE");
	 flGetVarValueI  = (PTflGetVarValueI)GetProcAddress(hDLL, "flGetVarValueI");
	 flGetVarValueCxS  = (PTflGetVarValueCxS)GetProcAddress(hDLL, "flGetVarValueCxS");
	 flGetVarValueCxD  = (PTflGetVarValueCxD)GetProcAddress(hDLL, "flGetVarValueCxD");
	 flGetVarValueCxE  = (PTflGetVarValueCxE)GetProcAddress(hDLL, "flGetVarValueCxE");
	 flGetArrayValueD  = (PTflGetArrayValueD)GetProcAddress(hDLL, "flGetArrayValueD");
	 flGetArrayValueE  = (PTflGetArrayValueE)GetProcAddress(hDLL, "flGetArrayValueE");
	 flGetArrayValueI  = (PTflGetArrayValueI)GetProcAddress(hDLL, "flGetArrayValueI");
	 flGetArrayValueS  = (PTflGetArrayValueS)GetProcAddress(hDLL, "flGetArrayValueS");

     flSetDiffVar = (PTflSetDiffVar)GetProcAddress(hDLL, "flSetDiffVar");
     flSetDiffExpr = (PTflSetDiffExpr)GetProcAddress(hDLL, "flSetDiffExpr");
     flDiffExpr = (PTflDiffExpr)GetProcAddress(hDLL, "flDiffExpr");
     flGetDiffString = (PTflGetDiffString)GetProcAddress(hDLL, "flGetDiffString");
     flCompileDiffExpr = (PTflCompileDiffExpr)GetProcAddress(hDLL, "flCompileDiffExpr");
     flCompileDeriv = (PTflCompileDeriv)GetProcAddress(hDLL, "flCompileDeriv");
     flCompileDiffExprATE = (PTflCompileDiffExprATE)GetProcAddress(hDLL, "flCompileDiffExprATE");
     flCompileDerivATE = (PTflCompileDerivATE)GetProcAddress(hDLL, "flCompileDerivATE");





     flSetDiffTemplate = (PTflSetDiffTemplate)GetProcAddress(hDLL, "flSetDiffTemplate");
     flSetSplainFunction = (PTflSetSplainFunction)GetProcAddress(hDLL, "flSetSplainFunction");
     flSetDiffNumCurrency = (PTflSetDiffNumCurrency)GetProcAddress(hDLL, "flSetDiffNumCurrency");


	 flLoadFPUD = (PTflLoadFPUD)GetProcAddress(hDLL, "flLoadFPUD");
	 flLoadFPUE = (PTflLoadFPUE)GetProcAddress(hDLL, "flLoadFPUE");
	 flLoadFPUDP = (PTflLoadFPUDP)GetProcAddress(hDLL, "flLoadFPUDP");
	 flLoadFPUEP = (PTflLoadFPUEP)GetProcAddress(hDLL, "flLoadFPUEP");

	 flPolarDP = (PTflPolarDP)GetProcAddress(hDLL, "flPolarDP");
	 flPolarEP = (PTflPolarEP)GetProcAddress(hDLL, "flPolarEP");
	 flDecartDP = (PTflDecartDP)GetProcAddress(hDLL, "flDecartDP");
	 flDecartEP = (PTflDecartEP)GetProcAddress(hDLL, "flDecartEP");

     flSetNameImUnit  = (PTflSetNameImUnit)GetProcAddress(hDLL, "flSetNameImUnit");

     flMaskFPUException = (PTflMaskFPUException)GetProcAddress(hDLL, "flMaskFPUException");
     flResetMaskFPUException = (PTflResetMaskFPUException)GetProcAddress(hDLL, "flResetMaskFPUException");
     flGetFPUException  = (PTflGetFPUException)GetProcAddress(hDLL, "flGetFPUException");
     flSetExtAddrErrorFPU = (PTflSetExtAddrErrorFPU)GetProcAddress(hDLL, "flSetExtAddrErrorFPU");
     flIsNAN             =  (PTflIsNAN)GetProcAddress(hDLL, "flIsNAN");

	 flAddNameFunction  = (PTflAddNameFunction)GetProcAddress(hDLL, "flAddNameFunction");
	 flGetFuncIDN  = (PTflGetFuncIDN)GetProcAddress(hDLL, "flGetFuncIDN");
	 flGetFunctionIDFP  = (PTflGetFunctionIDFP)GetProcAddress(hDLL, "flGetFunctionIDFP");
     flRenameFunction  = (PTflRenameFunction)GetProcAddress(hDLL, "flRenameFunction");
     flChangeFunctionProperty = (PTflChangeFunctionProperty)GetProcAddress(hDLL, "flChangeFunctionProperty");
     flGetFunctionAddr = (PTflGetFunctionAddr)GetProcAddress(hDLL, "flGetFunctionAddr");


     flSetOperation = (PTflSetOperation)GetProcAddress(hDLL, "flSetOperation");
     flGetOperation = (PTflGetOperation)GetProcAddress(hDLL, "flGetOperation");
     flCopyArrayExt = (PTflCopyArrayExt)GetProcAddress(hDLL, "flCopyArrayExt");
     flCopyArrayDbl = (PTflCopyArrayDbl)GetProcAddress(hDLL, "flCopyArrayDbl");
     flCopyArrayInt = (PTflCopyArrayInt)GetProcAddress(hDLL, "flCopyArrayInt");
     flCopyArrayExtDSC = (PTflCopyArrayExtDSC)GetProcAddress(hDLL, "flCopyArrayExtDSC");
     flCopyMemory = (PTflCopyMemory)GetProcAddress(hDLL, "flCopyMemory");
     flCopyVarCxD = (PTflCopyVarCxD)GetProcAddress(hDLL, "flCopyVarCxD");
     flCopyVarCxE = (PTflCopyVarCxE)GetProcAddress(hDLL, "flCopyVarCxE");
     flCopyVarD   = (PTflCopyVarE)GetProcAddress(hDLL, "flCopyVarD");
     flCopyVarE   = (PTflCopyVarD)GetProcAddress(hDLL, "flCopyVarE");
     flCopyVarI   = (PTflCopyVarI)GetProcAddress(hDLL, "flCopyVarI");


     flGet(fl_COMPILED_BY,0,IDL);
     if (IDL >= 100 ) {DLLCompiledBy = Lazarus;} else {DLLCompiledBy = Delphi;};

	return 1;
   }
}


void  InitFuncStruct(TAddFuncStruct& FS)
{
  FS.addr=0;
  FS.CallType=fl_STDCALL;
  FS.Arg=0;
  FS.ArgType=fl_DIFFER;
  FS.ArgTypeList=0;
  FS.CallFunc=0;
  FS.ResultType=0;
  FS.CalcConst=fl_YES;
  FS.DeepFPU=8;   //max value = 8 ! Use, if unknown deep FPU stack of added function. To prevents error overload stack FPU.
  FS.SaveReg=15;  //=15 save eax,ebx,ecx,edx (RECOMMEND.);  =255 save all reg; see .doc if there are any error
  FS.ReplFunc=fl_YES;
  FS.Set_ID=0;
  FS.Id_Func=0;
  FS.AdrDeriv=0;
  FS.NDeriv=0;
  FS.Place=fl_NEW; //fl_ReWRITE;
  FS.ResultTypeMath = fl_EXTENDED;
  FS.IsInline = fl_NO;
  FS.Rsrv1=0;
  FS.Rsrv2=0;
  FS.Rsrv3=0;
}


