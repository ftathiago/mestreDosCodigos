unit DDD.Anotacao.Entidade;

interface

uses
  DDD.Anotacao;

type
  TEntidadeAttribute = class(TAnotacaoAttribute)
  private
    FNomeEntidade: string;
  public
    constructor Create(const ANomeEntidade: string);
    property NomeEntidade: string read FNomeEntidade;
  end;

implementation


constructor TEntidadeAttribute.Create(const ANomeEntidade: string);
begin
  FNomeEntidade := ANomeEntidade;
end;

end.
