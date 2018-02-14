unit GeradorSQL.Comp.Select;

interface

uses
  System.Rtti,
  System.Classes,
  System.Generics.Collections,
  SQL.Enums,
  SQL.Intf.Fabrica,
  SQL.Intf.Select,
  SQL.Intf.Coluna,
  SQL.Impl.Coluna.Lista,
  GeradorSQL.Comp.Collection.Tabela,
  GeradorSQL.Comp.Collection.Coluna,
  GeradorSQL.Comp.Collection.Condicao,
  GeradorSQL.Comp.Collection.Juncao;

type
  TMCSelect = class(TComponent)
  private
    FSelect: ISQLSelect;
    FOtimizarPara: TOtimizarPara;
    FFrom: TTabela;
    FColuna: TColunaCollection;
    FCondicao: TCondicaoCollection;
    FJuncao: TJuncaoCollection;
    FOrderBy: TColunaCollection;
    procedure SetOtimizarPara(const Value: TOtimizarPara);
    procedure SetFrom(const Value: TTabela);
    procedure SetColuna(const Value: TColunaCollection);
    procedure SetCondicao(const Value: TCondicaoCollection);
    procedure SetJuncao(const Value: TJuncaoCollection);
    procedure ConstruirSelect;
    procedure SetOrderBy(const Value: TColunaCollection);
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
    property OrderBy: TColunaCollection read FOrderBy write SetOrderBy;
  end;

implementation


uses
  System.SysUtils,
  DesignPattern.Builder.Intf.Director,
  DesignPattern.Builder.Impl.Director,
  SQL.Impl.Fabrica,
  SQL.Intf.SQL,
  SQL.Intf.Select.Builder,
  SQL.Impl.Select.Director,
  GeradorSQL.ConcreteBuilder.Select;

{ TSelect }

procedure TMCSelect.ConstruirSelect;
var
  _director: IDirector<IBuilderSelect, ISQLSelect>;
  _builder: IBuilderSelect;
begin
  if Assigned(FSelect) then
    exit;

  _builder := TCBSelectComponente.New(Self);

  _director := TDirectorSelect.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FSelect := _director.getObjetoPronto;
end;

constructor TMCSelect.Create(AOwner: TComponent);
begin
  inherited;
  FFrom := TTabela.Create;
  FCondicao := TCondicaoCollection.Create(AOwner);
  FJuncao := TJuncaoCollection.Create(Self);
  FColuna := TColunaCollection.Create(AOwner);
  FOrderBy := TColunaCollection.Create(Self);
  FOtimizarPara := opPadraoSQL3;
end;

destructor TMCSelect.Destroy;
begin
  FCondicao.Clear;
  FJuncao.Clear;
  FColuna.Clear;
  FOrderBy.Clear;

  FreeAndNil(FCondicao);
  FreeAndNil(FJuncao);
  FreeAndNil(FColuna);
  FreeAndNil(FFrom);
  FreeAndNil(FOrderBy);
  inherited;
end;

function TMCSelect.GerarSQL: string;
begin
  ConstruirSelect;
  result := FSelect.ToString;
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

procedure TMCSelect.SetOrderBy(const Value: TColunaCollection);
begin
  FOrderBy := Value;
end;

procedure TMCSelect.SetOtimizarPara(const Value: TOtimizarPara);
begin
  FOtimizarPara := Value;
end;

end.
