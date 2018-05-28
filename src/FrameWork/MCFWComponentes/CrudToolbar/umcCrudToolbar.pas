unit umcCrudToolbar;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin,
  Data.DB,
  DataSet.Proxy.DataSource.DataStateChange,
  DataSet.Proxy.DataSource.UpdateData,
  umcFrameWorkTypes;

type
  TCrudToolbar = class(TFrame)
    btnCrudSalvar: TToolButton;
    btnCrudDesfazer: TToolButton;
    btnSeparator1: TToolButton;
    btnCrudApagar: TToolButton;
    btnCrudImprimir: TToolButton;
    ImageList: TImageList;
    btnCrudAtualizar: TToolButton;
    ImageListDisabled: TImageList;
    tblCrud: TToolBar;
    procedure btnCrudSalvarClick(Sender: TObject);
    procedure btnCrudDesfazerClick(Sender: TObject);
    procedure btnCrudApagarClick(Sender: TObject);
    procedure btnCrudImprimirClick(Sender: TObject);
    procedure btnCrudAtualizarClick(Sender: TObject);
  private
    FAcoes: TCRUDAcoesSet;
    FDataStateChangeProxy: TDataStateChangeProxy;
    FUpdateDataProxy: TUpdateDataProxy;
    FDataSource: TDataSource;
    FOnDataChange: TDataChangeEvent;
    FOnSalvarClick: TDataSetClick;
    FOnImprimirClick: TDataSetClick;
    FOnApagarClick: TDataSetClick;
    FOnDesfazerClick: TDataSetClick;
    FOnAtualizarClick: TDataSetAtualizarClick;
    FAposSalvar: TDataSetClick;
    FAposAtualizar: TDataSetClick;
    FAntesImprimir: TDataSetEventoCancelavel;
    FAntesApagar: TDataSetEventoCancelavel;
    FAntesDesfazer: TDataSetEventoCancelavel;
    FAntesSalvar: TDataSetEventoCancelavel;
    FAntesAtualizar: TDataSetEventoCancelavel;
    FAposImprimir: TDataSetClick;
    FAposApagar: TDataSetClick;
    FAposDesfazer: TDataSetClick;
    procedure SetAcoes(const Value: TCRUDAcoesSet);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetOnApagarClick(const Value: TDataSetClick);
    procedure SetOnDesfazerClick(const Value: TDataSetClick);
    procedure SetOnImprimirClick(const Value: TDataSetClick);
    procedure SetOnSalvarClick(const Value: TDataSetClick);
    procedure SetOnAtualizarClick(const Value: TDataSetAtualizarClick);
    procedure MonitorarEventos;
    procedure DesmonitorarEventos;
    procedure SetAntesApagar(const Value: TDataSetEventoCancelavel);
    procedure SetAntesAtualizar(const Value: TDataSetEventoCancelavel);
    procedure SetAntesDesfazer(const Value: TDataSetEventoCancelavel);
    procedure SetAntesImprimir(const Value: TDataSetEventoCancelavel);
    procedure SetAntesSalvar(const Value: TDataSetEventoCancelavel);
    procedure SetAposApagar(const Value: TDataSetClick);
    procedure SetAposAtualizar(const Value: TDataSetClick);
    procedure SetAposDesfazer(const Value: TDataSetClick);
    procedure SetAposImprimir(const Value: TDataSetClick);
    procedure SetAposSalvar(const Value: TDataSetClick);
  protected
    procedure ExecutarAcao(const ADataSet: TDataSet; const ProcAcao: TProc; const EventoAntes: TDataSetEventoCancelavel;
      const EventoApos: TDataSetClick); virtual; final;
    function getDataSet: TDataSet; virtual;
    function TestarDataSetAtribuido: boolean;
    function TestarDataSetVazio: boolean;
    function TestarDataSetEditavel: boolean;
    procedure SincronizarBotoes; virtual;
    procedure DataChange(Sender: TObject; Field: TField);
    procedure UpdateData(Sender: TObject);
    procedure StateChange(Sender: TObject);

    procedure DoAntesSalvar(const ADataSet: TDataSet; var AContinuar: boolean); virtual;
    procedure DoSalvarClick; virtual;
    procedure DoAposSalvar(const ADataSet: TDataSet); virtual;

    procedure DoAntesDesfazer(const ADataSet: TDataSet; var AContinuar: boolean); virtual;
    procedure DoDesfazerClick; virtual;
    procedure DoAposDesfazer(const ADataSet: TDataSet); virtual;

    procedure DoAntesApagar(const ADataSet: TDataSet; var AContinuar: boolean); virtual;
    procedure DoApagarClick; virtual;
    procedure DoAposApagar(const ADataSet: TDataSet); virtual;

    procedure DoAntesImprimir(const ADataSet: TDataSet; var AContinuar: boolean); virtual;
    procedure DoImprimirClick; virtual;
    procedure DoAposImprimir(const ADataSet: TDataSet); virtual;

    procedure DoAntesAtualizar(const ADataSet: TDataSet; var AContinuar: boolean); virtual;
    procedure DoAtualizarClick; virtual;
    procedure DoAposAtualizar(const ADataSet: TDataSet); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Salvar; virtual;
    procedure Desfazer; virtual;
    procedure Apagar; virtual;
    procedure Imprimir; virtual;
    procedure Atualizar; virtual;
  published
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property Acoes: TCRUDAcoesSet read FAcoes write SetAcoes Default [crudSalvar, crudCancelar, crudApagar,
      crudAtualizar];

    property AntesSalvar: TDataSetEventoCancelavel read FAntesSalvar write SetAntesSalvar;
    property OnSalvarClick: TDataSetClick read FOnSalvarClick write SetOnSalvarClick;
    property AposSalvar: TDataSetClick read FAposSalvar write SetAposSalvar;

    property AntesDesfazer: TDataSetEventoCancelavel read FAntesDesfazer write SetAntesDesfazer;
    property OnDesfazerClick: TDataSetClick read FOnDesfazerClick write SetOnDesfazerClick;
    property AposDesfazer: TDataSetClick read FAposDesfazer write SetAposDesfazer;

    property AntesApagar: TDataSetEventoCancelavel read FAntesApagar write SetAntesApagar;
    property OnApagarClick: TDataSetClick read FOnApagarClick write SetOnApagarClick;
    property AposApagar: TDataSetClick read FAposApagar write SetAposApagar;

    property AntesImprimir: TDataSetEventoCancelavel read FAntesImprimir write SetAntesImprimir;
    property OnImprimirClick: TDataSetClick read FOnImprimirClick write SetOnImprimirClick;
    property AposImprimir: TDataSetClick read FAposImprimir write SetAposImprimir;

    property AntesAtualizar: TDataSetEventoCancelavel read FAntesAtualizar write SetAntesAtualizar;
    property OnAtualizarClick: TDataSetAtualizarClick read FOnAtualizarClick write SetOnAtualizarClick;
    property AposAtualizar: TDataSetClick read FAposAtualizar write SetAposAtualizar;
  end;

