unit umcCrudToolbar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  Data.DB,
  umcFrameWorkTypes;

type
  TCrudToolbar = class(TFrame)
    ToolBar: TToolBar;
    btnCrudSalvar: TToolButton;
    btnCrudDesfazer: TToolButton;
    ToolButton3: TToolButton;
    btnCrudApagar: TToolButton;
    btnCrudImprimir: TToolButton;
    ImageList: TImageList;
    procedure btnCrudSalvarClick(Sender: TObject);
    procedure btnCrudDesfazerClick(Sender: TObject);
    procedure btnCrudApagarClick(Sender: TObject);
    procedure btnCrudImprimirClick(Sender: TObject);
  private
    { Private declarations }
    FAcoes: TCRUDAcoesSet;
    FDataSource: TDataSource;
    FOnStateChange: TNotifyEvent;
    FOnDataChange: TDataChangeEvent;
    FOnUpdateData: TNotifyEvent;
    FOnSalvarClick: TDataSetClick;
    FOnImprimirClick: TDataSetClick;
    FOnApagarClick: TDataSetClick;
    FOnDesfazerClick: TDataSetClick;
    procedure SincronizarBotoes;
    procedure SetAcoes(const Value: TCRUDAcoesSet);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetOnApagarClick(const Value: TDataSetClick);
    procedure SetOnDesfazerClick(const Value: TDataSetClick);
    procedure SetOnImprimirClick(const Value: TDataSetClick);
    procedure SetOnSalvarClick(const Value: TDataSetClick);
    procedure MonitorarEventos;
    procedure DesmonitorarEventos;
  protected
    function getDataSet: TDataSet;
    function TestarDataSetAtribuido: boolean;
    function TestarDataSetVazio: boolean;
    function TestarDataSetEditavel: boolean;
    procedure DataChange(Sender: TObject; Field: TField);
    procedure UpdateData(Sender: TObject);
    procedure StateChange(Sender: TObject);
    procedure DoSalvarClick;
    procedure DoDesfazerClick;
    procedure DoApagarClick;
    procedure DoImprimirClick;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Salvar;
    procedure Desfazer;
    procedure Apagar;
    procedure Imprimir;
  published
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property Acoes: TCRUDAcoesSet read FAcoes write SetAcoes
      Default [crudSalvar, crudCancelar, crudApagar, crudAtualizar];
    property OnSalvarClick: TDataSetClick read FOnSalvarClick write SetOnSalvarClick;
    property OnDesfazerClick: TDataSetClick read FOnDesfazerClick write SetOnDesfazerClick;
    property OnApagarClick: TDataSetClick read FOnApagarClick write SetOnApagarClick;
    property OnImprimirClick: TDataSetClick read FOnImprimirClick write SetOnImprimirClick;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TCrudToolbar.Apagar;
begin
  if not TestarDataSetVazio then
    getDataSet.Delete;

  DoApagarClick;
end;

procedure TCrudToolbar.btnCrudApagarClick(Sender: TObject);
begin
  Apagar;
end;

procedure TCrudToolbar.btnCrudDesfazerClick(Sender: TObject);
begin
  Desfazer;
end;

procedure TCrudToolbar.btnCrudImprimirClick(Sender: TObject);
begin
  Imprimir;
end;

procedure TCrudToolbar.btnCrudSalvarClick(Sender: TObject);
begin
  Salvar;
end;

constructor TCrudToolbar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAcoes := [crudSalvar, crudCancelar, crudApagar, crudAtualizar];
end;

procedure TCrudToolbar.DataChange(Sender: TObject; Field: TField);
begin
  if Assigned(FOnDataChange) then
    FOnDataChange(Sender, Field);
end;

procedure TCrudToolbar.Desfazer;
begin
  if TestarDataSetEditavel then
    getDataSet.Cancel;

  DoDesfazerClick;
end;

procedure TCrudToolbar.DesmonitorarEventos;
begin
  FDataSource.OnStateChange := FOnStateChange;
  FDataSource.OnDataChange := FOnDataChange;
  FDataSource.OnUpdateData := FOnUpdateData;
end;

destructor TCrudToolbar.Destroy;
begin
  if Assigned(FDataSource) then
    DesmonitorarEventos;

  inherited;
end;

