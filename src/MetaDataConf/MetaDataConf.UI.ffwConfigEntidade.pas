unit MetaDataConf.UI.ffwConfigEntidade;

interface

uses
  ufwForm,
  umcFDCrudToolbar,
  DataSet.Intf.MetaDataContainer,
  DataSet.Intf.ConfiguradorMetaData,
  DataSet.Intf.MetaDataController,
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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  Vcl.ActnList,
  Vcl.ImgList,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,
  umcCrudToolbar,
  GeradorSQL.Comp.Select,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait;

type
  TffwConfigEntidade = class(TffwForm)
    pnlEntidade: TPanel;
    pnlENT_PROPRIEDADE: TPanel;
    grdENTIDADE: TDBGrid;
    grdENT_PROPRIEDADE: TDBGrid;
    dsEntidade: TDataSource;
    dsEntPropriedade: TDataSource;
    ENT_PROPRIEDADE: TFDQuery;
    imgEntidades: TImageList;
    ActionList: TActionList;
    actLerEstruturaDoBanco: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    CrudToolbar: TumcFDCrudToolbar;
    ENTIDADE: TFDQuery;
    ENTIDADEID: TFDAutoIncField;
    ENTIDADENOME: TStringField;
    ENTIDADEDESCRICAO: TStringField;
    ENT_PROPRIEDADEID: TFDAutoIncField;
    ENT_PROPRIEDADEENTIDADE_ID: TIntegerField;
    ENT_PROPRIEDADENOME: TStringField;
    ENT_PROPRIEDADEDESCRICAO: TStringField;
    ENT_PROPRIEDADEREQUERIDO: TStringField;
    ENT_PROPRIEDADESOMENTE_LEITURA: TStringField;
    ENT_PROPRIEDADEVISIVEL: TStringField;
    ENT_PROPRIEDADETAMANHO_DISPLAY: TIntegerField;
    ENT_PROPRIEDADEPOSICAO: TSmallintField;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    actApagarTodaEstrutura: TAction;
    mcsEntidade: TMCSelect;
    mcsEntPropriedade: TMCSelect;
    procedure FormCreate(Sender: TObject);
    procedure ENTIDADEAfterOpen(DataSet: TDataSet);
    procedure ENT_PROPRIEDADEAfterOpen(DataSet: TDataSet);
    procedure grdENTIDADEEnter(Sender: TObject);
    procedure actLerEstruturaDoBancoExecute(Sender: TObject);
    procedure actApagarTodaEstruturaExecute(Sender: TObject);
    procedure CrudToolbarSalvarClick(const DataSet: TDataSet);
    procedure CrudToolbarDesfazerClick(const DataSet: TDataSet);
  private
    { Private declarations }
    FFDConnection: TFDConnection;
    FMetaData: IMetaDataContainer;
    FConfiguradorMetaData: IConfiguradorMetaData;
    function getMetaDataController: ImcMetaDataController;
    procedure ConfigurarDataSets(const FDConnection: TFDConnection);
    procedure CarregarEstruturaDoBancoNasTabelas;
    procedure AlterarDataSourceDoToolbar(const Sender: TObject);
    procedure ApagarTodosOsMetaDados;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses
  umcConstantes,
  Conexao.Intf.Fabrica,
  Conexao.Impl.Fabrica.FireDAC,
  DataSet.Impl.MetaDataController,
  DataSet.Impl.MetaDataContainer,
  DataSet.Impl.ConfiguradorMetaData;

procedure TffwConfigEntidade.FormCreate(Sender: TObject);
begin
  inherited;
  FFDConnection := TFabricaFireDac.New.getConexao as TFDConnection;

  FMetaData := TMetaDataContainer.New(FFDConnection);
  FConfiguradorMetaData := TConfiguradorMetaData.New(FMetaData.ENTIDADE, FMetaData.EntPropriedade);

  ConfigurarDataSets(FFDConnection);
