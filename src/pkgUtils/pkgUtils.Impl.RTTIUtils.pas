unit pkgUtils.Impl.RTTIUtils;

interface

uses System.JSON, System.Rtti, System.SysUtils, Data.DB, Vcl.dialogs;

type
  ERttiUtils = class(Exception);

  RttiUtils = class
  private
    class var _ctx: TRttiContext;
    class function ctx: TRttiContext;
  public
    class function TValueNumericIsEmpty(AValue: TValue; ZeroIsEmpty: boolean = True): boolean;
    class function TValueStringIsEmpty(AValue: TValue): boolean;
    class function getType(Kind: TTypeKind): string; overload;
    class function getType(const Value: Variant): string; overload;
    class function getInstanceType(AQualifiedClassName: string): TRttiInstanceType;
    class function getRttiType(AQualifiedClassname: string): TRttiType;
    class function CreateObject(AQualifiedClassName: string): TObject; overload;
    class function CreateObject(ARttiType: TRttiType): TObject; overload;
    class function getProperty(Instance: TObject; PropertyName: string): TRttiProperty;
    class function getObjectProperty(Instance: TObject; PropertyName: string): TObject;
    class function getIndexedProperty(Instance: TObject; PropertyName: string): TRttiIndexedProperty;
    class function getProperties(Instance: TObject): TArray<TRttiProperty>;
    class function getMethod(Instance: TObject; MethodName: string): TRttiMethod;
    class function ForceGetPropValue(var Instance: TObject; const PropName: string): TValue;
    class procedure ForceSetPropValue(var Instance: TObject; const PropName: string; const Value: TValue);
    class procedure FieldToValue(AField: TField; Instance: TObject; APropertyName: string);
    class procedure setValue(AValue: TValue; Instance: TObject; var AProperty: TRttiProperty);
  end;

implementation

uses Winapi.Windows, System.Classes, System.Variants, System.Generics.Collections, System.TypInfo, System.DateUtils, Vcl.Forms;

{ TRttiUtils }

class function RttiUtils.CreateObject(AQualifiedClassName: string): TObject;
var
  RttiType: TRttiType;
begin
  RttiType := RttiUtils.ctx.FindType(AQualifiedClassName);
  if Assigned(RttiType) then
    Result := CreateObject(RttiType)
  else
    Result := nil;
end;

class function RttiUtils.CreateObject(ARttiType: TRttiType): TObject;
var
  Method: TRttiMethod;
  metaClass: TClass;
begin
  { First solution, clear and slow }
  metaClass := nil;
  Method := nil;
  for Method in ARttiType.GetMethods do
    if Method.HasExtendedInfo and Method.IsConstructor then
      if Length(Method.GetParameters) = 0 then
      begin
        metaClass := ARttiType.AsInstance.MetaclassType;
        Break;
      end;
  if Assigned(metaClass) then
    Result := Method.Invoke(metaClass, []).AsObject
  else
    raise Exception.Create('Cannot find a propert constructor for ' +
        ARttiType.ToString);

  { Second solution, dirty and fast }
  // Result := TObject(ARttiType.GetMethod('Create')
  // .Invoke(ARttiType.AsInstance.MetaclassType, []).AsObject);
end;

class function RttiUtils.ctx: TRttiContext;
begin
  Result := RttiUtils._ctx;
end;

class procedure RttiUtils.FieldToValue(AField: TField; Instance: TObject; APropertyName: string);
var
  _Property: TRttiProperty;
begin
  if AField.IsNull then
  begin
    RttiUtils.ForceSetPropValue(Instance, APropertyName, TValue.FromVariant(Null));
  end
  else
  begin
    _Property := RttiUtils.getProperty(Instance, APropertyName);
    case _Property.PropertyType.TypeKind of
      tkString, tkUString:
        RttiUtils.ForceSetPropValue(Instance, APropertyName, AField.AsString);
      tkInteger:
        RttiUtils.ForceSetPropValue(Instance, APropertyName, AField.AsInteger);
      tkEnumeration:
        begin
          if _Property.PropertyType.Handle^.TypeData^.BaseType^ = TypeInfo(boolean) then
          begin
            if AField.DataType = ftBoolean then
              RttiUtils.ForceSetPropValue(Instance, APropertyName, AField.AsBoolean)
            else if AField.DataType in [ftInteger, ftSmallint] then
              RttiUtils.ForceSetPropValue(Instance, APropertyName, AField.AsInteger = 1)
            else if AField.DataType in [ftString, ftWideString] then
              RttiUtils.ForceSetPropValue(Instance, APropertyName, AField.AsString.Equals('S'));
          end
          else
          begin
            if AField.DataType = ftInteger then
              RttiUtils.ForceSetPropValue(Instance, APropertyName, TValue.FromOrdinal(_Property.PropertyType.Handle, AField.AsInteger))
            else
              RttiUtils.ForceSetPropValue(Instance, APropertyName, GetEnumValue(_Property.PropertyType.Handle, AField.AsString))
          end;
        end;
      tkFloat:
        RttiUtils.ForceSetPropValue(Instance, APropertyName, AField.AsExtended);
      tkVariant:
        RttiUtils.ForceSetPropValue(Instance, APropertyName, TValue.From<Variant>(AField.Value));
      tkInt64:
        RttiUtils.ForceSetPropValue(Instance, APropertyName, AField.AsInteger);
    end;
  end;
