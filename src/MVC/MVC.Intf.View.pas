unit MVC.Intf.View;

interface

uses
  System.Classes, MVC.Intf.Controller;

type
  IView = Interface(IInterface)
    ['{F058C630-0436-4848-A9C3-ACC23FFF790A}']
    function GetComponent(AIndex: Integer): TComponent;
    function FindComponent(const AName: string): TComponent;
    procedure DefinirController(const AController: IController);
    property Components[Index: Integer]: TComponent read GetComponent;
    function ShowModal: Integer;
  end;

implementation

end.
