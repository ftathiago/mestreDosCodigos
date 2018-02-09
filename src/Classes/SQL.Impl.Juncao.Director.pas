unit SQL.Impl.Juncao.Director;

interface

uses
  DesignPattern.Builder.Impl.Director,
  SQL.Intf.Juncao,
  SQL.Intf.Juncao.Builder;

type
  TDirectorJuncao = class(TDirector<IBuilderJuncao, ISQLJuncao>)
  public
    procedure Construir(); override;
  end;

implementation

{ TDirectorJuncao }

procedure TDirectorJuncao.Construir;
begin
  inherited;
  FBuilder.ConstruirNovaInstancia;
  FBuilder.AdicionarTabela;
  FBuilder.AdicionarCondicao;
  FObjeto := FBuilder.getObjeto;
end;

end.
