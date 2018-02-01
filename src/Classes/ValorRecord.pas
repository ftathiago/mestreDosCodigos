unit ValorRecord;

interface

uses
  Controls, Classes, SysUtils, TypInfo;

type

  TTiposSuportados = (tsUnknow, tsString, tsInteger, tsCurrency, tsDouble,
    tsDateTime, tsDate, tsTime);

  { TValor }

  TValor = record
    Tipo: TTiposSuportados;
    Texto: string;
    Inteiro: integer;
    Monetario: currency;
    Fracionado: double;
    DataHora: TDateTime;
    Data: TDate;
    Hora: TTime;
{
    function isEmpty(Zero: boolean = True; StrEmpty: boolean = True): boolean;
    procedure Clear();
    function AsString(): string;
}
  end;


operator := (Texto: string) valor: TValor;
operator := (Inteiro: integer) valor: TValor;
operator := (Monetario: currency) valor: TValor;
operator := (Fracionado: double) valor: TValor;
operator := (DataHora: TDateTime) valor: TValor;
operator := (Data: TDate) valor: TValor;
operator := (Hora: TTime) valor: TValor;



implementation

uses DateTimeHelper;

operator := (Texto: string)valor: TValor;
begin
  valor.Clear();
  valor.tipo := tsString;
  valor.Texto := Texto;
end;

operator := (Inteiro: integer)valor: TValor;
begin
  valor.Clear();
  valor.tipo := tsInteger;
  valor.Inteiro := Inteiro;
end;

operator := (Monetario: currency)valor: TValor;
begin
  valor.Clear();
  valor.tipo := tsCurrency;
  valor.Monetario := Monetario;
end;

operator := (Fracionado: double)valor: TValor;
begin
  valor.Clear();
  valor.tipo := tsDouble;
  valor.Fracionado := Fracionado;
end;

operator := (DataHora: TDateTime)valor: TValor;
begin
  valor.Clear();
  valor.tipo := tsDateTime;
  valor.DataHora := DataHora;
end;

operator := (Data: TDate)valor: TValor;
begin
  valor.Clear();
  valor.tipo := tsDate;
  valor.Data := Data;
end;

operator := (Hora: TTime)valor: TValor;
begin
  valor.Clear();
  valor.tipo := tsTime;
  valor.Hora := Hora;
end;

{ TValor }

function TValor.isEmpty(Zero: boolean; StrEmpty: boolean): boolean;
begin
  Result :=
    (Texto.Trim.IsEmpty() and StrEmpty) and (Zero and (Inteiro = 0) and
    (Monetario = 0) and (Fracionado = 0) and (DataHora = 0) and
    (Data = 0) and (Hora = 0));
end;

procedure TValor.Clear();
begin
  Tipo := tsUnknow;
  Texto := '';
  Inteiro := 0;
  Monetario := 0;
  Fracionado := 0;
  DataHora := 0;
  Data := 0;
  Hora := 0;
end;

function TValor.AsString(): string;
begin
  case Tipo of
    tsString: Result := Texto;
    tsInteger: Result := Inteiro.ToString();
    tsCurrency: Result := CurrToStr(Monetario);
    tsDouble: Result := Self.Fracionado.ToString();
    tsDateTime: Result := Self.DataHora.ToString('dd/mm/yyyy hh:nn:ss.zzzz');
    tsDate: Result := TDateTime(Data).ToString(FormatSettings.ShortDateFormat);
    tsTime: Result := TDateTime(Hora).ToString(FormatSettings.ShortTimeFormat);
  end;
end;

end.