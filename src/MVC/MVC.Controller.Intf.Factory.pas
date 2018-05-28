unit MVC.Controller.Intf.Factory;

interface

uses
  System.Classes, MVC.Intf.Controller;

type
  IControllerFactory = Interface(IInterface)
    ['{524DB6D1-C8DA-45C7-8A13-0B9AD7897C0B}']
    function RetornarControleDaView(const AViewClassName: string): IController;
  end;

implementation

end.
