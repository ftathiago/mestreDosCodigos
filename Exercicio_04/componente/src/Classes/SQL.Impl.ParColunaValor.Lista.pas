unit SQL.Impl.ParColunaValor.Lista;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  SQL.Intf.ParColunaValor;

type
  TListaParColunaValor = class(TList<ISQLParColunaValor>)
  private
    procedure RemoverSeparadorPadrao(var SQL: TStringBuilder);
  public
    function ToString: string; override;
    function ValorToString: string;
    function ColunaToString: string;
  end;

implementation

const
  SEPARADOR_DE_COLUNAS = ' , ';

  { TListaParColunaValor }

function TListaParColunaValor.ColunaToString: string;
var
  i: Integer;
  _sql: TStringBuilder;
begin
  result := '';

  if Self.Count <= 0 then
    exit;

  _sql := TStringBuilder.Create;
  try
    for i := 0 to Pred(Self.Count) do
      _sql
        .Append(SEPARADOR_DE_COLUNAS)
        .Append(Items[i].getColuna.ToString);

    RemoverSeparadorPadrao(_sql);

    result := _sql.ToString;
  finally
    _sql.Free;
  end;
end;

procedure TListaParColunaValor.RemoverSeparadorPadrao(var SQL: TStringBuilder);
begin
  SQL.Remove(0, SEPARADOR_DE_COLUNAS.Length);
end;

function TListaParColunaValor.ToString: string;
var
  i: Integer;
  _sql: TStringBuilder;
begin
  result := '';

  if Self.Count <= 0 then
    exit;

  _sql := TStringBuilder.Create;
  try
    for i := 0 to Pred(Self.Count) do
    begin
      _sql
        .Append(SEPARADOR_DE_COLUNAS)
        .Append(Items[i].getColuna.ToString);

      if Items[i].getValor.trim.IsEmpty then
        Continue;

      _sql
        .Append(' = ')
        .Append(Items[i].getValor);
    end;

    RemoverSeparadorPadrao(_sql);

    result := _sql.ToString;
  finally
    _sql.Free;
  end;
end;

function TListaParColunaValor.ValorToString: string;
var
  i: Integer;
  _sql: TStringBuilder;
begin
  result := '';

  if Self.Count <= 0 then
    exit;

  _sql := TStringBuilder.Create;
  try
    for i := 0 to Pred(Self.Count) do
      _sql
        .Append(SEPARADOR_DE_COLUNAS)
        .Append(Items[i].getValor);

    RemoverSeparadorPadrao(_sql);

    result := _sql.ToString;
  finally
    _sql.Free;
  end;
end;

end.
