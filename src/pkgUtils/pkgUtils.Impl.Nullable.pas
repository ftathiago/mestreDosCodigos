unit pkgUtils.Impl.Nullable;

interface

uses
  System.Types, System.Generics.Defaults, System.SysUtils;

type
  Nullable<T> = record
  private
    FValor: T;
    FTemValor: IInterface;
    function PegarValor: T;
    function TestarTemValor: boolean;
  public
    constructor Create(AValue: T);
    function PegarValorOuPadrao: T; overload;
    function PegarValorOuPadrao(Default: T): T; overload;
    procedure Limpar;
    property TemValor: boolean read TestarTemValor;
    property Valor: T read PegarValor;
    class operator Implicit(Value: Nullable<T>): T;
    class operator Implicit(Value: T): Nullable<T>;
    class operator GreaterThan(aLeft, aRight: Nullable<T>): boolean;
    class operator GreaterThanOrEqual(aLeft, aRight: Nullable<T>): boolean;
    class operator LessThan(aLeft, aRight: Nullable<T>): boolean;
    class operator LessThanOrEqual(aLeft, aRight: Nullable<T>): boolean;
    class operator NotEqual(const aLeft, aRight: Nullable<T>): boolean;
    class operator Equal(aLeft, aRight: Nullable<T>): boolean;
  end;

procedure SetFlagInterface(var Intf: IInterface);

implementation

function NopAddref(inst: Pointer): Integer; stdcall;
begin
  Result := -1;
end;

function NopRelease(inst: Pointer): Integer; stdcall;
begin
  Result := -1;
end;

function NopQueryInterface(inst: Pointer; const IID: TGUID; out Obj): HResult; stdcall;
begin
  Result := E_NOINTERFACE;
end;

const
  FlagInterfaceVTable: array [0 .. 2] of Pointer = (@NopQueryInterface, @NopAddref, @NopRelease);

  FlagInterfaceInstance: Pointer = @FlagInterfaceVTable;

procedure SetFlagInterface(var Intf: IInterface);
begin
  Intf := IInterface(@FlagInterfaceInstance);
end;

{ Nullable<T> }

constructor Nullable<T>.Create(AValue: T);
begin
  FValor := AValue;
  SetFlagInterface(FTemValor);
end;

class operator Nullable<T>.Equal(aLeft, aRight: Nullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if aLeft.TemValor and aRight.TemValor then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := Comparer.Equals(aLeft.Valor, aRight.Valor);
  end
  else
    Result := aLeft.TemValor = aRight.TemValor;
end;

function Nullable<T>.TestarTemValor: boolean;
begin
  Result := FTemValor <> nil;
end;

function Nullable<T>.PegarValor: T;
begin
  if not TestarTemValor then
    exit;
  Result := FValor;
end;

function Nullable<T>.PegarValorOuPadrao: T;
begin
  if TemValor then
    Result := FValor
  else
    Result := Default (T);
end;

function Nullable<T>.PegarValorOuPadrao(Default: T): T;
begin
  if not TemValor then
    Result := Default
  else
    Result := FValor;
end;

class operator Nullable<T>.GreaterThan(aLeft, aRight: Nullable<T>): boolean;
var
  _comparer: IComparer<T>;
  _relacao: TValueRelationship;
begin
  if not aLeft.TemValor then
    Exit(False);

  if not aRight.TemValor then
    Exit(True);

  _comparer := TComparer<T>.Default;
  _relacao := TValueRelationship(_comparer.Compare(aLeft, aRight));
  result := _relacao > EqualsValue;
end;

class operator Nullable<T>.GreaterThanOrEqual(aLeft, aRight: Nullable<T>): boolean;
var
  _comparer: IComparer<T>;
  _relacao: TValueRelationship;
begin
  if (not aLeft.TemValor) and (not aRight.TemValor) then
    Exit(True);
  _comparer := TComparer<T>.Default;
  _relacao := TValueRelationship(_comparer.Compare(aLeft, aRight));
  Result := _relacao >= 0;
end;

class operator Nullable<T>.Implicit(Value: Nullable<T>): T;
begin
  Result := Value.Valor;
end;

class operator Nullable<T>.Implicit(Value: T): Nullable<T>;
begin
  Result := Nullable<T>.Create(Value);
end;

class operator Nullable<T>.LessThan(aLeft, aRight: Nullable<T>): boolean;
var
  _comparer: IComparer<T>;
  _relacao: TValueRelationship;
begin
  _comparer := TComparer<T>.Default;
  _relacao := TValueRelationship(_comparer.Compare(aLeft, aRight));
  Result := _relacao = LessThanValue;
end;

class operator Nullable<T>.LessThanOrEqual(aLeft, aRight: Nullable<T>): boolean;
var
  _comparer: IComparer<T>;
  _relacao: TValueRelationship;
begin
  result := False;

  if (not aLeft.TemValor) and (not aRight.TemValor) then
    Exit(True);

  _comparer := TComparer<T>.Default;
  _relacao := TValueRelationship(_comparer.Compare(aLeft, aRight));
  result := _relacao <= 0;
end;

procedure Nullable<T>.Limpar;
begin
  FTemValor := nil;
  Finalize(FValor);
end;

class operator Nullable<T>.NotEqual(const aLeft, aRight: Nullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if aLeft.TemValor and aRight.TemValor then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := not Comparer.Equals(aLeft.Valor, aRight.Valor);
  end
  else
    Result := aLeft.TemValor <> aRight.TemValor;
end;

end.
