unit MVC.Intf.Controller;

interface

uses
  System.Classes, System.Generics.Collections, VCL.Forms, MVC.Intf.Conectavel;

type
  IController = Interface(IConectavel)
    ['{E4603871-9FDD-460B-8B31-047F84A7E250}']
    procedure setView(const AView: TComponent);
    procedure AposCriarAView;
    procedure AoMostrar;
    procedure AoDestruirView;
  end;

implementation

end.
