
/**
                     Examples for Foreval.dll v.9.1.1
**/

/**
           Very stupid inline assembler. :(. If you can, rewrite asm. insertion in procedures self (more higher speed). My excuse.
**/


#pragma once
#include "Forevaldll.h"
#include "Types.h"

 long double const c_pi = 3.14159265358979323846264338327950288419716939937510582097494459230781640628620899863;


  TFloatType    an[16],bn[16];
  _int32        P_Integral,N_Integral;



  TArrayF  CFid;
  void InitCFid(_int32 lenv);

  PFloatType PVX, PVY, PVT;
  PComplexF  PVZ1,PVZ2,PVZ3, PRESF;


  inline TFloatType sqr(TFloatType x);

  void InitRealPointerVar(PFloatType px, PFloatType py, PFloatType pt);
  void InitComplexPointerVar(PComplexF pz1, PComplexF pz2, PComplexF pz3);
  void InitGlobalResPointerVar(PComplexF presf);

  void InitIntegral(void);
  TFloatType  _stdcall  Integral3FF(Pointer32 Func, Pointer32 PV1 , Pointer32 PV2, Pointer32 PV3, TFloatType a, TFloatType b , Pointer32 Func1, Pointer32 Func2, Pointer32 Func3, Pointer32 Func4);
  TFloatType  _stdcall  Integral3(Pointer32 Func, Pointer32 PV1 , Pointer32 PV2, Pointer32 PV3, TFloatType a, TFloatType b , TFloatType c, TFloatType d, TFloatType e, TFloatType f);
  TFloatType  _stdcall  Integral1(Pointer32 Func, Pointer32 PV1 ,/* _int32 RType,*/  TFloatType a, TFloatType b);


///************************************************************************************************************************************


void InitRealPointerVar(PFloatType px, PFloatType py, PFloatType pt)
{
    PVX = px; PVY = py; PVT = pt;
};


void InitComplexPointerVar(Pointer32 pz1, Pointer32 pz2, Pointer32 pz3)
{
    PVZ1 = (PComplexF)pz1; PVZ2 = (PComplexF)pz2; PVZ3 = (PComplexF)pz3;
};


void InitGlobalResPointerVar(PComplexF presf)
{
    PRESF = presf;
};



inline TFloatType sqr(TFloatType x)
{
  return x*x;
};


void InitCFid(_int32 lenv)
{
    CFid.resize(lenv+1);
    CFid[1] = 1.0; CFid[2] = 2.0; CFid[3] = 3.0; CFid[4] = 4.0;
};





TFloatType  _cdecl SP1(TFloatType x1)
{
 return  x1*x1;
};


TFloatType  _stdcall SP2(TFloatType x1, TFloatType x2)
{
 return  x1-x2;
};


TFloatType _cdecl SP3(TFloatType x1, TFloatType x2, TFloatType x3)
{
 return  x1+x2-x3;
};



TFloatType _cdecl SP8(_int32 vx , _int32 nx ,Extended x ,_int32 vd, _int32 nd, double d,  _int32 vi, _int32 ni)
{

//sp8(TArrayE vx, Int32 nx, Extended x, TArrayD vd, Int32 nd, double d,  TArrayI vi, Int32 ni) = (vx[nx]*x-vd[nd]*d)*vi[ni]

//sp8(ve,n,x,vd,k,y,vi,j) = (ve[n]*x - vd[k]*d)*vi[j]

//sp8(ve,n+3,x*t,vd,j+k,x-y,vi,n+k+j)

  double    fvd;
 Extended   fvx;
 __int32    fvi;

/*
 fvx=*PExtended(vx+nx*10);  //vx[nx]
 fvd=*PDouble(vd+nd*8);  //vd[nd]
 fvi=*PInteger(vi+ni*4); //vi[ni]

 return (fvx*x-fvd*d)*fvi;
*/
return ((*PExtended(vx+nx*10))*x-(*PDouble(vd+nd*8))*d)*(*PInteger(vi+ni*4));

}




