unit DDD.Modulo.Impl.IDFactory;

interface

uses
  System.Rtti, DDD.Core.Intf.ID, DDD.Modulo.Intf.IDFactory;

type
  TIDFactory = class(TInterfacedObject, IIDFactory)
  private
    FTipoID: TTipoId;
    function PegarMetodoNew: TRttiMethod;
  public
    class function New(const ATipoFabrica: TTipoId): IIDFactory;
    constructor Create(const ATipoFabrica: TTipoId);
    function InicializarID(const AValor: integer): IID;
    function NovoID: IID;
  end;

implementation

uses
  pkgUtils.Impl.RTTIUtils, DDD.Core.Impl.IDRandomico;

constructor TIDFactory.Create(const ATipoFabrica: TTipoId);
begin
  FTipoID := ATipoFabrica;
end;

function TIDFactory.InicializarID(const AValor: integer): IID;
var
  _objetoInstanciado: TValue;
  _parametro: TValue;
begin
  result := nil;

  _parametro := TValue.From<integer>(AValor);
  _objetoInstanciado := PegarMetodoNew.Invoke(FTipoID.PegarClasseID, [_parametro]);

  if not _objetoInstanciado.IsEmpty then
    result := PegarMetodoNew.Invoke(FTipoID.PegarClasseID, [_parametro]).AsInterface as IID;
end;

class function TIDFactory.New(const ATipoFabrica: TTipoId): IIDFactory;
begin
  result := Create(ATipoFabrica);
end;

function TIDFactory.NovoID: IID;
begin
  result := InicializarID(-1);
end;

function TIDFactory.PegarMetodoNew: TRttiMethod;
var
  _tipo: TRttiType;
  _metodoNew: TRttiMethod;
begin
  _tipo := RTTIUtils.getRttiType(FTipoID.PegarClasseID.QualifiedClassName);

  _metodoNew := _tipo.GetMethod('New');

  if not Assigned(_metodoNew) then
    raise ERttiUtils.CreateFmt('O método NEW não foi implementado na classe [%s]',
      [FTipoID.PegarClasseID.QualifiedClassName]);
  result := _metodoNew;
end;

end.
