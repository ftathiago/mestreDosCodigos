program FrameWork;

uses
  Vcl.Forms,
  ufwPrincipal in 'ufwPrincipal.pas' {ffwPrincipal},
  ufwAplicacao in 'ufwAplicacao.pas',
  ufwForm in 'ufwForm.pas' {ffwForm},
  ufwConfigEntidade in 'ufwConfigEntidade.pas' {ffwConfigEntidade};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TffwPrincipal, ffwPrincipal);
  Application.Run;
end.
