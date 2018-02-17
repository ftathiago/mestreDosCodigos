unit GeradorSQL.ConcreteBuilder.Select;

interface

uses
  GeradorSQL.Comp.Select,
  SQL.Enums,
  SQL.Intf.Select.Builder,
  SQL.Impl.Select.Builder,
  SQL.Intf.Tabela;

type
  TCBSelectComponente = class(TBuilderSelect)
  private
    FMCSelect: TMCSelect;
  public
    constructor Create(AMCSelect: TMCSelect); reintroduce;
    class function New(AMCSelect: TMCSelect): IBuilderSelect;
    procedure buildSQLAntes; override;
    procedure buildSQLApos; override;
    procedure buildLimite; override;
    procedure buildSalto; override;
    procedure buildCampo; override;
    procedure buildFrom; override;
    procedure buildJuncao; override;
    procedure buildWhere; override;
    procedure buildOrderBy; override;
    procedure buildGroupBy; override;
    procedure buildSQL; override;
  end;

implementation

uses
  System.Classes,
  System.Generics.Collections,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.SQL,
  SQL.Impl.SQL,
  SQL.Intf.Tabela.Builder,
  SQL.Impl.Tabela.Director,
  SQL.Intf.Coluna,
  SQL.Intf.Coluna.Builder,
  SQL.Impl.Coluna.Director,
  SQL.Intf.Juncao,
  SQL.Intf.Juncao.Builder,
  SQL.Impl.Juncao.Director,
  SQL.Intf.Condicao,
  SQL.Intf.Condicao.Builder,
  SQL.Impl.Condicao.Director,
  GeradorSQL.Comp.Collection.Coluna,
  GeradorSQL.Comp.Collection.Juncao,
  GeradorSQL.Comp.Collection.Condicao,
  GeradorSQL.ConcreteBuilder.Tabela,
  GeradorSQL.ConcreteBuilder.Coluna,
  GeradorSQL.ConcreteBuilder.Juncao,
  GeradorSQL.ConcreteBuilder.Condicao;

{ TCBSelectComponente }

procedure TCBSelectComponente.buildCampo;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
  _concreteBuilder: IBuilderColuna;
  _collectionItem: TColunaCollectionItem;
  i: Integer;
begin
  inherited;
  _director := TDirectorColuna.New;

  for i := 0 to Pred(FMCSelect.Coluna.Count) do
  begin
    _collectionItem := FMCSelect.Coluna.Items[i];
    _concreteBuilder := TCBColuna.New(_collectionItem.Coluna, getOtimizarPara);

    _director.setBuilder(_concreteBuilder);
    _director.Construir;

    FObjeto.addColuna(_director.getObjetoPronto);
  end;
end;

procedure TCBSelectComponente.buildFrom;
var
  _director: IDirector<IBuilderTabela, ISQLTabela>;
  _concreteBuilder: IBuilderTabela;
begin
  inherited;
  _concreteBuilder := TCBTabela.New(FMCSelect.From, getOtimizarPara);
  _concreteBuilder.SetOtimizarPara(getOtimizarPara);

  _director := TDirectorTabela.New;
  _director.setBuilder(_concreteBuilder);
  _director.Construir;

  FObjeto.setTabela(_director.getObjetoPronto)
end;

procedure TCBSelectComponente.buildGroupBy;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
  _concreteBuilder: IBuilderColuna;
  _collectionItem: TColunaCollectionItem;
  i: Integer;
begin
  inherited;
  _director := TDirectorColuna.New;

  for i := 0 to Pred(FMCSelect.GroupBy.Count) do
  begin
    _collectionItem := FMCSelect.GroupBy.Items[i];

    _concreteBuilder := TCBColuna.New(_collectionItem.Coluna, getOtimizarPara);
    _director.setBuilder(_concreteBuilder);
    _director.Construir;

    FObjeto.addGroupBy(_director.getObjetoPronto);
  end;
end;

procedure TCBSelectComponente.buildJuncao;
var
  i: Integer;
  _director: IDirector<IBuilderJuncao, ISQLJuncao>;
  _builder: IBuilderJuncao;
  _juncaoItem: TJuncaoCollectionItem;
begin
  inherited;
  _director := TDirectorJuncao.New;

  for i := 0 to Pred(FMCSelect.Juncao.Count) do
  begin
    _juncaoItem := FMCSelect.Juncao.Items[i];
    _builder := TCBJuncao.New(_juncaoItem, getOtimizarPara);

    _director.setBuilder(_builder);
    _director.Construir;

    FObjeto.addJuncao(_director.getObjetoPronto);
  end;
end;

procedure TCBSelectComponente.buildLimite;
begin
  inherited;
  FObjeto.setLimite(FMCSelect.LimitarRegistros);
end;

procedure TCBSelectComponente.buildOrderBy;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
  _concreteBuilder: IBuilderColuna;
  _collectionItem: TColunaCollectionItem;
  i: Integer;
begin
  inherited;
  _director := TDirectorColuna.New;

  for i := 0 to Pred(FMCSelect.OrderBy.Count) do
  begin
    _collectionItem := FMCSelect.OrderBy.Items[i];

    _concreteBuilder := TCBColuna.New(_collectionItem.Coluna, getOtimizarPara);
    _director.setBuilder(_concreteBuilder);
    _director.Construir;

    FObjeto.addOrderBy(_director.getObjetoPronto);
  end;
end;

procedure TCBSelectComponente.buildSalto;
begin
  inherited;
  FObjeto.setSaltar(FMCSelect.SaltarRegistros);
end;

procedure TCBSelectComponente.buildSQL;
begin
  inherited;
  if FMCSelect.SQLTexto.Count > 0 then
    FObjeto.setTextoSQL(FMCSelect.SQLTexto.Text)
end;

procedure TCBSelectComponente.buildSQLAntes;
var
  _sqlAntes: ISQL;
begin
  inherited;
  _sqlAntes := TSQL.New;
  _sqlAntes.setTextoSQL(FMCSelect.InjetarSQLAntes);

  FObjeto.injectSQLAntes(_sqlAntes);
end;

procedure TCBSelectComponente.buildSQLApos;
var
  _sqlApos: ISQL;
begin
  inherited;
  _sqlApos := TSQL.New;
  _sqlApos.setTextoSQL(FMCSelect.InjetarSQLApos);

  FObjeto.injectSQLApos(_sqlApos);
end;

procedure TCBSelectComponente.buildWhere;
var
  _director: IDirector<IBuilderCondicao, ISQLCondicao>;
  _builder: IBuilderCondicao;
  _condicaoItem: TCondicaoCollectionItem;
  i: Integer;
begin
  inherited;
  _director := TDirectorCondicao.New;
  for i := 0 to Pred(FMCSelect.Condicao.Count) do
  begin
    _condicaoItem := FMCSelect.Condicao.Items[i];

    _builder := TCBCondicao.New(_condicaoItem, getOtimizarPara);

    _director.setBuilder(_builder);
    _director.Construir;

    FObjeto.addCondicao(_director.getObjetoPronto)
  end;
end;

constructor TCBSelectComponente.Create(AMCSelect: TMCSelect);
begin
  inherited Create;
  FMCSelect := AMCSelect;
  SetOtimizarPara(AMCSelect.OtimizarPara);
end;

class function TCBSelectComponente.New(AMCSelect: TMCSelect): IBuilderSelect;
begin
  result := Create(AMCSelect);
end;

end.
