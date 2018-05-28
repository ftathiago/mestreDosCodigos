unit MVC.Sample.FormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MVC.Intf.CDI, Vcl.ComCtrls, Vcl.ToolWin;

type
  TFormPrincipal = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FCDI: ICDI;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses
  MVC.Impl.CDI;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  FCDI := TCDI.New;
end;

procedure TFormPrincipal.ToolButton1Click(Sender: TObject);
begin
  FCDI.TratarRequisicaoMVC('TFormHelloWorld').Show;
end;

end.
