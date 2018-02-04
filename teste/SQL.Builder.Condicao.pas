unit SQL.Builder.Condicao;

interface

uses
  System.Rtti,
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.SQL,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao;

type
  IBuilderCondicao = interface(IInterface)
    ['{FB34CE34-00D8-4B1A-8E99-3D2AF86A2A7D}']
    function getCondicao: ISQLCondicao;
    procedure criarNovaCondicao();
    procedure buildValor();
  end;

  TBuilderCondicao = class(TInterfacedObject, IBuilderCondicao)
  protected
    FCondicao: ISQLCondicao;
  private
    function getColuna: ISQLColuna;
  public
    class function New: IBuilderCondicao;
    function getCondicao: ISQLCondicao;
    procedure criarNovaCondicao();
    procedure buildValor(); virtual; abstract;
  end;

  TBuilderCondicaoValor = class(TBuilderCondicao)
  public
    procedure buildValor(); override;
  end;

  TDirectorCondicao = class
  private
    FCondicaoBuilder: IBuilderCondicao;
  public
    procedure setBuilderCondicao(const ABuilderCondicao: IBuilderCondicao);
    procedure construirCondicao();
    function getCondicao: ISQLCondicao;
  end;

implementation

uses
  Teste.Constantes,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  SQL.Builder.Tabela,
  SQL.Builder.Coluna;

{ TBuilderCondicao }

procedure TBuilderCondicao.criarNovaCondicao();
begin
  FCondicao := TFabrica.New(SQL_TIPO_PADRAO).Condicao;
  FCondicao
    .setOperadorLogico(olAnd)
    .setColuna(getColuna)
    .setOperadorComparacao(ocIgual);
end;

function TBuilderCondicao.getColuna: ISQLColuna;
var
  _builder: IBuilderColuna;
  _director: TDirectorColuna;
begin
  _director :=  TDirectorColuna.Create;
  _builder := TBuilderColunaSimples.New;
  try
    _director.setBuilderColuna(_builder);
    _director.construirColuna;
    result := _director.getColuna;
  finally
    _director.free;
  end;
end;

function TBuilderCondicao.getCondicao: ISQLCondicao;
begin
  result := FCondicao;
end;

class function TBuilderCondicao.New: IBuilderCondicao;
begin
  result := Create;
end;

{ TDirectorTabela }

procedure TDirectorCondicao.construirCondicao;
begin
  FCondicaoBuilder.criarNovaCondicao;
  FCondicaoBuilder.buildValor;
end;

function TDirectorCondicao.getCondicao: ISQLCondicao;
begin
  result := FCondicaoBuilder.getCondicao;
end;

procedure TDirectorCondicao.setBuilderCondicao(const ABuilderCondicao: IBuilderCondicao);
begin
  FCondicaoBuilder := ABuilderCondicao;
end;

{ TBuilderCondicaoValor }

procedure TBuilderCondicaoValor.buildValor;
begin
  FCondicao.setValor('VALOR')
end;

end.
