unit ExecSQL.Controller.Intf.frmPesquisaSQL;

interface

uses
  MVC.Intf.Controller;

type
  IfrmPesquisaSQLController = Interface(IController)
    ['{4E7B53B5-BCFD-4FAC-B69A-C2B9C0F43BCD}']
    procedure MarcarTextoComErro(const Texto: string);
    procedure MarcarSelecaoComErro;
  end;

implementation

end.
