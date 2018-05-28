unit MVC.Impl.LocalizadorController;

interface

uses
  System.Generics.Collections, MVC.Intf.Controller, MVC.Impl.Controller, MVC.Intf.LocalizadorController,
  MVC.Anotacoes.Anotacao, MVC.RegistroDeClasses;

type
  TLocalizadorController = class(TInterfacedObject, ILocalizadorController)
  private
    FListaClasses: TDictionary<string, TControllerClass>;
  public
    class function New(const AListaClasses: TControllerDictionary): ILocalizadorController;
    constructor Create(const AListaClasses: TControllerDictionary);
    function Localizar(const AAnotacaoClass: TAnotacaoAttributeClass; const MinhaClass: string): TControllerClass;
  end;

implementation

uses
  System.SysUtils, System.Rtti, System.TypInfo, pkgUtils.Impl.RTTIUtils;

class function TLocalizadorController.New(const AListaClasses: TControllerDictionary): ILocalizadorController;
begin
  result := Create(AListaClasses);
end;

constructor TLocalizadorController.Create(const AListaClasses: TControllerDictionary);
begin
  FListaClasses := AListaClasses;
end;

function TLocalizadorController.Localizar(const AAnotacaoClass: TAnotacaoAttributeClass; const MinhaClass: string)
  : TControllerClass;
var
  _pair: TControllerPair;
  _anotacao: TAnotacaoAttribute;
begin
  result := nil;
  _anotacao := AAnotacaoClass.Create(MinhaClass);
  try
    for _pair in FListaClasses do
    begin
      if _anotacao.ClasseContemEstaAnotacao(_pair.Value) then
      begin
        result := _pair.Value;
        break;
      end;
    end;
  finally
    FreeAndNil(_anotacao);
  end;
end;

end.
