unit DDD.Core.Impl.Agregado;

interface

uses
  FireDac.Comp.Client,
  Data.DB,
  DDD.Core.Intf.Entidade, DDD.Core.Intf.Agregado, DDD.Core.Intf.ID;

type
  TAgregado<T: IEntidade> = class(TFDMemTable, IAgregado<T>)
  private
    FRegistroAtual: T;
  protected
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    procedure CarregarDadosNaEntidade(var AEntidade: T);
    procedure CriarEntidade(var AEntidade: T); virtual; abstract;
  public
    procedure AfterConstruction; override;
    procedure Apagar(const AID: IID); virtual;
    procedure Incluir(const AEntidade: T); virtual;
    function Localizar(const AID: IID): T; virtual;
    function NovoID: IID; virtual; abstract;
    function RegistroAtual: T;
  end;

implementation

uses
  pkgUtils.Intf.DataSetPropriedadesTemporarias, pkgUtils.Impl.FDDataSetPropriedadesTemporarias,
  DDD.Modulo.Impl.Adaptador.DataSetEntidade, DDD.Modulo.Impl.Adaptador.EntidadeDataSet,
  DDD.Modulo.Intf.Adaptador;

procedure TAgregado<T>.AfterConstruction;
begin
  inherited;
  LogChanges := True;
end;

procedure TAgregado<T>.Apagar(const AID: IID);
var
  _fdPropTemp: IDataSetPropriedadesTemporarias;
begin
  inherited;
  _fdPropTemp := TFDDataSetPropriedadesTemporarias.New(Self);
  Self.IndexFieldNames := 'ID';
  if not Self.FindKey([AID.Valor]) then
    exit;
  Self.Delete;
end;

procedure TAgregado<T>.CarregarDadosNaEntidade(var AEntidade: T);
var
  _adaptador: IAdaptador;
begin
  if IsEmpty then
    exit;

  CriarEntidade(AEntidade);

  _adaptador := TAdaptadorDataSetEntidade<T>.New(Self, AEntidade);
  _adaptador.Adaptar;
end;

procedure TAgregado<T>.DataEvent(Event: TDataEvent; Info: NativeInt);
begin
  inherited;
  if Event in [deCheckBrowseMode, deParentScroll, deDisabledStateChange] then
    Initialize(FRegistroAtual);
end;

procedure TAgregado<T>.Incluir(const AEntidade: T);
var
  _adaptador: IAdaptador;
begin
  _adaptador := TAdaptadorEntidadeDataSet<T>.New(Self, AEntidade);
  _adaptador.Adaptar;
end;

function TAgregado<T>.Localizar(const AID: IID): T;
var
  _dataSetPropriedadeTemp: IDataSetPropriedadesTemporarias;
begin
  result := nil;
  _dataSetPropriedadeTemp := TFDDataSetPropriedadesTemporarias.New(Self);
  Self.IndexFieldNames := 'ID';
  if Self.FindKey([AID.Valor]) then
    result := Self.RegistroAtual
end;

function TAgregado<T>.RegistroAtual: T;
begin
  if IsEmpty then
  begin
    FRegistroAtual := nil;
    exit;
  end;

  if not Assigned(FRegistroAtual) then
    CarregarDadosNaEntidade(FRegistroAtual);
  result := FRegistroAtual;
end;

end.