implementation

{$R *.dfm}

constructor TCrudToolbar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAcoes := [crudSalvar, crudCancelar, crudApagar, crudAtualizar];
  FDataStateChangeProxy := nil;
end;

destructor TCrudToolbar.Destroy;
begin
  if Assigned(FDataSource) then
    DesmonitorarEventos;
  if Assigned(FDataStateChangeProxy) then
    FreeAndNil(FDataStateChangeProxy);
  inherited;
end;

procedure TCrudToolbar.Salvar;
begin
  ExecutarAcao(getDataSet, DoSalvarClick, DoAntesSalvar, DoAposSalvar);
end;

procedure TCrudToolbar.DoAntesSalvar(const ADataSet: TDataSet; var AContinuar: boolean);
begin
  if Assigned(FAntesSalvar) then
    FAntesSalvar(ADataSet, AContinuar);
end;

procedure TCrudToolbar.DoSalvarClick;
begin
  if Assigned(FOnSalvarClick) then
    FOnSalvarClick(DataSource.DataSet);

  if TestarDataSetEditavel then
    getDataSet.Post;
end;

procedure TCrudToolbar.DoAposSalvar(const ADataSet: TDataSet);
begin
  if Assigned(FAposSalvar) then
    FAposSalvar(ADataSet);
end;

procedure TCrudToolbar.Desfazer;
begin
  ExecutarAcao(getDataSet, DoDesfazerClick, DoAntesDesfazer, DoAposDesfazer);
end;

procedure TCrudToolbar.DoAntesDesfazer(const ADataSet: TDataSet; var AContinuar: boolean);
begin
  if Assigned(FAntesDesfazer) then
    FAntesDesfazer(ADataSet, AContinuar);
end;

procedure TCrudToolbar.DoDesfazerClick;
begin
  if TestarDataSetEditavel then
    getDataSet.Cancel;

  if Assigned(FOnDesfazerClick) then
    FOnDesfazerClick(DataSource.DataSet);
end;

