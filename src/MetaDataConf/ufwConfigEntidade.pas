unit ufwConfigEntidade;

interface

uses
  ufwPrincipal,
  ufwForm,
  umcFDCrudToolbar,
  DataSet.Intf.MetaDataContainer,
  DataSet.Intf.ConfiguradorMetaData,
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
  FireDAC.Stan.StorageBin, umcCrudToolbar;

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
    actLimpar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ENTIDADEAfterOpen(DataSet: TDataSet);
    procedure ENT_PROPRIEDADEAfterOpen(DataSet: TDataSet);
    procedure grdENTIDADEEnter(Sender: TObject);
    procedure actLerEstruturaDoBancoExecute(Sender: TObject);
    procedure actLimparExecute(Sender: TObject);
    procedure CrudToolbarSalvarClick(const DataSet: TDataSet);
    procedure CrudToolbarDesfazerClick(const DataSet: TDataSet);
  private
    { Private declarations }
    FMetaData: IMetaDataContainer;
    FConfiguradorMetaData: IConfiguradorMetaData;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses
  umcConstantes,
  DataSet.Intf.MetaDataController,
  DataSet.Impl.MetaDataController,
  DataSet.Impl.MetaDataContainer,
  DataSet.Impl.ConfiguradorMetaData;

procedure TffwConfigEntidade.FormCreate(Sender: TObject);
begin
  inherited;
  FMetaData := TMetaDataContainer.New(ENTIDADE.Connection);
  FConfiguradorMetaData := TConfiguradorMetaData.New(FMetaData.ENTIDADE, FMetaData.EntPropriedade);

  ENTIDADE.Open();
  ENT_PROPRIEDADE.Open();
end;

procedure TffwConfigEntidade.actLerEstruturaDoBancoExecute(Sender: TObject);
var

  _metaDataController: ImcMetaDataController;
begin
  inherited;
  _metaDataController := TmcMetaDataController.New(ffwPrincipal.FDConnection);
  _metaDataController.SetMetaDataContainer(FMetaData);
  _metaDataController.Carregar;
  ENTIDADE.Close;
  ENTIDADE.Open();
end;

procedure TffwConfigEntidade.actLimparExecute(Sender: TObject);
var
  _metaDataController: ImcMetaDataController;
begin
  inherited;
  _metaDataController := TmcMetaDataController.New(ffwPrincipal.FDConnection);
  _metaDataController.SetMetaDataContainer(FMetaData);
  _metaDataController.Limpar;
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

procedure TffwConfigEntidade.grdENTIDADEEnter(Sender: TObject);
var
  _grid: TDBGrid;
begin
  inherited;
  _grid := Sender as TDBGrid;
  CrudToolbar.DataSource := _grid.DataSource;
end;

initialization

RegisterClass(TffwConfigEntidade);

end.
