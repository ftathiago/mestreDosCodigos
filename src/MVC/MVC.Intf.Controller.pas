unit MVC.Intf.Controller;

interface

uses
  System.Classes, System.Generics.Collections, VCL.Forms;

type
  IController = Interface(IInterface)
    procedure CriarForm(const FormClass: TFormClass; const Owner: TComponent);
  end;

implementation

end.