procedure TCrudToolbar.DoApagarClick;
begin
  if Assigned(FOnApagarClick) then
    FOnApagarClick(DataSource.DataSet);
end;

procedure TCrudToolbar.DoDesfazerClick;
begin
  if Assigned(FOnDesfazerClick) then
    FOnDesfazerClick(DataSource.DataSet);
end;

procedure TCrudToolbar.DoImprimirClick;
begin
  if Assigned(FOnImprimirClick) then
    FOnImprimirClick(DataSource.DataSet);
end;

procedure TCrudToolbar.DoSalvarClick;
begin
  if Assigned(FOnSalvarClick) then
    FOnSalvarClick(DataSource.DataSet);
end;

function TCrudToolbar.getDataSet: TDataSet;
begin
  result := nil;
  if TestarDataSetAtribuido then
    result := FDataSource.DataSet;
end;

procedure TCrudToolbar.Imprimir;
begin
  DoImprimirClick
end;

procedure TCrudToolbar.MonitorarEventos;
begin
  FOnStateChange := FDataSource.OnStateChange;
  FOnDataChange := FDataSource.OnDataChange;
  FOnUpdateData := FDataSource.OnUpdateData;

  FDataSource.OnStateChange := StateChange;
  FDataSource.OnDataChange := DataChange;
  FDataSource.OnUpdateData := UpdateData;
end;

procedure TCrudToolbar.Salvar;
begin
  if TestarDataSetEditavel then
    getDataSet.Post;

  DoSalvarClick;
end;

procedure TCrudToolbar.SetAcoes(const Value: TCRUDAcoesSet);
begin
  FAcoes := Value;
  SincronizarBotoes;
end;

procedure TCrudToolbar.SetDataSource(const Value: TDataSource);
begin
  if Assigned(FDataSource) then
    DesmonitorarEventos;

  FDataSource := Value;

  MonitorarEventos;

  SincronizarBotoes;
end;

procedure TCrudToolbar.SetOnApagarClick(const Value: TDataSetClick);
begin
  FOnApagarClick := Value;
end;

procedure TCrudToolbar.SetOnDesfazerClick(const Value: TDataSetClick);
begin
  FOnDesfazerClick := Value;
end;

procedure TCrudToolbar.SetOnImprimirClick(const Value: TDataSetClick);
begin
  FOnImprimirClick := Value;
end;

procedure TCrudToolbar.SetOnSalvarClick(const Value: TDataSetClick);
begin
  FOnSalvarClick := Value;
end;

procedure TCrudToolbar.SincronizarBotoes;
begin
  btnCrudSalvar.Visible := (crudSalvar in Acoes);
  btnCrudDesfazer.Visible := (crudCancelar in Acoes);
  btnCrudApagar.Visible := (crudApagar in Acoes);
  btnCrudImprimir.Visible := (crudImprimir in Acoes);

  btnCrudSalvar.Enabled := (not TestarDataSetVazio) and btnCrudSalvar.Visible;
  btnCrudDesfazer.Enabled := (not TestarDataSetVazio) and btnCrudDesfazer.Visible;
  btnCrudApagar.Enabled := (not TestarDataSetVazio) and btnCrudApagar.Visible;
  btnCrudImprimir.Enabled := (not TestarDataSetVazio) and btnCrudImprimir.Visible;
end;

procedure TCrudToolbar.StateChange(Sender: TObject);
begin
  if Assigned(FOnStateChange) then
    FOnStateChange(Sender);

  SincronizarBotoes;
end;

function TCrudToolbar.TestarDataSetAtribuido: boolean;
begin
  result := false;

  if not Assigned(FDataSource) then
    exit;

  if not Assigned(FDataSource.DataSet) then
    exit;

  result := true;
end;

function TCrudToolbar.TestarDataSetEditavel: boolean;
begin
  result := false;

  if not TestarDataSetAtribuido then
    exit;

  if TestarDataSetVazio then
    exit;

  result := FDataSource.State in dsEditModes;
end;

function TCrudToolbar.TestarDataSetVazio: boolean;
begin
  result := true;

  if not TestarDataSetAtribuido then
    exit;

  result := getDataSet.IsEmpty;
end;

procedure TCrudToolbar.UpdateData(Sender: TObject);
begin
  if Assigned(FOnUpdateData) then
    FOnUpdateData(Sender);
end;

end.
