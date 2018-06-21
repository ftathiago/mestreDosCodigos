unit DDD.Core.Impl.Agregado;

interface

uses
  DDD.Core.Intf.Agregado, DDD.Core.Intf.Entidade, DDD.Core.Intf.ID,
  Data.DB, FireDac.Comp.Client;

type
  TAgregado<T: IEntidade> = class(TFDMemTable, IAgregado<T>)
  private
    FRegistroAtual: T;
  protected
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    procedure CarregarDadosNaEntidade(const AEntidade: T);
  public
    procedure Apagar(const AEntidade: T); virtual; abstract;
    procedure Incluir(const AEntidade: T); virtual; abstract;
    function Localizar(const AID: IID): T; virtual; abstract;
    function NovoID: IID; virtual; abstract;
    function RegistroAtual: T;
  end;

implementation

procedure TAgregado<T>.CarregarDadosNaEntidade(const AEntidade: T);
begin
  if IsEmpty then
    Exit;
end;

procedure TAgregado<T>.DataEvent(Event: TDataEvent; Info: NativeInt);
begin
  inherited;
  if Event in [deCheckBrowseMode, deParentScroll, deDisabledStateChange] then
    Initialize(FRegistroAtual);
end;

function TAgregado<T>.RegistroAtual: T;
begin
  if Not Assigned(FRegistroAtual) then
    CarregarDadosNaEntidade(FRegistroAtual);
end;

end.
