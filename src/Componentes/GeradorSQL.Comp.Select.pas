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
    FGroupBy: TColunaCollection;
    FSaltarRegistros: integer;
    FLimitarRegistros: integer;
    FInjetarSQLApos: string;
    FInjetarSQLAntes: string;
    FSQLTexto: TStrings;
    procedure SetOtimizarPara(const Value: TOtimizarPara);
    procedure SetFrom(const Value: TTabela);
    procedure SetColuna(const Value: TColunaCollection);
    procedure SetCondicao(const Value: TCondicaoCollection);
    procedure SetJuncao(const Value: TJuncaoCollection);
    procedure ConstruirSelect;
    procedure SetOrderBy(const Value: TColunaCollection);
    procedure SetGroupBy(const Value: TColunaCollection);
    procedure SetLimitarRegistros(const Value: integer);
    procedure SetSaltarRegistros(const Value: integer);
    procedure SetInjetarSQLAntes(const Value: string);
    procedure SetInjetarSQLApos(const Value: string);
    procedure SetSQLTexto(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GerarSQL: string;
  published
    property InjetarSQLAntes: string read FInjetarSQLAntes write SetInjetarSQLAntes;
    property InjetarSQLApos: string read FInjetarSQLApos write SetInjetarSQLApos;
    property OtimizarPara: TOtimizarPara read FOtimizarPara write SetOtimizarPara
      Default opPadraoSQL3;
    property Coluna: TColunaCollection read FColuna write SetColuna;
    property From: TTabela read FFrom write SetFrom;
    property Juncao: TJuncaoCollection read FJuncao write SetJuncao;
    property Condicao: TCondicaoCollection read FCondicao write SetCondicao;
    property OrderBy: TColunaCollection read FOrderBy write SetOrderBy;
    property GroupBy: TColunaCollection read FGroupBy write SetGroupBy;
    property LimitarRegistros: integer read FLimitarRegistros write SetLimitarRegistros;
    property SaltarRegistros: integer read FSaltarRegistros write SetSaltarRegistros;
    property SQLTexto: TStrings read FSQLTexto write SetSQLTexto;
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
  FGroupBy := TColunaCollection.Create(Self);
  FOtimizarPara := opPadraoSQL3;
  FSQLTexto := TStringList.Create;
end;

destructor TMCSelect.Destroy;
begin
  FCondicao.Clear;
  FJuncao.Clear;
  FColuna.Clear;
  FOrderBy.Clear;
  FGroupBy.Clear;
  FSQLTexto.Clear;

  FreeAndNil(FCondicao);
  FreeAndNil(FJuncao);
  FreeAndNil(FColuna);
  FreeAndNil(FFrom);
  FreeAndNil(FOrderBy);
  FreeAndNil(FGroupBy);
  FreeAndNil(FSQLTexto);
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

procedure TMCSelect.SetGroupBy(const Value: TColunaCollection);
begin
  FGroupBy := Value;
end;

procedure TMCSelect.SetInjetarSQLAntes(const Value: string);
begin
  FInjetarSQLAntes := Value;
end;

procedure TMCSelect.SetInjetarSQLApos(const Value: string);
begin
  FInjetarSQLApos := Value;
end;

procedure TMCSelect.SetJuncao(const Value: TJuncaoCollection);
begin
  FJuncao := Value;
end;

procedure TMCSelect.SetLimitarRegistros(const Value: integer);
begin
  FLimitarRegistros := Value;
end;

procedure TMCSelect.SetOrderBy(const Value: TColunaCollection);
begin
  FOrderBy := Value;
end;

procedure TMCSelect.SetOtimizarPara(const Value: TOtimizarPara);
begin
  FOtimizarPara := Value;
end;

procedure TMCSelect.SetSaltarRegistros(const Value: integer);
begin
  FSaltarRegistros := Value;
end;

procedure TMCSelect.SetSQLTexto(const Value: TStrings);
begin
  FSQLTexto.Clear;
  FSQLTexto.Assign(Value);
end;

end.
