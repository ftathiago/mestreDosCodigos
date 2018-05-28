unit ExecSQL.Controller.Intf.frmListaObjetos;

interface

uses
  MVC.Intf.Controller;

type
  IfrmListaObjetosController = Interface(IController)
    ['{7A12C88F-26F1-4980-AAC6-643A5D9A6521}']
    procedure MostrarCamposDaTabela(const ANomeDaTabela: string);
    procedure LocalizarTabela(const ANomeTabela: string);
    procedure LocalizarCampo(const ANomeCampo: string);
    procedure LocalizarStoredProcedure(const ANomeSP: string);
    function LabelPadraoPesquisa: string;
  end;

implementation

end.