end;

procedure TffwConfigEntidade.ConfigurarDataSets(const FDConnection: TFDConnection);
begin
  ENTIDADE.Close;
  ENT_PROPRIEDADE.Close;

  ENTIDADE.SQL.Text := mcsEntidade.GerarSQL;
  ENT_PROPRIEDADE.SQL.Text := mcsEntPropriedade.GerarSQL;

  ENTIDADE.Connection := FDConnection;
  ENT_PROPRIEDADE.Connection := FDConnection;

  ENTIDADE.Open();
  ENT_PROPRIEDADE.Open();
end;

procedure TffwConfigEntidade.actLerEstruturaDoBancoExecute(Sender: TObject);
begin
  inherited;
  CarregarEstruturaDoBancoNasTabelas;
end;

procedure TffwConfigEntidade.actApagarTodaEstruturaExecute(Sender: TObject);
begin
  inherited;
  ApagarTodosOsMetaDados;
end;

procedure TffwConfigEntidade.AlterarDataSourceDoToolbar(const Sender: TObject);
var
  _grid: TDBGrid;
begin
  if not(Sender is TDBGrid) then
    exit;

  _grid := Sender as TDBGrid;
  CrudToolbar.DataSource := _grid.DataSource;
end;

procedure TffwConfigEntidade.ApagarTodosOsMetaDados;
begin
  getMetaDataController.Limpar();
  ENTIDADE.Close;
  ENTIDADE.Open();
end;

procedure TffwConfigEntidade.CarregarEstruturaDoBancoNasTabelas;
begin
  getMetaDataController.Carregar;
  ENTIDADE.Close;
  ENTIDADE.Open();
end;

procedure TffwConfigEntidade.CrudToolbarDesfazerClick(const DataSet: TDataSet);
begin
  inherited;
  if ENT_PROPRIEDADE.UpdatesPending then
    ENT_PROPRIEDADE.CancelUpdates;

  if ENTIDADE.UpdatesPending then
    ENTIDADE.CancelUpdates;
end;

procedure TffwConfigEntidade.CrudToolbarSalvarClick(const DataSet: TDataSet);
begin
  inherited;
  if ENT_PROPRIEDADE.State in dsEditModes then
    ENT_PROPRIEDADE.Post;

  if ENTIDADE.State in dsEditModes then
    ENTIDADE.Post;

  if (ENTIDADE.ChangeCount > 0) and (ENTIDADE.UpdatesPending) then
  begin
    if ENTIDADE.ApplyUpdates(0) = 0 then
      ENTIDADE.CommitUpdates;
  end;

  if (ENT_PROPRIEDADE.ChangeCount > 0) and (ENT_PROPRIEDADE.UpdatesPending) then
  begin
    if ENT_PROPRIEDADE.ApplyUpdates(0) = 0 then
      ENT_PROPRIEDADE.CommitUpdates;
  end;
end;

procedure TffwConfigEntidade.ENTIDADEAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FConfiguradorMetaData.setConfigurarDataSet(DataSet, ['ENTIDADE']);
end;

procedure TffwConfigEntidade.ENT_PROPRIEDADEAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FConfiguradorMetaData.setConfigurarDataSet(DataSet, ['ENT_PROPRIEDADE']);
end;

function TffwConfigEntidade.getMetaDataController: ImcMetaDataController;
var
  _metaDataController: ImcMetaDataController;
begin
  inherited;
  result := TmcMetaDataController.New(FFDConnection);
  result.SetMetaDataContainer(FMetaData);
  _metaDataController.Limpar;
  ENTIDADE.Close;
  ENTIDADE.Open();
end;

procedure TffwConfigEntidade.grdENTIDADEEnter(Sender: TObject);
begin
  inherited;
  AlterarDataSourceDoToolbar(Sender);
end;

initialization

RegisterClass(TffwConfigEntidade);

end.
