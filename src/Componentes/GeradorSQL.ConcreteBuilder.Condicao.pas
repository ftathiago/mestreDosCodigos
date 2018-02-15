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
    FCondicaoCollectionItem: TCondicaoCollectionItem;
  public
    constructor Create(ACondicao: TCondicaoCollectionItem; const OtimizarPara: TOtimizarPara); reintroduce;
    class function New(ACondicao: TCondicaoCollectionItem; const OtimizarPara: TOtimizarPara): IBuilderCondicao; reintroduce;
    procedure buildValor; override;
    procedure buildColuna; override;
    procedure buildOperadorComparacao; override;
    procedure buildOperadorLogico; override;
  end;

implementation

uses
  DesignPattern.Builder.Intf.Director,
  DesignPattern.Builder.Impl.Director,
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
  _builder := TCBColuna.New(FCondicaoCollectionItem.Condicao.Coluna, getOtimizarPara);

  _director := TDirectorColuna.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.setColuna(_director.getObjetoPronto);
end;

procedure TCBCondicao.buildOperadorComparacao;
begin
  inherited;
  FObjeto.setOperadorComparacao(FCondicaoCollectionItem.Condicao.OperadorComparacao);
end;

procedure TCBCondicao.buildOperadorLogico;
begin
  inherited;
  FObjeto.setOperadorLogico(FCondicaoCollectionItem.Condicao.OperadorLogico);
end;

procedure TCBCondicao.buildValor;
begin
  inherited;
  FObjeto.setValor(FCondicaoCollectionItem.Condicao.Valor)
end;

constructor TCBCondicao.Create(ACondicao: TCondicaoCollectionItem; const OtimizarPara: TOtimizarPara);
begin
  FCondicaoCollectionItem := ACondicao;
  setOtimizarPara(OtimizarPara);
end;

class function TCBCondicao.New(ACondicao: TCondicaoCollectionItem; const OtimizarPara: TOtimizarPara): IBuilderCondicao;
begin
  result := Create(ACondicao, OtimizarPara);
end;

end.
