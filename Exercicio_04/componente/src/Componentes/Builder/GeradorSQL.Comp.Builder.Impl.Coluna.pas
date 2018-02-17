unit GeradorSQL.Comp.Builder.Impl.Coluna;

interface

uses
  SQL.Impl.Builder.Coluna,
  GeradorSQL.Comp.Collection.Coluna;

type 
  TBuilderColunaCollection = class(TBuilder<ISQLColuna>, IBuilderColunaCollection)
  public
    class function New: IBuilderColunaCollection;
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
    procedure buildTabela(); override;
  end;

implementation

{ TBuilderColunaSimples }

procedure TBuilderColunaSimples.buildNome;
begin
  inherited;

end;

procedure TBuilderColunaSimples.buildNomeVirtual;
begin
  inherited;

end;

procedure TBuilderColunaSimples.buildTabela;
begin
  inherited;

end;

end.
