unit GeradorSQL.Comp.Select;

interface

uses
  System.Rtti,
  System.Classes,
  System.Generics.Collections,
  SQL.Enums,
  SQL.Intf.Coluna,
  SQL.Intf.Fabrica,
  SQL.Impl.Coluna.Lista,
  GeradorSQL.Comp.Collection.Tabela,
  GeradorSQL.Comp.Collection.Coluna,
  GeradorSQL.Comp.Collection.Condicao,
  GeradorSQL.Comp.Collection.Juncao;

type
  TMCSelect = class(TComponent)
  private
    FOtimizarPara: TOtimizarPara;
    FFrom: TTabela;
    FColuna: TColunaCollection;
    FCondicao: TCondicaoCollection;
    FJuncao: TJuncaoCollection;
    procedure SetOtimizarPara(const Value: TOtimizarPara);
    procedure SetFrom(const Value: TTabela);
    procedure SetColuna(const Value: TColunaCollection);
    procedure SetCondicao(const Value: TCondicaoCollection);
    procedure SetJuncao(const Value: TJuncaoCollection);
    procedure ConstruirColunas(ColunasLista: TListaColunaSelect);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GerarSQL: string;
  published
    property OtimizarPara: TOtimizarPara read FOtimizarPara write SetOtimizarPara
      Default opPadraoSQL3;
    property Coluna: TColunaCollection read FColuna write SetColuna;
    property From: TTabela read FFrom write SetFrom;
    property Juncao: TJuncaoCollection read FJuncao write SetJuncao;
    property Condicao: TCondicaoCollection read FCondicao write SetCondicao;
  end;

  TColunaBuilder = class
  private
    FFabrica: IFabrica;
    FColunaCollection: TColunaCollection;
    FListaColuna: TListaColunaSelect;
  public
    constructor Create(OptimizarPara: TOtimizarPara);
    procedure SetListaColuna(ListaColuna: TListaColunaSelect);
    procedure SetColunaCollection(ColunaCollection: TColunaCollection);
    procedure Construir;
  end;

implementation

uses
  System.SysUtils,
  SQL.Intf.SQL,
  SQL.Impl.Fabrica;

{ TSelect }

procedure TMCSelect.ConstruirColunas(ColunasLista: TListaColunaSelect);
begin

end;

constructor TMCSelect.Create(AOwner: TComponent);
begin
  inherited;
  FFrom := TTabela.Create;
  FCondicao := TCondicaoCollection.Create(AOwner);
  FJuncao := TJuncaoCollection.Create(Self);
  FColuna := TColunaCollection.Create(AOwner);
  FOtimizarPara := opPadraoSQL3;
end;

destructor TMCSelect.Destroy;
begin
  FCondicao.Clear;
  FJuncao.Clear;
  FColuna.Clear;

  FreeAndNil(FCondicao);
  FreeAndNil(FJuncao);
  FreeAndNil(FColuna);
  FreeAndNil(FFrom);
  inherited;
end;

function TMCSelect.GerarSQL: string;
begin

end;

procedure TMCSelect.SetColuna(const Value: TColunaCollection);
begin
  FColuna := Value;
end;

procedure TMCSelect.SetCondicao(const Value: TCondicaoCollection);
begin
  FCondicao := Value;
end;

procedure TMCSelect.SetFrom(const Value: TTabela);
begin
  FFrom := Value;
end;

procedure TMCSelect.SetJuncao(const Value: TJuncaoCollection);
begin
  FJuncao := Value;
end;

procedure TMCSelect.SetOtimizarPara(const Value: TOtimizarPara);
begin
  FOtimizarPara := Value;
end;

{ TJuncao }

{ TColunaBuilder }

procedure TColunaBuilder.Construir;
var
  _coluna: TColuna;
  _SQLColuna: ISQLColuna;
  i: integer;
begin
  for i := 0 to Pred(FColunaCollection.Count) do
  begin
    _SQLColuna := FFabrica.Coluna;
    if Assigned(_coluna.Tabela) then
    begin
      _SQLColuna.setTabela(
        FFabrica.Tabela
          .setNome(_coluna.Tabela.Nome)
          .setAlias(_coluna.Tabela.Alias));
    end;
    _SQLColuna
      .setColuna(_coluna.Nome)
      .setNomeVirtual(_coluna.Alias);
    FListaColuna.Add(_SQLColuna);
  end;
end;

constructor TColunaBuilder.Create(OptimizarPara: TOtimizarPara);
begin
  FFabrica := TFabrica.New(OptimizarPara);
end;

procedure TColunaBuilder.SetColunaCollection(ColunaCollection: TColunaCollection);
begin
  FColunaCollection:= ColunaCollection;
end;

procedure TColunaBuilder.SetListaColuna(ListaColuna: TListaColunaSelect);
begin
  FListaColuna := ListaColuna;
end;

end.
