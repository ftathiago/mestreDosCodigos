unit umcFrmConsulta;

interface

uses
  umcFrameWorkTypes,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ToolWin,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfmcFrmConsulta = class(TFrame)
    grDados: TDBGrid;
    tblComandos: TToolBar;
    btnSelecionar: TToolButton;
    ActionList: TActionList;
    actSelecionar: TAction;
    btnNovoRegistro: TToolButton;
    pnPesquisa: TPanel;
    Label1: TLabel;
    edtPesquisa: TEdit;
    actNovo: TAction;
    Button1: TButton;
    actPesquisar: TAction;
    actImprimir: TAction;
    actFechar: TAction;
    btnImprimir: TToolButton;
    btnFechar: TToolButton;
    ToolButton1: TToolButton;
    ImageList: TImageList;
    procedure actSelecionarExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure grDadosTitleClick(Column: TColumn);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure grDadosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure grDadosDblClick(Sender: TObject);
  private
    { Private declarations }
    FDataSource: TDataSource;
    FDataSourceStateChange: TNotifyEvent;
    FAcoes: TAcoesSet;
    FOnFecharClick: TDataSetClick;
    FOnNovoClick: TDataSetClick;
    FOnSelecionarClick: TDataSetClick;
    FOnImprimirClick: TDataSetClick;
    FOnPesquisar: TPesquisarClick;
    FCampoDaPesquisa: TField;
    FOnSelecionarCampoParaPesquisa: TDBGridClickEvent;
    function GetDataSource: TDataSource;
    function LocalizarColunaDoCampo(const ACampo: TField): TColumn;
    procedure DataSourceStateChange(Sender: TObject);
    procedure SetColunaPesquisa(const Coluna: TColumn);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetAcoes(const Value: TAcoesSet);
    procedure SetOnFecharClick(const Value: TDataSetClick);
    procedure SetOnImprimirClick(const Value: TDataSetClick);
    procedure SetOnNovoClick(const Value: TDataSetClick);
    procedure SetOnSelecionarClick(const Value: TDataSetClick);
    procedure SetOnPesquisar(const Value: TPesquisarClick);
    procedure SincronizarBotoes;
    procedure SetOnSelecionarCampoParaPesquisa(const Value: TDBGridClickEvent);
  public
    { Public declarations }
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align Default alClient;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Acoes: TAcoesSet read FAcoes write SetAcoes Default [aSelecionar, aNovo, aFechar, aImprimir];
    property OnSelecionarClick: TDataSetClick read FOnSelecionarClick write SetOnSelecionarClick;
    property OnNovoClick: TDataSetClick read FOnNovoClick write SetOnNovoClick;
    property OnImprimirClick: TDataSetClick read FOnImprimirClick write SetOnImprimirClick;
    property OnFecharClick: TDataSetClick read FOnFecharClick write SetOnFecharClick;
    property OnPesquisar: TPesquisarClick read FOnPesquisar write SetOnPesquisar;
    property OnSelecionarCampoParaPesquisa: TDBGridClickEvent read FOnSelecionarCampoParaPesquisa
      write SetOnSelecionarCampoParaPesquisa;
  end;

procedure Register;

implementation

{$R *.dfm}

uses
  umcExceptions, System.RTLConsts, Vcl.Themes;

procedure Register;
begin
  RegisterComponents('Mestre dos Códigos', [TfmcFrmConsulta]);
end;

{ TfmcFrmConsulta }

procedure TfmcFrmConsulta.actFecharExecute(Sender: TObject);
begin
  if Assigned(FOnFecharClick) then
    FOnFecharClick(DataSource.DataSet);
end;

procedure TfmcFrmConsulta.actImprimirExecute(Sender: TObject);
begin
  if Assigned(FOnImprimirClick) then
    FOnImprimirClick(DataSource.DataSet);
end;

procedure TfmcFrmConsulta.actNovoExecute(Sender: TObject);
begin
  if Assigned(FOnNovoClick) then
    FOnNovoClick(DataSource.DataSet);
end;

procedure TfmcFrmConsulta.actPesquisarExecute(Sender: TObject);
begin
  if String(edtPesquisa.Text).Trim.IsEmpty then
  begin
    edtPesquisa.SetFocus;
    raise EPesquisaException.Create('Você esqueceu de informar o conteúdo da pesquisa!');
  end;

  if Assigned(FOnPesquisar) then
    FOnPesquisar(edtPesquisa.Text, FCampoDaPesquisa);
end;

procedure TfmcFrmConsulta.actSelecionarExecute(Sender: TObject);
begin
  if Assigned(FOnSelecionarClick) then
    FOnSelecionarClick(DataSource.DataSet);
end;

procedure TfmcFrmConsulta.AfterConstruction;
begin
  inherited;
  SincronizarBotoes;
end;

constructor TfmcFrmConsulta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAcoes := [aSelecionar, aNovo, aFechar, aImprimir];
  Align := alClient;
end;

