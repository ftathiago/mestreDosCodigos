unit MVC.Controller.Impl.Factory;

interface

uses
  System.Classes, MVC.Controller.Intf.Factory, MVC.Intf.Controller, MVC.Intf.LocalizadorController;

type
  TControllerFactory = class(TInterfacedObject, IControllerFactory)
  private
    FLocalizadorController: ILocalizadorController;
  public
    class function New: IControllerFactory;
    constructor Create;
    function RetornarControleDaView(const AViewClassName: string): IController;
  end;

implementation

uses MVC.RegistroDeClasses, MVC.Impl.LocalizadorController, MVC.Impl.Controller, MVC.Anotacoes.View, MVC.Exception;

class function TControllerFactory.New: IControllerFactory;
begin
  result := Create;
end;

constructor TControllerFactory.Create;
begin
  FLocalizadorController := TLocalizadorController.New(RetornarControllerLista);
end;

function TControllerFactory.RetornarControleDaView(const AViewClassName: string): IController;
var
  _controllerClass: TControllerClass;
begin
  _controllerClass := FLocalizadorController.Localizar(TViewAttribute, AViewClassName);
  if not Assigned(_controllerClass) then
    raise EMVCControllerNotFound.Create(AViewClassName);
  result := _controllerClass.New;
end;

end.
