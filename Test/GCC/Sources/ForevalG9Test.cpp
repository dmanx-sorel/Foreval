//---------------------------------------------------------------------------
                                               /** 9.1.1.395 **/




/**
                               Warning:

      >  Use  32bit compiler.

      >  Foreval does not support multitasking: compiled expression can not be executed simultaneously in multiple threads;
           For each thread needs its own compilation of expression, it also applies to functions such fl_Precompiled (not  thread-safe).

      >  If many expressions are compiled, but are calculated once, to speed up, disable all optimizations: flSet (fl_Disable, fl_Optimization, 0);
             and turn off  mode fl_USE_VIRTUAL_ALLOC:  flSet(fl_DISABLE,fl_USE_VIRTUAL_ALLOC,0) (if possible, see below for MSVC)

      >  For MSVC and other likes.
          All data passed in  and returned from Foreval (addresses of variables and functions)  must placing in 'unmanaged memory' so as using at compilation, except strings.
          I.e., they must be located at fixed, non-movable addresses in memory.
           Also use mode:
             flSet(fl_ENABLE,fl_USE_VIRTUAL_ALLOC,0);  - necessarily (if without this installation compilation and calculation does not work).
             flSet(fl_ENABLE,fl_MASK_FPU_EXCEPTION,0); - to use , if at connecting Foreval.dll, don't catched FPU exception in internal try except block (of dll).


      >  For  environments   with only 'managed memory'  use internal definition of variables:  flSetVarIntrnl , and added external functions  with type flPrecompiled.





**/



#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <tchar.h>
#include <iostream>
#include <sstream>
#include <cstdlib>
#include <string>
#include <vector>
#include <math.h>
#include <ctime>
//#include <complex.h>


#include "Types.h"
#include "Forevaldll.h"
//#include "stComplexNum.h"
#include "ExtFunc.h"


using namespace std;

// #define OVERLOADCOMPLEX

//const Int32 Delphi  = 1;
//const Int32 Lazarus = 2;

typedef   TComplexNum (*PTGccTestZ)(void);
typedef   TComplexSTD (*PTGccTestZ_std)(void);
//typedef   TFloatType  (*PTGccTestR)(void);





 struct TFunc2
		   {
				//TStringType    Expr;
				Pointer32      Addr;
				TFloatType  res;
				TFloatType  x;
				TFloatType  y;

		  };

 struct TFunc3
		   {
				//TStringType    Expr;
				Pointer32      Addr;
				TFloatType  res;
				TFloatType  x;
				TFloatType  y;
				TFloatType  z;

		  };

struct TFuncInt3
	  {
	  Pointer32 FAddr;
	  TFloatType  x    ;
	  TFloatType  y     ;
	  TFloatType  z     ;
	  TFloatType  a     ;
	  TFloatType  b     ;
	  Pointer32 F1Addr;
	  Pointer32 F2Addr ;
	  Pointer32 F3Addr ;
	  Pointer32 F4Addr ;
	  };

struct TFuncInt3Ext
	  {
	  Pointer32 FAddr;
	  Pointer32 adrX;
	  Pointer32 adrY;
	  Pointer32 adrZ;
	  TFloatType  a     ;
	  TFloatType  b     ;
	  Pointer32 F1Addr;
	  Pointer32 F2Addr;
	  Pointer32 F3Addr;
	  Pointer32 F4Addr;
	  };

struct TFunc3ExtCX
	  {
	  Pointer32 FAddr;
	  Pointer32 addrX;
	  Pointer32 addrY;
	  Pointer32 addrN;
	  Pointer32 addrK;
	  Pointer32 addrZ1;
	  Pointer32 addrZ2;
	  Pointer32 addrZ3;
	  Pointer32 addrRezCX;
	  TStringType Expr;
	  };


struct TFunc4RZ
       {
		 TComplex    z1;
		 TComplex    z2;
		 TComplex    z3;
		 TFloatType  x;
		 TFloatType  y;
		 TFloatType  z;
		 TFloatType  t;
		 _int32      n;
		 TComplex    res;
		 Pointer32   Addr;
		 TStringType Expr;
		 //PCHAR       PchExpr;
       };








const TFloatType    A = 2.54321l;
const TFloatType    B = -3.98765l;
const TFloatType    C = 4.12345l;
const TFloatType    D = -5.67893l;
const TFloatType    E = -3.25715l;
const TFloatType    F = 7.35791l;
const TFloatType    G = 11.97531l;

const TComplexNum i {0.0l,1.0l};
const TComplexSTD I (0.0l,1.0l);

const TComplexNum Ai {A,C};
const TComplexNum Bi {B,A};
const TComplexNum Ci {C,B};
const TComplexNum Di {D,C-A};


const TComplexSTD Ais (A,C);
const TComplexSTD Bis (B,A);
const TComplexSTD Cis (C,B);
const TComplexSTD Dis (D,C-A);



Int32        RType, CxType, VType, MType;

TAttrib     Attr;
//TComplexNum z1,z2,z3,i;
//TComplexD z1d,z2d,z3d,resf;

TComplex    z1f,z2f,z3f,z4f,z5f;
TComplexNum z1, z2, z3, z4, z5,i0;//i
TComplexSTD z1s,z2s,z3s,z4s,z5s;
///resf - global var. for returned result all func&proc
  TComplexF resf;
/**
#ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
   TComplexNum resf;
#else                           // <- complex variables are set the same as internal Foreval
   TComplex resf;
#endif
**/


TFloatType x,y,t,s,p,r,z,u,v,q;
_int32 n,k,j,m,l,lenv,ii, sizecell, FPUError;

Pointer32  PtrF1,PtrF2,PtrF3,PtrF4,PtrF5,Ptr1,Ptr2,Ptr3,Ptr4,Ptr5,PtrV,PtrV0;
PFloatType pvX,pvY,pvT;
Pointer32  pvZ1,pvZ2,pvZ3; // -> &TComplex or &TComplexNum

//long double _Complex zc1,zc2,zc3,zc4;


TComplex  testx1,testx2;

TFunc4RZ fnc1,fnc2,fnc3,fnc1A,fnc2A,fnc3A;

Pointer32 adrVD, adrVE,adrVU,adrVU1,adrVU2,adrVU3,adrVE1,adrVE2,adrVE3,adrVECE,adrVECE2,adrVEF,adrVDF,adrVIF,adrVI,adrAD,adr1,adrVECD,adrVECI,adrXSPL,adrYSPL, adrCP, adrCP12, FDynArray, adrVPS, adrAN, adrBN;
Pointer32 adrSVX ,adrSVY, adrVS, adrVD1, adrVI1, adrVS1;
Pointer32 adrVPR;

Pointer32 adrVpF3,adrVp1,adrVp2,adrVp3;
Pointer32 adrAint,adrBint;

Pointer32 Ptr0Vu1,Ptr0Vu2,Ptr0Vu3,Ptr0M1u,Ptr0M1ux,Ptr0M1uy;
_int32    LenVU;


string    ExprE1R,ExprE2R,ExprE2RCM,ExprE2RC,ExprE3SR,ExprE4SR,ExprA5R,ExprA6R,ExprA6FR,ExprA6VU,ExprA6VDU,ExprA6VDUP,ExprA6PVU,ExprA6PR,ExprP7R,ExprP7AR,ExprP7BR,ExprF8R,ExprF9R,ExprF10SR,ExprF11SR,ExprF12SR,ExprF12CR,ExprFE13SPR,ExprFE13PSR,ExprFE13MSR,ExprFE13PCR,ExprFE14SPR,ExprFE14PSR,ExprFE14MSR,ExprFE14PCR;
Pointer32 FuncE1R,FuncE2R,FuncE2RCM,FuncE2RC,FuncE3SR,FuncE4SR,FuncA5R,FuncA6R,FuncA6FR,FuncA6VU,FuncA6VDU,FuncA6VDUP,FuncA6PVU,FuncA6PR,FuncP7R,FuncP7AR,FuncP7BR,FuncF8R,FuncF9R,FuncF10SR,FuncF11SR,FuncF12SR,FuncF12CR,FuncFE13SPR,FuncFE13PSR,FuncFE13MSR,FuncFE13PCR,FuncFE14SPR,FuncFE14PSR,FuncFE14MSR,FuncFE14PCR;

string    ExprE1AR, ExprE3ASR, ExprE4ASR, ExprE4SRC, ExprIntegralF1, ExprE4SCZ, ExprE2PR, ExprES1AR, ExprES2AR;
Pointer32 FuncE1AR, FuncE3ASR, FuncE4ASR, FuncE4SRC, FuncIntegralF1, FuncE4SCZ, FuncE2PR, FuncES1AR, FuncES2AR;

string    ExprE2R_Diffdxdy_Long,ExprE2PR_Diffdxdy_Long;
Pointer32 FuncE2R_Diffdxdy_Long,FuncE2PR_Diffdxdy_Long;

string    ExprFE15SPR,ExprFE15PSR,ExprFE15MSR,ExprFE15PCR,ExprFE15SPRC,ExprFE15PSRC,ExprFE15MSRC,ExprFE15PCRC,ExprFE15ASPR,ExprFE15APSR,ExprFE15AMSR,ExprFE15APCR;
Pointer32 FuncFE15SPR,FuncFE15PSR,FuncFE15MSR,FuncFE15PCR,FuncFE15SPRC,FuncFE15PSRC,FuncFE15MSRC,FuncFE15PCRC,FuncFE15ASPR,FuncFE15APSR,FuncFE15AMSR,FuncFE15APCR;

string    ExprE1Z,ExprE1AZ,ExprE1BZ,ExprE1CZ, ExprE2CZ, ExprE2Z,ExprE2AZ,ExprE2BZ,ExprE3CM,ExprE3C,ExprE3Z,ExprE3SZ,ExprE3ASZ,ExprE3BSZ,ExprE4SZ,ExprA5Z,ExprA6Z,ExprA6FZ,ExprP7Z,ExprP7AZ;
Pointer32 FuncE1Z,FuncE1AZ,FuncE1BZ,FuncE1CZ, FuncE2CZ, FuncE2Z,FuncE2AZ,FuncE2BZ,FuncE3CM,FuncE3C,FuncE3Z,FuncE3SZ,FuncE3ASZ,FuncE3BSZ,FuncE4SZ,FuncA5Z,FuncA6Z,FuncA6FZ,FuncP7Z,FuncP7AZ;

string    ExprES1Z, ExprES2Z;
Pointer32 FuncES1Z, FuncES2Z;

string    ExprF8Z,ExprF9Z,ExprF10SZ,ExprF11SZ,ExprF12SZ,ExprFE13SPZ,ExprFE13PSZ,ExprFE13MSZ,ExprFE13PCZ,ExprFE13APSZ,ExprFE13ASPZ,ExprFE13AMSZ,ExprFE13APCZ;
Pointer32 FuncF8Z,FuncF9Z,FuncF10SZ,FuncF11SZ,FuncF12SZ,FuncFE13SPZ,FuncFE13PSZ,FuncFE13MSZ,FuncFE13PCZ,FuncFE13APSZ,FuncFE13ASPZ,FuncFE13APCZ,FuncFE13AMSZ;

string    ExprP1Z , ExprP1ZP , ExprP1ZV, ExprP1CZ , ExprP1CZP;
Pointer32 FuncP1Z , FuncP1ZP , FuncP1ZV, FuncP1CZ , FuncP1CZP;

string    ExprFE13BPSZ,ExprFE13BSPZ,ExprFE13BPCZ;
Pointer32 FuncFE13BPSZ,FuncFE13BSPZ,FuncFE13BPCZ;

string    ExprFE14SPZ,ExprFE14PSZ,ExprFE14MSZ,ExprFE14PCZ,ExprFE15SPZ,ExprFE15PSZ,ExprFE15PCZ,ExprFE15MSZ,ExprFE15SPZC,ExprFE15PSZC,ExprFE15MSZC,ExprFE15PCZC;
Pointer32 FuncFE14SPZ,FuncFE14PSZ,FuncFE14MSZ,FuncFE14PCZ,FuncFE15SPZ,FuncFE15PSZ,FuncFE15PCZ,FuncFE15MSZ,FuncFE15SPZC,FuncFE15PSZC,FuncFE15MSZC,FuncFE15PCZC;

string    ExprF1Z ,ExprF2Z ,ExprF3Z ,ExprF4Z ,ExprF5Z, ExprF6Z, ExprF7Z, ExprF8CZ;
Pointer32 FuncF1Z, FuncF2Z, FuncF3Z, FuncF4Z, FuncF5Z, FuncF6Z, FuncF7Z, FuncF8CZ;

string    G_Expr;

PDouble  px,py;
PInteger pi1;
Int32    ct,LenVR;
//Int32 DLLCompiledBy;
//TFunc3  func1,func2,fnc3;

TFuncInt3     FInt3;
TFuncInt3Ext  FInt3Ext;

TFunc3ExtCX   Func1ExtCX,Func2ExtCX;
Pointer32     AddrX,AddrY,AddrN,AddrZ1,AddrZ2,AddrZ3;




//double    D,E;
Extended  Ae,Be,Ce,De,Ee,Fe,Ge;
TComplexE Acx,Bcx,Ccx,Dcx,Ecx,Fcx,Gcx;

TFloatType X1c,Y1c,Z1c,X2c,Y2c,Z2c, Al, Bt, Gm;


//Pointer32 adrXVD,adrXVE,adrXVI,adrXAD,adr1,adrVECD,adrVD,FDynArray,adrXSPL,adrYSPL, adrVDX, adrVDY, adrVF;


 INT32 FpuExc,GNC,Perf,rt,PerfG;
 BOOLEAN F_CalcError;

 TArrayS     vs,vs1,vst;
 TArrayD     xspl,yspl;
 TArrayD     vd,vd1,vecd,vdf,vdt;
 TArrayE     ve,ve1,ve2,ve3,vece,vet;
 TArrayI     vi,vi1,veci,vif,vit;
 TArrayF     CP12,vps,vu,vu1,vu2,vu3,vpr,vu1t,vu2t,vu3t;
 TArrayE_10  ve10,vece10,ve10f;

 TArrayF     M1u,M1ux,M1uy;
 Pointer32   adrM1u,adrM1ux,adrM1uy;
 INT32       LenSCM1u,SizeRandElem;

 BOOLEAN     G_CompileDiffExpr;

//---------------------------------------------------------------------------------------------------------------------------


 TFloatType _trunc(TFloatType d);
 TFloatType _abs(TFloatType d);
 void PtrToStr(Pointer32 PtrStr,  std::string &StrOut);
 std::string IntToStr(INT32 Inum);
 INT32 StrToInt(std::string Str);
 std::string FloatToStr(TFloatType F);
 void ShowResult(TFloatType Re);
 void ShowResult(TFloatType Re1, TFloatType Re2);
 void ShowResult(TComplex Cx);
 void ShowResult(TComplexNum Cx);
 void ShowResult( std::string SCom, TFloatType Re);
 void ShowResult( std::string SRes, Int32 rt, TComplex ResCx);
 void ShowResult( std::string SRes, Int32 rt, TComplexNum ResCx);
 void ShowResult(Pointer32 Addr, std::string SFunc, _int32 id);
 void ShowResult(Pointer32 Addr, std::string SFunc);
 void ShowResult( std::string SCom, TFloatType Re,  TFloatType Im);

 void RefReshVar();
 void RefReshArrays();
 void CopyArrayExtGF(Pointer32 psrc, Pointer32 pdest,  _int32 SZ);
 void CopyArrayExtFG(Pointer32 psrc, Pointer32 pdest,  _int32 SZ);

 void LoadDataLib(void);

 void TestEvalCmpVR(PTGccTestR GccFunc, Pointer32 FFunc);
 TFloatType GccA6R();

 TFloatType   GccInt1Func(TFloatType x1);
 TFloatType   Integral1(TFloatType a, TFloatType b);

 void RandSizeMatrixAndFillRandElem();
 TFloatType DetMulMxM1();
 void RandSizeMatrixAndFillRandElemS4();
 void SetMatrixDetMulExpr();
 void CompileMatrixDetMulExpr(Pointer32 &AddrCmpl);
 void SetExprE2R_Diffdxdy_Long();
 void SetExprE2PR_Diffdxdy_Long();

 void CalcExprS1U_T4(Pointer32 Func, TComplex   &resCx);
 void CalcExprF1_T1 (Pointer32 Func, TComplex   &resCx);
 void CalcExprF1U_T2(Pointer32 Func, TComplex   &resCx);




 //-----------------------------------------
 Extended GccIntMain();
 Extended GccIntFY1();
 Extended GccIntFY1();
 Extended GccIntFY2();
 Extended GccIntFZ1();
 Extended GccIntFZ2();


  TComplexNum   Gccfnc1(TComplexNum z1, TComplexNum z2, _int32 n, TFloatType x);
  TComplexNum   Gccfnc2(TComplexNum z1, TComplexNum z2, _int32 n, TFloatType x);

  TComplexNum func1Gcc(TComplexNum z1, TComplexNum z2, TComplexNum z3, TFloatType x, TFloatType y,  _int32 k, _int32 n);
  TComplexNum func2Gcc(TComplexNum z1, TComplexNum z2, TComplexNum z3, TFloatType x, TFloatType y,  _int32 k, _int32 n);
/*****************************************************************************************************************************/





void  ShowError(void)
{
Int32 CError, EIntrnl;
Pointer32 PS;
string strE,strOut,strTmp,S,SE;
TStringType chE,chTmp;


flGetErrorCode(CError);

switch ( CError )
 {
   case  fl_UNKNOWN_SYMBOL:                       S ="UNKNOWN SYMBOL or INCORRECT ARGUMENT or WRONG EXPRESSION"; break;
   case  fl_MISSING_ROUND_BRACKET:                S ="MISSING ROUND BRACKET"; break;
   case  fl_MISSING_OPERATION:                    S="MISSING OPERATION";   break;
   case  fl_WRONG_NUMBER_ARGUMENTS:               S="WRONG NUMBER ARGUMENTS";  break;
   case  fl_MISSING_EXPRESSION:                   S="MISSING EXPRESSION";  break;
   case  fl_UNKNOWN_FUNCTION:                     S="UNKNOWN FUNCTION"; break;
   case  fl_UNKNOWN_ARRAY:                        S="UNKNOWN ARRAY"; break;
   case  fl_ERROR_AT_ADDITION_FUNCTION:           S="ERROR AT ADDITION FUNCTION";   break;
   case  fl_NOT_DEFINED_OPERATOR:                 S="NOT DEFINED OPERATOR"; break;
   case  fl_NOT_DEFINED_FUNCTION:                 S="NOT DEFINED FUNCTION";  break;
   case  fl_INCORRECT_ARGUMENT:                   S="WRONG TYPE OF ARGUMENT";   break;
   case  fl_MISSING_ARGUMENT:                     S="MISSING ARGUMENT";  break;
   case  fl_INTERNAL_ERROR:                       S="INTERNAL ERROR or  UNCATCHABLE SYNTAX ERROR"; break;
   case  fl_CALCULATION_ERROR:                    S="INTERNAL ERROR AT CALCULATION";  break;
   case  fl_INCORRECT_TYPE:                       S="WRONG TYPE" ;   break;
   case  fl_WRONG_NAME:                           S="WRONG NAME";  break;
   case  fl_MISSING_SQUARE_BRACKET:               S="MISSING SQUARE BRACKET";  break;
   case  fl_MISSING_CURLY_BRACKET:                S="MISSING CURLY BRACKET";  break;
   case  fl_MISSING_ABS_BRACKET:                  S="MISSING ABS BRACKET";  break;
   case  fl_WRONG_EXPRESSION:                     S="WRONG EXPRESSION";  break;
   case  fl_ABSENT_LOAD_FUNCTION_FOR_TYPE:        S="ABSENT LOAD FUNCTION FOR TYPE"; break;
   case  fl_MISSING_SEPARATOR:                    S="MISSING SEPARATOR OR OPERATION";   break;
   case  fl_INCORRECT_SPACE:                      S="INCORRECT SPACE";  break;
   case  fl_VARIABLE_REDECLARED:                  S="VARIABLE REDECLARED";  break;
   case  fl_WRONG_PASSED_DATA:                    S="WRONG PASSED DATA";break;
   case  fl_NO_DIFF_SYMBOLIC:                     S="NOT DIFFERENTIATED SYMBOLICALLY";break;
   case  fl_INTERNAL_ERROR_AT_DIFF:               S="INTERNAL ERROR AT DIFF or UNCATCHABLE SYNTAX ERROR";break;
   case  fl_WRONG_SYMBOL:                         S="WRONG SYMBOL" ; break;
   case  fl_VOID_EXPRESSION:                      S="VOID EXPRESSION"; break;
   case  fl_NO_RETURN_NUMBER:                     S="NO RETURN NUMBER"; break;
   case  fl_PROHIBITED_SYMBOL:                    S="PROHIBITED SYMBOL";break;
   case  fl_NO_FUNCTION_ARGUMENT:                 S="NO FUNCTION ARGUMENT";break;
   case  fl_NO_APPLICABLE_TO_EXTERNAL_ARRAY:      S="NO APPLICABLE TO EXTERNAL ARRAY"; break;
   case  fl_MULTI_EXPR_DISABLE:                   S="MULTI EXPRESSIONS ARE DISABLE"; break;
   case  fl_LABEL_IN_GOTO_NOT_SET:                S="LABEL IN GOTO NOT SET"; break;
   case  fl_NO_APPLICABLE_TO_PASSED_ARRAY:        S="NO APPLICABLE TO PASSED ARRAY"; break;
   case  fl_NAME_ALREADY_USED:                    S="NAME ALREADY USED"; break;
   case  fl_WRONG_PLACEMENT_OPERATOR:             S="WRONG PLACEMENT OPERATOR";break;
   case  fl_ERROR_AT_ADDITION_OF_OPERATOR:        S="ERROR AT ADDITION OF OPERATOR";break;
   case  fl_UNKNOWN_VARIABLE:                     S="UNKNOWN VARIABLE"; break;
   case  fl_INVALID_FPU_LOADING:                  S="EXPRESSION MUST BE SAVE RESULT"; break;
   //case  fl_ABSENT_OR_WRONG_SEMICOLON:            S="ABSENT OR WRONG SEMICOLON"; break;

   default:                                       S="UNKNOWN SYNTAX ERROR"; break;
}


  flGet(fl_INTERNAL_ERROR_CODE,0,EIntrnl);  //addition info about error
  if (EIntrnl != 0)
  {
       switch ( EIntrnl)
      {
        case   fl_ZERO_DIVIDE:          SE = "ZERO DIVIDE";break;
        case   fl_INVALID_OPERATION:    SE = "INVALID OPERATION";break;
        case   fl_OVERFLOW:             SE = "OVERFLOW";break;
        case   fl_UNDERFLOW:            SE = "UNDERFLOW";break;
        case   fl_ACCESS_VIOLATION:     SE = "ACCESS VIOLATION";break;
        case   fl_OUT_OF_MEMORY:        SE = "OUT OF MEMORY";break;
        case   fl_STACK_OVERFLOW:       SE = "STACK OVERFLOW";break;
      }
  };




   /** it's best to make coping throw auxiliary string **/
       flGetErrorString(PS);
	   chTmp=(TStringType)(PS);
	   strTmp=(string)(chTmp);
	   strOut=strTmp;
	   strTmp="";
	   cout << "Foreval Syntax Error:" << S+":   "+SE << endl;
       cout << strOut << endl;


}

void PtrToStr(Pointer32 PtrStr, std::string &StrOut)
{
   TStringType chTmp;
   string      StrTmp;



   chTmp=(TStringType)(PtrStr);
   StrTmp=(string)(chTmp);
   StrOut=StrTmp; StrTmp="";
}




int onLoad()
{
      _int32       flLoad,ic,ECode, NC, len,rt;
	  TStringType  Expr,Expr1,Expr2,Expr3,Expr4,Expr5, FExpr,FExpr1,FExpr2,DFNumExpr;
	  std::string  DFFunc,DFNumFunc;
	  //TStringType   Sid,Sid1,Sid2,Sid3,Sid4,Expr1,Expr2,SRes;

	  Pointer32    Func1,ve0,FZ1,FS1,FS2,FS3,FS4,FS5,FDS1,FDS2,FDS3,vd0,pa1,pe1,pe2,psrc,pdest,FS6,FS7 ; //*TidFunc idFP
	  Pointer32    DynArray1,DynArray2,MxMulDet,MxMulDetP;
	  Pointer32    pf1,pf2,pf3,pf4,pf5,pf6;

	  TidFunc      idFP, idFP1, idFP2, idFP3;
      _int32       IDN, Ans, Err;


	  TFloatType       ax,bx,hx,sx,fx,dx,dy,res,sumv;


	  //TArrayI      VT;
      TArrayB      Code;
	  _int32       ni, NR,li,ki,lv;
	  _int32       ID,ID1,ID2,ID3,ID4,SZ,IDF;
	  PInteger     pint1,P_C;
	  PDouble      pdbl1;
	  string       Sid,Sid1,Sid2,Sid3,Sid4,SText,SRes;
      char*        Ch32;

	  TComplexD    rezCx;
	  TComplexE    rezeCX;
      TComplex     resCx;

	  TAddFuncStruct FS;

	  TOperData     OpData;

	  Int32        VT[20];
	  Int32        adrVE0, adrVD0, adrVU0, adrVU01, adrVU02, adrVU03, adrVI0, adrVS0, adrVE10, adrVD10, adrVECE0,adrVECE20, adrVECD0, adrVECI0, adrVE02, adr;
	  Int32         adrVI01, adrVD01, adrVS01;
	  double       resd;
	  TFloatType   a,b,a1,b1,c1,d1,e1,f1;

      TFloatType   Fnc1x,Fnc2x,Fnc2y,Fnc3x,Fnc3y,Fnc3z,resg;
      TComplexNum  RezG;

      Pointer32    PtrS;
      string       strOut,strTmp;
      std::string  SD2,SDX2,SDY2,SDXY,StrDiff;
      TStringType  chTmp;
      char         cht;

      TByte10  y10;
      Extended xb,zb,xet,xet1,xt1;
      _int32  adr1,adr2;
      _int32  iN,iK;

      long double xe1,ye1;








     //***********************************************************
     flLoad=flInit();
     if (flLoad != 0)
     {

         /*
         flGet(fl_COMPILED_BY,0,ID);
         if (ID >= 100 ) {DLLCompiledBy = Lazarus;} else {DLLCompiledBy = Delphi;};
         */


         /** !!! The first command should be to set the string type !!!  **/

         flSet(fl_STRING_TYPE, fl_ANSISTRING,0); /// example only for ansi,for other string types see Builder's example
         //flSet(fl_STRING_TYPE,fl_WIDESTRING,0);
         //flSet(fl_STRING_TYPE,fl_STRING_UTF8,0);
         //flSet(fl_STRING_TYPE,fl_STRING_UTF16,0);





         flSet(fl_RESULT_LEAD_TO_TYPE, fl_STAY_AS_IS,0); /// type of result remains unchanged
         //flSet(fl_RESULT_LEAD_TO_TYPE, fl_COMPLEX,0);  /// type of result of expressions lead to complex,
         //flSet(fl_RESULT_LEAD_TO_TYPE, fl_REAL,0);     /// type of result of expressions lead to real


         //
		 flSetDiffVar("x");

		 flSetExtAddrErrorFPU(&FPUError); ///address var. for returns error code at calculation in TypeCalcProc = 5,6(with masked FPU exception)


         flSet(fl_ENABLE, fl_SHOW_EXCEPTION,0); //show exception message from Foreval.dll


         //flSet(fl_ENABLE,fl_MASK_FPU_EXCEPTION,0); //set it, If exceptions at errors are not caught at parsing inside dll
                                                      //t-x*(a/(a*(b+1)-(1+b)*a))+y; t-y*power(-1.1,1.1)*2+x; 2*x*sqrt(2/(4-5))+y;


        // catching floating point exceptions inside Foreval may be unstable if Foreval is compiled to FPC
        // if (DLLCompiledBy == Lazarus) { flSet(fl_ENABLE,fl_MASK_FPU_EXCEPTION,0);}


         flSet(fl_ENABLE,fl_USE_VIRTUAL_ALLOC,0);  ///Not necessary, if the program(exe) does not generate an error. If (exe) from MSVC - necessarily to use !!


        /// set type for const. & temporary results. For greater accuracy use Extended type for saving intermediate result of calculations
        flSet(fl_STACK_TYPE,fl_EXTENDED,0);        // for more precision
          //flSet(fl_STACK_TYPE,fl_DOUBLE,0);      // for more speed




          flSet(fl_ENABLE, fl_INSERT_INLINE,0);    /// for some external added  functions with type fl_Precompiled and key {$IN+}.


         #ifdef   EXTENDED_FLOAT
           // flSet(fl_STACK_TYPE,fl_EXTENDED,0);
            RType = fl_REAL_EXTENDED; CxType = fl_COMPLEX_EXTENDED; VType = fl_ARRAY_REAL_EXTENDED; MType = fl_EXTENDED;
         #else
           // flSet(fl_STACK_TYPE,fl_DOUBLE,0);
            RType = fl_REAL_DOUBLE; CxType = fl_COMPLEX_DOUBLE;  VType = fl_ARRAY_REAL_DOUBLE; MType = fl_DOUBLE;
         #endif

         // flSet(fl_STD_FUNC, fl_ACCURATE,0);


            /**
               Set float (real+complex) variables   (passed to Foreval):
               RType  = fl_REAL_DOUBLE;    fl_REAL_EXTENDED
               CxType = fl_COMPLEX_DOUBLE; fl_COMPLEX_EXTENDED;
            **/


            #ifdef   COMPLEX_VAR_ANY_ADDR   /// <- complex variables are set the same as in GCC TComplexNum
                flSetVarCx("z1",&z1.re,&z1.im,CxType);
                flSetVarCx("z2",&z2.re,&z2.im,CxType);
                flSetVarCx("z3",&z3.re,&z3.im,CxType);
                flSetVarCx("z4",&z4.re,&z4.im,CxType);
                flSetVarCx("z5",&z5.re,&z5.im,CxType);
                pvZ1=&z1; pvZ2=&z2; pvZ3=&z3;
            #else                           /// <- complex variables are set the same as internal Foreval
                flSetVar("z1",&z1f,CxType);
                flSetVar("z2",&z2f,CxType);
                flSetVar("z3",&z3f,CxType);
                flSetVar("z4",&z4f,CxType);
                flSetVar("z5",&z5f,CxType);
                pvZ1=&z1f; pvZ2=&z2f; pvZ3=&z3f;
            #endif

            /// ResultR, ResultCX, Result, Res - associated with the same global variable. ResultR pointing to real part of it.
            /// Used for store results of calculations through global var in all expressions.
            /// For compatibility, always TComplexF
            flSetVarCx("ResultCx", &resf.re,&resf.im, CxType);
            flSetVarCx("Result",   &resf.re,&resf.im, CxType);
            flSetVarCx("Res",      &resf.re,&resf.im, CxType);
            flSetVar("ResultR",    &resf.re, RType);


            flSetVar("x",&x,RType);
            flSetVar("y",&y,RType);
            flSetVar("t",&t,RType);
            flSetVar("r",&r,RType);
            flSetVar("s",&s,RType);
            flSetVar("u",&u,RType);
            flSetVar("v",&v,RType);
            flSetVar("q",&q,RType);
            flSetVar("p",&p,RType);





         /// Set integer  variables:
            flSetVar("n",&n,fl_REAL_INTEGER);
            flSetVar("k",&k,fl_REAL_INTEGER);
            flSetVar("j",&j,fl_REAL_INTEGER);
            flSetVar("m",&m,fl_REAL_INTEGER);
            flSetVar("l",&l,fl_REAL_INTEGER);
            flSetVar("lenv",&lenv,fl_REAL_INTEGER);
            flSetVar("LenVU",&LenVU,fl_REAL_INTEGER);

        /// Set pointer variables
            flSetVar("ptr1",&Ptr1,fl_POINTER);
            flSetVar("ptr2",&Ptr2,fl_POINTER);
            flSetVar("ptr3",&Ptr3,fl_POINTER);
            flSetVar("ptr4",&Ptr4,fl_POINTER);
            flSetVar("ptr5",&Ptr5,fl_POINTER);

            flSetVar("PtrF1",&PtrF1,fl_POINTER);
            flSetVar("PtrF2",&PtrF2,fl_POINTER);
            flSetVar("PtrF3",&PtrF3,fl_POINTER);
            flSetVar("PtrF4",&PtrF4,fl_POINTER);
            flSetVar("PtrF5",&PtrF5,fl_POINTER);


            flSetVar("PtrV",&PtrV,fl_POINTER);
            flSetVar("PtrV0",&PtrV0,fl_POINTER);

            flSetVar("Ptr0Vu1",&Ptr0Vu1,fl_POINTER);
            flSetVar("Ptr0Vu2",&Ptr0Vu2,fl_POINTER);
            flSetVar("Ptr0Vu3",&Ptr0Vu3,fl_POINTER);





         /**
           Set parameters (real+complex)
           Parameters must be definite before setting
           For greater accuracy use Extended type for parameters
         **/


         /** A, B, C, D, E, F, G,  Ai, Bi, Ci - defined as const **/

         Ae=A;
         Be=B;
         Ce=C;
         De=D;
         Ee=E;
         Fe=F;
         Ge=G;

         Acx.re=Ai.re; Acx.im=Ai.im;
         Bcx.re=Bi.re; Bcx.im=Bi.im;
         Ccx.re=Ci.re; Ccx.im=Ci.im;
         Dcx.re=De;    Dcx.im=Ce-Ae;
         Ecx.re=Ee;    Ecx.im=Be-De;
         Fcx.re=Fe;    Fcx.im=Ge-Fe;
         Gcx.re=Ge;    Gcx.im=Ae-Ge;



         flSetParamE("a",Ae,0,fl_REAL);  /// flSetParamD("a",Ae,0,fl_REAL); if parameters values passed as double
         flSetParamE("b",Be,0,fl_REAL);
         flSetParamE("c",Ce,0,fl_REAL);
         flSetParamE("d",De,0,fl_REAL);
         flSetParamE("e",Ee,0,fl_REAL);
         flSetParamE("f",Fe,0,fl_REAL);
         flSetParamE("g",Ge,0,fl_REAL);

         flSetParamE("ai",Acx.re,Acx.im,fl_COMPLEX);  /// flSetParamD("ai",Acx.re,Acx.im,fl_COMPLEX);  if parameters values passed as double
         flSetParamE("bi",Bcx.re,Bcx.im,fl_COMPLEX);
         flSetParamE("ci",Ccx.re,Ccx.im,fl_COMPLEX);
         flSetParamE("di",Dcx.re,Dcx.im,fl_COMPLEX);
         flSetParamE("ei",Ecx.re,Ecx.im,fl_COMPLEX);
         flSetParamE("fi",Fcx.re,Fcx.im,fl_COMPLEX);
         flSetParamE("gi",Gcx.re,Gcx.im,fl_COMPLEX);


         flSetParamI("DblCS",8);  /// size double
         flSetParamI("ExtCS",12); /// size extended in GCC arrays (in Delphi - 10)



  n = 1; k = 2; j = 5; m = -3; l = 4;

  x = 2.123l; y = 5.456l;  t = -3.789l;
  r = 1.357l; s = -5.135l; p = 2.246l;
  q = 3.678l; u = -1.468l; v = 4.975l;


  z1f.re=2.123l;   z1f.im=-1.456l;
  z2f.re=5.456l;   z2f.im=2.789l;
  z3f.re=-3.789l;  z3f.im=-3.123l;
  z4f.re=-5.135l;  z4f.im=3.975l;
  z5f.re=2.246l;   z5f.im=1.753l;

  z1.re = z1f.re;  z1.im = z1f.im;
  z2.re = z2f.re;  z2.im = z2f.im;
  z3.re = z3f.re;  z3.im = z3f.im;
  z4.re = z4f.re;  z4.im = z4f.im;
  z5.re = z5f.re;  z5.im = z5f.im;


  z1s.real(z1.re); z1s.imag(z1.im);
  z2s.real(z2.re); z2s.imag(z2.im);
  z3s.real(z3.re); z3s.imag(z3.im);
  z4s.real(z4.re); z4s.imag(z4.im);
  z5s.real(z5.re); z5s.imag(z5.im);


  InitRealPointerVar(&x, &y, &t);
  InitComplexPointerVar(pvZ1, pvZ2, pvZ3);
  InitGlobalResPointerVar(&resf);



  /*
  ad.set_length(3);
  ad[0]=3.5; ad[1]=-1.4;  ad[2]=7.6;
*/



//  i.re=0; i.im=1;
  i0.re=0; i0.im=0;

  /*
  pe1 = &z1.re;
  pe2 = &z1.im;
  adr1 = (_int32)pe1;
  adr2 = (_int32)pe2;
  lv = adr2 - adr1;
 */

  /*
  vd=new double[11];
  vd[0]=1.1; vd[1]=2.2; vd[2]=3.3;
  adr1=&vd[0];
  int adr2 = 0;
  px=&vd[0];
  pi1=(PInteger)px;
  pi1=pi1-1;
  //px=px-4;
  //pi1=(PInteger)px;
  n=*pi1;


  LPF->Text= n.ToString();
  */
  //px=px+1;
  //T=*px;
  //LPF->Text= T.ToString();

  //n=(int)(adr2-4);
  //T= (*double)(n);
 /*
  vecd.push_back(1.1);
  vecd.push_back(2.2);
  vecd.push_back(3.3);
  vecd.push_back(4.4);
  vecd.push_back(5.5);
*/
  //vecd[0]=0;


    ///*************** Set arrays ****************************************************************************************************************
    /**
        Foreval  deals with dynamic arrays in format of Delphi. Structure array of Delphi:
        cells:
           Len  vec[0]  vec[1]  vec[2]   vec[3] ...
        |   4b|   0   |   1   |   2   |   3   | ...
        Len - Length of array is lie in 4 bytes before first element - zero cell: vec[0]

        In FPC instead length, saved High of array = Length-1 !!! which is incompatible with Delphi format.!!! Need correct length in this case.
        Variable of dynamic array type of Delphi ( addrVec = &vec[0]), is Pointer32 (INT32) , contains address of zero cell of array.
        Using in command:
        flSetVarIntrnl("vec",ArrayType, addrVec);
        flSetLength(addrVec, ArrayType, Len);
        flSetArrayValue<I,D,E>(addrVec,indx,val);
        flGetArrayValue<I,D,E>(addrVec,indx,&val);

        After set new length placing in memory of array is changing, so &vec[0] be other, and it rewrite  in addrVec.
        So, addrVec always contain pointer to current placing of array.

        Command flSetVar("vec",vec, ArrayType) used  only! for Delphi/FPC format dynamic array.
        There are more fast way using of dynamic array defined in Gcc with Foreval.dll. See below in examples.

    **/

      /**
         Warning!!
         In GCC, Extended type is placement in 12 bytes. And it write at once more than 10 byte - 12.
         So, dynamic array of Extended type in Gcc incompatibility with array of Extended type in Foreval (placement 10 bytes in cell)
         Exceeding 2 bytes in the last element causes AV when copying GCC  array to Foreval (extended array) and writes invalid data otherwise (Foreval->GCC).
         Instead, for compatibility  may to use dynamic array of type TByte10 - TArrayE_10; Size of cell - 10 bytes.
         Writing array of TByte10 through type conversion ( ve10[indx] = ExtendedVar ) :       *PByte10(&ve10[indx]) = *PByte10(&ExtendedVar);
         Read data from cell of array of TByte10 ( ExtendedVar= vec10[indx] ):                 ExtendedVar =  *PExtended(&vec10[indx])
         Besides, coping GCC (array of TByte10) between to Foreval (array of Extended) are implementation more fast than coping standard GCC (array of Extended).
        **/



  flSetVarIntrnl("vps",VType,adrVPS);
  flSetVarIntrnl("vpr",VType,adrVPR);

  lenv = 100;
  /// Define  arrays  (passed from  Foreval)           Set it length
  flSetVarIntrnl("ad",fl_ARRAY_REAL_DOUBLE,adrAD);     flSetLength(adrAD, fl_ARRAY_REAL_DOUBLE, 3);
  flSetVarIntrnl("vd",fl_ARRAY_REAL_DOUBLE,adrVD);     flSetLength(adrVD, fl_ARRAY_REAL_DOUBLE, lenv);
  flSetVarIntrnl("ve",fl_ARRAY_REAL_EXTENDED,adrVE);   flSetLength(adrVE, fl_ARRAY_REAL_EXTENDED, lenv);
  flSetVarIntrnl("vd1",fl_ARRAY_REAL_DOUBLE,adrVD1);   flSetLength(adrVD1,fl_ARRAY_REAL_DOUBLE, lenv);
  flSetVarIntrnl("ve1",fl_ARRAY_REAL_EXTENDED,adrVE1); flSetLength(adrVE1,fl_ARRAY_REAL_EXTENDED, lenv);
  flSetVarIntrnl("ve2",fl_ARRAY_REAL_EXTENDED,adrVE2); flSetLength(adrVE2,fl_ARRAY_REAL_EXTENDED, lenv);
  flSetVarIntrnl("ve3",fl_ARRAY_REAL_EXTENDED,adrVE3); flSetLength(adrVE3,fl_ARRAY_REAL_EXTENDED, lenv);
  flSetVarIntrnl("vi",fl_ARRAY_REAL_INTEGER,adrVI);    flSetLength(adrVI, fl_ARRAY_REAL_INTEGER, lenv);
  flSetVarIntrnl("vs",fl_ARRAY_REAL_SINGLE,adrVS);     flSetLength(adrVS, fl_ARRAY_REAL_SINGLE, lenv);

  flSetVarIntrnl("vi1",fl_ARRAY_REAL_INTEGER,adrVI1);  flSetLength(adrVI1, fl_ARRAY_REAL_INTEGER, lenv);
  flSetVarIntrnl("vs1",fl_ARRAY_REAL_SINGLE,adrVS1);   flSetLength(adrVS1, fl_ARRAY_REAL_SINGLE, lenv);

  /// vu,vu1,vu2,vu3 -
  flSetVarIntrnl("vu", VType,adrVU);                   flSetLength(adrVU,  VType, lenv);
  flSetVarIntrnl("vu1",VType,adrVU1);                  flSetLength(adrVU1, VType, lenv);
  flSetVarIntrnl("vu2",VType,adrVU2);                  flSetLength(adrVU2, VType, lenv);
  flSetVarIntrnl("vu3",VType,adrVU3);                  flSetLength(adrVU3, VType, lenv);

  flSetVar("LenSCM1u",&LenSCM1u,fl_REAL_INTEGER);
  flSetVarIntrnl("M1u",  VType, adrM1u);
  flSetVarIntrnl("M1ux", VType, adrM1ux);
  flSetVarIntrnl("M1uy", VType, adrM1uy);
  flSetVar("Ptr0M1u", &Ptr0M1u, fl_POINTER);
  flSetVar("Ptr0M1ux",&Ptr0M1ux,fl_POINTER);
  flSetVar("Ptr0M1uy",&Ptr0M1uy,fl_POINTER);


  adrVE0  = *PInteger(adrVE);  /// adrVE0=@ve[0] ;
  adrVI0  = *PInteger(adrVI);  /// adrVI0=@vi[0] ;
  adrVD0  = *PInteger(adrVD);  /// adrVD0=@vd[0] ;
  adrVS0  = *PInteger(adrVS);  /// adrVS0=@vs[0] ;

  adrVU0   = *PInteger(adrVU);  /// adrVU0=@vu[0] ;
  adrVU01  = *PInteger(adrVU1);  /// adrVU01=@vu1[0] ;
  adrVU02  = *PInteger(adrVU2);  /// adrVU02=@vu2[0] ;
  adrVU03  = *PInteger(adrVU3);  /// adrVU03=@vu3[0] ;

  flSetVar("vdf", &adrVDF ,fl_ARRAY_REAL_DOUBLE);    /// Set array  in GCC  (passed to Foreval)

  /**
     After each changing the length of the array: flSetLength (adrVEC, fl_ARRAY_REAL_DOUBLE, LEN);
     these pointers are also changing (adrVE0 adrVI0 adrVD0).So as array has new placement in memory.
     Need again read these pointers.
  **/

   /// Set GCC arrays
   vd.resize(lenv);  vdt.resize(lenv);
   ve.resize(lenv);  vet.resize(lenv);
   vi.resize(lenv);  vit.resize(lenv);
   vs.resize(lenv);  vst.resize(lenv);
   vu.resize(lenv);
   vi1.resize(lenv);
   vs1.resize(lenv);
   vd1.resize(lenv);
   ve1.resize(lenv);
   ve2.resize(lenv);
   ve3.resize(lenv);
   vu1.resize(lenv); vu1t.resize(lenv);
   vu2.resize(lenv); vu2t.resize(lenv);
   vu3.resize(lenv); vu3t.resize(lenv);
   ve10.resize(lenv); /// array of type TByte10 - TArrayE_10;




   //vf.resize(101);  /// for "fast connect": see below



    ///  Write data of arrays:
    for (ni = 0; ni <=lenv-1; ni++)
	{
        vd[ni]=ni+1;
        ve[ni]=ni+5;
        vs[ni]=ni+3;

        ve1[ni]=ni+2;
        ve2[ni]=ni+3;
        ve3[ni]=ni+4;

        vd1[ni]=ni+2;
        vs1[ni]=ni+2;

        ve1[ni]=powl(-1,ni+2)*ve1[ni]*0.7l;
        ve2[ni]=powl(-1,ni+3)*ve2[ni]*0.5l;
        ve3[ni]=powl(-1,ni+4)*ve3[ni]*0.3l;

        vd1[ni]=pow(-1,ni+2)*vd1[ni]*0.7;
        vs1[ni]=pow(-1,ni+2)*vs1[ni]*0.7;

        vu1[ni]=ve1[ni];
        vu2[ni]=ve2[ni];
        vu3[ni]=ve3[ni];

        vd[ni]=pow((double)(-1),(Int32)(ni+1))*vd[ni]*0.5;
        ve[ni]=powl((Extended)(-1),(Int32)(ni+5))*ve[ni]*0.5l;
        vs[ni]=pow(-1,ni+3)*vs[ni]*0.5;
        *PByte10(&ve10[ni]) = *PByte10(&ve2[ni]);


        vi[ni]=truncl(ve[ni]);
        vi1[ni]=truncl(ve1[ni]);

        //vf[ni+1]=ve[ni];

        vdt[ni]=vd[ni];
        vet[ni]=ve[ni];
        vit[ni]=vi[ni];
        vst[ni]=vs[ni];
        vu1t[ni]=vu1[ni];
        vu2t[ni]=vu3[ni];
        vu3t[ni]=vu3[ni];


                     /**   Write data Foreval arrays by coping GCC arrays:          **/

         //---------------------------  integer array vi ---------------------------------------------------

          //flSetArrayValueI(adrVI,ni,vi[ni]);
               /** or so, more fast **/
           *PInteger(adrVI0 + ni * 4) = vi[ni];  //4-sizeOf(integer)

         //-------------------------------------------------------------------------------


        //---------------------------  single array vs ---------------------------------------------------

          //flSetArrayValueS(adrVS,ni,vs[ni]);
               /** or so, more fast **/
           *PSingle(adrVS0 + ni * 4) = vs[ni];  //4-sizeOf(single)

         //-------------------------------------------------------------------------------



       //----------------------------- double array vd --------------------------------------------------

         //flSetArrayValueD(adrVD,ni,vd[ni]);
               /** or so, more fast  **/
           *PDouble(adrVD0 + ni * 8) = vd[ni]; //8-sizeOf(double)

       //--------------------------------------------------------------------------------



      //------------------------- extended array ve -----------------------------------------------------

       //flSetArrayValueE(adrVE,ni,ve[ni]);
                /** or so, more fast **/
       *PByte10(adrVE0 + ni * 10) = *PByte10(&ve[ni]);  /// 10-sizeOf(extended)
                   /// instead it:
       //*PExtended(adrVE0 + ni * 10) = ve[ni];  /// 10-sizeOf(extended)

        /**
         Use  this command (through PByte10) instead *PExtended(addr) = x;
         So that in GCC, Extended type is placement in 12 bytes.
         And it write at once more than 10 byte - 12, at coping through *PExtended(addr).
         Excess by 2 bytes in the last element results in AV! or corruption data in array.
        **/

     //-------------------------------------------------------------------------------




          #ifdef   EXTENDED_FLOAT
            vu[ni]=ve[ni];
            flSetArrayValueE(adrVU,ni,ve[ni]);
            flSetArrayValueE(adrVU1,ni,ve1[ni]);
            flSetArrayValueE(adrVU2,ni,ve2[ni]);
            flSetArrayValueE(adrVU3,ni,ve3[ni]);
          #else
            vu[ni]=vd[ni];
            flSetArrayValueD(adrVU,ni,vd[ni]);
            flSetArrayValueD(adrVU1,ni,ve1[ni]);
            flSetArrayValueD(adrVU2,ni,ve2[ni]);
            flSetArrayValueD(adrVU3,ni,ve3[ni]);
          #endif



       //---------------------------------------------------------------------------------
	}

 //goto endc;

  //------------------------------------------------------------------------------------

      /**
                   Coping array of double GCC(vd1)=>Foreval(vd1)
	    To write Foreval array "vd1" through copy to memory from DCC array vd1[]
	    adrVD01=@vd1[0] ;
	    (Pointer32)(adrVD01) lead to pointer
      **/

      flSetLength(adrVD1, fl_ARRAY_REAL_DOUBLE, vd1.size());   //set new length in Foreval array
	  //vd01=(Pointer32)(*((PInteger)adrVD1));  /// = &vd1[0] in Foreval
	  //CopyMemory(vd01,&vd1[0],8*vd1.size());   /// 8 - sizeof(double)
	  SZ=vd1.size();
      adrVD01=*PInteger(adrVD1);  /// adrVD01=@vd1[0] ;
              /// system proc. copy:
      //CopyMemory((Pointer32)(adrVD10),&vd1[0],8*vd1.size());   /// 8 - sizeof(double)
             /// internal Foreval proc. copy; More fast:   !!!  addrDest = addrSource !!! Size is  numbers of cell !!!
      flCopyArrayDbl((Pointer32)(adrVD01),&vd1[0],SZ);

   //--------------------------------------------------------------------------------------



      /**
                Coping array of extended GCC(ve1)=>Foreval(ve1)
        For array of Extended type (ve1: TArrayE), setting it by CopyMemory don't work,
            so as size of cell for element (TArrayE)  in Foreval = 10,  in Gcc = 12
        Need write procedure of copying (CopyArrayExtGF)
      **/


                /**  ve1(Gcc) => ve1(Foreval) **/

      flSetLength(adrVE1, fl_ARRAY_REAL_EXTENDED, ve1.size());  /// set new length in Foreval array
      SZ=ve1.size();
      psrc = &ve1[0];
      pdest =(Pointer32)(*((PInteger)adrVE1));  /// = &ve1[0] in Foreval
      //pdest = (PInteger)adrXVE1;
            /// GCC proc. copy arrays:
      //CopyArrayExtGF(psrc,pdest,SZ);
           /// internal Foreval proc. copy; More fast:
      flCopyArrayExtDSC(pdest, psrc, 12,10,SZ);  /// 12 - size of cell in extended array GCC; 10 - size of cell in extended array Foreval; Size is numbers of cell !!!


   //---------------------------------------------------------------------------------------


      /**
             Coping modify array of extended (ve10 array of TByte10) GCC(ve10)=>Foreval(ve2)
	         To write Foreval array "ve2"  through copy to memory from gcc array ve10[]
	         adrVE02=@ve2[0] ;
	         (Pointer32)(adrVE02) lead to pointer
      **/

      flSetLength(adrVE2, fl_ARRAY_REAL_EXTENDED, ve10.size());   /// set new length in Foreval array
      SZ = ve10.size();
      adrVE02 = *PInteger(adrVE2);  /// adrVE02=@ve2[0] ;
      //CopyMemory((Pointer32)(adrVE02),&ve10[0],10*ve10.size());   /// 10 - sizeof(Extended)
          /// internal Foreval proc. copy; More fast:   !!! addrDest = addrSource  !!! Size in numbers of cell !!!
      flCopyArrayExt((Pointer32)(adrVE02), &ve10[0], SZ);

   //--------------------------------------------------------------------------------------



   //--------------------------------------------------------------------------------------


      /**
                   Coping array of integer GCC(vi1)=>Foreval(vi1)
	    To write Foreval array "vi1" through copy to memory from DCC array vi1[]
	    adrVI01=@vi1[0] ;
	    (Pointer32)(adrVI01) lead to pointer
      **/

      flSetLength(adrVI1, fl_ARRAY_REAL_INTEGER, vi1.size());   //set new length in Foreval array
	  //vi01=(Pointer32)(*((PInteger)adrVI1));  /// = &vi1[0] in Foreval
	  //CopyMemory(vi01,&vi1[0],4*vi1.size());   /// 4 - sizeof(integer)
	  SZ=vi1.size();
      adrVI01=*PInteger(adrVI1);  /// adrVI01=@vi1[0] ;
              /// system proc. copy:
      //CopyMemory((Pointer32)(adrVI01),&vi1[0],4*vi1.size());   /// 4 - sizeof(integer)
             /// internal Foreval proc. copy; More fast:   !!!  addrDest = addrSource !!! Size is  numbers of cell !!!
      flCopyArrayInt((Pointer32)(adrVI01),&vi1[0],SZ);

   //--------------------------------------------------------------------------------------



   //--------------------------------------------------------------------------------------


      /**
                   Coping array of single GCC(vs1)=>Foreval(vs1)
	    To write Foreval array "vs1" through copy to memory from DCC array vs1[]
	    adrVS01=@vs1[0] ;
	    (Pointer32)(adrVS01) lead to pointer
      **/

      flSetLength(adrVS1, fl_ARRAY_REAL_SINGLE, vs1.size());   //set new length in Foreval array
	  //vs01=(Pointer32)(*((PInteger)adrVS1));  /// = &vs1[0] in Foreval
	  //CopyMemory(vs01,&vs1[0],4*vs1.size());   /// 4 - sizeof(single)
	  SZ=vs1.size();
      adrVS01=*PInteger(adrVS1);  /// adrVS01=@vs1[0] ;
              /// system proc. copy:
      //CopyMemory((Pointer32)(adrVS01),&vs1[0],4*vs1.size());   /// 4 - sizeof(single)
             /// internal Foreval proc. copy; More fast:   !!!  addrDest = addrSource !!! Size is  numbers of cell !!!
      flCopyArrayInt((Pointer32)(adrVS01),&vs1[0],SZ); // for coping single array use flCopyArrayInt , so as the same size of array = 4b

   //--------------------------------------------------------------------------------------




 /** if data and length of vd is changed, that need reinstall VD  without recompiling expression , consisting of 'vd' **/
	/*
	  vd.resize(1000);
	  for (ni = 0; ni <=999; ni++)
	  {
		vd[ni]=ni+1.123;
	  }

	 flSetLength(adrVD, fl_ARRAY_REAL_DOUBLE, vd.size());
	 vd0=(Pointer32)(*((PInteger)adrVD));
	 CopyMemory(vd0,&vd[0],8*vd.size());
	*/


  //flSetVarIntrnl("an",fl_ARRAY_REAL_EXTENDED,adrAN); flSetLength(adrAN,fl_ARRAY_REAL_EXTENDED, 15);
  //flSetVarIntrnl("bn",fl_ARRAY_REAL_EXTENDED,adrBN); flSetLength(adrBN,fl_ARRAY_REAL_EXTENDED, 15);





  flSetVarIntrnl("vpF3",fl_ARRAY_POINTER,adrVpF3);     //flSetLength(adrVpF3, fl_ARRAY_POINTER, 3);
  flSetVarIntrnl("vp1",fl_ARRAY_POINTER,adrVp1);
  flSetVarIntrnl("vp2",fl_ARRAY_POINTER,adrVp2);
  flSetVarIntrnl("vp3",fl_ARRAY_POINTER,adrVp3);


  /// array for Poly(CP1,x),  Poly(CP12,z1)
  len=13;
  CP12.resize(len);
  CP12[12]=1.1l;CP12[11]=-2.1l;CP12[10]=-3.1l;CP12[9]=2.2l;CP12[8]=-3.3l;CP12[7]=-5.7l;CP12[6]=2.3l;CP12[5]=-9.8l;CP12[4]=1.7l;
  CP12[3]=1.4l;CP12[2]=-7.5l;CP12[1]=7.7l;CP12[0]=12.3l;

  #ifdef   EXTENDED_FLOAT
    flSetVarIntrnl("CP12",fl_ARRAY_REAL_EXTENDED,adrCP12);
    flSetLength(adrCP12,fl_ARRAY_REAL_EXTENDED ,len);
  #else
    flSetVarIntrnl("CP12",fl_ARRAY_REAL_DOUBLE,adrCP12);
    flSetLength(adrCP12,fl_ARRAY_REAL_DOUBLE,len);
  #endif

   for(ni=0; ni <= len-1; ni++)
     {
        #ifdef   EXTENDED_FLOAT
          flSetArrayValueE(adrCP12,ni,CP12[ni]);
        #else
          flSetArrayValueD(adrCP12,ni,CP12[ni]);
        #endif

     };


   InitIntegral();


   flSetVar("N_Integral",&N_Integral,fl_REAL_INTEGER);
   flSetVar("P_Integral",&P_Integral,fl_REAL_INTEGER);

   flSetVarIntrnl("Aint",VType,adrAint);
   flSetVarIntrnl("Bint",VType,adrBint);

   flSetLength(adrAint, VType, N_Integral);
   flSetLength(adrBint, VType, N_Integral);


   for(ni = 1; ni <= N_Integral; ni++)
   {
      #ifdef   EXTENDED_FLOAT
          flSetArrayValueE(adrAint,ni-1,an[ni]);
          flSetArrayValueE(adrBint,ni-1,bn[ni]);
      #else
          flSetArrayValueD(adrAint,ni-1,an[ni]);
          flSetArrayValueD(adrBint,ni-1,bn[ni]);
      #endif

   };




/******************************************************************************


                         Addition external functions:

*******************************************************************************/



/**


 func1(arg1)=arg1^2;
 func2(arg1,arg2)=arg1-arg2;
 func3(arg1,arg2,arg3)=arg1+arg2-arg3;

 arg1,arg2,arg3 - real/complex
 arg1,arg2 - mixed real/complex

 sp1, sp2, sp3      fl_VARS_VALUES
 ps1, ps2, ps3      fl_VARS_ADDRS
 ms1, ms2, ms3      fl_VARS_LIST_ADDR_ESP
 pc1, pc2, pc3      fl_PreCompiled


 ---------------------------------------


 sp8(TArrayE vx, Int32 nx, Extended x, TArrayD vd, Int32 nd, double d,  TArrayI vi, Int32 ni):real = (vx[nx]*x-vd[nd]*d)*vi[ni]
 ps8(TArrayE vx, Int32 nx, Extended x, TArrayD vd, Int32 nd, double d,  TArrayI vi, Int32 ni):real = (vx[nx]*x-vd[nd]*d)*vi[ni]
 ms8(TArrayE vx, Int32 nx, Extended x, TArrayD vd, Int32 nd, double d,  TArrayI vi, Int32 ni):real = (vx[nx]*x-vd[nd]*d)*vi[ni]
 pc8(TArrayE vx, Int32 nx, Extended x, TArrayD vd, Int32 nd, double d,  TArrayI vi, Int32 ni):real = (vx[nx]*x-vd[nd]*d)*vi[ni]

      < with complex arg.: >
 sp8(TArrayE vx, Int32 nx, TComplexE zx, TArrayD vd, Int32 nd, TComplexD zd,  TArrayI vi, Int32 ni):complex = (vx[nx]*zx-vd[nd]*zd)*vi[ni]
 ms8(TArrayE vx, Int32 nx, TComplexE zx, TArrayD vd, Int32 nd, TComplexD zd,  TArrayI vi, Int32 ni):complex = (vx[nx]*zx-vd[nd]*zd)*vi[ni]
 ps8(TArrayE vx, Int32 nx, TComplexE zx, TArrayD vd, Int32 nd, TComplexD zd,  TArrayI vi, Int32 ni):complex = (vx[nx]*zx-vd[nd]*zd)*vi[ni]
 pc8(TArrayE vx, Int32 nx, TComplexE zx, TArrayD vd, Int32 nd, TComplexD zd,  TArrayI vi, Int32 ni):complex = (vx[nx]*zx-vd[nd]*zd)*vi[ni]


----------------------------------------------

      < with arg. of all types: >

 func10(TArrayE vx, Int32 nx, TComplexE zx, TArrayD vd, Int32 nd, double d, TComplexD zd, Extended x, TArrayI vi, Int32 ni) = (vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]

 spall    fl_VARS_VALUES
 psall    fl_VARS_ADDRS
 msall    fl_VARS_LIST_ADDR_ESP
 pcall    fl_PreCompiled

----------------------------------------------
        < procedures. ( void function(vec,x) ) >

 FillArray(TArrayD vd, Double x)   =   vd[all] = x
 FillArray(TArrayE ve, Extended x) =   ve[all] = x
 FillArray(TArrayI vi, Integer x)  =   vi[all] = x

-------------------------------------------------

   < splain functions: >  (see examples)

 spl1(x:real)
 spl2(x:real)

---------------------------------------------------

      < functions without arguments: >

 sp0r():real     = 123.456789;
 sp0z():complex  = 321.98765+456.789123i;
 psor():real     = 123.456789;
 psoz():complex  = 321.98765+456.789123i;

-----------------------------------------------------

   < functions, passing the identifier: >  (see examples)

 idsin, idcos;
 idFncCF

---------------------------------------------------------

            < OVERLOAD: >

 Fovrl()=pi^2;
 Fovrl(x:real)=x^2;
 Fovrl(z:complex)=z^2;
 Fovrl(vu:array; n:integer)=vu[n]^2;

---------------------------------------------------------

              < INFINITE (fl_INFINITE) >

 infsum(...,real,...):real       = sum(of all arguments)
 infsum(...,complex,...):complex = sum(of all arguments)

-------------------------------------------------------------
There are only one! differentiation template for all overloaded functions with the same name (restriction of versions  Foreval 9.0-9.1)
--------------------------------------------------------------


********************************************************************************
**/




  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP1;
  FS.CallType=fl_CDECL;
  FS.Arg=1;
  FS.ArgType=RType; //fl_real_double;   fl_real_extended;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=1;
  flSetFunction("sp1",&FS,&idFP);
  flSetDiffTemplate(&idFP,"2*$arg1*$dfarg1");

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP2;
  FS.CallType=fl_STDCALL;
  FS.Arg=2;
  FS.ArgType=RType; //fl_real_double;   fl_real_extended;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=1;
  flSetFunction("sp2",&FS,&idFP);
  flSetDiffTemplate(&idFP,"$dfarg1-$dfarg2");

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP3;
  FS.CallType=fl_CDECL;
  FS.Arg=3;
  FS.ArgType=RType;  //fl_real_double;   fl_real_extended;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=1;
  flSetFunction("sp3",&FS,&idFP);
  flSetDiffTemplate(&idFP,"$dfarg1+$dfarg2-$dfarg3");

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP1Z;
  FS.CallType=fl_CDECL;
  FS.Arg=1;
  FS.ArgType=CxType; //fl_COMPLEX_DOUBLE,fl_COMPLEX_EXTENDED ;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("sp1",&FS,&idFP);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP2Z;
  FS.CallType=fl_CDECL;
  FS.Arg=2;
  FS.ArgType=CxType; //fl_COMPLEX_DOUBLE,fl_COMPLEX_EXTENDED ;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("sp2",&FS,&idFP);

  //mixed
  //sp2(z,x)=z-x
  InitFuncStruct(FS);
  FS.Arg=2;
  //VT.set_length(FS.Arg);
  VT[0]=CxType; //fl_COMPLEX_DOUBLE,fl_COMPLEX_EXTENDED ;
  VT[1]=RType;   //fl_real_double;   fl_real_extended;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&SP2ZR;
  FS.CallType=fl_CDECL;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("sp2",&FS,&idFP);

  //sp2(x,z)=x-z
  InitFuncStruct(FS);
  FS.Arg=2;
  //VT.set_length(FS.Arg);
  VT[0]=RType;    //fl_real_double;   fl_real_extended;
  VT[1]=CxType; //fl_COMPLEX_DOUBLE,fl_COMPLEX_EXTENDED ;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&SP2RZ;
  FS.CallType=fl_CDECL;
  FS.Arg=2;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("sp2",&FS,&idFP);

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP3Z;
  FS.CallType=fl_STDCALL;
  FS.Arg=3;
  FS.ArgType=CxType;//fl_COMPLEX_DOUBLE,fl_COMPLEX_EXTENDED ;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("sp3",&FS,&idFP);

  InitFuncStruct(FS);
  FS.Arg=3;
  VT[0]=CxType;
  VT[1]=RType;
  VT[2]=CxType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&SP3ZRZ;
  FS.CallType=fl_STDCALL;
  FS.ArgType = fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("sp3",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=3;
  VT[0]=RType;
  VT[1]=CxType;
  VT[2]=RType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&SP3RZR;
  FS.CallType=fl_STDCALL;
  FS.ArgType = fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("sp3",&FS,&idFP);



  //ps1(x)
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS1;
  FS.CallType=fl_CDECL;
  FS.Arg=1;
  FS.ArgType=RType;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=1;
  flSetFunction("ps1",&FS,&idFP);
  flSetDiffTemplate(&idFP,"2*$arg1*$dfarg1");

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS2;
  FS.CallType=fl_CDECL;
  FS.Arg=2;
  FS.ArgType=RType;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=1;
  flSetFunction("ps2",&FS,&idFP);
  flSetDiffTemplate(&idFP,"$dfarg1-$dfarg2");

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS3;
  FS.CallType=fl_STDCALL;
  FS.Arg=3;
  FS.ArgType=RType;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=1;
  flSetFunction("ps3",&FS,&idFP);

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS1Z;
  FS.CallType=fl_CDECL;
  FS.Arg=1;
  FS.ArgType=CxType;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=1;
  flSetFunction("ps1",&FS,&idFP);

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS2Z;
  FS.CallType=fl_CDECL;
  FS.Arg=2;
  FS.ArgType=CxType;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=2;
  flSetFunction("ps2",&FS,&idFP);

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS3Z;
  FS.CallType=fl_STDCALL;
  FS.Arg=3;
  FS.ArgType=CxType;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=2;
  flSetFunction("ps3",&FS,&idFP);
  flSetDiffTemplate(&idFP,"$dfarg1+$dfarg2-$dfarg3");

    //mixed
  //ps2(z,x)=z-x
  InitFuncStruct(FS);
  FS.Arg=2;
  VT[0]=CxType;
  VT[1]=RType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&PS2ZR;
  FS.CallType=fl_CDECL;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=2;
  flSetFunction("ps2",&FS,&idFP);

  //ps2(x,z)=x-z
  InitFuncStruct(FS);
  FS.Arg=2;
  VT[0]=RType;
  VT[1]=CxType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&PS2RZ;
  FS.CallType=fl_CDECL;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=2;
  flSetFunction("ps2",&FS,&idFP);

  InitFuncStruct(FS);
  FS.Arg=3;
  VT[0]=CxType;
  VT[1]=RType;
  VT[2]=CxType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&PS3ZRZ;
  FS.CallType=fl_STDCALL;
  FS.ArgType = fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=2;
  flSetFunction("ps3",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=3;
  VT[0]=RType;
  VT[1]=CxType;
  VT[2]=RType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&PS3RZR;
  FS.CallType=fl_STDCALL;
  FS.ArgType = fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=2;
  flSetFunction("ps3",&FS,&idFP);


  //ms1
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&MS1;
  FS.ArgType=RType;
  FS.Arg=1;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=1;
  FS.ResultType=fl_REAL;
  flSetFunction("ms1",&FS,&idFP);
  flSetDiffTemplate(&idFP,"2*$arg1*$dfarg1");

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&MS2;
  FS.ArgType=RType;
  FS.Arg=2;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=1;
  FS.ResultType=fl_REAL;
  flSetFunction("ms2",&FS,&idFP);
  flSetDiffTemplate(&idFP,"$dfarg1-$dfarg2");

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&MS3;
  FS.ArgType=RType;
  FS.Arg=3;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=1;
  FS.ResultType=fl_REAL;
  flSetFunction("ms3",&FS,&idFP);
  flSetDiffTemplate(&idFP,"$dfarg1+$dfarg2-$dfarg3");

   //ms2z
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&MS1Z;
  FS.ArgType=CxType;
  FS.Arg=1;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("ms1",&FS,&idFP);

   //ms2z
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&MS2Z;
  FS.ArgType=CxType;
  FS.Arg=2;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("ms2",&FS,&idFP);

   //ms3z
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&MS3Z;
  FS.ArgType=CxType;
  FS.Arg=3;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("ms3",&FS,&idFP);

  //mixed
  //ms2(z,x)=z-x
  InitFuncStruct(FS);
  FS.Arg=2;
  VT[0]=CxType;
  VT[1]=RType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&MS2ZR;
  FS.CallType=fl_CDECL;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.DeepFPU=2;
  flSetFunction("ms2",&FS,&idFP);

  //ms2(x,z)=x-z
  InitFuncStruct(FS);
  FS.Arg=2;
  VT[0]=RType;
  VT[1]=CxType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&MS2RZ;
  FS.CallType=fl_CDECL;
  FS.Arg=2;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.DeepFPU=2;
  flSetFunction("ms2",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=3;
  VT[0]=CxType;
  VT[1]=RType;
  VT[2]=CxType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&MS3ZRZ;
  FS.CallType=fl_CDECL;
  FS.ArgType = fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.DeepFPU=2;
  flSetFunction("ms3",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=3;
  VT[0]=RType;
  VT[1]=CxType;
  VT[2]=RType;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&MS3RZR;
  FS.CallType=fl_CDECL;
  FS.ArgType = fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.DeepFPU=2;
  flSetFunction("ms3",&FS,&idFP);




  //func(TArrayE vx, Int32 nx, Extended x, TArrayD vd, Int32 nd, double d,  TArrayI vi, Int32 ni) = (vx[nx]*x-vd[nd]*d)*vi[ni]
  InitFuncStruct(FS);
  FS.Arg=8;
  //VT.set_length(FS.Arg);
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_REAL_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE; VT[4]=fl_REAL_INTEGER;
  VT[5]=fl_REAL_DOUBLE; VT[6]=fl_ARRAY_REAL_INTEGER; VT[7]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&SP8;
  FS.ArgType=fl_DIFFER;
  FS.CallType=fl_CDECL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("sp8",&FS,&idFP);
  //sp8(ve,n+3,x*t,vd,j+k,x-y,vi,n+k+j)

  InitFuncStruct(FS);
  FS.Arg=8;
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_COMPLEX_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE; VT[4]=fl_REAL_INTEGER;
  VT[5]=fl_COMPLEX_DOUBLE; VT[6]=fl_ARRAY_REAL_INTEGER; VT[7]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&SP8Z;
  FS.ArgType=fl_DIFFER;
  FS.CallType=fl_CDECL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=3;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("sp8",&FS,&idFP);
  //sp8(ve,n+3,z1*z2,vd,j+k,z3-z2,vi,n+k+j)


  //func(TArrayE *vx, Int32 *nx, Extended *x, TArrayD *vd, Int32 *nd, double *d,  TArrayI *vi, Int32 *ni) = (vx[nx]*x-vd[nd]*d)*vi[ni]
  InitFuncStruct(FS);
  FS.Arg=8;
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_REAL_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE; VT[4]=fl_REAL_INTEGER;
  VT[5]=fl_REAL_DOUBLE; VT[6]=fl_ARRAY_REAL_INTEGER; VT[7]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&PS8;  //ps8
  FS.ArgType=fl_DIFFER;
  FS.CallType=fl_CDECL;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("ps8",&FS,&idFP);
  //ps8(ve,n+3,x*t,vd,j+k,x-y,vi,n+k+j)

  InitFuncStruct(FS);
  FS.Arg=8;
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_COMPLEX_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE; VT[4]=fl_REAL_INTEGER;
  VT[5]=fl_COMPLEX_DOUBLE; VT[6]=fl_ARRAY_REAL_INTEGER; VT[7]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&PS8Z;
  FS.ArgType=fl_DIFFER;
  FS.CallType=fl_CDECL;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=3;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("ps8",&FS,&idFP);
  //ps8(ve,n+3,z1*z2,vd,j+k,z3-z2,vi,n+k+j)




  //func(TArrayE vx, Int32 nx, Extended x, TArrayD vd, Int32 nd, double d,  TArrayI vi, Int32 ni) = (vx[nx]*x-vd[nd]*d)*vi[ni]
  //func(adr) = (vx[nx]*x-vd[nd]*d)*vi[ni]
  InitFuncStruct(FS);
  FS.Arg=8;
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_REAL_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE; VT[4]=fl_REAL_INTEGER;
  VT[5]=fl_REAL_DOUBLE; VT[6]=fl_ARRAY_REAL_INTEGER; VT[7]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&MS8;
  FS.ArgType=fl_DIFFER;
  FS.CallType=fl_CDECL;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("ms8",&FS,&idFP);
  //ms8(ve,n+3,x*t,vd,j+k,x-y,vi,n+k+j)



  InitFuncStruct(FS);                   //idsin(x)^2+idcos(x)^2
  FS.addr=(Pointer32)&idfunc;
  FS.Arg=1;
  FS.ArgType=RType;
  FS.CallType=fl_STDCALL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=0;
  FS.Set_ID=fl_ENABLE;
  FS.Id_Func=1;
  FS.ResultType=fl_REAL;
  flSetFunction("idSin",&FS,&idFP);
  FS.Id_Func=2;
  flSetFunction("idCos",&FS,&idFP);



  //idFncCF(z,x,vu,n,id) = z*vu[n]*x*CFid[id];
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&idFncCF;
  FS.Arg=4;
  //VT.resize(FS.Arg);
  VT[0]=CxType; VT[1]=RType;  VT[2]=VType;   VT[3]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.ArgType=fl_DIFFER;
  FS.CallType=fl_STDCALL;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=2;
  FS.Set_ID=fl_ENABLE;
  FS.Id_Func=1;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("idFnc1",&FS,&idFP);
  FS.Id_Func=2;
  flSetFunction("idFnc2",&FS,&idFP);
  FS.Id_Func=3;
  flSetFunction("idFnc3",&FS,&idFP);
  FS.Id_Func=4;
  flSetFunction("idFnc4",&FS,&idFP);
  InitCFid(FS.Id_Func);



  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SUMR;
  FS.ArgType=RType;
  FS.CallFunc=fl_INFINITE;
  FS.CallType=fl_CDECL;
  FS.ResultType=fl_REAL;
  FS.DeepFPU=2;
  flSetFunction("infsum",&FS,&idFP);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SUMZ;
  FS.ArgType=CxType;
  FS.CallFunc=fl_INFINITE;
  FS.CallType=fl_CDECL;
  FS.ResultType=fl_COMPLEX;
  FS.DeepFPU=2;
  flSetFunction("infsum",&FS,&idFP);



  //sp0()  : real

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP0;
  FS.CallType=fl_STDCALL;
  FS.Arg=0;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=1;
  flSetFunction("sp0r",&FS,&idFP);


  //sp0() :complex
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&SP0Z;
  FS.CallType=fl_STDCALL;
  FS.Arg=0;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=1;
  flSetFunction("sp0z",&FS,&idFP);

  //ps0()
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS0;
  FS.CallType=fl_CDECL;
  FS.Arg=0;
  FS.ArgType=RType;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=1;
  flSetFunction("ps0r",&FS,&idFP);

  //ps0()
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&PS0Z;
  FS.CallType=fl_CDECL;
  FS.Arg=0;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=1;
  flSetFunction("ps0z",&FS,&idFP);




  //_cdecl SPALL(__int32 vx, __int32 nx, TComplexE zx, __int32 vd, __int32 nd, double d, TComplexD zd, Extended x, __int32 vi, __int32 ni)
  InitFuncStruct(FS);
  FS.Arg=10;
  FS.addr=(Pointer32)&SPALL;
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_COMPLEX_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE;
  VT[4]=fl_REAL_INTEGER; VT[5]=fl_REAL_DOUBLE; VT[6]=fl_COMPLEX_DOUBLE;  VT[7]=fl_REAL_EXTENDED;
  VT[8]=fl_ARRAY_REAL_INTEGER; VT[9]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.CallType=fl_CDECL;
  //FS.ArgType=fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=3;
  flSetFunction("spall",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=10;
  FS.addr=(Pointer32)&PSALL;
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_COMPLEX_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE;
  VT[4]=fl_REAL_INTEGER; VT[5]=fl_REAL_DOUBLE; VT[6]=fl_COMPLEX_DOUBLE;  VT[7]=fl_REAL_EXTENDED;
  VT[8]=fl_ARRAY_REAL_INTEGER; VT[9]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.CallType=fl_CDECL;
  //FS.ArgType=fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=3;
  flSetFunction("psall",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=10;
  FS.addr=(Pointer32)&MSALL;
  VT[0]=fl_ARRAY_REAL_EXTENDED; VT[1]=fl_REAL_INTEGER; VT[2]=fl_COMPLEX_EXTENDED; VT[3]=fl_ARRAY_REAL_DOUBLE;
  VT[4]=fl_REAL_INTEGER; VT[5]=fl_REAL_DOUBLE; VT[6]=fl_COMPLEX_DOUBLE;  VT[7]=fl_REAL_EXTENDED;
  VT[8]=fl_ARRAY_REAL_INTEGER; VT[9]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.CallType=fl_CDECL;
  //FS.ArgType=fl_DIFFER;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_LIST_ADDR_ESP;
  FS.DeepFPU=3;
  flSetFunction("msall",&FS,&idFP);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FOVRL_;
  FS.CallType=fl_STDCALL;
  FS.Arg=0;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=1;
  flSetFunction("fovrl",&FS,&idFP);

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FOVRL_R;
  FS.CallType=fl_STDCALL;
  FS.Arg=1;
  FS.ArgType=RType;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("fovrl",&FS,&idFP);

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FOVRL_CX;
  FS.CallType=fl_CDECL;
  FS.Arg=1;
  FS.ArgType=CxType;
  FS.ResultType=fl_COMPLEX;
  FS.CallFunc=fl_VARS_ADDRS;
  FS.DeepFPU=3;
  flSetFunction("fovrl",&FS,&idFP);

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FOVRL_V;
  FS.CallType=fl_CDECL;
  FS.Arg=2;
  VT[0]=VType; VT[1]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.ArgType=fl_DIFFER;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=2;
  flSetFunction("fovrl",&FS,&idFP);


  //goto endc;

  /// FillArrayD(TArrayD vd, Double x) = vd[all]=x
  InitFuncStruct(FS);
  FS.Arg=2;
  //VT.set_length(FS.Arg);
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_DOUBLE;  VT[1]=fl_REAL_DOUBLE;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&FillArrayD;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_NONE;
  flSetFunction("FillArray",&FS,&idFP);



  /// FillArrayE(TArrayE ve, Extended x) = ve[all]=x
  InitFuncStruct(FS);
  FS.Arg=2;
  //VT.set_length(FS.Arg);
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_EXTENDED;  VT[1]=fl_REAL_EXTENDED;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&FillArrayE;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_NONE;
  flSetFunction("FillArray",&FS,&idFP);


  /// FillArrayI(TArrayI vi, Integer x) = vi[all]=x
  InitFuncStruct(FS);
  FS.Arg=2;
  //VT.set_length(FS.Arg);
  //VT.resize(FS.Arg);
  VT[0]=fl_ARRAY_REAL_INTEGER;  VT[1]=fl_REAL_INTEGER;
  FS.ArgTypeList=&VT[0];
  FS.addr=(Pointer32)&FillArrayI;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_NONE;
  flSetFunction("FillArray",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=1;
  FS.ArgType=fl_POINTER;
  FS.addr=(Pointer32)&gccSumVd;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_REAL;
  flSetFunction("gccSumVd",&FS,&idFP);


  InitFuncStruct(FS);
  FS.Arg=1;
  FS.ArgType=fl_POINTER;
  FS.addr=(Pointer32)&gccSumVe;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_REAL;
  flSetFunction("gccSumVe",&FS,&idFP);

  InitFuncStruct(FS);
  FS.Arg=1;
  FS.ArgType=fl_POINTER;
  FS.addr=(Pointer32)&gccSumVi;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_CDECL;
  FS.DeepFPU=2;
  FS.ResultType=fl_REAL;
  flSetFunction("gccSumVi",&FS,&idFP);





    //flSet(fl_ENABLE,fl_USE_VIRTUAL_ALLOC); /// with this fl_Precompiled functions run faster.

  flSetFunction("pcall(vx: arrayExt; nx:int; zx: Cxext; vd: arrayDbl; nd: int; d: dbl; zd: Cxdbl; x: ext; vi: arrayInt; ni: int):complex=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]",0,&idFP);


//Key-Prefix{$IN+} make function inline at compilation, if it's allowed in mode  fl_INSERT_INLINE. But, gives very small increase to performance
#ifdef   EXTENDED_FLOAT
    flSetFunction("{$IN+}pc1(x:ext):real=x^2",0,&idFP);
    flSetDiffTemplate(&idFP,"2*$arg1*$dfarg1");
    flSetFunction("{$IN+}pc2(x,y:ext):real=x-y",0,&idFP);
    flSetDiffTemplate(&idFP,"$dfarg1-$dfarg2");
    flSetFunction("{$IN+}pc3(x1,x2,x3:ext):real=x1+x2-x3",0,&idFP);
    flSetDiffTemplate(&idFP,"$dfarg1+$dfarg2-$dfarg3");
    flSetFunction("{$IN+}pc1(z:Cxext):complex=z^2",0,&idFP);
    flSetFunction("pc2(x:ext;z:Cxext):complex=x-z",0,&idFP);
    flSetFunction("pc2(z:Cxext; x:ext):complex=z-x",0,&idFP);
    flSetFunction("pc2(z1,z2:Cxext):complex=z1-z2",0,&idFP);
    flSetFunction("pc3(z1,z2,z3:Cxext):complex=z1+z2-z3",0,&idFP);
    flSetFunction("pc3(z1:Cxext;x2:ext;z3:Cxext):complex=z1+x2-z3",0,&idFP);
    flSetFunction("pc3(x1:ext;z2:Cxext;x3:ext):complex=x1+z2-x3",0,&idFP);

    flSetFunction("{$IN+}int1func(x:ext):real=(a*x+b)*(c*x+d)/(a*x^2+b*x+c)",0,&idFP);
  #else
    flSetFunction("{$IN+}pc1(x:dbl):real=x^2",0,&idFP);
    flSetDiffTemplate(&idFP,"2*$arg1*$dfarg1");
    flSetFunction("{$IN+}pc2(x,y:dbl):real=x-y",0,&idFP);
    flSetDiffTemplate(&idFP,"$dfarg1-$dfarg2");
    flSetFunction("{$IN+}pc3(x1,x2,x3:dbl):real=x1+x2-x3",0,&idFP);
    flSetDiffTemplate(&idFP,"$dfarg1+$dfarg2-$dfarg3");
    flSetFunction("{$IN+}pc1(z:Cxdbl):complex=z^2",0,&idFP);
    flSetFunction("pc2(x:dbl;z:Cxdbl):complex=x-z",0,&idFP);
    flSetFunction("pc2(z:Cxdbl; x:dbl):complex=z-x",0,&idFP);
    flSetFunction("pc2(z1,z2:Cxdbl):complex=z1-z2",0,&idFP);
    flSetFunction("pc3(z1,z2,z3:Cxdbl):complex=z1+z2-z3",0,&idFP);
    flSetFunction("pc3(z1:Cxdbl;x2:dbl;z3:Cxdbl):complex=z1+x2-z3",0,&idFP);
    flSetFunction("pc3(x1:dbl;z2:Cxdbl;x3:dbl):complex=x1+z2-x3",0,&idFP);

    flSetFunction("{$IN+}int1func(x:dbl):real=(a*x+b)*(c*x+d)/(a*x^2+b*x+c)",0,&idFP);

#endif

   flSetFunction("pc8(vx: arrayExt; nx:int; x: ext; vd: arrayDbl; nd: int; d: dbl; vi: arrayInt; ni: int):real = (vx[nx]*x - vd[nd]*d)*vi[ni]",0,&idFP);
   flSetFunction("pc8(vx: arrayExt; nx:int; zx: Cxext; vd: arrayDbl; nd: int; zd: Cxdbl; vi: arrayInt; ni: int):complex = (vx[nx]*zx - vd[nd]*zd)*vi[ni]",0,&idFP);



 //flSet(fl_DISABLE,fl_USE_VIRTUAL_ALLOC);



// *****************   Call Functions & Procedures with arguments passed by  Pointers  *******************************************

 //spproc2r(2*x,3*y,@res.re); res.re
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&spproc2r;
  FS.Arg=3;
  VT[0]=RType;  VT[1]=RType;  VT[2]=fl_POINTER;
  FS.ArgTypeList=&VT[0];
  FS.ArgType=fl_DIFFER;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=2;
  FS.ResultType=fl_NONE;
  flSetFunction("spproc2r",&FS,&idFP);




  //spproc2c(2*z1,3*z2,@z3); z3
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&spproc2c;
  FS.Arg=3;
  VT[0]=CxType;  VT[1]=CxType;  VT[2]=fl_POINTER;
  FS.ArgTypeList=&VT[0];
  FS.ArgType=fl_DIFFER;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=2;
  FS.ResultType=fl_NONE;
  flSetFunction("spproc2c",&FS,&idFP);



  // x=1.1; y=5.5; spprocswpinc2r(@x,@y);
  // x=1.1; y=5.5; t=spprocswpinc2r(@x,@y); x
  // x=1.1; y=5.5; t=spprocswpinc2r(@x,@y); y
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&spprocswpinc2r;
  FS.Arg=2;
  FS.ArgType=fl_POINTER;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=2;
  FS.ResultType=fl_REAL;
  flSetFunction("spprocswpinc2r",&FS,&idFP);




  // z1=1.1+2.2i; z2=5.5+7.7i; spprocswpinc2c(@z1,@z2);
  // z1=1.1+2.2i; z2=5.5+7.7i; z3=spprocswpinc2c(@z1,@z2); z1
  // z1=1.1+2.2i; z2=5.5+7.7i; z3=spprocswpinc2c(@z1,@z2); z2
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&spprocswpinc2c;
  FS.Arg=2;
  FS.ArgType=fl_POINTER;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("spprocswpinc2c",&FS,&idFP);




  //x=3; z1=1.1+2.2i; spprocsqr2(@x,@z1); x
  //x=3; z1=1.1+2.2i; spprocsqr2(@x,@z1); z1
  InitFuncStruct(FS);
  FS.addr=(Pointer32)&spprocsqr2;
  FS.Arg=2;
  FS.ArgType=fl_POINTER;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_NONE;
  flSetFunction("spprocsqr2",&FS,&idFP);




  //spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3); (resR=x+y; resC=z1+z2; resI=n1+n2; resV=vu1+vu2)
  //x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  s-(2*x+1 + 3*y+2)
  //x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  m-(n+k + 2*j*k)
  //x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  z5-(2*z1 + 5*z1+z2)
  //x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  r=0; for(k,0,len(vu3)-1,r=vu3[k]-(vu1[k]+vu2[k]));r
  //x=1; y=2; n=3; k=4; z1=3+4i; z2= 5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3);  r=0; kf:int=0;  for(kf,0,len(vu3)-1,r=r+(vu1[kf]+vu2[kf])); r/sum(vu3)+s/(2*x+1 + 3*y+2)+ m/(n+k + 2*j*k)+z5/(2*z1 + 5*z1+z2)




  InitFuncStruct(FS);
  FS.addr=(Pointer32)&spprocsumall;
  FS.Arg=12;
  VT[0]=RType;  VT[1]=RType;
  VT[2]=fl_REAL_INTEGER;  VT[3]=fl_REAL_INTEGER;
  VT[4]=CxType;  VT[5]=CxType;
  VT[6]=VType;   VT[7]=VType;
  VT[8]=fl_POINTER;  VT[9]=fl_POINTER;  VT[10]=fl_POINTER;  VT[11]=fl_POINTER;
  FS.ArgTypeList=&VT[0];
  FS.ArgType=fl_DIFFER;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=4;
  FS.ResultType=fl_NONE;
  flSetFunction("spprocsumall",&FS,&idFP);





 ///*************** INTEGRAL FUNCTIONS**************************///

  InitFuncStruct(FS);
  FS.Arg=10;
  FS.addr=(Pointer32)&Integral3FF;
  VT[0]=fl_POINTER; VT[1]=fl_POINTER; VT[2]=fl_POINTER; VT[3]=fl_POINTER;
  VT[4]=RType; VT[5]=RType;
  VT[6]=fl_POINTER; VT[7]=fl_POINTER; VT[8]=fl_POINTER; VT[9]=fl_POINTER;
  FS.ArgTypeList=&VT[0];
  FS.CallType=fl_STDCALL;
  FS.ArgType=fl_DIFFER;
  FS.ResultType=fl_REAL;
  FS.CallFunc=fl_VARS_VALUES;
  FS.DeepFPU=8;
  flSetFunction("Integral3FF",&FS,&idFP);



  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FRInt1XYT;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("FRInt1XYT",&FS,&idFP);
  flSetFunction("pcInt1XYT():real=0.11*x*(0.32*t-0.23*y)",0,&idFP1);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FRInt2XYT;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("FRInt2XYT",&FS,&idFP);
  flSetFunction("pcInt2XYT():real=0.17*t*(0.31*x+0.17*y)",0,&idFP2);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FRInt3XYT;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("FRInt3XYT",&FS,&idFP);
  flSetFunction("pcInt3XYT():real=0.21*y*(0.25*x-0.15*t)",0,&idFP3);



  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FRLim1X;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("FRLim1X",&FS,&idFP);
  flSetFunction("pcLim1X():real=-0.5*sqr(x-1.1)",0,&idFP);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FRLim2X;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("FRLim2X",&FS,&idFP);
  flSetFunction("pcLim2X():real=0.7*sqr(x+1.7)",0,&idFP);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FRLim3XY;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("FRLim3XY",&FS,&idFP);
  flSetFunction("pcLim3XY():real=-0.1*sqr(1.1*x-0.2*y)",0,&idFP);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&FRLim4XY;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=3;
  FS.ResultType=fl_REAL;
  flSetFunction("FRLim4XY",&FS,&idFP);
  flSetFunction("pcLim4XY():real=0.2*sqr(1.2*x-0.3*y)",0,&idFP);


/**
n:int=IntPartitions-1;
h:ext=|b-a|/IntPartitions;
int1:ext=0;
//j:int=0;
//k:int=0;
L:int=Len(Aint)-1;



for(j=0, n-1,
        x1:ext=a+j*h;
        x2:ext=a+(j+1)*h;
        ax:ext=(x1+x2)*0.5;
        sx:ext=(x2-x1)*0.5;
        for(k=0, L,
            x:ext=sx*Bint[k]+ax;
            int1=int1+Aint[k]*int1func(x)*sx;
           );
   );

int1;
**/






 /*****************   Call Functions by Pointers  *******************************************/

  InitFuncStruct(FS);
  FS.addr=(Pointer32)&_RFuncPtr;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=4;
  FS.ResultType=fl_REAL;
  flSetFunction("rfunc",&FS,&idFP);
  flSetFunction("pcrfunc():real = 2.5*x+1.7*y",0,&idFP1);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&_ZFuncPtr;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=4;
  FS.ResultType=fl_COMPLEX;
  flSetFunction("zfunc",&FS,&idFP);
  flSetFunction("pczfunc():complex = 2.5*z1-1.7*z2",0,&idFP2);


  InitFuncStruct(FS);
  FS.addr=(Pointer32)&_NFuncPtr;
  FS.Arg=0;
  FS.CallFunc=fl_VARS_VALUES;
  FS.CallType=fl_STDCALL;
  FS.DeepFPU=4;
  FS.ResultType=fl_NONE;
  flSetFunction("nfunc",&FS,&idFP);
  flSetFunction("pcnfunc():none = res=2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i",0,&idFP3);//res (resf) - global var.







/****************      SPLAIN FUNCTIONS       ****************************/



/**         spl1(x) = (sin(3*x)-cos(2*x))*exp(-x/10);    -15<=x<=15     **/


/**using internal arrays:**/

 hx=0.1;      //<=1!!!
 ax=-15.0; bx=15.0; sx=ax;
 lv=_trunc(_abs(bx-ax)/hx)+1;
 flSetVarIntrnl("svx",VType,adrSVX); ///  VType = fl_ARRAY_REAL_EXTENDED; fl_ARRAY_REAL_DOUBLE;
 flSetVarIntrnl("svy",VType,adrSVY);
 flSetLength(adrSVX,VType,lv);
 flSetLength(adrSVY,VType,lv);


 for(ic=0;ic <= lv-1; ic++)
 {
   if (VType ==  fl_ARRAY_REAL_EXTENDED) {flSetArrayValueE(adrSVX,ic,sx);} else {flSetArrayValueD(adrSVX,ic,sx);}; /// key EXTENDED_FLOAT
   fx=(sin(3*sx)-cos(2*sx))*exp(-sx/10);
   if (VType ==  fl_ARRAY_REAL_EXTENDED) {flSetArrayValueE(adrSVY,ic,fx);} else {flSetArrayValueD(adrSVY,ic,fx);}; /// key EXTENDED_FLOAT
   sx=sx+hx;
 };



 flSetSplainFunction("spl1",adrSVX,adrSVY,VType,&idFP);
 //flGetErrorCode(ECode); if (ECode != 0){ShowError();}





/**                         spl2(x) = x*(sin(x)+cos(x));          -10<=x<=10  **/

/**using external arrays with "fast connection": arrays (xspl,yspl) must placing in 'unmanaged memory' !!! **/


 hx=0.1;      //<=1!!!
 ax=-10; bx=10; sx=ax;
 lv=_trunc(_abs(bx-ax)/hx)+1;
 xspl.resize(lv+2);  /// +1: in "0" - length
 yspl.resize(lv+2);  /// +1: in "0" - length



 for (ic = 1; ic <= xspl.size()-1; ic++)
 {
   xspl[ic]=sx;
   yspl[ic]=sx*(sin(sx)+cos(sx));
   sx=sx+hx;
 }

 adrXSPL=&xspl[1];  /// to set a  reference to the array. To second cell!  adrXSPL  always: placing in 'unmanaged memory' !
 adrYSPL=&yspl[1];  /// to set a  reference to the array. To second cell!  adrYSPL  always: placing in 'unmanaged memory'!

  /// to write length:
  pint1 = (PInteger)adrXSPL;
  pint1=pint1-1; ///  = &xspl[1]-4b; or = &xspl[0]+4b;  sizeof(double) = 8
  if (DLLCompiledBy == Delphi) {SZ = xspl.size()-1;} else {SZ=xspl.size()-2;};  /// DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
  *pint1 = SZ;  ///  pint1 = &xspl[1]-4b;  *pint1 <- length

  pint1 = (PInteger)adrYSPL;
  pint1=pint1-1; ///  = &yspl[1]-4b; or = &yspl[0]+4b;  sizeof(double) = 8
  if (DLLCompiledBy == Delphi) {SZ = yspl.size()-1;} else {SZ=yspl.size()-2;};  ///  DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
  *pint1 = SZ;  ///  pint1 = &yspl[1]-4b;  *pint1 <- length

  flSetSplainFunction("spl2",&adrXSPL,&adrYSPL,fl_ARRAY_REAL_DOUBLE,&idFP);
 //flGetErrorCode(ECode); if (ECode != 0){ShowError();}

   /**
         NOTE!:
           xspl,yspl: TArrayD

	       For an array GCC of Extended type (TArrayE), setting it this way does not work due to difference cell size extended type GCC vs Delphi.
           To use  an array GCC of Extended type need set it as TArrayE_10, or conversion it to Foreval extended type array by copying flCopyArrayExtDSC
              or set as internal from Foreval flSetVarIntrnl.


	   **/


 //z4s=acosh(z3s*(z2s+z1s-z3s));
 //ShowResult("acosh()=",z4s.real(),z4s.imag());



  //*************************************************************************************************************************************


    LoadDataLib();

    cout <<  "" << endl;
    cout <<  "" << endl;
    cout <<  "" << endl;

    asktst:
    fflush(stdin);
    printf("Run a internal tests Foreval?, Y/N: ");
    cout <<  "" << endl;
    cht=getchar();
    //scanf("%d", &GNC);
    if(tolower(cht) == 'n')
        goto endc;
    else  if(tolower(cht) != 'y')
        goto asktst;




/***********************************************************************************************************************/
/**                               EXAMPLES                                                                            **/
/***********************************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "                 Internal test. Run  examples                              " << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "                   Examples (1)                                            " << endl;
   cout <<  "         Using of array.    Standard way. Extended type                    " << endl;
   cout <<  "                   See comments in text of program                         " << endl;
   cout <<  "-----------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;

  /**                    Example using of array (1)   Standard way. Extended type of array.           **/





  flSetVarIntrnl("vece",fl_ARRAY_REAL_EXTENDED,adrVECE);  ///  set new array of Extended defined from Foreval
  flCompile("k:int=0; len:int=len(vece); s:ext=0; for(k = 0,len-1,s=s+vece[k]); ResultR = sum(vece); s",0, DynArray1);  ///  out: ResultR = sum(vece),s=sum(vece)
  flCompile("len: int=len(vece); vet: arrayExt=len; k:int=0;  for(k = 0,len-1,vet[k]=vece[k]); FillArray(vece,1.0); ResultR=sum(vece); sum(vet)",0,DynArray2);///  out: ResultR = sum(vece),sum(vet<=vece)


  /**Run 3 times with different length of array 'vece' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  /// new length of array
       flSetLength(adrVECE, fl_ARRAY_REAL_EXTENDED, lenv); /// set new length in Foreval array
       /**
          after  command  flSetLength(adrVECE, fl_ARRAY_REAL_EXTENDED, lenv), placement array Foreval is changed in memory. Need to get new reference to first element.
          or use command  flSetArrayValueE(adrVECE,indx,val);
       **/
       /// To write data in Foreval array (vece)
       adrVECE0=*PInteger(adrVECE);
       for (ni = 0; ni <=lenv-1; ni++)
	   {
         //flSetArrayValueE(adrVECE,ni,ni+1);
          /// or more fast:
         *PExtended(adrVECE0 + ni * 10) = ni+1;  /// 10-sizeOf(extended)
	   }
	    /// without recompiling expressions with vece
       res = flResultR(DynArray1);   /// res = s; resf.re=ResultR; global var.
       ShowResult(res,resf.re);
       res = flResultR(DynArray2);   /// res = sum(vet); resf.re=ResultR=sum(vece); global var.
       ShowResult(res,resf.re);

       ///Copy vece(Foreval)->vece(Gcc); vece filled by 1.0 after DynArray2  ( = len(vece) )
       vece.resize(lenv);
       psrc =(Pointer32)(*((PInteger)adrVECE));  /// = &vece[0] in Foreval
       pdest = &vece[0];
       //CopyArrayExtFG(psrc,pdest,lenv);
           /// internal Foreval proc. copy; More fast:
       flCopyArrayExtDSC(pdest, psrc,10,12,lenv);  /// 12 - size of cell in extended array GCC; 10 - size of cell in extended array Foreval; Size is numbers of cell !!!

       sumv=0;
       for (ki = 0; ki <= lenv-1; ki++)
       {
          sumv=vece[ki]+sumv;
       }
       ShowResult(sumv);

       cout <<  "--------------------------------------------------------------" << endl;


       /**
          Answer out = sum(vece)   sum(vece);     <- vece(Foreval) after call DynArray1
                       sum(vece)   len(vece);     <- vece(Foreval) after call DynArray2
                       len(vece);                 <- vece(GCC)
       **/
  }

  cout <<  "" << endl;
  //goto endc;


/***********************************************************************************************************************/

/**                    Example using of array (2)   Standard way. Modify Extended type of array (of TByte10).           **/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (2)                                  " << endl;
 cout <<  "         Using of array.    Standard way.  Modify Extended type of array (of TByte10)                                  " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "-----------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;


  /**                    Example using of array (2).   Standard way.  Modify Extended type of array (of TByte10).          **/





  flSetVarIntrnl("vece2",fl_ARRAY_REAL_EXTENDED,adrVECE2);  ///  set new array of Extended defined from Foreval
  flCompile("k:int=0; len:int=len(vece2); s:ext=0; for(k=0,len-1,s=s+vece2[k]); ResultR = sum(vece2); s",0, DynArray1);  ///  out: ResultR = sum(vece2),s=sum(vece2)
  flCompile("len: int=len(vece2); vet2: arrayExt=len; k:int=0;  for(k=0,len-1,vet2[k]=vece2[k]); FillArray(vece2,1.0); ResultR=sum(vece2); sum(vet2)",0,DynArray2);///  out: ResultR = sum(vece2),sum(vet2<=vece2)


  /**Run 3 times with different length of array 'vece2' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  //new length of array
       flSetLength(adrVECE2, fl_ARRAY_REAL_EXTENDED, lenv); /// set new length in Foreval array
       /**
          after  command  flSetLength(adrVECE2, fl_ARRAY_REAL_EXTENDED, lenv), placement array Foreval is changed in memory. Need to get new reference to first element.
          or use command  flSetArrayValueE(adrVECE2,indx,val);
       **/
       /// To write data in Foreval array (vece2)
       adrVECE20=*PInteger(adrVECE2);
       for (ni = 0; ni <=lenv-1; ni++)
	   {
        //flSetArrayValueE(adrVECE2,ni,ni+1);
          /// or more fast:
        *PExtended(adrVECE20 + ni * 10) = ni+1;  /// 10-sizeOf(extended)
          /// may use instead *PByte10, because performed calculations in FPU, but no coping (mem to mem).
	   }
	    /// without recompiling expressions with vece2
       res = flResultR(DynArray1);   /// res = s; resf.re=ResultR; global var.
       ShowResult(res,resf.re);
       res = flResultR(DynArray2);   /// res = sum(vet); resf.re=ResultR=sum(vece); global var.
       ShowResult(res,resf.re);

       ///Copy vece2(Foreval)->vece10(Gcc); vece2 filled by 1.0 after DynArray2  ( = len(vece2) )
       vece10.resize(lenv);
       //CopyMemory(&vece10[0], (Pointer32)(adrVECE20),10*vece10.size());   /// 10 - sizeof(double)
          /// more fast coping:
       flCopyArrayExt(&vece10[0],(Pointer32)(adrVECE20),lenv);

       sumv=0;
       for (ki = 0; ki <= lenv-1; ki++)
       {
          //sumv = vece10[ki]+sumv;

          sumv =  *PExtended(&vece10[ki]) + sumv;
       }
       ShowResult(sumv);

       cout <<  "--------------------------------------------------------------" << endl;


       /**
          Answer out = sum(vece2)   sum(vece2);     <- vece2(Foreval) after call DynArray1
                       sum(vece2)   len(vece2);     <- vece2(Foreval) after call DynArray2
                       len(vece10);                 <- vece10(GCC)
       **/
  }

  cout <<  "" << endl;
  //goto endc;

/***********************************************************************************************************************/

/**                    Example using of array (3)   Standard way. Double type of array.           **/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (3)                                  " << endl;
 cout <<  "         Using of array.    Standard way. Double type            " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "-----------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;





  flSetVarIntrnl("vecd",fl_ARRAY_REAL_DOUBLE,adrVECD); ///  set new array of double defined from Foreval
  flCompile("k:int=0; len:int=len(vecd); s:ext=0; for(k=0,len-1,s=s+vecd[k]); ResultR = sum(vecd); s",0, DynArray1); // out: ResultR = sum(vecd),s=sum(vecd)
  flCompile("len: int=len(vecd); vdt: arrayDbl=len; k:int=0;  for(k=0,len-1,vdt[k]=vecd[k]); FillArray(vecd,1.0); ResultR=sum(vecd); sum(vdt)",0,DynArray2);// out: ResultR = sum(vecd),sum(vdt<=vecd)

  /**Run 3 times with different length of array 'vecd' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  /// new length of array
       flSetLength(adrVECD, fl_ARRAY_REAL_DOUBLE, lenv); /// set new length in Foreval array
       /**
          after  command  flSetLength(adrVECD, fl_ARRAY_REAL_DOUBLE, lenv), placement array Foreval is changed in memory. Need to get new reference to first element.
          or use command  flSetArrayValueD(adrVECD,indx,val);
       **/
        /// To write data in Foreval array (vecd)
       adrVECD0=*PInteger(adrVECD);
       for (ni = 0; ni <=lenv-1; ni++)
	   {
        //flSetArrayValueD(adrVECD,ni,ni+1);
          /// or more fast:
        *PDouble(adrVECD0 + ni * 8) = ni+1;  /// 8-sizeOf(double)
	   }
	    /// without recompiling expressions with vecd
       res = flResultR(DynArray1);   /// res = s; resf.re=ResultR; global var.
       ShowResult(res,resf.re);
       res = flResultR(DynArray2);   /// res = sum(vdt); resf.re=ResultR=sum(vecd); global var.
       ShowResult(res,resf.re);

       ///Copy vecd(Foreval)->vecd(Gcc); vecd filled by 1.0 after DynArray2  ( = len(vecd) )
       vecd.resize(lenv);
       //adrVECD0=*PInteger(adrVECD);
       //CopyMemory(&vecd[0], (Pointer32)(adrVECD0),8*vecd.size());   /// 8 - sizeof(double)
           /// more fast coping:
       flCopyArrayDbl(&vecd[0],(Pointer32)(adrVECD0),lenv);

       sumv=0;
       for (ki = 0; ki <= lenv-1; ki++)
       {
          sumv=vecd[ki]+sumv;
       }
       ShowResult(sumv);

       cout <<  "--------------------------------------------------------------" << endl;


      /**
          Answer out = sum(vecd)   sum(vecd);     <- vecd(Foreval) after call DynArray1
                       sum(vecd)   len(vecd);     <- vecd(Foreval) after call DynArray2
                       len(vecd);                 <- vecd(GCC)
       **/
  }



  //goto endc;

cout <<  "" << endl;


 /***********************************************************************************************************************/


/**                    Example using of array (4)   Standard way. Integer type of array.           **/
 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (4)                                  " << endl;
 cout <<  "         Using of array.    Standard way. Integer type           " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;



  flSetVarIntrnl("veci",fl_ARRAY_REAL_INTEGER,adrVECI); ///  set new array of integer defined from Foreval
  flCompile("k:int=0; len:int=len(veci); s:ext=0; for(k=0,len-1,s=s+veci[k]); ResultR = sum(veci); s",0, DynArray1); // out: ResultR = sum(veci),s=sum(veci)
  flCompile("len: int=len(veci); vdi: arrayInt=len; k:int=0;  for(k=0,len-1,vdi[k]=veci[k]); FillArray(veci,1.0); ResultR=sum(veci); sum(vdi)",0,DynArray2); // out: ResultR = sum(veci),sum(vdi<=veci)

  /**Run 3 times with different length of array 'veci' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  /// new length of array
       flSetLength(adrVECI, fl_ARRAY_REAL_INTEGER, lenv); /// set new length in Foreval array
       /**
          after  command  flSetLength(adrVECI, fl_ARRAY_REAL_INTEGER, lenv), placement array Foreval is changed in memory. Need to get new reference to first element.
          or use command  flSetArrayValueI(adrVECI,indx,val);
       **/
      /// To write data in Foreval array (veci)
       adrVECI0=*PInteger(adrVECI);
       for (ni = 0; ni <=lenv-1; ni++)
	   {
        //flSetArrayValueI(adrVECI,ni,ni+1);
        /// or more fast:
        *PInteger(adrVECI0 + ni * 4) = ni+1;  /// 4-sizeOf(integer)
	   }
	    /// without recompiling expressions with veci
       res = flResultR(DynArray1);  /// res = s; resf.re=ResultR; global var.
       ShowResult(res,resf.re);
       res = flResultR(DynArray2);  /// res = sum(vdi); resf.re=ResultR=sum(veci); global var.
       ShowResult(res,resf.re);

       ///Copy veci(Foreval)->veci(Gcc);  veci filled by 1.0 after DynArray2  ( = len(veci) )
       veci.resize(lenv);
       //adrVECI0=*PInteger(adrVECI);
       //CopyMemory(&veci[0], (Pointer32)(adrVECI0),4*veci.size());   /// 4 - sizeof(integer)
        /// more fast coping:
       flCopyArrayInt(&veci[0],(Pointer32)(adrVECI0),lenv);

       sumv=0;
       for (ki = 0; ki <= lenv-1; ki++)
       {
          sumv=veci[ki]+sumv;
       }
       ShowResult(sumv);

        cout <<  "--------------------------------------------------------------" << endl;


        /**
          Answer out = sum(veci)   sum(veci);     <- veci(Foreval) after call DynArray1
                       sum(veci)   len(veci);     <- veci(Foreval) after call DynArray2
                       len(veci);                 <- veci(GCC)
       **/
  }



  //goto endc;
cout <<  "" << endl;

/***********************************************************************************************************************/




 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (5)                                  " << endl;
 cout <<  "         Using of array.  'Fast connect' of array. Double type   " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;

    /**                    Example using of array (5)   "Fast connect" of array.  Double type of array.
           Test  fast connecting of dynamic array. Double type; (in C++ count from '1', in Foreval count from '0'   !!!)
                                 without using   flSetArrayValueD or CopyMemory
    **/

    /**
        structure array of Delphi
        cells:
           Len  vd[0] vd[1] vd[2] vd[3] ...
        |   4b|  0  |  1  |  2  |  3  | ...
        Length of array is lie in 4 bytes before first element - zero cell: vd[0]
        In FPC instead length, saved High of array = Length-1
     **/

    /** Call function of change length  flSetLength work slow
        There is other way  to adding external dynamic array: more fast (without using  flSetLength and flSetVarIntrnl)
        For this need to use a construct that combines an array in GCC  with a Foreval array with a slight change.
        Array in Foreval is taken from GCC array without creating internal array by flSetVarIntrnl
        Length array in GCC must be on 1 element more and count from '1' !!!;
        Zero element is using for saving of length for Foreval array.
        Array in GCC count from '1', in Foreval count from '0'   !!!
        Array and pointer to it adrARRAY - returned from flSetVarIntrnl must placing in 'unmanaged memory' so as using at compilation !!! !!!

        Arrays in Double and Integer types coincide between other in Foreval and GCC.
        But in Extended type size of cell in Foreval - 10 bytes, in GCC - 12 bytes.
    **/


                                 /** vdf:  "fast connect" for double array **/
                /** Results of calculations in array vdf in compiled expression Foreval automatically will be in vdf array GCC, but count from '1' !!!  **/


  flSetVar("vdf", &adrVDF ,fl_ARRAY_REAL_DOUBLE);    ///  Set array  in GCC  (passed to Foreval)

  flCompile("k:int=0; len:int=len(vdf); s:ext=0; for(k=0,len-1,s=s+vdf[k]); ResultR = sum(vdf); s",0, DynArray1);
  flCompile("len: int=len(vdf); vdt: arrayDbl=len; k:int=0;  for(k=0,len-1,vdt[k]=vdf[k]); FillArray(vdf,1.0); ResultR=sum(vdf); sum(vdt)",0,DynArray2);

  //vdf.push_back(0);/// vdf[0] - reserve for length Foreval array
  //vdf.push_back(0);/// vdf[1] - begin of array vdf[1]
  vdf.resize(2); /// reserve for length  Foreval array.  (vdf[0]) + begin of array vdf[1] (for creating pointer to array: adrVDF)
  adrVDF=&vdf[1];  /// to set a  reference to the array.  adrVDF always: placing in 'unmanaged memory' and pointer only to vdf, so as address of adrVDF using at compilation !!!

  /** to write length: **/
  pint1 = (PInteger)adrVDF;
  pint1=pint1-1;  /// = &vdf[1]-4b; or = &vdf[0]+4b;  sizeof(double) = 8
  if (DLLCompiledBy == Delphi) {SZ = vdf.size()-1;} else {SZ=vdf.size()-2;};  ///  DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
  *pint1 = SZ;  /// pint1 = &vdf[1]-4b;  *pint1 <- length


  /**Run 3 times with different length of array 'vdf' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  /// new length of array

	/***   first way to write array GCC:  ***/
	/*

	     vdf.push_back(0);//reserve for length Foreval array
         for (ni = 1; ni <= lenv; ni++)  //count from 1 in GCC array  !!!
     	 {
           vdf.push_back(ni+1);
	     }
	*/

	/***  second way to write array GCC:  ***/

    	 vdf.resize(lenv+1); /// lenv+1=length(GCC); lenv = length(Foreval); (>0 !!!); 1 - reserve for length Foreval(vdf[0])

         for (ni = 1; ni <= lenv; ni++)  /// count from 1 in GCC array!!!    In '0' cell placement its length.
         {
	       vdf[ni]=(ni-1)+1;
	     }

   /** set reference and length Foreval Array **/

	     adrVDF=&vdf[1];   ///  to set a new reference to the array, so  as  memory location of  vdf is changed  ; after full load of array!!!
	     pint1 = (PInteger)adrVDF;
	     pint1=pint1-1;
	     if (DLLCompiledBy == Delphi) {SZ = vdf.size()-1;} else {SZ=vdf.size()-2;};  /// DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
	     *pint1 = SZ;  ///  pint1 = &vdf[1]-4b;  *pint1 <- length


  ///  without recompiling expressions with vdf

        res = flResultR(DynArray1);
        ShowResult(res,resf.re);
        res = flResultR(DynArray2);
        ShowResult(res,resf.re);
        /// Content of Array (Gcc) was changed and fill by 1.0. Now,sum of vdf equal length;
        sumv=0;
        for (ki = 1; ki <= lenv; ki++)  ///  Gcc array: Count from '1' !!!    In '0' cell placement its length.
        {
            sumv=vdf[ki]+sumv;
        }
        ShowResult(sumv);
        cout <<  "--------------------------------------------------------------" << endl;

        /**
          Answer out = sum(vdf)   sum(vdf);     <- vdf after call DynArray1
                       sum(vdf)   len(vdf);     <- vdf after call DynArray2
                       len(vdf);
       **/

  }
  cout <<  "" << endl;

  // goto endc;
///**************************************************************************************************************************************





/**************************************************************************************************************************************

  "Fast connect" for Extended type of  array  doesn't make sense to use.
  So that  array in Gcc will be damaged at copy to Foreval array, because of cell of elements of arrays  are  12 instead 10 bytes!!!
  PS: Size of cell Extended type in Gcc array - 12 instead - 10 bytes.
  Can use instead standard GCC TArrayE: array<Extended> ,array with type: TArrayE_10 ( array<TByte10> ), with compliance  Delphi 10 bytes Extended cell size,
  //but they are uncomfortable to use for read/write


**************************************************************************************************************************************/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (6)                                              " << endl;
 cout <<  "         Using of array.  'Fast connect' of array. Extended type (TByte10)   " << endl;
 cout <<  "                   See comments in text of program                           " << endl;
 cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;

    /**                    Example using of array (6)   "Fast connect" of array.  Extended type of array (TByte10).               **/


                                 /** ve10f:  "fast connect" for Extended (TByte10) array **/
                /** Results of calculations in array ve10f in compiled expression Foreval automatically will be in ve10f array GCC, but count from '1' !!!  **/


  flSetVar("vef", &adrVEF ,fl_ARRAY_REAL_EXTENDED);    ///  Set array  in GCC  (passed to Foreval). Name 've10f' in Foreval - 'vef'.

  flCompile("k:int=0; len:int=len(vef); s:ext=0; for(k=0,len-1,s=s+vef[k]); ResultR = sum(vef); s",0, DynArray1);
  flCompile("len: int=len(vef); vet: arrayExt=len; k:int=0;  for(k=0,len-1,vet[k]=vef[k]); FillArray(vef,1.0); ResultR=sum(vef); sum(vet)",0,DynArray2);

  //ve10f.push_back(0);/// ve10f[0] - reserve for length Foreval array
  //ve10f.push_back(0);/// ve10f[1] - begin of array ve10f[1]
  ve10f.resize(2); /// reserve for length  Foreval array.  (ve10f[0]) + begin of array ve10f[1] (for creating pointer to array: adrVEF)
  adrVEF=&ve10f[1];  /// to set a  reference to the array.  adrVEF always: placing in 'unmanaged memory' and pointer only to ve10f, so as address of adrVEF using at compilation !!!

  /** to write length: **/
  pint1 = (PInteger)adrVEF;
  pint1=pint1-1;  /// = &ve10f[1]-4b; or = &ve10f[0]+6b;  sizeof(Extended) = 10
  if (DLLCompiledBy == Delphi) {SZ = ve10f.size()-1;} else {SZ=ve10f.size()-2;};  ///  DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
  *pint1 = SZ;  /// pint1 = &ve10f[1]-4b;  *pint1 <- length


  /**Run 3 times with different length of array 've10f' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  //new length of array

	/***   first way to write array GCC:  ***/
	/*

	     ve10f.push_back(0);//reserve for length Foreval array
         for (ni = 1; ni <= lenv; ni++)  //count from 1 in GCC array  !!!
     	 {
           ve10f.push_back(ni+1);
	     }
	*/

	/***  second way to write array GCC:  ***/

    	 ve10f.resize(lenv+1); /// lenv+1=length(GCC); lenv = length(Foreval); (>0 !!!); 1 - reserve for length Foreval(ve10f[0])

         for (ni = 1; ni <= lenv; ni++)  /// count from 1 in GCC array!!!    In '0' cell placement its length.
         {
	       //ve10f[ni]=(ni-1)+1;
	       *PExtended(&ve10f[ni]) =  (ni-1)+1;
	        /// may use instead *PByte10, because performed calculations in FPU, but no coping (mem to mem).
	     }

   /** set reference and length Foreval Array **/

	     adrVEF=&ve10f[1];   ///  to set a new reference to the array, so  as  memory location of  ve10f is changed  ; after full load of array!!!
	     pint1 = (PInteger)adrVEF;
	     pint1=pint1-1;
	     if (DLLCompiledBy == Delphi) {SZ = ve10f.size()-1;} else {SZ=ve10f.size()-2;};  /// DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
	     *pint1 = SZ;  ///  pint1 = &ve10f[1]-4b;  *pint1 <- length


  // without recompiling expressions with ve10f

        res = flResultR(DynArray1);
        ShowResult(res,resf.re);
        res = flResultR(DynArray2);
        ShowResult(res,resf.re);
        /// Content of Array (Gcc) was changed and fill by 1.0. Now,sum of ve10f equal length;
        sumv=0;
        for (ki = 1; ki <= lenv; ki++)  ///  Gcc array: Count from '1' !!!    In '0' cell placement its length.
        {
            //sumv=ve10f[ki]+sumv;
            sumv =  *PExtended(&ve10f[ki]) + sumv;
        }
        ShowResult(sumv);
        cout <<  "--------------------------------------------------------------" << endl;

        /**
          Answer out = sum(ve10f)   sum(ve10f);     <- ve10f after call DynArray1
                       sum(ve10f)   len(ve10f);     <- ve10f after call DynArray2
                       len(ve10f);
       **/

  }
  cout <<  "" << endl;






/**                    Example using of array (7)   "Fast connect" of array.  Integer type of array.               **/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (7)                                  " << endl;
 cout <<  "         Using of array.  'Fast connect' of array. Integer type  " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;





  flSetVar("vif", &adrVIF ,fl_ARRAY_REAL_INTEGER);

  flCompile("k:int=0; len:int=len(vif); s:ext=0; for(k=0,len-1,s=s+vif[k]); ResultR = sum(vif); s",0, DynArray1);
  flCompile("len: int=len(vif); vit: arrayInt=len; k:int=0;  for(k=0,len-1,vit[k]=vif[k]); FillArray(vif,1); ResultR=sum(vif); sum(vit)",0,DynArray2);

  //vdf.push_back(0);/// vdf[0] - reserve for length Foreval array
  //vdf.push_back(0);/// vdf[1] - begin of array vdf[1]
  vif.resize(2); /// reserve for length  Foreval array.  (vif[0]) + begin of array vif[1] (for creating pointer to array: adrVIF)
  adrVIF=&vif[1];  /// to set a  reference to the array.  adrVIF always: placing in 'unmanaged memory' and pointer only to vif, so as address of adrVIF using at compilation !!!

  /** to write length: **/
  pint1 = (PInteger)adrVIF;
  pint1=pint1-1;  /// = &vif[1]-4b; or = &vif[0];  sizeof(integer) = 4
  if (DLLCompiledBy == Delphi) {SZ = vif.size()-1;} else {SZ=vif.size()-2;};  ///  DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
  *pint1 = SZ;  /// pint1 = &vdf[1]-4b;  *pint1 <- length


  /**Run 3 times with different length of array 'vdf' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  //new length of array

	/***   first way to write array GCC:  ***/
	/*

	     vif.push_back(0);//reserve for length Foreval array
         for (ni = 1; ni <= lenv; ni++)  //count from 1 in GCC array  !!!
     	 {
           vif.push_back(ni+1);
	     }
	*/

	/***  second way to write array GCC:  ***/

    	 vif.resize(lenv+1); /// lenv+1=length(GCC); lenv = length(Foreval); (>0 !!!); 1 - reserve for length Foreval(vif[0])

         for (ni = 1; ni <= lenv; ni++)  /// count from 1 in GCC array!!!
         {
	       vif[ni]=(ni-1)+1;
	     }

   /** set reference and length Foreval Array **/

	     adrVIF=&vif[1];   ///  to set a new reference to the array, so  as  memory location of  vif is changed  ; after full load of array!!!
	     pint1 = (PInteger)adrVIF;
	     pint1=pint1-1;
	     if (DLLCompiledBy == Delphi) {SZ = vif.size()-1;} else {SZ=vif.size()-2;};  /// DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
	     *pint1 = SZ;  ///  pint1 = &vif[1]-4b;  *pint1 <- length


  ///  without recompiling expressions with vif

        res = flResultR(DynArray1);
        ShowResult(res,resf.re);
        res = flResultR(DynArray2);
        ShowResult(res,resf.re);
        /// Content of Array (Gcc) was changed and fill by 1. Now,sum of vif equal length;
        sumv=0;
        for (ki = 1; ki <= lenv; ki++)   ///  Gcc array: Count from '1' !!!    In '0' cell placement its length.
        {
            sumv=vif[ki]+sumv;
        }
        ShowResult(sumv);
        cout <<  "--------------------------------------------------------------" << endl;

       /**
          Answer = sum(vif)   sum(vif)
                   sum(vif)   len(vif)
                   len(vif)
       **/

  }

cout <<  "" << endl;
   //goto endc;



/***********************************************************************************************************************/

/**     Example using of array (8)   Through Pointers PExtended(Addr), without using external  Foreval array. Extended type of GCC array.           **/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (8)                                  " << endl;
 cout <<  " Using of array.  Through Pointers PExtended(Addr), without using external Foreval array. Extended type of GCC array. " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "-----------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;



  /// Used only Gcc array vece;

  /// In Foreval expression passed global vars:
      ///  PtrV  - pointer to vece    (need at calling gcc summation from within  - gccSumVe )
      ///  PtrV0 - pointer to vece[0]
      ///  lenv  - size of vece
      ///  sizecell - size of cell of array vece (sizecell set as  parameter for best optimization )

 /// At each resize of vece, need to be updated PtrV,PtrV0,lenv (without recompiling expression)

  flSetParamI("sizecell",12); /// set size of cell of array vece = 12 in Gcc (in Delphi - 10)

  flCompile("k:int=0;  s:ext=0; for(k=0,lenv-1,s=s+PExtended(PtrV0+sizecell*k)); ResultR = gccSumVe(PtrV); s",0, DynArray1); // out: ResultR =  sum(vece); s =  sum(vece);
  flCompile("vdt: arrayExt=lenv; k:int=0;  for(k=0,lenv-1,vdt[k]=PExtended(PtrV0+sizecell*k));  for(k=0,lenv-1,PExtended(PtrV0+sizecell*k)=1.0); ResultR=gccSumVe(PtrV); sum(vdt)",0,DynArray2);// out: ResultR = sum(vece),sum(vdt<=vece)

  /**Run 3 times with different length of array 'vece' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;                  /// new length of array ; global var, used in compiling exprssions
       vece.resize(lenv);
       PtrV = (Pointer32)(&vece);     /// set pointer to vece after resize
       PtrV0 = (Pointer32)(&vece[0]); /// set pointer to vece[0] after resize


       for (ni = 0; ni <=lenv-1; ni++)
	   {
         vece[ni]=ni+1;
	   }

	    /// without recompiling expressions with vece
       res = flResultR(DynArray1);   /// res = s; resf.re=ResultR; global var.
       ShowResult(res,resf.re);
       res = flResultR(DynArray2);   /// res = sum(vdt); resf.re=ResultR=sum(vece); global var.
       ShowResult(res,resf.re);

       sumv=0;
       for (ki = 0; ki <= lenv-1; ki++)
       {
          sumv=vece[ki]+sumv;
       }
       ShowResult(sumv);

       cout <<  "--------------------------------------------------------------" << endl;


      /**
          Answer out = sum(vece)   sum(vece);     <- vece(Foreval) after call DynArray1
                       sum(vece)   len(vece);     <- vece(Foreval) after call DynArray2
                       len(vece);                 <- vece(GCC)
       **/
  }



  //goto endc;

cout <<  "" << endl;




/***********************************************************************************************************************/

/**    Example using of array (9)   Through Pointers PDouble(Addr), without using external  Foreval array. Double type of GCC array.           **/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (9)                                  " << endl;
 cout <<  " Using of array.   Through Pointers PDouble(Addr), without using external Foreval array. Double type of GCC array.     " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "-----------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;



  /// Used only Gcc array vecd;

  /// In Foreval expression passed global vars:
      ///  PtrV  - pointer to vecd    (need at calling gcc summation from within  - gccSumVd )
      ///  PtrV0 - pointer to vecd[0]
      ///  lenv  - size of vecd
      ///  sizecell - size of cell of array vecd (sizecell set as  parameter for best optimization )

 /// At each resize of vecd, need to be updated PtrV,PtrV0,lenv (without recompiling expression)

  flSetParamI("sizecell",8); /// set size of cell of array vecd; 8 = double

  flCompile("k:int=0;  s:ext=0; for(k=0,lenv-1,s=s+PDouble(PtrV0+sizecell*k)); ResultR = gccSumVd(PtrV); s",0, DynArray1); // out: ResultR =  sum(vecd); s =  sum(vecd);
  flCompile("vdt: arrayDbl=lenv; k:int=0;  for(k=0,lenv-1,vdt[k]=PDouble(PtrV0+sizecell*k));  for(k=0,lenv-1,PDouble(PtrV0+sizecell*k)=1.0); ResultR=gccSumVd(PtrV); sum(vdt)",0,DynArray2);// out: ResultR = sum(vecd),sum(vdt<=vecd)

  /**Run 3 times with different length of array 'vecd' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  /// new length of array ; global var, used in compiling exprssions
       vecd.resize(lenv);
       PtrV = (Pointer32)(&vecd);     /// set pointer to vecd after resize
       PtrV0 = (Pointer32)(&vecd[0]); /// set pointer to vecd[0] after resize


       for (ni = 0; ni <=lenv-1; ni++)
	   {
         vecd[ni]=ni+1;
	   }

	    /// without recompiling expressions with vecd
       res = flResultR(DynArray1);   /// res = s; resf.re=ResultR; global var.
       ShowResult(res,resf.re);
       res = flResultR(DynArray2);   /// res = sum(vdt); resf.re=ResultR=sum(vecd); global var.
       ShowResult(res,resf.re);

       sumv=0;
       for (ki = 0; ki <= lenv-1; ki++)
       {
          sumv=vecd[ki]+sumv;
       }
       ShowResult(sumv);

       cout <<  "--------------------------------------------------------------" << endl;


      /**
          Answer out = sum(vecd)   sum(vecd);     <- vecd(Foreval) after call DynArray1
                       sum(vecd)   len(vecd);     <- vecd(Foreval) after call DynArray2
                       len(vecd);                 <- vecd(GCC)
       **/
  }



  //goto endc;

cout <<  "" << endl;





/***********************************************************************************************************************/

/** Example using of array (10)   Through Pointers PInteger(Addr), without using external  Foreval array. Integer type of GCC array.    **/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (10)                                  " << endl;
 cout <<  " Using of array.   Through Pointers PInteger(Addr), without using external Foreval array. Integer type of GCC array.   " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "-----------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;



  /// Used only Gcc array veci;

  /// In Foreval expression passed global vars:
      ///  PtrV  - pointer to veci    (need at calling gcc summation from within  - gccSumVi )
      ///  PtrV0 - pointer to veci[0]
      ///  lenv  - size of veci
      ///  sizecell - size of cell of array veci (sizecell set as  parameter for best optimization )

 /// At each resize of veci, need to be updated PtrV,PtrV0,lenv (without recompiling expression)

  flSetParamI("sizecell",4); /// set size of cell of array veci; 4 = integer

  flCompile("k:int=0;  s:ext=0; for(k=0,lenv-1,s=s+PInteger(PtrV0+sizecell*k)); ResultR = gccSumVi(PtrV); s",0, DynArray1); // out: ResultR =  sum(veci); s =  sum(veci);
  flCompile("vdt: arrayInt=lenv; k:int=0;  for(k=0,lenv-1,vdt[k]=PInteger(PtrV0+sizecell*k));  for(k=0,lenv-1,PInteger(PtrV0+sizecell*k)=1.0); ResultR=gccSumVi(PtrV); sum(vdt)",0,DynArray2);// out: ResultR = sum(veci),sum(vdt<=veci)

  /**Run 3 times with different length of array 'veci' **/
  for (li = 1; li <= 3; li++)
  {
       lenv = 50*li;  /// new length of array ; global var, used in compiling expressions
       veci.resize(lenv);
       PtrV = (Pointer32)(&veci);     /// set pointer to veci after resize
       PtrV0 = (Pointer32)(&veci[0]); /// set pointer to veci[0] after resize


       for (ni = 0; ni <=lenv-1; ni++)
	   {
         veci[ni]=ni+1;
	   }

	    /// without recompiling expressions with veci
       res = flResultR(DynArray1);   /// res = s; resf.re=ResultR; global var.
       ShowResult(res,resf.re);
       res = flResultR(DynArray2);   /// res = sum(vdt); resf.re=ResultR=sum(veci); global var.
       ShowResult(res,resf.re);

       sumv=0;
       for (ki = 0; ki <= lenv-1; ki++)
       {
          sumv=veci[ki]+sumv;
       }
       ShowResult(sumv);

       cout <<  "--------------------------------------------------------------" << endl;


      /**
          Answer out = sum(veid)   sum(veci);     <- veci(Foreval) after call DynArray1
                       sum(veci)   len(veci);     <- veci(Foreval) after call DynArray2
                       len(veci);                 <- veci(GCC)
       **/
  }



  //goto endc;

cout <<  "" << endl;





/****************************************************************************************************************************
                                                Examples (11)
                  Test  fast connecting of dynamic array. Double type; (in C++ count from '1', in Foreval count from '0'   !!!)
                                 without using   flSetArrayValueD or CopyMemory
****************************************************************************************************************************/



 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (11)                                  " << endl;
 cout <<  "         Using of array.  'Fast connect' of array. Double type  " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;


   flCompile("k:int=0; len:int=len(vdf); s:dbl=0; for(k,0,len-1,s=s+vdf[k]); ResultR=s; s/sum(vdf)", 0,FDynArray); /// Returned Result must be always = 1.

    srand(time(0));
   for (li = 1; li <= 10; li++)  /// 10 times runs test
   {

         ///  set randomize size of array (VDF) and fill it 1.0
	     NC = rand()+2;
         vdf.clear();


	    //******************first way to write array:
	    /*
	        vdf.push_back(0);//reserve for length
            for (ni = 1; ni <= NC; ni++)  //count from 1 !!!
     	    {
            vdf.push_back(1.0);
	        }
	    */

	    //*******************second way to write array:
    	   vdf.resize(NC+1); ///  NC+1=length(VC++); NC = length(foreval); (>0 !!!); 1 - reserve for length (vdf[0])
          //vdf.reserve(NC+1);

          for (ni = 1; ni <= NC; ni++)  /// count from 1 !!!   In '0' cell placement its length.
          {
	         vdf[ni]=1.0;
	      }

         /// set length
	     adrVDF=&vdf[1];/// to set a new reference to the array so , as  memory location of  vdf is changed  ; after full load of array!!!
	     pint1 = (PInteger)adrVDF;
	     pint1=pint1-1;
	     if (DLLCompiledBy == Delphi) {SZ = vdf.size()-1;} else {SZ=vdf.size()-2;};  /// DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
	     *pint1 = SZ;  /// pint1 = &vdf[1]-4b;  *pint1 <- length

	     //len(vdf)*(sumq(vdf)/sqr(norm(vdf)))


         res = flResultR(FDynArray); /// without recompiling expression

         printf("length =  %i", NC);  printf(";     ");   printf("sum =    %.1f", (double)resf.re); printf(";     ");  printf("s/sum =  %.1f\n", (double)res);


   };

     //system("pause");
     //goto dynarray;


cout <<  "" << endl;

//************************************************************************************************************************************************




/****************************************************************************************************************************
                                                Examples (12)
                  Test  fast connecting of dynamic array. Extended type (TByte10) (in C++ count from '1', in Foreval count from '0'  !!!)

****************************************************************************************************************************/



 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (12)                                  " << endl;
 cout <<  "         Using of array.  'Fast connect' of array. Extended type (TByte10)  " << endl;
 cout <<  "                   See comments in text of program               " << endl;
 cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;


   flCompile("k:int=0; len:int=len(vef); s:dbl=0; for(k=0,len-1,s=s+vef[k]); ResultR=s; s/sum(vef)", 0,FDynArray); //Returned Result must be always = 1.

    srand(time(0));
   for (li = 1; li <= 10; li++)  /// 10 times runs test
   {

         ///  set randomize size of array (VDF) and fill it 1.0
	     NC = rand()+2;
         ve10f.clear();

       /*
	    //******************first way to write array:

	        ve10f.push_back(0);//reserve for length
            for (ni = 1; ni <= NC; ni++)  //count from 1 !!!
     	    {
            ve10f.push_back(1.0);
	        }
         */

	    //*******************second way to write array:
    	   ve10f.resize(NC+1); ///  NC+1=length(VC++); NC = length(foreval); (>0 !!!); 1 - reserve for length (ve10f[0])
          //ve10f.reserve(NC+1);

          for (ni = 1; ni <= NC; ni++)  /// count from 1 !!!   In '0' cell placement its length.
          {
	        // ve10f[ni]=1.0;
	        //*PExtended(&ve10f[ni]) = 1.0;
	        xt1 = 1.0;
	        *PByte10(&ve10f[ni]) = *PByte10(&xt1);
	      }

         /// set length
	     adrVEF=&ve10f[1];   /// to set a new reference to the array so , as  memory location of  ve10f is changed  ; after full load of array!!!
	     pint1 = (PInteger)adrVEF;
	     pint1=pint1-1;
	     if (DLLCompiledBy == Delphi) {SZ = ve10f.size()-1;} else {SZ=ve10f.size()-2;};  /// DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
	     *pint1 = SZ;  //pint1 = &ve10f[1]-4b;  *pint1 <- length

	     //len(ve10f)*(sumq(ve10f)/sqr(norm(ve10f)))


         res = flResultR(FDynArray); /// without recompiling expression

         printf("length =  %i", NC);  printf(";     ");   printf("sum =    %.1f", (double)resf.re); printf(";     ");  printf("s/sum =  %.1f\n", (double)res);


   };

     //system("pause");
     //goto dynarray;


cout <<  "" << endl;

//************************************************************************************************************************************************




/***********************************************************************************************************************/

/** Example using of array (13)  ; Emulation of calculations with matrices, are placed  in arrays. M[i,j] -> A[i*LenStr+j]     **/
/** Calculation of the determinant of the product of 2 matrices. Mu1=Mu1x*Mu1y; det(Mu1)  **/
 cout <<  "" << endl;
 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (13)                                                                              " << endl;
 cout <<  "                  Using of array.                                                                             " << endl;
 cout <<  "   Emulation of calculations with matrices, are placed  in arrays. M[i,j] -> A[i*LenStr+j]                    " << endl;
 cout <<  "   Calculation of the determinant of the product of 2 matrices. M1u=M1ux*M1uy; det(M1u)                       " << endl;
 cout <<  "   Calculation the same, using Gcc arrays with addressed by pointers via PExtended/PDouble                    " << endl;
 cout <<  "-----------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;
 cout <<  "" << endl;


 cout <<  "" << endl;



    //flCompile(ExprA6VDU.c_str(),0,FuncA6VDU);
    //RandSizeMatrixAndFillRandElemS4();

     SetMatrixDetMulExpr();  /// see for text programm
     printf(ExprA6VDU.c_str());

     CompileMatrixDetMulExpr(MxMulDet);
     CompileMatrixDetMulExpr(MxMulDetP);


     LenSCM1u = 10;     ///  size square matrices.  LenSCM1u x LenSCM1u
     SizeRandElem = 2;  ///  generation an filling random elements in [0, SizeRandElem]

     RandSizeMatrixAndFillRandElem();
     //Ptr0M1u=&M1u[0]; Ptr0M1ux=&M1ux[0]; Ptr0M1uy=&M1uy[0];

    cout <<  "" << endl;
   // cout <<  "" << endl;
   // cout <<  "M1u=M1ux*M1uy; det(M1u)" << endl;
   // cout <<  "" << endl;
    //cout <<  "" << endl;
    cout <<  "" << endl;
    res = DetMulMxM1();
    ShowResult("GCC result                                             :" ,res);
    res=flResultR(MxMulDet);
    ShowResult("Foreval result                                         :" ,res);
    res=flResultR(MxMulDetP);
    ShowResult("Foreval result (uses Gcc arrays, addressed by pointers):" ,res);




    //res = flResultR(DynArray1);   //res = s; resf.re=ResultR; global var.
     //  ShowResult(res,resf.re);


 cout <<  "" << endl;
  cout <<  "" << endl;



/****************************************************************************************************************************************

                                            Examples (14)   Triple integral

 int3(F(x,y,z)=x*y+2*y*z-z*x, x = -1..2; y = -2*x...x^2+1; z = x-y...x+y
 in wolframalpha representation: Integrate[x*y+2*y*z-z*x, {x,-1,2}, {y,-2*x,x^2+1}, {z, x-y, x+y}]

*******************************************************************************************************************************************/


 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (14)                                  " << endl;
 cout <<  "         Triple integral.   int3(F(x,y,z)=x*y+2*y*z-z*x, x = -1..2; y = -2*x...x^2+1; z = x-y...x+y " << endl;
 cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;



  //InitIntegral();

  flPerform(fl_SAVE, fl_VAR_LIST);      /// save global variables list

  /*****************  Triple integral with external var. **********************************************************/

  flSetVar("x", &FInt3.x, RType); /// RType = fl_REAL_EXTENDED, fl_REAL_Double
  flSetVar("y", &FInt3.y, RType) ;
  flSetVar("z", &FInt3.z, RType)  ;
  flCompile("x*y+2*y*z-z*x", 0, FInt3.FAddr);
  flCompile("-2*x", 0, FInt3.F1Addr) ;
  flCompile("x^2+1", 0, FInt3.F2Addr) ;
  flCompile("x-y", 0, FInt3.F3Addr);
  flCompile("x+y", 0, FInt3.F4Addr) ;
  FInt3.a = -1;
  FInt3.b = 2 ;

  flPerform(fl_RESTORE, fl_VAR_LIST) ;   /// restore global variables list
      //P_Integral = 30;
      //T1=GetTickCount();
  res = Integral3FF(FInt3.FAddr, &FInt3.x, &FInt3.y, &FInt3.z, FInt3.a, FInt3.b, FInt3.F1Addr, FInt3.F2Addr, FInt3.F3Addr, FInt3.F4Addr);
      // T2=GetTickCount();
  //printf("Triple integral: %.15f\n", resd);
  //cout <<  "External Var." << endl;
  ShowResult("External Var.:  ",res);
      // printf("Time Foreval Integral ms:  %5d\n", T2-T1);

/*****************  Triple integral with internal var. **********************************************************/

  flPerform(fl_SAVE, fl_VAR_LIST);

  flSetVarIntrnl("x", RType, FInt3Ext.adrX);   /// RType = fl_REAL_EXTENDED, fl_REAL_Double
  flSetVarIntrnl("y", RType, FInt3Ext.adrY);
  flSetVarIntrnl("z", RType, FInt3Ext.adrZ);

  flCompile("x*y+2*y*z-z*x", 0, FInt3Ext.FAddr);
  flCompile("-2*x", 0, FInt3Ext.F1Addr) ;
  flCompile("x^2+1", 0, FInt3Ext.F2Addr) ;
  flCompile("x-y", 0, FInt3Ext.F3Addr);
  flCompile("x+y", 0, FInt3Ext.F4Addr) ;
  FInt3Ext.a = -1;
  FInt3Ext.b = 2 ;

  flPerform(fl_RESTORE, fl_VAR_LIST) ;
     //P_Integral = 30;
     // T1=GetTickCount();
  res = Integral3FF(FInt3Ext.FAddr, FInt3Ext.adrX, FInt3Ext.adrY, FInt3Ext.adrZ, FInt3Ext.a, FInt3Ext.b, FInt3Ext.F1Addr, FInt3Ext.F2Addr, FInt3Ext.F3Addr, FInt3Ext.F4Addr);
     // T2=GetTickCount();
  //printf("Triple integral with internal var.: %.15f\n", resd);
  //cout <<  "Internal Var." << endl;
  ShowResult("Internal Var.:  " ,res);
     // printf("Time Foreval Integral ms:  %5d\n", T2-T1);


///*************************** Triple integral: GCC functions ************************************************


  pf1 = Pointer32(&GccIntMain); pf2 = Pointer32(&GccIntFY1); pf3 = Pointer32(&GccIntFY2);
  pf4 = Pointer32(&GccIntFZ1);  pf5 = Pointer32(&GccIntFZ2);
     //P_Integral = 30;
     //T1=GetTickCount();
  res = Integral3FF(pf1, &x, &y, &z, FInt3.a, FInt3.b, pf2, pf3, pf4, pf5);
     //T2=GetTickCount();
  //printf("Triple integral Gcc: %.15f\n", resd);
     //printf("Time GCC Integral ms:  %5d\n", T2-T1);

  //cout <<  "Gcc eval." << endl;
  ShowResult("Gcc res.:       ",res);

  //goto endc;



cout <<  "" << endl;

/****************************************************************************************************************************************

                                            Examples (15)   Splain functions

                fs1(x)  =  (sin(3*x)-cos(2*x))*exp(-x/10);
                fs2(x) =   x*(sin(x)+cos(x));
                spl1(x) = splain of fs1(x)     -15<=x<=15
                spl2(x) = splain of fs2(x)     -10<=x<=10

*******************************************************************************************************************************************/

 cout <<  "***********************************************************************************************************************" << endl;
 cout <<  "                   Examples (15)    Test splain functions                               " << endl;
 cout <<  "" << endl;
 cout <<  "         fs1(x)  =  (sin(3*x)-cos(2*x))*exp(-x/10);   " << endl;
 cout <<  "         fs2(x)  =   x*(sin(x)+cos(x));               " << endl;
 cout <<  "         spl1(x) =  splain of fs1(x)     -15<=x<=15    step h = 0.1   Data of extended type  " << endl;
 cout <<  "         spl2(x) =  splain of fs2(x)     -10<=x<=10    step h = 0.1   Data of double type    " << endl;
 cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
 cout <<  "" << endl;


  flCompile("(sin(3*x)-cos(2*x))*exp(-x/10)", 0, FS1);
  flCompile("spl1(x)", 0, FS2);
  flCompile("x*(sin(x)+cos(x))", 0, FS3);
  flCompile("spl2(x)", 0, FS4);

  resd = Integral1(FS1, &x,  -15.0, 15.0);
  printf("Integral(fs1,-15,15)      : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);
  resd = Integral1(FS2, &x,   -15.0, 15.0);
  printf("Integral(spl1(x),-15,15)  : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);
  resd = Integral1(FS3, &x,  -10.0, 10.0);
  printf("Integral(fs2,-10,10)      : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);
  resd = Integral1(FS4, &x,   -10.0, 10.0);
  printf("Integral(spl2(x),-10,10)  : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);




  cout <<  "" << endl;
  flCompileDeriv("(sin(3*x)-cos(2*x))*exp(-x/10)","x",1,FS1);
  flCompileDeriv("spl1(x)","x",1,FS2);
  flCompileDeriv("x*(sin(x)+cos(x))","x",1,FS3);
  flCompileDeriv("spl2(x)","x",1,FS4);



  resd = Integral1(FS1, &x,  -15.0, 15.0);
  printf("Integral(d(fs1)/dx,-15,15)      : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);
  resd = Integral1(FS2, &x,   -15.0, 15.0);
  printf("Integral(d(spl1(x))/dx,-15,15)  : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);
  resd = Integral1(FS3, &x,  -10.0, 10.0);
  printf("Integral(d(fs2)/dx,-10,10)      : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);
  resd = Integral1(FS4, &x,   -10.0, 10.0);
  printf("Integral(d(spl2(x))/dx,-10,10)  : %.15f\n", resd);
  //ShowResult("Integral(fs1,-15,15):  " ,res);
  cout <<  "" << endl;


cout <<  "  " << endl;



/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (16)
              integral(d^3 f(x)/dx^3,a,b) = d^2 f(x)/dx^2 (a) - d^2 f(x)/dx^2 (b)
              f(x) = (sin(3*x)-cos(2*x))*exp(-x/10)    ; a=1.0; b=5.0;
***************************************************************************************************/
cout <<  "***********************************************************************************************************************" << endl;
cout <<  "                   Examples (16)    Test derivatives on one var                               " << endl;
cout <<  "" << endl;

cout <<  "        integral(d^3 f(x)/dx^3,a,b) = d^2 f(x)/dx^2 (b) - d^2 f(x)/dx^2 (a)     " << endl;
cout <<  ""                                                                               << endl;
cout <<  "        f(x) = (sin(3*x)-cos(2*x))*exp(-x/10)    ; a=1.0; b=5.0;                " << endl;
 cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
cout <<  "  " << endl;

  a = 1.0; b = 5.0;
  FExpr = "(sin(3*x)-cos(2*x))*exp(-x/10)";
  flCompileDeriv(FExpr,"x",3,FS1);
  flCompileDeriv(FExpr,"x",2,FS2);
  resd = Integral1(FS1, &x,   a, b);
  printf("Integral(d^3(f(x))/dx^3,a,b)           :    %.15f\n", resd);
  x = b;
  resd=flResultR(FS2);
  x = a;
  resd=resd-flResultR(FS2);
  printf("(dx^2 f(x)/dx^2 (a)- dx^2 f(x)/dx^2 (b):    %.15f\n", resd);

 // goto endc;


cout <<  "  " << endl;


/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (17)  Test derivatives on multi var

                            d^3/dxdy^2 f(x,y) = sin(x*y)
***************************************************************************************************/
cout <<  "***********************************************************************************************************************" << endl;
cout <<  "                   Examples (17)    Test derivatives on multi var                               " << endl;
cout <<  "                      d^3/dxdy^2 f(x,y) = sin(x*y)                                             " << endl;
 cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
cout <<  "" << endl;

  /// DEDUG+
   /*
  DFFunc =  "t=x; sin(t)";

  flSet(fl_DIFF_NUMERIC_PRECISION,14,2);

  flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);

  flSetDiffExpr(DFFunc.c_str());

     //flPerform(fl_CLEAR,fl_ERROR_CODE );

  flSet(fl_TYPE_OF_DIFFERENTIATION, fl_NUMERIC,0);

  flSetDiffExpr(DFFunc.c_str());

   flSetDiffVar("x");
   flDiffExpr(1);
   flCompileDiffExpr(FS6);

   flGetErrorCode(Err);
   if (Err == 0)
    {

	        flGetDiffString(PtrS);
            PtrToStr(PtrS,StrDiff);
            cout << "diff expr" << StrDiff << endl;
            cout <<  "" << endl;

              flPerform(fl_FREE,(INT32)FS6);
              Attr.MType = MType; Attr.AddrRE = &resf.re; Attr.AddrIM = &resf.im;


              flCompileDiffExprATE( &Attr,FS6,rt,Err);
              Err=flResultSafe(FS6);
              if (Err == 0) {ShowResult("Result = %.12e", fl_REAL, resf);};

     };

     */
   /*
     //DFFunc =  "123*x";
     //DFFunc =  "123*x";
     DFFunc =  "sumqs(vd,x)*x";

     flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);
     //flSet(fl_TYPE_OF_DIFFERENTIATION, fl_NUMERIC,0);
     flSet(fl_DIFF_NUMERIC_PRECISION,3,4);
     flSetDiffExpr(DFFunc.c_str());
     flSetDiffVar("x");
     flDiffExpr(1);


     flGetDiffString(PtrS);
     PtrToStr(PtrS,StrDiff);
     cout << "diff expr" << StrDiff << endl;
     cout <<  "" << endl;

     Attr.MType = MType; Attr.AddrRE = &resf.re; Attr.AddrIM = &resf.im;

     flCompileDiffExprATE( &Attr,FS6,rt,Err);
     //flCompileATE(StrDiff.c_str(), &Attr,FS6,rt,Err);
     flResult(FS6);
     ShowResult("Result = %.12e", fl_REAL, resf);
     //Err = flResultSafe(FS6);
    // if (Err == 0) { resd = resf.re;    printf("  %.12f\n", resd); };
    //  if (Err == 0) {ShowResult("Result = %.12e", fl_REAL, resf);};


     //ShowResult("Result = %.12e", fl_REAL, resf);
     //if (Err == 0) {ShowResult("Result = %.12e", fl_REAL, resf);};
     //printf(" %d", Err);


   */

  /// DEDUG-




  // DFFunc =  "sin(x*y)";

/*
  DFNumFunc = "diffFunc(x:ext; y:ext)="+DFFunc;
  flSetFunction(DFNumFunc.c_str(),0,&idFP);
  DFNumExpr = "diffFunc(x,y)";
*/




  DFFunc =  "sin(x*y)";

  flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);
  flSetDiffExpr(DFFunc.c_str());
  flSetDiffVar("x");
  flDiffExpr(1);
  flSetDiffVar("y");
  flDiffExpr(2);
  flCompileDiffExpr(FS1);

  flGetDiffString(PtrS);
  PtrToStr(PtrS,StrDiff);
  cout << "symbolic diff. expression d^3/dxdy^2 sin(x*y):   " << StrDiff << endl;
  cout <<  "" << endl;



  flSet(fl_DIFF_NUMERIC_PRECISION,3,4); /// diff polynom of 3 degree ; h=10^(-4)
  //flSetDiffExpr(DFNumExpr);

  flSet(fl_TYPE_OF_DIFFERENTIATION, fl_NUMERIC,0);
   //flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);



  flSetDiffExpr(DFFunc.c_str());

  flSetDiffVar("x");
  flDiffExpr(1);
  flSetDiffVar("y");
  flDiffExpr(2);
  flCompileDiffExpr(FS2);

  resd=flResultR(FS1);
  printf("d^3/dxdy^2 sin(x*y) | symbolic diff:    %.15f\n", resd);
  resd=flResultR(FS2);
  printf("d^3/dxdy^2 sin(x*y) | numeric diff :    %.15f\n", resd);






cout <<  "" << endl;

    //goto endc;

/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (18)  Test derivatives on multi var

                            d^3/dxdydt f(x,y,t) = sin(x*y)*cos(y*t)*sin(x*t)
***************************************************************************************************/
cout <<  "***********************************************************************************************************************" << endl;
cout <<  "                   Examples (18)    Test derivatives on multi var                               " << endl;
cout <<  "                  d^3/dxdydt f(x,y,t) = sin(x*y)*cos(y*t)*sin(x*t)                             " << endl;
 cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
cout <<  "" << endl;

  DFFunc =  "sin(x*y)*cos(y*t)*sin(x*t)";

/*
  DFNumFunc = "diffFunc(x:ext; y:ext; t:ext)="+DFFunc;
  flSetFunction(DFNumFunc.c_str(),0,&idFP);
  DFNumExpr = "diffFunc(x,y,t)";
*/
  flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);
  flSetDiffExpr(DFFunc.c_str());
  flSetDiffVar("x");
  flDiffExpr(1);
  flSetDiffVar("y");
  flDiffExpr(1);
  flSetDiffVar("t");
  flDiffExpr(1);
  flCompileDiffExpr(FS1);

  flGetDiffString(PtrS);
  PtrToStr(PtrS,StrDiff);
  cout << "symbolic diff. expression d^3/dxdydt sin(x*y)*cos(y*t)*sin(x*t):   "  << endl;
  cout << StrDiff << endl;
  cout <<  "" << endl;



  flSet(fl_DIFF_NUMERIC_PRECISION,3,4); /// diff polynom of 3 degree ; h=10^(-4)
  //flSetDiffExpr(DFNumExpr);
  flSet(fl_TYPE_OF_DIFFERENTIATION, fl_NUMERIC,0);
  flSetDiffExpr(DFFunc.c_str());
  flSetDiffVar("x");
  flDiffExpr(1);
  flSetDiffVar("y");
  flDiffExpr(1);
  flSetDiffVar("t");
  flDiffExpr(1);
  flCompileDiffExpr(FS2);

  resd=flResultR(FS1);
  printf("d^3/dxdydt sin(x*y)*cos(y*t)*sin(x*t) | symbolic diff:    %.15f\n", resd);
  resd=flResultR(FS2);
  printf("d^3/dxdydt sin(x*y)*cos(y*t)*sin(x*t) | numeric diff :    %.15f\n", resd);



  //goto endc;

cout <<  "" << endl;



/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (19)  Second order differential of a function of two variables
                            F(x,y) = cos(x)*sin(y);  d^2[F(x,y)]  = (d/dx+d/dy)^2[F(x,y)]
                            F(x,y) = sin(x)*cos(y)
***************************************************************************************************/
cout <<  "***********************************************************************************************************************" << endl;
cout <<  "                   Examples (19)    Second order differential of a function of two variables                              " << endl;
cout <<  "                   F(x,y) = sin(x)*cos(y) ;  d^2[F(x,y)] = ?                                                               " << endl;
 cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
cout <<  "" << endl;

  DFFunc =  "sin(x)*cos(y)";

  flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);

  flSetDiffExpr(DFFunc.c_str());
  flSetDiffVar("x");
  flDiffExpr(2);                       // d2/dx2 F(x,y)
  flGetDiffString(PtrS);
  PtrToStr(PtrS,SDX2);                // SDX2 =  d2/dx2 F(x,y)

  flSetDiffExpr(DFFunc.c_str());
  flSetDiffVar("y");
  flDiffExpr(2);                       // d2/dy2 F(x,y)
  flGetDiffString(PtrS);
  PtrToStr(PtrS,SDY2);                    // SDY2 =  d2/dy2 F(x,y)


  flSetDiffExpr(DFFunc.c_str());
  flDiffExpr(1);                        // d/dy F(x,y)
  flSetDiffVar("x");
  flDiffExpr(1);                        // d2/dydx F(x,y)
  flGetDiffString(PtrS);
  PtrToStr(PtrS,SDXY) ;                 // SDXY =  d2/dydx F(x,y)

  SD2 = SDX2 + "+"+SDY2 +"+2*("+ SDXY + ")";

  cout << "symbolic differential  second order   d^2 [sin(x)*cos(y)] = "  << endl;
  cout << SD2 << endl;
  cout <<  "" << endl;

  flCompile(SD2.c_str(), 0, FS2);        //  d2 [F(x,y)]
  resd=flResultR(FS2);
  printf("d^2 [sin(x)*cos(y)]=    %.15f\n", resd);



  //goto endc;

cout <<  "" << endl;



/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (20)  Test derivatives of polynom

                            3 ways write of polynom:

                                           2*x^9-4*x^8+7*x^7-5*x^6-6*x^5-9*x^4-8*x^3-2*x^2-5*x+10
                                           poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,x)
                                           poly(cp,x)     cp- arrays with coeff.


***************************************************************************************************/
cout <<  "***********************************************************************************************************************" << endl;
cout <<  "                   Examples (20)    Test derivatives of polynomial                             " << endl;
cout <<  "                   The same polynomials with different type of writing" << endl;
cout <<  "               2*x^9-4*x^8+7*x^7-5*x^6-6*x^5-9*x^4-8*x^3-2*x^2-5*x+10                          " << endl;
cout <<  "                           poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,x)                                 " << endl;
cout <<  "                           poly(cp,x);     cp - arrays with coeff.                              " << endl;
 cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;

cout <<  "" << endl;

   lenv = 10;
   flSetVarIntrnl("cp",fl_ARRAY_REAL_EXTENDED,adrCP);
   flSetLength(adrCP,fl_ARRAY_REAL_EXTENDED,lenv)  ;
   flSetArrayValueE(adrCP,9,2.0);   flSetArrayValueE(adrCP,8,-4.0);  flSetArrayValueE(adrCP,7,7.0);   flSetArrayValueE(adrCP,6,-5.0);  flSetArrayValueE(adrCP,5,-6.0);
   flSetArrayValueE(adrCP,4,-9.0);  flSetArrayValueE(adrCP,3,-8.0);  flSetArrayValueE(adrCP,2,-2.0);  flSetArrayValueE(adrCP,1,-5.0);  flSetArrayValueE(adrCP,0,10.0);

   Expr1 = "2*x^9-4*x^8+7*x^7-5*x^6-6*x^5-9*x^4-8*x^3-2*x^2-5*x+10";
   Expr2 = "poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,x)";
   Expr3 = "poly(cp,x)";
   flCompile(Expr1,0,FS1);
   flCompile(Expr2,0,FS2);
   flCompile(Expr3,0,FS3);
   flCompileDeriv(Expr1,"x",3,FDS1);
   flCompileDeriv(Expr2,"x",3,FDS2);
   flCompileDeriv(Expr3,"x",3,FDS3);

   x = 2.123;
   resd=flResultR(FS1);
   printf("2*x^9-4*x^8+7*x^7-5*x^6-6*x^5-9*x^4-8*x^3-2*x^2-5*x+10 :    %.15f\n", resd);
   resd=flResultR(FS2);
   printf("poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,x)                    :    %.15f\n", resd);
   resd=flResultR(FS3);
   printf("poly(cp,x)                                             :    %.15f\n", resd);
   cout <<  "" << endl;
   resd=flResultR(FDS1);
   printf("d^3/dx^3 2*x^9-4*x^8+7*x^7-5*x^6-6*x^5-9*x^4-8*x^3-2*x^2-5*x+10 :    %.15f\n", resd);
   resd=flResultR(FDS2);
   printf("d^3/dx^3 poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,x)                    :    %.15f\n", resd);
   resd=flResultR(FDS3);
   printf("d^3/dx^3 poly(cp,x)                                             :    %.15f\n", resd);

   cout <<  "" << endl;




cout <<  "***********************************************************************************************************************" << endl;
cout <<  "                   Examples (21)    Test derivatives of polynomials with complex vars.         " << endl;
cout <<  "                   The same polynomials with different type of writing" << endl;
cout <<  "      2*(z1/z2)^9-4*(z1/z2)^8+7*(z1/z2)^7-5*(z1/z2)^6-6*(z1/z2)^5-9*(z1/z2)^4-8*(z1/z2)^3-2*(z1/z2)^2-5*(z1/z2)+10                          " << endl;
cout <<  "                           poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,z1/z2)                                 " << endl;
cout <<  "                           poly(cp,z1/z2);     cp- arrays with coeff.                              " << endl;
 cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
cout <<  "" << endl;



   Expr1 = "2*(z1/z2)^9-4*(z1/z2)^8+7*(z1/z2)^7-5*(z1/z2)^6-6*(z1/z2)^5-9*(z1/z2)^4-8*(z1/z2)^3-2*(z1/z2)^2-5*(z1/z2)+10";
   Expr2 = "poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,z1/z2)";
   Expr3 = "poly(cp,z1/z2)";
   flCompile(Expr1,0,FS1);
   flCompile(Expr2,0,FS2);
   flCompile(Expr3,0,FS3);
   flCompileDeriv(Expr1,"z1",3,FDS1);
   flCompileDeriv(Expr2,"z1",3,FDS2);
   flCompileDeriv(Expr3,"z1",3,FDS3);

   flResultCxEP(FS1,&rezeCX);
   //flResultCxE(FS1,rezeCX.re,rezeCX.im);
   printf("2*(z1/z2)^9-4*(z1/z2)^8+7*(z1/z2)^7-5*(z1/z2)^6-6*(z1/z2)^5-9*(z1/z2)^4-8*(z1/z2)^3-2*(z1/z2)^2-5*(z1/z2)+10 \n");
   printf("Result :  %.12e", (double)rezeCX.re); printf(" "); printf("%.12e",  (double)rezeCX.im);  printf("i\n");
   cout <<  "" << endl;
   flResultCxEP(FS2,&rezeCX);
   //flResultCxE(FS1,rezeCX.re,rezeCX.im);
   printf("poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,z1/z2)\n");
   printf("Result :  %.12e", (double)rezeCX.re); printf(" "); printf("%.12e",  (double)rezeCX.im);  printf("i\n");
   cout <<  "" << endl;
   flResultCxEP(FS3,&rezeCX);
   //flResultCxE(FS1,rezeCX.re,rezeCX.im);
   printf("poly(cp,z1/z2)\n");
   printf("Result :  %.12e", (double)rezeCX.re); printf(" "); printf("%.12e",  (double)rezeCX.im);  printf("i\n");
   cout <<  "" << endl;


   flResultCxEP(FDS1,&rezeCX);
   printf("d^3/dz1^3 2*(z1/z2)^9-4*(z1/z2)^8+7*(z1/z2)^7-5*(z1/z2)^6-6*(z1/z2)^5-9*(z1/z2)^4-8*(z1/z2)^3-2*(z1/z2)^2-5*(z1/z2)+10 \n");
   printf("Result :  %.12e", (double)rezeCX.re); printf(" "); printf("%.12e",  (double)rezeCX.im);  printf("i\n");
   cout <<  "" << endl;
   flResultCxEP(FDS2,&rezeCX);
   printf("d^3/dz1^3 poly(2,-4,7,-5,-6,-9,-8,-2,-5,10,z1/z2)\n", resd);
   printf("Result :  %.12e", (double)rezeCX.re); printf(" "); printf("%.12e",  (double)rezeCX.im);  printf("i\n");
   cout <<  "" << endl;
   flResultCxEP(FDS3,&rezeCX);
   printf("d^3/dz1^3 poly(cp,z1/z2)\n", resd);
   printf("Result :  %.12e", (double)rezeCX.re); printf(" "); printf("%.12e",  (double)rezeCX.im);  printf("i\n");
   cout <<  "" << endl;

  // goto endc;


cout <<  "" << endl;
/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (22)  Test derivatives of functions with diff. template




***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "               Examples (22)    Test derivatives of functions with diff template               " << endl;
   cout <<  "                                                                                               " << endl;
   cout <<  "" << endl;

   cout << "fnc(x,y) = pow(-x^(k+1)/sin(-x/y),-ln(y/x)/cos(-y/x))"  << endl;
   cout << "pcdiv,pcpow,pcsin,pccos ,pcln -  derivatives of these are defined through diff. template"  << endl;
   cout << "pcfnc(x,y) = pcpow(-pcdiv(pcipow(x,k+1),pcsin(-pcdiv(x,y))),-pcdiv(pcln(pcdiv(y,x)),pccos(-pcdiv(y,x))))"  << endl;
    cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;

   flSetFunction("pcdiv(x1,x2:ext) = x1/x2",0,&idFP);
   flSetDiffTemplate(&idFP,"pcdiv (($dfarg1*$arg2-$arg1*$dfarg2),sqr($arg2))");

   flSetFunction("pcsin(x:ext) = sin(x)",0,&idFP);
   flSetDiffTemplate(&idFP,"pccos($arg1)*$dfarg1");

   flSetFunction("pccos(x:ext) = cos(x)",0,&idFP);
   flSetDiffTemplate(&idFP,"- pcsin($arg1)*$dfarg1");

   flSetFunction("pcln(x:ext) = ln(x)",0,&idFP);
   flSetDiffTemplate(&idFP,"$dfarg1/$arg1");

   flSetFunction("pcpow(x1,x2:ext) = x1^x2",0,&idFP);
   flSetDiffTemplate(&idFP,"pcpow($arg1,$arg2)*(($arg2)*($dfarg1)/($arg1)+($dfarg2)*pcln($arg1))");

   flSetFunction("pcipow(x:ext; n:int)=x^n",0,&idFP);
   flSetDiffTemplate(&idFP,"pcipow($arg1,$arg2-1)*$arg2*$dfarg1");


   Expr1 = "pow(-x^(k+1)/sin(-x/y),-ln(y/x)/cos(-y/x))";
   Expr2 = "pcpow(-pcdiv(pcipow(x,k+1),pcsin(-pcdiv(x,y))),-pcdiv(pcln(pcdiv(y,x)),pccos(-pcdiv(y,x))))";


   flSetDiffExpr(Expr1);
   flSetDiffVar("x");
   flDiffExpr(1);
   flSetDiffVar("y");
   flDiffExpr(1);
   flCompileDiffExpr(FS1);

   flSetDiffExpr(Expr2);
   flSetDiffVar("x");
   flDiffExpr(1);
   flSetDiffVar("y");
   flDiffExpr(1);
   flCompileDiffExpr(FS2);

   resd=flResultR(FS1);
   printf("  d^2/dxdy fnc(x,y)  :    %.15f\n", resd);
   resd=flResultR(FS2);
   printf("  d^2/dxdy pcfnc(x,y):    %.15f\n", resd);

   cout <<  "" << endl;
   ///-----------------------------------------------------------
   cout <<  "" << endl;



/**************************************************************************************************
                    Examples (23)  Test derivatives of functions with diff. template
/***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "               Examples (23)    Test derivatives of functions with diff. template              " << endl;
   cout <<  "                                                                                               " << endl;
   cout <<  "                     fnc(x,y,t)   = sin(2*x*y-3*y*t/(sin(t/(y*x))*t))                          " << endl;
   cout <<  "                     pcfnc(x,y,t) = pcfunc3(2*x*y,3*y*t,pcfunc2(t,y*x)*t)                      " << endl;
   cout <<  "                     where derivatives of these functions :                                    " << endl;
   cout <<  "                           pcfunc2(x,y:ext) = sin(x/y)                                         " << endl;
   cout <<  "                           pcfunc3(x,y,t:ext) = sin(x-y/t)                                     " << endl;
   cout <<  "                     are defined through  diff. template                                       " << endl;
    cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;


  // cout << "pcfunc2(x,y:ext) = sin(x/y)"  << endl;
  // cout << "pcfunc3(x,y,t:ext) = sin(x-y/t)"  << endl;
  // cout << "pcfunc2, pcfunc3 - with  diff. template"  << endl;
  // cout <<  "" << endl;

   flSetFunction("pcfunc2(x,y:ext) = sin(x/y)",0,&idFP);
   flSetDiffTemplate(&idFP,"cos($arg1/$arg2)*($dfarg1*$arg2-$dfarg2*$arg1)/sqr($arg2)");

   flSetFunction("pcfunc3(x,y,t:ext) = sin(x-y/t)",0,&idFP);
   flSetDiffTemplate(&idFP,"cos($arg1-$arg2/$arg3)*($dfarg1*sqr($arg3)-$dfarg2*$arg3+$dfarg3*$arg2)/sqr($arg3)");

   //pcfunc3(2*x*y,3*y*t,pcfunc2(t,y*x)*t)
   //sin(2*x*y-3*y*t/(sin(t/(y*x))*t))

   Expr1 = "sin(2*x*y-3*y*t/(sin(t/(y*x))*t))";
   Expr2 = "pcfunc3(2*x*y,3*y*t,pcfunc2(t,y*x)*t)";

   flSetDiffExpr(Expr1);
   flSetDiffVar("x");
   flDiffExpr(1);
   flSetDiffVar("y");
   flDiffExpr(1);
   flSetDiffVar("t");
   flDiffExpr(1);
   flCompileDiffExpr(FS1);

   flSetDiffExpr(Expr2);
   flSetDiffVar("x");
   flDiffExpr(1);
   flSetDiffVar("y");
   flDiffExpr(1);
   flSetDiffVar("t");
   flDiffExpr(1);
   flCompileDiffExpr(FS2);


   resd=flResultR(FS1);
   printf("  d^3/dxdydt fnc(x,y,t)  :    %.15f\n", resd);
   resd=flResultR(FS2);
   printf("  d^3/dxdydt pcfnc(x,y,t):    %.15f\n", resd);


   //goto endc;



cout <<  "" << endl;

/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (24)  Test  several expressions: REAL


/**
   fs3(x,y,z)=x*(y+z)+y*(x+z); fs2(x,y)=x+y; fs1(x)=1-x
   sum(x=1..5, dx=0.5; y=1..10; dy=0.2; fs3(f1(x-y),fs2(x+1,y-1),x+y));
**/



/***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "               Examples (24)    Test  several expressions: REAL              " << endl;
   cout <<  "                                                                                               " << endl;
   cout <<  "            fnc3(x,y,z)=x*(y+z)+y*(x+z); fnc2(x,y)=x+y; fnc1(x)=1-x                               " << endl;
   cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "            sum(x=1..5, dx=0.5; y=1..10; dy=0.2; fnc3(fnc1(x-y),fnc2(x+1,y-1),x+y)) =                " << endl;
   cout <<  "" << endl;


 flPerform(fl_SAVE, fl_VAR_LIST);/// save global var.


 fnc1.Expr = "1-x";
 fnc2.Expr = "x+y";
 fnc3.Expr = "x*(y+z)+y*(x+z)";

 flSetVar("x", &fnc1.x, RType);
 flCompile(fnc1.Expr, 0, fnc1.Addr);

 flSetVar("x", &fnc2.x, RType);
 flSetVar("y", &fnc2.y, RType);
 flCompile(fnc2.Expr, 0, fnc2.Addr);

 flSetVar("x", &fnc3.x, RType);
 flSetVar("y", &fnc3.y, RType);
 flSetVar("z", &fnc3.z, RType);
 flCompile(fnc3.Expr, 0, fnc3.Addr);

 flPerform(fl_RESTORE, fl_VAR_LIST);  ///  restore global var.
//flSet(fl_FPU_CW_DEFAULT,0x1332,0);
//flSet(fl_FPU_CW_DEFAULT,0,0)

	x = 1.0;
	y = 1.0;
	dx = 0.5;
	dy = 0.2;
	res = 0.0;
	resg = 0.0;

 while (x <= 5.0)
 {
	y = 1.0;
	while (y <= 10.0)
	{
		fnc1.x = x - y;
		fnc2.x = x + 1.0;
		fnc2.y = y - 1.0;

		fnc3.x =  flResultR(fnc1.Addr);
		fnc3.y =  flResultR(fnc2.Addr);
		fnc3.z = x + y;

		res = res +  flResultR(fnc3.Addr);


		/// by GCC:
		Fnc1x = x - y;
		Fnc2x = x + 1.0;
		Fnc2y = y - 1.0;

		Fnc3x = 1.0 - Fnc1x;
        Fnc3y = Fnc2x + Fnc2y;
        Fnc3z = x + y;

		resg =  resg + Fnc3x*(Fnc3y + Fnc3z) + Fnc3y*(Fnc3x + Fnc3z);



		y = y + dy;
	};

	x = x + dx;
 };

 //resd = res;
 //printf("several expressions (Foreval): %.12f\n", resd);
 //resd = resg;
 //printf("several expressions (GCC)    : %.12f\n", resd);

 ShowResult("Result (Foreval):",res);
 ShowResult("Result (GCC)    :",resg);

 //goto endc;

  cout <<  "" << endl;


/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (25)  Test  several expressions:  COMPLEX

 /**
	  fnc1(z1,z2,n,x) = z1+z2+n*x;
	  fnc2(z1,z2,n,x)=  z1*z2+(i*n+x);

	  fnc2(fnc1(2-i,5+3i,3,1.1),1-i,5,fnc1(2-i,5+3i,3,1.1).re)=
   **/



/***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "               Examples (25)    Test  several expressions:  COMPLEX              " << endl;
   cout <<  "                                                                                 " << endl;
   cout <<  "             fnc1(z1,z2,n,x) = z1+z2+n*x; fnc2(z1,z2,n,x)=  z1*z2+(i*n+x);       " << endl;
   cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;
   cout <<  "             fnc2(fnc1(2-i,5+3i,3,1.1),1-i,5,fnc1(2-i,5+3i,3,1.1).re)  =         " << endl;
   cout <<  "" << endl;

    flPerform(fl_SAVE, fl_VAR_LIST);   /// save global variables list

    fnc1.Expr= "z1+z2+n*x";
	flSetVar("x", &fnc1.x, RType);
	flSetVar("n", &fnc1.n, fl_REAL_INTEGER);
	flSetVar("z1", &fnc1.z1, CxType);
	flSetVar("z2", &fnc1.z2, CxType);
	flCompile(fnc1.Expr, 0, fnc1.Addr);

	fnc2.Expr = "z1*z2+(i*n+x)";
	flSetVar("x", &fnc2.x, RType);
	flSetVar("n", &fnc2.n, fl_REAL_INTEGER);
	flSetVar("z1", &fnc2.z1, CxType);
	flSetVar("z2", &fnc2.z2, CxType);
	flCompile(fnc2.Expr, 0, fnc2.Addr);

	flPerform(fl_RESTORE, fl_VAR_LIST);    /// restore global variables list

	fnc1.x = 1.1;  fnc1.n = 3; fnc1.z1.re = 2;  fnc1.z1.im = -1;  fnc1.z2.re = 5; fnc1.z2.im = 3;
				   fnc2.n = 5;                                    fnc2.z2.re = 1; fnc2.z2.im = -1;


    #ifdef   EXTENDED_FLOAT
        flResultCxEP(fnc1.Addr, &fnc1.res) ;    //fnc1.res=fnc1(2-i,5+3i,3,1.1)
    #else
        flResultCxDP(fnc1.Addr, &fnc1.res) ;    //fnc1.res=fnc1(2-i,5+3i,3,1.1)
    #endif


	fnc2.z1 = fnc1.res; fnc2.x = fnc1.res.re;


    #ifdef   EXTENDED_FLOAT
        flResultCxEP(fnc2.Addr, &fnc2.res);
    #else
        flResultCxDP(fnc2.Addr, &fnc2.res);
    #endif

    //ShowResult(fnc2.res);

    RezG = Gccfnc2(Gccfnc1(2-i,5+3*i,3,1.1),1-i,5,Gccfnc1(2-i,5+3*i,3,1.1).re) ;
   //RezG = Gccfnc2(2-i,5+3*i,3,1.1);
    ShowResult("Result (Foreval):",fnc2.res.re,fnc2.res.im);
    ShowResult("Result (GCC)    :",RezG.re,RezG.im);

	//SRes=FloatToStr(fnc2.res.re)+"   "+FloatToStr(fnc2.res.im)+"i";
    //cout <<  SRes << endl;

  // goto endc;

//******************************************************************************
   cout <<  "" << endl;




/***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "                                                    Examples (26)                                                     " << endl;
   cout <<  "               Test  several COMPLEX expressions with  memory for variables allocated in  Foreval.dll              " << endl;
   cout <<  "     For environments without permanent memory allocated for variables. That is, the memory under them is relocatable. " << endl;
   cout <<  "                                                                                                                       " << endl;
   cout <<  "-------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;
   cout <<  "                     " << endl;
   cout <<  "" << endl;

   flPerform(fl_SAVE, fl_VAR_LIST);   /// save global variables list
   /**


       f1 = func1(z1,z2,z3: complex; x,y: real; k,n:integer) = z3*(z1*x+z2*y)/(z1*n+z2*k)
       f2 = func2(z1,z2,z3: complex; x,y: real; k,n:integer) = z3*(z1*y+z2*x)/(z1*k+z2*n)

       z3,x,n - common for both functions


       algorithm:

       k = 1..5
       {
           n = 1..5
           {
             z1t = func1(z2,    z1-z2, z3, x, x-y,  k-n, n);
             z2  = func2(z2-z1, z1,    z3, x, y-x,  n-k, n);
             z1  = z1t;
             x   = x-x/(n+k);
             y   = y-y/(n+k);
             z3.re = z3.re-x/y;
             z3.im = z3.im-y/x;
           }
       }

       Result = z1+z2+z3;



   **/

   /// set common vars.
   flSetVarIntrnl("z3",CxType,AddrZ3);
   flSetVarIntrnl("x",RType,AddrX);
   flSetVarIntrnl("n",fl_REAL_INTEGER,AddrN);


   Func1ExtCX.Expr = "z3*(z1*x+z2*y)/(z1*n+z2*k)";
   //flSetVarIntrnl("x",RType,Func1ExtCX.addrX);
   flSetVarIntrnl("y",RType,Func1ExtCX.addrY);
   //flSetVarIntrnl("n",fl_REAL_INTEGER,Func1ExtCX.addrN);
   flSetVarIntrnl("k",fl_REAL_INTEGER,Func1ExtCX.addrK);
   flSetVarIntrnl("z1",CxType,Func1ExtCX.addrZ1);
   flSetVarIntrnl("z2",CxType,Func1ExtCX.addrZ2);
   //flSetVarIntrnl("z3",CxType,Func1ExtCX.addrZ3);
   flSetVarIntrnl("Func1Rez",CxType, Func1ExtCX.addrRezCX);
   flCompile(Func1ExtCX.Expr, 0, Func1ExtCX.FAddr);

   Func2ExtCX.Expr = "z3*(z1*y+z2*x)/(z1*k+z2*n)";
   //flSetVarIntrnl("x",RType,Func2ExtCX.addrX);
   flSetVarIntrnl("y",RType,Func2ExtCX.addrY);
   //flSetVarIntrnl("n",fl_REAL_INTEGER,Func2ExtCX.addrN);
   flSetVarIntrnl("k",fl_REAL_INTEGER,Func2ExtCX.addrK);
   flSetVarIntrnl("z1",CxType,Func2ExtCX.addrZ1);
   flSetVarIntrnl("z2",CxType,Func2ExtCX.addrZ2);
   //flSetVarIntrnl("z3",CxType,Func2ExtCX.addrZ3);
   flSetVarIntrnl("Func2Rez",CxType, Func2ExtCX.addrRezCX);
   flCompile(Func2ExtCX.Expr, 0, Func2ExtCX.FAddr);

   //flSetVarIntrnl("z1",CxType,AddrZ1);
   //flSetVarIntrnl("z2",CxType,AddrZ2);
   //flSetVarIntrnl("z3",CxType,AddrZ3);

   flPerform(fl_RESTORE, fl_VAR_LIST);    /// restore global variables list



   ///********* Calc. in Foreval ***************************

                /// z1,z2,z3,z4,x,y,iN,iK - do not require address passed
   z1.re = 1.1;  z1.im = -2.2;
   z2.re = -1.2; z2.im = 2.1;
   z3.re = 1.5;  z3.im = 2.5;
   x = 1.7; y = - 2.3;
   #ifdef   EXTENDED_FLOAT
       flSetVarValueCxE(Func1ExtCX.addrZ1,z2.re,z2.im);
       flSetVarValueCxE(Func2ExtCX.addrZ2,z1.re,z1.im);
       z4 = z1-z2;
       flSetVarValueCxE(Func1ExtCX.addrZ2,z4.re,z4.im);
       z4 = -z4; //= z2-z1
       flSetVarValueCxE(Func2ExtCX.addrZ1,z4.re,z4.im);
       flSetVarValueCxE(AddrZ3,z3.re,z3.im);
       flSetVarValueE(AddrX,x);
       flSetVarValueE(Func1ExtCX.addrY,x-y);
       flSetVarValueE(Func2ExtCX.addrY,y-x);
   #else
       flSetVarValueCxD(Func1ExtCX.addrZ1,z2.re,z2.im);
       flSetVarValueCxD(Func2ExtCX.addrZ2,z1.re,z1.im);
       z4 = z1-z2;
       flSetVarValueCxD(Func1ExtCX.addrZ2,z4.re,z4.im);
       z4 = -z4; //= z2-z1
       flSetVarValueCxD(Func2ExtCX.addrZ1,z4.re,z4.im);
       flSetVarValueCxD(AddrZ3,z3.re,z3.im);
       flSetVarValueD(AddrX,x);
       flSetVarValueD(Func1ExtCX.addrY,x-y);
       flSetVarValueD(Func2ExtCX.addrY,y-x);
   #endif


   for(iK = 1; iK <= 5; iK++)
   {
        for(iN = 1; iN <= 5; iN++)
        {
            flSetVarValueI(AddrN,iN);
            flSetVarValueI(Func1ExtCX.addrK,iK-iN);
            flSetVarValueI(Func2ExtCX.addrK,iN-iK);




            #ifdef   EXTENDED_FLOAT
                flResultCxEP(Func1ExtCX.FAddr, Func1ExtCX.addrRezCX) ;
                flResultCxEP(Func2ExtCX.FAddr, Func2ExtCX.addrRezCX) ;

                flCopyVarCxE(Func2ExtCX.addrZ2, Func1ExtCX.addrRezCX); //func1.result (= z1) -> func2.z2
                flCopyVarCxE(Func1ExtCX.addrZ1, Func2ExtCX.addrRezCX); //func2.result (= z2) -> func1.z1

                 x  = x - x/(iN+iK);
                 y  = y - y/(iN+iK);
                 z3.re = z3.re-x/(y+x);
                 z3.im = z3.im-y/(y+x);
                 flSetVarValueCxE(AddrZ3,z3.re,z3.im);
                 flSetVarValueE(AddrX,x);
                 flSetVarValueE(Func1ExtCX.addrY,x-y);
                 flSetVarValueE(Func2ExtCX.addrY,y-x);
                 flGetVarValueCxE(Func1ExtCX.addrRezCX,z1.re,z1.im);
                 flGetVarValueCxE(Func2ExtCX.addrRezCX,z2.re,z2.im);
                 z4 = z1-z2;
                 flSetVarValueCxE(Func1ExtCX.addrZ2,z4.re,z4.im);
                 z4 = -z4; //= z2-z1
                 flSetVarValueCxE(Func2ExtCX.addrZ1,z4.re,z4.im);
            #else
                 flResultCxDP(Func1ExtCX.FAddr, Func1ExtCX.addrRezCX) ;
                 flResultCxDP(Func2ExtCX.FAddr, Func2ExtCX.addrRezCX) ;

                 flCopyVarCxD(Func2ExtCX.addrZ2, Func1ExtCX.addrRezCX); //func1.result (= z1) -> func2.z2
                 flCopyVarCxD(Func1ExtCX.addrZ1, Func2ExtCX.addrRezCX); //func2.result (= z2) -> func1.z1

                 x  = x - x/(iN+iK);
                 y  = y - y/(iN+iK);
                 z3.re = z3.re-x/(y+x);
                 z3.im = z3.im-y/(y+x);
                 flSetVarValueCxD(AddrZ3,z3.re,z3.im);
                 flSetVarValueD(AddrX,x);
                 flSetVarValueD(Func1ExtCX.addrY,x-y);
                 flSetVarValueD(Func2ExtCX.addrY,y-x);
                 flGetVarValueCxD(Func1ExtCX.addrRezCX,z1.re,z1.im);
                 flGetVarValueCxD(Func2ExtCX.addrRezCX,z2.re,z2.im);
                 z4 = z1-z2;
                 flSetVarValueCxD(Func1ExtCX.addrZ2,z4.re,z4.im);
                 z4 = -z4; //= z2-z1
                 flSetVarValueCxD(Func2ExtCX.addrZ1,z4.re,z4.im);
            #endif





        }  ;

   } ;
   #ifdef   EXTENDED_FLOAT
      flGetVarValueCxE(Func1ExtCX.addrRezCX,z1.re,z1.im);
      flGetVarValueCxE(Func2ExtCX.addrRezCX,z2.re,z2.im);
   #else
      flGetVarValueCxD(Func1ExtCX.addrRezCX,z1.re,z1.im);
      flGetVarValueCxD(Func2ExtCX.addrRezCX,z2.re,z2.im);
   #endif

   z4 = z1+z2+z3;
   ShowResult("Result (Foreval):",z4.re,z4.im);


   ///********* Calc. in GCC ***************************

   z1.re = 1.1;  z1.im = -2.2;
   z2.re = -1.2; z2.im = 2.1;
   z3.re = 1.5;  z3.im = 2.5;
   x = 1.7; y = - 2.3;


    for(iK = 1; iK <= 5; iK++)
   {
        for(iN = 1; iN <= 5; iN++)
        {

                 z4 = func1Gcc(z2, z1-z2, z3, x, x-y,  iK-iN, iN);
                 z2 = func2Gcc(z2-z1, z1, z3, x, y-x,  iN-iK, iN);

                 z1 = z4;
                 x  = x - x/(iN+iK);
                 y  = y - y/(iN+iK);
                 z3.re = z3.re-x/(y+x);
                 z3.im = z3.im-y/(y+x);

        }  ;

   } ;

   z4 = z1+z2+z3;
   ShowResult("Result (GCC):    ",z4.re,z4.im);



   RefReshVar();

/****************************************************************************************************************************************
/**************************************************************************************************
                            Examples (27)  Test  functions with ID

 /**
      idSin(x)=idfunc(x,id=1)=sin(x); idCos(x)=idfunc(x,id=2)=cos(x);
	  idSin(x)^2+idCos(x)^2 =

	  idFnc1(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=1);
	  idFnc2(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=2);
	  idFnc3(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=3);
	  idFnc4(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=4);

	  idFncCF(z1,x,vd,n,id) = z1*vd[n]*x*CFid[id];

       idFnc1(z1,x,vd,n)/(z1*x*vd[n])+ idFnc2(z1,y,vd,n+3)/(z1*y*vd[n+3]) + idFnc3(z2,x+y,vd,n+5)/(z2*(x+y)*vd[n+5]) + idFnc4(z3,t,vd,k+n+7)/(z3*t*vd[k+n+7])=

   **/

    cout <<  "" << endl;

/***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "               Examples (27)    Test  functions with ID;               " << endl;
   cout <<  "                                                                       " << endl;
   cout <<  "idSin(x)=idfunc(x,id=1)=sin(x); idCos(x)=idfunc(x,id=2)=cos(x);" << endl;
   cout <<  "                                                                " << endl;
   cout <<  "idFnc1(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=1); idFnc2(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=2);" << endl;
   cout <<  "idFnc3(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=3); idFnc4(z1,x,vd,n) = idFncCF(z1,x,vd,n,id=4); " << endl;
   cout <<  "                                                                                          " << endl;
   cout <<  "                idFncCF(z1,x,vd,n,id) = z1*vd[n]*x*CFid[id];" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;



   Expr1 = "idSin(x)^2+idCos(x)^2";
   Expr2 = "idFnc1(z1,x,vu,n)/(z1*x*vu[n])+ idFnc2(z1,y,vu,n+3)/(z1*y*vu[n+3]) + idFnc3(z2,x+y,vu,n+5)/(z2*(x+y)*vu[n+5]) + idFnc4(z3,t,vu,k+n+7)/(z3*t*vu[k+n+7])";

   /*
   #ifdef   EXTENDED_FLOAT
        Expr2 = "idFnc1(z1,x,ve,n)/(z1*x*ve[n])+ idFnc2(z1,y,ve,n+3)/(z1*y*ve[n+3]) + idFnc3(z2,x+y,ve,n+5)/(z2*(x+y)*ve[n+5]) + idFnc4(z3,t,ve,k+n+7)/(z3*t*ve[k+n+7])";
   #else
        Expr2 = "idFnc1(z1,x,vd,n)/(z1*x*vd[n])+ idFnc2(z1,y,vd,n+3)/(z1*y*vd[n+3]) + idFnc3(z2,x+y,vd,n+5)/(z2*(x+y)*vd[n+5]) + idFnc4(z3,t,vd,k+n+7)/(z3*t*vd[k+n+7])";
   #endif
   */


   flCompile(Expr1, 0, FS1);
   flCompile(Expr2, 0, FS2);



   //resd=flResultR(FS1);
   //printf("idSin(x)^2+idCos(x)^2 =     %.15f\n", resd);

   cout <<  "" << endl;

   /*
   #ifdef   EXTENDED_FLOAT
        flResultCxEP(FS2, &resf) ;
    #else
        flResultCxDP(FS2, &resf) ;
    #endif

    printf("idFnc1(z1,x,vu,n)/(z1*x*vu[n])+ idFnc2(z1,y,vu,n+3)/(z1*y*vu[n+3]) + idFnc3(z2,x+y,vu,n+5)/(z2*(x+y)*vu[n+5]) + idFnc4(z3,t,vu,k+n+7)/(z3*t*vu[k+n+7]) =   \n");
    ShowResult(resf);
    */
    ShowResult(FS1,Expr1,fl_REAL);
    ShowResult(FS2,Expr2,fl_COMPLEX);


   cout <<  "" << endl;



/***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "               Examples (28)    Test  overload functions;               " << endl;
   cout <<  "" << endl;
   cout <<  "            Fovrl()=pi^2; Fovrl(x)=x^2; Fovrl(z)=z^2; Fovrl(vx,n)=vx[n]^2;                             " << endl;
   cout <<  "" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;


    Expr1 = "Fovrl()/pi^2+Fovrl(x+y)/(x+y)^2+Fovrl(z1+z2)/(z1+z2)^2+Fovrl(vu,n+k)/vu[n+k]^2";
    flCompile(Expr1, 0, FS1);


    #ifdef   EXTENDED_FLOAT
        flResultCxEP(FS1, &resf) ;
    #else
        flResultCxDP(FS1, &resf) ;
    #endif

    printf("Fovrl()/pi^2+Fovrl(x+y)/(x+y)^2+Fovrl(z1+z2)/(z1+z2)^2+Fovrl(vu,n+k)/vu[n+k]^2 =   \n");
    ShowResult(resf);

  //goto endc;


    cout <<  "" << endl;


   /***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "               Examples (29)    Test  infinite  functions (with any numbers of arguments);               " << endl;
   cout <<  "" << endl;
   cout <<  "            infsum(r1,r2,...)=sum(r1,r2,...);  infsum(z1,z2,...)=sum(z1,z2,...);                             " << endl;
   cout <<  "" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;

    Expr1 = "infsum(x,3*infsum(t+2*x+infsum(y,t)),y,2*x,3*y,t*infsum()+x)/(x+3*(t+2*x+(y+t))+y+2*x+3*y+t*0+x)";
    flCompile(Expr1, 0, FS1);
    ShowResult(FS1,Expr1,fl_REAL);
   // resd=flResultR(FS1);
  //  printf("infsum(x,3*infsum(t+2*x+infsum(y,t)),y,2*x,3*y,t*infsum()+x)/(x+3*(t+2*x+(y+t))+y+2*x+3*y+t*0+x) = :    %.15f\n", resd);

    Expr2 = "infsum(z1,3*infsum(z3+2*z1+infsum(z2,z3)),z2,2*z1,3*z2,z3*infsum()+z1)/(z1+3*(z3+2*z1+(z2+z3))+z2+2*z1+3*z2+z3*0+z1)";
    flCompile(Expr2, 0, FS2);
    ShowResult(FS2,Expr2,fl_COMPLEX);

 cout <<  "" << endl;




    /******************************************************************************
                                 ATTRIB
    ******************************************************************************/


   /***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "               Examples (30)    Test    ATTRIB structure;               " << endl;
   cout <<  "" << endl;
   cout <<  "                 See comments in text of program                          " << endl;
   cout <<  "" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;

               /// ATTRIB using for  the convenience of calculations in one procedure:  flResult

    flPerform(fl_SAVE, fl_VAR_LIST);   /// save global vars.

    flSet(fl_RESULT_LEAD_TO_TYPE,fl_STAY_AS_IS,0);

                                                /// RType = fl_REAL_EXTENDED/fl_REAL_DOUBLE; CxType = fl_COMPLEX_EXTENDED/fl_COMPLEX_DOUBLE;

    /// ----------- Result Type = None.  Result store in global var. ResultR --------------
     fnc1A.Expr = "ResultR = x+y+t";
     flSetVar("x", &fnc1A.x, RType);
     flSetVar("y", &fnc1A.y, RType);
     flSetVar("t", &fnc1A.t, RType);


     Attr.MType = MType; Attr.AddrRE = &fnc1A.res; Attr.AddrIM = &fnc1A.res.im ;///MType = fl_EXTENDED,fl_DOUBLE
     flCompile(fnc1A.Expr, &Attr, fnc1A.Addr);



    /// ------------- Result Type = Real.  Result store in fnc2A.res ------------
     fnc2A.Expr = "x=x+1; y=y+2; t=t+3; x*y*t";
     flSetVar("x", &fnc2A.x, RType);
     flSetVar("y", &fnc2A.y, RType);
     flSetVar("t", &fnc2A.t, RType);


     Attr.MType = MType; Attr.AddrRE = &fnc2A.res; Attr.AddrIM = &fnc2A.res.im;  ///MType = fl_EXTENDED,fl_DOUBLE
     flCompile(fnc2A.Expr, &Attr, fnc2A.Addr);


    ///------------- Result Type = Complex. Result store in fnc3A.res. z2 - global var.  ------------
     fnc3A.Expr = "(z2-z1+x)*ResultR";
     flSetVar("x",  &fnc3A.x,  RType);
     flSetVar("z1", &fnc3A.z1, CxType);


     Attr.MType = MType; Attr.AddrRE = &fnc3A.res.re;  Attr.AddrIM = &fnc3A.res.im; ///MType = fl_EXTENDED,fl_DOUBLE
     flCompile(fnc3A.Expr, &Attr, fnc3A.Addr);
   ///-------------------------

   flPerform(fl_RESTORE, fl_VAR_LIST); ///  restore global vars.


     fnc1A.x = 1.1;  fnc1A.y = 2.2; fnc1A.t = 3.3;
     fnc2A.x = 1.0;  fnc2A.y = 2.0; fnc2A.t = 3.0;

   flResult(fnc1A.Addr);        //ResultR=1.1+2.2+3.3=6.6
   flResult(fnc2A.Addr);        //fnc2A.res=(1+1)*(2+2)*(3+3)=48

     fnc3A.x = fnc2A.res.re; fnc3A.z1.re = 1.1;  fnc3A.z1.im = -1.1;

   flResult(fnc3A.Addr);          //fnc3A.res = (5.456+2.789i-(1.1-1.1i)+48)*6.6  = 345.5496+25.6674i

     ShowResult(resf.re);
     ShowResult(fnc2A.res.re);
     ShowResult(fnc3A.res);


  cout <<  "" << endl;
  cout <<  "***********************************************************************************************************************" << endl;

  /******************************************************************************/

  cout <<  "" << endl;





  /***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "            Examples (31)    Test of call external functions and procedures on their addresses by callr, callc, calln; " << endl;
   cout <<  "" << endl;
   cout <<  "                 See comments in text of program                          " << endl;
   cout <<  "" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;


   /** See  above  setting:  _RFuncPtr, pcrfunc;  _ZFuncPtr, pczfunc;  _NFuncPtr, pcnfunc
    vp1[] - consist identical 2 addr of real func with different type of setting
    vp2[] - consist identical 2 addr of complex func with different type of setting;
    vp3[] - consist identical 2 addr of complex proc with different type of setting;
    Comparing of  results summing these func&proc throught calling by addr - SC  and right evaluations identical expressions with changes variables at calculations - SC1
   **/

   InitRealPointerVar(&x, &y, &t);
   InitComplexPointerVar(pvZ1, pvZ2, pvZ3);

   flGetFunctionAddr(&idFP1,Ptr1);  ///Ptr1 <- pcrfunc
   flGetFunctionAddr(&idFP2,Ptr2);  ///Ptr2 <- pczfunc
   flGetFunctionAddr(&idFP3,Ptr3);  ///Ptr3 <- pcnfunc


   flSetLength(adrVp1, fl_ARRAY_POINTER, 2);  ///for addr real func
   flSetLength(adrVp2, fl_ARRAY_POINTER, 2);  ///for addr complex func
   flSetLength(adrVp3, fl_ARRAY_POINTER, 2);  ///for addr complex proc


   flSetArrayValueI(adrVp1,0,(_int32)&_RFuncPtr); flSetArrayValueI(adrVp1,1,(_int32)Ptr1);
   flSetArrayValueI(adrVp2,0,(_int32)&_ZFuncPtr); flSetArrayValueI(adrVp2,1,(_int32)Ptr2);
   flSetArrayValueI(adrVp3,0,(_int32)&_NFuncPtr); flSetArrayValueI(adrVp3,1,(_int32)Ptr3);

   //L1 = L2 = L3 = 2
   Expr1 = "L1:int=len(vp1); L2:int=Len(vp2);L3:int=Len(vp3); n:int=0;  k:int=0; CNT: int=10;"
           "x=2; y=3; z1=2-3i; z2=3-5i;  SC: Cxext=0+0i;"
           "for(k=1,CNT, x=x/k; y=y/k;  z1=z1/k; z2=z2/k;  for(n=0,L1-1, SC=SC+callr(vp1[n])); for(n=0,L2-1, SC=SC+callc(vp2[n])); for(n=0,L3-1, call(vp3[n]); SC=SC+Result));"

           "x=2; y=3; z1=2-3i; z2=3-5i;  SC1: Cxext=0+0i;"
           "for(k=1,CNT, x=x/k; y=y/k;  z1=z1/k; z2=z2/k;   SC1=SC1+(( 2.5*x+1.7*y ) + ( 2.5*z1-1.7*z2 ) + (2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i)));"

           "SC/(SC1*L1)";


   flCompile(Expr1, 0, FS1);
   ShowResult(FS1,Expr1,fl_COMPLEX);





  /***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "            Examples (32)    Test of call external functions and procedures  with arguments passed by  Pointers " << endl;
   cout <<  "" << endl;
   cout <<  "  spprocsqr2(@x,@z) -> return x^2,z^2;                                                                            " << endl;
   cout <<  "" << endl;
   cout <<  "  spprocsumall(RealVal1, RealVal2, IntVal1, IntVal2, ComplexVal1, ComplexVal2, Array1, Array2, @RealS, @IntS, @ComplexS, @ArrayS);   " << endl;
   cout <<  "  -> return RealS=RealVal1+RealVal2,z^2; IntS=IntVal12+IntVal2; ComplexS=ComplexVal1+ComplexVal2;  ArrayS=Array1+Array2 ;"  << endl;
    cout <<  "" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;

   /** See  above  setting:  spproc2r , spproc2c , spprocswpinc2r ,  spprocswpinc2c , spprocsqr2 ,  spprocsumall **/

   Expr1 = "x=2; z1=3+3i; spprocsqr2(@x,@z1); spprocsqr2(@x,@z1); spprocsqr2(@x,@z1); root(z1,8,1)*root8(x)"; //=(3+3i)*2

   Expr1 = "x=2; z1=3+3i; xt=x; zt=z1; spprocsqr2(@x,@z1); spprocsqr2(@x,@z1); spprocsqr2(@x,@z1); (x*z1)/(xt^8*zt^8)"; //=1+0i

   flCompile(Expr1, 0, FS1);
   ShowResult(FS1,Expr1,fl_COMPLEX);

   cout <<  "" << endl;

   Expr2 = "x=1; y=2; n=3; k=4; z1=3+4i; z2=5+7i; spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1,vu2, @s, @m, @z5, @vu3); r=0; kf:int=0;"
           "L:int=len(vu3); for(kf=0,L-1,r=r+(vu1[kf]+vu2[kf])); ctrlc:Cxext = r/sum(vu3) + s/(2*x+1 + 3*y+2) + m/(n+k + 2*j*k) + z5/(2*z1 + 5*z1+z2); ctrlc"; // = 4+0i
   flCompile(Expr2, 0, FS2);
   ShowResult(FS2,Expr2,fl_COMPLEX);

    //ctrlc = 4+0i





   /***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "               Examples (33)    Test of external functions and procedures with variables, passed by pointers;          " << endl;
   cout <<  "" << endl;
   cout <<  "                 See comments in text of program                          " << endl;
   cout <<  "" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;


   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "Triple integral (on v1,v2,v3 ) with variables  limits of integration , passed by the addresses  FRInt1XYT = Func(v1,v2,v3);  FRLim1X,FRLim2X = Func(v2); FRLim3XY,FRLim4XY = Func(v2,v3) " << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;

    Expr1 = "Integral3FF(@FRInt1XYT, @x,@y,@t, a,f, @FRLim1X, @FRLim2X,  @FRLim3XY, @FRLim4XY)";
    flCompile(Expr1, 0, FS1);
    ShowResult(FS1,Expr1,fl_REAL);
   cout <<  "" << endl;

    Expr2 = "Integral3FF(@FRInt1XYT, @s,@p,@q, a,f, @FRLim1X, @FRLim2X,  @FRLim3XY, @FRLim4XY)";
    flCompile(Expr2, 0, FS2);
    ShowResult(FS2,Expr2,fl_REAL);

   cout <<  "" << endl;
    ///  For analogous "pc"-functions ,variables of integration only - x,y,t!


    Expr3 = "Integral3FF(@pcInt1XYT, @x,@y,@t, a,f, @pcLim1X, @pcLim2X,  @pcLim3XY, @pcLim4XY)";
    flCompile(Expr3, 0, FS3);
    ShowResult(FS3,Expr3,fl_REAL);

  cout <<  "" << endl;
  cout <<  "" << endl;


    cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
    cout <<  "Sums of three triple integrals. Variables and functions limits pass by addresses " << endl;
    cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;


    cout <<  "" << endl;
    Expr1 = "PFLim1X:pointer = @FRLim1X; PFLim2X:pointer = @FRLim2X; PFLim3XY:pointer =  @FRLim3XY; PFLim4XY:pointer =  @FRLim4XY;"
             "L:Int=3; VPF: arrayPtr = L; VPF[0] = @FRInt1XYT;  VPF[1] = @FRInt2XYT; VPF[2] = @FRInt3XYT;  s:ext=0; n:int=0;"
             "for(n=0,L-1, s=s + Integral3FF(VPF[n], @x,@y,@t, a,f, PFLim1X, PFLim2X,  PFLim3XY, PFLim4XY));s" ;

   flCompile(Expr1, 0, FS1);
   ShowResult(FS1,Expr1,fl_REAL);

  cout <<  "" << endl;

   Expr2 = "PFLim1X:pointer = @pcLim1X; PFLim2X:pointer = @pcLim2X; PFLim3XY:pointer =  @pcLim3XY; PFLim4XY:pointer =  @pcLim4XY;"
           "L:Int=3; VPF: arrayPtr = L; VPF[0] = @pcInt1XYT;  VPF[1] = @pcInt2XYT; VPF[2] = @pcInt3XYT;  s:ext=0; n:int=0;"
           "for(n=0,L-1, s=s + Integral3FF(VPF[n], @x,@y,@t, a,f, PFLim1X, PFLim2X,  PFLim3XY, PFLim4XY));s";

   flCompile(Expr2, 0, FS2);
   ShowResult(FS2,Expr2,fl_REAL);

  cout <<  "" << endl;


   flSetLength(adrVpF3, fl_ARRAY_POINTER, 3);
   flSetArrayValueI(adrVpF3,0,(_int32)&FRInt1XYT);
   flSetArrayValueI(adrVpF3,1,(_int32)&FRInt2XYT);
   flSetArrayValueI(adrVpF3,2,(_int32)&FRInt3XYT);

   PtrF1=(Pointer32)&FRLim1X;
   PtrF2=(Pointer32)&FRLim2X;
   PtrF3=(Pointer32)&FRLim3XY;
   PtrF4=(Pointer32)&FRLim4XY;

   Expr3 = "L:Int=Len(vpF3);  s:ext=0; n:int=0; for(n=0,L-1, s=s + Integral3FF(VPF3[n], @x,@y,@t, a,f, PtrF1, PtrF2,  PtrF3, PtrF4));s";
   flCompile(Expr3, 0, FS3);
   ShowResult(FS3,Expr3,fl_REAL);
   cout <<  "" << endl;



   pvX=&x; pvY=&y; pvT=&t;
   flSetVar("px",&pvX,fl_POINTER);
   flSetVar("py",&pvY,fl_POINTER);
   flSetVar("pt",&pvT,fl_POINTER);

   Expr4 = "L:Int=Len(vpF3);  s:ext=0; n:int=0; for(n=0,L-1, s=s + Integral3FF(VPF3[n], px,py,pt, a,f, PtrF1, PtrF2,  PtrF3, PtrF4));s";
   flCompile(Expr4, 0, FS4);
   ShowResult(FS4,Expr4,fl_REAL);



  cout <<  "" << endl;
   cout <<  "" << endl;
   cout <<  "***********************************************************************************************************************" << endl;

    /******************************************************************************/

    cout <<  "" << endl;






  /***************************************************************************************************/
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "***********************************************************************************************************************" << endl;
   cout <<  "" << endl;
   cout <<  "            Examples (34)    Test mode of optimization: fl_PACKAGE_EXPRESSIONS "                                          << endl;
   cout <<  "" << endl;
   cout <<  "               Two way calculations of package expressions.   See comments in text of program                       "     << endl;
   cout <<  "" << endl;
   cout <<  "------------------------------------------------------------------------------------------------------------------------" << endl;
   cout <<  "" << endl;



    flSetVar("Bt",  &Bt, RType);
    flSetVar("Al",  &Al, RType);
    flSetVar("Gm",  &Gm, RType);

    /// (1)
    flSetVar("X1c", &X1c, RType); flSetVar("Y1c", &Y1c, RType); flSetVar("Z1c", &Z1c, RType);

    Expr1= "X1c=R*sin(Bt)*cos(Gm)*exp(Gm*cot(Al)); Y1c=R*sin(Bt)*sin(Gm)*exp(Gm*cot(Al)); Z1c=-R *cos(Bt)*exp(Gm*cot(Al))";

    flSet(fl_ENABLE,  fl_ALL_REPLACE,0);
        flCompile(Expr1, 0, FS1);
    flSet(fl_DISABLE,  fl_ALL_REPLACE,0);


    /// (2)
    flSetVar("X2c", &X2c, RType); flSetVar("Y2c", &Y2c, RType); flSetVar("Z2c", &Z2c, RType);

    flSet(fl_ENABLE,  fl_PACKAGE_EXPRESSIONS,0); // in mode fl_PACKAGE_EXPRESSIONS, optimization  fl_ALL_REPLACE - turns on automatically
       Attr.AddrRE = &X2c;   Attr.MType = RType;
       flSetExpression("R*sin(Bt)*cos(Gm)*exp(Gm*cot(Al))", &Attr,  fl_PACKAGE_EXPRESSIONS,  FS3,  Err);
       Attr.AddrRE = &Y2c;
       flSetExpression("R*sin(Bt)*sin(Gm)*exp(Gm*cot(Al))", &Attr,  fl_PACKAGE_EXPRESSIONS,  FS3,  Err);
       Attr.AddrRE = &Z2c;
       flSetExpression("-R *cos(Bt)*exp(Gm*cot(Al))", &Attr,  fl_PACKAGE_EXPRESSIONS,  FS3,  Err);
    flPerform(fl_COMPILE,  fl_PACKAGE_EXPRESSIONS);  //after compilation, optimization  fl_ALL_REPLACE - turns off automatically
    flGetP(fl_PACKAGE_COMPILE_ADDR, 0, FS2);




    r=30.1;  Al=7.7; Bt=9.9; Gm=10.4;


    flResult(FS1); /// result in X1c,Y1c,Z1c
    flResult(FS2); /// result in X2c,Y2c,Z2c

    ShowResult("X1c=    :",X1c);
    ShowResult("X2c=    :",X2c);
    ShowResult("Y1c=    :",Y1c);
    ShowResult("Y2c=    :",Y2c);
    ShowResult("Z1c=    :",Z1c);
    ShowResult("Z2c=    :",Z2c);

    /// speed calculation this expression in mode    fl_ALL_REPLACE ~ in 2.5 above, than without it


//**************************************



   goto endc;

   //-------------------------------------------------------------------------------------------------------------------------

  /*********************************************************************************************************/
  /******************************* Examples of syntax managements ******************************************/
  /*********************************************************************************************************/



  /// (1)   Get function id on string name

  flSetFunction("pcmul(x1,x2: ext)=x1*x2",0,&idFP);
  flGetFunctionIDFP("pcmul",0,&idFP);
  flSetDiffTemplate(&idFP,"pcmul($dfarg1,$arg2)+pcmul($arg1,$dfarg2)");
   // or this:
  //flSetDiffTemplate(&idfP,'$dfarg1*$arg2+$arg1*$dfarg2');

  // pcmul(sin(x),cos(x))



  /// *********** (2) Redefinition sqrt  **************
  /// Set new function: "sqrtcx"

  flSetFunction("sqrtcx(x1: real): complex = if(x1 < 0, i*sqrt(|x1|)+0, sqrt(x1)+i*0)",0,&idFP);
  flSetFunction("sqrtcx(z1: complex): complex = sqrt(z1)",0,&idFP);

  flSetDiffTemplate(&idFP,"0.5*$dfarg1/sqrt($arg1)");  //sqrt($arg1) = sqrtcx($arg1)

  /// Add new name to "sqrtcx" : "sqrt"
  /// !!! not work due to conflict with sqrt_acc, has second name - 'sqrt'. Need also disable  "sqrt_acc"

  /// Disable  "sqrt_acc"
  flGetFuncIDN("sqrt_acc",IDN);
  idFP.idName =  IDN; idFP.idArg = fl_ANY;
  flChangeFunctionProperty(fl_DISABLE_FUNCTION,&idFP);

  /// Disable buil-in "sqrt"
  flGetFuncIDN("sqrt",IDN);
  idFP.idName =  IDN; idFP.idArg = fl_ANY;
  flChangeFunctionProperty(fl_DISABLE_FUNCTION,&idFP);

  /// Add new name to "sqrtcx" : "sqrt"
  flGetFuncIDN("sqrtcx",IDN);
  flAddNameFunction(IDN,"sqrt");


   //-------------------------------------------------------------------------------------------------------------------------



  /// *********** (3)  Redefinition power*************
  /// Set new function: "pwr".  All returned type is complex.

  flSetFunction("pwr(x,y: ext):complex= if( (x < 0) and ([y] <> y),(x+0i)^y,x^y+0i)",0,&idFP);
  flSetFunction("pwr(x: ext; z: Cxext):complex= x^z",0,&idFP);
  flSetFunction("pwr(z: Cxext; x: ext):complex= z^x",0,&idFP);
  flSetFunction("pwr(z1,z2: Cxext):complex= z1^z2",0,&idFP);

  flSetDiffTemplate(&idFP,"pwr($arg1,$arg2)*(($arg2)*($dfarg1)/($arg1)+($dfarg2)*ln($arg1+0i))");  //arg1+0i: arg1 may be < 0 or complex

  /// Add new name to "pwr" : "power"
  ///  !!! not work due to conflict with power_acc, has second name - 'power'. Need also disable  "power_acc"

  /// Disable  "power_acc"
  flGetFuncIDN("power_acc",IDN);
  idFP.idName =  IDN; idFP.idArg = fl_ANY;
  flChangeFunctionProperty(fl_DISABLE_FUNCTION,&idFP);

  /// Disable buil-in "power"
  flGetFuncIDN("power",IDN);
  idFP.idName =  IDN; idFP.idArg = fl_ANY;
  flChangeFunctionProperty(fl_DISABLE_FUNCTION,&idFP);

  /// Add new name to "pwr" : "power"
  flGetFuncIDN("pwr",IDN);
  flAddNameFunction(IDN, "power");
  flAddNameFunction(IDN,"pow");

  /// Associate symbol operation "^" with "pwr"
  idFP.idName = IDN;
  flChangeFunctionProperty(fl_SET_POWER_SYMBOL,&idFP);

  flCompile("x^y",0,FZ1);
  ShowResult(FZ1,"x^y"); /// x^y   =  x^y+0i


   //-------------------------------------------------------------------------------------------------------------------------



  /// ***************  (4)   Use both registers for names ******************
  flSet(fl_ENABLE,fl_SHOW_EXCEPTION,0); /// for show errors

  flSet(fl_DISABLE,fl_LEAD_TO_LOWER_CASE,0);
  testx1.re = 1.1; testx1.im = -1.1; testx2.re = 2.3;  testx2.im = -2.3;

  flSetVar("x1",&testx1,CxType);  /// CxType = fl_COMPLEX_EXTENDED; fl_COMPLEX_DOUBLE
  flSetVar("X1",&testx2,CxType);
  flSetFunction("tst(x: complex; X: complex):complex=x+X",0,&idFP);
  flSetFunction("TST(x: complex; X: complex):complex=x*X",0,&idFP);

  flCompile("x1+X1",0,FZ1);
  ShowResult(FZ1,"x1+X1");  /// = x1+X1

  flCompile("tst(x1,X1)",0,FZ1);
  ShowResult(FZ1,"tst(x1,X1)");   /// = x1+X1

  flCompile("TST(x1,X1)",0,FZ1);
  ShowResult(FZ1,"TST(x1,X1)");  /// = x1*X1




  /// Lead to Lower Case
  flSet(fl_ENABLE,fl_LEAD_TO_LOWER_CASE,0);

  flSetVar("x1",&testx1,CxType);
  flSetVar("X1",&testx2,CxType);  /// X1 set after x1 and recover x1 in lower case
  flSetFunction("tst(x: complex):complex=x+X",0,&idFP);
  flSetFunction("TST(X: complex):complex=x*X",0,&idFP);  ///  TST set after tst and recover tst in lower case




  flCompile("x1+X1",0,FZ1);
  ShowResult(FZ1,"x1+X1"); /// = X1+X1

  flCompile("TST(X1)",0,FZ1);
  ShowResult(FZ1,"TST(X1)"); /// = X1*X1

  flCompile("tst(x1)",0,FZ1);
  ShowResult(FZ1,"tst(x1)"); /// = X1*X1



   //-------------------------------------------------------------------------------------------------------------------------



  ///*********** (5)    Rename image unit  ******************

  flSetNameImUnit("ii");
  flSetVar("i",&ii,fl_REAL_INTEGER);
  ii = 100;
  flCompile("i*(1+2ii)",0,FZ1);
  ShowResult(FZ1,"i*(1+2ii)"); // i*(1+2ii)   =  100+200i

  flSetNameImUnit("i");  // return

  //-------------------------------------------------------------------------------------------------------------------------


   /// ************** (6)  Disable remove space in numbers and name of functions & variables   ***********

  flSet(fl_ENABLE,fl_CHECK_INCORRECT_SPACE,0);
  flSet(fl_ENABLE,fl_SHOW_EXCEPTION,0);  ///  for show errors
  flCompile("10.15 * ( 4 5. 87 - 2.12)",0,FZ1);   /// error in '4?5'
  flCompile("x * si n (x+1)",0,FZ1);              /// error in 'si?n'
  flCompile("x * sin (v d[n] + 1)",0,FZ1);        /// error in 'v?d'


    ///***** (7) Info about used vars.******
  flCompile("y:ext=1; x+y+vd[k]",0,FZ1);
  flGet(fl_PESENT_VAR,INT32(&x),Ans);       /// Ans= fl_YES
  flGet(fl_PESENT_VAR,INT32(&y),Ans);       /// Ans= fl_NO   // internal var 'y' rewrite global var 'y'
  flGet(fl_PESENT_VAR,INT32(adrVD),Ans);    /// Ans= fl_YES
  flGet(fl_PESENT_VAR,INT32(&k),Ans);       /// Ans= fl_YES



  /// ***** (8)  disable operation conj:'$' *****
  flGetOperation("$", &OpData);
  flSet(fl_DISABLE, fl_OPERATOR, OpData.IdOp);
  //flPerform(fl_DISABLE_OPERATOR,OpData.IdOp);



}

 endc:


   flSet(fl_DISABLE, fl_SHOW_EXCEPTION,0); /// don't show exception message from dll

   RefReshVar();
   RefReshArrays();

   srand(time( 0 ));

  cout <<  "" << endl;
  cout <<  "" << endl;
  cout <<  "" << endl;
return flLoad;
}


Extended GccIntMain()
{
 return  x*y+2*y*z-z*x;
};


Extended GccIntFY1()
{
 return  -2*x;
};


Extended GccIntFY2()
{
 return  x*x+1;
};


Extended GccIntFZ1()
{
 return  x-y;
};


Extended GccIntFZ2()
{
 return  x+y;
};






TFloatType  _cdecl sp1(TFloatType x1)
{
 return  x1*x1;
};


TFloatType  _stdcall sp2(TFloatType x1, TFloatType x2)
{
 return  x1-x2;
};


TFloatType  _cdecl sp3(TFloatType x1, TFloatType x2, TFloatType x3)
{
 return  x1+x2-x3;
};


TFloatType _cdecl sp8(TArrayE &vx, Int32 nx, Extended x, TArrayD &vd, Int32 nd, double d,  TArrayI &vi, Int32 ni)
{

return  (vx[nx]*x-vd[nd]*d)*vi[ni];

}





//********     same  functions for overloading complex: TComplexNum  ***********



TComplexNum  _cdecl sp8(TArrayE &vx, Int32 nx, TComplexNum z1, TArrayD &vd, Int32 nd, TComplexNum z2,  TArrayI &vi, Int32 ni)
{

return  (vx[nx]*z1-vd[nd]*z2)*vi[ni];

}


TComplexNum  __fastcall sp1(TComplexNum z1)
{

  return z1*z1;
}


TComplexNum  __fastcall sp2(TComplexNum z1, TComplexNum z2)
{

  return z1-z2;
}

TComplexNum  __fastcall sp2(TComplexNum z1, TFloatType x)
{

  return z1-x;
}


TComplexNum  __fastcall sp2(TFloatType x, TComplexNum z1)
{
 return x-z1;
}

TComplexNum  __fastcall sp3(TComplexNum z1, TComplexNum z2, TComplexNum z3)
{
  return z1+z2-z3;
}


TComplexNum  __fastcall sp3(TComplexNum z1, TFloatType x2, TComplexNum z3)
{
  return z1+x2-z3;
}


TComplexNum  __fastcall sp3( TFloatType x1, TComplexNum z2, TFloatType x3)
{
  return x1+z2-x3;
}






TComplexNum _cdecl spall(TArrayE &vx, _int32 nx, TComplexNum zx, TArrayD &vd, _int32 nd, double d, TComplexNum zd, Extended x, TArrayI &vi, _int32 ni)
{
//rez=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
//spall(ve,n,z1,vd,k,y,z2,x,vi,j) = (vd[k]*y*z2 - ve[n]*x*z1)*vi[j]
 TComplexNum rez;

 //spall(ve,n+3,z1,vd,j+k,x,z2+z3,t-y,vi,n+k+j)


 rez.re=(vd[nd]*d*zd.re-vx[nx]*x*zx.re)*vi[ni];
 rez.im=(vd[nd]*d*zd.im-vx[nx]*x*zx.im)*vi[ni];


return rez;


}





//********     same  functions for overloading complex: TComplexSTD  ***********



TComplexSTD  _cdecl sp8_std(TArrayE &vx, Int32 nx, TComplexSTD z1, TArrayD &vd, Int32 nd, TComplexSTD z2,  TArrayI &vi, Int32 ni)
{

 //return  (vx[nx]*z1-(TFloatType)(vd[nd])*z2)*(TFloatType)(vi[ni]);
 return  (TFloatType(vx[nx])*z1-TFloatType(vd[nd])*z2)*TFloatType(vi[ni]);
// return  (vx[nx]*z1-vd[nd]*z2)*vi[ni];

}


TComplexSTD  __fastcall sp1_std(TComplexSTD z1)
{

  return z1*z1;
}


TComplexSTD  __fastcall sp2_std(TComplexSTD z1, TComplexSTD z2)
{

  return z1-z2;
}

TComplexSTD  __fastcall sp2_std(TComplexSTD z1, TFloatType x)
{

  return z1-x;
}


TComplexSTD  __fastcall sp2_std(TFloatType x, TComplexSTD z1)
{
 return x-z1;
}

TComplexSTD  __fastcall sp3_std(TComplexSTD z1,TComplexSTD z2, TComplexSTD z3)
{
  return z1+z2-z3;
}


TComplexSTD  __fastcall sp3_std(TComplexSTD z1, TFloatType x2, TComplexSTD z3)
{
  return z1+x2-z3;
}


TComplexSTD  __fastcall sp3_std( TFloatType x1, TComplexSTD z2, TFloatType x3)
{
  return x1+z2-x3;
}






TComplexSTD _cdecl spall_std(TArrayE &vx, _int32 nx, TComplexSTD zx, TArrayD &vd, _int32 nd, double d, TComplexSTD zd, Extended x, TArrayI &vi, _int32 ni)
{
//rez=(vd[nd]*d*zd - vx[nx]*x*zx)*vi[ni]
//spall(ve,n,z1,vd,k,y,z2,x,vi,j) = (vd[k]*y*z2 - ve[n]*x*z1)*vi[j]
 TComplexSTD rez;

 rez=(TFloatType(vd[nd]*d)*zd - TFloatType(vx[nx]*x)*zx)*TFloatType(vi[ni]);

 //spall(ve,n+3,z1,vd,j+k,x,z2+z3,t-y,vi,n+k+j)


 //rez.re=(vd[nd]*d*zd.re-vx[nx]*x*zx.re)*vi[ni];
 //rez.im=(vd[nd]*d*zd.im-vx[nx]*x*zx.im)*vi[ni];


return rez;


}




TComplexNum   Gccfnc1(TComplexNum z1, TComplexNum z2, _int32 n, TFloatType x)
{
  return z1+z2+n*x;
}



TComplexNum    Gccfnc2(TComplexNum z1, TComplexNum z2, _int32 n, TFloatType x)
{
  return z1*z2+(i*n+x);
}




                      /// arithmetic expressions:



TFloatType GccES2AR()
{
 return x*(y-t)-y*(t-x)+t*(y-x);
 };


TFloatType GccES1AR()
{
 return (A*x-B*y+C)*(C*(y-B*t+B)-x)-C*y*(A-x*t);
 };


TFloatType GccE1AR()
{
 return y*(x*t+y)*(x+y*t)-(x*(y-x)+y*(t-y)+t*(x-t))-(x-y)*(y-t)*(t-x)*(x+y)*(y+t)*(x+t)*(y*x-t);
 };


TFloatType GccE1R()
{
 return  -(-x*(-1/x-y*(-(-y-t/(-y/(-x*(-y-x-t))-y/(x*y-t*(-x-(-x/(-t))-1/(-1/(-x))-y-x/(-t-y*(t*(-y*t-t*(-x))-x))))))))-t*y*(-y/(-t)))*(-y-x*(-t/(-y/(x-y*(-x*t))-t/(-x*(-y-(-t-(-y+x)/x)*y)/(-t-y))-x/(-y-(x*(-t*(-y/(-x*(-y-x-t/(-y-t))))))))));
};


TFloatType GccE2R()
{
 return x*y/(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))*(2.3*x/t-2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7)*(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5)))));
};



TFloatType GccE2PR()
{
 return (-A/(-x)-(-B-y/(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))))/(-x*y/(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))));

}

///with const subexpr.
TFloatType GccE2RCM()
{
 //return  (A*y*(B-C*A)*C-B*x*(C-A*B)*A)*((-A*(B-C*(C*B-A*B*x)))*x*C*A-B*y*x*A*C)*(A*(B-C)*x-y*(A*x*B-y*C*x)-(-C-A*(-B*(-x*B*C*y-y*A*(A-B*C*A)))))*(A*x*C*(B*C-C*(B*A-C*(B*A-C*B))))/(A*x*B*(A*C-B*(A-C))-C*y*B*(B-A*C-(-C*(-B-A)*B)*(-C+A)));
 return (A*y*(B-C*A)*C-B*x*(C-A*B)*A)*((-A*(B-C*(C*B-A*B*x)))*x*C*A-B*y*x*A*C)*(A*(B-C)*x-y*(A*x*B-y*C*x)-(-C-A*(-B*(-x*B*C*y-y*A*(A-B*C*A)))))*(A*x*C*(B*C-C*(B*A-C*(B*A-C*B))))/(A*x*B*(A*C-B*(A-C))/((A*B*C/(A+B-x)))-C*y*B*(B-A*C-(-C*(-B-A)*B)*(-C+A))/(C*y*A*(A/C-C/(A-B))-B*x*C/(C-B-A)));
};


TFloatType GccE2RC()
{
 return  (A*y*(B-C/A)*C-B*x/(C-A/B)*A)*((-A/(B-C/(C/B-A*B*x)))*x/C/A-B/y/x/A/C)*(A*(B-C)/x-y/(A*x/B-y/C/x)-(-C-A/(-B/(-x/B/C/y-y*A/(A-B/C*A)))))/(A*x*C/(B*C-C/(B/A-C/(B/A-C/B))))*(A*x*B/(A/C-B/(A-C))-C/y*B/(B-A/C-(-C/(-B-A)/B)/(-C+A)));
};


///with common subexpr.
TFloatType GccE3SR()
{
 return  x*(y/(x/y-y/x)-x/(x*y/(x+y)+t/(y/x-x/(x+y)))+t*(-y/(t/(x-y)-x*y/(x+y))+x*y*t/(x/(x+y)-y/(x+y))))*(x/(x/(x-y)-y/(t/(y/x-x/(x+y))+y/(t/(x-y)-x*y/(x+y))))-y/(x*y*t/(x/(x+y)-y/(x+y))-y/(x/y-y/x)))/(x/(x-y)+y/(x/(x/y-y/x)+x/(x*y/(x+y)+t/(y/x-x/(x+y)))));;
};


///with common subexpr.
TFloatType GccE3ASR()
{
  return ((x*y*(x*t+y*t*(-x*y*t+x*t*((x/y-y/t+y*t/(x/t-x*y*(x*t-y)))/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x)+x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+y*t/(x*t/(x*y+t)-x*y*(x*t-y))))))/(x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+((y/t-x*y*t/(x/y-y/t))*(x/y-x*y*t/((x*y+t)*(y*t-x)-y*t/(x*t-y)))*(y*t/(x/t-x*y*(x*t-y))))/((x/t-x/(y*t-x))*(x/y-y/t+y*t/(x/t-x*y*(x*t-y)))*(y*t/(x*t/(x*y+t)-x*y*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))));
}


///with common subexpr.
TFloatType GccE4SR()
{
 return  (2.1*x/(3.2*y-1.1*x+t)-1.1/(3.2*x*y-1.5)+5.7/(2.1/(x+2.4)-1.4/(y+1.2))-x/(-1.1/(1.5*x*y-3.7)+x*y/(1.2*x+2.3*y+3.3*t-4.5)))*(-y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4))-t/(1.4/(y+1.2)+1.1/(3.2*x*y-1.5)))/(x*(1.1/(1.5*x*y-3.7)-2.1*x/(3.2*y-1.1*x+t))+y*(x*y/(1.2*x+2.3*y+3.3*t-4.5)+y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4)))-5.7/(2.1/(x+2.4)-1.4/(y+1.2)));;
};




///with common subexpr.
TFloatType GccE4ASR()
{
 return (((B/x-D/t)*(C/y-B/t)+(C/x-D/t+B/y)/(A*x/(C/t-B/(D*y-C*t)))+(B/x-D/t)*(C/y-B/t))*((A*t-D*y)*(B*(C/x-B/y)-D*(B/t-D/x))/(D*x*y*t-B*(C*x-A*t)-C*(D*y*t-C*x))))*((A*(A*x+B*y)-B*(A*y-B*x-C*t)+C*(A*t-B*x+C*y))/((A*x*y-B*t)*(B*t*x-C*y)-(D*x-B*y)/(B*t+C*y))+((D*x-B)*(A*y-C)*(D*t-C*x-A*y)/(A*x*y-B*t*x)+(B*y+C*x)/(C*t-B*y)-(A*x+B)/(C*y+D))/((A*x+B)*(B*y+C)+(B*y+C*x)/(C*t-B*y)-(A*x+B)/(C*y+D)))/(((B/x-D/t)*(C/y-B/t)+(C/x-D/t+B/y)/(A*x/(C/t-B/(D*y-C*t)))+(B/x-D/t)*(C/y-B/t))*((A*t-D*y)*(B*(C/x-B/y)-D*(B/t-D/x))/(D*x*y*t-B*(C*x-A*t)-C*(D*y*t-C*x)))+(A*(A*x+B*y)-B*(A*y-B*x-C*t)+C*(A*t-B*x+C*y))/((A*x*y-B*t)*(B*t*x-C*y)-(D*x-B*y)/(B*t+C*y))+((D*x-B)*(A*y-C)*(D*t-C*x-A*y)/(A*x*y-B*t*x)+(B*y+C*x)/(C*t-B*y)-(A*x+B)/(C*y+D))/((A*x+B)*(B*y+C)+(B*y+C*x)/(C*t-B*y)-(A*x+B)/(C*y+D)));
};



///with constant & common subexpr.
TFloatType GccE4SRC()
{
 return (A*B*C*x/(B/C-C/D)-D*B*A*y/(C/D-B/A)-C*A*D*t/(A/C-B/D))/((A+B)*(B-D)*x/(A+B-C)-(A-B)*(B+D)*y/(A-B-D)+(C-B)*(B-D)*t/(B-C-A)+(A*(B-C)*x/(B*(A-B)*y/(B-C)-C*(C-D)*t/(A+D))-B*(B-D)*y/(C*(A+C)*x/(C-A)-B*(C+D)*t/(A-D))+C*(B-A)*t/(D*(B+C)*x/(B+D)-D*(D-C)*y/(B-C)))+((A*(B*D+C*A)*x-D*(A*D+C*B)*y-B*(A*C-D*B)*t)/(C*B*(A-B)/x-C*D*(A-C)/y-A*B*(A+D)/t)+((A+B)*x/(C-D)-(B+C)*y/(A-D)-(A+C)*t/(D-B))-((A*C-B*D)*t/(A+B)-(A*B-C*D)*y/(D+A)-(B*C-B*A)*x/(B-C))))-(A*(B-C)*x/(B*(A-B)*y/(B-C)-C*(C-D)*t/(A+D))-B*(B-D)*y/(C*(A+C)*x/(C-A)-B*(C+D)*t/(A-D))+C*(B-A)*t/(D*(B+C)*x/(B+D)-D*(D-C)*y/(B-C))+(A+B)*(B-D)*x/(A+B-C)-(A-B)*(B+D)*y/(A-B-D)+(C-B)*(B-D)*t/(B-C-A))+(A*B*C*x/(B/C-C/D)-D*B*A*y/(C/D-B/A)-C*A*D*t/(A/C-B/D))*((A*C-B*D)*t/(A+B)-(A*B-C*D)*y/(D+A)-(B*C-B*A)*x/(B-C))/((A*(B*D+C*A)*x-D*(A*D+C*B)*y-B*(A*C-D*B)*t)+(C*B*(A-B)/x-C*D*(A-C)/y-A*B*(A+D)/t)+(A+B)*x/(C-D)-(B+C)*y/(A-D)-(A+C)*t/(D-B));
};



TFloatType GccE2R_Diffdxdy_Long()
{
    /**
        Long expression , consisting from 29731 symbols, there are symbolic derivative  2rd order of GccE2R: d2/(dxdy) (GccE2R)
        There are many common subexpr.
    **/

   return
   (x*y/(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))*(-((2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7))*((((5.8)*((t)*(2.6)))*(sqr(y+1.7))-(2*(y+1.7))*(((5.8)*((t)*(2.6)))*(y+1.7)))/sqr(sqr(y+1.7))-
((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*(((x-1.5)*(((((5.7*y-7.4)*(4.7))*(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*
(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-
(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*
(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+
9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*
(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))+
(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*
(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))*((4.7)*(5.7))-((1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+
(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/
(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*
(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/
sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+
1.7)-9.4))))))*((4.7*x-1.1)*(5.7))+((4.7*x-1.1)*(5.7*y-7.4))*((((2.4*t)*(-((8.1*y)*(((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*
((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))*((t)*((-2.5*y-5.7)*((9.9*
(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))+((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1)*(-(2.1))))+((t)*((7.3-2.1*y)*(2.1)))*((9.9*
(2.1*x-1.2))*(4.9))+((2.1*x*(7.3-2.1*y)*t-7.1)*(((9.9)*(2.1))*(4.9))+((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))*((t)*((2.1*x)*(-(2.1))))))))+((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*
(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))*(-(2.5))))-((1-(-(1/(t-1.7)+
(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))+(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t)*((((3.6)*(-((((8.3)*((-1.2*t-1)*((2.8)*(-(1.5)))))*(sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7))-(2*(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)*((-1.2*t-1)*(2.8*(-1.5*x+3.1))))*
(((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)))/sqr(sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))))*(sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(2*(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)-9.4)*(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7))))*((1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)))*(3.6)))/sqr(sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))*(sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))-(2*(x-y*2.8-3.6/
(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))*(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/
(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))*(((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+
(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*
((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*
x*(-2.5*y-5.7)*t)))/sqr(sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))+((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-
7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))*(8.1))))*(sqr(3.8-
7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-
(2*(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))*
(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*
(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/
sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*
(8.1))))*((-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+
(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*
(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/
sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)))/sqr(sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*
x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))))*(sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*
x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))-(2*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))*(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+
8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-
7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*
(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))*(((5.7*y-7.4)*
(4.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)-9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*
((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+
(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*
(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4))))/sqr(sqr(x-2.7*y-1.7-2.4*t/
(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))-
((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/
(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*
((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*
(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*
x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*
t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*
x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))*(sqr(x-1.5))/sqr(sqr(x-1.5)))+((-3.1)/sqr(x+1.5)+((((((5.7*y-7.4)*
(4.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*
(-1.2*t-1)+1.7)-9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*
((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+
(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*
(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*
y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)-
((4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+
8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))/sqr(x-1.5)))*((2.8*x*(y+1.1))*(3.4)+(3.4*y+2.2)*(2.8*x))+((3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*
(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*
((3.4*y+2.2)*(2.8)+((y+1.1)*(2.8))*(3.4))+((3.4*y+2.2)*((y+1.1)*(2.8)))*(-(-((t)*(2.4))*(2.3*t)/sqr(2.4*y*t-1.7))+(((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+
9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/
(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+
8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+
(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/
sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*
((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+
8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)/sqr(x-1.5)))))))+(((3.6*x-1)-(3.6)*(x))/sqr(3.6*x-1)-((-4.1)/sqr(x))+(((5.8)*((t)*(2.6)))*(y+1.7)/sqr(y+1.7))-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*((-3.1)/
sqr(x+1.5)+((((((5.7*y-7.4)*(4.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+
8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-
(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*
(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)-((4.7*x-1.1)*
(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)-9.4)))))))/sqr(x-1.5)))+(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*
(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((3.4*y+2.2)*((y+1.1)*(2.8))))))*(-(-(3.6))*(2.5*x*(3.7*t-1))/sqr(2.7*x-3.6*y-4.7))+
((x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))))*(((((3.7*t-1)*(2.5))*(-(3.6)))*(sqr(2.7*x-3.6*y-4.7))-
(2*(2.7*x-3.6*y-4.7)*(-(3.6)))*(((3.7*t-1)*(2.5))*(2.7*x-3.6*y-4.7)-(2.7)*(2.5*x*(3.7*t-1))))/sqr(sqr(2.7*x-3.6*y-4.7)))+((((3.7*t-1)*(2.5))*(2.7*x-3.6*y-4.7)-(2.7)*(2.5*x*(3.7*t-1)))/sqr(2.7*x-3.6*y-4.7))*
(-(5.8*(2.6*x*t-1.7))/sqr(y+1.7)-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*(-(-((t)*(2.4))*(2.3*t)/sqr(2.4*y*t-1.7))+(((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/
(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*
(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-
8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-
7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/
sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*
y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)/sqr(x-1.5)))+(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((2.8*x*(y+1.1))*(3.4)+(3.4*y+2.2)*(2.8*x))))))))+((2.3)*(t)/sqr(t)-
((2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7))*(((3.6*x-1)-(3.6)*(x))/sqr(3.6*x-1)-((-4.1)/sqr(x))+(((5.8)*((t)*(2.6)))*(y+1.7)/sqr(y+1.7))-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*((-3.1)/sqr(x+1.5)+((((((5.7*y-7.4)*(4.7))*
(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-
9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+
(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*
(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-
3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/
(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)-((4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-
7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))/sqr(x-1.5)))+(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+
(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*
(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((3.4*y+2.2)*((y+1.1)*(2.8))))))+(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/
(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-
9.4)))))/(x-1.5))))*((((3.7*t-1)*(2.5))*(2.7*x-3.6*y-4.7)-(2.7)*(2.5*x*(3.7*t-1)))/sqr(2.7*x-3.6*y-4.7))))*(((x)*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-((2.7*x)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+
(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4)))))*(x*y))/sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))+((2.3*x/t-2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7)*(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*
(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/
(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5)))))*((((y)*((2.7*x)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4)))))+(2.7*x*(-3.3*x*(4.4*y*
(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-(((2.7*x)*(-((3.3*x)*((4.4*y)*(2.9+((10.1)*(1.9))))+(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))*(3.3)))+(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))*(2.7))*(x)+(x*y)*((2.7*x)*
(-((3.3*x)*((2.9+((10.1)*(1.9)))*(4.4))+((3.3)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4)))))+((2.7)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4))))))))*
(sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))-(2*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))*((2.7*x)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4))))))*
((y)*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-((2.7*x)*(-((3.3*x)*((4.4*y)*(2.9+((10.1)*(1.9))))+(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))*(3.3)))+(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))*(2.7))*
(x*y)))/sqr(sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))))+(((y)*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-((2.7*x)*(-((3.3*x)*((4.4*y)*(2.9+((10.1)*(1.9))))+(4.4*y*(2.9*x+3.7*y+10.1*
(1.9*x+9.1*y)))*(3.3)))+(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))*(2.7))*(x*y))/sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))*(-((2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7))*(-(5.8*(2.6*x*t-1.7))/
sqr(y+1.7)-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*(-(-((t)*(2.4))*(2.3*t)/sqr(2.4*y*t-1.7))+(((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*
(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-
9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*
(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*
(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*
(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)/sqr(x-1.5)))+
(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-
3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((2.8*x*(y+1.1))*(3.4)+(3.4*y+2.2)*(2.8*x)))))+(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*
(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/
(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))))*(-(-(3.6))*(2.5*x*(3.7*t-1))/sqr(2.7*x-3.6*y-4.7)))));

};


TFloatType GccE2PR_Diffdxdy_Long()
{
    /**
        Long expression , consisting from 54412 symbols, there are symbolic derivative  2rd order of GccE2PR: d2/(dxdy) (GccE2PR)
        There are many common subexpr.
    **/

   return
  -((((-(-(-(-(-(-1)*(B)/sqr(-x))-(((B)*(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/
(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))-(-(-(-(-(-(D)-(-(-1-(-(-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(-(-(((-(C)-
(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/
sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/
sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*
(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*
(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/
(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/
(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x))/sqr(-B/(-C/y-B/
(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(D)/sqr(-y-B/
(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*
(y)/sqr(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/
(-B-x/(-A/y))))))))))))))*(-(((x)*(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))-(-(((-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))-(-(-(-(-(-1)*(C)/sqr(-y-B)))*(B)/sqr(-A-C/(-y-B)))-
((D)*(-((C)*(-((y)*(-((x)*(-(((-C-D*(-y/(-x-D)))-(-((D)*(-(1/(-x-D)))))*(y))/sqr(-C-D*(-y/(-x-D)))))))+(-x*(-y/(-C-D*(-y/(-x-D)))))))))))*(y))/sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*(x*y))/
sqr(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))))+(-x*y/(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*((((-(-(-(-1)*(B)/sqr(-x))-(((B)*(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/
(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))-(-(-(-(-(-(D)-(-(-1-(-(-(((-(C))*
(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(-(-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-
(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/
sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/
(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/
(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/
(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x))/sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/
(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(D)/sqr(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-
C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))+(y)*(-((((D)*(-((((B)*(-(-(-(-(C)/sqr(y))-(-(-(-(-(-(-(-(-(B))*
(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/
(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/
(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/
(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/
(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/sqr(-D-(-C*x-
(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))-((B*x)*((((B)*((((B)*((((C)*((((D)*(-((((-(C))*(-(B)))*(sqr(-A*x-B*y-A))-(2*(-A*x-B*y-A)*(-(B)))*((-(C))*
(-A*x-B*y-A)-(-(A))*(C*(-x))))/sqr(sqr(-A*x-B*y-A)))-(-((((B)*(1/(sqr(x))))*(sqr(-y/x))-(2*(-y/x)*(-(1/(x))))*((-(-(y)/sqr(x)))*(B)))/sqr(sqr(-y/x))))))*(sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(2*(-C*(-x)/(-A*x-B*y-A)-B/
(-y/x))*(-(-(-(B))*(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x))))*((-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)))/sqr(sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-
(-((((-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/
sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/
(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*
(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/
(-x-C))/(-y/(-B-x/(-A/y))))))*(C)+(C*y)*(-((((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/
sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-
(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/
sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))+(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))*(-((((-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*
(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))+(y)*((((B)*((-1)*(sqr(-B-x))/sqr(sqr(-B-x))-(((-(-(-(-(-1-(-(-1)*(x)/
sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y))))-((x)*((((B)*((((D)*(-(((-1)*(sqr(-A-x-y))-(-(2*(-A-x-y)))*((-A-x-y)-(-1)*(x)))/sqr(sqr(-A-x-y)))))*(sqr(-y-x/(-A-x-y)))-(2*(-y-x/(-A-x-y))*(-1-(-(-1)*(x)/
sqr(-A-x-y))))*((-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)))/sqr(sqr(-y-x/(-A-x-y)))))*(sqr(-D/(-y-x/(-A-x-y))))-(2*(-D/(-y-x/(-A-x-y)))*(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y)))))*((-(-(-(((-A-x-y)-(-1)*(x))/
sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)))/sqr(sqr(-D/(-y-x/(-A-x-y)))))))*(sqr(-C-B/(-D/(-y-x/(-A-x-y)))))-(2*(-C-B/(-D/(-y-x/(-A-x-y))))*(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/
(-A-x-y))))))*((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)))/sqr(sqr(-C-B/(-D/(-y-x/(-A-x-y))))))))*(sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y))))))-(2*(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))*(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y)))))))*((-(-(-1)*(y)/
sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)))/sqr(sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y))))))))*(sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-(2*(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))*(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/
(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))))*((-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/
(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)))/sqr(sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-(-(-1-
(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x)))))-((x)*((((D)*((((C)*(-(((-((-(D))*(-x)/sqr(-x))-((x)*((D)*(sqr(-x))/sqr(sqr(-x)))))*(sqr(-D*(-y)/(-x)))-
(2*(-D*(-y)/(-x))*(-((-(D))*(-x)/sqr(-x))))*((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x)))/sqr(sqr(-D*(-y)/(-x))))))*(sqr(-x/(-D*(-y)/(-x))))-(2*(-x/(-D*(-y)/(-x)))*(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x)))))*
((-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)))/sqr(sqr(-x/(-D*(-y)/(-x))))))*(sqr(-y-C/(-x/(-D*(-y)/(-x)))))-(2*(-y-C/(-x/(-D*(-y)/(-x))))*(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/
(-x))))*(C)/sqr(-x/(-D*(-y)/(-x))))))*((-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)))/sqr(sqr(-y-C/(-x/(-D*(-y)/(-x))))))))*(sqr(-D/(-y-C/(-x/(-D*(-y)/
(-x))))))-(2*(-D/(-y-C/(-x/(-D*(-y)/(-x)))))*(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x)))))))*((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-
(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)))/sqr(sqr(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))))))-((-(((((-D/(-x-C))-(-(-(-1)*(D)/
sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-(-(((-B/
(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/
(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/
(-x))))))*(x)/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))+(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))*(-((((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/
(-x-C)))*(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))-((x/(-D/(-x-C)))*((((-(1/(-A/y)))+(y)*(-(-(-(-(A)/sqr(y)))*(1)/sqr(-A/y))))*(sqr(-B-x/(-A/y)))-(2*(-B-x/(-A/y))*(-(-(-(-(A)/sqr(y)))*
(x)/sqr(-A/y))))*((-(1/(-A/y)))*(y)))/sqr(sqr(-B-x/(-A/y))))))*(sqr(-y/(-B-x/(-A/y))))-(2*(-y/(-B-x/(-A/y)))*(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y)))))*((((-D/(-x-C))-(-(-(-1)*(D)/
sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))))/sqr(sqr(-y/(-B-x/(-A/y))))))))*(sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(2*(-y-x/(-D/(-x-C))/(-y/(-B-x/
(-A/y))))*(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y))))))*((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-
(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/
(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/
(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))))/sqr(sqr(-y-x/(-D/(-x-C))/
(-y/(-B-x/(-A/y))))))))*(sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))-(2*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))*(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/
sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*
(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-
(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/
(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*((-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/
sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-
((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/
(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/
(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)))/sqr(sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))-(2*(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/
(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(-(-(-(-(-(B))*(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/
(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/
sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-
((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/(-x/
(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/
(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*((-1-(-(-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(-(-(((-(C)-
(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/
sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/
(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/
(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)))/sqr(sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-
B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/
(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))-(2*(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/
(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(-(-(-(-(-(-(-(B))*(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x)))*(D)/
sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(-(((-(-(((-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/
sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/
(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/
(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/
(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*((-(D)-(-(-1-(-(-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-
(-(-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/
sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/
sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/
sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/
sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/
(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)))/sqr(sqr(-D*x-C/(-x-D/
(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(sqr(-C/y-B/(-D*x-C/(-x-D/
(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))-(2*(-C/y-B/(-D*x-C/(-x-D/
(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(-(-(C)/sqr(y))-(-(-(-(-(-(-(-(-(B))*
(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/
(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/
(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/
sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/
sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/
sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-
(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/
(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*((-(-(-(D)-(-(-1-(-(-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-
(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(-(-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*
(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/
(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/
(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/
(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/
(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/
(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)))/sqr(sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/
(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))*(sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/
(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))-(2*(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/
(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(-(-(-(-(C)/sqr(y))-(-(-(-(-(-(-(-(-(B))*(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-
(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/
(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/(-x/
(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/
(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*((B)*(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/
(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))-(-(-(-(-(-(D)-(-(-1-(-(-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/
(-y/x)))-(-(-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*
(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/
sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/
sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/
sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/
(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/
(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x)))/sqr(sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/
(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))))*(sqr(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))-(2*(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/
(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(-1-(-(-(-(-(-(C)/sqr(y))-(-(-(-(-(-(-(-(-(B))*(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*
(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-
(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/
sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/
sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/
sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x)/sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))*((-(-(-1)*(B)/sqr(-x))-(((B)*(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))-(-(-(-(-(-(D)-(-(-1-(-(-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*
(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(-(-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/
(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-
D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-
(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/
(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/
(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*
(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*
(B*x))/sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/
(-A/y)))))))))))*(D)))/sqr(sqr(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/
(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))))*(sqr(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/
(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))))-(2*(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))*(-(-1-(-(-(-(-(-(C)/sqr(y))-(-(-(-(-(-(-(-(-(B))*(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/
(-A*x-B*y-A)-B/(-y/x)))-(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*
(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/
(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/
(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/
(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/
(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/
(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x)/sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/
(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(D)/sqr(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))*((-(-(-(-1)*(B)/sqr(-x))-(((B)*(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-
A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))-(-(-(-(-(-(D)-(-(-1-(-(-(((-(C))*(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/
(-A*x-B*y-A)-B/(-y/x)))-(-(-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/
(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*
(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*
(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*
(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/
(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/
(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x))/sqr(-B/(-C/y-
B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(D)/sqr(-y-B/
(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*
(y)))/sqr(sqr(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/
(-y/(-B-x/(-A/y))))))))))))))-((-(((y)*(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))-(-(-(-((D)*(-((C)*(-((y)*(-((x)*(-(-(-((D)*(-(-(-1)*(y)/sqr(-x-D)))))*(y)/sqr(-C-D*(-y/(-x-D)))))+(-y/(-C-D*(-y/
(-x-D))))))))))))*(y)/sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*(x*y))/sqr(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))))*(-(((-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/
(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))-(-(-1-(-(-(-(-(-(C)/sqr(y))-
(-(-(-(-(-(-(-(-(B))*(C*(-x))/sqr(-A*x-B*y-A))-(-(-(1/(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(((C)*(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/
(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))-(-(((-(-(((-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-(-(-(-(1/(-B-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x)/
sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y))/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-((A)*(-((B)*(-(-(-(-(-1-(-(-(-(-((-(D))*(-x)/sqr(-x)))*(x)/sqr(-D*(-y)/(-x))))*(C)/
sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x)/sqr(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-1-(-(-(((-B-x/(-A/y))-(-(-(-(-(A)/sqr(y)))*(x)/sqr(-A/y)))*(y))/sqr(-B-x/
(-A/y))))*(x/(-D/(-x-C)))/sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y))/sqr(-D-(-C*x-(-y/
(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/
(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x)/sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/
(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(D)/sqr(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(y))/sqr(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-
(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))))+(-B-y/(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/
(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))))*(-((((y)*(-(((-B/(-A-C/(-y-B))-
D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))-(-(-(-(-(-1)*(C)/sqr(-y-B)))*(B)/sqr(-A-C/(-y-B)))-((D)*(-((C)*(-((y)*(-((x)*(-(((-C-D*(-y/(-x-D)))-(-((D)*(-(1/(-x-D)))))*(y))/sqr(-C-D*(-y/(-x-D)))))))+(-x*(-y/(-C-D*(-y/
(-x-D)))))))))))*(y))/sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))+(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))-((-(-(-((D)*(-((C)*(-((y)*(-((x)*(-(-(-((D)*(-(-(-1)*(y)/
sqr(-x-D)))))*(y)/sqr(-C-D*(-y/(-x-D)))))+(-y/(-C-D*(-y/(-x-D))))))))))))*(y)/sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*(x)+(x*y)*((((-((D)*(-((C)*(-((y)*(-((x)*(-(-(-((D)*(-(-(-1)*(y)/
sqr(-x-D)))))*(y)/sqr(-C-D*(-y/(-x-D)))))+(-y/(-C-D*(-y/(-x-D))))))))))))+(y)*(-((D)*(-((C)*(-((y)*(-((x)*((((-((D)*(-(-(-1)*(y)/sqr(-x-D)))))+(y)*(-((D)*((-1)*(sqr(-x-D))/sqr(sqr(-x-D))))))*(sqr(-C-D*(-y/(-x-D))))-
(2*(-C-D*(-y/(-x-D)))*(-((D)*(-(1/(-x-D))))))*((-((D)*(-(-(-1)*(y)/sqr(-x-D)))))*(y)))/sqr(sqr(-C-D*(-y/(-x-D)))))+(-(((-C-D*(-y/(-x-D)))-(-((D)*(-(1/(-x-D)))))*(y))/sqr(-C-D*(-y/(-x-D)))))))+(-((x)*(-(-(-((D)*
(-(-(-1)*(y)/sqr(-x-D)))))*(y)/sqr(-C-D*(-y/(-x-D)))))+(-y/(-C-D*(-y/(-x-D)))))))))))))*(sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))-(2*(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))*
(-(-(-(-(-1)*(C)/sqr(-y-B)))*(B)/sqr(-A-C/(-y-B)))-((D)*(-((C)*(-((y)*(-((x)*(-(((-C-D*(-y/(-x-D)))-(-((D)*(-(1/(-x-D)))))*(y))/sqr(-C-D*(-y/(-x-D)))))))+(-x*(-y/(-C-D*(-y/(-x-D))))))))))))*((-((D)*(-((C)*(-((y)*
(-((x)*(-(-(-((D)*(-(-(-1)*(y)/sqr(-x-D)))))*(y)/sqr(-C-D*(-y/(-x-D)))))+(-y/(-C-D*(-y/(-x-D))))))))))))*(y)))/sqr(sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))))*(sqr(-y/(-B/(-A-C/(-y-B))-D*
(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))-(2*(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))*(-(((-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))-(-(-(-(-(-1)*(C)/sqr(-y-B)))*(B)/
sqr(-A-C/(-y-B)))-((D)*(-((C)*(-((y)*(-((x)*(-(((-C-D*(-y/(-x-D)))-(-((D)*(-(1/(-x-D)))))*(y))/sqr(-C-D*(-y/(-x-D)))))))+(-x*(-y/(-C-D*(-y/(-x-D)))))))))))*(y))/sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/
(-x-D)))))))))))*((y)*(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))-(-(-(-((D)*(-((C)*(-((y)*(-((x)*(-(-(-((D)*(-(-(-1)*(y)/sqr(-x-D)))))*(y)/sqr(-C-D*(-y/(-x-D)))))+(-y/(-C-D*(-y/(-x-D))))))))))))*
(y)/sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*(x*y)))/sqr(sqr(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))))))*(sqr(-x*y/(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/
(-x-D)))))))))))-(2*(-x*y/(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*(-(((x)*(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))-(-(((-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/
(-x-D))))))))-(-(-(-(-(-1)*(C)/sqr(-y-B)))*(B)/sqr(-A-C/(-y-B)))-((D)*(-((C)*(-((y)*(-((x)*(-(((-C-D*(-y/(-x-D)))-(-((D)*(-(1/(-x-D)))))*(y))/sqr(-C-D*(-y/(-x-D)))))))+(-x*(-y/(-C-D*(-y/(-x-D)))))))))))*(y))/
sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*(x*y))/sqr(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))))*((-(-(-(-(-(-1)*(B)/sqr(-x))-(((B)*(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/
(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))-(-(-(-(-(-(D)-(-(-1-(-(-(((-(C))*
(-A*x-B*y-A)-(-(A))*(C*(-x)))/sqr(-A*x-B*y-A))-(-(-(-(y)/sqr(x)))*(B)/sqr(-y/x)))*(D)/sqr(-C*(-x)/(-A*x-B*y-A)-B/(-y/x)))-(-(-(((-(C)-(-(-(-(-(-(-(-1)*(y)/sqr(-B-x))-(((-C-B/(-D/(-y-x/(-A-x-y))))-(-(-(-(-(-(((-A-x-y)-
(-1)*(x))/sqr(-A-x-y)))*(D)/sqr(-y-x/(-A-x-y))))*(B)/sqr(-D/(-y-x/(-A-x-y)))))*(x))/sqr(-C-B/(-D/(-y-x/(-A-x-y))))))*(B)/sqr(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))*(y)/sqr(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y)))))))-
((A)*(-((B)*(-(((-D/(-y-C/(-x/(-D*(-y)/(-x)))))-(-(-(-(-(-(((-D*(-y)/(-x))-(-(-(-1)*(D*(-y))/sqr(-x)))*(x))/sqr(-D*(-y)/(-x))))*(C)/sqr(-x/(-D*(-y)/(-x)))))*(D)/sqr(-y-C/(-x/(-D*(-y)/(-x))))))*(x))/sqr(-D/(-y-C/
(-x/(-D*(-y)/(-x))))))))))))*(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))-(-(((((-D/(-x-C))-(-(-(-1)*(D)/sqr(-x-C)))*(x))/sqr(-D/(-x-C)))*(-y/(-B-x/(-A/y)))-(-(-(-(1/(-A/y)))*(y)/sqr(-B-x/(-A/y))))*(x/(-D/(-x-C))))/
sqr(-y/(-B-x/(-A/y)))))*(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x))))))))))/sqr(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))*(C*y)/sqr(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))*(C)/sqr(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))*(B)/sqr(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/
(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))*(B)/sqr(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/
(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))*(B*x))/sqr(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/
(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(D)/sqr(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/
(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))*(y)/sqr(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/
(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y))))))))))))))*
(-x*y/(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))-(-(((y)*(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))-(-(-(-((D)*(-((C)*(-((y)*(-((x)*(-(-(-((D)*(-(-(-1)*(y)/sqr(-x-D)))))*
(y)/sqr(-C-D*(-y/(-x-D)))))+(-y/(-C-D*(-y/(-x-D))))))))))))*(y)/sqr(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))*(x*y))/sqr(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D)))))))))))*
(-B-y/(-C-(-D/(-y-B/(-x)-B*x/(-B/(-C/y-B/(-D*x-C/(-x-D/(-C*(-x)/(-A*x-B*y-A)-B/(-y/x))-C*y/(-D-(-C*x-(-y/(-B/(-y/(-B-x)-x/(-C-B/(-D/(-y-x/(-A-x-y))))))-A*(-B*(-C-x/(-D/(-y-C/(-x/(-D*(-y)/(-x)))))))))/
(-y-x/(-D/(-x-C))/(-y/(-B-x/(-A/y)))))))))))))))/sqr(sqr(-x*y/(-y/(-B/(-A-C/(-y-B))-D*(-C*(-y*(-x*(-y/(-C-D*(-y/(-x-D))))))))))));

};

                                               /// indexing array
TFloatType GccA5R()
{
 return  (x*vd[n+1]*ve[k+n]-y*vd[2*n+1]*ve[k+3*n]+t*vi[2*k+n+1])*(t*vd[4*n+k-3]*ve[j+5]+x*ve[5*n+3*k-4]*vd[j+k-n]-y*vi[2*j+k-1]*ve[5*j+3*k*n-2*j*k*n+4*k+15]);
};




TFloatType GccA6R()
{
     INT32 i,j,L;
     double avr,res;


L = vd.size()-1;
     //L = 99;
     res = 0;
     for(i=0; i <= L; i++)
     {
          if(vd[i] > 0)
          {
             for(j=0; j <= L; j++)
               {
                 if((j > i)&&(vd[j] > vd[i]))
                    {
                        res=res-x*vd[j-i];
                    }
                    else
                    {
                        res=res+x*vd[j];
                    };

               }
          }
          else
          {
              res=res-y*vd[L-i];
         }
     };

  return res;

};



TFloatType GccA6FR()
{
     INT32 i,j,L;
     double avr,res;


L = vdf.size()-1;
     //L = 99;
     res = 0;
     for(i=1; i <= L; i++)  /// in C++ count from 1  !! (if array in Foreval as "fast connect")
     {
          if(vdf[i] > 0)
          {
             for(j=1; j <= L; j++)  /// in C++ count from 1  !! (if array in Foreval as "fast connect")
               {
                 if((j > i)&&(vdf[j] > vdf[i]))
                    {
                        res=res-x*vdf[j-i+1];  /// in C++ count from 1  !! (if array in Foreval as "fast connect")
                    }
                    else
                    {
                        res=res+x*vdf[j];

                    };

               }
          }
          else
          {
              res=res-y*vdf[L+1-i];  /// in C++ count from 1  !! (if array in Foreval as "fast connect")
         }
     };

  return res;

};




TFloatType GccA6VU()
{
     INT32 k,L;
     TFloatType s;


     L = vu1.size();

     s = 0;
     for(k=1; k <= L-2; k++)
     {
         vu1[k]=(vu2[k-1]*x+y*vu3[k+1])-vu1[k-1];
     };


     for(k=0; k <= L-1; k++)
     {
        if(vu2[k]+x > vu3[k]+y)
        {
          s=s+x*vu1[k]; x = vu2[k]; y = vu3[k];
        }
        else
        {
          s=s-y*vu1[k]; x = vu3[k]; y = vu2[k];
        }

     };



  return s/L;

};




void RandSizeMatrixAndFillRandElem()
{
    /*

    */
    INT32       rmin,rmax,k;
    Pointer32   pdest,psrc;



    M1u.resize(LenSCM1u*LenSCM1u);
    M1ux.resize(LenSCM1u*LenSCM1u);
    M1uy.resize(LenSCM1u*LenSCM1u);
    flSetLength(adrM1u,   VType, LenSCM1u*LenSCM1u);
    flSetLength(adrM1ux,  VType, LenSCM1u*LenSCM1u);
    flSetLength(adrM1uy,  VType, LenSCM1u*LenSCM1u);

    Ptr0M1u=&M1u[0]; Ptr0M1ux=&M1ux[0]; Ptr0M1uy=&M1uy[0]; ///set new refers to arrays (for Foreval) after their resize



   //rmin=-SizeRandElem; rmax=SizeRandElem;
   rmin=0; rmax=SizeRandElem;


   for (k = 0; k <=  LenSCM1u*LenSCM1u-1; k++)
   {

      M1ux[k] = (double)rand()/(double) RAND_MAX*(rmax-rmin)+rmin;
      M1uy[k] = (double)rand()/(double) RAND_MAX*(rmax-rmin)+rmin;

   };

   /// copy Gcc arrays to Foreval ones
   #ifdef   EXTENDED_FLOAT
      psrc = &M1ux[0];
      pdest =(Pointer32)(*((PInteger)adrM1ux));
      flCopyArrayExtDSC(pdest, psrc, 12,10,LenSCM1u*LenSCM1u);

      psrc = &M1uy[0];
      pdest =(Pointer32)(*((PInteger)adrM1uy));
      flCopyArrayExtDSC(pdest, psrc, 12,10,LenSCM1u*LenSCM1u);
   #else
      psrc = &M1ux[0];
      pdest =(Pointer32)(*((PInteger)adrM1ux));
      flCopyArrayDbl(pdest, psrc, LenSCM1u*LenSCM1u);

      psrc = &M1uy[0];
      pdest =(Pointer32)(*((PInteger)adrM1uy));
      flCopyArrayDbl(pdest, psrc, LenSCM1u*LenSCM1u);
   #endif

};




void RandSizeMatrixAndFillRandElemS4()
{
    /*

    */
    INT32       rmin,rmax,ic;
    Pointer32   pdest,psrc;



    LenSCM1u = 4;
    M1u.resize(LenSCM1u*LenSCM1u);
    M1ux.resize(LenSCM1u*LenSCM1u);
    M1uy.resize(LenSCM1u*LenSCM1u);
    flSetLength(adrM1u,   VType, LenSCM1u*LenSCM1u);
    flSetLength(adrM1ux,  VType, LenSCM1u*LenSCM1u);
    flSetLength(adrM1uy,  VType, LenSCM1u*LenSCM1u);



M1ux[0]=0;     M1ux[1]=1;      M1ux[2]=-1;      M1ux[3]=3 ;
M1ux[4]=2;     M1ux[5]=1;      M1ux[6]=0;       M1ux[7]= 0 ;
M1ux[8]=-2;    M1ux[9]=4;      M1ux[10]=5;      M1ux[11]=1;
M1ux[12]=3;    M1ux[13]= 2;    M1ux[14]= 1;     M1ux[15]= 0;


   for (k = 0; k <=  LenSCM1u*LenSCM1u-1; k++)
   {
      M1uy[k] = M1ux[k];
   };



   #ifdef   EXTENDED_FLOAT
      psrc = &M1ux[0];
      pdest =(Pointer32)(*((PInteger)adrM1ux));
      flCopyArrayExtDSC(pdest, psrc, 12,10,LenSCM1u*LenSCM1u);

      psrc = &M1uy[0];
      pdest =(Pointer32)(*((PInteger)adrM1uy));
      flCopyArrayExtDSC(pdest, psrc, 12,10,LenSCM1u*LenSCM1u);
   #else
      psrc = &M1ux[0];
      pdest =(Pointer32)(*((PInteger)adrM1ux));
      flCopyArrayDbl(pdest, psrc, LenSCM1u*LenSCM1u);

      psrc = &M1uy[0];
      pdest =(Pointer32)(*((PInteger)adrM1uy));
      flCopyArrayDbl(pdest, psrc, LenSCM1u*LenSCM1u);
   #endif


};



void SetMatrixDetMulExpr()
{

   ExprA6VDU = ""
   " D1:ext=1; Z:ext=1; k:int=0; i:int=0; j:int=0; m:int=0;   E:int=0;"
   " T:ext=0;  S:ext=0;"
   "L:int=LenSCM1u;"
   "Hi:int=L-1;"
   "for(i=0 , Hi ,"
     "for(j=0, Hi ,"
         "S=0;"
         "for(m=0 , Hi ,"
             "S=S+M1ux[i*L+m]*M1uy[m*L+j];"
            ");"
         "M1u[i*L+j]=S;"
        ");"
     ");"
  "D1=1; Z=1; E=0;"
  "for(k=0,Hi,"
      "ifp(M1u[k*L+k]=0,"
          "E=0;"
          "for(n=k, Hi,"
             "ifp(M1u[n*L+k] <> 0,"
                 "for(m=0 , Hi ,"
                      "swap(M1u[k*L+m],M1u[n*L+m]);"
                     "); "
                 "goto (endxch);"
                ");"
            "); "
          "for(n=k , Hi ,"
            "ifp(M1u[k*L+n] <> 0 ,"
                "for(m=0 , Hi ,"
                     "swap(M1u[m*L+k],M1u[m*L+n]);"
                   "); "
                "goto (endxch);"
               ");"
             ");"
          "E=1;"
          "endxch >>"
          "ifp(E = 1,  goto (endp));"
          "Z=-Z;"
         ");"
      "T=M1u[k*L+k];"
      "D1=D1*T;"
      "T=1/T;"
      "for(i=k , Hi ,"
         "for(j=k , Hi ,"
            "ifp(i=k , M1u[i*L+j]=M1u[i*L+j]*T ,"
                   " ifp(j>k,  M1u[i*L+j]=M1u[i*L+j]-M1u[i*L+k]*M1u[k*L+j]);"
                ");"
           " ); "
        " ); "
     "); "
    "endp>>"
    "ifp(E = 1 , D1=0);"
    "D=D1*Z;"
    "D";

#ifdef   EXTENDED_FLOAT


  ExprA6VDUP =""
  "D1:ext=1; Z:ext=1; k:int=0; i:int=0; j:int=0; m:int=0;   E:int=0;"
  "T:ext=0;  S:ext=0; sw:Ext=0;"
  "L:int=LenSCM1u;"
  "Hi:int=L-1;"
  "for(i=0 , Hi ,"
     "for(j=0, Hi ,"
         "S=0;"
         "for(m=0 , Hi ,"
             "S=S+PExtended(Ptr0M1ux+ExtCS*i*L+ExtCS*m)*PExtended(Ptr0M1uy+ExtCS*m*L+ExtCS*j);"
            ");"
         "PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)=S;"
         ");"
      ");"
  "D1=1; Z=1; E=0;"
  "for(k=0,Hi,"
      "ifp(PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*k)=0 ,"
          "E=0;"
          "for(n=k, Hi,"
             "ifp(PExtended(Ptr0M1u+ExtCS*n*L+ExtCS*k)<>0,"
                 "for(m=0 , Hi ,"
                      "sw=PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*m);"
                      "PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*m)=PExtended(Ptr0M1u+ExtCS*n*L+ExtCS*m);"
                      "PExtended(Ptr0M1u+ExtCS*n*L+ExtCS*m)=sw;"
                     ");"
                 "goto (endxch);"
                ");"
            ");"
          "for(n=k , Hi ,"
            "ifp(PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*n) <> 0 ,"
                "for(m=0 , Hi ,"
                      "sw=PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*k);"
                      "PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*k)=PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*n);"
                      "PExtended(Ptr0M1u+ExtCS*m*L+ExtCS*n)=sw;"
                   ");"
                "goto (endxch);"
               ");"
             ");"
          "E=1;"
          "endxch >>"
          "ifp(E = 1,  goto (endp));"
          "Z=-Z;"
         ");"
      "T=PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*k);"
      "D1=D1*T;"
      "T=1/T;"
      "for(i=k , Hi ,"
         "for(j=k , Hi ,"
            "ifp(i=k , PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j) = PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)*T,"
                      "ifp(j>k,"
                           "PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)=PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*j)-PExtended(Ptr0M1u+ExtCS*i*L+ExtCS*k)*PExtended(Ptr0M1u+ExtCS*k*L+ExtCS*j)"
                         ");"
               ");"
            ");"
         ");"
     ");"
    "endp>>"
    "ifp(E = 1 , D1=0);"
    "D=D1*Z;"
    "D";

#else

  ExprA6VDUP =""
  "D1:ext=1; Z:ext=1; k:int=0; i:int=0; j:int=0; m:int=0;   E:int=0;"
  "T:ext=0;  S:ext=0; sw:Ext=0;"
  "L:int=LenSCM1u;"
  "Hi:int=L-1;"
  "for(i=0 , Hi ,"
     "for(j=0, Hi ,"
         "S=0;"
         "for(m=0 , Hi ,"
             "S=S+PDouble(Ptr0M1ux+DblCS*i*L+DblCS*m)*PDouble(Ptr0M1uy+DblCS*m*L+DblCS*j);"
            ");"
         "PDouble(Ptr0M1u+DblCS*i*L+DblCS*j)=S;"
         ");"
      ");"
  "D1=1; Z=1; E=0;"
  "for(k=0,Hi,"
      "ifp(PDouble(Ptr0M1u+DblCS*k*L+DblCS*k)=0 ,"
          "E=0;"
          "for(n=k, Hi,"
             "ifp(PDouble(Ptr0M1u+DblCS*n*L+DblCS*k)<>0,"
                 "for(m=0 , Hi ,"
                      "sw=PDouble(Ptr0M1u+DblCS*k*L+DblCS*m);"
                      "PDouble(Ptr0M1u+DblCS*k*L+DblCS*m)=PDouble(Ptr0M1u+DblCS*n*L+DblCS*m);"
                      "PDouble(Ptr0M1u+DblCS*n*L+DblCS*m)=sw;"
                     ");"
                 "goto (endxch);"
                ");"
            ");"
          "for(n=k , Hi ,"
            "ifp(PDouble(Ptr0M1u+DblCS*k*L+DblCS*n) <> 0 ,"
                "for(m=0 , Hi ,"
                      "sw=PDouble(Ptr0M1u+DblCS*m*L+DblCS*k);"
                      "PDouble(Ptr0M1u+DblCS*m*L+DblCS*k)=PDouble(Ptr0M1u+DblCS*m*L+DblCS*n);"
                      "PDouble(Ptr0M1u+DblCS*m*L+DblCS*n)=sw;"
                   ");"
                "goto (endxch);"
               ");"
             ");"
          "E=1;"
          "endxch >>"
          "ifp(E = 1,  goto (endp));"
          "Z=-Z;"
         ");"
      "T=PDouble(Ptr0M1u+DblCS*k*L+DblCS*k);"
      "D1=D1*T;"
      "T=1/T;"
      "for(i=k , Hi ,"
         "for(j=k , Hi ,"
            "ifp(i=k , PDouble(Ptr0M1u+DblCS*i*L+DblCS*j) = PDouble(Ptr0M1u+DblCS*i*L+DblCS*j)*T,"
                      "ifp(j>k,"
                           "PDouble(Ptr0M1u+DblCS*i*L+DblCS*j)=PDouble(Ptr0M1u+DblCS*i*L+DblCS*j)-PDouble(Ptr0M1u+DblCS*i*L+DblCS*k)*PDouble(Ptr0M1u+DblCS*k*L+DblCS*j)"
                         ");"
               ");"
            ");"
         ");"
     ");"
    "endp>>"
    "ifp(E = 1 , D1=0);"
    "D=D1*Z;"
    "D";

#endif

};



void CompileMatrixDetMulExpr(Pointer32 &AddrCmpl)
{
  flCompile(ExprA6VDU.c_str(),0,AddrCmpl);
};


void CompileMatrixDetMulExprP(Pointer32 &AddrCmpl)
{

  flCompile(ExprA6VDUP.c_str(),0,AddrCmpl);

};



TFloatType DetMulMxM1()
{
     INT32 Hi,k,i,n,m,L,E;
     Extended D,D1,Z,T,x,S;

    // label endxch, endp;

/*

  square matrices: M1u = M1ux*M1uy; return det(M1u)
  M1ux,M1uy are created with random size in [6,9] and are  filled random elements in [-10..10]
  LenSCM1u = sqrt(SizeOf(M1u)) = Number of String = Number of Column
  matrices placed in 1d arrays [0..LenSCM1u*LenSCM1u]
  read/write matrix element in 1d array M2[S,C] = M1[S*LenSCM1u + C]
*/

L=LenSCM1u;
Hi=L-1;



// M2u[j,k]  -> M1u[j*L+k]

for(i=0 ; i <= Hi;  i++)
{
  for(j=0 ; j <= Hi;  j++)
  {
   S=0;
   for(m=0 ; m <= Hi;  m++)
   {
    S=S+M1ux[i*L+m]*M1uy[m*L+j];
   };
   M1u[i*L+j]=S;
  };
};




 D1=1;
 Z=1;
 E=0;
 for(k=0 ; k <= Hi;  k++)
 {

  if (M1u[k*L+k] == 0)
  {
     E=0;
     // i <-> j //i=k; j=k
     for(n=k ; n <= Hi;  n++)
     {
       if( M1u[n*L+k] != 0)
       {
         for(m = 0 ; m <= Hi; m++)
         {
           x=M1u[k*L+m]; M1u[k*L+m]=M1u[n*L+m]; M1u[n*L+m]=x;
         };
         goto endxch;
       };
     };

     for(n=k ; n <= Hi;  n++)
     {

       if (M1u[k*L+n] != 0)
       {
          for(m=0 ; m <= Hi; m++)
          {
            x=M1u[m*L+k]; M1u[m*L+k]=M1u[m*L+n]; M1u[m*L+n]=x;
          };
          goto endxch;
       };
     };


     E=1;


     endxch:
     if (E == 1) {goto endp;};
     Z=-Z;
  };


  T=M1u[k*L+k];
  D1=D1*T;
  T=1/T;

  for(i=k ; i <= Hi; i++)
  {
   for(j=k ; j <= Hi; j++)
   {
    if (i == k ) {M1u[i*L+j]=M1u[i*L+j]*T;} else
     if (j > k) {M1u[i*L+j]=M1u[i*L+j]-M1u[i*L+k]*M1u[k*L+j];};
   };
  };

 };

 endp:
 if (E == 1){D1=0;};
 D=D1*Z;


 return D;
};






/**
   len: int = 50; c: int=0; s: dbl = 0; i:int = 0; l:int=0; r:int=len-1; bf: dbl=0;   vds: arrayDbl = len; for(i,0,len-1, vds[i] = rnd(1,100));
     while(l < r, for(i,l,r-1, if(vds[i] > vds[i+1], bf=vds[i]; vds[i] = vds[i+1]; vds[i+1] = bf)); dec(r); fordown(i,r,l+1, if(vds[i] < vds[i-1], bf=vds[i]; vds[i] = vds[i-1]; vds[i-1] = bf)); inc(l););
        for(i,0,len-2, if(vds[i] < vds[i+1], s=s+vds[i]; inc(c))); s = s+vds[len-1]; s
**/
/// len: int = len(vps);  s: dbl = 0; i:int = 0; l:int=0; r:int=len-1; bf: dbl=0; for(i,0,len-1, vps[i] = rnd(1,100)); while(l < r, for(i,l,r-1, if(vps[i] > vps[i+1], bf=vps[i]; vps[i] = vps[i+1]; vps[i+1] = bf)); dec(r); fordown(i,r,l+1, if(vps[i] < vps[i-1], bf=vps[i]; vps[i] = vps[i-1]; vps[i-1] = bf)); inc(l););    for(i,0,len-2, if(vps[i] < vps[i+1], s=s+vps[i]; )); s+vps[len-1];"

TFloatType GccA6PR()
{
     INT32 i,j,len,l,r;
     TFloatType bf,s;


     len = vps.size();
     l = 0; r = len-1; s = 0; i = 0; bf = 0;


     while(l < r)
     {
        for(i=l; i <= r-1; i++)
        {
            if (vps[i] > vps[i+1])
            {
                bf = vps[i];
                vps[i] = vps[i+1];
                vps[i+1] = bf;
            };

        };
        r--;

        for(i=r; i >= l+1; i--)
        {
            if (vps[i] < vps[i-1])
            {
                bf = vps[i];
                vps[i] = vps[i-1];
                vps[i-1] = bf;
            };

        };
        l++;

     };

     for(i=0; i <= len-2; i++)
     {
        if (vps[i] < vps[i+1])
        {
            s = s+ vps[i];
        };

     };


     return s+vps[len-1];

};



TFloatType GccIntegralF1()
{
 return Integral1(x,y);
};



                                                 /// polynom
TFloatType GccP7R()
{
       #ifdef   EXTENDED_FLOAT
          return  1.1*powl(x,12)-2.1*powl(x,11)-3.1*powl(x,10)+2.2*powl(x,9)-3.3*powl(x,8)-5.7*powl(x,7)+2.3*powl(x,6)-9.8*powl(x,5)+1.7*powl(x,4)+1.4*powl(x,3)-7.5*powl(x,2)+7.7*x+12.3;
       #else
          return  1.1*pow(x,12)-2.1*pow(x,11)-3.1*pow(x,10)+2.2*pow(x,9)-3.3*pow(x,8)-5.7*pow(x,7)+2.3*pow(x,6)-9.8*pow(x,5)+1.7*pow(x,4)+1.4*pow(x,3)-7.5*pow(x,2)+7.7*x+12.3;
       #endif
};


                                                  /// function
TFloatType GccF8R()
{
 #ifdef   EXTENDED_FLOAT
    return  sinl(cosl(x+y))*cosl(y*sinl(x-y))*(2.15*cosl(sinl(3.53*cosl(t-x)))-tanl(x+y)*(tanl(t+x)-cosl(sinl(t+y))*((1.76*asinl(x/(x+y))+2.97*acosl(y/(x+y)))*(2.12*atanl(x-y)*atan2l(x-y,x+y)-asinl(t/(x+y))*acosl(t/(y+x-t))/(atanl(x+y)+atan2l(t-x-y,x-t))))));
   #else
    return  sin(cos(x+y))*cos(y*sin(x-y))*(2.15*cos(sin(3.53*cos(t-x)))-tan(x+y)*(tan(t+x)-cos(sin(t+y))*((1.76*asin(x/(x+y))+2.97*acos(y/(x+y)))*(2.12*atan(x-y)*atan2(x-y,x+y)-asin(t/(x+y))*acos(t/(y+x-t))/(atan(x+y)+atan2(t-x-y,x-t))))));
  #endif
};

/// mixed
TFloatType GccF9R()
{
    #ifdef   EXTENDED_FLOAT
       return  (powl(x-sinl(x),y-cosl(y))/(tanl(1.5*asinl(1.1*x/(1.2*x+y))))+powl(y-sinl(x*1.2)/cosl(y+1.1),n+k)/(x+2.1*y))*(2.1*sinhl(x/y)*sinl(x+y)-3.2*coshl(x/(x+y)*cosl(x-y))-tanhl(y/(x+y))/(expl(2.1*x/y))*asinl(1.1*x/(2.1*x+y))-2.1*atanl(1.1*x-y)*atan2l(x-y,1.3*x+y));
    #else
       return  (pow(x-sin(x),y-cos(y))/(tan(1.5*asin(1.1*x/(1.2*x+y))))+pow(y-sin(x*1.2)/cos(y+1.1),n+k)/(x+2.1*y))*(2.1*sinh(x/y)*sin(x+y)-3.2*cosh(x/(x+y)*cos(x-y))-tanh(y/(x+y))/(exp(2.1*x/y))*asin(1.1*x/(2.1*x+y))-2.1*atan(1.1*x-y)*atan2(x-y,1.3*x+y));
    #endif

};

                                         /// function with common subexpr.
/// trig. func.
TFloatType GccF10SR()
{
  #ifdef   EXTENDED_FLOAT
       return  (cosl(x*sinl(x))*sinl(y*cosl(y))-sinl(cosl(x*cosl(x+y)))*cosl(y*cosl(x*sinl(x*y))))*(cosl(sinl(y)*y+x*cosl(x))*sinl(x*sinl(x+y))-cosl(y*cosl(x*y))*sinl(x*cosl(x+y))+sinl(y*cosl(x*sinl(x*y)))*sinl(cosl(x*cosl(x+y)))/(sinl(x*sinl(x))*cosl(y*cosl(y))+cosl(cosl(x*cosl(x+y)))*sinl(sinl(y)*y+x*cosl(x))-sinl(y*cosl(x*sinl(x*y)))*sinl(cosl(x*cosl(x+y)))));
   #else
       return  (cos(x*sin(x))*sin(y*cos(y))-sin(cos(x*cos(x+y)))*cos(y*cos(x*sin(x*y))))*(cos(sin(y)*y+x*cos(x))*sin(x*sin(x+y))-cos(y*cos(x*y))*sin(x*cos(x+y))+sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))/(sin(x*sin(x))*cos(y*cos(y))+cos(cos(x*cos(x+y)))*sin(sin(y)*y+x*cos(x))-sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))));
  #endif


};


/// mixed
TFloatType GccF11SR()
{
  #ifdef   EXTENDED_FLOAT
    return (sinl(x/(x+y))-sinhl(x/(x+y))*asinl(x/(x+y)))*(coshl(x/(x+y))*acosl(x/(x+y))+cosl(x/(x+y)))*(tanhl(x/(x+y))-expl(x/(x+y)));
   #else
    return (sin(x/(x+y))-sinh(x/(x+y))*asin(x/(x+y)))*(cosh(x/(x+y))*acos(x/(x+y))+cos(x/(x+y)))*(tanh(x/(x+y))-exp(x/(x+y)));
  #endif


};



TFloatType GccF12SR()
{
    /*
 #ifdef   EXTENDED_FLOAT
    return (powl(sinl(x+y),k+2*n)*powl(cosl(x*y),n+k)-powl(x-sinl(x*y),powl(cosl(x*y),n+k))*powl(y-cosl(x+y),powl(sinl(x+y),k+2*n)))/(y-sinl(powl(x-sinl(x),y-cosl(y)))/cosl(powl(x-sinl(x),y-cosl(y)))) ;
   #else
    return (pow(sin(x+y),k+2*n)*pow(cos(x*y),n+k)-pow(x-sin(x*y),pow(cos(x*y),n+k))*pow(y-cos(x+y),pow(sin(x+y),k+2*n)))/(y-sin(pow(x-sin(x),y-cos(y)))/cos(pow(x-sin(x),y-cos(y)))) ;
  #endif
  */


  #ifdef   EXTENDED_FLOAT
    //return cosl(powl(sinl(x+y),k+2*n)*powl(cosl(x*y),n+k)-powl(x-sinl(x*y),powl(cosl(x*y),n+k))*powl(y-cosl(x+y),powl(sinl(x+y),k+2*n)))/(sinl(powl(sinl(x+y),k+2*n))/cosl(powl(cosl(x*y),n+k))-sinl(powl(x-sinl(x),y-cosl(y)))/cosl(powl(x-sinl(x),y-cosl(y)))) ;
    //return cosl(powl(sinl(x+y),k+2*n-10)*powl(cosl(x*y),n+k-7)-powl(x-sinl(x*y),powl(cosl(x*y),n+k-7))*powl(y-cosl(x+y),powl(sinl(x+y),k+2*n-10)))/(sinl(powl(sinl(x+y),k+2*n-10))/cosl(powl(cosl(x*y),n+k-7))-sinl(powl(x-sinl(x),y-cosl(y)))/cosl(powl(x-sinl(x),y-cosl(y)))) ;
    return (powl(x-sinl(x*y),powl(cosl(x*y),n+k-7))/powl(y-cosl(x+y),powl(sinl(x+y),k+2*n-10))-powl(sinl(x+y),k+2*n-10)*powl(cosl(x*y),n+k-7))/(cosl(powl(cosl(x*y),n+k))/sinl(powl(sinl(x+y),k+2*n))+cosl(powl(x-sinl(x),y-cosl(y)))/sinl(powl(x-sinl(x),y-cosl(y))));

   #else
    //return cos(pow(sin(x+y),k+2*n)*pow(cos(x*y),n+k)-pow(x-sin(x*y),pow(cos(x*y),n+k))*pow(y-cos(x+y),pow(sin(x+y),k+2*n)))/(sin(pow(sin(x+y),k+2*n))/cos(pow(cos(x*y),n+k))-sin(pow(x-sin(x),y-cos(y)))/cos(pow(x-sin(x),y-cos(y)))) ;
    //return (pow(sin(x+y),k+2*n-10)*pow(cos(x*y),n+k-7)-pow(x-sin(x*y),pow(cos(x*y),n+k-7))*pow(y-cos(x+y),pow(sin(x+y),k+2*n-10)))/(sin(pow(sin(x+y),k+2*n-10))/cos(pow(cos(x*y),n+k-7))-sin(pow(x-sin(x),y-cos(y)))/cos(pow(x-sin(x),y-cos(y)))) ;
    return (pow(x-sin(x*y),pow(cos(x*y),n+k-7))/pow(y-cos(x+y),pow(sin(x+y),k+2*n-10))-pow(sin(x+y),k+2*n-10)*pow(cos(x*y),n+k-7))/(cos(pow(cos(x*y),n+k))/sin(pow(sin(x+y),k+2*n))+cos(pow(x-sin(x),y-cos(y)))/sin(pow(x-sin(x),y-cos(y))));

  #endif

 };



TFloatType GccF12CR()
{

  #ifdef   EXTENDED_FLOAT
    return A*cosl(sinl(C*powl(A/C,C/(A-B*C))/(B-C))*x+cosl(A/expl(A/B)*y+B/powl(A-B,A/(C*sinl(A*B/C)))))*powl(sinl(A*B/(A-C))+cosl(C/(A/B-B/C)),x/y);
   #else
    return A*cos(sin(C*pow(A/C,C/(A-B*C))/(B-C))*x+cos(A/exp(A/B)*y+B/pow(A-B,A/(C*sin(A*B/C)))))*pow(sin(A*B/(A-C))+cos(C/(A/B-B/C)),x/y);
  #endif

 };


                            /// external functions.
TFloatType GccFE13R()
{
 return sp3(x-sp3(sp1(y/x),sp3(x+y,x+t,y+t)-2.1*sp2(sp1(t*1.25),1.1-sp2(sp1(1.1+x),y-sp3(x+1.2,y+1.3,t+1.4))),t-sp2(sp3(x-y,y-t,t-x),sp2(2.1-x,3.2-y))),y-sp3(-x*1.51,-2.79*y,t-sp3(-t+2.75,x*y*2.71,-y-sp2(3.6*t-y*sp2(t-y*1.11,-y+x*2.11),y-sp3(1.15*x-y,y*1.72,x*1.27)))),1.51*y-sp3(1.19*x,-y+1.17,-t-1.97)*sp3(sp2(x*2.73,1.96*y),-sp2(-x*1.95,y/(x-1.77)),-sp3(y+1.89,7.98-t,-x-2.98)));
};


TFloatType GccFE14R()
{
  return sp8(ve,j+3,t+sp8(ve,n+2,y-sp8(ve,k+3,x-y,vd,j+n,y-sp8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-sp8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/sp8(ve,j,x+sp8(ve,k+n+2,t+sp8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+sp8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2);
};




TFloatType GccFE15R()
{
  return (sp3(x/y-sp2(x-y,x/y),x/sp2(x-y,x/y),sp1(x/y)*sp1(-sp1(y/x)))*sp1(x/y)-sp2(y/sp2(x-y,x/y),-x/sp2(x-y,x/y))*sp1(-sp1(y/x)))/(sp1(x/y-sp2(x-y,x/y))-sp2(x/sp2(x-y,x/y),y/sp2(x-y,x/y))+sp2(x-y,x/y)*sp3(x/y-sp2(x-y,x/y),x/sp2(x-y,x/y),sp1(x/y)*sp1(-sp1(y/x))));
}



TFloatType GccFE15RC()
{
  return sp2(sp3(A-B,B/C,C/(B-A))*A/sp2(sp2(B/sp1(A/(B+C)),B/(C+A)),A-B*C)*x/B,x/sp2(A*sp1(C/B),A/(B+A)))*sp3((C-A)*sp1(C/B)/sp2(B/(C+A/B),B/(C-A))*x/sp1(C/A),sp1(C/B)/sp1(B/A),x/sp2(B-C/A,C-B/C))*sp2(-A/(C+B/A),x/(A-B));;
}



TFloatType GccFE15AR()
{
  return sp3(-x/sp2(x/y,-t/x)-sp3(x/(x+y),t/(x-y),y/(x+t)),x/sp1(x/y)-y/sp2(t/y,y/(x+t)),-sp2(x/(x+y),t/(x-y))/sp3(x/y,y/(x+y+t),t/(t-x-y)))*sp2(x/sp1(x/y),sp2(x/(x+y),t/(x-y)))/(sp1(x/sp3(x/(x+y),t/(x-y),y/(x+t)))*sp3(x/y,y/(x+y+t),t/(t-x-y))-sp2(t/(t-x-y)-y/(x+t),y/(x+y+t)-t/(x-y))*(x/sp1(x/y)-y/sp2(t/y,y/(x+t)))/(sp2(x/sp1(x/y),sp2(x/(x+y),t/(x-y)))-sp1(sp3(x/y,y/(x+y+t),t/(t-x-y)))));
}


TFloatType GccFuncExR()
{
     TFloatType res;

//res = (2.1*x/(3.2*y-1.1*x+t)-1.1/(3.2*x*y-1.5)+5.7/(2.1/(x+2.4)-1.4/(y+1.2))-x/(-1.1/(1.5*x*y-3.7)+x*y/(1.2*x+2.3*y+3.3*t-4.5)))*(-y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4))-t/(1.4/(y+1.2)+1.1/(3.2*x*y-1.5)))/(x*(1.1/(1.5*x*y-3.7)-2.1*x/(3.2*y-1.1*x+t))+y*(x*y/(1.2*x+2.3*y+3.3*t-4.5)+y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4)))-5.7/(2.1/(x+2.4)-1.4/(y+1.2)));

     //res = x*(y*x+t*(-x-(-y-x*(-y/x+x*(x*y+y*(t+x)))/(-y*(x*y*t*(x+t)*(y+t)/(y/t+x/(t-y))))/(y*(y/(x+y+t)-x/(x*y+t/(y+x*(y-x))))-x*(t/(t-x)+y*x/(y-x*(t/y-t)-t*(x*(-t-y-x))))))));

     //res = x*y*(2.2*x+1)*(2.3*x*y/t-2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7)*(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*y*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*x*y*t-1.7)+(4.7*x-1.164)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.198*x-8.9/t+9.9*(2.1*x-1.261)*(3.1*x+4.9*y+5.8)*(2.1*x*y*t-7.1)*x*y*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*x*y*t+1.7)-9.4)))))/(x-1.5)))));

     //res = x*(y/(x/y-y/x)-x/(x*y/(x+y)+t/(y/x-x/(x+y)))+t*(-y/(t/(x-y)-x*y/(x+y))+x*y*t/(x/(x+y)-y/(x+y))))*(x/(x/(x-y)-y/(t/(y/x-x/(x+y))+y/(t/(x-y)-x*y/(x+y))))-y/(x*y*t/(x/(x+y)-y/(x+y))-y/(x/y-y/x)))/(x/(x-y)+y/(x/(x/y-y/x)+x/(x*y/(x+y)+t/(y/x-x/(x+y)))));



//res =  x*y-x/(x/y-t/y-(-x-y*(x*y-t*x/(x/y-t/y-(-x-(-y-(-t-(x*(y-t)-y*(-x*(-y-x)-y/(x+y*t)))*x)*y)/(x+y*(-t-x/t))-x*(y/t-(-y*(t/x)/(x-y/t)-(-x-(-y/(-x*(-x-y)*y)+x/y*(-(-t/y-x)*x+y*(-t/x)-x/(x-y/t))-x/(y-x-y/x)*(x/y+(-x/(-y+x)-t/y+x-y*(x/y-x/t)))))+x*(-y-t)*(-t-x+y)*(x+y/t))))))));

//     x*y*(2.251*x+1)*(2.243*x*y/t-2.353*x*(3.475*t-1)/(2.575*x-3.675*y-4.766)*(x/(3.767*x-1)-4.176/x+5.186*(2.866*x*y*t-1.766)/(y+1.876)-7.165*(2.874*x*(y+1.641)*(3.864*y+2.162)*(3.171/(x+1.765)-2.173*t/(2.174*x*y*t-1.171)+(4.171*x-1.164)*(5.172*y-7.174)/(x-2.175*y-1.747-2.174*t/(3.618-7.716*x-8.181*y*(4.612*x/(2.189*t+1.165)-7.198*x-8.149/t+9.912*(2.199*x-1.261)*(3.107*x+4.179*y+5.108)*(2.271*x*y*t-7.179)*x*y*t/(x-y*2.282-3.621/(x/(t-1.147)-7.198/(y+2.245)+8.233/(2.288*x*y*t+1.247)-9.174)))))/(x-1.525)))));
//        res =
 //    res = (x*y*t)/((y*x*t)/(x*t*y));
//        res = 2.12*x+3.56*y+t;
//res = (x*y+t*(x+y))/(x*t-y*x*t);
//        res = x*y+t*y*(x*y+y*t*(x*y+t*y*(x*y+y*t*(x*y+t*y*(x*y+y*t*(x*y+t*y*(x*y+y*t*(x*y+t*y*(x*y+y*t*(x*y+t*y*(x*y+y*t)))))))))));
 //       res = (x+0.1)*(y-0.01)+t*(y+0.01)*((x+0.2)*y+(y-0.2)*t*((x-0.3)*y+t*(y-0.3)*((x+0.4)*y+(y-0.4)*t*((x-0.5)*y+t*(y+0.5)*((x+0.6)*y+(y-0.6)*t*((x+0.7)*y+t*(y-0.7)*((x+0.8)*y+(y-0.8)*t*((x+0.9)*y+t*(y-0.9)*((x-0.11)*y+(y+0.11)*t*((x-0.12)*y+t*(y-0.12)*((x-0.13)*y+(y-0.14)*t)))))))))));
//        res = x*y+y*x*(t*y-x*t*(t*x+(x+y)*(x-y)*(y*t-x*(x+t)*((x-t)*y-y*(y+t)*((y-t)*t-t*(t-x)*(t*(t-y)-x*(y-x+t)*(x*(x-y-t)*t-y*(y*(x+y*t)*t+x*(t+y-x)))))))));
//        res = (y/x-x/(x+y)-y/(x-y)+t/(x/y+t+y/x)+x/(x/(x+y)-y/(x-t)))*(y/(x/y-x/(x+y))-t/(y/(x-t)+y/x-x/y))/(t/(t/(x/y+t+y/x)-y/(x-t))-x/(x/(x+y)-y/(x-t)));
//        res = x*y-x/(x/y-t/y-(-x-y*(x*y-t*x/(x/y-t/y-(-x-(-y-(-t-(x*(y-t)-y*(-x*(-y-x)-y/(x+y*t)))*x)*y)/(x+y*(-t-x/t))-x*(y/t-(-y*(t/x)/(x-y/t)-(-x-(-y/(-x*(-x-y)*y)+x/y*(-(-t/y-x)*x+y*(-t/x)-x/(x-y/t))-x/(y-x-y/x)*(x/y+(-x/(-y+x)-t/y+x-y*(x/y-x/t)))))+x*(-y-t)*(-t-x+y)*(x+y/t))))))));


// 		  res = x*y*t*(t*x*(x*y-t*x)-x*y*(x*t-y*t)+y*x*(y*x-t*y)-(x+y)*(x-y)*(t-y)*(x*y-t*x*(x-y*(t-x*(t-x)*(x-t)*(t-y)-x*y-y))))-(x*t*y*(x*y-x*(y-y*(t-t*(x-x*t*(x*y-t*x-(x*y-t*x)*(x-y)*(y-t)*(t-y)-(x+t*y)*(y-x*t)+(t-y*t)*(y-t*x))))))) ;
//		  res = -x/(x/y-t/(x+t)+x*y*(x*y-y*t+x/(x/(x+y)+y/(t+x))))*(y*(x-y/(x*y-y/(x*y+y*t)*(y*t-x*y)))+x-y*(x-t-t/(x-y)*(y/(y-t*(x+y*t)*(y-x*t)/(x*t-y*(x+t))))))*(x*y-t*y-t*(x*t-y*(t-x)/(x*y*t-x-y-t)));
//		  res = x*y*(2.111*x+1)*(2.211*x*y/t-2.311*x*(3.422*t-1)/(2.511*x-3.611*y-4.22)*(x/(3.711*x-1)-4.111/x+5.111*(2.611*x*y*t-1.23)/(y+1.12)-7.132*(2.812*x*(y+1.123)*(3.832*y+2.121)*(3.112/(x+1.123)-2.133*t))));
//		  res = x*y*(x-t*(2.123*x-3.222*y-5.323)/(t*x*y/(2.234-x*y)+(2.455*x+3.632)*(3.734*y-4.832*t-5.923)-(1.134-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.745*x-3.345*y-t))-y*(x*y-y*t*3.167+2.965*(x/t-t/(x-y*(2.467-x-y-t)))*(y-t)-2.376*x)*(y-x)-7.154/x)*(-1.943/t+x*y*t*5.334))-3.556*x-5.657)-7.243*y-3.459)/(x-t)+x*(t*y/(x-2.834*t)-y*(x*(t-2.756*y-x-5.676))));
//		  res = (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t)-t*(-x-y*(-t*(-x*(y-t))))))))))));
 //res=(sin(x/(x+y))-sinh(y/(x+y))*asin(x/(x+y)))*(cosh(y/(x+y))*acos(x/(x+y))+cos(x/(x+y)));
//		  res = x*y-x/(x/y-t/y-(-x-y*(x*y-t*x/(x/y-t/y-(-x-(-y-(-t-(x*y-y*(-x*y-y/(x+y*t)))*x)*y)/(x+y*t)-x*(y/t-(-y*x/(x-y*t)-(-x-(-y/(-x*y*(-x-y))+x/y*(y*x+y*t-x/(x+y*t))-x*y*(x*y+(-x*y-t/y+x-y*x)))))+x*y*t*(x+y*t)))))));
//		  res = x*y*(x-t*(2.154*x-3.253*y-5.353)/(t*x*y/(2.544-x*y)+(2.143*x+3.556)*(3.343*y-4.153*t-5.456)-(1.153-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.644*x-3.364*y-t))-y*(x*y-y*t*3.164+2.267*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.535/x)*(-1.253/t+x*y*t*5.353))-3.433*x-5.455)-7.466*y-3.577)/(x-t)+x*(t*y/(x-2.699*t)-y*(x*(t-2.767*y-x-5.854)-y*(-1.549-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.344/y-x*y*(2.435*x-1.456)*(t*y*3.326-5.347)*(1.943-x*y*t*3.245)*(x+y))))));
//		  res = (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t*(x-y*(t-x*y-y*(x*y-t*x)-t*(t*x+y))))-t*(-x-y*(-t*(-x*(y-t*(x*y*t-y*x*t*(-x*(y*x-t*y-x-y-t)))))))))))))));
//        res = (x*y+t/(x*y-y*t/x-x+y-t))*(x+y+t)/(x-y-t)*(t-x*(t-y/(x-y-t)))*x/y*t-x*t*(x*t-y*t+x-t)/(y*x+t*x+t/y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y/(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t/(x-y*(t-x*y-y/(x*y-t*x)-t/(t/x+y))))-t*(-x-y*(-t/(-x*(y-t*(x*y/t-y*x*t/(-x*(y*x-t*y-x-y-t)))))))))))))));
//		  res = x*y*(x-t*(2.156*x-3.652*y-5.653)/(t*x*y/(2.664-x*y)+(2.155*x+3.543)*(3.345*y-4.431*t-5.443)-(1.451-x)/(-t-y))+x*(y-(-x-(-y/(-t*x*(x*y*t*(2.453*x-3.353*y-t))-y*(x*y-y*t*3.153+2.253*(x/t-t/(x-y*(2.533-x-y-t)))*(y-t)-2.453*x)*(y-x)-7.553/x)*(-1.253/t+x*y*t*5.533))-3.453*x-5.453)-7.453*y-3.553)/(x-t)+x*(t*y/(x-2.653*t)-y*(x*(t-2.753*y-x-5.853)-y*(-1.539-x/(-t-y))/(x/y-x/(t/x-y/t)+t*(1/x-5.553/y-x*y*(2.535*x-1.53)*(t*y*3.536-5.753)*(1.539-x*y*t*3.665)*(x+y*(t-(-x-y*t/(x*y-2.863*(x*y*(x-y*(x*t+y/t*(2.623*x-1.352-t*y))))))))))))) ;
 //       res = x*y*(2.251*x+1)*(2.243*x*y/t-2.353*x*(3.475*t-1)/(2.575*x-3.675*y-4.766)*(x/(3.767*x-1)-4.176/x+5.186*(2.866*x*y*t-1.766)/(y+1.876)-7.165*(2.874*x*(y+1.641)*(3.864*y+2.162)*(3.171/(x+1.765)-2.173*t/(2.174*x*y*t-1.171)+(4.171*x-1.164)*(5.172*y-7.174)/(x-2.175*y-1.747-2.174*t/(3.618-7.716*x-8.181*y*(4.612*x/(2.189*t+1.165)-7.198*x-8.149/t+9.912*(2.199*x-1.261)*(3.107*x+4.179*y+5.108)*(2.271*x*y*t-7.179)*x*y*t/(x-y*2.282-3.621/(x/(t-1.147)-7.198/(y+2.245)+8.233/(2.288*x*y*t+1.247)-9.174)))))/(x-1.525)))));
//        res = (x/y+y/x)*(x/(x+y)-y/(x-y)-(t/(x/y-y/x))/(x/(y-t/(x/y-y/x)))-(y/(x-y)-t/(y/x-x/(x+y))+x/(x+y)));
//        res  = (x*y+t*(x*y-y*t*x-x+y-t))*(x+y+t)*(x-y-t)*(t-x*(t-y*(x-y-t)))*x*y*t-x*t*(x*t-y*t+x-t)*(y*x+t*x+t*y-y-x)*(x*t-y*(x-y*t-t-x)*(x-y-t)-y*(y+y*x-t-x)+t*(x*y-x*(t+y*(x*y-t*y*x-y*t*(y+x*(x-t+y*(x-y+t-x*(x*y-t*x)*(x*y-t*(x+y+t)*(x-y-t)-t*(-x-y*(-t*(-x*(y-t))))))))))));
//res = sp8(ve,j,t,vd,k,y,vi,j);
//res = sp8(ve,j+1,t+x,vd,k+2*j,y-t,vi,j+k+1);

//res = sp8(ve,j+3,t+sp8(ve,n,y-sp8(ve,k,x-y,vd,j+n,y-sp8(ve,k,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-sp8(ve,n,-x,vd,j+n-1,-y,vi,k+2*n-1)/sp8(ve,j,x+sp8(ve,k,t+sp8(ve,n,y-t,vd,j+n+1,y,vi,k+5),vd,n+3,x+sp8(ve,j+k,y,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,y,vi,n+2*k),vi,n+2);

res = (x*vd[n+1]*ve[k+n]-y*vd[2*n+1]*ve[k+3*n]+t*vi[k+n])*(t*vd[n+k+3]*ve[j+5]+x*ve[2*n+3*k+4]*vd[j+k-n]-y*vi[j+k-1]);

     // res = sp8(ve,n+3,x/sp8(ve,n+7,x-t,vd,j+3,-y+sp8(ve,k+3,-t,vd,j+3*k,x-sp8(ve,j+3,t,vd,j+n,t+x,vi,n+2*j),vi,k+j),vi,n+2*k),vd,j+k,x*sp8(ve,n+7,t/sp8(ve,j+6,x-t,vd,j+n-1,x-y,vi,n+3*k+j),vd,j+9,x+sp8(ve,n,t,vd,k,y,vi,j),vi,j+5),vi,n+k+j)/sp8(ve,k+3,t,vd,n+3,x,vi,k+2*j);
		   // pc8(ve,n+3,x/pc8(ve,n+7,x-t,vd,j+3,-y+pc8(ve,k+3,-t,vd,j+3*k,x-pc8(ve,j+3,t,vd,j+n,t+x,vi,n+2*j),vi,k+j),vi,n+2*k),vd,j+k,x*pc8(ve,n+7,t/pc8(ve,j+6,x-t,vd,j+n-1,x-y,vi,n+3*k+j),vd,j+9,x+pc8(ve,n,t,vd,k,y,vi,j),vi,j+5),vi,n+k+j)/pc8(ve,k+3,t,vd,n+3,x,vi,k+2*j);
		   // ms8(ve,n+3,x/ms8(ve,n+7,x-t,vd,j+3,-y+ms8(ve,k+3,-t,vd,j+3*k,x-ms8(ve,j+3,t,vd,j+n,t+x,vi,n+2*j),vi,k+j),vi,n+2*k),vd,j+k,x*ms8(ve,n+7,t/ms8(ve,j+6,x-t,vd,j+n-1,x-y,vi,n+3*k+j),vd,j+9,x+ms8(ve,n,t,vd,k,y,vi,j),vi,j+5),vi,n+k+j)/ms8(ve,k+3,t,vd,n+3,x,vi,k+2*j);
		   // ps8(ve,n+3,x/ps8(ve,n+7,x-t,vd,j+3,-y+ps8(ve,k+3,-t,vd,j+3*k,x-ps8(ve,j+3,t,vd,j+n,t+x,vi,n+2*j),vi,k+j),vi,n+2*k),vd,j+k,x*ps8(ve,n+7,t/ps8(ve,j+6,x-t,vd,j+n-1,x-y,vi,n+3*k+j),vd,j+9,x+ps8(ve,n,t,vd,k,y,vi,j),vi,j+5),vi,n+k+j)/ps8(ve,k+3,t,vd,n+3,x,vi,k+2*j);

		   //res=sp8(ve,j,t,vd,k,y,vi,j);
		   //res=sp1(x)*sp2(x,y)*sp3(x,y,t);
		  //res=sp1(-x)/(-(-(-1-sp2(-1-x,sp1(x))))-sp1(-sp1(-x)-1)*(2-sp2(-x,-1)*3))/(-sp1(sp1(-x)*2-3)*3-5)/(sp1(-x-1)*3-5)+(-(-sp1(-1-x))*(-(-(-sp1(-x)*2+5)))*(-sp1(x+1)))+sp1(2*sp1(-x-1)-1)-sp1(-1-x)/((sp1(2*sp1(-x-1)-1)*3-5)+(-(-(-sp1(-1+2*sp1(-x-1)))))-(-sp1(-2*sp1(-x-1)+1)-5)*(sp1(1-2*sp1(-x-1))))+(-sp1(2*sp1(-x-1)-1)-5)*(-2*sp1(1-2*sp1(-x-1))-3)/(sp1(-1+2*sp1(-x-1))*3-sp1(2*sp1(-x-1)-1)*5)/sp1(2*sp1(-x-1)-1)-(-sp1(2*sp1(-x-1)-1)/sp1(x+1))+sp2(-x,x)+2*sp2(x,-x)/(-sp2(-x-1,x+1)-5*sp2(x+1,-x-1)*sp1(sp2(x+1,-x-1)))*(sp1(sp2(x+1,-x-1))-sp1(sp2(1-2*sp1(-x-1),-1-x)))-sp2(x+1,2*sp1(-x)-1)/(-(-3*sp2(1-2*sp1(-x-1),-1-x)))*((-2*sp2(sp1(x+1)*2-1,-1-2*sp1(x+1))-(-5*sp2(-sp1(x+1)*2-1,1-sp1(-x-1)*2))))+(-sp2(-x,x)+(7-3*sp2(x,-x)-5)/(-sp2(-x-1,x+1))/sp2(x+1,-x-1))/(-9/sp2(1-2*sp1(-x-1),-1-x)-sp1(-7*sp2(x+1,2*sp1(-x)-1))-3)+(-sp1(-sp2(sp1(x+1)*2-1,-1-2*sp1(x+1))-7)+(3*sp2(-sp1(x+1)*2-1,1-sp1(-x-1)*2)-5));

//		  res=sp3(x*sp2(sp1(y-x),sp2(x-sp2(x*t,x-t),sp2(t*x,y+t))),sp1(t-y)+sp2(sp3(sp2(t-x-y,y*x),t,sp2(t-x,x-y)),sp3(sp3(x-y,y*x,y*t),x*sp2(t+y,y-t),t*sp1(x+y))),sp3(sp1(t+x),sp2(x+t*x,t*y),sp1(x+y+t)))
            //ps3(x*ps2(ps1(y-x),ps2(x-ps2(x*t,x-t),ps2(t*x,y+t))),ps1(t-y)+ps2(ps3(ps2(t-x-y,y*x),t,ps2(t-x,x-y)),ps3(ps3(x-y,y*x,y*t),x*ps2(t+y,y-t),t*ps1(x+y))),ps3(ps1(t+x),ps2(x+t*x,t*y),ps1(x+y+t)))
            //ms3(x*ms2(ms1(y-x),ms2(x-ms2(x*t,x-t),ms2(t*x,y+t))),ms1(t-y)+ms2(ms3(ms2(t-x-y,y*x),t,ms2(t-x,x-y)),ms3(ms3(x-y,y*x,y*t),x*ms2(t+y,y-t),t*ms1(x+y))),ms3(ms1(t+x),ms2(x+t*x,t*y),ms1(x+y+t)))
            //pc3(x*pc2(pc1(y-x),pc2(x-pc2(x*t,x-t),pc2(t*x,y+t))),pc1(t-y)+pc2(pc3(pc2(t-x-y,y*x),t,pc2(t-x,x-y)),pc3(pc3(x-y,y*x,y*t),x*pc2(t+y,y-t),t*pc1(x+y))),pc3(pc1(t+x),pc2(x+t*x,t*y),pc1(x+y+t)))

         //res = 1.1*pow(x,12)-2.*pow(x,11)-3.1*pow(x,10)+2.2*pow(x,9)-3.3*pow(x,8)-5.7*pow(x,7)+2.3*pow(x,6)-9.8*pow(x,5)+1.7*pow(x,4)+1.4*pow(x,3)-7.5*pow(x,2)+7.7*x+12.3;
//
            //res = 2.15*pow(x,12)-4.541*pow(x,11)-3.65*pow(x,10)+6.75*pow(x,9)+2.2*pow(x,8)-2.84*pow(x,7)+5.2*pow(x,6)-3.9*pow(x,5)+4.765*pow(x,4)+2.63*pow(x,3)+2.8*pow(x,2)+2.11*x+12.754;
//            res = (pow(x-1.5,2*n-3*k+1)*0.05-15.1*pow(t*x,n-2*k)-21.1*pow(y*t,k-3*n-7))/(2.1*pow(x+y,2*k+1)-y*pow(x-t,n+5))*(3.2*pow(x-y,n+k)-x*pow(t+x*y,n+k+2)) ;
//            res = sin(cos(x+y))*cos(y*sin(x-y))*(2.15*cos(sin(3.53*cos(t-x)))-tan(x+y)*(tan(t+x)-cos(sin(t+y))*((1.76*asin(x/(x+y))+2.97*acos(y/(x+y)))*(2.12*atan(x-y)*atan2(x-y,x+y)-asin(t/(x+y))*acos(t/(y+x-t))/(atan(x+y)+atan2(t-x-y,x-t))))));
//            res = (sin(x)+cos(sin(x)))/(cos(sin(x)+sin(x)));
             // res = (sin(x*cos(y)+y)*sin(y)-cos(y)*cos(x*cos(y)+y)-sin(x+y)*sin(x*cos(x+y)))*(sin(x*cos(y*sin(x*cos(x+y))))*cos(sin(x+y))-cos(y*sin(x*cos(x+y)))*cos(x*cos(y*sin(x*cos(x+y)))));

//            res = sp3(x-sp3(sp1(y),sp3(x+y,x+t,y+t)-2.1*sp2(sp1(t),1.1-sp2(sp1(1.1+x),y-sp3(x+1.2,y+1.3,t+1.4))),t-sp2(sp3(x-y,y-t,t-x),sp2(2.1-x,3.2-y))),y-sp3(-x,-y,t-sp3(-t,x,-y-sp2(t-sp2(t,-y+x),y-sp3(x-y,y,x)))),1.5*y-sp3(x,-y,-t)*sp3(sp2(x,y),-sp2(-x,t),sp3(y,t,x)));


 //res = (pow(x-sin(x),y-cos(y))/(tan(1.5*asin(1.1*x/(1.2*x+y))))+pow(y-sin(x*1.2)/cos(y+1.1),n+k)/(x+2.1*y))*(2.1*sinh(x/y)*sin(x+y)-3.2*cosh(x/(x+y)*cos(x-y))-tanh(x/(x+y))/(exp(2.1*x/y))*asin(1.1*x/(2.1*x+y))-2.1*atan(1.1*x-y)*atan2(x-y,1.3*x+y));


        //res =  (cos(x*sin(x))*sin(y*cos(y))-sin(cos(x*cos(x+y)))*cos(y*cos(x*sin(x*y))))*(cos(sin(y)*y+x*cos(x))*sin(x*sin(x+y))-cos(y*cos(x*y))*sin(x*cos(x+y))+sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))/(sin(x*sin(x))*cos(y*cos(y))+cos(cos(x*cos(x+y)))*sin(sin(y)*y+x*cos(x))-sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))));
         //res = (sin(x*cos(y)+y)*sin(y)-cos(y)*cos(x*cos(y)+y)-sin(x+y)*sin(x*cos(x+y)))*(sin(x*cos(y*sin(x*cos(x+y))))*cos(sin(x*y)+cos(x*y))-cos(y*sin(x*cos(x+y)))*cos(x*cos(y*sin(x*cos(x+y)))))*(cos(sin(x*y)+cos(x*y))*y-x*sin(sin(x*y)+cos(x*y)));




          // res = (cos(x*sin(x))*sin(y*cos(y))-sin(cos(x*cos(x+y)))*cos(y*cos(x*sin(x*y))))*(cos(sin(y)*y+x*cos(x))*sin(x*sin(x+y))-cos(y*cos(x*y))*sin(x*cos(x+y))+sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))/(sin(x*sin(x))*cos(y*cos(y))+cos(cos(x*cos(x+y)))*sin(sin(y)*y+x*cos(x))));

//		      res=pow(x,y)/pow(y+x,y-x);
//              res = (x*(y*(x*y-x/y)-x)-y)/(y*x-(x*(y*(x*y-x/y)-x)-y));
             //res=pow(x-sin(x),y-cos(y))/(x-pow(x-sin(x),y-cos(y))+y);

           // res = (pow(sin(x+y),k+2*n)*pow(cos(x*y),n+k)-pow(x-sin(x*y),pow(cos(x*y),n+k))*pow(y-cos(x+y),pow(sin(x+y),k+2*n)))/(y-sin(pow(x-sin(x),y-cos(y)))/cos(pow(x-sin(x),y-cos(y))));

              //res = (pow(sin(x+y),k+2*n)*pow(cos(x*y),n+k)-pow(x-sin(x*y),pow(cos(x*y),n+k))*pow(y-cos(x+y),pow(sin(x+y),k+2*n)))/(x-(pow(x-sin(x),y-cos(y)))/(pow(x-sin(x),y-cos(y))+y));


//            res=sin(x/y)*(sin(y/(x+y))+cos(x/(x+y))+cos(y/x))+cos(x/y)*(sin(y/x)+cos(y/(x+y))+sin(x/(x+y)));
//              res = sin(x/y)+cos(y/x);

			//res=(sin(x/(x+y))-sinh(x/(x+y))*asin(x/(x+y)))*(cosh(x/(x+y))*acos(x/(x+y))+cos(x/(x+y)));
    //   res=(sin(x/(x+y))-sinh(x/(x+y))*asin(x/(x+y)))*(cosh(x/(x+y))*acos(x/(x+y))+cos(x/(x+y)))*(tanh(x/(x+y))-exp(x/(x+y)));
//            res=exp(y/(x+y))*(cosh(x/(x+y))-sinh(y/(x+y)))-(tanh(y/(x+y))-sinh(x/(x+y)))*exp(x/(x+y));
              //res = (asin(x/(x+y))*sin(x/y)-acos(x/(x+y))*cos(x/y))*(tan(y/x)+1/tan(y/x));
              //res=(vd[n+1]*x-ve[k+n]*y)*(vd[n+k+3]*(x-y)+ve[2*n+3*k+4]*t);
             // res = (x*vd[n+1]*ve[k+n]-y*vd[2*n+1]*ve[k+3*n])*(t*vd[n+k+3]*ve[j+5]+x*ve[2*n+3*k+4]*vd[j+k-n]-y);
//        res = x/t*y +y*x/t+y/t*x;
		  /*
		  sp8(ve,j,t,vd,k,y,vi,j)
		  ps8(ve,j,t,vd,k,y,vi,j)
		  ms8(ve,j,t,vd,k,y,vi,j)
		  pc8(ve,j,t,vd,k,y,vi,j)
		  */


 return res;
};




TComplexNum GccES1Z()
{
   return  z1+z2*z3;
};



TComplexSTD GccES1Z_std()
{
   return z1s+z2s*z3s;
};



TComplexNum GccES2Z()
{
   // return (Ai*z1-Bi*z2)*(Ci*x-Di*z3)*(A*z2-B*z3-Ci*y);
   return (Ai*z1-Bi*z2)*(Ci*x-Di*z3)*(A*z2-B*z3+Bi*y)*(x-Ai);
};




TComplexSTD GccES2Z_std()
{
    return (Ais*z1s-Bis*z2s)*(Cis*x-Dis*z3s)*(A*z2s-B*z3s+Bis*y)*(x-Ais);
};


TComplexNum GccE1Z()
{
    return (z1-z2)*(z2-z3)*(z3-z1)*(z1+z2)*(z2+z3)*(z1+z3)*(z2*z1-z3)-z2*(z1*z3+z2)*(z1+z2*z3);
 //return  z1*z2-z3*(z1+z2-z3);
 //return  z1*z2-z3*(z1+z2-z3*(z1-z2*(z2-z1))-z1*z3*(z3-z2)*z2)+z2*(z1+z3+z2*(z1-z3)-z1*(z3-z1))*z1;
 //return z1*z2*(z2*z1-z3*z2*(z1*z3+z2*z3*(z3*z1+z1*z2)));
// return z1*(2.1*z2-3.5*z3)*1.5-3.2*(4.7-z1-z3*(2.2*z1*z3-1.7*z2)+1.2*z2*z1*(2.1*z2*z3-3.2*z1)*(1.6*z1-3.9*z2));
//return ((z3/(z1*z2-z3/z1+2.5)-2.1*z2*z1/(1.5-z1-z2/z3)+(-z1-2.3/z3+1.7/(z1/z2-z3*z1))/(z2-z3*z1*2.7)*(2.1*z1-z2*1.9-2.5/z3-1.1))/((-z2/z1)/z2-z3/(z1*1.1/z2*(z3-z1)-z1/(-z3))-2.7/(-2.1-(-z1-z3/z2))+z1*1.2*z2/(z2-1.5)*z3*(-1.1/z1-z2)/(z1-z2))-(-z1*(-z1/(1.1/z3-z1/(-z2-3.1/(-z1))))*z2/(z2-z3*z1)-(z1*z2/(-z1-z2/(z3-1.2/(-z1*1.5))))*z3*(-z2-z3/z1)+z2/(2.1/(-z1)-1.5/(-z1))*5.5-z1*z2*(z3/(-z1)+z1*(z2-z3/z1)))/(-z1*z2/z3-z3/z1*z2*(-1.1*z1/z2*z3-2.3/(-z1-(z2/z3-z1/z2)/(z1-2.5-z2*3.2)))+z3*(z3/(z1-z2-2.1)-(z1*z3-2.5/z1+3.7)/z2)*z1/(z2*z1-z3/(-2.5/z1-3.7*(z1*z2-z3/(-1.5-z2*z1))/(2.1*z1-3.2*z2-2.5*z3+2.7/z3)))))*(z1*z2-z3*z2/(z1-z2/(z1*z3-z3*(z2-z1*z2/(z2/z3-z1)))));
//return (z3/(z1*z2-z3/z1+2.5)-2.1*z2*x/(1.5-z1-z2/t)+(-z1-2.3/z3+1.7/(y/z2-z3*z1))/(z2*x-z3*z1*2.7)*(2.1*z1-z2*1.9-2.5/z3-1.1))/((-y*z2/z1)/z2-z3/(z1*1.1/z2*(t/z3-z1/(x+y))-x*z1/(-z3*y))-2.7/(-2.1-(-z1-z3/z2-y))+z1*1.2*z2/(t-z2-1.5)*z3*(-1.1/z1-t*z2*y)/(y+z1-z2+x))-(-z1*(-z1/(y-1.1/z3-z1/(-z2-3.1/(-z1)-x)))*z2/(z2-z3*z1)-(z1*z2/(-z1-z2/(z3-1.2/(-z1*1.5+2.1*y))))*z3*(-z2-z3/z1-x*3.5)+z2/(2.1/(-z1)-1.5/(-z1))*5.5-z1*z2*(z3/(-z1)+z1*(z2-z3/(y-z1/z3-x)))/(-z1*y*z2/z3-z3/z1*z2*(-1.1*z1/z2*z3*(y+x/z2)*(-t+1.5)-2.3/(-z1-(z2/z3-z1/z2-x/(z1+t)+(y+z2)/y)/(z1-2.5-z2*3.2)))+z3*(z3/(z1-z2-2.1)-(z1*z3-2.5/z1+3.7)/z2)*z1/(z2*z1-z3/(-2.5/z1-3.7*(z1*z2-z3/(-1.5-z2*z1))/(2.1*z1-3.2*z2-2.5*z3+2.7/z3)))))*(z1*z2-z3*z2/(z1-z2/(z1*z3-z3*(z2-z1*z2/(z2/z3-z1)))));
//return (z3/(z1*z2-z3/z1)-z2*x/(-z1-z2/t)+(-z1-z3+x/(y/z2-z3*z1))/(z2*x-z3*z1)*(z1-z2-t/z3))/((-y*z2/z1)/z2-z3/(z1/z2*(t/z3-z1/(x+y))-x*z1/(-z3*y))-t/(-x-(-z1-z3/z2-y))+z1*z2/(t-z2-y)*z3*(-x/z1-t*z2*y)/(y+z1-z2+x))-(-z1*(-z1/(y-t/z3-z1/(-z2-y/(-z1)-x)))*z2/(z2-z3*z1)-(z1*z2/(-z1-z2/(z3-y/(-z1*t+y))))*z3*(-z2-z3/z1-x)+z2/(x/(-z1)-y/(-z1))*t-z1*z2*(z3/(-z1)+z1*(z2-z3/(y-z1/z3-x)))/(-z1*y*z2/z3-z3/z1*z2*(-z1/z2*z3*(y+x/z2)*(-t+z3*y)-y/(-z1-(z2/z3-z1/z2-x/(z1+t)+(y+z2)/y)/(z1-z2)))+z3*(z3/(z1-z3)-(z1*z3-t/z1+x)/z2)*z1/(z2*z1-z3/(-y/z1-t*(z1*z2-z3/(-x-z2*z1))/(z1-z2*t-x*z3+y/z3)))))*(z1*z2-z3*z2/(z1-z2/(z1*z3-z3*(z2-z1*z2/(z2/z3-z1)))));


//return z1*x*(z1*z2/(z3+y/z2))-z3/(y-x/z2-z1/(x+y)+t)+z3*z2/(z3-z2*x)+z1*(z2/z3-y)*(x-z1);

//return z1*(x*2.1*z1*z2/(z3*1.1+2.1*y/z2))-z3/(1.5/y-x/z2-z1/(x+y)+t*3.2)+z3*z2/(3.7-z2*x)-z1/(z2*1.2-3.2/z3+x*(y-2.1*z3)/t)+z3/(2.5/z1+z3/1.7);



//return (z1/(z2-z3)-(z1+z2)/(z3-z1)+z1*z2*(z1-z2+z3)/(z1-z3)-z2*(z1+z3)*(z2-z1))*(z1/(z2*z3+z1)-z2)*(z1/z3-z3)/(z1*(z1*z3+z3+z2*z1)+z3*z2+z2);
//return (z1*z2/(z1+z2)+z1/(x/z1+z2/y)-z2*(z3*t-x*z2)*(z1+x)*(y+z3)+z3*z2*(z3-y)/(y+z1))*(1.5*z1-3.7/z2+2.5*x*z3)*(z3/(1.7-z3*y)-y/z1)*((x*z1+z2*t+1.5)/(z1*z3+t)+z3)/(z3*(z1*2.5+1.7*t*z2)+z2*z3*t*2.7);
//return (z1/z2-z1*z2)*((z3-z1)*(z1+z2)-z3/z2)*(z1*z3/(z1-z2+z3))/((z3-z2/(z3-z1))*(z2*z3-z1/(z3/z1-z2/(z2-z1))));
//return ((z1-z2)/(z3-z1)-(z1+(z3-z2*z1)/(z1-z3+z2))*(z3-z2))*(z3+z2-(z1-z2)*(z3-z1/z3));
//return (z1/z3-z2/(z1*z2-z3)+z3*(z2/(z3/z1-z1/z3)-z1/(z1*z2-z2/z3))+(z2*z3-z3*(z1+z2)/(z2/(z1*z2-z3)-z1/(z1*z2-z2/z3))))/((z2*z3-z1*z2)/(z3*(z2/z3+z3*(z2/(z3/z1-z1/z3)-z1/(z1*z2-z2/z3)))));

//return z1*(z2/i-i*Im(z1-z2/z3)-Re(z3*z2-z1/(z3+z2))/i)*(2.5/i-i/3.7-Re(z1/(z2+z3))/Im(z1/i-i*z2));

//return z1*z3*z2-z1*(z2-z3*z1*(z2-z1)*(z3+z1)*(z1*z2-z2+z3));
//return z3*z2-z1*(z2-z3*z1*(z2-z1)*(z3+z1));
//return (z1-z2)*(z2-z3)*(z3-z1)*(z1+z2)*(z2+z3)*(z1+z3);
//return (z1-z2)*(z2-z3)*(z3-z1)*(z1+z2)*(z2+z3)*(z1+z3)*(z2*z1-z3)*(z1*z3+z2);
};




TComplexSTD GccE1Z_std()
{
    return (z1s-z2s)*(z2s-z3s)*(z3s-z1s)*(z1s+z2s)*(z2s+z3s)*(z1s+z3s)*(z2s*z1s-z3s)-z2s*(z1s*z3s+z2s)*(z1s+z2s*z3s);

}



TComplexNum GccE1AZ()
{
    return z1*z2-z3*(z1+z2-z3*(z1-z2*(z2-z1))-z1*z3*(z3-z2)*z2)+z2*(z1+z3+z2*(z1-z3)-z1*(z3-z1))*z1;

}



TComplexSTD GccE1AZ_std()
{
    return z1s*z2s-z3s*(z1s+z2s-z3s*(z1s-z2s*(z2s-z1s))-z1s*z3s*(z3s-z2s)*z2s)+z2s*(z1s+z3s+z2s*(z1s-z3s)-z1s*(z3s-z1s))*z1s;

}


TComplexNum GccE1BZ()
{
    return z1*z2/(2.7*z1*(-3.3*z1*(4.4*z2*(2.9*z1+3.7*z2+10.1*(1.9*z1+9.1*z2)))))*(2.3*z1/z3-2.5*z1*(3.7*z3-1)/(2.7*z1-3.6*z2-4.7)*(z1/(3.6*z1-1)-4.1/z1+5.8*(2.6*z1*z3-1.7)/(z2+1.7)-7.1*(2.8*z1*(z2+1.1)*(3.4*z2+2.2)*(3.1/(z1+1.5)-2.3*z3/(2.4*z2*z3-1.7)+(4.7*z1-1.1)*(5.7*z2-7.4)/(z1-2.7*z2-1.7-2.4*z3/(3.8-7.6*z1-8.1*z2*(4.2*z1/(2.9*z3+1.6)-7.8*z1-8.9/z3+9.9*(2.1*z1-1.2)*(3.1*z1+4.9*z2+5.8)*(2.1*z1*(7.3-2.1*z2)*z3-7.1)*z1*(-2.5*z2-5.7)*z3/(z1-z2*2.8-3.6/(z1/(z3-1.7)-7.8/(z2+2.5)+8.3/(2.8*(-1.5*z1+3.1)*z2*(-1.2*z3-1)+1.7)-9.4)))))/(z1-1.5)))));
}



TComplexSTD  GccE1BZ_std()
{

   #ifdef   EXTENDED_FLOAT
       return z1s*z2s/(2.7l*z1s*(-3.3l*z1s*(4.4l*z2s*(2.9l*z1s+3.7l*z2s+10.1l*(1.9l*z1s+9.1l*z2s)))))*(2.3l*z1s/z3s-2.5l*z1s*(3.7l*z3s-1.0l)/(2.7l*z1s-3.6l*z2s-4.7l)*(z1s/(3.6l*z1s-1.0l)-4.1l/z1s+5.8l*(2.6l*z1s*z3s-1.7l)/(z2s+1.7l)-7.1l*(2.8l*z1s*(z2s+1.1l)*(3.4l*z2s+2.2l)*(3.1l/(z1s+1.5l)-2.3l*z3s/(2.4l*z2s*z3s-1.7l)+(4.7l*z1s-1.1l)*(5.7l*z2s-7.4l)/(z1s-2.7l*z2s-1.7l-2.4l*z3s/(3.8l-7.6l*z1s-8.1l*z2s*(4.2l*z1s/(2.9l*z3s+1.6l)-7.8l*z1s-8.9l/z3s+9.9l*(2.1l*z1s-1.2l)*(3.1l*z1s+4.9l*z2s+5.8l)*(2.1l*z1s*(7.3l-2.1l*z2s)*z3s-7.1l)*z1s*(-2.5l*z2s-5.7l)*z3s/(z1s-z2s*2.8l-3.6l/(z1s/(z3s-1.7l)-7.8l/(z2s+2.5l)+8.3l/(2.8l*(-1.5l*z1s+3.1l)*z2s*(-1.2l*z3s-1.0l)+1.7l)-9.4l)))))/(z1s-1.5l)))));

   #else
      return z1s*z2s/(2.7*z1s*(-3.3*z1s*(4.4*z2s*(2.9*z1s+3.7*z2s+10.1*(1.9*z1s+9.1*z2s)))))*(2.3*z1s/z3s-2.5*z1s*(3.7*z3s-1.0)/(2.7*z1s-3.6*z2s-4.7)*(z1s/(3.6*z1s-1.0)-4.1/z1s+5.8*(2.6*z1s*z3s-1.7)/(z2s+1.7)-7.1*(2.8*z1s*(z2s+1.1)*(3.4*z2s+2.2)*(3.1/(z1s+1.5)-2.3*z3s/(2.4*z2s*z3s-1.7)+(4.7*z1s-1.1)*(5.7*z2s-7.4)/(z1s-2.7*z2s-1.7-2.4*z3s/(3.8-7.6*z1s-8.1*z2s*(4.2*z1s/(2.9*z3s+1.6)-7.8*z1s-8.9/z3s+9.9*(2.1*z1s-1.2)*(3.1*z1s+4.9*z2s+5.8)*(2.1*z1s*(7.3-2.1*z2s)*z3s-7.1)*z1s*(-2.5*z2s-5.7)*z3s/(z1s-z2s*2.8-3.6/(z1s/(z3s-1.7)-7.8/(z2s+2.5)+8.3/(2.8*(-1.5*z1s+3.1)*z2s*(-1.2*z3s-1.0)+1.7)-9.4)))))/(z1s-1.5)))));
  #endif
}


TComplexNum GccE1CZ()
{
    return z1*(z1+z2+z3)+z1*(z2+z1+z3)+z1*(z1+z3+z2)+z1*(z2+z3+z1)+z1*(z3+z1+z2)+z1*(z3+z2+z1)+z2*(z1-z2-z3)+z2*(z2-z1-z3)+z2*(z1-z3-z2)+z2*(z2-z3-z1)+z2*(z3-z1-z2)+z2*(z3-z2-z1);

}



TComplexSTD  GccE1CZ_std()
{
   return z1s*(z1s+z2s+z3s)+z1s*(z2s+z1s+z3s)+z1s*(z1s+z3s+z2s)+z1s*(z2s+z3s+z1s)+z1s*(z3s+z1s+z2s)+z1s*(z3s+z2s+z1s)+z2s*(z1s-z2s-z3s)+z2s*(z2s-z1s-z3s)+z2s*(z1s-z3s-z2s)+z2s*(z2s-z3s-z1s)+z2s*(z3s-z1s-z2s)+z2s*(z3s-z2s-z1s);

}


TComplexNum GccE2CZ()
{
    return (z1*x*Bi-y*z2*0.571)*(Ai*z2-z3*0.234)+(t*z3*A-z1*y*0.579)*(Bi*z1-z2*Ci*t)+(z2*(y-x*A)+z3*C-x*y*Ai)*(Ai-t*z1-y*z3*0.357)-(-z2*z1*Ci+0.753*z3*(B*t+x)) ;

}




TComplexSTD GccE2CZ_std()
{
 #ifdef   EXTENDED_FLOAT

    return (z1s*x*Bis-y*z2s*0.571l)*(Ais*z2s-z3s*0.234l)+(t*z3s*A-z1s*y*0.579l)*(Bis*z1s-z2s*Cis*t)+(z2s*(y-x*A)+z3s*C-x*y*Ais)*(Ais-t*z1s-y*z3s*0.357l)-(-z2s*z1s*Cis+0.753l*z3s*(B*t+x));

 #else
    return (z1s*x*Bis-y*z2s*0.571)*(Ais*z2s-z3s*0.234)+(t*z3s*A-z1s*y*0.579)*(Bis*z1s-z2s*Cis*t)+(z2s*(y-x*A)+z3s*C-x*y*Ais)*(Ais-t*z1s-y*z3s*0.357)-(-z2s*z1s*Cis+0.753*z3s*(B*t+x));

 #endif
}




TComplexNum GccE2Z()
{
    return  (z1*z2/(z1+z2)+z1/(x/z1+z2/y)-z2*(z3*t-x*z2)*(z1+x)*(y+z3)+z3*z2*(z3-y)/(y+z1))*(1.5*z1-3.7/z2+2.5*x*z3)*(z3/(1.7-z3*y)-y/z1)*((x*z1+z2*t+1.5)/(z1*z3+t)+z3)/(z3*(z1*2.5+1.7*t*z2)+z2*z3*t*2.7);

}


TComplexSTD  GccE2Z_std()
{
   //return  (z1s*z2s/(z1s+z2s)+z1s/(x/z1s+z2s/y)-z2s*(z3s*t-x*z2s)*(z1s+x)*(y+z3s)+z3s*z2s*(z3s-y)/(y+z1s))*(1.5*z1s-3.7/z2s+2.5*x*z3s)*(z3s/(1.7-z3s*y)-y/z1s)*((x*z1s+z2s*t+1.5)/(z1s*z3s+t)+z3s)/(z3s*(z1s*2.5+1.7*t*z2s)+z2s*z3s*t*2.7);

  //  return  (z1s*z2s/(z1s+z2s)+z1s/(x/z1s+z2s/y)-z2s*(z3s*t-x*z2s)*(z1s+x)*(y+z3s)+z3s*z2s*(z3s-y)/(y+z1s))*(1.5l*z1s-3.7l/z2s+2.5l*x*z3s)*(z3s/(1.7l-z3s*y)-y/z1s)*((x*z1s+z2s*t+1.5l)/(z1s*z3s+t)+z3s)/(z3s*(z1s*2.5l+1.7l*t*z2s)+z2s*z3s*t*2.7l);

   #ifdef   EXTENDED_FLOAT
    return (z1s*z2s/(z1s+z2s)+z1s/(x/z1s+z2s/y)-z2s*(z3s*t-x*z2s)*(z1s+x)*(y+z3s)+z3s*z2s*(z3s-y)/(y+z1s))*(1.5l*z1s-3.7l/z2s+2.5l*x*z3s)*(z3s/(1.7l-z3s*y)-y/z1s)*((x*z1s+z2s*t+1.5l)/(z1s*z3s+t)+z3s)/(z3s*(z1s*2.5l+1.7l*t*z2s)+z2s*z3s*t*2.7l);
   #else
    return (z1s*z2s/(z1s+z2s)+z1s/(x/z1s+z2s/y)-z2s*(z3s*t-x*z2s)*(z1s+x)*(y+z3s)+z3s*z2s*(z3s-y)/(y+z1s))*(1.5*z1s-3.7/z2s+2.5*x*z3s)*(z3s/(1.7-z3s*y)-y/z1s)*((x*z1s+z2s*t+1.5)/(z1s*z3s+t)+z3s)/(z3s*(z1s*2.5+1.7*t*z2s)+z2s*z3s*t*2.7);
  #endif
}


TComplexNum GccE2AZ()
{
    return  (z1*x-y/(z3-z2+2.7*z1)+(x*z2-z3/y)/(x*3.1+y*t)-z1*z2*(z3/(z2*x*z3-x/(z2-z1-z3*t))-z2/(z1/t-x/z2))*(-z3*(x-t/(z1-x))*(z2-z3/(z2+y)))/(-2.1*z2/x-z2*y/(z3-z1-z2*z3)))/((z3-t*x)*(y/x+z2+z3)*(2.7-x*y)*(z3-1.7*x*z2)-(2.9/z3+y+z3/(x*2.5*z1-z2*1.2/y)));
}



TComplexSTD  GccE2AZ_std()
{
     // return  (z1s*x-y/(z3s-z2s+2.7*z1s)+(x*z2s-z3s/y)/(x*3.1+y*t)-z1s*z2s*(z3s/(z2s*x*z3s-x/(z2s-z1s-z3s*t))-z2s/(z1s/t-x/z2s))*(-z3s*(x-t/(z1s-x))*(z2s-z3s/(z2s+y)))/(-2.1*z2s/x-z2s*y/(z3s-z1s-z2s*z3s)))/((z3s-t*x)*(y/x+z2s+z3s)*(2.7-x*y)*(z3s-1.7*x*z2s)-(2.9/z3s+y+z3s/(x*2.5*z1s-z2s*1.2/y)));

    //return  (z1s*x-y/(z3s-z2s+2.7l*z1s)+(x*z2s-z3s/y)/(x*3.1l+y*t)-z1s*z2s*(z3s/(z2s*x*z3s-x/(z2s-z1s-z3s*t))-z2s/(z1s/t-x/z2s))*(-z3s*(x-t/(z1s-x))*(z2s-z3s/(z2s+y)))/(-2.1l*z2s/x-z2s*y/(z3s-z1s-z2s*z3s)))/((z3s-t*x)*(y/x+z2s+z3s)*(2.7l-x*y)*(z3s-1.7l*x*z2s)-(2.9l/z3s+y+z3s/(x*2.5l*z1s-z2s*1.2l/y)));

  #ifdef   EXTENDED_FLOAT
    return (z1s*x-y/(z3s-z2s+2.7l*z1s)+(x*z2s-z3s/y)/(x*3.1l+y*t)-z1s*z2s*(z3s/(z2s*x*z3s-x/(z2s-z1s-z3s*t))-z2s/(z1s/t-x/z2s))*(-z3s*(x-t/(z1s-x))*(z2s-z3s/(z2s+y)))/(-2.1l*z2s/x-z2s*y/(z3s-z1s-z2s*z3s)))/((z3s-t*x)*(y/x+z2s+z3s)*(2.7l-x*y)*(z3s-1.7l*x*z2s)-(2.9l/z3s+y+z3s/(x*2.5l*z1s-z2s*1.2l/y)));
   #else
    return (z1s*x-y/(z3s-z2s+2.7*z1s)+(x*z2s-z3s/y)/(x*3.1+y*t)-z1s*z2s*(z3s/(z2s*x*z3s-x/(z2s-z1s-z3s*t))-z2s/(z1s/t-x/z2s))*(-z3s*(x-t/(z1s-x))*(z2s-z3s/(z2s+y)))/(-2.1*z2s/x-z2s*y/(z3s-z1s-z2s*z3s)))/((z3s-t*x)*(y/x+z2s+z3s)*(2.7-x*y)*(z3s-1.7*x*z2s)-(2.9/z3s+y+z3s/(x*2.5*z1s-z2s*1.2/y)));
  #endif

}




TComplexNum GccE2BZ()
{
  return   (z1*x/i-i*y/(z3*Re(z2*i-y*i)-Im(z2+2.7*z1)/i)+(x*z2-z3/y/i)/(Re(x*3.1-i*z2)+y*t)-Im(z1*z2)*(z3/(z2*x*z3-i*x/(z2-z1-z3*t))-z2/(z1/t-x/z2/Re(z1-i*x*y/z2)))*(-i*(z3*(x-t/(z1-x*Im(z1-z2*i/x)))*(z2/i-z3*i/(z2+y)))/(-2.1*z2/x-Re(z2*y)*i/Im(z3-z1-z2*z3))))/((z3-t*x)*Im(y/x/i+z2+z3*(2.5*i-7))*(2.7-x*y)*Re(z3-1.7*x*z2)-(-i*2.9/z3+y+z3/(x*2.5*z1-z2*1.2/y-i)));
}




TComplexSTD GccE2BZ_std()
{

 //  return   (z1s*x/I-I*y/(z3s*std::real(z2s*I-y*I)-std::imag(z2s+2.7l*z1s)/I)+(x*z2s-z3s/y/I)/(std::real(x*3.1l-I*z2s)+y*t)-std::imag(z1s*z2s)*(z3s/(z2s*x*z3s-I*x/(z2s-z1s-z3s*t))-z2s/(z1s/t-x/z2s/std::real(z1s-I*x*y/z2s)))*(-I*(z3s*(x-t/(z1s-x*std::imag(z1s-z2s*I/x)))*(z2s/I-z3s*I/(z2s+y)))/(-2.1l*z2s/x-std::real(z2s*y)*I/std::imag(z3s-z1s-z2s*z3s))))/((z3s-t*x)*std::imag(y/x/I+z2s+z3s*(2.5l*I-7.0l))*(2.7l-x*y)*std::real(z3s-1.7l*x*z2s)-(-I*2.9l/z3s+y+z3s/(x*2.5l*z1s-z2s*1.2l/y-I)));

   #ifdef   EXTENDED_FLOAT
    return (z1s*x/I-I*y/(z3s*std::real(z2s*I-y*I)-std::imag(z2s+2.7l*z1s)/I)+(x*z2s-z3s/y/I)/(std::real(x*3.1l-I*z2s)+y*t)-std::imag(z1s*z2s)*(z3s/(z2s*x*z3s-I*x/(z2s-z1s-z3s*t))-z2s/(z1s/t-x/z2s/std::real(z1s-I*x*y/z2s)))*(-I*(z3s*(x-t/(z1s-x*std::imag(z1s-z2s*I/x)))*(z2s/I-z3s*I/(z2s+y)))/(-2.1l*z2s/x-std::real(z2s*y)*I/std::imag(z3s-z1s-z2s*z3s))))/((z3s-t*x)*std::imag(y/x/I+z2s+z3s*(2.5l*I-7.0l))*(2.7l-x*y)*std::real(z3s-1.7l*x*z2s)-(-I*2.9l/z3s+y+z3s/(x*2.5l*z1s-z2s*1.2l/y-I)));
   #else
    return   (z1s*x/I-I*y/(z3s*std::real(z2s*I-y*I)-std::imag(z2s+2.7*z1s)/I)+(x*z2s-z3s/y/I)/(std::real(x*3.1-I*z2s)+y*t)-std::imag(z1s*z2s)*(z3s/(z2s*x*z3s-I*x/(z2s-z1s-z3s*t))-z2s/(z1s/t-x/z2s/std::real(z1s-I*x*y/z2s)))*(-I*(z3s*(x-t/(z1s-x*std::imag(z1s-z2s*I/x)))*(z2s/I-z3s*I/(z2s+y)))/(-2.1*z2s/x-std::real(z2s*y)*I/std::imag(z3s-z1s-z2s*z3s))))/((z3s-t*x)*std::imag(y/x/I+z2s+z3s*(2.5*I-7.0))*(2.7-x*y)*std::real(z3s-1.7*x*z2s)-(-I*2.9/z3s+y+z3s/(x*2.5*z1s-z2s*1.2/y-I)));
  #endif

}




TComplexNum GccE3CM()
{
  return (Ai*z2*(B-Ci*Ai)*C-Bi*z1*(Ci-Ai*B)*Ai)*((-Ai*(B-Ci*(Ci*B-Ai*B*z1)))*z1*C*Ai-Bi*z2*z1*Ai*C)*(Ai*(Bi-Ci)*z1-z2*(Ai*z1*B-z2*Ci*z1)-(-Ci-A*(-Bi*(-z1*B*Ci*z2-z2*A*(Ai-B*Ci*Ai)))))*(Ai*z1*C*(Bi*Ci-C*(B*Ai-Ci*(Bi*A-Ci*B))))/(A*z1*B*(A*Ci-Bi*(Ai-C))-Ci*z2*Bi*(B-A*Ci-(-Ci*(-Bi-A)*Bi)*(-Ci+Ai)));
}



TComplexNum GccE3C()
{
  return (Ai*z2*(B-Ci/Ai)*C-Bi*z1/(Ci-Ai/B)*Ai)*((-Ai/(B-Ci/(Ci/B-Ai*B*z1)))*z1/C/Ai-Bi/z2/z1/Ai/C)*(Ai*(Bi-Ci)/z1-z2/(Ai*z1/B-z2/Ci/z1)-(-Ci-A/(-Bi/(-z1/B/Ci/z2-z2*A/(Ai-B/Ci*Ai)))))/(Ai*z1*C/(Bi*Ci-C/(B/Ai-Ci/(Bi/A-Ci/B))))*(A*z1*B/(A/Ci-Bi/(Ai-C))-Ci/z2*Bi/(B-A/Ci-(-Ci/(-Bi-A)/Bi)/(-Ci+Ai)));
}



TComplexSTD GccE3CM_std()
{
  return (Ais*z2s*(B-Cis*Ais)*C-Bis*z1s*(Cis-Ais*B)*Ais)*((-Ais*(B-Cis*(Cis*B-Ais*B*z1s)))*z1s*C*Ais-Bis*z2s*z1s*Ais*C)*(Ais*(Bis-Cis)*z1s-z2s*(Ais*z1s*B-z2s*Cis*z1s)-(-Cis-A*(-Bis*(-z1s*B*Cis*z2s-z2s*A*(Ais-B*Cis*Ais)))))*(Ais*z1s*C*(Bis*Cis-C*(B*Ais-Cis*(Bis*A-Cis*B))))/(A*z1s*B*(A*Cis-Bis*(Ais-C))-Cis*z2s*Bis*(B-A*Cis-(-Cis*(-Bis-A)*Bis)*(-Cis+Ais)));
}



TComplexSTD GccE3C_std()
{
  return (Ais*z2s*(B-Cis/Ais)*C-Bis*z1s/(Cis-Ais/B)*Ais)*((-Ais/(B-Cis/(Cis/B-Ais*B*z1s)))*z1s/C/Ais-Bis/z2s/z1s/Ais/C)*(Ais*(Bis-Cis)/z1s-z2s/(Ais*z1s/B-z2s/Cis/z1s)-(-Cis-A/(-Bis/(-z1s/B/Cis/z2s-z2s*A/(Ais-B/Cis*Ais)))))/(Ais*z1s*C/(Bis*Cis-C/(B/Ais-Cis/(Bis/A-Cis/B))))*(A*z1s*B/(A/Cis-Bis/(Ais-C))-Cis/z2s*Bis/(B-A/Cis-(-Cis/(-Bis-A)/Bis)/(-Cis+Ais)));
}





TComplexNum GccE3SZ()
{
    return  (z1*z2+z3/z1+z2/(z1*z2-z3/z1))/(z2/z3-z3/z1)-z1*z2*z3*(z2/z3-z3/z1)/(z3-z2/(z1*z2-z3/z1));

}



TComplexSTD GccE3SZ_std()
{
      return  (z1s*z2s+z3s/z1s+z2s/(z1s*z2s-z3s/z1s))/(z2s/z3s-z3s/z1s)-z1s*z2s*z3s*(z2s/z3s-z3s/z1s)/(z3s-z2s/(z1s*z2s-z3s/z1s));

}



TComplexNum GccE3ASZ()
{
    return (z2/z3-z2*z1+x*z2-y/(z3/z1-z2/y))*(x/(z1-z2*z1)+z3*(z1*(z2/z3-z1))-z3/(x*z2-y*z1))-(z1*(z2/z3-z1)+z3*(x*z2-y*z1)-x/(z1-z2*z1))/(z3*(z1*(z2/z3-z1))-(z2/z3-z3/z1)*(z2*z1-z3/z1+y/(z3/z1-z2/y)));

}



TComplexSTD GccE3ASZ_std()
{
    return (z2s/z3s-z2s*z1s+x*z2s-y/(z3s/z1s-z2s/y))*(x/(z1s-z2s*z1s)+z3s*(z1s*(z2s/z3s-z1s))-z3s/(x*z2s-y*z1s))-(z1s*(z2s/z3s-z1s)+z3s*(x*z2s-y*z1s)-x/(z1s-z2s*z1s))/(z3s*(z1s*(z2s/z3s-z1s))-(z2s/z3s-z3s/z1s)*(z2s*z1s-z3s/z1s+y/(z3s/z1s-z2s/y)));

}


TComplexNum GccE3BSZ()
{
    return z1*z2+z1*z3*(z2*z3+z1*z2*(z2*z3+z1*z3*(z1*z2+z2*z3*(z1*z3+z2*z3*(z1*z2+z2*z3*(z1*z3+z1*z2*(z2*z3+z1*z3*(z1*z2+z2*z3*(z1*z3+z2*z3*(z2*z3+z1*z3*(z2*z3+z1*z3*(z2*z3+z1*z2))))))))))));

}

TComplexSTD GccE3BSZ_std()
{
    return z1s*z2s+z1s*z3s*(z2s*z3s+z1s*z2s*(z2s*z3s+z1s*z3s*(z1s*z2s+z2s*z3s*(z1s*z3s+z2s*z3s*(z1s*z2s+z2s*z3s*(z1s*z3s+z1s*z2s*(z2s*z3s+z1s*z3s*(z1s*z2s+z2s*z3s*(z1s*z3s+z2s*z3s*(z2s*z3s+z1s*z3s*(z2s*z3s+z1s*z3s*(z2s*z3s+z1s*z2s))))))))))));

}




TComplexNum GccE4SZ()
{
    return  z1*(z2/z3-x/(z1+z2))-i/(z1*i-i/z2)+z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2)))+(z2-z3)/(z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2))));

}


TComplexSTD GccE4SZ_std()
{
   // return  z1*(z2/z3-x/(z1+z2))-i/(z1*i-i/z2)+z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2)))+(z2-z3)/(z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2))));
    return  z1s*(z2s/z3s-x/(z1s+z2s))-I/(z1s*I-I/z2s)+z2s*(y*I-std::real(z2s/z3s)*std::imag(I/z2s))-z3s/(I/(z1s*I-I/z2s)-z1s*(z2s/z3s-x/(z1s+z2s)))+(z2s-z3s)/(z2s*(y*I-std::real(z2s/z3s)*std::imag(I/z2s))-z3s/(I/(z1s*I-I/z2s)-z1s*(z2s/z3s-x/(z1s+z2s))));
}





TComplexNum GccE4SCZ()
{
    return  (Ai*Bi*Ci*z1/(Bi/Ci-Ci/Di)-Di*Bi*Ai*z2/(Ci/Di-Bi/Ai)-Ci*Ai*Di*z3/(Ai/Ci-Bi/Di))/((Ai+Bi)*(Bi-Di)*z1/(Ai+Bi-Ci)-(Ai-Bi)*(Bi+Di)*z2/(Ai-Bi-Di)+(Ci-Bi)*(Bi-Di)*z3/(Bi-Ci-Ai)+(Ai*(Bi-Ci)*z1/(Bi*(Ai-Bi)*z2/(Bi-Ci)-Ci*(Ci-Di)*z3/(Ai+Di))-Bi*(Bi-Di)*z2/(Ci*(Ai+Ci)*z1/(Ci-Ai)-Bi*(Ci+Di)*z3/(Ai-Di))+Ci*(Bi-Ai)*z3/(Di*(Bi+Ci)*z1/(Bi+Di)-Di*(Di-Ci)*z2/(Bi-Ci)))+((Ai*(Bi*Di+Ci*Ai)*z1-Di*(Ai*Di+Ci*Bi)*z2-Bi*(Ai*Ci-Di*Bi)*z3)/(Ci*Bi*(Ai-Bi)/z1-Ci*Di*(Ai-Ci)/z2-Ai*Bi*(Ai+Di)/z3)+((Ai+Bi)*z1/(Ci-Di)-(Bi+Ci)*z2/(Ai-Di)-(Ai+Ci)*z3/(Di-Bi))-((Ai*Ci-Bi*Di)*z3/(Ai+Bi)-(Ai*Bi-Ci*Di)*z2/(Di+Ai)-(Bi*Ci-Bi*Ai)*z1/(Bi-Ci))))-(Ai*(Bi-Ci)*z1/(Bi*(Ai-Bi)*z2/(Bi-Ci)-Ci*(Ci-Di)*z3/(Ai+Di))-Bi*(Bi-Di)*z2/(Ci*(Ai+Ci)*z1/(Ci-Ai)-Bi*(Ci+Di)*z3/(Ai-Di))+Ci*(Bi-Ai)*z3/(Di*(Bi+Ci)*z1/(Bi+Di)-Di*(Di-Ci)*z2/(Bi-Ci))+(Ai+Bi)*(Bi-Di)*z1/(Ai+Bi-Ci)-(Ai-Bi)*(Bi+Di)*z2/(Ai-Bi-Di)+(Ci-Bi)*(Bi-Di)*z3/(Bi-Ci-Ai))+(Ai*Bi*Ci*z1/(Bi/Ci-Ci/Di)-Di*Bi*Ai*z2/(Ci/Di-Bi/Ai)-Ci*Ai*Di*z3/(Ai/Ci-Bi/Di))*((Ai*Ci-Bi*Di)*z3/(Ai+Bi)-(Ai*Bi-Ci*Di)*z2/(Di+Ai)-(Bi*Ci-Bi*Ai)*z1/(Bi-Ci))/((Ai*(Bi*Di+Ci*Ai)*z1-Di*(Ai*Di+Ci*Bi)*z2-Bi*(Ai*Ci-Di*Bi)*z3)+(Ci*Bi*(Ai-Bi)/z1-Ci*Di*(Ai-Ci)/z2-Ai*Bi*(Ai+Di)/z3)+(Ai+Bi)*z1/(Ci-Di)-(Bi+Ci)*z2/(Ai-Di)-(Ai+Ci)*z3/(Di-Bi));

}



TComplexSTD GccE4SCZ_std()
{
    return (Ais*Bis*Cis*z1s/(Bis/Cis-Cis/Dis)-Dis*Bis*Ais*z2s/(Cis/Dis-Bis/Ais)-Cis*Ais*Dis*z3s/(Ais/Cis-Bis/Dis))/((Ais+Bis)*(Bis-Dis)*z1s/(Ais+Bis-Cis)-(Ais-Bis)*(Bis+Dis)*z2s/(Ais-Bis-Dis)+(Cis-Bis)*(Bis-Dis)*z3s/(Bis-Cis-Ais)+(Ais*(Bis-Cis)*z1s/(Bis*(Ais-Bis)*z2s/(Bis-Cis)-Cis*(Cis-Dis)*z3s/(Ais+Dis))-Bis*(Bis-Dis)*z2s/(Cis*(Ais+Cis)*z1s/(Cis-Ais)-Bis*(Cis+Dis)*z3s/(Ais-Dis))+Cis*(Bis-Ais)*z3s/(Dis*(Bis+Cis)*z1s/(Bis+Dis)-Dis*(Dis-Cis)*z2s/(Bis-Cis)))+((Ais*(Bis*Dis+Cis*Ais)*z1s-Dis*(Ais*Dis+Cis*Bis)*z2s-Bis*(Ais*Cis-Dis*Bis)*z3s)/(Cis*Bis*(Ais-Bis)/z1s-Cis*Dis*(Ais-Cis)/z2s-Ais*Bis*(Ais+Dis)/z3s)+((Ais+Bis)*z1s/(Cis-Dis)-(Bis+Cis)*z2s/(Ais-Dis)-(Ais+Cis)*z3s/(Dis-Bis))-((Ais*Cis-Bis*Dis)*z3s/(Ais+Bis)-(Ais*Bis-Cis*Dis)*z2s/(Dis+Ais)-(Bis*Cis-Bis*Ais)*z1s/(Bis-Cis))))-(Ais*(Bis-Cis)*z1s/(Bis*(Ais-Bis)*z2s/(Bis-Cis)-Cis*(Cis-Dis)*z3s/(Ais+Dis))-Bis*(Bis-Dis)*z2s/(Cis*(Ais+Cis)*z1s/(Cis-Ais)-Bis*(Cis+Dis)*z3s/(Ais-Dis))+Cis*(Bis-Ais)*z3s/(Dis*(Bis+Cis)*z1s/(Bis+Dis)-Dis*(Dis-Cis)*z2s/(Bis-Cis))+(Ais+Bis)*(Bis-Dis)*z1s/(Ais+Bis-Cis)-(Ais-Bis)*(Bis+Dis)*z2s/(Ais-Bis-Dis)+(Cis-Bis)*(Bis-Dis)*z3s/(Bis-Cis-Ais))+(Ais*Bis*Cis*z1s/(Bis/Cis-Cis/Dis)-Dis*Bis*Ais*z2s/(Cis/Dis-Bis/Ais)-Cis*Ais*Dis*z3s/(Ais/Cis-Bis/Dis))*((Ais*Cis-Bis*Dis)*z3s/(Ais+Bis)-(Ais*Bis-Cis*Dis)*z2s/(Dis+Ais)-(Bis*Cis-Bis*Ais)*z1s/(Bis-Cis))/((Ais*(Bis*Dis+Cis*Ais)*z1s-Dis*(Ais*Dis+Cis*Bis)*z2s-Bis*(Ais*Cis-Dis*Bis)*z3s)+(Cis*Bis*(Ais-Bis)/z1s-Cis*Dis*(Ais-Cis)/z2s-Ais*Bis*(Ais+Dis)/z3s)+(Ais+Bis)*z1s/(Cis-Dis)-(Bis+Cis)*z2s/(Ais-Dis)-(Ais+Cis)*z3s/(Dis-Bis));

}


                                           /// complex polynom

TComplexSTD GccP1Z_std()
{

     //return  1.1l*pow(z1s,12)-2.1l*pow(z1s,11)-3.1l*pow(z1s,10)+2.2l*pow(z1s,9)-3.3l*pow(z1s,8)-5.7l*pow(z1s,7)+2.3l*pow(z1s,6)-9.8l*pow(z1s,5)+1.7l*pow(z1s,4)+1.4l*pow(z1s,3)-7.5l*pow(z1s,2)+7.7l*z1s+12.3l;

    #ifdef   EXTENDED_FLOAT
       return  1.1l*pow(z1s,12)-2.1l*pow(z1s,11)-3.1l*pow(z1s,10)+2.2l*pow(z1s,9)-3.3l*pow(z1s,8)-5.7l*pow(z1s,7)+2.3l*pow(z1s,6)-9.8l*pow(z1s,5)+1.7l*pow(z1s,4)+1.4l*pow(z1s,3)-7.5l*pow(z1s,2)+7.7l*z1s+12.3l;
    #else
       return  1.1*pow(z1s,12)-2.1*pow(z1s,11)-3.1*pow(z1s,10)+2.2*pow(z1s,9)-3.3*pow(z1s,8)-5.7*pow(z1s,7)+2.3*pow(z1s,6)-9.8*pow(z1s,5)+1.7*pow(z1s,4)+1.4*pow(z1s,3)-7.5*pow(z1s,2)+7.7*z1s+12.3;
    #endif
};



TComplexSTD GccP1CZ_std()
{

     return  pow(z1s,12)-A*pow(z1s,11)-Ais*pow(z1s,10)+Bis*pow(z1s,9)-B*pow(z1s,8)-C*pow(z1s,7)+Cis*pow(z1s,6)-D*pow(z1s,5)+Dis*pow(z1s,4)+A*Ais*pow(z1s,3)-Bis*B*pow(z1s,2)+Cis*Dis*z1s+Ais*Cis*D*A;

//    #ifdef   EXTENDED_FLOAT
//       return  1.1l*pow(z1s,12)-2.1l*pow(z1s,11)-3.1l*pow(z1s,10)+2.2l*pow(z1s,9)-3.3l*pow(z1s,8)-5.7l*pow(z1s,7)+2.3l*pow(z1s,6)-9.8l*pow(z1s,5)+1.7l*pow(z1s,4)+1.4l*pow(z1s,3)-7.5l*pow(z1s,2)+7.7l*z1s+12.3l;
//    #else
//       return  1.1*pow(z1s,12)-2.1*pow(z1s,11)-3.1*pow(z1s,10)+2.2*pow(z1s,9)-3.3*pow(z1s,8)-5.7*pow(z1s,7)+2.3*pow(z1s,6)-9.8*pow(z1s,5)+1.7*pow(z1s,4)+1.4*pow(z1s,3)-7.5*pow(z1s,2)+7.7*z1s+12.3;
//    #endif
};


TComplexSTD GccF1Z_std()
{
 //return sin(cos(z1s+0.31l*z2s))*cos(0.15l*sin(z1s-z3s))*(1.17l*cos(sin(0.35l*cos(0.25l*z3s-z1s))))*tan(z1s+0.12l*z2s)*(tan(z3s+z1s)-cos(sin(z3s+z2s))*((1.76l*asin(0.05l*(1.2l*z1s-z2s))+1.97l*acos((z2s-2.0l*z1s)))*(1.12l*atan(z1s-z2s)*sin(0.37l*z3s+z1s)-asin(z3s-(z1s+0.15l*z2s))*acos(z3s*(z2s+z1s-z3s))*(atan(-1.15l*z1s+z2s)+atan(z3s-z1s-0.11l*z2s)))));
   return sin(acos(z1s+z2s)-asin(z1s-z2s))*cos(asin(z2s-z1s)-acos(z2s+z3s))-tan(cos(z2s-z3s)-sin(z3s-z2s))*tan(atan(z1s+z3s)-atan(z1s-z3s));

}


TComplexSTD GccF2Z_std()
{
 //return (pow(z1s-sin(z1s),z2s-cos(z2s))/(tan(1.5l*asin(1.1l*z1s/(1.2l*z1s+z2s))))+pow(z2s-sin(z1s*1.2l)/cos(z2s+1.1l),n+k)/(z1s+2.1l*z2s))*(2.1l*sinh(z1s/z2s)*sin(0.17l*z1s-z2s)-3.2l*cosh(z1s/(z1s-z2s)*cos(z1s-0.25l*z2s))-tanh(z2s/(z3s+z2s))/(exp(2.1l*z1s/z3s))*asin(1.1l*z1s/(2.1l*z1s+z2s))-2.1l*atan(1.1l*z1s-z2s)*atan(1.5l*z1s+z2s));
   return sinh(acosh(z1s+z2s)-asinh(z1s-z2s))*cosh(asinh(z2s-z1s)-acosh(z2s+z3s))*(sinh(atanh(z2s-z3s)-atanh(z3s-z2s))+cosh(tanh(z1s+z3s)-tanh(z1s-z3s)));
}



TComplexSTD GccF3Z_std()
{
 //return  (cos(z1s+sin(z1s))*sin(z2s+cos(z2s))-sin(cos(z1s+cos(z1s+z2s)))*cos(z2s+cos(z1s+sin(z1s+z2s))))*(cos(sin(z2s)/z2s+z1s+cos(z1s))*sin(z1s+sin(z1s+z2s))-cos(z2s+cos(z1s+z2s))*sin(z1s+cos(z1s+z2s))+sin(z2s+cos(z1s+sin(z1s+z2s)))*sin(cos(z1s+cos(z1s+z2s)))/(sin(z1s+sin(z1s))*cos(z2s+cos(z2s))+cos(cos(z1s+cos(z1s+z2s)))*sin(sin(z2s)/z2s+z1s+cos(z1s))-sin(z2s+cos(z1s+sin(z1s+z2s)))*sin(cos(z1s+cos(z1s+z2s)))));
  return  (pow(z1s-sin(z1s),z2s-cos(z2s))/(tan(asin(z1s/(z1s+z2s))))+pow(z2s-sin(z2s-z1s)/cos(z3s),n+k)/(z3s-z2s))*(sinh(z1s/z2s)*sin(z1s-z2s)-cosh(z1s/(z3s+z1s)*cos(z2s-z3s))-tanh(z2s/(z3s+z2s))/(exp(z1s/z3s))*asin(z1s/(z3s-z1s))-atan(z1s-z3s)*atan(z1s+z3s));

}


TComplexSTD GccF4Z_std()
{
 //return (sin(z1s/(z1s+z2s))-sinh(z1s/(z1s+z2s))*asin(z1s/(z1s+z2s)))*(cosh(z1s/(z1s+z2s))*acos(z1s/(z1s+z2s))+cos(z1s/(z1s+z2s)))*(tanh(z1s/(z1s+z2s))-exp(z1s/(z1s+z2s)));
  return (cos(z1s+z2s)-sin(z1s+z3s))*(sin(cos(z1s+z2s)+sin(z1s+z3s))-cos(z1s+z3s)*sin(z1s+z2s))*tan(cos(z2s+z3s))*tan(sin(sin(z1s+z3s)-sin(z1s+z2s)))/(cos(sin(z1s+z3s)-sin(z1s+z2s))-sin(z2s+z3s)*sin(z1s-z2s))*tan(cos(z1s+z2s)*sin(z1s+z3s))*(cos(cos(z1s+z2s)+sin(z1s+z3s))-sin(cos(z1s+z2s)+sin(z1s+z3s)));

}


TComplexSTD GccF5Z_std()
{
 //return  (pow(sin(z1s+z2s),k+2*n-10)*pow(cos(z1s*z2s),n+k-7)-pow(z1s-sin(z1s*z2s),pow(cos(z1s*z2s),n+k-7))*pow(z2s-cos(z1s+z2s),pow(sin(z1s+z2s),k+2*n-10)))/(sin(pow(sin(z1s+z2s),k+2*n-10))/cos(pow(cos(z1s*z2s),n+k-7))-sin(pow(z1s-sin(z1s),z2s-cos(z2s)))/cos(pow(z1s-sin(z1s),z2s-cos(z2s))));
  return (cosh(z1s/z2s)-sinh(z1s/z3s))*(sinh(cosh(z1s/z2s)+sinh(z1s/z3s))-cosh(z1s/z3s)*sinh(z1s/z2s))*tanh(cosh(z2s/z3s))*tanh(sinh(sinh(z1s/z3s)-sinh(z1s/z2s)))/(cosh(sinh(z1s/z3s)-sinh(z1s/z2s))-sinh(z2s/z3s)*sinh(z1s/z2s))*tanh(cosh(z1s/z2s)*sinh(z1s/z3s))*(cosh(cosh(z1s/z2s)+sinh(z1s/z3s))-sinh(cosh(z1s/z2s)+sinh(z1s/z3s)));

}



TComplexSTD GccF6Z_std()
{
 return  (sin(z1s/(z1s+z2s))-sinh(z1s/(z1s+z2s))*asin(z1s/(z1s+z2s)))*(cosh(z1s/(z1s+z2s))*acos(z1s/(z1s+z2s))+cos(z1s/(z1s+z2s)))*(tanh(z1s/(z1s+z2s))-exp(z1s/(z1s+z2s)));

}


TComplexSTD GccF7Z_std()
{
 return  (pow(sin(z1s+z2s),k+2*n-10)*pow(cos(z1s*z2s),n+k-7)-pow(z1s-sin(z1s*z2s),pow(cos(z1s*z2s),n+k-7))*pow(z2s-cos(z1s+z2s),pow(sin(z1s+z2s),k+2*n-10)))/(sin(pow(sin(z1s+z2s),k+2*n-10))/cos(pow(cos(z1s*z2s),n+k-7))-sin(pow(z1s-sin(z1s),z2s-cos(z2s)))/cos(pow(z1s-sin(z1s),z2s-cos(z2s))));

}



TComplexSTD GccF8CZ_std()
{
  return  Ais*cos(sin(Cis*pow(Ais/Cis,Cis/(Ais-Bis*Cis))/(Bis-Cis))*z1s/cos(Ais/exp(Cis/Bis)*z2s+Bis/pow(Ais-Bis,Ais/(Cis*sin(Ais*Bis/Cis)))))*pow(sin(Ais*Bis/(Ais-Cis))+cos(Cis/(Ais/Bis-Bis/Cis)),z1s/z2s);
}





//sp3(z1,sp2(z1+z3,x+z2)+sp2(sp2(z1+z2,t+y)+z2,sp3(z1,z3,z2)+sp2(x+y,z1+z2)),z3+z1+sp2(z3+x,y+z1))+sp2(sp2(x+t,y+x),sp1(z2+z3)+sp1(x+t))+sp3(x,y,y+t+x)+sp2(z1+z2+sp2(z2,t+z3),sp1(z3)+x+z2)+sp2(sp2(z3+y,x+z2),z2);


TComplexNum GccFE13Z()
{
return sp3(z1*x,sp2(z1+z3,x-z2)-sp2(sp2(z1+z2,t+y)-z2,sp3(z1+y,z3*1.25,-z2)*sp2(x+y,z1-z2)),z3-z1*sp2(z3*x,-y*z1))*sp2(-sp2(x*t,-y*x),sp1(z2+z3)*sp1(x-t))-sp3(1.75*x,y-t,y-t*x)*sp2(z1-z2*sp2(z2-t,t+z3),sp1(z3-z2)*x-z2)*sp2(-sp2(z3+y,x+z2),z2-z3);

//return   sp3(z1,sp2(z1+z3,x-z2)-sp2(sp2(z1+z2,t+y)-z2,sp3(z1,z3,z2)*sp2(x+y,z1-z2)),z3-z1*sp2(z3*x,y*z1))*sp2(sp2(x*t,y*x),sp1(z2+z3)*sp1(x-t))-sp3(x,y,y-t*x)*sp2(z1-z2*sp2(z2,t+z3),sp1(z3)*x-z2)*sp2(sp2(z3+y,x+z2),z2);
  //return   sp3(z1,sp2(z1+z3,x+z2)+sp2(sp2(z1+z2,t+y)+z2,sp3(z1,z3,z2)+sp2(x+y,z1+z2)),z3+z1+sp2(z3+x,y+z1))+sp2(sp2(x+t,y+x),sp1(z2+z3)+sp1(x+t))+sp3(x,y,y+t+x)+sp2(z1+z2+sp2(z2,t+z3),sp1(z3)+x+z2)+sp2(sp2(z3+y,x+z2),z2);
  //return sp2(sp2(x+t,y+x),sp1(z2+z3)+sp1(x+t))+sp3(x,y,y+t+x)+sp2(z1+z2+sp2(z2,t+z3),sp1(z3)+x+z2)+sp2(sp2(z3+y,x+z2),z2);
  //return sp2(sp2(x+t,y+x),sp1(z2+z3))+sp2(z1+z2+sp2(z2,t+z3),sp1(z3)+x+z2);
  //return sp2(sp2(x+t,y+x),sp1(z2+z3))+sp2(z1+z2+sp2(z2,t+z3),x+z2);
  //return sp2(y+x,z2+z3)+sp2(z1+z2+t+z3,x+z2);
  //return sp2(z1+z2+t+z3,x+z2);
  //return sp2(y,z2)+sp2(z3,z1)+x;
}





TComplexNum GccFE13AZ()
{
 return sp3(z1-sp3(z1*y,-t*z2,z3+z1),x*sp2(x+y,sp1(0.57*y)),sp2(z1+x,y-z2)-z2)*sp3(sp2(x-y,sp1(x*1.15)),z2-sp2(z1-z3,z2*x),-sp3(sp2(x*y,y+t)*x,2.1*x-y,y*sp2(2.15*y,1.17*t)));
}


TComplexNum GccFE13BZ()
{
  return sp8(ve,j+3,z1-sp8(ve,n+2,z2-sp8(ve,k+3,z1-z2,vd,j+n,z2-sp8(ve,k+n,t*z1-y,vd,j+n,z2-z3,vi,j+2),vi,j+2),vd,k+2,t*(z1+z2),vi,n+2*j),vd,j+n,z3-sp8(ve,n*3+1,-z3*x,vd,j+n-1,-z1*1.15,vi,k+2*n-1)/sp8(ve,j,z3+x/sp8(ve,k+n+2,z1*y+sp8(ve,n*4-2,z3-z1*2.73,vd,j+n+1,y*z3,vi,k+5),vd,n+3,z1*t+z3/sp8(ve,j+k,z2*1.17-z3,vd,j+k*2,z3*y-2.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1+z3*2.12,vi,n+2*k),vi,n+2);
};



TComplexNum GccFE14Z()
{
  //return spall(ve,n,z1,vd,n,x,z2,y,vi,k);
  return spall(ve,n+3,spall(ve,n+1,z1/z2,vd,j+k-1,x,z2/spall(ve,j+3,z3-spall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/spall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-spall(ve,k+3,z1/spall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*spall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j);

}




TComplexNum GccFE15Z()
{
   return (sp3(z1/z2-sp2(z1-z2,z1/z2),z1/sp2(z1-z2,z1/z2),sp1(z1/z2)*sp1(-sp1(z2/z1)))*sp1(z1/z2)-sp2(z2/sp2(z1-z2,z1/z2),-z1/sp2(z1-z2,z1/z2))*sp1(-sp1(z2/z1)))/(sp1(z1/z2-sp2(z1-z2,z1/z2))-sp2(z1/sp2(z1-z2,z1/z2),z2/sp2(z1-z2,z1/z2))+sp2(z1-z2,z1/z2)*sp3(z1/z2-sp2(z1-z2,z1/z2),z1/sp2(z1-z2,z1/z2),sp1(z1/z2)*sp1(-sp1(z2/z1))));
}



TComplexNum GccFE15ZC()
{
   return sp2(sp3(Ai-Bi,Bi/Ci,Ci/(Bi-Ai))*Ai/sp2(sp2(Bi/sp1(Ai/(Bi+Ci)),Bi/(Ci+Ai)),Ai-Bi*Ci)*z1/Bi,z2/sp2(Ai*sp1(Ci/Bi),Ai/(Bi+Ai)))*sp3((Ci-Ai)*sp1(Ci/Bi)/sp2(Bi/(Ci+Ai/Bi),Bi/(Ci-Ai))*z2/sp1(Ci/Ai),sp1(Ci/Bi)/sp1(Bi/Ai),z2/sp2(Bi-Ci/Ai,Ci-Bi/Ci))*sp2(-Ai/(Ci+Bi/Ai),z1/(Ai-Bi));
}




TComplexSTD GccFE15ZC_std()
{
   return sp2_std(sp3_std(Ais-Bis,Bis/Cis,Cis/(Bis-Ais))*Ais/sp2_std(sp2_std(Bis/sp1_std(Ais/(Bis+Cis)),Bis/(Cis+Ais)),Ais-Bis*Cis)*z1s/Bis,z2s/sp2_std(Ais*sp1_std(Cis/Bis),Ais/(Bis+Ais)))*sp3_std((Cis-Ais)*sp1_std(Cis/Bis)/sp2_std(Bis/(Cis+Ais/Bis),Bis/(Cis-Ais))*z2s/sp1_std(Cis/Ais),sp1_std(Cis/Bis)/sp1_std(Bis/Ais),z2s/sp2_std(Bis-Cis/Ais,Cis-Bis/Cis))*sp2_std(-Ais/(Cis+Bis/Ais),z1s/(Ais-Bis));
}





// std ********************************

TComplexSTD GccFE13Z_std()
{
 return sp3_std(z1s*x,sp2_std(z1s+z3s,x-z2s)-sp2_std(sp2_std(z1s+z2s,t+y)-z2s,sp3_std(z1s+y,z3s*TFloatType(1.25),-z2s)*sp2_std(x+y,z1s-z2s)),z3s-z1s*sp2_std(z3s*x,-y*z1s))*sp2_std(-sp2(x*t,-y*x),sp1_std(z2s+z3s)*sp1(x-t))-sp3(TFloatType(1.75)*x,y-t,y-t*x)*sp2_std(z1s-z2s*sp2_std(z2s-t,t+z3s),sp1_std(z3s-z2s)*x-z2s)*sp2_std(-sp2_std(z3s+y,x+z2s),z2s-z3s);
}


TComplexSTD GccFE13AZ_std()
{
 return sp3_std(z1s-sp3_std(z1s*y,-t*z2s,z3s+z1s),x*sp2(x+y,sp1(0.57*y)),sp2_std(z1s+x,y-z2s)-z2s)*sp3_std(sp2(x-y,sp1(x*1.15)),z2s-sp2_std(z1s-z3s,z2s*x),-sp3(sp2(x*y,y+t)*x,2.1*x-y,y*sp2(2.15*y,1.17*t)));
}


TComplexSTD GccFE13BZ_std()
{
  return sp8_std(ve,j+3,z1s-sp8_std(ve,n+2,z2s-sp8_std(ve,k+3,z1s-z2s,vd,j+n,z2s-sp8_std(ve,k+n,t*z1s-y,vd,j+n,z2s-z3s,vi,j+2),vi,j+2),vd,k+2,t*(z1s+z2s),vi,n+2*j),vd,j+n,z3s-sp8_std(ve,n*3+1,-z3s*x,vd,j+n-1,-z1s*TFloatType(1.15),vi,k+2*n-1)/sp8_std(ve,j,z3s+x/sp8_std(ve,k+n+2,z1s*y+sp8_std(ve,n*4-2,z3s-z1s*TFloatType(2.73),vd,j+n+1,y*z3s,vi,k+5),vd,n+3,z1s*t+z3s/sp8_std(ve,j+k,z2s*TFloatType(1.17)-z3s,vd,j+k*2,z3s*y-TFloatType(2.1),vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1s+z3s*TFloatType(2.12),vi,n+2*k),vi,n+2);
};



TComplexSTD GccFE14Z_std()
{
 return spall_std(ve,n+3,spall_std(ve,n+1,z1s/z2s,vd,j+k-1,x,z2s/spall_std(ve,j+3,z3s-spall_std(ve,n+9,z1s-z3s+z1s,vd,k*j,x*t,z2s*z3s,y-t,vi,j+9),vd,k+7,x,z1s-z2s/spall_std(ve,n+3+j,z3s/z1s,vd,j+k+7,x,z2s/z3s,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2s-spall_std(ve,k+3,z1s/spall_std(ve,n+3+k,z3s*t,vd,j+k+9,x,z1s-z3s,t-y*x,vi,n+k+j),vd,k+3,x/t,z2s*spall_std(ve,j+k+7,z1s*y,vd,j+3*k,x,z2s*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j);

}


TComplexSTD GccFE15Z_std()
{
   return (sp3_std(z1s/z2s-sp2_std(z1s-z2s,z1s/z2s),z1s/sp2_std(z1s-z2s,z1s/z2s),sp1_std(z1s/z2s)*sp1_std(-sp1_std(z2s/z1s)))*sp1_std(z1s/z2s)-sp2_std(z2s/sp2_std(z1s-z2s,z1s/z2s),-z1s/sp2_std(z1s-z2s,z1s/z2s))*sp1_std(-sp1_std(z2s/z1s)))/(sp1_std(z1s/z2s-sp2_std(z1s-z2s,z1s/z2s))-sp2_std(z1s/sp2_std(z1s-z2s,z1s/z2s),z2s/sp2_std(z1s-z2s,z1s/z2s))+sp2_std(z1s-z2s,z1s/z2s)*sp3_std(z1s/z2s-sp2_std(z1s-z2s,z1s/z2s),z1s/sp2_std(z1s-z2s,z1s/z2s),sp1_std(z1s/z2s)*sp1_std(-sp1_std(z2s/z1s))));
}




TComplexNum GccA6Z()
{
     INT32 ci,cj,L;
     TComplexNum res;


L = vd.size()-1;
     //L = 99;
     res.re = 0; res.im = 0;
     for(ci=0; ci <= L; ci++)
     {
          if(vd[ci] > 0)
          {
             for(cj=0; cj <= L; cj++)
               {
                 if((cj > ci)&&(vd[cj] > vd[ci]))
                    {
                        res=res-z1*vd[cj-ci];
                    }
                    else
                    {
                        res=res+z1*vd[cj];
                    };

               }
          }
          else
          {
              //res=res-z2*vd[L-i];
              res.re=res.re-z2.re*vd[L-ci];
              res.im=res.im-z2.im*vd[ci];
         }
     };

  return res;

};






TComplexNum GccA6FZ()
{
     INT32 ci,cj,L;
      TComplexNum res;


L = vdf.size()-1;
     //L = 99;
     res.re = 0; res.im = 0;

     for(ci=1; ci <= L; ci++)  /// in GCC count from 1  !! (if array in Foreval as "fast connect")
     {
          if(vdf[ci] > 0)
          {
             for(cj=1; cj <= L; cj++)  /// in GCC count from 1  !! (if array in Foreval as "fast connect")
               {
                 if((cj > ci)&&(vdf[cj] > vdf[ci]))
                    {
                        res=res-z1*vdf[cj-ci+1];  /// in GCC count from 1  !! (if array in Foreval as "fast connect")
                    }
                    else
                    {
                        res=res+z1*vdf[cj];

                    };

               }
          }
          else
          {
              //res=res-z2*vdf[L+1-i];  /// in GCC count from 1  !! (if array in Foreval as "fast connect")
              res.re=res.re-z2.re*vdf[L-ci+1]; /// in GCC count from 1  !! (if array in Foreval as "fast connect")
              res.im=res.im-z2.im*vdf[ci];
         }
     };

  return res;

};





void TestEvalCmpR(PTGccTestR GccFunc, Pointer32 FFunc)
{
       TFloatType resG,resF,h;
       Extended dh,dx,dy,dt;
       double dresG,dresF,si;
       INT32 t1,t2,i,PerfG,PerfF,dn,dk,dj;
       PTGccTestR ForevalFunc;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/


       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG=0.0; //h=0.0000001;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;


              /** GCC runs **/

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
		  n=n+dn; k=k+dk; j=j+dj;

	    resG=resG+GccFunc();

          j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };



                 /** Foreval runs **/
       ForevalFunc =  (PTGccTestR)FFunc; /// call compiled Foreval expression as TFloatType func()

       RefReshVar();
       resF=0.0;

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
		  n=n+dn; k=k+dk; j=j+dj;


	    //resF=resF+flResultR(FFunc);
	    resF=resF + ForevalFunc();   /// call compiled Foreval expression as TFloatType func(); runs some faster compared to flResultR(FFunc)

          j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };


   // dresG=resG; dresF=resF;
    printf("\n");
    printf("Result GCC    : %.12e\n", (double)resG/GNC);
    printf("Result Foreval: %.12e\n", (double)resF/GNC);
    printf("Perfomance GCC  Expr/ms    :  %5d\n", PerfG);
    printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfF);
    printf("\n");
};



void TestEvalFR(Pointer32 FFunc)
{
       TFloatType resG,resF,h;
       Extended dh,dx,dy,dt;
       double dresG,dresF,si;
       INT32 t1,t2,i,PerfG,PerfF,dn,dk,dj;
       PTGccTestR ForevalFunc;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

       ForevalFunc =  (PTGccTestR)FFunc; /// call compiled Foreval expression as TFloatType func()

       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resF=0.0; //h=0.0000001;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		 x=x+dx; y=y-dy; t=t+dt;
		 n=n+dn; k=k+dk; j=j+dj;

	    //resF=resF+flResultR(FFunc);
	    resF=resF + ForevalFunc();   /// call compiled Foreval expression as TFloatType func(); runs some faster compared to flResultR(FFunc)


	     j=j-dj; k=k-dk;  n=n-dn;
         //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };


   // dresF=resF;
    printf("\n");
    printf("Result : %.12e\n", (double)resF/GNC);
    printf("Perfomance   Expr/ms:  %5d\n", PerfF);
    printf("\n");
};



void TestEvalCmpVR(PTGccTestR GccFunc, Pointer32 FFunc)
{
       TFloatType resG,resF,h;
       Extended dh,dx,dy,dt;
       double dresG,dresF,si;
       INT32 t1,t2,ni,i,PerfG,PerfF,dn,dk,dj,ar,br,SZ,L;
       PInteger     pint1;
       PTGccTestR ForevalFunc;

       SZ = rand() % 10+100 ;  /// size array changed in rand[95,105]

       vdf.resize(SZ+2);  ///change size
       ar=1; br=50; L = vdf.size()-1;

       for(ni=1; ni <= L; ni++)  /// in C++ count from 1  !! (if array in Foreval as "fast connect")
       {
           vdf[ni]=ni+1;
           vdf[ni]=pow((double)(-1),(Int32)(ni+1))*vdf[ni]*0.5;
       };


       /// to write length: (If the size of the array does not change, this is not necessary)**/
           adrVDF=&vdf[1];
           pint1 = (PInteger)adrVDF;
           pint1=pint1-1;   /// = &vdf[1]-4b; or = &vdf[0]+4b;  sizeof(double) = 8
           if (DLLCompiledBy == Delphi) {SZ = vdf.size()-1;} else {SZ=vdf.size()-2;};  // DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
           *pint1 = SZ;  /// pint1 = &vdf[1]-4b;  *pint1 <- length


 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);
       resG=0.0; //h=0.0000001;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;

                      /** GCC runs **/
       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
          n=n+dn; k=k+dk; j=j-dj;

	    resG=resG+GccFunc();

           k=k-dk; j=j+dj; n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };


                      /** Foreval runs **/
       RefReshVar();
       resF=0.0; //h=0.0000001;

        ForevalFunc =  (PTGccTestR)FFunc; /// call compiled Foreval expression as TFloatType func()

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
          n=n+dn; k=k+dk; j=j-dj;

        //resF=resF+flResultR(FFunc);
         resF=resF + ForevalFunc();   /// call compiled Foreval expression as TFloatType func(); runs some faster compared to flResultR(FFunc)

	     k=k-dk; j=j+dj; n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };


   // dresG=resG; dresF=resF;
    //printf("\n");
    printf("Result GCC    : %.12e\n", (double)resG/GNC);
    printf("Result Foreval: %.12e\n", (double)resF/GNC);
    printf("Perfomance GCC  Expr/ms    :  %5d\n", PerfG);
    printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfF);
    //printf("\n");

};





void TestEvalCmpV_GCC(PTGccTestR GccFunc, double &_Res, INT32 &_Perf)
{
       TFloatType resG,resF,h;
       Extended dh,dx,dy,dt;
       double dresG,dresF,si;
       INT32 t1,t2,ni,i,PerfG,PerfF,dn,dk,dj,ar,br,SZ,L;
       PInteger     pint1;




 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);
       resG=0.0; //h=0.0000001;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
          //n=n+dn; k=k+dk; j=j-dj;

	    resG=resG+GccFunc();

          //k=k-dk; j=j+dj; n=n-dn;
          t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };





    //printf("Result GCC    : %.12e\n", (double)resG/GNC);
    //printf("Result Foreval: %.12e\n", (double)resF/GNC);
    //printf("Perfomance GCC  Expr/ms    :  %5d\n", PerfG);
    //printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfF);

   _Res = (double)resG/GNC;
   _Perf = PerfG;
};





void TestEvalCmpV_Foreval(Pointer32 FFunc, double &_Res, INT32 &_Perf)
{
       TFloatType resG,resF,h;
       Extended dh,dx,dy,dt;
       double dresG,dresF,si;
       INT32 t1,t2,ni,i,PerfG,PerfF,dn,dk,dj,ar,br,SZ,L;
       PInteger     pint1;
       PTGccTestR ForevalFunc;





 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);
       resG=0.0; //h=0.0000001;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;




       RefReshVar();
       resF=0.0; //h=0.0000001;
       ForevalFunc =  (PTGccTestR)FFunc; /// call compiled Foreval expression as TFloatType func()

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
          //n=n+dn; k=k+dk; j=j-dj;

        //resF=resF+flResultR(FFunc);
        resF=resF+ForevalFunc();   /// call compiled Foreval expression as TFloatType func(); runs some faster compared to flResultR(FFunc)

	     //k=k-dk; j=j+dj; n=n-dn;
         t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };



    //printf("Result GCC    : %.12e\n", (double)resG/GNC);
    //printf("Result Foreval: %.12e\n", (double)resF/GNC);
    //printf("Perfomance GCC  Expr/ms    :  %5d\n", PerfG);
    //printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfF);

   _Res = (double)resF/GNC;
   _Perf = PerfF;
};




void TestEvalCmpDetMulMatrix(PTGccTestR GccFunc, Pointer32 FFunc, Pointer32 FFuncP)
{
       TFloatType resG,resF,resFp,h;
       Extended dh,dx,dy,dt;
       double dresG,dresF,si;
       INT32 t1g,t2g,t1f,t2f,t1fp,t2fp,ni,i,PerfG,PerfF,PerfFp,dn,dk,dj,ar,br,SZ,L;
       PInteger     pint1;

       //generation of random size and elements are need for suppression of GCC super optimizations (for honest comparison)
       srand(time( 0 ));
       LenSCM1u = rand()%3+7 ;      // size square matrices:  LenSCM1u x LenSCM1u; Is changed in rand [7,9];
       SizeRandElem = 7;           // matrices elements in [0, SizeRandElem]
       RandSizeMatrixAndFillRandElem();   // generation an filling random elements in [0, SizeRandElem]




       /// to write length: (If the size of the array does not change, this is not necessary)**/
         //  adrVDF=&vdf[1];
         //  pint1 = (PInteger)adrVDF;
         //  pint1=pint1-1;   /// = &vdf[1]-4b; or = &vdf[0]+4b;  sizeof(double) = 8
         //  if (DLLCompiledBy == Delphi) {SZ = vdf.size()-1;} else {SZ=vdf.size()-2;};  // DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
        //   *pint1 = SZ;  /// pint1 = &vdf[1]-4b;  *pint1 <- length


 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/


        resG=0.0; resF=0.0; resFp=0.0;
        t2g=0; t2f=0; t2fp=0;

       for(i=0; i <= GNC; i++)
       {

         LenSCM1u = rand()%3+7 ;            // size square matrices:  LenSCM1u x LenSCM1u; Is changed in rand [7,9];
         //SizeRandElem = 7;                 // matrices elements in [-SizeRandElem, SizeRandElem]
         RandSizeMatrixAndFillRandElem();   // generation an filling random elements in [0, SizeRandElem]

         t1g=GetTickCount();
	       resG=resG+GccFunc();
	     t2g=t2g+GetTickCount()-t1g;

         t1f=GetTickCount();
	       resF=resF+flResultR(FFunc);
         t2f=t2f+GetTickCount()-t1f;

         t1fp=GetTickCount();
	       resFp=resFp+flResultR(FFunc);
         t2fp=t2fp+GetTickCount()-t1fp;

       }


       if (t2g == 0)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2g));
       };


       if (t2f == 0)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2f));
       };

        if (t2fp == 0)
       {
         PerfFp=0;
       }
       else
       {
        PerfFp=INT32(GNC/(t2fp));
       };





   // dresG=resG; dresF=resF;
    //printf("\n");
    printf("Result GCC    : %.12e\n", (double)resG/GNC);
    printf("Result Foreval: %.12e\n", (double)resF/GNC);
    printf("Result Foreval: %.12e\n", (double)resFp/GNC);
    printf("Perfomance GCC  Expr/ms    :  %5d\n", PerfG);
    printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfF);
    printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfFp);
    //printf("\n");

};







void FillRandArrayU(Int32 Len)
{
    Int32       ni;
    TFloatType  rv;


       vpr.resize(Len);
       flSetLength(adrVPR, VType, Len);


       srand( time( 0 ) );

       for(ni=0; ni <= Len-1; ni++)
       {
             //rv = rand() / 10+100 ;
             rv = ((TFloatType)rand() / RAND_MAX) * 99+1;//(high - low) + low;
             vpr[ni] = rv;


             #ifdef   EXTENDED_FLOAT
                flSetArrayValueE(adrVPR,ni,vpr[ni]);
             #else
                flSetArrayValueD(adrVPR,ni,vpr[ni]);
             #endif

       };

};



void ReLoadCopyArrayU( Int32 Len)
{
             //(Pointer32)(*((PInteger)adrArray));  /// = &Array[0] in Foreval

             #ifdef   EXTENDED_FLOAT
                flCopyArrayExtDSC(&vps[0], &vpr[0],12,12,Len);
                flCopyArrayExt((Pointer32)(*((PInteger)adrVPS)), (Pointer32)(*((PInteger)adrVPR)), Len);
             #else
                flCopyArrayDbl(&vps[0], &vpr[0], Len);
                flCopyArrayDbl((Pointer32)(*((PInteger)adrVPS)), (Pointer32)(*((PInteger)adrVPR)), Len);
             #endif

}


void TestEvalCmpVPR(PTGccTestR GccFunc, Pointer32 FFunc)
{
       TFloatType resG,resF,h,rv,rv1;
       Extended dh,dx,dy,dt;
       double dresG,dresF,si;
       INT32 t1g,t2g,t1f,t2f,ttc,ni,i,PerfG,PerfF,dn,dk,dj,ar,br,SZ,L;
       PInteger     pint1;
       PTGccTestR ForevalFunc;

       //L =  rand() % 10+40 ;
       L = LenVR;


       vps.resize(L);
       flSetLength(adrVPS, VType, L);

       FillRandArrayU(L);
       ReLoadCopyArrayU(L);

/*
       srand( time( 0 ) );

       for(ni=0; ni <= L-1; ni++)
       {
             //rv = rand() / 10+100 ;
             rv = ((TFloatType)rand() / RAND_MAX) * 99+1;//(high - low) + low;
             vps[ni] = rv;


             #ifdef   EXTENDED_FLOAT
                flSetArrayValueE(adrVPS,ni,vps[ni]);
             #else
                flSetArrayValueD(adrVPS,ni,vps[ni]);
             #endif

       };

*/

          /**
         resG = 0.0;  resF = 0.0;
         for(ni=0; ni <= L-1; ni++)
         {

             resG = resG+vps[ni];


             flGetArrayValueE(adrVPS,ni,rv);
             resF = resF+rv;

        };

         **/


               /**  Run Gcc **/

       resG = 0.0;  ttc = 0;
       t2g=0;
       //t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {

         t1g=GetTickCount();
            resG=resG+GccFunc();
         t2g=t2g+GetTickCount()-t1g;

         ReLoadCopyArrayU(L);

       }
      // t2=GetTickCount();

       if (t1f == t2g)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2g));
       };



       /**  Run Foreval **/

       ForevalFunc =  (PTGccTestR)FFunc; /// call compiled Foreval expression as TFloatType func()
       resF=0.0;
       t2f=0;
       for(i=0; i <= GNC; i++)
       {
          t1f=GetTickCount();
            //resF=resF+flResultR(FFunc);
            resF=resF+ForevalFunc();   /// call compiled Foreval expression as TFloatType func(); runs some faster compared to flResultR(FFunc)
          t2f=t2f+GetTickCount()-t1f;

         ReLoadCopyArrayU(L);

       }


       if (t1f == t2f)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2f));
       };

         /**
         resG = 0.0;  resF = 0.0;
         for(ni=0; ni <= L-1; ni++)
         {

             resG = resG+vps[ni];


             flGetArrayValueE(adrVPS,ni,rv);
             resF = resF+rv;

        };
        **/

   // dresG=resG; dresF=resF;

    printf("\n");
    printf("Result GCC    : %.12e\n", (double)resG/GNC);
    printf("Result Foreval: %.12e\n", (double)resF/GNC);
    printf("Perfomance GCC  Expr/ms    :  %5d\n", PerfG);
    printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfF);
    printf("\n");


};




void TestEvalCmpZ(PTGccTestZ GccFunc, Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im,si;
       INT32 t1,t2,i,PerfG,PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplex resF;
       string S1r,S2r,SResG,SResF;
       PTProc ForevalProc;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

        /// GCC TEST
       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG.re=0.0; resG.im=0.0; //h=0.0000001;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		   x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
          z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
	    resG=resG+GccFunc();
	    //resG=GccFunc();
           //z3.im=z3.im+dt; z3.re=z3.re-dt; z1.re=z1.re-dx; z2.re=z2.re-dy; z2.im=z2.im+dy;  z1.im=z1.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };



         /// FOREVAL TEST
       ForevalProc =  (PTProc)FFunc; /// call compiled Foreval expression as  procedure: proc()

       RefReshVar();
       resf.re=0.0; resf.im = 0.0;//h=0.0000001;

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {


	    //resF=resF+flResultF(FFunc);
          x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
	      //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;

	        #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
                z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif

	    //flResult(FFunc);
	      ForevalProc();   /// call compiled Foreval expression as proc(); runs some faster compared to flResult(FFunc)

	      //z3f.im=z3f.im+dt; z3f.re=z3f.re-dt; z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z2f.im=z2f.im+dy;  z1f.im=z1f.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };
/*
    dresG_re=resG.re/GNC; dresG_im=resG.im/GNC;
    dresF_re=resf.re/GNC; dresF_im=resf.im/GNC;

    S1r=FloatToStr(dresG_re);
    S2r=FloatToStr(dresG_im);
    SResG=S1r+"  "+S2r+"i";

    S1r=FloatToStr(dresF_re);
    S2r=FloatToStr(dresF_im);
    SResF=S1r+"  "+S2r+"i";





    printf("\n");
    printf("Result GCC     :  %.12f", dresG_re); printf(" "); printf("%.12f", dresG_im); printf("i\n");
    printf("Result ForevalZ:  %.12f", dresF_re); printf(" "); printf("%.12f", dresF_im); printf("i\n");
 */

    printf("Result GCC      :  %.12e", (double)(resG.re/GNC)); printf(" "); printf("%.12e",  (double)(resG.im/GNC)); printf("i\n");
    printf("Result Foreval  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");


    //printf("Result ForevalZ:  %.17f\n", SResF.c_str());
    printf("Perfomance GCC  Expr/ms     :  %5d\n", PerfG);
    printf("Perfomance Foreval   Expr/ms:  %5d\n", PerfF);
    printf("\n");

};



void TestEvalCmpZ_std(PTGccTestZ GccFunc, PTGccTestZ_std GccFunc_std, Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im,si;
       INT32 t1,t2,i,PerfG,PerfG_std,PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplexSTD resG_std;
       TComplex resF;
       string S1r,S2r,SResG,SResF;
       PTProc ForevalProc;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

        /// GCC TEST
       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG.re=0.0; resG.im=0.0; //h=0.0000001;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		   x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
          z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
	    resG=resG+GccFunc();
	    //resG=GccFunc();
           //z3.im=z3.im+dt; z3.re=z3.re-dt; z1.re=z1.re-dx; z2.re=z2.re-dy; z2.im=z2.im+dy;  z1.im=z1.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };

  /// GCC TEST std::complex
       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG_std.real(0.0); resG_std.imag(0.0);
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		   x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
          //z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
          z1s.real(z1s.real()+dz1); z2s.real(z2s.real()+dz2); z3s.real(z3s.real()+dz3);
          z1s.imag(z1s.imag()-dz1); z2s.imag(z2s.imag()-dz2); z3s.imag(z3s.imag()-dz3);

	    resG_std=resG_std+GccFunc_std();
	    //resG=GccFunc();
           //z3.im=z3.im+dt; z3.re=z3.re-dt; z1.re=z1.re-dx; z2.re=z2.re-dy; z2.im=z2.im+dy;  z1.im=z1.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG_std=0;
       }
       else
       {
        PerfG_std=INT32(GNC/(t2-t1));
       };



         /// FOREVAL TEST
       RefReshVar();
       resf.re=0.0; resf.im = 0.0;//h=0.0000001;
       ForevalProc =  (PTProc)FFunc; /// call compiled Foreval expression as  procedure: proc()

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {


	    //resF=resF+flResultF(FFunc);
          x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
	      //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;

	        #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
                z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif

	    // flResult(FFunc);
	     ForevalProc();   /// call compiled Foreval expression as proc(); runs some faster compared to flResult(FFunc)

	      //z3f.im=z3f.im+dt; z3f.re=z3f.re-dt; z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z2f.im=z2f.im+dy;  z1f.im=z1f.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };
/*
    dresG_re=resG.re/GNC; dresG_im=resG.im/GNC;
    dresF_re=resf.re/GNC; dresF_im=resf.im/GNC;

    S1r=FloatToStr(dresG_re);
    S2r=FloatToStr(dresG_im);
    SResG=S1r+"  "+S2r+"i";

    S1r=FloatToStr(dresF_re);
    S2r=FloatToStr(dresF_im);
    SResF=S1r+"  "+S2r+"i";





    printf("\n");
    printf("Result GCC     :  %.12f", dresG_re); printf(" "); printf("%.12f", dresG_im); printf("i\n");
    printf("Result ForevalZ:  %.12f", dresF_re); printf(" "); printf("%.12f", dresF_im); printf("i\n");
 */

    printf("Result GCC OVRL :  %.12e", (double)(resG.re/GNC)); printf(" "); printf("%.12e",  (double)(resG.im/GNC)); printf("i\n");
    printf("Result GCC STD  :  %.12e", (double)(resG_std.real()/GNC)); printf(" "); printf("%.12e",  (double)(resG_std.imag()/GNC)); printf("i\n");
    printf("Result Foreval  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");


    //printf("Result ForevalZ:  %.17f\n", SResF.c_str());
    printf("Perfomance GCC OVRL  Expr/ms :  %5d\n", PerfG);
    printf("Perfomance GCC STD   Expr/ms :  %5d\n", PerfG_std);
    printf("Perfomance Foreval   Expr/ms :  %5d\n", PerfF);
    printf("\n");

};



void TestEvalCmpZ_std(PTGccTestZ_std GccFunc_std, Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im,si;
       INT32 t1,t2,i,PerfG,PerfG_std,PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplexSTD resG_std;
       TComplex resF;
       string S1r,S2r,SResG,SResF;
       PTProc ForevalProc;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/



  /// GCC TEST std::complex
       RefReshVar();
       si=log10(GNC)/5;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);
       if (dn > 3){dn=3;};
       if (dk > 2){dk=2;};
       if (dj > 1){dj=1;};

       resG_std.real(0.0); resG_std.imag(0.0);
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.0135; dz2=dh*0.0357; dz3=0.0531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  // x=x+dx; y=y-dy; t=t+dt;
		  n=n+dn; k=k+dk; j=j+dj;
          //z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
          z1s.real(z1s.real()+dz1); z2s.real(z2s.real()+dz2); z3s.real(z3s.real()+dz3);
          z1s.imag(z1s.imag()-dz1); z2s.imag(z2s.imag()-dz2); z3s.imag(z3s.imag()-dz3);

	    resG_std=resG_std+GccFunc_std();

	    //resG=GccFunc();
           //z3.im=z3.im+dt; z3.re=z3.re-dt; z1.re=z1.re-dx; z2.re=z2.re-dy; z2.im=z2.im+dy;  z1.im=z1.im+dx;
          j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG_std=0;
       }
       else
       {
        PerfG_std=INT32(GNC/(t2-t1));
       };



         /// FOREVAL TEST
       RefReshVar();
       resf.re=0.0; resf.im = 0.0;//h=0.0000001;
       ForevalProc =  (PTProc)FFunc; /// call compiled Foreval expression as  procedure: proc()

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {


	    //resF=resF+flResultF(FFunc);
         // x=x+dx; y=y-dy; t=t+dt;
		  n=n+dn; k=k+dk; j=j+dj;

	      //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;

	        #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
                z1.re=z1.re+dz1; z1.im=z1.im-dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3;  z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z1f.im=z1f.im-dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3;  z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif

	    // flResult(FFunc);
	    ForevalProc();   ///call compiled Foreval expression as proc(); runs some faster compared to flResult(FFunc)


	      //z3f.im=z3f.im+dt; z3f.re=z3f.re-dt; z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z2f.im=z2f.im+dy;  z1f.im=z1f.im+dx;
          j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };



    printf("Result GCC STD  :  %.12e", (double)(resG_std.real()/GNC)); printf(" "); printf("%.12e",  (double)(resG_std.imag()/GNC)); printf("i\n");
    printf("Result Foreval  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");




    printf("Perfomance GCC STD   Expr/ms :  %5d\n", PerfG_std);
    printf("Perfomance Foreval   Expr/ms :  %5d\n", PerfF);
    printf("\n");

};



void TestEvalCmpPZ_std(PTGccTestZ_std GccFunc_std, Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im,si;
       INT32 t1,t2,i,PerfG,PerfG_std,PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplexSTD resG_std;
       TComplex resF;
       string S1r,S2r,SResG,SResF;
       PTProc ForevalProc;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/



  /// GCC TEST std::complex
       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG_std.real(0.0); resG_std.imag(0.0);
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  // x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
          //z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
          z1s.real(z1s.real()+dz1); //z2s.real(z2s.real()+dz2); z3s.real(z3s.real()+dz3);
          z1s.imag(z1s.imag()-dz1); //z2s.imag(z2s.imag()-dz2); z3s.imag(z3s.imag()-dz3);

	    resG_std=resG_std+GccFunc_std();
	    //resG=GccFunc();
           //z3.im=z3.im+dt; z3.re=z3.re-dt; z1.re=z1.re-dx; z2.re=z2.re-dy; z2.im=z2.im+dy;  z1.im=z1.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG_std=0;
       }
       else
       {
        PerfG_std=INT32(GNC/(t2-t1));
       };



         /// FOREVAL TEST
       RefReshVar();
       resf.re=0.0; resf.im = 0.0;//h=0.0000001;
       ForevalProc =  (PTProc)FFunc; /// call compiled Foreval expression as  procedure: proc()

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {


	    //resF=resF+flResultF(FFunc);
         // x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
	      //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;

	        #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
                z1.re=z1.re+dz1; z1.im=z1.im-dz1; //z2.re=z2.re+dz2; z3.re=z3.re+dz3;  z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z1f.im=z1f.im-dz1; //z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3;  z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif

	      //flResult(FFunc);
	      ForevalProc();   /// call compiled Foreval expression as proc(); runs some faster compared to flResult(FFunc)


	      //z3f.im=z3f.im+dt; z3f.re=z3f.re-dt; z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z2f.im=z2f.im+dy;  z1f.im=z1f.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };
/*
    dresG_re=resG.re/GNC; dresG_im=resG.im/GNC;
    dresF_re=resf.re/GNC; dresF_im=resf.im/GNC;

    S1r=FloatToStr(dresG_re);
    S2r=FloatToStr(dresG_im);
    SResG=S1r+"  "+S2r+"i";

    S1r=FloatToStr(dresF_re);
    S2r=FloatToStr(dresF_im);
    SResF=S1r+"  "+S2r+"i";





    printf("\n");
    printf("Result GCC     :  %.12f", dresG_re); printf(" "); printf("%.12f", dresG_im); printf("i\n");
    printf("Result ForevalZ:  %.12f", dresF_re); printf(" "); printf("%.12f", dresF_im); printf("i\n");
 */

   // printf("Result GCC      :  %.12e", (double)(resG.re/GNC)); printf(" "); printf("%.12e",  (double)(resG.im/GNC)); printf("i\n");
    printf("Result GCC STD  :  %.12e", (double)(resG_std.real()/GNC)); printf(" "); printf("%.12e",  (double)(resG_std.imag()/GNC)); printf("i\n");
    printf("Result Foreval  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");


    //printf("Result ForevalZ:  %.17f\n", SResF.c_str());
   // printf("Perfomance GCC  Expr/ms      :  %5d\n", PerfG);
    printf("Perfomance GCC STD   Expr/ms :  %5d\n", PerfG_std);
    printf("Perfomance Foreval   Expr/ms :  %5d\n", PerfF);
    printf("\n");

};




void TestEvalPZF(Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im,si;
       INT32 t1,t2,i,PerfG,PerfG_std,PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplexSTD resG_std;
       TComplex resF;

       string S1r,S2r,SResG,SResF;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/


       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       //resG_std.real(0.0); resG_std.imag(0.0);

       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;



         /// FOREVAL TEST
       RefReshVar();
       resf.re=0.0; resf.im = 0.0;//h=0.0000001;

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {


	    //resF=resF+flResultF(FFunc);
         // x=x+dx; y=y-dy; t=t+dt;
		  //n=n+dn; k=k+dk; j=j+dj;
	      //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;

	        #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
                z1.re=z1.re+dz1; z1.im=z1.im-dz1; //z2.re=z2.re+dz2; z3.re=z3.re+dz3;  z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z1f.im=z1f.im-dz1; //z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3;  z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif

	    flResult(FFunc);
	      //z3f.im=z3f.im+dt; z3f.re=z3f.re-dt; z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z2f.im=z2f.im+dy;  z1f.im=z1f.im+dx;
          //j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };
/*
    dresG_re=resG.re/GNC; dresG_im=resG.im/GNC;
    dresF_re=resf.re/GNC; dresF_im=resf.im/GNC;

    S1r=FloatToStr(dresG_re);
    S2r=FloatToStr(dresG_im);
    SResG=S1r+"  "+S2r+"i";

    S1r=FloatToStr(dresF_re);
    S2r=FloatToStr(dresF_im);
    SResF=S1r+"  "+S2r+"i";





    printf("\n");
    printf("Result GCC     :  %.12f", dresG_re); printf(" "); printf("%.12f", dresG_im); printf("i\n");
    printf("Result ForevalZ:  %.12f", dresF_re); printf(" "); printf("%.12f", dresF_im); printf("i\n");
 */

   // printf("Result GCC      :  %.12e", (double)(resG.re/GNC)); printf(" "); printf("%.12e",  (double)(resG.im/GNC)); printf("i\n");
    //printf("Result GCC STD  :  %.12e", (double)(resG_std.real()/GNC)); printf(" "); printf("%.12e",  (double)(resG_std.imag()/GNC)); printf("i\n");
    printf("Result Foreval  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");


    //printf("Result ForevalZ:  %.17f\n", SResF.c_str());
   // printf("Perfomance GCC  Expr/ms      :  %5d\n", PerfG);
    //printf("Perfomance GCC STD   Expr/ms :  %5d\n", PerfG_std);
    printf("Perfomance Foreval   Expr/ms :  %5d\n", PerfF);
    printf("\n");

};



void TestEvalCmpFEZ(PTGccTestZ GccFunc, Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,si,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im;
       INT32 t1,t2,i,PerfG,PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplex resF;
       string S1r,S2r,SResG,SResF;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

        ///GCC TEST
       RefReshVar();
       si=log10((Extended)GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG.re=0.0; resG.im=0.0; //h=0.0000001;
       dh=(Extended)1/(GNC);
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		   x=x+dx; y=y-dy; t=t+dt;
		   n=n+dn; k=k+dk; j=j+dj;
           z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
	    resG=resG+GccFunc();
           //z1.re=z1.re-dx; z2.re=z2.re-dy; z3.re=z3.re-dt; z1.im=z1.im+dx; z2.im=z2.im+dy; z3.im=z3.im+dt;
           j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };

       ///FOREVAL TEST
       RefReshVar();
       resf.re=0.0; resf.im = 0.0;//h=0.0000001;

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
		  n=n+dn; k=k+dk; j=j+dj;
	      //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
	       #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
	            z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif
	      flResult(FFunc);
	      //z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z3f.re=z3f.re-dt; z1f.im=z1f.im+dx; z2f.im=z2f.im+dy; z3f.im=z3f.im+dt;
          j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };
/*
    dresG_re=resG.re/GNC; dresG_im=resG.im/GNC;
    dresF_re=resf.re/GNC; dresF_im=resf.im/GNC;

    S1r=FloatToStr(dresG_re);
    S2r=FloatToStr(dresG_im);
    SResG=S1r+"  "+S2r+"i";

    S1r=FloatToStr(dresF_re);
    S2r=FloatToStr(dresF_im);
    SResF=S1r+"  "+S2r+"i";

*/



    printf("\n");
    printf("Result GCC OVRL :  %.12e", (double)(resG.re/GNC)); printf(" "); printf("%.12e",  (double)(resG.im/GNC)); printf("i\n");
    printf("Result Foreval  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");

    //printf("Result Foreval:  %.17f\n", SResF.c_str());
    printf("Perfomance GCC OVRL  Expr/ms :  %5d\n", PerfG);
    printf("Perfomance Foreval   Expr/ms :  %5d\n", PerfF);
    printf("\n");

};




void TestEvalCmpFEZ_std(PTGccTestZ GccFunc, PTGccTestZ_std GccFunc_std, Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,si,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im;
       INT32 t1,t2,i,PerfG,PerfG_std, PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplexSTD resG_std;
       TComplex resF;
       string S1r,S2r,SResG,SResF;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

        ///GCC TEST
       RefReshVar();
       si=log10((Extended)GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG.re=0.0; resG.im=0.0; //h=0.0000001;
       dh=(Extended)1/(GNC);
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		   x=x+dx; y=y-dy; t=t+dt;
		   n=n+dn; k=k+dk; j=j+dj;
           z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
	    resG=resG+GccFunc();
           //z1.re=z1.re-dx; z2.re=z2.re-dy; z3.re=z3.re-dt; z1.im=z1.im+dx; z2.im=z2.im+dy; z3.im=z3.im+dt;
           j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };




         ///GCC STD TEST
       RefReshVar();
       si=log10((Extended)GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resG_std.real(0.0); resG_std.imag(0.0); //h=0.0000001;
       dh=(Extended)1/(GNC);
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;


       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		   x=x+dx; y=y-dy; t=t+dt;
		   n=n+dn; k=k+dk; j=j+dj;
           //z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
          z1s.real(z1s.real()+dz1); z2s.real(z2s.real()+dz2); z3s.real(z3s.real()+dz3);
          z1s.imag(z1s.imag()-dz1); z2s.imag(z2s.imag()-dz2); z3s.imag(z3s.imag()-dz3);
	    resG_std=resG_std+GccFunc_std();

           //z1.re=z1.re-dx; z2.re=z2.re-dy; z3.re=z3.re-dt; z1.im=z1.im+dx; z2.im=z2.im+dy; z3.im=z3.im+dt;
           j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG_std=0;
       }
       else
       {
        PerfG_std=INT32(GNC/(t2-t1));
       };





       ///FOREVAL TEST
       RefReshVar();
       resf.re=0.0; resf.im = 0.0;//h=0.0000001;

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {
		  x=x+dx; y=y-dy; t=t+dt;
		  n=n+dn; k=k+dk; j=j+dj;
	      //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
	       #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
	            z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif
	      flResult(FFunc);
	      //z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z3f.re=z3f.re-dt; z1f.im=z1f.im+dx; z2f.im=z2f.im+dy; z3f.im=z3f.im+dt;
          j=j-dj; k=k-dk;  n=n-dn;
          //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };
/*
    dresG_re=resG.re/GNC; dresG_im=resG.im/GNC;
    dresF_re=resf.re/GNC; dresF_im=resf.im/GNC;

    S1r=FloatToStr(dresG_re);
    S2r=FloatToStr(dresG_im);
    SResG=S1r+"  "+S2r+"i";

    S1r=FloatToStr(dresF_re);
    S2r=FloatToStr(dresF_im);
    SResF=S1r+"  "+S2r+"i";

*/



    printf("\n");
    printf("Result GCC OVRL :  %.12e", (double)(resG.re/GNC)); printf(" "); printf("%.12e",  (double)(resG.im/GNC)); printf("i\n");
    printf("Result GCC STD  :  %.12e", (double)(resG_std.real()/GNC)); printf(" "); printf("%.12e",  (double)(resG_std.imag()/GNC)); printf("i\n");
    printf("Result Foreval  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");

    //printf("Result Foreval:  %.17f\n", SResF.c_str());
    printf("Perfomance GCC OVRL  Expr/ms :  %5d\n", PerfG);
    printf("Perfomance GCC STD   Expr/ms :  %5d\n", PerfG_std);
    printf("Perfomance Foreval   Expr/ms :  %5d\n", PerfF);
    printf("\n");

};




void TestEvalFZ(Pointer32 FFunc)
{

       Extended resGr,resGi,resFr,resFi,h,dh,dx,dy,dt,dz1,dz2,dz3;
       double dresG_re,dresG_im,dresF_re,dresF_im,si;
       INT32 t1,t2,i,PerfG,PerfF,dn,dk,dj;
       TComplexNum resG;
       TComplex resF;
       string S1r,S2r,SResG,SResF;

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

        ///FOREVAL TEST
       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);

       resf.re=0.0; resf.im = 0.0;//h=0.0000001;
       dh=(Extended)1/(GNC);
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {

           x=x+dx; y=y-dy; t=t+dt;
           n=n+dn; k=k+dk; j=j+dj;
	       //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
	       #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
                z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif
	     flResult(FFunc);
	      //z1f.re=z1f.re-dx; z2f.re=z2f.re-dy; z3f.re=z3f.re-dt; z1f.im=z1f.im+dx; z2f.im=z2f.im+dy; z3f.im=z3f.im+dt;
           j=j-dj; k=k-dk;  n=n-dn;
           //t=t-dt;  y=y+dy; x=x-dx;
       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };

/*
    dresF_re=resf.re/GNC; dresF_im=resf.im/GNC;


    S1r=FloatToStr(dresF_re);
    S2r=FloatToStr(dresF_im);
    SResF=S1r+"  "+S2r+"i";





    printf("\n");
    printf("Result ForevalZ:  %.12f", dresF_re); printf(" "); printf("%.12f", dresF_im); printf("i\n");
*/
    printf("\n");
    printf("Result Foreval     :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");

    //printf("Result ForevalZ:  %.17f\n", SResF.c_str());
    printf("Perfomance Foreval  Expr/ms:  %5d\n", PerfF);
    printf("\n");

};



void TestEvalCmpVZ(PTGccTestZ GccFunc, Pointer32 FFunc)
{
       TFloatType resF,h;
       TComplexNum resG;
       //Extended resG;
       Extended dh,dx,dy,dt,dz1,dz2,dz3;
       double dresG,dresF,si;
       INT32 t1,t2,ni,ci,PerfG,PerfF,dn,dk,dj,ar,br,SZ,L;
       PInteger     pint1;

       SZ = rand() % 10+100 ;  /// size array changed in rand[95,105]

       vdf.resize(SZ+2);  ///change size
       ar=1; br=50; L = vdf.size()-1;

       for(ni=1; ni <= L; ni++)  /// in GCC count from 1  !! (if array in Foreval as "fast connect")
       {
           vdf[ni]=ni+1;
           vdf[ni]=pow((double)(-1),(Int32)(ni+1))*vdf[ni]*0.5;
       };


       /// to write length: (If the size of the array does not change, this is not necessary)**/
           adrVDF=&vdf[1];
           pint1 = (PInteger)adrVDF;
           pint1=pint1-1;   /// = &vdf[1]-4b; or = &vdf[0]+4b;  sizeof(double) = 8
           if (DLLCompiledBy == Delphi) {SZ = vdf.size()-1;} else {SZ=vdf.size()-2;};  /// DLLCompiledBy=1(Delphi); DLLCompiledBy=2(FPC),  in FPC Length=High
           *pint1 = SZ;  /// pint1 = &vdf[1]-4b;  *pint1 <- length

 /** Calculation with change of all variables included in the expression. The change depends on external data. Necessary for to trick the GCC optimizer **/

       RefReshVar();
       si=log10(GNC)/3;
       dn=(INT32)_trunc(si+3);
       dk=(INT32)_trunc(si+2);
       dj=(INT32)_trunc(si+1);
       resG.re=0.0; resG.im=0.0;
       dh=(Extended)1/GNC;
       dx=dh*0.123; dy=dh*0.456; dt=0.321*dh;
       dz1=dh*0.135; dz2=dh*0.357; dz3=0.531*dh;

       t1=GetTickCount();
       for(ci=0; ci <= GNC; ci++)
       {
          //x=x+dx; y=y-dy; t=t+dt;
          //n=n+dn; k=k+dk; j=j-dj;
		  z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
	    //resG=resG+GccFunc();
	    resG.re=resG.re+GccFunc().re;
          //k=k-dk; j=j+dj; n=n-dn;

       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfG=0;
       }
       else
       {
        PerfG=INT32(GNC/(t2-t1));
       };

       RefReshVar();

       resf.re=0; resf.im=0;
       t1=GetTickCount();
       for(ci=0; ci <= GNC; ci++)
       {
          //x=x+dx; y=y-dy; t=t+dt;
          //n=n+dn; k=k+dk; j=j-dj;
		  //z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
		   #ifdef   COMPLEX_VAR_ANY_ADDR   // <- complex variables are set the same as in GCC TComplexNum
                z1.re=z1.re+dz1; z2.re=z2.re+dz2; z3.re=z3.re+dz3; z1.im=z1.im-dz1; z2.im=z2.im-dz2; z3.im=z3.im-dz3;
            #else
                z1f.re=z1f.re+dz1; z2f.re=z2f.re+dz2; z3f.re=z3f.re+dz3; z1f.im=z1f.im-dz1; z2f.im=z2f.im-dz2; z3f.im=z3f.im-dz3;
            #endif
        flResult(FFunc);
         //k=k-dk; j=j+dj; n=n-dn;

       }
       t2=GetTickCount();

       if (t1 == t2)
       {
         PerfF=0;
       }
       else
       {
        PerfF=INT32(GNC/(t2-t1));
       };


   // dresG=resG; dresF=resF;
    //printf("\n");


    printf("Result GCC OVRL      :  %.12e", (double)(resG.re/GNC)); printf(" "); printf("%.12e",  (double)(resG.im/GNC)); printf("i\n");
    printf("Result Foreval OVRL  :  %.12e", (double)(resf.re/GNC)); printf(" "); printf("%.12e",  (double)(resf.im/GNC)); printf("i\n");

    //printf("Result ForevalZ:  %.17f\n", SResF.c_str());
    printf("Perfomance GCC OVRL  Expr/ms :  %5d\n", PerfG);
    printf("Perfomance Foreval   Expr/ms :  %5d\n", PerfF);
    printf("\n");
    //printf("\n");
};



void CompileTestR()
{

 INT32 i,len;

  flSet(fl_ENABLE, fl_SHOW_EXCEPTION,0); // show exception message from dll

                                       /// arithmetic expressions:

  ExprES2AR = "x*(y-t)-y*(t-x)+t*(y-x)";

  ExprES1AR = "(a*x-b*y+c)*(c*(y-b*t+b)-x)-c*y*(a-x*t)";

  ExprE1AR = "y*(x*t+y)*(x+y*t)-(x*(y-x)+y*(t-y)+t*(x-t))-(x-y)*(y-t)*(t-x)*(x+y)*(y+t)*(x+t)*(y*x-t)";

  //ExprE1R = "x*(y*x+t*(-x-(-y-x*(-y/x+x*(x*y+y*(t+x)))/(-y*(x*y*t*(x+t)*(y+t)/(y/t+x/(t-y))))/(y*(y/(x+y+t)-x/(x*y+t/(y+x*(y-x))))-x*(t/(t-x)+y*x/(y-x*(t/y-t)-t*(x*(-t-y-x))))))))";

  ExprE1R = "-(-x*(-1/x-y*(-(-y-t/(-y/(-x*(-y-x-t))-y/(x*y-t*(-x-(-x/(-t))-1/(-1/(-x))-y-x/(-t-y*(t*(-y*t-t*(-x))-x))))))))-t*y*(-y/(-t)))*(-y-x*(-t/(-y/(x-y*(-x*t))-t/(-x*(-y-(-t-(-y+x)/x)*y)/(-t-y))-x/(-y-(x*(-t*(-y/(-x*(-y-x-t/(-y-t))))))))))";

  //ExprE2R = "x*y*(2.2*x+1)*(2.3*x*y/t-2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7)*(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*y*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*x*y*t-1.7)+(4.7*x-1.164)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.198*x-8.9/t+9.9*(2.1*x-1.261)*(3.1*x+4.9*y+5.8)*(2.1*x*y*t-7.1)*x*y*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*x*y*t+1.7)-9.4)))))/(x-1.5)))))";
  ExprE2R = "x*y/(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))*(2.3*x/t-2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7)*(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5)))))";

  ExprE2PR = "(-a/(-x)-(-b-y/(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))))/(-x*y/(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))))";


  /// with constant subexpr.
  //ExprE2RCM = "(a*y*(b-c*a)*c-b*x*(c-a*b)*a)*((-a*(b-c*(c*b-a*b*x)))*x*c*a-b*y*x*a*c)*(a*(b-c)*x-y*(a*x*b-y*c*x)-(-c-a*(-b*(-x*b*c*y-y*a*(a-b*c*a)))))*(a*x*c*(b*c-c*(b*a-c*(b*a-c*b))))/(a*x*b*(a*c-b*(a-c))-c*y*b*(b-a*c-(-c*(-b-a)*b)*(-c+a)))";
  ExprE2RCM = "(a*y*(b-c*a)*c-b*x*(c-a*b)*a)*((-a*(b-c*(c*b-a*b*x)))*x*c*a-b*y*x*a*c)*(a*(b-c)*x-y*(a*x*b-y*c*x)-(-c-a*(-b*(-x*b*c*y-y*a*(a-b*c*a)))))*(a*x*c*(b*c-c*(b*a-c*(b*a-c*b))))/(a*x*b*(a*c-b*(a-c))/((a*b*c/(a+b-x)))-c*y*b*(b-a*c-(-c*(-b-a)*b)*(-c+a))/(c*y*a*(a/c-c/(a-b))-b*x*c/(c-b-a)))";
  ExprE2RC = "(a*y*(b-c/a)*c-b*x/(c-a/b)*a)*((-a/(b-c/(c/b-a*b*x)))*x/c/a-b/y/x/a/c)*(a*(b-c)/x-y/(a*x/b-y/c/x)-(-c-a/(-b/(-x/b/c/y-y*a/(a-b/c*a)))))/(a*x*c/(b*c-c/(b/a-c/(b/a-c/b))))*(a*x*b/(a/c-b/(a-c))-c/y*b/(b-a/c-(-c/(-b-a)/b)/(-c+a)))";

  /// with common subexpr.
  ExprE3SR ="x*(y/(x/y-y/x)-x/(x*y/(x+y)+t/(y/x-x/(x+y)))+t*(-y/(t/(x-y)-x*y/(x+y))+x*y*t/(x/(x+y)-y/(x+y))))*(x/(x/(x-y)-y/(t/(y/x-x/(x+y))+y/(t/(x-y)-x*y/(x+y))))-y/(x*y*t/(x/(x+y)-y/(x+y))-y/(x/y-y/x)))/(x/(x-y)+y/(x/(x/y-y/x)+x/(x*y/(x+y)+t/(y/x-x/(x+y)))))";

  ExprE3ASR = "((x*y*(x*t+y*t*(-x*y*t+x*t*((x/y-y/t+y*t/(x/t-x*y*(x*t-y)))/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x)+x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+y*t/(x*t/(x*y+t)-x*y*(x*t-y))))))/(x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+((y/t-x*y*t/(x/y-y/t))*(x/y-x*y*t/((x*y+t)*(y*t-x)-y*t/(x*t-y)))*(y*t/(x/t-x*y*(x*t-y))))/((x/t-x/(y*t-x))*(x/y-y/t+y*t/(x/t-x*y*(x*t-y)))*(y*t/(x*t/(x*y+t)-x*y*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))))";

  /// with common subexpr.
  ExprE4SR =  "(2.1*x/(3.2*y-1.1*x+t)-1.1/(3.2*x*y-1.5)+5.7/(2.1/(x+2.4)-1.4/(y+1.2))-x/(-1.1/(1.5*x*y-3.7)+x*y/(1.2*x+2.3*y+3.3*t-4.5)))*(-y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4))-t/(1.4/(y+1.2)+1.1/(3.2*x*y-1.5)))/(x*(1.1/(1.5*x*y-3.7)-2.1*x/(3.2*y-1.1*x+t))+y*(x*y/(1.2*x+2.3*y+3.3*t-4.5)+y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4)))-5.7/(2.1/(x+2.4)-1.4/(y+1.2)))";

 /// with common subexpr.
  ExprE4ASR =  "(((b/x-d/t)*(c/y-b/t)+(c/x-d/t+b/y)/(a*x/(c/t-b/(d*y-c*t)))+(b/x-d/t)*(c/y-b/t))*((a*t-d*y)*(b*(c/x-b/y)-d*(b/t-d/x))/(d*x*y*t-b*(c*x-a*t)-c*(d*y*t-c*x))))*((a*(a*x+b*y)-b*(a*y-b*x-c*t)+c*(a*t-b*x+c*y))/((a*x*y-b*t)*(b*t*x-c*y)-(d*x-b*y)/(b*t+c*y))+((d*x-b)*(a*y-c)*(d*t-c*x-a*y)/(a*x*y-b*t*x)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d))/((a*x+b)*(b*y+c)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d)))/(((b/x-d/t)*(c/y-b/t)+(c/x-d/t+b/y)/(a*x/(c/t-b/(d*y-c*t)))+(b/x-d/t)*(c/y-b/t))*((a*t-d*y)*(b*(c/x-b/y)-d*(b/t-d/x))/(d*x*y*t-b*(c*x-a*t)-c*(d*y*t-c*x)))+(a*(a*x+b*y)-b*(a*y-b*x-c*t)+c*(a*t-b*x+c*y))/((a*x*y-b*t)*(b*t*x-c*y)-(d*x-b*y)/(b*t+c*y))+((d*x-b)*(a*y-c)*(d*t-c*x-a*y)/(a*x*y-b*t*x)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d))/((a*x+b)*(b*y+c)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d)))";

  /// with constant & common subexpr.
   ExprE4SRC  = "(a*b*c*x/(b/c-c/d)-d*b*a*y/(c/d-b/a)-c*a*d*t/(a/c-b/d))/((a+b)*(b-d)*x/(a+b-c)-(a-b)*(b+d)*y/(a-b-d)+(c-b)*(b-d)*t/(b-c-a)+(a*(b-c)*x/(b*(a-b)*y/(b-c)-c*(c-d)*t/(a+d))-b*(b-d)*y/(c*(a+c)*x/(c-a)-b*(c+d)*t/(a-d))+c*(b-a)*t/(d*(b+c)*x/(b+d)-d*(d-c)*y/(b-c)))+((a*(b*d+c*a)*x-d*(a*d+c*b)*y-b*(a*c-d*b)*t)/(c*b*(a-b)/x-c*d*(a-c)/y-a*b*(a+d)/t)+((a+b)*x/(c-d)-(b+c)*y/(a-d)-(a+c)*t/(d-b))-((a*c-b*d)*t/(a+b)-(a*b-c*d)*y/(d+a)-(b*c-b*a)*x/(b-c))))-(a*(b-c)*x/(b*(a-b)*y/(b-c)-c*(c-d)*t/(a+d))-b*(b-d)*y/(c*(a+c)*x/(c-a)-b*(c+d)*t/(a-d))+c*(b-a)*t/(d*(b+c)*x/(b+d)-d*(d-c)*y/(b-c))+(a+b)*(b-d)*x/(a+b-c)-(a-b)*(b+d)*y/(a-b-d)+(c-b)*(b-d)*t/(b-c-a))+(a*b*c*x/(b/c-c/d)-d*b*a*y/(c/d-b/a)-c*a*d*t/(a/c-b/d))*((a*c-b*d)*t/(a+b)-(a*b-c*d)*y/(d+a)-(b*c-b*a)*x/(b-c))/((a*(b*d+c*a)*x-d*(a*d+c*b)*y-b*(a*c-d*b)*t)+(c*b*(a-b)/x-c*d*(a-c)/y-a*b*(a+d)/t)+(a+b)*x/(c-d)-(b+c)*y/(a-d)-(a+c)*t/(d-b))";


                                               /// indexing of arrays

  //ExprA5 = "(x*vd[n+1]*ve[k+n]-y*vd[2*n+1]*ve[k+3*n]+t*vi[k+n+1])*(t*vd[n+k+3]*ve[j+5]+x*ve[2*n+3*k+4]*vd[j+k-n]-y*vi[j+k-1])";
  ExprA5R = "(x*vd[n+1]*ve[k+n]-y*vd[2*n+1]*ve[k+3*n]+t*vi[2*k+n+1])*(t*vd[4*n+k-3]*ve[j+5]+x*ve[5*n+3*k-4]*vd[j+k-n]-y*vi[2*j+k-1]*ve[5*j+3*k*n-2*j*k*n+4*k+15])";


  //ExprA6 = "avr:dbl=avr(vdf); i:int=0; L:int=Len(vdf)-1; res:dbl=0; for(i,0,L,if(vdf[i]>avr,res=res+vdf[i])); res*x+y";
  //ExprA6 = "res:dbl=0; i:int=0; j:int=0; L:int=Len(vd)-1;  for(i,0,L,ifp(vd[i]>0,for(j,0,L,ifp((j > i)and(vd[j] > vd[i]),res=res-vd[j],res=res+vd[i])),vd[L-i] = vd[i]-vd[L-i])); res";

  //ExprA6 = "res:dbl=0; i:int=0; j:int=0; L:int=Len(vd)-1;  for(i,0,L,ifp(vd[i]>0,for(j,0,L,ifp((j > i)and(vd[j] > vd[i]),res=res-x*vd[j],res=res+x*vd[i])),res=res+y*vd[L-i])); res";
  //ExprA6R = "res:dbl=0; i:int=0; j:int=0; L:int=Len(vdf)-1;  for(i,0,L,ifp(vdf[i]>0,for(j,0,L,ifp((j > i)and(vdf[j] > vdf[i]),res=res-x*vdf[j],res=res+x*vdf[i])),res=res-y*vdf[L-i])); res";
  //ExprA6 = "res:dbl=0; i:int=0; j:int=0; L:int=Len(vdf)-1;  for(i,0,L,ifp(vdf[i]>0,for(j,i,L,ifp((i+j<L)and(vdf[j] > vdf[i]),res=res-x*vdf[j],res=res+x*vdf[i])),res=res+y*vdf[L-i])); res";

   ExprA6R = "res:dbl=0; i:int=0; j:int=0; L:int=len(vd)-1;  for(i=0,L, ifp(vd[i] > 0, for(j=0,L,ifp((j > i)and(vd[j] > vd[i]),res=res-x*vd[j-i],res=res+x*vd[j])),res=res-y*vd[L-i] )); res";

   //ExprA6R = "res:dbl=0; i:int=0; j:int=0; L:int=Len(vd)-1;  for(i,0,L,ifp(vd[i]>0,for(j,0,L,ifp((j > i)and(vd[j] > vd[i]),res=res-x*vd[j-i],res=res+x*vd[j])),res=res-y*vd[L-i])); res";
   ExprA6FR = "res:dbl=0; i:int=0; j:int=0; L:int=Len(vdf)-1;  for(i=0,L,ifp(vdf[i]>0,for(j=0,L,ifp((j > i)and(vdf[j] > vdf[i]),res=res-x*vdf[j-i],res=res+x*vdf[j])),res=res-y*vdf[L-i])); res";
   //ExprA6PR ="len: int = len(vps);  s: dbl = 0; i:int = 0; l:int=0; r:int=len-1; bf: dbl=0; while(l < r, for(i,l,r-1, ifp(vps[i] > vps[i+1], bf=vps[i]; vps[i] = vps[i+1]; vps[i+1] = bf)); dec(r); fordown(i,r,l+1, ifp(vps[i] < vps[i-1], bf=vps[i]; vps[i] = vps[i-1]; vps[i-1] = bf)); inc(l););    for(i,0,len-2, ifp(vps[i] < vps[i+1], s=s+vps[i]; )); s+vps[len-1];";
   ExprA6PR ="len: int = len(vps);  s: dbl = 0; i:int = 0; l:int=0; r:int=len-1; bf: dbl=0; while(l < r, for(i=l,r-1, swapif(vps[i] > vps[i+1])); dec(r); fordown(i=r,l+1, swapif(vps[i] < vps[i-1])); inc(l););    for(i=0,len-2, ifp(vps[i] < vps[i+1], s=s+vps[i]; )); s+vps[len-1];";




   ExprA6VU = "L:int=len(vu1); for(k=1,L-2,vu1[k]=(vu2[k-1]*x+y*vu3[k+1])-vu1[k-1]);  s:ext=0; for(k=0,L-1,ifp(vu2[k]+x > vu3[k]+y,s=s+x*vu1[k];  x = vu2[k]; y = vu3[k]; , s=s-y*vu1[k];  x = vu3[k]; y = vu2[k];));s/L";
   #ifdef   EXTENDED_FLOAT
       ExprA6PVU = "for(k=1,LenVU-2,PExtended(Ptr0Vu1+ExtCS*k)=(PExtended(Ptr0Vu2+ExtCS*k-ExtCS)*x+y*PExtended(Ptr0Vu3+ExtCS*k+ExtCS))-PExtended(Ptr0Vu1+ExtCS*k-ExtCS));  s:ext=0; for(k=0,LenVU-1,ifp(PExtended(Ptr0Vu2+ExtCS*k)+x > PExtended(Ptr0Vu3+ExtCS*k)+y,s=s+x*PExtended(Ptr0Vu1+ExtCS*k); x = PExtended(Ptr0Vu2+ExtCS*k); y = PExtended(Ptr0Vu3+ExtCS*k); ,  s=s-y*PExtended(Ptr0Vu1+ExtCS*k);x = PExtended(Ptr0Vu3+ExtCS*k); y = PExtended(Ptr0Vu2+ExtCS*k); ));s/LenVU";
   #else
       ExprA6PVU = "for(k=1,LenVU-2,PDouble(Ptr0Vu1+DblCS*k)=(PDouble(Ptr0Vu2+DblCS*k-DblCS)*x+y*PDouble(Ptr0Vu3+DblCS*k+DblCS))-PDouble(Ptr0Vu1+DblCS*k-DblCS));  s:ext=0; for(k=0,LenVU-1,ifp(PDouble(Ptr0Vu2+DblCS*k)+x > PDouble(Ptr0Vu3+DblCS*k)+y,s=s+x*PDouble(Ptr0Vu1+DblCS*k); x = PDouble(Ptr0Vu2+DblCS*k); y = PDouble(Ptr0Vu3+DblCS*k); , s=s-y*PDouble(Ptr0Vu1+DblCS*k); x = PDouble(Ptr0Vu3+DblCS*k); y = PDouble(Ptr0Vu2+DblCS*k);));s/LenVU";
   #endif



   #ifdef   EXTENDED_FLOAT
       ExprIntegralF1 = "n:int=P_Integral-1; h:ext=|y-x|/P_Integral;  int1:ext=0;  L:int=N_Integral-1; for(j=0, n, x1:ext=x+j*h; x2:ext=x+(j+1)*h; ax:ext=(x1+x2)*0.5; sx:ext=(x2-x1)*0.5;  for(k=0, L,  xf:ext=sx*Bint[k]+ax;  int1=int1+Aint[k]*int1func(xf)*sx; ); ); int1;";
   #else
        ExprIntegralF1 = "n:int=P_Integral-1; h:dbl=|y-x|/P_Integral;  int1:dbl=0;  L:int=N_Integral-1; for(j=0, n, x1:dbl=x+j*h; x2:dbl=x+(j+1)*h; ax:dbl=(x1+x2)*0.5; sx:dbl=(x2-x1)*0.5;  for(k=0, L,  xf:dbl=sx*Bint[k]+ax;  int1=int1+Aint[k]*int1func(xf)*sx; ); ); int1;";
   #endif


  // ExprIntegralF1 = "n:int=P_Integral-1; h:ext=|y-x|/P_Integral;  int1:ext=0;  L:int=N_Integral-1; for(j,0,L,int1=int1+Aint[j]); int1 ";
  // ExprIntegralF1 = "n:int=P_Integral-1; h:ext=|y-x|/P_Integral;  int1:ext=0;  L:int=N_Integral-1; for(j=0, n, x1:ext=x+j*h; x2:ext=x+(j+1)*h; ax:ext=(x1+x2)*0.5; sx:ext=(x2-x1)*0.5;  for(k=0, L,  xf:ext=sx+ax;  int1=int1+sx; ); ); int1;";


                                               /// polynom
   ExprP7R = "1.1*pow(x,12)-2.1*pow(x,11)-3.1*pow(x,10)+2.2*pow(x,9)-3.3*pow(x,8)-5.7*pow(x,7)+2.3*pow(x,6)-9.8*pow(x,5)+1.7*pow(x,4)+1.4*pow(x,3)-7.5*pow(x,2)+7.7*x+12.3";

   ExprP7AR = "poly(1.1,-2.1,-3.1,2.2,-3.3,-5.7,2.3,-9.8,1.7,1.4,-7.5,7.7,12.3,x)";

   ExprP7BR = "poly(CP12,x)";







                                                  /// function
ExprF8R =  "sin(cos(x+y))*cos(y*sin(x-y))*(2.15*cos(sin(3.53*cos(t-x)))-tan(x+y)*(tan(t+x)-cos(sin(t+y))*((1.76*asin(x/(x+y))+2.97*acos(y/(x+y)))*(2.12*atan(x-y)*atan2(x-y,x+y)-asin(t/(x+y))*acos(t/(y+x-t))/(atan(x+y)+atan2(t-x-y,x-t))))))";


/// mixed
ExprF9R = "(pow(x-sin(x),y-cos(y))/(tan(1.5*asin(1.1*x/(1.2*x+y))))+pow(y-sin(x*1.2)/cos(y+1.1),n+k)/(x+2.1*y))*(2.1*sinh(x/y)*sin(x+y)-3.2*cosh(x/(x+y)*cos(x-y))-tanh(y/(x+y))/(exp(2.1*x/y))*asin(1.1*x/(2.1*x+y))-2.1*atan(1.1*x-y)*atan2(x-y,1.3*x+y))";


                                         /// function with common subexpr.
/// trig. func.
ExprF10SR  = "(cos(x*sin(x))*sin(y*cos(y))-sin(cos(x*cos(x+y)))*cos(y*cos(x*sin(x*y))))*(cos(sin(y)*y+x*cos(x))*sin(x*sin(x+y))-cos(y*cos(x*y))*sin(x*cos(x+y))+sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))/(sin(x*sin(x))*cos(y*cos(y))+cos(cos(x*cos(x+y)))*sin(sin(y)*y+x*cos(x))-sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))))";


/// mixed
ExprF11SR = "(sin(x/(x+y))-sinh(x/(x+y))*asin(x/(x+y)))*(cosh(x/(x+y))*acos(x/(x+y))+cos(x/(x+y)))*(tanh(x/(x+y))-exp(x/(x+y)))";


//ExprF12SR = "cos(pow(sin(x+y),k+2*n)*pow(cos(x*y),n+k)-pow(x-sin(x*y),pow(cos(x*y),n+k))*pow(y-cos(x+y),pow(sin(x+y),k+2*n)))/(sin(pow(sin(x+y),k+2*n))/cos(pow(cos(x*y),n+k))-sin(pow(x-sin(x),y-cos(y)))/cos(pow(x-sin(x),y-cos(y))))";
//ExprF12SR = "cos(pow(sin(x+y),k+2*n-10)*pow(cos(x*y),n+k-7)-pow(x-sin(x*y),pow(cos(x*y),n+k-7))*pow(y-cos(x+y),pow(sin(x+y),k+2*n-10)))/(sin(pow(sin(x+y),k+2*n-10))/cos(pow(cos(x*y),n+k-7))-sin(pow(x-sin(x),y-cos(y)))/cos(pow(x-sin(x),y-cos(y))))";

ExprF12SR = "(pow(x-sin(x*y),pow(cos(x*y),n+k-7))/pow(y-cos(x+y),pow(sin(x+y),k+2*n-10))-pow(sin(x+y),k+2*n-10)*pow(cos(x*y),n+k-7))/(cos(pow(cos(x*y),n+k))/sin(pow(sin(x+y),k+2*n))+cos(pow(x-sin(x),y-cos(y)))/sin(pow(x-sin(x),y-cos(y))))";



ExprF12CR = "a*cos(sin(c*pow(a/c,c/(a-b*c))/(b-c))*x+cos(a/exp(a/b)*y+b/pow(a-b,a/(c*sin(a*b/c)))))*pow(sin(a*b/(a-c))+cos(c/(a/b-b/c)),x/y)";


                            /// external functions.
ExprFE13SPR = "sp3(x-sp3(sp1(y/x),sp3(x+y,x+t,y+t)-2.1*sp2(sp1(t*1.25),1.1-sp2(sp1(1.1+x),y-sp3(x+1.2,y+1.3,t+1.4))),t-sp2(sp3(x-y,y-t,t-x),sp2(2.1-x,3.2-y))),y-sp3(-x*1.51,-2.79*y,t-sp3(-t+2.75,x*y*2.71,-y-sp2(3.6*t-y*sp2(t-y*1.11,-y+x*2.11),y-sp3(1.15*x-y,y*1.72,x*1.27)))),1.51*y-sp3(1.19*x,-y+1.17,-t-1.97)*sp3(sp2(x*2.73,1.96*y),-sp2(-x*1.95,y/(x-1.77)),-sp3(y+1.89,7.98-t,-x-2.98)))";
ExprFE13PSR = "ps3(x-ps3(ps1(y/x),ps3(x+y,x+t,y+t)-2.1*ps2(ps1(t*1.25),1.1-ps2(ps1(1.1+x),y-ps3(x+1.2,y+1.3,t+1.4))),t-ps2(ps3(x-y,y-t,t-x),ps2(2.1-x,3.2-y))),y-ps3(-x*1.51,-2.79*y,t-ps3(-t+2.75,x*y*2.71,-y-ps2(3.6*t-y*ps2(t-y*1.11,-y+x*2.11),y-ps3(1.15*x-y,y*1.72,x*1.27)))),1.51*y-ps3(1.19*x,-y+1.17,-t-1.97)*ps3(ps2(x*2.73,1.96*y),-ps2(-x*1.95,y/(x-1.77)),-ps3(y+1.89,7.98-t,-x-2.98)))";
ExprFE13MSR = "ms3(x-ms3(ms1(y/x),ms3(x+y,x+t,y+t)-2.1*ms2(ms1(t*1.25),1.1-ms2(ms1(1.1+x),y-ms3(x+1.2,y+1.3,t+1.4))),t-ms2(ms3(x-y,y-t,t-x),ms2(2.1-x,3.2-y))),y-ms3(-x*1.51,-2.79*y,t-ms3(-t+2.75,x*y*2.71,-y-ms2(3.6*t-y*ms2(t-y*1.11,-y+x*2.11),y-ms3(1.15*x-y,y*1.72,x*1.27)))),1.51*y-ms3(1.19*x,-y+1.17,-t-1.97)*ms3(ms2(x*2.73,1.96*y),-ms2(-x*1.95,y/(x-1.77)),-ms3(y+1.89,7.98-t,-x-2.98)))";
ExprFE13PCR = "pc3(x-pc3(pc1(y/x),pc3(x+y,x+t,y+t)-2.1*pc2(pc1(t*1.25),1.1-pc2(pc1(1.1+x),y-pc3(x+1.2,y+1.3,t+1.4))),t-pc2(pc3(x-y,y-t,t-x),pc2(2.1-x,3.2-y))),y-pc3(-x*1.51,-2.79*y,t-pc3(-t+2.75,x*y*2.71,-y-pc2(3.6*t-y*pc2(t-y*1.11,-y+x*2.11),y-pc3(1.15*x-y,y*1.72,x*1.27)))),1.51*y-pc3(1.19*x,-y+1.17,-t-1.97)*pc3(pc2(x*2.73,1.96*y),-pc2(-x*1.95,y/(x-1.77)),-pc3(y+1.89,7.98-t,-x-2.98)))";


ExprFE14SPR = "sp8(ve,j+3,t+sp8(ve,n+2,y-sp8(ve,k+3,x-y,vd,j+n,y-sp8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-sp8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/sp8(ve,j,x+sp8(ve,k+n+2,t+sp8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+sp8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2)";
ExprFE14PSR = "ps8(ve,j+3,t+ps8(ve,n+2,y-ps8(ve,k+3,x-y,vd,j+n,y-ps8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-ps8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/ps8(ve,j,x+ps8(ve,k+n+2,t+ps8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+ps8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2)";
ExprFE14MSR = "ms8(ve,j+3,t+ms8(ve,n+2,y-ms8(ve,k+3,x-y,vd,j+n,y-ms8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-ms8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/ms8(ve,j,x+ms8(ve,k+n+2,t+ms8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+ms8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2)";
ExprFE14PCR = "pc8(ve,j+3,t+pc8(ve,n+2,y-pc8(ve,k+3,x-y,vd,j+n,y-pc8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-pc8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/pc8(ve,j,x+pc8(ve,k+n+2,t+pc8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+pc8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2)";



ExprFE15SPR = "(sp3(x/y-sp2(x-y,x/y),x/sp2(x-y,x/y),sp1(x/y)*sp1(-sp1(y/x)))*sp1(x/y)-sp2(y/sp2(x-y,x/y),-x/sp2(x-y,x/y))*sp1(-sp1(y/x)))/(sp1(x/y-sp2(x-y,x/y))-sp2(x/sp2(x-y,x/y),y/sp2(x-y,x/y))+sp2(x-y,x/y)*sp3(x/y-sp2(x-y,x/y),x/sp2(x-y,x/y),sp1(x/y)*sp1(-sp1(y/x))))";
ExprFE15PSR = "(ps3(x/y-ps2(x-y,x/y),x/ps2(x-y,x/y),ps1(x/y)*ps1(-ps1(y/x)))*ps1(x/y)-ps2(y/ps2(x-y,x/y),-x/ps2(x-y,x/y))*ps1(-ps1(y/x)))/(ps1(x/y-ps2(x-y,x/y))-ps2(x/ps2(x-y,x/y),y/ps2(x-y,x/y))+ps2(x-y,x/y)*ps3(x/y-ps2(x-y,x/y),x/ps2(x-y,x/y),ps1(x/y)*ps1(-ps1(y/x))))";
ExprFE15MSR = "(ms3(x/y-ms2(x-y,x/y),x/ms2(x-y,x/y),ms1(x/y)*ms1(-ms1(y/x)))*ms1(x/y)-ms2(y/ms2(x-y,x/y),-x/ms2(x-y,x/y))*ms1(-ms1(y/x)))/(ms1(x/y-ms2(x-y,x/y))-ms2(x/ms2(x-y,x/y),y/ms2(x-y,x/y))+ms2(x-y,x/y)*ms3(x/y-ms2(x-y,x/y),x/ms2(x-y,x/y),ms1(x/y)*ms1(-ms1(y/x))))";
ExprFE15PCR = "(pc3(x/y-pc2(x-y,x/y),x/pc2(x-y,x/y),pc1(x/y)*pc1(-pc1(y/x)))*pc1(x/y)-pc2(y/pc2(x-y,x/y),-x/pc2(x-y,x/y))*pc1(-pc1(y/x)))/(pc1(x/y-pc2(x-y,x/y))-pc2(x/pc2(x-y,x/y),y/pc2(x-y,x/y))+pc2(x-y,x/y)*pc3(x/y-pc2(x-y,x/y),x/pc2(x-y,x/y),pc1(x/y)*pc1(-pc1(y/x))))";



ExprFE15SPRC = "sp2(sp3(a-b,b/c,c/(b-a))*a/sp2(sp2(b/sp1(a/(b+c)),b/(c+a)),a-b*c)*x/b,x/sp2(a*sp1(c/b),a/(b+a)))*sp3((c-a)*sp1(c/b)/sp2(b/(c+a/b),b/(c-a))*x/sp1(c/a),sp1(c/b)/sp1(b/a),x/sp2(b-c/a,c-b/c))*sp2(-a/(c+b/a),x/(a-b))";
ExprFE15PSRC = "ps2(ps3(a-b,b/c,c/(b-a))*a/ps2(ps2(b/ps1(a/(b+c)),b/(c+a)),a-b*c)*x/b,x/ps2(a*ps1(c/b),a/(b+a)))*ps3((c-a)*ps1(c/b)/ps2(b/(c+a/b),b/(c-a))*x/ps1(c/a),ps1(c/b)/ps1(b/a),x/ps2(b-c/a,c-b/c))*ps2(-a/(c+b/a),x/(a-b))";
ExprFE15MSRC = "ms2(ms3(a-b,b/c,c/(b-a))*a/ms2(ms2(b/ms1(a/(b+c)),b/(c+a)),a-b*c)*x/b,x/ms2(a*ms1(c/b),a/(b+a)))*ms3((c-a)*ms1(c/b)/ms2(b/(c+a/b),b/(c-a))*x/ms1(c/a),ms1(c/b)/ms1(b/a),x/ms2(b-c/a,c-b/c))*ms2(-a/(c+b/a),x/(a-b))";
ExprFE15PCRC = "pc2(pc3(a-b,b/c,c/(b-a))*a/pc2(pc2(b/pc1(a/(b+c)),b/(c+a)),a-b*c)*x/b,x/pc2(a*pc1(c/b),a/(b+a)))*pc3((c-a)*pc1(c/b)/pc2(b/(c+a/b),b/(c-a))*x/pc1(c/a),pc1(c/b)/pc1(b/a),x/pc2(b-c/a,c-b/c))*pc2(-a/(c+b/a),x/(a-b))";


ExprFE15ASPR = "sp3(-x/sp2(x/y,-t/x)-sp3(x/(x+y),t/(x-y),y/(x+t)),x/sp1(x/y)-y/sp2(t/y,y/(x+t)),-sp2(x/(x+y),t/(x-y))/sp3(x/y,y/(x+y+t),t/(t-x-y)))*sp2(x/sp1(x/y),sp2(x/(x+y),t/(x-y)))/(sp1(x/sp3(x/(x+y),t/(x-y),y/(x+t)))*sp3(x/y,y/(x+y+t),t/(t-x-y))-sp2(t/(t-x-y)-y/(x+t),y/(x+y+t)-t/(x-y))*(x/sp1(x/y)-y/sp2(t/y,y/(x+t)))/(sp2(x/sp1(x/y),sp2(x/(x+y),t/(x-y)))-sp1(sp3(x/y,y/(x+y+t),t/(t-x-y)))))";
ExprFE15APSR = "ps3(-x/ps2(x/y,-t/x)-ps3(x/(x+y),t/(x-y),y/(x+t)),x/ps1(x/y)-y/ps2(t/y,y/(x+t)),-ps2(x/(x+y),t/(x-y))/ps3(x/y,y/(x+y+t),t/(t-x-y)))*ps2(x/ps1(x/y),ps2(x/(x+y),t/(x-y)))/(ps1(x/ps3(x/(x+y),t/(x-y),y/(x+t)))*ps3(x/y,y/(x+y+t),t/(t-x-y))-ps2(t/(t-x-y)-y/(x+t),y/(x+y+t)-t/(x-y))*(x/ps1(x/y)-y/ps2(t/y,y/(x+t)))/(ps2(x/ps1(x/y),ps2(x/(x+y),t/(x-y)))-ps1(ps3(x/y,y/(x+y+t),t/(t-x-y)))))";
ExprFE15AMSR = "ms3(-x/ms2(x/y,-t/x)-ms3(x/(x+y),t/(x-y),y/(x+t)),x/ms1(x/y)-y/ms2(t/y,y/(x+t)),-ms2(x/(x+y),t/(x-y))/ms3(x/y,y/(x+y+t),t/(t-x-y)))*ms2(x/ms1(x/y),ms2(x/(x+y),t/(x-y)))/(ms1(x/ms3(x/(x+y),t/(x-y),y/(x+t)))*ms3(x/y,y/(x+y+t),t/(t-x-y))-ms2(t/(t-x-y)-y/(x+t),y/(x+y+t)-t/(x-y))*(x/ms1(x/y)-y/ms2(t/y,y/(x+t)))/(ms2(x/ms1(x/y),ms2(x/(x+y),t/(x-y)))-ms1(ms3(x/y,y/(x+y+t),t/(t-x-y)))))";
ExprFE15APCR = "pc3(-x/pc2(x/y,-t/x)-pc3(x/(x+y),t/(x-y),y/(x+t)),x/pc1(x/y)-y/pc2(t/y,y/(x+t)),-pc2(x/(x+y),t/(x-y))/pc3(x/y,y/(x+y+t),t/(t-x-y)))*pc2(x/pc1(x/y),pc2(x/(x+y),t/(x-y)))/(pc1(x/pc3(x/(x+y),t/(x-y),y/(x+t)))*pc3(x/y,y/(x+y+t),t/(t-x-y))-pc2(t/(t-x-y)-y/(x+t),y/(x+y+t)-t/(x-y))*(x/pc1(x/y)-y/pc2(t/y,y/(x+t)))/(pc2(x/pc1(x/y),pc2(x/(x+y),t/(x-y)))-pc1(pc3(x/y,y/(x+y+t),t/(t-x-y)))))";

SetExprE2R_Diffdxdy_Long();
SetExprE2PR_Diffdxdy_Long();

 //flCompile(ExprES2AR.c_str(),0,FuncES2AR);
 flCompile(ExprES1AR.c_str(),0,FuncES1AR);
 flCompile(ExprE1AR.c_str(),0,FuncE1AR);
 flCompile(ExprE1R.c_str(),0,FuncE1R);
 flCompile(ExprE2R.c_str(),0,FuncE2R);
 flCompile(ExprE2PR.c_str(),0,FuncE2PR);
 flCompile(ExprE2RC.c_str(),0,FuncE2RC);
 flCompile(ExprE2RCM.c_str(),0,FuncE2RCM);
 flCompile(ExprE3SR.c_str(),0,FuncE3SR);
 flCompile(ExprE3ASR.c_str(),0,FuncE3ASR);
 flCompile(ExprE4SR.c_str(),0,FuncE4SR);
 flCompile(ExprE4ASR.c_str(),0,FuncE4ASR);
 flCompile(ExprE4SRC.c_str(),0,FuncE4SRC);
 flCompile(ExprA5R.c_str(),0,FuncA5R);
 flCompile(ExprA6R.c_str(),0,FuncA6R);
 flCompile(ExprA6FR.c_str(),0,FuncA6FR);
 flCompile(ExprA6PR.c_str(),0,FuncA6PR);
 flCompile(ExprA6VU.c_str(),0,FuncA6VU);
 flCompile(ExprA6PVU.c_str(),0,FuncA6PVU);

 flCompile(ExprE2R_Diffdxdy_Long.c_str(),0,FuncE2R_Diffdxdy_Long);
 flCompile(ExprE2PR_Diffdxdy_Long.c_str(),0,FuncE2PR_Diffdxdy_Long);


 SetMatrixDetMulExpr(); //flCompile(ExprA6VDU.c_str(),0,FuncA6VDU);
 CompileMatrixDetMulExpr(FuncA6VDU); //flCompile(ExprA6VDU.c_str(),0,FuncA6VDU);
 CompileMatrixDetMulExpr(FuncA6VDUP);


 flCompile(ExprIntegralF1.c_str(),0,FuncIntegralF1);
 flCompile(ExprP7R.c_str(),0,FuncP7R);
 flCompile(ExprP7AR.c_str(),0,FuncP7AR);
 flCompile(ExprP7BR.c_str(),0,FuncP7BR);
 flCompile(ExprF8R.c_str(),0,FuncF8R);
 flCompile(ExprF9R.c_str(),0,FuncF9R);
 flCompile(ExprF10SR.c_str(),0,FuncF10SR);
 flCompile(ExprF11SR.c_str(),0,FuncF11SR);
 flCompile(ExprF12SR.c_str(),0,FuncF12SR);
 flCompile(ExprF12CR.c_str(),0,FuncF12CR);

 flCompile(ExprFE13SPR.c_str(),0,FuncFE13SPR);
 flCompile(ExprFE13PSR.c_str(),0,FuncFE13PSR);
 flCompile(ExprFE13MSR.c_str(),0,FuncFE13MSR);
 flCompile(ExprFE13PCR.c_str(),0,FuncFE13PCR);

 flCompile(ExprFE14SPR.c_str(),0,FuncFE14SPR);
 flCompile(ExprFE14PSR.c_str(),0,FuncFE14PSR);
 flCompile(ExprFE14MSR.c_str(),0,FuncFE14MSR);
 flCompile(ExprFE14PCR.c_str(),0,FuncFE14PCR);

 flCompile(ExprFE15SPR.c_str(),0,FuncFE15SPR);
 flCompile(ExprFE15PSR.c_str(),0,FuncFE15PSR);
 flCompile(ExprFE15MSR.c_str(),0,FuncFE15MSR);
 flCompile(ExprFE15PCR.c_str(),0,FuncFE15PCR);

 flCompile(ExprFE15SPRC.c_str(),0,FuncFE15SPRC);
 flCompile(ExprFE15PSRC.c_str(),0,FuncFE15PSRC);
 flCompile(ExprFE15MSRC.c_str(),0,FuncFE15MSRC);
 flCompile(ExprFE15PCRC.c_str(),0,FuncFE15PCRC);

 flCompile(ExprFE15ASPR.c_str(),0,FuncFE15ASPR);
 flCompile(ExprFE15APSR.c_str(),0,FuncFE15APSR);
 flCompile(ExprFE15AMSR.c_str(),0,FuncFE15AMSR);
 flCompile(ExprFE15APCR.c_str(),0,FuncFE15APCR);



 flSet(fl_DISABLE, fl_SHOW_EXCEPTION,0); //don't show exception message from dll
};






void CompareTestR()
{
  TFloatType resG,resF,h,dh,dx,dy,dt;
  double dresG,dresF,_ResG,_ResF,_ResF1;
  //TFloatType resG,resF;
  INT32 rt,FpuExc,t1,t2,i,ni, lenv, ECode,PerfG,PerfF,GNCt,_PerfG,_PerfF,_PerfF1;
  Pointer32 Func;
  string Expr;

  PTGccTestR GccFunc;
  //string    ExprE0,ExprE1,ExprE2S,ExprE3S,ExprA4,ExprP5,ExprF6,ExprF7,ExprF8S,ExprF9S,ExprF10S,ExprFE11SP,ExprFE11PS,ExprFE11MS,ExprFE12SP,ExprFE12PS,ExprFE12MS;
  //Pointer32 FuncE0,FuncE1,FuncE2S,FuncE3S,FuncA4,FuncP5,FuncF6,FuncF7,FuncF8S,FuncF9S,FuncF10S,FuncFE11SP,FuncFE11PS,FuncFE11MS,FuncFE12SP,FuncFE12PS,FuncFE12MS;




GNCt = GNC;

//goto f12sr;


/*
printf("\n");
printf("**********************************  arithmetic expressions:   ****************************************\n");
printf("\n");
//printf("x*(y-t)+y*(t-x)+t*(y-x)\n");
printf(ExprES2AR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccES2AR,FuncES2AR);
printf("\n");
printf("*******************************************************************************\n");
*/


printf("\n");
printf("**********************************  arithmetic expressions:   ****************************************\n");
printf("\n");
//printf("(a*x-b*y+c)*(c*(y-b*t+b)-x)-c*y*(a-x*t)\n");
printf(ExprES1AR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccES1AR,FuncES1AR);
printf("\n");
printf("*******************************************************************************\n");


printf("\n");
printf("**********************************  arithmetic expressions:   ****************************************\n");
printf("\n");
//printf("y*(x*t+y)*(x+y*t)-(x*(y-x)+y*(t-y)+t*(x-t))-(x-y)*(y-t)*(t-x)*(x+y)*(y+t)*(x+t)*(y*x-t))\n");
printf(ExprE1AR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE1AR,FuncE1AR);
printf("\n");
printf("*******************************************************************************\n");


printf("\n");
printf("**********************************  arithmetic expressions: ****************************************\n");
printf("\n");
//printf("-(-x*(-1/x-y*(-(-y-t/(-y/(-x*(-y-x-t))-y/(x*y-t*(-x-(-x/(-t))-1/(-1/(-x))-y-x/(-t-y*(t*(-y*t-t*(-x))-x))))))))-t*y*(-y/(-t)))*(-y-x*(-t/(-y/(x-y*(-x*t))-t/(-x*(-y-(-t-(-y+x)/x)*y)/(-t-y))-x/(-y-(x*(-t*(-y/(-x*(-y-x-t/(-y-t))))))))))\n");
printf(ExprE1R.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE1R,FuncE1R);
printf("\n");
printf("*******************************************************************************\n");


printf("\n");
printf("**********************************  arithmetic expressions: ****************************************\n");
printf("\n");
//printf("x*y/(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))*(2.3*x/t-2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7)*(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5)))))\n");
printf(ExprE2R.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE2R,FuncE2R);
printf("\n");
printf("*******************************************************************************\n");



printf("\n");
printf("**********************************  arithmetic expressions: ****************************************\n");
printf("\n");
printf(ExprE2PR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE2PR,FuncE2PR);
printf("\n");
printf("*******************************************************************************\n");



printf("\n");
printf("**********************************  arithmetic expressions with constant subexpressions ****************************************\n");
printf("\n");
//printf("(a*y*(b-c*a)*c-b*x*(c-a*b)*a)*((-a*(b-c*(c*b-a*b*x)))*x*c*a-b*y*x*a*c)*(a*(b-c)*x-y*(a*x*b-y*c*x)-(-c-a*(-b*(-x*b*c*y-y*a*(a-b*c*a)))))*(a*x*c*(b*c-c*(b*a-c*(b*a-c*b))))/(a*x*b*(a*c-b*(a-c))/((a*b*c/(a+b-x)))-c*y*b*(b-a*c-(-c*(-b-a)*b)*(-c+a))/(c*y*a*(a/c-c/(a-b))-b*x*c/(c-b-a)))\n");
printf(ExprE2RCM.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE2RCM,FuncE2RCM);
printf("\n");
printf("*******************************************************************************\n");


printf("\n");
printf("**********************************  arithmetic expressions with constant subexpressions ****************************************\n");
printf("\n");
//printf("(a*y*(b-c/a)*c-b*x/(c-a/b)*a)*((-a/(b-c/(c/b-a*b*x)))*x/c/a-b/y/x/a/c)*(a*(b-c)/x-y/(a*x/b-y/c/x)-(-c-a/(-b/(-x/b/c/y-y*a/(a-b/c*a)))))/(a*x*c/(b*c-c/(b/a-c/(b/a-c/b))))*(a*x*b/(a/c-b/(a-c))-c/y*b/(b-a/c-(-c/(-b-a)/b)/(-c+a)))\n");
printf(ExprE2RC.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE2RC,FuncE2RC);
printf("\n");
printf("*******************************************************************************\n");


printf("\n");
printf("**********************************  arithmetic expressions with common subexpressions ****************************************\n");
printf("\n");
//printf("x*(y/(x/y-y/x)-x/(x*y/(x+y)+t/(y/x-x/(x+y)))+t*(-y/(t/(x-y)-x*y/(x+y))+x*y*t/(x/(x+y)-y/(x+y))))*(x/(x/(x-y)-y/(t/(y/x-x/(x+y))+y/(t/(x-y)-x*y/(x+y))))-y/(x*y*t/(x/(x+y)-y/(x+y))-y/(x/y-y/x)))/(x/(x-y)+y/(x/(x/y-y/x)+x/(x*y/(x+y)+t/(y/x-x/(x+y)))))\n");
printf(ExprE3SR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE3SR,FuncE3SR);
printf("\n");
printf("*******************************************************************************\n");


printf("\n");
printf("**********************************  arithmetic expressions with common subexpressions ****************************************\n");
printf("\n");
//printf("((x*y*(x*t+y*t*(-x*y*t+x*t*((x/y-y/t+y*t/(x/t-x*y*(x*t-y)))/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x)+x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+y*t/(x*t/(x*y+t)-x*y*(x*t-y))))))/(x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+((y/t-x*y*t/(x/y-y/t))*(x/y-x*y*t/((x*y+t)*(y*t-x)-y*t/(x*t-y)))*(y*t/(x/t-x*y*(x*t-y))))/((x/t-x/(y*t-x))*(x/y-y/t+y*t/(x/t-x*y*(x*t-y)))*(y*t/(x*t/(x*y+t)-x*y*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))))\n");
printf(ExprE3ASR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE3ASR,FuncE3ASR);
printf("\n");
printf("*******************************************************************************\n");



printf("\n");
printf("**********************************  arithmetic expressions with common subexpressions ****************************************\n");
printf("\n");
//printf("(2.1*x/(3.2*y-1.1*x+t)-1.1/(3.2*x*y-1.5)+5.7/(2.1/(x+2.4)-1.4/(y+1.2))-x/(-1.1/(1.5*x*y-3.7)+x*y/(1.2*x+2.3*y+3.3*t-4.5)))*(-y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4))-t/(1.4/(y+1.2)+1.1/(3.2*x*y-1.5)))/(x*(1.1/(1.5*x*y-3.7)-2.1*x/(3.2*y-1.1*x+t))+y*(x*y/(1.2*x+2.3*y+3.3*t-4.5)+y*x/(-3.5/(-1.5*y-t/(1.7*x*y*t-7.7))+2.1/(x+2.4)))-5.7/(2.1/(x+2.4)-1.4/(y+1.2)))\n");
printf(ExprE4SR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE4SR,FuncE4SR);
printf("\n");
printf("*******************************************************************************\n");




printf("\n");
printf("**********************************  arithmetic expressions with common subexpressions ****************************************\n");
//printf("(((b/x-d/t)*(c/y-b/t)+(c/x-d/t+b/y)/(a*x/(c/t-b/(d*y-c*t)))+(b/x-d/t)*(c/y-b/t))*((a*t-d*y)*(b*(c/x-b/y)-d*(b/t-d/x))/(d*x*y*t-b*(c*x-a*t)-c*(d*y*t-c*x))))*((a*(a*x+b*y)-b*(a*y-b*x-c*t)+c*(a*t-b*x+c*y))/((a*x*y-b*t)*(b*t*x-c*y)-(d*x-b*y)/(b*t+c*y))+((d*x-b)*(a*y-c)*(d*t-c*x-a*y)/(a*x*y-b*t*x)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d))/((a*x+b)*(b*y+c)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d)))/(((b/x-d/t)*(c/y-b/t)+(c/x-d/t+b/y)/(a*x/(c/t-b/(d*y-c*t)))+(b/x-d/t)*(c/y-b/t))*((a*t-d*y)*(b*(c/x-b/y)-d*(b/t-d/x))/(d*x*y*t-b*(c*x-a*t)-c*(d*y*t-c*x)))+(a*(a*x+b*y)-b*(a*y-b*x-c*t)+c*(a*t-b*x+c*y))/((a*x*y-b*t)*(b*t*x-c*y)-(d*x-b*y)/(b*t+c*y))+((d*x-b)*(a*y-c)*(d*t-c*x-a*y)/(a*x*y-b*t*x)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d))/((a*x+b)*(b*y+c)+(b*y+c*x)/(c*t-b*y)-(a*x+b)/(c*y+d)))\n");
printf("\n");
printf(ExprE4ASR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE4ASR,FuncE4ASR);
printf("\n");
printf("*******************************************************************************\n");





printf("\n");
printf("**********************************  arithmetic expressions with constant and common subexpressions ****************************************\n");
//printf("(a*b*c*x/(b/c-c/d)-d*b*a*y/(c/d-b/a)-c*a*d*t/(a/c-b/d))/((a+b)*(b-d)*x/(a+b-c)-(a-b)*(b+d)*y/(a-b-d)+(c-b)*(b-d)*t/(b-c-a)+(a*(b-c)*x/(b*(a-b)*y/(b-c)-c*(c-d)*t/(a+d))-b*(b-d)*y/(c*(a+c)*x/(c-a)-b*(c+d)*t/(a-d))+c*(b-a)*t/(d*(b+c)*x/(b+d)-d*(d-c)*y/(b-c)))+((a*(b*d+c*a)*x-d*(a*d+c*b)*y-b*(a*c-d*b)*t)/(c*b*(a-b)/x-c*d*(a-c)/y-a*b*(a+d)/t)+((a+b)*x/(c-d)-(b+c)*y/(a-d)-(a+c)*t/(d-b))-((a*c-b*d)*t/(a+b)-(a*b-c*d)*y/(d+a)-(b*c-b*a)*x/(b-c))))-(a*(b-c)*x/(b*(a-b)*y/(b-c)-c*(c-d)*t/(a+d))-b*(b-d)*y/(c*(a+c)*x/(c-a)-b*(c+d)*t/(a-d))+c*(b-a)*t/(d*(b+c)*x/(b+d)-d*(d-c)*y/(b-c))+(a+b)*(b-d)*x/(a+b-c)-(a-b)*(b+d)*y/(a-b-d)+(c-b)*(b-d)*t/(b-c-a))+(a*b*c*x/(b/c-c/d)-d*b*a*y/(c/d-b/a)-c*a*d*t/(a/c-b/d))*((a*c-b*d)*t/(a+b)-(a*b-c*d)*y/(d+a)-(b*c-b*a)*x/(b-c))/((a*(b*d+c*a)*x-d*(a*d+c*b)*y-b*(a*c-d*b)*t)+(c*b*(a-b)/x-c*d*(a-c)/y-a*b*(a+d)/t)+(a+b)*x/(c-d)-(b+c)*y/(a-d)-(a+c)*t/(d-b))\n");
printf("\n");
printf(ExprE4SRC.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE4SRC,FuncE4SRC);
printf("\n");
printf("*******************************************************************************\n");


GNC = GNCt/5;
printf("\n");
printf("**********************************  arithmetic expressions:  with  common subexpressions: ****************************************\n");
printf("\n");
printf("Long expression consisting of 29731 characters is a 2nd order symbolic derivative of the expression N4: d2/(dxdy) (Expr4)");
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE2R_Diffdxdy_Long,FuncE2R_Diffdxdy_Long);
printf("\n");
printf("*******************************************************************************\n");
GNC = GNCt;


GNC = GNCt/10;
printf("\n");
printf("**********************************  arithmetic expressions:  with  common subexpressions: ****************************************\n");
printf("\n");
printf("Long expression consisting of 54412 characters is a 2nd order symbolic derivative of the expression N5: d2/(dxdy) (Expr5)");
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccE2PR_Diffdxdy_Long,FuncE2PR_Diffdxdy_Long);
printf("\n");
printf("*******************************************************************************\n");
GNC = GNCt;


printf("\n");
printf("*********************  indexing of arrays  ***********************************************\n");
printf("\n");
//printf("(x*vd[n+1]*ve[k+n]-y*vd[2*n+1]*ve[k+3*n]+t*vi[2*k+n+1])*(t*vd[4*n+k-3]*ve[j+5]+x*ve[5*n+3*k-4]*vd[j+k-n]-y*vi[2*j+k-1]*ve[5*j+3*k*n-2*j*k*n+4*k+15])\n");
printf(ExprA5R.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpVR(GccA5R,FuncA5R);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


//GNCt = GNC;
GNC = GNCt/100;
printf("*********************  calculations with arrays  ***********************************************\n");
printf("\n");
//printf("res:dbl=0; i:int=0; j:int=0; L:int=Len(vd)-1;  for(i=0,L,ifp(vd[i]>0,for(j=0,L,ifp((j > i)and(vd[j] > vd[i]),res=res-x*vd[j-i],res=res+x*vd[j])),res=res-y*vd[L-i])); res \n");
printf(ExprA6R.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpVR(GccA6R,FuncA6R);
printf("\n");
printf("*******************************************************************************\n");


printf("\n");
printf("*********************  calculations with arrays  ***********************************************\n");
printf("\n");
printf("analogous expression with vd->vdf ; see source \n");
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpVR(GccA6FR,FuncA6FR);
printf("\n");
printf("*******************************************************************************\n");
GNC = GNCt;






GNC = GNCt/100;

//rand size of vu1,vu2,vu3 (so that the optimizer GCC does not do "stupid things" :)  )

       lenv = rand() % 10+89 ;  /// size array changed in rand[89,99]

       vu1.resize(lenv);  vu2.resize(lenv);  vu3.resize(lenv);
       flSetLength(adrVU1, VType, lenv); flSetLength(adrVU2, VType, lenv); flSetLength(adrVU3, VType, lenv);

       for(ni=0; ni <= lenv-1; ni++)
       {
          vu1[ni] = ve1[ni]; vu2[ni] = ve2[ni]; vu3[ni] = ve3[ni];
           #ifdef   EXTENDED_FLOAT
            flSetArrayValueE(adrVU1,ni,vu1[ni]);
            flSetArrayValueE(adrVU2,ni,vu2[ni]);
            flSetArrayValueE(adrVU3,ni,vu3[ni]);
          #else
            flSetArrayValueD(adrVU1,ni,vu1[ni]);
            flSetArrayValueD(adrVU2,ni,vu2[ni]);
            flSetArrayValueD(adrVU3,ni,vu3[ni]);
          #endif

       };

//init address data of vu1,vu2,vu3 to Foreval , need after every resize of array (See  ExprA6PVU string):
Ptr0Vu1=&vu1[0];Ptr0Vu2=&vu2[0];Ptr0Vu3=&vu3[0]; LenVU=lenv;




printf("*********************  calculations with arrays; using direct addressing and via pointers   ***********************************************\n");
///L:int=len(vu1); for(k=1,L-2,vu1[k]=(vu2[k-1]*x+y*vu3[k+1])-vu1[k-1]);  s:ext=0; for(k=0,L-1,ifp(vu2[k] > vu3[k],s=s+vu1[k]; x=x+0.00001;y=y-0.00001 ,s=s-vu1[k]; x=x-0.000011;y=y+0.000011;));s/L
///and same expression, used only GCC arrays vu1,vu2,vu3 with read/write through pointers in PExtended/PDouble.  See  ExprA6PVU string
printf("\n");
printf(ExprA6VU.c_str());
printf("\n");
printf("and same expression, used only GCC arrays vu1,vu2,vu3 with read/write through pointers in PExtended/PDouble");
printf("\n");
printf("********************************** RUN ****************************************\n");

TestEvalCmpV_GCC(GccA6VU,_ResG,_PerfG);
TestEvalCmpV_Foreval(FuncA6VU,_ResF,_PerfF);
TestEvalCmpV_Foreval(FuncA6PVU,_ResF1,_PerfF1);

printf("Result GCC                                       : %.12e\n", (double)_ResG);
printf("Result Foreval (use internal arrays)             : %.12e\n", (double)_ResF);
printf("Result Foreval (use GCC arrays through pointers) : %.12e\n", (double)_ResF1);

printf("Perfomance GCC                                       Expr/ms :  %5d\n", _PerfG);
printf("Perfomance Foreval (use internal arrays)             Expr/ms :  %5d\n", _PerfF);
printf("Perfomance Foreval (use GCC arrays through pointers) Expr/ms :  %5d\n", _PerfF1);
printf("\n");
printf("*******************************************************************************\n");


/**
//Restore data vu1, vu2, vu3
       lenv = 100 ;

       vu1.resize(lenv);  vu2.resize(lenv);  vu3.resize(lenv);
       flSetLength(adrVU1, VType, lenv); flSetLength(adrVU2, VType, lenv); flSetLength(adrVU3, VType, lenv);

       for(ni=0; ni <= lenv-1; ni++)
       {
          vu1[ni] = ve1[ni]; vu2[ni] = ve2[ni]; vu3[ni] = ve3[ni];
           #ifdef   EXTENDED_FLOAT
            flSetArrayValueE(adrVU1,ni,vu1[ni]);
            flSetArrayValueE(adrVU2,ni,vu2[ni]);
            flSetArrayValueE(adrVU3,ni,vu3[ni]);
          #else
            flSetArrayValueD(adrVU1,ni,vu1[ni]);
            flSetArrayValueD(adrVU2,ni,vu2[ni]);
            flSetArrayValueD(adrVU3,ni,vu3[ni]);
          #endif

       };
**/
RefReshVar();
RefReshArrays();
GNC = GNCt;


/**

GNC = GNCt/100;
printf("\n");
printf("*********************  calculations with arrays:   ************************************************\n");
printf("***  Emulation of calculations with matrices, are placed  in arrays. M[i,j] -> A[i*LenStr+j]      ****\n");
printf("***  1. Calculation of the determinant of the product of 2 matrices. M1u=M1ux*M1uy; det(M1u)      ****\n");
printf("***  2. Calculation the same, using Gcc arrays with addressed by pointers via PExtended/PDouble   ****\n");
printf("\n");
printf(ExprA6VDU.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpDetMulMatrix(DetMulMxM1, FuncA6VDU, FuncA6VDUP);
printf("\n");
printf("*******************************************************************************\n");
GNC = GNCt;

**/





GNC = GNCt/100;
LenVR = _trunc(log(GNCt)*3);
printf("\n");
printf("*********************  calculations with arrays: sort  ***********************************************\n");
printf("\n");
//printf("len: int = len(vps);  s: dbl = 0; i:int = 0; l:int=0; r:int=len-1; bf: dbl=0; while(l < r, for(i=l,r-1, swapif(vps[i] > vps[i+1]) ); dec(r); fordown(i=r,l+1, swapif(vps[i] < vps[i-1])); inc(l););    for(i=0,len-2, ifp(vps[i] < vps[i+1], s=s+vps[i]; )); s+vps[len-1]; \n");
printf(ExprA6PR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpVPR(GccA6PR,FuncA6PR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");
GNC = GNCt;



GNC = GNCt/1000;
//GNC = GNCt/1000;
//P_Integral = 30;
printf("\n");
printf("**********************************  calculations Integral; using arrays ****************************************\n");
printf("\n");
//printf("n:int=P_Integral-1; h:ext=|y-x|/P_Integral; int1:ext=0;  L:int=N_Integral-1; for(j=0, n, x1:ext=x+j*h; x2:ext=x+(j+1)*h; ax:ext=(x1+x2)*0.5; sx:ext=(x2-x1)*0.5;  for(k=0, L,  xf:ext=sx*Bint[k]+ax;  int1=int1+Aint[k]*int1func(xf)*sx; ); ); int1;  < int1Func(x)=(a*x+b)*(c*x+d)/(a*x^2+b*x+c) >  \n");
printf(ExprIntegralF1.c_str());
printf("\n");
printf("int1Func(x)=(a*x+b)*(c*x+d)/(a*x^2+b*x+c)");
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccIntegralF1,FuncIntegralF1);
printf("\n");
printf("*******************************************************************************\n");
//P_Integral = 10;
GNC = GNCt;




GNC = GNCt;
printf("*********************  polynom  ***********************************************\n");
printf("\n");
//printf("1.1*pow(x,12)-2.1*pow(x,11)-3.1*pow(x,10)+2.2*pow(x,9)-3.3*pow(x,8)-5.7*pow(x,7)+2.3*pow(x,6)-9.8*pow(x,5)+1.7*pow(x,4)+1.4*pow(x,3)-7.5*pow(x,2)+7.7*x+12.3\n");
printf(ExprP7R.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR( GccP7R,FuncP7R);
printf("\n");
printf("calculation through 'poly' function using Horner's method.\n");
//printf("poly(1.1,-2.1,-3.1,2.2,-3.3,-5.7,2.3,-9.8,1.7,1.4,-7.5,7.7,12.3,x)\n");
printf(ExprP7AR.c_str());
TestEvalFR(FuncP7AR);
printf("\n");
printf("calculation through 'poly' function with coeff. in array.\n");
//printf("poly(CP12,x)\n");
printf(ExprP7BR.c_str());
TestEvalFR(FuncP7BR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



GNC = GNCt/5;

printf("*********************  trigonometric functions  ***********************************************\n");
printf("\n");
//printf("sin(cos(x+y))*cos(y*sin(x-y))*(2.15*cos(sin(3.53*cos(t-x)))-tan(x+y)*(tan(t+x)-cos(sin(t+y))*((1.76*asin(x/(x+y))+2.97*acos(y/(x+y)))*(2.12*atan(x-y)*atan2(x-y,x+y)-asin(t/(x+y))*acos(t/(y+x-t))/(atan(x+y)+atan2(t-x-y,x-t))))))\n");
printf(ExprF8R.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccF8R,FuncF8R);
printf("\n");
printf("*******************************************************************************\n");



printf("*********************  trigonometric+hyperbolic+pow functions  ***********************************************\n");
printf("\n");
//printf("(pow(x-sin(x),y-cos(y))/(tan(1.5*asin(1.1*x/(1.2*x+y))))+pow(y-sin(x*1.2)/cos(y+1.1),n+k)/(x+2.1*y))*(2.1*sinh(x/y)*sin(x+y)-3.2*cosh(x/(x+y)*cos(x-y))-tanh(y/(x+y))/(exp(2.1*x/y))*asin(1.1*x/(2.1*x+y))-2.1*atan(1.1*x-y)*atan2(x-y,1.3*x+y))\n");
printf(ExprF9R.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccF9R,FuncF9R);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


printf("*********************  trigonometric functions with common subexpressions ***********************************************\n");
printf("\n");
//printf("(cos(x*sin(x))*sin(y*cos(y))-sin(cos(x*cos(x+y)))*cos(y*cos(x*sin(x*y))))*(cos(sin(y)*y+x*cos(x))*sin(x*sin(x+y))-cos(y*cos(x*y))*sin(x*cos(x+y))+sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))/(sin(x*sin(x))*cos(y*cos(y))+cos(cos(x*cos(x+y)))*sin(sin(y)*y+x*cos(x))-sin(y*cos(x*sin(x*y)))*sin(cos(x*cos(x+y)))))\n");
printf(ExprF10SR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccF10SR,FuncF10SR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


printf("*********************  mixed functions with common subexpressions ***********************************************\n");
printf("\n");
//printf("(sin(x/(x+y))-sinh(x/(x+y))*asin(x/(x+y)))*(cosh(x/(x+y))*acos(x/(x+y))+cos(x/(x+y)))*(tanh(x/(x+y))-exp(x/(x+y)))\n");
printf(ExprF11SR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccF11SR,FuncF11SR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


f12sr:
//GNC = GNCt/5;
printf("*********************  mixed functions with common subexpressions ***********************************************\n");
printf("\n");
//printf("(pow(sin(x+y),k+2*n)*pow(cos(x*y),n+k)-pow(x-sin(x*y),pow(cos(x*y),n+k))*pow(y-cos(x+y),pow(sin(x+y),k+2*n)))/(sin(pow(sin(x+y),k+2*n))/cos(pow(cos(x*y),n+k))-sin(pow(x-sin(x),y-cos(y)))/cos(pow(x-sin(x),y-cos(y))))\n");
printf(ExprF12SR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccF12SR,FuncF12SR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



printf("*********************  mixed functions with constant subexpressions ***********************************************\n");
printf("\n");
//printf("a*cos(sin(c*pow(a/c,c/(a-b*c))/(b-c))*x+cos(a/exp(a/b)*y+b/pow(a-b,a/(c*sin(a*b/c)))))*pow(sin(a*b/(a-c))+cos(c/(a/b-b/c)),x/y)\n");
printf(ExprF12CR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccF12CR,FuncF12CR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



GNC = GNCt;

printf("*********************   external functions  ***********************************************\n");
printf("\n");
//printf("sp3(x-sp3(sp1(y/x),sp3(x+y,x+t,y+t)-2.1*sp2(sp1(t*1.25),1.1-sp2(sp1(1.1+x),y-sp3(x+1.2,y+1.3,t+1.4))),t-sp2(sp3(x-y,y-t,t-x),sp2(2.1-x,3.2-y))),y-sp3(-x*1.51,-2.79*y,t-sp3(-t+2.75,x*y*2.71,-y-sp2(3.6*t-y*sp2(t-y*1.11,-y+x*2.11),y-sp3(1.15*x-y,y*1.72,x*1.27)))),1.51*y-sp3(1.19*x,-y+1.17,-t-1.97)*sp3(sp2(x*2.73,1.96*y),-sp2(-x*1.95,y/(x-1.77)),-sp3(y+1.89,7.98-t,-x-2.98)))");
printf(ExprFE13SPR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccFE13R,FuncFE13SPR);
printf("other call type: sp->ps\n");
TestEvalFR(FuncFE13PSR);
printf("other call type: sp->ms\n");
TestEvalFR(FuncFE13MSR);
printf("\n");
printf("other call type: sp->pc\n");
TestEvalFR(FuncFE13PCR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



printf("*********************   external functions with arrays  ***********************************************\n");
printf("\n");
//printf("sp8(ve,j+3,t+sp8(ve,n+2,y-sp8(ve,k+3,x-y,vd,j+n,y-sp8(ve,k+n,t-y,vd,j+n,y,vi,j+2),vi,j+2),vd,k+2,t,vi,n+2*j),vd,j+n,x-sp8(ve,n*3+1,-x,vd,j+n-1,-y,vi,k+2*n-1)/sp8(ve,j,x+sp8(ve,k+n+2,t+sp8(ve,n*4-2,y-t,vd,j+n+1,y*t,vi,k+5),vd,n+3,x+sp8(ve,j+k,y-t,vd,j+k*2,y+1.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,x-y,vi,n+2*k),vi,n+2)\n");
printf(ExprFE14SPR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpR(GccFE14R,FuncFE14SPR);
printf("other call type: sp->ps\n");
TestEvalFR(FuncFE14PSR);
printf("other call type: sp->ms\n");
TestEvalFR(FuncFE14MSR);
printf("\n");
printf("other call type: sp->pc\n");
TestEvalFR(FuncFE14PCR);
printf("\n");



printf("*********************   external functions  with constant subexpressions ***********************************************\n");
printf("\n");
//printf("sp2(sp3(a-b,b/c,c/(b-a))*a/sp2(sp2(b/sp1(a/(b+c)),b/(c+a)),a-b*c)*x/b,x/sp2(a*sp1(c/b),a/(b+a)))*sp3((c-a)*sp1(c/b)/sp2(b/(c+a/b),b/(c-a))*x/sp1(c/a),sp1(c/b)/sp1(b/a),x/sp2(b-c/a,c-b/c))*sp2(-a/(c+b/a),x/(a-b))\n");
printf(ExprFE15SPRC.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
   TestEvalCmpR(GccFE15RC,FuncFE15SPRC);
   printf("other call type: sp->ps\n");
   TestEvalFR(FuncFE15PSRC);
   printf("other call type: sp->ms\n");
   TestEvalFR(FuncFE15MSRC);
   printf("other call type: sp->pc\n");
   TestEvalFR(FuncFE15PCRC);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



printf("*********************   external functions  with common subexpressions ***********************************************\n");
printf("\n");
//printf("(sp3(x/y-sp2(x-y,x/y),x/sp2(x-y,x/y),sp1(x/y)*sp1(-sp1(y/x)))*sp1(x/y)-sp2(y/sp2(x-y,x/y),-x/sp2(x-y,x/y))*sp1(-sp1(y/x)))/(sp1(x/y-sp2(x-y,x/y))-sp2(x/sp2(x-y,x/y),y/sp2(x-y,x/y))+sp2(x-y,x/y)*sp3(x/y-sp2(x-y,x/y),x/sp2(x-y,x/y),sp1(x/y)*sp1(-sp1(y/x))))\n");
printf(ExprFE15SPR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
   TestEvalCmpR(GccFE15R,FuncFE15SPR);
   printf("other call type: sp->ps\n");
   TestEvalFR(FuncFE15PSR);
   printf("other call type: sp->ms\n");
   TestEvalFR(FuncFE15MSR);
   printf("other call type: sp->pc\n");
   TestEvalFR(FuncFE15PCR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



printf("*********************   external functions  with common subexpressions ***********************************************\n");
printf("\n");
//printf("sp3(-x/sp2(x/y,-t/x)-sp3(x/(x+y),t/(x-y),y/(x+t)),x/sp1(x/y)-y/sp2(t/y,y/(x+t)),-sp2(x/(x+y),t/(x-y))/sp3(x/y,y/(x+y+t),t/(t-x-y)))*sp2(x/sp1(x/y),sp2(x/(x+y),t/(x-y)))/(sp1(x/sp3(x/(x+y),t/(x-y),y/(x+t)))*sp3(x/y,y/(x+y+t),t/(t-x-y))-sp2(t/(t-x-y)-y/(x+t),y/(x+y+t)-t/(x-y))*(x/sp1(x/y)-y/sp2(t/y,y/(x+t)))/(sp2(x/sp1(x/y),sp2(x/(x+y),t/(x-y)))-sp1(sp3(x/y,y/(x+y+t),t/(t-x-y)))))\n");
printf(ExprFE15ASPR.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
   TestEvalCmpR(GccFE15AR,FuncFE15ASPR);
   printf("other call type: sp->ps\n");
   TestEvalFR(FuncFE15APSR);
   printf("other call type: sp->ms\n");
   TestEvalFR(FuncFE15AMSR);
   printf("other call type: sp->pc\n");
   TestEvalFR(FuncFE15APCR);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


printf("********************************** END ****************************************\n");
printf("\n");




};





void CompileTestZ()
{

flSet(fl_ENABLE, fl_SHOW_EXCEPTION,0); // show exception message from dll

                                       /// arithmetic expressions:

//ExprE1 = " res=res+z1*z2-z3*(z1+z2-z3*(z1-z2*(z2-z1))-z1*z3*(z3-z2)*z2)+z2*(z1+z3+z2*(z1-z3)-z1*(z3-z1))*z1";
//ExprE1 = "x*(y*x+t*(-x-(-y-x*(-y/x+x*(x*y+y*(t+x)))/(-y*(x*y*t*(x+t)*(y+t)/(y/t+x/(t-y))))/(y*(y/(x+y+t)-x/(x*y+t/(y+x*(y-x))))-x*(t/(t-x)+y*x/(y-x*(t/y-t)-t*(x*(-t-y-x))))))))";

//ExprE1 = " res=res+z1*(z3-z2+z1)*z2+z2*(z1+z2-z3)*z3";
//ExprE1 = "res=res+z1*(2.1*z2-3.5*z3)*1.5-3.2*(4.7-z1-z3*(2.2*z1*z3-1.7*z2)+1.2*z2*z1*(2.1*z2*z3-3.2*z1)*(1.6*z1-3.9*z2))";
//ExprE1 = "res=res+z1*z2*z3+z3+z1+z2";

//ExprE1 = "res=res+z1*z2*(z2*z1-z3*z2*(z1*z3+z2*z3*(z3*z1+z1*z2)))";

//ExprE1 = "res=res+(z1/z2-z1*z2)*((z3-z1)*(z1+z2)-z3/z2)*(z1*z3/(z1-z2+z3))/((z3-z2/(z3-z1))*(z2*z3-z1/(z3/z1-z2/(z2-z1))))";
//ExprE1 = "res=res+((z1-z2)/(z3-z1)-(z1+(z3-z2*z1)/(z1-z3+z2))*(z3-z2))*(z3+z2-(z1-z2)*(z3-z1/z3))";
//ExprE1 = "res=res+(z1/z3-z2/(z1*z2-z3)+z3*(z2/(z3/z1-z1/z3)-z1/(z1*z2-z2/z3))+(z2*z3-z3*(z1+z2)/(z2/(z1*z2-z3)-z1/(z1*z2-z2/z3))))/((z2*z3-z1*z2)/(z3*(z2/z3+z3*(z2/(z3/z1-z1/z3)-z1/(z1*z2-z2/z3)))))";

//ExprE1 = "res=res+z1*(z2/i-i*Im(z1-z2/z3)-Re(z3*z2-z1/(z3+z2))/i)*(2.5/i-i/3.7-Re(z1/(z2+z3))/Im(z1/i-i*z2))";



//ExprE1 = "res=res+z1*z3*z2-z1*(z2-z3*z1*(z2-z1)*(z3+z1)*(z1*z2-z2+z3))";
//ExprE1 = "res=res+z3*z2-z1*(z2-z3*z1*(z2-z1)*(z3+z1))";
//ExprE1 = "res=res+(z1-z2)*(z2-z3)*(z3-z1)*(z1+z2)*(z2+z3)*(z1+z3)";
//ExprE1 = "res=res+(z1-z2)*(z2-z3)*(z3-z1)*(z1+z2)*(z2+z3)*(z1+z3)*(z2*z1-z3)*(z1*z3+z2)";

 ExprES1Z = "res=res+z1+z2*z3";
 ExprES2Z = "res=res+(Ai*z1-Bi*z2)*(Ci*x-Di*z3)*(A*z2-B*z3+Bi*y)*(x-Ai)";

 ExprE1Z = "res=res+(z1-z2)*(z2-z3)*(z3-z1)*(z1+z2)*(z2+z3)*(z1+z3)*(z2*z1-z3)-z2*(z1*z3+z2)*(z1+z2*z3)";

 ExprE1AZ = "res=res+z1*z2-z3*(z1+z2-z3*(z1-z2*(z2-z1))-z1*z3*(z3-z2)*z2)+z2*(z1+z3+z2*(z1-z3)-z1*(z3-z1))*z1";

 ExprE1BZ ="res = res +z1*z2/(2.7*z1*(-3.3*z1*(4.4*z2*(2.9*z1+3.7*z2+10.1*(1.9*z1+9.1*z2)))))*(2.3*z1/z3-2.5*z1*(3.7*z3-1)/(2.7*z1-3.6*z2-4.7)*(z1/(3.6*z1-1)-4.1/z1+5.8*(2.6*z1*z3-1.7)/(z2+1.7)-7.1*(2.8*z1*(z2+1.1)*(3.4*z2+2.2)*(3.1/(z1+1.5)-2.3*z3/(2.4*z2*z3-1.7)+(4.7*z1-1.1)*(5.7*z2-7.4)/(z1-2.7*z2-1.7-2.4*z3/(3.8-7.6*z1-8.1*z2*(4.2*z1/(2.9*z3+1.6)-7.8*z1-8.9/z3+9.9*(2.1*z1-1.2)*(3.1*z1+4.9*z2+5.8)*(2.1*z1*(7.3-2.1*z2)*z3-7.1)*z1*(-2.5*z2-5.7)*z3/(z1-z2*2.8-3.6/(z1/(z3-1.7)-7.8/(z2+2.5)+8.3/(2.8*(-1.5*z1+3.1)*z2*(-1.2*z3-1)+1.7)-9.4)))))/(z1-1.5)))))";

 //ExprE1CZ ="res = res + z1*(z1+z2+z3)+z1*(z2+z1+z3)+z1*(z1+z3+z2)+z1*(z2+z3+z1)+z1*(z3+z1+z2)+z1*(z3+z2+z1)+z2*(z1-z2-z3)+z2*(z2-z1-z3)+z2*(z1-z3-z2)+z2*(z2-z3-z1)+z2*(z3-z1-z2)+z2*(z3-z2-z1)";
 ExprE1CZ ="res = res + z1*z1+z1*z2+z1*z3+z1*z2+z1*z1+z1*z3+z1*z1+z1*z3+z1*z2+z1*z2+z1*z3+z1*z1+z1*z3+z1*z1+z1*z2+z1*z3+z1*z2+z1*z1+z1*z2-z2*z2-z2*z3+z2*z2-z1*z2-z2*z3+z1*z2-z2*z3-z2*z2+z2*z2-z2*z3-z1*z2+z2*z3-z1*z2-z2*z2+z2*z3-z2*z2-z1*z2";

//mix
 //ExprE2CZ = "res=res+t*z1*z2-0.123*z3*(ai*z1+z2*x-y*z3*(-z1*bi-0.123*z2*t*(z2*ci*y-z1*0.345*t))-bi*z1*(0.579*y-ci*x)*z3*(-z3*(x-ci*y)-z2*(t*0.257-bi))*z2)+z2*(x-0.123*t-bi)*(-z1*0.479+(y-ci*t)*z3+z2*(z1-z3)-z1*(-ai*z3-z1-x*y))*t";

 ExprE2CZ = "res=res+(z1*x*bi-y*z2*0.571)*(ai*z2-z3*0.234)+(t*z3*a-z1*y*0.579)*(bi*z1-z2*ci*t)+(z2*(y-x*a)+z3*c-x*y*ai)*(ai-t*z1-y*z3*0.357)-(-z2*z1*ci+0.753*z3*(b*t+x))";
 ExprE2Z =  "res=res+(z1*z2/(z1+z2)+z1/(x/z1+z2/y)-z2*(z3*t-x*z2)*(z1+x)*(y+z3)+z3*z2*(z3-y)/(y+z1))*(1.5*z1-3.7/z2+2.5*x*z3)*(z3/(1.7-z3*y)-y/z1)*((x*z1+z2*t+1.5)/(z1*z3+t)+z3)/(z3*(z1*2.5+1.7*t*z2)+z2*z3*t*2.7)";
 ExprE2AZ = "res=res+(z1*x-y/(z3-z2+2.7*z1)+(x*z2-z3/y)/(x*3.1+y*t)-z1*z2*(z3/(z2*x*z3-x/(z2-z1-z3*t))-z2/(z1/t-x/z2))*(-z3*(x-t/(z1-x))*(z2-z3/(z2+y)))/(-2.1*z2/x-z2*y/(z3-z1-z2*z3)))/((z3-t*x)*(y/x+z2+z3)*(2.7-x*y)*(z3-1.7*x*z2)-(2.9/z3+y+z3/(x*2.5*z1-z2*1.2/y)))";
 ExprE2BZ = "res=res+(z1*x/i-i*y/(z3*Re(z2*i-y*i)-Im(z2+2.7*z1)/i)+(x*z2-z3/y/i)/(Re(x*3.1-i*z2)+y*t)-Im(z1*z2)*(z3/(z2*x*z3-i*x/(z2-z1-z3*t))-z2/(z1/t-x/z2/Re(z1-i*x*y/z2)))*(-i*(z3*(x-t/(z1-x*Im(z1-z2*i/x)))*(z2/i-z3*i/(z2+y)))/(-2.1*z2/x-Re(z2*y)*i/Im(z3-z1-z2*z3))))/((z3-t*x)*Im(y/x/i+z2+z3*(2.5*i-7))*(2.7-x*y)*Re(z3-1.7*x*z2)-(-i*2.9/z3+y+z3/(x*2.5*z1-z2*1.2/y-i)))";

 //with constant
 ExprE3CM = "res=res+ (ai*z2*(b-ci*ai)*c-bi*z1*(ci-ai*b)*ai)*((-ai*(b-ci*(ci*b-ai*b*z1)))*z1*c*ai-bi*z2*z1*ai*c)*(ai*(bi-ci)*z1-z2*(ai*z1*b-z2*ci*z1)-(-ci-a*(-bi*(-z1*b*ci*z2-z2*a*(ai-b*ci*ai)))))*(ai*z1*c*(bi*ci-c*(b*ai-ci*(bi*a-ci*b))))/(a*z1*b*(a*ci-bi*(ai-c))-ci*z2*bi*(b-a*ci-(-ci*(-bi-a)*bi)*(-ci+ai)))";
 ExprE3C  = "res=res+(ai*z2*(b-ci/ai)*c-bi*z1/(ci-ai/b)*ai)*((-ai/(b-ci/(ci/b-ai*b*z1)))*z1/c/ai-bi/z2/z1/ai/c)*(ai*(bi-ci)/z1-z2/(ai*z1/b-z2/ci/z1)-(-ci-a/(-bi/(-z1/b/ci/z2-z2*a/(ai-b/ci*ai)))))/(ai*z1*c/(bi*ci-c/(b/ai-ci/(bi/a-ci/b))))*(a*z1*b/(a/ci-bi/(ai-c))-ci/z2*bi/(b-a/ci-(-ci/(-bi-a)/bi)/(-ci+ai)))";

 //common subexpr:
 ExprE3SZ = "res=res+(z1*z2+z3/z1+z2/(z1*z2-z3/z1))/(z2/z3-z3/z1)-z1*z2*z3*(z2/z3-z3/z1)/(z3-z2/(z1*z2-z3/z1))";
 ExprE3ASZ = "res=res+(z2/z3-z2*z1+x*z2-y/(z3/z1-z2/y))*(x/(z1-z2*z1)+z3*(z1*(z2/z3-z1))-z3/(x*z2-y*z1))-(z1*(z2/z3-z1)+z3*(x*z2-y*z1)-x/(z1-z2*z1))/(z3*(z1*(z2/z3-z1))-(z2/z3-z3/z1)*(z2*z1-z3/z1+y/(z3/z1-z2/y)))";
 ExprE3BSZ = "res=res+z1*z2+z1*z3*(z2*z3+z1*z2*(z2*z3+z1*z3*(z1*z2+z2*z3*(z1*z3+z2*z3*(z1*z2+z2*z3*(z1*z3+z1*z2*(z2*z3+z1*z3*(z1*z2+z2*z3*(z1*z3+z2*z3*(z2*z3+z1*z3*(z2*z3+z1*z3*(z2*z3+z1*z2))))))))))))";

 ExprE4SZ = "res=res+z1*(z2/z3-x/(z1+z2))-i/(z1*i-i/z2)+z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2)))+(z2-z3)/(z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2))))";

 ExprE4SCZ = "res=res+(ai*bi*ci*z1/(bi/ci-ci/di)-di*bi*ai*z2/(ci/di-bi/ai)-ci*ai*di*z3/(ai/ci-bi/di))/((ai+bi)*(bi-di)*z1/(ai+bi-ci)-(ai-bi)*(bi+di)*z2/(ai-bi-di)+(ci-bi)*(bi-di)*z3/(bi-ci-ai)+(ai*(bi-ci)*z1/(bi*(ai-bi)*z2/(bi-ci)-ci*(ci-di)*z3/(ai+di))-bi*(bi-di)*z2/(ci*(ai+ci)*z1/(ci-ai)-bi*(ci+di)*z3/(ai-di))+ci*(bi-ai)*z3/(di*(bi+ci)*z1/(bi+di)-di*(di-ci)*z2/(bi-ci)))+((ai*(bi*di+ci*ai)*z1-di*(ai*di+ci*bi)*z2-bi*(ai*ci-di*bi)*z3)/(ci*bi*(ai-bi)/z1-ci*di*(ai-ci)/z2-ai*bi*(ai+di)/z3)+((ai+bi)*z1/(ci-di)-(bi+ci)*z2/(ai-di)-(ai+ci)*z3/(di-bi))-((ai*ci-bi*di)*z3/(ai+bi)-(ai*bi-ci*di)*z2/(di+ai)-(bi*ci-bi*ai)*z1/(bi-ci))))-(ai*(bi-ci)*z1/(bi*(ai-bi)*z2/(bi-ci)-ci*(ci-di)*z3/(ai+di))-bi*(bi-di)*z2/(ci*(ai+ci)*z1/(ci-ai)-bi*(ci+di)*z3/(ai-di))+ci*(bi-ai)*z3/(di*(bi+ci)*z1/(bi+di)-di*(di-ci)*z2/(bi-ci))+(ai+bi)*(bi-di)*z1/(ai+bi-ci)-(ai-bi)*(bi+di)*z2/(ai-bi-di)+(ci-bi)*(bi-di)*z3/(bi-ci-ai))+(ai*bi*ci*z1/(bi/ci-ci/di)-di*bi*ai*z2/(ci/di-bi/ai)-ci*ai*di*z3/(ai/ci-bi/di))*((ai*ci-bi*di)*z3/(ai+bi)-(ai*bi-ci*di)*z2/(di+ai)-(bi*ci-bi*ai)*z1/(bi-ci))/((ai*(bi*di+ci*ai)*z1-di*(ai*di+ci*bi)*z2-bi*(ai*ci-di*bi)*z3)+(ci*bi*(ai-bi)/z1-ci*di*(ai-ci)/z2-ai*bi*(ai+di)/z3)+(ai+bi)*z1/(ci-di)-(bi+ci)*z2/(ai-di)-(ai+ci)*z3/(di-bi))";



 ExprP1Z = "res=res+1.1*pow(z1,12)-2.1*pow(z1,11)-3.1*pow(z1,10)+2.2*pow(z1,9)-3.3*pow(z1,8)-5.7*pow(z1,7)+2.3*pow(z1,6)-9.8*pow(z1,5)+1.7*pow(z1,4)+1.4*pow(z1,3)-7.5*pow(z1,2)+7.7*z1+12.3";
 ExprP1ZP = "res=res+poly(1.1,-2.1,-3.1,2.2,-3.3,-5.7,2.3,-9.8,1.7,1.4,-7.5,7.7,12.3,z1)";
 ExprP1ZV = "res=res+poly(cp12,z1)";

 ExprP1CZ =  "res=res+pow(z1,12)-a*pow(z1,11)-ai*pow(z1,10)+bi*pow(z1,9)-b*pow(z1,8)-c*pow(z1,7)+ci*pow(z1,6)-d*pow(z1,5)+di*pow(z1,4)+a*ai*pow(z1,3)-bi*b*pow(z1,2)+ci*di*z1+ai*ci*d*a";
 ExprP1CZP = "res=res+poly(1,-a,-ai,bi,-b,-c,ci,-d,di,a*ai,-bi*b,ci*di,ai*ci*d*a,z1)";


// ExprA6Z =  "resl:Cxext=0; ci:int=0; cj:int=0; L:int=Len(vd)-1;   for(ci,0,L,ifp(vd[ci] >0,for(cj,0,L,ifp((cj > ci)and(vd[cj]  > vd[ci]), resl=resl-z1*vd[cj-ci], resl=resl+z1*vd[cj])),  resl.re=resl.re-z2.re*vd[L-ci];  resl.im=resl.im-z2.im*vd[ci];)); res=res+resl";
// ExprA6FZ = "resl:Cxext=0; ci:int=0; cj:int=0; L:int=Len(vdf)-1;  for(ci,0,L,ifp(vdf[ci]>0,for(cj,0,L,ifp((cj > ci)and(vdf[cj] > vdf[ci]),resl=resl-z1*vdf[cj-ci],resl=resl+z1*vdf[cj])), resl.re=resl.re-z2.re*vdf[L-ci]; resl.im=resl.im-z2.im*vdf[ci];)); res=res+resl";

                                                   /// function
 //ExprF1Z = "res=res+sin(cos(z1+0.31*z2))*cos(0.15*sin(z1-z3))*(1.17*cos(sin(0.35*cos(0.25*z3-z1))))*tan(z1+0.12*z2)*(tan(z3+z1)-cos(sin(z3+z2))*((1.76*asin(0.05*(1.2*z1-z2))+1.97*acos((z2-2*z1)))*(1.12*atan(z1-z2)*sin(0.37*z3+z1)-asin(z3-(z1+0.15*z2))*acos(z3*(z2+z1-z3))*(atan(-1.15*z1+z2)+atan(z3-z1-0.11*z2)))))";

                                                  ///trig
   ExprF1Z = "res=res+sin(acos(z1+z2)-asin(z1-z2))*cos(asin(z2-z1)-acos(z2+z3))-tan(cos(z2-z3)-sin(z3-z2))*tan(atan(z1+z3)-atan(z1-z3))";

                                                 ///hyp
   ExprF2Z = "res=res+sinh(acosh(z1+z2)-asinh(z1-z2))*cosh(asinh(z2-z1)-acosh(z2+z3))*(sinh(atanh(z2-z3)-atanh(z3-z2))+cosh(tanh(z1+z3)-tanh(z1-z3)))";

                                                /// mixed
   //ExprF3Z = "res=res+(pow(z1-sin(z1),z2-cos(z2))/(tan(1.5*asin(1.1*z1/(1.2*z1+z2))))+pow(z2-sin(z1*1.2)/cos(z2+1.1),n+k)/(z1+2.1*z2))*(2.1*sinh(z1/z2)*sin(0.17*z1-z2)-3.2*cosh(z1/(z1-z2)*cos(z1-0.25*z2))-tanh(z2/(z3+z2))/(exp(2.1*z1/z3))*asin(1.1*z1/(2.1*z1+z2))-2.1*atan(1.1*z1-z2)*atan(1.5*z1+z2))";
    ExprF3Z = "res=res+(pow(z1-sin(z1),z2-cos(z2))/(tan(asin(z1/(z1+z2))))+pow(z2-sin(z2-z1)/cos(z3),n+k)/(z3-z2))*(sinh(z1/z2)*sin(z1-z2)-cosh(z1/(z3+z1)*cos(z2-z3))-tanh(z2/(z3+z2))/(exp(z1/z3))*asin(z1/(z3-z1))-atan(z1-z3)*atan(z1+z3))";



                                         /// function with common subexpr.
 /// trig. func.
  ExprF4Z  = "res=res+(cos(z1+z2)-sin(z1+z3))*(sin(cos(z1+z2)+sin(z1+z3))-cos(z1+z3)*sin(z1+z2))*tan(cos(z2+z3))*tan(sin(sin(z1+z3)-sin(z1+z2)))/(cos(sin(z1+z3)-sin(z1+z2))-sin(z2+z3)*sin(z1-z2))*tan(cos(z1+z2)*sin(z1+z3))*(cos(cos(z1+z2)+sin(z1+z3))-sin(cos(z1+z2)+sin(z1+z3)))";


// ExprF4Z  = "res=res+(cos(z1+sin(z1))*sin(z2+cos(z2))-sin(cos(z1+cos(z1+z2)))*cos(z2+cos(z1+sin(z1+z2))))*(cos(sin(z2)/z2+z1+cos(z1))*sin(z1+sin(z1+z2))-cos(z2+cos(z1+z2))*sin(z1+cos(z1+z2))+sin(z2+cos(z1+sin(z1+z2)))*sin(cos(z1+cos(z1+z2)))/(sin(z1+sin(z1))*cos(z2+cos(z2))+cos(cos(z1+cos(z1+z2)))*sin(sin(z2)/z2+z1+cos(z1))-sin(z2+cos(z1+sin(z1+z2)))*sin(cos(z1+cos(z1+z2)))))";

 /// hyp. func
 ExprF5Z =  "res=res+(cosh(z1/z2)-sinh(z1/z3))*(sinh(cosh(z1/z2)+sinh(z1/z3))-cosh(z1/z3)*sinh(z1/z2))*tanh(cosh(z2/z3))*tanh(sinh(sinh(z1/z3)-sinh(z1/z2)))/(cosh(sinh(z1/z3)-sinh(z1/z2))-sinh(z2/z3)*sinh(z1/z2))*tanh(cosh(z1/z2)*sinh(z1/z3))*(cosh(cosh(z1/z2)+sinh(z1/z3))-sinh(cosh(z1/z2)+sinh(z1/z3)))";


 /// mixed
 ExprF6Z = "res=res+(sin(z1/(z1+z2))-sinh(z1/(z1+z2))*asin(z1/(z1+z2)))*(cosh(z1/(z1+z2))*acos(z1/(z1+z2))+cos(z1/(z1+z2)))*(tanh(z1/(z1+z2))-exp(z1/(z1+z2)))";
    //(sin(z1/(z1+z2))-sinh(z1/(z1+z2))*asin(z1/(z1+z2)))*(cosh(z1/(z1+z2))*acos(z1/(z1+z2))+cos(z1/(z1+z2)))*(tanh(z1/(z1+z2))-exp(z1/(z1+z2)))*(atan(z1/(z1+z2))+atanh(z1/(z1+z2)))

 ExprF7Z =  "res=res+(pow(sin(z1+z2),k+2*n-10)*pow(cos(z1*z2),n+k-7)-pow(z1-sin(z1*z2),pow(cos(z1*z2),n+k-7))*pow(z2-cos(z1+z2),pow(sin(z1+z2),k+2*n-10)))/(sin(pow(sin(z1+z2),k+2*n-10))/cos(pow(cos(z1*z2),n+k-7))-sin(pow(z1-sin(z1),z2-cos(z2)))/cos(pow(z1-sin(z1),z2-cos(z2))))";

 ExprF8CZ =  "res=res+ai*cos(sin(ci*pow(ai/ci,ci/(ai-bi*ci))/(bi-ci))*z1/cos(ai/exp(ci/bi)*z2+bi/pow(ai-bi,ai/(ci*sin(ai*bi/ci)))))*pow(sin(ai*bi/(ai-ci))+cos(ci/(ai/bi-bi/ci)),z1/z2)";


 ExprFE13ASPZ = "res=res+sp3(z1-sp3(z1*y,-t*z2,z3+z1),x*sp2(x+y,sp1(0.57*y)),sp2(z1+x,y-z2)-z2)*sp3(sp2(x-y,sp1(x*1.15)),z2-sp2(z1-z3,z2*x),-sp3(sp2(x*y,y+t)*x,2.1*x-y,y*sp2(2.15*y,1.17*t)))";
 ExprFE13APSZ = "res=res+ps3(z1-ps3(z1*y,-t*z2,z3+z1),x*ps2(x+y,ps1(0.57*y)),ps2(z1+x,y-z2)-z2)*ps3(ps2(x-y,ps1(x*1.15)),z2-ps2(z1-z3,z2*x),-ps3(ps2(x*y,y+t)*x,2.1*x-y,y*ps2(2.15*y,1.17*t)))";
 ExprFE13AMSZ = "res=res+ms3(z1-ms3(z1*y,-t*z2,z3+z1),x*ms2(x+y,ms1(0.57*y)),ms2(z1+x,y-z2)-z2)*ms3(ms2(x-y,ms1(x*1.15)),z2-ms2(z1-z3,z2*x),-ms3(ms2(x*y,y+t)*x,2.1*x-y,y*ms2(2.15*y,1.17*t)))";
 ExprFE13APCZ = "res=res+pc3(z1-pc3(z1*y,-t*z2,z3+z1),x*pc2(x+y,pc1(0.57*y)),pc2(z1+x,y-z2)-z2)*pc3(pc2(x-y,pc1(x*1.15)),z2-pc2(z1-z3,z2*x),-pc3(pc2(x*y,y+t)*x,2.1*x-y,y*pc2(2.15*y,1.17*t)))";


 ExprFE13SPZ = "res=res+sp3(z1*x,sp2(z1+z3,x-z2)-sp2(sp2(z1+z2,t+y)-z2,sp3(z1+y,z3*1.25,-z2)*sp2(x+y,z1-z2)),z3-z1*sp2(z3*x,-y*z1))*sp2(-sp2(x*t,-y*x),sp1(z2+z3)*sp1(x-t))-sp3(1.75*x,y-t,y-t*x)*sp2(z1-z2*sp2(z2-t,t+z3),sp1(z3-z2)*x-z2)*sp2(-sp2(z3+y,x+z2),z2-z3)";
 ExprFE13PSZ = "res=res+ps3(z1*x,ps2(z1+z3,x-z2)-ps2(ps2(z1+z2,t+y)-z2,ps3(z1+y,z3*1.25,-z2)*ps2(x+y,z1-z2)),z3-z1*ps2(z3*x,-y*z1))*ps2(-ps2(x*t,-y*x),ps1(z2+z3)*ps1(x-t))-ps3(1.75*x,y-t,y-t*x)*ps2(z1-z2*ps2(z2-t,t+z3),ps1(z3-z2)*x-z2)*ps2(-ps2(z3+y,x+z2),z2-z3)";
 ExprFE13MSZ = "res=res+ms3(z1*x,ms2(z1+z3,x-z2)-ms2(ms2(z1+z2,t+y)-z2,ms3(z1+y,z3*1.25,-z2)*ms2(x+y,z1-z2)),z3-z1*ms2(z3*x,-y*z1))*ms2(-ms2(x*t,-y*x),ms1(z2+z3)*ms1(x-t))-ms3(1.75*x,y-t,y-t*x)*ms2(z1-z2*ms2(z2-t,t+z3),ms1(z3-z2)*x-z2)*ms2(-ms2(z3+y,x+z2),z2-z3)";
 ExprFE13PCZ = "res=res+pc3(z1*x,pc2(z1+z3,x-z2)-pc2(pc2(z1+z2,t+y)-z2,pc3(z1+y,z3*1.25,-z2)*pc2(x+y,z1-z2)),z3-z1*pc2(z3*x,-y*z1))*pc2(-pc2(x*t,-y*x),pc1(z2+z3)*pc1(x-t))-pc3(1.75*x,y-t,y-t*x)*pc2(z1-z2*pc2(z2-t,t+z3),pc1(z3-z2)*x-z2)*pc2(-pc2(z3+y,x+z2),z2-z3)";

 ExprFE13BSPZ = "res=res+sp8(ve,j+3,z1-sp8(ve,n+2,z2-sp8(ve,k+3,z1-z2,vd,j+n,z2-sp8(ve,k+n,t*z1-y,vd,j+n,z2-z3,vi,j+2),vi,j+2),vd,k+2,t*(z1+z2),vi,n+2*j),vd,j+n,z3-sp8(ve,n*3+1,-z3*x,vd,j+n-1,-z1*1.15,vi,k+2*n-1)/sp8(ve,j,z3+x/sp8(ve,k+n+2,z1*y+sp8(ve,n*4-2,z3-z1*2.73,vd,j+n+1,y*z3,vi,k+5),vd,n+3,z1*t+z3/sp8(ve,j+k,z2*1.17-z3,vd,j+k*2,z3*y-2.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1+z3*2.12,vi,n+2*k),vi,n+2)";
 ExprFE13BPSZ = "res=res+ps8(ve,j+3,z1-ps8(ve,n+2,z2-ps8(ve,k+3,z1-z2,vd,j+n,z2-ps8(ve,k+n,t*z1-y,vd,j+n,z2-z3,vi,j+2),vi,j+2),vd,k+2,t*(z1+z2),vi,n+2*j),vd,j+n,z3-ps8(ve,n*3+1,-z3*x,vd,j+n-1,-z1*1.15,vi,k+2*n-1)/ps8(ve,j,z3+x/ps8(ve,k+n+2,z1*y+ps8(ve,n*4-2,z3-z1*2.73,vd,j+n+1,y*z3,vi,k+5),vd,n+3,z1*t+z3/ps8(ve,j+k,z2*1.17-z3,vd,j+k*2,z3*y-2.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1+z3*2.12,vi,n+2*k),vi,n+2)";
 ExprFE13BPCZ = "res=res+pc8(ve,j+3,z1-pc8(ve,n+2,z2-pc8(ve,k+3,z1-z2,vd,j+n,z2-pc8(ve,k+n,t*z1-y,vd,j+n,z2-z3,vi,j+2),vi,j+2),vd,k+2,t*(z1+z2),vi,n+2*j),vd,j+n,z3-pc8(ve,n*3+1,-z3*x,vd,j+n-1,-z1*1.15,vi,k+2*n-1)/pc8(ve,j,z3+x/pc8(ve,k+n+2,z1*y+pc8(ve,n*4-2,z3-z1*2.73,vd,j+n+1,y*z3,vi,k+5),vd,n+3,z1*t+z3/pc8(ve,j+k,z2*1.17-z3,vd,j+k*2,z3*y-2.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1+z3*2.12,vi,n+2*k),vi,n+2)";


 ExprFE14SPZ = "res=res+spall(ve,n+3,spall(ve,n+1,z1/z2,vd,j+k-1,x,z2/spall(ve,j+3,z3-spall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/spall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-spall(ve,k+3,z1/spall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*spall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)";
 ExprFE14PSZ = "res=res+psall(ve,n+3,psall(ve,n+1,z1/z2,vd,j+k-1,x,z2/psall(ve,j+3,z3-psall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/psall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-psall(ve,k+3,z1/psall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*psall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)";
 ExprFE14MSZ = "res=res+msall(ve,n+3,msall(ve,n+1,z1/z2,vd,j+k-1,x,z2/msall(ve,j+3,z3-msall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/msall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-msall(ve,k+3,z1/msall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*msall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)";
 ExprFE14PCZ = "res=res+pcall(ve,n+3,pcall(ve,n+1,z1/z2,vd,j+k-1,x,z2/pcall(ve,j+3,z3-pcall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/pcall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-pcall(ve,k+3,z1/pcall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*pcall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)";


 ExprFE15SPZ = "res=res+(sp3(z1/z2-sp2(z1-z2,z1/z2),z1/sp2(z1-z2,z1/z2),sp1(z1/z2)*sp1(-sp1(z2/z1)))*sp1(z1/z2)-sp2(z2/sp2(z1-z2,z1/z2),-z1/sp2(z1-z2,z1/z2))*sp1(-sp1(z2/z1)))/(sp1(z1/z2-sp2(z1-z2,z1/z2))-sp2(z1/sp2(z1-z2,z1/z2),z2/sp2(z1-z2,z1/z2))+sp2(z1-z2,z1/z2)*sp3(z1/z2-sp2(z1-z2,z1/z2),z1/sp2(z1-z2,z1/z2),sp1(z1/z2)*sp1(-sp1(z2/z1))))";
 ExprFE15PSZ = "res=res+(ps3(z1/z2-ps2(z1-z2,z1/z2),z1/ps2(z1-z2,z1/z2),ps1(z1/z2)*ps1(-ps1(z2/z1)))*ps1(z1/z2)-ps2(z2/ps2(z1-z2,z1/z2),-z1/ps2(z1-z2,z1/z2))*ps1(-ps1(z2/z1)))/(ps1(z1/z2-ps2(z1-z2,z1/z2))-ps2(z1/ps2(z1-z2,z1/z2),z2/ps2(z1-z2,z1/z2))+ps2(z1-z2,z1/z2)*ps3(z1/z2-ps2(z1-z2,z1/z2),z1/ps2(z1-z2,z1/z2),ps1(z1/z2)*ps1(-ps1(z2/z1))))";
 ExprFE15MSZ = "res=res+(ms3(z1/z2-ms2(z1-z2,z1/z2),z1/ms2(z1-z2,z1/z2),ms1(z1/z2)*ms1(-ms1(z2/z1)))*ms1(z1/z2)-ms2(z2/ms2(z1-z2,z1/z2),-z1/ms2(z1-z2,z1/z2))*ms1(-ms1(z2/z1)))/(ms1(z1/z2-ms2(z1-z2,z1/z2))-ms2(z1/ms2(z1-z2,z1/z2),z2/ms2(z1-z2,z1/z2))+ms2(z1-z2,z1/z2)*ms3(z1/z2-ms2(z1-z2,z1/z2),z1/ms2(z1-z2,z1/z2),ms1(z1/z2)*ms1(-ms1(z2/z1))))";
 ExprFE15PCZ = "res=res+(pc3(z1/z2-pc2(z1-z2,z1/z2),z1/pc2(z1-z2,z1/z2),pc1(z1/z2)*pc1(-pc1(z2/z1)))*pc1(z1/z2)-pc2(z2/pc2(z1-z2,z1/z2),-z1/pc2(z1-z2,z1/z2))*pc1(-pc1(z2/z1)))/(pc1(z1/z2-pc2(z1-z2,z1/z2))-pc2(z1/pc2(z1-z2,z1/z2),z2/pc2(z1-z2,z1/z2))+pc2(z1-z2,z1/z2)*pc3(z1/z2-pc2(z1-z2,z1/z2),z1/pc2(z1-z2,z1/z2),pc1(z1/z2)*pc1(-pc1(z2/z1))))";

 ExprFE15SPZC = "res=res+sp2(sp3(ai-bi,bi/ci,ci/(bi-ai))*ai/sp2(sp2(bi/sp1(ai/(bi+ci)),bi/(ci+ai)),ai-bi*ci)*z1/bi,z2/sp2(ai*sp1(ci/bi),ai/(bi+ai)))*sp3((ci-ai)*sp1(ci/bi)/sp2(bi/(ci+ai/bi),bi/(ci-ai))*z2/sp1(ci/ai),sp1(ci/bi)/sp1(bi/ai),z2/sp2(bi-ci/ai,ci-bi/ci))*sp2(-ai/(ci+bi/ai),z1/(ai-bi))";
 ExprFE15PSZC = "res=res+ps2(ps3(ai-bi,bi/ci,ci/(bi-ai))*ai/ps2(ps2(bi/ps1(ai/(bi+ci)),bi/(ci+ai)),ai-bi*ci)*z1/bi,z2/ps2(ai*ps1(ci/bi),ai/(bi+ai)))*ps3((ci-ai)*ps1(ci/bi)/ps2(bi/(ci+ai/bi),bi/(ci-ai))*z2/ps1(ci/ai),ps1(ci/bi)/ps1(bi/ai),z2/ps2(bi-ci/ai,ci-bi/ci))*ps2(-ai/(ci+bi/ai),z1/(ai-bi))";
 ExprFE15MSZC = "res=res+ms2(ms3(ai-bi,bi/ci,ci/(bi-ai))*ai/ms2(ms2(bi/ms1(ai/(bi+ci)),bi/(ci+ai)),ai-bi*ci)*z1/bi,z2/ms2(ai*ms1(ci/bi),ai/(bi+ai)))*ms3((ci-ai)*ms1(ci/bi)/ms2(bi/(ci+ai/bi),bi/(ci-ai))*z2/ms1(ci/ai),ms1(ci/bi)/ms1(bi/ai),z2/ms2(bi-ci/ai,ci-bi/ci))*ms2(-ai/(ci+bi/ai),z1/(ai-bi))";
 ExprFE15PCZC = "res=res+pc2(pc3(ai-bi,bi/ci,ci/(bi-ai))*ai/pc2(pc2(bi/pc1(ai/(bi+ci)),bi/(ci+ai)),ai-bi*ci)*z1/bi,z2/pc2(ai*pc1(ci/bi),ai/(bi+ai)))*pc3((ci-ai)*pc1(ci/bi)/pc2(bi/(ci+ai/bi),bi/(ci-ai))*z2/pc1(ci/ai),pc1(ci/bi)/pc1(bi/ai),z2/pc2(bi-ci/ai,ci-bi/ci))*pc2(-ai/(ci+bi/ai),z1/(ai-bi))";


flCompile(ExprES1Z.c_str(),0,FuncES1Z);
flCompile(ExprES2Z.c_str(),0,FuncES2Z);


flCompile(ExprE1Z.c_str(),0,FuncE1Z);
flCompile(ExprE1AZ.c_str(),0,FuncE1AZ);
flCompile(ExprE1BZ.c_str(),0,FuncE1BZ);
//flCompile(ExprE1CZ.c_str(),0,FuncE1CZ);

flCompile(ExprE2CZ.c_str(),0,FuncE2CZ);
flCompile(ExprE2Z.c_str(),0,FuncE2Z);
flCompile(ExprE2AZ.c_str(),0,FuncE2AZ);
flCompile(ExprE2BZ.c_str(),0,FuncE2BZ);

flCompile(ExprE3CM.c_str(),0,FuncE3CM);
flCompile(ExprE3C.c_str(),0,FuncE3C);

flCompile(ExprE3SZ.c_str(),0,FuncE3SZ);
flCompile(ExprE3ASZ.c_str(),0,FuncE3ASZ);
flCompile(ExprE3BSZ.c_str(),0,FuncE3BSZ);
flCompile(ExprE4SZ.c_str(),0,FuncE4SZ);
flCompile(ExprE4SCZ.c_str(),0,FuncE4SCZ);

flCompile(ExprF1Z.c_str(),0,FuncF1Z);
flCompile(ExprF2Z.c_str(),0,FuncF2Z);
flCompile(ExprF3Z.c_str(),0,FuncF3Z);
flCompile(ExprF4Z.c_str(),0,FuncF4Z);
flCompile(ExprF5Z.c_str(),0,FuncF5Z);
flCompile(ExprF6Z.c_str(),0,FuncF6Z);
flCompile(ExprF7Z.c_str(),0,FuncF7Z);
flCompile(ExprF8CZ.c_str(),0,FuncF8CZ);

flCompile(ExprP1Z.c_str(),0,FuncP1Z);
flCompile(ExprP1ZP.c_str(),0,FuncP1ZP);
flCompile(ExprP1ZV.c_str(),0,FuncP1ZV);

flCompile(ExprP1CZ.c_str(),0,FuncP1CZ);
flCompile(ExprP1CZP.c_str(),0,FuncP1CZP);

//flCompile(ExprA6Z.c_str(),0,FuncA6Z);
//flCompile(ExprA6FZ.c_str(),0,FuncA6FZ);

flCompile(ExprFE13ASPZ.c_str(),0,FuncFE13ASPZ);
flCompile(ExprFE13APSZ.c_str(),0,FuncFE13APSZ);
flCompile(ExprFE13APCZ.c_str(),0,FuncFE13APCZ);
flCompile(ExprFE13AMSZ.c_str(),0,FuncFE13AMSZ);

flCompile(ExprFE13SPZ.c_str(),0,FuncFE13SPZ);
flCompile(ExprFE13PSZ.c_str(),0,FuncFE13PSZ);
flCompile(ExprFE13MSZ.c_str(),0,FuncFE13MSZ);
flCompile(ExprFE13PCZ.c_str(),0,FuncFE13PCZ);

flCompile(ExprFE13BSPZ.c_str(),0,FuncFE13BSPZ);
flCompile(ExprFE13BPSZ.c_str(),0,FuncFE13BPSZ);
flCompile(ExprFE13BPCZ.c_str(),0,FuncFE13BPCZ);

flCompile(ExprFE14SPZ.c_str(),0,FuncFE14SPZ);
flCompile(ExprFE14PSZ.c_str(),0,FuncFE14PSZ);
flCompile(ExprFE14MSZ.c_str(),0,FuncFE14MSZ);
flCompile(ExprFE14PCZ.c_str(),0,FuncFE14PCZ);


flCompile(ExprFE15SPZ.c_str(),0,FuncFE15SPZ);
flCompile(ExprFE15PSZ.c_str(),0,FuncFE15PSZ);
flCompile(ExprFE15MSZ.c_str(),0,FuncFE15MSZ);
flCompile(ExprFE15PCZ.c_str(),0,FuncFE15PCZ);


flCompile(ExprFE15SPZC.c_str(),0,FuncFE15SPZC);
flCompile(ExprFE15PSZC.c_str(),0,FuncFE15PSZC);
flCompile(ExprFE15MSZC.c_str(),0,FuncFE15MSZC);
flCompile(ExprFE15PCZC.c_str(),0,FuncFE15PCZC);

/*
flCompile(ExprE2.c_str(),0,FuncE2);
flCompile(ExprE3S.c_str(),0,FuncE3S);
flCompile(ExprE4S.c_str(),0,FuncE4S);
flCompile(ExprA5.c_str(),0,FuncA5);
flCompile(ExprA6.c_str(),0,FuncA6);
flCompile(ExprP7.c_str(),0,FuncP7);
flCompile(ExprP7A.c_str(),0,FuncP7A);
flCompile(ExprF8.c_str(),0,FuncF8);
flCompile(ExprF9.c_str(),0,FuncF9);
flCompile(ExprF10S.c_str(),0,FuncF10S);
flCompile(ExprF11S.c_str(),0,FuncF11S);
flCompile(ExprF12S.c_str(),0,FuncF12S);
flCompile(ExprFE13SP.c_str(),0,FuncFE13SP);
flCompile(ExprFE13PS.c_str(),0,FuncFE13PS);
flCompile(ExprFE13MS.c_str(),0,FuncFE13MS);
flCompile(ExprFE14SP.c_str(),0,FuncFE14SP);
flCompile(ExprFE14PS.c_str(),0,FuncFE14PS);
flCompile(ExprFE14MS.c_str(),0,FuncFE14MS);
*/

 flSet(fl_DISABLE, fl_SHOW_EXCEPTION,0); // show exception message from dll
};



void CompareTestZ()
{
  Extended resG,resF,h,dh,dx,dy,dt;
  double dresG,dresF;
  //TFloatType resG,resF;
  INT32 rt,FpuExc,t1,t2,i,ECode,PerfG,PerfF,GNCt;
  Pointer32 Func;
  string Expr;

  PTGccTestZ GccFunc;
  PTGccTestZ_std GccFunc_std;




/*
printf("\n");
printf("**********************************  arithmetic expressions: complex  ****************************************\n");
printf("\n");
printf("z1*(z1+z2+z3)+z1*(z2+z1+z3)+z1*(z1+z3+z2)+z1*(z2+z3+z1)+z1*(z3+z1+z2)+z1*(z3+z2+z1)+z2*(z1-z2-z3)+z2*(z2-z1-z3)+z2*(z1-z3-z2)+z2*(z2-z3-z1)+z2*(z3-z1-z2)+z2*(z3-z2-z1)\n");
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ(GccE1CZ,FuncE1CZ);
printf("\n");
*/



printf("\n");
printf("\n");
printf("\n");
printf("\n");
printf("**********************************  arithmetic expressions: complex, short expr. (only ops: + - *)  ****************************************\n");
printf("\n");
//printf("z1+z2*z3\n");
printf("\n");
printf(ExprES1Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE1Z,FuncE1Z);
TestEvalCmpZ_std(GccES1Z,GccES1Z_std,FuncES1Z);
printf("\n");



printf("\n");
printf("\n");
printf("\n");
printf("\n");
printf("**********************************  arithmetic expressions: complex+real, short expr. (only ops: + - *) ****************************************\n");
printf("\n");
//printf("(Ai*z1-Bi*z2)*(Ci*x-Di*z3)*(A*z2-B*z3-Ci*y)\n");
printf("\n");
printf(ExprES2Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE1Z,FuncE1Z);
TestEvalCmpZ_std(GccES2Z,GccES2Z_std,FuncES2Z);
printf("\n");





printf("\n");
printf("\n");
printf("\n");
printf("\n");
printf("**********************************  arithmetic expressions: complex (only ops: + - *)  ****************************************\n");
printf("\n");
//printf("(z1-z2)*(z2-z3)*(z3-z1)*(z1+z2)*(z2+z3)*(z1+z3)*(z2*z1-z3)-z2*(z1*z3+z2)*(z1+z2*z3)\n");
printf("\n");
printf(ExprE1Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE1Z,FuncE1Z);
TestEvalCmpZ_std(GccE1Z,GccE1Z_std,FuncE1Z);
printf("\n");


printf("\n");
printf("**********************************  arithmetic expressions: complex (only ops: + - *) ****************************************\n");
printf("\n");
//printf("z1*z2-z3*(z1+z2-z3*(z1-z2*(z2-z1))-z1*z3*(z3-z2)*z2)+z2*(z1+z3+z2*(z1-z3)-z1*(z3-z1))*z1\n");
printf(ExprE1AZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE1AZ,FuncE1AZ);
TestEvalCmpZ_std(GccE1AZ,GccE1AZ_std,FuncE1AZ);
printf("\n");






GNCt = GNC;
GNC = GNCt/10;

printf("\n");
printf("**********************************  arithmetic expressions: complex  ****************************************\n");
printf("\n");
//printf("z1*z2/(2.7*z1*(-3.3*z1*(4.4*z2*(2.9*z1+3.7*z2+10.1*(1.9*z1+9.1*z2)))))*(2.3*z1/z3-2.5*z1*(3.7*z3-1)/(2.7*z1-3.6*z2-4.7)*(z1/(3.6*z1-1)-4.1/z1+5.8*(2.6*z1*z3-1.7)/(z2+1.7)-7.1*(2.8*z1*(z2+1.1)*(3.4*z2+2.2)*(3.1/(z1+1.5)-2.3*z3/(2.4*z2*z3-1.7)+(4.7*z1-1.1)*(5.7*z2-7.4)/(z1-2.7*z2-1.7-2.4*z3/(3.8-7.6*z1-8.1*z2*(4.2*z1/(2.9*z3+1.6)-7.8*z1-8.9/z3+9.9*(2.1*z1-1.2)*(3.1*z1+4.9*z2+5.8)*(2.1*z1*(7.3-2.1*z2)*z3-7.1)*z1*(-2.5*z2-5.7)*z3/(z1-z2*2.8-3.6/(z1/(z3-1.7)-7.8/(z2+2.5)+8.3/(2.8*(-1.5*z1+3.1)*z2*(-1.2*z3-1)+1.7)-9.4)))))/(z1-1.5)))))\n");
printf(ExprE1BZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE1BZ,FuncE1BZ);
TestEvalCmpZ_std(GccE1BZ,GccE1BZ_std,FuncE1BZ);
printf("\n");

GNC = GNCt;




printf("\n");
printf("**********************************  arithmetic expressions: complex+real (only ops: + - *)  ****************************************\n");
printf("\n");
//printf("(z1*x*bi-y*z2*0.571)*(ai*z2-z3*0.234)+(t*z3*a-z1*y*0.579)*(bi*z1-z2*ci*t)+(z2*(y-x*a)+z3*c-x*y*ai)*(ai-t*z1-y*z3*0.357)-(-z2*z1*ci+0.753*z3*(b*t+x))\n");
printf(ExprE2CZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE2Z,FuncE2Z);
TestEvalCmpZ_std(GccE2CZ,GccE2CZ_std,FuncE2CZ);
printf("\n");




printf("\n");
printf("**********************************  arithmetic expressions: complex+real  ****************************************\n");
printf("\n");
//printf("(z1*z2/(z1+z2)+z1/(x/z1+z2/y)-z2*(z3*t-x*z2)*(z1+x)*(y+z3)+z3*z2*(z3-y)/(y+z1))*(1.5*z1-3.7/z2+2.5*x*z3)*(z3/(1.7-z3*y)-y/z1)*((x*z1+z2*t+1.5)/(z1*z3+t)+z3)/(z3*(z1*2.5+1.7*t*z2)+z2*z3*t*2.7)\n");
printf(ExprE2Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE2Z,FuncE2Z);
TestEvalCmpZ_std(GccE2Z,GccE2Z_std,FuncE2Z);
printf("\n");



printf("\n");
printf("**********************************  arithmetic expressions: complex+real  ****************************************\n");
printf("\n");
//printf("(z1*x-y/(z3-z2+2.7*z1)+(x*z2-z3/y)/(x*3.1+y*t)-z1*z2*(z3/(z2*x*z3-x/(z2-z1-z3*t))-z2/(z1/t-x/z2))*(-z3*(x-t/(z1-x))*(z2-z3/(z2+y)))/(-2.1*z2/x-z2*y/(z3-z1-z2*z3)))/((z3-t*x)*(y/x+z2+z3)*(2.7-x*y)*(z3-1.7*x*z2)-(2.9/z3+y+z3/(x*2.5*z1-z2*1.2/y)))\n");
printf(ExprE2AZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE2AZ,FuncE2AZ);
TestEvalCmpZ_std(GccE2AZ,GccE2AZ_std,FuncE2AZ);
printf("\n");


printf("\n");
printf("**********************************  arithmetic expressions: complex+real  ****************************************\n");
printf("\n");
//printf("(z1*x/i-i*y/(z3*Re(z2*i-y*i)-Im(z2+2.7*z1)/i)+(x*z2-z3/y/i)/(Re(x*3.1-i*z2)+y*t)-Im(z1*z2)*(z3/(z2*x*z3-i*x/(z2-z1-z3*t))-z2/(z1/t-x/z2/Re(z1-i*x*y/z2)))*(-i*(z3*(x-t/(z1-x*Im(z1-z2*i/x)))*(z2/i-z3*i/(z2+y)))/(-2.1*z2/x-Re(z2*y)*i/Im(z3-z1-z2*z3))))/((z3-t*x)*Im(y/x/i+z2+z3*(2.5*i-7))*(2.7-x*y)*Re(z3-1.7*x*z2)-(-i*2.9/z3+y+z3/(x*2.5*z1-z2*1.2/y-i)))\n");
printf(ExprE2BZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE2BZ,FuncE2BZ);
TestEvalCmpZ_std(GccE2BZ,GccE2BZ_std,FuncE2BZ);
printf("\n");



printf("**********************************  arithmetic expressions: complex, with constant subexpressions  ****************************************\n");
printf("\n");
//printf("(ai*z2*(b-ci*ai)*c-bi*z1*(ci-ai*b)*ai)*((-ai*(b-ci*(ci*b-ai*b*z1)))*z1*c*ai-bi*z2*z1*ai*c)*(ai*(bi-ci)*z1-z2*(ai*z1*b-z2*ci*z1)-(-ci-a*(-bi*(-z1*b*ci*z2-z2*a*(ai-b*ci*ai)))))*(ai*z1*c*(bi*ci-c*(b*ai-ci*(bi*a-ci*b))))/(a*z1*b*(a*ci-bi*(ai-c))-ci*z2*bi*(b-a*ci-(-ci*(-bi-a)*bi)*(-ci+ai)))\n");
printf(ExprE3CM.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE3CM,FuncE3CM);
TestEvalCmpZ_std(GccE3CM,GccE3CM_std,FuncE3CM);
printf("\n");


printf("\n");
printf("**********************************  arithmetic expressions: complex, with constant subexpressions  ****************************************\n");
printf("\n");
//printf("(ai*z2*(b-ci/ai)*c-bi*z1/(ci-ai/b)*ai)*((-ai/(b-ci/(ci/b-ai*b*z1)))*z1/c/ai-bi/z2/z1/ai/c)*(ai*(bi-ci)/z1-z2/(ai*z1/b-z2/ci/z1)-(-ci-a/(-bi/(-z1/b/ci/z2-z2*a/(ai-b/ci*ai)))))/(ai*z1*c/(bi*ci-c/(b/ai-ci/(bi/a-ci/b))))*(a*z1*b/(a/ci-bi/(ai-c))-ci/z2*bi/(b-a/ci-(-ci/(-bi-a)/bi)/(-ci+ai)))\n");
printf(ExprE3C.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE3C,FuncE3C);
TestEvalCmpZ_std(GccE3C,GccE3C_std,FuncE3C);
printf("\n");


printf("\n");
printf("**********************************  arithmetic expressions: complex, with common subexpressions  ****************************************\n");
printf("\n");
//printf("(z1*z2+z3/z1+z2/(z1*z2-z3/z1))/(z2/z3-z3/z1)-z1*z2*z3*(z2/z3-z3/z1)/(z3-z2/(z1*z2-z3/z1))\n");
printf(ExprE3SZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE3SZ,FuncE3SZ);
TestEvalCmpZ_std(GccE3SZ,GccE3SZ_std,FuncE3SZ);
printf("\n");




printf("\n");
printf("**********************************  arithmetic expressions: complex, with common subexpressions  ****************************************\n");
printf("\n");
//printf("z1*z2+z1*z3*(z2*z3+z1*z2*(z2*z3+z1*z3*(z1*z2+z2*z3*(z1*z3+z2*z3*(z1*z2+z2*z3*(z1*z3+z1*z2*(z2*z3+z1*z3*(z1*z2+z2*z3*(z1*z3+z2*z3*(z2*z3+z1*z3*(z2*z3+z1*z3*(z2*z3+z1*z2))))))))))))\n");
printf(ExprE3BSZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccE3BSZ,GccE3BSZ_std,FuncE3BSZ);
printf("\n");




printf("\n");
printf("**********************************  arithmetic expressions: complex, with common subexpression  ****************************************\n");
printf("\n");
//printf("(z2/z3-z2*z1+x*z2-y/(z3/z1-z2/y))*(x/(z1-z2*z1)+z3*(z1*(z2/z3-z1))-z3/(x*z2-y*z1))-(z1*(z2/z3-z1)+z3*(x*z2-y*z1)-x/(z1-z2*z1))/(z3*(z1*(z2/z3-z1))-(z2/z3-z3/z1)*(z2*z1-z3/z1+y/(z3/z1-z2/y)))\n");
printf(ExprE3ASZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE3ASZ,FuncE3ASZ);
TestEvalCmpZ_std(GccE3ASZ,GccE3ASZ_std,FuncE3ASZ);
printf("\n");


printf("\n");
printf("**********************************  arithmetic expressions: complex+real, with common subexpression  ****************************************\n");
printf("\n");
//printf("z1*(z2/z3-x/(z1+z2))-i/(z1*i-i/z2)+z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2)))+(z2-z3)/(z2*(y*i-Re(z2/z3)*Im(i/z2))-z3/(i/(z1*i-i/z2)-z1*(z2/z3-x/(z1+z2))))\n");
printf(ExprE4SZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE4SZ,FuncE4SZ);
TestEvalCmpZ_std(GccE4SZ,GccE4SZ_std,FuncE4SZ);
printf("\n");


/**
printf("\n");
printf("**********************************  arithmetic expressions: complex, with common & constant subexpression  ****************************************\n");
printf("\n");
printf("(ai*bi*ci*z1/(bi/ci-ci/di)-di*bi*ai*z2/(ci/di-bi/ai)-ci*ai*di*z3/(ai/ci-bi/di))/((ai+bi)*(bi-di)*z1/(ai+bi-ci)-(ai-bi)*(bi+di)*z2/(ai-bi-di)+(ci-bi)*(bi-di)*z3/(bi-ci-ai)+(ai*(bi-ci)*z1/(bi*(ai-bi)*z2/(bi-ci)-ci*(ci-di)*z3/(ai+di))-bi*(bi-di)*z2/(ci*(ai+ci)*z1/(ci-ai)-bi*(ci+di)*z3/(ai-di))+ci*(bi-ai)*z3/(di*(bi+ci)*z1/(bi+di)-di*(di-ci)*z2/(bi-ci)))+((ai*(bi*di+ci*ai)*z1-di*(ai*di+ci*bi)*z2-bi*(ai*ci-di*bi)*z3)/(ci*bi*(ai-bi)/z1-ci*di*(ai-ci)/z2-ai*bi*(ai+di)/z3)+((ai+bi)*z1/(ci-di)-(bi+ci)*z2/(ai-di)-(ai+ci)*z3/(di-bi))-((ai*ci-bi*di)*z3/(ai+bi)-(ai*bi-ci*di)*z2/(di+ai)-(bi*ci-bi*ai)*z1/(bi-ci))))-(ai*(bi-ci)*z1/(bi*(ai-bi)*z2/(bi-ci)-ci*(ci-di)*z3/(ai+di))-bi*(bi-di)*z2/(ci*(ai+ci)*z1/(ci-ai)-bi*(ci+di)*z3/(ai-di))+ci*(bi-ai)*z3/(di*(bi+ci)*z1/(bi+di)-di*(di-ci)*z2/(bi-ci))+(ai+bi)*(bi-di)*z1/(ai+bi-ci)-(ai-bi)*(bi+di)*z2/(ai-bi-di)+(ci-bi)*(bi-di)*z3/(bi-ci-ai))+(ai*bi*ci*z1/(bi/ci-ci/di)-di*bi*ai*z2/(ci/di-bi/ai)-ci*ai*di*z3/(ai/ci-bi/di))*((ai*ci-bi*di)*z3/(ai+bi)-(ai*bi-ci*di)*z2/(di+ai)-(bi*ci-bi*ai)*z1/(bi-ci))/((ai*(bi*di+ci*ai)*z1-di*(ai*di+ci*bi)*z2-bi*(ai*ci-di*bi)*z3)+(ci*bi*(ai-bi)/z1-ci*di*(ai-ci)/z2-ai*bi*(ai+di)/z3)+(ai+bi)*z1/(ci-di)-(bi+ci)*z2/(ai-di)-(ai+ci)*z3/(di-bi))\n");
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpZ(GccE4SZ,FuncE4SZ);
TestEvalCmpZ_std(GccE4SCZ,GccE4SCZ_std,FuncE4SCZ);
printf("\n");
**/


printf("\n");
printf("*********************  polynom with real coeff ***********************************************\n");
printf("\n");
//printf("1.1*pow(z1,12)-2.1*pow(z1,11)-3.1*pow(z1,10)+2.2*pow(z1,9)-3.3*pow(z1,8)-5.7*pow(z1,7)+2.3*pow(z1,6)-9.8*pow(z1,5)+1.7*pow(z1,4)+1.4*pow(z1,3)-7.5*pow(z1,2)+7.7*z1+12.3\n");
printf(ExprP1Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpPZ_std(GccP1Z_std,FuncP1Z);
printf("\n");
printf("calculation through 'poly' function using Horner's method.\n");
//printf("poly(1.1,-2.1,-3.1,2.2,-3.3,-5.7,2.3,-9.8,1.7,1.4,-7.5,7.7,12.3,z1)\n");
printf(ExprP1ZP.c_str());
printf("\n");
TestEvalPZF(FuncP1ZP);
printf("\n");
printf("calculation through 'poly' function with coeff. in array.\n");
//printf("poly(CP12,z1)\n");
printf(ExprP1ZV.c_str());
printf("\n");
TestEvalPZF(FuncP1ZV);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");




printf("\n");
printf("*********************  polynom with complex coeff ***********************************************\n");
printf("\n");
printf(ExprP1CZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpPZ_std(GccP1CZ_std,FuncP1CZ);
printf("\n");
printf("calculation through 'poly' function using Horner's method.\n");
printf(ExprP1CZP.c_str());
printf("\n");
TestEvalPZF(FuncP1CZP);
printf("\n");




GNCt = GNC;
GNC = GNCt/5;

printf("\n");
printf("*********************  trigonometric functions  ***********************************************\n");
printf("\n");
//printf("sin(acos(z1+z2)-asin(z1-z2))*cos(asin(z2-z1)-acos(z2+z3))-tan(cos(z2-z3)-sin(z3-z2))*tan(atan(z1+z3)-atan(z1-z3))\n");
printf(ExprF1Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF1Z_std,FuncF1Z);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


printf("\n");
printf("*********************  hyperbolic functions  ***********************************************\n");
printf("\n");
//printf("sinh(acosh(z1+z2)-asinh(z1-z2))*cosh(asinh(z2-z1)-acosh(z2+z3))*(sinh(atanh(z2-z3)-atanh(z3-z2))+cosh(tanh(z1+z3)-tanh(z1-z3)))\n");
printf(ExprF2Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF2Z_std,FuncF2Z);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



printf("\n");
printf("*********************  mixed functions  ***********************************************\n");
printf("\n");
//printf("(pow(z1-sin(z1),z2-cos(z2))/(tan(asin(z1/(z1+z2))))+pow(z2-sin(z2-z1)/cos(z3),n+k)/(z3-z2))*(sinh(z1/z2)*sin(z1-z2)-cosh(z1/(z3+z1)*cos(z2-z3))-tanh(z2/(z3+z2))/(exp(z1/z3))*asin(z1/(z3-z1))-atan(z1-z3)*atan(z1+z3))\n");
printf(ExprF3Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF3Z_std,FuncF3Z);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");



printf("\n");
printf("*********************    trigonometric functions with common subexpressions  ***********************************************\n");
printf("\n");
//printf(" (cos(z1+z2)-sin(z1+z3))*(sin(cos(z1+z2)+sin(z1+z3))-cos(z1+z3)*sin(z1+z2))*tan(cos(z2+z3))*tan(sin(sin(z1+z3)-sin(z1+z2)))/(cos(sin(z1+z3)-sin(z1+z2))-sin(z2+z3)*sin(z1-z2))*tan(cos(z1+z2)*sin(z1+z3))*(cos(cos(z1+z2)+sin(z1+z3))-sin(cos(z1+z2)+sin(z1+z3)))\n");
printf(ExprF4Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF4Z_std,FuncF4Z);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


printf("\n");
printf("*********************  hyperbolic  functions with common subexpressions   ***********************************************\n");
printf("\n");
//printf(" (cosh(z1/z2)-sinh(z1/z3))*(sinh(cosh(z1/z2)+sinh(z1/z3))-cosh(z1/z3)*sinh(z1/z2))*tanh(cosh(z2/z3))*tanh(sinh(sinh(z1/z3)-sinh(z1/z2)))/(cosh(sinh(z1/z3)-sinh(z1/z2))-sinh(z2/z3)*sinh(z1/z2))*tanh(cosh(z1/z2)*sinh(z1/z3))*(cosh(cosh(z1/z2)+sinh(z1/z3))-sinh(cosh(z1/z2)+sinh(z1/z3)))\n");
printf(ExprF5Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF5Z_std,FuncF5Z);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");




printf("\n");
printf("*********************  mixed  functions with common subexpressions   ***********************************************\n");
printf("\n");
//printf("(sin(z1/(z1+z2))-sinh(z1/(z1+z2))*asin(z1/(z1+z2)))*(cosh(z1/(z1+z2))*acos(z1/(z1+z2))+cos(z1/(z1+z2)))*(tanh(z1/(z1+z2))-exp(z1/(z1+z2)))\n");
printf(ExprF6Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF6Z_std,FuncF6Z);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");




printf("\n");
printf("*********************  mixed  functions with common subexpressions   ***********************************************\n");
printf("\n");
//printf("(pow(sin(z1+z2),k+2*n-10)*pow(cos(z1*z2),n+k-7)-pow(z1-sin(z1*z2),pow(cos(z1*z2),n+k-7))*pow(z2-cos(z1+z2),pow(sin(z1+z2),k+2*n-10)))/(sin(pow(sin(z1+z2),k+2*n-10))/cos(pow(cos(z1*z2),n+k-7))-sin(pow(z1-sin(z1),z2-cos(z2)))/cos(pow(z1-sin(z1),z2-cos(z2))))\n");
printf(ExprF7Z.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF7Z_std,FuncF7Z);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");




printf("\n");
printf("*********************  mixed  functions with constant subexpressions   ***********************************************\n");
printf("\n");
//printf("ai*cos(sin(ci*pow(ai/ci,ci/(ai-bi*ci))/(bi-ci))*z1/cos(ai/exp(ci/bi)*z2+bi/pow(ai-bi,ai/(ci*sin(ai*bi/ci)))))*pow(sin(ai*bi/(ai-ci))+cos(ci/(ai/bi-bi/ci)),z1/z2)\n");
printf(ExprF8CZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
TestEvalCmpZ_std(GccF8CZ_std,FuncF8CZ);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");


GNC = GNCt;


printf("*********************   External functions  ***********************************************\n");
printf("\n");
//printf("sp3(z1-sp3(z1*y,-t*z2,z3+z1),x*sp2(x+y,sp1(0.57*y)),sp2(z1+x,y-z2)-z2)*sp3(sp2(x-y,sp1(x*1.15)),z2-sp2(z1-z3,z2*x),-sp3(sp2(x*y,y+t)*x,2.1*x-y,y*sp2(2.15*y,1.17*t)))");
printf(ExprFE13ASPZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
//TestEvalCmpFEZ(GccFE13AZ,FuncFE13ASPZ);
TestEvalCmpFEZ_std(GccFE13AZ,GccFE13AZ_std,FuncFE13ASPZ);
printf("other call type: sp->ps\n");
TestEvalFZ(FuncFE13APSZ);
printf("other call type: sp->ms\n");
TestEvalFZ(FuncFE13AMSZ);
printf("other call type: sp->pc\n");
TestEvalFZ(FuncFE13APCZ);
printf("\n");
printf("*******************************************************************************\n");
printf("\n");




printf("\n");
printf("*********************   External functions  ***********************************************\n");
printf("\n");
//printf("sp3(z1*x,sp2(z1+z3,x-z2)-sp2(sp2(z1+z2,t+y)-z2,sp3(z1+y,z3*1.25,-z2)*sp2(x+y,z1-z2)),z3-z1*sp2(z3*x,-y*z1))*sp2(-sp2(x*t,-y*x),sp1(z2+z3)*sp1(x-t))-sp3(1.75*x,y-t,y-t*x)*sp2(z1-z2*sp2(z2-t,t+z3),sp1(z3-z2)*x-z2)*sp2(-sp2(z3+y,x+z2),z2-z3)\n");
printf(ExprFE13SPZ.c_str());
printf("\n");

printf("********************************** RUN ****************************************\n");

   //TestEvalCmpFEZ(GccFE13Z,FuncFE13SPZ);
   TestEvalCmpFEZ_std(GccFE13Z,GccFE13Z_std,FuncFE13SPZ);
   printf("other call type: sp->ps\n");
   TestEvalFZ(FuncFE13PSZ);
   printf("other call type: sp->ms\n");
   TestEvalFZ(FuncFE13MSZ);
   printf("other call type: sp->pc\n");
   TestEvalFZ(FuncFE13PCZ);

printf("\n");
printf("*******************************************************************************\n");






printf("\n");
printf("*********************   External functions  with arrays ***********************************************\n");
printf("\n");
//printf("sp8(ve,j+3,z1-sp8(ve,n+2,z2-sp8(ve,k+3,z1-z2,vd,j+n,z2-sp8(ve,k+n,t*z1-y,vd,j+n,z2-z3,vi,j+2),vi,j+2),vd,k+2,t*(z1+z2),vi,n+2*j),vd,j+n,z3-sp8(ve,n*3+1,-z3*x,vd,j+n-1,-z1*1.15,vi,k+2*n-1)/sp8(ve,j,z3+x/sp8(ve,k+n+2,z1*y+sp8(ve,n*4-2,z3-z1*2.73,vd,j+n+1,y*z3,vi,k+5),vd,n+3,z1*t+z3/sp8(ve,j+k,z2*1.17-z3,vd,j+k*2,z3*y-2.1,vi,n+k+3*j),vi,k+j*2-1),vd,j-1,z1+z3*2.12,vi,n+2*k),vi,n+2)");
printf(ExprFE13BSPZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
   //TestEvalCmpFEZ(GccFE13BZ,FuncFE13BSPZ);
   TestEvalCmpFEZ_std(GccFE13BZ,GccFE13BZ_std,FuncFE13BSPZ);
   printf("other call type: sp->ps\n");
   TestEvalFZ(FuncFE13BPSZ);
   printf("other call type: sp->pc\n");
   TestEvalFZ(FuncFE13BPCZ);


printf("*******************************************************************************\n");
printf("\n");


printf("*********************   External functions  with constant subexpressions ***********************************************\n");
printf("\n");
//printf("sp2(sp3(ai-bi,bi/ci,ci/(bi-ai))*ai/sp2(sp2(bi/sp1(ai/(bi+ci)),bi/(ci+ai)),ai-bi*ci)*z1/bi,z2/sp2(ai*sp1(ci/bi),ai/(bi+ai)))*sp3((ci-ai)*sp1(ci/bi)/sp2(bi/(ci+ai/bi),bi/(ci-ai))*z2/sp1(ci/ai),sp1(ci/bi)/sp1(bi/ai),z2/sp2(bi-ci/ai,ci-bi/ci))*sp2(-ai/(ci+bi/ai),z1/(ai-bi))");
printf(ExprFE15SPZC.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
   TestEvalCmpFEZ_std(GccFE15ZC,GccFE15ZC_std,FuncFE15SPZC);
   printf("other call type: sp->ps\n");
   TestEvalFZ(FuncFE15PSZC);
   printf("other call type: sp->ms\n");
   TestEvalFZ(FuncFE15MSZC);
   printf("other call type: sp->pc\n");
   TestEvalFZ(FuncFE15PCZC);

printf("*******************************************************************************\n");
printf("\n");





printf("*********************   External functions with all type of variables  ***********************************************\n");
printf("\n");
//printf("all(ve,n+3,all(ve,n+1,z1/z2,vd,j+k-1,x,z2/all(ve,j+3,z3-all(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/all(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-all(ve,k+3,z1/all(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*all(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)\n");
printf(ExprFE14SPZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");
   //TestEvalCmpFEZ(GccFE14Z,FuncFE14SPZ);
   TestEvalCmpFEZ_std(GccFE14Z,GccFE14Z_std,FuncFE14SPZ);
   printf("other call type: sp->ps\n");
   TestEvalFZ(FuncFE14PSZ);
   printf("other call type: sp->ms\n");
   TestEvalFZ(FuncFE14MSZ);
   printf("other call type: sp->pc\n");
   TestEvalFZ(FuncFE14PCZ);
   printf("\n");

printf("*******************************************************************************\n");
printf("\n");





printf("*********************   external functions with common subexpressions  ***********************************************\n");
printf("\n");
//printf("(sp3(z1/z2-sp2(z1-z2,z1/z2),z1/sp2(z1-z2,z1/z2),sp1(z1/z2)*sp1(-sp1(z2/z1)))*sp1(z1/z2)-sp2(z2/sp2(z1-z2,z1/z2),-z1/sp2(z1-z2,z1/z2))*sp1(-sp1(z2/z1)))/(sp1(z1/z2-sp2(z1-z2,z1/z2))-sp2(z1/sp2(z1-z2,z1/z2),z2/sp2(z1-z2,z1/z2))+sp2(z1-z2,z1/z2)*sp3(z1/z2-sp2(z1-z2,z1/z2),z1/sp2(z1-z2,z1/z2),sp1(z1/z2)*sp1(-sp1(z2/z1))))\n");
printf(ExprFE15SPZ.c_str());
printf("\n");
printf("********************************** RUN ****************************************\n");

   //TestEvalCmpFEZ(GccFE15Z,FuncFE15SPZ);
   TestEvalCmpFEZ_std(GccFE15Z,GccFE15Z_std,FuncFE15SPZ);
   printf("other call type: sp->ps\n");
   TestEvalFZ(FuncFE15PSZ);
   printf("other call type: sp->ms\n");
   TestEvalFZ(FuncFE15MSZ);
   printf("other call type: sp->pc\n");
   TestEvalFZ(FuncFE15PCZ);


printf("\n");
printf("*******************************************************************************\n");
printf("\n");

printf("******************************  END  *************************************************\n");
printf("\n");
printf("\n");


};




TComplexNum GccFuncZ()
{
     TComplexNum  rez;

       // rez = z1+z2*z3-z2;
 //     rez =  z2*(z1-(z3-z2+z1)*(z3*z2-z2*z1+z1*z3))+z1*z2-z2*(z1+z2-z3)*z2;
//      rez =  z3*(z1*z3-z2*(z1-z2+z3*z1)-z2*z3)-z1*z2;
//      rez =  z1/z2-z3/(z1+z2)+(z1-z3)/z2;
//      rez =  (y*(z1-z2+z3)-t*z3+(x-t)*(z3*z2*y-z1))*(z1*x-y*z2)*(z2-t+z3*(x+y));
//      rez =  z2*(z1-(z3-z2+z1)*(z3*z2-z2*z1+z1*z3))+z1*z2-z2*(z1+z2-z3)*z2-(z1*(z3+z2)*z3-(z3*z1-z3-z1))*z1;

//      rez =  z1*z2*z3*(z3*z1*(z1*z2-z3*z1)-z1*z2*(z1*z3-z2*z3)+z2*z1*(z2*z1-z3*z2)-(z1+z2)*(z1-z2)*(z3-z2)*(z1*z2-z3*z1*(z1-z2*(z3-z1*(z3-z1)*(z1-z3)*(z3-z2)-z1*z2-z2))))-(z1*z3*z2*(z1*z2-z1*(z2-z2*(z3-z3*(z1-z1*z3*(z1*z2-z3*z1-(z1*z2-z3*z1)*(z1-z2)*(z2-z3)*(z3-z2)-(z1+z3*z2)*(z2-z1*z3)+(z3-z2*z3)*(z2-z3*z1))))))) ;
//      rez = -z1/(z1/z2-z3/(z1+z3)+z1*z2*(z1*z2-z2*z3+z1/(z1/(z1+z2)+z2/(z3+z1))))*(z2*(z1-z2/(z1*z2-z2/(z1*z2+z2*z3)*(z2*z3-z1*z2)))+z1-z2*(z1-z3-z3/(z1-z2)*(z2/(z2-z3*(z1+z2*z3)*(z2-z1*z3)/(z1*z3-z2*(z1+z3))))))*(z1*z2-z3*z2-z3*(z1*z3-z2*(z3-z1)/(z1*z2*z3-z1-z2-z3)));
//      rez = z1*z2*(2.111*z1+1)*(2.211*z1*z2/z3-2.311*z1*(3.422*z3-1)/(2.511*z1-3.611*z2-4.22)*(z1/(3.711*z1-1)-4.111/z1+5.111*(2.611*z1*z2*z3-1.23)/(z2+1.12)-7.132*(2.812*z1*(z2+1.123)*(3.832*z2+2.121)*(3.112/(z1+1.123)-2.133*z3))));
//      rez = z1*z2*(z1-z3*(2.123*z1-3.222*z2-5.323)/(z3*z1*z2/(2.234-z1*z2)+(2.455*z1+3.632)*(3.734*z2-4.832*z3-5.923)-(1.134-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.745*z1-3.345*z2-z3))-z2*(z1*z2-z2*z3*3.167+2.965*(z1/z3-z3/(z1-z2*(2.467-z1-z2-z3)))*(z2-z3)-2.376*z1)*(z2-z1)-7.154/z1)*(-1.943/z3+z1*z2*z3*5.334))-3.556*z1-5.657)-7.243*z2-3.459)/(z1-z3)+z1*(z3*z2/(z1-2.834*z3)-z2*(z1*(z3-2.756*z2-z1-5.676))));
//      rez = (z1*z2+z3*(z1*z2-z2*z3*z1-z1+z2-z3))*(z1+z2+z3)*(z1-z2-z3)*(z3-z1*(z3-z2*(z1-z2-z3)))*z1*z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)*(z2*z1+z3*z1+z3*z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2*(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3)-z3*(-z1-z2*(-z3*(-z1*(z2-z3))))))))))));
//      rez = z1*z2-z1/(z1/z2-z3/z2-(-z1-z2*(z1*z2-z3*z1/(z1/z2-z3/z2-(-z1-(-z2-(-z3-(z1*z2-z2*(-z1*z2-z2/(z1+z2*z3)))*z1)*z2)/(z1+z2*z3)-z1*(z2/z3-(-z2*z1/(z1-z2*z3)-(-z1-(-z2/(-z1*z2*(-z1-z2))+z1/z2*(z2*z1+z2*z3-z1/(z1+z2*z3))-z1*z2*(z1*z2+(-z1*z2-z3/z2+z1-z2*z1)))))+z1*z2*z3*(z1+z2*z3)))))));
//      rez = z1*z2*(z1-z3*(2.154*z1-3.253*z2-5.353)/(z3*z1*z2/(2.544-z1*z2)+(2.143*z1+3.556)*(3.343*z2-4.153*z3-5.456)-(1.153-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.644*z1-3.364*z2-z3))-z2*(z1*z2-z2*z3*3.164+2.267*(z1/z3-z3/(z1-z2*(2.533-z1-z2-z3)))*(z2-z3)-2.453*z1)*(z2-z1)-7.535/z1)*(-1.253/z3+z1*z2*z3*5.353))-3.433*z1-5.455)-7.466*z2-3.577)/(z1-z3)+z1*(z3*z2/(z1-2.699*z3)-z2*(z1*(z3-2.767*z2-z1-5.854)-z2*(-1.549-z1/(-z3-z2))/(z1/z2-z1/(z3/z1-z2/z3)+z3*(1/z1-5.344/z2-z1*z2*(2.435*z1-1.456)*(z3*z2*3.326-5.347)*(1.943-z1*z2*z3*3.245)*(z1+z2))))));
//      rez = (z1*z2+z3*(z1*z2-z2*z3*z1-z1+z2-z3))*(z1+z2+z3)*(z1-z2-z3)*(z3-z1*(z3-z2*(z1-z2-z3)))*z1*z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)*(z2*z1+z3*z1+z3*z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2*(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3*(z1-z2*(z3-z1*z2-z2*(z1*z2-z3*z1)-z3*(z3*z1+z2))))-z3*(-z1-z2*(-z3*(-z1*(z2-z3*(z1*z2*z3-z2*z1*z3*(-z1*(z2*z1-z3*z2-z1-z2-z3)))))))))))))));
//      rez = (z1*z2+z3/(z1*z2-z2*z3/z1-z1+z2-z3))*(z1+z2+z3)/(z1-z2-z3)*(z3-z1*(z3-z2/(z1-z2-z3)))*z1/z2*z3-z1*z3*(z1*z3-z2*z3+z1-z3)/(z2*z1+z3*z1+z3/z2-z2-z1)*(z1*z3-z2*(z1-z2*z3-z3-z1)*(z1-z2-z3)-z2*(z2+z2*z1-z3-z1)+z3*(z1*z2-z1*(z3+z2/(z1*z2-z3*z2*z1-z2*z3*(z2+z1*(z1-z3+z2*(z1-z2+z3-z1*(z1*z2-z3*z1)*(z1*z2-z3*(z1+z2+z3)*(z1-z2-z3/(z1-z2*(z3-z1*z2-z2/(z1*z2-z3*z1)-z3/(z3/z1+z2))))-z3*(-z1-z2*(-z3/(-z1*(z2-z3*(z1*z2/z3-z2*z1*z3/(-z1*(z2*z1-z3*z2-z1-z2-z3)))))))))))))));
//      rez = z1*z2*(z1-z3*(2.156*z1-3.652*z2-5.653)/(z3*z1*z2/(2.664-z1*z2)+(2.155*z1+3.543)*(3.345*z2-4.431*z3-5.443)-(1.451-z1)/(-z3-z2))+z1*(z2-(-z1-(-z2/(-z3*z1*(z1*z2*z3*(2.453*z1-3.353*z2-z3))-z2*(z1*z2-z2*z3*3.153+2.253*(z1/z3-z3/(z1-z2*(2.533-z1-z2-z3)))*(z2-z3)-2.453*z1)*(z2-z1)-7.553/z1)*(-1.253/z3+z1*z2*z3*5.533))-3.453*z1-5.453)-7.453*z2-3.553)/(z1-z3)+z1*(z3*z2/(z1-2.653*z3)-z2*(z1*(z3-2.753*z2-z1-5.853)-z2*(-1.539-z1/(-z3-z2))/(z1/z2-z1/(z3/z1-z2/z3)+z3*(1/z1-5.553/z2-z1*z2*(2.535*z1-1.53)*(z3*z2*3.536-5.753)*(1.539-z1*z2*z3*3.665)*(z1+z2*(z3-(-z1-z2*z3/(z1*z2-2.863*(z1*z2*(z1-z2*(z1*z3+z2/z3*(2.623*z1-1.352-z3*z2))))))))))))) ;
//      rez = z1*z2*(2.251*z1+1)*(2.243*z1*z2/z3-2.353*z1*(3.475*z3-1)/(2.575*z1-3.675*z2-4.766)*(z1/(3.767*z1-1)-4.176/z1+5.186*(2.866*z1*z2*z3-1.766)/(z2+1.876)-7.165*(2.874*z1*(z2+1.641)*(3.864*z2+2.162)*(3.171/(z1+1.765)-2.173*z3/(2.174*z1*z2*z3-1.171)+(4.171*z1-1.164)*(5.172*z2-7.174)/(z1-2.175*z2-1.747-2.174*z3/(3.618-7.716*z1-8.181*z2*(4.612*z1/(2.189*z3+1.165)-7.198*z1-8.149/z3+9.912*(2.199*z1-1.261)*(3.107*z1+4.179*z2+5.108)*(2.271*z1*z2*z3-7.179)*z1*z2*z3/(z1-z2*2.282-3.621/(z1/(z3-1.147)-7.198/(z2+2.245)+8.233/(2.288*z1*z2*z3+1.247)-9.174)))))/(z1-1.525)))));

//sp3(z1,sp2(z1+z3,x-z2)-sp2(sp2(z1+z2,t+y)-z2,sp3(z1,z3,-z2)*sp2(x+y,z1-z2)),z3-z1*sp2(z3*x,-y*z1))*sp2(-sp2(x*t,-y*x),sp1(z2+z3)*sp1(x-t))
//  	rez = sp3(z1*sp2(sp1(z2-z1),sp2(z1-sp2(z3*z1,z1-z2),sp2(z3*z1,z2+z3))),sp1(z3-z2)+sp2(sp3(sp2(z1*z3,z2*z1),z3,sp2(z3-z1,z2-z1)),sp3(sp3(z1-z2,z2*z1,z2*z3),z1*sp2(z1-z2,z2-z3),z3*sp1(z1+z2))),sp3(sp1(z3+z1),sp2(z1-z2,z2*z3),sp1(z1+z2+z3)));
		 //  ps3(z1*ps2(ps1(z2-z1),ps2(z1-ps2(z3*z1,z1-z2),ps2(z3*z1,z2+z3))),ps1(z3-z2)+ps2(ps3(ps2(z1*z3,z2*z1),z3,ps2(z3-z1,z2-z1)),ps3(ps3(z1-z2,z2*z1,z2*z3),z1*ps2(z1-z2,z2-z3),z3*ps1(z1+z2))),ps3(ps1(z3+z1),ps2(z1-z2,z2*z3),ps1(z1+z2+z3)));
		 //  ms3(z1*ms2(ms1(z2-z1),ms2(z1-ms2(z3*z1,z1-z2),ms2(z3*z1,z2+z3))),ms1(z3-z2)+ms2(ms3(ms2(z1*z3,z2*z1),z3,ms2(z3-z1,z2-z1)),ms3(ms3(z1-z2,z2*z1,z2*z3),z1*ms2(z1-z2,z2-z3),z3*ms1(z1+z2))),ms3(ms1(z3+z1),ms2(z1-z2,z2*z3),ms1(z1+z2+z3)));
		 //  pc3(z1*pc2(pc1(z2-z1),pc2(z1-pc2(z3*z1,z1-z2),pc2(z3*z1,z2+z3))),pc1(z3-z2)+pc2(pc3(pc2(z1*z3,z2*z1),z3,pc2(z3-z1,z2-z1)),pc3(pc3(z1-z2,z2*z1,z2*z3),z1*pc2(z1-z2,z2-z3),z3*pc1(z1+z2))),pc3(pc1(z3+z1),pc2(z1-z2,z2*z3),pc1(z1+z2+z3)));

     //rez = spall(ve,n,z1,vd,n,x,z2,y,vi,k);

	 //rez = spall(ve,n+3,spall(ve,n+1,z1/z2,vd,j+k-1,x,z2/spall(ve,j+3,z3-spall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/spall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-spall(ve,k+3,z1/spall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*spall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j);
	      // pcall(ve,n+3,pcall(ve,n+1,z1/z2,vd,j+k-1,x,z2/pcall(ve,j+3,z3-pcall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/pcall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-pcall(ve,k+3,z1/pcall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*pcall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)
	      // msall(ve,n+3,msall(ve,n+1,z1/z2,vd,j+k-1,x,z2/msall(ve,j+3,z3-msall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/msall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-msall(ve,k+3,z1/msall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*msall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j)

    //rez = sp3(sp2(sp3(z1,z2,z3-sp2(sp2(z1,z3),sp2(t,z2))),sp2(z2-z3,x*z1)),sp3(sp2(z2,t),sp2(y,z3),sp3(x,y,t)*sp3(z3,z1,z2)),sp3(z1-sp1(z2),z2-sp2(x*y,-z2),z3-sp2(z2-z1,x*y)));
		 // ps3(ps2(ps3(z1,z2,z3-ps2(ps2(z1,z3),ps2(t,z2))),ps2(z2-z3,x*z1)),ps3(ps2(z2,t),ps2(y,z3),ps3(x,y,t)*ps3(z3,z1,z2)),ps3(z1-ps1(z2),z2-ps2(x*y,-z2),z3-ps2(z2-z1,x*y)))
		 // ms3(ms2(ms3(z1,z2,z3-ms2(ms2(z1,z3),ms2(t,z2))),ms2(z2-z3,x*z1)),ms3(ms2(z2,t),ms2(y,z3),ms3(x,y,t)*ms3(z3,z1,z2)),ms3(z1-ms1(z2),z2-ms2(x*y,-z2),z3-ms2(z2-z1,x*y)))
		 // pc3(pc2(pc3(z1,z2,z3-pc2(pc2(z1,z3),pc2(t,z2))),pc2(z2-z3,x*z1)),pc3(pc2(z2,t),pc2(y,z3),pc3(x,y,t)*pc3(z3,z1,z2)),pc3(z1-pc1(z2),z2-pc2(x*y,-z2),z3-pc2(z2-z1,x*y)))


	// rez = (z1/z2*z3/(z1.re-z2.im*(x-i))*(-z1/(-z2-i/(-x+y*i)))/(y/(z1/x-y/z2)+z2.re/(i-z1.im)))*(-i-3.5-i*x*(-z1-z2.im*(-z1.im*i-t/(-i)*(2.5/z1*i/t-i/(-i+x/z2)))));
	 //rez = (z1.re*t-i*x*(z2.im-z1.re/(i-1.5)-i/(-i-3.5/z2-z1*(x*z3.re-t/z2)*(z2.re/z1.im-z3.re/i)+(i*2.5+1.7*z3)*(i*z1+z3/i-z3.re*z1.im*(x-z1-i))+10.5*(i*2.5+5.7))));


		//rez=z1*z2-(-y/x-i-3.6-z1+z2)*7.3;
	   //rez=z1/x;
	  // rez=2*z1*z2-i*x;
	// rez=  z1*z2-z3*(z1-z2-z1*(z2+z3-z1));
		  //rez=x+y+i0;
		  //rez=z1+z2;
	   //rez=-(-(-(-(-(-z1-(-z2-(x-(-2.5-z1-(-(-(-x-z1-(-3.2-i)-i-(-i-4.5))))-i*(-z1-3.7*i-y/i))))-9.5-(-3.5-z2/i)))-i-(-z1/(-i)-(-z2/(-x))))));
	   //rez=sp1(z1*sp2(z2,z1/sp1(z2/x-y/z2)))/sp3(z1-x,sp2(-sp2(-x/i,i/y),-7.5-i/sp3(-z1,-z2/z1,z2*i)),sp1(x*z1-i)/x);
		//rez=Re(z1*sp1(z1)*sp3(z1,z2,z3*sp2(x,z2)-sp2(z3,y)))+i;
		 // rez=sp2(z1,z2)*sp2(x,y);
      //rez=-z1-z2.im*(i*z2.re-z1.im/(z1-i*z2.re*z1.im)-z1/(-1.5-2.7*i-i*(-2.5-x*i)/(x-z1.re-(z2.im*y-i)/i)));
	   //rez=(1.5*i-2.7)*(-3.2-i*(2.7-x-(-z2-i-(-z1.re-3.5-(-x/(z1-z2*i)-i/(x-z2.im-2.3*i)))))/(-i/x*z1-z2*y/i));
	  //rez=(x*z1-z2*y)*(-i-2.1-z1*(x+y*z2.im)+(-z1.re*x-3.2)*z2-z1*(-i-z1*x)-(y-z2*i)*z2*(z1-z2*y*i))/(-z1/(x*y-3.5/(x+y))+(x-y*z2.re*z1.im)/z2);


		//rez=(z1.re-i*(-2.2-z2.im*(-y-3.1*i-i/(x/i-i/z2))-z1*z2*i*x/(-x-2.5*i-z2.im*i)))*(z1*(-i-(y/z1-z2/x*i)/(1.7-i-z2))-z2/(x-i/y))/(-i*(-x/(-z2.im-3.1))+z2*i-4.5/i);
	   //rez=sp3(z1,z2,z3*sp3(z1-x,y-z3,z2-z1*z2))*sp2(sp1(sp2(sp1(z2),sp1(z1))),sp2(z3,z2));
	   //rez=sp3(sp2(z2,sp3(z1,z3,z2)),sp3(z2,sp3(sp3(z3,z2,sp3(z2,z1,z3)),z1,z2),z3),sp1(sp3(z1,sp3(z3,sp3(z2,z3,z1),z1),z3)));
	   rez=spall(ve,n+3,spall(ve,n+1,z1/z2,vd,j+k-1,x,z2/spall(ve,j+3,z3-spall(ve,n+9,z1-z3+z1,vd,k*j,x*t,z2*z3,y-t,vi,j+9),vd,k+7,x,z1-z2/spall(ve,n+3+j,z3/z1,vd,j+k+7,x,z2/z3,-y/t,vi,k+j+5),y/t,vi,j),t-y,vi,n+j),vd,j+k,x,z2-spall(ve,k+3,z1/spall(ve,n+3+k,z3*t,vd,j+k+9,x,z1-z3,t-y*x,vi,n+k+j),vd,k+3,x/t,z2*spall(ve,j+k+7,z1*y,vd,j+3*k,x,z2*y,y-x/y,vi,n+7*k),t/y,vi,k+n+7),t-y/t,vi,n+k+j);
	   //rez=spall(ve,n,z1,vd,n,x,z2,y,vi,k);
	   //rez=z1*sp2(i,x/i-z2*sp3(-x*sp1(z1-i),-3.796-i,x*(-i-z2-5.875))/5.145+sp2(-i-z2,-t-i/z2)/z1)/sp3(z1*sp1(y*i),-sp2(-z1/x,y/(z1/z2-i))/sp3(x*(z1-z2/i),-z3/z1,x/(-z3)),sp2(2.841-t*i,-z2/(-z3-i/(-x-z1)))*sp3(z1*sp1(t/i),x/i-i/y,2.5*z1-7.5/z2)/sp2(z2/x-y*z3/z2,-4.784/i-i/3.752));

	   //rez=-(-(-z1-(-z2-(-(-x-(-2.5-(-x-z1-(-3.2-i)-i-z2)))))));
		  //rez=sp1(x)*sp3(x,y,t)+i0;

 //return z1+z2*z3-z2;
 return rez;
};




void CalcExprF1_T1(Pointer32 Func, TComplex   &resCx)
{

  INT32 i,t1,t2;
  PTGccTestR ForevalFunc;
  PTProc     ForevalProc;


/*
        this construction dont't catch fpu exception !!?
  try
  {
     flResultCxEP(Func,&resCx);
  }
  catch(...)
  {
    //error
  }

*/

  /** Direct fast calculations without catch of errors!!  **/


  resCx.re = 0; resCx.im = 0;


   /**  Get type of returned result and call appropriate calculation procedure **/

   flGet(fl_RESULT_TYPE,INT32(Func),rt);

   if (rt == fl_NONE)           /// no return number: return result through global var.resf (named Result, ResultR, ResultCx)
   {                            /// (result = sum(vd))   ( zt: complexDbl=z1+z2; zt=zt*x; result=zt  )

     ForevalProc =  (PTProc)Func; /// call compiled Foreval expression as  procedure: proc()

     t1=GetTickCount();
     for(i=0; i <= GNC; i++)
     {
		 //flResult(Func);   //return result through Global var. resf (named Result, ResultR,ResultCx)

		 ForevalProc();     /// call compiled Foreval expression as proc(); runs some faster compared to flResult(Func)

		  //Result(Func);
     }
     t2=GetTickCount();

	     resCx.re=resf.re;
	     resCx.im=resf.im;
   }
   else
   {
	 if (rt == fl_REAL)  /// return only real result: Re(expr)
	 {

	   ForevalFunc =  (PTGccTestR)Func; /// call compiled Foreval expression as TFloatType func()

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {

          #ifdef   EXTENDED_FLOAT
               //flResultE(Func,resCx.re);
           #else
               //flResultD(Func,resCx.re);
          #endif
            /// or use the universal calculation function only for a real expression that returns a number:
		   //resCx.re=flResultR(Func);

        ///call compiled Foreval expression as TFloatType func(); runs some faster compared to flResultR(Func)/flResultE(Func,resCx.re)/flResultD(Func,resCx.re);
           resCx.re = ForevalFunc();


       }
       t2=GetTickCount();


	 }
	 else     ///  rt =  fl_Complex
	 {


        t1=GetTickCount();
        for(i=0; i <= GNC; i++)
        {

		   #ifdef   EXTENDED_FLOAT
               flResultCxEP(Func,&resCx);
               //flResultCxE(Func,resCx.re,resCx.im);
           #else
               flResultCxDP(Func,&resCx);
               //flResultCxD(Func,resCx.re,resCx.im);
          #endif

        }
        t2=GetTickCount();

     }

   }



   if (t1 == t2)
   {
       Perf=-1;
   }
   else
   {
      Perf=INT32(GNC/(t2-t1));
   }
}




void CalcExprF1U_T2(Pointer32 Func, TComplex   &resCx)
{

  INT32 i,t1,t2,CError,rt;
  PTProc     ForevalProc;



/*
        this construction dont't catch fpu exception !!?
  try
  {
     flResult(Func,&resCx);
  }
  catch(...)
  {
    //error
  }

*/

   /**
     Direct fast calculations without catch of errors!!

     Universal computational procedure. But need for this to set address returned variable through use field Attr (if expression returned numbers).
     Calculation expression in one  procedure, regardless of the output type of expression.
     Return result in global variable -resf.  May be returned in any var.
   **/

   resCx.re = 0; resCx.im = 0;

   flPerform(fl_FREE,(INT32)Func);  // Free the above compiled code to recompile in a different way by setting a global variable to storing the returned result (if present)


   Attr.MType = MType; Attr.AddrRE = &resf.re; Attr.AddrIM = &resf.im;  //return result through Global var. 'resf' (named Result, ResultR, ResultCx)
                                                                        // (Result = sum(vd))   ( zt: complexDbl=z1+z2; zt=zt*x; ResultCx=zt  )

   if (G_CompileDiffExpr == TRUE)
    { flCompileDiffExprATE( &Attr,Func,rt,CError);}
   else
   { flCompile(G_Expr.c_str(), &Attr, Func);};

   ForevalProc =  (PTProc)Func; /// call compiled Foreval expression as  procedure: proc()

   t1=GetTickCount();
     for(i=0; i <= GNC; i++)
     {
         //flResult(Func);
         ForevalProc();     /// call compiled Foreval expression as proc(); runs some faster compared to flResult(Func)


		  //Result(Func);
     }
    t2=GetTickCount();

    resCx.re=resf.re;
    resCx.im=resf.im;



   if (t1 == t2)
   {
       Perf=-1;
   }
   else
   {
      Perf=INT32(GNC/(t2-t1));
   }
}






void CalcExprS1_T3(Pointer32 Func, TComplex   &resCx)
{
  Extended res;
  TComplexD   resCxd;
  double resd;
  INT32 t1,t2,i;
  string SCE;

/*
        this construction dont't catch fpu exception !!?
  try
  {
     flResultCxEP(Func,&resCx);
  }
  catch(...)
  {
    //error
  }

*/


/**  Safe calculations with catch all exception: FPU & AccessViolation & StackOverflow.

     Run from Delphi block:

             try
                asm
                  call Func
                end
             except
               on Exception do:
               ...
             end;


     and return Error Code. But it works  slowly.

**/


   resCx.re = 0; resCx.im = 0;


   flGet(fl_RESULT_TYPE,INT32(Func),rt);
   if (rt == fl_NONE)       /// no return number or return result through global var.resf (named Result, ResultR, ResultCx)
   {

		  /**
		      res=sqrt(-x)
              res=x/sin(x-x)
		      x=10000; res=x^x
		   **/

        t1=GetTickCount();
        for(i=0; i<=GNC; i++)
        {
          FpuExc=flResultSafe(Func);
		  if (FpuExc != 0) { goto endc;}
        }
        t2=GetTickCount();
        resCx.re=resf.re;
        resCx.im=resf.im;
   }
   else
   {
	 if (rt == fl_REAL)  ///return only real result: Re(expr)
	 {
		   /**
		       sqrt(-x)
               x/sin(x-x)
		       x=10000; x^x
		   **/

        t1=GetTickCount();
        for(i=0; i<=GNC; i++)
        {

          #ifdef   EXTENDED_FLOAT
               FpuExc=flResultSafeE(Func,resCx.re);
           #else
               FpuExc=flResultSafeD(Func,resCx.re);
          #endif

		   if (FpuExc != 0) { goto endc;}
        }
        t2=GetTickCount();
        //resCx.re = resCxd.re;
	 }
	 else   ///rt = fl_Complex;
	 {


        t1=GetTickCount();
        for(i=0; i<=GNC; i++)
        {
		   #ifdef   EXTENDED_FLOAT
               //FpuExc=flResultSafeCxEP(Func,&resCx);  //don't work in GCC for unknown reason. Use this proc.:
               FpuExc=flResultSafeCxE(Func,resCx.re,resCx.im);
           #else
               FpuExc=flResultSafeCxDP(Func,&resCx);
               //FpuExc=flResultSafeCxD(Func,resCx.re,resCx.im);
          #endif

		   if (FpuExc != 0) { goto endc;}
        }
        t2=GetTickCount();
        //resCx.re = resCxd.re; resCx.im = resCxd.im;
     }

   }

   endc:
    if (FpuExc != 0)
      {
	    switch ( FpuExc)
        {
          case  fl_INVALID_OPERATION:           SCE="Invalid operation";break;          ///  sqrt(-x)
	      case  fl_ZERO_DIVIDE:                 SCE="Divizion on Zero";break;           ///  x/sin(x-x)
	      case  fl_OVERFLOW:                    SCE="Overflow in float point";break;    ///  (x*10000)^(x*10000)
          case  fl_ACCESS_VIOLATION:            SCE="Access violation";break;           ///  x*vd[k*100000000], x*vd[n-2*k]   //k > 0, n-2*k < 0
          case  fl_STACK_OVERFLOW:              SCE="Stack overflow";break;
          case  fl_COMMON_CALCULATON_ERROR:     SCE="Common error";break;               ///   All other errors

		 // default:    SCE="Invalid operation";break;
        }
	      cout << SCE << endl;
	      F_CalcError = TRUE;
      }


   if (t1 == t2)
   {
       Perf=-1;
   }
   else
   {
      Perf=INT32(GNC/(t2-t1));
   }
}





void CalcExprS1U_T4(Pointer32 Func, TComplex   &resCx)
{

  INT32 i,t1,t2,rt,CError;
  string SCE;


/*
        this construction dont't catch fpu exception !!?
  try
  {
     flResult(Func,&resCx);
  }
  catch(...)
  {
    //error
  }

*/

/**
     Universal computational procedure. But need for this to set address returned variable through use field Attr (if expression returned numbers).
     Calculation expression in one  procedure, regardless of the output type of expression.
     Return result in global variable - resf.  May be returned in any var.


     Safe calculations with catch all exception: FPU & AccessViolation & StackOverflow.

     Run from Delphi block:

             try
                asm
                  call Func
                end
             except
               on Exception do:
               ...
             end;


     and return Error Code. But it works  slowly.

**/





   resCx.re = 0; resCx.im = 0;

   flPerform(fl_FREE,(INT32)Func);  // Free the above compiled code to recompile in a different way by setting a global variable to storing the returned result (if present)

   Attr.MType = MType; Attr.AddrRE = &resf.re; Attr.AddrIM = &resf.im;  //return result through Global var. 'resf' (named Result, ResultR, ResultCx)
                                                                        // (Result = sum(vd))   ( zt: complexDbl=z1+z2; zt=zt*x; ResultCx=zt  )


   if (G_CompileDiffExpr == TRUE)
    { flCompileDiffExprATE( &Attr,Func,rt,CError);}
   else
   { flCompile(G_Expr.c_str(), &Attr, Func);};



   t1=GetTickCount();
     for(i=0; i <= GNC; i++)
     {
        FpuExc=flResultSafe(Func);
		  if (FpuExc != 0) { goto endc;}
     }
    t2=GetTickCount();

    resCx.re=resf.re;
    resCx.im=resf.im;


  endc:
    if (FpuExc != 0)
      {
	    switch ( FpuExc)
        {
          case  fl_INVALID_OPERATION:           SCE="Invalid operation";break;          ///  sqrt(-x)
	      case  fl_ZERO_DIVIDE:                 SCE="Divizion on Zero";break;           ///  x/sin(x-x)
	      case  fl_OVERFLOW:                    SCE="Overflow in float point";break;    /// (x*10000)^(x*10000)
          case  fl_ACCESS_VIOLATION:            SCE="Access violation";break;           ///  x*vd[k*100000000], x*vd[n-2*k]   //k > 0, n-2*k < 0
          case  fl_STACK_OVERFLOW:              SCE="Stack overflow";break;
          case  fl_COMMON_CALCULATON_ERROR:     SCE="Common error";break;               ///   All other errors

		 // default:    SCE="Invalid operation";break;
        }
	      cout << SCE << endl;
	      F_CalcError = TRUE;
      };


   if (t1 == t2)
   {
       Perf=-1;
   }
   else
   {
      Perf=INT32(GNC/(t2-t1));
   }

}





void CalcExprS2_T5(Pointer32 Func, TComplex   &resCx)
{

  INT32 i,t1,t2;
  string SCE;


/*
        this construction dont't catch fpu exception !!?
  try
  {
     flResultCxEP(Func,&resCx);
  }
  catch(...)
  {
    //error
  }

*/


 /**
     Safe calculations, but with catch only  FPU exception!!! (no AccessViolation or StackOverflow !!!)
     Mask  exceptions of FPU. Read exception flag of FPU - FPUError after each step of calculations.
     Exception flag of FPU - FPUError install by flSetExtAddrErrorFPU(&FPUError) in onLoad;
     Work more fast, than CalcExprS1_T3 (with catch all exception), especially, it is necessary to handle exceptions without interrupting calculations.
**/


   resCx.re = 0; resCx.im = 0;



   flMaskFPUException(); //= flPerform(fl_MASK_FPU_EXCEPTION,0);
   FPUError = 0; //var. for returns error code


   flGet(fl_RESULT_TYPE,INT32(Func),rt);


   if (rt == fl_NONE)            /// no return number: return result through global var.resf (named Result, ResultR, ResultCx)
   {
     t1=GetTickCount();
     for(i=0; i <= GNC; i++)
     {

         flResultMaskedFPU(Func);
         if (FPUError != 0){goto endc;};   /// if error
     }
     t2=GetTickCount();

	     resCx.re=resf.re;
	     resCx.im=resf.im;
   }
   else
   {

	 if (rt == fl_REAL)  /// return only real result: Re(expr)
	 {

       t1=GetTickCount();
       for(i=0; i <= GNC; i++)
       {


             #ifdef   EXTENDED_FLOAT
                  flResultMaskedFpuE(Func,resCx.re);
              #else
                  flResultMaskedFpuD(Func,resCx.re);
             #endif

             if (FPUError != 0) {goto endc;};  /// if error

       }
       t2=GetTickCount();


	 }
	 else     ///  rt =  fl_Complex
	 {


        t1=GetTickCount();
        for(i=0; i <= GNC; i++)
        {

		   #ifdef   EXTENDED_FLOAT
               flResultMaskedFpuCxEP(Func,&resCx);
               //flResultMaskedFpuCxE(Func,resCx.re,resCx.im);
           #else
               flResultMaskedFpuCxDP(Func,&resCx);
               //flResultMaskedFpuCxD(Func,resCx.re,resCx.im);
          #endif

          if (FPUError != 0){goto endc;};  /// if error
        }
        t2=GetTickCount();


     }

   }



  endc:


     flResetMaskFPUException(); //= flPerform(fl_CLEAR_FPU_EXCEPTION,0);

	 if (FPUError != 0)
      {
	    switch ( FPUError)
        {
	      case  4:    SCE="Divizion on Zero";break;           ///  x/sin(x-x)
	      case  8:    SCE="Overflow in float point";break;    ///  (x*10000)^(x*10000)
		  default:    SCE="Invalid operation";break;          ///  sqrt(-x) and all other FPU errors
        }
	      cout << SCE << endl;
	      F_CalcError = TRUE;
      }

   if (t1 == t2)
   {
       Perf=-1;
   }
   else
   {
      Perf=INT32(GNC/(t2-t1));
   }
}





void CalcExprS2U_T6(Pointer32 Func, TComplex   &resCx)
{

  INT32 i,t1,t2,rt,CError;
  string SCE;


/*
        this construction dont't catch fpu exception !!?
  try
  {
     flResultCxEP(Func,&resCx);
  }
  catch(...)
  {
    //error
  }

*/


 /**

 /**
     Safe calculations, but with catch only  FPU exception!!! (no AccessViolation or StackOverflow !!!)
     Mask  exceptions of FPU. Read exception flag of FPU - FPUError after each step of calculations.
     Exception flag of FPU - FPUError install by flSetExtAddrErrorFPU(&FPUError) in onLoad;
     Work more fast, than CalcExprS1U_T4 (with catch all exception), especially, it is necessary to handle exceptions without interrupting calculations.

     Universal computational procedure. But need for this to set address returned variable through use field Attr (if expression returned numbers).
     Calculation expression in one  procedure, regardless of the output type of expression.
     Return result in global variable - resf.  May be returned in any var.
**/


   resCx.re = 0; resCx.im = 0;

   flPerform(fl_FREE,(INT32)Func);  // Free the above compiled code to recompile in a different way by setting a global variable to storing the returned result (if present)

   Attr.MType = MType; Attr.AddrRE = &resf.re; Attr.AddrIM = &resf.im;  //return result through Global var. 'resf' (named Result, ResultR, ResultCx)
                                                                        // (Result = sum(vd))   ( zt: complexDbl=z1+z2; zt=zt*x; ResultCx=zt  )

   if (G_CompileDiffExpr == TRUE)
    { flCompileDiffExprATE( &Attr,Func,rt,CError);}
   else
   { flCompile(G_Expr.c_str(), &Attr, Func);};


   //flPerform(fl_MASK_FPU_EXCEPTION,0);
   flMaskFPUException(); //= flPerform(fl_MASK_FPU_EXCEPTION,0);
   FPUError = 0; //var. for returns error code

   t1=GetTickCount();
     for(i=0; i <= GNC; i++)
     {
        flResultMaskedFPU(Func);
        if (FPUError != 0){goto endc;};   /// if error
     }
   t2=GetTickCount();

    resCx.re=resf.re;
    resCx.im=resf.im;

  endc:

     //flPerform(fl_CLEAR_FPU_EXCEPTION,0);
     flResetMaskFPUException(); //= flPerform(fl_CLEAR_FPU_EXCEPTION,0);

	 if (FPUError != 0)
      {
	    switch ( FPUError)
        {
	      case  4:    SCE="Divizion on Zero";break;           ///  x/sin(x-x)
	      case  8:    SCE="Overflow in float point";break;    ///  (x*10000)^(x*10000)
		  default:    SCE="Invalid operation";break;          ///  sqrt(-x) and all other FPU errors
        }
	      cout << SCE << endl;
	      F_CalcError = TRUE;
      }

   if (t1 == t2)
   {
       Perf=-1;
   }
   else
   {
      Perf=INT32(GNC/(t2-t1));
   }
}









void test()
{
    int          flLoad,ECode,NC,ni,SZ,i,t1,t2;
	string       Expr,strOut,strTmp,SRes,S1r,S2r;
	std::string  StrDiff;

	TStringType chE,chTmp;
	char cht;

	PInteger     pint1;
    Int32        adrVE0;

	int ndx,SafeCalc,GNCmin,GNCmax,GNCd;
	//AnsiChar* chS = new char;
    double resd;
    //Extended res;

	Pointer32 Func,FuncDx,PS;
	TComplexD    resCxd;
    TComplex     resCx;
	TComplexNum  res;
	_int32       TypeCalcProc,PDiffPoly;
	boolean      NumericDiff;



/*
        this construction dont't catch fpu exception !!?
  try
  {
    flResultCxEP(Func,&resCx);
  }
  catch(...)
  {
    //error
  }

*/

/**
Calculations goes with masking of interruptions to (1) CalcExpr(Func); (2) CalcExprSafe(Func);
It is a slow method. Besides, if in expression there is incorrectly written function,
 in which there is a reset of FPU masks and/or flags of exceptions, interception of an error will not work.
It is better to use catch of errors  through  interrupts in the design:

 try
  {
    flResultCxEP(Func,&resCx);
  }
  catch(...)
  {
    //error
  };

,if you are able to force it to work! :(
**/

 flLoad=onLoad();


 if (flLoad != 0)
 {



 GNCmin = 1000000;
 GNCmax = 2000000000;
 GNCd =   100000000;//default


//(x*y*(-x*t-y*t*(-x*y*t+x*t*((x/y-y/t)/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x))))
//(x*y*(-x*t-y*t*(-x*y*t+x*t*((x/y-y/t+y*t/(x/t-x*y*(x*t-y)))/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x)+x*y/(x/y+y/t)+y*t/(x*t/(x*y+t)-x*y*(x*t-y)))))
//(x*y*(-x*t-y*t*(-x*y*t+x*t*((x/y-y/t+y*t/(x/t-x*y*(x*t-y)))/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x)+x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+y*t/(x*t/(x*y+t)-x*y*(x*t-y)))))

//(x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+((y/t-x*y*t/(x/y-y/t))*(x/y-x*y*t/((x*y+t)*(y*t-x)-y*t/(x*t-y)))*(y*t/(x/t-x*y*(x*t-y))))/((x/t-x/(y*t-x))*(x/y-y/t+y*t/(x/t-x*y*(x*t-y)))*(y*t/(x*t/(x*y+t)-x*y*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))))
//((x*y*(-x*t-y*t*(-x*y*t+x*t*((x/y-y/t+y*t/(x/t-x*y*(x*t-y)))/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x)+x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+y*t/(x*t/(x*y+t)-x*y*(x*t-y))))))/(x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+((y/t-x*y*t/(x/y-y/t))*(x/y-x*y*t/((x*y+t)*(y*t-x)-y*t/(x*t-y)))*(y*t/(x/t-x*y*(x*t-y))))/((x/t-x/(y*t-x))*(x/y-y/t+y*t/(x/t-x*y*(x*t-y)))*(y*t/(x*t/(x*y+t)-x*y*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))))

//((x*y*(x*t+y*t*(-x*y*t+x*t*((x/y-y/t+y*t/(x/t-x*y*(x*t-y)))/(x/t-x/(y*t-x))-x*t/(x*y+t))+x*y/(y*t-x))-y*t/(x*t-y))-x*t*((x*y+t)*(y*t-x)+x*y*t*(x/y-x/(y*t-x)+x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+y*t/(x*t/(x*y+t)-x*y*(x*t-y))))))/(x*y/(x/y+y/t+x/((x*y+t)*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))+((y/t-x*y*t/(x/y-y/t))*(x/y-x*y*t/((x*y+t)*(y*t-x)-y*t/(x*t-y)))*(y*t/(x/t-x*y*(x*t-y))))/((x/t-x/(y*t-x))*(x/y-y/t+y*t/(x/t-x*y*(x*t-y)))*(y*t/(x*t/(x*y+t)-x*y*(x*t-y))-y/(x*y*(x*t-y)-y*t/(x*t-y)))))


///************************************** Compare Test: Foreval vs GCC **********************************************************************************************************

/**
  Performance comparisons are performed by calculating the sum of the expression in a loop while modifying the variables included in the expression.
  The increment of variables is specified as a dependence on the entered number of loops (GNC), so that the optimizer does not throw the expression out of the loop.
**/


///*********************************************  Test Real ******************************************************************
askbenchtest:
    RefReshVar();
    RefReshArrays();
    GNC = GNCd;

    fflush(stdin);
    printf("Run a benchmark test  Foreval vs Gcc (real expression)?, Y/N  [N - goto test with complex expression] ");
    cout <<  "" << endl;
    cht=getchar();
    //scanf("%d", &GNC);
    if(tolower(cht) == 'n')
        goto askcxbenchtest;
    else  if(tolower(cht) != 'y')
        goto askbenchtest;


        cout <<  "" << endl;
        cout <<  "Test real expressions" << endl;
        cout <<  "" << endl;
        //cout <<  "Compile real expressions..." << endl;
          printf("Compile real expressions...");
        //cout <<  "" << endl;

        CompileTestR();

        //cout <<  "OK" << endl;
        printf("OK");
        cout <<  "" << endl;
        printf("\n");
        printf("Each example is calculation in loop with changed of variables\n");
        printf("Number of loops for the accuracy of the comparison should be such that each expression is calculated for at least 10 seconds ");
        printf("Enter number of loops: 1E6 - 2E9. On default(Enter) = 1E8: ");
        fflush(stdin);
        //cht=getchar();
        //scanf("%s", Schr);
        getline(cin,strTmp);
        if(strTmp == "\0")
            {GNC = GNCd;}
            else
            {
                GNC = StrToInt(strTmp);
                if(GNC < GNCmin){GNC = GNCmin;} else if(GNC > GNCmax){GNC = GNCmax;} ;
            };

        CompareTestR();




///*********************************************  Test Complex ******************************************************************
askcxbenchtest:
      cout <<  "" << endl;
      cout <<  "" << endl;


       RefReshVar();
       RefReshArrays();
       GNC = GNCd;

       fflush(stdin);
       printf("Run a benchmark test  Foreval vs Gcc (complex expression)?, Y/N  [N - goto test with entered expression] ");
       cout <<  "" << endl;
       cht=getchar();

       if(tolower(cht) == 'n')
         goto beginexprtest;
       else  if(tolower(cht) != 'y')
        goto askcxbenchtest;

        cout <<  "" << endl;
        cout <<  "Test complex expressions" << endl;
        cout <<  "GCC OVRL - calculation through determining the type of complex numbers and overloading arithmetic operators for them. " << endl;
        cout <<  "GCC STD  - calculation using the built-in class std::complex. " << endl;
        cout <<  "" << endl;
        //cout <<  "Compile complex expressions..." << endl;
        //cout <<  "" << endl;
        printf("Compile complex expressions...");

        CompileTestZ();

        printf("OK");
        //cout <<  "OK" << endl;
        cout <<  "" << endl;

        printf("Each example is calculation in loop with changed of variables\n");
        printf("Number of loops for the accuracy of the comparison should be such that each expression is calculated for at least 10 seconds ");
        printf("Enter number of loops: 1E6 - 2E9. On default(Enter) = 1E8: ");
        fflush(stdin);
        //cht=getchar();
        //scanf("%s", Schr);
        getline(cin,strTmp);
        if(strTmp == "\0")
            {GNC = GNCd;}
            else
            {
                GNC = StrToInt(strTmp);
                if(GNC < GNCmin){GNC = GNCmin;} else if(GNC > GNCmax){GNC = GNCmax;} ;
            };
        //scanf("%d", &GNC);
        CompareTestZ();


        goto askbenchtest;





///*********************************************  End Compare Test ****************************************************************************************************









//---------------------------------------------------------------------------------------------------------
                /**!!!!! WITH  OVERLOAD COMPLEX OPERATIONS  !!!!! **/

   #ifdef   OVERLOADCOMPLEX
   printf("  \n");
   printf(" OVERLOADCOMPLEX GCC \n");
   t1=GetTickCount();
   for(i=0; i <= GNC; i++)
   {
      res=GccFunc();
   }

   t2=GetTickCount();
   if (t1 == t2)
   {
       PerfG=0;
   }
   else
   {
      PerfG=INT32(GNC/(t2-t1));
   }
   //S1r=FloatToStr(res.re);
   //S2r=FloatToStr(res.im);
   //SRes=S1r+"  "+S2r+"i";
   //cout << SRes << endl;
   printf("Result Gcc :  %.12e", (double)(res.re)); printf(" "); printf("%.12e",  (double)(res.im)); printf("i\n");
   printf("perfomance  Gcc, Expr/ms:  %5d\n", PerfG);

   #endif
//--------------------------------------------------------------------------------------------------------------------------------------------------------








///*********************************************   Test of entered expression  ****************************************************************************************************


 /**
          **** There are 6 ways of calculations ***********************

           ***** two ways of fast calculations *****
              CalcExprF1_T1(Func,resCx);     (1)
              CalcExprF1U_T2(Func,resCx);    (2)

           ***** four ways of safe calculations (work slow,  but with interception of error) *****
             -- catch all errors: --
              CalcExprS1_T3(Func,resCx);     (3)
              CalcExprS1U_T4(Func,resCx);    (4)

             -- catch only FPU errors: --
              CalcExprS2_T5(Func,resCx);     (5)
              CalcExprS2U_T6(Func,resCx);    (6)

**/



beginexprtest:

 flSet(fl_DISABLE, fl_SHOW_EXCEPTION,0); /// show exception message from Foreval.dll
  //flSet(fl_ENABLE, fl_SHOW_EXCEPTION,0);



cout <<  "" << endl;
cout <<  "***********************************************" << endl;
cout <<  "" << endl;
cout <<  "     Test entered expression" << endl;
cout <<  "" << endl;
cout <<  "-----------------------------------------------" << endl;
cout <<  "" << endl;


TypeCalcProc =  4;  /// = 1,2,3,4,5,6


/** ------------Enter Type of Evaluation----------------------------- **/
askTypeCalc:
      cout <<  "" << endl;


       GNC = GNCd;

       fflush(stdin);
       printf("Enter type of evaluation command\n");
       printf(" 2 -  Fast procedure of calculation  without catching exceptions\n");
       printf(" 4 -  Slow universal procedure for calculating with catch of ANY exception after each computation\n");


       cout <<  "" << endl;
       cht=getchar();

       if(tolower(cht) == '2')
         TypeCalcProc =  2;
       else
        if(tolower(cht) == '4')
         TypeCalcProc =  4;

  //TypeCalcProc =  6;

/** ---------------------------------------------- **/


switch (TypeCalcProc)
	{
	case 1:
		cout <<  "     1. Fast procedure of calculation  without catching exceptions" << endl;
		break;
	case 2:
		cout <<  "     2. Fast, universal procedure for calculating without catching exceptions with pass of the result through a global variable " << endl;
		break;
	case 3:
		cout <<  "     3. Slow procedure of calculations  with catch of ANY exception after each computation " << endl;
		break;
	case 4:
		cout <<  "     4. Slow universal procedure for calculating with catch of ANY exception after each computation and pass of the result through a global variable " << endl;
		break;
	case 5:
		cout <<  "     5. Slow  procedure for calculating with catch only of FPU exception after each computation and pass of the error code through a global variable " << endl;
		break;         //Works a little faster, then - 3,4. But works much faster, if rise exceptions in calculations
	case 6:
		cout <<  "     6. Slow universal procedure for calculating with catch only of FPU exception after each computation and pass of the error code through a global variable " << endl;
		break;         //Works a little faster, then - 3,4. But works much faster, if rise exceptions in calculations
	};
cout <<  "" << endl;
cout <<  "***********************************************" << endl;

exprtest:
    cout <<  "" << endl;
   // printf("**************************************************************************\n");
    cout <<  "" << endl;


    GNC=GNCd;
    RefReshVar();

    F_CalcError = FALSE;
    resCx.re = 0; resCx.im = 0;
    resf.re = 0;  resf.im = 0;



    printf("\n");
    printf("Enter number of loops: 1E6 - 2E9. On default(Enter) = 1E8: ");
    fflush(stdin);
    getline(cin,strTmp);
        if(strTmp == "\0")
            {GNC = GNCd;}
            else
            {
                GNC = StrToInt(strTmp);

                if(GNC < 1000) {GNC = 10;} ///Debug
                else
                {
                   if(GNC <  GNCmin){GNC = GNCmin;} else if(GNC > 2000000000){GNC = 2000000000;} ;
                }
            };
    fflush(stdin);
    printf("Input expression:\n");
	getline(cin, Expr);


    //goto _deriv;

    ///       *******         COMPILE AND EVAL  Expr   ***********   ///

    G_CompileDiffExpr = FALSE;
    G_Expr = Expr;
    flCompile(Expr.c_str(),0, Func);
    flGet(fl_RESULT_TYPE,INT32(Func),rt);
    //flGet(fl_RESULT_TYPE,0,rt);  //work only for  last compiled expression
	flGetErrorCode(ECode);

	if (ECode == 0)
    {
          //  resCx.re = flResultR(Func);

    /******* There are 6 ways of calculations ***********************/

        switch (TypeCalcProc)
	    {
        case 1:  CalcExprF1_T1(Func,resCx);
		         break;
	    case 2:  CalcExprF1U_T2(Func,resCx);
		         break;
	    case 3:  CalcExprS1_T3(Func,resCx);
		         break;
    	case 4:  CalcExprS1U_T4(Func,resCx);
		         break;
        case 5:  CalcExprS2_T5(Func,resCx);
		         break;
		case 6:  CalcExprS2U_T6(Func,resCx);
		         break;
	    };


            //--------------------------------------------------------
            if (F_CalcError == FALSE)
            {
              printf("\n");
              ShowResult("Result =    %.12e", rt,resCx);
              printf("\n");
              if(Perf == -1) { printf("perfomance  Expr/ms:  not defined; increase  number of loops \n");}
              else           { printf("perfomance  Expr/ms:  %5d\n", Perf);};
              printf("\n");
              cout <<  "" << endl;
            }
            //--------------------------------------------------------
    }
	else
    {
        ShowError();  /// show syntax error

    };





	//S1r=FloatToStr(resCx.re);
    //S2r=FloatToStr(resCx.im);
    //SRes=S1r+"  "+S2r+"i";


   ///       *******         COMPILE AND EVAL DERIVATIVE d/dx Expr   ***********   ///

 _deriv:

    // TypeCalcProc = 5;

   G_Expr = Expr;
   G_CompileDiffExpr = TRUE;
   flSet(fl_TYPE_OF_DIFFERENTIATION, fl_SYMBOLIC,0);
   NumericDiff = FALSE;

   ndx=1; ///  d/dx(Expr)
   /// flCompileDeriv(Expr.c_str(),"x",ndx,FuncDx); // <- After this command, impossible to get diff. str.  by calling  flGetDiffString;
   /// Can only after this way:
   PDiffPoly = 14;  // diff polynom degree
   flSet(fl_DIFF_NUMERIC_PRECISION,PDiffPoly,2); /// diff polynom of PDiffPoly degree ; h=10^(-2)  for numeric diff.

   flSetDiffExpr(Expr.c_str()); ///!!! <- Check syntax error! If Error, than subsequent diff.& compiling should not be performed.


    flGetErrorCode(ECode);
	if (ECode != 0)
    {
         if (ECode == fl_NO_DIFF_SYMBOLIC)  /// if the expression is not differentiated symbolically, then switch to numerical differentiation mode
         {
            flSet(fl_TYPE_OF_DIFFERENTIATION, fl_NUMERIC,0);
            NumericDiff = TRUE;
            flSetDiffExpr(Expr.c_str());
         }
         else
         {
           ShowError();
           goto exprtest;
         }
    };



   flSetDiffVar("x");
   flDiffExpr(ndx);
   flCompileDiffExpr(FuncDx);

   flGetErrorCode(ECode);

   /// for TypeCalcProc = 2,4,6 with recompiling diff expression
   /*
   flGetDiffString(PS);
   PtrToStr(PS,StrDiff);
   G_Expr = StrDiff;
   */

	if (ECode == 0)
    {
            if ( NumericDiff == TRUE)
                {
                  printf("Expression is not differentiated symbolically. Will be differentiation in  numerical  mode.\n");
                  printf("Degree of differentiating polynomial: %d\n", PDiffPoly);
                };


	        flGetDiffString(PS);
	        PtrToStr(PS,StrDiff);

	        cout << "Diff. expression (d/dx):   " << StrDiff << endl;

            printf("\n");

	        // resCx.re = flResultR(FuncDx);

     /******* There are 6 ways of calculations ***********************/

         switch (TypeCalcProc)
	     {
           case 1:  CalcExprF1_T1(FuncDx,resCx);
		            break;
	       case 2:  CalcExprF1U_T2(FuncDx,resCx);
		            break;
	       case 3:  CalcExprS1_T3(FuncDx,resCx);
		            break;
    	   case 4:  CalcExprS1U_T4(FuncDx,resCx);
		            break;
           case 5:  CalcExprS2_T5(FuncDx,resCx);
		            break;
		   case 6:  CalcExprS2U_T6(FuncDx,resCx);
		         break;
	     };


            if (F_CalcError == FALSE)
            {
               //ShowResult("Result d/dx: %.12e\n", rt,resCx);
               /// printf("result d/dx: %.12e\n", (double)res);
               //printf("\n");
               ShowResult("Result d/dx = %.12e", rt,resCx);
               printf("\n");
               if(Perf == -1) { printf("perfomance  Expr/ms:  not defined; increase  number of loops \n");}
               else           { printf("perfomance  Expr/ms:  %5d\n", Perf);};
               printf("\n");
            }

    }
	else
    {
        ShowError();

    };

    /// Releases the memory of compiled expressions after they have been evaluated: Func, FuncDx
    flPerform(fl_FREE,(INT32)Func);   // not necessary. After closing Foreval.dll, the memory is automatically released
    flPerform(fl_FREE,(INT32)FuncDx); // not necessary. After closing Foreval.dll, the memory is automatically released

    printf("**************************************************************************\n");




	goto exprtest;



///*********************************************  End  test of entered expression ****************************************************************************************************


	system("pause");
 }
}



void SetExprE2R_Diffdxdy_Long()
{

    ExprE2R_Diffdxdy_Long =
    "(x*y/(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))*(-((2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7))*((((5.8)*((t)*(2.6)))*(sqr(y+1.7))-(2*(y+1.7))*(((5.8)*((t)*(2.6)))*(y+1.7)))/sqr(sqr(y+1.7))-"
"((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*(((x-1.5)*(((((5.7*y-7.4)*(4.7))*(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*"
"(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-"
"(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*"
"(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+"
"9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*"
"(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))+"
"(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*"
"(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))*((4.7)*(5.7))-((1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+"
"(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/"
"(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*"
"(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/"
"sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+"
"1.7)-9.4))))))*((4.7*x-1.1)*(5.7))+((4.7*x-1.1)*(5.7*y-7.4))*((((2.4*t)*(-((8.1*y)*(((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*"
"((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))*((t)*((-2.5*y-5.7)*((9.9*"
"(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))+((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1)*(-(2.1))))+((t)*((7.3-2.1*y)*(2.1)))*((9.9*"
"(2.1*x-1.2))*(4.9))+((2.1*x*(7.3-2.1*y)*t-7.1)*(((9.9)*(2.1))*(4.9))+((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))*((t)*((2.1*x)*(-(2.1))))))))+((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*"
"(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))*(-(2.5))))-((1-(-(1/(t-1.7)+"
"(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))+(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t)*((((3.6)*(-((((8.3)*((-1.2*t-1)*((2.8)*(-(1.5)))))*(sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7))-(2*(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)*((-1.2*t-1)*(2.8*(-1.5*x+3.1))))*"
"(((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)))/sqr(sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))))*(sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(2*(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)-9.4)*(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7))))*((1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)))*(3.6)))/sqr(sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))*(sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))-(2*(x-y*2.8-3.6/"
"(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))*(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/"
"(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))*(((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+"
"(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*"
"((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*"
"x*(-2.5*y-5.7)*t)))/sqr(sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))+((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-"
"7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))*(8.1))))*(sqr(3.8-"
"7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-"
"(2*(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))*"
"(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*"
"(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/"
"sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*"
"(8.1))))*((-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+"
"(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*"
"(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/"
"sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)))/sqr(sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*"
"x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))))*(sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*"
"x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))-(2*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))*(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+"
"8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-"
"7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*"
"(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))*(((5.7*y-7.4)*"
"(4.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)-9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*"
"((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+"
"(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*"
"(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4))))/sqr(sqr(x-2.7*y-1.7-2.4*t/"
"(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))-"
"((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/"
"(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*"
"((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*"
"(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*"
"x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*"
"t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*"
"x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))*(sqr(x-1.5))/sqr(sqr(x-1.5)))+((-3.1)/sqr(x+1.5)+((((((5.7*y-7.4)*"
"(4.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*"
"(-1.2*t-1)+1.7)-9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*"
"((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+"
"(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*"
"(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*"
"y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)-"
"((4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+"
"8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))/sqr(x-1.5)))*((2.8*x*(y+1.1))*(3.4)+(3.4*y+2.2)*(2.8*x))+((3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*"
"(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*"
"((3.4*y+2.2)*(2.8)+((y+1.1)*(2.8))*(3.4))+((3.4*y+2.2)*((y+1.1)*(2.8)))*(-(-((t)*(2.4))*(2.3*t)/sqr(2.4*y*t-1.7))+(((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+"
"9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/"
"(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+"
"8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+"
"(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/"
"sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*"
"((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+"
"8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)/sqr(x-1.5)))))))+(((3.6*x-1)-(3.6)*(x))/sqr(3.6*x-1)-((-4.1)/sqr(x))+(((5.8)*((t)*(2.6)))*(y+1.7)/sqr(y+1.7))-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*((-3.1)/"
"sqr(x+1.5)+((((((5.7*y-7.4)*(4.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+"
"8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-"
"(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*"
"(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)-((4.7*x-1.1)*"
"(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)-9.4)))))))/sqr(x-1.5)))+(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*"
"(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((3.4*y+2.2)*((y+1.1)*(2.8))))))*(-(-(3.6))*(2.5*x*(3.7*t-1))/sqr(2.7*x-3.6*y-4.7))+"
"((x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))))*(((((3.7*t-1)*(2.5))*(-(3.6)))*(sqr(2.7*x-3.6*y-4.7))-"
"(2*(2.7*x-3.6*y-4.7)*(-(3.6)))*(((3.7*t-1)*(2.5))*(2.7*x-3.6*y-4.7)-(2.7)*(2.5*x*(3.7*t-1))))/sqr(sqr(2.7*x-3.6*y-4.7)))+((((3.7*t-1)*(2.5))*(2.7*x-3.6*y-4.7)-(2.7)*(2.5*x*(3.7*t-1)))/sqr(2.7*x-3.6*y-4.7))*"
"(-(5.8*(2.6*x*t-1.7))/sqr(y+1.7)-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*(-(-((t)*(2.4))*(2.3*t)/sqr(2.4*y*t-1.7))+(((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x)*(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/"
"(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*"
"(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-"
"8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-"
"7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/"
"sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*"
"y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)/sqr(x-1.5)))+(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((2.8*x*(y+1.1))*(3.4)+(3.4*y+2.2)*(2.8*x))))))))+((2.3)*(t)/sqr(t)-"
"((2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7))*(((3.6*x-1)-(3.6)*(x))/sqr(3.6*x-1)-((-4.1)/sqr(x))+(((5.8)*((t)*(2.6)))*(y+1.7)/sqr(y+1.7))-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*((-3.1)/sqr(x+1.5)+((((((5.7*y-7.4)*(4.7))*"
"(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-"
"9.4)))))-(1-(-(-(7.6)-((8.1*y)*((4.2)*(2.9*t+1.6)/sqr(2.9*t+1.6)-(7.8)+((((t)*((-2.5*y-5.7)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1))+(x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((7.3-2.1*y)*(2.1)))+"
"(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(3.1)+(3.1*x+4.9*y+5.8)*((9.9)*(2.1)))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))-(1-(-(1/(t-1.7)+(-((-1.2*t-1)*((y)*((2.8)*(-(1.5)))))*"
"(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-"
"3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/"
"(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)-((4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-"
"7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))))/sqr(x-1.5)))+(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+"
"(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*"
"(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((3.4*y+2.2)*((y+1.1)*(2.8))))))+(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/"
"(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-"
"9.4)))))/(x-1.5))))*((((3.7*t-1)*(2.5))*(2.7*x-3.6*y-4.7)-(2.7)*(2.5*x*(3.7*t-1)))/sqr(2.7*x-3.6*y-4.7))))*(((x)*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-((2.7*x)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+"
"(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4)))))*(x*y))/sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))+((2.3*x/t-2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7)*(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*"
"(3.4*y+2.2)*(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/"
"(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5)))))*((((y)*((2.7*x)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4)))))+(2.7*x*(-3.3*x*(4.4*y*"
"(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-(((2.7*x)*(-((3.3*x)*((4.4*y)*(2.9+((10.1)*(1.9))))+(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))*(3.3)))+(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))*(2.7))*(x)+(x*y)*((2.7*x)*"
"(-((3.3*x)*((2.9+((10.1)*(1.9)))*(4.4))+((3.3)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4)))))+((2.7)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4))))))))*"
"(sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))-(2*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))*((2.7*x)*(-((3.3*x)*((4.4*y)*(3.7+((10.1)*(9.1)))+(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))*(4.4))))))*"
"((y)*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-((2.7*x)*(-((3.3*x)*((4.4*y)*(2.9+((10.1)*(1.9))))+(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))*(3.3)))+(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))*(2.7))*"
"(x*y)))/sqr(sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))))+(((y)*(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y)))))-((2.7*x)*(-((3.3*x)*((4.4*y)*(2.9+((10.1)*(1.9))))+(4.4*y*(2.9*x+3.7*y+10.1*"
"(1.9*x+9.1*y)))*(3.3)))+(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))*(2.7))*(x*y))/sqr(2.7*x*(-3.3*x*(4.4*y*(2.9*x+3.7*y+10.1*(1.9*x+9.1*y))))))*(-((2.5*x*(3.7*t-1)/(2.7*x-3.6*y-4.7))*(-(5.8*(2.6*x*t-1.7))/"
"sqr(y+1.7)-((7.1)*((2.8*x*(y+1.1)*(3.4*y+2.2))*(-(-((t)*(2.4))*(2.3*t)/sqr(2.4*y*t-1.7))+(((((4.7*x-1.1)*(5.7))*(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))-(-(2.7)-(-(-((8.1*y)*((((t)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x)*"
"(-(2.5))+(-2.5*y-5.7)*((x)*((9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8))*((t)*((2.1*x)*(-(2.1))))+(2.1*x*(7.3-2.1*y)*t-7.1)*((9.9*(2.1*x-1.2))*(4.9))))))*(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-"
"9.4))-(-(2.8)-(-(-((-7.8)/sqr(y+2.5))+(-((-1.2*t-1)*(2.8*(-1.5*x+3.1)))*(8.3)/sqr(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)))*(3.6)/sqr(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t))/sqr(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))+(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*"
"(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))*(8.1)))*(2.4*t)/sqr(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*"
"(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*((4.7*x-1.1)*(5.7*y-7.4)))/sqr(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*"
"(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4))))))*(x-1.5)/sqr(x-1.5)))+"
"(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-"
"3.6/(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))*((2.8*x*(y+1.1))*(3.4)+(3.4*y+2.2)*(2.8*x)))))+(x/(3.6*x-1)-4.1/x+5.8*(2.6*x*t-1.7)/(y+1.7)-7.1*(2.8*x*(y+1.1)*(3.4*y+2.2)*"
"(3.1/(x+1.5)-2.3*t/(2.4*y*t-1.7)+(4.7*x-1.1)*(5.7*y-7.4)/(x-2.7*y-1.7-2.4*t/(3.8-7.6*x-8.1*y*(4.2*x/(2.9*t+1.6)-7.8*x-8.9/t+9.9*(2.1*x-1.2)*(3.1*x+4.9*y+5.8)*(2.1*x*(7.3-2.1*y)*t-7.1)*x*(-2.5*y-5.7)*t/(x-y*2.8-3.6/"
"(x/(t-1.7)-7.8/(y+2.5)+8.3/(2.8*(-1.5*x+3.1)*y*(-1.2*t-1)+1.7)-9.4)))))/(x-1.5))))*(-(-(3.6))*(2.5*x*(3.7*t-1))/sqr(2.7*x-3.6*y-4.7)))));";

}





void SetExprE2PR_Diffdxdy_Long()
{

    ExprE2PR_Diffdxdy_Long =
    "-((((-(-(-(-(-(-1)*(b)/sqr(-x))-(((b)*(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/"
"(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))-(-(-(-(-(-(d)-(-(-1-(-(-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(-(-(((-(c)-"
"(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/"
"sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/"
"sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*"
"(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*"
"(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/"
"(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/"
"(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x))/sqr(-b/(-c/y-b/"
"(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(d)/sqr(-y-b/"
"(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*"
"(y)/sqr(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/"
"(-b-x/(-a/y))))))))))))))*(-(((x)*(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))-(-(((-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))-(-(-(-(-(-1)*(c)/sqr(-y-b)))*(b)/sqr(-a-c/(-y-b)))-"
"((d)*(-((c)*(-((y)*(-((x)*(-(((-c-d*(-y/(-x-d)))-(-((d)*(-(1/(-x-d)))))*(y))/sqr(-c-d*(-y/(-x-d)))))))+(-x*(-y/(-c-d*(-y/(-x-d)))))))))))*(y))/sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*(x*y))/"
"sqr(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))))+(-x*y/(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*((((-(-(-(-1)*(b)/sqr(-x))-(((b)*(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/"
"(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))-(-(-(-(-(-(d)-(-(-1-(-(-(((-(c))*"
"(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(-(-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-"
"(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/"
"sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/"
"(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/"
"(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/"
"(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x))/sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/"
"(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(d)/sqr(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-"
"c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))+(y)*(-((((d)*(-((((b)*(-(-(-(-(c)/sqr(y))-(-(-(-(-(-(-(-(-(b))*"
"(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/"
"(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/"
"(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/"
"(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/"
"(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/sqr(-d-(-c*x-"
"(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))-((b*x)*((((b)*((((b)*((((c)*((((d)*(-((((-(c))*(-(b)))*(sqr(-a*x-b*y-a))-(2*(-a*x-b*y-a)*(-(b)))*((-(c))*"
"(-a*x-b*y-a)-(-(a))*(c*(-x))))/sqr(sqr(-a*x-b*y-a)))-(-((((b)*(1/(sqr(x))))*(sqr(-y/x))-(2*(-y/x)*(-(1/(x))))*((-(-(y)/sqr(x)))*(b)))/sqr(sqr(-y/x))))))*(sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(2*(-c*(-x)/(-a*x-b*y-a)-b/"
"(-y/x))*(-(-(-(b))*(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x))))*((-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)))/sqr(sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-"
"(-((((-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/"
"sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/"
"(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*"
"(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/"
"(-x-c))/(-y/(-b-x/(-a/y))))))*(c)+(c*y)*(-((((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/"
"sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-"
"(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/"
"sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))+(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))*(-((((-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*"
"(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))+(y)*((((b)*((-1)*(sqr(-b-x))/sqr(sqr(-b-x))-(((-(-(-(-(-1-(-(-1)*(x)/"
"sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y))))-((x)*((((b)*((((d)*(-(((-1)*(sqr(-a-x-y))-(-(2*(-a-x-y)))*((-a-x-y)-(-1)*(x)))/sqr(sqr(-a-x-y)))))*(sqr(-y-x/(-a-x-y)))-(2*(-y-x/(-a-x-y))*(-1-(-(-1)*(x)/"
"sqr(-a-x-y))))*((-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)))/sqr(sqr(-y-x/(-a-x-y)))))*(sqr(-d/(-y-x/(-a-x-y))))-(2*(-d/(-y-x/(-a-x-y)))*(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y)))))*((-(-(-(((-a-x-y)-(-1)*(x))/"
"sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)))/sqr(sqr(-d/(-y-x/(-a-x-y)))))))*(sqr(-c-b/(-d/(-y-x/(-a-x-y)))))-(2*(-c-b/(-d/(-y-x/(-a-x-y))))*(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/"
"(-a-x-y))))))*((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)))/sqr(sqr(-c-b/(-d/(-y-x/(-a-x-y))))))))*(sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y))))))-(2*(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))*(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y)))))))*((-(-(-1)*(y)/"
"sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)))/sqr(sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y))))))))*(sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-(2*(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))*(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/"
"(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))))*((-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/"
"(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)))/sqr(sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-(-(-1-"
"(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x)))))-((x)*((((d)*((((c)*(-(((-((-(d))*(-x)/sqr(-x))-((x)*((d)*(sqr(-x))/sqr(sqr(-x)))))*(sqr(-d*(-y)/(-x)))-"
"(2*(-d*(-y)/(-x))*(-((-(d))*(-x)/sqr(-x))))*((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x)))/sqr(sqr(-d*(-y)/(-x))))))*(sqr(-x/(-d*(-y)/(-x))))-(2*(-x/(-d*(-y)/(-x)))*(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x)))))*"
"((-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)))/sqr(sqr(-x/(-d*(-y)/(-x))))))*(sqr(-y-c/(-x/(-d*(-y)/(-x)))))-(2*(-y-c/(-x/(-d*(-y)/(-x))))*(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/"
"(-x))))*(c)/sqr(-x/(-d*(-y)/(-x))))))*((-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)))/sqr(sqr(-y-c/(-x/(-d*(-y)/(-x))))))))*(sqr(-d/(-y-c/(-x/(-d*(-y)/"
"(-x))))))-(2*(-d/(-y-c/(-x/(-d*(-y)/(-x)))))*(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x)))))))*((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-"
"(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)))/sqr(sqr(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))))))-((-(((((-d/(-x-c))-(-(-(-1)*(d)/"
"sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-(-(((-b/"
"(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/"
"(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/"
"(-x))))))*(x)/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))+(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))*(-((((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/"
"(-x-c)))*(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))-((x/(-d/(-x-c)))*((((-(1/(-a/y)))+(y)*(-(-(-(-(a)/sqr(y)))*(1)/sqr(-a/y))))*(sqr(-b-x/(-a/y)))-(2*(-b-x/(-a/y))*(-(-(-(-(a)/sqr(y)))*"
"(x)/sqr(-a/y))))*((-(1/(-a/y)))*(y)))/sqr(sqr(-b-x/(-a/y))))))*(sqr(-y/(-b-x/(-a/y))))-(2*(-y/(-b-x/(-a/y)))*(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y)))))*((((-d/(-x-c))-(-(-(-1)*(d)/"
"sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))))/sqr(sqr(-y/(-b-x/(-a/y))))))))*(sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(2*(-y-x/(-d/(-x-c))/(-y/(-b-x/"
"(-a/y))))*(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y))))))*((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-"
"(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/"
"(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/"
"(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))))/sqr(sqr(-y-x/(-d/(-x-c))/"
"(-y/(-b-x/(-a/y))))))))*(sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))-(2*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))*(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/"
"sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*"
"(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-"
"(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/"
"(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*((-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/"
"sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-"
"((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/"
"(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/"
"(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)))/sqr(sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))-(2*(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/"
"(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(-(-(-(-(-(b))*(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/"
"(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/"
"sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-"
"((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/(-x/"
"(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/"
"(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*((-1-(-(-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(-(-(((-(c)-"
"(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/"
"sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/"
"(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/"
"(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)))/sqr(sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-"
"b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/"
"(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))-(2*(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/"
"(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(-(-(-(-(-(-(-(b))*(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x)))*(d)/"
"sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(-(((-(-(((-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/"
"sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/"
"(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/"
"(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/"
"(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*((-(d)-(-(-1-(-(-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-"
"(-(-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/"
"sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/"
"sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/"
"sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/"
"sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/"
"(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)))/sqr(sqr(-d*x-c/(-x-d/"
"(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(sqr(-c/y-b/(-d*x-c/(-x-d/"
"(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))-(2*(-c/y-b/(-d*x-c/(-x-d/"
"(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(-(-(c)/sqr(y))-(-(-(-(-(-(-(-(-(b))*"
"(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/"
"(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/"
"(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/"
"sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/"
"sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/"
"sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-"
"(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/"
"(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*((-(-(-(d)-(-(-1-(-(-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-"
"(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(-(-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*"
"(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/"
"(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/"
"(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/"
"(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/"
"(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)))/sqr(sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/"
"(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))*(sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/"
"(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))-(2*(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/"
"(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(-(-(-(-(c)/sqr(y))-(-(-(-(-(-(-(-(-(b))*(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-"
"(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/"
"(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/(-x/"
"(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/"
"(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*((b)*(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/"
"(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))-(-(-(-(-(-(d)-(-(-1-(-(-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/"
"(-y/x)))-(-(-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*"
"(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/"
"sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/"
"sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/"
"sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/"
"(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/"
"(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x)))/sqr(sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/"
"(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))))*(sqr(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))-(2*(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/"
"(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(-1-(-(-(-(-(-(c)/sqr(y))-(-(-(-(-(-(-(-(-(b))*(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*"
"(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-"
"(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/"
"sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/"
"sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/"
"sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x)/sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))*((-(-(-1)*(b)/sqr(-x))-(((b)*(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))-(-(-(-(-(-(d)-(-(-1-(-(-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*"
"(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(-(-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/"
"(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-"
"d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-"
"(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/"
"(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/"
"(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*"
"(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*"
"(b*x))/sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/"
"(-a/y)))))))))))*(d)))/sqr(sqr(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/"
"(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))))*(sqr(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/"
"(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))))-(2*(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))*(-(-1-(-(-(-(-(-(c)/sqr(y))-(-(-(-(-(-(-(-(-(b))*(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/"
"(-a*x-b*y-a)-b/(-y/x)))-(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*"
"(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/"
"(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/"
"(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/"
"(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/"
"(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/"
"(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x)/sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/"
"(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(d)/sqr(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))*((-(-(-(-1)*(b)/sqr(-x))-(((b)*(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-"
"a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))-(-(-(-(-(-(d)-(-(-1-(-(-(((-(c))*(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/"
"(-a*x-b*y-a)-b/(-y/x)))-(-(-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/"
"(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*"
"(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*"
"(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*"
"(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/"
"(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/"
"(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x))/sqr(-b/(-c/y-"
"b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(d)/sqr(-y-b/"
"(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*"
"(y)))/sqr(sqr(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/"
"(-y/(-b-x/(-a/y))))))))))))))-((-(((y)*(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))-(-(-(-((d)*(-((c)*(-((y)*(-((x)*(-(-(-((d)*(-(-(-1)*(y)/sqr(-x-d)))))*(y)/sqr(-c-d*(-y/(-x-d)))))+(-y/(-c-d*(-y/"
"(-x-d))))))))))))*(y)/sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*(x*y))/sqr(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))))*(-(((-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/"
"(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))-(-(-1-(-(-(-(-(-(c)/sqr(y))-"
"(-(-(-(-(-(-(-(-(b))*(c*(-x))/sqr(-a*x-b*y-a))-(-(-(1/(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(((c)*(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/"
"(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))-(-(((-(-(((-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-(-(-(-(1/(-b-x))-(-(-(-(-(-(-1-(-(-1)*(x)/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x)/"
"sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y))/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-((a)*(-((b)*(-(-(-(-(-1-(-(-(-(-((-(d))*(-x)/sqr(-x)))*(x)/sqr(-d*(-y)/(-x))))*(c)/"
"sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x)/sqr(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-1-(-(-(((-b-x/(-a/y))-(-(-(-(-(a)/sqr(y)))*(x)/sqr(-a/y)))*(y))/sqr(-b-x/"
"(-a/y))))*(x/(-d/(-x-c)))/sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y))/sqr(-d-(-c*x-(-y/"
"(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/"
"(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x)/sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/"
"(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(d)/sqr(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(y))/sqr(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-"
"(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))))+(-b-y/(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/"
"(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))))*(-((((y)*(-(((-b/(-a-c/(-y-b))-"
"d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))-(-(-(-(-(-1)*(c)/sqr(-y-b)))*(b)/sqr(-a-c/(-y-b)))-((d)*(-((c)*(-((y)*(-((x)*(-(((-c-d*(-y/(-x-d)))-(-((d)*(-(1/(-x-d)))))*(y))/sqr(-c-d*(-y/(-x-d)))))))+(-x*(-y/(-c-d*(-y/"
"(-x-d)))))))))))*(y))/sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))+(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))-((-(-(-((d)*(-((c)*(-((y)*(-((x)*(-(-(-((d)*(-(-(-1)*(y)/"
"sqr(-x-d)))))*(y)/sqr(-c-d*(-y/(-x-d)))))+(-y/(-c-d*(-y/(-x-d))))))))))))*(y)/sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*(x)+(x*y)*((((-((d)*(-((c)*(-((y)*(-((x)*(-(-(-((d)*(-(-(-1)*(y)/"
"sqr(-x-d)))))*(y)/sqr(-c-d*(-y/(-x-d)))))+(-y/(-c-d*(-y/(-x-d))))))))))))+(y)*(-((d)*(-((c)*(-((y)*(-((x)*((((-((d)*(-(-(-1)*(y)/sqr(-x-d)))))+(y)*(-((d)*((-1)*(sqr(-x-d))/sqr(sqr(-x-d))))))*(sqr(-c-d*(-y/(-x-d))))-"
"(2*(-c-d*(-y/(-x-d)))*(-((d)*(-(1/(-x-d))))))*((-((d)*(-(-(-1)*(y)/sqr(-x-d)))))*(y)))/sqr(sqr(-c-d*(-y/(-x-d)))))+(-(((-c-d*(-y/(-x-d)))-(-((d)*(-(1/(-x-d)))))*(y))/sqr(-c-d*(-y/(-x-d)))))))+(-((x)*(-(-(-((d)*"
"(-(-(-1)*(y)/sqr(-x-d)))))*(y)/sqr(-c-d*(-y/(-x-d)))))+(-y/(-c-d*(-y/(-x-d)))))))))))))*(sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))-(2*(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))*"
"(-(-(-(-(-1)*(c)/sqr(-y-b)))*(b)/sqr(-a-c/(-y-b)))-((d)*(-((c)*(-((y)*(-((x)*(-(((-c-d*(-y/(-x-d)))-(-((d)*(-(1/(-x-d)))))*(y))/sqr(-c-d*(-y/(-x-d)))))))+(-x*(-y/(-c-d*(-y/(-x-d))))))))))))*((-((d)*(-((c)*(-((y)*"
"(-((x)*(-(-(-((d)*(-(-(-1)*(y)/sqr(-x-d)))))*(y)/sqr(-c-d*(-y/(-x-d)))))+(-y/(-c-d*(-y/(-x-d))))))))))))*(y)))/sqr(sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))))*(sqr(-y/(-b/(-a-c/(-y-b))-d*"
"(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))-(2*(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))*(-(((-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))-(-(-(-(-(-1)*(c)/sqr(-y-b)))*(b)/"
"sqr(-a-c/(-y-b)))-((d)*(-((c)*(-((y)*(-((x)*(-(((-c-d*(-y/(-x-d)))-(-((d)*(-(1/(-x-d)))))*(y))/sqr(-c-d*(-y/(-x-d)))))))+(-x*(-y/(-c-d*(-y/(-x-d)))))))))))*(y))/sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/"
"(-x-d)))))))))))*((y)*(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))-(-(-(-((d)*(-((c)*(-((y)*(-((x)*(-(-(-((d)*(-(-(-1)*(y)/sqr(-x-d)))))*(y)/sqr(-c-d*(-y/(-x-d)))))+(-y/(-c-d*(-y/(-x-d))))))))))))*"
"(y)/sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*(x*y)))/sqr(sqr(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))))))*(sqr(-x*y/(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/"
"(-x-d)))))))))))-(2*(-x*y/(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*(-(((x)*(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))-(-(((-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/"
"(-x-d))))))))-(-(-(-(-(-1)*(c)/sqr(-y-b)))*(b)/sqr(-a-c/(-y-b)))-((d)*(-((c)*(-((y)*(-((x)*(-(((-c-d*(-y/(-x-d)))-(-((d)*(-(1/(-x-d)))))*(y))/sqr(-c-d*(-y/(-x-d)))))))+(-x*(-y/(-c-d*(-y/(-x-d)))))))))))*(y))/"
"sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*(x*y))/sqr(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))))*((-(-(-(-(-(-1)*(b)/sqr(-x))-(((b)*(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/"
"(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))-(-(-(-(-(-(d)-(-(-1-(-(-(((-(c))*"
"(-a*x-b*y-a)-(-(a))*(c*(-x)))/sqr(-a*x-b*y-a))-(-(-(-(y)/sqr(x)))*(b)/sqr(-y/x)))*(d)/sqr(-c*(-x)/(-a*x-b*y-a)-b/(-y/x)))-(-(-(((-(c)-(-(-(-(-(-(-(-1)*(y)/sqr(-b-x))-(((-c-b/(-d/(-y-x/(-a-x-y))))-(-(-(-(-(-(((-a-x-y)-"
"(-1)*(x))/sqr(-a-x-y)))*(d)/sqr(-y-x/(-a-x-y))))*(b)/sqr(-d/(-y-x/(-a-x-y)))))*(x))/sqr(-c-b/(-d/(-y-x/(-a-x-y))))))*(b)/sqr(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))*(y)/sqr(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y)))))))-"
"((a)*(-((b)*(-(((-d/(-y-c/(-x/(-d*(-y)/(-x)))))-(-(-(-(-(-(((-d*(-y)/(-x))-(-(-(-1)*(d*(-y))/sqr(-x)))*(x))/sqr(-d*(-y)/(-x))))*(c)/sqr(-x/(-d*(-y)/(-x)))))*(d)/sqr(-y-c/(-x/(-d*(-y)/(-x))))))*(x))/sqr(-d/(-y-c/"
"(-x/(-d*(-y)/(-x))))))))))))*(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))-(-(((((-d/(-x-c))-(-(-(-1)*(d)/sqr(-x-c)))*(x))/sqr(-d/(-x-c)))*(-y/(-b-x/(-a/y)))-(-(-(-(1/(-a/y)))*(y)/sqr(-b-x/(-a/y))))*(x/(-d/(-x-c))))/"
"sqr(-y/(-b-x/(-a/y)))))*(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x))))))))))/sqr(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))*(c*y)/sqr(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))*(c)/sqr(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))*(b)/sqr(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/"
"(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))*(b)/sqr(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/"
"(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))*(b*x))/sqr(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/"
"(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(d)/sqr(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/"
"(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))*(y)/sqr(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/"
"(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y))))))))))))))*"
"(-x*y/(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))-(-(((y)*(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))-(-(-(-((d)*(-((c)*(-((y)*(-((x)*(-(-(-((d)*(-(-(-1)*(y)/sqr(-x-d)))))*"
"(y)/sqr(-c-d*(-y/(-x-d)))))+(-y/(-c-d*(-y/(-x-d))))))))))))*(y)/sqr(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))*(x*y))/sqr(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d)))))))))))*"
"(-b-y/(-c-(-d/(-y-b/(-x)-b*x/(-b/(-c/y-b/(-d*x-c/(-x-d/(-c*(-x)/(-a*x-b*y-a)-b/(-y/x))-c*y/(-d-(-c*x-(-y/(-b/(-y/(-b-x)-x/(-c-b/(-d/(-y-x/(-a-x-y))))))-a*(-b*(-c-x/(-d/(-y-c/(-x/(-d*(-y)/(-x)))))))))/"
"(-y-x/(-d/(-x-c))/(-y/(-b-x/(-a/y)))))))))))))))/sqr(sqr(-x*y/(-y/(-b/(-a-c/(-y-b))-d*(-c*(-y*(-x*(-y/(-c-d*(-y/(-x-d))))))))))))";
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void LoadDataLib(void)
{


	  _int32       ID,ID1,ID2,ID3,ID4,SZ,IDF;
	  string       Sid,Sid1,Sid2,Sid3,Sid4,SText,SRes;




  flGet(fl_VERSION,fl_MAJOR,ID1);    Sid1=IntToStr(ID1);
  flGet(fl_VERSION,fl_MINOR,ID2);    Sid2=IntToStr(ID2);
  flGet(fl_VERSION,fl_RELEASE,ID3);  Sid3=IntToStr(ID3);
  flGet(fl_VERSION,fl_BUILD,ID4);    Sid4=IntToStr(ID4);
  Sid=Sid1+"."+Sid2+"."+Sid3+"."+Sid4;



  SText="Foreval.dll  (v."+Sid+")";
  flGet(fl_COMPILED_BY,0,ID);


  if (ID >= 100)
    {
        SText=SText+".  Compiled by FPC v." + IntToStr(ID);// DLLCompiledBy = Lazarus;
    }

  else
  {
    //DLLCompiledBy = Delphi;
    switch  (ID)
   {

    case 15:  SText=SText+".    Compiled by Delphi7"; break;
    case 16:  SText=SText+".    Compiled by Delphi8";   break;
    case 17:  SText=SText+".    Compiled by Delphi2005"; break;
    case 18:  SText=SText+".    Compiled by Delphi2006"; break;
    case 19:  SText=SText+".    Compiled by Delphi2007";  break;
    case 20:  SText=SText+".    Compiled by Delphi 2009"; break;
    case 21:  SText=SText+".    Compiled by Delphi 2010"; break;
    case 22:  SText=SText+".    Compiled by Delphi XE"; break;
    case 23:  SText=SText+".    Compiled by Delphi XE2";  break;
    case 24:  SText=SText+".    Compiled by Delphi XE3";  break;
    case 25:  SText=SText+".    Compiled by Delphi XE4";  break;
    case 26:  SText=SText+".    Compiled by Delphi XE5"; break;
    case 27:  SText=SText+".    Compiled by Delphi XE6";  break;
    case 28:  SText=SText+".    Compiled by Delphi XE7";  break;
    case 29:  SText=SText+".    Compiled by Delphi XE8";  break;
    case 30:  SText=SText+".    Compiled by Delphi 10";  break;
    case 31:  SText=SText+".    Compiled by Delphi 10.1";  break;
    case 32:  SText=SText+".    Compiled by Delphi 10.2";  break;
    case 33:  SText=SText+".    Compiled by Delphi 10.3";  break;
    case 34:  SText=SText+".    Compiled by Delphi 10.4";  break;
    case 35:  SText=SText+".    Compiled by Delphi 11";  break;
    default:  SText=SText+".    Compiled by Delphi 11+";  break;
   }
 }
  SText = "      "+SText;
  cout <<  "" << endl;


  cout <<  "" << endl;
  cout <<  "************************************************************************"<< endl;
  cout <<  "************************************************************************"<< endl;
  cout <<  "                    Test  Foreval.dll on GCC"                            << endl;
  cout <<  "************************************************************************"<< endl;
  cout <<  "************************************************************************"<< endl;
  cout <<  "" << endl;
  cout <<  SText << endl;
  cout <<  "************************************************************************"<< endl;



  #ifdef   EXTENDED_FLOAT
       SText="Current setting: Float type for variables & functions is EXTENDED";
  #else
       SText="Current setting: Float type for variables & functions is DOUBLE";
  #endif
   SText = "      "+SText;
   cout <<  "" << endl;
   cout <<  SText << endl;
   //cout <<  "" << endl;



  #ifdef   COMPLEX_VAR_ANY_ADDR
       SText="Current setting: Addresses of complex variables of Foreval  same as GCC";
  #else
       SText="Current setting: Addresses of  Foreval complex variables are independent from GCC complex variables";
  #endif
   SText = "      "+SText;
   cout <<  "" << endl;
   cout <<  SText << endl;
   cout <<  "" << endl;



  cout << "  on default:" << endl;
  cout << "" << endl;
  cout <<  "  real var.: x=2.123; y=5.456; t=-3.789; and other "<< endl;
  cout <<  ""<< endl;
  cout <<  "  int. var.: n=1; k=2; j=5; and other " << endl;
  cout <<  ""<< endl;
  cout <<  "  complex var.: z1.re=2.123; z1.im= -1.456; z2.re=5.456; z2.im=2.789; z3.re= -3.789; z3.im= -3.123; and other "<< endl;
  cout <<  ""<< endl;
  cout <<  "  real const.: a=2.54321; b=-3.98765; c=4.12345; and other"<< endl;
  cout <<  ""<< endl;
  cout <<  "  complex const.: ai=2.54321+4.12345i; bi=-3.98765+2.54321i; ci=4.12345-3.98765; and other"<< endl;
  cout <<  ""<< endl;
  cout <<  "  array of extended:    ve (0-99)"<< endl;
  cout <<  "  array of double:      vd (0-99)"<< endl;
  cout <<  "  array of integer:     vi (0-99)"<< endl;
  cout <<  "  array of single:      vs (0-99)"<< endl;
  cout <<  "  array of float(double/extended):  vu1,vu2,vu3 (0-99)"<< endl;
  cout <<  ""<< endl;
  cout <<  "*****************************************"<< endl;
  cout <<  "examples:"<< endl;
  cout <<  ""<< endl;
  cout <<  "  root(z1,3)+(z2.re/z1.im)^2"<< endl;
  cout <<  ""<< endl;
  cout <<  "  zi1:Cxdbl = |z1|^n*cossin(arg(z1)*n); zi2:Cxdbl = |z1|*exp(i*arg(z1)); zi1/zi2"<< endl;
  cout <<  ""<< endl;
  cout <<  "  z1:Cxdbl = 1+2i; z2:Cxdbl = 3-5i; result = z1^log(z1,z2)/z2 "<< endl;

  cout <<  "******************************************************************************" << endl;


}


//----------------------------------------------------------------------------------------------------------------------------------

TComplexNum func1Gcc(TComplexNum z1, TComplexNum z2, TComplexNum z3, TFloatType x, TFloatType y,  _int32 k, _int32 n)
{
  return  z3*(z1*x+z2*y)/(z1*n+z2*k);
};


TComplexNum func2Gcc(TComplexNum z1, TComplexNum z2, TComplexNum z3, TFloatType x, TFloatType y,  _int32 k, _int32 n)
{
  return  z3*(z1*y+z2*x)/(z1*k+z2*n);
};



//double trunc(double d){ return (d>0) ? floor(d) : ceil(d) ; }
TFloatType _trunc(TFloatType d){ return (d>0) ? floor(d) : ceil(d) ; }

//double abs(double d){ return fabs(d) ; }
TFloatType _abs(TFloatType d){ return fabs(d) ; }


std::string IntToStr(INT32 Inum)
{
    std::stringstream ss;
    ss<<Inum;
    std::string str1;
    ss>>str1;
    return str1;
};

INT32 StrToInt(std::string Str)
{
 /**
    std::stringstream ss;
    INT32   Inum;

    ss<<Str;
    ss>>Inum;

    return Inum;
**/
    std::stringstream ss;
    INT32   Inum;
    TFloatType FX;


    ss<<Str;
    ss>>FX;

    Inum = (Int32)_trunc(FX);

    return Inum;


};


                         //double
std::string FloatToStr(TFloatType F)
{

    std::stringstream ss;
    ss<<F;
    std::string str1;
    ss>>str1;
    return str1;
 }


void ShowResult(TFloatType Re)
{
    //std::stringstream SRes;
    std::string SRes;

    SRes=FloatToStr(Re)+"   ";
    cout <<  SRes << endl;
}


void ShowResult(TFloatType Re1, TFloatType Re2)
{
    //std::stringstream SRes;
    std::string SRes;

    SRes=FloatToStr(Re1)+"   "+FloatToStr(Re2);
    cout <<  SRes << endl;
}


void ShowResult(TComplex Cx)
{
    //std::stringstream SRe,SIm,SRes;
    std::string SRe,SIm,SRes;

    //SRe=FloatToStr(Cx.re);
    //SIm=FloatToStr(Cx.im);
    //SRes=SRe+"    "+SIm+"i";
    //cout <<  SRes << endl;

    cout <<  std::to_string(Cx.re)+"    " + std::to_string(Cx.im)+"i"<< endl;
}


void ShowResult(TComplexNum Cx)
{
    //std::stringstream SRe,SIm,SRes;
    std::string SRe,SIm,SRes;

    //SRe=FloatToStr(Cx.re);
    //SIm=FloatToStr(Cx.im);
    //SRes=SRe+"    "+SIm+"i";
    //cout <<  SRes << endl;

    cout <<  std::to_string(Cx.re) +"    "+ std::to_string(Cx.im)+"i"<< endl;
}


void ShowResult( std::string SCom, TFloatType Re)
{
    //std::stringstream SRes;
    std::string SRes;

    SRes=SCom + FloatToStr(Re)+"   ";
    cout <<  SRes << endl;


}



void ShowResult( std::string SCom, TFloatType Re,  TFloatType Im)
{
    //std::stringstream SRes;
    std::string SRes;

    SRes=SCom + FloatToStr(Re)+"   "+ FloatToStr(Im)+"i";
    cout <<  SRes << endl;


}



void ShowResult( std::string SRes, Int32 rt, TComplex ResCx)
{
    //std::stringstream SRes;
    //std::string SPRes;


	//S1r=FloatToStr(resCx.re);
    //S2r=FloatToStr(resCx.im);
    //SRes=S1r+"  "+S2r+"i";



      if  ((rt == fl_COMPLEX) || (rt == fl_NONE))
        {
              // printf(SRes.c_str(), (double)(ResCx.re)); printf(" "); printf("%.12e",  (double)(ResCx.im)); printf("i\n");



               //printf(SRes.c_str());  printf("\n");

               printf(SRes.c_str(),  (double)(ResCx.re)); printf(" "); printf("%.12e",  (double)(ResCx.im)); printf("i\n");
              // printf(SRes.c_str(),  (long double)(ResCx.re)); printf(" "); printf("%Le.12e",  (long double)(ResCx.im)); printf("i\n");
        }
      else /// (rt == fl_REAL)
        {
              printf(SRes.c_str(), (double)(ResCx.re));
        };


}



void ShowResult( std::string SRes, Int32 rt, TComplexNum ResCx)
{
    //std::stringstream SRes;
    //std::string SPRes;


	//S1r=FloatToStr(resCx.re);
    //S2r=FloatToStr(resCx.im);
    //SRes=S1r+"  "+S2r+"i";



      if  ((rt == fl_COMPLEX) || (rt == fl_NONE))
        {
              // printf(SRes.c_str(), (double)(ResCx.re)); printf(" "); printf("%.12e",  (double)(ResCx.im)); printf("i\n");



               //printf(SRes.c_str());  printf("\n");
               printf(SRes.c_str(),  (double)(ResCx.re)); printf(" "); printf("%.12e",  (double)(ResCx.im)); printf("i\n");

               //printf(SRes.c_str(),  (long double)(ResCx.re)); printf(" "); printf("%Le.12e",  (long double)(ResCx.im)); printf("i\n");
        }
      else /// (rt == fl_REAL)
        {
              printf(SRes.c_str(), (double)(ResCx.re));
        };


}



void ShowResult(Pointer32 Addr, std::string SFunc, _int32 id)
{
  SFunc=SFunc+" = ";

 if(id == fl_REAL)
         {
             resf.re=flResultR(Addr);
             cout <<  SFunc << endl;
             ShowResult(resf.re);
         }
         else
         {
            #ifdef   EXTENDED_FLOAT
               flResultCxE(Addr, resf.re, resf.im) ;
            #else
               flResultCxD(Addr, resf.re, resf.im) ;
            #endif

            cout <<  SFunc << endl;
             ShowResult(resf);

         };

};



void ShowResult(Pointer32 Addr, std::string SFunc)
{
  _int32 rt;

  SFunc=SFunc+" = ";

  flGet(fl_RESULT_TYPE,INT32(Addr),rt);

  if(rt == fl_REAL)
         {
             resf.re=flResultR(Addr);
             cout <<  SFunc << endl;
             ShowResult(resf.re);
         }
  else
  if(rt == fl_COMPLEX)
         {
            #ifdef   EXTENDED_FLOAT
               flResultCxE(Addr, resf.re, resf.im) ;
            #else
               flResultCxD(Addr, resf.re, resf.im) ;
            #endif

            cout <<  SFunc << endl;
             ShowResult(resf);

         };

};




void RefReshVar()
{


  n = 1; k = 2; j = 5; m = -3; l = 4;

  x = 2.123l; y = 5.456l;  t = -3.789l;
  r = 1.357l; s = -5.135l; p = 2.246l;
  q = 3.678l; u = -1.468l; v = 4.975l;



     z1f.re=2.123l;  z1f.im=-1.456l;
     z2f.re=5.456l;  z2f.im=2.789l;
     z3f.re=-3.789l; z3f.im=-3.123l;
     z4f.re=-5.135l; z4f.im=3.975l;
     z5f.re=2.246l;  z5f.im=1.753l;

     z1.re=2.123l;   z1.im=-1.456l;
     z2.re=5.456l;   z2.im=2.789l;
     z3.re=-3.789l;  z3.im=-3.123l;
     z4.re=-5.135l;  z4.im=3.975l;
     z5.re=2.246l;   z5.im=1.753l;

     z1s.real(z1.re); z1s.imag(z1.im);
     z2s.real(z2.re); z2s.imag(z2.im);
     z3s.real(z3.re); z3s.imag(z3.im);
     z4s.real(z4.re); z4s.imag(z4.im);
     z5s.real(z5.re); z5s.imag(z5.im);



}




void RefReshArrays()
{
     INT32 lenv;
     lenv = vdt.size();
     vd.resize(lenv);
     flSetLength(adrVD, fl_ARRAY_REAL_DOUBLE, lenv);
     flCopyArrayDbl(&vd[0],&vdt[0],lenv); //to gcc array
     flCopyArrayDbl((Pointer32)(*((PInteger)adrVD)),&vdt[0],lenv);//to foreval array

     lenv = vit.size();
     vi.resize(lenv);
     flSetLength(adrVI, fl_ARRAY_REAL_INTEGER, lenv);
     flCopyArrayInt(&vi[0],&vit[0],lenv);//to gcc array
     flCopyArrayInt((Pointer32)(*((PInteger)adrVI)),&vit[0],lenv);//to foreval array

     // for coping single array use flCopyArrayInt , so as the same size of array = 4b
     lenv = vst.size();
     vs.resize(lenv);
     flSetLength(adrVS, fl_ARRAY_REAL_SINGLE, lenv);
     flCopyArrayInt(&vs[0],&vst[0],lenv);//to gcc array
     flCopyArrayInt((Pointer32)(*((PInteger)adrVS)),&vst[0],lenv);//to foreval array



     lenv = vet.size();
     ve.resize(lenv);
     flSetLength(adrVE, fl_ARRAY_REAL_EXTENDED, lenv);
     flCopyArrayExtDSC(&ve[0],&vet[0],12,12,lenv);//to gcc array
     flCopyArrayExtDSC((Pointer32)(*((PInteger)adrVE)),&vet[0],12,10,lenv);//to foreval array



     #ifdef   EXTENDED_FLOAT

       lenv = vu1t.size();
       vu1.resize(lenv);
       flSetLength(adrVU1, fl_ARRAY_REAL_EXTENDED, lenv);
       flCopyArrayExtDSC(&vu1[0],&vu1t[0],12,12,lenv);
       flCopyArrayExtDSC((Pointer32)(*((PInteger)adrVU1)),&vu1t[0],12,10,lenv);

       lenv = vu2t.size();
       vu2.resize(lenv);
       flSetLength(adrVU2, fl_ARRAY_REAL_EXTENDED, lenv);
       flCopyArrayExtDSC(&vu2[0],&vu2t[0],12,12,lenv);
       flCopyArrayExtDSC((Pointer32)(*((PInteger)adrVU2)),&vu2t[0],12,10,lenv);

       lenv = vu3t.size();
       vu3.resize(lenv);
       flSetLength(adrVU3, fl_ARRAY_REAL_EXTENDED, lenv);
       flCopyArrayExtDSC(&vu3[0],&vu3t[0],12,12,lenv);
       flCopyArrayExtDSC((Pointer32)(*((PInteger)adrVU3)),&vu3t[0],12,10,lenv);

     #else

       lenv = vu1t.size();
       vu1.resize(lenv);
       flSetLength(adrVU1, fl_ARRAY_REAL_DOUBLE, lenv);
       flCopyArrayDbl(&vu1[0],&vu1t[0],lenv);
       flCopyArrayDbl((Pointer32)(*((PInteger)adrVU1)),&vu1t[0],lenv);

       lenv = vu2t.size();
       vu2.resize(lenv);
       flSetLength(adrVU2, fl_ARRAY_REAL_DOUBLE, lenv);
       flCopyArrayDbl(&vu2[0],&vu2t[0],lenv);
       flCopyArrayDbl((Pointer32)(*((PInteger)adrVU2)),&vu2t[0],lenv);

       lenv = vu3t.size();
       vu3.resize(lenv);
       flSetLength(adrVU3, fl_ARRAY_REAL_DOUBLE, lenv);
       flCopyArrayDbl(&vu3[0],&vu3t[0],lenv);
       flCopyArrayDbl((Pointer32)(*((PInteger)adrVU3)),&vu3t[0],lenv);

     #endif // EXTENDED_FLOAT

       Ptr0M1u=&M1u[0]; Ptr0M1ux=&M1ux[0]; Ptr0M1uy=&M1uy[0]; ///set new refers to arrays (for Foreval),  need after every resize of array
       Ptr0Vu1=&vu1[0];Ptr0Vu2=&vu2[0];Ptr0Vu3=&vu3[0];


}

void CopyArrayExtGF(Pointer32 psrc, Pointer32 pdest,  _int32 SZ)
{
/**
 Copy array of extended (Gcc) => array of extended (Foreval)
   In Foreval elements of array of extended are placed through throw 10 byte
   in Gcc - 12 byte.
**/
 _int32 ic;

   for(ic = 1;ic <= SZ; ic++)
   {
     /*
      *(PExtended)pdest = *(PExtended)psrc;
        psrc = psrc+12;
        pdest = pdest+10;
     */


       *PByte10(pdest) = *PByte10(psrc);  //10-sizeOf(extended)
                   //instead it:
       // *(PExtended)pdest = *(PExtended)psrc;  //10-sizeOf(extended)

        /*
         Use  this command instead *PExtended(addr) = x;
         So that in GCC, Extended type is placement in 12 bytes. And it write at once more than 10 byte - 12.
         Excess by 2 bytes in the last element results in AV!
        */

         psrc = psrc+12;
         pdest = pdest+10;
   }

};


void CopyArrayExtFG(Pointer32 psrc, Pointer32 pdest,  _int32 SZ)
{
/**
 Copy array of extended (Gcc) => array of extended (Foreval)
   In Foreval elements of array of extended are placed through throw 10 byte
   in Gcc - 12 byte.
**/
 _int32 ic;

   for(ic = 1;ic <= SZ; ic++)
   {
    *(PExtended)pdest = *(PExtended)psrc;
    psrc = psrc+10;
    pdest = pdest+12;
   }

};



TFloatType GccInt1Func(TFloatType x1)
{
 return  (A*x1+B)*(C*x1+D)/(A*x1*x1+B*x1+C);
};



TFloatType   Integral1(TFloatType a, TFloatType b)
{
Int32 k,j,n;
TFloatType int1,  x, h,  x1, x2, ax, sx ;

  int1 = 0;

  n = P_Integral-1;

  h = abs(b - a) / P_Integral ;

	 for(j = 0; j <= n; j++)
	 {
	   x1 = a + j * h ;
	   x2 = a + (j + 1) * h ;
	   ax = (x1 + x2) * 0.5 ;
	   sx = (x2 - x1) * 0.5 ;

	   for(k = 1; k <= N_Integral; k++)
	   {
         x = sx * bn[k] + ax;
         int1 = int1 + an[k] * GccInt1Func(x) * sx ;

	   }

	 }


  return int1 ;

};
















