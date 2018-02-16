unit SQL.Impl.Coluna.Director;

interface

uses
  DesignPattern.Builder.Impl.Director,
  SQL.Intf.Coluna.Builder,
  SQL.Intf.Coluna.Director,
  SQL.Intf.Coluna,
  SQL.Intf.Tabela;

type
  TDirectorColuna = class(TDirector<IBuilderColuna, ISQLColuna>)
  public
    procedure Construir(); override;
  end;

implementation

{ TDirectorColuna }

procedure TDirectorColuna.Construir;
begin
  inherited;
  FBuilder.ConstruirNovaInstancia;

  FBuilder.buildSQL;
  FBuilder.buildNome;
  FBuilder.buildNomeVirtual;
  FBuilder.buildTabela;
  FObjeto := FBuilder.getObjeto;
end;

end.
