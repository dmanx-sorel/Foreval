
#pragma once
#include "Forevaldll.h"
#include <vector>

#include <windows.h>
#include <oleauto.h>
#include <complex>
//#include <complex.h>
//#include <cmath>

using namespace std;


///**************************************************************************************************************************************



#define EXTENDED_FLOAT   ///  <- x,y,t,...: TFloatType(Extended); z1,z2,z3,...: TComplexE(Extended); z1s,z2s,z3s,...: TSTDComplexE(Extended)
                         ///         vu1,vu2,vu3: TArrayE; STACK&CONST in Foreval : Extended; All variables in functions are Extended **/
                         /// else ... - double;


 #define COMPLEX_VAR_ANY_ADDR
 /**
   Enable to  define complex var. by setting separately addresses of Re & Im part. flSetVarCx(Name,addrRe,addrIm)
   If alignment address of complex var. is not  a multiple of 16 ,  Im part is lie far from Re ,  address of Im <> address Re+16,
      may occur strong fall of performance.
  **/

//---------------------------------------------------------------------------



#ifdef   EXTENDED_FLOAT
  typedef  Extended  TFloatType;
#else
  typedef  double TFloatType;
#endif // EXTENDED_FLOAT



typedef   TFloatType  (*PTGccTestR)(void);
typedef   void  (*PTProc)(void);

typedef   std::vector<double> TArrayD ;
typedef   std::vector<Extended> TArrayE ;
typedef   std::vector<Single> TArrayS ;
typedef   std::vector<int> TArrayI ;
typedef   std::vector<BYTE> TArrayB ;
typedef   std::vector<Pointer32> TArrayP ;
typedef   std::complex<double> TSTDComplexD ;
typedef   std::complex<Extended>  TSTDComplexE ;


#ifdef   EXTENDED_FLOAT
 typedef  TArrayE  TArrayF;
  #else
 typedef  TArrayD  TArrayF;
#endif



//typedef  __float80 Extended;

#pragma pack( push ,1)


struct TComplexS
			  {
				Single re;
				Single im;
			  } ;

struct TComplexD
			  {
				double re;
				double im;
			  } ;



/*
  In Delphi TComplexE type has .RE(16 bytes) & .IM(16 bytes) . IN GCC  TComplexE type has .RE(12 bytes) & .IM(12 bytes)
  For compliance to Delphi type, need insert spacer 4byte between .RE & .IM fields.
  This work with GCC 4.9.2 version with all optimizations(O1,O2,O3), but  other versions may change size of fields or permute their;

*/

struct TComplexE
			  {
				Extended re;
				INT32  spacer1; ///alignment on 16 byte for compliance to Delphi
				Extended im;
				INT32  spacer2; ///alignment on 16 byte for compliance to Delphi
			  } ;

/*
  TByte10 using in operation copying, instead Extended type. Replace Extended type;
  So that in GCC, Extended type is placement in 12 bytes. And it write at once more than 10 byte - 12.
  Excess by 2 bytes in the last element results in AV!
*/
struct TByte10
       {
           BYTE b0;
           BYTE b1;
           BYTE b2;
           BYTE b3;
           BYTE b4;
           BYTE b5;
           BYTE b6;
           BYTE b7;
           BYTE b8;
           BYTE b9;
       };


#pragma pack( pop ,1)





typedef   std::vector<TByte10> TArrayE_10 ;
/**
  Array of Extended  in Delphi SizeOf(cell) = 10; in GCC = 12 bytes;
  For compliance with Delphi type of array <Extended> entered type array <TByte10> with

  Write to  array of type TByte10 ( val: Extended => ve10[indx] ):  *PByte10(&ve10[indx]) = *PByte10(&val)
  Read from array of type TByte10 ( ve10[indx] => val: Extended ):   val = *PExtended(&ve10[indx])
**/


typedef TByte10*     PByte10;



#ifdef   EXTENDED_FLOAT
  typedef  Extended    TFloatType;
  typedef  TComplexE   TComplex;
  typedef  TSTDComplexE   TComplexSTD;
#else
  typedef  double      TFloatType;
  typedef  TComplexD   TComplex;
  typedef  TSTDComplexD   TComplexSTD;
#endif // EXTENDED_FLOAT


typedef TComplexD*   PComplexD ;
typedef TComplexE*   PComplexE ;
typedef TFloatType*  PFloatType ;
typedef TComplex*    PComplex ;



/// *****************************************  GCC Complex Numbers Type ********************

struct   TComplexNum
{
//private:

 public:

  TFloatType re;
  TFloatType im;
  //explicit TComplexNum() {};
  //explicit TComplexNum(long double r, long double i) { re = r, im = i; }



