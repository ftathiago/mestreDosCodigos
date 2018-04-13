unit GeradorSQL.ConcreteBuilder.Condicao;

interface

uses
  GeradorSQL.Comp.Collection.Condicao,
  SQL.Enums,
  SQL.Intf.Condicao.Builder,
  SQL.Impl.Condicao.Builder;

type
  TCBCondicao = class(TBuilderCondicao)
  private
    FCondicao: TCondicao;
  public
    constructor Create(ACondicaoCollectionItem: TCondicaoCollectionItem;
      const OtimizarPara: TOtimizarPara); reintroduce;
    class function New(ACondicaoCollectionItem: TCondicaoCollectionItem;
      const OtimizarPara: TOtimizarPara): IBuilderCondicao; reintroduce;
    procedure buildValor; override;
    procedure buildColuna; override;
    procedure buildOperadorComparacao; override;
    procedure buildOperadorLogico; override;
    procedure buildSQL; override;
  end;

implementation

uses
  DesignPattern.Builder.Intf.Director,
  DesignPattern.Builder.Impl.Director,
  SQL.Intf.SQL,
  SQL.Impl.SQL,
  SQL.Intf.Coluna,
  SQL.Intf.Coluna.Builder,
  SQL.Impl.Coluna.Director,
  GeradorSQL.ConcreteBuilder.Coluna;

{ TCBCondicao }

procedure TCBCondicao.buildColuna;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
  _builder: IBuilderColuna;
begin
  inherited;
  _builder := TCBColuna.New(FCondicao.Coluna, getOtimizarPara);

  _director := TDirectorColuna.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.setColuna(_director.getObjetoPronto);
end;

procedure TCBCondicao.buildOperadorComparacao;
begin
  inherited;
  FObjeto.setOperadorComparacao(FCondicao.OperadorComparacao);
end;

procedure TCBCondicao.buildOperadorLogico;
begin
  inherited;
  FObjeto.setOperadorLogico(FCondicao.OperadorLogico);
end;

procedure TCBCondicao.buildSQL;
begin
  inherited;
  if FCondicao.SQLTexto.Count > 0 then
    FObjeto.setTextoSQL(FCondicao.SQLTexto.Text);
end;

procedure TCBCondicao.buildValor;
begin
  inherited;
  FObjeto.setValor(FCondicao.Valor)
end;

constructor TCBCondicao.Create(ACondicaoCollectionItem: TCondicaoCollectionItem;
  const OtimizarPara: TOtimizarPara);
begin
  FCondicao := ACondicaoCollectionItem.Condicao;
  setOtimizarPara(OtimizarPara);
end;

class function TCBCondicao.New(ACondicaoCollectionItem: TCondicaoCollectionItem;
  const OtimizarPara: TOtimizarPara): IBuilderCondicao;
begin
  result := Create(ACondicaoCollectionItem, OtimizarPara);
end;

end.
