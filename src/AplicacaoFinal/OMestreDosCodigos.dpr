program OMestreDosCodigos;

uses
  Vcl.Forms,
  OMestreDosCodigos.UI.frmMenu in 'OMestreDosCodigos.UI.frmMenu.pas' {frmMenu},
  umcForm in '..\FrameWork\MCFWForms\umcForm.pas' {fmcForm},
  OMestreDosCodigos.UI.frmArrayClientes in 'OMestreDosCodigos.UI.frmArrayClientes.pas' {frmArrayClientes},
  OMestreDosCodigos.Impl.Cliente in 'OMestreDosCodigos.Impl.Cliente.pas',
  pkgUtils.Intf.EMail in '..\pkgUtils\pkgUtils.Intf.EMail.pas',
  pkgUtils.Intf.Telefone in '..\pkgUtils\pkgUtils.Intf.Telefone.pas',
  OMestreDosCodigos.Impl.Cliente.Builder in 'OMestreDosCodigos.Impl.Cliente.Builder.pas',
  OMestreDosCodigos.Intf.Cliente in 'OMestreDosCodigos.Intf.Cliente.pas',
  OMestreDosCodigos.Intf.Cliente.Builder in 'OMestreDosCodigos.Intf.Cliente.Builder.pas',
  OMestreDosCodigos.Intf.Cliente.ListaArrayDinamico in 'OMestreDosCodigos.Intf.Cliente.ListaArrayDinamico.pas',
  OMestreDosCodigos.Impl.Cliente.ListaArrayDinamico in 'OMestreDosCodigos.Impl.Cliente.ListaArrayDinamico.pas',
  MetaDataConf.UI.ffwForm in '..\MetaDataConf\MetaDataConf.UI.ffwForm.pas' {ffwForm},
  MetaDataConf.UI.ffwConfigEntidade in '..\MetaDataConf\MetaDataConf.UI.ffwConfigEntidade.pas' {ffwConfigEntidade},
  MetaDataConf.UI.ffwConfigEntidade.Relatorio in '..\MetaDataConf\MetaDataConf.UI.ffwConfigEntidade.Relatorio.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
