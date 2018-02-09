unit Teste.Builder.Select;

interface

uses
  SQL.Intf.Builder,
  SQL.Intf.Select,
  SQL.Intf.Select.Builder,
  SQL.Impl.Select.Builder;

type

  TBuilderSelectSimples = class(TBuilderSelect)
  public
    procedure buildCampo; override;
    procedure buildFrom; override;
    procedure buildJuncao; override;
    procedure buildWhere; override;
  end;

implementation

uses
  Teste.Constantes,
  SQL.Enums,
  SQL.Constantes,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Fabrica,
  SQL.Intf.Coluna,
  SQL.Intf.Coluna.Builder,
  SQL.Intf.Juncao,
  SQL.Intf.Condicao,
  SQL.Intf.Condicao.Builder,
  SQL.Intf.Tabela,
  SQL.Impl.Fabrica,
  SQL.Impl.Condicao.Director,
  SQL.Impl.Coluna.Director,
  SQL.Intf.Juncao.Builder,
  SQL.Impl.Juncao.Director,
  SQL.Builder.Tabela,
  Teste.Builder.Coluna,
  Teste.Builder.Condicao,
  Teste.Builder.Juncao;

{ TBuilderSelectSimples }

procedure TBuilderSelectSimples.buildCampo;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
  _builder: IBuilderColuna;
begin
  _builder := TCBColunaSimples.New;
  _director := TDirectorColuna.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.addColuna(_director.getObjetoPronto);
  FObjeto.addColuna(_director.getObjetoPronto);
  FObjeto.addColuna(_director.getObjetoPronto);

  _builder := TCBColunaTotalmenteVirtual.New;
  _director.setBuilder(_builder);
  _director.Construir;
  FObjeto.addColuna(_director.getObjetoPronto);
end;

procedure TBuilderSelectSimples.buildFrom;
var
  _director: IDirector<IBuilderTabela, ISQLTabela>;
  _builder: IBuilderTabela;
begin
  _builder := TBuilderTabelaComNomeEAlias.New;

  _director := TDirectorTabela.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.setTabela(_director.getObjetoPronto);
end;

procedure TBuilderSelectSimples.buildJuncao;
var
  _director: IDirector<IBuilderJuncao, ISQLJuncao>;
  _builder: IBuilderJuncao;
begin
  _builder := TBuilderJuncaoApenasTabela.New;

  _director := TDirectorJuncao.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
end;

procedure TBuilderSelectSimples.buildWhere;
var
  _director: IDirector<IBuilderCondicao, ISQLCondicao>;
  _builder: IBuilderCondicao;
  _condicao: ISQLCondicao;
begin
  _builder := TBuilderCondicaoValor.New;

  _director := TDirectorCondicao.New;
  _director.setBuilder(_builder);

  _director.Construir;
  _condicao := _director.getObjetoPronto;
  FObjeto.addCondicao(_condicao);

  _director.Construir;
  _condicao := _director.getObjetoPronto;
  _condicao.setOperadorLogico(olOr);
  FObjeto.addCondicao(_condicao);

  _director.Construir;
  _condicao := _director.getObjetoPronto;
  _condicao.setOperadorLogico(olAnd);
  FObjeto.addCondicao(_condicao);
end;

end.
