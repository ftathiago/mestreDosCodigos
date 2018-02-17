unit SQL.Impl.ParColunaValor;

interface

uses
  SQL.Intf.SQL,
  SQL.Intf.ParColunaValor,
  SQL.Intf.Coluna,
  SQL.Impl.SQL;

type
  TSQLParColunaValor = class(TSQL, ISQLParColunaValor)
  private
    FColuna: ISQLColuna;
    FTexto: string;
  public
    class function New: ISQLParColunaValor; reintroduce;
    function setColuna(const AColuna: ISQLColuna): ISQLParColunaValor;
    function setValor(const SQL: ISQL): ISQLParColunaValor; overload;
    function setValor(const Texto: string): ISQLParColunaValor; overload;
    function getColuna: ISQLColuna;
    function getValor: string;
  end;

implementation

{ TSQLParColunaValor }

function TSQLParColunaValor.getColuna: ISQLColuna;
begin
  result := FColuna;
end;

function TSQLParColunaValor.getValor: string;
begin
  result := FTexto;
end;

class function TSQLParColunaValor.New: ISQLParColunaValor;
begin
  result := Create;
end;

function TSQLParColunaValor.setColuna(const AColuna: ISQLColuna): ISQLParColunaValor;
begin
  FColuna := AColuna;
end;

function TSQLParColunaValor.setValor(const Texto: string): ISQLParColunaValor;
begin
  FTexto := Texto;
end;

function TSQLParColunaValor.setValor(const SQL: ISQL): ISQLParColunaValor;
begin
  FTexto := SQL.ToString;
end;

end.
