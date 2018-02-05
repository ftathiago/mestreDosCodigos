unit SQL.Builder.Condicao;

interface

uses
  System.Rtti,
  SQL.Intf.Builder,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao,
  SQL.Impl.Builder,
  SQL.Impl.Director;

type
  IBuilderCondicao = interface(IBuilder<ISQLCondicao>)
    ['{FB34CE34-00D8-4B1A-8E99-3D2AF86A2A7D}']
    procedure buildValor();
  end;

  TBuilderCondicao = class(TBuilder<ISQLCondicao>, IBuilderCondicao)
  protected
  private
    function getColuna: ISQLColuna;
  public
    class function New: IBuilderCondicao;
    procedure ConstruirNovaInstancia(); override;
    procedure buildValor(); virtual; abstract;
  end;

  TBuilderCondicaoValor = class(TBuilderCondicao)
  public
    procedure buildValor(); override;
  end;

  TDirectorCondicao = class(TDirector<IBuilderCondicao, ISQLCondicao>)
  public
    procedure Construir(); override;
  end;

implementation

uses
  Teste.Constantes,
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Director,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  SQL.Builder.Tabela,
  SQL.Builder.Coluna;

{ TBuilderCondicao }

procedure TBuilderCondicao.ConstruirNovaInstancia();
begin
  FObjeto := TFabrica.New(SQL_TIPO_PADRAO).Condicao;
  FObjeto
    .setOperadorLogico(olAnd)
    .setColuna(getColuna)
    .setOperadorComparacao(ocIgual);
end;

function TBuilderCondicao.getColuna: ISQLColuna;
var
  _builder: IBuilderColuna;
  _director: IDirector<IBuilderColuna, ISQLColuna>;
begin
  _builder := TBuilderColunaSimples.New;

  _director := TDirectorColuna.New;
  _director.setBuilder(_builder);
  _director.construir;

  result := _director.getObjetoPronto;
end;

class function TBuilderCondicao.New: IBuilderCondicao;
begin
  result := Create;
end;

{ TDirectorTabela }

procedure TDirectorCondicao.construir;
begin
  FBuilder.ConstruirNovaInstancia;
  FBuilder.buildValor;
  FObjeto := FBuilder.getObjeto
end;

{ TBuilderCondicaoValor }

procedure TBuilderCondicaoValor.buildValor;
begin
  FObjeto.setValor('VALOR')
end;

end.
