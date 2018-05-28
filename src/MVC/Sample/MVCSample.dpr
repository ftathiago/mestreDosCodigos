program MVCSample;

uses
  Vcl.Forms,
  MVC.Sample.FormPrincipal in 'MVC.Sample.FormPrincipal.pas' {FormPrincipal},
  MVC.Sample.View.FormHelloWorld in 'MVC.Sample.View.FormHelloWorld.pas' {FormHelloWorld},
  MVC.Sample.Controller.Impl.FormHelloWorld in 'MVC.Sample.Controller.Impl.FormHelloWorld.pas',
  MVC.Sample.Controller.Intf.FormHelloWorld in 'MVC.Sample.Controller.Intf.FormHelloWorld.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
