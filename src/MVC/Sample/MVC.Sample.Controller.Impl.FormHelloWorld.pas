unit MVC.Sample.Controller.Impl.FormHelloWorld;

interface

uses
  MVC.Anotacoes.View, MVC.Impl.Controller, MVC.Sample.Controller.Intf.FormHelloWorld, Vcl.Dialogs, Vcl.StdCtrls;

type

  [TView('TFormHelloWorld')]
  TFormHelloWorldController = class(TController, IFormHelloWorldController)
  private
    FlblOlaMundo: TLabel;
  protected
    function lblOlaMundo: TLabel;
    procedure AposCriarAView; override;
  public
    procedure ClicarBotao;
  end;

implementation

uses
  MVC.RegistroDeClasses;

procedure TFormHelloWorldController.AposCriarAView;
begin
  inherited;
  lblOlaMundo.Caption := 'Hello world do controller';
end;

procedure TFormHelloWorldController.ClicarBotao;
begin
  ShowMessage('Mensagem vinda do controller');
end;

function TFormHelloWorldController.lblOlaMundo: TLabel;
begin
  if not Assigned(FlblOlaMundo) then
    FlblOlaMundo := View.FindComponent('lblOlaMundo') as TLabel;
  result := FlblOlaMundo;
end;

initialization

RegistrarController(TFormHelloWorldController);

end.