end;

class function RttiUtils.ForceGetPropValue(var Instance: TObject;
  const PropName: string): TValue;
var
  obj: TObject;
  _nomeCampo: string;
begin
  if PropName.Contains('.') then
  begin
    _nomeCampo := PropName.Substring(0, PropName.IndexOf('.'));
    obj := System.TypInfo.GetObjectProp(Instance, _nomeCampo);
    if Assigned(obj) then
    begin
      Result :=
        RttiUtils.ForceGetPropValue(
        obj,
        PropName.Substring(PropName.IndexOf('.') + 1));
      obj := nil;
    end
    else
      raise ERttiUtils.CreateFmt('O objeto %s não foi encontrado', [_nomeCampo]);
  end
  else
    Result := RttiUtils.getProperty(Instance, PropName).GetValue(Instance);
end;

class procedure RttiUtils.ForceSetPropValue(var Instance: TObject;
  const PropName: string; const Value: TValue);
var
  obj: TObject;
  _nomeCampo: string;
  _rttiProperty: TRttiProperty;
begin
  if PropName.Contains('.') then
  begin
    _nomeCampo := PropName.Substring(0, PropName.IndexOf('.'));
    obj := RttiUtils.getObjectProperty(Instance, _nomeCampo);
    if Assigned(obj) then
    begin
      RttiUtils.ForceSetPropValue(
        obj,
        PropName.Substring(PropName.IndexOf('.') + 1),
        Value);
    end
    else
      raise ERttiUtils.CreateFmt('O objeto %s não foi encontrado', [_nomeCampo]);
  end
  else
  begin
    _rttiProperty := RttiUtils.getProperty(Instance, PropName);
    RttiUtils.setValue(Value, Instance, _rttiProperty);
    // SetPropValue(Instance,PropName,Value);
  end;
end;

class function RttiUtils.getObjectProperty(Instance: TObject;
  PropertyName: string): TObject;
var
  PropertyRTTI: TRttiProperty;
begin
  PropertyRTTI := RttiUtils.getProperty(Instance, PropertyName);
  if PropertyRTTI.PropertyType.TypeKind <> tkClass then
    raise Exception.Create('A propriedade informada não é um objeto')
  else
  begin
    Result := PropertyRTTI.GetValue(Instance).AsObject;
    if not Assigned(Result) then
      Result := RttiUtils.CreateObject(PropertyRTTI.PropertyType.QualifiedName);
  end;
end;

class function RttiUtils.getProperties(Instance: TObject): TArray<TRttiProperty>;
var
  ClassRtti: TRttiType;
begin
  ClassRtti := RttiUtils.ctx.getType(Instance.ClassInfo);
  Result := ClassRtti.getProperties;
end;

class function RttiUtils.getProperty(Instance: TObject;
  PropertyName: string): TRttiProperty;
var
  ClassRtti: TRttiType;

  obj: TObject;
  _nomeCampo: string;
begin
  if PropertyName.Contains('.') then
  begin
    _nomeCampo := PropertyName.Substring(0, PropertyName.IndexOf('.'));
    obj := RttiUtils.getObjectProperty(Instance, _nomeCampo);
    if Assigned(obj) then
    begin
      Result :=
        RttiUtils.getProperty(
        obj,
        PropertyName.Substring(PropertyName.IndexOf('.') + 1));
    end
    else
      raise ERttiUtils.CreateFmt('O objeto %s não foi encontrado', [_nomeCampo]);
  end
  else
  begin
    ClassRtti := RttiUtils.ctx.getType(Instance.ClassInfo);
    Result := ClassRtti.getProperty(PropertyName);
  end;
end;

class function RttiUtils.getRttiType(AQualifiedClassname: string): TRttiType;
begin
  Result := RttiUtils.ctx.FindType(AQualifiedClassName);
end;

