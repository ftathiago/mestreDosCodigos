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
  private
    { Private declarations }
    FDataSource: TDataSource;
    FAcoes: TAcoesSet;
    FOnFecharClick: TDataSetClick;
    FOnNovoClick: TDataSetClick;
    FOnSelecionarClick: TDataSetClick;
    FOnImprimirClick: TDataSetClick;
    FOnPesquisar: TPesquisarClick;
    FCampoDaPesquisa: TField;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetAcoes(const Value: TAcoesSet);
    procedure SetOnFecharClick(const Value: TDataSetClick);
    procedure SetOnImprimirClick(const Value: TDataSetClick);
    procedure SetOnNovoClick(const Value: TDataSetClick);
    procedure SetOnSelecionarClick(const Value: TDataSetClick);
    procedure SetOnPesquisar(const Value: TPesquisarClick);
    procedure SincronizarBotoes;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Align Default alClient;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Acoes: TAcoesSet read FAcoes write SetAcoes Default [aSelecionar, aNovo, aFechar,
      aImprimir];
    property OnSelecionarClick: TDataSetClick read FOnSelecionarClick write SetOnSelecionarClick;
    property OnNovoClick: TDataSetClick read FOnNovoClick write SetOnNovoClick;
    property OnImprimirClick: TDataSetClick read FOnImprimirClick write SetOnImprimirClick;
    property OnFecharClick: TDataSetClick read FOnFecharClick write SetOnFecharClick;
    property OnPesquisar: TPesquisarClick read FOnPesquisar write SetOnPesquisar;
  end;

procedure Register;

implementation

{$R *.dfm}


uses
  System.RTLConsts,
  Vcl.Themes;

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

function TfmcFrmConsulta.GetDataSource: TDataSource;
begin
  result := FDataSource;
end;

procedure TfmcFrmConsulta.grDadosTitleClick(Column: TColumn);
begin
  FCampoDaPesquisa := Column.Field;
end;

procedure TfmcFrmConsulta.SetAcoes(const Value: TAcoesSet);
begin
  FAcoes := Value;
  SincronizarBotoes;
end;

procedure TfmcFrmConsulta.SetDataSource(const Value: TDataSource);
begin
  if FDataSource <> Value then
  begin
    FDataSource := Value;
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
