unit MVC.Intf.LocalizadorController;

interface

uses
  MVC.Impl.Controller, MVC.Anotacoes.Anotacao;

type
  ILocalizadorController = Interface(IInterface)
    ['{1D85752C-2409-4515-95AF-015B93361A03}']
    function Localizar(const AAnotacaoClass: TAnotacaoAttributeClass; const MinhaClass: string): TControllerClass;
  end;

implementation

end.
