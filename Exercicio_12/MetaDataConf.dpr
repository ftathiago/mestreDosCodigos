program MetaDataConf;

uses
  Vcl.Forms,
  ufwPrincipal in 'ufwPrincipal.pas' {ffwPrincipal},
  ufwAplicacao in 'ufwAplicacao.pas',
  ufwForm in 'ufwForm.pas' {ffwForm},
  ufwConfigEntidade in 'ufwConfigEntidade.pas' {ffwConfigEntidade},
  DataSet.Intf.MetaDataController in '..\dpk\MCFWComponentes\DataSet.Intf.MetaDataController.pas',
  DataSet.Impl.MetaDataController in '..\dpk\MCFWComponentes\DataSet.Impl.MetaDataController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TffwPrincipal, ffwPrincipal);
  Application.Run;
end.
