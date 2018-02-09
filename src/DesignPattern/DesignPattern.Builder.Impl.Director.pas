unit DesignPattern.Builder.Impl.Director;

interface

uses
  DesignPattern.Builder.Intf.Director;

type
  TDirector<T, R> = class(TInterfacedObject, IDirector<T, R>)
  protected
    FObjeto: R;
    FBuilder: T;
  public
    class function New: IDirector<T, R>;
    procedure setBuilder(const ABuilder: T);
    procedure Construir; virtual; abstract;
    function getObjetoPronto: R;
  end;

implementation

{ TDirector<T, R> }

function TDirector<T, R>.getObjetoPronto: R;
begin
  Result := FObjeto;
end;

class function TDirector<T, R>.New: IDirector<T, R>;
begin
  Result := Create;
end;

procedure TDirector<T, R>.setBuilder(const ABuilder: T);
begin
  FBuilder := ABuilder;
end;

end.
