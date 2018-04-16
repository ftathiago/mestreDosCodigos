program MetaDataConf;

uses
  Vcl.Forms,
  ufwPrincipal in 'ufwPrincipal.pas' {ffwPrincipal},
  ufwAplicacao in 'ufwAplicacao.pas',
  ufwForm in 'ufwForm.pas' {ffwForm},
  MetaDataConf.UI.ffwConfigEntidade in 'MetaDataConf.UI.ffwConfigEntidade.pas' {ffwConfigEntidade};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TffwPrincipal, ffwPrincipal);
  Application.Run;
end.