void _cdecl SP8Z(_int32 vx , _int32 nx ,TComplexE z1 ,_int32 vd, _int32 nd, TComplexD z2,  _int32 vi, _int32 ni)
{
 double    fvd;
 Extended  fvx;
 __int32   fvi;
 TComplex rez;

 /*
 fvx=*PExtended(vx+nx*10);  //vx[nx]
 fvd=*PDouble(vd+nd*8);  //vd[nd]
 fvi=*PInteger(vi+ni*4); //vi[ni]

return (fvx*z1-fvd*z2)*fvi;
*/
 rez.re =  ((*PExtended(vx+nx*10))*z1.re-(*PDouble(vd+nd*8))*z2.re)*(*PInteger(vi+ni*4));
 rez.im =  ((*PExtended(vx+nx*10))*z1.im-(*PDouble(vd+nd*8))*z2.im)*(*PInteger(vi+ni*4));



#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}




TFloatType _cdecl PS8(_int32 &vx , _int32 &nx ,Extended &x ,_int32 &vd, _int32 &nd, double &d,  _int32 &vi, _int32 &ni)
{
 double    fvd;
 Extended  fvx;
 __int32   fvi;

 /*
 fvx=*PExtended(vx+nx*10);  //vx[nx]
 fvd=*PDouble(vd+nd*8);  //vd[nd]
 fvi=*PInteger(vi+ni*4); //vi[ni]

return (fvx*x-fvd*d)*fvi;
*/
return ((*PExtended(vx+nx*10))*x-(*PDouble(vd+nd*8))*d)*(*PInteger(vi+ni*4));

}




void _cdecl PS8Z(_int32 &vx , _int32 &nx ,TComplexE &z1 ,_int32 &vd, _int32 &nd, TComplexD &z2,  _int32 &vi, _int32 &ni)
{
 double    fvd;
 Extended  fvx;
 __int32   fvi;
 TComplex rez;

 /*
 fvx=*PExtended(vx+nx*10);  //vx[nx]
 fvd=*PDouble(vd+nd*8);  //vd[nd]
 fvi=*PInteger(vi+ni*4); //vi[ni]

return (fvx*z1-fvd*z2)*fvi;
*/
 rez.re =  ((*PExtended(vx+nx*10))*z1.re-(*PDouble(vd+nd*8))*z2.re)*(*PInteger(vi+ni*4));
 rez.im =  ((*PExtended(vx+nx*10))*z1.im-(*PDouble(vd+nd*8))*z2.im)*(*PInteger(vi+ni*4));



#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}




TFloatType _cdecl MS8(_int32 addr)
{
//ms8(vx,nx,x,vd,nd,d,vi,ni) = (vx[nx]*x-vd[nd]*d)*vd[ni])

  //vx: array of extended;
  //vd: array of double;
  //vi: array of integer;
  //d:  double;
  //nd,ni: integer;

  //vx[nx]  =  (*PExtended(*PInteger(addr)+(*PInteger(addr+16))*10))      //10 -sizeof(extended)
  //x       =  (*PExtended(addr+32))
  //vd[nd]  =  (*PDouble(*PInteger(addr+48)+(*PInteger(addr+64))*8))
  //d       =  (*PDouble(addr+80))
  //vi[ni]  =  (*PInteger(*PInteger(addr+96)+(*PInteger(addr+112))*4))  //4 -sizeof(int)





return ( (*PExtended(*PInteger(addr)+(*PInteger(addr+16))*10))*(*PExtended(addr+32)) - (*PDouble(*PInteger(addr+48)+(*PInteger(addr+64))*8))*(*PDouble(addr+80)))*(*PInteger(*PInteger(addr+96)+(*PInteger(addr+112))*4));


}





void  _cdecl SP1Z(TComplex z1)
{
TFloatType re,im;
TComplex rez;

 rez.re=z1.re*z1.re-z1.im*z1.im;
 rez.im=2*z1.re*z1.im;
 /*
 _asm
 {
   //fld qword ptr [rez+8]
   //fld qword ptr [rez]
	 fld qword ptr [rez.im]
     fld qword ptr [rez.re]
 }
 */

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}



void  _cdecl SP2Z(TComplex z1,TComplex z2)
{
TFloatType re,im;
TComplex rez;

 rez.re=z1.re-z2.re;
 rez.im=z1.im-z2.im;



#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}




void  _stdcall SP3Z(TComplex z1, TComplex z2, TComplex z3)
{
TFloatType re,im;
TComplex rez;

 rez.re=z1.re+z2.re-z3.re;
 rez.im=z1.im+z2.im-z3.im;

/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}





void  _cdecl SP2ZR(TComplex z1, TFloatType x)
{
//double re,im;
TComplex rez;

 rez.re=z1.re-x;
 rez.im=z1.im;

/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
 */

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}



void  _cdecl SP2RZ(TFloatType x, TComplex z2)
{
TFloatType re,im;
TComplex rez;

 rez.re=x-z2.re;
 rez.im=-z2.im;
/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}



void  _stdcall SP3ZRZ(TComplex z1, TFloatType x2, TComplex z3)
{
 TFloatType re,im;
 TComplex rez;

 rez.re=z1.re+x2-z3.re;
 rez.im=z1.im-z3.im;
/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}



void  _stdcall SP3RZR(TFloatType x1, TComplex z2,  TFloatType x3)
{
 TFloatType re,im;
 TComplex rez;

 rez.re=x1+z2.re-x3;
 rez.im=z2.im;

/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}





TFloatType  _cdecl PS1(TFloatType *x1)
{
 return  (*x1)*(*x1);
}


TFloatType  _cdecl PS2(TFloatType *x1,TFloatType *x2)
{
 return  (*x1)-(*x2);
}


TFloatType _stdcall PS3(TFloatType *x1, TFloatType *x2, TFloatType *x3)
{
 return  (*x1)+(*x2)-(*x3);
}




void  _cdecl PS1Z(TComplex *z1)
{
TFloatType re,im;
TComplex rez;

 rez.re=(*z1).re*(*z1).re-(*z1).im*(*z1).im;
 rez.im=2*(*z1).re*(*z1).im;
/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }

*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}



void  _cdecl PS2Z(TComplex *z1,TComplex *z2)
{
TFloatType re,im;
TComplex rez;

 rez.re=(*z1).re-(*z2).re;
 rez.im=(*z1).im-(*z2).im;
/*
_asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}



void  _stdcall PS3Z(TComplex *z1, TComplex *z2, TComplex *z3)
{
double re,im;
TComplex rez;

 rez.re=(*z1).re+(*z2).re-(*z3).re;
 rez.im=(*z1).im+(*z2).im-(*z3).im;
/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}



void  _stdcall PS3ZRZ(TComplex &z1, TFloatType &x2, TComplex &z3)
{
 TFloatType re,im;
 TComplex rez;

 rez.re=z1.re+x2-z3.re;
 rez.im=z1.im-z3.im;
/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}



void  _stdcall PS3RZR(TFloatType &x1, TComplex &z2,  TFloatType &x3)
{
 TFloatType re,im;
 TComplex rez;

 rez.re=x1+z2.re-x3;
 rez.im=z2.im;

/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}




void  _cdecl PS2ZR(TComplex *z1, TFloatType *x)
{
TFloatType re,im;
TComplex rez;

 rez.re=(*z1).re-(*x);
 rez.im=(*z1).im;
/*
_asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}



void  _cdecl PS2RZ(TFloatType *x,TComplex *z2)
{
TFloatType re,im;
TComplex rez;

 rez.re=(*x)-(*z2).re;
 rez.im=-(*z2).im;
/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}



TFloatType  _cdecl MS1(_int32 addr)
{
 return  (*PFloatType(addr))*(*PFloatType(addr));
}



TFloatType  _cdecl MS2(_int32 addr)
{
 return  (*PFloatType(addr))-(*PFloatType(addr+16));
}



TFloatType  _cdecl MS3(_int32 addr)
{
 return  (*PFloatType(addr))+(*PFloatType(addr+16))-(*PFloatType(addr+32));
}





void  _cdecl MS1Z(_int32 addr)
{
TFloatType re,im;
TComplex rez;

/*
#ifdef   EXTENDED_FLOAT
  rez.re=(*PExtended(addr))*(*PExtended(addr))-(*PExtended(addr+16))*(*PExtended(addr+16));
  rez.im=2*(*PExtended(addr))*(*PExtended(addr+16));
#else
  rez.re=(*PDouble(addr))*(*PDouble(addr))-(*PDouble(addr+16))*(*PDouble(addr+16));
  rez.im=2*(*PDouble(addr))*(*PDouble(addr+16));
#endif
*/

  rez.re=(*PFloatType(addr))*(*PFloatType(addr))-(*PFloatType(addr+16))*(*PFloatType(addr+16));
  rez.im=2*(*PFloatType(addr))*(*PFloatType(addr+16));

 /*
_asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}



void  _cdecl MS2Z(_int32 addr)
{
TFloatType re,im;
TComplex rez;

/*
#ifdef   EXTENDED_FLOAT
   rez.re=(*PExtended(addr))-(*PExtended(addr+32));
   rez.im=(*PExtended(addr+16))-(*PExtended(addr+48));
#else
   rez.re=(*PDouble(addr))-(*PDouble(addr+32));
   rez.im=(*PDouble(addr+16))-(*PDouble(addr+48));
#endif
*/

rez.re=(*PFloatType(addr))-(*PFloatType(addr+32));
rez.im=(*PFloatType(addr+16))-(*PFloatType(addr+48));



/*
_asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}


void  _cdecl MS3Z(_int32 addr)
{
TFloatType re,im;
TComplex rez;

/*
#ifdef   EXTENDED_FLOAT
  rez.re=(*PExtended(addr))+(*PExtended(addr+32))-(*PExtended(addr+64));
  rez.im=(*PExtended(addr+16))+(*PExtended(addr+48))-(*PExtended(addr+80));
#else
  rez.re=(*PDouble(addr))+(*PDouble(addr+32))-(*PDouble(addr+64));
  rez.im=(*PDouble(addr+16))+(*PDouble(addr+48))-(*PDouble(addr+80));
#endif
*/

rez.re=(*PFloatType(addr))+(*PFloatType(addr+32))-(*PFloatType(addr+64));
rez.im=(*PFloatType(addr+16))+(*PFloatType(addr+48))-(*PFloatType(addr+80));



/*
_asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}


//z1+x2-z3
void  _cdecl MS3ZRZ(_int32 addr)
{
TFloatType re,im;
TComplex rez;

             //z1.re            //x2                  //z3.re
rez.re=(*PFloatType(addr))+(*PFloatType(addr+32))-(*PFloatType(addr+48));
                //z1.im             //z3.im
rez.im=(*PFloatType(addr+16))-(*PFloatType(addr+64));


#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}




//x1+z2-x3
void  _cdecl MS3RZR(_int32 addr)
{
TFloatType re,im;
TComplex rez;

            //x1                //z2.re              //x3
rez.re=(*PFloatType(addr))+(*PFloatType(addr+16))-(*PFloatType(addr+48));
             //z2.im
rez.im=(*PFloatType(addr+32));



#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}





void  _cdecl MS2ZR(_int32 addr)
{
TFloatType re,im;
TComplex rez;

/*
#ifdef   EXTENDED_FLOAT
   rez.re=(*PExtended(addr))-(*PExtended(addr+32));
   rez.im=(*PExtended(addr+16));
#else
   rez.re=(*PDouble(addr))-(*PDouble(addr+32));
   rez.im=(*PDouble(addr+16));
#endif
*/

rez.re=(*PFloatType(addr))-(*PFloatType(addr+32));
rez.im=(*PFloatType(addr+16));


/*
_asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}



void  _cdecl MS2RZ(_int32 addr)
{
TFloatType re,im;
TComplex rez;

/*
#ifdef   EXTENDED_FLOAT
   rez.re=(*PExtended(addr))-(*PExtended(addr+16));
   rez.im=-(*PExtended(addr+32));
#else
   rez.re=(*PDouble(addr))-(*PDouble(addr+16));
   rez.im=-(*PDouble(addr+32));
#endif
*/

rez.re=(*PFloatType(addr))-(*PFloatType(addr+16));
rez.im=-(*PFloatType(addr+32));


/*
_asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}







//infsum(z1,z2,z3,z3-z2,z2-z1,z1*z2)
void _cdecl SUMZ(__int32 addr, __int32 len)
{
 __int32 N,ni;
 TComplex Sz;
 TFloatType re,im;


  Sz.re=0; Sz.im=0;
  //re=0; im=0;
  for (ni = 0; ni <= len-1; ni++)
  {
   Sz.re=Sz.re+(*PFloatType(addr+32*ni));
   Sz.im=Sz.im+(*PFloatType(addr+32*ni+16));
   }




#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&Sz);
#else
  flLoadFPUDP(&Sz);
#endif

}



//infsum(x,y,t,x-y-infsum(x,y,t,x*y),t*x)
TFloatType _cdecl SUMR(__int32 addr, __int32 len)
{
 __int32 N,ni;
 TFloatType S;

  S=0;
  for (ni = 0; ni <= len-1; ni++)
  {
   S=S+(*PFloatType(addr+16*ni));
  }

 return S;
}



//spall(ve,n+3,z1,vd,j+k,x,z2+z3,t-y,vi,n+k+j)
void _cdecl SPALL(__int32 vx, __int32 nx, TComplexE zx, __int32 vd, __int32 nd, double d, TComplexD zd, Extended x, __int32 vi, __int32 ni)
//void _cdecl spall(Pointer32 vx, __int32 nx, TComplexE zx, Pointer32 vd, __int32 nd, double d, TComplexD zd, Extended x, Pointer32 vi, __int32 ni)
{
//rez=(vx[nx]*d*zd - vd[nd]*x*zx)*vi[ni]
//spall(vx,nx,zx,vd,nd,d,zd,x,vi,ni) = (vx[nx]*d*zd - vx[nx]*x*zx)*vi[ni]
/*
  vd: array of double;
  vx: array of Extended;
  vi: array of integer;
  d: double;
  x: Extended;
  nd,nx,ni: integer;
  zd: TComplexD;
  zx: TComplexE;
*/
 TComplex rez;
 //spall(ve,n+3,z1,vd,j+k,x,z2+z3,t-y,vi,n+k+j)


 Extended fvx;
 double  fvd;
 __int32  fvi,adr1;


 fvx=*PExtended(vx+nx*10);  //vx[nx]
 fvd=*PDouble(vd+nd*8);  //vd[nd]
 fvi=*PInteger(vi+ni*4); //vi[ni]

 rez.re=(fvd*d*zd.re-fvx*x*zx.re)*fvi;
 rez.im=(fvd*d*zd.im-fvx*x*zx.im)*fvi;

 /*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}




void _cdecl PSALL(__int32 *vx, __int32 *nx, TComplexE *zx, __int32 *vd, __int32 *nd, double *d, TComplexD *zd, Extended *x, __int32 *vi, __int32 *ni)
{
//rez=(vx[nd]*d*zd - vd[nx]*x*zx)*vi[ni]
//psall(ve,n,z1,vd,k,y,z2,x,vi,j) = (ve[k]*y*z2 - vd[n]*x*z1)*vi[ni]
/*
  vd: array of double;
  vx: array of Extended;
  vi: array of integer;
  d: double;
  x: Extended;
  nd,nx,ni: integer;
  zd: TComplexD;
  zx: TComplexE;
*/
 TComplex rez;
 //psall(ve,n+3,z1,vd,j+k,x,z2+z3,t-y,vi,n+k+j)


 Extended fvx;
 double   fvd;
 __int32  fni,fnd,fnx,fvi;


 fvx=*PExtended((*vx)+(*nx)*10);  //vx[nx]
 fvd=*PDouble((*vd)+(*nd)*8);     //vd[nd]
 fvi=*PInteger((*vi)+(*ni)*4);    //vi[ni]

 rez.re=(fvd*(*d)*(*zd).re-fvx*(*x)*(*zx).re)*fvi;
 rez.im=(fvd*(*d)*(*zd).im-fvx*(*x)*(*zx).im)*fvi;




 /*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/

#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}



//msall(ve,n+3,z1,vd,j+k,x,z2+z3,t-y,vi,n+k+j)
void _cdecl MSALL(__int32 addr)
{
  //msall(vx,nx,zd,vd2,nd,d,zx,x,vi,ni) = (vx[nd]*d*zd - vd2[nx]*x*zx)*vi[ni]
 TComplex rez;

 double vd,d;
 Extended vx,x;
 INT32 nx,nd,ni,vi;
 TComplexD zd;
 TComplexE zx;

 /*
  vd: array of double;
  vx: array of Extended;
  vi: array of integer;
  d: double;
  x: Extended;
  nd,nx,ni: integer;
  zd: TComplexD;
  zx: TComplexE;
*/


/*
   nx = *PInteger(addr+16);
  //vx[nx] = (*PArrayE(addr))[(*PInteger(addr+16))]       =    (*PExtended(*PInteger(addr)+(*PInteger(addr+16))*10));   //*10 - SizeOf(Extended)
  //zx.re =  (*PExtended(addr+32));
  //zx.im =  (*PExtended(addr+48));
   nd = *PInteger(addr+80);
  //vd[nd] = (*PArrayD(addr+64))[(*PInteger(addr+80))]    =   (*PDouble(*PInteger(addr+64)+(*PInteger(addr+80))*8));    //*8 - SizeOf(Double)
  //d =      (*PDouble(addr+96));
  //zd.re =  (*PDouble(addr+112));
  //zd.im =  (*PDouble(addr+128));
  //x =      (*PExtended(addr+144));
    ni = *PInteger(addr+176);
  //vi[ni] = (*PArrayI(addr+160))[(*PInteger(addr+176))]   = (*PInteger(*PInteger(addr+160)+(*PInteger(addr+176))*4));  //*4 - SizeOf(Integer)
*/

/*
   //nx =     (*PInteger(addr+16));
   vx =     (*PExtended(*PInteger(addr)+(*PInteger(addr+16))*10));
   zx.re =  (*PExtended(addr+32));
   zx.im =  (*PExtended(addr+48));
   //nd    =  (*PInteger(addr+80));
   vd   =   (*PDouble(*PInteger(addr+64)+(*PInteger(addr+80))*8));
   d =      (*PDouble(addr+96));
   zd.re =  (*PDouble(addr+112));
   zd.im =  (*PDouble(addr+128));
   x =      (*PExtended(addr+144));
   //ni =     (*PInteger(addr+176));
   vi     = (*PInteger(*PInteger(addr+160)+(*PInteger(addr+176))*4));

 rez.re=(vd*d*zd.re-vx*x*zx.re)*vi;
 rez.im=(vd*d*zd.im-vx*x*zx.im)*vi;
*/


rez.re  =  ((*PDouble(*PInteger(addr+64)+(*PInteger(addr+80))*8))*(*PDouble(addr+96))*(*PDouble(addr+112))-(*PExtended(*PInteger(addr)+(*PInteger(addr+16))*10))*(*PExtended(addr+144))*(*PExtended(addr+32)))*(*PInteger(*PInteger(addr+160)+(*PInteger(addr+176))*4));
rez.im  =  ((*PDouble(*PInteger(addr+64)+(*PInteger(addr+80))*8))*(*PDouble(addr+96))*(*PDouble(addr+128))-(*PExtended(*PInteger(addr)+(*PInteger(addr+16))*10))*(*PExtended(addr+144))*(*PExtended(addr+48)))*(*PInteger(*PInteger(addr+160)+(*PInteger(addr+176))*4));


/*
 _asm
 {
  fld qword ptr [rez.im]
  fld qword ptr [rez.re]
 }
*/
#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
}




TFloatType _stdcall SP0(void)
{
    //TFloatType res = 123.456789;
    return 123.456789;
};




void _stdcall SP0Z(void)
{
TComplex rez;

rez.re = 321.98765;
rez.im = 456.789123;
#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

}




TFloatType _cdecl  PS0(void)
{
  return  123.456789;
};



void _cdecl PS0Z(void)
{
TComplex rez;

rez.re = 321.98765;
rez.im = 456.789123;
#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif

};





TFloatType _stdcall FOVRL_(void)
{
 return (c_pi*c_pi);
};


TFloatType _stdcall FOVRL_R(TFloatType r)
{
 return r*r;
};


void  _cdecl FOVRL_CX(TComplex *z)
{
TFloatType re,im;
TComplex rez;

 rez.re=(*z).re*(*z).re-(*z).im*(*z).im;
 rez.im=2*(*z).re*(*z).im;


#ifdef   EXTENDED_FLOAT
  flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
#else
  flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);
#endif
};



TFloatType _cdecl FOVRL_V(__int32 vu, __int32 nu)
{

 TFloatType fvu;

 #ifdef   EXTENDED_FLOAT
   fvu=*PExtended(vu+nu*10);  //vu[nu]
   //flGetArrayValueE((Pointer32)(&vu), nu, fvu);
 #else
   fvu=*PDouble(vu+nu*8);   //vu[nu]
   //flGetArrayValueD((Pointer32)(&vu), nu, fvu);
 #endif

  return fvu*fvu;
};





/// FillArrayD(VD): VD[all]=x
void _cdecl FillArrayD(_int32 adrVD , double x)
{
 _int32 lenV;
 _int32 adrVD0,tmp;
 _int32 ni,i;
 PInteger pi1;
 Pointer32 pvd0;



/// ******************* 1 - slow way ******************************


/**
  flGet(fl_ARRAY_LENGTH, (_int32)(&adrVD), lenV);

    for(ni = 0; ni <= lenV-1; ni++)
	{
       flSetArrayValueD((Pointer32)(&adrVD), ni, x);
	}
**/

//***************************************************************


/// *********************2 - much fast ******************************



  if (adrVD != 0)
     {
		adrVD0=*PInteger(&adrVD);  //adrVD0=@vd[0] ; address of address !!!

       //pi1=PInteger(adrVD);
       //pi1=pi1-1;
       //lenV=*pi1;


	  lenV=*PInteger((PInteger(adrVD)-1));
	  /// lenV=lenV+1;  // <- if Foreval compiled in FPC !!!
	  if (DLLCompiledBy == Lazarus ) { lenV=lenV+1;};

     }
  else
     {lenV=0;};

  for(ni = 0; ni <= lenV-1; ni++)
	{
       *PDouble(adrVD0 + ni * 8) = x;  //8-sizeOf(double)
	}



//***************************************************************


/// ******************3 - most fast *******************************
/*
  _asm
  {
 	push eax
 	push ecx
 	push edx


   mov eax, dword Ptr [adrVD]
   cmp eax, 0
   jz  endp

   mov edx, dword Ptr [eax-4]  // <- Len
   /// add edx,1               // <- edx+1 if Foreval compiled in FPC !!!!!!
   fld qword Ptr [x]
   Xor ecx, ecx

   ckl:
   fst qword Ptr [eax+8*ecx]   // <- 8 as double
   inc ecx
   cmp ecx, edx
   jnz ckl

   fstp st(0)

   endp:
   pop  edx
   pop  ecx
   pop  eax

  }
*/

//*************************************************************************

};



/// FillArrayE(VE): VE[all]=x
void _cdecl FillArrayE(_int32 adrVE , Extended x)
{
 _int32 lenV;
 _int32 adrVE0,tmp;
 _int32 ni,i;
 PInteger pi1;
 Pointer32 pvd0;



/// ******************* 1 way - slow, but more reliable and safe ******************************

/*
  flGet(fl_ARRAY_LENGTH, (_int32)(&adrVE), lenV);

    for(ni = 0; ni <= lenV-1; ni++)
	{
       flSetArrayValueE((Pointer32)(&adrVE), ni, x);
	}
*/

//****************************************************************


/// *********************2 way - much fast ******************************


  if (adrVE != 0)
     {
		adrVE0=*PInteger(&adrVE);  //adrVE0=@ve[0] ; address of address !!!

       //pi1=PInteger(adrVE);
       //pi1=pi1-1;
       //lenV=*pi1;


	  lenV=*PInteger((PInteger(adrVE)-1));
	  /// lenV=lenV+1;  // <- if Foreval compiled in FPC !!!
      if (DLLCompiledBy == Lazarus ) { lenV=lenV+1;};

     }
  else
     {lenV=0;};

  for(ni = 0; ni <= lenV-1; ni++)
	{

    //*PExtended(adrVE0 + ni * 10) = x;  // 10-sizeOf(extended)
      *PByte10(adrVE0 + ni * 10) = *PByte10(&x); // 10-sizeOf(extended)
      /*
        Use  this command instead *PExtended(adrVE0 + ni * 10) = x;
        So that in GCC, Extended type is placement in 12 bytes. And it write at once more than 10 byte - 12.
        Excess by 2 bytes in the last element results in AV!
      */

	}




//***************************************************************


/// ******************3 way - most fast *******************************
///** See FillArrayD .
/*
  _asm
  {

  }
*/

//*************************************************************************

};






/// FillArrayI(VI): VI[all]=n
void _cdecl FillArrayI(_int32 adrVI , _int32 n)
{
 _int32 lenV;
 _int32 adrVI0,tmp;
 _int32 ni,i;
 PInteger pi1;
 Pointer32 pvd0;



/// ******************* 1 - slow way ******************************


/**
  flGet(fl_ARRAY_LENGTH, (_int32)(&adrVI), lenV);

    for(ni = 0; ni <= lenV-1; ni++)
	{
       flSetArrayValueI((Pointer32)(&adrVI), ni, n);
	}
**/

//***************************************************************


/// *********************2 - much fast ******************************



  if (adrVI != 0)
     {
		adrVI0=*PInteger(&adrVI);  //adrVI0=@vi[0] ; address of address !!!

       //pi1=PInteger(adrVI);
       //pi1=pi1-1;
       //lenV=*pi1;


	  lenV=*PInteger((PInteger(adrVI)-1));
	  /// lenV=lenV+1;  // <- if Foreval compiled in FPC !!!
      if (DLLCompiledBy == Lazarus ) { lenV=lenV+1;};

     }
  else
     {lenV=0;};

  for(ni = 0; ni <= lenV-1; ni++)
	{
       *PInteger(adrVI0 + ni * 4) = n;  //4-sizeOf(double)
	}



};

TFloatType _cdecl gccSumVd(TArrayD vd )
{
  _int32 lenv,ni;
  TFloatType s;

  lenv = vd.size();
  s = 0;
  for(ni = 0; ni <= lenv-1; ni++)
	{
       s = s + vd[ni];
	}

  return s;
}



TFloatType _cdecl gccSumVe(TArrayE ve )
{
  _int32 lenv,ni;
  TFloatType s;

  lenv = ve.size();
  s = 0;
  for(ni = 0; ni <= lenv-1; ni++)
	{
       s = s + ve[ni];
	}

  return s;
}




TFloatType _cdecl gccSumVi(TArrayI vi )
{
  _int32 lenv,ni;
  TFloatType s;

  lenv = vi.size();
  s = 0;
  for(ni = 0; ni <= lenv-1; ni++)
	{
       s = s + vi[ni];
	}

  return s;
}


TFloatType _stdcall idfunc(TFloatType x,  _int32 ID)
{
 if (ID == 1) {return sin(x);} else
   if (ID == 2)  {return cos(x);} ;
};




//  idFncCF(z1,x,vd,n,id) = z*vf[n]*x*CFid[id];
void _stdcall idFncCF(TComplex *z, TFloatType *x, _int32 *vf, _int32 *n, _int32 ID)
{
 TFloatType re,im,fvx,mp;
 TComplex rez;
 _int32 nv,idv;
 TFloatType xr,xi;


 #ifdef   EXTENDED_FLOAT
   fvx=*PExtended((*vf)+(*n)*10);
 #else
   fvx=*PDouble((*vf)+(*n)*8);
 #endif




   mp = fvx*(*x)*CFid[ID];
   rez.re = (*z).re*mp;
   rez.im = (*z).im*mp;



 #ifdef   EXTENDED_FLOAT
   flLoadFPUEP(&rez);
 //flLoadFPUE(rez.re,rez.im);
 #else
  flLoadFPUDP(&rez);
  //flLoadFPUD(rez.re,rez.im);
 #endif
};


//spproc2r(x,y,@t); t
void _stdcall spproc2r( TFloatType x,  TFloatType y,   TFloatType& res)
{
 res = x+y;
};




/**
 ---------------------------------------------------------------------------------------
      Functions and Procedures with arguments given as addresses of variables
  ---------------------------------------------------------------------------------------

                                          WARNING!
 If  complex value passed on address @CXVar in Proc&Func , then it has type TComplexF. See comments in 'Types.h'

**/



//spproc2c(z1,z2,@z3); z3
//spproc2c(2*z1+z2,3*z2*z1,@z3); z3
void _stdcall spproc2c( TComplex z1, TComplex z2,  TComplexF& res)
 /// return :  res=z1+z2
{
 res.re=z1.re+z2.re;
 res.im=z1.im+z2.im;
};




//spprocswpinc2r(@x,@y)=x+y; (x=y+1; y=x+1)
TFloatType _stdcall spprocswpinc2r(PFloatType px, PFloatType py)
{
 /// return: x+y;  x=y+1; y=x+1

 TFloatType t;


 t = (*px);
 *px = (*py)+1;
 *py = t+1;

 return (*px)+(*py);
};



//spprocswpinc2c(@z1,@z2)=z1+z2; (z1=2*z2+2+2i; z2=3*z1+3+3i)
void _stdcall  spprocswpinc2c(PComplexF pz1, PComplexF pz2)
{
/// return: z1+z2;  z1=2*z2+2+2i; z2=3*z1+3+3i

 TComplex Sz,tz;


 Sz.re = (*pz1).re+(*pz2).re;
 Sz.im = (*pz1).im+(*pz2).im;

 tz.re = (*pz1).re;
 tz.im = (*pz1).im;

 (*pz1).re = 2*(*pz2).re+2;
 (*pz1).im = 2*(*pz2).im+2;

 (*pz2).re = 3*tz.re+3;
 (*pz2).im = 3*tz.im+3;



 #ifdef   EXTENDED_FLOAT
   flLoadFPUEP(&Sz);
 //flLoadFPUE(Sz.re,Sz.im);
 #else
  flLoadFPUDP(&Sz);
  //flLoadFPUD(Sz.re,Sz.im);
 #endif

}




//spprocsqr2(@x,@z1); (x=x^2; z1=z1^2)
void _stdcall  spprocsqr2(TFloatType& x,  TComplexF& z)
{
/// return: x=x^2; z1=z1^2

 TFloatType t;


 x=sqr(x);

 t=z.re;
 z.re=sqr(z.re)-sqr(z.im);
 z.im=2*t*z.im;

}




//spprocsumall(2*x+1, 3*y+2, n+k, 2*j*k, 2*z1, 5*z1+z2, vu1, vu2, @s, @m, @z5, @vu3);
void _stdcall   spprocsumall(TFloatType x, TFloatType y, _int32 n1, _int32 n2,  TComplex z1, TComplex z2,  _int32 vu1,  _int32 vu2,    TFloatType& ResR,  _int32& ResI, TComplexF& ResC, _int32& ResV)
{
   /// return :  ResR=x+y; ResC=z1+z2; ResI=n1+n2; ResV=vu1+vu2

_int32      lenV,ni,adrResV;
TFloatType  fvx1,fvx2;


 ResR=x+y;
 ResI=n1+n2;
 ResC.re=z1.re+z2.re;
 ResC.im=z1.im+z2.im;



 /**       sum arrays ResV=vu1+vu2           **/

/// ******************* 1 - slow standard way ******************************


  flGet(fl_ARRAY_LENGTH, (_int32)(&vu1), lenV); //= Length vu1, vu2, ResV !!!

  for(ni = 0; ni <= lenV-1; ni++)
  {


        #ifdef   EXTENDED_FLOAT
            fvx1=*PFloatType(vu1+ni*10);
            fvx2=*PFloatType(vu2+ni*10);
            flSetArrayValueE((Pointer32)(&ResV), ni, fvx1+fvx2);
        #else
            fvx1=*PFloatType(vu1+ni*8);
            fvx2=*PFloatType(vu2+ni*8);
            flSetArrayValueD((Pointer32)(&ResV), ni, fvx1+fvx2);
        #endif

  }




/// *********************2 way - much fast ******************************

/**

		adrResV=*PInteger(&ResV);

       //pi1=PInteger(ResV);
       //pi1=pi1-1;
       //lenV=*pi1;


	  lenV=*PInteger((PInteger(adrResV)-1));  //= Length vu1, vu2, ResV !!!

	  /// lenV=lenV+1;  // <- if Foreval compiled in FPC !!!
      if (DLLCompiledBy == Lazarus ) { lenV=lenV+1;};



  for(ni = 0; ni <= lenV-1; ni++)
	{
	     #ifdef   EXTENDED_FLOAT
            fvx1=*PFloatType(vu1+ni*10);
            fvx2=*PFloatType(vu2+ni*10);
            *PFloatType(adrResV + ni*10)=fvx1+fvx2;
        #else
            fvx1=*PFloatType(vu1+ni*8);
            fvx2=*PFloatType(vu2+ni*8);
            *PFloatType(adrResV + ni*8)=fvx1+fvx2;
        #endif



	}


**/

}



/**
 ---------------------------------------------------------------------------------------
      Functions and Procedures calling by addresses in CallR(Addr) CallC(Addr) Call(Addr)
  ---------------------------------------------------------------------------------------

**/




TFloatType _stdcall  _RFuncPtr(void)
{
    return 2.5*(*PVX)+1.7*(*PVY);
}




void _stdcall  _ZFuncPtr(void)
{
  TComplex zt;

  zt.re=(2.5*(*PVZ1).re-1.7*(*PVZ2).re);
  zt.im=(2.5*(*PVZ1).im-1.7*(*PVZ2).im);

  //zt.im=1;
  //zt.re=2;


 #ifdef   EXTENDED_FLOAT
   flLoadFPUEP(&zt);
 //flLoadFPUE(zt.re,zt.im);
 #else
  flLoadFPUDP(&zt);
  //flLoadFPUD(zt.re,zt.im);
 #endif


}


//2.5*(z1.re*x+z2.re*y)+1.7*(z1.im*y-z2.im*x)*i
void _stdcall _NFuncPtr(void)
{
  //Resf - global var
  (*PRESF).re = 2.5*((*PVZ1).re*(*PVX)+(*PVZ2).re*(*PVY));
  (*PRESF).im = 1.7*((*PVZ1).im*(*PVY)-(*PVZ2).im*(*PVX));
};








///******************************  INTEGRAL *****************************************************///


void InitIntegral(void)
{
 P_Integral=10;
 N_Integral=15;

 an[1]=0.03075324199611726835; an[2]=0.07036604748810812471;
 an[3]=0.10715922046717193501; an[4]=0.13957067792615431445;
 an[5]=0.16626920581699393355; an[6]=0.18616100001556221103;
 an[7]=0.19843148532711157646; an[8]=0.20257824192556127288;
 an[9]=an[7];  an[10]=an[6];  an[11]=an[5]; an[12]=an[4];
 an[13]=an[3]; an[14]=an[2];  an[15]=an[1];
 bn[1]=0.98799251802048542849; bn[2]=0.93727339240070590431;
 bn[3]=0.84820658341042721620; bn[4]=0.72441773136017004742;
 bn[5]=0.57097217260853884754; bn[6]=0.39415134707756336990;
 bn[7]=0.20119409399743452230; bn[8]=0;
 bn[9]=-bn[7]; bn[10]=-bn[6]; bn[11]=-bn[5]; bn[12]=-bn[4];
 bn[13]=-bn[3];bn[14]=-bn[2]; bn[15]=-bn[1];
};







TFloatType  _stdcall FRInt1XYT(void)
{
   return 0.11*(*PVX)*(0.32*(*PVT)-0.23*(*PVY));
};



TFloatType  _stdcall FRInt2XYT(void)
{
  return 0.17*(*PVT)*(0.31*(*PVX)+0.17*(*PVY));
};



TFloatType  _stdcall FRInt3XYT(void)
{
  return 0.21*(*PVY)*(0.25*(*PVX)-0.15*(*PVT));
};




TFloatType  _stdcall FRLim1X(void)
{
   return -0.5*sqr((*PVX)-1.1);
};


TFloatType  _stdcall FRLim2X(void)
{
  return 0.7*sqr((*PVX)+1.7);
};



TFloatType  _stdcall FRLim3XY(void)
{
  return -0.1*sqr(1.1*(*PVX)-0.2*(*PVY));
};


TFloatType  _stdcall FRLim4XY(void)
{
  return 0.2*sqr(1.2*(*PVX)-0.3*(*PVY));
};






TFloatType  _stdcall Integral3FF(Pointer32 Func, Pointer32 PV1 , Pointer32 PV2, Pointer32 PV3, TFloatType a, TFloatType b , Pointer32 Func1, Pointer32 Func2, Pointer32 Func3, Pointer32 Func4)

{
 Int32 R, j1, i1, j2, i2, j3, i3, n1, n2, n3;
 TFloatType int1, int2, int3, HV1, HV2, HV3, h1, h2, h3, x1, x2, c, d, e, f, h, r;
 TFloatType ax1, ax2, ax3, sx1, sx2, sx3;
 PTGccTestR Func1R,Func2R,Func3R,Func4R,FuncMR;


 PVX = PFloatType(PV1);
 PVY = PFloatType(PV2);
 PVT = PFloatType(PV3);

 HV1 = *(PFloatType)PV1; HV2 = *(PFloatType)PV2; HV3 = *(PFloatType)PV3;

 FuncMR =  (PTGccTestR)Func;
 Func1R =  (PTGccTestR)Func1;
 Func2R =  (PTGccTestR)Func2;
 Func3R =  (PTGccTestR)Func3;
 Func4R =  (PTGccTestR)Func4;



int3 = 0;


n1 = abs(P_Integral);
if (n1 == 0) {n1 = 1;};
n2 = abs(P_Integral);
if (n2 == 0) {n2 = 1;};
n3 = abs(P_Integral);
if (n3 == 0) {n3 = 1;};
h3 = (b - a) / n3 ;


for(j3 = 0; j3 <= n3-1; j3++)
{
 x1 = a + j3 * h3 ;
 x2 = a + (j3 + 1) * h3 ;
 ax3 = (x1 + x2) * 0.5 ;
 sx3 = (x2 - x1) * 0.5 ;

  for(i3 = 1; i3 <= N_Integral; i3++)
  {
   //*PExtended(PV1)= sx3 * bn[i3] + ax3 ;
   *PFloatType(PV1)= sx3 * bn[i3] + ax3 ;

   int2 = 0;
   d = Func2R(); /// more fast call, instead of
   //d = flResultR(Func2);
   //flResultE(Func2,d);

   c = Func1R(); /// more fast call, instead of
   //c = flResultR(Func1);
   //flResultE(Func1,c);

   h2 = (d - c) / n2 ;

   for(j2 = 0; j2 <= n2-1; j2++)
   {
	x1 = c + j2 * h2;
	x2 = c + (j2 + 1) * h2;
	ax2 = (x1 + x2) * 0.5 ;
	sx2 = (x2 - x1) * 0.5 ;

	for(i2 = 1; i2 <= N_Integral; i2++)
	{
	 //*PExtended(PV2)= sx2 * bn[i2] + ax2 ;
     *PFloatType(PV2)= sx2 * bn[i2] + ax2 ;

	 int1 = 0;

     f = Func4R(); /// more fast call, instead of
	 //f = flResultR(Func4);
	 //flResultE(Func4,f);

     e = Func3R(); /// more fast call, instead of
	 //e = flResultR(Func3);
	 //flResultE(Func3,e);

	 h1 = (f - e) / n1  ;

	 for(j1 = 0; j1 <= n1-1; j1++)
	 {
	   x1 = e + j1 * h1 ;
	   x2 = e + (j1 + 1) * h1 ;
	   ax1 = (x1 + x2) * 0.5 ;
	   sx1 = (x2 - x1) * 0.5 ;

	   for(i1 = 1; i1 <= N_Integral; i1++)
	   {
		//*PExtended(PV3)= sx1 * bn[i1] + ax1 ;
		*PFloatType(PV3)= sx1 * bn[i1] + ax1 ;

           int1 = int1 + an[i1] * FuncMR() * sx1 ;  /// more fast call, instead of
		  //int1 = int1 + an[i1] * flResultR(Func) * sx1 ;
		  /*
		  flResultE(Func,r);
		  int1 = int1 + an[i1] * r * sx1 ;
		  */
	   }

	 }

	 int2 = int2 + an[i2] * int1 * sx2 ;

	}
   }

  int3 = int3 + an[i3] * int2 * sx3;
  }
}

*(PFloatType)PV1 = HV1; *(PFloatType)PV2 = HV2; *(PFloatType)PV3 = HV3;

return int3 ;

};




TFloatType   _stdcall Integral3(Pointer32 Func, Pointer32 PV1 , Pointer32 PV2, Pointer32 PV3, TFloatType a, TFloatType b , TFloatType c, TFloatType d, TFloatType e, TFloatType f)

{
Int32 R, j1, i1, j2, i2, j3, i3, n1, n2, n3;
TFloatType int1, int2, int3, HV1, HV2, HV3, h1, h2, h3, x1, x2,  h, r;
TFloatType ax1, ax2, ax3, sx1, sx2, sx3;



int3 = 0;


n1 = abs(P_Integral);
if (n1 == 0) {n1 = 1;};
n2 = abs(P_Integral);
if (n2 == 0) {n2 = 1;};
n3 = abs(P_Integral);
if (n3 == 0) {n3 = 1;};
h3 = (b - a) / n3 ;
h2 = (d - c) / n2 ;
h1 = (f - e) / n1  ;

for(j3 = 0; j3 <= n3-1; j3++)
{
 x1 = a + j3 * h3 ;
 x2 = a + (j3 + 1) * h3 ;
 ax3 = (x1 + x2) * 0.5 ;
 sx3 = (x2 - x1) * 0.5 ;

  for(i3 = 1; i3 <= N_Integral; i3++)
  {
   //*PExtended(PV1)= sx3 * bn[i3] + ax3 ;
   *PFloatType(PV1)= sx3 * bn[i3] + ax3 ;

   int2 = 0;
   //d = flResultR(Func2);
   //flResultE(Func2,d);
   //c = flResultR(Func1);
   //flResultE(Func1,c);

   //h2 = (d - c) / n2 ;

   for(j2 = 0; j2 <= n2-1; j2++)
   {
	x1 = c + j2 * h2;
	x2 = c + (j2 + 1) * h2;
	ax2 = (x1 + x2) * 0.5 ;
	sx2 = (x2 - x1) * 0.5 ;

	for(i2 = 1; i2 <= N_Integral; i2++)
	{
	 //*PExtended(PV2)= sx2 * bn[i2] + ax2 ;
     *PFloatType(PV2)= sx2 * bn[i2] + ax2 ;

	 int1 = 0;

	 //f = flResultR(Func4);
	 //flResultE(Func4,f);
	 //e = flResultR(Func3);
	 //flResultE(Func3,e);

	 //h1 = (f - e) / n1  ;

	 for(j1 = 0; j1 <= n1-1; j1++)
	 {
	   x1 = e + j1 * h1 ;
	   x2 = e + (j1 + 1) * h1 ;
	   ax1 = (x1 + x2) * 0.5 ;
	   sx1 = (x2 - x1) * 0.5 ;

	   for(i1 = 1; i1 <= N_Integral; i1++)
	   {
		//*PExtended(PV3)= sx1 * bn[i1] + ax1 ;
		*PFloatType(PV3)= sx1 * bn[i1] + ax1 ;


		  int1 = int1 + an[i1] * flResultR(Func) * sx1 ;
		  /*
		  flResultE(Func,r);
		  int1 = int1 + an[i1] * r * sx1 ;
		  */
	   }

	 }

	 int2 = int2 + an[i2] * int1 * sx2 ;

	}
   }

  int3 = int3 + an[i3] * int2 * sx3;
  }
}


return int3 ;

};



TFloatType  _stdcall  Integral1(Pointer32 Func, Pointer32 PV1 ,/* _int32 RType,*/  TFloatType a, TFloatType b)

{
Int32 R, j1, i1, j2, i2, j3, i3, n1, n2, n3;
TFloatType int1, int2, int3, HV1, HV2, HV3, h1, h2, h3, x1, x2, c, d, e, f, h, r;
TFloatType ax1, ax2, ax3, sx1, sx2, sx3;
PTGccTestR FuncMR;


  FuncMR =  (PTGccTestR)Func;

  int1 = 0;


  n1 = abs(P_Integral);
  if (n1 == 0) {n1 = 1;};
  h1 = (b - a) / n1 ;

	 for(j1 = 0; j1 <= n1-1; j1++)
	 {
	   x1 = a + j1 * h1 ;
	   x2 = a + (j1 + 1) * h1 ;
	   ax1 = (x1 + x2) * 0.5 ;
	   sx1 = (x2 - x1) * 0.5 ;

	   for(i1 = 1; i1 <= N_Integral; i1++)
	   {
         //if (RType ==  fl_REAL_EXTENDED) {*PExtended(PV1)= sx1 * bn[i1] + ax1 ;} else {*PDouble(PV1)= sx1 * bn[i1] + ax1;};
         *PFloatType(PV1)= sx1 * bn[i1] + ax1;

         int1 = int1 + an[i1] * FuncMR() * sx1 ;//more fast call, instead of
         //int1 = int1 + an[i1] * flResultR(Func) * sx1 ;

	   }

	 }


  return int1 ;

};



///***********************************************************************************///



/*
void  _cdecl anyf(_int32 ni, TComplexE z1, double x, TArrayE vx)
{
double re,im;
TComplexE rez;
 //anyf(j+k,z1*z2,x+y,ve)


 rez.re=ni+z1.re+x+vx[ni];
 rez.im=z1.im;
 //rez.re=vx[ni];

 _asm
{
   fld tbyte ptr [rez+16]
   fld tbyte ptr [rez]
 }

 //flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);

}



void  _cdecl anyf1(_int32 ni, TComplexE z1, double x, TArrayI vi)
{
double re,im;
TComplexE rez;
 //anyf1(j+k,z1*z2,x+y,vi)


 rez.re=ni+z1.re+x+vi[ni];
 rez.im=z1.im;
 //rez.re=vx[ni];

 _asm
{
   fld tbyte ptr [rez+16]
   fld tbyte ptr [rez]
 }

 //flLoadFPUDP(&rez);
 //flLoadFPUD(rez.re,rez.im);

}



//vems(ve,n)= ve[n]
double  _cdecl VEMS(_int32 addr)
{
 return  (*PArrayE(addr))[(*PInteger(addr+16))];
}
*/
