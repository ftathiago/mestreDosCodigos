unit DataSet.Proxy.DataSource.UpdateData;

interface

uses
  System.Classes,
  Data.DB;

type
  TUpdateDataProxy = class
    FDataSource: TDataSource;
    FOriginal: TNotifyEvent;
    FEventoProxy: TNotifyEvent;
    procedure Disparar(Sender: TObject);
  public
    constructor Create(ADataSource: TDataSource; ANovoUpdateData: TNotifyEvent);
    destructor Destroy; override;
  end;

implementation

type
  TDataSourceProxy = class(TDataSource);

constructor TUpdateDataProxy.Create(ADataSource: TDataSource; ANovoUpdateData: TNotifyEvent);
begin
  FDataSource := ADataSource;
  FOriginal := TDataSourceProxy(FDataSource).OnUpdateData;
  FEventoProxy := ANovoUpdateData;
  TDataSourceProxy(FDataSource).OnUpdateData := Disparar;
end;

destructor TUpdateDataProxy.Destroy;
begin
  TDataSourceProxy(FDataSource).OnUpdateData := FOriginal;
  inherited;
end;

procedure TUpdateDataProxy.Disparar(Sender: TObject);
begin
  if Assigned(FOriginal) then
    FOriginal(Sender);
  if Assigned(FEventoProxy) then
    FEventoProxy(Sender);
end;

end.
