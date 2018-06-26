unit DDD.Core.Impl.IDRandomico;

interface

uses
  DDD.Core.Intf.ID;

type
  TIDRandomico = class(TInterfacedObject, IID)
    FValor: Integer;
  public
    class function New(const AValor: integer = -1): IID;
    constructor Create(const AValor: integer = -1);
    function Valor: Integer;
  end;

implementation

uses
  System.SysUtils;

constructor TIDRandomico.Create(const AValor: integer = -1);
begin
  FValor := AValor;
  if AValor = -1 then
    FValor := Random(Integer.MaxValue);
end;

class function TIDRandomico.New(const AValor: integer = -1): IID;
begin
  result := Create(AValor);
end;

function TIDRandomico.Valor: Integer;
begin
  result := FValor;
end;

initialization

Randomize;

end.
