unit pkgUtils.Impl.Nullable;

interface

uses
  System.Types, System.Generics.Defaults, System.SysUtils;

type
  Nullable<T> = record
  private
    FValue: T;
    FHasValue: IInterface;
    function GetValue: T;
    function GetHasValue: boolean;
  public
    constructor Create(AValue: T);
    function GetValueOrDefault: T; overload;
    function GetValueOrDefault(Default: T): T; overload;
    property HasValue: boolean read GetHasValue;
    property Value: T read GetValue;
    class operator Implicit(Value: Nullable<T>): T;
    class operator Implicit(Value: T): Nullable<T>;
    class operator GreaterThan(aLeft, aRight: Nullable<T>): boolean;
    class operator GreaterThanOrEqual(aLeft, aRight: Nullable<T>): boolean;
    class operator LessThan(aLeft, aRight: Nullable<T>):boolean;
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
  FValue := AValue;
  SetFlagInterface(FHasValue);
end;

class operator Nullable<T>.Equal(aLeft, aRight: Nullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if aLeft.HasValue and aRight.HasValue then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := Comparer.Equals(aLeft.Value, aRight.Value);
  end
  else
    Result := aLeft.HasValue = aRight.HasValue;
end;

function Nullable<T>.GetHasValue: boolean;
begin
  Result := FHasValue <> nil;
end;

function Nullable<T>.GetValue: T;
begin
  if not HasValue then
    raise Exception.Create('Invalid operation, Nullable type has no value');
  Result := FValue;
end;

function Nullable<T>.GetValueOrDefault: T;
begin
  if HasValue then
    Result := FValue
  else
    Result := Default (T);
end;

function Nullable<T>.GetValueOrDefault(Default: T): T;
begin
  if not HasValue then
    Result := Default
  else
    Result := FValue;
end;

class operator Nullable<T>.GreaterThan(aLeft, aRight: Nullable<T>): boolean;
var
  _comparer: IComparer<T>;
  _relacao: TValueRelationship;
begin
  if not aLeft.HasValue then
    Exit(False);

  if not aRight.HasValue then
    Exit(True);

  _comparer := TComparer<T>.Default;
  _relacao := TValueRelationship(_comparer.Compare(aLeft, aRight));
  result := _relacao = GreaterThanValue;
end;

class operator Nullable<T>.GreaterThanOrEqual(aLeft, aRight: Nullable<T>): boolean;
var
  _comparer: IComparer<T>;
  _relacao: TValueRelationship;
begin
  if (not aLeft.HasValue) and (not aRight.HasValue) then
    Exit(True);
  _comparer := TComparer<T>.Default;
  _relacao := TValueRelationship(_comparer.Compare(aLeft, aRight));
  Result := _relacao in [EqualsValue, GreaterThanValue];
end;

class operator Nullable<T>.Implicit(Value: Nullable<T>): T;
begin
  Result := Value.Value;
end;

class operator Nullable<T>.Implicit(Value: T): Nullable<T>;
begin
  Result := Nullable<T>.Create(Value);
end;

class operator Nullable<T>.LessThan(aLeft, aRight: Nullable<T>): boolean;
begin

end;

class operator Nullable<T>.NotEqual(const aLeft, aRight: Nullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if aLeft.HasValue and aRight.HasValue then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := not Comparer.Equals(aLeft.Value, aRight.Value);
  end
  else
    Result := aLeft.HasValue <> aRight.HasValue;
end;

end.
