unit MVC.Sample.View.FormHelloWorld;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MVC.Impl.View, MVC.Sample.Controller.Intf.FormHelloWorld;

type
  TFormHelloWorld = class(TFormView)
    lblOlaMundo: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  protected
    function Controller: IFormHelloWorldController; reintroduce;
  public
    { Public declarations }
  end;

var
  FormHelloWorld: TFormHelloWorld;

implementation

{$R *.dfm}

uses
  MVC.RegistroDeClasses;

procedure TFormHelloWorld.Button1Click(Sender: TObject);
begin
  Controller.ClicarBotao;
end;

function TFormHelloWorld.Controller: IFormHelloWorldController;
begin
  result := inherited Controller as IFormHelloWorldController;
end;

initialization

RegistrarView(TFormHelloWorld);

end.
