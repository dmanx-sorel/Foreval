                      Для компиляции в режиме подключения Foreval.dll.

  Компиляция тестовой программы: 
      Скопировать  модули :  TestForevalG9.pas, DefFN.pas, Forevaldll.pas из папки .../Test/CommonDelphiLazarus в папку .../Test/Lazarus/Sources 
      Компилировать TestG9.lpr в папке  .../Test/Lazarus/Sources
  Компиляция Foreval.dll: 
      Скопировать исходники Foreval ".pas" из папки .../Foreval/Foreval в папку .../Foreval/Lazarus
      Компилировать Foreval.lpr.
  Поместить Foreval.dll и тестовую программу в одну папку.




                 Для компиляции в режиме непосредственного подключения Foreval к программе:

  Скопировать модули TestForevalG9.pas, DefFN.pas  из папки .../Test/CommonDelphiLazarus в папку .../Test/Lazarus/Sources 
  Скопируйте исходники Foreval ".pas" из папки .../Foreval/Foreval в папку .../Test/Lazarus/Sources
  В модулях тестовой программы: TestForevalG9.pas и интерфейсном модуле Foreval: Foreval_Lib.pas запретите ключ {$DEFINE USEDLL}.
  Компилировать TestG9.lpr.




PS
Модули тестовой программы   :  TestForevalG9.pas, DefFN.pas
 модуль подключения         :  Forevaldll.pas
 и '.pas' модули Foreval.dll:  Foreval_Lib.pas, Foreval_Main.pas, Foreval_Command.pas, 
                               Foreval_DiffNumeric.pas, Foreval_SpecFunc.pas, Foreval_Definitions
 одинаковы для Delphi и Lazarus.





  Foreval.dll скомпилированная в FPC(Lazarus) не полностью совместима с версией, скомпилированной в Delphi 2009:
    отсутствует поддержка строковых типов UTF16, UTF8;
    несовместим формат динамических массивов (даже в {$MODE DELPHI}) - (Length -> High)  (Действительный размер = Length(FPC) + 1  !!!))
    Нельзя объявлять динамические массивы в exe(Delphi) и подключать dll(FPC) и наоборот. 
    В таких случаях  подключать как внутренние: flSetVarIntrnl, либо компилировать dll и exe в одной среде, 
      либо использовать компиляцию с прямым подключением модулей Foreval.

 В версии 9.1.1 эту несовместимость можно частично обойти через передачу информации о среде компиляции EXE в DLL (См doc)
     flSet(fl_COMPILER_TYPE_EXE,  fl_DELPHI, 0  )  
     flSet(fl_COMPILER_TYPE_EXE,  fl_FREE_PASCAL, 0  ) 
 


Компиляция проверялась в Лазарус 2.0.10 (FPC 3.2)



