program ExecSQL;

uses
  Vcl.Forms,
  ExecSQL.View.Impl.frmInicial in 'ExecSQL.View.Impl.frmInicial.pas' {frmInicialView},
  UI.frmSQL in 'UI.frmSQL.pas' {frmSQL: TFrame},
  ExecSQL.View.Impl.frmListaObjetos in 'ExecSQL.View.Impl.frmListaObjetos.pas' {frmListaObjetosView: TFrame},
  ExecSQL.UI.frmPrincipal in 'ExecSQL.UI.frmPrincipal.pas' {frmPrincipal},
  ExecSQL.Controller.Impl.frmPesquisaSQL in 'ExecSQL.Controller.Impl.frmPesquisaSQL.pas',
  ExecSQL.Controller.Intf.frmPesquisaSQL in 'ExecSQL.Controller.Intf.frmPesquisaSQL.pas',
  ExecSQL.Controller.Intf.frmListaObjetos in 'ExecSQL.Controller.Intf.frmListaObjetos.pas',
  ExecSQL.Controller.Impl.frmListaObjetos in 'ExecSQL.Controller.Impl.frmListaObjetos.pas',
  ExecSQL.Controller.Intf.frmInicial in 'ExecSQL.Controller.Intf.frmInicial.pas',
  ExecSQL.Controller.Impl.frmInicial in 'ExecSQL.Controller.Impl.frmInicial.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
