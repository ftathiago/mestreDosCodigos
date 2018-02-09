unit Teste.Builder.Juncao;

interface

uses
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Condicao.Builder,
  SQL.Intf.Builder,
  SQL.Intf.Juncao,
  SQL.Impl.Juncao.Builder,
  SQL.Impl.Condicao.Director;

type
  TBuilderJuncaoApenasTabela = class(TBuilderJuncao)
  public
    procedure AdicionarCondicao; override;
  end;

  TBuilderJuncaoTabelaComAlias = class(TBuilderJuncao)
  public
    procedure AdicionarTabela; override;
    procedure AdicionarCondicao; override;
  end;

implementation

uses
  System.SysUtils,
  Teste.Constantes,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Condicao,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  Teste.Builder.Coluna,
  SQL.Builder.Tabela,
  Teste.Builder.Condicao;

{ TBuilderJuncaoApenasTabela }

procedure TBuilderJuncaoApenasTabela.AdicionarCondicao;
var
  _directorCondicao: DesignPattern.Builder.Intf.Director.IDirector<IBuilderCondicao, ISQLCondicao>;
  _directorTabela: DesignPattern.Builder.Intf.Director.IDirector<IBuilderTabela, ISQLTabela>;
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
