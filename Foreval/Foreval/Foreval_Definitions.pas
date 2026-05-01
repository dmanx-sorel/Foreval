unit Foreval_Definitions;

//ver 9.1.1.381

interface

const
c_pi:extended =   3.1415926535897932384626433832795;
c_ln2:extended =  0.6931471805599453094172321214581;
c_ln10:extended = 2.3025850929940456840179914546843;
c_lg2:extended =  0.3010299956639811952137388947244;
c_lge:extended =  0.4342944819032518276511289189166;
c_l2e:extended =  1.4426950408889634073599246810018;
c_l2g:extended =  3.3219280948873623478703194294893;
c_exp1:extended = 2.7182818284590452353602874713526;
c_2pi:extended =  6.2831853071795864769252867665590;
c_eul:extended =  0.5772156649015328606065120900824;


  const _STACK_ADDR = 1;
  const _STACK_VAL = 2;
  const _MEMORY_ESP = 4;
  const _MEMORY_EAX = 5;
  const _STACK_INFINITE   = 6;
  const _INTERNAL_INFINITE_ANY = 7; //любое число аргументов с любым типом (исп-с€ при оптимизации и #prog)
  const _COMPILED = 9;


  const R_EAX = 1;
  const R_EBX = 2;
  const R_ECX = 3;
  const R_EDX = 4;
  const R_ESP = 5;
  const R_EBP = 6;
  const R_ESI = 7;
  const R_EDI = 8;
  const R_FPU = 9;


  const __VarType  = 7;
  const  T_Real    = 1;
  const  T_Complex = 2;
  const  T_Array   = 3;
  const  T_Integer = 4; //пока не используетс€. ¬¬едЄн дл€ целочисленных функций и выражений, возращающих тип Integer через  EAX
  const  T_None    = 5;
  const  T_Void    = 6;  //как T_None, только дл€ внутренних ф-ий
  const  T_Pointer = 7; // .347
  const  T_Any  =   -1;  // .324  //виртуальный тип, подразумевает использование любого вместо себ€. ¬ ходе разбора преобразуетс€ в конкретный тип.


  const C_None = 0;
  const C_Real = 1;      // = T_Real !!!
  const C_Complex = 2;   // = T_Complex !!!
  const C_Image = 3;


  const __MathType = 5;
  const _Single    = 1;
  const _Double    = 2;
  const _Extended  = 3;
  const _Integer   = 4;
  const _Pointer   = 5;
  const _Byte      = 6;
  const _Word      = 7;

  const _Real     = 1;    //=T_Real     !!!
  const _Complex  = 2;    //=T_Complex  !!!

  // fl_COMPLEX_DIV
  const _fast      = 1;
  const _standard  = 2;
  const _accurate  = 3;
  const _extra     = 4;

  

  const  _Enable  = 1;
  const  _Disable = 2;
  const  _Auto    = 3;

  const  _New = 10;
  const  _ReWrite = 20;
  const  _NewOverload = 30;


  const _between = 1;
  const _after   = 2;
  const _before  = 3;



  const  _RE = 1;
  const  _IM = 2;
  const _RIGHT = 1;
  const _BACK = 2;
  const _INFINITE = -1;

  const  _YES  = 1;
  const  _NO  = 2;
  const  _ANY  = -1;        // = -1 !!!
  const  _NOT_FOUND = -1;   // = -1 !!!
  const  _ABSENT  = -1;     // = -1 !!!
  const  _POSITIVE = 3;
  const  _NEGATIVE = 4;
  const  _DELETED  = 5; //<> _YES,_NO!!!

  { _ABSENT =  _NOT_FOUND = -1 !!! }

   //F_DiffType
  const
   _Symbolic      = 1;
   _Numeric       = 2;


    //source of definition of variables
  const
       ds_ExternalAddr          = 1;
       ds_InternalAddr          = 2;
       ds_ProgrammBody          = 3;
       ds_FunctionHeader        = 4;
       ds_FunctionBody          = 5;



type TAddress = Cardinal;

type TFloat = extended; {всегда!! always!! = extended} //тип переменных

type PFloat = ^TFloat;

type TArrayF = array of TFloat;


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
type TArrayI = array of Integer;
type TArrayD = array of Double;
type TArrayE = array of Extended;
type TArrayS = array of Single;
type TArrayP = array of Pointer;
type TArrayB = array of byte;

type PArrayI = ^TArrayI;
type PArrayD = ^TArrayD;
type PArrayE = ^TArrayE;
type PArrayS = ^TArrayS;
type PArrayB = ^TArrayB;
type PArrayP = ^TArrayP;


type
TAttribInt = record
                 FType:    Integer; //тип сохран€емого результата
                            //FType = _Double,_Integer,_Extended,_Single
                 AddrRE:   Cardinal; //адрес сохран€емого результата (непосредственный - Address)
                 AddrIM:   Cardinal; //адрес сохран€емого результата (непосредственный - Address)
             end;

type
TAttrib   = record      //дл€ внешней передачи
                 MType:    Integer; //тип сохран€емого результата
                            //MType = fl_Double, fl_Integer,fl_Extended,fl_Pointer,fl_Single
                 AddrRE:   Pointer; //адрес сохран€емого результата (непосредственный - Address)
                 AddrIM:   Pointer; //адрес сохран€емого результата (непосредственный - Address)
             end;


implementation

end.
