unit ufwConfigEntidade;

interface

uses
  ufwPrincipal,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  ufwForm,
  Data.DB,
  umcCrudToolbar,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
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
  Vcl.ComCtrls,
  Vcl.ToolWin,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList;

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
    ToolButton2: TToolButton;
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
    ENT_PROPRIEDADEID: TIntegerField;
    ENT_PROPRIEDADEENTIDADE_ID: TIntegerField;
    ENT_PROPRIEDADENOME: TStringField;
    ENT_PROPRIEDADEDESCRICAO: TStringField;
    ENT_PROPRIEDADETAMANHO: TIntegerField;
    ENT_PROPRIEDADECASAS_DECIMAIS: TIntegerField;
    ENT_PROPRIEDADEREQUERIDO: TStringField;
    ENT_PROPRIEDADESOMENTE_LEITURA: TStringField;
    ENTIDADE: TFDQuery;
    ENTIDADEID: TFDAutoIncField;
    ENTIDADENOME: TStringField;
    ENTIDADEDESCRICAO: TStringField;
    procedure CrudToolbarSalvarClick(const DataSet: TDataSet);
    procedure CrudToolbarDesfazerClick(const DataSet: TDataSet);
    procedure actLerEstruturaDoBancoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdENTIDADEEnter(Sender: TObject);
  private
    { Private declarations }
    procedure CriarIndiceENTIDADE(AQuery: TFDCustomQuery);
    procedure CriarIndiceENT_PROPRIEDADE(AQuery: TFDCustomQuery);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


procedure TffwConfigEntidade.actLerEstruturaDoBancoExecute(Sender: TObject);
var
  _id: integer;
  _idProp: integer;
begin
  inherited;
  CriarIndiceENTIDADE(ENTIDADE);
  TABELAS.Open();
  TABELAS.First;
  _id := 0;
  _idProp := 0;
  while not TABELAS.Eof do
  begin
    if not ENTIDADE.FindKey([TABELASTABLE_NAME.AsString]) then
    begin
      dec(_id);
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
        ENT_PROPRIEDADENOME.AsString :=
          CAMPOSCOLUMN_NAME.AsString;
        ENT_PROPRIEDADEDESCRICAO.AsString :=
          CAMPOSCOLUMN_NAME.AsString;
        ENT_PROPRIEDADETAMANHO.AsInteger :=
          CAMPOSCOLUMN_LENGTH.AsInteger;
        ENT_PROPRIEDADECASAS_DECIMAIS.AsInteger :=
          CAMPOSCOLUMN_PRECISION.AsInteger;
        ENT_PROPRIEDADEREQUERIDO.AsString := 'N';
        ENT_PROPRIEDADESOMENTE_LEITURA.AsString := 'S';

        ENT_PROPRIEDADE.Post;

      end;
      CAMPOS.Next;
    end;

    ENT_PROPRIEDADE.ApplyUpdates(0);
    ENT_PROPRIEDADE.CommitUpdates;
    TABELAS.Next;
  end;
end;

procedure TffwConfigEntidade.CriarIndiceENTIDADE(AQuery: TFDCustomQuery);
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

procedure TffwConfigEntidade.CriarIndiceENT_PROPRIEDADE(AQuery: TFDCustomQuery);
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

procedure TffwConfigEntidade.FormCreate(Sender: TObject);
begin
  inherited;
  ENTIDADE.Open();
  ENT_PROPRIEDADE.Open();
  TABELAS.Open();
  CAMPOS.Open();

  ENTIDADE.SaveToFile(ExtractFilePath(Application.ExeName)+ Entidade.Name);
  ENT_PROPRIEDADE.SaveToFile(ExtractFilePath(Application.ExeName)+ ENT_PROPRIEDADE.Name);
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
