unit ExecSQL.Controller.Impl.frmInicial;

interface

uses
  Data.DB, FireDac.Comp.Client, MVC.Anotacoes.View, MVC.Impl.Controller, ExecSQL.Controller.Intf.frmInicial,
  ExecSQL.View.Impl.frmListaObjetos, ExecSQL.Controller.Intf.frmListaObjetos;

type

  [TView('TfrmInicialView')]
  TfrmInicialController = class(TController, IfrmInicialController)
  private
    FfrmListaObjetosController: IfrmListaObjetosController;
  public
    constructor Create; override;
    procedure DefinirConexao(const AConexao: TCustomConnection); override;
    function frmListaObjetosController: IfrmListaObjetosController;
    procedure AposCriarAView; override;
  end;

implementation

uses
  Vcl.Forms, MVC.RegistroDeClasses, MVC.Intf.ControlaExibicao, MVC.Intf.View, MVC.Impl.View,
  ExecSQL.Controller.Impl.frmListaObjetos;

{ TfrmInicialController }

procedure TfrmInicialController.AposCriarAView;
begin
  inherited;
  frmListaObjetosController.AposCriarAView;
end;

constructor TfrmInicialController.Create;
begin
  inherited;
  FfrmListaObjetosController := TfrmListaObjetosController.New;
end;

procedure TfrmInicialController.DefinirConexao(const AConexao: TCustomConnection);
begin
  inherited;
  FfrmListaObjetosController.DefinirConexao(RetornarConexao);
end;

function TfrmInicialController.frmListaObjetosController: IfrmListaObjetosController;
begin
  result := FfrmListaObjetosController;
end;

initialization

RegistrarController(TfrmInicialController);

end.
