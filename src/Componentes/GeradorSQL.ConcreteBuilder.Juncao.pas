unit GeradorSQL.ConcreteBuilder.Juncao;

interface

uses
  GeradorSQL.Comp.Collection.Juncao,
  SQL.Intf.Juncao.Builder,
  SQL.Impl.Juncao.Builder;

type
  TCBJuncao = class(TBuilderJuncao)
  private
    FJuncao: TJuncaoCollectionItem;
  public
    constructor Create(AJuncao: TJuncaoCollectionItem); reintroduce;
    class function New(AJuncao: TJuncaoCollectionItem): IBuilderJuncao;
    procedure buildTabela; override;
    procedure buildCondicoes; override;
  end;

implementation

uses
  System.Classes,
  DesignPattern.Builder.Intf.Director,
  DesignPattern.Builder.Impl.Director,
  SQL.Intf.Tabela,
  SQL.Intf.Tabela.Builder,
  SQL.Impl.Tabela.Director,
  SQL.Intf.Condicao,
  SQL.Intf.Condicao.Builder,
  SQL.Impl.Condicao.Director,
  GeradorSQL.Comp.Collection.Condicao,
  GeradorSQL.ConcreteBuilder.Condicao,
  GeradorSQL.ConcreteBuilder.Tabela;

{ TCBJuncao }

procedure TCBJuncao.buildCondicoes;
var
  i: integer;
  _director: IDirector<IBuilderCondicao, ISQLCondicao>;
  _builder: IBuilderCondicao;
  _condicaoItem: TCondicaoCollectionItem;
begin
  inherited;
  _director := TDirectorCondicao.New;

  for i := 0 to Pred(FJuncao.Condicao.Count) do
  begin
    _condicaoItem := FJuncao.Condicao.Items[i];
    _builder := TCBCondicao.New(_condicaoItem);
    _director.setBuilder(_builder);
    _director.Construir;
    FObjeto.addCondicao(_director.getObjetoPronto);
  end;
end;

procedure TCBJuncao.buildTabela;
var
  _director: IDirector<IBuilderTabela, ISQLTabela>;
  _builder: IBuilderTabela;
begin
  inherited;
  _builder := TCBTabela.New(FJuncao.Tabela);

  _director := TDirectorTabela.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.setTabelaEstrangeira(_director.getObjetoPronto);
end;

constructor TCBJuncao.Create(AJuncao: TJuncaoCollectionItem);
begin
  inherited Create;
  FJuncao := AJuncao;
end;

class function TCBJuncao.New(AJuncao: TJuncaoCollectionItem): IBuilderJuncao;
begin
  Result := Create(AJuncao);
end;

end.
