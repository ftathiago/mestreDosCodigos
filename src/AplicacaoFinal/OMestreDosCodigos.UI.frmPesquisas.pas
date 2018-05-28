unit OMestreDosCodigos.UI.frmPesquisas;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  umcFDCRUD,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, GeradorSQL.Comp.Select, umcCrudToolbar, umcFDCrudToolbar, umcFrmConsulta,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmCadPesquisa = class(TfmcFDCRUD)
    qryDataSet: TFDQuery;
    mcsDataSet: TMCSelect;
    Label1: TLabel;
    ID: TDBEdit;
    Label2: TLabel;
    DESCRICAO: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    DATA_INICIO: TDBEdit;
    Label5: TLabel;
    DATA_FIM: TDBEdit;
    ATIVA: TDBCheckBox;
    DBText1: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure qryPesquisaAfterOpen(DataSet: TDataSet);
    procedure qryDataSetNewRecord(DataSet: TDataSet);
    procedure fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataSet.Constantes;

procedure TfrmCadPesquisa.fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
begin
  inherited;
  qryDataSet.Close;
  qryDataSet.Params[0].AsInteger := qryPesquisa.FieldByName('ID').AsInteger;
  qryDataSet.Open();
end;

procedure TfrmCadPesquisa.FormCreate(Sender: TObject);
begin
  inherited;
  qryPesquisa.Close;
  qryPesquisa.SQL.Text := mcsPesquisa.GerarSQL;
  qryPesquisa.Open();

  qryDataSet.Close;
  qryDataSet.SQL.Text := mcsDataSet.GerarSQL;
end;

procedure TfrmCadPesquisa.qryDataSetNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('DATA_CADASTRO').AsDateTime := Now;
  DataSet.FieldByName('DATA_INICIO').AsDateTime := Now;
  DataSet.FieldByName('ATIVA').AsString := BOOLEAN_TRUE;
end;

procedure TfrmCadPesquisa.qryPesquisaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ConfiguradorMetaData.setConfigurarDataSet(DataSet, [mcsDataSet.From.Nome]);
end;

initialization

RegisterClass(TfrmCadPesquisa);

end.