procedure TfmcFrmConsulta.DataSourceStateChange(Sender: TObject);
var
  _dataSource: TDataSource;
begin
  if Assigned(FDataSourceStateChange) then
    FDataSourceStateChange(Sender);

  if not Assigned(Sender) then
    exit;

  _dataSource := Sender as TDataSource;

  if not Assigned(_dataSource.DataSet) then
    exit;

  if _dataSource.State = dsBrowse then
    SetColunaPesquisa(LocalizarColunaDoCampo(FCampoDaPesquisa));
end;

destructor TfmcFrmConsulta.Destroy;
begin
  if Assigned(FDataSource) then
    FDataSource.OnStateChange := FDataSourceStateChange;
  FDataSourceStateChange := nil;
  inherited;
end;

function TfmcFrmConsulta.GetDataSource: TDataSource;
begin
  result := FDataSource;
end;

procedure TfmcFrmConsulta.grDadosDblClick(Sender: TObject);
begin
  actSelecionar.Execute;
end;

procedure TfmcFrmConsulta.grDadosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  mousePt: TGridcoord;
begin
  mousePt := grDados.MouseCoord(X, Y);
  if mousePt.Y = 0 then
    Screen.Cursor := crHandPoint
  else
    Screen.Cursor := crDefault;
end;

procedure TfmcFrmConsulta.grDadosTitleClick(Column: TColumn);
begin
  SetColunaPesquisa(Column);
end;

function TfmcFrmConsulta.LocalizarColunaDoCampo(const ACampo: TField): TColumn;
var
  i: Integer;
begin
  result := nil;

  if not Assigned(ACampo) then
    exit;

  for i := 0 to Pred(grDados.Columns.Count) do
    if grDados.Columns[i].Field = ACampo then
    begin
      result := grDados.Columns[i];
      break;
    end;
end;

procedure TfmcFrmConsulta.SetAcoes(const Value: TAcoesSet);
begin
  FAcoes := Value;
  SincronizarBotoes;
end;

procedure TfmcFrmConsulta.SetColunaPesquisa(const Coluna: TColumn);
var
  i: Integer;
  _coluna: TColumn;
begin
  if grDados.Columns.Count = 0 then
    exit;

  _coluna := Coluna;
  if not Assigned(_coluna) then
    _coluna := grDados.Columns[0];

  for i := 0 to grDados.Columns.Count - 1 do
    grDados.Columns[i].Title.Font.Style := [];

  _coluna.Title.Font.Style := [fsBold];

  FCampoDaPesquisa := _coluna.Field;

  if Assigned(FOnSelecionarCampoParaPesquisa) then
    FOnSelecionarCampoParaPesquisa(_coluna);
end;

procedure TfmcFrmConsulta.SetDataSource(const Value: TDataSource);
begin
  if FDataSource <> Value then
  begin

    if Assigned(FDataSource) then
      FDataSource.OnStateChange := FDataSourceStateChange;

    FDataSourceStateChange := nil;

    FDataSource := Value;
    FDataSourceStateChange := FDataSource.OnStateChange;
    FDataSource.OnStateChange := DataSourceStateChange;

    grDados.DataSource := Value;
  end;
end;

procedure TfmcFrmConsulta.SetOnFecharClick(const Value: TDataSetClick);
begin
  FOnFecharClick := Value;
end;

procedure TfmcFrmConsulta.SetOnImprimirClick(const Value: TDataSetClick);
begin
  FOnImprimirClick := Value;
end;

procedure TfmcFrmConsulta.SetOnNovoClick(const Value: TDataSetClick);
begin
  FOnNovoClick := Value;
end;

procedure TfmcFrmConsulta.SetOnPesquisar(const Value: TPesquisarClick);
begin
  FOnPesquisar := Value;
end;

procedure TfmcFrmConsulta.SetOnSelecionarCampoParaPesquisa(const Value: TDBGridClickEvent);
begin
  FOnSelecionarCampoParaPesquisa := Value;
end;

procedure TfmcFrmConsulta.SetOnSelecionarClick(const Value: TDataSetClick);
begin
  FOnSelecionarClick := Value;
end;

procedure TfmcFrmConsulta.SincronizarBotoes;
begin
  actSelecionar.Enabled := aSelecionar in FAcoes;
  actSelecionar.Visible := aSelecionar in FAcoes;
  btnSelecionar.Visible := aSelecionar in FAcoes;

  actNovo.Enabled := aNovo in FAcoes;
  actNovo.Visible := aNovo in FAcoes;
  btnNovoRegistro.Visible := aNovo in FAcoes;

  actImprimir.Enabled := aImprimir in FAcoes;
  actImprimir.Visible := aImprimir in FAcoes;
  btnImprimir.Visible := aImprimir in FAcoes;

  actFechar.Enabled := aFechar in FAcoes;
  actFechar.Visible := aFechar in FAcoes;
  btnFechar.Visible := aFechar in FAcoes;
end;

end.
