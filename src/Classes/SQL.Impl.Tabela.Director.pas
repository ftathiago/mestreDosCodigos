unit SQL.Impl.Tabela.Director;

interface

uses
  DesignPattern.Builder.Impl.Director,
  SQL.Intf.Tabela,
  SQL.Intf.Tabela.Builder;

type
  TDirectorTabela = class(TDirector<IBuilderTabela, ISQLTabela>)
  public
    procedure Construir; override;
  end;

implementation

{ TDirectorTabela }

procedure TDirectorTabela.construir;
begin
  FBuilder.ConstruirNovaInstancia;
  FBuilder.buildNomeTabela;
  FBuilder.buildAliasTabela;
  FObjeto := FBuilder.getObjeto
end;

end.