  inline friend TComplexNum operator+(const TComplexNum &z1, const TComplexNum &z2)
  {
   TComplexNum rez;
	rez.re=z1.re+z2.re;
	rez.im=z1.im+z2.im;
	return rez;
   //return TComplexNum(z1.re+z2.re,z1.im+z2.im);
  }

  inline friend TComplexNum operator+(const TFloatType &r1, const TComplexNum &z2)
  {
   TComplexNum rez;
	rez.re=r1+z2.re;
	rez.im=z2.im;
	return rez;
   //return TComplexNum(z1.re+z2.re,z1.im+z2.im);
  }

   inline friend TComplexNum operator+(const TComplexNum &z1, const TFloatType &r2)
  {
   TComplexNum rez;
	rez.re=z1.re+r2;
	rez.im=z1.im;
	return rez;
   //return TComplexNum(z1.re+z2.re,z1.im+z2.im);
  }

   inline friend TComplexNum operator-(const TComplexNum &z1, const TComplexNum &z2)
  {
	TComplexNum res;
	res.re = z1.re - z2.re;
	res.im = z1.im - z2.im;
	return res ;
  }

   inline friend TComplexNum operator-(const TFloatType &r1, const TComplexNum &z2)
  {
   TComplexNum rez;
	rez.re=r1-z2.re;
	rez.im=-z2.im;
	return rez;
   //return TComplexNum(z1.re+z2.re,z1.im+z2.im);
  }

   inline friend TComplexNum operator-(const TComplexNum &z1, const TFloatType &r2)
  {
   TComplexNum rez;
	rez.re=z1.re-r2;
	rez.im=z1.im;
	return rez;
   //return TComplexNum(z1.re+z2.re,z1.im+z2.im);
  }

	inline friend TComplexNum operator-(const TComplexNum &z1)
  {
	TComplexNum res;
	res.re = -z1.re;
	res.im = -z1.im;
	return res ;
  }

  inline friend TComplexNum operator*(const TComplexNum &z1, const TComplexNum &z2)
	{
	TComplexNum res;
	res.re = z1.re * z2.re-z1.im * z2.im;
	res.im = z1.im * z2.re + z1.re * z2.im;
	return res ;
	}

 inline friend TComplexNum operator*(const TFloatType &r1, const TComplexNum &z2)
	{
	TComplexNum res;
	res.re = r1 * z2.re;
	res.im = r1 * z2.im;
	return res ;
	}

  inline friend TComplexNum operator*(const TComplexNum &z1, const TFloatType &r2)
	{
	TComplexNum res;
	res.re = r2 * z1.re;
	res.im = r2 * z1.im;
	return res ;
	}


  inline friend TComplexNum operator/(const TComplexNum &z1, const TComplexNum &z2)
	{
	TComplexNum res;
	TFloatType t;

	t = 1/(z2.re*z2.re+z2.im*z2.im);
	res.re = (z1.re*z2.re+z1.im*z2.im)*t;
	res.im = (z1.im*z2.re-z1.re*z2.im)*t;

	return res ;

	}


	inline friend TComplexNum operator/(const TFloatType &r1, const TComplexNum &z2)
	{
	TComplexNum res;
	TFloatType t;

	t = 1/(z2.re*z2.re+z2.im*z2.im);
	res.re = r1*z2.re*t;
	res.im = -r1*z2.im*t;
	return res ;
	}


	inline friend TComplexNum operator/(const TComplexNum &z1, const TFloatType &r2)
	{
	TComplexNum res;
	TFloatType t;

	t = 1/r2;
	res.re = z1.re*t;
	res.im = z1.im*t;
	return res ;
	}
};



 TFloatType Re(  TComplexNum z1)
{
  return z1.re;
};


 TFloatType Im( TComplexNum z1)
{
  return z1.im;
};


/// ************** WARNING! **********************
/*

 If using proc., with complex  variables  passed  through  addresses, then passed and setted  type of variables  must be appropriate.


 I.e. proc. kind of  proc(TComplex& z1,..., TComplex& zn)  ;

    then complex type in proc. and setted for these variables  by flSet() must be identical!

    For this purpose,  introduced type - TComplexF.
    that ñombines the types of variables and transmitted through addresses to procedures in one type.
    Depends from key 'COMPLEX_VAR_ANY_ADDR'

 */

#ifdef   COMPLEX_VAR_ANY_ADDR
 typedef  TComplexNum  TComplexF;
  #else
 typedef  TComplex  TComplexF;
#endif

typedef  TComplexF*   PComplexF;






