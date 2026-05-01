library Foreval;
{v.9.1.1.395}

{Foreval® : Math expression compiler    ©CopyRight 2000+. SOREL®   S.-Petersburg, Russia}


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
  
  Foreval_Lib;

exports

flCompile,
flCompileATE,
flCheckName,
flSetExpression,
flSetVar,
flSetVarCx,
flSetParamD,
flSetParamE,
flSetParamI,
flSetParamP,
flSetParamCxP,
flSetFunction,
flSet,
flGet,
flGetErrorCode,
flGetErrorString,
flRenameFunction,
flAddNameFunction,
flPerform,
flResultCxD,
flResultCxE,
flResultCxDP,
flResultCxEP,
flResultD,
flResultE,
flResult,


flResultSafe,
flResultSafeD,
flResultSafeE,
flResultSafeCxD,
flResultSafeCxE,
flResultSafeCxDP,
flResultSafeCxEP,


flSetExtAddrErrorFPU,
flMaskFPUException,
flResetMaskFPUException,
flGetFPUException,
flIsNAN,
flResultMaskedFPU,
flResultMaskedFpuE,
flResultMaskedFpuD,
flResultMaskedFpuCxE,
flResultMaskedFpuCxD,
flResultMaskedFpuCxEP,
flResultMaskedFpuCxDP,



flPolarDP,
flPolarEP,
flDecartDP,
flDecartEP,
flSetVarIntrnl,
flSetVarValueD,
flSetVarValueE,
flSetVarValueI,
flSetVarValueS,
flSetVarValueCxS,
flSetVarValueCxD,
flSetVarValueCxE,
flSetLength,
flSetArrayValueI,
flSetArrayValueD,
flSetArrayValueE,
flSetArrayValueS,
flGetVarValueE,
flGetVarValueI,
flGetVarValueD,
flGetVarValueS,
flGetArrayValueI,
flGetArrayValueD,
flGetArrayValueE,
flGetArrayValueS,
flGetVarValueCxS,
flGetVarValueCxD,
flGetVarValueCxE,
flSetNameImUnit,
flLoadFPUD,
flLoadFPUE,
flLoadFPUDP,
flLoadFPUEP,
flGetFuncIDN,
flSetDiffVar,
flSetDiffExpr,
flDiffExpr,
flGetDiffString,
flCompileDiffExpr,
flCompileDiffExprATE,
flSetDiffTemplate,
flCompileDeriv,
flCompileDerivATE,
flGetFunctionIDFP,
flSetSplainFunction,
flSetDiffNumCurrency,
flChangeFunctionProperty,
flSetOperation,
flGetOperation,
flGetFunctionAddr,
flCopyArrayExt,
flCopyArrayDbl,
flCopyArrayInt,
flCopyArrayExtDSC,
flCopyMemory,
flCopyVarCxD,
flCopyVarCxE,
flCopyVarD,
flCopyVarE,
flCopyVarI;




{$R *.Res}



begin
  //SetMinimumBlockAlignment(mba16Byte);
end.
