unit OMestreDosCodigos.UI.frmPerguntasAlternativas;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  umcCrudToolbar, umcFDCrudToolbar, umcFrmConsulta, umcFDCRUD,
  GeradorSQL.Comp.Select,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls;

type
  TfrmPerguntasAlternativas = class(TfmcFDCRUD)
    qryPerguntas: TFDQuery;
    qryAlternativas: TFDQuery;
    mcsPerguntas: TMCSelect;
    mcsAlternativas: TMCSelect;
    qryPerguntasID: TFDAutoIncField;
    qryPerguntasPESQUISA_ID: TIntegerField;
    qryPerguntasDESCRICAO: TStringField;
    qryPerguntasPESQUISA_DESC: TStringField;
    Panel1: TPanel;
    Label1: TLabel;
    ID: TDBEdit;
    PESQUISA_ID: TDBEdit;
    Label3: TLabel;
    DESCRICAO: TDBEdit;
    Label4: TLabel;
    PESQUISA_DESC: TDBEdit;
    dsAlternativas: TDataSource;
    FDSchemaAdapter: TFDSchemaAdapter;
    pnlGrade: TPanel;
    grdAlternativas: TDBGrid;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure qryPerguntasAfterOpen(DataSet: TDataSet);
    procedure qryAlternativasAfterOpen(DataSet: TDataSet);
    procedure qryAlternativasBeforeInsert(DataSet: TDataSet);
    procedure qryAlternativasBeforeEdit(DataSet: TDataSet);
    procedure dsAlternativasStateChange(Sender: TObject);
    procedure qryAlternativasAfterPost(DataSet: TDataSet);
    procedure qryAlternativasAfterDelete(DataSet: TDataSet);
  private
    function PodeAlterarAlternativas: boolean;
  protected
    procedure AntesSelecionar(const ADataSetPesquisa: TDataSet; var AContinuar: boolean); override;
  end;

implementation

{$R *.dfm}

uses
  OMestreDosCodigos.UI.frmMenu, umcFormFactory, umcConsulta;

procedure TfrmPerguntasAlternativas.AntesSelecionar(const ADataSetPesquisa: TDataSet; var AContinuar: boolean);
begin
  inherited;
  AContinuar := false;

  if ADataSetPesquisa.IsEmpty then
    exit;

  qryPerguntas.Close;
  qryPerguntas.Params[0].AsInteger := ADataSetPesquisa.FieldByName('ID').AsInteger;
  qryPerguntas.Open();

  AContinuar := not qryPerguntas.IsEmpty;
end;

procedure TfrmPerguntasAlternativas.dsAlternativasStateChange(Sender: TObject);
begin
  inherited;
  dsDataSet.OnStateChange(dsDataSet);
end;

procedure TfrmPerguntasAlternativas.FormCreate(Sender: TObject);
begin
  inherited;
  qryPerguntas.Close;
  qryAlternativas.Close;

  qryPerguntas.SQL.Text := mcsPerguntas.GerarSQL;
  qryAlternativas.SQL.Text := mcsAlternativas.GerarSQL;
end;

function TfrmPerguntasAlternativas.PodeAlterarAlternativas: boolean;
begin
  result := not(qryPerguntas.UpdateStatus = usInserted);
end;

procedure TfrmPerguntasAlternativas.qryAlternativasAfterDelete(DataSet: TDataSet);
begin
  inherited;
  dsDataSet.OnStateChange(dsDataSet);
end;

procedure TfrmPerguntasAlternativas.qryAlternativasAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ConfiguradorMetaData.setConfigurarDataSet(DataSet, [mcsAlternativas.From.Nome]);
end;

procedure TfrmPerguntasAlternativas.qryAlternativasAfterPost(DataSet: TDataSet);
begin
  inherited;
  dsDataSet.OnStateChange(dsDataSet);
end;

procedure TfrmPerguntasAlternativas.qryAlternativasBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if not PodeAlterarAlternativas then
    Abort;
end;

procedure TfrmPerguntasAlternativas.qryAlternativasBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if not PodeAlterarAlternativas then
    Abort;
end;

procedure TfrmPerguntasAlternativas.qryPerguntasAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ConfiguradorMetaData.setConfigurarDataSet(DataSet, [mcsPerguntas.From.Nome]);
  qryAlternativas.Open();
end;

initialization

RegisterClass(TfrmPerguntasAlternativas);

end.
