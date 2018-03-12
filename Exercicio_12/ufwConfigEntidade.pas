unit ufwConfigEntidade;

interface

uses
  ufwPrincipal,
  ufwForm,
  umcCrudToolbar,
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
  FireDAC.Stan.StorageBin;

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
    CrudToolbar: TCrudToolbar;
    TABELAS: TFDMetaInfoQuery;
    CAMPOS: TFDMetaInfoQuery;
    CAMPOSRECNO: TIntegerField;
    CAMPOSCATALOG_NAME: TWideStringField;
    CAMPOSSCHEMA_NAME: TWideStringField;
    CAMPOSTABLE_NAME: TWideStringField;
    CAMPOSCOLUMN_NAME: TWideStringField;
    CAMPOSCOLUMN_POSITION: TIntegerField;
    CAMPOSCOLUMN_DATATYPE: TIntegerField;
    CAMPOSCOLUMN_TYPENAME: TWideStringField;
    CAMPOSCOLUMN_ATTRIBUTES: TLongWordField;
    CAMPOSCOLUMN_PRECISION: TIntegerField;
    CAMPOSCOLUMN_SCALE: TIntegerField;
    CAMPOSCOLUMN_LENGTH: TIntegerField;
    TABELASRECNO: TIntegerField;
    TABELASCATALOG_NAME: TWideStringField;
    TABELASSCHEMA_NAME: TWideStringField;
    TABELASTABLE_NAME: TWideStringField;
    TABELASTABLE_TYPE: TIntegerField;
    TABELASTABLE_SCOPE: TIntegerField;
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
    procedure CrudToolbarSalvarClick(const DataSet: TDataSet);
    procedure CrudToolbarDesfazerClick(const DataSet: TDataSet);
    procedure actLerEstruturaDoBancoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdENTIDADEEnter(Sender: TObject);
    procedure ENTIDADEAfterOpen(DataSet: TDataSet);
    procedure ENT_PROPRIEDADEAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FMetaData: IMetaDataContainer;
    FConfiguradorMetaData: IConfiguradorMetaData;
    procedure CriarIndiceENTIDADE(AQuery: TFDDataSet);
    procedure CriarIndiceENT_PROPRIEDADE(AQuery: TFDDataSet);
    procedure DefinirAtributos;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses
  umcConstantes,
  DataSet.Impl.MetaDataContainer,
  DataSet.Impl.ConfiguradorMetaData;

procedure TffwConfigEntidade.FormCreate(Sender: TObject);
begin
  inherited;
  FMetaData := TMetaDataContainer.New(ENTIDADE.Connection);
  FConfiguradorMetaData := TConfiguradorMetaData.New(FMetaData.ENTIDADE, FMetaData.EntPropriedade);

  ENTIDADE.Open();
  ENT_PROPRIEDADE.Open();
  TABELAS.Open();
  CAMPOS.Open();
  ENTIDADE.Connection
end;

procedure TffwConfigEntidade.actLerEstruturaDoBancoExecute(Sender: TObject);
var
  _idProp: integer;
begin
  inherited;
  CriarIndiceENTIDADE(ENTIDADE);
  TABELAS.Open();
  TABELAS.First;
  _idProp := 0;
  while not TABELAS.Eof do
  begin
    if not ENTIDADE.FindKey([TABELASTABLE_NAME.AsString]) then
    begin
      ENTIDADE.Insert;
      ENTIDADENOME.AsString := TABELASTABLE_NAME.AsString;
      ENTIDADEDESCRICAO.AsString := TABELASTABLE_NAME.AsString;
      ENTIDADE.Post;
      ENTIDADE.ApplyUpdates(0);
      ENTIDADE.CommitUpdates;
    end;

    CAMPOS.Close;
    CAMPOS.ObjectName := TABELASTABLE_NAME.AsString;
    CAMPOS.Open();
    CAMPOS.First;
    CriarIndiceENT_PROPRIEDADE(ENT_PROPRIEDADE);

    while not CAMPOS.Eof do
    begin
      dec(_idProp);

      if not ENT_PROPRIEDADE.FindKey([ENTIDADEID.AsInteger, CAMPOSCOLUMN_NAME.AsString]) then
      begin
        ENT_PROPRIEDADE.Insert;

        ENT_PROPRIEDADEID.AsInteger := _idProp;

        ENT_PROPRIEDADEENTIDADE_ID.AsInteger := ENTIDADEID.AsInteger;

        ENT_PROPRIEDADENOME.AsString := CAMPOSCOLUMN_NAME.AsString;

        ENT_PROPRIEDADEPOSICAO.AsInteger := CAMPOSCOLUMN_POSITION.AsInteger;

        ENT_PROPRIEDADEDESCRICAO.AsString := CAMPOSCOLUMN_NAME.AsString;

        ENT_PROPRIEDADEVISIVEL.AsString := BOOLEAN_TRUE;

        if CAMPOSCOLUMN_LENGTH.AsInteger = 0 then
          ENT_PROPRIEDADETAMANHO_DISPLAY.AsInteger := INTEIRO_INDEFINIDO
        else
          ENT_PROPRIEDADETAMANHO_DISPLAY.AsInteger := CAMPOSCOLUMN_LENGTH.AsInteger;

        DefinirAtributos;

        ENT_PROPRIEDADE.Post;

      end;
      CAMPOS.Next;
    end;

    ENT_PROPRIEDADE.ApplyUpdates(0);
    ENT_PROPRIEDADE.CommitUpdates;
    TABELAS.Next;
  end;
end;

procedure TffwConfigEntidade.CriarIndiceENTIDADE(AQuery: TFDDataSet);
const
  idx_name = 'IDX_ENTIDADE';
var
  _index: TFDIndex;
begin
  if AQuery.IndexName.Equals(idx_name) then
    exit;

  AQuery.Indexes.FindIndex(idx_name);
  _index := AQuery.Indexes.Add;
  _index.Name := idx_name;
  _index.Fields := 'NOME';
  _index.Selected := True;
  _index.Active := True;

  AQuery.IndexesActive := False;

  AQuery.IndexName := idx_name;
end;

procedure TffwConfigEntidade.CriarIndiceENT_PROPRIEDADE(AQuery: TFDDataSet);
const
  idx_name = 'IDX_ENT_PROPRIEDADE';
var
  _index: TFDIndex;
begin
  if AQuery.IndexName.Equals(idx_name) then
    exit;

  AQuery.Indexes.FindIndex(idx_name);
  _index := AQuery.Indexes.Add;
  _index.Name := idx_name;
  _index.Fields := 'ENTIDADE_ID;NOME';
  _index.Selected := True;
  _index.Active := True;

  AQuery.IndexesActive := False;

  AQuery.IndexName := idx_name;
end;

procedure TffwConfigEntidade.DefinirAtributos;
var
  _attr: integer;
  _dataAttributes: TFDDataAttributes;
begin
  _attr := CAMPOSCOLUMN_ATTRIBUTES.Value;
  _dataAttributes := TFDDataAttributes(Pointer(@_attr)^);

  if caAllowNull in _dataAttributes then
    ENT_PROPRIEDADEREQUERIDO.AsString := BOOLEAN_TRUE
  else
    ENT_PROPRIEDADEREQUERIDO.AsString := BOOLEAN_FALSE;

  if caReadOnly in _dataAttributes then
    ENT_PROPRIEDADESOMENTE_LEITURA.AsString := BOOLEAN_TRUE
  else
    ENT_PROPRIEDADESOMENTE_LEITURA.AsString := BOOLEAN_FALSE;
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
