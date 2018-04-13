unit Teste.Builder.Juncao;

interface

uses
  SQL.Intf.Tabela,
  SQL.Impl.Juncao.Builder;

type
  TCBJuncaoBase = class(TBuilderJuncao)
  public
    procedure AfterConstruction; override;
    procedure buildSQL; override;

  end;

  TCBJuncaoApenasTabela = class(TCBJuncaoBase)
  private
    function getTabela: ISQLTabela;
  public
    procedure buildTabela; override;
    procedure buildCondicoes; override;
  end;

  TCBJuncaoTabelaComAlias = class(TCBJuncaoBase)
  private
    function getTabela: ISQLTabela;
  public
    procedure buildTabela; override;
    procedure buildCondicoes; override;
  end;

implementation

uses
  System.SysUtils,
  Teste.Constantes,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Condicao,
  SQL.Intf.Condicao.Builder,
  SQL.Intf.Tabela.Builder,
  SQL.Intf.Coluna,
  SQL.Impl.Condicao.Director,
  SQL.Impl.Tabela.Director,
  Teste.Builder.Coluna,
  Teste.Builder.Tabela,
  Teste.Builder.Condicao;

{ TBuilderJuncaoApenasTabela }

procedure TCBJuncaoApenasTabela.buildCondicoes;
var
  _directorCondicao: DesignPattern.Builder.Intf.Director.IDirector<IBuilderCondicao, ISQLCondicao>;

  _condicao: ISQLCondicao;
begin
  _directorCondicao := TDirectorCondicao.New;

  _directorCondicao.setBuilder(TCBCondicaoValor.New);
  _directorCondicao.construir;
  _condicao := _directorCondicao.getObjetoPronto;

  _condicao.getColuna.setTabela(getTabela);

  FObjeto.addCondicao(_condicao);
end;

{ TBuilderJuncaoTabelaComAlias }

procedure TCBJuncaoTabelaComAlias.buildCondicoes;
var
  _directorCondicao: DesignPattern.Builder.Intf.Director.IDirector<IBuilderCondicao, ISQLCondicao>;

  _condicao: ISQLCondicao;
begin
  _directorCondicao := TDirectorCondicao.New;

  _directorCondicao.setBuilder(TCBCondicaoValor.New);
  _directorCondicao.construir;
  _condicao := _directorCondicao.getObjetoPronto;

  _condicao.getColuna.setTabela(getTabela);

  FObjeto.addCondicao(_condicao);
end;

procedure TCBJuncaoTabelaComAlias.buildTabela;
begin
  inherited;
  FObjeto.setTabelaEstrangeira(getTabela);
end;

function TCBJuncaoTabelaComAlias.getTabela: ISQLTabela;
var
  _directorTabela: IDirector<IBuilderTabela, ISQLTabela>;
begin
  _directorTabela := TDirectorTabela.New;
  _directorTabela.setBuilder(TCBTabelaComNomeEAlias.New);
  _directorTabela.construir;
  result := _directorTabela.getObjetoPronto;
end;

procedure TCBJuncaoApenasTabela.buildTabela;
begin
  inherited;
  FObjeto.setTabelaEstrangeira(getTabela);
end;

function TCBJuncaoApenasTabela.getTabela: ISQLTabela;
var
  _directorTabela: DesignPattern.Builder.Intf.Director.IDirector<IBuilderTabela, ISQLTabela>;
begin
  _directorTabela := TDirectorTabela.New;
  _directorTabela.setBuilder(TCBTabelaComNomeApenas.New);
  _directorTabela.construir;
  result := _directorTabela.getObjetoPronto;
end;

{ TCBJuncaoBase }

procedure TCBJuncaoBase.AfterConstruction;
begin
  inherited;
  setOtimizarPara(OTIMIZAR_PARA);
end;

procedure TCBJuncaoBase.buildSQL;
begin
  inherited;

end;

end.
