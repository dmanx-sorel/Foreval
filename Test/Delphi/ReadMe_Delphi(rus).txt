                            
                        Для компиляции в режиме подключения Foreval.dll:

  Компиляция тестовой программы: 
      Скопировать  модули :  TestForevalG9.pas, DefFN.pas, Forevaldll.pas из папки .../Test/CommonDelphiLazarus в папку .../Test/Delphi/Sources 
      Компилировать TestG9.dpr в папке  .../Test/Delphi/Sources
  Компиляция Foreval.dll: 
      Скопировать исходники Foreval ".pas" из папки .../Foreval/Foreval в папку .../Foreval/Delphi
      Компилировать Foreval.dpr.
  Поместить Foreval.dll и тестовую программу в одну папку.



                         Для компиляции в режиме непосредственного подключения Foreval к программе:

  Скопировать модули TestForevalG9.pas, DefFN.pas,  из папки .../Test/CommonDelphiLazarus в папку .../Test/Delphi/Sources 
  Скопировать исходники Foreval ".pas" из папки .../Foreval/Foreval в папку .../Test/Delphi/Sources
  В модулях тестовой программы: TestForevalG9.pas и интерфейсном модуле Foreval: Foreval_Lib.pas запретите ключ {$DEFINE USEDLL}.
  Компилировать TestG9.dpr.


PS
Модули тестовой программы  :  TestForevalG9.pas,DefFN.pas,
модуль подключения         :  Forevaldll.pas
и '.pas' модули Foreval.dll:  Foreval_Lib.pas, Foreval_Main.pas, Foreval_Command.pas, 
                              Foreval_DiffNumeric.pas, Foreval_SpecFunc.pas, Foreval_Definitions
одинаковы для Delphi и Lazarus.

Foreval.dll скомпилирована в DelphiXE3. 
Компиляция проверялась в Delphi2009, DelphiXE3