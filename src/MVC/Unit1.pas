unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, u.Intf.Controller.Teste;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses MVC.Intf.View, u.Impl.Controller.Teste, u.Impl.View.Teste;

procedure TForm1.Button1Click(Sender: TObject);
var
  _controller: IControllerTeste;
begin
  _controller := TControllerTeste.New;
  _controller.CriarForm(TViewTeste, Owner);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

end.
