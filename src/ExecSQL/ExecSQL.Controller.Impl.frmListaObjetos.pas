unit ExecSQL.Controller.Impl.frmListaObjetos;

interface

uses
  Data.DB, FireDac.Comp.Client, MVC.RegistroDeClasses, MVC.Impl.Controller, ExecSQL.Controller.Intf.frmListaObjetos;

type
  TfrmListaObjetosController = class(TController, IfrmListaObjetosController)
  private
    FqrySP: TFDMetaInfoQuery;
    FqryTabela: TFDMetaInfoQuery;
    FqryCampos: TFDMetaInfoQuery;
  protected
    function qrySP: TFDMetaInfoQuery;
    function qryTabela: TFDMetaInfoQuery;
    function qryCampos: TFDMetaInfoQuery;
  public
    class function New: IfrmListaObjetosController;
    procedure LocalizarCampo(const ANomeCampo: string);
    procedure LocalizarStoredProcedure(const ANomeSP: string);
    procedure LocalizarTabela(const ANomeTabela: string);
    procedure MostrarCamposDaTabela(const ANomeDaTabela: string);
    function LabelPadraoPesquisa: string;
    procedure AposCriarAView; override;
  end;

implementation

uses
  System.Classes, System.SysUtils;

const
  PESQUISAR_CAPTION = 'Pesquisar...';

procedure TfrmListaObjetosController.AposCriarAView;
begin
  inherited;
  qryTabela.Open();
  qrySP.Open();
end;

function TfrmListaObjetosController.LabelPadraoPesquisa: string;
begin
  result := PESQUISAR_CAPTION;
end;

procedure TfrmListaObjetosController.LocalizarCampo(const ANomeCampo: string);
begin
  if SameText(PESQUISAR_CAPTION, ANomeCampo) then
    exit;

  qryCampos.Locate('COLUMN_NAME', ANomeCampo, [loPartialKey]);
end;

procedure TfrmListaObjetosController.LocalizarStoredProcedure(const ANomeSP: string);
begin
  if SameText(PESQUISAR_CAPTION, ANomeSP) then
    exit;

  qrySP.Locate('PROC_NAME', ANomeSP, [loPartialKey]);
end;

procedure TfrmListaObjetosController.LocalizarTabela(const ANomeTabela: string);
begin
  if SameText(PESQUISAR_CAPTION, ANomeTabela) then
    exit;

  qryTabela.Locate('TABLE_NAME', ANomeTabela, [loPartialKey]);
end;

procedure TfrmListaObjetosController.MostrarCamposDaTabela(const ANomeDaTabela: string);
begin
  qryCampos.ObjectName := ANomeDaTabela;

  if not qryCampos.Active then
    qryCampos.Open;
end;

class function TfrmListaObjetosController.New: IfrmListaObjetosController;
begin
  result := Create;
end;

function TfrmListaObjetosController.qryCampos: TFDMetaInfoQuery;
begin
  if not Assigned(FqryCampos) then
    FqryCampos := View.FindComponent('qryCampos') as TFDMetaInfoQuery;

  result := FqryCampos;
end;

function TfrmListaObjetosController.qrySP: TFDMetaInfoQuery;
begin
  if not Assigned(FqrySP) then
    FqrySP := View.FindComponent('qrySP') as TFDMetaInfoQuery;

  result := FqrySP;
end;

function TfrmListaObjetosController.qryTabela: TFDMetaInfoQuery;
begin
  if not Assigned(FqryTabela) then
    FqryTabela := View.FindComponent('qryTabelas') as TFDMetaInfoQuery;

  result := FqryTabela;
end;

initialization

RegistrarController(TfrmListaObjetosController);

end.
