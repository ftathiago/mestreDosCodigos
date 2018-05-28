unit umcFDCRUD;

interface

uses
  umcCrudToolbar, umcFDCrudToolbar, umcCRUD, umcFrmConsulta,
  GeradorSQL.Comp.Select,
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfmcFDCRUD = class(TfmcCRUD)
    qryPesquisa: TFDQuery;
    procedure qryPesquisaAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure fmcFrmConsultaSelecionarCampoParaPesquisa(Column: TColumn);
  private
  protected
    procedure Pesquisar(const Conteudo: string; const Campo: TField); override;
    procedure SetConnection(const AConexao: TCustomConnection); override;
    function getConexao: TFDConnection; reintroduce;
  public
    { Public declarations }
  end;

var
  fmcFDCRUD: TfmcFDCRUD;

implementation

{$R *.dfm}

uses
  SQL.Enums, umcConstantes;

procedure TfmcFDCRUD.fmcFrmConsultaSelecionarCampoParaPesquisa(Column: TColumn);
begin
  inherited;
  if qryPesquisa.Active then
    qryPesquisa.IndexFieldNames := Column.Field.FieldName;
end;

procedure TfmcFDCRUD.FormCreate(Sender: TObject);
begin
  inherited;
  qryPesquisa.Close;
  qryPesquisa.SQL.Text := mcsPesquisa.GerarSQL;
  qryPesquisa.Open();
end;

function TfmcFDCRUD.getConexao: TFDConnection;
begin
  result := inherited getConexao as TFDConnection;
end;

procedure TfmcFDCRUD.Pesquisar(const Conteudo: string; const Campo: TField);
var
  _fieldName: string;
begin
  inherited;
  _fieldName := Campo.FieldName;
  qryPesquisa.Close;
  qryPesquisa.SQL.Text := mcsPesquisa.GerarSQL;

  qryPesquisa.ParamByName(_fieldName).Value := Conteudo;
  if mcsPesquisa.Condicao.Items[0].Condicao.OperadorComparacao = ocContenha then
    qryPesquisa.ParamByName(_fieldName).Value := Format('%%%s%%', [Conteudo]);

  qryPesquisa.Open;
end;

procedure TfmcFDCRUD.qryPesquisaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ConfiguradorMetaData.setConfigurarDataSet(DataSet, [mcsPesquisa.From.Nome.ToUpper]);
end;

procedure TfmcFDCRUD.setConnection(const AConexao: TCustomConnection);
var
  _conexao: TFDConnection;
  i: Integer;
begin
  inherited;
  _conexao := AConexao as TFDConnection;

  for i := 0 to Pred(ComponentCount) do
  begin
    if Components[i].InheritsFrom(TFDRdbmsDataSet) then
      (Components[i] as TFDRdbmsDataSet).Connection := _conexao;
  end;
end;

end.
