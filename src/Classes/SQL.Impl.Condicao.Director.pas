unit SQL.Impl.Condicao.Director;

interface

uses
  DesignPattern.Builder.Impl.Director,
  SQL.Intf.Condicao,
  SQL.Intf.Condicao.Builder;


type
  TDirectorCondicao = class(TDirector<IBuilderCondicao, ISQLCondicao>)
  public
    procedure Construir(); override;
  end;

implementation

{ TDirectorCondicao }

procedure TDirectorCondicao.Construir;
begin
  inherited;
  FBuilder.ConstruirNovaInstancia;
  FBuilder.buildOperadorLogico;
  FBuilder.buildColuna;
  FBuilder.buildOperadorComparacao;
  FBuilder.buildValor;

  FObjeto := FBuilder.getObjeto
end;

end.
