unit GeradorSQL.ConcreteBuilder.Tabela;

interface

uses
  GeradorSQL.Comp.Collection.Tabela,
  SQL.Intf.Tabela.Builder,
  SQL.Impl.Tabela.Builder;

type
  TCBTabela = class(TBuilderTabela)
  private
    FTabela: TTabela;
  public
    constructor Create(ATabela: TTabela); reintroduce;
    class function New(ATabela: TTabela): IBuilderTabela; reintroduce;
    procedure buildAliasTabela; override;
    procedure buildNomeTabela; override;
  end;

implementation

{ TCBTabela }

procedure TCBTabela.buildAliasTabela;
begin
  inherited;
  FObjeto.setAlias(FTabela.Alias);
end;

procedure TCBTabela.buildNomeTabela;
begin
  inherited;
  FObjeto.setNome(FTabela.Nome);
end;

constructor TCBTabela.Create(ATabela: TTabela);
begin
  FTabela := ATabela;
end;

class function TCBTabela.New(ATabela: TTabela): IBuilderTabela;
begin
  Result := Create(ATabela);
end;

end.
