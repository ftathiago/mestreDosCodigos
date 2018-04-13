program OMestreDosCodigos;

uses
  Vcl.Forms,
  uFrmMenu in 'uFrmMenu.pas' {Form1},
  umcForm in '..\FrameWork\MCFWForms\umcForm.pas' {fmcForm},
  uFrmArrayClientes in 'uFrmArrayClientes.pas' {fmcForm1},
  uCliente in 'uCliente.pas',
  uICliente in 'uICliente.pas',
  pkgUtils.Intf.EMail in '..\pkgUtils\pkgUtils.Intf.EMail.pas',
  pkgUtils.Intf.Telefone in '..\pkgUtils\pkgUtils.Intf.Telefone.pas',
  pkgUtils.Intf.Comparavel in '..\pkgUtils\pkgUtils.Intf.Comparavel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