procedure TCrudToolbar.DoAposDesfazer(const ADataSet: TDataSet);
begin
  if Assigned(FAposDesfazer) then
    FAposDesfazer(ADataSet);
end;

procedure TCrudToolbar.Apagar;
begin
  ExecutarAcao(getDataSet, DoApagarClick, DoAntesApagar, DoAposApagar);
end;

procedure TCrudToolbar.DoApagarClick;
begin
  if Assigned(FOnApagarClick) then
    FOnApagarClick(DataSource.DataSet);

  if not TestarDataSetVazio then
    getDataSet.Delete;
end;

procedure TCrudToolbar.DoAposApagar(const ADataSet: TDataSet);
begin
  if Assigned(FAposApagar) then
    FAposApagar(ADataSet);
end;

procedure TCrudToolbar.DoAntesApagar(const ADataSet: TDataSet; var AContinuar: boolean);
begin
  if Assigned(FAntesApagar) then
    FAntesApagar(ADataSet, AContinuar);
end;

procedure TCrudToolbar.DoAntesImprimir(const ADataSet: TDataSet; var AContinuar: boolean);
begin
  if Assigned(FAntesImprimir) then
    FAntesImprimir(ADataSet, AContinuar);
end;

procedure TCrudToolbar.DoImprimirClick;
begin
  if Assigned(FOnImprimirClick) then
    FOnImprimirClick(DataSource.DataSet);
end;

procedure TCrudToolbar.DoAposImprimir(const ADataSet: TDataSet);
begin
  if Assigned(FAposImprimir) then
    FAposImprimir(ADataSet);
end;

procedure TCrudToolbar.Imprimir;
begin
  ExecutarAcao(getDataSet, DoImprimirClick, DoAntesImprimir, DoAposImprimir);
end;

procedure TCrudToolbar.Atualizar;
begin
  ExecutarAcao(getDataSet, DoAtualizarClick, DoAntesAtualizar, DoAposAtualizar);
end;

procedure TCrudToolbar.DoAntesAtualizar(const ADataSet: TDataSet; var AContinuar: boolean);
begin
  if Assigned(FAntesAtualizar) then
    FAntesAtualizar(ADataSet, AContinuar);
end;

procedure TCrudToolbar.DoAtualizarClick;
var
  _atualizado: boolean;
begin
  _atualizado := False;

  if Assigned(FOnAtualizarClick) then
    FOnAtualizarClick(DataSource.DataSet, _atualizado);

  if not _atualizado then
    getDataSet.Refresh;
end;

procedure TCrudToolbar.DoAposAtualizar(const ADataSet: TDataSet);
begin
  if Assigned(FAposAtualizar) then
    FAposAtualizar(ADataSet);
end;

procedure TCrudToolbar.ExecutarAcao(const ADataSet: TDataSet; const ProcAcao: TProc;
  const EventoAntes: TDataSetEventoCancelavel; const EventoApos: TDataSetClick);
var
  _podeContinuar: boolean;
begin
  try
    _podeContinuar := True;

    if Assigned(EventoAntes) then
      EventoAntes(ADataSet, _podeContinuar);

    if not _podeContinuar then
      exit;

    ProcAcao;

    if Assigned(EventoApos) then
      EventoApos(ADataSet);
  finally
    SincronizarBotoes;
  end;
end;

procedure TCrudToolbar.btnCrudSalvarClick(Sender: TObject);
begin
  Salvar;
end;

procedure TCrudToolbar.btnCrudDesfazerClick(Sender: TObject);
begin
  Desfazer;
end;

procedure TCrudToolbar.btnCrudApagarClick(Sender: TObject);
begin
  Apagar;
end;

procedure TCrudToolbar.btnCrudImprimirClick(Sender: TObject);
begin
  Imprimir;
end;

procedure TCrudToolbar.btnCrudAtualizarClick(Sender: TObject);
begin
  Atualizar;
end;

function TCrudToolbar.getDataSet: TDataSet;
begin
  result := nil;
  if TestarDataSetAtribuido then
    result := FDataSource.DataSet;
end;

procedure TCrudToolbar.SetAcoes(const Value: TCRUDAcoesSet);
begin
  FAcoes := Value;
  SincronizarBotoes;
end;

procedure TCrudToolbar.SetAntesApagar(const Value: TDataSetEventoCancelavel);
begin
  FAntesApagar := Value;
end;

procedure TCrudToolbar.SetAntesAtualizar(const Value: TDataSetEventoCancelavel);
begin
  FAntesAtualizar := Value;
end;

