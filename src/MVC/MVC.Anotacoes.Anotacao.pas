unit MVC.Anotacoes.Anotacao;

interface

type
  TAnotacaoAttribute = class;
  TAnotacaoAttributeClass = class of TAnotacaoAttribute;

  TAnotacaoAttribute = class(TCustomAttribute)
  private
    FAnotacao: string;
  public
    constructor Create(const AAnotacao: string);
    function ClasseContemEstaAnotacao(const AClasse: TClass): boolean; virtual;
    property Anotacao: string read FAnotacao;
  end;

implementation

uses
  System.SysUtils, System.Rtti, pkgUtils.Impl.RTTIUtils;

function TAnotacaoAttribute.ClasseContemEstaAnotacao(const AClasse: TClass): boolean;
var
  _anotacao: TCustomAttribute;
  _atributos: TArray<TCustomAttribute>;
  _instanceType: TRttiInstanceType;
begin
  result := False;
  _instanceType := RTTIUtils.getInstanceType(AClasse.QualifiedClassName);
  try
    _atributos := _instanceType.GetAttributes;

    for _anotacao in _atributos do
    begin
      if not(_anotacao is Self.ClassType) then
        Continue;

      result := SameText(TAnotacaoAttribute(_anotacao).Anotacao, Self.Anotacao);

      break;
    end;
  finally
    FreeAndNil(_instanceType);
  end;
end;

constructor TAnotacaoAttribute.Create(const AAnotacao: string);
begin
  FAnotacao := AAnotacao;
end;

end.
