unit DDD.Anotacao.Entidade.Propriedade;

interface

uses
  DDD.Anotacao,
  System.Rtti, Data.DB;

type
  /// <summary>
  ///   Anotação que referencia campos em uma tabela
  /// </summary>
  TPropriedadeAttribute = class(TAnotacaoAttribute)
  private
    FNomePropriedade: string;
    FTipoCampo: TFieldType;
    FRequerido: boolean;
  public
    constructor Create(const ANomePropriedade: string; const ATipoCampo: TFieldType;
      const ARequerido: boolean);
    property NomePropriedade: string read FNomePropriedade;
    property TipoCampo: TFieldType read FTipoCampo;
    property Requerido: boolean read FRequerido;
  end;

implementation

uses
  pkgUtils.Impl.RttiUtils;

constructor TPropriedadeAttribute.Create(const ANomePropriedade: string; const ATipoCampo: TFieldType;
  const ARequerido: boolean);
begin
  FNomePropriedade := ANomePropriedade;
  FTipoCampo := ATipoCampo;
  FRequerido := ARequerido;
end;


end.
