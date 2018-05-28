unit DataSet.Proxy.DataSource.DataStateChange;

interface

uses
  System.Classes,
  Data.DB;

type
  TDataStateChangeProxy = class
    FDataSource: TDataSource;
    FOriginal: TNotifyEvent;
    FEventoProxy: TNotifyEvent;
    procedure Disparar(Sender: TObject);
  public
    constructor Create(ADataSource: TDataSource; ANovoStateChange: TNotifyEvent);
    destructor Destroy; override;
  end;

implementation

type
  TDataSourceProxy = class(TDataSource);

constructor TDataStateChangeProxy.Create(ADataSource: TDataSource; ANovoStateChange: TNotifyEvent);
begin
  FDataSource := ADataSource;
  FOriginal := TDataSourceProxy(FDataSource).OnStateChange;
  FEventoProxy := ANovoStateChange;
  TDataSourceProxy(FDataSource).OnStateChange := Disparar;
end;

destructor TDataStateChangeProxy.Destroy;
begin
  TDataSourceProxy(FDataSource).OnStateChange := FOriginal;
  inherited;
end;

procedure TDataStateChangeProxy.Disparar(Sender: TObject);
begin
  if Assigned(FOriginal) then
    FOriginal(Sender);
  if Assigned(FEventoProxy) then
    FEventoProxy(Sender);
end;

end.
