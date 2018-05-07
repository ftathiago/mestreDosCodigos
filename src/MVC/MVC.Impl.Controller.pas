unit MVC.Impl.Controller;

interface

uses
  System.Generics.Collections, System.Classes, VCL.Forms, MVC.Intf.Controller, MVC.Intf.View;

type
  TController = class(TInterfacedObject, IController)
  private
    FView: IView;
  protected
    function View: IView;
    procedure AposViewCriada; virtual;
  public
    procedure CriarForm(const FormClass: TFormClass; const Owner: TComponent); virtual;
    class function New: IController; virtual;
  end;

implementation

procedure TController.AposViewCriada;
begin

end;

procedure TController.CriarForm(const FormClass: TFormClass; const Owner: TComponent);
begin
  FView := Nil;
  FView := FormClass.Create(Owner) as IView;
  FView.DefinirController(Self);

  AposViewCriada;

  FView.ShowModal;
end;

class function TController.New: IController;
begin
  result := Create;
end;

function TController.View: IView;
begin
  result := FView;
end;

initialization

end.
