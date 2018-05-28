unit ExecSQL.Controller.Intf.frmInicial;

interface

uses
  MVC.Intf.Controller, ExecSQL.Controller.Intf.frmListaObjetos;

type
  IfrmInicialController = Interface(IController)
    ['{7A12C88F-26F1-4980-AAC6-643A5D9A6521}']
    function frmListaObjetosController: IfrmListaObjetosController;
  end;

implementation

end.
