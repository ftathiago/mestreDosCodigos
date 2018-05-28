unit umcCRUD;

interface

uses
  umcFDCrudToolbar, umcFrmConsulta, umcDBForm, umcCrudToolbar, umcFrameWorkTypes,
  DataSet.Intf.ConfiguradorMetaData,
  GeradorSQL.Comp.Collection.Condicao, GeradorSQL.Comp.Select,
  System.SysUtils, System.Classes, System.Generics.Collections, System.Actions, System.ImageList,
  Vcl.Forms, Vcl.ComCtrls, Vcl.Controls, Vcl.ToolWin, Vcl.ActnList, Vcl.ImgList, Data.DB;

type
  TDataSetEventoCancelavel = procedure(const ADataSet: TDataSet; var AContinuar: boolean) of object;

  TfmcCRUD = class(TfmcDBForm)
    pgcCrud: TPageControl;
    tbsPesquisa: TTabSheet;
    tbsCadastro: TTabSheet;
    fmcFrmConsulta: TfmcFrmConsulta;
    CrudToolbar: TumcFDCrudToolbar;
    dsPesquisa: TDataSource;
    mcsPesquisa: TMCSelect;
    procedure fmcFrmConsultaNovoClick(const DataSet: TDataSet);
    procedure fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
    procedure fmcFrmConsultaFecharClick(const DataSet: TDataSet);
    procedure fmcFrmConsultaPesquisar(const Conteudo: string; const Campo: TField);
  private
    procedure ExecutarAcao(const ADataSet: TDataSet; const ProcAcao: TProc; const EventoAntes: TDataSetEventoCancelavel;
      const EventoApos: TDataSetNotifyEvent);
    procedure DefinirOperadorComparacao(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);
    procedure DefinirParametroPesquisa(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);
  protected

    procedure PrepararSQL(const ACampo: TField); virtual;
    procedure Pesquisar(const Conteudo: string; const Campo: TField); virtual;

    procedure NovoRegistro; virtual;
    procedure AntesNovoRegistro(const ADataSet: TDataSet; var AContinuar: boolean); virtual;
    procedure AposNovoRegistro(ADataSet: TDataSet); virtual;

    procedure Selecionar; virtual;
    procedure AntesSelecionar(const ADataSetPesquisa: TDataSet; var AContinuar: boolean); virtual;
    procedure AposSelecionar(ADataSetPesquisa: TDataSet); virtual;
  public
    procedure AfterConstruction; override;
  end;

var
  fmcCRUD: TfmcCRUD;

implementation

{$R *.dfm}

uses
  SQL.Enums, DataSet.Constantes;

procedure TfmcCRUD.AfterConstruction;
begin
  inherited;
  pgcCrud.ActivePage := tbsPesquisa;
end;

procedure TfmcCRUD.AntesNovoRegistro(const ADataSet: TDataSet; var AContinuar: boolean);
begin

end;

procedure TfmcCRUD.AntesSelecionar(const ADataSetPesquisa: TDataSet; var AContinuar: boolean);
begin

end;

procedure TfmcCRUD.AposNovoRegistro(ADataSet: TDataSet);
begin

end;

procedure TfmcCRUD.AposSelecionar(ADataSetPesquisa: TDataSet);
begin

end;

procedure TfmcCRUD.DefinirOperadorComparacao(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);
begin
  ACondicao.Condicao.OperadorComparacao := ocIgual;
  if ACampo.DataType in FieldTypeString then
  begin
    if ACampo.Size > 1 then
      ACondicao.Condicao.OperadorComparacao := ocContenha;
  end;
end;

procedure TfmcCRUD.fmcFrmConsultaFecharClick(const DataSet: TDataSet);
begin
  inherited;
  Close;
end;

procedure TfmcCRUD.fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
begin
  inherited;
  Selecionar;
end;

procedure TfmcCRUD.fmcFrmConsultaNovoClick(const DataSet: TDataSet);
begin
  inherited;
  NovoRegistro;
end;

procedure TfmcCRUD.fmcFrmConsultaPesquisar(const Conteudo: string; const Campo: TField);
begin
  inherited;
  Pesquisar(Conteudo, Campo);
end;

procedure TfmcCRUD.NovoRegistro;
begin
  ExecutarAcao(dsDataSet.DataSet,
    procedure
    begin
      if not dsDataSet.DataSet.Active then
        dsDataSet.DataSet.Open;

      dsDataSet.DataSet.Insert;
      pgcCrud.ActivePage := tbsCadastro;
    end, AntesNovoRegistro, AposNovoRegistro);
end;

procedure TfmcCRUD.Pesquisar(const Conteudo: string; const Campo: TField);
begin
  PrepararSQL(Campo);
end;

procedure TfmcCRUD.DefinirParametroPesquisa(const ACampo: TField; const ACondicao: TCondicaoCollectionItem);
const
  FORMATO_PARAMETRO = ':%s';
begin
  ACondicao.Condicao.Valor := Format(FORMATO_PARAMETRO, [ACampo.FieldName]);
end;

procedure TfmcCRUD.PrepararSQL(const ACampo: TField);
var
  _condicao: TCondicaoCollectionItem;
begin
  mcsPesquisa.Condicao.Clear;

  _condicao := mcsPesquisa.Condicao.Add as TCondicaoCollectionItem;

  _condicao.Condicao.Coluna.Nome := ACampo.FieldName;

  DefinirOperadorComparacao(ACampo, _condicao);
  DefinirParametroPesquisa(ACampo, _condicao);
end;

procedure TfmcCRUD.Selecionar;
begin
  ExecutarAcao(dsPesquisa.DataSet,
    procedure
    begin
      pgcCrud.ActivePage := tbsCadastro;
    end, AntesSelecionar, AposSelecionar);
end;

procedure TfmcCRUD.ExecutarAcao(const ADataSet: TDataSet; const ProcAcao: TProc;
const EventoAntes: TDataSetEventoCancelavel; const EventoApos: TDataSetNotifyEvent);
var
  _podeContinuar: boolean;
begin
  _podeContinuar := True;

  EventoAntes(ADataSet, _podeContinuar);

  if not _podeContinuar then
    exit;

  ProcAcao;

  EventoApos(ADataSet);
end;

end.
