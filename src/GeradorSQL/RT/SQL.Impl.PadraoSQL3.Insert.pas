unit SQL.Impl.PadraoSQL3.Insert;

interface

uses
  System.SysUtils,
  SQL.Impl.SQL,
  SQL.Intf.Select,
  SQL.Intf.ParColunaValor,
  SQL.Impl.ParColunaValor.Lista,
  SQL.Intf.Tabela,
  SQL.Intf.Insert;

type
  TSQL3Insert = class(TSQL, ISQLInsert)
  private
    FParColunaValor: TListaParColunaValor;
    FSelectInsert: ISQLSelect;
    FTabela: ISQLTabela;
  protected
    procedure ConstruirValues(var SQL: TStringBuilder);
    procedure ConstruirSQL; override;
  public
    constructor Create; override;
    class function New: ISQLInsert; reintroduce;
    destructor Destroy; override;
    function addParColunaValor(const AParColunaValor: ISQLParColunaValor): ISQLInsert;
    function setSelectInsert(const ASelect: ISQLSelect): ISQLInsert;
    function setTabela(const ATabela: ISQLTabela): ISQLInsert;
  end;

implementation

uses
  SQL.Exceptions,
  SQL.Mensagens;

{ TSQL3Insert }

function TSQL3Insert.addParColunaValor(const AParColunaValor: ISQLParColunaValor): ISQLInsert;
begin
  Result := Self;

  FParColunaValor.Add(AParColunaValor);
end;

procedure TSQL3Insert.ConstruirSQL;
var
  _sql: TStringBuilder;
begin
  FTexto := '';

  if FParColunaValor.Count <= 0 then
    exit;

  if not Assigned(FTabela) then
    raise ESQLInsert.CreateFmt(OBJETO_VAZIO, ['Tabela']);

  _sql := TStringBuilder.Create;
  try
    _sql
      .Append('insert into ')
      .Append(FTabela.ToString)
      .Append('(')
      .Append(FParColunaValor.ColunaToString)
      .Append(')');

    ConstruirValues(_sql);

    FTexto := _sql.ToString;
  finally
    _sql.Free;
  end;
end;

procedure TSQL3Insert.ConstruirValues(var SQL: TStringBuilder);
begin
  if Assigned(FSelectInsert) then
  begin
    SQL.Append(FSelectInsert.ToString);
    exit;
  end;

  SQL
    .Append(' values (')
    .Append(FParColunaValor.ValorToString)
    .Append(')');
end;

constructor TSQL3Insert.Create();
begin
  inherited;
  FParColunaValor := TListaParColunaValor.Create;
end;

destructor TSQL3Insert.Destroy;
begin
  FParColunaValor.Clear;
  FreeAndNil(FParColunaValor);
  inherited;
end;

class function TSQL3Insert.New: ISQLInsert;
begin

end;

function TSQL3Insert.setSelectInsert(const ASelect: ISQLSelect): ISQLInsert;
begin
  Result := Self;
  FSelectInsert := ASelect;
end;

function TSQL3Insert.setTabela(const ATabela: ISQLTabela): ISQLInsert;
begin
  Result := Self;
  FTabela := ATabela;
end;

end.
