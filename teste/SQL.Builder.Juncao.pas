unit SQL.Builder.Juncao;

interface

uses
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Builder,
  SQL.Intf.Juncao,
  SQL.Impl.Builder,
  SQL.Impl.Director;

type
  IBuilderJuncao = interface(IBuilder<ISQLJuncao>)
    ['{D1CDB699-1DD2-4F44-BEE4-6587AE3E2735}']
    procedure AdicionarTabela;
    procedure AdicionarCondicao;
  end;

  TBuilderJuncao = class(TBuilder<ISQLJuncao>, IBuilderJuncao)
  public
    class function New: IBuilderJuncao;
    procedure ConstruirNovaInstancia; override;
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

  TDirectorJuncao = class(TDirector<IBuilderJuncao, ISQLJuncao>)
  public
    procedure Construir(); override;
  end;

implementation

uses
  System.SysUtils,
  Teste.Constantes,
  SQL.Impl.Fabrica,
  SQL.Intf.Condicao,
  SQL.Intf.Director,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Builder.Coluna,
  SQL.Builder.Tabela,
  SQL.Builder.Condicao;

{ TBuilderJuncao }

procedure TBuilderJuncao.AdicionarTabela;
var
  _directorTabela: IDirector<IBuilderTabela, ISQLTabela>;
begin
  _directorTabela := TDirectorTabela.New;
  _directorTabela.setBuilder(TBuilderTabelaComNomeEAlias.New);
  _directorTabela.construir;
  FObjeto.setTabelaEstrangeira(_directorTabela.getObjetoPronto);
end;

procedure TBuilderJuncao.ConstruirNovaInstancia;
begin
  FObjeto := TFabrica.New(SQL_TIPO_PADRAO).Juncao;
end;

class function TBuilderJuncao.New: IBuilderJuncao;
begin
  result := Create;
end;

{ TDirectorJuncao }

procedure TDirectorJuncao.Construir;
begin
  FBuilder.ConstruirNovaInstancia;
  FBuilder.AdicionarTabela;
  FBuilder.AdicionarCondicao;
  FObjeto := FBuilder.getObjeto;
end;



{ TBuilderJuncaoApenasTabela }

procedure TBuilderJuncaoApenasTabela.AdicionarCondicao;
var
  _directorCondicao: IDirector<IBuilderCondicao, ISQLCondicao>;
  _directorTabela: IDirector<IBuilderTabela, ISQLTabela>;
  _condicao: ISQLCondicao;
begin
  _directorCondicao := TDirectorCondicao.New;
  _directorTabela := TDirectorTabela.New;

  _directorCondicao.setBuilder(TBuilderCondicaoValor.New);
  _directorCondicao.construir;
  _condicao := _directorCondicao.getObjetoPronto;

  _directorTabela.setBuilder(TBuilderTabelaComNomeEAlias.New);
  _directorTabela.construir;

  _condicao.getColuna.setTabela(_directorTabela.getObjetoPronto);

  FObjeto.addCondicao(_condicao);
end;

{ TBuilderJuncaoTabelaComAlias }

procedure TBuilderJuncaoTabelaComAlias.AdicionarCondicao;
begin
  inherited;

end;

procedure TBuilderJuncaoTabelaComAlias.AdicionarTabela;
begin
  inherited;
  FObjeto
    .getTabelaEstrangeira
    .setNome(TABELA_COM_ALIAS)
    .setAlias(TABELA_ALIAS);
end;

end.
