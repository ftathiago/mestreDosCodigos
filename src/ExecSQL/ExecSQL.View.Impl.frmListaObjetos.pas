unit ExecSQL.View.Impl.frmListaObjetos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  MVC.Impl.View.FrameView, ExecSQL.Controller.Intf.frmListaObjetos,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait;

type
  TfrmListaObjetosView = class(TFrameView)
    ListaObjetosDados: TCategoryPanelGroup;
    ListaTabelas: TCategoryPanel;
    GridTabelas: TDBGrid;
    edtPesquisarTabelas: TEdit;
    ListaCampos: TCategoryPanel;
    DBGrid2: TDBGrid;
    edtPesquisarCampos: TEdit;
    ListaStoredProcedures: TCategoryPanel;
    DBGrid3: TDBGrid;
    edtPesquisarSP: TEdit;
    qryCampos: TFDMetaInfoQuery;
    qrySP: TFDMetaInfoQuery;
    qryTabelas: TFDMetaInfoQuery;
    dtsTabelas: TDataSource;
    MestredoscodigosConnection: TFDConnection;
    dtsCampos: TDataSource;
    dtsSP: TDataSource;
    procedure edtPesquisarTabelasChange(Sender: TObject);
    procedure edtPesquisarCamposChange(Sender: TObject);
    procedure edtPesquisarSPChange(Sender: TObject);
    procedure qryTabelasAfterScroll(DataSet: TDataSet);
  private
  protected
    function Controller: IfrmListaObjetosController; reintroduce;
  end;

implementation

{$R *.dfm}

function TfrmListaObjetosView.Controller: IfrmListaObjetosController;
begin
  result := (inherited Controller) as IfrmListaObjetosController;
end;

procedure TfrmListaObjetosView.edtPesquisarCamposChange(Sender: TObject);
begin
  if String(edtPesquisarCampos.Text).Trim.IsEmpty then
  begin
    edtPesquisarCampos.Text := Controller.LabelPadraoPesquisa;
    exit;
  end;

  if SameText(edtPesquisarCampos.Text, Controller.LabelPadraoPesquisa) then
    exit;

  Controller.LocalizarCampo(edtPesquisarCampos.Text);
end;

procedure TfrmListaObjetosView.edtPesquisarSPChange(Sender: TObject);
begin
  if String(edtPesquisarSP.Text).Trim.IsEmpty then
  begin
    edtPesquisarSP.Text := Controller.LabelPadraoPesquisa;
    exit;
  end;

  if SameText(edtPesquisarSP.Text, Controller.LabelPadraoPesquisa) then
    exit;

  Controller.LocalizarStoredProcedure(edtPesquisarSP.Text);
end;

procedure TfrmListaObjetosView.edtPesquisarTabelasChange(Sender: TObject);
begin
  if String(edtPesquisarTabelas.Text).Trim.IsEmpty then
  begin
    edtPesquisarTabelas.Text := Controller.LabelPadraoPesquisa;
    exit;
  end;

  if SameText(edtPesquisarTabelas.Text, Controller.LabelPadraoPesquisa) then
    exit;

  Controller.LocalizarTabela(edtPesquisarTabelas.Text);
end;

procedure TfrmListaObjetosView.qryTabelasAfterScroll(DataSet: TDataSet);
begin
  inherited;
  Controller.MostrarCamposDaTabela(qryTabelas.FieldByName('TABLE_NAME').AsString);
end;

initialization

RegisterClass(TfrmListaObjetosView);

end.