procedure TCrudToolbar.SetAntesDesfazer(const Value: TDataSetEventoCancelavel);
begin
  FAntesDesfazer := Value;
end;

procedure TCrudToolbar.SetAntesImprimir(const Value: TDataSetEventoCancelavel);
begin
  FAntesImprimir := Value;
end;

procedure TCrudToolbar.SetAntesSalvar(const Value: TDataSetEventoCancelavel);
begin
  FAntesSalvar := Value;
end;

procedure TCrudToolbar.SetAposApagar(const Value: TDataSetClick);
begin
  FAposApagar := Value;
end;

procedure TCrudToolbar.SetAposAtualizar(const Value: TDataSetClick);
begin
  FAposAtualizar := Value;
end;

procedure TCrudToolbar.SetAposDesfazer(const Value: TDataSetClick);
begin
  FAposDesfazer := Value;
end;

procedure TCrudToolbar.SetAposImprimir(const Value: TDataSetClick);
begin
  FAposImprimir := Value;
end;

procedure TCrudToolbar.SetAposSalvar(const Value: TDataSetClick);
begin
  FAposSalvar := Value;
end;

procedure TCrudToolbar.SetDataSource(const Value: TDataSource);
begin
  if Assigned(FDataSource) then
    DesmonitorarEventos;

  FDataSource := Value;

  MonitorarEventos;

  SincronizarBotoes;
end;

procedure TCrudToolbar.DesmonitorarEventos;
begin
  if Assigned(FDataStateChangeProxy) then
    FreeAndNil(FDataStateChangeProxy);

  if Assigned(FUpdateDataProxy) then
    FreeAndNil(FUpdateDataProxy);

  FDataSource.OnDataChange := FOnDataChange;
end;

procedure TCrudToolbar.MonitorarEventos;
begin
  FDataStateChangeProxy := TDataStateChangeProxy.Create(FDataSource, Self.StateChange);
  FUpdateDataProxy := TUpdateDataProxy.Create(FDataSource, Self.UpdateData);

  FOnDataChange := FDataSource.OnDataChange;
  FDataSource.OnDataChange := DataChange;
end;

procedure TCrudToolbar.SetOnApagarClick(const Value: TDataSetClick);
begin
  FOnApagarClick := Value;
end;

procedure TCrudToolbar.SetOnAtualizarClick(const Value: TDataSetAtualizarClick);
begin
  FOnAtualizarClick := Value;
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

function TCrudToolbar.TestarDataSetAtribuido: boolean;
begin
  result := False;

  if not Assigned(FDataSource) then
    exit;

  if not Assigned(FDataSource.DataSet) then
    exit;

  result := True;
end;

function TCrudToolbar.TestarDataSetEditavel: boolean;
begin
  result := False;

  if not TestarDataSetAtribuido then
    exit;

  if TestarDataSetVazio then
    exit;

  result := FDataSource.State in dsEditModes;
end;

function TCrudToolbar.TestarDataSetVazio: boolean;
begin
  result := True;

  if not TestarDataSetAtribuido then
    exit;

  result := getDataSet.IsEmpty;
end;

procedure TCrudToolbar.SincronizarBotoes;
begin
  btnCrudSalvar.Visible := (crudSalvar in Acoes);
  btnCrudDesfazer.Visible := (crudCancelar in Acoes);
  btnCrudApagar.Visible := (crudApagar in Acoes);
  btnCrudImprimir.Visible := (crudImprimir in Acoes);
  btnCrudAtualizar.Visible := (crudAtualizar in Acoes);

  btnCrudSalvar.Enabled := (TestarDataSetEditavel) and btnCrudSalvar.Visible;
  btnCrudDesfazer.Enabled := (TestarDataSetEditavel) and btnCrudDesfazer.Visible;
  btnCrudApagar.Enabled := (not TestarDataSetVazio) and btnCrudApagar.Visible;
  btnCrudImprimir.Enabled := (not TestarDataSetVazio) and (not TestarDataSetEditavel) and btnCrudImprimir.Visible;
  btnCrudAtualizar.Enabled := (TestarDataSetAtribuido) and (not TestarDataSetEditavel) and btnCrudAtualizar.Visible;
end;

procedure TCrudToolbar.DataChange(Sender: TObject; Field: TField);
begin
  if Assigned(FOnDataChange) then
    FOnDataChange(Sender, Field);
end;

procedure TCrudToolbar.UpdateData(Sender: TObject);
begin
  //
end;

procedure TCrudToolbar.StateChange(Sender: TObject);
begin
  SincronizarBotoes;
end;

end.
