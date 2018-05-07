unit MVC.Impl.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MVC.Intf.View, MVC.Intf.Controller;

type
  TFormView = class(TForm, IView)
  private
    { Private declarations }
    FController: IController;
  protected
    function Controller: IInterface;
  public
    { Public declarations }
    procedure DefinirController(const AController: IController);
  end;


implementation

{$R *.dfm}

{ TForm2<T> }

function TFormView.Controller: IInterface;
begin
  result := FController;
end;

procedure TFormView.DefinirController(const AController: IController);
begin
  FController := AController;
end;

end.
