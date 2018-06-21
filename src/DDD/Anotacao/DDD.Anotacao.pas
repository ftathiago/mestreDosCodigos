unit DDD.Anotacao;

interface

uses
  System.Rtti;

type
  TAnotacaoAttribute = class(TCustomAttribute)
  public
    class function PropriedadeEstaAnotada(const APropriedade: TRttiProperty): boolean;
    /// <summary>
    /// Extrai a anotaca da propriedade
    /// </summary>
    /// <param name="APropriedade">
    /// Rtti da propriedade investigada
    /// </param>
    /// <returns>
    /// nil se a anotação não existir na propriedade
    /// </returns>
    class function ExtrairAnotacao(const APropriedade: TRttiProperty): TAnotacaoAttribute;
  end;

  TAnotacaoAttributeClass = class of TAnotacaoAttribute;

implementation

uses
  System.SysUtils;

class function TAnotacaoAttribute.ExtrairAnotacao(const APropriedade: TRttiProperty): TAnotacaoAttribute;
var
  _listaAtributos: TArray<TCustomAttribute>;
  _atributo: TCustomAttribute;
begin
  result := nil;
  _listaAtributos := APropriedade.GetAttributes;
  for _atributo in _listaAtributos do
  begin
    if not _atributo.InheritsFrom(TAnotacaoAttribute) then
      continue;

    if _atributo.QualifiedClassName.Equals(Self.QualifiedClassName) then
    begin
      result := _atributo as TAnotacaoAttribute;
      break;
    end;
  end;
end;

class function TAnotacaoAttribute.PropriedadeEstaAnotada(const APropriedade: TRttiProperty): boolean;
var
  _listaAtributos: TArray<TCustomAttribute>;
  _atributo: TCustomAttribute;
begin
  result := false;
  _listaAtributos := APropriedade.GetAttributes;
  for _atributo in _listaAtributos do
  begin
    if not _atributo.InheritsFrom(TAnotacaoAttribute) then
      continue;

    result := _atributo.ClassNameIs(Self.ClassName);
    if result then
      break;
  end;
end;

end.
