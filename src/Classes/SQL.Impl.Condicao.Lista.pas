unit SQL.Impl.Condicao.Lista;

interface

uses
  System.Generics.Collections,
  SQL.Intf.Condicao;

type
  TListaCondicao = class(TList<ISQLCondicao>)
  public
    function ToString: string; override;
  end;

implementation

uses
  System.TypInfo,
  System.SysUtils,
  SQL.Enums,
  SQL.Mensagens;

{ TListaCondicoes }

function TListaCondicao.ToString: string;
var
  _condicao: ISQLCondicao;
  _resultSet: TStringBuilder;
  _primeiroOperadorLogico: TOperadorLogico;
  i: integer;
begin
  result := '';

  if Count <= 0 then
    exit;

  _primeiroOperadorLogico := Self.First.getOperadorLogico;

  _resultSet := TStringBuilder.Create;
  try
    for i := 0 to Pred(Count) do
    begin
      _condicao := Items[i];
      _resultSet
        .Append(_condicao.getOperadorLogico.getSQLString)
        .Append(' ')
        .AppendLine(_condicao.ToString);
    end;

    _resultSet.Remove(0, _primeiroOperadorLogico.getSQLString.Length + 1);

    result := _resultSet.ToString.Trim;
  finally
    _resultSet.Free;
  end;
end;

end.
