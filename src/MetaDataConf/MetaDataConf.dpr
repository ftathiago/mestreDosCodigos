program MetaDataConf;

uses
  Vcl.Forms,
  MetaDataConf.UI.ffwPrincipal in 'MetaDataConf.UI.ffwPrincipal.pas' {ffwPrincipal},
  MetaDataConf.UI.ffwForm in 'MetaDataConf.UI.ffwForm.pas' {ffwForm},
  MetaDataConf.UI.ffwConfigEntidade in 'MetaDataConf.UI.ffwConfigEntidade.pas' {ffwConfigEntidade},
  DataSet.Intf.MetaDataController in '..\FrameWork\MCFWComponentes\DataSet.Intf.MetaDataController.pas',
  DataSet.Impl.MetaDataController in '..\FrameWork\MCFWComponentes\DataSet.Impl.MetaDataController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TffwPrincipal, ffwPrincipal);
  Application.Run;
end.
