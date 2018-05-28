unit u.Impl.Controller.Teste;

interface

uses
  System.Classes, VCL.Forms, VCL.Dialogs, MVC.Impl.Controller, u.Intf.Controller.Teste;

type
  TControllerTeste = class(TController, IControllerTeste)
  protected
    procedure AposViewCriada; override;
  public
    procedure MostrarHelloWorld;
    class function New: IControllerTeste;
  end;

implementation

uses
  VCL.StdCtrls;

{ TControllerTeste }

procedure TControllerTeste.AposViewCriada;
var
  _button: TButton;
begin
  inherited;
  _button := View.FindComponent('Button1') as TButton;
  _button.Caption := 'Do Controller';
end;

procedure TControllerTeste.MostrarHelloWorld;
begin
  ShowMessage('Hello world');
end;

class function TControllerTeste.New: IControllerTeste;
begin
  result := Create;
end;

end.
