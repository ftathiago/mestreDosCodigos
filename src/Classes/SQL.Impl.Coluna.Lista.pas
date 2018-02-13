unit SQL.Impl.Coluna.Lista;

interface

uses
  System.Generics.Collections,
  SQL.Intf.Coluna;

type
  TListaColunaSelect = class(TList<ISQLColuna>)
    function ToString: string; override;
  end;

implementation

uses
  System.SysUtils;

{ TListaColunaSelect }

function TListaColunaSelect.ToString: string;
const
  sSEPARADOR = ', ';
var
  _coluna: ISQLColuna;
  _colunas: TStringBuilder;
begin
  result := '';

  if Count = 0 then
    exit;

  _colunas := TStringBuilder.Create;
  try
    for _coluna in Self do
      _colunas
        .Append(sSEPARADOR)
        .AppendLine(_coluna.ToString);
    _colunas.Remove(0, sSEPARADOR.Length);

    result := _colunas.ToString;
  finally
    _colunas.Free;
  end;
end;

end.
