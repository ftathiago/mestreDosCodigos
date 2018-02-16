unit GeradorSQL.ConcreteBuilder.Coluna;

interface

uses
  GeradorSQL.Comp.Collection.Coluna,
  SQL.Enums,
  SQL.Intf.Coluna.Builder,
  SQL.Impl.Coluna.Builder;

type
  TCBColuna = class(TBuilderColuna)
  private
    FColuna: TColuna;
  public
    constructor Create(const AColuna: TColuna; const OtimizarPara: TOtimizarPara); reintroduce;
    class function New(const AColuna: TColuna; const OtimizarPara: TOtimizarPara): IBuilderColuna;
      reintroduce;
    procedure buildNome; override;
    procedure buildNomeVirtual; override;
    procedure buildTabela; override;
    procedure buildSQL; override;
  end;

implementation

uses
  System.SysUtils,
  SQL.Impl.SQL,
  SQL.Intf.SQL,
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

procedure TCBColuna.buildSQL;
begin
  inherited;
  if FColuna.SQLTexto.Count > 0 then
    FObjeto.setTextoSQL(FColuna.SQLTexto.Text);
end;

procedure TCBColuna.buildTabela;
var
  _director: IDirector<IBuilderTabela, ISQLTabela>;
  _concreteBuilder: IBuilderTabela;
begin
  inherited;
  if FColuna.Tabela.Nome.Trim.IsEmpty then
    exit;

  _concreteBuilder := TCBTabela.New(FColuna.Tabela, getOtimizarPara);

  _director := TDirectorTabela.New;
  _director.setBuilder(_concreteBuilder);
  _director.Construir;

  FObjeto.setTabela(_director.getObjetoPronto);
end;

constructor TCBColuna.Create(const AColuna: TColuna; const OtimizarPara: TOtimizarPara);
begin
  FColuna := AColuna;
  setOtimizarPara(OtimizarPara);
end;

class function TCBColuna.New(const AColuna: TColuna; const OtimizarPara: TOtimizarPara)
  : IBuilderColuna;
begin
  Result := Create(AColuna, OtimizarPara);
end;

end.
