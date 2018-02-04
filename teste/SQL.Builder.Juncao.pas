unit SQL.Builder.Juncao;

interface

uses
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Juncao;

type
  IBuilderJuncao = interface(IInterface)
    ['{D1CDB699-1DD2-4F44-BEE4-6587AE3E2735}']
    function getJuncao: ISQLJuncao;
    procedure criarNovaJuncao;
    procedure AdicionarTabela;
    procedure AdicionarCondicao;
  end;

  TBuilderJuncao = class(TInterfacedObject, IBuilderJuncao)
  protected
    FJuncao: ISQLJuncao;
  public
    class function New: IBuilderJuncao;
    function getJuncao: ISQLJuncao;
    procedure criarNovaJuncao;
    procedure AdicionarTabela; virtual;
    procedure AdicionarCondicao; virtual; abstract;
  end;

  TBuilderJuncaoApenasTabela = class(TBuilderJuncao)
  public
    procedure AdicionarCondicao; override;
  end;

  TBuilderJuncaoTabelaComAlias = class(TBuilderJuncao)
  public
    procedure AdicionarTabela; override;
    procedure AdicionarCondicao; override;
  end;

  TDirectorJuncao = class
  private
    FJuncaoBuilder: IBuilderJuncao;
  public
    procedure setBuilderJuncao(const ABuilderJuncao: IBuilderJuncao);
    procedure construirJuncao();
    function getJuncao: ISQLJuncao;
  end;

implementation

uses
  System.SysUtils,
  Teste.Constantes,
  SQL.Impl.Fabrica,
  SQL.Intf.Condicao,
  SQL.Builder.Coluna,
  SQL.Builder.Tabela,
  SQL.Builder.Condicao;

{ TBuilderJuncao }

procedure TBuilderJuncao.AdicionarTabela;
var
  _directorTabela: TDirectorTabela;
begin
  _directorTabela := TDirectorTabela.Create;
  try
    _directorTabela.setBuilderTabela(TBuilderTabelaComNomeEAlias.New);
    _directorTabela.construirTabela;
    FJuncao.setTabelaEstrangeira(_directorTabela.getTabela);
  finally
    FreeAndNil(_directorTabela);
  end;
end;

procedure TBuilderJuncao.criarNovaJuncao;
var
  _director: TDirectorColuna;
begin
  _director := TDirectorColuna.Create;
  try
    FJuncao := TFabrica.New(SQL_TIPO_PADRAO).Juncao;
  finally
    FreeAndNil(_director);
  end;
end;

function TBuilderJuncao.getJuncao: ISQLJuncao;
begin
  result := FJuncao;
end;

class function TBuilderJuncao.New: IBuilderJuncao;
begin
  result := Create;
end;

{ TDirectorJuncao }

procedure TDirectorJuncao.construirJuncao;
begin
  FJuncaoBuilder.criarNovaJuncao;
  FJuncaoBuilder.AdicionarTabela;
  FJuncaoBuilder.AdicionarCondicao
end;

function TDirectorJuncao.getJuncao: ISQLJuncao;
begin
  result := FJuncaoBuilder.getJuncao;
end;

procedure TDirectorJuncao.setBuilderJuncao(const ABuilderJuncao: IBuilderJuncao);
begin
  FJuncaoBuilder := ABuilderJuncao;
end;

{ TBuilderJuncaoApenasTabela }

procedure TBuilderJuncaoApenasTabela.AdicionarCondicao;
var
  _directorCondicao: TDirectorCondicao;
  _directorTabela: TDirectorTabela;
  _condicao: ISQLCondicao;
begin
  _directorCondicao := TDirectorCondicao.Create;
  _directorTabela := TDirectorTabela.Create;
  try
    _directorCondicao.setBuilderCondicao(TBuilderCondicaoValor.New);
    _directorCondicao.construirCondicao;
    _condicao := _directorCondicao.getCondicao;

    _directorTabela.setBuilderTabela(TBuilderTabelaComNomeEAlias.New);
    _directorTabela.construirTabela;

    _condicao.getColuna.setTabela(_directorTabela.getTabela);

    FJuncao.addCondicao(_condicao);
  finally
    FreeAndNil(_directorCondicao);
    FreeAndNil(_directorTabela);
  end;
end;

{ TBuilderJuncaoTabelaComAlias }

procedure TBuilderJuncaoTabelaComAlias.AdicionarCondicao;
begin
  inherited;

end;

procedure TBuilderJuncaoTabelaComAlias.AdicionarTabela;
begin
  inherited;
  FJuncao
    .getTabelaEstrangeira
    .setNome(TABELA_COM_ALIAS)
    .setAlias(TABELA_ALIAS);
end;

end.
