unit MVC.Impl.View.FrameView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Data.DB,
  MVC.Intf.View, MVC.Intf.Controller, MVC.Intf.Conectavel, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrameView = class(TFrame, IView)
  private
    FController: IController;
  protected
    function Controller: IController; virtual;
  public
    procedure DefinirController(const AController: IController);
  end;

implementation

{$R *.dfm}

function TFrameView.Controller: IController;
begin
  result := FController;
end;

procedure TFrameView.DefinirController(const AController: IController);
begin
  FController := AController;
end;

end.
