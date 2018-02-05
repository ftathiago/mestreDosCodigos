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
begin
  result := '';

  if Count <= 0 then
    exit;

  _primeiroOperadorLogico := Self.First.getOperadorLogico;

  _resultSet := TStringBuilder.Create;
  try
    for _condicao in Self do
    begin
      _resultSet
        .Append(_condicao.getOperadorLogico.getSQLString)
        .Append(' ')
        .Append(_condicao.ToString);
    end;

    _resultSet.Remove(0, _primeiroOperadorLogico.getSQLString.Length + 1);

    result := _resultSet.ToString;
  finally
    _resultSet.Free;
  end;
end;

end.
