unit GeradorSQL.ConcreteBuilder.Coluna;

interface

uses
  GeradorSQL.Comp.Collection.Coluna,
  SQL.Intf.Coluna.Builder,
  SQL.Impl.Coluna.Builder;

type
  TCBColuna = class(TBuilderColuna)
  private
    FColuna: TColuna;
  public
    constructor Create(AColuna: TColuna); reintroduce;
    class function New(AColuna: TColuna): IBuilderColuna; reintroduce;
    procedure buildNome; override;
    procedure buildNomeVirtual; override;
    procedure buildTabela; override;
  end;

implementation

uses
  System.SysUtils,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Tabela,
  SQL.Intf.Tabela.Builder,
  SQL.Impl.Tabela.Director,
  GeradorSQL.ConcreteBuilder.Tabela;

{ TCBColuna }

procedure TCBColuna.buildNome;
begin
  inherited;
  FObjeto.setColuna(FColuna.Nome);
end;

procedure TCBColuna.buildNomeVirtual;
begin
  inherited;
  FObjeto.setNomeVirtual(FColuna.NomeVirtual);
end;

procedure TCBColuna.buildTabela;
var
  _director: IDirector<IBuilderTabela,ISQLTabela>;
  _concreteBuilder: IBuilderTabela;
begin
  inherited;
  if FColuna.Tabela.Nome.Trim.IsEmpty then
    exit;

  _concreteBuilder := TCBTabela.New(FColuna.Tabela);

  _director := TDirectorTabela.New;
  _director.setBuilder(_concreteBuilder);
  _director.Construir;

  FObjeto.setTabela(_director.getObjetoPronto);
end;

constructor TCBColuna.Create(AColuna: TColuna);
begin
  FColuna := AColuna;
end;

class function TCBColuna.New(AColuna: TColuna): IBuilderColuna;
begin
  Result := Create(AColuna);
end;


end.
