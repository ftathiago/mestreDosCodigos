unit OMestreDosCodigos.UI.frmConstPesquisa;

interface

uses
  umcConsulta, GeradorSQL.Comp.Collection.Condicao,
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, umcFrmConsulta, GeradorSQL.Comp.Select, Vcl.Grids, Vcl.DBGrids;

type
  TfrmConsPesquisa = class(TfmcConsulta)
    qryPesquisa: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure fmcFrmConsultaSelecionarCampoParaPesquisa(Column: TColumn);
    procedure qryPesquisaAfterOpen(DataSet: TDataSet);
    procedure fmcFrmConsultaPesquisar(const Conteudo: string; const Campo: TField);
  private
    procedure PrepararSQL(const ACampo: TField); virtual;
    procedure Pesquisar; overload;
    procedure Pesquisar(const Conteudo: string; const Campo: TField); overload;
    procedure DefinirOperadorComparacao(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);
    procedure DefinirParametroPesquisa(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);

  public
  end;

implementation

{$R *.dfm}

uses
  SQL.Enums, DataSet.Constantes;

procedure TfrmConsPesquisa.DefinirOperadorComparacao(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);
begin
  ACondicao.Condicao.OperadorComparacao := ocIgual;
  if ACampo.DataType in FieldTypeString then
  begin
    if ACampo.Size > 1 then
      ACondicao.Condicao.OperadorComparacao := ocContenha;
  end;
end;

procedure TfrmConsPesquisa.DefinirParametroPesquisa(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);
const
  FORMATO_PARAMETRO = ':%s';
begin
  ACondicao.Condicao.Valor := Format(FORMATO_PARAMETRO, [ACampo.FieldName]);
end;

procedure TfrmConsPesquisa.fmcFrmConsultaPesquisar(const Conteudo: string; const Campo: TField);
begin
  inherited;
  Pesquisar(Conteudo, Campo);
end;

procedure TfrmConsPesquisa.fmcFrmConsultaSelecionarCampoParaPesquisa(Column: TColumn);
begin
  inherited;
  if qryPesquisa.Active then
    qryPesquisa.IndexFieldNames := Column.Field.FieldName;
end;

procedure TfrmConsPesquisa.FormCreate(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmConsPesquisa.Pesquisar(const Conteudo: string; const Campo: TField);
var
  _fieldName: string;
begin
  inherited;
  PrepararSQL(Campo);

  _fieldName := Campo.FieldName;
  qryPesquisa.Close;
  qryPesquisa.SQL.Text := selPesquisa.GerarSQL;

  qryPesquisa.ParamByName(_fieldName).Value := Conteudo;
  if selPesquisa.Condicao.Items[0].Condicao.OperadorComparacao = ocContenha then
    qryPesquisa.ParamByName(_fieldName).Value := Format('%%%s%%', [Conteudo]);

  qryPesquisa.Open;
end;

procedure TfrmConsPesquisa.PrepararSQL(const ACampo: TField);
var
  _condicao: TCondicaoCollectionItem;
begin
  selPesquisa.Condicao.Clear;

  _condicao := selPesquisa.Condicao.Add as TCondicaoCollectionItem;

  _condicao.Condicao.Coluna.Nome := ACampo.FieldName;

  DefinirOperadorComparacao(ACampo, _condicao);
  DefinirParametroPesquisa(ACampo, _condicao);
end;

procedure TfrmConsPesquisa.Pesquisar;
begin
  qryPesquisa.Close;
  qryPesquisa.SQL.Text := selPesquisa.GerarSQL;
  qryPesquisa.Open();
end;

procedure TfrmConsPesquisa.qryPesquisaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ConfiguradorMetaData.setConfigurarDataSet(DataSet, [selPesquisa.From.Nome.ToUpper]);
end;

initialization

RegisterClass(TfrmConsPesquisa);

end.
