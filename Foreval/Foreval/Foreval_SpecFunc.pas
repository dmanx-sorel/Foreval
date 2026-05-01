unit Foreval_SpecFunc;

                             {ver 9.1.1.375}

{
                    //DeepFPU для комплексной >= 6  real >=4!!!

                  Special functions+standard accurate functions

                  Bessel functions,
                  Sherical Bessel functions,
                  Gamma + its companions and derivatives,
                  Zeta functions,
                  Spherical harmonic,
                  Probability distributions,
                  Legendre,Laguerre,Hermite,Chebyshev polynoms,... other special functions

                  by

              (C) Copyright   Wolfgang Ehrhardt   http://wolfgang-ehrhardt.de/

                https://github.com/chadilukito/www.wolfgang-ehrhardt.de
                https://github.com/maelh/www.wolfgang-ehrhardt.de-1/tree/master/
                https://github.com/moe123/www.wolfgang-ehrhardt.de



                                     ***********       !!!  IMPORTANT !!!   ***********
                             Changes in spec. functions (related to source of Wolfgang Ehrhardt ):

               Standard functions are different from sourcer Wolfgang Ehrhardt markered with postfix "_acc": NameFunction_acc
               Some special functions was fasterted with calling of replacing standard functions from within by more faster, but less accurate.
               Their marked by postfix "_fa" and controlled by variable F_ FastSpec, which switch functions from accurate to fast.
               Some changes in Bessel functions related to evaluate approximation polynomial in mode F_ FastSpec = True;
               Some changes in spherical Bessel functions order 0,1,2 to speed up. Controlled by variable F_ FastSpec,
               Functions rewrites on pure assembler: PolEvalX -> PolEvalX_f;   CSEvalX -> CSEvalX_f; cmul -> cmul_f;  cpolyr -> cpolyr_f and other

               REMARK    Wolfgang Ehrhardt     :
               $define use_fast_exp if the roundmode-safe exp code should
               NOT be used. This assumes that the exp/exp3/5/7/10 routines
               should be called with rounding to nearest, otherwise in
               rare case there may be wrong results.
}

{$R-}
{$Q-}

{$IFDEF FPC}
  {$MODE DELPHI}
  {$ASMMODE INTEL}
{$ENDIF}

interface

//uses  math;







type THexExtW = packed array[0..4] of word;
type TDA02 = array[0..2] of double;
type THexDblW = packed array[0..3] of word;  {Double   as array of word}
THexDblA = packed array[0..7] of byte;  {Double   as array of bytes}

type
  TExtVector = array[0..6528] of extended;

type
  TExtRec  = packed record     {Extended as sign, exponent, significand}
               lm: longint;    {low  32 bit of significand}
               hm: longint;    {high 32 bit of significand}
               xp: word;       {biased exponent and sign  }
             end;


// = TComplexE !!!!!!! (16byte+16byte on each field)
type
  complex = record
              re: extended; {real part     }
              im: extended; {imaginary part}
            end;


{type
  complex = TComplexE; }

type
  TDblRec  = packed record     {Double as sign, exponent, significand}
               lm: longint;    {low  32 bit of significand}
               hm: longint;    {high bits of significand, biased exponent and sign}
             end;


const NumberFact = 1754;

const c_Pi : extended = 3.1415926535897932384626433832795;

const MinExtHex   : THexExtW = ($0000,$0000,$0000,$8000,$0001); {MinExtended as Hex}
const MaxExtHex   : THexExtW = ($ffff,$ffff,$ffff,$ffff,$7ffe); {MaxExtended as Hex}
const TwoPihex    : THexExtW = ($c235,$2168,$daa2,$c90f,$4001); {2*Pi}
const PosInfXHex  : THexExtW = ($0000,$0000,$0000,$8000,$7fff); {extended +INF   as hex}
const NegInfXHex  : THexExtW = ($0000,$0000,$0000,$8000,$ffff); {extended -INF   as hex}
const NaNXHex     : THexExtW = ($ffff,$ffff,$ffff,$ffff,$7fff); {an extended NaN as hex}
const ph_cutoff   : extended = 549755813888.0;     {2^39, threshold for Payne/Hanek}
const two24:  double = 16777216.0;             {2^24}
const  twon24: double = 5.9604644775390625e-08; {1/2^24}
const Pi_4hex     : THexExtW = ($c235,$2168,$daa2,$c90f,$3ffe); {Pi/4}
const eps_x: extended = 1.084202172485504434E-19; {Hex: 0000000000000080C03F}
const Sqrt_MinXH  : THexExtW = ($0000,$0000,$0000,$8000,$2000); {sqrt(MinExtended) as Hex}
const ln_succx0   = -11398.80538430830061;
const c2dPi:extended = 2/pi;
const MachineEpsilon: extended = 5E-16;
const RTE_ArgumentRange: integer = 235;
const Sqrt_2Pihex : THexExtW = ($2cb3,$b138,$98ff,$a06c,$4000); {sqrt(2*Pi)}
const XLGAE   = 8.0;
const LnSqrt2Pihex: THexExtW = ($a535,$25f5,$8e43,$eb3f,$3ffe); {ln(sqrt(2*Pi)=}
const Pi_2hex     : THexExtW = ($c235,$2168,$daa2,$c90f,$3fff); {Pi/2}
const ln_MaxXH    : THexExtW = ($79ab,$d1cf,$17f7,$b172,$400c); {predx(ln(MaxExtended))}
const ln_MinXH    : THexExtW = ($eb2f,$1210,$8c67,$b16c,$c00c); {succx(ln(MinExtended))}
//const ln_MaxDH    : THexDblW = ($39EE,$FEFA,$2E42,$4086); {predd(ln(MaxDouble))}
//const ln_MinDH    : THexDblW = ($BCD1,$DD7A,$232B,$C086); {succd(ln(MinDouble))}
const PosInfDHex  : THexDblW = ($0000,$0000,$0000,$7ff0); {double +INF  as hex}
const lnpi:extended = 1.144729885849400174;
const NaNDHex     : THexDblW = ($ffff,$ffff,$ffff,$7fff); {a double NaN as hex}
const ln2hex      : THexExtW = ($79ac,$d1cf,$17f7,$b172,$3ffe); {ln(2)}
const ln3hex      : THexDblW = ($030A,$7AAD,$93EA,$3FF1); {ln(3)}
//const eps_d: double   = 2.2204460492503131E-16;
const Neg0DblHex  : THexDblW = ($0000,$0000,$0000,$8000); {-0}
const MV_4  : double = 0.44942328371e308;  {< MaxDouble/4}
const ln2_hi: THexDblA = ($00,$00,$E0,$FE,$42,$2E,$E6,$3F);
const ln2_lo: THexDblA = ($76,$3C,$79,$35,$EF,$39,$EA,$3D);
const log2ehex    : THexExtW = ($f0bc,$5c17,$3b29,$b8aa,$3fff); {log2(e)}
const PiSqrHex    : THexExtW = ($F2D2,$F22E,$E64D,$9DE9,$4002); {9.8696044010893586185}
const SqrtPihex   : THexExtW = ($553D,$A77B,$C48D,$E2DF,$3FFF); {sqrt(Pi) = +1.7724538509055160273}
const Sqrt_MaxXH  : THexExtW = ($ffff,$ffff,$ffff,$ffff,$5ffe); {sqrt(MaxExtended) as Hex}
  {Bernoulli numbers. The B(2n), n = 0..MaxB2nSmall are in AMath}
const MaxBernoulli = 2312;
const MaxB2nSmall  = 60;
const THREE       : extended = 3.0;
const eps_d: double   = 2.2204460492503131E-16;   {Hex: 000000000000B03C}
const Sqrt2hex    : THexExtW = ($6484,$F9DE,$F333,$B504,$3FFF); {sqrt(2)}
const log10ehex   : THexExtW = ($7195,$3728,$d8a9,$de5b,$3ffd); {log10(e)}


{shb}
const EulerGamHex : THexExtW = ($c7a5,$7db0,$67e3,$93c4,$3ffe); {Euler's constant}
const RTE_NoConvergence: integer = 234;  {shb}
const BT_J = 1; BT_Y = 2;

SIXX        : extended = 6.0; //Same reason (SIX would be sine integral)


const
  NXPGPMAX = 100;  {max. n for polygamma(n,x) with x < 0 via cot polynomial}


{
REMARK (from WE)     :$define use_fast_exp if the roundmode-safe exp code should
                      NOT be used. This assumes that the exp/exp3/5/7/10 routines
                      should be called with rounding to nearest, otherwise in
                      rare case there may be wrong results.
}
const
  half: single = 0.5;     {used for roundmode-safe exp routines}
  two : single = 2.0;     {used for roundmode-safe exp routines}
  ebig: single = 24576.0; {used for roundmode-safe exp routines}

const x0e :double = 6.5;         {erf(x)  = 1 for |x| > x0e}
const x1e:double = 106.75;      {erfc(x) = 0 for |x| > x1e}
const ETAEPS = 1e-9;

const
  MAXGAMX = 1755.455;  {max. argument for sfc_gamma}

const
  lanczos_gm05: extended = 12.64453125 + 3.375000000005456968e-5;

const  sqrt_epsh   : extended = 2.3283064365386962890625e-10;  {sqrt(eps_x/2)}

const
 C_1: complex = (re: 1.0; im: 0.0);  {complex 1}



const
  ipio2: array[0..689] of longint = (
           $A2F983, $6E4E44, $1529FC, $2757D1, $F534DD, $C0DB62,
           $95993C, $439041, $FE5163, $ABDEBB, $C561B7, $246E3A,
           $424DD2, $E00649, $2EEA09, $D1921C, $FE1DEB, $1CB129,
           $A73EE8, $8235F5, $2EBB44, $84E99C, $7026B4, $5F7E41,
           $3991D6, $398353, $39F49C, $845F8B, $BDF928, $3B1FF8,
           $97FFDE, $05980F, $EF2F11, $8B5A0A, $6D1F6D, $367ECF,
           $27CB09, $B74F46, $3F669E, $5FEA2D, $7527BA, $C7EBE5,
           $F17B3D, $0739F7, $8A5292, $EA6BFB, $5FB11F, $8D5D08,
           $560330, $46FC7B, $6BABF0, $CFBC20, $9AF436, $1DA9E3,
           $91615E, $E61B08, $659985, $5F14A0, $68408D, $FFD880,
           $4D7327, $310606, $1556CA, $73A8C9, $60E27B, $C08C6B,
           {the following bits are needed for extended exponents only}
           $47C419, $C367CD, $DCE809, $2A8359, $C4768B, $961CA6,
           $DDAF44, $D15719, $053EA5, $FF0705, $3F7E33, $E832C2,
           $DE4F98, $327DBB, $C33D26, $EF6B1E, $5EF89F, $3A1F35,
           $CAF27F, $1D87F1, $21907C, $7C246A, $FA6ED5, $772D30,
           $433B15, $C614B5, $9D19C3, $C2C4AD, $414D2C, $5D000C,
           $467D86, $2D71E3, $9AC69B, $006233, $7CD2B4, $97A7B4,
           $D55537, $F63ED7, $1810A3, $FC764D, $2A9D64, $ABD770,
           $F87C63, $57B07A, $E71517, $5649C0, $D9D63B, $3884A7,
           $CB2324, $778AD6, $23545A, $B91F00, $1B0AF1, $DFCE19,
           $FF319F, $6A1E66, $615799, $47FBAC, $D87F7E, $B76522,
           $89E832, $60BFE6, $CDC4EF, $09366C, $D43F5D, $D7DE16,
           $DE3B58, $929BDE, $2822D2, $E88628, $4D58E2, $32CAC6,
           $16E308, $CB7DE0, $50C017, $A71DF3, $5BE018, $34132E,
           $621283, $014883, $5B8EF5, $7FB0AD, $F2E91E, $434A48,
           $D36710, $D8DDAA, $425FAE, $CE616A, $A4280A, $B499D3,
           $F2A606, $7F775C, $83C2A3, $883C61, $78738A, $5A8CAF,
           $BDD76F, $63A62D, $CBBFF4, $EF818D, $67C126, $45CA55,
           $36D9CA, $D2A828, $8D61C2, $77C912, $142604, $9B4612,
           $C459C4, $44C5C8, $91B24D, $F31700, $AD43D4, $E54929,
           $10D5FD, $FCBE00, $CC941E, $EECE70, $F53E13, $80F1EC,
           $C3E7B3, $28F8C7, $940593, $3E71C1, $B3092E, $F3450B,
           $9C1288, $7B20AB, $9FB52E, $C29247, $2F327B, $6D550C,
           $90A772, $1FE76B, $96CB31, $4A1679, $E27941, $89DFF4,
           $9794E8, $84E6E2, $973199, $6BED88, $365F5F, $0EFDBB,
           $B49A48, $6CA467, $427271, $325D8D, $B8159F, $09E5BC,
           $25318D, $3974F7, $1C0530, $010C0D, $68084B, $58EE2C,
           $90AA47, $02E774, $24D6BD, $A67DF7, $72486E, $EF169F,
           $A6948E, $F691B4, $5153D1, $F20ACF, $339820, $7E4BF5,
           $6863B2, $5F3EDD, $035D40, $7F8985, $295255, $C06437,
           $10D86D, $324832, $754C5B, $D4714E, $6E5445, $C1090B,
           $69F52A, $D56614, $9D0727, $50045D, $DB3BB4, $C576EA,
           $17F987, $7D6B49, $BA271D, $296996, $ACCCC6, $5414AD,
           $6AE290, $89D988, $50722C, $BEA404, $940777, $7030F3,
           $27FC00, $A871EA, $49C266, $3DE064, $83DD97, $973FA3,
           $FD9443, $8C860D, $DE4131, $9D3992, $8C70DD, $E7B717,
           $3BDF08, $2B3715, $A0805C, $93805A, $921110, $D8E80F,
           $AF806C, $4BFFDB, $0F9038, $761859, $15A562, $BBCB61,
           $B989C7, $BD4010, $04F2D2, $277549, $F6B6EB, $BB22DB,
           $AA140A, $2F2689, $768364, $333B09, $1A940E, $AA3A51,
           $C2A31D, $AEEDAF, $12265C, $4DC26D, $9C7A2D, $9756C0,
           $833F03, $F6F009, $8C402B, $99316D, $07B439, $15200C,
           $5BC3D8, $C492F5, $4BADC6, $A5CA4E, $CD37A7, $36A9E6,
           $9492AB, $6842DD, $DE6319, $EF8C76, $528B68, $37DBFC,
           $ABA1AE, $3115DF, $A1AE00, $DAFB0C, $664D64, $B705ED,
           $306529, $BF5657, $3AFF47, $B9F96A, $F3BE75, $DF9328,
           $3080AB, $F68C66, $15CB04, $0622FA, $1DE4D9, $A4B33D,
           $8F1B57, $09CD36, $E9424E, $A4BE13, $B52333, $1AAAF0,
           $A8654F, $A5C1D2, $0F3F0B, $CD785B, $76F923, $048B7B,
           $721789, $53A6C6, $E26E6F, $00EBEF, $584A9B, $B7DAC4,
           $BA66AA, $CFCF76, $1D02D1, $2DF1B1, $C1998C, $77ADC3,
           $DA4886, $A05DF7, $F480C6, $2FF0AC, $9AECDD, $BC5C3F,
           $6DDED0, $1FC790, $B6DB2A, $3A25A3, $9AAF00, $9353AD,
           $0457B6, $B42D29, $7E804B, $A707DA, $0EAA76, $A1597B,
           $2A1216, $2DB7DC, $FDE5FA, $FEDB89, $FDBE89, $6C76E4,
           $FCA906, $70803E, $156E85, $FF87FD, $073E28, $336761,
           $86182A, $EABD4D, $AFE7B3, $6E6D8F, $396795, $5BBF31,
           $48D784, $16DF30, $432DC7, $356125, $CE70C9, $B8CB30,
           $FD6CBF, $A200A4, $E46C05, $A0DD5A, $476F21, $D21262,
           $845CB9, $496170, $E0566B, $015299, $375550, $B7D51E,
           $C4F133, $5F6E13, $E4305D, $A92E85, $C3B21D, $3632A1,
           $A4B708, $D4B1EA, $21F716, $E4698F, $77FF27, $80030C,
           $2D408D, $A0CD4F, $99A520, $D3A2B3, $0A5D2F, $42F9B4,
           $CBDA11, $D0BE7D, $C1DB9B, $BD17AB, $81A2CA, $5C6A08,
           $17552E, $550027, $F0147F, $8607E1, $640B14, $8D4196,
           $DEBE87, $2AFDDA, $B6256B, $34897B, $FEF305, $9EBFB9,
           $4F6A68, $A82A4A, $5AC44F, $BCF82D, $985AD7, $95C7F4,
           $8D4D0D, $A63A20, $5F57A4, $B13F14, $953880, $0120CC,
           $86DD71, $B6DEC9, $F560BF, $11654D, $6B0701, $ACB08C,
           $D0C0B2, $485551, $0EFB1E, $C37295, $3B06A3, $3540C0,
           $7BDC06, $CC45E0, $FA294E, $C8CAD6, $41F3E8, $DE647C,
           $D8649B, $31BED9, $C397A4, $D45877, $C5E369, $13DAF0,
           $3C3ABA, $461846, $5F7555, $F5BDD2, $C6926E, $5D2EAC,
           $ED440E, $423E1C, $87C461, $E9FD29, $F3D6E7, $CA7C22,
           $35916F, $C5E008, $8DD7FF, $E26A6E, $C6FDB0, $C10893,
           $745D7C, $B2AD6B, $9D6ECD, $7B723E, $6A11C6, $A9CFF7,
           $DF7329, $BAC9B5, $5100B7, $0DB2E2, $24BA74, $607DE5,
           $8AD874, $2C150D, $0C1881, $94667E, $162901, $767A9F,
           $BEFDFD, $EF4556, $367ED9, $13D9EC, $B9BA8B, $FC97C4,
           $27A831, $C36EF1, $36C594, $56A8D8, $B5A8B4, $0ECCCF,
           $2D8912, $34576F, $89562C, $E3CE99, $B920D6, $AA5E6B,
           $9C2A3E, $CC5F11, $4A0BFD, $FBF4E1, $6D3B8E, $2C86E2,
           $84D4E9, $A9B4FC, $D1EEEF, $C9352E, $61392F, $442138,
           $C8D91B, $0AFC81, $6A4AFB, $D81C2F, $84B453, $8C994E,
           $CC2254, $DC552A, $D6C6C0, $96190B, $B8701A, $649569,
           $605A26, $EE523F, $0F117F, $11B5F4, $F5CBFC, $2DBC34,
           $EEBC34, $CC5DE8, $605EDD, $9B8E67, $EF3392, $B817C9,
           $9B5861, $BC57E1, $C68351, $103ED8, $4871DD, $DD1C2D,
           $A118AF, $462C21, $D7F359, $987AD9, $C0549E, $FA864F,
           $FC0656, $AE79E5, $362289, $22AD38, $DC9367, $AAE855,
           $382682, $9BE7CA, $A40D51, $B13399, $0ED7A9, $480569,
           $F0B265, $A7887F, $974C88, $36D1F9, $B39221, $4A827B,
           $21CF98, $DC9F40, $5547DC, $3A74E1, $42EB67, $DF9DFE,
           $5FD45E, $A4677B, $7AACBA, $A2F655, $23882B, $55BA41,
           $086E59, $862A21, $834739, $E6E389, $D49EE5, $40FB49,
           $E956FF, $CA0F1C, $8A59C5, $2BFA94, $C5C1D3, $CFC50F,
           $AE5ADB, $86C547, $624385, $3B8621, $94792C, $876110,
           $7B4C2A, $1A2C80, $12BF43, $902688, $893C78, $E4C4A8,
           $7BDBE5, $C23AC4, $EAF426, $8A67F7, $BF920D, $2BA365,
           $B1933D, $0B7CBD, $DC51A4, $63DD27, $DDE169, $19949A,
           $9529A8, $28CE68, $B4ED09, $209F44, $CA984E, $638270,
           $237C7E, $32B90F, $8EF5A7, $E75614, $08F121, $2A9DB5,
           $4D7E6F, $5119A5, $ABF9B5, $D6DF82, $61DD96, $023616,
           $9F3AC4, $A1A283, $6DED72, $7A8D39, $A9B882, $5C326B,
           $5B2746, $ED3400, $7700D2, $55F4FC, $4D5901, $8071E0);

const
  PIo2: array[0..7] of THexDblW = (
          ($0000, $4000, $21FB, $3FF9),  {1.5707962512969971    }
          ($0000, $0000, $442D, $3E74),  {7.5497894158615964e-08}
          ($0000, $8000, $4698, $3CF8),  {5.3903025299577648e-15}
          ($0000, $6000, $CC51, $3B78),  {3.2820034158079130e-22}
          ($0000, $8000, $1B83, $39F0),  {1.2706557530806761e-29}
          ($0000, $4000, $2520, $387A),  {1.2293330898111133e-36}
          ($0000, $8000, $8222, $36E3),  {2.7337005381646456e-44}
          ($0000, $0000, $F31D, $3569)); {2.1674168387780482e-51}

const
  init_jk: array[0..3] of integer = (2,3,4,6); {initial value for jk}

const
  NBoF  = 20;
  BoFHex: array[0..NBoF] of THexExtW = (      {Bernoulli(2k+2)/(2k+2)! }
            ($AAAB,$AAAA,$AAAA,$AAAA,$3FFB),  {+8.3333333333333333336E-2}
            ($B60B,$0B60,$60B6,$B60B,$BFF5),  {-1.3888888888888888888E-3}
            ($355E,$08AB,$55E0,$8AB3,$3FF0),  {+3.3068783068783068783E-5}
            ($5563,$A778,$BC99,$DDEB,$BFEA),  {-8.2671957671957671957E-7}
            ($ED15,$B875,$795F,$B354,$3FE5),  {+2.0876756987868098980E-8}
            ($F7BA,$2133,$2EB2,$9140,$BFE0),  {-5.2841901386874931847E-10}
            ($0FDC,$048B,$9627,$EB6D,$3FDA),  {+1.3382536530684678833E-11}
            ($E260,$CCAA,$70FB,$BED2,$BFD5),  {-3.3896802963225828668E-13}
            ($ECEE,$2974,$38EB,$9AAC,$3FD0),  {+8.5860620562778445639E-15}
            ($8664,$5567,$CB46,$FABE,$BFCA),  {-2.1748686985580618731E-16}
            ($77D8,$E1BB,$0F84,$CB3F,$3FC5),  {+5.5090028283602295151E-18}
            ($E371,$D15A,$C819,$A4BE,$BFC0),  {-1.3954464685812523341E-19}
            ($3204,$3568,$96BE,$8589,$3FBB),  {+3.5347070396294674718E-21}
            ($B3E6,$F8E0,$96AC,$D87B,$BFB5),  {-8.9535174270375468504E-23}
            ($6AD7,$6513,$6D26,$AF79,$3FB0),  {+2.2679524523376830603E-24}
            ($57E2,$6F1C,$EFCB,$8E3B,$BFAB),  {-5.7447906688722024451E-26}
            ($0D7F,$90DB,$CEF2,$E694,$3FA5),  {+1.4551724756148649018E-27}
            ($3676,$2BA5,$F32B,$BAE6,$BFA0),  {-3.6859949406653101781E-29}
            ($F634,$DA56,$46D9,$977F,$3F9B),  {+9.3367342570950446721E-31}
            ($F768,$3B0F,$1482,$F599,$BF95),  {-2.3650224157006299346E-32}
            ($2185,$9423,$FFC9,$C712,$3F90)); {+5.9906717624821343044E-34}


  const
  B2nHex: array[0..MaxB2nSmall] of THexExtw = ( {Bernoulli(2n), n=0..}
            ($0000,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000000}
            ($AAAB,$AAAA,$AAAA,$AAAA,$3FFC),  {+1.6666666666666666667E-1}
            ($8889,$8888,$8888,$8888,$BFFA),  {-3.3333333333333333335E-2}
            ($C30C,$0C30,$30C3,$C30C,$3FF9),  {+2.3809523809523809523E-2}
            ($8889,$8888,$8888,$8888,$BFFA),  {-3.3333333333333333335E-2}
            ($26CA,$6C9B,$C9B2,$9B26,$3FFB),  {+7.5757575757575757578E-2}
            ($8198,$9819,$1981,$8198,$BFFD),  {-2.5311355311355311355E-1}
            ($5555,$5555,$5555,$9555,$3FFF),  {+1.1666666666666666666}
            ($F2F3,$F2F2,$F2F2,$E2F2,$C001),  {-7.0921568627450980392}
            ($27C8,$9F1E,$7C78,$DBE2,$4004),  {+5.4971177944862155390E+1}
            ($67F4,$7F39,$F396,$8447,$C008),  {-5.2912424242424242426E+2}
            ($28D0,$33F1,$FC4A,$C180,$400B),  {+6.1921231884057971016E+3}
            ($6606,$0660,$2066,$A91A,$C00F),  {-8.6580253113553113550E+4}
            ($5555,$5555,$6955,$AE03,$4013),  {+1.4255171666666666666E+6}
            ($9C8B,$AE32,$DB88,$D044,$C017),  {-2.7298231067816091954E+7}
            ($FE36,$9A41,$9527,$8F6D,$401C),  {+6.0158087390064236836E+8}
            ($E5E6,$C5E5,$2B1D,$E140,$C020),  {-1.5116315767092156863E+10}
            ($5555,$EA55,$0E6E,$C80E,$4025),  {+4.2961464306116666666E+11}
            ($5309,$8E05,$E567,$C787,$C02A),  {-1.3711655205088332772E+13}
            ($9555,$CF4C,$5D33,$DE11,$402F),  {+4.8833231897359316666E+14}
            ($C84C,$1CEA,$45FA,$891C,$C035),  {-1.9296579341940068148E+16}
            ($9B70,$68B9,$B5E0,$BAE4,$403A),  {+8.4169304757368261500E+17}
            ($60ED,$6259,$67A8,$8BF3,$C040),  {-4.0338071854059455412E+19}
            ($D4E6,$F92A,$1ECC,$E551,$4045),  {+2.1150748638081991606E+21}
            ($8EB9,$1AF2,$630E,$CCC1,$C04B),  {-1.2086626522296525934E+23}
            ($C97F,$74B7,$D9A2,$C68B,$4051),  {+7.5008667460769643668E+24}
            ($50C0,$269C,$2369,$D066,$C057),  {-5.0387781014810689143E+26}
            ($D9ED,$4EC6,$CA9A,$EC0F,$405D),  {+3.6528776484818123334E+28}
            ($E7CF,$899B,$CBC7,$8FE1,$C064),  {-2.8498769302450882226E+30}
            ($5070,$15A2,$D8D6,$BC43,$406A),  {+2.3865427499683627645E+32}
            ($65EE,$E640,$2AAB,$83E3,$C071),  {-2.1399949257225333666E+34}
            ($707D,$1C11,$CE9D,$C56A,$4077),  {+2.0500975723478097570E+36}
            ($1E1C,$7AC8,$21EF,$9D85,$C07E),  {-2.0938005911346378408E+38}
            ($E927,$8376,$73E5,$85BA,$4085),  {+2.2752696488463515559E+40}
            ($8500,$E7B3,$9488,$F123,$C08B),  {-2.6257710286239576047E+42}
            ($B991,$385E,$7503,$E67C,$4092),  {+3.2125082102718032518E+44}
            ($0E52,$1EBF,$9A0F,$E92A,$C099),  {-4.1598278166794710914E+46}
            ($7C1E,$0021,$4E79,$F942,$40A0),  {+5.6920695482035280023E+48}
            ($970D,$F26E,$AF7E,$8C94,$C0A8),  {-8.2183629419784575694E+50}
            ($2C49,$524C,$2BE5,$A716,$40AF),  {+1.2502904327166993017E+53}
            ($C0A8,$EA20,$F1CB,$D0F8,$C0B6),  {-2.0015583233248370275E+55}
            ($8E7B,$4C4E,$5298,$8956,$40BE),  {+3.3674982915364374232E+57}
            ($7DC5,$B6DB,$4610,$BD7C,$C0C5),  {-5.9470970503135447718E+59}
            ($12CC,$59DB,$F874,$890D,$40CD),  {+1.1011910323627977560E+62}
            ($4590,$25D4,$A47F,$CFA5,$C0D4),  {-2.1355259545253501188E+64}
            ($A679,$4EF1,$AF84,$A492,$40DC),  {+4.3328896986641192418E+66}
            ($5E81,$3FBE,$35D8,$8854,$C0E4),  {-9.1885528241669328228E+68}
            ($8A90,$C146,$AAF0,$EBD8,$40EB),  {+2.0346896776329074493E+71}
            ($C12C,$4593,$68CD,$D4D3,$C0F3),  {-4.7003833958035731077E+73}
            ($FF4E,$F062,$48DC,$C82E,$40FB),  {+1.1318043445484249271E+76}
            ($3F3B,$AFB3,$532E,$C417,$C103),  {-2.8382249570693706958E+78}
            ($7E40,$DF17,$81CD,$C7E2,$410B),  {+7.4064248979678850632E+80}
            ($45B1,$D38C,$5DAE,$D3DC,$C113),  {-2.0096454802756604484E+83}
            ($5F41,$4EA9,$1C33,$E951,$411B),  {+5.6657170050805941445E+85}
            ($6A4B,$0BDB,$E3F8,$8563,$C124),  {-1.6584511154136216916E+88}
            ($4724,$DD5F,$F84A,$9E3F,$412C),  {+5.0368859950492377418E+90}
            ($328E,$4648,$E010,$C2A9,$C134),  {-1.5861468237658186369E+93}
            ($826C,$BA97,$AC47,$F81F,$413C),  {+5.1756743617545626984E+95}
            ($93F0,$781D,$43FD,$A3C1,$C145),  {-1.7488921840217117340E+98}
            ($0AFB,$0494,$C087,$DFB2,$414D),  {+6.1160519994952185254E+100}
            ($8384,$4095,$B028,$9E09,$C156)); {-2.2122776912707834942E+103}


const
  npcv=7; {chebyshev(((1-cos(x))-x^2/2)/x^4,x=-Pi/4..Pi/4,1e-20) converted to poly}
  pcvh: array[0..npcv-1] of THexExtW = (
          ($AAAB,$AAAA,$AAAA,$AAAA,$BFFA),  {-0.416666666666666666661679544980e-1 }
          ($B26B,$0B60,$60B6,$B60B,$3FF5),  {+0.138888888888888879063613392395e-2 }
          ($B143,$0CE8,$00D0,$D00D,$BFEF),  {-0.248015873015846864625912712986e-4 }
          ($5CC9,$89D7,$7DBB,$93F2,$3FE9),  {+0.275573192214211550883212170218e-6 }
          ($6C85,$4AA7,$C6F6,$8F76,$BFE2),  {-0.208767557953773544469035900043e-8 }
          ($BDBB,$E308,$5D99,$C9CA,$3FDA),  {+0.114704613872478358447153370873e-10}
          ($234A,$7E37,$70F1,$D5BC,$BFD2)); {-0.474589475226674827431568738364e-13}

var
  pcv: array[0..npcv-1] of extended absolute pcvh;



var
  PosInf_x    : extended absolute PosInfXHex;  {extended +INF  }
  NegInf_x    : extended absolute NegInfXHex;  {extended -INF  }
  NaN_x       : extended absolute NaNXHex;
  Pi_4        : extended absolute Pi_4hex;
  Sqrt_MinExt : extended absolute Sqrt_MinXH;  {= 1.833603867554847166E-2466}  {= 0.5^8191}
  MaxExtended : extended absolute MaxExtHex;   {= 1.189731495357231764E+4932}  {2^16384-2^16320 = (2^64-1)*2^16320}
  MinExtended : extended absolute MinExtHex;   {= 3.362103143112093507E-4932}  {= 2^(-16382)}
  Sqrt_TwoPi  : extended absolute Sqrt_2Pihex;
  LnSqrt2Pi   : extended absolute LnSqrt2Pihex;
  Pi_2        : extended absolute Pi_2hex;
  ln_MaxExt   : extended absolute ln_MaxXH;    {= 11356.52340629414394}
  ln_MinExt   : extended absolute ln_MinXH;    {=-11355.13711193302405}
  log2e       : extended absolute log2ehex;    {= 1.4426950408889634079 }
  PiSqr       : extended absolute PiSqrHex;    {= 9.8696044010893586185}
  PosInf_d    : double absolute PosInfDHex;    {double +INF }
  TwoPi       : extended absolute TwoPihex;    {= 6.2831853071795864769 }
  Sqrt_MaxExt : extended absolute Sqrt_MaxXH;  {= 1.090748135619415929E+2466}  {= 2.0^8192}
  log10e      : extended absolute log10ehex;   {= 0.43429448190325182765}
  NaN	        : extended absolute NaNXHex;     {an extended quiet NaN}

  //NaN_d       : double absolute NaNDHex;     {a double NaN}
  ln2         : extended absolute ln2hex;      {= 0.69314718055994530942}
  //ln3         : double absolute ln3hex;      {= 1.09861228866810969140}
 // NegZero_d   : double absolute Neg0DblHex;  {-0}
  SqrtPi      : extended absolute SqrtPihex;   {= 1.7724538509055160273}

  {shb}
  EulerGamma  : extended absolute EulerGamHex; {= 0.57721566490153286061}

  Sqrt2       : extended absolute Sqrt2hex;    {= 1.41421356237309504880168872421}
  Bern2n      : array[0..MaxB2nSmall] of extended absolute B2nHex;
  SLB   : extended = 3.66720773511E-2466;   {> 2*sqrt_MinExt}
  SUB   : extended = 5.453740678097E2465;   {< sqrt_MaxExt/2}

  Cdn: extended;     // =1/sqrt(2*Pi)


//RAND


{****************************END SPEC. FUNC.******************************************************}

function modf(x: extended; var ip: longint): extended;
function floor_acc(x: extended): Integer;
function floor_fa(x: extended): Integer;
function log2_f(x: extended): extended;

function copysign(x,y: extended): extended;

function IsNaN(x: extended): boolean;
function IsNaNorInf(x: extended): boolean;
procedure GenerateFPUException(FError: Extended);


function cos_f(x: extended): extended;
function sin_f(x: extended): extended;
function tan_f(x: extended): extended;
procedure frexp(x: extended; var m: extended; var e: longint);
function exp_fa(x: extended): extended;
function exp_acc(x : extended): extended;
function power_fa(x,y: extended): extended;
procedure sincosPi_fa(x: extended; var s,c: extended);
procedure sincosPi_acc(x: extended; var s,c: extended);
procedure sincos_f(x: extended; var s,c: extended);
procedure sincos_fa(x: extended; var s,c: extended);
procedure sincos_acc(x: extended; var s,c: extended);
function sinPi_fa(x: extended): extended;
function sinPi_acc(x: extended): extended;
function sin_fa(x: extended): extended;
function cos_fa(x: extended): extended;
function tan_fa(x: extended): extended;
function cot_fa(x: extended): extended;
function arccos_fa(x: extended): extended;
function tan_acc(x: extended): extended;
function cot_acc(x: extended): extended;
function cot_f(x: extended): extended;
function sin_acc(x: extended): extended;
function cos_acc(x: extended): extended;
function power_acc(x, y : extended): extended;
function power_f(Base, Exponent: Extended): Extended;


function ilogb(x: extended): longint;
function intpower_f(x: extended; n: longint): extended;
function intpower_acc(x: extended; n: longint): extended;
function intpower_fa(x: extended; n: integer): extended;

function sinc_fa(x: extended): extended;
function sinc_acc(x: extended): extended;
function arctan2_fa(y, x: extended): extended;
function arctan2_f(y, x: extended): extended;
function arctan2_acc(y, x: extended): extended;

procedure sinhcosh_fa(x: extended; var s,c: extended);
procedure sinhcosh_acc(x: extended; var s,c: extended);


function _factorial(n: integer): extended;
function _factorial2(n: integer): extended;
function exp3(x: extended): extended;
function ldexp(x: extended; e: longint): extended;
function hypot_fa(x,y: extended): extended;
function hypot_acc(x,y: extended): extended;
//function IsNaND(d: extended): boolean;   {$ifdef HAS_INLINE} inline;{$endif}
function isign(x: extended): integer;
function coshm1_acc(x: extended): extended;
function CSEvalX(x: extended; const a: array of extended; n: integer): extended;
function CSEvalX_f(x: extended; const a: array of extended; n: integer): extended; assembler;
function CSEvalX_fa(x: extended; const a: array of extended; n: integer): extended;
function PolEvalX_f(x: extended; const va:array of extended; n: integer): extended; assembler;
function PolEvalX(x: extended; const va:array of extended; n: integer): extended;
function sinh_small(x: extended): extended;                 overload;
function sinh_small(x: extended; rel: boolean): extended;   overload;

procedure clngam_lanczos(const z: complex; var w: complex);
function rem_pio2_ph(x: extended; var z: extended): integer;
function rem_pio2_cw(x: extended; var z: extended): integer;
function rem_pio2(x: extended; var z: extended): integer;
function floorx(x: extended): extended;
function rem_int2(x: extended; var z: extended): integer;

procedure rdivc_acc(x: extended; const y: complex; var z: complex);
procedure rdivc_fa(x: extended; const y: complex; var z: complex);
procedure rdivc_f(x: extended; y: complex; var z: complex);

procedure clngam1z(const z: complex; var w: complex);
procedure clngamma(const z: complex; var w: complex);
//procedure sincosPi(x: extended; var s,c: extended);
function sfc_zetah(s,a: extended): extended;
function sfc_zetaint(n: integer): extended;
function zetap(s,sc: extended): extended;
function exp2(x: extended): extended;
function etam1pos(s: extended): extended;
function exp2m1(x: extended): extended;
function bernpoly_intern(n: integer; x: extended): extended;
function hz_a1(s,a: extended; var ok: boolean): extended;
function hurwitz_formula(s,a: extended): extended;
function sfc_bernoulli(n: integer): extended;
function exp10(x: extended): extended;
function exp7(x: extended): extended;
function powm1(x,y: extended): extended;
procedure cinv_fa(const z: complex; var w: complex);
procedure cadd(const x,y: complex; var z: complex);
procedure csqr(const z: complex; var w: complex);
procedure csub(const x,y: complex; var z: complex);
procedure cmul(const x,y: complex; var z: complex);
procedure cmul_f(x,y: complex; var z: complex);
procedure cpolyr(const z: complex; const a: array of extended; n: integer; var w: complex);
procedure CPOLYR_f( z: complex; const va: array of extended; n: integer; var w: complex); {stdcall;}  assembler;
procedure ccoth_acc(const z: complex; var w: complex);
//procedure ccoth_fa(const z: complex; var w: complex);
function vers(x: extended): extended;
procedure ctanh_acc(const z: complex; var w: complex);

procedure cexp_acc(z: complex; var w: complex);
procedure cexp_f( z: complex; var w: complex);
procedure cexp_fa(z: complex; var w: complex);

procedure cln_acc(const z: complex; var w: complex);
procedure cln_fa(const z: complex; var w: complex);
procedure cln_f( z: complex; var w: complex);


procedure ctan_acc(const z: complex; var w: complex);
procedure ccot_acc(const z: complex; var w: complex);
procedure ccot_fa(const z: complex; var w: complex);

procedure cpow_acc(const z,a: complex; var w: complex);
procedure cpowx_acc(const z: complex; x: extended; var w: complex);
procedure csqrt(const z: complex; var w: complex);
procedure csinh_acc(const z: complex; var w: complex);
function sinh_acc(x: extended): extended;
function sinh_f(x: extended): extended;
function cosh_acc(x: extended): extended;
function cosh_f(x: extended): extended;
function tanh_acc(x: extended): extended;


procedure ccosh_acc(const z: complex; var w: complex);
function cosh_fa(x: extended): extended;
procedure clog10_acc(const z: complex; var w: complex);
procedure clogbase_acc(const b,z: complex; var w: complex);


procedure csec_acc(const z: complex; var w: complex);
procedure ccsc_acc(const z: complex; var w: complex);
procedure csech_acc(const z: complex; var w: complex);
procedure ccsch_acc(const z: complex; var w: complex);



procedure Z_COT_ACC(z:  complex);     stdcall;
procedure Z_TAN_ACC(z:  complex);     stdcall;
function  R_COT_ACC(x:  extended): extended;        stdcall;
function  R_TAN_ACC(x:  extended): extended;      stdcall;
function  R_SIN_ACC(x:  extended): extended;        stdcall;
function  R_COS_ACC(x:  extended): extended;      stdcall;
procedure Z_SIN_ACC(z:  complex);     stdcall;
procedure Z_COS_ACC(z:  complex);     stdcall;
procedure Z_COSSIN_ACC(x:  extended);     stdcall;



procedure Z_SINH_acc(z: complex);  stdcall;
function R_SINH_acc(x: extended): extended;  stdcall;
procedure Z_COSH_acc(z: complex);  stdcall;
function R_COSH_acc(x: extended): extended;  stdcall;
procedure Z_TANH_acc(z: complex);  stdcall;
function R_TANH_acc(x: extended): extended;  stdcall;
procedure Z_COTH_acc(z: complex);  stdcall;
function R_COTH_acc(x: extended): extended;  stdcall;
procedure Z_SEC_acc(z: complex);  stdcall;
function R_SEC_acc(x: extended): extended;  stdcall;
procedure Z_COSEC_acc(z: complex);  stdcall;
function R_COSEC_acc(x: extended): extended;  stdcall;
procedure Z_SECH_acc(z: complex);  stdcall;
function R_SECH_acc(x: extended): extended;  stdcall;
procedure Z_COSECH_acc(z: complex);  stdcall;
function R_COSECH_acc(x: extended): extended;  stdcall;

procedure Z_ARCSIN_acc(z: complex);  stdcall;
function R_ARCSIN_acc(x: extended): extended;  stdcall;
procedure Z_ARCCOS_acc(z: complex);  stdcall;
function R_ARCCOS_acc(x: extended): extended;  stdcall;
procedure Z_ARCTAN_acc(z: complex);  stdcall;
function R_ARCTAN_acc(x: extended): extended;  stdcall;
procedure Z_ARCCOTAN_acc(z: complex);  stdcall;
function R_ARCCOTAN_acc(x: extended): extended;  stdcall;
procedure Z_ARCSEC_acc(z: complex);  stdcall;
function R_ARCSEC_acc(x: extended): extended;  stdcall;
procedure Z_ARCCOSEC_acc(z: complex);  stdcall;
function R_ARCCOSEC_acc(x: extended): extended;  stdcall;


procedure Z_ARCSINH_acc(z: complex);  stdcall;
function R_ARCSINH_acc(x: extended): extended;  stdcall;
procedure Z_ARCCOSH_acc(z: complex);  stdcall;
function R_ARCCOSH_acc(x: extended): extended;  stdcall;
procedure Z_ARCTANH_acc(z: complex);  stdcall;
function R_ARCTANH_acc(x: extended): extended;  stdcall;
procedure Z_ARCCOTANH_acc(z: complex);  stdcall;
function R_ARCCOTANH_acc(x: extended): extended;  stdcall;
procedure Z_ARCSECH_acc(z: complex);  stdcall;
function R_ARCSECH_acc(x: extended): extended;  stdcall;
procedure Z_ARCCOSECH_acc(z: complex);  stdcall;
function R_ARCCOSECH_acc(x: extended): extended;  stdcall;





procedure Z_EXP_ACC(z:  complex);     stdcall;
function  R_EXP_ACC(x:  extended): extended;        stdcall;

procedure Z_POWER_ACC(z1,z2:  complex);     stdcall;
function  R_POWER_ACC(x,y:  extended): extended;      stdcall;
procedure ZR_POWER_ACC(z1:  complex; x: extended);     stdcall;
procedure RZ_POWER_ACC(x: extended; z2:  complex);    stdcall;

procedure Z_CDIV(z1,z2: complex);    stdcall;
procedure Z_ROOT_acc(z: complex; n: integer);  stdcall;
function R_ROOT_acc(x: extended; n: integer): extended;  stdcall;
procedure Z_SQRT_acc(z: complex);  stdcall;
function R_SQRT_acc(x: extended): extended;  stdcall;
procedure Z_LN_acc(z: complex);  stdcall;
function R_LN_acc(x: extended): extended;  stdcall;

procedure Z_LOG_acc(z,x: complex);  stdcall;
procedure ZR_LOG_acc(z: complex; x:extended);  stdcall;
procedure RZ_LOG_acc(x:extended; z: complex );  stdcall;
function R_LOG_acc(b,x: extended): extended; assembler;  stdcall;
procedure Z_LOG10_acc(z: complex);  stdcall;
procedure Z_LOG2_acc(z: complex);  stdcall;
function R_LOG10_acc(x: extended): extended; assembler;  stdcall;
function R_LOG2_acc(x: extended): extended; assembler;  stdcall;




function sfc_lngcorr(x: extended): extended;
function sfc_j0(x: extended): extended;
function sfc_lngamma(x: extended): extended;
function lngamma_small(x,xm1,xm2: extended; useln1p: boolean): extended;
function sfc_j1(x: extended): extended;
function sfc_jn(n: integer; x: extended): extended;
function sfc_y0(x: extended): extended;
function sfc_y1(x: extended): extended;
function sfc_yn(n: integer; x: extended): extended;

function sfc_sph_jn(n: integer; x: extended): extended; stdcall;
function sfc_sph_yn(n: integer; x: extended): extended; stdcall;
function sfc_yv(v, x: extended): extended;
//procedure cgamma(const z: complex; var wx,wy: extended);  stdcall;
procedure cgamma(const z: complex; var w: complex);
function BinomialC(n,k: integer): extended; stdcall;
function sfc_binomial(n,k: integer): extended;
function sfc_lnbeta(x,y: extended): extended;
function lanczos(x: extended; egscale: boolean): extended;
function sfc_rgamma(x: extended): extended;
function sfc_gdr_pos(x,d: extended): extended;
function sfc_gamma_delta_ratio(x,d: extended): extended;
function sfc_pochhammer(a,x: extended): extended;
function sfc_beta(x,y: extended): extended;
function minx(x, y: extended): extended;
function sfc_ibetaprefix(a,b,x,y: extended): extended;
function sfc_beta_pdf(a, b, x: extended): extended;
function sfc_binomial_pmf(p: extended; n, k: longint): extended;
//function DistBinomial(p: extended; n, k: longint): extended; stdcall;
function DistBinomial(k, n: longint; p: extended): extended;  stdcall;
function sfc_poisson_pmf(mu: extended; k: longint): extended;
//function DistPoisson(mu: extended; k: longint): extended;  stdcall;
function DistPoisson(k: longint; mu: extended): extended;  stdcall;
function sfc_igprefix(a,x: extended): extended;
function ln1pmx(x: extended): extended;
function logcf(x,i,d: extended): extended;
//function DistNormal(mu, sd, x: extended): extended; stdcall;
function DistNormal(x, mu, sd: extended): extended; stdcall;
function sfc_erf_p(x: extended): extended;
function expmx2h(x: extended): extended;
function sfc_normal_pdf(mu, sd, x: extended): extended;
function sfc_erf_z(x: extended): extended;
//function DistHyperGeom(n1,n2,n,k: longint): extended; stdcall;
function DistHyperGeom(k1,N,K,n1: longint): extended; stdcall;
function sfc_hypergeo_pmf(n1,n2,n,k: longint): extended;
function bin_raw(p,q: extended; n, k: longint): extended;
//function sfc_binomial_cdf(p: extended; n, k: longint): extended;  stdcall;
function sfc_binomial_cdf(k, n: longint; p: extended): extended;  stdcall;
function sfc_ibeta(a, b, x: extended): extended;
function basym(a,b,lambda,eps: extended): extended;
function ccdf_binom(n,k: integer; x,y: extended): extended;
function ibeta_series(a, b, x: extended; normalised: boolean): extended;
function ibeta_cf(a, b, x: extended; type2: boolean): extended;
function sfc_erfce(x: extended): extended;
function sfc_poisson_cdf(k: longint; mu: extended): extended;   stdcall;
function sfc_igammaq(a,x: extended): extended;   stdcall;
procedure sfc_incgamma_ex(a,x: extended; var p,q,dax: extended; calcdax: boolean);
function igammaq_int(a, x: extended): extended;
function igammaq_half(a, x: extended): extended;
procedure igam_pqasymp(a,x: extended; var p,q: extended);
procedure igam_ptaylor(a,x,dax: extended; var p,q: extended);
procedure igam_qtaylor(a,x: extended; var p,q: extended);
procedure igam_qfraction(a,x,dax: extended; var p,q: extended);
function igam_aux(x: extended): extended;
function sfc_normal_cdf(x, mu, sd: extended): extended; stdcall;
function sfc_maxwell_pdf(x, b: extended): extended;  stdcall;
function sfc_maxwell_cdf(x, b: extended): extended;     stdcall;
function sfc_igammap(a,x: extended): extended;   stdcall;
function sfc_igammal(a,x: extended): extended;     stdcall;
function sfc_igamma(a,x: extended): extended;  stdcall;
function sfc_maxwell_inv(y, b: extended): extended; stdcall;
function sfc_igammap_inv(a,p: extended): extended;   stdcall;
function sfc_igammaq_inv(a,q: extended): extended;  stdcall;
function sfc_igamma_inv(a,p,q: extended): extended;
procedure sfc_incgamma_inv(a,p,q: extended; var x: extended; var ierr: integer);
function igamma_inv_guess(a,p,q: extended; var noiter: boolean): extended;
function DM_Fettis(a,lnB: extended): extended;
function DM_CF6(a,p,q: extended): extended;
function sfc_normstd_pdf(x: extended): extended;   stdcall;
function sfc_normstd_cdf(x: extended): extended;   stdcall;
function sfc_normstd_inv(y: extended): extended;   stdcall;
function sfc_normal_inv(y, mu, sd: extended): extended;   stdcall;
function sfc_erfc_inv(x: extended): extended;    stdcall;
function sfc_erf_inv(x: extended): extended;  stdcall;
procedure cerf(const z: complex; var w: complex);
procedure cerfc(const z: complex; var w: complex);
procedure sfc_erfCx(z: complex);    stdcall;
procedure sfc_erfcCx(z: complex);    stdcall;
function inverror(p,q: extended): extended;
function igaml_mser(a,x: extended; var err: extended): extended;
function sfc_e1(x: extended): extended;
function sfc_ei(x: extended): extended;
function sfc_eiex(x,expx: extended): extended;
function stirf(x: extended): extended;
function sfc_gamma_ratio(x,y: extended): extended;
function legendre_plmf(l,m: integer; x,f: extended): extended;

function sfc_i0e(x: extended): extended;
function sfc_i0(x: extended): extended;
function bess_i0_small(x: extended): extended;
function bess_i1_small(x: extended): extended;
function sfc_i1e(x: extended): extended;
function sfc_k0(x: extended): extended;
function sfc_k0e(x: extended): extended;
function bess_k0_small(x: extended): extended;
function bess_k1_small(x: extended): extended;
function sfc_k1e(x: extended): extended;
function sfc_jv(v, x: extended): extended;  stdcall;

function sfc_iv(v, x: extended): extended;
function sfc_in(n: integer; x: extended): extended;
procedure bessel_ik(v,x: extended; CalcI, escale: boolean; var Iv,Kv: extended);
procedure temme_k(v,x: extended; var K0,K1: extended);
function sfc_gamma1pm1(x: extended): extended;
function sinhc_acc(x: extended): extended;
function sinhc_fa(x: extended): extended;
procedure CF2_K(v,x: extended; escale: boolean; var K0,K1: extended);
function bess_i_large(v,x: extended; var Ivs: extended): boolean;
procedure CF1_I(v,x: extended; var fv: extended);
function IJ_series(v,x: extended; CalcJv: boolean): extended;
function expm1(x: extended): extended;
function sfc_kn(n: integer; x: extended): extended;
function sfc_kv(v, x: extended): extended;


procedure sphY(l, m: Pinteger; theta, phi: Pextended);  stdcall;
function sfc_gamma(x: extended):extended; stdcall;
procedure sfc_gammaCx(const z: complex); stdcall;
procedure sfc_lngammaCx(const z: complex);   stdcall;
procedure cpsi(const z: complex; var w: complex);
procedure czeta(const s: complex; var w: complex);
procedure czeta_neg(const s: complex; var w: complex);
procedure czeta_pos(const s: complex; var w: complex);
function  cabs_acc(const z: complex): extended;
function  cabs_fa(const z: complex): extended;
procedure cexp2(const z: complex; var w: complex);
procedure cdiv_fa(const x,y: complex; var z: complex);
procedure cdiv_f(x,y: complex; var z: complex);
procedure cdiv_acc(const x,y: complex; var z: complex);
procedure csinpi(const z: complex; var w: complex);
procedure coshsinhmult_fa(y,a,b: extended; var u,v: extended);
procedure coshsinhmult_acc(y,a,b: extended; var u,v: extended);
procedure sfc_psiCx(const z: complex);     stdcall;
procedure sfc_zetaCx(z: complex);    stdcall;
procedure Z_GAMMA;
procedure Z_LNGAMMA;
procedure Z_PSI;
procedure Z_ZETA;
function sfc_polygamma(n: integer; x: extended): extended;   stdcall;
function polygam_negx(n: integer; x: extended): extended; stdcall;
function polygam_ase(n: integer; x: extended): extended;
function polygam_cotpoly(n: integer; x: extended): extended;
function polygam_sum(n: integer; x: extended): extended;


function bessel_j0(px: PExtended): extended;  stdcall;
function bessel_j1(px: PExtended): extended;  stdcall;
function bessel_jn(pn: PInteger; px: PExtended): extended;  stdcall;
function bessel_jv(pv,px: PExtended): extended;  stdcall;

function bessel_y0(px: PExtended): extended;  stdcall;
function bessel_y1(px: PExtended): extended;  stdcall;
function bessel_yn(pn: PInteger; px: PExtended): extended;  stdcall;
function bessel_yv(pv,px: PExtended): extended;  stdcall;

function bessel_i0(px: PExtended): extended;  stdcall;
function bessel_i1(px: PExtended): extended;  stdcall;
function bessel_in(pn: PInteger; px: PExtended): extended;  stdcall;
function bessel_iv(pv,px: PExtended): extended;             stdcall;

function bessel_k0(px: PExtended): extended;  stdcall;
function bessel_k1(px: PExtended): extended;  stdcall;
function bessel_kn(pn: PInteger; px: PExtended): extended;  stdcall;
function bessel_kv(pv,px: PExtended): extended;  stdcall;

function sfc_legendre_p(l: integer; x: extended): extended;      stdcall;
function sfc_legendre_plm(l,m: integer; x: extended): extended;  stdcall;
function sph_bessel_jn(pn: Pinteger; px: Pextended): extended; stdcall; {shb}
function sph_bessel_yn(pn: PInteger; px: PExtended): extended;  stdcall;

function erf_small(x: extended): extended;
function sfc_erf(x: extended): extended;    stdcall;
function sfc_erfc(x: extended): extended;    stdcall;
procedure sfc_erfc_iusc(x: extended; var p,q: extended);
function IsInf(x: extended): boolean;
function expx2_acc(x: extended): extended;
function expx2_fa(x: extended): extended;
function ac_help(x: extended): extended;



function sfc_psi(x: extended): extended;       stdcall;      //psi
function sfc_trigamma(x: extended): extended;   stdcall;     //psid1
function sfc_tetragamma(x: extended): extended;   stdcall;   //psid2
function sfc_pentagamma(x: extended): extended;   stdcall;   //psid3
function sfc_zeta(s: extended): extended; stdcall;         //zeta

function sfc_chebyshev_t(n: integer; x: extended): extended;  stdcall;
function sfc_chebyshev_u(n: integer; x: extended): extended;  stdcall;
function sfc_laguerre(n: integer; x: extended): extended; stdcall;
function sfc_laguerre_a(n: integer; a,x: extended): extended; stdcall;
function sfc_hermite_h(n: integer; x: extended): extended; stdcall;



 function coth_fa(const X: Extended): Extended;
 function coth_acc(const X: Extended): Extended;
 function coth_f( X: Extended): Extended;

 function sech_acc(const X: Extended): Extended;
 function csch_acc(const x: extended): extended;
 function csc_acc(const X: Extended): Extended;
 function sec_acc(const X: Extended): Extended;


 function arccsch_acc(x: extended): extended;
 function arcsech_acc(x: extended): extended;
 function arccoth_acc(x: extended): extended;
 function arctanh_acc(x: extended): extended;

 function arccosh_acc(x: extended): extended;
 function arccosh_f(x: extended): extended;
 function arccosh_fa(x: extended): extended;

 function arcsinh_acc(x: extended): extended;
 function arccsc_acc(x: extended): extended;
 function arcsec_acc(x: extended): extended;
 function arccot_acc(x: extended): extended;
 //function arctan_acc(x: extended): extended;
 function arccos_acc(x: extended): extended;
 function arcsin_acc(x: extended): extended;

 procedure carccsch_acc(const z: complex; var w: complex);
 procedure carcsech_acc(const z: complex; var w: complex);
 procedure carccoth_acc(const z: complex; var w: complex);
 procedure carctanh_acc(const z: complex; var w: complex);
 procedure carccosh_acc(const z: complex; var w: complex);
 procedure carcsinh_acc(const z: complex; var w: complex);
 procedure carccsc_acc(const z: complex; var w: complex);
 procedure carcsec_acc(const z: complex; var w: complex);
 procedure carccot_acc(const z: complex; var w: complex);
 procedure carctan_acc(const z: complex; var w: complex);
 procedure carccos_acc(const z: complex; var w: complex);
 procedure carcsin_acc(const z: complex; var w: complex);

 const NTrue: integer=1;
 const NFalse: integer=0;

 var
  F_FastSpec: Boolean;
  F_EnableFPUException: Integer;
  ResFPUErrorValue: Extended;
  FPUErrorNAN,FPUErrorINF: Integer;

implementation
uses
 Foreval_Command;



function IsNaN(x: extended): boolean;  {$ifdef HAS_INLINE} inline;{$endif}
  {-Return true if x is a NaN}
begin
  with TExtRec(x) do begin
    IsNaN := (xp and $7FFF=$7FFF) and ((hm<>longint($80000000)) or (lm<>0));
  end;
end;


function IsInf(x: extended): boolean;  {$ifdef HAS_INLINE} inline;{$endif}
  {-Return true if x is +INF or -INF}
begin
  with TExtRec(x) do begin
    IsInf := (xp and $7FFF=$7FFF) and (hm=longint($80000000)) and (lm=0);
  end;
end;


function IsNaNorInf(x: extended): boolean;  {$ifdef HAS_INLINE} inline;{$endif}
  {-Return true if x is a NaN or infinite}
begin
  IsNaNorInf := TExtRec(x).xp and $7FFF=$7FFF;
end;


{
 По умолчанию, спец ф-ии не генерируют FPU исключения, а возвращают NAN, INF
 F_EnableFPUException вызывает принудительное генерирование исключений FPU
 в спец ф-иях в некоторых случаях. В b.375 - только при NAN!
 Связано со сложностью и неоднозначностью обработки INF аргументов во многих ф-иях
 Используется при вычислении с маскированием FPU
}
procedure GenerateFPUException(FError: Extended); {.375}
 function _zero: Extended; assembler;
 asm
   fldz
 end;
 function _sqrt: Extended; assembler;
 asm
   fld1
   fchs
   fsqrt
 end;
//generate invalid op in FPU
begin
  if F_EnableFPUException = NTrue then
  begin
    if FError = FPUErrorNAN then  ResFPUErrorValue:=_sqrt
    else
    if FError = FPUErrorINF then ResFPUErrorValue:=1/_zero;
  end;
end;



function exp_f(x: extended): extended; assembler;
asm
    fld  tbyte ptr [x]
    call R_EXP
    //fstp @Result
end;




function exp_fa(x: extended): extended;
begin
 if F_FastSpec = True then  exp_fa:=exp_f(x) else exp_fa:=exp_acc(x)
end;


function power_fa(x,y: extended): extended;
begin
 if F_FastSpec = True then  power_fa:=power_f(x,y) else power_fa:=power_acc(x,y)
end;


function cosh_fa(x: extended): extended;
begin
 if F_FastSpec = True then  cosh_fa:=cosh_f(x) else cosh_fa:=cosh_acc(x)
end;


function sinh_fa(x: extended): extended;
begin
 if F_FastSpec = True then  sinh_fa:=sinh_f(x) else sinh_fa:=sinh_acc(x)
end;


procedure sincosPi_fa(x: extended; var s,c: extended);
begin
  if F_FastSpec = True then
  begin
    sincos_f(Pi*x,s,c);
  end
  else
  begin
    sincosPi_acc(x,s,c);
  end;
end;



procedure sincos_fa(x: extended; var s,c: extended);
begin
  if F_FastSpec = True then
  begin
    sincos_f(x,s,c);
  end
  else
  begin
    sincos_acc(x,s,c);
  end;
end;



function tan_f(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Return the circular tangent of x, x mod Pi <> Pi/2}
asm
  {tan := sin(x)/cos(x)}
  fld    [x]
  fptan
  fstp   st(0)
end;

 {
function cotan_f(x: extended): extended;  assembler;
asm
  fld    [x]
  fptan
  fdivrp
end;
}



function coth_f(X: Extended): Extended;  assembler;
 asm
   fld  [x]
   call R_COTANH
 end;


function arccos_f(X: Extended): Extended;  assembler;
asm
   fld  [x]
   call R_ARCCOS
end;




function sinPi_acc(x: extended): extended;
  {-Return sin(Pi*x), result will be 0 for abs(x) >= 2^64}
var
 t: extended;
 i: integer;
begin
  i := rem_int2(x,t) and 3;
  t := Pi*t;
  case i of
      0:  sinPi_acc :=  sin_f(t);
      1:  sinPi_acc :=  cos_f(t);
      2:  sinPi_acc := -sin_f(t);
    else  sinPi_acc := -cos_f(t);
  end;
end;



function sinPi_fa(x: extended): extended;
  {Return sin(Pi*x)}
var
 t: extended;
begin
 if F_FastSpec = True then sinPi_fa:=sin_f(Pi*x) else sinPi_fa:=sinPi_acc(x)
end;




function sin_fa(x: extended): extended;
begin
 if F_FastSpec = True then  sin_fa:=sin_f(x) else sin_fa:=sin_acc(x)
end;




function cos_fa(x: extended): extended;
begin
 if F_FastSpec = True then  cos_fa:=cos_f(x) else cos_fa:=cos_acc(x)
end;



function tan_fa(x: extended): extended;
begin
 if F_FastSpec = True then  tan_fa:=tan_f(x) else tan_fa:=tan_acc(x)
end;




function arccos_fa(x: extended): extended;
begin
 if F_FastSpec = True then arccos_fa:=arccos_f(x) else arccos_fa:=arccos_acc(x)
end;







procedure frexp(x: extended; var m: extended; var e: longint);
  {-Return the mantissa m and exponent e of x with x = m*2^e, 0.5 <= abs(m) < 1;}
  { if x is 0, +-INF, NaN, return m=x, e=0}
var
  xh: THexExtW absolute x;  {x as array of word}
const
  H2_64: THexExtW = ($0000,$0000,$0000,$8000,$403f);  {2^64}
begin
  e := xh[4] and $7FFF;
  {First check is INF or NAN}
  if (e=$7FFF) or (x=0.0) then e := 0
  else begin
    if e=0 then begin
      {denormal}
      x := x*extended(H2_64);
      e := xh[4] and $7FFF;
      dec(e,64+$3FFE);
    end
    else dec(e,$3FFE);
    xh[4] := (xh[4] and $8000) or $3FFE;
  end;
  m := x;
end;



function coth_acc(const x: extended): extended;
begin
    coth_acc:=1/tanh_acc(x);
end;


function coth_fa(const X: Extended): Extended;
begin
  if F_FastSpec = True then  coth_fa:=coth_f(x) else coth_fa:=1.0/tanh_acc(X);
end;


function cot_fa(x: extended): extended;
begin
 if F_FastSpec = True then  cot_fa:=cot_f(x) else cot_fa:=cot_acc(x)
end;



function sinc_fa(x: extended): extended;
begin
 if F_FastSpec = True then  sinc_fa:=sin_f(x)/x else sinc_fa:=sinc_acc(x)
end;



function hypot_acc(x,y: extended): extended;
  {-Return sqrt(x*x + y*y)}
begin
  x := abs(x);
  y := abs(y);
  if x>y then hypot_acc := x*sqrt(1.0+sqr(y/x))
  else if x>0.0 then hypot_acc := y*sqrt(1.0+sqr(x/y)) {here y >= x > 0}
  else hypot_acc := y;                                 {here x=0}
end;




function hypot_fa(x,y: extended): extended;
begin
 if F_FastSpec = True then  hypot_fa:=sqrt(x*x + y*y) else hypot_fa:=hypot_acc(x,y)
end;



function _factorial(n: integer): extended;
begin
   if n < 0 then
   begin
     _factorial := PosInf_x;
     //GenerateFPUException(FPUErrorInf);{.375}
   end
   else _factorial:=factorial[n];
end;


function _factorial2(n: integer): extended;
begin
   if n < 0 then
   begin
    _factorial2 := PosInf_x;
    //GenerateFPUException(FPUErrorInf);{.375}
   end
   else _factorial2:=factorial2F[n];
end;




function copysign(x,y: extended): extended; {$ifdef HAS_INLINE} inline;{$endif}
  {-Return abs(x)*sign(y)}
begin
  THexExtW(x)[4] := (THexExtW(x)[4] and $7FFF) or (THexExtW(y)[4] and $8000);
  copysign := x;
end;






function modf(x: extended; var ip: longint): extended;
  {-Return frac(x) and trunc(x) in ip, |x|<=MaxLongint}
begin
  ip := trunc(x);
  modf := x-ip
end;



function floor_f(X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;


function floor_acc(x: extended): Integer;
  {-Return the largest integer <= x; |x|<=MaxLongint}
var
  i: Integer;
begin
  x := modf(x,i);
  if x<0.0 then floor_acc := i-1
  else floor_acc := i;
end;



function floor_fa(x: extended): Integer;
begin
   if F_FastSpec = True then  floor_fa:=floor_f(x)  else floor_fa:=floor_acc(x);
end;




function log2_f(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Return base 2 logarithm of x}
asm
  fld1
  fld     [x]
  fyl2x
  fwait
end;



function arctan2_fa(y,x: extended): extended;
begin
 if F_FastSpec = True then  arctan2_fa:=arctan2_f(y,x) else arctan2_fa:=arctan2_acc(y,x)
end;




function arctan2_f(y, x: extended): extended;  assembler; {&Frame-} {&Uses none}
  {-Return arctan(y/x); result in [-Pi..Pi] with correct quadrant}
asm
  fld     [y]
  fld     [x]
  fpatan
  //fwait
end;


function arctan2_acc(y, x: extended): extended;
  {-Return arctan(y/x); result in [-Pi..Pi] with correct quadrant}
var
  z: extended;
  ed: longint;
begin
  if x=0.0 then begin
    if y=0.0 then arctan2_acc := 0.0
    else if y>0.0 then arctan2_acc := Pi_2
    else arctan2_acc := -Pi_2;
  end
  else begin
    {Get difference of the exponents of x and y, (note: bias is cancelled)}
    ed := longint(THexExtW(y)[4] and $7FFF) - longint(THexExtW(x)[4] and $7FFF);
    {Safe to call arctan if abs(exp diff) <= 60}
    if ed>60 then z := Pi_2
    else if (x<0.0) and (ed<-60) then z := 0.0
    else z := arctan(abs(y/x));
    if x>0 then begin
      if y<0.0 then arctan2_acc := -z else arctan2_acc := z;
    end
    else begin
      if y<0.0 then arctan2_acc := z-Pi else arctan2_acc := Pi-z;
    end;
  end;
end;



(*
function power_f(const Base, Exponent: Extended): Extended;

const
  Max  : Double = MaxInt;
var
  IntExp : Integer;
asm // StackAlignSafe
  fld     Exponent
  fld     st             {copy to st(1)}
  fabs                   {abs(exp)}

  fld     Max

  fcomip  st(0), st(1)
  fstp    st(0)
  {
  fcompp                 //leave exp in st(0)
  fstsw   ax
  sahf
  }

  jb      @@RealPower    {exp > MaxInt}
  fld     st             {exp in st(0) and st(1)}
  frndint                {round(exp)}

  fcomip  st(0), st(1)
  {
  fcomp                  //compare exp and round(exp)
  fstsw   ax
  sahf
  }

  jne     @@RealPower
  fistp   IntExp
  mov     eax, IntExp    {eax=Trunc(Exponent)}
  mov     ecx, eax
  cdq
  fld1                   {Result=1}
  xor     eax, edx
  sub     eax, edx       {abs(exp)}
  jz      @@Exit
  fld     Base
  jmp     @@Entry
@@Loop:
  fmul    st, st         {Base * Base}
@@Entry:
  shr     eax, 1
  jnc     @@Loop
  fmul    st(1), st      {Result * X}
  jnz     @@Loop
  fstp    st
  cmp     ecx, 0
  jge     @@Exit
  fld1
  fdivrp                 {1/Result}
  jmp     @@Exit
@@RealPower:
  fld     Base
  ftst
  fstsw   ax
  sahf
  jz      @@Done
  fldln2
  fxch
  fyl2x
  fxch
  fmulp   st(1), st
  fldl2e
  fmulp   st(1), st
  fld     st(0)
  frndint
  fsub    st(1), st
  fxch    st(1)
  f2xm1
  fld1
  faddp   st(1), st
  fscale
@@Done:
  fstp    st(1)
@@Exit:
end;

*)





function power_f(Base, Exponent: Extended): Extended; assembler;
asm
  fld  tbyte ptr [Exponent]
  fld  tbyte ptr [Base]
  call FPWR
end;



{---------------------------------------------------------------------------}
function exp_acc(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Accurate exp, result good to extended precision}
asm
  {This version of Norbert Juffa's exp is from the VirtualPascal RTL source,}
  {discussed and explained in the VP Bugtracker system. Quote:              }
  {                                                                         }
  { ... "since the 387, F2XM1 can accecpt arguments in [-1, 1].             }
  {                                                                         }
  { So, we can split the argument into an integer and a fraction part using }
  { FRNDINT and the fraction part will always be -1 <= f <= 1 no matter what}
  { rounding control. This means we don't have to load/restore the FPU      }
  { control word (CW) which is slow on modern OOO FPUs (since FLDCW is a    }
  { serializing instruction).                                               }
  {                                                                         }
  { Note that precision is lost in doing exponentation when the fraction is }
  { subtracted from the integer part of the argument. The "naive" code can  }
  { loose up to 11 (or 15) bits of the extended precision format for large  }
  { DP or EP arguments, yielding a result good to double precision. To get a}
  { function accurate to full extended precision, we need to simulate higher}
  { precision intermediate arithmetic."                                     }
  { Ref: [Virtual Pascal 0000056]: More accurate Exp() function. URL (Oct.2009):}
  { https://admin.topica.com/lists/virtualpascal@topica.com/read/message.html?sort=a&mid=908867704&start=7}

  fld     [x]                { x                                                 }
  fldl2e                     { log2(e) | x                                       }
  fmul    st,st(1)           { z = x * log2(e) x                                 }
  frndint                    { int(z) | x                                        }
  fld     qword ptr [ln2_hi] { ln2_hi | int(z) | x                               }
  fmul    st,st(1)           { int(z)*ln2_hi | int(z) | x                        }
  fsubp   st(2),st           { int(z) | x-int(z)*ln2_hi                          }
  fld     qword ptr [ln2_lo] { ln2_lo | int(z) | x-int(z)*ln2_hi                 }
  fmul    st, st(1)          { int(z)*ln2_lo | int(z) | x-int(z)*ln2_hi          }
  fsubp   st(2),st           { int(z) | (x-int(z)*ln2_hi)-int(z)*ln2_lo          }
  fxch    st(1)              { (x-int(z)*ln2_hi)-int(z)*ln2_lo | int(z)          }
  fldl2e                     { log2(e) | (x-int(z)*ln2_hi)-int(z)*ln2_lo | int(z)}
  fmulp   st(1),st           { frac(z) | int(z)                                  }

{$ifndef use_fast_exp}
  {It may happen (especially for rounding modes other than "round to nearest")   }
  {that |frac(z)| > 1. In this case the result of f2xm1 is undefined. The next   }
  {lines will test frac(z) and use a safe algorithm if necessary.                }
  {Another problem pops up if x is very large e.g. for x=1e3000. AMath checks    }
  {int(z) and returns 2^int(z) if int(z) > 1.5*16384, result is 0 or overflow!   }
  fld     st
  fabs                       { abs(frac(z)) | frac(z) | int(z)                   }
  fld1                       { 1 | abs(frac(z)) | frac(z) | int(z)               }
  fcompp
  fstsw   ax
  sahf
  jae     @@1                { frac(z) <= 1, no special action needed            }
  fld     st(1)              { int(z) | frac(z) | int(z)                         }
  fabs                       { abs(int(z)) | frac(z) | int(z)                    }
  fcomp   [ebig]
  fstsw   ax
  sahf
  jb      @@0
  fsub    st,st              { set frac=0 and scale with too large int(z)}
  jmp     @@1
@@0:
  {Safely calculate 2^frac(z)-1 as (2^(frac(z)/2)-1)*(2^(frac(z)/2)+1) and use   }
  {2^(frac(z)/2)+1 = (2^(frac(z)/2)-1) + 2 (suggested by N. Juffa, 16.Jan.2011)  }
  fmul    dword ptr [half]   { frac(z)/2  | int(z)                               }
  f2xm1                      { 2^(frac(z)/2)-1 | int(z)                          }
  fld     st                 { 2^(frac(z)/2)-1 | 2^(frac(z)/2)-1 | int(z)        }
  fadd    dword ptr [two]    { 2^(frac(z)/2)+1 | 2^(frac(z)/2)-1 | int(z)        }
  fmulp   st(1),st           { 2^frac(z)-1 | int(z)                              }
  jmp     @@2
{$endif}

@@1:
  f2xm1                      { 2^frac(z)-1 | int(z)                              }

@@2:
  fld1                       { 1 | 2^frac(z)-1 | int(z)                          }
  faddp   st(1),st           { 2^frac(z) | int(z)                                }
  fscale                     { 2^z | int(z)                                      }
  fstp    st(1)              { 2^z = e^x                                         }
  fwait
end;




function ilogb(x: extended): longint;
  {-Return base 2 exponent of x. For finite x ilogb = floor(log2(|x|))}
  { otherwise -MaxLongint for x=0 and MaxLongint if x = +-INF or Nan. }
var
  e: integer;
  f: longint;
  m: extended;
begin
  e := THexExtW(x)[4] and $7FFF;
  if e=$7FFF then ilogb := MaxLongint
  else if x=0.0 then ilogb := -MaxLongint
  else if e<>0 then  ilogb := e-$3FFF
  else begin
    {e=0, x<>0: denormal use frexp exponent}
    frexp(x,m,f);
    ilogb := f-1;
  end;
end;


function intpower_f(x: extended; n: integer): extended; assembler; {&Frame-} {&Uses none}
  {-Return x^n; via binary exponentiation (no overflow detection)}
asm
       mov    eax,n     {Note: this may be a mov eax,eax in Delphi/FPC}
                        {but it is needed in VirtualPascal}
       fld1             {r := 1 }
       cdq              {edx=-1 if n<0, 0 otherwise}
       xor    eax,edx
       sub    eax,edx   {eax == i := abs(n)}
       jz     @@3       {if n=0 done}
       fld    [x]
       jmp    @@2
  @@1: fmul   st,st     {x := x*x }
  @@2: shr    eax,1     {i := i shr 1}
       jnc    @@1       {i had not been odd, repeat squaring}
       fmul   st(1),st  {r := r*x }
       jnz    @@1       {if i=0 exit loop}
       fstp   st        {pop x}
       or     edx,edx   {n<0 iff dx<>0}
       jz     @@3
       fld1
       fdivrp st(1),st  {intpower := 1/r; FPC does not like fdivr}
  @@3: fwait
end;



function intpower_acc(x: extended; n: integer): extended;
  {-Return x^n; via binary exponentiation (no overflow detection)}
var
  i: longint;
  r: extended;
begin
  i := abs(n);
  r := abs(x);
  if (i=0) or (r=1.0) then begin
    if odd(i) and (x < 0) then intpower_acc := -1
    else intpower_acc := 1.0;
    exit;
  end;
  if (n<0) and (r>1.0) then begin
    if (1.0+ilogb(r))*i >= 16383 then begin
      {avoid spurious overflow, use x^(-n) = (1/x)^n}
      {so that e.g. 2^(-16400) is computed as denormal}
      x := 1.0/x;
      n := i;
    end;
  end;
  {Use internal assembler function}
  intpower_acc := intpower_f(x,n);
end;



function intpower_fa(x: extended; n: integer): extended;
begin
  if F_FastSpec = True then  intpower_fa:=intpower_f(x,n) else  intpower_fa:=intpower_acc(x,n)
end;



function power_acc(x, y : extended): extended;
  {-Return x^y; if frac(y)<>0 then x must be > 0}

  {This is my Pascal translation of the ldouble/powl.c file from the   }
  {freely distributable Cephes Mathematical Library V2.8, (June 2000)  }
  {Copyright 1984, 1991, 1998 by Stephen L. Moshier                    }

  {Following Cody and Waite, the Cephes function uses a lookup table of}
  {2**-i/NXT and pseudo extended precision arithmetic to obtain several}
  {extra bits of accuracy in both the logarithm and the exponential.   }

  {My routine uses a table size of 512 entries resulting in about four }
  {additional bits of accuracy; the tables are calculated with MPArith.}

const
  NXT = 512;  {table size, must be power of 2}

const
  MEXP   =  NXT*16384.0;
  MNEXP  = -NXT*(16384.0+64.0);    {+64 for denormal support}

const
  LOG2EA : THexExtW = ($c2ef,$705f,$eca5,$e2a8,$3ffd); { = 0.44269504088896340736 = log2(e)-1}

const
  {Coefficients for log(1+x) =  x - .5x^2 + x^3 *  P(z)/Q(z) }
  {on the domain  2^(-1/32) - 1  <=  x  <=  2^(1/32) - 1     }
  PH: array[0..3] of THexExtW = (
        ($b804,$a8b7,$c6f4,$da6a,$3ff4),
        ($7de9,$cf02,$58c0,$fae1,$3ffd),
        ($405a,$3722,$67c9,$e000,$3fff),
        ($cd99,$6b43,$87ca,$b333,$3fff));
  QH: array[0..2] of THexExtW = (
        ($6307,$a469,$3b33,$a800,$4001),
        ($fec2,$62d7,$a51c,$8666,$4002),
        ($da32,$d072,$a5d7,$8666,$4001));
  {Coefficients for 2^x = 1 + x P(x),  on the interval -1/32 <= x <= 0}
  RH: array[0..6] of THexExtW = (
        ($a69b,$530e,$ee1d,$fd2a,$3fee),
        ($c746,$8e7e,$5960,$a182,$3ff2),
        ($63b6,$adda,$fd6a,$aec3,$3ff5),
        ($c104,$fd99,$5b7c,$9d95,$3ff8),
        ($e05e,$249d,$46b8,$e358,$3ffa),
        ($5d1d,$162c,$effc,$f5fd,$3ffc),
        ($79aa,$d1cf,$17f7,$b172,$3ffe));
var
  P: array[0..3] of extended absolute PH;
  Q: array[0..2] of extended absolute QH;
  R: array[0..6] of extended absolute RH;

const
  {A[i] = 2^(-i/NXT), calculated with MPArith/t_powtab.pas}
  {If i is even, A[i] + B[i/2] gives additional accuracy. }
  A: array[0..NXT] of THexExtW = (
       ($0000,$0000,$0000,$8000,$3fff), ($aed2,$1c8d,$5652,$ffa7,$3ffe), ($c8a5,$511e,$cb59,$ff4e,$3ffe),
       ($a3ca,$fb18,$5f0a,$fef6,$3ffe), ($884c,$7b8f,$115c,$fe9e,$3ffe), ($695d,$3745,$e243,$fe45,$3ffe),
       ($9f35,$96a8,$d1b4,$fded,$3ffe), ($a15e,$05d2,$dfa6,$fd95,$3ffe), ($c175,$f486,$0c0c,$fd3e,$3ffe),
       ($e654,$d630,$56de,$fce6,$3ffe), ($47bb,$21e4,$c011,$fc8e,$3ffe), ($2a57,$525a,$4799,$fc37,$3ffe),
       ($9c49,$e5f0,$ed6c,$fbdf,$3ffe), ($3211,$5ea9,$b181,$fb88,$3ffe), ($c3f4,$4227,$93cc,$fb31,$3ffe),
       ($2bca,$19b1,$9443,$fada,$3ffe), ($033a,$722a,$b2db,$fa83,$3ffe), ($6270,$dc15,$ef8a,$fa2c,$3ffe),
       ($9f35,$eb93,$4a46,$f9d6,$3ffe), ($0c81,$3861,$c305,$f97f,$3ffe), ($ba74,$5dd4,$59bb,$f929,$3ffe),
       ($36c6,$fadf,$0e5e,$f8d3,$3ffe), ($4d9c,$b209,$e0e5,$f87c,$3ffe), ($cad3,$2972,$d145,$f826,$3ffe),
       ($3bb9,$0ad1,$df73,$f7d0,$3ffe), ($b12e,$036e,$0b65,$f77b,$3ffe), ($8239,$c428,$5510,$f725,$3ffe),
       ($0f0b,$016e,$bc6c,$f6cf,$3ffe), ($846e,$733f,$416c,$f67a,$3ffe), ($9f9c,$d52c,$e407,$f624,$3ffe),
       ($7290,$e653,$a433,$f5cf,$3ffe), ($28bd,$695f,$81e6,$f57a,$3ffe), ($cc2c,$2486,$7d15,$f525,$3ffe),
       ($0b17,$e18c,$95b5,$f4d0,$3ffe), ($fddf,$6db9,$cbbe,$f47b,$3ffe), ($ed7e,$99e3,$1f24,$f427,$3ffe),
       ($1a5b,$3a64,$8fde,$f3d2,$3ffe), ($8390,$271a,$1de1,$f37e,$3ffe), ($ae9c,$3b6b,$c923,$f329,$3ffe),
       ($6f7d,$563f,$919a,$f2d5,$3ffe), ($b13a,$59ff,$773c,$f281,$3ffe), ($3eda,$2c97,$79ff,$f22d,$3ffe),
       ($8cc1,$b770,$99d8,$f1d9,$3ffe), ($8280,$e774,$d6be,$f185,$3ffe), ($4509,$ad09,$30a7,$f132,$3ffe),
       ($0154,$fc11,$a788,$f0de,$3ffe), ($b76a,$cbe8,$3b58,$f08b,$3ffe), ($05e5,$1767,$ec0d,$f037,$3ffe),
       ($f5cb,$dcda,$b99b,$efe4,$3ffe), ($c6e3,$1e0a,$a3fb,$ef91,$3ffe), ($bc6b,$e032,$ab20,$ef3e,$3ffe),
       ($ea3d,$2c03,$cf03,$eeeb,$3ffe), ($025b,$0da3,$0f98,$ee99,$3ffe), ($22ea,$94a7,$6cd5,$ee46,$3ffe),
       ($a491,$d418,$e6b1,$edf3,$3ffe), ($e946,$e26f,$7d22,$eda1,$3ffe), ($2b84,$d994,$301e,$ed4f,$3ffe),
       ($4dea,$d6da,$ff9b,$ecfc,$3ffe), ($ab41,$fb03,$eb8f,$ecaa,$3ffe), ($e6f1,$6a3c,$f3f1,$ec58,$3ffe),
       ($bddc,$4c1c,$18b6,$ec07,$3ffe), ($d79f,$cba2,$59d4,$ebb5,$3ffe), ($9840,$1736,$b743,$eb63,$3ffe),
       ($f244,$60a5,$30f7,$eb12,$3ffe), ($392f,$dd24,$c6e7,$eac0,$3ffe), ($f464,$c548,$790a,$ea6f,$3ffe),
       ($b27b,$550e,$4756,$ea1e,$3ffe), ($dcf5,$cbd1,$31c0,$e9cd,$3ffe), ($8c57,$6c4f,$3840,$e97c,$3ffe),
       ($5cb8,$7ca4,$5acb,$e92b,$3ffe), ($42ab,$464b,$9958,$e8da,$3ffe), ($6094,$161c,$f3dd,$e889,$3ffe),
       ($dc68,$3c4b,$6a50,$e839,$3ffe), ($b5d3,$0c68,$fca8,$e7e8,$3ffe), ($9cbf,$dd5b,$aada,$e798,$3ffe),
       ($c84b,$0965,$74df,$e748,$3ffe), ($ce22,$ee1f,$5aaa,$e6f8,$3ffe), ($7a41,$ec78,$5c34,$e6a8,$3ffe),
       ($a717,$68b3,$7973,$e658,$3ffe), ($1616,$ca69,$b25c,$e608,$3ffe), ($48a8,$7c83,$06e7,$e5b9,$3ffe),
       ($5988,$ed3e,$7709,$e569,$3ffe), ($d681,$8e26,$02ba,$e51a,$3ffe), ($9a96,$d418,$a9ef,$e4ca,$3ffe),
       ($a88d,$373d,$6ca0,$e47b,$3ffe), ($05e2,$330d,$4ac2,$e42c,$3ffe), ($9619,$4649,$444c,$e3dd,$3ffe),
       ($f681,$f300,$5934,$e38e,$3ffe), ($5a51,$be8a,$8972,$e33f,$3ffe), ($6732,$3185,$d4fc,$e2f0,$3ffe),
       ($1226,$d7d9,$3bc7,$e2a2,$3ffe), ($7cdd,$40b2,$bdcc,$e253,$3ffe), ($d369,$fe83,$5aff,$e205,$3ffe),
       ($2a54,$a703,$1359,$e1b7,$3ffe), ($5d23,$d329,$e6cf,$e168,$3ffe), ($ed37,$1f30,$d559,$e11a,$3ffe),
       ($e111,$2a94,$deec,$e0cc,$3ffe), ($a3fe,$980f,$037f,$e07f,$3ffe), ($e627,$0d99,$430a,$e031,$3ffe),
       ($7d00,$3469,$9d82,$dfe3,$3ffe), ($4420,$b8f0,$12de,$df96,$3ffe), ($fe78,$4ada,$a316,$df48,$3ffe),
       ($37f2,$9d10,$4e1f,$defb,$3ffe), ($276d,$65af,$13f1,$deae,$3ffe), ($9124,$5e0e,$f482,$de60,$3ffe),
       ($a96f,$42bb,$efc9,$de13,$3ffe), ($f7f0,$d378,$05bc,$ddc7,$3ffe), ($3b1a,$d33d,$3653,$dd7a,$3ffe),
       ($4c20,$0832,$8185,$dd2d,$3ffe), ($0346,$3bb4,$e747,$dce0,$3ffe), ($1c92,$3a4f,$6791,$dc94,$3ffe),
       ($1cde,$d3c0,$0259,$dc48,$3ffe), ($3755,$daf2,$b797,$dbfb,$3ffe), ($3343,$25fe,$8742,$dbaf,$3ffe),
       ($5255,$8e29,$714f,$db63,$3ffe), ($3730,$efe4,$75b6,$db17,$3ffe), ($cc72,$2ac9,$946f,$dacb,$3ffe),
       ($2c0c,$219e,$cd6f,$da7f,$3ffe), ($8704,$ba4d,$20ad,$da34,$3ffe), ($0d97,$ddeb,$8e21,$d9e8,$3ffe),
       ($d7b6,$78af,$15c2,$d99d,$3ffe), ($cdeb,$79f9,$b786,$d951,$3ffe), ($929c,$d44a,$7364,$d906,$3ffe),
       ($6bac,$7d46,$4954,$d8bb,$3ffe), ($2c84,$6db3,$394c,$d870,$3ffe), ($2070,$a177,$4343,$d825,$3ffe),
       ($f56a,$1797,$6731,$d7da,$3ffe), ($a737,$d239,$a50b,$d78f,$3ffe), ($6af4,$d69d,$fcca,$d744,$3ffe),
       ($9af2,$2d20,$6e65,$d6fa,$3ffe), ($a2fe,$e13b,$f9d1,$d6af,$3ffe), ($ed01,$0180,$9f08,$d665,$3ffe),
       ($ce07,$9f9b,$5dfe,$d61b,$3ffe), ($739a,$d04f,$36ac,$d5d1,$3ffe), ($d18a,$ab75,$2909,$d587,$3ffe),
       ($9006,$4bfe,$350c,$d53d,$3ffe), ($fa1f,$cfed,$5aab,$d4f3,$3ffe), ($eca5,$585b,$99df,$d4a9,$3ffe),
       ($c561,$0972,$f29e,$d45f,$3ffe), ($52af,$0a6e,$64df,$d416,$3ffe), ($c379,$859a,$f099,$d3cc,$3ffe),
       ($978e,$a853,$95c4,$d383,$3ffe), ($9054,$a302,$5457,$d33a,$3ffe), ($a1de,$a91e,$2c49,$d2f1,$3ffe),
       ($e45a,$f12a,$1d91,$d2a8,$3ffe), ($85e3,$b4b5,$2827,$d25f,$3ffe), ($bcab,$3056,$4c02,$d216,$3ffe),
       ($b983,$a3af,$8918,$d1cd,$3ffe), ($9ac6,$5169,$df62,$d184,$3ffe), ($5f98,$7f34,$4ed6,$d13c,$3ffe),
       ($db8d,$75c5,$d76c,$d0f3,$3ffe), ($aaa0,$80d8,$791b,$d0ab,$3ffe), ($2595,$ef2b,$33da,$d063,$3ffe),
       ($56ab,$127e,$07a2,$d01b,$3ffe), ($eeb5,$3f94,$f468,$cfd2,$3ffe), ($3a86,$ce32,$fa24,$cf8a,$3ffe),
       ($18c1,$1919,$18cf,$cf43,$3ffe), ($f001,$7e0a,$505e,$cefb,$3ffe), ($a55d,$5dc6,$a0ca,$ceb3,$3ffe),
       ($934d,$1c07,$0a0a,$ce6c,$3ffe), ($80e4,$1f84,$8c15,$ce24,$3ffe), ($9967,$d1ee,$26e2,$cddd,$3ffe),
       ($6445,$9ff0,$da6a,$cd95,$3ffe), ($bd65,$f92c,$a6a3,$cd4e,$3ffe), ($cdd2,$503d,$8b86,$cd07,$3ffe),
       ($04bd,$1ab4,$8909,$ccc0,$3ffe), ($10e5,$d115,$9f23,$cc79,$3ffe), ($da4f,$eeda,$cdcd,$cc32,$3ffe),
       ($7c5d,$f272,$14fe,$cbec,$3ffe), ($4041,$5d3b,$74ae,$cba5,$3ffe), ($97c9,$b385,$ecd3,$cb5e,$3ffe),
       ($1886,$7c92,$7d66,$cb18,$3ffe), ($774e,$4290,$265e,$cad2,$3ffe), ($8414,$929e,$e7b2,$ca8b,$3ffe),
       ($2624,$fcc7,$c15a,$ca45,$3ffe), ($58aa,$1401,$b34f,$c9ff,$3ffe), ($27a3,$6e2f,$bd86,$c9b9,$3ffe),
       ($ad1a,$a41c,$dff8,$c973,$3ffe), ($0ecc,$517f,$1a9d,$c92e,$3ffe), ($7c14,$14f3,$6d6c,$c8e8,$3ffe),
       ($2c45,$8ffe,$d85c,$c8a2,$3ffe), ($5d4c,$6709,$5b66,$c85d,$3ffe), ($52b2,$4164,$f681,$c817,$3ffe),
       ($54fd,$c942,$a9a4,$c7d2,$3ffe), ($b15d,$abb9,$74c8,$c78d,$3ffe), ($b9ba,$98c2,$57e4,$c748,$3ffe),
       ($c51e,$4336,$52f0,$c703,$3ffe), ($306b,$60cf,$65e3,$c6be,$3ffe), ($5f79,$aa24,$90b5,$c679,$3ffe),
       ($be7f,$daac,$d35e,$c634,$3ffe), ($c3d9,$b0bb,$2dd6,$c5f0,$3ffe), ($f22e,$ed80,$a014,$c5ab,$3ffe),
       ($dadd,$5506,$2a11,$c567,$3ffe), ($20d3,$ae32,$cbc3,$c522,$3ffe), ($7baa,$c2c0,$8523,$c4de,$3ffe),
       ($bb30,$5f47,$5629,$c49a,$3ffe), ($cb33,$5334,$3ecc,$c456,$3ffe), ($b7b1,$70ca,$3f04,$c412,$3ffe),
       ($b15d,$8d21,$56c9,$c3ce,$3ffe), ($1279,$8026,$8613,$c38a,$3ffe), ($6407,$2497,$ccda,$c346,$3ffe),
       ($6351,$5807,$2b15,$c303,$3ffe), ($07c9,$fad9,$a0bc,$c2bf,$3ffe), ($8940,$f03f,$2dc8,$c27c,$3ffe),
       ($6673,$1e3d,$d231,$c238,$3ffe), ($6be9,$6da3,$8ded,$c1f5,$3ffe), ($bb33,$ca0f,$60f5,$c1b2,$3ffe),
       ($d278,$21ec,$4b42,$c16f,$3ffe), ($9456,$6670,$4cca,$c12c,$3ffe), ($5028,$8b9b,$6586,$c0e9,$3ffe),
       ($ca8d,$8836,$956e,$c0a6,$3ffe), ($4652,$55d5,$dc7a,$c063,$3ffe), ($8db0,$f0d0,$3aa1,$c021,$3ffe),
       ($fbdf,$5848,$afdd,$bfde,$3ffe), ($86f8,$8e24,$3c24,$bf9c,$3ffe), ($ca35,$970d,$df6f,$bf59,$3ffe),
       ($1083,$7a73,$99b6,$bf17,$3ffe), ($5f66,$4285,$6af1,$bed5,$3ffe), ($8238,$fc37,$5317,$be93,$3ffe),
       ($15b4,$b73d,$5222,$be51,$3ffe), ($93e2,$8609,$6809,$be0f,$3ffe), ($6049,$7dcf,$94c4,$bdcd,$3ffe),
       ($d483,$b67e,$d84b,$bd8b,$3ffe), ($4d18,$4ac5,$3297,$bd4a,$3ffe), ($36bf,$580c,$a39f,$bd08,$3ffe),
       ($1bdc,$fe78,$2b5b,$bcc7,$3ffe), ($b269,$60e7,$c9c5,$bc85,$3ffe), ($ea22,$a4f2,$7ed3,$bc44,$3ffe),
       ($fb0d,$f2e9,$4a7e,$bc03,$3ffe), ($7453,$75d4,$2cbf,$bbc2,$3ffe), ($4b6f,$5b70,$258d,$bb81,$3ffe),
       ($ebac,$d430,$34e0,$bb40,$3ffe), ($45fb,$133e,$5ab2,$baff,$3ffe), ($e119,$4e73,$96f9,$babe,$3ffe),
       ($ea09,$be5f,$e9ae,$ba7d,$3ffe), ($44e1,$9e42,$52ca,$ba3d,$3ffe), ($9deb,$2c0b,$d245,$b9fc,$3ffe),
       ($7b17,$a85c,$6816,$b9bc,$3ffe), ($4dbf,$5684,$1437,$b97c,$3ffe), ($84c1,$7c80,$d69f,$b93b,$3ffe),
       ($9ee9,$62fb,$af47,$b8fb,$3ffe), ($3dab,$554c,$9e27,$b8bb,$3ffe), ($3834,$a174,$a337,$b87b,$3ffe),
       ($aec9,$981f,$be70,$b83b,$3ffe), ($1e7c,$8ca4,$efca,$b7fb,$3ffe), ($752f,$d4ff,$373d,$b7bc,$3ffe),
       ($25e9,$c9d7,$94c2,$b77c,$3ffe), ($3d80,$c677,$0851,$b73d,$3ffe), ($7791,$28d1,$91e3,$b6fd,$3ffe),
       ($53cc,$517c,$316f,$b6be,$3ffe), ($2b8f,$a3b2,$e6ee,$b67e,$3ffe), ($47d3,$8550,$b259,$b63f,$3ffe),
       ($f76c,$5ed5,$93a8,$b600,$3ffe), ($a594,$9b63,$8ad3,$b5c1,$3ffe), ($f0d2,$a8b9,$97d3,$b582,$3ffe),
       ($c224,$f738,$baa0,$b543,$3ffe), ($6484,$f9de,$f333,$b504,$3ffe), ($9cbb,$2646,$4185,$b4c6,$3ffe),
       ($c180,$f4a9,$a58c,$b487,$3ffe), ($d3ed,$dfdb,$1f43,$b449,$3ffe), ($9841,$654b,$aea2,$b40a,$3ffe),
       ($aef3,$0501,$53a1,$b3cc,$3ffe), ($ae18,$419f,$0e38,$b38e,$3ffe), ($3b0e,$a05f,$de60,$b34f,$3ffe),
       ($2489,$a911,$c412,$b311,$3ffe), ($7cdd,$e61c,$bf46,$b2d3,$3ffe), ($b4a4,$e47d,$cff5,$b295,$3ffe),
       ($b5ac,$33c5,$f618,$b257,$3ffe), ($fe3b,$6618,$31a6,$b21a,$3ffe), ($bc9f,$102e,$8299,$b1dc,$3ffe),
       ($eb09,$c94f,$e8e8,$b19e,$3ffe), ($6bbd,$2b56,$648e,$b161,$3ffe), ($2590,$d2ac,$f581,$b123,$3ffe),
       ($20b2,$5e4a,$9bbc,$b0e6,$3ffe), ($a3c9,$6fb7,$5736,$b0a9,$3ffe), ($515c,$ab09,$27e8,$b06c,$3ffe),
       ($4584,$b6e0,$0dcb,$b02f,$3ffe), ($33f9,$3c69,$08d8,$aff2,$3ffe), ($8661,$e75b,$1906,$afb5,$3ffe),
       ($7af7,$65f8,$3e50,$af78,$3ffe), ($4375,$690a,$78ad,$af3b,$3ffe), ($2457,$a3e3,$c816,$aefe,$3ffe),
       ($9465,$cc5c,$2c84,$aec2,$3ffe), ($5c8e,$9ad6,$a5f0,$ae85,$3ffe), ($b80e,$ca35,$3452,$ae49,$3ffe),
       ($74e3,$17e4,$d7a4,$ae0c,$3ffe), ($1491,$43d0,$8fdd,$add0,$3ffe), ($ed2f,$1068,$5cf7,$ad94,$3ffe),
       ($4ac6,$42a1,$3eea,$ad58,$3ffe), ($90fb,$a1ec,$35af,$ad1c,$3ffe), ($5d04,$f83e,$413f,$ace0,$3ffe),
       ($a7ed,$1209,$6194,$aca4,$3ffe), ($e929,$be3f,$96a4,$ac68,$3ffe), ($3971,$ce50,$e06a,$ac2c,$3ffe),
       ($75e9,$1626,$3edf,$abf1,$3ffe), ($639b,$6c2a,$b1fa,$abb5,$3ffe), ($d337,$a93e,$39b5,$ab7a,$3ffe),
       ($c526,$a8c0,$d609,$ab3e,$3ffe), ($8de1,$4886,$86ef,$ab03,$3ffe), ($fa98,$68de,$4c5f,$aac8,$3ffe),
       ($7629,$ec90,$2652,$aa8d,$3ffe), ($2e5f,$b8d8,$14c2,$aa52,$3ffe), ($3979,$b569,$17a7,$aa17,$3ffe),
       ($bc03,$cc6b,$2efa,$a9dc,$3ffe), ($0ef8,$ea7c,$5ab4,$a9a1,$3ffe), ($e631,$fea9,$9ace,$a966,$3ffe),
       ($771b,$fa77,$ef41,$a92b,$3ffe), ($9fbe,$d1d8,$5806,$a8f1,$3ffe), ($0e09,$7b32,$d516,$a8b6,$3ffe),
       ($6770,$ef58,$6669,$a87c,$3ffe), ($70d1,$298f,$0bfa,$a842,$3ffe), ($36a1,$2789,$c5c0,$a807,$3ffe),
       ($356a,$e965,$93b4,$a7cd,$3ffe), ($828e,$71af,$75d1,$a793,$3ffe), ($f55b,$c55f,$6c0e,$a759,$3ffe),
       ($5062,$ebd9,$7665,$a71f,$3ffe), ($6b1e,$eee8,$94cf,$a6e5,$3ffe), ($5bdf,$dac3,$c745,$a6ab,$3ffe),
       ($a20c,$be08,$0dc0,$a672,$3ffe), ($509c,$a9be,$6839,$a638,$3ffe), ($38ea,$b151,$d6a9,$a5fe,$3ffe),
       ($15cb,$ea94,$5909,$a5c5,$3ffe), ($b6ee,$6dbe,$ef53,$a58b,$3ffe), ($2c84,$556d,$997f,$a552,$3ffe),
       ($f339,$be9e,$5786,$a519,$3ffe), ($2070,$c8b6,$2962,$a4e0,$3ffe), ($8ec5,$9576,$0f0c,$a4a7,$3ffe),
       ($0ae4,$4905,$087d,$a46e,$3ffe), ($809e,$09e6,$15ae,$a435,$3ffe), ($284c,$00ff,$3698,$a3fc,$3ffe),
       ($b47c,$5991,$6b34,$a3c3,$3ffe), ($7fe0,$413e,$b37c,$a38a,$3ffe), ($bb93,$e802,$0f68,$a352,$3ffe),
       ($9d94,$8037,$7ef3,$a319,$3ffe), ($8f9e,$3e91,$0215,$a2e1,$3ffe), ($5e39,$5a1f,$98c7,$a2a8,$3ffe),
       ($6819,$0c49,$4303,$a270,$3ffe), ($cdc5,$90d0,$00c1,$a238,$3ffe), ($a188,$25ce,$d1fc,$a1ff,$3ffe),
       ($17a8,$0bb3,$b6ac,$a1c7,$3ffe), ($b6e4,$8544,$aeca,$a18f,$3ffe), ($8939,$d79f,$ba50,$a157,$3ffe),
       ($4cf7,$4a34,$d938,$a11f,$3ffe), ($a612,$26c7,$0b7a,$a0e8,$3ffe), ($4fc2,$b971,$510f,$a0b0,$3ffe),
       ($4e69,$509b,$a9f2,$a078,$3ffe), ($21be,$3d01,$161b,$a041,$3ffe), ($f745,$d1ae,$9583,$a009,$3ffe),
       ($dd06,$6400,$2825,$9fd2,$3ffe), ($f493,$4ba1,$cdf9,$9f9a,$3ffe), ($a651,$e28b,$86f8,$9f63,$3ffe),
       ($d504,$8504,$531d,$9f2c,$3ffe), ($11ae,$91a1,$3260,$9ef5,$3ffe), ($cfa5,$693f,$24bb,$9ebe,$3ffe),
       ($98ff,$6f0b,$2a27,$9e87,$3ffe), ($4337,$0879,$429e,$9e50,$3ffe), ($2420,$9d47,$6e18,$9e19,$3ffe),
       ($4720,$977c,$ac90,$9de2,$3ffe), ($a2aa,$6367,$fdff,$9dab,$3ffe), ($4e03,$6f9f,$625e,$9d75,$3ffe),
       ($b751,$2cff,$d9a7,$9d3e,$3ffe), ($d9e2,$0eaa,$63d3,$9d08,$3ffe), ($74cb,$8a07,$00db,$9cd2,$3ffe),
       ($41be,$16c0,$b0ba,$9c9b,$3ffe), ($2c2d,$2ec3,$7368,$9c65,$3ffe), ($88b4,$4e40,$48df,$9c2f,$3ffe),
       ($4cc1,$f3aa,$3118,$9bf9,$3ffe), ($4688,$9fb3,$2c0e,$9bc3,$3ffe), ($5539,$d54e,$39b9,$9b8d,$3ffe),
       ($a17e,$19ad,$5a14,$9b57,$3ffe), ($d63d,$f441,$8d16,$9b21,$3ffe), ($599b,$eeb9,$d2bb,$9aeb,$3ffe),
       ($864a,$94ff,$2afc,$9ab6,$3ffe), ($e51a,$753b,$95d2,$9a80,$3ffe), ($66ca,$1fd1,$1337,$9a4b,$3ffe),
       ($9e27,$275d,$a324,$9a15,$3ffe), ($fa65,$20b7,$4593,$99e0,$3ffe), ($01c4,$a2f1,$fa7d,$99aa,$3ffe),
       ($8c77,$4751,$c1dd,$9975,$3ffe), ($ffcf,$a959,$9bab,$9940,$3ffe), ($89aa,$66c1,$87e2,$990b,$3ffe),
       ($5c25,$1f75,$867b,$98d6,$3ffe), ($e996,$7597,$976f,$98a1,$3ffe), ($20c6,$0d80,$bab9,$986c,$3ffe),
       ($a96f,$8db8,$f051,$9837,$3ffe), ($2103,$9eff,$3832,$9803,$3ffe), ($57ab,$ec43,$9255,$97ce,$3ffe),
       ($8d99,$22a6,$feb5,$9799,$3ffe), ($b08e,$f17a,$7d49,$9765,$3ffe), ($99b3,$0a41,$0e0e,$9731,$3ffe),
       ($4ba3,$20ac,$b0fb,$96fc,$3ffe), ($30cb,$ea9a,$660a,$96c8,$3ffe), ($5a00,$2018,$2d37,$9694,$3ffe),
       ($bd5c,$7b60,$0679,$9660,$3ffe), ($7560,$b8d9,$f1cb,$962b,$3ffe), ($0054,$9714,$ef27,$95f7,$3ffe),
       ($7fef,$d6cc,$fe86,$95c3,$3ffe), ($f940,$3ae8,$1fe3,$9590,$3ffe), ($94d5,$8878,$5336,$955c,$3ffe),
       ($df2c,$86b2,$987a,$9528,$3ffe), ($0961,$fef7,$efa8,$94f4,$3ffe), ($2a1f,$bccb,$58bb,$94c1,$3ffe),
       ($7ed3,$8ddb,$d3ac,$948d,$3ffe), ($ad28,$41f9,$6075,$945a,$3ffe), ($04b6,$ab1c,$ff0f,$9426,$3ffe),
       ($c105,$9d5c,$af75,$93f3,$3ffe), ($4bc1,$eef9,$71a0,$93c0,$3ffe), ($7f3c,$7851,$458b,$938d,$3ffe),
       ($e92c,$13e6,$2b2f,$935a,$3ffe), ($0dac,$9e5c,$2285,$9327,$3ffe), ($aa7c,$f673,$2b88,$92f4,$3ffe),
       ($fa89,$fd0f,$4632,$92c1,$3ffe), ($f9ac,$9531,$727d,$928e,$3ffe), ($a8b4,$a3f8,$b062,$925b,$3ffe),
       ($51ad,$10a0,$ffdc,$9228,$3ffe), ($cc64,$c481,$60e3,$91f6,$3ffe), ($c336,$ab11,$d373,$91c3,$3ffe),
       ($f815,$b1df,$5785,$9191,$3ffe), ($89d3,$c896,$ed13,$915e,$3ffe), ($39b3,$e0f9,$9417,$912c,$3ffe),
       ($b12b,$eee4,$4c8b,$90fa,$3ffe), ($c7f9,$e84d,$1669,$90c8,$3ffe), ($ca6b,$c540,$f1ab,$9095,$3ffe),
       ($bfef,$7fe0,$de4b,$9063,$3ffe), ($b1dc,$1466,$dc43,$9031,$3ffe), ($f285,$8120,$eb8c,$8fff,$3ffe),
       ($6481,$c672,$0c21,$8fce,$3ffe), ($c23d,$e6d1,$3dfc,$8f9c,$3ffe), ($e5c4,$e6c8,$8117,$8f6a,$3ffe),
       ($10d3,$ccf4,$d56c,$8f38,$3ffe), ($3520,$a201,$3af5,$8f07,$3ffe), ($3ce9,$70af,$b1ac,$8ed5,$3ffe),
       ($53c0,$45cd,$398b,$8ea4,$3ffe), ($2f95,$303a,$d28c,$8e72,$3ffe), ($5a01,$40e3,$7ca9,$8e41,$3ffe),
       ($79d3,$8ac4,$37dc,$8e10,$3ffe), ($9cd6,$22e6,$0420,$8ddf,$3ffe), ($81d8,$205f,$e16e,$8dad,$3ffe),
       ($e2f8,$9c50,$cfc0,$8d7c,$3ffe), ($c024,$b1e7,$cf11,$8d4b,$3ffe), ($a9e6,$7e5b,$df5b,$8d1a,$3ffe),
       ($0c60,$20ee,$0098,$8cea,$3ffe), ($7a95,$bae9,$32c1,$8cb9,$3ffe), ($f9e9,$6fa0,$75d2,$8c88,$3ffe),
       ($4dde,$646f,$c9c4,$8c57,$3ffe), ($4414,$c0b6,$2e91,$8c27,$3ffe), ($0085,$adde,$a434,$8bf6,$3ffe),
       ($4a01,$5754,$2aa7,$8bc6,$3ffe), ($d6e7,$ea8b,$c1e3,$8b95,$3ffe), ($9a18,$96fb,$69e4,$8b65,$3ffe),
       ($1032,$8e1e,$22a3,$8b35,$3ffe), ($8cfe,$0370,$ec1b,$8b04,$3ffe), ($8924,$2c72,$c645,$8ad4,$3ffe),
       ($f018,$40a4,$b11c,$8aa4,$3ffe), ($6e47,$7989,$ac9a,$8a74,$3ffe), ($bf7f,$12a1,$b8ba,$8a44,$3ffe),
       ($fd9a,$496e,$d575,$8a14,$3ffe), ($ef5e,$5d70,$02c6,$89e5,$3ffe), ($57a4,$9025,$40a7,$89b5,$3ffe),
       ($44b2,$2507,$8f13,$8985,$3ffe), ($5fdd,$618e,$ee03,$8955,$3ffe), ($3d5e,$8d2e,$5d72,$8926,$3ffe),
       ($ac6b,$f155,$dd5a,$88f6,$3ffe), ($078c,$d96e,$6db6,$88c7,$3ffe), ($8527,$92da,$0e80,$8898,$3ffe),
       ($8851,$6cf7,$bfb2,$8868,$3ffe), ($f1d4,$b919,$8146,$8839,$3ffe), ($717c,$ca8e,$5337,$880a,$3ffe),
       ($d792,$f698,$357f,$87db,$3ffe), ($66a0,$9473,$2819,$87ac,$3ffe), ($256c,$fd4e,$2afe,$877d,$3ffe),
       ($3131,$8c4e,$3e2a,$874e,$3ffe), ($1010,$9e8d,$6196,$871f,$3ffe), ($03c3,$9318,$953d,$86f0,$3ffe),
       ($5c88,$caef,$d919,$86c1,$3ffe), ($cc4a,$a905,$2d25,$8693,$3ffe), ($ba04,$923f,$915b,$8664,$3ffe),
       ($9563,$ed72,$05b5,$8636,$3ffe), ($2a9f,$2364,$8a2f,$8607,$3ffe), ($f694,$9ec9,$1ec1,$85d9,$3ffe),
       ($7b15,$cc48,$c367,$85aa,$3ffe), ($9376,$1a72,$781c,$857c,$3ffe), ($c95d,$f9c8,$3cd8,$854e,$3ffe),
       ($a9c0,$dcb8,$1198,$8520,$3ffe), ($1a29,$379c,$f656,$84f1,$3ffe), ($ae30,$80b8,$eb0b,$84c3,$3ffe),
       ($fd30,$303e,$efb3,$8495,$3ffe), ($f83c,$c049,$0447,$8468,$3ffe), ($4046,$acde,$28c3,$843a,$3ffe),
       ($7c8b,$73e9,$5d21,$840c,$3ffe), ($b132,$9541,$a15b,$83de,$3ffe), ($9628,$92a4,$f56c,$83b0,$3ffe),
       ($ee37,$efb6,$594e,$8383,$3ffe), ($de5a,$3203,$ccfd,$8355,$3ffe), ($4547,$e0fc,$5071,$8328,$3ffe),
       ($1333,$85f6,$e3a7,$82fa,$3ffe), ($a1d7,$ac2b,$8698,$82cd,$3ffe), ($0ca8,$e0bb,$393f,$82a0,$3ffe),
       ($894c,$b2a5,$fb97,$8272,$3ffe), ($c048,$b2ce,$cd9a,$8245,$3ffe), ($25ec,$73fc,$af43,$8218,$3ffe),
       ($5370,$8ad4,$a08c,$81eb,$3ffe), ($6056,$8dde,$a170,$81be,$3ffe), ($3bfd,$1581,$b1ea,$8191,$3ffe),
       ($0773,$bc03,$d1f3,$8164,$3ffe), ($6f7c,$1d88,$0188,$8138,$3ffe), ($06d4,$d814,$40a1,$810b,$3ffe),
       ($a0af,$8b85,$8f3b,$80de,$3ffe), ($ab6c,$d999,$ed4f,$80b1,$3ffe), ($8b84,$65e8,$5ad9,$8085,$3ffe),
       ($f6b1,$d5e5,$d7d2,$8058,$3ffe), ($4f51,$d0e0,$6436,$802c,$3ffe), ($0000,$0000,$0000,$8000,$3ffe));

  B: array[0..NXT div 2] of THexExtW = (
       ($0000,$0000,$0000,$0000,$0000), ($75f1,$bc63,$885f,$c06e,$3fbc), ($a1ed,$30c5,$4cd4,$a45b,$bfbd),
       ($7996,$d6b2,$a131,$ee62,$bfbc), ($23fa,$9c3e,$8b4d,$f581,$bfbd), ($ed9b,$4bb4,$c430,$8aba,$3fbd),
       ($3a32,$426a,$018d,$c4b4,$bfbd), ($9352,$0f8b,$4e4d,$decd,$3fbd), ($ff99,$62ba,$7628,$f84b,$3fbd),
       ($8143,$0442,$24f9,$b4b8,$3fbc), ($8d5b,$21a9,$86c7,$d2df,$3fbc), ($f811,$5153,$4607,$8019,$bfbd),
       ($8a8b,$f824,$b494,$b795,$bfb7), ($71b9,$b976,$bc54,$b92d,$bfbc), ($b9e0,$6310,$046b,$fced,$bfbd),
       ($f03c,$3c66,$a4f9,$cbc8,$3fbd), ($1f87,$db30,$18f5,$f73a,$3fbd), ($f2a3,$b0d9,$b054,$9480,$bfbb),
       ($a758,$8798,$7cdc,$b74d,$bfbd), ($7f23,$646f,$a919,$f15b,$3fb5), ($2da7,$b85c,$ab19,$bb3f,$bfbb),
       ($b86e,$5d58,$808e,$d6f3,$3fbd), ($cfcf,$b4c8,$42f5,$ec3f,$3fbc), ($e18c,$0bc4,$2a38,$ad64,$3fbd),
       ($7226,$291b,$39ed,$8cac,$3fbd), ($7cff,$5c4a,$6191,$ab5c,$3fbd), ($9321,$30a3,$3c06,$95de,$3fbd),
       ($f8e2,$0dde,$ca3a,$8736,$3fbc), ($f624,$4c97,$5b6d,$c01a,$3fbd), ($f23b,$506c,$1942,$b491,$bfbd),
       ($97d9,$0bf0,$0910,$9f3a,$3fbc), ($2748,$d2ff,$abf4,$bc2d,$bfbc), ($ac15,$3e46,$2932,$bf4a,$bfbc),
       ($20bd,$8514,$d685,$d4ef,$3fbd), ($259d,$efed,$3b0a,$f6e3,$bfba), ($d9ce,$8932,$32e4,$e4ef,$bfbc),
       ($8fbc,$58e1,$21a1,$f22f,$3fbd), ($43fe,$5717,$6dff,$e9b8,$bfbb), ($5160,$51be,$8fac,$f895,$3fbd),
       ($fbdb,$24a1,$8024,$83e1,$bfbb), ($8765,$76dd,$7a52,$f2f4,$3fbb), ($5d6e,$3d3f,$4342,$afb4,$bfbc),
       ($ddb5,$c442,$8805,$cbc4,$3fbd), ($8e61,$ab24,$c4aa,$d777,$bfbd), ($eecf,$5980,$9079,$9bfe,$3fba),
       ($3963,$50d1,$6c4a,$f8db,$bfbb), ($ac99,$7d75,$df0e,$b207,$bfbd), ($943c,$8a3a,$0dd6,$ba7a,$3fbd),
       ($7944,$ba66,$a091,$cb12,$3fb9), ($40a9,$b97a,$c086,$b4ab,$3fbd), ($9fa0,$e344,$2518,$8d70,$3fbd),
       ($b2ac,$6d49,$83a9,$988d,$bfbb), ($5e9c,$5ee6,$7498,$8be1,$bfbc), ($dc97,$9dfa,$3696,$ad2e,$3fbd),
       ($2972,$b47f,$6af5,$cb3c,$3fbd), ($7771,$7175,$32d9,$8595,$bfbd), ($a991,$78a6,$356a,$f610,$3fbc),
       ($43dd,$6e2f,$883f,$f352,$3fbb), ($1d1c,$f187,$dd36,$efdd,$bfbc), ($8358,$36fd,$6208,$9c21,$3fbd),
       ($2a20,$0f6a,$09ae,$bc61,$bfb7), ($83db,$4d18,$7e2a,$bf6d,$bfbd), ($1cbc,$ed94,$bf8d,$8559,$3fbc),
       ($ad2d,$b32d,$cc57,$bf03,$bfbd), ($ff78,$40b4,$2ee6,$e69a,$3fbc), ($6957,$1b4c,$4e47,$c449,$bfbb),
       ($1837,$3407,$b9db,$8d32,$bfbc), ($7a1e,$aecd,$45ae,$f389,$bfbc), ($58b5,$4c4c,$bdff,$b243,$3fbd),
       ($0795,$517f,$742b,$cf65,$bfba), ($8797,$f1a9,$b158,$dfb2,$3fbd), ($70d3,$3663,$0670,$f563,$3fbc),
       ($0143,$1ef2,$72be,$9124,$3fbb), ($8b0e,$bf14,$c09d,$ff4e,$3fba), ($3fd1,$56aa,$b86d,$b8fb,$3fba),
       ($01a1,$78c9,$ba0c,$f388,$bfbc), ($abf8,$996c,$8e6a,$a4ae,$bfbc), ($7873,$a64a,$a1c0,$c62a,$3fbd),
       ($21f2,$8dc0,$1cc9,$994f,$3fbc), ($7323,$e675,$113e,$a0ae,$3fbc), ($c895,$5069,$e383,$ee53,$bfbb),
       ($3036,$2fc1,$edaa,$9c9b,$bfba), ($14e6,$8c84,$73b9,$ef64,$bfbd), ($344f,$8ec8,$24c7,$bdaa,$3fbd),
       ($9231,$a140,$370b,$b6f8,$bfba), ($3b7d,$2256,$fc67,$9659,$bfbd), ($8383,$0390,$6a5f,$b7c9,$bfbd),
       ($a683,$6654,$5f4b,$f59e,$bfbc), ($2d04,$f5dd,$0dab,$fe3c,$bfbd), ($024d,$6fed,$c73b,$abf4,$bfbd),
       ($0385,$6e1c,$d3ed,$c368,$3fbc), ($aaed,$f499,$7f8f,$b2a1,$3fbd), ($6207,$24ff,$471a,$fb17,$bfbc),
       ($5d3b,$72dc,$e4d9,$a537,$bfbc), ($84aa,$c55d,$d161,$aa1c,$3fbd), ($4ef2,$1b9e,$10d1,$d7bf,$3fbd),
       ($7cde,$9376,$4325,$f8ab,$3fbc), ($0271,$0aa0,$1d48,$e551,$3fbd), ($9ed8,$b162,$20d2,$cf43,$bfbd),
       ($34c3,$ef34,$b6d1,$b5f4,$3fbc), ($e90a,$a2e0,$1584,$83b2,$3fbc), ($5a72,$5b3e,$e2c8,$9d23,$bfbd),
       ($c8f1,$bf6a,$6839,$d094,$bfbd), ($2880,$f54f,$77ca,$e68c,$3fbd), ($0f6b,$4a01,$fab3,$f88a,$3fbd),
       ($96b3,$aca3,$bab8,$f23c,$bfbd), ($a707,$354e,$649a,$de67,$3fbd), ($7c2d,$5246,$6cee,$ee30,$3fba),
       ($3d7b,$a07a,$7aa1,$bf51,$bfbb), ($da5f,$d319,$2351,$8901,$bfbd), ($b2dd,$7562,$4593,$9334,$3fbd),
       ($81bb,$2209,$1a37,$ed61,$bfbd), ($a10c,$25e0,$c093,$aefd,$bfbd), ($a77b,$9ef7,$556e,$d431,$3fbc),
       ($9a84,$e9a8,$fef4,$a3fa,$bfbc), ($a31d,$eff0,$228f,$ee2d,$3fba), ($0718,$8b27,$33a4,$e9aa,$3fbd),
       ($fcc0,$e4bd,$6478,$a79d,$bfb5), ($5478,$3b9f,$65d5,$d96c,$bfbb), ($46fe,$1c8c,$358b,$a80b,$bfbd),
       ($2d0d,$b35b,$bbc2,$dc3c,$3fbb), ($ece5,$6684,$ae95,$a6ec,$bfbd), ($ff37,$4277,$9e7c,$fc36,$3fbc),
       ($46da,$590d,$0d64,$ba4f,$bfbc), ($4b3f,$aa83,$e1bb,$e2cb,$3fb9), ($efe7,$c23c,$bc5c,$aa6d,$3fbd),
       ($0214,$b0cc,$7ff0,$9566,$bfbd), ($a511,$5e39,$6cac,$e15a,$bfbc), ($7d3e,$ea95,$1366,$b2fb,$3fbd),
       ($838b,$8b93,$5d68,$97b3,$3fbd), ($e500,$3363,$6118,$ea37,$bfbb), ($530c,$2670,$0d8c,$e64b,$bfbd),
       ($4670,$e629,$5371,$fb3c,$3fbc), ($0259,$822c,$69cf,$f572,$bfbd), ($e410,$d9a4,$4c4e,$f871,$3fbd),
       ($477b,$1aa3,$469b,$ef41,$bfbb), ($44e3,$25bd,$902d,$f05f,$bfbd), ($4b87,$09bd,$ae13,$cf92,$3fbd),
       ($cb15,$91c4,$d5b7,$90a6,$bfbd), ($70d3,$0dc8,$8646,$a443,$3fbd), ($bf35,$d132,$bf8c,$8367,$bfbc),
       ($dba0,$dea4,$a5d4,$ac2b,$3fbc), ($07b1,$0d44,$02d3,$9637,$3fbc), ($b6fe,$cca3,$b983,$bd67,$3fba),
       ($5d89,$eb34,$5191,$9301,$3fbd), ($79c4,$83b1,$19f9,$b3b9,$bfbd), ($ec93,$bcf2,$7343,$bc2b,$3fbd),
       ($7312,$e23a,$2bdc,$c645,$bfbc), ($00f3,$eb3c,$4764,$cb00,$3fbd), ($eed6,$fbe6,$a3ba,$db85,$bfbd),
       ($7264,$4ca6,$0243,$ec62,$3fbd), ($6cc4,$df77,$4b57,$9b46,$3fbc), ($f4e6,$6a63,$49d8,$a83c,$3fbd),
       ($b45b,$11d7,$8202,$ce57,$3fbc), ($6f19,$7dde,$37b2,$d0ad,$bfbd), ($2f65,$cbd8,$36e8,$9369,$3fbc),
       ($1aa2,$f8c1,$9655,$c274,$bfbd), ($c479,$6b70,$68a1,$a0b4,$3fbd), ($7b4e,$f33b,$e561,$c910,$bfbd),
       ($9774,$519b,$7aa1,$eb4b,$bfbc), ($80d9,$b883,$fb10,$e5eb,$3fbb), ($f6f0,$fdf9,$e512,$b70f,$bfbd),
       ($461e,$9586,$f46f,$d8bc,$3fbd), ($a3fa,$a7e0,$9267,$a257,$bfbc), ($1eec,$781e,$4831,$d1db,$3fba),
       ($b6b0,$331c,$4457,$f0ed,$bfbb), ($20c0,$6268,$a6dd,$ed0b,$bfbd), ($7a5c,$038e,$e827,$df33,$3fbd),
       ($42b1,$fe60,$f620,$c90b,$bfbd), ($da65,$029a,$04c0,$be97,$3fba), ($7e1e,$3313,$6bef,$fbbc,$bfbd),
       ($6a4d,$915c,$a675,$e91f,$3fbc), ($cd4c,$d87e,$3cf6,$c96e,$3fbb), ($74e4,$eded,$42cb,$81d2,$bfbc),
       ($73e3,$cd04,$5be7,$8fe5,$bfb9), ($379c,$7943,$7193,$cc6f,$bfbd), ($045d,$288c,$c1ec,$bedd,$bfbd),
       ($2374,$c710,$c284,$8d08,$3fbd), ($f035,$9bba,$5ac7,$f914,$3fb6), ($9707,$39e2,$6400,$e647,$bfbd),
       ($93d4,$bc59,$cc3e,$86da,$bfbc), ($1ff1,$9a23,$4714,$d2fe,$bfbc), ($53bd,$d0c8,$d9be,$9cb0,$3fbd),
       ($ae8d,$7102,$4c53,$8d58,$3fbd), ($81c2,$b867,$d0ba,$baaf,$bfbd), ($e89f,$2ec0,$365c,$a250,$bfbb),
       ($1adb,$75e7,$ec6e,$c468,$3fbc), ($714a,$cb7d,$9eef,$b14d,$3fbd), ($1a8c,$5a50,$c9a6,$de7b,$bfbb),
       ($8739,$39e4,$d2c3,$85f0,$3fbd), ($443a,$e0f2,$79fe,$c61c,$bfbc), ($8e76,$65ec,$8180,$cb81,$bfbd),
       ($eded,$5c85,$4630,$8d5a,$3fbd), ($8609,$5b52,$3509,$eaab,$3fba), ($af61,$3833,$5d52,$a0f4,$3fbd),
       ($523a,$33e5,$218f,$9802,$bfbc), ($458a,$7538,$36d0,$91d5,$3fbd), ($48b9,$923c,$75a8,$a2d3,$bfbc),
       ($dde8,$aa3b,$6381,$adcd,$bfba), ($4325,$58c4,$e96f,$bce6,$3fbb), ($7951,$9547,$eb44,$ba2b,$3fbc),
       ($bd1d,$d0c0,$eff8,$e375,$3fbc), ($7fdb,$a096,$f03c,$f15c,$3fbd), ($a970,$4a37,$030c,$c1fd,$bfbc),
       ($c463,$89b6,$afc5,$b319,$bfbc), ($74dd,$962b,$618d,$d125,$3fbc), ($6a72,$5204,$7a7a,$aadf,$3fbb),
       ($ce25,$a73d,$8d59,$cdbb,$bfb8), ($9d82,$e5ac,$8e0a,$fd6d,$3fba), ($1e38,$d3d9,$aefa,$9f6a,$3fbd),
       ($49e1,$424b,$6d6b,$d02d,$bfbd), ($cda6,$6474,$7e55,$9696,$3fbc), ($0fc5,$929d,$2950,$eeb0,$3fbd),
       ($3c94,$28f4,$da14,$b6d7,$3fbd), ($826a,$e8f2,$0890,$cffb,$3fba), ($ba60,$486f,$dcd2,$89fd,$3fbd),
       ($5317,$1e0f,$5132,$b700,$3fbc), ($c524,$6473,$087c,$bbc0,$3fbc), ($0653,$81ca,$4bbd,$e18d,$bfbd),
       ($8588,$002b,$92db,$f4b6,$bfba), ($a594,$e37c,$96d2,$9670,$bfbd), ($14b4,$820b,$7c5f,$b761,$3fbd),
       ($6840,$afa3,$5c3d,$8f46,$bfb9), ($06b3,$cdef,$a9d2,$e00e,$bfba), ($6dfd,$eb58,$af14,$8373,$bfb9),
       ($c4e4,$5cd8,$d15e,$dc47,$bfbb), ($92a3,$13bf,$dd56,$d573,$3fb9), ($bbfe,$55af,$dfa2,$f41c,$bfbb),
       ($0c22,$c368,$1d92,$80ca,$3fba), ($6cb6,$e77c,$d246,$847d,$bfbd), ($08d9,$971d,$cdb2,$d452,$bfbd),
       ($3455,$2381,$3f01,$eac2,$3fbd), ($eac6,$318c,$aed9,$bbf1,$3fbd), ($d5c0,$baa7,$d25f,$dd62,$3fbd),
       ($aeb2,$ebd9,$2275,$df6e,$bfbd), ($b52b,$7922,$eaff,$9190,$3fbd), ($a559,$ed4a,$9f15,$e85c,$3fbc),
       ($4b5f,$b50b,$1f98,$a6f2,$bfbc), ($eaa7,$4742,$8ed8,$91f4,$bfbc), ($e75c,$7784,$690e,$c483,$3fbc),
       ($f938,$7aac,$91cf,$e8da,$bfbc), ($0e4d,$9bc6,$9e8e,$b643,$3fbb), ($a5d1,$6b5b,$62c2,$f030,$3fba),
       ($e760,$a1eb,$147f,$c700,$bfba), ($ac10,$9fe8,$7650,$d7c9,$3fbb), ($b51d,$bff9,$1161,$cd15,$3fbc),
       ($4be1,$1360,$589e,$eff1,$bfbb), ($1f52,$e5ac,$e670,$ded5,$bfbd), ($2ffd,$1948,$1d6d,$f8a9,$3fbc),
       ($63ed,$2320,$a834,$de4e,$3fbc), ($9130,$5b81,$5df2,$c706,$bfbd), ($d9d8,$f72d,$8a90,$bf70,$bfbd),
       ($bde9,$7a29,$ca4f,$f7ca,$3fbd), ($54fb,$4a66,$3ab1,$cef0,$3fba), ($f480,$db9b,$5c66,$94cd,$3fbc),
       ($6abc,$ee23,$ec13,$d654,$bfbd), ($0000,$0000,$0000,$0000,$0000));
var
  w, z, ya, yb, u: extended;
  F, Fa, Fb, G, Ga, Gb, H, Ha, Hb: extended;
  e,i : longint;
  k: integer;
  nflg : boolean;
begin

  if IsNanOrInf(x) or IsNanOrInf(y) then
  begin
    power_acc := NaN_x;
    GenerateFPUException(FPUErrorNAN); {.375}
    exit;
  end;

  {Handle easy cases}
  if y=0.0 then begin
    power_acc := 1.0;
    exit;
  end
  else if (x=0.0) then begin
    if y>0.0 then power_acc := 0.0
    else
    begin
      {here y<0: if y is odd and x=-0 return -INF}
      if frac(0.5*y)=0.0 then
      begin
        power_acc := PosInf_x;
        //GenerateFPUException(FPUErrorInf);{.375}
      end
      else
       power_acc := copysign(PosInf_x,x);
    end;
    exit;
  end
  else if y=1.0 then begin
    power_acc := x;
    exit;
  end
  else if x=1.0 then begin
    power_acc := 1.0;
    exit;
  end
  else if abs(y)=0.5 then begin
    if y>0.0 then power_acc := sqrt(x)
    else power_acc := 1.0/sqrt(x);
    exit;
  end;

  nflg := false;         {true if x<0 raised to integer power }
  w := floorx(y);
  if w=y then begin
    z := abs(w);
    u := ilogb(x);
    {intpower does not catch overflows, therefore call it only if safe.}
    if (z<=2048) and (z*(abs(u) + 1.0) < 16382.0) then begin
      power_acc := intpower_acc(x,trunc(w));
      exit;
    end;
  end;
  if x<0.0 then begin
    if w<>y then begin
      {noninteger power of negative number: exception or RTE}
      power_acc := exp_acc(y*ln(x));
      exit;
    end;
    {Find out if the integer exponent is odd or even.}
    w := 2.0*floorx(0.5*y);
    nflg := w<>y;
    x := abs(x);
  end;

  {separate significand from exponent}
  frexp(x, x, e);

  {find significand in antilog table A[]}
  i := 1;
  if x <= extended(A[257])  then i := 257;
  if x <= extended(A[i+128])then inc(i,128);
  if x <= extended(A[i+64]) then inc(i,64);
  if x <= extended(A[i+32]) then inc(i,32);
  if x <= extended(A[i+16]) then inc(i,16);
  if x <= extended(A[i+8])  then inc(i, 8);
  if x <= extended(A[i+4])  then inc(i, 4);
  if x <= extended(A[i+2])  then inc(i, 2);
  if x >= extended(A[1])    then i := -1;
  inc(i);

  {Find (x - A[i])/A[i] in order to compute log(x/A[i]):}
  {log(x) = log( a x/a ) = log(a) + log(x/a)            }
  {log(x/a) = log(1+v),  v = x/a - 1 = (x-a)/a          }
  x := x - extended(A[i]);
  x := x - extended(B[i div 2]);
  x := x / extended(A[i]);

  {rational approximation for log(1+v) = v - v**2/2 + v**3 P(v) / Q(v)}
  z := x*x;

  {w:= polevl(x,P,3)}
  w := ((P[0]*x + P[1])*x + P[2])*x + P[3];
  {u = p1evl(x,Q,3)}
  u := ((x + Q[0])*x + Q[1])*x + Q[2];

  w := x*(z*w/u) - 0.5*z;

  {Convert to base 2 logarithm: multiply by log2(e) = 1+LOG2EA}
  z := extended(LOG2EA)*w;
  z := z + w;
  z := z + extended(LOG2EA)*x;
  z := z + x;

  {Compute exponent term of the base 2 logarithm.}
  w := -i;
  w := w/NXT + e;

  {Now base 2 log of x is w + z.  Multiply base 2 log by y, in pseudo multi}
  {precision. Separate y into large part ya and small part yb less than 1/NXT}

  {WE: mul/div with NXT is faster than original ldexp(,LNXT)}

  ya := floorx(y*NXT)/NXT;    {reduc(y)}
  yb := y - ya;

  F  := z*y + w*yb;
  Fa := floorx(F*NXT)/NXT;    {reduc(F)}
  Fb := F - Fa;

  G  := Fa + w*ya;
  Ga := floorx(G*NXT)/NXT;    {reduc(G)}
  Gb := G - Ga;

  H  := Fb + Gb;
  Ha := floorx(H*NXT)/NXT;    {reduc(H)}
  w  := NXT*(Ga+Ha);

  {Test the power of 2 for over/underflow}
  if w>MEXP then
  begin
    if nflg then power_acc := NegInf_x
    else power_acc := PosInf_x;
    //GenerateFPUException(FPUErrorInf);{.375}
    exit;
  end
  else if w<MNEXP then begin
    power_acc := 0.0;
    exit;
  end;

  e := trunc(w);
  Hb := H - Ha;
  if Hb>0.0 then begin
    inc(e);
    Hb := Hb - 1.0/NXT;
  end;

  {Now the product y * log2(x) = Hb + e/NXT. Compute base 2 exponential}
  {of Hb, where -1/NXT <= Hb <= 0.}

  {z := Hb*polevl(Hb,R,6);    z=2**Hb-1}
  z := R[0];
  for k:=1 to 6 do z := z*Hb + R[k];
  z := Hb*z;

  {Express e/NXT as an integer plus a negative number of (1/NXT)ths.}
  {Find lookup table entry for the fractional power of 2.}
  if e<0 then i := 0 else i := 1;
  inc(i, e div NXT);
  e := NXT*i - e;

  w := extended(A[e]);
  z := w + w*z;     {2**-e * ( 1 + (2**Hb-1) )     }
  z := ldexp(z,i);  {multiply by integer power of 2}

  if nflg then power_acc := -z {odd integer exponent and x<0}
  else power_acc := z;

end;


(*
function exp_x(x: extended): extended;
  {-slow but accurate exp, result good to extended precision}
const
  xmin = -11398.80538430831;  { < -11398.8053843083006133663822374 = ln(succx(0))}
var
  z,t: extended;
  k: longint;
  ln2hi: double absolute ln2_hi;
  ln2lo: double absolute ln2_lo;
  zwa: array[0..4] of word absolute z;
begin
  if x > ln_MaxExt then exp_x := system.exp(x)
  else if x < xmin then exp_x := 0.0
  else if x < ln_MinExt then begin
    {-11398.80538430831 <= x < ln_MinExt: denormal try exp(x/2)^2}
    t := exp_x(0.5*x);
    exp_x := t*t;
  end
  else begin
    {rewrite exp(x) = exp(x - k*ln2 + k*ln2) = exp(k*ln2)*exp(x - k*ln2)}
    { = 2^k*exp(x - k*ln2) with small x-k*ln2, ie k ~= x/ln2 = x*log2(e)}
    k := trunc(log2e*x);
    t := k;
    z := x - t*ln2hi;
    t := t*ln2lo;
    x := z - t;
    {z = exp(x - k*ln2}
    z := system.exp(x);
    {multiply with 2^k, handle over/underflow}
    {z should be >=0, ie the sign bit should be clear, but..}
    k := k + (zwa[4] and $7FFF);
    if k<0 then begin
      {underflow}
      exp_x := 0.0;
    end
    else begin
      if k>=32767 then begin
        {generate floating point overflow}
        RunError(205);
      end
      else begin
        {store exponent of 2^k*exp(x - k*ln2)}
        zwa[4] := k;
      end;
      exp_x := z;
    end;
  end;
end;
*)






function rem_pio2_cw(x: extended; var z: extended): integer;
  {-Cody/Waite reduction of x: z = x - n*Pi/2, |z| <= Pi/4, result = n mod 8}
var
  i: longint;
  y: extended;
const
  HP1 : THexExtW = ($0000,$0000,$da80,$c90f,$3ffe);
  HP2 : THexExtW = ($0000,$0000,$a300,$8885,$3fe4);
  HP3 : THexExtW = ($3707,$a2e0,$3198,$8d31,$3fc8);
var
  DP1 : extended absolute HP1; {= 7.853981554508209228515625E-1;}
  DP2 : extended absolute HP2; {= 7.94662735614792836713604629E-9;}
  DP3 : extended absolute HP3; {= 3.06161699786838294306516483E-17;}
begin
  {This is my Pascal translation of the CW reduction given in}
  {sinl.c from the Cephes Math Library Release 2.7: May, 1998}
  {Copyright 1985, 1990, 1998 by Stephen L. Moshier          }
  if x=0.0 then begin
    z := 0.0;
    rem_pio2_cw := 0;
  end
  else begin
    y := floorx(x/Pi_4);
    i := trunc(y - 16.0*floorx(y/16.0));
    if odd(i) then begin
      inc(i);
      y := y + 1.0;
    end;
    rem_pio2_cw := (i shr 1) and 7;
    {Extended precision modular arithmetic}
    z := ((x - y * DP1) - y * DP2) - y * DP3;
  end;
end;



function rem_pio2(x: extended; var z: extended): integer;
  {-Argument reduction of x:  z = x - n*Pi/2, |z| <= Pi/4, result = n mod 8.}
  { Uses Payne/Hanek if |x| >= ph_cutoff, Cody/Waite otherwise}
const
  tol: extended = 5.9604644775390625e-8;  {ph_cutoff*eps_x}
begin
  z := abs(x);
  if z<Pi_4 then begin
    z := x;
    rem_pio2 := 0;
  end
  else if z > ph_cutoff then rem_pio2 := rem_pio2_ph(x,z)
  else begin
    rem_pio2 := rem_pio2_cw(x,z);
    if abs(z) <= tol then begin
      {If x is close to a multiple of Pi/2, the C/W relative error may be}
      {large, e.g. 1.0389e-6 for x = 491299012647073665.0/16777216.0 with}
      {z_cw = 5.0672257144385922E-20 and z_ph = 5.0672204500144216E-20.  }
      {In this case redo the calculation with the Payne/Hanek algorithm. }
      rem_pio2 := rem_pio2_ph(x,z);
    end;
  end;
end;



function sin_acc(x: extended): extended;
  {-Accurate version of circular sine, uses system.sin for |x| <= Pi/4}
var
  t: extended;
begin
  {reduction mod Pi/2, |t| <= Pi/4}
  case rem_pio2(x,t) and 3 of
      0:  sin_acc :=  sin_f(t);
      1:  sin_acc :=  cos_f(t);
      2:  sin_acc := -sin_f(t);
    else  sin_acc := -cos_f(t);
  end;
end;

function cos_acc(x: extended): extended;
  {-Accurate version of circular cosine, uses system.cos for |x| <= Pi/4}
var
  t: extended;
begin
  {reduction mod Pi/2, |t| <= Pi/4}
  case rem_pio2(x,t) and 3 of
      0:  cos_acc :=  cos_f(t);
      1:  cos_acc := -sin_f(t);
      2:  cos_acc := -cos_f(t);
    else  cos_acc :=  sin_f(t);
  end;
end;



function cosh_acc(x: extended): extended;
  {-Return the hyperbolic cosine of x}
const
  x0 = 23.0;     {ceil(-0.5*ln(2^-64)) = ceil(32*ln(2))}
begin
  x := abs(x);
  if x<=1.0 then cosh_acc := 1.0 + coshm1_acc(x)
  else begin
    if x>x0 then begin
      {x>x0: exp(x) + exp(-x) ~ exp(x)}
      if x<ln_MaxExt then cosh_acc := 0.5*exp_acc(x)
      else cosh_acc := exp_acc(x-ln2);
    end
    else begin
      {calculate inverse only if it is not too small}
      x := exp_acc(x);
      cosh_acc := 0.5*(x + 1.0/x);
    end
  end;
end;





function sinh_acc(x: extended): extended;
  {-Return the hyperbolic sine of x, accurate even for x near 0}
var
  t: extended;
const
  t0 = 23.0;     {ceil(-0.5*ln(2^-64)) = ceil(32*ln(2))}
begin
  t := abs(x);
  if t<1.0 then sinh_acc := sinh_small(x)
  else begin
    {sinh(t) = 0.5*(exp(t) - exp(-t))}
    if t<=t0 then begin
      {calculate inverse only if it is not too small}
      t := exp_acc(t);
      t := 0.5*(t - 1.0/t);
    end
    else if t<ln_MaxExt then begin
      {t>t0: exp(t)-exp(-t) ~ exp(t)}
      t := 0.5*exp_acc(t)
    end
    else begin
      {exp(t) would overflow, use small margin below overflow}
      t := exp_acc(t-ln2);
    end;
    if x>0.0 then sinh_acc := t
    else sinh_acc := -t;
  end;
end;




procedure sincos_acc(x: extended; var s,c: extended);
  {-Return accurate values s=sin(x), c=cos(x)}
var
  t,ss,cc: extended;
  n: integer;
begin
  {reduction mod Pi/2, |t| <= Pi/4}
  n := rem_pio2(x,t) and 3;
  sincos_f(t,ss,cc);
  case n of
      0: begin s:= ss; c:= cc; end;
      1: begin s:= cc; c:=-ss; end;
      2: begin s:=-ss; c:=-cc; end;
    else begin s:=-cc; c:= ss; end;
  end;
end;




function sinc_acc(x: extended): extended;
  {-Return the cardinal sine sinc(x) = sin(x)/x}
begin
  {sin(x)/x = 1 - 1/6*x^2 + 1/120*x^4 - 1/5040*x^6 + 1/362880*x^8 + O(x^10)}
  x := abs(x);
  if x < 6.15e-4 then begin
    if x < 2.3e-10 then sinc_acc := 1.0
    else begin
      x := sqr(x);
      if x < 2.3e-10 then sinc_acc := 1.0 - x/SIXX
      else sinc_acc := 1.0 - (x/SIXX - sqr(x)/120.0)
    end;
  end
  else sinc_acc := sin_acc(x)/x;
end;




function ldexp(x: extended; e: longint): extended;
  {-Return x*2^e}
var
  i: integer;
const
  H2_64: THexExtW = ($0000,$0000,$0000,$8000,$403f);  {2^64}
begin
  {if +-INF, NaN, 0 or if e=0 return x}
  i := THexExtW(x)[4] and $7FFF;
  if (i=$7FFF) or (e=0) or (x=0.0) then ldexp := x
  else if i=0 then begin
    {Denormal: result = x*2^64*2^(e-64)}
    ldexp := ldexp(x*extended(H2_64), e-64);
  end
  else begin
    e := e+i;
    if e>$7FFE then begin
      {overflow}
      if x>0.0 then ldexp := PosInf_x
      else ldexp := NegInf_x;
    end
    else if e<1 then begin
      {underflow or denormal}
      if e<-63 then ldexp := 0.0
      else begin
        {Denormal: result = x*2^(e+64)/2^64}
        inc(e,64);
        THexExtW(x)[4] := (THexExtW(x)[4] and $8000) or (e and $7FFF);
        ldexp := x/extended(H2_64);
      end;
    end
    else begin
      THexExtW(x)[4] := (THexExtW(x)[4] and $8000) or (e and $7FFF);
      ldexp := x;
    end;
  end;
end;



function sfc_gamma_ratio(x,y: extended): extended;
  {-Return gamma(x)/gamma(y)}
begin
  sfc_gamma_ratio := sfc_gamma_delta_ratio(x,y-x)
end;




function floorx(x: extended): extended;
  {-Return the largest integer <= x}
var
  t: extended;
begin
  t := int(x);
  if (x>=0.0) or (x=t) then floorx := t
  else floorx := t - 1.0;
end;



function k_rem_pio2({$ifdef CONST}const{$else}var {$endif} x: TDA02;
                    var y: TDA02; e0, nx, prec: integer): integer;
 {-Calculate y with y = x - n*Pi/2, |y| <= Pi/4 and return n mod 8}
label
  recompute;
var
  i,ih,j,jz,jx,jv,jp,jk,carry,k,m,n,q0: integer;
  t: longint; {WE: used for longint calculations, all other C-ints can be integers}
  iq: array[0..19] of longint;
  f,fq,q: array[0..19] of double;
  z,fw: double;
begin

  {initialize jk}
  jk := init_jk[prec];
  jp := jk;

  {determine jx,jv,q0, note that 3>q0}
  jx := nx-1;
  jv := (e0-3) div 24; if jv<0 then jv := 0;
  q0 := e0-24*(jv+1);

  {set up f[0] to f[jx+jk] where f[jx+jk] = ipio2[jv+jk]}
  j := jv-jx;
  m := jx+jk;
  for i:=0 to m do begin
    if j<0 then f[i] := 0.0 else f[i] := ipio2[j];
    inc(j);
  end;

  {compute q[0],q[1],...q[jk]}
  for i:=0 to jk do begin
    fw := 0.0;
    for j:=0 to jx do begin
      fw   := fw + x[j]*f[jx+i-j];
      q[i] := fw;
    end;
  end;
  jz := jk;

recompute:

  {distill q[] into iq[] reversingly}
  i := 0;
  j := jz;
  z := q[jz];
  while j>0 do begin
    fw    := trunc(twon24*z);
    iq[i] := trunc(z-two24*fw);
    z     := q[j-1]+fw;
    inc(i);
    dec(j);
  end;

  {compute n}
  z  := ldexp(z,q0);              {actual value of z}
  z  := z - 8.0*floorx(z*0.125);  {trim off integer >= 8}
  n  := trunc(z);
  z  := z - n;
  ih := 0;
  if q0>0 then begin
    {need iq[jz-1] to determine n}
    t  := (iq[jz-1] shr (24-q0));
    inc(n,t);
    dec(iq[jz-1], t shl (24-q0));
    ih := iq[jz-1] shr (23-q0);
  end
  else if q0=0 then ih := iq[jz-1] shr 23
  else if z>=0.5 then ih := 2;

  if ih>0 then begin
    {q > 0.5}
    inc(n);
    carry := 0;
    for i:=0 to jz-1 do begin
      {compute 1-q}
      t := iq[i];
      if carry=0 then begin
        if t<>0 then begin
          carry := 1;
          iq[i] := $1000000 - t;
        end
      end
      else iq[i] := $ffffff - t;
    end;
    if q0>0 then begin
      {rare case: chance is 1 in 12}
      case q0 of
        1: iq[jz-1] := iq[jz-1] and $7fffff;
        2: iq[jz-1] := iq[jz-1] and $3fffff;
      end;
    end;
    if ih=2 then begin
      z := 1.0 - z;
      if carry<>0 then  z := z - ldexp(1.0,q0);
    end;
  end;

  {check if recomputation is needed}
  if z=0.0 then begin
    t := 0;
    for i:=jz-1 downto jk do t := t or iq[i];
    if t=0 then begin
      {need recomputation}
      k := 1;
      while iq[jk-k]=0 do inc(k);   {k = no. of terms needed}
      for i:=jz+1 to jz+k do begin
        {add q[jz+1] to q[jz+k]}
        f[jx+i] := ipio2[jv+i];
        fw := 0.0;
        for j:=0 to jx do fw := fw + x[j]*f[jx+i-j];
        q[i] := fw;
      end;
      inc(jz,k);
      goto recompute;
    end;
  end;

  {chop off zero terms}
  if z=0.0 then begin
    dec(jz);
    dec(q0,24);
    while iq[jz]=0 do begin
      dec(jz);
      dec(q0,24);
    end;
  end
  else begin
    {break z into 24-bit if necessary}
    z := ldexp(z,-q0);
    if z>=two24 then begin
      fw := trunc(twon24*z);
      iq[jz] := trunc(z-two24*fw);
      inc(jz);
      inc(q0,24);
      iq[jz] := trunc(fw);
    end
    else iq[jz] := trunc(z);
  end;

  {convert integer "bit" chunk to floating-point value}
  fw := ldexp(1.0,q0);
  for i:=jz downto 0 do begin
    q[i] := fw*iq[i];
    fw := fw*twon24;
  end;

  {compute PIo2[0,...,jp]*q[jz,...,0]}
  for i:=jz downto 0 do begin
    fw :=0.0;
    k := 0;
    while (k<=jp) and (k<=jz-i) do begin
      fw := fw + double(PIo2[k])*(q[i+k]);
      fq[jz-i] := fw;
      inc(k);
    end;
  end;

  {compress fq[] into y[]}
  case prec of
     0:  begin
           fw := 0.0;
           for i:=jz downto 0 do fw := fw + fq[i];
           if ih=0 then y[0] := fw else y[0] := -fw;
         end;
     1,
     2:  begin
           fw := 0.0;
           for i:=jz downto 0 do fw := fw + fq[i];
           if ih=0 then y[0] := fw else y[0] := -fw;
           fw := fq[0]-fw;
           for i:=1 to jz do fw := fw + fq[i];
           if ih=0 then y[1] := fw else y[1] := -fw;
         end;
     3:  begin
           {painful}
           for i:=jz downto 1 do begin
             fw     := fq[i-1]+fq[i];
             fq[i]  := fq[i] + (fq[i-1]-fw);
             fq[i-1]:= fw;
           end;
           for i:=jz downto 2 do begin
             fw      := fq[i-1]+fq[i];
             fq[i]  := fq[i] + (fq[i-1]-fw);
             fq[i-1]:= fw;
           end;
           fw := 0.0;
           for i:=jz downto 2 do fw := fw + fq[i];
           if ih=0 then begin
             y[0] :=  fq[0];
             y[1] :=  fq[1];
             y[2] :=  fw;
           end
           else begin
             y[0] := -fq[0];
             y[1] := -fq[1];
             y[2] := -fw;
           end;
         end;
  end;
  k_rem_pio2 := n and 7;
end;





function rem_pio2_ph_x(x: extended; var z: extended): integer;
  {-Payne/Hanek reduction of x:  z = x - n*Pi/2, |z| <= Pi/4, result = n mod 8}
var
  ax, ay: TDA02;
  e0: integer;
begin
  z := abs(x);
  if (x=0.0) or IsNanOrInf(x) then rem_pio2_ph_x := 0
  else begin
    e0 := ilogb(z)-23;
    z  := ldexp(z,-e0);
    ax[0] := trunc(z); z := ldexp(z-ax[0],24);
    ax[1] := trunc(z);
    ax[2] := trunc(ldexp(z-ax[1],24));
    e0 := k_rem_pio2(ax,ay, e0, 3, 2);
    if x>=0 then begin
      z := ay[0]+ay[1];
      rem_pio2_ph_x := e0;
    end
    else begin
      z := -ay[0]-ay[1];
      rem_pio2_ph_x := (-e0) and 7;
    end;
  end;
end;


function rem_2pi(x: extended): extended;
  {-Return x mod 2*Pi}
var
  {$ifndef ExtendedSyntax_on} n: integer;{$endif}
  z: extended;
const
  {Reduction constants: 2*Pi = Pi2H + Pi2M + Pi2L}
  H2PH : THexExtW = ($0000,$0000,$da80,$c90f,$4001);
  H2PM : THexExtW = ($0000,$0000,$a300,$8885,$3fe7);
  H2PL : THexExtW = ($3707,$a2e0,$3198,$8d31,$3fcb);
var
  Pi2H: extended absolute H2PH; {= 6.28318524360656738}
  Pi2M: extended absolute H2PM; {= 6.35730188491834269E-8}
  Pi2L: extended absolute H2PL; {= 2.44929359829470635E-16}
begin
  if abs(x) <= ph_cutoff then begin
    {Direct Cody/Waite style reduction. This is more efficient}
    {than calling rem_pio2_cw with additional adjustment.}
    z := floorx(x/TwoPi);
    z := ((x - z*Pi2H) - z*Pi2M) - z*Pi2L;
    if z>TwoPi then begin
      {May be reached due to rounding, but was never observed}
      z := ((z - Pi2H) - Pi2M) - Pi2L;
    end;
  end
  else begin
    {Use Payne/Hanek code with adjustments for mod 2Pi}
    {$ifndef ExtendedSyntax_on} n:={$endif} rem_pio2_ph_x(0.25*x,z);
    z := 4.0*z;
    {Here |z| <= Pi, adjustment for z<0 is done below}
  end;
  {Note that in rare cases result=TwoPi, e.g. for x = -TwoPi.}
  {All z with -2eps_x <= z < 0 will have z + TwoPi = TwoPi}
  if z<0.0 then z := ((z + Pi2H) + Pi2M) + Pi2L;
  rem_2pi := z;
end;


procedure sfc_spherical_harmonic(l, m: integer; theta, phi: extended; var yr,yi: extended);
  {-Return Re and Im of the spherical harmonic function Y_lm(theta,phi)}
var
  r_sign, i_sign: boolean;
  t,f: extended;
  k: integer;
begin
  {Ref: Boost [19], special_functions\spherical_harmonic.hpp}
  if (l<0) or (abs(m)>l) then begin
    yr := 0.0;
    yi := 0.0;
    exit;
  end;
  if m < 0 then begin
    {Reflect and adjust sign if m < 0}
    r_sign := odd(m);
    i_sign := not r_sign;
    m := abs(m);
  end
  else begin
    r_sign := false;
    i_sign := false;
  end;
  if odd(m) then begin
    {Check phase if theta is outside [0, Pi]:}
    t := rem_2pi(theta);
    if t<0.0 then t := t+TwoPi;
    if t>Pi  then begin
      r_sign := not r_sign;
      i_sign := not i_sign;
    end;
  end;
  {Calculate amplitude}
  k := l+m;
  {
  if (k>=0) and (k<MAXGAMX) then t := sfc_fac(l-m)/sfc_fac(k)
  else t := sfc_gamma_delta_ratio(l-m+1, 2*m);
  }
  if (k>=0) and (k<MAXGAMX) then  t:=_factorial(l-m)/_factorial(k)    {.335}
  else t := sfc_gamma_delta_ratio(l-m+1, 2*m);


  t := 0.5*sqrt(t*(2*l+1)/Pi);
  f := power_fa(abs(sin_fa(theta)), m);
  f := legendre_plmf(l,m,cos_fa(theta),f);
  f := f*t;
  {f*exp(i*m*phi)}
  sincos_fa(m*phi, yi, yr);
  yr := f*yr;
  yi := f*yi;
  {Add in the signs}
  if r_sign then yr := -yr;
  if i_sign then yi := -yi;
end;


procedure sphY(l, m: Pinteger; theta, phi: Pextended);  stdcall;
var
yr,yi: extended;
begin
  sfc_spherical_harmonic(l^, m^, theta^, phi^, yr,yi);
  asm
    fld tbyte ptr [yi]
    fld tbyte ptr [yr]
  end;
end;





{*******************************GAMMA***********************************************}

function PolEvalX(x: extended; const va:array of extended; n: integer): extended;
  {-Evaluate polynomial; return a[0] + a[1]*x + ... + a[n-1]*x^(n-1)}
var
  a: TExtVector absolute va;
var
  i: integer;
  s: extended;
begin

if F_FastSpec = False then
begin

  if n<=0 then begin
    PolEvalX := 0.0;
    exit;
  end;
  s := a[n-1];
  for i:=n-2 downto 0 do s := s*x + a[i];
  PolEvalX := s;
end

else

begin


    //polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
asm     //EAX<-adr(vector)
       fld [x]
       push ecx
       push edx
       push eax
       mov  eax, va
       fldz
       test eax,eax
       jz @@end
       mov  ecx,n
       jecxz @@end
       fstp st
       dec  ecx
       //fld  qword ptr [eax+8*ecx]  //vd[n-1]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       jecxz @@end
       dec  ecx
       @@L:
       fmul st(0),st(1)   //s*x
       //fld  qword ptr [eax+8*ecx]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       faddp
       dec ecx
       cmp ecx,-$1
       jnz @@L
       @@end:
       fstp st(1)
       pop eax
       pop  edx
       pop  ecx
       fstp @Result
end;

end;



end;




function PolEvalX_f(x: extended; const va:array of extended; n: integer): extended; assembler;
  {-Evaluate polynomial; return a[0] + a[1]*x + ... + a[n-1]*x^(n-1)}

    //polynom(vec,x)=vec[n]*x^(n)+...+vec[1]*x+vec[0] ;n=Length(vec)-1
asm     //EAX<-addr(vector)     Len -> ECX  x -> ST(0)

       fld [x]
       push ecx
       push edx
       push eax
       mov  eax, va
       fldz
       test eax,eax
       jz @@end
       mov  ecx,n
       jecxz @@end
       fstp st
       dec  ecx
       //fld  qword ptr [eax+8*ecx]  //vd[n-1]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       jecxz @@end
       dec  ecx
       @@L:
       fmul st(0),st(1)   //s*x
       //fld  qword ptr [eax+8*ecx]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       faddp
       dec ecx
       cmp ecx,-$1
       jnz @@L
       @@end:
       fstp st(1)
       pop  eax
       pop  edx
       pop  ecx

end;







procedure CPOLYR_f( z: complex; const va: array of extended; n: integer; var w: complex{re,im: extended}); {stdcall;}  assembler;
  {-Evaluate polynomial; return a[0] + a[1]*z + ... + a[n-1]*z^(n-1)}

      //polynom(vec,z)=vec[n]*z^(n)+...+vec[1]*z+vec[0] ;n=Length(vec)-1
      //EAX<-adr(vector)   ;   z.re->st(0),z.im->st(1)
asm
       fld  tbyte ptr [z.im]
       fld  tbyte ptr [z.re]
       push eax
       push ecx
       push edx

       fldz
       fldz
       mov  eax, va
       test eax,eax
       jz @@end

       mov  ecx,n

       jecxz @@end
       fstp st
       fstp st
       dec  ecx
       fldz
       //fld  qword ptr [eax+8*ecx]  //vd[n-1]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       jecxz @@end
       dec  ecx
       @@L:

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

       //fld  qword ptr [eax+8*ecx]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       faddp
       dec ecx
       cmp ecx,-$1
       jnz @@L
       @@end:
       fstp st(2)
       fstp st(2)

       mov  eax, [w]
       fstp tbyte ptr [eax]
       fstp tbyte ptr [eax+16]
       //fstp tbyte ptr [re]
       //fstp tbyte ptr [im]

       pop  edx
       pop  ecx
       pop  eax
end;







function sfc_gaminv_small(x: extended): extended;
  {- 1/gamma(x) for small argument values, |x| < 0.03125}
const
  {1/gamma(x) = x*P(x), 0 < x < 0.03125, peak relative error 4.2e-23}
  SPHex: array[0..8] of THexExtW = (
           ($0000,$0000,$0000,$8000,$3fff),   { 1.000000000000000000000E+0}
           ($c7a9,$7db0,$67e3,$93c4,$3ffe),   { 5.772156649015328608253E-1}
           ($7bf6,$57d1,$a013,$a7e7,$bffe),   {-6.558780715202540684668E-1}
           ($f183,$126b,$f47d,$ac0a,$bffa),   {-4.200263503403344054473E-2}
           ($6b8d,$7515,$1905,$aa89,$3ffc),   { 1.665386113720805206758E-1}
           ($10b0,$ec17,$87dc,$acd7,$bffa),   {-4.219773360705915470089E-2}
           ($9225,$dfef,$b0e9,$9da5,$bff8),   {-9.622023360406271645744E-3}
           ($fe9a,$ceb4,$c74e,$ec9a,$3ff7),   { 7.220599478036909672331E-3}
           ($baeb,$d6d3,$25e5,$9c7e,$bff5));  {-1.193945051381510095614E-3}

  {1/gamma(-x) = x*P(x), 0 < x < 0.03125, peak relative error 5.16e-23}
  SNHex: array[0..8] of THexExtW = (
           ($0000,$0000,$0000,$8000,$bfff),   {-1.000000000000000000000E+0}
           ($c7aa,$7db0,$67e3,$93c4,$3ffe),   { 5.772156649015328608727E-1}
           ($5e26,$57d1,$a013,$a7e7,$3ffe),   { 6.558780715202536547116E-1}
           ($7f64,$1234,$f47d,$ac0a,$bffa),   {-4.200263503402112910504E-2}
           ($7a5b,$d76d,$1905,$aa89,$bffc),   {-1.665386113944413519335E-1}
           ($783f,$41dd,$87d1,$acd7,$bffa),   {-4.219773343731191721664E-2}
           ($2ca1,$18f0,$386f,$9da5,$3ff8),   { 9.621911155035976733706E-3}
           ($989b,$dd68,$c5f1,$ec9c,$3ff7),   { 7.220837261893170325704E-3}
           ($5dd1,$02de,$b9f7,$948d,$3ff5));  { 1.133374167243894382010E-3}
var
  SP: array[0..8] of extended absolute SPHex;
  SN: array[0..8] of extended absolute SNHex;
var
  p: extended;
begin
  {Ref: Cephes [7], function gammal/label small in file ldouble/gammal.c}
  if x=0.0 then sfc_gaminv_small := 0.0
  else begin
    if x<0.0 then
    begin
      x := -x;
      //p := PolEvalX(x, SN, 9);
      p:=((((((((sn[8]*x+sn[7])*x+sn[6])*x+sn[5])*x+sn[4])*x+sn[3])*x+sn[2])*x+sn[1])*x+sn[0]);
    end
    else //p := PolEvalX(x, SP, 9);
          p:=((((((((sp[8]*x+sp[7])*x+sp[6])*x+sp[5])*x+sp[4])*x+sp[3])*x+sp[2])*x+sp[1])*x+sp[0]);

    sfc_gaminv_small := x*p;
  end;
end;




{---------------------------------------------------------------------------}
function sfc_gamma_medium(x: extended): extended;
  {-Return gamma(x), |x| <= 13, x negative integer produces div by 0}
const
  {gamma(x+2) = P(x)/Q(x), 0 <= x <= 1, peak relative error = 1.83e-20}
  PHex: array[0..7] of THexExtW = (
           ($0000,$0000,$0000,$8000,$3fff),   { 1.000000000000000000009E+0}
           ($29cf,$19b3,$16c8,$d67a,$3ffe),   { 8.378004301573126728826E-1}
           ($8d75,$23af,$c8e4,$b9d4,$3ffd),   { 3.629515436640239168939E-1}
           ($9549,$8eb5,$8c3a,$e3f4,$3ffb),   { 1.113062816019361559013E-1}
           ($7f43,$5196,$b166,$c368,$3ff9),   { 2.385363243461108252554E-2}
           ($be6c,$3757,$c717,$861b,$3ff7),   { 4.092666828394035500949E-3}
           ($f5aa,$e82f,$335b,$ee2e,$3ff3),   { 4.542931960608009155600E-4}
           ($434a,$3f22,$2bda,$b0b2,$3ff0));  { 4.212760487471622013093E-5}

  QHex: array[0..8] of THexExtW = (
           ($0000,$0000,$0000,$8000,$3fff),   { 9.999999999999999999908E-1}
           ($e458,$2ec7,$fd57,$d47c,$3ffd),   { 4.150160950588455434583E-1}
           ($75ef,$3ab7,$4ad3,$e5bc,$bffc),   {-2.243510905670329164562E-1}
           ($3295,$3698,$d580,$bdcd,$bffa),   {-4.633887671244534213831E-2}
           ($0417,$7989,$d7bc,$e338,$3ff9),   { 2.773706565840072979165E-2}
           ($296e,$7cb1,$5dfd,$d08f,$bff4),   {-7.955933682494738320586E-4}
           ($beed,$1853,$a691,$a23d,$bff5),   {-1.237799246653152231188E-3}
           ($334b,$c2f0,$a2dd,$f60e,$3ff2),   { 2.346584059160635244282E-4}
           ($5473,$2de8,$1268,$ea67,$bfee));  {-1.397148517476170440917E-5}
var
  PX: array[0..7] of extended absolute PHex;
  QX: array[0..8] of extended absolute QHex;
var
  z: extended;
begin
  {Ref: Cephes [7], function gammal in file ldouble/gammal.c}
  {-13 <= x <= 13. Use recurrence formula to bring argument to [2,3)}
  z := 1.0;
  while x >= 3.0 do begin
    x := x-1.0;
    z := z*x;
  end;
  while x < -0.03125 do begin
    z := z/x;
    x := x+1.0;
  end;
  {Here -0.03125 <= x < 3}
  if x <= 0.03125 then begin
    {argument near a pole, use approximation of 1/gamma}
     sfc_gamma_medium := z/sfc_gaminv_small(x);
  end
  else begin
    {finish reduction to [2,3)}
    while x < 2.0 do begin
      z := z/x;
      x := x+1.0;
    end;
    if x=2.0 then  sfc_gamma_medium := z
    else begin
      x := x-2.0;
       //sfc_gamma_medium := z * PolEvalX(x,PX,8) / PolEvalX(x,QX,9);
       sfc_gamma_medium := z *(((((((px[7]*x+px[6])*x+px[5])*x+px[4])*x+px[3])*x+px[2])*x+px[1])*x+px[0])/((((((((qx[8]*x+qx[7])*x+qx[6])*x+qx[5])*x+qx[4])*x+qx[3])*x+qx[2])*x+qx[1])*x+qx[0])
    end;
  end;
end;




function stirf(x: extended): extended;
  {-Stirling's formula for the gamma function for x > 13.0}
  { gamma(x) = sqrt(2*Pi)*x^(x-0.5)*exp(-x)*(1 + 1/x * P(1/x))}
const
  {13 <= x <= 1024, relative peak error = 9.44E-21, relative error spread = 8.8e-4}
  SPHex: array[0..8] of THexExtW = (
           ($a1d5,$aaaa,$aaaa,$aaaa,$3ffb),  { 8.333333333333331800504E-2}
           ($c3c9,$906e,$38e3,$e38e,$3ff6),  { 3.472222222230075327854E-3}
           ($3a1c,$5ac8,$3478,$afb9,$bff6),  {-2.681327161876304418288E-3}
           ($bef3,$7023,$6a08,$f09e,$bff2),  {-2.294719747873185405699E-4}
           ($30b7,$1a21,$98b2,$cd87,$3ff4),  { 7.840334842744753003862E-4}
           ($5704,$1a39,$b11d,$9293,$3ff1),  { 6.989332260623193171870E-5}
           ($ba6f,$7c59,$5e47,$9bfb,$bff4),  {-5.950237554056330156018E-4}
           ($c395,$0295,$4443,$c64b,$bfef),  {-2.363848809501759061727E-5}
           ($6ede,$69f7,$54e3,$bb5d,$3ff4)); { 7.147391378143610789273E-4}
const
  {x > 1024, rational coefficients from the analytical expansion  }
  { exp(sum(i=1,20,x^(2*i-1)*bernfrac(2*i)/(2*i)/(2*i-1)))+O(x^7) }
  { = 1 + 1/12*x + 1/288*x^2 - 139/51840*x^3 - 571/2488320*x^4    }
  {     + 163879/209018880*x^5 + 5246819/75246796800*x^6 + O(x^7) }
  SAHex: array[0..5] of THexExtW = (
           ($aaab,$aaaa,$aaaa,$aaaa,$3ffb),  { 8.33333333333333333333E-2} {1/12}
           ($e38e,$8e38,$38e3,$e38e,$3ff6),  { 3.47222222222222222222E-3} {1/288}
           ($3df2,$d5a6,$3476,$afb9,$bff6),  {-2.68132716049382716049E-3} {-139/51840}
           ($cab1,$fd42,$7232,$f09e,$bff2),  {-2.29472093621399176955E-4} {-571/2488320}
           ($20e4,$a796,$fb43,$cd87,$3ff4),  { 7.84039221720066627474E-4} {163879/209018880}
           ($c3f2,$ce01,$0241,$923b,$3ff1)); { 6.97281375836585777429E-5} {5246819/75246796800}
const
  XMAX = 1500.0; {max. argument for direct power}
var
  SP: array[0..8] of extended absolute SPHex;
  SA: array[0..5] of extended absolute SAHex;
var
  v,w,y: extended;
begin
  {Ref: Cephes [7], function stirf in file ldouble/gammal.c}
  w := 1.0/x;
  if x > 1024.0 then //w := 1.0 + w*PolEvalX(w, SA, 6)
                       w:=1.0 + w*(((((sa[5]*w+sa[4])*w+sa[3])*w+sa[2])*w+sa[1])*w+sa[0])
  else //w := 1.0 + w*PolEvalX(w, SP, 9);
       w:=1.0 + w*((((((((sp[8]*w+sp[7])*w+sp[6])*w+sp[5])*w+sp[4])*w+sp[3])*w+sp[2])*w+sp[1])*w+sp[0]);
  if x > XMAX then begin
    {Avoid overflow in power}
    y := exp_fa(-x);
    v := power_fa(x,0.5*x-0.25);
    y := v*(v*y);
  end
  else begin
    y := exp_fa(x);
    y := power_fa(x, x-0.5)/y;
  end;
  stirf := Sqrt_TwoPi*y*w;
end;


(*
function floorx(x: extended): extended;
  {-Return the largest integer <= x}
var
  t: extended;
begin
  t := int(x);
  if (x>=0.0) or (x=t) then floorx := t
  else floorx := t - 1.0;
end;
*)

function rem_int2(x: extended; var z: extended): integer;
  {-Argument reduction of x: z*Pi = x*Pi - n*Pi/2, |z|<=1/4, result = n mod 8.}
  { Used for argument reduction in sin(Pi*x) and cos(Pi*x)}
var
  y: extended;
  i: integer;
begin
  if IsNanOrInf(x) or (abs(x)<=0.25) then begin
    rem_int2 := 0;
    z := x;
    exit;
  end;
  if frac(x)=0.0 then begin
    {Here x is an integer or abs(x) >= 2^64}
    z := 0;
    i := 0;
    {set i=2, if x is a odd}
    if (TExtRec(x).xp and $7FFF < $403F) and (frac(0.5*x)<>0.0) then i:=2;
  end
  else begin
    {Here x is not an integer. First calculate x mod 2,}
    {this leaves Pi*x = Pi*(x mod 2) mod 2*Pi invariant}
    x := 0.5*x;
    x := 2.0*(x-floorx(x));
    {then apply the Cody/Waite style range reduction}
    y := floorx(4.0*x);
    i := trunc(y - 16.0*floorx(y/16.0));
    if odd(i) then begin
      inc(i);
      y := y + 1.0;
    end;
    i := (i shr 1) and 7;
    z := x-0.25*y;
  end;
  rem_int2 := i;
end;



{---------------------------------------------------------------------------}
function ln1p(x: extended): extended;
  {-Return ln(1+x), accurate even for x near 0}
var
  y: extended;
const
  x0 = 4.0;
begin
  if x >= x0 then ln1p := ln(1.0 + x)
  else begin
    y := 1.0 + x;
    {The following formula is more accurate than Goldberg [3], Theorem 4. The}
    {Taylor series f(x) = f(x0) + (x-x0)*f'(x0) + .. for f(x) = ln(1+x) gives}
    {ln1p(x) = ln(1+x0) + (x-x0)/(1+x0) = ln(y) + (x-(y-1))/y, with y = 1+x0.}
    if y=1.0 then ln1p := x
    else ln1p := ln(y) + (x-(y-1.0))/y;
  end
end;


function lngamma_small(x,xm1,xm2: extended; useln1p: boolean): extended;
  {-Return ln(gamma(x), 0<=x<8; xm1=x-1, xm2=x-2 are supplied for increased precision}
  { useln1p should be true if xm1 is supposed to be more accurate than x-1}
var
  r,t,z,xm2n: extended;
const
  Y20: THexExtW = ($0,$0,$6000,$A2C7,$3FFC); {0.158963680267333984375 = 333371/2097152}
  P20: array[0..6] of extended = (
         -0.180355685678449379109e-1,
          0.25126649619989678683e-1,
          0.494103151567532234274e-1,
          0.172491608709613993966e-1,
         -0.259453563205438108893e-3,
         -0.541009869215204396339e-3,
         -0.324588649825948492091e-4);
  Q20: array[0..7] of extended = (
          1.0,
          0.196202987197795200688e1,
          0.148019669424231326694e1,
          0.541391432071720958364e0,
          0.988504251128010129477e-1,
          0.82130967464889339326e-2,
          0.224936291922115757597e-3,
         -0.223352763208617092964e-6);
const
  Y10: THexExtW = ($0,$0,$1000,$8735,$3FFE);  {0.52815341949462890625 = 1107618/2097152}
  P10: array[0..6] of extended = (
          0.490622454069039543534e-1,
         -0.969117530159521214579e-1,
         -0.414983358359495381969e0,
         -0.406567124211938417342e0,
         -0.158413586390692192217e0,
         -0.240149820648571559892e-1,
         -0.100346687696279557415e-2);
  Q10: array[0..6] of extended = (
          1.0,
          0.302349829846463038743e1,
          0.348739585360723852576e1,
          0.191415588274426679201e1,
          0.507137738614363510846e0,
          0.577039722690451849648e-1,
          0.195768102601107189171e-2);
const
  Y15: THexExtW = ($0,$0,$D000,$E76E,$3FFD);  {0.452017307281494140625 = 947949/2097152}
  P15: array[0..5] of extended = (
         -0.292329721830270012337e-1,
          0.144216267757192309184e0,
         -0.142440390738631274135e0,
          0.542809694055053558157e-1,
         -0.850535976868336437746e-2,
          0.431171342679297331241e-3);
  Q15: array[0..6] of extended = (
          1.0,
         -0.150169356054485044494e1,
          0.846973248876495016101e0,
         -0.220095151814995745555e0,
          0.25582797155975869989e-1,
         -0.100666795539143372762e-2,
         -0.827193521891290553639e-6);
begin
  {Based on \boost\math\special_functions\detail\lgamma_small.hpp [19]}
  {Copyright John Maddock 2006, see 3rdparty.ama for Boost license}
  if x<eps_x then begin
    lngamma_small := -ln(x);
    exit;
  end;
  if (xm1=0.0) or (xm2=0.0) then begin
    lngamma_small := 0.0;
    exit;
  end;
  {The Boost rational approximations are optimized for low absolute error.}
  {As long as their absolute error is small compared to the constants Yxx }
  {then any rounding errors in their computation will get wiped out.      }
  if x>2.0 then begin
    {Use recurrence formula to bring argument to [2,3)}
    if x>=3 then begin
      z := 1.0;
      repeat
        x := x-1.0;
        z := z*x;
      until x<3.0;
      xm2 := x-2.0;
      z := ln(z);
    end
    else z := 0.0;
    {Use the following form: lngamma(x) = (x-2)*(x+1)*(Y20 + R(x-2))}

    //r := PolEvalX(xm2, P20, 7) / PolEvalX(xm2, Q20, 8);
    r:=((((((p20[6]*xm2+p20[5])*xm2+p20[4])*xm2+p20[3])*xm2+p20[2])*xm2+p20[1])*xm2+p20[0])/(((((((q20[7]*xm2+q20[6])*xm2+q20[5])*xm2+q20[4])*xm2+q20[3])*xm2+q20[2])*xm2+q20[1])*xm2+q20[0]);

    t := xm2*(x+1.0);
    lngamma_small := z + (t*extended(Y20) + t*r);
  end
  else begin
    if x<1.0 then begin
      {bring argument into [1,2)}
      if useln1p then z := -ln1p(xm1)
      else z := -ln(x);
      xm2 := xm1;
      xm1 := x;
      x   := x+1.0;
    end
    else z := 0.0;
    {Two approximations, one for x in [1.0,1.5] and one for x in (1.5,2]}
    if x<=1.5 then begin
      {Use the following form: lngamma(x) = (x-1)*(x-2)*(Y10 + R(x-1))}

      //r := PolEvalX(xm1, P10, 7) / PolEvalX(xm1, Q10, 7);
      r:=((((((p10[6]*xm1+p10[5])*xm1+p10[4])*xm1+p10[3])*xm1+p10[2])*xm1+p10[1])*xm1+p10[0])/((((((q10[6]*xm1+q10[5])*xm1+q10[4])*xm1+q10[3])*xm1+q10[2])*xm1+q10[1])*xm1+q10[0]);

      t := xm1*xm2;
      lngamma_small := z + (t*extended(Y10) + t*r);
    end
    else begin
      {Use the following form: lngamma(x) = (2-x)*(1-x)*(Y15 + R(2-x))}

      //r := PolEvalX(-xm2, P15, 6) / PolEvalX(-xm2, Q15, 7);
      xm2n:=-xm2;
      r:=(((((p15[5]*xm2n+p15[4])*xm2n+p15[3])*xm2n+p15[2])*xm2n+p15[1])*xm2n+p15[0])/((((((q15[6]*xm2n+q15[5])*xm2n+q15[4])*xm2n+q15[3])*xm2n+q15[2])*xm2n+q15[1])*xm2n+q15[0]);

      t := xm1*xm2;
      lngamma_small := z + (t*extended(Y15) + t*r);
    end;
  end;
end;






function sfc_lngamma(x: extended): extended;
  {-Return ln(|gamma(x)|), |x| <= MAXLGM, NAN/RTE if x is a non-positive integer}
var
  t: extended;
begin
  if x<0.0 then begin
    {avoid infinite loop if x is (negative) NAN}
    if IsNaN(x) then
    begin
      sfc_lngamma := NaN_x; GenerateFPUException(FPUErrorNAN); {.375}
    end
    else if frac(x)=0.0 then
    begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      sfc_lngamma := NaN_x;  GenerateFPUException(FPUErrorNAN); {.375}
    end
    else begin
      {use reflection formula}
      //t := x*sinPi(x);
      t := x*sinPi_fa(x) ; {.335}
      sfc_lngamma := ln(abs(Pi/t)) - sfc_lngamma(abs(x));
    end;
    exit;
  end;
  if x <= XLGAE then begin
    {Note: will generate error for x=0}
    sfc_lngamma := lngamma_small(x,x-1.0,x-2.0,false)
  end
  else begin
    {Stirling approximation for x > 8}
    sfc_lngamma := (x-0.5)*ln(x) - x + LnSqrt2Pi + sfc_lngcorr(x);
  end;
end;





{---------------------------------------------------------------------------}
function sfc_lngcorr(x: extended): extended;
  {-Return lngamma correction term lngamma(x) - ((x-0.5)*ln(x) - x + ln(sqrt(2*Pi)), x>=8}
const
  { ln gamma(x) = (x-0.5)*ln(x) - x + ln(sqrt(2*Pi) + 1/x * A(1/x^2) }
  { x >= 8, peak relative error 1.51e-21}
  AHex: array[0..6] of THexExtW = (
          ($9fcc,$aaaa,$aaaa,$aaaa,$3ffb),   { 8.333333333333331447505E-2}
          ($4d88,$03a8,$60b6,$b60b,$bff6),   {-2.777777777750349603440E-3}
          ($f8f2,$30e5,$0092,$d00d,$3ff4),   { 7.936507795855070755671E-4}
          ($8b20,$9fce,$844e,$9c09,$bff4),   {-5.952345851765688514613E-4}
          ($3bdc,$aad1,$d492,$dc88,$3ff4),   { 8.412723297322498080632E-4}
          ($3d91,$0304,$3da1,$f685,$bff5),   {-1.880801938119376907179E-3}
          ($d984,$cc08,$91c2,$a012,$3ff7));  { 4.885026142432270781165E-3}
var
  PA: array[0..6] of extended absolute AHex;
  xt: extended;
const
  xbig = 4.294967296e9;
  xmax = 2.47860728199e4930;
begin
  {Ref: Cephes [7], part function lgaml in file ldouble/gammal.c}
  if x < XLGAE then begin
    {this is not really used but return 'correct' result}
    sfc_lngcorr := sfc_lngamma(x) - ((x-0.5)*ln(x) - x + LnSqrt2Pi);
  end
  else if x > xmax then sfc_lngcorr := 0.0
  else if x > xbig then sfc_lngcorr := 1.0/(12.0*x)
  else
  begin
       //sfc_lngcorr := PolEvalX(1.0/(x*x),PA,7)/x;
       xt:=1.0/(x*x);
       sfc_lngcorr := ((((((pa[6]*xt+pa[5])*xt+pa[4])*xt+pa[3])*xt+pa[2])*xt+pa[1])*xt+pa[0])/x;
  end;
end;








{---------------------------------------------------------------------------}



function sfc_lngammas(x: extended; var s: integer): extended;
  {-Return ln(|gamma(x)|), |x| <= MAXLGM, s=-1,1 is the sign of gamma}
begin
  sfc_lngammas := sfc_lngamma(x);
  if (x>0.0) or (frac(0.5*floorx(x))=0.0) then s := 1 else s := -1;
end;


function sfc_signgamma(x: extended): extended;
  {-Return sign(gamma(x)), useless for 0 or negative integer}
begin
  if IsNanOrInf(x) or (x>0.0) or (frac(0.5*floorx(x))=0.0) then sfc_signgamma := 1.0
  else sfc_signgamma := -1.0;
end;




{---------------------------------------------------------------------------}
function sfc_gamma(x: extended):extended; stdcall;
  {-Return gamma(x), x <= MAXGAMX; NAN/RTE if x is a non-positive integer}
var
  i,ix: integer;
  q,z: extended;
begin


  {Ref: Cephes [7], function gammal in file ldouble/gammal.c}
  if x=PosInf_x then begin
    sfc_gamma := x;
    exit;
  end;

  (*
  if (x<=0.0) and (frac(x)=0.0) then begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_gamma := NaN_x;
    exit;
  end;
  *)

  {.365A}
   ix := trunc(x);
   if ix = x then
   begin
     if (x<=0.0) then
     begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      sfc_gamma := NaN_x;
      GenerateFPUException(FPUErrorNAN); {.375}
      exit;
     end
     else
     if ix <= NumberFact then
     begin
       sfc_gamma := factorial[ix-1];
       exit;
     end;
  end;


  if x>MAXGAMX then
  begin
    sfc_gamma := PosInf_x;
    //GenerateFPUException(FPUErrorINF);{.375}
    exit;
  end;

  q := abs(x);
  if q <= 13.0 then sfc_gamma := sfc_gamma_medium(x)
  else begin
    if x < 0.0 then begin
      if q <= MAXGAMX then begin
        i := trunc(q);
        z := q-i;
        if z > 0.5 then z := q - (i+1);
        //z := abs(q * sinPi(z)) * stirf(q);
        z := abs(q * sinPi_fa(z)) * stirf(q);  {.335}
        if z <= Pi/MaxExtended then begin
          sfc_gamma := copysign(PosInf_x, sfc_signgamma(x));
          exit;
        end;
        sfc_gamma := sfc_signgamma(x)*Pi/z;
      end
      else begin
        {Use lngamma, there are only very rare 'non-zero' cases, most values}
        {underflow. gamma(-1756-0.5^24) = -2.75052000244830115684312e-4930}
        z := exp_fa(sfc_lngammas(x,i));
        sfc_gamma := z*i;
      end;
    end
    else sfc_gamma := stirf(x);
  end
end;



{---------------------------------------------------------------------------}
function sfc_psi(x: extended): extended;       stdcall;
  {-Return the psi (digamma) function of x, INF if x is a non-positive integer}
const
  BNNHex: array[0..8] of THexExtW = (      {bernreal(2k+2)/(2k+2), k=0..7}
            ($AAAB, $AAAA, $AAAA, $AAAA, $3FFB),   { 8.33333333333333333333333E-2}
            ($8889, $8888, $8888, $8888, $BFF8),   {-8.33333333333333333333333E-3}
            ($8208, $0820, $2082, $8208, $3FF7),   { 3.96825396825396825396825E-3}
            ($8889, $8888, $8888, $8888, $BFF7),   {-4.16666666666666666666667E-3}
            ($3E10, $E0F8, $0F83, $F83E, $3FF7),   { 7.57575757575757575757576E-3}
            ($ACCB, $CACC, $CCAC, $ACCA, $BFF9),   {-2.10927960927960927960928E-2}
            ($AAAB, $AAAA, $AAAA, $AAAA, $3FFB),   { 8.33333333333333333333333E-2}
            ($F2F3, $F2F2, $F2F2, $E2F2, $BFFD),   {-4.43259803921568627450980E-1}
            ($3FCE, $FF37, $FCDC, $C373, $4000));  { 3.05395433027011974380395   }
var
  BNN: array[0..7] of extended absolute BNNHex;

const
  PPHex: array[0..5] of THexExtW = (
           ($5D8F, $71C5, $5E47, $F7B9, $3FFE),  {+0.967672245447621170427444761712   }
           ($93CE, $3DA8, $4992, $9274, $3FFF),  {+1.14417380943934132177443086511    }
           ($6D52, $5F65, $79EF, $F169, $3FFD),  {+0.471507845373433246720039154386   }
           ($9EF2, $DF82, $1865, $A71D, $3FFB),  {+0.815984636391829369377116423465e-1}
           ($D564, $B95D, $BF51, $B443, $3FF7),  {+0.550124017486102827456755050064e-2}
           ($05E4, $B416, $530F, $C9AD, $3FF1)); {+0.961671107604462646458076964138e-4}
  PQHex: array[0..6] of THexExtW = (
           ($0000, $0000, $0000, $8000, $3FFF),  {+1.00000000000000000000000000000    }
           ($A4B3, $CD52, $FAA6, $D1E9, $3FFF),  {+1.63995297569876643247016291140    }
           ($2D1C, $1958, $35D7, $F872, $3FFE),  {+0.970492711080937113643931469693   }
           ($E38A, $0D1E, $6FB5, $84F8, $3FFD),  {+0.259707918978674869994308187160   }
           ($A4B6, $ADD5, $3BC7, $81BF, $3FFA),  {+0.316765151172736832756607905517e-1}
           ($C902, $DFDF, $6A6A, $C67A, $3FF5),  {+0.151426838914381207406214536130e-2}
           ($B01C, $4DC7, $7496, $8E9D, $3FEF)); {+0.170010400090619970545999542634e-4}
const
  x0hHex: THexExtW = ($0000,$0000,$8000,$BB16,$3FFF);  {1.4616241455078125}
  x0lHex: THexExtW = ($A9C9,$F6E1,$6BE3,$8635,$3FEE);  {7.9994605498412626595423257213e-6}
var
  PP : array[0..5] of extended absolute PPHex;
  PQ : array[0..6] of extended absolute PQHex;
  x0h: extended absolute x0hHex;
  x0l: extended absolute x0lHex;
var
  p,q,nz,s,w,y,z: extended;
  i,n: integer;
  subneg: boolean;

begin

  if IsNanOrInf(x) then
  begin
    if x=PosInf_x then
    begin
       sfc_psi := PosInf_x;
       //GenerateFPUException(FPUErrorINF);
    end
    else
    begin
      sfc_psi := NaN_x;
      GenerateFPUException(FPUErrorNAN); {.375}
    end;
    exit;
  end;

  {General algorithm layout is as in Cephes [7] double/psi.c. Coefficients }
  {of the asymptotic expansion are calculated with Pari/GP's bernreal, the }
  {Pad‚ approximation polynomials with Maple V's "pade(Psi(x+x0),x,[6,6])".}
  {Conversions to THexExtW form are done with MPArith/t_rcalc's xh command.}

  subneg := false;
  nz := 0.0;

  if x<=0.0 then begin
    q := x;
    p := floorx(q);
    if p=q then
    begin
      sfc_psi := PosInf_x;
      //GenerateFPUException(FPUErrorINF);
      exit;
    end;
    {Remove the zeros of tan(Pi*x) by subtracting the nearest integer from x}
    nz := q - p;
    if nz<>0.5 then begin
      if nz>0.5 then begin
        p  := p + 1.0;
        nz := q - p;
      end;
      {nz := Pi/tan(Pi*nz)}
      sincosPi_fa(nz,s,z);        {.335}
      nz := Pi*z/s;
    end
    else nz := 0.0;
    x := 1.0 - x;
    subneg := nz<>0.0;
  end;

  {Check for small positive integers}
  if (x <= 12.0) and (x=floorx(x)) then begin
    y := 0.0;
    n := trunc(x);
    for i:=n-1 downto 1 do y := y+1.0/i;
    y := y - EulerGamma;
  end
  else if abs(x-x0h)<0.2 then begin
    {Pad‚ approximation for x in (x0-0.2, x0+0.2), abs. error < 3e-19}
    {where x0=1.46163214496836234126.., psi(x0)=0}
    x := x-x0h;
    x := x-x0l;

    //y := x*(PolEvalX(x,PP,6)/PolEvalX(x,PQ,7));
    y:=x*(((((pp[5]*x+pp[4])*x+pp[3])*x+pp[2])*x+pp[1])*x+pp[0])/((((((pq[6]*x+pq[5])*x+pq[4])*x+pq[3])*x+pq[2])*x+pq[1])*x+pq[0]);
  end
  else begin
    s := x;
    w := 0.0;
    while s<12.0 do begin
      w := w + 1.0/s;
      s := s + 1.0;
    end;
    {asymptotic expansion}
    if s>1e10 then y := 0.0
    else begin
      z := 1.0/(s*s);
      //y := z*PolEvalX(z,BNN,8);
      y:=z*(((((((bnn[7]*z+bnn[6])*z+bnn[5])*z+bnn[4])*z+bnn[3])*z+bnn[2])*z+bnn[1])*z+bnn[0]);
    end;
    y := ln(s) - (0.5/s) - y - w;
  end;
  if subneg then y := y-nz;
  sfc_psi := y;
end;




{---------------------------------------------------------------------------}
function sfc_trigamma(x: extended): extended;   stdcall;
  {-Return the trigamma function psi'(x), INF if x is a negative integer}
var
  s: extended;
begin
  {trigamma = psi(1,x) = zetah(2,x) for x >0}
  if IsNanOrInf(x) then
  begin
    if x=PosInf_x then sfc_trigamma := 0.0
    else
    begin
      sfc_trigamma := NaN_x;
      GenerateFPUException(FPUErrorNAN); {.375}
    end;
  end
  else if x>0.0 then begin
    if x >= 1e20 then sfc_trigamma := 1.0/x
    else sfc_trigamma := sfc_zetah(2.0,x)
  end
  else if frac(x)=0.0 then sfc_trigamma := PosInf_x
  else begin
    {Reflection formula HMF [1] 6.4.7 with n=1}
    {psi(1,1-x) + psi(1,x) = Pi^2*(1+cot(Pi*x)^2) = Pi^2/sin(Pi*x)^2}
    //s := sinPi(x);
    s:=sinPi_fa(x) ; {.335}
    sfc_trigamma := PiSqr/sqr(s) - sfc_zetah(2.0,1.0-x);
  end;
end;


{---------------------------------------------------------------------------}
function sfc_tetragamma(x: extended): extended;   stdcall;
  {-Return the tetragamma function psi''(x), NAN/RTE if x is a negative integer}
var
  c,s: extended;
const
  PP3H: THexExtW = ($E0F0,$C4EB,$DAC9,$F80C,$4004);  {2*Pi^3}
begin
  {tetragamma = psi(2,x) = -2*zetah(3,x) for x >0}
  if IsNanOrInf(x) then
  begin
    if x=PosInf_x then sfc_tetragamma := 0.0
    else
    begin
      sfc_tetragamma := NaN_x;
      GenerateFPUException(FPUErrorNAN); {.375}
    end;
  end
  else if x>0.0 then begin
    if x >= 1e20 then begin
      x := 1.0/x;
      sfc_tetragamma := -x*x;
    end
    else sfc_tetragamma := -2.0*sfc_zetah(3.0,x)
  end
  else
  if frac(x)=0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_tetragamma := NaN_x;  GenerateFPUException(FPUErrorNAN); {.375}
  end
  else begin
    {Reflection formula HMF [1] 6.4.7 with n=2, 2nd derivative of cot(Pi*x) with Maple}
    {psi(2,1-x) - psi(2,x) = 2*Pi^3*cot(Pi*x)*(1+cot(Pi*x)^2)}
    //sincosPi(x,s,c);
    sincosPi_fa(x,s,c); {.335}
    c := c/s;
    c := c*(1.0 + c*c);
    s := -2.0*sfc_zetah(3.0,1.0-x);
    sfc_tetragamma := s - extended(PP3H)*c;
  end;
end;


{---------------------------------------------------------------------------}
function sfc_pentagamma(x: extended): extended;   stdcall;
  {-Return the pentagamma function psi'''(x), INF if x is a negative integer}
var
  c,s: extended;
const
  PP4H: THexExtW = ($2C68,$4841,$7461,$C2D1,$4006);  {2*Pi^4}
begin
  {pentagamma = psi(3,x) = 6*zetah(4,x) for x >0}
  if IsNanOrInf(x) then
  begin
    if x=PosInf_x then sfc_pentagamma := 0.0
    else
    begin
      sfc_pentagamma := NaN_x;
      GenerateFPUException(FPUErrorNAN); {.375}
    end;
  end
  else if x>0.0 then begin
    if x >= 1e20 then begin
      x := 1.0/x;
      sfc_pentagamma := 2.0*x*x*x;
    end
    else sfc_pentagamma := 6.0*sfc_zetah(4.0,x);
  end
  else if frac(x)=0.0 then sfc_pentagamma := PosInf_x
  else begin
    {Reflection formula HMF [1] 6.4.7 with n=3, 3rd derivative of cot(Pi*x) with Maple}
    {psi(3,1-x) + psi(3,x) = 2*Pi^4*(1+4*cot(Pi*x)^2 + 3*cot(Pi*x)^4)}
    //sincosPi(x,s,c);
    sincosPi_fa(x,s,c);  {.335}
    c := sqr(c/s);
    c := 1.0 + c*(4.0 + 3.0*c);
    s := 6.0*sfc_zetah(4.0,1.0-x);
    sfc_pentagamma := extended(PP4H)*c - s;
  end;
end;




function sfc_zeta(s: extended): extended;
  {-Return the Riemann zeta function at s, s<>1}
var
  sc: extended;
  a,b: extended;
  ig: integer;
begin
  {Ref: Boost [19], file zeta.hpp}
  if IsNanOrInf(s) then begin
    if s=PosInf_x then sfc_zeta := 1.0
    else
    begin
      sfc_zeta := NaN_x;
      GenerateFPUException(FPUErrorNAN); {.375}
    end;
    exit;
  end;
  if frac(s)=0.0 then begin
    if (s > -MaxBernoulli) and  (s <= MaxInt) then begin
      sfc_zeta := sfc_zetaint(round(s));
      exit;
    end;
  end
  else if abs(s) <= 1.6e-10 then begin
    {Small s, especially useful for s<0 to avoid reflection machinery}
    sfc_zeta := (-0.5) - LnSqrt2Pi*s;
    exit;
  end;
  sc := 1.0-s;
  if s<0.0 then begin
    if frac(0.5*s)=0.0 then sfc_zeta := 0.0
    else begin
      {compute Gamma(sc)/(2Pi)^sc}
      if sc>MaxGAMX-1 then begin
        {Not very accurate but does not overflow!  For s=-1753.5 this branch}
        {gives a rel. error of 2.0e-16 vs 1.8e-17 for the non-lngamma branch}
        a := sfc_lngammas(sc,ig);
        b := 2.0*sc*LnSqrt2Pi;
        {here Zeta(sc)=1}
        a := a-b;
        if a<Ln_MaxExt then a := exp_fa(a)
        else a := PosInf_d;
        a := ig*a;
      end
      else begin
        a := sfc_gamma(sc);
        b := power_fa(TwoPi,-sc);
        a := a*b;
        b := zetap(sc,s);
        a := a*b;
      end;
      {here a = zeta(sc)*Gamma(sc)/(2Pi)^sc}
      //b := sinPi(0.5*s);
       b := sinPi_fa(0.5*s) ; {.335}
      sfc_zeta := 2.0*a*b;
    end;
  end
  else sfc_zeta := zetap(s,sc);
end;

function sfc_zetam1(s: extended): extended;
  {-Return Riemann zeta(s)-1, s<>1}
var
  t: extended;
begin
  if s <= 2.0 then sfc_zetam1 := sfc_zeta(s) - 1.0
  else begin
    if s >= 120.0 then sfc_zetam1 := exp2(-s)
    else begin
      t := 0.5*exp2(s);
      {$ifdef VER50}
        s := etam1pos(s);
        sfc_zetam1 := (1.0 + s*t) / (t - 1.0);
      {$else}
        sfc_zetam1 := (1.0 + etam1pos(s)*t) / (t - 1.0);
      {$endif}
    end;
  end;
end;



{*******************************BESSEL***********************************************}
 { (C) Copyright   Wolfgang Ehrhardt   http://wolfgang-ehrhardt.de/ }


procedure h1v_large(v, x: extended; var mv,tmx: extended);
  {-Return modulus and (phase - x) of the Hankel function H1_v(x), x > 0 large}
var
  s,m,m2,y: extended;
const
  c56 = 5.0/6.0;
begin
  {Modulus Mv: asymptotic expansion from HMF[1] 9.2.28}
  y  := sqr(0.5/x);
  m  := 4.0*sqr(v);
  m2 := sqr(m);
  s  := 1.0 + 0.5*y*(m-1.0)*(1.0 + 0.75*y*(m-9.0)*(1.0 + c56*y*(m-25.0)));
  mv := sqrt(2.0*s/(Pi*x));
  {Phase theta_v - x: asymptotic expansion from HMF[1] 9.2.29}
  y  := 0.25*y;
  s  := (5.0*m*m2 - 1535.0*m2 + 54703.0*m - 37573.0)/14.0;
  s  := s*y + (m2 - 114.0*m + 1073)/5.0;
  s  := s*y + (m-25.0)/6.0;
  tmx:= (m-1.0)*(s*y + 0.5)/(4.0*x) - Pi*(0.5*v+0.25)
end;




procedure bess_m0p0(x: extended; var m0,p0: extended);
  {-Modulus and phase for J0(x) and Y0(x), x >= 9.0}
var
  y, z: extended;
const
  m0nhex: array[0..7] of THexExtW = (
             ($cb2b,$4b73,$8075,$8aa3,$3ff8),
             ($6b78,$4cc6,$25b7,$b912,$3ffb),
             ($cfe9,$74e0,$67a1,$b75e,$3ffe),
             ($b1cd,$4e5e,$2274,$b5ec,$4000),
             ($5e4b,$e3af,$59bb,$f409,$4001),
             ($b343,$2673,$4e51,$a36b,$4002),
             ($38a3,$a663,$7b91,$dbab,$4001),
             ($8559,$f552,$3a38,$ca1d,$3ffd));
  m0dhex: array[0..7] of THexExtW = (
             ($8a83,$1b80,$003e,$adc2,$3ff8),
             ($ed5a,$31cd,$b3ac,$e7f3,$3ffb),
             ($7e3f,$b8dd,$04df,$e5fd,$3ffe),
             ($775a,$1b79,$7d9c,$e475,$4000),
             ($b837,$3075,$dbc0,$99ce,$4002),
             ($5e3d,$b5f4,$9848,$d032,$4002),
             ($4498,$3d2a,$f3fb,$91df,$4002),
             ($0000,$0000,$0000,$8000,$3fff));
  p0nhex: array[0..5] of THexExtW = (
             ($4c2f,$2dd8,$79c3,$e65d,$bfe9),
             ($dc17,$325e,$8baf,$9d35,$bff1),
             ($e514,$8866,$25a9,$8309,$bff7),
             ($8d8a,$84e7,$dbd5,$9e75,$bffb),
             ($1e30,$04da,$b769,$800a,$bffe),
             ($5106,$12a6,$4dd2,$bc55,$bffe));
  p0dhex: array[0..6] of THexExtW = (
             ($4c8c,$2dd8,$79c3,$e65d,$3fec),
             ($ac5c,$4806,$8709,$9dad,$3ff4),
             ($37bf,$fcc8,$9b9f,$844b,$3ffa),
             ($6f25,$2a95,$2dc6,$a285,$3ffe),
             ($4b69,$3f87,$131f,$891f,$4001),
             ($f3e9,$b2a5,$6652,$ec17,$4001),
             ($0000,$0000,$0000,$8000,$3fff));
var
  m0n: array[0..7] of extended absolute m0nhex;
  m0d: array[0..7] of extended absolute m0dhex;
  p0n: array[0..5] of extended absolute p0nhex;
  p0d: array[0..6] of extended absolute p0dhex;
begin
  {Ref: Cephes [7], file ldouble\j0l.c}
  {See also HMF[1], sections 9.2.17 .. 9.2.31}

  {Calculate the modulus m0(x) = sqrt(J0(x)^2 + Y0(x)^2) and the}
  {phase p0(x) = arctan(Y0(x)/J0(x)) with rational approximations}
  {For x>=9: J0(x) = m0(x)*cos(p0(x)) and Y0(x) = m0(x)*sin(p0(x))}
  z  := sqr(1.0/x);
  y  := abs(x);


    {.357}
     //p0 := y - Pi_4 + PolEvalX(z,p0n,6)/PolEvalX(z,p0d,7)/y;
      p0 := y - Pi_4 + (((((p0n[5]*z+p0n[4])*z+p0n[3])*z+p0n[2])*z+p0n[1])*z+p0n[0])/(((((((p0d[6]*z+p0d[5])*z+p0d[4])*z+p0d[3])*z+p0d[2])*z+p0d[1])*z+p0d[0])*y);
      z  := 1.0/y;
      //m0 := PolEvalX(z,m0n,8)/PolEvalX(z,m0d,8)/sqrt(y);
      m0 := (((((((m0n[7]*z+m0n[6])*z+m0n[5])*z+m0n[4])*z+m0n[3])*z+m0n[2])*z+m0n[1])*z+m0n[0])/((((((((m0d[7]*z+m0d[6])*z+m0d[5])*z+m0d[4])*z+m0d[3])*z+m0d[2])*z+m0d[1])*z+m0d[0])*sqrt(y));


  (*
  if F_FastSpec = True then
  begin
      //p0 := y - Pi_4 + PolEvalX(z,p0n,6)/PolEvalX(z,p0d,7)/y;
      p0 := y - Pi_4 + (((((p0n[5]*z+p0n[4])*z+p0n[3])*z+p0n[2])*z+p0n[1])*z+p0n[0])/(((((((p0d[6]*z+p0d[5])*z+p0d[4])*z+p0d[3])*z+p0d[2])*z+p0d[1])*z+p0d[0])*y);
      z  := 1.0/y;
      //m0 := PolEvalX(z,m0n,8)/PolEvalX(z,m0d,8)/sqrt(y);
      m0 := (((((((m0n[7]*z+m0n[6])*z+m0n[5])*z+m0n[4])*z+m0n[3])*z+m0n[2])*z+m0n[1])*z+m0n[0])/((((((((m0d[7]*z+m0d[6])*z+m0d[5])*z+m0d[4])*z+m0d[3])*z+m0d[2])*z+m0d[1])*z+m0d[0])*sqrt(y));
  end
  else
  begin

      p0 := y - Pi_4 + PolEvalX_f(z,p0n,6)/PolEvalX_f(z,p0d,7)/y;
      z  := 1.0/y;
      m0 := PolEvalX_f(z,m0n,8)/PolEvalX_f(z,m0d,8)/sqrt(y);

     { p0 := y - Pi_4 + (((((p0n[5]*z+p0n[4])*z+p0n[3])*z+p0n[2])*z+p0n[1])*z+p0n[0])/((((((p0d[6]*z+p0d[5])*z+p0d[4])*z+p0d[3])*z+p0d[2])*z+p0d[1])*z+p0d[0])/y;
      z  := 1.0/y;
      m0 := (((((((m0n[7]*z+m0n[6])*z+m0n[5])*z+m0n[4])*z+m0n[3])*z+m0n[2])*z+m0n[1])*z+m0n[0])/(((((((m0d[7]*z+m0d[6])*z+m0d[5])*z+m0d[4])*z+m0d[3])*z+m0d[2])*z+m0d[1])*z+m0d[0])/sqrt(y);  }

  end;
  *)




end;


 //bj0(x/x*400)

function bessj_large(v, x: extended): extended;
  {-Return J_v(x) via modulus/phase asymptotic expansion, x large}
var
  mv,tv,st,ct,sx,cx: extended;
begin
  h1v_large(v,x,mv,tv);
  //sincos_x(tv,st,ct);
  //sincos_x(x,sx,cx);
  sincos_fa(tv,st,ct);  {.335}
  sincos_fa(x,sx,cx);  {.335}
  {J_v := mv*cos(x+tv); cos(x+tv) = cos(x)cos(tv) - sin(x)sin(tv)}
  bessj_large := mv*(cx*ct - sx*st);
end;



procedure bess_m1p1(x: extended; var m1,p1: extended);
  {-Modulus and phase for J1(x) and Y1(x), x >= 9.0}
var
  y, z: extended;
const
  m1nhex: array[0..7] of THexExtW = (
            ($a905,$05fb,$3101,$82c9,$3ff9),
            ($6de4,$8fae,$fe26,$8097,$3ffc),
            ($2cb0,$c657,$be70,$81e0,$3fff),
            ($71e6,$88a5,$0a53,$b702,$4000),
            ($e5e2,$6914,$3a08,$e582,$4001),
            ($7d55,$db8c,$e825,$a1c2,$4000),
            ($3111,$863a,$3a61,$c8a0,$3ffd),
            ($3d53,$b598,$f3bf,$a155,$c001));
  m1dhex: array[0..8] of THexExtW = (
            ($1237,$cc6c,$7356,$a3ea,$3ff9),
            ($fc82,$02c7,$17a4,$a12b,$3ffc),
            ($37ce,$79ae,$2f15,$a24c,$3fff),
            ($77b6,$34e2,$501a,$e37a,$4000),
            ($0260,$746b,$d030,$8c14,$4002),
            ($6420,$97ce,$8e44,$a208,$4000),
            ($77b5,$8f2d,$b6bf,$ebe1,$bffe),
            ($2603,$640e,$7d8d,$c775,$c001),
            ($0000,$0000,$0000,$8000,$3fff));
  p1nhex: array[0..5] of THexExtW = (
            ($540c,$c1d5,$b096,$e54f,$3feb),
            ($f74f,$be87,$7e7d,$9741,$3ff3),
            ($a830,$f4a3,$2c60,$f144,$3ff8),
            ($e907,$28b9,$7cb7,$895c,$3ffd),
            ($6050,$98aa,$3500,$cb2f,$3fff),
            ($ebc0,$5506,$512f,$80ab,$4000));
  p1dhex: array[0..6] of THexExtW = (
            ($8d72,$2be3,$cb0f,$98df,$3fed),
            ($a853,$55fb,$6c79,$ca32,$3ff4),
            ($98f8,$d610,$3c35,$a235,$3ffa),
            ($c39e,$9c8c,$5428,$bb65,$3ffe),
            ($b1f2,$e0d2,$5ab5,$9098,$4001),
            ($efe3,$292c,$0d43,$d9e6,$4001),
            ($0000,$0000,$0000,$8000,$3fff));
var
  m1n: array[0..7] of extended absolute m1nhex;
  m1d: array[0..8] of extended absolute m1dhex;
  p1n: array[0..5] of extended absolute p1nhex;
  p1d: array[0..6] of extended absolute p1dhex;
begin
  {Ref: Cephes [7], file ldouble\j1l.c}

  {Calculate the modulus m1(x) = sign(x)*sqrt(J1(x)^2 + Y1(x)^2) and }
  {the phase p1(x) = arctan(Y1(x)/J1(x)) with rational approximations}
  {For x>=9: J1(x) = m1(x)*cos(p1(x)) and Y1(x) = m1(x)*sin(p1(x))}
  z  := sqr(1.0/x);
  y  := abs(x);

     {.357}
    //p1 := y - 3.0*Pi_4 + PolEvalX(z,p1n,6)/PolEvalX(z,p1d,7)/y;
     p1 := y - 3.0*Pi_4 + (((((p1n[5]*z+p1n[4])*z+p1n[3])*z+p1n[2])*z+p1n[1])*z+p1n[0])/(((((((p1d[6]*z+p1d[5])*z+p1d[4])*z+p1d[3])*z+p1d[2])*z+p1d[1])*z+p1d[0])*y);
     z  := 1.0/y;
     //m1 := PolEvalX(z,m1n,8)/PolEvalX(z,m1d,9)/sqrt(y);
     m1 := (((((((m1n[7]*z+m1n[6])*z+m1n[5])*z+m1n[4])*z+m1n[3])*z+m1n[2])*z+m1n[1])*z+m1n[0])/(((((((((m1d[8]*z+m1d[7])*z+m1d[6])*z+m1d[5])*z+m1d[4])*z+m1d[3])*z+m1d[2])*z+m1d[1])*z+m1d[0])*sqrt(y));


  (*
  if F_FastSpec = True then
  begin
     //p1 := y - 3.0*Pi_4 + PolEvalX(z,p1n,6)/PolEvalX(z,p1d,7)/y;
     p1 := y - 3.0*Pi_4 + (((((p1n[5]*z+p1n[4])*z+p1n[3])*z+p1n[2])*z+p1n[1])*z+p1n[0])/(((((((p1d[6]*z+p1d[5])*z+p1d[4])*z+p1d[3])*z+p1d[2])*z+p1d[1])*z+p1d[0])*y);
     z  := 1.0/y;
     //m1 := PolEvalX(z,m1n,8)/PolEvalX(z,m1d,9)/sqrt(y);
     m1 := (((((((m1n[7]*z+m1n[6])*z+m1n[5])*z+m1n[4])*z+m1n[3])*z+m1n[2])*z+m1n[1])*z+m1n[0])/(((((((((m1d[8]*z+m1d[7])*z+m1d[6])*z+m1d[5])*z+m1d[4])*z+m1d[3])*z+m1d[2])*z+m1d[1])*z+m1d[0])*sqrt(y));
  end
  else
  begin
      p1 := y - 3.0*Pi_4 + PolEvalX_f(z,p1n,6)/PolEvalX_f(z,p1d,7)/y;
      z  := 1.0/y;
      m1 := PolEvalX_f(z,m1n,8)/PolEvalX_f(z,m1d,9)/sqrt(y);
  end;
  *)


  if x<0.0 then m1 := -m1;
end;



function CF_jn(n: integer; x: extended): extended;
  {-Return J_(n+1)(x) / J_n(x), use only if |x| <= |n|}
var
  b,c,d,f,k,delta,tiny,tol,limit: extended;
begin
  {Evaluate continued fraction HMF[1], 9.1.73 using modified Lentz's method.}
  {Based on boost_1_42_0\boost\math\special_functions\detail\bessel_jy.hpp [19]}
  {Copyright 2006 Xiaogang Zhang, see 3rdparty.ama for Boost license}
  tol  := eps_x;
  tiny := Sqrt_MinExt;
  n := abs(n);
  c := tiny;
  f := tiny;
  d := 0.0;
  x := 0.5*x;
  k := n+1;
  limit := 3.0*(k + 20.0*sqrt(k));
  while k<=limit do begin
    b := k/x;
    c := b - 1.0/c;
    d := b - d;
    if c=0.0 then c := tiny;
    if d=0.0 then d := tiny;
    d := 1.0/d;
    delta := c*d;
    f := f*delta;
    if abs(delta - 1.0) < tol then begin
      CF_jn := -f;
      exit;
    end;
    k := k+1.0;
  end;
  CF_jn := 0.0;
end;


function sfc_jn(n: integer; x: extended): extended;
  {-Return J_n(x), the Bessel function of the 1st kind, order n; not suitable for large n or x.}
var
  curr,prev,q,temp,init,xh: extended;
  k: integer;
  neg: boolean;
const
  small = 7.143435E-1651;  {~ cbrt(succx(0))}
  lnsml:extended = ln_succx0;
begin


  {Based on boost_1_42_0\boost\math\special_functions\detail\bessel_jn.hpp [19]}
  {Copyright 2006 Xiaogang Zhang, see 3rdparty.ama for Boost license}
  init := Sqrt_MinExt;
  {Flag to negate result for |n|}
  neg := (n<0) and odd(n);
  n := abs(n);

  if n=0 then curr := sfc_j0(x)
  else if n=1 then curr := sfc_j1(x)
  else if abs(x) <= small then begin
    if (x=0.0) or (n>2) then curr := 0.0
    else curr := 0.125*sqr(x);
  end
  else begin
    xh := 0.5*x;
    if abs(x) > n then begin
      {forward recurrence}
      prev := sfc_j0(x);
      curr := sfc_j1(x);
      for k:=1 to n-1 do begin
        temp := curr*k/xh - prev;
        prev := curr;
        curr := temp;
      end;
    end
    else begin
      {Quick check if |J_n(x)| < MinExtended from HMF[1] 9.1.63}
      {solution of z*exp(sqrt(1-z^2))=1 is z = 0.39989.. }
      q := abs(x/n);
      if n<=100 then temp := 1e-40
      else if n<1000 then temp := 1e-4
      else if n<5000 then temp := 0.07
      else temp := 0.3999;
      if q < temp then begin
        {Jn(x) <= [q*exp(sqrt(1-q^2))/(1+sqrt(1-q^2))]^n}
        temp := sqrt(1.0 - q*q);
        temp := ln(q/(1.0+temp)) + temp;
        if temp < lnsml/n then begin
          sfc_jn := 0.0;
          exit;
        end;
      end;
      {set overflow threshold for iteration}
      q := 0.5*MaxExtended*q;
      {backward recurrence}
      prev := CF_jn(n,x)*init;
      curr := init;
      for k:=n downto 1 do begin
        if abs(curr) > q then begin
          {prevent overflow and set result to zero}
          sfc_jn := 0.0;
          exit;
        end;
        temp := curr*k/xh - prev;
        prev := curr;
        curr := temp;
      end;
      curr := (init/curr)*sfc_j0(x);
    end;
  end;
  if neg then sfc_jn := -curr else sfc_jn := curr;
end;



function sfc_j0(x: extended): extended;
  {-Return J0(x), the Bessel function of the 1st kind, order zero}
var
  y,z: extended;
const
  {Squares of first three roots of J0, calculated with Maple and t_rcalc/xh}
  j1h: THexExtW = ($DBB7,$315D,$DC02,$B90F,$4001);  {5.7831859629467845213}
  j2h: THexExtW = ($7778,$0EEB,$2531,$F3C5,$4003);  {3.0471262343662086400E+1}
  j3h: THexExtW = ($40F6,$0ABB,$25C1,$95C6,$4005);  {7.4887006790695183442E+1}
var
  jz1: extended absolute j1h;
  jz2: extended absolute j2h;
  jz3: extended absolute j3h;
const
  j0nhex:  array[0..7] of THexExtW = (
             ($b96c,$c486,$fb95,$9f47,$c03a),
             ($4018,$ad26,$71ba,$e643,$4034),
             ($1b0b,$6331,$7add,$8753,$c02e),
             ($943a,$69b7,$36ca,$a996,$4026),
             ($008c,$7b60,$d119,$f792,$c01d),
             ($fe10,$b608,$4829,$d503,$4014),
             ($a9a8,$e62b,$3b28,$ca73,$c00a),
             ($f759,$4208,$23d6,$a5ff,$3fff));
  j0dhex: array[0..8] of THexExtW = (
             ($00ac,$fb2b,$6f62,$804b,$4048),
             ($fdce,$a4ca,$2ed8,$88b8,$4041),
             ($3d2c,$ed55,$20e1,$9105,$4039),
             ($0841,$8cb6,$5a46,$c9e3,$4030),
             ($fed1,$086d,$3425,$cc0a,$4027),
             ($66d2,$93fe,$0762,$9b79,$401e),
             ($e1a0,$923f,$cb5c,$b1a2,$4014),
             ($bdfe,$c832,$5b9f,$8e9f,$400a),
             ($0000,$0000,$0000,$8000,$3fff));
var
  j0n: array[0..7] of extended absolute j0nhex;
  j0d: array[0..8] of extended absolute j0dhex;
  ptrj0n: Pointer absolute j0nhex;

     //  bj0(x)
     {
     function _Polyj0n(x: extended; PtrA: Pointer): extended; assembler;
     asm
       mov eax, ptrA
       fld tbyte ptr [eax+60]
       fld tbyte ptr [eax+70]
       fld   [x]
       fld   st(0)
       fmul  st(0),st(0)
       fmul  st(2),st(0)
       fmul  st(3),st(0)
       fld   tbyte ptr [eax+40]
       faddp st(4),st(0)
       fld   tbyte ptr [eax+50]
       faddp st(3),st(0)
       fmul  st(2),st(0)
       fmul  st(3),st(0)
       fld   tbyte ptr [eax+20]
       faddp st(4),st(0)
       fld   tbyte ptr [eax+30]
       faddp st(3),st(0)
       fmul  st(2),st(0)
       fmul  st(3),st(0)
       fstp  st(0)
       fmul  st(1),st(0)
       fld   tbyte ptr [eax]
       fld   tbyte ptr [eax+10]
       fmulp st(2),st(0)
       faddp st(1),st(0)
       fxch  st(2)
       faddp st(1),st(0)
       faddp st(1),st(0)
     end;
     }
begin
  {Ref: Cephes [7], file ldouble\j0l.c}
  x := abs(x);
  if x < 9.0 then begin
    {In the interval [0,9) a rational approximation of the form }
    {J0(x) = (x^2 - r^2) (x^2 - s^2) (x^2 - t^2) P7(x^2)/Q8(x^2)}
    {is used, where r, s, t are the first three zeros of J0.}
    z := sqr(x);
    y := (z - jz1)*(z - jz2)*(z - jz3);
    //sfc_j0 := y*PolEvalX_f(z,j0n,8)/PolEvalX_f(z,j0d,9);
    //sfc_j0 := y*PolEvalX(z,j0n,8)/PolEvalX(z,j0d,9);
    sfc_j0 :=y*(((((((j0n[7]*z+j0n[6])*z+j0n[5])*z+j0n[4])*z+j0n[3])*z+j0n[2])*z+j0n[1])*z+j0n[0])/(((((((((j0d[8]*z+j0d[7])*z+j0d[6])*z+j0d[5])*z+j0d[4])*z+j0d[3])*z+j0d[2])*z+j0d[1])*z+j0d[0]));


    //sfc_j0 := PolEvalX_f(z,j0n,8);
    //ptrj0n:=@j0nhex[0];
    //z:=PExtended(Pointer(@j0nhex))^+1.123;
    //z:=j0n[0];
    //z:=z+1;
    //z:=PExtended(ptrj0n)^ ;

    //sfc_j0 := _Polyj0n(z,@j0n);
    //sfc_j0 :=y*_Polyj0n(z,@j0n)/(((((((((j0d[8]*z+j0d[7])*z+j0d[6])*z+j0d[5])*z+j0d[4])*z+j0d[3])*z+j0d[2])*z+j0d[1])*z+j0d[0]));

   end
  else begin
    {For x>=9 the common rational approximations to modulus}
    {and phase are used J0(x) = modulus * cos(phase).}
    if x >= 500.0 then sfc_j0 := bessj_large(0,x)
    else begin
      bess_m0p0(x,y,z);
      sfc_j0 := y*cos_fa(z);
    end;
  end;
end;



{---------------------------------------------------------------------------}
function sfc_j1(x: extended): extended;
  {-Return J1(x), the Bessel function of the 1st kind, order one}
var
  y,z: extended;
const
  {Squares of first three roots of J1, calculated with Maple and t_rcalc/xh}
  j1h: THexExtW = ($5F8E,$4C11,$5A0C,$EAE9,$4002);  {1.4681970642123893257E+1}
  j2h: THexExtW = ($9093,$9521,$B303,$C4DF,$4004);  {4.9218456321694603672E+1}
  j3h: THexExtW = ($5EBF,$C2F1,$B86B,$CEFF,$4005);  {1.0349945389513658033E+2}
var
  jz1: extended absolute j1h;
  jz2: extended absolute j2h;
  jz3: extended absolute j3h;
const
  j1nhex:  array[0..8] of THexExtW = (
             ($d8d8,$7311,$a7d2,$97a4,$c039),
             ($d3c2,$f8f0,$f852,$c144,$4033),
             ($636c,$4d29,$9f71,$cebb,$c02c),
             ($038e,$bd23,$a7fa,$f49c,$4024),
             ($1ac8,$c825,$3c9c,$b0b6,$c01c),
             ($38f5,$f72b,$0a5c,$a122,$4013),
             ($29f3,$496b,$a54c,$b6d9,$c009),
             ($6dc3,$c850,$a096,$ee6b,$3ffe),
             ($f72f,$18cc,$50b2,$8a22,$bff3));
  j1dhex: array[0..8] of THexExtW = (
             ($dd67,$f5b3,$0522,$ad0f,$404a),
             ($665d,$b178,$242e,$9af7,$4043),
             ($e6c0,$a725,$3d56,$88f7,$403b),
             ($0122,$56c0,$f2ef,$9d6e,$4032),
             ($b498,$fdd5,$209e,$820e,$4029),
             ($6041,$c9fe,$6890,$a033,$401f),
             ($6a17,$e162,$4e86,$9218,$4015),
             ($baf9,$146e,$df50,$b88a,$400a),
             ($0000,$0000,$0000,$8000,$3fff));
var
  j1n: array[0..8] of extended absolute j1nhex;
  j1d: array[0..8] of extended absolute j1dhex;
begin
  {Ref: Cephes [7], file ldouble\j1l.c}
  z := abs(x);
  if z < 9.0 then begin
    z := sqr(x);
    {In the interval [0,9) a rational approximation of the form }
    {J1(x) = x*(x^2 - r^2)*(x^2 - s^2)*(x^2 - t^2)*P8(x^2)/Q8(x^2)}
    {is used, where r, s, t are the first three zeros of J1.}
    y := x*(z - jz1)*(z - jz2)*(z - jz3);

    //sfc_j1 := y*PolEvalX(z,j1n,9)/PolEvalX(z,j1d,9);
    sfc_j1:= y*((((((((j1n[8]*z+j1n[7])*z+j1n[6])*z+j1n[5])*z+j1n[4])*z+j1n[3])*z+j1n[2])*z+j1n[1])*z+j1n[0])/((((((((j1d[8]*z+j1d[7])*z+j1d[6])*z+j1d[5])*z+j1d[4])*z+j1d[3])*z+j1d[2])*z+j1d[1])*z+j1d[0]);

  end
  else begin
    {For x>=9 the common rational approximations to modulus}
    {and phase are used J1(x) = modulus * cos(phase).}
    if z >= 500.0 then begin
      y := bessj_large(1,z);
      if x<0.0 then sfc_j1 := -y else sfc_j1 := y;
    end
    else begin
      bess_m1p1(x,y,z);
      sfc_j1 := y*cos_fa(z);
    end;
  end;
end;




{---------------------------------------------------------------------------}

function bess_i0_small(x: extended): extended;
  {-Return Bessel function I0(x) for abs(x)<=3, x assumed >= 0}
const
  xsml = 0.65854450798271924667e-9;  {sqrt(4*eps_x)}
const
  nbi0 = 13;
  bi0h : array[0..nbi0-1] of THexExtW = (
           ($4003,$A1EE,$5479,$9CE3,$BFFB), {-0.7660547252839144951081894976243285e-1}
           ($48B3,$5F19,$0294,$F6B3,$3FFF), {+0.1927337953993808269952408750881196e+1}
           ($B8D1,$AF86,$2883,$E9BE,$3FFC), {+0.2282644586920301338937029292330415e+0}
           ($B9F3,$936B,$1D6F,$D5CB,$3FF8), {+0.1304891466707290428079334210691888e-1}
           ($5C27,$B9AE,$D127,$E3C3,$3FF3), {+0.4344270900816487451378682681026107e-3}
           ($F200,$B849,$01B0,$9E16,$3FEE), {+0.9422657686001934663923171744118766e-5}
           ($CFA2,$6F56,$AA2C,$99F9,$3FE8), {+0.1434006289510691079962091878179957e-6}
           ($189D,$34A0,$4423,$DDCE,$3FE1), {+0.1613849069661749069915419719994611e-8}
           ($DA55,$222E,$86B5,$F5B3,$3FDA), {+0.1396650044535669699495092708142522e-10}
           ($4C24,$393C,$C78C,$D7B5,$3FD3), {+0.9579451725505445344627523171893333e-13}
           ($B4AE,$B291,$D6DC,$99BD,$3FCC), {+0.5333981859862502131015107744000000e-15}
           ($1BB6,$1CA4,$D573,$B56B,$3FC4), {+0.2458716088437470774696785919999999e-17}
           ($1BB2,$06F5,$B92D,$B41F,$3FBC));{+0.9535680890248770026944341333333333e-20}
var
  bi0: array[0..nbi0-1] of extended absolute bi0h;
begin
  {Ref: W. Fullerton [14] and [20], files dbesi0.f and dbsi0e.f}
  {Hex Chebyshev values calculated with mp_arith/t_rcalc}
  if x<=xsml then bess_i0_small := 1.0
  else bess_i0_small := 2.75 + CSEvalX_f(x*x/4.5-1.0,bi0,nbi0);
end;



function sfc_i0e(x: extended): extended;
  {-Return I0(x)*exp(-|x|), the exponentially scaled modified Bessel function of the 1st kind, order zero}
const
  xsml = 0.23283064365386962891e-9;  {sqrt(0.5*eps_x)}
const
  nai0 = 28;
   ai0: array[0..nai0-1] of extended = (
          +0.7575994494023795942729872037438e-1,
          +0.7591380810823345507292978733204e-2,
          +0.4153131338923750501863197491382e-3,
          +0.1070076463439073073582429702170e-4,
          -0.7901179979212894660750319485730e-5,
          -0.7826143501438752269788989806909e-6,
          +0.2783849942948870806381185389857e-6,
          +0.8252472600612027191966829133198e-8,
          -0.1204463945520199179054960891103e-7,
          +0.1559648598506076443612287527928e-8,
          +0.2292556367103316543477254802857e-9,
          -0.1191622884279064603677774234478e-9,
          +0.1757854916032409830218331247743e-10,
          +0.1128224463218900517144411356824e-11,
          -0.1146848625927298877729633876982e-11,
          +0.2715592054803662872643651921606e-12,
          -0.2415874666562687838442475720281e-13,
          -0.6084469888255125064606099639224e-14,
          +0.3145705077175477293708360267303e-14,
          -0.7172212924871187717962175059176e-15,
          +0.7874493403454103396083909603327e-16,
          +0.1004802753009462402345244571839e-16,
          -0.7566895365350534853428435888810e-17,
          +0.2150380106876119887812051287845e-17,
          -0.3754858341830874429151584452608e-18,
          +0.2354065842226992576900757105322e-19,
          +0.1114667612047928530226373355110e-19,
          -0.5398891884396990378696779322709e-20);
const
  nai2 = 33;
  ai02: array[0..nai2-1] of extended = (
          +0.5449041101410883160789609622680e-1,
          +0.3369116478255694089897856629799e-2,
          +0.6889758346916823984262639143011e-4,
          +0.2891370520834756482966924023232e-5,
          +0.2048918589469063741827605340931e-6,
          +0.2266668990498178064593277431361e-7,
          +0.3396232025708386345150843969523e-8,
          +0.4940602388224969589104824497835e-9,
          +0.1188914710784643834240845251963e-10,
          -0.3149916527963241364538648629619e-10,
          -0.1321581184044771311875407399267e-10,
          -0.1794178531506806117779435740269e-11,
          +0.7180124451383666233671064293469e-12,
          +0.3852778382742142701140898017776e-12,
          +0.1540086217521409826913258233397e-13,
          -0.4150569347287222086626899720156e-13,
          -0.9554846698828307648702144943125e-14,
          +0.3811680669352622420746055355118e-14,
          +0.1772560133056526383604932666758e-14,
          -0.3425485619677219134619247903282e-15,
          -0.2827623980516583484942055937594e-15,
          +0.3461222867697461093097062508134e-16,
          +0.4465621420296759999010420542843e-16,
          -0.4830504485944182071255254037954e-17,
          -0.7233180487874753954562272409245e-17,
          +0.9921475412173698598880460939810e-18,
          +0.1193650890845982085504399499242e-17,
          -0.2488709837150807235720544916602e-18,
          -0.1938426454160905928984697811326e-18,
          +0.6444656697373443868783019493949e-19,
          +0.2886051596289224326481713830734e-19,
          -0.1601954907174971807061671562007e-19,
          -0.3270815010592314720891935674859e-20);
begin
  {Ref: W. Fullerton [14] and [20], file dbsi0e.f}
  x := abs(x);
  if x<=3.0 then begin
    {Note that there is bug in dbsi0e.f from [20] for small x. We use the}
    {Taylor series for I(0,x)*exp(-x) = 1 - x + 3/4*x^2 -5/12*x^3 + O(x^4)}
    if x<=xsml then sfc_i0e := 1 - x
    else sfc_i0e := exp_fa(-x)*bess_i0_small(x);
  end
  else if x<=8.0 then begin
    sfc_i0e := (0.375 + CSEvalX_f((48.0/x-11.0)/5.0, ai0, nai0))/sqrt(x);
  end
  else begin
    sfc_i0e := (0.375 + CSEvalX_f(16.0/x-1.0, ai02, nai2))/sqrt(x);
  end;
end;


function sfc_i0(x: extended): extended;
  {-Return I0(x), the modified Bessel function of the 1st kind, order zero}
begin
  x := abs(x);
  if x<=3.0 then sfc_i0 := bess_i0_small(x)
  else if x>ln_MaxExt then sfc_i0 := PosInf_x
  else sfc_i0 := sfc_i0e(x)*exp_fa(x);
end;





function bess_i1_small(x: extended): extended;
  {-Return Bessel function I1(x) for abs(x)<=3}
var
  y: extended;
const
  xsml = 0.23283064365386962891e-9;  {sqrt(0.5*eps_x)}
const
  nbi1 = 12;
  bi1: array[0..nbi1-1] of extended = (
         -0.19717132610998597316138503218149e-2,
         +0.40734887667546480608155393652014e+0,
         +0.34838994299959455866245037783787e-1,
         +0.15453945563001236038598401058489e-2,
         +0.41888521098377784129458832004120e-4,
         +0.76490267648362114741959703966069e-6,
         +0.10042493924741178689179808037238e-7,
         +0.99322077919238106481371298054863e-10,
         +0.76638017918447637275200171681349e-12,
         +0.47414189238167394980388091948160e-14,
         +0.24041144040745181799863172032000e-16,
         +0.10171505007093713649121100799999e-18);
begin
  {Ref: W. Fullerton [14] and [20], files dbesi1.f and dbsi1e.f}
  y := abs(x);
  if y=0.0 then bess_i1_small := 0.0
  else if y<=xsml then bess_i1_small := 0.5*x
  else bess_i1_small := x*(0.875 + CSEvalX_f(x*x/4.5-1.0,bi1,nbi1));
end;



function sfc_i1e(x: extended): extended;
  {-Return I1(x)*exp(-|x|), the exponentially scaled modified Bessel function of the 1st kind, order one}
var
  y: extended;
const
  nai1 = 28;
   ai1: array[0..nai1-1] of extended = (
          -0.2846744181881478674100372468307e-1,
          -0.1922953231443220651044448774979e-1,
          -0.6115185857943788982256249917785e-3,
          -0.2069971253350227708882823777979e-4,
          +0.8585619145810725565536944673138e-5,
          +0.1049498246711590862517453997860e-5,
          -0.2918338918447902202093432326697e-6,
          -0.1559378146631739000160680969077e-7,
          +0.1318012367144944705525302873909e-7,
          -0.1448423418183078317639134467815e-8,
          -0.2908512243993142094825040993010e-9,
          +0.1266388917875382387311159690403e-9,
          -0.1664947772919220670624178398580e-10,
          -0.1666653644609432976095937154999e-11,
          +0.1242602414290768265232168472017e-11,
          -0.2731549379672432397251461428633e-12,
          +0.2023947881645803780700262688981e-13,
          +0.7307950018116883636198698126123e-14,
          -0.3332905634404674943813778617133e-14,
          +0.7175346558512953743542254665670e-15,
          -0.6982530324796256355850629223656e-16,
          -0.1299944201562760760060446080587e-16,
          +0.8120942864242798892054678342860e-17,
          -0.2194016207410736898156266643783e-17,
          +0.3630516170029654848279860932334e-18,
          -0.1695139772439104166306866790399e-19,
          -0.1288184829897907807116882538222e-19,
          +0.5694428604967052780109991073109e-20);
const
  nai2 = 33;
  ai12: array[0..nai2-1] of extended = (
         +0.2857623501828012047449845948469e-1,
         -0.9761097491361468407765164457302e-2,
         -0.1105889387626237162912569212775e-3,
         -0.3882564808877690393456544776274e-5,
         -0.2512236237870208925294520022121e-6,
         -0.2631468846889519506837052365232e-7,
         -0.3835380385964237022045006787968e-8,
         -0.5589743462196583806868112522229e-9,
         -0.1897495812350541234498925033238e-10,
         +0.3252603583015488238555080679949e-10,
         +0.1412580743661378133163366332846e-10,
         +0.2035628544147089507224526136840e-11,
         -0.7198551776245908512092589890446e-12,
         -0.4083551111092197318228499639691e-12,
         -0.2101541842772664313019845727462e-13,
         +0.4272440016711951354297788336997e-13,
         +0.1042027698412880276417414499948e-13,
         -0.3814403072437007804767072535396e-14,
         -0.1880354775510782448512734533963e-14,
         +0.3308202310920928282731903352405e-15,
         +0.2962628997645950139068546542052e-15,
         -0.3209525921993423958778373532887e-16,
         -0.4650305368489358325571282818979e-16,
         +0.4414348323071707949946113759641e-17,
         +0.7517296310842104805425458080295e-17,
         -0.9314178867326883375684847845157e-18,
         -0.1242193275194890956116784488697e-17,
         +0.2414276719454848469005153902176e-18,
         +0.2026944384053285178971922860692e-18,
         -0.6394267188269097787043919886811e-19,
         -0.3049812452373095896084884503571e-19,
         +0.1612841851651480225134622307691e-19,
         +0.3560913964309925054510270904620e-20);
begin
  {Ref: W. Fullerton [14] and [20], file dbsi1e.f}
  y := abs(x);
  if y<=3.0 then sfc_i1e := exp_fa(-y)*bess_i1_small(x)
  else begin
    if y<=8.0 then begin
      y := (0.375 + CSEvalX_f((48.0/y-11.0)/5.0, ai1, nai1))/sqrt(y)
    end
    else begin
      y := (0.375 + CSEvalX_f(16.0/y-1.0, ai12, nai2))/sqrt(y);
    end;
    if x>0 then sfc_i1e := y else sfc_i1e := -y;
  end;
end;




function sfc_i1(x: extended): extended;
  {-Return I1(x), the modified Bessel function of the 1st kind, order one}
var
  y: extended;
begin
  y := abs(x);
  if y<=3.0 then sfc_i1 := bess_i1_small(x)
  else if x>ln_MaxExt then sfc_i1 := PosInf_x
  else sfc_i1 := sfc_i1e(x)*exp_fa(y);
end;





{---------------------------------------------------------------------------}
function bess_k0_small(x: extended): extended;
  {-Return Bessel function K0(x) for 0 < x <= 2}
var
  y: extended;
const
  xsml = 0.46566128730773925781e-9;  {sqrt(2*eps_x)}
const
  nbk0 = 12;
  bk0: array[0..nbk0-1] of extended = (
         -0.353273932339027687201140060063153e-1,
         +0.344289899924628486886344927529213e+0,
         +0.359799365153615016265721303687231e-1,
         +0.126461541144692592338479508673447e-2,
         +0.228621210311945178608269830297585e-4,
         +0.253479107902614945730790013428354e-6,
         +0.190451637722020885897214059381366e-8,
         +0.103496952576336245851008317853089e-10,
         +0.425981614279108257652445327170133e-13,
         +0.137446543588075089694238325440000e-15,
         +0.357089652850837359099688597333333e-18,
         +0.763164366011643737667498666666666e-21);
begin
  {Ref: W. Fullerton [14] and [20], files dbesk0.f and dbsk0e.f}
  if x>xsml then y := x*x
  else begin
    if x=0.0 then begin
      bess_k0_small := PosInf_x;
      exit;
    end
    else y := 0.0;
  end;
  bess_k0_small := -ln(0.5*x)*bess_i0_small(x) - 0.25 + CSEvalX_f(0.5*y-1.0,bk0,nbk0);
end;



function sfc_k0e(x: extended): extended;
  {-Return K0(x)*exp(x), the exponentially scaled modified Bessel function of the 2nd kind, order zero, x>0}
const
  nak0 = 22;
   ak0: array[0..nak0-1] of extended = (
          -0.7643947903327941424082978270088e-1,
          -0.2235652605699819052023095550791e-1,
          +0.7734181154693858235300618174047e-3,
          -0.4281006688886099464452146435416e-4,
          +0.3081700173862974743650014826660e-5,
          -0.2639367222009664974067448892723e-6,
          +0.2563713036403469206294088265742e-7,
          -0.2742705549900201263857211915244e-8,
          +0.3169429658097499592080832873403e-9,
          -0.3902353286962184141601065717962e-10,
          +0.5068040698188575402050092127286e-11,
          -0.6889574741007870679541713557984e-12,
          +0.9744978497825917691388201336831e-13,
          -0.1427332841884548505389855340122e-13,
          +0.2156412571021463039558062976527e-14,
          -0.3349654255149562772188782058530e-15,
          +0.5335260216952911692145280392601e-16,
          -0.8693669980890753807639622378837e-17,
          +0.1446404347862212227887763442346e-17,
          -0.2452889825500129682404678751573e-18,
          +0.4233754526232171572821706342400e-19,
          -0.7427946526454464195695341294933e-20);
const
  nak2 = 18;
  ak02: array[0..nak2-1] of extended = (
          -0.1201869826307592239839346212452e-1,
          -0.9174852691025695310652561075713e-2,
          +0.1444550931775005821048843878057e-3,
          -0.4013614175435709728671021077879e-5,
          +0.1567831810852310672590348990333e-6,
          -0.7770110438521737710315799754460e-8,
          +0.4611182576179717882533130529586e-9,
          -0.3158592997860565770526665803309e-10,
          +0.2435018039365041127835887814329e-11,
          -0.2074331387398347897709853373506e-12,
          +0.1925787280589917084742736504693e-13,
          -0.1927554805838956103600347182218e-14,
          +0.2062198029197818278285237869644e-15,
          -0.2341685117579242402603640195071e-16,
          +0.2805902810643042246815178828458e-17,
          -0.3530507631161807945815482463573e-18,
          +0.4645295422935108267424216337066e-19,
          -0.6368625941344266473922053461333e-20);
begin
  {Ref: W. Fullerton [14] and [20], file dbsk0e.f}
  if x<=2.0 then sfc_k0e := exp_fa(x)*bess_k0_small(x)
  else if x<=8.0 then begin
    sfc_k0e := (1.25 + CSEvalX_f((16.0/x-5.0)/THREE, ak0, nak0))/sqrt(x);
  end
  else begin
    sfc_k0e := (1.25 + CSEvalX_f(16.0/x-1.0, ak02, nak2))/sqrt(x);
  end;
end;



function sfc_k0(x: extended): extended;
{-Return K0(x), the modified Bessel function of the 2nd kind, order zero, x>0}
begin
  if x<=2.0 then sfc_k0 := bess_k0_small(x)
  else sfc_k0 := sfc_k0e(x)*exp_fa(-x);
end;



{---------------------------------------------------------------------------}
function bess_k1_small(x: extended): extended;
  {-Return Bessel function K1(x) for 0 < x <= 2}
var
  y: extended;
const
  xsml = 0.46566128730773925781e-9;  {sqrt(2*eps_x)}
const
  nbk1 = 12;
  bk1: array[0..nbk1-1] of extended = (
         +0.25300227338947770532531120868533e-1,
         -0.35315596077654487566723831691801e+0,
         -0.12261118082265714823479067930042e+0,
         -0.69757238596398643501812920296083e-2,
         -0.17302889575130520630176507368979e-3,
         -0.24334061415659682349600735030164e-5,
         -0.22133876307347258558315252545126e-7,
         -0.14114883926335277610958330212608e-9,
         -0.66669016941993290060853751264373e-12,
         -0.24274498505193659339263196864853e-14,
         -0.70238634793862875971783797120000e-17,
         -0.16543275155100994675491029333333e-19);
begin
  {Ref: W. Fullerton [14] and [20], files dbesk1.f and dbsk1e.f}
  if x>xsml then y := x*x
  else begin
    if x=0.0 then begin
      bess_k1_small := PosInf_x;
      exit;
    end
    else y := 0.0;
  end;
  bess_k1_small := ln(0.5*x)*bess_i1_small(x) + (0.75 + CSEvalX_f(0.5*y-1.0,bk1,nbk1))/x;
end;



function sfc_k1e(x: extended): extended;
  {-Return K1(x)*exp(x), the exponentially scaled modified Bessel function of the 2nd kind, order one, x>0}
const
  nak1 = 22;
   ak1: array[0..nak1-1] of extended = (
          +0.27443134069738829695257666227266e+0,
          +0.75719899531993678170892378149290e-1,
          -0.14410515564754061229853116175625e-2,
          +0.66501169551257479394251385477036e-4,
          -0.43699847095201407660580845089167e-5,
          +0.35402774997630526799417139008534e-6,
          -0.33111637792932920208982688245704e-7,
          +0.34459775819010534532311499770992e-8,
          -0.38989323474754271048981937492758e-9,
          +0.47208197504658356400947449339005e-10,
          -0.60478356628753562345373591562890e-11,
          +0.81284948748658747888193837985663e-12,
          -0.11386945747147891428923915951042e-12,
          +0.16540358408462282325972948205090e-13,
          -0.24809025677068848221516010440533e-14,
          +0.38292378907024096948429227299157e-15,
          -0.60647341040012418187768210377386e-16,
          +0.98324256232648616038194004650666e-17,
          -0.16284168738284380035666620115626e-17,
          +0.27501536496752623718284120337066e-18,
          -0.47289666463953250924281069568000e-19,
          +0.82681500028109932722392050346666e-20);
const
  nak2 = 18;
  ak12: array[0..nak2-1] of extended = (
          +0.6379308343739001036600488534102e-1,
          +0.2832887813049720935835030284708e-1,
          -0.2475370673905250345414545566732e-3,
          +0.5771972451607248820470976625763e-5,
          -0.2068939219536548302745533196552e-6,
          +0.9739983441381804180309213097887e-8,
          -0.5585336140380624984688895511129e-9,
          +0.3732996634046185240221212854731e-10,
          -0.2825051961023225445135065754928e-11,
          +0.2372019002484144173643496955486e-12,
          -0.2176677387991753979268301667938e-13,
          +0.2157914161616032453939562689706e-14,
          -0.2290196930718269275991551338154e-15,
          +0.2582885729823274961919939565226e-16,
          -0.3076752641268463187621098173440e-17,
          +0.3851487721280491597094896844799e-18,
          -0.5044794897641528977117282508800e-19,
          +0.6888673850418544237018292223999e-20);
begin
  {Ref: W. Fullerton [14] and [20], file dbsk1e.f}
  if x<=2.0 then sfc_k1e := exp_fa(x)*bess_k1_small(x)
  else if x<=8.0 then begin
    sfc_k1e := (1.25 + CSEvalX_f((16.0/x-5.0)/THREE, ak1, nak1))/sqrt(x);
  end
  else begin
    sfc_k1e := (1.25 + CSEvalX_f(16.0/x-1.0, ak12, nak2))/sqrt(x);
  end;
end;



function sfc_k1(x: extended): extended;
  {-Return K1(x), the modified Bessel function of the 2nd kind, order one, x>0}
begin
  if x<=2.0 then sfc_k1 := bess_k1_small(x)
  else sfc_k1 := sfc_k1e(x)*exp_fa(-x);
end;




function sinh_f(x: extended): extended;
var
  t: extended;
begin
  if x = 0 then   sinh_f:=0 else
  begin
    t:=Exp_f(x);
    sinh_f:=(t-1/t)*0.5;
  end;
end;



function cosh_f(x: extended): extended;
var
  t: extended;
begin
  if x = 0 then   cosh_f:=0 else
  begin
    t:=Exp_f(x);
    cosh_f:=(t+1/t)*0.5;
  end;
end;


function sinhc_acc(x: extended): extended;
  {-Return sinh(x)/x, accurate even for x near 0}
var
  t: extended;
begin
  t := abs(x);
  if abs(t) < 1.0 then sinhc_acc := sinh_small(t, true)
  else if t < ln_MaxExt then sinhc_acc := sinh_acc(t)/t
  else begin
    t := t - ln(2.0*t);
    sinhc_acc := exp_acc(t);
  end;
end;



function sinhc_fa(x: extended): extended;
begin
  if F_FastSpec = True then  sinhc_fa:=sinh_f(x)/x else sinhc_fa:=sinhc_acc(x)
end;



procedure temme_k(v,x: extended; var K0,K1: extended);
  {-Calculate K(v, x) and K(v+1, x) by Temme's method for small |x|}
var
  k,h,p,q,f,c,d,s,s1,tol,a: extended;
  g1,g2,gp,gm: extended;
const
  MAXIT = 30000;
begin

{$ifdef debug}
  if (abs(v) > 0.5) or (abs(x) > 2.0) then begin
    if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
  end;
{$endif}

  {N.M. Temme [52], On the numerical evaluation of the }
  {modified Bessel function of the third kind. See also}
  {Boost [19], file bessel_ik.hpp / function temme_ik  }
  gp := sfc_gamma1pm1(v);
  gm := sfc_gamma1pm1(-v);
  a  := ln(0.5*x);
  s  := -a*v;
  h  := exp_fa(a*v);
  if abs(v) < eps_x then begin
    c  := 1.0;
    g1 := -EulerGamma;
  end
  else begin
    c  := sinPi_fa(v)/(v*Pi);
    g1 := (0.5*c/v)*(gp-gm);
  end;
  g2 := 0.5*c*(2.0+gp+gm);
  {initial values}
  p := 0.5*(1.0+gp)/h;
  q := 0.5*(1.0+gm)*h;
  f := (g1*cosh_fa(s) - a*g2*sinhc_fa(s))/c;
  h := p;
  c := 1.0;
  s := c*f;
  s1:= c*h;

  a := v*v;
  d := 0.25*x*x;

  {series summation}
  tol := 0.5*eps_x;
  k := 1.0;
  while k <= MAXIT do begin
    f := (k*f + p + q) / (k*k - a);
    p := p/(k - v);
    q := q/(k + v);
    h := p - k*f;
    c := c*d/k;
    s := s  + c*f;
    s1:= s1 + c*h;
    if abs(c*f) < abs(s)*tol then begin
      K0 := s;
      K1 := 2.0*s1/x;
      exit;
    end;
    k := k + 1.0;
  end;
  {No convergence}
  if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));
  K0 := s;
  K1 := 2.0*s1/x;
end;




procedure CF2_K(v,x: extended; escale: boolean; var K0,K1: extended);
  {-Compute K(v,x) and K(v+1,x) via continued fraction, |v| <= 0.5, |x| > 1}
  { If escale=true the values are multiplied by exp(x)}
var
  a,a1,b,c,d,dh,ds,h,q,q1,q2,s,t: extended;
  k: integer;
const
  MAXIT = 30000;
label
  done;
begin
  {Ref: Numerical Recipes [13], Ch. 6.7, section Modified Bessel Functions}
  {and p.249, function bessik. It is based on I.J. Thompson, A.R. Barnett,}
  {1987, Computer Physics Communications, vol. 47, pp. 245-257.           }

{$ifdef debug}
  if (abs(v) > 0.5) or (abs(x) <= 1.0) then begin
    if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
  end;
{$endif}

  b  := 2.0*(1.0+x);
  d  := 1.0/b;
  h  := d;
  dh := d;
  q1 := 0.0;
  q2 := 1.0;
  a  := v*v - 0.25;
  a1 := -a;
  q  := a1;
  c  := a1;
  s  := 1.0+q*dh;
  for k:=2 to MAXIT do begin
    a  := a - 2*(k-1);
    c  := -a*c/k;
    t  := (q1-b*q2)/a;
    q1 := q2;
    q2 := t;
    q  := q + c*t;
    b  := b + 2.0;
    d  := 1.0/(b+a*d);
    dh := (b*d-1.0)*dh;
    h  := h + dh;
    ds := q*dh;
    s  := s + ds;
    if abs(ds) < abs(s)*eps_x then goto done;
  end;
  {No convergence}
  if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));

done:

  K0 := sqrt(Pi_2/x)/s;
  if not escale then K0 := K0*exp_fa(-x);
  K1 := K0*(v+x+0.5-a1*h)/x;
end;



function bess_i_large(v,x: extended; var Ivs: extended): boolean;
  {-Compute I_v(x) for large x >= 100,  sqrt(x) >= 2v. Return true}
  { if 'convergence' within 50 iterations, Ivs = I_v(x)*exp(-x)*sqrt(2Pix)}
var
  s,t,u,w: extended;
  k: integer;
begin
  {Hankel expansion of Iv, NIST[30], 10.40.1 and 10.17.1}
  u := 4.0*sqr(v);
  w := 8.0*x;
  {Typical values: w >= 800,  u/w < 1/8}
  t := 1.0;
  s := 1.0;
  bess_i_large := false;
  for k:=1 to 50 do begin
    t := t*(sqr(2*k-1)-u)/k/w;
    s := s + t;
    if abs(t)<eps_x then begin
      bess_i_large := true;
      Ivs := s;
      exit;
    end;
  end;
  Ivs := s;
end;


procedure bessel_ik(v,x: extended; CalcI, escale: boolean; var Iv,Kv: extended);
  {-Return I_v(x) and/or K_v(x) depending on CalcI, x>0, |v| < MaxLongint}
  { If escale=true the values are exponentially scaled.}
var
  n,k: longint;
  u, Kv1, Ku, Ku1, fv: extended;
  w, curr, prev, next, t, x2: extended;
  reflect,OK,kzero: boolean;
begin

  {Ref: Boost [19] file bessel_ik.hpp, function bessel_ik}
  {and NR [13], Ch.6.7, section Modified Bessel Functions}

  reflect := v < 0.0;
  v  := abs(v);

  x2 := 0.5*x;
  n  := round(v);
  u  := v-n;

  if x <= 2.0 then begin
    temme_k(u, x, Ku, Ku1);
    if escale then begin
      fv := exp_fa(x);
      Ku := Ku*fv;
      Ku1:= Ku1*fv;
    end;
  end
  else CF2_K(u, x, escale, Ku, Ku1);

  kzero := (abs(Ku1)+abs(Ku))=0.0;
  if not kzero then begin
    prev := Ku;
    curr := Ku1;
    for k:=1 to n do begin
      {forward recurrence for K}
      t := (u+k)/x2;
      if (t > 1.0) and (curr >= MaxExtended/t) then begin
        Kv := PosInf_x;
        if CalcI then begin
          if Reflect then Iv := PosInf_x else Iv := 0.0;
        end;
        exit;
      end;
      next := t*curr + prev;
      prev := curr;
      curr := next;
    end;
    Kv  := prev;
    Kv1 := curr;
    kzero := (abs(Kv1)+abs(Kv))=0.0;
  end
  else begin
    Kv  := 0.0;
    Kv1 := 0.0;
  end;

  if CalcI then begin
    if (x >= 100.0) and (2.0*v <= sqrt(x)) then begin
      {Asymptotic expansion HMF[1], 9.7.1 or NIST[30], 10.40.4}
      OK := bess_i_large(v,x,t);
      if not escale then begin
        {Even if no convergence the result is used for ovrflow check}
        if (t <= 0.0) or (x+ln(t)-0.5*ln(TwoPi*x) >= ln_MaxExt) then begin
          Iv := PosInf_x;
          exit;
        end;
      end;
      if OK then begin
        if escale then Iv := t/sqrt(TwoPi*x)
        else begin
          u  := exp_fa(0.5*x);
          Iv := u*(u*(t/sqrt(TwoPi*x)));
        end;
      end;
    end
    else begin
      if kzero then begin
        Iv := PosInf_x;
        exit;
      end;
      CF1_I(v, x, fv);
      w  := 1.0/x;
      Iv := w/(Kv*fv + Kv1); {Wronskian relation}
    end;
    if reflect then begin
      {Kv contribution to reflection}
      t := sinPi_fa(v)*Kv/Pi_2;
      {Note: Kv is scaled with exp(|x|), so we have to multiply with exp(-2|x|)}
      if escale then t := t*exp_fa(-2.0*abs(x));
      Iv := Iv + t;
    end;
  end;
end;




procedure CF1_I(v,x: extended; var fv: extended);
  {-Return I_(v+1)(x) / I_v(x) using continued fraction}
var
  c,d,f,b,t,tiny,tol: extended;
  k: integer;
const
  MAXIT = 30000;
begin
  {Evaluate NIST[30], 10.33.1 using modified Lentz's method.}
  {Ref: NR [13] (6.7.21) and p.248, function bessik         }
  {and Boost [19] file bessel_ik.hpp, function CF1_Ik       }
  {If |x| <= |v|, CF1_I converges rapidly but if |x| > |v|  }
  {then CF1_I needs O(|x|) iterations to converge!          }

  tol  := 2.0*eps_x;
  tiny := Sqrt_MinExt;
  c := tiny;
  f := tiny;
  d := 0.0;
  for k:=1 to MAXIT do begin
    b := 2.0*(v + k)/x;
    c := b + 1.0/c;
    d := b + d;
    if c=0.0 then c := tiny;
    if d=0.0 then d := tiny;
    d := 1.0/d;
    t := c * d;
    f := f*t;
    if abs(t-1.0) < tol then begin
      fv := f;
      exit;
    end;
  end;
  {No convergence}
  if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));
  fv := f;
end;




function sfc_iv(v, x: extended): extended;
  {-Return I_v(x), the modified Bessel function of the 1st kind, order v.}
var
  r,t: extended;
const
  IvMaxXH: THexExtW = ($7D70,$8F6F,$7209,$B188,$400C);  {+1.1362111364594631013E+4}
begin

  if IsNaNorInf(x) or IsNaNorInf(v) then
  begin
    sfc_iv := NaN_x;
    GenerateFPUException(FPUErrorNAN); {.375}
    exit;
  end;

  if x<0.0 then begin
    {if v is not an integer I(v, x) is complex}
    if frac(v)=0.0 then begin
      r := sfc_iv(v,-x);
      if frac(0.5*v)<>0 then r := -r;
      sfc_iv := r;
    end
    else
    begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      sfc_iv := NaN_x;
      GenerateFPUException(FPUErrorNAN); {.375}
    end;
  end
  else if abs(v)=0.5 then begin
    {NIST[30] 10.39.1: I(0.5,x)=sinh(x)/R, I(-0.5,x)=cosh(x)/R, R=sqrt(Pi*x/2)}
    if x >= Ln_MaxExt then begin
      if x >= extended(IvMaxXH) then sfc_iv := PosInf_x
      else begin
        {Avoid overflow for x in range 11356.52 .. 11362.11}
        r := exp_fa(0.5*x);
        sfc_iv := r*(r/sqrt(TwoPi*x));
      end;
    end
    else begin
      r := sqrt(Pi_2*x);
      if v<0.0 then sfc_iv := cosh_fa(x)/r
      else sfc_iv := sinh_fa(x)/r;
    end;
  end
  else if x=0.0 then begin
    if v=0.0 then sfc_iv := 1.0
    else sfc_iv := 0.0;
  end
  else begin
    {x>0}
    if v=0.0 then sfc_iv := sfc_i0(x)
    else if abs(v)=1.0 then sfc_iv := sfc_i1(x)
    else if x >= extended(IvMaxXH) then sfc_iv := PosInf_x
    else begin
      bessel_ik(v,x,true,false,r,t);
      sfc_iv := r;
    end;
  end;
end;




function IJ_series(v,x: extended; CalcJv: boolean): extended;
  {-Power series for Bessel J_v(x) or I_v(x), 0 <= v < MAXGAMX-1, 0 <= x <= 2}
var
  f,s,t: extended;
  n: integer;
begin
  f := 0.5*x;
  t := power_fa(f,v)/sfc_gamma(v+1.0);
  if CalcJv then f := -f*f else f := f*f;
  s := t;
  n := 0;
  repeat
    inc(n);
    t := t*f/n/(v+n);
    s := s + t;
  until abs(t) <= 0.5*eps_x*abs(s);
  IJ_series := s;
end;


function sfc_in(n: integer; x: extended): extended;
  {-Return I_n(x), the modified Bessel function of the 1st kind, order n}
var
  curr,prev,temp,init,y: extended;
  k: integer;
const
  NMax = 256;     {double: 160}
  XMax = 1024.0;  {double: 512}
begin
  if IsNaNorInf(x)  then
  begin
    sfc_in := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  {HMF[1], 9.6.6: I(-n,x) = I(n,x)}
  n := abs(n);
  if n=0 then sfc_in := sfc_i0(x)
  else if n=1 then sfc_in := sfc_i1(x)
  else if x=0.0 then sfc_in := 0.0
  else begin
    y := abs(x);
    {If n or x are not small then use real order function}
    if (n>NMax) or (y>XMax) then sfc_in := sfc_iv(n,x)
    else begin
      {Simplified calculation for I_n only with existing functions}
      if y <= 2.0 then begin
        curr := IJ_series(n,y,false);
      end
      else begin
        {I_(n+1)(y)/I_n(y) using continued fraction and recurse backwards}
        CF1_I(n,y,temp);
        y := 0.5*y;
        init := Sqrt_MinExt;
        curr := init;
        prev := init*temp;
        for k:=n downto 1 do begin
          temp := curr*k/y + prev;
          prev := curr;
          curr := temp;
        end;
        curr := (init/curr)*sfc_i0(x);
      end;
      {Adjust sign}
      if (x<0.0) and odd(n) then curr := -curr;
      sfc_in := curr;
    end;
  end;
end;



function expm1(x: extended): extended;
  {-Return exmp1(x)-1, accurate even for x near 0}
const
  nce=17;
  ceh: array[0..nce-1] of THexExtW = (     {chebyshev(((exp(x)-1)/x - 1)/x, x=-1..1, 0.1e-20);}
         ($6A89,$722B,$FAC5,$8577,$3FFF),  {+1.04272398606220957726049179176     }
         ($D006,$0AFA,$F911,$B131,$3FFC),  {+0.173042194047179631675883846985    }
         ($D2C9,$D68A,$A866,$B073,$3FF9),  {+0.215395249458237651324867090935e-1 }
         ($B98A,$635F,$18B1,$8CA8,$3FF6),  {+0.214624979834132263391667992385e-2 }
         ($6731,$7DD9,$FF11,$BAFB,$3FF2),  {+0.178322182449141937355350007488e-3 }
         ($4297,$88F5,$C8BC,$D52A,$3FEE),  {+0.127057507929428665687742064639e-4 }
         ($2C99,$3975,$4676,$D4B9,$3FEA),  {+0.792457652881593907264616203751e-6 }
         ($196B,$F18F,$09DF,$BCC1,$3FE6),  {+0.439477285666343943629044429651e-7 }
         ($A60E,$D37D,$5A0B,$96C6,$3FE2),  {+0.219406227546144888207254174079e-8 }
         ($F7F8,$EF82,$8D42,$DB05,$3FDD),  {+0.995995318266659554765505887521e-10}
         ($CB48,$CD67,$F8D6,$91D8,$3FD9),  {+0.414523660148535566445986193898e-11}
         ($9AFA,$57D1,$F72D,$B352,$3FD4),  {+0.159271781651030822298380021406e-12}
         ($560F,$44FD,$5097,$CCC2,$3FCF),  {+0.568320507930678710973086211864e-14}
         ($33CD,$BF09,$610D,$DA3C,$3FCA),  {+0.189289431283787337567205644620e-15}
         ($7E97,$7C7D,$7B0A,$DA14,$3FC5),  {+0.591107031096332196225712012488e-17}
         ($1F08,$8285,$97C9,$CD1E,$3FC0),  {+0.173742977663542892171117958472e-18}
         ($0AA6,$23C8,$CF63,$B638,$3FBB)); {+0.482337391484586252954369194368e-20}
var
  ces: array[0..nce-1] of extended absolute ceh;
  t: extended;
begin
  if abs(x)<=1.0 then begin
    t := CSEvalx_f(x, ces, nce);
    expm1 := x + x*x*t;
  end
  else expm1 := exp_fa(x)-1.0;
end;



function sfc_gamma1pm1(x: extended): extended;
  {-Return gamma(1+x)-1 with increased accuracy for x near 0}
begin
  if abs(x)<=eps_x then sfc_gamma1pm1 := -EulerGamma*x
  else if (x<-0.5) or (x>2.0) then sfc_gamma1pm1 := sfc_gamma(1.0+x)-1.0
  else if x>0.0 then sfc_gamma1pm1 := expm1(lngamma_small(x+1.0,x,x-1.0,true))
  else sfc_gamma1pm1 := expm1(lngamma_small(x+2.0,x+1.0,x,false) - ln1p(x));
end;




function sfc_kn(n: integer; x: extended): extended;
  {-Return K_n(x), the modified Bessel function of the 2nd kind, order n, x>0, not suitable for large n}
var
  kn,knm1,knm2: extended;
  k: integer;
begin
  {HMF[1], 9.6.6: K(-n,x) = K(n,x)}
  n := abs(n);
  {Range error for x<=0 is generated in k0 or k1}
  if n=0 then kn := sfc_k0(x)
  else if n=1 then kn := sfc_k1(x)
  else begin
    {avoid false warning "Variable 'kn' might not have been initialized"}
    kn := 0.0;
    {forward recurrence, K(n+1,x) = 2n/x*K(n,x) + K(n-1,x)}
    knm2 := sfc_k0(x);
    knm1 := sfc_k1(x);
    x := 0.5*x;
    for k:=1 to n-1 do begin
      kn   := knm1*k/x + knm2;
      knm2 := knm1;
      knm1 := kn;
    end;
  end;
  sfc_kn := kn;
end;




function sfc_kv(v, x: extended): extended;
  {-Return K_v(x), the modified Bessel function of the 2nd kind, order v, x>0}
var
  r,t: extended;
begin

  if IsNaNorInf(x) or IsNaNorInf(v) then
  begin
    sfc_kv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;

  if (frac(v)=0.0) and (v<MaxInt) then sfc_kv := sfc_kn(round(v),x)
  else if x<=0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_kv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
  end
  else begin
    if abs(v)=0.5 then begin
      {NIST[30] 10.39.2: K(0.5,x) = K(-0.5,x) = exp(-x)*sqrt(Pi/2/x)}
      sfc_kv := exp_fa(-x)*sqrt(Pi_2/x);
    end
    else begin
      bessel_ik(v, x, false, false, t, r);
      sfc_kv := r;
    end;
  end;
end;



function bessel_In(pn: PInteger; px: PExtended): extended;  stdcall;
{Return I_n(x), the Bessel function }
begin
  bessel_In := sfc_in(pn^,px^);
end;




function bessel_iv(pv,px: PExtended): extended;  stdcall;
{Return I_v(x), the modified Bessel function of the 1st kind, order v.}
begin
  bessel_iv := sfc_iv(pv^,px^);
end;




function bessel_k0(px: PExtended): extended;  stdcall;
begin
  bessel_k0 := sfc_k0(px^);
end;



function bessel_k1(px: PExtended): extended;  stdcall;
begin
  bessel_k1 := sfc_k1(px^);
end;




function bessel_kn(pn: PInteger; px: PExtended): extended;  stdcall;
 {Return K_n(x), the modified Bessel function of the 2nd kind, order n, x>0, not suitable for large n}
begin
  bessel_kn := sfc_kn(pn^,px^);
end;


function bessel_kv(pv,px: PExtended): extended;  stdcall;
 {Return K_v(x), the modified Bessel function of the 2nd kind, order v, x>0}
begin
  bessel_kv := sfc_kv(pv^,px^);
end;



function bessel_i0(px: PExtended): extended;  stdcall;
begin
  bessel_i0 := sfc_i0(px^);
end;



function bessel_i1(px: PExtended): extended;  stdcall;
 {-Return I1(x), the modified Bessel function of the 1st kind, order zero}
begin
  bessel_i1 := sfc_i1(px^);
end;



function bessel_j0(px: PExtended): extended;  stdcall;
  {Return J0(x), the Bessel function of the 1st kind, order zero}
begin
  bessel_j0 := sfc_j0(px^);
end;


{---------------------------------------------------------------------------}
function bessel_j1(px: PExtended): extended;  stdcall;
  {Return J1(x), the Bessel function of the 1st kind, order one}
begin
  bessel_j1 := sfc_j1(px^);
end;


{---------------------------------------------------------------------------}
function bessel_jn(pn: PInteger; px: PExtended): extended;  stdcall;
{Return J_n(x), the Bessel function of the 1st kind, order n; not suitable for large n or x.}
begin
  bessel_jn := sfc_jn(pn^,px^);
end;



function bessel_jv(pv,px: PExtended): extended;  stdcall;
{Return J_v(x), the Bessel function of the 1st kind, order v; not suitable for large v.}
begin
  bessel_jv := sfc_jv(pv^,px^);
end;




function bessel_y0(px: PExtended): extended;  stdcall;
  {-Return Y0(x), the Bessel function of the 2 kind, order zero}
begin
  bessel_y0 := sfc_y0(px^);
end;



function bessel_y1(px: PExtended): extended;  stdcall;
  {-Return Y1(x), the Bessel function of the 2 kind, order one}
begin
  bessel_y1 := sfc_y1(px^);
end;



function bessel_yn(pn: PInteger; px: PExtended): extended;  stdcall;
{-Return Y_n(x), the Bessel function of the 2 kind, order n; not suitable for large n or x.}
begin
  bessel_yn := sfc_yn(pn^,px^);
end;



function bessel_yv(pv,px: PExtended): extended;  stdcall;
 {Return Y_v(x), the Bessel function of the 2nd kind, order v; x > 0; not suitable for large v.}
begin
  bessel_yv := sfc_yv(pv^,px^);
end;




function sfc_legendre_plm(l,m: integer; x: extended): extended;   stdcall;
  {-Return the associated Legendre polynomial P_lm(x)}
var
  f: extended;
begin

  if IsNaNorInf(x) then
   begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_legendre_plm := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;

  if m=0 then sfc_legendre_plm := sfc_legendre_p(l,x)
  else begin
    f := (1.0-x)*(1.0+x);
    if f=0.0 then sfc_legendre_plm := 0.0
    else begin
      f := power_fa(abs(f), 0.5*abs(m));
      if x > -1.0 then sfc_legendre_plm := legendre_plmf(l,m,x,f)
      else begin
        {Switch to positive degree. Although legendre_plmf handles this case, }
        {it is already done here because it changes the odd/even status below.}
        if l<0 then l := -l-1;
        {x on the branch cut (-inf,-1), choose P_lm(x + i*0)}
        {and use Lebedev [45], 7.12.24 with integer nu = l}
        f := legendre_plmf(l,m,abs(x),f);
        if odd(l) then sfc_legendre_plm := -f
        else sfc_legendre_plm := f;
      end;
    end;
  end;
end;






function bessy_large(v, x: extended): extended;
  {-Return Y_v(x) via modulus/phase asymptotic expansion, x large}
var
  mv,tv,st,ct,sx,cx: extended;
begin
  h1v_large(v,x,mv,tv);
  //sincos_x(tv,st,ct);
  //sincos_x(x,sx,cx);
  sincos_fa(tv,st,ct);  {.335}
  sincos_fa(x,sx,cx);  {.335}
  {Y_v := mv*sin(x+tv); sin(x+tv) = cos(x)sin(tv) + sin(x)cos(tv)}
  bessy_large := mv*(st*cx + ct*sx);
end;





function sfc_y0(x: extended): extended;
  {-Return Y0(x), the Bessel function of the 2nd kind, order zero; x>0}
var
  y, z: extended;
const
  {The first four roots of Y0, calculated with Maple and t_rcalc/xh}
  y1h: THexExtW = ($DE10,$C2B4,$9A6C,$FD4A,$4000);  {3.9576784193148578685}
  y2h: THexExtW = ($1734,$3908,$EE27,$E2C0,$4001);  {7.0860510603017726975}
  y3h: THexExtW = ($BC69,$23EA,$B9AD,$A38E,$4002);  {10.222345043496417019}
  y4h: THexExtW = ($4D04,$0F3A,$0E25,$D5C7,$4002);  {13.361097473872763478}
var
  y0z1: extended absolute y1h;
  y0z2: extended absolute y2h;
  y0z3: extended absolute y3h;
  y0z4: extended absolute y4h;
const
  y0nhex: array[0..7] of THexExtW = (
            ($5fbd,$0171,$135a,$8340,$c035),
            ($501f,$6264,$bdf4,$9d17,$4036),
            ($23c9,$6b29,$4244,$c4c9,$c032),
            ($b219,$37ba,$5142,$9f1f,$402d),
            ($3e3c,$b343,$46c9,$e45f,$c026),
            ($2fdd,$4b27,$ca98,$a1c3,$401f),
            ($2ec0,$7b95,$297f,$df70,$c016),
            ($126c,$20be,$647f,$f344,$400c));
  y0dhex: array[0..7] of THexExtW = (
            ($241a,$8f2b,$629a,$de4b,$4038),
            ($04d3,$a629,$d61d,$b410,$4032),
            ($6732,$8c1b,$c5ab,$9384,$402b),
            ($553b,$4dc8,$8695,$a0c3,$4023),
            ($97a4,$90fa,$a7e9,$801c,$401b),
            ($d938,$b6b2,$71d8,$98be,$4012),
            ($9057,$7f25,$59b7,$8219,$4009),
            ($0000,$0000,$0000,$8000,$3fff));
  y059nh: array[0..9] of THexExtW = (
            ($f90c,$3510,$0be9,$87e7,$c012),
            ($fd54,$b2fe,$0a23,$e37e,$c00f),
            ($8c07,$29e3,$11be,$9f10,$4012),
            ($49e2,$fb52,$02af,$be8a,$4010),
            ($e8fa,$4b44,$4a39,$dc5b,$400b),
            ($62e0,$c25b,$2cb3,$8f12,$c00b),
            ($d5a3,$f673,$4e59,$9a8c,$4005),
            ($5504,$035a,$59fa,$ca14,$4003),
            ($1207,$46ea,$c3db,$bc88,$bfff),
            ($992f,$ab45,$90b6,$c20b,$3ff9));
  y059dh: array[0..9] of THexExtW = (
            ($3b3b,$ea0b,$b8d1,$8bd7,$401d),
            ($ceb6,$3463,$5ddb,$d1b5,$401e),
            ($e26b,$76b9,$250a,$a7fb,$c01c),
            ($27ff,$ca92,$3d78,$cea1,$4019),
            ($ec8a,$4697,$ddde,$a742,$c016),
            ($e8b6,$d705,$da91,$d62c,$4012),
            ($a28c,$5563,$d19f,$c75e,$c00e),
            ($ad09,$8e6a,$a502,$8b0c,$400a),
            ($debf,$a468,$8a55,$f96b,$c004),
            ($0000,$0000,$0000,$8000,$3fff));
var
  y059n: array[0..9] of extended absolute y059nh;
  y059d: array[0..9] of extended absolute y059dh;
  y0n:   array[0..7] of extended absolute y0nhex;
  y0d:   array[0..7] of extended absolute y0dhex;
begin
  {Ref: Cephes [7], file ldouble\j0l.c}
  if x<=0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_y0 := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if x < 9.0 then begin
    z := sqr(x);
    if z < 20.25 then begin
      {In the interval [0,4.5) a rational approximation of the}
      {form Y0(x) = P7(x)/Q7(x) + 2/Pi*ln(x)*J0(x) is used.   }
      y := ln(x)*sfc_j0(x)/Pi_2;

      //sfc_y0 := y + PolEvalX(z,y0n,8)/PolEvalX(z,y0d,8);
      sfc_y0 := y + (((((((y0n[7]*z+y0n[6])*z+y0n[5])*z+y0n[4])*z+y0n[3])*z+y0n[2])*z+y0n[1])*z+y0n[0])/((((((((y0d[7]*z+y0d[6])*z+y0d[5])*z+y0d[4])*z+y0d[3])*z+y0d[2])*z+y0d[1])*z+y0d[0]));

    end
    else begin
      {In the interval [4.5,9) a rational approximation of the}
      {form Y0(x) = (x - p)(x - q)(x - r)(x - s)P9(x)/Q9(x) is}
      {is used where p, q, r, s are first four zeros of Y0(x).}
      y := (x - y0z1)*(x - y0z2)*(x - y0z3)*(x - y0z4);

      //sfc_y0 := y * PolEvalX(x,y059n,10)/PolEvalX(x,y059d,10);
       sfc_y0 := y*(((((((((y059n[9]*x+y059n[8])*x+y059n[7])*x+y059n[6])*x+y059n[5])*x+y059n[4])*x+y059n[3])*x+y059n[2])*x+y059n[1])*x+y059n[0])/(((((((((y059d[9]*x+y059d[8])*x+y059d[7])*x+y059d[6])*x+y059d[5])*x+y059d[4])*x+y059d[3])*x+y059d[2])*x+y059d[1])*x+y059d[0]);

    end;
  end
  else begin
    {For x>=9 the common rational approximations to modulus}
    {and phase are used Y0(x) = modulus * sin(phase).}
    if x >= 1600 then sfc_y0 := bessy_large(0,x)
    else begin
      bess_m0p0(x,y,z);
      sfc_y0 := y*sin_fa(z);
    end;
  end;
end;



function sfc_y1(x: extended): extended;
  {-Return Y1(x), the Bessel function of the 2nd kind, order one; x>0}
var
  y, z: extended;
const
  {The first four roots of Y1, calculated with Maple and t_rcalc/xh}
  y1h: THexExtW = ($1721,$FF92,$F6A6,$8C9D,$4000); {2.1971413260310170351}
  y2h: THexExtW = ($73C0,$3D81,$F274,$ADBF,$4001); {5.4296810407941351328}
  y3h: THexExtW = ($A148,$0B4D,$3D73,$8989,$4002); {8.5960058683311689268}
  y4h: THexExtW = ($3022,$A190,$89C6,$BBFC,$4002); {11.749154830839881243}
var
  y1z1: extended absolute y1h;
  y1z2: extended absolute y2h;
  y1z3: extended absolute y3h;
  y1z4: extended absolute y4h;
const
  y1nhex: array[0..6] of THexExtW = (
            ($3a10,$0848,$5930,$9965,$c035),
            ($7f8b,$4757,$75bd,$a196,$4033),
            ($69fd,$1242,$f62d,$de75,$c02e),
            ($5633,$aa6b,$79e5,$e62c,$4028),
            ($7607,$a687,$af0a,$d892,$c021),
            ($53e4,$194c,$befa,$bd19,$4019),
            ($5b16,$f7f8,$0d7e,$fbbd,$c00f));
  y1dhex: array[0..7] of THexExtW = (
            ($7302,$b91b,$de7e,$c399,$4037),
            ($8c6a,$397e,$0963,$ad7a,$4031),
            ($aaf0,$342b,$d098,$9ca5,$402a),
            ($57e0,$1d92,$90a9,$bd99,$4022),
            ($0e86,$117b,$36d6,$a94a,$401a),
            ($298c,$29ef,$0630,$e482,$4011),
            ($dd1a,$3b8e,$ab73,$df28,$4008),
            ($0000,$0000,$0000,$8000,$3fff));
  y159nh: array[0..9] of THexExtW = (
            ($539b,$f305,$c3d8,$97f6,$4011),
            ($f62f,$d968,$8c66,$8d15,$c013),
            ($3811,$a3da,$413f,$dc24,$c013),
            ($cd43,$2f50,$1118,$d972,$c013),
            ($a33b,$8229,$1561,$f1fc,$c00f),
            ($b2bf,$4296,$65af,$a3d1,$400d),
            ($df40,$226b,$7e37,$c0d9,$400b),
            ($e917,$8486,$0ebd,$e6c3,$c008),
            ($fdf1,$41e5,$4beb,$ac44,$4004),
            ($b5e5,$bb42,$f667,$ae3f,$bffe));
  y159dh: array[0..10] of THexExtW = (
            ($a231,$6ab0,$7952,$cdb2,$4019),
            ($b3ad,$1c6d,$0f07,$8ba8,$c01d),
            ($8e0e,$e148,$5ab3,$ff44,$401e),
            ($a46a,$0273,$bc0f,$c358,$c01c),
            ($6de5,$b797,$ea1c,$e66b,$4019),
            ($e5e5,$4172,$8863,$b4a0,$c016),
            ($3c4f,$dc46,$b802,$e107,$4012),
            ($bed4,$3ad5,$2da1,$cc1d,$c00e),
            ($d0fe,$2487,$01c0,$8be3,$400a),
            ($1a6c,$1c93,$612a,$f742,$c004),
            ($0000,$0000,$0000,$8000,$3fff));
var
  y159n: array[0..9]  of extended absolute y159nh;
  y159d: array[0..10] of extended absolute y159dh;
  y1n:   array[0..6]  of extended absolute y1nhex;
  y1d:   array[0..7]  of extended absolute y1dhex;
begin
  {Ref: Cephes [7], file ldouble\j1l.c}
  if x<=0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_y1 := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if x < 9.0 then begin
    z := sqr(x);
    if z < 20.25 then begin
      {In the interval [0,4.5) a rational approximation of the form}
      {Y1(x) = x*P6(x)/Q7(x) + 2/Pi*(ln(x)*J1(x) - 1/x) is used.}
      y := (ln(x)*sfc_j1(x) - 1.0/x)/Pi_2;

      //sfc_y1 := y + x*PolEvalX(z,y1n,7)/PolEvalX(z,y1d,8);
      sfc_y1 := y + x*((((((y1n[6]*z+y1n[5])*z+y1n[4])*z+y1n[3])*z+y1n[2])*z+y1n[1])*z+y1n[0])/(((((((y1d[7]*z+y1d[6])*z+y1d[5])*z+y1d[4])*z+y1d[3])*z+y1d[2])*z+y1d[1])*z+y1d[0]);

    end
    else begin
      {In the interval [4.5,9) a rational approximation of the form}
      {Y1(x) = (x - p)*(x - q)*(x - r)*(x - s)*P9(x)/Q10(x) is used}
      {where p, q, r, s are first four zeros of Y1(x).}
      y := (x - y1z1)*(x - y1z2)*(x - y1z3)*(x - y1z4);

      //sfc_y1 := y * PolEvalX(x,y159n,10)/PolEvalX(x,y159d,11);
      sfc_y1 := y * (((((((((y159n[9]*x+y159n[8])*x+y159n[7])*x+y159n[6])*x+y159n[5])*x+y159n[4])*x+y159n[3])*x+y159n[2])*x+y159n[1])*x+y159n[0])/((((((((((y159d[10]*x+y159d[9])*x+y159d[8])*x+y159d[7])*x+y159d[6])*x+y159d[5])*x+y159d[4])*x+y159d[3])*x+y159d[2])*x+y159d[1])*x+y159d[0]);

    end;
  end
  else begin
    {For x>=9 the common rational approximations to modulus}
    {and phase are used Y1(x) = modulus * sin(phase).}
    if x >= 1600 then sfc_y1 := bessy_large(1,x)
    else begin
      bess_m1p1(x,y,z);
      sfc_y1 := y*sin_fa(z);
    end;
  end;
end;


function sfc_lnfac(n: longint): extended;
  {-Return ln(n!), INF if n<0}
begin
  {if n>25 then sfc_lnfac := sfc_lngamma(n+1.0)
  else begin
    if n<0 then sfc_lnfac := PosInf_x
    else sfc_lnfac := ln(Factorial[n]);
  end;    }

  sfc_lnfac:=ln(_factorial(n));
end;


function sfc_yn(n: integer; x: extended): extended;
  {-Return Y_n(x), the Bessel function of the 2nd kind, order n, x>0, not suitable for large n or x}
var
  yn,yn1,t: extended;
  k: integer;
  neg: boolean;
const
  lnpi = 1.144729885849400174;
begin
  {Flag to negate result for |n|}
  neg := (n<0) and odd(n);
  n := abs(n);
  if x<=0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_yn := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if n=0 then yn := sfc_y0(x)
  else if n=1 then yn := sfc_y1(x)
  else if (n>MAXGAMX) and (x<=2.0) then yn := NegInf_x
  else begin
    if x<1.0 then begin
      {NIST[30] 10.7.4}
      t := sfc_lnfac(n-1) - n*ln(0.5*x) - lnpi;
      if t > ln_MaxExt then begin
        if neg then sfc_yn := PosInf_x else sfc_yn := NegInf_x;
        exit;
      end;
    end;
    {forward recurrence}
    yn1 := sfc_y0(x);
    yn  := sfc_y1(x);
    x := 0.5*x;
    for k:=1 to n-1 do begin
      t  := yn*k/x - yn1;
      yn1:= yn;
      yn := t;
    end;
  end;
  if neg then sfc_yn := -yn else sfc_yn := yn;
end;


{-----------------------BESSEL SHERICAL---------------------------------------}  {shb}

function sph_bessel_jn(pn: PInteger; px: PExtended): extended;  stdcall;
{-Return J_n(x), the Bessel function of the 2 kind, order n; not suitable for large n or x.}
begin
  sph_bessel_jn := sfc_sph_jn(pn^,px^);
end;


function sph_bessel_yn(pn: PInteger; px: PExtended): extended;  stdcall;
{-Return Y_n(x), the Bessel function of the 2 kind, order n; not suitable for large n or x.}
begin
  sph_bessel_yn := sfc_sph_yn(pn^,px^);
end;




function maxx(x, y: extended): extended; {$ifdef HAS_INLINE} inline;{$endif}
  {-Return the maximum of two extendeds; x,y <> NAN}
begin
  if x>y then maxx := x
  else maxx := y;
end;

procedure sincosPi_acc(x: extended; var s,c: extended);
  {-Return s=sin(Pi*x), c=cos(Pi*x); (s,c)=(0,1) for abs(x) >= 2^64}
var
  t,ss,cc: extended;
  n: integer;
begin
  n := rem_int2(x,t) and 3;
  t := Pi*t;
  sincos_fa(t,ss,cc);
  case n of
      0: begin s:= ss; c:= cc; end;
      1: begin s:= cc; c:=-ss; end;
      2: begin s:=-ss; c:=-cc; end;
    else begin s:=-cc; c:= ss; end;
  end;
end;

function Jv_series(v,x: extended): extended;
  {-Power series for Bessel J_v(x), 0 <= v < MAXGAMX-1, |x|<1 or v > x^2/4}
var
  f,s,t: extended;
  n: integer;
begin
  f := 0.5*x;
  t := power_fa(f,v)/sfc_gamma(v+1.0);
  f := -f*f;
  s := t;
  n := 0;
  repeat
    inc(n);
    t := t*f/n/(v+n);
    s := s + t;
  until abs(t) <= 0.5*eps_x*abs(s);
  Jv_series := s;
end;


function Yv_series(v,x: extended): extended;
  {-Series for Yv for 'small' x < 1;  frac(v)<>0}
var
  h,k,v1,v2,t1,t2,xx,Yv: extended;
const
  hsmall: THexExtW = ($4153,$E4E4,$9836,$0A2F,$0000); {2.675476672E-4933 = ~ 1/(MaxExtended*Pi)}
begin

  {Use Yv(x) = ( Jv(v,x)cos(vx) - Jv(-v,x) )/sin(vx) }
  {and Gamma reflection to sum the two series for Jv }

  if v<MAXGAMX then h := power_fa(0.5*x, v)/sfc_gamma(v)
  else h := exp_fa(v*ln(0.5*x) - sfc_lngamma(v));

  if h <= extended(hsmall) then begin
    {1.0/(h*Pi) will overflow}
    Yv_series := NegInf_x;
    exit;
  end;

 // sincosPi_x(v, v1, v2);
  sincosPi_fa(v,v1,v2);  {.335}
  t2 := 1.0/(h*Pi);
  t1 := h*(v2/(v*v1));

  Yv := t1-t2;
  xx := 0.25*x*x;
  v2 := v;
  v1 := v;
  k  := 0.0;
  repeat
    k  := k + 1.0;
    v1 := v1 + 1.0;
    v2 := v2 - 1.0;
    t1 := -t1*xx/(k*v1);
    t2 :=  t2*xx/(k*v2);
    h  := t1 - t2;
    Yv := Yv + h;
  until (abs(h)<eps_x*abs(Yv));
  Yv_series := Yv;
end;

 (*
{$ifdef CONST}
function CSEval_X(x: extended; const a: array of extended; n: integer): extended;
  {-Evaluate Chebyshev sum a[0]/2 + a[1]*T_1(x) +..+ a[n-1]*T_(n-1)(x) using Clenshaw algorithm}
{$else}
function CSEval_X(x: extended; var va{:array of extended}; n: integer): extended;
var
  a: TExtVector absolute va;
{$endif}
*)
function CSEval_X(x: extended; const a: array of extended; n: integer): extended;
var
  b0,b1,b2: extended;
  i: integer;
begin
  {$ifdef CONST}
    {$ifdef debug}
    {.227}
      {
      if n>high(a)+1 then begin
        writeln('CSEvalX:  n > high(a)+1, n = ',n, ' vs. ', high(a)+1);
        readln;
      end;
      }
    {$endif}
    if n>high(a)+1 then n := high(a)+1;
  {$endif}
  b2 := 0.0;
  b1 := 0.0;
  b0 := 0.0;
  x  := 2.0*x;
  for i:=n-1 downto 0 do begin
    b2 := b1;
    b1 := b0;
    b0 := x*b1 - b2 + a[i];
  end;
  CSEval_X := 0.5*(b0-b2);
end;




procedure CF1_j(v,x: extended; var fv: extended; var s: integer);
  {-Return J_(v+1)(x) / J_v(x), efficient only if |x| <= |v|}
var
  c,d,f,b,t,tiny,tol: extended;
  k: longint;

const
  MAXIT = longint(32000)*100;  {see note below}

begin
  s := 1;

  {Evaluate HMF [1], 9.1.73 using modified Lentz's method. s keeps track }
  {of sign changes in the denominator. Ref: NR [13] (6.7.2) and p. 244,  }
  {function bessjy and Boost [19] file bessel_jy.hpp, function CF1_jy.   }

  {Note that CF1_j needs about O(|x|) iterations if |x| > |v|. But unless}
  {there is a better implementation below the asymptotic range,  CF1_j is}
  {is used in the last resort branch of bessel_jy. If a better algorithm }
  {(like Olver/Temme uniform Airy type asymptotic expansion) is available}
  {the factor 100 in the MAXIT declaration should be removed.}

  tol  := 2.0*eps_x;
  tiny := Sqrt_MinExt;
  c := tiny;
  f := tiny;
  d := 0.0;
  for k:=1 to MAXIT do begin
    b := 2.0*(v + k)/x;
    c := b - 1.0/c;
    d := b - d;
    if c=0.0 then c := tiny;
    if d=0.0 then d := tiny;
    d := 1.0/d;
    t := c * d;
    f := f*t;
    if d<0 then s := -s;
    if abs(t-1.0) < tol then begin
      fv := -f;
      exit;
    end;
  end;
  {No convergence}
  if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));
  fv := -f;
end;






procedure temme_y(v,x: extended; var Y,Y1: extended);
  {-Calculate Y(v, x) and Y(v+1, x) by Temme's method for small |x|}
var
  k,g,h,p,q,f,c,d,s,s1,tol,a,e: extended;
  g1,g2,gp,gm,v2: extended;
const
  MAXIT = 30000;
begin

{$ifdef debug}
 {.227}
{
  if (abs(v) > 0.5) or (abs(x) > 2) then begin
    if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
  end;
  }
{$endif}

  {N.M.Temme [51], On the Numerical Evaluation of the Ordinary}
  {Bessel Function of the Second Kind, Section 2.}
  gp := sfc_gamma1pm1(v);
  gm := sfc_gamma1pm1(-v);
  a  := ln(0.5*x);
  s  := -a*v;

  if abs(v) < eps_x then begin
    e := 0.5*v*sqr(Pi);
    d := 1.0/Pi;
  end
  else begin
    //e := 2.0*sqr(sinpi(0.5*v))/v;
    e := 2.0*sqr( sinPi_fa(0.5*v))/v; {.335}
    //d := v/sinpi(v);
    d := v/sinPi_fa(v);           {.335}
  end;

  if v=0.0 then g1 := -EulerGamma
  else g1 := 0.5*(gp-gm)/((1.0+gp)*(1.0+gm)*v);
  g2 := 0.5*(2.0+gp+gm)/((1.0+gp)*(1.0+gm));

  if abs(s) <= eps_x then f := 1.0 else f := sinh_fa(s)/s;
  f := 2.0*(g1*cosh_fa(s) - g2*a*f)*d;

  c := power_fa(0.5*x, v);
  p := d/(c*(1.0 + gm));
  q := d*c/(1.0 + gp);

  g := f + e*q;
  c := 1.0;
  s := c*g;
  s1:= c*p;

  v2 := v*v;
  d  := -0.25*x*x;

  {series summation}
  tol := 0.5*eps_x;
  {use extended k because otherwise k*k may overflow}
  k := 1.0;
  while k <= MAXIT do begin
    c := c*d/k;
    f := (k*f + p + q) / (k*k - v2);
    p := p/(k - v);
    q := q/(k + v);
    g := f + e*q;
    h := p - k*g;
    s := s  + c*g;
    s1:= s1 + c*h;
    if abs(c*g) < abs(s)*tol then begin
      Y  := -s;
      Y1 := -2.0*s1/x;
      exit;
    end;
    k := k + 1.0;
  end;
  {No convergence}
  if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));
  Y  := -s;
  Y1 := -2.0*s1/x;
end;


procedure CF2_jy(v,x: extended; var p,q: extended);
  {-Return the continued fraction p + i*q = (J' + iY') / (J + iY)}
var
  a,br,bi,cr,ci,dr,di,er,ei,fr,fi,t: extended;
  i: integer;
const
  MAXIT = 30000;
begin
  {Ref: Numerical Recipes [13], ch. 6.7, p.244, function bessjy}
  {Evaluate the continued fraction p + iq = (J' + iY') / (J + iY)}
  {NR [13] (6.7.3) using the (complex) modified Lentz's method.}

{$ifdef debug}
 {.227}
{
  if abs(x) < 1.0 then begin
    if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
  end;
  }
{$endif}

  t  := 1.0/x;
  a  := 0.25-v*v;
  fr := -0.5*t;
  fi := 1.0;
  br := 2.0*x;
  bi := 2.0;
  t  := a*t/(fr*fr+fi*fi);
  cr := br+t*fi;
  ci := bi+t*fr;
  t  := br*br+bi*bi;
  dr := +br/t;
  di := -bi/t;
  er := cr*dr-ci*di;
  ei := cr*di+ci*dr;
  t  := fr*er-fi*ei;
  fi := fr*ei+fi*er;
  fr := t;
  for i:=1 to MAXIT do begin
    a  := a + 2.0*i;
    bi := bi + 2.0;
    dr := a*dr+br;
    di := a*di+bi;
    if abs(dr)+abs(di) = 0.0 then dr := Sqrt_MinExt;
    t  := a/(cr*cr+ci*ci);
    cr := br+t*cr;
    ci := bi-t*ci;
    if abs(cr)+abs(ci) = 0.0 then cr := Sqrt_MinExt;
    t  := dr*dr+di*di;
    dr := +dr/t;
    di := -di/t;
    er := cr*dr-ci*di;
    ei := cr*di+ci*dr;
    t  := fr*er-fi*ei;
    fi := fr*ei+fi*er;
    fr := t;
    if abs(er-1.0)+abs(ei) < 8*eps_x then begin
      p := fr;
      q := fi;
      exit;
    end;
  end;
  {No convergence}
  if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));
  p := fr;
  q := fi;
end;



procedure bessel_jy(v,x: extended; BT: byte; var Jv,Yv: extended);
  {-Return J_v(x) and/or Y_v(x) depending on BT, x>0, |v| < MaxLongint, INF if overflow}
var
  n,k: longint;
  u, Ju, Yv1, Yu, Yu1, fv, fu: extended;
  w, p, q, g, curr, prev, next, init, t, x2: extended;
  reflect: boolean;
  s: integer;
const
  lnepsh = -44.3614195558364998;  {ln(0.5*eps_x)}

  {--------------------------------------------}
  function rec_overflow(a,b: extended): boolean;
    {-Test if a*b overflows, if yes set Yv and Jv = PosInf_x}
  begin
    if (abs(a) > 1.0) and (abs(b) >= MaxExtended/abs(a)) then begin
      rec_overflow := true;
      Jv := PosInf_x;
      Yv := PosInf_x;
    end
    else rec_overflow := false;
  end;

begin

  {Ref: Boost [19] file bessel_jy.hpp, function bessel_jy}
  {and NR [13], Ch.6.7, section Ordinary Bessel Functions}

  {For x < 0 the functions Jv and Yv are in general complex; and Yv}
  {is singular for x=0. |v| < MaxLongint is assumed, so we can work}
  {with longint in the recurrence iterative, but these routines are}
  {are not suitable for large v values anyway.}

  reflect := v < 0.0;
  if reflect then begin
    v  := -v;
    BT := BT_J + BT_Y;   {J and Y needed for reflection formula}
  end;

  x2 := 0.5*x;
  n  := round(v);
  u  := v-n;
  w  := 2.0/(Pi*x); {Wronskian}

  if x<=2.0 then begin
    if v>MAXGAMX then begin
      Yv := PosInf_x;
      if reflect then Jv := PosInf_x else Jv := 0.0;
      exit;
    end
    else begin
      {Check very 'small' x and v case with (near) overflow for Yv}
      if (x<1.0) and (u<>0.0) and (lnepsh > v*ln(0.25*sqr(x)/v)) then begin
        if BT and BT_J <> 0 then Jv := Jv_series(v, x);
        if BT and BT_Y <> 0 then Yv := Yv_series(v, x);
      end
      else begin
        temme_y(u, x, Yu,Yu1);
        if n=0 then begin
          Yv  := Yu;
          Yv1 := Yu1;
        end
        else begin
          prev := Yu;
          curr := Yu1;
          {skip last next calculation if J is not needed: it}
          {overflows in some cases like bessel_yv(1755.45,2)}
          {bessel_jv(1755.45,2) will produce an overflow!   }
          for k:=1 to n-1 do begin
            {forward recurrence for Y}
            t := (u+k)/x2;
            if rec_overflow(t,curr) then exit;
            next := t*curr - prev;
            prev := curr;
            curr := next;
          end;
          Yv  := curr;
          if BT and BT_J = 0 then Yv1 := 0.0  {keep some compilers quiet!}
          else Yv1 := ((u+n)/x2)*curr - prev;
        end;
        if BT and BT_J <> 0 then begin
          CF1_j(v, x, fv, s);
          Jv := w/(Yv*fv - Yv1);   {Wronskian relation}
        end;
      end;
    end;
  end
  else begin
    {calculate the lower limit t=t(v) for asymptotic range}
    if BT=BT_Y then t:= 1552
    else begin
      t := maxx(3.0, v*v)*121.0;
      if BT and BT_Y <> 0 then t := maxx(t,1552);
    end;
    if x>t then begin
      {Use asymptotic expansion of Hankel function H1v(x)}
      if BT and BT_J <> 0 then Jv := bessj_large(v, x);
      if BT and BT_Y <> 0 then begin
        Yu  := bessy_large(u, x);
        Yu1 := bessy_large(u + 1, x);
      end;
    end
    else begin
      CF1_j(v, x, fv, s);
      {tiny initial value to prevent overflow}
      init := Sqrt_MinExt;
      curr := s*init;
      prev := fv*curr;
      for k:=n downto 1 do begin
        {backward recurrence for J}
        t := (u+k)/x2;
        if rec_overflow(t,curr) then exit;
        next := t*curr - prev;
        prev := curr;
        curr := next;
      end;
      CF2_jy(u, x, p, q);
      fu := prev/curr;
      t  := u/x - fu;   {t = J'/J}
      g  := (p-t)/q;
      Ju := sqrt(w/(q + g*(p-t)));
      if curr<0.0 then Ju := -Ju;
      Jv := s*Ju*(init/curr); {normalization}
      Yu := g*Ju;
      Yu1:= Yu*(u/x - p - q/g);
    end;
    if BT and BT_Y <> 0 then begin
      prev := Yu;
      curr := Yu1;
      if n=0 then Yv := prev
      else begin
        for k:=1 to n-1 do begin
          {forward recurrence for Y}
          t := (u+k)/x2;
          if rec_overflow(t,curr) then exit;
          next := t*curr - prev;
          prev := curr;
          curr := next;
        end;
        Yv := curr;
      end;
    end;
  end;

  if reflect then begin
    {For negative v use reflection formula NR [13], 6.7.19}
    {J(-v,x) = cos(Pi*v)*J(v,x) - sin(Pi*v)*Y(v,x)}
    {Y(-v,x) = sin(Pi*v)*J(v,x) + cos(Pi*v)*Y(v,x)}
    //sincosPi_x(v,p,q);
    sincosPi_fa(v,p,q);  {.335}
    t  := q*Jv - p*Yv;
    Yv := p*Jv + q*Yv;
    Jv := t;
  end;
end;




function sfc_jv(v, x: extended): extended;  stdcall;
  {-Return J_v(x), the Bessel function of the 1st kind, order v; not suitable for large v.}
var
  r,n: extended;
begin

//bjv(0.5,x)= sqrt(2/(pi*x))*sin(x)
//bjv(-0.5,x)=sqrt(2/(pi*x))*cos(x)


  if IsNaNorInf(x) or IsNaNorInf(v) then
  begin
    sfc_jv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;

  {.357}
  //if F_FastSpec = True then
  begin
    if v = 0.5 then begin sfc_jv := sqrt(2/(pi*x))*sin_fa(x); exit; end
      else
    if v = -0.5 then begin sfc_jv := sqrt(2/(pi*x))*cos_fa(x); exit; end;
  end;


  n := int(v);
  if x<0.0 then begin
    if n=v then begin
      r := sfc_jv(v, -x);
      if frac(0.5*v)<>0 then r := -r;
      sfc_jv := r;
    end
    else
    begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      sfc_jv := NaN_x;
      GenerateFPUException(FPUErrorNAN);{.375}
    end;
  end
  else if x=0.0 then begin
    if v=0.0 then sfc_jv := 1.0
    else if v>0.0 then sfc_jv := 0.0
    else
    begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      sfc_jv := NaN_x;
      GenerateFPUException(FPUErrorNAN);{.375}
    end;
  end
  else begin
    {here x > 0}
    if n=v then begin
      {integer order}
      if abs(n)<200.0 then begin
        if x > maxx(3.0, v*v)*121.0 then begin
          r := bessj_large(abs(v),x);
          if frac(0.5*v)<0.0 then r := -r;
          sfc_jv := r;
        end
        else sfc_jv := sfc_jn(round(n),x);
        exit;
      end;
    end;
    {Here v no integer or |v| > 200}
    if ((v >= 0.0) and (v<MAXGAMX-1)) and ((x < 1.0) or (v > 0.25*x*x)) then begin
      sfc_jv := Jv_series(v, x);
    end
    else begin
      bessel_jy(v,x,BT_J,r,n);
      sfc_jv := r;
    end;
  end;
end;




function sfc_sph_jn(n: integer; x: extended): extended; stdcall;
  {-Return j_n(x), the spherical Bessel function of the 1st kind, order n}
label accf;


   // sin(x)/x
   function sbj0(x: extended): extended; assembler;
   asm
     fld     tbyte ptr [x]
     fld     st(0)
     fsin
     fdivrp
   end;

   //(sin(x)-x*cos(x))/x^2
   function sbj1(x: extended): extended; assembler;
   asm
     fld     tbyte ptr [x]
     fld     st(0)
     fsincos
     fxch    st(2)
     fmul    st(2), st(0)
     fmul    st(0), st(0)
     fxch    st(2)
     fsubp
     fdivrp
   end;


   //((3-x^2)*sin(x)-3*x*cos(x))/x^3
   function sbj2(x: extended): extended; assembler;
   const c3:double = 3.0;
   asm
     fld     tbyte ptr [x]
     fld     st(0)
     fsincos
     fxch    st(2)
     fmul    st(2), st(0)
     fld     st(0)
     fmul    st(0), st(0)
     fmul    st(1),st(0)
     fsubr   c3
     fmulp   st(2),st(0)
     fxch    st(2)
     fmul    c3
     fsubp
     fdivrp
   end;


var
  r,z: extended;
begin

  if IsNaNorInf(x) then
  begin
    sfc_sph_jn := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;


  if F_FastSpec = True then     {.357}
  begin

    if n = 0 then sfc_sph_jn:=sbj0(x)
    else
    if n = 1 then sfc_sph_jn:=sbj1(x)
    else
    if n = 2 then sfc_sph_jn:=sbj2(x)
    else
    goto accf;

  end
  else
  begin
    accf:
    if n=0 then sfc_sph_jn := sinc_fa(x)
    else
    if x=0.0 then sfc_sph_jn := 0.0
    else
    begin
      z := abs(x);
      r := sqrt(Pi_2/z)*sfc_jv(0.5+n,z);
      if (x<0.0) and odd(n) then r := -r;    {NIST 10.47.14}
      sfc_sph_jn := r;
    end;
  end;

end;



function sfc_sph_yn(n: integer; x: extended): extended;
  {-Return y_n(x), the spherical Bessel function of the 2nd kind, order n >=0 , x<>0}
  label accf;


   // -cos(x)/x
   function sby0(x: extended): extended; assembler;
   asm
     fld     tbyte ptr [x]
     fld     st(0)
     fcos
     fdivrp
     fchs
   end;

    //-(cos(x)+x*sin(x))/x^2
   function sby1(x: extended): extended; assembler;
   asm
     fld     tbyte ptr [x]
     fld     st(0)
     fsincos
     fxch    st(2)
     fmul    st(1), st(0)
     fmul    st(0), st(0)
     fxch    st(2)
     faddp
     fdivrp
     fchs
   end;


   //((x^2-3)*cos(x)-3*x*sin(x))/x^3
   function sby2(x: extended): extended; assembler;
   const c3:double = 3.0;
   asm
     fld     tbyte ptr [x]
     fld     st(0)
     fsincos
     fxch    st(2)
     fmul    st(1), st(0)
     fld     st(0)
     fmul    st(0), st(0)
     fmul    st(1),st(0)
     fsub    c3
     fmulp   st(3),st(0)
     fxch    st(1)
     fmul    c3
     fsubp   ST(2),ST(0)
     fdivp
   end;

var
  r,z: extended;
begin

  if IsNaNorInf(x) then
  begin
    sfc_sph_yn := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;


  if F_FastSpec = True then     {.357}
  begin
    if n = 0 then sfc_sph_yn:=sby0(x)
    else
    if n = 1 then sfc_sph_yn:=sby1(x)
    else
    if n = 2 then sfc_sph_yn:=sby2(x)
    else
    goto accf;
  end
  else
  begin
    accf:

    z := abs(x);
    if x=0.0 then r := NegInf_x
    else r := sqrt(Pi_2/z)*sfc_yv(0.5+n,z);
    if (x<0.0) and odd(n+1) then r := -r;      {NIST 10.47.14}
    sfc_sph_yn := r;

  end;

end;




function sfc_yv(v, x: extended): extended;
  {-Return Y_v(x), the Bessel function of the 2nd kind, order v; x > 0; not suitable for large v.}
var
  r,n: extended;
begin

  if IsNaNorInf(x) or IsNaNorInf(v) or (x<=0.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_yv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;

  r := abs(v);
  if r=0.5 then begin
    r := sqrt(Pi_2*x);
    if v<0.0 then sfc_yv := sin_fa(x)/r // sin(x)/r  {.335}
    else sfc_yv := -cos_fa(x)/r; //-cos(x)/r;  {.335}
  end
  else if frac(v) = -0.5 then begin
    {Reflection would be used but cos(Pi*v)=0: Y(v,x) = sin(Pi*v)*J(-v,x)}
    n := sfc_jv(-v,x);
    if frac(0.5*(r-0.5))=0.0 then sfc_yv := n else sfc_yv := -n;
  end
  else begin
    n := int(v);
    if n=v then begin
      {integer order}
      if (x>1552.0) and (x>5.0*abs(v)) then begin
        r := bessy_large(abs(v),x);
        if frac(0.5*v)<0.0 then r := -r;
        sfc_yv := r;
      end
      else if abs(n)<2000 then begin
        sfc_yv := sfc_yn(round(n),x);
      end
      else begin
        {Call general routine but avoid Jv calculation for v<0}
        bessel_jy(abs(v),x,BT_Y,n,r);
        if frac(0.5*v)<0.0 then r := -r;
        sfc_yv := r;
      end;
      exit;
    end
    else begin
      bessel_jy(v,x,BT_Y,n,r);
      sfc_yv := r;
    end;
  end;
end;




{-------------------------------------------------------------------------------}

{----------------GAMMA(complex)-----------------------------}


procedure sfc_gammaCx(const z: complex);   stdcall;
var
wx,wy: extended;
w: complex;
 rez: boolean;
begin
  {asm
    fstp qword ptr [z.re]
    fstp qword ptr [z.im]
  end;  }

  rez := z.im=0.0;
  clngamma(z,w);
  cexp_fa(w,w);
  if rez then w.im := 0.0;

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;


procedure Z_GAMMA;
var
wx,wy: extended;
w,z: complex;
 rez: boolean;
begin
  asm
    fstp tbyte ptr [z.re]
    fstp tbyte ptr [z.im]
  end;

  rez := z.im=0.0;
  clngamma(z,w);
  cexp_fa(w,w);
  if rez then w.im := 0.0;

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



procedure Z_ZETA;
var
wx,wy: extended;
w,z: complex;
 rez: boolean;
begin
  asm
    fstp tbyte ptr [z.re]
    fstp tbyte ptr [z.im]
  end;

 czeta(z,w);

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;




(*
procedure cgamma(const z: complex; var wx,wy: extended);  stdcall;
  {-Return the complex Gamma function w = Gamma(z)}
var
  rez: boolean;
  w: complex;
begin
  rez := z.im=0.0;
  clngamma(z,w);
  cexp(w,w);
  if rez then w.im := 0.0;

  wy:=w.im;
  wx:=w.re;
end;
*)

{---------------------------------------------------------------------------}
procedure cgamma(const z: complex; var w: complex);
  {-Return the complex Gamma function w = Gamma(z)}
var
  rez: boolean;
begin
  rez := z.im=0.0;
  clngamma(z,w);
  cexp_fa(w,w);
  if rez then w.im := 0.0;
end;




procedure clngamma(const z: complex; var w: complex);
  {-Return w = lnGamma(z), the principal branch of the log-Gamma function}
var
  t: complex;
  afix,s,c,y,sh,ch: extended;
  si: integer;
begin
  {Note that lnGamma(z) is normally <> ln(Gamma(z)), real parts are }
  {equal but Im(Ln(Gamma(z)) is in [-Pi, Pi]. This function contains}
  {some guesswork about the multiples of 2*Pi which are to be added }
  {to w.im if z.re < 0, the reference was Maple's lnGAMMA function. }
  y := abs(z.im);
  if (y <= 0.75) and (abs(z.re-1)<=1.25) then begin
    {Use power series if z near pole at 0 or zeroes at 1,2}
    {Near the zeroes Lanczos gives only absolute accuracy }
    if abs(z.re-1) <= 0.25 then begin
      {Code for z near 1}
      w.re := z.re - 1.0;
      w.im := z.im;
      clngam1z(w,w);
      exit;
    end;
    if abs(z.re) <= 0.25 then begin
      {Code for z near 0: lnGamma(z) = lnGamma(z+1) - ln(z)}
      {ln(z)}
      cln_fa(z,t);
      w.re := z.re;
      w.im := z.im;
      {lnGamma(z+1)}
      clngam1z(w,w);
      w.re := w.re - t.re;
      w.im := w.im - t.im;
      exit;
    end;
    if abs(z.re-2.0) <= 0.25 then begin
      {Code for z near 2: lnGamma(z) = ln(z-1) + lnGamma(z-1)}
      {ln(z-1)}
      t.re := z.re - 1.0;
      t.im := z.im;
      cln_fa(t,t);
      {compute lnGamma(z-1) with z-1 near 1}
      w.re := z.re - 2.0;
      w.im := z.im;
      clngam1z(w,w);
      w.re := w.re + t.re;
      w.im := w.im + t.im;
      exit;
    end;
  end;

  if z.re > 1.0 then begin
    {Here Lanczos seems OK, for z.re=1 sometimes w.im is off by 2*Pi}
    clngam_lanczos(z,w);
  end
  else if z.re >= 0.0 then begin
    {Use recursive call lnGamma(z) = lnGamma(z+1) - ln(z) to make z.re > 1}
    t.re := z.re + 1.0;
    t.im := z.im;
    cln_fa(z,t);
    w.re := z.re + 1.0;
    w.im := z.im;
    clngamma(w,w);
    w.re := w.re - t.re;
    w.im := w.im - t.im;
  end
  else begin
    {Use reflection formula HMF[1], 6.1.17: Gamma(z)Gamma(1-z)=Pi/sin(Pi*z}
    {and conjugation [1], 6.1.23: ln(Gamma(z)) = conj(ln(Gamma(conj(z))). }
    {Note: The real case could be simplified by using sfGamma, but then a }
    {large overhead from other special functions units would be included. }
    if y=0.0 then begin
      {Real case for z.re < 0}
      t.re := -z.re;
      t.im := 0.0;
      clngamma(t,t);
     // s := z.re*sinPi(z.re);
      s := z.re*sinPi_fa(z.re);  {.335}
      w.re := ln(abs(Pi/s)) - t.re;
      w.im := floorx(z.re)*Pi;
    end
    else begin
      si := isign(z.im);
      {t := lngam(1-z)}
      t.re := 1.0 - z.re;
      t.im := -y;
      clngam_lanczos(t,t);
      {This is the 'magic' arg fix to make w.im compatible to Maple and}
      {Wolfram Alpha, see http://functions.wolfram.com/06.11.16.0002.01}
      afix := floorx(0.5*(z.re+0.5))*TwoPi;
      {w := ln(sin(Pi*z))}
      //sincosPi_x(z.re,s,c);
      sincosPi_fa(z.re,s,c);  {.335}
      if y >= 8.0 then begin
        {Here sinh(Pi*y)^2 > 1/eps_x, tanh(Pi*y) = 1}
        {HMF[1], 4.3.59: w.re ~ ln(sinh(y*Pi) = y*Pi - ln(2)}
        w.re := y*Pi - ln2;
        {HMF[1], 4.3.60: w.im ~ arctan(cot(z.re*Pi)tanh(Pi*y)), so}
        {w.im = arctan(cot(z.re*Pi)) = arctan(c/s) = arctan2(c,s).}
        w.im := arctan2_fa(c,s);
      end
      else begin
        {Use full formulas from HMF[1] 4.3.59/60. An option would be:}
        {coshsinhmult(y*Pi, s,c, w.re,w.im); cln(w,w);}
        sinhcosh_fa(y*Pi,sh,ch);
        w.re := ln(hypot_fa(s,sh));
        w.im := arctan2_fa(c*sh, s*ch);
      end;
      w.re :=  LnPi - w.re - t.re;
      w.im := (afix - w.im - t.im)*si;
    end;
  end;
end;


procedure sfc_lngammaCx(const z: complex);   stdcall;
var
wx,wy: extended;
w: complex;
 rez: boolean;
begin
  {asm
    fstp qword ptr [z.re]
    fstp qword ptr [z.im]
  end;  }

  rez := z.im=0.0;
  clngamma(z,w);
  //cexp(w,w);
  if rez then w.im := 0.0;

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



procedure sfc_psiCx(const z: complex);    stdcall;
var
 w: complex;
begin

  cpsi(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;

end;




procedure sfc_zetaCx(z: complex);    stdcall;
var
 w: complex;
begin

  czeta(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;

end;



{
procedure cerf(const z: complex; var w: complex);
procedure cerfc(const z: complex; var w: complex);
}




procedure czeta(const s: complex; var w: complex);
  {-Return the complex Riemann Zeta function, w=Zeta(s), s <> 1}
var
  x: extended;
begin
  x := s.re;
  if s.im=0.0 then begin
    if x=0.0 then begin
      w.re := -0.5;
      w.im := 0.0;
      exit;
    end
    else if x=1 then begin
      w.re := NaN;
      w.im := NaN;
      exit;
    end
    else if (x<0.0) and (frac(0.5*x)=0.0) then begin
      {s.re = -2n}
      w.re := 0.0;
      w.im := 0.0;
      exit;
    end;
  end;
  if x >= 0.375 then begin
    czeta_pos(s,w);
  end
  else begin
    czeta_neg(s,w);
  end;
end;



procedure czeta_neg(const s: complex; var w: complex);
  {-Return the Riemann Zeta function, w=Zeta(s), s.re < 0.5}
var
  a,t,u: complex;
const
  smin = 0.6e-3;  {double = 2e-3}
  TCA: array[0..5] of extended = (
         -0.500000000000000000000000000000,
         -0.918938533204672741780329736405,
         -1.00317822795429242560505001337,
         -1.00078519447704240796017680223,
         -0.999879299500571164957800813655,
         -1.00000194089632045603779988198);
begin
  if cabs_fa(s) < smin then begin
    {Maclaurin series}
    cpolyr_f(s, TCA, 6, w);
  end
  else begin
    {Zeta(s) = 2^s*Pi^(s-1)*sin(Pi/2*s)*gamma(1-s)*zeta(1-s);}
    u.re := 1.0-s.re;
    u.im := -s.im;
    cexp2(s,a);
    t.re := lnPi*u.re;
    t.im := lnPi*u.im;
    cexp_fa(t,t);
    cdiv_fa(a,t,a);
    t.re := 0.5 * s.re;
    t.im := 0.5 * s.im;
    csinpi(t,t);

    cmul_f(a,t,a);
    cgamma(u,t);
    cmul_f(a,t,a);
    czeta_pos(u,t);
    cmul_f(a,t,w);
  end;
end;




procedure czeta_pos(const s: complex; var w: complex);
  {-Return w=Zeta(s), s.re >= 0}
var
  a,c,z,zn,t,u: complex;
  k,n,m: longint;
  x,y,eps: extended;
begin

  {estimate initial n}
  if s.re >= 1.0 then begin
    x := 10 + 0.25*abs(s.im)/s.re;
    if x>100 then n := 100
    else n := round(x);
  end
  else n := 32;

  {Ref: A. Banuelos, R.A. Depine [81]}
  m := 2;
  eps := 2*eps_x;
  c := c_1;
  zn := c;
  repeat
    {zn = sum(k^(-s), k=1..N-1}
    for k:=m to n do begin
      x := ln1p(-1/k);
      t.re := x*s.re;
      t.im := x*s.im;
      cexp_fa(t,t);
      cmul_f(c,t,c);
      cadd(zn,c,zn);
    end;
    n := n+1;
    x := ln(n);

    {N^(-s)/2}
    t.re := -x*s.re;
    t.im := -x*s.im;
    cexp_fa(t,t);
    z.re := zn.re + 0.5*t.re;
    z.im := zn.im + 0.5*t.im;

    {N^(1-s)/(s-1)}
    u.re := s.re - 1.0;
    u.im := s.im;
    t.re := -x*u.re;
    t.im := -x*u.im;
    cexp_fa(t,t);
    cdiv_fa(t,u,u);
    cadd(z,u,z);

    {0.5*s*B_1/N^(s+1)}
    t.re := x*(s.re+1);
    t.im := x*s.im;
    cexp_fa(t,t);
    cdiv_fa(s,t,a);
    x := 0.5*Bern2n[1];
    a.re := x*a.re;
    a.im := x*a.im;
    cadd(z,a,z);

    y := sqr(int(n));
    for k:=1 to 30 do begin
      t.re := s.re + 2*k;
      t.im := s.im;
      u.re := t.re - 1.0;
      u.im := t.im;
      cmul_f(u,t,t);
      x := Bern2n[k+1]/Bern2n[k]/(2*k+2)/(2*k+1)/y;
      t.re := x*t.re;
      t.im := x*t.im;
      cmul_f(a,t,a);
      cadd(z,a,z);
      x := hypot_fa(s.re + 2*k+1, s.im)*cabs_fa(a);
      if x < eps then begin
        w := z;
        {writeln('n=',n);}
        exit;
      end;
    end;
    m := n;
    n := n+64;
  until false;
end;






function cabs_acc(const z: complex): extended;
  {-Return the complex absolute value |z| = sqrt(z.re^2 + z.im^2)}
begin
  cabs_acc := hypot_acc(z.re, z.im);
end;



function cabs_fa(const z: complex): extended;
  {-Return the complex absolute value |z| = sqrt(z.re^2 + z.im^2)}
begin
  if F_FastSpec = True then  cabs_fa:=sqrt(sqr(z.re) + sqr(z.im)) else cabs_fa:=hypot_acc(z.re, z.im)
end;





procedure cexp2(const z: complex; var w: complex);
  {-Return w = 2^z = exp(z*ln(2))}
var
  r: extended;
begin
  r := exp2(z.re);
  //sincos(z.im*ln2, w.im, w.re);
  sincos_fa(z.im*ln2, w.im, w.re); {.335}
  w.re := r*w.re;
  w.im := r*w.im;
end;




procedure csinpi(const z: complex; var w: complex);
  {-Return the complex circular sine w = sin(Pi*z)}
var
  c,s: extended;
begin
  {HMF[1], 4.3.55: sin(x + iy) = sin(x)*cosh(y) + i*cos(x)*sinh(y)}
  //sincospi(z.re, s,c);
  sincosPi_fa(z.re, s,c);  {.335}
  coshsinhmult_fa(z.im*Pi, s, c, w.re, w.im);
end;




procedure coshsinhmult_acc(y,a,b: extended; var u,v: extended);
  {-Return u = a*cosh(y), v = b*sinh(y) with |a|,|b| <= 1}
var
  t: extended;
begin
  {u = a*cosh(y), v = b*sinh(y)}
  if abs(y)<=ln_MaxExt then begin
    if y=0.0 then begin
      u := a;
      v := 0.0;
    end
    else begin
      {v=sinh(y), u=cosh(y)}
      sinhcosh_acc(y,v,u);
      u := a*u;
      v := b*v;
    end;
  end
  else begin
    {extreme case: exp(|y|) will overflow}
    t := abs(y);
    if a=0.0 then u := 0.0
    else begin
      {compute a*cosh(y)}
      u := t + ln(abs(a)) - ln2;
      if u<=ln_MaxExt then u := exp_acc(u) {.335}
      else u := PosInf_x;
      if a<0.0 then u := -u;
    end;
    if b=0.0 then v := 0.0
    else begin
      {compute b*sinh(y)}
      v := t + ln(abs(b)) - ln2;
      if v<=ln_MaxExt then v := exp_acc(v) {.335}
      else v := PosInf_x;
      if (b<0.0) <> (y<0.0) then v := -v;
    end;
  end;
end;




procedure coshsinhmult_fa(y,a,b: extended; var u,v: extended);
  {Return u = a*cosh(y), v = b*sinh(y) with |a|,|b| <= 1}
var
 t: extended;
begin
  if F_FastSpec = True then
  begin
     t:=Exp_f(y);
     u:=a*(t+1/t)*0.5;
     v:=b*(t-1/t)*0.5;
  end
  else
  begin
     coshsinhmult_acc(y,a,b,u,v);
  end;

end;




procedure cpsi(const z: complex; var w: complex);
  {-Return the complex digamma function w = psi(z), z <> 0,-1,-2...}
const
  NB = 7;                       {Bernoulli(2(k+1))/(2(k+1)), k=0..NB}
  B: array[0..NB] of extended = (1.0/12.0,  -1.0/120.0,     1.0/252.0, -1.0/240.0,
                                 1.0/132.0, -691.0/32760.0, 1.0/12.0,  -3617/8160);
var
  u,v,x: complex;
  a: extended;
const
  x0 = 13.0;    {double = 12.0}
begin
  if z.re < 0.0 then begin
    {HMF [1], 6.3.7: psi(z) = psi(1-z) - Pi*cot(Pi*z)}
    x.re := 1.0-z.re;
    x.im := -z.im;
    cpsi(x,u);
    {compute v = Pi*cot(Pi*z)}
    if z.im=0.0 then begin
      //sincosPi(x.re,v.re,v.im);
      sincosPi_fa(x.re,v.re,v.im); {.335}
      {cot(x) = cos(x)/sin(x), will crash if frac(x)=0!}
      v.re := Pi*v.im/v.re;
      v.im := 0.0;
    end
    else if frac(z.re)=0.0 then begin
      {cot((-m + y*I)*Pi)= -I*coth(Pi*y))}
      v.re := 0.0;
      v.im := -Pi*coth_fa(Pi*z.im);
    end
    else begin
      {Because cot has period Pi, use only the fractional part of z.re.  }
      {Note: There can be a large relative error, if z.re is not exactly }
      {representable as float, e.g. if z.re = -10 - 1e-8 then frac(z.re) }
      { = -9.99999999994061195E-9 with a relative error of 5.938805E-12! }
      {And then v.im, w.im will have relative errors of the same order.  }
      a := frac(z.re);
      {a < 0: if abs(a) > 0.5 take the next multiple of Pi. Note that }
      {a+1 generates no additional error according to Sterbenz' lemma.}
      if a < -0.5 then a := a + 1.0;
      x.re := Pi*a;
      x.im := Pi*z.im;
      ccot_fa(x,v);
      v.re := Pi*v.re;
      v.im := Pi*v.im;
    end;
    w.re := u.re - v.re;
    w.im := u.im - v.im;
    exit;
  end;

  {This next code is analogous to the real digamma sfc_psi:}
  {Step 1: Make Re(x) >= x0 using HMF [1], 6.3.5}
  x.re := z.re;
  x.im := z.im;
  w.re := 0.0;
  w.im := 0.0;
  while x.re < x0 do begin
    cinv_fa(x,v);
    cadd(w,v,w);
    x.re := x.re + 1.0;
  end;

  {Step 2: If re(x) >= x0, use asymptotic expansion from HMF [1], 6.3.18}
  {v = -1/(2x) - sum(B_2k/(2k*x^2k)}
  a := maxx(abs(x.re), abs(x.im));
  if a >= 1e10 then begin
    {Avoid overflow on square and useless polynomial evaluation}
    rdivc_fa(-0.5, x, v);
  end
  else begin
    {TODO: optimize and use fewer terms depending on a?}
    csqr(x,u);
    cinv_fa(u,u);
    cpolyr_f(u,B,NB+1,v);
    cmul_f(v,u,v);
    rdivc_fa(-0.5, x, u);
    csub(u,v,v);
  end;

  {Step 3: psi(x) = ln(x) + v - w, with w from Step 1}
  cln_fa(x,u);
  cadd(u,v,u);
  csub(u,w,w);
end;




function sfc_polygamma(n: integer; x: extended): extended;
  {-Return the polygamma function: n'th derivative of psi; n>=0, x>0 for n>MAXGAMX}
  { Note: The accuracy may be reduced for n >= MAXGAMX due to ln/exp operations.}
var
  z,f,t: extended;
  k: integer;
const
  NPMAX = 2500; {Max. n > 1752 for calculation of n! as product}
begin
  if n<4 then begin
    case n of
        0: sfc_polygamma := sfc_psi(x);
        1: sfc_polygamma := sfc_trigamma(x);
        2: sfc_polygamma := sfc_tetragamma(x);
        3: sfc_polygamma := sfc_pentagamma(x);
      else begin
             {RTE or NAN if n < 0}
             {$ifopt R+}
               if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
             {$endif}
             sfc_polygamma := NaN_x;
             GenerateFPUException(FPUErrorNAN);{.375}
           end;
    end;
  end
  else if IsNanOrInf(x) then begin
    if x=PosInf_x then begin
      if n>0 then sfc_polygamma := 0.0
      else
      begin
       sfc_polygamma := PosInf_x ;
       //GenerateFPUException(FPUErrorINF);{.375}
      end;
    end
    else
    begin
     sfc_polygamma := NaN_x;
     GenerateFPUException(FPUErrorNAN);{.375}
    end;
  end
  else if x > 0.0 then begin
    {polygamma(n,x) = (-1)^(n+1)*n!*sum(1/(x+k)^(n+1), k>=0), HMF[1] 6.4.10}
    {or with the Hurwitz zeta:  polygamma(n,x) = (-1)^(n+1)*n!*zetah(n+1,x)}
    z := sfc_zetah(n+1,x);
    if z=0.0 then begin
      {If zetah=0, use HMF[1] 6.4.10 or the asymptotic formula 6.4.11}
      if x>0.25*n then z := polygam_ase(n,x)
      else z := polygam_sum(n,x)
    end
    else if n<MAXGAMX-1 then begin
      {n! is OK, but n!*zetah may overflow for small x}
      f := _factorial(n);//sfc_fac(n);
      t := ln(f)+ln(z);
      if t<ln_MaxExt then z := z*f
      else z := PosInf_x;
    end
    else begin
      f := sfc_lngamma(n+1);
      t := f + ln(z);
      if t > ln_MaxExt then z := PosInf_x
      else if t < ln_MinExt then z := 0.0
      else begin
        if n>NPMAX then z := exp_fa(t) {.335}
        else begin
          {example: sfc_polygamma(2001,32)}
          z := _factorial(1752)*z;//sfc_fac(1752)*z;
          for k:=1753 to n do z := z*k;
        end;
      end;
    end;
    if odd(n) then sfc_polygamma := z
    else sfc_polygamma := -z;
  end
  else if (x<0.0) and (n>MAXGAMX) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_polygamma := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
  end
  else begin
    {x<0 and n<=nmax}
    sfc_polygamma := polygam_negx(n,x);
  end;
end;




function polygam_negx(n: integer; x: extended): extended;
  {-Polygamma for finite negative x and 1 <= n <= MAXGAMX}
var
  n1,k: integer;
  z,s,t,a,b,d: extended;
const
  tmin = 13;   {should > 12}
  tmax = 70.0; {must by <= NXPGPMAX}
begin
  z  := frac(x);
  if (z=0.0) or (x>0.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    polygam_negx := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if n <= 12 then begin
    {Use hard-coded polynomials}
    polygam_negx := polygam_cotpoly(n,x);
    exit;
  end;

  n1 := n+1;
  if (z=-0.5) and odd(n1) then begin
    {cot term is zero for even n}
    s := 0.0;
  end
  else begin
    if z=-0.5 then begin
      t := tmin;
      z := 0.5;
    end
    else begin
      if z<-0.5 then z := z+1.0;
      {-0.5 < z < 0.5}
      t := -5.0*log2_f(0.5 - abs(z));
      if t<tmin then t := tmin
      else if t>tmax then t := tmax;
    end;
    if n < t then begin
      {presumed slow convergence, use polynomial}
      polygam_negx := polygam_cotpoly(n,x);
      exit;
    end;
    //s := power(z,-n1);
    s := IntPower_fa(z,-n1);
    k := 1;
    repeat
      {a := power(z+k,-n1);
      b := power(z-k,-n1); }
      a := IntPower_fa(z+k,-n1);
      b := IntPower_fa(z-k,-n1);
      d := a + b;
      s := s+d;
      inc(k);
    until abs(d)<=eps_x*abs(s);
    if odd(n) then s := -s;
  end;
  t := sfc_zetah(n1, 1.0-x);
  a := s+t;
  b := _factorial(n);//sfc_fac(n);
  if abs(a) <= MaxExtended/b then polygam_negx := -b*a
  else polygam_negx := copysign(PosInf_x, -a);
end;







function polygam_cotpoly(n: integer; x: extended): extended;
  {-Polygamma for negative x and 1 <= n <= NXPGPMAX}
type
  TCArray = array[-1..NXPGPMAX+2] of extended;
  PCArray = ^TCArray;
  { for i from 1 to 12 do sort(simplify(expand(diff(cot(x),x$i)))); od;
     -C^2 - 1             with C = cot(x)
     2*C^3 + 2*C
     -6*C^4 -8*C^2 - 2
     24*C^5 + 40*C^3 + 16*C
     -120*C^6 - 240*C^4 - 136*C^2 - 16
     720*C^7 + 1680*C^5 + 1232*C^3 + 272*C
     -5040*C^8 - 13440*C^6 - 12096*C^4 - 3968*C^2 - 272
     40320*C^9 + 120960*C^7 + 129024*C^5 + 56320*C^3 + 7936*C
     -362880*C^10 - 1209600*C^8 - 1491840*C^6 - 814080*C^4 - 176896*C^2 - 7936
     3628800*C^11 + 13305600*C^9 + 18627840*C^7 + 12207360*C^5 + 3610112*C^3 + 353792*C
     -39916800*C^12 - 159667200*C^10 - 250145280*C^8 - 191431680*C^6 - 71867136*C^4 - 11184128*C^2 - 353792
     479001600*C^13 + 2075673600*C^11 + 3597834240*C^9 + 3149752320*C^7 + 1436058624*C^5 + 309836800*C^3 + 22368256*C
  }
const
  ca: array[0..53] of single = ({Above coefficients reflected and positive,}
        { 1} 1,1,               {all are exactly representable as single!}
        { 2} 2,2,
        { 3} 2,8,6,
        { 4} 16,40,24,
        { 5} 16,136,240,120,
        { 6} 272,1232,1680,720,
        { 7} 272,3968,12096,13440,5040,
        { 8} 7936,56320,129024,120960,40320,
        { 9} 7936,176896,814080,1491840,1209600,362880,
        {10} 353792,3610112,12207360,18627840,13305600,3628800,
        {11} 353792,11184128,71867136,191431680,250145280,159667200,39916800,
        {12} 22368256,309836800,1436058624,3149752320.0,3597834240.0,2075673600,479001600);
  ko: array[1..12] of integer = (0,2,4,7,10,14,18,23,28,34,40,47); {index of first coeff for n}
var
  c,s,t: extended;
  i,k: integer;
  pa: PCArray;
  pa_f: array of extended;
  sa: word;


begin
 // sincosPi(x,s,c);
  sincosPi_fa(x,s,c);  {.335}
  if (n<1) or (n>NXPGPMAX) or (x>=0.0) or (s=0.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    polygam_cotpoly := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;

  {Reflection formula: HMF[1] (6.4.7) or  NIST[30], (5.15.6)}
  {psi(n,1-x) + (-1)^(n+1)*psi(n,x) = (-1)^n*Pi*d^n/dx^n(cot(Pi*x))}

  {psi(n,x) = - (-1)^(n+1)*psi(n,1-x) + (-1)^(n+n+1)*Pi*d^n/dx^n(cot(Pi*x))}
  {psi(n,x) = (-1)^n*psi(n,1-x) - Pi*d^n/dx^n(cot(Pi*x))}

  if (c=0.0) and (n and 1 = 0) then begin
    {early exit for cot=0: for even n cot recflection term -t*c below will be 0}
    polygam_cotpoly := sfc_polygamma(n,1.0-x);
    exit;
  end;

  {c = cot(Pi*x), s = cot(Pi*x)^2}
  c := c/s;
  s := c*c;

  {Compute polynomial in cot(Pi*x)^2 in t}
  if n<=12 then begin
    {use hard-coded coefficients}
    k := ko[n];
    t := 0.0;
    for i := (succ(n) div 2) downto 0 do t := t*s + ca[k+i];
  end
  else
  begin


    {
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      Changing for Foreval : alloc. memory for coeff pa[] now is in DynamicArray -> pa_f[]
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    }


    (*
    {Recursive computation using cot'(x) = -(1+cot^2(x)). As above the}
    {coefficient*(-1)^n are evaluated, the working array contains the }
    {interlaced coefficients for n-1 and n, indices -1...n+2 are used.}
    sa := (n+4)*sizeof(extended);
    {allocate and clear to zero}
    pa := calloc(sa);
    if pa=nil then begin
      {$ifopt R+}
        {Heap overflow error}
        RunError(203);
      {$endif}
      polygam_cotpoly := NaN_x;
      exit;
    end;
    {pa^[k] contains the positive coefficient for cot^k(x)}
    pa^[1] := 1.0;
    for i:=2 to n+1 do begin
      k := i and 1;
      while k <= i do begin
        pa^[k] := pa^[k-1]*(k-1) + pa^[k+1]*(k+1);
        inc(k,2);
      end;
    end;
    {Coefficients done, evaluate polynomial in cot(Pi*x)^2}
    t := pa^[n+1];
    i := n-1;
    repeat
      t := t*s + pa^[i];
      dec(i,2);
    until i<0;
    mfree(pa,sa);
    *)

    {
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      Changing for Foreval : alloc. memory for coeff pa[] now is in DynamicArray -> pa_f[]
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    }

    SetLength(pa_f,n+4+1);

    {pa[k] contains the positive coefficient for cot^k(x)}
    pa_f[1] := 1.0;
    for i:=2 to n+1 do begin
      k := i and 1;
      while k <= i do begin
        pa_f[k] := pa_f[k-1]*(k-1) + pa_f[k+1]*(k+1);
        inc(k,2);
      end;
    end;

    {Coefficients done, evaluate polynomial in cot(Pi*x)^2}
    t := pa_f[n+1];
    i := n-1;
    repeat
      t := t*s + pa_f[i];
      dec(i,2);
    until i<0;





  end;
  s := sfc_polygamma(n,1.0-x);
  if odd(n) then s := -s
  else begin
    {t is already correct for odd n, for even n multiply with -cot(Pi*x)}
    {the minus compensates the fact that the coefficients are positive. }
    t := -t*c;
  end;
  t := t*intpower_fa(Pi,n+1);
  polygam_cotpoly := s + t;
end;






function polygam_ase(n: integer; x: extended): extended;
  {-Polygamma asymptotic expansion}
var
  z,f,t,b: extended;
  k,j: integer;
const
  K2MAX =  120; {doubled maximum index in asymptotic sum}
  NPMAX = 2000; {Max. n for calculation of (n-1)!/x^n as product}
  TFMAX = 2.6E4913;  {~ 2*MaxExtended*eps_s, used for 'no-convergence' check}
begin
  f := sfc_lngamma(n);
  z := n*ln(x);
  t := f-z;
  if t > ln_MaxExt then z := PosInf_x
  else if t < ln_MinExt then z := 0.0
  else begin
    {calculate f = (n-1)!/x^n}
    if (abs(z)<11356.0) and (n<MAXGAMX-1) then begin
      f := _factorial(n-1)*IntPower_fa(x,-n); //f:=sfc_fac(n-1)*power(x,-n);
    end
    else begin
      if n <= NPMAX then begin
        {avoid exp/ln inaccuracies, example: sfc_polygamma(1800,980)}
        f := 1.0;
        for k:=1 to n-1 do f := f*k/x;
        f := f/x;
      end
      else f := exp_fa(t);
    end;
    {First two terms}
    z := f + 0.5*f*(n/x);
    {Add sum terms with Bernoulli numbers}
    k := 2;
    repeat
      j := k-1;
      t := (n+j)/k*(n+j-1)/j/x/x;
      b := sfc_bernoulli(k);
      if (k>K2MAX) or (abs(f) > abs(TFMAX/t/b)) then begin
        {Convergence failed if k too large or a summand ~> MaxExtended}
        {Try direct summation, complete failure if result is NaN}
        z := polygam_sum(n,x);
        {$ifopt R+}
          if (IsNaN(z)) and (RTE_NoConvergence>0) then RunError(byte(RTE_NoConvergence));
        {$endif}
        polygam_ase := z;
        exit;
      end;
      f := f*t;
      t := f*b;
      z := z + t;
      k := k+2;
    until abs(t)<abs(z)*eps_x;
  end;
  polygam_ase := z
end;




function polygam_sum(n: integer; x: extended): extended;
  {-Direct summation polygamma(n,x) = n!/x^(n+1)*(1 + sum(1/(1+k/x)^(n+1), k=1...))}
const
  KMAX = 200;
var
  s,t,e: extended;
  k,m: integer;
begin
  m := -(n+1);
  e := 0.125*eps_x;
  s := 0.0;
  k := 1;
  repeat
    //t := power(1.0+k/x, m);
    t := IntPower_fa(1.0+k/x, m);
    s := s + t;
    inc(k);
  until (t<=e) or (k>KMAX);
  if k>KMAX then
  begin
    {no convergence}
    polygam_sum := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
  end
  else begin
    t := sfc_lngamma(n+1) - (n+1)*ln(x);
    if t+ln1p(s) >= ln_MaxExt then polygam_sum := PosInf_x
    else polygam_sum := (1.0+s)*exp_fa(t); {.335}
  end;
end;




procedure cpolyr(const z: complex; const a: array of extended; n: integer; var w: complex);
  {-Evaluate polynomial; return a[0] + a[1]*z + ... + a[n-1]*z^(n-1)}
var
  uj,vj,r,s,t: extended;
  j: integer;
begin


  if n<=1 then begin
    w.im := 0.0;
    if n=1 then w.re := a[0]
    else w.re := 0.0;
    exit;
  end;
  {$ifdef debug}
   {
    if n>high(a)+1 then begin
      writeln('cpolyr:  n > high(a)+1, n = ',n, ' vs. ', high(a)+1);
      readln;
      if n>high(a)+1 then n := high(a)+1;
    end;
    }
  {$endif}

  {Use the procedure from  Knuth [32], 4.6.4 (3). This saves about}
  {2n multiplications and n additions compared to the old version.}
  uj := a[n-1];
  vj := a[n-2];
  if n>2 then begin
    r := 2.0*z.re;
    s := sqr(z.re) + sqr(z.im);
    for j:=n-3 downto 0 do begin
      t  := vj   + r*uj;
      vj := a[j] - s*uj;
      uj := t;
    end;
  end;
  w.re := z.re*uj + vj;
  w.im := z.im*uj;



end;



procedure cmul(const x,y: complex; var z: complex);
  {-Return the complex product z = x*y}
var
  t: extended;
begin
  t    := x.re*y.re - x.im*y.im;
  z.im := x.re*y.im + x.im*y.re;
  z.re := t;
end;



procedure cmul_f(x,y: complex; var z: complex); assembler;
//z1*z2; z1.RE-ST,z1.IM-ST(1),z2.RE-ST(2),z2.IM-ST(3);
asm
 fld  tbyte ptr [y.im]
 fld  tbyte ptr [y.re]
 fld  tbyte ptr [x.im]
 fld  tbyte ptr [x.re]
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
 fstp  tbyte ptr [z.re]
 fstp  tbyte ptr [z.im]
end;





procedure cdiv_f(x,y: complex; var z: complex);  assembler;
asm
      fld  tbyte ptr [y.im]
      fld  tbyte ptr [y.re]
      fld  tbyte ptr [x.im]
      fld  tbyte ptr [x.re]
      call Z_DIV_FAST
      fstp tbyte ptr [z.re]
      fstp tbyte ptr [z.im]
end;




procedure cdiv_fa(const x,y: complex; var z: complex);
begin
   if F_FastSpec = True then  cdiv_f(x,y,z) else cdiv_acc(x,y,z);
end;




procedure cdiv_acc(const x,y: complex; var z: complex);
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




procedure csqr(const z: complex; var w: complex);
  {-Return the square w = z^2}
var
  t: extended;
begin
  t := (z.re - z.im)*(z.re + z.im);
  w.im := 2.0*z.re*z.im;
  w.re := t;
end;




procedure csub(const x,y: complex; var z: complex);
  {-Return the complex difference z = x - y}
begin
  z.re := x.re - y.re;
  z.im := x.im - y.im;
end;


procedure cadd(const x,y: complex; var z: complex);
  {-Return the complex sum z = x + y}
begin
  z.re := x.re + y.re;
  z.im := x.im + y.im;
end;


procedure cinv_fa(const z: complex; var w: complex);
  {-Return the complex inverse w = 1/z}
begin
  rdivc_fa(1.0,z,w);
end;




{---------------------------------------------------------------------------}
procedure ccoth_acc(const z: complex; var w: complex);
  {-Return the complex hyperbolic cotangent w = coth(z)}
var
  x,y,c,s,t: extended;
const
  t0 = 23.0;
begin
  {HMF[1], 4.5.52: coth(x + iy) = (sinh(2x) - i*sin(2y))/(cosh(2x) - cos(2y))}
  x := z.re;
  y := z.im;
  t := abs(x);
  if y=0.0 then begin
    w.re := coth_acc(x);
    w.im := 0.0;
  end
  else if t=0.0 then begin
    w.re := 0.0;
    w.im := -cot_acc(y);
  end
  else if t >= t0 then begin
    w.re := isign(x);
    w.im := -2.0*sin_acc(2.0*y)*exp_acc(-2.0*t);
  end
  else begin
    x := 2.0*x;
    y := 2.0*y;
    if t<0.5 then begin
      {accurately compute cosh(2x) - cos(2y) for small x}
      {cosh(2x) = coshm1(2x)+1 and -cos(2y) = vers(2y)-1}
      t := coshm1_acc(x) + vers(y);
      {Note: theoretically  t > 0 because  cosh(2x) > 1, but}
      {underflow may occur, therefore multiply by 1/y or Inf}
      if abs(t) < MinExtended then t := PosInf_x else t := 1.0/t;
      w.re := sinh_acc(x)*t;
      w.im := -sin_acc(y)*t;
    end
    else begin
      sincos_acc(y,s,c);
      sinhcosh_acc(x,x,y);  {x=sinh(2x), y=cosh(2x)}     {.335}
      {here cosh >= 1.5 and t will be > 0.5}
      t := y - c;
      w.re :=  x/t;
      w.im := -s/t;
    end;
  end;
end;



procedure sinhcosh_acc(x: extended; var s,c: extended);
  {-Return s=sinh(x) and c=cosh(x)}
var
  t: extended;
const
  t0 = 23.0;     {ceil(-0.5*ln(2^-64)) = ceil(32*ln(2))}
begin
  t := abs(x);
  if t<=1.0 then begin
    s := sinh_small(x, false);
    c := 1.0 + coshm1_acc(x)
  end
  else begin
    if t<=t0 then begin
      {calculate inverse only if it is not too small}
      t := exp_acc(t);
      c := 1.0/t;
      s := 0.5*(t - c);
      c := 0.5*(t + c);
    end
    else if t<ln_MaxExt then begin
      {t>t0: exp(t) + exp(-t) ~ exp(t) - exp(-t) ~ exp(t)}
      s := 0.5*exp_acc(t);
      c := s;
    end
    else begin
      {exp(t) would overflow, use small margin below overflow}
      s := exp_acc(t-ln2);
      c := s;
    end;
    if x<0.0 then s := -s;
  end;
end;




procedure sinhcosh_fa(x: extended; var s,c: extended);
var
 t: extended;
begin

if F_FastSpec = True then
  begin
     t:=Exp_f(x);
     c:=(t+1/t)*0.5;
     s:=(t-1/t)*0.5;
  end
  else
  begin
     sinhcosh_acc(x,s,c);
  end;

end;



function vers(x: extended): extended;
  {-Return the versine vers(x) = 1 - cos(x)}
var
  t: extended;
begin
  {reduction mod Pi/2, |t| <= Pi/4}
  case rem_pio2(x,t) and 3 of
      0:  begin
            {vers(x) = 1 - cos(t)}
            x := t*t;
            t := PolEvalX_f(x,pcv,npcv);
            vers := 0.5*x + sqr(x)*t;
          end;
      1:  vers := 1.0 + sin_f(t);
      2:  vers := 1.0 + cos_f(t);
    else  vers := 1.0 - sin_f(t)
  end;
end;




procedure cexp_f(z: complex; var w: complex); assembler;
asm
  fld  tbyte ptr   [z.im]
  fld  tbyte ptr   [z.re]

  call    Z_EXP

  fstp  tbyte ptr [w.re]
  fstp  tbyte ptr [w.im]
end;





procedure cexp_fa(z: complex; var w: complex);
begin
   if F_FastSpec = True then cexp_f(z,w)  else cexp_acc(z,w);
end;



procedure cexp_acc(z: complex; var w: complex);
  {-Return the complex exponential function w = exp(z)}
var
  s,c,x: extended;

  function expmul(const y: extended): extended;
    {-Return exp(x)*y}
  var
    t: extended;
  begin
    if y=0.0 then expmul := 0.0
    else begin
      t := x + ln(abs(y));
      if t<=ln_MaxExt then t := exp_acc(t)     //_acc
      else t := PosInf_x;
      if y<0.0 then expmul := -t
      else expmul := t;
    end;
  end;

begin
  {HMF[1], 4.3.47: exp(x + iy) = cos(y)*exp(x) + i*sin(y)*exp(x)}
  //sincos_x(z.im,s,c);

  if z.im = 0 then         {.375}
  begin
    w.re:=exp_acc(z.re);
    w.im:=0;
  end
  else
  begin

   sincos_acc(z.im,s,c);  {.335}      //_acc
   x := z.re;
   if x<=ln_MaxExt then begin
    {No overflow}
     x := exp_acc(x);   //_acc
     w.re := c*x;
     w.im := s*x;
   end
   else
   begin
    {exp(x) will overflow, but product(s) may be finite}
    w.re := expmul(c);
    w.im := expmul(s);
   end;

  end;
end;







procedure ccot_f(z: complex; var w: complex);  assembler;
asm
  fld     [z.im]
  fld     [z.re]

  call    Z_COTAN

  fstp  tbyte ptr w.re
  fstp  tbyte ptr w.im
end;




procedure ccot_fa(const z: complex; var w: complex);
  {-Return the complex circular cotangent w = cot(z)}
var
  u: complex;
begin
  if F_FastSpec = True then ccot_f(z,w)  else ccot_acc(z,w);
end;


procedure ccot_acc(const z: complex; var w: complex);
  {-Return the complex circular cotangent w = cot(z)}
var
  u: complex;
begin
  {cot(z) = i*coth(iz)}
  if z.im = 0 then         {.375}
  begin
    w.re:=cot_acc(z.re);
    w.im:=0;
  end
  else
  begin
    u.re := -z.im;
    u.im :=  z.re;
    ccoth_acc(u,u);
    w.re := -u.im;
    w.im :=  u.re;
  end;
end;



{---------------------------------------------------------------------------}
procedure ctan_acc(const z: complex; var w: complex);
  {-Return the complex circular tangent w = tan(z)}
var
  u: complex;
begin
  {tan(z) = - i*tanh(iz)}
  if z.im = 0 then         {.375}
  begin
    w.re:=tan_acc(z.re);
    w.im:=0;
  end
  else
  begin
    u.re := -z.im;
    u.im :=  z.re;
    ctanh_acc(u,u);
    w.re :=  u.im;
    w.im := -u.re;
  end;
end;



{---------------------------------------------------------------------------}
procedure ccos_acc(const z: complex; var w: complex);
  {-Return the complex circular cosine w = cos(z)}
var
  c,s: extended;
begin
  {HMF[1], 4.3.56: cos(x + iy) = cos(x)*cosh(y) - i*sin(x)*sinh(y)}
  //sincos(z.re, s,c);

  if z.im = 0 then         {.375}
  begin
    w.re:=cos_acc(z.re);
    w.im:=0;
  end
  else
  begin
    sincos_acc(z.re, s,c);  {.335}
    coshsinhmult_acc(z.im, c, -s, w.re, w.im);
  end;
end;


{---------------------------------------------------------------------------}
procedure csin_acc(const z: complex; var w: complex);
  {-Return the complex circular sine w = sin(z)}
var
  c,s: extended;
begin
  {HMF[1], 4.3.55: sin(x + iy) = sin(x)*cosh(y) + i*cos(x)*sinh(y)}
  //sincos(z.re, s,c);


  if z.im = 0 then         {.375}
  begin
    w.re:=sin_acc(z.re);
    w.im:=0;
  end
  else
  begin
    sincos_acc(z.re, s,c);  {.335}
    coshsinhmult_acc(z.im, s, c, w.re, w.im);
  end;
end;



{---------------------------------------------------------------------------}
function cot_f(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Return the circular cotangent of x, x mod Pi <> 0}
asm
  {cot := cos(x)/sin(x) = 1/tan(x)}
  fld    [x]
  fptan
  fdivrp st(1),st
  //fwait
end;



{---------------------------------------------------------------------------}
function tan_acc(x: extended): extended;
  {-Return the circular tangent of x, x mod Pi <> Pi/2}
var
  t: extended;
begin
  {reduction mod Pi/2, |t| <= Pi/4}
  if odd(rem_pio2(x,t)) then tan_acc := -cot_f(t)
  else tan_acc := tan_f(t);
end;


{---------------------------------------------------------------------------}
function cot_acc(x: extended): extended;
  {-Return the circular cotangent of x, x mod Pi <> 0}
var
  t: extended;
begin
  {reduction mod Pi/2, |t| <= Pi/4}
  if odd(rem_pio2(x,t)) then cot_acc := -tan_f(t)
  else cot_acc := cot_f(t);
end;





{---------------------------------------------------------------------------}
procedure cx_sqrt(a,b: extended; var u,v: extended);
  {-Return u + iv := sqrt(a + bi)}
  const
   MV_125: extended = 0.95e4932;
var
  x,y,r,t: extended;
begin
  x := abs(a);
  y := abs(b);
  if (x=0.0) and (y=0.0) then begin
    u := 0.0;
    v := 0.0;
  end
  else begin
    {Ref: NR[13], (5.4.6/7), see also HMF[1], 3.7.27}
    if x >= y then begin
      r := y/x;
      t := x;
      r := 0.5*(1.0+sqrt(1.0+r*r));
    end
    else begin
      r := x/y;
      t := y;
      r := 0.5*(r+sqrt(1.0+r*r));
    end;
    if t<=MV_125 then t := sqrt(t*r)
    else t := sqrt(t)*sqrt(r);
    if a >= 0.0 then begin
      u := t;
      v := 0.5*(b/t);
    end
    else begin
      if b < 0.0 then t := -t;
      u := 0.5*(b/t);
      v := t;
    end;
  end;
end;




{---------------------------------------------------------------------------}
procedure cpolar_acc(const z: complex; var r,theta: extended);  {$ifdef HAS_INLINE} inline;{$endif}
  {-Return the polar form z = r*exp(i*theta) with r = |z|, theta = arg z}
begin
  r := hypot_acc(z.re, z.im);
  theta := arctan2_acc(z.im, z.re);
end;




{---------------------------------------------------------------------------}
function cbrt(x: extended): extended;
  {-Return the cube root of x}
var
  y: extended;
begin
  if (TExtRec(x).xp and $7FFF=$7FFF) or (x=0.0) or (abs(x)=1.0) then begin
    {x is 0, +1, -1, Inf, or NaN}
    cbrt := x;
  end
  else begin
    {calculate initial approximation}
    y := copysign(exp2(log2_f(abs(x))/THREE),x);
    {perform one Newton step}
    cbrt := y - (y - x/sqr(y))/THREE;
  end;
end;


{---------------------------------------------------------------------------}
function nroot_acc(x: extended; n: integer): extended;
  {-Return the nth root of x; n<>0, x >= 0 if n is even}
var
  y: extended;
begin
  if n<0 then nroot_acc := 1.0/nroot_acc(x,-n)
  else if n<4 then begin
    case n of
        3:  nroot_acc := cbrt(x);
        2:  nroot_acc := sqrt(x);
        1:  nroot_acc := x;
      else  nroot_acc := 1.0/n;
    end
  end
  else if x=0.0 then nroot_acc := 0.0
  else begin
    {if x<0 and n even, log(y) will generate RTE}
    if odd(n) then y := abs(x) else y := x;
    {calculate initial approximation}
    y := copysign(exp2(log2_f(y)/n),x);
    {perform one Newton step}
    nroot_acc := y - (y - x/intpower_acc(y,n-1))/n
  end;
end;

{---------------------------------------------------------------------------}
procedure cnroot_acc(const z: complex; n: integer; var w: complex);
  {-Return the complex principal n'th root w = z^(1/n)}
var
  r,s,c,t: extended;
begin
  if n=1 then w := z
  else if n=2 then csqrt(z,w)
  else begin
    cpolar_acc(z,r,t);
    r := nroot_acc(r,n);
    //sincos(t/n,s,c);
    sincos_acc(t/n,s,c);  {.335}
    w.re := r*c;
    w.im := r*s;
  end;
end;



{---------------------------------------------------------------------------}
procedure csqrt(const z: complex; var w: complex);
  {-Return the complex principal square root w = sqrt(z)}
begin
  cx_sqrt(z.re,z.im,w.re,w.im);
end;




function R_ROOT_acc(x: extended; n: integer):extended;  stdcall;
  {-Return the complex principal n'th root w = z^(1/n)}
var
  r,s,c,t: extended;
  w: complex;
begin
  R_ROOT_acc:=nroot_acc(x,n);
end;




procedure Z_ROOT_acc(z: complex; n: integer);  stdcall;
  {-Return the complex principal n'th root w = z^(1/n)}
var
  r,s,c,t: extended;
  w: complex;
begin
  cnroot_acc(z,n,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



procedure Z_COT_ACC(z:  complex);    stdcall;
var
w: complex;
begin
  ccot_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;


procedure Z_TAN_ACC(z:  complex);    stdcall;
var
w: complex;
begin
  ctan_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



procedure Z_SIN_ACC(z:  complex);    stdcall;
var
w: complex;
begin
  csin_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;




procedure Z_COS_ACC(z:  complex);    stdcall;
var
w: complex;
begin
  ccos_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;


function R_COT_ACC(x:  extended): extended;    stdcall;
begin
  R_COT_ACC:=cot_acc(x);
end;



function R_TAN_ACC(x:  extended): extended;    stdcall;
begin
  R_TAN_ACC:=tan_acc(x);
end;




function R_SIN_ACC(x:  extended): extended;    stdcall;
begin
  R_SIN_ACC:=sin_acc(x);
end;



function R_COS_ACC(x:  extended): extended;    stdcall;
begin
  R_COS_ACC:=cos_acc(x);
end;



procedure Z_COSSIN_ACC(x:  extended);     stdcall;
var
s,c: extended;
begin
  sincos_acc(x, s,c);
  asm
    fld tbyte ptr [s]
    fld tbyte ptr [c]
  end;
end;


procedure Z_EXP_ACC(z:  complex);     stdcall;
var
w: complex;
begin
  cexp_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function  R_EXP_ACC(x:  extended): extended;        stdcall;
begin
  R_EXP_ACC:=exp_acc(x);
end;


function  R_POWER_ACC(x,y:  extended): extended;      stdcall;
begin
   R_POWER_ACC:=power_acc(x,y);
end;



procedure Z_POWER_ACC(z1,z2:  complex);    stdcall;
var
w: complex;
begin
  cpow_acc(z1,z2,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;




procedure ZR_POWER_ACC(z1:  complex; x: extended);    stdcall;
var
w: complex;
begin
  cpowx_acc(z1,x,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;




procedure RZ_POWER_ACC(x: extended; z2:  complex);    stdcall;
var
z1,w: complex;
begin
  z1.re:=x;
  z1.im:=0.0;
  cpow_acc(z1,z2,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;





procedure Z_CDIV(z1,z2: complex);    stdcall;
var
w: complex;
q,d,t: extended;
begin
  //cdiv(z1,z2,w);
   {Smith's method: see Knuth[32], Exercise 4.2.1.16 and NR[13], (5.4.5)}
  if abs(z2.re) >= abs(z2.im) then begin
    q := z2.im/z2.re;
    d := z2.re + q*z2.im;
    t := (z1.re + q*z1.im)/d;
    w.im := (z1.im - q*z1.re)/d;
    w.re := t;
  end
  else begin
    q := z2.re/z2.im;
    d := z2.im + q*z2.re;
    t := (q*z1.re + z1.im)/d;
    w.im := (q*z1.im - z1.re)/d;
    w.re := t;
  end;
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;




procedure Z_SQRT_acc(z: complex);  stdcall;
var
  w: complex;
begin
  csqrt(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;


function R_SQRT_acc(x: extended): extended; assembler;  stdcall;
  {-Return the square root of x >= 0}
asm
  fld     [x]
  fsqrt
  //fwait
end;




procedure Z_LN_acc(z: complex);  stdcall;
var
  w: complex;
begin
  cln_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_LN_acc(x: extended): extended; assembler; stdcall;
  {-Return natural logarithm of x}
asm
  fldln2
  fld     [x]
  fyl2x
  fwait
end;




procedure Z_SINH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  if z.im = 0 then         {.375}
  begin
    w.re:=sinh_acc(z.re);
    w.im:=0;
  end
  else
  begin
   csinh_acc(z,w);
  end;

  asm
     fld tbyte ptr [w.im]
     fld tbyte ptr [w.re]
  end;

end;



function R_SINH_acc(x: extended): extended; stdcall;
begin
    R_SINH_acc:=sinh_acc(x);
end;




procedure Z_COSH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  if z.im = 0 then         {.375}
  begin
    w.re:=cosh_acc(z.re);
    w.im:=0;
  end
  else
  begin
    ccosh_acc(z,w);
  end;

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;

end;



function R_COSH_acc(x: extended): extended; stdcall;
begin
    R_COSH_acc:=cosh_acc(x);
end;




procedure Z_TANH_acc(z: complex);  stdcall;
var
  w: complex;
begin
if z.im = 0 then         {.375}
  begin
    w.re:=tanh_acc(z.re);
    w.im:=0;
  end
  else
  begin
    ctanh_acc(z,w);
  end;


  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_TANH_acc(x: extended): extended; stdcall;
begin
    R_TANH_acc:=tanh_acc(x);
end;






procedure Z_COTH_acc(z: complex);  stdcall;
var
  w: complex;
begin

  if z.im = 0 then         {.375}
  begin
    w.re:=coth_acc(z.re);
    w.im:=0;
  end
  else
  begin
    ccoth_acc(z,w);
  end;

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_COTH_acc(x: extended): extended; stdcall;
begin
    R_COTH_acc:=1/tanh_acc(x);
end;






procedure Z_SEC_acc(z: complex);  stdcall;
var
  w: complex;
begin
  csec_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_SEC_acc(x: extended): extended; stdcall;
begin
    R_SEC_acc:=1/cos_acc(x);
end;





procedure Z_COSEC_acc(z: complex);  stdcall;
var
  w: complex;
begin
  ccsc_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_COSEC_acc(x: extended): extended; stdcall;
begin
    R_COSEC_acc:=1/sin_acc(x);
end;



procedure Z_SECH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  csech_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_SECH_acc(x: extended): extended; stdcall;
begin
    R_SECH_acc:=1/cosh_acc(x);
end;



procedure Z_COSECH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  ccsch_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_COSECH_acc(x: extended): extended; stdcall;
begin
    R_COSECH_acc:=1/sinh_acc(x);
end;



 {--------------------------------------}

procedure Z_ARCSIN_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carcsin_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCSIN_acc(x: extended): extended; stdcall;
begin
    R_ARCSIN_acc:=arcsin_acc(x);
end;



procedure Z_ARCCOS_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carccos_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCCOS_acc(x: extended): extended; stdcall;
begin
    R_ARCCOS_acc:=arccos_acc(x);
end;


procedure Z_ARCTAN_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carctan_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCTAN_acc(x: extended): extended; stdcall;
begin
    R_ARCTAN_acc:=arctan(x);
end;



procedure Z_ARCCOTAN_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carccot_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCCOTAN_acc(x: extended): extended; stdcall;
begin
    R_ARCCOTAN_acc:=arccot_acc(x);
end;




procedure Z_ARCSEC_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carcsec_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCSEC_acc(x: extended): extended; stdcall;
begin
    R_ARCSEC_acc:=arcsec_acc(x);
end;


procedure Z_ARCCOSEC_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carccsc_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCCOSEC_acc(x: extended): extended; stdcall;
begin
    R_ARCCOSEC_acc:=arccsc_acc(x);
end;




 {--------------------------------------}

procedure Z_ARCSINH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carcsinh_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCSINH_acc(x: extended): extended; stdcall;
begin
    R_ARCSINH_acc:=arcsinh_acc(x);
end;



procedure Z_ARCCOSH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carccosh_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCCOSH_acc(x: extended): extended; stdcall;
begin
    R_ARCCOSH_acc:=arccosh_acc(x);
end;


procedure Z_ARCTANH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carctanh_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCTANH_acc(x: extended): extended; stdcall;
begin
    R_ARCTANH_acc:=arctanh_acc(x);
end;



procedure Z_ARCCOTANH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carccoth_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCCOTANH_acc(x: extended): extended; stdcall;
begin
    R_ARCCOTANH_acc:=arccoth_acc(x);
end;




procedure Z_ARCSECH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carcsech_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCSECH_acc(x: extended): extended; stdcall;
begin
    R_ARCSECH_acc:=arcsech_acc(x);
end;


procedure Z_ARCCOSECH_acc(z: complex);  stdcall;
var
  w: complex;
begin
  carccsch_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



function R_ARCCOSECH_acc(x: extended): extended; stdcall;
begin
    R_ARCCOSECH_acc:=arccsch_acc(x);
end;










{---------------------------------------------------------------------------}
procedure clog10_acc(const z: complex; var w: complex);
  {-Return the principal branch of the base 10 logarithm of z, w=ln(z)/ln(10)}
begin
  cln_acc(z,w);
  w.re := w.re*log10e;
  w.im := w.im*log10e;
end;


{---------------------------------------------------------------------------}
procedure clogbase_acc(const b,z: complex; var w: complex);
  {-Return the principal branch of the base b logarithm of z, w=ln(z)/ln(b)}
var
  u: complex;
begin
  cln_acc(b,u);
  cln_acc(z,w);
  cdiv_acc(w,u,w);
end;



procedure Z_LOG_acc(z,x: complex);  stdcall;
var
  w: complex;
begin
  clogbase_acc(z,x,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



procedure ZR_LOG_acc(z: complex; x:extended);  stdcall;
var
  b,w: complex;
begin
 b.re:=x; b.im:=0;
 clogbase_acc(z,b,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;




procedure RZ_LOG_acc(x:extended; z: complex );  stdcall;
var
  zp,w: complex;
begin
 zp.re:=x; zp.im:=0;
 clogbase_acc(zp,z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;





function R_LOG_acc(b,x: extended): extended; assembler;  stdcall;
{-Return base b logarithm of x}
asm
  fld1
  fld     [x]
  fyl2x
  fld1
  fld     [b]
  fyl2x
  fdivp   st(1),st
  fwait
end;


{---------------------------------------------------------------------------}



procedure Z_LOG10_acc(z: complex);  stdcall;
var
  w: complex;
begin
  clog10_acc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;




procedure Z_LOG2_acc(z: complex);  stdcall;
var
  b,w: complex;
begin
 b.re:=2; b.im:=0;
 clogbase_acc(b,z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;






function R_LOG10_acc(x: extended): extended; assembler;  stdcall;
  {-Return base 10 logarithm of x}
asm
  fldlg2
  fld     [x]
  fyl2x
  //fwait
end;



function R_LOG2_acc(x: extended): extended; assembler;  stdcall;
  {-Return base 2 logarithm of x}
asm
  fld1
  fld     [x]
  fyl2x
  //fwait
end;





{---------------------------------------------------------------------------}
procedure cpow_acc(const z,a: complex; var w: complex);
  {-Return the principal value of the complex power w = z^a = exp(a*ln(z))}
var
  u: complex;
  t: extended;
begin
  {Ref: NIST[30], 4.2(iv) and Kahan[61], Table 1]}
  if (a.re=0.0) and (a.im=0.0) then begin
    {z^0 = 1}
    w.re := 1.0;
    w.im := 0.0;
  end
  else if (z.re=0.0) and (z.im=0.0) and (a.re > 0.0) then begin
    {0^a = 0 if re(a) > 0}
    w.re := 0.0;
    w.im := 0.0;
  end
  else begin
    {w = exp(a*ln(z))}
    cln_acc(z,u);
    {u := u*a}
    t    := u.re*a.re - u.im*a.im;
    u.im := u.re*a.im + u.im*a.re;
    u.re := t;
    cexp_acc(u,w);
  end;
end;


{---------------------------------------------------------------------------}
procedure cpowx_acc(const z: complex; x: extended; var w: complex);
  {-Return the complex principal value w = z^x = |z|^x * exp(i*x*arg(z))}
var
  r,s,c,t: extended;
begin
  if x=0.0 then w := C_1
  else begin
    cpolar_acc(z,r,t);
    //r := power(r,x);
    r := power_acc(r,x); {.335}
    //sincos(t*x,s,c);
    sincos_acc(t*x,s,c); {.335}
    w.re := r*c;
    w.im := r*s;
  end;
end;



//***************************ACC END********************************************



procedure Z_LNGAMMA;
var
wx,wy: extended;
w,z: complex;
 rez: boolean;
begin
  asm
    fstp tbyte ptr [z.re]
    fstp tbyte ptr [z.im]
  end;

  rez := z.im=0.0;
  clngamma(z,w);
  //cexp(w,w);
  if rez then w.im := 0.0;

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



procedure Z_PSI;
var
wx,wy: extended;
w,z: complex;
 rez: boolean;
begin
  asm
    fstp tbyte ptr [z.re]
    fstp tbyte ptr [z.im]
  end;

  cpsi(z,w);

  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;
end;



//lngamma(z1/z2)
procedure clngam1z(const z: complex; var w: complex);
  {-Return lnGamma(1+z) with power series, |z| < 2}
var
  s,p,d: complex;
  x,eps: extended;
  n: integer;
const
  NMAX = 128;
const
  znhex: array[2..28] of THexExtW = ( {for n from 2 to 28 do evalf((-1)^n*(Zeta(n)-1)/n) od;}
           ($3231,$307D,$6625,$A51A,$3FFD),  {+3.2246703342411321824E-1}
           ($3409,$ABB0,$00D2,$89F0,$BFFB),  {-6.7352301053198095132E-2}
           ($1B60,$EC24,$1563,$A899,$3FF9),  {+2.0580808427784547880E-2}
           ($8C37,$C7AF,$7E10,$F202,$BFF7),  {-7.3855510286739852664E-3}
           ($7EA5,$DB61,$B756,$BD6E,$3FF6),  {+2.8905103307415232858E-3}
           ($3E76,$FC70,$2E15,$9C56,$BFF5),  {-1.1927539117032609771E-3}
           ($45F3,$1CB7,$57C3,$859B,$3FF4),  {+5.0966952474304242234E-4}
           ($3E38,$697E,$A63B,$E9FE,$BFF2),  {-2.2315475845357937976E-4}
           ($D19D,$BEB2,$D878,$D093,$3FF1),  {+9.9457512781808533713E-5}
           ($7797,$E40F,$2DEB,$BC6F,$BFF0),  {-4.4926236738133141698E-5}
           ($1126,$3758,$E773,$AC06,$3FEF),  {+2.0507212775670691553E-5}
           ($142B,$7112,$4B1E,$9E5E,$BFEE),  {-9.4394882752683959037E-6}
           ($5C81,$9A55,$D1CF,$92CB,$3FED),  {+4.3748667899074878042E-6}
           ($08E4,$3CAA,$75BB,$88D9,$BFEC),  {-2.0392157538013662368E-6}
           ($79D0,$9178,$66F5,$8032,$3FEB),  {+9.5514121304074198328E-7}
           ($75DA,$E7E9,$06C9,$F130,$BFE9),  {-4.4924691987645660433E-7}
           ($6BB3,$83D2,$DD9F,$E3B5,$3FE8),  {+2.1207184805554665869E-7}
           ($BB2C,$FC54,$365D,$D7AD,$BFE7),  {-1.0043224823968099609E-7}
           ($7A06,$3858,$9E10,$CCDC,$3FE6),  {+4.7698101693639805657E-8}
           ($6366,$F9F5,$39A6,$C316,$BFE5),  {-2.2711094608943164910E-8}
           ($6593,$7D6E,$ED66,$BA34,$3FE4),  {+1.0838659214896954091E-8}
           ($681B,$3D75,$5422,$B21A,$BFE3),  {-5.1834750419700466551E-9}
           ($14F1,$FE96,$43BF,$AAAD,$3FE2),  {+2.4836745438024783171E-9}
           ($720A,$2C68,$B3C9,$A3D8,$BFE1),  {-1.1921401405860912074E-9}
           ($5E28,$7E08,$E959,$9D8A,$3FE0),  {+5.7313672416788620131E-10}
           ($FCBD,$5F1E,$D4FD,$97B4,$BFDF),  {-2.7595228851242331451E-10}
           ($620C,$BA1A,$9519,$9249,$3FDE)); {+1.3304764374244489481E-10}
begin
  {HMF[1], 6.1.33}
  x := 0.4227843350984671394; {1-EulerGamma}
  n := 2;
  s.re := z.re + 1.0;
  s.im := z.im;
  cln_fa(s,s);
  s.re := z.re*x - s.re;
  s.im := z.im*x - s.im;
  eps  := 0.5*eps_x;
  {p = z^n}
  p.re := z.re;
  p.im := z.im;

  repeat
    cmul_f(p,z,p);   // cmul(p,z,p);
    {compute x = (-1)^n*(Zeta(n)-1)/n}
    if n<29 then x := extended(znhex[n])
    else begin
      x := ldexp(1,-n);
      x := x + x*x + exp3(-n); {1/2^n + 1/3^n + 1/4^n}
      if odd(n) then x := -x/n
      else x := x/n
    end;
    d.re := p.re*x;
    d.im := p.im*x;
    s.re := s.re + d.re;
    s.im := s.im + d.im;
    inc(n);
  until ((abs(d.re) <= eps*abs(s.re)) and (abs(d.im) <= eps*abs(s.im))) or (n>NMAX);
  {$ifdef debug}
  {.227}
    {
    if n>NMAX then begin
      writeln('No convergence in clngam1z');

    end;
    }
  {$endif}
  w.re := s.re;
  w.im := s.im;
end;



{---------------------------------------------------------------------------}
function rem_pio2_ph(x: extended; var z: extended): integer;
  {-Payne/Hanek reduction of x:  z = x - n*Pi/2, |z| <= Pi/4, result = n mod 8}
var
  ax, ay: TDA02;
  e0: integer;
begin
  z := abs(x);
  if (x=0.0) or IsNanOrInf(x) then rem_pio2_ph := 0
  else begin
    e0 := ilogb(z)-23;
    z  := ldexp(z,-e0);
    ax[0] := trunc(z); z := ldexp(z-ax[0],24);
    ax[1] := trunc(z);
    ax[2] := trunc(ldexp(z-ax[1],24));
    e0 := k_rem_pio2(ax,ay, e0, 3, 2);
    if x>=0 then begin
      z := ay[0]+ay[1];
      rem_pio2_ph := e0;
    end
    else begin
      z := -ay[0]-ay[1];
      rem_pio2_ph := (-e0) and 7;
    end;
  end;
end;




procedure clngam_lanczos(const z: complex; var w: complex);
  {-Return lnGamma(z) using Lanczos sum, assumes z.re >= 1}
var
  k: integer;
  xr,tr: extended;
  s,t: complex;
{Coefficients for g=9 from Paul Godfrey's  http://my.fit.edu/~gabdo/gammacoeff.txt}
const
  lgam = 9;
  lcoeffh: array[0..lgam+1] of THexExtW = (
             ($064B,$0000,$0000,$8000,$3FFF),  {+1.0000000000000001747}
             ($4FAA,$E8F4,$3395,$B2A3,$400B),  {+5.7164001882743413789E+3}
             ($6D9F,$F2A2,$3791,$E77D,$C00C),  {-1.4815304267684139090E+4}
             ($C153,$6C23,$F89A,$DF4D,$400C),  {+1.4291492776574785540E+4}
             ($767E,$2FD2,$4820,$C661,$C00B),  {-6.3481602176414588134E+3}
             ($5DC8,$52E3,$7714,$A2B3,$4009),  {+1.3016082860583218741E+3}
             ($5F27,$B2E6,$791F,$D85A,$C005),  {-1.0817670535143696347E+2}
             ($AC57,$B9DA,$BB46,$A6C3,$4000),  {+2.6056965056117558277}
             ($5E14,$9ACD,$6EE0,$F340,$BFF7),  {-7.4234525102014161516E-3}
             ($16EC,$FC65,$34C4,$E73F,$3FE6),  {+5.3841364325095640630E-8}
             ($B1AC,$8882,$5F2D,$8A3F,$BFE3)); {-4.0235331412682363722E-9}
var
  lcoeff: array[0..lgam+1] of extended absolute lcoeffh;
begin
  {compute s = ln(Lanczos sum) = ln(c[0]+sum(c[k]/(z+k)))}
  s.re := lcoeff[0];
  s.im := 0.0;
  for k:=1 to lgam+1 do begin
    t.re := z.re + (k-1);
    t.im := z.im;
    rdivc_fa(lcoeff[k],t,t);
    s.re := s.re + t.re;
    s.im := s.im + t.im;
  end;
  cln_fa(s,s);

  {t = ln(z+lgam-0.5)}
  t.re := z.re + (lgam-0.5);
  t.im := z.im;
  cln_fa(t,t);

  {w = -(z+lgam-0.5) + (z-0.5)*t + ln(sqrt(2Pi)) + s}
  xr := z.re - 0.5;
  tr := t.re - 1.0;
  w.re := tr*xr   - t.im*z.im + s.re + (LnSqrt2Pi-lgam);
  w.im := tr*z.im + t.im*xr   + s.im;

end;





function sinh_small(x: extended): extended;
  {-Internal: return sinh(x) for |x| <= 1}
const
  ncs=9;
  csh: array[0..ncs-1] of THexExtW = (     {chebyshev(sinh(x)/x-1, x=-1..1, 0.1e-20)}
         ($D006,$0AFA,$F911,$B131,$3FFC),  {+0.173042194047179631675883846985    }
         ($4EEC,$D088,$9973,$B364,$3FFB),  {+0.875942219227604771549002634544e-1 }
         ($AECD,$1FE8,$437A,$8D7D,$3FF5),  {+0.107947777456713275024272706516e-2 }
         ($D1B0,$68E6,$89C6,$D5E7,$3FED),  {+0.637484926075475048156855545659e-5 }
         ($DAE7,$9306,$8CA6,$BD2E,$3FE5),  {+0.220236640492305301591904955350e-7 }
         ($E0C5,$862E,$36BE,$DB5F,$3FDC),  {+0.498794018041584931494262802066e-10}
         ($5D46,$9B41,$8645,$B389,$3FD3),  {+0.797305355411573048133738827571e-13}
         ($D7DD,$B169,$A8B3,$DA6F,$3FC9),  {+0.947315871307254445124531745434e-16}
         ($7636,$F264,$EF5C,$CD44,$3FBF)); {+0.869349205044812416919840906342e-19}
var
  css: array[0..ncs-1] of extended absolute csh;
var
  t: extended;
const
  t1 = 2.3E-10;  {~ sqrt(2^-64)}
begin
  if abs(x)<=t1 then begin
    {sinh(x) = x*(1 + 1/6*x^2 + 1/120*x^4 + O(x^6))}
    sinh_small := x;
  end
  else begin
    t := CSEvalX_f(2.0*sqr(x)-1.0, css, ncs);
    sinh_small := x + x*t;
  end;
end;



function sinh_small(x: extended; rel: boolean): extended;
  {-Internal: return sinh(x) for |x| <= 1}
const
  ncs=9;
  csh: array[0..ncs-1] of THexExtW = (     {chebyshev(sinh(x)/x-1, x=-1..1, 0.1e-20)}
         ($D006,$0AFA,$F911,$B131,$3FFC),  {+0.173042194047179631675883846985    }
         ($4EEC,$D088,$9973,$B364,$3FFB),  {+0.875942219227604771549002634544e-1 }
         ($AECD,$1FE8,$437A,$8D7D,$3FF5),  {+0.107947777456713275024272706516e-2 }
         ($D1B0,$68E6,$89C6,$D5E7,$3FED),  {+0.637484926075475048156855545659e-5 }
         ($DAE7,$9306,$8CA6,$BD2E,$3FE5),  {+0.220236640492305301591904955350e-7 }
         ($E0C5,$862E,$36BE,$DB5F,$3FDC),  {+0.498794018041584931494262802066e-10}
         ($5D46,$9B41,$8645,$B389,$3FD3),  {+0.797305355411573048133738827571e-13}
         ($D7DD,$B169,$A8B3,$DA6F,$3FC9),  {+0.947315871307254445124531745434e-16}
         ($7636,$F264,$EF5C,$CD44,$3FBF)); {+0.869349205044812416919840906342e-19}
var
  css: array[0..ncs-1] of extended absolute csh;
var
  t: extended;
const
  t1 = 2.3E-10;  {~ sqrt(2^-64)}
begin
  if abs(x)<=t1 then begin
    {sinh(x) = x*(1 + 1/6*x^2 + 1/120*x^4 + O(x^6))}
    if rel then sinh_small := 1.0
    else sinh_small := x;
  end
  else begin
    t := CSEvalX_f(2.0*sqr(x)-1.0, css, ncs);
    if rel then sinh_small := 1.0 + t
    else sinh_small := x + x*t;
  end;
end;








function CSEvalX_f(x: extended; const a: array of extended; n: integer): extended; assembler;
const c2: double=2.0;
const c05: double=0.5;
asm     //EAX <- addr(array)  ECX <- Length(array)
        //b0->ST(0);  b1->ST(1); b2->ST(2); b0x->ST(3);

       push eax
       push ecx
       push edx

       mov eax,  a
       mov ecx,  n
       sub ecx,  1

       fld  tbyte ptr [x]
       fmul c2
       fldz
       fldz
       fldz

       @@Ckl:

       fxch  st(1)
       fst   st(2)    //b2=b1
       fxch  st(1)
       fst   st(1)   //b1=b0
       fmul  st(0),st(3)    //x*b1
       fsub  st(0),st(2)    //x*b1-b2
       //fld  tbyte ptr [eax+10*edx]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       faddp

       dec  ecx
       jnz @@Ckl
       //loop @@Ckl


       // zero element a[0]
       fxch  st(1)
       fst   st(2)    //b2=b1
       fxch  st(1)
       fst   st(1)   //b1=b0

       fmul  st(0),st(3)    //x*b1
       fsub  st(0),st(2)    //x*b1-b2
       //fld  tbyte ptr [eax+10*edx]
       lea   edx,[ecx+4*ecx]
       fld   tbyte ptr [eax+2*edx]
       faddp



       fsubrp st(2),st(0)
       fstp   st(0)
       fmul   c05
       fstp   st(1)


       pop  edx
       pop  ecx
       pop  eax
end;



function CSEvalX(x: extended; const a: array of extended; n: integer): extended;
var
  b0,b1,b2: extended;
  i: integer;
begin
  {$ifdef CONST}
    {$ifdef debug}
     {.227}
    {
      if n>high(a)+1 then begin
        writeln('CSEvalX:  n > high(a)+1, n = ',n, ' vs. ', high(a)+1);
        readln;
      end;
      }
    {$endif}
    if n>high(a)+1 then n := high(a)+1;
  {$endif}
  b2 := 0.0;
  b1 := 0.0;
  b0 := 0.0;
  x  := 2.0*x;
  for i:=n-1 downto 0 do begin
    b2 := b1;
    b1 := b0;
    b0 := x*b1 - b2 + a[i];
  end;
  CSEvalX := 0.5*(b0-b2);
end;



function CSEvalX_fa(x: extended; const a: array of extended; n: integer): extended;
begin
  if F_FastSpec = True then  CSEvalX_fa:=CSEvalX_f(x,a,n) else CSEvalX_fa:=CSEvalX(x,a,n);
end;



function coshm1_acc(x: extended): extended;
  {-Return cosh(x)-1, accurate even for x near 0}
const
  ncc=8;
  cch: array[0..ncc-1] of THexExtW = (     {chebyshev(((cosh(x)-1)/(x^2)-1/2)/x^2, x=-1..1, 0.1e-20);}
         ($7F5B,$DC92,$B00E,$AD8C,$3FFB),  {+0.847409967933085972383472682702e-1 }
         ($E233,$6D68,$4FB4,$B954,$3FF4),  {+0.706975331110557282636312722683e-3 }
         ($C401,$57F2,$9421,$D38C,$3FEC),  {+0.315232776534872632694769980081e-5 }
         ($60F4,$9F76,$CDC0,$9634,$3FE4),  {+0.874315531301413118696907944019e-8 }
         ($D666,$F7AB,$C086,$9172,$3FDB),  {+0.165355516210397415961496829471e-10}
         ($5E0D,$C9ED,$687C,$CC55,$3FD1),  {+0.226855895848535933261822520050e-13}
         ($0DEF,$8B25,$7570,$D9B9,$3FC7),  {+0.236057319781153495473072617928e-16}
         ($7B04,$4A7F,$2A3E,$B5FC,$3FBD)); {+0.192684134365813759102742156829e-19}
var
  ccs: array[0..ncc-1] of extended absolute cch;
  z: extended;
begin
  x := abs(x);
  if x<=1.0 then begin
    x := sqr(x);
    if x<eps_x then begin
      {cosh(x)-1 = 0.5*x^2*[1 + 1/12*x^2 + O(x^4)]}
      coshm1_acc := 0.5*x;
    end
    else begin
      z := CSEvalX_f(2.0*x-1.0, ccs, ncc);
      coshm1_acc := 0.5*x + x*x*z;
    end;
  end
  else coshm1_acc := cosh_acc(x)-1.0;
end;



function isign(x: extended): integer;
  {-Return the sign of x, 0 if x=0 or NAN}
begin
  if IsNaN(x) or (x=0.0) then isign := 0
  else if x>0.0 then isign := 1
  else isign := -1;
end;









function exp3(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Return 3^x}
const
  l32_hi: THexDblA = ($00,$00,$30,$98,$93,$30,$E4,$3F);
  l32_lo: THexDblA = ($58,$1F,$02,$A7,$F4,$D4,$C4,$3D);
  log23h: THexExtW = ($43D0,$FDEB,$0D1C,$CAE0,$3FFF);  {1.5849625007211561815}
  c3: double = 3.0;
asm
 {
 fld   [x]
 fld   c3
 call  FPWR
 }

  fld     [x]                { x                                                  }
  fld     tbyte ptr [log23h] { log2(3) | x                                        }
  fmul    st,st(1)           { z = x * log2(3) | x                                }
  frndint                    { int(z) | x                                         }
  fld     qword ptr [l32_hi] { l32_hi | int(z) | x                                }
  fmul    st,st(1)           { int(z)*l32_hi | int(z) | x                         }
  fsubp   st(2),st           { int(z) | x-int(z)*l32_hi                           }
  fld     qword ptr [l32_lo] { l32_lo | int(z) | x-int(z)*l32_hi                  }
  fmul    st, st(1)          { int(z)*l32_lo | int(z) | x-int(z)*l32_hi           }
  fsubp   st(2),st           { int(z) | (x-int(z)*l32_hi)-int(z)*l32_lo           }
  fxch    st(1)              { (x-int(z)*l32_hi)-int(z)*l32_lo | int(z)           }
  fld     tbyte ptr [log23h] { log2(3) | (x-int(z)*l32_hi)-int(z)*l32_lo | int(z) }
  fmulp   st(1),st           { frac(z) | int(z)                                   }

{$ifndef use_fast_exp}

  {See the exp code for a description of these conditional lines}
  fld     st
  fabs                       { abs(frac(z)) | frac(z) | int(z)                   }
  fld1                       { 1 | abs(frac(z)) | frac(z) | int(z)               }
  fcompp
  fstsw   ax
  sahf
  jae     @@1                { frac(z) <= 1, no special action needed            }
  fld     st(1)              { int(z) | frac(z) | int(z)                         }
  fabs                       { abs(int(z)) | frac(z) | int(z)                    }
  fcomp   [ebig]
  fstsw   ax
  sahf
  jb      @@0
  fsub    st,st              { set frac=0 and scale with too large int(z)}
  jmp     @@1
@@0:
  fmul    dword ptr [half]   { frac(z)/2  | int(z)                               }
  f2xm1                      { 2^(frac(z)/2)-1 | int(z)                          }
  fld     st                 { 2^(frac(z)/2)-1 | 2^(frac(z)/2)-1 | int(z)        }
  fadd    dword ptr [two]    { 2^(frac(z)/2)+1 | 2^(frac(z)/2)-1 | int(z)        }
  fmulp   st(1),st           { 2^frac(z)-1 | int(z)                              }
  jmp     @@2

{$endif}

@@1:
  f2xm1                      { 2^frac(z)-1 | int(z)                              }

@@2:
  fld1                       { 1 | 2^frac(z)-1 | int(z)                          }
  faddp   st(1),st           { 2^frac(z) | int(z)                                }
  fscale                     { 2^z | int(z)                                      }
  fstp    st(1)              { 2^z = 3^x                                          }
  fwait

end;





procedure cln_f( z: complex; var w: complex); assembler;
asm
      fld  tbyte ptr [z.im]
      fld  tbyte ptr [z.re]
      call Z_LN
      fstp tbyte ptr [w.re]
      fstp tbyte ptr [w.im]
end;



procedure cln_fa(const z: complex; var w: complex);
begin
  if F_FastSpec = True then  cln_f(z,w) else cln_acc(z,w);
end;


procedure cln_acc(const z: complex; var w: complex);
  {-Return the complex natural logarithm w = ln(z); principal branch ln(|z|) + i*arg(z), accurate near |z|=1}
var
  a,x,y: extended;
begin
  {Ref: HMF[1], 4.1.2/3, accuracy improved for |z| near 1}
  x := abs(z.re);
  y := abs(z.im);
  if x<y then begin
    a := x;
    x := y;
    y := a;
  end;
  if (x<0.5) or (x>1.5) or (x+y>2.0) then a := ln(hypot_acc(x, y))
  else begin
    {avoid inaccuracies for |z|~1, eg ln(1e-20 + i) ~ 0.5e-40 + Pi/2}
    {ln(|z|) = 0.5*ln(x^2 + y^2) = 0.5*ln1p[(x^2-1) + y^2]}
    a := ln1p((x-1.0)*(x+1.0) + y*y)*0.5;
  end;
  w.im := arctan2_acc(z.im, z.re);
  w.re := a;
end;




procedure rdivc_f(x: extended; y: complex; var z: complex); assembler;
asm
      fld  tbyte ptr [y.im]
      fld  tbyte ptr [y.re]
      fld  tbyte ptr [x]
      call Z_RZDIV_FAST
      fstp tbyte ptr [z.re]
      fstp tbyte ptr [z.im]
end;



procedure rdivc_fa(x: extended; const y: complex; var z: complex);
begin
  if F_FastSpec = True then  rdivc_f(x,y,z) else rdivc_acc(x,y,z);
end;


procedure rdivc_acc(x: extended; const y: complex; var z: complex);
  {Return the quotient z = x/y for real x}
var
  d,q: extended;
begin
  {Stripped-down version of cdiv}
  if abs(y.re) >= abs(y.im) then begin
    q := y.im/y.re;
    if abs(y.re) < MV_4 then d := y.re + q*y.im
    else begin
      d := 0.5*y.re + 0.5*q*y.im;
      x := 0.5*x;
    end;
    z.im := -(q*x)/d;
    z.re := x/d;
  end
  else begin
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




function expx2_fa(x: extended): extended;
begin
  if F_FastSpec = True then  expx2_fa:= exp_f(x*abs(x)) else expx2_fa:=expx2_acc(x);
end;



function expx2_acc(x: extended): extended;
  {-Return exp(x*|x|) with damped error amplification in computing exp of the product.}
  { Used for exp(x^2) = expx2(abs(x)) and exp(-x^2) = expx2(-abs(x))}
const
  MFAC = 32768.0;
  MINV = 3.0517578125e-5;
var
  u,u1,m,f: extended;
  neg: boolean;
begin
  if x >= 106.5669902282 then begin
    expx2_acc := PosInf_x;
    exit;
  end
  else if x <= -106.77 then begin
    expx2_acc := 0.0;
    exit;
  end;

  {Ref: Cephes [7], file ldouble\expx2l.c}
  neg := x<0;
  x := abs(x);
  if x <= 1.0 then begin
    if neg then u := -x*x else u := x*x;
    expx2_acc := exp_acc(u);
  end
  else begin
    {Represent x as an exact multiple of MFAC plus a residual.}
    {MFAC is a power of 2 chosen so that exp(m * m) does not  }
    {overflow or underflow and so that |x - m| is small.      }
    m := MINV*floorx(MFAC*x + 0.5);
    f := x - m;

    {x^2 = m^2 + 2mf + f^2}
    u  := m*m;
    u1 := 2.0*m*f + f*f;

    if neg then begin
      u  := -u;
      u1 := -u1;
    end;

    if u+u1 > ln_MaxExt then expx2_acc := PosInf_x
    else begin
      {u is exact, u1 is small}
      expx2_acc := exp_acc(u)*exp_acc(u1);
    end;
  end;
end;




procedure sincos_f(x: extended; var s,c: extended); assembler; {&Frame-} {&Uses none}
asm
  fld [x]
  fsincos
  fxch
  mov     eax, s
  fstp    tbyte ptr [eax]
  mov     eax, c
  fstp    tbyte ptr [eax]
  fwait
end;




function sin_f(x: extended): extended;  assembler;
asm
  fld tbyte ptr [x]
  fsin
end;





function cos_f(x: extended): extended;  assembler;
asm
  fld tbyte ptr [x]
  fcos
end;



(*
procedure sincosPi(x: extended; var s,c: extended);
  {-Return s=sin(Pi*x), c=cos(Pi*x); (s,c)=(0,1) for abs(x) >= 2^64}
var
  t,ss,cc: extended;
  n: integer;
begin
  n := rem_int2(x,t) and 3;
  t := Pi*t;
  _sincos(t,ss,cc);
  case n of
      0: begin s:= ss; c:= cc; end;
      1: begin s:= cc; c:=-ss; end;
      2: begin s:=-ss; c:=-cc; end;
    else begin s:=-cc; c:= ss; end;
  end;
end;
*)


function sfc_zetah(s,a: extended): extended;
  {-Return the Hurwitz zeta function zetah(s,a) = sum(1/(i+a)^s, i=0..INF), s<>1, a>0}
var
  eps,q,r,t,u,w,z: extended;
  j,k,n: integer;
  ok: boolean;
const
  MaxIter = 40;
  eps1 = 1e-4;   {Threshold for hz_a1}
  S_HF = -8;     {Threshold for Hurzwitz formula}
label
  noconv;
begin
  {Initial reference: Cephes [7], file double\zeta.c}
  if IsNanOrInf(s) or IsNanOrInf(a) or (s=1.0) or (a<=0.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_zetah := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end
  else if s=0.0 then begin
    sfc_zetah := 0.5 - a;       {NIST [30], 25.11.13}
    exit;
  end
  else if a=0.5 then begin
    if s < 16384.0 then begin
      sfc_zetah := exp2m1(s)*sfc_zeta(s);   {NIST [30], 25.11.11}
      exit;
    end;
  end
  else if a=1.0 then begin
    sfc_zetah := sfc_zeta(s);   {NIST [30], 25.11.2}
    exit;
  end
  else if a=2.0 then begin
    sfc_zetah := sfc_zetam1(s); {NIST [30], 25.11.2/3}
    exit;
  end;

  if s>0.0 then begin
    {Quick checks: avoid overflow/underflow}
    t := ln(a);
    t := -s*t;
    if t>ln_MaxExt then begin
      sfc_zetah := PosInf_x;
      exit;
    end
    else if t<ln_MinExt then begin
      {here s > 1, 1/a^s ~ 0, avoid underflow in some cases:}
      {zetah ~ a^(1-s)/(s-1) + 0.5/a^s = (a/(s-1) + 0.5)/a^s}
      {      = a^(1-s)/(s-1) + 0.5*a^(1-s)/a}
      u := power_fa(a, 1-s);
      sfc_zetah := u/(s-1.0) + 0.5*u/a;
      exit;
    end;
  end
  else begin
    if (a>1.0) then begin
      if -s*ln(a-1.0) >ln_MaxExt then begin
        sfc_zetah := PosInf_x;
        exit;
      end;
    end;
    {Test if Bernoulli polynomials or Hurwitz formula can be used}
    if (s >= S_HF) and (frac(s)=0.0) then begin
      {s small negative integer: use 'naive' Bernoulli polynomial code}
      k := 1 - round(s);
      sfc_zetah := -bernpoly_intern(k,a)/k;  {NIST [30], 25.11.14}
      exit;
    end;
    if abs(a-1.0)<eps1 then begin
      {try expansion near a=1}
      sfc_zetah := hz_a1(s,a,ok);
      if ok then exit;
    end;
    if s < S_HF then begin
      sfc_zetah := hurwitz_formula(s,a);
      exit;
    end
  end;

  {Calculate z = zetah with the Euler-Maclaurin summation formula:}
  {See e.g. http://functions.wolfram.com/10.02.06.0020.01         }
  {z = sum1(s,a,n) + (a+n)^(1-s)/(s-1) - 1/2/(a+n)^s + sum2(s,a,n)}
  {with sum1(a,n) = sum(1/(a+k)^s, k=0..n) and                    }
  {sum2 = sum(B_2k/(2k)! * s(s+1)..(s+2k)/(a+n)^(s+2k+1),k=0..INF)}

  eps := 0.5*eps_x;
  if abs(s)<0.5 then n := 8
  else n := 9;

  {$ifdef Delphi}
    {Avoid brain-damaged paranoid warning: r,w,t might not have been initialized}
    r := 0; w := 0; t := 0;
  {$endif}

  {compute z = s1(a,n) = sum(1/(a+k)^s, k=0..n)}
  z := 0.0;
  for k:=0 to n do begin
    w := a+k;
    r := power_fa(w,-s);
    z := z+r;
    if r < eps*z then begin
      sfc_zetah := z;
      exit;
    end
  end;

  {Add the two single terms z = z + (a+n)^(1-s)/(s-1) - 1/2/(a+n)^s}
  {Here w=(a+n), r=1/(a+n)^s}
  z := z + r*w/(s-1.0);
  z := z - 0.5*r;

  {Add the terms of sum2 until a term is < e*(partial result)}
  q := 1.0;
  k := 0;
  for j:=0 to MaxIter do begin
    q := q*(s+k);
    r := r/w;
    if j>NBoF then begin
      {Some problematic (s,a) values: Check decreasing terms in}
      {asymptotic expansion and increase convergence tolerance.}
      if j=NBOF+1 then eps := 1.5*eps_x;
      u := t;
      t := sfc_bernoulli(k+2);  {TP5 fix}
      t := t/_factorial(k+2);   // t/sfc_fac(k+2);
      t := (q*t)*r;
      if abs(u)<=abs(t) then goto noconv;
    end
    else t := (q*extended(BoFHex[j]))*r;
    z := z + t;
    if abs(t) < eps*abs(z) then begin
      sfc_zetah := z;
      exit;
    end;
    q := q*(s+k+1);
    r := r/w;
    inc(k,2);
  end;

noconv:
  {No convergence}
  sfc_zetah := z;
  {$ifdef debug}
   {.248}
   // writeln('sfc_zetah - Euler-Maclaurin issue: ',s:21,' ',a:21);
  {$endif}
  if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));
end;



function sfc_zetaint(n: integer): extended;
  {-Return zeta(n) for integer arguments, n<>1}
const
  znhex: array[2..63] of THexExtW = (
           ($9918,$983E,$3312,$D28D,$3FFF),  {+1.6449340668482264364}
           ($09C2,$8031,$0027,$99DD,$3FFF),  {+1.2020569031595942854}
           ($41B6,$3EC2,$9156,$8A89,$3FFF),  {+1.0823232337111381915}
           ($6DBD,$53E6,$0C76,$84BA,$3FFF),  {+1.0369277551433699263}
           ($247C,$0492,$4C26,$8238,$3FFF),  {+1.0173430619844491397}
           ($C46D,$A679,$96D0,$8111,$3FFF),  {+1.0083492773819228268}
           ($B746,$C31C,$9B57,$8085,$3FFF),  {+1.0040773561979443394}
           ($AB81,$C0B5,$CF9E,$8041,$3FFF),  {+1.0020083928260822144}
           ($CBF1,$D2DD,$9719,$8020,$3FFF),  {+1.0009945751278180854}
           ($9954,$F245,$318D,$8010,$3FFF),  {+1.0004941886041194645}
           ($9821,$D966,$1052,$8008,$3FFF),  {+1.0002460865533080483}
           ($DEF6,$E845,$0564,$8004,$3FFF),  {+1.0001227133475784892}
           ($9C2B,$5E56,$01C9,$8002,$3FFF),  {+1.0000612481350587048}
           ($11BF,$BCBF,$0097,$8001,$3FFF),  {+1.0000305882363070205}
           ($9178,$66F5,$8032,$8000,$3FFF),  {+1.0000152822594086518}
           ($A19A,$C1CD,$4010,$8000,$3FFF),  {+1.0000076371976378998}
           ($6E8A,$932A,$2005,$8000,$3FFF),  {+1.0000038172932649999}
           ($F9BA,$DB08,$1001,$8000,$3FFF),  {+1.0000019082127165539}
           ($A233,$9E2C,$0800,$8000,$3FFF),  {+1.0000009539620338727}
           ($ACA0,$34AE,$0400,$8000,$3FFF),  {+1.0000004769329867878}
           ($D9D9,$118C,$0200,$8000,$3FFF),  {+1.0000002384505027277}
           ($F138,$05D8,$0100,$8000,$3FFF),  {+1.0000001192199259653}
           ($CFFF,$01F2,$0080,$8000,$3FFF),  {+1.0000000596081890513}
           ($3A95,$00A6,$0040,$8000,$3FFF),  {+1.0000000298035035146}
           ($662E,$0037,$0020,$8000,$3FFF),  {+1.0000000149015548284}
           ($76B9,$0012,$0010,$8000,$3FFF),  {+1.0000000074507117898}
           ($2768,$0006,$0008,$8000,$3FFF),  {+1.0000000037253340248}
           ($0D18,$0002,$0004,$8000,$3FFF),  {+1.0000000018626597235}
           ($AF05,$0000,$0002,$8000,$3FFF),  {+1.0000000009313274324}
           ($3A56,$0000,$0001,$8000,$3FFF),  {+1.0000000004656629064}
           ($1372,$8000,$0000,$8000,$3FFF),  {+1.0000000002328311834}
           ($067B,$4000,$0000,$8000,$3FFF),  {+1.0000000001164155017}
           ($0229,$2000,$0000,$8000,$3FFF),  {+1.0000000000582077209}
           ($00B8,$1000,$0000,$8000,$3FFF),  {+1.0000000000291038504}
           ($003D,$0800,$0000,$8000,$3FFF),  {+1.0000000000145519218}
           ($0014,$0400,$0000,$8000,$3FFF),  {+1.0000000000072759598}
           ($0007,$0200,$0000,$8000,$3FFF),  {+1.0000000000036379796}
           ($0002,$0100,$0000,$8000,$3FFF),  {+1.0000000000018189896}
           ($0001,$0080,$0000,$8000,$3FFF),  {+1.0000000000009094948}
           ($0000,$0040,$0000,$8000,$3FFF),  {+1.0000000000004547474}
           ($0000,$0020,$0000,$8000,$3FFF),  {+1.0000000000002273737}
           ($0000,$0010,$0000,$8000,$3FFF),  {+1.0000000000001136868}
           ($0000,$0008,$0000,$8000,$3FFF),  {+1.0000000000000568434}
           ($0000,$0004,$0000,$8000,$3FFF),  {+1.0000000000000284217}
           ($0000,$0002,$0000,$8000,$3FFF),  {+1.0000000000000142108}
           ($0000,$0001,$0000,$8000,$3FFF),  {+1.0000000000000071054}
           ($8000,$0000,$0000,$8000,$3FFF),  {+1.0000000000000035527}
           ($4000,$0000,$0000,$8000,$3FFF),  {+1.0000000000000017764}
           ($2000,$0000,$0000,$8000,$3FFF),  {+1.0000000000000008882}
           ($1000,$0000,$0000,$8000,$3FFF),  {+1.0000000000000004441}
           ($0800,$0000,$0000,$8000,$3FFF),  {+1.0000000000000002220}
           ($0400,$0000,$0000,$8000,$3FFF),  {+1.0000000000000001110}
           ($0200,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000555}
           ($0100,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000278}
           ($0080,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000139}
           ($0040,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000069}
           ($0020,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000035}
           ($0010,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000017}
           ($0008,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000009}
           ($0004,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000004}
           ($0002,$0000,$0000,$8000,$3FFF),  {+1.0000000000000000002}
           ($0001,$0000,$0000,$8000,$3FFF)); {+1.0000000000000000001}
begin
  if n>63 then sfc_zetaint := 1.0
  else if n>1 then sfc_zetaint := extended(znhex[n])
  else if n<0 then sfc_zetaint := sfc_bernoulli(1-n)/(n-1)+0.0  {avoid -0}
  else if n=0 then sfc_zetaint := -0.5
  else sfc_zetaint := PosInf_x;
end;




{---------------------------------------------------------------------------}
function zetap(s,sc: extended): extended;
  {-Return the Riemann zeta function at s>0, s<>1, sc=1-s}
var
  y: extended;
{Based on boost_1_42_0\boost\math\special_functions\zeta.hpp [19]}
{Copyright John Maddock 2007, see 3rdparty.ama for Boost license}
const
  P1: array[0..5] of extended = (
        0.243392944335937499969,
       -0.496837806864865688082,
        0.0680008039723709987107,
       -0.00511620413006619942112,
        0.000455369899250053003335,
       -0.279496685273033761927e-4);
  Q1: array[0..6] of extended = (
        1.0,
       -0.30425480068225790522,
        0.050052748580371598736,
       -0.00519355671064700627862,
        0.000360623385771198350257,
       -0.159600883054550987633e-4,
        0.339770279812410586032e-6);
  P2: array[0..5] of extended = (
        0.577215664901532860605,
        0.222537368917162139445,
        0.0356286324033215682729,
        0.00304465292366350081446,
        0.000178102511649069421904,
        0.700867470265983665042e-5);
  Q2: array[0..6] of extended = (
        1.0,
        0.259385759149531030085,
        0.0373974962106091316854,
        0.00332735159183332820617,
        0.000188690420706998606469,
        0.635994377921861930071e-5,
        0.226583954978371199405e-7);
  P4: array[0..6] of extended = (
       -0.053725830002359501027,
        0.0470551187571475844778,
        0.0101339410415759517471,
        0.00100240326666092854528,
        0.685027119098122814867e-4,
        0.390972820219765942117e-5,
        0.540319769113543934483e-7);
  Q4: array[0..7] of extended = (
        1.0,
        0.286577739726542730421,
        0.0447355811517733225843,
        0.00430125107610252363302,
        0.000284956969089786662045,
        0.116188101609848411329e-4,
        0.278090318191657278204e-6,
       -0.19683620233222028478e-8);
  P7: array[0..7] of extended = (
       -2.49710190602259407065,
       -3.36664913245960625334,
       -1.77180020623777595452,
       -0.464717885249654313933,
       -0.0643694921293579472583,
       -0.00464265386202805715487,
       -0.000165556579779704340166,
       -0.252884970740994069582e-5);
  Q7: array[0..8] of extended = (
        1.0,
        1.01300131390690459085,
        0.387898115758643503827,
        0.0695071490045701135188,
        0.00586908595251442839291,
        0.000217752974064612188616,
        0.397626583349419011731e-5,
       -0.927884739284359700764e-8,
        0.119810501805618894381e-9);
  P15: array[0..8] of extended = (
        -4.78558028495135548083,
        -3.23873322238609358947,
        -0.892338582881021799922,
        -0.131326296217965913809,
        -0.0115651591773783712996,
        -0.000657728968362695775205,
        -0.252051328129449973047e-4,
        -0.626503445372641798925e-6,
        -0.815696314790853893484e-8);
  Q15: array[0..8] of extended = (
         1.0,
         0.525765665400123515036,
         0.10852641753657122787,
         0.0115669945375362045249,
         0.000732896513858274091966,
         0.30683952282420248448e-4,
         0.819649214609633126119e-6,
         0.117957556472335968146e-7,
        -0.193432300973017671137e-12);
  P42: array[0..8] of extended = (
        -10.3948950573308861781,
         -2.82646012777913950108,
         -0.342144362739570333665,
         -0.0249285145498722647472,
         -0.00122493108848097114118,
         -0.423055371192592850196e-4,
         -0.1025215577185967488e-5,
         -0.165096762663509467061e-7,
         -0.145392555873022044329e-9);
  Q42: array[0..9] of extended = (
         1.0,
         0.205135978585281988052,
         0.0192359357875879453602,
         0.00111496452029715514119,
         0.434928449016693986857e-4,
         0.116911068726610725891e-5,
         0.206704342290235237475e-7,
         0.209772836100827647474e-9,
        -0.939798249922234703384e-16,
         0.264584017421245080294e-18);
const
   x1: extended = 81487.0/65536.0;
   x4: extended = 366299.0/524288.0;
begin
  {$ifdef debug}
   {.248}
    {
    if abs((s+sc)-1.0)>5e-19*maxx(1.0,abs(s)) then begin
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      zetap := NaN_x;
      exit;
    end;
    }
  {$endif}
  if s<1.0 then begin
    //y := PolEvalX(sc,P1,6)/PolEvalX(sc,Q1,7) - x1;
    y:=(((((P1[5]*sc+P1[4])*sc+P1[3])*sc+P1[2])*sc+P1[1])*sc+P1[0])/((((((Q1[6]*sc+Q1[5])*sc+Q1[4])*sc+Q1[3])*sc+Q1[2])*sc+Q1[1])*sc+Q1[0]) - x1;
    zetap := (y+sc)/sc;
  end
  else if s<=2.0 then begin
    s := -sc;
    //y := PolEvalX(s,P2,6)/PolEvalX(s,Q2,7);
    y:=(((((P2[5]*s+P2[4])*s+P2[3])*s+P2[2])*s+P2[1])*s+P2[0])/((((((Q2[6]*s+Q2[5])*s+Q2[4])*s+Q2[3])*s+Q2[2])*s+Q2[1])*s+Q2[0]);
    zetap := y - 1.0/sc;
  end
  else if s<=4.0 then begin
    s := s-2.0;
    //y := PolEvalX(s,P4,7)/PolEvalX(s,Q4,8) + x4;
    y := ((((((P4[6]*s+P4[5])*s+P4[4])*s+P4[3])*s+P4[2])*s+P4[1])*s+P4[0])/(((((((Q4[7]*s+Q4[6])*s+Q4[5])*s+Q4[4])*s+Q4[3])*s+Q4[2])*s+Q4[1])*s+Q4[0]) + x4;
    zetap := y - 1.0/sc;
  end
  else if s<=7.0 then begin
    s := s-4.0;
    //y := PolEvalX(s,P7,8)/PolEvalX(s,Q7,9);
    y := (((((((P7[7]*s+P7[6])*s+P7[5])*s+P7[4])*s+P7[3])*s+P7[2])*s+P7[1])*s+P7[0])/((((((((Q7[8]*s+Q7[7])*s+Q7[6])*s+Q7[5])*s+Q7[4])*s+Q7[3])*s+Q7[2])*s+Q7[1])*s+Q7[0]);
    zetap := 1.0 + exp_fa(y);
  end
  else if s<15.0 then begin
    s := s-7.0;
    //y := PolEvalX(s,P15,9)/PolEvalX(s,Q15,9);
    y := ((((((((P15[8]*s+P15[7])*s+P15[6])*s+P15[5])*s+P15[4])*s+P15[3])*s+P15[2])*s+P15[1])*s+P15[0])/((((((((Q15[8]*s+Q15[7])*s+Q15[6])*s+Q15[5])*s+Q15[4])*s+Q15[3])*s+Q15[2])*s+Q15[1])*s+Q15[0]);
    zetap := 1.0 + exp_fa(y);
  end
  else if s<42.0 then begin
    s := s-15.0;
    //y := PolEvalX(s,P42,9)/PolEvalX(s,Q42,10);
    y := ((((((((P42[8]*s+P42[7])*s+P42[6])*s+P42[5])*s+P42[4])*s+P42[3])*s+P42[2])*s+P42[1])*s+P42[0])/(((((((((Q42[9]*s+Q42[8])*s+Q42[7])*s+Q42[6])*s+Q42[5])*s+Q42[4])*s+Q42[3])*s+Q42[2])*s+Q42[1])*s+Q42[0]);
    zetap := 1.0 + exp_fa(y);
  end
  else if s<64.0 then zetap := 1.0 + exp2(-s)
  else zetap := 1.0;
end;



function exp2(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Return 2^x}
asm
  fld     [x]                { x                       }
  fld     st(0)              { x | x                   }
  frndint                    { int(x) | x              }
  fxch    st(1)              { x | int(x)              }
  fsub    st(0),st(1)        { frac(x) | int(x)        }
  f2xm1                      { 2^frac(x)-1 | int(x)    }
  fld1                       { 1 | 2^frac(x)-1 | int(x)}
  faddp   st(1),st           { 2^frac(x) | int(x)      }
  fscale                     { 2^z | int(x)            }
  fstp    st(1)
  fwait
end;




function etam1pos(s: extended): extended;
  {-Return the eta(s)-1 = -sum((-1)^k/k^s, k=2..) for s >= -ETAEPS; internal use}

const
  dh: array[2..24] of THexExtW = (
        ($FFA5,$FFFF,$FFFF,$FFFF,$BFFE),  {-0.99999999999999999506430323408864009302707409760650   }
        ($875D,$FFFE,$FFFF,$FFFF,$3FFE),  {+0.99999999999999477309712489986985851567146936528101   }
        ($D5A9,$FEFB,$FFFF,$FFFF,$BFFE),  {-0.99999999999907570687373807736430090108503647599525   }
        ($3E9B,$B83F,$FFFF,$FFFF,$3FFE),  {+0.99999999993474107123666050197526788003473422599175   }
        ($787A,$74E2,$FFF5,$FFFF,$BFFE),  {-0.99999999754516889043092198752546995530922208300482   }
        ($9FF0,$7505,$FF0B,$FFFF,$3FFE),  {+0.99999994306292316806008385807007727156754522290285   }
        ($2930,$A5AA,$F115,$FFFF,$BFFE),  {-0.99999911097044304457819242638771628351284408679994   }
        ($6065,$D3A9,$59D2,$FFFF,$3FFE),  {+0.99999009511126280553264350727993678656849990880578   }
        ($1A12,$43A3,$9FBC,$FFFA,$BFFE),  {-0.99991796823782089316825215441770081101374648485252   }
        ($0A33,$3791,$E44C,$FFDD,$3FFE),  {+0.99947954998748770036508902917665860666132371180327   }
        ($E514,$245E,$659A,$FF56,$BFFE),  {-0.99741206181749538061964608067153326403095105573943   }
        ($5B36,$DD12,$214D,$FD5F,$3FFE),  {+0.98973282004323819299371512908106770568956690464520   }
        ($544C,$0A46,$35FD,$F78F,$BFFE),  {-0.96702897479760824696922362003099562015851811010573   }
        ($E565,$E3A5,$FCA7,$E9C9,$3FFE),  {+0.91323832606180806715735142935851714059264865842761   }
        ($983E,$D706,$464E,$CF8F,$BFFE),  {-0.81077994751742677227759487569665336999099255999308   }
        ($6535,$017E,$D18E,$A766,$3FFE),  {+0.65391263691844299666858829009021366603535356790712   }
        ($6615,$FFBF,$F03A,$EC59,$BFFD),  {-0.46162367553904352979303183031457789989618319051142   }
        ($ED27,$D227,$22A5,$8C88,$3FFD),  {+0.27447613023930715026708917962385218097998528309956   }
        ($838F,$6B07,$85EE,$870D,$BFFC),  {-0.13188752429665086110446620766901353799621544888100   }
        ($9514,$E77C,$BD13,$C796,$3FFA),  {+0.48727739891972228733661913925793276796577280986824e-1}
        ($5449,$F08D,$C274,$D36F,$BFF8),  {-0.12905063533033740943161602774867625818271608663177e-1}
        ($A6BB,$3D4D,$0397,$8E43,$3FF6),  {+0.21707423941183752637782342766808453857479577229903e-2}
        ($1D19,$2582,$5684,$B618,$BFF2)); {-0.17365939152947002110225874213446763085983661783922e-3}
const
  ln2m1h: THexExtW = ($0CA8,$5C61,$D010,$9D1B,$BFFD);  {-3.0685281944005469057E-1}
  lnpi2h: THexExtW = ($AE23,$5098,$D92D,$E735,$3FFC);  {0.2257913526447274323630976} {ln(pi/2)/2}
var
  d: array[2..24] of extended absolute dh;
  p: array[2..24] of extended;
  x,sum: extended;
  k: integer;

begin

  if s=1.0 then begin
    etam1pos := extended(ln2m1h); {ln(2)-1}
    exit;
  end
  else if abs(s) <= ETAEPS then begin
    etam1pos := extended(lnpi2h)*s - 0.5;
    exit;
  end;

  x := -s;

  {Calculate p[k] := 1/k^s but only if necessary. Prime powers are}
  {evaluated with power/exp?, otherwise products of p[k] are used.}
  p[2] := exp2(x);
  if s >= 120.0 then begin
    etam1pos := -p[2];
    exit;
  end;

  p[3] := exp3(x);
  p[4] := p[2]*p[2];
  if s >= 50.0 then begin
    etam1pos := (p[3] - p[4]) - p[2];
    exit;
  end;

  p[10] := exp10(x);
  p[ 5] := p[10]/p[2];
  p[ 6] := p[2]*p[3];
  p[ 7] := exp7(x);
  p[ 8] := p[2]*p[4];
  p[ 9] := p[3]*p[3];
  if s >= 28.0 then begin
    sum := 0.0;
    for k:=10 downto 3 do begin
      if odd(k) then sum := sum + p[k]
      else sum := sum - p[k];
    end;
    etam1pos := sum - p[2];
    exit;
  end;

  p[11] := power_fa(11,x);
  p[12] := p[2]*p[6];
  p[13] := power_fa(13,x);
  p[14] := p[2]*p[7];
  p[15] := p[3]*p[5];
  p[16] := p[2]*p[8];
  p[17] := power_fa(17,x);
  p[18] := p[2]*p[9];
  p[19] := power_fa(19,x);
  p[20] := p[2]*p[10];
  p[21] := p[3]*p[7];
  p[22] := p[2]*p[11];
  if s>=19.5 then begin
    sum := 0.0;
    for k:=22 downto 3 do begin
      if odd(k) then sum := sum + p[k]
      else sum := sum - p[k];
    end;
    etam1pos := sum - p[2];
  end
  else begin
    p[23] := power_fa(23,x);
    p[24] := p[3]*p[8];
    {Convergence acceleration: see P. Borwein[36]}

    {The d[] are from P. Borwein's Algorithm 2, but scaled and shifted.}
    {Calculated with Maple VR4 and T_RCalc/xh using n:=23; Digits:=50; }

    { d(n,k) = n*sum((n+j-1)!*4^j/((n-j)!*(2*j)!),j=0..k); }
    { d[2]   := 1/d(n,n)-1.0;                              }
    { d[i]   := (-1)^(i-2)*(d(n,i-2)/d(n,n)-1), i=3..n+1;  }
    sum := p[24]*d[24];
    for k:=23 downto 3 do sum := sum + d[k]*p[k];
    etam1pos := sum + d[2]*p[2];
  end;
end;


{---------------------------------------------------------------------------}
function exp2m1(x: extended): extended;
  {-Return 2^x-1, accurate even for x near 0}
begin
  if abs(x)<=1 then begin
    {$ifdef BASM}
      asm
        fld   [x]
        f2xm1
        {$ifdef NO_FPU_RESULT}
          fstp   [x]
        {$else}
          fstp   [@result]
        {$endif}
      end;
       {$ifdef NO_FPU_RESULT}
         exp2m1 := x;
       {$endif}
    {$else}
      exp2m1 := powm1(2.0,x);
    {$endif}
  end
  else exp2m1 := exp2(x)-1.0;
end;



function bernpoly_intern(n: integer; x: extended): extended;
  {-Return the Bernoulli polynomial B_n(x), internal use: for small n only}
var
  i: integer;
  s,f: extended;
  ref: boolean;
begin
  if n<0 then bernpoly_intern := 0
  else if n=0 then bernpoly_intern := 1.0
  else if n=1 then bernpoly_intern := x - 0.5
  else begin
    ref := false;
    if abs(x-1.0) <= 0.125 then begin
      {if x is near 1 use NIST[30], 24.4.3: B_n(1-x) = (-1)^n B_n(x)}
      x := 1.0 - x;
      ref := odd(n);
    end;
    {Compute sum NIST[30], 24.2.5}
    f := n;
    s := x - 0.5*n;
    for i:=2 to n do begin
      f := (n+1-i)*f/i;
      s := s*x;
      if i and 1 = 0 then s := s + sfc_bernoulli(i)*f;
    end;
    if ref then s := -s;
    bernpoly_intern := s;
  end;
end;




function hz_a1(s,a: extended; var ok: boolean): extended;
  {-Return zetah(s,a) for a close to 1, s<>1 (normally s < 0)}
var
  x,t,f,z: extended;
  n: integer;
const
  MaxIter = 100;
begin
  hz_a1 := 0.0;
  ok := false;
  {compute sum from NIST[30], 25.11.10}
  z := sfc_zeta(s);
  if IsNanOrInf(z) then exit;
  x := 1.0-a;
  if x<>0.0 then begin
    n := 0;
    f := 1;
    repeat
      f := f*(s+n);
      inc(n);
      t := s+n;
      if (n>MaxIter) or (t=1.0) then exit;
      f := f*x/n;
      t := sfc_zeta(t);
      t := t*f;
      z := z + t;
      {do not use t for exit test because zeta(s+n) may be very small}
    until (abs(f)<=eps_x*abs(z)) and (n>2);
  end;
  ok := true;
  hz_a1 := z;
end;



{---------------------------------------------------------------------------}
function hurwitz_formula(s,a: extended): extended;
  {-Compute zetah with range reduction and Hurwitz formula, a > 0, s < 0}
var
  n,k: longint;
  a2,f,h,r,t,tol,sh,z: extended;
  done: boolean;
const
  MaxIter = 10000;
begin
  r := 0.0;
  z := -s;
  f := frac(a);
  k := trunc(a);
  if f=0.0 then begin
    {Use strict Hurwitz formula with reduced a in (0,1].}
    {Empirically it is valid also for reduced frac(a)=0.}
    f := 1.0;
    k := k-1;
  end;
  a2  := 2.0*f;
  sh  := 2.0*frac(0.25*s);  {sh = s/2 mod 2}
  tol := 0.5*eps_x;
  {NIST [30],25.11.4}
  for n:=0 to k-1 do begin
    t := power_fa(f+n,z);
    r := r + t;
  end;
  h := 0.0;
  {Perform summation only for non-trivial arguments}
  if (frac(a2)<>0.0) or (frac(sh)<>0.0) then begin
    {A. Erdelyi [50], Higher Transcendental Functions I, 1.10 (6),}
    {see also NIST [30], 25.11.9  with s <-> 1-s and cos <-> sin. }
    n := 1;
    z := s-1.0;
    done := false;
    repeat
      t := n*a2 + sh;
      if frac(t)<>0.0 then begin
        //t := sinpi(t);
        t := sinpi_fa(t); {.335}
        f := power_fa(n, z);
        t := t*f;
        h := h + t;
        done := (f < tol*(abs(h) + 1e-10));  {1e-10 addition to avoid exit if h ~ 0}
      end;
      inc(n);
    until done or (n>MaxIter);
    if (n>MaxIter) and (RTE_NoConvergence>0) then RunError(byte(RTE_NoConvergence));
  end;
  if h=0.0 then hurwitz_formula := -r
  else begin
    {compute = 2*h*Gamma(1-s)/(2Pi)^(1-s)}
    z := 1.0 - s;
    if (z>0.0) and (z<MAXGAMX) then begin
      f := sfc_gamma(z);
      t := power_fa(TwoPi, -z);
      t := (t*f)*(2.0*h);
    end
    else begin
      f := sfc_lngamma(z);
      t := ln(abs(2.0*h)) + f - z*ln(TwoPi);
      if t>= ln_MaxExt then t := PosInf_x
      else t := exp_fa(t);
      if h<0.0 then t := -t;
    end;
    hurwitz_formula := t - r;
  end
end;




{---------------------------------------------------------------------------}
function sfc_bernoulli(n: integer): extended;
  {-Return the nth Bernoulli number, 0 if n<0 or odd n >= 3}
var
  bn,p4: extended;
  m: integer;
const
  bx32: array[0..68] of THexExtw = (        {Bernoulli(32*n+128)}
          ($52FD,$BE3D,$B49C,$DA4E,$C178),  {-5.2500923086774133900E+113}
          ($FF69,$87B9,$BE6D,$ABE4,$C209),  {-1.8437723552033869727E+157}
          ($4263,$EB29,$A09A,$A2CC,$C2A3),  {-3.9876744968232207445E+203}
          ($F6AA,$C1D8,$F6B1,$FC3C,$C344),  {-1.8059559586909309014E+252}
          ($B09F,$C9C2,$93E6,$9464,$C3ED),  {-7.9502125045885252855E+302}
          ($9CD8,$18C3,$6CDC,$9557,$C49B),  {-1.9158673530031573512E+355}
          ($4195,$04C1,$073E,$A49C,$C54E),  {-1.6181135520838065925E+409}
          ($739D,$571F,$11CD,$8B25,$C606),  {-3.3538244754399336890E+464}
          ($6270,$777F,$2738,$86CE,$C6C2),  {-1.2747336393845383643E+521}
          ($7FAB,$7570,$F9E6,$EADB,$C781),  {-6.9702671752326436791E+578}
          ($4BFF,$0F88,$1349,$95D1,$C845),  {-4.4656129117005935721E+637}
          ($77B2,$1772,$C601,$EAC7,$C90B),  {-2.8113943110814931668E+697}
          ($215A,$6E86,$91AA,$C206,$C9D5),  {-1.4934073418970347178E+758}
          ($5C7F,$D540,$F299,$9400,$CAA2),  {-5.8578844571843963827E+819}
          ($9A59,$4576,$14FE,$B949,$CB71),  {-1.5084075750891085972E+882}
          ($F479,$B007,$0BB5,$AB72,$CC43),  {-2.2966905497257900647E+945}
          ($C675,$9DA9,$A628,$D590,$CD17),  {-1.8830664597658071289E+1009}
          ($0CCE,$2F96,$B80B,$A49C,$CDEE),  {-7.6426951845750635249E+1073}
          ($3EA8,$63C6,$E69D,$9180,$CEC7),  {-1.4228762140674037692E+1139}
          ($4F15,$2C2F,$CD6C,$899F,$CFA2),  {-1.1338551314597730180E+1205}
          ($3CE2,$FDE0,$5490,$82C2,$D07F),  {-3.6304766452190330209E+1271}
          ($3E25,$B6E8,$D002,$EB8A,$D15D),  {-4.4077763139644032336E+1338}
          ($C753,$F062,$8250,$BEAA,$D23E),  {-1.9238585974016076227E+1406}
          ($0C77,$16EC,$4BAC,$840D,$D321),  {-2.8737803110109338078E+1474}
          ($4BEB,$3C03,$6AAB,$9587,$D405),  {-1.4036962824375857856E+1543}
          ($55C7,$0248,$8353,$84AE,$D4EB),  {-2.1491058465822269708E+1612}
          ($E368,$D032,$65E9,$B163,$D5D2),  {-9.9151825072869898178E+1681}
          ($BDEF,$D7FE,$04EF,$AC37,$D6BB),  {-1.3287264083350159101E+1752}
          ($7A90,$3C2E,$9735,$EA9B,$D7A5),  {-4.9971936871087436659E+1822}
          ($9FC1,$AC12,$A7FA,$D91F,$D891),  {-5.1070475539922579356E+1893}
          ($C234,$DE06,$003E,$8470,$D97F),  {-1.3759818684504019193E+1965}
          ($D312,$510C,$861B,$CEFB,$DA6D),  {-9.4989226808690414704E+2036}
          ($B32D,$A0BE,$8870,$C9B7,$DB5D),  {-1.6356184195123832511E+2109}
          ($F8D5,$2E47,$4E40,$EF06,$DC4E),  {-6.8487492292184253538E+2181}
          ($4706,$AFF3,$6F23,$A81A,$DD41),  {-6.8082216303292659152E+2254}
          ($269B,$331E,$4461,$892E,$DE35),  {-1.5706145196821570477E+2328}
          ($B8F7,$3321,$712A,$FE3E,$DF29),  {-8.2289799425426414984E+2401}
          ($D598,$89BA,$1E5D,$830E,$E020),  {-9.5930887251893861974E+2475}
          ($5173,$0867,$AB5F,$9368,$E117),  {-2.4402644753692194590E+2550}
          ($E63F,$76FF,$2870,$B191,$E20F),  {-1.3295801865055646274E+2625}
          ($F314,$7CE5,$BF4B,$E10C,$E308),  {-1.5244028786126305655E+2700}
          ($C94F,$DECD,$6EC9,$9389,$E403),  {-3.6161842428643845094E+2775}
          ($5940,$BF69,$792C,$C4E9,$E4FE),  {-1.7464299021830195980E+2851}
          ($A1C0,$F220,$16A1,$83B6,$E5FB),  {-1.6907945786261035527E+2927}
          ($92B8,$8BC5,$F001,$AE03,$E6F8),  {-3.2332881196060927594E+3003}
          ($DBF1,$FA98,$71AD,$DFDC,$E7F6),  {-1.2040771662431166519E+3080}
          ($BEF9,$BB8F,$DE3B,$8A4F,$E8F6),  {-8.6141885195778356538E+3156}
          ($D7D6,$F08B,$2222,$A20A,$E9F6),  {-1.1685695524501785594E+3234}
          ($E709,$C538,$6958,$B1BD,$EAF7),  {-2.9684329116433388662E+3311}
          ($9EFA,$77E4,$442C,$B459,$EBF9),  {-1.3950642936150073193E+3389}
          ($9693,$9589,$9A1E,$A753,$ECFC),  {-1.1989884572796487307E+3467}
          ($1F33,$FD26,$C024,$8C5F,$EE00),  {-1.8635271302518619006E+3545}
          ($BFDB,$D0DD,$0E46,$D2AF,$EF04),  {-5.1817804064721174490E+3623}
          ($36A4,$A1D6,$BAE4,$8BF7,$F00A),  {-2.5511413022051873656E+3702}
          ($04E7,$CCC3,$B596,$A2FF,$F110),  {-2.2016594557163485556E+3781}
          ($0B04,$CD7E,$45F3,$A4C4,$F217),  {-3.2985559030415466710E+3860}
          ($E49A,$0504,$EDB4,$8F39,$F31F),  {-8.4995513646331021388E+3939}
          ($9F07,$D98B,$CC09,$D433,$F427),  {-3.7328650389340701819E+4019}
          ($1417,$52A2,$A454,$84CC,$F531),  {-2.7699188001914063216E+4099}
          ($3D97,$75F1,$0EF2,$8B3C,$F63B),  {-3.4434756013646314132E+4179}
          ($198B,$2EA0,$521E,$F293,$F745),  {-7.1133726432191288073E+4259}
          ($A708,$C185,$31CE,$AE2D,$F851),  {-2.4224631302940113182E+4340}
          ($955A,$427F,$7027,$CC98,$F95D),  {-1.3495915388686739922E+4421}
          ($E7A1,$2BA2,$3BF4,$C31E,$FA6A),  {-1.2208793515089649122E+4502}
          ($B45B,$AA6B,$972C,$95FC,$FB78),  {-1.7804374121649736373E+4583}
          ($CB82,$33DD,$DA5B,$B88F,$FC86),  {-4.1563772250412736023E+4664}
          ($90AA,$6E95,$658B,$B48A,$FD95),  {-1.5426825919798643530E+4746}
          ($C03F,$1D53,$D309,$8B77,$FEA5),  {-9.0434733129342411538E+4827}
          ($3D11,$CC1D,$E67F,$A912,$FFB5)); {-8.3194707606651575345E+4909}
begin
  if odd(n) or (n<0) then begin
    if n=1 then sfc_bernoulli := -0.5
    else sfc_bernoulli := 0.0;
  end
  else begin
    m := n div 2;
    if m<=MaxB2nSmall then sfc_bernoulli := extended(B2nHex[m])
    else if n>MaxBernoulli then sfc_bernoulli := PosInf_x
    else begin
      {When n is even, B(2n) = -2*(-1)^n*m!/(2Pi)^m*zeta(m) with m=2n. For }
      {large m (e.g. m>63) zeta(m) is very close to 1 and we can derive the}
      {asymptotic recursion formula B(m+1) = -m*(m+1)/(2Pi)^2 * B(m). The  }
      {avg. iteration count is <4, the max. rel. error=4.5*eps_x for n=878.}
      m  := (n - 112) div 32;
      bn := extended(bx32[m]);
      m  := 32*m + 128;
      p4 := 4.0*PiSqr;
      if n>m then begin
        while n>m do begin
          inc(m,2);
          bn := bn/p4*m*(1-m);
        end;
      end
      else begin
        while m>n do begin
          bn := bn/m/(1-m)*p4;
          dec(m,2);
        end;
      end;
      sfc_bernoulli := bn;
    end;
  end;
end;



{---------------------------------------------------------------------------}
function exp10(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Return 10^x}
const
  lg2_hi: THexDblA = ($00,$00,$80,$50,$13,$44,$D3,$3F);
  lg2_lo: THexDblA = ($2B,$F1,$11,$F3,$FE,$79,$DF,$3D);
asm
  fld     [x]                { x                                                  }
  fldl2t                     { log2(10) | x                                       }
  fmul    st,st(1)           { z = x * log2(10) | x                               }
  frndint                    { int(z) | x                                         }
  fld     qword ptr [lg2_hi] { lg2_hi | int(z) | x                                }
  fmul    st,st(1)           { int(z)*lg2_hi | int(z) | x                         }
  fsubp   st(2),st           { int(z) | x-int(z)*lg2_hi                           }
  fld     qword ptr [lg2_lo] { lg2_lo | int(z) | x-int(z)*lg2_hi                  }
  fmul    st, st(1)          { int(z)*lg2_lo | int(z) | x-int(z)*lg2_hi           }
  fsubp   st(2),st           { int(z) | (x-int(z)*lg2_hi)-int(z)*lg2_lo           }
  fxch    st(1)              { (x-int(z)*lg2_hi)-int(z)*lg2_lo | int(z)           }
  fldl2t                     { log2(10) | (x-int(z)*lg2_hi)-int(z)*lg2_lo | int(z)}
  fmulp   st(1),st           { frac(z) | int(z)                                   }

{$ifndef use_fast_exp}
  {See the exp code for a description of these conditional lines}
  fld     st
  fabs                       { abs(frac(z)) | frac(z) | int(z)                   }
  fld1                       { 1 | abs(frac(z)) | frac(z) | int(z)               }
  fcompp
  fstsw   ax
  sahf
  jae     @@1                { frac(z) <= 1, no special action needed            }
  fld     st(1)              { int(z) | frac(z) | int(z)                         }
  fabs                       { abs(int(z)) | frac(z) | int(z)                    }
  fcomp   [ebig]
  fstsw   ax
  sahf
  jb      @@0
  fsub    st,st              { set frac=0 and scale with too large int(z)}
  jmp     @@1
@@0:
  fmul    dword ptr [half]   { frac(z)/2  | int(z)                               }
  f2xm1                      { 2^(frac(z)/2)-1 | int(z)                          }
  fld     st                 { 2^(frac(z)/2)-1 | 2^(frac(z)/2)-1 | int(z)        }
  fadd    dword ptr [two]    { 2^(frac(z)/2)+1 | 2^(frac(z)/2)-1 | int(z)        }
  fmulp   st(1),st           { 2^frac(z)-1 | int(z)                              }
  jmp     @@2
{$endif}

@@1:
  f2xm1                      { 2^frac(z)-1 | int(z)                              }

@@2:
  fld1                       { 1 | 2^frac(z)-1 | int(z)                          }
  faddp   st(1),st           { 2^frac(z) | int(z)                                }
  fscale                     { 2^z | int(z)                                      }
  fstp    st(1)              { 2^z = 10^x                                         }
  fwait
end;



function exp7(x: extended): extended; assembler; {&Frame-} {&Uses none}
  {-Return 7^x}
const
  l72_hi: THexDblA = ($00,$00,$00,$3A,$19,$CC,$D6,$3F);
  l72_lo: THexDblA = ($C1,$DE,$44,$9C,$36,$D5,$09,$3E);
  log27h: THexExtW = ($66CD,$A021,$B3FA,$B3AB,$4000);  {2.8073549220576041075}
asm
  fld     [x]                { x                                                  }
  fld     tbyte ptr [log27h] { log2(7) | x                                        }
  fmul    st,st(1)           { z = x * log2(7) | x                                }
  frndint                    { int(z) | x                                         }
  fld     qword ptr [l72_hi] { l72_hi | int(z) | x                                }
  fmul    st,st(1)           { int(z)*l72_hi | int(z) | x                         }
  fsubp   st(2),st           { int(z) | x-int(z)*l72_hi                           }
  fld     qword ptr [l72_lo] { l72_lo | int(z) | x-int(z)*l72_hi                  }
  fmul    st, st(1)          { int(z)*l72_lo | int(z) | x-int(z)*l72_hi           }
  fsubp   st(2),st           { int(z) | (x-int(z)*l72_hi)-int(z)*l72_lo           }
  fxch    st(1)              { (x-int(z)*l72_hi)-int(z)*l72_lo | int(z)           }
  fld     tbyte ptr [log27h] { log2(7) | (x-int(z)*l72_hi)-int(z)*l72_lo | int(z) }
  fmulp   st(1),st           { frac(z) | int(z)                                   }

{$ifndef use_fast_exp}
  {See the exp code for a description of these conditional lines}
  fld     st
  fabs                       { abs(frac(z)) | frac(z) | int(z)                   }
  fld1                       { 1 | abs(frac(z)) | frac(z) | int(z)               }
  fcompp
  fstsw   ax
  sahf
  jae     @@1                { frac(z) <= 1, no special action needed            }
  fld     st(1)              { int(z) | frac(z) | int(z)                         }
  fabs                       { abs(int(z)) | frac(z) | int(z)                    }
  fcomp   [ebig]
  fstsw   ax
  sahf
  jb      @@0
  fsub    st,st              { set frac=0 and scale with too large int(z)}
  jmp     @@1
@@0:
  fmul    dword ptr [half]   { frac(z)/2  | int(z)                               }
  f2xm1                      { 2^(frac(z)/2)-1 | int(z)                          }
  fld     st                 { 2^(frac(z)/2)-1 | 2^(frac(z)/2)-1 | int(z)        }
  fadd    dword ptr [two]    { 2^(frac(z)/2)+1 | 2^(frac(z)/2)-1 | int(z)        }
  fmulp   st(1),st           { 2^frac(z)-1 | int(z)                              }
  jmp     @@2
{$endif}

@@1:
  f2xm1                      { 2^frac(z)-1 | int(z)                              }

@@2:
  fld1                       { 1 | 2^frac(z)-1 | int(z)                          }
  faddp   st(1),st           { 2^frac(z) | int(z)                                }
  fscale                     { 2^z | int(z)                                      }
  fstp    st(1)              { 2^z = 7^x                                          }
  fwait
end;



function powm1(x,y: extended): extended;
  {-Return x^y - 1; special code for small x,y}
var
  p: extended;
begin
  if y=0.0 then begin
    powm1 := 0.0;
    exit;
  end;
  if (x>0.0) and ((x<2.0) or (abs(y)<2.0)) then begin
    p := y*ln(x);
    if abs(p) < 4.0 then begin
      powm1 := expm1(p);
      exit;
    end;
  end;
  powm1 := power_fa(x,y)-1.0;
end;


{-------------------------------------------------------------------------------}




function sfc_legendre_p(l: integer; x: extended): extended;
  {-Return P_l(x), the Legendre polynomial/function P_l, degree l}


  function _legendre_p(l: integer; x: extended): extended; assembler;
  const
    c1_5:  double = 1.5;
    c05: double = 0.5;
  var
    MEMk, MEMk1, MEM2k1: Integer;

  asm


  PUSH  EAX  //L
  PUSH  EBX  //2k-1
  PUSH  ECX  //k cycle


//k = 2:
  FLD   tbyte ptr [x]
  FLD   ST(0)
  FLD   ST(0)
  FLD   ST(0)

  FMUL  ST(0), ST(0)
  FMUL  c1_5
  FSUB  c05
  FST   ST(1)  //pk,pk,x,x

  MOV   EAX,L
  MOV   ECX,3 //k=3
  MOV   MEMk,ECX
  MOV   MEMk1,ECX


@cycle:     //k >= 3
  MOV    EBX,ECX
  DEC    dword ptr [MEMk1]
  ADD    EBX,EBX
  FMUL   ST(0),ST(3)
  FXCH   ST(2)
  DEC    EBX    //=2k-1
  MOV    MEM2k1,EBX
  FIMUL  MEMk1
  FXCH   ST(2)
  FIMUL  MEM2k1
  FSUB   ST(0),ST(2)
  FIDIV  MEMk

  INC    ECX

  FXCH   ST(1)
  INC    dword ptr [MEMk]
  FST    ST(2)
  ADD    dword ptr [MEMk1],2
  FXCH   ST(1)
  FST    ST(1)


  CMP    ECX,EAX
  JLE     @cycle

  FSTP   ST(3)
  FSTP   ST(0)
  FSTP   ST(0)


  POP   ECX
  POP   EBX
  POP   EAX



  end;




var
  p0, p1, pk: extended;
  k: integer;
begin
   (*

  if abs(x)=1.0 then begin
    if (x=-1.0) and odd(l) then sfc_legendre_p := -1.0
    else sfc_legendre_p := 1.0;
  end
  else
  begin
    if l<0 then l := -l-1;            {negative degree: HMF[1] 8.2.1}
    {here l >= 0}
    if l=0 then sfc_legendre_p := 1                    {HMF[1] 8.4.1}
    else if l=1 then sfc_legendre_p := x               {HMF[1] 8.4.3}
    else if l=2 then sfc_legendre_p := 1.5*sqr(x)-0.5  {HMF[1] 8.4.5}
    else begin
      if (x=0.0) and odd(l) then sfc_legendre_p := 0.0
      else
      begin


        p0 := 1.0;
        p1 := x;
        {Recurrence relation for varying degree: HMF[1] 8.5.3}
        for k:=2 to l do begin
          pk := ((2*k-1)*x*p1 - (k-1)*p0)/k;
          p0 := p1;
          p1 := pk;
        end;

        sfc_legendre_p := p1;


       //sfc_legendre_p := _legendre_p(l,x);

      end;
    end;
  end;

 *)

 if abs(x)=1.0 then begin
    if (x=-1.0) and odd(l) then sfc_legendre_p := -1.0
    else sfc_legendre_p := 1.0;
  end
  else
  begin
    if l<0 then l := -l-1;            {negative degree: HMF[1] 8.2.1}
    {here l >= 0}
    if l=0 then sfc_legendre_p := 1                    {HMF[1] 8.4.1}
      else
    if l=1 then sfc_legendre_p := x               {HMF[1] 8.4.3}
      else
    if l=2 then sfc_legendre_p := 1.5*sqr(x)-0.5  {HMF[1] 8.4.5}
      else
    if l=3 then sfc_legendre_p := (sqr(x)*2.5-1.5)*x
      else
    if l=4 then sfc_legendre_p := (sqr(x)*4.375-3.75)*sqr(x)+0.375
      else
    if l=5 then sfc_legendre_p := ((sqr(x)*7.875-8.75)*sqr(x)+1.875)*x
      else
    if l=6 then sfc_legendre_p := (((sqr(x)*14.4375-19.6875)*sqr(x)+6.5625))*sqr(x)-0.3125
      else
    if l=7 then sfc_legendre_p := (((sqr(x)*26.8125-43.3125)*sqr(x)+19.6875)*sqr(x)-2.1875)*x
      else
    begin
      if (x=0.0) and odd(l) then sfc_legendre_p := 0.0
      else
      begin

        sfc_legendre_p := _legendre_p(l,x);

      end;
    end;
  end;


end;




function legendre_plmf(l,m: integer; x,f: extended): extended;
  {-Associated Legendre polynomial P_lm(x), f=|1-x^2|^(|m|/2) calculated externally}
var
  p0, p1, pk: extended;
  k: integer;
begin
  {Ref: HMF [1], ch.8; NR [13] ch.6.8; [19] legendre.hpp/legendre_imp}
  if l<0 then l := -l-1; {negative degree: HMF[1] 8.2.1}
  if m<0 then begin
    {Negative order: P(l,-m) = s*(l-m)!/(l+m)! P(l,m), for s see below}
    k := l+m;
    if k<0 then p1 := 0
    else p1 := legendre_plmf(l, -m, x, f);
    if p1<>0.0 then begin

      l := l-m;
      {
      if l<MAXGAMX then p0 := sfc_fac(k)/sfc_fac(l)
      else p0 := sfc_gamma_ratio(k+1, l+1);
      }
           {.335}
      if l<MAXGAMX then p0 := _factorial(k)/_factorial(l)
      else p0 := sfc_gamma_ratio(k+1, l+1);

      if odd(m) and (abs(x)<=1.0) then p1 := -p1*p0
      else p1 := p1*p0;
    end;
    legendre_plmf := p1;
  end
  else if m>l then legendre_plmf := 0.0
  else if m=0 then legendre_plmf := sfc_legendre_p(l,x)
  else begin
    {Starting value p0 = P_mm = (-1)^m * (2m-1)!! * f,  NR[13] 6.8.8}
    //p0 := sfc_dfac(2*m-1)*f;
    p0 := _factorial2(2*m-1)*f;
    if odd(m) and (x<=1.0) then p0 := -p0;
    if m=l then begin
      legendre_plmf := p0;
      exit;
    end;
    p1 := x*p0*(2*m + 1);
    k := succ(m);
    while k<l do begin
      {Recurrence relation for varying degree: HMF[1] 8.5.3}
      pk := ((2*k+1)*x*p1 - (k+m)*p0)/(k+1-m);
      p0 := p1;
      p1 := pk;
      inc(k);
    end;
    legendre_plmf := p1;
  end;
end;





{---------------------------------------------------------------------------}

function sfc_chebyshev_t(n: integer; x: extended): extended;  stdcall;
  {-Return Tn(x), the Chebyshev polynomial of the first kind, degree n}
var
  t0, t1, tk, z, sqrx: extended;
  k: integer;
const
  NTR = 64;
begin
  {T(k+1,x) = 2x*T(k,x) - T(k-1,x);   T(0,x) = 1;   T(1,x) = x}
  {We use the trig/hyp form of Tn to generalize to negative degree: If n<0}
  {define T(-n,x) = T(n,x) because cos(nz) and cosh(nz) are even functions}
  n := abs(n);
  z := abs(x);
  //sqrx:=sqr(x);
  if n=0 then sfc_chebyshev_t := 1.0
  else if n=1 then sfc_chebyshev_t := x

  {.357}
   else
  if n = 2  then  sfc_chebyshev_t := 2*sqr(x)-1
   else
  if n = 3  then  sfc_chebyshev_t := x*(4*sqr(x)-3)
   else
  if n = 4  then  sfc_chebyshev_t := 8*sqr(x)*(sqr(x)-1)+1
   else
  if n = 5  then  sfc_chebyshev_t := ((16*sqr(x)-20)*sqr(x)+5)*x
   else
  if n = 6  then  sfc_chebyshev_t := ((32*sqr(x)-48)*sqr(x)+18)*sqr(x)-1
   else
  if n = 7  then  sfc_chebyshev_t := (((64*sqr(x)-112)*sqr(x)+56)*sqr(x)-7)*x


  else if z=1.0 then begin
    if odd(n) and (x<0.0) then sfc_chebyshev_t := -1.0
    else sfc_chebyshev_t := 1.0
  end
  else if n>NTR then begin
    {use trigonometric/hyperbolic functions if n is large}
    if z<1.0 then sfc_chebyshev_t:= cos_fa(n*arccos_acc(x)) {.335}
    else begin
      {cannot use x < -1 for arccosh, use abs and adjust sign}
      t1 := cosh_fa(n*arccosh_fa(z));
      if odd(n) and (x<0.0) then sfc_chebyshev_t := -t1
      else sfc_chebyshev_t := t1;
    end;
  end
  else begin
    z  := 2.0*x;
    t0 := 1.0;
    t1 := x;
    for k:=2 to n do begin
      tk := z*t1 - t0;
      t0 := t1;
      t1 := tk;
    end;
    sfc_chebyshev_t := t1;
  end;
end;



{---------------------------------------------------------------------------}
(*
function sfc_chebyshev_t(n: integer; x: extended): extended;  stdcall;
  {-Return Tn(x), the Chebyshev polynomial of the first kind, degree n}
var
  t0, t1, tk, z, sqrx: extended;
  k: integer;
const
  NTR = 64;
  c2d: double = 2;
  c3d: double = 3;
  c4d: double = 4;
  c5d: double = 5;
  c7d: double = 7;
  c8d: double = 8;
  c16d: double = 16;
  c18d: double = 18;
  c20d: double = 20;
  c32d: double = 32;
  c48d: double = 48;
  c56d: double = 56;
  c64d: double = 64;
  c112d: double = 112;



   //**********
begin
  {T(k+1,x) = 2x*T(k,x) - T(k-1,x);   T(0,x) = 1;   T(1,x) = x}
  {We use the trig/hyp form of Tn to generalize to negative degree: If n<0}
  {define T(-n,x) = T(n,x) because cos(nz) and cosh(nz) are even functions}
  n := abs(n);
  z := abs(x);

  //tcheb(2,x)

  if n < 8 then
  begin

  {
   asm

      push  eax
      mov   eax,n

      cmp   n,0
      jnz   @@n1
      fld1
      jmp   @@end

    @@n1:
      fld   x
      cmp   n,1
      jnz   @@n2
      jmp   @@end
    @@n2:
      fld   st(0)
      fmul  st(0),st(0)
      cmp   n,2
      jnz   @@n3
      // 2*sqrx-1
      fld1
      fld  c2d
      fmul  st(0),st(2)
      fsubrp st(1),st(0)
      jmp   @@endp
    @@n3:
      cmp   n,3
      jnz   @@n4
      // x*(4*sqrx-3)
      fld  c3d
      fld  c4d
      fmul  st(0),st(2)
      fsubrp st(1),st(0)
      fmul  st(0),st(2)
      jmp   @@endp
    @@n4:
      cmp   n,4
      jnz   @@n5
      //  8*sqrx*(sqrx-1)+1
      fld  c8d
      fld1
      fsubr  st(0),st(2)
      fmulp  st(1),st(0)
      fmul   st(0),st(1)
      fld1
      faddp st(1),st(0)
      jmp   @@endp
    @@n5:
      cmp   n,5
      jnz   @@n6
      // ((16*sqrx-20)*sqrx+5)*x
      fld  c5d
      fld  c20d
      fld  c16d
      fmul   st(0),st(3)
      fsubrp st(1),st(0)
      fmul   st(0),st(2)
      faddp  st(1),st(0)
      fmul   st(0),st(2)
      jmp   @@endp
    @@n6:
      cmp   n,6
      jnz   @@n7
      // ((32*sqrx-48)*sqrx+18)*sqrx-1
      fld  c18d
      fld  c48d
      fld  c32d
      fmul   st(0),st(3)
      fsubrp st(1),st(0)
      fmul   st(0),st(2)
      faddp  st(1),st(0)
      fmul   st(0),st(1)
      fld1
      fsubp st(1),st(0)
      jmp   @@endp
    @@n7:
     // (((64*sqrx-112)*sqrx+56)*sqrx-7)*x
      fld  c7d
      fld  c56d
      fld  c112d
      fld  c64d
      fmul   st(0),st(4)
      fsubrp st(1),st(0)
      fmul   st(0),st(3)
      faddp  st(1),st(0)
      fmul   st(0),st(2)
      fsubrp st(1),st(0)
      fmul   st(0),st(2)

    @@endp:
      fstp  st(1)
      fstp  st(1)

    @@end:

      pop   eax
      fstp  @Result
   end
  }


   if n=0 then sfc_chebyshev_t := 1.0
   else if n=1 then sfc_chebyshev_t := x
   else
   begin
    sqrx:=sqr(x);
    if n = 2  then  sfc_chebyshev_t := 2*sqrx-1
      else
    if n = 3  then  sfc_chebyshev_t := x*(4*sqrx-3)
     else
    if n = 4  then  sfc_chebyshev_t := 8*sqrx*(sqrx-1)+1
     else
    if n = 5  then  sfc_chebyshev_t := ((16*sqrx-20)*sqrx+5)*x
     else
    if n = 6  then  sfc_chebyshev_t := ((32*sqrx-48)*sqrx+18)*sqrx-1
     else
    if n= 7  then  sfc_chebyshev_t := (((64*sqrx-112)*sqrx+56)*sqrx-7)*x
   end;



  end

  else
  if z=1.0 then
  begin
    if odd(n) and (x<0.0) then sfc_chebyshev_t := -1.0
    else sfc_chebyshev_t := 1.0
  end
  else
  if n>NTR then
  begin
    {use trigonometric/hyperbolic functions if n is large}
    if z<1.0 then sfc_chebyshev_t:= cos_fa(n*arccos_acc(x)) {.335}
    else begin
      {cannot use x < -1 for arccosh, use abs and adjust sign}
      t1 := cosh_fa(n*arccosh_fa(z));
      if odd(n) and (x<0.0) then sfc_chebyshev_t := -t1
      else sfc_chebyshev_t := t1;
    end;
  end
  else
  begin
    z  := 2.0*x;
    t0 := 1.0;
    t1 := x;
    for k:=2 to n do begin
      tk := z*t1 - t0;
      t0 := t1;
      t1 := tk;
    end;
    sfc_chebyshev_t := t1;
  end;
end;
*)


{---------------------------------------------------------------------------}
function sfc_chebyshev_u(n: integer; x: extended): extended;  stdcall;
  {-Return Un(x), the Chebyshev polynomial of the second kind, degree n}
var
  u0, u1, uk, z: extended;
  k,n1: integer;
const
  NTR = 64;
begin
  {U(k+1,x) = 2x*U(k,x) - U(k-1,x);   U(0,x) = 1;   U(1,x) = 2x}
  if n<0 then begin
    {We use the trig/hyp form of U_n to generalize to negative degree: If n<0}
    {then sin((n+1)z) = sin((-|n|+1)z) = -sin((|n|-1)z) = -sin(((|n|-2)+1)z) }
    {and a similar argument applies for sinh. So define U(n,x) = -U(-n-2,x). }
    {The only special case is n=-1. Then we have -n-2 = -1 again. Here we can}
    {use sin((n+1)z) = sin(0z) = 0, and therefore U(-1,x) = 0 for all x.}
    if n=-1 then sfc_chebyshev_u := 0.0
    else sfc_chebyshev_u := -sfc_chebyshev_u(-n-2,x);
    exit;
  end;
  n1 := n+1;
  z  := abs(x);
  if n=0 then sfc_chebyshev_u := 1.0
  else if n=1 then sfc_chebyshev_u := 2.0*x

   {.357}
   else
  if n = 2  then  sfc_chebyshev_u := 4*sqr(x)-1
   else
  if n = 3  then  sfc_chebyshev_u := x*(8*sqr(x)-4)
   else
  if n = 4  then  sfc_chebyshev_u := sqr(x)*(16*sqr(x)-12)+1
   else
  if n = 5  then  sfc_chebyshev_u := ((sqr(x)-1)*sqr(x)*32+6)*x
   else
  if n = 6  then  sfc_chebyshev_u := ((64*sqr(x)-80)*sqr(x)+24)*sqr(x)-1
   else
  if n = 7  then  sfc_chebyshev_u := (((128*sqr(x)-192)*sqr(x)+80)*sqr(x)-8)*x



  else if z=1.0 then begin
    if odd(n) and (x<0.0) then sfc_chebyshev_u := -n1
    else sfc_chebyshev_u := n1
  end
  else if n>NTR then begin
    {Use trigonometric/hyperbolic functions if n is large,}
    {calculate U(n, abs(x)) and adjust sign}
    if z<1.0 then begin
      z  := arccos_acc(z);
      u0 := sin_fa(z);  {.335}
      if u0=0.0 then u1 := n1 {u0=0 -> z=0 or Pi -> x ~ 1 or -1}
      else u1 := sin_fa(n1*z)/u0;  {.335}
    end
    else begin
      z  := arccosh_fa(z);
      u0 := sinh_fa(z);
      if u0=0.0 then u1 := n1  {u0=0 -> arccosh(z)=0 -> x ~ +-1}
      else u1 := sinh_fa(n1*z)/u0;
    end;
    if odd(n) and (x<0.0) then sfc_chebyshev_u := -u1
    else sfc_chebyshev_u := u1;
  end
  else begin
    z  := 2.0*x;
    u0 := 1.0;
    u1 := z;
    for k:=2 to n do begin
      uk := z*u1 - u0;
      u0 := u1;
      u1 := uk;
    end;
    sfc_chebyshev_u := u1;
  end;
end;



function sfc_laguerre(n: integer; x: extended): extended;
  {-Return Ln(a,x), the nth generalized Laguerre polynomial with parameter a;}
  { degree n must be >= 0. x >=0 and a > -1 are the standard ranges.}
var
  l0,l1,lk,a1,ax,a: extended;
  k: integer;
begin

a:=0;

  {Recurrence relation, HMF[1] 22.7.12:  L(0,a,x) = 1;  L(1,a,x) = -x+1+a}
  {L(k,a,x) = (2*k+a-1-x)*L(k-1,a,x)/k - (k+a-1)*L(k-2,a,x)/k  for  k > 1}

  if n<=1 then begin
    if n=1 then sfc_laguerre := a+1.0-x
    else if n=0 then sfc_laguerre := 1.0
    else sfc_laguerre := 0.0;
    exit;
  end;

  if (x<0.0) and (a>-1.0) then begin
    {Calculate result via confluent hypergeometric function M.}
    { = binom(a+n,n) * M(-n,a+1,x); see HMF[1] 22.5.54, 13.1.2}
    a1 := a+1.0;
    ax := 1.0;  {binom}
    lk := 1.0;  {kth term of M}
    l1 := lk;   {sum M}
    for k:=0 to n-1 do begin
      {here (k-n)*x > 0, and lk > 0}
      lk := (k-n)/(a1+k)*x/(k+1)*lk;
      l1 := l1 + lk;
      ax := ax*(a1+k)/(k+1);
    end;
    l1 := l1*ax;
  end
  else begin
    {Calculate via standard recurrence relation}
    a1 := a-1.0;
    ax := a1-x;
    l0 := 1.0;
    l1 := a+1.0-x;
    for k:=2 to n do begin
      lk := (2*k+ax)*l1 - (k+a1)*l0;
      l0 := l1;
      l1 := lk/k;
    end;
  end;
  sfc_laguerre := l1;
end;



function sfc_laguerre_a(n: integer; a,x: extended): extended;
  {-Return Ln(a,x), the nth generalized Laguerre polynomial with parameter a;}
  { degree n must be >= 0. x >=0 and a > -1 are the standard ranges.}
var
  l0,l1,lk,a1,ax: extended;
  k: integer;
begin

  {Recurrence relation, HMF[1] 22.7.12:  L(0,a,x) = 1;  L(1,a,x) = -x+1+a}
  {L(k,a,x) = (2*k+a-1-x)*L(k-1,a,x)/k - (k+a-1)*L(k-2,a,x)/k  for  k > 1}

  if n<=1 then begin
    if n=1 then sfc_laguerre_a := a+1.0-x
    else if n=0 then sfc_laguerre_a := 1.0
    else sfc_laguerre_a := 0.0;
    exit;
  end;

  if (x<0.0) and (a>-1.0) then begin
    {Calculate result via confluent hypergeometric function M.}
    { = binom(a+n,n) * M(-n,a+1,x); see HMF[1] 22.5.54, 13.1.2}
    a1 := a+1.0;
    ax := 1.0;  {binom}
    lk := 1.0;  {kth term of M}
    l1 := lk;   {sum M}
    for k:=0 to n-1 do begin
      {here (k-n)*x > 0, and lk > 0}
      lk := (k-n)/(a1+k)*x/(k+1)*lk;
      l1 := l1 + lk;
      ax := ax*(a1+k)/(k+1);
    end;
    l1 := l1*ax;
  end
  else begin
    {Calculate via standard recurrence relation}
    a1 := a-1.0;
    ax := a1-x;
    l0 := 1.0;
    l1 := a+1.0-x;
    for k:=2 to n do begin
      lk := (2*k+ax)*l1 - (k+a1)*l0;
      l0 := l1;
      l1 := lk/k;
    end;
  end;
  sfc_laguerre_a := l1;
end;



{---------------------------------------------------------------------------}
function sfc_hermite_h(n: integer; x: extended): extended;
  {-Return Hn(x), the nth Hermite polynomial, degree n >= 0}
var
  h0,h1,hk: extended;
  k: integer;
begin

  h0 := 1.0;
  h1 := 2.0*x;

  {Recurrence relation, HMF[1] 22.7.13:   H(0,x) = 1, H(1,x) = 2*x}
  {H(k,x) = 2*x*H(k-1,x) - 2*(k-1)*H(k-2,x), for k>1.}
  (*
  if n<=1 then begin
    if n=1 then sfc_hermite_h := h1
    else if n=0 then sfc_hermite_h := h0
    else sfc_hermite_h := 0.0;
    exit;
  end;

  for k:=2 to n do begin
      hk := x*h1 - pred(k)*h0;
      h0 := h1;
      h1 := 2.0*hk;
    end;
  sfc_hermite_h := h1;

  *)

  {.357}
  if n <= 0 then sfc_hermite_h := 0
    else
  if n = 0 then sfc_hermite_h := h0
    else
  if n = 1 then sfc_hermite_h := h1
    else
  if n = 2  then  sfc_hermite_h := 4*sqr(x)-2
   else
  if n = 3  then  sfc_hermite_h := x*(8*sqr(x)-12)
   else
  if n = 4  then  sfc_hermite_h := sqr(x)*(16*sqr(x)-48)+12
   else
  if n = 5  then  sfc_hermite_h := ((32*sqr(x)-160)*sqr(x)+120)*x
   else
  if n = 6  then  sfc_hermite_h := ((64*sqr(x)-480)*sqr(x)+720)*sqr(x)-120
   else
  if n = 7  then  sfc_hermite_h := (((128*sqr(x)-1344)*sqr(x)+3360)*sqr(x)-1680)*x
   else

  begin

    for k:=2 to n do begin
      hk := x*h1 - pred(k)*h0;
      h0 := h1;
      h1 := 2.0*hk;
    end;
    sfc_hermite_h := h1;

  end;


end;





{--------------------------------------------------------------------------------}
{
                     Statistic  functions
}
{--------------------------------------------------------------------------------}




{-----------------------  ERF  --------------------------------------------------------}




function sfc_erf(x: extended): extended;     stdcall;
  {-Return the error function erf(x) = 2/sqrt(Pi)*integral((exp(-t^2), t=0..x)}
begin
  if IsInf(x) then sfc_erf := copysign(1.0,x)
  else if abs(x)<=1 then sfc_erf := erf_small(x)
  else if x > +x0e then sfc_erf := +1.0
  else if x < -x0e then sfc_erf := -1.0
  else sfc_erf := 1.0 - sfc_erfc(x);
end;


function erf_small(x: extended): extended;
  {-Return erf(x) for |x| <= 1}
const
  {erf(x) = x*T(x^2)/U(x^2),  0 <= x <= 1, Peak relative error 7.6e-23}
  THex: array[0..6] of THexExtW = (
          ($c446,$6bab,$0b2a,$86d0,$4013),  {1.104385395713178565288E6}
          ($7a56,$e45a,$a4bd,$975b,$4010),  {1.549905740900882313773E5}
          ($b954,$a987,$c60c,$bc83,$400e),  {4.825977363071025440855E4}
          ($6118,$6059,$9093,$a757,$400a),  {2.677472796799053019985E3}
          ($9517,$4e93,$540e,$8f97,$4007),  {2.871822526820825849235E2}
          ($3128,$c337,$3716,$ace5,$4001),  {5.402980370004774841217E0}
          ($fd7a,$3a1a,$705b,$e0c4,$3ffb)); {1.097496774521124996496E-1}
  UHex: array[0..6] of THexExtW = (
          ($71a7,$1cad,$012e,$eef3,$4012),  {9.787360737578177599571E5}
          ($9ad5,$1aef,$45b1,$e25e,$4011),  {4.636021778692893773576E5}
          ($481d,$445b,$c807,$c232,$400f),  {9.942956272177178491525E4}
          ($ffe8,$9cac,$3b84,$c2ac,$400c),  {1.245905812306219011252E4}
          ($71ac,$b12f,$21ca,$f2e2,$4008),  {9.715333124857259246107E2}
          ($3453,$1f8e,$f688,$b507,$4004),  {4.525777638142203713736E1}
          ($0000,$0000,$0000,$8000,$3fff)); {1.000000000000000000000E0}
var
  z: extended;
  T: array[0..6] of extended absolute THex;
  U: array[0..6] of extended absolute UHex;
begin
  {Ref: Cephes [7], file ldouble\ndtrl.c}
  if x=0.0 then erf_small := x
  else begin
    z := x*x;

    //erf_small := x*PolEvalx(z,T,7)/PolEvalx(z,U,7);
    erf_small := x*((((((T[6]*z+T[5])*z+T[4])*z+T[3])*z+T[2])*z+T[1])*z+T[0])/((((((U[6]*z+U[5])*z+U[4])*z+U[3])*z+U[2])*z+U[1])*z+U[0]);
  end;
end;



function sfc_erfc(x: extended): extended;     stdcall;
  {-Return the complementary error function erfc(x) = 1-erf(x)}
var
  p,q,a,z: extended;
begin
  {expx2 is used to suppress error amplification in computing exp(-x^2)}
  {Ref: Cephes [7], file ldouble\ndtrl.c}
  if IsInf(x) then begin
    sfc_erfc := 1.0-copysign(1.0,x);
    exit;
  end;
  a := abs(x);
  if a < 1.0 then sfc_erfc := 1.0-erf_small(x)
  else if x < -x0e then sfc_erfc := 2.0
  else if x > x1e then sfc_erfc := 0.0
  else begin
    {Here x is in one of the ranges -x0e..-1 or 1..x1e}
    {Compute accurate z = exp(-a^2)}
    z := expx2_fa(-a);
    {Compute p/q := exp(a^2)*erfc(a)}
    sfc_erfc_iusc(a,p,q);
    z := (z*p)/q;
    if x>=0 then sfc_erfc := z
    else sfc_erfc := 2.0-z;
  end;
end;

procedure sfc_erfc_iusc(x: extended; var p,q: extended);
  {-(internal) unevaluated scaled erfc, p/q := exp(x^2)*erfc(x), 1<=x<=128}
const
  {erfc(x) = exp(-x^2)*P(1/x)/Q(1/x), 1/8<=1/x<=1, Peak relative error 5.8e-21}
  PHex: array[0..9] of THexExtW = (
          ($333b,$d9e6,$d404,$986f,$bfee),   {-9.085943037416544232472E-6}
          ($0144,$489e,$be68,$9c31,$4011),   {3.198859502299390825278E5}
          ($3b58,$3da2,$af02,$9780,$4015),   {4.964439504376477951135E6}
          ($5840,$554d,$37a3,$9239,$4018),   {3.833161455208142870198E7}
          ($4e13,$caee,$9e31,$b258,$401a),   {1.870095071120436715930E8}
          ($ada8,$356a,$4982,$94a6,$401c),   {6.234814405521647580919E8}
          ($b6d0,$c92b,$5417,$acb1,$401d),   {1.448651275892911637208E9}
          ($d025,$cfd5,$8494,$88d3,$401e),   {2.295563412811856278515E9}
          ($df23,$d843,$4032,$8881,$401e),   {2.290171954844785638925E9}
          ($4bf0,$9ad8,$7a03,$86c7,$401d));  {1.130609921802431462353E9}
  QHex: array[0..10] of THexExtW = (
          ($24fa,$96f6,$7153,$8a6c,$4012),   {5.669830829076399819566E5}
          ($3708,$33b1,$07fa,$8644,$4016),   {8.799239977351261077610E6}
          ($c4cb,$305a,$bf78,$8220,$4019),   {6.822450775590265689648E7}
          ($a75d,$436f,$30dd,$a027,$401b),   {3.358653716579278063988E8}
          ($c39d,$e415,$c43d,$87c0,$401d),   {1.138778654945478547049E9}
          ($4991,$cfda,$52f1,$a2a9,$401e),   {2.729005809811924550999E9}
          ($00e7,$7595,$cd06,$88bb,$401f),   {4.588018188918609726890E9}
          ($8eae,$8dad,$6eb4,$9aa2,$401f),   {5.188672873106859049556E9}
          ($f817,$9128,$c0f8,$d48b,$401e),   {3.565928696567031388910E9}
          ($0e43,$302d,$79ed,$86c7,$401d),   {1.130609910594093747762E9}
          ($0000,$0000,$0000,$8000,$3fff));  {1.000000000000000000000E0}
const
  {erfc(x) = exp(-x^2)*1/x*R(1/x^2)/S(1/x^2), 1/128<=1/x<1/8, Peak relative error 1.9e-21}
  RHex: array[0..4] of THexExtW = (
          ($22cf,$c711,$6c5b,$dcfb,$3ff9),   {2.697535671015506686136E-2}
          ($521d,$8527,$3435,$8dc2,$3ffe),   {5.537445669807799246891E-1}
          ($0615,$4b00,$575f,$dc7b,$4000),   {3.445028155383625172464E0}
          ($4761,$613e,$df6d,$e58e,$4001),   {7.173690522797138522298E0}
          ($260a,$ab95,$2fc7,$e7c4,$4000));  {3.621349282255624026891E0}
  SHex: array[0..5] of THexExtW = (
          ($f5af,$2fb2,$1e57,$c3d7,$3ffa),   {4.781257488046430019872E-2}
          ($3684,$3798,$b793,$80b0,$3fff),   {1.005392977603322982436E0}
          ($b611,$8f76,$f020,$d255,$4001),   {6.572990478128949439509E0}
          ($55d5,$d300,$e71e,$f564,$4002),   {1.533713447609627196926E1}
          ($5de6,$17d7,$54d6,$aba9,$4002),   {1.072884067182663823072E1}
          ($0000,$0000,$0000,$8000,$3fff));  {1.000000000000000000000E0}
var
  PP: array[0..9]  of extended absolute PHex;
  QQ: array[0..10] of extended absolute QHex;
  RR: array[0..4]  of extended absolute RHex;
  SS: array[0..5]  of extended absolute SHex;
var
  y: extended;
begin
  {Ref: Cephes [7], file ldouble\ndtrl.c}
  y := 1.0/x;
  if x<8.0 then
  begin
    {p := PolEvalx(y,PP,10);
    q := PolEvalx(y,QQ,11); }

    p:=(((((((((PP[9]*y+PP[8])*y+PP[7])*y+PP[6])*y+PP[5])*y+PP[4])*y+PP[3])*y+PP[2])*y+PP[1])*y+PP[0]);
    q:=((((((((((QQ[10]*y+QQ[9])*y+QQ[8])*y+QQ[7])*y+QQ[6])*y+QQ[5])*y+QQ[4])*y+QQ[3])*y+QQ[2])*y+QQ[1])*y+QQ[0]);
  end
  else
  begin
    q := y*y;

    {p := y*PolEvalx(q,RR,5);
    q := PolEvalx(q,SS,6);}

    p := y*((((RR[4]*q+RR[3])*q+RR[2])*q+RR[1])*q+RR[0]);
    q := (((((SS[5]*q+SS[4])*q+SS[3])*q+SS[2])*q+SS[1])*q+SS[0]);


  end;
end;




function sfc_erfc_inv(x: extended): extended;    stdcall;
  {-Return the inverse function of erfc, erfc(erfc_inv(x)) = x, 0 < x < 2}
begin
  {Ref: Boost [19], erf_inv.hpp/erfc_inv}
  if IsNanOrInf(x) or (x<=0) or (x>=2.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_erfc_inv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if x>1.0 then sfc_erfc_inv := -inverror(x-1.0, 2.0-x)
  else sfc_erfc_inv := inverror(1.0-x, x)
end;



function sfc_erf_inv(x: extended): extended;  stdcall;
  {-Return the inverse function of erf, erf(erf_inv(x)) = x, -1 < x < 1}
begin
  {Ref: Boost [19], erf_inv.hpp/erf_inv}
  if IsNanOrInf(x) or (abs(x) >=1) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_erf_inv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if x < 0.0 then sfc_erf_inv := -inverror(-x, 1.0+x)
  else sfc_erf_inv := inverror(x, 1.0-x)
end;







procedure sfc_erfCx(z: complex);    stdcall;
var
 w: complex;
begin

  cerf(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;

end;




procedure sfc_erfcCx(z: complex);    stdcall;
var
 w: complex;
begin

  cerfc(z,w);
  asm
    fld tbyte ptr [w.im]
    fld tbyte ptr [w.re]
  end;

end;



procedure cerf(const z: complex; var w: complex);
  {-Return the complex error function w = erf(z) = 2/sqrt(Pi)*integral((exp(-t^2), t=0..z)}
var
  u: complex;
const
  nt = 8;
  ctsh: array[0..nt-1] of THexExtW = (
         ($688D,$14DB,$BA82,$906E,$3FFF),  { 1.1283791670955125738961589031215451717e+00}
         ($3612,$1BCF,$A358,$C093,$BFFD),  {-3.7612638903183752463205296770718172390e-01}
         ($0DAF,$215F,$90D0,$E717,$3FFB),  { 1.1283791670955125738961589031215451717e-01}
         ($86F0,$445A,$7189,$DC16,$BFF9),  {-2.6866170645131251759432354836227265993e-02}
         ($F72C,$3529,$E687,$AB2D,$3FF7),  { 5.2239776254421878421118467737108572763e-03}
         ($2C4D,$205C,$DA00,$E016,$BFF4),  {-8.5483270234508528325466583569814028158e-04}
         ($BBD3,$DC4D,$937C,$FCD1,$3FF1),  { 1.2055332981789664251027338708563516792e-04}
         ($5AF3,$0617,$2E1F,$FA69,$BFEE)); {-1.4925650358406250977462419353459592218e-05}
      (* ($1404,$328D,$64EE,$DCF3,$3FEB),  { 1.6462114365889247401612962522198079652e-06}
         ($CF8B,$1F38,$1762,$AFBA,$BFE8),  {-1.6365844691234924317393003677039026555e-07}
         ($DE6D,$1260,$B903,$FE62,$3FE4),  { 1.4807192815879217239546050945892452597e-08}
         ($6424,$2E9B,$8C0E,$A8EB,$BFE1),  {-1.2290555301717927352982888136906778836e-09}
         ($7E41,$AD39,$6AF2,$CF35,$3FDD),  { 9.4227590646504109706202142382951971074e-11}
         ($4EF7,$6237,$9E58,$EC22,$BFD9)); {-6.7113668551641103779346255258512799910e-12} *)
var
  cts: array[0..nt-1] of extended absolute ctsh;
begin
  {Ref: archive gamerf.zip, file gamerf2a.f, function cqerf(x)}
  {Gamma / Error Functions in Fortran, (C) 1996 Takuya OOURA  }
  {http://www.kurims.kyoto-u.ac.jp/~ooura/gamerf.html}
  if abs(z.re)+abs(z.im) <= 0.125 then begin
    {Use Taylor series}
    csqr(z,u);
    cpolyr_f(u,cts,nt,u);
    cmul_f(z,u,w);
  end
  else begin
    {Use erf(z) = 1-erfc(z)}
    if z.re >= 0.0 then begin
      cerfc(z,u);
      w.re := 1.0 - u.re;
      w.im := -u.im;
    end
    else begin
      u.re := -z.re;
      u.im := -z.im;
      cerfc(u,w);
      w.re := w.re - 1.0;
    end;
  end;
end;




procedure cerfc(const z: complex; var w: complex);
  {-Return the complex complementary error function w = erfc(z) = 1-erf(z)}
const
  ph  = 9.4599403715183963963159646240033837464;
  pvh : THexExtW = ($7181,$5C81,$EA6F,$935B,$4003);  {1.8419880743036792792631929248006767493e+01}

const
  npq = 19;
  nrs = 19;

  p: array[0..npq] of THexExtW = (
       ($35B3,$DCE9,$406C,$D7FE,$3FFC),  {2.1093083061644187538279122968913808152e-01}
       ($FC21,$7134,$37EF,$AB26,$3FFC),  {1.6713797949733065528971052035163045322e-01}
       ($F5A0,$CABF,$5275,$D6EB,$3FFB),  {1.0494102880451803704489103456267864462e-01}
       ($9C3C,$4456,$C271,$D5D9,$3FFA),  {5.2209624806229062497556308453704817574e-02}
       ($E50B,$6277,$EA0A,$A89B,$3FF9),  {2.0582158194044619069754225289969978299e-02}
       ($2F46,$AE5A,$34B7,$D2AD,$3FF7),  {6.4293391618431334949721030322694803569e-03}
       ($DA5B,$E504,$36F7,$D096,$3FF5),  {1.5913908100149480106505036886507485785e-03}
       ($A402,$C4CB,$1E53,$A3A4,$3FF3),  {3.1212060500464898607481297780989148689e-04}
       ($33B7,$FF6B,$D6D3,$CB73,$3FF0),  {4.8506855193831619356742051276480109919e-05}
       ($7A7E,$9646,$CB6B,$C86E,$3FED),  {5.9733626677651815061875193953000538326e-06}
       ($EE6F,$D48E,$56F3,$9C76,$3FEA),  {5.8286735523223186734841193923199386322e-07}
       ($36E7,$A7DE,$59A6,$C18F,$3FE6),  {4.5066690471880700341073630648957059945e-08}
       ($EF29,$5DD7,$2CDC,$BDBD,$3FE2),  {2.7610653454261808871589140980422088532e-09}
       ($52EA,$6A6D,$C3A5,$9360,$3FDE),  {1.3403949680961254958324655659147790094e-10}
       ($00B3,$9FA0,$4D91,$B56A,$3FD9),  {5.1561314110869289752886735305964573946e-12}
       ($9555,$C277,$24F8,$B0F3,$3FD4),  {1.5716297853674992841622413214543994197e-13}
       ($1E75,$1817,$BE63,$88C2,$3FCF),  {3.7958724379391814374198930599398267061e-15}
       ($5428,$6FDA,$44C7,$A782,$3FC9),  {7.2645388829894728683842661597496303959e-17}
       ($71E6,$2119,$C57B,$A292,$3FC3),  {1.1016397065175311063529497475707242525e-18}
       ($FAFF,$74F2,$A79A,$FA0C,$3FBC)); {1.3237506731591609005566634525737840832e-20}
    (* ($02CB,$6C9F,$720C,$985F,$3FB6),  {1.2603985415835627864680027724651354389e-22}
       ($CAAC,$D34F,$E1DC,$9325,$3FAF),  {9.5092151781247278003169665785149729821e-25}
       ($F481,$FA1F,$E68D,$E132,$3FA7),  {5.6848177046496801634666761604409403206e-27}
       ($0829,$F773,$1A88,$888C,$3FA0),  {2.6929202705338711046737832028758053393e-29}
       ($291A,$057F,$9D59,$8335,$3F98),  {1.0108006977320702265677957534508423789e-31}
       ($51FE,$82D1,$C2FB,$C7CE,$3F8F),  {3.0063715680065086923565072577882673057e-34}
       ($2748,$B606,$3000,$F119,$3F86)); {7.0852448481490904907112832127691803349e-37} *)

  q: array[0..npq] of THexExtW = (
       ($F922,$A2DA,$ADC9,$EE4B,$3FF9),  {2.9088820866572159615394846141476878557e-02}
       ($2C23,$6B9B,$91C1,$860A,$3FFD),  {2.6179938779914943653855361527329190702e-01}
       ($12A3,$873B,$1FC5,$BA2B,$3FFE),  {7.2722052166430399038487115353692196393e-01}
       ($A6BE,$60AF,$F10E,$B671,$3FFF),  {1.4253522224620358211543474609323670493e+00}
       ($91A8,$990E,$E3F9,$96CB,$4000),  {2.3561944901923449288469825374596271631e+00}
       ($FF82,$9BF2,$8A48,$E143,$4000),  {3.5197473248552313134627763831187023054e+00}
       ($8E78,$1C82,$F5BA,$9D4F,$4001),  {4.9160107264506949750017289979095924762e+00}
       ($74F7,$3822,$83BE,$D170,$4001),  {6.5449846949787359134638403818322976754e+00}
       ($99A0,$506C,$B798,$8681,$4002),  {8.4066692304393541288491105348868179031e+00}
       ($64A9,$AB53,$5C08,$A804,$4002),  {1.0501064332832549621157539457073153159e+01}
       ($9B96,$2CC5,$2F30,$CD40,$4002),  {1.2828170002158322390389127148391303444e+01}
       ($3E68,$D4C3,$310E,$F635,$4002),  {1.5387986238416672436543873608841268757e+01}
       ($268F,$51A6,$B0D2,$9171,$4003),  {1.8180513041607599759621778838423049098e+01}
       ($63DD,$CC30,$6078,$A9A5,$4003),  {2.1205750411731104359622842837136644468e+01}
       ($571C,$DA00,$A77A,$C3B5,$4003),  {2.4463698348787186236547065604982054867e+01}
       ($004E,$7B16,$85D8,$DFA2,$4003),  {2.7954356852775845390394447141959280294e+01}
       ($5F73,$AF71,$FB91,$FD6B,$4003),  {3.1677725923697081821164987448068320749e+01}
       ($3A45,$3B89,$0453,$8E89,$4004),  {3.5633805561550895528858686523309176233e+01}
       ($9FC9,$68FC,$568B,$9F4A,$4004),  {3.9822595766337286513475544367681846745e+01}
       ($E046,$6012,$F471,$B0F9,$4004)); {4.4244096538056254775015560981186332286e+01}
    (* ($FBBD,$20CB,$DE05,$C397,$4004),  {4.8898307876707800313478736363822632855e+01}
       ($F22D,$AB27,$1346,$D724,$4004),  {5.3785229782291923128865070515590748453e+01}
       ($C396,$FF26,$9435,$EB9E,$4004),  {5.8904862254808623221174563436490679079e+01}
       ($37FC,$8E64,$B069,$8083,$4005),  {6.4257205294257900590407215126522424733e+01}
       ($7BAA,$0206,$3C8F,$8BAF,$4005),  {6.9842258900639755236563025585685985416e+01}
       ($2CD4,$5A7A,$EE8B,$9751,$4005),  {7.5660023073954187159641994813981361128e+01}
       ($4B7A,$97BF,$C65E,$A36B,$4005)); {8.1710497814201196359644122811408551868e+01} *)

  r: array[0..nrs] of THexExtW = (
       ($636C,$A6CB,$5190,$DE5E,$3FFB),  {1.0857833597842664924141880507518822324e-01}
       ($5077,$F4BE,$7839,$C5F1,$3FFC),  {1.9330394605384376865851659517702988226e-01}
       ($DE3D,$8D04,$5D17,$8B9E,$3FFC),  {1.3634629684679999083131393208557974008e-01}
       ($0C27,$A592,$253F,$9C11,$3FFB),  {7.6204577450604403788088248675471849578e-02}
       ($C190,$BCEA,$D116,$8A3B,$3FFA),  {3.3748451951221171387030636574487677141e-02}
       ($9675,$0334,$24B1,$C209,$3FF8),  {1.1843000251292400843913857684704052043e-02}
       ($804E,$9F7B,$05D9,$D7D1,$3FF6),  {3.2930983812757205929921213829383580821e-03}
       ($E548,$4516,$9068,$BE34,$3FF4),  {7.2557574646222760967368809292892366817e-04}
       ($44F3,$C096,$738E,$84D4,$3FF2),  {1.2667645289367856821531300675005701424e-04}
       ($2D14,$6BD1,$720A,$9301,$3FEF),  {1.7524438664090954799894562703988992670e-05}
       ($3FC8,$EF68,$8876,$80EA,$3FEC),  {1.9210002539217758384351411001702958461e-06}
       ($A1C5,$A41F,$72EE,$B329,$3FE8),  {1.6685753127194156512431242433234203465e-07}
       ($627C,$C324,$E053,$C54B,$3FE4),  {1.1484161468186100454021914187739990566e-08}
       ($8725,$2B47,$7F1A,$AC28,$3FE0),  {6.2630784459909945721312231747915945961e-10}
       ($3DAF,$78E5,$72C7,$EE11,$3FDB),  {2.7065216004464856039123247342635784082e-11}
       ($43A6,$1ACD,$4649,$826E,$3FD7),  {9.2676629018209927646524369276088075961e-13}
       ($FC2D,$7203,$141C,$E27E,$3FD1),  {2.5145718215575387941885792873856026053e-14}
       ($5C58,$E57A,$CAC1,$9BD2,$3FCC),  {5.4062104214337911880413049229210178595e-16}
       ($C947,$0EC1,$B99A,$A9E4,$3FC6),  {9.2099427616964263777001122276945386232e-18}
       ($1215,$02D1,$B657,$92C6,$3FC0)); {1.2432429403206980797482152563988923532e-19}
    (* ($507D,$2A6B,$996B,$C8F4,$3FB9),  {1.3298117235769445146920469835700830835e-21}
       ($9A45,$9A76,$E582,$DA02,$3FB2),  {1.1270920794418483512403852639398106151e-23}
       ($5BAB,$5A80,$05D2,$BB69,$3FAB),  {7.5694395178532891627960685040600391752e-26}
       ($262E,$EA8D,$181D,$FF50,$3FA3),  {4.0281268032076992671072314251173518774e-28}
       ($710E,$5E26,$7225,$89CD,$3F9C),  {1.6985472346741765564942981815307583270e-30}
       ($D70E,$253D,$EAB0,$EBBD,$3F93),  {5.6752788970027027984246568768226680280e-33}
       ($E6D3,$C52A,$941F,$9FC7,$3F8B)); {1.5025601745064174185565587049015131885e-35} *)

  s: array[0..nrs] of THexExtW = (
       ($0000,$0000,$0000,$0000,$0000),  {0                                          }
       ($F922,$A2DA,$ADC9,$EE4B,$3FFB),  {1.1635528346628863846157938456590751423e-01}
       ($F922,$A2DA,$ADC9,$EE4B,$3FFD),  {4.6542113386515455384631753826363005692e-01}
       ($2C23,$6B9B,$91C1,$860A,$3FFF),  {1.0471975511965977461542144610931676281e+00}
       ($F922,$A2DA,$ADC9,$EE4B,$3FFF),  {1.8616845354606182153852701530545202277e+00}
       ($12A3,$873B,$1FC5,$BA2B,$4000),  {2.9088820866572159615394846141476878557e+00}
       ($2C23,$6B9B,$91C1,$860A,$4001),  {4.1887902047863909846168578443726705123e+00}
       ($A6BE,$60AF,$F10E,$B671,$4001),  {5.7014088898481432846173898437294681972e+00}
       ($F922,$A2DA,$ADC9,$EE4B,$4001),  {7.4467381418424728615410806122180809107e+00}
       ($91A8,$990E,$E3F9,$96CB,$4002),  {9.4247779607693797153879301498385086526e+00}
       ($12A3,$873B,$1FC5,$BA2B,$4002),  {1.1635528346628863846157938456590751423e+01}
       ($FF82,$9BF2,$8A48,$E143,$4002),  {1.4078989299420925253851105532474809222e+01}
       ($2C23,$6B9B,$91C1,$860A,$4003),  {1.6755160819145563938467431377490682049e+01}
       ($8E78,$1C82,$F5BA,$9D4F,$4003),  {1.9664042905802779900006915991638369905e+01}
       ($A6BE,$60AF,$F10E,$B671,$4003),  {2.2805635559392573138469559374917872789e+01}
       ($74F7,$3822,$83BE,$D170,$4003),  {2.6179938779914943653855361527329190702e+01}
       ($F922,$A2DA,$ADC9,$EE4B,$4003),  {2.9786952567369891446164322448872323643e+01}
       ($99A0,$506C,$B798,$8681,$4004),  {3.3626676921757416515396442139547271612e+01}
       ($91A8,$990E,$E3F9,$96CB,$4004),  {3.7699111843077518861551720599354034610e+01}
       ($64A9,$AB53,$5C08,$A804,$4004)); {4.2004257331330198484630157828292612637e+01}
    (* ($12A3,$873B,$1FC5,$BA2B,$4004),  {4.6542113386515455384631753826363005692e+01}
       ($9B96,$2CC5,$2F30,$CD40,$4004),  {5.1312680008633289561556508593565213775e+01}
       ($FF82,$9BF2,$8A48,$E143,$4004),  {5.6315957197683701015404422129899236887e+01}
       ($3E68,$D4C3,$310E,$F635,$4004),  {6.1551944953666689746175494435365075027e+01}
       ($2C23,$6B9B,$91C1,$860A,$4005),  {6.7020643276582255753869725509962728196e+01}
       ($268F,$51A6,$B0D2,$9171,$4005),  {7.2722052166430399038487115353692196393e+01}
       ($8E78,$1C82,$F5BA,$9D4F,$4005)); {7.8656171623211119600027663966553479619e+01} *)

var
  x,y,t,u,v,a: complex;
  i: integer;
  re0,im0: boolean;
begin
  {Ref: archive gamerf.zip, file gamerf2a.f, function cqerfc(x)}
  {Gamma / Error Functions in Fortran, (C) 1996 Takuya OOURA   }
  {http://www.kurims.kyoto-u.ac.jp/~ooura/gamerf.html}

  {Re z=0 -> Re w = 1, Im z=0 -> Im w = 0}
  re0 := z.re=0.0;
  im0 := z.im=0.0;
  if im0 then begin
    w.im := 0.0;
    if re0 then begin
      w.re := 1.0;
      exit;
    end
    else if z.re < -x0e  then begin
      w.re := 2.0;
      exit;
    end
    else if z.re > x1e then begin
      w.re := 0.0;
      exit;
    end;
  end;

  csqr(z,y);
  v.re := 0.0;
  v.im := 0.0;
  u.im := y.im;
  t.re := -y.re;
  t.im := -y.im;
  cexp_fa(t, x);
  cmul_f(x,z,x);

  if abs(z.re)+abs(z.im) <= ph then begin
    t.re := extended(pvh)*z.re;
    t.im := extended(pvh)*z.im;
    cexp_fa(t,a);
    if a.re >= 0.0 then begin
      for i:=npq downto 0 do begin
        u.re := y.re + extended(q[i]);
        rdivc_fa(extended(p[i]), u, t);
        v.re := v.re + t.re;
        v.im := v.im + t.im;
      end;
      a.re := a.re + 1.0;
      rdivc_fa(2.0,a,t);
    end
    else begin
      for i:=nrs downto 0 do begin
        u.re := y.re + extended(s[i]);
        rdivc_fa(extended(r[i]), u, t);
        v.re := v.re + t.re;
        v.im := v.im + t.im;
      end;
      a.re := a.re - 1.0;
      rdivc_fa(-2.0,a,t);
    end;
    cmul_f(v,x,u);
    w.re := u.re + t.re;
    w.im := u.im + t.im;
  end
  else begin
    for i:=npq downto 0 do begin
      u.re := y.re + extended(q[i]);
      rdivc_fa(extended(p[i]), u, t);
      v.re := v.re + t.re;
      v.im := v.im + t.im;
    end;
    if z.re >= 0.0 then cmul_f(x,v,w)
    else begin
      cmul_f(x,v,w);
      w.re := w.re + 2.0;
    end;
  end;
  if re0 then w.re := 1.0;
  if im0 then w.im := 0.0;
end;



{----------------- Distributions & Probabilities -------------------------------}


function BinomialC(n,k: integer): extended; stdcall;
begin

{.357}

 if   (n <= SizeBinomC) and (k <= SizeBinomC) then    BinomialC:=BinomC[n,k]
      else
   if (n < NumberFact) and (k < NumberFact) then      BinomialC:=_factorial(n)/(_factorial(k)*_factorial(n-k))
      else                                            BinomialC:=sfc_binomial(n,k);


  (*
if F_FastSpec = True then
begin
   if (n <= SizeBinomC) and (k <= SizeBinomC) then    BinomialC:=BinomC[n,k]
      else
   if (n < NumberFact) and (k < NumberFact) then      BinomialC:=_factorial(n)/(_factorial(k)*_factorial(n-k))
      else                                            BinomialC:=sfc_binomial(n,k);
end
else
begin
   BinomialC:=sfc_binomial(n,k);
end;
*)

end;




function DistBinomial(k, n: longint; p: extended): extended;  stdcall;
begin
 if F_FastSpec = True then
 begin
     if (k < 0) or (k > n) then DistBinomial:= 0.0
      else
     if n = 0 then              DistBinomial:= 1.0
      else
                                DistBinomial:=BinomialC(n,k)*IntPower_f(p,k)*IntPower_f(1-p,n-k)
 end
 else
 begin
     DistBinomial:=sfc_binomial_pmf(p,n,k);
 end;

end;


{
function DistBinomial(p: extended; n, k: longint): extended;  stdcall;
begin
 if F_FastSpec = True then
 begin
     if (k < 0) or (k > n) then DistBinomial:= 0.0
      else
     if n = 0 then              DistBinomial:= 1.0
      else
                                DistBinomial:=BinomialC(n,k)*IntPower(p,k)*IntPower(1-p,n-k)
 end
 else
 begin
     DistBinomial:=sfc_binomial_pmf(p,n,k);
 end;

end;
}



//function DistPoisson(mu: extended; k: longint): extended;  stdcall;
function DistPoisson(k: longint; mu: extended): extended;  stdcall;
begin
     {.357}
 if k < 0.0 then DistPoisson := 0.0
     else
    if mu = 0.0 then
    begin
      if k = 0 then DistPoisson := 1.0
      else DistPoisson := 0.0;
    end
    else
    begin
      if k < NumberFact then
           DistPoisson:=IntPower_f(mu,k)*exp_f(-mu)/_factorial(k)
      else
           DistPoisson:=sfc_poisson_pmf(mu,k);
    end;

(*
 if F_FastSpec = True then
 begin

    if k < 0.0 then DistPoisson := 0.0
     else
    if mu = 0.0 then
    begin
      if k = 0 then DistPoisson := 1.0
      else DistPoisson := 0.0;
    end
    else
    begin
      if k < NumberFact then
           DistPoisson:=IntPower_f(mu,k)*exp_f(-mu)/_factorial(k)
      else
           DistPoisson:=sfc_poisson_pmf(mu,k);
    end;

 end

 else
 begin
     DistPoisson:=sfc_poisson_pmf(mu,k);
 end;
 *)


end;





//function DistNormal(mu, sd, x: extended): extended; stdcall;
function DistNormal(x, mu, sd: extended): extended; stdcall;
begin
 if F_FastSpec = True then
 begin
     DistNormal := Cdn/sd*exp_f(-sqr((x-mu)/sd)*0.5);
 end
 else
 begin
     DistNormal:=sfc_normal_pdf(mu, sd, x);
 end;

end;





//function DistHyperGeom(n1,n2,n,k: longint): extended; stdcall;
function DistHyperGeom(k1,N,K,n1: longint): extended; stdcall;
begin

 if (k1 > N) or (K > N) or (n1 > N) or (k1 > K) or (n1-k1 > N-K) then
    DistHyperGeom := 0.0
 else
    DistHyperGeom := BinomialC(K,K1)*BinomialC(N-K,n1-k1)/BinomialC(N,n1);

end;



{
n1,n2,n,k = k N D n
BinomialC(n,n1)*BinomialC(n2-n,k-n1)/BinomialC(n2,k);
}
(*
function DistHyperGeom(n1,n2,n,k: longint): extended; stdcall;
begin


 if F_FastSpec = True then
 begin
     DistHyperGeom := BinomialC(n,n1)*BinomialC(n2-n,k-n1)/BinomialC(n2,k);
 end
 else
 begin
     //DistHyperGeom:=sfc_hypergeo_pmf(n1,n2,n,k);
      // DistHyperGeom:=sfc_hypergeo_pmf(n,k,n1,n2);
     // DistHyperGeom:=sfc_hypergeo_pmf(n2,n1,k,n);
    //DistHyperGeom:=sfc_hypergeo_pmf(k,n,n2,n1);
    //DistHyperGeom:=sfc_hypergeo_pmf(n,n1,n2,k);
    //DistHyperGeom:=sfc_hypergeo_pmf(n,n1,k,n2);
    //DistHyperGeom:=sfc_hypergeo_pmf(k,n2,n,n1);
   //  DistHyperGeom:=sfc_hypergeo_pmf(k,n1,n,n2);
    //  DistHyperGeom:=sfc_hypergeo_pmf(k,n1,n2,n);
     //DistHyperGeom:=sfc_hypergeo_pmf(k,n,n2,n1);
      DistHyperGeom:=sfc_hypergeo_pmf(k,n,n1,n2);
 end;

end;
 *)





//function sfc_binomial_cdf(p: extended; n, k: longint): extended;  stdcall;
function sfc_binomial_cdf(k, n: longint; p: extended): extended;  stdcall;
  {-Return the cumulative binomial distribution function with number}
  { of trials n >= 0 and success probability 0 <= p <= 1}
begin
  if (p < 0.0) or (p > 1.0) or (n < 0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_binomial_cdf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if k<0 then sfc_binomial_cdf := 0.0
  else if (k>=n) or (p=0.0) then sfc_binomial_cdf := 1.0
  else sfc_binomial_cdf := sfc_ibeta(n-k,k+1,1.0-p)
end;




function sfc_poisson_cdf(k: longint; mu: extended): extended;   stdcall;
  {-Return the cumulative Poisson distribution function with mean mu >= 0}
begin
  if mu < 0.0 then begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_poisson_cdf := NaN_x;
    exit;
  end;
  if k<0.0 then sfc_poisson_cdf := 0.0
  else if mu=0.0 then sfc_poisson_cdf := 1.0
  else sfc_poisson_cdf := sfc_igammaq(k+1,mu);
end;





function sfc_normal_cdf(x, mu, sd: extended): extended; stdcall;
  {-Return the normal (Gaussian) distribution function}
  { with mean mu and standard deviation sd > 0        }
begin
  if sd <= 0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_normal_cdf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  sfc_normal_cdf := sfc_erf_p((x-mu)/sd);
end;





function sfc_maxwell_pdf(x, b: extended): extended;  stdcall;
  {-Return the Maxwell probability density function with scale b > 0, x >= 0}
var
  y: extended;
const
  sqrt2_pi = 0.797884560802865355879892119869;  {sqrt(2/Pi)}
begin

  if (b <= 0.0) or (x < 0.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_maxwell_pdf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  {pdf = sqrt(2/Pi) * x^2/b^3 * exp(-0.5*(x/b)^2)}
  x := x/b;
  if x >= Sqrt_MaxExt then sfc_maxwell_pdf := 0.0
  else begin
    y := exp_fa(-0.5*sqr(x));
    y := y*sqr(x)*sqrt2_pi;
    sfc_maxwell_pdf := y/b;
  end;



end;




{
https://mathworld.wolfram.com/MaxwellDistribution.html
https://simple.wikipedia.org/wiki/Maxwell%E2%80%93Boltzmann_distribution
 }

function sfc_maxwell_cdf(x, b: extended): extended;     stdcall;
  {-Return the cumulative Maxwell distribution function with scale b > 0, x >= 0}
const
  sqrt2_pi = 0.797884560802865355879892119869;  {sqrt(2/Pi)}
var
  y: extended;
begin


if F_FastSpec = True then
begin
   //sfc_maxwell_cdf:=sfc_erf(x/(sqrt(2)*b))-x*exp(-0.5*sqr(x/b))/b*sqrt(2/pi);
   sfc_maxwell_cdf:=sfc_erf(x/(Sqrt2*b))-x*exp_fa(-0.5*sqr(x/b))/b*sqrt2_pi;
end
else
begin
  if (b <= 0.0) or (x < 0.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_maxwell_cdf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  {cdf = igammap(3/2,(x/b)^2/2}
  y := x/b;
  if y >= Sqrt_MaxExt then sfc_maxwell_cdf := 1.0
  else sfc_maxwell_cdf := sfc_igammap(1.5,0.5*sqr(y));
end;


end;





function sfc_maxwell_inv(y, b: extended): extended;  stdcall;
  {-Return the functional inverse of the Maxwell distribution with scale b > 0}
var
  z: extended;
begin
  if (b <= 0.0) or (y<0.0) or (y>1.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_maxwell_inv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if y=1.0 then sfc_maxwell_inv := PosInf_x
  else if y=0.0 then sfc_maxwell_inv := 0.0
  else begin
    {inv = b*sqrt(2*igammap_inv(3/2, y))}
    z := sfc_igammap_inv(1.5, y);
    sfc_maxwell_inv := b*sqrt(2.0*z);
  end;
end;




function sfc_normstd_pdf(x: extended): extended;   stdcall;
  {-Return the std. normal probability density function exp(-x^2/2)/sqrt(2*Pi)}
begin
  sfc_normstd_pdf := sfc_erf_z(x);
end;



function sfc_normstd_cdf(x: extended): extended;   stdcall;
  {-Return the standard normal distribution function}
begin
  sfc_normstd_cdf := sfc_erf_p(x);
end;


function sfc_normstd_inv(y: extended): extended;   stdcall;
  {-Return the inverse standard normal distribution function, 0 <= y <= 1.}
  { For x=normstd_inv(y) and y from [0,1], normstd_cdf(x) = y}
begin
  if IsNanOrInf(y) then sfc_normstd_inv := y
  else if y <= 0.0 then sfc_normstd_inv := NegInf_x
  else if y >= 1.0 then sfc_normstd_inv := PosInf_x
  else sfc_normstd_inv := -sfc_erfc_inv(2.0*y)*sqrt2;
end;





//function sfc_normal_inv(mu, sd, y: extended): extended;   stdcall;
function sfc_normal_inv(y, mu, sd: extended): extended;   stdcall;
  {-Return the functional inverse of normal (Gaussian) distribution}
  { with mean mu and standard deviation sd > 0, 0 < y < 1.}
begin
  if (sd <= 0.0) or (y < 0.0) or (y > 1.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_normal_inv := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  {$ifdef Ver50}
    y := sfc_normstd_inv(y);
    sfc_normal_inv := sd*y + mu;
  {$else}
    sfc_normal_inv := sd*sfc_normstd_inv(y) + mu;
  {$endif}
end;






function inverror(p,q: extended): extended;
  {-Return value of inverse error function: erf_inv(p) if p <= 0.5, erfc_inv(q) otherwise}
var
  r,x,z: extended;
const
  Y1= 747689.0/8388608.0; {0.0891314744949340820313f}
  P1: array[0..7] of extended = (
         -0.000508781949658280665617,
         -0.00836874819741736770379,
          0.0334806625409744615033,
         -0.0126926147662974029034,
         -0.0365637971411762664006,
          0.0219878681111168899165,
          0.00822687874676915743155,
         -0.00538772965071242932965);
  Q1: array[0..9] of extended = (
          1.0,
         -0.970005043303290640362,
         -1.56574558234175846809,
          1.56221558398423026363,
          0.662328840472002992063,
         -0.71228902341542847553,
         -0.0527396382340099713954,
          0.0795283687341571680018,
         -0.00233393759374190016776,
          0.000886216390456424707504);
const
  Y2= 73711.0/32768.0; {2.249481201171875f}
  P2: array[0..8] of extended = (
         -0.202433508355938759655,
          0.105264680699391713268,
          8.37050328343119927838,
         17.6447298408374015486,
        -18.8510648058714251895,
        -44.6382324441786960818,
         17.445385985570866523,
         21.1294655448340526258,
         -3.67192254707729348546);
  Q2: array[0..8] of extended = (
          1.0,
          6.24264124854247537712,
          3.9713437953343869095,
        -28.6608180499800029974,
        -20.1432634680485188801,
         48.5609213108739935468,
         10.8268667355460159008,
        -22.6436933413139721736,
          1.72114765761200282724);
const
  Y3= 26451.0/32768.0; {0.807220458984375f}
  P3: array[0..10] of extended = (
         -0.131102781679951906451,
         -0.163794047193317060787,
          0.117030156341995252019,
          0.387079738972604337464,
          0.337785538912035898924,
          0.142869534408157156766,
          0.0290157910005329060432,
          0.00214558995388805277169,
         -0.679465575181126350155e-6,
          0.285225331782217055858e-7,
         -0.681149956853776992068e-9);
  Q3: array[0..7] of extended = (
          1.0,
          3.46625407242567245975,
          5.38168345707006855425,
          4.77846592945843778382,
          2.59301921623620271374,
          0.848854343457902036425,
          0.152264338295331783612,
          0.01105924229346489121);
const
  Y4= 985615.0/1048576.0; {0.93995571136474609375f}
  P4: array[0..8] of extended = (
         -0.0350353787183177984712,
         -0.00222426529213447927281,
          0.0185573306514231072324,
          0.00950804701325919603619,
          0.00187123492819559223345,
          0.000157544617424960554631,
          0.460469890584317994083e-5,
         -0.230404776911882601748e-9,
          0.266339227425782031962e-11);
  Q4: array[0..6] of extended = (
          1.0,
          1.3653349817554063097,
          0.762059164553623404043,
          0.220091105764131249824,
          0.0341589143670947727934,
          0.00263861676657015992959,
          0.764675292302794483503e-4);
const
  Y5= 1031409.0/1048576.0; {0.98362827301025390625f}
  P5: array[0..8] of extended = (
         -0.0167431005076633737133,
         -0.00112951438745580278863,
          0.00105628862152492910091,
          0.000209386317487588078668,
          0.149624783758342370182e-4,
          0.449696789927706453732e-6,
          0.462596163522878599135e-8,
         -0.281128735628831791805e-13,
          0.99055709973310326855e-16);
  Q5: array[0..6] of extended = (
          1.0,
          0.591429344886417493481,
          0.138151865749083321638,
          0.0160746087093676504695,
          0.000964011807005165528527,
          0.275335474764726041141e-4,
          0.282243172016108031869e-6);
const
  Y6= 1045583.0/1048576.0;  {0.99714565277099609375f}
  P6: array[0..7] of extended = (
         -0.0024978212791898131227,
         -0.779190719229053954292e-5,
          0.254723037413027451751e-4,
          0.162397777342510920873e-5,
          0.396341011304801168516e-7,
          0.411632831190944208473e-9,
          0.145596286718675035587e-11,
         -0.116765012397184275695e-17);
  Q6: array[0..6] of extended = (
          1.0,
          0.207123112214422517181,
          0.0169410838120975906478,
          0.000690538265622684595676,
          0.145007359818232637924e-4,
          0.144437756628144157666e-6,
          0.509761276599778486139e-9);
const
  Y7= 1047961.0/1048576.0;  {0.99941349029541015625f}
  P7: array[0..7] of extended = (
         -0.000539042911019078575891,
         -0.28398759004727721098e-6,
          0.899465114892291446442e-6,
          0.229345859265920864296e-7,
          0.225561444863500149219e-9,
          0.947846627503022684216e-12,
          0.135880130108924861008e-14,
         -0.348890393399948882918e-21);
  Q7: array[0..6] of extended = (
          1.0,
          0.0845746234001899436914,
          0.00282092984726264681981,
          0.468292921940894236786e-4,
          0.399968812193862100054e-6,
          0.161809290887904476097e-8,
          0.231558608310259605225e-11);

begin
  {Ref: Boost [19], erf_inv.hpp/erf_inv_imp}
  if p <= 0.5 then begin
    z := p * (p + 10);
    r := PolEvalX_f(p, P1, 8) / PolEvalX_f(p, Q1, 10);
    inverror := z*Y1 + z*r;
  end
  else if q >= 0.25 then begin
    z := q - 0.25;
    r := PolEvalX_f(z, P2, 9) / PolEvalX_f(z, Q2, 9);
    inverror := sqrt(-2.0*ln(q)) / (Y2 + r);
   end
   else begin
     x := sqrt(-ln(q));
     if x<3.0 then begin
       z := x - 1.125;
       r := PolEvalX_f(z, P3, 11) / PolEvalX_f(z, Q3, 8);
       inverror := Y3*x + r*x;
     end
     else if x<6.0 then begin
       z := x - 3.0;
       r := PolEvalX_f(z, P4, 9) / PolEvalX_f(z, Q4, 7);
       inverror := Y4*x + r*x;
     end
     else if x<18.0 then begin
       z := x - 6.0;
       r := PolEvalX_f(z, P5, 9) / PolEvalX_f(z, Q5, 7);
       inverror := Y5*x + r*x;
     end
     else if x<44.0 then begin
       z := x - 18.0;
       r := PolEvalX_f(z, P6, 8) / PolEvalX_f(z, Q6, 7);
       inverror := Y6*x + r*x;
     end
     else begin
       z := x - 44.0;
       r := PolEvalX_f(z, P7, 8) / PolEvalX_f(z, Q7, 7);
       inverror := Y7*x + r*x;
     end;
   end;
end;





function sfc_igammap_inv(a,p: extended): extended;   stdcall;
  {-Inverse incomplete gamma: return x with P(a,x)=p, a>=0, 0<=p<1}
begin
  sfc_igammap_inv := sfc_igamma_inv(a,p,1.0-p);
end;



{---------------------------------------------------------------------------}
function sfc_igammaq_inv(a,q: extended): extended;  stdcall;
  {-Inverse complemented incomplete gamma: return x with Q(a,x)=q, a>=0, 0<q<=1}
begin
  sfc_igammaq_inv := sfc_igamma_inv(a,1.0-q,q);
end;




function sfc_igamma_inv(a,p,q: extended): extended;
  {-Return the inverse normalised incomplete gamma function, i.e. calculate}
  { x with P(a,x)=p and Q(a,x)=q. Input parameter a>0, p>=0, q>0 and p+q=1.}
var
  ierr: integer;
  x: extended;
begin
  sfc_incgamma_inv(a,p,q,x,ierr);
  sfc_igamma_inv := x;
  if ierr<0 then begin
    if (ierr=-2) or (ierr=-4) then
    begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      sfc_igamma_inv := NaN_x;
      GenerateFPUException(FPUErrorNAN);{.375}
      exit;
    end;
    {$ifopt R+}
      if RTE_NoConvergence>0 then RunError(byte(RTE_NoConvergence));
    {$endif}
  end;
end;




procedure sfc_incgamma_inv(a,p,q: extended; var x: extended; var ierr: integer);
  {-Return the inverse normalised incomplete gamma function, i.e. calculate}
  { x with P(a,x)=p and Q(a,x)=q. Input parameter a>0, p>=0, q>=0 and p+q=1.}
  { ierr is >= 0 for success, < 0 for input errors or iterations failures. }
var
  pn,qn,r,t,h,w,d,td,am1: extended;
  done: boolean;
const
  eps  = 1.1e-13;      {~ (eps_x/2)^(2/3), cf. Boost's [19] 2/3*digits}
  tol  = 1.1e-13;
  rmin = 3.101e-4913;  {Threshold for derivative, ~MinExtended/eps_x}
begin

  {The classical reference is A.R. Didonato, A.H. Morris[27]. The original}
  {text and equations are used together with the Boost interpretation from}
  {\boost\math\special_functions\detail\igamma_inverse.hpp [19], which is }
  {Copyright John Maddock 2006, see 3rdparty.ama for Boost license}

  {Some of the ierr return codes from [27] are used: }
  { ierr >=  0, iteration count                      }
  { ierr  = -2, if a <= 0                            }
  { ierr  = -4, if p < 0, q < 0, or |p+q-1| > eps_d  }
  { ierr  = -6, if 10 iterations were performed      }
  { ierr  = -7, iteration failed                     }
  { ierr  = -8, x is calculated with unknown accuracy}

  x := -1.0;
  if a <= 0.0 then begin
    ierr := -2;
    exit;
  end;

  {Use eps_d for check because function may be called with 'double' p,q}
  if (p<0.0) or (q<0.0) or (abs(p+q-1.0)>eps_d) then begin
    ierr := -4;
    exit;
  end;

  if (p=1.0) and (q=0.0) then begin
    x := PosInf_x;
    exit;
  end;

  x := 0.0;
  ierr := 0;
  if p=0.0 then exit;

  if a=1.0 then begin
    {No guess, no iteration. Use known answer}
    if q <= 0.9 then x := -ln(q)
    else x := -ln1p(-p);
    exit;
  end;

  {Calculate initial approximation, done if no iteration needed/useful}
  x := igamma_inv_guess(a,p,q,done);
  if done then begin
    exit;
  end;

  if (p <= MinExtended) or (q <= MinExtended) then begin
    ierr := -8;
    exit;
  end;

  td   := tol*minx(p,q);  {iteration tolerance for |p-pn| or |q-qn|}
  am1  := a - 1.0;
  done := false;

  repeat
    {Note that DiDonato & Morris [27] use two different iteration loops:}
    {one for P and one for Q, they can be combined with minimal effort. }
    inc(ierr);
    if ierr>10 then begin
      ierr := -6;
      exit;
    end;
    sfc_incgamma_ex(a,x,pn,qn,r,true);
    if r<rmin then begin
      ierr := -8;
      exit;
    end;
    if p<=0.5 then d := pn-p else d := q-qn;
    t := d/r;
    w := 0.5*(am1-x);
    if (abs(t) < 0.1) and (abs(w*t) <= 0.1) then begin
      {Schr”der step}
      h := w*sqr(t);
      done := (abs(w) > 1.0) and (abs(h) < eps);
      h := t + h;
    end
    else begin
      {Newton step}
      h := t;
    end;
    x := x*(1.0-h);
    if x<=0.0 then begin
      ierr := -7;
      exit;
    end;
    if (abs(h) < eps) or (abs(d) < td) then done := true;
  until done;
end;




function igamma_inv_guess(a,p,q: extended; var noiter: boolean): extended;
  {-Return an initial approximation for inverse incomplete gamma}
var
  b,g,s,t,u,v,w,x,y,z,am1,ap1: extended;
  i: integer;
const
  ln10 = 2.302585092994;
begin
  noiter := false;
  am1 := a-1.0;
  if a=1.0 then x := - ln(q)
  else if a<1.0 then begin
    g := sfc_gamma(a);
    b := q*g;
    if ((b > 0.6) or ((b >= 0.45) and (a >= 0.3))) then begin
      {DiDonato & Morris [27], Eq (21), see comment in Boost for a slight variation}
      if (b*q > 1e-8) and (q > 1e-5) then u := power_fa(p*g*a, 1.0/a)
      else u := exp_fa(-q/a - EulerGamma);
      x := u/(1.0 - u/(a+1.0));
    end
    else if (a < 0.3) and (b >= 0.35) then begin
      {DiDonato & Morris [27], Eq (22)}
      t := exp_fa(-EulerGamma - b);
      u := t*exp_fa(t);
      x := t*exp_fa(u);
    end
    else if (b > 0.15) or (a >= 0.3) then begin
      {DiDonato & Morris [27], Eq (23)}
      y := -ln(b);
      v := y + am1*ln(y);
      x := y + am1*ln(v) - ln1p(-am1/(1.0+v));
    end
    else if b>0.1 then begin
      {DiDonato & Morris [27], Eq (24)}
      y := -ln(b);
      v := y + am1*ln(y);
      t := v*v + 2.0*(3.0-a)*v + (2.0-a)*(3.0-a);
      u := v*v + (5.0-a)*v + 2.0;
      x := y + am1*ln(v) - ln(u/t);
    end
    else begin
      {DiDonato & Morris [27], Eq (25)}
      x  := DM_Fettis(a,ln(b));
    end;
  end
  else begin {a > 1}
    w := DM_CF6(a,p,q);
    t := abs(1.0 - w/a);
    if (a >= 500.0) and (t < 1e-6) then begin
      x := w;
      if t<1e-17 then noiter := true;
    end
    else if p>0.5 then begin
      if w < 3.0*a then begin
        x := w;
      end
      else begin
        {here b = ln(q*Gamma(a)) = ln(B)}
        b := ln(q) + sfc_lngamma(a);
        t := maxx(2.0, a*am1);
        if b < -ln10*t then begin
          x := DM_Fettis(a,b)
        end
        else begin
          {DiDonato & Morris [27], Eq (33)}
          u := am1*ln(w) - b - ln1p(-am1/(1.0+w));
          x := am1*ln(u) - b - ln1p(-am1/(1.0+u));
        end;
      end
    end
    else begin
      {p < 0.5}
      z := w;
      ap1 := a+1.0;
      if w < 0.15*ap1 then begin
        {DiDonato & Morris [27], Eq (35)}
        v := ln(p) + sfc_lngamma(ap1);
        t := a+2.0;
        z := exp_fa((v+w)/a);
        s := ln1p(z/ap1*(1.0 + z/t));
        z := exp_fa((v + z - s)/a);
        {Note: the next line is missing in the Boost code!}
        s := ln1p(z/ap1*(1.0 + z/t));
        z := exp_fa((v + z - s)/a);
        s := ln1p(z/ap1 * (1.0 + z/t*(1.0 + z/(a+3.0))));
        z := exp_fa((v + z - s)/a);
      end;

      {WE: The setting noiter := true if z<0.002(a+1) has been dropped}
      if (z <= 0.01*ap1) or (z > 0.7*ap1) then begin
        x := z;
      end
      else begin
        {DiDonato & Morris [27], Eq (34)}
        i := 1;
        t := z/ap1;
        s := 1.0+t;
        while (i<100) and (t>1e-4) do begin
          inc(i);
          t := t*(z/(a+i));
          s := s+t;
        end;
        {DiDonato & Morris [27], Eq (36)}
        t := ln(p) + sfc_lngamma(ap1) - ln(s);
        z := exp_fa((z+t)/a);
        x := z*(1.0 - (a*ln(z) - z - t)/(a-z));
      end;
    end;
  end;
  igamma_inv_guess := x;
end;


function DM_Fettis(a,lnB: extended): extended;
  {-Initial x for inverse incomplete gamma when a<1, q*Gamma(a) < 0.01}
var
  y,c1,c2,c3,c4,c5,a1,a2,a3: extended;
begin
  {DiDonato & Morris [27], Eq (25)}
  y  := -lnB;
  a1 := a-1.0;
  a2 := sqr(a);
  a3 := a2*a;
  c1 := a1*ln(y);
  c2 := 1.0 + c1;
  c3 := (-0.5*c1 + (a-2.0))*c1 + (1.5*a-2.5);
  c4 := ((c1/THREE - (1.5*a-2.5))*c1 + (a2 -6.0*a + 7.0))*c1 + (11.0*a2 - 46.0*a+47.0)/6.0;
  c5 := (((-0.25*c1 + (11.0*a - 17.0)/6.0)*c1 + (-3.0*a2 + 13.0*a - 13.0))*c1
           + (a3 - 12.5*a2 + 36.0*a - 30.5))*c1
           + (25.0*a3 - 195.0*a2 + 477.0*a - 379.0)/12.0;
  DM_Fettis := ((((c5/y + c4)/y + c3)/y + c2)*a1/y + c1) + y;
end;





function DM_CF6(a,p,q: extended): extended;
  {-Cornish-Fisher 6-term approximation for inverse incomplete gamma}
const
  ca: array[0..3] of extended = (3.31125922108741, 11.6616720288968, 4.28342155967104, 0.213623493715853);
  cb: array[0..4] of extended = (1.0, 6.61053765625462, 6.40691597760039, 1.27364489782223, 0.3611708101884203e-1);
var
  rta,s,s2,t: extended;
begin
  {DiDonato & Morris [27], Eq (32)}
  if p<0.5 then t := sqrt(-2.0*ln(p))
  else t := sqrt(-2.0*ln(q));

  //s2 := PolEvalX(t,ca,4);
  s2 := (((ca[3]*t+ca[2])*t+ca[1])*t+ca[0]);

  //s  := PolEvalX(t,cb,5);
  s := ((((cb[4]*t+cb[3])*t+cb[2])*t+cb[1])*t+cb[0]);

  s  := t - s2/s;
  if p<0.5 then s := -s;
  {DiDonato & Morris [27], Eq (31)}
  s2  := s*s;
  rta := sqrt(a);
  t   := a + s*rta + (s2 - 1.0)/3.0 + s*(s2 - 7.0)/(36.0*rta)
           - ((3.0*s2 + 7.0)*s2 - 16.0)/(810.0*a)
           + s*((9.0*s2 + 256.0)*s2 - 433.0)/(38880.0*a*rta);
  if t<0.0 then DM_CF6 := 0.0
  else DM_CF6 := t;
end;




function sfc_igammaq(a,x: extended): extended;   stdcall;
  {-Return the normalised upper incomplete gamma function Q(a,x), a>=0, x>=0}
  { Q(a,x) = integral(exp(-t)*t^(a-1), t=x..Inf)/gamma(a)}
var
  p,q,dax: extended;
begin
  sfc_incgamma_ex(a,x,p,q,dax,false);
  sfc_igammaq := q;
end;



function sfc_igammap(a,x: extended): extended;    stdcall;
  {-Return the normalised lower incomplete gamma function P(a,x), a>=0, x>=0}
  { P(a,x) = integral(exp(-t)*t^(a-1), t=0..x)/gamma(a)}
var
  p,q,dax: extended;
begin
  sfc_incgamma_ex(a,x,p,q,dax,false);
  sfc_igammap := p;
end;




function sfc_igammal(a,x: extended): extended;     stdcall;
  {-Return the non-normalised lower incomplete gamma function}
  { gamma(a,x) = integral(exp(-t)*t^(a-1), t=0..x); x>=0, a<>0,-1,-2,..}
var
  r,t,p: extended;
begin
  if (x<0.0) or IsNanOrInf(x) or IsNanOrInf(a) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_igammal := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if x=0.0 then sfc_igammal := 0.0
  else if a<=0.0 then begin
    if frac(a)=0.0 then
    begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      GenerateFPUException(FPUErrorNAN);{.375}
      sfc_igammal := NaN_x;
      exit;
    end;
    {Split for TP5}
    r := sfc_gamma(a);
    t := sfc_igamma(a,x);
    p := r-t;
    {$ifdef debug}
        {if abs(p)<sqrt_epsh*(abs(t)+abs(r)) then
        begin
        sfc_write_debug_str('*** sfc_igammal: loss of accuracy');
        end;}
    {$endif}
    sfc_igammal := p;
  end
  else if (a<MinExtended) then sfc_igammal := PosInf_x
  else if (a<MinExtended*x) then sfc_igammal := 1.0/a
  else if (x<a-0.25) or (x<4.0) then begin
    if a<MAXGAMX then begin
      {Result is just P(a,x)*Gamma(a) if P(a,x) <> 0}
      p := sfc_igammap(a,x);
      if p<>0.0 then begin
        r := sfc_gamma(a);
        sfc_igammal := p*r;
        exit;
      end;
    end;
    p := igaml_mser(a,x,t);
    {$ifdef debug}
        {
        if abs(p)<t then
        begin
        sfc_write_debug_str('*** sfc_igammal: large error from igaml_mser');
        end;
        }
    {$endif}
    {Now gamma(a,x) = x^a*exp(-x)*p/a, but handle possible overflows}
    t := a*ln(x)-x;
    r := t + ln(p/a);
    if r > ln_MaxExt then sfc_igammal := PosInf_x
    else sfc_igammal := exp_fa(r);   {.335}
  end
  else begin
    {x>=4 and x >= a - 0.25}
    if a<MAXGAMX then begin
      {Split for TP5}
      r := sfc_gamma(a);
      t := sfc_igamma(a,x);
      p := r-t;
      {$ifdef debug}
          {
          if abs(p)<sqrt_epsh*(abs(t)+abs(r)) then
          begin
          sfc_write_debug_str('*** sfc_igammal: loss of accuracy');
          end;
          }
      {$endif}
      sfc_igammal := p;
    end
    else begin
      {Handle small window below overflow}
      sfc_igammal := PosInf_x;
      p := sfc_igammap(a,x);
      if p<>0 then begin
        t := ln(p) + sfc_lngamma(a);
        if t<=ln_MaxExt then sfc_igammal := exp_fa(t); {.335}
      end;
    end;
  end;
end;




function sfc_igamma(a,x: extended): extended;  stdcall;
  {-Return the non-normalised upper incomplete gamma function}
  { GAMMA(a,x) = integral(exp(-t)*t^(a-1), t=x..Inf), x>=0}
var
  p,q,t,lnx: extended;
  k: integer;
  ok: boolean;
begin
  if (x<0.0) or IsNanOrInf(x) or IsNanOrInf(a) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    GenerateFPUException(FPUErrorNAN);{.375}
    sfc_igamma := NaN_x;
    exit;
  end;
  {Special cases: GAMMA(a,0) = gamma(a) and GAMMA(0,x) = E_1(x)}
  if x=0.0 then sfc_igamma := sfc_gamma(a)
  else if (a=0.0) and (x>0.0) then sfc_igamma := sfc_e1(x)
  else if (a>0) and (a<MAXGAMX) then begin
    {Result is just Q(a,x)*Gamma(a)}
    sfc_incgamma_ex(a,x,p,q,t,false);
    t := sfc_gamma(a);
    sfc_igamma := q*t;
  end
  else if a<0.0 then begin
    {Logic for a<0 is similar to GSL [21], function gamma_inc.c}
    if (x>0.25) or (a <= -10000) then begin
      t := a*ln(x)-x;
      if t>ln_MaxExt then begin
        sfc_igamma := PosInf_x;
        exit;
      end;
      igam_qfraction(a,x,exp_fa(t),p,q);
      sfc_igamma := q;
    end
    else if a >= -0.5 then begin
      igam_qtaylor(a,x,p,q);
      t := sfc_gamma(a);  {a <> 0!}
      sfc_igamma := q*t;
    end
    else begin
      {-10000 < a < -0.5}
      t := a - floor_fa(a);
      {0 <= t < 1, set q = GAMMA(t,x) and use the recurrence formula}
      {NIST[30] 8.8.2:  GAMMA(t,x) = [GAMMA(t+1,x) - x^t*exp(-x)]/t }
      if t>0.0 then q := sfc_igammaq(t,x)*sfc_gamma(t)
      else q := sfc_e1(x);
      lnx := ln(x);
      for k:=1 to -floor_fa(a) do begin
        t := t-1.0;
        p := -x + t*lnx;
        if p>ln_MaxExt then begin
          sfc_igamma := PosInf_x;
          exit;
        end;
        q := (q-exp_fa(p))/t;
      end;
      sfc_igamma := q;
    end
  end
  else begin
    {here a >= MAXGAMX, i.e. gamma(a) overflows}
    if (x >= 1.0) and (a < x+0.25) then begin
      {qfraction if t=x^a*exp(-x) is not too large}
      t := a*ln(x);
      ok := false;
      if (t < ln_MaxExt) and (-x > ln_MinExt) then
      begin
        t := power_fa(x,a)*exp_fa(-x);
        ok := true;
      end
      else
      if t-x < ln_MaxExt then
      begin
        t := power_fa(x/exp_fa(x/a), a);
        ok := true;
      end;
      if ok then begin
        igam_qfraction(a,x,t,p,q);
        sfc_igamma := q;
        exit;
      end;
    end;
    {return Q(a,x)*Gamma(a) using lngamma}
    sfc_incgamma_ex(a,x,p,q,t,false);
    if q=0.0 then sfc_igamma := 0.0
    else begin
      t := sfc_lngamma(a);
      if q<0.75 then t := t + ln(q)
      else t := t + ln1p(-p);
      if t>ln_MaxExt then sfc_igamma := PosInf_x
      else sfc_igamma := exp_fa(t);
    end;
  end;
end;





function igaml_mser(a,x: extended; var err: extended): extended;
  {-Return igaml_mser(a,x) = M(1,1+a,x) = igammal(a,x)*a*exp(x)/x^a}
var
  p,c,r,t,e: extended;
  n: integer;
begin
  {Modified non-normalised Temme/Gautschi code for P(a,x), cf. igam_ptaylor}
  r := a;
  c := 1.0;
  p := 1.0;
  e := 1.0;
  n := 0;
  repeat
    r := r+1.0;
    c := c*x/r;
    p := p+c;
    t := abs(c);
    if t>e then e := t;
    inc(n);
  until t < abs(p)*eps_x;
  e := e*eps_x;
  if p<>0 then e := e/abs(p);
  err := 0.5*n*eps_x + e;
  igaml_mser := p;
end;





function sfc_e1(x: extended): extended;
  {-Return the exponential integral E1(x) = integral(exp(-x*t)/t, t=1..Inf), x <> 0}
var
  y,z: extended;
{Based on boost_1_42_0\boost\math\special_functions\expint.hpp [19]}
{Copyright John Maddock 2007, see 3rdparty.ama for Boost license}
const
  P01: array[0..5] of extended = (
         0.08651972480793979568216,
         0.0275114007037026844633,
        -0.246594388074877139824,
        -0.0237624819878732642231,
        -0.00259113319641673986276,
         0.30853660894346057053e-4);
  Q01: array[0..6] of extended = (
         1.0,
         0.317978365797784100273,
         0.0393622602554758722511,
         0.00204062029115966323229,
         0.732512107100088047854e-5,
        -0.202872781770207871975e-5,
         0.52779248094603709945e-7);
  Pix: array[0..13] of extended = (
         -0.534401189080684443046e-23,
         -0.999999999999999999905,
         -62.1517806091379402505,
         -1568.45688271895145277,
         -21015.3431990874009619,
         -164333.011755931661949,
         -777917.270775426696103,
         -2244188.56195255112937,
         -3888702.98145335643429,
         -3909822.65621952648353,
         -2149033.9538897398457,
         -584705.537139793925189,
         -65815.2605361889477244,
         -2038.82870680427258038);
  Qix: array[0..13] of extended = (
         1.0,
         64.1517806091379399478,
         1690.76044393722763785,
         24035.9534033068949426,
         203679.998633572361706,
         1074661.58459976978285,
         3586552.65020899358773,
         7552186.84989547621411,
         9853333.79353054111434,
         7689642.74550683631258,
         3385553.35146759180739,
         763218.072732396428725,
         73930.2995984054930821,
         2063.86994219629165937);
const
  y01 = 695977.0/1048576.0;
begin
  {avoid infinite loop if x is (negative) NAN}
  if IsNaN(x) then sfc_e1 := x
  else if x < 0.0 then sfc_e1 := -sfc_ei(-x)
  else if x<=1.0 then begin
    y := PolEvalX_f(x,P01,6) / PolEvalX_f(x,Q01,7);
    sfc_e1 := y + (x - ln(x) - y01);
  end
  else if x>=ln_MaxExt then sfc_e1 := 0.0
  else begin
    y := 1.0/x;
    z := 1.0 + PolEvalX_f(y,Pix,14) / PolEvalX_f(y,Qix,14);
    sfc_e1 := z*(exp_fa(-x)*y);
  end;
end;



function sfc_ei(x: extended): extended;
  {-Return the exponential integral Ei(x) = PV-integral(exp(t)/t, t=-Inf..x)}
var
  y,z: extended;
{Based on boost_1_42_0\boost\math\special_functions\expint.hpp [19]}
{Copyright John Maddock 2007, see 3rdparty.ama for Boost license}

{WE note: Do not change P6/Q6 to decimal! This change will increase}
{         the relative error around x=6 to about 15..20 eps_x}
const
  P6H: array[0..10] of THexExtW = (
         ($7A8C,$8A1E,$46C4,$BF27,$4000),  { 2.98677224343598593764}
         ($FD57,$D5A6,$A7DC,$8490,$3FFD),  { 0.25891613550886736592}
         ($EFE7,$87E0,$1C47,$CA11,$3FFE),  { 0.789323584998672832285}
         ($016D,$549D,$4BEE,$BD4D,$3FFB),  { 0.092432587824602399339}
         ($EE5D,$A73C,$A7C9,$D2A1,$3FFA),  { 0.0514236978728625906656}
         ($D5AB,$1103,$17FD,$D7C5,$3FF7),  { 0.00658477469745132977921}
         ($AD92,$84F1,$5D20,$A3BA,$3FF5),  { 0.00124914538197086254233}
         ($3827,$AC7C,$62CE,$89D0,$3FF2),  { 0.000131429679565472408551}
         ($0427,$B705,$7D19,$BD78,$3FEE),  { 0.11293331317982763165e-4}
         ($5B5D,$FA07,$DC80,$A8FA,$3FEA),  { 0.629499283139417444244e-6}
         ($98C6,$B2D3,$E672,$98C1,$3FE5)); { 0.177833045143692498221e-7}
  Q6H: array[0..8] of THexExtW = (
         ($0000,$0000,$0000,$8000,$3FFF),  { 1.0}
         ($726A,$E11E,$1134,$9A0D,$BFFF),  {-1.20352377969742325748}
         ($21BC,$21B8,$B14D,$AAC5,$3FFE),  { 0.66707904942606479811}
         ($04C7,$8509,$EBDF,$E45D,$BFFC),  {-0.223014531629140771914}
         ($788A,$488A,$7362,$CA12,$3FFA),  { 0.0493340022262908008636}
         ($403E,$5311,$F531,$F31D,$BFF7),  {-0.00741934273050807310677}
         ($05C2,$B8B2,$D5AD,$C2E9,$3FF4),  { 0.00074353567782087939294}
         ($2CD6,$4141,$C7BD,$BF33,$BFF0),  {-0.455861727069603367656e-4}
         ($628A,$9DB7,$5B80,$B084,$3FEB)); { 0.131515429329812837701e-5}
const
  rh : THexExtW = ($E1E5,$A5AF,$4A95,$BEB9,$3FFD); { = 0.37250741078136663446199186658.. ; root of Ei: Ei(r)=0}
  r1h: THexExtW = ($E000,$A5AF,$4A95,$BEB9,$3FFD); { = 1677624236387711.0/4503599627370496.0 = 3.7250741078136662132E-1}
  r2 = 0.13140183414386028200928e-16;              { = r - r1}
var
  r : extended absolute rh;
  r1: extended absolute r1h;
  P06: array[0..10]of extended absolute P6H;
  Q06: array[0..8] of extended absolute Q6H;
begin
  {avoid infinite loop if x is (negative) NAN}
  if IsNaN(x) then sfc_ei := x
  else if x<0 then sfc_ei := -sfc_e1(-x)
  else if x<=eps_x then begin
    {Boost's rational approximation is suboptimal for small x}
    {use Ei(x) = (+EulerGamma + ln(x)) + x + 1/4*x^2 + O(x^3)}
    {for x <= eps_x, i.e. |ln(x)| > 43, the x term is negligible}
    sfc_ei := EulerGamma + ln(x);
  end
  else if x<=6.0 then begin
    y := x/THREE - 1.0;
    z := PolEvalX_f(y,P06,11) / PolEvalX_f(y,Q06,9);
    y := (x - r1) - r2;
    z := y*z;
    if abs(y)<0.1 then sfc_ei := z + ln1p(y/r)
    else sfc_ei := z + ln(x/r);
  end
  else if x>ln_MaxExt then sfc_ei := PosInf_x
  else sfc_ei := sfc_eiex(x,exp_fa(x));
end;





function sfc_eiex(x,expx: extended): extended;
  {-Return the exponential integral Ei(x) = PV-integral(exp(t)/t, t=-Inf..x)}
  { internal version for x>6, expx must be = exp(x), used by ei and li}
var
  y,z: extended;

const
  {Based on boost_1_42_0\boost\math\special_functions\expint.hpp [19]}
  {Copyright John Maddock 2007, see 3rdparty.ama for Boost license}
  P10: array[0..8] of extended = (
         0.00139324086199409049399,
        -0.0345238388952337563247,
        -0.0382065278072592940767,
        -0.0156117003070560727392,
        -0.00383276012430495387102,
        -0.000697070540945496497992,
        -0.877310384591205930343e-4,
        -0.623067256376494930067e-5,
        -0.377246883283337141444e-6);
  Q10: array[0..9] of extended = (
         1.0,
         1.08073635708902053767,
         0.553681133533942532909,
         0.176763647137553797451,
         0.0387891748253869928121,
         0.0060603004848394727017,
         0.000670519492939992806051,
         0.4947357050100855646e-4,
         0.204339282037446434827e-5,
         0.146951181174930425744e-7);
  P20: array[0..9] of extended = (
        -0.00893891094356946995368,
        -0.0487562980088748775943,
        -0.0670568657950041926085,
        -0.0509577352851442932713,
        -0.02551800927409034206,
        -0.00892913759760086687083,
        -0.00224469630207344379888,
        -0.000392477245911296982776,
        -0.44424044184395578775e-4,
        -0.252788029251437017959e-5);
  Q20: array[0..9] of extended = (
         1.0,
         2.00323265503572414261,
         1.94688958187256383178,
         1.19733638134417472296,
         0.513137726038353385661,
         0.159135395578007264547,
         0.0358233587351620919881,
         0.0056716655597009417875,
         0.000577048986213535829925,
         0.290976943033493216793e-4);
  P40: array[0..11] of extended = (
        -0.00356165148914447278177,
        -0.0240235006148610849678,
        -0.0516699967278057976119,
        -0.0586603078706856245674,
        -0.0409960120868776180825,
        -0.0185485073689590665153,
        -0.00537842101034123222417,
        -0.000920988084778273760609,
        -0.716742618812210980263e-4,
        -0.504623302166487346677e-9,
         0.712662196671896837736e-10,
        -0.533769629702262072175e-11);
  Q40: array[0..8] of extended = (
         1.0,
         3.13286733695729715455,
         4.49281223045653491929,
         3.84900294427622911374,
         2.15205199043580378211,
         0.802912186540269232424,
         0.194793170017818925388,
         0.0280128013584653182994,
         0.00182034930799902922549);
const
  Pix: array[0..8] of extended = (
        -0.0130653381347656250004,
         0.644487780349757303739,
         143.995670348227433964,
        -13918.9322758014173709,
         476260.975133624194484,
        -7437102.15135982802122,
         53732298.8764767916542,
        -160695051.957997452509,
         137839271.592778020028);
  Qix: array[0..8] of extended = (
         1.0,
         27.2103343964943718802,
        -8785.48528692879413676,
         397530.290000322626766,
        -7356441.34957799368252,
         63050914.5343400957524,
        -246143779.638307701369,
         384647824.678554961174,
        -166288297.874583961493);
const
  y10 = 303821.0/262144.0;
  y20 = 569887.0/524288.0;
  y40 = 136233.0/131072.0;
  yix = 265569.0/262144.0;
begin
  if x>ln_MaxExt then sfc_eiex := PosInf_x
  else begin
    if x<=10.0 then begin
      y := 0.5*x - 4.0;
      z := y10 + PolEvalX_f(y,P10,9) / PolEvalX_f(y,Q10,10);
    end
    else if x<=20.0 then begin
      y := x/5.0 - 3.0;
      z := y20 + PolEvalX_f(y,P20,10) / PolEvalX_f(y,Q20,10);
    end
    else if x<=40.0 then begin
      y := x/10.0 - 3.0;
      z := y40 + PolEvalX_f(y,P40,12) / PolEvalX_f(y,Q40,9);
    end
    else begin
      y := 1.0/x;
      z := yix + PolEvalX_f(y,Pix,9) / PolEvalX_f(y,Qix,9);
    end;
    z := z*(expx/x);
    sfc_eiex := z + x;
  end;
end;




procedure sfc_incgamma_ex(a,x: extended; var p,q,dax: extended; calcdax: boolean);
  {-Return the normalised incomplete gamma functions P and Q, a>=0, x>=0}
  { P(a,x) = integral(exp(-t)*t^(a-1), t=0..x  )/gamma(a)}
  { Q(a,x) = integral(exp(-t)*t^(a-1), t=x..Inf)/gamma(a)}
  { If calcdax=true, dax = x^a*exp(-x)/gamma(a) is returned. This is extra}
  { effort only in the special cases, otherwise dax is calculated anyway.}
var
  mu,alfa: extended;
  use_temme: boolean;
begin
  dax := 0.0;
  if (x<0.0) or (a<0.0) or IsNanOrInf(x) or IsNanOrInf(a) then begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    p := NaN_x;
    q := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;

  {The logic is based on Temme [26] and Boost's gamma.hpp [19]}
  {First handle trivial cases}
  if (a=0.0) and (x=0.0) then begin
    p := 0.5;
    q := 0.5;
    exit;
  end
  else if x=0.0 then begin
    p := 0.0;
    q := 1.0;
    exit;
  end
  else if a=0.0 then begin
    p := 1.0;
    q := 0.0;
    exit;
  end;

  {Calculate prefix factor if requested. The Lanczos based routine seems to}
  {give the best overall results, although daxw is sometimes more accurate.}
  if calcdax then dax := sfc_igprefix(a,x);

  if frac(2.0*a)=0.0 then begin
    {a is integer or half integer}
    if a=0.5 then begin
      {q = erfc(sqrt(x))}
      {p =  erf(sqrt(x))}
      x := sqrt(x);
      if x < 1.0 then begin
        p := sfc_erf(x);
        q := 1.0 - p;
      end
      else begin
        q := sfc_erfc(x);
        p := 1.0 - q;
      end;
      exit;
    end
    else if a=1.0 then begin
      q := exp_fa(-x);
      p := -expm1(-x);
      exit;
    end
    else if (a < 30.0) and (a < x+1.0) then begin
      {Note: }
      if frac(a)=0.0 then begin
        {a is integer}
        if x > 0.6 then begin
          q := igammaq_int(a,x);
          p := 1.0 - q;
        end;
      end
      else begin
        {a is half-integer}
        if x > 0.2 then begin
          q := igammaq_half(a,x);
          p := 1.0 - q;
        end;
      end;
      exit;
    end;
  end;

  {Check if asymptotic expansion should be used}
  if a > 20.0 then begin
    mu := (x-a)/a;
    use_temme := false;
    if a > 200.0 then begin
      if abs(mu) < sqrt(20.0/a) then use_temme := true;
    end
    else if abs(mu) < 0.4 then use_temme := true;
    if use_temme then begin
      igam_pqasymp(a,x,p,q);
      exit;
    end;
  end;

  {If calcdax=true this has already been done above}
  if not calcdax then dax := sfc_igprefix(a,x);

  if dax < MinExtended then begin
    {Special case:  dax is zero or denormal. Note that this will not}
    {really help if the un-normalised functions shall be calculated!}
    if a > x then p := 0.0 else p := 1.0;
    q := 1.0-p;
  end
  else begin
    {Calculate Taylor series or continued fraction}
    if x > 0.25 then alfa := x+0.25 else alfa := -ln2/ln(x);
    if a > alfa then igam_ptaylor(a,x,dax,p,q)
    else if x < 1.0 then igam_qtaylor(a,x,p,q)
    else igam_qfraction(a,x,dax,p,q);
  end;
end;





procedure igam_qfraction(a,x,dax: extended; var p,q: extended);
  {-Temme/Gautschi continued fraction for Q(a,x)}
var
  g,r,s,t,y,rho,tau: extended;
begin
  {Ref: Temme [26] function qfraction}
  s := 1.0-a;
  y := x+s;
  p := 0.0;
  q := y*(x-1.0-a);
  r := 4.0*y;
  t := 1.0;
  g := 1.0;
  rho:= 0.0;
  repeat
    p := p + s;
    q := q + r;
    r := r + 8.0;
    s := s + 2.0;
    tau := p*(1.0+rho);
    rho := tau/(q-tau);
    t := rho*t;
    g := g + t;
  until abs(t) < eps_x*abs(g);
  q := g/y*dax;
  p := 1.0-q;
end;




function igam_aux(x: extended): extended;
  {-Temme's function g(x) in 1/Gamma(x) = 1 + x*(x-1)*g(x), x >= -1}
const
  {Maple definition: g := x -> (1/GAMMA(x+1)-1)/(x*(x-1));}
  {chebyshev(g(x), x=0..1, 0.5e-20); calculated with Digits:=30;}
  gan = 17;
  gah : array[0..gan-1] of THexExtW = (
          ($239C,$09A0,$F2BB,$81BD,$BFFF),  {-1.0136092580098657770}
          ($CD4B,$0359,$8CDD,$A0BF,$3FFB),  {+7.8490353102478228353E-2}
          ($D4FE,$74A4,$7C17,$DD79,$3FF7),  {+6.7588668743258315530E-3}
          ($1E68,$B149,$93E4,$A7A5,$BFF5),  {-1.2790434869623468121E-3}
          ($500F,$828F,$C963,$C22B,$3FF0),  {+4.6293983864273958470E-5}
          ($95EA,$C104,$94B3,$9190,$3FED),  {+4.3381681744740351916E-6}
          ($DA7B,$C158,$FD11,$8EFD,$BFEA),  {-5.3268724226180054113E-7}
          ($B0F6,$C479,$89AE,$93F2,$3FE5),  {+1.7223345741053954363E-8}
          ($005A,$13AE,$DF56,$E429,$3FE0),  {+8.3005421071190512062E-10}
          ($3840,$FF67,$B4A5,$E815,$BFDD),  {-1.0553994239956561153E-10}
          ($B1C8,$BD78,$A291,$8AAE,$3FD9),  {+3.9415842852183794790E-12}
          ($AD9E,$0DAE,$A912,$A30F,$3FD2),  {+3.6206853862057649821E-14}
          ($0FA5,$C7C9,$0F38,$C18C,$BFD0),  {-1.0744022741827186475E-14}
          ($8F70,$F721,$8BBB,$9020,$3FCC),  {+5.0004143941936846223E-16}
          ($38FD,$009F,$EE9C,$E667,$BFC5),  {-6.2451667275159614503E-18}
          ($88DA,$7509,$6FFB,$9909,$BFC2),  {-5.1850906707471146260E-19}
          ($4FF8,$4609,$2514,$A3C5,$3FBE)); {+3.4679666990622142954E-20}
var
  ga: array[0..gan-1] of extended absolute gah;

  function csfun(x: extended): extended;
  begin
    csfun := CSEvalX_f(2.0*x-1, ga, gan);
  end;

begin
  {See Temme [26] function auxgam for the ranges. Temme uses a rational}
  {approximation, I use a Chebyshev expansion calculated with Maple V. }
  if x<=-1 then igam_aux := -0.5
  else if x<0.0  then igam_aux := -(1.0+sqr(1.0+x)*csfun(x+1.0))/(1.0-x)
  else if x<=1.0 then igam_aux := csfun(x)
  else if x<=2.0 then igam_aux := ((x-2.0)*csfun(x)-1.0)/sqr(x)
  else igam_aux := (1.0/sfc_gamma(x+1.0)-1.0)/(x*(x-1.0));
end;



procedure igam_qtaylor(a,x: extended; var p,q: extended);
  {-Temme/Gautschi code for Q(a,x) when x < 1}
var
  r,s,t,v,u: extended;
begin
  {Ref: Temme [26] function qtaylor}
  q := powm1(x,a);
  s := -a*(a-1.0)*igam_aux(a);
  u := s - q*(1-s);
  p := a*x;
  q := a + 1.0;
  r := a + 3.0;
  t := 1.0;
  v := 1.0;
  repeat
    p := p + x;
    q := q + r;
    r := r + 2.0;
    t := -p*t/q;
    v := v + t;
  until abs(t) < eps_x*abs(v);
  t := a*(1.0-s)*x*exp_fa(a*ln(x));
  r := t*v/(a+1);
  q := r + u;
  p := 1.0 - q;
end;



procedure igam_ptaylor(a,x,dax: extended; var p,q: extended);
  {-Temme/Gautschi code for P(a,x), dax = x^a*exp(-x)/gamma(a+1)}
var
  c,r: extended;
begin
  {Ref: Temme [26] formula (5.5) and function ptaylor}
  if (a<=0.0) or (x<=0.0) then p := 0.0
  else begin
    r := a;
    c := 1.0;
    p := 1.0;
    repeat
      r := r+1.0;
      c := c*x/r;
      p := p+c;
    until c < p*eps_x;
    p := p*dax/a;
  end;
  q := 1.0 - p;
end;





//gammainvq(100,x/y)
procedure igam_pqasymp(a,x: extended; var p,q: extended);
  {-Incomplete gamma functions for large a and a ~ x}
var
  y,z: extended;
  w: array[0..12] of extended;
const
  N0=18;
  C0: array[0..N0] of extended = (
       -0.333333333333333333333,
        0.0833333333333333333333,
       -0.0148148148148148148148,
        0.00115740740740740740741,
        0.000352733686067019400353,
       -0.0001787551440329218107,
        0.39192631785224377817e-4,
       -0.218544851067999216147e-5,
       -0.18540622107151599607e-5,
        0.829671134095308600502e-6,
       -0.176659527368260793044e-6,
        0.670785354340149858037e-8,
        0.102618097842403080426e-7,
       -0.438203601845335318655e-8,
        0.914769958223679023418e-9,
       -0.255141939949462497669e-10,
       -0.583077213255042506746e-10,
        0.243619480206674162437e-10,
       -0.502766928011417558909e-11);

  N1=16;
  C1: array[0..N1] of extended = (
       -0.00185185185185185185185,
       -0.00347222222222222222222,
        0.00264550264550264550265,
       -0.000990226337448559670782,
        0.000205761316872427983539,
       -0.40187757201646090535e-6,
       -0.18098550334489977837e-4,
        0.764916091608111008464e-5,
       -0.161209008945634460038e-5,
        0.464712780280743434226e-8,
        0.137863344691572095931e-6,
       -0.575254560351770496402e-7,
        0.119516285997781473243e-7,
       -0.175432417197476476238e-10,
       -0.100915437106004126275e-8,
        0.416279299184258263623e-9,
       -0.856390702649298063807e-10);

   N2=14;
   C2: array[0..N2] of extended = (
         0.00413359788359788359788,
        -0.00268132716049382716049,
         0.000771604938271604938272,
         0.200938786008230452675e-5,
        -0.000107366532263651605215,
         0.529234488291201254164e-4,
        -0.127606351886187277134e-4,
         0.342357873409613807419e-7,
         0.137219573090629332056e-5,
        -0.629899213838005502291e-6,
         0.142806142060642417916e-6,
        -0.204770984219908660149e-9,
        -0.140925299108675210533e-7,
         0.622897408492202203356e-8,
        -0.136704883966171134993e-8);

   N3=12;
   C3: array[0..N3] of extended = (
         0.000649434156378600823045,
         0.000229472093621399176955,
        -0.000469189494395255712128,
         0.000267720632062838852962,
        -0.756180167188397641073e-4,
        -0.239650511386729665193e-6,
         0.110826541153473023615e-4,
        -0.56749528269915965675e-5,
         0.142309007324358839146e-5,
        -0.278610802915281422406e-10,
        -0.169584040919302772899e-6,
         0.809946490538808236335e-7,
        -0.191111684859736540607e-7);

   N4=10;
   C4: array[0..N4] of extended = (
        -0.000861888290916711698605,
         0.000784039221720066627474,
        -0.000299072480303190179733,
        -0.146384525788434181781e-5,
         0.664149821546512218666e-4,
        -0.396836504717943466443e-4,
         0.113757269706784190981e-4,
         0.250749722623753280165e-9,
        -0.169541495365583060147e-5,
         0.890750753220530968883e-6,
        -0.229293483400080487057e-6);

   N5=8;
   C5: array[0..N5] of extended = (
        -0.000336798553366358150309,
        -0.697281375836585777429e-4,
         0.000277275324495939207873,
        -0.000199325705161888477003,
         0.679778047793720783882e-4,
         0.141906292064396701483e-6,
        -0.135940481897686932785e-4,
         0.801847025633420153972e-5,
        -0.229148117650809517038e-5);

   N6=10;
   C6: array[0..N6] of extended = (
         0.000531307936463992223166,
        -0.000592166437353693882865,
         0.000270878209671804482771,
         0.790235323266032787212e-6,
        -0.815396936756196875093e-4,
         0.561168275310624965004e-4,
        -0.183291165828433755673e-4,
        -0.307961345060330478256e-8,
         0.346515536880360908674e-5,
        -0.20291327396058603727e-5,
         0.57887928631490037089e-6);

   N7=8;
   C7: array[0..N7] of extended = (
         0.000344367606892377671254,
         0.517179090826059219337e-4,
        -0.000334931610811422363117,
         0.000281269515476323702274,
        -0.000109765822446847310235,
        -0.127410090954844853795e-6,
         0.277444515115636441571e-4,
        -0.182634888057113326614e-4,
         0.578769494973505239894e-5);

   N8=6;
   C8: array[0..N8] of extended = (
        -0.000652623918595309418922,
         0.000839498720672087279993,
        -0.000438297098541721005061,
        -0.696909145842055197137e-6,
         0.000166448466420675478374,
        -0.000127835176797692185853,
         0.462995326369130429061e-4);

   N9=4;
   C9: array[0..N9] of extended = (
        -0.000596761290192746250124,
        -0.720489541602001055909e-4,
         0.000678230883766732836162,
        -0.0006401475260262758451,
         0.000277501076343287044992);

   N10=2;
   C10: array[0..N10] of extended = (
          0.00133244544948006563713,
         -0.0019144384985654775265,
          0.00110893691345966373396);

   N11=4;
   C11: array[0..N11] of extended = (
          0.00157972766073083495909,
          0.000162516262783915816899,
         -0.00206334210355432762645,
          0.00213896861856890981541,
         -0.00101085593912630031708);

   N12=2;
   C12: array[0..2] of extended = (
         -0.00407251211951401664727,
          0.00640336283380806979482,
         -0.00404101610816766177474);
begin
   {Asymptotic expansions of incomplete gamma functions P(a,x) and Q(a,x)}
   {when a is large and x ~ a, }

   {Based on \boost\math\special_functions\detail\igamma_large.hpp [19]}
   {Copyright John Maddock 2006, see 3rdparty.ama for Boost license}

   p := -ln1pmx((x-a)/a);
   y := a*p;
   z := sqrt(2.0*p);
   if x<a then z := -z;

   w[0] := PolEvalX_f(z, C0, 1+N0 );
   w[1] := PolEvalX_f(z, C1, 1+N1 );
   w[2] := PolEvalX_f(z, C2, 1+N2 );
   w[3] := PolEvalX_f(z, C3, 1+N3 );
   //w[4] := PolEvalX(z, C4, 1+N4 );
   w[4] := ((((((((((C4[10]*z+C4[9])*z+C4[8])*z+C4[7])*z+C4[6])*z+C4[5])*z+C4[4])*z+C4[3])*z+C4[2])*z+C4[1])*z+C4[0]);
   //w[5] := PolEvalX(z, C5, 1+N5 );
    w[5] := ((((((((C5[8]*z+C5[7])*z+C5[6])*z+C5[5])*z+C5[4])*z+C5[3])*z+C5[2])*z+C5[1])*z+C5[0]);
   //w[6] := PolEvalX(z, C6, 1+N6 );
   w[6] := ((((((((((C6[10]*z+C6[9])*z+C6[8])*z+C6[7])*z+C6[6])*z+C6[5])*z+C6[4])*z+C6[3])*z+C6[2])*z+C6[1])*z+C6[0]);
   //w[7] := PolEvalX(z, C7, 1+N7 );
   w[7] := ((((((((C7[8]*z+C7[7])*z+C7[6])*z+C7[5])*z+C7[4])*z+C7[3])*z+C7[2])*z+C7[1])*z+C7[0]);
   //w[8] := PolEvalX(z, C8, 1+N8 );
   w[8] := ((((((C8[6]*z+C8[5])*z+C8[4])*z+C8[3])*z+C8[2])*z+C8[1])*z+C8[0]);
   //w[9] := PolEvalX(z, C9, 1+N9 );
   w[9]:= ((((C9[4]*z+C9[3])*z+C9[2])*z+C9[1])*z+C9[0]);
   //w[10]:= PolEvalX(z, C10,1+N10);
    w[10]:= ((C10[2]*z+C10[1])*z+C10[0]);
   //w[11]:= PolEvalX(z, C11,1+N11);
   w[11]:= ((((C11[4]*z+C11[3])*z+C11[2])*z+C11[1])*z+C11[0]);
   //w[12]:= PolEvalX(z, C12,1+N12);
   w[12]:= ((C12[2]*z+C12[1])*z+C12[0]);


   p := PolEvalX_f(1.0/a, w, 13);
   p := p*exp_fa(-y)/sqrt(a*TwoPi);
   if x<a then p := -p;
   p := p + 0.5*sfc_erfc(sqrt(y));
   if x>=a then begin
     q := p;
     p := 1.0 - q;
   end
   else begin
     q := 1.0 - p;
   end;
end;



function igammaq_int(a, x: extended): extended;
  {-Return Q(a,x) when is an integer, a < min(30,x+1)}
var
  s,t: extended;
  n: integer;
begin
  {Ref: Boost [19], gamma.hpp, function finite_gamma_q}
  s := exp_fa(-x);
  if (s>0.0) and (a>=2.0) then begin
    t := s;
    n := 1;
    while n<a do begin
      t := (t/n)*x;
      s := s+t;
      inc(n);
    end;
  end;
  igammaq_int := s;
end;



function igammaq_half(a, x: extended): extended;
  {-Return Q(a,x) when is a half-integer, a < min(30,x+1)}
var
  e,s,t: extended;
  n: integer;
begin
  {Ref: Boost [19], gamma.hpp, function finite_half_gamma_q}
  e := sfc_erfc(sqrt(x));
  if (e<>0.0) and (a>1.0) then begin
    t := 2.0*exp_fa(-x)*sqrt(x/Pi);
    s := t;
    n := 2;
    while n<a do begin
      t := (t/(n-0.5))*x;
      s := s+t;
      inc(n);
    end;
    e := e + s;
  end;
  igammaq_half := e;
end;




function sfc_ibeta(a, b, x: extended): extended;
  {-Return the normalised incomplete beta function, a>0, b>0, 0 <= x <= 1}
  { sfc_ibeta = integral(t^(a-1)*(1-t)^(b-1) / beta(a,b), t=0..x)}
var
  a1, b1, x1, t, w, xc, y: extended;
  flag : boolean;
begin

  {Refs:  Cephes[7], function incbetl in ldouble/incbetl.c}
  {and  Boost [19], beta.hpp; [37] Alg.708, function BASYM}

  if (a <= 0.0) or (b <= 0.0) or (x < 0.0) or (x > 1.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_ibeta := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;

  if (x=0.0) or (x=1.0) then begin
    sfc_ibeta := x;
    exit;
  end
  else if b=1.0 then begin
    sfc_ibeta := power_fa(x,a);
    exit;
  end
  else if (a<1e-22) and (b<1e-22) then begin
   sfc_ibeta  := b/(a+b);
   exit;
  end;

  flag := false;
  w := 1.0 - x;

  {here t corresponds to lambda from [19] and [37]}
  if a>b then t := a - (a+b)*x
  else t := (a+b)*w - b;

  {reverse a and b if x is greater than the mean}
  if t < 0 then begin
    flag := true;
    a1 := b;
    b1 := a;
    xc := x;
    x1 := w;
    t  := -t;
  end
  else begin
    a1 := a;
    b1 := b;
    xc := w;
    x1 := x;
  end;

  if (a>=100.0) and (b>=100.0) then begin
    {Check if asymptotic expansion can be used}
    if ((a1<=b1) and (t<=0.03*a1)) or ((a1>b1) and (t<=0.03*b1)) then begin
      t := basym(a1,b1,t,100.0*eps_x);
      if t>=0.0 then begin
        {convergence with current basym array size}
        if flag then t := 1.0 - t;
        sfc_ibeta := t;
        exit;
      end;
    end;
  end;

  if (b1<=40) and (frac(b1)=0) and (a1<=32000) and (frac(a1)=0) then begin
    {Use finite sum related to binomial distribution}
    t := ccdf_binom(round(a1+b1-1),round(a1-1), x1, xc);
  end
  else if (b1*x1 <= 1.0) and (x1 <= 0.95) then begin
    t := ibeta_series(a1, b1, x1, true);
  end
  else begin
    {choose expansion for optimal convergence}
    y := x1*(a1 + b1 - 2.0) - (a1 - 1.0);
    if y < 0.0 then w := ibeta_cf(a1, b1, x1, false)
    else w := ibeta_cf(a1, b1, x1, true) / xc;
    {$ifdef VER50}
       {multiply w by the factor x^a*(1-x)^b*gamma(a+b)/(a*gamma(a)*gamma(b))}
       if flag then begin
         {here xc=x and x1=1-x}
         y := a1*ln1p(-x);
         t := b1*ln(x);
       end
       else begin
         {here x1=x and xc=1-x}
         y := a1*ln(x);
         t := b1*ln1p(-x);
       end;
       if (a1+b1 < MAXGAMX) and (abs(y) < ln_MaxExt) and (abs(t) < ln_MaxExt) then begin
         t := power_fa(xc, b1) ;
         y := power_fa(x1, a1);
         t := (t*y/a1)*w;
         t := t/sfc_beta(a1,b1);
       end
       else begin
         {resort to logarithms}
         t := t - sfc_lnbeta(a1,b1);
         y := y + ln(w/a1);
         t := exp_fa(y+t);
       end;
    {$else}
      t := sfc_ibetaprefix(a1,b1,x1,xc);
      t := w*(t/a1);
    {$endif}
  end;

  if flag then sfc_ibeta := 1.0 - t
  else sfc_ibeta := t;

end;





function ibeta_cf(a, b, x: extended; type2: boolean): extended;
  {-Continued fraction expansion type #1 or #2 for incomplete beta integral}
var
  xk, pk, pkm1, pkm2, qk, qkm1, qkm2: extended;
  k1, k2, k3, k4, k5, k6, k7, k8: extended;
  dk, r, t, ans, big, thresh: extended;
  i,imax: integer;
begin
  {Ref: Cephes [7], functions incbcfl & incbdl in ldouble/incbetl.c}
  {The two continued fraction from [7] are almost identical and are}
  {merged into a single routine, selected by the type2 parameter.}
  k1 := a;
  k3 := a;
  k4 := a + 1.0;
  k5 := 1.0;
  k7 := k4;
  k8 := a + 2.0;

  pkm2 := 0.0;
  qkm2 := 1.0;
  pkm1 := 1.0;
  qkm1 := 1.0;

  ans  := 1.0;
  big  := ldexp(1,63);

  r := 1.0;
  t := sqrt(maxx(a,b));
  if t<400.0 then t := 400.0
  else if t>32000.0 then t := 32000.0;
  imax := round(t);

  thresh := 3.0*eps_x;
  if type2 then begin
    k2 := b - 1.0;
    k6 := a + b;
    dk := -1.0;
    x  := x/(1.0 - x);
  end
  else begin
    k2 := a + b;
    k6 := b - 1.0;
    dk := 1.0;
  end;

  for i:=1 to imax do begin
    xk := - (x * k1 * k2) / (k3 * k4);
    pk := pkm1 + pkm2 * xk;
    qk := qkm1 + qkm2 * xk;
    pkm2 := pkm1;
    pkm1 := pk;
    qkm2 := qkm1;
    qkm1 := qk;

    xk := (x * k5 * k6) / (k7 * k8);
    pk := pkm1 + pkm2 * xk;
    qk := qkm1 + qkm2 * xk;
    pkm2 := pkm1;
    pkm1 := pk;
    qkm2 := qkm1;
    qkm1 := qk;

    if qk <> 0.0 then r := pk / qk;
    if r <> 0.0 then begin
      t := abs((ans - r) / r);
      ans := r;
    end
    else t := 1.0;

    if t < thresh then begin
      ibeta_cf := ans;
      exit;
    end;

    k1 := k1 + 1.0;
    k2 := k2 + dk;
    k3 := k3 + 2.0;
    k4 := k4 + 2.0;
    k5 := k5 + 1.0;
    k6 := k6 - dk;
    k7 := k7 + 2.0;
    k8 := k8 + 2.0;

    if abs(qk) + abs(pk) > big then begin
      pkm2 := pkm2 * eps_x;
      pkm1 := pkm1 * eps_x;
      qkm2 := qkm2 * eps_x;
      qkm1 := qkm1 * eps_x;
    end;
    if (abs(qk) < eps_x) or (abs(pk) < eps_x) then begin
      pkm2 := pkm2 * big;
      pkm1 := pkm1 * big;
      qkm2 := qkm2 * big;
      qkm1 := qkm1 * big;
    end;

  end;

  if RTE_NoConvergence>0 then begin
    RunError(byte(RTE_NoConvergence));
  end;
  ibeta_cf := ans;
end;



function basym(a,b,lambda,eps: extended): extended;
  {-Return I_x(a,b) for large a,b. lambda = (a+b)*(1-x) - b, }
  { eps is the tolerance used. It is assumed that lambda is  }
  { nonnegative and that a,b are greater than or equal to 15.}
  { -1 is returned if no convergence for array size num.     }
const
  num = 20; {maximum n value in the main repeat loop, must be even.}
  e0  = 1.128379167095512573896; {2/sqrt(Pi)}
  e1  = 0.353553390593273762200; {2^(-3/2)}
var
  a0,b0,c,d: array[0..num] of extended;
var
  h,r,s,t,w,j0,j1,h2,r0,r1,t0,t1,w0,z0,z2,hn,zn,sum,znm1,bsum,dsum: extended;
  i,j,m,n,im1,mm1,mmj: integer;
  done: boolean;
begin
  {Ref: [37] Algorithm 708, function BASYM}
  {ln1pmx = -rlog1}
  h := -a*ln1pmx(-lambda/a);
  t := -b*ln1pmx(lambda/b);
  h := h+t;
  t := exp_fa(-h);
  if t=0.0 then begin
    basym := 0.0;
    exit;
  end;

  z0  := sqrt(h);
  z2  := 2.0*h;
  znm1:= 0.5*z0/e1;
  if a<b then begin
    h  := a/b;
    r0 := 1.0/(1.0+h);
    r1 := (b-a)/b;
    w0 := 1.0/sqrt(a*(1.0+h));
  end
  else begin
    h  := b/a;
    r0 := 1.0/(1.0+h);
    r1 := (b-a) / a;
    w0 := 1.0/sqrt(b*(1.0+h));
  end;

  a0[0]:= (2.0*r1)/THREE;
  c[0] := -0.5*a0[0];
  d[0] := -c[0];
  j0   := sfc_erfce(z0)*0.5/e0;
  j1   := e1;
  sum  := j0 + d[0]*w0*j1;
  s    := 1.0;
  h2   := h*h;
  hn   := 1.0;
  w    := w0;
  zn   := z2;

  n := 2;
  repeat
    hn := h2*hn;
    s  := s + hn;
    a0[n-1]:= 2.0*r0*(1.0+h*hn)/(n+2);
    a0[n]  := 2.0*r1*s/(n+3);

    for i:=n to n+1 do begin
      im1 := pred(i);
      r   := -0.5*succ(i);
      b0[0] := r*a0[0];
      for m:=2 to i do begin
        bsum := 0.0;
        mm1  := m-1;
        for j:=1 to mm1 do begin
          mmj := m-j;
          bsum := bsum + (j*r - mmj)*a0[j-1]*b0[mmj-1];
        end;
        b0[mm1] := r*a0[mm1] + bsum/m;
      end;
      c[im1] := b0[im1]/succ(i);
      dsum := 0.0;
      for j:=1 to im1 do dsum := dsum + d[im1-j]*c[j-1];
      d[im1] := -(dsum + c[im1]);
    end;

    j0 := e1*znm1 + (n-1)*j0;
    j1 := e1*zn   + n*j1;
    znm1 := z2*znm1;
    zn := z2*zn;
    w  := w0*w;
    t0 := d[n-1]*w*j0;
    w  := w0*w;
    t1 := d[n]*w*j1;
    sum := sum + (t0+t1);
    inc(n,2);
    done := abs(t0) + abs(t1) <= eps*sum;
  until done or (n>num);

  if done then begin
    {compute w = exp(-bcorr(a,b)) using sfc_lngcorr}
    w := sfc_lngcorr(b) - sfc_lngcorr(a+b);
    w := w + sfc_lngcorr(a);
    w := exp_fa(-w);
    basym := e0*t*w*sum;
  end
  else basym := -1;
end;






function sfc_erfce(x: extended): extended;
  {-Return the exponentially scaled complementary error function erfce(x) = exp(x^2)*erfc(x)}
var
  y,z: extended;
const
  xmin = -106.5637380121098417;
begin
  if IsNan(x) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
     GenerateFPUException(FPUErrorNAN);{.375}
     sfc_erfce := NaN_x;
    exit;
  end;
  y := abs(x);
  if y <= 1e-10 then sfc_erfce := 1.0 - 2.0*x/SqrtPi
  else if y <= 1.0 then begin
    z := 1.0-erf_small(x);
    sfc_erfce := exp_fa(x*x)*z;
  end
  else if x < -x0e then begin
    {here erfc(x)=2.0 accurate to extended precision}
    if x < xmin then sfc_erfce := PosInf_x
    else sfc_erfce := 2.0*expx2_fa(y);
  end
  else if y <= 128.0 then begin
    { -x0e < x <= 128: Recycle sfc_erfc_iusc}
    sfc_erfc_iusc(y,y,z);
    y := y/z;
    if x>0.0 then sfc_erfce := y
    else begin
      z := 2.0*expx2_fa(-x);
      sfc_erfce := z-y;
    end;
  end
  else begin
    {x > 128: use asymptotic expansion}
    if x > 0.5e10 then z := 1.0
    else begin
      y := 0.5/sqr(x);
      {erfce = (1 - y + 3y^2 - 15y^3 + 105y^4 - 945y^5 + O(y^6))/x/sqrt(pi)}
      z := (105.0 - 945.0*y)*y - 15.0;
      z := (z*y + 3.0)*y - 1.0;
      z := z*y + 1.0;
    end;
    sfc_erfce := z/x/sqrtpi;
  end;
end;



function ccdf_binom(n,k: integer; x,y: extended): extended;
  {-Return complement of the binomial distribution}
var
  s,t,p: extended;
  i: integer;
begin
  {Ref: Boost [19], beta.hpp, function binomial_ccdf}
  p := power_fa(x,n);
  s := 1.0;
  if p>0.0 then begin
    t := s;
    for i:=pred(n) downto succ(k) do begin
      t := t*(succ(i)*y);
      t := t/((n-i)*x);
      s := s + t;
    end;
  end;
  ccdf_binom := s*p;
end;



function ibeta_series(a, b, x: extended; normalised: boolean): extended;
  {-Power series for incomplete beta integral. Use when b*x is small }
var
  s, t, u, v, t1, z, ai: extended;
  n: integer;
const
  nmax = 30000;
begin
  {Ref: Cephes [7], function pseriesl in ldouble/incbetl.c}
  ai := 1.0/a;
  u  := (1.0-b)*x;
  v  := u/(a+1.0);
  t1 := v;
  t  := u;
  n  := 2;
  s  := 0.0;
  z  := abs(t1+ai)*eps_x;
  if z=0.0 then z := sqr(eps_x);
  repeat
    u := (n - b)*x/n;
    t := t*u;
    v := t/(a + n);
    s := s + v;
    n := n + 1;
  until (abs(v) <= z) or (n>nmax);

  if (n>=nmax) and (RTE_NoConvergence>0) then begin
    RunError(byte(RTE_NoConvergence));
  end;

  s := (s + t1) + ai;
  if normalised then begin
    if a+b < MAXGAMX then begin
      t := sfc_beta(a,b);
      ibeta_series := s/t*power_fa(x, a);
    end
    else begin
      u := a*ln(x);
      s := ln(s);
      t := sfc_lnbeta(a,b);
      ibeta_series := exp_fa((u+s)-t);
    end;
  end
  else begin
    {no overflow because x <= 1, a > 0}
    ibeta_series := s*power_fa(x, a);
  end;
end;






function sfc_hypergeo_pmf(n1,n2,n,k: longint): extended;
  {-Return the hypergeometric distribution probability mass function; n,n1,n2 >= 0, n <= n1+n2;}
  { i.e. the probability that among n randomly chosen samples from a container}
  { with n1 type1 objects and n2 type2 objects are exactly k type1 objects:}
var
  b1,b2,b3,p,q: extended;
begin
  {Result = binomial(n1,k)*binomial(n2,n-k)/binomial(n1+n2,n)}
  if (n1<0) or (n2<0) or (n<0) or (n>n1+n2) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_hypergeo_pmf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  sfc_hypergeo_pmf := 0.0;
  if (k<0) or (k>n1) or (k>n) then exit;
  if (n2<n) and (k<n-n2) then exit;
  if n1+n2 = 0 then begin
    {here n=n1=n2=0; result is 1 if k=1 and 0 otherwise}
    if k=0 then sfc_hypergeo_pmf := 1.0;
  end
  else begin
    p  := n/(n1+n2);
    q  := (n1+n2-n)/(n1+n2);
    {R trick: use binomial_pmf with p=n/(n1+n2) instead of binomial()}
    b1 := bin_raw(p,q,n1,k);
    b2 := bin_raw(p,q,n2,n-k);
    b3 := bin_raw(p,q,n1+n2,n);
    sfc_hypergeo_pmf := b1*(b2/b3);
  end;
end;




function bin_raw(p,q: extended; n, k: longint): extended;
  {-Return raw binomial(n,k)*p^k*q^(n-k) without arg check}
var
  lc,lf: extended;

  function bd0(x,np: extended): extended;
    {-Return "deviance part", see Loader article}
  var
    ej, s, s1, v: extended;
    j: integer;
  begin
    if abs(x-np) < 0.1*(x+np) then begin
      v  := (x-np)/(x+np);
      s  := (x-np)*v;
      ej := 2.0*x*v;
      v  := v*v;
      j  := 3;
      repeat
        ej := ej*v;
        s1 := s + ej/j;
        if s=s1 then begin
          bd0 := s1;
          exit;
        end;
        s := s1;
        inc(j,2);
      until j<0;
    end;
    bd0 := x*ln(x/np)+np-x;
  end;

  function stirlerr(k: longint): extended;
    {-sfc_lngcorr for integer, avaoid lngamma for small k}
  const
    sterr: array[0..7] of extended = (
             0,
             0.81061466795327258219670263595e-1,
             0.41340695955409294093822081405e-1,
             0.27677925684998339148789292755e-1,
             0.20790672103765093111522771755e-1,
             0.16644691189821192163194865355e-1,
             0.13876128823070747998745727025e-1,
             0.11896709945891770095055724095e-1);
  begin
    if k>=8 then stirlerr := sfc_lngcorr(k)
    else stirlerr := sterr[k];
  end;

begin
  {Raw binomial pmf used in hypergeometric pmf based on R function dbinom.c and}
  {Catherine Loader (2000). Fast and Accurate Computation of Binomial Probabilities}
  {http://projects.scipy.org/scipy/raw-attachment/ticket/620/loader2000Fast.pdf}
  if (k<0) or (k>n) then bin_raw := 0.0
  else if n=0 then bin_raw:= 1.0
  else if k=0 then bin_raw:= IntPower_fa(q,n)// power(q, n)
  else if k=n then bin_raw:= IntPower_fa(p,n)//power(p, n)
  else begin
    {$ifdef VER50}
      lc := stirlerr(n);
      lf := stirlerr(k);    lc := lc-lf;
      lf := stirlerr(n-k);  lc := lc -lf;
      lf := bd0(k,n*p);     lc := lc -lf;
      lf := bd0(n-k,n*q);   lc := lc -lf;
    {$else}
      lc := stirlerr(n) - stirlerr(k) - stirlerr(n-k) - bd0(k,n*p) - bd0(n-k,n*q);
    {$endif}
    lf := ln(TwoPi) + ln(k) + ln1p(-k/n);
    bin_raw := exp_fa(lc - 0.5*lf);
  end;
end;




function sfc_normal_pdf(mu, sd, x: extended): extended;
  {-Return the normal (Gaussian) probability density function with mean mu}
  { and standard deviation sd>0, exp(-0.5*(x-mu)^2/sd^2) / sqrt(2*Pi*sd^2)}
begin
  if sd <= 0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_normal_pdf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  sfc_normal_pdf := sfc_erf_z((x-mu)/sd)/sd;
end;




function sfc_erf_z(x: extended): extended;
  {-Return the probability function erf_z = exp(-x^2/2)/sqrt(2*Pi)}
begin
  if IsNan(x) then sfc_erf_z := x
  else if abs(x) > 151.0 then sfc_erf_z := 0.0
  else sfc_erf_Z := expmx2h(x)/Sqrt_TwoPi;
end;





function sfc_erf_p(x: extended): extended;
  {-Return the probability function erf_p = integral(exp(-t^2/2)/sqrt(2*Pi), t=-Inf..x)}
const
  SQRTH = 0.7071067811865475244008;  {sqrt(0.5)=($6484,$F9DE,$F333,$B504,$3FFE)}
var
  y,z: extended;
begin
  if IsNan(x) then begin
    sfc_erf_p := x;
    exit;
  end;
  {erf_p = (1 + erf(z))/2 = erfc(z)/2, where z = x/sqrt(2)}
  y := x*SQRTH;
  z := abs(y);
  if z<1.0 then sfc_erf_p := 0.5 + 0.5*sfc_erf(y)
  else if x<-150.7 then sfc_erf_p := 0.0
  else if x>=9.5 then sfc_erf_p := 1.0
  else begin
    sfc_erfc_iusc(z,y,z);
    y := 0.5*y/z;
    y := y*expmx2h(x);
    if x<0.0 then sfc_erf_p := y
    else sfc_erf_p := 1.0 - y;
  end;
end;




function expmx2h(x: extended): extended;
  {-Return exp(-0.5*x^2) with damped error amplification}
const
  MFAC = 32768.0;
  MINV = 3.0517578125e-5;
var
  u,u1,m,f: extended;
begin
  {Ref: Cephes [7], file ldouble\expx2l.c}
  x := abs(x);
  if x >= 150.994 then expmx2h := 0.0
  else if x <= 2.0 then begin
    expmx2h := exp_fa(-0.5*x*x);
  end
  else begin
    {Represent x as an exact multiple of MFAC plus a residual.}
    {MFAC is a power of 2 chosen so that exp(m * m) does not  }
    {overflow or underflow and so that |x - m| is small.      }
    m := MINV*floorx(MFAC*x + 0.5);
    f := x - m;
    {0.5*x^2 = 0.5*(m^2 + mf + f^2)}
    u  := (-0.5)*m*m;
    u1 := (-0.5)*f*f - m*f;
    {u is exact, u1 is small}
    expmx2h := exp_fa(u)*exp_fa(u1);
  end;
end;



function sfc_poisson_pmf(mu: extended; k: longint): extended;
  {-Return the Poisson distribution probability mass function with mean mu >= 0}
var
  t: extended;
begin
  if mu<0.0 then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_poisson_pmf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if k<0.0 then sfc_poisson_pmf := 0.0
  else
  if mu=0.0 then
  begin
    if k=0 then sfc_poisson_pmf := 1.0
    else sfc_poisson_pmf := 0.0;
  end
  else begin
    if mu<eps_x then begin
      t := sfc_igprefix(k,mu);
      sfc_poisson_pmf := t/k
    end
    else begin
      t := sfc_igprefix(k+1,mu);
      sfc_poisson_pmf := t/mu;
    end;
  end;
end;





function sfc_igprefix(a,x: extended): extended;
  {-return x^a*exp(-x)/gamma(a) using Lanczos sum}
const
  e1h: THexExtW = ($BE35,$6779,$B1B1,$BC5A,$3FFD);  {+3.6787944117144232158E-1}
var
  prefix,agh,alx,amx,amxa,d,mina,maxa: extended;
  em1: extended absolute e1h;  {1/e}
begin
  {Ref: Boost [19], gamma.hpp, function regularised_gamma_prefix}
  if a<1.0 then begin
    if x<Ln_MaxExt then sfc_igprefix := power_fa(x,a)*exp_fa(-x)/sfc_gamma(a)
    else begin
      {underflow exp(-x)}
      d := sfc_lngamma(a);
      prefix := a*ln(x) - x - d;
      sfc_igprefix := exp_fa(prefix);
    end;
    exit;
  end;

  agh := a + lanczos_gm05;
  d := ((x-a) - lanczos_gm05)/agh;
  if ((abs(d*d*a) <= 100.0) and (a > 150.0)) then begin
    prefix := a*ln1pmx(d) - x*lanczos_gm05/agh;
    prefix := exp_fa(prefix);
  end
  else begin
    alx := a * ln(x/agh);
    amx := a - x;
    if alx < amx then begin
      mina := alx;
      maxa := amx;
    end
    else begin
      maxa := alx;
      mina := amx;
    end;
    if (mina <= ln_MinExt) or (maxa >= ln_MaxExt) then begin
      amxa := amx/a;
      if (0.5*mina > ln_MinExt) and (0.5*maxa < ln_MaxExt) then begin
        {compute square root of the result and then square it}
        prefix := power_fa(x/agh, 0.5*a)*exp_fa(0.5*amx);
        prefix := sqr(prefix);
      end
      else if (0.25*mina > ln_MinExt) and (0.25*maxa < ln_MaxExt) and (x > a) then begin
        {compute the 4th root of the result then square it twice}
        prefix := power_fa(x/agh, 0.25*a)*exp_fa(0.25*amx);
        prefix := sqr(sqr(prefix));
      end
      else if ((amxa > ln_MinExt) and (amxa < ln_MaxExt)) then begin
        prefix := power_fa((x*exp_fa(amxa))/agh, a);
      end
      else prefix := exp_fa(alx + amx);
    end
    else begin
      prefix := power_fa(x/agh,a)*exp_fa(amx);
    end;
  end;
  sfc_igprefix := prefix*sqrt(agh*em1)/lanczos(a, true);
end;





function ln1pmx(x: extended): extended;
  {-Return ln(1+x)-x, x>-1, accurate even for -0.5 <= x <= 1.0}
const
  c9 = 2.0/9.0;
  c7 = 2.0/7.0;
  c5 = 2.0/5.0;
  c3 = 2.0/3.0;
  xm = -0.525;
  xp =  1.05;
  x0 =  0.016;
var
  y,z: extended;
begin
  {Based on function log1 by Ian Smith [25]}
  if (x<xm) or (x>xp) then ln1pmx := ln(1.0+x)-x
  else begin
    z := x/(2.0 + x);
    y := z*z;
    if abs(x)>x0 then y := 2.0*y*logcf(y, 3.0, 2.0)
    else y := (((c9*y + c7)*y + c5)*y + c3)*y;
    ln1pmx := z*(y-x);
  end;
end;




function logcf(x,i,d: extended): extended;
  {-Calculate 1/i + x/(i+d) + x^2/(i+2*d) + x^3/(i+3d) .. via continued fractions}
var
  c1,c2,c3,c4,a1,b1,a2,b2: extended;
const
  hugeh: THexExtW = ($0000,$0000,$0000,$8000,$43FF); {2^1024}
  tinyh: THexExtW = ($0000,$0000,$0000,$8000,$3BFF); {1/2^1024}
var
  huge: extended absolute hugeh;
  tiny: extended absolute tinyh;
begin
  {Pascal translation of function logcf by Ian Smith [25]}
  c1 := 2.0*d;
  c2 := i + d;
  c4 := c2 + d;
  a1 := c2;
  b1 := i*(c2 - i*x);
  b2 := d*d*x;
  a2 := c4*c2 - b2;
  b2 := c4*b1 - i*b2;

  while abs(a2*b1-a1*b2) > abs(eps_x*b1*b2)  do begin
    c3 := c2*c2*x;
    c2 := c2 + d;
    c4 := c4 + d;
    a1 := c4*a2 - c3*a1;
    b1 := c4*b2 - c3*b1;

    c3 := c1*c1*x;
    c1 := c1 + d;
    c4 := c4 + d;
    a2 := c4*a1 - c3*a2;
    b2 := c4*b1 - c3*b2;

    c3 := abs(b2);
    if c3 > huge then begin
      a1 := a1*tiny;
      b1 := b1*tiny;
      a2 := a2*tiny;
      b2 := b2*tiny;
    end
    else if c3 < tiny then begin
      a1 := a1*huge;
      b1 := b1*huge;
      a2 := a2*huge;
      b2 := b2*huge;
    end;
  end;

  logcf := a2 / b2;
end;




function sfc_binomial(n,k: integer{; dbl: boolean}): extended;
  {-Return the binomial coefficient 'n choose k'; set dbl=true, if used in SpecFun}
var
  t,a: extended;
  i,m: integer;
  function lnf0(m: integer): extended;
    {-Return quick and dirty approximation of ln(m!)}
  begin
    lnf0 := (0.5+m)*ln(1.0+m)-m;
  end;
begin
  (*
  Accuracy of sfc_binomial, random values 0<=k<=n, computed with t_binom
  Range (n)      Samples   RMS           Peak
      0.. 1000   20000     1.2087E-19    5.9631E-19  for (820,415)
   1000.. 1700   20000     1.4733E-19    6.5052E-19  for (1678,331)
   1700.. 8000   20000     1.4177E-18    7.4801E-18  for (7185,4779)
   8000..16000   10000     2.0377E-16    1.2166E-15  for (14557,6857)
  16000..32000   10000     1.8608E-16    1.2806E-15  for (18717,4636)
  *)

  {If n<0 and k>=0, we use the identity 1.2.6 (17) from D.E. Knuth: The art}
  {of computer programming, Vol. 1, Fundamental algorithms, 3rd ed., 1997.}
  {[*]   binomial(n,k) = (-1)^k * binomial(k-n-1,k)}

  if (k=0) or (k=n) then sfc_binomial := 1.0
  else if (k=1) or (k=pred(n)) then sfc_binomial := n
  else if k<0 then begin
    if (n>=0) or (n<k) then sfc_binomial := 0.0
    else begin
      {Here k <= n < 0:  We use binomial(n,k) = binomial(n,n-k) which is}
      {valid for all integer k, and then use [*] since n<0 and n-k >= 0:}
      {binomial(n,k) = (-1)^(n-k)*binomial(n-k-n-1,n-k)}
      i := n-k;
      t := sfc_binomial(-succ(k),i);
      if (t<>0.0) and odd(i) then sfc_binomial := -t
      else sfc_binomial := t;
    end;
  end
  else if n<0 then begin
    {Here n < 0 and k >= 0. Apply Knuth's [*] identity}
    t := sfc_binomial(k-n-1,k);
    if (t<>0.0) and odd(k) then sfc_binomial := -t
    else sfc_binomial := t;
  end
  else if k>n then sfc_binomial := 0.0
  else begin
    {here n > 2 and  1 < k < n-1}
    if n<MAXGAMX-1 then begin
      {t := sfc_fac(n);
      t := t/sfc_fac(n-k);
      t := t/sfc_fac(k); }
      t :=_factorial(n);
      t := t/_factorial(n-k);
      t := t/_factorial(k);
    end
    else begin
      {if k>n/2 use symmetry to reduce k}
      if k>n-k then k := n-k;
      {all (n,k) with n <= m will NOT overflow,}
      {this saves three logarithm calculations.}

      {if dbl then begin
        a := 750;
        m := 1029;
      end
      else}

      begin
        a := 11500;
        m := 16391;
      end;
      if n<=m then t:=0
      else begin
        {Calculate rough estimate t}
        t := lnf0(k);
        t := t + lnf0(n-k);
        t := lnf0(n)-t;
      end;
      if t>a then begin
        {don't waste time (especially for double), if result is INF}
        t := PosInf_x
      end
      else if (t<11300) and (k<=4000) then begin
        {Compute n*(n-1).../k! if k is 'small' and no risk of overflow}
        t := n;
        inc(n);
        for i:=2 to k do t := t*((n-i)/i);
      end
      else begin
        {Here n > 8000 and k > 4000, or a very large result > 1.7e4777.}
        {Use lnbeta function (increased inaccuracy for 'large' values)}
        t := sfc_lnbeta(k,n-k+1);
        t := k*exp_fa(t);
        if t<MinExtended then begin
          {for t > 0.25*MinExtended inversion will not overflow}
          if 4.0*t<MinExtended then t := PosInf_x
          else t := 1.0/t;
        end
        else t := 1.0/t;
      end;
    end;
    {round to nearest integer value}
    sfc_binomial := int(t+0.5);
  end;
end;




function lanczos(x: extended; egscale: boolean): extended;
  {-Return the Lanczos sum for x, exp(g) scaled if egscale=true}
const
  lsh:  array[0..12] of THexExtW = (
          ($6F92,$D992,$7F81,$A01D,$402C),  {+4.4012138428004608955E+13}
          ($CD54,$4004,$20CB,$974E,$402C),  {+4.1590453358593200516E+13}
          ($F967,$596F,$659A,$8311,$402B),  {+1.8013842787117996778E+13}
          ($71D8,$A66C,$D4A5,$899F,$4029),  {+4.7287362634753888969E+12}
          ($96F3,$2C67,$5538,$C317,$4026),  {+8.3791008362840464705E+11}
          ($817F,$4B70,$3C24,$C4AA,$4023),  {+1.0558370727342993449E+11}
          ($125B,$9FAE,$C3E8,$908F,$4020),  {+9.7013636184949994935E+9}
          ($B883,$315C,$CD76,$9C24,$401C),  {+6.5491439754820526409E+8}
          ($29BA,$97D5,$7978,$F5F5,$4017),  {+3.2238322942133565306E+7}
          ($EA59,$87B0,$11C1,$89C2,$4013),  {+1.1285142194970914380E+6}
          ($0534,$EF56,$966A,$D053,$400D),  {+2.6665793784598589447E+4}
          ($8931,$781E,$A7EE,$BEF0,$4007),  {+3.8188012486329268705E+2}
          ($2CB3,$B138,$98FF,$A06C,$4000)); {+2.5066282746310005025}
  lseh: array[0..12] of THexExtW = (
          ($EBF0,$180B,$E131,$A434,$4019),  {+8.6091529534185372176E+7}
          ($A3D3,$B6ED,$E125,$9B2B,$4019),  {+8.1354505178580112428E+7}
          ($78B7,$D786,$C498,$866A,$4018),  {+3.5236626388154619108E+7}
          ($F7DC,$EF2B,$16FC,$8D24,$4016),  {+9.2498149880244712949E+6}
          ($8D43,$C678,$81BB,$C813,$4013),  {+1.6390242166871469602E+6}
          ($D9B5,$7AB8,$B435,$C9B0,$4010),  {+2.0653081576412250327E+5}
          ($A231,$1063,$6764,$9441,$400D),  {+1.8976701935302889156E+4}
          ($059E,$8F9A,$3482,$A022,$4009),  {+1.2810689099125594799E+3}
          ($35CD,$8C87,$6555,$FC3E,$4004),  {+6.3060933434202345361E+1}
          ($950B,$1B89,$3411,$8D47,$4000),  {+2.2074709097925276381}
          ($3037,$2E58,$56F1,$D5A6,$3FFA),  {+5.2160586946135054274E-2}
          ($653E,$8220,$AD06,$C3D1,$3FF4),  {+7.4699038089154483163E-4}
          ($6259,$720D,$001B,$A486,$3FED)); {+4.9031805734598718626E-6}
type
  TX12 = array[0..12] of extended;

  function lratev(const num: TX12; z: extended): extended;
  const
    denom: TX12 = ( 0.0,
                    39916800.0,
                    120543840.0,
                    150917976.0,
                    105258076.0,
                    45995730.0,
                    13339535.0,
                    2637558.0,
                    357423.0,
                    32670.0,
                    1925.0,
                    66.0,
                    1.0);
  var
    s1,s2: extended;
    i: integer;
  begin
    if abs(z)<=1.0 then begin
      s1 := num[12];
      s2 := denom[12];
      for i:=11 downto 0 do begin
        s1 := s1*z + num[i];
        s2 := s2*z + denom[i];
      end;
    end
    else begin
      z  := 1.0/z;
      s1 := num[0];
      s2 := denom[0];
      for i:=1 to 12 do begin
        s1 := s1*z + num[i];
        s2 := s2*z + denom[i];
      end;
    end;
    lratev := s1/s2;
  end;

begin
  {Ref: Boost [19], lanczos.hpp, struct lanczos13}
  if egscale then lanczos := lratev(TX12(lseh), x)
  else lanczos := lratev(TX12(lsh), x);
end;




function sfc_lnbeta(x,y: extended): extended;
  {-Return the logarithm of |beta(x,y)|=|gamma(x)*gamma(y)/gamma(x+y)|}
var
  c,s: extended;
begin
  if IsNanOrInf(x) or IsNanOrInf(x) then
  begin
    sfc_lnbeta := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  {based on SLATEC [14] routine dlbeta.f}
  {force x <= y}
  if x>y then begin
    c := x;
    x := y;
    y := c;
  end;
  s := x+y;
  if x >= XLGAE then begin
    {x and y >= XLGAE}
    c := sfc_lngcorr(x) + sfc_lngcorr(y) - sfc_lngcorr(s);
    sfc_lnbeta := -0.5*ln(y) + lnsqrt2pi + c + (x-0.5)*ln(x/s) + y*ln1p(-x/s);
  end
  else if (y >= XLGAE) and (s >= XLGAE) then begin
    {Fixed in 1.02.01: check s >= XLGAE, otherwise lnbeta(-10.1,10) fails}
    {x < XLGAE, y >= XLGAE}
    c := sfc_lngcorr(y) - sfc_lngcorr(s);
    {$ifdef VER50}
      c := sfc_lngamma(x) + c + x;
      c := c - x*ln(s);
      sfc_lnbeta := c + (y-0.5)*ln1p(-x/s);
    {$else}
      sfc_lnbeta := sfc_lngamma(x) + c + x - x*ln(s) + (y-0.5)*ln1p(-x/s)
    {$endif}
  end
  else begin
    {x,y < XLGAE; or s<=0}
    sfc_lnbeta := sfc_lngamma(x) + sfc_lngamma(y) - sfc_lngamma(s);
  end;
end;





function sfc_rgamma(x: extended): extended;
  {-Return the reciprocal gamma function rgamma = 1/gamma(x)}
begin
  if IsNanOrInf(x) then
  begin
    if x=PosInf_x then sfc_rgamma := 0.0
    else
    begin
      sfc_rgamma := NaN_x;
      GenerateFPUException(FPUErrorNAN);{.375}
    end;
  end
  else if abs(x)<0.03125 then sfc_rgamma := sfc_gaminv_small(x)
  else if (x<0.0) and (frac(x)=0.0) then sfc_rgamma := 0.0
  else begin
    {
    if (x<-0.5) or (x>XLGAE) then sfc_rgamma := sfc_signgamma(x)*exp(power(-sfc_lngamma(x))
    else sfc_rgamma := 1.0/sfc_gamma_medium(x);
    }
    if (x<-0.5) or (x>=MAXGAMX) then sfc_rgamma := sfc_signgamma(x)*exp_fa(-sfc_lngamma(x))
    else if x <= 13.0 then sfc_rgamma := 1.0/sfc_gamma_medium(x)
    else sfc_rgamma := 1.0/stirf(x);
  end;
end;



function sfc_gdr_pos(x,d: extended): extended;
  {-Return gamma(x)/gamma(x+d), x>0, x+d > 0, accurate even for |d| << |x|}
var
  xgh,res: extended;
begin
  {$ifdef debug}
    if (x <= 0.0) and (x+d <= 0.0) then
    begin
      {$ifopt R+}
        if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
      {$endif}
      sfc_gdr_pos := NaN_x;
      GenerateFPUException(FPUErrorNAN);{.375}
      exit;
    end;
  {$endif}
  if x<eps_x then begin
    {x small, Gamma(x)=1/x. Result = rGamma(x+d)/x}
    {but avoid spurious underflow if x+d > MAXGAMX}
    d := x+d;
    if d<MAXGAMX then sfc_gdr_pos := sfc_rgamma(d)/x
    else begin
      {Note very accurate but better than underflow}
      res := sfc_lngamma(d);
      res := res + ln(x);
      sfc_gdr_pos := exp_fa(-res);
    end;
    exit;
  end;
  xgh := x + lanczos_gm05;
  if abs(d) < 10.0 then begin
    res := ln1p(d/xgh);
    res := exp_fa((0.5-x)*res);
  end
  else begin
    res := power_fa(xgh/(xgh+d), x-0.5);
  end;
  res := res*power_fa(exp_fa(1.0)/(xgh + d), d);
  sfc_gdr_pos := lanczos(x,false)/lanczos(x+d,false)*res;
end;



function sfc_gamma_delta_ratio(x,d: extended): extended;
  {-Return gamma(x)/gamma(x+d), accurate even for |d| << |x|}
var
  s,t,y: extended;
begin
  if IsNanOrInf(x) or IsNanOrInf(d) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_gamma_delta_ratio := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  y := x+d;
  if x=y then sfc_gamma_delta_ratio := 1.0
  else if (x>0.0) and (y>0.0) then sfc_gamma_delta_ratio := sfc_gdr_pos(x,d)
  else begin
    if (y<=0.0) and (frac(y)=0.0) then begin
      {y=x+d is a non-positive integer}
      if (x>0.0) or (frac(x)<>0.0) then begin
        {gamma(x+d) = inf, gamma(x)<>0, return zero}
        sfc_gamma_delta_ratio := 0.0;
        exit;
      end;
      {both x,y non-positive integers, no need to calculate sin for reflection}
      t := sfc_gdr_pos(1.0-x,-d);
      if frac(0.5*x)<>frac(0.5*y) then t := -t;
      sfc_gamma_delta_ratio := 1.0/t;
      exit;
    end;
    if (x<0.0) and (y<0.0) then begin
      {Here both x and y are negative, use reflection formula for gammas}
      {gamma(x)/gamma(x+d) = sinPi(x+d)/sinP(x)/ [gamma(1-x)/gamma(1-x-d]}
      t := sfc_gdr_pos(1.0-x,-d);
      //t := sinPi(x)*t;
      t := sinPi_fa(x)*t; {.335}
      //y := sinPi(y);
      y := sinPi_fa(y); {.335}
      sfc_gamma_delta_ratio := y/t;
    end
    else begin
      {Remaining cases: use lngamma for both arguments}
      s := sfc_signgamma(x)*sfc_signgamma(y);
      y := sfc_lngamma(y);
      t := sfc_lngamma(x);
      t := exp_fa(t-y);
      sfc_gamma_delta_ratio := s*t;
    end
  end;
end;




function sfc_pochhammer(a,x: extended): extended;
  {-Return the Pochhammer symbol (a)_x = gamma(a+x)/gamma(a).}
  { Accuracy is reduced if x or x+a are near negative integers.}
var
  t: extended;
  it,ia: boolean;
  i: integer;
begin
  if IsNanOrInf(x) or IsNanOrInf(a) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_pochhammer := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if x=0.0 then sfc_pochhammer := 1.0
  else begin
    t := a+x;
    ia := (a<=0.0) and (frac(a)=0.0);
    it := (t<=0.0) and (frac(t)=0.0);
    if it or ia then begin
      if it and ia then begin
        {both a and a+x are negative integers}
        t := sfc_gamma_delta_ratio(1-a,-x);
        if frac(0.5*x)<>0 then t := -t;
        sfc_pochhammer := t;
      end
      else if ia then sfc_pochhammer := 0.0
      else
      begin
        {$ifopt R+}
          if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
        {$endif}
        sfc_pochhammer := NaN_x;
        GenerateFPUException(FPUErrorNAN);{.375}
      end;
    end
    else begin
      if (frac(x)=0.0) and (x>0.0) and (x<=100.0) then begin
        {x is a small positive integer, use simple multiply loop}
        t := a;
        for i:=1 to trunc(x)-1 do t := t*(a+i);
        sfc_pochhammer := t;
      end
      else begin
        t := sfc_gamma_delta_ratio(a,x);
        if t<>0 then sfc_pochhammer := 1.0/t
        else sfc_pochhammer := PosInf_x;
      end;
    end;
  end;
end;



function sfc_beta(x,y: extended): extended;
  {-Return the function beta(x,y)=gamma(x)*gamma(y)/gamma(x+y)}
var
  r,t: extended;
begin
  {If one arg is 1, return the inverse of the other because}
  {gamma(1)*gamma(y)/gamma(y+1) = 1/y, analogue for y=1}
  if IsNanOrInf(x) or IsNanOrInf(x) then begin sfc_beta := NaN_x; GenerateFPUException(FPUErrorNAN);{.375} end
  else if x=1.0 then sfc_beta := 1.0/y
  else if y=1.0 then sfc_beta := 1.0/x
  else begin
    {force x >= y}
    if x<y then begin
      t := x;
      x := y;
      y := t;
    end;
    t := x+y;
    if (t<=0.0) and (frac(t)=0.0) then begin
      if (frac(x)<>0.0) and (frac(y)<>0.0) then begin
        {gamma(x+y) = Inf, gamma(x)*gamma(y)<>Inf}
        sfc_beta := 0.0;
      end
      else begin
        t := sfc_gamma(x);
        r := sfc_pochhammer(y,x);
        sfc_beta := t/r;
      end;
      exit;
    end;
    if t=x then begin
      {gamma(x)/gamma(x+y)=1}
      sfc_beta := sfc_gamma(y);
    end
    else begin
      r := sfc_lnbeta(x,y);
      t := exp_fa(r);
      if (x<0.0) or (y<0.0) then begin
        {get signs only if necessary}
        r := sfc_signgamma(x)*sfc_signgamma(y)/sfc_signgamma(x+y);
        sfc_beta := r*t;
      end
      else sfc_beta := t;
    end;
  end;
end;






function minx(x, y: extended): extended;
  {-Return the minimum of two extendeds; x,y <> NAN}
begin
  if x<y then minx := x
  else minx := y;
end;



function sfc_ibetaprefix(a,b,x,y: extended): extended;
  {-Return (x^a)(y^b)/Beta(a,b), x+y=1, using Lanczos approximation}
var
  res,c,
  agh,bgh,cgh,b1,b2,
  l,l1,l2,l3,ratio: extended;
  sa: boolean;
begin

  {Ref: Boost [19], beta.hpp, function ibeta_power_terms}
  c := a + b;
  {combine power terms with Lanczos approximation}
  agh := a + lanczos_gm05;
  bgh := b + lanczos_gm05;
  cgh := c + lanczos_gm05;
  res := lanczos(c,true)/(lanczos(a,true)*lanczos(b,true));

  {l1 and l2 are the base of the exponents minus one}
  l1 := (x*b - y*agh) / agh;
  l2 := (y*a - x*bgh) / bgh;
  if minx(abs(l1), abs(l2)) < 0.2 then begin
    {when the base of the exponent is very near 1 we get really}
    {gross errors unless extra care is taken}
    if (l1*l2 > 0) or (minx(a, b) < 1) then begin
      if abs(l1) < 0.1 then res := res*exp_fa(a*ln1p(l1))
      else res := res*power_fa((x * cgh) / agh, a);
      if abs(l2) < 0.1 then res := res*exp_fa(b*ln1p(l2))
      else res := res*power_fa((y * cgh) / bgh, b);
    end
    else if maxx(abs(l1), abs(l2)) < 0.5 then begin
      sa := a < b;
      ratio := b / a;
      if (sa and (ratio*l2 < 0.1)) or ((not sa) and (l1/ratio > 0.1)) then begin
        l3 := expm1(ratio*ln1p(l2));
        l3 := l1 + l3 + l3*l1;
        l3 := a*ln1p(l3);
        res := res*exp_fa(l3);
      end
      else begin
        l3 := expm1(ln1p(l1) / ratio);
        l3 := l2 + l3 + l3*l2;
        l3 := b*ln1p(l3);
        res := res*exp_fa(l3);
      end;
    end
    else if abs(l1) < abs(l2) then begin
      {First base near 1 only}
      l := a*ln1p(l1) + b*ln((y*cgh) / bgh);
      res := res*exp_fa(l);
    end
    else begin
      {Second base near 1 only}
      l := b*ln1p(l2) + a*ln((x*cgh) / agh);
      res := res*exp_fa(l);
    end
  end
  else begin
    {general case:}
    b1 := (x*cgh) / agh;
    b2 := (y*cgh) / bgh;
    l1 := a*ln(b1);
    l2 := b*ln(b2);
    if (l1 >= ln_MaxExt) or (l1 <= ln_MinExt) or (l2 >= ln_MaxExt) or (l2 <= ln_MinExt) then begin
      {Oops, overflow, sidestep}
      if a < b then res := res*power_fa(power_fa(b2, b/a)*b1, a)
      else res := res*power_fa(power_fa(b1, a/b)*b2, b);
    end
    else begin
      {finally the normal case}
      res := res*power_fa(b1,a)*power_fa(b2,b);
    end;
  end;
  {combine with the leftover terms from the Lanczos approximation}
  res := res*sqrt(bgh/exp_fa(1));
  res := res*sqrt(agh/cgh);
  sfc_ibetaprefix:= res;
end;




function sfc_beta_pdf(a, b, x: extended): extended;
  {-Return the probability density function of the beta distribution with}
  { parameters a and b: sfc_beta_pdf = x^(a-1)*(1-x)^(b-1) / beta(a,b)}
var
  p,t: extended;
begin
  if (a <= 0.0) or (b <= 0.0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_beta_pdf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if (x<0.0) or (x>1.0) then sfc_beta_pdf := 0.0
  else if (x=0.0) or (x=1.0) then begin
    p := power_fa(x, a-1.0);
    p := p*power_fa(1.0-x, b-1.0);
    sfc_beta_pdf := p/sfc_beta(a,b);
  end
  else if b=1.0 then sfc_beta_pdf := a*power_fa(x,a-1.0)
  else begin
    {0 < x < 1}
    t := sfc_ibetaprefix(a,b,x,1-x);
    if t<>0 then begin
      p := x*(1.0-x);
      if p*MaxExtended < t then t := PosInf_x else t := t/p;
    end;
    sfc_beta_pdf := t;
  end;
end;



function sfc_binomial_pmf(p: extended; n, k: longint): extended;
  {-Return the binomial distribution probability mass function with number}
  { of trials n >= 0 and success probability 0 <= p <= 1}
begin
  if (p < 0.0) or (p > 1.0) or (n < 0) then
  begin
    {$ifopt R+}
      if RTE_ArgumentRange>0 then RunError(byte(RTE_ArgumentRange));
    {$endif}
    sfc_binomial_pmf := NaN_x;
    GenerateFPUException(FPUErrorNAN);{.375}
    exit;
  end;
  if (k<0) or (k>n) then sfc_binomial_pmf := 0.0
  else if n=0 then sfc_binomial_pmf := 1.0
  else if k=0 then sfc_binomial_pmf := power_fa(1.0-p, n)
  else if k=n then sfc_binomial_pmf := power_fa(p, n)
  else
  begin
      sfc_binomial_pmf := sfc_beta_pdf(k+1,n-k+1,p)/(n+1);
  end;
end;





{---------------------------------------------------------------------------}


{---------------------------------------------------------------------------}
function ac_help(x: extended): extended;
  {-Calculate ln1p(x+sqrt(2x+x^2)}
var
  y: extended;
begin
  x := x+sqrt(2.0*x+x*x);
  {see ln1p for the formula}
  y := 1.0 + x;
  if y=1.0 then ac_help := x
  else ac_help := ln(y) + (x-(y-1.0))/y;
end;




{---------------------------------------------------------------------------}
procedure csinh_acc(const z: complex; var w: complex);
  {-Return the complex hyperbolic sine w = sinh(z)}
var
  c,s: extended;
begin
  {HMF[1], 4.5.49: sinh(x + iy) = cos(y)*sinh(x) + i*sin(y)*cosh(x)}
  sincos_acc(z.im, s,c);
  coshsinhmult_acc(z.re, s, c, w.im, w.re);
end;





{---------------------------------------------------------------------------}
function tanh_acc(x: extended): extended;
  {-Return the hyperbolic tangent of x, accurate even for x near 0}
var
  t,z: extended;
const
  t0 = 23.0;       {ceil(-0.5*ln(2^-64)) = ceil(32*ln(2))}
  t1 = 1.5e-5;     {~ 2^(-64/4)}
  t2 = 0.625;
  PH: array[0..3] of THexExtW = (
        ($e3be,$bfbd,$5cbc,$a381,$c009),  {-1.3080425704712825945553e+3}
        ($b576,$ef5e,$6d57,$a81b,$c005),  {-8.4053568599672284488465e+1}
        ($5959,$9111,$9cc7,$f4e2,$bffe),  {-9.5658283111794641589011e-1}
        ($d2a4,$1b0c,$8f15,$8f99,$bff1)); {-6.8473739392677100872869e-5}
  QH: array[0..3] of THexExtW = (
        ($d5a2,$1f9c,$0b1b,$f542,$400a),  { 3.9241277114138477845780e+3}
        ($3793,$c95f,$fa2f,$e3b9,$4009),  { 1.8218117903645559060232e+3}
        ($687f,$ce24,$dd6c,$c084,$4005),  { 9.6259501838840336946872e+1}
        ($0000,$0000,$0000,$8000,$3fff)); { 1.0000000000000000000000e+0}
var
  P: array[0..3] of extended absolute PH;
  Q: array[0..3] of extended absolute QH;
begin
  t := abs(x);
  if t>t0 then begin
    if x<0.0 then tanh_acc := -1.0 else tanh_acc := +1.0;
  end
  else if t<t2 then begin
    z := x*x;
    if t <= t1 then begin
      {tanh(x) = x*(1 - 1/3*x^2 + 2/15*x^4 + O(x^6))}
      t := -0.33333333333333333333;
    end
    else begin
      {Ref: Cephes[7], tanhl.c}
     // t := PolEvalX(z,P,4)/PolEvalX(z,Q,4);
     t:=( ((p[3]*z+p[2])*z+p[1])*z+p[0] )/( ((q[3]*z+q[2])*z+q[1])*z+q[0] );
    end;
    z := x*t*z;
    tanh_acc := x + z;
  end
  else begin
    t := exp_acc(2.0*t)+1.0;
    if x>0.0 then tanh_acc := 1.0 - 2.0/t
    else tanh_acc := -1.0 + 2.0/t;
  end;
end;





{---------------------------------------------------------------------------}
procedure ccosh_acc(const z: complex; var w: complex);
  {-Return the complex hyperbolic cosine w = cosh(z)}
var
  c,s: extended;
begin
  {HMF[1], 4.5.50: cosh(x + iy) = cos(y)*cosh(x) + i*sin(y)*sinh(x)}
  sincos_acc(z.im, s,c);
  coshsinhmult_acc(z.re, c, s, w.re, w.im);
end;



{---------------------------------------------------------------------------}
procedure ctanh_acc(const z: complex; var w: complex);
  {-Return the complex hyperbolic tangent w = tanh(z)}
var
  x,y,c,s,h,t: extended;
const
  t0 = 23.0;
begin
  {HMF[1], 4.5.51: tanh(x + iy) = (sinh(2x) + i*sin(2y))/(cosh(2x) + cos(2y))}
  {See AMath reference manual for implementation notes}
  x := z.re;
  y := z.im;
  t := abs(x);
  if y=0.0 then begin
    w.re := tanh_acc(x);
    w.im := 0.0;
  end
  else if t=0.0 then begin
    w.re := 0.0;
    w.im := tan_acc(y);
  end
  else if t >= t0 then begin
    w.re := isign(x);
    w.im := 2.0*sin_acc(2.0*y)*exp_acc(-2.0*t);
  end
  else begin
    {Note: The argument y for sincos is correct! NOT 2y,}
    {the argument doubling is implicit in the formulas. }
    sincos_acc(y,s,c);
    {accurately compute h=exp(2x)-1 and t=4(h+1)c}
    if t<=1.0 then begin
      h := expm1(2.0*x);
      t := 4*(1.0 + h)*c;
    end
    else begin
      t := exp_acc(2.0*x);
      h := t - 1.0;
      t := 4.0*t*c;
    end;
    x := h*h;
    {Note: theoretically y = h^2 + 4(h+1)c^2 > 0 because h+1>0}
    {but underflow may occur, therefore multiply by 1/y or Inf}
    y := x + t*c;
    if abs(y) < MinExtended then y := PosInf_x else y := 1.0/y;
    w.re := (x+2.0*h)*y;
    w.im := (t*s)*y;
  end;
end;



{---------------------------------------------------------------------------}
procedure csec_acc(const z: complex; var w: complex);
  {-Return the complex circular secant w = sec(z) = 1/cos(z)}
begin
  ccos_acc(z,w);
  rdivc_acc(1.0, w, w);
end;




{---------------------------------------------------------------------------}
procedure ccsc_acc(const z: complex; var w: complex);
  {-Return the complex circular cosecant w = csc(z) = 1/sin(z)}
begin
  csin_acc(z,w);
  rdivc_acc(1.0, w, w);
end;


{---------------------------------------------------------------------------}
procedure csech_acc(const z: complex; var w: complex);
  {-Return the complex hyperbolic secant w = sech(z) = 1/cosh(z)}
begin
  ccosh_acc(z,w);
  rdivc_acc(1.0, w, w);
end;


{---------------------------------------------------------------------------}
procedure ccsch_acc(const z: complex; var w: complex);
  {-Return the complex hyperbolic cosecant w = csch(z) = 1/sinh(z)}
begin
  csinh_acc(z,w);
  rdivc_acc(1.0, w, w);
end;






{---------------------------------------------------------------------------}
function sech_acc(const x: extended): extended;
  {-Return the hyperbolic secant of x}
begin
  if abs(x) > ln_MaxExt then sech_acc := 0.0
  else sech_acc := 1.0/cosh_acc(x);
end;


{---------------------------------------------------------------------------}
function csch_acc(const x: extended): extended;
  {-Return the hyperbolic cosecant of x, x<>0}
begin
  if abs(x) > ln_MaxExt then csch_acc := 0.0
  else csch_acc := 1.0/sinh_acc(x);
end;



{---------------------------------------------------------------------------}
function csc_acc(const x: extended): extended;
  {-Return the circular cosecant of x, x mod Pi <> 0}
begin
  csc_acc := 1.0/sin_acc(x);
end;



{---------------------------------------------------------------------------}
function sec_acc(const x: extended): extended;
  {-Return the circular secant of x, x mod Pi <> Pi/2}
begin
  sec_acc := 1.0/cos_acc(x);
end;




{---------------------------------------------------------------------------}
function arcsin_acc(x: extended): extended;
  {-Return the inverse circular sine of x, |x| <= 1}
begin
  {basic formula arcsin(x) = arctan(x/sqrt(1-x^2))}
  arcsin_acc := arctan2_acc(x, sqrt((1.0-x)*(1.0+x)))
end;



{---------------------------------------------------------------------------}
function arccos_acc(x: extended): extended;
  {-Return the inverse circular cosine of x, |x| <= 1}
begin
  {basic formula arccos(x) = arctan(sqrt(1-x^2)/x))}
  if abs(x)=1.0 then begin
    if x<0.0 then arccos_acc := Pi else arccos_acc := 0.0;
  end
  else arccos_acc := arctan2_acc(sqrt((1.0-x)*(1.0+x)),x)
end;



{---------------------------------------------------------------------------}
function arctan_f(x: extended): extended; assembler;
  {-Return the inverse circular tangent of x}
asm
  fld    [x]
  fld1
  fpatan
  fwait
end;


{---------------------------------------------------------------------------}
function arccot_acc(x: extended): extended;
  {-Return the sign symmetric inverse circular cotangent; arccot(x) = arctan(1/x), x <> 0}
begin
  if abs(x) > 1E-20 then arccot_acc := arctan(1.0/x)
  else begin
    if x>=0.0 then arccot_acc := Pi_2
    else arccot_acc := -Pi_2;
  end;
end;



{---------------------------------------------------------------------------}
function arcsec_acc(x: extended): extended;
  {-Return the inverse secant of x, |x| >= 1}
var
  t: extended;
begin
  if abs(x) >= 0.5e10 then begin
    {avoid x^2 overflow and/or arctan evaluation}
    arcsec_acc := Pi_2 - 1.0/x;
  end
  else begin
    t := arctan(sqrt((x-1.0)*(x+1.0)));
    if x>0.0 then arcsec_acc := t
    else arcsec_acc := Pi-t;
  end;
end;



{---------------------------------------------------------------------------}
function arccsc_acc(x: extended): extended;
  {-Return the inverse cosecant of x, |x| >= 1}
var
  y,z: extended;
begin
  {arccsc = arcsin(1.0/x) = arctan(1/sqrt(x^2-1))}
  y := abs(x);
  if y >= 1E10 then begin
    {arccsc(x) ~ 1/x + 1/6/x^3 + 3/40/x^5 + O(1/x^6) for large x}
    z := 1.0/y;
  end
  else if y > 2.0 then z := arctan2_acc(1.0, sqrt(y*y-1.0))
  else begin
    z := y-1.0;
    z := arctan2_acc(1.0, sqrt(z*y+z));
  end;
  if x>0.0 then arccsc_acc := z
  else arccsc_acc := -z;
end;




{---------------------------------------------------------------------------}
function arcsinh_acc(x: extended): extended;
  {-Return the inverse hyperbolic sine of x}
var
  t,z: extended;
const
  t0 = 0.43e10;    {sqrt(t0^2 + 1) = t0}
  t1 = 0.59e4932;  {t1 < Maxextended/2 }
const
  CSN = 24;
  CSAH: array[0..CSN-1] of THexExtW = (     {chebyshev((arcsinh(x)/x-1), x=-1..1, 1e-20);}
          ($74C4,$2C57,$F726,$8346,$BFFC),  {-0.128200399117381863433721273592    }
          ($60FB,$E565,$99EE,$F0E4,$BFFA),  {-0.588117611899517675652117571383e-1 }
          ($4327,$5038,$DAB6,$9AE8,$3FF7),  {+0.472746543221248156407252497561e-2 }
          ($E4B7,$CEAC,$CB4F,$8174,$BFF4),  {-0.493836316265361721013601747903e-3 }
          ($F880,$4F1E,$8FBD,$F564,$3FF0),  {+0.585062070585574122874948352586e-4 }
          ($AE3D,$780B,$06F9,$FA8D,$BFED),  {-0.746699832893136813547550692112e-5 }
          ($8655,$9CEE,$EACE,$865F,$3FEB),  {+0.100116935835581992659661920174e-5 }
          ($D271,$A5F8,$C535,$9549,$BFE8),  {-0.139035438587083336086164721962e-6 }
          ($2CEA,$53B7,$9C56,$AA47,$3FE5),  {+0.198231694831727935473173603337e-7 }
          ($051A,$3D90,$00CD,$C63D,$BFE2),  {-0.288474684178488436127472674074e-8 }
          ($79C8,$31D9,$DC1C,$EA98,$3FDF),  {+0.426729654671599379534575435248e-9 }
          ($7F9A,$EA05,$5578,$8CAF,$BFDD),  {-0.639760846543663578687526705064e-10}
          ($CC8C,$E66B,$2C10,$AAA1,$3FDA),  {+0.969916860890647041478747328871e-11}
          ($A487,$C2BA,$24E9,$D0EA,$BFD7),  {-0.148442769720437708302434249871e-11}
          ($77D3,$838C,$C3D7,$80EF,$3FD5),  {+0.229037379390274479880187613939e-12}
          ($BF67,$A9BA,$A045,$A046,$BFD2),  {-0.355883951327326451644472656709e-13}
          ($89C0,$7126,$8F52,$C876,$3FCF),  {+0.556396940800567901824410323292e-14}
          ($CA8D,$2192,$F0F4,$FC17,$BFCC),  {-0.874625095996246917448307610618e-15}
          ($3213,$353B,$6AE5,$9F47,$3FCA),  {+0.138152488445267754259259259259e-15}
          ($7B9A,$3E40,$512C,$CA25,$BFC7),  {-0.219166882829054218109516486403e-16}
          ($E036,$4ADC,$8495,$80C6,$3FC5),  {+0.349046585251352023737824855452e-17}
          ($BAAB,$4F80,$8CCC,$A4A6,$BFC2),  {-0.557857884196310306067662486759e-18}
          ($D7E8,$6819,$4637,$D332,$3FBF),  {+0.894451477596418179416166864814e-19}
          ($A859,$BFDE,$0201,$87D9,$BFBD)); {-0.143834333235934314272184000000e-19}
         {($5CEB,$BE05,$504B,$AF3C,$3FBA)}  {+0.231922385806700541867783333333e-20}
var
  CSA: array[0..CSN-1] of extended absolute CSAH;
begin
  t := abs(x);
  if t<=1.0 then begin
    if t <= sqrt_epsh then begin
      {arcsinh(x) = x*(1 - 1/6*x^2 + 3/40*x^4 + O(x^6))}
      arcsinh_acc := x;
    end
    else begin
      z := 2.0*x*x - 1.0;
      t := CSEvalX_f(z, CSA, CSN);
      arcsinh_acc := x + x*t;
    end;
  end
  else begin
    if t >= t0 then begin
      {skip sqrt() because sqrt(t^2+1) = t}
      if t <= t1 then z := ln(2.0*t)
      else z := ln(t)+ln2
    end
    else z := ln(t + sqrt(1.0+t*t));
    if x>0.0 then arcsinh_acc := z
    else arcsinh_acc := -z;
  end;
end;







function arccosh_f(x: extended): extended; assembler;
asm
  fld     tbyte  [x]
  call    R_ARCCOSH
end;





function arccosh_acc(x: extended): extended;
  {-Return the inverse hyperbolic cosine, x >= 1. Note: for x near 1 the}
  { function arccosh1p(x-1) should be used to reduce cancellation errors!}
begin
  if x=1.0 then arccosh_acc := 0
  else begin
    if x>1E10 then begin
      {skip sqrt() calculation because sqrt(x^2-1) = x}
      arccosh_acc := ln(x)+ln2;
    end
    else if x>2.0 then begin
      {arccosh := ln(x+sqrt((x-1)*(x+1)))}
      arccosh_acc := ln(2.0*x - 1.0/(x+sqrt(x*x-1.0)))
    end
    else begin
      {arccosh = ln1p(y+sqrt(2*y + y*y)), y=x-1}
      arccosh_acc := ac_help(x-1.0);
    end;
  end;
end;



function arccosh_fa(x: extended): extended;
begin
  if F_FastSpec = True then arccosh_fa:=arccosh_f(x)  else arccosh_fa:=arccosh_acc(x);
end;



{---------------------------------------------------------------------------}
function arctanh_acc(x: extended): extended;
  {-Return the inverse hyperbolic tangent of x, |x| < 1}
var
  t: extended;
const
  t0 = 2.3E-10;
begin
  t := abs(x);
  if t<t0 then begin
    {arctanh(x) = x + 1/3*x^3 + 1/5*x^5 + 1/7*x^7 + O(x^9)}
    arctanh_acc := x;
  end
  else begin
    {arctanh(x) = 0.5*ln((1+x)/(1-x))     = 0.5*ln((1-x+2x)/(1-x)) }
    {           = 0.5*ln(1+2x/(1-x))      = 0.5*ln1p(2x/(1-x))     }
    {  or       = 0.5*(ln(1+x)-ln(1-x))   = 0.5*(ln1p(x)-ln1p(-x)) }
    {  or       = 0.5*ln(1+2x+2x^2/(1-x)) = 0.5*ln1p(2x+2x^2/(1-x))}
    if t<0.75 then t := 0.5*(ln1p(t)-ln1p(-t))
    else t := 0.5*ln((1.0+t)/(1.0-t));
    if x>0.0 then arctanh_acc := t
    else arctanh_acc := -t;
  end;
end;



{---------------------------------------------------------------------------}
function arccoth_acc(x: extended): extended;
  {-Return the inverse hyperbolic cotangent of x, |x| > 1}
var
  t: extended;
begin
  t := abs(x);
  {compute t = arccoth(|x|)}
  if t<32.0 then t := 0.5*ln1p(2.0/(t-1.0))
  else t := -0.5*ln1p(-2.0/(t+1.0));
  {adjust sign}
  if x>0.0 then arccoth_acc := t
  else arccoth_acc := -t;
end;


{---------------------------------------------------------------------------}
function arcsech_acc(x: extended): extended;
  {-Return the inverse hyperbolic secant of x, 0 < x <= 1}
var
  t: extended;
begin
  t := 1.0-x;
  if t=0 then arcsech_acc := 0.0
  else if x<=1E-10 then begin
    {avoid overflow in ac_help}
    {arcsech(x) = (ln(2)-ln(x)) -1/4*x^2 -3/32*x^4 + O(x^6)}
    arcsech_acc := -ln(0.5*x);
  end
  else begin
    {arcsech(x) = arccosh(1/x), see arccosh branch for x<=2}
    arcsech_acc := ac_help(t/x);
  end;
end;


{---------------------------------------------------------------------------}
function arccsch_acc(x: extended): extended;
  {-Return the inverse hyperbolic cosecant of x, x <> 0}
var
  t: extended;
begin
  t := abs(x);
  if t<=1.0 then begin
    if t<=5e-10 then begin
      {avoid overflow for 1/t^2}
      {arccsch(x) = (ln(2)-ln(x)) + 1/4*x^2 -3/32*x^4 + O(x^6)}
      t := -ln(0.5*t)
    end
    else begin
      {ln(1/t + sqrt(1+1/t^2)) = ln((1+sqrt(1+t^2)/t) = }
      t := ln1p(sqrt(1.0+t*t)) - ln(t);
    end;
    if x>0.0 then arccsch_acc := t
    else arccsch_acc := -t;
  end
  else arccsch_acc := arcsinh_acc(1.0/x);
end;




{---------------------------------------------------------------------------}
procedure carcsin_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse circular sine w = arcsin(z)}
var
  x,y,xm,ym,xp,yp: extended;
begin
  {Ref: Kahan[61], procedure CASIN             }
  {u = arctan2(re(z), re(sqrt(1-z)*sqrt(1+z))) }
  {v = arcsinh(im(sqrt(1-cconj(z))*sqrt(1+z))) }
  x  := z.re;
  xp := abs(x);
  y  := z.im;
  yp := abs(y);
  if (abs(x) > MV_4) or (abs(y) > MV_4) then begin
    if y >= 0.0 then w.re := arctan2_acc(x,y)
    else w.re := arctan2_acc(-x,-y);
    w.im := ln(hypot_acc(0.5*x, 0.5*y)) + 2.0*ln2;
    w.re := copysign(w.re,x);
    w.im := copysign(w.im,y);
  end
  else if (xp <= sqrt_epsh) and (yp <= sqrt_epsh) then begin
    {arcsin(z) = z + 1/6*z^3 + 3/40*z^5 +O(z^6) }
    w.re := x;
    w.im := y;
  end
  else begin
    {xp + i*yp = sqrt(1+z)}
    cx_sqrt(1.0+x, y, xp, yp);
    {xm + i*ym = sqrt(1-z)}
    cx_sqrt(1.0-x, -y, xm, ym);
    {use im(sqrt(1-cconj(z))) = -im(sqrt(1-z)) = -ym}
    y := yp*xm - xp*ym;
    w.re := arctan2_acc(x, xp*xm - yp*ym);
    w.im := arcsinh_acc(y);
  end;
end;


{---------------------------------------------------------------------------}
procedure carccos_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse circular cosine w = arccos(z)}
var
  x,y,xm,ym,xp,yp: extended;
begin
  {Ref: Kahan[61], procedure CACOS               }
  {u = 2.0*arctan2(re(sqrt(1-z), re(sqrt(1+z)))) }
  {v = arcsinrh(im(sqrt(1+cconj(z))*sqrt(1-z)))   }
  x  := z.re;
  xp := abs(x);
  y  := z.im;
  yp := abs(y);

  if (xp > MV_4) or (xp > MV_4) then begin
    w.re := arctan2_acc(y,x);
    w.im := ln(hypot_acc(0.5*x, 0.5*y)) + 2.0*ln2;
  end
  else if (xp <= sqrt_epsh) and (yp <= sqrt_epsh) then begin
    {arccos(z) = Pi/2 - z - 1/6*z^3 - 3/40*z^5 +O(z^6)}
    w.re := Pi_2-x;
    w.im := -y;
  end
  else begin
    {xp + i*yp = sqrt(1+z)}
    cx_sqrt(1.0+x, y, xp, yp);
    {xm + i*ym = sqrt(1-z)}
    cx_sqrt(1.0-x, -y, xm, ym);
    {use im(sqrt(1+cconj(z))) = -im(sqrt(1+z))}
    y := xp*ym - yp*xm;
    w.re:= 2.0*arctan2_acc(xm, xp);
    w.im := arcsinh_acc(y);
  end;
end;



{---------------------------------------------------------------------------}
procedure carctan_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse circular tangent w = arctan(z)}
var
  u: complex;
begin
  {Ref HMF[1], 4.4.22: arctan(z) = -i*arctanh(iz)}
  u.re := -z.im;
  u.im :=  z.re;
  carctanh_acc(u,u);
  w.re :=  u.im;
  w.im := -u.re;
end;




{---------------------------------------------------------------------------}
procedure carccot_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse circular cotangent w = arccot(z) = arctan(1/z)}
var
  u: complex;
begin
  {arccot(z) = i*arccoth(i*z))}
  u.re := -z.im;
  u.im :=  z.re;
  carccoth_acc(u,u);
  w.re := -u.im;
  w.im :=  u.re;
end;


{---------------------------------------------------------------------------}
procedure carcsec_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse circular secant w = arcsec(z) = arccos(1/z)}
var
  u: complex;
  xm,ym,xp,yp: extended;
begin
  xp := abs(z.re);
  if (abs(xp-1.0) < 0.5) and (abs(z.im) < 0.5) then begin
    {This is the code for arccos(1/z) with 1 +- 1/z = (z +- 1)/z}
    {xp + i*yp = sqrt(1+1/z) = sqrt((1+z)/z}
    u.re := z.re + 1.0;
    u.im := z.im;
    cdiv_acc(u,z,u);
    cx_sqrt(u.re, u.im, xp, yp);
    {xm + i*ym = sqrt(1-1/z)=sqrt(z-1)/z}
    u.re := z.re - 1.0;
    u.im := z.im;
    cdiv_acc(u,z,u);
    cx_sqrt(u.re, u.im, xm, ym);
    w.re := 2.0*arctan2_acc(xm, xp);
    w.im := arcsinh_acc(xp*ym - yp*xm);
  end
  else begin
    rdivc_acc(1.0, z, w);
    carccos_acc(w,w);
  end;
end;



{---------------------------------------------------------------------------}
procedure carccsc_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse circular cosecant w = arccsc(z) = arcsin(1/z)}
var
  u: complex;
  xm,ym,xp,yp: extended;
begin
  xp := abs(z.re);
  if (abs(xp-1.0) < 0.5) and (abs(z.im) < 0.5) then begin
    {This is the code for arcsin(1/z) with 1 +- 1/z = (z +- 1)/z}
    {xp + i*yp = sqrt(1+1/z) = sqrt((z+1)/z)}
    u.re := z.re + 1.0;
    u.im := z.im;
    cdiv_acc(u,z,u);
    cx_sqrt(u.re, u.im, xp, yp);
    {xm + i*ym = sqrt(1-1/z) = sqrt((z-1)/z)}
    u.re := z.re - 1.0;
    u.im := z.im;
    cdiv_acc(u,z,u);
    cx_sqrt(u.re, u.im, xm, ym);
    rdivc_acc(1.0,z,u);
    w.re := arctan2_acc(u.re, xp*xm - yp*ym);
    w.im := arcsinh_acc(yp*xm - xp*ym);
  end
  else begin
    rdivc_acc(1.0, z, w);
    carcsin_acc(w,w);
  end;
end;




procedure carcsinh_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse hyperbolic sine w = arcsinh(z)}
var
  u: complex;
begin
  {HMF[1], 4.6.14: arcsinh(z) = - i*arcsin(iz)}
  u.re := -z.im;
  u.im :=  z.re;
  carcsin_acc(u,u);
  w.re :=  u.im;
  w.im := -u.re;
end;




{---------------------------------------------------------------------------}
procedure carccosh_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse hyperbolic cosine w = arccosh(z)}
var
  x,y,xm,ym,xp,yp: extended;
begin
  {Ref: Kahan[61], procedure CACOSH                  }
  {u = arcsinh(re(sqrt(cconj(z)-1.0)*sqrt(z+1.0)))   }
  {v = 2.0*arctan2(im(sqrt(z-1.0), re(sqrt(z+1.0)))) }
  x := z.re;
  y := z.im;
  if (abs(x) > MV_4) or (abs(y) > MV_4) then begin
    w.re := ln(hypot_acc(0.5*x, 0.5*y)) + 2.0*ln2;
    w.im := arctan2_acc(y,x);
  end
  else begin
    {xp + i*yp = sqrt(z+1)}
    cx_sqrt(x+1.0, y, xp, yp);
    {xm + i*ym = sqrt(z-1)}
    cx_sqrt(x-1.0, y, xm, ym);
    {use im(sqrt(cconj(z)-1)) = -im(sqrt(z-1))}
    y := xp*xm + yp*ym;
    w.re := arcsinh_acc(y);
    w.im := 2.0*arctan2_acc(ym, xp);
  end;
end;



{---------------------------------------------------------------------------}
procedure carctanh_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse hyperbolic tangent w = arctanh(z)}
var
  x,x1,y,u,v: extended;
begin
  {Ref: Boost[19], function math\complex\atanh.hpp}
  x  := abs(z.re);
  if x=0.0 then begin
    {arctanh(iy)=i*arctan(y);}
    w.re := 0.0;
    w.im := arctan(z.im);
    exit;
  end;
  {here x > 0}
  x1 := 1.0-x;
  y  := abs(z.im);
  if (x>SLB) and (x<SUB) and (y>SLB) and (y<SUB) then begin
    {x and y in standard safe range}
    v := y*y;
    u := ln1p(4.0*x/(sqr(x1) + v));
    v := arctan2_acc(2.0*y, x1*(1.0+x) - v);
    w.im := copysign(0.5 ,z.im)*v;
    w.re := copysign(0.25,z.re)*u;
  end
  else begin
    {special cases where standard formulas may over/underflow}
    {safe-compute (w.re) = ln1p(4*x/((1-x)^2 + y^2)}
    if x>=SUB then begin
      if (x=PosInf_x) or (y=PosInf_x) then u := 0.0
      else if y >= SUB then u := ln1p((4.0/y)/(x/y + y/x))
      else if y > 1.0 then u := ln1p(4.0/(x + y*y/x))
      else u := ln1p(4.0/x);
    end
    else if y >= SUB then begin
      if x > 1.0 then u := ln1p((4.0*x/y)/(y + x1*x1/y))
      else u := 4.0*x/y/y;
    end
    else if x <> 1.0 then begin
      u := x1*x1;
      if y > SLB then u := u + y*y;
      u := ln1p(4.0*x/u);
    end
    else u := 2.0*(ln2 - ln(y));
    {safe-compute (w.im) = arctan2(2y, (1-x^2) - y^2)}
    if (x >= SUB) or (y >= SUB) then v := Pi
    else if (x <= SLB) then begin
       if y <= SLB then v := arctan2_acc(2.0*y, 1.0)
       else begin
         if (x=0.0) and (y=0.0) then v := 0.0
         else v := arctan2_acc(2.0*y, 1.0 - y*y);
       end;
    end
    else begin
      {The next statement adjusts the sign on the cut: if z.im=0 then}
      {w.im=Pi/2 for z.re < -1, 0 for |z.re| < 1, -Pi/2 for z.re > 1 }
      if (y=0.0) and (z.re>1.0) then v := -Pi
      else v := arctan2_acc(2.0*y, x1*(1.0+x));
    end;
    if (z.im < 0.0) and (v<>0.0) then v := -v;
    w.im := 0.5*v;
    w.re := copysign(0.25,z.re)*u;
  end;
end;



{---------------------------------------------------------------------------}
procedure carccoth_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse hyperbolic cotangent w = arccoth(z) = arctanh(1/z)}
var
  u: complex;
  x: extended;
begin
  x := abs(z.re);
  if z.im=0.0 then begin
    {z is real}
    if x >= 1.0 then begin
      w.re := arctanh_acc(1.0/z.re);
      w.im := 0.0;
    end
    else begin
      w.re := arctanh_acc(z.re);
      if z.re>0.0 then w.im := -Pi_2 else w.im := Pi_2;
    end;
  end
  else if (abs(1.0-x) < 0.5) and (abs(z.im) < 0.5) then begin
    {See [63] 5.4: Definition of arccoth, and appendix Lemma 3}
    {arccoth(z) = 0.5*[ln(-1-z) - ln(1-z)]}
    u.re := -1.0 - z.re;
    u.im := -z.im;
    w.re := 1.0 - z.re;
    w.im := -z.im;
    cln_acc(u,u);
    cln_acc(w,w);
    w.re := 0.5*(u.re - w.re);
    w.im := 0.5*(u.im - w.im);
  end
  else begin
    {arccoth(z) = arctanh(1/z)}
    rdivc_acc(1.0, z, w);
    carctanh_acc(w,w);
  end;
end;



{---------------------------------------------------------------------------}
procedure carcsech_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse hyperbolic secant w = arcsech(z) = arccosh(1/z)}
var
  u: complex;
  xm,ym,xp,yp: extended;
begin
  xp := abs(z.re);
  if (abs(xp-1.0) < 0.5) and (abs(z.im) < 0.5) then begin
    {This is the code for arccosh(1/z) with 1/z +- 1 = (1 +- z)/z}
    {xp + i*yp = sqrt(1/z+1) = sqrt((1+z)/z}
    u.re := z.re + 1.0;
    u.im := z.im;
    cdiv_acc(u,z,u);
    cx_sqrt(u.re, u.im, xp, yp);
    {xm + i*ym = sqrt(1/z-1) = sqrt((1-z)/z)}
    u.re := 1.0 - z.re;
    u.im := -z.im;
    cdiv_acc(u,z,u);
    cx_sqrt(u.re, u.im, xm, ym);
    w.re := arcsinh_acc(xp*xm + yp*ym);
    w.im := 2.0*arctan2_acc(ym, xp);
  end
  else begin
    rdivc_acc(1.0, z, w);
    carccosh_acc(w,w);
  end;
end;


{---------------------------------------------------------------------------}
procedure carccsch_acc(const z: complex; var w: complex);
  {-Return the principal value of the complex inverse hyperbolic cosecant w = arccsch(z) = arcsinh(1/z)}
var
  u: complex;
begin
  {Use arccsch(z) = i*arccsc(i*z)}
  u.re := -z.im;
  u.im :=  z.re;
  carccsc_acc(u,u);
  w.re := -u.im;
  w.im :=  u.re;
end;





initialization
begin
 Cdn:=1/sqrt(2*c_Pi);
 FPUErrorNAN:=0;
 FPUErrorInf:=1;
 F_FastSpec:=True;
 F_EnableFPUException:=NFalse;    {.375}

 {
  Разрешает принудительно вызывать исключения FPU в случае их появления при вычислении спец. ф-ий
  Иначе во многих ф-иях по умолчанию они не вызываются, а в ответ помещаются NAN, INF.
  Используется при вычислении с маскированием FPU
      (
        В версии b.375 генерируются исключения ТОЛЬКО для NAN! INF исключения по прежнему не вызываются
        Связано со сложностью и неоднозначностью обработки INF аргументов во многих ф-иях
      )
   По умолчанию отключено. Включаются только в процедурах маскироваания FPU исключений.
 }
end;


end.
