unit MVC.Intf.ControlaExibicao;

interface

type
  IControlaExibicao = interface(IInterface)
    ['{C80B647D-DDC8-4DAE-9FC4-8E539C0A042A}']
    function PodeSerModal: boolean;
    function Visible: boolean;
    function ShowModal: integer;
    procedure Show;
    procedure Hide;
  end;

implementation

end.
