unit SQL.Impl.Juncao.Lista;

interface

uses
  System.Generics.Collections,
  SQL.Intf.Juncao;

type
  TListaJuncao = class(TList<ISQLJuncao>)
    function ToString: string; override;
  end;

implementation

uses
  System.SysUtils;

{ TListaJuncao }

function TListaJuncao.ToString: string;
var
  _juncoes: TStringBuilder;
  _juncao: ISQLJuncao;
begin
  result := '';

  if Count = 0 then
    exit;

  _juncoes := TStringBuilder.Create;
  try
    for _juncao in Self do
      _juncoes.AppendLine(_juncao.ToString);

    result := _juncoes.ToString;
  finally
    FreeAndNil(_juncoes);
  end;
end;

end.
