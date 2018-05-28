unit u.Impl.View.Teste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,MVC.Intf.View, MVC.Impl.View, u.intf.Controller.Teste;

type
  TViewTeste = class(TFormView)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  protected
    function Controller: IControllerTeste; reintroduce;
  private
    { Private declarations }
  public
    class function New(const AOwner: TComponent): IView;
  end;

var
  ViewTeste: TViewTeste;

implementation

{$R *.dfm}

procedure TViewTeste.Button1Click(Sender: TObject);
begin
  inherited;
  Self.Controller.MostrarHelloWorld();
end;

function TViewTeste.Controller: IControllerTeste;
begin
  result := inherited Controller as IControllerTeste;
end;

class function TViewTeste.New(const AOwner: TComponent): IView;
begin
  result := Create(AOwner);
end;

end.