class function RttiUtils.getType(const Value: Variant): string;
begin
  case TVarData(Value).VType of
    varEmpty:
      Result := 'Empty';
    varNull:
      Result := 'Null';
    varSmallInt:
      Result := 'SmallInt';
    varInteger:
      Result := 'Integer';
    varSingle:
      Result := 'Single';
    varDouble:
      Result := 'Double';
    varCurrency:
      Result := 'Currency';
    varDate:
      Result := 'Date';
    varOleStr:
      Result := 'OleStr';
    varDispatch:
      Result := 'Dispatch';
    varError:
      Result := 'Error';
    varBoolean:
      Result := 'Boolean';
    varVariant:
      Result := 'Variant';
    varUnknown:
      Result := 'Unknown';
    varByte:
      Result := 'Byte';
    varString:
      Result := 'String';
    varTypeMask:
      Result := 'TypeMask';
    varArray:
      Result := 'Array';
    varByRef:
      Result := 'ByRef';
  end;
end;

class function RttiUtils.getType(Kind: TTypeKind): string;
begin
  case Kind of
    tkUnknown:
      Result := 'string';
    tkInteger:
      Result := 'integer';
    tkChar:
      Result := 'string';
    tkEnumeration:
      Result := 'string';
    tkFloat:
      Result := 'Double';
    tkString:
      Result := 'string';
    tkSet:
      Result := 'string';
    tkClass:
      Result := 'string';
    tkMethod:
      Result := 'string';
    tkWChar:
      Result := 'string';
    tkLString:
      Result := 'string';
    tkWString:
      Result := 'string';
    tkVariant:
      Result := 'string';
    tkArray:
      Result := 'string';
    tkRecord:
      Result := 'string';
    tkInterface:
      Result := 'string';
    tkInt64:
      Result := 'Integer';
    tkDynArray:
      Result := 'string';
    tkUString:
      Result := 'string';
    tkClassRef:
      Result := 'string';
    tkPointer:
      Result := 'string';
    tkProcedure:
      Result := 'string';
  end;
end;

class procedure RttiUtils.setValue(AValue: TValue; Instance: TObject; var AProperty: TRttiProperty);
begin
  if AValue.IsEmpty then
    Exit;

  case AProperty.PropertyType.TypeKind of
    tkSet:
      begin
        raise Exception.Create('Não implementado');
      end;
    tkString, tkUString:
      begin
        case AValue.Kind of
          tkInteger:
            AProperty.setValue(Instance, AValue.AsInteger.ToString);
          tkFloat:
            AProperty.setValue(Instance, AValue.AsExtended.ToString);
        else
          AProperty.setValue(Instance, AValue.AsString);
        end;
      end;
    tkInteger:
      AProperty.setValue(Instance, AValue.AsInteger);
    tkEnumeration:
      begin
        if AProperty.PropertyType.Handle^.TypeData^.BaseType^ = TypeInfo(boolean) then
          AProperty.setValue(Instance, AValue.AsBoolean)
        else
        begin
          if AValue.TypeInfo.Kind = tkEnumeration then
            AProperty.setValue(Instance, AValue)
          else if AValue.TypeInfo.Kind = tkInteger then
            AProperty.setValue(Instance, TValue.FromOrdinal(AProperty.PropertyType.Handle, AValue.AsInteger))
          else
            AProperty.setValue(
              Instance,
              TValue.FromOrdinal(
                AProperty.PropertyType.Handle,
                GetEnumValue(
                  AProperty.PropertyType.Handle,
                  AValue.AsString
                  )
                )
              );
        end;
      end;
    tkFloat:
      AProperty.setValue(Instance, AValue.AsExtended);
    tkVariant:
      AProperty.setValue(Instance, AValue);
    tkInt64:
      AProperty.setValue(Instance, AValue.AsInt64);
  end;
end;

class function RttiUtils.TValueNumericIsEmpty(AValue: TValue; ZeroIsEmpty: boolean): boolean;
begin
  Result :=
    AValue.IsEmpty
    or AValue.ToString.Trim.IsEmpty
    or ((AValue.AsInteger = 0) and ZeroIsEmpty);
end;

class function RttiUtils.TValueStringIsEmpty(AValue: TValue): boolean;
begin
  Result :=
    AValue.IsEmpty
    or AValue.ToString.Trim.IsEmpty
    or AValue.AsString.Trim.IsEmpty;
end;

class function RttiUtils.getIndexedProperty(Instance: TObject; PropertyName: string): TRttiIndexedProperty;
var
  ClassRtti: TRttiType;
begin
  ClassRtti := RttiUtils.ctx.getType(Instance.ClassInfo);
  Result := ClassRtti.getIndexedProperty(PropertyName);
end;

class function RttiUtils.getInstanceType(AQualifiedClassName: string): TRttiInstanceType;
begin
  Result := getRttiType(AQualifiedClassName) as TRttiInstanceType;
end;

class function RttiUtils.getMethod(Instance: TObject; MethodName: string): TRttiMethod;
var
  ClassRtti: TRttiType;
begin
  ClassRtti := RttiUtils.ctx.getType(Instance.ClassInfo);
  Result := ClassRtti.getMethod(MethodName);
end;

initialization

RttiUtils._ctx := TRttiContext.Create;

finalization

RttiUtils._ctx.Free;

end.

