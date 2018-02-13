unit Teste.Builder.Select;

interface

uses
  DesignPattern.Builder.Intf.Builder,
  SQL.Intf.Select,
  SQL.Intf.Select.Builder,
  SQL.Impl.Select.Builder;

type

  TCBSelectSimples = class(TBuilderSelect)
  public
    procedure buildCampo; override;
    procedure buildFrom; override;
    procedure buildJuncao; override;
    procedure buildWhere; override;
  end;

implementation

uses
  DesignPattern.Builder.Intf.Director,
  DesignPattern.Builder.Impl.Director,
  SQL.Enums,
  SQL.Intf.Coluna,
  SQL.Intf.Coluna.Builder,
  SQL.Impl.Coluna.Director,
  SQL.Intf.Tabela,
  SQL.Intf.Tabela.Builder,
  SQL.Impl.Tabela.Director,
  SQL.Intf.Juncao,
  SQL.Intf.Juncao.Builder,
  SQL.Impl.Juncao.Director,
  SQL.Intf.Condicao,
  SQL.Intf.Condicao.Builder,
  SQL.Impl.Condicao.Director,
  Teste.Constantes,
  Teste.Builder.Tabela,
  Teste.Builder.Coluna,
  Teste.Builder.Juncao,
  Teste.Builder.Condicao;

{ TBuilderSelectSimples }

procedure TCBSelectSimples.buildCampo;
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

procedure TCBSelectSimples.buildFrom;
var
  _director: IDirector<IBuilderTabela, ISQLTabela>;
  _builder: IBuilderTabela;
begin
  _builder := TCBTabelaComNomeEAlias.New;

  _director := TDirectorTabela.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.setTabela(_director.getObjetoPronto);
end;

procedure TCBSelectSimples.buildJuncao;
var
  _director: IDirector<IBuilderJuncao, ISQLJuncao>;
  _builder: IBuilderJuncao;
begin
  _builder := TCBJuncaoTabelaComAlias.New;

  _director := TDirectorJuncao.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
end;

procedure TCBSelectSimples.buildWhere;
var
  _director: IDirector<IBuilderCondicao, ISQLCondicao>;
  _builder: IBuilderCondicao;
  _condicao: ISQLCondicao;
begin
  _builder := TCBCondicaoValor.New;

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
